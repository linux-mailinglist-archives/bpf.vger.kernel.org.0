Return-Path: <bpf+bounces-65475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B760B23C25
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 01:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A5C1B60B71
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 23:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3282D9EE8;
	Tue, 12 Aug 2025 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYoA76D7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88DC2F0687;
	Tue, 12 Aug 2025 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039595; cv=none; b=hOYm4IX9IkSFzjJlDdwNj9I0sycqnnvoHotKnLMqJ9xyzBZuHnKqrPb5Gx8eGRMTDw7Kp459mRwm/h0vcvHzas6geB4gMxRlcgUAzBopmrzLp1kO03erF0pH/4GqQjLy0TSznn7YMkkLHsomuEhJi2r0RT2B0MlBNoY+6Rp1xVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039595; c=relaxed/simple;
	bh=fpchoCTZioGd6XRCUCJs0T8y5Ql2Q1u9UY0oUOYuvzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GaPfv3/+41MEMzLrQstnvIthIrJhf4aF+TCo7zH6WRJRPpV18/dG4/NS0qDqEEqMjYoGGE11W6sDjKUQwfqvbA6KH/3ykA7fwwHf+c8OF6BRDElSFUYOsE9tvPan6HuubnN38vzw7RK6UefEVLq2LYGBny7O13TNFPpwnyjfASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYoA76D7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473FEC4CEF0;
	Tue, 12 Aug 2025 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755039595;
	bh=fpchoCTZioGd6XRCUCJs0T8y5Ql2Q1u9UY0oUOYuvzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KYoA76D78cUzEsrGdeDhq8mMz2dFzCUq/WoD3SEp2QkJft1wO8Z3+QHbH+qoJUHtz
	 lqwYGMQBpXhFtUlSgAilJaTKed0V+IDv8q54koyHfVExlB5Hvt9Nko9zfPUmb9DNEE
	 tbtZcfdSbXo+Sg788Je7JFGumhej+VXm9cBf5SIiADnAxTCDDYvGSLkC5/GPRtcJUv
	 aBEdIkWxuCrYggMF0JeKNFCuJrV5WG/U2/YkERCpGYGhSh7SLXesG6xO/raZkK2u2W
	 BHrp/ZyrytErplBRDohjPVfeFejEXtjbsiWepD/sqlVgDvF/dQO+aYeiZL65BoBYqX
	 Cy95cfh2kBDog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CF8383BF51;
	Tue, 12 Aug 2025 23:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: replace kvfree with kfree for kzalloc memory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175503960726.2855347.13670250861747428049.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 23:00:07 +0000
References: <20250811123949.552885-1-rongqianfeng@vivo.com>
In-Reply-To: <20250811123949.552885-1-rongqianfeng@vivo.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Aug 2025 20:39:49 +0800 you wrote:
> The 'backedge' pointer is allocated with kzalloc(), which returns
> physically contiguous memory. Using kvfree() to deallocate such
> memory is functionally safe but semantically incorrect.
> 
> Replace kvfree() with kfree() to avoid unnecessary is_vmalloc_addr()
> check in kvfree().
> 
> [...]

Here is the summary with links:
  - bpf: replace kvfree with kfree for kzalloc memory
    https://git.kernel.org/bpf/bpf-next/c/bf0c2a84df9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



