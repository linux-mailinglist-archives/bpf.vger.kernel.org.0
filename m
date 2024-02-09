Return-Path: <bpf+bounces-21649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45D84FD5A
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 21:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B512872B6
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEA1272BF;
	Fri,  9 Feb 2024 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deP8stjw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D186ADC;
	Fri,  9 Feb 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509710; cv=none; b=jbzkRIszhs5QM1AwmRw4JQiV5qSyFhy/ponJewMCSKLsPRL0QJtzfHAK5CxeKu3Ic9LZZ8vImwiaItggexaxs3ojJD3objJ5IC3VdrdQ9CW0dq6g76wurjAKIMFi0vjYhHMoOPJLo7sXaPE2szxOiXGVxPZrmJKmI0IBayRNYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509710; c=relaxed/simple;
	bh=KbQ7F0Liz/IR0JdyUYKRu0MD8EOx1z2A8SO9DHOuelI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUunrlLXsniP7sb7PIa4TNP8C8iz0QnpEcVcVu0FyJaH8OoLbwbSjEttZDP8ID/pq9jcfMtRbkWeO8k8ze+9CcR16qUJJIuBNsSqZ9HKh2uhYKQNusMkaMpJG9LZwoPCRK3/b3c/aASXy3gzU+J+Rax2CconCMH9DRAERlD00Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deP8stjw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-604b2c3c643so14824237b3.0;
        Fri, 09 Feb 2024 12:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707509707; x=1708114507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y384vEWgOGq2E/xd1hs0bcs64tGP1Jnw5tGzeqsFTv4=;
        b=deP8stjwTt38WOoUc6AtSoYRGBLpOVgdsJecuhGZznoTCcFP+GdF3N/GUhgMq/Yub1
         2YqLZ387MkMwTWTQQ+wGpUSgA98HuAQj4NWMT9QiFOwLRh0zv3QbRAXBfBK1TeFZ4kDJ
         pV24UOUXAxRg/ZhLr3d+ia3tiLNurNztCAibd2b42bGvRib5nGpAGQD0sM7khTNuZdTf
         dEp7pE8r5Xf9ZMCBv8L+ZFsxxrQuzj6owgh3mBjhpGqg0K7cJqX+/0XwaZXHALzGTMzV
         k69taGxP3ST2JRJH2da3E2iEgv5ZvaOcWbx1nQQrtbSUZUlaGdkwJA5v5+hxjQRVJFl7
         EuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707509707; x=1708114507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y384vEWgOGq2E/xd1hs0bcs64tGP1Jnw5tGzeqsFTv4=;
        b=Rde2KHBaEmxvjB6qFrugEzZ7qB4zpLJWakO04bAItrc0x1zVwcOpuOQmYbXw2RZ+SO
         X1cXW97XTkGIpCyfEB0E7QZtauuBgXO6dal77Omfb/c58B8JXpbnxgxINoAjToqb9ZBa
         O8o8o8pCGwhCyNofiaKaozpbClq5T/L9/PCHot7jVeJCFmq88u/edu47DD14vTrW+yWO
         JrX6K6M5zQcIfSwqiD8YKbGJZEOAwpCc0XCXExTS5L5mqiejfkUbS9sOp72GR5gmsCGa
         JEvm+lX2s3uGzzC28H36G78MUIhqi69EnmgM6jYAd/1L1bVI3Drng3itgBuvJoEUFROE
         vK4A==
X-Gm-Message-State: AOJu0YyevZlrATuuff+YppBDpO0eKyuDz4LuQL7cN/2UpO3S+UFxe09s
	nRUhgXYn6Wb+aMBd5Tup8gNx8Owzc2kLi5VNqxGYLvK04GrNCyMXltDhZbvzwEBdz5OiDSxOzi5
	ErBngz8/pkSRK8k8zCQBo8JsbjRqkJx8a6FgZow==
X-Google-Smtp-Source: AGHT+IELL7MsofjVJYIGuxc495CS3KQKm5r1oY0HMALcGYcprqTvRyEOSCPQ4xxYGtetKMx73h3dttKcEwyvj9oElAk=
X-Received: by 2002:a81:a142:0:b0:604:1709:a5f9 with SMTP id
 y63-20020a81a142000000b006041709a5f9mr328219ywg.18.1707509707107; Fri, 09 Feb
 2024 12:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
 <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev> <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
 <01fdb720-c0dc-495d-a42d-756aa2bf4455@linux.dev> <CAMB2axOZqwgksukO5d4OiXeEgo2jFrgnzO5PQwABi_WxYFycGg@mail.gmail.com>
 <8c00bd63-2d00-401e-af6d-1b6aebac4701@linux.dev> <CAMB2axOdeE5dPeFGvgM5QVd9a47srtvDFZd1VUYjSarNJC=T_w@mail.gmail.com>
 <8a2e9cf6-ef36-4ba8-bb95-fb592bdce5db@linux.dev>
In-Reply-To: <8a2e9cf6-ef36-4ba8-bb95-fb592bdce5db@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 9 Feb 2024 12:14:55 -0800
Message-ID: <CAMB2axMg1RQOaOA+5bvh234YK98o7vMmm5B4+VT__kS1=Tcqyw@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com, 
	jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com, netdev@vger.kernel.org, 
	Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 1/31/24 8:23 AM, Amery Hung wrote:
> >>> 1. Passing a referenced kptr into a bpf program, which will also need
> >>> to be released, or exchanged into maps or allocated objects.
> >> "enqueue" should be the one considering here:
> >>
> >> struct Qdisc_ops {
> >>          /* ... */
> >>          int                     (*enqueue)(struct sk_buff *skb,
> >>                                             struct Qdisc *sch,
> >>                                             struct sk_buff **to_free);
> >>
> >> };
> >>
> >> The verifier only marks the skb as a trusted kptr but does not mark it=
s
> >> reg->ref_obj_id. Take a look at btf_ctx_access(). In particular:
> >>
> >>          if (prog_args_trusted(prog))
> >>                  info->reg_type |=3D PTR_TRUSTED;
> >>
> >> The verifier does not know the skb ownership is passed into the ".enqu=
eue" ops
> >> and does not know the bpf prog needs to release it or store it in a ma=
p.
> >>
> >> The verifier tracks the reference state when a KF_ACQUIRE kfunc is cal=
led (just
> >> an example, not saying we need to use KF_ACQUIRE kfunc). Take a look a=
t
> >> acquire_reference_state() which is the useful one here.
> >>
> >> Whenever the verifier is loading the ".enqueue" bpf_prog, the verifier=
 can
> >> always acquire_reference_state() for the "struct sk_buff *skb" argumen=
t.
> >>
> >> Take a look at a recent RFC:
> >> https://lore.kernel.org/bpf/20240122212217.1391878-1-thinker.li@gmail.=
com/
> >> which is tagging the argument of an ops (e.g. ".enqueue" here). That R=
FC patch
> >> is tagging the argument could be NULL by appending "__nullable" to the=
 argument
> >> name. The verifier will enforce that the bpf prog must check for NULL =
first.
> >>
> >> The similar idea can be used here but with a different tagging (for ex=
ample,
> >> "__must_release", admittedly not a good name). While the RFC patch is
> >> in-progress, for now, may be hardcode for the ".enqueue" ops in
> >> check_struct_ops_btf_id() and always acquire_reference_state() for the=
 skb. This
> >> part can be adjusted later once the RFC patch will be in shape.
> >>
> > Make sense. One more thing to consider here is that .enqueue is
> > actually a reference acquiring and releasing function at the same
> > time. Assuming ctx written to by a struct_ops program can be seen by
> > the kernel, another new tag for the "to_free" argument will still be
> > needed so that the verifier can recognize when writing skb to
> > "to_free".
>
> I don't think "to_free" needs special tagging. I was thinking the
> "bpf_qdisc_drop" kfunc could be a KF_RELEASE. Ideally, it should be like
>
> __bpf_kfunc int bpf_qdisc_drop(struct sk_buff *skb, struct Qdisc *sch,
>                                struct sk_buff **to_free)
> {
>         return qdisc_drop(skb, sch, to_free);
> }
>
> However, I don't think the verifier supports pointer to pointer now. Mean=
ing
> "struct sk_buff **to_free" does not work.
>
> If the ptr indirection spinning in my head is sound, one possible solutio=
n to
> unblock the qdisc work is to introduce:
>
> struct bpf_sk_buff_ptr {
>         struct sk_buff *skb;
> };
>
> and the bpf_qdisc_drop kfunc:
>
> __bpf_kfunc int bpf_qdisc_drop(struct sk_buff *skb, struct Qdisc *sch,
>                                 struct bpf_sk_buff_ptr *to_free_list)
>
> and the enqueue prog:
>
> SEC("struct_ops/enqueue")
> int BPF_PROG(test_enqueue, struct sk_buff *skb,
>               struct Qdisc *sch,
>               struct bpf_sk_buff_ptr *to_free_list)
> {
>         return bpf_qdisc_drop(skb, sch, to_free_list);
> }
>
> and the ".is_valid_access" needs to change the btf_type from "struct sk_b=
uff **"
> to "struct bpf_sk_buff_ptr *" which is sort of similar to the bpf_tcp_ca.=
c that
> is changing the "struct sock *" type to the "struct tcp_sock *" type.
>
> I have the compiler-tested idea here:
> https://git.kernel.org/pub/scm/linux/kernel/git/martin.lau/bpf-next.git/l=
og/?h=3Dqdisc-ideas
>
>
> >
> >> Then one more thing is to track when the struct_ops bpf prog is actual=
ly reading
> >> the value of the skb pointer. One thing is worth to mention here, e.g.=
 a
> >> struct_ops prog for enqueue:
> >>
> >> SEC("struct_ops")
> >> int BPF_PROG(bpf_dropall_enqueue, struct sk_buff *skb, struct Qdisc *s=
ch,
> >>               struct sk_buff **to_free)
> >> {
> >>          return bpf_qdisc_drop(skb, sch, to_free);
> >> }
> >>
> >> Take a look at the BPF_PROG macro, the bpf prog is getting a pointer t=
o an array
> >> of __u64 as the only argument. The skb is actually in ctx[0], sch is i=
n
> >> ctx[1]...etc. When ctx[0] is read to get the skb pointer (e.g. r1 =3D =
ctx[0]),
> >> btf_ctx_access() marks the reg_type to PTR_TRUSTED. It needs to also i=
nitialize
> >> the reg->ref_obj_id by the id obtained earlier from acquire_reference_=
state()
> >> during check_struct_ops_btf_id() somehow.
>

I appreciate the idea. The pointer redirection works without problems.
I now have a working fifo bpf qdisc using struct_ops. I will explore
how other parts of qdisc work with struct_ops.

Thanks,
Amery

