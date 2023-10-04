Return-Path: <bpf+bounces-11344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81F7B76BC
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 04:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 5FE09B208A3
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99858EC6;
	Wed,  4 Oct 2023 02:57:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DBA811
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 02:57:37 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248CC95
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 19:57:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27b0d0c0ba0so62748a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 19:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696388254; x=1696993054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl04552UzkMClMd+8RKvOnU6bCuu2/2CcuWsor5n7Sk=;
        b=FzP56XQQwdZFw9WAvVMO8WkO7wLOUmiFQgvuCoZB0v66zwmU0OjTEV74grwgGPM6bf
         A2LpcxgNNxZ/GpZIsdmC8eXEpA8kacR8lKSibuVfQjIwafSx9akqkfGMUtF7XICFUVUl
         ruTM/nkkX1BIiaDbVGRYurAY1olCFdnpmDsMfnKhr7+7Eqm5jMRAxO2AgJ6/fYNGKevE
         6v8/JutOIV2DqzGYnBP4wFdk4KFOuEvGE85H4vInLZHeWRS8HfGmu5hmGwlajUYjtnaN
         6o0D5g76LUsFKDfiUpFK+bZVu6dYkUCIzDSxO6LAyofwhanVLHRl3GWiecT83lxMXpMV
         3Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696388254; x=1696993054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl04552UzkMClMd+8RKvOnU6bCuu2/2CcuWsor5n7Sk=;
        b=Eltu2+wgJIgPROhUyTeveZdJijFy2MokSrf8Lz/MVmUqTXbMScIdnfyhMHSASC68Kv
         FEOM+fXlZQchf05rhyg2Kgu0c7rDlT3ABIRJvF3RHy6A0pOQehFk/5Jv2dlM0G37eylo
         49Bi+Iwe2De9cy6iE34CT3iGJ4GLAkFZGuszd6VfniKDa2XtFRRF4XX7YUXgdgliV5Y4
         iXqo9Z2+BPK4CclmDqQpqnxoB9+MRFispLUCdQumSfWE4urtXGNri/2T0Ccaq4nTTQN2
         lOiUF/K+lKRObyioNHTpKA9/WR5Hh4zHvBBygBP0oFT6KgIy7qc8AfY4R+emHcvhXLqC
         PVEg==
X-Gm-Message-State: AOJu0Yy69FLnMWDeu8lK0ODApyGOsoLQzmHnAmY0BUmiY64oMtDerV/m
	N+siNnwmuh+b0usL3Xga8l0=
X-Google-Smtp-Source: AGHT+IFvdRTlB5wU2x995MktPJLgPMsWYdQHakao7pQUiE4J7ChjDWM9SdggzaVvuKhqkQxJAnTGkg==
X-Received: by 2002:a17:90a:cf01:b0:26d:19bb:8638 with SMTP id h1-20020a17090acf0100b0026d19bb8638mr1081468pju.10.1696388254452;
        Tue, 03 Oct 2023 19:57:34 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:4bdc])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090aeb0200b0026f90d7947csm319565pjz.34.2023.10.03.19.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 19:57:34 -0700 (PDT)
Date: Tue, 3 Oct 2023 19:57:31 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrew Werner <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>,
	Andrei Matei <andreimatei1@gmail.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	kernel-team@dataexmachina.dev, Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
Message-ID: <20231004025731.ft7xjnr2nxdhxjq5@MacBook-Pro-49.local>
References: <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
 <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
 <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
 <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
 <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local>
 <3d88ede5cbe38ae96be0c148770454b2344fdcce.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d88ede5cbe38ae96be0c148770454b2344fdcce.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 04:05:30AM +0300, Eduard Zingerman wrote:
> On Tue, 2023-10-03 at 16:08 -0700, Alexei Starovoitov wrote:
> [...]
> > > When bpf_iter_next() is reached in state C and states_equal() shows
> > > that there is potentially equivalent state V:
> > > - copy C' of C is created sing copy_verifier_state(), it updates all
> > >   branch counters up the ownership chain as with any other state;
> > > - C' is put to env->loop_stack.
> > 
> > and C' points to normal parent and increments its branches as part of __push_stack().
> 
> Yes.
> 
> > void foo()
> > {
> >   if (...) { .. } // no pruning
> >   if (...) { .. } // no pruning
> > 
> >   bpf_for(...)
> >   if (...) { .. } // all ok
> > }
> > 
> > Essentially any complex code before the loop has a high chance of the verifier
> > state explosion.
> 
> Yes. This may be an issue. I'll try to hack a layered variant I talked
> before to see what are the underlying issues. The idea is to verify
> every child state of the loop entry before moving to any branches of
> loop's parent states. 

Isn't that what current DFS logic does?

> This would allow to compute local "steady loop"
> and mark everything after loop entry as safe (.branches == 0).
> 
> > > It is possible and correct to propagate liveness and precision from V
> > > to C when loop steady state is achieved, as at that point we know for
> > > sure that C is a sub-state of V. However, currently loop states are
> > > tracked globally and no states are processed after loops steady state
> > > is reached, hence I don't do liveness and precision propagation.
> > 
> > Hmm. I think the code is doing it:
> > if (is_iter_next_insn(env, insn_idx)) {
> >   if (states_equal(env, &sl->state, cur)) {
> >     push_loop_stack(env, insn_idx, env->prev_insn_idx);
> >     goto hit;
> > hit:
> >   propagate_liveness()
> 
> Yes and this should be changed. It should not produce incorrect
> results as additional precision and read marks are conservative,
> but will hinder state pruning in some scenarios.
> 
> > DFS + BFS traversal doesn't guarantee safety.
> > We delayed looping states in loop_stack, but it doesn't mean
> > that the loop body reached a steady state.
> > Your own num_iter_bug() is an example.
> > The verifier will miss exploring path with r7 = 0xdead.
> > When C' is popped from loop_stack there is chance it will explore them,
> > but there is no guarantee.
> > For this particular num_iter_bug() case the loop processing
> > will eventually propagate precision marks and retrying with C' later,
> > the C' will be correctly rejected, since precision marks are there.
> > But I think that is more due to luck and the shape of the test.
> > 
> > if (is_iter_next_insn(env, insn_idx)) {
> >   if (states_equal(env, &sl->state, cur)) {
> > 
> > is a foot gun. It finds broken equivalence and potentially skipping
> > whole blocks of code.
> > What guarantees that C' from loop_stack will explore them?
> 
> The idea is that when `env->stack.size == 0` all V's non-delayed
> children states are explored and relevant precision marks are
> propagated to V. 

But that is not true.
if (is_iter_next_insn(env, insn_idx)) {
  if (states_equal(env, &sl->state, cur)) {
with sl->state.branches > 0
will prevent exploration of all children.
Hence I still believe that fine tunning this equavalence check is
the first step in any fix.

> If at this point some states_equal(V, C') is false it
> is necessary to schedule C' for one more exploration round as it might
> visit some code blocks that were not visited on the path from V to C'
> (as different predictions decisions could be made).

exactly my point above,
but because of broken double 'if' above the 2nd pass might be hitting
the same issues as the first. Because some path wasn't explored
the precision marks might still be wrong.

More loop states can be created and delayed again into loop_stack?

> If a point is reached when for all loop states C' there are some
> states V such that states_equal(V, C'), there are no more
> configurations that can visit code blocks not visited on the path from
> V to C', as prediction decisions would be the same.

and it not, we can repeat loop_stack->stack->loop_stack potentially forever?

> > I think avoiding states_equal(V, cur) when V state didn't converge
> > is a mandatory part of the fix.
> 
> But there are no other heuristics that suggest that exploration of the
> infinite series of loop iterations could be stopped for current path.

Did you look at my broken patch? yes. it's buggy, but it demonstrates
the idea where it removes above problematic double 'if' and uses
states_equal() on states where st->branches==0 && st->looping_states==1
meaning that in those states all paths were explored except the one
forked by iter_next kfunc.
So precision and liveness is correct,
while doing states_equal on V with branches=2+ is broken. It's a guess.
Could just be random true/false and algorithm of delaying looping states
will probably converge the same way on the tests we have so far.

> > I can see that little bit of out-of-order state processing probably
> > is still correct, but delaying loop_stack all the way until 
> > env->stack.size == 0 is just broken.
> > For example we can push looping state in process_iter_next_call()
> > not the top of the stack, but place it after branches with
> > insn_idx >= iter_next's insn_idx.
> 
> This should be based on state parentage chain as code blocks could be
> non-linearly structured.

ok. discard that idea.

> > This way the delayed looping states will still be processed
> > around loop processing and every code block before the loop
> > will converge to branches = 0.
> > To do that we don't need another loop_stack.
> 
> Will comment in the morning.

