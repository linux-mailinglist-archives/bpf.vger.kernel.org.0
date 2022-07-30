Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C75857EE
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 04:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiG3CRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 22:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiG3CRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 22:17:22 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03411286D0
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 19:17:21 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id b2so3097172vkg.2
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 19:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8tNP9LlZTVMzxDXSx2utXV95LpPNdoVBPljv9RPD+TE=;
        b=iRcZqtWUB5a3fDjG40U0XcLRoCHRg1ui2BQGJ4tlLbo8IKEhf3HzkKlc35oPC8F2Sz
         4tysvRtQwVOQIpq6zZEwmOwMK/NNOXfNxEcKI2gPh1wk/Z/fM6Y3p6U00wNy6uBSajdG
         Wzz7VecYAWckfZqS+YvLDtC4lCnbtwOT5b8n9kdT0XLHP6S/foAx0V80sHCsG02kF56k
         28E9OdeWGG2cckzi//Han+D7/i1u5Su+ARkkGRDo+Cx6N+zOLP37SW3hRaICBeH/WNjV
         63ZNnTSp2ioHOsagUKf5sS0wBgVUpGDslMzBNWREkUyThdUhgCwT1IA6zyEYihscjl+x
         6qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8tNP9LlZTVMzxDXSx2utXV95LpPNdoVBPljv9RPD+TE=;
        b=28jwESJpFOB/FnweJK6r8kSBSy2DMjMBjGsew8RlkNY2gR383tnW7zzbC48Y4CV2QB
         U1gwOX+MjS/kDdwMXu7nYCzcqM4v/E1btlE9F+PegMwm6GoDp0gwx0A11xhE3mPWg4wp
         NwL2TKiHbygpWvUKZCHG/4rYfMwLYgwQjkodTD+ZQ3hy7Php5NBKjhtTuLZyItV/Yjbd
         f/F5ZJTq3+h/Ld7xmqnFhhA3L+/Wptqwd9Bh00KVts/Xg2534hVDKkGFjKgt3DwRWMBH
         Pble81HnKODg5wYmWLl4cs5bZFIWStFAkX/W8SLxnStN9Td6sk3ra/1CmNsMLT1f3jDZ
         8SVQ==
X-Gm-Message-State: AJIora+Uh4q8kZJH+y+7Dwjwz77M7gSSkVvB4nY1bnSb2pyWsOe1EEtD
        S7or+dNsFLJSD9IkG6yJqo8A9uxdIV3oXjoFIyb0SEHGA78=
X-Google-Smtp-Source: AA6agR621DNQWTUNN9p9DtNk4b+E4AG019pm4RXV4xUqI6jqcdQeKAFnQTQl3/BCDX8zQQyona4MmND8WDatqHsdNT0=
X-Received: by 2002:a17:902:7005:b0:16d:bcca:443e with SMTP id
 y5-20020a170902700500b0016dbcca443emr6515150plk.73.1659147429731; Fri, 29 Jul
 2022 19:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220730000809.312891-1-sdf@google.com> <20220730000809.312891-2-sdf@google.com>
 <CA+khW7gumsWLKjb4cR2nGwXhTZ2pd-foegRXNXBvCqFzKX-zNw@mail.gmail.com>
In-Reply-To: <CA+khW7gumsWLKjb4cR2nGwXhTZ2pd-foegRXNXBvCqFzKX-zNw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 29 Jul 2022 19:16:58 -0700
Message-ID: <CAKH8qBum-ZiQkOd2uZu8VcJDnkV2B9YfefJEbz=e+xO4DYFBpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Excercise bpf_obj_get_info_by_fd
 for bpf2bpf
To:     Hao Luo <haoluo@google.com>
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

On Fri, Jul 29, 2022 at 5:56 PM Hao Luo <haoluo@google.com> wrote:
>
> On Fri, Jul 29, 2022 at 5:08 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Apparently, no existing selftest covers it. Add a new one where
> > we load cgroup/bind4 program and attach fentry to it.
> > Calling bpf_obj_get_info_by_fd on the fentry program
> > should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
>
> Looks good to me overall, with a few nits.

Thank you for the review! Will respin on Mon.

> >  .../selftests/bpf/prog_tests/attach_to_bpf.c  | 109 ++++++++++++++++++
> >  .../selftests/bpf/progs/attach_to_bpf.c       |  12 ++
> >  2 files changed, 121 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> > new file mode 100644
> > index 000000000000..fcf726c5ff0f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +#include <stdlib.h>
> > +#include <bpf/btf.h>
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +#include "attach_to_bpf.skel.h"
> > +
> > +char bpf_log_buf[BPF_LOG_BUF_SIZE];
> > +
> > +static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> > +{
> > +       struct bpf_prog_info info = {};
> > +       __u32 info_len = sizeof(info);
> > +       struct btf *btf;
> > +       int err;
> > +
> > +       err = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
> > +       if (err)
> > +               return err;
> > +
> > +       if (!info.btf_id)
> > +               return -EINVAL;
> > +
> > +       btf = btf__load_from_kernel_by_id(info.btf_id);
> > +       err = libbpf_get_error(btf);
> > +       if (err)
> > +               return err;
> > +
> > +       err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
>
> nit: Prefer use a separate variable like 'btf_id' instead of using 'err'.

SG!

> > +       btf__free(btf);
> > +       if (err <= 0)
> > +               return err;
> > +
> > +       return err;
> > +}
> > +
> > +int load_fentry(int attach_prog_fd, int attach_btf_id)
> > +{
> > +       LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > +                   .expected_attach_type = BPF_TRACE_FENTRY,
> > +                   .attach_prog_fd = attach_prog_fd,
> > +                   .attach_btf_id = attach_btf_id,
> > +                   .log_buf = bpf_log_buf,
> > +                   .log_size = sizeof(bpf_log_buf),
> > +       );
> > +       struct bpf_insn insns[] = {
> > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +       int ret;
> > +
> > +       ret = bpf_prog_load(BPF_PROG_TYPE_TRACING,
> > +                           "bind4_fentry",
> > +                           "GPL",
> > +                           insns,
> > +                           ARRAY_SIZE(insns),
> > +                           &opts);
> > +       if (ret)
> > +               printf("verifier log: %s\n", bpf_log_buf);
>
> Do we need to print log? If print logging isn't necessary, we could
> directly return bpf_prog_load(). Seems simpler.

We don't really need it. I've been using it during development, but I
guess it should be fine to drop since the test is passing now :-)

> > +       return ret;
> > +}
> > +
> > +void test_attach_to_bpf(void)
> > +{
> > +       struct attach_to_bpf *skel = NULL;
> > +       struct bpf_prog_info info = {};
> > +       __u32 info_len = sizeof(info);
> > +       int cgroup_fd = -1;
> > +       int fentry_fd = -1;
> > +       int btf_id;
> > +
> > +       cgroup_fd = test__join_cgroup("/attach_to_bpf");
> > +       if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> > +               return;
> > +
> > +       skel = attach_to_bpf__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "skel"))
> > +               goto cleanup;
> > +
> > +       skel->links.bind4 = bpf_program__attach_cgroup(skel->progs.bind4, cgroup_fd);
> > +       if (!ASSERT_OK_PTR(skel, "bpf_program__attach_cgroup"))
> > +               goto cleanup;
> > +
> > +       btf_id = find_prog_btf_id("bind4", bpf_program__fd(skel->progs.bind4));
> > +       if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
> > +               goto cleanup;
> > +
> > +       fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind4), btf_id);
> > +       if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
> > +               goto cleanup;
> > +
> > +       /* Make sure bpf_obj_get_info_by_fd works correctly when attaching
> > +        * to another BPF program.
> > +        */
> > +
> > +       if (!ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> > +                      "bpf_obj_get_info_by_fd"))
> > +               goto cleanup;
> > +
>
> Conditional checking may not be necessary. Just
> ASSERT_OK(bpf_obj_get_info_by_fd(...)). Looks more compact.

Ack, makes sense.

> > +       ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> > +       ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> > +       ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
> > +
> > +cleanup:
> > +       close(cgroup_fd);
> > +       close(fentry_fd);
> > +       attach_to_bpf__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/attach_to_bpf.c b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
> > new file mode 100644
> > index 000000000000..3f111fe96f8f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
> > @@ -0,0 +1,12 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +SEC("cgroup/bind4")
> > +int bind4(struct bpf_sock_addr *ctx)
> > +{
> > +       return 1;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > --
> > 2.37.1.455.g008518b4e5-goog
> >
