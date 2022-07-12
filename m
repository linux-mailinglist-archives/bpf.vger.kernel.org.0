Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD8257112B
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 06:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiGLETc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 00:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiGLET1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 00:19:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA389DFB0;
        Mon, 11 Jul 2022 21:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SerALkoKkILFqR40xrtVLu7qCXWoTY5YVNTXw341g5M=; b=JkhW4IaWbotUT+4T1nlgzM0/mi
        3J3G0B15QqJw92tXicvjFX6bv3jehp952EXaLwVjeebCGVdpLpConV5X701ky4yIA7uumUmU5Qojp
        Wozqu6yfxwiAWzMq8k1OlYJ7cvJZgEJ0EfXTGYguP0AWJfaM4TIAx0jNv7t7NJ+oWvMP1HgGuPpo0
        DOpDBd1oyAAMtm/1XazxcAluYMFd0RAabjzuruTfRmH1HHTpN6OO8nSM+qLQ4Oiul40pqW6NFlDvF
        Y8YkaXgIRV96VHMeNj8TeJq075TJrolZCBNb39XVqmf12EDm4CVIP5fTg+Ly4Bu+q4I1fX9FknKNH
        q9/k/bjw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB7ML-007GZm-C7; Tue, 12 Jul 2022 04:18:53 +0000
Date:   Mon, 11 Jul 2022 21:18:53 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <Ysz2LX3q2OsaO4gM@bombadil.infradead.org>
References: <20220707223546.4124919-1-song@kernel.org>
 <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
 <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
 <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
 <YsiupnNJ8WANZiIc@bombadil.infradead.org>
 <6214B9C9-557B-4DC0-BFDE-77EAC425E577@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6214B9C9-557B-4DC0-BFDE-77EAC425E577@fb.com>
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

On Sat, Jul 09, 2022 at 01:14:23AM +0000, Song Liu wrote:
> > On Jul 8, 2022, at 3:24 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> > 
> >> 1) Rename module_alloc_huge as module_alloc_text_huge();
> > 
> > module_alloc_text_huge() is too long, but I've suggested names before
> > which are short and generic, and also suggested that if modules are
> > not the only users this needs to go outside of modules and so
> > vmalloc_text_huge() or whatever.
> > 
> > To do this right it begs the question why we don't do that for the
> > existing module_alloc(), as the users of this code is well outside of
> > modules now. Last time a similar generic name was used all the special
> > arch stuff was left to be done by the module code still, but still
> > non-modules were still using that allocator. From my perspective the
> > right thing to do is to deal with all the arch stuff as well in the
> > generic handler, and have the module code *and* the other users which
> > use module_alloc() to use that new caller as well.
> 
> The key difference between module_alloc() and the new API is that the 
> API will return RO+X memory, and the user need text-poke like API to
> modify this buffer. Archs that do not support text-poke will not be
> able to use the new API. Does this sound like a reasonable design?

I'm adding kprobe + ftrace folks.

I can't see why we need to *require* text_poke for just a
module_alloc_huge(). Enhancements on module_alloc() are just
enhancements, not requirements. So we have these for instance:

``` from arch/Kconfig
config ARCH_OPTIONAL_KERNEL_RWX
	def_bool n

config ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
	def_bool n

config ARCH_HAS_STRICT_KERNEL_RWX
	def_bool n

config STRICT_KERNEL_RWX
	bool "Make kernel text and rodata read-only" if ARCH_OPTIONAL_KERNEL_RWX
	depends on ARCH_HAS_STRICT_KERNEL_RWX
	default !ARCH_OPTIONAL_KERNEL_RWX || ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
	help
	  If this is set, kernel text and rodata memory will be made read-only,
	  and non-text memory will be made non-executable. This provides
	  protection against certain security exploits (e.g. executing the heap
	  or modifying text)

	  These features are considered standard security practice these days.
	  You should say Y here in almost all cases.

config ARCH_HAS_STRICT_MODULE_RWX
	def_bool n

config STRICT_MODULE_RWX
	bool "Set loadable kernel module data as NX and text as RO" if ARCH_OPTIONAL_KERNEL_RWX
	depends on ARCH_HAS_STRICT_MODULE_RWX && MODULES
	default !ARCH_OPTIONAL_KERNEL_RWX || ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
	help
	  If this is set, module text and rodata memory will be made read-only,
	  and non-text memory will be made non-executable. This provides
	  protection against certain security exploits (e.g. writing to text)
```

With module_alloc() we have the above symbols to tell us when we *can*
support strict module rwx. So the way the kernel's modules are allocated
and used is:

for each module section:
	module_alloc()
module_enable_ro()
module_enable_nx()
module_enable_x()

The above can be read in the code as:

load_module() -->
	layout_and_allocate()
	complete_formation()

Then there is the consideration of set_vm_flush_reset_perms() for
freeing. On the module code we use this fore the RO+X stuff (core_layout,
init_layout), but now that is a bit obfuscated due to the placement of
the call. It would seem the other users use it for the same:

 * ebpf
 * kprobes
 * ftrace

I believe you are mentioning requiring text_poke() because the way
eBPF code uses the module_alloc() is different. Correct me if I'm
wrong, but from what I gather is you use the text_poke_copy() as the data
is already RO+X, contrary module_alloc() use cases. You do this since your
bpf_prog_pack_alloc() calls set_memory_ro() and set_memory_x() after
module_alloc() and before you can use this memory. This is a different type
of allocator. And, again please correct me if I'm wrong but now you want to
share *one* 2 MiB huge-page for multiple BPF programs to help with the
impact of TLB misses.

A vmalloc_ro_exec() by definition would imply a text_poke().

Can kprobes, ftrace and modules use it too? It would be nice
so to not have to deal with the loose semantics on the user to
have to use set_vm_flush_reset_perms() on ro+x later, but
I think this can be addressed separately on a case by case basis.

But a vmalloc_ro_exec() with a respective free can remove the
requirement to do set_vm_flush_reset_perms().

  Luis
