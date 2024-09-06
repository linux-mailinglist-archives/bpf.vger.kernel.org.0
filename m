Return-Path: <bpf+bounces-39084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CBC96E6A1
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 02:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B11F23491
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 00:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDD5819;
	Fri,  6 Sep 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV765uYG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAD629
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581433; cv=none; b=CwiBc00/a/jhyuyA7CYMyW7bzOQS+GZu8/ArY6BT35iRuTBz8Bz1VXmfDAFcClUJB6lFLtu1Et3e4aQzzvuCB2ws/xhiD1gunMBbRALBeFHj5+muKW5qfNDElr2py5ZpRJbmMdXA5NxKC1EaPA8AU3U+1NzMEcx57aj3hNV371c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581433; c=relaxed/simple;
	bh=Ttw+5M5m6Yk1TCqNjgxJQl30H7KKV2TLpqkCqDYmdJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EejOOw/BbIuQCKqQNs59rs1lFE1M9YrREmsN5Ehh1/bSO55WRJTnNfq3BvXQgRhja063CMatWdZGyOJzrUB1aJ/5IYNQium+7jKGksctBtsJRzDOWLZeGGMFmWV7B0VGwHQxP/sAbPfrnnWU+TBIt7KfAhrY95Ashd6fU0eyKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV765uYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA7DC4CEC3;
	Fri,  6 Sep 2024 00:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725581432;
	bh=Ttw+5M5m6Yk1TCqNjgxJQl30H7KKV2TLpqkCqDYmdJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IV765uYGp78DA8qdpLLX+z16Hfvzn8yuwIcBq4HA6nHlK2ucwldT3Iy8sTrIdcsui
	 RMRCd6hNKk4i9b+ZG7aBGt+mdN2ZS2Uplti2Oyaz3kYq5oIXUxKFvSCC/4S5Wf2UPM
	 u0MFloRnUbatRCFlwmnkPrvenadjEIt5TxnelhwH2ukC8bA3xT0szG++mEFtVF5ehe
	 hrjsrsQ7s01OyIfp9mR1yjkpUpjjJs0pOHb9h64PSe9mJHGNnbSQizrCkys/MDj4WG
	 0qn6ejEhLlO9U/hCT8yYi7GYKRPp2u3TBEuPsJq3AUoGe6+us0Rjr7v+Wpei8hHT5W
	 oFONOZy9P9qhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3A13806654;
	Fri,  6 Sep 2024 00:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: change int cmd argument in __sys_bpf into typed
 enum bpf_cmd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172558143375.1881463.18367037269892472184.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 00:10:33 +0000
References: <20240905210520.2252984-1-andrii@kernel.org>
In-Reply-To: <20240905210520.2252984-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Sep 2024 14:05:20 -0700 you wrote:
> This improves BTF data recorded about this function and makes
> debugging/tracing better, because now command can be displayed as
> symbolic name, instead of obscure number.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf: change int cmd argument in __sys_bpf into typed enum bpf_cmd
    https://git.kernel.org/bpf/bpf-next/c/2db2b8cb8f96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



