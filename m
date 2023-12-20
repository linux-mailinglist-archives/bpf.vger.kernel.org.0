Return-Path: <bpf+bounces-18350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184EE819532
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 01:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7C1C24743
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D3E23C4;
	Wed, 20 Dec 2023 00:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrLEakRO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7246B0;
	Wed, 20 Dec 2023 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3366e78d872so2292326f8f.3;
        Tue, 19 Dec 2023 16:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703031959; x=1703636759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8SdDvE7M57yXe3BWZ3ZcRgxoEXpwC009EWtj4naDlo=;
        b=jrLEakROWtxFBmVftDc2CjXqf45zvlK0KCawG+cOgc+pdrufluELINqqlzG7yL5nQw
         ZthEkKrHb2UOXVyL3Khh/773a9eSdy/dL4KJFXyhsofjXS2irjv3Fpboc2bg+UJKQJ82
         rIAsYIEgUoWOPd2VgrhzL/XdN/Ct17u6gxa6VHnccpMzC7XkL27VnMsMNJYuB+vAdQRw
         8JrLYbwkIK0pGeVwpAnTkVzEExUCbBV6mAWVnSBmKlBmgQFizcXlxfEoYcu+bpRWYgan
         QrUh+vo3mqfpISd5k2OaCWxSnCKBMEVeGo7euKfS9V5u9j5MV4/teha6/mP0zjRQnEm3
         EHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031959; x=1703636759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8SdDvE7M57yXe3BWZ3ZcRgxoEXpwC009EWtj4naDlo=;
        b=SOnhzwaXhkbu66rg5X5cnfdMK8dzxGKDHigVqL/wDwpDe2GcNQjptVdrxu9tMBxFtt
         hVI9i5EIL688j1Ptk6LbixYSfaoitTk1CkPFpd/eiagN7OLE8NSmTzOBl08tlsqHzqz2
         wcdFMFnwJhNo/0tHja2/45S3pLQ9hYX0TdLDWjZQd/Q+afJdi/BaP5c1YqKEzmAoXuE5
         IVGUt+sQpbA8J8U+ABYUNwK6V5XZOoR5d0oWnUm91IBbmfdiG966p/kdKNxwhQ2o7elV
         wyz7HUSSsbQhQe3+P8BtAaXEoxolJKjd9sCXMA1YKN03lMytQgb0qoUefU9fXFufljtJ
         v0/Q==
X-Gm-Message-State: AOJu0YzMwikWSRUQ3v6CQ7xsqCdC+/CPsgVnUepGJNn297pfTjewz+n4
	2G02Z8sxAz/rZY/KKUxNCNdg4tuiVhv2kYb3Aio=
X-Google-Smtp-Source: AGHT+IEKMRJ2A/8k+HFec9JVztktWh1oH4gjUHQQ0P51MbeujpIkHXJ7CzFF2BpdFy049M782P4CbjjYU8rKwgPQOXw=
X-Received: by 2002:adf:e9c6:0:b0:336:5fb5:b5b with SMTP id
 l6-20020adfe9c6000000b003365fb50b5bmr1843366wrn.109.1703031958902; Tue, 19
 Dec 2023 16:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215171020.687342-1-bigeasy@linutronix.de> <20231215171020.687342-16-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-16-bigeasy@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 16:25:47 -0800
Message-ID: <CAADnVQKJBpvfyvmgM29FLv+KpLwBBRggXWzwKzaCT9U-4bgxjA@mail.gmail.com>
Subject: Re: [PATCH net-next 15/24] net: Use nested-BH locking for XDP redirect.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Ronak Doshi <doshir@vmware.com>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 9:10=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5a0f6da7b3ae5..5ba7509e88752 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3993,6 +3993,7 @@ sch_handle_ingress(struct sk_buff *skb, struct pack=
et_type **pt_prev, int *ret,
>                 *pt_prev =3D NULL;
>         }
>
> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>         qdisc_skb_cb(skb)->pkt_len =3D skb->len;
>         tcx_set_ingress(skb, true);
>
> @@ -4045,6 +4046,7 @@ sch_handle_egress(struct sk_buff *skb, int *ret, st=
ruct net_device *dev)
>         if (!entry)
>                 return skb;
>
> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>         /* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
>          * already set by the caller.
>          */
> @@ -5008,6 +5010,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struc=
t sk_buff *skb)
>                 u32 act;
>                 int err;
>
> +               guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>                 act =3D netif_receive_generic_xdp(skb, &xdp, xdp_prog);
>                 if (act !=3D XDP_PASS) {
>                         switch (act) {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7c9653734fb60..72a7812f933a1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4241,6 +4241,7 @@ static const struct bpf_func_proto bpf_xdp_adjust_m=
eta_proto =3D {
>   */
>  void xdp_do_flush(void)
>  {
> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>         __dev_flush();
>         __cpu_map_flush();
>         __xsk_map_flush();
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index a94943681e5aa..74b88e897a7e3 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -44,6 +44,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_=
lwt_prog *lwt,
>          * BPF prog and skb_do_redirect().
>          */
>         local_bh_disable();
> +       local_lock_nested_bh(&bpf_run_lock.redirect_lock);
>         bpf_compute_data_pointers(skb);
>         ret =3D bpf_prog_run_save_cb(lwt->prog, skb);
>
> @@ -76,6 +77,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_=
lwt_prog *lwt,
>                 break;
>         }
>
> +       local_unlock_nested_bh(&bpf_run_lock.redirect_lock);
>         local_bh_enable();
>
>         return ret;
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 1976bd1639863..da61b99bc558f 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -23,6 +23,7 @@
>  #include <linux/jhash.h>
>  #include <linux/rculist.h>
>  #include <linux/rhashtable.h>
> +#include <linux/bpf.h>
>  #include <net/net_namespace.h>
>  #include <net/sock.h>
>  #include <net/netlink.h>
> @@ -3925,6 +3926,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent=
 *qe, struct Qdisc *sch, stru
>
>         fl =3D rcu_dereference_bh(qe->filter_chain);
>
> +       guard(local_lock_nested_bh)(&bpf_run_lock.redirect_lock);
>         switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
>         case TC_ACT_SHOT:
>                 qdisc_qstats_drop(sch);

Here and in all other places this patch adds locks that
will kill performance of XDP, tcx and everything else in networking.

I'm surprised Jesper and other folks are not jumping in with nacks.
We measure performance in nanoseconds here.
Extra lock is no go.
Please find a different way without ruining performance.

