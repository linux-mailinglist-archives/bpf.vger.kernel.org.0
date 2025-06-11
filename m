Return-Path: <bpf+bounces-60338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2878AD5B4E
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91063A6B23
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FFC1E9915;
	Wed, 11 Jun 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE8Gi/Ir"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEB1DED6D;
	Wed, 11 Jun 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657603; cv=none; b=bu0Mi4iWh5xOHUDZtFgn+Bg0/oA8VP+6DiFkqfXVcOKCV055YfoqBSspDCT7zyjocqyLXuIlui+latjnt2g/if7oJOfCuKk8hZusG95WGhupLcNmTiiAe0N6ZcZLOajJ4wuFc8iisv9V0H+d8A1Av1eM78ozEnXXAI1BmSpFmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657603; c=relaxed/simple;
	bh=8T/9FFc74gQ/xdRdqp0xuQKAL3xmTEUyUa0P+Ev4CP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kGKRUdzKPXaNekXRi+gy51Pa5DfWAJwuXkl00jfh+oSBZWn0nMJYY/v4AFXZKrUwnxNoJLA1fsLMLKyHJ7c2m5rTloh99O/m1cHKxCqc3yLHMikmQtHc9eDGbervevXMuDkkMqmTH+kAaScLd2flf598k2DrV3jHQ5Ih3wdmGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE8Gi/Ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F78AC4CEE3;
	Wed, 11 Jun 2025 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749657603;
	bh=8T/9FFc74gQ/xdRdqp0xuQKAL3xmTEUyUa0P+Ev4CP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NE8Gi/IrabTcH7jsfcaOGJHq2R+eOPHJR+KfW5kywPTSXTJqDFpWe8YRjT/2e9HRT
	 56QEQCQjmy6YtXmfZjDdOII19AVZPJngz/vtjEgXiZf8+BaoHcjALXis4gjxAwlS7F
	 /8jJZDi2WCfVdLVF5Is3cTQpFT0nYKI3yKPSkRhxJhalsXcO2+vnYcwB2t399n9oEQ
	 sBZKAmnKt+ej/pdp5Lu0KYIewlfDuc+NRnlbE3YZJmqVbPED3oWEoX5gqRXwtzGDuk
	 WMug2NCOFVFUtiug49E5aBbwDdbaNFxwoCadgeDLGMRwIUiZWO4qzFrQjDgSk6xBPK
	 xNdkMrpXOlPcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFEF39EFFC5;
	Wed, 11 Jun 2025 16:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] net: Fix RCU usage in task_cls_state() for
 BPF
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174965763351.3384611.4699133562202888154.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 16:00:33 +0000
References: <20250611-rcu-fix-task_cls_state-v2-1-1a7fc248232a@posteo.net>
In-Reply-To: <20250611-rcu-fix-task_cls_state-v2-1-1a7fc248232a@posteo.net>
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

On Wed, 11 Jun 2025 09:04:06 +0000 you wrote:
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
  - [bpf-next,v2] net: Fix RCU usage in task_cls_state() for BPF programs
    https://git.kernel.org/bpf/bpf-next/c/bdcaef7b8815

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



