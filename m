Return-Path: <bpf+bounces-23150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81EC86E408
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 16:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDB01F23077
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BB543AD8;
	Fri,  1 Mar 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRYhYKKd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610D3987B
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305611; cv=none; b=QWQHm3EMMidXmZE/5CpVvo9p/fWsEiMrR1KXMkaQzBWqBQlUNroF5kYlgX15wMgD1eqoCSSgPYVLKr2qtF/GaJHD0+JdcLgKqvlI638Lh/AziByeqOjfEMqxhh5dgz26lmGwn+YoQKqpf8Ec3iToNaJ4Jg6+kkEephOKicHve+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305611; c=relaxed/simple;
	bh=Cy009/vj2yFSUAK4JL7zCWDxH9GpKuPEZfyi2myxI+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtqnHtII7oPkhjAm2//eu/NlpDvRpR3UXE0qL2HyUIgXT3rnz1QBJAoQGUibs19ew++HCHSx4V6JiAcy7x0TxNISG2eguGDAWX/Kq7v0dct8nHzfohRfRctOHCcjZDIZJVY8UCMDEkjMktH38GsjA1c8I44qd2e6+j0tLt9APpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRYhYKKd; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so3929573a12.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709305608; x=1709910408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy009/vj2yFSUAK4JL7zCWDxH9GpKuPEZfyi2myxI+s=;
        b=lRYhYKKd/kpDsvc0GqKK8e05oJZIql8VHal6d/DSyPgfarEMWOPnLFiJG6OlffVGsH
         UG595bgUylhbXQ8uZhM2QrA4rmskzbHnmmQDzlLYaEHIumAzDIje1cSx/ffReKqvMeiP
         +wVrmhSu5/S95JvxMSyaIlmg2LPKHClo176OChbKkc/C5XsQBm1WQdJfnNLlvsWV+MdY
         jpSqf1bzDDvGZWG7Migdhnjr50ziPqTakOucsY+e9H5SduV1RdXBk3kf9qXmuH6xLVkg
         L3V5xtXTHdfpGqqkJqm2FLMvQtlkIGhKPUGjgDvgwG8LGT5rDDTmgE1mo+pp11lf7iNQ
         ibdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709305608; x=1709910408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy009/vj2yFSUAK4JL7zCWDxH9GpKuPEZfyi2myxI+s=;
        b=hZc4Hex/YlRfaQKpwX8WDVdJaCSbR8jGfbf0t9Bl72vP4WIKm6PCVwwlXifbabd1dZ
         YXNhkDtM+N2HXMVm0tFNzCjKcGpoMN4DeQ6IsC04h31NArHOVuMJ5DTWHVWCYX6gFubs
         pDfxWdrir/48rNmZtJLCy5AE8a0EzGM/8HaTjFrQCdKlVvaZ1N7meMw4BeZgso9ItM0i
         fDpYvhqm+prJpeUy69BB8YIspMcgC/Snb2VeLQP8RzIdQLjliiLq6PIpdszYKmeBwjGA
         GBK6IDnUD44hCOFK2lKDMRKlG5kxp7Ick8VhX1WnI68bzh5vNQvPl/fb7kattQFQAu6y
         3iHA==
X-Forwarded-Encrypted: i=1; AJvYcCUQcAQ9GTXMz8IA1t4Zg7qlANdEXqRDYBMRSTH6silXJo+7iawZyxqO/BrT5Naa7vyPDxHIB3CdlQgGCYUVxb43nrqm
X-Gm-Message-State: AOJu0YwXQCL9OHYBrczKWiXlmkAiGEq0IxWEBd2m/VYz09ACmcsTa5GR
	C9bxcAFwZvzKvC0okYbBWsO4FBhOLA8jtB2tIvXtKpB7xf8NbTYjOMB4ZSCuvKtL9xCTfEyvSWe
	LSY/bZLXQ33iGaf4Pt1OHJ794InauUMik58E=
X-Google-Smtp-Source: AGHT+IFcPgEJItzfXo5SCf4RdZRXQEGyBEx3M8fo18iG/UNfiV/QKJ2pZuYq9gNuc2NzEi5F5b/p+zmu+93e/XqMIZE=
X-Received: by 2002:a50:c8cb:0:b0:561:3b53:d0af with SMTP id
 k11-20020a50c8cb000000b005613b53d0afmr1615835edh.12.1709305607958; Fri, 01
 Mar 2024 07:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
 <CAP01T76R0bqdNK+LkObuVTej_TRwEB9HnvwJaTTsRrr1Y8_WmA@mail.gmail.com>
 <878r34ejv1.fsf@toke.dk> <CAMB2axO3B-ziNt9AFM+Xkr1H0WQzzhaThi1PO-xKcGP3cNtxQQ@mail.gmail.com>
 <87le729h9l.fsf@toke.dk> <CAMB2axOvfVfFFrmAkJanpJN8-W1j+XmuJcsgzvd-9WRWeqrCEw@mail.gmail.com>
In-Reply-To: <CAMB2axOvfVfFFrmAkJanpJN8-W1j+XmuJcsgzvd-9WRWeqrCEw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 1 Mar 2024 16:06:11 +0100
Message-ID: <CAP01T74B54OXbnk9eAzLvhQJWEc=Q50ys66zS7uMpDbVG_o2cw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
To: Amery Hung <ameryhung@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 at 16:01, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Fri, Mar 1, 2024 at 6:08=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
> >
> > Amery Hung <ameryhung@gmail.com> writes:
> >
> > > On Wed, Feb 28, 2024 at 6:36=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> > >>
> > >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> > >>
> > >> > On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.com> wro=
te:
> > >> >>
> > >> >> Hi all,
> > >> >>
> > >> >> I would like to discuss bpf qdisc in the BPF track. As we now try=
 to
> > >> >> support bpf qdisc using struct_ops, we found some limitations of
> > >> >> bpf/struct_ops. While some have been discussed briefly on the mai=
ling
> > >> >> list, we can discuss in more detail to make struct_ops a more
> > >> >> generic/palatable approach to replace kernel functions.
> > >> >>
> > >> >> In addition, I would like to discuss supporting adding kernel obj=
ects
> > >> >> to bpf_list/rbtree, which may have performance benefits in some
> > >> >> applications and can improve the programming experience. The curr=
ent
> > >> >> bpf fq in the RFC has a 6% throughput loss compared to the native
> > >> >> counterpart due to memory allocation in enqueue() to store skb kp=
tr.
> > >> >> With a POC I wrote that allows adding skb to bpf_list, the throug=
hput
> > >> >> becomes comparable. We can discuss the approach and other potenti=
al
> > >> >> use cases.
> > >> >>
> > >> >
> > >> > When discussing this with Toke (Cc'd) long ago for the XDP queuein=
g
> > >> > patch set, we discussed the same thing, in that the sk_buff alread=
y
> > >> > has space for a list or rbnode due to it getting queued in other
> > >> > layers (TCP OoO queue, qdiscs, etc.) so it would make sense to tea=
ch
> > >> > the verifier that it is a valid bpf_list_node and bpf_rb_node and
> > >> > allow inserting it as an element into a BPF list or rbtree. Back t=
hen
> > >> > we didn't add that as the posting only used the PIFO map.
> > >> >
> > >> > I think not only sk_buff, you can do a similar thing with xdp_buff=
 as
> > >> > well.
> > >>
> > >> Yeah, I agree that allowing skbs to be inserted directly into a BPF
> > >> rbtree would make a lot of sense if it can be done safely. I am less
> > >> sure about xdp_frames, mostly for performance reasons, but if it doe=
s
> > >> turn out to be useful whichever mechanism we add for skbs should be
> > >> fairly straight forward to reuse.
> > >>
> > >> > The verifier side changes should be fairly minimal, just allowing =
the
> > >> > use of a known kernel type as the contained object in a list or
> > >> > rbtree, and the field pointing to this allowlisted list or rbnode.
> > >>
> > >> I think one additional concern here is how we ensure that an skb has
> > >> been correctly removed from any rbtrees it sits in before it is bein=
g
> > >> transmitted to another part of the stack?
> > >
> > > I think one solution is to disallow shared ownership of skb in
> > > multiple lists or rbtrees. That is, users should not be able to
> > > acquire the reference of an skb from the ctx more than once in
> > > ".enqueue" or using bpf_refcount_acquire().
> >
> > Can the verifier enforce this, even across multiple enqueue/dequeue
> > calls? Not sure if acquiring a refcount ensures that the rbtree entry
> > has been cleared?
> >
> > Basically, I'm worried about a dequeue() op that does something like:
> >
> > skb =3D rbtree_head();
> > // skb->rbnode is not cleared
> > return skb; // stack will keep processing it
> >
> > I'm a little fuzzy on how the bpf rbtree stuff works, though, so maybe
> > the verifier is already ensuring that a node cannot be read from a tree
> > without being properly cleared from it?
> >
>
> I see what you are saying now, and thanks Kumar for the clarification!
>
> I was thinking about how to prevent an skb from being added to lists
> and rbtrees at the same time, since list and rbnode share the same
> space. Hence the suggestion.
>

In BPF qdisc programs, you could teach the verifier that the skb has
reference semantics (ref_obj_id > 0),
in such a case once you push it into a list or rbtree, the program
will lose ownership of the skb and all pointers same as the skb will
be marked invalid.
You could use some peek helper to look at it, but will never have an
skb with program ownership until you pop it back from a list or
rbtree.

In the XDP queueing series, we taught the verifier to have reference
semantics for xdp_md in the dequeue program, and then return such a
pointer from the program back to the kernel.
The changes to allow PTR_TO_PACKET accesses were also fairly simple,
the verifier just needs to know that comparison of data, data_end can
only be done for pkt pointers coming from the same xdp_md (as there
can be multiple in the same program at a time).

