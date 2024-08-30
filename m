Return-Path: <bpf+bounces-38511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFE89654ED
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32066280F27
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FD4D8CE;
	Fri, 30 Aug 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ+DJHK4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72D12B71;
	Fri, 30 Aug 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983229; cv=none; b=OGYddlUWfz7BeE+GDI8vIFTLFyfxtVNJlgkErG81eddKkyDsUUGfgTtigyEl5DAfQ14KVTxUb54iFgasZ3FWaxfznGsXPF5zK/wyT85TJDAmAGW8MQNzijNvoMNdw4dyZOuVEbikGknPF3olcghl0obwMlMebZ33qSRula4AlbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983229; c=relaxed/simple;
	bh=B2HPHms1/46KYw9UCCyoWapPV2HKBQXDMWa9CS2eZzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MuA3nAFigrFUscoEzXaJd3CyMO8Q1v87CWasWFJVEz4WIPLa4ssEnmQekHH2lqkuCpETbv71jd8TxvyC/TP8N2tUN7kMVyjuoYNVgjU+yfSEybKQQawMjrQt+0BrVk3ULiix+4KLeBp2bmkZW1rKb0KnqWDBrIcPTrLFm21CMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ+DJHK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68640C4CEC5;
	Fri, 30 Aug 2024 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724983228;
	bh=B2HPHms1/46KYw9UCCyoWapPV2HKBQXDMWa9CS2eZzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QJ+DJHK43N4Zbe1npGyyHNv50QX9ybNfA7fJWq4RNSj0fNU0nf1Gh2S5xc2XXJb+t
	 MQfE0q1HYAPIldCTdcCUGdCIt19NWmdaO/7g4b8B87uXCqdbW6+Y2tTiebsxVKFLX+
	 VkNAy+OM0LYNFIO6kBUmBa+8HGnZOjXNFMAHP9kZS5K4GxLBjRhCAygDySMCA9/wyu
	 hf9A1SqV3HQ2WwLiNTZswptAG+RG8GaDkk0ZDSbb3naNK/vshTl29mh+YQzgn9Pkx0
	 JpIHj9TzeAINrF7LBo7oDCzXi0Uyej2DSqMah8imfe1Ls+jx8/rjgznGkul48vL1R+
	 TGSGs5gvAlxsw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D71043822D6A;
	Fri, 30 Aug 2024 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Make the pointer returned by iter next
 method valid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172498322987.2141782.12883744896077744332.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 02:00:29 +0000
References: <AM6PR03MB584869F8B448EA1C87B7CDA399962@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB584869F8B448EA1C87B7CDA399962@AM6PR03MB5848.eurprd03.prod.outlook.com>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 29 Aug 2024 21:11:17 +0100 you wrote:
> Currently we cannot pass the pointer returned by iter next method as
> argument to KF_TRUSTED_ARGS or KF_RCU kfuncs, because the pointer
> returned by iter next method is not "valid".
> 
> This patch sets the pointer returned by iter next method to be valid.
> 
> This is based on the fact that if the iterator is implemented correctly,
> then the pointer returned from the iter next method should be valid.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Make the pointer returned by iter next method valid
    https://git.kernel.org/bpf/bpf-next/c/4cc8c50c9abc
  - [bpf-next,v4,2/2] selftests/bpf: Add tests for iter next method returning valid pointer
    https://git.kernel.org/bpf/bpf-next/c/7c5f7b16fe1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



