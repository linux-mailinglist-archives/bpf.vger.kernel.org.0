Return-Path: <bpf+bounces-47296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEA89F72F7
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 03:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EF61891A14
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 02:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90F1A08C5;
	Thu, 19 Dec 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T4K/LGYu"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094619E7F7
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576354; cv=none; b=NdXB0tp0GvKd/i83oVywchpxl6mp2B1z6WI2zJCew27abmRVJxP5Pme0YS3uh6mWhkvoAMKd9NXX9DBXFQ62jDS/IwVyTR4KMAosLJNUM21LkuCvSh8wCvnqXX4qGAMaqIWXtyMB7JJBxo07jhAFXF+Nn17uK2+NeGFLv5ZKkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576354; c=relaxed/simple;
	bh=2nPmr55spPv3F842Zd7uAsiUa4imHnh5oPaeWnF/WNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/68NenmOO3iCe3Ra/mTKw8PhV++PgOBPwqJee65kLaiulMIX2IEe44M/8qxQihDO5FARgYfn53/d9xou+NKt4In5eD6VDdwGFLdrHvkZd5m34rVrrI6f6ra/QgB2iVjONLgAFO9AU2j2rjO7aax6sfgkd2JWf9OrJp7B+7oKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T4K/LGYu; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb9d4609-970e-4760-af94-8e48cca7ec23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734576339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAMyW4oZEHUM3nFgztJTzHyHr7HEd39GcX9IeUZWofc=;
	b=T4K/LGYuQiRxY8XE21+BJJVOy+SoWILpMQNVxH96I7yKG253mn3ZByzMMgxIZqZUSMmhJv
	JI8Qete7n9drcnGg2EC3Lrhd33h6IZM+GGPELtDwIqmc2tML8TyqhlpkNX2FWuzMBpdr4E
	HBFZqILwccwTEUFmSb/B6Vni25U+oG0=
Date: Wed, 18 Dec 2024 18:45:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix deadlock when freeing cgroup storage
Content-Language: en-GB
To: Abel Wu <wuyun.abel@bytedance.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 David Vernet <void@manifault.com>
Cc: "open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241218092149.42339-1-wuyun.abel@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241218092149.42339-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 12/18/24 1:21 AM, Abel Wu wrote:
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
> 	_raw_spin_lock_irqsave+0x3d/0x50
> 	bpf_local_storage_update+0xd1/0x460
> 	bpf_cgrp_storage_get+0x109/0x130
> 	bpf_prog_72026450ec387477_cgrp_ptr+0x38/0x5e
> 	bpf_trace_run1+0x84/0x100
> 	cgroup_storage_ptr+0x4c/0x60
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
> 	[ Since the verifier treats 'void *' as scalar which
> 	  prevents me from getting a pointer to 'struct cgroup *',
> 	  I added a raw tracepoint in cgroup_storage_ptr() to
> 	  help reproducing this issue. ]
>
> Although it is tricky to reproduce, the risk of deadlock exists and
> worthy of a fix, by passing its busy counter to the free procedure so
> it can be properly incremented before storage/smap locking.

The above stack trace and explanation does not show that we will have
a potential dead lock here. You mentioned that it is tricky to reproduce,
does it mean that you have done some analysis or coding to reproduce it?
Could you share the details on why you think we may have deadlock here?

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


