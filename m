Return-Path: <bpf+bounces-57844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BE5AB0D30
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 10:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493C99C10DA
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9FC272E55;
	Fri,  9 May 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CTT/mrY0"
X-Original-To: bpf@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206335280;
	Fri,  9 May 2025 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779641; cv=none; b=ONFSAtxy48iR2cvP3oc1llYS4HFQnqAzDjD8BgwnXOadUkRuLuzPxpS6WwSMED0C3gOWKRp33HEZAyGWut9qCWAEAJE2Zq/3ZusP1nfg4XCIsIo9Zyc1Ldi2LP7EMi0s+L16FZUFpG1Xrj40vOQyNGBVK92gIbDYx8QpD/n18cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779641; c=relaxed/simple;
	bh=o5hr7FGhY4b4G6SxA3gQOQR0SDXj9Zf8g5CJwZ6Ct6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LwDSZ2QlpHALFTBGc6fgHp/wIadDBS1WqqRKqBmXhsH4Uc59oBH/DcV4uyqQT+xwvq9sD0bUnCIFIaqL4b/bvYbGp+zK98Duc35Fp+RfL1h+4veHK+ih6RrIZ+GCm/TJj962LNbL0h0T5Kcx5r5Oe95xyHzOiFETq5hQSipaTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CTT/mrY0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93FD141C84;
	Fri,  9 May 2025 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746779631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94DVZcbTpVhuih5h+lFAVS5FnBjZEMqUpSyD4fdPpC4=;
	b=CTT/mrY0NKsnAxcMLdD0y4N7a3pkExkoyEfMCCebyatb1anNf+ppTzD0YSA+WhRiwm7CHx
	2jZKlDkJAhB0m5I0jBkL5ZshmRRAwusRhM4NMxZD5RlyFn+RI3v1g6kV2XeiK2N4JDuDQ6
	WFwCJ3+tP4Rr46cj8hdyCFj68/ZCCzUizKSCyxKS5ua7NcvyXZC+Z4PvPZoR3kYj/vEkKh
	3bPFUQxLNZl33lu9B1b/bPPbgjZJ1qXHqUP7he+Yzq9jHmWSYv00l2WRLYCWOEsWcCvkQD
	ElvrvVdPTcDI0nRtPHXAQC2wb6nVF7ygoeg4t0YmUDmszMKXsumohU+/e/IhaQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 May 2025 10:33:50 +0200
Message-Id: <D9RHP83CJA32.1LGMU4SC9QJ1K@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Tony Ambardar" <tony.ambardar@gmail.com>
Cc: <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>, "Alan Maguire"
 <alan.maguire@oracle.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
Subject: Re: [PATCH dwarves v2] dwarf_loader: Fix skipped encoding of
 function BTF on 32-bit systems
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <Z/+HZ3w2KmbK5OAi@kodidev-ubuntu>
 <20250502070318.1561924-1-tony.ambardar@gmail.com>
 <D9QOFW6WEIT0.2AJBVJINZRRBV@bootlin.com> <aB2Q3ylln95YFTCD@kodidev-ubuntu>
In-Reply-To: <aB2Q3ylln95YFTCD@kodidev-ubuntu>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkhffvvefuofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvheeffeekieevfeehfeetkeetudfgudekteetieeigefhleffgfejudelffehvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehtohhnhidrrghmsggrrhgurghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlrghnrdhmrghguhhir
 hgvsehorhgrtghlvgdrtghomhdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvth
X-GND-Sasl: alexis.lothore@bootlin.com

On Fri May 9, 2025 at 7:21 AM CEST, Tony Ambardar wrote:
> Hi Alexis,
>
> On Thu, May 08, 2025 at 11:38:06AM +0200, Alexis Lothor=C3=A9 wrote:
>> Hello,

[...]

> Nice! I notice bootlin has worked on several BPF testing contributions,
> and was wondering if your build is some new standard buildroot/yocto
> config tailored for BPF testing, and what archs it might support? Reason
> for asking is I have a large stack of WIP patches for enabling use of
> test_progs across 64/32-bit archs and cross-compilation, and I'm keen to
> see other examples of configs, root images, etc. (especially for 32-bit)
> At the moment I'm targeting 32-bit armhf support to make progress..

No,  that's really a custom, minimal setup that I am using, based on
buildroot. My workflow is roughly the following:
- use buildroot to download an arm64 toolchain and build a minimal rootfs.
  No specific defconfig used, it is a configuration from scratch, with
  additional tools for development and debugging
- configure a kernel for arm64 testing:
$ cat tools/testing/selftest/bpf/{config,config.vm,config.aarch64} >
.config
- use the toolchain downloaded by buildroot to build the kernel
- build the selftests with the same toolchain (so I am cross-building those
  directly from my host, I am not really using vmtest)
- run all of those in qemu, and run the selftests directly with test_progs
  in there

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


