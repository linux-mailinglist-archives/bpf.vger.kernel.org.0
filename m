Return-Path: <bpf+bounces-43363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170A9B3FD1
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253C41C21F9B
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468778C75;
	Tue, 29 Oct 2024 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxEnCUij"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC62D51C;
	Tue, 29 Oct 2024 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165634; cv=none; b=lLnkYc48gthRoSAyUeSwVxkYLiZlbfCkLr24+VBveF7+dQbpdY5cYDi1guRcdMefcC6wufylbK8lPkIYj4tUe7jYW46XbTmd0cOeIe14i/T8x/V9dkTj5/V8PJNKdtJtSXf014r0BuFwnxIYoTJbaNVgU8dSe2YKW1xZGC3LCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165634; c=relaxed/simple;
	bh=mx83EcXnPhD9sRj5KhC4mEqCkZFFyG0tpimAy2494OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTRWif1RRU3dzvc1HPWZpxyk+qPM0Uqv1aYVRxPWOhWkaFNo5xhEAkqE9vQuV3EkRZ+/SGKFd+hUtxgr0VuLhvBMjdGNesWQpR8WKcWYpgI5Lo208d8/UUmRLN8UZLhRE77tvrY7Zz/OW4/M3oymu9iCmKZ8eXc/Ys0nURugY2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxEnCUij; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a5075ed279so3262945ab.0;
        Mon, 28 Oct 2024 18:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730165631; x=1730770431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYVGXUOiAMhl1SfiwviRNdfuWDiTB3srlC1L+Iddu7Q=;
        b=BxEnCUijOY54n+lMArldFGjD3KqQDkGPcwC4H4MEPMxZGPFxeKtGrL0PTojDAIxRGi
         TkW+rZPJyc1hetCfYVlUfqcck2tGGkcDs6lwbhifTBkCHCV75w4YnaYoHCzOtaplZauk
         aNyCHIsdzL+liYYTDp9JKgATPtprIJCGxH8qEgWeuMyu+WYQJOqLOM1B1fd2HpbydpuZ
         BkBNo306Mnt0wXCUylOxgrLeMR4ahPpyJPVF1z5HBoMkVb3Y1rmpw2DqvvmxkDs0xPjK
         0DS9ve+4jAGoiW2vKCwkY5B9dqSvyNkM6DseWolnE6CVNwu421iU2sKtxeaSzSpKo0pR
         jh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730165631; x=1730770431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYVGXUOiAMhl1SfiwviRNdfuWDiTB3srlC1L+Iddu7Q=;
        b=EBwfNxJA0CrzDlfoELalGX/2gHIqVCKcjwLkRB8X6H3wk9fC+aW642PUqwAyysKpkT
         /WUB9E2gu/Y8WTYYBCS4E8LBva8PJfxEptwKH8e0J42KkWpWsgQi6m0vm0mfcpMooVzj
         ZXVKt/9PsWWBDFTRH4ASARxFFf/hvpZcQU6N4ynWVmq7Qly9QCsR4e+DH8Rhen8dsyev
         kp/mpZwtRwajDyrHOL6Vk1f2nC5HUVX/H8cpKvJ5WKyvpMtWJ9N3f5yNFjpMZLcmpWtd
         mUCn79+kYTwsKOJaijBWl+1pyzhtr+nd//4WKMf4yfMM7r0XTmUXbMKxjPPtw95gpM3+
         jvIg==
X-Forwarded-Encrypted: i=1; AJvYcCU5GpWNXxt9i0A7LAE5dPDhDVipZi8AXT2Rf5rSOMv84YGhS358VTvcx8GItzVZD3yFDTmwPRn5@vger.kernel.org, AJvYcCXN0TexwuDcGRR0arxIjGxEJWNm6QZ379Q+rlhxzm/Zgexd/CP9lq98MgrvC3cp0dIisyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hfijICl0EKMyMYseaElQVsRKJ9Cify7VHhgqbzSXRsfuN7t0
	icxR02M6VFX+BhjpVLWqQy1HhHtH3PE97iTpho9HoEtBLnfcrdrGNy2t7F6wLBa9Sbkwz8E8Ti2
	H6ghfrAL35tjpApKrKCiiOzwdgNo=
X-Google-Smtp-Source: AGHT+IHnTyHjyKhOIlmcrZdULblZS6O5GEmfuhDOoFblx5FdbHIj/LhbLZSdnGksLKr3qfXtsVKYfnvHc4pP6LLwiXg=
X-Received: by 2002:a05:6e02:1c26:b0:3a3:4175:79d2 with SMTP id
 e9e14a558f8ab-3a4ed2badbbmr99355825ab.14.1730165630709; Mon, 28 Oct 2024
 18:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-15-kerneljasonxing@gmail.com> <672039e3cec10_24dce629448@willemb.c.googlers.com.notmuch>
In-Reply-To: <672039e3cec10_24dce629448@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 09:33:14 +0800
Message-ID: <CAL+tcoC61L8Kq9uhgUNArawzZNfi4wH1CRWy42dLq9KVcJigHQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 14/14] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:27=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Only check if we pass those three key points after we enable the
> > bpf extension for so_timestamping. During each point, we can choose
> > whether to print the current timestamp.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  .../bpf/prog_tests/so_timestamping.c          |  98 ++++++++++++++
> >  .../selftests/bpf/progs/so_timestamping.c     | 123 ++++++++++++++++++
> >  2 files changed, 221 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamp=
ing.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b=
/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> > new file mode 100644
> > index 000000000000..dfb7588c246d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Tencent */
> > +
> > +#define _GNU_SOURCE
> > +#include <sched.h>
> > +#include <linux/socket.h>
> > +#include <linux/tls.h>
> > +#include <net/if.h>
> > +
> > +#include "test_progs.h"
> > +#include "cgroup_helpers.h"
> > +#include "network_helpers.h"
> > +
> > +#include "so_timestamping.skel.h"
> > +
> > +#define CG_NAME "/so-timestamping-test"
> > +
> > +static const char addr4_str[] =3D "127.0.0.1";
> > +static const char addr6_str[] =3D "::1";
> > +static struct so_timestamping *skel;
> > +static int cg_fd;
> > +
> > +static int create_netns(void)
> > +{
> > +     if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
> > +             return -1;
> > +
> > +     if (!ASSERT_OK(system("ip link set dev lo up"), "set lo up"))
> > +             return -1;
> > +
> > +     return 0;
> > +}
> > +
> > +static void test_tcp(int family)
> > +{
> > +     struct so_timestamping__bss *bss =3D skel->bss;
> > +     char buf[] =3D "testing testing";
> > +     int sfd =3D -1, cfd =3D -1;
> > +     int n;
> > +
> > +     memset(bss, 0, sizeof(*bss));
> > +
> > +     sfd =3D start_server(family, SOCK_STREAM,
> > +                        family =3D=3D AF_INET6 ? addr6_str : addr4_str=
, 0, 0);
> > +     if (!ASSERT_GE(sfd, 0, "start_server"))
> > +             goto out;
> > +
> > +     cfd =3D connect_to_fd(sfd, 0);
> > +     if (!ASSERT_GE(cfd, 0, "connect_to_fd_server")) {
> > +             close(sfd);
> > +             goto out;
> > +     }
> > +
> > +     n =3D write(cfd, buf, sizeof(buf));
> > +     if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
> > +             goto out;
> > +
> > +     ASSERT_EQ(bss->nr_active, 1, "nr_active");
> > +     ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
> > +     ASSERT_EQ(bss->nr_sched, 1, "nr_sched");
> > +     ASSERT_EQ(bss->nr_txsw, 1, "nr_txsw");
> > +     ASSERT_EQ(bss->nr_ack, 1, "nr_ack");
> > +
> > +out:
> > +     if (sfd >=3D 0)
> > +             close(sfd);
> > +     if (cfd >=3D 0)
> > +             close(cfd);
> > +}
> > +
> > +void test_so_timestamping(void)
> > +{
> > +     cg_fd =3D test__join_cgroup(CG_NAME);
> > +     if (cg_fd < 0)
> > +             return;
> > +
> > +     if (create_netns())
> > +             goto done;
> > +
> > +     skel =3D so_timestamping__open();
> > +     if (!ASSERT_OK_PTR(skel, "open skel"))
> > +             goto done;
> > +
> > +     if (!ASSERT_OK(so_timestamping__load(skel), "load skel"))
> > +             goto done;
> > +
> > +     skel->links.skops_sockopt =3D
> > +             bpf_program__attach_cgroup(skel->progs.skops_sockopt, cg_=
fd);
> > +     if (!ASSERT_OK_PTR(skel->links.skops_sockopt, "attach cgroup"))
> > +             goto done;
> > +
> > +     test_tcp(AF_INET6);
> > +     test_tcp(AF_INET);
> > +
> > +done:
> > +     so_timestamping__destroy(skel);
> > +     close(cg_fd);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/so_timestamping.c b/tool=
s/testing/selftests/bpf/progs/so_timestamping.c
> > new file mode 100644
> > index 000000000000..a15317951786
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
> > @@ -0,0 +1,123 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Tencent */
> > +
> > +#include "vmlinux.h"
> > +#include "bpf_tracing_net.h"
> > +#include <bpf/bpf_core_read.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "bpf_misc.h"
> > +
> > +#define SO_TIMESTAMPING 37
> > +#define SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK (SOF_TIMESTAMPING_SOFTWAR=
E | \
> > +                                           SOF_TIMESTAMPING_TX_SCHED |=
 \
> > +                                           SOF_TIMESTAMPING_TX_SOFTWAR=
E | \
> > +                                           SOF_TIMESTAMPING_TX_ACK | \
> > +                                           SOF_TIMESTAMPING_OPT_ID | \
> > +                                           SOF_TIMESTAMPING_OPT_ID_TCP=
)
> > +
> > +extern unsigned long CONFIG_HZ __kconfig;
> > +
> > +int nr_active;
> > +int nr_passive;
> > +int nr_sched;
> > +int nr_txsw;
> > +int nr_ack;
> > +
> > +struct sockopt_test {
> > +     int opt;
> > +     int new;
> > +     int expected;
> > +};
> > +
> > +static const struct sockopt_test sol_socket_tests[] =3D {
> > +     { .opt =3D SO_TIMESTAMPING, .new =3D SOF_TIMESTAMPING_TX_SCHED, .=
expected =3D 256, },
> > +     { .opt =3D SO_TIMESTAMPING, .new =3D SOF_TIMESTAMPING_BPF_SUPPPOR=
TED_MASK, .expected =3D 66450, },
> > +     { .opt =3D 0, },
> > +};
> > +
> > +struct loop_ctx {
> > +     void *ctx;
> > +     struct sock *sk;
> > +};
> > +
> > +static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
> > +                             const struct sockopt_test *t,
> > +                             int level)
> > +{
> > +     int tmp, new, expected, opt;
> > +
> > +     opt =3D t->opt;
> > +     new =3D t->new;
> > +     expected =3D t->expected;
> > +
> > +     if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
> > +             return 1;
> > +     if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
> > +         tmp !=3D expected)
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int bpf_test_socket_sockopt(__u32 i, struct loop_ctx *lc)
> > +{
> > +     const struct sockopt_test *t;
> > +
> > +     if (i >=3D ARRAY_SIZE(sol_socket_tests))
> > +             return 1;
> > +
> > +     t =3D &sol_socket_tests[i];
> > +     if (!t->opt)
> > +             return 1;
> > +
> > +     return bpf_test_sockopt_int(lc->ctx, lc->sk, t, SOL_SOCKET);
> > +}
> > +
> > +static int bpf_test_sockopt(void *ctx, struct sock *sk)
> > +{
> > +     struct loop_ctx lc =3D { .ctx =3D ctx, .sk =3D sk, };
> > +     int n;
> > +
> > +     n =3D bpf_loop(ARRAY_SIZE(sol_socket_tests), bpf_test_socket_sock=
opt, &lc, 0);
> > +     if (n !=3D ARRAY_SIZE(sol_socket_tests))
> > +             return -1;
> > +
> > +     return 0;
> > +}
> > +
> > +SEC("sockops")
> > +int skops_sockopt(struct bpf_sock_ops *skops)
> > +{
> > +     struct bpf_sock *bpf_sk =3D skops->sk;
> > +     struct sock *sk;
> > +
> > +     if (!bpf_sk)
> > +             return 1;
> > +
> > +     sk =3D (struct sock *)bpf_skc_to_tcp_sock(bpf_sk);
> > +     if (!sk)
> > +             return 1;
> > +
> > +     switch (skops->op) {
> > +     case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> > +             nr_active +=3D !bpf_test_sockopt(skops, sk);
> > +             break;
> > +     case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> > +             nr_passive +=3D !bpf_test_sockopt(skops, sk);
> > +             break;
> > +     case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> > +             nr_sched +=3D 1;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_SW_OPT_CB:
> > +             nr_txsw +=3D 1;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> > +             nr_ack +=3D 1;
> > +             break;
>
> Perhaps demonstrate what to do with the args on the new
> TS_*_OPT_CB.

Roger that.

I would like to know if the current patch is too big to review? Should
I split it into a few patches? But this series has 14 patches right
now which could possibly exceed the maximum limit.

Thanks,
Jason

