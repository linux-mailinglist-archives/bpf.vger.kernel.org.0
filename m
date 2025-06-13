Return-Path: <bpf+bounces-60630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA1AAD94FF
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 21:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730743B2A21
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2671523958A;
	Fri, 13 Jun 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIeS2lir"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE631A76AE
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841801; cv=none; b=lGUmNa2hPGoolzWi2KKLbXDeYUG8xS+Szz3hDYuyc7rke/Qh+SuGfnH58Izg/5V/5W/CL5qY+RmbxXVGoQFK/CHNFL8pgWoExqTG1zQOKYHooT0DShogn8q3xNRFGq5vrrnQFRRSZmcT8K/hcMVNTAb2gv+WCYfnfpnsACcFdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841801; c=relaxed/simple;
	bh=xYJHst5Hfzee61Xx0ozv/FSpj14cso8bBqf0alluMJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kz6O81eoSVEhP2cHm8hcctq11gNXD8O0Wj9H0XXXtUvJ4nK6vaMkB5eEjapu7cemKnqfHmivqT8jLMeKWfbvyl8c2RBDiF+91ueRFU6dr9Zg+nm1BbN5vOltfn8nONwzLYujchiH0AXOetw4Xat8zV3oyP5clnxbBLDfoJAOans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIeS2lir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2981DC4CEE3;
	Fri, 13 Jun 2025 19:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749841801;
	bh=xYJHst5Hfzee61Xx0ozv/FSpj14cso8bBqf0alluMJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZIeS2lirNHz+pRWwEzzY/R4kB+uaOKXnhV+LF52fujjioBcoAaS6A5CVGfvVyWxGN
	 Z2WZo6pOjWOtsbepHCM08vamWC+5TRPgY5tksdA4OssHI4/RFILBG+JZ/geNPxwcX7
	 ucANmeZSdb2Y7lzuc3JX5u6L1jO6rQca3nuEuSXEWC7otm+FP8kJB5lbll4sBlNtk8
	 1f2vVtyT/GBiHGTCU0+i0SA9y1Q7UkeWlSNy+lcf5NApq6jbCu5F3BDu0UsU7ehr6i
	 Tv+PutQGrws5H504b5HtbokEDWV4vSxyLOnTysZLhnyyazcgvwgVngi6a4vsr79caA
	 r861nO5beZ4hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFE5380AAD0;
	Fri, 13 Jun 2025 19:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/2] bpf: handle jset (if a & b ...) as a jump
 in
 CFG computation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174984183075.856264.12436732973812728838.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 19:10:30 +0000
References: <20250613175331.3238739-1-eddyz87@gmail.com>
In-Reply-To: <20250613175331.3238739-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,
 syzbot+a36aac327960ff474804@syzkaller.appspotmail.com,
 alexei.starovoitov@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Jun 2025 10:53:30 -0700 you wrote:
> BPF_JSET is a conditional jump and currently verifier.c:can_jump()
> does not know about that. This can lead to incorrect live registers
> and SCC computation.
> 
> E.g. in the following example:
> 
>    1: r0 = 1;
>    2: r2 = 2;
>    3: if r1 & 0x7 goto +1;
>    4: exit;
>    5: r0 = r2;
>    6: exit;
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: handle jset (if a & b ...) as a jump in CFG computation
    https://git.kernel.org/bpf/bpf-next/c/3157f7e29996
  - [bpf-next,v1,2/2] selftests/bpf: verify jset handling in CFG computation
    https://git.kernel.org/bpf/bpf-next/c/4a4b84ba9e45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



