Return-Path: <bpf+bounces-8214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE778389D
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499A7280F96
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97351878;
	Tue, 22 Aug 2023 03:45:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC17F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 03:45:23 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00622186
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:45:21 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64f444fe7a7so6241296d6.0
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692675921; x=1693280721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZtoZCqGZTbWYLrI58wqNa+DFIqjRYy+yAkX2JcXJpE=;
        b=AGEsAnmYcZmWyhUOmUAIsUWzkdE+dMpHl9SpX8JrzeilBcV4FQeC2GihwjJwKFJN3U
         tdFjPE2EBf7aCP64froZlvFtX7GOav62qovt0MELEkjstV35Gnv2YutF2xSfnWSCO0jD
         opHV+6y3VXU0w+tlKT5RXcA0HQFs0SOXqtGNTDJu8K3OmQq9Qxe3FuqeaR8ODh4qk2Jm
         5G5q9xZ9Dergz9f4U4riGSSoaGzvh4TgOczcRjI2XDI39zXHzf64ZMfi5QCRX6rBGOMt
         9XjzE7PRq0wMUgsaa4FuXRR+b0wx63tAHqb8bpnNrPJmKkOLV57+8/vfdS7m8v1VLQP8
         QFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692675921; x=1693280721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZtoZCqGZTbWYLrI58wqNa+DFIqjRYy+yAkX2JcXJpE=;
        b=hFvYLuSE+esozyeTPCDI8ViNPtQ8S7KgiTz8OYJmTyUypDRgcOBhNtHAsTiiH5Vom3
         SXYh8LadoyLl1H6r5k7qWRRGIzmD18p7MCVutLIt7zGGKZPs/1aKJDC+HcU32l1wKZw+
         Dg47oRK5ec4w4FibzHrvRhXEKJCQCmTMN6xjB15nvjyloC+7vPCXszG5unT/WLXHPrmL
         nu1nLRTkTORmLbeXMtO697fUm/w9UPSLNN+vvSzOC8hltTtalEN5o32nvl48rX0jkdFq
         XqkI7MChsU+GNQkQN6Eawl7Y/RrqUUt/MyFcaJ2/8o6XhthIsvmrHtmkEhw4BqA43E1D
         yQYg==
X-Gm-Message-State: AOJu0Yz9VPZk73HzlWQcDc3Vx8bzew9JGti10o7QIze0jdRhzpezyjDW
	GeGedQKpYURlqKi69g+tdYTwMODHOWyFOVRiM/s=
X-Google-Smtp-Source: AGHT+IEFSWyT8iLJiOFd84oUnZEkKkWJw6t/nVxAiiiFy8rf0snIK5OJ0OAuqtKluf4Ugju+dmEu5yIRQ45vbimBAio=
X-Received: by 2002:a0c:8e83:0:b0:647:3346:1289 with SMTP id
 x3-20020a0c8e83000000b0064733461289mr10368300qvb.11.1692675921086; Mon, 21
 Aug 2023 20:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818083920.3771-1-laoar.shao@gmail.com> <20230818083920.3771-3-laoar.shao@gmail.com>
 <CAADnVQJ-BcSfPVL4J8DPA0XXgWtfUSXDzjnNeQvf1Z2SAASQ2g@mail.gmail.com>
 <CALOAHbDfYLnd7PwCdJ7LwP8eBNzPT8jttZZj3a0KMU32+LefXg@mail.gmail.com> <CAADnVQLcS16cs4AQ9tmOTwffU8W71=S_BQKSTnDN89xHhxVfsg@mail.gmail.com>
In-Reply-To: <CAADnVQLcS16cs4AQ9tmOTwffU8W71=S_BQKSTnDN89xHhxVfsg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 22 Aug 2023 11:44:45 +0800
Message-ID: <CALOAHbDC3LsNV-i7RG4C1ayPM5UrJL9E3kVTJdvi4KoMzHyZHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for allow_ptr_leaks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 11:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 21, 2023 at 7:43=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Tue, Aug 22, 2023 at 6:45=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Aug 18, 2023 at 1:39=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > - Without prev commit
> > > >
> > > >   $ tools/testing/selftests/bpf/test_progs --name=3Dtc_bpf
> > > >   #232/1   tc_bpf/tc_bpf_root:OK
> > > >   test_tc_bpf_non_root:PASS:set_cap_bpf_cap_net_admin 0 nsec
> > > >   test_tc_bpf_non_root:PASS:disable_cap_sys_admin 0 nsec
> > > >   0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > > >   ; if ((long)(iph + 1) > (long)skb->data_end)
> > > >   0: (61) r2 =3D *(u32 *)(r1 +80)         ; R1=3Dctx(off=3D0,imm=3D=
0) R2_w=3Dpkt_end(off=3D0,imm=3D0)
> > > >   ; struct iphdr *iph =3D (void *)(long)skb->data + sizeof(struct e=
thhdr);
> > > >   1: (61) r1 =3D *(u32 *)(r1 +76)         ; R1_w=3Dpkt(off=3D0,r=3D=
0,imm=3D0)
> > > >   ; if ((long)(iph + 1) > (long)skb->data_end)
> > > >   2: (07) r1 +=3D 34                      ; R1_w=3Dpkt(off=3D34,r=
=3D0,imm=3D0)
> > > >   3: (b4) w0 =3D 1                        ; R0_w=3D1
> > > >   4: (2d) if r1 > r2 goto pc+1
> > > >   R2 pointer comparison prohibited
> > > >   processed 5 insns (limit 1000000) max_states_per_insn 0 total_sta=
tes 0 peak_states 0 mark_read 0
> > > >   test_tc_bpf_non_root:FAIL:test_tc_bpf__open_and_load unexpected e=
rror: -13
> > > >   #233/2   tc_bpf_non_root:FAIL
> > > >
> > > > - With prev commit
> > > >
> > > >   $ tools/testing/selftests/bpf/test_progs --name=3Dtc_bpf
> > > >   #232/1   tc_bpf/tc_bpf_root:OK
> > > >   #232/2   tc_bpf/tc_bpf_non_root:OK
> > > >   #232     tc_bpf:OK
> > > >   Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/prog_tests/tc_bpf.c | 36 +++++++++++++=
+++++++++++-
> > > >  tools/testing/selftests/bpf/progs/test_tc_bpf.c | 14 ++++++++++
> > > >  2 files changed, 49 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c b/tool=
s/testing/selftests/bpf/prog_tests/tc_bpf.c
> > > > index e873766..48b5553 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/tc_bpf.c
> > > > @@ -3,6 +3,7 @@
> > > >  #include <test_progs.h>
> > > >  #include <linux/pkt_cls.h>
> > > >
> > > > +#include "cap_helpers.h"
> > > >  #include "test_tc_bpf.skel.h"
> > > >
> > > >  #define LO_IFINDEX 1
> > > > @@ -327,7 +328,7 @@ static int test_tc_bpf_api(struct bpf_tc_hook *=
hook, int fd)
> > > >         return 0;
> > > >  }
> > > >
> > > > -void test_tc_bpf(void)
> > > > +void tc_bpf_root(void)
> > > >  {
> > > >         DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex =3D LO_IFIN=
DEX,
> > > >                             .attach_point =3D BPF_TC_INGRESS);
> > > > @@ -393,3 +394,36 @@ void test_tc_bpf(void)
> > > >         }
> > > >         test_tc_bpf__destroy(skel);
> > > >  }
> > > > +
> > > > +void tc_bpf_non_root(void)
> > > > +{
> > > > +       struct test_tc_bpf *skel =3D NULL;
> > > > +       __u64 caps =3D 0;
> > > > +       int ret;
> > > > +
> > > > +       /* In case CAP_BPF and CAP_PERFMON is not set */
> > > > +       ret =3D cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_=
NET_ADMIN, &caps);
> > > > +       if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
> > > > +               return;
> > > > +       ret =3D cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL =
<< CAP_PERFMON, NULL);
> > > > +       if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
> > > > +               goto restore_cap;
> > > > +
> > > > +       skel =3D test_tc_bpf__open_and_load();
> > > > +       if (!ASSERT_OK_PTR(skel, "test_tc_bpf__open_and_load"))
> > > > +               goto restore_cap;
> > > > +
> > > > +       test_tc_bpf__destroy(skel);
> > > > +
> > > > +restore_cap:
> > > > +       if (caps)
> > > > +               cap_enable_effective(caps, NULL);
> > > > +}
> > > > +
> > > > +void test_tc_bpf(void)
> > > > +{
> > > > +       if (test__start_subtest("tc_bpf_root"))
> > > > +               tc_bpf_root();
> > > > +       if (test__start_subtest("tc_bpf_non_root"))
> > > > +               tc_bpf_non_root();
> > > > +}
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf.c b/tool=
s/testing/selftests/bpf/progs/test_tc_bpf.c
> > > > index d28ca8d..3e0f218 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> > > > @@ -1,5 +1,8 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > >
> > > > +#include <linux/pkt_cls.h>
> > > > +#include <linux/ip.h>
> > > > +#include <linux/if_ether.h>
> > >
> > > Due to above it fails to compile:
> > >
> > > In file included from progs/test_tc_bpf.c:4:
> > > In file included from /usr/include/linux/ip.h:21:
> > > In file included from /usr/include/asm/byteorder.h:5:
> > > In file included from /usr/include/linux/byteorder/little_endian.h:13=
:
> > > /usr/include/linux/swab.h:136:8: error: unknown type name '__always_i=
nline'
> > >   136 | static __always_inline unsigned long __swab(const unsigned lo=
ng y)
> > >       |        ^
> >
> > I can't find the above error log in the BPF CI log.
> > The BPF CI log just shows that it fails the test_map on s390 without
> > logs. Not sure why.
>
> It's not in CI. I caught it by manual build.
>
> > __always_inline is defined in bpf_helpers.h, so I think below
> > additional change could fix it.
> >
> > --- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> > @@ -1,10 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> >  #include <linux/pkt_cls.h>
> >  #include <linux/ip.h>
> >  #include <linux/if_ether.h>
> > -#include <linux/bpf.h>
> > -#include <bpf/bpf_helpers.h>
>
> Maybe, but I'd rather remove the includes and replace
> TC_ACT_STOLEN/ACT_OK with zeros, since the return values are
> irrelevant.

Good point. That could remove the "linux/pkt_cls.h".

--=20
Regards
Yafang

