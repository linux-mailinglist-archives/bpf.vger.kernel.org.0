Return-Path: <bpf+bounces-46403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9119E99D0
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 16:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD894282FEA
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7221BEF73;
	Mon,  9 Dec 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6WCnSUb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF81B0420;
	Mon,  9 Dec 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756364; cv=none; b=OqgN7+UB0ltUAAvaIByImGwxW7b2R8Pm+2VO3dAweJ8RPkcwdrcW+IETCZ/A7kIQLkxKsQmwCDd4vQ58COUbOCJl71RAfwmUF+PHPePotrbGUu9nTPOwMX4E5eO0TNh9rVgVOkIfiuUTBqqbbfXIPh3X1DRoT1lCIUSU8a5yCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756364; c=relaxed/simple;
	bh=RnziF7I+GIF12Gw37CC2Nayai3UDOJ/YIgYq0Vr2fdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDJdOo4lwlPTZEm3EGppk21JKcd4PyXryRO1diTQdmO9m+fGbX16ANaTMsOsf7b0tJCRst4izk8K33zrGa3KV/DFNvopA6Sm57I/+VBo6afMV97JrJbRtfsxOPQarmhusiVucyM8CB0/ZD3HMmSDJXHNCh8piRWNZSzuP+MZOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6WCnSUb; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-841d8dec20aso139281039f.3;
        Mon, 09 Dec 2024 06:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733756361; x=1734361161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsGBgEFVSjnBwprNKOnRmwnuVT2osYiL41EtFLb2wxg=;
        b=A6WCnSUbwIJYKVFOHyTy96wckjURvM7JUQ4Z/pF2dBojep81rRk4XHZ38nnP5f+e/o
         bp0CgNLBC6abJWKF6NwPwiDple+t8pDaJSIVTU/T0ACZ9wxG50yn4dV3vaGVSA1JxS/h
         Kylt5h20ip0Cp3P4vXffpngLhIneoka8AOucMOpwv/C3XAA3HyW+XXOHs46r0OAkgkRf
         y13DiYW4Jpni325UdSuDOdEDbpJt40w33aXYaHU94UlwloNweQuhdDl24W8Rw4t8wPPB
         Q8DO20q7lEpfTpL8HSraOxA4mGCQJHfilXIurN0pHySz1PtK1BsPZ0s1EfjTOOMO6y0z
         1b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756361; x=1734361161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsGBgEFVSjnBwprNKOnRmwnuVT2osYiL41EtFLb2wxg=;
        b=nngmKDTABT3nOpgpshHY8DJDBkwB8y6D6D5RNqfaSAcEGbB4eufrdk6Vpb4ALzo0No
         PukUQBTJbSnlfPRa1HDl2oVGi+zzdqj8yltNBfOQjqeg2pArAJAmXwv1JCdRiMB5D0iG
         95Hdv8Y+cs/SJOF9MukBglrNFl7+eNPNdoG3okwz8/hI3qEBZwhNCIPr5/d4TTxng6k3
         VrZKzCHw0jbWQpuFZZak6FNdq5mUqZ/u9YRLJIWjTt3tZXFFz6pX0AlvLgC4QVPxQiOy
         VmpCQt3JCpqqwPsISn1Z2EDuY/rAsMsfDVftSX7DBm48H4uq3UFiDebM5RI4sh84k3ZO
         Ar4A==
X-Forwarded-Encrypted: i=1; AJvYcCUE9fsk80MlaD65YH/2KDi9fPmdvXB3d7HX1NUpRDYEm8D1bDH/lXDPQnkd5dFDTdDcJT4=@vger.kernel.org, AJvYcCUuzoubedtssWkOPJfzDklQ+92NQOSLfUXuP44iUved5boUGgX2d1LycU42QAdV3fTyvJ0tPhJS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6sE2c/saoQoPv/lDLI5xlMsP5n4p2wuCUfhPI94VRlcmTkaAX
	UKu5W0pRaFq2yYNcJrdCk2D6mMgmBNuo6kh8UcsGbiZkstqOKZt51al6VrA+2uNs9nZ87EkJ6fk
	5zOG+aVd/gfWLBX30CmBRVTRAOtA=
X-Gm-Gg: ASbGncsL+kC9v+RMAPJQadfIOYpReJJkyDSHX0jC404UhY8a7N4Uqg5TeQG4uQucdxV
	/UkHljXzNF55IRRHTrBq1+25yN0/khQ==
X-Google-Smtp-Source: AGHT+IHCkMVYHUkWByhXpzzG8u+jHGSFGxkB/Mhvw/BmLU7/0BdikwscqH0OCkT50+Mu1mywusYJqO0xcwR066if/PI=
X-Received: by 2002:a05:6e02:1a83:b0:3a7:e0d1:e255 with SMTP id
 e9e14a558f8ab-3a9dbb2b3bdmr8392345ab.23.1733756361315; Mon, 09 Dec 2024
 06:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-12-kerneljasonxing@gmail.com> <6757029acc193_31657c2947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <6757029acc193_31657c2947c@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Dec 2024 22:58:45 +0800
Message-ID: <CAL+tcoCD_oiHbLvPj2MpcW0vrp2-me-OznF2kvt3=-NYZo3WTg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 11/11] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:45=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
>
> in subject: s/so_timstamping/so_timestamping

Will fix it soon.

>
> > Only check if we pass those three key points after we enable the
> > bpf extension for so_timestamping. During each point, we can choose
> > whether to print the current timestamp.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  .../bpf/prog_tests/so_timestamping.c          |  97 +++++++++++++
> >  .../selftests/bpf/progs/so_timestamping.c     | 135 ++++++++++++++++++
> >  2 files changed, 232 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamp=
ing.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b=
/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> > new file mode 100644
> > index 000000000000..c5978444f9c8
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> > @@ -0,0 +1,97 @@
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
> > index 000000000000..f64e94dbd70e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
> > @@ -0,0 +1,135 @@
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
> > +#define SK_BPF_CB_FLAGS 1009
> > +#define SK_BPF_CB_TX_TIMESTAMPING 1
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
> > +};
> > +
> > +static const struct sockopt_test sol_socket_tests[] =3D {
> > +     { .opt =3D SK_BPF_CB_FLAGS, .new =3D SK_BPF_CB_TX_TIMESTAMPING, }=
,
> > +     { .opt =3D 0, },
> > +};
> > +
> > +struct loop_ctx {
> > +     void *ctx;
> > +     struct sock *sk;
> > +};
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __type(key, u32);
> > +     __type(value, u64);
> > +     __uint(max_entries, 1024);
> > +} hash_map SEC(".maps");
> > +
> > +static u64 delay_tolerance_nsec =3D 5000000;
> > +
> > +static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
> > +                             const struct sockopt_test *t,
> > +                             int level)
> > +{
> > +     int new, opt;
> > +
> > +     opt =3D t->opt;
> > +     new =3D t->new;
> > +
> > +     if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
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
> > +static bool bpf_test_delay(struct bpf_sock_ops *skops)
> > +{
> > +     u64 timestamp =3D bpf_ktime_get_ns();
> > +     u32 seq =3D skops->args[2];
> > +     u64 *value;
> > +
> > +     value =3D bpf_map_lookup_elem(&hash_map, &seq);
> > +     if (value && (timestamp - *value > delay_tolerance_nsec)) {
> > +             bpf_printk("time delay: %lu", timestamp - *value);
> > +             return false;
> > +     }
> > +
> > +     bpf_map_update_elem(&hash_map, &seq, &timestamp, BPF_ANY);
>
> Maybe enforce that you expect value to be found for all cases except
> the first (SCHED). I.e., that they share the same seq/tskey.

Good suggestion. Will do it :)

Thanks,
Jason

>
> > +     return true;
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
> > +     case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> > +             if (bpf_test_delay(skops))
> > +                     nr_sched +=3D 1;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_SW_OPT_CB:
> > +             if (bpf_test_delay(skops))
> > +                     nr_txsw +=3D 1;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> > +             if (bpf_test_delay(skops))
> > +                     nr_ack +=3D 1;
> > +             break;
> > +     }
> > +
> > +     return 1;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.37.3
> >
>
>

