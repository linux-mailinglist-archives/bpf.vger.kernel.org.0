Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C555D512784
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 01:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbiD0Xbb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 19:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiD0XbY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 19:31:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E71186E6
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 16:28:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y32so5710833lfa.6
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 16:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPC6xX3QBFQMxbfLjfRSsgUfxM06oRmtaupVeJtFiSc=;
        b=fBWMmahL+K6mBUghpreAckptr7ZWRl/2SHjuEYp+B4VavrFivCcdRH4AGuaLcZvRe4
         3oZtKT7kgSgNRs8iVSYrWCV1kTLHvSgx5n18lWz4hA1rR84o56kHXU5C5Dqq4qVED1ui
         KfIZfw2qLl51OqVWrWC0x9FSeZoZhpXm+Hj+t1/v+dgReoj9KW7ItvSwH+gKvK6MiFjd
         ciiWy9B1yx8QRWQO0lIfGx0huJidMSjiCMrVDnv+WrK59ZhDGdDr8YeU05PKBl/Wby0M
         nPUqWhf2Rhphrj/7dHax8gYov+UnAH9ngOvJ5it068S/9AynRF8OCDocKeZuO3m/h0i4
         sT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPC6xX3QBFQMxbfLjfRSsgUfxM06oRmtaupVeJtFiSc=;
        b=LVpHWbpCODMJaSeVB0NKbSHc5npRzkhzWYdVAu/+3tGHhTRkeijOpFIuiLMkk8eQA0
         CA/DDUA9sekTw1A0QwDnUfLMrmnDymiGmXilRAQP2AbOTnSvBcHz1aVHwfmMzMHsfHGi
         FPa5iuaKivtlW7VcJzKYPsuRxZPIdtfXD0hKWzs5aya8yGp6CxuJ89zGcURDG2kzGNFN
         txsP90ZAfcj4MS5b/3dz2bPrco1En+8OTwHOJHqeK63yWLiIyeidFc0+uH34Klji29GH
         a2Bjat5+KakG8Bq+ckl4h87AhHBmEWyDZwmQcshur51tgJW1n9p8LAM6aF9yugxOAgio
         T4zg==
X-Gm-Message-State: AOAM5327F08TDXupoJeJ8sZqInJ44G7R1kiOxCfZqyXox8cJR58ilH+/
        aq83DdjXLQS9rTtJzR7DSEOPFUU/tNVE8H7VO6FYuVkVHRM=
X-Google-Smtp-Source: ABdhPJzgajhifYHAxLOitvNDIZmZ+yV3vxLQXqhiP9uU74AYaSu/r4A5H+ThLGrY+rd5XMyMIA7WC9EevjfTiJDP4cE=
X-Received: by 2002:a05:6512:3995:b0:472:38f5:9452 with SMTP id
 j21-20020a056512399500b0047238f59452mr332104lfu.540.1651102090331; Wed, 27
 Apr 2022 16:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com> <20220422025212.n4c25z23rj2pp3yu@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAJnrk1ZczWZi4SAGTqoY1764oei8gCzcEA9a7608R4H2XkisrA@mail.gmail.com>
 <CAADnVQK9dKfnz=MwWvb67diEMf5XrppGZr5GiOWgvBkaNaX1RA@mail.gmail.com> <CAEf4BzZdRM1icwQu0pBUCOw_zsoHft9RF_O3VNqcDxdRjDd57w@mail.gmail.com>
In-Reply-To: <CAEf4BzZdRM1icwQu0pBUCOw_zsoHft9RF_O3VNqcDxdRjDd57w@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 27 Apr 2022 16:27:59 -0700
Message-ID: <CAJnrk1aj50==BxOJrkCc=MttL8Wter6G6_4QGwsEcXRLmH2XKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Tue, Apr 26, 2022 at 8:53 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 26, 2022 at 6:26 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 4:45 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > >
> > > > I guess it's ok to treat refcnted dynptr special like above.
> > > > I wonder whether we can reuse check_reference_leak logic?
> > > I like this idea! My reason for not storing dynptr reference ids in
> > > state->refs was because it's costly (eg we realloc_array every time we
> > > acquire a reference). But thinking about this some more, I like the
> > > idea of keeping everything unified by having all reference ids reside
> > > within state->refs and checking for leaks the same way. Perhaps we can
> > > optimize acquire_reference_state() as well where we upfront allocate
> > > more space for state->refs instead of having to do a realloc_array
> > > every time.
> >
> > realloc is decently efficient underneath.
> > Probably not worth micro optimizing for it.
> > As far as ref state... Looks like dynptr patch is trying
> > hard to prevent writes into the stack area where dynptr
> > was allocated. Then cleans it up after dynptr_put.
> > For other pointers on stack we just mark the area as stack_misc
> > only when the stack slot was overwritten.
> > We don't mark the slot as 'misc' after the pointer was read from stack.
> > We can use the same approach with dynptr as long as dynptr
> > leaking is tracking through ref state
> > (instead of for(each stack slot) at the time of bpf_exit)
I think the trade-off with this is that the verifier error message
will be more ambiguous (eg if you try to call bpf_dynptr_put, the
message would be something like "arg 1 is an unacquired reference" vs.
a more clear-cut message like "direct write into dynptr is not
permitted" at the erring instruction). But I think that's fine. I will
change it to mark the slot as misc for v3.
> >
> > iirc we've debugged the case where clang reused stack area
> > with a scalar that was previously used for stack spill.
> > The dynptr on stack won't be seen as stack spill from compiler pov
> > but I worry about the case:
> > struct bpf_dynptr t;
> > bpf_dynptr_alloc(&t,..);
> > bpf_dynptr_put(&t);
> > // compiler thinks the stack area of 't' is dead and reuses
> > // it for something like scalar.
> > Even without dynptr_put above the compiler might
> > see that dynptr_alloc or another function stored
> > something into dynptr, but if nothing is using that
> > dynptr later it might consider the stack area as dead.
> > We cannot mark every dynptr variable as volatile.
> >
> > Another point to consider...
> > This patch unconditionally tells the verifier to
> > unmark_stack_slots_dynptr() after bpf_dynptr_put().
> > But that's valid only for refcnt=1 -> 0 transition.
> > I'm not sure that will be forever the case even
> > for dynptr-s on stack.
> > If we allows refcnt=2,3,... on stack then
> > the verifier won't be able to clear stack slots
> > after bpf_dynptr_put and we will face the stack reuse issue.
> > I guess the idea is that refcnt-ed dynptr will be only in a map?
> > That might be inconvenient.
> > We allow refcnt-ed kptrs to be in a map, in a register,
> > and spilled to the stack.
> > Surely, dynptr are more complex in that sense.
>
> struct dynptr on the stack isn't by itself refcounted. E.g., if we
> have dynptr pointing to PTR_TO_MAP_VALUE there is no refcounting
> involved and we don't have to do bpf_dynptr_put(). The really
> refcounted case is malloc()'ed memory pointed to by dynptr. But in
> this case refcount is stored next to the actual memory, not inside
> struct bpf_dynptr. So when we do bpf_dynptr_put() on local struct
> dynptr copy, it decrements refcount of malloc()'ed memory. If it was
> the last refcnt, then memory is freed. But we can still have other
> copies (e.g., in another on-the-stack struct bpf_dynptr copy of BPF
> program that runs on another CPU, or inside the map value) which will
> keep allocated memory.
>
> bpf_dynptr_put() are just saying "we are done with our local instance
> of struct bpf_dynptr and that slot can be reused for something else".
> So Clang deciding to reuse that stack slot for something unrelated
> after bpf_dynptr_put() should be fine.
