Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2036DA656
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjDFXyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 19:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjDFXyI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:54:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2806A9748
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:54:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e18so41004481wra.9
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680825245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpgIrgXDKr7mYg657t1IZTUwOa1v/O9NHLLvRs1T5EE=;
        b=XGw0NFEjCUWYQ8Pl3k09rGtpOhBQ1j9EYPBoDuH/ey4Uv4mABaPLARUOLV57QEfOyC
         hmcf/+/xa1/olflr0nFEn0YgxzwQv28Eft+fNmkv+y8xRsXrfcvxJxRH1tQj84eQpF/n
         OctUWf/ECKAln/KX/AyC1KdIDU4goZOpYD+5TMkhUhG5hlRZ9YGR+PouPV0CallTs8wT
         UnCAUKD9zhzO/ByAPCC/53DVfUPtjD7mYX0ZDCvyY3y6CerCGNtEx8d56Yv/u7JUbwIb
         LWIAbnFrsu2finCvgv4RWKgSx4GK09sODz0qavz3Jfo3nEYMs7hvWtOI38FdJxw82CG9
         Hprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpgIrgXDKr7mYg657t1IZTUwOa1v/O9NHLLvRs1T5EE=;
        b=XzZ+aQ8lF/L2VZ3YykWBSNm6V1yWjagVrgpgS6sWzhQZQRZgVH1DMKeCy4DUO/BsT+
         JbLerxM1WnJLQSiDqbI/q7q/lFGWlFB8fec8WcpfrflHdI4UIvK9qgvffZsIurkBTv4T
         5y7SGQcUc7JaE4tMkVHkgRTlKu2mYuG6HHo/PgddAEKiFcuptz+eLj9ZmUbKnKhxUj+W
         XSdsbkdOKjz29wY0EhuAokk+Kr6K/PC+EOENPdWFcto+s78HotD4U3qyQcHNQqF24nEh
         UrSh9bpTMyAwLCB0lQh4mcdJs+YohhWdPrT5I6/zDkSOFK0MGVA35f6zPtJdrac5oUHD
         I0wQ==
X-Gm-Message-State: AAQBX9fkSPjm3rsHtQ0Cxi1iMuGZSSNY0DIBxzSpeA/nViNJfxCuh89T
        QHHKBu7CfxMgKpBq4rlIsEiOZ665hxU2/Q==
X-Google-Smtp-Source: AKy350a9hSZN1y0YBUJrCuhM4ty/IcPPvyI8+R6kMe+CQQjOhGZJ8vPkZmHeE/ZeWTy8WqTlZi9D2w==
X-Received: by 2002:a05:6000:1b81:b0:2d7:3d7c:19cb with SMTP id r1-20020a0560001b8100b002d73d7c19cbmr126353wru.4.1680825245334;
        Thu, 06 Apr 2023 16:54:05 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d60cd000000b002efabde5609sm904956wrt.92.2023.04.06.16.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 16:54:04 -0700 (PDT)
Date:   Fri, 7 Apr 2023 01:54:03 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 3/9] bpf: Implement bpf_throw kfunc
Message-ID: <xmehxhdk4ba2j75ltdygzi2b56aftcei36dndptg3v6gdumrh2@zadr5xdn5g3m>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-4-memxor@gmail.com>
 <20230406021622.xbgzrmfjxli6dkpt@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406021622.xbgzrmfjxli6dkpt@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 06, 2023 at 04:16:22AM CEST, Alexei Starovoitov wrote:
> On Wed, Apr 05, 2023 at 02:42:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> >
> > - The exception state is represented using four booleans in the
> >   task_struct of current task. Each boolean corresponds to the exception
> >   state for each kernel context. This allows BPF programs to be
> >   interrupted and still not clobber the other's exception state.
>
> that doesn't work for sleepable bpf progs and in RT for regular progs too.
>

Can you elaborate? If a sleepable program blocks, that means the task is
scheduled out, so the next program will use the other task's task_struct.
Same for preemption for normal progs (under RT or not).

Is there something else that I'm missing?

> > - The other vexing case is of recursion. If a program calls into another
> >   program (e.g. call into helper which invokes tracing program
> >   eventually), it may throw and clobber the current exception state. To
> >   avoid this, an invariant is maintained across the implementation:
> > 	Exception state is always cleared on entry and exit of the main
> > 	BPF program.
> >   This implies that if recursion occurs, the BPF program will clear the
> >   current exception state on entry and exit. However, callbacks do not
> >   do the same, because they are subprograms. The case for propagating
> >   exceptions of callbacks invoked by the kernel back to the BPF program
> >   is handled in the next commit. This is also the main reason to clear
> >   exception state on entry, asynchronous callbacks can clobber exception
> >   state even though we make sure it's always set to be 0 within the
> >   kernel.
> >   Anyhow, the only other thing to be kept in mind is to never allow a
> >   BPF program to execute when the program is being unwinded. This
> >   implies that every function involved in this path must be notrace,
> >   which is the case for bpf_throw, bpf_get_exception and
> >   bpf_reset_exception.
>
> ...
>
> > +			struct bpf_insn entry_insns[] = {
> > +				BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
> > +				BPF_EMIT_CALL(bpf_reset_exception),
> > +				BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> > +				insn[i],
> > +			};
>
> Is not correct in global bpf progs that take more than 1 argument.
>

But this is not done for global subprogs, only for the main subprog, it only
needs to be done when we enter the program from the kernel.

> How about using a scratch space in prog->aux->exception[] instead of current task?
>

I actually had this thought. It's even better because we can hardcode the
address of the exception state right in the program (since prog->aux remains
stable during bpf_patch_insn_data). However, concurrent program invocations on
multiple CPUs doesn't work well with this. It's like, one program sets the state
while the other tries to check it. It can be per-CPU but then we have to disable
preemption (which cannot be done).

Unfortunately per-task state seemed like the only choice which works without
complicating things too much.

> > +notrace u64 bpf_get_exception(void)
> > +{
> > +	int i = interrupt_context_level();
> > +
> > +	return current->bpf_exception_thrown[i];
> > +}
>
> this is too slow to be acceptable.

I agree, also partly why I still marked this an RFC.

> it needs to be single load plus branch.
> with prog->aux->exception approach we can achieve that.
> Instead of inserting a call to bpf_get_exception() we can do load+cmp.
> We probably should pass prog->aux into exception callback, so it
> can know where throw came from.
>

IMO prog->aux->exception won't work either (unless I'm missing some way which
you can point out). The other option would be that we spill pointer to the
per-task exception state to the program's stack on entry, and then every check
loads the value and performs the check. It will be a load from stack, load from
memory and then a jump instruction. Still not as good as a direct load though,
which we'd have with prog->aux, but much better than the current state.

> > - Rewrites happen for bpf_throw and call instructions to subprogs.
> >   The instructions which are executed in the main frame of the main
> >   program (thus, not global functions and extension programs, which end
> >   up executing in frame > 0) need to be rewritten differently. This is
> >   tracked using BPF_THROW_OUTER vs BPF_THROW_INNER. If not done, a
>
> how about BPF_THROW_OUTER vs BPF_THROW_ANY_INNER ?
> would it be more precise ?

I'm fine with the renaming. The only thing the type signifies is if we need to
do the rewrite for frame 0 vs frame N.

>
> > +__bpf_kfunc notrace void bpf_throw(void)
> > +{
> > +	int i = interrupt_context_level();
> > +
> > +	current->bpf_exception_thrown[i] = true;
> > +}
>
> I think this needs to take u64 or couple u64 args and store them
> in the scratch area.
> bpf_assert* macros also need a way for bpf prog to specify
> the reason for the assertion.
> Otherwise there won't be any way to debug what happened.

I agree. Should we force it to be a constant value? Then we can hardcode it in
the .text without having to save and restore it, but that might end up being a
little too restrictive?
