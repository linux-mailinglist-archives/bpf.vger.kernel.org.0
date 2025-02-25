Return-Path: <bpf+bounces-52504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230F9A4401B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82C5178AE3
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA732686AF;
	Tue, 25 Feb 2025 13:03:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1131E485
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488632; cv=none; b=LdDEF95Ye/GyXpzPm2rlTQ47LGjnQB0/bP76KqhLW0PUIuSrlpyAfIJezorJEfKhooheJgYw7vCY1F+CB8WdLnLIChheB4N/ps3KmUXmGsuajjcQbEmoOSKIpXS51DFaHdo9hSZ2vwE4jWjg+7MfRhEkmcS7bc69Kbat5+4+o2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488632; c=relaxed/simple;
	bh=+IvFYzkwxcqbjtXv5SrtKrBuVivN1BtAtz2kvgmOOio=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RigKqfRrRCxlfvA21OTTS+UnP4C+QIi57hD3HHUmLDQtXiXSYiNz8DaBKKSfVBWD3bNhMfyhmPE7HLb4N5mup3QVE9gQLJwO6O5df1FEAbltIwWRVWyQzxHUvojXv08yeiMnZs6QlAwn13W76VlX+Aytmlhs8kdvXhtXZihf+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z2Hpk0S2Dz4f3jsy
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 21:03:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8948C1A0FDC
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 21:03:42 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBnBsGqv71nC4kwEw--.8691S2;
	Tue, 25 Feb 2025 21:03:42 +0800 (CST)
Subject: Re: [PATCH bpf-next] bpf: Fix deadlock between rcu_tasks_trace and
 event_mutex.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com, kernel-team@fb.com
References: <20250224221637.4780-1-alexei.starovoitov@gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <df335e68-2b30-7cd3-1fb4-e988c8d8ff82@huaweicloud.com>
Date: Tue, 25 Feb 2025 21:03:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250224221637.4780-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBnBsGqv71nC4kwEw--.8691S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fAryDuw4fZw1rXr4xWFg_yoW8tFW3pF
	s8JF90kF48Ar42q3Z3Xr40yr13C3sYq3y5JwsrGr1fAr1DXr4vganFqrW3tFyF9ry7GF9I
	ya1j9rZIgw48Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/25/2025 6:16 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Fix the following deadlock:
> CPU A
> _free_event()
>   perf_kprobe_destroy()
>     mutex_lock(&event_mutex)
>       perf_trace_event_unreg()
>         synchronize_rcu_tasks_trace()
>
> There are several paths where _free_event() grabs event_mutex
> and calls sync_rcu_tasks_trace. Above is one such case.
>
> CPU B
> bpf_prog_test_run_syscall()
>   rcu_read_lock_trace()
>     bpf_prog_run_pin_on_cpu()
>       bpf_prog_load()
>         bpf_tracing_func_proto()
>           trace_set_clr_event()
>             mutex_lock(&event_mutex)

Considering the unregistered case is not so frequency, would it better
to use mutex_trylock firstly, then fallback to workqueue when the
event_mutex is busy ?
>
> Delegate trace_set_clr_event() to workqueue to avoid
> such lock dependency.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a612f6f182e5..13bef2462e94 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -392,7 +392,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
>  	.arg2_type	= ARG_CONST_SIZE,
>  };
>  
> -static void __set_printk_clr_event(void)
> +static void __set_printk_clr_event(struct work_struct *work)
>  {
>  	/*
>  	 * This program might be calling bpf_trace_printk,
> @@ -405,10 +405,11 @@ static void __set_printk_clr_event(void)
>  	if (trace_set_clr_event("bpf_trace", "bpf_trace_printk", 1))
>  		pr_warn_ratelimited("could not enable bpf_trace_printk events");
>  }
> +static DECLARE_WORK(set_printk_work, __set_printk_clr_event);
>  
>  const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
>  {
> -	__set_printk_clr_event();
> +	schedule_work(&set_printk_work);
>  	return &bpf_trace_printk_proto;
>  }
>  
> @@ -451,7 +452,7 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
>  
>  const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
>  {
> -	__set_printk_clr_event();
> +	schedule_work(&set_printk_work);
>  	return &bpf_trace_vprintk_proto;
>  }
>  


