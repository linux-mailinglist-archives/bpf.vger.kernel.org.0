Return-Path: <bpf+bounces-44386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6409C25E0
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E8C1F218DA
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4151C1F32;
	Fri,  8 Nov 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWVgOvVr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B651C1F2E
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095420; cv=none; b=J3SfsZKoiNFctdexzxuiWOnImpzYknQWYPDN0TBnSZlzHwaepQFfiPdTDp1mc0BPdG9DXU49PoRUnhV4ZxcNxXXSeqCjkC1WZJ7dvRmr8/BQzvKYp0C5aEQzUyDdRxEyWNhyvt6hIQ83A1EWp7pcVCX3dnG8fqJ8Kaie8M3GtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095420; c=relaxed/simple;
	bh=b1sTAv/3lkC/b3dhyPrWAiwMDeqr4nGTBvNOE6aKXU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LzFr5YXcUYislu01PIWC6ED1BGM7tbjHeE8+9cibQ3UtUJsRMksg7zO7OAbWMkkTOev40Solb1wp+TakTvAR3uquG+Md0s9fAuRuLhJSIPuOtkq26sMWk9j1B55C00UNAJtjZHHsFOp/rTt2V8qBCzen2NjZUcFSJtoNQPuVrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWVgOvVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2C4C4CED2;
	Fri,  8 Nov 2024 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731095420;
	bh=b1sTAv/3lkC/b3dhyPrWAiwMDeqr4nGTBvNOE6aKXU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oWVgOvVrZimtaBKJbQ+8iyHrteVUuPLaoezW7o6ewp7CipAbR4Vpv+XUzLIXQmZCF
	 xpfyrUQqEWh8oPQAMJM2QTHw1Dg6axPqLUEQaY1vNAETzl2mGgPtb8uOQ4S0JL3nBL
	 kI2iWlrnk2lyKjnnBLhCGs7No64bRx4TsD8+HCE6BilhHHklD1xHg9HsCSNvbpFnlZ
	 Qs0O961M32gwMceF6nFcipxieaYtaIaq+15pzJ+viv1DMYrrMkhKyDjJ47G3Wiv3RM
	 f+rOIZtT+786V9N2DXpPaZBOAVwoVaNWCTrycY9WPBRlFDA/P6w4QttreUp8L41RL/
	 OJYHbxkwkMqrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0FC3809A81;
	Fri,  8 Nov 2024 19:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Fix lockdep warning for htab of map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173109542975.2744281.12366813939147315544.git-patchwork-notify@kernel.org>
Date: Fri, 08 Nov 2024 19:50:29 +0000
References: <20241106063542.357743-1-houtao@huaweicloud.com>
In-Reply-To: <20241106063542.357743-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com,
 bigeasy@linutronix.de, houtao1@huawei.com, xukuohai@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  6 Nov 2024 14:35:39 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patch set fixes a lockdep warning for htab of map. The
> warning is found when running test_maps. The warning occurs when
> htab_put_fd_value() attempts to acquire map_idr_lock to free the map id
> of the inner map while already holding the bucket lock (raw_spinlock_t).
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: Call free_htab_elem() after htab_unlock_bucket()
    https://git.kernel.org/bpf/bpf-next/c/81eef03cbf70
  - [bpf-next,2/3] selftests/bpf: Move ENOTSUPP from bpf_util.h
    https://git.kernel.org/bpf/bpf-next/c/7d5e83b4d41b
  - [bpf-next,3/3] selftests/bpf: Test the update operations for htab of maps
    https://git.kernel.org/bpf/bpf-next/c/ff605ec69735

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



