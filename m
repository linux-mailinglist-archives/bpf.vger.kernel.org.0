Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8B2DC930
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 23:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgLPWpN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 17:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgLPWpM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 17:45:12 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC80CC061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 14:44:32 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id y4so3478303ybn.3
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 14:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bEGYC7haX5hVkJO6gZp3/9UlAVMZ51tvMTvkLjCZXk=;
        b=IUvzuvzo8WuB8bR8OmTUeg/lD/sm0k6XzCL9O+TK7xcm3eLNwcC+jkaBtGn0kfdIaS
         A10VWZWmTQTlqcgptFnyoBsRRkru4jCHODanZC4pxd19/tpS9opd4S64IRIUudXj5v0q
         y6B/9W7bnqn61MxFUwfAHc43vmoV61aa2wVjluTyoH74R7SK8mgK2ZdCakYkBZ/asb15
         2Vjn3QmSh0xIk5gScnUJfS7wBLu4iZhDRQUfH/eYRqELoLZlbecTh7P/Pb4WMBCt1mJp
         hLChTrJ5MhKmZg4gAjwwbj951d6gcXeX2GAcsLmJSrjkKyH7Lw0P3Vk+Ml3WQHTcv5nf
         XaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bEGYC7haX5hVkJO6gZp3/9UlAVMZ51tvMTvkLjCZXk=;
        b=e81JohMTFXpDiHpsiLOq5x26biBTxpijyT1FGjamy3kaSRQyOzcdIf/2BPm0DIuLhn
         3RVNydRxQj79DVnSKIGOqPRQzFsAdY69vunIxhjTHOCDPpEQ3Q+VD/ixovKClBub+Y4m
         p4YJHJYbEksdTgSycQxzdxw7o6CxQfie74wUNQNHZc+fI8ttzQ9P56ZDWzf2I+fgHYB8
         aej50jvudcPl9HqVRIsPBhcGlZRn2Pd/YlnAxlDu9xY7wU6BTD0s0nA8ekbioF6FpkE5
         G698mepDHEyuRgZ86uP3zsR4CgYMV5RbKjhJ9zwwX4MAEoplXnv9tH1Q35TnMHeIB7cD
         /KxA==
X-Gm-Message-State: AOAM532GeFQ2S/3iuX4+HPg2ERvwN+H45d6DRYJW04sYE7CdJJ7ZJyaN
        +IRZRsbIcsVvrtZssT/7SWwk6MstgzY2WMB7N8E=
X-Google-Smtp-Source: ABdhPJy+G4R+uFjGsuJyzlZdraESzb3xs7xC1NUO6xpwDZn6rGL4sJJrM+1ZyPQ/P+SjsLP5ySEaCAm2GHCTTqrJjlA=
X-Received: by 2002:a25:f505:: with SMTP id a5mr51256471ybe.425.1608158671924;
 Wed, 16 Dec 2020 14:44:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607973529.git.me@ubique.spb.ru>
In-Reply-To: <cover.1607973529.git.me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Dec 2020 14:44:21 -0800
Message-ID: <CAEf4BzadLQ3jxcjhXNU06VkGW9nuFuU3q1-Z7TRU4wQ6s=PgAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Add support of pointer to struct in global functions
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 14, 2020 at 11:53 AM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> This patchset adds support of a pointer to struct among global function
> arguments.
>
> The motivation is to overcome the limit on the maximum number of allowed
> arguments and avoid tricky and unoptimal ways of passing arguments.
>
> The limitation is that used structs may not contain any other pointers.
>

This patch set seems to be breaking a few selftests, please take a look ([0]).

  [0] https://travis-ci.com/github/kernel-patches/bpf/builds/208973941

> Dmitrii Banshchikov (3):
>   bpf: Factor out nullable reg type conversion
>   bpf: Support pointer to struct in global func args
>   selftests/bpf: Add unit tests for global functions
>
>  include/linux/bpf_verifier.h                  |   2 +
>  kernel/bpf/btf.c                              |  59 ++++++++--
>  kernel/bpf/verifier.c                         | 107 ++++++++++++------
>  .../bpf/prog_tests/test_global_funcs.c        |   5 +
>  .../selftests/bpf/progs/test_global_func10.c  |  29 +++++
>  .../selftests/bpf/progs/test_global_func11.c  |  19 ++++
>  .../selftests/bpf/progs/test_global_func12.c  |  21 ++++
>  .../selftests/bpf/progs/test_global_func13.c  |  24 ++++
>  .../selftests/bpf/progs/test_global_func9.c   |  59 ++++++++++
>  9 files changed, 284 insertions(+), 41 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c
>
> --
> 2.25.1
>
