Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD07B44B092
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 16:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhKIPpa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 10:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbhKIPp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 10:45:29 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75757C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 07:42:43 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v7so54152709ybq.0
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6awoos2fVF3Ff0e+PY6waI6ohoqrOW5oOwOMGZV4ovY=;
        b=X9rxtXj9sXbLhGn1r8AKpZ6gXHZ8nW814Nqc6/1TzLcb6qyB3ac53fMR2XjB8ppl+d
         j2fVqGd3JvjVVf6h5M4IzTfPmugWi9/n5SqvqRDffdKIRYEYqXu6hXWzs4kuLMQSfahj
         TajOrVw7Qx9txduDPLCukhIRP+I2Vgd/gt/uoJTmvfCK3d8RqvuTfxkDMsqCy5UtXq6q
         5rNcJhYS4+jge8EPN9TwJ1XBTljF8QMX04baS8lCLlQqe4nAzsn1i6VhDs1qpLvsUgt+
         7IGJGoh2OHV1KgghJ9lQi8eUlfyL3Xcp4fXPR3p3RNquYVEpf0oBDSrtYzfp4aUkRbEt
         8jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6awoos2fVF3Ff0e+PY6waI6ohoqrOW5oOwOMGZV4ovY=;
        b=ivr8gTAr3iIoc53kNbKO75O0LxvhX0+CmEwancyp6y2ertC0jsLRIKsLwvlxDa4f73
         r3NQ0wSoLL5JgxYCnVj54NviRGwfYWuVYolfAlSqCYxNGwDilt7AADtmoym6ncxHfkhu
         q8iRA6L3HiuD3Y9SQdz5zGwi5YK/ThuryTIHlCYLxLFbXF7BzsI/cT3qToCW8a00BjrB
         O9K2x5Z43XkD8o/fDvd4Lt3W91H87cLYK/7FidlX06CpdEDtKd3nDKPRCENFuizFJVlo
         yxpiwyNxgmx19YwASFJ6m+AkJWHORorzyRQC5zJnWx3Ev1zu0IVFbDwjbr7t3qPIGS1z
         ew/g==
X-Gm-Message-State: AOAM532kp2DmGrNGQ3RadwmJnd4EXyYbhZWdrTJ4nY3AH3GowcYp7AGH
        zYufAQ+iJBUiEtNcrzflQmPzzQnUc4JCYUvVUu2O0DZv
X-Google-Smtp-Source: ABdhPJzzPTH2Z2qvVMEtpl2Y3OI0VrKCFDDlUn4fOhNryHsKhzIz2Z7JFPIUgbeMXDRurfJMqC/t6jVdGdu6II1tYYs=
X-Received: by 2002:a25:d010:: with SMTP id h16mr10448192ybg.225.1636472562690;
 Tue, 09 Nov 2021 07:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20211108061316.203217-1-andrii@kernel.org> <20211108061316.203217-5-andrii@kernel.org>
 <20211109034423.2fcwtksijnmywexg@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211109034423.2fcwtksijnmywexg@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 07:42:29 -0800
Message-ID: <CAEf4BzaAgpdDK+vyP6Ch=dKD5pa98A1tJfWq--zFosySmruUng@mail.gmail.com>
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

On Mon, Nov 8, 2021 at 7:44 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Nov 07, 2021 at 10:13:09PM -0800, Andrii Nakryiko wrote:
> > Add test_progs-shared flavor to compile against libbpf as a shared
> > library. This is useful to make sure that libbpf's backwards/forward
> > compatibility guarantees are upheld. Currently this has to be checked
> > locally, but in the future we'll automate at least some scenarios as
> > part of libbpf CI runs.
> >
> > Biggest change is how either libbpf.a or libbpf.so is passed to the
> > compiler, which is controled on per-flavor through a new TRUNNER_LIBBPF
> > parameter. All the places that depend on libbpf artifacts (headers,
> > library itself, etc) to be built are moved to order-only dependency on
> > $(BPFOBJ). rpath is used to specify relative location to where libbpf.so
> > should be so that when test_progs-shared is run under QEMU, libbpf.so is
> > still going to be discovered correctly.
> >
> > Few selftests are using or testing internal libbpf APIs, so are not
> > compatible with shared library use of libbpf. Filter them out for shared
> > flavor.
> ...
> > +# Define test_progs-shared test runner.
> > +TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> > +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
> > +TRUNNER_EXTRA_CFLAGS := -Wl,-rpath=$(subst $(CURDIR)/,,$(dir $(BPFOBJ)))
> > +TRUNNER_LIBBPF := $(patsubst %libbpf.a,%libbpf.so,$(BPFOBJ))
> > +TRUNNER_TESTS_BLACKLIST := cpu_mask.c hashmap.c perf_buffer.c raw_tp_test_run.c
> > +$(eval $(call DEFINE_TEST_RUNNER,test_progs,shared))
> > +TRUNNER_TESTS_BLACKLIST :=
>
> It's a good idea to add libbpf.so test, but going through test_progs is imo overkill.
> No reason to run more than one test with shared lib.
> If it links fine it's pretty much certain that it will work.
> Maybe convert test_maps into shared only? CI runs it already.

If some APIs are not used from a user app, their symbols won't be used
during dynamic linking, so they won't be tested neither for linking
nor functionally. E.g., in this case all the btf_dump__new(),
btf__dedup(), etc, invocations won't be verified even at dynamic
linking time. At least that's my understanding from looking at
generated ELF binaries. And that was the sole motivator (at least
initially) to add -shared flavor, so that I can make sure it works.
Learned a bit about symbol versioning and symbol visibility from that,
so definitely not a waste of time.

But more broadly, what's the concern? User-space part compilation time
for test_progs is extremely fast, it's the BPF object compilation that
is slow. I'll send another Makefile change to eliminate the third
compilation variant for BPF source code in the next few days (will
roll it into this patch set unless it lands first), so that will go
away.

It seems useful to have a full-featured testing ground for libbpf.so,
especially that I don't use (and thus don't test and validate
constantly) it in practice in my own applications.
