Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C722D6C61
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 01:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393345AbgLKALE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 19:11:04 -0500
Received: from www62.your-server.de ([213.133.104.62]:39796 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390241AbgLKAKu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 19:10:50 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1knW0e-00083h-5v; Fri, 11 Dec 2020 01:10:08 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1knW0e-000QYv-03; Fri, 11 Dec 2020 01:10:08 +0100
Subject: Re: [PATCH bpf-next v2 1/2] bpf: permits pointers on stack for helper
 calls
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, kernel-team@fb.com,
        Song Liu <songliubraving@fb.com>
References: <20201210013348.943623-1-yhs@fb.com>
 <20201210013349.943719-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <27ad1c8d-5294-8ddb-a750-90d82bdfcd68@iogearbox.net>
Date:   Fri, 11 Dec 2020 01:10:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201210013349.943719-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26014/Thu Dec 10 15:21:42 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/10/20 2:33 AM, Yonghong Song wrote:
> Currently, when checking stack memory accessed by helper calls,
> for spills, only PTR_TO_BTF_ID and SCALAR_VALUE are
> allowed.
> 
> Song discovered an issue where the below bpf program
>    int dump_task(struct bpf_iter__task *ctx)
>    {
>      struct seq_file *seq = ctx->meta->seq;
>      static char[] info = "abc";
>      BPF_SEQ_PRINTF(seq, "%s\n", info);
>      return 0;
>    }
> may cause a verifier failure.
> 
> The verifier output looks like:
>    ; struct seq_file *seq = ctx->meta->seq;
>    1: (79) r1 = *(u64 *)(r1 +0)
>    ; BPF_SEQ_PRINTF(seq, "%s\n", info);
>    2: (18) r2 = 0xffff9054400f6000
>    4: (7b) *(u64 *)(r10 -8) = r2
>    5: (bf) r4 = r10
>    ;
>    6: (07) r4 += -8
>    ; BPF_SEQ_PRINTF(seq, "%s\n", info);
>    7: (18) r2 = 0xffff9054400fe000
>    9: (b4) w3 = 4
>    10: (b4) w5 = 8
>    11: (85) call bpf_seq_printf#126
>     R1_w=ptr_seq_file(id=0,off=0,imm=0) R2_w=map_value(id=0,off=0,ks=4,vs=4,imm=0)
>    R3_w=inv4 R4_w=fp-8 R5_w=inv8 R10=fp0 fp-8_w=map_value
>    last_idx 11 first_idx 0
>    regs=8 stack=0 before 10: (b4) w5 = 8
>    regs=8 stack=0 before 9: (b4) w3 = 4
>    invalid indirect read from stack off -8+0 size 8
> 
> Basically, the verifier complains the map_value pointer at "fp-8" location.
> To fix the issue, if env->allow_ptr_leaks is true, let us also permit
> pointers on the stack to be accessible by the helper.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Reported-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   kernel/bpf/verifier.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 93def76cf32b..9159c9822ede 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3769,7 +3769,8 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
>   			goto mark;
>   
>   		if (state->stack[spi].slot_type[0] == STACK_SPILL &&
> -		    state->stack[spi].spilled_ptr.type == SCALAR_VALUE) {
> +		    (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
> +		     env->allow_ptr_leaks)) {

Afaik, in check_stack_write() we mark some of the spilled_ptr.type as NOT_INIT,
shouldn't we at least avoid an implicit transition of NOT_INIT into SCALAR_VALUE?

>   			__mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
>   			for (j = 0; j < BPF_REG_SIZE; j++)
>   				state->stack[spi].slot_type[j] = STACK_MISC;
> 

