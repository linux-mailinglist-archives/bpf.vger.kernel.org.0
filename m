Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3B58717D
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 21:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiHATeG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 15:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiHATeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 15:34:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FB32AC79
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 12:34:01 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h22so8863022qta.3
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 12:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9kOVzob3NkeSsnaWNYRlnwRAQpxcWIHoMoj93hHF6g=;
        b=MaZugcFotMO5xNClYU99Yb7dwf16gGy87qiVPQ/Is55xfrQVF75sejbgYsMhT7ZwgP
         PRJfK4A6EaiifzqB+VnEqop+ow2P18KQQCbeJtfTJbvTfGiG1XmzoWmqysYLpD3Jp6TD
         2GiZJcWGOfPDQ1Yy58Dn7MMp6Y95/kWWSVMW+dUK3pYc9iJcZZtJdLHZ8YT+3rGKYPgB
         MXow8jXD+3Mg86mrgyJ0KaIymIeBxvMscWIY+9MY9MjeuuACXPAUNgpFUDG1i3A5Vhoa
         i7JbqNH91OF8n9N1mlwor8bUhLP3BylrOlEgOMcdHyNLjZsMpkpMaDfStTc+/VXuWuSQ
         TkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9kOVzob3NkeSsnaWNYRlnwRAQpxcWIHoMoj93hHF6g=;
        b=SsU9TINt2pqRI+gQDqedrukZKbrpTLwOe+gOVlZHfPeBUqRjBmhNIbUfZ5Ds8q+g0U
         Sdfy+YIAjLstXgHgWm2n2MsEFiUc2dEC59qHIwGdRqu2tfhOauE/k5pUVEz6JTANxDQX
         OwsBV8pddsXo5/jsBMdPka7ePYONDJrcz3AGSvd6A3Kb1tTirSR5QKDMm5AFhSRuws8q
         DHw7kfAe1rO+8tX+mpCrK0VnLH3xLdFGIKt/VxWrWww9E8Kpxs0bW8RXuYt7SNEW7U2d
         mI2x3Mz28ynF4Fw2pA2yY7QKqUC3QmuTv5JiOAtIaFSHdAivfIZl2MNjJByUi7a8K//p
         BNQg==
X-Gm-Message-State: AJIora8BHk5tuB5Pceo4T5YfROxz38Uc6X/ilmwihwGbxgMfQKpXo3ru
        d86R/wFPAbM006ajwN9QN0uVqJSum/SfCVNfTInchQ==
X-Google-Smtp-Source: AGRyM1uf7Hs3kEgfTppCGTzwKDydoAkk6DCYGC58k3fQZJuhPqiP/xETRNanurjDCKNawUuwrpSQRLZrZ0F+FcV7TFM=
X-Received: by 2002:a05:622a:4e:b0:31e:f84c:bf17 with SMTP id
 y14-20020a05622a004e00b0031ef84cbf17mr15506559qtw.566.1659382439765; Mon, 01
 Aug 2022 12:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220801173926.2441748-1-sdf@google.com> <20220801173926.2441748-2-sdf@google.com>
In-Reply-To: <20220801173926.2441748-2-sdf@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 1 Aug 2022 12:33:49 -0700
Message-ID: <CA+khW7hWwXc3vXJaXSUzhWEwBAsH0JdxK6SC-H4DOXw+PxuUgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Excercise
 bpf_obj_get_info_by_fd for bpf2bpf
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        jolsa@kernel.org
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

On Mon, Aug 1, 2022 at 10:39 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> Apparently, no existing selftest covers it. Add a new one where
> we load cgroup/bind4 program and attach fentry to it.
> Calling bpf_obj_get_info_by_fd on the fentry program
> should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
>
> v2:
> - use ret instead of err in find_prog_btf_id (Hao)
> - remove verifier log (Hao)
> - drop if conditional from ASSERT_OK(bpf_obj_get_info_by_fd(...)) (Hao)
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

I see Martin has comments based on v1, but v2 looks good to me.

Acked-by: Hao Luo <haoluo@google.com>

> ---
>  .../selftests/bpf/prog_tests/attach_to_bpf.c  | 97 +++++++++++++++++++
>  .../selftests/bpf/progs/attach_to_bpf.c       | 12 +++
>  2 files changed, 109 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> new file mode 100644
> index 000000000000..eb06f522c0b3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <bpf/btf.h>
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "attach_to_bpf.skel.h"
> +
> +static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> +{
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
> +       struct btf *btf;
> +       int ret;
> +
> +       ret = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
> +       if (ret)
> +               return ret;
> +
> +       if (!info.btf_id)
> +               return -EINVAL;
> +
> +       btf = btf__load_from_kernel_by_id(info.btf_id);
> +       ret = libbpf_get_error(btf);
> +       if (ret)
> +               return ret;
> +
> +       ret = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> +       btf__free(btf);
> +       return ret;
> +}
> +
> +int load_fentry(int attach_prog_fd, int attach_btf_id)
> +{
> +       LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +                   .expected_attach_type = BPF_TRACE_FENTRY,
> +                   .attach_prog_fd = attach_prog_fd,
> +                   .attach_btf_id = attach_btf_id,
> +       );
> +       struct bpf_insn insns[] = {
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +
> +       return bpf_prog_load(BPF_PROG_TYPE_TRACING,
> +                            "bind4_fentry",
> +                            "GPL",
> +                            insns,
> +                            ARRAY_SIZE(insns),
> +                            &opts);
> +}
> +
> +void test_attach_to_bpf(void)
> +{
> +       struct attach_to_bpf *skel = NULL;
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
> +       int cgroup_fd = -1;
> +       int fentry_fd = -1;
> +       int btf_id;
> +
> +       cgroup_fd = test__join_cgroup("/attach_to_bpf");
> +       if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> +               return;
> +
> +       skel = attach_to_bpf__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel"))
> +               goto cleanup;
> +
> +       skel->links.bind4 = bpf_program__attach_cgroup(skel->progs.bind4, cgroup_fd);
> +       if (!ASSERT_OK_PTR(skel, "bpf_program__attach_cgroup"))
> +               goto cleanup;
> +
> +       btf_id = find_prog_btf_id("bind4", bpf_program__fd(skel->progs.bind4));
> +       if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
> +               goto cleanup;
> +
> +       fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind4), btf_id);
> +       if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
> +               goto cleanup;
> +
> +       /* Make sure bpf_obj_get_info_by_fd works correctly when attaching
> +        * to another BPF program.
> +        */
> +
> +       ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> +                 "bpf_obj_get_info_by_fd");
> +
> +       ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> +       ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> +       ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
> +
> +cleanup:
> +       close(cgroup_fd);
> +       close(fentry_fd);
> +       attach_to_bpf__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/attach_to_bpf.c b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
> new file mode 100644
> index 000000000000..3f111fe96f8f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +SEC("cgroup/bind4")
> +int bind4(struct bpf_sock_addr *ctx)
> +{
> +       return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.37.1.455.g008518b4e5-goog
>
