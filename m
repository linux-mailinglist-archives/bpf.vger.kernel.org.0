Return-Path: <bpf+bounces-18392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBD481A1C4
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 16:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A276288C08
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D23D974;
	Wed, 20 Dec 2023 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BkVHkd7r"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384B38DEA
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uJ14NiVY86tUZxAVM+ZwNZQZHWjOSr6p4HOz7pLGbO0=; b=BkVHkd7rlhEhiJvUoBoH66Q/Et
	b1FoIFjsCuw6ESuGEBVSoIEfSIMvnDqUjPcIJA2gA4nPeCjmFOp3os3fD47hNq2XWz92vg0J8RbZo
	ansYdspKAJ/0NYinXLna4V95eXuqEDC2g/+4qflxFvq1ZbtMctyqMEBmeutwRxcuJesp+NTXikoEd
	wbsq6Q6SSV/9472cw7UMwXIS3WBKUdkOcll500UVDfoEezUEkl30oxjcJAhKBBdLDaF/IuxJhBzK7
	t9uwdVFkQ8PU2jrXBRnRANBwAg2zfGkPg7EKc5YOe1sSU6pQ8wwgZIBcWcL2Ppb0H9CPZjuEtZdVm
	zqj7qsSQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFy5K-000KeS-TC; Wed, 20 Dec 2023 16:02:10 +0100
Received: from [178.197.249.36] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFy5K-000ELm-06; Wed, 20 Dec 2023 16:02:10 +0100
Subject: Re: [PATCH bpf-next 1/3] bpf: Support inlining bpf_kptr_xchg() helper
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
 <20231219135615.2656572-2-houtao@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ee4fb6df-1eb9-3dbb-ec09-1e0f6fd06a6a@iogearbox.net>
Date: Wed, 20 Dec 2023 16:02:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219135615.2656572-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27129/Wed Dec 20 10:38:37 2023)

On 12/19/23 2:56 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Considering most 64-bit JIT backends support atomic_xchg() and the
> implementation of xchg() is the same as atomic_xchg() on these 64-bits
> architectures, inline bpf_kptr_xchg() by converting the calling of
> bpf_kptr_xchg() into an atomic_xchg() instruction.
> 
> As a precaution, defining a weak function bpf_jit_supports_ptr_xchg()
> to state whether such conversion is safe and only inlining under 64-bit
> host.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

You can probably send patch 2/3 as stand-alone, and squash patch 3/3 with
this one in here.

> ---
>   include/linux/filter.h |  1 +
>   kernel/bpf/core.c      | 10 ++++++++++
>   kernel/bpf/verifier.c  | 17 +++++++++++++++++
>   3 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 12d907f17d36..fee070b9826e 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -955,6 +955,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
>   bool bpf_jit_supports_kfunc_call(void);
>   bool bpf_jit_supports_far_kfunc_call(void);
>   bool bpf_jit_supports_exceptions(void);
> +bool bpf_jit_supports_ptr_xchg(void);
>   void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
>   bool bpf_helper_changes_pkt_data(void *func);
>   
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5aa6863ac33b..b64885827f90 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2922,6 +2922,16 @@ bool __weak bpf_jit_supports_far_kfunc_call(void)
>   	return false;
>   }
>   
> +/* Return TRUE if the JIT backend satisfies the following two conditions:
> + * 1) JIT backend supports atomic_xchg() on pointer-sized words.
> + * 2) Under the specific arch, the implementation of xchg() is the same
> + *    as atomic_xchg() on pointer-sized words.
> + */
> +bool __weak bpf_jit_supports_ptr_xchg(void)
> +{
> +	return false;
> +}
> +
>   /* To execute LD_ABS/LD_IND instructions __bpf_prog_run() may call
>    * skb_copy_bits(), so provide a weak definition of it for NET-less config.
>    */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9456ee0ad129..7814c4f7576e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19668,6 +19668,23 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>   			continue;
>   		}
>   
> +		/* Implement bpf_kptr_xchg inline */
> +		if (prog->jit_requested && BITS_PER_LONG == 64 &&
> +		    insn->imm == BPF_FUNC_kptr_xchg &&
> +		    bpf_jit_supports_ptr_xchg()) {
> +			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
> +			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
> +			cnt = 2;
> +
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    += cnt - 1;
> +			env->prog = prog = new_prog;
> +			insn      = new_prog->insnsi + i + delta;
> +			continue;
> +		}
>   patch_call_imm:
>   		fn = env->ops->get_func_proto(insn->imm, env->prog);
>   		/* all functions that have prototype and verifier allowed
> 


