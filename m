Return-Path: <bpf+bounces-30504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB88CE862
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55EF9B22A69
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73B12E1E9;
	Fri, 24 May 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH7AMcz2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542D1E52C;
	Fri, 24 May 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566430; cv=none; b=XWcRjAER98pqvUoFh7Y1jF7dGkZIg2e69chAtVr+1OToUgGEVozwPNQTnaZS4Tog2MhVYUEwZiysvRQ6CqFfmfSfUbsKIG3PM4N3yRz9WFey8J9yGEGreRhaymNltVgL52hsw+LpUMBuVgdI6UeSpVPLFFhIZeKi4pkMdfeOj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566430; c=relaxed/simple;
	bh=XsGFpt79JlV/4qc58Z4cW+QADzC3zecgEyG8wek/1Fk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PWZaKJEIV2PQREwLlNazqSM2mWMz0eGcDVkyAKJuS3l8arQj4CzvFoH2xosAAF4MaNM9lmy0avyqFUdQQwQSiSv/BAbfycFwvrvVyH1LIRyyD8Ud6F/MQkSlVE7nFGRSwvxnyrebPzSE2MVlEd2AU+NR9m2I5TKOAHyNZKf8kfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH7AMcz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06A89C32782;
	Fri, 24 May 2024 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716566430;
	bh=XsGFpt79JlV/4qc58Z4cW+QADzC3zecgEyG8wek/1Fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rH7AMcz27ibPaJ5aNzbugBIXcJbkjUTZBnvAS+iRYM/Gysfkd1BnPmsMYfp9sQpMh
	 QPNBNLaNXMgEJo5r/TtmWccbPKdpwDbQvf3HHarcsj0tvq4SQ6jDcinZ+OfnnYK4Br
	 EFt1uTDqaytu2h/vtX3+qLqdWhM1Gv/HdKIm4580fK1r9Wo5CC8IHaHYg/KZ/ELlMC
	 KrklBDEnE9NYAXxZZoUc9aJDxw6rkflk+0QDyP0oSxJW0ROT7L5/60KTGjSfshZjon
	 l7f+q88L5ZSe1blk163GZBeHBBECMLofIqRcgw/zRFqUdH/9ITgHKfHnOo0ZdqWY7/
	 6mgqgMBxrqmsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5A0DC54BB3;
	Fri, 24 May 2024 16:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: constify member bpf_sysctl_kern::table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171656642993.1905.17222357299734558059.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 16:00:29 +0000
References: <20240518-sysctl-const-handler-bpf-v1-1-f0d7186743c1@weissschuh.net>
In-Reply-To: <20240518-sysctl-const-handler-bpf-v1-1-f0d7186743c1@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, j.granados@samsung.com, mcgrof@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 18 May 2024 16:58:47 +0200 you wrote:
> The sysctl core is preparing to only expose instances of
> struct ctl_table as "const".
> This will also affect the ctl_table argument of sysctl handlers,
> for which bpf_sysctl_kern::table is also used.
> 
> As the function prototype of all sysctl handlers throughout the tree
> needs to stay consistent that change will be done in one commit.
> 
> [...]

Here is the summary with links:
  - bpf: constify member bpf_sysctl_kern::table
    https://git.kernel.org/bpf/bpf-next/c/2c1713a8f1c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



