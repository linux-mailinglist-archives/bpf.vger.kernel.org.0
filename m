Return-Path: <bpf+bounces-70492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8DBC0285
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 06:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09E974E3FA1
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 04:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6317A318;
	Tue,  7 Oct 2025 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsP+s/pF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0C34BA46;
	Tue,  7 Oct 2025 04:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811417; cv=none; b=RiJzdiPLNjCLkj5zHhz7JaR1WYOJqLy7Mk5CeMEJVDy8NSl6Lzt7o92TdfBF9SUoHsn7NJtioLnJcSP7IYJDL2fB/BUbMNnkufn1dZdEKwASjrvlSQf8mc7Mj/UEg7hUh2ZvRh/axZw06sBPWxDUpEHAxY6Autq0yvCYp+jXQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811417; c=relaxed/simple;
	bh=Fars6CA4ilNTXpDU97iagdtg3f/2EPHvkljUA+yZ+kU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qgvxTfWnIIGmmiVjlC/4EKWb0TsKfssGpxf0ZfRoHRayxJRKOUp8IYke5WqHrrmc9jw4XdgSzt7bDFT31/MLrFwadWW2jo61U/KIfJbKeFqczgAEP0H1vm9xApX6Cwh6v1MPOu5DrZ0ICtIurReAW8eEwwCtuomV+XniAtKtRmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsP+s/pF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D88FC4CEF1;
	Tue,  7 Oct 2025 04:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759811416;
	bh=Fars6CA4ilNTXpDU97iagdtg3f/2EPHvkljUA+yZ+kU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OsP+s/pFvPMTi6IHj4X2/5fJBalG+lRd4xF5BM2ro0+oHZB0CQEJUnPPVVfAdmMlK
	 wPbp7m7NOMF/p1UcK4HEWLFpRKX/1KtYWRn7UFsFPmIznX9eRRYH9vKUkbf5eJA82P
	 w/Hm0O7QUG1jonfAlpXVWvTZoT/ozlmvEkcczwhM+watGwnXesxtkYn9sVAjbt4zXB
	 2MQCxI1HU4iHIpRVBTVLCAQXEyPoiPw0w6HG5+U0xr0Atp5738Y8jj+QF348dbCX8Y
	 D4wuxoJh4LkcqsHt04XN34hBPSXyj26DondiVw3dpmBq0OluYpYusAEn275Uj5s7aH
	 olLAePxPFZIXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE939EF964;
	Tue,  7 Oct 2025 04:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix metadata_dst leak
 __bpf_redirect_neigh_v{4,6}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175981140601.1739515.15486628648255293405.git-patchwork-notify@kernel.org>
Date: Tue, 07 Oct 2025 04:30:06 +0000
References: <20251003073418.291171-1-daniel@iogearbox.net>
In-Reply-To: <20251003073418.291171-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yusuke.suzuki@isovalent.com,
 jwi@isovalent.com, martin.lau@kernel.org, kuba@kernel.org, jrife@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  3 Oct 2025 09:34:18 +0200 you wrote:
> Cilium has a BPF egress gateway feature which forces outgoing K8s Pod
> traffic to pass through dedicated egress gateways which then SNAT the
> traffic in order to interact with stable IPs outside the cluster.
> 
> The traffic is directed to the gateway via vxlan tunnel in collect md
> mode. A recent BPF change utilized the bpf_redirect_neigh() helper to
> forward packets after the arrival and decap on vxlan, which turned out
> over time that the kmalloc-256 slab usage in kernel was ever-increasing.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix metadata_dst leak __bpf_redirect_neigh_v{4,6}
    https://git.kernel.org/bpf/bpf/c/23f3770e1a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



