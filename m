Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6310844DBC7
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhKKSw5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhKKSw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:52:57 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3145C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:50:07 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g17so17308727ybe.13
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQqJYSjKLICPrq4vheXAZ/SXWmehyghKAZpiTnSno8I=;
        b=M9X/YIFXPyr8HxlgfxpEy8V9o6+WOby4MFpur6TGjuNczYlpQMl2eq49m71XJlBJrL
         /I//O+6TTcu9CewB3fJhoPmKMhjjJqD1aKimEDyL4qKwpqYF53Th+eKwACvtHuzELPDY
         da6UP/0CLRN9/gNFAjuOfaUE7wLe36161oTLSo8lGMod3jn1Amk9x82A0URfswIJ/gdx
         6Tlv7eQ5SBdQLulSu5Y5yILUaeUJv/6msA8zxqC62CFOLikRcqKnC9nmA6E9png9I7mm
         oK43FXpkLxDKei0jfEeGxabU221kx0xPvwt9XkGdgUOv+6wBoHFyZYIF+xoEgouVdSIV
         J8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQqJYSjKLICPrq4vheXAZ/SXWmehyghKAZpiTnSno8I=;
        b=OXw9CNkdhlwmrVbEDzbOHbvdP8DKX/MuwL2XYs+7JNzARhAcVcxdCALHfP1QhiFpUK
         i/G264H807sj8nfXcmNheBcAmToSf7iR/7bu1W7dEKprFJBE8+iD1oJLPcOxkFOX4yLm
         tRyg54vaHlIl5y4IjXXFoF3EQgTsEk1df32JQvMt7+IzvhymyxozxT0C1PfKQgRkAnNL
         qlN3tQVhtSB1jYDRbaHYqEI9I4tVsxUqEocirDew7O3pGgSScSQsEvRMl0XwoApp2Mcj
         VFg4b3TiPRiW3ScUyWuaNripApEO8GbQeuVdGAvBUm+yVlEb7JWm464onqnitIMSPTjK
         MPXg==
X-Gm-Message-State: AOAM530+X3PkNcBYw5Tt1qq6GHAD/tyIIxVXcMGMV98R7WkRCGMXAPjf
        RTY0fiXnWAJ7cKo/lEdsmWnHJXoheQIZXREMQkiTONlw
X-Google-Smtp-Source: ABdhPJzn7jDQIu3VlCp7zzVpUw1GIZyDqjPRH/Mra2g56X1T3K4QEjz/6AY8qVHE30REvrKCavXK5RxS8zo6JnnxR+w=
X-Received: by 2002:a25:d16:: with SMTP id 22mr10127572ybn.51.1636656607161;
 Thu, 11 Nov 2021 10:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110052012.371411-1-yhs@fb.com>
In-Reply-To: <20211110052012.371411-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:49:55 -0800
Message-ID: <CAEf4BzYgzKtTqMYkvSYr-PRtdQzN6KMDbXJTM0TA8J5icic==A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/10] selftests/bpf: Test BTF_KIND_DECL_TAG for deduplication
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:21 PM Yonghong Song <yhs@fb.com> wrote:
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c | 46 ++++++++++++++++++--
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index ebd0ead5f4bc..91b19c41729f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -6889,15 +6889,16 @@ const struct btf_dedup_test dedup_tests[] = {
>                         BTF_RESTRICT_ENC(8),                                            /* [11] restrict */
>                         BTF_FUNC_PROTO_ENC(1, 2),                                       /* [12] func_proto */
>                                 BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 18),
>                         BTF_FUNC_ENC(NAME_TBD, 12),                                     /* [13] func */
>                         BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),                                /* [14] float */
>                         BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),                             /* [15] decl_tag */
>                         BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),                              /* [16] decl_tag */
>                         BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),                              /* [17] decl_tag */
> +                       BTF_TYPE_TAG_ENC(NAME_TBD, 8),                                  /* [18] type_tag */
>                         BTF_END_RAW,
>                 },
> -               BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q"),
> +               BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R"),
>         },
>         .expect = {
>                 .raw_types = {
> @@ -6918,15 +6919,16 @@ const struct btf_dedup_test dedup_tests[] = {
>                         BTF_RESTRICT_ENC(8),                                            /* [11] restrict */
>                         BTF_FUNC_PROTO_ENC(1, 2),                                       /* [12] func_proto */
>                                 BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> -                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
> +                               BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 18),
>                         BTF_FUNC_ENC(NAME_TBD, 12),                                     /* [13] func */
>                         BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),                                /* [14] float */
>                         BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),                             /* [15] decl_tag */
>                         BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),                              /* [16] decl_tag */
>                         BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),                              /* [17] decl_tag */
> +                       BTF_TYPE_TAG_ENC(NAME_TBD, 8),                                  /* [18] type_tag */
>                         BTF_END_RAW,
>                 },
> -               BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q"),
> +               BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R"),
>         },
>         .opts = {
>                 .dont_resolve_fwds = false,
> @@ -7254,6 +7256,42 @@ const struct btf_dedup_test dedup_tests[] = {
>                 .dont_resolve_fwds = false,
>         },
>  },
> +{
> +       .descr = "dedup: btf_tag_type",
> +       .input = {
> +               .raw_types = {
> +                       /* int */
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +                       /* tag: tag1, tag2 */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /* [2] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),               /* [3] */
> +                       BTF_PTR_ENC(3),                                 /* [4] */
> +                       /* tag: tag1, tag2 */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /* [5] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 5),               /* [6] */
> +                       BTF_PTR_ENC(6),                                 /* [7] */
> +                       /* tag: tag1 */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /* [8] */
> +                       BTF_PTR_ENC(8),                                 /* [9] */
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0tag1\0tag2"),
> +       },

Can you please add a test for two more situations:

First, like this:

tag1 -> tag2 -> int
tag1 -> int

tag1's shouldn't be deduped

Second, like this

tag1 -> tag2 -> int
tag2 -> tag1 -> int

Nothing gets deduped.

Actually, also third situation:

tag1 -> int
tag1 -> long

Nothing gets deduped.

That will document expected behavior.

Thanks.

> +       .expect = {
> +               .raw_types = {
> +                       BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),               /* [2] */
> +                       BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),               /* [3] */
> +                       BTF_PTR_ENC(3),                                 /* [4] */
> +                       BTF_PTR_ENC(2),                                 /* [5] */
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0tag1\0tag2"),
> +       },
> +       .opts = {
> +               .dont_resolve_fwds = false,
> +       },
> +},
>
>  };
>
> --
> 2.30.2
>
