Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB94433DCD
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhJSRxK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 13:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhJSRxJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 13:53:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5EEC06161C
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 10:50:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t127so12031021ybf.13
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlhdPi8AOZZTCp9eCtfFwCOazpvWLYwiFZSK+mM3Q6E=;
        b=UaRqJCFpuGsrn+RA/tOJaN0sQBOJqBAMOrWvshdaPt7NM7ZIJbIICGd8ImtqolRhim
         rL8y5/4P4mH05SLUmCUCOBT3fH1+x0weyjNsANJiGpDlhR13H0wurWO+/JaX4HsqzVcx
         cwC1LSfTfQV7Ymg23S6j+rU1kIu5PzSds8qB06WEaTg9SB96cd0vBbhT86pZWcY0WQhN
         CULAL6dBU9WTc8VYNx/BuYmjsAjOvR3RYR80ecu3JpnoTRH1H02vUmfveDX0Ce7EdvTF
         cz4z/kNjB7b1CafQhspm4GzxM/b2k+taM7F8Gwefjd0UZcdCP2Gnh25YHvNIK1dOIakw
         DEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlhdPi8AOZZTCp9eCtfFwCOazpvWLYwiFZSK+mM3Q6E=;
        b=mSqE9fhy9dQcSx4GLu6Djbi0h/z1twgYvpD5TK4tSUCwrUtBMNiHthDDBEcJ3p6JQE
         c48JoZHMxMYtc5l/raXdXQUtnvrA0voRoEXQ1DLyR9OG0YkB5yRz3TcAKmkzFeX7PbrP
         anWEWGeSp9cUWTgqpykZck1GQpk+yn2i1ETGF4omq2tZkQTSmREDMXQmL82zAaPvwHt5
         5Oy+qkwhTgb0tmrzsKbKQOpMbRyeZYkFRZ7vMPHF+FCiS/lpPkbx901N7ywW36/dvTfL
         i84ctzSMoTiEVD9WnHVer/K1Bzn+glppKUN5W6M1XeDsNRkL5LVzB+f9dYO50cX03pIe
         MFhA==
X-Gm-Message-State: AOAM533JAu/u5qnXkpoRi4SaffwIQnKfs+Ud1A5Yls6IGwfuPr1kZ3GZ
        p2QF3DG7SciLFRQNK8HR/m2AfUqS1Ervs89jkOEhLlFavn8=
X-Google-Smtp-Source: ABdhPJyJJYoZDQL0+QctQJar6fFZ/hJF15d4TjmI8qqzGkOZg++VEGcmYVy4a5KK1RYXIiKqhA5C7391kh5TKppSbYQ=
X-Received: by 2002:a25:5606:: with SMTP id k6mr38292302ybb.51.1634665855277;
 Tue, 19 Oct 2021 10:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211009150029.1746383-1-hengqi.chen@gmail.com> <20211009150029.1746383-3-hengqi.chen@gmail.com>
In-Reply-To: <20211009150029.1746383-3-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 Oct 2021 10:50:43 -0700
Message-ID: <CAEf4Bza6iFBn6FJ4ps+ONwDQ-Otqt=QtBm7Tw00qg+zVYM0wdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] tools: Switch to new btf__type_cnt/btf__raw_data
 APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 9, 2021 at 8:01 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Replace the calls to btf__get_nr_types/btf__get_raw_data in tools
> with new APIs btf__type_cnt/btf__raw_data. The old APIs will be
> deprecated in recent release of libbpf.

"in libbpf v0.7+"

>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/bpf/bpftool/btf.c                              | 12 ++++++------
>  tools/bpf/bpftool/gen.c                              |  4 ++--
>  tools/bpf/resolve_btfids/main.c                      |  4 ++--
>  tools/perf/util/bpf-event.c                          |  2 +-
>  tools/testing/selftests/bpf/btf_helpers.c            |  4 ++--
>  tools/testing/selftests/bpf/prog_tests/btf.c         | 10 +++++-----
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c    |  8 ++++----
>  tools/testing/selftests/bpf/prog_tests/btf_endian.c  | 12 ++++++------
>  tools/testing/selftests/bpf/prog_tests/btf_split.c   |  2 +-
>  .../testing/selftests/bpf/prog_tests/core_autosize.c |  2 +-
>  tools/testing/selftests/bpf/prog_tests/core_reloc.c  |  2 +-
>  .../selftests/bpf/prog_tests/resolve_btfids.c        |  4 ++--
>  12 files changed, 33 insertions(+), 33 deletions(-)
>

Please split each tool into a separate patch, and selftests separate
from tools as well. Otherwise, great job, thanks!

[...]
