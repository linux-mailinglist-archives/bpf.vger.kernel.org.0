Return-Path: <bpf+bounces-69858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D501BA4E19
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 20:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FC23A2696
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466430C634;
	Fri, 26 Sep 2025 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCNEVMwL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE915278E;
	Fri, 26 Sep 2025 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910812; cv=none; b=cebDyHmVar6kDYhlkGkFRxUCSLfiGhT5j9pfzU9qDsWL15pb65EyFVthfWW9r8YY8BX2OIW6cvbMSPyDlbvIUiFdNJOVrg/NBfibBJwN38HBZ0tUFLKVL63CkwGVQ/kkM5roNtMKGRUOIWCZrfRxe09rBJqJANM3P4bVoDhgaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910812; c=relaxed/simple;
	bh=8KjxtYBneSqhs2aSNS2njRCWZWfxPB5tyfunMXkN940=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ExukHQedG9Mzjj0VnN2OsPcjlARmRcZ/EnfNbIJkxABHRcoF2FVJCYXqhWiV1MnQGlgAmyQxUYFVWImZh2K9qFmYN0iWwK56q2cFpwrrPezs94XDRTo7oAs0fJroe99n35YyWVhBqz5b8m9nBQfuM3zo2eGdpoJHHjPsv9v0/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCNEVMwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D19C4CEF4;
	Fri, 26 Sep 2025 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758910811;
	bh=8KjxtYBneSqhs2aSNS2njRCWZWfxPB5tyfunMXkN940=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sCNEVMwLZ/y6hiB4JFUljjc5Ibber6pwkRZqZ2gMPvrqL5K4gdXpay/voT7RFMac+
	 SL210rq6Jxb8JHeqSydUDzsPnatFkkH2uJsZJcuIFZRHJG8Ni7lPSFYAanCexE/Zzp
	 gPgpLvIXwRMdW7fsGdXOiB41gHFPRPBric85paUZbLkgaym3/AlVL1xxk7t+D6pYZA
	 YEi7jaTUKO5rRGoH/im8S3qDrnM1gx2tXkkoOPTBsv2g3LtdtGb3Prmsb3PtJgy5lS
	 kDl5ydynl+8oY9IvFwrRRz4+jx6RvPKmOc3169NgYTTTf3Ilt3kfDBwX3rPwSKTTww
	 91W2UkO3wNdbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713F839D0C3F;
	Fri, 26 Sep 2025 18:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/1] selftests/bpf: Test changing packet data
 from
 kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175891080717.14535.11599362718566307637.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 18:20:07 +0000
References: <20250926164142.1850176-1-ameryhung@gmail.com>
In-Reply-To: <20250926164142.1850176-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 26 Sep 2025 09:41:42 -0700 you wrote:
> bpf_xdp_pull_data() is the first kfunc that changes packet data. Make
> sure the verifier clear all packet pointers after calling packet data
> changing kfunc.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/verifier_sock.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Here is the summary with links:
  - [bpf-next,1/1] selftests/bpf: Test changing packet data from kfunc
    https://git.kernel.org/bpf/bpf-next/c/991e555efffd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



