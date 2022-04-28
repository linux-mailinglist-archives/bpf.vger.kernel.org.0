Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E05128ED
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 03:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiD1Bko (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 21:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240730AbiD1Bkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 21:40:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208396B086
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 18:37:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o69so1583405pjo.3
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 18:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6T59ytWJ8UNOXplrmRGA1DGd2Dy4dShocYWhnOSb6fs=;
        b=jdDFZOI5qvNFNwY2UUGib32de/NfjXEarnnJUjimWXATtYVg66P7WSzrtBjkjNa49n
         gNHpbk1pRJwMgoUgNqL0jbw5tafKUBaO8c1sDgWnQknPA9ANsVdpSdRbUSQ3BvY7I93o
         UJoHTGVR0t/FpIGKJpNmTKopeS1MFa0+X/pZz8LaemksstjKO3WfwR+0qyrZI+HDl1np
         yr4LkOdrAm/+nocyBQg+Io7/yRQnZdRuXnh1ecgme8IfPeY+EfbZm2oQG1XUf9dJUVpS
         C5p/deJPE4ZaSWKvbxGRbjRPCedc7Ymdf2CpVZkVC2ymOdFBFskn2ELkxVvYckGjXrCe
         oVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6T59ytWJ8UNOXplrmRGA1DGd2Dy4dShocYWhnOSb6fs=;
        b=A4OZoTIDFAYa+QSkTLNW1Pzs2Ax4gbx3RlTj0WSh9M/RhZJJe4Zkon9ZLMrNc2WnKD
         U61jYwpxPjKtqZhlz+ROXQITJTscvSeKkgnqvZaWwzTeupplw2AZRkNBVfIRCqc6JjoK
         jsAf1quSLxXhhdFbfaVZ6G7TO3Lm8lni1UR5MSZfar/EkEDKcbQdQNf1DZY31V9VO4kO
         N/SutyxPdzLtAde5SiRQ47/7wjUxf3WypTCk6NBH7fMg21H8NgE3Xhd9+HxDaqwiT55Y
         D/3UW2fkHWyn73I1LKeMy9r+byTIZJ3doHk+tejVgJmvx9ASfLYaaoZTXxXcfm7LRwym
         SBZw==
X-Gm-Message-State: AOAM531By1jOAkaHnUjSDKRCnM48dITZlVLXvhSNhbFwL1U/pgWB4h3D
        FmolpC8RTGwPAjjvMqFXwrVNBktGnf6vMZL+C2c=
X-Google-Smtp-Source: ABdhPJwUzGnwQMrgWK5SVx+R3n5y5hZZErozUezfT2hu2XVidzX4GX+jGt3dx6CYad1oYJK4acvmS2rH07QnAp54BSE=
X-Received: by 2002:a17:90a:8591:b0:1b9:da10:2127 with SMTP id
 m17-20020a17090a859100b001b9da102127mr46949620pjn.13.1651109849517; Wed, 27
 Apr 2022 18:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com> <20220422025212.n4c25z23rj2pp3yu@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAJnrk1ZczWZi4SAGTqoY1764oei8gCzcEA9a7608R4H2XkisrA@mail.gmail.com>
 <CAADnVQK9dKfnz=MwWvb67diEMf5XrppGZr5GiOWgvBkaNaX1RA@mail.gmail.com>
 <CAEf4BzZdRM1icwQu0pBUCOw_zsoHft9RF_O3VNqcDxdRjDd57w@mail.gmail.com> <CAJnrk1aj50==BxOJrkCc=MttL8Wter6G6_4QGwsEcXRLmH2XKg@mail.gmail.com>
In-Reply-To: <CAJnrk1aj50==BxOJrkCc=MttL8Wter6G6_4QGwsEcXRLmH2XKg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 27 Apr 2022 18:37:18 -0700
Message-ID: <CAADnVQ+ZXZ0Qq8PhQK-OE7+YAYkc+iA_S0Ah6dbv6d0x1DeaoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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

On Wed, Apr 27, 2022 at 4:28 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Tue, Apr 26, 2022 at 8:53 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 6:26 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Apr 26, 2022 at 4:45 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > >
> > > > > I guess it's ok to treat refcnted dynptr special like above.
> > > > > I wonder whether we can reuse check_reference_leak logic?
> > > > I like this idea! My reason for not storing dynptr reference ids in
> > > > state->refs was because it's costly (eg we realloc_array every time we
> > > > acquire a reference). But thinking about this some more, I like the
> > > > idea of keeping everything unified by having all reference ids reside
> > > > within state->refs and checking for leaks the same way. Perhaps we can
> > > > optimize acquire_reference_state() as well where we upfront allocate
> > > > more space for state->refs instead of having to do a realloc_array
> > > > every time.
> > >
> > > realloc is decently efficient underneath.
> > > Probably not worth micro optimizing for it.
> > > As far as ref state... Looks like dynptr patch is trying
> > > hard to prevent writes into the stack area where dynptr
> > > was allocated. Then cleans it up after dynptr_put.
> > > For other pointers on stack we just mark the area as stack_misc
> > > only when the stack slot was overwritten.
> > > We don't mark the slot as 'misc' after the pointer was read from stack.
> > > We can use the same approach with dynptr as long as dynptr
> > > leaking is tracking through ref state
> > > (instead of for(each stack slot) at the time of bpf_exit)
> I think the trade-off with this is that the verifier error message
> will be more ambiguous (eg if you try to call bpf_dynptr_put, the
> message would be something like "arg 1 is an unacquired reference" vs.
> a more clear-cut message like "direct write into dynptr is not
> permitted" at the erring instruction). But I think that's fine. I will
> change it to mark the slot as misc for v3.

I'm trying to say that
"direct write into dynptr is not permitted"
could be just as confusing to users,
because the store instruction into that stack slot
was generated by the compiler because of some optimization
and the user has no idea why that code was generated.
