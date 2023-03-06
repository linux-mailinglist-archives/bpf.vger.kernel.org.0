Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E408E6AB523
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 04:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCFDuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 22:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFDuW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 22:50:22 -0500
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A05C179;
        Sun,  5 Mar 2023 19:50:21 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-53cb9ac9470so160330527b3.10;
        Sun, 05 Mar 2023 19:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678074620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay4ex10vTu61kOz08JE0Hs5aH8GGI7PZ9K+bj2AVgqg=;
        b=Rbmyj5Rm/SQwLMnK445UsrjO2YG7l4PrhjYGwlvxVn5gv+iQw10Z8ynkVxOiY6x8kQ
         s4U6IgLDyfACIydNYY1m9p+UDu2VIhxlMMQD/tVF4D7Z7qRFEbeCfQmgg1dFXvnuHV7x
         dvoauG3cIOigzA40uriWPZx3EMnwxOActsDsbvHi+dg1YwxoH+A/vsdBBqTcz83E6zsX
         aRWfUiyq7d7iYE+smjSdHaceE3lEhk5vV/hBlUrkOJ9TR9pOu4ivpNkV2moIQQYWZ8Ts
         OMK+EMWpTPx69IcD6QmVElhab3OfAWBCjmoFNLEdl3gaWsvei2zh7uIz5AN+tZIf90n1
         5qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678074620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay4ex10vTu61kOz08JE0Hs5aH8GGI7PZ9K+bj2AVgqg=;
        b=Kx7zfOUJU3rSX5RkqzUzUOKJVCQoBY4NzA0DBDE0kjS2TlQWqOWQ7hhvH3yXrREO+o
         vjM/xomON7oDM5ttTUTc9C/u838r0ggO1ttApghmlhEk9mvByV6tz+46lCdrKDwgxgsN
         aPNxOU3q/ABrDUr+DMPW0K7pkqUhRb2BWOwfJppv+dFVO09lyt3rIfncGzVaPQAbqbbh
         pfBix2vRO46cQs7+cFB2AbEVUabuPAmIzDIxKxsgaYqBW6Ma9SkbFUb0cTtcSk0Blrzz
         mkX/kF3ceItfL7Qegh/Vbb+YxypWHkQ2oLFycoCMu8b6EGA4BiqhsiZurB/phespKN0b
         PpLA==
X-Gm-Message-State: AO0yUKUbcVTYTh/g+q17xjSNrBp66SRmxPCML/x0lnqrUdMc5IQhX5sp
        HIk54HuKAeKAtDuFqT0eqvVJeBV8SAbv/Mmj6uI=
X-Google-Smtp-Source: AK7set9Qai/m6cEMA8MPJWAnUEaemZDLqQbdJFAr+Uubn3rdZ/KjyPtdgvDvhL9qyX2IFi0khzbvVHRLtDQeWomuP94=
X-Received: by 2002:a81:b289:0:b0:53c:7095:595a with SMTP id
 q131-20020a81b289000000b0053c7095595amr5914591ywh.7.1678074620075; Sun, 05
 Mar 2023 19:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20230221025347.389047-1-imagedong@tencent.com>
 <20230221025347.389047-4-imagedong@tencent.com> <CAEf4BzbJoXsXRa_Rk+jOr+z6Q02FS2Jyp3wiJHGETrSGGE5DLg@mail.gmail.com>
In-Reply-To: <CAEf4BzbJoXsXRa_Rk+jOr+z6Q02FS2Jyp3wiJHGETrSGGE5DLg@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Mon, 6 Mar 2023 11:50:08 +0800
Message-ID: <CADxym3YanOVYB9XMJAzeky0kUOUmuLDVtnYROstTzRBqk0pTmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test for legacy/perf
 kprobe/uprobe attach mode
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        benbjiang@tencent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 5:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 20, 2023 at 6:54=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
> >
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Add the testing for kprobe/uprobe attaching in default, legacy, perf an=
d
> > link mode. And the testing passed:
> >
> > ./test_progs -t attach_probe
> > $5/1     attach_probe/manual-default:OK
> > $5/2     attach_probe/manual-legacy:OK
> > $5/3     attach_probe/manual-perf:OK
> > $5/4     attach_probe/manual-link:OK
> > $5/5     attach_probe/auto:OK
> > $5/6     attach_probe/kprobe-sleepable:OK
> > $5/7     attach_probe/uprobe-lib:OK
> > $5/8     attach_probe/uprobe-sleepable:OK
> > $5/9     attach_probe/uprobe-ref_ctr:OK
> > $5       attach_probe:OK
> > Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  .../selftests/bpf/prog_tests/attach_probe.c   | 54 ++++++++++++++-----
> >  .../selftests/bpf/progs/test_attach_probe.c   | 32 -----------
> >  .../bpf/progs/test_attach_probe_manual.c      | 53 ++++++++++++++++++
> >  3 files changed, 93 insertions(+), 46 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_attach_probe=
_manual.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/to=
ols/testing/selftests/bpf/prog_tests/attach_probe.c
> > index 8afd3e6066b8..e71cb44bf2e7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <test_progs.h>
> >  #include "test_attach_kprobe_sleepable.skel.h"
> > +#include "test_attach_probe_manual.skel.h"
> >  #include "test_attach_probe.skel.h"
> >
> >  /* this is how USDT semaphore is actually defined, except volatile mod=
ifier */
> > @@ -33,33 +34,48 @@ static noinline void trigger_func4(void)
> >  static char test_data[] =3D "test_data";
> >
> >  /* manual attach kprobe/kretprobe/uprobe/uretprobe testings */
> > -static void test_attach_probe_manual(struct test_attach_probe *skel)
> > +static void test_attach_probe_manual(enum probe_attach_mode attach_mod=
e)
> >  {
> >         DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> > +       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> >         struct bpf_link *kprobe_link, *kretprobe_link;
> >         struct bpf_link *uprobe_link, *uretprobe_link;
> > +       struct test_attach_probe_manual *skel;
> >         ssize_t uprobe_offset;
> >
> > +       skel =3D test_attach_probe_manual__open();
> > +       if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open"))
> > +               return;
> > +
> > +       if (!ASSERT_OK(test_attach_probe_manual__load(skel), "skel_manu=
al_load"))
> > +               goto cleanup;
>
> use test_attach_probe_manual__open_and_load() ?
>

Yeah, sounds nice!

> > +       if (!ASSERT_OK_PTR(skel->bss, "manual_check_bss"))
> > +               goto cleanup;
> > +
>
> no need to test this, lots of other tests validate this already, BPF
> skeleton has been validated many times over, no need to add this in
> new tests
>
> >         uprobe_offset =3D get_uprobe_offset(&trigger_func);
> >         if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
> > -               return;
> > +               goto cleanup;
>
> didn't you update all the `goto cleanup;` into `return;` in previous
> patch, and now updating it back to `goto cleanup;`? Maybe just keep an
> empty `cleanup:` label at the end to reduce churn?
>

OK!

Thanks!
Menglong Dong

> >
> >         /* manual-attach kprobe/kretprobe */
> > -       kprobe_link =3D bpf_program__attach_kprobe(skel->progs.handle_k=
probe,
> > -                                                false /* retprobe */,
> > -                                                SYS_NANOSLEEP_KPROBE_N=
AME);
> > +       kprobe_opts.attach_mode =3D attach_mode;
> > +       kprobe_opts.retprobe =3D false;
> > +       kprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.han=
dle_kprobe,
> > +                                                     SYS_NANOSLEEP_KPR=
OBE_NAME,
> > +                                                     &kprobe_opts);
> >         if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe"))
> > -               return;
> > +               goto cleanup;
> >         skel->links.handle_kprobe =3D kprobe_link;
> >
> > -       kretprobe_link =3D bpf_program__attach_kprobe(skel->progs.handl=
e_kretprobe,
> > -                                                   true /* retprobe */=
,
> > -                                                   SYS_NANOSLEEP_KPROB=
E_NAME);
> > +       kprobe_opts.retprobe =3D true;
> > +       kretprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.=
handle_kretprobe,
> > +                                                        SYS_NANOSLEEP_=
KPROBE_NAME,
> > +                                                        &kprobe_opts);
> >         if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe"))
> > -               return;
> > +               goto cleanup;
> >         skel->links.handle_kretprobe =3D kretprobe_link;
> >
> >         /* manual-attach uprobe/uretprobe */
> > +       uprobe_opts.attach_mode =3D attach_mode;
> >         uprobe_opts.ref_ctr_offset =3D 0;
> >         uprobe_opts.retprobe =3D false;
> >         uprobe_link =3D bpf_program__attach_uprobe_opts(skel->progs.han=
dle_uprobe,
>
> [...]
