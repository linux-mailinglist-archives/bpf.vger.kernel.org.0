Return-Path: <bpf+bounces-46108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495889E4571
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 21:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAD7169177
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3071F03D1;
	Wed,  4 Dec 2024 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIIldsYj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE03154433
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343132; cv=none; b=CVNVx4yo9RB6870LJh1oZA/k7Rvnp+W0pDnmC6mIrw8BgcLusag/baKe+IpzHDs7PVWSAII+YQacscmIfjthWkLyWyJilx3ZF9Mf5iOIHSC42bn0mqv5AvjwYud6ZSGEv+oVwBX2sObesiEWWnRMYNUssGGuXPDeNAz0yLiADWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343132; c=relaxed/simple;
	bh=+tYABKE+9VZ7RMyRCTc+tYyfN2yVNZw/8jxpGDZTedc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PekNRqB2RVmvBKOzNYaPDpW2d76zV41S9PbOAisrktfXYDM3sQp9w9rJfEyNclbImh0YA1x4h6rAWDz9x2K82xiQQ817FXWEnTOT3A2+T+OQ3dx9ZkE3XDXbQBVhyfFqgF0HiA5eC2hkA0Nwc7W4hF4ZSSW2QbZwwyioxsDJtnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIIldsYj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215909152c5so1418865ad.3
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 12:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733343130; x=1733947930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7GBC6xfTNsIXbNlV9Qs00AxRvgqJbQsfnGWeYO27AeE=;
        b=mIIldsYjpL6sgoy3x9JbF6WtzoHZjelRKlsdT7iJbqY084n6irmrq3XVR1gb6lPAHK
         PW6Ogres96D0cvOzVQ05hCYptxvm0iR6vUu+HvfnMzjt/3cAC9rz7WJKxXAaCRypTI7r
         H3ojAUCCQqejKgfYGgemKhxO0nQHGM+Lzy7LoWyul5mp/19u1ASwCcjEzaGpDexCDsHH
         DCuUCQW3Nz+sutvz/0pqg3YQdU66A7FPsCSFkGP7DnVEkcM1GfB+skbBKUGtsba2tVms
         SZWALeEVIiAODzS0EP9eJdC0HxAmmE5hd7if0XwZ16qjyYT7sW02Ngszl2bHADOr7W+o
         EXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343130; x=1733947930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7GBC6xfTNsIXbNlV9Qs00AxRvgqJbQsfnGWeYO27AeE=;
        b=fWLFY7YEfbmswZU8pmEdkqSsf0B0y2OarvPKGJ7fCmneYF2oEns7qSF+bHf7PWoWaz
         aD1VOj8Gb8RYHOxCWKXklFdZf1SGFtTGP2NjCdPmzDQbr4TuoYBwYUmgKRBlNMGlDPTf
         IBgGEle3fplloKs00E74WQ2dMPTtrUFlc2sePtJk5mQ8O3IIwAcl7cNU1jTjvjObWLQM
         Hz0EY+EbXuebWkX7PpeBwhduJ8hNgXgCTbr8Cd852ZJGqceA7YkDnkI2IbbAZIlwSanv
         1cWy1kGqLmwOOIGHkww4JNSc4oqRCg3sPFmf70TtiMy/FiStuyEVeFA5gRnFwZXez4lO
         O4Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUSIi2ddgDWbq6FyA76ddFGJgGuGFpTHPE0IOHTxXfQ2FVIsAmGSM8VUzVC+b7MaljgLIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8LEp1cPDEHGMxaF7JtR+yYgbVAhLuKtqoqdI5LtvFL4rx7is
	H/aVnSdilGrMwrViQ5SEg7jsn75rZttqp60TfmR0jCqL1B/eqx1N
X-Gm-Gg: ASbGncuIypTV+aEhai6T+eqzB+1pBKQNwuqWzyARMtxH+OKAmLq4ymeXMHOoFpuGWXp
	llrgJFS29pf3Gjnon0I2xnvxjF7xDxWbmmRQ8xARgRdFR+mdG/BgtRrK9dVW9ol5toH3TC7ntV7
	b8yNeQtt7lyVCSASwi3i+bBmv32Al0Y5cHZRi4Hf6grQy3+KAPjhNsnXqb3/YBn4exsc6BSD5PW
	IbYZzMRBYRSYspUgoPClhyCO4/nNi+K8hoQ7u0J3bQWVTbN0s2kCL7UIaaVLXKvWT4OLuF88Mic
X-Google-Smtp-Source: AGHT+IFxYpodVK+rq3YAN1p1uS5dI4YBFBncPPJ6GOs2Uh9HBCIY7W2L+1wKhYDVuQ0XkikzC2nPxQ==
X-Received: by 2002:a17:902:e80f:b0:215:86cf:f10b with SMTP id d9443c01a7336-215bd1b453cmr113058345ad.11.1733343130152;
        Wed, 04 Dec 2024 12:12:10 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a:ab16:b297:5216:f3f1? ([2620:10d:c090:600::1:468e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21589aa5478sm61730395ad.59.2024.12.04.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:12:09 -0800 (PST)
Message-ID: <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Manu Bretelle <chantra@meta.com>,
 kernel-team@fb.com
Date: Wed, 04 Dec 2024 12:12:07 -0800
In-Reply-To: <20241204024154.21386-3-memxor@gmail.com>
References: <20241204024154.21386-1-memxor@gmail.com>
	 <20241204024154.21386-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-03 at 18:41 -0800, Kumar Kartikeya Dwivedi wrote:

[...]

> +/* r2 with offset is checked, which marks r1 with off=3D0 as non-NULL */
> +SEC("tp_btf/bpf_testmod_test_raw_tp_null")
> +__failure
> +__msg("3: (07) r2 +=3D 8                       ; R2_w=3Dtrusted_ptr_or_n=
ull_sk_buff(id=3D1,off=3D8)")
> +__msg("4: (15) if r2 =3D=3D 0x0 goto pc+2        ; R2_w=3Dtrusted_ptr_or=
_null_sk_buff(id=3D2,off=3D8)")
> +__msg("5: (bf) r1 =3D r1                       ; R1_w=3Dtrusted_ptr_sk_b=
uff()")

This looks like a bug.
'r1 !=3D 0' does not follow from 'r2 =3D=3D r1 + 8 and r2 !=3D 0'.

> +int BPF_PROG(test_raw_tp_null_copy_check_with_off, struct sk_buff *skb)
> +{
> +	asm volatile (
> +		"r1 =3D *(u64 *)(r1 +0);			\
> +		 r2 =3D r1;				\
> +		 r3 =3D 0;				\
> +		 r2 +=3D 8;				\
> +		 if r2 =3D=3D 0 goto jmp2;			\
> +		 r1 =3D r1;				\
> +		 *(u64 *)(r3 +0) =3D r3;			\
> +		 jmp2:					"
> +		::
> +		: __clobber_all
> +	);
> +	return 0;
> +}

[...]

