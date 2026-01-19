Return-Path: <bpf+bounces-79421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4CD39E30
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 07:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B43493016B95
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 06:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCE826CE25;
	Mon, 19 Jan 2026 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jnzMs6hH"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52925F797;
	Mon, 19 Jan 2026 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768802411; cv=none; b=Yar9V1WO0vZ2EXtzz3l7brgkCkap7zlXu695JEiU4gj/IMVWDpUMtPBGwfKbk/F2Vt1Kp2hup/D4ZrX2Mo439VRiegu2qtqdHkDFJgXGlb2z/WElz9byMa+J0NyHTDaY0WFbu5JqrW6kTqj2cTwGXBGNFs1rhUdRGds/TTUzAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768802411; c=relaxed/simple;
	bh=j/vF8hNjPDjHaC/QNctJECkdd1RqKykTiJz2QSliPO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iisrmF5wdRPK9agAdYsxeghDywW23DJQZg7yW0GHnIL2n6ZD3lpNf9PjKzW8WkJtr/hXGh5xPK4fe30+5LYUZGkML0m8WPHTIx9A7H+F8hh/aJdaFY0Y/WdR5z7O7k5Yv+PtkpjgGxL1mPS3DUf/Ynfy/1VjrKUWmbN5Gfwrfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jnzMs6hH; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768802397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XQANzAXpyoPhO9UGId1UIScWwWHg0JLuBcFpQLkopQ=;
	b=jnzMs6hHmh2KoZktLNdqVHUt3hnHtJPFAVljdZVM751sT4ugi1BMSn2EVri6ji+SJ7XTwF
	mMjBXK5CfiHfB40czCnhppVj+80shADKmM67pNx3muBuU7zwPuqsqVIk+yWZT7tJhQi8Z3
	o8SrkgRmo1GtHUwnUqZ+CP5X5lJ+QNM=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
 jolsa@kernel.org, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v3 1/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
Date: Mon, 19 Jan 2026 13:59:41 +0800
Message-ID: <5957968.DvuYhMxLoT@7940hx>
In-Reply-To: <53c55a34-5b24-4481-91fe-290dc1b2d2e8@linux.dev>
References:
 <20260119023732.130642-1-dongml2@chinatelecom.cn>
 <20260119023732.130642-2-dongml2@chinatelecom.cn>
 <53c55a34-5b24-4481-91fe-290dc1b2d2e8@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/19 13:11 Yonghong Song <yonghong.song@linux.dev> write:
> 
> On 1/18/26 6:37 PM, Menglong Dong wrote:
> > For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported by
> > the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> > tracepoint, especially for the case that the position of the arguments in
> > a tracepoint can change.
> >
> > The target tracepoint BTF type id is specified during loading time,
> > therefore we can get the function argument count from the function
> > prototype instead of the stack.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v3:
> > - remove unnecessary NULL checking for prog->aux->attach_func_proto
> >
> > v2:
> > - for nr_args, skip first 'void *__data' argument in btf_trace_##name
> >    typedef
> > ---
> >   kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
> >   kernel/trace/bpf_trace.c |  4 ++--
> >   2 files changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index faa1ecc1fe9d..4f52342573f0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23316,8 +23316,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >   		/* Implement bpf_get_func_arg inline. */
> >   		if (prog_type == BPF_PROG_TYPE_TRACING &&
> >   		    insn->imm == BPF_FUNC_get_func_arg) {
> > -			/* Load nr_args from ctx - 8 */
> > -			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +			if (eatype == BPF_TRACE_RAW_TP) {
> > +				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
> > +
> > +				/*
> > +				 * skip first 'void *__data' argument in btf_trace_##name
> > +				 * typedef
> > +				 */
> > +				nr_args--;
> > +				/* Save nr_args to reg0 */
> > +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> > +			} else {
> > +				/* Load nr_args from ctx - 8 */
> > +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +			}
> >   			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
> >   			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
> >   			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
> > @@ -23369,8 +23381,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >   		/* Implement get_func_arg_cnt inline. */
> >   		if (prog_type == BPF_PROG_TYPE_TRACING &&
> >   		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
> > -			/* Load nr_args from ctx - 8 */
> > -			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +			if (eatype == BPF_TRACE_RAW_TP) {
> > +				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
> > +
> > +				/*
> > +				 * skip first 'void *__data' argument in btf_trace_##name
> > +				 * typedef
> > +				 */
> > +				nr_args--;
> > +				/* Save nr_args to reg0 */
> > +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> > +			} else {
> > +				/* Load nr_args from ctx - 8 */
> > +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +			}
> >   
> >   			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
> >   			if (!new_prog)
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 6e076485bf70..9b1b56851d26 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >   	case BPF_FUNC_d_path:
> >   		return &bpf_d_path_proto;
> >   	case BPF_FUNC_get_func_arg:
> > -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
> > +		return &bpf_get_func_arg_proto;
> 
> BPF_TRACE_ITER is a tracing attach type. It should not support bpf_get_func_arg() or
> bpf_get_func_arg_cnt().

Ah, my bad, I forgot BPF_TRACE_ITER. I'll fix it in the next version.

Thanks!
Menglong Dong

> 
> >   	case BPF_FUNC_get_func_ret:
> >   		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
> >   	case BPF_FUNC_get_func_arg_cnt:
> > -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
> > +		return &bpf_get_func_arg_cnt_proto;
> >   	case BPF_FUNC_get_attach_cookie:
> >   		if (prog->type == BPF_PROG_TYPE_TRACING &&
> >   		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
> 
> 
> 





