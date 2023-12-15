Return-Path: <bpf+bounces-17924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF8813F1B
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDD01F22CE6
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10382650;
	Fri, 15 Dec 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGkDmbZg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E236F
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 01:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 146C8C433C8;
	Fri, 15 Dec 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702603224;
	bh=IR7rJ5syJepctSquiJfAfXTLyeEhyoANRGxLZuKj5wM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fGkDmbZgI3yrWuSwR8d63t1FT1m+syKdnWug/7dhiDsNyodcBAYNgksdZ4tqlFVIM
	 yb5bnCGuFMz4855gELlR4rKgTpHfkhOpLvSkRmqM2KWohXVYoUP0IciqbmQB04qLQi
	 y6emgPKHtd0Uc5g6GWLNd/mOVqh/RRYyWrfBWleKoMANcx8HGu4s0CbTdBUu1kfuea
	 uvJMnk6eaFPDh/fyvPghq5+U2SPvmLW1x0azhTJfuOs48fr9KjzScJcdvdQGfytDBV
	 iTg2eQuogpcNnanQ8/ljDKstrO6PEsN9GW9GYVlfZVtHgeFL34oAJJld+jiICottwv
	 Ltbty96iMiAeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1E74DD4EF9;
	Fri, 15 Dec 2023 01:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Fix a race condition between btf_put()
 and map_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260322398.10731.15714047011878677066.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 01:20:23 +0000
References: <20231214203815.1469107-1-yonghong.song@linux.dev>
In-Reply-To: <20231214203815.1469107-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 houtao@huaweicloud.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Dec 2023 12:38:15 -0800 you wrote:
> When running `./test_progs -j` in my local vm with latest kernel,
> I once hit a kasan error like below:
> 
>   [ 1887.184724] BUG: KASAN: slab-use-after-free in bpf_rb_root_free+0x1f8/0x2b0
>   [ 1887.185599] Read of size 4 at addr ffff888106806910 by task kworker/u12:2/2830
>   [ 1887.186498]
>   [ 1887.186712] CPU: 3 PID: 2830 Comm: kworker/u12:2 Tainted: G           OEL     6.7.0-rc3-00699-g90679706d486-dirty #494
>   [ 1887.188034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>   [ 1887.189618] Workqueue: events_unbound bpf_map_free_deferred
>   [ 1887.190341] Call Trace:
>   [ 1887.190666]  <TASK>
>   [ 1887.190949]  dump_stack_lvl+0xac/0xe0
>   [ 1887.191423]  ? nf_tcp_handle_invalid+0x1b0/0x1b0
>   [ 1887.192019]  ? panic+0x3c0/0x3c0
>   [ 1887.192449]  print_report+0x14f/0x720
>   [ 1887.192930]  ? preempt_count_sub+0x1c/0xd0
>   [ 1887.193459]  ? __virt_addr_valid+0xac/0x120
>   [ 1887.194004]  ? bpf_rb_root_free+0x1f8/0x2b0
>   [ 1887.194572]  kasan_report+0xc3/0x100
>   [ 1887.195085]  ? bpf_rb_root_free+0x1f8/0x2b0
>   [ 1887.195668]  bpf_rb_root_free+0x1f8/0x2b0
>   [ 1887.196183]  ? __bpf_obj_drop_impl+0xb0/0xb0
>   [ 1887.196736]  ? preempt_count_sub+0x1c/0xd0
>   [ 1887.197270]  ? preempt_count_sub+0x1c/0xd0
>   [ 1887.197802]  ? _raw_spin_unlock+0x1f/0x40
>   [ 1887.198319]  bpf_obj_free_fields+0x1d4/0x260
>   [ 1887.198883]  array_map_free+0x1a3/0x260
>   [ 1887.199380]  bpf_map_free_deferred+0x7b/0xe0
>   [ 1887.199943]  process_scheduled_works+0x3a2/0x6c0
>   [ 1887.200549]  worker_thread+0x633/0x890
>   [ 1887.201047]  ? __kthread_parkme+0xd7/0xf0
>   [ 1887.201574]  ? kthread+0x102/0x1d0
>   [ 1887.202020]  kthread+0x1ab/0x1d0
>   [ 1887.202447]  ? pr_cont_work+0x270/0x270
>   [ 1887.202954]  ? kthread_blkcg+0x50/0x50
>   [ 1887.203444]  ret_from_fork+0x34/0x50
>   [ 1887.203914]  ? kthread_blkcg+0x50/0x50
>   [ 1887.204397]  ret_from_fork_asm+0x11/0x20
>   [ 1887.204913]  </TASK>
>   [ 1887.204913]  </TASK>
>   [ 1887.205209]
>   [ 1887.205416] Allocated by task 2197:
>   [ 1887.205881]  kasan_set_track+0x3f/0x60
>   [ 1887.206366]  __kasan_kmalloc+0x6e/0x80
>   [ 1887.206856]  __kmalloc+0xac/0x1a0
>   [ 1887.207293]  btf_parse_fields+0xa15/0x1480
>   [ 1887.207836]  btf_parse_struct_metas+0x566/0x670
>   [ 1887.208387]  btf_new_fd+0x294/0x4d0
>   [ 1887.208851]  __sys_bpf+0x4ba/0x600
>   [ 1887.209292]  __x64_sys_bpf+0x41/0x50
>   [ 1887.209762]  do_syscall_64+0x4c/0xf0
>   [ 1887.210222]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>   [ 1887.210868]
>   [ 1887.211074] Freed by task 36:
>   [ 1887.211460]  kasan_set_track+0x3f/0x60
>   [ 1887.211951]  kasan_save_free_info+0x28/0x40
>   [ 1887.212485]  ____kasan_slab_free+0x101/0x180
>   [ 1887.213027]  __kmem_cache_free+0xe4/0x210
>   [ 1887.213514]  btf_free+0x5b/0x130
>   [ 1887.213918]  rcu_core+0x638/0xcc0
>   [ 1887.214347]  __do_softirq+0x114/0x37e
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] bpf: Fix a race condition between btf_put() and map_free()
    https://git.kernel.org/bpf/bpf-next/c/59e5791f59dd
  - [bpf-next,v6,2/2] selftests/bpf: Remove flaky test_btf_id test
    https://git.kernel.org/bpf/bpf-next/c/56925f389e15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



