Return-Path: <bpf+bounces-43652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA79B7E85
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00081C23883
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C51A254F;
	Thu, 31 Oct 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQzU+5mX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150019E7EB;
	Thu, 31 Oct 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388623; cv=none; b=emlUc5D57zHg9YkZx7L3TlwWqSiLJSmDdAa4XE9xvzB/VSjHy2h6ClSI1IPPGuwe5rLn6nRuk9ywvttUjr+hkrT30Q8Hw09382gleYNBLVQy92RzXb2HHNjFeVqGnj1zPcMbXOBrWAJnlbCb6SBfN5bgcYVYY46L77sJFIp+pBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388623; c=relaxed/simple;
	bh=OvzSifmX4gwDA00DM+e60niTQxZ4iyWIF7c+fO+Tc60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PZcsko+s/8LIFpNgAHblEfMmNhCXBmTC9eBymmHN/UPW0kYS26GicAs94/+tPjpyFglzeawcAwiMCdfBsbHnjgHnkv14GNgcsr/0x6UoD80viqp9I4wNlM/XL13pwoLuQtc0o7mL/XrcXr/nohcwAtJMxp/xjqGpDkN1bpdlLj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQzU+5mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A74DC4DE03;
	Thu, 31 Oct 2024 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730388623;
	bh=OvzSifmX4gwDA00DM+e60niTQxZ4iyWIF7c+fO+Tc60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nQzU+5mXm0F0SZGc7/g6+7JJdaxLLP4Wbt7FmYSZQNTYIxHyIdpsLQK9MG3XdbCop
	 YckXd5jpixxbNhoU4FgJfIrgFS3CA3DBr6tjUfs3gCg6fcEdALXXa0MjsfIluZWz8x
	 wL1xvgB8OdN7XxrhLYWY0mLj6THS5Q8t49GdOq5lS2JobgiWClE6gZO/Bg5ZASr2oV
	 Lglip5WgThmA/lXyvEJz6M8rud1mhrMD4ezVy4k0kslngj2oo0BouPCsa6dxOducZt
	 G7HT/ISorhuMS7Az5Kd7dkCgCjr4/LXuldqWSBazrNhdH3IoW58Vd/AloHpEq2FbaQ
	 aNlNrg3udzlGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D44380AC0A;
	Thu, 31 Oct 2024 15:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf, test_run: Fix LIVE_FRAME frame update after a
 page has been recycled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173038863101.1997785.11856320294725217143.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 15:30:31 +0000
References: <20241030-test-run-mem-fix-v1-1-41e88e8cae43@redhat.com>
In-Reply-To: <20241030-test-run-mem-fix-v1-1-41e88e8cae43@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, aleksander.lobakin@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, syzbot+d121e098da06af416d23@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 30 Oct 2024 11:48:26 +0100 you wrote:
> The test_run code detects whether a page has been modified and
> re-initialises the xdp_frame structure if it has, using
> xdp_update_frame_from_buff(). However, xdp_update_frame_from_buff()
> doesn't touch frame->mem, so that wasn't correctly re-initialised, which
> led to the pages from page_pool not being returned correctly. Syzbot
> noticed this as a memory leak.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, test_run: Fix LIVE_FRAME frame update after a page has been recycled
    https://git.kernel.org/bpf/bpf/c/c40dd8c47325

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



