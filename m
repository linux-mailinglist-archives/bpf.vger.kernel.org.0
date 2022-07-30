Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C465857A9
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 02:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiG3A4g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 20:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3A4f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 20:56:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C0804B2
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 17:56:33 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o1so4798331qkg.9
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 17:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KP9GE21Xvi3V4V6umQwQwNdXvcVTT76NegaLBNE0EO4=;
        b=L7RJPmvljgKfk7VcUdHoY/UpAHJm/nKhqdoPqWvPskGNYQ3YjDYoGW+MllhnT75PnI
         FxCA5MQ0xnI//67vQwz5auFpqe85IkNAn8iQVF7gzSLBdBcpUA3QPK0WjCpS79LRK2J+
         iu+7e0adIebTUY2w5or90rtSfakuQUxJuB/JrhMq+2ry1EwWI1ymvrMkbNl4bCDa4Qo9
         7ALP/FCtoZhO3zHnN2Si8/EpcQJdBKWcnDpAJoWil/p+1GFIkmyi7/1QOubio2BOqLbU
         iC6X8QnH2BVYK/z7wFRPN1mI4DgwyoaNtzJDlE0CJmHbxafWkx5IzBsR9fh1HJHCtjuP
         v9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KP9GE21Xvi3V4V6umQwQwNdXvcVTT76NegaLBNE0EO4=;
        b=xLT8Idb63Az+Kn25IcptalFUn5/QA6sTmEZkZsp077EuIPNoNGcqWy/I5zMniMi6BO
         BhRRwnp3ydHJhM8AvPtr26ksgoePXchdUFNF1ZZEidcR3e0uLPEV50689aayaRgJ281U
         VXDfYE1/2354yG26euGfXHsHSEqVws+n49qkZ3OBv9y++fz6EM5+/omo+i+bW3Y1HRRk
         aIp2OTlrwndOc+c2XcquWlRlM8jEr/adi9Dv+oRnLS4oWt5HibxI3vTz/jeAdCysE6/P
         xeD66MTYclNrTQvpnHHFWC0hJkELINUdzWq+zvZFQ/JxZQ7EpplyDZweMW9KaT+LdLa/
         mNzg==
X-Gm-Message-State: AJIora+LxOncu0SBvcWQftaRsH2+/zYXpBw7hIUK8059Wvgqc08SxEMp
        hBSgbxJlYT90DkhliJvN9ZpEAgHXHPLyWJv5LcWx7w==
X-Google-Smtp-Source: AGRyM1tCqUh1wVZzRnEsFlcSfPkv9+uWLxaPUcpBJ4N+EaNWveTP881MoM0CGSB0uZt6EjeykogEBV+VWKkN7s/jovc=
X-Received: by 2002:a05:620a:4590:b0:6b5:e884:2d2c with SMTP id
 bp16-20020a05620a459000b006b5e8842d2cmr4837865qkb.267.1659142592761; Fri, 29
 Jul 2022 17:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220730000809.312891-1-sdf@google.com> <20220730000809.312891-2-sdf@google.com>
In-Reply-To: <20220730000809.312891-2-sdf@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 29 Jul 2022 17:56:21 -0700
Message-ID: <CA+khW7gumsWLKjb4cR2nGwXhTZ2pd-foegRXNXBvCqFzKX-zNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Excercise bpf_obj_get_info_by_fd
 for bpf2bpf
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

On Fri, Jul 29, 2022 at 5:08 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Apparently, no existing selftest covers it. Add a new one where
> we load cgroup/bind4 program and attach fentry to it.
> Calling bpf_obj_get_info_by_fd on the fentry program
> should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---

Looks good to me overall, with a few nits.

>  .../selftests/bpf/prog_tests/attach_to_bpf.c  | 109 ++++++++++++++++++
>  .../selftests/bpf/progs/attach_to_bpf.c       |  12 ++
>  2 files changed, 121 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> new file mode 100644
> index 000000000000..fcf726c5ff0f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <bpf/btf.h>
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "attach_to_bpf.skel.h"
> +
> +char bpf_log_buf[BPF_LOG_BUF_SIZE];
> +
> +static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> +{
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
> +       struct btf *btf;
> +       int err;
> +
> +       err = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
> +       if (err)
> +               return err;
> +
> +       if (!info.btf_id)
> +               return -EINVAL;
> +
> +       btf = btf__load_from_kernel_by_id(info.btf_id);
> +       err = libbpf_get_error(btf);
> +       if (err)
> +               return err;
> +
> +       err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);

nit: Prefer use a separate variable like 'btf_id' instead of using 'err'.

> +       btf__free(btf);
> +       if (err <= 0)
> +               return err;
> +
> +       return err;
> +}
> +
> +int load_fentry(int attach_prog_fd, int attach_btf_id)
> +{
> +       LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +                   .expected_attach_type = BPF_TRACE_FENTRY,
> +                   .attach_prog_fd = attach_prog_fd,
> +                   .attach_btf_id = attach_btf_id,
> +                   .log_buf = bpf_log_buf,
> +                   .log_size = sizeof(bpf_log_buf),
> +       );
> +       struct bpf_insn insns[] = {
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       int ret;
> +
> +       ret = bpf_prog_load(BPF_PROG_TYPE_TRACING,
> +                           "bind4_fentry",
> +                           "GPL",
> +                           insns,
> +                           ARRAY_SIZE(insns),
> +                           &opts);
> +       if (ret)
> +               printf("verifier log: %s\n", bpf_log_buf);

Do we need to print log? If print logging isn't necessary, we could
directly return bpf_prog_load(). Seems simpler.

> +       return ret;
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
> +       if (!ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> +                      "bpf_obj_get_info_by_fd"))
> +               goto cleanup;
> +

Conditional checking may not be necessary. Just
ASSERT_OK(bpf_obj_get_info_by_fd(...)). Looks more compact.

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
