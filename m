Return-Path: <bpf+bounces-60368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CCBAD5F2C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083F53AA111
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71332BDC37;
	Wed, 11 Jun 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm85XNkS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585628853E;
	Wed, 11 Jun 2025 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670808; cv=none; b=CYbZ4RxALhdUFlDUMxuANx6/gEy60bt8YcXb/JomoZeaHA7pTxQLPThi+5i/RZ0EI6qrEywtGpcU2s7UIUoQ2HllOVNbwVD0EFSr3TPdBTM94GvUQ+XiGQ59l0Pq6O+k8YbSUw0vFfBMeLNJ5kSeb+tFB/PEoakhBbzdYMF5jjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670808; c=relaxed/simple;
	bh=P+77/chWEkT7CmAB48ybuVAEZkvc5wpADMBeS/stKf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FKONSRGyzK/3/0AE3vI9wCChA3FDo/s1jQH+p3HvORFX+HHko9TmQRGNFl4XBIVewDcYyYsidpDKgN8Eo6Z8dXYcy/AFyOQkzRotYcg/WPsnLfPns3zqFDXC1p3pC1J1jYbPY9CnDdY2dKKSlcWQlgzo6Gep++1K4ZfamxW7noE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm85XNkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEF7C4CEE3;
	Wed, 11 Jun 2025 19:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749670807;
	bh=P+77/chWEkT7CmAB48ybuVAEZkvc5wpADMBeS/stKf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zm85XNkS7FdAfyj4Pz0aSQ5tUEtqSvr5wyZfp5OWjboW+BHrHtGWFfKJkcnW9B+uU
	 b0Maq23yv+fssenODQNYpzy+VnoSrkCrT/U/KwkDNaXXmyvrjuCEGbRXvxs7Xp1Y1K
	 HqZnGe+vnqEpP2nCyocuKUq2+Pi7atgw7L68KU8UlZHRq/J+N2wipGArkfSMhzMWd2
	 QLwimXXf8vW8LY0UyEFliO3UOOUiQLTampm/oSYAvOqLf4ZZtLfrZzuipgGogm8Sy0
	 lGJmnUO7uXbLb1j39cj4TsASWF5hLHPQ4zlyTsb8hhXsKS1XhwxYeY944mU+qCUI+Z
	 ixngWT3uJDZYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE8380DBE9;
	Wed, 11 Jun 2025 19:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] net: Fix RCU usage in task_cls_state() for
 BPF
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967083774.3454768.14388619349258228793.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 19:40:37 +0000
References: <20250611-rcu-fix-task_cls_state-v3-1-3d30e1de753f@posteo.net>
In-Reply-To: <20250611-rcu-fix-task_cls_state-v3-1-3d30e1de753f@posteo.net>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, yangfeng@kylinos.cn, tj@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 11 Jun 2025 17:20:43 +0000 you wrote:
> The commit ee971630f20f ("bpf: Allow some trace helpers for all prog
> types") made bpf_get_cgroup_classid_curr helper available to all BPF
> program types, not just networking programs.
> 
> This helper calls __task_get_classid() which internally calls
> task_cls_state() requiring rcu_read_lock_bh_held(). This works in
> networking/tc context where RCU BH is held, but triggers an RCU
> warning when called from other contexts like BPF syscall programs that
> run under rcu_read_lock_trace():
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] net: Fix RCU usage in task_cls_state() for BPF programs
    https://git.kernel.org/bpf/bpf-next/c/7f12c3385048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



