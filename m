Return-Path: <bpf+bounces-56864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD0FA9F977
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 21:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4885A2C3B
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB257296D30;
	Mon, 28 Apr 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPg92QrL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E826ACD
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868390; cv=none; b=Q4W02ZIycDk4RDVzR6KkuIEc4WkJYI54T4hBmSZq3sd+7FeTPrZWttsAJsZNiSVncI0QRXx8DqViKUq1Loh4H3jVmEe5hRnsUTu/FfLGSTUoPcTSWkTNVU/2KeuweLfru7e/lWpXqYbKQWHOzVFzX9Jr84w2ecabHpiIcHo8eCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868390; c=relaxed/simple;
	bh=bvSPsLzC9cttKZCTX66Wj+/WxqdGhhY0oa1q3qCBgj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnKafOXaNU/eW22REZij3Iux/q8QNybLGeTIAgP3ZcT2pRkgZWGs6qhkZXwl05whUI5033RZMGrHr516jbEBW+lUtwQcZQgnBDiuFpohUq1EI1wDCr+U/FaF3OgpA8tf7ucZT+E+Ca1vorb3XvRinWrvkD5GeMbh9HHgTcbk+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPg92QrL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223f4c06e9fso45351025ad.1
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745868388; x=1746473188; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYwq0/Kb675uuE13bq5/Rpy4747+98czZI08JB1j9kI=;
        b=cPg92QrL8ggvk/02lAMNhG2jH0fYEemomMNJyU7pbAScq/O8h3mpKFH3cUBcKmSNl5
         45CPa3QtnLTZWm9qYLE0VCxnJgsrlc8l2ctXgWZ4Qak1JX704X9sNlwkx1SEaP4FnUWR
         4wxW8boinhaImrCTzf7sOKn5xd0yNy9cInk0IBCeCVirGx5LOsV39jY7C/sp4gp9oPrH
         iS43ejn1wyY/tPp+X4yABU36LyA9dDEKIBWWkikoZXvYutPSXFXIT1GsixhEoioYrvKs
         bzPSezVhp6t2/4/9YSKc3cQvDRcEIEMMyY/ZEoLb1pesBkK9p33o0pYH5vmlTy3TDf16
         zW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745868388; x=1746473188;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYwq0/Kb675uuE13bq5/Rpy4747+98czZI08JB1j9kI=;
        b=mxFGrAeoddqATkMCy13W5PABqfdWC4r3uvCTuqRPaTIhRpAA1ara15ftj7ptubrty1
         wqv5KiL3lM+JUAge8C5eAXq3iH39cTvtd2iZ6UdSDr2nggN5G3sFKoYL0sTOnucxstke
         0qs5LXtkULzQp3bF10D8ShUJ7yAZ8gD+smW4K6UuNV7OENODPm4TUwia9cV7Ixzlb0Yj
         GRcqr1ruxtsznZh//wBGb+/ewURSBmp97keLEubhnY6f6cnUiIET5P06dZ5zI+y2McIN
         oQYTdkwOjcGq3PZ0eyby4u9euXiwLxq0SODogk6I4cdLVV5yHUy9lB/ArKP8DKy1IXK9
         dnyA==
X-Gm-Message-State: AOJu0YzW87m9CWYiCZYajO4Xc/tObS0JT9XjbJeN2UTqmnPLoBahZWAs
	ELjp+A6K/6NEQy5EfDUtitw8iHTi2FMwpDN7pWsWqEEHbs0A3D78
X-Gm-Gg: ASbGncvxK8ek2fi5UGz2hbF/kRPem2DPgorDGVTiceZRUOqahjUDRe0Pr0Qlvl/gRWz
	3ElvqznT1eO3QYjt9tjxE2avKhTuPQ/0ZuWNpAMgjDOmrZ/Ia0dTMGGnOHAwDbpHhAoGVnax28a
	BVZMpCWPs5PpRuBDVAK5UKcjR+njNIqTWF65Kk8YK3XpbZPkdfiSyCBRg0fFsJOU09Q8F7cG3nR
	CMT41X6BDYu/8BTzIK7QjDcW5YmGSk4bkGzNHWpku8FyJyYnFf0QF+gXZLXlfUJhWcUshd5ATeX
	nRO15BEpTCU7h188x1AkUd4eG7JsdKJ3lPLg62/2aPjYe53tMQ==
X-Google-Smtp-Source: AGHT+IEQtGpzAYc9PCOO0+lFTyJFPwc43kZjT53xFHFyATyqQSBExcFRpNFbFxHnechzGPOWOda+5w==
X-Received: by 2002:a17:902:d4ca:b0:223:517a:d5a9 with SMTP id d9443c01a7336-22de6c0cb6dmr5770005ad.15.1745868387685;
        Mon, 28 Apr 2025 12:26:27 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:6628])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7636sm87246995ad.117.2025.04.28.12.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 12:26:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Kernel Team
 <kernel-team@fb.com>,  Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: use SCC info instead of loop_entry
In-Reply-To: <CAADnVQK1tP1_of=pn7HdeZNqmPu=4AqpRETeOVeQMjDfSt0NOw@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 28 Apr 2025 10:31:20 -0700")
References: <20250426104634.744077-1-eddyz87@gmail.com>
	<20250426104634.744077-4-eddyz87@gmail.com>
	<CAADnVQK1tP1_of=pn7HdeZNqmPu=4AqpRETeOVeQMjDfSt0NOw@mail.gmail.com>
Date: Mon, 28 Apr 2025 12:26:25 -0700
Message-ID: <m2plgwjdem.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

[...]

>> @@ -466,11 +456,10 @@ struct bpf_verifier_state {
>>         u32 dfs_depth;
>>         u32 callback_unroll_depth;
>>         u32 may_goto_depth;
>> -       /* If this state was ever pointed-to by other state's loop_entry field
>> -        * this flag would be set to true. Used to avoid freeing such states
>> -        * while they are still in use.
>> +       /* If this state is a checkpoint at insn_idx that belongs to an SCC,
>> +        * record the SCC epoch at the time of checkpoint creation.
>>          */
>
> Please use normal kernel comment style for all new code:
> /*
>  * multi-
>  * line
>  * comment
>  */
>

Ack.

>> -       u32 used_as_loop_entry;
>> +       u32 scc_epoch;
>>  };
>>
>>  #define bpf_get_spilled_reg(slot, frame, mask)                         \
>> @@ -717,6 +706,29 @@ struct bpf_idset {
>>         u32 ids[BPF_ID_MAP_SIZE];
>>  };
>>
>> +/* Information tracked for CFG strongly connected components */
>> +struct bpf_scc_info {
>> +       /* True if states_equal(... RANGE_WITHIN) ever returned
>> +        * true for a state with insn_idx within this SCC.
>> +        * E.g. for iterator next call.
>
> I feel RANGE_WITHIN is unnecessary information here.
> Maybe reword it as:
> Set to true when is_state_visited() detected convergence of open coded iterator.
> ?

Technically this could also happen for callbacks, e.g. for bpf_loop().
Will reword as you suggest, should be clear enough for a few people
working with this code.

[...]

>> @@ -18222,15 +18129,17 @@ static void clean_func_state(struct bpf_verifier_env *env,
>>         }
>>  }
>>
>> +static bool verifier_state_cleaned(struct bpf_verifier_state *st)
>> +{
>> +       /* all regs in this state in all frames were already marked */
>> +       return st->frame[0]->regs[0].live & REG_LIVE_DONE;
>> +}
>
> move refactor into pre-patch.
>

Ack.

[...]

>> @@ -18243,6 +18152,114 @@ static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
>>                : st->frame[frame + 1]->callsite;
>>  }
>>
>> +/* Open coded iterators introduce loops in the verifier state graph.
>> + * State graph loops can result in incomplete read and precision marks
>> + * on individual states. E.g. consider the following states graph:
>> + *
>> + *  .-> A --.  Assume the states are visited in the order A, B, C.
>> + *  |   |   |  Assume that state B reaches a state equivalent to state A.
>> + *  |   v   v  At this point, state C has not been processed yet,
>> + *  '-- B   C  so state A does not have any read or precision marks from C yet.
>> + *             As a result, these marks won't be propagated to B.
>> + *
>> + * If the marks on B are incomplete, it would be unsafe to use it in
>> + * states_equal() checks.
>
> earlier RANGE_WITHIN distinction was unnecessary,
> but here we should clarify that
> states_equal(NOT_EXACT) is unsafe,
> while states_equal(RANGE_WITHIN) is fine.
> Right?
>

Ack.

>> + *
>> + * To avoid this safety issue, and since states with incomplete read
>> + * marks can only occur within control flow graph loops, the verifier
>> + * assumes that any state with bpf_verifier_state->insn_idx residing
>> + * in a strongly connected component (SCC) has read and precision
>> + * marks for all registers. This assumption is enforced by the
>> + * function mark_all_regs_read_and_precise(), which assigns
>> + * corresponding marks.
>> + *
>> + * An intuitive point to call mark_all_regs_read_and_precise() would
>> + * be when a new state is created in is_state_visited().
>> + * However, doing so would interfere with widen_imprecise_scalars(),
>> + * which widens scalars in the current state after checking registers in a
>> + * parent state. Registers are not widened if they are marked as precise
>> + * in the parent state.
>> + *
>> + * To avoid interfering with widening logic,
>> + * a call to mark_all_regs_read_and_precise() for state is postponed
>> + * until no widening is possible in any descendant of state S.
>> + *
>> + * Another intuitive spot to call mark_all_regs_read_and_precise()
>> + * would be in update_branch_counts() when S's branches counter
>> + * reaches 0. However, this falls short in the following case:
>> + *
>> + *     sum = 0
>> + *     bpf_repeat(10) {                              // a
>> + *             if (unlikely(bpf_get_prandom_u32()))  // b
>> + *                     sum += 1;
>> + *             if (bpf_get_prandom_u32())            // c
>> + *                     asm volatile ("");
>> + *             asm volatile ("goto +0;");            // d
>> + *     }
>> + *
>> + * Here a checkpoint is created at (d) with {sum=0} and the branch counter
>> + * for (d) reaches 0, so 'sum' would be marked precise.
>> + * When second branch of (c) reaches (d), checkpoint would be hit,
>> + * and the precision mark for 'sum' propagated to (a).
>> + * When the second branch of (b) reaches (a), the state would be {sum=1},
>> + * no widening would occur, causing verification to continue forever.
>> + *
>> + * To avoid such premature precision markings, the verifier postpones
>> + * the call to mark_all_regs_read_and_precise() for state S even further.
>> + * Suppose state P is a [grand]parent of state S and is the first state
>> + * in the current state chain with state->insn_idx within current SCC.
>> + * mark_all_regs_read_and_precise() for state S is only called once P
>> + * is fully explored.
>> + *
>> + * The struct 'bpf_scc_info' is used to track this condition:
>> + * - bpf_scc_info->branches counts how many states currently
>> + *   in env->cur_state or env->head originate from this SCC;
>
> I'm still struggling with this definition of scc_info->branches
> and this extra 'enter':
>
>>         cur->insn_hist_start = cur->insn_hist_end;
>>         cur->dfs_depth = new->dfs_depth + 1;
>>         list_add(&new_sl->node, head);
>> +       parent_scc_enter(env, env->cur_state);
>
> since we don't do it for st->branches.
>
> Can we make scc->branches symmetrical to st->branches ?
> Only push_stack() will do scc_enter(),
> and scc_exit() in update_branch_counts()
> even if st->branches > 0.
>
> If that's not possible let's pick a different name for scc_info->branches
> to make it clear that the logic is quite different to st->branches.
>

It is simmetrical in a way.

Operations on bpf_verifier_state->branches:
- do_check_common() initializes env->cur_state->branches == 1
  (and this is maintained as invariant);
- push_stack() does env->cur_state->parent->branches++;
- update_branch_counts() does env->cur_state->parent->branches--
  (and continues recursively).

Operations on bpf_scc_info->branches:
- is_state_visited() does insn_scc(env->cur_state->parent->insn_idx)->branches++
- push_stack() does insn_scc(env->cur_state->parent->insn_idx)->branches++;
- update_branch_counts() does
  insn_scc(env->cur_state->parent->insn_idx)->branches--
  (and continues recursively);

The main difference is that bpf_verifier_state->branches is initialized to 1,
while bpf_scc_info->branches is initialized to 0.
Hence a call to parent_scc_enter() in is_state_visited().

>> + * - bpf_scc_info->scc_epoch counts how many times 'branches'
>> + *   has reached zero;
>> + * - bpf_verifier_state->scc_epoch records the epoch of the SCC
>> + *   corresponding to bpf_verifier_state->insn_idx at the moment
>> + *   of state creation.
>> + *
>> + * Functions parent_scc_enter() and parent_scc_exit() maintain the
>> + * bpf_scc_info->{branches,scc_epoch} counters.
>> + *
>> + * bpf_scc_info->branches reaching zero indicates that state P is
>> + * fully explored. Its descendants residing in the same SCC have
>> + * state->scc_epoch == scc_info->scc_epoch. parent_scc_exit()
>> + * increments scc_info->scc_epoch, allowing clean_live_states() to
>> + * detect these states and apply mark_all_regs_read_and_precise().
>> + */

