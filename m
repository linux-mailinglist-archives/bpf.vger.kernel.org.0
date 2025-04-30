Return-Path: <bpf+bounces-57067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27035AA51B3
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228E21C20106
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F0126C05;
	Wed, 30 Apr 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH0USNqy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048C2641D8;
	Wed, 30 Apr 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030559; cv=none; b=AcZSsI7af2GksZ8BRSnG3WkFN0VugUbPglDTEFH2Fs7b/8rp7KxYmxttG3HzfDM9ZcqPru2e9sLk+GhLV8Aow+vnGdh3ZEodbmYXkOlY5MXYFbGhOySQ4bK8Pz+PJ3SfOCDKFJkI6XAKRlchHgESsKvAIA7O8WUCfA0cnmCbINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030559; c=relaxed/simple;
	bh=u70XBbVPx5nQc5CRmhxK7SEVU/8+kQaEYawHPX70naA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm0TYxbJxaiBWi0HNfELRiat5mtZq0vbGN72FESVoZNdwIdh8CMtFxJ7hxUDpKbTbRswkxqWSFkFHPZidixFYUuXl9C6H7lFsxezEj8tBs5+aN6U+sz3KD77UfFUSv0xnuse1hKC0/XFpgzXJq8kS7jeyWW6ITHpxrzm3yewuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH0USNqy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so33165e9.0;
        Wed, 30 Apr 2025 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746030555; x=1746635355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJZLV0Sll2PYEUOZWtyGELHHAeYU3ZMvyo1o32OOZOo=;
        b=gH0USNqycEw+1dw8uKEvY4YBLBY7FglB4YUw4xwsgUNa+l3JyMytabzsraDTg6eSia
         l4aZ6S9OB02lPBvsgqzQvgxBWDW2SoQCL5DD+tDOSOMC4axKsoXgdRpcWp+01D9cSnwx
         0FPmdYEoIdqRnoouw8bRQFL6Jq2cCDVYnPD0+KZhdD+bBuZMdZ5SKCochAtOlJU2iPqw
         iXe3E4eFeR+fmE7HHMHw0CTk+Ud1yrz2KpP+QQLJGpCkhz3ql2n7Ajq+BcZkpfWxuLdA
         klEfqXrOQZImWDKhI+nqK9s5F6xrAqSGaBvts2towUvb2ihjeLwT4wutoHEN5Ysfc1PA
         QWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746030555; x=1746635355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJZLV0Sll2PYEUOZWtyGELHHAeYU3ZMvyo1o32OOZOo=;
        b=XkQx8YzvarY5bLd/8czMPJ3JysJFezUPSBpYHbBUNgdJ1u9dEE1+qwZCgeSmjronfU
         kjiul/VccP1DbaKCLFJSJ9TMNoXy5X+fbMWtsokm9fAfcrEQfSGcOIGsJ5VSWM0gf1sV
         zMqw+holU26qcNKEDw8u3it2YI4rq3uNbXovrpM8jqcLzUJ7gy/XCVDbp0f67SDnZdw6
         PLAuzVZ/VQJRJbWI1OffJh+LJlqXjli/meJ0FqLdPltF60+EXEi+ikdGqygiU9fMqkZI
         THWT8hYDKUCJ4/+GWX3kIfQ1+iyUMQHazpZPzlSM0R8r9q7Uz2bYkHGHbC0n1q3zKTXK
         ZxFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGImrX+QFNCjBsoVbnVLVdNpJCcu01/urARlxVRDULEI+Ksy7Iev0gxXFLDqkWJ8qqyyE=@vger.kernel.org, AJvYcCWYqoRCaUoa+5PfGRhec6T6ijfZPlc4Lm0DhgVO/Yj3OQUXsgFlqPEPa+8EIn+tzrv3sBj+zaFv@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHzRy55Fjj0/j1/RsjFqGAG5tHCBytKZ1v1x2SrFW/1RSDBLS
	ruy8p2PacyjA4GaSBfbmEs5d5XvEVD9MR5HmQ7Tym0piNxP+E4sFmh+Z98mNQktfCQZrvYBvFwr
	jSNp+Qi/gv/oZqE1HS8kN5JoeBLM=
X-Gm-Gg: ASbGncvPfZxvaR3HDeDWXHFwylvyNjL0L1nzGs9k/xn5KD2PCkxTJ612EXKEvxtXYET
	rpmetiVeXr0+P6DERpN0UYi3aUhm98zCKBjD/0rg7T6UmaTTHmAXUEHKFBE1XxIKQAZBIC1KyzF
	QVacFXRvILgFfhySovsKu4ZmlmuNOpDfTLzs090g==
X-Google-Smtp-Source: AGHT+IHtfElgtG61hW/u6Xd1EZLtQ0iSGf0kTetWxLhfpufDWQSp+FSq5OoY16Z1ctreST2E4KRVyKDCaF5WzTUHDaM=
X-Received: by 2002:a05:600c:4ecc:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-441b2696cd2mr24821685e9.33.1746030555265; Wed, 30 Apr 2025
 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
 <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
 <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com> <CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com>
 <87frhqnh0e.fsf@toke.dk>
In-Reply-To: <87frhqnh0e.fsf@toke.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Apr 2025 09:29:04 -0700
X-Gm-Features: ATxdqUErKzZImGgqgFULhi6t18jxh2W3jtQ4NzOOT9a4hopKuAG6uSJBEggZxVs
Message-ID: <CAADnVQ+V3Tp1zgFb6yfZQgC8m9WhdQOZmmrAFetDb5sZNxXLQQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for packet metadata
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Arthur Fabre <arthur@arthurfabre.com>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>, jbrandeburg@cloudflare.com, 
	lbiancon@redhat.com, Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 2:19=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurfab=
re.com> wrote:
> >>
> >> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
> >> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthurf=
abre.com> wrote:
> >> > >
> >> > > +/**
> >> > > + * trait_set() - Set a trait key.
> >> > > + * @traits: Start of trait store area.
> >> > > + * @hard_end: Hard limit the trait store can currently grow up ag=
ainst.
> >> > > + * @key: The key to set.
> >> > > + * @val: The value to set.
> >> > > + * @len: The length of the value.
> >> > > + * @flags: Unused for now. Should be 0.
> >> > > + *
> >> > > + * Return:
> >> > > + * * %0       - Success.
> >> > > + * * %-EINVAL - Key or length invalid.
> >> > > + * * %-EBUSY  - Key previously set with different length.
> >> > > + * * %-ENOSPC - Not enough room left to store value.
> >> > > + */
> >> > > +static __always_inline
> >> > > +int trait_set(void *traits, void *hard_end, u64 key, const void *=
val, u64 len, u64 flags)
> >> > > +{
> >> > > +       if (!__trait_valid_key(key) || !__trait_valid_len(len))
> >> > > +               return -EINVAL;
> >> > > +
> >> > > +       struct __trait_hdr *h =3D (struct __trait_hdr *)traits;
> >> > > +
> >> > > +       /* Offset of value of this key. */
> >> > > +       int off =3D __trait_offset(*h, key);
> >> > > +
> >> > > +       if ((h->high & (1ull << key)) || (h->low & (1ull << key)))=
 {
> >> > > +               /* Key is already set, but with a different length=
 */
> >> > > +               if (__trait_total_length(__trait_and(*h, (1ull << =
key))) !=3D len)
> >> > > +                       return -EBUSY;
> >> > > +       } else {
> >> > > +               /* Figure out if we have enough room left: total l=
ength of everything now. */
> >> > > +               if (traits + sizeof(struct __trait_hdr) + __trait_=
total_length(*h) + len > hard_end)
> >> > > +                       return -ENOSPC;
> >> >
> >> > I'm still not excited about having two metadata-s
> >> > in front of the packet.
> >> > Why cannot traits use the same metadata space ?
> >> >
> >> > For trait_set() you already pass hard_end and have to check it
> >> > at run-time.
> >> > If you add the same hard_end to trait_get/del the kfuncs will deal
> >> > with possible corruption of metadata by the program.
> >> > Transition from xdp to skb will be automatic. The code won't care th=
at traits
> >> > are there. It will just copy all metadata from xdp to skb. Corrupted=
 or not.
> >> > bpf progs in xdp and skb might even use the same kfuncs
> >> > (or two different sets if the verifier is not smart enough right now=
).
> >>
> >> Good idea, that would solve the corruption problem.
> >>
> >> But I think storing metadata at the "end" of the headroom (ie where
> >> XDP metadata is today) makes it harder to persist in the SKB layer.
> >> Functions like __skb_push() assume that skb_headroom() bytes are
> >> available just before skb->data.
> >>
> >> They can be updated to move XDP metadata out of the way, but this
> >> assumption seems pretty pervasive.
> >
> > The same argument can be flipped.
> > Why does the skb layer need to push?
> > If it needs to encapsulate it will forward to tunnel device
> > to go on the wire. At this point any kind of metadata is going
> > to be lost on the wire. bpf prog would need to convert
> > metadata into actual on the wire format or stash it
> > or send to user space.
> > I don't see a use case where skb layer would move medadata by N
> > bytes, populate these N bytes with "???" and pass to next skb layer.
> > skb layers strip (pop) the header when it goes from ip to tcp to user s=
pace.
> > No need to move metadata.
> >
> >> By using the "front" of the headroom, we can hide that from the rest o=
f
> >> the SKB code. We could even update skb->head to completely hide the
> >> space used at the front of the headroom.
> >> It also avoids the cost of moving the metadata around (but maybe that
> >> would be insignificant).
> >
> > That's a theory. Do you actually have skb layers pushing things
> > while metadata is there?
>
> Erm, any encapsulation? UDP tunnels, wireguard, WiFi, etc. There are
> almost 1000 calls to skb_push() all over the kernel. One of the primary
> use cases for traits is to tag a packet with an ID to follow it
> throughout its lifetime inside the kernel. This absolutely includes
> encapsulation; in fact, having the tracing ID survive these kinds of
> transformations is one of the primary motivators for this work.

and the assumption here is that placing traits in the front will
be enough for all possible encaps that the stack can do?
Hopefully not. Moving traits due to skb_push() is mandatory anyway.

The other point you're arguing is that the current metadata approach
is broken, since it doesn't work for encap?
pskb_expand_head() does skb_metadata_clear().
Though I don't remember anyone complaining of that behavior,
let's assume it's a problem indeed.
With traits in front the pskb_expand_head() should either fail or move
traits when it runs out of room.
Let's be consistent and do the same for regular metadata.

My main point is we should not introduce a second kind of metadata.
If the current metadata doesn't quite work, fix it instead of adding
a new one.

