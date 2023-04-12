Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29BF6DFEC4
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDLTgS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 15:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDLTgR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 15:36:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D7213A
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:36:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p17so1361680pla.3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681328176; x=1683920176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ykwc6fjvsy5ZhAj3Z3A2NkdXok1QLsB8+rSZo7jr/q4=;
        b=L5e3qkJkVJuJErkA4RZslRimyAF1hXDjvx4E5lPNvTSWpPhNkxZN9gnhcsC8G2IPnL
         B93EjdfU28q7ynRS43c+EbQJF6+TYgbrk2oZBeM6+w/exhlIWdxmBHX2FUhwSjcJUHgI
         JEVCACFWs1+U40xL9A3W/aHgZaGqZsaQBcNeJD/rt8yjE6nzsjWV2SBSBSuTYNSVOTpP
         t8Ml/1CF2cIvqnrIe4JtYQH3NOz6Sur5cmO2I3BVWilajflOdLY8CT/LCu6VgYMCkwx6
         TyvpbleNuaY7bOFlaXIJsQHllv4M7lA0APkNKcJaWFc/qkWqjLEVXL4lV0QW7MKRe3eb
         eenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328176; x=1683920176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ykwc6fjvsy5ZhAj3Z3A2NkdXok1QLsB8+rSZo7jr/q4=;
        b=CsJzccEBgwJIbm9dAQZjJeeAdOJmduvOvXC40yXWuJ5EnrCpRFKTZMcbl6WHoV/gqr
         n/sJRvLM78IyqZvOE07OT8VCU7kTHLAwuCwu5shYGqRBlK2LXmp+Oy18njtDt/HrTf7s
         X1xpxfYfiwPMw+ekQ6u2fi4fQmAyxGwJJ9tX6Y0ETBfnUvgjywlErfm3FhLG4HpUkABL
         Kt3Rz+yYzt4scvIsjHWkiXUHv3KoH7fsURppRjgtHW7L4wZPeiLZyTn3dIeJWnoR7gHz
         4HlbEPov19V3fkACDgd2XfpZZFjmRaMRm3bH3GWWl1Ji0KrbLq67AKUovAQG/YyX3jBt
         QjSA==
X-Gm-Message-State: AAQBX9cBUqZTKCgS4dVUPwq4IL2G9V/bf/87NUrYIwtMzK94lvlxLuue
        MzS+rArMrRNsm7zek21MvKfEGYnnWvc=
X-Google-Smtp-Source: AKy350Yq8KFGBozim0Otqq076+iE2h3aIWvQuZjz+y96oogXQPsoyF9SNhsWqzUUrI+3hsW5qsDb9Q==
X-Received: by 2002:a05:6a20:3a9a:b0:e3:8710:6846 with SMTP id d26-20020a056a203a9a00b000e387106846mr7146770pzh.10.1681328175495;
        Wed, 12 Apr 2023 12:36:15 -0700 (PDT)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:5010])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78d45000000b00625037cf695sm8593104pfe.86.2023.04.12.12.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:36:15 -0700 (PDT)
Date:   Wed, 12 Apr 2023 12:36:12 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 3/9] bpf: Implement bpf_throw kfunc
Message-ID: <20230412193612.neaz7i7whrk3i5f2@macbook-pro-6.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-4-memxor@gmail.com>
 <20230406021622.xbgzrmfjxli6dkpt@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <xmehxhdk4ba2j75ltdygzi2b56aftcei36dndptg3v6gdumrh2@zadr5xdn5g3m>
 <20230407021136.dmq42wum3wzhq4bu@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <bykk75ofgzxtmcpbvebju3mdp2jumt27mhfrvk4ysbkfotu2dv@3vd7vm352kp7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bykk75ofgzxtmcpbvebju3mdp2jumt27mhfrvk4ysbkfotu2dv@3vd7vm352kp7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 04:46:55AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri, Apr 07, 2023 at 04:11:36AM CEST, Alexei Starovoitov wrote:
> > On Fri, Apr 07, 2023 at 01:54:03AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Thu, Apr 06, 2023 at 04:16:22AM CEST, Alexei Starovoitov wrote:
> > > > On Wed, Apr 05, 2023 at 02:42:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > >
> > > > > - The exception state is represented using four booleans in the
> > > > >   task_struct of current task. Each boolean corresponds to the exception
> > > > >   state for each kernel context. This allows BPF programs to be
> > > > >   interrupted and still not clobber the other's exception state.
> > > >
> > > > that doesn't work for sleepable bpf progs and in RT for regular progs too.
> > > >
> > >
> > > Can you elaborate? If a sleepable program blocks, that means the task is
> > > scheduled out, so the next program will use the other task's task_struct.
> > > Same for preemption for normal progs (under RT or not).
> >
> > I was worried about the case of the same task but different code paths
> > in the kernel with tracing prog stepping on preempted lsm.s prog.
> > I think you point that in this case they gotta be in different interrupt_context_level.
> > I need to think it through a bit more.
> >
> 
> If there is nesting, the programs always clear their exception state on exit, so
> the prog that calls into the kernel which then calls into the tracing prog etc.
> won't see its exception state on return. The only path where attaching programs
> would screw things up is when we see a thrown exception and start unwinding
> (where clearing would be a problem since its done frame-by-frame). For that, I
> already prevent _throwing_ fexit programs from attaching to subprogs in this
> series (normal ones are still ok and supported, because fentry/fexit is
> important for stats etc.). There might be some other corner cases I missed but
> ensuring this property alone in general should make things work correctly.
> 
> > > > How about using a scratch space in prog->aux->exception[] instead of current task?
> > > >
> > >
> > > I actually had this thought. It's even better because we can hardcode the
> > > address of the exception state right in the program (since prog->aux remains
> > > stable during bpf_patch_insn_data).
> >
> > exactly.
> >
> > > However, concurrent program invocations on
> > > multiple CPUs doesn't work well with this. It's like, one program sets the state
> > > while the other tries to check it.
> >
> > Right. If it asserts on one cpu all other cpus will unwind as well,
> > since we're saying bpf_assert is for exceptions when user cannot convince
> > the verifier that the program is correct.
> > So it doesn't matter that it aborted everywhere. It's probably a good thing too.
> >
> 
> We can discuss the semantics (this makes bpf_assert more stronger and basically
> poisons the program globally in some sense), but implementation wise it's going
> to be a lot more tricky to reason about correctness.
> 
> Right now, the verifier follows paths and knows what resources are held when we
> throw from a nested call chain (to complain on leaks). Callers doing the check
> for exception state at runtime expect only certain throwing points to trigger
> the check and rely on that for leak freedom.
> 
> With a global prog->aux->exception, things will be ok for the CPU on which the
> exception was thrown, but some other CPU will see the check returning true in a
> caller even if the callee subprog for it did not throw and was possibly
> transferring its acquired references to the caller after completing execution,
> which now causes leaks (because subprogs are allowed to acquire and return to
> their caller).
> 
> The way to handle this would be that we assume every callee which throws may
> also notionally throw right when returning (due to some other CPU's throw which
> we may see). Then every exit from throwing callees may be processed as throwing
> if we see the global state as set.
> 
> However, this completely prevents subprogs from transferring some acquired
> resource to their caller (which I think is too restrictive). If I'm acquiring
> memory from static subprog and returning to my caller, I can't any longer since
> I notionally throw when exiting and holding resources when doing bpf_throw is
> disallowed, so transfer is out of the question.

I was under impression that subprogs cannot acquire refs and transfer them
to caller.
Looks like your commit 9d9d00ac29d0 ("bpf: Fix reference state management for synchronous callbacks")
allowed too much.
I don't think it's a good idea to support coding patterns like:
void my_alloc_foo(struct foo **ptr)
{
  struct foo *p = bpf_obj_new(typeof(*p));
  *ptr = p;
}

It's a correct C, of course, but do we really want to support such code?
I don't think the verifier can fully support it anyway.
That commit of yours allowed some of it in theory, but above example probably won't work,
since 'transfer' isn't understood by the verifier.

Regardless whether we tighten the verifier now or later such subprogs shouldn't be throwing.
So I don't see an issue doing global prog->aux->exception.
