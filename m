Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A294D5FE265
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 21:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJMTG3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJMTGX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 15:06:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA8C1578A5
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 12:06:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m15so3899951edb.13
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4o2xIwq8lIpPFxY4llLg+4tg6OUYfotnj0mgIMo2Qg=;
        b=eJ5a1eFI3uOi3LooUVZfEDTCiyk0NMd3VdHJXJGauWuP+2cPo0jYxCb/NkeaAE1RAT
         AicYHkrBcNT+oQVkXWD4AEhqW9QUaW4ASCXY/OTgYN4jvopAecTwSUFM2DJq0SYUvX6w
         QRU/B/G1wSYRySg2yGGX9QVr12cUIz7DVyr4z7qKwaru1s3eluzNtjK5NKlFNFyigwRi
         n0egMKYX9KHRYhx/y8JCWmyj6roVOfSQ0IU2OMYfOjknwAxTKisrjdvdMABVZHfODYRg
         cY3FG6Zc99Y5VZJub+zc06Jd9g6s/NOjzVQ11cjfUoYFwF7pQ1KMiWv9P9ZYwlu+ty3w
         WTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4o2xIwq8lIpPFxY4llLg+4tg6OUYfotnj0mgIMo2Qg=;
        b=pZcAEHca3+7//4w+3m9q/Ei0z2twk2n5rYsImkysD6anGmS2gJh5w/FAjviC7KQ5Yz
         kz8YDc/b9IrzHeezjmKZ6TDqPLBwxPvC+VpXQPWPys5H6O9h1S3eqGLFOarmD6h/WbCs
         ArpM4KrnYIJ+mGTE4cMy3r5g11cDUvoguhpAPYX9ElIMVTL6MbFXKo0VJcMao5bzLODk
         sVzo6w7UwvUsrhyuWbKZDz+Y6PcTv0GQYMyuuQov5bkTNpgQp6wOETY48mV6RhGA3xgN
         TT5NKW/2Au8iboAXieMRBLzqHjSFtqFob9jzpTi7wlkhQDk4w0wY1bs/1MtkXORfv3P1
         hMsQ==
X-Gm-Message-State: ACrzQf2aO37wCd045AP4cjx+YUZx9yN7rGDOGoofn/n1JdpG4Tgq7EY/
        XG9AbfwaUGayWw6aUSM7orH/TZyCn+I74VSqYio=
X-Google-Smtp-Source: AMsMyM5aemqzzkBDUIUCoxaVMeNT452xj2c+CSwAStp01dJyH5AVyBxScED2VnNHiNYkcQ9Xa8pvO4zlaEAFiHCW/nQ=
X-Received: by 2002:a05:6402:22ed:b0:458:bcd1:69cf with SMTP id
 dn13-20020a05640222ed00b00458bcd169cfmr1104646edb.260.1665687978046; Thu, 13
 Oct 2022 12:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-8-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-8-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 Oct 2022 12:06:06 -0700
Message-ID: <CAEf4BzbX5G3LXNJAdRA0kkO=7V1pheN6fUHAHUcPjdpbFQSEuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: Add kprobe_multi kmod link
 api tests
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding kprobe_multi kmod link api tests that attach bpf_testmod
> functions via kprobe_multi link API.
>
> Running it as serial test, because we don't want other tests to
> reload bpf_testmod while it's running.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../prog_tests/kprobe_multi_testmod_test.c    | 94 +++++++++++++++++++
>  .../selftests/bpf/progs/kprobe_multi.c        | 51 ++++++++++
>  2 files changed, 145 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> new file mode 100644
> index 000000000000..5fe02572650a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "kprobe_multi.skel.h"
> +#include "trace_helpers.h"
> +#include "bpf/libbpf_internal.h"
> +
> +static void kprobe_multi_testmod_check(struct kprobe_multi *skel)
> +{
> +       ASSERT_EQ(skel->bss->kprobe_testmod_test1_result, 1, "kprobe_test1_result");
> +       ASSERT_EQ(skel->bss->kprobe_testmod_test2_result, 1, "kprobe_test2_result");
> +       ASSERT_EQ(skel->bss->kprobe_testmod_test3_result, 1, "kprobe_test3_result");
> +
> +       ASSERT_EQ(skel->bss->kretprobe_testmod_test1_result, 1, "kretprobe_test1_result");
> +       ASSERT_EQ(skel->bss->kretprobe_testmod_test2_result, 1, "kretprobe_test2_result");
> +       ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1, "kretprobe_test3_result");
> +}
> +
> +static void test_testmod_link_api(struct bpf_link_create_opts *opts)
> +{
> +       int prog_fd, link1_fd = -1, link2_fd = -1;
> +       struct kprobe_multi *skel = NULL;
> +
> +       skel = kprobe_multi__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
> +               goto cleanup;
> +
> +       skel->bss->pid = getpid();
> +       prog_fd = bpf_program__fd(skel->progs.test_kprobe_testmod);
> +       link1_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, opts);
> +       if (!ASSERT_GE(link1_fd, 0, "link_fd1"))
> +               goto cleanup;
> +
> +       opts->kprobe_multi.flags = BPF_F_KPROBE_MULTI_RETURN;
> +       prog_fd = bpf_program__fd(skel->progs.test_kretprobe_testmod);
> +       link2_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, opts);
> +       if (!ASSERT_GE(link2_fd, 0, "link_fd2"))
> +               goto cleanup;
> +

any reason to not use bpf_program__attach_kprobe_multi_ops() and
instead use low-level bpf_link_create?

> +       ASSERT_OK(trigger_module_test_read(1), "trigger_read");
> +       kprobe_multi_testmod_check(skel);
> +
> +cleanup:
> +       if (link1_fd != -1)
> +               close(link1_fd);
> +       if (link2_fd != -1)
> +               close(link2_fd);

you don't need to even do this if you stick to high-level attach APIs

> +       kprobe_multi__destroy(skel);
> +}
> +
> +#define GET_ADDR(__sym, __addr) ({                                     \
> +       __addr = ksym_get_addr(__sym);                                  \
> +       if (!ASSERT_NEQ(__addr, 0, "kallsyms load failed for " #__sym)) \
> +               return;                                                 \
> +})

macro for this? why? just make understanding the code and debugging
it, if necessary, harder. You don't even need that return, just lookup
and ASSERT_NEQ(). Go to symbol #2 and do the same. If something goes
wrong you'll have three failed ASSERT_NEQs, which is totally fine.

> +
> +static void test_testmod_link_api_addrs(void)
> +{
> +       LIBBPF_OPTS(bpf_link_create_opts, opts);
> +       unsigned long long addrs[3];
> +
> +       GET_ADDR("bpf_testmod_fentry_test1", addrs[0]);
> +       GET_ADDR("bpf_testmod_fentry_test2", addrs[1]);
> +       GET_ADDR("bpf_testmod_fentry_test3", addrs[2]);
> +
> +       opts.kprobe_multi.addrs = (const unsigned long *) addrs;
> +       opts.kprobe_multi.cnt = ARRAY_SIZE(addrs);
> +
> +       test_testmod_link_api(&opts);
> +}
> +
> +static void test_testmod_link_api_syms(void)
> +{
> +       LIBBPF_OPTS(bpf_link_create_opts, opts);
> +       const char *syms[3] = {
> +               "bpf_testmod_fentry_test1",
> +               "bpf_testmod_fentry_test2",
> +               "bpf_testmod_fentry_test3",
> +       };
> +
> +       opts.kprobe_multi.syms = syms;
> +       opts.kprobe_multi.cnt = ARRAY_SIZE(syms);
> +       test_testmod_link_api(&opts);
> +}
> +
> +void serial_test_kprobe_multi_testmod_test(void)
> +{
> +       if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
> +               return;
> +
> +       if (test__start_subtest("testmod_link_api_syms"))
> +               test_testmod_link_api_syms();
> +       if (test__start_subtest("testmod_link_api_addrs"))
> +               test_testmod_link_api_addrs();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> index 98c3399e15c0..b3c54ec13a45 100644
> --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> @@ -110,3 +110,54 @@ int test_kretprobe_manual(struct pt_regs *ctx)
>         kprobe_multi_check(ctx, true);
>         return 0;
>  }
> +
> +extern const void bpf_testmod_fentry_test1 __ksym;
> +extern const void bpf_testmod_fentry_test2 __ksym;
> +extern const void bpf_testmod_fentry_test3 __ksym;
> +
> +__u64 kprobe_testmod_test1_result = 0;
> +__u64 kprobe_testmod_test2_result = 0;
> +__u64 kprobe_testmod_test3_result = 0;
> +
> +__u64 kretprobe_testmod_test1_result = 0;
> +__u64 kretprobe_testmod_test2_result = 0;
> +__u64 kretprobe_testmod_test3_result = 0;
> +
> +static void kprobe_multi_testmod_check(void *ctx, bool is_return)
> +{
> +       if (bpf_get_current_pid_tgid() >> 32 != pid)
> +               return;
> +
> +       __u64 addr = bpf_get_func_ip(ctx);
> +
> +#define SET(__var, __addr) ({                          \
> +       if ((const void *) addr == __addr)              \
> +               __var = 1;                              \
> +})
> +

same feedback, why macro for this? There is nothing repetitive done in it at all

> +       if (is_return) {
> +               SET(kretprobe_testmod_test1_result, &bpf_testmod_fentry_test1);
> +               SET(kretprobe_testmod_test2_result, &bpf_testmod_fentry_test2);
> +               SET(kretprobe_testmod_test3_result, &bpf_testmod_fentry_test3);
> +       } else {
> +               SET(kprobe_testmod_test1_result, &bpf_testmod_fentry_test1);
> +               SET(kprobe_testmod_test2_result, &bpf_testmod_fentry_test2);
> +               SET(kprobe_testmod_test3_result, &bpf_testmod_fentry_test3);
> +       }
> +
> +#undef SET
> +}
> +
> +SEC("kprobe.multi")
> +int test_kprobe_testmod(struct pt_regs *ctx)
> +{
> +       kprobe_multi_testmod_check(ctx, false);
> +       return 0;
> +}
> +
> +SEC("kretprobe.multi")
> +int test_kretprobe_testmod(struct pt_regs *ctx)
> +{
> +       kprobe_multi_testmod_check(ctx, true);
> +       return 0;
> +}
> --
> 2.37.3
>
