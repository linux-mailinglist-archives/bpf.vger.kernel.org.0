Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45FB6461B4
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLGT1N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 14:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLGT1M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 14:27:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3691F663CE
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 11:27:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE2A661BDD
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 19:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B81BC43146
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 19:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670441231;
        bh=5FkmKMcgD621lYtSY9QcdA9W2/ZLeGsK+iiW5+lfbKk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dUGdL7xnr5ubERiyhjNyzE40gYFVdDe741GFRufq4sPsTHLmB7na1t0ZX0wp/kQI0
         fQyOslMGHy1nNVqFp8vxejmO38urzA+hrxMBnPdOSzjxnFA7xQovojkLjJqTgEPruw
         T202vzwpe7D/E1zL9iVMMi2oGEqKtpqFB8IpUS05IPxQ7qXB+HLe89jOK60pxIs6Q/
         V4k+Ruz94wqP8paAzNtV+x1AhuEMtDHowQ5JMOSmsXwRkP76+tgrBvqNe3YDHliBHx
         DdeJQlLod08CMdNt7eQSz2yLl1XIn69REzXnI//a9UESIe2DaT8PW75+kdCSUpS1ox
         fw5DsPWoM21cg==
Received: by mail-ej1-f44.google.com with SMTP id n21so16323326ejb.9
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 11:27:11 -0800 (PST)
X-Gm-Message-State: ANoB5pnnLA4VdNyvvnLhNbOiXTFV5UzQlOL4J93XRRsf2fx4i0XyQ/+4
        rsDnt5zM0WVkwv3EkOXEHwBFd0BaiBpteoBczbY=
X-Google-Smtp-Source: AA0mqf4D7uENP5j+VoEifnebjfv7JhZ4uwh8K+Lw1iyWJW9ee9FSiBI8qcd7cvWmmBoqwiIuQ76VE1Tegt/i0WRZYzk=
X-Received: by 2002:a17:907:7e86:b0:7af:bc9:5e8d with SMTP id
 qb6-20020a1709077e8600b007af0bc95e8dmr1072278ejc.3.1670441229415; Wed, 07 Dec
 2022 11:27:09 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
 <87v8mvsd8d.ffs@tglx> <CAPhsuW5g45D+CFHBYR53nR17zG3dJ=3UJem-GCJwT0v6YCsxwg@mail.gmail.com>
 <87k03ar3e3.ffs@tglx> <CAPhsuW592J1+Z1e_g_1YPn9KcyX65WFfbbBx6hjyuj0wgN4_XQ@mail.gmail.com>
 <878rjqqhxf.ffs@tglx> <CAPhsuW65K5TBbT_noTMnAEQ58rNGe-MfnjHF-arG8SZV9nfhzg@mail.gmail.com>
 <87v8mndy3y.ffs@tglx>
In-Reply-To: <87v8mndy3y.ffs@tglx>
From:   Song Liu <song@kernel.org>
Date:   Wed, 7 Dec 2022 11:26:56 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7tv3MwKJZeEib_4mFUx-DJL3aZO05CjFkvH0U+EFQyrg@mail.gmail.com>
Message-ID: <CAPhsuW7tv3MwKJZeEib_4mFUx-DJL3aZO05CjFkvH0U+EFQyrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Thomas,

On Wed, Dec 7, 2022 at 7:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
[...]
> > Survey of the 11 architecture specific module_alloc(). They basically do
> > the following magic:
> >
> > 1. Modify MODULES_VADDR and/or MODULES_END. There are multiple
> >   reasons behind this, some arch does this for KASLR, some other archs
> >   have different MODULES_[VADDR|END] for different processors (32b vs.
> >   64b for example), some archs use some module address space for other
> >   things (i.e. _exiprom on arm).
> >
> > Archs need 1: x86, arm64, arm, mips, ppc, riscv, s390, loongarch,
> > sparc
>
> All of this is pretty much a boot time init decision, right?

Yeah, all of these are boot time or compile time decisions.

>
> > 2. Use kasan_alloc_module_shadow()
> >
> > Archs need 2: x86, arm64, s390
>
> There is nothing really architecture specific, so that can be part of
> the core code, right?

Right, kasan_free_module_shadow() is called from vmalloc.c, so the
alloc one can do the same.

>
> > 3. A secondary module address space. There is a smaller preferred
> >   address space for modules. Once the preferred space runs out, allocate
> >   memory from a secondary address space.
[...]
>
> > 6. nios2 uses kmalloc() for modules. Based on the comment, this is
> >   probably only because it needs different MODULES_[VADDR|END].
>
> It's a horrible hack because they decided to have their layout:
>
>      VMALLOC_SPACE   0x80000000
>      KERNEL_SPACE    0xC0000000
>
> and they use kmalloc because CALL26/PCREL26 cannot reach from 0x80000000
> to 0xC0000000. That's true, but broken beyond repair.
>
> Making the layout:
>
>      VMALLOC_SPACE   0x80000000
>      MODULE_SPACE    0xBE000000         == 0xC0000000 - (1 << 24) (32M)
> or
>      MODULE_SPACE    0xBF000000         == 0xC0000000 - (1 << 24) (16M)
>      KERNEL_SPACE    0xC0000000
>
> would have been too obvious...

Yeah, I was thinking about something like this.

>
> > I think we can handle all these with a single module_alloc() and a few
> > module_arch_* functions().

[...]

>
> /**
>  * struct mod_alloc_type - Parameters for module allocation type
>  * @mapto_type:         The type to merge this type into, if different
>  *                      from the actual type which is configured here.
>  * @flags:              Properties
>  * @granularity:        The allocation granularity (PTE/PMD)
>  * @alignment:          The allocation alignment requirement
>  * @start:              Array of address space range start (inclusive)
>  * @end:                Array of address space range end (inclusive)
>  * @pgprot:             The page protection for this type
>  * @fill:               Function to fill allocated space. If NULL, use memcpy()
>  * @invalidate:         Function to invalidate allocated space. If NULL, use memset()
>  *
>  * If @granularity > @alignment the allocation can reuse free space in
>  * previously allocated pages. If they are the same, then fresh pages
>  * have to be allocated.
>  */
> struct mod_alloc_type {
>         unsigned int    mapto_type;
>         unsigned int    flags;
>         unsigned int    granularity;
>         unsigned int    alignment;
>         unsigned long   start[MOD_MAX_ADDR_SPACES];
>         unsigned long   end[MOD_MAX_ADDR_SPACES];
>         pgprot_t        pgprot;
>         void            (*fill)(void *dst, void *src, unsigned int size);
>         void            (*invalidate)(void *dst, unsigned int size);
> };

Yeah, this is a lot better than arch_ functions.

We probably want two more function pointers here:

int (*protect)(unsigned long addr, int numpages);
int (*unprotect)(unsigned long addr, int numpages);

These two functions will be NULL for archs that support text_poke;
while legacy archs use them for set_memory_[ro|x|rw|nx]. Then, I
think we can get rid of VM_FLUSH_RESET_PERMS.

[...]

Everything else makes perfect sense. Thanks!

I think I am ready to dive into the code and prepare the first RFC/PATCH.
Please let me know if there is anything we should discuss/clarify before that.

Best,
Song
