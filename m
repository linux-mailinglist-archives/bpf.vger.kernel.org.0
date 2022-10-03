Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1ED5F336B
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJCQXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 12:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJCQXf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 12:23:35 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB241DA57;
        Mon,  3 Oct 2022 09:23:34 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h10so5487227qvq.7;
        Mon, 03 Oct 2022 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cvyK67mrfsgVH18MEq1er8pChBJ9aUvlnI16vefVb98=;
        b=BQxPIwGMFy3xalQSV0+E6nI36B8lgk9jyBoEuVtNxwN2aBH8a6I7C/d+EUxirZBH/H
         /HHVBVDAnkBjvGhBEog+UI98ngMNrGQiwupitsmgON0J2G54DZqJbRN3/W9N3D6vgG6r
         f4ZAcyTXfmzkvFNP+yc5hZhm7Kvdq3usd800muhROfKiQJpq+5fM6f93JH5CmCOAL+2m
         6IEFtc5DhbmQYA+7e+CZuimmKEjOWWcpNvISXyZjtBvjDBiDd/qbgGtkPieeGHMoqgNX
         EaCF/ef+lK4DUnD3US8Z4S9Xc8gF9qmPN1YORF4jh1IhTeReBg+TUHdFfUjx4hY49lPG
         5USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cvyK67mrfsgVH18MEq1er8pChBJ9aUvlnI16vefVb98=;
        b=kEk7bIo2gq3mKfLFTzd2Pw2Ll4ziyQms+Mab0fzVnE50L7T9N5iYTDFD/MYL29khMk
         FviB03HtgDboBZPZar5BOHGBHJtAqYAnrEkfqowqLsAFXon9AeNI38fJxDWro8aImpBI
         a+H0MvmVXV3KdrM4djiQ6GK3aGtuZClJT7aGZ9neSMAuFjoUZeWtuWqllxngv3ADAjZO
         Lb9QbW7z0joRDj1EnFjdqblEvGuTbixrUY/qaaQRXDQaf1n+NBOT33fuqxFLBePTqaqQ
         NpxDkh5X9Fa5jSVOpjYsW9mW46h4YozJodsyGtq7W7cY4KxBqJas5BzuUfaiMHOOrgJJ
         ihEA==
X-Gm-Message-State: ACrzQf2QJqchBJ2VgIkCsSk93isfLjKIRFl7tk6fM1f+emm5YsLFOU2+
        GawXrCxXzXOM+r1LMD9b//qyZowLtrSwFPPpiQE=
X-Google-Smtp-Source: AMsMyM6/go4RwfrQf3InU5QuWtxz0ZJ/WXRELCelvZLgQeUY+Kn8NLM13xHgOcfIrUFXUGF4DOoDoOXEp4gihIVa84A=
X-Received: by 2002:a05:6214:20a7:b0:4b1:7c4f:a218 with SMTP id
 7-20020a05621420a700b004b17c4fa218mr7748637qvd.85.1664814213488; Mon, 03 Oct
 2022 09:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221002171012.3529521-1-void@manifault.com> <CAP01T76SFT7TM02RaR9CMtBww34swXZotS2FkGKVBE6+o5XqBw@mail.gmail.com>
 <YzrpI4PWxDaejZ6d@maniforge.dhcp.thefacebook.com>
In-Reply-To: <YzrpI4PWxDaejZ6d@maniforge.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 3 Oct 2022 18:22:55 +0200
Message-ID: <CAP01T74bA2-qf3-yTkqd01k-Ft-7LJBGnuc9yOWkZK_ZmydqLw@mail.gmail.com>
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

On Mon, 3 Oct 2022 at 15:52, David Vernet <void@manifault.com> wrote:
>
> On Mon, Oct 03, 2022 at 01:35:49AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Sun, 2 Oct 2022 at 19:10, David Vernet <void@manifault.com> wrote:
> > >
> > > In the map_kptr selftest, the bpf_kfunc_call_test_kptr_get() kfunc is used
> > > to verify and illustrate a typical use case of kptrs wherein an additional
> > > reference is taken on a referenced kptr that is already stored in a map.
> > > This would be useful for programs that, for example, want to pass the
> > > referenced kptr to a kfunc without removing it from the map.
> > >
> > > Unfortunately, the implementation of bpf_kfunc_call_test_kptr_get() isn't
> > > representative of a real kfunc that needs to guard against possible
> > > refcounting races by BPF program callers. bpf_kfunc_call_test_kptr_get()
> > > does a READ_ONCE() on the struct prog_test_ref_kfunc **pp passed by the
> > > user and then calls refcount_inc() if the pointer is nonzero, but this
> > > can race with another callback in the same program that removes the kptr
> > > from the map  and frees it:
> > >
> > > 1. A BPF program with a referenced kptr in a map passes the kptr to
> > >    bpf_kfunc_call_test_kptr_get() as:
> > >
> > >    p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
> > >
> > >    from CPU 0.
> > >
> > > 2. bpf_kfunc_call_test_kptr_get() does READ_ONCE(), and sees that the
> > >    struct prog_test_ref_kfunc **pp contains a non-NULL pointer.
> > >
> > > 3. Another BPF handler on CPU 1 then invokes bpf_kptr_xchg() to remove
> > >    the kptr from the map, and frees it with a call to
> > >    bpf_kfunc_call_test_release(). This drops the final refcount on the
> > >    kptr.
> > >
> > > 4. CPU 0 then issues refcount_inc() on the kptr with refcount 0, causing
> > >    a use-after-free.
> > >
> > > In the map_kptr selftest, this doesn't cause a use-after-free because
> > > the structure being refcounted is statically allocated, and the
> > > refcounts aren't actually used to control the object lifecycle. In a
> > > kfunc supporting a real use case, the refcount going to 0 would likely
> > > cause the object to be freed, as it does for e.g. struct task_struct.
> > >
> > > A more realistic use-case would use something like RCU in the kfunc
> > > handler to ensure that the kptr object can be safely accessed, and then
> > > issuing a refcount_inc_not_zero() to acquire a refcount on the object.
> > > This patch updates the map_kptr selftest to do this.
> > >
> > > Signed-off-by: David Vernet <void@manifault.com>
> > > ---
> >
> > In my defense, I did note all this in the commit adding support for
> > kptr_get, so it seemed overkill to do it for a static struct.
> > But it's probably not a bad idea to have a real example, given it's a
> > necessity that such a helper requires reclamation of the object
> > through RCU, and people probably won't go and read the commit message.
>
> No defense needed, though I of course agree that it's important to have
> a real example here. I decided to add it because I got confused about
> how it was safe to use refcount_inc() instead of refcount_inc_not_zero()
> in bpf_kfunc_call_test_kptr_get().
>
> > However, some questions below...
> >
> > >  net/bpf/test_run.c                            | 31 ++++++++++++++++---
> > >  .../selftests/bpf/prog_tests/map_kptr.c       |  4 +--
> > >  .../testing/selftests/bpf/verifier/map_kptr.c |  4 +--
> > >  3 files changed, 31 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > > index 13d578ce2a09..3fe9495abcbe 100644
> > > --- a/net/bpf/test_run.c
> > > +++ b/net/bpf/test_run.c
> > > @@ -565,6 +565,8 @@ struct prog_test_ref_kfunc {
> > >         int b;
> > >         struct prog_test_member memb;
> > >         struct prog_test_ref_kfunc *next;
> > > +       struct rcu_head rcu;
> > > +       atomic_t destroyed;
> > >         refcount_t cnt;
> > >  };
> > >
> > > @@ -572,12 +574,14 @@ static struct prog_test_ref_kfunc prog_test_struct = {
> > >         .a = 42,
> > >         .b = 108,
> > >         .next = &prog_test_struct,
> > > +       .destroyed = ATOMIC_INIT(0),
> > >         .cnt = REFCOUNT_INIT(1),
> > >  };
> > >
> > >  noinline struct prog_test_ref_kfunc *
> > >  bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
> > >  {
> > > +       WARN_ON_ONCE(atomic_read(&prog_test_struct.destroyed));
> > >         refcount_inc(&prog_test_struct.cnt);
> > >         return &prog_test_struct;
> > >  }
> > > @@ -589,12 +593,22 @@ bpf_kfunc_call_memb_acquire(void)
> > >         return NULL;
> > >  }
> > >
> > > +static void delayed_destroy_test_ref_struct(struct rcu_head *rhp)
> > > +{
> > > +       struct prog_test_ref_kfunc *p = container_of(rhp, struct prog_test_ref_kfunc, rcu);
> > > +
> > > +       WARN_ON_ONCE(refcount_read(&p->cnt) > 0);
> > > +       atomic_set(&p->destroyed, true);
> > > +}
> > > +
> > >  noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
> > >  {
> > >         if (!p)
> > >                 return;
> > >
> > > -       refcount_dec(&p->cnt);
> > > +       WARN_ON_ONCE(atomic_read(&p->destroyed));
> > > +       if (refcount_dec_and_test(&p->cnt))
> > > +               call_rcu(&p->rcu, delayed_destroy_test_ref_struct);
> >
> > I wonder whether this is ever called, I haven't really given this
> > patch a shot, but I don't see how the refcount can ever drop back to
> > zero. It's initialized as 1, and then only acquired after that, so
> > pairing all releases should still preserve refcount as 1.
>
> Yeah, the call_rcu() path is never hit. If we wanted to update the test
> so that this codepath was actually exercised, I think we'd need to add
> another kfunc that returned a reference to a dynamically allocated
> object rather than using the global, static one. I'm happy to do that if
> we think it's useful. The downside to adding more of these test kfuncs
> is that they actually do add a small bit of runtime overhead to the
> kernel because they're unconditionally registered in the __init function
> for test_run.c.
>

But that only happens once, right? It still happens, so I don't see
what changes.

> > Also, even if you made it work, wouldn't you have the warning once you
> > run more selftests using prog_test_run, if you just set the  destroyed
> > bit on each test run?
>
> If we want to update the test to have the refcount drop to 0, we would
> probably have to instead use dynamically allocated objects. At that
> point, we'd probably just crash instead of seeing a warning if we
> accidentally let a caller invoke acquire or release after the object had
> been destroyed. Maybe the better thing to do here is to just warn
> unconditionally in the destructor rather than setting a flag? What we
> really want to ensure is that the final refcount that's "owned" by the
> main kernel is never dropped.

I think the refcount_t API already warns if underflow happens.

To be clear, I don't mind if you want to improve this, it's certainly
a mess right now. Tests can't even run in parallel easily because it's
global. Testing like an actually allocated object might be a good way
to simulate a real scenario. And I totally agree that having a real
example is useful to people who want to add support for more kptrs.

Maybe some comments around the code would also be helpful on what the
expectations are. We should make it easy for people to hook into this
stuff. Nobody reads documentation, people usually only look at
existing examples.
