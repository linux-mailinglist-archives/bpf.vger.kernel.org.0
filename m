Return-Path: <bpf+bounces-43364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0543A9B3FEC
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FAE1C2220C
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19882866;
	Tue, 29 Oct 2024 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrR8HIjg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7228E7;
	Tue, 29 Oct 2024 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730166014; cv=none; b=U1jHKJ+y0JE4DDFRkewv4qU8987pVfyWRgjU+sPbbxUE/AdrYAmuAP+S9uWCNj//68bJ/R9GDeh5h7LxsY4E6ot/6glj6GaOdPXgHKTPqMUDqUqJ8oROwNAgJ0/Qbi+62DTRoEKuV76aNXQrT777/JpX2epfUdnInmaQN4poJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730166014; c=relaxed/simple;
	bh=EZa56QTpekmalvcPy7N5pdIY3Ib4pGM0CfeCw0wTZxs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qGh0xkejWcMD9pKwb3e9k+Yx8pYPEGfUFr9M1rNkwRdMuZxntYxIpaPiYFIV2wxvXFEaux2ex7jokAql2/GfkeAakQuiwni0lwFZ7UGYlS9UyTr/PzXeXf4RuYgWIxzqZ1npSb4Ot0hLCG4AEnz1aVt3noA9AWito2BKwkMs3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrR8HIjg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460ace055d8so35239841cf.1;
        Mon, 28 Oct 2024 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730166011; x=1730770811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRuMNsAxF2+zDtgu01AMqWNiM820fSDyu+f3s5H9RWs=;
        b=MrR8HIjg9E3d8iXSVd/gYbHhhSpscL4c1+8vziQCzK7Bopd4MmbMWfPTfhIhe+NRCJ
         GzX7ha7DaQmtBHxX/tOeuxi1oTJbY/JMrh5X7bEMQU0CM/m6cYUp93gLXe2ayXKKVKUg
         91yElPpw1KMlTvdo5snWvGBgOiDB6bhHrwDm0r2XbuaMmZ/VqxJIK0T7XpvF9JtslWsh
         l1K77RNd1HFLN65hsEpq0ERqE+iC7DB9tLyRGuOst7E3s8dtZFc7Twi6UCqKCxEBhrMo
         wQM/liwk8Jgz85KT2JIOCOr1o67cNC6kh3G9kLaiBcVaUcCqw0zjOhgExKroVCAmg5W9
         AvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730166011; x=1730770811;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LRuMNsAxF2+zDtgu01AMqWNiM820fSDyu+f3s5H9RWs=;
        b=tJsxMMhpmL811dfzyHHpaKhcAlfmcW8uZ7grUaEeq2iOyd3+J45tzKx4oHoiPYff4k
         QcfS8DMzpt+Oh/eqY1OHziM6YmGjtNndCQiDLS1mFak5d8BeoS6r1rCyHzs0GMp8yTTQ
         jBcyyr0rPoCtZOWLjGz9SgOtvh/ETMtgZRIFmK0FxuPDwKJragSAVLHPnGPVSVdrNVf+
         tddKMAfv3a2v9g91MmsUHPS/fXJ/TL29buRLS/o8hhzW3NXbQX5wIBwGfa4fr50yG1O7
         QPUIdqFQ/549nLwLmi39U9cC9ywIIvSM8pgXdDzTKohY6hziuYlDNmdZQ9PRORNCNCfx
         4/oA==
X-Forwarded-Encrypted: i=1; AJvYcCWmqIjnQqdZkdlrts4EmFPyfBrwm1emqkFwCiH2VUE/94X/lmBReicrPfzgmG6/CvPqXu/TIagr@vger.kernel.org, AJvYcCWvXP1eNULdQsXqWc2f4bd3rB8DrFa8SNQBhGCcWPntpxLQFv/UDRl7W3d179AYiZxGtGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdBkMt5J7nfSAFnjCYsTvzlR2XI+g++6sUONK9Cry13iUOtaF
	QanlK0Jdt4b5RbIcJ+W1m5PAbb1XyEwwr9ti3kGFMuFb8U57tp6f
X-Google-Smtp-Source: AGHT+IFf/2pWFGoQahhq6EFKUx3umnwNZr+uXULmQ6X6QoMy0XwfD1Jjfi6TIZ8DS4owam8FQkRwLQ==
X-Received: by 2002:a05:622a:1984:b0:460:ae4b:ed02 with SMTP id d75a77b69052e-4613c006123mr132841711cf.16.1730166010863;
        Mon, 28 Oct 2024 18:40:10 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323790cbsm39938271cf.68.2024.10.28.18.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:40:10 -0700 (PDT)
Date: Mon, 28 Oct 2024 21:40:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67203cf9b9c11_2599232948a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC61L8Kq9uhgUNArawzZNfi4wH1CRWy42dLq9KVcJigHQ@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-15-kerneljasonxing@gmail.com>
 <672039e3cec10_24dce629448@willemb.c.googlers.com.notmuch>
 <CAL+tcoC61L8Kq9uhgUNArawzZNfi4wH1CRWy42dLq9KVcJigHQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 14/14] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Tue, Oct 29, 2024 at 9:27=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Only check if we pass those three key points after we enable the
> > > bpf extension for so_timestamping. During each point, we can choose=

> > > whether to print the current timestamp.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  .../bpf/prog_tests/so_timestamping.c          |  98 ++++++++++++++=

> > >  .../selftests/bpf/progs/so_timestamping.c     | 123 ++++++++++++++=
++++
> > >  2 files changed, 221 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/so_times=
tamping.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/so_timestampi=
ng.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping=
.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> > > new file mode 100644
> > > index 000000000000..dfb7588c246d
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> > > @@ -0,0 +1,98 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2024 Tencent */
> > > +
> > > +#define _GNU_SOURCE
> > > +#include <sched.h>
> > > +#include <linux/socket.h>
> > > +#include <linux/tls.h>
> > > +#include <net/if.h>
> > > +
> > > +#include "test_progs.h"
> > > +#include "cgroup_helpers.h"
> > > +#include "network_helpers.h"
> > > +
> > > +#include "so_timestamping.skel.h"
> > > +
> > > +#define CG_NAME "/so-timestamping-test"
> > > +
> > > +static const char addr4_str[] =3D "127.0.0.1";
> > > +static const char addr6_str[] =3D "::1";
> > > +static struct so_timestamping *skel;
> > > +static int cg_fd;
> > > +
> > > +static int create_netns(void)
> > > +{
> > > +     if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
> > > +             return -1;
> > > +
> > > +     if (!ASSERT_OK(system("ip link set dev lo up"), "set lo up"))=

> > > +             return -1;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void test_tcp(int family)
> > > +{
> > > +     struct so_timestamping__bss *bss =3D skel->bss;
> > > +     char buf[] =3D "testing testing";
> > > +     int sfd =3D -1, cfd =3D -1;
> > > +     int n;
> > > +
> > > +     memset(bss, 0, sizeof(*bss));
> > > +
> > > +     sfd =3D start_server(family, SOCK_STREAM,
> > > +                        family =3D=3D AF_INET6 ? addr6_str : addr4=
_str, 0, 0);
> > > +     if (!ASSERT_GE(sfd, 0, "start_server"))
> > > +             goto out;
> > > +
> > > +     cfd =3D connect_to_fd(sfd, 0);
> > > +     if (!ASSERT_GE(cfd, 0, "connect_to_fd_server")) {
> > > +             close(sfd);
> > > +             goto out;
> > > +     }
> > > +
> > > +     n =3D write(cfd, buf, sizeof(buf));
> > > +     if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
> > > +             goto out;
> > > +
> > > +     ASSERT_EQ(bss->nr_active, 1, "nr_active");
> > > +     ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
> > > +     ASSERT_EQ(bss->nr_sched, 1, "nr_sched");
> > > +     ASSERT_EQ(bss->nr_txsw, 1, "nr_txsw");
> > > +     ASSERT_EQ(bss->nr_ack, 1, "nr_ack");
> > > +
> > > +out:
> > > +     if (sfd >=3D 0)
> > > +             close(sfd);
> > > +     if (cfd >=3D 0)
> > > +             close(cfd);
> > > +}
> > > +
> > > +void test_so_timestamping(void)
> > > +{
> > > +     cg_fd =3D test__join_cgroup(CG_NAME);
> > > +     if (cg_fd < 0)
> > > +             return;
> > > +
> > > +     if (create_netns())
> > > +             goto done;
> > > +
> > > +     skel =3D so_timestamping__open();
> > > +     if (!ASSERT_OK_PTR(skel, "open skel"))
> > > +             goto done;
> > > +
> > > +     if (!ASSERT_OK(so_timestamping__load(skel), "load skel"))
> > > +             goto done;
> > > +
> > > +     skel->links.skops_sockopt =3D
> > > +             bpf_program__attach_cgroup(skel->progs.skops_sockopt,=
 cg_fd);
> > > +     if (!ASSERT_OK_PTR(skel->links.skops_sockopt, "attach cgroup"=
))
> > > +             goto done;
> > > +
> > > +     test_tcp(AF_INET6);
> > > +     test_tcp(AF_INET);
> > > +
> > > +done:
> > > +     so_timestamping__destroy(skel);
> > > +     close(cg_fd);
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/so_timestamping.c b/=
tools/testing/selftests/bpf/progs/so_timestamping.c
> > > new file mode 100644
> > > index 000000000000..a15317951786
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
> > > @@ -0,0 +1,123 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2024 Tencent */
> > > +
> > > +#include "vmlinux.h"
> > > +#include "bpf_tracing_net.h"
> > > +#include <bpf/bpf_core_read.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +#include "bpf_misc.h"
> > > +
> > > +#define SO_TIMESTAMPING 37
> > > +#define SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK (SOF_TIMESTAMPING_SOF=
TWARE | \
> > > +                                           SOF_TIMESTAMPING_TX_SCH=
ED | \
> > > +                                           SOF_TIMESTAMPING_TX_SOF=
TWARE | \
> > > +                                           SOF_TIMESTAMPING_TX_ACK=
 | \
> > > +                                           SOF_TIMESTAMPING_OPT_ID=
 | \
> > > +                                           SOF_TIMESTAMPING_OPT_ID=
_TCP)
> > > +
> > > +extern unsigned long CONFIG_HZ __kconfig;
> > > +
> > > +int nr_active;
> > > +int nr_passive;
> > > +int nr_sched;
> > > +int nr_txsw;
> > > +int nr_ack;
> > > +
> > > +struct sockopt_test {
> > > +     int opt;
> > > +     int new;
> > > +     int expected;
> > > +};
> > > +
> > > +static const struct sockopt_test sol_socket_tests[] =3D {
> > > +     { .opt =3D SO_TIMESTAMPING, .new =3D SOF_TIMESTAMPING_TX_SCHE=
D, .expected =3D 256, },
> > > +     { .opt =3D SO_TIMESTAMPING, .new =3D SOF_TIMESTAMPING_BPF_SUP=
PPORTED_MASK, .expected =3D 66450, },
> > > +     { .opt =3D 0, },
> > > +};
> > > +
> > > +struct loop_ctx {
> > > +     void *ctx;
> > > +     struct sock *sk;
> > > +};
> > > +
> > > +static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
> > > +                             const struct sockopt_test *t,
> > > +                             int level)
> > > +{
> > > +     int tmp, new, expected, opt;
> > > +
> > > +     opt =3D t->opt;
> > > +     new =3D t->new;
> > > +     expected =3D t->expected;
> > > +
> > > +     if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
> > > +             return 1;
> > > +     if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
> > > +         tmp !=3D expected)
> > > +             return 1;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int bpf_test_socket_sockopt(__u32 i, struct loop_ctx *lc)
> > > +{
> > > +     const struct sockopt_test *t;
> > > +
> > > +     if (i >=3D ARRAY_SIZE(sol_socket_tests))
> > > +             return 1;
> > > +
> > > +     t =3D &sol_socket_tests[i];
> > > +     if (!t->opt)
> > > +             return 1;
> > > +
> > > +     return bpf_test_sockopt_int(lc->ctx, lc->sk, t, SOL_SOCKET);
> > > +}
> > > +
> > > +static int bpf_test_sockopt(void *ctx, struct sock *sk)
> > > +{
> > > +     struct loop_ctx lc =3D { .ctx =3D ctx, .sk =3D sk, };
> > > +     int n;
> > > +
> > > +     n =3D bpf_loop(ARRAY_SIZE(sol_socket_tests), bpf_test_socket_=
sockopt, &lc, 0);
> > > +     if (n !=3D ARRAY_SIZE(sol_socket_tests))
> > > +             return -1;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +SEC("sockops")
> > > +int skops_sockopt(struct bpf_sock_ops *skops)
> > > +{
> > > +     struct bpf_sock *bpf_sk =3D skops->sk;
> > > +     struct sock *sk;
> > > +
> > > +     if (!bpf_sk)
> > > +             return 1;
> > > +
> > > +     sk =3D (struct sock *)bpf_skc_to_tcp_sock(bpf_sk);
> > > +     if (!sk)
> > > +             return 1;
> > > +
> > > +     switch (skops->op) {
> > > +     case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> > > +             nr_active +=3D !bpf_test_sockopt(skops, sk);
> > > +             break;
> > > +     case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> > > +             nr_passive +=3D !bpf_test_sockopt(skops, sk);
> > > +             break;
> > > +     case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> > > +             nr_sched +=3D 1;
> > > +             break;
> > > +     case BPF_SOCK_OPS_TS_SW_OPT_CB:
> > > +             nr_txsw +=3D 1;
> > > +             break;
> > > +     case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> > > +             nr_ack +=3D 1;
> > > +             break;
> >
> > Perhaps demonstrate what to do with the args on the new
> > TS_*_OPT_CB.
> =

> Roger that.
> =

> I would like to know if the current patch is too big to review? Should
> I split it into a few patches? But this series has 14 patches right
> now which could possibly exceed the maximum limit.

For a test patch, this looks fine to me. They often are a longer than
feature patches. But much of it is easy to grasp.=

