Return-Path: <bpf+bounces-22105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC62A856F1A
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 22:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7474B1F243AE
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53713B78E;
	Thu, 15 Feb 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOnAW+u9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64584139564
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031429; cv=none; b=a5mg+y71uz/IsFL8OhXFjQjRhAEnhAXa3xeKuC8qP6beyM5PHOOyrfG9Z0KRmuVHsO/B3jXp6LYqAjDvwt8Utj/jYQtrRkc2gYBI+DR0uK4UD7ZCnnIplBj9gnNCqSk49pMjwNXxdnBPQenFLB1PKtT8CrcoPQm2DHaiiKth8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031429; c=relaxed/simple;
	bh=/vPNoA3Y/H8eDY4B63c+YcRKkpjAt0yVwuwZoyKJlqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EKPBdrahRbcwmaYuKn2Yx6y5DMbQOr2mVcU8vE9YmkdTDrbUFHORrsSU04JIB10P8hCknCxSMAUyny4vYegityeLyLrOB3Jg92yrzs/LqIaRGUePr5wlex2Azg7HTXUHPFmeAAtFYtBaWJ4rwV1TLb1UMo4kGeOslQqQwf1n2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOnAW+u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2894C43390;
	Thu, 15 Feb 2024 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708031428;
	bh=/vPNoA3Y/H8eDY4B63c+YcRKkpjAt0yVwuwZoyKJlqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QOnAW+u9yGd+BhKtTuuKPmrztwkiAW/GC5J6M1YVR1vBfVcmVUg5zNXPIVraotXT8
	 7oPZnDtT+guqBY1cmRwB/vHfjmIzmdYOEi2v/8RbpHX8TeftwuqTau3DDw++yeLJeC
	 uYqkCTmTgzZh4/aEXSDP+ETWo/LvjEhXPUmxEQPvtv1BF7b1ZjaleWEPY2DBcfvoRS
	 Ckb6tV/XWeQIzZwPXmz43dTt5RYH3z6k9lobTpzYUqsQsCOtO5VeS2x2wWk/KacjNv
	 /uwVYbonQu40tPF2Par4UpnfG1AdPq8pVzkrYnShuvLt/e2WQSrZSwKjWUqCMFQhjH
	 krez6ol6d173Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7E75D8C97D;
	Thu, 15 Feb 2024 21:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: improve duplicate source code line detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170803142874.29324.16767652017654370701.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 21:10:28 +0000
References: <20240214174100.2847419-1-andrii@kernel.org>
In-Reply-To: <20240214174100.2847419-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 14 Feb 2024 09:41:00 -0800 you wrote:
> Verifier log avoids printing the same source code line multiple times
> when a consecutive block of BPF assembly instructions are covered by the
> same original (C) source code line. This greatly improves verifier log
> legibility.
> 
> Unfortunately, this check is imperfect and in production applications it
> quite often happens that verifier log will have multiple duplicated
> source lines emitted, for no apparently good reason. E.g., this is
> excerpt from a real-world BPF application (with register states omitted
> for clarity):
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: improve duplicate source code line detection
    https://git.kernel.org/bpf/bpf-next/c/57354f5fdee8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



