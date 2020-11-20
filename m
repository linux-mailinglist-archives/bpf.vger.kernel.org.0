Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC92BB6DC
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgKTUaC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:10342 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730856AbgKTUaC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:02 -0500
IronPort-SDR: yfiuLft2BH3yRBY0LYU3TRPBetlioIUZLdRIuXH8kYmF/+raMQxQlWvLaqDC3NZMonuicNhoto
 Ld6ngUsNRFDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683268"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:00 -0800
IronPort-SDR: sTXiclG0+qdIk49kdKuFdIvhfYsyJ4n3iFnlThGvcFItygRQ78Q3TqB7Lf0riCkExkoWxuZ/xF
 fllhfo/4/+zg==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163265"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:00 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 00/10] New permission vmalloc interface
Date:   Fri, 20 Nov 2020 12:24:16 -0800
Message-Id: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a proposal to address some inefficiencies in how memory permissions
are handled on vmalloc mappings. The way the interfaces are defined across
vmalloc and cpa make it hard to fully address problems underneath the
existing interfaces. So this creates a new interface in vmalloc that
encapsulates what vmalloc memory permission usages need, but with more
details handled on the back end. This allows for optimizations and shared caches
of resources. The genesis for this was this conversation[0] and many of the
ideas were suggested by Andy Lutomirski. In its current state it takes module
load's down to usually one kernel range shootdown, and BPF JIT load's down to
usually zero on x86. It also minimizes the direct map 4k breakage when possible.

For the future, x86 also has new kernel memory permission types that would
benefit from efficiently handling the direct map permissions/unmapping, for
example [1]. However, this patchset is just targeting improving performance
inefficiencies with existing usages in modules and normal eBPF JITs.

The code is early and very lightly tested. I was hoping to get some feedback on
the approach.

The Problem
===========

For a little background, the way executable code is loaded (modules, BPF
JITs, etc) on x86 goes something like this:

ptr = vmalloc_node_range(, PAGE_KERNEL)
   alloc_page() - Get random pages from page allocator
   map_kernel_range() - Map vmalloc range allocation as RW to those pages

set_memory_ro(ptr)
   set vmalloc alias to RO, break direct map aliases to 4k/RO, all-cpu shootdown
   vm_unmap_alias() flush any lazy RW aliases to now RO pages, all-cpu shootdown

set_memory_x(ptr)
   set vmalloc alias to not-NX, all-cpu shootdown
   vm_unmap_alias(), possible all-cpu shootdown

So during this load operation, 4 shootdowns may take place and the direct map
will be broken to 4k pages across whichever random pages got used in the
executable region. When a split is required it can be even more. Besides the
direct map, the other reason for this is having to change the permission of the
vmalloc mapping several times in order to load it while it's writable, and then
transition it to its final permission.

Ideally we would unmap pages from the direct map in bulk to share a shootdown.
For changing the vmalloc mappings permission, we should instead map it at its
final permission from the start and use a temporary per-cpu mapping such as
text_poke() to load the data such that it only requires a local TLB flush.

For large page breakage on the direct map, if multiple JITs happen to get
pages from the same 2MB physical region this can limit the damage to a
smaller region. However, currently this depends on lucky physical distance of
the pages picked inside vmalloc. Today it seems more likely to happen if
allocations are made close together in time. Ideally we would make an effort
to group pages used for permissioned vmallocs together physically so the
direct map breakage would be minimized.

But trying to improve this doesn't fit into the existing interfaces very well.

 - vmalloc_node_range() doesn't know what it's final permission will be.

 - There isn't any cross-arch way to describe to vmalloc what the permissions
will be, since permissions are encoded into the name of the set_memory_foo()
functions.

 - text_poke() only exists on x86, and other HW ways of temporarily writing to
RO mappings don't necessarily have standardized semantics.

Proposed solution
=================

For text or RO allocations, to oversimplify, what usages want to do is just
say:

1. Give me a kva for this particular permission and size
2. Load this data into it
3. Make it "live" (no writable mapping, no direct map mapping, whatever
permissions are set on it and ready to go)

So this implements a new interface to do just that. I had in mind this
interface should try to support the following optimizations on x86 even if
they weren't implemented right away.

1. Draw from 2MB physical pages that can be unmapped from the direct map in
contiguous chunks

In memory pressure situations a shrinker callback can free unused pages
from the cache. These can get re-mapped on the fly without any flush since the
direct map would be transitioning NP->RW. Since we can re-map the direct map
cheaply, it's better to unmap more than we need. This part is close to
secretmem[2] in implementation, and should possibly share infrastructure or
caches of unmapped pages.

2. Load text/special data via per-cpu mappings

The mapping can be mapped in its "final" permission, and loaded via text_poke().
This will reduce shootdowns during loads to zero is most cases. Just local
flushes. The new interface provides a writable buffer for usages to stage their
changes, and trigger the copying into the RO mapping via text_poke()

3. Caching of virtual mappings as well as pages

Normally executable mappings need to be zapped and flushed before the pages
return to the page allocator to prevent random other memory that uses the
page later from having an executable alias. But we could cache these live
mappings and delay the flush until the page is needed for an allocation of a
larger size or different permission. The "free" operations could just zero it
with a per-cpu mapping to prevent unwanted text from remaining mapped.

4. 2MB module space mappings

It would be nice if the virtual mappings of the same permission types could
be placed next to each other so that they could share 2MB mappings. This way we
could have modules or PKS memory have 2MB pages. Of course allocating from a
2MB block could cause internal fragmentation and wasted memory, however it
might be possible to break the virtual mapping later and allow the wasted
memory to be unmapped and freed in the formerly 2MB page. Often a bunch of
modules are loaded at boot. If we placed the long lived "core sections" of
these modules sequentially into the 2MB blocks, there is probably a good chance
we could get some decent utilization out of one.


This RFC just has 1 and 2 actually implemented on x86.

Module loader changes
=====================

Of the text allocation usages, kernel modules are the most complex because a
single vmalloc allocation has many memory permissions across it (RO+X for the
text, RO, RO after init, and RW). In addition to this preventing having module
text mapped in 2MB pages since the text is all scattered around in different
allocations, it would require more complexity for the new interface.

However, at least for x86, it doesn't seem like there is any requirement for
a module allocation to be virtually contiguous. Instead we could have the
module loader treat each of its 4 permission regions as separate allocations.
Then the new interface could be simpler and it could have the option of putting
similar permission allocations next to each other to achieve 2MB pages or more
opportunities to reuse existing mappings.

The challenge in changing this in the module loader is that most of it is
cross-arch code and there could be relocation rules required by various
arch's that depend on the existing virtual address distances. To try to
transition to this interface without disturbing anything, the default
module.c behavior is to layout the modules as they were before in both
location and permissions, but wrapped separately as multiple instances of the
new type of allocation. This way it could have no functional change for other
architectures at first, but allow any to implement similar optimizations in the
arch module.c breakouts. So this RFC also looks at handling things as separate
allocations, and actually allocates them separately for x86.

Of course, there are several areas outside of modules that are involved in
modifying the module text and data such as alternatives, orc unwinding, etc.
These components are changed to be aware they may need to opearate on the
writable staging area buffer.

[0] https://lore.kernel.org/lkml/CALCETrV_tGk=B3Hw0h9viW45wMqB_W+rwWzx6LnC3-vSATOUOA@mail.gmail.com/
[1] https://lore.kernel.org/lkml/20201009201410.3209180-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/lkml/20200924132904.1391-1-rppt@kernel.org/

This RFC has been acked by Dave Hansen.

Rick Edgecombe (10):
  vmalloc: Add basic perm alloc implementation
  bpf: Use perm_alloc() for BPF JIT filters
  module: Use perm_alloc() for modules
  module: Support separate writable allocation
  x86/modules: Use real perm_allocations
  x86/alternatives: Handle perm_allocs for modules
  x86/unwind: Unwind orc at module writable address
  jump_label: Handle module writable address
  ftrace: Use module writable address
  vmalloc: Add perm_alloc x86 implementation

 arch/Kconfig                      |   3 +
 arch/arm/net/bpf_jit_32.c         |   3 +-
 arch/arm64/net/bpf_jit_comp.c     |   5 +-
 arch/mips/net/bpf_jit.c           |   2 +-
 arch/mips/net/ebpf_jit.c          |   3 +-
 arch/powerpc/net/bpf_jit_comp.c   |   2 +-
 arch/powerpc/net/bpf_jit_comp64.c |  10 +-
 arch/s390/net/bpf_jit_comp.c      |   5 +-
 arch/sparc/net/bpf_jit_comp_32.c  |   2 +-
 arch/sparc/net/bpf_jit_comp_64.c  |   5 +-
 arch/x86/Kconfig                  |   1 +
 arch/x86/include/asm/set_memory.h |   2 +
 arch/x86/kernel/alternative.c     |  25 +-
 arch/x86/kernel/jump_label.c      |  18 +-
 arch/x86/kernel/module.c          |  84 ++++-
 arch/x86/kernel/unwind_orc.c      |   8 +-
 arch/x86/mm/Makefile              |   1 +
 arch/x86/mm/pat/set_memory.c      |  13 +
 arch/x86/mm/vmalloc.c             | 438 +++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c       |  15 +-
 arch/x86/net/bpf_jit_comp32.c     |   3 +-
 include/linux/filter.h            |  30 +-
 include/linux/module.h            |  66 +++-
 include/linux/vmalloc.h           |  82 +++++
 kernel/bpf/core.c                 |  48 ++-
 kernel/jump_label.c               |   2 +-
 kernel/module.c                   | 561 ++++++++++++++++++------------
 kernel/trace/ftrace.c             |   2 +-
 mm/nommu.c                        |  66 ++++
 mm/vmalloc.c                      | 135 +++++++
 30 files changed, 1308 insertions(+), 332 deletions(-)
 create mode 100644 arch/x86/mm/vmalloc.c

-- 
2.20.1

