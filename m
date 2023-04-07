Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7539F6DA78A
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 04:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbjDGCMT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 22:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbjDGCMH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 22:12:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18CDA5F8
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 19:11:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7178477pjc.1
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 19:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680833500; x=1683425500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc2JtiSyR8yI1l50fPNS7krLCdm072Zg+wC8mAel2ec=;
        b=bKWHqlJj8+pF+7Xb+A8hw+iU4BY33zwCughXqv0hydxU9m/B/9Q1XTU0TtQLxwzFNt
         W6a3ZWA/HN4nBGEE9FKeW8/ycxNE6xDPcN2R16Vhm1qU8GgQi5vassetdURlvhuNmPhi
         gEqU9f7wLWpHpOjjWRDCsC/EZWHdk27ZZSZhCUjwoTZI4/Op3eHOBwUglVQKZk822YJB
         JIh/s6PqUwlLf5LKw9Wj4bq3krK+RFvKNr04nEXjoqPniuTXV8n2L7ZsAFWMp2CsthQK
         3alN6HD6W3vI2spIkh5LxvPqCbithYI0jbKHLlMkimfi8GeyvJQjt92uchny5NIKYm30
         KTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680833500; x=1683425500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc2JtiSyR8yI1l50fPNS7krLCdm072Zg+wC8mAel2ec=;
        b=VWmDaSWFSQVFJAtHqFel8IS8YbFgohw2OumX53bAHKT5ehxAv7vj8FAWLPikDODJWy
         4TNzHk8eUYByly+f4kSrpFI7PsHwH1ic15Lb63cC8023xYVwSV3XBRbQp+Dt6ClgNNLr
         4MW3S9z1+2X9me128qVVwCNw/6vEx1lg0zDIKXsKFngizrcj4res52iikKiSq4UvkWjd
         YXx0dMn8EdMB6924to2241bX45OikVQ478+2vzjXlDP4H/1PG5PrPt43KqJpH4smzxsa
         cztLz9esQiKaaL+F6kT6OclK2BfvcMdOp/S+zJsfHZTrDDIxx0QPVb8E69h5M0GG4IgY
         TWDQ==
X-Gm-Message-State: AAQBX9c4ru2MPNNirX9VlrY67CUTMnXss1EU7HiKsRR0ybXvWr99mCWA
        bKObGVoQxnVVRCMixDcNgyp3XHityUc=
X-Google-Smtp-Source: AKy350YnJ9B2BKl0zqwKlU8J8rg7Q8ReiWdyuCg02chKdtHcdUH98monAf4OXy/TV3EfuvTlITi/EQ==
X-Received: by 2002:a17:902:db11:b0:19e:6cb9:4c8f with SMTP id m17-20020a170902db1100b0019e6cb94c8fmr1433436plx.41.1680833499912;
        Thu, 06 Apr 2023 19:11:39 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5abd])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b0019f1205bdcbsm1967578plq.147.2023.04.06.19.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:11:39 -0700 (PDT)
Date:   Thu, 6 Apr 2023 19:11:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 3/9] bpf: Implement bpf_throw kfunc
Message-ID: <20230407021136.dmq42wum3wzhq4bu@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-4-memxor@gmail.com>
 <20230406021622.xbgzrmfjxli6dkpt@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <xmehxhdk4ba2j75ltdygzi2b56aftcei36dndptg3v6gdumrh2@zadr5xdn5g3m>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmehxhdk4ba2j75ltdygzi2b56aftcei36dndptg3v6gdumrh2@zadr5xdn5g3m>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 01:54:03AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu, Apr 06, 2023 at 04:16:22AM CEST, Alexei Starovoitov wrote:
> > On Wed, Apr 05, 2023 at 02:42:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> > >
> > > - The exception state is represented using four booleans in the
> > >   task_struct of current task. Each boolean corresponds to the exception
> > >   state for each kernel context. This allows BPF programs to be
> > >   interrupted and still not clobber the other's exception state.
> >
> > that doesn't work for sleepable bpf progs and in RT for regular progs too.
> >
> 
> Can you elaborate? If a sleepable program blocks, that means the task is
> scheduled out, so the next program will use the other task's task_struct.
> Same for preemption for normal progs (under RT or not).

I was worried about the case of the same task but different code paths
in the kernel with tracing prog stepping on preempted lsm.s prog.
I think you point that in this case they gotta be in different interrupt_context_level.
I need to think it through a bit more.

> > How about using a scratch space in prog->aux->exception[] instead of current task?
> >
> 
> I actually had this thought. It's even better because we can hardcode the
> address of the exception state right in the program (since prog->aux remains
> stable during bpf_patch_insn_data). 

exactly.

> However, concurrent program invocations on
> multiple CPUs doesn't work well with this. It's like, one program sets the state
> while the other tries to check it. 

Right. If it asserts on one cpu all other cpus will unwind as well,
since we're saying bpf_assert is for exceptions when user cannot convince
the verifier that the program is correct.
So it doesn't matter that it aborted everywhere. It's probably a good thing too.

> It can be per-CPU but then we have to disable
> preemption (which cannot be done).

I was thinking to propose a per-cpu prog->aux->exception[] area.
Sleepable and not are in migrate_disable(). bpf progs never migrate.
So we can do it, but we'd need new pseudo this_cpu_ptr instruction and
corresponding JIT support which felt like overkill.

Another idea I contemplated is to do preempt_disable() and local_irq_save()
into special field in prog->aux->exception first thing in bpf_throw()
and then re-enable everything before entering exception cb.
To avoid races with other progs, but NMI can still happen, so it's pointless.
Just non-per-cpu prog->aux->exception seems good enough.

> > > - Rewrites happen for bpf_throw and call instructions to subprogs.
> > >   The instructions which are executed in the main frame of the main
> > >   program (thus, not global functions and extension programs, which end
> > >   up executing in frame > 0) need to be rewritten differently. This is
> > >   tracked using BPF_THROW_OUTER vs BPF_THROW_INNER. If not done, a
> >
> > how about BPF_THROW_OUTER vs BPF_THROW_ANY_INNER ?
> > would it be more precise ?
> 
> I'm fine with the renaming. The only thing the type signifies is if we need to
> do the rewrite for frame 0 vs frame N.

Sure. BPF_THROW_FRAME_ZERO and BPF_THROW_FRAME_NON_ZERO also works.
Or any name that shows that 2nd includes multiple cases.

> >
> > > +__bpf_kfunc notrace void bpf_throw(void)
> > > +{
> > > +	int i = interrupt_context_level();
> > > +
> > > +	current->bpf_exception_thrown[i] = true;
> > > +}
> >
> > I think this needs to take u64 or couple u64 args and store them
> > in the scratch area.
> > bpf_assert* macros also need a way for bpf prog to specify
> > the reason for the assertion.
> > Otherwise there won't be any way to debug what happened.
> 
> I agree. Should we force it to be a constant value? Then we can hardcode it in
> the .text without having to save and restore it, but that might end up being a
> little too restrictive?

with prog->aux->exception approach run-time values works too.
