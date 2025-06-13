Return-Path: <bpf+bounces-60566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B931AD80E3
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459FC1E17DB
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2CA1EDA14;
	Fri, 13 Jun 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaeKzMZS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CBF610C
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781204; cv=none; b=kL+zpkhQakjOU+gdoIEHkAyvQCVIz742ksWE6D3IMJh0Hl6WsgRJxCagb1Q7cYHwN5cPnhmtj35KxBh+Kvxj5KkQRYq8LAKnPhLXlFlZwlF7H780DVOoPMAQc8XAFUQ6bipLZuX+7huVrpO2X45LZc9PtAiuc0GOec9VBf+ox8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781204; c=relaxed/simple;
	bh=tALYGNelgf6lqsr7wbKNWjURg0N7OHiJgVdQWAp5z80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i4BngBOwjNEhQpUt+2uYaJyHfCbHcNjJJ6nXvPPm0JzKPpPNLQR31EaVNuZc8hCqWw08IJTcrBv9l9f14qeWlPnhF2hhr7CjND2+nSJXRR6ss/5EnB3lvlu4kctsfOcCWS34Pt8E/xtuvMB8woqgOSAUgxOrg0i4EW1OBnEHwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaeKzMZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7178CC4CEEA;
	Fri, 13 Jun 2025 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749781203;
	bh=tALYGNelgf6lqsr7wbKNWjURg0N7OHiJgVdQWAp5z80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OaeKzMZSV/OeMwxB+mai9zFbBLBPzJISXAwObAdpNFWaIEcDjpCXD5umRe/F5X51V
	 vFtB+krBVvDXiFMM+DfppgRkR2JFvoUbGmMDThsCRjnNBROJ4ethzjUsVLu3b0Qsjb
	 CaJTr0/0klxwvxkbJ2stQcMY9zt8RdS/0LG7Mc6GvIpUfxlM48uQbNWTqv1VaqL0C+
	 x1Kx0na7qoX5MQPhZz+l2F39JD4IUKtz0RxyIh8uhzYNUx/kWKjUCvNVlt0yWVjMqy
	 8wa+pRMOu4zcqOe8i4ua0fQqqS0wu18EhJVov/p3s+LvQsQyw9Lz2kC5lae2q24R+P
	 HNMuyRLEtHJJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BD139EFFD1;
	Fri, 13 Jun 2025 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Fix a few test failures with 64K
 page
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174978123325.192771.7556309609340756372.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 02:20:33 +0000
References: <20250612035027.2207299-1-yonghong.song@linux.dev>
In-Reply-To: <20250612035027.2207299-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Jun 2025 20:50:27 -0700 you wrote:
> Changelog:
>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20250611171519.2033193-1-yonghong.song@linux.dev/
>     - Add additional comments for xdp_adjust_tail test.
>     - Use actual kernel page size to set new_len for Patch 2 tests.
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20250608165534.1019914-1-yonghong.song@linux.dev/
>     - For xdp_adjust_tail, let kernel test_run can handle various page sizes for xdp progs.
>     - For two change_tail tests, make code easier to understand.
>     - Resolved a new test failure (xdp_do_redirect).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Fix an issue in bpf_prog_test_run_xdp when page size greater than 4K
    https://git.kernel.org/bpf/bpf-next/c/4fc012daf9c0
  - [bpf-next,v3,2/3] selftests/bpf: Fix two net related test failures with 64K page size
    https://git.kernel.org/bpf/bpf-next/c/96fcf7e7a71c
  - [bpf-next,v3,3/3] selftests/bpf: Fix xdp_do_redirect failure with 64KB page size
    https://git.kernel.org/bpf/bpf-next/c/44df9e0d4eec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



