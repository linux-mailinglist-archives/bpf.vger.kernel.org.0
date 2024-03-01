Return-Path: <bpf+bounces-23140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF5786E2FF
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A12C1C21AB7
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0836EEEB;
	Fri,  1 Mar 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXwTHnEz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A46EB79
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302110; cv=none; b=WpRHWkIFHnuxuwAN4KF5dneAYNFWOp/7hZUkXiP/PpMjex9/eR3kJ6vz0J5tRURm+SVNEjQ6CvU4idrtWrdBfwldf7k3s0TMhqqL+hinff1eBMHw2bBkatEbpMeJLplhyK6pOojPOI+Ea6YIRx5F7HxXXa2gk96KOYbfGX/tG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302110; c=relaxed/simple;
	bh=g/sZy6B7Tga7p9gz55vrAAJyoOe8pZxsoC50bk64Dis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VBudgz16NgJJdzqM7ZJwP/s8o0qRBQ9wF/Uk4TLRzp6BPXdXCBISuCYWumA3JTYh2W38ir1tGnG3HgA65Px2supZ8yETsdtcIil294s+hOkJaxai4OY9xfLj4rHIrjorz9Ccj+BIyfkGklNl/9Em/St00u44Y+9G3wl07DDwWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXwTHnEz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709302107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/sZy6B7Tga7p9gz55vrAAJyoOe8pZxsoC50bk64Dis=;
	b=KXwTHnEzaapGfzBW6RAtxHCPftOUkCvbbhpU4VpeTvzkE14NBJpLdQieUE27cJ1/nMXU+6
	rVeJ6TSFRKx2oVPnAy+OvfQDgDG+hZ+uWkIwVmXR5v9tN5IRkWw4b9191TpyJRULGEqqNy
	ncDRDylxFpCi+m+D9D5Rbhw5s9hm54I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-6nAHbkygP-KqgWDh1Ki6Jg-1; Fri, 01 Mar 2024 09:08:25 -0500
X-MC-Unique: 6nAHbkygP-KqgWDh1Ki6Jg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a44508b6b22so119120866b.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 06:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302103; x=1709906903;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/sZy6B7Tga7p9gz55vrAAJyoOe8pZxsoC50bk64Dis=;
        b=aeef2UZkHrzRk6jrnjyaIval73uQUegWtz7QSZisZEyIrq89n+QWgQt4fYC85/ev2s
         8qNKPxVsUWgO6rmi995FN1xycOx6zyZaow8pqNRzjdlx31YMtrJHiVorztbfF8A0/krz
         EaHePv511vBjZlgaINC8SX1jO9BSP5IZoSMXlFUadAckvMSJ0xXg+FkEXRibkUZAwpr7
         pFLGYgTZv+/74ZQJf9UAcqwnfQcUu2Y/U57/mp/Oh5D/jmmkssgadnfSD7Wvaa5INgRU
         0B1/+J/AoA1mry3Y3K7QbWh6SKkSreJYu92IUzMD02/pkLU3meJ0pnEmffQeiysrHnFX
         SMVA==
X-Forwarded-Encrypted: i=1; AJvYcCUadHcr5cBOoJQPVy1BYGBIsQ4GG/rd5spFH7W3UKRoRrBvIc0Ach+gt0aEP8yKjhzY8H4hE8aDReODrpes1xrUjKT5
X-Gm-Message-State: AOJu0YxU3GGionjfih7p3dgwZd6ALOuC3mGkj24AsQz2Pjlv/2RriJU0
	U+1iBKGDqICmGxK83S1omw3c4aP6QAxcpJaADxX7hQClc4NsHD7hbhE+hKDoaTbEBKyKcnoF3qJ
	M/fEiUncZHYuC82a/UAS4+uWPBIZ0qcDpTZy1ag5uQd9OHeTv/gWBsL+MXg==
X-Received: by 2002:a17:906:2dcc:b0:a3f:70bc:bfe4 with SMTP id h12-20020a1709062dcc00b00a3f70bcbfe4mr1185289eji.31.1709302103578;
        Fri, 01 Mar 2024 06:08:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdVUxW1hSTDqtzH0xW+b/PUridE4fApPWqzEF2/iuvIXMfrUHYVi9JZt+U4FnWyTcLIPon9A==
X-Received: by 2002:a17:906:2dcc:b0:a3f:70bc:bfe4 with SMTP id h12-20020a1709062dcc00b00a3f70bcbfe4mr1185269eji.31.1709302103214;
        Fri, 01 Mar 2024 06:08:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id qu24-20020a170907111800b00a433e8cfb7esm1732209ejb.64.2024.03.01.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:08:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 77B5E112E993; Fri,  1 Mar 2024 15:08:22 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
In-Reply-To: <CAMB2axO3B-ziNt9AFM+Xkr1H0WQzzhaThi1PO-xKcGP3cNtxQQ@mail.gmail.com>
References: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
 <CAP01T76R0bqdNK+LkObuVTej_TRwEB9HnvwJaTTsRrr1Y8_WmA@mail.gmail.com>
 <878r34ejv1.fsf@toke.dk>
 <CAMB2axO3B-ziNt9AFM+Xkr1H0WQzzhaThi1PO-xKcGP3cNtxQQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Mar 2024 15:08:22 +0100
Message-ID: <87le729h9l.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amery Hung <ameryhung@gmail.com> writes:

> On Wed, Feb 28, 2024 at 6:36=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>> > On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.com> wrote:
>> >>
>> >> Hi all,
>> >>
>> >> I would like to discuss bpf qdisc in the BPF track. As we now try to
>> >> support bpf qdisc using struct_ops, we found some limitations of
>> >> bpf/struct_ops. While some have been discussed briefly on the mailing
>> >> list, we can discuss in more detail to make struct_ops a more
>> >> generic/palatable approach to replace kernel functions.
>> >>
>> >> In addition, I would like to discuss supporting adding kernel objects
>> >> to bpf_list/rbtree, which may have performance benefits in some
>> >> applications and can improve the programming experience. The current
>> >> bpf fq in the RFC has a 6% throughput loss compared to the native
>> >> counterpart due to memory allocation in enqueue() to store skb kptr.
>> >> With a POC I wrote that allows adding skb to bpf_list, the throughput
>> >> becomes comparable. We can discuss the approach and other potential
>> >> use cases.
>> >>
>> >
>> > When discussing this with Toke (Cc'd) long ago for the XDP queueing
>> > patch set, we discussed the same thing, in that the sk_buff already
>> > has space for a list or rbnode due to it getting queued in other
>> > layers (TCP OoO queue, qdiscs, etc.) so it would make sense to teach
>> > the verifier that it is a valid bpf_list_node and bpf_rb_node and
>> > allow inserting it as an element into a BPF list or rbtree. Back then
>> > we didn't add that as the posting only used the PIFO map.
>> >
>> > I think not only sk_buff, you can do a similar thing with xdp_buff as
>> > well.
>>
>> Yeah, I agree that allowing skbs to be inserted directly into a BPF
>> rbtree would make a lot of sense if it can be done safely. I am less
>> sure about xdp_frames, mostly for performance reasons, but if it does
>> turn out to be useful whichever mechanism we add for skbs should be
>> fairly straight forward to reuse.
>>
>> > The verifier side changes should be fairly minimal, just allowing the
>> > use of a known kernel type as the contained object in a list or
>> > rbtree, and the field pointing to this allowlisted list or rbnode.
>>
>> I think one additional concern here is how we ensure that an skb has
>> been correctly removed from any rbtrees it sits in before it is being
>> transmitted to another part of the stack?
>
> I think one solution is to disallow shared ownership of skb in
> multiple lists or rbtrees. That is, users should not be able to
> acquire the reference of an skb from the ctx more than once in
> ".enqueue" or using bpf_refcount_acquire().

Can the verifier enforce this, even across multiple enqueue/dequeue
calls? Not sure if acquiring a refcount ensures that the rbtree entry
has been cleared?

Basically, I'm worried about a dequeue() op that does something like:

skb =3D rbtree_head();
// skb->rbnode is not cleared
return skb; // stack will keep processing it

I'm a little fuzzy on how the bpf rbtree stuff works, though, so maybe
the verifier is already ensuring that a node cannot be read from a tree
without being properly cleared from it?

-Toke


