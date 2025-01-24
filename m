Return-Path: <bpf+bounces-49708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B56A1BD4D
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 21:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F55188696F
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A101921A425;
	Fri, 24 Jan 2025 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DtvJlfcJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F718A93E
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750066; cv=none; b=ESgwCN8B8WuXMxKdEku721VYXf05nvxpX5QFT9Zc29EUWrGKVTIaS0qKvVAR2mlw5ak7GFRV7b/+r/vzGytwMc8PpiAj7zRTPs98tONcuEqhj/L3wuEH8PUcgTrcO1rVYVsIhbtg/mES1rdfn9FpPPsMyxwgYL0r3SBUG+YWc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750066; c=relaxed/simple;
	bh=Yb1W1gjJqHwl1D4aMg6xgGWVL9WrsI7znMGCeIRMM5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpV5jIo0xaZT77xi2IoERYLOd2xIZPS/6ozVM8KfvdQZaK34bypiKBcQ1F70F6EkDtLmU6SkfPIgXz6EgfgNc9SScglVWWhO8iiCccVXDfmWYiXhFqLwhYa19b9Cwf8RCif5fOhF+nA3S0Hp9QV7kSpS6v/tYg37Ci2LSatwkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DtvJlfcJ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02c69185-1477-485c-af4f-a46f7aadadab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737750054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YB9Lkx2YLsx81q0woXn4RYBLPtp8YNlgiS03lX4O1zc=;
	b=DtvJlfcJfZ3EE/MgqSFwKX/dT7w/cfgHzpTaA5Yi37ktQFVhaleZdSp2/U9pLQMnmXvWge
	1OUpENRtzOO1ZRT2Ub1EWyx/3VR5btmtPmfgiNMTlDyLTND2m42bdvdFgOAf9HbsZadcwu
	3Ux8q3DI3kiWk7l7UfIKgRyuWx+uKvE=
Date: Fri, 24 Jan 2025 12:20:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf: Fix deadlock when freeing cgroup storage
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>,
 "open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241221061018.37717-1-wuyun.abel@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241221061018.37717-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/24 10:10 PM, Abel Wu wrote:
> The following commit
> bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
> first introduced deadlock prevention for fentry/fexit programs attaching
> on bpf_task_storage helpers. That commit also employed the logic in map
> free path in its v6 version.
> 
> Later bpf_cgrp_storage was first introduced in
> c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
> which faces the same issue as bpf_task_storage, instead of its busy
> counter, NULL was passed to bpf_local_storage_map_free() which opened
> a window to cause deadlock:
> 
> 	<TASK>
> 		(acquiring local_storage->lock)
> 	_raw_spin_lock_irqsave+0x3d/0x50
> 	bpf_local_storage_update+0xd1/0x460
> 	bpf_cgrp_storage_get+0x109/0x130
> 	bpf_prog_a4d4a370ba857314_cgrp_ptr+0x139/0x170
> 	? __bpf_prog_enter_recur+0x16/0x80
> 	bpf_trampoline_6442485186+0x43/0xa4
> 	cgroup_storage_ptr+0x9/0x20
> 		(holding local_storage->lock)
> 	bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
> 	bpf_selem_unlink_storage+0x6f/0x110
> 	bpf_local_storage_map_free+0xa2/0x110
> 	bpf_map_free_deferred+0x5b/0x90
> 	process_one_work+0x17c/0x390
> 	worker_thread+0x251/0x360
> 	kthread+0xd2/0x100
> 	ret_from_fork+0x34/0x50
> 	ret_from_fork_asm+0x1a/0x30
> 	</TASK>
> 
> Progs:
>   - A: SEC("fentry/cgroup_storage_ptr")

The v1 thread has suggested using notrace in a few functions. I didn't see any 
counterarguments that wouldn't be sufficient.

imo, that should be a better option instead of having more unnecessary failures 
in all other normal use cases which will not be interested in tracing 
cgroup_storage_ptr().

pw-bot: cr

>     - cgid (BPF_MAP_TYPE_HASH)
> 	Record the id of the cgroup the current task belonging
> 	to in this hash map, using the address of the cgroup
> 	as the map key.
>     - cgrpa (BPF_MAP_TYPE_CGRP_STORAGE)
> 	If current task is a kworker, lookup the above hash
> 	map using function parameter @owner as the key to get
> 	its corresponding cgroup id which is then used to get
> 	a trusted pointer to the cgroup through
> 	bpf_cgroup_from_id(). This trusted pointer can then
> 	be passed to bpf_cgrp_storage_get() to finally trigger
> 	the deadlock issue.
>   - B: SEC("tp_btf/sys_enter")
>     - cgrpb (BPF_MAP_TYPE_CGRP_STORAGE)
> 	The only purpose of this prog is to fill Prog A's
> 	hash map by calling bpf_cgrp_storage_get() for as
> 	many userspace tasks as possible.
> 
> Steps to reproduce:
>   - Run A;
>   - while (true) { Run B; Destroy B; }
> 
> Fix this issue by passing its busy counter to the free procedure so
> it can be properly incremented before storage/smap locking.
> 
> Fixes: c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>   kernel/bpf/bpf_cgrp_storage.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> index 20f05de92e9c..7996fcea3755 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -154,7 +154,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>   
>   static void cgroup_storage_map_free(struct bpf_map *map)
>   {
> -	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
> +	bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
>   }
>   
>   /* *gfp_flags* is a hidden argument provided by the verifier */


