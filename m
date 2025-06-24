Return-Path: <bpf+bounces-61447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0A7AE71EE
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF63AC8FA
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3625B2EB;
	Tue, 24 Jun 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpZJ/ilS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52D25A63D
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802382; cv=none; b=GxWHteoSjmPDQSpNHXoHKzvTeWrxOwyXCKwwyYDTLMtnxrLj6TkLliH/LHe+b+wP74fohPQdYg1q1dGI3RS/EOm0JSrzqfnWjJOFi2YzOIrR22uReyPE5ul11sBVU7IeWsxJ8O0xvbhTTXlA9ZA6JyewS4BMWuJQx6DuLY6unIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802382; c=relaxed/simple;
	bh=VeUGsJ00DVcZJb07ICLOSrMjWbNUkhEnyrXcMPvMhgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imrCNU1DYGKfGAzQnaM7eMuyuaWymumhQHPfWqMVdeHIXV7pRQHHgWey17LeGANBPWp0sJViL66BlILmn8CEXcYGRiqlXx/bCv1kd5+x9OMOjrQawqUNGOGI5rXKw7pdqD4imgIsBuYFqiusA8NK7359duk55Bxc6wQwdlD5K8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpZJ/ilS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a5123c1533so3036211f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750802379; x=1751407179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTuaCRjS54zin0b+PorqeaeBtGv/UqSREklizsbJCUI=;
        b=IpZJ/ilSM8FH4FV/mbVi4inbziMmmahRpSCxBUmnqRuQELjJ3EXVqA0RZCWiYQfbJv
         uweu1jBX75LhDi8cGORQo+Uj1z7gaYa13OlpD0h/g55f4pJrlGTseeip0XAh/EGYXMTk
         q/rKdG1g5oGDyJLSMpRHqauEmcGzyHhwYPdcpITpD71tBW4NkxU/yDADhfmry9efa8cH
         JuPKOQ+C+mDENR0ESjncLGUpVPlDigGBoYiNbfjYKWXfX8C3rzp2z3NTQp7UElxnNhm1
         t7W4Oalk90+sIDTBxt0qNMaX+R8DwMv9ukKl4fOG5KXtDAbA4xwCtT+t20lMesgEyk7s
         TNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750802379; x=1751407179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTuaCRjS54zin0b+PorqeaeBtGv/UqSREklizsbJCUI=;
        b=Ca+qVob8+ItoyXG027S1VyHRn224V6Ez1ezXTlN4yE5hNKfLe58TTxav0LxJ3Iks8g
         dnQ1VIf7USZj6tELr/Wuar5cV+OmVY1faoDu+27HEJsrYRu7Xbnn++uPPTimPTG20+cU
         UQMrITNkWJ3NB8a7fjyP5u7212hVPmwb3ub4X81gMCTHHktaEltZaYm9VQ1d4hTGFp40
         PonPKuX+2UuTUs0Ts0F2A5BijXj94eo8ym7c961JLENVHbp3bBsbqlE6ID0r2xCj1jOw
         /f0jMMR/pqP+ivhbkGLo5m3QwwgTdNDFRuD+l9WIDgkPl/BL0nQVjv1nKc5jM57qWvZp
         PgFQ==
X-Gm-Message-State: AOJu0YxTR8WxsVuG3qdwQQt8xkjYmSIeSTWyhpXbZa07CEJyYkV+iyBs
	DY05qK0sRMcDZQr63d48jpozDDOJl4jU31DzMvLun2SOFQzh88Xqbq131GjJ7c4tHVVH//BD+ir
	RMw0/0+lYvL/rNUz5etZx8PiSyDyRO3A=
X-Gm-Gg: ASbGncthsyajoySB8zUT1z1FjAkfGUjcyGDZR+jtN1qi5sV6Td1mK5x1qlVnwReN+Kv
	hCwMV3xlVUSNQKJKU0cbBh/TMxV7SFJkhvl7d8iZWzn4/yh/4/onbEMEtomCGl4fs78xwqsUkL/
	29jlnwQBMXRQwKOwWC6na4TudxtNZbK5DQsPEqxcqDxd7B8b42QRNtzlSkAmOzc2b2bHYVm68M
X-Google-Smtp-Source: AGHT+IHjvXx5ld27CKNAyMoEAGvSySW2JrSgKkkpfqR1zloN70QlFYaQVOBQJTldZO34/Iyc56s8Xp6l2/482DH+Y5U=
X-Received: by 2002:a05:6000:290c:b0:3a4:ebc4:45a4 with SMTP id
 ffacd0b85a97d-3a6ed5e9d53mr253622f8f.5.1750802378595; Tue, 24 Jun 2025
 14:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624191009.902874-1-eddyz87@gmail.com> <20250624191009.902874-3-eddyz87@gmail.com>
In-Reply-To: <20250624191009.902874-3-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 14:59:26 -0700
X-Gm-Features: Ac12FXwPutVjKysSpjb9pfdWdRw658bGzERrJ-m1l27tp1fogmhm-qYqTl_GkhE
Message-ID: <CAADnVQK=ML6A7OwQ4aQSgiRku83tgkKiNdAnKMYq=iDNe-7dRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: add bpf_features enum
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 12:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> This commit adds a kernel side enum for use in conjucntion with BTF
> CO-RE bpf_core_enum_value_exists. The goal of the enum is to assist
> with available BPF features detection.
>
> Support for bpf_rdonly_cast to void* is the first feature listed in
> the enum. Here is an example usage:
>
>   if (bpf_core_enum_value_exists(enum bpf_features,
>                                  BPF_FEAT_RDONLY_CAST_TO_VOID))
>      ... bpf_rdonly_cast(..., 0) ...
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8fd65eb74051..01050d1f7389 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -44,6 +44,11 @@ static const struct bpf_verifier_ops * const bpf_verif=
ier_ops[] =3D {
>  #undef BPF_LINK_TYPE
>  };
>
> +enum bpf_features {
> +       BPF_FEAT_RDONLY_CAST_TO_VOID =3D 0,
> +       BPF_FEAT_TOTAL,

I don't see the value of 'total', but not strongly against it.
But pls be consistent with __MAX_BPF_CMD, __MAX_BPF_MAP_TYPE, ...
Say, __MAX_BPF_FEAT ?


Also it's better to introduce this enum in some earlier patch,
and then always add BTF_FEAT_... to this enum
in the same patch that adds the feature to make
sure backports won't screw it up.
Another rule should be to always assign a number to it.

At the end with random backports the __MAX_BPF_FEAT
won't be accurate, but whatever.

> +};
> +
>  struct bpf_mem_alloc bpf_global_percpu_ma;
>  static bool bpf_global_percpu_ma_set;
>
> @@ -24436,6 +24441,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>         u32 log_true_size;
>         bool is_priv;
>
> +       BTF_TYPE_EMIT(enum bpf_features);
> +
>         /* no program is valid */
>         if (ARRAY_SIZE(bpf_verifier_ops) =3D=3D 0)
>                 return -EINVAL;
> --
> 2.47.1
>

