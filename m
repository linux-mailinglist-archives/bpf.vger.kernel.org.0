Return-Path: <bpf+bounces-73333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1722C2ACCF
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 10:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CD2F349130
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729192EFDB5;
	Mon,  3 Nov 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fJE5DKqL"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914312EC558;
	Mon,  3 Nov 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162787; cv=none; b=jLDYw+RlqqEYDr5sPnCDCHqsDs/VbfD1/cuq+l/Y8fN2KOE3G4AksIRkT0NVz2Cz1FrjhZv51CwLoPOrpksTig/qAIswdbNQOpes4w8BvmrF9YbU6q+3xlqlqCeCiwS58PCYarvSvF8ASyFb/SoYSP9gNQmABVVRNZhm2xe9jko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162787; c=relaxed/simple;
	bh=wN2aU/M8qhuJf9I7yq5BtC9TMEbeEqeInZHiWNRpMcQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=NkBmrRNVXXp+L58IoH31btDYuzt8+z1c1q32/pjjnCyapv/hQUnk5/0yRXCd+zPOxEB3cVEDvr9sxziotuQlB7PEQcSgSTCWT3p4aEAsjtCHwXM1aQkOotLxJ+GAgfCqrIDJaqq9Y8uInSbK/+tlIV0gc7PY86VkLuVhLi1L9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fJE5DKqL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BD7BE1A1839;
	Mon,  3 Nov 2025 09:39:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A41460628;
	Mon,  3 Nov 2025 09:39:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C3581181802F;
	Mon,  3 Nov 2025 10:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762162781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vkeC2Id2TZzKkRDJDdQieEk1hQjbOf+Z6dHLIhtw7EU=;
	b=fJE5DKqLMxGrsvaZpi9XL9uZbYF+IT52opnNBntnb0+EsyDZs1EVJk2TXtSHRsUbhEm7Ov
	QRVa9WzZRinCxJysO64SgUx7/iEMt/hvuoTl/tuuOsb4zgMEKdggLQ3gqJvEaG4qr5hNWS
	HbtSyk1JYkjf1N2yt9m0raq84eG7dlbuUODIYpD1Bh1NuEHJWRSUej+CY/4T49JhQO1QBq
	46L5KRrSbx1Q9WNdFaMXXneOnF5kqSOg2Bz7Urb94CLlg6J9Ua5CbEQulOI29O95BykPVD
	vHwEWayJY+HUtqDDNKoASp7vSvPdd492wS+zT2Dt7bLZEz4qFLebqY3ICSYU8w==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 10:39:36 +0100
Message-Id: <DDYYKJWVL8KH.3UDBWDYHK2M8N@bootlin.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: integrate test_tc_edt into
 test_progs
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>,
 <bot+bpf-ci@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <shuah@kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Martin KaFai Lau" <martin.lau@linux.dev>, <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251031-tc_edt-v1-2-5d34a5823144@bootlin.com>
 <09feef91b51f675195b5b1b9a854d844c9999c0cebb429d785fe60f6c787dc8b@mail.kernel.org> <d886e631-851b-4e2f-aecb-ecdb541dfedc@linux.dev>
In-Reply-To: <d886e631-851b-4e2f-aecb-ecdb541dfedc@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Oct 31, 2025 at 8:28 PM CET, Martin KaFai Lau wrote:
> On 10/31/25 9:20 AM, bot+bpf-ci@kernel.org wrote:

[...]

>>> +	while (true) {
>>> +		send(conn->client_conn_fd, (void *)tx_buffer, BUFFER_LEN, 0);
>>> +		ts_end =3D get_time_ns();
>>> +		if ((ts_end - ts_start)/100000 >=3D TIMEOUT_MS) {
>>                                           ^^^^^^
>>=20
>> Does this time conversion use the correct divisor? The timeout check
>> appears to divide nanoseconds by 100000, but TIMEOUT_MS is 2000
>> milliseconds. Converting nanoseconds to milliseconds requires dividing
>> by 1000000, not 100000. With the current calculation, the timeout would
>> trigger after 200 milliseconds rather than 2000 milliseconds.
>
> The report is correct, there is a typo in the denominator.

Gaaaah, that's one stupid mistake, and so I possibly got too enthusiastic
about the initial results. I'll redo some more tests with this point fixed.

> Use the send_recv_data() helper in network_helpers.c. It should simplify=
=20
> this test and no need to pthread_create, while loop, ....etc.=20
> send_recv_data limits by the number of bytes instead of the length of=20
> time. There is a target rate in this test, so it should be easy to=20
> convert from time limit to byte limit and reuse the send_recv_data.

Nice, thanks for the hint, I'll then simplify the whole test by using this
helper.

Alexis



--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


