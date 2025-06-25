Return-Path: <bpf+bounces-61574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C31AE8F10
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AEA171EA5
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ECE2BF01C;
	Wed, 25 Jun 2025 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcD+07FZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63820485B
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750881581; cv=none; b=Q85z+VlMB/aDYjt535mLFu1LuLmG25ovbPrRykEPRQ1zshJ6jjuQ3kUXDzGuYOF1c9NgVrCSuJMgHMwGYIDwz/v9/jCGPemUaInq9TZTHzVe7XAviH/uAoatEg8w6vRMC4+nwYyqFzXvYnM4GvMmWjZhSCdrteAqLOqdpacE5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750881581; c=relaxed/simple;
	bh=5hwPzLEHAd5giz5S5wcnjndLqq4HET+50I+lxjn/3Xo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oZtjgxDLfDLtukTjhpsBjfs4uW22SYhYNe7zwPb/m17/u2lMUDUdqawocvXF8ZYJtlAmyDF+HLpmpd9zRpZdpKnaH0nWU9mYdVJUFo0oc77gIpJgYTiDZFXFzMMdOWf0LdaiH5xGIux1y1ty9KQ3x8AWasrcKYWfALyeuf45f0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcD+07FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754BEC4CEEA;
	Wed, 25 Jun 2025 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750881580;
	bh=5hwPzLEHAd5giz5S5wcnjndLqq4HET+50I+lxjn/3Xo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QcD+07FZqU8Ph+ysJpEJz5cXtxbSyUYeiuQVqhgYxL8rlP7npLl7Sl4un5DMthZ6P
	 kpaPtZQhv7bGskYl9xo14oCqN6FLrhsqJsx9PQDAWldZFh8yjsikVROu4ts4Bruqre
	 msGJt/vTgXbI9QpYNmLIaA+RMFcNX/qQA5T6iwuVlqy/Wm299Krf91pweXqrsXTwpG
	 iPlqX28gzyJoBqFHx7zqHHpFeIFYV1woO841x1BR98BwLhkNoYYytRrfMWmsdaZFIF
	 U8i6zE/SZarCk8NeP2eccWK1bLsGr4TVEN/h1Jdr5RA2+g/lUd5SXR5C5cD3I3wTfV
	 MJe5vEuCwGmgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D613A40FCB;
	Wed, 25 Jun 2025 20:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Fix usdt multispec failure
 with
 arm64/clang20 selftest build
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175088160701.606615.10752678689497563399.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 20:00:07 +0000
References: <20250624211802.2198821-1-yonghong.song@linux.dev>
In-Reply-To: <20250624211802.2198821-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 24 Jun 2025 14:18:02 -0700 you wrote:
> When building the selftest with arm64/clang20, the following test failed:
>   ...
>   ubtest_multispec_usdt:PASS:usdt_100_called 0 nsec
>   subtest_multispec_usdt:PASS:usdt_100_sum 0 nsec
>   subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointer: 0xaaaad82a2a80
>   #471/2   usdt/multispec:FAIL
>   #471     usdt:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Fix usdt multispec failure with arm64/clang20 selftest build
    https://git.kernel.org/bpf/bpf-next/c/d69bafe6ee2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



