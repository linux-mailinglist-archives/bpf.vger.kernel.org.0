Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF344B9CA
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 01:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhKJAzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 19:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhKJAzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 19:55:06 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B018FC061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 16:52:19 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v138so1980962ybb.8
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 16:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLiUSflfHjrv4bVwXjLWlC8eXc0koRkcfcFnyjaHVLA=;
        b=JC2ut83BDZts5WVP2drzX23vtEBBxxUecM4HhBiqqXU/CmKgKHP8opPipT95RdFnXS
         eaKdMfGQr8CKgWy8s6XWukbCLSVlTw3xUri0sfctujVUU0CBrCG2k7Tgwtwdi5NcQZVV
         h1gEM8np1k9kVGP9hRG0V48WO7ILWLsU0SaIKVPCggI2bpStXMUPl+U4hk/JRzqf3HN0
         xH61oiQ4agOCyiMBM3bl4z29oaDj3vHUtolqhEYOMZIIVF2nRIvNzmowrYgZHstvL7Qn
         FeYVE1QWvZIriI81qjm9sqld/o9yMg8TjO/djLSg9HaRH3h8RRd6hfBqLE1vxIIV2ibd
         ljjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLiUSflfHjrv4bVwXjLWlC8eXc0koRkcfcFnyjaHVLA=;
        b=r9B3epW+flXwBGZhtu4me6zTXXY7e52SdLi369Sd4Gtvb+LbIUrE4WbrX1Df1wB3pC
         cZRPIvdOYexxvLNcIxikpHs8lnRZbQHTqEZgUp7gEVy5bVzudfBdZRL7Ront+RSeNtq9
         98eCkNKfVaMHGn8jEBOKKCkmZxd47ozKU8Rjak8dw7FajK7lNPsu15k3er7mynIxiDrW
         sc8kqfZmRpzlLG0+DSkik16+ufBo64NMrQ+8ceuCY9hMBBXJsuPZQ3sB38DGcrRCsyWT
         AiC0ZjNKD7TaMmNlYzc4pERlNbzJHJdIVZnkCL3Imf9YN1Fd3c+/qfiLU71DB+v0eNJK
         Vv2g==
X-Gm-Message-State: AOAM532oagZvIRG4HaypCfUpXV7vtpPeiDxd6JYzsy00CDZnvLjiFHDu
        SGtaiqMaXuaOxw90hDdeZrNa49G+cBn0pgPkaqg=
X-Google-Smtp-Source: ABdhPJwPWC4dHAQWfLnUc+ABrOfBUKSkewHjkWlxAXVp96YAzdyGWxKUfalxCJMBSEyz56TQ7xuv96alKelCMAJzhLY=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr13577671ybe.455.1636505538786;
 Tue, 09 Nov 2021 16:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20211108061316.203217-1-andrii@kernel.org> <20211108061316.203217-5-andrii@kernel.org>
 <20211109034423.2fcwtksijnmywexg@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzaAgpdDK+vyP6Ch=dKD5pa98A1tJfWq--zFosySmruUng@mail.gmail.com> <20211109175312.tb6n3gkymgyyuw5j@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211109175312.tb6n3gkymgyyuw5j@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 16:52:07 -0800
Message-ID: <CAEf4BzbUxjhXSmUDQj2S11wddF9G7uu5=nxnQpX=z_m4icUaTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/11] selftests/bpf: add test_progs flavor using
 libbpf as a shared lib
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:53 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 09, 2021 at 07:42:29AM -0800, Andrii Nakryiko wrote:
> > On Mon, Nov 8, 2021 at 7:44 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sun, Nov 07, 2021 at 10:13:09PM -0800, Andrii Nakryiko wrote:
> > > > Add test_progs-shared flavor to compile against libbpf as a shared
> > > > library. This is useful to make sure that libbpf's backwards/forward
> > > > compatibility guarantees are upheld. Currently this has to be checked
> > > > locally, but in the future we'll automate at least some scenarios as
> > > > part of libbpf CI runs.
> > > >
> > > > Biggest change is how either libbpf.a or libbpf.so is passed to the
> > > > compiler, which is controled on per-flavor through a new TRUNNER_LIBBPF
> > > > parameter. All the places that depend on libbpf artifacts (headers,
> > > > library itself, etc) to be built are moved to order-only dependency on
> > > > $(BPFOBJ). rpath is used to specify relative location to where libbpf.so
> > > > should be so that when test_progs-shared is run under QEMU, libbpf.so is
> > > > still going to be discovered correctly.
> > > >
> > > > Few selftests are using or testing internal libbpf APIs, so are not
> > > > compatible with shared library use of libbpf. Filter them out for shared
> > > > flavor.
> > > ...
> > > > +# Define test_progs-shared test runner.
> > > > +TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> > > > +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
> > > > +TRUNNER_EXTRA_CFLAGS := -Wl,-rpath=$(subst $(CURDIR)/,,$(dir $(BPFOBJ)))
> > > > +TRUNNER_LIBBPF := $(patsubst %libbpf.a,%libbpf.so,$(BPFOBJ))
> > > > +TRUNNER_TESTS_BLACKLIST := cpu_mask.c hashmap.c perf_buffer.c raw_tp_test_run.c
> > > > +$(eval $(call DEFINE_TEST_RUNNER,test_progs,shared))
> > > > +TRUNNER_TESTS_BLACKLIST :=
> > >
> > > It's a good idea to add libbpf.so test, but going through test_progs is imo overkill.
> > > No reason to run more than one test with shared lib.
> > > If it links fine it's pretty much certain that it will work.
> > > Maybe convert test_maps into shared only? CI runs it already.
> >
> > If some APIs are not used from a user app, their symbols won't be used
> > during dynamic linking, so they won't be tested neither for linking
> > nor functionally. E.g., in this case all the btf_dump__new(),
> > btf__dedup(), etc, invocations won't be verified even at dynamic
> > linking time. At least that's my understanding from looking at
> > generated ELF binaries. And that was the sole motivator (at least
> > initially) to add -shared flavor, so that I can make sure it works.
> > Learned a bit about symbol versioning and symbol visibility from that,
> > so definitely not a waste of time.
> >
> > But more broadly, what's the concern? User-space part compilation time
> > for test_progs is extremely fast, it's the BPF object compilation that
> > is slow. I'll send another Makefile change to eliminate the third
> > compilation variant for BPF source code in the next few days (will
> > roll it into this patch set unless it lands first), so that will go
> > away.
>
> exactly. Rebuilding the tests for 3rd variant is a build time waste.

I've built selftests with and without this patch set. With -j8 and
-j80 (because I can ;) ). I forced re-building only the user-space
part (e.g., by `touch flow_dissector_load.h && make -j8`).

WITH SHARED
===========
make -j8  40.47s user 12.85s system 757% cpu 7.037 total
make -j80  65.21s user 22.47s system 4370% cpu 2.006 total

WITHOUT SHARED
==============
make -j8  27.82s user 8.49s system 747% cpu 4.858 total
make -j80  43.56s user 17.95s system 4290% cpu 1.433 total

2.2 seconds and 0.6 seconds build time difference. Hardly that big of a deal.

> Even linking test_progs as shared is misleading.

Because flavor *has to* denote the flavor of BPF? Why is that so?

> There is no need to run such flavor.
> I suspect test_progs doesn't use 100% of libbpf api.

test_progs is the best we have in terms of libbpf API coverage,
though. Not perfect and not 100%, but by far the most complete. And
where all the usability features go into, including parallelization,
error summaries, etc. test_maps is not going to get most (or any) of
that.

> test_maps is using less than test_progs. If the goal is to cover
> all of libbpf then how about adding all calls from libbpf.map
> to test_maps or standalone new binary to check link+run sanity.

I'd rather have end-to-end (including runtime correctness) testing,
especially that it doesn't require lots of new code to be written or
an added ongoing maintenance.

> I understand the appeal to follow the pattern of different
> test_progs flavors, but shared doesn't fit.

It doesn't have to denote *BPF* flavor specifically. It's just a
flavor. We don't have specified anywhere that it has to only specify
differences in how BPF code is built.

> Different flavors are used when tests themselves are compiled differently.
> Not when test_progs runner is different.

*Tests* are compiled differently. Even test_progs.c itself is compiled
differently (it also uses libbpf APIs). Static libbpf vs shared
libbpf. You are talking about BPF programs, but that's only part of
the test, not *the test* in isolation.

> imo standalone binary that calls 100% of func from libbpf.map will
> serve us better in the long run from maintainability pov.

There are literally zero changes to prog_tests/*.c, I fail to see how
that induces maintainability cost.

> That will be an accurate unit test for .so functionality.

Only for dynamic linking part. Not for runtime correctness and proving
that the right versions of symbols were resolved.


I don't think any of the above arguments are really relevant. The
bigger problem is that we will now have a 3rd flavor of test_progs,
which you think everyone will have to run every single time, so that
adds a minute of extra testing time. From my perspective, when I was
working on adding -shared flavor I didn't assume we'll require anyone
to run it, unless they want/need. And I certainly wasn't going to run
it 100% of the time when testing locally.

BPF CI is supposed to run all the flavors, all the time. That's what
I'm optimizing for.

Having said that, the rest of the patch set is way more important. We
can always go back to -shared flavor later, if the need arises. I'll
drop first few patches and resubmit with the + -> || change.
