Return-Path: <bpf+bounces-20419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CD383E113
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 19:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6291F261F6
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ABB208CA;
	Fri, 26 Jan 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUorqWZ7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B6208C0
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292625; cv=none; b=XZk0EW550w/aaHmOOf1/izokMRbvKYAr5nEH84n6TyHKop1XVOl5cetWcFAsR/mVXV2C2m62jSdSo0OWVpGLPtjK8sENzInTRieoZR3nc5vqBlmvEOFnjwSKAOmt8jTpyQE48f1GmU0K0fzCAqrQibgiQhvt1NI54/Su8sGRR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292625; c=relaxed/simple;
	bh=g0JRLLqebaqqwc51UhTuVaPhuGhvHQADkHOBUhvDz78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a58wifwvJXsJeNUWXwHgs1w9+B/QYi77QYauioLrEGOyuja7Y7ytEDyJzc5mRocOFEnrftk3q38mBCIf3bmZRMXDwFrmi/+sB09jGLfJge+2qKNc0k9YUlauh6OaD7nICGV6pp7XP6UW/h07cji3VOuPbpULm5pfj4PpYImPxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUorqWZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDFEFC433F1;
	Fri, 26 Jan 2024 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706292625;
	bh=g0JRLLqebaqqwc51UhTuVaPhuGhvHQADkHOBUhvDz78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lUorqWZ7ftCPmx0m7mNb4y9nSi23XPl0ITlkDSGMaiBH3ZQCRAusBfHl83O4DT0kr
	 6szYl7r/SA8Z8TciIBlFEljgsqEDqs8uZ/Gr9/NzEsVadMgWbuJj4mALR0N4AZfY21
	 Z2g/tQrwneA6jsbuImHD4V5CdgpaCH5iIEaZ+PUwOnjnY98tgSViHfBQXMpt2X5uV4
	 lrbm4SfOd6aax1VotCy0mNFHmYac0EPcA2ZTj/Mg11S+knsKDwd8+ms+61wFfY796n
	 hfwGVJrhnLbtlUZPUNTaZ5o7ExdoZu5uMqbIkGvzNDjCDkvOuMDk3w9XrPil2VNH59
	 HwI87dJNn5L0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4B69D8C962;
	Fri, 26 Jan 2024 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: Clarify definitions of various instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170629262486.24502.15753507404227221716.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 18:10:24 +0000
References: <20240126040050.8464-1-dthaler1968@gmail.com>
In-Reply-To: <20240126040050.8464-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 25 Jan 2024 20:00:50 -0800 you wrote:
> Clarify definitions of several instructions:
> * BPF_NEG does not support BPF_X
> * BPF_CALL does not support BPF_JMP32 or BPF_X
> * BPF_EXIT does not support BPF_X
> * BPF_JA does not support BPF_X (was implied but not explicitly stated)
> 
> Also fix a typo in the wide instruction figure where
> the field is actually named "opcode" not "code".
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Clarify definitions of various instructions
    https://git.kernel.org/bpf/bpf-next/c/e48f0f4a9bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



