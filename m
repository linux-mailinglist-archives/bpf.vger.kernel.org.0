Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8205FAAAC
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 04:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJKClJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 22:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJKClF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 22:41:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA617DF51;
        Mon, 10 Oct 2022 19:41:04 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s21so7548224qtx.6;
        Mon, 10 Oct 2022 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YdwJJqMqMav7983gG2xEJt2EcmsplMVNQmbGSg4wVJM=;
        b=H9RF6oZj5V84NbjMUUnzP/2x4LktZ54Dli06SdmuwX3kln3W0glxpHbJ0GV9FnTU8J
         I0uvgBtuSHXUhGp6vdiFQ43uS+nAVQS4TBP2pM3p96qwvsN9zcDNIn1GVFXguuh0/Wbf
         Teg0BUTdive3LizRW1QigKIUiSFel852GUn1DlE8ARB4fjRP9YoxGi6ERIFE7uWwRSqp
         z9PDvA5zy05KaRJeWJ8r3tIDDk029Ji91okrrbDUKkLPSqIxizRNm3Mw/8qWIROhwTKL
         peeVDe/+3fA+vO5KUA2OcDTH6XWyEEnuHdXYmh7DRb/3QZ4KBfG1SQolVJOBfDS7GUUG
         L92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdwJJqMqMav7983gG2xEJt2EcmsplMVNQmbGSg4wVJM=;
        b=lkPhak5MyLk0PgHuVN3ZZpZHaGkQyr0FGio8ViCdrhnPqpthse9I6AJGhGPdInaTYQ
         HhYWX+o0OLwR6U9qfXPA4UnFKgoiaCPIR5c1IKrQVWxrGARRM8/TFkk339gBNO376XCq
         g3oX52KWVx50ApkRi8fYnvFhmzYV+ExJ0UGCM9CoXXw2GxbhKKJiDQMD3tOsWvhUo0cn
         vsIla9G4t4MlFUVUlbwMYyq9/dHYitVuw7gGPl2CJcce+/1ioBADJWRjxsXDrThjtbWO
         qDKL1bJe1yCx+rpAUqu6I7PxOlOX3DY5JNy8oUVgiat6WXcsoXN1p9rNU44UYmHbeURD
         bMaw==
X-Gm-Message-State: ACrzQf3R/fFmrZ9oUZp0X94FApH9E5AvJbMmEQ/TwMYOlcBFCKxBon0g
        iFWka2WJv3HbwyUKvRNp/bnWx4x3BsTN/pWgXcA=
X-Google-Smtp-Source: AMsMyM4CbArNbrzGSvgyHdixrA5EcFHOib5pQC/ZGoruVzmkzHDx5PQpsV7yKJ+M7qPrbWAXjFygKc9PupUCGFukEkM=
X-Received: by 2002:a05:622a:551:b0:35d:5237:1781 with SMTP id
 m17-20020a05622a055100b0035d52371781mr17522078qtx.566.1665456063129; Mon, 10
 Oct 2022 19:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221002171012.3529521-1-void@manifault.com> <CAP01T76SFT7TM02RaR9CMtBww34swXZotS2FkGKVBE6+o5XqBw@mail.gmail.com>
 <YzrpI4PWxDaejZ6d@maniforge.dhcp.thefacebook.com> <CAP01T74bA2-qf3-yTkqd01k-Ft-7LJBGnuc9yOWkZK_ZmydqLw@mail.gmail.com>
 <YzxRa6dBz6z/85ZV@maniforge.lan>
In-Reply-To: <YzxRa6dBz6z/85ZV@maniforge.lan>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 11 Oct 2022 08:10:26 +0530
Message-ID: <CAP01T77QYNc6BJP+OtVV3YQGgS06ZeWTUBdq3sp2FhKmeoo6-A@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Update map_kptr examples to reflect
 real use-cases
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 4 Oct 2022 at 20:59, David Vernet <void@manifault.com> wrote:
>
> On Mon, Oct 03, 2022 at 06:22:55PM +0200, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > > > >  noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
> > > > >  {
> > > > >         if (!p)
> > > > >                 return;
> > > > >
> > > > > -       refcount_dec(&p->cnt);
> > > > > +       WARN_ON_ONCE(atomic_read(&p->destroyed));
> > > > > +       if (refcount_dec_and_test(&p->cnt))
> > > > > +               call_rcu(&p->rcu, delayed_destroy_test_ref_struct);
> > > >
> > > > I wonder whether this is ever called, I haven't really given this
> > > > patch a shot, but I don't see how the refcount can ever drop back to
> > > > zero. It's initialized as 1, and then only acquired after that, so
> > > > pairing all releases should still preserve refcount as 1.
> > >
> > > Yeah, the call_rcu() path is never hit. If we wanted to update the test
> > > so that this codepath was actually exercised, I think we'd need to add
> > > another kfunc that returned a reference to a dynamically allocated
> > > object rather than using the global, static one. I'm happy to do that if
> > > we think it's useful. The downside to adding more of these test kfuncs
> > > is that they actually do add a small bit of runtime overhead to the
> > > kernel because they're unconditionally registered in the __init function
> > > for test_run.c.
> > >
> >
> > But that only happens once, right? It still happens, so I don't see
> > what changes.
>
> The idea here would be to return a dynamically allocated object with an
> initial refcount of 1 that's owned by the _BPF program_, rather than
> what we have today where the global struct has an initial refcount
> that's owned by the main kernel and is never expected to go to 0. For
> all success (i.e. non-fail) testcases that are able to dynamically
> allocate this object, the refcount should go to 0 for each of them and
> the object will be destroyed after the current RCU grace period. Please
> let me know if I've misunderstood your point.
>
> > > > Also, even if you made it work, wouldn't you have the warning once you
> > > > run more selftests using prog_test_run, if you just set the  destroyed
> > > > bit on each test run?
> > >
> > > If we want to update the test to have the refcount drop to 0, we would
> > > probably have to instead use dynamically allocated objects. At that
> > > point, we'd probably just crash instead of seeing a warning if we
> > > accidentally let a caller invoke acquire or release after the object had
> > > been destroyed. Maybe the better thing to do here is to just warn
> > > unconditionally in the destructor rather than setting a flag? What we
> > > really want to ensure is that the final refcount that's "owned" by the
> > > main kernel is never dropped.
> >
> > I think the refcount_t API already warns if underflow happens.
>
> Right, a warning would probably show up if we did a release that caused
> an underflow, but it would not for an acquire after the refcount dropped
> to 0.
>

It should, see REFCOUNT_ADD_UAF in include/linux/refcount.h.

> > To be clear, I don't mind if you want to improve this, it's certainly
> > a mess right now. Tests can't even run in parallel easily because it's
> > global. Testing like an actually allocated object might be a good way
> > to simulate a real scenario. And I totally agree that having a real
> > example is useful to people who want to add support for more kptrs.
>
> Ok, let me update the tests to do two things then:
>
> 1. Add a new test kfunc called bpf_kfunc_call_test_alloc() which returns
>    a dynamically allocated instance of a prog_test_ref_kfunc *. This is
>    similar in intention to bpf_xdp_ct_alloc().
> 2. Update bpf_kfunc_call_test_acquire() and
>    bpf_kfunc_call_test_release() to take a trusted pointer to that
>    allocated prog_test_ref_kfunc *.

This should work, but you would have to go through a lot of tests,
sadly I assumed it is global in a lot of places to make testing easier
(e.g. observing count after releasing by doing p->next, which gave me
a PTR_TO_BTF_ID that is preserved after release).
Some other way would have to be found to do the same thing.

> 3. Keep the other changes which e.g. use RCU in
>    bpf_kfunc_call_test_kptr_get() to synchronize on getting the kptr.
>    Once the __rcu kptr variant is landed we can get rid of
>    bpf_kfunc_call_test_kptr_get() and make bpf_kfunc_call_test_acquire()
>    require an __rcu pointer.
>

In the case of RCU I don't plan on passing the rcu pointer to acquire
functions, but rather kptr_get stops taking pointer to pointer. I.e.
in your point 3, kptr_get does what you want _acquire to do. It takes
an rcu protected pointer to an object and safely increments its count.

> Continuing on point (3) above, we should _probably_ also have an example
> for an object that isn't RCU-protected? I imagine that we don't want to
> get rid of KF_KPTR_GET entirely once we have __rcu pointers because some
> kptr_get() implementations may synchronize in other ways, such as with
> spinlocks or whatever. Let's leave this until after __rcu lands though.
>

I think it's unlikely kptr_get can work without it, spinlocks may be
required internally (e.g. to inspect the object key/generation in
SLAB_TYPESAFE_BY_RCU case without races) but that goes on top of RCU
protection. But yes, it depends, maybe it will work for some special
cases. Though I don't think it's worth adding an example for the
uncommon case.

So you will still need kptr_get helpers, some of them simply do
refcount_inc_not_zero, others may do a little more.
Anyway, let's discuss more when the set is posted.

> Does this all sound good?
>

Yes.
