Return-Path: <bpf+bounces-79548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E91D8D3BDF7
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 04:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CB014E582D
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 03:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9765F3314A4;
	Tue, 20 Jan 2026 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKUK6QBn"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF18331222
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768880266; cv=none; b=CWFYpFUUq+Q+zbs2ycBg9sJmIoo+gMARfgzv6f1LobdoxmEwATL3tSNVHWJK9JFyQdDy22k5QUmho4WtzgZZ5+IckELrp44hKQ/5xCgEVFGPl8nhyQ6I8CbAQq5dFH0REAcGBXPt7dQRtlljk+f2BzfMfmyFrNpBdnbDbLnIwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768880266; c=relaxed/simple;
	bh=oVfpMv215nFVlCyqVOAEsiwuEnayAo6kct65sZY0bVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnin2zBDA9xaya5fYBIGxCn4jn59NdSGMub+8wWoNhBLNpdaVVVfJtnqMx6YkU5ktixNEX9jtkAEIL8eeWolzSra2wLZtRA8Wwz0aAk82tKynLLfk30bek2eKOBiTh2aDkXLx0WJcb0QNa3OOLueBudFRmbi5ACakA0OG7FoFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cKUK6QBn; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768880261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1K2ecHWtAyNI8GOayMKvK7FUh2cGuRh0U/BL+EvV5E=;
	b=cKUK6QBnY2uz9T6owUj2WMbFjKHb7dh0glg/MA+2n6JjrmkRYBEghIx9tjIw642HA9X3SU
	AdxcYncU+hyE7B8jOfwy4sXzs3MIKo/IGRaH1Jn3K8mPAGrCGUVNwFtWPEUgAmPE/aWzKg
	IEtoDXl2ojX/8B6Klx+YK8iqJ+5b/mw=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, andrii@kernel.org, ast@kernel.org,
 bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v3 1/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
Date: Tue, 20 Jan 2026 11:37:25 +0800
Message-ID: <2814392.mvXUDI8C0e@7950hx>
In-Reply-To:
 <c83188087c6d6409524b80b2078285813ccfea8e42ea82e88542e6e8d5e5f73d@mail.kernel.org>
References:
 <20260119023732.130642-2-dongml2@chinatelecom.cn>
 <c83188087c6d6409524b80b2078285813ccfea8e42ea82e88542e6e8d5e5f73d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/20 02:44, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index f73e08c223b5..64976009ba3c 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  	case BPF_FUNC_d_path:
> >  		return &bpf_d_path_proto;
> >  	case BPF_FUNC_get_func_arg:
> > -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
> > +		return &bpf_get_func_arg_proto;
> 
> Removing the bpf_prog_has_trampoline() check here allows all TRACING
> program types to use bpf_get_func_arg(), not just RAW_TP and trampoline-
> based types. In particular, BPF_TRACE_ITER programs can now use this
> helper.
> 
> However, looking at do_misc_fixups() in verifier.c, the inline code
> generation only handles BPF_TRACE_RAW_TP specially. For other non-
> trampoline types like BPF_TRACE_ITER, the else branch generates:
> 
>     BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8)
> 
> This loads nr_args from ctx-8, but ITER programs use a different context
> layout (e.g. struct bpf_iter__bpf_map_elem with meta, map, key, value
> pointers). There is no nr_args at ctx-8 for ITER programs.
> 
> Would this cause ITER programs using bpf_get_func_arg() to read arbitrary
> memory at ctx-8, potentially leaking kernel data or causing incorrect
> bounds checks for subsequent argument access?

You are right. As Yonghong said, I missed the bpf_iter case, and it should
be skipped.

I'll fix it in the next version.

> 
> >  	case BPF_FUNC_get_func_ret:
> >  		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
> >  	case BPF_FUNC_get_func_arg_cnt:
> > -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
> > +		return &bpf_get_func_arg_cnt_proto;
> 
> Same question applies here for bpf_get_func_arg_cnt() with ITER programs.
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9de0ec0c3ed9..0b281b7c41eb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23323,8 +23323,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >  		/* Implement bpf_get_func_arg inline. */
> >  		if (prog_type == BPF_PROG_TYPE_TRACING &&
> >  		    insn->imm == BPF_FUNC_get_func_arg) {
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
> 
> This else branch now applies to BPF_TRACE_ITER as well, since the
> trampoline check was removed in tracing_prog_func_proto(). Should the
> condition be extended to also handle ITER, or should ITER be explicitly
> blocked from using these helpers?
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147849826
> 





