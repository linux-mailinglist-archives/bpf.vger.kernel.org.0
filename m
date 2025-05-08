Return-Path: <bpf+bounces-57745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBB0AAF6E1
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 11:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B26B1C048FC
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BEB2641E8;
	Thu,  8 May 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jdIWhOqJ"
X-Original-To: bpf@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0E256D;
	Thu,  8 May 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697094; cv=none; b=VF7AmJrq21WBWt4yrZgfjShHeClQUwRF6d6SzjCp3dgRSb7rQHebFUYRzlFFv7p/DXEDU4juld7omBe6dUdAlR29ZwY2HN+iqMEaT2iaJKH3NlPgglHnrpyAiEVKXW4ik1fTy0ioeGsTGwDMl0ZQGkDQDqum/gPamEgZoVoQEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697094; c=relaxed/simple;
	bh=SaXVJVqCe8qEoYe4/DuliBjSR0HDjrjWq27uDIX9Nco=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:Mime-Version:
	 References:In-Reply-To; b=KiXUHor0Gy5XM7Qr3WTlfuY2k4MJB0r2fVlbWfFy3HZu4iV2s3zI9yn8J0LqwtxqTHeFX4bA93Gcv6m8EEW+1OD9xkGYOyd4pXYQwL2NIcCCs3MxIpHyWko83g1JL5o2cFhunB6CpliTzFMJGiwkTXfIToK3WTZzgfUnOpYJGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jdIWhOqJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4220D439EB;
	Thu,  8 May 2025 09:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746697087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0b3+napmc38ovl9hoUwfu3ONlhB8xiw4jdwMaPzEcs=;
	b=jdIWhOqJy3XbvgQFPrqfGBwg7SVIJGCcPraTUF5QQel2GUOsPF/UUbvlPzyZoo0Qayn4Tg
	pWdQAA9szKfe82OTAXwwAmUt7j5kRLavFiCmPx8hNQsDTyF3sMsv6nMoAZ2rkMKODIyV+7
	QDngj4QIEvSOGcP8RZ+j9r0TH9AWjzV5Tm7b+DKziUuoeaN5rJo5rpzslXhe8VjJypyIsx
	bmoUt6Lw7//v0nfgxe6xVB0GCj6Piu7xCA+oJ1HkHlJ8pH8VwgkSvrRseB8nAGMlmG7O0/
	RPeR5/uRR+xBzBpSnUu+5Uf4/eEh2vi3pCpYu4ggcd+ISc9vizIVb7feSKbyBw==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 May 2025 11:38:06 +0200
Message-Id: <D9QOFW6WEIT0.2AJBVJINZRRBV@bootlin.com>
Subject: Re: [PATCH dwarves v2] dwarf_loader: Fix skipped encoding of
 function BTF on 32-bit systems
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Tony Ambardar" <tony.ambardar@gmail.com>, <dwarves@vger.kernel.org>,
 <bpf@vger.kernel.org>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Arnaldo Carvalho de Melo"
 <acme@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <Z/+HZ3w2KmbK5OAi@kodidev-ubuntu>
 <20250502070318.1561924-1-tony.ambardar@gmail.com>
In-Reply-To: <20250502070318.1561924-1-tony.ambardar@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeelgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkuffhvfevggfgofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffkefgfedvvdfhhfevjedvjedtvedvhfeileekgfdtfefhfedtgeekkeehffdtjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepthhonhihrdgrmhgsrghruggrrhesghhmrghilhdrtghomhdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvght
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

On Fri May 2, 2025 at 9:03 AM CEST, Tony Ambardar wrote:
> I encountered an issue building BTF kernels for 32-bit armhf, where many
> functions are missing in BTF data:

[...]

> Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expect=
ed registers for params")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>

I encountered some issues with pahole 1.30 when trying to generate BTF data
for functions having some __int128 values ([1]), and have been redirected
here by Tony. I gave a try to the patch below and confirm that it fixes my
issue: BTF data is now properly generated for my target function, so:

Tested-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>

While at it, to follow-up on Alan's request for more testing, I did the
following:
- build kernel and bpf selftests with pahole 1.30, extract BTF raw data
  with bpftool
- repeat with pahole 1.30 + Tony's patch
- I build my kernel for arm64, it is based on bpf-next_base and I use a
  defconfig very close to the one used in BPF CI (so based on
  tools/testing/selftests/bpf/config*)

I observe the following when comparing the resulting BTF data with/without
Tony's patch:
- There is no difference on vmlinux BTF data
- For bpf_testmod.ko, there is a slight shift in the first BTF ID (first ID
  is 46 with pristine pahole, 47 with patched pahole), which in turns makes
  a lot of noise in the diff, but the actual diff seems to be about two new
  BTF entries related to my custom function now being properly detected
  (BTF_KIND_FUNC and BTF_KIND_FUNC_PROTO)

Alexis

[1] https://lore.kernel.org/bpf/D9Q73OTLEOU4.LNAO9K4POETM@bootlin.com/

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


