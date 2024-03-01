Return-Path: <bpf+bounces-23144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552CD86E339
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 15:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C191D1F21E7B
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D16F077;
	Fri,  1 Mar 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZxgq5ZD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA9316FF56
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302990; cv=none; b=kgI8ktCeGLg5ywWBYpV6zVXibYq8a229qP5FL0crHrJ+ISOKOZtO5YuT2BH9Bk2fg7QIvq9lhojfFJvcklLx0zWcOrmirfUKlTn3k8dTX/mrIZhoiyqUBbsjNeMQA4qPH1k22npPeX9qs3nqkUOk+IF+y+WS8RC/ZH+lM6HgcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302990; c=relaxed/simple;
	bh=fmjyMR50N9A0Z5bRYjsJ3gslww7GSwym8cCQP73MYDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J4Et3oFNUUBIdSVtOzQLSGBNMz9Pw1maPenqU1PoCEfiRewn7pBoBZguDagt9ImesISeOE0kKz7MIHdUB18hPNwXBjP8FPtEZlM/mcPN4ztxfpfbG4VP2sICvo9exIFR184NVcYaV5UNtRMHE2jZ7oyVkSq+XHFUzQ5bfzUk8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZxgq5ZD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709302987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmjyMR50N9A0Z5bRYjsJ3gslww7GSwym8cCQP73MYDo=;
	b=UZxgq5ZDqyYIP5c268qvAEy0EGiNMAklqrUVghRiUYl0Rxh++wom0noPuadcrmOkmlbDX9
	TnHqFR9KrZrCR8PcyEyQw2ltrFy0G4/EJiV9O/PWzeBmPf2bg/EsvIh5TuqDbzEna1cIb/
	u5E+vVpPIRLh3pX9fOaWJSqY6JqzE6o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-jBcxae1iNQu5msrdSRtAvA-1; Fri, 01 Mar 2024 09:23:06 -0500
X-MC-Unique: jBcxae1iNQu5msrdSRtAvA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a448cfe2266so75848066b.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 06:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709302985; x=1709907785;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmjyMR50N9A0Z5bRYjsJ3gslww7GSwym8cCQP73MYDo=;
        b=SMbVri9bB+tJ/bHhLr2cH7ZA7Up+BhFzk+INtvmKMDzP5J/uh8MUcKmZiJxxYuPRYC
         kccGVegsNfu9J0MoRA7faMzwAZ+tLahtVq3Y0vpJ/0U0enBlIKyxGTb0QleSulO9ncku
         HY1hKzJSLQpvX4V0pYylHL6/iRcezGZhLlffJjT0wG3sAs/twexldV+dgcJJrQYiu6Fj
         C+VS8dfn0Lol8QZ7tbqI13R++E7DLbvP6t1LdW4QRIOJVSjo6kSeBREJ3liYSfpQYtOJ
         z6fATfB6Jb9Eym0nsvHZbwf42AxbaabtckZBhyCYNhWzT6kHk4vWukVnIM9Q05yAqzOe
         /uSA==
X-Forwarded-Encrypted: i=1; AJvYcCUfCLxa0upx+7C2U2JUZ9NyRHmdvNsYm7+ljQxZyLfl3V0WRDYjlLXaRFN9V2j2FtarT+OKmaH18tauXA5JmnFI28I9
X-Gm-Message-State: AOJu0YwLKebN5fpJTZD6IcImR/0F2T8eY4NR0DI74qgvvUzPY6Gdd/1T
	F5Fgy6aqrRWyJggoVfYXWkftfN2Sdp1amWX9Sek0NWLCnD5x+dibYiD37ZBKlVg7MloDIhLsuEP
	rIAyKI9EzcXBdFa5m1ubMVm6X0D1cYVkh8zxeQqt1AitKP872AQ==
X-Received: by 2002:a17:906:3db:b0:a44:3f8d:dcbc with SMTP id c27-20020a17090603db00b00a443f8ddcbcmr1393662eja.60.1709302985492;
        Fri, 01 Mar 2024 06:23:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBe/o49rpHI3BzhFvtYnE6YJgqCFPXJ8bdRX/urIfzThxgWC6JtEUmsqKsN4a3EC/f0GeKHQ==
X-Received: by 2002:a17:906:3db:b0:a44:3f8d:dcbc with SMTP id c27-20020a17090603db00b00a443f8ddcbcmr1393641eja.60.1709302985019;
        Fri, 01 Mar 2024 06:23:05 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gu24-20020a170906f29800b00a4426363f95sm1744386ejb.208.2024.03.01.06.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:23:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 28060112E99A; Fri,  1 Mar 2024 15:23:04 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, lsf-pc@lists.linux-foundation.org,
 bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
In-Reply-To: <CAP01T76K7gsk=qyVGXkmk=8tZfKV==z62mFeurz-P7tQKWNAWw@mail.gmail.com>
References: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
 <CAP01T76R0bqdNK+LkObuVTej_TRwEB9HnvwJaTTsRrr1Y8_WmA@mail.gmail.com>
 <878r34ejv1.fsf@toke.dk>
 <CAMB2axO3B-ziNt9AFM+Xkr1H0WQzzhaThi1PO-xKcGP3cNtxQQ@mail.gmail.com>
 <87le729h9l.fsf@toke.dk>
 <CAP01T76K7gsk=qyVGXkmk=8tZfKV==z62mFeurz-P7tQKWNAWw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Mar 2024 15:23:04 +0100
Message-ID: <87frxa9gl3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Fri, 1 Mar 2024 at 15:08, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>>
>> Amery Hung <ameryhung@gmail.com> writes:
>>
>> > On Wed, Feb 28, 2024 at 6:36=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
>> >>
>> >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>> >>
>> >> > On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.com> wrot=
e:
>> >> >>
>> >> >> Hi all,
>> >> >>
>> >> >> I would like to discuss bpf qdisc in the BPF track. As we now try =
to
>> >> >> support bpf qdisc using struct_ops, we found some limitations of
>> >> >> bpf/struct_ops. While some have been discussed briefly on the mail=
ing
>> >> >> list, we can discuss in more detail to make struct_ops a more
>> >> >> generic/palatable approach to replace kernel functions.
>> >> >>
>> >> >> In addition, I would like to discuss supporting adding kernel obje=
cts
>> >> >> to bpf_list/rbtree, which may have performance benefits in some
>> >> >> applications and can improve the programming experience. The curre=
nt
>> >> >> bpf fq in the RFC has a 6% throughput loss compared to the native
>> >> >> counterpart due to memory allocation in enqueue() to store skb kpt=
r.
>> >> >> With a POC I wrote that allows adding skb to bpf_list, the through=
put
>> >> >> becomes comparable. We can discuss the approach and other potential
>> >> >> use cases.
>> >> >>
>> >> >
>> >> > When discussing this with Toke (Cc'd) long ago for the XDP queueing
>> >> > patch set, we discussed the same thing, in that the sk_buff already
>> >> > has space for a list or rbnode due to it getting queued in other
>> >> > layers (TCP OoO queue, qdiscs, etc.) so it would make sense to teach
>> >> > the verifier that it is a valid bpf_list_node and bpf_rb_node and
>> >> > allow inserting it as an element into a BPF list or rbtree. Back th=
en
>> >> > we didn't add that as the posting only used the PIFO map.
>> >> >
>> >> > I think not only sk_buff, you can do a similar thing with xdp_buff =
as
>> >> > well.
>> >>
>> >> Yeah, I agree that allowing skbs to be inserted directly into a BPF
>> >> rbtree would make a lot of sense if it can be done safely. I am less
>> >> sure about xdp_frames, mostly for performance reasons, but if it does
>> >> turn out to be useful whichever mechanism we add for skbs should be
>> >> fairly straight forward to reuse.
>> >>
>> >> > The verifier side changes should be fairly minimal, just allowing t=
he
>> >> > use of a known kernel type as the contained object in a list or
>> >> > rbtree, and the field pointing to this allowlisted list or rbnode.
>> >>
>> >> I think one additional concern here is how we ensure that an skb has
>> >> been correctly removed from any rbtrees it sits in before it is being
>> >> transmitted to another part of the stack?
>> >
>> > I think one solution is to disallow shared ownership of skb in
>> > multiple lists or rbtrees. That is, users should not be able to
>> > acquire the reference of an skb from the ctx more than once in
>> > ".enqueue" or using bpf_refcount_acquire().
>>
>> Can the verifier enforce this, even across multiple enqueue/dequeue
>> calls? Not sure if acquiring a refcount ensures that the rbtree entry
>> has been cleared?
>>
>> Basically, I'm worried about a dequeue() op that does something like:
>>
>> skb =3D rbtree_head();
>> // skb->rbnode is not cleared
>> return skb; // stack will keep processing it
>>
>> I'm a little fuzzy on how the bpf rbtree stuff works, though, so maybe
>> the verifier is already ensuring that a node cannot be read from a tree
>> without being properly cleared from it?
>>
>
> I think it should be ok. I'm not exactly sure what ownership scheme
> the BPF qdisc stuff will follow, but the verifier is able to
> distinguish between the cases where an skb would just be viewed but
> inserted in an rbtree, vs when it is fully owned by the program and
> not in the rbtree (say when removed from it). Therefore, it should be
> possible to ensure unique ownership at any point of time.

Alright, cool. Thanks for clarifying! :)

-Toke


