Return-Path: <bpf+bounces-23211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B486ECF1
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 00:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C731C21B8B
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F95EE8F;
	Fri,  1 Mar 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrLsUJOQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F55EE8B
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709335822; cv=none; b=Mr62QZu9JfFQ0YRdIAU6iHTeNjpyZGoaoT9cgjMuKmncId7hkI8uwpabxxgLSfu4Vne4wndloZs0cy2pfh+QBcOApA9RTrP0gMBLbmAJ43jBPvCjOq+oSkkiKm04BG2HPbGqKQ2oaaZDxSiw+tqYaushS8iFb18K0Df2QKKqWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709335822; c=relaxed/simple;
	bh=hiBpEM43RGPpZaTEIOYDNq9bboBklAZ69n7uu+rZ+Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGrM1J0mL0OT4bQOSclyObV/JtiHNujjjmf11NzqXaWgzoXQmVsl04egwLnA+o3xTF5cF0Z+zRWQjPAPfspeFaIKvuU4/syigu5qznMoKc7Em4EhmJP/sdhBQN69jHeYNsbT5wD3a0SZkaH5ZivkdEeRJ8fXEaBMGgvuBkYORw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrLsUJOQ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc74435c428so2929559276.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709335820; x=1709940620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5B78i3f4q1MnhgahVgQ/Bj1+tkpNQEqMbVuxeiKZOA=;
        b=nrLsUJOQSC+4pIA4s7QR7HhAmublyRXy+1e3W1luQAbcE0JB6TsMUjHSjpl4dA6pex
         rrQI+6dh1CpW8leOoBQdCsnDtXtSqSz3VW20pRYiqT7xdGZRPDP5bWNa+doxLv1/tNVF
         3GeQCaQC3cKtwEiCgL1URLV6UoV9LFSdDRj+UxF+uVAC42xttmIx/RkOGIc32AKtDQbx
         CkgHsXPuDQhTsUoLaQA5jPr+f/SDuTdvCa80X8uoZU2RuEycxHbkEX+Mz3zxpt4qNaLT
         XKxIK1uBLdXsJUbqMqtOsn1ggim5aKrYk2T9jFsKT2sXoVHSVN+YSVxrF9RcFY5/EjgZ
         /1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709335820; x=1709940620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5B78i3f4q1MnhgahVgQ/Bj1+tkpNQEqMbVuxeiKZOA=;
        b=ENB9w1Xh5uGYPFg6d/vWICjHBS090gaKJXjF2xoCewysp5iuYaVpnNg+tXjnmYtM+V
         xX2Wmy6+HoRNJqj/V3KG2hkb/ShRDsWm9hKd4IxMK+KfpQhF8g+qQhQf3Sed8FlsKL+4
         rYL2mRYnNV+5dV//veLA/mJsEYMIaRv6Gw/Es7FGEG6CWWQ/Ma3hiusTsFnSv9RcZ+TM
         5s6quAlnm+FBgC1LZRUKuzXIse0+nmDHSZAF2EbQY4h0PHUDO1o7IikrrACmZ79ZcHwo
         KqHdsCTHZFRsquL4PVs2NDUS+rhUVDyGMvxVB5y7D6QpCvMT0tZEZrFXuiD1A6Sur7J5
         HKnA==
X-Forwarded-Encrypted: i=1; AJvYcCW7kBbXBaqsRfFuFM1r1dT63483B1ZqdByND/s2Suto1NKOhrdXLVtwjVyD1cL1jL/YcvkVZJqis/+UdqRrWNwaGNNz
X-Gm-Message-State: AOJu0Yxq8aZST/uvlzHq28JiZq9qA3RaRsis/BRoyrhRZNWQsm8KjFmV
	rwK3SMW05FfKkLBhBnMAVwB9Bv+tHDvXECA/PM1Hy2IA5jChKQYcGdHdeEe/IyRBc6q9RQe49fM
	jacMO7iPpv9HFsLDiBh+Sc9f0BOWndggB
X-Google-Smtp-Source: AGHT+IFFW7x2d67zbWFpebjBlyna9n82miNk+0U67NaTJ917i7CPaicsbNHxlkIwSQ70KkM3uIb5bsNoTEjhr9x8BhU=
X-Received: by 2002:a25:ac1:0:b0:dcd:2aa3:d73b with SMTP id
 184-20020a250ac1000000b00dcd2aa3d73bmr2360146ybk.50.1709335819944; Fri, 01
 Mar 2024 15:30:19 -0800 (PST)
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
 <CAMB2axPj5_a=s=iVqy+BfrWdnK9H4mzganUHYNK_oMxD7VTTsw@mail.gmail.com> <CAP01T77a-Tjf9z6Td8-GjnH5t3O5gQMBeic459TUtO+s3HxMAQ@mail.gmail.com>
In-Reply-To: <CAP01T77a-Tjf9z6Td8-GjnH5t3O5gQMBeic459TUtO+s3HxMAQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 1 Mar 2024 15:30:08 -0800
Message-ID: <CAMB2axOUOn7DOGsyJcZ83aWb9tGCwmiLm0_yuZit+24-xY2ORQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:08=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 1 Mar 2024 at 20:28, Amery Hung <ameryhung@gmail.com> wrote:
> >
> > On Fri, Mar 1, 2024 at 7:06=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> > >
> > > On Fri, 1 Mar 2024 at 16:01, Amery Hung <ameryhung@gmail.com> wrote:
> > > >
> > > > On Fri, Mar 1, 2024 at 6:08=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rge=
nsen <toke@redhat.com> wrote:
> > > > >
> > > > > Amery Hung <ameryhung@gmail.com> writes:
> > > > >
> > > > > > On Wed, Feb 28, 2024 at 6:36=E2=80=AFAM Toke H=C3=B8iland-J=C3=
=B8rgensen <toke@redhat.com> wrote:
> > > > > >>
> > > > > >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> > > > > >>
> > > > > >> > On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.co=
m> wrote:
> > > > > >> >>
> > > > > >> >> Hi all,
> > > > > >> >>
> > > > > >> >> I would like to discuss bpf qdisc in the BPF track. As we n=
ow try to
> > > > > >> >> support bpf qdisc using struct_ops, we found some limitatio=
ns of
> > > > > >> >> bpf/struct_ops. While some have been discussed briefly on t=
he mailing
> > > > > >> >> list, we can discuss in more detail to make struct_ops a mo=
re
> > > > > >> >> generic/palatable approach to replace kernel functions.
> > > > > >> >>
> > > > > >> >> In addition, I would like to discuss supporting adding kern=
el objects
> > > > > >> >> to bpf_list/rbtree, which may have performance benefits in =
some
> > > > > >> >> applications and can improve the programming experience. Th=
e current
> > > > > >> >> bpf fq in the RFC has a 6% throughput loss compared to the =
native
> > > > > >> >> counterpart due to memory allocation in enqueue() to store =
skb kptr.
> > > > > >> >> With a POC I wrote that allows adding skb to bpf_list, the =
throughput
> > > > > >> >> becomes comparable. We can discuss the approach and other p=
otential
> > > > > >> >> use cases.
> > > > > >> >>
> > > > > >> >
> > > > > >> > When discussing this with Toke (Cc'd) long ago for the XDP q=
ueueing
> > > > > >> > patch set, we discussed the same thing, in that the sk_buff =
already
> > > > > >> > has space for a list or rbnode due to it getting queued in o=
ther
> > > > > >> > layers (TCP OoO queue, qdiscs, etc.) so it would make sense =
to teach
> > > > > >> > the verifier that it is a valid bpf_list_node and bpf_rb_nod=
e and
> > > > > >> > allow inserting it as an element into a BPF list or rbtree. =
Back then
> > > > > >> > we didn't add that as the posting only used the PIFO map.
> > > > > >> >
> > > > > >> > I think not only sk_buff, you can do a similar thing with xd=
p_buff as
> > > > > >> > well.
> > > > > >>
> > > > > >> Yeah, I agree that allowing skbs to be inserted directly into =
a BPF
> > > > > >> rbtree would make a lot of sense if it can be done safely. I a=
m less
> > > > > >> sure about xdp_frames, mostly for performance reasons, but if =
it does
> > > > > >> turn out to be useful whichever mechanism we add for skbs shou=
ld be
> > > > > >> fairly straight forward to reuse.
> > > > > >>
> > > > > >> > The verifier side changes should be fairly minimal, just all=
owing the
> > > > > >> > use of a known kernel type as the contained object in a list=
 or
> > > > > >> > rbtree, and the field pointing to this allowlisted list or r=
bnode.
> > > > > >>
> > > > > >> I think one additional concern here is how we ensure that an s=
kb has
> > > > > >> been correctly removed from any rbtrees it sits in before it i=
s being
> > > > > >> transmitted to another part of the stack?
> > > > > >
> > > > > > I think one solution is to disallow shared ownership of skb in
> > > > > > multiple lists or rbtrees. That is, users should not be able to
> > > > > > acquire the reference of an skb from the ctx more than once in
> > > > > > ".enqueue" or using bpf_refcount_acquire().
> > > > >
> > > > > Can the verifier enforce this, even across multiple enqueue/deque=
ue
> > > > > calls? Not sure if acquiring a refcount ensures that the rbtree e=
ntry
> > > > > has been cleared?
> > > > >
> > > > > Basically, I'm worried about a dequeue() op that does something l=
ike:
> > > > >
> > > > > skb =3D rbtree_head();
> > > > > // skb->rbnode is not cleared
> > > > > return skb; // stack will keep processing it
> > > > >
> > > > > I'm a little fuzzy on how the bpf rbtree stuff works, though, so =
maybe
> > > > > the verifier is already ensuring that a node cannot be read from =
a tree
> > > > > without being properly cleared from it?
> > > > >
> > > >
> > > > I see what you are saying now, and thanks Kumar for the clarificati=
on!
> > > >
> > > > I was thinking about how to prevent an skb from being added to list=
s
> > > > and rbtrees at the same time, since list and rbnode share the same
> > > > space. Hence the suggestion.
> > > >
> > >
> > > In BPF qdisc programs, you could teach the verifier that the skb has
> > > reference semantics (ref_obj_id > 0),
> > > in such a case once you push it into a list or rbtree, the program
> > > will lose ownership of the skb and all pointers same as the skb will
> > > be marked invalid.
> > > You could use some peek helper to look at it, but will never have an
> > > skb with program ownership until you pop it back from a list or
> > > rbtree.
> > >
> >
> > This part makes sense. In the enqueue() op of bpf qdisc, I use a kfunc
> > to acquire an skb kptr (ref_obj_id > 0) from the skb in ctx for now.
> > Martin suggested tracking reads from ctx and assigning ref_obj_id.
> >
> > However, either way, if users can do this multiple times in one
> > enqueue() call like below, they can acquire multiple references to the
> > same skb and put them on different lists/rbtrees. This is what I'd
> > like to avoid.
> >
> > SEC("struct_ops/bpf_fifo_enqueue")
> > int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
> > struct bpf_sk_buff_ptr *to_free)
> > {
> >         ...
> >         skb_kptr_a =3D bpf_skb_acquire(skb);
> >         skb_kptr_b =3D bpf_skb_acquire(skb);
>
> Yeah, this acquire kfunc is the root cause. That basically is a sign
> that 'multiple references are ok' even though that's not the case.
> It would have been the least intrusive way to allow skb kptrs, but it
> wouldn't work well to enforce unique ownership of the skb.
>
> Instead of this, we could teach the verifier that a struct ops
> argument can be an acquired pointer being passed as a parameter to the
> BPF program.
> Then, on entry into the program, it would have a reference state
> created for it and the corresponding ref_obj_id be assigned to that
> when loading it from ctx.
> When the reference state goes away, loading it again from ctx will
> just mark it as an unknown scalar or return an error.

This seems to be the more natural way to enforce such semantics rather
than hacking kfuncs. I will try to incorporate this into the next RFC.
Thank you!

-Amery

>
> Then, you can only push the skb into a list or rbtree once.
>
> >
> >         bpf_list_push_back(&list_1, skb_kptr_a->bpf_list);
> >         bpf_list_push_back(&list_2, skb_kptr_b->bpf_list);
> >         ...
> >
> > Thanks,
> > Amery
> >
> > > In the XDP queueing series, we taught the verifier to have reference
> > > semantics for xdp_md in the dequeue program, and then return such a
> > > pointer from the program back to the kernel.
> > > The changes to allow PTR_TO_PACKET accesses were also fairly simple,
> > > the verifier just needs to know that comparison of data, data_end can
> > > only be done for pkt pointers coming from the same xdp_md (as there
> > > can be multiple in the same program at a time).

