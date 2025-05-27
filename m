Return-Path: <bpf+bounces-59010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D6BAC58D8
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 19:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039BE1BC2E38
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4135D280038;
	Tue, 27 May 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEDTCtuF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BAA27A131;
	Tue, 27 May 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368196; cv=none; b=RO5Vf2GqdhhgDPLrvk0LOzLogfkeWWrvNRi/MTMARY7D6oMnTISDNLK5RJobZ2j/XLS689NmI2s8yekUR2LamHK8Mp4MCFqZJwfX1qBQe5Vv8PSrAraD12IKoyt3sOl//2K3Yl0R9RG8j8jMpAsMrtaYHBSO3CkzwjpDq5p3ccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368196; c=relaxed/simple;
	bh=u6RlqQsVwqhdS3Om0f8q0tySfymkFYitRgLj80KCa5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bn/WWlYCA1e1zEXbTJhx5vH3PhF5TjnFSQ0X17ILrpWMiENNi6OLCeIfz2WYTUQ6L6VyhwgJ3Za7aJAjNMHv3LCvyZrHMmnLLUzk2oJSedJOk3932Mgjes86HEvOga6+NI7FfoxFSHdGms6PuZPcode/i57mlN7wRD3ZpIdYLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEDTCtuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1F7C4CEEA;
	Tue, 27 May 2025 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748368196;
	bh=u6RlqQsVwqhdS3Om0f8q0tySfymkFYitRgLj80KCa5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CEDTCtuFw1ooDIYX4sfCUSahGH7C3UVddOKVbjxZOdSkEU1ycpbBvQhvzUUW+v7NZ
	 bCWDQKSnC3wS5rBsZhgzSHjIlWt6PfKI471dZjG6xvqstPi5nw7mzUmKjVdBG/edl4
	 udcAWIyvXPW0XEP2UVMO1IYPEUNxvo29eSDip5QETOV5abfhMC+0czdU9vq4CKskhW
	 5C3uzOL7/TdTtc0BiufK3ibbHlLm2p+CgHvb1+TeT54QdlLMynqprs88FgGeOS9IXz
	 Ug1/TRlD+2oZKn/fK0QCnuR0O5lDMnXc53qDwr9t4cym7kVHm3ZZRIzgXNLMG10vre
	 STH1WwJ4ldKsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD30380AAE2;
	Tue, 27 May 2025 17:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/1] bpf: fix WARNING in __bpf_prog_ret0_warn when
 jit failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174836823075.1725298.17816488514505670750.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 17:50:30 +0000
References: <20250526133358.2594176-1-mannkafai@gmail.com>
In-Reply-To: <20250526133358.2594176-1-mannkafai@gmail.com>
To: KaFai Wan <mannkafai@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 26 May 2025 21:33:58 +0800 you wrote:
> syzkaller reported an issue:
> 
> WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357 __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> Modules linked in:
> CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> RSP: 0018:ffffc900031f6c18 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc9000006e000 RCX: 1ffff9200000dc06
> RDX: ffff8880234ba440 RSI: ffffffff81ca6979 RDI: ffff888031e93040
> RBP: ffffc900031f6cb8 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b61e010
> R13: ffff888031e93040 R14: 00000000000000a0 R15: ffff88802c3d4800
> FS:  0000000000000000(0000) GS:ffff8880d6ce2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055557b6d2ca8 CR3: 000000002473e000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
>  ...
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/1] bpf: fix WARNING in __bpf_prog_ret0_warn when jit failed
    https://git.kernel.org/bpf/bpf-next/c/86bc9c742426

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



