Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E43DBFB9
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 22:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhG3UXV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 16:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhG3UXU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 16:23:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F026C061765
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 13:23:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so22420004pjb.3
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6GZwee3zFFPBRG9bG2No8hxtp9CFwbkFuUJbccfQD8=;
        b=JOXZU0qKiHccvRmfAizmxvmud0U+2vK3GFGatspi4UhZRWN3JsNmy3MdrbFHbeAeJM
         lrYOTe1Ho70mPMzYNS5JwA55FuwyRj13ksmPSMFGqIoJAG7CiU2s29g04sacltNidi8T
         diHZAcffS23I++UNReWAA5HcM+Lw2yxQpJq1IYAcNSqzRadS936SgWQMcpaRzFoWb1Gd
         Wy4I1H9xPQ5ofw2grKWdDE8R/sEVbt8Knnp5w29aydvkox2IWf5HPg+cM+xi1k6Y7XDI
         f3/0udHVUmYlW2fHQqtQPgVoe7hqfWiDRLKBIo4Hl7KAYytUsRs+4MqhKifbRAvhCR1w
         g1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6GZwee3zFFPBRG9bG2No8hxtp9CFwbkFuUJbccfQD8=;
        b=mk+6uZO7CqiInbipIU4WLBHDtvNQQf91hvBKVkNJbviyZbG89n4HZ4BIjRIeUeTzJ9
         F/S/NH1M6R9gxH2URCKLUw+2zMu2R1+mXyW0plYrMhQTVLUbp57sdkZN77vqqg2Uq1hL
         r9rejUTsjbs8c3Uuzfc2VATDhgB4pPP925qo0bZZ7Jg3BqxPhV6C8ROSo54gRb76K4Jy
         T7KXDhbZQidKeefApcr3f45qFR3kQ+EZ/mlAn40XQrrXZccHHcBPqZyYpc97KqEdGmxc
         Gs/I8x/Cc7sEOAvYOe4vBXtqT36QtfC2j4KbVagCGQsRUzdK2cClzZC8h2Ht44gmVzxw
         MZGw==
X-Gm-Message-State: AOAM5329FXm0jKEeeX3NN4/C+mfbURKdzDgZGXBnim/LjYDznCkvcQ5r
        6nqZ1fbhMKxIi4KwpYv7sJuFAiNWmHeTGxbsXsfddw==
X-Google-Smtp-Source: ABdhPJzqTNIRbw91KykDwe5YpS6CSO6GukDdkNVThVJ90gsI7hID/Uof2oiHLdFn5gxpJ1RoZDgN/n4fI8N7+AryPbw=
X-Received: by 2002:a17:902:e551:b029:12b:7e4c:b34 with SMTP id
 n17-20020a170902e551b029012b7e4c0b34mr3977994plf.43.1627676594074; Fri, 30
 Jul 2021 13:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210729162028.29512-1-quentin@isovalent.com> <CAEf4BzbrQOr8Z2oiywT-zPBEz9jbP9_6oJXOW28LdOaqAy8pLw@mail.gmail.com>
 <22d59def-51e7-2b98-61b6-b700e7de8ef6@isovalent.com> <CAEf4BzbjN+zjio3HPRkGLRgZpbLj9MUGLnXt1KDSsoOHB8_v3Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbjN+zjio3HPRkGLRgZpbLj9MUGLnXt1KDSsoOHB8_v3Q@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Fri, 30 Jul 2021 21:23:02 +0100
Message-ID: <CACdoK4KCbseLYzY2aqVM5KC0oXOwzE-5b3-g07uoeyJN4+r70g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/8] libbpf: rename btf__get_from_id() and
 btf__load() APIs, support split BTF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 30 Jul 2021 at 18:24, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

[...]

> > > The right approach will be to define
> > > LIBBPF_MAJOR_VERSION/LIBBPF_MINOR_VERSION in some sort of
> > > auto-generated header, included from libbpf_common.h and installed as
> > > part of libbpf package.
> >
> > So generating this header is easy. Installing it with the other headers
> > is simple too. It becomes a bit trickier when we build outside of the
> > directory (it seems I need to pass -I$(OUTPUT) to build libbpf).
>
> Not sure why using the header is tricky. We auto-generate
> bpf_helper_defs.h, which is included from bpf_helpers.h, which is
> included in every single libbpf-using application. Works good with no
> extra magic.

bpf_helper_defs.h is the first thing I looked at, and I processed
libbpf_version.h just like it. But there is a difference:
bpf_helper_defs.h is _not_ included in libbpf itself, nor is it needed
in bpftool at the bootstrap stage (it is only included from the eBPF
skeletons for profiling or showing PIDs etc., which are compiled after
libbpf). The version header is needed in both cases.

>
> >
> > The step I'm most struggling with at the moment is bpftool, which
> > bootstraps a first version of itself before building libbpf, by looking
> > at the headers directly in libbpf's directory. It means that the
> > generated header with the version number has not yet been generated. Do
> > you think it is worth changing bpftool's build steps to implement this
> > deprecation helper?
>
> If it doesn't do that already, bpftool should do `make install` for
> libbpf, not just build. Install will put all the headers, generated or
> otherwise, into a designated destination folder, which should be
> passed as -I parameter. But that should be already happening due to
> bpf_helper_defs.h.

bpftool does not run "make install". It compiles libbpf passing
"OUTPUT=$(LIBBPF_OUTPUT)", sets LIBBPF_PATH to the same directory, and
then adds "-I$(LIBBPF_PATH)" for accessing bpf_helper_defs.h and compile
its eBPF programs. It is possible to include libbpf_version.h the same
way, but only after libbpf has been compiled, after the bootstrap.

I'll look into updating the Makefile to compile and install libbpf
before the bootstrap, when I have some time.
