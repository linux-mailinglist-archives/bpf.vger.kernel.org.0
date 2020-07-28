Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFF2231661
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 01:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgG1XmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 19:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbgG1XmV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 19:42:21 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23192075D
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 23:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595979741;
        bh=yqG2GsmNKP/IW1idMDNUyImoWeBa2E6r9yYiRXGcNXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e69V6/uWRbe1KebjGkvNRvhvrKdYIyverJ7COCzf5ocn5H0sfEEtovx0luyzUX8lA
         ssiRIUjEVPvsDzBiM1+4oyFqRF0q0op4PvYHHORvjVFQ49Duq1a79bN/cZUaowL0nl
         N4+LndNhS+XaCJwoWGAiuCymaLRYeVRc7Zv+ju9Y=
Received: by mail-lj1-f173.google.com with SMTP id 185so12838539ljj.7
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 16:42:20 -0700 (PDT)
X-Gm-Message-State: AOAM531h9L7QsmHkAyR6vIWevfsuF+MrsHUR7i2shbzTWUQ3l+/JNpUJ
        EI6XXuZTrTB1ifJH/i8aUVOxbfdDRtLK7Cyc4bU=
X-Google-Smtp-Source: ABdhPJxLbFHs9G7w0tC9PLOkAVtHK7fXKreUsVW4mO0+xiszWiy9qEqSqTSYe4dW0U8wQaY/Fs8VkkpEmju/T+enTog=
X-Received: by 2002:a2e:3003:: with SMTP id w3mr13792228ljw.273.1595979739061;
 Tue, 28 Jul 2020 16:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200728221801.1090349-1-yhs@fb.com> <20200728221801.1090406-1-yhs@fb.com>
In-Reply-To: <20200728221801.1090406-1-yhs@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jul 2020 16:42:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5aLvdjYphgBLJeJUkg82EZr852dj7G126PLDc5EJdq=w@mail.gmail.com>
Message-ID: <CAPhsuW5aLvdjYphgBLJeJUkg82EZr852dj7G126PLDc5EJdq=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: test bpf_iter buffer access
 with negative offset
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 3:18 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit afbf21dce668 ("bpf: Support readonly/readwrite buffers
> in verifier") added readonly/readwrite buffer support which
> is currently used by bpf_iter tracing programs. It has
> a bug with incorrect parameter ordering which later fixed
> by Commit f6dfbe31e8fa ("bpf: Fix swapped arguments in calls
> to check_buffer_access").
>
> This patch added a test case with a negative offset access
> which will trigger the error path.
>
> Without Commit f6dfbe31e8fa, running the test case in the patch,
> the error message looks like:
>    R1_w=rdwr_buf(id=0,off=0,imm=0) R10=fp0
>   ; value_sum += *(__u32 *)(value - 4);
>   2: (61) r1 = *(u32 *)(r1 -4)
>   R1 invalid (null) buffer access: off=-4, size=4
>
> With the above commit, the error message looks like:
>    R1_w=rdwr_buf(id=0,off=0,imm=0) R10=fp0
>   ; value_sum += *(__u32 *)(value - 4);
>   2: (61) r1 = *(u32 *)(r1 -4)
>   R1 invalid rdwr buffer access: off=-4, size=4
>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 13 ++++++++++++
>  .../selftests/bpf/progs/bpf_iter_test_kern6.c | 21 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index d95de80b1851..4ffefdc1130f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -21,6 +21,7 @@
>  #include "bpf_iter_bpf_percpu_array_map.skel.h"
>  #include "bpf_iter_bpf_sk_storage_map.skel.h"
>  #include "bpf_iter_test_kern5.skel.h"
> +#include "bpf_iter_test_kern6.skel.h"
>
>  static int duration;
>
> @@ -885,6 +886,16 @@ static void test_rdonly_buf_out_of_bound(void)
>         bpf_iter_test_kern5__destroy(skel);
>  }
>
> +static void test_buf_neg_offset(void)
> +{
> +       struct bpf_iter_test_kern6 *skel;
> +
> +       skel = bpf_iter_test_kern6__open_and_load();
> +       if (CHECK(skel, "bpf_iter_test_kern6__open_and_load",
> +                 "skeleton open_and_load unexpected success\n"))
> +               bpf_iter_test_kern6__destroy(skel);
> +}
> +
>  void test_bpf_iter(void)
>  {
>         if (test__start_subtest("btf_id_or_null"))
> @@ -933,4 +944,6 @@ void test_bpf_iter(void)
>                 test_bpf_sk_storage_map();
>         if (test__start_subtest("rdonly-buf-out-of-bound"))
>                 test_rdonly_buf_out_of_bound();
> +       if (test__start_subtest("buf-neg-offset"))
> +               test_buf_neg_offset();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c
> new file mode 100644
> index 000000000000..1c7304f56b1e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 Facebook */
> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u32 value_sum = 0;
> +
> +SEC("iter/bpf_map_elem")
> +int dump_bpf_hash_map(struct bpf_iter__bpf_map_elem *ctx)
> +{
> +       void *value = ctx->value;
> +
> +       if (value == (void *)0)
> +               return 0;
> +
> +       /* negative offset, verifier failure. */
> +       value_sum += *(__u32 *)(value - 4);
> +       return 0;
> +}
> --
> 2.24.1
>
