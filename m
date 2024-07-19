Return-Path: <bpf+bounces-35108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE1937C68
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FA21F21BCE
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689D1474A7;
	Fri, 19 Jul 2024 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeSghAU/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC9B657;
	Fri, 19 Jul 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413268; cv=none; b=a2H4XIQvMUOmW0o7U+umN5eMqsaaLWzesla64SNdBO/NzXmo8f4XpTaZd3mgsXXKvxYkVOV6Ot44B7c/TCsGttyP4V1b0v3C1lGOlzQBrflWR/bdpQ2TtLkzzMXTcoVLUJEegQGXJMpQIp0IPVR0waKX/ObNdm6UxD/FODqar2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413268; c=relaxed/simple;
	bh=VjRN94vhgfCfMB0gvhqgDvZXC7fzHFkNXxGL0r7YfYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCgdzP86gtOsXVj0MBfqCzA3eZnYawfRJAp1YZVv0e7KAYrounAWvgJO02/Ilw8PT5lMWAx6EO7AapChSb4+QlZEdvTAdYtT5CZQaOlGLbwzqK59M5fDpGIJJ8THCx3tIaEBCThXdIHwp+Rq6PjNaZXXMBi16SWMQiuiXJhuMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeSghAU/; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e05d48cf642so2348999276.2;
        Fri, 19 Jul 2024 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721413266; x=1722018066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqDNl1lTvXBnPUwPhnX1XGRRZkoCiM8/gjbuVFaf1EQ=;
        b=FeSghAU/d3kL7TGF59zCkQFb1xblJc+Mav0mue6ARDSAAanxtmSh4uJ373ZFuE/weC
         SUO30MzjSz3Nsl1385LGmwogGGa12BRxPEZw5NmRbLDOjaKlVMILXyVHWqwCSm/zOGl4
         UJcW/h8EGD6Z3yFZntbDw4f9Vi8KOKhQ6yahNt7b18aeZyl2fgCP3UVQIa96DiDzGe80
         aL2HliawHTxKZrT4T4yQOpQrm/uUycISqjV2buZ+gOq41/5s4EuSRkqt/gx0hj9xBWoa
         TBfqQsJlORg1woUmankMnU3BxQGQRi2vIdJLxfmuQeRNqAW/tnj2buAA0UAZ5Sa1quvE
         uq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721413266; x=1722018066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqDNl1lTvXBnPUwPhnX1XGRRZkoCiM8/gjbuVFaf1EQ=;
        b=FhLIVzGyUxYz5Rxn4EYjrRWrWzbWgnUvoLroaI0gBXatTycQZ+a18Bi3iAk2WyvO7D
         MEKwez17HS2TRuqeXKfkVm379ruwYRy8lPJlyJ7PTZYobnk3llPDIU8DNAy8h552pJjd
         U3O40yi/o4H9TJLjmbqSXcmzHX5dqmKIuccP+1MUCrBWYFaZkIBCG3TGJ6yLVdZoyR6t
         lJoKS+sWwfugttySgLMdjLCX6ZUQBd0aJE88sGWX9TPP4A74sZ1XfytAt3uw7gypx5cB
         5aTeeZKVpRB615DWQyDx6OapLjlT8IhWgZ6r6qATfp5aUZKOMjr1Qg552It5kzwJt6zc
         uTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgOa19zC6sSkIR3xcKYLBRawyZ7LFWZWMkuuDjZGsNZCEGOnxH5R3VCLyOjsPgY68u52IJ94NEz7ctg7GtGYMyLEVlIgHt
X-Gm-Message-State: AOJu0Yywu/L5wnnVSIY3JoekS4+G47StcDBPrJf6Q9PrkAnhL4LRWxNq
	oeUkCaNEHzuSyxhzP59kHYnagJSO7DtplJA47vhWRUrvy4hQwrcL7Sb2pgHbTipqNH5w3J2iedG
	f09j+MWqYRgj5MJpPu/n24zMuHPI=
X-Google-Smtp-Source: AGHT+IFktE/ikt9UBxW6kGZF1ZltR94oxMb16NRKUOHi6eDlJCGHgkIsGnOE9TsFlq5FUVaYEf6RcgN+9so4jTtXNIY=
X-Received: by 2002:a05:6902:1a4a:b0:e08:6eef:8d77 with SMTP id
 3f1490d57ef6-e086eef986dmr715429276.47.1721413265768; Fri, 19 Jul 2024
 11:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-11-amery.hung@bytedance.com> <f3ec8147-69ad-4852-be93-92a2a627229a@linux.dev>
In-Reply-To: <f3ec8147-69ad-4852-be93-92a2a627229a@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 19 Jul 2024 11:20:55 -0700
Message-ID: <CAMB2axN77AVg+ti993a3m+0KzGR545_bX7+8qGWRaC11JXK=Vg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 10/11] selftests: Add a bpf fq qdisc to selftest
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com, Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 6:54=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/14/24 10:51 AM, Amery Hung wrote:
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_ARRAY);
> > +     __type(key, __u32);
> > +     __type(value, struct fq_stashed_flow);
> > +     __uint(max_entries, NUM_QUEUE + 1);
> > +} fq_stashed_flows SEC(".maps");
> > +
> > +#define private(name) SEC(".data." #name) __hidden __attribute__((alig=
ned(8)))
> > +
> > +private(A) struct bpf_spin_lock fq_delayed_lock;
> > +private(A) struct bpf_rb_root fq_delayed __contains(fq_flow_node, rb_n=
ode);
> > +
> > +private(B) struct bpf_spin_lock fq_new_flows_lock;
> > +private(B) struct bpf_list_head fq_new_flows __contains(fq_flow_node, =
list_node);
> > +
> > +private(C) struct bpf_spin_lock fq_old_flows_lock;
> > +private(C) struct bpf_list_head fq_old_flows __contains(fq_flow_node, =
list_node);
>
> Potentially, multiple qdisc instances will content on these global locks.=
 Do you
> think it will be an issue in setup like the root is mq and multiple fq(s)=
 below
> the mq, like mq =3D> (fq1, fq2, fq3...)?
>
> I guess it could be solved by storing them into the map's value and each =
fq
> instance uses its own lock and list/rb (?) to make it work like ".priv_si=
ze",
> but just more work is needed in ".init". Not necessary the top of the thi=
ngs to
> tackle/optimize for now though.
>

The examples in selftests indeed do not work well for mq as they share
a global queue.

Just thinking on a higher level. A solution could be introducing some
semantics to bpf to annotate maps or graphs to be private and backed
by per-qdisc privdata, so that users don't need to specify the qdisc
everytime when accessing private data. In addition, maybe the reset
mechanism can piggyback on this.

Though it is not the highest priority, I think the final code is
selftests should use independent queues if under mq. I will fix it in
some future revisions.

> [ ... ]
>
> > +SEC("struct_ops/bpf_fq_enqueue")
> > +int BPF_PROG(bpf_fq_enqueue, struct sk_buff *skb, struct Qdisc *sch,
> > +          struct bpf_sk_buff_ptr *to_free)
> > +{
> > +     struct fq_flow_node *flow =3D NULL, *flow_copy;
> > +     struct fq_stashed_flow *sflow;
> > +     u64 time_to_send, jiffies;
> > +     u32 hash, sk_hash;
> > +     struct skb_node *skbn;
> > +     bool connected;
> > +
> > +     if (fq_qlen >=3D q_plimit)
> > +             goto drop;
> > +
> > +     if (!skb->tstamp) {
> > +             time_to_send =3D ktime_cache =3D bpf_ktime_get_ns();
> > +     } else {
> > +             if (fq_packet_beyond_horizon(skb)) {
> > +                     ktime_cache =3D bpf_ktime_get_ns();
> > +                     if (fq_packet_beyond_horizon(skb)) {
> > +                             if (q_horizon_drop)
> > +                                     goto drop;
> > +
> > +                             skb->tstamp =3D ktime_cache + q_horizon;
> > +                     }
> > +             }
> > +             time_to_send =3D skb->tstamp;
> > +     }
> > +
> > +     if (fq_classify(skb, &hash, &sflow, &connected, &sk_hash) < 0)
> > +             goto drop;
> > +
> > +     flow =3D bpf_kptr_xchg(&sflow->flow, flow);
> > +     if (!flow)
> > +             goto drop;
> > +
> > +     if (hash !=3D PRIO_QUEUE) {
> > +             if (connected && flow->socket_hash !=3D sk_hash) {
>
> The commit message mentioned it does not handle the hash collision. Not a
> request for now, I just want to understand if you hit some issues.

IIRC, when I used hashmap for fq_stashed_flows, there were some false
negatives from the verifier. So I simplified the implementation by
rehashing flow hash to 10 bits and using an arraymap instead. Let me
fix this and see if there are fundamental issues.

>
> > +                     flow->credit =3D q_initial_quantum;
> > +                     flow->socket_hash =3D sk_hash;
> > +                     if (fq_flow_is_throttled(flow)) {
> > +                             /* mark the flow as undetached. The refer=
ence to the
> > +                              * throttled flow in fq_delayed will be r=
emoved later.
> > +                              */
> > +                             flow_copy =3D bpf_refcount_acquire(flow);
> > +                             flow_copy->age =3D 0;
> > +                             fq_flows_add_tail(&fq_old_flows, &fq_old_=
flows_lock, flow_copy);
> > +                     }
> > +                     flow->time_next_packet =3D 0ULL;
> > +             }
> > +
> > +             if (flow->qlen >=3D q_flow_plimit) {
> > +                     bpf_kptr_xchg_back(&sflow->flow, flow);
> > +                     goto drop;
> > +             }
> > +
> > +             if (fq_flow_is_detached(flow)) {
> > +                     if (connected)
> > +                             flow->socket_hash =3D sk_hash;
> > +
> > +                     flow_copy =3D bpf_refcount_acquire(flow);
> > +
> > +                     jiffies =3D bpf_jiffies64();
> > +                     if ((s64)(jiffies - (flow_copy->age + q_flow_refi=
ll_delay)) > 0) {
> > +                             if (flow_copy->credit < q_quantum)
> > +                                     flow_copy->credit =3D q_quantum;
> > +                     }
> > +                     flow_copy->age =3D 0;
> > +                     fq_flows_add_tail(&fq_new_flows, &fq_new_flows_lo=
ck, flow_copy);
> > +             }
> > +     }
> > +
> > +     skbn =3D bpf_obj_new(typeof(*skbn));
> > +     if (!skbn) {
> > +             bpf_kptr_xchg_back(&sflow->flow, flow)
> Please post the patch that makes the bpf_kptr_xchg() work. It is easier i=
f I can
> try the selftests out.
>

The offlist RFC patchset from Dave Marchevsky is now in reply to the
cover letter for people interested to try out. I am also copying Dave
here.

Thanks for reviewing,
Amery

