Return-Path: <bpf+bounces-33660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA599247D8
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A3B1F2706C
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93412E1CA;
	Tue,  2 Jul 2024 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jo2Y74lh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBPG4xjr"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240976E5ED
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947212; cv=none; b=ZdF9MH0Y2VoJvW0PmvxHYP3L98cKC1mRq/pAaWSkHAs/V77NwSIvYHH6jpQ9UgzstKxIcpvjJq6qO3Pu+a/PSuEyKEpDBWTq8POPoibaWY7mi7uYSJwvgY8Adk8AOvSin55ViVpdVTxAANrdFupT2JJW1TN31peXRqnLcBW/8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947212; c=relaxed/simple;
	bh=9oTQbPhIKrtj2CunXwJ1xKEFkcptcJJZbcDmZP1qBfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8dEJH2j29WyoDJQEn8lVSTdei80eoU9DF+2Nan8wF/6F92NduWvI2KFnN15maFePWWRhvfCpXOd6ZhXhI3RjJTKBgl2xH34z1nbb4kTrEpNInbfCp/cKF8y7Bkt4FsVfpZdZEhEkWZLV+j2bXoiwXeNzFFmdKgIefTaU9tcvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jo2Y74lh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eBPG4xjr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 2 Jul 2024 20:12:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719943956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBL/9oB2KixNpv9EdsvM6VEir6mo24cXpWJumxL6yp4=;
	b=jo2Y74lhL7qEIO57nDymsv9dhUH1dkIfII8sj6MHJpY6KHV0dYdJidrzDu0sCceYHBQlk+
	+zpL1dPax8a4yK8OhkpR0hpgG5bpWuwtLfMYvRLLiwJK9B0DKhWG5vyw2PNouIYgPK5Osq
	+aObcO5X30yd8lEeNWfRs9gC3j6dR9XJQBfC64l9oI4q/r9uuDELIjsb1IzVwR44cvLn1q
	vJkChKZr7J2RiEHZUMNUd3ZZ7Ym6xFca+cpwY4et6mkGoh6+WEeoLfvbg0jBp0CdOf8J45
	DaC2YGkoLW8rJlr4OiDXbkRbNom4NcW2TvJOgphnH3/hB4mYREmRwyVoXghhyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719943956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBL/9oB2KixNpv9EdsvM6VEir6mo24cXpWJumxL6yp4=;
	b=eBPG4xjrhwETYQJGKeLK24dE2+JSoNvIBVtjHaOht72U7TArHtomXx87meO4wL7wuuwC94
	Vx9mfHuQnHQjWJAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 3/3] bpf: Implement bpf_check_basics_ok() as
 a macro.
Message-ID: <20240702181233.URQ43uFX@linutronix.de>
References: <20240702142542.179753-1-bigeasy@linutronix.de>
 <20240702142542.179753-4-bigeasy@linutronix.de>
 <ZoQqc_dNjxF1-AR-@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZoQqc_dNjxF1-AR-@krava>

On 2024-07-02 18:27:31 [+0200], Jiri Olsa wrote:
> On Tue, Jul 02, 2024 at 04:21:43PM +0200, Sebastian Andrzej Siewior wrote:
> > sparse complains about the argument type for filter that is passed to
> > bpf_check_basics_ok(). There are two users of the function where the
> > variable is with __user attribute one without. The pointer is only
> > checked against NULL so there is no access to the content and so no need
> > for any user-wrapper.
> >=20
> > Adding the __user to the declaration doesn't solve anything because
> > there is one kernel user so it will be wrong again.
> > Splitting the function in two seems an overkill because the function is
> > small and simple.
>=20
> could we just retype the __user argument? like
>=20
>   bpf_check_basics_ok((const struct sock_filter *) fprog->filter, ...)

If we keep the function and add a cast here then cast the __user part
away and it would be wrong if we do something else with the pointer.
If it is understood that that will never happen=E2=80=A6

> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -1035,16 +1035,20 @@ static bool chk_code_allowed(u16 code_to_probe)
=E2=80=A6
> > + /* macro instead of a function to avoid woring about _filter which mi=
ght be a
> > +  * user or kernel pointer. It does not matter for the NULL check.
> > +  */
> > +#define bpf_check_basics_ok(fprog_filter, fprog_flen)	\
> > +({							\
> > +	bool __ret =3D true;				\
> > +	u16 __flen =3D fprog_flen;			\
>=20
> why not use fprog_flen directly? I'm not sure I get the changelog
> explanation=20

This was to avoid expanding `fprog_flen' twice. But looking at the
actual output, the code generation seems to be unaffected.

> thanks,
> jirka

Sebastian

