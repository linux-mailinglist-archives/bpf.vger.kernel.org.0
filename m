Return-Path: <bpf+bounces-51399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1308A33E1E
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 12:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A8188D674
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD8227EAC;
	Thu, 13 Feb 2025 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLhTm5Du"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B43227E84;
	Thu, 13 Feb 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446333; cv=none; b=toEmlTkIxWo2SaJDtF1Bm0i+Gh3+gXtRYDtLgOUO/kJs4csVKSQg1BDVJ+6oTMyGSFXE7MWuEbdAtRghxbg4ahZGRuWROG7rV5D73LjtfCS7/PzUFTzK55FscIHbhPD9k2LYI7zq5xXxDbykeGCxqbRwm51NVA5A6TPvAZHMJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446333; c=relaxed/simple;
	bh=JMmNrNGxBusUXjmw1e/m43zW+kYp4gjZqwugs+o1GxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPAbcI3fTfMJTPWGxI3aheYZn457cIp8N050KtgIY5nQjNiFFiR94w39TvZXfvAlXh6m1eFBCj6e4aiAU76srl/8q/nE7YvbDwkkd9GKpyaqshDKYUbQkRALBnHkfVRzxwrQXAFCO6TIDNMDpqw+lDy1KE1tqrSL9y5cgdYeigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLhTm5Du; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d191bfeafbso1323725ab.0;
        Thu, 13 Feb 2025 03:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739446331; x=1740051131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5pEdjvoy+hM9yGBLdPLFls6A/hClUwK2piaDLzE5lE=;
        b=VLhTm5DuoX0KBRfE9Z8v/K5LiAgKGPTuayRT5+12wo3OrI3ew3fgJR02vtGztt9Xbm
         dBRvVXqLtTio7qOJe0IbCvrxdebxEMdHUETCgPQsu07mKDIbf9309SdQFESXFygZP5HB
         bfPQrTBainsRxqU6QoM88F6qhrpf/NEcE2qoy4a6NQ5ovhrtb9gTmGgck98ZAukzMGen
         OHsCZsxQOxLLsd+HmZNGNgjbNK/3DgX26eNWio2pY5mt6+Iv7BK40y8oqMNZQP390EcW
         g01Ygj3sMTsB1iCpYi6KI9gBPn6enCQaBObAQrEnLAAzCK4PqYEh6rBGuX52SvCnFL4e
         L/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446331; x=1740051131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5pEdjvoy+hM9yGBLdPLFls6A/hClUwK2piaDLzE5lE=;
        b=vHeNYAPrteMaTuX03TXhh/2ILJuDEzDGkNqAjTVg+n31pX1bVLDUXIpBlu5W3EklHC
         dgeIswcUQXSmAa2NY3cB2ts28wxrirU+AjLiqyXqLEOXg32pCFNyZtAi55pbZCejgPy7
         Y5p9UUSYHdDSNttPQ/H92erTd+hzIW6m3J1a+h0Xrlk5uSJcteOOZcLenj2sOWml3bsk
         R33ihRo/Nl7tK7VviK+p1A9JPUwMAlElZvjJgJDbwvR+eqyqXDrUfqemJcKY6l2/O1pf
         kcSIo4kFuZC3GTlSz66oh8yAmLYPLm8ZZ07wOS5E8Zfc8kVoUKINj2AR5yklPY7Qr/n1
         oxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyoiwV5R10TUuLAg+a7zeJsWMNOG2Y1yGKJUbgTqUjQQYp9SDbPAR5Abka6adkUSjK7Jnw1xaZ@vger.kernel.org, AJvYcCXD9IUItCEc+n8F0R1vaPFcGlb6WgXBFjCIyYC19Z471QM2F4AZzA7rOLYaLobDp7OMsjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTIvn2z7jTn+Gjn5P9gy5wMHauE0iyH8gy8bKJS35WE5Da+H8
	z1ZXioq7Yi6dHDHeubQOywYqAvsSSIg5DRKXYOYYEUJ/NlNeaSJtxGRk8/I5H82GndqYJPiIY5A
	UhNynYEZ/0A80toLE2QnniVxUmj0=
X-Gm-Gg: ASbGncv9ZJ6CkVLERW9NbMizOzEcjGWh2TRjMtWWlxO/GVIXCZbAItTvVk90ShAgMmJ
	PyPXCBxNSfwl+7eUBAqP15T2B5kovMXgOilj5RnChSamNN+XNcjJrJ6E9eyyB/atkqUWBwyhJ
X-Google-Smtp-Source: AGHT+IEwtWiy6mbn5Y9MrmdhkoTHR/5WLil4ayL8TII51KdYdm/HZspsjA/LdYAN95MYxz9MgpCu3n7fMRiimekOKYg=
X-Received: by 2002:a05:6e02:1c2c:b0:3d0:4d76:79b8 with SMTP id
 e9e14a558f8ab-3d18c0abe5dmr20000405ab.0.1739446330635; Thu, 13 Feb 2025
 03:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-13-kerneljasonxing@gmail.com> <4e51fae2-0b43-426f-8fae-ea267fe2839f@linux.dev>
In-Reply-To: <4e51fae2-0b43-426f-8fae-ea267fe2839f@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 19:31:33 +0800
X-Gm-Features: AWEUYZkBGzHYVFeqNxf3_qW6nrUVbz4uIm4ivL88iT41ERfsjuOMgbMvMeAJbMc
Message-ID: <CAL+tcoAkRc3mG+ggrMj4MpV=_qn5uS9dsm8jauaDbs6wjmko1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:08=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/11/25 10:18 PM, Jason Xing wrote:
> > BPF program calculates a couple of latency deltas between each tx
> > timestamping callbacks. It can be used in the real world to diagnose
> > the kernel behaviour in the tx path.
> >
> > Check the safety issues by accessing a few bpf calls in
> > bpf_test_access_bpf_calls() which are implemented in the patch 3 and 4.
> >
> > Check if the bpf timestamping can co-exist with socket timestamping.
> >
> > There remains a few realistic things[1][2] to highlight:
> > 1. in general a packet may pass through multiple qdiscs. For instance
> > with bonding or tunnel virtual devices in the egress path.
> > 2. packets may be resent, in which case an ACK might precede a repeat
> > SCHED and SND.
> > 3. erroneous or malicious peers may also just never send an ACK.
> >
> > [1]: https://lore.kernel.org/all/67a389af981b0_14e0832949d@willemb.c.go=
oglers.com.notmuch/
> > [2]: https://lore.kernel.org/all/c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@l=
inux.dev/
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   .../bpf/prog_tests/net_timestamping.c         | 231 +++++++++++++++++
> >   .../selftests/bpf/progs/net_timestamping.c    | 244 +++++++++++++++++=
+
> >   2 files changed, 475 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/net_timesta=
mping.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/net_timestamping=
.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/net_timestamping.c =
b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> > new file mode 100644
> > index 000000000000..dcdc40473a7d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/net_timestamping.c
> > @@ -0,0 +1,231 @@
> > +#include <linux/net_tstamp.h>
> > +#include <sys/time.h>
> > +#include <linux/errqueue.h>
> > +#include "test_progs.h"
> > +#include "network_helpers.h"
> > +#include "net_timestamping.skel.h"
> > +
> > +#define CG_NAME "/net-timestamping-test"
> > +#define NSEC_PER_SEC    1000000000LL
> > +
> > +static const char addr4_str[] =3D "127.0.0.1";
> > +static const char addr6_str[] =3D "::1";
> > +static struct net_timestamping *skel;
> > +static int cfg_payload_len =3D 30;
>
> const ?

Will add it.

>
> > +static struct timespec usr_ts;
> > +static u64 delay_tolerance_nsec =3D 10000000000; /* 10 seconds */
> > +int SK_TS_SCHED;
> > +int SK_TS_TXSW;
> > +int SK_TS_ACK;
> > +
> > +static int64_t timespec_to_ns64(struct timespec *ts)
> > +{
> > +     return ts->tv_sec * NSEC_PER_SEC + ts->tv_nsec;
> > +}
> > +
> > +static void validate_key(int tskey, int tstype)
> > +{
> > +     static int expected_tskey =3D -1;
> > +
> > +     if (tstype =3D=3D SCM_TSTAMP_SCHED)
> > +             expected_tskey =3D cfg_payload_len - 1;
> > +
> > +     ASSERT_EQ(expected_tskey, tskey, "tskey mismatch");
> > +
> > +     expected_tskey =3D tskey;
> > +}
> > +
> > +static void validate_timestamp(struct timespec *cur, struct timespec *=
prev)
> > +{
> > +     int64_t cur_ns, prev_ns;
> > +
> > +     cur_ns =3D timespec_to_ns64(cur);
> > +     prev_ns =3D timespec_to_ns64(prev);
> > +
> > +     ASSERT_TRUE((cur_ns - prev_ns) < delay_tolerance_nsec, "latency")=
;
>
> ASSERT_LT()

Got it!

>
> > +}
> > +
> > +static void test_socket_timestamp(struct scm_timestamping *tss, int ts=
type,
> > +                               int tskey)
> > +{
> > +     static struct timespec *prev_ts =3D &usr_ts;
> > +
> > +     validate_key(tskey, tstype);
> > +
> > +     switch (tstype) {
> > +     case SCM_TSTAMP_SCHED:
> > +             validate_timestamp(&tss->ts[0], prev_ts);
> > +             SK_TS_SCHED =3D 1;
> > +             SK_TS_TXSW =3D SK_TS_ACK =3D 0;
> > +             break;
> > +     case SCM_TSTAMP_SND:
> > +             validate_timestamp(&tss->ts[0], prev_ts);
> > +             SK_TS_TXSW =3D 1;
> > +             break;
> > +     case SCM_TSTAMP_ACK:
> > +             validate_timestamp(&tss->ts[0], prev_ts);
> > +             SK_TS_ACK =3D 1;
> > +             break;
> > +     }
> > +
> > +     prev_ts =3D &tss->ts[0];
> > +}
> > +
> > +static void test_recv_errmsg_cmsg(struct msghdr *msg)
> > +{
> > +     struct sock_extended_err *serr =3D NULL;
> > +     struct scm_timestamping *tss =3D NULL;
> > +     struct cmsghdr *cm;
> > +
> > +     for (cm =3D CMSG_FIRSTHDR(msg);
> > +          cm && cm->cmsg_len;
> > +          cm =3D CMSG_NXTHDR(msg, cm)) {
> > +             if (cm->cmsg_level =3D=3D SOL_SOCKET &&
> > +                 cm->cmsg_type =3D=3D SCM_TIMESTAMPING) {
> > +                     tss =3D (void *) CMSG_DATA(cm);
> > +             } else if ((cm->cmsg_level =3D=3D SOL_IP &&
> > +                         cm->cmsg_type =3D=3D IP_RECVERR) ||
> > +                        (cm->cmsg_level =3D=3D SOL_IPV6 &&
> > +                         cm->cmsg_type =3D=3D IPV6_RECVERR) ||
> > +                        (cm->cmsg_level =3D=3D SOL_PACKET &&
> > +                         cm->cmsg_type =3D=3D PACKET_TX_TIMESTAMP)) {
> > +                     serr =3D (void *) CMSG_DATA(cm);
> > +                     ASSERT_EQ(serr->ee_origin, SO_EE_ORIGIN_TIMESTAMP=
ING,
> > +                                 "cmsg type");
> > +             }
> > +
> > +             if (serr && tss)
> > +                     test_socket_timestamp(tss, serr->ee_info,
> > +                                           serr->ee_data);
> > +     }
> > +}
> > +
> > +static bool socket_recv_errmsg(int fd)
> > +{
> > +     static char ctrl[1024 /* overprovision*/];
> > +     char data[cfg_payload_len];
> > +     static struct msghdr msg;
> > +     struct iovec entry;
> > +     int n =3D 0;
> > +
> > +     memset(&msg, 0, sizeof(msg));
> > +     memset(&entry, 0, sizeof(entry));
> > +     memset(ctrl, 0, sizeof(ctrl));
> > +
> > +     entry.iov_base =3D data;
> > +     entry.iov_len =3D cfg_payload_len;
> > +     msg.msg_iov =3D &entry;
> > +     msg.msg_iovlen =3D 1;
> > +     msg.msg_name =3D NULL;
> > +     msg.msg_namelen =3D 0;
> > +     msg.msg_control =3D ctrl;
> > +     msg.msg_controllen =3D sizeof(ctrl);
> > +
> > +     n =3D recvmsg(fd, &msg, MSG_ERRQUEUE);
> > +     if (n =3D=3D -1)
> > +             ASSERT_EQ(errno, EAGAIN, "recvmsg MSG_ERRQUEUE");
> > +
> > +     if (n >=3D 0)
> > +             test_recv_errmsg_cmsg(&msg);
> > +
> > +     return n =3D=3D -1;
> > +
> > +}
> > +
> > +static void test_socket_timestamping(int fd)
> > +{
> > +     while (!socket_recv_errmsg(fd));
> > +
> > +     ASSERT_EQ(SK_TS_SCHED, 1, "SCM_TSTAMP_SCHED");
> > +     ASSERT_EQ(SK_TS_TXSW, 1, "SCM_TSTAMP_SND");
> > +     ASSERT_EQ(SK_TS_ACK, 1, "SCM_TSTAMP_ACK");
> > +}
> > +
> > +static void test_tcp(int family)
> > +{
> > +     struct net_timestamping__bss *bss =3D skel->bss;
> > +     char buf[cfg_payload_len];
> > +     int sfd =3D -1, cfd =3D -1;
> > +     unsigned int sock_opt;
> > +     int ret;
> > +
> > +     memset(bss, 0, sizeof(*bss));
>
> No need to reset some of the new global variables, e.g. SK_TS_SCHED?

I thought I had handled it well, but the fact is .... Will fix it.

>
> > +
> > +     sfd =3D start_server(family, SOCK_STREAM,
> > +                        family =3D=3D AF_INET6 ? addr6_str : addr4_str=
, 0, 0);
> > +     if (!ASSERT_OK_FD(sfd, "start_server"))
> > +             goto out;
> > +
> > +     cfd =3D connect_to_fd(sfd, 0);
> > +     if (!ASSERT_OK_FD(cfd, "connect_to_fd_server"))
> > +             goto out;
> > +
> > +     sock_opt =3D SOF_TIMESTAMPING_SOFTWARE |
> > +                SOF_TIMESTAMPING_OPT_ID |
> > +                SOF_TIMESTAMPING_TX_SCHED |
> > +                SOF_TIMESTAMPING_TX_SOFTWARE |
> > +                SOF_TIMESTAMPING_TX_ACK;
> > +     ret =3D setsockopt(cfd, SOL_SOCKET, SO_TIMESTAMPING,
> > +                      (char *) &sock_opt, sizeof(sock_opt));
>
> It also needs the original test in v9 to check the bpf timestamping works
> without the user space's SO_TIMESTAMPING, which is the major use case of =
this
> series.
>
> It should be easy to do by conditionally enabling the SO_TIMESTAMPING her=
e.

Agreed.

>
> > +     if (!ASSERT_OK(ret, "setsockopt SO_TIMESTAMPING"))
> > +             goto out;
> > +
> > +     ret =3D clock_gettime(CLOCK_REALTIME, &usr_ts);
> > +     if (!ASSERT_OK(ret, "get user time"))
> > +             goto out;
> > +
> > +     ret =3D write(cfd, buf, sizeof(buf));
> > +     if (!ASSERT_EQ(ret, sizeof(buf), "send to server"))
> > +             goto out;
> > +
> > +     /* Test if socket timestamping works correctly even with bpf
> > +      * extension enabled.
> > +      */
> > +     test_socket_timestamping(cfd);
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
> > +void test_net_timestamping(void)
> > +{
> > +     struct netns_obj *ns;
> > +     int cg_fd;
> > +
> > +     cg_fd =3D test__join_cgroup(CG_NAME);
> > +     if (!ASSERT_OK_FD(cg_fd, "join cgroup"))
> > +             return;
> > +
> > +     ns =3D netns_new("net_timestamping_ns", true);
> > +     if (!ASSERT_OK_PTR(ns, "create ns"))
> > +             goto done;
> > +
> > +     skel =3D net_timestamping__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "open and load skel"))
> > +             goto done;
> > +
> > +     if (!ASSERT_OK(net_timestamping__attach(skel), "attach skel"))
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
>
> Considering the w and w/o SO_TIMESTAMPING combinations (i.e. x2), it is w=
orth to
> have proper subtests. It is easy also. Take a look at the test__start_sub=
test()
> usage `under the prog_tests/.

Will use it :)

>
> > +
> > +done:
> > +     net_timestamping__destroy(skel);
> > +     netns_free(ns);
> > +     close(cg_fd);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/net_timestamping.c b/too=
ls/testing/selftests/bpf/progs/net_timestamping.c
> > new file mode 100644
> > index 000000000000..d3e1da599626
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/net_timestamping.c
> > @@ -0,0 +1,244 @@
> > +#include "vmlinux.h"
> > +#include "bpf_tracing_net.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "bpf_misc.h"
> > +#include "bpf_kfuncs.h"
> > +#include <errno.h>
> > +
> > +#define SK_BPF_CB_FLAGS 1009
> > +#define SK_BPF_CB_TX_TIMESTAMPING 1
>
> Remove these two defines. The vmlinux.h has it.

Will do it.

>
> [ ... ]
>
> > +SEC("fentry/tcp_sendmsg_locked")
> > +int BPF_PROG(trace_tcp_sendmsg_locked, struct sock *sk, struct msghdr =
*msg, size_t size)
> > +{
> > +     u64 timestamp =3D bpf_ktime_get_ns();
> > +     u32 flag =3D sk->sk_bpf_cb_flags;
> > +     struct sk_stg *stg;
> > +
> > +     if (!flag)
>
> I just noticed this one.
>
> Lets replace the "flag" check with a better check (e.g. pid check used in=
 other
> tests). Then it won't affect sk of other tests running in parallel.
>
> It is pretty easy. Take a look at how bpf_get_current_pid_tgid() is used =
in
> progs/local_storage.c.

Thanks, I would use "if (pid !=3D monitored_pid || !flag)" to test.

I've already made the changes as you suggested and it works. Thanks. I
will do more rounds of tests.

>
>
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

