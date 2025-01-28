Return-Path: <bpf+bounces-49987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92735A2148D
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 23:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8DF3A85EE
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1690D1EE039;
	Tue, 28 Jan 2025 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NUNSUUGt"
X-Original-To: bpf@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052B18F2D8;
	Tue, 28 Jan 2025 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738104123; cv=none; b=ZSF1tzNNEft+ZEMz5E4zgPPXk+febAiAn33i/Eh/A6X2yRIlMKHMYXePkYGjBA29YrW1R0lzdzk27xkElQ1TfsRtEt5A+Csf4YkVhqrQuLgDt0bgaRRhNqmMnL/t6zPWAoS/PF7kQE0QMZlFM67269x0X7WL/qUqMWlBuZ/lMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738104123; c=relaxed/simple;
	bh=AOq0SJfJiBWND1wZ8FCd25+xqo3YTjsEqxOPO7EP2Os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FstZ4C6DuUxK9n5M/3sg7jpX/GB3dpw1cVdd0Rje5e+IrzQ204QiRqwwmVyx07DktIGradd5Ie/WbNADPj5RPL0y8Zpyb+ibRpIexleAFtYiDUFvEW3KX+VkOpd/umHn281FNaZhLY+iyFPjMBcDcp1VSYcbo8UhwRuSgJsix8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NUNSUUGt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 06ECA403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1738104121; bh=+meNH1juZBBtvrp/xo2cF0Sh2lEGZRx9Dv3JEMGVfwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NUNSUUGtYAw8IZ7v+u9urKWTHqRqgIaFDi/LwOklT1yZ+dVdXczOD9aTVo9dL8GaQ
	 OAf5s35W/sLcrCXBP9L1rzztGXQrZf82Io4oQsEPVhxr2Gmfam9dfHpeHYHM4gAzS8
	 Z5wJvtiQGdryhtYMX/RqM8UUTkxsZ7qqsI/DxEU04UzFD7wrLVaAgpDF9YgOAVZODR
	 ghFfoDDu31L5plmrTy4y8+t+6MkL5TJscft0G5BNRz45gjvAU7I+oGLILjgoaHhU9M
	 9iNee1I8iwhHjJ3JhYnCMWXNAtQ6QziZH5AMs5lTvSyDYyN1vQVIIWC4TLGwjRIBKs
	 EZQClEOOCB0lQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 06ECA403FA;
	Tue, 28 Jan 2025 22:42:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-hardening@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [RFC v2 00/38] Improve ABI documentation generation
In-Reply-To: <cover.1738020236.git.mchehab+huawei@kernel.org>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
Date: Tue, 28 Jan 2025 15:42:00 -0700
Message-ID: <87h65i7e87.fsf@trenco.lwn.net>
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
> That's the second version of my RFC patches meant to modenize the ABI
> parser that I wrote in Perl.

I have a couple of minor comments on the individual patches, but overall
I do like this direction.

It would be nice, though, if the code were a bit more extensively
commented.  Parts of it get into the "twistly maze of regexes" mode that
can be awfully hard to follow.

> On this series we have:
>
> patches 1 to 11: several bug fixes addressing issues at ABI symbols;

1-3 aren't needed - it seems you already upstreamed #2?

For the rest, is there any reason to not apply them right away?  They
just seem like worthwhile fixes.

> patch 12: a fix for scripts/documentation-file-ref-check
> patches 13-15: create new script with rest and search logic and 
>   minimally integrate with kernel_abi Sphinx extension(phase 1);
> patches 16-19: implement phase 2: class integration (phase 2);
> patch 20: fix a bug at kernel_abi: the way it splits lines is buggy;
> patches  21-24: rewrite kernel_abi logic to make it simpler and more
>   robust;
> patches 25-27: add cross-reference support at automarkup;
> patches 28-36: several ABI cleanups to cope with the improvements;
> patch 37: implement undefined command;
> patch 38: get rid of the old Perl script.
>
> To make it easier to review/apply, I may end breaking the next version
> on a couple of different patchsets. Still it would be nice to have more
> people testing it and providing some feedback.

I've looked over everything, though with limited depth.  My testing
hasn't turned up any problems.  I've only tested with current Sphinx,
have you tried this with the more ancient versions we support?

[It's probably time to raise our minimum version again, especially now
that current Sphinx has better performance.]

I don't see a whole lot of reasons not to apply this set shortly after
the merge window; anybody disagree?

Thanks,

jon

