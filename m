Return-Path: <bpf+bounces-37868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5265695B95D
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22A72856D3
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F8D1C9EBB;
	Thu, 22 Aug 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcHFRiru"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9F1CBE94
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339435; cv=none; b=mH/oCMJ1oQyJp5SjHMYnGciCnBjMcTO5RlJqE7CXdWWFKQgFBp+Dk3dsg2CU114Z5QjHVu/j1JVlDaoSLAGe4Rh0fOfatDgpECxJY/Ki1mBRefzFNQmO0KoTFoohfHKbdV/RCP4Ujimon6PtzAjs5K5xCzVLXlQm/BrER9xh25E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339435; c=relaxed/simple;
	bh=EzRi5GEMYAlLdHEyq+Tt3M1Gbkoijov7TSAuuvzNdFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qgi4LXpPRuk/yuMNgUiUdxkINdgzFIqxTU5ZiZJ02DCNEKn0Qk1tXg5LJpy5hg7StHlBV9yOAJpZCkBw4EXjkTVN1lNrJIO6VAaY92wWCEXM7muU2h6kxc2t1Xb6v2YEQgjoCxz+TvCj5qYRUefOjSIWTKsX1TClHfAV0AAr5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcHFRiru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD76C4AF13;
	Thu, 22 Aug 2024 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724339435;
	bh=EzRi5GEMYAlLdHEyq+Tt3M1Gbkoijov7TSAuuvzNdFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PcHFRiru9ZP1cepIL8gmMoQQvdk0ChPXlm8VACUJMtyTeSr0C6yhUnVj/HANscrcX
	 RRG1zuUPceLWrX8egu0jrVHaLkqib5Uf3rymDfDiy9cJC189H8CkN3Hs7LrBRCRUis
	 tM1b86eX3C4NmKQE7BV2p55BV1YfL+NNO+m9sz/1lkZqfpNpXWsczQ5VpfBSJudLqQ
	 //owzJAplo6hWyavjOLSqLjOT0lmkwF2ATlayHe+1rUHPqvzOmdaUvdP8NTppK7mAr
	 Y7ZKCAeFpH/6UNpPdy5eZQRtWu/VjSHf6V2VoD3BojtV2pgh5W6ucZb0gUp5ZJpXy0
	 VFmmILP0Q3nNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344DC3809A80;
	Thu, 22 Aug 2024 15:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: fix null pointer access for malformed
 BPF_CORE_TYPE_ID_LOCAL relos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172433943503.2352405.13996384805060141798.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 15:10:35 +0000
References: <20240822080124.2995724-1-eddyz87@gmail.com>
In-Reply-To: <20240822080124.2995724-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, cnitlrt@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Aug 2024 01:01:22 -0700 you wrote:
> Liu RuiTong reported an in-kernel null pointer derefence when
> processing BPF_CORE_TYPE_ID_LOCAL relocations referencing non-existing
> BTF types. Fix this by adding proper id checks.
> 
> Changes v2->v3:
> - selftest update suggested by Andrii:
>   avoid memset(0) for log buffer and do memset(0) for bpf_attr.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos
    https://git.kernel.org/bpf/bpf-next/c/3d2786d65aaa
  - [bpf-next,v3,2/2] selftests/bpf: test for malformed BPF_CORE_TYPE_ID_LOCAL relocation
    https://git.kernel.org/bpf/bpf-next/c/110bbd3a2ed7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



