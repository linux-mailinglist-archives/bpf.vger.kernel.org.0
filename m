Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612FE5F46B2
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJDP3p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJDP3n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 11:29:43 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87152634;
        Tue,  4 Oct 2022 08:29:41 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id df9so5209470qvb.9;
        Tue, 04 Oct 2022 08:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FfSJ4aymufDxA8b5eqmbbn2OCM92Q3VRBAEZIvvgymc=;
        b=uC/CtMvAUiR5o+DM4lZ6xBxI0LFDMIqZ0eFfyrTi9i4wNz876dORmVtCxJLQ9Bb64D
         hNYaSigAkNv3mazL8HmKg5rwKSW91Czztn5REndvG8gKmAARZeB9hSep/pv2UfnDQcHD
         39TBjGrwsL/gVHfUnUS2knQgg+znAQrhXT1e8raUQBos07H0ajWLqvAHnTDbk/Vkkhx0
         q6ut5LCiMXntgXASW0mxfGESIomo2OurDQmAlw2wQp5eDgq14JLAoHFCQyL/8ZqZTiFi
         nonWEyC6sOD1hxzePKAAp9ybNOBvgo7Lax+dVvMxCnqU8fDhgU5K9VwN/duPeWelYXup
         CP8w==
X-Gm-Message-State: ACrzQf0rA8q2d0QDNaV8WzFvY1P9+9u3mxmtL0eOVyqV2WCipoDxslLu
        X4gYMIQE8TZASmk4CaG+Aqw=
X-Google-Smtp-Source: AMsMyM7uYwLo20yrzkpF7LdyqTYksWob0np8zsZ0AV8W5BQuwM0pSsjxYdARigRaZPn3c1L4S6u0Rg==
X-Received: by 2002:a05:6214:2588:b0:49e:5dea:8e66 with SMTP id fq8-20020a056214258800b0049e5dea8e66mr20608063qvb.21.1664897380698;
        Tue, 04 Oct 2022 08:29:40 -0700 (PDT)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b006a6ebde4799sm14848509qkb.90.2022.10.04.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:29:40 -0700 (PDT)
Date:   Tue, 4 Oct 2022 10:29:47 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2] selftests/bpf: Update map_kptr examples to reflect
 real use-cases
Message-ID: <YzxRa6dBz6z/85ZV@maniforge.lan>
References: <20221002171012.3529521-1-void@manifault.com>
 <CAP01T76SFT7TM02RaR9CMtBww34swXZotS2FkGKVBE6+o5XqBw@mail.gmail.com>
 <YzrpI4PWxDaejZ6d@maniforge.dhcp.thefacebook.com>
 <CAP01T74bA2-qf3-yTkqd01k-Ft-7LJBGnuc9yOWkZK_ZmydqLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T74bA2-qf3-yTkqd01k-Ft-7LJBGnuc9yOWkZK_ZmydqLw@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 03, 2022 at 06:22:55PM +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> > > >  noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
> > > >  {
> > > >         if (!p)
> > > >                 return;
> > > >
> > > > -       refcount_dec(&p->cnt);
> > > > +       WARN_ON_ONCE(atomic_read(&p->destroyed));
> > > > +       if (refcount_dec_and_test(&p->cnt))
> > > > +               call_rcu(&p->rcu, delayed_destroy_test_ref_struct);
> > >
> > > I wonder whether this is ever called, I haven't really given this
> > > patch a shot, but I don't see how the refcount can ever drop back to
> > > zero. It's initialized as 1, and then only acquired after that, so
> > > pairing all releases should still preserve refcount as 1.
> >
> > Yeah, the call_rcu() path is never hit. If we wanted to update the test
> > so that this codepath was actually exercised, I think we'd need to add
> > another kfunc that returned a reference to a dynamically allocated
> > object rather than using the global, static one. I'm happy to do that if
> > we think it's useful. The downside to adding more of these test kfuncs
> > is that they actually do add a small bit of runtime overhead to the
> > kernel because they're unconditionally registered in the __init function
> > for test_run.c.
> >
> 
> But that only happens once, right? It still happens, so I don't see
> what changes.

The idea here would be to return a dynamically allocated object with an
initial refcount of 1 that's owned by the _BPF program_, rather than
what we have today where the global struct has an initial refcount
that's owned by the main kernel and is never expected to go to 0. For
all success (i.e. non-fail) testcases that are able to dynamically
allocate this object, the refcount should go to 0 for each of them and
the object will be destroyed after the current RCU grace period. Please
let me know if I've misunderstood your point.

> > > Also, even if you made it work, wouldn't you have the warning once you
> > > run more selftests using prog_test_run, if you just set the  destroyed
> > > bit on each test run?
> >
> > If we want to update the test to have the refcount drop to 0, we would
> > probably have to instead use dynamically allocated objects. At that
> > point, we'd probably just crash instead of seeing a warning if we
> > accidentally let a caller invoke acquire or release after the object had
> > been destroyed. Maybe the better thing to do here is to just warn
> > unconditionally in the destructor rather than setting a flag? What we
> > really want to ensure is that the final refcount that's "owned" by the
> > main kernel is never dropped.
> 
> I think the refcount_t API already warns if underflow happens.

Right, a warning would probably show up if we did a release that caused
an underflow, but it would not for an acquire after the refcount dropped
to 0.

> To be clear, I don't mind if you want to improve this, it's certainly
> a mess right now. Tests can't even run in parallel easily because it's
> global. Testing like an actually allocated object might be a good way
> to simulate a real scenario. And I totally agree that having a real
> example is useful to people who want to add support for more kptrs.

Ok, let me update the tests to do two things then:

1. Add a new test kfunc called bpf_kfunc_call_test_alloc() which returns
   a dynamically allocated instance of a prog_test_ref_kfunc *. This is
   similar in intention to bpf_xdp_ct_alloc().
2. Update bpf_kfunc_call_test_acquire() and
   bpf_kfunc_call_test_release() to take a trusted pointer to that
   allocated prog_test_ref_kfunc *.
3. Keep the other changes which e.g. use RCU in
   bpf_kfunc_call_test_kptr_get() to synchronize on getting the kptr.
   Once the __rcu kptr variant is landed we can get rid of
   bpf_kfunc_call_test_kptr_get() and make bpf_kfunc_call_test_acquire()
   require an __rcu pointer.

Continuing on point (3) above, we should _probably_ also have an example
for an object that isn't RCU-protected? I imagine that we don't want to
get rid of KF_KPTR_GET entirely once we have __rcu pointers because some
kptr_get() implementations may synchronize in other ways, such as with
spinlocks or whatever. Let's leave this until after __rcu lands though.

Does this all sound good?

> Maybe some comments around the code would also be helpful on what the
> expectations are. We should make it easy for people to hook into this
> stuff. Nobody reads documentation, people usually only look at
> existing examples.

For sure, can do.
