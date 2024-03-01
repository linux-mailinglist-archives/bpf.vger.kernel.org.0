Return-Path: <bpf+bounces-23142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127FC86E312
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 15:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2878B1C21D48
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B78967E8D;
	Fri,  1 Mar 2024 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWijkWzd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF06EF16
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302320; cv=none; b=ik+vu84FupLm1x9Fs8m/a3soC0SaLEJLC0JQSLegEH0/oEltaEHUuBfGlKd+QJ1Tu9z88tgPu0YeDfpEsO3+yFQg7GSHZIpXwsBoB+WNQf8/Dro9Crct+7WjnBurXsKl7PIFyq/a1MYhI8UdcEIQEgz5+IFTtFcdwRIZDU0fWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302320; c=relaxed/simple;
	bh=HikkruI1e/loLt3J6Ehhu3BisD2M+zRqee7sgo+WcxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXDmVp1Ivf4X/59ErxB/sWIuIBQs+BiCkFUyI+duxZtKHU/lNQYqD81fZ2nSM/y+n2ypOC9qL/M2xEbQOjZXt4BY98/lQZrJIPTXa1KkAK/iqNAmAFbjNCnDVRyT42yiyd2e/pALdE8kpJ444Mi4if3brPbgfix6tCNsNoOeP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWijkWzd; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-566e1e94b47so687040a12.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709302317; x=1709907117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HikkruI1e/loLt3J6Ehhu3BisD2M+zRqee7sgo+WcxM=;
        b=UWijkWzdbKGdx93ye1938kz9hVHfAzQ9umjNaQogFzKcLjnZ4E1TfZUAEdOPtxrxVT
         MmBNABWAWwDCQLY83UIkA7LeRJGI/ijQiEDl9MysXRlVQxM36b3bnp0a7KsrrUHcJyT+
         ZV8Elf+YWpJWKDgRdGOxwpowMCt/fsMurdpl2yxcAN+T184cjNds20eDOF1qocKJWnMv
         bVJTagJ5y3nbHJdoVy3C/0XjOkIcW1FiZV8aZ7jLfYGQGl5e1/uYtlvsCqGqbRW+CygQ
         R5w4UmKgAs48hQkRbWwOqlgw2Nz5ZT6tmKr55BIKkYO7htME6NqkRAePNyqbkHYIHFEG
         1PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302317; x=1709907117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HikkruI1e/loLt3J6Ehhu3BisD2M+zRqee7sgo+WcxM=;
        b=sSzJjtXhacpkh/fWfIjB1393grU4y68OTJ8DpLPi+mEmxIZHikoF5WeYalej4HVr0R
         pXGJQ0OkiTQbuLsjXg1Mk2pU6bYPmg7klkaf0fW9I+c1PYrj6FlgU/LVS5ARNrrWnyNY
         xivA+TQF/mc9kor7mOyGIDEwSz8mo18v58GR/s10H0BC9/4kHVp+fcfNtqq0K3Vpn2Zj
         ohMgus/ypvh1OBn24mouH3nWsZC9oPyNp7spAD3Zs/3c5NBMBEnGTu/MbTzy2DQkAMuC
         dW6zJyIZfYrxvO7ZvdzJ/+Bnq9Xz6nlqRzF5HjykeBMYlo1IfsNwqDwv/vvPF0K06Ie3
         AoJA==
X-Forwarded-Encrypted: i=1; AJvYcCWM7xPFXLdErqK4I3YG0c/9q+YN0CFdhWDh8So7PAhd1ZtUQBukr5CWB298ifCqGP2KnfMPVge1f1Ow0ZeQo8cYBvib
X-Gm-Message-State: AOJu0YztKvBaVU6vlljUd21KGzdqvBsckTW7YG/ZIzJPEIZjjQ3bDQaF
	MVXA+7HaXf3wBlEl0ozGv9Qdu4QOfU0/YtAxtw/flE+fxVLR8pqO1Q9DWHD3HDcra0KyfqDMJwS
	I962vZr1HUI+jZOG+O4UHh7KmfWw=
X-Google-Smtp-Source: AGHT+IGeJXNIpR3rAkNduoBXoMqoK1huoBRJVRki3Gae3tX2plmCtBSrs/H4nblPrtL6ARyQkhnjEkx1r0UFgIEUVa4=
X-Received: by 2002:a17:906:f0ce:b0:a44:50bb:8cc2 with SMTP id
 dk14-20020a170906f0ce00b00a4450bb8cc2mr1779435ejb.28.1709302316614; Fri, 01
 Mar 2024 06:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
 <CAP01T76R0bqdNK+LkObuVTej_TRwEB9HnvwJaTTsRrr1Y8_WmA@mail.gmail.com>
 <878r34ejv1.fsf@toke.dk> <CAMB2axO3B-ziNt9AFM+Xkr1H0WQzzhaThi1PO-xKcGP3cNtxQQ@mail.gmail.com>
 <87le729h9l.fsf@toke.dk>
In-Reply-To: <87le729h9l.fsf@toke.dk>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 1 Mar 2024 15:11:20 +0100
Message-ID: <CAP01T76K7gsk=qyVGXkmk=8tZfKV==z62mFeurz-P7tQKWNAWw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Amery Hung <ameryhung@gmail.com>, lsf-pc@lists.linux-foundation.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 at 15:08, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.=
com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > On Wed, Feb 28, 2024 at 6:36=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >>
> >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> >>
> >> > On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.com> wrote=
:
> >> >>
> >> >> Hi all,
> >> >>
> >> >> I would like to discuss bpf qdisc in the BPF track. As we now try t=
o
> >> >> support bpf qdisc using struct_ops, we found some limitations of
> >> >> bpf/struct_ops. While some have been discussed briefly on the maili=
ng
> >> >> list, we can discuss in more detail to make struct_ops a more
> >> >> generic/palatable approach to replace kernel functions.
> >> >>
> >> >> In addition, I would like to discuss supporting adding kernel objec=
ts
> >> >> to bpf_list/rbtree, which may have performance benefits in some
> >> >> applications and can improve the programming experience. The curren=
t
> >> >> bpf fq in the RFC has a 6% throughput loss compared to the native
> >> >> counterpart due to memory allocation in enqueue() to store skb kptr=
.
> >> >> With a POC I wrote that allows adding skb to bpf_list, the throughp=
ut
> >> >> becomes comparable. We can discuss the approach and other potential
> >> >> use cases.
> >> >>
> >> >
> >> > When discussing this with Toke (Cc'd) long ago for the XDP queueing
> >> > patch set, we discussed the same thing, in that the sk_buff already
> >> > has space for a list or rbnode due to it getting queued in other
> >> > layers (TCP OoO queue, qdiscs, etc.) so it would make sense to teach
> >> > the verifier that it is a valid bpf_list_node and bpf_rb_node and
> >> > allow inserting it as an element into a BPF list or rbtree. Back the=
n
> >> > we didn't add that as the posting only used the PIFO map.
> >> >
> >> > I think not only sk_buff, you can do a similar thing with xdp_buff a=
s
> >> > well.
> >>
> >> Yeah, I agree that allowing skbs to be inserted directly into a BPF
> >> rbtree would make a lot of sense if it can be done safely. I am less
> >> sure about xdp_frames, mostly for performance reasons, but if it does
> >> turn out to be useful whichever mechanism we add for skbs should be
> >> fairly straight forward to reuse.
> >>
> >> > The verifier side changes should be fairly minimal, just allowing th=
e
> >> > use of a known kernel type as the contained object in a list or
> >> > rbtree, and the field pointing to this allowlisted list or rbnode.
> >>
> >> I think one additional concern here is how we ensure that an skb has
> >> been correctly removed from any rbtrees it sits in before it is being
> >> transmitted to another part of the stack?
> >
> > I think one solution is to disallow shared ownership of skb in
> > multiple lists or rbtrees. That is, users should not be able to
> > acquire the reference of an skb from the ctx more than once in
> > ".enqueue" or using bpf_refcount_acquire().
>
> Can the verifier enforce this, even across multiple enqueue/dequeue
> calls? Not sure if acquiring a refcount ensures that the rbtree entry
> has been cleared?
>
> Basically, I'm worried about a dequeue() op that does something like:
>
> skb =3D rbtree_head();
> // skb->rbnode is not cleared
> return skb; // stack will keep processing it
>
> I'm a little fuzzy on how the bpf rbtree stuff works, though, so maybe
> the verifier is already ensuring that a node cannot be read from a tree
> without being properly cleared from it?
>

I think it should be ok. I'm not exactly sure what ownership scheme
the BPF qdisc stuff will follow, but the verifier is able to
distinguish between the cases where an skb would just be viewed but
inserted in an rbtree, vs when it is fully owned by the program and
not in the rbtree (say when removed from it). Therefore, it should be
possible to ensure unique ownership at any point of time.

> -Toke
>
>

