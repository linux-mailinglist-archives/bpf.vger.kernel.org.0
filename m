Return-Path: <bpf+bounces-31696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBAE901A30
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 07:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B20281439
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 05:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D2ADDB8;
	Mon, 10 Jun 2024 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="upNTFVPJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66416A935
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 05:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717997176; cv=none; b=OJBXg0uGJ9IrlcY4H9iBP7RSCRQXmHeptbXTrgwHdqVb9uQlo5cvctW6bvMmdHeoPlY2Wsazg8KCsZfKdG1oo/5YRdtV7WhoraNpoYlzpHP14lgmLfMFs4uYRhhlXkSZpkT2VWNAm7nRLcwme+zH7891hTAfO5vphAomzI4XfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717997176; c=relaxed/simple;
	bh=6zuX/V8RLgMFnOt5VSB5bnff6Z2ic+zlgxbmWKHTFCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrYHIcBAmGOGpm28l6t4dyd383bme4quh0v/vvbSDuU1+rknKi+FTYCb1CUEq9/8+wuNJboZyFhZUyizXqpPy22+QqMdasCCqtOR7r5XBM48t/WFPhNVdgQmurQ1ICAi1ZHz4mvYDKNTyjQ10ieyVteOTpgmsBw8lGSoElL/hy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=upNTFVPJ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hffilwlqm@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717997171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=As73JymwY74P2zIpJZsw9dlM/B1K3ri5lWLEiUur7wE=;
	b=upNTFVPJncwWAZukdHqnxELgEktHoM/CaQM9dd9QECd/ZazU+ZUEHc9vOvtwfDO5wo0Hug
	W1D7v/h8qoZiTmLcPrshux2YMdhJuVno44cjfurgXE6ccKwHL3Vbi3JPVnvlcp/OdehcNf
	kD/Kvm0DgAEcs/uuyyQQMVNMk09QK/E=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-patches-bot@fb.com
Message-ID: <37e6a405-9a8f-4406-9238-b22c4a8b5e6c@linux.dev>
Date: Sun, 9 Jun 2024 22:26:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, verifier: Correct tail_call_reachable for
 bpf prog
Content-Language: en-GB
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, kernel-patches-bot@fb.com
References: <20240609073100.42925-1-hffilwlqm@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240609073100.42925-1-hffilwlqm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/9/24 12:31 AM, Leon Hwang wrote:
> It's confusing to inspect 'prog->aux->tail_call_reachable' with drgn[0],
> when bpf prog has tail call but 'tail_call_reachable' is false.
>
> This patch corrects 'tail_call_reachable' when bpf prog has tail call.
>
> [0] https://github.com/osandov/drgn
>
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>   kernel/bpf/verifier.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 81a3d2ced78d5..d7045676246a7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2982,8 +2982,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
>   
>   		if (code == (BPF_JMP | BPF_CALL) &&
>   		    insn[i].src_reg == 0 &&
> -		    insn[i].imm == BPF_FUNC_tail_call)
> +		    insn[i].imm == BPF_FUNC_tail_call) {
>   			subprog[cur_subprog].has_tail_call = true;
> +			subprog[cur_subprog].tail_call_reachable = true;

This tail_call_reachable is handled in jit. For example, in arch/x86/net/bpf_jit_comp.c:

static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
                              bool *regs_used, bool *tail_call_seen)
{
         int i;

         for (i = 1; i <= insn_cnt; i++, insn++) {
                 if (insn->code == (BPF_JMP | BPF_TAIL_CALL))
                         *tail_call_seen = true;
                 if (insn->dst_reg == BPF_REG_6 || insn->src_reg == BPF_REG_6)
                         regs_used[0] = true;
                 if (insn->dst_reg == BPF_REG_7 || insn->src_reg == BPF_REG_7)
                         regs_used[1] = true;
                 if (insn->dst_reg == BPF_REG_8 || insn->src_reg == BPF_REG_8)
                         regs_used[2] = true;
                 if (insn->dst_reg == BPF_REG_9 || insn->src_reg == BPF_REG_9)
                         regs_used[3] = true;
         }
}

and

         detect_reg_usage(insn, insn_cnt, callee_regs_used,
                          &tail_call_seen);
         
         /* tail call's presence in current prog implies it is reachable */
         tail_call_reachable |= tail_call_seen;

I didn't check other architectures. If other arch is similar to x86 w.r.t.
tail_call_reachable marking, your change looks good. But you should also
make changes in jit to remove those redundent checking.

> +		}
>   		if (BPF_CLASS(code) == BPF_LD &&
>   		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
>   			subprog[cur_subprog].has_ld_abs = true;
>
> base-commit: 2c6987105026a4395935a3db665c54eb1bafe782

