Return-Path: <bpf+bounces-49760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2CAA1C0C1
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 04:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7387A18891EF
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB012204683;
	Sat, 25 Jan 2025 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN8I72xB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1C25A623;
	Sat, 25 Jan 2025 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737776578; cv=none; b=to3BtxWWhmHftci6EeiNzwf/eKv+ZTl6Yeap6YrRQttTeqPdN2hYw36A2uS5cy4/TVXaJYxhxb9ahacpLuaTNt/QwjVPmPs9g8Rg9tPagyoU1IsdmexwH6WgTdA4IhvCXa8Y3Lb3evjWQs8N0x+UGzOiqObJcpJosDwaJI5zh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737776578; c=relaxed/simple;
	bh=gM8Xh4qo7Sr7+2LsP6BDCnxS/B/6a7mRHXNQV0GBrUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jj6tKdjH6tENrA2s5CcQYFBRpyK7QCQMkF7beRtLR62kfgraCu/RwEHXBH6IrYWVaU3uvbeTfjN7Oy4MNE4mb1UDknlvkbJuKKz08exOfGQ51+h2F4UIBPgfrBDgcyhG2iepws8GiNh5Tvb6YsIdNtWYskr+yTjJUjz0BI5u4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN8I72xB; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso8484195ab.1;
        Fri, 24 Jan 2025 19:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737776575; x=1738381375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sO/FW6MPRDVQv5xCUdgA+HR0TRSL6ltbbxDu3+zEG8=;
        b=cN8I72xBO7WioDBgE5iFWn3yXxjYcmmYitiokjLw+uRQqEnoxZj/rhuCIsLjuGofD9
         +cy1ILlSXEBMCu1O5z6ioHiaEDulfTPs33VzrqW1lOH1oUQRCJFoQpXXLHXeIWQBBz8V
         K0Kw6ay0i+f5X+8nToAgYLwLcpxMIlnKZ7kRh4JXlRjTWCeQgpZBiPiiGaeMr+V8yxrG
         XXjLiEb7K1E0vgS13bee8Sy/oXPUnepWBo6VqT+YHLHy3K9Rr3OBSTqHklRWntjycUUk
         PwIFGj0qtqjGT4CByWh0Inh34bsEEO1DPGtCR1wIYgqzlqUIk/lhMKRdkLXOpZrndk3J
         mcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737776575; x=1738381375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sO/FW6MPRDVQv5xCUdgA+HR0TRSL6ltbbxDu3+zEG8=;
        b=cuAZqCKT+ecuu9/AA2nDO+pP6UT7utsDmDfjD4mlY1zRokgXCmjzvrIB5B6zLZtoSr
         cG5W+nxfVaEHwUcksSnBV1r+vetr3ZAkGxLTTq7BOM4GLFAYIFNDLsfQl4bElS0R+RSR
         PGP99SkDJbAztIx0F+ArH67/+d5R00Mj79Q1eKLgygokum5hEVrY5BYjS1vSijkU2tW6
         BUuAuWUmZaC2OX6756oxKVa5dORDGDww9z02pXDp8MHR9qBz4yzndokgk/3FymwTvng2
         6f1oxfPCOZF/TiSiggqSH3+fT2R/ffoafFpt7szEFLtPiW6GlFFGUs0ExsHXJBeu2LON
         BKTg==
X-Forwarded-Encrypted: i=1; AJvYcCUdV+yRRmmsQ3TrfgXfZGUWngGZlO2+Bbn48OhLKqxhqMP2cYqOYNzDIrnZ4L8lCSat0xi3b9GG@vger.kernel.org, AJvYcCVwRQRjS1C+nw+YWmv9EpK+r6IXGFsqSnXCcJWNKRDPLelRaQ6PcDxl/IjFV6cm0I858Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyjFDacjBCesjQhb3vx3Vratcpjd2LAuPodwWVc6YLzsceWv+1
	SAISwbd0IPHPSN4cbWGH78GX//Fc41TMXASlP48oPb9zZdjV2r3UhgWIsRdS/XS1dA2aYcZp3Vt
	AtauluiJHAPRPlclGTcMtQAdbh9Y=
X-Gm-Gg: ASbGnctbt5BxpLV0SoJiFLbdQmuCH5JIFRfSQiOjQy5fWjvTxGGxCq/rRW0PGlRe4wY
	uijfc6KeTuCdRMdTTVrTF/jc2G93ggaz+637Rg7SU6aA77Esidai4yrE7ZMZIrQ==
X-Google-Smtp-Source: AGHT+IHP5Uy5zO43+PUnseH/1T3DbDXqGiCAq9PvacoC97fNElfv9KJXKLcIDJLkZgnOGzrYB6UPaK3uitvMCkV4lUw=
X-Received: by 2002:a05:6e02:1a24:b0:3cf:b87b:8fd4 with SMTP id
 e9e14a558f8ab-3cfb87c43e7mr111505745ab.15.1737776575194; Fri, 24 Jan 2025
 19:42:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-14-kerneljasonxing@gmail.com> <564d8d62-3148-41a1-ae08-ed4ad08996d3@linux.dev>
In-Reply-To: <564d8d62-3148-41a1-ae08-ed4ad08996d3@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 11:42:18 +0800
X-Gm-Features: AWEUYZm56xtX6CHa5VlvV_CN-YZ3w2pdIRdrLk-1QYM3bxlFASsmlG00G2FSYhM
Message-ID: <CAL+tcoCpJESydmRXp9ASeXYjFkjOyXn+dF+7dYa0Ek6DdnMHKw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 13/13] bpf: add simple bpf tests in the tx
 path for so_timestamping feature
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 11:08=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 1/20/25 5:29 PM, Jason Xing wrote:
> > Only check if we pass those three key points after we enable the
> > bpf extension for so_timestamping. During each point, we can choose
> > whether to print the current timestamp.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   .../bpf/prog_tests/so_timestamping.c          |  98 ++++++++
> >   .../selftests/bpf/progs/so_timestamping.c     | 227 +++++++++++++++++=
+
> >   2 files changed, 325 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestam=
ping.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.=
c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b=
/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> > new file mode 100644
> > index 000000000000..bbfa7eb38cfb
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> > @@ -0,0 +1,98 @@
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
>
> Reuse the netns_new("so_timestamping_ns", true) from test_progs.c.
>
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
>
> nit. ASSERT_OK_FD.
>
> > +             goto out;
> > +
> > +     cfd =3D connect_to_fd(sfd, 0);
> > +     if (!ASSERT_GE(cfd, 0, "connect_to_fd_server")) {
>
> Same here. ASSERT_OK_FD.
>
> > +             close(sfd);
>
> This close is unnecessary. It will cause a double close at "out:" also.
>
> > +             goto out;
> > +     }
> > +
> > +     n =3D write(cfd, buf, sizeof(buf));
> > +     if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
> > +             goto out;
> > +
> > +     ASSERT_EQ(bss->nr_active, 1, "nr_active");
> > +     ASSERT_EQ(bss->nr_snd, 2, "nr_snd");
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
>
> nit. so_timestamping__open_and_load()
>
> > +     if (!ASSERT_OK_PTR(skel, "open skel"))
> > +             goto done;
> > +
> > +     if (!ASSERT_OK(so_timestamping__load(skel), "load skel"))
>
> Then this __load() is not need.
>
> > +             goto done;
> > +
> > +     if (!ASSERT_OK(so_timestamping__attach(skel), "attach skel"))
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
> > index 000000000000..f4708e84c243
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
> > @@ -0,0 +1,227 @@
> > +#include "vmlinux.h"
> > +#include "bpf_tracing_net.h"
> > +#include <bpf/bpf_core_read.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +//#include <bpf/bpf_core_read.h>
> > +#include "bpf_misc.h"
> > +#include "bpf_kfuncs.h"
> > +
> > +#define SK_BPF_CB_FLAGS 1009
> > +#define SK_BPF_CB_TX_TIMESTAMPING 1
> > +
> > +int nr_active;
> > +int nr_snd;
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
> > +     const struct sock *sk;
> > +};
> > +
> > +struct sk_stg {
> > +     __u64 sendmsg_ns;       /* record ts when sendmsg is called */
> > +};
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_SK_STORAGE);
> > +     __uint(map_flags, BPF_F_NO_PREALLOC);
> > +     __type(key, int);
> > +     __type(value, struct sk_stg);
> > +} sk_stg_map SEC(".maps");
> > +
> > +
> > +struct delay_info {
> > +     u64 sendmsg_ns;         /* record ts when sendmsg is called */
> > +     u32 sched_delay;        /* SCHED_OPT_CB - sendmsg_ns */
> > +     u32 sw_snd_delay;       /* SW_OPT_CB - SCHED_OPT_CB */
> > +     u32 ack_delay;          /* ACK_OPT_CB - SW_OPT_CB */
> > +};
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __type(key, u32);
> > +     __type(value, struct delay_info);
> > +     __uint(max_entries, 1024);
> > +} time_map SEC(".maps");
> > +
> > +static u64 delay_tolerance_nsec =3D 1000000000; /* 1 second as an exam=
ple */
> > +
> > +static int bpf_test_sockopt_int(void *ctx, const struct sock *sk,
> > +                             const struct sockopt_test *t,
> > +                             int level)
> > +{
> > +     int new, opt, tmp;
> > +
> > +     opt =3D t->opt;
> > +     new =3D t->new;
> > +
> > +     if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
> > +             return 1;
> > +
> > +     if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
> > +         tmp !=3D new) {
> > +             return 1;
> > +     }
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
> > +static int bpf_test_sockopt(void *ctx, const struct sock *sk)
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
> > +static bool bpf_test_delay(struct bpf_sock_ops *skops, const struct so=
ck *sk)
> > +{
> > +     struct bpf_sock_ops_kern *skops_kern;
> > +     u64 timestamp =3D bpf_ktime_get_ns();
> > +     struct skb_shared_info *shinfo;
> > +     struct delay_info dinfo =3D {0};
> > +     struct delay_info *val;
> > +     struct sk_buff *skb;
> > +     struct sk_stg *stg;
> > +     u32 delay, tskey;
> > +     u64 prior_ts;
> > +
> > +     skops_kern =3D bpf_cast_to_kern_ctx(skops);
> > +     skb =3D skops_kern->skb;
> > +     shinfo =3D bpf_core_cast(skb->head + skb->end, struct skb_shared_=
info);
> > +     tskey =3D shinfo->tskey;
> > +     if (!tskey)
> > +             return false;
> > +
> > +     if (skops->op =3D=3D BPF_SOCK_OPS_TS_TCP_SND_CB) {
> > +             stg =3D bpf_sk_storage_get(&sk_stg_map, (void *)sk, 0, 0)=
;
> > +             if (!stg)
> > +                     return false;
> > +             dinfo.sendmsg_ns =3D stg->sendmsg_ns;
> > +             val =3D &dinfo;
>
> Move the map_update here instead.
>
>                 bpf_map_update_elem(&time_map, &tskey, val, BPF_ANY);
>
> > +             goto out;
> > +     }
> > +
> > +     val =3D bpf_map_lookup_elem(&time_map, &tskey);
> > +     if (!val)
> > +             return false;
> > +
> > +     switch (skops->op) {
> > +     case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> > +             delay =3D val->sched_delay =3D timestamp - val->sendmsg_n=
s;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_SW_OPT_CB:
> > +             prior_ts =3D val->sched_delay + val->sendmsg_ns;
> > +             delay =3D val->sw_snd_delay =3D timestamp - prior_ts;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> > +             prior_ts =3D val->sw_snd_delay + val->sched_delay + val->=
sendmsg_ns;
> > +             delay =3D val->ack_delay =3D timestamp - prior_ts;
> > +             break;
> > +     }
> > +
> > +     if (delay <=3D 0 || delay >=3D delay_tolerance_nsec)
>
> Regarding delay <=3D 0 check, note that delay was defined as u32.
>
> delay_tolerance_nsec is 1 sec which could be too short for the bpf CI. Ma=
y be
> raise it to like 10s and only check "if (delay >=3D delay_tolerance_nsec)=
". It
> will be useful to bump a nr_long_delay++ also and ASSERT in the userspace=
.
>
> btw, it is in nsec, is u32 enough?
>
>
> > +             return false;
> > +
> > +     /* Since it's the last one, remove from the map after latency che=
ck */
> > +     if (skops->op =3D=3D BPF_SOCK_OPS_TS_ACK_OPT_CB) {
> > +             bpf_map_delete_elem(&time_map, &tskey);
> > +             return true;
> > +     }
> > +
> > +out:
> > +     bpf_map_update_elem(&time_map, &tskey, val, BPF_ANY);
>
> then no need to do update_elem here for other op.

I'm going to adjust all the points that you mentioned as above. Thanks!

>
> Overall, I think the set looks good. Only a few things left. Thanks for
> revamping the test also. The test should be pretty close to how it will b=
e used.
>
> Please add tests to ensure the new timestamping callbacks cannot use the =
helpers
> that we discussed in the earlier patch and also cannot directly read/writ=
e the
> sock fields through the bpf_sock_ops.

No problem. Will do it in the next respin.

>
> Please also add some details on how the UDP BPF_SOCK_OPS_TS_TCP_SND_CB (o=
r to be
> renamed to BPF_SOCK_OPS_TS_SND_CB ?) will look like. It is the only callb=
ack
> that I don't have a clear idea for UDP.

I think I will rename it as you said. But I wonder if I can add more
details about UDP after this series gets merged which should not be
too late. After this series, I will carefully consider and test how we
use for UDP type.

>
> Please tag the set to bpf-next. Then the bpf CI can pick up automatically=
 and
> continue testing it whenever some other bpf patches landed.

Got it!

>
> [ I will reply other followup later ]

Thanks for your work.

>
> > +     return true;
> > +}
> > +
> > +SEC("fentry/tcp_sendmsg_locked")
> > +int BPF_PROG(trace_tcp_sendmsg_locked, struct sock *sk, struct msghdr =
*msg, size_t size)
> > +{
> > +     u64 timestamp =3D bpf_ktime_get_ns();
> > +     u32 flag =3D sk->sk_bpf_cb_flags;
> > +     struct sk_stg *stg;
> > +
> > +     if (!flag)
> > +             return 0;
> > +
> > +     stg =3D bpf_sk_storage_get(&sk_stg_map, sk, 0,
> > +                              BPF_SK_STORAGE_GET_F_CREATE);
> > +     if (!stg)
> > +             return 0;
> > +
> > +     stg->sendmsg_ns =3D timestamp;
> > +     nr_snd +=3D 1;
> > +     return 0;
> > +}
> > +
> > +SEC("sockops")
> > +int skops_sockopt(struct bpf_sock_ops *skops)
> > +{
> > +     struct bpf_sock *bpf_sk =3D skops->sk;
> > +     const struct sock *sk;
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
> > +     case BPF_SOCK_OPS_TS_TCP_SND_CB:
> > +             if (bpf_test_delay(skops, sk))
> > +                     nr_snd +=3D 1;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> > +             if (bpf_test_delay(skops, sk))
> > +                     nr_sched +=3D 1;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_SW_OPT_CB:
> > +             if (bpf_test_delay(skops, sk))
> > +                     nr_txsw +=3D 1;
> > +             break;
> > +     case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> > +             if (bpf_test_delay(skops, sk))
> > +                     nr_ack +=3D 1;
> > +             break;
> > +     }
> > +
> > +     return 1;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
>

