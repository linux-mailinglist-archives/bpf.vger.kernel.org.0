Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC96DA7D3
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 04:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjDGCrJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 22:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbjDGCrC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 22:47:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E171171C
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 19:46:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v1so41228511wrv.1
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 19:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680835618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8F6Kg6dKzJGta8eDJAlNzr0ZdMQGZQvSILDwoR+XB5M=;
        b=Hc+CLpU4/GOb4tNcuRs3VGG9AiC0tDJthqwPFKqsL3EvPFUvxkc5WjXvOoy3nTThZQ
         ePSY1Kh5oCh1F4pauqajX2uqsDF7nwx1Tu2dNjsT4Mmz6nGIiIdp0zRleeFQGl0v8IqG
         CLTGdl55L8+5HikgQfvhDF0ss6ncctre9EPMv8FhST8ELE6e9Xr3Lrp84SRIHUWnSFWd
         Iaznov5ATjsb0voFMMnJCHNLkD2n9qzp6Ood8saEZ2fB+Rk2VMjXcl8M5g+gmiOL0Z2c
         6i2qP9xE0/Snsn6YLpUzHvyy7gFHMqqDHvBorOKeMjVLwBZCga2F1655D7DWjIdDJJZ7
         +Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680835618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F6Kg6dKzJGta8eDJAlNzr0ZdMQGZQvSILDwoR+XB5M=;
        b=6NPu5DVtzeN/V8gpujZpKbEB/NF+JBkQohg8UkQFSACSMzQ73IU2VJE6tY6lTmJsjZ
         wbORlivl5Pg9G8n8seUEyreSbqalxwltDFYv8RQHBWbCf89hN5SXakOWgEHTluOcRmNx
         n/pLV/02Fh85dn+fMjgBmZ22wA60xyM5Qd7ntTV7T7EsBy/9RE19okrkFFYK/hFqFq87
         2Gqeqr9DXaHQZiofa3x4bbT1T1qze7iMLd1MXtnDT39pBn7hNDVNWteP5qrTkKlu8cyA
         yjDg3FRCEUp6Sge/+T93w5Qj9lk/RQuglwnNTLnUaTCbmbdMCBuAkgHByRP8hH6UNC92
         gspA==
X-Gm-Message-State: AAQBX9fi8/OAqxtAOZKIfHdIZ/57JFpf/Lc998cpotU+vQBUg9BEkldM
        Kuy6Cn47/cAgmqmRJSn6XWG/1tTspKpsVA==
X-Google-Smtp-Source: AKy350Y2AAoZF5595XisGh802wLF908qf3MlwR3CwPB7KN+Oa9kD1Z81Hfya4n+CU12AcS+nxM8jmg==
X-Received: by 2002:adf:fa09:0:b0:2ce:adda:f45a with SMTP id m9-20020adffa09000000b002ceaddaf45amr230816wrr.62.1680835617598;
        Thu, 06 Apr 2023 19:46:57 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id h8-20020a056000000800b002d431f61b18sm3181363wrx.103.2023.04.06.19.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:46:56 -0700 (PDT)
Date:   Fri, 7 Apr 2023 04:46:55 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 3/9] bpf: Implement bpf_throw kfunc
Message-ID: <bykk75ofgzxtmcpbvebju3mdp2jumt27mhfrvk4ysbkfotu2dv@3vd7vm352kp7>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-4-memxor@gmail.com>
 <20230406021622.xbgzrmfjxli6dkpt@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <xmehxhdk4ba2j75ltdygzi2b56aftcei36dndptg3v6gdumrh2@zadr5xdn5g3m>
 <20230407021136.dmq42wum3wzhq4bu@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407021136.dmq42wum3wzhq4bu@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 04:11:36AM CEST, Alexei Starovoitov wrote:
> On Fri, Apr 07, 2023 at 01:54:03AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Thu, Apr 06, 2023 at 04:16:22AM CEST, Alexei Starovoitov wrote:
> > > On Wed, Apr 05, 2023 at 02:42:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > >
> > > > - The exception state is represented using four booleans in the
> > > >   task_struct of current task. Each boolean corresponds to the exception
> > > >   state for each kernel context. This allows BPF programs to be
> > > >   interrupted and still not clobber the other's exception state.
> > >
> > > that doesn't work for sleepable bpf progs and in RT for regular progs too.
> > >
> >
> > Can you elaborate? If a sleepable program blocks, that means the task is
> > scheduled out, so the next program will use the other task's task_struct.
> > Same for preemption for normal progs (under RT or not).
>
> I was worried about the case of the same task but different code paths
> in the kernel with tracing prog stepping on preempted lsm.s prog.
> I think you point that in this case they gotta be in different interrupt_context_level.
> I need to think it through a bit more.
>

If there is nesting, the programs always clear their exception state on exit, so
the prog that calls into the kernel which then calls into the tracing prog etc.
won't see its exception state on return. The only path where attaching programs
would screw things up is when we see a thrown exception and start unwinding
(where clearing would be a problem since its done frame-by-frame). For that, I
already prevent _throwing_ fexit programs from attaching to subprogs in this
series (normal ones are still ok and supported, because fentry/fexit is
important for stats etc.). There might be some other corner cases I missed but
ensuring this property alone in general should make things work correctly.

> > > How about using a scratch space in prog->aux->exception[] instead of current task?
> > >
> >
> > I actually had this thought. It's even better because we can hardcode the
> > address of the exception state right in the program (since prog->aux remains
> > stable during bpf_patch_insn_data).
>
> exactly.
>
> > However, concurrent program invocations on
> > multiple CPUs doesn't work well with this. It's like, one program sets the state
> > while the other tries to check it.
>
> Right. If it asserts on one cpu all other cpus will unwind as well,
> since we're saying bpf_assert is for exceptions when user cannot convince
> the verifier that the program is correct.
> So it doesn't matter that it aborted everywhere. It's probably a good thing too.
>

We can discuss the semantics (this makes bpf_assert more stronger and basically
poisons the program globally in some sense), but implementation wise it's going
to be a lot more tricky to reason about correctness.

Right now, the verifier follows paths and knows what resources are held when we
throw from a nested call chain (to complain on leaks). Callers doing the check
for exception state at runtime expect only certain throwing points to trigger
the check and rely on that for leak freedom.

With a global prog->aux->exception, things will be ok for the CPU on which the
exception was thrown, but some other CPU will see the check returning true in a
caller even if the callee subprog for it did not throw and was possibly
transferring its acquired references to the caller after completing execution,
which now causes leaks (because subprogs are allowed to acquire and return to
their caller).

The way to handle this would be that we assume every callee which throws may
also notionally throw right when returning (due to some other CPU's throw which
we may see). Then every exit from throwing callees may be processed as throwing
if we see the global state as set.

However, this completely prevents subprogs from transferring some acquired
resource to their caller (which I think is too restrictive). If I'm acquiring
memory from static subprog and returning to my caller, I can't any longer since
I notionally throw when exiting and holding resources when doing bpf_throw is
disallowed, so transfer is out of the question.

In the current scenario it would work, because I threw early on in my subprog
when checking some condition (or proving something to the verifier) and after
that just chugged along and did my work.

> > It can be per-CPU but then we have to disable
> > preemption (which cannot be done).
>
> I was thinking to propose a per-cpu prog->aux->exception[] area.
> Sleepable and not are in migrate_disable(). bpf progs never migrate.
> So we can do it, but we'd need new pseudo this_cpu_ptr instruction and
> corresponding JIT support which felt like overkill.
>
> Another idea I contemplated is to do preempt_disable() and local_irq_save()
> into special field in prog->aux->exception first thing in bpf_throw()
> and then re-enable everything before entering exception cb.
> To avoid races with other progs, but NMI can still happen, so it's pointless.
> Just non-per-cpu prog->aux->exception seems good enough.
>
> > > > - Rewrites happen for bpf_throw and call instructions to subprogs.
> > > >   The instructions which are executed in the main frame of the main
> > > >   program (thus, not global functions and extension programs, which end
> > > >   up executing in frame > 0) need to be rewritten differently. This is
> > > >   tracked using BPF_THROW_OUTER vs BPF_THROW_INNER. If not done, a
> > >
> > > how about BPF_THROW_OUTER vs BPF_THROW_ANY_INNER ?
> > > would it be more precise ?
> >
> > I'm fine with the renaming. The only thing the type signifies is if we need to
> > do the rewrite for frame 0 vs frame N.
>
> Sure. BPF_THROW_FRAME_ZERO and BPF_THROW_FRAME_NON_ZERO also works.
> Or any name that shows that 2nd includes multiple cases.
>

Ack.

> > >
> > > > +__bpf_kfunc notrace void bpf_throw(void)
> > > > +{
> > > > +	int i = interrupt_context_level();
> > > > +
> > > > +	current->bpf_exception_thrown[i] = true;
> > > > +}
> > >
> > > I think this needs to take u64 or couple u64 args and store them
> > > in the scratch area.
> > > bpf_assert* macros also need a way for bpf prog to specify
> > > the reason for the assertion.
> > > Otherwise there won't be any way to debug what happened.
> >
> > I agree. Should we force it to be a constant value? Then we can hardcode it in
> > the .text without having to save and restore it, but that might end up being a
> > little too restrictive?
>
> with prog->aux->exception approach run-time values works too.
