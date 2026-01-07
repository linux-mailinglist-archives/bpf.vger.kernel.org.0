Return-Path: <bpf+bounces-78155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2513CFFD72
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 20:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0390231CB812
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EAD348899;
	Wed,  7 Jan 2026 18:45:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01D78F2E;
	Wed,  7 Jan 2026 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811506; cv=none; b=MOBI2xa0m2DBptqZHxmRVISQNF6LSCEvZoewNDX15+rb5T2kFhTX88JrEb5as78Qn6sMoCtkhAUqv/EFfkeZ0aSVfUphcMUcTPhv0le2fan7BC2YMm/K8Vy5iOhyFQvE7plQlgyq7qO9zqThTLe0KuP5VASAMZMI7lQQdb+uh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811506; c=relaxed/simple;
	bh=DG3whT9PujCefmKddk6lZ5QNU/GgwbGAuPgSKM+P7mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaAhp8hoBpmxtgZ9hagRCpkOTp9ylbGgiadF8Ba09VUkplsN+EkzlI9OSOyadN9CViEYKFCtLr55azUCPtWiA1IfsOQ5YhHZtoBwYoSGHCf7xY5wqEtQCHeWWP9x05UFPuEBWagGCVMUbIXhIHWVPp4IvYgG/xrKpjuUPsxKIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a01:cb04:302:1e00:dc6d:2db6:511f:add6] (2a01cb0403021e00dc6d2db6511fadd6.ipv6.abo.wanadoo.fr [IPv6:2a01:cb04:302:1e00:dc6d:2db6:511f:add6])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 37E6B407C2;
	Wed,  7 Jan 2026 18:44:55 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a01:cb04:302:1e00:dc6d:2db6:511f:add6) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a01:cb04:302:1e00:dc6d:2db6:511f:add6]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <355281c3-522d-4e29-9289-0e7e35938551@arnaud-lcm.com>
Date: Wed, 7 Jan 2026 19:44:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf-next: Prevent out of bound buffer write in
 __bpf_get_stack
To: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 yonghong.song@linux.dev, Brahmajit Das <listout@listout.xyz>
References: <20260107181237.1075490-1-contact@arnaud-lcm.com>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <20260107181237.1075490-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <176781149575.24306.10856014405059361660@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Aborting in favor of my comment on the first rev.

On 07/01/2026 19:12, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stack()
> during stack trace copying.
>
> The issue occurs when: the callchain entry (stored as a per-cpu variable)
> grow between collection and buffer copy, causing it to exceed the initially
> calculated buffer size based on max_depth.
>
> The callchain collection intentionally avoids locking for performance
> reasons, but this creates a window where concurrent modifications can
> occur during the copy operation.
>
> To prevent this from happening, we clamp the trace len to the max
> depth initially calculated with the buffer size and the size of
> a trace.
>
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/691231dc.a70a0220.22f260.0101.GAE@google.com/T/
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Cc: Brahmajit Das <listout@listout.xyz>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
> Changes in v2:
> 	- Moved the trace_nr clamping to max_depth above trace->nr skip
> 	  verification.
> Link to v1: https://lore.kernel.org/all/20260104205220.980752-1-contact@arnaud-lcm.com/
>
> Thanks Brahmajit Das for the initial fix he proposed that I tweaked
> with the correct justification and a better implementation in my
> opinion.
> ---
>   kernel/bpf/stackmap.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..c0a430f9eafb 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -465,7 +465,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   
>   	if (trace_in) {
>   		trace = trace_in;
> -		trace->nr = min_t(u32, trace->nr, max_depth);
>   	} else if (kernel && task) {
>   		trace = get_callchain_entry_for_task(task, max_depth);
>   	} else {
> @@ -473,13 +472,15 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   					   crosstask, false, 0);
>   	}
>   
> -	if (unlikely(!trace) || trace->nr < skip) {
> +	trace_nr = min(trace->nr, max_depth);
> +
> +	if (unlikely(!trace) || trace_nr < skip) {
>   		if (may_fault)
>   			rcu_read_unlock();
>   		goto err_fault;
>   	}
>   
> -	trace_nr = trace->nr - skip;
> +	trace_nr = trace_nr - skip;
>   	copy_len = trace_nr * elem_size;
>   
>   	ips = trace->ip + skip;

