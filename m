Return-Path: <bpf+bounces-64677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2CFB15563
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 00:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C3818A7407
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825C2874E9;
	Tue, 29 Jul 2025 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NoHxaHhD"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AD28152F
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829126; cv=none; b=MVo4ifbi8AfCTZ6fbU+qCX3NgggTxTsGoeoURd8tXilU5Tauusy1MLlypejDGoe+J99MieoCyRTmhlWW2CnhKhZ/q4LPIgaEjav9D1shikd/oXUrm7M8hYZGbh0vkTFcjYko1noHDv49jE4SdoaAMu69Sd/rHVXQTeHPcMA+9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829126; c=relaxed/simple;
	bh=qL+Vm8lMbkkauUVydnRswhxGIXQ0ZFlJGQG6dIHHVx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtbJc6LZQVPo7e09LNsJTFMhT/Xdb4QELiJ6KX6LAvIBi8XFoHL/X6Q+GKg1TDQ7yq0VGo7d3GikwPAXlNwS4B6o6SN+Iw5NMRz+AERtj0b1oT8VbYqTjId85HTCsX5G909iIcK/BJ5SUOvtpkZyT2XhqPGCTHxr0kVwI5JBxr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NoHxaHhD; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2b69e397-a457-4dba-86f1-47b7fe87ef79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753829111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHtbR4MKyVlIuat93c1sNNhih7aR3T+tXcbxNcT2Hxc=;
	b=NoHxaHhDIYDryk5osFw6tdy4NWlzL14gU4kq/b+bUKuBIsTZV/UQtAPyoXgXpFpyh5Oeq1
	5//b5z38AhmkFaKH5HwKpl0qtiIX3LwrmsFzt11wjD2kE1LTm6DWsFqObiJcmi915PYgLp
	EYTvJhYdkeoVE93Ud5FAz2T9m9mTq14=
Date: Tue, 29 Jul 2025 15:45:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>, song@kernel.org,
 jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
References: <20250729165622.13794-1-contact@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250729165622.13794-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/29/25 9:56 AM, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
> when copying stack trace data. The issue occurs when the perf trace
>   contains more stack entries than the stack map bucket can hold,
>   leading to an out-of-bounds write in the bucket's data array.
> For build_id mode, we use sizeof(struct bpf_stack_build_id)
>   to determine capacity, and for normal mode we use sizeof(u64).
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
> Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>

Could you add a selftest? This way folks can easily find out what is
the problem and why this fix solves the issue correctly.

> ---
> Changes in v2:
>   - Use utilty stack_map_data_size to compute map stack map size
> ---
>   kernel/bpf/stackmap.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 3615c06b7dfa..6f225d477f07 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -230,7 +230,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
>   	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
>   	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> -	u32 hash, id, trace_nr, trace_len, i;
> +	u32 hash, id, trace_nr, trace_len, i, max_depth;
>   	bool user = flags & BPF_F_USER_STACK;
>   	u64 *ips;
>   	bool hash_matches;
> @@ -241,6 +241,12 @@ static long __bpf_get_stackid(struct bpf_map *map,
>   
>   	trace_nr = trace->nr - skip;
>   	trace_len = trace_nr * sizeof(u64);
> +
> +	/* Clamp the trace to max allowed depth */
> +	max_depth = smap->map.value_size / stack_map_data_size(map);
> +	if (trace_nr > max_depth)
> +		trace_nr = max_depth;
> +
>   	ips = trace->ip + skip;
>   	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
>   	id = hash & (smap->n_buckets - 1);


