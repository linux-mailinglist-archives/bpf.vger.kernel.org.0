Return-Path: <bpf+bounces-23149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F0D86E407
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718B31F23638
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB341C6E;
	Fri,  1 Mar 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+tKQuxS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB813987B
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305604; cv=none; b=dC8EInSvca68GAqw+bOm5e3JqhhqZoBSymJ0TovwFEBV/7Tivwqm7r9M4nzXT9uwxHjLjRCe8xXJCkQsPKbThr0DdItQ12iIIcBzgtmS9j4N402YVeX9hRM2tD8W1TUjxOrD2Gi1q3pqb1fcN71hSSVyceLg++YUilTJLshYbFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305604; c=relaxed/simple;
	bh=YVnb9TMFnuRQoPyCqxRThbBRRXQwNkm9KVEeyRMDNVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAIf4wlqs6cFlBuRjkTOWHxSe/mXFH0r9sdOx52O2N3bsQCu9dK46iRQL1cwDwWWzun3Rivl+s/3Eggy6Mmf1UBk0uI8WgfyiGvwJsy/29dO2wv5dBjyaPcHUpyNaOjxkWp42YY2UP2Sm3+cpCrxtFTUnkueTnC5BpBQm91XKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+tKQuxS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709305601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVnb9TMFnuRQoPyCqxRThbBRRXQwNkm9KVEeyRMDNVQ=;
	b=B+tKQuxSblSG2Dsr+ZKR1fWRJI/0m6ofh7CoiHWXFiyLH3DDvPDXGEepbKntAHxPQtsiqb
	IKuy/RLeqzBIULLBGy2dltzB2KjMyLLPy3F6ErElagV/tbqB3vnXmNLIuevASAyS7qSZoo
	fvbXcueyn8/aT2jbOQDmZBug69fE+gM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-W9qegzwpPpOibNkXSGETZw-1; Fri, 01 Mar 2024 10:06:39 -0500
X-MC-Unique: W9qegzwpPpOibNkXSGETZw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a449ac4522cso40883666b.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 07:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709305594; x=1709910394;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVnb9TMFnuRQoPyCqxRThbBRRXQwNkm9KVEeyRMDNVQ=;
        b=PYQmcP7wVQkR3g4IbzwJTHmRZua0grBKKb+9/xpGonPCFF5eWneYUNWWiZSB9/HrvW
         u2OPatyzlV6cH+AzhUuS+T+BzEnzk06J3H88CLexA+GZx1S0tXGWU3s5e/SBaieUiuAN
         iZg9Hpsoc6w7htXnR6Z7zt6RWHONL78WAVl2tHb/IJXbSl+l+DovVEQKarViolLXuShk
         rc11Cq1sp5qOgqm9Y+PiRWvLWDaJPM4rJvvdTTmcv8E336ET82YN0exn6iBiHLMl67QO
         QblHtDXRm+Yc3ekCtIqap6EhuhRjksTIVAo44YQoxnJ1pHkOtbU2gh942mZmQtGCnRl6
         m24Q==
X-Forwarded-Encrypted: i=1; AJvYcCV704DOSC3nhMf9UvN85UDPswXDMxSvvt9fmcOTISIXGSDxsGaPD4qMCfCkhYpoFG+bTL68pChlbqfWdjYO6nO5BGMY
X-Gm-Message-State: AOJu0YwaK31sXtfnCIbQlFwMp9T2SC5IC3s/BsCxTr1g+c7iX/yS3j5P
	j3PqedhKNrjokq5HmxOfWK6Ii4E2Kc1yec+4yCx/v2q39ywMmjeW7MjEO029AlmsisQdfF7yHY9
	H4GZDVoICJoYkyES09AqbUQBzh2tq9ifrFUkVpWfRh4H5rTLp9g==
X-Received: by 2002:a17:906:d7b1:b0:a44:16e:2618 with SMTP id pk17-20020a170906d7b100b00a44016e2618mr1484901ejb.48.1709305594562;
        Fri, 01 Mar 2024 07:06:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJzNJZOJHDMQPKrIPHcagRSasATjXL4p8cYOMoG35zwD+PEwHYd8dT9dzCd4YWa+P2J8xSVw==
X-Received: by 2002:a17:906:d7b1:b0:a44:16e:2618 with SMTP id pk17-20020a170906d7b100b00a44016e2618mr1484863ejb.48.1709305593526;
        Fri, 01 Mar 2024 07:06:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090608c900b00a42f36174c7sm1782846eje.92.2024.03.01.07.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:06:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C784E112E9B3; Fri,  1 Mar 2024 16:06:32 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
In-Reply-To: <CAMB2axOvfVfFFrmAkJanpJN8-W1j+XmuJcsgzvd-9WRWeqrCEw@mail.gmail.com>
References: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
 <CAP01T76R0bqdNK+LkObuVTej_TRwEB9HnvwJaTTsRrr1Y8_WmA@mail.gmail.com>
 <878r34ejv1.fsf@toke.dk>
 <CAMB2axO3B-ziNt9AFM+Xkr1H0WQzzhaThi1PO-xKcGP3cNtxQQ@mail.gmail.com>
 <87le729h9l.fsf@toke.dk>
 <CAMB2axOvfVfFFrmAkJanpJN8-W1j+XmuJcsgzvd-9WRWeqrCEw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Mar 2024 16:06:32 +0100
Message-ID: <87a5ni9ekn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amery Hung <ameryhung@gmail.com> writes:

> On Fri, Mar 1, 2024 at 6:08=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
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
> I see what you are saying now, and thanks Kumar for the clarification!
>
> I was thinking about how to prevent an skb from being added to lists
> and rbtrees at the same time, since list and rbnode share the same
> space. Hence the suggestion.

Ah, yes, good point, that is also a concern, certainly!

-Toke


