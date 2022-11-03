Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578AE618A29
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiKCVEk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiKCVEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:04:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E6C617D
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2BC16200E
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6270BC43143
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667509477;
        bh=KoiwtwxOFtywoer6DVhuuU206cSyG1Ct3vE1IS6mSso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uYjPI3z7hDgTTlt7jAOy1DqEHosYSvhZveN66J6m9u7fnVQfmTP4dD56OZJROqRqR
         EXc99gAU+tZzqGG97jUc0I0tU8PKvYkmVLYbaZqSnv/wOInTUqWtIVDYj/NZMnM8Wq
         lSOr6bIgeJ0B9veDA6sgke2ZfZZJP9zuFzHk0eWqE2iRoMaFY3MWaOp19xnRrQoRWv
         UF2bQt+XPQuMUYXfzhBeIJtbi44nDJVNK43CsUvMms7w1Dh40oTBugsXO90QE+KXTU
         a4BqCFyfqhzJHkozGpZ20Di9rYFNORijYMBdwj1lOecFN32+Tn2urwed3jjWjEptt9
         6kbkuuO97wZxw==
Received: by mail-ej1-f50.google.com with SMTP id b2so8604994eja.6
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 14:04:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf0pVSvKZNth0q6A+Eh0Os4xyJP5aNWb3BTjgAxLtxeyb7ZcA3vB
        V9l0qqUC6ZK/pu73YRoIooWCKQ6tkiBeJGFmTRc=
X-Google-Smtp-Source: AMsMyM59wJGWw6eOzYpikm1npeXtKo29IzgzLaFkJDqlnyhINxonsRZIQKUkKCmeqBin6mKBOkntrgYnezAlqMHUdi0=
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id
 nd15-20020a170907628f00b0072f58fc3815mr30385410ejc.719.1667509475620; Thu, 03
 Nov 2022 14:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221031222541.1773452-1-song@kernel.org> <20221031222541.1773452-6-song@kernel.org>
 <cc240325744f6b9237c433fb74aac28f34a3a8cf.camel@intel.com>
In-Reply-To: <cc240325744f6b9237c433fb74aac28f34a3a8cf.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 3 Nov 2022 14:04:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Q=Pyx_ATiGZ6QfXKMSxftNVCMRfqaaanzqOi91DCm9A@mail.gmail.com>
Message-ID: <CAPhsuW6Q=Pyx_ATiGZ6QfXKMSxftNVCMRfqaaanzqOi91DCm9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 RESEND 5/5] x86: use register_text_tail_vm
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 2, 2022 at 3:24 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2022-10-31 at 15:25 -0700, Song Liu wrote:
> > Allocate 2MB pages up to round_up(_etext, 2MB), and register memory
> > [round_up(_etext, 4kb), round_up(_etext, 2MB)] with
> > register_text_tail_vm
> > so that we can use this part of memory for dynamic kernel text (BPF
> > programs, etc.).
> >
> > Here is an example:
> >
> > [root@eth50-1 ~]# grep _etext /proc/kallsyms
> > ffffffff82202a08 T _etext
> >
> > [root@eth50-1 ~]# grep bpf_prog_ /proc/kallsyms  | tail -n 3
> > ffffffff8220f920 t
> > bpf_prog_cc61a5364ac11d93_handle__sched_wakeup       [bpf]
> > ffffffff8220fa28 t
> > bpf_prog_cc61a5364ac11d93_handle__sched_wakeup_new   [bpf]
> > ffffffff8220fad4 t
> > bpf_prog_3bf73fa16f5e3d92_handle__sched_switch       [bpf]
> >
> > [root@eth50-1 ~]#  grep 0xffffffff82200000
> > /sys/kernel/debug/page_tables/kernel
> > 0xffffffff82200000-
> > 0xffffffff82400000     2M     ro   PSE         x  pmd
> >
> > ffffffff82200000-ffffffff82400000 is a 2MB page, serving kernel text,
> > and
> > bpf programs.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  arch/x86/include/asm/pgtable_64_types.h | 1 +
> >  arch/x86/mm/init_64.c                   | 4 +++-
> >  include/linux/vmalloc.h                 | 4 ++++
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/pgtable_64_types.h
> > b/arch/x86/include/asm/pgtable_64_types.h
> > index 04f36063ad54..c0f9cceb109a 100644
> > --- a/arch/x86/include/asm/pgtable_64_types.h
> > +++ b/arch/x86/include/asm/pgtable_64_types.h
> > @@ -101,6 +101,7 @@ extern unsigned int ptrs_per_p4d;
> >  #define PUD_MASK     (~(PUD_SIZE - 1))
> >  #define PGDIR_SIZE   (_AC(1, UL) << PGDIR_SHIFT)
> >  #define PGDIR_MASK   (~(PGDIR_SIZE - 1))
> > +#define PMD_ALIGN(x) (((unsigned long)(x) + (PMD_SIZE - 1)) &
> > PMD_MASK)
> >
> >  /*
> >   * See Documentation/x86/x86_64/mm.rst for a description of the
> > memory map.
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index 3f040c6e5d13..5b42fc0c6099 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1373,7 +1373,7 @@ void mark_rodata_ro(void)
> >       unsigned long start = PFN_ALIGN(_text);
> >       unsigned long rodata_start = PFN_ALIGN(__start_rodata);
> >       unsigned long end = (unsigned long)__end_rodata_hpage_align;
> > -     unsigned long text_end = PFN_ALIGN(_etext);
> > +     unsigned long text_end = PMD_ALIGN(_etext);
> >       unsigned long rodata_end = PFN_ALIGN(__end_rodata);
> >       unsigned long all_end;
>
> Check out is_errata93(). Right now it assumes all text is between text-
> etext and MODULES_VADDR-MODULES_END. It's a quite old errata, but it
> would be nice if we had a is_text_addr() helper or something. To help
> keep track of the places where text might pop up.
>
> Speaking of which, it might be nice to update
> Documentation/x86/x86_64/mm.rst with some hints that this area exists.
>
> >
> > @@ -1414,6 +1414,8 @@ void mark_rodata_ro(void)
> >                               (void *)rodata_end, (void *)_sdata);
> >
> >       debug_checkwx();
> > +     register_text_tail_vm(PFN_ALIGN((unsigned long)_etext),
> > +                           PMD_ALIGN((unsigned long)_etext));
> >  }
> >
> >  int kern_addr_valid(unsigned long addr)
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 9b2042313c12..7365cf9c4e7f 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -132,11 +132,15 @@ extern void vm_unmap_aliases(void);
> >  #ifdef CONFIG_MMU
> >  extern void __init vmalloc_init(void);
> >  extern unsigned long vmalloc_nr_pages(void);
> > +void register_text_tail_vm(unsigned long start, unsigned long end);
> >  #else
> >  static inline void vmalloc_init(void)
> >  {
> >  }
> >  static inline unsigned long vmalloc_nr_pages(void) { return 0; }
> > +void register_text_tail_vm(unsigned long start, unsigned long end)
> > +{
> > +}
> >  #endif
>
> This looks like it should be in the previous patch.

Good catch! I will fix it in the next version.

Thanks,
Song

>
> >
> >  extern void *vmalloc(unsigned long size) __alloc_size(1);
