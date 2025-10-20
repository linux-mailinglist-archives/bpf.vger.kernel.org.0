Return-Path: <bpf+bounces-71363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC4FBEFF43
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B131189E49C
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE89A2EC08D;
	Mon, 20 Oct 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mQb2+yga"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6F2E8DF0;
	Mon, 20 Oct 2025 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949040; cv=none; b=CcgOp/0fiy/Uz/E1Qs7A36F5imtV9ZpYsUtYS4+HS2TzNkLxj3y0iUHmx1fbjRgTdZwX3FnQ/0FgQkW0I8JbGcf9S9PObTIzzSJjwHN9B7QRYCfnLt0WkhKkXusMZZRmNvQAmWSB5n87PGIiZF1zSsvPEUWBE74LorHKPN8HBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949040; c=relaxed/simple;
	bh=g7YCL1sUbPStqVMJN6jT9eisK1CkwlQ2HT0ruBv8c+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ji0XpoyPJS8JeM/XO4u+JnEHsGovVl5i7OL4oMPISZ6XGlr28uuKc5AHSxSrJfe/TsBGAJiOOrVKbvf2YSTFTJDqwtfDwCeGd0pDvCU/R77Iw0s/qcdmZ+GMtjaf/rfHF8tdcaezZN0FYbCXeWhnqQCGOJdNZmC+0ZtZPMexwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mQb2+yga; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760949035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcnuuSTRqUyp29uKa5CEvOOKmfXQMRjJKflnfGm6FKw=;
	b=mQb2+ygaH3snZXltYV1LxueQejv/s5F6IrIAuUWjTtDa9ftAfNeaQmEmZd72d20dP5aaEu
	wIM8vtGMyVVJ3iLQyBlfdQ0M3AIEV0RvNRctkqbpUBMxbWItav21ySgMD63K/IW6DgsTH4
	+aeEdo03S46TPqOSG6N4JHitTCN1XIU=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC bpf-next 2/5] bpf: add kfunc bpf_tracing_is_exit for
 TRACE_SESSION
Date: Mon, 20 Oct 2025 16:30:12 +0800
Message-ID: <12766136.O9o76ZdvQC@7950hx>
In-Reply-To: <aPXwfxRvSk63FOxU@krava>
References:
 <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-3-dongml2@chinatelecom.cn> <aPXwfxRvSk63FOxU@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/20 16:19, Jiri Olsa wrote:
> On Sat, Oct 18, 2025 at 10:21:21PM +0800, Menglong Dong wrote:
> > If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
> > trampoline to store the flags that we needed, and the 8-bytes lie before
> > the function argument count, which means ctx[-2]. And we will store the
> > flag "is_exit" to the first bit of it.
> > 
> > Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
> > is fexit currently.
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  kernel/bpf/verifier.c    |  5 ++++-
> >  kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 44 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 40e3274e8bc2..a1db11818d01 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12284,6 +12284,7 @@ enum special_kfunc_type {
> >  	KF___bpf_trap,
> >  	KF_bpf_task_work_schedule_signal,
> >  	KF_bpf_task_work_schedule_resume,
> > +	KF_bpf_tracing_is_exit,
> >  };
> >  
> >  BTF_ID_LIST(special_kfunc_list)
> > @@ -12356,6 +12357,7 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
> >  BTF_ID(func, __bpf_trap)
> >  BTF_ID(func, bpf_task_work_schedule_signal)
> >  BTF_ID(func, bpf_task_work_schedule_resume)
> > +BTF_ID(func, bpf_tracing_is_exit)
> >  
> >  static bool is_task_work_add_kfunc(u32 func_id)
> >  {
> > @@ -12410,7 +12412,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
> >  	struct bpf_reg_state *reg = &regs[regno];
> >  	bool arg_mem_size = false;
> >  
> > -	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
> > +	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
> > +	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit])
> >  		return KF_ARG_PTR_TO_CTX;
> >  
> >  	/* In this function, we verify the kfunc's BTF as per the argument type,
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 4f87c16d915a..6dde48b9d27f 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3356,12 +3356,49 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
> >  	.filter = bpf_kprobe_multi_filter,
> >  };
> >  
> > -static int __init bpf_kprobe_multi_kfuncs_init(void)
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
> > +{
> > +	/* ctx[-2] is the session flags, and the last bit is is_exit */
> > +	return ((u64 *)ctx)[-2] & 1;
> > +}
> 
> I think this could be inlined by verifier

Yeah, that make sense. I'll inline it in the next version.

Thanks!
Menglong Dong

> 
> jirka
> 
> 
> > +
> > +__bpf_kfunc_end_defs();
> 
> SNIP
> 
> 





