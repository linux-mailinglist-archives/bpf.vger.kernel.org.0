Return-Path: <bpf+bounces-74443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCE0C5A5AF
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 23:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740FD3AB6FC
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804430E0F2;
	Thu, 13 Nov 2025 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx9rgmZY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA92E1C63
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073638; cv=none; b=o+oK/zKA4YGC1jV124KYw+Ti0OoMftWkdYmf/7iEqSJy3oWeNX9QnxEcG97fBBJ1ODPiqVADsSGqIpKNBK5JWnqcXU6rIAhLZIS3BzArgcCxCi4FcdpsQUlgNJmzhPunhfdzPhYe01UCSVnhJ19dhl2sqLnKVl9tHdEcUxosYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073638; c=relaxed/simple;
	bh=lobv1deOUqi60LXcDUSJ+FZCZ7fQF5WMhyZucWAV6eY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g/dK+cQA58erno6VHyKnAky7/mIhhaVkwKfiiE+5/q0qNrbW3wcA0J2K6xlO/yDS2n3HWXjAhh6awp8qpDfIDo85z8lnsynyerQJDdA0orAfW9lUvn4Ko9pJQZL1p5yZ5FURPGn8C38z8sYYoJM1dFPIxUExAa9bfdWOhbxf2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx9rgmZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9D7C4CEF7;
	Thu, 13 Nov 2025 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763073638;
	bh=lobv1deOUqi60LXcDUSJ+FZCZ7fQF5WMhyZucWAV6eY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nx9rgmZYm2sFppNPWRSsee9VzXSE90C3arT7wgDs2v5uH17wCaPk+ZSCWX68pCCJv
	 Ud6oRKX2kSZe7mjOAOe4UylRrc9+uvaaAlmpfE6rpaDBdBolahf5YVv4a3+hEk/BLc
	 RvWyz905JxErqwMG4srq86wsw9O7x8+YZDbssllud34+irxjFI98X+Z1AWLsa7rBe7
	 A2G4x924sa+vnG4so2Z+J/84JLVG+c/LWdcKFBzDnpVuNDfp0BrXHFQHrVqA2BLyvO
	 /vHypLPJomw7poyGZEs8HRl4x3uGaPWzHCIm+RbLcbAhN6ZhKwmC2ItwLYdxpBykrT
	 Nfu1bRHVaxfKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EFB3A54A02;
	Thu, 13 Nov 2025 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: retry bpf_map_update_elem()
 when
 E2BIG is returned
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176307360726.1030856.10620091346821004797.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 22:40:07 +0000
References: <20251113092519.2632079-1-mattbobrowski@google.com>
In-Reply-To: <20251113092519.2632079-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Nov 2025 09:25:19 +0000 you wrote:
> Executing the test_maps binary on platforms with extremely high core
> counts may cause intermittent assertion failures in
> test_update_delete() (called via test_map_parallel()). This can occur
> because bpf_map_update_elem() under some circumstances (specifically
> in this case while performing bpf_map_update_elem() with BPF_NOEXIST
> on a BPF_MAP_TYPE_HASH with its map_flags set to BPF_F_NO_PREALLOC)
> can return an E2BIG error code i.e.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: retry bpf_map_update_elem() when E2BIG is returned
    https://git.kernel.org/bpf/bpf-next/c/93ce3bee311d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



