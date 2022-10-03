Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716B45F317D
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 15:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJCNwd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 09:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJCNwd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 09:52:33 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7738E3A499;
        Mon,  3 Oct 2022 06:52:30 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id f26so6326767qto.11;
        Mon, 03 Oct 2022 06:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Y4mLiAeuYzzPUufQ4FVONmNtpuZVsKfjXcAhc4xOCrM=;
        b=X5IuqG49W0MReNY4ETjSUDNQyCLRLbR4KPydpYtvdAmizBlIvvT7LRsra4sAaxDLFK
         L0hlQwDVqZwWSeyTl8puMyjBK+Iw/bDIwZmrlHWJNoP+28ZnM8Ka1Vr80I7dhIJZDToX
         X2k/+kJkdf0nJhIH5JsGgLbwyUcSGZRXjjGaLadMNH/dOaQcrB2AnVoxTKWGuFaZik/w
         insDSX4L7dbVZ7WuOrkL8RKsfX5qmSgB6RnYAnpY7InfHXhGgBAoL73P6Y7UFF+KsrLV
         KauIuRVdhe01RPJlBQMWCj8W3JVQqmCsjX2p1kAgaOAcPonnaJZ5kB9D56Y5/DbmMqpS
         AgQQ==
X-Gm-Message-State: ACrzQf396lvcFj5kq6MWj28oixEBWlympHzMTnwhGse4pfWUcHZP7GLW
        mV1BmsHUzZtJYEnFfzoL3hA=
X-Google-Smtp-Source: AMsMyM7oLIm4eEdIdJmdJ+o8mPUls6dfyfnupswAerJ9bXCtOz4dGwKrkeh/l3O8RBoc2PAZt75FYA==
X-Received: by 2002:ac8:5a06:0:b0:35c:cc7b:610c with SMTP id n6-20020ac85a06000000b0035ccc7b610cmr15815718qta.131.1664805148851;
        Mon, 03 Oct 2022 06:52:28 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::59bd])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b006cfc1d827cbsm10998770qkp.9.2022.10.03.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:52:28 -0700 (PDT)
Date:   Mon, 3 Oct 2022 08:52:35 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2] selftests/bpf: Update map_kptr examples to reflect
 real use-cases
Message-ID: <YzrpI4PWxDaejZ6d@maniforge.dhcp.thefacebook.com>
References: <20221002171012.3529521-1-void@manifault.com>
 <CAP01T76SFT7TM02RaR9CMtBww34swXZotS2FkGKVBE6+o5XqBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T76SFT7TM02RaR9CMtBww34swXZotS2FkGKVBE6+o5XqBw@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 03, 2022 at 01:35:49AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sun, 2 Oct 2022 at 19:10, David Vernet <void@manifault.com> wrote:
> >
> > In the map_kptr selftest, the bpf_kfunc_call_test_kptr_get() kfunc is used
> > to verify and illustrate a typical use case of kptrs wherein an additional
> > reference is taken on a referenced kptr that is already stored in a map.
> > This would be useful for programs that, for example, want to pass the
> > referenced kptr to a kfunc without removing it from the map.
> >
> > Unfortunately, the implementation of bpf_kfunc_call_test_kptr_get() isn't
> > representative of a real kfunc that needs to guard against possible
> > refcounting races by BPF program callers. bpf_kfunc_call_test_kptr_get()
> > does a READ_ONCE() on the struct prog_test_ref_kfunc **pp passed by the
> > user and then calls refcount_inc() if the pointer is nonzero, but this
> > can race with another callback in the same program that removes the kptr
> > from the map  and frees it:
> >
> > 1. A BPF program with a referenced kptr in a map passes the kptr to
> >    bpf_kfunc_call_test_kptr_get() as:
> >
> >    p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
> >
> >    from CPU 0.
> >
> > 2. bpf_kfunc_call_test_kptr_get() does READ_ONCE(), and sees that the
> >    struct prog_test_ref_kfunc **pp contains a non-NULL pointer.
> >
> > 3. Another BPF handler on CPU 1 then invokes bpf_kptr_xchg() to remove
> >    the kptr from the map, and frees it with a call to
> >    bpf_kfunc_call_test_release(). This drops the final refcount on the
> >    kptr.
> >
> > 4. CPU 0 then issues refcount_inc() on the kptr with refcount 0, causing
> >    a use-after-free.
> >
> > In the map_kptr selftest, this doesn't cause a use-after-free because
> > the structure being refcounted is statically allocated, and the
> > refcounts aren't actually used to control the object lifecycle. In a
> > kfunc supporting a real use case, the refcount going to 0 would likely
> > cause the object to be freed, as it does for e.g. struct task_struct.
> >
> > A more realistic use-case would use something like RCU in the kfunc
> > handler to ensure that the kptr object can be safely accessed, and then
> > issuing a refcount_inc_not_zero() to acquire a refcount on the object.
> > This patch updates the map_kptr selftest to do this.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> 
> In my defense, I did note all this in the commit adding support for
> kptr_get, so it seemed overkill to do it for a static struct.
> But it's probably not a bad idea to have a real example, given it's a
> necessity that such a helper requires reclamation of the object
> through RCU, and people probably won't go and read the commit message.

No defense needed, though I of course agree that it's important to have
a real example here. I decided to add it because I got confused about
how it was safe to use refcount_inc() instead of refcount_inc_not_zero()
in bpf_kfunc_call_test_kptr_get().

> However, some questions below...
> 
> >  net/bpf/test_run.c                            | 31 ++++++++++++++++---
> >  .../selftests/bpf/prog_tests/map_kptr.c       |  4 +--
> >  .../testing/selftests/bpf/verifier/map_kptr.c |  4 +--
> >  3 files changed, 31 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 13d578ce2a09..3fe9495abcbe 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -565,6 +565,8 @@ struct prog_test_ref_kfunc {
> >         int b;
> >         struct prog_test_member memb;
> >         struct prog_test_ref_kfunc *next;
> > +       struct rcu_head rcu;
> > +       atomic_t destroyed;
> >         refcount_t cnt;
> >  };
> >
> > @@ -572,12 +574,14 @@ static struct prog_test_ref_kfunc prog_test_struct = {
> >         .a = 42,
> >         .b = 108,
> >         .next = &prog_test_struct,
> > +       .destroyed = ATOMIC_INIT(0),
> >         .cnt = REFCOUNT_INIT(1),
> >  };
> >
> >  noinline struct prog_test_ref_kfunc *
> >  bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
> >  {
> > +       WARN_ON_ONCE(atomic_read(&prog_test_struct.destroyed));
> >         refcount_inc(&prog_test_struct.cnt);
> >         return &prog_test_struct;
> >  }
> > @@ -589,12 +593,22 @@ bpf_kfunc_call_memb_acquire(void)
> >         return NULL;
> >  }
> >
> > +static void delayed_destroy_test_ref_struct(struct rcu_head *rhp)
> > +{
> > +       struct prog_test_ref_kfunc *p = container_of(rhp, struct prog_test_ref_kfunc, rcu);
> > +
> > +       WARN_ON_ONCE(refcount_read(&p->cnt) > 0);
> > +       atomic_set(&p->destroyed, true);
> > +}
> > +
> >  noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
> >  {
> >         if (!p)
> >                 return;
> >
> > -       refcount_dec(&p->cnt);
> > +       WARN_ON_ONCE(atomic_read(&p->destroyed));
> > +       if (refcount_dec_and_test(&p->cnt))
> > +               call_rcu(&p->rcu, delayed_destroy_test_ref_struct);
> 
> I wonder whether this is ever called, I haven't really given this
> patch a shot, but I don't see how the refcount can ever drop back to
> zero. It's initialized as 1, and then only acquired after that, so
> pairing all releases should still preserve refcount as 1.

Yeah, the call_rcu() path is never hit. If we wanted to update the test
so that this codepath was actually exercised, I think we'd need to add
another kfunc that returned a reference to a dynamically allocated
object rather than using the global, static one. I'm happy to do that if
we think it's useful. The downside to adding more of these test kfuncs
is that they actually do add a small bit of runtime overhead to the
kernel because they're unconditionally registered in the __init function
for test_run.c.

> Also, even if you made it work, wouldn't you have the warning once you
> run more selftests using prog_test_run, if you just set the  destroyed
> bit on each test run?

If we want to update the test to have the refcount drop to 0, we would
probably have to instead use dynamically allocated objects. At that
point, we'd probably just crash instead of seeing a warning if we
accidentally let a caller invoke acquire or release after the object had
been destroyed. Maybe the better thing to do here is to just warn
unconditionally in the destructor rather than setting a flag? What we
really want to ensure is that the final refcount that's "owned" by the
main kernel is never dropped.
