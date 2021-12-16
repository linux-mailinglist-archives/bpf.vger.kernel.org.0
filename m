Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C1F47768E
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 17:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhLPQDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 11:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbhLPQDR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 11:03:17 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DB4C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:03:17 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bf8so37117622oib.6
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+URSeXYEOXBiJ55t4947He9Cl/mDKLgzYApsLtKEys=;
        b=W0/HuP036jtMsdMj0Z4Lsq/JUdOZR+8B8NVjp6BDR9H3KJFyCSLT5/F3fPqLNRsLS5
         NENuuYMxOYF1AZw0GC38Myyvz8vI9Lhwa1+0NFqrocCk1LV6SUrw4nx7O5vUh30d4h9w
         z7y+/zDAngymgWro9Jfw9AZPqK0bcNgVrGVu70Ng+k2BIP3egGiaEdykiaTEMH5jdzfo
         kWXAJq1Bzdu79oY8HPJ3SgZHGWGWrQpyJ3fDCfmlYbYyZ1vf5RkdXQIxSn2jVl12pwgr
         pbECq9FNqeXqEr2AooEIeKvPP4ElRzh4L8zcG9/IBX0r0lHRqbuF0iPQjdOmAJb9CIE4
         QaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+URSeXYEOXBiJ55t4947He9Cl/mDKLgzYApsLtKEys=;
        b=x5t7d2ev/1wdrPiaXBrqIEPt+BEcE5AMhjghqI3/OIibh09DwIPjbQVZ4Lf26C3wDf
         X+0I1C5h3W/kJVCkVUCCG6AIvC5+2msYFdBvlz03zkm0MrHMaDxAm02KWWVWZgB3vwHN
         UfvfpXjcbIR3Ojp4COhlHlhCoLnzUWEYgvcZVcoyNRQthH60C9IFxxETEsAYgZg4urGc
         mA+Ut4FBY2PlbYrNZPlKgI/U5C76mEE3k6MELWnpeAOz7RPQEQo1QWNdpEAm0XKdRhq5
         B8ERRPnw4FQLLNj4VGrl4bhu5lYSDMJ/4jik39O1JshLBOHuf4javl+QtG4PZqqRco0q
         nyZw==
X-Gm-Message-State: AOAM531zFbZB+NfCGZGdQk4tgFswYJfGRjiD0If0rK50St0mCh2zBHuI
        lgMvHSxfAV9m7Ff88lPB41+l/tEImwMR0/muLlY=
X-Google-Smtp-Source: ABdhPJy2xecGAk3OItZ8iP+fCoLTW9ULUD8aC3kvuMwE/q7im+5ZdaJTVoobwxMMZh/DtJu+POEQz3VOerLOQp68MWE=
X-Received: by 2002:a54:468b:: with SMTP id k11mr4684506oic.105.1639670596740;
 Thu, 16 Dec 2021 08:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20211215192225.1278237-1-christylee@fb.com> <20211215192225.1278237-3-christylee@fb.com>
 <CAEf4BzZvpODHJ-ca7yifmYBvqw+7ysR5A+HHPVDKHBs8XMzr-A@mail.gmail.com> <CAPqJDZr1AudE2PfbZQarHf0N5i_-xm-zyhfLqS5rogX98UtNLQ@mail.gmail.com>
In-Reply-To: <CAPqJDZr1AudE2PfbZQarHf0N5i_-xm-zyhfLqS5rogX98UtNLQ@mail.gmail.com>
From:   Christy Lee <christyc.y.lee@gmail.com>
Date:   Thu, 16 Dec 2021 08:03:05 -0800
Message-ID: <CAPqJDZqyRLz+Xt77XLfxYbqP3DiEVonBYhhhOCsO4mN-Mc7xQw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/3] Right align verifier states in verifier logs
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

On Thu, Dec 16, 2021 at 7:59 AM Christy Lee <christyc.y.lee@gmail.com> wrote:>

Apologies, resending this because the previous email was not plain text.

>
> On Wed, Dec 15, 2021 at 11:02 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, Dec 15, 2021 at 11:22 AM Christy Lee <christylee@fb.com> wrote:
>> >
>
> [...]
>>
>>
>> There seems to be quite a lot of jumpin back and forth in terms of
>> 33th (see off by one error below) vs 40th offsets (this is for
>> pyperf50 test):
>>
>> 16: (07) r2 += -8               ; R2_w=fp-8
>> ; Event* event = bpf_map_lookup_elem(&eventmap, &zero);
>> 17: (18) r1 = 0xffff88810d81dc00       ;
>> R1_w=map_ptr(id=0,off=0,ks=4,vs=252,imm=0)
>> 19: (85) call bpf_map_lookup_elem#1    ;
>> R0=map_value_or_null(id=3,off=0,ks=4,vs=252,imm=0)
>> 20: (bf) r7 = r0                ;
>> R0=map_value_or_null(id=3,off=0,ks=4,vs=252,imm=0)
>> R7_w=map_value_or_null(id=3,off=0,ks=4,vs=252,imm=0)
>> ; if (!event)
>> 21: (15) if r7 == 0x0 goto pc+5193     ;
>> R7_w=map_value(id=0,off=0,ks=4,vs=252,imm=0)
>> ; event->pid = pid;
>> 22: (61) r1 = *(u32 *)(r10 -4)  ;
>> R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
>>
>> Maybe let's bump the minimum to 40?
>
> Will do! I'll experiment with the nicest looking offset.
>>
>>
>> >
>> > Signed-off-by: Christy Lee <christylee@fb.com>
>
> [...]
>>
>> >
>> > +static u32 vlog_alignment(u32 prev_insn_print_len)
>> > +{
>> > +       if (prev_insn_print_len < BPF_LOG_ALIGNMENT_POS)
>> > +               return BPF_LOG_ALIGNMENT_POS - prev_insn_print_len + 1;
>>
>> why +1 here?
>
> I wanted the insn_state to be prepended by BPF_LOG_ALIGNMENT_POS
> number of characters, in this case, that would be prepended by 32 and starting
> at 33. This ensures that whether prev_insn_print_len is smaller than
> BPF_LOG_ALIGNMENT_POS or not, the insn_states would be aligned properly,
> there would be an off-by-one error otherwise.
>>
>>
>> > +       return round_up(prev_insn_print_len, BPF_LOG_MIN_ALIGNMENT) -
>> > +              prev_insn_print_len;
>> > +}
>> > +
>> > +static void print_prev_insn_state(struct bpf_verifier_env *env,
>> > +                                 const struct bpf_func_state *state)
>> > +{
>> > +       if (env->prev_log_len == env->log.len_used) {
>> > +               if (env->prev_log_len)
>> > +                       bpf_vlog_reset(&env->log, env->prev_log_len - 1);
>>
>> I don't get this... why do we need this reset? Why just appending
>> alignment spaces below doesn't work?
>
> The insn are printed via print_bpf_insn() which ends the line with a '\n', we need to
> reset one character in order to remove the new line and print insn_state on the same
> line. print_bpf_insn() is defined in kernel/bpf/disasm.h and used by bpf_tool as well, so I
> didn't want to modify it.
>>
>>
>> > +               verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_len),
>> > +                       ' ');
>>
>> nit: keep it on single line
>>
>> > +       } else
>> > +               verbose(env, "%d:", env->insn_idx);
>>
>> if one branch of if/else has {}, the other one has to have them as
>> well, even if it's a single line statement
>>
>> > +       print_verifier_state(env, state);
>> > +}
>> > +
>> >  /* copy array src of length n * size bytes to dst. dst is reallocated if it's too
>> >   * small to hold src. This is different from krealloc since we don't want to preserve
>> >   * the contents of dst.
>>
>> [...]
>>
>> > @@ -9441,8 +9465,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>> >                         insn->dst_reg);
>> >                 return -EACCES;
>> >         }
>> > -       if (env->log.level & BPF_LOG_LEVEL)
>> > -               print_verifier_state(env, this_branch->frame[this_branch->curframe]);
>> > +       if (env->log.level & BPF_LOG_LEVEL) {
>> > +               print_prev_insn_state(
>> > +                       env, this_branch->frame[this_branch->curframe]);
>>
>> nit: keep on a single line. But also is it really a "previous
>> instruction" or still a current instruction? Maybe just
>> "print_insn_state"? Do we have "next_insn" helper anywhere? If not,
>> dropping this "prev_" prefix from helpers and variables would be
>> cleaner, IMO
>>
>> > +       }
>> >         return 0;
>> >  }
>> >
>> > @@ -11310,17 +11336,12 @@ static int do_check(struct bpf_verifier_env *env)
>> >                 if (need_resched())
>> >                         cond_resched();
>> >
>> > -               if ((env->log.level & BPF_LOG_LEVEL2) ||
>> > -                   (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
>> > -                       if (verifier_state_scratched(env) &&
>> > -                           (env->log.level & BPF_LOG_LEVEL2))
>> > -                               verbose(env, "%d:", env->insn_idx);
>> > -                       else
>> > -                               verbose(env, "\nfrom %d to %d%s:",
>> > -                                       env->prev_insn_idx, env->insn_idx,
>> > -                                       env->cur_state->speculative ?
>> > -                                       " (speculative execution)" : "");
>> > -                       print_verifier_state(env, state->frame[state->curframe]);
>> > +               if (env->log.level & BPF_LOG_LEVEL1 && do_print_state) {
>>
>> () around bit operations
>>
>> > +                       verbose(env, "\nfrom %d to %d%s:\n", env->prev_insn_idx,
>> > +                               env->insn_idx,
>> > +                               env->cur_state->speculative ?
>> > +                                       " (speculative execution)" :
>> > +                                             "");
>>
>> it's ok to go up to 100 characters, please keep the code more readable
>>
>> >                         do_print_state = false;
>> >                 }
>> >
>> > @@ -11331,9 +11352,17 @@ static int do_check(struct bpf_verifier_env *env)
>> >                                 .private_data   = env,
>> >                         };
>> >
>> > +                       if (verifier_state_scratched(env))
>> > +                               print_prev_insn_state(
>> > +                                       env, state->frame[state->curframe]);
>> > +
>> >                         verbose_linfo(env, env->insn_idx, "; ");
>> > +                       env->prev_log_len = env->log.len_used;
>> >                         verbose(env, "%d: ", env->insn_idx);
>> >                         print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
>> > +                       env->prev_insn_print_len =
>> > +                               env->log.len_used - env->prev_log_len;
>> > +                       env->prev_log_len = env->log.len_used;
>> >                 }
>> >
>> >                 if (bpf_prog_is_dev_bound(env->prog->aux)) {
>>
>> [...]
