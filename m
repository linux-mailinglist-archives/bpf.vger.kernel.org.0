Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3F201D4B
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgFSVtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 17:49:15 -0400
Received: from www62.your-server.de ([213.133.104.62]:35130 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgFSVtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jun 2020 17:49:15 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jmOsq-0002qF-V3; Fri, 19 Jun 2020 23:49:12 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jmOsq-000WTp-OR; Fri, 19 Jun 2020 23:49:12 +0200
Subject: Re: [PATCH bpf-next 1/2] bpf: avoid verifier failure for 32bit
 pointer arithmetic
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, kernel-team@fb.com
References: <20200618234631.3321026-1-yhs@fb.com>
 <20200618234631.3321118-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <93091308-0865-6bad-aa1f-3b46cbc71895@iogearbox.net>
Date:   Fri, 19 Jun 2020 23:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200618234631.3321118-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25848/Fri Jun 19 15:01:57 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/19/20 1:46 AM, Yonghong Song wrote:
> When do experiments with llvm (disabling instcombine and
> simplifyCFG), I hit the following error with test_seg6_loop.o.
> 
>    ; R1=pkt(id=0,off=0,r=48,imm=0), R7=pkt(id=0,off=40,r=48,imm=0)
>    w2 = w7
>    ; R2_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
>    w2 -= w1
>    R2 32-bit pointer arithmetic prohibited
> 
> The corresponding source code is:
>    uint32_t srh_off
>    // srh and skb->data are all packet pointers
>    srh_off = (char *)srh - (char *)(long)skb->data;
> 
> The verifier does not support 32-bit pointer/scalar arithmetic.
> 
> Without my llvm change, the code looks like
> 
>    ; R3=pkt(id=0,off=40,r=48,imm=0), R8=pkt(id=0,off=0,r=48,imm=0)
>    w3 -= w8
>    ; R3_w=inv(id=0)
> 
> This is explicitly allowed in verifier if both registers are
> pointers and the opcode is BPF_SUB.
> 
> To fix this problem, I changed the verifier to allow
> 32-bit pointer/scaler BPF_SUB operations.
> 
> At the source level, the issue could be workarounded with
> inline asm or changing "uint32_t srh_off" to "uint64_t srh_off".
> But I feel that verifier change might be the right thing to do.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Looks good, both applied, thanks!

> ---
>   kernel/bpf/verifier.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 22d90d47befa..bbf6d655d6ad 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5052,6 +5052,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>   
>   	if (BPF_CLASS(insn->code) != BPF_ALU64) {
>   		/* 32-bit ALU ops on pointers produce (meaningless) scalars */
> +		if (opcode == BPF_SUB && env->allow_ptr_leaks) {
> +			__mark_reg_unknown(env, dst_reg);
> +			return 0;
> +		}
> +

We could have also allowed ADD case while at it, but ok either way. Wrt pointer
sanitation, nothing additional seems to be needed here as we 'destroy' the reg
to fully unknown.

>   		verbose(env,
>   			"R%d 32-bit pointer arithmetic prohibited\n",
>   			dst);
> 

