Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05175222BB
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348239AbiEJRfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 13:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbiEJRfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 13:35:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD9D36173
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 10:31:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e24so24798713wrc.9
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMS92GaQ7hO3xy/t9fwXMiFHFCxyk1U0M9qobTgqVWk=;
        b=h3VopUxf73QReee+Ood03VkiuF8OW3nBBpEBiDDD0py+pMyj/vW7GIQqtIO7DJRIBT
         NXARG8s6OTS5/k+czyEq/i9by5gM3i7o74mJrheJDSh2Rqpl+GXp8qbP1MByVp0w8DpL
         sWUGdIOsA8iCWNTexFzgBCPcMMOxy6edvYJnoGFIWWfTmUyxZXhQ5UUxkEf0hr2pbExV
         47lqiC8B8atrPb04Rj5jbt4V1tgLg0LUHvrivxu33tE85VVyBnSG2J7d208dZMp+nT6x
         TZPagwo8JL3tkJjdQT0rW88UlYlbbSPMJw124SDMaOEFW4QzCR3641LxHnq/wwvayA4w
         AAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMS92GaQ7hO3xy/t9fwXMiFHFCxyk1U0M9qobTgqVWk=;
        b=4+2npol8Q40mFnSGWRVc4VDatXCozSofSADZ69htvr9JeXcj1PQT99RFmc7kAnjO60
         ldXEAh3HVsIxjtwxQrx33233XfZz0x2HLuBRxiV189keS2jASyanVtTjjQglMV8RNVj2
         1OqiLvaZI4pw8gpmcv0vMiD3utb4ntFqrFPrRaLksLEhPDYk4qf0Thv6qKIi7zTv8QSf
         8wiZeDHf35l//u+cDWFoz8ZZNW4yxuqFx1votTIH6ULkLGQqSGtCfATZGPjw28o4l9r4
         ezige9Azv5JQb9Mq/WAaFM6bkVzBDDG+r7DNp++59RnyxyyWi045n/BUCv7JNE4aww1k
         njMQ==
X-Gm-Message-State: AOAM5336OQE/fgsTBcxAa+ddZsxY8Oxvy6BlYXwDGjQp7MfGPznhA2qV
        GCG327JWWugBkearXLfKZ000VzehlboJBtt52T6hFA==
X-Google-Smtp-Source: ABdhPJzMoZQgpo+aZayZuRTimX/sAQryFjuKnc8OPfpsa/R/eOVislK2fcMnMdK/GTGkzvhimYsieSyeQKvdUFXiKPk=
X-Received: by 2002:a5d:5707:0:b0:20a:c768:bc8 with SMTP id
 a7-20020a5d5707000000b0020ac7680bc8mr19704783wrv.565.1652203871843; Tue, 10
 May 2022 10:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220429211540.715151-1-sdf@google.com> <20220429211540.715151-11-sdf@google.com>
 <CAEf4BzY3Nd2pi+O-x4bp41=joFgPXU2+UFqBusdjR08ME62k5g@mail.gmail.com>
 <CAKH8qBtk6CpR-29R6sWicz_zW=RCYUrXZqBZbgF9eqt4XGgNqQ@mail.gmail.com> <CAEf4BzZvVzHd9Sb=uH+614fq0wrht1wBAyG1zh6ZJg-_Qz0-rA@mail.gmail.com>
In-Reply-To: <CAEf4BzZvVzHd9Sb=uH+614fq0wrht1wBAyG1zh6ZJg-_Qz0-rA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 10 May 2022 10:31:00 -0700
Message-ID: <CAKH8qBv401RBdiouFD71JGZScG_oFD+3fUNav68JpzA=VWLkiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 10/10] selftests/bpf: verify lsm_cgroup struct
 sock access
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 9, 2022 at 4:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 9, 2022 at 4:38 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Mon, May 9, 2022 at 2:54 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Apr 29, 2022 at 2:16 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > > sk_priority & sk_mark are writable, the rest is readonly.
> > > >
> > > > Add new ldx_offset fixups to lookup the offset of struct field.
> > > > Allow using test.kfunc regardless of prog_type.
> > > >
> > > > One interesting thing here is that the verifier doesn't
> > > > really force me to add NULL checks anywhere :-/
> > > >
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/test_verifier.c   | 54 ++++++++++++++++++-
> > > >  .../selftests/bpf/verifier/lsm_cgroup.c       | 34 ++++++++++++
> > > >  2 files changed, 87 insertions(+), 1 deletion(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/verifier/lsm_cgroup.c
> > > >
> > >
> > > [...]
> > >
> > > > diff --git a/tools/testing/selftests/bpf/verifier/lsm_cgroup.c b/tools/testing/selftests/bpf/verifier/lsm_cgroup.c
> > > > new file mode 100644
> > > > index 000000000000..af0efe783511
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/verifier/lsm_cgroup.c
> > > > @@ -0,0 +1,34 @@
> > > > +#define SK_WRITABLE_FIELD(tp, field, size, res) \
> > > > +{ \
> > > > +       .descr = field, \
> > > > +       .insns = { \
> > > > +               /* r1 = *(u64 *)(r1 + 0) */ \
> > > > +               BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0), \
> > > > +               /* r1 = *(u64 *)(r1 + offsetof(struct socket, sk)) */ \
> > > > +               BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0), \
> > > > +               /* r2 = *(u64 *)(r1 + offsetof(struct sock, <field>)) */ \
> > > > +               BPF_LDX_MEM(size, BPF_REG_2, BPF_REG_1, 0), \
> > > > +               /* *(u64 *)(r1 + offsetof(struct sock, <field>)) = r2 */ \
> > > > +               BPF_STX_MEM(size, BPF_REG_1, BPF_REG_2, 0), \
> > > > +               BPF_MOV64_IMM(BPF_REG_0, 1), \
> > > > +               BPF_EXIT_INSN(), \
> > > > +       }, \
> > > > +       .result = res, \
> > > > +       .errstr = res ? "no write support to 'struct sock' at off" : "", \
> > > > +       .prog_type = BPF_PROG_TYPE_LSM, \
> > > > +       .expected_attach_type = BPF_LSM_CGROUP, \
> > > > +       .kfunc = "socket_post_create", \
> > > > +       .fixup_ldx = { \
> > > > +               { "socket", "sk", 1 }, \
> > > > +               { tp, field, 2 }, \
> > > > +               { tp, field, 3 }, \
> > > > +       }, \
> > > > +}
> > > > +
> > > > +SK_WRITABLE_FIELD("sock_common", "skc_family", BPF_H, REJECT),
> > > > +SK_WRITABLE_FIELD("sock", "sk_sndtimeo", BPF_DW, REJECT),
> > > > +SK_WRITABLE_FIELD("sock", "sk_priority", BPF_W, ACCEPT),
> > > > +SK_WRITABLE_FIELD("sock", "sk_mark", BPF_W, ACCEPT),
> > > > +SK_WRITABLE_FIELD("sock", "sk_pacing_rate", BPF_DW, REJECT),
> > > > +
> > >
> > > have you tried writing it as C program and adding the test to
> > > test_progs? Does something not work there?
> >
> > Seems like it should work, I don't see any issues with writing 5
> > programs to test each field.
> > But test_verified still feels like a better fit? Any reason in
> > particular you'd prefer test_progs over test_verifier?
>
> Adding that fixup_ldx->strct special handling didn't feel like the
> best fit, tbh. test_progs is generally much nicer to deal with in
> terms of CI and in terms of comprehending what's going on and
> supporting the code longer term.

This is not new, right? We already have a bunch of fixup_xxx things.
I can try to move this into test_progs in largely the same manner if
you prefer, having a C file per field seems like an overkill.
