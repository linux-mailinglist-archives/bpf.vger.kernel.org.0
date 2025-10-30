Return-Path: <bpf+bounces-72958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BB2C1E026
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 02:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD80B3B9EEF
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D6263C8C;
	Thu, 30 Oct 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUrl+vNM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8823A9B0
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787233; cv=none; b=HSDe63W/OGq+YbMrffN1aGhDvGU2ur3te3Wjn/9EhLfquS7hro8aaX1+Kx+Iq+zTNsqnD9BSbIaNLpf6GXUMoKX1IUS9AeBLylWOG7+U+kVgmbyjm18ZZT1ukXL8mXA4R1gsXIwuLqMLfOH3OIiG3amitCOVUBcFMP43xpjfccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787233; c=relaxed/simple;
	bh=qha4jyirR3iyodn8zLGwM6KgCstlPk0UbE/wvwEv20Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gm9gGEbQNx02+QaSTEjLzD19wwwGuX+hMFj0Bb89MSYT9MT0ERv6FdNR5+yhB0QCTowFg/x1T4z6CUCzIcoSiaj4bEou+eunw5kmjj9bFyCo05HG5j8rI3B2kCVDxPMKsB4SLkXXqxqweSMSbbfmxZXgZq1PsMYUqPT/JiHZb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUrl+vNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBDAC4CEF7;
	Thu, 30 Oct 2025 01:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761787232;
	bh=qha4jyirR3iyodn8zLGwM6KgCstlPk0UbE/wvwEv20Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aUrl+vNMhr17kdrfAHDYEd6olVCzhx4Z2dq+v1b/JdVnl2U3lwQCPFOM50fJEGGG7
	 w/mqY6IgMxLRP+prMNukCMHwSUcoHIe9UR7vHE8CKwDFgChFZWWcWUtNdXlqjVhl7T
	 Sj36DC3ttzuBcvF/Oe7syYiSA1uGkehnro9pclgjQl+sMK0Qp8DueRe63WeTI5XRqd
	 ixGutflZNVx0BQMT/ZsiZG/uZmXiGpgPxLGr1TInc7spc7Os6KFxRjXm7ebQUAxFgH
	 0kPnETePl260271Agvek/ZI8FyI4YZHU4/RmGdX4kxBUp39o+/EEtuGJ8L9fAhKV+t
	 18PUoxE6+jyMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1D5E53A55EC7;
	Thu, 30 Oct 2025 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Misc rqspinlock updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178721000.3274494.12983591492643896889.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 01:20:10 +0000
References: <20251029181828.231529-1-memxor@gmail.com>
In-Reply-To: <20251029181828.231529-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 29 Oct 2025 18:18:26 +0000 you wrote:
> A couple of changes for rqspinlock, the first disables propagation of AA
> and ABBA deadlocks to waiters succeeding the deadlocking waiter. A more
> verbose rationale is available in the commit log. The second commit
> expands the stress test to introduce a ABBCCA mode that will reliably
> exercise the timeout fallback.
> 
> Kumar Kartikeya Dwivedi (2):
>   rqspinlock: Disable queue destruction for deadlocks
>   selftests/bpf: Add ABBCCA case for rqspinlock stress test
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] rqspinlock: Disable queue destruction for deadlocks
    https://git.kernel.org/bpf/bpf-next/c/7bd6e5ce5be6
  - [bpf-next,v1,2/2] selftests/bpf: Add ABBCCA case for rqspinlock stress test
    https://git.kernel.org/bpf/bpf-next/c/a8a0abf09754

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



