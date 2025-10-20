Return-Path: <bpf+bounces-71480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E567BF409C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 01:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B526F4851EF
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84846334372;
	Mon, 20 Oct 2025 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzucv1ks"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B373314DE
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003516; cv=none; b=BWi9nscJk7U9urChCbO63yfdSXE8upg4WlLSrZbPGAyJDQKAzdsWhFPtVlteeCK0iFUZhRICC1MMSeZ0FqvkxYnghpJ9smXe1Xwvi0TrT16cL2wwL7J/6XKqCXIVQ95qpcEVStUKzSeuAB8UL6Jmneac9Uh5ccsYNn5VDs1XK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003516; c=relaxed/simple;
	bh=CqhEh06XuNkc0pjwxYQXFDytCHwMWnUrOh/PWkCdkoc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSgdAm3Xity1RD6a56WyfkaS+ZtAjuSPbY/yofUsk9tVFn4mAPKiDvHHfD2LaUlFM4EZNsIB7bESkTlQVs9cea0K5U0gfi9ddCt8VOEEU0zMDTgXJ1pbH8QM5JWBhZh8LuwEPchD73zqKDEUErb0SeZW1rWCx0WBtHtaIAKAqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzucv1ks; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so4409534a91.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761003514; x=1761608314; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZM2OIoWz79ZppbI7zG4JTUhqc0vLeW/rRSnJrjJTQM=;
        b=Tzucv1ks/eQyr7S7qYZHmh2Nu8MR5SP5bYtn/Q9gx1iaVGb8WNU8oJ2YDRy3t6kGQS
         8UFY3H4TuF2cZhbzydG/xPgtwPR4l7FEN7y7XSU4gqLRtTXrPesXkYlGlz1FXuHuaB+v
         9apX9Bjc+x8wVIXuyNytA3TdFnSUppCnXifW5zc+zkQOgcw5hXRI0XlQrEGJVOCPd3F0
         INAiiF+Az25Oc4BOP/v2NvUGS3THeu3pjB0b5RCUtW6CaB7YpPTKleR2ofqpRUZAI7QS
         flI52tgg8XjHLPPkTaxVhmMjbYZN80Ms8wwgvrdkrS71isP++o3jklwLIGdSGci10uS0
         Xphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761003514; x=1761608314;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZM2OIoWz79ZppbI7zG4JTUhqc0vLeW/rRSnJrjJTQM=;
        b=Ia+SLhmiROclCeQSJRb5qedx4SYMuwlTAn+SLWNubFuDjZtHvEgOZT62dcrnpvcoAR
         RRPKXSzYCbWcDAEtr79dXYPxGn0/WfTNl2GZE1wGDRDXZEQ3bMsrs0Zzl11VlvQj+x9E
         DpFAuiJ+NfeuohmivQV+mXoKCZkca/+BkCPBgSCNCgBBrYbE4THpTIMxsWE7pBBji5mW
         2koMqSVAAQjdp57t9zWr7LofG7zf+N67ARB2qth47pvqDLjua6jU5WVdCM36j6mWSVtR
         rFTCHdFx5+TMRzpaBEvYFH9gt5O/tnaXMWmpoBLyvIIISUuFcUHzvU5zyrU7me3FRDqe
         h1dA==
X-Forwarded-Encrypted: i=1; AJvYcCXHIdtWiMxIDVst92vDcDtCi2h6IyvHv7jjYDq0uAdDgVsjtXY9kacT5yJ/GzVVJgvZRCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xGDe0B9Z/tW8sCiQdzZCYpiYlTMVLlaZqZdwbQUNZFBFzGEx
	C8TaZagpYY3tBwy4G426gSS6aITRIDeY6ti1e65ygbpWqLFYM8072+is
X-Gm-Gg: ASbGncu8U5dQ6REJqJSL7QpoE5Z0VByo8TMjhHrS598YolJRJuGfp0SKs3D/MVg1hlA
	iZjIgvwAOlvLHSQzQKPWJk8yOnIUvllSaBiIWV+dN6mTleZJCmV0c/MGcFzYlrdmZeSQKHQ5aT8
	5DdWxMD3IOWr5GM+OsMa80HszIgX+ugQB/J3jjYSo2TsHs1GPQqLBvLOq8yp1HqenpjFGPNXKFa
	OcLnloPbbDPQBmNTFMeH+DqHk4IET5ciiFRmAIMIThJZ3YfXtpKvB71JnCEt7+Nyc+BfvEqmX49
	AzRQOEOsvKOnMOhKAIMp+zRgs51OwwRZEUuqc/o0ckZgJdUSR8nJVw9PJzYjXhPBF3xabCivlx2
	ieBVPzjW70iVq7akyY5Hwxs4BIBITYtP0zN168Tl92J0ieRwo/LEAOIJkT9ORR3aexYtyKBUDHb
	COnYuNgDCs6QRjamCKc+aovBiFTw==
X-Google-Smtp-Source: AGHT+IFfNjUDX2bR4yQgbYUgnHCE1fsA2LOtCbPzsweFO95yMscNfaO7OyhYsrXB2/seyLuF/w7K4w==
X-Received: by 2002:a17:90b:5281:b0:330:a301:35f4 with SMTP id 98e67ed59e1d1-33bcf8e95dbmr20093335a91.20.1761003513779;
        Mon, 20 Oct 2025 16:38:33 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:badb:b2de:62b2:f20c? ([2620:10d:c090:500::4:1637])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de10cf5sm9083574a91.6.2025.10.20.16.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:38:33 -0700 (PDT)
Message-ID: <e6388c88bcb09404209a956e65f4d0510aa13294.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 08/10] bpf: verifier: refactor kfunc
 specialization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 20 Oct 2025 16:38:31 -0700
In-Reply-To: <20251020222538.932915-9-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
	 <20251020222538.932915-9-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 23:25 +0100, Mykyta Yatsenko wrote:

[...]

> @@ -3375,18 +3366,25 @@ static int add_kfunc_call(struct bpf_verifier_env=
 *env, u32 func_id, s16 offset)
>  			return err;
>  	}
> =20
> +	err =3D btf_distill_func_proto(&env->log, desc_btf,
> +				     func_proto, func_name,
> +				     &func_model);
> +	if (err)
> +		return err;
> +
> +	err =3D kfunc_call_imm(env, addr, func_id, &call_imm);
> +	if (err)
> +		return err;
> +

Sorry, I should have asked in v1/v2. Is there a reason to call this
function two times? In other words, it looks like doing the following
on top of your changes is sufficient and removes the need to call
kfunc_call_imm twice:

    ---- 8< -----------------------------------------

    diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
    index 0418768d13e4..f509f9e0383d 100644
    --- a/kernel/bpf/verifier.c
    +++ b/kernel/bpf/verifier.c
    @@ -3373,13 +3373,8 @@ static int add_kfunc_call(struct bpf_verifier_en=
v *env, u32 func_id, s16 offset)
            if (err)
                    return err;
    =20
    -       err =3D kfunc_call_imm(env, addr, func_id, &call_imm);
    -       if (err)
    -               return err;
    -
            desc =3D &tab->descs[tab->nr_descs++];
            desc->func_id =3D func_id;
    -       desc->imm =3D call_imm;
            desc->offset =3D offset;
            desc->addr =3D addr;
            desc->func_model =3D func_model;
    @@ -21892,8 +21887,10 @@ static int specialize_kfunc(struct bpf_verifie=
r_env *env, struct bpf_kfunc_desc
            unsigned long addr =3D 0;
            int err;
    =20
    +       addr =3D desc->addr;
    +
            if (offset) /* return if module BTF is used */
    -               return 0;
    +               goto fill_imm;
    =20
            if (bpf_dev_bound_kfunc_id(func_id)) {
                    xdp_kfunc =3D bpf_dev_bound_resolve_kfunc(prog, func_id=
);
    @@ -21922,9 +21919,7 @@ static int specialize_kfunc(struct bpf_verifier=
_env *env, struct bpf_kfunc_desc
                            addr =3D (unsigned long)bpf_dynptr_from_file_sl=
eepable;
            }
    =20
    -       if (!addr) /* Nothing to patch with */
    -               return 0;
    -
    +fill_imm:
            err =3D kfunc_call_imm(env, addr, func_id, &desc->imm);
            if (err)
                    return err;

    ----------------------------------------- >8 ----

The desc->imm field is used only from:
- kfunc_desc_cmp_by_imm_off():
  - invoked from do_misc_fixups() at the very end,
    after all specialize_kfunc() calls are done.
- bpf_jit_find_kfunc_model(), from some jits.

So, that should be safe.
Selftests are passing after this change as well.

>  	desc =3D &tab->descs[tab->nr_descs++];
>  	desc->func_id =3D func_id;
>  	desc->imm =3D call_imm;
>  	desc->offset =3D offset;
>  	desc->addr =3D addr;
> -	err =3D btf_distill_func_proto(&env->log, desc_btf,
> -				     func_proto, func_name,
> -				     &desc->func_model);
> -	if (!err)
> -		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> -		     kfunc_desc_cmp_by_id_off, NULL);
> -	return err;
> +	desc->func_model =3D func_model;
> +	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> +	     kfunc_desc_cmp_by_id_off, NULL);
> +	return 0;
>  }


[...]

