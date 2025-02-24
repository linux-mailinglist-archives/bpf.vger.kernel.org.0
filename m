Return-Path: <bpf+bounces-52444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C4A42FD3
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4724E3A82E9
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871711FC7D5;
	Mon, 24 Feb 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM0aQ4rU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6981FC0EB
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435010; cv=none; b=j84zDj1g7fbH78gYSQ2UHhrfkj0HBQWsjWzdwhzsBux3gweZ39MfWLtmb9FsTTWcUmigCx/wVK/iwmClXMkE6WxTSmxQ29K4q46ikaWfFgAOLPI+8JjewgYQm5BKVCy9xPN4CyQl1TsJxfMch5vAZSznUMuUXUm3qOfudxTSjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435010; c=relaxed/simple;
	bh=JDAzArgtVM/3oWSLdrLSsQm625SRvTwj6WpC0zPSv4w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fl+WSb+3EG6ZfWruwtN5lHERT2E+Ewdr149G7i7PddKnO4w5BtVn9b4tPwFHx0wJu6wn2KWwzDbSIjirYJtr8/7pqM+oPE3LVYhcFUHYD9f840vNOVONSHvyypDtBDv+y4Lh3O6DDxjKO0UPuftEjDkTvQmGB7aG8wJCDsaBt/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM0aQ4rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78224C4CEE7;
	Mon, 24 Feb 2025 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740435009;
	bh=JDAzArgtVM/3oWSLdrLSsQm625SRvTwj6WpC0zPSv4w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bM0aQ4rUaMsHbfcSxVsUjTxNqJ0XF838MOPxG/qRhcyV7o8trzAuVqd7Izn6BNMaP
	 0sliaeUzNYdrAHunjUxWe/rc6vLwbHck2SaAnedBqcyIYsNrcfvm9OPRkzkXegvlGk
	 tj8UrgQp7OXUdfd40hsVakumL4fis9uFOQU+v17FpKrWkjMqyGXCd0Dg39/uWH1OBZ
	 aRO+jbmC2g3Wb4as2rc9SciiUDfcpu+4rGyBPaSWHJeb6LnKj+2RHiN0TBxiqCEt5d
	 ygiPY6Fp5obbQ1z0LuXkJ1+0ogBJi6JM0wk4Vl+rfdck+Ped++oSlMnvumjDg52dDS
	 zDi96APaA0EfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E53380CEDD;
	Mon, 24 Feb 2025 22:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fix out-of-bound read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174043504102.3625999.5963189772004385991.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 22:10:41 +0000
References: <20250221210110.3182084-1-nandakumar@nandakumar.co.in>
In-Reply-To: <20250221210110.3182084-1-nandakumar@nandakumar.co.in>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 22 Feb 2025 02:31:11 +0530 you wrote:
> In `set_kcfg_value_str`, an untrusted string is accessed with the assumption
> that it will be at least two characters long due to the presence of checks for
> opening and closing quotes. But the check for the closing quote
> (value[len - 1] != '"') misses the fact that it could be checking the opening
> quote itself in case of an invalid input that consists of just the opening
> quote.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Fix out-of-bound read
    https://git.kernel.org/bpf/bpf-next/c/236d3910117e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



