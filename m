Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8828D6E1323
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 19:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDMRGF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 13:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDMRGE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 13:06:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEDC59EB
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 10:06:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ud9so38932973ejc.7
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681405561; x=1683997561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5ueXmIZkDkQUDZhRZRSTzJ+gsx/ixfp/eu+AXzndMU=;
        b=SM0n9+O5ariCdFLz5rYQDCo2AlPvB60PffoRwRj7yuBPtKrjmH3XDUJ5wBk9bsLFsS
         Q6f3BvxQaJ17ep4YeuoOYK3nLh3WvMo2ex/+XYHcKmuLzZVDKV3x3nPeazGKdeurtCTb
         i65QMZzFrYSy8JQy6WcEwZylpWw1wsFXMM2v+34AThZp2M2LLTJo/DW/+lx1Ebj8gIL7
         i0GWJ8LotHFPCeDu6ClymlcTYFCKM17GMIbvDFG4ZcuWWQBYsXkDWeXAUnL8se3L3o2l
         TAR3jUk74rqAABx1l5UJYDntfUMbe2H/DuF/03QWEDIsS7a8XftaP74WDQnZqp+h2iin
         OKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405561; x=1683997561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5ueXmIZkDkQUDZhRZRSTzJ+gsx/ixfp/eu+AXzndMU=;
        b=LoBjQPxXAj5Mr9IWMUxgOscdFrXdT+4dWsj3qwbi9EWYJJnGJHFWWHDjB2NSajqhWt
         z20wDcV+GV9vk61bCyBuOqtcswBVnQ1O8+DJk1K588LTLXVyhC8CB8JKkwEQ+/eDRovg
         gs3QTuLKbaJ/yCpk+wZjKPPcdJz/Nve8UFVQeTr8KqvXuQczxhJVNvKgU+06lJRMTemx
         kZJdRi2yN+ntABx7ClRIrdr7klzeSQq/nu598QEiZFRbh1N8Kiwxi/RKl0b2ilNBD72q
         znQSr+VyWpurunixeYrLk7g3LTIvDgcHgEpW/ZUNzKlJkptE53hvkwbQk8KCLXRmKRMz
         Rb/w==
X-Gm-Message-State: AAQBX9dsaNyLnZS4+u6uUK6fpWMMQZjCGdyAmKIuXPtsAyFw8wqjKc1H
        /AhuyxtDrSgJlTxTWu5z/iIgVqz8XeHj+w==
X-Google-Smtp-Source: AKy350Zskr9iM5glFIzvpo6LT9lO117847vpYGctszyfmJN235HvrPVyYkIEUhCNrvTnUmkBe1fneQ==
X-Received: by 2002:a17:907:9873:b0:94e:887f:a083 with SMTP id ko19-20020a170907987300b0094e887fa083mr3393126ejc.57.1681405561283;
        Thu, 13 Apr 2023 10:06:01 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id v3-20020a170906338300b0093120a11a5dsm1233862eja.92.2023.04.13.10.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 10:06:00 -0700 (PDT)
Date:   Thu, 13 Apr 2023 19:05:59 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 3/9] bpf: Implement bpf_throw kfunc
Message-ID: <6fqtzhptgwzv35orfpgbisoclsr6uxrombphrsneqk5n4zjamg@jjuncmnoalmu>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-4-memxor@gmail.com>
 <20230406021622.xbgzrmfjxli6dkpt@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <xmehxhdk4ba2j75ltdygzi2b56aftcei36dndptg3v6gdumrh2@zadr5xdn5g3m>
 <20230407021136.dmq42wum3wzhq4bu@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <bykk75ofgzxtmcpbvebju3mdp2jumt27mhfrvk4ysbkfotu2dv@3vd7vm352kp7>
 <20230412193612.neaz7i7whrk3i5f2@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412193612.neaz7i7whrk3i5f2@macbook-pro-6.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 09:36:12PM CEST, Alexei Starovoitov wrote:
> On Fri, Apr 07, 2023 at 04:46:55AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Fri, Apr 07, 2023 at 04:11:36AM CEST, Alexei Starovoitov wrote:
> > > On Fri, Apr 07, 2023 at 01:54:03AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > On Thu, Apr 06, 2023 at 04:16:22AM CEST, Alexei Starovoitov wrote:
> > > > > On Wed, Apr 05, 2023 at 02:42:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > >
> > > > > > - The exception state is represented using four booleans in the
> > > > > >   task_struct of current task. Each boolean corresponds to the exception
> > > > > >   state for each kernel context. This allows BPF programs to be
> > > > > >   interrupted and still not clobber the other's exception state.
> > > > >
> > > > > that doesn't work for sleepable bpf progs and in RT for regular progs too.
> > > > >
> > > >
> > > > Can you elaborate? If a sleepable program blocks, that means the task is
> > > > scheduled out, so the next program will use the other task's task_struct.
> > > > Same for preemption for normal progs (under RT or not).
> > >
> > > I was worried about the case of the same task but different code paths
> > > in the kernel with tracing prog stepping on preempted lsm.s prog.
> > > I think you point that in this case they gotta be in different interrupt_context_level.
> > > I need to think it through a bit more.
> > >
> >
> > If there is nesting, the programs always clear their exception state on exit, so
> > the prog that calls into the kernel which then calls into the tracing prog etc.
> > won't see its exception state on return. The only path where attaching programs
> > would screw things up is when we see a thrown exception and start unwinding
> > (where clearing would be a problem since its done frame-by-frame). For that, I
> > already prevent _throwing_ fexit programs from attaching to subprogs in this
> > series (normal ones are still ok and supported, because fentry/fexit is
> > important for stats etc.). There might be some other corner cases I missed but
> > ensuring this property alone in general should make things work correctly.
> >
> > > > > How about using a scratch space in prog->aux->exception[] instead of current task?
> > > > >
> > > >
> > > > I actually had this thought. It's even better because we can hardcode the
> > > > address of the exception state right in the program (since prog->aux remains
> > > > stable during bpf_patch_insn_data).
> > >
> > > exactly.
> > >
> > > > However, concurrent program invocations on
> > > > multiple CPUs doesn't work well with this. It's like, one program sets the state
> > > > while the other tries to check it.
> > >
> > > Right. If it asserts on one cpu all other cpus will unwind as well,
> > > since we're saying bpf_assert is for exceptions when user cannot convince
> > > the verifier that the program is correct.
> > > So it doesn't matter that it aborted everywhere. It's probably a good thing too.
> > >
> >
> > We can discuss the semantics (this makes bpf_assert more stronger and basically
> > poisons the program globally in some sense), but implementation wise it's going
> > to be a lot more tricky to reason about correctness.
> >
> > Right now, the verifier follows paths and knows what resources are held when we
> > throw from a nested call chain (to complain on leaks). Callers doing the check
> > for exception state at runtime expect only certain throwing points to trigger
> > the check and rely on that for leak freedom.
> >
> > With a global prog->aux->exception, things will be ok for the CPU on which the
> > exception was thrown, but some other CPU will see the check returning true in a
> > caller even if the callee subprog for it did not throw and was possibly
> > transferring its acquired references to the caller after completing execution,
> > which now causes leaks (because subprogs are allowed to acquire and return to
> > their caller).
> >
> > The way to handle this would be that we assume every callee which throws may
> > also notionally throw right when returning (due to some other CPU's throw which
> > we may see). Then every exit from throwing callees may be processed as throwing
> > if we see the global state as set.
> >
> > However, this completely prevents subprogs from transferring some acquired
> > resource to their caller (which I think is too restrictive). If I'm acquiring
> > memory from static subprog and returning to my caller, I can't any longer since
> > I notionally throw when exiting and holding resources when doing bpf_throw is
> > disallowed, so transfer is out of the question.
>
> I was under impression that subprogs cannot acquire refs and transfer them
> to caller.
> Looks like your commit 9d9d00ac29d0 ("bpf: Fix reference state management for synchronous callbacks")
> allowed too much.

I think you misunderstood the change in that commit. It was about restricting
callback functions from acquiring references and not releasing them before their
BPF_EXIT (since our handling is not completely correct for more than one
iteration). The verifier has always allowed acquiring references and
transferring them to the caller for subprog calls.

> I don't think it's a good idea to support coding patterns like:
> void my_alloc_foo(struct foo **ptr)
> {
>   struct foo *p = bpf_obj_new(typeof(*p));
>   *ptr = p;
> }
>
> It's a correct C, of course, but do we really want to support such code?
> I don't think the verifier can fully support it anyway.
> That commit of yours allowed some of it in theory, but above example probably won't work,
> since 'transfer' isn't understood by the verifier.

I have no strong opinions about restricting (I think the code for handling
transfers is sane and correct, we just transfer the modified reference state,
and it's a natural valid form of writing programs), especially since static
subprogs do not have the limitations as global subprogs, and you really don't
want to inline everything all the time.
But I think we may end up breaking existing code/programs if we do. Whether that
fallout will be small or not, I have no data yet to predict.

>
> Regardless whether we tighten the verifier now or later such subprogs shouldn't be throwing.
> So I don't see an issue doing global prog->aux->exception.

That's certainly an option, but I still think we need to be a bit careful. The
reason is that during analysis, we need to determine that whenever a subprog
call exits, are we in a state where we can safely unwind? It might end up
restricting a large set of use cases, but I can only say with certainty after I
try it out.

Right now, I heavily rely on the assumption that the checks only become true
when something throws (to also minimize rewrites, but that's a minor reason).
The core reason is being able to argue about correctness. With global exception
state, they can become true anytime, so we need to be a lot more conservative
even if we e.g. didn't see a subprog as throwing from all callsites.

call subprog(A) // will be rewritten, as using R1=A can throw
call subprog(B) // not rewritten, as using R1=B does not throw
