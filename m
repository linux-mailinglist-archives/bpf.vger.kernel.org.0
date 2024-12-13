Return-Path: <bpf+bounces-46868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AED9F11B7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E456D282132
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7957A1E3776;
	Fri, 13 Dec 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgCSgcz4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3141422D4;
	Fri, 13 Dec 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105807; cv=none; b=r50PFwUMzuEKnDjSh/IRcYU0uFrG7qLWc2eqzwts8Hb+XXoewYBOpJtI8MY2iiVzzSBBH0/JJ0wy9HDYCkXOFWOmGc5v1LXEbw4Y7myavUHPLE/uZisyGXn3/PeS0yG2Oj5evNeZfembQMdjNyO0o/K8q12bymBPF2poRY5dIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105807; c=relaxed/simple;
	bh=r4J/iHGWXT2W0mjVactzECRMGPhupDZlR76ruPjW72M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hx2kIGc340/+7FmgKrcwR/fcvsaS762lK+eQFQpFbrXRjGt28mMWpHoGb3I1kSXx7VPUJk3kWhXxedN1OlD4L6BV0Oy7njEGjP1mV9r240rxQ/ttFFIz73u/lsVw6ZfAl7/1QFazRoQaT05ZCFmB/WnOBoeDFaHLWSD9RegUAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgCSgcz4; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844e7409f8aso40225239f.1;
        Fri, 13 Dec 2024 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734105804; x=1734710604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBqLZ0VceY0xzz0CIOalTDgvwXwuN+SBwb0cizhvlp0=;
        b=CgCSgcz4tbikmwBw/aYeAd5STZNDu44OuNXyLsavRSEL7Hnu9H4fEeqXIbhVI4e/SK
         GPDGKLORXTzXE+G8a90NsrU9xyr632j1mBbiJX/jGyai2GEyA1BX/THSgX4ywUIhj+ii
         u7xd7nDgkaw/6/dZ7QafxmUsKBPerpHXyJ0aP/8/v0Ye+XQvxwt9WFn03rE5jcTi+N/8
         CattpN7a98G2/M5jcWTEKYAPo/Tw6C+sVIIvIbZdbKF7UNoiT+jPSkYqje99p/4bcnt+
         EDipMBgnvkxsYq9CTSpt755PF8Cw2SxTFuBSX2Z7IelLX2+kxNT1+G5Z9kh62r4sVKON
         zI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105804; x=1734710604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBqLZ0VceY0xzz0CIOalTDgvwXwuN+SBwb0cizhvlp0=;
        b=o++YgzVgZqKDSH9cDwoFxd3BDjVl2YbPEt70nuWi6rEc7eCfxaSW5cMYFpxxgEiJ50
         Tv3xvmP7WZafqWT3S8n+DB/Qtt3o3V0EjEdOkTgrq8e588YrPIpflO/kTkiYd+JsrTlE
         GaUR+98T7oPvJ/D/3AX3tocs7+CLS0hZnLBm8r7vAHm8Rrv+iEfjlSK+ttggbyWRuCZS
         H14sgXXv6p0VV9Fb/PtfD5HtMXjC1mvddMp3npX2Z4Aaza6PGTZcRiNLFe1pjxnGwzRa
         xFEQbQvxr433FBaaAFwvWLcxvKaJQ7CTnq3+AM54/Jt1GeIZEI+DthkRjCBZp7I9NCuj
         TEaw==
X-Forwarded-Encrypted: i=1; AJvYcCVGVxdpTdahpYReWwfnRD7rwsUSF0gAZ3MJa20lavJJmoOOx0mI3bJC8vLDo5flpERm+cM=@vger.kernel.org, AJvYcCXrGlfncWdFedOHY82LcQpZiGz0iJX1GRiis1cQeirYPnRK++pBFkyCO3DztUdNxmB/pOy6ciim@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0t2WZteuTSsOeyyLkriPeVOTurPgXSSHvIuyOncXwlDw7Yo+
	i212pHPSbJ4GDgndJ2eLRITvXtX9IDpB4QXylq+n5jEdCaX0a3OpHTrDHZoX5nbdNLchCloM/gg
	yqHtts4mQGwPd1snUj5euD04Bnrs=
X-Gm-Gg: ASbGncsBT3/nxq0cvHFOJEZBvl6dfDg63FcD+NnlM0Stdc/0ZGcTGtHhXk/P3iV2QJ3
	4mFXeBR8YOlDTsKzuM/bGDOWMKYF/VFILCImeeQ==
X-Google-Smtp-Source: AGHT+IGKcPaqU2/3npsnsY0YIgzCshxb38lgbrp/DJsbGCVxM2tiw5iGl83HVFRIdTxaovBS341/P8EwjehzaTAIqBA=
X-Received: by 2002:a05:6e02:20e1:b0:3ab:71d2:9bd9 with SMTP id
 e9e14a558f8ab-3aff800ee22mr34437905ab.16.1734105804382; Fri, 13 Dec 2024
 08:03:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-12-kerneljasonxing@gmail.com> <65a83b0e-5547-408a-a081-083ffd9d1c91@linux.dev>
In-Reply-To: <65a83b0e-5547-408a-a081-083ffd9d1c91@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 14 Dec 2024 00:02:48 +0800
Message-ID: <CAL+tcoDALG5pEXEvhrN4e3AWTi8xO-qOt5nLty55hsDiBaRPrA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 11/11] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:14=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/7/24 9:38 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Only check if we pass those three key points after we enable the
> > bpf extension for so_timestamping. During each point, we can choose
> > whether to print the current timestamp.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   .../bpf/prog_tests/so_timestamping.c          |  97 +++++++++++++
> >   .../selftests/bpf/progs/so_timestamping.c     | 135 +++++++++++++++++=
+
> >   2 files changed, 232 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestam=
ping.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.=
c
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
>
> If I count right, 5ms may not a lot for the bpf CI and the test could bec=
ome
> flaky. Probably good enough to ensure the delay is larger than the previo=
us one.

You're right, initially I set 2ms which make the test flaky. How about
20ms? We cannot ensure each delta (calculated between two tx points)
is larger than the previous one.

>
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
>
> Please try not to printk in selftests. The bpf CI cannot interpret it
> meaningfully and turn it into a PASS/FAIL signal.

All right.

>
> > +             return false;
> > +     }
> > +
> > +     bpf_map_update_elem(&hash_map, &seq, &timestamp, BPF_ANY);
>
> A nit.
>
>         *value =3D timestamp;

Will fix it.

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
>
> The test is a good step forward. Thanks. Instead of one u64 as the map va=
lue, I
> think it can be improved to make the test more real to record the individ=
ual
> delay. e.g. the following map value:
>
> struct delay_info {
>         u64 sendmsg_ns;
>         u32 sched_delay;  /* SCHED_OPT_CB - sendmsg_ns */
>         u32 sw_snd_delay;
>         u32 ack_delay;
> };
>

Good advice :)

> and I think a bpf callback during the sendmsg is still needed in the next=
 respin.

Okay, I planned to introduce a new BPF_SOCK_OPS_TS_SENDMSG_OPT_CB
after this patchset gets merged. Since you've already asked, I will
surely follow :) Thanks.


>
> > +     }
> > +
> > +     return 1;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
>

