Return-Path: <bpf+bounces-79478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B29FD3B612
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EA3D302C861
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0E38E5EA;
	Mon, 19 Jan 2026 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWsXrW1G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FB38B9AF;
	Mon, 19 Jan 2026 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848294; cv=none; b=qz8YMHeZiQwpLiPolaOa8w8QaokhiUAkuTCzYZMuQO6/v/mPYjCnK6cJHeDEuXoiV4tm3OztIzOlgfs7tb7w9NGZ0Ov8RsfvqKBUXrssatp9oJNmjsaUt8yAwW+dYrW+QZibG3A/o4kRIP159VJR17KibPknw5iSmoxpkUT0vVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848294; c=relaxed/simple;
	bh=7+qcIN3pStM1p5Kmh6umxaTJlgxXnlEyJuEVfeiEGCI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CHcGl9r8f2GMqpYNZOhy77IMDyH9pIIqkLpjLJ11TiW/JmLsi3FXIyfst9WxSuckwJKUYViv+1Mo0WSHr8sosxKIcJqZR1CgvD/zc/I7WKKWBQY8HRgFCaIRRUqBBQutb3up/gHkm65LkWCT863lM2ikoVo1XvoIHCoDszE3XN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWsXrW1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38662C116C6;
	Mon, 19 Jan 2026 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848293;
	bh=7+qcIN3pStM1p5Kmh6umxaTJlgxXnlEyJuEVfeiEGCI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XWsXrW1Ga6f8BkmJip2yofi1RID/M3W8y+zw193F9Hm0AkrQ+5Hq1SNWmPmofA757
	 ptIyZVs2BuvvL/95n3xk9g/NsujnB9eN7cReMFIMXT8C8H37sSnkwYwIpH2oCFtPn4
	 bXZryl7LjEYXtPkX27kwm+s/KPXqvcpPhvRmRGoiCiWgZiuUSdi9B+H/sCek/IXbmi
	 zRwTNeKmnALLl/i4498XqQH3na2PmdXeTS9sp94dQikpqo9DlI3TTE5BPCLbKdYfXu
	 EihZ4L6NqBtWNHIIdgRSGJZPjonK1zufFhXQaKGJOCciRCe/tznIddQlgGKx/tK1HK
	 Pnb1Gp1SQxEWw==
Content-Type: multipart/mixed; boundary="===============6140367530953031628=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c83188087c6d6409524b80b2078285813ccfea8e42ea82e88542e6e8d5e5f73d@mail.kernel.org>
In-Reply-To: <20260119023732.130642-2-dongml2@chinatelecom.cn>
References: <20260119023732.130642-2-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mattbobrowski@google.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:44:53 +0000 (UTC)

--===============6140367530953031628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f73e08c223b5..64976009ba3c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	case BPF_FUNC_d_path:
>  		return &bpf_d_path_proto;
>  	case BPF_FUNC_get_func_arg:
> -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
> +		return &bpf_get_func_arg_proto;

Removing the bpf_prog_has_trampoline() check here allows all TRACING
program types to use bpf_get_func_arg(), not just RAW_TP and trampoline-
based types. In particular, BPF_TRACE_ITER programs can now use this
helper.

However, looking at do_misc_fixups() in verifier.c, the inline code
generation only handles BPF_TRACE_RAW_TP specially. For other non-
trampoline types like BPF_TRACE_ITER, the else branch generates:

    BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8)

This loads nr_args from ctx-8, but ITER programs use a different context
layout (e.g. struct bpf_iter__bpf_map_elem with meta, map, key, value
pointers). There is no nr_args at ctx-8 for ITER programs.

Would this cause ITER programs using bpf_get_func_arg() to read arbitrary
memory at ctx-8, potentially leaking kernel data or causing incorrect
bounds checks for subsequent argument access?

>  	case BPF_FUNC_get_func_ret:
>  		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
>  	case BPF_FUNC_get_func_arg_cnt:
> -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
> +		return &bpf_get_func_arg_cnt_proto;

Same question applies here for bpf_get_func_arg_cnt() with ITER programs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9de0ec0c3ed9..0b281b7c41eb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23323,8 +23323,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		/* Implement bpf_get_func_arg inline. */
>  		if (prog_type == BPF_PROG_TYPE_TRACING &&
>  		    insn->imm == BPF_FUNC_get_func_arg) {
> +			if (eatype == BPF_TRACE_RAW_TP) {
> +				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
> +
> +				/*
> +				 * skip first 'void *__data' argument in btf_trace_##name
> +				 * typedef
> +				 */
> +				nr_args--;
> +				/* Save nr_args to reg0 */
> +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> +			} else {
> +				/* Load nr_args from ctx - 8 */
> +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			}

This else branch now applies to BPF_TRACE_ITER as well, since the
trampoline check was removed in tracing_prog_func_proto(). Should the
condition be extended to also handle ITER, or should ITER be explicitly
blocked from using these helpers?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147849826

--===============6140367530953031628==--

