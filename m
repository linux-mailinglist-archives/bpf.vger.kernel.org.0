Return-Path: <bpf+bounces-66114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB901B2E797
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 23:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885AF176E79
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9EB32C32C;
	Wed, 20 Aug 2025 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihRul78N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16C25D536;
	Wed, 20 Aug 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725934; cv=none; b=MC1qGlxAfU2XtcegJ2vsRQ27n3/jWkZZdxfvFbsHLNC0JNWxz3bYqZ/7o0qvBMWxjpP9gvXzqysybPEwM9u1ffacdPpAC98nrb5vKCfynppDNqTcaoqVJ5Bj+vW0gKqJzGVaCmW1/2yz/TdedKDw8MCZNtNskS5rjuiq9avWkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725934; c=relaxed/simple;
	bh=5zB6co7OtPQZxKOOl7Xwh/DrlpKaV1X5kz7WVukfGIA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZaQQ1aSvPpyUELCY7m5Ccs0fwOe3g6YI9n9IMvgQEg/5Ls2uWFb1QRVhHshpXIyt4NptJyds6JRBffVIkKLn5Kv6+IL6rRwLFgTSBPAMUbpy+Ow8lhTfTS0bD09qngRn+yGur+hSidaFKpEdgA8ZHpY5Gw9pSSC+Vq85UFF7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihRul78N; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb79db329so48918766b.2;
        Wed, 20 Aug 2025 14:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755725931; x=1756330731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9db3IZVe2NPrY1qxMzZWeMQAIN9TwhFbWzhqQDFk+I=;
        b=ihRul78NYsEXvuxT174LjapxZsfsXCvvUzGXiRdNjnfbdFtfIZOA2i6D5eQA+Dlz4i
         0Gqt+rXekC+v6VM6hxcQR14Y+c/JRUu/yeENpu1QbeZTx1r9V16aNAwRmom8+r5a/nfb
         J4RQfXsT8kgicRNMOgyUdgakfdKQUAL4WW632a/+xNmfivdm5jxbsdIQAnH5OeKG3SGu
         bpdrM2Ivx2iudMYvU6wL7NJkzCyS1PquV3kvrgwFNnDP+mpxT3q/8tGBmiZjdYHOnbiS
         3nqOt2ulYrthfZzUEom4WUnhKv1aG9I/2BXrCdwLgnz7+MEfKOR4rbMbzrPVx0wi4c75
         CHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755725931; x=1756330731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9db3IZVe2NPrY1qxMzZWeMQAIN9TwhFbWzhqQDFk+I=;
        b=ANpomgFIg5Jt7PyDIdbhQj2kpZ7GoKBcZ+fbpS0Jf9MuY2Kuz9hMrBitqe+mCKvucH
         /SnDZXJVrBFYk7yrLy8qMv1usYt4i34HO5It1OwzpH5ETFcM2BtlFSb8+qx6T5besCg8
         KYscOrczL4wtkScWIeOiJLwQgyLU69Yaug3Sb8m4IfJtzZR4uaUUf0Hi2LbRZzSg7ozf
         8M8CWCHdL7HkxW1xRI2ekG/mFm3MEr8XqgF+GyxLlV/gcMiDHk5oU+epgnK2gS2f2mc3
         QUukZsiahjc7yhM3vryPEdD9XOUpKuasPV+Fh3kdPsYx4F/RVJ43mmUrzEf4ocu6IHj9
         9zLg==
X-Forwarded-Encrypted: i=1; AJvYcCWEZytAIR8dQb4Lan/7+ReDcuPuQnv91CQUW8TCQ9Y6ivhPW6vmdXt+dEQDWMwP/BwdIe4=@vger.kernel.org, AJvYcCWu5fkI7NLzdvaWivNcwREi3u+vAkKDbcxXxLffP++sdFkikx7R7u2dnK8xbAdwmN9C73YQ0V7UFp/y7vFi@vger.kernel.org, AJvYcCWwJQHOvlzdhGVjgUrp5EsQ6YLcqk7AkwrlVB7fUmzur7Y2HACVv/asHs8f9JgrWkvkCKpCF4fqOAvNunKA+gZbfVwx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tQ5p4pRZl71kHgImBxHqmrvL74itQENYM7jPDNyJ0a+eZDXm
	ctQmK6hzFMxxQX9aFeQs50Kh69v99VQuyav8odYQnnc8a+OqGYysq9BfLa6cRg==
X-Gm-Gg: ASbGncte94s52zeia7GHgjc7ApoKpOVosL6YUKi9wFjx6k8W0FmHRvbFzdN3VEKwJkS
	A2c7wAs9NDfwBlovuQfhvzJuQgk7B74z9/l37Q/I/6yfwrrWj6Ag5TngGP0PPnyahpsSjie17P1
	+oBXn/DVn4gtB4keFKxmD5HEFcFDClhQptRZBPgzTN7+rxZsqgoMGnt6qhZELxauCOMb57oItRi
	ARgV6hl1IPE4Dm1vkMtVETTtIweKN1HGyYLOzNtGfywcrXo96isdt2DUU9+XOP8STe3jH2f63KQ
	06GoSwcp8BlZMiRgIumEU5pC+jP+n4Ju5lDBPw+rJQfnGCyy86Tu2MQUvY1ct9xEwzKbTT/dvZS
	QRu1uNAb80h2rhTw2RRL9
X-Google-Smtp-Source: AGHT+IHv2tN3lf/+uVvnmsWct88OLvnhlFhSuRf3igKrUi9lHYG6i6bh9uTyL8+JAj4DoVKt9av5yA==
X-Received: by 2002:a17:906:7313:b0:ae3:5185:541a with SMTP id a640c23a62f3a-afe07c177acmr25088866b.54.1755725930517;
        Wed, 20 Aug 2025 14:38:50 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded47933dsm253096366b.65.2025.08.20.14.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:38:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Aug 2025 23:38:48 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>, rick.p.edgecombe@intel.com
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aKZAaE0ktR2_Ae9c@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
 <20250820123033.GL3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820123033.GL3245006@noisy.programming.kicks-ass.net>

On Wed, Aug 20, 2025 at 02:30:33PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 19, 2025 at 09:15:15PM +0200, Peter Zijlstra wrote:
> > On Sun, Jul 20, 2025 at 01:21:20PM +0200, Jiri Olsa wrote:
> 
> > > +void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +	uprobe_opcode_t insn[5];
> > > +
> > > +	/*
> > > +	 * Do not optimize if shadow stack is enabled, the return address hijack
> > > +	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
> > > +	 * the entry uprobe is optimized and the shadow stack crashes the app.
> > > +	 */
> > > +	if (shstk_is_enabled())
> > > +		return;
> > 
> > Kernel should be able to fix up userspace shadow stack just fine.
> > 
> > > +	if (!should_optimize(auprobe))
> > > +		return;
> > > +
> > > +	mmap_write_lock(mm);
> > > +
> > > +	/*
> > > +	 * Check if some other thread already optimized the uprobe for us,
> > > +	 * if it's the case just go away silently.
> > > +	 */
> > > +	if (copy_from_vaddr(mm, vaddr, &insn, 5))
> > > +		goto unlock;
> > > +	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
> > > +		goto unlock;
> > > +
> > > +	/*
> > > +	 * If we fail to optimize the uprobe we set the fail bit so the
> > > +	 * above should_optimize will fail from now on.
> > > +	 */
> > > +	if (__arch_uprobe_optimize(auprobe, mm, vaddr))
> > > +		set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags);
> > > +
> > > +unlock:
> > > +	mmap_write_unlock(mm);
> > > +}
> 
> Something a little like this should do I suppose...
> 
> --- a/arch/x86/include/asm/shstk.h
> +++ b/arch/x86/include/asm/shstk.h
> @@ -23,6 +23,8 @@ int setup_signal_shadow_stack(struct ksi
>  int restore_signal_shadow_stack(void);
>  int shstk_update_last_frame(unsigned long val);
>  bool shstk_is_enabled(void);
> +int shstk_pop(u64 *val);
> +int shstk_push(u64 val);
>  #else
>  static inline long shstk_prctl(struct task_struct *task, int option,
>  			       unsigned long arg2) { return -EINVAL; }
> @@ -35,6 +37,8 @@ static inline int setup_signal_shadow_st
>  static inline int restore_signal_shadow_stack(void) { return 0; }
>  static inline int shstk_update_last_frame(unsigned long val) { return 0; }
>  static inline bool shstk_is_enabled(void) { return false; }
> +static inline int shstk_pop(u64 *val) { return -ENOTSUPP; }
> +static inline int shstk_push(u64 val) { return -ENOTSUPP; }
>  #endif /* CONFIG_X86_USER_SHADOW_STACK */
>  
>  #endif /* __ASSEMBLER__ */
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -246,6 +246,46 @@ static unsigned long get_user_shstk_addr
>  	return ssp;
>  }
>  
> +int shstk_pop(u64 *val)
> +{
> +	int ret = 0;
> +	u64 ssp;
> +
> +	if (!features_enabled(ARCH_SHSTK_SHSTK))
> +		return -ENOTSUPP;
> +
> +	fpregs_lock_and_load();
> +
> +	rdmsrq(MSR_IA32_PL3_SSP, ssp);
> +	if (val && get_user(*val, (__user u64 *)ssp))
> +	    ret = -EFAULT;
> +	ssp += SS_FRAME_SIZE;
> +	wrmsrq(MSR_IA32_PL3_SSP, ssp);
> +
> +	fpregs_unlock();
> +
> +	return ret;
> +}
> +
> +int shstk_push(u64 val)
> +{
> +	u64 ssp;
> +	int ret;
> +
> +	if (!features_enabled(ARCH_SHSTK_SHSTK))
> +		return -ENOTSUPP;
> +
> +	fpregs_lock_and_load();
> +
> +	rdmsrq(MSR_IA32_PL3_SSP, ssp);
> +	ssp -= SS_FRAME_SIZE;
> +	wrmsrq(MSR_IA32_PL3_SSP, ssp);
> +	ret = write_user_shstk_64((__user void *)ssp, val);
> +	fpregs_unlock();
> +
> +	return ret;
> +}
> +
>  #define SHSTK_DATA_BIT BIT(63)
>  
>  static int put_shstk_data(u64 __user *addr, u64 data)
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -804,7 +804,7 @@ SYSCALL_DEFINE0(uprobe)
>  {
>  	struct pt_regs *regs = task_pt_regs(current);
>  	struct uprobe_syscall_args args;
> -	unsigned long ip, sp;
> +	unsigned long ip, sp, sret;
>  	int err;
>  
>  	/* Allow execution only from uprobe trampolines. */
> @@ -831,6 +831,9 @@ SYSCALL_DEFINE0(uprobe)
>  
>  	sp = regs->sp;
>  
> +	if (shstk_pop(&sret) == 0 && sret != args.retaddr)
> +		goto sigill;
> +
>  	handle_syscall_uprobe(regs, regs->ip);
>  
>  	/*
> @@ -855,6 +858,9 @@ SYSCALL_DEFINE0(uprobe)
>  	if (args.retaddr - 5 != regs->ip)
>  		args.retaddr = regs->ip;
>  
> +	if (shstk_push(args.retaddr) == -EFAULT)
> +		goto sigill;
> +
>  	regs->ip = ip;
>  
>  	err = copy_to_user((void __user *)regs->sp, &args, sizeof(args));
> @@ -1124,14 +1130,6 @@ void arch_uprobe_optimize(struct arch_up
>  	struct mm_struct *mm = current->mm;
>  	uprobe_opcode_t insn[5];
>  
> -	/*
> -	 * Do not optimize if shadow stack is enabled, the return address hijack
> -	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
> -	 * the entry uprobe is optimized and the shadow stack crashes the app.
> -	 */
> -	if (shstk_is_enabled())
> -		return;
> -

nice, we will need to adjust selftests for that, there's shadow stack part
in prog_tests/uprobe_syscall.c that expects non optimized uprobe after enabling
shadow stack.. I'll run it and send the change

thanks,
jirka

