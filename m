Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025D2588529
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 02:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiHCAjQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 20:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHCAjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 20:39:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2110286CF
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 17:39:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so3151633ejc.10
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 17:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bL+FrfAIdiJqLWjUuenLt2c2xqL1LhZ2GVLzfjghkBQ=;
        b=ouJSZNefRl1fXNVcPFKRcCGO8xDygV2LipQOg7SVRiuvLWo2tD2HNlTNTFEIe5moCu
         F3unUl3V4AP+ADIIdB8k6gw3mYkYgphIcWogWeoC96PVFsD2APEWplByvJ1Bry1qaHyr
         pa1/2AXiYNsENHW+WoSeAq3eBeax+RpVhe5ls/GlnnjlLszTpnBgecDHlan5N3Bds5t/
         txtZaxrQDvt3ysn/Ewjx1LfshFWQe0X3NEpPGaA7QPrySSOFZx2GqDLn6X9SqnB3UeYt
         YOv6puJq7tggwDqmMUZFEz3rOIqMWnPErF+Ubgm8hLItb9sCsAz28NyazXb/dH3lVxmO
         +eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bL+FrfAIdiJqLWjUuenLt2c2xqL1LhZ2GVLzfjghkBQ=;
        b=VEaaZrmH1aK0Wl/rvm5rS85WfCxPmBjyMJoqViXZOJgxZWiP1QtP5B2gXm+6Nso21W
         lB59zkWg7GjEEXDDiNzcoCbKsAFxaCyFJlhB6bR+OpDgUrpLgPAmc9wEiXzOmxx5Pt2Y
         Z9BAyrmIvGREo6+As0a1vX1VMxDNHiAd2eANrcTxg/0qvXdE4W/UzkOXWCuQvENY+h6q
         1tZh2kcvGS0U165eFnIBBC11D4SNXkVbpt7ROHv3qmQOh+Ipv6KqncLsw7mCls7nxeiA
         XvlRJcpRkDBFPyMVQcWIg4s2gPUsWuAiMGjLJLzw/tZHuIBjsRweGw7CCvgmbO35uhSM
         UqKQ==
X-Gm-Message-State: AJIora8Dk08MPt+tA1u4Y9P2eHACuz2wQyD6Qfv+yut0geNiy0kyyY4k
        ExRqUeMCWUUxIho23rA+4spG/Q781PTd419kl74=
X-Google-Smtp-Source: AGRyM1sVbh1PdaGwDgLROZ16YOFvt2cBJg9adzbKDc8WGRS9g+DSaeJgnjI73Ra3NCG8RNgH5VvtKnq+uaJfHRhV78Q=
X-Received: by 2002:a17:907:2ccc:b0:72b:6907:fce6 with SMTP id
 hg12-20020a1709072ccc00b0072b6907fce6mr18397997ejc.115.1659487148298; Tue, 02
 Aug 2022 17:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220801173926.2441748-1-sdf@google.com> <20220801173926.2441748-2-sdf@google.com>
 <CAEf4BzYfSoxeFrf7t73tKSOMrH==6ZnvV1dLaWK9OakkQg7MpA@mail.gmail.com>
 <CAKH8qBtiRtcicr4553k87s8YeJa_6qOz=-e9DCNwO9bfa2v35g@mail.gmail.com>
 <CAEf4BzZW_5RA1a=t0RhKCWtuts+HuZ4+rDnuEC46YvTSi+azAQ@mail.gmail.com> <CAKH8qBtxfJr5B5_zsxJky-iM9o9OLCOetjwNmFVQ4LatgP494g@mail.gmail.com>
In-Reply-To: <CAKH8qBtxfJr5B5_zsxJky-iM9o9OLCOetjwNmFVQ4LatgP494g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Aug 2022 17:38:56 -0700
Message-ID: <CAEf4BzbuOxPvB_ZjXaz_SU5xGq24hdCbEgWA8Mw01qMm72m+kw@mail.gmail.com>
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

On Tue, Aug 2, 2022 at 1:53 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Tue, Aug 2, 2022 at 11:42 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 2, 2022 at 9:21 AM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > On Mon, Aug 1, 2022 at 2:44 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 1, 2022 at 10:39 AM Stanislav Fomichev <sdf@google.com> wrote:
> > > > >
> > > > > Apparently, no existing selftest covers it. Add a new one where
> > > > > we load cgroup/bind4 program and attach fentry to it.
> > > > > Calling bpf_obj_get_info_by_fd on the fentry program
> > > > > should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
> > > > >
> > > > > v2:
> > > > > - use ret instead of err in find_prog_btf_id (Hao)
> > > > > - remove verifier log (Hao)
> > > > > - drop if conditional from ASSERT_OK(bpf_obj_get_info_by_fd(...)) (Hao)
> > > > >
> > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > > ---
> > > > >  .../selftests/bpf/prog_tests/attach_to_bpf.c  | 97 +++++++++++++++++++
> > > > >  .../selftests/bpf/progs/attach_to_bpf.c       | 12 +++
> > > > >  2 files changed, 109 insertions(+)
> > > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> > > > >  create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > +
> > > > > +       ret = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> > > > > +       btf__free(btf);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +int load_fentry(int attach_prog_fd, int attach_btf_id)
> > > >
> > > > static?
> > > >
> > > > > +{
> > > > > +       LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > > > > +                   .expected_attach_type = BPF_TRACE_FENTRY,
> > > > > +                   .attach_prog_fd = attach_prog_fd,
> > > > > +                   .attach_btf_id = attach_btf_id,
> > > > > +       );
> > > > > +       struct bpf_insn insns[] = {
> > > > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > > > +               BPF_EXIT_INSN(),
> > > > > +       };
> > > > > +
> > > > > +       return bpf_prog_load(BPF_PROG_TYPE_TRACING,
> > > > > +                            "bind4_fentry",
> > > > > +                            "GPL",
> > > > > +                            insns,
> > > > > +                            ARRAY_SIZE(insns),
> > > > > +                            &opts);
> > > > > +}
> > > > > +
> > > > > +void test_attach_to_bpf(void)
> > > > > +{
> > > > > +       struct attach_to_bpf *skel = NULL;
> > > > > +       struct bpf_prog_info info = {};
> > > > > +       __u32 info_len = sizeof(info);
> > > > > +       int cgroup_fd = -1;
> > > > > +       int fentry_fd = -1;
> > > > > +       int btf_id;
> > > > > +
> > > > > +       cgroup_fd = test__join_cgroup("/attach_to_bpf");
> > > > > +       if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> > > > > +               return;
> > > > > +
> > > > > +       skel = attach_to_bpf__open_and_load();
> > > > > +       if (!ASSERT_OK_PTR(skel, "skel"))
> > > > > +               goto cleanup;
> > > > > +
> > > > > +       skel->links.bind4 = bpf_program__attach_cgroup(skel->progs.bind4, cgroup_fd);
> > > > > +       if (!ASSERT_OK_PTR(skel, "bpf_program__attach_cgroup"))
> > > >
> > > > you probably meant to check skel->links.bind4 instead of just skel
> > > > (which you already checked)
> > >
> > > Oh, good catch, thanks!
> > >
> > > > > +               goto cleanup;
> > > > > +
> > > > > +       btf_id = find_prog_btf_id("bind4", bpf_program__fd(skel->progs.bind4));
> > > > > +       if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
> > > > > +               goto cleanup;
> > > > > +
> > > > > +       fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind4), btf_id);
> > > > > +       if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
> > > > > +               goto cleanup;
> > > > > +
> > > > > +       /* Make sure bpf_obj_get_info_by_fd works correctly when attaching
> > > > > +        * to another BPF program.
> > > > > +        */
> > > > > +
> > > > > +       ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> > > > > +                 "bpf_obj_get_info_by_fd");
> > > > > +
> > > > > +       ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> > > > > +       ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> > > > > +       ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
> > > > > +
> > > > > +cleanup:
> > > >
> > > > if (cgroup_fd >= 0)
> > > >
> > > > > +       close(cgroup_fd);
> > > >
> > > > if (fentry_fd >= 0)
> > >
> > > Should be safe to do unconditional close(-1), right? Why bother with
> > > the checks here? Seems like a common pattern we do elsewhere?
> > >
> >
> > I don't think we consciously do close(-1), libbpf definitely tries
> > hard to not attempt to close invalid fd, and so do (most?) of
> > selftests. Where do you see use doing close(-1)?
>
> I might have contributed to this :-/ Everything is from prog_tests:
> sockopt_multi.c (test_sockopt_multi)
> lsm_cgroup.c (test_lsm_cgroup_functional)
>
> But there is more that haven't been added by me:
> d_path.c (trigger_fstat_events)
> cgroup_attach_override.c (serial_test_cgroup_attach_override)
> cg_storage_multi.c (connect_send)
> test_local_storage.c (test_test_local_storage)
> bpf_cookie.c (kprobe_multi_link_api_subtest)
> fexit_bpf2bpf.c (test_fentry_to_cgroup_bpf)
> (I stopped here, maybe there is more?)
>
> I'm not sure how much we should care about these 'if (fd >= 0)' checks.
> It might be it's easier to always do close(-1), otherwise we get bugs
> like the one in test_unpriv_bpf_disabled_positive from
> unpriv_bpf_disabled.c:
> if (link_fd)
>   close(link_fd);
>
> (but I'm also happy to add those 'ifs' if you prefer, lmk)
>
>
> ?

I'd rather have non-sloppy clean up sections.

>
>
>
> > > > > +       close(fentry_fd);
> > > > > +       attach_to_bpf__destroy(skel);
> > > > > +}
> > > > > diff --git a/tools/testing/selftests/bpf/progs/attach_to_bpf.c b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
> > > > > new file mode 100644
> > > > > index 000000000000..3f111fe96f8f
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
> > > > > @@ -0,0 +1,12 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +#include <linux/bpf.h>
> > > > > +#include <bpf/bpf_helpers.h>
> > > > > +
> > > > > +SEC("cgroup/bind4")
> > > > > +int bind4(struct bpf_sock_addr *ctx)
> > > > > +{
> > > > > +       return 1;
> > > > > +}
> > > > > +
> > > > > +char _license[] SEC("license") = "GPL";
> > > > > --
> > > > > 2.37.1.455.g008518b4e5-goog
> > > > >
