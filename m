Return-Path: <bpf+bounces-65885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D49B2A529
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271597A6F2F
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5F33A02F;
	Mon, 18 Aug 2025 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j092JZBx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D9322773;
	Mon, 18 Aug 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523201; cv=none; b=lC+RFCZkLfKiSBRBw+4UOVyg3eDOr8akbbiS75yMZtU8+xc4xP8mAke89e2Prq6cSl/dQUhg6kxswy/R1HMHILD7dRrQ9eM2xnrE8vpiawIRIQTR6opFTcgUkj6rGkYeA+ZgQnj0YoFR7IjGrzxsZwimP6SYVOwsxW/Np/OZe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523201; c=relaxed/simple;
	bh=DhrOBJkN/7ySaXw7u8RU2aOH47D+rwxpR5UFDr7scHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JrQCQdPKExx7tOl+zzGztzj1UDrpORQQ2shv6jWCdfdvXgM4609asrBm4tAoXJKKEmZYa/AJ5cTKVe/2lp5iHmhJyTuTOWNfsWRbmX3gbFTJQ7UI5UX2gh3ZWNiAHshjQek/mqLJiJLSZ2/tD+Fme0P1TUb8tfA4tuGjVDTqEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j092JZBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F5CC4CEEB;
	Mon, 18 Aug 2025 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755523201;
	bh=DhrOBJkN/7ySaXw7u8RU2aOH47D+rwxpR5UFDr7scHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j092JZBxJjtAsM1fSGc4TPOd5EwqaBj+p/xjr8tjL3/idh+gHDWeAWraFsoP6LRzo
	 ZGiDD+BX+rviAXjl73jX+k9uvwLLc05D0ldhZc+Dc+60SkSCkFhq9T6hAi4Ad07Uz5
	 ZH/mPoFDfK0pbGRJzvMou58dB8KJaKO68zjbBqezuDkd6+/2k5DAMQSUkpk2uah0mO
	 xhOPg4bTrkiKD00KWmvcvLAPLaAe0idirp+AmjJoM/M5/1MzTEwQXA52Pt+xFYWziB
	 mfU7Wav7Lcw+NwRYiaoK4ORGgAnf/haQ8iha5KmkY5iHwP466cwYQzLyE2ail7krfi
	 dQ2hm8tseUuTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9C383BF4E;
	Mon, 18 Aug 2025 13:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Replace get_next_cpu() with
 cpumask_next_wrap()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175552321149.2749470.18443459435706702983.git-patchwork-notify@kernel.org>
Date: Mon, 18 Aug 2025 13:20:11 +0000
References: <20250818032344.23229-1-wangfushuai@baidu.com>
In-Reply-To: <20250818032344.23229-1-wangfushuai@baidu.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 18 Aug 2025 11:23:44 +0800 you wrote:
> The get_next_cpu() function was only used in one place to find
> the next possible CPU, which can be replaced by cpumask_next_wrap().
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  kernel/bpf/bpf_lru_list.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Here is the summary with links:
  - [bpf-next,v2] bpf: Replace get_next_cpu() with cpumask_next_wrap()
    https://git.kernel.org/bpf/bpf-next/c/d87fdb1f27d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



