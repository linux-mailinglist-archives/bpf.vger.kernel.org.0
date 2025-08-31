Return-Path: <bpf+bounces-67068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D94BB3D0D6
	for <lists+bpf@lfdr.de>; Sun, 31 Aug 2025 05:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A9444A48
	for <lists+bpf@lfdr.de>; Sun, 31 Aug 2025 03:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931620E011;
	Sun, 31 Aug 2025 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJn4ceJS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D27E792;
	Sun, 31 Aug 2025 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756610481; cv=none; b=OrQi0LE7A+eXIaHhxxLnPLKqeYV2hqyMMuSB1tlfMOdPd2cre2prnSSnPFACzRwyfhhpOzrFcoAeG+gEGpkvkaS7V1yTCq8uMD1koZEYX1uFrVJ1PEB+tAwPxYHkqy+2ai1KcNNqgM0B4QY23d1yasrPlNpAInli0NscP6a6sP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756610481; c=relaxed/simple;
	bh=DvsrS5yV4f8tnEjy4K5dpNZ63UE+ZLKpyPJ0V7szXSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+0fbhndYlaQindrwLHu673iKKWXzOKJUq6ksupc3iWy61wlqBXkg8Z9aV3xNqVnc741viHumZ1yrWYrDE4b96Eu0+CHvCKIQCEtGMUTzaHLzF0gB3cW8tMnKnXRiL93Qy0CS3qMRiWCt1fJfk6Q4kyFmHTYjS6+SOl/VECWnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJn4ceJS; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70fa0e941a9so15903656d6.0;
        Sat, 30 Aug 2025 20:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756610478; x=1757215278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmkA2GEtVBpE1rfMwgGSnld1GOA1shoo7sxcZ5Vcnw8=;
        b=lJn4ceJSJp7M4NuRs8br5n0QcgMWeoJrw++fLPHSrKIgSMp4iGhadhkF/VY4X+pBub
         BMs4xYnhqWaLj6HNTe8ZYLEO8sjzq0UGpNE2wj3jL7SZx/7Dk1A+YL/XnNFOmhyJXJHG
         JlP+gUgDpfIXPEGNCmF1hnY1eV6ck0AtN15f2rE99gG2mu+f5Y4LnCYC9o7u0R+I+LSO
         Y/qxN0IBGStWxql5QuRZ1DZvo/L2+H/XS9/obrkI8OMtOa4h6L4Pp7KkybWTfjjRfYln
         NUrd1cjXkx0q3jN9+55UKS87+tBElhbaoqNAgfOUHpf1alKw+Tju3sAAmqaffMVcvwNJ
         /dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756610478; x=1757215278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmkA2GEtVBpE1rfMwgGSnld1GOA1shoo7sxcZ5Vcnw8=;
        b=j0RRgGFwbNmLuXcg+sRHMl2zu/uv2xjj19TX1EFvpjIZHxBk0gMv/L5ZkYmMq/WJ69
         SCZtrZVb7WVjKlbSWF5Kakb7eQ6GdC4u1Z2DFLgEa7yJwtCovU95IQmOBzQreS7Tzb5S
         9cHoyEN+WTtDTQVyjoxj9eTwnemeAWK7pOkBJwuROm6YpXfVDBnaPHkcV8jmAoqkopkL
         Uoqe4pgsxSVnXWIuT9DKFCO1MlirV9LPNnmYRBuryMOURNBUsGEHu2wEp11KDuqtIRa4
         EpSvYtLJ0NCjNG1F/cdl/GhCrIXnwE8+8+Mr+AXllPfB71pG1mN7JgQuLkRxTKqXCIjW
         F6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWG+jhFIDo2wOPDlTxI8BOh7eDldoitSLEXPxiZ+kcmNg7BrjnscciRyS4zf5DgkWvQz1w=@vger.kernel.org, AJvYcCWhRGnN3tpIN7k+F+EfNN0wa6ydKXUIzuC2Rl3g/DncKUdPO8GaKeIt5CWL4jIe42o9UuMu5yKD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2vlbIBaNI76DolngEaelENn1HMKjR5n+DMfoGjPXbta1lkMt
	3cb38cpDMoi0HVqhGQRC4Q9BhROavEbtXJdoVpmSbLSqG0HZ5i1TiMhBhZDyxHp8dHJDR14NB0g
	/SATcY2s3SAJYV+D4ffslki0IlRqOX7U=
X-Gm-Gg: ASbGncsCcGmb/8QKuHwndLwQVnw5H17vYJpKVIKVSx5E24eAHmlWsRmp4KcNKjFtAPe
	wJHjLBrZQfPMAm3dayqj16l5LS6mYIWRyRWcmJx5eDLkq8tYZuesdewX6mVUAeNGKWaJrlYbOWJ
	vQ26AbIJVgeRCphbpzlaGRBmRogWH6Ispvibxf89CDfBcqUbvEe0KEGr7EArxIbiQDN2aeD9ilZ
	qQj0/Cs3gZyn4j/vHtyzqZpSkL3sg9RjZiSvhJG
X-Google-Smtp-Source: AGHT+IFhcvL+85PJicyFvcYlpqfO5G7Jf9qUBEDmdUJQ9rfiz+3OG/iZpLHOb4Vi9O5eBLN1MJ1tLqo29CIkblyMpPk=
X-Received: by 2002:ad4:576d:0:b0:70d:c3ac:2bb5 with SMTP id
 6a1803df08f44-70fac97d6f4mr44981526d6.34.1756610478389; Sat, 30 Aug 2025
 20:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822064200.38149-1-laoar.shao@gmail.com> <1d3ba6ba-5c1e-4d3f-980a-8ad75101f04d@redhat.com>
 <CALOAHbBdiPZ_YVhBJeV517Xqz8=cuGo6jhhta_QXy5-eQ6EN4g@mail.gmail.com> <96158e58-da9a-4661-a47b-e7b85856ac90@iogearbox.net>
In-Reply-To: <96158e58-da9a-4661-a47b-e7b85856ac90@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 31 Aug 2025 11:20:42 +0800
X-Gm-Features: Ac12FXw19OqNKsxFEFxE8wzcjjHwmEp4kancSM8hftsH5GarRDGyjKlO_tPF4t0
Message-ID: <CALOAHbBq0+zNGx_yYCFVsacOZREs=8OBhGdiOBCK75k0YoPKOQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/cls_cgroup: Fix task_get_classid() during qdisc run
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, bigeasy@linutronix.de, tgraf@suug.ch, 
	paulmck@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 4:14=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/29/25 5:23 AM, Yafang Shao wrote:
> > On Thu, Aug 28, 2025 at 3:55=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 8/22/25 8:42 AM, Yafang Shao wrote:
> >>> During recent testing with the netem qdisc to inject delays into TCP
> >>> traffic, we observed that our CLS BPF program failed to function corr=
ectly
> >>> due to incorrect classid retrieval from task_get_classid(). The issue
> >>> manifests in the following call stack:
> >>>
> >>>          bpf_get_cgroup_classid+5
> >>>          cls_bpf_classify+507
> >>>          __tcf_classify+90
> >>>          tcf_classify+217
> >>>          __dev_queue_xmit+798
> >>>          bond_dev_queue_xmit+43
> >>>          __bond_start_xmit+211
> >>>          bond_start_xmit+70
> >>>          dev_hard_start_xmit+142
> >>>          sch_direct_xmit+161
> >>>          __qdisc_run+102             <<<<< Issue location
> >>>          __dev_xmit_skb+1015
> >>>          __dev_queue_xmit+637
> >>>          neigh_hh_output+159
> >>>          ip_finish_output2+461
> >>>          __ip_finish_output+183
> >>>          ip_finish_output+41
> >>>          ip_output+120
> >>>          ip_local_out+94
> >>>          __ip_queue_xmit+394
> >>>          ip_queue_xmit+21
> >>>          __tcp_transmit_skb+2169
> >>>          tcp_write_xmit+959
> >>>          __tcp_push_pending_frames+55
> >>>          tcp_push+264
> >>>          tcp_sendmsg_locked+661
> >>>          tcp_sendmsg+45
> >>>          inet_sendmsg+67
> >>>          sock_sendmsg+98
> >>>          sock_write_iter+147
> >>>          vfs_write+786
> >>>          ksys_write+181
> >>>          __x64_sys_write+25
> >>>          do_syscall_64+56
> >>>          entry_SYSCALL_64_after_hwframe+100
> >>>
> >>> The problem occurs when multiple tasks share a single qdisc. In such =
cases,
> >>> __qdisc_run() may transmit skbs created by different tasks. Consequen=
tly,
> >>> task_get_classid() retrieves an incorrect classid since it references=
 the
> >>> current task's context rather than the skb's originating task.
> >>>
> >>> Given that dev_queue_xmit() always executes with bh disabled, we can =
safely
> >>> use in_softirq() instead of in_serving_softirq() to properly identify=
 the
> >>> softirq context and obtain the correct classid.
> >>>
> >>> The simple steps to reproduce this issue:
> >>> 1. Add network delay to the network interface:
> >>>    such as: tc qdisc add dev bond0 root netem delay 1.5ms
> >>> 2. Create two distinct net_cls cgroups, each running a network-intens=
ive task
> >>> 3. Initiate parallel TCP streams from both tasks to external servers.
> >>>
> >>> Under this specific condition, the issue reliably occurs. The kernel
> >>> eventually dequeues an SKB that originated from Task-A while executin=
g in
> >>> the context of Task-B.
> >>>
> >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >>> Cc: Thomas Graf <tgraf@suug.ch>
> >>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >>>
> >>> v1->v2: use softirq_count() instead of in_softirq()
> >>> ---
> >>>   include/net/cls_cgroup.h | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/net/cls_cgroup.h b/include/net/cls_cgroup.h
> >>> index 7e78e7d6f015..668aeee9b3f6 100644
> >>> --- a/include/net/cls_cgroup.h
> >>> +++ b/include/net/cls_cgroup.h
> >>> @@ -63,7 +63,7 @@ static inline u32 task_get_classid(const struct sk_=
buff *skb)
> >>>         * calls by looking at the number of nested bh disable calls b=
ecause
> >>>         * softirqs always disables bh.
> >>>         */
> >>> -     if (in_serving_softirq()) {
> >>> +     if (softirq_count()) {
> >>>                struct sock *sk =3D skb_to_full_sk(skb);
> >>>
> >>>                /* If there is an sock_cgroup_classid we'll use that. =
*/
> >>
> >> AFAICS the above changes the established behavior for a slightly
> >> different scenario:
> >
> > right.
> >
> >> <sock S is created by task A>
> >> <class ID for task A is changed>
> >> <skb is created by sock S xmit and classified>
> >>
> >> prior to this patch the skb will be classified with the 'new' task A
> >> classid, now with the old/original one.
> >>
> >> I'm unsure if such behavior change is acceptable;
> >
> > The classid of a skb is only meaningful within its original network
> > context, not from a random task.
>
> Do you mean by original network context original netns? We also have
> bpf_skb_cgroup_classid() as well as bpf_get_cgroup_classid_curr(), both
> exposed to tcx, which kind of detangles what task_get_classid() is doing.
> I guess if you have apps in its own netns and the skb->sk is retained all
> the way to phys dev in hostns then bpf_skb_cgroup_classid() might be a
> better choice (assuming classid stays constant from container orchestrato=
r
> PoV).

Right. We have replaced bpf_get_cgroup_classid() with
bpf_skb_cgroup_classid() to handle this case. Nonetheless, I believe
we still need to fix bpf_get_cgroup_classid(), since this function can
easily mislead users.

--=20
Regards
Yafang

