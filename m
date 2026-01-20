Return-Path: <bpf+bounces-79527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC6D3BCFA
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34082300EE8D
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4C5253950;
	Tue, 20 Jan 2026 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bbQhLXaT"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C72494D8
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872978; cv=none; b=UV+ck2PRbHEas6nr6F7Huw8gFD1d24X74HzNIZKQazgZK3+iw56zKenetj+EvEhGpKDpjxWRWJjJsT2+f6DSXwUxBEu9vKGH/V9O2Kw38waaQB0hqBEz3IjAZfKd6tCezp2TgfhJfTiTWLuyzNYLncC2phOTsaEGynOZkiZh5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872978; c=relaxed/simple;
	bh=m27cUdkImg9cRRRd/ba4c7B43nnuHRaHjATslo0bgY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAYPBpp79iKYv4hIfUSmoh4cLeS8T3+gbJ84Ykb52mB6mMtPR6sp25NC250ya9bm5gd1W+j45tOg29FS9ZllQ6OFon1pvNns2g4l9imxFEINBIuIpCp615zcPHhax3lKm9OixDdoJgoTIOzsFLqTGvTPSXhhhydkOG60YpYaARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bbQhLXaT; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768872974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLPTqvfY+TgOMYl4l7Dh455o6dJuYXschwtVS9naGhE=;
	b=bbQhLXaTJ7Iz4netSqf6gyxgROLGQ0a1V2jB8QJn6k1y43bUvoyJnpjsYwOajM7g6ntl1p
	kuIVziEKXWhcxdBD1t/Y09lfygSLOlVEM3H3BhGNI5Nj3Fpwou7qgddo1Fyhkpe77wLg74
	k1MyoZyRLbsyppYQHNR7/3oXEYQSDsI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v3 1/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
Date: Tue, 20 Jan 2026 09:24:46 +0800
Message-ID: <6099572.DvuYhMxLoT@7950hx>
In-Reply-To: <aW7APKlKCgg2_YvW@krava>
References:
 <20260119023732.130642-1-dongml2@chinatelecom.cn>
 <20260119023732.130642-2-dongml2@chinatelecom.cn> <aW7APKlKCgg2_YvW@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/20 07:37, Jiri Olsa wrote:
> On Mon, Jan 19, 2026 at 10:37:31AM +0800, Menglong Dong wrote:
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
> >   typedef
> > ---
> >  kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
> >  kernel/trace/bpf_trace.c |  4 ++--
> >  2 files changed, 30 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index faa1ecc1fe9d..4f52342573f0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23316,8 +23316,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >  		/* Implement bpf_get_func_arg inline. */
> >  		if (prog_type == BPF_PROG_TYPE_TRACING &&
> >  		    insn->imm == BPF_FUNC_get_func_arg) {
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
> >  			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
> >  			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
> >  			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
> > @@ -23369,8 +23381,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >  		/* Implement get_func_arg_cnt inline. */
> >  		if (prog_type == BPF_PROG_TYPE_TRACING &&
> >  		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
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
> 
> I think we can attach single bpf program to multiple rawtp tracepoints,
> in which case this would not work properly for such program links on
> tracepoints with different nr_args, right?

Hi, Jiri. As for now, I think we can't do that when I look into
bpf_raw_tp_link_attach(). For the BPF_TRACE_RAW_TP, we specify
a target btf type id when loading the bpf prog. And during
attaching, it seems that we can only attach to that target, which
means that we can't attach to multiple rawtp tracepoint. And
we can't change the target btf id when reattach, too. Right?

Part of the implement of bpf_raw_tp_link_attach():

static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
				  const char __user *user_tp_name, u64 cookie,
				  enum bpf_attach_type attach_type)
{
	struct bpf_link_primer link_primer;
	struct bpf_raw_tp_link *link;
	struct bpf_raw_event_map *btp;
	const char *tp_name;
	char buf[128];
	int err;

	switch (prog->type) {
	case BPF_PROG_TYPE_TRACING:
	case BPF_PROG_TYPE_EXT:
	case BPF_PROG_TYPE_LSM:
		if (user_tp_name)
			/* The attach point for this category of programs
			 * should be specified via btf_id during program load.
			 */
			return -EINVAL;
		if (prog->type == BPF_PROG_TYPE_TRACING &&
		    prog->expected_attach_type == BPF_TRACE_RAW_TP) {
			tp_name = prog->aux->attach_func_name;
			break;
		}
                       [......]
                       }
[......]
}

Thanks!
Menglong Dong

> 
> jirka
> 
> 
> > +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> > +			} else {
> > +				/* Load nr_args from ctx - 8 */
> > +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +			}
> >  
> >  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
> >  			if (!new_prog)
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 6e076485bf70..9b1b56851d26 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  	case BPF_FUNC_d_path:
> >  		return &bpf_d_path_proto;
> >  	case BPF_FUNC_get_func_arg:
> > -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
> > +		return &bpf_get_func_arg_proto;
> >  	case BPF_FUNC_get_func_ret:
> >  		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
> >  	case BPF_FUNC_get_func_arg_cnt:
> > -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
> > +		return &bpf_get_func_arg_cnt_proto;
> >  	case BPF_FUNC_get_attach_cookie:
> >  		if (prog->type == BPF_PROG_TYPE_TRACING &&
> >  		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
> 
> 





