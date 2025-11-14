Return-Path: <bpf+bounces-74575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A658C5F67C
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386973AF6D6
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0937B361DA9;
	Fri, 14 Nov 2025 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyoONlrj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10D35CB89;
	Fri, 14 Nov 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156438; cv=none; b=HubZV7Ji9bhIksPN6RLQ/6fdv+fC5ZoB5mrMp4NMWUbwMcMf+UOQW/gQCXQNDazm9bL56QVIuf2moFyKNJYitoAEl9lp+PffWG6NeKstVAeNzqwN3ruGZE1GeTAeJMyHkEOuH97pYbO/u0Kn1PSD/dk2f1BA7ARL39wjJfcphi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156438; c=relaxed/simple;
	bh=aM43ucwGfj3HuBnSF7DFSLb/MFMSqDlYsor1bEAzcL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AvVt40hHjEz6srYHm1aazWWqzW3HqyDjmkXmtrigrD0SnkELVIN3G/Q5fU1mCdZ99UEbiWbjf8x+gIbJNa68ZRuCqnxW0EB9tcpJZ/K0iriSr3c+xtj4EhFVVTkXAIiHxlPeidHn7jUzuYeskx+7HDyAn2lQzcgb67ZiDZxAcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyoONlrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02665C4CEF5;
	Fri, 14 Nov 2025 21:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763156438;
	bh=aM43ucwGfj3HuBnSF7DFSLb/MFMSqDlYsor1bEAzcL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SyoONlrjkYvnUb6dpBQTe8NuWagQSiWlwx+HrPgFwBghS7XTQgJVNoNj/z+q41Evz
	 1jtrABsAezUELUybC0BShj8mefLrhf0LOxO6PUPoiAmuvDOmmwSFBd65lHSFO8m7sR
	 HD89keKEJahEXj8/joYmJbi/dXu6sOKtn7prh8VJly/htm42JX+D509DYuJpaCPJmg
	 K1ogq9HSAz5QcSMQuWbyfHNaFUzGrX1mAhW+0e1j4siTEd7eUWLsjrDF835yAN+khe
	 uJr+MsgzhRM0JYrsYbBvaT2gcPnhHciaS180lL5dBoOM4tTVZmJYvSPuAgOhlwR6am
	 FhVX9D/vHwC/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0A3A78A5E;
	Fri, 14 Nov 2025 21:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: handle the return of ftrace_set_filter_ip in
 register_fentry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176315640652.1844227.992402942103790626.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 21:40:06 +0000
References: <20251110120705.1553694-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251110120705.1553694-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, song@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 10 Nov 2025 20:07:05 +0800 you wrote:
> The error that returned by ftrace_set_filter_ip() in register_fentry() is
> not handled properly. Just fix it.
> 
> Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/bpf/trampoline.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf] bpf: handle the return of ftrace_set_filter_ip in register_fentry
    https://git.kernel.org/bpf/bpf-next/c/fea3f5e83c5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



