Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D67459A76
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 04:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhKWDbV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 22:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhKWDbU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 22:31:20 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D09C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 19:28:13 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id f9so22010786ybq.10
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 19:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENWwLm5ABhiVCv+SegrjRbCSJXOnnBqIb/zGTDwAinQ=;
        b=DRaP7ZYVexRWCkmMlZuCDDMtyOSJipGDiFDRMZ9T6+O4ti7N9nrUTSdA7ZhUVlQVEz
         kJ96icwjtKCvQaoeXzIRfktwfR1h2tGl/+3FBs7hYBgPjH2x6Mc6W/0PYm8JvnrvBYjv
         2PeC69f04lT11tqqaRUSnzFknxmMRqlyjTNPLmhMvvb/+YFKSv3Y0gqmsUc9PNR13q38
         aImZPGnYVOsvvqxbYhSbNBPzTq5jYdkxdWwvR9Naj4wJa7RDFCVN1R3IWk41NIYtQGVj
         4aiNBLInjA/OiliSMiL236kqrzxUSuF9V3E/wezzo5qq4b/bSXDHYk8gFOuNiZB6GXcB
         QPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENWwLm5ABhiVCv+SegrjRbCSJXOnnBqIb/zGTDwAinQ=;
        b=qaIkU6h1Jy/GEos69R4lF4Ov9VDjKqcBdiE5E0LxilTO5J/sPb1IVTtgpabMnFsRe+
         rvZ1TK7WPsEQONAbBxWdQxni8ZVLMbaJOOuqnNXCr7VzY2Sqeu8rOvxhWroOoXlc1fMr
         tWMMz3ZiKCNfUyjVF8cwyBe6FvfUU/p2rBy5DbacELmds98OLvl3c/KajYA5aAXmRyW4
         N7/Ww5c79q621YKZbCiZ7L7L5Rv7so1Fgt+nAqpghcMa4D0EB22oGaqtSQ81UhzvGmqU
         n0jUdVD9uoqTr73JrMY1Zh1IjMwwXLacRHX7qpbOvdJaqEbsQ5yHOFbGx4BmJkHV2Wbg
         sEEw==
X-Gm-Message-State: AOAM531N1bKYcRsqTPs6KSdfMs826R9XNvTubt5zsIGsPkZSjLFBj3no
        qJKwsZx41Ya9jhjZtKgH5+Pk9+nSvURjm0V7KnE=
X-Google-Smtp-Source: ABdhPJxGATgwZl3/OqUpxKYw5QpnmA2qikt1sFB9d+Tb82hLmnndPubXiIsZoUZ0NhuWCQmbg86q0RF9rFZDzD9Zyo8=
X-Received: by 2002:a25:ccd4:: with SMTP id l203mr2686936ybf.225.1637638092949;
 Mon, 22 Nov 2021 19:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20211121135440.3205482-1-hengqi.chen@gmail.com> <20211121135440.3205482-3-hengqi.chen@gmail.com>
In-Reply-To: <20211121135440.3205482-3-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 19:28:02 -0800
Message-ID: <CAEf4BzZ1_pgRfk-uwqa8sr8BDaYPPr0yreENdCbU=szzSL4HFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test BPF_MAP_TYPE_PROG_ARRAY
 static initialization
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 21, 2021 at 5:55 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add testcase for BPF_MAP_TYPE_PROG_ARRAY static initialization.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---

It's a bit too minimal, let's actually trigger the program and make
sure that tail call program gets executed. Please also make sure that
you filter by pid like other tracing progs do (I suggest using
usleep(1) and raw_tracepoint program for sys_enter, as the simplest
set up).

>  .../bpf/prog_tests/prog_array_init.c          | 27 +++++++++++++++++
>  .../bpf/progs/test_prog_array_init.c          | 30 +++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_array_init.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_prog_array_init.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_array_init.c b/tools/testing/selftests/bpf/prog_tests/prog_array_init.c
> new file mode 100644
> index 000000000000..2fbf6946a0b6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_array_init.c
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include <test_progs.h>
> +#include <sys/un.h>
> +#include "test_prog_array_init.skel.h"
> +
> +void test_prog_array_init(void)
> +{
> +       struct test_prog_array_init *skel;
> +       int err;
> +
> +       skel = test_prog_array_init__open();
> +       if (!ASSERT_OK_PTR(skel, "could not open BPF object"))
> +               return;
> +
> +       err = test_prog_array_init__load(skel);
> +       if (!ASSERT_OK(err, "could not load BPF object"))
> +               goto cleanup;
> +
> +       err = test_prog_array_init__attach(skel);
> +       if (!ASSERT_OK(err, "could not attach BPF object"))
> +               goto cleanup;
> +
> +cleanup:
> +       test_prog_array_init__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_prog_array_init.c b/tools/testing/selftests/bpf/progs/test_prog_array_init.c
> new file mode 100644
> index 000000000000..e97204dd5443
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_prog_array_init.c
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +SEC("socket")
> +int tailcall_1(void *ctx)
> +{

let's add some global variable that will be set by the tail call
program, so that we know that correct slot and correct program was set

> +       return 0;
> +}
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +       __uint(max_entries, 2);
> +       __uint(key_size, sizeof(__u32));
> +       __array(values, int (void *));
> +} prog_array_init SEC(".maps") = {
> +       .values = {
> +               [1] = (void *)&tailcall_1,
> +       },
> +};
> +
> +SEC("socket")
> +int BPF_PROG(entry)
> +{

BPF_PROG doesn't really help, it just hides ctx which you are actually
using below, so let's just stick to `int entry(void *ctx)` here.

> +       bpf_tail_call(ctx, &prog_array_init, 1);
> +       return 0;
> +}
> --
> 2.30.2
