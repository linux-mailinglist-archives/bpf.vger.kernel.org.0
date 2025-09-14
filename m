Return-Path: <bpf+bounces-68342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD83B56B73
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 21:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2563A189CF2A
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE392E03EB;
	Sun, 14 Sep 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fba/28Ew"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A72DFA32;
	Sun, 14 Sep 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876420; cv=none; b=oEdfzGRtMLqRGSxFPrSCIGUOeEHFMe03Rqs9UDfUJBEZ6rZd0dTfZrNBW7sJMHmbJjXiNCVInnGsXb078kYCEPuwhMS00oAgktrDy5A6RDUZByXzl6RjMsd2lAurcUVg7KCMxa0nqzCy5bgc+5dFTRFAJ/NKFqTtPzBIlZdCntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876420; c=relaxed/simple;
	bh=HXWTvZ0Rfo/S/tKkpVHE0VLWYEThtftZvmLT4n48M80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sKZYao0agPbp0BH/66x0QPrYmnUx6h56awpNx/BZfK428VwORVeKHjrla7T4MLxEM87jB4m38YKY0nBAZFsm3E+pzQZiryX4pDTyxbzndmeeg5OJAAmrf8PbY9jlOBN7u0zQFvEOPlmMKhcnuMOfZtgN9w063yO2XWHy2DsdQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fba/28Ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DF2C4CEFA;
	Sun, 14 Sep 2025 19:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757876418;
	bh=HXWTvZ0Rfo/S/tKkpVHE0VLWYEThtftZvmLT4n48M80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fba/28EwLh2TRwkN1ZwmwMKwxkikPrdlXpJJzBHqHRg3oq/Kf5N8arIACMg1IeNNq
	 xLp0oytxQHtqtHwsOLhevzOOOUDes+fclsXbaSK6JJTSWd8OT5TRrIQ0rg+UvZ0s/a
	 w8YiHHlv4t6CU41zaM+7/pWFMti9XqeTPJ9cycsof+ORyQx3YMv2RAwHifmc2+U5uU
	 AsSWHIeqxGcH/qPlcoBAd7ou4+DVLcinzYomhpze+x/EcHz3IoQh+0UknF2KUUkesi
	 xD+hO8KecAPTna8zK88drNO3UjGj1tqv/r7VprCS0R2pqwYpGAGKcrYleSwGG+xrK7
	 AUACMWhWFhOAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8139B167D;
	Sun, 14 Sep 2025 19:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 next-next] net/cls_cgroup: Fix task_get_classid()
 during
 qdisc run
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175787642000.3528285.12140096607438105996.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 19:00:20 +0000
References: <20250902062933.30087-1-laoar.shao@gmail.com>
In-Reply-To: <20250902062933.30087-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
 bigeasy@linutronix.de, tgraf@suug.ch, paulmck@kernel.org,
 razor@blackwall.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Sep 2025 14:29:33 +0800 you wrote:
> During recent testing with the netem qdisc to inject delays into TCP
> traffic, we observed that our CLS BPF program failed to function correctly
> due to incorrect classid retrieval from task_get_classid(). The issue
> manifests in the following call stack:
> 
>         bpf_get_cgroup_classid+5
>         cls_bpf_classify+507
>         __tcf_classify+90
>         tcf_classify+217
>         __dev_queue_xmit+798
>         bond_dev_queue_xmit+43
>         __bond_start_xmit+211
>         bond_start_xmit+70
>         dev_hard_start_xmit+142
>         sch_direct_xmit+161
>         __qdisc_run+102             <<<<< Issue location
>         __dev_xmit_skb+1015
>         __dev_queue_xmit+637
>         neigh_hh_output+159
>         ip_finish_output2+461
>         __ip_finish_output+183
>         ip_finish_output+41
>         ip_output+120
>         ip_local_out+94
>         __ip_queue_xmit+394
>         ip_queue_xmit+21
>         __tcp_transmit_skb+2169
>         tcp_write_xmit+959
>         __tcp_push_pending_frames+55
>         tcp_push+264
>         tcp_sendmsg_locked+661
>         tcp_sendmsg+45
>         inet_sendmsg+67
>         sock_sendmsg+98
>         sock_write_iter+147
>         vfs_write+786
>         ksys_write+181
>         __x64_sys_write+25
>         do_syscall_64+56
>         entry_SYSCALL_64_after_hwframe+100
> 
> [...]

Here is the summary with links:
  - [v4,next-next] net/cls_cgroup: Fix task_get_classid() during qdisc run
    https://git.kernel.org/netdev/net-next/c/66048f8b3cc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



