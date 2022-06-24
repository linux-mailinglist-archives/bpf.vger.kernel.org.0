Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2583D55A408
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiFXV5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiFXV5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:57:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA22E87B7B
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:57:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fi2so7268480ejb.9
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyRHIF+jzXcIgcTf9GYEoyybl3TdnOutvLa+uemFk/4=;
        b=atbg5BecxThb/+iex+5QjL7cfBb+/Z65rtXGGw1B8OKpnvIRmwYkIyRw93uh+EMHRK
         A9O30VQHQ7bgFY+G1OU+4GwYZAwRS3gSg0xFo757c6JdDi/Q97TsZUT/ZEkNrrWfTC/H
         GJNJOwBjRZsGTgAQTFSM3RuWNz6wVmJrr0ejvKoFue8Oi6sr6qQQW8R3/479/0FXqT7h
         Zz16zyiV8Ojv0ppA4svUrZNwxrfljAjBfCEjUk/ZHZombwhwqTTrHtbozXUjqJv0jXvQ
         wWDKKxvz1mtMc6Rwtei/4dK24rmstYLB6IxJYTR5JYj+CLelsyaLkKtJA947RpNVgALu
         PPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyRHIF+jzXcIgcTf9GYEoyybl3TdnOutvLa+uemFk/4=;
        b=6tETE2IOTQ+/jcD8GNlLbyz1TsOwZh/J2hMspttL8NREIVW20qjuYsqO6NG8UeFfqk
         r5vUJR+HGDg6R6fp3oAN44RAHZ4tiSonggT6nCRkUmFNGHYgk47Q9IxWy2LklgwY0xwo
         +EuCXMLM2ioR1HHCaTQkaCx85ue8uUGAWWUNTdWTLpRX0RDkqgEteXPfFMfO2O852bsU
         wjukY20/plo+XiLlRAzG9tJXELL9jrXfSu2bYueO3pe3XHYShW4GIDzzfzekRuA9sKwW
         vhrSt1FUVkcbPPmSnziMupDUl3qcg0/U73vchhbgU4k2MKsonyivT2DAYJNK8eUM+6hk
         1DYg==
X-Gm-Message-State: AJIora/U4WfbK537cnG4KyA2JQ0DcwDoUF7xhd+Vj03C2rz6B77wPtPZ
        2/OwFFlh/6aS2W0Gx1eUBUZdLW9RwxY8KggLx58=
X-Google-Smtp-Source: AGRyM1vAcb0H6TvxuBNi7vj1g8b135YwL4R4l17Up8icTo3qfVPPm+FbNOg5sfpR19kJmNpdDSxskvTyjyvRW+defCU=
X-Received: by 2002:a17:906:a3ca:b0:726:2bd2:87bc with SMTP id
 ca10-20020a170906a3ca00b007262bd287bcmr1114780ejb.226.1656107847528; Fri, 24
 Jun 2022 14:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220624045636.3668195-1-kpsingh@kernel.org> <20220624045636.3668195-6-kpsingh@kernel.org>
In-Reply-To: <20220624045636.3668195-6-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 14:57:16 -0700
Message-ID: <CAEf4BzaoqOrk8Zb9gSYThiULYBVj8iS=RdnoBHHPxGK2EYxWtQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 5/5] bpf/selftests: Add a selftest for bpf_getxattr
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 23, 2022 at 9:56 PM KP Singh <kpsingh@kernel.org> wrote:
>
> A simple test that adds an xattr on a copied /bin/ls and reads it back
> when the copied ls is executed.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  .../testing/selftests/bpf/prog_tests/xattr.c  | 58 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/xattr.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xattr.c b/tools/testing/selftests/bpf/prog_tests/xattr.c
> new file mode 100644
> index 000000000000..442b6c1aed0e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xattr.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include <test_progs.h>
> +#include <sys/xattr.h>
> +#include "xattr.skel.h"
> +
> +#define XATTR_NAME "security.bpf"
> +#define XATTR_VALUE "test_progs"
> +
> +static unsigned int duration;
> +
> +void test_xattr(void)
> +{
> +       struct xattr *skel = NULL;
> +       char tmp_dir_path[] = "/tmp/xattrXXXXXX";
> +       char tmp_exec_path[64];
> +       char cmd[256];
> +       int err;
> +
> +       if (CHECK(!mkdtemp(tmp_dir_path), "mkdtemp",
> +                 "unable to create tmpdir: %d\n", errno))
> +               goto close_prog;
> +
> +       snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_ls",
> +                tmp_dir_path);
> +       snprintf(cmd, sizeof(cmd), "cp /bin/ls %s", tmp_exec_path);
> +       if (CHECK_FAIL(system(cmd)))
> +               goto close_prog_rmdir;
> +
> +       if (CHECK(setxattr(tmp_exec_path, XATTR_NAME, XATTR_VALUE,
> +                          sizeof(XATTR_VALUE), 0),

let's not use CHECK() and CHECK_FAIL() for new tests


> +                 "setxattr", "unable to setxattr: %d", errno))
> +               goto close_prog_rmdir;
> +
> +       skel = xattr__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_load"))
> +               goto close_prog_rmdir;
> +
> +       err = xattr__attach(skel);
> +       if (!ASSERT_OK(err, "xattr__attach failed"))
> +               goto close_prog_rmdir;
> +
> +       snprintf(cmd, sizeof(cmd), "%s -l", tmp_exec_path);
> +       if (CHECK_FAIL(system(cmd)))
> +               goto close_prog_rmdir;
> +
> +       ASSERT_EQ(skel->bss->result, 1, "xattr result");
> +
> +close_prog_rmdir:
> +       snprintf(cmd, sizeof(cmd), "rm -rf %s", tmp_dir_path);
> +       system(cmd);
> +close_prog:
> +       xattr__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/xattr.c b/tools/testing/selftests/bpf/progs/xattr.c
> new file mode 100644
> index 000000000000..ccc078fb8ebd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xattr.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define XATTR_NAME "security.bpf"
> +#define XATTR_VALUE "test_progs"
> +
> +__u64 result = 0;
> +
> +extern ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
> +                           const char *name, void *value, int size) __ksym;
> +
> +SEC("lsm.s/bprm_committed_creds")
> +void BPF_PROG(bprm_cc, struct linux_binprm *bprm)
> +{
> +       struct task_struct *current = bpf_get_current_task_btf();
> +       char dir_xattr_value[64] = {0};
> +       int xattr_sz = 0;
> +
> +       xattr_sz = bpf_getxattr(bprm->file->f_path.dentry,
> +                               bprm->file->f_path.dentry->d_inode, XATTR_NAME,
> +                               dir_xattr_value, 64);
> +
> +       if (xattr_sz <= 0)
> +               return;
> +
> +       if (!bpf_strncmp(dir_xattr_value, sizeof(XATTR_VALUE), XATTR_VALUE))
> +               result = 1;
> +}
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
