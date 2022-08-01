Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4874A587059
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiHASYK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiHASYJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:24:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB241EC64
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 11:24:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z187so1464601pfb.12
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=c2QP9U+s5NyWtOoN2m6jHC+yIGx9QSitvIls9InBwZc=;
        b=AsSLXqutgRWj68z4iwNAx+uxzWBtVn7qI1NgMLJg24ajlcyXoNdXE0gInZLgF7k0ad
         ji8xn6Q8qk7QVD91KeAqCMzFfAVoD88F7c3UGUZyIxiLM8cdpSMnaxje6EnGjdT4MxGf
         l/OwEA+Ip0FNfmZE6esSFEDEBvL6fM+e8uiO5AarbD57O/erb8fxc9VNJ6wjCtan0PYv
         3ZjyKhysuNfpxqh7bgU/YnSJsrEarcUFhAcw47GpMyjTWfMGD3kZTOZg46HGX//glZVD
         pvl+qsVPacHfOyUlKJvTP30StdURKbm+OMXlHZzH99AyJYNECP+xhgZW0GTkqMqEuV0b
         OvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=c2QP9U+s5NyWtOoN2m6jHC+yIGx9QSitvIls9InBwZc=;
        b=6i9F9P8NUUmrfqm1kftM6/JXv+DHOPIAmWfjrILwfYJfwUOZZueJ/izYHPE+vsuEDt
         5glJcBryXXmsKyNziBtPOCmwkcSyu4KyIi3kVH1UfmP64LRk8y0tELaffBe/ewy/TF7Q
         S2mPD+ph9nONddm2qTWCUicp00oWrMDlRFuRE5ENbBxfRqyI6jm01n2aolWZxU9Zrx/0
         8XHWCMl8cHUuTvO5nnVVp2hlJafQKP4TfSDx6TusVOIwKOpP830vnisjZmJfkEwva/GW
         QZPlCOkfC+x8Nr6kkh1noPhuEhzT3NaVWvOtM8CsaQ3yOo2ACItSIyKjKCzjq7XGlvLI
         zUFA==
X-Gm-Message-State: AJIora+gzWXy5JOn8FeHiAeEtPrDDNVcu+tfakN87oc+nk3+ps/3P8nY
        pZNMvAXZ9N8T5LLtMbHeDV8KXXgDZaAaiKBAQBBhgw==
X-Google-Smtp-Source: AGRyM1s63vP+3avmHnJuJLfDYJTMprFkd7eVKDUMeCSqKX6nPUTTmp2hpUPelx1Pz2S62CVt+kD6iHWle4O3eScLe8c=
X-Received: by 2002:aa7:8889:0:b0:52a:f05b:31f5 with SMTP id
 z9-20020aa78889000000b0052af05b31f5mr17374117pfe.69.1659378247779; Mon, 01
 Aug 2022 11:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220730000809.312891-1-sdf@google.com> <20220730000809.312891-2-sdf@google.com>
 <20220801174530.lcxhrvm6xtfjpxa7@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220801174530.lcxhrvm6xtfjpxa7@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 1 Aug 2022 11:23:56 -0700
Message-ID: <CAKH8qBv2mNxTKV=GzB1mmSq+pTRAFzZHAE=827ByrcLykV_WQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Excercise bpf_obj_get_info_by_fd
 for bpf2bpf
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
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

On Mon, Aug 1, 2022 at 10:45 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jul 29, 2022 at 05:08:09PM -0700, Stanislav Fomichev wrote:
> > Apparently, no existing selftest covers it. Add a new one where
> > we load cgroup/bind4 program and attach fentry to it.
> > Calling bpf_obj_get_info_by_fd on the fentry program
> > should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
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
> static

Will remove bpf_log_buf. Sent v2 too soon :-(

> > +
> > +static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> > +{
> > +     struct bpf_prog_info info = {};
> > +     __u32 info_len = sizeof(info);
> > +     struct btf *btf;
> > +     int err;
> > +
> > +     err = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
> > +     if (err)
> > +             return err;
> > +
> > +     if (!info.btf_id)
> > +             return -EINVAL;
> > +
> > +     btf = btf__load_from_kernel_by_id(info.btf_id);
> > +     err = libbpf_get_error(btf);
> > +     if (err)
> > +             return err;
> > +
> > +     err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> > +     btf__free(btf);
> > +     if (err <= 0)
> > +             return err;
> > +
> > +     return err;
> > +}
> > +
> > +int load_fentry(int attach_prog_fd, int attach_btf_id)
> static

Thx!

> > +{
> > +     LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > +                 .expected_attach_type = BPF_TRACE_FENTRY,
> > +                 .attach_prog_fd = attach_prog_fd,
> > +                 .attach_btf_id = attach_btf_id,
> > +                 .log_buf = bpf_log_buf,
> > +                 .log_size = sizeof(bpf_log_buf),
> > +     );
> > +     struct bpf_insn insns[] = {
> > +             BPF_MOV64_IMM(BPF_REG_0, 0),
> > +             BPF_EXIT_INSN(),
> > +     };
> > +     int ret;
> > +
> > +     ret = bpf_prog_load(BPF_PROG_TYPE_TRACING,
> > +                         "bind4_fentry",
> > +                         "GPL",
> > +                         insns,
> > +                         ARRAY_SIZE(insns),
> > +                         &opts);
> > +     if (ret)
> > +             printf("verifier log: %s\n", bpf_log_buf);
> If this fentry prog is in the attach_to_bpf.c and load by skel, this printf
> and the bpf_log_buf can go away.  I wonder if it can use the '?' like
> SEC("?cgroup/bind4") and SEC("?fentry").  Then opens attach_to_bpf.skel.h
> twice and use bpf_program__set_autoload() to load individual program .

Good ideal, let me try to see if doing "?fentry" is easier..
(unless we agree to keep load_fentry, see below)

> Another option could be to reuse the progs/bind4_prog.c and directly
> put the fentry program in the attach_to_bpf.c.
>
> btw, this test feels like something that could be a few line
> addition to the test_fexit_bpf2bpf_common() in fexit_bpf2bpf.c.
> Adding one to test fentry into a cgroup bpf prog is also good.
> No strong opinion here also.

I was trying to reuse fexit_bpf2bpf initially but I sank too much time
into it and decided that it might be easier to write a
simpler/separate reproducer instead :-(
How about we reuse progs/bind4_prog.c and keep load_fentry() ? And put
this new test in fexit_bpf2bpf.c ?
