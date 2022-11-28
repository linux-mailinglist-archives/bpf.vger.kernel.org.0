Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2F363B40B
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 22:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiK1VOb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 16:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiK1VOa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 16:14:30 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A7815724
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 13:14:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h193so11076534pgc.10
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 13:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sJRA9FCDRavUYFI7by3yzKVeT1ghN1Puv2XV3+n07Vw=;
        b=cAwGflSSgDrT6knZFijAgJJnr7Yug52EFqBZ2tvYo3IxWJ9F1X2lokwmnBYbesk1DC
         uNYEE1fYrVKXjtwrxnI4NvqBz4Cc9nU0Beq43/jAQNmBa1wrjUmVHx16UQ5Gs4vQYz49
         W0sf5N5h5goPTEu5jn4RaHI5BBHAIOTtjqh43vrACOyI08c6jGgm4sSS2do9OIEJNPxC
         Rk26zlEJD+FxbCwVDniS1ILUYIaAsZWcjDll8SUpuBHNZiZf7TmNRJQT6KS+GCCECfPY
         btFQp/qA/TC1Y5FhKs879Ebmp3vIhgiVbjNN5XHNKHi6qlMY5iybvN1kSySweBWC4ugL
         rleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJRA9FCDRavUYFI7by3yzKVeT1ghN1Puv2XV3+n07Vw=;
        b=w6LCXu3mrSdAy+owRXUY2H4LrcJDE4fXbVVXWrHxR8zyD3Rd8dsVQnMltv6wBs36M1
         PeC3KPABKJMxRvw1t89jeAp+hTZj4byfMz6SWLGYW4XCcG2IAyMjwg116WBQ9L0wNKSk
         LvNfKTAu+uVhs1AbpDclvmx3NSrBQR6mvZNoiWxJ2zQaaGG2SArKB/S3b+tvJ44zjeH4
         +cOzUveFlAMwHJsxsk1fIx5+CuZYHNanyI2Tulw4PI53GeTqI02n9kSBfkhu2YdL02c5
         l2EdtfvIg7wiccnLMPYLXnwvyoSOgya2SnAi8FIIs+PlGqN26kbUoJJoY2Bp4Vt+WW5G
         zbmw==
X-Gm-Message-State: ANoB5pkzbF4GSFmlem/8kJF+tgH+cXshqTndbFZI9FCM6Lh65zjz8z80
        dTFYAnI6fSVxromYZAfQkp9hi2KUlyO9yNMV6ORrb6gVIQrSTg==
X-Google-Smtp-Source: AA0mqf5xeQ4Hw6fZFL+Mhd0YJMnPhuHNQh7MtpSf4tJ5AH+UHFqRi8pvov6NDlHUps2UUvT/g0480EzagYU+oxDJ6io=
X-Received: by 2002:a63:1302:0:b0:439:e030:3fa8 with SMTP id
 i2-20020a631302000000b00439e0303fa8mr29573667pgl.554.1669670068796; Mon, 28
 Nov 2022 13:14:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669216157.git.vmalik@redhat.com> <bc324e55558563ccb34f563d86d12c881c31ce9c.1669216157.git.vmalik@redhat.com>
In-Reply-To: <bc324e55558563ccb34f563d86d12c881c31ce9c.1669216157.git.vmalik@redhat.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 28 Nov 2022 13:14:17 -0800
Message-ID: <CA+khW7ipecor86hNYdDfQe1FDjOQ6ddN7f7YQP_64Ms-VVzCXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf/selftests: Test fentry attachment to
 shadowed functions
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 27, 2022 at 11:26 PM Viktor Malik <vmalik@redhat.com> wrote:
>
> Adds a new test that tries to attach a program to fentry of two
> functions of the same name, one located in vmlinux and the other in
> bpf_testmod.
>
> To avoid conflicts with existing tests, a new function
> "bpf_fentry_shadow_test" was created both in vmlinux and in bpf_testmod.
>
> The previous commit fixed a bug which caused this test to fail. The
> verifier would always use the vmlinux function's address as the target
> trampoline address, hence trying to attach two programs to the same
> trampoline.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
<...>
> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
> new file mode 100644
> index 000000000000..0c604a0f22ca
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Red Hat */
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "bpf/libbpf_internal.h"
> +#include "cgroup_helpers.h"
> +
> +static const char *module_name = "bpf_testmod";
> +static const char *symbol_name = "bpf_fentry_shadow_test";
> +
> +int get_bpf_testmod_btf_fd(void)
> +{
> +       struct bpf_btf_info info;
> +       char name[64];
> +       __u32 id, len;

We need to initialize 'id'.

> +       int err, fd;
<...>
> +}
> +
> +void test_module_fentry_shadow(void)
> +{
<...>
> +
> +       btf_id[0] = btf__find_by_name(vmlinux_btf, symbol_name);
> +       if (!ASSERT_GT(btf_id[0], 0, "btf_find_by_name"))
> +               goto out;
> +
> +       btf_id[1] = btf__find_by_name(mod_btf, symbol_name);

btf__find_by_name_kind() may be better. It skips the name comparison
if the kind doesn't match.

> +       if (!ASSERT_GT(btf_id[1], 0, "btf_find_by_name"))
> +               goto out;
> +
<...>
> +       err = bpf_prog_test_run_opts(prog_fd[0], &test_opts);
> +       ASSERT_OK(err, "running test");
> +
> +out:

We also need to btf__free vmlinux_btf and mod_btf.

> +       for (i = 0; i < 2; i++) {
> +               if (btf_fd[i])
> +                       close(btf_fd[i]);
> +               if (prog_fd[i])
> +                       close(prog_fd[i]);
> +               if (link_fd[i])
> +                       close(link_fd[i]);
> +       }
> +}
> --
> 2.38.1
>
