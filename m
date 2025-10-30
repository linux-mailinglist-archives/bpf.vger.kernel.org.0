Return-Path: <bpf+bounces-73015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C03C20811
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD951896627
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231423EA9B;
	Thu, 30 Oct 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mBWuMfc4"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A8126BF1
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833101; cv=none; b=OIaV0iUrww7qH6+fukDiUAwFmNgm0sVQZ0UnzdcvCQBEK2yqdZcQOtZBXQ0fU9F4CwqcmutxAK40xMvG3wg0RPObrzjTcPORUWKELYuKpfKCOFpzCOiQAi5hqiXslo9qTPjqYkXQ51JParlT+WbQTWVcqp5nQv8PUadBV2ZfRoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833101; c=relaxed/simple;
	bh=pcUvfzjJIS8X9Z2iVO1COuyDkpyh2KXBtzZqEZQzzto=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=UV0LFb4HMjBy0/sEeHaq43Ru95w1iNwVdvPth0/4yPd5y6EJI1p5NqNUA/fiGllYwwNfd4PS2aQuvzxv5td9u+F+gtBJ7vrwo5ldIH7Cwr2XxEDH/RgkCjBP05G8Eh0gsI6sXoJu2VjYMj3Mm0U2wtl15VK+DfkPjsjIbBSjurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mBWuMfc4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A489F4E413FC;
	Thu, 30 Oct 2025 14:04:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 77D6D6068C;
	Thu, 30 Oct 2025 14:04:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 442AD11808AD6;
	Thu, 30 Oct 2025 15:04:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761833095; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nS6Tx9jK9BuNcGfzXxz3LJT+z2ofZPtTh2IjKicAfKc=;
	b=mBWuMfc4SaB27L/gZWQnrSba9chzIQNTEFnJMYGYeHp82JTF7//5xSkJoVdCbs4nauDLu0
	y0YO0T9N2Pr/ISipdwQ7rRatIjYUVufRFM4lyeI2JRTgqF+VrKkvOp5x11AB14ZwQLhYM1
	rmOaWENzOlQK4Qrt5QU25WEwbUXuJ42FHx6hNZv544coKycyxwU929MbVJWiC/GIMAOnUj
	WpwbngAD5j7M5+UAeEsaxa/CaZP2wNryPDvSdah6ZNR3YBQ/u6FXZZUqHsKa2GYKs1MoQD
	ou795dIpXd8dRmF68ai6tqfL6CPKwcgLj8JBDRdch6WnHnzI/QA+MwFcojulVg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 15:04:51 +0100
Message-Id: <DDVPPGIO5P1F.E3DWINA74BJ6@bootlin.com>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: integrate
 test_tc_tunnel.sh tests into test_progs
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <ebpf@linuxfoundation.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Martin KaFai Lau" <martin.lau@linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251027-tc_tunnel-v3-0-505c12019f9d@bootlin.com>
 <20251027-tc_tunnel-v3-3-505c12019f9d@bootlin.com>
 <1ac9d14e-4250-480c-b863-410be78ac6c6@linux.dev>
In-Reply-To: <1ac9d14e-4250-480c-b863-410be78ac6c6@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hello Martin,
thanks for the review and the initial merge. I am preparing the follow-up
series.

On Wed Oct 29, 2025 at 8:56 PM CET, Martin KaFai Lau wrote:
> On 10/27/25 7:51 AM, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:
>> +static int run_server(struct subtest_cfg *cfg)
>> +{
>> +	struct nstoken *nstoken =3D open_netns(SERVER_NS);
>
> It is unlikely but still better to check for open_netns failure. Just in=
=20
> case that the network changes/traffic is accidentally done in the=20
> original netns. There are a few netns switching in the test. Please=20
> followup.

Yes, I'll add those missing checks.

>> +	int family =3D cfg->ipproto =3D=3D 6 ? AF_INET6 : AF_INET;
>> +
>> +	cfg->server_fd =3D start_reuseport_server(family, SOCK_STREAM,
>> +						cfg->server_addr, TEST_PORT,
>> +						TIMEOUT_MS, 1);
>
> Why reuseport is needed? Does it have issue in bind() to the same=20
> ip/port in the later sub-test?

Yes, I observed that is I use the bare start_server, I systematically have
the first test passing, an all the others failing on the server startup
with errno 98 (Address already in use). I have been assuming that it is due
to some TIME_WAIT state on the freshly closed socket, but I may be missing
something ?

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


