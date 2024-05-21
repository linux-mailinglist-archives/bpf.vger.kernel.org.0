Return-Path: <bpf+bounces-30143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46618CB323
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2D5282C5C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB7148302;
	Tue, 21 May 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgn2Ze5B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE97710F
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314282; cv=none; b=RWVXeWkv77MzavqcR2k7GbuFxylsKDxLZDhrJsGqRmhzzGj1QM5AkCF3LIXvOPsSHruiCG/c/L0+Tf3qtDt7hc1T56XIXtprahG5nPmzhoUvoVTCU2O7lBdFjPGWmf5DGpOqfTLS6lTT220G0FKZp2PCfAK0493nU8i2Eysl7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314282; c=relaxed/simple;
	bh=57otHDbyWpEQSYZP+djwqxwJXl7UhyRcLly89HjGWqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkuwPbGP7Im3/XiIZ+D0u2EI8Vf9yZT2t3DupnUnUQIvuNHETTsJ5TZzGCHAFFJRv4XBZO8DqVP/CIWQ2j9aATBo5NksBq4zKRH6dYJzuFR2iVKEDTvIreIg9ZjJ0mMA6/O9srhQmltrI56EAzoSuMq5ueLYDeiV1wdijFBbi8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgn2Ze5B; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48072da2f81so1362265137.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716314279; x=1716919079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y++FS4qihT9+Evgj4fmOIvxrPqYqfAhRfO0RbNpCoF8=;
        b=dgn2Ze5BstVGH5bbF754Yn+1N1pJ4L29wcb2/oSFCqPm5ecR/qVoDjGwNFJ0HaLFjG
         NAkqxLfEn36t7I5HzagkIC8ZnCGUQHY/zgaDjIVPF0ZILwXILvJy7vZWKREYe/YJA7W/
         gpz/88LrZLJYx82hki9LwnWIM+Hz+tU608hECiyATSZBw3Du5GOLAode8JZknxGajg3H
         iUNxyRLpUlB3RenNI3ygRaAquZewYz6w2K0+/7hvk1Z+kxCP+gBGUQdFJZdofrVmedHL
         DG3TPKQOegwuL/aznEgFarj04ow+XP6Z92MEzDt3Oltj7EU5Usn6q+oMXib2jUHXQ2hq
         ztvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314279; x=1716919079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y++FS4qihT9+Evgj4fmOIvxrPqYqfAhRfO0RbNpCoF8=;
        b=PjJBHrqWaGaI/J9ESIriO2VgZiQy+Sx+pJvmxmpyBCrdmLQiJoFUemLRtZze0q2Tbp
         XGEi7DAonKNLPt/uimHHcRqaSUUzbQzjiuuxdk28Y9mzbiHAYv58MF5GC7qEpOdHCVAB
         7dMI6IxPHvtP3+khHOTsfwaZi3G44IpOqqIdBLa7EKSY9tHCRGPpgLDnifgVRbUjqCbp
         9HKGB7TVgWQTFGmdjn+hyRtOP2nLQitJNqLTnxZFJRNoVwv+TFK8sFsDExYoTs8paxJl
         kCjL9YUXrz5sW6gscWzPT0WdMveXYVNMF+6QporFYFOlkNH7f+BEzTe/upVTMhk/C/jj
         GoJg==
X-Forwarded-Encrypted: i=1; AJvYcCWmjl28JX343fcNHIpWNbJ912PxblNXPVAFXVMLMUsLTIa3/bp5ujBcPb1xKuU78sT6CMoH0E6oKRo69jaNhXUJ+4ZP
X-Gm-Message-State: AOJu0Yyada3eT8BJ8gf4lBtGWhi9xHQVmsb7gNRwCeI0J8rugKjlPYiG
	TT/mhe1vGCIQQHSyfxuqfQmr/1vmbZipvyu208rsbiRNjRYeBas75fNGCt+kT7iaAB9YEIgrqJk
	bskc+FMS5Ha9EEt0yGtULC3bC+agphAB44KDr59CS1Iv6oTsWxg==
X-Google-Smtp-Source: AGHT+IHNweXdEkUekWOlYLvfYm6g1HJzG73/0P0hKCBUeixcqdl3qjea2nGoyUVaxYhKFfoGJdG4qCFSNvpDz8vqdJM=
X-Received: by 2002:a05:6122:3686:b0:4c9:b8a8:78d4 with SMTP id
 71dfb90a1353d-4df88286052mr31845709e0c.3.1716314279303; Tue, 21 May 2024
 10:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-18-amery.hung@bytedance.com> <ZkwRuEExDs8QnVu1@google.com>
 <CAMB2axOmZbZgqZdWjdAL0__uHgZCtK8G0ABoKCizk16NkQdpTQ@mail.gmail.com>
In-Reply-To: <CAMB2axOmZbZgqZdWjdAL0__uHgZCtK8G0ABoKCizk16NkQdpTQ@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 21 May 2024 10:57:47 -0700
Message-ID: <CAKH8qBsU4QY4vv-O4qisx-=H6h+ZWev3f1RGdWUn-F_1VYPJHg@mail.gmail.com>
Subject: Re: [RFC PATCH v8 17/20] selftests: Add a basic fifo qdisc test
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 8:03=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Mon, May 20, 2024 at 8:15=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On 05/10, Amery Hung wrote:
> > > This selftest shows a bare minimum fifo qdisc, which simply enqueues =
skbs
> > > into the back of a bpf list and dequeues from the front of the list.
> > >
> > > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/bpf_qdisc.c      | 161 ++++++++++++++++=
++
> > >  .../selftests/bpf/progs/bpf_qdisc_common.h    |  23 +++
> > >  .../selftests/bpf/progs/bpf_qdisc_fifo.c      |  83 +++++++++
> > >  3 files changed, 267 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.=
c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_commo=
n.h
> > >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.=
c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > > new file mode 100644
> > > index 000000000000..295d0216e70f
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > > @@ -0,0 +1,161 @@
> > > +#include <linux/pkt_sched.h>
> > > +#include <linux/rtnetlink.h>
> > > +#include <test_progs.h>
> > > +
> > > +#include "network_helpers.h"
> > > +#include "bpf_qdisc_fifo.skel.h"
> > > +
> > > +#ifndef ENOTSUPP
> > > +#define ENOTSUPP 524
> > > +#endif
> > > +
> > > +#define LO_IFINDEX 1
> > > +
> > > +static const unsigned int total_bytes =3D 10 * 1024 * 1024;
> > > +static int stop;
> > > +
> > > +static void *server(void *arg)
> > > +{
> > > +     int lfd =3D (int)(long)arg, err =3D 0, fd;
> > > +     ssize_t nr_sent =3D 0, bytes =3D 0;
> > > +     char batch[1500];
> > > +
> > > +     fd =3D accept(lfd, NULL, NULL);
> > > +     while (fd =3D=3D -1) {
> > > +             if (errno =3D=3D EINTR)
> > > +                     continue;
> > > +             err =3D -errno;
> > > +             goto done;
> > > +     }
> > > +
> > > +     if (settimeo(fd, 0)) {
> > > +             err =3D -errno;
> > > +             goto done;
> > > +     }
> > > +
> > > +     while (bytes < total_bytes && !READ_ONCE(stop)) {
> > > +             nr_sent =3D send(fd, &batch,
> > > +                            MIN(total_bytes - bytes, sizeof(batch)),=
 0);
> > > +             if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
> > > +                     continue;
> > > +             if (nr_sent =3D=3D -1) {
> > > +                     err =3D -errno;
> > > +                     break;
> > > +             }
> > > +             bytes +=3D nr_sent;
> > > +     }
> > > +
> > > +     ASSERT_EQ(bytes, total_bytes, "send");
> > > +
> > > +done:
> > > +     if (fd >=3D 0)
> > > +             close(fd);
> > > +     if (err) {
> > > +             WRITE_ONCE(stop, 1);
> > > +             return ERR_PTR(err);
> > > +     }
> > > +     return NULL;
> > > +}
> > > +
> > > +static void do_test(char *qdisc)
> > > +{
> > > +     DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex =3D LO_IFINDEX,
> > > +                         .attach_point =3D BPF_TC_QDISC,
> > > +                         .parent =3D TC_H_ROOT,
> > > +                         .handle =3D 0x8000000,
> > > +                         .qdisc =3D qdisc);
> > > +     struct sockaddr_in6 sa6 =3D {};
> > > +     ssize_t nr_recv =3D 0, bytes =3D 0;
> > > +     int lfd =3D -1, fd =3D -1;
> > > +     pthread_t srv_thread;
> > > +     socklen_t addrlen =3D sizeof(sa6);
> > > +     void *thread_ret;
> > > +     char batch[1500];
> > > +     int err;
> > > +
> > > +     WRITE_ONCE(stop, 0);
> > > +
> > > +     err =3D bpf_tc_hook_create(&hook);
> > > +     if (!ASSERT_OK(err, "attach qdisc"))
> > > +             return;
> > > +
> > > +     lfd =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> > > +     if (!ASSERT_NEQ(lfd, -1, "socket")) {
> > > +             bpf_tc_hook_destroy(&hook);
> > > +             return;
> > > +     }
> > > +
> > > +     fd =3D socket(AF_INET6, SOCK_STREAM, 0);
> > > +     if (!ASSERT_NEQ(fd, -1, "socket")) {
> > > +             bpf_tc_hook_destroy(&hook);
> > > +             close(lfd);
> > > +             return;
> > > +     }
> > > +
> > > +     if (settimeo(lfd, 0) || settimeo(fd, 0))
> > > +             goto done;
> > > +
> > > +     err =3D getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
> > > +     if (!ASSERT_NEQ(err, -1, "getsockname"))
> > > +             goto done;
> > > +
> > > +     /* connect to server */
> > > +     err =3D connect(fd, (struct sockaddr *)&sa6, addrlen);
> > > +     if (!ASSERT_NEQ(err, -1, "connect"))
> > > +             goto done;
> > > +
> > > +     err =3D pthread_create(&srv_thread, NULL, server, (void *)(long=
)lfd);
> > > +     if (!ASSERT_OK(err, "pthread_create"))
> > > +             goto done;
> > > +
> > > +     /* recv total_bytes */
> > > +     while (bytes < total_bytes && !READ_ONCE(stop)) {
> > > +             nr_recv =3D recv(fd, &batch,
> > > +                            MIN(total_bytes - bytes, sizeof(batch)),=
 0);
> > > +             if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
> > > +                     continue;
> > > +             if (nr_recv =3D=3D -1)
> > > +                     break;
> > > +             bytes +=3D nr_recv;
> > > +     }
> > > +
> > > +     ASSERT_EQ(bytes, total_bytes, "recv");
> > > +
> > > +     WRITE_ONCE(stop, 1);
> > > +     pthread_join(srv_thread, &thread_ret);
> > > +     ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
> > > +
> > > +done:
> > > +     close(lfd);
> > > +     close(fd);
> > > +
> > > +     bpf_tc_hook_destroy(&hook);
> > > +     return;
> > > +}
> > > +
> > > +static void test_fifo(void)
> > > +{
> > > +     struct bpf_qdisc_fifo *fifo_skel;
> > > +     struct bpf_link *link;
> > > +
> > > +     fifo_skel =3D bpf_qdisc_fifo__open_and_load();
> > > +     if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
> > > +             return;
> > > +
> > > +     link =3D bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
> > > +     if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> > > +             bpf_qdisc_fifo__destroy(fifo_skel);
> > > +             return;
> > > +     }
> > > +
> > > +     do_test("bpf_fifo");
> > > +
> > > +     bpf_link__destroy(link);
> > > +     bpf_qdisc_fifo__destroy(fifo_skel);
> > > +}
> > > +
> > > +void test_bpf_qdisc(void)
> > > +{
> > > +     if (test__start_subtest("fifo"))
> > > +             test_fifo();
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/t=
ools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> > > new file mode 100644
> > > index 000000000000..96ab357de28e
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> > > @@ -0,0 +1,23 @@
> > > +#ifndef _BPF_QDISC_COMMON_H
> > > +#define _BPF_QDISC_COMMON_H
> > > +
> > > +#define NET_XMIT_SUCCESS        0x00
> > > +#define NET_XMIT_DROP           0x01    /* skb dropped              =
    */
> > > +#define NET_XMIT_CN             0x02    /* congestion notification  =
    */
> > > +
> > > +#define TC_PRIO_CONTROL  7
> > > +#define TC_PRIO_MAX      15
> > > +
> > > +void bpf_skb_set_dev(struct sk_buff *skb, struct Qdisc *sch) __ksym;
> > > +u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
> > > +void bpf_skb_release(struct sk_buff *p) __ksym;
> > > +void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *t=
o_free) __ksym;
> > > +void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 =
delta_ns) __ksym;
> > > +bool bpf_qdisc_find_class(struct Qdisc *sch, u32 classid) __ksym;
> > > +int bpf_qdisc_create_child(struct Qdisc *sch, u32 min,
> > > +                        struct netlink_ext_ack *extack) __ksym;
> > > +int bpf_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch, u32 cl=
assid,
> > > +                   struct bpf_sk_buff_ptr *to_free_list) __ksym;
> > > +struct sk_buff *bpf_qdisc_dequeue(struct Qdisc *sch, u32 classid) __=
ksym;
> > > +
> > > +#endif
> > > diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/too=
ls/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> > > new file mode 100644
> > > index 000000000000..433fd9c3639c
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> > > @@ -0,0 +1,83 @@
> > > +#include <vmlinux.h>
> > > +#include "bpf_experimental.h"
> > > +#include "bpf_qdisc_common.h"
> > > +
> > > +char _license[] SEC("license") =3D "GPL";
> > > +
> > > +#define private(name) SEC(".data." #name) __hidden __attribute__((al=
igned(8)))
> > > +
> > > +private(B) struct bpf_spin_lock q_fifo_lock;
> > > +private(B) struct bpf_list_head q_fifo __contains_kptr(sk_buff, bpf_=
list);
> > > +
> > > +unsigned int q_limit =3D 1000;
> > > +unsigned int q_qlen =3D 0;
> > > +
> > > +SEC("struct_ops/bpf_fifo_enqueue")
> > > +int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sc=
h,
> > > +          struct bpf_sk_buff_ptr *to_free)
> > > +{
> > > +     q_qlen++;
> > > +     if (q_qlen > q_limit) {
> > > +             bpf_qdisc_skb_drop(skb, to_free);
> > > +             return NET_XMIT_DROP;
> > > +     }
> >
> > [..]
> >
> > > +     bpf_spin_lock(&q_fifo_lock);
> > > +     bpf_list_excl_push_back(&q_fifo, &skb->bpf_list);
> > > +     bpf_spin_unlock(&q_fifo_lock);
> >
> > Can you also expand a bit on the locking here and elsewhere? And how it
> > interplays with TCQ_F_NOLOCK?
> >
> > As I mentioned at lsfmmbpf, I don't think there is a lot of similar
> > locking in the existing C implementations? So why do we need it here?
>
> The locks are required to prevent catastrophic concurrent accesses to
> bpf graphs. The verifier will check 1) if there is a spin_lock in the
> same struct with a list head or rbtree root, and 2) the lock is held
> when accessing the list or rbtree.
>
> Since we have the safety guarantee provided by the verifier, I think
> there is an opportunity to allow qdisc users to set TCQ_F_NOLOCK. I will
> check if qdisc kfuncs are TCQ_F_NOLOCK safe though. Let me know if I
> missed anything.

Ah, so these locking constraints come from the verifier....
In this case, yes, it would be nice to have special treatment for bpf
qdisc (or maybe allow passing TCQ_F_NOLOCK somehow). If the verifier
enforces the locking for the underlying data structures, we should try
to remove the ones from the generic qdisc layer.

