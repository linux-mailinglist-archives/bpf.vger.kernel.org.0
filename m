Return-Path: <bpf+bounces-41748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A099A7F1
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DDB1C23804
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85154195F22;
	Fri, 11 Oct 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz1nV54j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F55381E;
	Fri, 11 Oct 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661072; cv=none; b=g/Mx9X0Sum2QLeoBiDZPSt/ZsPpIxM7cXuNs7yu1m2yY1AtqaHqEwHohz261pZdbl9gb0Q50VqW2C6wjUc3KVN9NGC1QB+7xPbT5oBNX/Cd2k+mXUp77d8xLnARmw4NiGQD2/omC0n/LD6M2IaJUDn/mH0xXqwhrY71qVRHHpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661072; c=relaxed/simple;
	bh=+W3hpc8PuHB/i38mGy7dgItbEIaIdWFPzAOfaW2RjFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sdef4EE0BYwXxvdPjimycZ/ZAIzozL8JizAH12Of+lCTVKlPsHyAGqPikCQ+bhqKMN0v5F8r3k7U2iHaJG/pZouE+2dKATNBtXGIRssv1htuo/b4e1IaZX7Su59yNzIamY/74BvId96pvTOy3xwvUKXqPaZtRnSMWWKLmAgIn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz1nV54j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431195c3538so13327155e9.3;
        Fri, 11 Oct 2024 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728661068; x=1729265868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1b6TlZen7Ia42IhglOx0HiKoBm+1RyFLQaTM4mr6xo=;
        b=Lz1nV54jPk20Be5uosdG4NeeUs/GbqvjNE5ZX9k9al6hFICgpbgNQojRu9tGV76wUe
         67QYigxSsp+5B7dkdmJBgUdF+jCwKld3vf/FUmNMW7i9d5DgcQXiAs3zy8//r3jymT4f
         8ptERn9utzQF/g/9CsGkkfKz9ufJjrFBnYTyZIastFic7yl/xtfpG7hy1VCkuOOqK0v/
         uG8UY165dBKCGTWunA9H6yyU7MAN2YxtaeqWduzMGQMOd5AK8T6/w8+OjY9g+xk5iQ0v
         6jE9rR/qxsXS/fdrUHmP2X2HkooxjA/mA/0HWOjNHmh/W+xjdor7rXosAvEd9/+a5Oo6
         pfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661068; x=1729265868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1b6TlZen7Ia42IhglOx0HiKoBm+1RyFLQaTM4mr6xo=;
        b=utYjCQinMVYDEzevvNkWAKNAE4xnv5zFY0Uqp2mPQphCaTvkj/0xAVW8M2Z53mukBm
         uYIMUajhula3kutdIrmisx9RYNBrcHUSeSCytWZ0U7pu4rQPWZomVWX3Xw/vShMfFFaD
         SQfwtqBQMNRbI3QXUi7rQieBVU43NO7CPbPWzLZlEGAY6PtjNRH5bagy33W5PHkCb4wC
         UT6et/Uo/lDFgwHeRtBr68SqzvHtp1+2s3w5u/2xD47LKpasz6Kkhk5vxtq8q2rVxOdG
         li8B/6Y/SYbSE6eVVLtyGF+FbcO1XWk4zMMMYi1S5HntJxsEAqGEa8ajzs9ToW2yeYBJ
         Tukg==
X-Forwarded-Encrypted: i=1; AJvYcCUg/FSMrqfbXN+sNZB+gULYSfjc3HXob4u+R1hk/KJQVLa63WtNbvo+3WTNEW2vqCkBV3nQsiCP@vger.kernel.org, AJvYcCW4a017UTQW3gdOITv2q9P1SbymvMJHROYiqy0Dy3RkVJ7qoYlqKrtS/jRi2TFQkA24zSnTOpCmcGTiEQ==@vger.kernel.org, AJvYcCWVzbeDuF3WACr2U2mfAoi/5m6oEBhQY00z7R6l6IyEvAhHuqcCoUCV+oG/0WrWutv4wKXpc0HEZIqzmw==@vger.kernel.org, AJvYcCXclAy0/djYpz3ZQqfx2eizVLVOjg3AJgSyuFoEhJSCvVvVyhfpPl/NOigt5Ad/aGv2yfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2+7CAsgec+oIMtoVq3ZhJf2GFne8f7zbo9YuEnIsSl4aM6cy
	STeGzda8g9ZTOvodG4/WG1adyaDLBxmW9qs0gDjxJPPzeq10iDtvAVQTSzfeY6Ycl7DABGyIvq3
	oR6mbBuzDsl8qOwN8Sz29XOgDCt4=
X-Google-Smtp-Source: AGHT+IFBujBf24C+TdOw4hxN/Gfp364N9yqIv2KFhsg2hN4+AHihtNmKnlaalKG/EPnrjqaau9UjVAJFEMLSWbYRIuY=
X-Received: by 2002:a05:600c:1c19:b0:431:1513:34a5 with SMTP id
 5b1f17b1804b1-4311df474a0mr22390925e9.23.1728661068259; Fri, 11 Oct 2024
 08:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728532691-20044-1-git-send-email-alibuda@linux.alibaba.com>
 <CAADnVQLXyA__zdDSiTdhaw=dXyfgmkr--cH068JvNK=JAYvRDA@mail.gmail.com> <b5aa477d-a4b1-45cb-af44-bd737504734e@linux.alibaba.com>
In-Reply-To: <b5aa477d-a4b1-45cb-af44-bd737504734e@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Oct 2024 08:37:36 -0700
Message-ID: <CAADnVQLS69MVZwTrek=ixP+1T7=+Fq0_kuOKgqBS+o4UoXMxFw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/smc: Introduce a hook to modify syn_smc at runtime
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	wintera@linux.ibm.com, guwen@linux.alibaba.com, 
	Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, linux-rdma@vger.kernel.org, 
	Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:44=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.co=
m> wrote:
>
>
>
> On 10/11/24 12:21 AM, Alexei Starovoitov wrote:
> > On Wed, Oct 9, 2024 at 8:58=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.=
com> wrote:
> >>
> >>
> >> +__bpf_hook_start();
> >> +
> >> +__weak noinline int select_syn_smc(const struct sock *sk, struct sock=
addr *peer)
> >> +{
> >> +       return 1;
> >> +}
> >> +
> >> +__bpf_hook_end();
> >> +
> >>   int smc_nl_dump_hs_limitation(struct sk_buff *skb, struct netlink_ca=
llback *cb)
> >>   {
> >>          struct smc_nl_dmp_ctx *cb_ctx =3D smc_nl_dmp_ctx(cb);
> >> @@ -156,19 +165,43 @@ static struct sock *smc_tcp_syn_recv_sock(const =
struct sock *sk,
> >>          return NULL;
> >>   }
> >>
> >> -static bool smc_hs_congested(const struct sock *sk)
> >> +static void smc_openreq_init(struct request_sock *req,
> >> +                            const struct tcp_options_received *rx_opt=
,
> >> +                            struct sk_buff *skb, const struct sock *s=
k)
> >>   {
> >> +       struct inet_request_sock *ireq =3D inet_rsk(req);
> >> +       struct sockaddr_storage rmt_sockaddr =3D {};
> >>          const struct smc_sock *smc;
> >>
> >>          smc =3D smc_clcsock_user_data(sk);
> >>
> >>          if (!smc)
> >> -               return true;
> >> +               return;
> >>
> >> -       if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
> >> -               return true;
> >> +       if (smc->limit_smc_hs && workqueue_congested(WORK_CPU_UNBOUND,=
 smc_hs_wq))
> >> +               goto out_no_smc;
> >>
> >> -       return false;
> >> +       rmt_sockaddr.ss_family =3D sk->sk_family;
> >> +
> >> +       if (rmt_sockaddr.ss_family =3D=3D AF_INET) {
> >> +               struct sockaddr_in *rmt4_sockaddr =3D  (struct sockadd=
r_in *)&rmt_sockaddr;
> >> +
> >> +               rmt4_sockaddr->sin_addr.s_addr =3D ireq->ir_rmt_addr;
> >> +               rmt4_sockaddr->sin_port =3D ireq->ir_rmt_port;
> >> +#if IS_ENABLED(CONFIG_IPV6)
> >> +       } else {
> >> +               struct sockaddr_in6 *rmt6_sockaddr =3D  (struct sockad=
dr_in6 *)&rmt_sockaddr;
> >> +
> >> +               rmt6_sockaddr->sin6_addr =3D ireq->ir_v6_rmt_addr;
> >> +               rmt6_sockaddr->sin6_port =3D ireq->ir_rmt_port;
> >> +#endif /* CONFIG_IPV6 */
> >> +       }
> >> +
> >> +       ireq->smc_ok =3D select_syn_smc(sk, (struct sockaddr *)&rmt_so=
ckaddr);
> >> +       return;
> >> +out_no_smc:
> >> +       ireq->smc_ok =3D 0;
> >> +       return;
> >>   }
> >>
> >>   struct smc_hashinfo smc_v4_hashinfo =3D {
> >> @@ -1671,7 +1704,7 @@ int smc_connect(struct socket *sock, struct sock=
addr *addr,
> >>          }
> >>
> >>          smc_copy_sock_settings_to_clc(smc);
> >> -       tcp_sk(smc->clcsock->sk)->syn_smc =3D 1;
> >> +       tcp_sk(smc->clcsock->sk)->syn_smc =3D select_syn_smc(sk, addr)=
;
> >>          if (smc->connect_nonblock) {
> >>                  rc =3D -EALREADY;
> >>                  goto out;
> >> @@ -2650,8 +2683,7 @@ int smc_listen(struct socket *sock, int backlog)
> >>
> >>          inet_csk(smc->clcsock->sk)->icsk_af_ops =3D &smc->af_ops;
> >>
> >> -       if (smc->limit_smc_hs)
> >> -               tcp_sk(smc->clcsock->sk)->smc_hs_congested =3D smc_hs_=
congested;
> >> +       tcp_sk(smc->clcsock->sk)->smc_openreq_init =3D smc_openreq_ini=
t;
> >>
> >>          rc =3D kernel_listen(smc->clcsock, backlog);
> >>          if (rc) {
> >> @@ -3475,6 +3507,24 @@ static void __net_exit smc_net_stat_exit(struct=
 net *net)
> >>          .exit =3D smc_net_stat_exit,
> >>   };
> >>
> >> +#if IS_ENABLED(CONFIG_BPF_SYSCALL)
> >> +BTF_SET8_START(bpf_smc_fmodret_ids)
> >> +BTF_ID_FLAGS(func, select_syn_smc)
> >> +BTF_SET8_END(bpf_smc_fmodret_ids)
> >> +
> >> +static const struct btf_kfunc_id_set bpf_smc_fmodret_set =3D {
> >> +       .owner =3D THIS_MODULE,
> >> +       .set   =3D &bpf_smc_fmodret_ids,
> >> +};
> >> +
> >> +static int bpf_smc_kfunc_init(void)
> >> +{
> >> +       return register_btf_fmodret_id_set(&bpf_smc_fmodret_set);
> >> +}
> >
> > fmodret was an approach that hid-bpf took initially,
> > but eventually they removed it all and switched to struct-ops approach.
> > Please learn that lesson.
> > Use struct_ops from the beginning.
> >
> > I did a presentation recently explaining the motivation behind
> > struct_ops and tips on how to extend the kernel.
> > TLDR: the step one is to design the extension _without_ bpf.
> > The interface should be usable for kernel modules.
> > And then when you have *_ops style api in place
> > the bpf progs will plug-in without extra work.
> >
> > Slides:
> > https://github.com/4ast/docs/blob/main/BPF%20struct-ops.pdf
>
>
> Hi Alexei,
>
> Thanks very much for your suggestion.
>
> In fact, I tried struct_ops in SMC about a year ago. Unfortunately, at th=
at time struct_ops did not
> support registration from modules, and I had to move some smc dependencie=
s into bpf, which met with
> community opposition. However, I noticed that this feature is now support=
ed, so perhaps this is an
> opportunity.
>
> But on the other hand, given the current functionality, I wonder if struc=
t_ops might be an overkill.
> I haven't been able to come up with a suitable abstraction to define this=
 ops, and in the future,
> this ops might only contain the very one callback (select_syn_smc).
>
> Looking forward for your advises.

I guess I wasn't clear. It's a Nack to the current fmodret approach.

