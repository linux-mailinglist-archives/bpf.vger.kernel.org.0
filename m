Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32252453D5F
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 01:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhKQBBc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 20:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhKQBBc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 20:01:32 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4AC061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 16:58:34 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g17so2043204ybe.13
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 16:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RE8b2UKzhUFZb3fU8ktsYnwcR9zYve7dDadoUV5LmBE=;
        b=SJsxfQGiRxSJo701NYqvGUT7IfjjVQHamEHGfhEJIQsFLwgbiotbTaGnM9v4d/DAUf
         Q1NIpPsMka5O5gG4daaL0KGtq55OA0j/mmEl4G9+SdAv1n4HDukb+Cg2azWzllagwnW3
         n3Z0tdchG+d/W8KrDDIKNbYTz6AIIir8idp57+GOUwvWpDKzXCcUY6SNZXrA6XriXBrW
         90LVoYMN1HQbzB0+HFweRPppgmLt9WJuBG6Wjeg8kZaoOGaJ5DtFHwX64094wZxhJohw
         fFRMR4o5qRRkB83CQl6LbirMieC0Zayh1Kcpxnwo68t72OGAqHAn2b657TNHKcyK6JTB
         41kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RE8b2UKzhUFZb3fU8ktsYnwcR9zYve7dDadoUV5LmBE=;
        b=sOojYND4qwRqZ2IODKEmVwYLJTF+5FKyu+EpfadRAq7KR53dADcI6y6DG/CjjZ3Lqy
         IyRa+PhE6ePs86InyvLSEKuFXNR6pkZY7Y5+LMwHE0o2KUbptzGiGmsIto3NMbkmSBJi
         slQ4ujAA2DdI9y/BhUAeFhClCW9X2kf9nPEFu4mH24pLqLWYVLM0OvwPrBFZsTMWg/mg
         AiO3GyJhSEMfffZbb5Tc+efjOtpK1idsy+GfOKjbQqjYNSdRjVVcM1dMAPpIJjk3p+1Q
         idTdGh3Ksks/HWnBg+uMPPVleQdZ6nCI8Heg+rpQqBdgWBxMYWLtKlM5KqRjS20bH3Ca
         54ig==
X-Gm-Message-State: AOAM531mfZdxtPmvrGqL08Anz5MLjgYDIyKAN4sjAHyI1JUUI5iQl7bc
        FJP9B8alD1xV13qihi05H6aarlGIZ4FIv/c3HoeOO1dR
X-Google-Smtp-Source: ABdhPJylxf5gKBLelQej96fr8cARzNgRrMWU1ebNKMjNVhiQuzpPACS8kFFi/4NqFGjgFQQDkHLn2ISd4mO6CuMyaFE=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr12250307ybj.433.1637110713928;
 Tue, 16 Nov 2021 16:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-4-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 16:58:23 -0800
Message-ID: <CAEf4BzaY=waUdY2stYjmU=tT92BfqLoSiV7ytE_WX_sCr8RL=w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/12] bpf: Prepare relo_core.c for kernel duty.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 9:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Make relo_core.c to be compiled with kernel and with libbpf.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/btf.h       | 82 +++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/Makefile       |  4 ++
>  kernel/bpf/btf.c          | 26 +++++++++++++
>  tools/lib/bpf/relo_core.c | 71 ++++++++++++++++++++++++++++-----
>  4 files changed, 174 insertions(+), 9 deletions(-)
>

[...]

>  static inline const struct btf_member *btf_type_member(const struct btf_type *t)
>  {
>         return (const struct btf_member *)(t + 1);
>  }
>
> +

accidental empty line or intentional?

> +static inline struct btf_array *btf_array(const struct btf_type *t)
> +{
> +       return (struct btf_array *)(t + 1);
> +}
> +

[...]

> +int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
> +                             const struct btf *targ_btf, __u32 targ_id)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static bool bpf_core_is_flavor_sep(const char *s)
> +{
> +       /* check X___Y name pattern, where X and Y are not underscores */
> +       return s[0] != '_' &&                                 /* X */
> +              s[1] == '_' && s[2] == '_' && s[3] == '_' &&   /* ___ */
> +              s[4] != '_';                                   /* Y */
> +}
> +
> +size_t bpf_core_essential_name_len(const char *name)

I might have missed something, but this seems to be used only
internally, so should be static. Otherwise there would be a
compilation warning due to the missing prototype, no?

> +{
> +       size_t n = strlen(name);
> +       int i;
> +
> +       for (i = n - 5; i >= 0; i--) {
> +               if (bpf_core_is_flavor_sep(name + i))
> +                       return i + 1;
> +       }
> +       return n;
> +}

[...]

> +       t = btf_type_by_id(btf, type_id);
> +       t = btf_resolve_size(btf, t, &size);
> +       if (IS_ERR(t))
> +               return PTR_ERR(t);
> +       return size;
> +}

nit: empty line would be good here and after enum

> +enum libbpf_print_level {
> +       LIBBPF_WARN,
> +       LIBBPF_INFO,
> +       LIBBPF_DEBUG,
> +};
> +#undef pr_warn
> +#undef pr_info
> +#undef pr_debug
> +#define pr_warn(fmt, log, ...) bpf_log((void *)log, fmt, "", ##__VA_ARGS__)
> +#define pr_info(fmt, log, ...) bpf_log((void *)log, fmt, "", ##__VA_ARGS__)
> +#define pr_debug(fmt, log, ...)        bpf_log((void *)log, fmt, "", ##__VA_ARGS__)
> +#define libbpf_print(level, fmt, ...)  bpf_log((void *)prog_name, fmt, ##__VA_ARGS__)
> +#else
>  #include <stdio.h>
>  #include <string.h>
>  #include <errno.h>
> @@ -12,8 +64,9 @@
>  #include "btf.h"
>  #include "str_error.h"
>  #include "libbpf_internal.h"
> +#endif
>
> -#define BPF_CORE_SPEC_MAX_LEN 64
> +#define BPF_CORE_SPEC_MAX_LEN 32

This is worth calling out in the commit description, should have
practical implications, but good to mention.

>
>  /* represents BPF CO-RE field or array element accessor */
>  struct bpf_core_accessor {
> @@ -272,8 +325,8 @@ static int bpf_core_parse_spec(const struct btf *btf,
>                                 return sz;
>                         spec->bit_offset += access_idx * sz * 8;
>                 } else {
> -                       pr_warn("relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %s\n",
> -                               type_id, spec_str, i, id, btf_kind_str(t));
> +/*                     pr_warn("relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %s\n",
> +                               type_id, spec_str, i, id, btf_kind_str(t));*/

we can totally pass prog_name and add "prog '%s': " to uncomment this.
bpf_core_parse_spec() is called in the "context" of program, so it's
known

>                         return -EINVAL;
>                 }
>         }
> @@ -346,8 +399,8 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
>                 targ_id = btf_array(targ_type)->type;
>                 goto recur;
>         default:
> -               pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
> -                       btf_kind(local_type), local_id, targ_id);
> +/*             pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
> +                       btf_kind(local_type), local_id, targ_id);*/

sigh... it's a bit too intrusive to pass prog_name here but it's also
highly unlikely that this happens (unless some compiler bug or
corruption) and even in that case it's semantically correct that
fields just don't match. So I'd just drop this pr_warn() instead of
commenting it out

>                 return 0;
>         }
>  }

[...]
