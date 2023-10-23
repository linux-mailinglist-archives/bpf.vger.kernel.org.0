Return-Path: <bpf+bounces-13030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4E57D3D17
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 19:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9DD2813C2
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94561DA22;
	Mon, 23 Oct 2023 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC1ffybK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2A1B28C
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA529C433CB;
	Mon, 23 Oct 2023 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698081022;
	bh=WX6E0CLhoHMr8RlYe+YKKrkZuiycpsupzhu/hfLBcpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vC1ffybK8aYman2a99R/WzAJmyzmMLIl8AaSN4m1IYyxCGMC5nCfNFLsYQbs3bBo6
	 RegHoth0Auc0rHN79ry8WjFK9aIxg+LuM/LL1QcZBQuVp0Nhm+BXZmLno120lZppSN
	 ajyrVo2wcFohkeYddwB861SdQ109zZPn0fK5YLtACiATVIrVtKuCBFA5cRxcjVTxVZ
	 Whhe80+44jTPpc3WMny1V8ieqbQ+eFGrnvBHInW1xlEB1QojV+qP6L0jDzD1dFtJ3W
	 Wq9GTBesZKiHn7OBtGG0BC5ScrEqBX+7jQalRXXHRhw1cnUAs/PJZ1zpAWBeJda4xI
	 1o3P0YV3R/Pdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A00C3E4CC1C;
	Mon, 23 Oct 2023 17:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples: bpf: fix syscall_tp openat argument
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169808102264.23259.3811927107836817360.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 17:10:22 +0000
References: <20231019113521.4103825-1-dzagorui@cisco.com>
In-Reply-To: <20231019113521.4103825-1-dzagorui@cisco.com>
To: Denys Zagorui <dzagorui@cisco.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 19 Oct 2023 04:35:21 -0700 you wrote:
> This modification doesn't change behaviour of the syscall_tp
> But such code is often used as a reference so it should be
> correct anyway
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  samples/bpf/syscall_tp_kern.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Here is the summary with links:
  - samples: bpf: fix syscall_tp openat argument
    https://git.kernel.org/bpf/bpf-next/c/69a19170303f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



