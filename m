Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870D369A2B9
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 00:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjBPXzj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 18:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPXzi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 18:55:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D1C26AC
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:55:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u21so9210538edv.3
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wFa0hjj8BygvQVJ29nIAjjl9oTu4U8CflDdN3zQh/wc=;
        b=XMgPNIjwZ368yFaJq7VNBTCuE1PZ4aXqKz0x6r28RjucNj4MT/ks6Q+pbSf1CYPM3O
         o30Oc9r+RL8GRzBhGd6IE7jGWE23F0PSAw9g+vsLNqMWmoeA79ul0hV2qBdO0dS6yp3m
         pUaAbevCIyEpWxv06GexAfvcFHTufpmoI9Wj+y66QFYKRtF7GEkxSAqk1N2e+quMlzqo
         3dt1FlLvEtfGZd0IPhCZjqgLn/UvhZr9eUQSm0dfns8xwzBrvDop+JmiQjA3N0sxnO3m
         wFiY1itAQH7c6byYxChAdW5c85sEFVNuL8ZH0vCsEtnaZ0mgP7E9XI+aXtgjcZJP/Fdc
         Gymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFa0hjj8BygvQVJ29nIAjjl9oTu4U8CflDdN3zQh/wc=;
        b=KMXUhWee3pOnifLE92XXK+T0Q5zgEA3wkm0nicNdQW1w4xT3tvCL5MAjIrdv9ZG4OJ
         5iOeLN99rG4CMVE+LdIUMAw6tHiMzLph1n28LAQOhXDUHyjkud47IHTMC5uJkZT13iSB
         CQ6AHRNO1o767WL79otwsJBOqGK4MYrT50h+hpRSQsUag5lqKu6QNFFsaB3QCZEdWXQb
         QL+/Pv9szJRWGjvXQE1JmSdfI3OZ7liZ7Btj4BZU6oOX2jsf0ktsjupZGCF5d7l0mF+W
         LsM8s/f0dqGaqPNRvetcQp12H/9dPaQ1sva3OC/v79rpwHZlsnj9yreDTByC3qwc0yUD
         MkBQ==
X-Gm-Message-State: AO0yUKW4xlO1Y7ICNs/6Cy+Prc7NxN0Hl0O4kt+SdqVI7PtHaNwe5uNW
        KZeTV47BqfudX39H7OPD2qYuzzls+XyOG9x016zOp+Hr
X-Google-Smtp-Source: AK7set9UCe8i5HztKRX1cS3tWbWIGdAOFBwWSXxfzXozWcFDBi2DCijDMpHEn1cIu6q6q0Yr+BwLSANcONSbT8uBqSY=
X-Received: by 2002:a17:906:c797:b0:8b0:fbd5:2145 with SMTP id
 cw23-20020a170906c79700b008b0fbd52145mr3604849ejb.15.1676591735683; Thu, 16
 Feb 2023 15:55:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676542796.git.vmalik@redhat.com> <aac6b35e509b494737bd20f0cdf656afd37f6b54.1676542796.git.vmalik@redhat.com>
In-Reply-To: <aac6b35e509b494737bd20f0cdf656afd37f6b54.1676542796.git.vmalik@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 15:55:23 -0800
Message-ID: <CAEf4BzZzVPggOQN+aWGvq8=ugcAS+uCyYXS-Knfjqe-2i3cZmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] bpf/selftests: Test fentry attachment to
 shadowed functions
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
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

On Thu, Feb 16, 2023 at 2:33 AM Viktor Malik <vmalik@redhat.com> wrote:
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
> trampoline address, hence trying to create two trampolines for a single
> address, which is forbidden.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  net/bpf/test_run.c                            |   5 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +
>  .../bpf/prog_tests/module_attach_shadow.c     | 131 ++++++++++++++++++
>  3 files changed, 142 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index b766a84c8536..7d46e8adbc96 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -558,6 +558,11 @@ long noinline bpf_kfunc_call_test4(signed char a, short b, int c, long d)
>         return (long)a + (long)b + (long)c + d;
>  }
>
> +int noinline bpf_fentry_shadow_test(int a)
> +{
> +       return a + 1;
> +}
> +
>  struct prog_test_member1 {
>         int a;
>  };
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 46500636d8cd..c478b14fdea1 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -229,6 +229,12 @@ static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
>         .set   = &bpf_testmod_check_kfunc_ids,
>  };
>
> +noinline int bpf_fentry_shadow_test(int a)
> +{
> +       return a + 2;
> +}
> +EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
> +
>  extern int bpf_fentry_test1(int a);
>
>  static int bpf_testmod_init(void)
> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
> new file mode 100644
> index 000000000000..a75d2cdde928
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
> @@ -0,0 +1,131 @@
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
> +static int get_bpf_testmod_btf_fd(void)
> +{
> +       struct bpf_btf_info info;
> +       char name[64];
> +       __u32 id = 0, len;
> +       int err, fd;
> +
> +       while (true) {
> +               err = bpf_btf_get_next_id(id, &id);
> +               if (err) {
> +                       log_err("failed to iterate BTF objects");
> +                       return err;
> +               }
> +
> +               fd = bpf_btf_get_fd_by_id(id);
> +               if (fd < 0) {
> +                       if (errno == ENOENT)
> +                               continue; /* expected race: BTF was unloaded */
> +                       err = -errno;
> +                       log_err("failed to get FD for BTF object #%d", id);
> +                       return err;
> +               }
> +
> +               len = sizeof(info);
> +               memset(&info, 0, sizeof(info));
> +               info.name = ptr_to_u64(name);
> +               info.name_len = sizeof(name);
> +
> +               err = bpf_obj_get_info_by_fd(fd, &info, &len);
> +               if (err) {
> +                       err = -errno;
> +                       log_err("failed to get info for BTF object #%d", id);
> +                       close(fd);
> +                       return err;
> +               }
> +
> +               if (strcmp(name, module_name) == 0)
> +                       return fd;
> +
> +               close(fd);
> +       }
> +       return -ENOENT;
> +}
> +
> +void test_module_fentry_shadow(void)
> +{
> +       struct btf *vmlinux_btf = NULL, *mod_btf = NULL;
> +       int err, i;
> +       int btf_fd[2] = {};
> +       int prog_fd[2] = {};
> +       int link_fd[2] = {};
> +       __s32 btf_id[2] = {};
> +
> +       const struct bpf_insn trace_program[] = {
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +
> +       LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
> +               .expected_attach_type = BPF_TRACE_FENTRY,
> +       );

nit: this is a variable declaration, so keep it together with other variables

> +
> +       LIBBPF_OPTS(bpf_test_run_opts, test_opts);
> +
> +       vmlinux_btf = btf__load_vmlinux_btf();
> +       if (!ASSERT_OK_PTR(vmlinux_btf, "load_vmlinux_btf"))
> +               return;
> +
> +       btf_fd[1] = get_bpf_testmod_btf_fd();
> +       if (!ASSERT_GT(btf_fd[1], 0, "get_bpf_testmod_btf_fd"))
> +               goto out;

it probably won't ever happen, by FD == 0 is a valid FD, so better not
make >0 assumption here?

> +
> +       mod_btf = btf_get_from_fd(btf_fd[1], vmlinux_btf);
> +       if (!ASSERT_OK_PTR(mod_btf, "btf_get_from_fd"))
> +               goto out;
> +
> +       btf_id[0] = btf__find_by_name_kind(vmlinux_btf, symbol_name, BTF_KIND_FUNC);
> +       if (!ASSERT_GT(btf_id[0], 0, "btf_find_by_name"))
> +               goto out;
> +
> +       btf_id[1] = btf__find_by_name_kind(mod_btf, symbol_name, BTF_KIND_FUNC);
> +       if (!ASSERT_GT(btf_id[1], 0, "btf_find_by_name"))
> +               goto out;
> +
> +       for (i = 0; i < 2; i++) {
> +               load_opts.attach_btf_id = btf_id[i];
> +               load_opts.attach_btf_obj_fd = btf_fd[i];
> +               prog_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
> +                                          trace_program,
> +                                          sizeof(trace_program) / sizeof(struct bpf_insn),
> +                                          &load_opts);
> +               if (!ASSERT_GE(prog_fd[i], 0, "bpf_prog_load"))
> +                       goto out;
> +
> +               // If the verifier incorrectly resolves addresses of the
> +               // shadowed functions and uses the same address for both the
> +               // vmlinux and the bpf_testmod functions, this will fail on
> +               // attempting to create two trampolines for the same address,
> +               // which is forbidden.

C++ style comments, please use /* */

> +               link_fd[i] = bpf_link_create(prog_fd[i], 0, BPF_TRACE_FENTRY, NULL);
> +               if (!ASSERT_GE(link_fd[i], 0, "bpf_link_create"))
> +                       goto out;
> +       }
> +
> +       err = bpf_prog_test_run_opts(prog_fd[0], &test_opts);

you don't need empty test_opts, just pass NULL

> +       ASSERT_OK(err, "running test");
> +
> +out:
> +       if (vmlinux_btf)
> +               btf__free(vmlinux_btf);
> +       if (mod_btf)
> +               btf__free(mod_btf);

no need to check for non-NULL, libbpf's destructors (btf__free being
one of them) always handles NULLs correctly

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
> 2.39.1
>
