Return-Path: <bpf+bounces-31348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B078FB808
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A191F23178
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A9149E00;
	Tue,  4 Jun 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sga6/YSt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E036143C7B;
	Tue,  4 Jun 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516229; cv=none; b=eyo+eGortI5n/HB4Gon3EwLDeqZHEPXp9uxk+uNUaPPe2z4pcCYoKXjMoR/yT+gUkmmXa6OX2Ks5BXV71m+GsctVDqubzsVrO1beJTKC+dRCG4iJcFz4EIMaaIBH9YthMPp6ujcaiMIWwzdH42CBGjO0hq6OgNpDlxchn0G2sJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516229; c=relaxed/simple;
	bh=jL71Hp5r5p+U0n9OmOXNrzIVQ9YlWJeUDau1mqtyMjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KAu0ATQ1mlPimT5bIjp1qmpwhXfggW9wPpT4fNlx5yey665JYeDLJ17+aa47N1kFl3LWuLENATTWenRNjvflTNodH0P9bh9w3g5OHOWRgrbKWAzlFplxYQPqYVxa6tXR3PHYUU2qXPrYY6dJwdWmBtxKCo5WVs0KpiwuvqigAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sga6/YSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2E45C32786;
	Tue,  4 Jun 2024 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717516228;
	bh=jL71Hp5r5p+U0n9OmOXNrzIVQ9YlWJeUDau1mqtyMjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sga6/YStdCX9i0ZuN9aGYV9IcCqUCzMNJflPvhqtAgWoYq2dtlPuwrm95lgt0lGaV
	 v8RyHM5WB9UlJSTmM/5nCzlqzUm9YVY2yR+6cAnKA6kn/O+ebj0h6gIxNnSWpPziJR
	 RbzInHU3qbt04YjstDJBq3ds3hr+fX47nIozPJ3+CnLKhH3UYxrvUh7y0HlVodRBDR
	 TmlZA9QPqnOZa4fDer8//lcya0a6KvtpX3hrP+hmSnchr3iZNcsqAGh/qEzOBfjtsD
	 PrMUc8MYBrsXcyYM6uJ1/XR428ZiTYJz3PjpO72/egzFZZflgdEDCWfLPNUp32UC0P
	 eGi414HzfwqMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FA49C43617;
	Tue,  4 Jun 2024 15:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch bpf] bpf: fix a potential use-after-free in bpf_link_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171751622858.21059.9816190030253972766.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 15:50:28 +0000
References: <20240602182703.207276-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20240602182703.207276-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, cong.wang@bytedance.com,
 syzbot+1989ee16d94720836244@syzkaller.appspotmail.com, andrii@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun,  2 Jun 2024 11:27:03 -0700 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> After commit 1a80dbcb2dba, bpf_link can be freed by
> link->ops->dealloc_deferred, but the code still tests and uses
> link->ops->dealloc afterward, which leads to a use-after-free as
> reported by syzbot. Actually, one of them should be sufficient, so
> just call one of them instead of both. Also add a WARN_ON() in case
> of any problematic implementation.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix a potential use-after-free in bpf_link_free()
    https://git.kernel.org/bpf/bpf/c/2884dc7d08d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



