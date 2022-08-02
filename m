Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A137558802A
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 18:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiHBQVx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiHBQVx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 12:21:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0501658D
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 09:21:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m2so7150074pls.4
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pKOcsocXhINaAbXetxmXvbVkYmdPMXHw+FWyN2C9W2E=;
        b=KSvLvgu7iX7BTeOmKizrHBsA4l9E7z1i7UUizJk89+DE9/CwmZBHzmCbrxRsVHa82r
         o70Pi++qkVUNSmNgGVs2i6q2q6hf/tc+Qe1SvCl5gOstYM5sVwveIQyDzAxZnFmaaP4J
         llORV8NmGXyXZKCur4D33vz0ipZ6CxNS/DrS3HrWn5nEG4WTe601G2teJ783SyDN8Po3
         yrcZGHFhYpqBiH9GUPBXHK7F9eyHd1/xSr4Ihfo1n+ZP3zzDgu2bNlgQDfLvkmSjOUpk
         Qf2yjjs/VWx20AT9wIBp/kgZaDDKJKnqu7M5py6G0g58KmXrJqvSW6IgTI7E7WFN5IIl
         /lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pKOcsocXhINaAbXetxmXvbVkYmdPMXHw+FWyN2C9W2E=;
        b=KbAhP5eL7DSVIuVc4cl5BwnkX99Lw2dMveQwIpMuXa01vvlCfoOCJujVIYZ95oU1TN
         8u05n3XU4z9Tcr4z//E2fK8xF5HSb06eKAKJiBLZ+thL0yc/C/OHD6ell8cr9MKsHpwF
         bx14adpD7D2NJ2VfgjSC0sgoKMw1RDqihsPF2XodQXpPMXlYDiB2wN4YfMuoPrBb0BFE
         ad2HAs+9oYkEG/2pIfF9z6yvSw+MHDMnyKAyXVI3qxxKHlaqDBA+KnE67KUs2iqReT0j
         ji0kIFptU5MMkiZT12AwWZpWw8dOgjownDoMQ0cLPNDGNoJ6PC22fKIs3QsckvsVcfye
         rwmA==
X-Gm-Message-State: ACgBeo1RJnjPfVtuJrOE7EO7bIORFnbv+CuOI7UCBfb2W/aAadz99krq
        qTXWUGBMQScmGkcbpL1aPB6FwNfwOIJQQNAGpCzKhQ==
X-Google-Smtp-Source: AA6agR5whJsRYuE/q+l5Zaga4Mun90fPFv+bU5xU2rTgEVrlOirPtkfrKmhjoc1b6mHJ4s6v+WDADsDHOoC5e9BPlXs=
X-Received: by 2002:a17:90b:3887:b0:1f2:bc1f:64d7 with SMTP id
 mu7-20020a17090b388700b001f2bc1f64d7mr253417pjb.31.1659457311044; Tue, 02 Aug
 2022 09:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220801173926.2441748-1-sdf@google.com> <20220801173926.2441748-2-sdf@google.com>
 <CAEf4BzYfSoxeFrf7t73tKSOMrH==6ZnvV1dLaWK9OakkQg7MpA@mail.gmail.com>
In-Reply-To: <CAEf4BzYfSoxeFrf7t73tKSOMrH==6ZnvV1dLaWK9OakkQg7MpA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 2 Aug 2022 09:21:39 -0700
Message-ID: <CAKH8qBtiRtcicr4553k87s8YeJa_6qOz=-e9DCNwO9bfa2v35g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Excercise
 bpf_obj_get_info_by_fd for bpf2bpf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Mon, Aug 1, 2022 at 2:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 1, 2022 at 10:39 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Apparently, no existing selftest covers it. Add a new one where
> > we load cgroup/bind4 program and attach fentry to it.
> > Calling bpf_obj_get_info_by_fd on the fentry program
> > should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
> >
> > v2:
> > - use ret instead of err in find_prog_btf_id (Hao)
> > - remove verifier log (Hao)
> > - drop if conditional from ASSERT_OK(bpf_obj_get_info_by_fd(...)) (Hao)
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  .../selftests/bpf/prog_tests/attach_to_bpf.c  | 97 +++++++++++++++++++
> >  .../selftests/bpf/progs/attach_to_bpf.c       | 12 +++
> >  2 files changed, 109 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c
> >
>
> [...]
>
> > +
> > +       ret = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> > +       btf__free(btf);
> > +       return ret;
> > +}
> > +
> > +int load_fentry(int attach_prog_fd, int attach_btf_id)
>
> static?
>
> > +{
> > +       LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > +                   .expected_attach_type = BPF_TRACE_FENTRY,
> > +                   .attach_prog_fd = attach_prog_fd,
> > +                   .attach_btf_id = attach_btf_id,
> > +       );
> > +       struct bpf_insn insns[] = {
> > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +
> > +       return bpf_prog_load(BPF_PROG_TYPE_TRACING,
> > +                            "bind4_fentry",
> > +                            "GPL",
> > +                            insns,
> > +                            ARRAY_SIZE(insns),
> > +                            &opts);
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
>
> you probably meant to check skel->links.bind4 instead of just skel
> (which you already checked)

Oh, good catch, thanks!

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
> > +       ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> > +                 "bpf_obj_get_info_by_fd");
> > +
> > +       ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> > +       ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> > +       ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
> > +
> > +cleanup:
>
> if (cgroup_fd >= 0)
>
> > +       close(cgroup_fd);
>
> if (fentry_fd >= 0)

Should be safe to do unconditional close(-1), right? Why bother with
the checks here? Seems like a common pattern we do elsewhere?

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
