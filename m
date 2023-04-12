Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDF76DFEEF
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLTq0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDLTqU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 15:46:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ADC6EAB
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:46:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 21so4382493plg.12
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681328777; x=1683920777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rh9IeKDPhLqCojjOCexRwPlfwC8qA4P7+b4pfmzZpz8=;
        b=Vq8ocvLAWPveGsh0A2b2x85pBicdwLVZJvrBdDjjWoXLCkPWZ/eLZe3Ti9MyGwtiAz
         an8xb+nDsweekAFyG4fw1515dMWcc52bdIwAw3gORtSd9BaRbMfZCklOrnAk/KQD8J29
         CZpDwduNzJUvj4JGHCdaK6AEbZ1Lc8iE4DSDOOtWUCC26z2PKY55ia3S2BXQvlIg7nlr
         QClsh38N3tdwNJZI8PK0JZKdl5dPvqpgPaSWHaRCJMSWyQogFN1LemAP1ZcbgF9XTp8A
         0BAK8PrMXCpEykmIS7uh6FmnU5nbp0i2wHp9G/UrNkBz1V5seeNFqwZgsU5Acfkbuibr
         C/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328777; x=1683920777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh9IeKDPhLqCojjOCexRwPlfwC8qA4P7+b4pfmzZpz8=;
        b=EiZLqZoTu969rWD4FgiyNrk7w+Qw1NyURQYtfdHDKbIJv9pU8KIqAvmMD0f5ohtxG/
         WQ5u7zlPv0rPLX0Dw2s9VfY8Zm0iIBJA70n1ylFazJVwQR+X1XhCXpmor/u1fS7UwQ5z
         uEQVNGtGEJ/CNaB3kH1KfsiZaUcabMuMqiivLJc+IU4W5T3+kYayMCMi9r+prIbrWanV
         F1yHFSt14H8gqWGEMhMSrPjyZTowmVpJPNS18GoThPZO6Z0xc4DtUiy0b2BAXwWT0IOO
         crorL0AzpRsmX0mOqr0t1qxLfc4DwsU7MpvpORQyFXDYcxVwAZrMwO3D9sUgWNRrgHgo
         klLQ==
X-Gm-Message-State: AAQBX9cU8aYILC6ys5QI9H9C/ms+gfkdD7l6rSkp2bQT5gt5knz3BXrS
        ml8rlBuUpojwEIfllB2gDEg=
X-Google-Smtp-Source: AKy350bY02DSUIMCfmdxHozQ9td3hyWBjqRG65bsvgwUFGkHiuLOfGiwzK13OCfzc1M4nM3nMmbmWQ==
X-Received: by 2002:a05:6a20:a888:b0:db:df13:4f73 with SMTP id ca8-20020a056a20a88800b000dbdf134f73mr15411796pzb.26.1681328777334;
        Wed, 12 Apr 2023 12:46:17 -0700 (PDT)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:5010])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ee0f000000b005141568e322sm10650014pgi.81.2023.04.12.12.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:46:16 -0700 (PDT)
Date:   Wed, 12 Apr 2023 12:46:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 9/9] selftests/bpf: Add tests for BPF
 exceptions
Message-ID: <20230412194614.prin3fbc377jlh56@macbook-pro-6.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-10-memxor@gmail.com>
 <20230406023809.jffvgx5r7eyjw24g@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <qcyhnf2nmjyb6yjaqpibv2q6m4tqr63ftxmwuua3k6efjpx77u@5gohye433ufp>
 <20230407023007.uqito235y2aatfb2@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <e3fypriihcxl75uarpqqfqqyln376lmljshzzrx4pa2lskio46@yv2se4ow2yvu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fypriihcxl75uarpqqfqqyln376lmljshzzrx4pa2lskio46@yv2se4ow2yvu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 05:12:24AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri, Apr 07, 2023 at 04:30:07AM CEST, Alexei Starovoitov wrote:
> > On Fri, Apr 07, 2023 at 02:42:14AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Thu, Apr 06, 2023 at 04:38:09AM CEST, Alexei Starovoitov wrote:
> > > > On Wed, Apr 05, 2023 at 02:42:39AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > +static __noinline int throwing_subprog(struct __sk_buff *ctx)
> > > > > +{
> > > > > +	if (ctx)
> > > > > +		bpf_throw();
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +__noinline int global_subprog(struct __sk_buff *ctx)
> > > > > +{
> > > > > +	return subprog(ctx) + 1;
> > > > > +}
> > > > > +
> > > > > +__noinline int throwing_global_subprog(struct __sk_buff *ctx)
> > > > > +{
> > > > > +	if (ctx)
> > > > > +		bpf_throw();
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static __noinline int exception_cb(void)
> > > > > +{
> > > > > +	return 16;
> > > > > +}
> > > > > +
> > > > > +SEC("tc")
> > > > > +int exception_throw_subprog(struct __sk_buff *ctx)
> > > > > +{
> > > > > +	volatile int i;
> > > > > +
> > > > > +	exception_cb();
> > > > > +	bpf_set_exception_callback(exception_cb);
> > > > > +	i = subprog(ctx);
> > > > > +	i += global_subprog(ctx) - 1;
> > > > > +	if (!i)
> > > > > +		return throwing_global_subprog(ctx);
> > > > > +	else
> > > > > +		return throwing_subprog(ctx);
> > > > > +	bpf_throw();
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +__noinline int throwing_gfunc(volatile int i)
> > > > > +{
> > > > > +	bpf_assert_eq(i, 0);
> > > > > +	return 1;
> > > > > +}
> > > > > +
> > > > > +__noinline static int throwing_func(volatile int i)
> > > > > +{
> > > > > +	bpf_assert_lt(i, 1);
> > > > > +	return 1;
> > > > > +}
> > > >
> > > > exception_cb() has no way of knowning which assert statement threw the exception.
> > > > How about extending a macro:
> > > > bpf_assert_eq(i, 0, MY_INT_ERR);
> > > > or
> > > > bpf_assert_eq(i, 0) {bpf_throw(MY_INT_ERR);}
> > > >
> > > > bpf_throw can store it in prog->aux->exception pass the address to cb.
> > > >
> > >
> > > I agree and will add passing of a value that gets passed to the callback
> > > (probably just set it in the exception state), but I don't think prog->aux will
> > > work, see previous mails.
> > >
> > > > Also I think we shouldn't complicate the verifier with auto release of resources.
> > > > If the user really wants to assert when spin_lock is held it should be user's
> > > > job to specify what resources should be released.
> > > > Can we make it look like:
> > > >
> > > > bpf_spin_lock(&lock);
> > > > bpf_assert_eq(i, 0) {
> > > >   bpf_spin_unlock(&lock);
> > > >   bpf_throw(MY_INT_ERR);
> > > > }
> > >
> > > Do you mean just locks or all resources? Then it kind of undermines the point of
> > > having something like bpf_throw IMO. Since it's easy to insert code from the
> > > point of throw but it's not possible to do the same in callers (unless we add a
> > > way to 'catch' throws), so it only works for some particular cases where callers
> > > don't hold references (or in the main subprog).
> >
> > That's a good point. This approach will force caller of functions that can
> > throw not hold any referenced objects (spin_locks, sk_lookup, obj_new, etc)
> > That indeed might be too restrictive.
> > It would be great if we could come up with a way for bpf prog to release resources
> > explicitly though. I'm not a fan of magic release of spin locks.
> >
> 
> I think to realize that, we need a way to 'catch' thrown exceptions in the
> caller. The user will write a block of code that handles release of resources in
> the current scope and resume unwinding (implicitly by calling into some
> intrinsics). 

or we simply don't allow calling subprogs that can throw while holding resources.

> When we discussed this earlier, you rightly mentioned problems
> associated with introducing control flow into the program not seen by the
> compiler (unlike try/catch in something like C++ which has clear semantics).
> 
> But to take a step back, and about what you've said below:
> 
> > bpf_assert is not analogous to C++ exceptions. It shouldn't be seen a mechanism
> > to simplify control flow and error handling.
> 
> When programs get explicit control and handle the 'exceptional' condition, it
> begins to mimic more of an alternative 'slow path' of the program when it
> encounters an error, and starts resembling an alternative error handling
> mechanism pretty much like C++ exceptions.
> 
> I think that was not the goal here, and the automatic release of resources is
> simply supposed to happen to ensure that the kernel's resource safety is not
> violated when a program is aborting. An assertion's should never occur at
> runtime 99.9999% of the time, but when it does, the BPF runtime emits code to
> ensure that the aborting program does not leave the kernel in an inconsistent
> state (memory leaks, held locks that other programs can never take again, etc.).
> 
> So this will involve clean up of every resource it had acquired when it threw.
> If we cannot ensure that we can safely release resources (e.g. throwing in NMI
> context where a kptr_xchg'd pointer cannot be freed), we will bail during
> verification.

exactly. +1 to all of the above. the progs shouldn't be paying run-time cost
for this 0.0001% case.
