Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E4476ABB
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 08:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhLPHCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 02:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLPHCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 02:02:40 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E5C061574
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:02:40 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 131so61974736ybc.7
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5SS5bKJ6wzgwFhvE3jHe42Wrpcc+8fFeYLVfkrgc74=;
        b=ZUGIr3PEwjkq7MTtKTbMP8Mqa5zigql/SncmSsL2QFZWI/wFXXivggq2HEyJqsvpRF
         7B8G09PgIk/3yP9h8K5oODy8DTqpl6jT+MfkjuFQqm7RHtCsQ5i4S2nExxohoeyPUcl+
         p+CTmrYzzM+/S2U2h04fSoo9LOUPqOWzO6ny5MGziNdKwmUF7YRc6Q7inK5YAOvqzKsJ
         Rk4uI23r1i//erpWqxW+uZCgummGkcKMJFCfo0mqHwIF3LCEOj8r1txUy9XtIxhFW50k
         z2RWldJuff5un/tstt/YHWwzO2oV3axYNI7OVqbsVz7q2cyEb1MZDXl5AI0qUAWSEqdd
         TURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5SS5bKJ6wzgwFhvE3jHe42Wrpcc+8fFeYLVfkrgc74=;
        b=2Bi8NCx6tLE61PdQKCfq+ES1tfQHqHfOhUlyQUkIHIaKH9tIcfgNGNVM2RMCixdI5Z
         eyU6/xXholjlHyV59eKiLvEFk6ODv3d5+CM3EDUqWKtLIfVEJmcUKv9xS/qcGkkNdR4o
         nCoriOSgqQGiIvkhzebH89bOef5srZHxHe3cdmHaY0xP2zMr1jfr16RwtmsAVb/AJNuw
         xYALNi7XQKmarLggZnOu86jYVKSV+mpkRx5vSCQBztX72sDaaXS5T0xuX+o+gYlcxz4A
         jTyXXWGFTH1h81zhzBUykYEDAmTQY1AFzU9G1sAny5S3tIzkKv3ezV9MtU947CUvsbwd
         jUxg==
X-Gm-Message-State: AOAM530d1jiWKZnCuT3IB1ljUWJF+EgbokUh7HhSIbfSGkvogw4yFYMw
        Y3AXmLfRXd6QXhZaEOHRPqERAY8HiMsfcqqmmR8=
X-Google-Smtp-Source: ABdhPJzID2LNFIQkh9frWjh6Hm4wUQnbGC9ZFDn5jS9tAxxCW1gpDdkHaZH29olGf+Ct7M6JkKyLsHBdLvaEzrbacIg=
X-Received: by 2002:a25:37cb:: with SMTP id e194mr11583712yba.449.1639638159582;
 Wed, 15 Dec 2021 23:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20211215192225.1278237-1-christylee@fb.com> <20211215192225.1278237-2-christylee@fb.com>
In-Reply-To: <20211215192225.1278237-2-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Dec 2021 23:02:28 -0800
Message-ID: <CAEf4BzbNG3u2EOs3dnqkFyykj3QwZmBvn4vRFjuW_74H4ZmWCA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] Only print scratched registers and stack
 slots to verifier logs
To:     Christy Lee <christylee@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, christyc.y.lee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 15, 2021 at 11:23 AM Christy Lee <christylee@fb.com> wrote:
>
> When printing verifier state for any log level, print full verifier
> state only on function calls or on errors. Otherwise, only print the
> registers and stack slots that were accessed.
>
> Log size differences:
>
> verif_scale_loop6 before: 234566564
> verif_scale_loop6 after: 72143943
> 69% size reduction
>
> kfree_skb before: 166406
> kfree_skb after: 55386
> 69% size reduction
>
> Before:
>
> 156: (61) r0 = *(u32 *)(r1 +0)
> 157: R0_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R1=ctx(id=0,off=0,imm=0) R2_w=invP0 R10=fp0 fp-8_w=00000000 fp-16_w=00\
> 000000 fp-24_w=00000000 fp-32_w=00000000 fp-40_w=00000000 fp-48_w=00000000 fp-56_w=00000000 fp-64_w=00000000 fp-72_w=00000000 fp-80_w=00000\
> 000 fp-88_w=00000000 fp-96_w=00000000 fp-104_w=00000000 fp-112_w=00000000 fp-120_w=00000000 fp-128_w=00000000 fp-136_w=00000000 fp-144_w=00\
> 000000 fp-152_w=00000000 fp-160_w=00000000 fp-168_w=00000000 fp-176_w=00000000 fp-184_w=00000000 fp-192_w=00000000 fp-200_w=00000000 fp-208\
> _w=00000000 fp-216_w=00000000 fp-224_w=00000000 fp-232_w=00000000 fp-240_w=00000000 fp-248_w=00000000 fp-256_w=00000000 fp-264_w=00000000 f\
> p-272_w=00000000 fp-280_w=00000000 fp-288_w=00000000 fp-296_w=00000000 fp-304_w=00000000 fp-312_w=00000000 fp-320_w=00000000 fp-328_w=00000\
> 000 fp-336_w=00000000 fp-344_w=00000000 fp-352_w=00000000 fp-360_w=00000000 fp-368_w=00000000 fp-376_w=00000000 fp-384_w=00000000 fp-392_w=\
> 00000000 fp-400_w=00000000 fp-408_w=00000000 fp-416_w=00000000 fp-424_w=00000000 fp-432_w=00000000 fp-440_w=00000000 fp-448_w=00000000
> ; return skb->len;
> 157: (95) exit
> Func#4 is safe for any args that match its prototype
> Validating get_constant() func#5...
> 158: R1=invP(id=0) R10=fp0
> ; int get_constant(long val)
> 158: (bf) r0 = r1
> 159: R0_w=invP(id=1) R1=invP(id=1) R10=fp0
> ; return val - 122;
> 159: (04) w0 += -122
> 160: R0_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R1=invP(id=1) R10=fp0
> ; return val - 122;
> 160: (95) exit
> Func#5 is safe for any args that match its prototype
> Validating get_skb_ifindex() func#6...
> 161: R1=invP(id=0) R2=ctx(id=0,off=0,imm=0) R3=invP(id=0) R10=fp0
> ; int get_skb_ifindex(int val, struct __sk_buff *skb, int var)
> 161: (bc) w0 = w3
> 162: R0_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R1=invP(id=0) R2=ctx(id=0,off=0,imm=0) R3=invP(id=0) R10=fp0
>
> After:
>
> 156: (61) r0 = *(u32 *)(r1 +0)
> 157: R0_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R1=ctx(id=0,off=0,imm=0)
> ; return skb->len;
> 157: (95) exit
> Func#4 is safe for any args that match its prototype
> Validating get_constant() func#5...
> 158: R1=invP(id=0) R10=fp0
> ; int get_constant(long val)
> 158: (bf) r0 = r1
> 159: R0_w=invP(id=1) R1=invP(id=1)
> ; return val - 122;
> 159: (04) w0 += -122
> 160: R0_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return val - 122;
> 160: (95) exit
> Func#5 is safe for any args that match its prototype
> Validating get_skb_ifindex() func#6...
> 161: R1=invP(id=0) R2=ctx(id=0,off=0,imm=0) R3=invP(id=0) R10=fp0
> ; int get_skb_ifindex(int val, struct __sk_buff *skb, int var)
> 161: (bc) w0 = w3
> 162: R0_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R3=invP(id=0)
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---

Looks good to me, but see a few nits below. They can be ignored or
addressed as a follow up.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf_verifier.h                  |  7 +++
>  kernel/bpf/verifier.c                         | 62 ++++++++++++++++++-
>  .../testing/selftests/bpf/prog_tests/align.c  | 30 ++++-----
>  3 files changed, 82 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 182b16a91084..c555222c97d6 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -474,6 +474,13 @@ struct bpf_verifier_env {
>         /* longest register parentage chain walked for liveness marking */
>         u32 longest_mark_read_walk;
>         bpfptr_t fd_array;
> +
> +       /* bit mask to keep track of whether a register has been accessed
> +        * since the last time the function state was pritned

typo: printed

> +        */
> +       u32 scratched_regs;
> +       /* Same as scratched_regs but for stack slots */
> +       u64 scratched_stack_slots;
>  };
>
>  __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,

[...]

> +       mark_stack_slot_scratched(env, spi);
>         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
>             !register_is_null(reg) && env->bpf_capable) {
>                 if (dst_reg != BPF_REG_FP) {
> @@ -2957,6 +3004,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>                 slot = -i - 1;
>                 spi = slot / BPF_REG_SIZE;
>                 stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
> +               mark_stack_slot_scratched(env, spi);
>
>                 if (!env->allow_ptr_leaks
>                                 && *stype != NOT_INIT
> @@ -6009,8 +6057,10 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>         *insn_idx = env->subprog_info[subprog].start - 1;
>
>         if (env->log.level & BPF_LOG_LEVEL) {
> +               mark_verifier_state_scratched(env);
>                 verbose(env, "caller:\n");
>                 print_verifier_state(env, caller);

In all but one cases you call mark_verifier_state_scratched(env)
before calling print_verifier_state(). Instead of sort of artificially
scratch entire state, I'd add a bool flag to print_verifier_state() to
control whether we want to take into account scratch masks or not. It
would also make sure that we will never forget to scratch it where
necessary (you'll have to make a conscious decision on each
print_verifier_state() call).

> +               mark_verifier_state_scratched(env);
>                 verbose(env, "callee:\n");
>                 print_verifier_state(env, callee);
>         }

[...]

> @@ -161,13 +161,13 @@ static struct bpf_align_test tests[] = {
>                 },
>                 .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>                 .matches = {
> -                       {7, "R0_w=pkt(id=0,off=8,r=8,imm=0)"},
> +                       {6, "R0_w=pkt(id=0,off=8,r=8,imm=0)"},
>                         {7, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>                         {8, "R3_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
>                         {9, "R3_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
>                         {10, "R3_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
>                         {11, "R3_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},

consider this a feature request (unless people disagree), but these
"_value" suffixes for umin/umax/s32_min/etc are just noise and don't
contribute anything but extra visual noise. I'd remove them. map_value
is ok, probably (because we should have map_key, I guess).

> -                       {18, "R3=pkt_end(id=0,off=0,imm=0)"},
> +                       {13, "R3_w=pkt_end(id=0,off=0,imm=0)"},
>                         {18, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>                         {19, "R4_w=inv(id=0,umax_value=8160,var_off=(0x0; 0x1fe0))"},
>                         {20, "R4_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
> @@ -234,10 +234,10 @@ static struct bpf_align_test tests[] = {
>                 },
>                 .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>                 .matches = {
> -                       {4, "R5_w=pkt(id=0,off=0,r=0,imm=0)"},
> +                       {3, "R5_w=pkt(id=0,off=0,r=0,imm=0)"},

another improvement suggestion: all these id=0 is also noise. I'd make
sure that cases where we do care about ids always use id > 0 (I think
that might be the case already) and just never output id=0


>                         {5, "R5_w=pkt(id=0,off=14,r=0,imm=0)"},
>                         {6, "R4_w=pkt(id=0,off=14,r=0,imm=0)"},
> -                       {10, "R2=pkt(id=0,off=0,r=18,imm=0)"},
> +                       {9, "R2=pkt(id=0,off=0,r=18,imm=0)"},
>                         {10, "R5=pkt(id=0,off=14,r=18,imm=0)"},
>                         {10, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>                         {14, "R4_w=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff))"},

Another thing that always confuses me is the use of "inv" to denote
scalar. I could never understand why it's not a "scalar" or just
nothing. Especially for cases when we have known value. We'll see
"R4=inv4". So confusing. Maybe let's just drop the inv, so we'll have:

R4=4

or (taking into the account all the above suggestions)

R4=(umax=65535,var_off=(0x0; 0xffff))

I don't think we lose anything by dropping "inv", but "scalar" would
be still better (even if slightly longer).


> @@ -296,7 +296,7 @@ static struct bpf_align_test tests[] = {
>                         /* Calculated offset in R6 has unknown value, but known
>                          * alignment of 4.
>                          */
> -                       {8, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
> +                       {6, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
>                         {8, "R6_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
>                         /* Offset is added to packet pointer R5, resulting in
>                          * known fixed offset, and variable offset from R6.

[...]
