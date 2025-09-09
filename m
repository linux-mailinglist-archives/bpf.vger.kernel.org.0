Return-Path: <bpf+bounces-67949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC6B508F1
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 00:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44453A3758
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5626E708;
	Tue,  9 Sep 2025 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhKtnfYh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEA253F07
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757457603; cv=none; b=kF08cPFl8pdM8We3RLAHqCwQvAU1QXvHOEyUKBprkdxMeoN+/+0kjkA/CJR4eePlq8NjRI/Bu8Qx9GrjLPXayKnkDAGn4NsGbkAI4cCID/oDEDpwZZEvKEPC7S8UPT/TMG5ZQSfAo20uZ0ZII5E50t+wFuu26rzsB4fhEQ4GmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757457603; c=relaxed/simple;
	bh=hRjhnxUm0trj1HOY3MfMFjeHMWSzbkL2aSDIg0le0lQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FqvGXt1dIyLwk5IUGD06s7MD+9IyFnKyVF/9Y26rBZK4dZyNrVkfXgutr5OW8OD/YwcbtJyNI2w1ovR2T8IiBrDMFOTbSsziA+O9pWyGEQ1HAstcA6GZnas5m2MVMY2V8VuB09G1qbzWgjookxhGqAJJZrSw4+pTr+d4dSxoBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhKtnfYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1897CC4CEF4;
	Tue,  9 Sep 2025 22:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757457603;
	bh=hRjhnxUm0trj1HOY3MfMFjeHMWSzbkL2aSDIg0le0lQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GhKtnfYhpKBtZR0b1nh3HbaUzJ9RJbpRBUjJM9RincgI48FyVqvSl7QA6e0IKqtMB
	 IXbAeiSX9pWRfQ7vu5GsbHUxcw9C2Kq4wSgJKLnGrNpRRlzBp5Tecyezh+wDoE7Woq
	 Pj/akrdRZbE3BrGIdsDLgk71l+0KGov4SJm70NZnKGQKARcC02p/al6bvlY2syJExX
	 GnTd/AyrHOG3V7eOM50B5Tk4deQNhFe+biWHJrDBAdrpQppR0LN+0lRc0IYPDw0gev
	 yjwPLrNsOVpG5vZow3JtYUaaOsIuLJlHkK6Ei26MIAnE76efBsmAmPmspJS4+lGdIs
	 syLvfWi9Jvoqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FAC383BF69;
	Tue,  9 Sep 2025 22:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf/helpers: Use __GFP_HIGH instead of GFP_ATOMIC
 in
 __bpf_async_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175745760626.837268.10273222616654949199.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 22:40:06 +0000
References: <20250909095222.2121438-1-yepeilin@google.com>
In-Reply-To: <20250909095222.2121438-1-yepeilin@google.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, tj@kernel.org, roman.gushchin@linux.dev,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, joshdon@google.com,
 brho@google.com, linux-mm@kvack.org, leon.hwang@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Sep 2025 09:52:20 +0000 you wrote:
> Currently, calling bpf_map_kmalloc_node() from __bpf_async_init() can
> cause various locking issues; see the following stack trace (edited for
> style) as one example:
> 
> ...
>  [10.011566]  do_raw_spin_lock.cold
>  [10.011570]  try_to_wake_up             (5) double-acquiring the same
>  [10.011575]  kick_pool                      rq_lock, causing a hardlockup
>  [10.011579]  __queue_work
>  [10.011582]  queue_work_on
>  [10.011585]  kernfs_notify
>  [10.011589]  cgroup_file_notify
>  [10.011593]  try_charge_memcg           (4) memcg accounting raises an
>  [10.011597]  obj_cgroup_charge_pages        MEMCG_MAX event
>  [10.011599]  obj_cgroup_charge_account
>  [10.011600]  __memcg_slab_post_alloc_hook
>  [10.011603]  __kmalloc_node_noprof
> ...
>  [10.011611]  bpf_map_kmalloc_node
>  [10.011612]  __bpf_async_init
>  [10.011615]  bpf_timer_init             (3) BPF calls bpf_timer_init()
>  [10.011617]  bpf_prog_xxxxxxxxxxxxxxxx_fcg_runnable
>  [10.011619]  bpf__sched_ext_ops_runnable
>  [10.011620]  enqueue_task_scx           (2) BPF runs with rq_lock held
>  [10.011622]  enqueue_task
>  [10.011626]  ttwu_do_activate
>  [10.011629]  sched_ttwu_pending         (1) grabs rq_lock
> ...
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf/helpers: Use __GFP_HIGH instead of GFP_ATOMIC in __bpf_async_init()
    https://git.kernel.org/bpf/bpf/c/6d78b4473cdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



