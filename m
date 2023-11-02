Return-Path: <bpf+bounces-13911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B4B7DECB1
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 07:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4F3B2108E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119315C99;
	Thu,  2 Nov 2023 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl5oPmlu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDD53AC
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11854C433CB;
	Thu,  2 Nov 2023 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904825;
	bh=GD80CAKbgCq1tYFOrdJMrrxeLcyFbVi5xrx26IXKTFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rl5oPmluTD9TDCKWQKr4WK0Cld0hcuuIppKLFxd0iou40siCv9duj0G3/bQzvBKlo
	 H+OivhO8zBGFNuV7Or7gKkTZM8CU+VuV0GfVFUYq/lTRfKpDeVh47/A5KYchk/rhAA
	 H+rYmZ3top0YPAI7PZFrKvzIQqgpO/CnewYGNMB+ALjl6Eeu+7X5YxbgU15YN+rmtl
	 L+Kxfx+ekx5gEtpceelUQujRPMY+ocxWCogbrGaGTqkd22unB/4aAnZrfOJ1pvdF3t
	 Ni1QKWtjiLHWI2gLe+Fv6WCOm/uZAdXspaTUzNCPgDR5/mRwYh6C1bjP/spCjXGkGH
	 B2deJSQXEv0SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA9E4E00093;
	Thu,  2 Nov 2023 06:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Check map->usercnt after timer->timer is
 assigned
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890482495.9002.6880714745373814049.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 06:00:24 +0000
References: <20231030063616.1653024-1-houtao@huaweicloud.com>
In-Reply-To: <20231030063616.1653024-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com, hsinweih@uci.edu,
 houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 30 Oct 2023 14:36:16 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When there are concurrent uref release and bpf timer init operations,
> the following sequence diagram is possible. It will break the guarantee
> provided by bpf_timer: bpf_timer will still be alive after userspace
> application releases or unpins the map. It also will lead to kmemleak
> for old kernel version which doesn't release bpf_timer when map is
> released.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Check map->usercnt after timer->timer is assigned
    https://git.kernel.org/bpf/bpf/c/fd381ce60a2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



