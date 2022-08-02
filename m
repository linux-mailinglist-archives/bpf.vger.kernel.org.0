Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC74F5881FA
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 20:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiHBSmf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 14:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHBSmf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 14:42:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF8E13F97
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 11:42:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dc19so4769969ejb.12
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4LSePZ/Qo0no+tRPFmplOaHiRsjmB/sZPI2qwfXOQGs=;
        b=UglB5mE3Iebwapo+NeCC167bUn2l7BZ6c1nRxKPw9VKKG1GrfBeAyrKK8GDmu2pUS/
         GvYTmzDndUcUnCo7xEmOdks4aPn9MMKjdz7SWAzCXtcXIk5AeGCefY8VB1YQT4MIaehf
         H/EPEi8KJVeV2BC5HpUDc4lnqBrhYfTDyHoQnLkZmapuc0F5FjIpdSOseD1tslVTlrEf
         OZHnEW4CIWii/SkZecmNcxMancNskp/Qrc2dMEwlPITEimdWe+fqEzpMwqTRdqgRmy+p
         8naAjRD9bN7wJKaExjJSmma2a1Mi3Tz4sfoVK9CiRGlbzRHDK9BDFyz7T6W4VGZYQGC9
         ppKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4LSePZ/Qo0no+tRPFmplOaHiRsjmB/sZPI2qwfXOQGs=;
        b=0Rd0x/Bol09SyXpeyA33RtdBqfOYXiziNeCDsbpHith7WJ0E5cNgEQqprRiAxNne7j
         h+NbgL8RqoZSG2G9ZjkLhpLKD08gohyK9A2SBdrmLvj3/j/4+P64bMQvU7kC0SZSWaoi
         a+XjyO95eqWUT29jQwqrYuDwZ8Lk3zXMA1Y+MDoZojmMx5x3M2wQgBi+Riw6FPKADg/r
         HJmFdZ0mn6+crN1UChCVx7/HTl5YWvRpoGkuO1T+a79pEbZ3S0h8ThKRAN2QLrCcAP+P
         anENSqvC1lsNXSelhtUp8sFkD+90UbKaR4qHT/dUI7WlKH9dvMs6DOHXntURqMeioKEx
         8ARg==
X-Gm-Message-State: ACgBeo1SNbGRLP1n7vmdof09nqzKE3HRFE+a3/MWtmLJfVFt76fN/03A
        N69mdYI3t+xx2LkNPBFtffDL18u0tImAnNhmPvY=
X-Google-Smtp-Source: AA6agR7vtZGGHh0/RWlD0wgDPeTXa9P/QT3894IzuvF034yPvi5G6mb/av72dNhiIMgk/BypM0B00+8bKAcrkyAIMTY=
X-Received: by 2002:a17:906:cc14:b0:730:6055:ad6d with SMTP id
 ml20-20020a170906cc1400b007306055ad6dmr11322266ejb.226.1659465752485; Tue, 02
 Aug 2022 11:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220801173926.2441748-1-sdf@google.com> <20220801173926.2441748-2-sdf@google.com>
 <CAEf4BzYfSoxeFrf7t73tKSOMrH==6ZnvV1dLaWK9OakkQg7MpA@mail.gmail.com> <CAKH8qBtiRtcicr4553k87s8YeJa_6qOz=-e9DCNwO9bfa2v35g@mail.gmail.com>
In-Reply-To: <CAKH8qBtiRtcicr4553k87s8YeJa_6qOz=-e9DCNwO9bfa2v35g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Aug 2022 11:42:21 -0700
Message-ID: <CAEf4BzZW_5RA1a=t0RhKCWtuts+HuZ4+rDnuEC46YvTSi+azAQ@mail.gmail.com>
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

On Tue, Aug 2, 2022 at 9:21 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Mon, Aug 1, 2022 at 2:44 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Aug 1, 2022 at 10:39 AM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > Apparently, no existing selftest covers it. Add a new one where
> > > we load cgroup/bind4 program and attach fentry to it.
> > > Calling bpf_obj_get_info_by_fd on the fentry program
> > > should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
> > >
> > > v2:
> > > - use ret instead of err in find_prog_btf_id (Hao)
> > > - remove verifier log (Hao)
> > > - drop if conditional from ASSERT_OK(bpf_obj_get_info_by_fd(...)) (Hao)
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/attach_to_bpf.c  | 97 +++++++++++++++++++
> > >  .../selftests/bpf/progs/attach_to_bpf.c       | 12 +++
> > >  2 files changed, 109 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c
> > >
> >
> > [...]
> >
> > > +
> > > +       ret = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> > > +       btf__free(btf);
> > > +       return ret;
> > > +}
> > > +
> > > +int load_fentry(int attach_prog_fd, int attach_btf_id)
> >
> > static?
> >
> > > +{
> > > +       LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > > +                   .expected_attach_type = BPF_TRACE_FENTRY,
> > > +                   .attach_prog_fd = attach_prog_fd,
> > > +                   .attach_btf_id = attach_btf_id,
> > > +       );
> > > +       struct bpf_insn insns[] = {
> > > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +               BPF_EXIT_INSN(),
> > > +       };
> > > +
> > > +       return bpf_prog_load(BPF_PROG_TYPE_TRACING,
> > > +                            "bind4_fentry",
> > > +                            "GPL",
> > > +                            insns,
> > > +                            ARRAY_SIZE(insns),
> > > +                            &opts);
> > > +}
> > > +
> > > +void test_attach_to_bpf(void)
> > > +{
> > > +       struct attach_to_bpf *skel = NULL;
> > > +       struct bpf_prog_info info = {};
> > > +       __u32 info_len = sizeof(info);
> > > +       int cgroup_fd = -1;
> > > +       int fentry_fd = -1;
> > > +       int btf_id;
> > > +
> > > +       cgroup_fd = test__join_cgroup("/attach_to_bpf");
> > > +       if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> > > +               return;
> > > +
> > > +       skel = attach_to_bpf__open_and_load();
> > > +       if (!ASSERT_OK_PTR(skel, "skel"))
> > > +               goto cleanup;
> > > +
> > > +       skel->links.bind4 = bpf_program__attach_cgroup(skel->progs.bind4, cgroup_fd);
> > > +       if (!ASSERT_OK_PTR(skel, "bpf_program__attach_cgroup"))
> >
> > you probably meant to check skel->links.bind4 instead of just skel
> > (which you already checked)
>
> Oh, good catch, thanks!
>
> > > +               goto cleanup;
> > > +
> > > +       btf_id = find_prog_btf_id("bind4", bpf_program__fd(skel->progs.bind4));
> > > +       if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
> > > +               goto cleanup;
> > > +
> > > +       fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind4), btf_id);
> > > +       if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
> > > +               goto cleanup;
> > > +
> > > +       /* Make sure bpf_obj_get_info_by_fd works correctly when attaching
> > > +        * to another BPF program.
> > > +        */
> > > +
> > > +       ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> > > +                 "bpf_obj_get_info_by_fd");
> > > +
> > > +       ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> > > +       ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> > > +       ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
> > > +
> > > +cleanup:
> >
> > if (cgroup_fd >= 0)
> >
> > > +       close(cgroup_fd);
> >
> > if (fentry_fd >= 0)
>
> Should be safe to do unconditional close(-1), right? Why bother with
> the checks here? Seems like a common pattern we do elsewhere?
>

I don't think we consciously do close(-1), libbpf definitely tries
hard to not attempt to close invalid fd, and so do (most?) of
selftests. Where do you see use doing close(-1)?

> > > +       close(fentry_fd);
> > > +       attach_to_bpf__destroy(skel);
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/attach_to_bpf.c b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
> > > new file mode 100644
> > > index 000000000000..3f111fe96f8f
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/attach_to_bpf.c
> > > @@ -0,0 +1,12 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +
> > > +SEC("cgroup/bind4")
> > > +int bind4(struct bpf_sock_addr *ctx)
> > > +{
> > > +       return 1;
> > > +}
> > > +
> > > +char _license[] SEC("license") = "GPL";
> > > --
> > > 2.37.1.455.g008518b4e5-goog
> > >
