Return-Path: <bpf+bounces-61791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A0AEC404
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 03:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C271892244
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 02:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922891D8E10;
	Sat, 28 Jun 2025 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzCiUYSe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4E2F1FF1
	for <bpf@vger.kernel.org>; Sat, 28 Jun 2025 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075981; cv=none; b=rJvriY5SU6rZf5bDuzvevINzqqhry0/hicRGiCvlXvzEQJIYObmQrriiv/Y3jkoUy1gDdKDt0WcgTVrNdaoY07YTEKlRox1sz38XnO96ZFiV9qz9Q3L/km+ETIrSI0xYvvi9Pyl8EZNPnUsJLG8v4BckAtqgWk96MzK37/+h8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075981; c=relaxed/simple;
	bh=cOUePLHMUjnWBAjUKsnROm0uwT4nepvi0hnD+W0RQPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AXKtyO3k6u6YuxTgczpZmprKUKjDCoPfn6eQet+vo0BejJLUH1tqaPRHTBFNVp4uWTklWJzvIGTtvshRzyL/s3hZvorNmZT0fLQ41N8qhFfXwQj5kLD3BqWoHhW6hKWjkymeRGmsBflCiPtdgHEDBUIotxF0xd5IZPv6Fsh9l7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzCiUYSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8695AC4CEE3;
	Sat, 28 Jun 2025 01:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751075980;
	bh=cOUePLHMUjnWBAjUKsnROm0uwT4nepvi0hnD+W0RQPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HzCiUYSetJ4EkAPOk02UVgMCgcenIX18jHAO04ShfnStJk8jUOoY279/3iqNyEWuC
	 D6xydo3p+1hnK5HqU/JzBq8INymVH99AHoKMf7Grd2WTSGdQKqyzbp00KtwUeLUMBv
	 j0tTo5pyuFhpyY+PZqNkdEcO/Rl/hU5xYrpWFWaquHH9URmLIu7TUgvdSIGVbuZdXv
	 SfuU0M+my1GJMc9hwErXKlqlAkFPQsPt9K7hF6KdsMwSmLDNkF3yNOPepXXAHFTsB3
	 oyTQsbxSTWT/LZciBlJCeC/11fI9+kmCkERyhjuHnT8NH/LY4ZLOniSVv1EUwYRTZf
	 8jlMoKnpu9ABA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8938111CE;
	Sat, 28 Jun 2025 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: improve error messages in
 veristat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175107600652.2110993.2865453274474091751.git-patchwork-notify@kernel.org>
Date: Sat, 28 Jun 2025 02:00:06 +0000
References: <20250627144342.686896-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250627144342.686896-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Jun 2025 15:43:42 +0100 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Return error if preset parsing fails. Avoid proceeding with veristat run
> if preset does not parse.
> Before:
> ```
> ./veristat set_global_vars.bpf.o -G "arr[999999999999999999999] = 1"
> Failed to parse value '999999999999999999999'
> Processing 'set_global_vars.bpf.o'...
> File                   Program           Verdict  Duration (us)  Insns  States  Program size  Jited size
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: improve error messages in veristat
    https://git.kernel.org/bpf/bpf-next/c/ffaff1804e2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



