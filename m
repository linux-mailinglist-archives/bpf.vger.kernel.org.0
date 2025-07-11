Return-Path: <bpf+bounces-63077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF076B0233E
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EDCA661DE
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1A82F2352;
	Fri, 11 Jul 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGCXV47h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27702F19B1;
	Fri, 11 Jul 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256794; cv=none; b=nXM55IugeienCJRtyK98pkrTzF+Ymf+RunQXdkAu0aTYRx2I4pLYJYnDB8ulug54ChwUsVg+oeZ37t4wOIUtAY9ekUHDWpk5XuGJwMc4X0mZEc4GBhOVoaVuic7Jou/h/2j2FuCWMjCXLiYi46zrQ85Nci/3pg3hDavsnoTj7RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256794; c=relaxed/simple;
	bh=AKpW72VC+1HOMYg6B0t+mzIDn2Tzs/VVIAhuZ2bpIQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CipqR4of7+YQzayz8X0UXbQau+ln1aERtmdOl4PS5LIyhdFdPEbYzXK8Fq8CvNLYg92gXB7ukEKjJ/XXf8THET0NwNAhFHQt/l2SfqhPalLh72FkhRVcnorg7W9SqwS73cWCfxNfACyTogkkJkxtcCUK5v4WivO1/LNhgGzG7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGCXV47h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FBBC4CEED;
	Fri, 11 Jul 2025 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752256793;
	bh=AKpW72VC+1HOMYg6B0t+mzIDn2Tzs/VVIAhuZ2bpIQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LGCXV47hplNjKNNtfxkpYShpJrK1VY2QNanrzvUJ5enWnyEGrJATEcjXlLcyCkM0j
	 MaF8K9RNAZYeIm63IIpfCtGy8U0+OIad6u5fGRPPJ+VFP09z78l/MlHzQZH6th5K8R
	 AMJT2nRDxRXm3VbGymENADxOGF0teuWuNgsmFfzzs2VWs/OAIboGLX3Tls3bDC8NGf
	 JQEEdYLBetuvGmKNkAcVX9CGloop9MMSg6pkYMj+hHPWjOileui90osc/acQkBh6Dj
	 uLExsKfgwdeoDWnHappV7uhpPHt7SK8Jeg/KOR3CmAHh8Ildeda8m+dgmpkOPSOFvW
	 +bWvA9o+5IuXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF4B383B275;
	Fri, 11 Jul 2025 18:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/7] Move attach_type into bpf_link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175225681552.2356840.5924088851532659615.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 18:00:15 +0000
References: <20250710032038.888700-1-chen.dylane@linux.dev>
In-Reply-To: <20250710032038.888700-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: daniel@iogearbox.net, razor@blackwall.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, horms@kernel.org, willemb@google.com,
 jakub@cloudflare.com, pablo@netfilter.org, kadlec@netfilter.org,
 hawk@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 10 Jul 2025 11:20:31 +0800 you wrote:
> Andrii suggested moving the attach_type into bpf_link, the previous discussion
> is as follows:
> https://lore.kernel.org/bpf/CAEf4BzY7TZRjxpCJM-+LYgEqe23YFj5Uv3isb7gat2-HU4OSng@mail.gmail.com
> 
> patch1 add attach_type in bpf_link, and pass it to bpf_link_init, which
> will init the attach_type field.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/7] bpf: Add attach_type in bpf_link
    (no matching commit)
  - [bpf-next,v4,2/7] bpf: Remove attach_type in bpf_cgroup_link
    https://git.kernel.org/bpf/bpf-next/c/9b8d543dc2bb
  - [bpf-next,v4,3/7] bpf: Remove attach_type in sockmap_link
    https://git.kernel.org/bpf/bpf-next/c/33f69f736570
  - [bpf-next,v4,4/7] bpf: Remove location field in tcx_link
    https://git.kernel.org/bpf/bpf-next/c/5d93e091911c
  - [bpf-next,v4,5/7] bpf: Remove attach_type in bpf_netns_link
    https://git.kernel.org/bpf/bpf-next/c/146ecb1e5cf7
  - [bpf-next,v4,6/7] bpf: Remove attach_type in bpf_tracing_link
    https://git.kernel.org/bpf/bpf-next/c/6b3c64b371da
  - [bpf-next,v4,7/7] netkit: Remove location field in netkit_link
    https://git.kernel.org/bpf/bpf-next/c/4254873c58bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



