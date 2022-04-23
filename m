Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B006350C79E
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 07:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiDWF2r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Apr 2022 01:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiDWF2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Apr 2022 01:28:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076818744A;
        Fri, 22 Apr 2022 22:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 588E0B801BA;
        Sat, 23 Apr 2022 05:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBF8C385A9;
        Sat, 23 Apr 2022 05:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650691545;
        bh=q6jqaY03g41hcsI0QCManqaNvGa5sGMYC6V39cLA0l8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bbR2UUPIqcJGuZZzm8nOgkWxo2ChtfrEfUBPvE4VPt8a+ThQn1tRffXiPDbxtsUIe
         wqyz42+I92dr0a+15dlgb77MpJuS0Sa0ddLMcrQx3LXqtvoFNGG85vUu7Iln5vZb6C
         uVX+RHbMhBTxVU9HJnmOsmQHYEOOIF8bQ+8+wY766NrkKrh9/vFVmPr39RVlumcCx0
         Ocnm0a6GGnPzVuZ7//PbngCzH6HbvD/oSf/Qmzq2gamYr3e1iFFrCEGj0e6zG6kNFv
         NvPe3BIgu3xBbxEeGUi5TceyAJ9GizKX0T0JwT5zhFaW/FuemcgYIDtr97YpNMwr9O
         a0XgAFAuAYuvA==
Received: by mail-yb1-f176.google.com with SMTP id b26so12362307ybj.13;
        Fri, 22 Apr 2022 22:25:45 -0700 (PDT)
X-Gm-Message-State: AOAM530LhD8aFr/mr+wnf+kf5PjmWAf2UNjPPZB31wC9/W5oZtkakfvw
        CzvArl3ybCZ21VFJvPyUJsRDiJKwD8UDLdKJWf0=
X-Google-Smtp-Source: ABdhPJxECgRV5ioL9K3lI8C1A9nSRRuKOZ108iWKeb3lc81+AwWwf2cxB3V44iK7qyJeRhTXiT++O1jnhjHju0z9HLs=
X-Received: by 2002:a25:395:0:b0:645:8146:9a9e with SMTP id
 143-20020a250395000000b0064581469a9emr7287113ybd.389.1650691544022; Fri, 22
 Apr 2022 22:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org> <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
 <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
 <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
 <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
 <1A4FF473-0988-48BE-9993-0F5E9F0AAC95@fb.com> <CAHk-=wi62LDc5B3DOr5pyVtOUOuLkLzHvmZQApH9q=raqaGkUg@mail.gmail.com>
 <8F788446-899C-4BA3-8236-612A94D98582@fb.com> <20220422073118.GR2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220422073118.GR2731@worktop.programming.kicks-ass.net>
From:   Song Liu <song@kernel.org>
Date:   Fri, 22 Apr 2022 22:25:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW58Y2wOe68jHmqj9ZCUQO-4nMWZn82wU=5sA+n7LEkM=A@mail.gmail.com>
Message-ID: <CAPhsuW58Y2wOe68jHmqj9ZCUQO-4nMWZn82wU=5sA+n7LEkM=A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 22, 2022 at 12:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > On Apr 21, 2022, at 3:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > > I actually think bpf_arch_text_copy() is another horribly badly done thing.
> > >
> > > It seems only implemented on x86 (I'm not sure how anything else is
> > > supposed to work, I didn't go look), and there it is horribly badly
> > > done, using __text_poke() that does all these magical things just to
> > > make it atomic wrt concurrent code execution.
> > >
> > > None of which is *AT*ALL* relevant for this case, since concurrent
> > > code execution simply isn't a thing (and if it were, you would already
> > > have lost).
> > >
> > > And if that wasn't pointless enough, it does all that magic "map the
> > > page writably at a different virtual address using poking_addr in
> > > poking_mm" and a different address space entirely.
> > >
> > > All of that is required for REAL KERNEL CODE.
> > >
> > > But the thing is, for bpf_prog_pack, all of that is just completely
> > > pointless and stupid complexity.
>
> I think the point is that this hole will likely share a page with active
> code, and as such there should not be a writable mapping mapping to it,
> necessitating the whole __text_poke() mess.
>
> That said; it does seem somewhat silly have a whole page worth of int3
> around just for this.
>
> Perhaps we can do something like the completely untested below?

Yeah, this looks like a better approach. I will draft v2 based on this.

Thanks,
Song

>
> ---
>  arch/x86/kernel/alternative.c | 48 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d374cb3cf024..60afa9105307 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -994,7 +994,20 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
>  __ro_after_init struct mm_struct *poking_mm;
>  __ro_after_init unsigned long poking_addr;
>
> -static void *__text_poke(void *addr, const void *opcode, size_t len)
> +static void text_poke_memcpy(void *dst, const void *src, size_t len)
> +{
> +       memcpy(dst, src, len);
> +}
> +
> +static void text_poke_memset(void *dst, const void *src, size_t len)
> +{
> +       int c = *(int *)src;
> +       memset(dst, c, len);
> +}
> +
> +typedef void text_poke_f(void *dst, const void *src, size_t len);
> +
> +static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t len)
>  {
>         bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
>         struct page *pages[2] = {NULL};
> @@ -1059,7 +1072,7 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
>         prev = use_temporary_mm(poking_mm);
>
>         kasan_disable_current();
> -       memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
> +       func((void *)poking_addr + offset_in_page(addr), src, len);
>         kasan_enable_current();
>
>         /*
> @@ -1091,7 +1104,8 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
>          * If the text does not match what we just wrote then something is
>          * fundamentally screwy; there's nothing we can really do about that.
>          */
> -       BUG_ON(memcmp(addr, opcode, len));
> +       if (func == text_poke_memcpy)
> +               BUG_ON(memcmp(addr, src, len));
>
>         local_irq_restore(flags);
>         pte_unmap_unlock(ptep, ptl);
> @@ -1118,7 +1132,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>  {
>         lockdep_assert_held(&text_mutex);
>
> -       return __text_poke(addr, opcode, len);
> +       return __text_poke(text_poke_memcpy, addr, opcode, len);
>  }
>
>  /**
> @@ -1137,7 +1151,7 @@ void *text_poke(void *addr, const void *opcode, size_t len)
>   */
>  void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
>  {
> -       return __text_poke(addr, opcode, len);
> +       return __text_poke(text_poke_memcpy, addr, opcode, len);
>  }
>
>  /**
> @@ -1167,7 +1181,29 @@ void *text_poke_copy(void *addr, const void *opcode, size_t len)
>
>                 s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
>
> -               __text_poke((void *)ptr, opcode + patched, s);
> +               __text_poke(text_poke_memcpy, (void *)ptr, opcode + patched, s);
> +               patched += s;
> +       }
> +       mutex_unlock(&text_mutex);
> +       return addr;
> +}
> +
> +void *text_poke_set(void *addr, int c, size_t len)
> +{
> +       unsigned long start = (unsigned long)addr;
> +       size_t patched = 0;
> +
> +       if (WARN_ON_ONCE(core_kernel_text(start)))
> +               return NULL;
> +
> +       mutex_lock(&text_mutex);
> +       while (patched < len) {
> +               unsigned long ptr = start + patched;
> +               size_t s;
> +
> +               s = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(ptr), len - patched);
> +
> +               __text_poke(text_poke_memset, (void *)ptr, (void *)&c, s);
>                 patched += s;
>         }
>         mutex_unlock(&text_mutex);
