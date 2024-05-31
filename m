Return-Path: <bpf+bounces-31074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D68D6C1A
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 00:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D205D28662D
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 22:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48E681725;
	Fri, 31 May 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu5JrQEb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA727EF10
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192880; cv=none; b=BTgeJxMh+DIn/aBuoPIupUd9sE5NAeqttkOHqq28CwWbXW2HoNNQS8UWA3CSHlKp3T1eDqXkiD3dIzxismYfet0cZK4/jHRc0PeA4oc5QxyEnIj07N9M9yeDczu5NoQ5qM5emDBO9X/7MPUex2EP0ZFyMoh+9hhjfCmv1lDo0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192880; c=relaxed/simple;
	bh=TyT3HooMUJ3zTWBBdNoT1GhpJm5S/ZJA51MfmiAEy10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S12dpu5gDTLzvaS+s1DA1D+kP1gp+GGd35QqOvb88UAsOIXKzK8/1Z2n0T0ib6vCOIuxSMY3geJpPbgPvvL2qX6OMG+GRTvAftpoEd/1unQnZ6nH7X+UHFogDQg00MYdzdApWctlC6oKQ6GSwZZwPDE2+lORKo+BOQGTf4TfiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu5JrQEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18684C4AF0B;
	Fri, 31 May 2024 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717192880;
	bh=TyT3HooMUJ3zTWBBdNoT1GhpJm5S/ZJA51MfmiAEy10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hu5JrQEbVkuzM8efu/WVPUOrLFxIJeyWpib6NgrJwn/1TtR60bJb4YZjwi403yqrW
	 dCR6xjKfj5inikwPel/u1QJ1PmTTQ5gIjAMjdk0xC3H2Pw+4oosJWsbXTWC2mAsSDR
	 b6LGgK65AxxOpd4izitgNrrfaJcLp8QbXmFEzZ7eBjomdea1nt3NGNvryFodVWOBFD
	 TlaoD5Ja3Xsd3UWrbCh4jhIHEZ5cdjZB0dnEqRh8gka2teItUjNj/TWXADk8rHrDnD
	 qTBamd1XT+WFNcDxGYHoNk/zBorVGxCNvhYcvWNjXW3kVxmMsqIK4cWChvCH5uwD49
	 hjKXFOXHb/Jpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01F81DEA710;
	Fri, 31 May 2024 22:01:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: don't close(-1) in multi-uprobe feature detector
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171719287999.16477.678713030026373386.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 22:01:19 +0000
References: <20240529231212.768828-1-andrii@kernel.org>
In-Reply-To: <20240529231212.768828-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 29 May 2024 16:12:12 -0700 you wrote:
> Guard close(link_fd) with extra link_fd >= 0 check to prevent close(-1).
> 
> Detected by Coverity static analysis.
> 
> Fixes: 04d939a2ab22 ("libbpf: detect broken PID filtering logic for multi-uprobe")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: don't close(-1) in multi-uprobe feature detector
    https://git.kernel.org/bpf/bpf/c/7d0b3953f6d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



