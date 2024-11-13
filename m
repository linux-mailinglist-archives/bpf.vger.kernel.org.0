Return-Path: <bpf+bounces-44806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420889C7CC1
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 21:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245C2B25B26
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417F204F66;
	Wed, 13 Nov 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjH3iMpZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAA1632D0;
	Wed, 13 Nov 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529220; cv=none; b=gWQxqCzaQMicjycvrkTrQFdmbe55jahval2xmZBi0lwhrOiu2Oh1kZYuKc3j3flDIYVuSbKUuD6UvGR485cJmxUmZ0JnWX27qMsvLT9EZGQNhfCGDdciQSGzLRUeYctfa2vpmuiyfYXx5joi6AjTNIdth3JgQ8sOm5nsVyIrh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529220; c=relaxed/simple;
	bh=QurR8l08tSHwfxD5LJ7CxJnPPrZhPaLnp/XY7YSX17g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LKwrUwrP3/VCfn5fQYsznPCyIC67pUetjh0dW6HuM5gTqrqh/dO55+Aalhl8+Ry7Zi5bR53jf+tRjnBFantDErFxp+j71rogV3EfsZ9F/i5z37XifU+JISOePI8w10oq0S+lmwFe/Lh9pb0D8OqEkngKaodXHE5rhtzkYqo+txE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjH3iMpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E71CC4CEC3;
	Wed, 13 Nov 2024 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731529220;
	bh=QurR8l08tSHwfxD5LJ7CxJnPPrZhPaLnp/XY7YSX17g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cjH3iMpZ8Q3VMe/PBPuzmsoKsgNvDy7WwBfEzQ6HG+Lv2AqHzyiFksV3D1NVrJENH
	 4Z4zktiPBQCNh76Penb/UOsZiK3JqJ0oLCkxrnZ15l+Nsb4qvaGU10rneMqYhnlrxQ
	 mMsD9+zIgBbSzkLF47ODw2uRqB6QBlz8AxGoUyhf1YWtsbqCMe9MfAU4CfzoawfUmo
	 HVkat6yqsdXYzi8fwxklv9tupdOfzUFJeqW7kz1zQKd8aUOffVSxnUfzIr2HCb91Pn
	 eBlaFjS3Mp59Zj8li0TBvGlFv95d45eFbD03pWwl4m3ILzcxYwkC0fQrh0pel2rjrT
	 wNf2mCill3J3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF9E3809A80;
	Wed, 13 Nov 2024 20:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: Cast variable `var` to long long
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173152923076.1373293.10104139027043308071.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 20:20:30 +0000
References: <20241112073701.283362-1-luoyifan@cmss.chinamobile.com>
In-Reply-To: <20241112073701.283362-1-luoyifan@cmss.chinamobile.com>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: andrii.nakryiko@gmail.com, qmo@kernel.org, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 12 Nov 2024 15:37:01 +0800 you wrote:
> When the SIGNED condition is met, the variable `var` should be cast to
> `long long` instead of `unsigned long long`.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>  tools/bpf/bpftool/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bpftool: Cast variable `var` to long long
    https://git.kernel.org/bpf/bpf-next/c/b7b31f184f88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



