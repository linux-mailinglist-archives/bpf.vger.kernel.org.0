Return-Path: <bpf+bounces-2444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875972CFE2
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 21:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69E2281103
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BFFBE61;
	Mon, 12 Jun 2023 19:56:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C3BA38
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 19:56:23 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF90102
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:56:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9741caaf9d4so696723666b.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686599781; x=1689191781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghPws8NgqBv0Nsd0Mn2zZ8GgkOk0ygXI8j71utRis0M=;
        b=bZXqdfLRGa0o/xlE0Hz6mc1WcfqKl+Sy+RuwFxSnLBsrx9rU8u7eg417spseMnpX1q
         pkDd8ANzdfSOuPBpg3XziIuTOTdhzkLybw5hW6tkHOOOYgegVpREcMSRzXm0sN1k378N
         8tjBnZz/xKhWJzRHUfc3gjNhPCtBlVrFhK/uvVi2P9z87mB1K8s/3PRFiWTZsbaVh1CD
         eHzvL8ZyOwmtioPGhzrGx3nyY1D5FZ0W2t0F8gMtWcHh9+El0D21z9I2MxgjmNZrxj5y
         mGLnNeq2xukTZnldv1HxjWwCYBl3U3dBiYGYm1Ad0DJeg0jD4TY50XklJa/bsd9IMmVI
         Phsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686599781; x=1689191781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghPws8NgqBv0Nsd0Mn2zZ8GgkOk0ygXI8j71utRis0M=;
        b=E0nHeoXlfFDxNZ5+6QphdHPtQd23l/eV087Uwh0NUGJ77OH6m/S9ei2UUWIMpXdi5F
         MQndLiF6Su2JjfVUGatZo5L5zPNAz+AMoQH05HEg6pWwSe1s1MQndMxoo9MZ+S41+FJM
         7wi/q0hh6mVSyesTJxEZUJjgiahSQdta6NgWhOoC1VyAdZvrWybol/CZGfeApoSbTkMD
         ApuPDdxbLeqtvuC7RkhpCf6o4tK7gBUhhI9FUuFeLc7CiVAmJrS7qw2faVuxDQyJOExa
         L2Jv/3BQVnVTA5Kzr6ebfS2JIxSr83PdmtrJaf2ATiQfJVxTAi2isQAZDhes6bchVtts
         KLCQ==
X-Gm-Message-State: AC+VfDxSJY8boXhTMj4KcZAWl37XEFG4vPjcfNoCDta8f1A5YDsa/7gq
	hwMnNGUwonufiXUPYrLK78ePcIyyxjZ8lntH9dM=
X-Google-Smtp-Source: ACHHUZ6JSedz5EjwGUJ9vQhbkOraV6KPwTJml4RzOu+I/WktP9t+N/X8z4UlcT/Lx+tQgKyGGhl0gJAPrEbHQERUpSg=
X-Received: by 2002:a17:907:3603:b0:96a:19d8:f082 with SMTP id
 bk3-20020a170907360300b0096a19d8f082mr10457953ejc.25.1686599780711; Mon, 12
 Jun 2023 12:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612160801.2804666-1-eddyz87@gmail.com> <20230612160801.2804666-2-eddyz87@gmail.com>
In-Reply-To: <20230612160801.2804666-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jun 2023 12:56:09 -0700
Message-ID: <CAEf4BzbwWy1KLp3KyL3VS6-ZF13mdNyYZvCVvTyAoZ6ZiWXHjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: use scalar ids in mark_chain_precision()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 9:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Change mark_chain_precision() to track precision in situations
> like below:
>
>     r2 =3D unknown value
>     ...
>   --- state #0 ---
>     ...
>     r1 =3D r2                 // r1 and r2 now share the same ID
>     ...
>   --- state #1 {r1.id =3D A, r2.id =3D A} ---
>     ...
>     if (r2 > 10) goto exit; // find_equal_scalars() assigns range to r1
>     ...
>   --- state #2 {r1.id =3D A, r2.id =3D A} ---
>     r3 =3D r10
>     r3 +=3D r1                // need to mark both r1 and r2
>
> At the beginning of the processing of each state, ensure that if a
> register with a scalar ID is marked as precise, all registers sharing
> this ID are also marked as precise.
>
> This property would be used by a follow-up change in regsafe().
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |  10 +-
>  kernel/bpf/verifier.c                         | 115 ++++++++++++++++++
>  .../testing/selftests/bpf/verifier/precise.c  |   8 +-
>  3 files changed, 128 insertions(+), 5 deletions(-)
>

[...]

> +static bool idset_contains(struct bpf_idset *s, u32 id)
> +{
> +       u32 i;
> +
> +       for (i =3D 0; i < s->count; ++i)
> +               if (s->ids[i] =3D=3D id)
> +                       return true;
> +
> +       return false;
> +}
> +
> +static int idset_push(struct bpf_idset *s, u32 id)
> +{
> +       if (WARN_ON_ONCE(s->count >=3D ARRAY_SIZE(s->ids)))
> +               return -1;

minor, but should be -EFAULT as well


> +       s->ids[s->count++] =3D id;
> +       return 0;
> +}
> +
> +static void idset_reset(struct bpf_idset *s)
> +{
> +       s->count =3D 0;
> +}
> +

[...]

