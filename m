Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7C523BFE
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 19:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbiEKRyY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 13:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345903AbiEKRyN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 13:54:13 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D32297D6
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 10:54:11 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id f3so2652775qvi.2
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBPHCFM11N3f/BZLIfZQ1ckgNpMjLH8X6WK/85i7XD0=;
        b=qCy2lBuYAeTJd8RL1Dr10eyrffLcvXiZC/6+oNitBp79+j24JjNQ0h4wdVWvXeZoll
         CW119XmkKuT0WVkj2U8WN8c1duB9v55H1bnMeG1x1/Vyhfi15URKRci5cGogufwUJAwR
         9zbisVzGTn77GIvDHz87N7B2N4jAkpVODRpdP7stTwXhlLRXphoMRi+MnnEhcyDA4zwl
         CDpkZD8cUVlPvu0lUWxeBoV9pHOOrbVIqHr/oEH9lKZaxSdJg44gd2n3NQxlPgSZWCaU
         aXUyMALY6i1FOS9/wFdb6QGTHW18DmDRfOzcNpQr8jex/h0KKZjD8OkB6cA2hYXkHQoc
         En3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBPHCFM11N3f/BZLIfZQ1ckgNpMjLH8X6WK/85i7XD0=;
        b=BsP+09pfkFeDndNcQTPhPPJKlcr1zNDwIyjcmWAmXCJcd4uFzOytEpNsflXTrM/FfF
         iXxIUBsdSeMPNLBVD5Pk2ZZDpbl3S0s6PoCnORy3a/LOKQwT4OxrVg4b6vNpIOK9lUOE
         1lnvOdXzPke6ozZf8pRtl5zFRP6eSxvFFfZkl77vGHNpIFqCy6pNMl/xvXwhh/Ihq0de
         XunvWp6OKoZQCITew0jDu7tE1P8pn8cVLbdJ22aK5BoF/z0Y7NXn5E90YGETuTABoBlE
         uEIu2MKZSVLQD7sPdix4l5NI4+rXZ2P0jo8usezT3lU1/VFCVACT460OLUc9Ea9pe8pO
         6R3A==
X-Gm-Message-State: AOAM531SNdDIQwbT707wj89o1X5cUMFd24psfxDBHmpgp179x4nNCOMC
        fixo8lp7jCODorAlvqFw16ehHhMM2Dhtlro8Ztg=
X-Google-Smtp-Source: ABdhPJxcGIJnDWKEVr5bYrJ/MF7i/j8/mirdZooQMoNK5R020nLuL9w+az6zgC11erlU6f4asF1e9/Ee3QkPJ2Z7s38=
X-Received: by 2002:ad4:5bea:0:b0:45b:1f7:eee7 with SMTP id
 k10-20020ad45bea000000b0045b01f7eee7mr17003258qvc.11.1652291650889; Wed, 11
 May 2022 10:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220510211727.575686-1-memxor@gmail.com> <20220510211727.575686-3-memxor@gmail.com>
 <CAADnVQ+WFGc4yEAGVuxzbWkXsj2G+U2nN4YmEzMh7SHbHdknjA@mail.gmail.com> <20220511060233.x2ew422zqnoj2itc@apollo.legion>
In-Reply-To: <20220511060233.x2ew422zqnoj2itc@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 11 May 2022 10:53:59 -0700
Message-ID: <CAADnVQKi8mSMv5FMxyptFkAeJetpMgY5oqZz-n-y+WyXiCDbyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Prepare prog_test_struct kfuncs for
 runtime tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 10, 2022 at 11:01 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, May 11, 2022 at 10:07:35AM IST, Alexei Starovoitov wrote:
> > On Tue, May 10, 2022 at 2:17 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > In an effort to actually test the refcounting logic at runtime, add a
> > > refcount_t member to prog_test_ref_kfunc and use it in selftests to
> > > verify and test the whole logic more exhaustively.
> > >
> > > To ensure reading the count to verify it remains stable, make
> > > prog_test_ref_kfunc a per-CPU variable, so that inside a BPF program the
> > > count can be read reliably based on number of acquisitions made. Then,
> > > pairing them with releases and reading from the global per-CPU variable
> > > will allow verifying whether release operations put the refcount.
> >
> > The patches look good, but the per-cpu part is a puzzle.
> > The test is not parallel. Everything looks sequential
> > and there are no races.
> > It seems to me if it was
> > static struct prog_test_ref_kfunc prog_test_struct = {..};
> > and none of [bpf_]this_cpu_ptr()
> > the test would work the same way.
> > What am I missing?
>
> You are not missing anything. It would work the same. I just made it per-CPU for
> the off chance that someone runs ./test_progs -t map_kptr in parallel on the
> same machine. Then one or both might fail, since count won't just be inc/dec by
> us, and reading it would produce something other than what we expect.

I see. You should have mentioned that in the commit log.
But how per-cpu helps in this case?
prog_run is executed with cpu=0, so both test_progs -t map_kptr
will collide on the same cpu.
At the end it's the same. one or both might fail?

In general all serial_ tests in test_progs will fail in
parallel run.
Even non-serial tests might fail.
The non-serial tests are ok for test_progs -j.
They're parallel between themselves, but there are no guarantees
that every individual test can be run parallel with itself.
Majority will probably be fine, but not all.

> One other benefit is getting non-ref PTR_TO_BTF_ID to prog_test_struct to
> inspect cnt after releasing acquired pointer (using bpf_this_cpu_ptr), but that
> can also be done by non-ref kfunc returning a pointer to it.

Not following. non-ref == ptr_untrusted. That doesn't preclude
bpf prog from reading refcnt directly, but disallows passing
into helpers.
So with non-percpu the following hack
 bpf_kfunc_call_test_release(p);
 if (p_cpu->cnt.refs.counter ...)
wouldn't be necessary.
The prog could release(p) and read p->cnt.refs.counter right after.
While with per-cpu approach you had to do
p_cpu = bpf_this_cpu_ptr(&prog_test_struct);
hack and rely on intimate knowledge of the kernel side.

> If you feel it's not worth it, I will drop it in the next version.

So far I see the downsides.
Also check the CI. test_progs-no_alu32 fails:
test_map_kptr_fail_prog:PASS:map_kptr__load must fail 0 nsec
test_map_kptr_fail_prog:FAIL:expected error message unexpected error: -22
Expected: Unreleased reference id=5 alloc_insn=18
Verifier: 0: R1=ctx(off=0,imm=0) R10=fp0
