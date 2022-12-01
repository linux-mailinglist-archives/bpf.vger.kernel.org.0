Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD38D63F910
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 21:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiLAUXg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 15:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiLAUXe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 15:23:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8108567A
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 12:23:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 368946211A
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 20:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA9C433D6;
        Thu,  1 Dec 2022 20:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669926212;
        bh=JLbZ6up/9E6WAJSAbM7WyLhAqYygiyaeytFXLHrqY2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdpIXlEdOePC3sLVtcjPcergkM188bT8YbiOGIEyMUYBAkQTCD3cSoFlErRQHeJrL
         qUHGQ/3KZ+nUh/+hW6avNnAWwHC6MPYDzOwU7PDJpto6VpEoCuGIT2O354YmaXMQYM
         aadGg4eiCQalJaVnHISOBRiUhP97huYaBYvME79oZCLjKv0gZbj+dCBfOkEPbOc/4M
         r8fnXnjligrj/XQBTfoDzfzFn/O5+rcYTmD+Uv/afdtH6IQMBJEjAwYOZ6lJGJxZgE
         dxdQTFF2YmD+gap8bXUg94+edV7jD6XiCzqH8N8EtYwjPy4CkAS66t4lw3ygaEnMkP
         9VxsWeoELvBKg==
Date:   Thu, 1 Dec 2022 22:23:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y4kNMpRgvEN2KrkD@kernel.org>
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8mvsd8d.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 01, 2022 at 10:08:18AM +0100, Thomas Gleixner wrote:
> Song!
> 
> On Wed, Nov 30 2022 at 08:18, Song Liu wrote:
> > On Tue, Nov 29, 2022 at 3:56 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> You are not making anything easier. You are violating the basic
> >> engineering principle of "Fix the root cause, not the symptom".
> >>
> >
> > I am not sure what is the root cause and the symptom here.
> 
> The symptom is iTLB pressure. The root cause is the way how module
> memory is allocated, which in turn causes the fragmentation into
> 4k PTEs. That's the same problem for anything which uses module_alloc()
> to get space for text allocated, e.g. kprobes, tracing....

There's also dTLB pressure caused by the fragmentation of the direct map.
The memory allocated with module_alloc() is a priori mapped with 4k PTEs,
but setting RO in the malloc address space also updates the direct map
alias and this causes splits of large pages.

It's not clear what causes more performance improvement: avoiding splits of
large pages in the direct map or reducing iTLB pressure by backing text
memory with 2M pages. If the major improvement comes from keeping direct
map intact, it's might be possible to mix data and text in the same 2M
page.
 
> A module consists of:
> 
>   - text sections
>   - data sections
> 
> Except for PPC32, which has the module data in vmalloc space, all others
> allocate text and data sections in one lump.
> 
> This en-bloc allocation is one reason for the 4k splits:
> 
>    - text is RX
>    - data is RW or RO
> 
> Truly vmalloc'ed module data is not an option for 64bit architectures
> which use PC relative addressing as vmalloc does not guarantee that the
> data ends up within the limited displacement range (s32 on x8664)
> 
> This made me look at your allocator again:
> 
> > +#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
> > +#define EXEC_MEM_START MODULES_VADDR
> > +#define EXEC_MEM_END MODULES_END
> > +#else
> > +#define EXEC_MEM_START VMALLOC_START
> > +#define EXEC_MEM_END VMALLOC_END
> > +#endif
> 
> The #else part is completely broken on x86/64 and any other
> architecture, which has PC relative restricted displacement.
> 
> Even if modules are disabled in Kconfig the only safe place to allocate
> executable kernel text from (on these architectures) is the modules
> address space. The ISA restrictions do not go magically away when
> modules are disabled.
> 
> In the early version of the SKX retbleed mitigation work I had
> 
>   https://lore.kernel.org/all/20220716230953.442937066@linutronix.de
> 
> exactly to handle this correctly for the !MODULE case. It went nowhere
> as we did not need the trampolines in the final version.
> 
> This is why Peter suggested to 'split' the module address range into a
> top down and bottom up part:
> 
>   https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/
>   
> That obviously separates text and data, but keeps everything within the
> defined working range.
> 
> It immediately solves the text problem for _all_ module_alloc() users
> and still leaves the data split into 4k pages due to RO/RW sections.
> 
> But after staring at it for a while I think this top down and bottom up
> dance is too much effort for not much gain. The module address space is
> sized generously, so the straight forward solution is to split that
> space into two blocks and use them to allocate text and data separately.
> 
> The rest of Peter's suggestions how to migrate there still apply.
> 
> The init sections of a module are obviously separate as they are freed
> after the module is initialized, but they are not really special either.
> Today they leave holes in the address range. With the new scheme these
> holes will be in the memory backed large mapping, but I don't see a real
> issue with that, especially as those holes at least in text can be
> reused for small allocations (kprobes, trace, bpf).
> 
> As a logical next step we make that three blocks and allocate text,
> data and rodata separately, which will preserve the large mappings for
> text and data. rodata still needs to be split because we need a space to
> accomodate ro_after_init data.
> 
> Alternatively, instead of splitting the module address space, the
> allocation mechanism can keep track of the types (text, data, rodata)
> and manage large mapping blocks per type. There are pros and cons for
> both approaches, so that needs some thought.
> 
> But at the end we want an allocation mechanism which:
> 
>   - preserves large mappings
>   - handles a distinct address range
>   - is mapping type aware
> 
> That solves _all_ the issues of modules, kprobes, tracing, bpf in one
> go. See?

There is also

    - handles kaslr

and at least for arm and powerpc we'd also need 

    - handles architecture specific range restrictions and fallbacks
 
> Thanks,
> 
>         tglx

-- 
Sincerely yours,
Mike.
