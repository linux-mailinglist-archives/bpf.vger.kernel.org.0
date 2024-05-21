Return-Path: <bpf+bounces-30119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D664B8CB0F5
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 17:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD8BB2433D
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA0142623;
	Tue, 21 May 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTw5xDRa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE114A8E;
	Tue, 21 May 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303799; cv=none; b=gyVBKzNYhJPfloCtLo7saNJ+jBD7lkBBAOnShdUSbAieceY2ZMkjAZfkSpkCiFJdbypwIwRmvizRodzKirscx1VZWti2XgR5d/KFGT+q/pcYmMLGiKkcZpbPveEkpW1h/ojWHtp+orqRLIje3hc4E9gU2anoHAs4vZ2yFqDuVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303799; c=relaxed/simple;
	bh=/Y45I9chualZW+99/xoX3FB3cef6Agtm2HzDJwduKhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=closqjYh89QdM6QW2woCQYnSXHZde8ymAyZm51r4oyxhLuWPYy54IADNl1NoAU7sriMbx09j+JWucDyB26K2gchIBaSxstws6BwbsiBA5AsXSl5XTpymlTduobcbdsrV9zQqQw449NOQz48jeYf/HmJj3b1NlvS1Suuytd32X84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTw5xDRa; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de607ab52f4so3761022276.2;
        Tue, 21 May 2024 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716303796; x=1716908596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plXb3HCiPEnMJ4Iwt03yRxfneXkmAp+BT/TZjTSpOCE=;
        b=WTw5xDRa1w1wYS4lXl0atZz/RMwQ9c0jC+jv1JvDmiR99VtRwfzDLvZYrepXGQZMlW
         Y8MNqa5tonN34ZwtCE4hGLOa5+B//Uch/5U+Q9TNwkx/iza2Aujg7gpGQsozordyir1g
         JH7rIp1bSrlrwXtZHMW0CN8yIIrGyBtBx4VmJwxM9VcU1d/joJOBMFlrrm9otXvlUVBE
         mBESgXUGlQD/TvQ800UJgRnvqubXh7OTntYpozwDat3TOy+YAfoFbfa2nayEt8/+U8vS
         HeukYyP6Tpq0nTCaDAxWB4KCw3S0fQprVJaBwVup30Wd8Bz2woZTaO5Pmf0GYQ1/i9ob
         ZgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303796; x=1716908596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plXb3HCiPEnMJ4Iwt03yRxfneXkmAp+BT/TZjTSpOCE=;
        b=efdbTCyJFVHlWPEobPHtNGJI8r3TYR4f/9cRgesWFL+Aywgp6fcnElWfDl2yKaEnCG
         +QpynDVbW9F0QOyfYYRxBXZZ//46pi/an018HMDL+RBenEhjpAVTc5l2tz8VcVOiIslW
         Ld/HOgIRJobDnXb4WH4YU8oFSGbWEB/nnqurSl26GKNVX7p4nnMlN7voHuYz4dmByIBX
         2yoPtKyOqKOpuxJjbNcmWMBzhfYO99veKfj/23Oh9ByoY3yNPTvDuNbqHjv+nxXYXr29
         Lspwud46YxkVNaDNlvduBirvN9Fzp3dr7V2Z/NSzHHGrlBH1rkcmUBATumw6dHb9Ng/0
         ocYg==
X-Forwarded-Encrypted: i=1; AJvYcCUfWOi93bAv4Wyo2SjCXBBW4lK+WupbceNdnchSdlgRZ/WFDjhpFJRvEYMjqRPafM2kdGzwCS4+vAJShN8djV/F+eSE
X-Gm-Message-State: AOJu0YycZK8cNrE4O+6EKgm0AthbjDGiUby1GWRTCQ8yYzoz8+aUmVB1
	7xe7IJXpuKDUItZ/II3zOgGVDi9uJJdANRD0kdaAPAPYd0eWgaWbK5XHi/JGziHnQbjDdctJ2SV
	bVAif89Ckf9wcdLM/15K1MV8JuPk=
X-Google-Smtp-Source: AGHT+IGUuqbQYXCoNra15W9/annAoNJjZtPceihDgrpvO/JeqUFz4HsBA4iQGIf6uYFH7CgfBmgeGJ5o/sNfVJivz1M=
X-Received: by 2002:a25:6850:0:b0:de0:f753:ad25 with SMTP id
 3f1490d57ef6-dee4f324aa3mr31525812276.1.1716303796245; Tue, 21 May 2024
 08:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-18-amery.hung@bytedance.com> <ZkwRuEExDs8QnVu1@google.com>
In-Reply-To: <ZkwRuEExDs8QnVu1@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 21 May 2024 08:03:04 -0700
Message-ID: <CAMB2axOmZbZgqZdWjdAL0__uHgZCtK8G0ABoKCizk16NkQdpTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 17/20] selftests: Add a basic fifo qdisc test
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 8:15=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 05/10, Amery Hung wrote:
> > This selftest shows a bare minimum fifo qdisc, which simply enqueues sk=
bs
> > into the back of a bpf list and dequeues from the front of the list.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >  .../selftests/bpf/prog_tests/bpf_qdisc.c      | 161 ++++++++++++++++++
> >  .../selftests/bpf/progs/bpf_qdisc_common.h    |  23 +++
> >  .../selftests/bpf/progs/bpf_qdisc_fifo.c      |  83 +++++++++
> >  3 files changed, 267 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_common.=
h
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > new file mode 100644
> > index 000000000000..295d0216e70f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > @@ -0,0 +1,161 @@
> > +#include <linux/pkt_sched.h>
> > +#include <linux/rtnetlink.h>
> > +#include <test_progs.h>
> > +
> > +#include "network_helpers.h"
> > +#include "bpf_qdisc_fifo.skel.h"
> > +
> > +#ifndef ENOTSUPP
> > +#define ENOTSUPP 524
> > +#endif
> > +
> > +#define LO_IFINDEX 1
> > +
> > +static const unsigned int total_bytes =3D 10 * 1024 * 1024;
> > +static int stop;
> > +
> > +static void *server(void *arg)
> > +{
> > +     int lfd =3D (int)(long)arg, err =3D 0, fd;
> > +     ssize_t nr_sent =3D 0, bytes =3D 0;
> > +     char batch[1500];
> > +
> > +     fd =3D accept(lfd, NULL, NULL);
> > +     while (fd =3D=3D -1) {
> > +             if (errno =3D=3D EINTR)
> > +                     continue;
> > +             err =3D -errno;
> > +             goto done;
> > +     }
> > +
> > +     if (settimeo(fd, 0)) {
> > +             err =3D -errno;
> > +             goto done;
> > +     }
> > +
> > +     while (bytes < total_bytes && !READ_ONCE(stop)) {
> > +             nr_sent =3D send(fd, &batch,
> > +                            MIN(total_bytes - bytes, sizeof(batch)), 0=
);
> > +             if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
> > +                     continue;
> > +             if (nr_sent =3D=3D -1) {
> > +                     err =3D -errno;
> > +                     break;
> > +             }
> > +             bytes +=3D nr_sent;
> > +     }
> > +
> > +     ASSERT_EQ(bytes, total_bytes, "send");
> > +
> > +done:
> > +     if (fd >=3D 0)
> > +             close(fd);
> > +     if (err) {
> > +             WRITE_ONCE(stop, 1);
> > +             return ERR_PTR(err);
> > +     }
> > +     return NULL;
> > +}
> > +
> > +static void do_test(char *qdisc)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex =3D LO_IFINDEX,
> > +                         .attach_point =3D BPF_TC_QDISC,
> > +                         .parent =3D TC_H_ROOT,
> > +                         .handle =3D 0x8000000,
> > +                         .qdisc =3D qdisc);
> > +     struct sockaddr_in6 sa6 =3D {};
> > +     ssize_t nr_recv =3D 0, bytes =3D 0;
> > +     int lfd =3D -1, fd =3D -1;
> > +     pthread_t srv_thread;
> > +     socklen_t addrlen =3D sizeof(sa6);
> > +     void *thread_ret;
> > +     char batch[1500];
> > +     int err;
> > +
> > +     WRITE_ONCE(stop, 0);
> > +
> > +     err =3D bpf_tc_hook_create(&hook);
> > +     if (!ASSERT_OK(err, "attach qdisc"))
> > +             return;
> > +
> > +     lfd =3D start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> > +     if (!ASSERT_NEQ(lfd, -1, "socket")) {
> > +             bpf_tc_hook_destroy(&hook);
> > +             return;
> > +     }
> > +
> > +     fd =3D socket(AF_INET6, SOCK_STREAM, 0);
> > +     if (!ASSERT_NEQ(fd, -1, "socket")) {
> > +             bpf_tc_hook_destroy(&hook);
> > +             close(lfd);
> > +             return;
> > +     }
> > +
> > +     if (settimeo(lfd, 0) || settimeo(fd, 0))
> > +             goto done;
> > +
> > +     err =3D getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
> > +     if (!ASSERT_NEQ(err, -1, "getsockname"))
> > +             goto done;
> > +
> > +     /* connect to server */
> > +     err =3D connect(fd, (struct sockaddr *)&sa6, addrlen);
> > +     if (!ASSERT_NEQ(err, -1, "connect"))
> > +             goto done;
> > +
> > +     err =3D pthread_create(&srv_thread, NULL, server, (void *)(long)l=
fd);
> > +     if (!ASSERT_OK(err, "pthread_create"))
> > +             goto done;
> > +
> > +     /* recv total_bytes */
> > +     while (bytes < total_bytes && !READ_ONCE(stop)) {
> > +             nr_recv =3D recv(fd, &batch,
> > +                            MIN(total_bytes - bytes, sizeof(batch)), 0=
);
> > +             if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
> > +                     continue;
> > +             if (nr_recv =3D=3D -1)
> > +                     break;
> > +             bytes +=3D nr_recv;
> > +     }
> > +
> > +     ASSERT_EQ(bytes, total_bytes, "recv");
> > +
> > +     WRITE_ONCE(stop, 1);
> > +     pthread_join(srv_thread, &thread_ret);
> > +     ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
> > +
> > +done:
> > +     close(lfd);
> > +     close(fd);
> > +
> > +     bpf_tc_hook_destroy(&hook);
> > +     return;
> > +}
> > +
> > +static void test_fifo(void)
> > +{
> > +     struct bpf_qdisc_fifo *fifo_skel;
> > +     struct bpf_link *link;
> > +
> > +     fifo_skel =3D bpf_qdisc_fifo__open_and_load();
> > +     if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
> > +             return;
> > +
> > +     link =3D bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
> > +     if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> > +             bpf_qdisc_fifo__destroy(fifo_skel);
> > +             return;
> > +     }
> > +
> > +     do_test("bpf_fifo");
> > +
> > +     bpf_link__destroy(link);
> > +     bpf_qdisc_fifo__destroy(fifo_skel);
> > +}
> > +
> > +void test_bpf_qdisc(void)
> > +{
> > +     if (test__start_subtest("fifo"))
> > +             test_fifo();
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/too=
ls/testing/selftests/bpf/progs/bpf_qdisc_common.h
> > new file mode 100644
> > index 000000000000..96ab357de28e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> > @@ -0,0 +1,23 @@
> > +#ifndef _BPF_QDISC_COMMON_H
> > +#define _BPF_QDISC_COMMON_H
> > +
> > +#define NET_XMIT_SUCCESS        0x00
> > +#define NET_XMIT_DROP           0x01    /* skb dropped                =
  */
> > +#define NET_XMIT_CN             0x02    /* congestion notification    =
  */
> > +
> > +#define TC_PRIO_CONTROL  7
> > +#define TC_PRIO_MAX      15
> > +
> > +void bpf_skb_set_dev(struct sk_buff *skb, struct Qdisc *sch) __ksym;
> > +u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
> > +void bpf_skb_release(struct sk_buff *p) __ksym;
> > +void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_=
free) __ksym;
> > +void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 de=
lta_ns) __ksym;
> > +bool bpf_qdisc_find_class(struct Qdisc *sch, u32 classid) __ksym;
> > +int bpf_qdisc_create_child(struct Qdisc *sch, u32 min,
> > +                        struct netlink_ext_ack *extack) __ksym;
> > +int bpf_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch, u32 clas=
sid,
> > +                   struct bpf_sk_buff_ptr *to_free_list) __ksym;
> > +struct sk_buff *bpf_qdisc_dequeue(struct Qdisc *sch, u32 classid) __ks=
ym;
> > +
> > +#endif
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools=
/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> > new file mode 100644
> > index 000000000000..433fd9c3639c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
> > @@ -0,0 +1,83 @@
> > +#include <vmlinux.h>
> > +#include "bpf_experimental.h"
> > +#include "bpf_qdisc_common.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +#define private(name) SEC(".data." #name) __hidden __attribute__((alig=
ned(8)))
> > +
> > +private(B) struct bpf_spin_lock q_fifo_lock;
> > +private(B) struct bpf_list_head q_fifo __contains_kptr(sk_buff, bpf_li=
st);
> > +
> > +unsigned int q_limit =3D 1000;
> > +unsigned int q_qlen =3D 0;
> > +
> > +SEC("struct_ops/bpf_fifo_enqueue")
> > +int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
> > +          struct bpf_sk_buff_ptr *to_free)
> > +{
> > +     q_qlen++;
> > +     if (q_qlen > q_limit) {
> > +             bpf_qdisc_skb_drop(skb, to_free);
> > +             return NET_XMIT_DROP;
> > +     }
>
> [..]
>
> > +     bpf_spin_lock(&q_fifo_lock);
> > +     bpf_list_excl_push_back(&q_fifo, &skb->bpf_list);
> > +     bpf_spin_unlock(&q_fifo_lock);
>
> Can you also expand a bit on the locking here and elsewhere? And how it
> interplays with TCQ_F_NOLOCK?
>
> As I mentioned at lsfmmbpf, I don't think there is a lot of similar
> locking in the existing C implementations? So why do we need it here?

The locks are required to prevent catastrophic concurrent accesses to
bpf graphs. The verifier will check 1) if there is a spin_lock in the
same struct with a list head or rbtree root, and 2) the lock is held
when accessing the list or rbtree.

Since we have the safety guarantee provided by the verifier, I think
there is an opportunity to allow qdisc users to set TCQ_F_NOLOCK. I will
check if qdisc kfuncs are TCQ_F_NOLOCK safe though. Let me know if I
missed anything.

Thanks,
Amery

