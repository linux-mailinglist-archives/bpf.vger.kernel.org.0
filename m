Return-Path: <bpf+bounces-37819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF0B95AC98
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 06:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF184283555
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 04:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69803B79C;
	Thu, 22 Aug 2024 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLqh9cxp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D77208A7
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300975; cv=none; b=tgf5kyjqkMjvu2g3NIU+xVpEuWZS0psjTqoxWADA9NMyOM802JMct7NcE+6Jmlqfj+zJ/7adV88ibeO7qsrOgH/L6/RVCOio6jL0TeUUxfSEVVzKdNNJ94qeIBL3w5owm7XWoMyWTcAwD41mvFfCL8+SuRqe/3IADSl5I94h/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300975; c=relaxed/simple;
	bh=Dg+QTtdTCpcElMbBUJtWQ9kCUgSvDzZA0C79JL80nQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vsc1o/IL0t1KARZHL6jiFDb2X6ioQEcK0SQ7LN4o2QLTupzian0fhXdVkMz9AekO8hlvqhwoXzaaD0jPDBNGvhsti1PR2ia6FH1ZjZuvn9dmCyR4nzZyOqnkycP5ecU7MXLxV49knvnBxoxnxCXVcLhwL46xNbPKP84NsKcUGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLqh9cxp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2023dd9b86aso3164635ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724300973; x=1724905773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxCqpLyVevfmp3bH2jn7QBU048ftTNt7E9UYzV+rSjs=;
        b=nLqh9cxpZ9UYAJE4xtTYvBWJZekLjuqbQ4ZLpgg0zO78kh8lTIOS9ZNaipjcv+V9qq
         qSYkYK2NI1SUaHzndi2XOSe1+8sfwa+cq1TQ6egKrkR0LuQw+7kXQN4YgcRCMa4Tq4XA
         lKrBz4DHgN8nMmJ9OGSm8UEsMA9Q3Hdy9ygqXlgC4hnP5ubetUuQgSUlqBL4JfEOxYWa
         jGXjgH75yWk4LnWx7ugGZc8mafeZSzI0HY8Z5uVAy3e34iFYU9WnNjP7FOrOcsTuWi+Z
         7SmzG8R4isbhK2NKMWLdK5vbbNpT2Ge+FvnAcdn8lVxUMWN+MmAY35oxhbAPokc5Ff+x
         BW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724300973; x=1724905773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxCqpLyVevfmp3bH2jn7QBU048ftTNt7E9UYzV+rSjs=;
        b=DvQqtJv7Rc8I7hpzQPCO2cuboYjDm7XwKx2PkDd4AJbcqXsPeekM6cHUWmMNg5Pu6A
         8Rwit3s845uAJt9B1KYZvvTC1aYCGde8cduIgyHi+fM1VUeyCeRDBc0wAh92QNUEIjZf
         BRHErZdCfQQlEuqf5DW5hd2IKfdB9m4e1d2kJR0cgXVBHT4Rk709+HyCKvm5voSecaUJ
         0992grI2Zt/rcCJ/JPZxyoO5b2m/CEWUWPR0/eCfA0vdEvP+BbAKAAJi7PvO68BJs9rC
         YZZF+BcVVO8h22VcyHieqjRkPcbi7gvd72EfVfe2qmT+TS+8+Lfh5ebamQ31cn6SjNS6
         UMdw==
X-Gm-Message-State: AOJu0Yz1xIuFP/il2jKmSX+MV4xn1PvCK4OR+4Nhj10VTCSUyBRFehbs
	ou7HhojAQrxrhdzq9st97UCl/4udxLaWhkN21K87oMDML44luATl5BLe+hH1ReCSBvmATWCQvK/
	ocE8ISQa/EkVjMYCDo4k2sGjnxAE=
X-Google-Smtp-Source: AGHT+IFQ2LThW2FI5mydxpMzBYWsPuQwbpz4K4huX+QMoQbt6wDf8UtvfIl/dIoQZhP3mXebEQHnvnxTd7kXr1THKQ0=
X-Received: by 2002:a17:90b:30d2:b0:2c9:923e:faf1 with SMTP id
 98e67ed59e1d1-2d616b278ebmr819717a91.18.1724300973068; Wed, 21 Aug 2024
 21:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822001837.2715909-1-eddyz87@gmail.com> <20240822001837.2715909-2-eddyz87@gmail.com>
In-Reply-To: <20240822001837.2715909-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Aug 2024 21:29:21 -0700
Message-ID: <CAEf4BzbX8J_inHVJOFHaXYcaN-xcCyjv1FsvRmvtTqt+FJp8Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: correctly handle malformed
 BPF_CORE_TYPE_ID_LOCAL relos
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cnitlrt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> In case of malformed relocation record of kind BPF_CORE_TYPE_ID_LOCAL
> referencing a non-existing BTF type, function bpf_core_calc_relo_insn
> would cause a null pointer deference.
>
> Fix this by adding a proper check upper in call stack, as malformed
> relocation records could be passed from user space.
>
> Simplest reproducer is a program:
>
>     r0 =3D 0
>     exit
>
> With a single relocation record:
>
>     .insn_off =3D 0,          /* patch first instruction */
>     .type_id =3D 100500,      /* this type id does not exist */
>     .access_str_off =3D 6,    /* offset of string "0" */
>     .kind =3D BPF_CORE_TYPE_ID_LOCAL,
>
> See the link for original reproducer or next commit for a test case.
>
> Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_type_by_=
id().")
> Reported-by: Liu RuiTong <cnitlrt@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X=
3Y9+p0sWzipFSA@mail.gmail.com/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/btf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b12db397303e..e38e770a6945 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8888,6 +8888,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const =
struct bpf_core_relo *relo,
>         struct bpf_core_cand_list cands =3D {};
>         struct bpf_core_relo_res targ_res;
>         struct bpf_core_spec *specs;
> +       const struct btf_type *type;
>         int err;
>
>         /* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:=
5"
> @@ -8897,6 +8898,13 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const=
 struct bpf_core_relo *relo,
>         if (!specs)
>                 return -ENOMEM;
>
> +       type =3D btf_type_by_id(ctx->btf, relo->type_id);
> +       if (!type) {
> +               bpf_log(ctx->log, "relo #%u: bad type id %u\n",
> +                       relo_idx, relo->type_id);
> +               return -EINVAL;
> +       }
> +
>         if (need_cands) {
>                 struct bpf_cand_cache *cc;
>                 int i;
> --
> 2.45.2
>

