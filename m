Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6193E53D6DB
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiFDMvZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jun 2022 08:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiFDMvY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jun 2022 08:51:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D36E366B2
        for <bpf@vger.kernel.org>; Sat,  4 Jun 2022 05:51:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so20683859ejk.5
        for <bpf@vger.kernel.org>; Sat, 04 Jun 2022 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sVsjKrVO8eTEmAtVqutovLAkNG2i3RjyQ6Qbsw0n2oE=;
        b=XnhYl7VT4hTOSK5gDQzQ8bBcgiGC2yxvevjHkp214s1Cq8AgTWv3NrXb+tRHr8C0r2
         s9Shee8wOqqAiuXAbauVqbhCAc/Xfb+fabwzd9GlzFfcsQWzw1KTDQubdNveotoSbZ85
         wkWqms2/9BA813ASKYzsVaOwhUT20cGzBRbGYF78lN8Ga3LPD5DjVcoqt4uDvd1cR+z/
         /+znA5t+6ETfsQymlDzCAUaeyb3Aw0NZXFrZszg9ZSYZXEuoXe/1ywA5Uzw3o2HvEmOK
         yuZoo00hnP83w8HqVFNWMtxBORf6g7EZaMSaujG/om1OIGkYb+NBTIC6RL4apgS/Jcyn
         A13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=sVsjKrVO8eTEmAtVqutovLAkNG2i3RjyQ6Qbsw0n2oE=;
        b=MBCXlHxuljVR2qlnYi7MAuqTGKYFkR8rxo4FFOz1x2+x60/0ile9wvogCUfa6rv1Po
         1jW/DQzBjWZO6i+N2ROyi9GTWNXDLZaiPRzk3DeFZ6FmktRdM8NTCX57CparOzxtxtAu
         EOoigcOmZgKfTUuQ9gONN4pdHolWy0Vp7U19ThqRA8WNV4yjoIviQLa9P3t9GHnYI1xE
         nT2Ba5SK0GYB+7kgKnzViFzJXRjZEcuE+0TjPgmHn/B0BRigN0F70JUmqXXNL3khVeCy
         Mz/NFfsb5CX9fkFE9/iJSMgNIXOiviP4iHoMUxZrZ8I5Ucf0J/1yShJZlXaXKRRV6BhU
         obqg==
X-Gm-Message-State: AOAM532H+R3dk09W6WCZTX6VZLwWPvGpKWeFL6kgsb3s1dFDMajXQfKq
        jYzoQs1QFM6KlcnOhksf63+UVBHg/3Zy8D1b
X-Google-Smtp-Source: ABdhPJx5ZJE2trdtMUiOwC8yLzxD9SVQ1eYecyYx4K9Lc4o76+ZKQgsLKOaTrfTgPOJ0p3tIo4nNaw==
X-Received: by 2002:a17:906:7948:b0:6f7:d5a3:3b91 with SMTP id l8-20020a170906794800b006f7d5a33b91mr13381481ejo.354.1654347081981;
        Sat, 04 Jun 2022 05:51:21 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709064ac900b006f3ef214e20sm3942975ejt.134.2022.06.04.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 05:51:21 -0700 (PDT)
Message-ID: <b6aa2c2c048cab8687bc22eb5ee14820cf6311f9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        song@kernel.org
Date:   Sat, 04 Jun 2022 15:51:19 +0300
In-Reply-To: <CAJnrk1YZB_9WNtUv1yU4VacDuMUSA_iB6=Nc14fR7sw9RadZ2Q@mail.gmail.com>
References: <20220603141047.2163170-1-eddyz87@gmail.com>
         <20220603141047.2163170-4-eddyz87@gmail.com>
         <CAJnrk1YZB_9WNtUv1yU4VacDuMUSA_iB6=Nc14fR7sw9RadZ2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joanne, thanks for the review!

> On Fri, 2022-06-03 at 17:06 -0700, Joanne Koong wrote:
> Should this be moved to include/linux/bpf.h since
> kernel/bpf/bpf_iter.c also uses this? Then we don't need the "#include
> <linux/bpf_verifier.h>" in bpf_iter.c

Will do.

> Also, as a side-note, I think if we have an "is_valid" field, then we
> don't need both the "callback_is_constant" and "flags_is_zero" fields.
> If the flags is not zero or the callback subprogno is not the same on
> each invocation of the instruction, then we could represent that by
> just setting is_valid to false.

Agree, I'll update the declaration as follows:

struct bpf_loop_inline_state {
	bool initialized; /* set to true upon first entry */
	bool can_inline; /* true if callback function
			  * is the same at each call
			  * and flags are always zero */
	u32 callback_subprogno; /* valid when can_inline is true */
	/* stack offset for loop vars;
	 * u16 since bpf_subprog_info.stack_depth is u16;
	 * we take the negative of it whenever we use it
	 * since the stack grows downwards
	 */
	u16 stack_base;
};

> Is placing this inside the union in "struct bpf_insn_aux_data" an option?

This is an option indeed, will do.

> > +
> > +               if (fit_for_bpf_loop_inline(aux)) {
> > +                       if (!subprog_updated) {
> > +                               subprog_updated = true;
> > +                               subprogs[cur_subprog].stack_depth += BPF_REG_SIZE * 3;
> > +                               stack_base = -subprogs[cur_subprog].stack_depth;
> > +                       }
> > +                       aux->loop_inline_state.stack_base = stack_base;
> > +               }
> > +               if (i == subprog_end - 1) {
> > +                       subprog_updated = false;
> > +                       cur_subprog++;
> > +                       if (cur_subprog < env->subprog_cnt)
> > +                               subprog_end = subprogs[cur_subprog + 1].start;
> > +               }
> > +       }
> > +
> > +       env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
> 
> In the case where a subprogram that is not subprogram 0 is a fit for
> the bpf loop inline and thus increases its stack depth, won't
> env->prog->aux->stack_depth need to also be updated?

As far as I understand the logic in `do_check_main` and `jit_subprogs`
`env->prog->aux->stack_depth` always reflects the stack depth of the
first sub-program (aka `env->subprog_info[0].stack_depth`). So the
last line of `adjust_stack_depth_for_loop_inlining` merely ensures
this invariant. The stack depth for each relevant subprogram is
updated earlier in the function:

static void adjust_stack_depth_for_loop_inlining(struct bpf_verifier_env *env)
{
	...
	for (i = 0; i < insn_cnt; i++) {
		...
		if (fit_for_bpf_loop_inline(aux)) {
			if (!subprog_updated) {
				subprog_updated = true;
here  ---->			subprogs[cur_subprog].stack_depth += BPF_REG_SIZE * 3;
				...
			}
			...
		}
		if (i == subprog_end - 1) {
			subprog_updated = false;
			cur_subprog++;
			...
		}
	}
	...
}

Also, the patch v3 4/5 in a series has a test case "bpf_loop_inline
stack locations for loop vars" which checks that stack offsets for
spilled registers are assigned correctly for subprogram that is not a
first subprogram.

> > @@ -15030,6 +15216,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
> >         if (ret == 0)
> >                 ret = check_max_stack_depth(env);
> > 
> > +       if (ret == 0)
> > +               adjust_stack_depth_for_loop_inlining(env);
> 
> Do we need to do this before the check_max_stack_depth() call above
> since adjust_stack_depth_for_loop_inlining() adjusts the stack depth?

This is an interesting question. I used the following reasoning
placing `adjust_stack_depth_for_loop_inlining` after the
`check_max_stack_depth`:

1. If `adjust_stack_depth_for_loop_inlining` is placed before
   `check_max_stack_depth` some of the existing BPF programs might
   stop loading, because of increased stack usage.
2. To avoid (1) it is possible to do `check_max_stack_depth` first,
   remember actual max depth and apply
   `adjust_stack_depth_for_loop_inlining` only when there is enough
   stack space. However there are two downsides:
   - the optimization becomes flaky, similarly simple changes to the
     code of the BPF program might cause loop inlining to stop
     working;
   - the precise verification itself is non-trivial as each possible
     stack trace has to be analyzed in terms of stack size with loop
     inlining / stack size without loop inlining. If necessary, I will
     probably use a simpler heuristic where stack budget for register
     spilling would be computed as
     `MAX_BPF_STACK - actual_max_stack_depth`
3. Things are simpler if MAX_BPF_STACK is a soft limit that ensures
   that BPF programs consume limited amount of stack. In such case
   current implementation is sufficient.

So this boils down to the question what is `MAX_BPF_STACK`:
- a hard limit for the BPF program stack size?
- a soft limit used to verify that programs consume a limited amount
  of stack while executing?

If the answer is "hard limit" I'll proceed with implementation for
option (2).

Thanks,
Eduard

