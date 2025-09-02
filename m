Return-Path: <bpf+bounces-67195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD5B408F2
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 17:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E975F3A4C65
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC4321F3F;
	Tue,  2 Sep 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUQtterF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E053128D6;
	Tue,  2 Sep 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827003; cv=none; b=Ubn6TZqYyih5QuTxr2dLSXvkFw+hBrYZvUi/TLrWTS3Mq46nAOFq4qk0jKGGoDaB7kgSUeIw1DL5zSNQcDBZUstiC652ymtFulaBmfDGAU37DkBtA/tbvDBFFm7lwT4tURbUyIK4n48YYleeB/UBei4psDqOjJO2TUksJ5wG27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827003; c=relaxed/simple;
	bh=k7xaqgxUhvucn0+WGTvIZyGwsHYi8uMgMRuBoGs5D2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JUs+q2r0dZy+PLNoxsulg5E7Df7hgpRqYXBmuaeYAhDVKHQ3jUaosJ7ipqvFALdfm3TnFggWIpGLAb4sbZjY+J/ko+kZ24rh6ojSUXef4WodF4gj/rMUtykYugzFczhJPqZRbTHXKcIXXY6eWxy+1XSYUHQjHxAa8Im6vSQUT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUQtterF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2572C4CEED;
	Tue,  2 Sep 2025 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756827003;
	bh=k7xaqgxUhvucn0+WGTvIZyGwsHYi8uMgMRuBoGs5D2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KUQtterFkIXAp7fifKyFzJwyDVmBBG+8ZvlyDAo195yMl3MvXp5ptDn9DuFExrAF3
	 MPc7jGYVN3IU8bHcE0aO74lsKjP/2msrbo0rpRCe1BKMzrh3kvLwYVjrybB+qB+r1j
	 jEHncNUOMBHC9J5vMlrvjXra3zajdO5NjRAaYtam2HdxOgnFbIxMFdYbQqiBuz92J6
	 0SxIpaBslOOXOHyPgGPkMteREwmLBKZVYzaB3qvyS7GawWpd2u1wB4fC92WjWABbLZ
	 VxQBeg82CtjJG70upMh+crbtKK8f7Jl60UBEIorEjM4jUJQ+zIq20X6C4hAJVS+B28
	 sPf8HDpbRo3RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE9A3383BF75;
	Tue,  2 Sep 2025 15:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 0/2] bpftool: Refactor config parsing and add CET
 symbol
 matching
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175682700752.343659.7302091706748568937.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 15:30:07 +0000
References: <20250829061107.23905-1-chenyuan_fl@163.com>
In-Reply-To: <20250829061107.23905-1-chenyuan_fl@163.com>
To: chenyuan <chenyuan_fl@163.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, olsajiri@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenyuan@kylinos.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 29 Aug 2025 07:11:05 +0100 you wrote:
> From: Yuan CHen <chenyuan@kylinos.cn>
> 
> 1. **Refactor kernel config parsing**
>    - Moves duplicate config file handling from feature.c to common.c
>    - Keeps all existing functionality while enabling code reuse
> 
> 2. **Add CET-aware symbol matching**
>    - Adjusts kprobe hook detection for x86_64 CET (endbr32/64 prefixes)
>    - Matches symbols at both original and CET-adjusted addresses
> 
> [...]

Here is the summary with links:
  - [v8,1/2] bpftool: Refactor kernel config reading into common helper
    https://git.kernel.org/bpf/bpf-next/c/70f32a10ad42
  - [v8,2/2] bpftool: Add CET-aware symbol matching for x86_64 architectures
    https://git.kernel.org/bpf/bpf-next/c/6417ca85305e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



