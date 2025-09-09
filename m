Return-Path: <bpf+bounces-67948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E824FB508D2
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 00:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965E116CA2E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03726D4C3;
	Tue,  9 Sep 2025 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZtb0/5W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E7DDC3;
	Tue,  9 Sep 2025 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757456419; cv=none; b=PXuOimzvuW41YrhzYfx14b12G5v6fhcFixzpN80Ia0YoVFk3HJjBiVUdWAWehbtsB9W4x8mb5wAzMQdpN3xXIsmvHswHHsDMkb77L7nYouABMwOwjj5pnTBIB6AprmZHMH2HTnda4kV7z1B9kngKbtp9jCdj8hxvhICVYdESgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757456419; c=relaxed/simple;
	bh=w6ygJ+jSHMHJMhXIICTvawWCkV2w+6vPGTpa2TzYJtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z+UJmpBK0N+jrk/RatmEGmB2bcy1V+m5aJUSzY1t2vSVjDUeot7QLT7/kJmH0ootdkipYZ2D8ATlWa5r1TtTELo9a7b0CJWCod+ugVxlBvqLW/0U5ucVPKCchs+e8H3Lu3KkTgvfbQufsbwQGofKCyc72a5t8bUhWKluVhEK4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZtb0/5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08422C4CEF7;
	Tue,  9 Sep 2025 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757456418;
	bh=w6ygJ+jSHMHJMhXIICTvawWCkV2w+6vPGTpa2TzYJtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NZtb0/5WOnb/KEvMZHwNED7Fj2zz33s0KwVT4rSquWAELjM139tgThu+t4+iPiNV2
	 7HYR7YYPCcUCwelLN8FpyaHG9WvdvR0mCKMxx22s/RW5zHLS8bu/tkyRSI5QfQVI6W
	 DwZHcE4TFbCNCT4DnsyiC3urEj35cb52dH/Z7hAQx/cqCwMpxA2fqsPuCl8IhDjQvf
	 +kJYAHWtIfBl2DUpcV5gCp844IlhCgsxFG3uhon1mF1oPuNan+4wLHfWBxHYiFmK2S
	 lE4XTJO3LauvzI4zC/Y4P9I4aZLY15oCY6TxwHBsSXLifPpuoUrjoWBOAmLydQ2UfT
	 vekjrdQtBJBFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71617383BF69;
	Tue,  9 Sep 2025 22:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 1/1] bpf: Allow fall back to interpreter for
 programs
 with stack size <= 512
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175745642125.833608.7682913821526006189.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 22:20:21 +0000
References: <20250909144614.2991253-1-kafai.wan@linux.dev>
In-Reply-To: <20250909144614.2991253-1-kafai.wan@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mrpre@163.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, nbd@nbd.name

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Sep 2025 22:46:14 +0800 you wrote:
> OpenWRT users reported regression on ARMv6 devices after updating to latest
> HEAD, where tcpdump filter:
> 
> tcpdump "not ether host 3c37121a2b3c and not ether host 184ecbca2a3a \
> and not ether host 14130b4d3f47 and not ether host f0f61cf440b7 \
> and not ether host a84b4dedf471 and not ether host d022be17e1d7 \
> and not ether host 5c497967208b and not ether host 706655784d5b"
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/1] bpf: Allow fall back to interpreter for programs with stack size <= 512
    https://git.kernel.org/bpf/bpf/c/df0cb5cb50bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



