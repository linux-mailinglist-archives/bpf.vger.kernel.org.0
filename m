Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E2A20FCB4
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 21:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgF3TYG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 15:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgF3TYF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 15:24:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952F0C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 12:24:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so19736620qkb.8
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WG0PVAJaY9m6Bbo5rnedHvIHgcHLQFKN9oqROlWXEL4=;
        b=FcpLiCKiO7KFr4cPLWGdSw7uLR4a8CK32dLcd5psYtjK84k2cQ9HLOu5EvQtchp7GR
         Ksm6GvIO/ujEpptWdg3pv2o/3R6iazlTl7UJLdf43x2wcR0AjhSwS3SF1mX9KDBlFqe/
         9fFm/KUVe0wcpl8ur91SRtXenM+sWUd57ImBetUQxZlVvGYV5bMxLKwjP9+d/jMcmsS1
         gbL61lMdkAYlx2sC7tg30x4h4/pEbY3/63ufnG0pKpZR4OnI3eX14gnHevVyNnd2wzk3
         LFNE9hTp+pGYNd2UDdW94AgLJ6rBZJ6GYeYD6fJVUO0TU0X7wEuhsPyoS2/s02mNzrgZ
         s/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WG0PVAJaY9m6Bbo5rnedHvIHgcHLQFKN9oqROlWXEL4=;
        b=Jo5KXf1sJCcoWTjOi+W9TA1KTsk4MZF6pECAJtmgN4uwNLMDFz4GwDMJZYlRpDaB/I
         6h+d8WUVD4uMk09RS38ixtGPTi27uMeLZOMQ+eFeVp1FVYChyJoX7glxjX1TzIt19bdf
         HoEcBJ2gpb0oFqVLwoKnpcNdktXRQMmbaMNfl5+GUTyb0KzWGNOJeZo0nEGfMAnwFZOk
         Qmj4dfRsSz4dSaH9c4xR14HXUWUPffN4l9/nhvfrTAFgR2EFst0TmX7sBoDOUVUFcCW8
         9U+3rDxIV/ofqzw7GzrATpwNNBTugN3Nwp1/yMQVogY2fNHvtb2Zga1Kp2Amh6Wp5LfF
         JnsA==
X-Gm-Message-State: AOAM531+dF2EAHPCakD2NFvdw+DWhOn8mPqrxncAgqmIdkzANKFSkhLZ
        0Uo1foso37V629ZK6tltRJ2GDUD38TUl519IM14=
X-Google-Smtp-Source: ABdhPJxFlk6y2Ow3kXqV1bVBnUz9SaLZ1XA3AnNuZpgE2qP5o0eP2pvJA9b2QxJLGgH8UejRDLMgh21aU/SHm4txAF0=
X-Received: by 2002:ae9:f002:: with SMTP id l2mr10612904qkg.437.1593545044453;
 Tue, 30 Jun 2020 12:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200630171240.2523628-1-yhs@fb.com> <20200630171241.2523875-1-yhs@fb.com>
In-Reply-To: <20200630171241.2523875-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Jun 2020 12:23:53 -0700
Message-ID: <CAEf4BzbfKWaJH3i3+L1kc79zytO1xAhFCiF-4bPd6dqBPA+SSQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] bpf: add tests for PTR_TO_BTF_ID vs. null comparison
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 11:46 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add two tests for PTR_TO_BTF_ID vs. null ptr comparison,
> one for PTR_TO_BTF_ID in the ctx structure and the
> other for PTR_TO_BTF_ID after one level pointer chasing.
> In both cases, the test ensures condition is not
> removed.
>
> For example, for this test
>  struct bpf_fentry_test_t {
>      struct bpf_fentry_test_t *a;
>  };
>  int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>  {
>      if (arg == 0)
>          test7_result = 1;
>      return 0;
>  }
> Before the previous verifier change, we have xlated codes:
>   int test7(long long unsigned int * ctx):
>   ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>      0: (79) r1 = *(u64 *)(r1 +0)
>   ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>      1: (b4) w0 = 0
>      2: (95) exit
> After the previous verifier change, we have:
>   int test7(long long unsigned int * ctx):
>   ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>      0: (79) r1 = *(u64 *)(r1 +0)
>   ; if (arg == 0)
>      1: (55) if r1 != 0x0 goto pc+4
>   ; test7_result = 1;
>      2: (18) r1 = map[id:6][0]+48
>      4: (b7) r2 = 1
>      5: (7b) *(u64 *)(r1 +0) = r2
>   ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>      6: (b4) w0 = 0
>      7: (95) exit
>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Wenbo Zhang <ethercflow@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM, two nits below.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  net/bpf/test_run.c                            | 19 +++++++++++++++-
>  .../selftests/bpf/prog_tests/fentry_fexit.c   |  2 +-
>  .../testing/selftests/bpf/progs/fentry_test.c | 22 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/fexit_test.c  | 22 +++++++++++++++++++
>  4 files changed, 63 insertions(+), 2 deletions(-)
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/testing/selftests/bpf/progs/fentry_test.c
> index 9365b686f84b..5f645fdaba6f 100644
> --- a/tools/testing/selftests/bpf/progs/fentry_test.c
> +++ b/tools/testing/selftests/bpf/progs/fentry_test.c
> @@ -55,3 +55,25 @@ int BPF_PROG(test6, __u64 a, void *b, short c, int d, void * e, __u64 f)
>                 e == (void *)20 && f == 21;
>         return 0;
>  }
> +
> +struct bpf_fentry_test_t {
> +       struct bpf_fentry_test_t *a;
> +};

nit: __attribute__((preserve_access_index)) ?

> +
> +__u64 test7_result = 0;
> +SEC("fentry/bpf_fentry_test7")
> +int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
> +{
> +       if (arg == 0)
> +               test7_result = 1;
> +       return 0;
> +}
> +
> +__u64 test8_result = 0;
> +SEC("fentry/bpf_fentry_test8")
> +int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
> +{
> +       if (arg->a == 0)
> +               test8_result = 1;
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testing/selftests/bpf/progs/fexit_test.c
> index bd1e17d8024c..0952affb22a6 100644
> --- a/tools/testing/selftests/bpf/progs/fexit_test.c
> +++ b/tools/testing/selftests/bpf/progs/fexit_test.c
> @@ -56,3 +56,25 @@ int BPF_PROG(test6, __u64 a, void *b, short c, int d, void *e, __u64 f, int ret)
>                 e == (void *)20 && f == 21 && ret == 111;
>         return 0;
>  }
> +
> +struct bpf_fentry_test_t {
> +       struct bpf_fentry_test *a;
> +};

same nit

> +
> +__u64 test7_result = 0;
> +SEC("fexit/bpf_fentry_test7")
> +int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
> +{
> +       if (arg == 0)
> +               test7_result = 1;
> +       return 0;
> +}
> +
> +__u64 test8_result = 0;
> +SEC("fexit/bpf_fentry_test8")
> +int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
> +{
> +       if (arg->a == 0)
> +               test8_result = 1;
> +       return 0;
> +}
> --
> 2.24.1
>
