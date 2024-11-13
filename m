Return-Path: <bpf+bounces-44721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C269C6A43
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 09:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8750B237A0
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFD189B86;
	Wed, 13 Nov 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b="ramRqTKG"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755F18595E
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485027; cv=none; b=TANdIeOp5m7qhU5/WJqmGGvY8zAkyFTiS1q/ySpxoSfLUzalAmwjsq3EzQAJSjUXItq0eNXRZ7nvBjpxjmjrlwoM0I3CsgKS6OUjbOwIZ1HdIQ3nLgBtE9eCmokwHEsfcsybM1Cc2bnYAyytxpkxz/NAXrvxJCGECc7rL1kIoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485027; c=relaxed/simple;
	bh=9bkdI7aPmf2NlA1l+V03H+kg5MblsdE4hSkBMw4jzLM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=D45RSQ5mLfw12L5zQVc7SxNBhtSZ+dTHGVmKPHVRB7DqCo5hBCNtcErQnNLbuNXwmcga3J5IdvwPGDcHX2EkCIPXh94UuRo+o89ETKhRi7PUNhFZluzVSPovBH1jDY8BhChteW96hagCnVOmH1wuoAyT9o87SwnelSjraiyIJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org; spf=pass smtp.mailfrom=vahedi.org; dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b=ramRqTKG; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vahedi.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vahedi.org; s=key1;
	t=1731485020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EU1k9AMEn/tc26JK+CGYVsgo3nAeKg3I3puW7ATTdAM=;
	b=ramRqTKGMlEWUG6s8JlLeeewYyPHOO1FlckkgQKa2+duIcS10fkhQf97a9r6F5EZAlIdkQ
	yfLymEAegdz+pjls2QXVoMI5y7CzSsX7HF0B4VFAoXPIWKYKkdSx4CkzQuF3W6UtPzwhoO
	asb0qODJMEpQorv7vtWDdgqp4helBnPPOMXi8ESmHSYFN/GkWDvNZaBe6OvBZS5F7X7axY
	j8HMdXSxJW/+ksbo0R4fH+FkPfRobdsHovUAhehl9cxHYBtvWt7mcoLe2du6dkchg13YhZ
	cQmF4DfdamuhYdwf2dXuDcETwsmfWVgS9IySjtXJE0JzCBbStAukA3VaL3OXPA==
Date: Wed, 13 Nov 2024 08:03:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Shahab Vahedi" <list+bpf@vahedi.org>
Message-ID: <c617471892505a16188397d4120b21ebd553a457@vahedi.org>
TLS-Required: No
Subject: Re: [PATCH] ARC: bpf_jit_arcv2: Remove redundant condition check
To: "Hardevsinh Palaniya" <hardevsinh.palaniya@siliconsignals.io>, "Vadim 
 Fedorenko" <vadim.fedorenko@linux.dev>, ast@kernel.org, andrii@kernel.org
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song 
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "John 
 Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Vineet Gupta" <vgupta@kernel.org>,
 bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <PN0P287MB28435A985BADB4B4D857223AFF5A2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241111142028.67708-1-hardevsinh.palaniya@siliconsignals.io>
 <e6d27adb-151c-46c1-9668-1cd2b492321b@linux.dev>
 <6454497ff35d2a534cd34b7635fb044e4033fe6b@vahedi.org>
 <PN0P287MB28435A985BADB4B4D857223AFF5A2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
X-Migadu-Flow: FLOW_OUT

Hardev wrote:

> Shahab wrote:=C2=A0
> >=20=20
>=20> Vadim wrote:
> > >=20
>=20> >=20
>=20> > The original code is obviously optimized out, but the intention, =
I
> > > believe, was to check if the jump is conditional or not.
> > > So the proper fix should change the code to check cond:
> > >
> > >   - if (ARC_CC_AL)
> > >   + if (cond =3D=3D ARC_CC_AL)
> >
> >=20
>=20> That is absolutely correct. If a new patch is not submitted soon
> > I'll try to fix it myself.
>
> if you are okay with that then I can proceed by submitting version 2
> of the patch with the proposed changes included

Of course. Please go ahead. To be clear, What I meant by "soon" was
something around a week time.


Cheers,
Shahab

