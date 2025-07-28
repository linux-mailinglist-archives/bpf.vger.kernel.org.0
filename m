Return-Path: <bpf+bounces-64543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB6FB140F9
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 19:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DB416BE9A
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39A9275AE1;
	Mon, 28 Jul 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFo+AZCO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D67275860
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722598; cv=none; b=P4yx/LsSrLnHvCWesBWR03dHBUM/eHDtO6O40nyHzo37+F3x/l0Ly5p7QjGFefMVH+LSNBXg0p5FJWpIGDK3gNtf6/cOnxvg1s6V/OK9tFuJ5toJVwylhLM2gIM1YMexQdOkhdRuFKFl5b2d+IJVmxRVAwUM+mp0TDpwNgpxnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722598; c=relaxed/simple;
	bh=CVNbSOFFjYBpbk1+dD2dqT8gj5uGzJl4/nVdZifJSJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nb8GwUH/qcZOrEhG/YrXoPrqoHnJVWq7K6TatlwiZ3UEfB1je0lt2bYRJV5Z5hJD5/v6Ld6MzKYjWwV1glUckcP/nYZNwgVRRYnGnnYIjivUUCzW+zP6lz+6kzZyDb5VTeOBJFw2CrwHcZ3fKWsEPNf013q2PBk4PounOUT4YNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFo+AZCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9D5C4CEE7;
	Mon, 28 Jul 2025 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753722597;
	bh=CVNbSOFFjYBpbk1+dD2dqT8gj5uGzJl4/nVdZifJSJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YFo+AZCO1nrysR31cJhPL5DTejwBhrRBClESE24xH6+GihpD0p/8xmjZwpF13jOv8
	 FJxcw/JL9BXdXWNiTnKgEHgBi0iX2DWCAP8munnd99tEwsDUpsyDa/YJ2BbZNJt5dZ
	 Gn6fo+9Brf26fRdsH1tSMrUaR7dWSy71VHNuOUQ8U2jjipLhJ6OqtVmTC01cNBBYQW
	 vWF/IN5nzb5SL+hE5VCICrld+qLJ98iGHrMexCwhgnb9cjsNW/t1nBZstLQMHhDpWK
	 MlmNQImuy5UnMmlS+6syA3jYwB1RmAUPwdadp1bYYJsQSCu/bObXx+LEdTje2lMYhM
	 5XwPCmoiLjUSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D65383BF5F;
	Mon, 28 Jul 2025 17:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/5] bpf: Improve 64bits bounds refinement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175372261425.782645.17863794939852326898.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 17:10:14 +0000
References: <cover.1753695655.git.paul.chaignon@gmail.com>
In-Reply-To: <cover.1753695655.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 shung-hsi.yu@suse.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 28 Jul 2025 11:50:01 +0200 you wrote:
> This patchset improves the 64bits bounds refinement when the s64 ranges
> crosses the sign boundary. The first patch explains the small addition
> to __reg64_deduce_bounds. The last one explains why we need a third
> round of __reg_deduce_bounds. The third patch adds a selftest with a
> more complete example of the impact on verification. The second and
> fourth patches update the existing selftests to take the new refinement
> into account.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/5] bpf: Improve bounds when s64 crosses sign boundary
    https://git.kernel.org/bpf/bpf-next/c/00bf8d0c6c9b
  - [bpf-next,v4,2/5] selftests/bpf: Update reg_bound range refinement logic
    https://git.kernel.org/bpf/bpf-next/c/da653de268d3
  - [bpf-next,v4,3/5] selftests/bpf: Test cross-sign 64bits range refinement
    https://git.kernel.org/bpf/bpf-next/c/26e5e346a52c
  - [bpf-next,v4,4/5] selftests/bpf: Test invariants on JSLT crossing sign
    https://git.kernel.org/bpf/bpf-next/c/f96841bbf4a1
  - [bpf-next,v4,5/5] bpf: Add third round of bounds deduction
    https://git.kernel.org/bpf/bpf-next/c/5dbb19b16ac4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



