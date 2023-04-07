Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6046DA7EC
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 05:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjDGDMa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 23:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjDGDM3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 23:12:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D01761B3
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 20:12:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t4so36020821wra.7
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 20:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680837146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lB+uuLaT6cwabzI+H/eHM6Haf1swEEqn3fXHgQXD1DM=;
        b=kLa2ScE9iLy3vacdtgGD9hInWSkNmoCcVH824KrDm9GVTJutJ2g9Czfl0U06ZKpoqQ
         KY7dpRh3mmrveVLDCQjfBcNAU0nx4xarjlAMWa6Fv6CoC0a5QK1V9c2wbPvjPfqicBr5
         L9yn7DcJSKhpzkU5jJZve1+AEFL994drTx4aQHboUoAqLdhYjHnGo+LGIFHaj//+hmNC
         0+GRnn99q2IGokGoj7h6ExnDQSuwrTMLR4a2znJgceIx+oonaGTzpv2P8om1VPhtSTMo
         /lXZYiFM3PWDYMV3fHQML30QnSEaNRsXSQZtX+xpUKEMbV0k8CAKikCwXKe8t/7fSSVN
         9SJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680837146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB+uuLaT6cwabzI+H/eHM6Haf1swEEqn3fXHgQXD1DM=;
        b=xRiSJ2nrMS2Uu9A4HcrpeeoBl4GdulTwka1/Cuuy+DVtAP/5+QUiI1BuCBriHqHg4+
         X7xRtJCbr1XNj00hMSuHN1qTYOYUzTWRIY9K+r2auxN4X9k5sCAPHBZD1K+zBrdFeLJK
         QElBiRi3PmlJiYz6pcBJb2LbrY4GnjrZmudAfFyk9rOzSXN8L8oF/0B3pRcEHPtvptlN
         swnonimBiy9D0WVKNdRi3eG6icpcFB4KgpqdH8Btb+vaS4b1FXWK/6LEwp6frKw5nKFu
         F0hYjnVJw2d7jmcF5bP9bBElxV/pDGxQ5HwGZjFB8pMV4P7e11NCLRAOh+iH2fYTNFWo
         8XYg==
X-Gm-Message-State: AAQBX9e05XwZcfE6FGXBTwcCRjQAe6CJeO9yLu/62jAXnKbfrkqyBNkv
        rlj6WrlDW5pldbjDRJYgXQS1fs1VNskacw==
X-Google-Smtp-Source: AKy350bi/DaRKQfq26bsXh4fBHNifaCzHO95wJYyyIwDCWGFzHf3UzaolleydFn7xKZYvUXlltgoMQ==
X-Received: by 2002:adf:dc0a:0:b0:2e5:5f89:3386 with SMTP id t10-20020adfdc0a000000b002e55f893386mr250290wri.23.1680837145767;
        Thu, 06 Apr 2023 20:12:25 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id b6-20020a05600010c600b002d8566128e5sm3294351wrx.25.2023.04.06.20.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 20:12:25 -0700 (PDT)
Date:   Fri, 7 Apr 2023 05:12:24 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 9/9] selftests/bpf: Add tests for BPF
 exceptions
Message-ID: <e3fypriihcxl75uarpqqfqqyln376lmljshzzrx4pa2lskio46@yv2se4ow2yvu>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-10-memxor@gmail.com>
 <20230406023809.jffvgx5r7eyjw24g@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <qcyhnf2nmjyb6yjaqpibv2q6m4tqr63ftxmwuua3k6efjpx77u@5gohye433ufp>
 <20230407023007.uqito235y2aatfb2@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407023007.uqito235y2aatfb2@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 04:30:07AM CEST, Alexei Starovoitov wrote:
> On Fri, Apr 07, 2023 at 02:42:14AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Thu, Apr 06, 2023 at 04:38:09AM CEST, Alexei Starovoitov wrote:
> > > On Wed, Apr 05, 2023 at 02:42:39AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > +static __noinline int throwing_subprog(struct __sk_buff *ctx)
> > > > +{
> > > > +	if (ctx)
> > > > +		bpf_throw();
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +__noinline int global_subprog(struct __sk_buff *ctx)
> > > > +{
> > > > +	return subprog(ctx) + 1;
> > > > +}
> > > > +
> > > > +__noinline int throwing_global_subprog(struct __sk_buff *ctx)
> > > > +{
> > > > +	if (ctx)
> > > > +		bpf_throw();
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static __noinline int exception_cb(void)
> > > > +{
> > > > +	return 16;
> > > > +}
> > > > +
> > > > +SEC("tc")
> > > > +int exception_throw_subprog(struct __sk_buff *ctx)
> > > > +{
> > > > +	volatile int i;
> > > > +
> > > > +	exception_cb();
> > > > +	bpf_set_exception_callback(exception_cb);
> > > > +	i = subprog(ctx);
> > > > +	i += global_subprog(ctx) - 1;
> > > > +	if (!i)
> > > > +		return throwing_global_subprog(ctx);
> > > > +	else
> > > > +		return throwing_subprog(ctx);
> > > > +	bpf_throw();
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +__noinline int throwing_gfunc(volatile int i)
> > > > +{
> > > > +	bpf_assert_eq(i, 0);
> > > > +	return 1;
> > > > +}
> > > > +
> > > > +__noinline static int throwing_func(volatile int i)
> > > > +{
> > > > +	bpf_assert_lt(i, 1);
> > > > +	return 1;
> > > > +}
> > >
> > > exception_cb() has no way of knowning which assert statement threw the exception.
> > > How about extending a macro:
> > > bpf_assert_eq(i, 0, MY_INT_ERR);
> > > or
> > > bpf_assert_eq(i, 0) {bpf_throw(MY_INT_ERR);}
> > >
> > > bpf_throw can store it in prog->aux->exception pass the address to cb.
> > >
> >
> > I agree and will add passing of a value that gets passed to the callback
> > (probably just set it in the exception state), but I don't think prog->aux will
> > work, see previous mails.
> >
> > > Also I think we shouldn't complicate the verifier with auto release of resources.
> > > If the user really wants to assert when spin_lock is held it should be user's
> > > job to specify what resources should be released.
> > > Can we make it look like:
> > >
> > > bpf_spin_lock(&lock);
> > > bpf_assert_eq(i, 0) {
> > >   bpf_spin_unlock(&lock);
> > >   bpf_throw(MY_INT_ERR);
> > > }
> >
> > Do you mean just locks or all resources? Then it kind of undermines the point of
> > having something like bpf_throw IMO. Since it's easy to insert code from the
> > point of throw but it's not possible to do the same in callers (unless we add a
> > way to 'catch' throws), so it only works for some particular cases where callers
> > don't hold references (or in the main subprog).
>
> That's a good point. This approach will force caller of functions that can
> throw not hold any referenced objects (spin_locks, sk_lookup, obj_new, etc)
> That indeed might be too restrictive.
> It would be great if we could come up with a way for bpf prog to release resources
> explicitly though. I'm not a fan of magic release of spin locks.
>

I think to realize that, we need a way to 'catch' thrown exceptions in the
caller. The user will write a block of code that handles release of resources in
the current scope and resume unwinding (implicitly by calling into some
intrinsics). When we discussed this earlier, you rightly mentioned problems
associated with introducing control flow into the program not seen by the
compiler (unlike try/catch in something like C++ which has clear semantics).

But to take a step back, and about what you've said below:

> bpf_assert is not analogous to C++ exceptions. It shouldn't be seen a mechanism
> to simplify control flow and error handling.

When programs get explicit control and handle the 'exceptional' condition, it
begins to mimic more of an alternative 'slow path' of the program when it
encounters an error, and starts resembling an alternative error handling
mechanism pretty much like C++ exceptions.

I think that was not the goal here, and the automatic release of resources is
simply supposed to happen to ensure that the kernel's resource safety is not
violated when a program is aborting. An assertion's should never occur at
runtime 99.9999% of the time, but when it does, the BPF runtime emits code to
ensure that the aborting program does not leave the kernel in an inconsistent
state (memory leaks, held locks that other programs can never take again, etc.).

So this will involve clean up of every resource it had acquired when it threw.
If we cannot ensure that we can safely release resources (e.g. throwing in NMI
context where a kptr_xchg'd pointer cannot be freed), we will bail during
verification.

> > There are also other ways to go about this whole thing, like having the compiler
> > emit calls to instrinsics which the BPF runtime provides (or have the call
> > configurable through compiler switches), and it already emits the landing pad
> > code to release stuff and we simply receive the table of pads indexed by each
> > throwing instruction, perform necessary checks to ensure everything is actually
> > released correctly when control flow goes through them (e.g. when exploring
> > multiple paths through the same instruction), and unwind frame by frame. That
> > reduces the burden on both the verifier and user, but then it would be probably
> > need to be BPF C++, or have to be a new language extension for BPF C. E.g. there
> > was something about defer, panic, recover etc. in wg14
> > https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2542.pdf . Having the compiler
> > do it is also probably easier if we want 'catch' style handlers.
>
> Interesting idea. __attribute__((cleanup(..))) may be handy, but that's a ton of work.
> I'm in a camp of developers who enforce -fno-exceptions in C++ projects.
> bpf_assert is not analogous to C++ exceptions. It shouldn't be seen a mechanism
> to simplify control flow and error handling.
