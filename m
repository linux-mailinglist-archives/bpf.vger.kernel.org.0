Return-Path: <bpf+bounces-63438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05420B0763B
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 14:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F85C4E6B17
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208332F50BC;
	Wed, 16 Jul 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MwbN2H02"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB92F509B
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670327; cv=none; b=fme+v49vON/FJL7HiPnaFN4uYKbALyDvrWZ3agO65tAZ8BmWrAKuQzXMrpAdW1EzMAiytxw361Vl6PskcGWqiqLq5GDEf/+63v9BgetMmdQxZwsadYT5kNZYAc5fSTQz2xvBpk6/ly5N1iVlIVjv0SHJbuZcWCUB2kD8s3yfdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670327; c=relaxed/simple;
	bh=BgpwLOuihvCHzD5hv6/Y9aWhLnwAwkI6lX5RYOEdsos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJwRh0HI72UGYZA0xg7qd0tCneZF6G0tkCy98dgQ5SZOgqo8MT2OGESNYzKHNrXgDDMVLN4mi9+AfYh3bkgqN9PEgSBmPD2SbadxJ9je7tVLzGSWBUHAM0LIpzNhCJuPlubqfXNGsujgAYaYB/f/r/bSimZO9IMw6wZdRbc0Ccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MwbN2H02; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752670312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgpwLOuihvCHzD5hv6/Y9aWhLnwAwkI6lX5RYOEdsos=;
	b=MwbN2H02kuOq6xWkkFbFgvMPh71sN/iHa3P4q4qOvdn8oX8obtjqKLTxHgmmqoOLPZKGMq
	JJMzH1GOXVjOU2FVLn6HV0XA+h0B8/HnQq+W9kGUHQpn9K9aFEmSRgw//IMakuAdyiVm2V
	SOfE+7EWr/B+OmEveeSI71reFSayI2w=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com,
 rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 06/18] bpf: tracing: add support to record and check
 the accessed args
Date: Wed, 16 Jul 2025 20:50:44 +0800
Message-ID: <2067709.yKVeVyVuyW@7940hx>
In-Reply-To:
 <CAEf4BzYXy7GOnFwPWA+-Vn9oOSJ7m--KMBBsZPw8-tx=0rbAdA@mail.gmail.com>
References:
 <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <0027bec0-e10f-4c7d-9a56-1c9be7737f6a@linux.dev>
 <CAEf4BzYXy7GOnFwPWA+-Vn9oOSJ7m--KMBBsZPw8-tx=0rbAdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2241665.OBFZWjSADL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart2241665.OBFZWjSADL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Jul 2025 20:50:44 +0800
Message-ID: <2067709.yKVeVyVuyW@7940hx>
MIME-Version: 1.0

On Wednesday, July 16, 2025 1:11 AM Andrii Nakryiko <andrii.nakryiko@gmail.=
com> write:
> On Mon, Jul 14, 2025 at 4:45=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> >
> > On 2025/7/15 06:07, Andrii Nakryiko wrote:
> > > On Thu, Jul 3, 2025 at 5:20=E2=80=AFAM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >> In this commit, we add the 'accessed_args' field to struct bpf_prog_=
aux,
> > >> which is used to record the accessed index of the function args in
> > >> btf_ctx_access().
> > > Do we need to bother giving access to arguments through direct ctx[i]
> > > access for these multi-fentry/fexit programs? We have
> > > bpf_get_func_arg_cnt() and bpf_get_func_arg() which can be used to get
> > > any given argument at runtime.
> >
> >
> > Hi Andrii. This commit is not for that purpose. We remember all the acc=
essed
> > args to bpf_prog_aux->accessed_args. And when we attach the tracing-mul=
ti
> > prog to the kernel functions, we will check if the accessed arguments a=
re
> > consistent between all the target functions.
> >
> > The bpf_prog_aux->accessed_args will be used in
> > https://lore.kernel.org/bpf/20250703121521.1874196-12-dongml2@chinatele=
com.cn/
> >
> > in bpf_tracing_check_multi() to do such checking.
> >
> > With such checking, the target functions don't need to have
> > the same prototype, which makes tracing-multi more flexible.
>=20
> Yeah, and my point is why even track this at verifier level. If we
> don't allow direct ctx[i] access and only access arguments through
> bpf_get_func_arg(), we can check actual number of arguments at runtime
> and if program is trying to access something that's not there, we'll
> just return error code, so user can handle this generically.
>=20
> I'm just not sure if there is a need to do anything more than that.

This commit is for the ctx[i] direct access, and we can use
bpf_core_cast() instead, as you said in
https://lore.kernel.org/bpf/CADxym3Zrqb6MxoV6mg4ioQMCiR+Cden9tmD5YHj8DtRFjn=
14HA@mail.gmail.com/T/#m7daa262d423c0e8bb1c7033e51099ef06180d2c5

Which means that we don't need this commit any more.



--nextPart2241665.OBFZWjSADL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEEfXselyBLFGBR0Mm8PZ2NQ5E0lkFAmh3oCQACgkQ8PZ2NQ5E
0llrzgf/bR1rHzhff7j2nQAYFvS3uMbeaEIAL9DciUYGIfc4tPPP1fp3qvz8mE+y
qUeYUN8fLFbC1r0luHQxtah29hd5viz95ALNA9Ag+68Eei7wXj7wFjludDaueiLN
ipnQIIDvduK5K+ogqPyWD6cV5Dl2FWeWLBG2F57PIzNBJ2P9fCnpDmd9kM97OvWX
ZCfnud6yMAJXPTIQTa+TcBCgMj5BgEOEHgpKbagsu9pOmM9hIhHPUa7GyMmx8lLS
MkoqgEWpKr2Vs/gtafrzHIII0R+KCaT57jYPwcuo5SCLjEQuqf7ez0NxzWI7f9Dx
yUcxNEyMUHBGT1HDO7q20XQLnA0N8A==
=Unak
-----END PGP SIGNATURE-----

--nextPart2241665.OBFZWjSADL--




