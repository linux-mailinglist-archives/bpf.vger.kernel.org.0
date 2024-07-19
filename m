Return-Path: <bpf+bounces-35103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5FA937BBD
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191011C20805
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674C91474BF;
	Fri, 19 Jul 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFepid2/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C2146D57;
	Fri, 19 Jul 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410833; cv=none; b=TFIU2id3gqiMYwFxLqh34O4zaPabbgHoS3AcDDALFL9ii+ozwJZVlZJdBeZd7YbuPQWntrPiOdBvPNpDButqt4VmRai7Pw6MkorBzVtYa9DOgl+eLIr8Kse1zY1HONGK3HgNRXCyqiBgu97GvDnx/KBqclqmS3va31VHx7BnWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410833; c=relaxed/simple;
	bh=gnrXPddmYCu+DtOUkPpf909uGlCSkEw8oUX4mutzTqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WcmgBz26SLZmycSox3wDen6TDWRDY++H/kXPMw299kZDUcyoSL24BelJlz23siWeim6u7Hgppd4o5+UYDA7DUoRe8J7blbyGVgsh1hmo1SQKhXI0OdlWjJJqYiDaAd10bI8XPEVUOjWhbG2krDPMcJMBrWcinV5qX4L6LxDsgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFepid2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 571A8C4AF0B;
	Fri, 19 Jul 2024 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721410832;
	bh=gnrXPddmYCu+DtOUkPpf909uGlCSkEw8oUX4mutzTqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dFepid2/oj255lP68Z0/Df//3B0jZfdUp5r3bzSwej506X2P/jjRWN3//gEYAmSJ6
	 KhvATo2aiAZb19E1Rb+MS34WITNBsYb6NuT+eCAkm1xqumsnVfAdMXELRissSIls/5
	 n5WTb6V46TcUIQlw927HCKkq+GoJslWuVw80Pk0P/obSJqPJmNXc+sPQmVqmwGQuGB
	 YZ2pE8hEzXVQwXVk4A8XDdKS5jCckVmCyJcVY6po+nlMZBsh32WLYzlbGxKjwE1EUt
	 O50TyuBqo/LvRTGIK+yrdZcLfRSAQnJENUduXND3VkQieZgkWrpbvhf7CZeLXm8JC3
	 zNArckr/uu9Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45810C43335;
	Fri, 19 Jul 2024 17:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Replace 8 seq_puts() calls by seq_putc() calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172141083227.15079.12391054093974999369.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jul 2024 17:40:32 +0000
References: <e26b7df9-cd63-491f-85e8-8cabe60a85e5@web.de>
In-Reply-To: <e26b7df9-cd63-491f-85e8-8cabe60a85e5@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: bpf@vger.kernel.org, kernel-janitors@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, martin.lau@linux.dev, song@kernel.org, sdf@fomichev.me,
 yonghong.song@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 14 Jul 2024 16:30:38 +0200 you wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 14 Jul 2024 16:15:34 +0200
> 
> Single line breaks should occasionally be put into a sequence.
> Thus use the corresponding function “seq_putc”.
> 
> This issue was transformed by using the Coccinelle software.
> 
> [...]

Here is the summary with links:
  - bpf: Replace 8 seq_puts() calls by seq_putc() calls
    https://git.kernel.org/bpf/bpf-next/c/173c57bc61b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



