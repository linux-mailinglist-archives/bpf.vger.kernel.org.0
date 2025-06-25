Return-Path: <bpf+bounces-61593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19265AE90F3
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96208175071
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F842F363E;
	Wed, 25 Jun 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnkGhDRH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175E1F419B
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889994; cv=none; b=NI57Cugqip3BD8tmIegeXdloIZKbk+4ygg/FAnQ4IuD4De9QqK+uppHopRrTLu8mQuxmBWTkiaYsgGB4VEakEiQ0AU5c6EoNF5ioLc5FT8fp8s94/5D01fShtCSclhE2bwZPm8+KD0xo5rMcXncqmabHVC55VhC+XWY8+hHUGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889994; c=relaxed/simple;
	bh=UpcvlpABBMFYHOnbPBO3/1jQM1g8BtINfVQarONZGQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o1u1jBN3zLe1a/TxOg5mWqbpZj8Z04FyGbtx0uWzHuBO8jT8pKX95kJr2UjHj81hk+7tprtfC+m2jtGECa4w6HiNHnCZhaaE3pwHqFfIIkONasPw60mYke3l+MXyG8jKZpv6lLw6g/f57WJIkqLCuVnI8PNzBUqT1mbjqy1Tw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnkGhDRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793FEC4CEEE;
	Wed, 25 Jun 2025 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889993;
	bh=UpcvlpABBMFYHOnbPBO3/1jQM1g8BtINfVQarONZGQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mnkGhDRHcnmYZ9TevTrxz+2T6OTMRGihxigabW9ov8zq/DJe+hSQVZL4llNUjDKai
	 rpI3aYqZQtudjYPAT8VcXxy2Ty3pvNjw0Vt4Yi7Pvz7hnbF8z3FpeJDgeVkaYph2RT
	 Rb941gunHQvy3q2UAbM7tEZFRSVYzcjAIGAEzQzGdEY6E7sIkNIghL1sLWGcETu53F
	 sM+nZC86xa4iYR/3NvBmHLvFX4Hdoslrz5QYyi/d87bfXpsR8gfQSizV+Rq2MrzDY3
	 gsNwD04UVQdt5DQJd3T0GsejHVw8Dz4cTwaKNRdddpbSTAFSkyvNehKUM+qP/u714j
	 kXsw5zmRbd1cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7E3A40FCB;
	Wed, 25 Jun 2025 22:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: add btf_type_is_i{32,64} helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089001999.639228.605549449250222149.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:20:19 +0000
References: <20250625151621.1000584-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250625151621.1000584-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Jun 2025 15:16:21 +0000 you wrote:
> There are places in BPF code which check if a BTF type is an integer
> of particular size. This code can be made simpler by using helpers.
> Add new btf_type_is_i{32,64} helpers, and simplify code in a few
> files. (Suggested by Eduard for a patch which copy-pasted such a
> check [1].)
> 
>   v1 -> v2:
>     * export less generic helpers (Eduard)
>     * make subject less generic than in [v1] (Eduard)
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: add btf_type_is_i{32,64} helpers
    https://git.kernel.org/bpf/bpf-next/c/d83caf7c8dad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



