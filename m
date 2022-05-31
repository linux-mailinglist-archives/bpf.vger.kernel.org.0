Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B55539545
	for <lists+bpf@lfdr.de>; Tue, 31 May 2022 19:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiEaRLg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 13:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiEaRLf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 13:11:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D58BD1E;
        Tue, 31 May 2022 10:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC64860A54;
        Tue, 31 May 2022 17:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631D5C3411D;
        Tue, 31 May 2022 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654017093;
        bh=PiJTFDNVbEqwodufEmKeOFpsiPkT1+3psU+PLhFiVvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a1kBtGxeowAhq9hi8kGTWlPnjN6B174ifLpjM0UytOV0o/RNsLoF97qVr5j31gMHo
         8UQ9FmXxVkOntl7m1kJNMvlMQahstqASa/9BC5oh2XcmhM2C5GTJYbgZLcq1wAXYtz
         a1hRp9RsIGzu7Va8u8+dvr4Zu9T57Osn1ip4rNLIiwZmb2OGzY5KGvMlWldrqDv1sf
         8rBaurh9N9UnJ7QJuSG8E7kbrQXxJTsGoJ9KnbxocUfWHqomOLPmqDeqS2mcDiMwMW
         SPr73kr0YRSgFvuA5fgcuz3gekf3c19qRq+l/abo4ZmhT0PFeiDssuavc4h1hDXPHA
         owNDiCUGP40tA==
Received: by mail-yb1-f169.google.com with SMTP id i11so24997869ybq.9;
        Tue, 31 May 2022 10:11:33 -0700 (PDT)
X-Gm-Message-State: AOAM532IHZ3o/Zo1ERSBqel7rb6JQ+Zj1jKFHLGfd7C7PGnRQh33Eym9
        phGv4HSgqSiBHuLlQKPidHpzoif8jr7Z0sXgh5s=
X-Google-Smtp-Source: ABdhPJwvDKqKQC9u2rSsjZrg7aOLDH1q98E2Fy1YGgfjIjyvfPDnWPlwAS8Sm1EVf3Ec6+b95jlZB9zo0bfU7vsaVUM=
X-Received: by 2002:a25:4705:0:b0:65d:43f8:5652 with SMTP id
 u5-20020a254705000000b0065d43f85652mr3648473yba.389.1654017092431; Tue, 31
 May 2022 10:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1653861287.git.dxu@dxuuu.xyz> <a8f5faada9b96218d79beb7b7ddebe6a837a5536.1653861287.git.dxu@dxuuu.xyz>
In-Reply-To: <a8f5faada9b96218d79beb7b7ddebe6a837a5536.1653861287.git.dxu@dxuuu.xyz>
From:   Song Liu <song@kernel.org>
Date:   Tue, 31 May 2022 10:11:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6eQXZrnJdRGUEu6jQAjpXnEB_f4bzBF1rXst4LWBWd=g@mail.gmail.com>
Message-ID: <CAPhsuW6eQXZrnJdRGUEu6jQAjpXnEB_f4bzBF1rXst4LWBWd=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add PROG_TEST_RUN selftest
 for BPF_PROG_TYPE_KPROBE
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 29, 2022 at 3:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit adds a selftest to test that we can both PROG_TEST_RUN a
> kprobe prog and set its context.

nit: per Documentation/process/submitting-patches.rst:

Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.

>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Other than that,

Acked-by: Song Liu <songliubraving@fb.com>


> ---
>  .../selftests/bpf/prog_tests/kprobe_ctx.c     | 57 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/kprobe_ctx.c  | 33 +++++++++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_ctx.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_ctx.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_ctx.c b/tools/testing/selftests/bpf/prog_tests/kprobe_ctx.c
> new file mode 100644
> index 000000000000..260966fd4506
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_ctx.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <linux/ptrace.h>
> +#include "kprobe_ctx.skel.h"
> +
> +/*
> + * x86_64 happens to be one of the architectures that exports the
> + * kernel `struct pt_regs` to userspace ABI. For the architectures
> + * that don't, users will have to extract `struct pt_regs` from vmlinux
> + * BTF in order to use BPF_PROG_TYPE_KPROBE's BPF_PROG_RUN functionality.
> + *
> + * We choose to only test x86 here to keep the test simple.
> + */
> +void test_kprobe_ctx(void)
> +{
> +#ifdef __x86_64__
> +       struct pt_regs regs = {
> +               .rdi = 1,
> +               .rsi = 2,
> +               .rdx = 3,
> +               .rcx = 4,
> +               .r8 = 5,
> +       };
> +
> +       LIBBPF_OPTS(bpf_test_run_opts, tattr,
> +               .ctx_in = &regs,
> +               .ctx_size_in = sizeof(regs),
> +       );
> +
> +       struct kprobe_ctx *skel = NULL;
> +       int prog_fd;
> +       int err;
> +
> +       skel = kprobe_ctx__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       skel->bss->expected_p1 = (void *)1;
> +       skel->bss->expected_p2 = (void *)2;
> +       skel->bss->expected_p3 = (void *)3;
> +       skel->bss->expected_p4 = (void *)4;
> +       skel->bss->expected_p5 = (void *)5;
> +
> +       prog_fd = bpf_program__fd(skel->progs.prog);
> +       err = bpf_prog_test_run_opts(prog_fd, &tattr);
> +       if (!ASSERT_OK(err, "bpf_prog_test_run"))
> +               goto cleanup;
> +
> +       if (!ASSERT_TRUE(skel->bss->ret, "ret"))
> +               goto cleanup;
> +
> +       if (!ASSERT_GT(tattr.duration, 0, "duration"))
> +               goto cleanup;
> +cleanup:
> +       kprobe_ctx__destroy(skel);
> +#endif
> +}
> diff --git a/tools/testing/selftests/bpf/progs/kprobe_ctx.c b/tools/testing/selftests/bpf/progs/kprobe_ctx.c
> new file mode 100644
> index 000000000000..98063c549930
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kprobe_ctx.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +volatile void *expected_p1;
> +volatile void *expected_p2;
> +volatile void *expected_p3;
> +volatile void *expected_p4;
> +volatile void *expected_p5;
> +volatile bool ret = false;
> +
> +SEC("kprobe/this_function_does_not_exist")
> +int prog(struct pt_regs *ctx)
> +{
> +       void *p1, *p2, *p3, *p4, *p5;
> +
> +       p1 = (void *)PT_REGS_PARM1(ctx);
> +       p2 = (void *)PT_REGS_PARM2(ctx);
> +       p3 = (void *)PT_REGS_PARM3(ctx);
> +       p4 = (void *)PT_REGS_PARM4(ctx);
> +       p5 = (void *)PT_REGS_PARM5(ctx);
> +
> +       if (p1 != expected_p1 || p2 != expected_p2 || p3 != expected_p3 ||
> +           p4 != expected_p4 || p5 != expected_p5)
> +               return 0;
> +
> +       ret = true;
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.36.1
>
