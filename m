Return-Path: <bpf+bounces-57794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28255AB030C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140F9506F05
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F8A287512;
	Thu,  8 May 2025 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pASPS2Ae"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7779286D50;
	Thu,  8 May 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729602; cv=none; b=ZSlLy6iJBGm2kDujQQBocZdrSTnM8vx9W4PQp5tfA8gV6+ULNndJ3w0lbbcnYCIsmfEyiifwemI93G0mXsY/HfVRHG0FJpg/cVo2TTDy/ltekefRzbYjNaSkqetrX8bfj6SLJsvd7Y6GCQYJKpMHgSoIjiyMKFnxQmtgSCjOyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729602; c=relaxed/simple;
	bh=BP5gg62J52gJfbuerk6jATuo7cDeaEweaijouBM+HwM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gpbRM2Bl2P8b13rERaPCuL1v9ORYd5EcfqmwOXZy55cucgVNneGuB2p6sDhJjUbsK+n0fg+YBu9UXmkuwUg+t7ZMLo9pjU4VOSHGEUIlYnQk1yfWp10EgmSQpkF5S7ZPh5FkXI6P/FIKggOD1ciIrJqzcA9PTeqDeKLrt8uTqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pASPS2Ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183E6C4CEE7;
	Thu,  8 May 2025 18:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746729602;
	bh=BP5gg62J52gJfbuerk6jATuo7cDeaEweaijouBM+HwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pASPS2Aefpzco7YR8QcBAELUeDROGSr0GqviYpZeB36YJkwfv8FxBnN0SvikghUh8
	 plAEJ+vXHRVhWsvPj6EvRsn56g+UxnrqdYdcqjrmEYlk84vOrt8ZfG+yh5Xpnsdkl8
	 M5hzcvcx4i2bhrSRGCVDsSlhoZOHM7lGCXkZb6FgbNPCTNw6YiGW2Qkz3YYgYkYWda
	 SAAQeQ4iH9/NpUfxDUcenzG3fezdX8LJZtwD9GbhEiQb1yrtBHr1Sqq1gI2DTAxStX
	 rmCNPo94PODuKVH1YsSQWJC1eF/FF9ZcK8cSEgTCX22ftLWC/lkPIrA6rY35RTK/mq
	 HnHa3NdLgcedg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB54F380AA70;
	Thu,  8 May 2025 18:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Fix cgroup command to only show cgroup bpf
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174672964049.3007694.10087671758774364033.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 18:40:40 +0000
References: <20250507203232.1420762-1-martin.lau@linux.dev>
In-Reply-To: <20250507203232.1420762-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, kernel-team@meta.com,
 qmo@kernel.org, ctakshak@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  7 May 2025 13:32:32 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The netkit program is not a cgroup bpf program and should not be shown
> in the output of the "bpftool cgroup show" command.
> 
> However, if the netkit device happens to have ifindex 3,
> the "bpftool cgroup show" command will output the netkit
> bpf program as well:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Fix cgroup command to only show cgroup bpf programs
    https://git.kernel.org/bpf/bpf-next/c/b69d4413aa19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



