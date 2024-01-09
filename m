Return-Path: <bpf+bounces-19269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AAD828B33
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 18:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9995E282FF1
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7CA3B297;
	Tue,  9 Jan 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q9kujKB3"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368938DC7
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5c37e7b-0e6a-4892-82d0-1a0d4d4db1ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704821219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2l7mCo0RdOHm+zeAnels6JMKGXAJjPtm22/2Nhv1jpk=;
	b=Q9kujKB3CbAiLqBPYGLPqelxmv7M4Vd+MiS1wPNZbKUWNsER9Wy13JI5z2mTWjmD1/eBct
	Xn6yVuvecPNjAhGINfTUATcYhNwyOUMPnsXi5ew8aSN22vTtWgoQ/o3KxZfU4EJV9MrolM
	TKOhmi845lvOLk4uohOMsNRyE1d0qGg=
Date: Tue, 9 Jan 2024 09:26:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: infer packet range for 'if pkt ==/!=
 pkt_end' comparisons
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, zenczykowski@gmail.com
References: <20240108132802.6103-1-eddyz87@gmail.com>
 <20240108132802.6103-3-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240108132802.6103-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/8/24 5:28 AM, Eduard Zingerman wrote:
> Extend try_match_pkt_pointers() to handle == and != operations.
> For instruction:
>
>        .--------------- pointer to packet with some range R
>        |     .--------- pointer to packet end
>        v     v
>    if rA == rB goto ...
>
> It is valid to infer that R bytes are available in packet.
> This change should allow verification of BPF generated for
> C code like below:
>
>    if (data + 42 != data_end) { ... }
>
> Suggested-by: Maciej Żenczykowski <zenczykowski@gmail.com>
> Link: https://lore.kernel.org/bpf/CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   kernel/bpf/verifier.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 918e6a7912e2..b229ba0ad114 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14677,6 +14677,7 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
>   				   struct bpf_verifier_state *this_branch,
>   				   struct bpf_verifier_state *other_branch)
>   {
> +	struct bpf_verifier_state *eq_branch;
>   	int opcode = BPF_OP(insn->code);
>   	int dst_regno = insn->dst_reg;
>   
> @@ -14713,6 +14714,13 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
>   		find_good_pkt_pointers(other_branch, dst_reg, dst_reg->type, opcode == BPF_JLT);
>   		mark_pkt_end(this_branch, dst_regno, opcode == BPF_JLE);
>   		break;
> +	case BPF_JEQ:
> +	case BPF_JNE:
> +		/* pkt_data ==/!= pkt_end, pkt_meta ==/!= pkt_data */
> +		eq_branch = opcode == BPF_JEQ ? other_branch : this_branch;
> +		find_good_pkt_pointers(eq_branch, dst_reg, dst_reg->type, true);
> +		mark_pkt_end(eq_branch, dst_regno, false);
> +		break;

What will happen if there are multiple BPF_JEQ/BPF_JNE? I made a change to one of tests
in patch 3:

+SEC("tc")
+__success __log_level(2)
+__msg("if r3 != r2 goto pc+3         ; R2_w=pkt_end() R3_w=pkt(off=8,r=0xffffffffffffffff)")
+__naked void data_plus_const_neq_pkt_end(void)
+{
+       asm volatile ("                                 \
+       r9 = r1;                                        \
+       r1 = *(u32*)(r9 + %[__sk_buff_data]);           \
+       r2 = *(u32*)(r9 + %[__sk_buff_data_end]);       \
+       r3 = r1;                                        \
+       r3 += 8;                                        \
+       if r3 != r2 goto 1f;                            \
+       r3 += 8;                                        \
+       if r3 != r2 goto 1f;                            \
+       r1 = *(u64 *)(r1 + 0);                          \
+1:                                                     \
+       r0 = 0;                                         \
+       exit;                                           \
+"      :
+       : __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+         __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+       : __clobber_all);
+}


The verifier output:
func#0 @0
Global function data_plus_const_neq_pkt_end() doesn't return scalar. Only those are supported.
0: R1=ctx() R10=fp0
; asm volatile ("                                       \
0: (bf) r9 = r1                       ; R1=ctx() R9_w=ctx()
1: (61) r1 = *(u32 *)(r9 +76)         ; R1_w=pkt(r=0) R9_w=ctx()
2: (61) r2 = *(u32 *)(r9 +80)         ; R2_w=pkt_end() R9_w=ctx()
3: (bf) r3 = r1                       ; R1_w=pkt(r=0) R3_w=pkt(r=0)
4: (07) r3 += 8                       ; R3_w=pkt(off=8,r=0)
5: (5d) if r3 != r2 goto pc+3         ; R2_w=pkt_end() R3_w=pkt(off=8,r=0xffffffffffffffff)
6: (07) r3 += 8                       ; R3_w=pkt(off=16,r=0xffffffffffffffff)
7: (5d) if r3 != r2 goto pc+1         ; R2_w=pkt_end() R3_w=pkt(off=16,r=0xffffffffffffffff)
8: (79) r1 = *(u64 *)(r1 +0)          ; R1=scalar()
9: (b7) r0 = 0                        ; R0_w=0
10: (95) exit

from 7 to 9: safe

from 5 to 9: safe
processed 13 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0

insn 5, for this_branch (straight one), r3 range will be 8 and assuming pkt_end is 8.
insn 7, r3 range becomes 18 and then we assume pkt_end is 16.

I guess we should handle this case. For branch 5 and 7, it cannot be that both will be true.

>   	default:
>   		return false;
>   	}

