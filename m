Return-Path: <bpf+bounces-79181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BCD2B48A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 05:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDB8D3016DEB
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 04:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41793342CA7;
	Fri, 16 Jan 2026 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1m/Oz/H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE11EA65;
	Fri, 16 Jan 2026 04:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768537220; cv=none; b=nvHo1350NEZfuFWx0ofDNLZIS30b5L+V7CVZFVNhCT/cwFTC9ekMnGyx0bZkU/j0tU2+zjTV9KPsm7bor9G/DNn2lnhUjqDNeBgiXpRBN9HPbfsQKzJhX55X2yUWOwJobIfYVneBlE9ZMIttJN3opTpGdiqVU7BM+1w4rMenfSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768537220; c=relaxed/simple;
	bh=GrzRKedk/PtC+lBV9iy9CF6AJ0GM3vGl7nMOo0Bx134=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q8Q/THve31DskxjPs52/d1HUuCpftqNnEaqohjVaxf0aIGlbRgCpm1xyDipUcxFxc/AapYkjNIy+se6QD1RhW1zVN/QYiG3g5V5nDOHDDfrDj6KewL3u55OeAXgPy0FMxDmkuFwnWoezHJ686hNMfhmfh+iFEE/uQl4PKJzuxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1m/Oz/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C4FC116C6;
	Fri, 16 Jan 2026 04:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768537220;
	bh=GrzRKedk/PtC+lBV9iy9CF6AJ0GM3vGl7nMOo0Bx134=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=q1m/Oz/HQ/wtRor3RtOoGofa39Z2EJ9fX87K7G99Xg78My/ZG7ZorF9M7h4NCh+2g
	 XobV8ITV7f1QPE+x/7kE3A2jZjeOdTsZZClyqd1Wr381NV9lFrIe43ZwRHJNo0vaCy
	 iZn2fWRtKBKbxmSlwtK3DPekPznluhsAw/4Cddrbg0ntO8ZnRas2oHqVKZsXuUHWYe
	 6pA3g5pYjjCKVbBmbe6RujK8f7hvDei43c//CoxUGvFXmw+grajM6S6ihvQp5yRfNR
	 XEtAke4ZEcm6ektLRW/d9c5G/A3YCgjtKT1u4nNpI8kTV4neKrZa7Kvkv6Y2ZT13f7
	 bJwJW/QY02AaQ==
Content-Type: multipart/mixed; boundary="===============2352824339848731724=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf8e99a4398ad6c1383a82fd33fa1e0cfdfc6b935c8d4d8f5216a64cafccb660@mail.kernel.org>
In-Reply-To: <20260116035024.98214-2-dongml2@chinatelecom.cn>
References: <20260116035024.98214-2-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mattbobrowski@google.com,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 16 Jan 2026 04:20:19 +0000 (UTC)

--===============2352824339848731724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7a375f608263..223e5b483bbd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23321,8 +23321,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		/* Implement bpf_get_func_arg inline. */
>  		if (prog_type == BPF_PROG_TYPE_TRACING &&
>  		    insn->imm == BPF_FUNC_get_func_arg) {
> +			if (eatype == BPF_TRACE_RAW_TP) {
> +				int nr_args;
> +
> +				if (!prog->aux->attach_func_proto)
> +					return -EINVAL;
> +				nr_args = btf_type_vlen(prog->aux->attach_func_proto);
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The attach_func_proto for raw tracepoints points to the BTF func_proto of
__bpf_trace_* or btf_trace_* which has an extra "void *__data" as the
first parameter. For example, a tracepoint declared with TP_PROTO(int a)
results in a btf_trace_* typedef of "void (*)(void *__data, int a)" which
has 2 parameters.

Does btf_type_vlen() return the count including the hidden __data param?
If so, a tracepoint with 1 actual argument would report nr_args=2, but
the BPF context only contains 1 argument. Calling bpf_get_func_arg(ctx, 1)
would pass the bounds check (1 < 2) but read out of bounds from ctx.

The bpf_trace_run* functions populate args[] with only the actual
tracepoint arguments (see __bpf_trace_run() in kernel/trace/bpf_trace.c),
not including __data. Should nr_args be adjusted by subtracting 1 to
account for the hidden first parameter?

> +				/* Save nr_args to reg0 */
> +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> +			} else {
> +				/* Load nr_args from ctx - 8 */
> +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			}

[ ... ]

> @@ -23374,8 +23384,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		/* Implement get_func_arg_cnt inline. */
>  		if (prog_type == BPF_PROG_TYPE_TRACING &&
>  		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
> +			if (eatype == BPF_TRACE_RAW_TP) {
> +				int nr_args;
> +
> +				if (!prog->aux->attach_func_proto)
> +					return -EINVAL;
> +				nr_args = btf_type_vlen(prog->aux->attach_func_proto);
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Same question here for bpf_get_func_arg_cnt() - should this subtract 1 to
exclude the __data parameter from the count returned to BPF programs?

> +				/* Save nr_args to reg0 */
> +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21055137351

--===============2352824339848731724==--

