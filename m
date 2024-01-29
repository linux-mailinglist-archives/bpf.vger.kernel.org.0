Return-Path: <bpf+bounces-20607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87E840A8A
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EAC28B16B
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B1155A35;
	Mon, 29 Jan 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZPZOj+n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B2155A23;
	Mon, 29 Jan 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543424; cv=none; b=Q0y+J/xJ0jqV88QaemBfMA/zrDidlhR6VB/7XxFWeKFFaRARPGMLR15A7y/kkrlD8PD/Jy17L8kgdqQayMEjTjoL8/2SFEC5axxLB1SjkrhRV2RlzfjSUptJyceFcJLKfoVKfj82qwAPkUuWNeVQV2txbSZ3bHlM9PbW7inxEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543424; c=relaxed/simple;
	bh=MFMW2gGj8UPTfzSUu/AE4tRnn2jz014AVeZMHtJf6i8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s8Hglbn58EV3nBLwSKo1V3sRO9YV57Bt7Al6l55lwRBcUKdQc/5i4NCgihk1bxk2lZ93k2v8Ogc8rRR8uNKWZCcOiFhNKjeSwikufyDLAG3gJRAzAtXNjlvrvwadl+k9cvN+bzJkzyk0SeXipqN+bAW4uVpqEe5NG4n+4q70ma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZPZOj+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23156C43394;
	Mon, 29 Jan 2024 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706543424;
	bh=MFMW2gGj8UPTfzSUu/AE4tRnn2jz014AVeZMHtJf6i8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PZPZOj+n9k4znzXji8lTRD+6nRabXwN6bB5XWLebfqPNrG1Z3kOPjopWuCJHgcXzU
	 7m+z+WV2wnI6I91y9wYcGzEOx7CL8gTt0JeZtjU91XgxW7TWI5dRDtJbTy+6f21G5z
	 hPGuNjB+2qEWgJzh2G4mIbKlUyLoQvODZO6TpfjJlHxlJo54KI5ejYCvfsc88qIOFs
	 dWQB3tJnQDB3tidZk3bbX3vbtI9HywKiNhcmufYZmd2q2FKccFkhicqwLX2sU9n+Fj
	 qnZb03x6oy22M+7RH3LLqs8baW76lyQJ+T4EQy9fdfZzfL0KpKA8lmmWnBWP1OUvVZ
	 ZPlNM5LtkSISA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07A3CC3274C;
	Mon, 29 Jan 2024 15:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: remove unused field "mod" in struct
 bpf_trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170654342402.16483.547185809042657698.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 15:50:24 +0000
References: <20240128055443.413291-1-dongmenglong.8@bytedance.com>
In-Reply-To: <20240128055443.413291-1-dongmenglong.8@bytedance.com>
To: Menglong Dong <dongmenglong.8@bytedance.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 28 Jan 2024 13:54:43 +0800 you wrote:
> It seems that the field "mod" in struct bpf_trampoline is not used
> anywhere after the commit 31bf1dbccfb0 ("bpf: Fix attaching
> fentry/fexit/fmod_ret/lsm to modules"). So we can just remove it now.
> 
> Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> ---
>  include/linux/bpf.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf-next] bpf: remove unused field "mod" in struct bpf_trampoline
    https://git.kernel.org/bpf/bpf-next/c/efaa47db9245

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



