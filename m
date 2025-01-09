Return-Path: <bpf+bounces-48451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27E8A08196
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBFF7A3654
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80DE1F427A;
	Thu,  9 Jan 2025 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/oLLoA7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3384039;
	Thu,  9 Jan 2025 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455790; cv=none; b=XOwPF9m0jZJ8vfvpK68ozC8SWIoduYKbAc9kuA8OhxcnhjNgk/qkHIehKFDMvUIoLbuNcG+f3/hDrLbGiifEn3ACGbt/IVrKeLMWATN47sYE0tYIDHjKWtldWAN5tB+xYK2HKT/gSVByxY57e3mIqKRPNYvarH8287k9pEkvKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455790; c=relaxed/simple;
	bh=FH/4qGR5kPhsF4u+Mmf9/LojodSTnp7PLu0zvxD40uY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmfBa9zj1T9CWHVYZ3Rs7DQB9rcIaXxZ8K32EaA2qbi7D0O6Uo95JDbaWNTvKDZf5D3gsf2xlZcqb29FXG3OFjphnbSw+aSsCLvuDyBTE7d+KMRsqsR4N2E8OQd6sSmWxLbArOn47yKC+ig0ataQBs9zU/NSthqBxAXzAuLI1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/oLLoA7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so2070961a12.1;
        Thu, 09 Jan 2025 12:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736455787; x=1737060587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrGAnASATrAJyxyB4lmwfQ0d2tF2OIGq2TmbshecCws=;
        b=Q/oLLoA7cqY1j0++U5fyVoRjfpL4ItVK7qjSK85ucmMXUQIAJ/Yndjg9Fj5hSCQ/iD
         pwxg/W+5sriX62OwooZXMMgWVVdV48U401TPdxSX9mNTXsmd9OOb6M7EgWwdzBFy5sHp
         jMhIQNJccbEWVEl4IR9K+EN9qMQ7eBSqmeWRIzIHOaY00FzUdgsuqfP/LAJy0z7OE+hh
         vOKPRQg2z960HzobdKhH02wvyyXL+AnrWKy81X6iGRWDA3oSSSv8tEvReOmq0WNJSCsz
         uZpC3U3LY8c+WaqypxXAxOSl+aI4RbYve0iebaAiQjYJ2xmZDHJrKyFmIZPTW4H/ijgR
         7EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736455787; x=1737060587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrGAnASATrAJyxyB4lmwfQ0d2tF2OIGq2TmbshecCws=;
        b=NIlp1NJYYIvinn/kajnhV7dFfxyogSvKIbySQWJhrX88+k4NH1AR5NFcZOz1my0PVt
         ZIgI70m7qYsMglzTi6n/bruMKUMMqu5tV+1AkYPIp0qb9kO9uVhYqSuTuAC3I1QsfVyb
         NVdYjBbpaUz4xXS1XVbLIwUwEJ8x1P6dMmeBWLcPycGUvHn8SZ2PQ7nMc5+7ZftCbLA2
         rJPJEqpd64vZUWdAhHDDRvGopXc1yBA4yY27fqKCziNePKJEZSz2WvF5yKUXaP3TIpx3
         QHm/+hcKtHU1CDQ4js0nDb8aMTVO9IaUCBwGIlkM7hX4vcWXADadh+jQ8+l8ijsj1G0Q
         bVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUURzlABuRZap6UIN742SKakb5vEVry8E3CEXvhPeaviqHVPqtYlRBbS4HX0SFD15wuGas=@vger.kernel.org, AJvYcCVGRJww9XfjFoLRgmSY39Fy+YussNM/gRTMK0uGuVtz2Dw+e8TfH7tv51eqH6EYqdjlroZjDt1G7cHE3CVd@vger.kernel.org, AJvYcCVPaT+JrHR7UmM1A+iZqmryi8CPm9GmGXiKsAOj/M+I4US7DhcVsm0Jz1l5dcoomfltqZSIhts712f0/u4mEwECQOv4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5QOyUqREa1kKX3VZoPd4kLteZujfdq0Vbcj0n7/t/Fkp+opA2
	3lKgz9sNGVddrPUjkx2PyuovfyCLwke3ZQm/MH/Qx1HOzFJuHQT6
X-Gm-Gg: ASbGncvZj2fjSh7X6iYYsSIuB0nnNdogpikH3ODN8Ez7uCQdfAZ2N88Kr3b/12alhob
	Yy/5nTcfV0fxi+kyD3diDfpaK3JzSVNA9apTv1eO6nw1cK8F3wbcdZovKsOHYAp+Ltdtpdi7kLx
	CSvBq8Gg4nmkclsnh4E7N36ue2MwNcezkcamsIGOrcLiCgxlifW2VBXWq+MEwBch2CzTx4/1Tm3
	AIGwfXOJe7z1VV8/mv/Y1145unrWRvn4NHdG5p9WTB39p8eSBPGTdHSjKcg2dk=
X-Google-Smtp-Source: AGHT+IGjzr9iM4gWdAjiTc/gBNY9Iyz3JIGALO+iLXbe3zas7tr+roEftRw0LWZGQNOnL7CaHWj1gA==
X-Received: by 2002:a05:6402:2711:b0:5d3:e4eb:8d1f with SMTP id 4fb4d7f45d1cf-5d972e06d96mr7618391a12.12.1736455786416;
        Thu, 09 Jan 2025 12:49:46 -0800 (PST)
Received: from krava (85-193-35-24.rib.o2.cz. [85.193.35.24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a4127sm948195a12.77.2025.01.09.12.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 12:49:46 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 9 Jan 2025 21:49:43 +0100
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Makarov <maxpain@linux.com>, bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Fix race in uprobe_free_utask
Message-ID: <Z4A2Z6wzwXLePriB@krava>
References: <20250109141440.2692173-1-jolsa@kernel.org>
 <af5b64ae-3917-4083-930b-b8e41d3a98d7@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5b64ae-3917-4083-930b-b8e41d3a98d7@iogearbox.net>

On Thu, Jan 09, 2025 at 03:41:26PM +0100, Daniel Borkmann wrote:
> On 1/9/25 3:14 PM, Jiri Olsa wrote:
> > Max Makarov reported kernel panic [1] in perf user callchain code.
> > 
> > The reason for that is the race between uprobe_free_utask and bpf
> > profiler code doing the perf user stack unwind and is triggered
> > within uprobe_free_utask function:
> >    - after current->utask is freed and
> >    - before current->utask is set to NULL
> > 
> >   general protection fault, probably for non-canonical address 0x9e759c37ee555c76: 0000 [#1] SMP PTI
> >   RIP: 0010:is_uprobe_at_func_entry+0x28/0x80
> >   ...
> >    ? die_addr+0x36/0x90
> >    ? exc_general_protection+0x217/0x420
> >    ? asm_exc_general_protection+0x26/0x30
> >    ? is_uprobe_at_func_entry+0x28/0x80
> >    perf_callchain_user+0x20a/0x360
> >    get_perf_callchain+0x147/0x1d0
> >    bpf_get_stackid+0x60/0x90
> >    bpf_prog_9aac297fb833e2f5_do_perf_event+0x434/0x53b
> >    ? __smp_call_single_queue+0xad/0x120
> >    bpf_overflow_handler+0x75/0x110
> >    ...
> >    asm_sysvec_apic_timer_interrupt+0x1a/0x20
> >   RIP: 0010:__kmem_cache_free+0x1cb/0x350
> >   ...
> >    ? uprobe_free_utask+0x62/0x80
> >    ? acct_collect+0x4c/0x220
> >    uprobe_free_utask+0x62/0x80
> >    mm_release+0x12/0xb0
> >    do_exit+0x26b/0xaa0
> >    __x64_sys_exit+0x1b/0x20
> >    do_syscall_64+0x5a/0x80
> > 
> > It can be easily reproduced by running following commands in
> > separate terminals:
> > 
> >    # while :; do bpftrace -e 'uprobe:/bin/ls:_start  { printf("hit\n"); }' -c ls; done
> >    # bpftrace -e 'profile:hz:100000 { @[ustack()] = count(); }'
> > 
> > Fixing this by making sure current->utask pointer is set to NULL
> > before we start to release the utask object.
> 
> Lets add Fixes tag for stable team:
> 
> Fixes: cfa7f3d2c526 ("perf,x86: avoid missing caller address in stack traces captured in uprobe")

ugh right, thanks for finding that

jirka

> 
> > [1] https://github.com/grafana/pyroscope/issues/3673
> > Reported-by: Max Makarov <maxpain@linux.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> fwiw, the other version we were potentially thinking of was below, but
> just moving the t->utask NULL assignment seemed better.
> 
> Thanks,
> Daniel
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index c75c482d4c52..05f9cedf2691 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2835,6 +2835,8 @@ static bool is_uprobe_at_func_entry(struct pt_regs *regs)
> 
>         if (!current->utask)
>                 return false;
> +       if (!current->utask->active_uprobe)
> +               return false;
> 
>         auprobe = current->utask->auprobe;
>         if (!auprobe)

