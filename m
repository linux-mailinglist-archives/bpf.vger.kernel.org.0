Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D26DA7B4
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 04:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjDGCaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 22:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDGCaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 22:30:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DEA7281
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 19:30:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso373837pjm.3
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 19:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680834610; x=1683426610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0//pLs3q71Nu6UiuHi0ou6T3iRDnfPgTA2uioyNXv3s=;
        b=UsU/HKANl2VEmyQTns21GFUeGh641QO6NFn7lSEP/f5V46qGlTjMv54XoMcDqaTaj0
         dEGX1rhOe7sT3EPumYO5qsxYUwGKV62lirE0pD9NI5q4K0kkvFa4Xb9vsOQnCYw7tSm1
         njAj5ejKE4KLPHvFl8hn3Wss1eUS9l4mmGoywgCOT/Azpvjl+re4z3OERBK1BBG3HaHI
         41X5qzUPR+jLyeZ/TuztdvtVdwhj8Im/kgaBskMimdei17gdkjyQgJWVSkrjo02CaZ7l
         9NSJLpAPyfdWrHFblv84CZfZaAgh9noC1BV8U0uewzHHZ4MRZnpsuM5hxPeMJe93YRHx
         AEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680834610; x=1683426610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0//pLs3q71Nu6UiuHi0ou6T3iRDnfPgTA2uioyNXv3s=;
        b=VeolLL6sUenePDMnPhmSNozV4LWUaPVHtJwkyadn5dIiJqeWtVX/mAFxXc6+UyMGe0
         W7oQbjgYRhUJED/bR+qcr7gBy7Zjy6cqL+mb5kzVfMPcAvZQmVyoF2qg6UiiZKoWxu36
         FvF48n/bpT6X9dsakXkFyenEFUDuY5jG/wcCJPq+ENHZ0QLGFCloDQwy890v5ZrehIRa
         rtzPVGJFF1c8pX55BFj81IpT1tVCoC3Nc2/htc2osgyZRbiaZLan2ECjD9vKrOulk4uf
         dAx+mdPfZPx67LUk4dJbXL75iY9qck0O2F3JlUwqC1rkWBkLq4W29EBZU/cfaAJoAAtK
         TkiA==
X-Gm-Message-State: AAQBX9c/Y+a+jImEjhLutnmsDcFqSuiIHdAFN47SS95ZqHC6Yd9CfHFA
        xH4bWE7483bIV9/X5S5RBCUlfzWUtds=
X-Google-Smtp-Source: AKy350a53mj/6UWrR+lx0vt02Qc4F7kxbi1T23ZsKvFBYzUSxmtJxNw7ZiL0z7cKFJD9LEzV6CG2pg==
X-Received: by 2002:a17:902:da88:b0:1a0:6d9e:3c78 with SMTP id j8-20020a170902da8800b001a06d9e3c78mr1310513plx.53.1680834610308;
        Thu, 06 Apr 2023 19:30:10 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5abd])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001a279237e73sm1873554plo.152.2023.04.06.19.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:30:09 -0700 (PDT)
Date:   Thu, 6 Apr 2023 19:30:07 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 9/9] selftests/bpf: Add tests for BPF
 exceptions
Message-ID: <20230407023007.uqito235y2aatfb2@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-10-memxor@gmail.com>
 <20230406023809.jffvgx5r7eyjw24g@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <qcyhnf2nmjyb6yjaqpibv2q6m4tqr63ftxmwuua3k6efjpx77u@5gohye433ufp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qcyhnf2nmjyb6yjaqpibv2q6m4tqr63ftxmwuua3k6efjpx77u@5gohye433ufp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 07, 2023 at 02:42:14AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu, Apr 06, 2023 at 04:38:09AM CEST, Alexei Starovoitov wrote:
> > On Wed, Apr 05, 2023 at 02:42:39AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > +static __noinline int throwing_subprog(struct __sk_buff *ctx)
> > > +{
> > > +	if (ctx)
> > > +		bpf_throw();
> > > +	return 0;
> > > +}
> > > +
> > > +__noinline int global_subprog(struct __sk_buff *ctx)
> > > +{
> > > +	return subprog(ctx) + 1;
> > > +}
> > > +
> > > +__noinline int throwing_global_subprog(struct __sk_buff *ctx)
> > > +{
> > > +	if (ctx)
> > > +		bpf_throw();
> > > +	return 0;
> > > +}
> > > +
> > > +static __noinline int exception_cb(void)
> > > +{
> > > +	return 16;
> > > +}
> > > +
> > > +SEC("tc")
> > > +int exception_throw_subprog(struct __sk_buff *ctx)
> > > +{
> > > +	volatile int i;
> > > +
> > > +	exception_cb();
> > > +	bpf_set_exception_callback(exception_cb);
> > > +	i = subprog(ctx);
> > > +	i += global_subprog(ctx) - 1;
> > > +	if (!i)
> > > +		return throwing_global_subprog(ctx);
> > > +	else
> > > +		return throwing_subprog(ctx);
> > > +	bpf_throw();
> > > +	return 0;
> > > +}
> > > +
> > > +__noinline int throwing_gfunc(volatile int i)
> > > +{
> > > +	bpf_assert_eq(i, 0);
> > > +	return 1;
> > > +}
> > > +
> > > +__noinline static int throwing_func(volatile int i)
> > > +{
> > > +	bpf_assert_lt(i, 1);
> > > +	return 1;
> > > +}
> >
> > exception_cb() has no way of knowning which assert statement threw the exception.
> > How about extending a macro:
> > bpf_assert_eq(i, 0, MY_INT_ERR);
> > or
> > bpf_assert_eq(i, 0) {bpf_throw(MY_INT_ERR);}
> >
> > bpf_throw can store it in prog->aux->exception pass the address to cb.
> >
> 
> I agree and will add passing of a value that gets passed to the callback
> (probably just set it in the exception state), but I don't think prog->aux will
> work, see previous mails.
> 
> > Also I think we shouldn't complicate the verifier with auto release of resources.
> > If the user really wants to assert when spin_lock is held it should be user's
> > job to specify what resources should be released.
> > Can we make it look like:
> >
> > bpf_spin_lock(&lock);
> > bpf_assert_eq(i, 0) {
> >   bpf_spin_unlock(&lock);
> >   bpf_throw(MY_INT_ERR);
> > }
> 
> Do you mean just locks or all resources? Then it kind of undermines the point of
> having something like bpf_throw IMO. Since it's easy to insert code from the
> point of throw but it's not possible to do the same in callers (unless we add a
> way to 'catch' throws), so it only works for some particular cases where callers
> don't hold references (or in the main subprog).

That's a good point. This approach will force caller of functions that can
throw not hold any referenced objects (spin_locks, sk_lookup, obj_new, etc)
That indeed might be too restrictive.
It would be great if we could come up with a way for bpf prog to release resources
explicitly though. I'm not a fan of magic release of spin locks.

> There are also other ways to go about this whole thing, like having the compiler
> emit calls to instrinsics which the BPF runtime provides (or have the call
> configurable through compiler switches), and it already emits the landing pad
> code to release stuff and we simply receive the table of pads indexed by each
> throwing instruction, perform necessary checks to ensure everything is actually
> released correctly when control flow goes through them (e.g. when exploring
> multiple paths through the same instruction), and unwind frame by frame. That
> reduces the burden on both the verifier and user, but then it would be probably
> need to be BPF C++, or have to be a new language extension for BPF C. E.g. there
> was something about defer, panic, recover etc. in wg14
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2542.pdf . Having the compiler
> do it is also probably easier if we want 'catch' style handlers.

Interesting idea. __attribute__((cleanup(..))) may be handy, but that's a ton of work.
I'm in a camp of developers who enforce -fno-exceptions in C++ projects.
bpf_assert is not analogous to C++ exceptions. It shouldn't be seen a mechanism
to simplify control flow and error handling.
