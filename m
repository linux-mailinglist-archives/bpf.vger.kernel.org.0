Return-Path: <bpf+bounces-74093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D96C48684
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 18:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29689188F720
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193732DF12C;
	Mon, 10 Nov 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZY4mMquf"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7F2DECC5
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796717; cv=none; b=MZ/Xw/nP8S9jHBNTTB+HIYogHP0dqHnPguUpKMSR/ABnjcIew+VB/BtnVb8OvkV70bhgkHf47YKF4j4XlO4C14LmwPC6lvOLV+r7hn/t9aAtmF1FBoIHcHzLFRxIbuIwD+90XI3NBViLjGQtTJERObw5bhfAbdpK3Wfu6yfq9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796717; c=relaxed/simple;
	bh=kwN84qy/oBPX6YnfaFNRHfHYmA+10kfLAcPRduIOzMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktJAhWBnOB2oH1bh+c5yK6pwOI2zN5Y68qA5J0eggO+FT83kel6mKJEfcgzLdtWul/VVURhOwS4Pf5bny2CCGLl9N6JYz4UBVnSdM/KPW3Rj3+l92U86wsJLl5prOOJViz9m0ZJIiQps7ILGnuBTx0XyP0T4JivLndQHNrbTJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZY4mMquf; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03bc2787-b5e7-42e7-9812-8c50da912c0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762796708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgIIS0dl/K3pyYhjPZ2xzLo9ZkZ814D6YOqhxSd8kGo=;
	b=ZY4mMqufj21zxNwIXXOMfojj2NGonV6beF7izIKv6lsf+zRP8X8xLCoKVfT0KzhSC0/Bbw
	dHjRngNVMhnGC6JVcP6cVnnKPWlfzHUxhFiKpkQErnuiwkGE6Ao2Q+LW7+iAY2H58Hn4q8
	ox5I0Hab2UBG+pWo0a51Wa346wVdkCA=
Date: Mon, 10 Nov 2025 09:44:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: use preempt_disable/enable() to protect
 bpf_bprintf_buffers nesting
Content-Language: en-GB
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bot+bpf-ci@kernel.org, chandna.sahil@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.comi,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20251109173648.401996-1-chandna.sahil@gmail.com>
 <588e208637619b6c256f2a70dc35faeafda1a843b6410def9fa53ef8876a46e8@mail.kernel.org>
 <2ed9877e-77e4-4f18-84fd-dc8b1ffe810f@linux.dev>
 <20251110132546.eE4o18h6@linutronix.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251110132546.eE4o18h6@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/10/25 5:25 AM, Sebastian Andrzej Siewior wrote:
> On 2025-11-09 11:44:48 [-0800], Yonghong Song wrote:
>
> Could we do this instead?
> There is  __bpf_stream_push_str() => bpf_stream_page_reserve_elem() =>
> bpf_stream_page_replace() => alloc_pages_nolock().

I would suggest to stick to preempt_disable/enable().
In the bpf-next (newer change), for function
bpf_stream_elem_alloc(), kmalloc_nolock() is used
and no local_lock usage any more.


>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b469878de25c8..5a4965724c374 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1598,6 +1598,7 @@ struct task_struct {
>   	void				*security;
>   #endif
>   #ifdef CONFIG_BPF_SYSCALL
> +	s8				bpf_bprintf_idx;
>   	/* Used by BPF task local storage */
>   	struct bpf_local_storage __rcu	*bpf_storage;
>   	/* Used for BPF run context */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index eb25e70e0bdc0..62e37c845ec5a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -770,28 +770,39 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
>   /* Support executing three nested bprintf helper calls on a given CPU */
>   #define MAX_BPRINTF_NEST_LEVEL	3
>   
> -static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
> -static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
> +struct bpf_cpu_buffer {
> +	struct bpf_bprintf_buffers bufs[MAX_BPRINTF_NEST_LEVEL];
> +	local_lock_t	lock[MAX_BPRINTF_NEST_LEVEL];
> +};
> +
> +static DEFINE_PER_CPU(struct bpf_cpu_buffer, bpf_cpu_bprintf) = {
> +	.lock = { [0 ... MAX_BPRINTF_NEST_LEVEL - 1] = INIT_LOCAL_LOCK(bpf_cpu_bprintf.lock) },
> +};
>   
>   int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>   {
> -	int nest_level;
> +	s8 nest_level;
>   
> -	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
> -	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
> -		this_cpu_dec(bpf_bprintf_nest_level);
> +	nest_level = current->bpf_bprintf_idx++;
> +	if (WARN_ON_ONCE(nest_level >= MAX_BPRINTF_NEST_LEVEL)) {
> +		current->bpf_bprintf_idx--;
>   		return -EBUSY;
>   	}
> -	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>   
> +	local_lock(&bpf_cpu_bprintf.lock[nest_level]);
> +	*bufs = this_cpu_ptr(&bpf_cpu_bprintf.bufs[nest_level]);
>   	return 0;
>   }
>   
>   void bpf_put_buffers(void)
>   {
> -	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
> +	s8 nest_level;
> +
> +	nest_level = current->bpf_bprintf_idx;
> +	if (WARN_ON_ONCE(nest_level == 0))
>   		return;
> -	this_cpu_dec(bpf_bprintf_nest_level);
> +	local_unlock(&bpf_cpu_bprintf.lock[nest_level - 1]);
> +	current->bpf_bprintf_idx--;
>   }
>   
>   void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)


