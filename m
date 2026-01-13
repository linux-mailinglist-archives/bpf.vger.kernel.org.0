Return-Path: <bpf+bounces-78637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F6D16468
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C3303012CED
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 02:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600712EF66E;
	Tue, 13 Jan 2026 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKT0E1aw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359125393B;
	Tue, 13 Jan 2026 02:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768271309; cv=none; b=pdyn7DUHlv6waskH673UvMqtYkgZ8N5RxNdGWu76KOtJo3vtiUhMyEtDAjOY0abO7jQtFOd3uKLB56duke9mBxke527WEzqWml8YnIsLjx5ZuQQIfw+T1ZCHWBPmfjGunDNBdQg61jjk0lY5sNH32wL4B+d/qVCcDfrJUiVCed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768271309; c=relaxed/simple;
	bh=3ODfP5lodPYJ3ACrnsiZdAIgL7loZ95W9fuQfz7CadU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EJgrFxfpnFzkQoTxgs4+9td4kJ7ypl5/4FVQ4M+Ws5TgANH0BQkyRB3QsNaq5x+0/WQWeGdt5QKQd5NOdgROpct5/UyyrONz+X45TV7BsJntZfYPPrfqBQSpY9Q1U5e6n5GIkLDSySLBVjI3E2+HEmqZrriIqIrSW+pb9VXi9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKT0E1aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72082C116D0;
	Tue, 13 Jan 2026 02:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768271308;
	bh=3ODfP5lodPYJ3ACrnsiZdAIgL7loZ95W9fuQfz7CadU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QKT0E1awzMVBtMBpIdVgjg26XOPtRi8SIbjJgqXEEX3SlBVzsCtX85xen0ciqRyC3
	 qqlRfl4iQvbr8OMkSHXRgCirSueKm/fNc02Onla+qUID5lPkd8erwLubZfGBHZisyY
	 Uc3D/vgIgnNR+x+M27CLjfW2uGo9WqPlwxCzJfi+yDuKZQL7gA49oWWVdGVuWilSPG
	 +38THnfkZ8eUH5dA8Qskouinc7Jb7iTsFTCSzIFDIO4ASAI2gLiKrEz9M/q7uqXI6r
	 sNGQ360HjaW1gV+omSa1I+4eBTgk9X5uT9dn7JKPCPaK7CgAxGQzcBS9gli/0k1whV
	 myOraGM/PtOEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78DE5380CFDE;
	Tue, 13 Jan 2026 02:25:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix reference count leak in bpf_prog_test_run_xdp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827110202.1606835.9428948719532592789.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 02:25:02 +0000
References: <af090e53-9d9b-4412-8acb-957733b3975c@I-love.SAKURA.ne.jp>
In-Reply-To: <af090e53-9d9b-4412-8acb-957733b3975c@I-love.SAKURA.ne.jp>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: ast@kernel.org, john.fastabend@gmail.com, lorenzo@kernel.org,
 toke@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 8 Jan 2026 21:36:48 +0900 you wrote:
> syzbot is reporting
> 
>   unregister_netdevice: waiting for sit0 to become free. Usage count = 2
> 
> problem. A debug printk() patch found that a refcount is obtained at
> xdp_convert_md_to_buff() from bpf_prog_test_run_xdp().
> 
> [...]

Here is the summary with links:
  - bpf: fix reference count leak in bpf_prog_test_run_xdp()
    https://git.kernel.org/bpf/bpf/c/ec69daabe452

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



