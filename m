Return-Path: <bpf+bounces-45645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A8F9D9E18
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB635282D5F
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1F1DDC28;
	Tue, 26 Nov 2024 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSrPqHSt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7D728689
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650620; cv=none; b=TW2XiiEZsICOgDt8ST5aBkdtkS8A5NiwYy5yPggjonJeTQz2g2gPLqFYSq/OKjcyfoinA8OMBdBQnM54n3k9gTTGLi2hh3ADEOKHw//w0rLYR7IHKtTQKo/ZCOGjkyqYJxNwZWUdby99rTkHmzpF4au/p5AYFP+HTCjqfi9J13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650620; c=relaxed/simple;
	bh=1goe9Qd3gVXBV18ZfNe7WQA8yeIEWgVbf3eYcV+ct8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N8PJzQeLJt+FtE7/rl7DH/4AfIN03lQoMkHAj3LmZDWp95yhsGEinljZvI8ea0YbN2D9QwYhbQ5lttiuyFqmHOzZzB46I91bxPcGkAfCmN1ssgBcdHGICBrphl4IUPeClT02m+bhED6Z1vIUi1DbzpXVCNbFOZnb1NaCQ982258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSrPqHSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BD4C4CECF;
	Tue, 26 Nov 2024 19:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732650619;
	bh=1goe9Qd3gVXBV18ZfNe7WQA8yeIEWgVbf3eYcV+ct8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XSrPqHStTDb1jEU/kwrw0HTmDEZZTQ2ZL0hhXf1VgXMy+VvOfhyQDlMhDT1QjrCPR
	 +KUSZd225Wy0WSAzReqp9luV7I2LJoaZu5bG3yAceut6b+G3MPhdUyHFzq/XHuYS25
	 +4yDcdA9jbg6bshsPizjf3Hh/LBhMCUY1ByuSkSn2Z9qokimKhLLxUd5XevtKxWrNu
	 +squfY9Woh35PpDpYXhf6PkC3QskfO28VpGxwhS+epQHYX2bUHycotRuO/EbXU9ShF
	 GymbBuwhYRldOSBvSjweLVnhJgsH/js8avYpRwWV6zyRoS0ZMlQmMhvSJE1Z4l3mEU
	 Xw2c5J06HVLWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF823809A00;
	Tue, 26 Nov 2024 19:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] tcp_bpf: Fix the sk_mem_uncharge logic in
 tcp_bpf_sendmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173265063152.519863.16562098221406143028.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 19:50:31 +0000
References: <20241016234838.3167769-1-zijianzhang@bytedance.com>
In-Reply-To: <20241016234838.3167769-1-zijianzhang@bytedance.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 wangyufen@huawei.com, xiyou.wangcong@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 16 Oct 2024 23:48:36 +0000 you wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> When apply_bytes are not zero, sk_mem_uncharge for __SK_REDIRECT and
> __SK_DROP in tcp_bpf_sendmsg has some problem. Added a selftest to trigger
> the memory accounting WARNING, and fixed the sk_mem_uncharge logic in
> tcp_bpf_sendmsg
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] selftests/bpf: Add apply_bytes test to test_txmsg_redir_wait_sndmem in test_sockmap
    https://git.kernel.org/bpf/bpf/c/3448ad23b34e
  - [bpf,2/2] tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg
    https://git.kernel.org/bpf/bpf/c/ca70b8baf2bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



