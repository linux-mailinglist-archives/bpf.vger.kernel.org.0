Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA152961C
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 02:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiEQAhx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 20:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiEQAhw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 20:37:52 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1275DEEE
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:37:50 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s14so11653700ild.6
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 17:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lntBFGTLUGtHy43ugCwAaLnkXsAgUbMEuYgfnsEfFs=;
        b=djyTM+Bw9JPfwN+uV8gvdhLnvfOLNybd07rjF/Oh+29MzvhPJ2+eRoSNSc9Q46Bn0Y
         4A8x0Uaim03qQCue7rdU8GpiHuwqDs5Mm1Z8mg3BVCMEsFabpTqi0o2C4O4evU7BwqMK
         cudoR1XjOyMJomtEG1Gy3LWopgKaI3S8SRFIWXGnHDgkhAdw+hI/l9T9G0qGuYvpLb1g
         JVG/UYMBLSwzSmgcqws5+YAUMh/j9+lt4U52kek7ttFN8Hcw6pwV4EISyyP7uAwZUXol
         2ZNv0mXw6ay6Zf4Hj0NoqDvngndB+xb8Uv7VZv8wT7a3pfBmRZJu6f35GE7PMRI7Krmn
         BenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lntBFGTLUGtHy43ugCwAaLnkXsAgUbMEuYgfnsEfFs=;
        b=fohnh7eOPD6Q8WgFtTv4w9qqv/QapLDE2nAgQJfBmlDUxAX+KXC1kRf7S9J2hudDnE
         25bya69JSo3xNh4iBJ7/wuVAqGBh0ogKN4P7+yX6LEZWQt9gS6/FOSZkcd4KeaqT8Rn+
         RAYT7P+i4uIJmhX8dRoRrUUSGSrlldGQ31Gmnix1PJaJHRDjLD4OpD0xn0xvtLJLuLRJ
         6ZboHRzSRLLOEH5T0mnL9DFoIv48/bkDkL5KToNNigAlUmr01pV3lR2kW/rdlkVZY9M7
         tXEABd2Z/U+vZohcSrROqj5A6g1F2sLl2gLG8AwLUvaTluE7wq+MYiOlsyY83kLyB+Bo
         kU0w==
X-Gm-Message-State: AOAM531v+LX22a4UwPMXrvBQzLehhYY35BoMq+jnk66N6PPwejhEjwTH
        rT+vXqf6MF4ukKWMtSl7wZ0ndllPRBeKR03kI/NF/sFY
X-Google-Smtp-Source: ABdhPJy9tisGJf73u/xen3zdukAmmhIjWVWB90S0qb38aDpnvqeq9sg+W9kJYW5hH4l9sc5t901omFfeL3KJSRqwnSM=
X-Received: by 2002:a05:6e02:1c01:b0:2d1:262e:8d5f with SMTP id
 l1-20020a056e021c0100b002d1262e8d5fmr2954140ilh.98.1652747870195; Mon, 16 May
 2022 17:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031258.3242876-1-yhs@fb.com>
In-Reply-To: <20220514031258.3242876-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 17:37:39 -0700
Message-ID: <CAEf4BzZq1PdMukF4OCKOKAG0owD+NduZkKcYiTYJEM_RW-AZEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/18] libbpf: Add enum64 support for btf_dump
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add enum64 btf dumping support. For long long and unsigned long long
> dump, suffixes 'LL' and 'ULL' are added to avoid compilation errors
> in some cases.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.h      |   5 ++
>  tools/lib/bpf/btf_dump.c | 135 ++++++++++++++++++++++++++++++---------
>  2 files changed, 110 insertions(+), 30 deletions(-)
>

[...]

> @@ -989,38 +992,88 @@ static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
>         btf_dump_printf(d, "enum %s", btf_dump_type_name(d, id));
>  }
>
> -static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
> -                                  const struct btf_type *t,
> -                                  int lvl)
> +static void btf_dump_emit_enum32_val(struct btf_dump *d,
> +                                    const struct btf_type *t,
> +                                    int lvl, __u16 vlen)
>  {
>         const struct btf_enum *v = btf_enum(t);
> -       __u16 vlen = btf_vlen(t);

why passing it from outside if we can just get it from t? you don't do
it for kflag, for example, so I see no reason to do that for vlen here

> +       bool is_signed = btf_kflag(t);
> +       const char *fmt_str;
>         const char *name;
>         size_t dup_cnt;
>         int i;
>
> +

nit: extra empty line?

> +       for (i = 0; i < vlen; i++, v++) {
> +               name = btf_name_of(d, v->name_off);
> +               /* enumerators share namespace with typedef idents */
> +               dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
> +               if (dup_cnt > 1) {
> +                       fmt_str = is_signed ? "\n%s%s___%zd = %d,"
> +                                           : "\n%s%s___%zd = %u,";
> +                       btf_dump_printf(d, fmt_str,
> +                                       pfx(lvl + 1), name, dup_cnt,
> +                                       v->val);
> +               } else {
> +                       fmt_str = is_signed ? "\n%s%s = %d,"
> +                                           : "\n%s%s = %u,";
> +                       btf_dump_printf(d, fmt_str,
> +                                       pfx(lvl + 1), name,
> +                                       v->val);

100 character lines are ok now, try to make all those statements
single-line, if possible

> +               }
> +       }
> +}
> +

[...]
