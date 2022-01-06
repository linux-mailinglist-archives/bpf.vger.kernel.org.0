Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288C3485CC8
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 01:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiAFADX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 19:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245719AbiAFADS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 19:03:18 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B2FC061212
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 16:03:17 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id i14so1073019ioj.12
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 16:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KehxUzgtOA1sZte1YcGDmtlVUYwPB7E24i+HsQ9s94=;
        b=mgAT3re0nz1mBosJyfh7Iqs+Dh3UKguVe4At9iVaJNny4Lpkrq77J3NRcuuZfuXHcL
         5V+xN32EfjP1nWGKW0w8adBjCmwkUFQxbA1Q72sbFsYZOOwgybVfcjcx6xWxmL2F7UOl
         NB+8GdmfdJFtOAHTOY2W/85GdLXxy7yl2dN531+jgFnBf2RLDGkpcvMvxArVD9DgmtIX
         P8O+saU5LhMGhT8lsjB2Q4hzXvUEt0RtuRf6n/cvLA3bsuBRUT55LA0im2tCVjJCUB0S
         QvBqtbxBns6wuhtdkSjy809RbP85jFWaHnPjwxTm5FSMJzuIS4FwLWqhwZZh77SwA3Bi
         pzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KehxUzgtOA1sZte1YcGDmtlVUYwPB7E24i+HsQ9s94=;
        b=I4IsitRRQtVKbUUuA8e3LJx+K8qhnMX6OQNvrhr13VBlLKDyX3UsMqcIqHNtdC/uy9
         wC3R2JD4r5ixV/htSJkjEm7HyTx2qCYLN6U0T21SY9vkM6F/BjKo9XjCcqAEidxhRLlZ
         0Vja8D/qxcU3lvFbfM8xr0Via/KPYF/55hNrGgsefuqEh10Vi4sus2n6gYw/YEHjCBtN
         NVJB5TkhJDARS3a5pgZjONoWmd69+30pg5WRfjJNEFYJpP71TajXlMkc/2tG9wrm6Cyk
         K1NuthFJmyVOjEVlpYvTGeJyN61sAsZ/6G01Hw6s2xdyFsmoPiRJ0F0d5acHjfXwc8qM
         lzfg==
X-Gm-Message-State: AOAM533+AsFWXVwjPm5wceg3uIBKQynoBZTBvCH4MQFuT7BRSvLL5xnR
        RKaJgHPjQcw/MLBh1G9kYXFsVhnzOKOU4bSijhZFqTFC
X-Google-Smtp-Source: ABdhPJy6dk+M3S3criyyXS4q7LPAUeZDmMFtj4YTin2Nk7lxfuQx8i12C/CQ1VI4OEI/A1y8wTtc+SLVvdSRKd9+8LE=
X-Received: by 2002:a05:6602:1495:: with SMTP id a21mr26966469iow.79.1641427397221;
 Wed, 05 Jan 2022 16:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20211230204008.3136565-1-christylee@fb.com>
In-Reply-To: <20211230204008.3136565-1-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 16:03:06 -0800
Message-ID: <CAEf4BzasX0sk6AZg6vwGw3g2JADazn2_g8xHUJu2MtSR5qk9xQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] libbpf 1.0: deprecate non-OPTS variants of
 bpf_object__open API
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 30, 2021 at 12:40 PM Christy Lee <christylee@fb.com> wrote:
>
> Deprecate bpf_object__open(), bpf_object__open_buffer(), and
> bpf_object__open_xattr() in favor of bpf_object__open_file() and
> bpf_object__open_mem().
>
> [0] Closes: https://github.com/libbpf/libbpf/issues/287
>

Looks good overall, see a nit about libbpf_ptr(). But please also
split out selftests, perf, bpftool changes into separate commits.
Thanks!

> Christy Lee (3):
>   libbpf: deprecate bpf_object__open() API
>   libbpf: deprecate bpf_object__open_buffer() API
>   libbpf: deprecate bpf_object__open_xattr() API
>
>  Documentation/bpf/prog_lsm.rst                            | 2 +-
>  tools/bpf/bpftool/Documentation/bpftool-gen.rst           | 2 +-
>  tools/bpf/bpftool/iter.c                                  | 2 +-
>  tools/build/feature/test-libbpf.c                         | 2 +-
>  tools/lib/bpf/libbpf.c                                    | 2 +-
>  tools/lib/bpf/libbpf.h                                    | 7 +++++--
>  tools/perf/tests/llvm.c                                   | 2 +-
>  tools/perf/util/bpf-loader.c                              | 7 +++++--
>  tools/testing/selftests/bpf/prog_tests/btf.c              | 2 +-
>  tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
>  tools/testing/selftests/bpf/test_maps.c                   | 4 ++--
>  tools/testing/selftests/bpf/test_sockmap.c                | 2 +-
>  12 files changed, 21 insertions(+), 15 deletions(-)
>
> --
> 2.30.2
