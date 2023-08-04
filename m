Return-Path: <bpf+bounces-7057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99570770BFD
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 00:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAADC1C216B6
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85F253A0;
	Fri,  4 Aug 2023 22:40:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A81DA27
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 22:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59764C433C9;
	Fri,  4 Aug 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691188822;
	bh=Q1x89Gu3kkriJCoxnWjw3AsJ6ttpxf++BuC3nSzkZOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UMzHAtR5vQqk1Mwf2fOFARDhjtTP7o4hALQld+c7el57zqKvcJ2xkmqbKXz77Zjtt
	 LWoTIjMdk9fYhjLLyJhf3gXsnAStJE1ypUEqrSp/ywmmDIDOYa+sJG9ccHJYrgvNV3
	 w6t6Ea7EvsxlMCV1TFmVjKHU96TlQFPE+LiZXZoOWAbgE6IFRbGgbg3TRs7S6dnds1
	 nbu6BCXH2Dy/+Q4F7pkYmW2DEzuQHENaISUjYxIs70umQl7J5JNkUtfQp2WPu2/SbD
	 +33GQuY741gJECJlqypsZ8mM8rF/Ql+X0Yv87L1fnuje6Um5hxCDNIjNwwW/SRJBMM
	 yp0OiBShw/rnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31B5DC64458;
	Fri,  4 Aug 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] bpf: change bpf_alu_sign_string and bpf_movsx_string to
 static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118882220.4114.11393000838506374611.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:40:22 +0000
References: <20230803023128.3753323-1-yangyingliang@huawei.com>
In-Reply-To: <20230803023128.3753323-1-yangyingliang@huawei.com>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev, eddyz87@gmail.com,
 quentin@isovalent.com, ast@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 3 Aug 2023 10:31:28 +0800 you wrote:
> The bpf_alu_sign_string and bpf_movsx_string introduced in commit
> f835bb622299 ("bpf: Add kernel/bpftool asm support for new instructions")
> are only used in disasm.c now, change them to static.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  kernel/bpf/disasm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [-next] bpf: change bpf_alu_sign_string and bpf_movsx_string to static
    https://git.kernel.org/bpf/bpf-next/c/09d15054c467

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



