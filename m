Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996FE1E6DAA
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 23:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436609AbgE1Vai (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436505AbgE1Vaf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 17:30:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB8FC08C5C6
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 14:30:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y11so89504plt.12
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KIbLFfgdkB6/MGRHMv/5CD8r1hEle9l0mogeE9CrPGA=;
        b=pl4dAnDLLJHvY4e0WgP/Rj6Iz/Sv6wpRNIP2l9VQN2Wv152qe+jPv/Xje4pytI3bIc
         Tzlp3hpQVA8xVE7k58eLvjOW4FtrJKRQUPU3R/JPWyv/LKP8l6djFz/R2PTXZOi0G788
         qtlKD4wxNvQYmyfW9BOlANx1bu7ayd8NJqoEhIgssuW5pj7sTXF5Aj5i1LROWJnWNTEr
         wBYpXcuNWzSwS5+G7VpIVyX1A/yz7eRfAyyjwbvkgXBXndgn8M1C3PBOzVdc+OC0NQ9w
         hTjTp6S1Rj84e4PWYh/xMHxQv5aPrLBoGoO4yWuzIhv8ZYY0u31MTwpp71CK04TrfEw2
         TWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KIbLFfgdkB6/MGRHMv/5CD8r1hEle9l0mogeE9CrPGA=;
        b=VebyZRjdT03xIa3WYupNj/Rb8ey7gF0ICl+FvHlmdxQ6gU6N0vAMRhkd11Z/CCj5U/
         FbEyHHbtAFFW7qGxp6vMB49LhWzQHI2KeBWONJnG2QZS+jrmQQVS96G7Rfhzs3N9nxIb
         kuzT7VF1E2inNsUk1sRi6fSgk+9X9GGrYzbTja5syXZCBBknOkYvvq9rM+vEMtQOvZd7
         Fbg3SwzjlB85V6GZxb0T4+ksUjc2kreLgFHKcV2NeMsm8dA3dxK/w3pIQJDzVWBjbzvC
         0kQFnBZ9K4iwF/K/7ajL8wIut1cn47qVs8hy7+UjXQmBOvMs0TkuhahFlObQuASEjsUe
         7y8g==
X-Gm-Message-State: AOAM5327BS/yzCJRER27aMAbFq333tLi1A3Ou1EDZdkGC/8o4/aJabT9
        pwUy3H87C/WDgvGeq2BRdBw=
X-Google-Smtp-Source: ABdhPJzGmZO8mLWLDV31uBcTcxNe9Fp1ABpH5Ga9TjxcoKA/0qzyt8a2daVwhbf/O7XKDzoLdL1epg==
X-Received: by 2002:a17:90b:3745:: with SMTP id ne5mr5948230pjb.68.1590701434748;
        Thu, 28 May 2020 14:30:34 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id z6sm5097529pgu.85.2020.05.28.14.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:30:34 -0700 (PDT)
Date:   Thu, 28 May 2020 14:30:26 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        John Fastabend <john.fastabend@gmail.com>
Message-ID: <5ed02d7214c39_1fea2b263a20e5b435@john-XPS-13-9370.notmuch>
In-Reply-To: <20200528165043.1568695-1-yhs@fb.com>
References: <20200528165043.1568623-1-yhs@fb.com>
 <20200528165043.1568695-1-yhs@fb.com>
Subject: RE: [PATCH bpf 1/2] bpf: fix a verifier issue when assigning 32bit
 reg states to 64bit ones
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> With the latest trunk llvm (llvm 11), I hit a verifier issue for
> test_prog subtest test_verif_scale1.
> 
> The following simplified example illustrate the issue:
>     w9 = 0  /* R9_w=inv0 */
>     r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
>     r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
>     ......
>     w2 = w9 /* R2_w=inv0 */
>     r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>     r6 += r2 /* R6_w=inv(id=0) */
>     r3 = r6 /* R3_w=inv(id=0) */
>     r3 += 14 /* R3_w=inv(id=0) */
>     if r3 > r8 goto end
>     r5 = *(u32 *)(r6 + 0) /* R6_w=inv(id=0) */
>        <== error here: R6 invalid mem access 'inv'
>     ...
>   end:
> 
> In real test_verif_scale1 code, "w9 = 0" and "w2 = w9" are in
> different basic blocks.
> 
> In the above, after "r6 += r2", r6 becomes a scalar, which eventually
> caused the memory access error. The correct register state should be
> a pkt pointer.
> 
> The inprecise register state starts at "w2 = w9".
> The 32bit register w9 is 0, in __reg_assign_32_into_64(),
> the 64bit reg->smax_value is assigned to be U32_MAX.
> The 64bit reg->smin_value is 0 and the 64bit register
> itself remains constant based on reg->var_off.
> 
> In adjust_ptr_min_max_vals(), the verifier checks for a known constant,
> smin_val must be equal to smax_val. Since they are not equal,
> the verifier decides r6 is a unknown scalar, which caused later failure.
> 
> The llvm10 does not have this issue as it generates different code:
>     w9 = 0  /* R9_w=inv0 */
>     r8 = *(u32 *)(r1 + 80)  /* __sk_buff->data_end */
>     r7 = *(u32 *)(r1 + 76)  /* __sk_buff->data */
>     ......
>     r6 = r7 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>     r6 += r9 /* R6_w=pkt(id=0,off=0,r=0,imm=0) */
>     r3 = r6 /* R3_w=pkt(id=0,off=0,r=0,imm=0) */
>     r3 += 14 /* R3_w=pkt(id=0,off=14,r=0,imm=0) */
>     if r3 > r8 goto end
>     ...
> 
> To fix the issue, if 32bit register is a const 0,
> then just assign max vaue 0 to 64bit register smax_value as well.
> 
> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>


Thanks!

> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8d7ee40e2748..5123ce54695f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1174,6 +1174,9 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
>  		reg->smin_value = 0;
>  	if (reg->s32_max_value > 0)
>  		reg->smax_value = reg->s32_max_value;
> +	else if (reg->s32_max_value == 0 && reg->s32_min_value == 0 &&
> +		 tnum_is_const(reg->var_off))
> +		reg->smax_value = 0; /* const 0 */
>  	else
>  		reg->smax_value = U32_MAX;
>  }
> -- 
> 2.24.1
> 

How about the following, I think it will also cover the case above. We should be
checking 'smin_value > 0' as well I believe.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c                                                                                                                                                                                                    
index b3d2590..80d22de 100644                                                                                                                                                                                                                                 
--- a/kernel/bpf/verifier.c                                                                                                                                                                                                                                   
+++ b/kernel/bpf/verifier.c                                                                                                                                                                                                                                   
@@ -1217,14 +1217,14 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)                                                                                                                                                                        
         * but must be positive otherwise set to worse case bounds
         * and refine later from tnum.
         */
+       if (reg->s32_min_value >= 0 && reg->s32_max_value >= 0)
+               reg->smax_value = reg->s32_max_value;
+       else
+               reg->smax_value = U32_MAX;
        if (reg->s32_min_value > 0)
                reg->smin_value = reg->s32_min_value;
        else
                reg->smin_value = 0;
-       if (reg->s32_min_value >= 0 && reg->s32_max_value > 0)
-               reg->smax_value = reg->s32_max_value;
-       else
-               reg->smax_value = U32_MAX;
 }

This causes selftests failure I pasted it at the end of the email. By my
analysis what happens here is after line 10 we get different bounds
and this falls out so that we just miss triggering the failure case in
check_reg_sane_offset()

        if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
                verbose(env, "value %lld makes %s pointer be out of bounds\n",
                        smin, reg_type_str[type]);
                return false;
        }


However (would need to check, improve verifier test) that should still
fail as soon as its read. WDYT? I can try to roll it into your test if
you want or if you have time go for it. Let me know.

# ./test_verifier -v 66
#66/p bounds check after truncation of boundary-crossing range (2) FAIL
Unexpected success to load!
func#0 @0
0: R1=ctx(id=0,off=0,imm=0) R10=fp0
0: (7a) *(u64 *)(r10 -8) = 0
1: R1=ctx(id=0,off=0,imm=0) R10=fp0 fp-8_w=mmmmmmmm
1: (bf) r2 = r10
2: R1=ctx(id=0,off=0,imm=0) R2_w=fp0 R10=fp0 fp-8_w=mmmmmmmm
2: (07) r2 += -8
3: R1=ctx(id=0,off=0,imm=0) R2_w=fp-8 R10=fp0 fp-8_w=mmmmmmmm
3: (18) r1 = 0xffff8883dba1e800
5: R1_w=map_ptr(id=0,off=0,ks=8,vs=8,imm=0) R2_w=fp-8 R10=fp0 fp-8_w=mmmmmmmm
5: (85) call bpf_map_lookup_elem#1
6: R0_w=map_value_or_null(id=1,off=0,ks=8,vs=8,imm=0) R10=fp0 fp-8_w=mmmmmmmm
6: (15) if r0 == 0x0 goto pc+9
 R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R10=fp0 fp-8_w=mmmmmmmm
7: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R10=fp0 fp-8_w=mmmmmmmm
7: (71) r1 = *(u8 *)(r0 +0)
 R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R10=fp0 fp-8_w=mmmmmmmm
8: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) R10=fp0 fp-8_w=mmmmmmmm
8: (07) r1 += 2147483584
9: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umin_value=2147483584,umax_value=2147483839,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8_w=mmmmmmmm
9: (07) r1 += 2147483584
10: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umin_value=4294967168,umax_value=4294967423,var_off=(0x0; 0x1ffffffff)) R10=fp0 fp-8_w=mmmmmmmm
10: (bc) w1 = w1
11: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8_w=mmmmmmmm
11: (17) r1 -= 2147483584
12: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,smin_value=-2147483584,smax_value=2147483711) R10=fp0 fp-8_w=mmmmmmmm
12: (17) r1 -= 2147483584
13: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,smin_value=-4294967168,smax_value=127) R10=fp0 fp-8_w=mmmmmmmm
13: (77) r1 >>= 8
14: R0_w=map_value(id=0,off=0,ks=8,vs=8,imm=0) R1_w=inv(id=0,umax_value=72057594037927935,var_off=(0x0; 0xffffffffffffff)) R10=fp0 fp-8_w=mmmmmmmm
14: (0f) r0 += r1
last_idx 14 first_idx 0
regs=2 stack=0 before 13: (77) r1 >>= 8
regs=2 stack=0 before 12: (17) r1 -= 2147483584
regs=2 stack=0 before 11: (17) r1 -= 2147483584
regs=2 stack=0 before 10: (bc) w1 = w1
regs=2 stack=0 before 9: (07) r1 += 2147483584
regs=2 stack=0 before 8: (07) r1 += 2147483584
regs=2 stack=0 before 7: (71) r1 = *(u8 *)(r0 +0)
15: R0_w=map_value(id=0,off=0,ks=8,vs=8,umax_value=72057594037927935,var_off=(0x0; 0xffffffffffffff)) R1_w=invP(id=0,umax_value=72057594037927935,var_off=(0x0; 0xffffffffffffff)) R10=fp0 fp-8_w=mmmmmmmm
15: (b7) r0 = 0
16: R0=inv0 R1=invP(id=0,umax_value=72057594037927935,var_off=(0x0; 0xffffffffffffff)) R10=fp0 fp-8=mmmmmmmm
16: (95) exit

from 6 to 16: safe
processed 17 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
