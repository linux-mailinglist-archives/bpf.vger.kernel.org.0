Return-Path: <bpf+bounces-12457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E62C77CC8FF
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBEBB211DA
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA32D049;
	Tue, 17 Oct 2023 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI+O/Gml"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718A2D044
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DE0DC433C9;
	Tue, 17 Oct 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697560825;
	bh=HPxi9cZpgORT6OGLUQNGNt9kf12ELSL4oX1jG35kqss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mI+O/GmlzPSUdnGjtkD7jfGPZJbv7OJPaqo/3RpzhMosQxpJO0tlMmXTcwsVlyKGC
	 tmJaA7LC/HY1c7PkvgCozUc8VL7WMHBr/9L5nouaYGg8LAwm03yoPjx+XgAvMvpU7D
	 0tQtKmOvKcDKJmU4Azkcwwbz9Dbj8e1uHeogBELSW/Qo/7yKLwGnJpVuWOj0er7v2K
	 5eEZ8Et0x0eJXMWXMuT4uRTonaXdrclvAeQClz/XYY4BtHgYzk4s5YyYH/UMdG8VG2
	 RkKo7ny+KXhj7IE3o3LbCL+708fCP4up7TBq/F/C3PZcFTmQcBTpxGpRDkdBPKIBmp
	 xhaCFIu9s/IyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C3E3C04E27;
	Tue, 17 Oct 2023 16:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix missed rcu read lock in
 bpf_task_under_cgroup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169756082504.3529.3519234649035756359.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 16:40:25 +0000
References: <20231007135945.4306-1-laoar.shao@gmail.com>
In-Reply-To: <20231007135945.4306-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, zhoufeng.zf@bytedance.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat,  7 Oct 2023 13:59:44 +0000 you wrote:
> When employed within a sleepable program not under RCU protection, the use
> of 'bpf_task_under_cgroup()' may trigger a warning in the kernel log,
> particularly when CONFIG_PROVE_RCU is enabled.
> 
> [ 1259.662354] =============================
> [ 1259.662357] WARNING: suspicious RCU usage
> [ 1259.662358] 6.5.0+ #33 Not tainted
> [ 1259.662360] -----------------------------
> [ 1259.662361] include/linux/cgroup.h:423 suspicious rcu_dereference_check() usage!
> [ 1259.662364]
> other info that might help us debug this:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Fix missed rcu read lock in bpf_task_under_cgroup()
    https://git.kernel.org/bpf/bpf-next/c/29a7e00ffadd
  - [bpf-next,v2,2/2] selftests/bpf: Add selftest for bpf_task_under_cgroup() in sleepable prog
    https://git.kernel.org/bpf/bpf-next/c/44cb03f19b38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



