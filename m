Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1901047768A
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 17:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhLPQCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 11:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhLPQCn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 11:02:43 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E4DC061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:02:42 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso29566515otf.0
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7Ms3/NjYTVXeMpuo9p2D0JJypu1gMyq1J2UTpPACoA=;
        b=OPktM2YuvURqVFi42hashuIfU2swdBppFQ9dYy09Cpz7SQJ3cH2KPYIXPl7qwLUKrw
         TB8+QYk5NVEkk6d+OvM8gvJuWKTfnKoMSyeP+gnf1Ti10+mLtSO7hoGOxcu/DQXezKTI
         YxSUIyTGzRqsOiHVadK1TLEimV8EvovtrMyn9EL1VJzQRe2P3rGEPJ+5MJjef/6KjwM1
         zCuFNEpNNByzMEhLKBOYTuVG4E4YHbOu2ONHKsVA0IEu/m5/5/VEaXDYD61+r0pA6cqk
         VE6UHZkx1aYdCIAnHqqT4RIplZvh4jYr0PN4LkwDYe4XROqH+j4qLrqWD+FFKteTMaLb
         D3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7Ms3/NjYTVXeMpuo9p2D0JJypu1gMyq1J2UTpPACoA=;
        b=gjoshbVrf78aLhn73Z2fMTLEQQQcppZDdKMFw4I0VUn2jrS0dQnqAKs9i2dd702SMo
         KIGrCmx2U1RT05S8G0doF5b3KHyfweY1jFYElzZlywGPtO0sjgV3eMkj8SJP4x5VfWc/
         pZBYePscMN/LHj4b9rmmE6XXkNcHkwqYoFSJHwQkP6x0BneNXBndQzi0jo1LqEUMaMnj
         EORHjSwIpEajfi7CwLrb2iyWDqIv22at47hZYDByIhxq98Oc27NjZTmkqjhvsaqLexcn
         k6dp76AZPcFI72EWqXm6cAfwDnGNFW/pZ3x4J0QkXFA+1sIIklPILpXAY6UJgImLiUIr
         aX6Q==
X-Gm-Message-State: AOAM532D40WgHWJBAt56efZV+kMmdD2PAHvwi4FkDW6JXwaYU0AHrThM
        6PAWBzwqzzuGi7hTJPYEfCxSBSGIcvU/uUNaIdceZyON2CQ=
X-Google-Smtp-Source: ABdhPJyLdThygHlMyyUcWD8lCckOiTVdXw4F9M/EjIGJLcm+JE7nIWMS852Q5OeR/sbrpZo/gEFZPQJjcEnlLJhFn/E=
X-Received: by 2002:a05:6830:2646:: with SMTP id f6mr13387601otu.182.1639670562068;
 Thu, 16 Dec 2021 08:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20211215192225.1278237-1-christylee@fb.com> <20211215192225.1278237-2-christylee@fb.com>
 <CAEf4BzbNG3u2EOs3dnqkFyykj3QwZmBvn4vRFjuW_74H4ZmWCA@mail.gmail.com> <CAPqJDZpuZ586TawooQhxZGvOqgF4yCjT0yOLEXAUer8eJDO7gw@mail.gmail.com>
In-Reply-To: <CAPqJDZpuZ586TawooQhxZGvOqgF4yCjT0yOLEXAUer8eJDO7gw@mail.gmail.com>
From:   Christy Lee <christyc.y.lee@gmail.com>
Date:   Thu, 16 Dec 2021 08:02:30 -0800
Message-ID: <CAPqJDZpyO_dK8YA+trbrQWsriJmQF3e1gczTVpXYquiDNjWd5g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] Only print scratched registers and stack
 slots to verifier logs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Christy Lee <christylee@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 7:48 AM Christy Lee <christyc.y.lee@gmail.com> wrote:

Apologies, resending this because the previous email was not plain text.

>
>
> On Wed, Dec 15, 2021 at 11:02 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, Dec 15, 2021 at 11:23 AM Christy Lee <christylee@fb.com> wrote:
>>
> [...]
>>
>>
>> Looks good to me, but see a few nits below. They can be ignored or
>> addressed as a follow up.
>>
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>> >  include/linux/bpf_verifier.h                  |  7 +++
>> >  kernel/bpf/verifier.c                         | 62 ++++++++++++++++++-
>> >  .../testing/selftests/bpf/prog_tests/align.c  | 30 ++++-----
>> >  3 files changed, 82 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> > index 182b16a91084..c555222c97d6 100644
>> > --- a/include/linux/bpf_verifier.h
>> > +++ b/include/linux/bpf_verifier.h
>> > @@ -474,6 +474,13 @@ struct bpf_verifier_env {
>> >         /* longest register parentage chain walked for liveness marking */
>> >         u32 longest_mark_read_walk;
>> >         bpfptr_t fd_array;
>> > +
>> > +       /* bit mask to keep track of whether a register has been accessed
>> > +        * since the last time the function state was pritned
>>
>> typo: printed
>>
>> > +        */
>> > +       u32 scratched_regs;
>> > +       /* Same as scratched_regs but for stack slots */
>> > +       u64 scratched_stack_slots;
>> >  };
>> >
>> >  __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
>>
>> [...]
>>
>> > +       mark_stack_slot_scratched(env, spi);
>> >         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
>> >             !register_is_null(reg) && env->bpf_capable) {
>> >                 if (dst_reg != BPF_REG_FP) {
>> > @@ -2957,6 +3004,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>> >                 slot = -i - 1;
>> >                 spi = slot / BPF_REG_SIZE;
>> >                 stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
>> > +               mark_stack_slot_scratched(env, spi);
>> >
>> >                 if (!env->allow_ptr_leaks
>> >                                 && *stype != NOT_INIT
>> > @@ -6009,8 +6057,10 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>> >         *insn_idx = env->subprog_info[subprog].start - 1;
>> >
>> >         if (env->log.level & BPF_LOG_LEVEL) {
>> > +               mark_verifier_state_scratched(env);
>> >                 verbose(env, "caller:\n");
>> >                 print_verifier_state(env, caller);
>>
>> In all but one cases you call mark_verifier_state_scratched(env)
>> before calling print_verifier_state(). Instead of sort of artificially
>> scratch entire state, I'd add a bool flag to print_verifier_state() to
>> control whether we want to take into account scratch masks or not. It
>> would also make sure that we will never forget to scratch it where
>> necessary (you'll have to make a conscious decision on each
>> print_verifier_state() call).
>
> Good idea! I'll do that.
>>
>>
>> > +               mark_verifier_state_scratched(env);
>> >                 verbose(env, "callee:\n");
>> >                 print_verifier_state(env, callee);
>> >         }
>>
>> [...]
>>
>> > @@ -161,13 +161,13 @@ static struct bpf_align_test tests[] = {
>> >                 },
>> >                 .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>> >                 .matches = {
>> > -                       {7, "R0_w=pkt(id=0,off=8,r=8,imm=0)"},
>> > +                       {6, "R0_w=pkt(id=0,off=8,r=8,imm=0)"},
>> >                         {7, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>> >                         {8, "R3_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
>> >                         {9, "R3_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
>> >                         {10, "R3_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
>> >                         {11, "R3_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
>>
> These would be very useful features, I'll address them as a follow up.
>>
>> consider this a feature request (unless people disagree), but these
>> "_value" suffixes for umin/umax/s32_min/etc are just noise and don't
>> contribute anything but extra visual noise. I'd remove them. map_value
>> is ok, probably (because we should have map_key, I guess).
>>
>> > -                       {18, "R3=pkt_end(id=0,off=0,imm=0)"},
>> > +                       {13, "R3_w=pkt_end(id=0,off=0,imm=0)"},
>> >                         {18, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>> >                         {19, "R4_w=inv(id=0,umax_value=8160,var_off=(0x0; 0x1fe0))"},
>> >                         {20, "R4_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
>> > @@ -234,10 +234,10 @@ static struct bpf_align_test tests[] = {
>> >                 },
>> >                 .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>> >                 .matches = {
>> > -                       {4, "R5_w=pkt(id=0,off=0,r=0,imm=0)"},
>> > +                       {3, "R5_w=pkt(id=0,off=0,r=0,imm=0)"},
>>
>> another improvement suggestion: all these id=0 is also noise. I'd make
>> sure that cases where we do care about ids always use id > 0 (I think
>> that might be the case already) and just never output id=0
>>
>>
>> >                         {5, "R5_w=pkt(id=0,off=14,r=0,imm=0)"},
>> >                         {6, "R4_w=pkt(id=0,off=14,r=0,imm=0)"},
>> > -                       {10, "R2=pkt(id=0,off=0,r=18,imm=0)"},
>> > +                       {9, "R2=pkt(id=0,off=0,r=18,imm=0)"},
>> >                         {10, "R5=pkt(id=0,off=14,r=18,imm=0)"},
>> >                         {10, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
>> >                         {14, "R4_w=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff))"},
>>
>> Another thing that always confuses me is the use of "inv" to denote
>> scalar. I could never understand why it's not a "scalar" or just
>> nothing. Especially for cases when we have known value. We'll see
>> "R4=inv4". So confusing. Maybe let's just drop the inv, so we'll have:
>>
>> R4=4
>>
>> or (taking into the account all the above suggestions)
>>
>> R4=(umax=65535,var_off=(0x0; 0xffff))
>>
>> I don't think we lose anything by dropping "inv", but "scalar" would
>> be still better (even if slightly longer).
>>
>>
>> > @@ -296,7 +296,7 @@ static struct bpf_align_test tests[] = {
>> >                         /* Calculated offset in R6 has unknown value, but known
>> >                          * alignment of 4.
>> >                          */
>> > -                       {8, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
>> > +                       {6, "R2_w=pkt(id=0,off=0,r=8,imm=0)"},
>> >                         {8, "R6_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
>> >                         /* Offset is added to packet pointer R5, resulting in
>> >                          * known fixed offset, and variable offset from R6.
>>
>> [...]
