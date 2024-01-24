Return-Path: <bpf+bounces-20197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DEA83A14B
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 06:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BA51C27584
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 05:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318ADF4C;
	Wed, 24 Jan 2024 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAh1mW34"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5CD2F5;
	Wed, 24 Jan 2024 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073741; cv=none; b=m1vgvke/D42fwZb91YHbz50uzv4lBFXfw6MMCR1xR/sU8oXvSpEQ3MjKNCtC9A3yjHQs8bx5rpvmMQ5OrVr4drtd7jIhQVVq33EKcL7r9GwBRJ0OzwyXUKpHx++e6idVRmVSn4UoWtOosXdgqAHRvsaKQ154K0d5SqnLboauy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073741; c=relaxed/simple;
	bh=7XuOVzQBfFufesNIi8X9xjheTA+kngXyRFzCuhRl+sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFVXVb/6BYms0T87jNvER7HeOwZHclHLcwLAGJ18+g3XuCFPWE+pyfjLe7JYW7D2S9jWOHp9bcxj+tR5lzLZhXPRvtvi6j/QzV3ntz3yKOkomma4lraJP2mujMfN2BWllXlPHHNnnu5k8XXPP1xwcf2SWWzO/XQGaMTJjuDmcrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAh1mW34; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff7dc53ce0so37368767b3.1;
        Tue, 23 Jan 2024 21:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706073738; x=1706678538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIX+uqd+mzJsB6v+Eg3zoj7jr9qeqvKZegg1p3EvbLQ=;
        b=QAh1mW34NG10z+8iVq10J74oXxpugo3m6bCtq/1xKknIEonREYlmY1KDo5m8r4kao4
         SolCUfsMFkT0G724seONiMkelSGvXp5xIGp3Sn2MbUNJ4c7gOL0GGRWF2+SNJ+k/xKSt
         GAL4o35SWIbTXfm6TSI7AC2ikSndztxvu/SSF0eCjfQ+oFkYHvAhfUa7O0Y7fPcva+Dx
         0JY0C1gVpwnYQ6BNaskFABAPDtjtNj5NWzji9E9am3fUF5ZHmzrvWqDorYT1mMNoZAAg
         I1TxndDuJ7N/tOzM3V5njiuIoWEMK4TAhqkt5U6b3keQFssP/TSCu7o4oLyIc0a4zgEc
         3W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706073738; x=1706678538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIX+uqd+mzJsB6v+Eg3zoj7jr9qeqvKZegg1p3EvbLQ=;
        b=ZitMJMZjYnZarVn0WClLmrg5eEjPi5L1C7bsa2PvkF8ozOD/67+JR+3llWfnBzIJfO
         v0vK6GssLskNkjQoPUAP90+VhhF5ZT7uO0RKd2YAeCR527ROMiyNCV+VJohTe6WGjT53
         t7s/QNqA0ZutEjxjwxIuC0O7Aw9ag1gJHYvKpGfUSnyxSk0Q76rDvFwYCOV/4LF/r9yf
         CepsOmPz1FheKnrawyfQ+Sm4t7XDiFuItEKhiDWLnShIjjfIl+tZMHB+5ol1kNf6xDFy
         bp/NKwAGMCzCNIcgWa9Y5wCn9CG8fEkCxW/g74x5tbn7pEuWjgRXY2K8GgFC33DzWvgg
         MimA==
X-Gm-Message-State: AOJu0YzoUWwLEO+Ujwc1hXMjLQgWyrpBnRIP2DOSpXzEXQ/10yjh4igF
	S4NZ2JDO7B205yWNf9UoKhn4QnqWQmdvytPy4ND8Y1p3Pv6Va6g80Rjdbwmtw3/aZJiFSmopmW5
	t+iRDU00vaoEpxCP90BU4T2A2MwEzUheprRg=
X-Google-Smtp-Source: AGHT+IEFsRzUPC8FgriRq1zk8q/cSldD4KrO9Wy39+/TvsRaLutfRTd1+ZyOhGfjXvGT15K6FxN+S6lhKNMyIneR5Cg=
X-Received: by 2002:a25:9390:0:b0:dbe:2063:72b9 with SMTP id
 a16-20020a259390000000b00dbe206372b9mr103656ybm.50.1706073738425; Tue, 23 Jan
 2024 21:22:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
 <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev>
In-Reply-To: <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 23 Jan 2024 21:22:07 -0800
Message-ID: <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com, 
	jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:51=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/17/24 1:56 PM, Amery Hung wrote:
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 0bb92414c036..df280bbb7c0d 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -997,6 +997,7 @@ enum bpf_prog_type {
> >       BPF_PROG_TYPE_SK_LOOKUP,
> >       BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
> >       BPF_PROG_TYPE_NETFILTER,
> > +     BPF_PROG_TYPE_QDISC,
> >   };
> >
> >   enum bpf_attach_type {
> > @@ -1056,6 +1057,8 @@ enum bpf_attach_type {
> >       BPF_CGROUP_UNIX_GETSOCKNAME,
> >       BPF_NETKIT_PRIMARY,
> >       BPF_NETKIT_PEER,
> > +     BPF_QDISC_ENQUEUE,
> > +     BPF_QDISC_DEQUEUE,
> >       __MAX_BPF_ATTACH_TYPE
> >   };
> >
> > @@ -7357,4 +7360,22 @@ struct bpf_iter_num {
> >       __u64 __opaque[1];
> >   } __attribute__((aligned(8)));
> >
> > +struct bpf_qdisc_ctx {
> > +     __bpf_md_ptr(struct sk_buff *, skb);
> > +     __u32 classid;
> > +     __u64 expire;
> > +     __u64 delta_ns;
> > +};
> > +
> > +enum {
> > +     SCH_BPF_QUEUED,
> > +     SCH_BPF_DEQUEUED =3D SCH_BPF_QUEUED,
> > +     SCH_BPF_DROP,
> > +     SCH_BPF_CN,
> > +     SCH_BPF_THROTTLE,
> > +     SCH_BPF_PASS,
> > +     SCH_BPF_BYPASS,
> > +     SCH_BPF_STOLEN,
> > +};
> > +
> >   #endif /* _UAPI__LINUX_BPF_H__ */
>
> [ ... ]
>
> > +static bool tc_qdisc_is_valid_access(int off, int size,
> > +                                  enum bpf_access_type type,
> > +                                  const struct bpf_prog *prog,
> > +                                  struct bpf_insn_access_aux *info)
> > +{
> > +     struct btf *btf;
> > +
> > +     if (off < 0 || off >=3D sizeof(struct bpf_qdisc_ctx))
> > +             return false;
> > +
> > +     switch (off) {
> > +     case offsetof(struct bpf_qdisc_ctx, skb):
> > +             if (type =3D=3D BPF_WRITE ||
> > +                 size !=3D sizeof_field(struct bpf_qdisc_ctx, skb))
> > +                     return false;
> > +
> > +             if (prog->expected_attach_type !=3D BPF_QDISC_ENQUEUE)
> > +                     return false;
> > +
> > +             btf =3D bpf_get_btf_vmlinux();
> > +             if (IS_ERR_OR_NULL(btf))
> > +                     return false;
> > +
> > +             info->btf =3D btf;
> > +             info->btf_id =3D tc_qdisc_ctx_access_btf_ids[0];
> > +             info->reg_type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
> > +             return true;
> > +     case bpf_ctx_range(struct bpf_qdisc_ctx, classid):
> > +             return size =3D=3D sizeof_field(struct bpf_qdisc_ctx, cla=
ssid);
> > +     case bpf_ctx_range(struct bpf_qdisc_ctx, expire):
> > +             return size =3D=3D sizeof_field(struct bpf_qdisc_ctx, exp=
ire);
> > +     case bpf_ctx_range(struct bpf_qdisc_ctx, delta_ns):
> > +             return size =3D=3D sizeof_field(struct bpf_qdisc_ctx, del=
ta_ns);
> > +     default:
> > +             return false;
> > +     }
> > +
> > +     return false;
> > +}
> > +
>
> [ ... ]
>
> > +static int sch_bpf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> > +                        struct sk_buff **to_free)
> > +{
> > +     struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +     unsigned int len =3D qdisc_pkt_len(skb);
> > +     struct bpf_qdisc_ctx ctx =3D {};
> > +     int res =3D NET_XMIT_SUCCESS;
> > +     struct sch_bpf_class *cl;
> > +     struct bpf_prog *enqueue;
> > +
> > +     enqueue =3D rcu_dereference(q->enqueue_prog.prog);
> > +     if (!enqueue)
> > +             return NET_XMIT_DROP;
> > +
> > +     ctx.skb =3D skb;
> > +     ctx.classid =3D sch->handle;
> > +     res =3D bpf_prog_run(enqueue, &ctx);
> > +     switch (res) {
> > +     case SCH_BPF_THROTTLE:
> > +             qdisc_watchdog_schedule_range_ns(&q->watchdog, ctx.expire=
, ctx.delta_ns);
> > +             qdisc_qstats_overlimit(sch);
> > +             fallthrough;
> > +     case SCH_BPF_QUEUED:
> > +             qdisc_qstats_backlog_inc(sch, skb);
> > +             return NET_XMIT_SUCCESS;
> > +     case SCH_BPF_BYPASS:
> > +             qdisc_qstats_drop(sch);
> > +             __qdisc_drop(skb, to_free);
> > +             return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> > +     case SCH_BPF_STOLEN:
> > +             __qdisc_drop(skb, to_free);
> > +             return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
> > +     case SCH_BPF_CN:
> > +             return NET_XMIT_CN;
> > +     case SCH_BPF_PASS:
> > +             break;
> > +     default:
> > +             return qdisc_drop(skb, sch, to_free);
> > +     }
> > +
> > +     cl =3D sch_bpf_find(sch, ctx.classid);
> > +     if (!cl || !cl->qdisc)
> > +             return qdisc_drop(skb, sch, to_free);
> > +
> > +     res =3D qdisc_enqueue(skb, cl->qdisc, to_free);
> > +     if (res !=3D NET_XMIT_SUCCESS) {
> > +             if (net_xmit_drop_count(res)) {
> > +                     qdisc_qstats_drop(sch);
> > +                     cl->drops++;
> > +             }
> > +             return res;
> > +     }
> > +
> > +     sch->qstats.backlog +=3D len;
> > +     sch->q.qlen++;
> > +     return res;
> > +}
> > +
> > +DEFINE_PER_CPU(struct sk_buff*, bpf_skb_dequeue);
> > +
> > +static struct sk_buff *sch_bpf_dequeue(struct Qdisc *sch)
> > +{
> > +     struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +     struct bpf_qdisc_ctx ctx =3D {};
> > +     struct sk_buff *skb =3D NULL;
> > +     struct bpf_prog *dequeue;
> > +     struct sch_bpf_class *cl;
> > +     int res;
> > +
> > +     dequeue =3D rcu_dereference(q->dequeue_prog.prog);
> > +     if (!dequeue)
> > +             return NULL;
> > +
> > +     __this_cpu_write(bpf_skb_dequeue, NULL);
> > +     ctx.classid =3D sch->handle;
> > +     res =3D bpf_prog_run(dequeue, &ctx);
> > +     switch (res) {
> > +     case SCH_BPF_DEQUEUED:
> > +             skb =3D __this_cpu_read(bpf_skb_dequeue);
> > +             qdisc_bstats_update(sch, skb);
> > +             qdisc_qstats_backlog_dec(sch, skb);
> > +             break;
> > +     case SCH_BPF_THROTTLE:
> > +             qdisc_watchdog_schedule_range_ns(&q->watchdog, ctx.expire=
, ctx.delta_ns);
> > +             qdisc_qstats_overlimit(sch);
> > +             cl =3D sch_bpf_find(sch, ctx.classid);
> > +             if (cl)
> > +                     cl->overlimits++;
> > +             return NULL;
> > +     case SCH_BPF_PASS:
> > +             cl =3D sch_bpf_find(sch, ctx.classid);
> > +             if (!cl || !cl->qdisc)
> > +                     return NULL;
> > +             skb =3D qdisc_dequeue_peeked(cl->qdisc);
> > +             if (skb) {
> > +                     bstats_update(&cl->bstats, skb);
> > +                     qdisc_bstats_update(sch, skb);
> > +                     qdisc_qstats_backlog_dec(sch, skb);
> > +                     sch->q.qlen--;
> > +             }
> > +             break;
> > +     }
> > +
> > +     return skb;
> > +}
>
> [ ... ]
>
> > +static int sch_bpf_init(struct Qdisc *sch, struct nlattr *opt,
> > +                     struct netlink_ext_ack *extack)
> > +{
> > +     struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +     int err;
> > +
> > +     qdisc_watchdog_init(&q->watchdog, sch);
> > +     if (opt) {
> > +             err =3D sch_bpf_change(sch, opt, extack);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     err =3D tcf_block_get(&q->block, &q->filter_list, sch, extack);
> > +     if (err)
> > +             return err;
> > +
> > +     return qdisc_class_hash_init(&q->clhash);
> > +}
> > +
> > +static void sch_bpf_reset(struct Qdisc *sch)
> > +{
> > +     struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +     struct sch_bpf_class *cl;
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < q->clhash.hashsize; i++) {
> > +             hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode=
) {
> > +                     if (cl->qdisc)
> > +                             qdisc_reset(cl->qdisc);
> > +             }
> > +     }
> > +
> > +     qdisc_watchdog_cancel(&q->watchdog);
> > +}
> > +
>
> [ ... ]
>
> > +static const struct Qdisc_class_ops sch_bpf_class_ops =3D {
> > +     .graft          =3D       sch_bpf_graft,
> > +     .leaf           =3D       sch_bpf_leaf,
> > +     .find           =3D       sch_bpf_search,
> > +     .change         =3D       sch_bpf_change_class,
> > +     .delete         =3D       sch_bpf_delete,
> > +     .tcf_block      =3D       sch_bpf_tcf_block,
> > +     .bind_tcf       =3D       sch_bpf_bind,
> > +     .unbind_tcf     =3D       sch_bpf_unbind,
> > +     .dump           =3D       sch_bpf_dump_class,
> > +     .dump_stats     =3D       sch_bpf_dump_class_stats,
> > +     .walk           =3D       sch_bpf_walk,
> > +};
> > +
> > +static struct Qdisc_ops sch_bpf_qdisc_ops __read_mostly =3D {
> > +     .cl_ops         =3D       &sch_bpf_class_ops,
> > +     .id             =3D       "bpf",
> > +     .priv_size      =3D       sizeof(struct bpf_sched_data),
> > +     .enqueue        =3D       sch_bpf_enqueue,
> > +     .dequeue        =3D       sch_bpf_dequeue,
>
> I looked at the high level of the patchset. The major ops that it wants t=
o be
> programmable in bpf is the ".enqueue" and ".dequeue" (+ ".init" and ".res=
et" in
> patch 4 and patch 5).
>
> This patch adds a new prog type BPF_PROG_TYPE_QDISC, four attach types (e=
ach for
> ".enqueue", ".dequeue", ".init", and ".reset"), and a new "bpf_qdisc_ctx"=
 in the
> uapi. It is no long an acceptable way to add new bpf extension.
>
> Can the ".enqueue", ".dequeue", ".init", and ".reset" be completely imple=
mented
> in bpf (with the help of new kfuncs if needed)? Then a struct_ops for Qdi=
sc_ops
> can be created. The bpf Qdisc_ops can be loaded through the existing stru=
ct_ops api.
>

Partially. If using struct_ops, I think we'll need another structure
like the following in bpf qdisc to be implemented with struct_ops bpf:

struct bpf_qdisc_ops {
    int (*enqueue) (struct sk_buff *skb)
    void (*dequeue) (void)
    void (*init) (void)
    void (*reset) (void)
};

Then, Qdisc_ops will wrap around them to handle things that cannot be
implemented with bpf (e.g., sch_tree_lock, returning a skb ptr).

> If other ops (like ".dump", ".dump_stats"...) do not have good use case t=
o be
> programmable in bpf, it can stay with the kernel implementation for now a=
nd only
> allows the userspace to load the a bpf Qdisc_ops with .equeue/dequeue/ini=
t/reset
> implemented.
>
> You mentioned in the cover letter that:
> "Current struct_ops attachment model does not seem to support replacing o=
nly
> functions of a specific instance of a module, but I might be wrong."
>
> I assumed you meant allow bpf to replace only "some" ops of the Qdisc_ops=
? Yes,
> it can be done through the struct_ops's ".init_member". Take a look at
> bpf_tcp_ca_init_member. The kernel can assign the kernel implementation f=
or
> ".dump" (for example) when loading the bpf Qdisc_ops.
>

I have no problem with partially replacing a struct, which like you
mentioned has been demonstrated by congestion control or sched_ext.
What I am not sure about is the ability to create multiple bpf qdiscs,
where each has different ".enqueue", ".dequeue", and so on. I like the
struct_ops approach and would love to try it if struct_ops support
this.

Thanks,
Amery



> > +     .peek           =3D       qdisc_peek_dequeued,
> > +     .init           =3D       sch_bpf_init,
> > +     .reset          =3D       sch_bpf_reset, > +      .destroy       =
 =3D       sch_bpf_destroy,
> > +     .change         =3D       sch_bpf_change,
> > +     .dump           =3D       sch_bpf_dump,
> > +     .dump_stats     =3D       sch_bpf_dump_stats,
> > +     .owner          =3D       THIS_MODULE,
> > +};
> > +
> > +static int __init sch_bpf_mod_init(void)
> > +{
> > +     return register_qdisc(&sch_bpf_qdisc_ops);
> > +}
> > +
> > +static void __exit sch_bpf_mod_exit(void)
> > +{
> > +     unregister_qdisc(&sch_bpf_qdisc_ops);
> > +}
>

