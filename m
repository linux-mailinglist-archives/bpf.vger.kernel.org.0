Return-Path: <bpf+bounces-70901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D520BD94A2
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 14:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ED404E4959
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301B3128A7;
	Tue, 14 Oct 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvG7eOAM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E431280D
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444054; cv=none; b=Krf7wXWS1HZDAJ7JNAJ/zMG0I6jNiNWS21y33/8Y/oae1WaH0Jgoz4GeAo58HhayaUyxc2Yccaf25Mz9jM02NcdeBAFq1ccbmPMgSEh2hzWRIYUWs1h+gQUKCUSw984/jFeqx3M6V2cRL6MfTEcR0dnLx5YmBL3apPDsbGHY7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444054; c=relaxed/simple;
	bh=fIBzMkg0VGF52LXe1aiatwyk4pMCOhu7mOP/HlvLhSQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzLIy8OhYJle6zDHA0pEUh3X3NE9MuslKB+/JkO4XBls2juCnVlgMM6rp4fsrOshRpXlR0H0tTtR9WWjNga8Z1zKdUUJhf5Q2GNDDvPfR3dWAtHeu4PbGwiMjK/q4F7qoOBmNEimjwnBUUg8X0a7qWCcD82xMUgXJyQ0jXj4LqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvG7eOAM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b403bb7843eso1119881066b.3
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760444047; x=1761048847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4uv5mR3gumLLTp4rzrsge5eRolk8g3BgbWGMPSIr70=;
        b=fvG7eOAMSKj3VnEF6W9A6rI3EbIps9jpVGhIf5yvHF7LlcHmxe1scAATSS1JB3pNWT
         XGgcvCFKnYUlHCxUsAxSB43g9uzu8y3957zpKYYZhgvS5PipzRvZjl6DLVmi6N+5bM6a
         G9KJs3R24CDXOKkZyy7xkE8EglxXqZd8hdLYIEFQVaKz0R/yg61uYzVvHX90Y9Z0rHEz
         lDvgYraTbLwmm1ppLQWYtWSXfm0zhgShBanpRxwiIDkaK//Q1ytZcEIeF4TrYRBliVmz
         c3qNbvnAA3KmHZ3FNb6Zh1FYurn25PHQPRCc89mNo/lLBq4u54WbQlBvJyjtpkuzVtC3
         FgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444047; x=1761048847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4uv5mR3gumLLTp4rzrsge5eRolk8g3BgbWGMPSIr70=;
        b=ba2cELJa/elyvA1eSqd6BKLWm77Nm0sScfLZH5TrObX4Wuud6QDd8DocIeWdf3vE2g
         cWrPYvAziPjpSeQTLTp+hYDX1zwP4XJz5Gwp/gxe5WhihElwv1SpoJGHfS49KtkWODvh
         adT2Q3t4y0C2Kb61y1EXCyocUGQ4O13O8y90LtsoLWvKDCcl7XACbig3eu5OkpTo7LFf
         0FKxa9qVp92E7MbnGv6GIuw1MHnCGMSN7o8APlpUngJw8LenWDr376lW/hfMZv1w72PN
         BBNDFFxejwkTb8sdUaw68nn9rZs+hhFtfaEIgLzqh0rZJG+ujLLQ63TsgJE5Mi80iaRT
         Hoyg==
X-Forwarded-Encrypted: i=1; AJvYcCVXkxbSXLKwhxwDT/DwzpKNAH+/5POjvw/JuT59+BuznDro8Cn/TPDQtiVwLExUAxDZCG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk3gi5R90ilnKRxCCi5UxtD97zCd2L9PEll8GuPTO/on/rHVsE
	xvxT+PuPtBdtIomt+TCD9d1Y6vpRYRhL/7e0TahcGuCYbu4A/bJirvOF
X-Gm-Gg: ASbGncvWYzJp6q/8Wot9lt5gYFbkzDcofkj+JmX9mkWbSdLQ75Iw+uQxCa8PEyeiYQV
	BXpTydFt7QNOy5nqRIoN8LTW8Ceb1LTxWq2zYKwoPSs0h+1HSovy2J+iQo0FuHSNmxOHChFQeY1
	WPjnDKfvuZERd1SWWk8RIrqhN6Y1J6kZFE81r4JkwjGLtFH5+HzYBhn/hHjWqv045Dp0w3FPDUi
	b+gnsAiLXMYLGTPl3bqDye7JcwoJ31ewji5vtIlqGweEc6dovbdbej6yoAXQvNTtrfaSI5fC6Uz
	+nA6ppdIL5eY3idIE5R8c2EgWVVpBfS00frfsHvVr5alksZaKdm2Z3HH6DrtjZIZG6cXBKTL363
	tyGjBpB5IbMUp7ntU1qtZayFruw==
X-Google-Smtp-Source: AGHT+IHkRlcBwOY51BkfooCa8LhIq4rnJgTTrE+rrJI+8PsajKfIrEpNVRNGLaYNbHSpIVOY51g+2w==
X-Received: by 2002:a17:907:2d93:b0:afe:b92b:28e9 with SMTP id a640c23a62f3a-b50ac5d0859mr2537079066b.49.1760444046995;
        Tue, 14 Oct 2025 05:14:06 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d61cd9f5sm1130915166b.21.2025.10.14.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:14:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Oct 2025 14:14:04 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry
 to get_perf_callchain
Message-ID: <aO4-jAA5RIUY2yxc@krava>
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014100128.2721104-3-chen.dylane@linux.dev>

On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
> stack-allocated memory of bpf_perf_callchain_entry is used here.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 94e46b7f340..acd72c021c0 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -31,6 +31,11 @@ struct bpf_stack_map {
>  	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>  };
>  
> +struct bpf_perf_callchain_entry {
> +	u64 nr;
> +	u64 ip[PERF_MAX_STACK_DEPTH];
> +};
> +
>  static inline bool stack_map_use_build_id(struct bpf_map *map)
>  {
>  	return (map->map_flags & BPF_F_STACK_BUILD_ID);
> @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>  	bool user = flags & BPF_F_USER_STACK;
>  	struct perf_callchain_entry *trace;
>  	bool kernel = !user;
> +	struct bpf_perf_callchain_entry entry = { 0 };

so IIUC having entries on stack we do not need to do preempt_disable
you had in the previous version, right?

I saw Andrii's justification to have this on the stack, I think it's
fine, but does it have to be initialized? it seems that only used
entries are copied to map

jirka

>  
>  	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>  			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
> @@ -314,12 +320,8 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>  	if (max_depth > sysctl_perf_event_max_stack)
>  		max_depth = sysctl_perf_event_max_stack;
>  
> -	trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
> -				   false, false);
> -
> -	if (unlikely(!trace))
> -		/* couldn't fetch the stack trace */
> -		return -EFAULT;
> +	trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry,
> +				   kernel, user, max_depth, false, false);
>  
>  	return __bpf_get_stackid(map, trace, flags);
>  }
> @@ -412,6 +414,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
>  	bool user = flags & BPF_F_USER_STACK;
>  	struct perf_callchain_entry *trace;
> +	struct bpf_perf_callchain_entry entry = { 0 };
>  	bool kernel = !user;
>  	int err = -EINVAL;
>  	u64 *ips;
> @@ -451,8 +454,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	else if (kernel && task)
>  		trace = get_callchain_entry_for_task(task, max_depth);
>  	else
> -		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
> -					   crosstask, false);
> +		trace = get_perf_callchain(regs, (struct perf_callchain_entry *)&entry,
> +					   kernel, user, max_depth, crosstask, false);
>  
>  	if (unlikely(!trace) || trace->nr < skip) {
>  		if (may_fault)
> -- 
> 2.48.1
> 

