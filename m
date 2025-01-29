Return-Path: <bpf+bounces-50072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B5A22657
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 23:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31CD1885637
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 22:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7C51F2383;
	Wed, 29 Jan 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUp7KDJg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB41F1303;
	Wed, 29 Jan 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738190569; cv=none; b=D6Sf1O3lJTUdBtO4JMxE7ytDJSQYmflmIjRwRCreTnt3iyl+uuhye8qoF8Goe8dfKUTkrnY0tNLMhZthGAZL4g7hVdbbbOLJuwXLkJA2U0hvGiTEYeyQOYthAaRK7pOyxwC2aziCHw21Fwla72VjUJkHTV6kzvRg6RgYCwTUs+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738190569; c=relaxed/simple;
	bh=P08uyosPsMS7AKe1KO7RmlRnm6XNVqcj6fodU78tH5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHaVAeXqJPmvx1qwNNLqdX8I2MfBiFu1oAGqzqORczn+1LRYvDCZj2AwndUnWrIJ7SLt7cVMhBHvyjK2ewzbwH4pgq7U/xlrzsXli2ZtcwHa3/FMibLtsoLgs9H4z8khnuLFXW36keNfPviBc+93sdGWZeHL6U7LQHbCqfpiPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUp7KDJg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21bc1512a63so2671665ad.1;
        Wed, 29 Jan 2025 14:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738190567; x=1738795367; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N0BJFYEwW/5oCHFzaoG43elXSgU0vy+kvkYStyX0AOw=;
        b=WUp7KDJg9+UBXR39WDVHN56tHVTYQco+CPfR/I9v9wGukFe/CkWDlXvFL0mES2rQFO
         yYF0EyXLJzZur0SsAKP7i1uGM9f6aQNtlBDnIhBWKiGApo+JfghxN4WzTo8LNwQQ3fkt
         i7gR9qO/y8FnGg9VW1Vkjn3SsFIGfj1tqrdOs5jDT3Y/uP9cLS7T3UALqd4yaCKSCpZD
         B84GIauyhJXFpFgzQHmffjmkWlOJuMYRs6lsKc0bQoGVWafoYBb0fkdaACTOQFTbsmx7
         A+tJ1qlLKO4GoxYA5Ii30xi6+6CDUJsKaiEXyi8ASHsibHZRpa3AkC2HAZdzg2ODEH5B
         Knpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738190567; x=1738795367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0BJFYEwW/5oCHFzaoG43elXSgU0vy+kvkYStyX0AOw=;
        b=e4KvPX/QGWIc2RgUJWWNy7sXQEuyYJw35dHotdjF9lgEeEI4oGqDVPTSYGmsp7MlxL
         GOl+N/psqjXHfHU4afbZAPhkcief7HsVsJBBzvJA7gKLhnr4PUOZpLr1hIm3IlXpl7wx
         ZoimeATVxvEMdBZxn9e4plLW8WfIetHYm+a87OVO81NVdkFkRZxNolG1f23Mgi7E8Ygn
         iFExJOTOJ6veMIdOeaCqHX1xf9lZlCWR3A8WVtLxqR9GS1Vcd60ylHIV6nwfSUhcY0in
         /YFMBCnbyFIhwhSL+iUBKFwX2nOL6UzKCxV9CQo+Z9PkrxDKHqcOLlxOaQfp8ajY+OF1
         Q0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcPFzQ7L99Y+FCf2TDXrnrZsOw1640GSfHgvvJenB+lpoXZsXT0pbHgM/7tnUQsGxGjFXGlCqMM1f2YEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyxbRqdYs8o7iwzE09ggou9FQG6iEvJ2iqJPdjKBG/Rggj6sXG
	0jHwusButSlGEgegMh/iNeHr9bXlb4du5TzyoxFyrB8+9JewNFI5
X-Gm-Gg: ASbGncunZueT2ZX5GKUD5aNBQIMT7BeyXGicgoe2x8Y9/SNQYZ/zD7RAyiWSHOQfCyi
	yv+GOoE0ugxDYPMgzpIIgtevC5B4ok5zGhuoWA/VyrdvdrH0IuwHV+BteUhnDW1WfFqHpfcfBbX
	8JbETbftBb5hiRaH8kjJlx1Q+eNKsBAfdxgg3tK2dkICgwTP3P954golLRTCoXOtWaalwtsgV2g
	TX5j8TCeNsYkQiCFKGhGIg/HrttZdECpT6rGlqdDrRS/A8q+XxgxDDPQGp9jkHGLTGIoXoSKiPs
	xofAXtu6512o
X-Google-Smtp-Source: AGHT+IFe30LvAymnAmLt+ROpt7EhCRkis7bvw/dwChPa5P5DtQ/ENlt+OND9lffByLftnvxHGQKqwg==
X-Received: by 2002:a05:6a21:1394:b0:1e0:e07f:2f01 with SMTP id adf61e73a8af0-1ed7a337c5fmr8174960637.0.1738190567122;
        Wed, 29 Jan 2025 14:42:47 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe03f4e7bsm773852b3a.172.2025.01.29.14.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 14:42:46 -0800 (PST)
Message-ID: <da01f44bb1f3463515574796c3ac139bbbf7b4dc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Introduce load-acquire and
 store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
  Xu Kuohai <xukuohai@huaweicloud.com>, David Vernet <void@manifault.com>,
 Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend	 <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Jonathan Corbet	
 <corbet@lwn.net>, "Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan	
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon	 <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko	
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Josh Don
 <joshdon@google.com>,  Barret Rhoden <brho@google.com>, Neel Natu
 <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	linux-kernel@vger.kernel.org
Date: Wed, 29 Jan 2025 14:42:41 -0800
In-Reply-To: <Z5qmBaGE4a7NtaFU@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
	 <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
	 <b7de0135f7dcca0485ce9dc853d6ca812c30244b.camel@gmail.com>
	 <Z5qmBaGE4a7NtaFU@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-29 at 22:04 +0000, Peilin Ye wrote:

[...]

> > > +static int check_atomic_load(struct bpf_verifier_env *env, int insn_=
idx,
> > > +			     struct bpf_insn *insn)
> > > +{
> > > +	struct bpf_reg_state *regs =3D cur_regs(env);
> > > +	int err;
> > > +
> > > +	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
> > > +		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
> > > +			insn->src_reg,
> > > +			reg_type_str(env, reg_state(env, insn->src_reg)->type));
> > > +		return -EACCES;
> > > +	}
> > > +
> > > +	if (is_arena_reg(env, insn->src_reg)) {
> > > +		err =3D save_aux_ptr_type(env, PTR_TO_ARENA, false);
> > > +		if (err)
> > > +			return err;
> >=20
> > Nit: this and the next function look very similar to processing of
> >      generic load and store in do_check(). Maybe extract that code
> >      as an auxiliary function and call it in both places?
>=20
> Sure, I agree that they look a bit repetitive.
>=20
> >      The only major difference is is_arena_reg() check guarding
> >      save_aux_ptr_type(), but I think it is ok to do save_aux_ptr_type
> >      unconditionally. Fwiw, the code would be a bit simpler,
> >      just spent half an hour convincing myself that such conditional ha=
ndling
> >      is not an error. Wdyt?
>=20
> :-O
>=20
> Thanks a lot for that; would you mind sharing a bit more on how you
> reasoned about it (i.e., why is it OK to save_aux_ptr_type()
> unconditionally) ?

Well, save_aux_ptr_type() does two things:
- if there is no env->insn_aux_data[env->insn_idx].ptr_type associated
  with the instruction it saves one;
- if there is .ptr_type, it checks if a new one is compatible and
  errors out if it's not.

The .ptr_type is used in convert_ctx_accesses() to rewrite access
instruction (STX/LDX, atomic or not) in a way specific to pointer
type.

So, doing save_aux_ptr_type() conditionally is already sketchy,
as there is a risk to miss if some instruction is used in a context
where pointer type requires different rewrites.

convert_ctx_accesses() rewrites instruction for pointer following
types:
- PTR_TO_CTX
- PTR_TO_SOCKET
- PTR_TO_SOCK_COMMON
- PTR_TO_TCP_SOCK
- PTR_TO_XDP_SOCK
- PTR_TO_BTF_ID
- PTR_TO_ARENA

atomic_ptr_type_ok() allows the following pointer types:
- CONST_PTR_TO_MAP
- PTR_TO_MAP_VALUE
- PTR_TO_MAP_KEY
- PTR_TO_STACK
- PTR_TO_BTF_ID
- PTR_TO_MEM
- PTR_TO_ARENA
- PTR_TO_BUF
- PTR_TO_FUNC
- CONST_PTR_TO_DYNPTR

One has to check rewrites applied by convert_ctx_accesses() to atomic
instructions to reason about correctness of the conditional
save_aux_ptr_type() call.

If is_arena_reg() guard is removed from save_aux_ptr_type() we risk to
reject programs that do atomic load/store where same instruction is
used to modify a pointer that can be either of the above types.
I speculate that this is not the problem, as do_check() processing for
BPF_STX/BPF_LDX already calls save_aux_ptr_type() unconditionally.

[...]


