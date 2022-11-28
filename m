Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37F763B1CA
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 20:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiK1TDI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 28 Nov 2022 14:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiK1TDH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 14:03:07 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FE286C3
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:07 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASI101p012409
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:06 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m3fqts7qx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:06 -0800
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 11:03:05 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 5ED6110980335; Mon, 28 Nov 2022 11:02:52 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v5 0/6] execmem_alloc for BPF programs
Date:   Mon, 28 Nov 2022 11:02:39 -0800
Message-ID: <20221128190245.2337461-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TWH8iV4ukfMXot14MXKOdKRa5W60Lcmr
X-Proofpoint-GUID: TWH8iV4ukfMXot14MXKOdKRa5W60Lcmr
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset tries to address the following issues:

1. Direct map fragmentation

On x86, STRICT_*_RWX requires the direct map of any RO+X memory to be also
RO+X. These set_memory_* calls cause 1GB page table entries to be split
into 2MB and 4kB ones. This fragmentation in direct map results in bigger
and slower page table, and pressure for both instruction and data TLB.

Our previous work in bpf_prog_pack tries to address this issue from BPF
program side. Based on the experiments by Aaron Lu [4], bpf_prog_pack has
greatly reduced direct map fragmentation from BPF programs.

2. iTLB pressure from BPF program

Dynamic kernel text such as modules and BPF programs (even with current
bpf_prog_pack) use 4kB pages on x86, when the total size of modules and
BPF program is big, we can see visible performance drop caused by high
iTLB miss rate.

3. TLB shootdown for short-living BPF programs

Before bpf_prog_pack loading and unloading BPF programs requires global
TLB shootdown. This patchset (and bpf_prog_pack) replaces it with a local
TLB flush.

4. Reduce memory usage by BPF programs (in some cases)

Most BPF programs and various trampolines are small, and they often
occupies a whole page. From a random server in our fleet, 50% of the
loaded BPF programs are less than 500 byte in size, and 75% of them are
less than 2kB in size. Allowing these BPF programs to share 2MB pages
would yield some memory saving for systems with many BPF programs. For
systems with only small number of BPF programs, this patch may waste a
little memory by allocating one 2MB page, but using only part of it.

5. Introduce a unified API to allocate memory with special permissions.

This will help get rid of set_vm_flush_reset_perms calls from users of
vmalloc, module_alloc, etc.


Based on our experiments [5], we measured ~0.6% performance improvement
from bpf_prog_pack. This patchset further boosts the improvement to ~0.8%.
The difference is because bpf_prog_pack uses 512x 4kB pages instead of
1x 2MB page, bpf_prog_pack as-is doesn't resolve #2 above.

This patchset replaces bpf_prog_pack with a better API and makes it
available for other dynamic kernel text, such as modules, ftrace, kprobe.


This set enables bpf programs and bpf dispatchers to share huge pages with
new API:
  execmem_alloc()
  execmem_alloc()
  execmem_fill()

The idea is similar to Peter's suggestion in [1].

execmem_alloc() manages a set of PMD_SIZE RO+X memory, and allocates these
memory to its users. execmem_alloc() is used to free memory allocated by
execmem_alloc(). execmem_fill() is used to update memory allocated by
execmem_alloc().

Memory allocated by execmem_alloc() is RO+X, so this doesnot violate W^X.
The caller has to update the content with text_poke like mechanism.
Specifically, execmem_fill() is provided to update memory allocated by
execmem_alloc(). execmem_fill() also makes sure the update stays in the
boundary of one chunk allocated by execmem_alloc(). Please refer to patch
1/6 for more details of

Patch 4/6 uses these new APIs in bpf program and bpf dispatcher.

Patch 5/6and 6/6 allows static kernel text (_stext to _etext) to share
PMD_SIZE pages with dynamic kernel text on x86_64. This is achieved by
allocating PMD_SIZE pages to roundup(_etext, PMD_SIZE), and then use
_etext to roundup(_etext, PMD_SIZE) for dynamic kernel text.

[1] https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/
[2] RFC v1: https://lore.kernel.org/linux-mm/20220818224218.2399791-3-song@kernel.org/T/
[3] v1: https://lore.kernel.org/bpf/20221031222541.1773452-1-song@kernel.org/
[4] https://lore.kernel.org/bpf/Y2ioTodn+mBXdIqp@ziqianlu-desk2/
[5] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/

Changes v4 => v5:
1. Do not export execmem_* in normal build. (Christoph Hellwig)

Changes v3 => v4:
1. Fixed a bug found with test_vmalloc.

Changes v2 => v3:
1. Add selftests in 4/6. (Luis Chamberlain)
2. Add more motivation and test results. (Luis Chamberlain)
3. Fix error handling in execmem_alloc().

Changes PATCH v1 => v2:
1. Rename the APIs as execmem_* (Christoph Hellwig)
2. Add more information about the motivation of this work (and follow up
   works in for kernel modules, various trampolines, etc).
   (Luis Chamberlain, Rick Edgecombe, Mike Rapoport, Aaron Lu)
3. Include expermential results from previous bpf_prog_pack and the
   community. (Aaron Lu, Luis Chamberlain, Rick Edgecombe)

Changes RFC v2 => PATCH v1:
1. Add vcopy_exec(), which updates memory allocated by vmalloc_exec(). It
   also ensures vcopy_exec() is only used to update memory from one single
   vmalloc_exec() call. (Christoph Hellwig)
2. Add arch_vcopy_exec() and arch_invalidate_exec() as wrapper for the
   text_poke() like logic.
3. Drop changes for kernel modules and focus on BPF side changes.

Changes RFC v1 => RFC v2:
1. Major rewrite of the logic of vmalloc_exec and vfree_exec. They now
   work fine with BPF programs (patch 1, 2, 4). But module side (patch 3)
   still need some work.

Song Liu (6):
  vmalloc: introduce execmem_alloc, execmem_free, and execmem_fill
  x86/alternative: support execmem_alloc() and execmem_free()
  selftests/vm: extend test_vmalloc to test execmem_* APIs
  bpf: use execmem_alloc for bpf program and bpf dispatcher
  vmalloc: introduce register_text_tail_vm()
  x86: use register_text_tail_vm

 Documentation/x86/x86_64/mm.rst         |   4 +-
 arch/x86/include/asm/pgtable_64_types.h |   1 +
 arch/x86/kernel/alternative.c           |  12 +
 arch/x86/mm/init_64.c                   |   4 +-
 arch/x86/net/bpf_jit_comp.c             |  23 +-
 include/linux/bpf.h                     |   3 -
 include/linux/filter.h                  |   5 -
 include/linux/vmalloc.h                 |   9 +
 kernel/bpf/core.c                       | 180 +-----------
 kernel/bpf/dispatcher.c                 |  11 +-
 lib/test_vmalloc.c                      |  35 +++
 mm/nommu.c                              |  12 +
 mm/vmalloc.c                            | 367 ++++++++++++++++++++++++
 13 files changed, 462 insertions(+), 204 deletions(-)

--
2.30.2
