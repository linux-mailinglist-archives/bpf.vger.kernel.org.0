Return-Path: <bpf+bounces-42025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3D99ED86
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D9D1C23239
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E9136E28;
	Tue, 15 Oct 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE5Ie0SW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F71FC7EF;
	Tue, 15 Oct 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999028; cv=none; b=YTdOgGi5rD/Vmqq0NLeansAwN8QL1ZJPlXh3Wc64tiP7kexeLKLKCzkPkQc9hBfwY865PvhNTBU+/TkZ6h5iJMgWvrTl/qt3fpGWFBvgoHfNyuzgT6Je8Y2RvN6sm8epdyqIcNEY/zKzCFv/RxloxYEqpfLGT/br+w2e2sBR7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999028; c=relaxed/simple;
	bh=RLxwPHH2fBSYue1e3OstnRQCGv1pY2ed1e9CMYRPUSk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JaDYpv2DMC0yEe6dkUzboYmsNWvmTJToLmKOPjIqbPwjvYKZ0nzu2vgGJHZm2Kkpc+Y6BjiC3Oi2gvVmqFdRD1rP4MLPnIOg1csd9NkvrENzAACdStFGInoKWG7O899xocaaI4VSve9/vnhHVL9McD3ksy81W0ZeRpVplSs1OPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE5Ie0SW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15311C4CEC6;
	Tue, 15 Oct 2024 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728999028;
	bh=RLxwPHH2fBSYue1e3OstnRQCGv1pY2ed1e9CMYRPUSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JE5Ie0SWgDmXOPHUuZnS7urYNVMCmtbKTFwnrtMVEGzRPuA4FT/FMInyqImftdUj/
	 Hf8GqNoxc0EP8pyqHTa5Bpv3IFkqb/TxKe+08r1Ym0GEwR7UA0SyrsbV+j7/d8zkuP
	 N1xHiZkMLrmquqy5MjkqN4qGUmBa0gDHRYZ2uLqA70qv9UFNRXqAROsMFHkDMDpIby
	 8cIvR+aERMEniqGwwJaG2M0+Ml1qHXAq3ErfSoJ5cOw6stI/zJ+m+kzCl9u2ygc8nc
	 fl7R/WVF9vu9UfBAtASa0vwLp2WReFb2rY06ONK62BjbG8qVfUos8Csv52wAmpAQnP
	 KcmeHa94VurEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B9C3809A8A;
	Tue, 15 Oct 2024 13:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-10-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172899903326.1161856.7083596631931585539.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 13:30:33 +0000
References: <20241014211110.16562-1-daniel@iogearbox.net>
In-Reply-To: <20241014211110.16562-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 14 Oct 2024 23:11:10 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 21 non-merge commits during the last 18 day(s) which contain
> a total of 21 files changed, 1185 insertions(+), 127 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-10-14
    https://git.kernel.org/netdev/net-next/c/39ab20647d7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



