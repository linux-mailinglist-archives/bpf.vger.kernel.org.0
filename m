Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440D650A6AD
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiDURMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390606AbiDURMn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 13:12:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3883422C
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 10:09:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bj36so6529256ljb.13
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IqQ6+qBUviTbm525jpNP9rFFjEP17/Uq4yu2pgmklg=;
        b=h0AVqXEZDnoKpki6s6mvGXaq/qVhk9PLSMD+KC2kB/6zAm9WZ0/TOIR8jL431bIerZ
         7RJOezuZFJkSKXrVWiCiNh2VtITqKNiaXmqD1p7DnmDoWTRufGVc5rcdwItl1OU/NUUm
         /obosCnwvUIpl5bIMmP+YPXBXCAjBYScWaF/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IqQ6+qBUviTbm525jpNP9rFFjEP17/Uq4yu2pgmklg=;
        b=3vt31d42Bi5lcy9HlfD/klCfU4zOr0PzA45Hd1I12sw66LDQxnweuidZqhqu61cP2O
         0K0Nq+lFIPHz0FzT0eGl+MDGAScxTGUat0SLlMne5OOAZiw5dDgKSLckopUHsApfR4ZV
         siHL2FFVElQWoWedQ1k8VRh+btWHfP+fHE0Atnly+Kp8CLDZ96VqWGgS1jHZmYLrHxdr
         KLNn3+RHIVyzBzlrU0EIqgni/R1pnerClnZcLZhYKschmfDMOpA6Xo8sPpWYYclTJ2EQ
         Q4iYRt7khykavRrPKBetdCWm3hv07kkNeUnVtiQHufMAWjdeMxMcLwdzdGaXS/IPm7WI
         KV5Q==
X-Gm-Message-State: AOAM530IETiTIp3fhxeFBKEC4dRC9NdfwHC82fr1C2m8mH6c0FQI2Qu1
        VfpBqhy9td0IeZmV5ht9MF78O4uMyO0Su8aSJQ4=
X-Google-Smtp-Source: ABdhPJy/uXYOxI371qfnB65KPwMGo5UMUVJMgTk5Rc0kJCB9RrDMRDdkfb5VLcE39J+xlhKac7CNvQ==
X-Received: by 2002:a2e:9d8a:0:b0:24d:b3e3:c0c with SMTP id c10-20020a2e9d8a000000b0024db3e30c0cmr384553ljj.517.1650560989819;
        Thu, 21 Apr 2022 10:09:49 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i14-20020ac25b4e000000b00471d5317235sm22463lfp.242.2022.04.21.10.09.43
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:09:44 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id n17so6538556ljc.11
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 10:09:43 -0700 (PDT)
X-Received: by 2002:a2e:b8d2:0:b0:24e:e19c:5375 with SMTP id
 s18-20020a2eb8d2000000b0024ee19c5375mr413269ljp.176.1650560983746; Thu, 21
 Apr 2022 10:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220421072212.608884-1-song@kernel.org>
In-Reply-To: <20220421072212.608884-1-song@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Apr 2022 10:09:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
Message-ID: <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 12:27 AM Song Liu <song@kernel.org> wrote:
>
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -228,6 +228,28 @@ static void jit_fill_hole(void *area, unsigned int size)
>         memset(area, 0xcc, size);
>  }
>
> +#define INVALID_BUF_SIZE PAGE_SIZE
> +static char invalid_insn_buf[INVALID_BUF_SIZE];
> +
> +static int __init bpf_init_invalid_insn_buf(void)
> +{
> +       jit_fill_hole(invalid_insn_buf, INVALID_BUF_SIZE);
> +       return 0;
> +}
> +pure_initcall(bpf_init_invalid_insn_buf);
> +
> +void bpf_arch_invalidate_text(void *dst, size_t len)
> +{
> +       size_t i = 0;
> +
> +       while (i < len) {
> +               size_t s = min_t(size_t, len - i, INVALID_BUF_SIZE);
> +
> +               bpf_arch_text_copy(dst + i, invalid_insn_buf, s);
> +               i += s;
> +       }
> +}

Why do we need this new infrastructure?

Why bpf_arch_invalidate_text()?

Why not jit_fill_hole() unconditionally?

It seems a bit pointless to have page buffer for containing this data,
when we already have a (trivial) function to fill an area with invalid
instructions.

On x86, it's literally just "memset(0xcc)" (ie all 'int3' instructions).

And on most RISC architectures, it would be some variation of
"memset32(TRAP_INSN)".

And all bpf targets should already have that nicely as that
jit_fill_hole() function, no?

The pack-allocator bpf code already *does* that, and is already passed
that function.

But it's just that it does it too late. Instead of doing it when
allocating a new pack, it does it in the sub-allocator.

Afaik the code in bpf/core.c already has all the information it needs,
and already has that jit_fill_hole() function pointer, but is applying
it at the wrong point.

So I think the fix should be to just pass in that 'bpf_fill_ill_insns'
function pointer all the way to alloc_new_pack(), instead of using it
in bpf_jit_binary_alloc().

NOTE! Once again, I'm not actually all that familiar with the code.
Maybe I'm missing something.

             Linus
