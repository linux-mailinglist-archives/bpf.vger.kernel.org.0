Return-Path: <bpf+bounces-51036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC35A2F715
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 19:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4441B7A321D
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76452566CA;
	Mon, 10 Feb 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PxFnHkEK"
X-Original-To: bpf@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52625B668;
	Mon, 10 Feb 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212249; cv=none; b=ICbZJaJZKOTKwPBnvm557xT1Uij+e/8xohTFORwZ/JM4lZMEjh8sH2aBxcSbQLP3yWDNI/BX9poLGFPbswr9nu9x0rQJjHiYezuNdYXUyPwFS2z5qZlwf59X1tu5k5mP5WcqsvPliCrNH6Mz429v382yoDJqsnqEVRsAl/1Rx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212249; c=relaxed/simple;
	bh=vlbv0FSFlLbSmcwi0qSd9c4OoNOyoJGUgwl16y4Fj8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2cZDSOqy5UrMrWngEG1BnwAANdue9+ivOJQcFxUMAVS9vgSB02FS0sRPIY5jJ9+nk4ComR/KLws1zi9YZiGvrv+JmBRGB2yZA486H0qYNwaGZyDCIWsz8zZym+3Ur/oByuiQVoKmrb+NC4Xxfsy05xvx5XzaHQNKIdIqvtvn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PxFnHkEK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0D1D5411A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739212247; bh=vlbv0FSFlLbSmcwi0qSd9c4OoNOyoJGUgwl16y4Fj8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PxFnHkEKSZrBYbzFpew/UljRdQUkTOX+qKIpKomAZlWSWpxide9l4c2bxkwdMwNWF
	 sWHrza4QeD17HbEJ1GVDgKEHsQ4J5fGszAooe0rUMV8SpHN2AnJh5s+msApTtSueTq
	 kldvsJD8z29V82iGnnNsIvc0IpF/n5AUf1V7EwE15mOEBZuS5tkWNvoYAelEzc0LtF
	 9A/zQoFU1JnwlyetVPR6L3frzztdtk0XDVlSCAuejySkEp8NEq0ylr0UsJ5g1a1OZE
	 Vo03pIkLZ7JlMiGrr1nPdfsokPnHNxFSVgl0KcZB06VxFdKHkJg6ydIZAOvztgFrBm
	 SzjyXR5yVqF2g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0D1D5411A1;
	Mon, 10 Feb 2025 18:30:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, Chao Yu <mchehab+huawei@kernel.org>,
 Jaegeuk Kim <mchehab+huawei@kernel.org>, James Clark
 <james.clark@linaro.org>, Johannes Berg <johannes@sipsolutions.net>, Mike
 Leach <mike.leach@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Tony Luck <tony.luck@intel.com>, bpf@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-hardening@vger.kernel.org,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/27] Improve ABI documentation generation
In-Reply-To: <cover.1739182025.git.mchehab+huawei@kernel.org>
References: <cover.1739182025.git.mchehab+huawei@kernel.org>
Date: Mon, 10 Feb 2025 11:30:46 -0700
Message-ID: <87h651zm7d.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon/Greg,
>
> This series replace get_abi.pl with a Python version.
>
> I originally started it due to some issues I noticed when searching for
> ABI symbols. While I could just go ahead and fix the already existing
> script, I noticed that the script maintainance didn't have much care over
> all those years, probably because it is easier to find Python programmers
> those days.
>
> Also, the code is complex and was not using modules or classes and
> were using lots of global variables.
>
> So, I decided to rewrite it in Python. I started with a manual conversion
> for each function. Yet, to avoid future maintainership issues, I opted to
> divide the main code on three classes, each on a sepaparate file.
>
> Just like the original RFC, I opted to keep the Sphinx kernel-abi module
> on three different phases:
>
> - call get_abi.py as an exec file;
> - import AbiParser on a minimal integration scenario;
> - cleanup the code to avoid needing to parse line numbers from the text.
>
> This way, if something goes wrong, it would be easier to just revert any
> offending patches, It also provides a better rationale about what each
> logical change is doing.
>
> The initial patches on this series do some preparation work and
> cleans some ABI symbol bugs that lack ":" delimiter.
>
> I opted to place on this series the Sphinx and Python version updates.
>
> I still have ~10 patches here with additional cleanups, from the original
> series I sent as RFC but let's get the main changes merged first.

OK, I have applied this set - it seems to work for me, though it does
lead to some changes in the organization of
Documentation/admin-guide/abi.html in the output.

It would be nice if, eventually, we could put the README link up at the
top rather than under "ABI file", or even just include its contents
there directly.

Anyway, let's see how this goes :)

Thanks,

jon

