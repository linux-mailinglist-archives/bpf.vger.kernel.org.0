Return-Path: <bpf+bounces-19078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0979A824B93
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2F1284A92
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 23:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F62D03D;
	Thu,  4 Jan 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyPiQmqd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569502D029
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 23:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC942C433C9;
	Thu,  4 Jan 2024 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704409227;
	bh=HPMIpogk9rZhXYUPFZ4LCjdR73Wm93DjeoU+nyzvaGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TyPiQmqdN1Z6DRssJnFubW33kAe2h50scG5SDoUJf894/J3/F0ZI18OERH0C3SSCT
	 fVaoYB1Sip9B5crcqnu29Y1frvR6z77NxDrZmm827TT0ZnekmGaHjiNVcNltR5D+Dn
	 A4jK+k1aUiWc9eZSYN2JL1CliiZxyiFUbAEuyIEm6r75JSd8RFv2Bz9FUGIAcOJajc
	 z9InEqqnq0NQKr1E1w8v7AjFcHCb6adge9pvtypW7efqOB2JgJq6Dvrh6S3PqYryby
	 5K4L4kO9zwNPv8ztGzXfVZlBLIpuDNOasRDcZgO0yrzQBxA6KjtjI6OxqQTxCuegNQ
	 V+amUfqCgEHoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E32DC43168;
	Thu,  4 Jan 2024 23:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] s390/bpf: Fix gotol with large offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170440922757.28567.17128781732810815720.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 23:00:27 +0000
References: <20240102193531.3169422-1-iii@linux.ibm.com>
In-Reply-To: <20240102193531.3169422-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  2 Jan 2024 20:30:34 +0100 you wrote:
> Hi,
> 
> While looking at a pyperf180 failure on s390x (must be related to [1],
> I'm not done with the investigation yet) I noticed that I have
> unfortunately messed up the gotol implementation. Patch 1 is the fix,
> patch 2 is a small test infrastructure tweak, and patch 3 adds a
> test.
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] s390/bpf: Fix gotol with large offsets
    https://git.kernel.org/bpf/bpf-next/c/ecba66cb36e3
  - [bpf,2/3] selftests/bpf: Double the size of test_loader log
    https://git.kernel.org/bpf/bpf-next/c/445aea5afda4
  - [bpf,3/3] selftests/bpf: Test gotol with large offsets
    https://git.kernel.org/bpf/bpf-next/c/63fac34669e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



