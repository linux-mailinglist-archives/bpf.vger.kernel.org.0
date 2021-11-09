Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B510844B238
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 18:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbhKIR4B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 12:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbhKIR4B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 12:56:01 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24DDC061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 09:53:14 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q126so15230548pgq.13
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oeuup7j2gkbJ0fT5ShuzfLxpN96zbdUzhVL0/5YTsyk=;
        b=QfZZrvVHaNJPoqzWRf/2IcggemCCHIdrsbMX5aT/21A2W9oulsVPUZoaY+VKfs+9xb
         lXNer9Ye+gyVow9uohnWj0WeUih+W7O2PA6xbtVEPYVObLQdJ0lTZG9zALaWKZro9Llg
         CukiSfU2CepQIXfyJyP+RSvYDUJbr6Cc8jZLh1/jXsMcqql+TYyyEIBqqdfOqXEw+Zhk
         wTBHsV6IiBRg/AWFoKIGtDfs+eSDOYJ5iltp0NIgOet5y1137xDKjeVkzzaFGSIcJ6A2
         2nfh+DjzkXwQyss0wBa6cGEoCO/83EIKUBdVv2/EC3XBsLEMx4ckeChusGsfC8hJggW4
         PopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeuup7j2gkbJ0fT5ShuzfLxpN96zbdUzhVL0/5YTsyk=;
        b=iccFqTkJRpT8AwvSSXUib1XjDhSckH+ljwwwzuRjGn9vlyQDbhYFX8hDdmch7oZwcI
         iscPCyilFYcVhxDuq8/8G0aYZkDtaHZ97uEa3jLFn0irJ3mXZ7IfEYPRiK4ND/lizmgt
         IDIx/ewyfayY9ASRf2KHPZcLe1xqFkqVYLAatvsgt2VK5RqclmJo46DgP3eGXDds0LyM
         NUejc+URi6OSz1zsoLKssiQBmGr4uHt9Gi4ZpASS7Tl1Di/44qbCoQke3C7PmZuCmeZU
         Rs3wFREjbWj5131uRpNjzPNp8NVC0QBQEkEDKigwvJengwIw0paHze2xjtHH5/uU4DUD
         /eCA==
X-Gm-Message-State: AOAM531ELrTABBdGt7ReaZ/hBipmFwSTVTxvP1Ul8Uvds26uLyEc5TzP
        jhYu3aJLXxfUKZoEvesO+No=
X-Google-Smtp-Source: ABdhPJyKFZ5PImBrx7lgSwB/ea2gf92h0PGfQvmcUd96eKRuSonlQ2tlUNWHFBUwC54gjvJ+oPBv3Q==
X-Received: by 2002:a62:52cd:0:b0:49f:a7b8:69ad with SMTP id g196-20020a6252cd000000b0049fa7b869admr32739137pfb.3.1636480394475;
        Tue, 09 Nov 2021 09:53:14 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:f8f1])
        by smtp.gmail.com with ESMTPSA id q6sm5362752pgn.42.2021.11.09.09.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 09:53:14 -0800 (PST)
Date:   Tue, 9 Nov 2021 09:53:12 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 04/11] selftests/bpf: add test_progs flavor
 using libbpf as a shared lib
Message-ID: <20211109175312.tb6n3gkymgyyuw5j@ast-mbp.dhcp.thefacebook.com>
References: <20211108061316.203217-1-andrii@kernel.org>
 <20211108061316.203217-5-andrii@kernel.org>
 <20211109034423.2fcwtksijnmywexg@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzaAgpdDK+vyP6Ch=dKD5pa98A1tJfWq--zFosySmruUng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaAgpdDK+vyP6Ch=dKD5pa98A1tJfWq--zFosySmruUng@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 09, 2021 at 07:42:29AM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 8, 2021 at 7:44 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Nov 07, 2021 at 10:13:09PM -0800, Andrii Nakryiko wrote:
> > > Add test_progs-shared flavor to compile against libbpf as a shared
> > > library. This is useful to make sure that libbpf's backwards/forward
> > > compatibility guarantees are upheld. Currently this has to be checked
> > > locally, but in the future we'll automate at least some scenarios as
> > > part of libbpf CI runs.
> > >
> > > Biggest change is how either libbpf.a or libbpf.so is passed to the
> > > compiler, which is controled on per-flavor through a new TRUNNER_LIBBPF
> > > parameter. All the places that depend on libbpf artifacts (headers,
> > > library itself, etc) to be built are moved to order-only dependency on
> > > $(BPFOBJ). rpath is used to specify relative location to where libbpf.so
> > > should be so that when test_progs-shared is run under QEMU, libbpf.so is
> > > still going to be discovered correctly.
> > >
> > > Few selftests are using or testing internal libbpf APIs, so are not
> > > compatible with shared library use of libbpf. Filter them out for shared
> > > flavor.
> > ...
> > > +# Define test_progs-shared test runner.
> > > +TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> > > +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
> > > +TRUNNER_EXTRA_CFLAGS := -Wl,-rpath=$(subst $(CURDIR)/,,$(dir $(BPFOBJ)))
> > > +TRUNNER_LIBBPF := $(patsubst %libbpf.a,%libbpf.so,$(BPFOBJ))
> > > +TRUNNER_TESTS_BLACKLIST := cpu_mask.c hashmap.c perf_buffer.c raw_tp_test_run.c
> > > +$(eval $(call DEFINE_TEST_RUNNER,test_progs,shared))
> > > +TRUNNER_TESTS_BLACKLIST :=
> >
> > It's a good idea to add libbpf.so test, but going through test_progs is imo overkill.
> > No reason to run more than one test with shared lib.
> > If it links fine it's pretty much certain that it will work.
> > Maybe convert test_maps into shared only? CI runs it already.
> 
> If some APIs are not used from a user app, their symbols won't be used
> during dynamic linking, so they won't be tested neither for linking
> nor functionally. E.g., in this case all the btf_dump__new(),
> btf__dedup(), etc, invocations won't be verified even at dynamic
> linking time. At least that's my understanding from looking at
> generated ELF binaries. And that was the sole motivator (at least
> initially) to add -shared flavor, so that I can make sure it works.
> Learned a bit about symbol versioning and symbol visibility from that,
> so definitely not a waste of time.
> 
> But more broadly, what's the concern? User-space part compilation time
> for test_progs is extremely fast, it's the BPF object compilation that
> is slow. I'll send another Makefile change to eliminate the third
> compilation variant for BPF source code in the next few days (will
> roll it into this patch set unless it lands first), so that will go
> away.

exactly. Rebuilding the tests for 3rd variant is a build time waste.
Even linking test_progs as shared is misleading.
There is no need to run such flavor.
I suspect test_progs doesn't use 100% of libbpf api.
test_maps is using less than test_progs. If the goal is to cover
all of libbpf then how about adding all calls from libbpf.map
to test_maps or standalone new binary to check link+run sanity.
I understand the appeal to follow the pattern of different
test_progs flavors, but shared doesn't fit.
Different flavors are used when tests themselves are compiled differently.
Not when test_progs runner is different.
imo standalone binary that calls 100% of func from libbpf.map will
serve us better in the long run from maintainability pov.
That will be an accurate unit test for .so functionality.
