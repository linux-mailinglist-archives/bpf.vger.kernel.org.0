Return-Path: <bpf+bounces-20448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2F783E8EB
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 02:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252F728A9C3
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 01:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904F08C14;
	Sat, 27 Jan 2024 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVQpIRwA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E74436;
	Sat, 27 Jan 2024 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318261; cv=none; b=mEQ61zLRmWQLImtfuU5zxCapM4VPUOv/A5yA+8TCUaaJD/ohiZ1TreWknnLsXoV0Bf67NX/tvY2rl98RsbhboGC+wleKGr3ty72/NL3J+jSnfIS+WWlDepI7/hT08OS11JbQtP56POunCdGDiog47NMwUtRaZYOfdm2zae1HRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318261; c=relaxed/simple;
	bh=3Ly4jhvTbdYBkOAxKXYs8lGJMMm0tKTEkZb0H8hV5ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbaolks09zKsjKBxdRlP09IA4p81JCZrkxFtcshAZLpDsoC4Mh/NkmsWiA7UT0SawNuJPXqLDUJkDQpUniNW/guy5edrjGS9hn5qDsCpWJlq6vUpwktJFzJvRlEDCE5YtXdxflV1X7m/GGeyahc0fP134kGNAruc0kC7fA6T+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVQpIRwA; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed0710c74so1005246276.1;
        Fri, 26 Jan 2024 17:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706318258; x=1706923058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT5Utz/jGnl0qlwlkmglcMOy3en/bkj/UJpoPvpXC10=;
        b=EVQpIRwAxE9144Op21qRsnbE1lzg1pI79onxjCbnKwDd0lWyvOC8BkwkVI2W5uOQ0J
         gZg8CylamosnY9SRhO62GilzFlR01EjAkkszitmztw/6GTDA0WdMdA+hXsStOEOi7E33
         7wI6/NAwa3paX95Xsvh92OGm9QJUDYRJPEFtp7ZHd4FcuBpu4eZ8wx850MqUI3l77uuE
         btANK+xt5AtalBf6MFtwqrZpI+6uJJVvMznyT4uN0BSG98xXkSqjAXk5lQwJjYKHvmic
         tQPU4Fg/F/sdWbWsJv+7EwOC0PLtnfzvxeL0uIzc6Lb7wGmTTZteRUHA9UJSqD9M0+6g
         vseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706318258; x=1706923058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT5Utz/jGnl0qlwlkmglcMOy3en/bkj/UJpoPvpXC10=;
        b=khL+77scMX8783JqmGg2t5f8o1JxOsRxKsDdELXpEiEzd4mOTblcqfi9/kt1zCvCvj
         HK9rI+mOQzZ4nRQhVvuvG0pVErcuY1uXVdH9xUGZCan2uyTcy4uTLnJfCdjRE+fJfhcY
         XL9yVctHuQ8DosqBvHlGGuz/DMh0/SQSZ18DtOUYIlyLpQYMewncoF2rJ+xvbRANvOGl
         aZRfit7SkEy8dzp+vuyX6DPX5yVii6nT05p+HfQXefAZngKZWSdbXAdiMJwyJV8HQgMT
         2RQjkoKvPH3XYFQ8ZN9xfRxwXftkVPSkRHmwp5MQGKh8NeVuyyTr75aBp1BYo4T6Z7s9
         wXWA==
X-Gm-Message-State: AOJu0Yw5iFHqSsahJMZ0xt/M86GVB6e9iQnHeigHzsZVAM2nhJn/sifW
	QZmfeq/BSYCesXZd2mTv3Sr2jw8zq9pS6Nzhpaeovd9bNOd+gQEQ/kQMoyV9AIIuuW6AiOB2Xmt
	uZuTm+l+lu50n0aiOZwkT5vFl1Eo=
X-Google-Smtp-Source: AGHT+IHJFilB2FhpZsN/qosJ6DMrTemn3KAO89KmCBwYABzvRx9mYix0IGZ1bOsLufafRx9MK4RKqsN2/lltQNAhjT8=
X-Received: by 2002:a05:6902:2487:b0:dc2:4103:e0ac with SMTP id
 ds7-20020a056902248700b00dc24103e0acmr865362ybb.89.1706318258339; Fri, 26 Jan
 2024 17:17:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
 <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev> <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
 <01fdb720-c0dc-495d-a42d-756aa2bf4455@linux.dev>
In-Reply-To: <01fdb720-c0dc-495d-a42d-756aa2bf4455@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 26 Jan 2024 17:17:26 -0800
Message-ID: <CAMB2axOZqwgksukO5d4OiXeEgo2jFrgnzO5PQwABi_WxYFycGg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com, 
	jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 6:22=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/23/24 9:22 PM, Amery Hung wrote:
> >> I looked at the high level of the patchset. The major ops that it want=
s to be
> >> programmable in bpf is the ".enqueue" and ".dequeue" (+ ".init" and ".=
reset" in
> >> patch 4 and patch 5).
> >>
> >> This patch adds a new prog type BPF_PROG_TYPE_QDISC, four attach types=
 (each for
> >> ".enqueue", ".dequeue", ".init", and ".reset"), and a new "bpf_qdisc_c=
tx" in the
> >> uapi. It is no long an acceptable way to add new bpf extension.
> >>
> >> Can the ".enqueue", ".dequeue", ".init", and ".reset" be completely im=
plemented
> >> in bpf (with the help of new kfuncs if needed)? Then a struct_ops for =
Qdisc_ops
> >> can be created. The bpf Qdisc_ops can be loaded through the existing s=
truct_ops api.
> >>
> > Partially. If using struct_ops, I think we'll need another structure
> > like the following in bpf qdisc to be implemented with struct_ops bpf:
> >
> > struct bpf_qdisc_ops {
> >      int (*enqueue) (struct sk_buff *skb)
> >      void (*dequeue) (void)
> >      void (*init) (void)
> >      void (*reset) (void)
> > };
> >
> > Then, Qdisc_ops will wrap around them to handle things that cannot be
> > implemented with bpf (e.g., sch_tree_lock, returning a skb ptr).
>
> We can see how those limitations (calling sch_tree_lock() and returning a=
 ptr)
> can be addressed in bpf. This will also help other similar use cases.
>

For kptr, I wonder if we can support the following semantics in bpf if
they make sense:
1. Passing a referenced kptr into a bpf program, which will also need
to be released, or exchanged into maps or allocated objects.
2. Returning a kptr from a program and treating it as releasing the referen=
ce.

> Other than sch_tree_lock and returning a ptr from a bpf prog. What else d=
o you
> see that blocks directly implementing the enqueue/dequeue/init/reset in t=
he
> struct Qdisc_ops?
>

Not much! We can deal with sch_tree_lock later since
enqueue/dequeue/init/reset are unlikely to use it.

> Have you thought above ".priv_size"? It is now fixed to sizeof(struct
> bpf_sched_data). It should be useful to allow the bpf prog to store its o=
wn data
> there?
>

Maybe we can let bpf qdiscs store statistics here and make it work
with netlink. I haven't explored much in how bpf qdiscs record and
share statistics with user space.

> >
> >> If other ops (like ".dump", ".dump_stats"...) do not have good use cas=
e to be
> >> programmable in bpf, it can stay with the kernel implementation for no=
w and only
> >> allows the userspace to load the a bpf Qdisc_ops with .equeue/dequeue/=
init/reset
> >> implemented.
> >>
> >> You mentioned in the cover letter that:
> >> "Current struct_ops attachment model does not seem to support replacin=
g only
> >> functions of a specific instance of a module, but I might be wrong."
> >>
> >> I assumed you meant allow bpf to replace only "some" ops of the Qdisc_=
ops? Yes,
> >> it can be done through the struct_ops's ".init_member". Take a look at
> >> bpf_tcp_ca_init_member. The kernel can assign the kernel implementatio=
n for
> >> ".dump" (for example) when loading the bpf Qdisc_ops.
> >>
> > I have no problem with partially replacing a struct, which like you
> > mentioned has been demonstrated by congestion control or sched_ext.
> > What I am not sure about is the ability to create multiple bpf qdiscs,
> > where each has different ".enqueue", ".dequeue", and so on. I like the
> > struct_ops approach and would love to try it if struct_ops support
> > this.
>
> The need for allowing different ".enqueue/.dequeue/..." bpf
> (BPF_PROG_TYPE_QDISC) programs loaded into different qdisc instances is b=
ecause
> there is only one ".id =3D=3D bpf" Qdisc_ops native kernel implementation=
 which is
> then because of the limitation you mentioned above?
>
> Am I understanding your reason correctly on why it requires to load diffe=
rent
> bpf prog for different qdisc instances?
>
> If the ".enqueue/.dequeue/..." in the "struct Qdisc_ops" can be directly
> implemented in bpf prog itself, it can just load another bpf struct_ops w=
hich
> has a different ".enqueue/.dequeue/..." implementation:
>
> #> bpftool struct_ops register bpf_simple_fq_v1.bpf.o
> #> bpftool struct_ops register bpf_simple_fq_v2.bpf.o
> #> bpftool struct_ops register bpf_simple_fq_xyz.bpf.o
>
>  From reading the test bpf prog, I think the set is on a good footing. In=
stead
> of working around the limitation by wrapping the bpf prog in a predefined
> "struct Qdisc_ops sch_bpf_qdisc_ops", lets first understand what is missi=
ng in
> bpf and see how we could address them.
>

Thank you so much for the clarification. I had the wrong impression
since I was thinking about using a structure in the bpf qdisc for
struct_ops. It makes sense to try making "struct Qdisc_ops" work with
struct_ops. I will send the next patch set with struct_ops.

Thanks,
Amery

>

