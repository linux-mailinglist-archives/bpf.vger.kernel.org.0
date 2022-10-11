Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1763C5FAD73
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 09:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJKH13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 03:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJKH12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 03:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767F6527B
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6303610F4
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C99C43144
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665473246;
        bh=uXQUjQxkEBLJOa4xa9TH7b3q+w2qaBuQeGFMrLtsx9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EH7gtQBP9R2hj0L9YaeY0Y0wPdQrrG+Yh8mNCAH2euDy7NGoRcQYIKMPVXrIETY5g
         W5pq680mKXYLBcBEG54AZ3rF1CK4V6vXp6N8eHokTqeB8JBKoDl1fFb0jo4zgtaUcI
         vYp4hRt+/K554c9Kg2bgow/JORyJo2KdSkx8xiRDJTIwcB9M/T1QefsUegYi9uORKk
         hUmudQtiWCMgwJZLZR0LcD5S8S4evcJfooLrnlncjC4ajuADmG+ZuNADEliKIGSlfU
         KnEH03wGE7AJgLtiYsZV+Q4Oo3IoolvDjtk6WoDMCpzVtoUs7ThKHTc7ryYYg42sFO
         65oCoOkmdnf+w==
Received: by mail-ej1-f43.google.com with SMTP id k2so29485644ejr.2
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:27:26 -0700 (PDT)
X-Gm-Message-State: ACrzQf1zeyUQsN0cOJACyQShkVy9kBiEKFzD7pbEm987eG10oo69pYXP
        BcaqjVYm7d6gOCn8Nvu40tmiSPMZs70eIrkvarY=
X-Google-Smtp-Source: AMsMyM70/1axX88/jBRVG116cymlUXJki9g/ZSlmNe/nxxQwRlwWi1jvmx3BStpgpPjzOl41bECnAgPrUAhY1t6DTWI=
X-Received: by 2002:a17:907:970b:b0:78d:8d70:e4e8 with SMTP id
 jg11-20020a170907970b00b0078d8d70e4e8mr13747793ejc.614.1665473244298; Tue, 11
 Oct 2022 00:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-8-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-8-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 11 Oct 2022 00:27:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6r+=nzTozfzQzk+2qKr_3rmiY55TPDfnUgOZriWWWaYg@mail.gmail.com>
Message-ID: <CAPhsuW6r+=nzTozfzQzk+2qKr_3rmiY55TPDfnUgOZriWWWaYg@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 9, 2022 at 3:01 PM Jiri Olsa <jolsa@kernel.org> wrote:
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

nit: we can just return here.

Other than this:

Acked-by: Song Liu <song@kernel.org>

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
> +       ASSERT_OK(trigger_module_test_read(1), "trigger_read");
> +       kprobe_multi_testmod_check(skel);
> +
> +cleanup:
> +       if (link1_fd != -1)
> +               close(link1_fd);
> +       if (link2_fd != -1)
> +               close(link2_fd);
> +       kprobe_multi__destroy(skel);
> +}
>
