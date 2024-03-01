Return-Path: <bpf+bounces-23186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D886E993
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67D01C2568E
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884E3A8C5;
	Fri,  1 Mar 2024 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUKos7sF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB863A1B0
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321335; cv=none; b=UipFdq+eYZUUro0OatzJzThO7lx+0aiSTs+q9GalMReBRpWX5S2sWdbl6WokzbSR2lH5vKBiyUKqAi4CzCvmfxNu1onNcbQKL9zrCDm1QL+Y5G0l4OGuv1n0fl0L+LPeY5OBpkpTpWuYKSRUSYQtqxlVUvMWS1ZR1sS3+5hriB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321335; c=relaxed/simple;
	bh=g+e3mZs1Dhu/hBN776jwsQYKweuEu6VcBgGb1OdDlEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kb+ATePcVtc4vVY1veb3qIIFWysb9uksK+0fHAHA0aWR8V8Eptg0ETJIrqaT7hWuocqSbuQZHtcllAYn93hx0A/PEzphcz0ZPZ565SJW8R9Kd5RsIljRTfhOMX8Sbm9BVRfiNJg+MRdQTYTOjSdHB1VXduEDMI9nwutL8IZ5EOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUKos7sF; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2728780276.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709321333; x=1709926133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T99UXa2IN7xnJuBJxit4fGUTu8QkVWMos9GoMRL/yIs=;
        b=TUKos7sFHWmhm/i2VM7ZBQjFEn/Lt6WSXVGGUAgo81XuOWNKLkahQ/p6TqWQuwvJAz
         LZuxacAUUlIIlS2BPAZjU76s/U57AVnUHxtYnh6RKOxAOJcVN22QJtPiSU0se8/F0Pvd
         BTVD0JsUi9miLnk35sTjP+VfTuCUINXkg6iX0AmEBHydqE0BOB/ujMkDvdikf71gtdF/
         WZZDByPm3wF14II4/iklkVXS3i5t1ElFQIx8rzGYwGfzDwRTqdG99+6+jfWzI24ogfBJ
         66YXCyimv2+wiEVgDNBnXeFmKhwBQu5GC936sNUsNlrsnJ3ioLp9++wi7KHBrO95KKJv
         iyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321333; x=1709926133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T99UXa2IN7xnJuBJxit4fGUTu8QkVWMos9GoMRL/yIs=;
        b=bFst1JMjJuTPEnnzK8gtgcnKBu6Bd8AjqiknmPE66orzWPG+F8NX43UCOznwU5NGOr
         /JXYtOSMaA3qg01iuuR5QOEeSS3mV5gVPbmi+zpLacxO24NlG7tmTgLL7uRuSI4k9BgF
         QoRwNrQHxrvyx77FRcfCQ8iu6qWvJKlTQdZcyMHVNU3f7cDgjyQOfu2wA1PsxnD/bsHQ
         F1FT/b8qKcZY+HSMrAx4iBY9SK99FXIpFxbFJJ9EWE7L1A3lsSFFHSfSIU8o9/nCGXSs
         ntKtsP2HzGH6NVxWMLytXVKN/684OA87HUeS8QIkhHah9K43GKQWdSq6jIDZiHX+I5Rn
         hasw==
X-Forwarded-Encrypted: i=1; AJvYcCXHWrUhy5SrizaIDwDCz5CK2o2H29IQefuF9tT15uLgNF9zDtHqqEEbmbwu+XXu7SGY4fsZHt3Ta7CDbUPgaj00a7hX
X-Gm-Message-State: AOJu0YzIE6Ma/bQl3RB6sND7/fb9xTUwReg48z9f3SiDuyPOI9JcTL1+
	66opfaZtqE6w1oYg73QevoDXDCNHxhvAH1KfEZKs+LuyYYqjEbFohON+fojsHsoZU6G17kn41uA
	RfgN7DbkyF1JAwb5ZJACsdv+gmck=
X-Google-Smtp-Source: AGHT+IHLavGJ4MT0lR0FFMVewJMSeyfLXMk1f1ASJjO4euBK1eJm9MU5tGNUjkQE6Rnq6DcY165h4GrhHSrtTG0n/8Q=
X-Received: by 2002:a25:810b:0:b0:dc6:e75d:d828 with SMTP id
 o11-20020a25810b000000b00dc6e75dd828mr2436004ybk.18.1709321332860; Fri, 01
 Mar 2024 11:28:52 -0800 (PST)
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
 <CAP01T74B54OXbnk9eAzLvhQJWEc=Q50ys66zS7uMpDbVG_o2cw@mail.gmail.com>
In-Reply-To: <CAP01T74B54OXbnk9eAzLvhQJWEc=Q50ys66zS7uMpDbVG_o2cw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 1 Mar 2024 11:28:42 -0800
Message-ID: <CAMB2axPj5_a=s=iVqy+BfrWdnK9H4mzganUHYNK_oMxD7VTTsw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 7:06=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Fri, 1 Mar 2024 at 16:01, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > On Fri, Mar 1, 2024 at 6:08=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> > >
> > > Amery Hung <ameryhung@gmail.com> writes:
> > >
> > > > On Wed, Feb 28, 2024 at 6:36=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rg=
ensen <toke@redhat.com> wrote:
> > > >>
> > > >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> > > >>
> > > >> > On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.com> w=
rote:
> > > >> >>
> > > >> >> Hi all,
> > > >> >>
> > > >> >> I would like to discuss bpf qdisc in the BPF track. As we now t=
ry to
> > > >> >> support bpf qdisc using struct_ops, we found some limitations o=
f
> > > >> >> bpf/struct_ops. While some have been discussed briefly on the m=
ailing
> > > >> >> list, we can discuss in more detail to make struct_ops a more
> > > >> >> generic/palatable approach to replace kernel functions.
> > > >> >>
> > > >> >> In addition, I would like to discuss supporting adding kernel o=
bjects
> > > >> >> to bpf_list/rbtree, which may have performance benefits in some
> > > >> >> applications and can improve the programming experience. The cu=
rrent
> > > >> >> bpf fq in the RFC has a 6% throughput loss compared to the nati=
ve
> > > >> >> counterpart due to memory allocation in enqueue() to store skb =
kptr.
> > > >> >> With a POC I wrote that allows adding skb to bpf_list, the thro=
ughput
> > > >> >> becomes comparable. We can discuss the approach and other poten=
tial
> > > >> >> use cases.
> > > >> >>
> > > >> >
> > > >> > When discussing this with Toke (Cc'd) long ago for the XDP queue=
ing
> > > >> > patch set, we discussed the same thing, in that the sk_buff alre=
ady
> > > >> > has space for a list or rbnode due to it getting queued in other
> > > >> > layers (TCP OoO queue, qdiscs, etc.) so it would make sense to t=
each
> > > >> > the verifier that it is a valid bpf_list_node and bpf_rb_node an=
d
> > > >> > allow inserting it as an element into a BPF list or rbtree. Back=
 then
> > > >> > we didn't add that as the posting only used the PIFO map.
> > > >> >
> > > >> > I think not only sk_buff, you can do a similar thing with xdp_bu=
ff as
> > > >> > well.
> > > >>
> > > >> Yeah, I agree that allowing skbs to be inserted directly into a BP=
F
> > > >> rbtree would make a lot of sense if it can be done safely. I am le=
ss
> > > >> sure about xdp_frames, mostly for performance reasons, but if it d=
oes
> > > >> turn out to be useful whichever mechanism we add for skbs should b=
e
> > > >> fairly straight forward to reuse.
> > > >>
> > > >> > The verifier side changes should be fairly minimal, just allowin=
g the
> > > >> > use of a known kernel type as the contained object in a list or
> > > >> > rbtree, and the field pointing to this allowlisted list or rbnod=
e.
> > > >>
> > > >> I think one additional concern here is how we ensure that an skb h=
as
> > > >> been correctly removed from any rbtrees it sits in before it is be=
ing
> > > >> transmitted to another part of the stack?
> > > >
> > > > I think one solution is to disallow shared ownership of skb in
> > > > multiple lists or rbtrees. That is, users should not be able to
> > > > acquire the reference of an skb from the ctx more than once in
> > > > ".enqueue" or using bpf_refcount_acquire().
> > >
> > > Can the verifier enforce this, even across multiple enqueue/dequeue
> > > calls? Not sure if acquiring a refcount ensures that the rbtree entry
> > > has been cleared?
> > >
> > > Basically, I'm worried about a dequeue() op that does something like:
> > >
> > > skb =3D rbtree_head();
> > > // skb->rbnode is not cleared
> > > return skb; // stack will keep processing it
> > >
> > > I'm a little fuzzy on how the bpf rbtree stuff works, though, so mayb=
e
> > > the verifier is already ensuring that a node cannot be read from a tr=
ee
> > > without being properly cleared from it?
> > >
> >
> > I see what you are saying now, and thanks Kumar for the clarification!
> >
> > I was thinking about how to prevent an skb from being added to lists
> > and rbtrees at the same time, since list and rbnode share the same
> > space. Hence the suggestion.
> >
>
> In BPF qdisc programs, you could teach the verifier that the skb has
> reference semantics (ref_obj_id > 0),
> in such a case once you push it into a list or rbtree, the program
> will lose ownership of the skb and all pointers same as the skb will
> be marked invalid.
> You could use some peek helper to look at it, but will never have an
> skb with program ownership until you pop it back from a list or
> rbtree.
>

This part makes sense. In the enqueue() op of bpf qdisc, I use a kfunc
to acquire an skb kptr (ref_obj_id > 0) from the skb in ctx for now.
Martin suggested tracking reads from ctx and assigning ref_obj_id.

However, either way, if users can do this multiple times in one
enqueue() call like below, they can acquire multiple references to the
same skb and put them on different lists/rbtrees. This is what I'd
like to avoid.

SEC("struct_ops/bpf_fifo_enqueue")
int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
struct bpf_sk_buff_ptr *to_free)
{
        ...
        skb_kptr_a =3D bpf_skb_acquire(skb);
        skb_kptr_b =3D bpf_skb_acquire(skb);

        bpf_list_push_back(&list_1, skb_kptr_a->bpf_list);
        bpf_list_push_back(&list_2, skb_kptr_b->bpf_list);
        ...

Thanks,
Amery

> In the XDP queueing series, we taught the verifier to have reference
> semantics for xdp_md in the dequeue program, and then return such a
> pointer from the program back to the kernel.
> The changes to allow PTR_TO_PACKET accesses were also fairly simple,
> the verifier just needs to know that comparison of data, data_end can
> only be done for pkt pointers coming from the same xdp_md (as there
> can be multiple in the same program at a time).

