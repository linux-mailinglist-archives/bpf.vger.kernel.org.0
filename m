Return-Path: <bpf+bounces-49997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB63A2157C
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D41639DC
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC330155316;
	Wed, 29 Jan 2025 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWyKVFqW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64C43166;
	Wed, 29 Jan 2025 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109973; cv=none; b=nG0ARTCw10D1ZUkG1WELO5uJO464NO+PaQ6J98yUq6+FKfcdU+9USfHabIgT+nqZYDVMZqXXyBtNkKDsdbDbVvPhVzo9TRFNBaOPXaokLLAH1EZpJCAtvkM5VJah5k7j4MqtKwAG/pwxM0HRV4TO1uZUlJRu64oESjMIGgDvxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109973; c=relaxed/simple;
	bh=RwnxY8oUg+brKPw7SSB+K8hUynMHml/Ut1Zvlcqe4Zw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ultfjwREIvAZlOqAiSPyuzwUlCw/WuixM+wBRts09vqUlxtFNaJjTfnQO7Nv2cJXuPPPWa+K6cloH1wT41n5LIjmg/WzrcxQAcVoBWeVeZYTzAyoZUeBQE+SGeuz2XFOqdjhtXL6ToZFhEBaln4x+5UdQD+hFuruPMajVJcuF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWyKVFqW; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso8504007a91.0;
        Tue, 28 Jan 2025 16:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738109971; x=1738714771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TV7K2M6UXy/vt2SdaVfosbmTyfpXCQFAfw5jBj/4JbU=;
        b=fWyKVFqWynTBoliNkpz8bUVW1xLzioDY1b8b+Fe7VzBdjmulEOE5ou7jCkLnu3pOPh
         +Ckp7+5phLl5F/mBfDCukVvPy1S9/1LgxF41V4j4TN8g23f6HIsm525exVT0mrxkA3Nx
         myfPnpXSjwpk11Ud4RTTq/HOOIFpEr31OyZ4+NiN7NdxeikAboVYqFrhzfaZj8TErrgg
         BZsdJRkPaWOv76VYxikLFlXFXhJW17gZNVkOr1tea8uj/TIRitpoRiw/SsbroTJkPrP3
         8EF+0GBhmJfz81O12E8B55ObEtZfSdxqf/ihbPwlQ4FM4Cl9KDqPkaEmZsMDhFVSxSa3
         HuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738109971; x=1738714771;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TV7K2M6UXy/vt2SdaVfosbmTyfpXCQFAfw5jBj/4JbU=;
        b=lnWDZeoPO464HXjFrafu8yerXSfer9swuDW7h8VH+1Djy4HQr8uF1z8SOH+/1ZyOBQ
         aypQO6RFzySZb+JoH6W/gKrsfUFEILMtI3FFTSsvSeelEErXrWTDw1aekL11akKNZZT/
         Bc5067ReCfn3+eLeO/a8hWZyjoc4upUmfKI3MXoh0FCTum1O3SB9+syLAujiIqAfd+bM
         ETAgNfmyIhKHkJs5QUXfp3lrkJEuNPMAUbcP6Ockl4HqAyjDjlL9bGiJs0l0Mkwq9FJ1
         t991LKLeyJl9FEQv3yXY+K2vLgbn6VoPfb7jSr4pJuP5pIRdprcxzrYfDQXprcYbfQ4f
         LeoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu7UuSz31zo7ena5PlaHIA724ekVVLe8zbEwhY2c/ZSQWb8FA6i3FhiKh/VWzipwwQZ/o=@vger.kernel.org, AJvYcCVauFaJLF4Yy8czBJONYLFEbMYCyzP8nMobpR+IMIQHvMFXyXHeHPYp3gRjO3vLFrMlLPMOmKRIAzO+TpsM@vger.kernel.org
X-Gm-Message-State: AOJu0YyHz+vNh6L1/26MPmrKtOfY+znakGPLoouDAbixJlxXR2YNgAu7
	TMoRpMteUSSHx6l+VCPnKkhuIfhXJ1YneThhbkrbQP0/p2cbMTAc
X-Gm-Gg: ASbGnctoE67MG/r1wwDnFsVAR9gMIyW34hc71rfahnQDN/JzlRRVE1r0K5Xtjnu2fUw
	Ej/TvLWpbolyLbywOlgb4nISZd87DTIoyhAK4LbzNv5R5WOUU1bhybErDUDXntvky8aIRCk7HS9
	tWz8uVvs5XdTA5wqETtMjILSn0mGPHE0ueoEVD6VTxSCvCNVCbHvnUc9VYm0VyDMGeMNA+Vtj2v
	blIDdIJtUYRH5AnHnOQYhQ4yMqfP0o38VFD1+G/ghMtcydmH/EoY0qD9UurZyIYc0IJoGs2jg5+
	fav4D1IyjhLK
X-Google-Smtp-Source: AGHT+IGKt1S5KeBlhL++I8/Sk0F6dSfkbtLXLddGw22U8KsVqKlk04Nk/VftS8R3tTTxvXKf7WotjA==
X-Received: by 2002:a17:90b:50cf:b0:2ef:114d:7bf8 with SMTP id 98e67ed59e1d1-2f83ab8bb05mr1462857a91.6.1738109970782;
        Tue, 28 Jan 2025 16:19:30 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424ec12sm87428425ad.236.2025.01.28.16.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 16:19:30 -0800 (PST)
Message-ID: <b7de0135f7dcca0485ce9dc853d6ca812c30244b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Introduce load-acquire and
 store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, David Vernet	
 <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet	
 <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan	
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon	 <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko	
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Josh Don
 <joshdon@google.com>,  Barret Rhoden <brho@google.com>, Neel Natu
 <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	linux-kernel@vger.kernel.org
Date: Tue, 28 Jan 2025 16:19:25 -0800
In-Reply-To: <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
	 <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-01-25 at 02:18 +0000, Peilin Ye wrote:
> Introduce BPF instructions with load-acquire and store-release
> semantics, as discussed in [1].  The following new flags are defined:
>=20
>   BPF_ATOMIC_LOAD         0x10
>   BPF_ATOMIC_STORE        0x20
>   BPF_ATOMIC_TYPE(imm)    ((imm) & 0xf0)
>=20
>   BPF_RELAXED        0x0
>   BPF_ACQUIRE        0x1
>   BPF_RELEASE        0x2
>   BPF_ACQ_REL        0x3
>   BPF_SEQ_CST        0x4
>=20
>   BPF_LOAD_ACQ       (BPF_ATOMIC_LOAD | BPF_ACQUIRE)
>   BPF_STORE_REL      (BPF_ATOMIC_STORE | BPF_RELEASE)
>=20
> A "load-acquire" is a BPF_STX | BPF_ATOMIC instruction with the 'imm'
> field set to BPF_LOAD_ACQ (0x11).
>=20
> Similarly, a "store-release" is a BPF_STX | BPF_ATOMIC instruction with
> the 'imm' field set to BPF_STORE_REL (0x22).
>=20
> Unlike existing atomic operations that only support BPF_W (32-bit) and
> BPF_DW (64-bit) size modifiers, load-acquires and store-releases also
> support BPF_B (8-bit) and BPF_H (16-bit).  An 8- or 16-bit load-acquire
> zero-extends the value before writing it to a 32-bit register, just like
> ARM64 instruction LDARH and friends.
>=20
> As an example, consider the following 64-bit load-acquire BPF
> instruction:
>=20
>   db 10 00 00 11 00 00 00  r0 =3D load_acquire((u64 *)(r1 + 0x0))
>=20
>   opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
>   imm (0x00000011): BPF_LOAD_ACQ
>=20
> Similarly, a 16-bit BPF store-release:
>=20
>   cb 21 00 00 22 00 00 00  store_release((u16 *)(r1 + 0x0), w2)
>=20
>   opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
>   imm (0x00000022): BPF_STORE_REL
>=20
> [1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.=
com/
>=20
> Signed-off-by: Peilin Ye <yepeilin@google.com>
> ---

I think bpf_jit_supports_insn() in arch/{x86,s390}/net/bpf_jit_comp.c
need an update, as both would accept BPF_LOAD_ACQ/BPF_STORE_REL at the
moment.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +static int check_atomic_load(struct bpf_verifier_env *env, int insn_idx,
> +			     struct bpf_insn *insn)
> +{
> +	struct bpf_reg_state *regs =3D cur_regs(env);
> +	int err;
> +
> +	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
> +	if (err)
> +		return err;
> +
> +	err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
> +	if (err)
> +		return err;
> +
> +	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
> +		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
> +			insn->src_reg,
> +			reg_type_str(env, reg_state(env, insn->src_reg)->type));
> +		return -EACCES;
> +	}
> +
> +	if (is_arena_reg(env, insn->src_reg)) {
> +		err =3D save_aux_ptr_type(env, PTR_TO_ARENA, false);
> +		if (err)
> +			return err;

Nit: this and the next function look very similar to processing of
     generic load and store in do_check(). Maybe extract that code
     as an auxiliary function and call it in both places?
     The only major difference is is_arena_reg() check guarding
     save_aux_ptr_type(), but I think it is ok to do save_aux_ptr_type
     unconditionally. Fwiw, the code would be a bit simpler,
     just spent half an hour convincing myself that such conditional handli=
ng
     is not an error. Wdyt?

> +	}
> +
> +	/* Check whether we can read the memory. */
> +	err =3D check_mem_access(env, insn_idx, insn->src_reg, insn->off,
> +			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
> +			       true, false);
> +	if (err)
> +		return err;
> +
> +	err =3D reg_bounds_sanity_check(env, &regs[insn->dst_reg], "atomic_load=
");
> +	if (err)
> +		return err;
> +	return 0;
> +}
> +
> +static int check_atomic_store(struct bpf_verifier_env *env, int insn_idx=
,
> +			      struct bpf_insn *insn)
> +{
> +	int err;
> +
> +	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
> +	if (err)
> +		return err;
> +
> +	err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
> +	if (err)
> +		return err;
> +
> +	if (is_pointer_value(env, insn->src_reg)) {
> +		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
> +		return -EACCES;
> +	}
> +
> +	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
> +		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
> +			insn->dst_reg,
> +			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
> +		return -EACCES;
> +	}
> +
> +	if (is_arena_reg(env, insn->dst_reg)) {
> +		err =3D save_aux_ptr_type(env, PTR_TO_ARENA, false);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* Check whether we can write into the memory. */
> +	err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> +			       BPF_SIZE(insn->code), BPF_WRITE, insn->src_reg,
> +			       true, false);
> +	if (err)
> +		return err;
> +	return 0;
> +}
> +

[...]


