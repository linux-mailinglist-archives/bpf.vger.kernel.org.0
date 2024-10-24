Return-Path: <bpf+bounces-43045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E8A9AE473
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 14:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8242B2194C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B821D432F;
	Thu, 24 Oct 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWBBT9fx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E517B51A;
	Thu, 24 Oct 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771890; cv=none; b=NS+3hDjIfYVrgqm8o6d/puuUrhaiPt9GzW9bJvyIa657xZciICeagyd3VoD31sp8ZTOClzYpnFhQZVVupwWD4ub6CKHGuC73ys2yYc9m2MQ4bZMSd0nLZP9nbbnE3gHdTHZ/2qR02c8SMVNB4fWJ/vzG2o4HG+VYek2aVH6DRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771890; c=relaxed/simple;
	bh=j2aK+dZfMCFBYBRp0DvfF/+BrKP9xuPDDRi0Mwd5PnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3C/q1Pn4wrkpmwQhT0JYA36pQWQ4CQa7FhzOB2VBNybajKuyzyJPnM1726YvqBiW0kuN5Grn3mY1i7gR4FI/Nvboe6mtO4QkAoZXPmGsUL39AJcT0rgJ4NgNCB31KEPOZyFvXz7y+tH/QIuTxx0pP0RFONQd9LUucJeAWx1Ins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWBBT9fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3051C4CEC7;
	Thu, 24 Oct 2024 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729771890;
	bh=j2aK+dZfMCFBYBRp0DvfF/+BrKP9xuPDDRi0Mwd5PnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pWBBT9fx07KGZ3OHTmp1zmn3dnEMW/o6gErH3btQM5uvp8FLa0eQd/gmaiNN7uIJK
	 Lf5fiZ1Jo/NZ48cmqmkZIgSRKPHm6QD47Emcb1AAs60Tq1WLYEoR0hI91Hch6JkubI
	 1oxUAxjDrO5KvnvfMTcyJWndpAgDcUAoJpO0HRv36F+OEHNheXZASQSJvl6JzIG9IL
	 3Aji4cyM7Vp9FlDmkLD93cTXe6TcyBpBjlbd1xVQlV1dyt6HQxY7Hcb+c/VldUquUA
	 uiiMUfWqIEwnOb5c+XsSuYsIWT0+Bj7Y5Gss37rZ2hQqdzFDNewPw4nOdXDDKVt+lk
	 o/YtNJcx9j1Iw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, Andrea Parri
 <parri.andrea@gmail.com>, paulmck@kernel.org
Cc: bpf@vger.kernel.org, lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
In-Reply-To: <35bed95a-3203-43a7-972d-f3fd3c7da6f9@huaweicloud.com>
References: <Zxk2wNs4sxEIg-4d@andrea>
 <35bed95a-3203-43a7-972d-f3fd3c7da6f9@huaweicloud.com>
Date: Thu, 24 Oct 2024 12:11:11 +0000
Message-ID: <mb61pr085bt0g.fsf@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

Jonas Oberhauser <jonas.oberhauser@huaweicloud.com> writes:

> Am 10/23/2024 um 7:47 PM schrieb Andrea Parri:
>> Hi Puranjay and Paul,
>>=20
>> These remarks show that the proposed BPF formalization of acquire and
>> release somehow, but substantially, diverged from the corresponding
>> LKMM formalization.  My guess is that the divergences mentioned above
>> were not (fully) intentional, or I'm wondering -- why not follow the
>> latter (the LKMM's) more closely? -  This is probably the first question
>> I would need to clarify before trying/suggesting modifications to the
>> present formalizations.  ;-)  Thoughts?
>>=20
>
> I'm also curious why the formalization (not just in the semantics but=20
> also how it is structured) is so completely different from LKMM's.

While initially writing the cat formalization for BPF, I started with
LKMM but because BPF memory model is an instruction level memory model
and much simpler than LKMM, I wrote it from scratch. But I converted all
LKMM litmus tests to BPF and made sure that the cat model is complaint.

> At first glance there are also many semantic differences, e.g., it seems=
=20
> coe is much weaker in eBPF and the last axiom also seems a bit like a=20
> tack-on that doesn't "play well" with the previous axioms.

Yes, the last axion is a tack-on that I added to make acquire/release
work with other atomics just before the presentation at LPC. The
acquire/release part is still under development and not perfect.

If what you are saying about coe is true then it is a bug and I will try
to fix it.=20

> It would make sense to me to start with the framework of LKMM and maybe=20
> weaken it from there if it is really necessary. But maybe I don't know=20
> enough about how eBPF atomics are intended to work...

The cat formalization for BPF is currently experimental and it would be
great if people can find bugs and contribute to it. It would be great if
people who worked on the LKMM's cat file could help building BPF's cat
file too.=20


Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZxo5YBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nYfrAQDOGqum/r5aJ91GPDVTy/BLPPdxuOfx
Ut272swNQKHhBgD/bBj+wTEqr58TvGy9wYWVlmndLErh38dGjecBTefpHwI=
=US4p
-----END PGP SIGNATURE-----
--=-=-=--

