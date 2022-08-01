Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E133587376
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 23:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiHAVoK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 17:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiHAVoJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 17:44:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BEC23170
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 14:44:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id uj29so9572612ejc.0
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=x96+BBwYSxlOs5TyKWPHiCHcsMiKKaVzG0biPjdmkPE=;
        b=fEQA2yJrtpATBHvQTF7VGucbOc4Q443jgfk2YAXVSAbWDYwP3PAJGvqOKzUh7KrD9J
         AcWOdxr59SyQnDrbFnWizSdPZ2ZBJ5PrXd3HdxqRBg0G4ud8LqwhjalK2AWUygNEeFog
         lZeqTD8f4amxKAkAwwloJOoc8h5WFvd9SYWKZbRL2gooU9Toj8KM0cjzRYOEAazQ3Oy/
         j+Q+j+CJTTVv8A2lxOhPuNadkh0YaORZa2beyxRh121q6kbzBzSTkwTAypUJlQcNjKOE
         CWFeTcaLUNCR9q2kn4SXvH65Rap2Uy7gY1J/czJUc11be1CbcRvmOVF0SSl2qmo4cs64
         Y5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=x96+BBwYSxlOs5TyKWPHiCHcsMiKKaVzG0biPjdmkPE=;
        b=il9VKLC0RcHEzcT8UvDX4KwuX+3Arzai6GZbInfGigSbjlybTPSpWwvIyKfTW0EEpS
         9wnmLcyR90NMGw+gdE7WbHRDSzNqedr0YjwUBC2pILSBDAVvTv9w82DVSikUiJwmYVyo
         kDiXUIhWEQPHkMVP45La1hT/xVe+sO10R8hBMisJpY9GG9CEE2kaBCsfO4z+ET1zYpVV
         upBIR+BsWz6pgcv5RTl9ONwy/6OABsuuESwWZ6KuhG53xJtFh+KjLNNqImzLZMAIKMlg
         3rUwW8G4LZJeu86XimcJI/GxkSmZJtO0MyXTq5JPTesK8Eb0KCP/q3zWaNBk/Cq220No
         q/Tw==
X-Gm-Message-State: AJIora+P+V/qPJwfnpg1EUG392LHawYvajCVZt4utHPOmjoh/RvFrvaG
        H0uHWIhLHbG/yOl09KTu1V9j7EJDx1Vkyndc2hY=
X-Google-Smtp-Source: AGRyM1sLsVwejXMnRh8Vz+lfIoEURvU78MwhtDyfTWckyx1tyTRUtUd0K32XI3r3JUQbZnG0Vh49+WF64DXgVq4JW2U=
X-Received: by 2002:a17:907:2808:b0:72b:4d49:b2e9 with SMTP id
 eb8-20020a170907280800b0072b4d49b2e9mr14485747ejc.176.1659390246680; Mon, 01
 Aug 2022 14:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220801173926.2441748-1-sdf@google.com> <20220801173926.2441748-2-sdf@google.com>
In-Reply-To: <20220801173926.2441748-2-sdf@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Aug 2022 14:43:55 -0700
Message-ID: <CAEf4BzYfSoxeFrf7t73tKSOMrH==6ZnvV1dLaWK9OakkQg7MpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Excercise
 bpf_obj_get_info_by_fd for bpf2bpf
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
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
> ---
>  .../selftests/bpf/prog_tests/attach_to_bpf.c  | 97 +++++++++++++++++++
>  .../selftests/bpf/progs/attach_to_bpf.c       | 12 +++
>  2 files changed, 109 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c
>

[...]

> +
> +       ret = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> +       btf__free(btf);
> +       return ret;
> +}
> +
> +int load_fentry(int attach_prog_fd, int attach_btf_id)

static?

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

you probably meant to check skel->links.bind4 instead of just skel
(which you already checked)

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

if (cgroup_fd >= 0)

> +       close(cgroup_fd);

if (fentry_fd >= 0)

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
