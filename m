Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31D424244D
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 05:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHLDaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 23:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgHLDaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 23:30:18 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5497EC06174A
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 20:30:18 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id x10so585278ybj.13
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2020 20:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jq6KwZn9dBsNqjuVThBLi66fPTb+WyI9MZGaNYTOdqI=;
        b=m0pIU87+6fJXCrgzPexe6V6gNLgHq7HOyMioj0TZqaOCnIl3EJ/UGredW3jqiwgZfX
         LKWxN7XOF9Z95ugAyGf23he3/yl/5PSbygiT3Sco/mzsMkPkbZjzFqozhx4EvaPUyUcy
         o2egzx72IFhpbakgR29vHAVwxjMsEp/WQ5H8LOvU5/aZI13GHBErAgVoI7thMTWU5PPH
         fhlo6+ltkhuzukEd9dvTFLfV4CGoC+XtDslS2jekrssbykd7r+F0w3800rDxQD8/MYBl
         NYFe8yQkVZ41i9w5C8COZsLOiNhV0+oElcuya2hgRx4SGQWQkvtySjALOBKGPGBWa3IA
         rjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jq6KwZn9dBsNqjuVThBLi66fPTb+WyI9MZGaNYTOdqI=;
        b=COT+/is88laAGf6PCcQtOnujmD6K+4JudDMsYzpRFuKP1lTJPMdcLbAQCsvkNzY83c
         F08FIq2x15G94riTnUqDkRLo1Lv6X10z6nRRQt+bGbhBTRzaOejX02WIfGNRSLyVNIgV
         JUtuOszHLM/oDbVZc6sDs4qwrlRPf97lR5cfKKlGDe1jTRVVk4ZqARGVxEViiqMj3GaO
         hP3FRvg9oskwzHDB80Dj+dmtLMt38ZsODSTmVV4AA9ye1FduTpjkIh3ptAGoA78QzgXk
         EUakZ41jUuadZ3Q3n/Kznw5ErbWaZhoP3xpac2H6xL0w9vy6i5sRUYp7CvndGFE7lz+B
         uZeA==
X-Gm-Message-State: AOAM530YtUno6/HzG1S91QLX1AXsdCTg2XDEBRX0B+2CO2axTbhyGaFJ
        BLPzVZfYLu2px7bQai6AahHX96CDwi5FOrnY940=
X-Google-Smtp-Source: ABdhPJwD+mzEVwASRKgWMVRzQyP0zV4AshhMz4dSrww2reRFNfVfdoMzZJVLzuhSzhg3BBwcnzeioeGJaCN0s6icbmc=
X-Received: by 2002:a25:ad5a:: with SMTP id l26mr49283893ybe.510.1597203017584;
 Tue, 11 Aug 2020 20:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200810122835.2309026-1-jean-philippe@linaro.org>
In-Reply-To: <20200810122835.2309026-1-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 Aug 2020 20:30:06 -0700
Message-ID: <CAEf4Bza_Fchmy7sKT4=3Vs6wopk+yZU7g9o86CJNzeH4DY1c2A@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Handle GCC built-in types for Arm NEON
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 5:41 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When building Arm NEON (SIMD) code, GCC emits built-in types __PolyXX_t,
> which are not recognized by Clang. This causes build failures when
> including vmlinux.h generated from a kernel built with CONFIG_RAID6_PQ=y
> and CONFIG_KERNEL_MODE_NEON. Emit typedefs for these built-in types,
> based on the Clang definitions. poly64_t is unsigned long because it's
> only defined for 64-bit Arm.
>
> Including linux/kernel.h to use ARRAY_SIZE() incidentally redefined
> max(), causing a build bug due to different types, hence the seemingly
> unrelated change.
>
> Reported-by: Jakov Petrina <jakov.petrina@sartura.hr>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---

Thanks for sending small binaries (in little-endian, double thanks!)
for me to look at generated DWARF and BTF.

I have a bunch of naming nits below and a grudge against "long", but
the approach looks reasonable to me overall. It's unfortunate we have
to deal with GCC quirks like this.

>  tools/lib/bpf/btf_dump.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index cf711168d34a..3162d7b1880c 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -13,6 +13,7 @@
>  #include <errno.h>
>  #include <linux/err.h>
>  #include <linux/btf.h>
> +#include <linux/kernel.h>
>  #include "btf.h"
>  #include "hashmap.h"
>  #include "libbpf.h"
> @@ -549,6 +550,9 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
>         }
>  }
>
> +static void btf_dump_emit_int_def(struct btf_dump *d, __u32 id,
> +                                 const struct btf_type *t);
> +
>  static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
>                                      const struct btf_type *t);
>  static void btf_dump_emit_struct_def(struct btf_dump *d, __u32 id,
> @@ -671,6 +675,9 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
>
>         switch (kind) {
>         case BTF_KIND_INT:
> +               /* Emit type alias definitions if necessary */
> +               btf_dump_emit_int_def(d, id, t);

let's call it btf_dump_emit_missing_aliases() or something like that,
so it's clear that it's some sort of compatibility/legacy compiler
handling. "emit_int_def" is way too generic and normal-looking.

> +
>                 tstate->emit_state = EMITTED;
>                 break;
>         case BTF_KIND_ENUM:
> @@ -870,7 +877,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
>                         btf_dump_printf(d, ": %d", m_sz);
>                         off = m_off + m_sz;
>                 } else {
> -                       m_sz = max(0, btf__resolve_size(d->btf, m->type));
> +                       m_sz = max(0LL, btf__resolve_size(d->btf, m->type));
>                         off = m_off + m_sz * 8;
>                 }
>                 btf_dump_printf(d, ";");
> @@ -890,6 +897,32 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
>                 btf_dump_printf(d, " __attribute__((packed))");
>  }
>
> +static const char *builtin_types[][2] = {

again, something like "missing_base_types" would be a bit more prominent

> +       /*
> +        * GCC emits typedefs to its internal __PolyXX_t types when compiling
> +        * Arm SIMD intrinsics. Alias them to the same standard types as Clang.
> +        */
> +       { "__Poly8_t",          "unsigned char" },
> +       { "__Poly16_t",         "unsigned short" },
> +       { "__Poly64_t",         "unsigned long" },

In the diff ([0]) that Daniel referenced, seems like they are adding
poly64_t to ARM32. What prevents GCC from doing that (or maybe they've
already done that). So instead of making unreliable assumptions, let's
define it as "unsigned long long" instead?

  [0] https://reviews.llvm.org/D79711

> +       { "__Poly128_t",        "unsigned __int128" },
> +};
> +
> +static void btf_dump_emit_int_def(struct btf_dump *d, __u32 id,
> +                                 const struct btf_type *t)
> +{
> +       const char *name = btf_dump_type_name(d, id);
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(builtin_types); i++) {
> +               if (strcmp(name, builtin_types[i][0]) == 0) {
> +                       btf_dump_printf(d, "typedef %s %s;\n\n",
> +                                       builtin_types[i][1], name);
> +                       break;
> +               }
> +       }
> +}
> +
>  static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
>                                    const struct btf_type *t)
>  {
> --
> 2.27.0
>
