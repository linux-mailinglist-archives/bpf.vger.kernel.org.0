Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6639146DFB2
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 01:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbhLIAwG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 19:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLIAwF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 19:52:05 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E4C061746
        for <bpf@vger.kernel.org>; Wed,  8 Dec 2021 16:48:33 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y68so10112398ybe.1
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 16:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpE3CdZis6liFSsdwuIzIayZH6NXBEPId32QUCqLyrk=;
        b=aS/vLKQY1LtQaCcQrPW4f1TL9eFWvx3f8uugfGHY8iCxLSAiStvguW3CUV/UYerkjp
         7yf885WfNmsQxTq5n0CR/EF6G9ZULoLzfGqWOy6z4+n8Os3lU+a+t9BzYuitpf+3oElV
         ZkgTIjQsg1WnfdZOS6ZyHzZG7PzGUkSMl6VluOAjfIk06NvHR/8FOn52EJhNcB5fFbrV
         W4iLI7DPTFENMwjUjaXlg9RZJBsQi/NVlD08Nehec9sPUZiwwaeL+y9cUzhEGwT0LEMY
         OHS4gxIOddJWUjBLvHHzytKwo9xyjl+Gj9l8+6InN7xVIU0oHW/P2sv+npH7lmzEQFu3
         gxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpE3CdZis6liFSsdwuIzIayZH6NXBEPId32QUCqLyrk=;
        b=Xq85s4aD5ahiGihl1znvmnH8BNg7XOo9E3p4l4TpB/4GdzMxzuTf18TsJ0tkSgTtzA
         zy2h9xSuOCX5sjvcHVtg1JGxn6br0MtoZJqcO81bScYtynmdkAitiJoLZOBxCFk5Cp7h
         x/AtteYATFXQl7njXeGOTSnEZ/Yc0ZOw/97qBt+zIUl84GDRB2h56IzV7Psxp46jIsvJ
         Ah6qxbaBZ43qwua49SdfR/2UnrnkmdUKBuzuTTNpRyz+B4Op83GVm9pPye9Yvyr1hCbJ
         Ba5+5EcXx3eX3gEilqI2lpifu5GdorOuYNDLFbZTx5hhkBOQiiB3fmbwi50ljiMhIEs8
         vcnQ==
X-Gm-Message-State: AOAM532BRAQLqYVrGm5/vP0WY3CDtWJZ2dx3o1mdZ1+0uJWz0/rqa1Sc
        yWzuAnybKL6/P2aJaFE4Jv6FhllZcjvCclXUdCeu2P0ZeQ0=
X-Google-Smtp-Source: ABdhPJyRYHitJTTPysbqfD/OertCyIb+rvI7er6aWts8ho/EE0ieJNSS+h+P5ZCaKYB1in+NoBcOkGGMno110JlVZS0=
X-Received: by 2002:a25:e90a:: with SMTP id n10mr2533338ybd.180.1639010912572;
 Wed, 08 Dec 2021 16:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20211209003033.3962657-1-andrii@kernel.org>
In-Reply-To: <20211209003033.3962657-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Dec 2021 16:48:20 -0800
Message-ID: <CAEf4BzbqehpToeYRRQpZjFA71Puqde3CQFcpK424PGziaQO=HQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/12] Enhance and rework logging controls in libbpf
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 8, 2021 at 4:30 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add new open options and per-program setters to control BTF and program
> loading log verboseness and allow providing custom log buffers to capture logs
> of interest. Note how custom log_buf and log_level are orthogonal, which
> matches previous (alas less customizable) behavior of libbpf, even though it
> sort of worked by accident: if someone specified log_level = 1 in
> bpf_object__load_xattr(), first attempt to load any BPF program resulted in
> wasted bpf() syscall with -EINVAL due to !!log_buf != !!log_level. Then on
> retry libbpf would allocated log_buffer and try again, after which prog
> loading would succeed and libbpf would print verbose program loading log
> through its print callback.
>
> This behavior is now documented and made more efficient, not wasting
> unnecessary syscall. But additionally, log_level can be controlled globally on
> a per-bpf_object level through bpf_object_open_opts, as well as on
> a per-program basis with bpf_program__set_log_buf() and
> bpf_program__set_log_level() APIs.
>
> Now that we have a more future-proof way to set log_level, deprecate
> bpf_object__load_xattr().
>
> v1->v2:
>   - fix log_level == 0 handling of bpf_prog_load, add as patch #1 (Alexei);
>   - add comments explaining log_buf_size overflow prevention (Alexei).
>

Oh, the patch set was supposed to be marked with v2. I'll resend with
proper v2 tag, sorry for spam.

> Andrii Nakryiko (12):
>   libbpf: fix bpf_prog_load() log_buf logic for log_level 0
>   libbpf: add OPTS-based bpf_btf_load() API
>   libbpf: allow passing preallocated log_buf when loading BTF into
>     kernel
>   libbpf: allow passing user log setting through bpf_object_open_opts
>   libbpf: improve logging around BPF program loading
>   libbpf: preserve kernel error code and remove kprobe prog type
>     guessing
>   libbpf: add per-program log buffer setter and getter
>   libbpf: deprecate bpf_object__load_xattr()
>   selftests/bpf: replace all uses of bpf_load_btf() with bpf_btf_load()
>   selftests/bpf: add test for libbpf's custom log_buf behavior
>   selftests/bpf: remove the only use of deprecated
>     bpf_object__load_xattr()
>   bpftool: switch bpf_object__load_xattr() to bpf_object__load()
>
>  tools/bpf/bpftool/gen.c                       |  11 +-
>  tools/bpf/bpftool/prog.c                      |  24 +--
>  tools/bpf/bpftool/struct_ops.c                |  15 +-
>  tools/lib/bpf/bpf.c                           |  88 ++++++--
>  tools/lib/bpf/bpf.h                           |  22 +-
>  tools/lib/bpf/btf.c                           |  78 ++++---
>  tools/lib/bpf/libbpf.c                        | 194 ++++++++++++------
>  tools/lib/bpf/libbpf.h                        |  49 ++++-
>  tools/lib/bpf/libbpf.map                      |   3 +
>  tools/lib/bpf/libbpf_internal.h               |   1 +
>  tools/lib/bpf/libbpf_probes.c                 |   2 +-
>  .../selftests/bpf/map_tests/sk_storage_map.c  |   2 +-
>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |   6 +-
>  tools/testing/selftests/bpf/prog_tests/btf.c  |  50 +++--
>  .../selftests/bpf/prog_tests/log_buf.c        | 137 +++++++++++++
>  .../selftests/bpf/progs/test_log_buf.c        |  24 +++
>  tools/testing/selftests/bpf/test_verifier.c   |   2 +-
>  tools/testing/selftests/bpf/testing_helpers.c |  10 +-
>  18 files changed, 544 insertions(+), 174 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/log_buf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_log_buf.c
>
> --
> 2.30.2
>
