Return-Path: <bpf+bounces-59418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512D7ACA060
	for <lists+bpf@lfdr.de>; Sun,  1 Jun 2025 22:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CE97A4922
	for <lists+bpf@lfdr.de>; Sun,  1 Jun 2025 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3901EE03B;
	Sun,  1 Jun 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTifknte"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724AD151985
	for <bpf@vger.kernel.org>; Sun,  1 Jun 2025 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748808596; cv=none; b=s8atzd8mYibV+dwFFuUsdi4hOvJi0sRTnUnC1Cm0NokVIAVm4DLHtto4h15C9IJ7ghm9kl2K/qQX1L3SLbFRA63WAMBfirP9FhvRWTcJXw5Mo7YnFwAK129IXImPv8lJhFnt7H/XjYJgJnXC/Jnzq4XtJ+FZOLVxy0cfya3QM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748808596; c=relaxed/simple;
	bh=RV+FpUehgrLBpItCGtZ8odQ+YuPi6wdxf1iAi9Ew0PU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XcaiwBYJ+Ufz5okc6HvEf+HzE1VDfsXr6M3zqmMrGP9dDRes8Px+0k9vPJroXmshHEs/mWB/tc9RdeZk0rGW5Sf2RKbdx5GDnygYshyHuBFrY3n96Iz0cZxbuIU6T7GEt695SBzx5IBMkg8sQkY9K0fmt4yr8bqFQTZLGkEOxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTifknte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4264C4CEE7;
	Sun,  1 Jun 2025 20:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748808595;
	bh=RV+FpUehgrLBpItCGtZ8odQ+YuPi6wdxf1iAi9Ew0PU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KTifknte4+1o40VCImTCqAVP3SATYIjs9YtQuobtpUgb2hwUV2ew/oUayjPfEVZAV
	 af/Ruiaek2ZOLAUfGglf9JMRfE4rQ7F8T/SxX1nCHxEilutlbuxITCNHnlvZ5oEhyw
	 F+PUN6xBVl4HDNnBcDepB/4dLW5EpbcladwDa2CGbMQhEx3ASam7P5tkJRstwKWzTn
	 fKvN+wBC3SbduzOO2UxgMzAGnE5LtLOPG0UTxu+85vaKKvRzmT3AuUv4BSJIZf4Ixw
	 xmigvTeNvj0I6xVerA7gU7xmpcDti8Vj+MYJEMDEMFPEIecOwmoBlcklr+9CRqF8GK
	 spmur6DYnkLWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB08A380AA7C;
	Sun,  1 Jun 2025 20:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest
 btf_tag/btf_type_tag_percpu_vmlinux_helper failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174880862876.496505.9027969429688876815.git-patchwork-notify@kernel.org>
Date: Sun, 01 Jun 2025 20:10:28 +0000
References: <20250529201151.1787575-1-yonghong.song@linux.dev>
In-Reply-To: <20250529201151.1787575-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 ihor.solodrai@linux.dev, inwardvessel@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 29 May 2025 13:11:51 -0700 you wrote:
> Ihor Solodrai reported selftest 'btf_tag/btf_type_tag_percpu_vmlinux_helper'
> failure ([1]) during 6.16 merge window. The failure log:
> 
>   ...
>   7: (15) if r0 == 0x0 goto pc+1        ; R0=ptr_css_rstat_cpu()
>   ; *(volatile int *)rstat; @ btf_type_tag_percpu.c:68
>   8: (61) r1 = *(u32 *)(r0 +0)
>   cannot access ptr member updated_children with moff 0 in struct css_rstat_cpu with off 0 size 4
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix selftest btf_tag/btf_type_tag_percpu_vmlinux_helper failure
    https://git.kernel.org/bpf/bpf/c/baa39c169dd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



