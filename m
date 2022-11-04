Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D377461A54E
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKDXDD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKDXDB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:03:01 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F94326E0
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 16:02:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b5so5582489pgb.6
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzDwYg/jBVo6GJF4CZyJvC9Rpe9GVn043nzxijNyMPY=;
        b=jig2TyfQrYF2r6lG6PcfFvBvyPrgtCwXTH7/20ExHy1CmCeaRxH9xQEQ0u6a88RhQn
         ubE4uxwjLDKBwlQ8lwUw/yF1iQ2xNKmH5PFFTylTRwAE5mHnPD9UntZDN/Ssnga/S0n6
         KDbMPPmayQLpfMh2VUXWy1reNbWlpzpb9k+RGtx1s77ChIisZyIuGZhQmmQ159D7ylSm
         4ssWj9tOm+A4diqWNyeRHW5x6XbsXVGjjC0poz010sQNnOUaW9r6V/6PBBkxNlXI5xF+
         /M7kuWDm1V1i1U8r/H//l2VP+Aj2ik2DCguY8NOs+ZnuSqQoVIvUaMZjtfrgD5RxDMGD
         8yRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzDwYg/jBVo6GJF4CZyJvC9Rpe9GVn043nzxijNyMPY=;
        b=Xof///3d2bYwNzmq6cSi4W2pMlRxW9DLPbJm/UkhUGHhw5C8ZPWGTL6/6o8Rqf/0us
         1gtJMAp8dQSunOaXt8hnSbe7+4jjsG8yUhAtBlg8LucxWkbRb7zuRv7G6yFN1uN49zl0
         +4MO779FPSS0juiQ8F/dOPxJnUzAnYH1t1Gh5xLtnOhXUd56xRtaEG+kHYfATXPzH3mS
         woiOkTClUQuh0OYsdQ4jXdJL0gElp5znJ0Apijm6hfeFHz7prWq29VjafcRjpKZWSvkx
         Q/avnya7l+OsMcT+U6yoy3r7fZLqNqcVvETkVQ2eP2Fl75Wk1noqRt3wGzgOe/5W1mwh
         mIqg==
X-Gm-Message-State: ACrzQf1xL9hVJfdxLD+4llBy0QfFg0vnWQeP1IKKb0FuWl9s3tCocXw0
        Qu3FJaEUPqdEv7xUKaPXap/FcLEBVxRe6A==
X-Google-Smtp-Source: AMsMyM7MoiCr9oUrbas9J3o/nC+siTr8MPjCF77uu5u920ciER3ixwMzmyxpq503j8d3V/IK6mnjMg==
X-Received: by 2002:a05:6a02:10e:b0:43b:e57d:2bfa with SMTP id bg14-20020a056a02010e00b0043be57d2bfamr31659536pgb.263.1667602977632;
        Fri, 04 Nov 2022 16:02:57 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b0018157b415dbsm273105plg.63.2022.11.04.16.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 16:02:57 -0700 (PDT)
Date:   Sat, 5 Nov 2022 04:32:56 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 07/13] bpf: Fix partial dynptr stack slot
 reads/writes
Message-ID: <20221104230256.hjy53o2fmiugyzgh@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-8-memxor@gmail.com>
 <CAJnrk1Y_zn+oR3pN8bd3tHV2VubFxBc00XhcNzaWzHkSn1-UMw@mail.gmail.com>
 <20221022040830.usuuoeq35mj7vnxe@apollo>
 <CAJnrk1Zucjztcp-jjp_eRszU+P8BJv71-WimLybEqLtPx_T3mQ@mail.gmail.com>
 <CAEf4BzYKJJko-f-kGL1sv2CmAf3-HUKiVy7hNYucOTRCDZsEAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYKJJko-f-kGL1sv2CmAf3-HUKiVy7hNYucOTRCDZsEAg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 05, 2022 at 03:44:53AM IST, Andrii Nakryiko wrote:
> On Thu, Nov 3, 2022 at 7:07 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Sat, Oct 22, 2022 at 5:08 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Sat, Oct 22, 2022 at 04:20:28AM IST, Joanne Koong wrote:
> > > > [...]
> > > >
> > > > thanks for your work on this (and on the rest of the stack, which I'm
> > > > still working on reviewing)
> > > >
> > > > Regarding writes leading to partial dynptr stack slots, I'm regretting
> > > > not having the verifier flat-out reject this in the first place
> > > > (instead of it being allowed but internally the stack slot gets marked
> > > > as invalid) - I think it overall ends up being more confusing to end
> > > > users, where there it's not obvious at all that writing to the dynptr
> > > > on the stack automatically invalidates it. I'm not sure whether it's
> > > > too late from a public API behavior perspective to change this or not.
> > >
> > > It would be incorrect to reject writes into dynptrs whose reference is not
> > > tracked by the verifier (so bpf_dynptr_from_mem), because the compiler would be
> > > free to reuse the stack space for some other variable when the local dynptr
> > > variable's lifetime ends, and the verifier would have no way to know when the
> > > variable went out of scope.
> > >
> > > I feel it is also incorrect to refuse bpf_dynptr_from_mem where unref dynptr
> > > already exists as well. Right now it sees STACK_DYNPTR in the slot_type and
> > > fails. But consider something like this:
> > >
> > > void prog(void)
> > > {
> > >         {
> > >                 struct bpf_dynptr ptr;
> > >                 bpf_dynptr_from_mem(...);
> > >                 ...
> > >         }
> > >
> > >         ...
> > >
> > >         {
> > >                 struct bpf_dynptr ptr;
> > >                 bpf_dynptr_from_mem(...);
> > >         }
> > > }
> > >
> > > The program is valid, but if ptr in both scopes share the same stack slots, the
> > > call in the second scope would fail because verifier would see STACK_DYNPTR in
> > > slot_type.
>
> I don't think compiler is allowed to reuse the same stack slot for
> those two ptrs, because we are passing a pointer to it into a
> black-box bpf_dynptr_from_mem() function, so kernel can't assume that
> this slot is free to be reused just because no one is accessing it
> after bpf_dynptr_from_mem (I think?)
>

At the C level, once the lifetime of the object ends upon execution going out of
its enclosing scope, even if its pointer escaped, the ending of the lifetime
implicitly invalidates any such pointers (as per the abstract machine), so the
compiler is well within its rights (because using such a pointer any more is UB)
to reuse the same storage for another object.

E.g. https://godbolt.org/z/Wcvzfbfbr

For the following:

struct bpf_dynptr {
	unsigned long a, b;
};

extern void bpf_dynptr_func(struct bpf_dynptr *);
extern void bpf_dynptr_ro(const struct bpf_dynptr *);

int main(void)
{
	{
		struct bpf_dynptr d2;

		bpf_dynptr_func(&d2);
		bpf_dynptr_ro(&d2);
	}
	{
		struct bpf_dynptr d3;

		bpf_dynptr_func(&d3);
		bpf_dynptr_ro(&d3);
	}
}

clang produces:

main:                                   # @main
        r6 = r10
        r6 += -16
        call bpf_dynptr_func
        call bpf_dynptr_ro
        r6 = r10
        r6 += -16
        call bpf_dynptr_func
        call bpf_dynptr_ro
        exit

> Would it make sense to allow *optional* bpf_dynptr_free (of is it
> bpf_dynptr_put, not sure) for non-reference-tracked dynptrs if indeed
> we wanted to reuse the same stack variable for multiple dynptrs,
> though?

I think it's fine to simply overwrite the type of object when reusing the same
stack slot.

For some precedence:

This is what compilers essentially do for effective(C)/dynamic(C++) types, for
instance GCC will simply overwrite the effective type of the object (even for
declared objects, even though standard only permits overwriting it for allocated
objects) whenever you do a store using a lvalue of some type T or memcpy
(transferring the effective type to dst).

For a more concrete analogy, Storage Reuse in
https://en.cppreference.com/w/cpp/language/lifetime describes how placement new
simply reuses storage of trivially destructible objects without requiring the
destructor to be called. Since it is C++ if you replace storage of non-trivial
object it must be switched back to the same type before the runtime calls the
original destructors emitted implicitly for declared type.

So in BPF terms, local dynptr (dynptr_from_mem) is trivially destructible, but
ringbuf dynptr requires its 'destructor' to be called before storage is reused.

There are two choices in the second case, either complain when such a ringbuf
dynptr's storage is reused without calling its release function, or the verifier
will complain later when seeing an unreleased reference. I think complaining
early is better as later the user has to correlate insn_idx of leaked reference.
The program is going to fail in both cases anyway, so it makes sense to give a
better error back to the user.
