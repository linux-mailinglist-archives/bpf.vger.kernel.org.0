Return-Path: <bpf+bounces-23191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA5286EA11
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3F81C23562
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8993BBCD;
	Fri,  1 Mar 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6+xr+el"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCC39ACE
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323691; cv=none; b=kS3K0GFxKYK1BSxXI/8TRggUK0osTUf9aJmtR4fgWVGSl3cNndzF6VtbPDwuUEA2osqC7/z+OJLOxDMwlar5+wZgaRFvK1RtAkJvnsEoC6+IRwzfii9kDN22EEZNXBNVaLC47m1oalej/c8FP/N4cbXgOCLg1uUrSyP9IdmGx7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323691; c=relaxed/simple;
	bh=XZEoAW8j7FK4rHi/5y9R42ofrDeXGYmsy5nR0CWZZSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtFcX5MClQs8KIrkSuyqyiqSKxYJb2UZM2chKORSNvl2ooAPSmXNAKKsCEMhmrdAplUygWhfs5WzUzwbFlY9TNSqn/lKRLlKhqhcMWlwvQsLVktfiRJEWPoEDCW7PH1RjfuFxz+76O9MUrTB1au1dVAngk/ntSg4316wcrETDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6+xr+el; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a43dba50bb7so365451866b.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 12:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709323688; x=1709928488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4BWPIKnXHnscFGVDRM4lkRvF4ibCzbhbqTlfTTMLZM=;
        b=E6+xr+elYroJSwllL8lWz6Av/tuZcBjkKHNmpsiGQ/+BeLyoXtd8gWFrb1YFT61EKN
         MLmtGXJCR/wBVWMcvFt8LS1F46cvR0YVl47GXMf0diYoUjcTOjOEYoWzPqH5pmaHEjV0
         ZxuUWPQYSZPVKw5HO/IZLZPRranzkm6NvvtkYKGq4mdz8id08jCCSpNGfkWqCFRrJaPI
         URFL6FACWZwpWM0KDUBGlqZ228pI1hRLlreu1Tnf2TX2SAcRP+We2DSuz+kKT9Iet+/I
         9ZNkxvAbnC1VKmizoYB+tUJnvIe28WKWksIN/WrZTQYyHhVQzxAdMtuN2jlh5/qsOK1r
         Hxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709323688; x=1709928488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4BWPIKnXHnscFGVDRM4lkRvF4ibCzbhbqTlfTTMLZM=;
        b=dd7k5fJHWzfgElG1C0e86xXv6KHfOF8khnpHclKPHnlVdCtdXxYC1mPyIIyhu+Ulj0
         JNy67Qu9r+gyBZtzNPzb67jmdy3KtNYtdcThHFaBwvV61/qpPXnCmvlV9xRfUhz08nta
         h7R3/TvST/Xsnu+0Khr/0h+6Hl/OzDy0Kg0XX8Mlfd1rdCfvFnHxynAJs24bzPjQiHga
         C/7EBTphgMMyZdG0o6fl3ZVi1RjcRxZ9fidvUsBY0aoWhUszreFK/SDaFpVwkxAXevpe
         QMYEtHOUoNcbrredpNkvYXTrM0xuzukMXsGl0dCfLRttxQVhmzvLL+p3q6NzDarH8f9h
         weHg==
X-Forwarded-Encrypted: i=1; AJvYcCVFC5ucoxkdJ8Z3kzVby9GsR1hG6pWWS1VSRvZmR18g78tPV+sfBYw9KDvwN9WST3LcwTv++VyalGVCbP/9vfUgNtxc
X-Gm-Message-State: AOJu0YxYL4nCwq6ipH7Z3oP8uJvRMkbac6TNHjovY7NuiEmaOKPQ0+jc
	71orrAqf+rIYG2Qf6c1LxPfYcGav2BQrZZn/vV1JUOnu+RjycLNMycEUQ5nAjPa6EaxyXg94Og2
	8amV9qiHIvyyJEt5EIkx4HBoC4mE=
X-Google-Smtp-Source: AGHT+IEAtKUTikTcgrs3nIYZELTweg8gi0F6iiIc2XdjXV5xwoYMkOPsqgYHCRGvBZ3KRMhAakSWGLx/krA2XYKzmcw=
X-Received: by 2002:a17:906:5f90:b0:a44:29a4:46fb with SMTP id
 a16-20020a1709065f9000b00a4429a446fbmr1933664eju.16.1709323688018; Fri, 01
 Mar 2024 12:08:08 -0800 (PST)
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
 <CAP01T74B54OXbnk9eAzLvhQJWEc=Q50ys66zS7uMpDbVG_o2cw@mail.gmail.com> <CAMB2axPj5_a=s=iVqy+BfrWdnK9H4mzganUHYNK_oMxD7VTTsw@mail.gmail.com>
In-Reply-To: <CAMB2axPj5_a=s=iVqy+BfrWdnK9H4mzganUHYNK_oMxD7VTTsw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 1 Mar 2024 21:07:31 +0100
Message-ID: <CAP01T77a-Tjf9z6Td8-GjnH5t3O5gQMBeic459TUtO+s3HxMAQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
To: Amery Hung <ameryhung@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 at 20:28, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Fri, Mar 1, 2024 at 7:06=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > On Fri, 1 Mar 2024 at 16:01, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > On Fri, Mar 1, 2024 at 6:08=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
> > > >
> > > > Amery Hung <ameryhung@gmail.com> writes:
> > > >
> > > > > On Wed, Feb 28, 2024 at 6:36=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8=
rgensen <toke@redhat.com> wrote:
> > > > >>
> > > > >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> > > > >>
> > > > >> > On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.com>=
 wrote:
> > > > >> >>
> > > > >> >> Hi all,
> > > > >> >>
> > > > >> >> I would like to discuss bpf qdisc in the BPF track. As we now=
 try to
> > > > >> >> support bpf qdisc using struct_ops, we found some limitations=
 of
> > > > >> >> bpf/struct_ops. While some have been discussed briefly on the=
 mailing
> > > > >> >> list, we can discuss in more detail to make struct_ops a more
> > > > >> >> generic/palatable approach to replace kernel functions.
> > > > >> >>
> > > > >> >> In addition, I would like to discuss supporting adding kernel=
 objects
> > > > >> >> to bpf_list/rbtree, which may have performance benefits in so=
me
> > > > >> >> applications and can improve the programming experience. The =
current
> > > > >> >> bpf fq in the RFC has a 6% throughput loss compared to the na=
tive
> > > > >> >> counterpart due to memory allocation in enqueue() to store sk=
b kptr.
> > > > >> >> With a POC I wrote that allows adding skb to bpf_list, the th=
roughput
> > > > >> >> becomes comparable. We can discuss the approach and other pot=
ential
> > > > >> >> use cases.
> > > > >> >>
> > > > >> >
> > > > >> > When discussing this with Toke (Cc'd) long ago for the XDP que=
ueing
> > > > >> > patch set, we discussed the same thing, in that the sk_buff al=
ready
> > > > >> > has space for a list or rbnode due to it getting queued in oth=
er
> > > > >> > layers (TCP OoO queue, qdiscs, etc.) so it would make sense to=
 teach
> > > > >> > the verifier that it is a valid bpf_list_node and bpf_rb_node =
and
> > > > >> > allow inserting it as an element into a BPF list or rbtree. Ba=
ck then
> > > > >> > we didn't add that as the posting only used the PIFO map.
> > > > >> >
> > > > >> > I think not only sk_buff, you can do a similar thing with xdp_=
buff as
> > > > >> > well.
> > > > >>
> > > > >> Yeah, I agree that allowing skbs to be inserted directly into a =
BPF
> > > > >> rbtree would make a lot of sense if it can be done safely. I am =
less
> > > > >> sure about xdp_frames, mostly for performance reasons, but if it=
 does
> > > > >> turn out to be useful whichever mechanism we add for skbs should=
 be
> > > > >> fairly straight forward to reuse.
> > > > >>
> > > > >> > The verifier side changes should be fairly minimal, just allow=
ing the
> > > > >> > use of a known kernel type as the contained object in a list o=
r
> > > > >> > rbtree, and the field pointing to this allowlisted list or rbn=
ode.
> > > > >>
> > > > >> I think one additional concern here is how we ensure that an skb=
 has
> > > > >> been correctly removed from any rbtrees it sits in before it is =
being
> > > > >> transmitted to another part of the stack?
> > > > >
> > > > > I think one solution is to disallow shared ownership of skb in
> > > > > multiple lists or rbtrees. That is, users should not be able to
> > > > > acquire the reference of an skb from the ctx more than once in
> > > > > ".enqueue" or using bpf_refcount_acquire().
> > > >
> > > > Can the verifier enforce this, even across multiple enqueue/dequeue
> > > > calls? Not sure if acquiring a refcount ensures that the rbtree ent=
ry
> > > > has been cleared?
> > > >
> > > > Basically, I'm worried about a dequeue() op that does something lik=
e:
> > > >
> > > > skb =3D rbtree_head();
> > > > // skb->rbnode is not cleared
> > > > return skb; // stack will keep processing it
> > > >
> > > > I'm a little fuzzy on how the bpf rbtree stuff works, though, so ma=
ybe
> > > > the verifier is already ensuring that a node cannot be read from a =
tree
> > > > without being properly cleared from it?
> > > >
> > >
> > > I see what you are saying now, and thanks Kumar for the clarification=
!
> > >
> > > I was thinking about how to prevent an skb from being added to lists
> > > and rbtrees at the same time, since list and rbnode share the same
> > > space. Hence the suggestion.
> > >
> >
> > In BPF qdisc programs, you could teach the verifier that the skb has
> > reference semantics (ref_obj_id > 0),
> > in such a case once you push it into a list or rbtree, the program
> > will lose ownership of the skb and all pointers same as the skb will
> > be marked invalid.
> > You could use some peek helper to look at it, but will never have an
> > skb with program ownership until you pop it back from a list or
> > rbtree.
> >
>
> This part makes sense. In the enqueue() op of bpf qdisc, I use a kfunc
> to acquire an skb kptr (ref_obj_id > 0) from the skb in ctx for now.
> Martin suggested tracking reads from ctx and assigning ref_obj_id.
>
> However, either way, if users can do this multiple times in one
> enqueue() call like below, they can acquire multiple references to the
> same skb and put them on different lists/rbtrees. This is what I'd
> like to avoid.
>
> SEC("struct_ops/bpf_fifo_enqueue")
> int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
> struct bpf_sk_buff_ptr *to_free)
> {
>         ...
>         skb_kptr_a =3D bpf_skb_acquire(skb);
>         skb_kptr_b =3D bpf_skb_acquire(skb);

Yeah, this acquire kfunc is the root cause. That basically is a sign
that 'multiple references are ok' even though that's not the case.
It would have been the least intrusive way to allow skb kptrs, but it
wouldn't work well to enforce unique ownership of the skb.

Instead of this, we could teach the verifier that a struct ops
argument can be an acquired pointer being passed as a parameter to the
BPF program.
Then, on entry into the program, it would have a reference state
created for it and the corresponding ref_obj_id be assigned to that
when loading it from ctx.
When the reference state goes away, loading it again from ctx will
just mark it as an unknown scalar or return an error.

Then, you can only push the skb into a list or rbtree once.

>
>         bpf_list_push_back(&list_1, skb_kptr_a->bpf_list);
>         bpf_list_push_back(&list_2, skb_kptr_b->bpf_list);
>         ...
>
> Thanks,
> Amery
>
> > In the XDP queueing series, we taught the verifier to have reference
> > semantics for xdp_md in the dequeue program, and then return such a
> > pointer from the program back to the kernel.
> > The changes to allow PTR_TO_PACKET accesses were also fairly simple,
> > the verifier just needs to know that comparison of data, data_end can
> > only be done for pkt pointers coming from the same xdp_md (as there
> > can be multiple in the same program at a time).

