Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368DF1599C4
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 20:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgBKTaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 14:30:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42427 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgBKTaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 14:30:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id q15so11280157qke.9;
        Tue, 11 Feb 2020 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mtc3nhV1yFjtyZ72uQDRZQmFUp1an9UYV0/ZePw2JCY=;
        b=JRgMwCSc06Tbaq6tXLRRPsebZ4U51bfbGDh7uFD7ElvOgNWtSNEHQzFpbPYOXHSaxr
         MvOIVziC5npjqgPFgaL6hfAYsh0oy77XbPBODfewzN0QV0kS9WReWl0qpferJtWLw+v3
         4sGJXUMswY5s6j1YrY0vCIP+BpJ+NOViRQB/J5kkDd1ah1Xbi7lOl+Wwu14s9XlM8H2h
         VCHmLzd8yNWObKAOJGl4AeW2vCGGsCV07sgn2zDf/J6Nliov/42GiIU62gog/VFe3XoL
         9Ye2hz0euj56TKlNinXUh/ZeOdGobudVUgeItilRtOEn12JA6HnfAPOqWKLYoERZaxd4
         TXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mtc3nhV1yFjtyZ72uQDRZQmFUp1an9UYV0/ZePw2JCY=;
        b=lzg7xm/o7FI+0mW5viT80SHA7KUAqgSAGD2z5dc8DbWnVkYSwqhZf+fWkZscCV1mq5
         mbj22Bic4mU0X/atygI6gfbxwD6kcftAMoXKNKoC6ZoaarhCeHNtSPyxRFPo4zj2ZJRq
         FRGjFZC2iSNTY6XEkOcN+yIwczWCuoG1u32Im7BslaH4frgqCHRI7FoCEIFmIfDPkIAa
         NIW9ekPK31I7SFCzD0tw9vdGR+WFyr0Iw/4vpxPpVgJ0ne2FUY7j3Hu03ZGZ4mja+c+f
         Plgu8ni7LFitfzbWsx+mFgWANzjkRb26X2Iq2OLIQ8cuGbuYSDpZBH/fpNVNPDq7kdc/
         +23w==
X-Gm-Message-State: APjAAAU2ESK/M+oVitIx8Mr49R6D7itK2Pa3acFKW4XWyThMVa5Go3ZH
        eCB2EhWAyI5YCFWBdolQJbH8S6tlIUsx/kk7YeU=
X-Google-Smtp-Source: APXvYqzDRL8WUdWdfu/NIMmgyHqNWTLG1ythYteS9iJVNiC9RoJWX2HGhndP6u2TLymhMdgC8Cr216jYUxnmWOh4f58=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr7708132qkg.39.1581449412579;
 Tue, 11 Feb 2020 11:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20200210200737.13866-1-dxu@dxuuu.xyz> <20200210200737.13866-3-dxu@dxuuu.xyz>
In-Reply-To: <20200210200737.13866-3-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 Feb 2020 11:30:01 -0800
Message-ID: <CAEf4BzZfGXHL36ntjkQsTTEEa9yzqnS=Xs4XCibejpo5AKGpuQ@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next RESEND 2/2] selftests/bpf: add
 bpf_read_branch_records() selftest
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 10, 2020 at 12:09 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Add a selftest to test:
>
> * default bpf_read_branch_records() behavior
> * BPF_F_GET_BRANCH_RECORDS_SIZE flag behavior
> * error path on non branch record perf events
> * using helper to write to stack
> * using helper to write to map
>
> On host with hardware counter support:
>
>     # ./test_progs -t perf_branches
>     #27/1 perf_branches_hw:OK
>     #27/2 perf_branches_no_hw:OK
>     #27 perf_branches:OK
>     Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> On host without hardware counter support (VM):
>
>     # ./test_progs -t perf_branches
>     #27/1 perf_branches_hw:OK
>     #27/2 perf_branches_no_hw:OK
>     #27 perf_branches:OK
>     Summary: 1/2 PASSED, 1 SKIPPED, 0 FAILED
>
> Also sync tools/include/uapi/linux/bpf.h.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/include/uapi/linux/bpf.h                |  25 ++-
>  .../selftests/bpf/prog_tests/perf_branches.c  | 182 ++++++++++++++++++
>  .../selftests/bpf/progs/test_perf_branches.c  |  74 +++++++
>  3 files changed, 280 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c
>

[...]

> +       /* generate some branches on cpu 0 */
> +       CPU_ZERO(&cpu_set);
> +       CPU_SET(0, &cpu_set);
> +       err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
> +       if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
> +               goto out_free_pb;
> +       /* spin the loop for a while (random high number) */
> +       for (i = 0; i < 1000000; ++i)
> +               ++j;
> +

test_perf_branches__detach here?

> +       /* read perf buffer */
> +       err = perf_buffer__poll(pb, 500);
> +       if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
> +               goto out_free_pb;
> +
> +       if (CHECK(!ok, "ok", "not ok\n"))
> +               goto out_free_pb;
> +

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
> new file mode 100644
> index 000000000000..60327d512400
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2019 Facebook
> +
> +#include <stddef.h>
> +#include <linux/ptrace.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_trace_helpers.h"
> +
> +struct fake_perf_branch_entry {
> +       __u64 _a;
> +       __u64 _b;
> +       __u64 _c;
> +};
> +
> +struct output {
> +       int required_size;
> +       int written_stack;
> +       int written_map;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +       __uint(key_size, sizeof(int));
> +       __uint(value_size, sizeof(int));
> +} perf_buf_map SEC(".maps");
> +
> +typedef struct fake_perf_branch_entry fpbe_t[30];
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, fpbe_t);
> +} scratch_map SEC(".maps");

Can you please use global variables instead of array and
perf_event_array? Would make BPF side clearer and userspace simpler.
struct output member will just become variables.

[...]
