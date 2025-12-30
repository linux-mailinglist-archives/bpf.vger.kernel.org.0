Return-Path: <bpf+bounces-77545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E7CEAF0F
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 00:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B17930060E0
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383DD2FD691;
	Tue, 30 Dec 2025 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as2f3tX1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6C2A1BA
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767138807; cv=none; b=gXli7rjDUctgJwKSzXZxgChWPJhhaju/CsOPI9q0KQcupPaxaOmHnUSBBI0UEwgOvaGfdLg2n9ZGL3KStx+KwqFxIWbwOYdTfDN9SBJJd6IUTi2DFSFzNyLwVqwyzZBNHv3qyBqNWdLO6qz++G6Y7BYCByPPfOZ+Wmh4MttNKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767138807; c=relaxed/simple;
	bh=LDYfv8PEv2z3OV2F7Xdi3g9cHl9YCEd/w/LzVukKurY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lYYlRPIBm/4EAKKhIgy3yUtvMdPbt3qv0LPLZ/hF/TV+q6rUhipi0lJOsmFZHU3juz15MmQy/XcGmY0Q1p79fUo3ZKQtGNjDD6UVJKM0HYw5byOf40uTDn0DZTIyBndVmbQSW0WxtzAHrJn3klZoTXMIoT2pep1Li6jiZNNm248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as2f3tX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40493C4CEFB;
	Tue, 30 Dec 2025 23:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767138807;
	bh=LDYfv8PEv2z3OV2F7Xdi3g9cHl9YCEd/w/LzVukKurY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=as2f3tX1Ush5X21Mvz01xuBYGyqP/OqHi0U254qgL8co3TxLzFcAgbwfW0DZ96EaT
	 kRMMnKnGc84zq5dPwMEQHZX3nftdg1u2xyTsupwCs/RQBYF6zvFRbUuNVxH/qLtGm4
	 FBzEY/GQUEZ4iGTGNO4RFUX6IqeCarY4LST5rWPh3NMehGzOe8tYsv62NAYNH/4uQD
	 X+yxKrz51sMJ+AKgMFYANesuc2FF+JlVFiAzON8/Sqe1rCEXWcyYKe1u4q6lOsAWDU
	 xry78b/vaO10lVBZap5qqEvoOwyTIbtwSOLjCFo8cfBVL23Q3SoSMjn4wZVMpV9nLZ
	 b5CNchRTAglmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38EF93809A16;
	Tue, 30 Dec 2025 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176713860904.3380504.10164912509517856741.git-patchwork-notify@kernel.org>
Date: Tue, 30 Dec 2025 23:50:09 +0000
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
In-Reply-To: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 29 Dec 2025 23:13:06 -0800 you wrote:
> This is a correctness fix for the verification of BPF programs that
> work with callback-calling functions. The problem is the same as the
> issue fixed by series [1] for iterator-based loops: some of the states
> created while processing the callback function body might have
> incomplete read or precision marks.
> 
> An example of an unsafe program that is accepted without this fix can
> be found in patch #2.
> 
> [...]

Here is the summary with links:
  - [1/2] bpf: bpf_scc_visit instance and backedges accumulation for bpf_loop()
    https://git.kernel.org/bpf/bpf-next/c/f597664454bd
  - [2/2] selftests/bpf: test cases for bpf_loop SCC and state graph backedges
    https://git.kernel.org/bpf/bpf-next/c/e6f2612f0e7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



