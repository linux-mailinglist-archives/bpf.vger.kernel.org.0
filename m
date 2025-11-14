Return-Path: <bpf+bounces-74564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EDFC5F513
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAA2535C995
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70F2FD7B9;
	Fri, 14 Nov 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyPUH3to"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61F1E1A3D
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154640; cv=none; b=nTsmqBaMucB5SfBruUkxeo7WfRqer8JLbwJTjBCVeXpayerOt5nQWZGiqjV7htokk0Zh9moP3Eec+i6dFsgUXYGqatfpvHXoquXNNRbT2MW75nhQkm02gTfq8R5GDAws4ZWBe+mWkwXUHTfLw1euoNj2X3a1RBkgJZHWWSNEVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154640; c=relaxed/simple;
	bh=Znvtsb8YxwobQuaWe7GIlSz0SN1Nnfv6xFTQtZwPlCU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ea1bigKInh/UAnyNiyOkHjmS/HwRBK0t/n1fHwAP3CmJjPmT/bIIUKAIZotN6qHB5wW/u+9vQMCPr2Bk28r6KtsWdJVeTjVIln9PdQwLYbIPfAAWJ2YBQGzLO8Eeo+rAxeKU6Pgb3RgOMzWEAv8z/kf9svEx+ymYiI+bMpf9K4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyPUH3to; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F2BC4CEF5;
	Fri, 14 Nov 2025 21:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763154639;
	bh=Znvtsb8YxwobQuaWe7GIlSz0SN1Nnfv6xFTQtZwPlCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VyPUH3toXkZyqfAo+ElGJLDsFhzuANZJrR8nmKElwiKgrvxuM4BzfStzzYAjNDAWT
	 epRX0irIJ1cMPxGbJO5koe4K083PohSY81J6+7kUU54t++gmOMOnJjfYngigHtmoVh
	 JAEXqGAgmfzYSV+GU378H3tQ1BLJzOGK7mAbj+fVjsWjymZlLNJc0zT1dTZ4CXVEIq
	 YORnKenerKnpB+qLzkriMMpOovYU5/VEyO8LszPATryJoWzb59DYti+dTxpUsoGGHF
	 Kg+XfRcyiTCS21e1GxzvAqXc8zK2MG+/xWUf4rfceL/dHWYeIySBJhm8+FcvREZZzz
	 WVmFHc48BwtkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF663A78A5E;
	Fri, 14 Nov 2025 21:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: use preempt_disable/enable() to protect
 bpf_bprintf_buffers nesting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176315460778.1836273.16386065785565508699.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 21:10:07 +0000
References: <20251111170628.410641-1-chandna.sahil@gmail.com>
In-Reply-To: <20251111170628.410641-1-chandna.sahil@gmail.com>
To: Sahil Chandna <chandna.sahil@gmail.com>
Cc: yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bigeasy@linutronix.de,
 bpf@vger.kernel.org, syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 11 Nov 2025 22:36:28 +0530 you wrote:
> The bpf_bprintf_prepare() and related helpers (bpf_try_get_buffers() /
> bpf_put_buffers()) rely on a per-CPU counter bpf_bprintf_nest_level to
> manage nested buffer usage. However, when invoked from different contexts
> (process, softirq, NMI), the nesting counter can become inconsistent if
> task  migration occurs between CPUs during these operations. This can
> result in warnings such as:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: use preempt_disable/enable() to protect bpf_bprintf_buffers nesting
    https://git.kernel.org/bpf/bpf-next/c/c1da3df7191f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



