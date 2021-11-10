Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B944C9E4
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 20:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhKJT5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 14:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhKJT5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 14:57:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6910C061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 11:55:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f8so15220988edy.4
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMbT9S4gWfsi71zwwXv8lVadOojP2gn4XUqm8PUgzgk=;
        b=Dexx0zsryUc6zio4uVgOrrokBHoK/M5jwsy5WZQoCmj2iiLWT4TsLYGqYGBIGYBNQh
         nziBL9csFDOV+lujNgN6KexfWqd7qCVKBh92HX3Vo3tDoHOrwR+zYcEVaWg22Wpzs0mQ
         ILeeoK6Bydnl40XtBzJ5eMQVhFcxRhRSCIxsEqd13RIolBPLfH2Yzh0bqKjZNTc/0GBp
         qXLh4JIudPcO30wPBW65MGdMDgdUTRi5SKohcbq/ZznN4jPbJxfe/PHLAYtRRV4RiHn5
         uskDJvs5jj1SXGefxvEHeQDuv6jsahrvAMFHEByJkrLVQvPWTcEhEuXrds8u74aKLU+Q
         5/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMbT9S4gWfsi71zwwXv8lVadOojP2gn4XUqm8PUgzgk=;
        b=CW3Pqmk/ih2SOL32IW24CY+PEA1xPDSw/3WruYi4dhL+cUKRg3QijnBrXYlDV2M4E0
         Gjdw2CP8uPL7mtVmKWFF5nAjxBJ15733Z4/nFS3EvE8ziUwS2TH6rsFTgQy7rLfL2XKN
         ZiChh8E9A1zxiX6krleq3y9rV/3Zc+7aG9ox1nOd+rbkKfnOSHZCUYlj0jDwA275Msun
         ONl3WHtdym1s7VqcHU501dgXADosYkU7qtP+rasYDhFhGuSquhw1RvlGCQr8ASbxPcha
         GDUueS4FOsFL5+bEHuWgYphpAvYYZOZ5ggapL3TTbTvzYFpGlmFr/jmRqJWwaHsjDYpg
         44aQ==
X-Gm-Message-State: AOAM530ZCuPsJW4EIYgxi9vdEKPKtM1Mk9n+hwE3ERaqLD0tYIpZM7Jw
        4/E48WvWSlxY7RA0vpDJHsaF5YIMsPRsNwur0Ng4ZA==
X-Google-Smtp-Source: ABdhPJzcz/WyI+pPOW7ZRL5g8/pNdTJw0tEog01ypWe3UHJVeulo0B+mfwbfMtiZf+mH07yARfNnYkMpO/g1X/3yPs8=
X-Received: by 2002:a05:6402:95b:: with SMTP id h27mr2108073edz.116.1636574104072;
 Wed, 10 Nov 2021 11:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20211109003052.3499225-1-haoluo@google.com> <CAEf4BzZn0Oa_AXYFbsCXX3SXqeZCRNVGPQRrkVH5VGPiOBe04A@mail.gmail.com>
In-Reply-To: <CAEf4BzZn0Oa_AXYFbsCXX3SXqeZCRNVGPQRrkVH5VGPiOBe04A@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 10 Nov 2021 11:54:52 -0800
Message-ID: <CA+khW7g3SP5+0TYr-jtZ6Ookq9wwBWtR-bJhzPhDopxwkCbB2w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/3] bpf: Prevent writing read-only memory
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 8:43 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 8, 2021 at 4:31 PM Hao Luo <haoluo@google.com> wrote:
> >
> > There are currently two ways to modify a kernel memory in bpf programs:
> >  1. declare a ksym of scalar type and directly modify its memory.
> >  2. Pass a RDONLY_BUF into a helper function which will override
> >  its arguments. For example, bpf_d_path, bpf_snprintf.
> >
> > This patchset fixes these two problem. For the first, we introduce a
> > new reg type PTR_TO_RDONLY_MEM for the scalar typed ksym, which forbids
> > writing. For the second, we introduce a new arg type ARG_CONST_PTR_TO_MEM
> > to differentiate the arg types that only read the memory from those
> > that may write the memory. The previous ARG_PTR_TO_MEM is now only
> > compatible with writable memories. If a helper doesn't write into its
> > argument, it can use ARG_CONST_PTR_TO_MEM, which is also compatible
> > with read-only memories.
> >
> > In v2, Andrii suggested using the name "ARG_PTR_TO_RDONLY_MEM", but I
> > find it is sort of misleading. Because the new arg_type is compatible
> > with both write and read-only memory. So I chose ARG_CONST_PTR_TO_MEM
> > instead.
>
> I find ARG_CONST_PTR_TO_MEM misleading. It's the difference between
> `char * const` (const pointer to mutable memory) vs `const char *`
> (pointer to an immutable memory). We need the latter semantics, and
> that *is* PTR_TO_RDONLY_MEM in BPF verifier terms.
>

Ah, I am aware of the semantic difference between 'char * const' and
'const char *', but your explanation in the bracket helps me see your
point better. It does seem PTR_TO_RDONLY_MEM matches the semantics
now. Let me fix and send an update.

> Drawing further analogies from C, you can pass `char *` (pointer to
> mutable memory) to any function that expects `const char *`, because
> it's safe to do so, but not the other way.
>
> So I don't think it's confusing at all that it is PTR_TO_RDONLY_MEM
> and that you can pass PTR_TO_MEM register to a helper that expects
> ARG_PTR_TO_RDONLY_MEM.
>
> >
> > Hao Luo (3):
> >   bpf: Prevent write to ksym memory
> >   bpf: Introduce ARG_CONST_PTR_TO_MEM
> >   bpf/selftests: Test PTR_TO_RDONLY_MEM
> >
> >  include/linux/bpf.h                           | 20 +++++-
> >  include/uapi/linux/bpf.h                      |  4 +-
> >  kernel/bpf/btf.c                              |  2 +-
> >  kernel/bpf/cgroup.c                           |  2 +-
> >  kernel/bpf/helpers.c                          | 12 ++--
> >  kernel/bpf/ringbuf.c                          |  2 +-
> >  kernel/bpf/syscall.c                          |  2 +-
> >  kernel/bpf/verifier.c                         | 60 +++++++++++++----
> >  kernel/trace/bpf_trace.c                      | 26 ++++----
> >  net/core/filter.c                             | 64 +++++++++----------
> >  tools/include/uapi/linux/bpf.h                |  4 +-
> >  .../selftests/bpf/prog_tests/ksyms_btf.c      | 14 ++++
> >  .../bpf/progs/test_ksyms_btf_write_check.c    | 29 +++++++++
> >  13 files changed, 168 insertions(+), 73 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
> >
> > --
> > 2.34.0.rc0.344.g81b53c2807-goog
> >
