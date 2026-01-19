Return-Path: <bpf+bounces-79450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE469D3A9B4
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3390F3002B8E
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866135CBD5;
	Mon, 19 Jan 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="roJXIYqj"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF07234964
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827644; cv=none; b=Hkfe2liH1UDRYjvBjJzxizivTP9nZ8TrwzWL1R9tVkp1XrlSg2R5IxFDPnRfvlHqXHW1gwJeykeWbsZlL8mpyP4h5Vli9Yc5uJ+hEAlCaKqwnvo0VdboWLf/uoQJ3YHsinT+ftZ2yrHH/nDJt46+6dCf56cu7noSn06wIujtjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827644; c=relaxed/simple;
	bh=PXUujVm6ApgjcxVKO1Klzm4Mkx9p3MJapHrETbhtdzI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=BjEUwS0iVnc6GPClmQWK8js6Wda8yL0jGf7FX6+OvkXsiIc/FlacnxwtUVIIzNEzHFLAtR1uH6TPBKFtlrM4FXK1Pel/y8cGFn2yAvXPkEDsh3iXK2O5i2BjYeXDc34dnh1MrZj5xakylRszD1j9Fto60yppCxEh8WTPC314TTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=roJXIYqj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E6C891A2953;
	Mon, 19 Jan 2026 13:00:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B154260731;
	Mon, 19 Jan 2026 13:00:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E3B710B6AFB8;
	Mon, 19 Jan 2026 14:00:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768827639; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PXUujVm6ApgjcxVKO1Klzm4Mkx9p3MJapHrETbhtdzI=;
	b=roJXIYqjd+b+rNE/CDpmEhK2jw0yzuK9/7UCCLggWw8W9IhhkPpYBl1eot4Pg7ewVfR9kt
	5nyNt54hYgcJCmJsGH6GSB53U4C2QIyeOxjTW3eTO0+rPXSflDHnPi7RsukKJKfke0df9d
	0xJWjaw8JBrjkVtrWHZcYc16m4uQnpNcGvZZ70neaTws/eUTze+iUEGBFcDt0CNxCtO7s5
	1bnR3NUpRTZivsPsdK0vfsXXQY43i77TJDKpk7CkQW9Ss8G7Jvm3FeuXaknDh1+N268w4r
	CBBfCZkef2wuAsohh5+fQJw2SZQWWmY2+vDUzTgbMbN4+IsKRZqUDnNCYAY8eg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 14:00:34 +0100
Message-Id: <DFSL2DHCSLNU.1640Y190S8S1Q@bootlin.com>
Subject: Re: [PATCH bpf] selftests/bpf: Support when CONFIG_VXLAN=m
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
 <haoluo@google.com>, <jolsa@kernel.org>, <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alan Maguire" <alan.maguire@oracle.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115163457.146267-1-alan.maguire@oracle.com>
 <DFPVFON6H9AQ.3BE95ZHQ3ATOL@bootlin.com>
 <87900b12-c836-4692-ad7d-b1997df806d8@oracle.com>
In-Reply-To: <87900b12-c836-4692-ad7d-b1997df806d8@oracle.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Alan,

On Fri Jan 16, 2026 at 10:32 AM CET, Alan Maguire wrote:
> On 16/01/2026 08:30, Alexis Lothor=C3=A9 wrote:
>> Hello,
>>=20
>> On Thu Jan 15, 2026 at 5:34 PM CET, Alan Maguire wrote:
>>> If CONFIG_VXLAN is 'm', struct vxlanhdr will not be in vmlinux.h.
>>> Add a ___local variant to support cases where vxlan is a module.
>>=20
>> Just a naive question: for ebpf selftests, aren't we assuming a
>> dependency on a "fixed" kernel configuration (ie
>> tools/testing/selftests/bpf/{config,config.vm,config.<arch}), which
>> enables most of the features as built-in ?=20
>>=20
>
> It's a good question - my take here is that we also need to remember=20
> that most folks interactions with BPF happen via distro kernels. Most dis=
tros=20
> tend to modularize their configs more extensively, and they also want to =
use=20
> the BPF selftests to qualify the particular config combination they have
> so that they can be sure that users have a good BPF experience.
> Often issues arise from this, and distro folks either report or post
> fixes. This is all good, so if the only cost is a bit more flexibility
> in the test environment, I'd say it's well worth supporting that. In
> particular blockers to selftests compilation cause problems for this
> process.
>
> There are of course cases where having a very old toolchain or a highly
> incompatible configuration that aren't supportable, but in general where =
there
> is low-hanging fruit in making tests a bit more flexible, it's worth doin=
g I=20
> think.

With a bit of delay: ok, thanks for your input. To clarify, my point was
not really about challenging your change but rather that I was not sure
about the policy here; supporting only the CI selftests configuration,
VS supporting other kernel configurations like distro configs (at the
cost of duplicating a bit kernel data strutures definitions).

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


