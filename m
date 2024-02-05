Return-Path: <bpf+bounces-21230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59152849DC6
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB441C22D70
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E752C6A4;
	Mon,  5 Feb 2024 15:14:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB672C848
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146072; cv=none; b=Ar3Q0i7g4fiT0cPO7kPdntg8E+DjkjrED2NLng74+DQZQtcwAPqQbyKzqF7ZlF0zdXFQ1ocmU46QI0yFPK8YtPOo9y7VWG2OKgdglqkbHwq7N3ugE30um2HjfZJ7tLZuAYm5wvZpoTFwgdM8I48UIdQnqXkgun4m52IFllwnYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146072; c=relaxed/simple;
	bh=rpO6odx9CuVnsGzirNwiUR7UtfurFjF+HC97PqMTO9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prgN4AenDjO6yhwCtGDQLCom5bSi77ELbBDasPaJyOu3mv6SOSUSAG6dVxIXNTGrQUcMvRKN2E51/f6ykurS94GbuStVdxgryf1w2dHTpI4yB+bknCmUQNbPzbm4aSw27/yoAKmp+g64MoalDy6B3tZ3auYI2+g1lMV2XrnEPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78562c1ca4dso68918985a.0
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 07:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146069; x=1707750869;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpO6odx9CuVnsGzirNwiUR7UtfurFjF+HC97PqMTO9E=;
        b=Btcf24+caeSuhn0HgK0KE1INGl6jz2CzNK/ZHio5yqfFAhRpX3dPb58iycdlzJ+GUX
         MEapCH3bU+uY3LEXyaKz97Dav9081AOk6Lc1TbHOLb6q4GR3rAKdTqL3yaqZebnw85eK
         mDM4iq9ITxpBdJ9oGS9wGMPBdbwT51unab3CG5XZlgRenS9jk3MEwRuAqtGPNgnOHXdm
         vhIXrblJgcNH2ZWye1IENv0FNE3pjSpMVCUJYoaUIjBBlf58cqFQAtnzJL9y8hT7hD1C
         z1QrBeOBGQeNzlGSgeu60B+zGJBPpfC95n/2Wv4dvwOHxLbInigxLiwr0U/piif34rz+
         4Z+w==
X-Gm-Message-State: AOJu0YwCiGrXrC2/acFX57nfiUaQiLKFwS+TcCgrARa8WvKLhFiy8Ivp
	W8SVMSmNj4/ohumrPZE1DUnhkr33WE1jxChxVfBUseeLJQx4PyIY5qcaQbyaPeIrGQ==
X-Google-Smtp-Source: AGHT+IHUjtMKMBoRlADSue60NODgHy/KoXnVhsarzidYxeB9Lgk1AheB+eA4QHhkMYbQnpRQfy6XMA==
X-Received: by 2002:a05:620a:1a27:b0:785:7d89:6b8e with SMTP id bk39-20020a05620a1a2700b007857d896b8emr4625584qkb.55.1707146069569;
        Mon, 05 Feb 2024 07:14:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGqiwJeq+pvQ6tqGAzB8C1IjTakG1lqATfW4KH6qeiMg7f9x253TcGwbITjicSR1f+S48ljGtlNrGQnO5Vkar0tmc1FELLu0IzoN8ogM6QYwVIEsMUlKgAj0aFfjSSRRvHKCLJb3P2KGvHb1pH7IzJXMqDIBFTbow3WhxF2Vm5lWgZWeEieAH801RNZk1UcqPYR/SwCeUyy+8eVS6nZiAtQ86XD1YMrFu3NvDQSyI5hPjIEx0Rz0YGhMlr2w==
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id pe42-20020a05620a852a00b007857485b628sm9820qkn.117.2024.02.05.07.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:14:28 -0800 (PST)
Date: Mon, 5 Feb 2024 09:14:26 -0600
From: David Vernet <void@manifault.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for RCU lock
 transfer between subprogs
Message-ID: <20240205151426.GF120243@maniforge>
References: <20240205055646.1112186-1-memxor@gmail.com>
 <20240205055646.1112186-3-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CPTr+kn+0b3gSHyS"
Content-Disposition: inline
In-Reply-To: <20240205055646.1112186-3-memxor@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--CPTr+kn+0b3gSHyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:56:46AM +0000, Kumar Kartikeya Dwivedi wrote:
> Add selftests covering the following cases:
> - A static or global subprog called from within a RCU read section works
> - A static subprog taking an RCU read lock which is released in caller wo=
rks
> - A static subprog releasing the caller's RCU read lock works
>=20
> Global subprogs that leave the lock in an imbalanced state will not
> work, as they are verified separately, so ensure those cases fail as
> well.
>=20
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--CPTr+kn+0b3gSHyS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcD7UgAKCRBZ5LhpZcTz
ZM1yAP0W3iWhC37IrXNaNfV3cNIynvVOJ6WHnLZJxPafUC1RGwD5AeOc0FanR1vv
WtDDJ1VjIuKMz/SqgYRlwOehkSRK2gs=
=7lnd
-----END PGP SIGNATURE-----

--CPTr+kn+0b3gSHyS--

