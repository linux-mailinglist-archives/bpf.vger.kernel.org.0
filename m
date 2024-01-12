Return-Path: <bpf+bounces-19474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13FC82C58B
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FF01F248D4
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D879156F0;
	Fri, 12 Jan 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6spb3E4"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6A14F82
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7bbb2960-bfad-49bf-b54e-e31a9351d40d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705084693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8SfbdP6sENpPehsszchiXicCT8Q7M56bKRI/vbCoXE=;
	b=K6spb3E487C2mjj02Kyhvybez+3nW0+Fhe3nKtJAUt+elGqegCBNYU2p203pwK6lB7I8G/
	PhmIrKICXiFIjZHkFtEwGCZY6Haep/5gD9OM5P4cnNQkuGWUWbaSoif3WRJW7Xae9FWQVi
	YmTgpxaxKd/9WO0PNgqYsTj2djfG6u8=
Date: Fri, 12 Jan 2024 10:38:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] bpf: Reject variable offset alu on
 PTR_TO_FLOW_KEYS
Content-Language: en-GB
To: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc: willemb@google.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, linux-kernel@vger.kernel.org
References: <20240112152011.6264-1-sunhao.th@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240112152011.6264-1-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/12/24 7:20 AM, Hao Sun wrote:
> For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off
> for validation. However, variable offset ptr alu is not prohibited
> for this ptr kind. So the variable offset is not checked.
>
> The following prog is accepted:
> func#0 @0
> 0: R1=ctx() R10=fp0
> 0: (bf) r6 = r1                       ; R1=ctx() R6_w=ctx()
> 1: (79) r7 = *(u64 *)(r6 +144)        ; R6_w=ctx() R7_w=flow_keys()
> 2: (b7) r8 = 1024                     ; R8_w=1024
> 3: (37) r8 /= 1                       ; R8_w=scalar()
> 4: (57) r8 &= 1024                    ; R8_w=scalar(smin=smin32=0,
> smax=umax=smax32=umax32=1024,var_off=(0x0; 0x400))
> 5: (0f) r7 += r8
> mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=r8 stack= before 4: (57) r8 &= 1024
> mark_precise: frame0: regs=r8 stack= before 3: (37) r8 /= 1
> mark_precise: frame0: regs=r8 stack= before 2: (b7) r8 = 1024
> 6: R7_w=flow_keys(smin=smin32=0,smax=umax=smax32=umax32=1024,var_off
> =(0x0; 0x400)) R8_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1024,
> var_off=(0x0; 0x400))
> 6: (79) r0 = *(u64 *)(r7 +0)          ; R0_w=scalar()
> 7: (95) exit
>
> This prog loads flow_keys to r7, and adds the variable offset r8
> to r7, and finally causes out-of-bounds access:
>
> BUG: unable to handle page fault for address: ffffc90014c80038
> ...
> Call Trace:
>   <TASK>
>   bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
>   __bpf_prog_run include/linux/filter.h:651 [inline]
>   bpf_prog_run include/linux/filter.h:658 [inline]
>   bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
>   bpf_flow_dissect+0x15f/0x350 net/core/flow_dissector.c:991
>   bpf_prog_test_run_flow_dissector+0x39d/0x620 net/bpf/test_run.c:1359
>   bpf_prog_test_run kernel/bpf/syscall.c:4107 [inline]
>   __sys_bpf+0xf8f/0x4560 kernel/bpf/syscall.c:5475
>   __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
>   __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5559
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> Fix this by rejecting ptr alu with variable offset on flow_keys.
> Applying the patch makes the program rejected with "R7 pointer
> arithmetic on flow_keys prohibited"
>
> Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/verifier.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index adbf330d364b..65f598694d55 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12826,6 +12826,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>   	}
>   
>   	switch (base_type(ptr_reg->type)) {
> +	case PTR_TO_FLOW_KEYS:
> +		if (known)
> +			break;
> +		fallthrough;
>   	case CONST_PTR_TO_MAP:
>   		/* smin_val represents the known value */
>   		if (known && smin_val == 0 && opcode == BPF_ADD)

