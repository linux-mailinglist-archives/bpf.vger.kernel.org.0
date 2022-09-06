Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283FF5ADC4E
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 02:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIFAU3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Sep 2022 20:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIFAU2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Sep 2022 20:20:28 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072502AC62
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 17:20:27 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q81so7750952iod.9
        for <bpf@vger.kernel.org>; Mon, 05 Sep 2022 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nIT70WKHrS6CeeqAJwlXGOE4LWNc1wCjUo98CjXjOG4=;
        b=FQs50WfqktwADarWpOIaxzpH+e6uMn3tpVkRjYhLrlnNzT/SC+EmOpOKDwy1Wve3+9
         6DT7ZssEwqSOI+05y/sLbqUWSAPg2r/GVgpq443easv3HhQn2XdfHFQhoLI3mPTlGH5l
         mfhDyBH8PUjrqcbhQblehXZ4Noq1EmENr+QLcr5Ae/KF6qqD8d5lMZO42PVONADgaM05
         BfCNjjsPfHXkBJTO0ffk8cOmnwT1lu8nI8XWkZiihuREAhKH0lFD70+giNeKa7aAQjqG
         /AItEg0RgohEMh/5X+ql8syGIibkxeTXQ5w+ibQ9TXGVZfsfWy2izlUEXwvl/W+v9Nqe
         oHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nIT70WKHrS6CeeqAJwlXGOE4LWNc1wCjUo98CjXjOG4=;
        b=qt9d/pkRjBcsbf7MbHBG5ZjRxwJ1eWXvRIZ9Mgo/RG+VJQZF2dpRqKdR2rCClaKRIy
         yW6b3tr5ROMojcFXm2eqvixP3G6QEsqHTDM1wBqvNwPKRinS+t8B1IqjbBBvvMQo72XQ
         QfFpBQS/JaNLatlsgyWeujUeiuSsveWe1nJIZXEzinP05BCsQaFlAtJD8C71sM40CUue
         yJeFeOUVKgvM3FwP7e4TId5jYe/7xLAw0MWqzF5eOFDNDujMT7qKUmeY8SZhC4o2xAud
         sbGpytf9knIoJ+cvF9pVWTg2vnt0hf+Fv0mVCiRw1PbBYCISO69CP2uGMWZLe/9G7zBs
         gzUA==
X-Gm-Message-State: ACgBeo05P9qVWfARb0vj+GJpMpU9JiWiGmPZ56AcLgVNg9HkYheXNmYD
        F3+3iuzyd8CHpbbi9TcBAxtUD2Dlyo8VsMjwKvsf1zlT
X-Google-Smtp-Source: AA6agR5bQDJW+2c306w0l6DtYRoqfQA+3pcihEqPHl1sdNksWIZIP7kmSccZIKS5FUpVUD28CjD1Mk1RDWevRZKii1g=
X-Received: by 2002:a05:6638:16cf:b0:34a:263f:966d with SMTP id
 g15-20020a05663816cf00b0034a263f966dmr24345835jat.124.1662423626206; Mon, 05
 Sep 2022 17:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220815051540.18791-1-memxor@gmail.com> <CAEf4BzZjZC2nAg=mbsRqQXqHe1EL5-_wkhGAzF2=Y2h6mL9C7g@mail.gmail.com>
In-Reply-To: <CAEf4BzZjZC2nAg=mbsRqQXqHe1EL5-_wkhGAzF2=Y2h6mL9C7g@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 02:19:49 +0200
Message-ID: <CAP01T74cOJzo3xQcW6weURH+mYRQ7kAWMqQOgtd_ymSbhrOoMQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf v1 0/3] Verifier callback handling
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Aug 2022 at 01:18, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Aug 14, 2022 at 10:15 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Hi, these are fixes for issues I noticed while working on the callback code.
> > It is an RFC because I would like to discuss how to fix one other problem,
> > I have a rough idea but would like to discuss before working on it, since
> > it isn't trivial. The conservative fix doesn't pass existing selftests.
> >
> > It seems like the problem anticipated in [0] actually exists with all the
> > current callback based loop helpers, in a different form. The main reason is
> > that callback function is only explored as if it was executing once.
> >
> > There are some example cases included in selftests to show the problem, and make
> > sure we keep catching and rejecting them. Since callback which is loop body is
> > only verified once, once the for_each helper returns the execution state from
> > verifier's perspective is as if callback executed once, but ofcourse it may
> > execute multiple times, unknowable statically.
> >
> > Patch 1 fixes the case of acquiring and releasing references, unless I missed
> > some corner case it seems to mostly work fine.
> >
> > In the future when we have a case where a sycnhronous callback will only be
> > executed once by a helper, we can improve this case by relaxing these
> > restrictions, so transfer of references and verifying callback as if it executes
> > only once can be done. For now, all in_callback_fn function get executed
> > multiple times, hence that change is left for when it will be needed.
> >
> > Now, the important part:
> > ------------------------
> >
> > The included selftest will fail/crash, as one fix is missing from the series.
> > Whatever I tried so far wasn't backwards compatible with existing selftests
> > (e.g. conservatively marking all reads as UNKNOWN, and all writes scrubbing
> > stack slots). Some tests e.g. read skb pointer from ptr_to_stack passed to
> > callback.
> >
> > It is not clear to me what the correct fix would be to handle reads and writes
> > from the stack inside callback function. If a stack slot is never touched inside
> > the callback in any of the states, it should be safe to allow it to load spilled
> > registers from caller's stack frame, even allowing precise scalars would be safe
> > if they are read from untouched slots.
> >
> > The idea I have is roughly:
> >
> > In the first pass, verify as if callback is executing once. This is the same
> > case as of now, this may e.g. load a spilled precise scalar, then overwrite it,
> > so insns before the store doing overwrite verification consider register as
> > precise. In reality, in later loop iterations though this assumption may be
> > wrong.
> >
> > For e.g.
> > int i = 1;
> > int arr[2] = {0};
> >
> > bpf_loop(100, cb, &i, 0);
> >
> > cb:
> >         int i = *ctx;            // seen as 1
> >         func(*((int *)ctx - i)); // stack read ok, arr[1]
> >         *ctx = i + 1;            // i is now 2
> >
> > verification ends here, but this would start reading uninit stack in later
> > iterations.
> >
> > To fix this, we keep a bitmap of scratched slots for the stack in caller frame.
> > Once we see BPF_EXIT, we do reverification of the callback, but this time mark
> > _any_ register reading from slots that were scratched the first time around as
> > mark_reg_unknown (i.e. not precise). Moreover, in the caller stack it will be
> > marked STACK_MISC. It might not be able to track <8 byte writes but I guess
> > that is fine (since that would require 512 bits instead of 64).
> >
> > The big problem I can see in this is that the precise register guards another
> > write in another branch that was not taken the first time around. In that case
> > push_stack is not done to explore the other branch, and is_branch_taken is used
> > to predict the outcome.
> >
> > But: if this has to cause a problem, the precise reg guarding the branch must
> > change its value (and that we can see if it is being from a scratched slot
> > read), so by doing another pass we would get rid of this problem. I.e. one more
> > pass would be needed after downgrading precise registers to unknown.
> >
> > If I can get some hints for new ideas or feedback on whether this would be the
> > correct approach, I can work on a proper fix for this case.
> >
> > It seems like roughly the same approach will be required for open coded
> > iteration mentioned in [0], so we might be able to kill two birds with one shot.
> >
>
> Keep in mind that callbacks, just like open-coded iteration loops
> (which I plan to work on as soon as I dig myself out of BPF mailing
> list email hole), might be executed not just 1 or >1 times, they might
> be executed exactly zero times (e.g., pass invalid arguments to
> bpf_loop or any other such helper and your callback won't be
> executed). And as such, in principle, any write to a new stack slot
> and marking it as "initialized" is invalid.
>
> So generally only state modifications that keep state with equivalent
> (and not more) amount of information should be allowed. I.e., writing
> to an already written stack slot and not adding more specific
> knowledge to known register state should be ok regardless if callback
> was called 0, 1, or N times. E.g, if we knew that r1 is [100, 200]
> precise range and inside the callback we update that to [150, 175] --
> it's fine. We just need to restore original [100, 200] state once we
> are done validating callback. If parent's stack was non-precise and
> internally callback makes it precise for internal use -- that's also
> fine, but we need to restore that slot to original imprecise state
> after callback validation. Similarly, if stack slot was uninitialized,
> it's ok if callback uses that slot for something, but we should forget
> that something once callback is done.
>
> Iterators will also have an additional restriction that we don't
> actually create a new frame for each inner loop (so what you did for
> callbacks in this patch set won't be usable as-is directly, but it's
> fine).
>
>
> In short, possibility of zero executions makes everything much
> clearer. We can't assume we know what callback writes into parent's

Indeed, 0 callback executions seems like a significant insight.

There needs to be an exploration without actually exploring the loop
body, and we need to check whether the rest of the program passes
verification like that.

It seems that case should be handled even right now? It is like how we
handle branches, so you will push_stack pointing to the first
instruction of subprog in one exploration path (which simulates
execution once and continues back in parent from bpf_exit). While for
the 0 callback case, you continue verifying after the callback helper
call insn.

It seems orthogonal to the N times case. So maybe we should fix that
now while thinking about how to handle N explorations? Thoughts?

Right now, we verify the callback as if it executes once. So callback
may e.g. spill some register variable and mark it precise (bounded, or
even constant). Then we will verify the rest of the program using that
precise scalar. But it could happen that the callback never runs and
it will simply use that unbounded scalar thinking it is bounded.

> stack (as this write might never happen). As to how to make this a bit
> more practical, we'll need to work this out in a bit more details, I
> haven't spent too much time on this yet.
>
> But I think the approach (which you are right will be conceptually
> very similar to open-coded iterators) should be to do two passes:

You mean three, right? ;-)

>   a) pass that assumes no callback happened and no parent function's
> stack modifications happened. Program should still be correctly
> verifiable (and as such, any program that assumes that callback sets
> some stack slot to some known value from inside the callback is
> invalid; that slot has to be initialized with some default value).
>   b) pass that simulates exactly 1 execution. Once we are done with
> this, let's remember this state.
>   c) third pass that simulates N executions. We pass state from step
> b) as input state. We validate with that state. Assuming it's
> successful, we end up with some new state of the parent function. At
> this point we should check that end state from step b) and state from
> this step c) are "equivalent" (according to my explanation above,
> there should be no expansion of knowledge of the state).
>
>
> The latter state is what we do for BPF infinite loop detection. The
> fun part is here we actually want to see that it would cause infinite
> loop (states shouldn't differ). At this point we can just assume that
> it's fine to execute N callbacks and we just pop state c), go back to
> state b), and continue parent program verification.
>
>
> I might be missing some details, but that's a rough idea and a plan I have.
>

Thanks for articulating your ideas. Looking forward to the patches.
It does seem like checking whether states will be equal should be
enough, even though it might not allow all kinds of loops.
We already ensure when pruning search that the new state is 'safe'
given an old already explored safe state so it should still allow some
state modification inside the loop.
Choosing the number of times to repeat this process will be the hard
part, some value that isn't too conservative and yet still not too
high to end up consuming too much time and memory during verification,
since we might not start seeing equivalent states immediately on 2nd
exploration. Maybe the callback helpers themselves can give some hints
to tune the value of N. The other improvement might be identifying the
register involved in the condition used to break out of loops, if
scalar then learning the bounds from the branch containing the
bpf_exit with R0 set to callback return value, which might allow
exploring complicated cases without bounding to fixed N limit in
verifier.
