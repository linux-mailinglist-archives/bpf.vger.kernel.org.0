Return-Path: <bpf+bounces-42671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464639A723C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 20:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE326283329
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 18:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6771F942E;
	Mon, 21 Oct 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nZJKrTG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D1194AF6
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535040; cv=none; b=mAm2qizUvolrHF3wSZfVJEhUedWD/jgFu+3HBWZD/2EybUZIZ6QbS//9yYj7XcmP19Xa1/kRSeaTYjhnFTqrGVeAMg2x/sB4m8yMJJZ+mCHB5wI6e3/ZJo1nnnQJAlBGnzbKqaEN8heb+HMizj1U4v1Yu+Hqwm5103lvALJgpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535040; c=relaxed/simple;
	bh=8hO7WVmgs/54rE/Qnx5FskJRGtxef3jfJ04J3wZOwwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ELhuwROH7PMSAUtsmsczol1mgMgB8qW50fgJljEDBXeYCqDnlp/AJMjSr0OFkbIyKVANtR03gRsyjWlCBfGWZsygQQFx3qxgo4cC6nt3k8/GUE6uHeTvSGkSKfI05uMhqWBmkcgZ8kWMIz0OG2E3Y+Zbt5ye66pLWg7yJFj50wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nZJKrTG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2bd9b1441aso2689858276.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729535037; x=1730139837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCHyWAzgLFh6Pz5pJ9aASJ+gjKaVKunSmhhMck3hZyU=;
        b=0nZJKrTGc9HNp3zRFdJo5A52JGLbGL6pZq6tMspjwb8a+iBPAGxsinXdwmMJxmUaVc
         e8Asp1Us6mDpmouteQD69ST4+vDaA4Mf3R62TUnr/WAmADWhlxPOxyfoXYvxJaCt0byA
         Qw1kfLR0PevYzRqkr8MLbajzducDCfQlPWUe/xv8tfuC363dGavLTzdZEJHodQwwuDtV
         2M/hKMKNK1gjwNoohM6gRGBwfB3kgl4PW2EYg5YCT2DVZAQW+2MR5ok6HwYcuT6VHbYC
         bx4899LgiNwPVk27kCTNwz/tGDCnerCy/U0YEWYXh/mApp0i2gFmlNUq3Rijf7tWropu
         DMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535037; x=1730139837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCHyWAzgLFh6Pz5pJ9aASJ+gjKaVKunSmhhMck3hZyU=;
        b=mmlsy8jgwM/LRXRTN9JZZh01npVs0agREt8ZdJ/b4X2AnMm1T4wYJlVEmclWRz5sO/
         9kjfGfPdIxCma+sUIq7ZaoPQx5Mo8g65g4ZoBTqSvGKcPsTvU0IRv46p/EQNLlKiWfY9
         6YewQ9KKFGI7hQ3VpzabI2SqwbtjQZMZHI4OpmbCqNPLHk+5yh0Cg1zgRMG0HGGjiRRE
         a6ZUkz2NxWUyYN/i6ci2dQOLVspbPHEq6EjxGw3FTvRZiJf0oL5HCN0UUevLy47oFiY3
         NDsjLCOOH/cI+PWw9biwFyxt9WTS9c4WdL3UEu8/4gzx+xDTLyThMm/zJhOEqPJpE01B
         2aKA==
X-Forwarded-Encrypted: i=1; AJvYcCWKbObuL/8olKI2BipZ/iPc19WKFeBxP9jg7YJuO4P/cjeaipFEd3SgOJoOyEM54MFS6BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7E4K3p3eoYbVeOpAK41t8oOTrfWcPr2OFSfOi7ntVa6ufJ84L
	FRyHbTxIAidCAWhWeOjtDsE3SdO4a0XtGYMfej1ZOIxyvDVWM4ZmrdkZ+GGl0Vc+hz724mQ8Iw=
	=
X-Google-Smtp-Source: AGHT+IGU9wQ/1p0Qc2O+WS90aQobDGhVJv5JsMEe6PkyP+aaKw6VNLs64wQj+yTMqXYj7j0ZxkJT/QBjqg==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a25:dc8d:0:b0:e2b:d018:9690 with SMTP id
 3f1490d57ef6-e2bd0189713mr16383276.11.1729535037035; Mon, 21 Oct 2024
 11:23:57 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:23:47 +0000
In-Reply-To: <67121037.050a0220.10f4f4.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67121037.050a0220.10f4f4.000f.GAE@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241021182347.77750-1-jrife@google.com>
Subject: Re: [syzbot] [trace?] [bpf?] KASAN: slab-use-after-free Read in
 bpf_trace_run2 (2)
From: Jordan Rife <jrife@google.com>
To: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"

I performed a bisection and this issue starts with commit a363d27cdbc2
("tracing: Allow system call tracepoints to handle page faults") which
introduces this change.

> + *
> + * With @syscall=0, the tracepoint callback array dereference is
> + * protected by disabling preemption.
> + * With @syscall=1, the tracepoint callback array dereference is
> + * protected by Tasks Trace RCU, which allows probes to handle page
> + * faults.
>   */
>  #define __DO_TRACE(name, args, cond, syscall)				\
>  	do {								\
> @@ -204,11 +212,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (!(cond))						\
>  			return;						\
>  									\
> -		preempt_disable_notrace();				\
> +		if (syscall)						\
> +			rcu_read_lock_trace();				\
> +		else							\
> +			preempt_disable_notrace();			\
>  									\
>  		__DO_TRACE_CALL(name, TP_ARGS(args));			\
>  									\
> -		preempt_enable_notrace();				\
> +		if (syscall)						\
> +			rcu_read_unlock_trace();			\
> +		else							\
> +			preempt_enable_notrace();			\
>  	} while (0)

Link: https://lore.kernel.org/bpf/20241009010718.2050182-6-mathieu.desnoyers@efficios.com/

I reproduced the bug locally by running syz-execprog inside a QEMU VM.

> ./syz-execprog -repeat=0 -procs=5 ./repro.syz.txt

I /think/ what is happening is that with this change preemption may now
occur leading to a scenario where the RCU grace period is insufficient
in a few places where call_rcu() is used. In other words, there are a
few scenarios where call_rcu_tasks_trace() should be used instead to
prevent a use-after-free bug when a preempted tracepoint call tries to
access a program, link, etc. that was freed. It seems the syzkaller
program induces page faults while attaching raw tracepoints to
sys_enter making preemption more likely to occur.

kernel/tracepoint.c
===================
> ...
> static inline void release_probes(struct tracepoint_func *old)
> {
> 	...
> 	call_rcu(&tp_probes->rcu, rcu_free_old_probes); <-- Here
> 	...
> }
> ...

kernel/bpf/syscall.c
====================
> static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
> {
> 	bpf_prog_kallsyms_del_all(prog);
> 	btf_put(prog->aux->btf);
> 	module_put(prog->aux->mod);
> 	kvfree(prog->aux->jited_linfo);
> 	kvfree(prog->aux->linfo);
> 	kfree(prog->aux->kfunc_tab);
> 	if (prog->aux->attach_btf)
> 		btf_put(prog->aux->attach_btf);
> 
> 	if (deferred) {
> 		if (prog->sleepable) <------ HERE: New condition needed?
> 			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
> 		else
> 			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
> 	} else {
> 		__bpf_prog_put_rcu(&prog->aux->rcu);
> 	}
> }
> 
> static void bpf_link_free(struct bpf_link *link)
> {
> 	const struct bpf_link_ops *ops = link->ops;
> 	bool sleepable = false;
> 
> 	bpf_link_free_id(link->id);
> 	if (link->prog) {
> 		sleepable = link->prog->sleepable;
> 		/* detach BPF program, clean up used resources */
> 		ops->release(link);
> 		bpf_prog_put(link->prog);
> 	}
> 	if (ops->dealloc_deferred) {
> 		/* schedule BPF link deallocation; if underlying BPF program
> 		 * is sleepable, we need to first wait for RCU tasks trace
> 		 * sync, then go through "classic" RCU grace period
> 		 */
> 		if (prog->sleepable) <------ HERE: New condition needed?
> 			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> 		else
> 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
> 	} else if (ops->dealloc)
> 		ops->dealloc(link);
> }

After patching things locally to ensure that call_rcu_tasks_trace() is
always used in these three places I was unable to induce a KASAN bug
to occur whereas before it happened pretty much every time I ran 
./sys-execprog within a minute or so.

I'm a bit unsure about the actual conditions under which
call_rcu_tasks_trace() should be used here though. Should there perhaps
be another condition such as `preemptable` which is used to determine
if call_rcu_tasks_trace() or call_rcu() should be used to free
links/programs? Is there any harm in just using call_rcu_tasks_trace()
every time in combination with rcu_trace_implies_rcu_gp() like it is
in bpf_link_defer_dealloc_mult_rcu_gp()?

> static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)?
> {
> 	if (rcu_trace_implies_rcu_gp())
> 		bpf_link_defer_dealloc_rcu_gp(rcu);
> 	else
> 		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
> }

- Jordan

