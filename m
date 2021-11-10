Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D722044BAE4
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 05:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhKJEqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 23:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhKJEqb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 23:46:31 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705D4C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 20:43:44 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d10so3267355ybe.3
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 20:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUJJN8z5uOzTTIxPRa18VuR9xLvLQROLbM3Nvkb3jAw=;
        b=N0iJHIFmTra03RbHGrZH5dcxy+MeCud8FMibeZEmcVv+fEZWw9ebU1DePwOQQ/MBuh
         4CYQVZU5RfvJoHf7GfAZKxndTTeQFZDEh2UwKJLN2mABhzBAb5io5RtBXc6ISz4qzvxv
         oC2oY1JQNESC1D8rJpuvd/ZxV1uaWY3khGXcFPNh7O0VXKfoewFLflQ18dfL5q1u3kWO
         2+Vzl2bPoyMvDwToR5paw6YIfkogGGG5CALB2eBnF2PqXUj1SyB92JmVG6q6bgTkVYLJ
         iifBV5hmy2xgH64idFGWj36StLSCzoLTqdsUo3rNK+jn37mwEoTlrbPDzrvWoLxOhcDd
         1eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUJJN8z5uOzTTIxPRa18VuR9xLvLQROLbM3Nvkb3jAw=;
        b=hUQ5xhOrJ3pkVg3zQ6J2FPMMEOhidtPpG3hI03DFYBvM5lP6fu5ILZ9kL6kC2sxkiB
         CJALUieL/aF3Gqv1klXMYNr9jNE+ghU2tT+Tz/nJW7SyXHMbeKk4onw9FCr/UX7sObmx
         84XSgKk+gaGB5gMNk/lL7faRRie54eHtWekqXad+O5N8eXqZlRR9vplkOCmN4xbByPvb
         7yTXVZMj3nn1QexVLgT7oklOcGylk8MuFkbZJ/AXqu59duD4hbVkYLqKFjla6rDxAFdN
         cBpn1dhYK79oWaWOHqq5iUA5fGdJl7/1RTfMHI3CpLCbitiidmafhVK/pit7otvj51fH
         8dmw==
X-Gm-Message-State: AOAM532/8TP1a86xHY16uylnLt2Rz47ZeL0fM1niNGlAILZ8tLfMR2x5
        viiXJ1pe1gjVSEi+XIEh7rsKHmiKa/dW1hHfC3Y=
X-Google-Smtp-Source: ABdhPJzGEX8KuiaG9ppQI89fRHo6phgjBLgNqXe4JtMOTZgI/DxgHYM/FraZLG1+CAIr7QWgkWcEzU11gJYNXg+ocMQ=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr14810988ybe.455.1636519423647;
 Tue, 09 Nov 2021 20:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20211109003052.3499225-1-haoluo@google.com>
In-Reply-To: <20211109003052.3499225-1-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 20:43:32 -0800
Message-ID: <CAEf4BzZn0Oa_AXYFbsCXX3SXqeZCRNVGPQRrkVH5VGPiOBe04A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/3] bpf: Prevent writing read-only memory
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 8, 2021 at 4:31 PM Hao Luo <haoluo@google.com> wrote:
>
> There are currently two ways to modify a kernel memory in bpf programs:
>  1. declare a ksym of scalar type and directly modify its memory.
>  2. Pass a RDONLY_BUF into a helper function which will override
>  its arguments. For example, bpf_d_path, bpf_snprintf.
>
> This patchset fixes these two problem. For the first, we introduce a
> new reg type PTR_TO_RDONLY_MEM for the scalar typed ksym, which forbids
> writing. For the second, we introduce a new arg type ARG_CONST_PTR_TO_MEM
> to differentiate the arg types that only read the memory from those
> that may write the memory. The previous ARG_PTR_TO_MEM is now only
> compatible with writable memories. If a helper doesn't write into its
> argument, it can use ARG_CONST_PTR_TO_MEM, which is also compatible
> with read-only memories.
>
> In v2, Andrii suggested using the name "ARG_PTR_TO_RDONLY_MEM", but I
> find it is sort of misleading. Because the new arg_type is compatible
> with both write and read-only memory. So I chose ARG_CONST_PTR_TO_MEM
> instead.

I find ARG_CONST_PTR_TO_MEM misleading. It's the difference between
`char * const` (const pointer to mutable memory) vs `const char *`
(pointer to an immutable memory). We need the latter semantics, and
that *is* PTR_TO_RDONLY_MEM in BPF verifier terms.

Drawing further analogies from C, you can pass `char *` (pointer to
mutable memory) to any function that expects `const char *`, because
it's safe to do so, but not the other way.

So I don't think it's confusing at all that it is PTR_TO_RDONLY_MEM
and that you can pass PTR_TO_MEM register to a helper that expects
ARG_PTR_TO_RDONLY_MEM.

>
> Hao Luo (3):
>   bpf: Prevent write to ksym memory
>   bpf: Introduce ARG_CONST_PTR_TO_MEM
>   bpf/selftests: Test PTR_TO_RDONLY_MEM
>
>  include/linux/bpf.h                           | 20 +++++-
>  include/uapi/linux/bpf.h                      |  4 +-
>  kernel/bpf/btf.c                              |  2 +-
>  kernel/bpf/cgroup.c                           |  2 +-
>  kernel/bpf/helpers.c                          | 12 ++--
>  kernel/bpf/ringbuf.c                          |  2 +-
>  kernel/bpf/syscall.c                          |  2 +-
>  kernel/bpf/verifier.c                         | 60 +++++++++++++----
>  kernel/trace/bpf_trace.c                      | 26 ++++----
>  net/core/filter.c                             | 64 +++++++++----------
>  tools/include/uapi/linux/bpf.h                |  4 +-
>  .../selftests/bpf/prog_tests/ksyms_btf.c      | 14 ++++
>  .../bpf/progs/test_ksyms_btf_write_check.c    | 29 +++++++++
>  13 files changed, 168 insertions(+), 73 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c
>
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
