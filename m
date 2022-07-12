Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E226572A0C
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 01:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiGLXm5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 19:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGLXm4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 19:42:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45166BE0C5;
        Tue, 12 Jul 2022 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1GUN/YtQA9mT9gQIEhu74W6F99Ud11donCnvyusM+y4=; b=AA3VHE8HlUUwnmiz6EYWtMtgKZ
        B5fsBfh4Deq0dN5C3zDOUcvPcWF7JAdYMJ7xh9T5yVwkfrf/1GDjk0kqGNqsLfEteJHlaPdUwbwAF
        M9m0+W5Bq16vK+yHal0yjZVZTaCKclQDtEfDqfr/DvNVTG78g82a2cLeSLWYpO3EFYpMVgGvWUrA+
        4Gj4rolRr9XoB/8mkBKfXTL6YdouEBpPMUsT4P/dl1Pyt1wINgElDzfMzmEatGqVsjVTeL+p738fH
        Ii8Bd5fij2do+8BHaEHlSYqfO6ylr/DfJMTHqNawS6T4045IZOixTmrlgsqXkiGIpNfC0oZA2KIpr
        yl10XtLw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBPWN-00FpAm-SH; Tue, 12 Jul 2022 23:42:27 +0000
Date:   Tue, 12 Jul 2022 16:42:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Message-ID: <Ys4G4/dG6SGYV/iz@bombadil.infradead.org>
References: <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
 <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
 <YsiupnNJ8WANZiIc@bombadil.infradead.org>
 <6214B9C9-557B-4DC0-BFDE-77EAC425E577@fb.com>
 <Ysz2LX3q2OsaO4gM@bombadil.infradead.org>
 <E23B6EB1-AFFA-4B65-963E-B44BA0F2142D@fb.com>
 <Ys3FvYnASr2v9iPc@bombadil.infradead.org>
 <6CB56563-29E2-4CE0-BF7B-360979E42429@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CB56563-29E2-4CE0-BF7B-360979E42429@fb.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 11:12:22PM +0000, Song Liu wrote:
> 
> 
> > On Jul 12, 2022, at 12:04 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> > 
> > On Tue, Jul 12, 2022 at 05:49:32AM +0000, Song Liu wrote:
> >>> On Jul 11, 2022, at 9:18 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> >> 
> >>> I believe you are mentioning requiring text_poke() because the way
> >>> eBPF code uses the module_alloc() is different. Correct me if I'm
> >>> wrong, but from what I gather is you use the text_poke_copy() as the data
> >>> is already RO+X, contrary module_alloc() use cases. You do this since your
> >>> bpf_prog_pack_alloc() calls set_memory_ro() and set_memory_x() after
> >>> module_alloc() and before you can use this memory. This is a different type
> >>> of allocator. And, again please correct me if I'm wrong but now you want to
> >>> share *one* 2 MiB huge-page for multiple BPF programs to help with the
> >>> impact of TLB misses.
> >> 
> >> Yes, sharing 1x 2MiB huge page is the main reason to require text_poke. 
> >> OTOH, 2MiB huge pages without sharing is not really useful. Both kprobe
> >> and ftrace only uses a fraction of a 4kB page. Most BPF programs and 
> >> modules cannot use 2MiB either. Therefore, vmalloc_rw_exec() doesn't add
> >> much value on top of current module_alloc(). 
> > 
> > Thanks for the clarification.
> > 
> >>> A vmalloc_ro_exec() by definition would imply a text_poke().
> >>> 
> >>> Can kprobes, ftrace and modules use it too? It would be nice
> >>> so to not have to deal with the loose semantics on the user to
> >>> have to use set_vm_flush_reset_perms() on ro+x later, but
> >>> I think this can be addressed separately on a case by case basis.
> >> 
> >> I am pretty confident that kprobe and ftrace can share huge pages with 
> >> BPF programs.
> > 
> > Then wonderful, we know where to go in terms of a new API then as it
> > can be shared in the future for sure and there are gains.
> > 
> >> I haven't looked into all the details with modules, but 
> >> given CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, I think it is also 
> >> possible.
> > 
> > Sure.
> > 
> >> Once this is done, a regular system (without huge BPF program or huge
> >> modules) will just use 1x 2MB page for text from module, ftrace, kprobe, 
> >> and bpf programs. 
> > 
> > That would be nice, if possible, however modules will require likely its
> > own thing, on my system I see about 57 MiB used on coresize alone.
> > 
> > lsmod | grep -v Module | cut -f1 -d ' ' | \
> > 	xargs sudo modinfo | grep filename | \
> > 	grep -o '/.*' | xargs stat -c "%s - %n" | \
> > 	awk 'BEGIN {sum=0} {sum+=$1} END {print sum}'
> > 60001272
> > 
> > And so perhaps we need such a pool size to be configurable.
> > 
> >>> But a vmalloc_ro_exec() with a respective free can remove the
> >>> requirement to do set_vm_flush_reset_perms().
> >> 
> >> Removing the requirement to set_vm_flush_reset_perms() is the other
> >> reason to go directly to vmalloc_ro_exec(). 
> > 
> > Yes fantastic.
> > 
> >> My current version looks like this:
> >> 
> >> void *vmalloc_exec(unsigned long size);
> >> void vfree_exec(void *ptr, unsigned int size);
> >> 
> >> ro is eliminated as there is no rw version of the API. 
> > 
> > Alright.
> > 
> > I am not sure if 2 MiB will suffice given what I mentioned above, and
> > what to do to ensure this grows at a reasonable pace. Then, at least for
> > usage for all architectures since not all will support text_poke() we
> > will want to consider a way to make it easy to users to use non huge
> > page fallbacks, but that would be up to those users, so we can wait for
> > that.
> 
> We are not limited to 2MiB total. The logic is like: 
> 
> 1. Anything bigger than 2MiB gets its own allocation.

And does that allocation get split up into a few huge 2 MiB pages?
When freed does that go into the pool of available list of 2 MiB pages
to use?

> 2. We maintain a list of 2MiB pages, and bitmaps showing which parts of 
>    these pages are in use. 

How many 2 MiB huge pages are allocated initially? Do we have a cap?

> 3. For objects smaller than 2MiB, we will try to fit it in one of these
>    pages. 
>    3. a) If there isn't a page with big enough continuous free space, we
>         will allocate a new 2MiB page. 
> 
> (For system with n NUMA nodes, multiple 2MiB above by n). 
> 
> So, if we have 100 kernel modules using 1MiB each, they will share 50x
> 2MiB pages. 

lsmod | grep -v Module | cut -f1 -d ' ' | \
	xargs sudo modinfo | grep filename |\
	grep -o '/.*' | xargs stat -c "%s - %n" | \
	awk 'BEGIN {sum=0} {sum+=$1} END {print sum/NR/1024}' 
271.273

On average my system's modules are 271 KiB.

Then I only have 6 out of 216 modules which are use more than 2 MiB or
memory for coresize. So roughly 97% of my modules would be covered
with this. Not bad.

The monsters:

lsmod | grep -v Module | cut -f1 -d ' ' | xargs sudo modinfo \
	| grep filename |grep -o '/.*' | xargs stat -c "%s %n" | \
	sort -n -k 1 -r | head -10 | \
	awk '{print $1/1024/1024" "$2}'
6.50775 /lib/modules/5.17.0-1-amd64/kernel/drivers/gpu/drm/i915/i915.ko
3.6847 /lib/modules/5.17.0-1-amd64/kernel/fs/xfs/xfs.ko
3.34252 /lib/modules/5.17.0-1-amd64/kernel/fs/btrfs/btrfs.ko
2.37677 /lib/modules/5.17.0-1-amd64/kernel/net/mac80211/mac80211.ko
2.2972 /lib/modules/5.17.0-1-amd64/kernel/net/wireless/cfg80211.ko
2.05754 /lib/modules/5.17.0-1-amd64/kernel/arch/x86/kvm/kvm.ko
1.96126 /lib/modules/5.17.0-1-amd64/kernel/net/bluetooth/bluetooth.ko
1.83429 /lib/modules/5.17.0-1-amd64/kernel/fs/ext4/ext4.ko
1.7724 /lib/modules/5.17.0-1-amd64/kernel/fs/nfsd/nfsd.ko
1.60539 /lib/modules/5.17.0-1-amd64/kernel/net/sunrpc/sunrpc.ko

On a big iron server I have 149 modules and the situation is better
there:

3.69791 /lib/modules/5.16.0-6-amd64/kernel/fs/xfs/xfs.ko
3.35575 /lib/modules/5.16.0-6-amd64/kernel/fs/btrfs/btrfs.ko
3.21056 /lib/modules/5.16.0-6-amd64/kernel/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko
2.02773 /lib/modules/5.16.0-6-amd64/kernel/arch/x86/kvm/kvm.ko
1.82574 /lib/modules/5.16.0-6-amd64/kernel/fs/ext4/ext4.ko
1.36571 /lib/modules/5.16.0-6-amd64/kernel/net/sunrpc/sunrpc.ko
1.32686 /lib/modules/5.16.0-6-amd64/kernel/fs/nfsd/nfsd.ko
1.12648 /lib/modules/5.16.0-6-amd64/kernel/drivers/gpu/drm/drm.ko
0.898623 /lib/modules/5.16.0-6-amd64/kernel/drivers/infiniband/hw/mlx5/mlx5_ib.ko
0.86922 /lib/modules/5.16.0-6-amd64/kernel/drivers/infiniband/core/ib_core.ko

So this may just work nicely.

  Luis
