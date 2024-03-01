Return-Path: <bpf+bounces-23145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645B86E3DB
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADC9FB216E1
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 15:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09D3A8F2;
	Fri,  1 Mar 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7bCE+kw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D45394
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305269; cv=none; b=Xhh7PVCS+WSYKe2LhC8/l4sT+q1VTL4jOLcCipNiE+1/CDBIrEIH/4AZIk6V74uKTddOeXYYTtOqOtqQkjvVTn4iVBvORs5DD533GJrmviBTfiNHH6/sz4iM/FhApWkRaMb4Uf9OYI476HgoVTw6lxTz6Uj9rslajpSQY9K30BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305269; c=relaxed/simple;
	bh=fSc88OnuNTNWFGM0tceENrMeR9pVj55ZdRaKIdwfVDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b05pn+psLh+AdMWy/mFsSdKf7fonh7+O0atZsz6YSR1R5whdJgdwLPKLFxiXF8xrpw+ODMyQVRPTdFcltgCgtGbr0iiycxJZwWEvujMDTzd4qiFN5bWzBZBZFRTtzmMHppi1dZ2N9rGjUbE0uM/WoE48JMQk1hScznxkmaJ46lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7bCE+kw; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso2219302276.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 07:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709305266; x=1709910066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSc88OnuNTNWFGM0tceENrMeR9pVj55ZdRaKIdwfVDM=;
        b=b7bCE+kwreQ/1n7cpQ5rBo55SWF95Jne5B/PbFFLRysBeJc2PS4PokhFeUug+xbJ8R
         MRa2suwCjOFW+O2YFSXs4LpDA07v6+OPSrpElZ1apcrlbSZxqf0oTAJukDNplwZeUoFN
         CMoc388wmQgCVXtuedtQzHsaHPdGDwTYhCi7cRaebiXzyJ7X59as6l57+Xw8XjrNWLQH
         rEX8HvVKrn9zBjbYj52GB/kauvc50ve2JnAqw9Xr1tIFPgLK/N/9JyLljmUionajvPmQ
         axse21kKUOZ+sydglfAcMnrKaLx/Z6OEVybTz8VrgyvRwyEGobYfOMXls1MggGxl4v2X
         bc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709305266; x=1709910066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSc88OnuNTNWFGM0tceENrMeR9pVj55ZdRaKIdwfVDM=;
        b=b5BU35uniyvCU3s50y+ukt0CxXDur7+0kLwVx33WGFKeki1kgOtT5zQvIktbgSPDRX
         DP9a+OvIXz9CNbkgPjzCm980RQPyXxG/ljy7pN1WOSFloN4rT/orFujkvRvhJcO/8jdg
         xQfbkju2lxZsfJwG/xGTc1BdQ9FrtfEc8Yq1sQoLkOjGNM6G2uL+D4ze854ELb/eiyQG
         GptIciuKZAzVo+90QQTKfdk3+G5TgyRtMvEXXlnxuD4ibvtm3s0fX4MVmPAOTs8rkwIy
         woOPO+TaGnwiQQ4X+zHUyMYNXP7P0FVj/XadaOW6/jIJCAIviV88cITBb3Vv8rui9Yil
         JbiA==
X-Forwarded-Encrypted: i=1; AJvYcCWYX77RAgTAG3kDEFYIaoUg1489erATMiNH7wy4Jmqa3AAN0hx7Wf6xNZKcfcYEn23qv52I4O1u6E0nVzNahvimXL1X
X-Gm-Message-State: AOJu0Yz8fPGhFfKSeOZobefY3Gj1HHmWlWgf7ppkKWB1wAVJ2b8Zz1Yy
	49YKiVbu9+D2ioQG0M54guqZj7jJGh7sIoHkjucUx6Pxzp7MUNEbKC5uJVxkmR0rT150xIBDQOz
	DnSZ0MXlqtp77JJGi5WPK/Txo+BHjc5WWj3U=
X-Google-Smtp-Source: AGHT+IEFme1B+1Z8txCPzhcaDdDMqNRAgD7ZSqVoma1yNKkQ0GsiSa8Sp6NtMuhU5H/t+F/3jylP124UnOxbuIqIfUw=
X-Received: by 2002:a25:5f51:0:b0:dc6:be64:cfd1 with SMTP id
 h17-20020a255f51000000b00dc6be64cfd1mr1705781ybm.36.1709305266536; Fri, 01
 Mar 2024 07:01:06 -0800 (PST)
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
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 1 Mar 2024 07:00:54 -0800
Message-ID: <CAMB2axOvfVfFFrmAkJanpJN8-W1j+XmuJcsgzvd-9WRWeqrCEw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, lsf-pc@lists.linux-foundation.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:08=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
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

I see what you are saying now, and thanks Kumar for the clarification!

I was thinking about how to prevent an skb from being added to lists
and rbtrees at the same time, since list and rbnode share the same
space. Hence the suggestion.

> -Toke
>

