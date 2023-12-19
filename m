Return-Path: <bpf+bounces-18271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF068184E4
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 10:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510211C23C5E
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429961401E;
	Tue, 19 Dec 2023 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/rKVzmX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WsKHgcJ1"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2E14281
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702979864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzgZZ06CzopzrE4YdnIRO4IdWB8e7O/zNIu/4GV8Ucw=;
	b=e/rKVzmXQqoEBiR6xXHzpSxaaHvlEDEGxBmJW3dM3ZnT3xVz69qEPFdeGTfxBOBE1zAaIK
	bB82cVdL7FPSGdtl+75tfPtNrSHiIAGAr+UtvYq0cP7RZj3/HpUMtsmjogxrhTcwRdfWbv
	bbQxtgAHU5becojjFVzPPGidvoTTHkXogTYhpZQfehkQd73a+SzeJRml2j3qQj4rD4OJTh
	0tl1InrwuSQDmN6tXDfjPMps8NDp5PqRusmHFb8khoZYEL5CheCBOvinGY+QCFHk5dO9az
	kvbpx8niRXnNJYXenRzMwz5HWlhB/vuPjkVSvgBEhu/vjN9KWKAPGZJveCBZgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702979864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzgZZ06CzopzrE4YdnIRO4IdWB8e7O/zNIu/4GV8Ucw=;
	b=WsKHgcJ1TvZs7pOexx2ojocfUZWcoTS2PZ+aTEWcXWjg5zePNxhwjuaXd6vxGqJbbGXIap
	fSazDNgSu+NldxBA==
To: YiFei Zhu <zhuyifei@google.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf] selftests/bpf: Relax time_tai test for equal
 timestamps in tai_forward
In-Reply-To: <CAA-VZP=7s4S73CDGWApatHoFRE1Gv1AQKJKXi=Nqf5dBU50OoQ@mail.gmail.com>
References: <20231212182911.3784108-1-zhuyifei@google.com>
 <bff66df3-bd32-445a-89a8-b6208d87ae0c@linux.dev>
 <CAA-VZP=7s4S73CDGWApatHoFRE1Gv1AQKJKXi=Nqf5dBU50OoQ@mail.gmail.com>
Date: Tue, 19 Dec 2023 10:57:43 +0100
Message-ID: <875y0u4iqw.fsf@kurt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Tue Dec 12 2023, YiFei Zhu wrote:
>> > diff --git a/tools/testing/selftests/bpf/prog_tests/time_tai.c b/tools/testing/selftests/bpf/prog_tests/time_tai.c
>> > index a31119823666..f45af1b0ef2c 100644
>> > --- a/tools/testing/selftests/bpf/prog_tests/time_tai.c
>> > +++ b/tools/testing/selftests/bpf/prog_tests/time_tai.c
>> > @@ -56,7 +56,7 @@ void test_time_tai(void)
>> >       ASSERT_NEQ(ts2, 0, "tai_ts2");
>> >
>> >       /* TAI is moving forward only */
>> > -     ASSERT_GT(ts2, ts1, "tai_forward");
>> > +     ASSERT_GE(ts2, ts1, "tai_forward");
>>
>> Can we guard the new change with arm64 specific macro?
>
> Problem with this is that I'm not sure what other architectures could
> be affected. AFAICT from the test, what it cares about is that time is
> moving forwards rather than going backwards, so I thought GE is good
> enough for what it's testing for.

Yes, exactly. The time must not go backwards. Checking for GE is
fine. Thanks for fixing this.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmWBaRcTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgnh0D/9d/NUxFzxv+TrfCzR5QksGvMdHcCmG
jAn9U7kbMjPgw+H/NueLX6qLTOM6k3kqIq//SJ+h93K0/ySdUoG+GY0WYysoPbLP
T9WsuOXQMlIUuPXDMcN8lxyoRbshU5ccfbxzODAU8diz2gZbgkwr+kc4As9EcdG8
iU773dxVOys/dnOjc2Wcoesq0tlRYWh5tY6omWBkvLu4o1PYdga+YFCHmoxo6TZf
wv5FdDXx4Ooegx6JcCpDdwHn7bdqJwmzwM0miWXLPKsTsf5h7YyhM1dLeE/GWLDh
cIpWIgAwpGXeM4ah06rgSWjybzeUt4pi04/1K0FFg4/w8nP0tlyHfGaHLeJ1Wmp1
SQA8KJzKbf387uMd1aarh5p9u5h5SnLROk2MoMpSV4AlAG+JSqXya7vuKNvNi+4I
vIMcGAtvJ3LZDE/566zPHCfA4H4239+bdYZpngh8AKhJbSAV6jebYXjtqTbrsOdQ
GZoIhd0N7HdJl7ZHwpzNXvX/HsGxretrr3m20t/KePHlbLcPYLz07pLGuRWGR1Vz
U/E90VZmZ33DvNTADOfbDsffU5eF2CvJP6ihn7HdfxPissAy2pHIg6f8TxGYwekz
mvs/b1KJVX7mxSCP9KKuBnm2KovxizipC2l1v5QIndFzU/gkDUkvgbsWe9LWS4au
gqO9oAiAh11fHA==
=/uFe
-----END PGP SIGNATURE-----
--=-=-=--

