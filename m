Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C784273B9
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhJHW3Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhJHW3Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:16 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B15C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:27:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v195so24280025ybb.0
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uziYuWa9/YE/z9nWq64BWBEgcPL5B6wpo4Y1bYuSa18=;
        b=PRJdsEyFb+vth9CUq6e7mXUjGCXfFWpvasna1Uctx8k/ml7ipumuvpe/dVD9JESJUk
         aMx5BxZCRYFekF423RmE8PbbNpKc10lSo8qOyfMvwjc6bIL74CWPSX6PeL9IFCs0JHNC
         EFatH8p5RZFTEFeecv589jElIiQ8cyRK/RSU4PbvZPc/fqcYgNn8/TIDnum/C7Q9EZne
         mdoDCKDT0N6bdueQdH6d6Mdq14Or2+ynnLXiqHtXYYeO4Bjx/qWzKj0zt5vg/DYfzZlI
         NoofaAQMPgu01ymopJ99NiEOStjgVLxqWwMjQpzqo/BgoFzJIvf5XgNAkvD/c9tm0ssr
         o7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uziYuWa9/YE/z9nWq64BWBEgcPL5B6wpo4Y1bYuSa18=;
        b=YwDIYFdCU2ZI2lRkavDXwNCZuzp6XHpSCQNM47aBQ8HYFygzPS9n45Jsfu2m3mHU16
         q8OmmhOs4eoWEvUX68LxqwTCHUht5cgVtlBmwlSoC6B6l2pLYlqhmcGdNQsAVOyVNcFN
         RSIRrvrQdFd6yvg7byIAqDC4AUYDR/f0itzVyze+seNP9QmhNftIsLk3Zv1yAJ77NUEH
         6So3lkwlleb6b146YowO/DrGMgrg0AgnhjjEjlgFmpEvIe9zORkq4+YLAYMtI1lBbkAR
         D430JGmeCujXXa+9gLPn39Wx95pP0DBMev2FAO8YZk7ZeYUVNcjUdlLR/OCMWy6xtPrI
         Dvuw==
X-Gm-Message-State: AOAM530m5dO4WGmJGnYgT1bGGhu8Z71VuYlFBeVwb0WDLw436cIZRBvK
        XNBoXUfIHo+3cpqAl5IilMTWChtiSXZG7JwU6q0=
X-Google-Smtp-Source: ABdhPJwEqvvWWpiGUwMW+8Tu4liV5zXXE515NBTQP4yPx9t2u8FhyD/d7ltrvXVrsS4ww4R5c1XE6shS7B2PmLLDD+A=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr6597926ybk.2.1633732039835;
 Fri, 08 Oct 2021 15:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-6-fallentree@fb.com>
In-Reply-To: <20211006185619.364369-6-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:27:08 -0700
Message-ID: <CAEf4BzaWi5FQsES5C72T6FgPbEdxqAfQGTArovY_d2KS_w6-=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/14] selftests/bpf: adding
 read_perf_max_sample_freq() helper
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch moved a helper function to test_progs and make all tests
> setting sampling frequency use it to read current perf_max_sample_freq,
> this will avoid triggering EINVAL error.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_cookie.c     |  2 +-
>  .../selftests/bpf/prog_tests/perf_branches.c  |  4 ++--
>  .../selftests/bpf/prog_tests/perf_link.c      |  2 +-
>  .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 19 ++-----------------
>  tools/testing/selftests/bpf/test_progs.c      | 15 +++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h      |  1 +
>  6 files changed, 22 insertions(+), 21 deletions(-)
>

We have trace_helper.c, seems like it would be better to have it
there? I haven't applied this patch yet.

[...]

> @@ -48,6 +31,8 @@ void test_stacktrace_build_id_nmi(void)
>         if (CHECK(err, "skel_load", "skeleton load failed: %d\n", err))
>                 goto cleanup;
>
> +       attr.sample_freq = read_perf_max_sample_freq();
> +
>         pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
>                          0 /* cpu 0 */, -1 /* group id */,
>                          0 /* flags */);
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 2ac922f8aa2c..66825313414b 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1500,3 +1500,18 @@ int main(int argc, char **argv)
>
>         return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
>  }
> +
> +__u64 read_perf_max_sample_freq(void)
> +{
> +       __u64 sample_freq = 1000; /* fallback to 1000 on error */

previous default was 5000, message below still claims 5000, what's the
reason for changing it?



> +       FILE *f;
> +       __u32 duration = 0;
> +
> +       f = fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
> +       if (f == NULL)
> +               return sample_freq;
> +       CHECK(fscanf(f, "%llu", &sample_freq) != 1, "Get max sample rate",
> +             "return default value: 5000,err %d\n", -errno);
> +       fclose(f);
> +       return sample_freq;
> +}
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index b239dc9fcef0..d5ca0d36cc96 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -327,6 +327,7 @@ int extract_build_id(char *build_id, size_t size);
>  int kern_sync_rcu(void);
>  int trigger_module_test_read(int read_sz);
>  int trigger_module_test_write(int write_sz);
> +__u64 read_perf_max_sample_freq(void);
>
>  #ifdef __x86_64__
>  #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
> --
> 2.30.2
>
