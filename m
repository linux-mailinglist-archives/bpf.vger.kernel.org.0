Return-Path: <bpf+bounces-11326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA357B7481
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 01:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 2FC491F217C7
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 23:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11403F4A7;
	Tue,  3 Oct 2023 23:08:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A743CCF8
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 23:08:26 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBA69E
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 16:08:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so1163084b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696374505; x=1696979305; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=peMBat6LEZU1dSIMRvqHeZ46sCLAlahz2V0O1I/VZFc=;
        b=RyZL4IIhyV47X+vvpSmtmpOcMdAyAh4EMU0zVI2h9XO2MJNPnGskJgto0KALRnTKdg
         5gKk+D3Wd+SciRk2sazq8sGNjaZy8ZOjL1siTkwzo6aR7JoZiW5WGRu+8SyFf37v8ZTw
         CbGfpGDs4ZuA2N253jtT/8xAcn5Ab11TQWVKSNo6b/f1192wffd9Zn212gzJ5orUGbkD
         XMXE6YhLzYzEvFCcCo+6JRKsbh0n+ep1LZzSfZYFZbXGMflGEd4ZDPiUWWNbQZibGl+7
         YwBbdG964sAXiY85jPyXSkkQWDjXwmtZM75cK1wdPP3/hutzlMdh5OkgsQEY7Vu+8Jmh
         uWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696374505; x=1696979305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peMBat6LEZU1dSIMRvqHeZ46sCLAlahz2V0O1I/VZFc=;
        b=v/wYAoA5nSW2xaYFvBo5omki2CE/jPy3Lzj+kgdlibmPYK8y1kpLgB7N/Bo3RnWtP+
         M5MriNzntoZlztPCPhtp5JVcRrj9fA4UUMgUryMd6T6/YM09T2TrFu8KGiicDiLPDlvN
         scaBgtxGh075n9Xr2zI6lE01cFd71zpuor2xCkRQQsdC5uQnyOKjnxN57qz1xrtjm3Q1
         RgD0UoukqBvBqNF5ug20XF1AnS5GDzzprmLqgfHplpstBHQ4rRc8PjbZtMETQkivWCki
         ETPe/f/he30uBrtpQRYQvgOHgk9kOMtpKHUkH3ltNdBiZ/mUTTGvqfTsG5TtEwhXmvyv
         KKjA==
X-Gm-Message-State: AOJu0YzVInzibaVY8Gq8NYkqEjnnFdQd4lccdHciZ6XNItWrBCjmQyX3
	pNKWzA5Ixh+DaL5nGs8fawY=
X-Google-Smtp-Source: AGHT+IEnT71WCXCaR4gjdqBz3sO5GbGIzeMp4h8gGVPJNnKa4IJPXzf61V6ABa2X0TxLwORMsQpDWA==
X-Received: by 2002:a05:6a00:b95:b0:68f:dfea:9100 with SMTP id g21-20020a056a000b9500b0068fdfea9100mr1229497pfj.21.1696374504791;
        Tue, 03 Oct 2023 16:08:24 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:4bdc])
        by smtp.gmail.com with ESMTPSA id d5-20020a63a705000000b005781e026905sm1939060pgf.56.2023.10.03.16.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:08:24 -0700 (PDT)
Date: Tue, 3 Oct 2023 16:08:20 -0700
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
Message-ID: <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local>
References: <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
 <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
 <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
 <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 12:52:07AM +0300, Eduard Zingerman wrote:
> On Tue, 2023-10-03 at 11:50 -0700, Alexei Starovoitov wrote:
> > On Tue, Oct 3, 2023 at 8:33 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > 
> > > When I put states to the loop stack I do copy_verifier_state() and
> > > increase .branches counter for each state parent, so this should not
> > > trigger warnings with update_branch_counts().
> > 
> > No warn doesn't mean it's correct.
> > I suspect what your reschedule_loop_states() will increase
> > branches from 0 to 1.
> > Which is equivalent to increasing refcnt from zero. Not good.
> 
> Not really, here is how I modified bpf_verifier_env:
> 
>     struct bpf_verifier_state_stack {
>         struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
>         int size;                             /* number of states to be processed */
>     };
>     
>     struct bpf_verifier_env {
>         ...
>         struct bpf_verifier_state_stack stack;
>         struct bpf_verifier_state_stack loop_stack;
>         ...
>     }
> 
> Here env->stack is used for DFS traversal and env->loop_stack is used
> to delay verification of the loop states.
> 
> When bpf_iter_next() is reached in state C and states_equal() shows
> that there is potentially equivalent state V:
> - copy C' of C is created sing copy_verifier_state(), it updates all
>   branch counters up the ownership chain as with any other state;
> - C' is put to env->loop_stack.

and C' points to normal parent and increments its branches as part of __push_stack().

By delaying all looping states that looks to be equal to V states
due to broken precision marks the verifier will walk almost everything
after the loop, converge all branches to 0, then clean_live_states() and REG_LIVE_DONE
in the bottom part,
then it will proceed to verify all branches before the loop, but
since their branch counter is stuck due to states in loop_stack,
the upper part of the program won't get the same treatment.
update_branch_counts() will never go past the point where C' was put on loop_stack,
so every state before the loop will have branches > 0 and
verification of branches before the loop will not do any state pruning at all.

void foo()
{
  if (...) { .. } // no pruning
  if (...) { .. } // no pruning

  bpf_for(...)
  if (...) { .. } // all ok
}

Essentially any complex code before the loop has a high chance of the verifier
state explosion.

> It is possible and correct to propagate liveness and precision from V
> to C when loop steady state is achieved, as at that point we know for
> sure that C is a sub-state of V. However, currently loop states are
> tracked globally and no states are processed after loops steady state
> is reached, hence I don't do liveness and precision propagation.

Hmm. I think the code is doing it:
if (is_iter_next_insn(env, insn_idx)) {
  if (states_equal(env, &sl->state, cur)) {
    push_loop_stack(env, insn_idx, env->prev_insn_idx);
    goto hit;
hit:
  propagate_liveness()

> The necessity to visit all grandchildren states of V leads to
> necessity of mixed DFS and BFS traversal of the loop states.

DFS + BFS traversal doesn't guarantee safety.
We delayed looping states in loop_stack, but it doesn't mean
that the loop body reached a steady state.
Your own num_iter_bug() is an example.
The verifier will miss exploring path with r7 = 0xdead.
When C' is popped from loop_stack there is chance it will explore them,
but there is no guarantee.
For this particular num_iter_bug() case the loop processing
will eventually propagate precision marks and retrying with C' later,
the C' will be correctly rejected, since precision marks are there.
But I think that is more due to luck and the shape of the test.

if (is_iter_next_insn(env, insn_idx)) {
  if (states_equal(env, &sl->state, cur)) {

is a foot gun. It finds broken equivalence and potentially skipping
whole blocks of code.
What guarantees that C' from loop_stack will explore them?
I think avoiding states_equal(V, cur) when V state didn't converge
is a mandatory part of the fix.

I can see that little bit of out-of-order state processing probably
is still correct, but delaying loop_stack all the way until 
env->stack.size == 0 is just broken.
For example we can push looping state in process_iter_next_call()
not the top of the stack, but place it after branches with
insn_idx >= iter_next's insn_idx.
This way the delayed looping states will still be processed
around loop processing and every code block before the loop
will converge to branches = 0.
To do that we don't need another loop_stack.

I think we need a call to converge. Office hours on Thu at 9am?
Or tomorrow at 9am?

