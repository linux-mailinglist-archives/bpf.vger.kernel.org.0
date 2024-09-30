Return-Path: <bpf+bounces-40551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB3989FD9
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 12:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7455E1F2184D
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 10:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7D18DF84;
	Mon, 30 Sep 2024 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyrMu3ev"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71218D646
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693547; cv=none; b=fsjqp+/jDOCjsy0TzRg9GzMgtaNQhFJQWJbBTQJ76moElvoHcRJbOnZMEUJszEKf9EOq6Iv2z7p14a3GQbF08vPNiA5+qPUKY7Mxkv/iBt2y7fMaJAIke09R+bA7VA9JbEWY30lLrre4JhgEJpjUAjPn4s7c+8vqQjQEkSzQBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693547; c=relaxed/simple;
	bh=1crqKxlABME7V1a2cRCTVjGrqO9LGFAyPiQoJOyoka8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RygNRTcv5nvVeyW8902WKBgApehRJaxyu1bRDTFDeFT9gJRxOYZlOZJtGYS794egabsKgR+XIxPsm+uMrkVMsoJRuxOUmtqyYTxymRBx+YQZKlN/dNBnHIsbHoA9lSvcuKAX+N2d0nxrgb0zYMai4N3qyuK4l1Oe0myc6+nqhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyrMu3ev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727693544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1crqKxlABME7V1a2cRCTVjGrqO9LGFAyPiQoJOyoka8=;
	b=gyrMu3ev+RAy+gViJ5WWFMyhyZMY57DxP9y5a6Gd4mntD2nu9EXEAKwq6v6+JfYQIPyCSU
	mPjyxdeym/JTtfMtarMEkysjgnUuOHRgEFw/CPisjO6ImPmbzLhBuJ68ZNiiLWvo8klQyu
	USJXotSuSG0qwMAXaQLA709JZp+b8jw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-uZFSIwp7MryspmJ67Xg6Sw-1; Mon, 30 Sep 2024 06:52:23 -0400
X-MC-Unique: uZFSIwp7MryspmJ67Xg6Sw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb830ea86so28004505e9.3
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 03:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693542; x=1728298342;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1crqKxlABME7V1a2cRCTVjGrqO9LGFAyPiQoJOyoka8=;
        b=dAmRLwMQdTcSmz/Jsn9TLZvfEcvyhPfcqRd7p0W+LAmZkjgC8rWD6ocivkMHgwq6AM
         tjGnfvaGz0sEJpCwYXsBmeUTJiIEnyI2egjAnBgfyJgU3ygPpQyDGrsA1S6ubNdxJktT
         +IDikfYC8BBeqxWSiH9DaepzVjZiBJZIF7e5Q0F9tgsPKRh/npGTZv4I50BPfp5PeJj5
         3gdQOQyW1MJQGL5RKABqEVRD3kHkHQHl+0Cl2DNr3Xqn1h7yo78/8XckO23+BYUKUu95
         m28hdRKldcMObNS7W2V1p2u0NVAB0I68L5D4Yzot0Zr7pfwOPzUiyNg/mpcUXKWu9BWd
         uG0g==
X-Forwarded-Encrypted: i=1; AJvYcCWcAsSaVnxuTor03Z0nVoEGb/hhZV7zwjBqPo96ZothyvQEU0zoitnMzDbDFjre53Xm0XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8xRyKHYmTQ+ombTmblUq7zbXtzYvO2FoiHqqxBk7oCfPGPRm
	/PWPGsTqIVU9iZFRb+3k6tLxTJ3u41UOBj+yfEZX3/AksdkLEVgqUtd8AvFOdA0C/sdzMXlIVcn
	z28MpJiO9t56CjQ5mmTdRFMlzw0ovAO6yNdmfDW6hurzcWGX/dQ==
X-Received: by 2002:a05:600c:a02:b0:42c:b750:19f3 with SMTP id 5b1f17b1804b1-42f582a2e20mr88275665e9.0.1727693541616;
        Mon, 30 Sep 2024 03:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQkFV5V+976Mgk8k6lSIZmUdX3GlirGqMhZwgwwlC98YTGA2Uo+QV2xWpR5EXh1ej9bi1mCw==
X-Received: by 2002:a05:600c:a02:b0:42c:b750:19f3 with SMTP id 5b1f17b1804b1-42f582a2e20mr88275495e9.0.1727693541055;
        Mon, 30 Sep 2024 03:52:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a361c3sm147580305e9.34.2024.09.30.03.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:52:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C6207157FE96; Mon, 30 Sep 2024 12:52:18 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Arthur Fabre <afabre@cloudflare.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, john.fastabend@gmail.com, edumazet@google.com,
 pabeni@redhat.com, sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, mst@redhat.com, jasowang@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, kernel-team
 <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
In-Reply-To: <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk> <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk> <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 30 Sep 2024 12:52:18 +0200
Message-ID: <874j5xs9b1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Arthur Fabre" <afabre@cloudflare.com> writes:

> On Fri Sep 27, 2024 at 12:24 PM CEST, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> "Arthur Fabre" <afabre@cloudflare.com> writes:
>>
>> >> >> The nice thing about an API like this, though, is that it's extens=
ible,
>> >> >> and the kernel itself can be just another consumer of it for the
>> >> >> metadata fields Lorenzo is adding in this series. I.e., we could j=
ust
>> >> >> pre-define some IDs for metadata vlan, timestamp etc, and use the =
same
>> >> >> functions as above from within the kernel to set and get those val=
ues;
>> >> >> using the registry, there could even be an option to turn those of=
f if
>> >> >> an application wants more space for its own usage. Or, alternative=
ly, we
>> >> >> could keep the kernel-internal IDs hardcoded and always allocated,=
 and
>> >> >> just use the getter/setter functions as the BPF API for accessing =
them.
>> >> >
>> >> > That's exactly what I'm thinking of too, a simple API like:
>> >> >
>> >> > get(u8 key, u8 len, void *val);
>> >> > set(u8 key, u8 len, void *val);
>> >> >
>> >> > With "well-known" keys like METADATA_ID_HW_HASH for hardware metada=
ta.
>> >> >
>> >> > If a NIC doesn't support a certain well-known metadata, the key
>> >> > wouldn't be set, and get() would return ENOENT.
>> >> >
>> >> > I think this also lets us avoid having to "register" keys or bits of
>> >> > metadata with the kernel.
>> >> > We'd reserve some number of keys for hardware metadata.
>> >>
>> >> Right, but how do you allocate space/offset for each key without an
>> >> explicit allocation step? You'd basically have to encode the list of =
IDs
>> >> in the metadata area itself, which implies a TLV format that you have=
 to
>> >> walk on every access? The registry idea in my example above was
>> >> basically to avoid that...
>> >
>> > I've been playing around with having a small fixed header at the front
>> > of the metadata itself, that lets you access values without walking th=
em
>> > all.
>> >
>> > Still WIP, and maybe this is too restrictive, but it lets you encode 64
>> > 2, 4, or 8 byte KVs with a single 16 byte header:
>>
>> Ohh, that's clever, I like it! :)
>>
>> It's also extensible in the sense that the internal representation can
>> change without impacting the API, so if we end up needing more bits we
>> can always add those.
>>
>> Maybe it would be a good idea to make the 'key' parameter a larger
>> integer type (function parameters are always 64-bit anyway, so might as
>> well go all the way up to u64)? That way we can use higher values for
>> the kernel-reserved types instead of reserving part of the already-small
>> key space for applications (assuming the kernel-internal data is stored
>> somewhere else, like in a static struct as in Lorenzo's patch)?
>
> Good idea! That makes it more extensible too if we ever support more
> keys or bigger lengths.
>
> I'm not sure where the kernel-reserved types should live. Putting them
> in here uses up some the of KV IDs, but it uses less head room space than=
=20
> always reserving a static struct for them.
> Maybe it doesn't matter much, as long as we use the same API to access
> them, we could internally switch between one and the other.

Yeah, as long as we can move them around, we can do the thing that makes
most sense from a performance PoV, and we can change it later if that
changes.

>>
>> [...]
>>
>> >> > The remaining keys would be up to users. They'd have to allocate ke=
ys
>> >> > to services, and configure services to use those keys.
>> >> > This is similar to the way listening on a certain port works: only =
one
>> >> > service can use port 80 or 443, and that can typically beconfigured=
 in
>> >> > a service's config file.
>> >>
>> >> Right, well, port numbers *do* actually have an out of band service
>> >> registry (IANA), which I thought was what we wanted to avoid? ;)
>> >
>> > Depends how you think about it ;)
>> >
>> > I think we should avoid a global registry. But having a registry per
>> > deployment / server doesn't seem awful. Services that want to use a
>> > field would have a config file setting to set which index it correspon=
ds
>> > to.
>> > Admins would just have to pick a free one on their system, and set it =
in
>> > the config file of the service.
>> >
>> > This is similar to what we do for non-IANA registered ports internally.
>> > For example each service needs a port on an internal interface to expo=
se
>> > metrics, and we just track which ports are taken in our config
>> > management.
>>
>> Right, this would work, but it assumes that applications are
>> well-behaved and do this correctly. Which they probably do in a
>> centrally-managed system like yours, but for random applications shipped
>> by distros, I'm not sure if it's going to work.
>>
>> In fact, it's more or less the situation we have with skb->mark today,
>> isn't it? I.e., applications can co-exist as long as they don't use the
>> same bits, so they have to coordinate on which bits to use. Sure, with
>> this scheme there will be more total bits to use, which can lessen the
>> pressure somewhat, but the basic problem remains. In other words, I
>> worry that in practice we will end up with another github repository
>> serving as a registry for metadata keys...
>
> That's true. If applications hardcode keys, we'll be back to having
> conflicts. If someone creates a registry on github I'll be very sad.
>
> (Maybe we can make the verifier enforce that the key passed to get() and
> set() isn't a constant? - only joking)
>
> Applications don't tend to do this for ports though, I think most can be
> configured to listen on any port. Is that just because it's been
> instilled as "good practice" over time? Could we try to do the same with
> some very stern documentation and examples?

Well, telling users "you're doing it wrong" hasn't been that successful
in the past, I'm afraid...

> Thinking about it more, my only relectance for a registration API is how
> to communicate the ID back to other consumers (our discussion below).
>
>>
>> > Dynamically registering fields means you have to share the returned ID
>> > with whoever is interested, which sounds tricky.
>> > If an XDP program sets a field like packet_id, every tracing
>> > program that looks at it, and userspace service, would need to know wh=
at
>> > the ID of that field is.
>> > Is there a way to easily share that ID with all of them?
>>
>> Right, so I'll admit this was one of the handwavy bits of my original
>> proposal, but I don't think it's unsolvable. You could do something like
>> (once, on application initialisation):
>>
>> __u64 my_key =3D bpf_register_metadata_field(my_size); /* maybe add a na=
me for introspection? */
>> bpf_map_update(&shared_application_config, &my_key_index, &my_key);
>>
>> and then just get the key out of that map from all programs that want to
>> use it?
>
> Passing it out of band works (whether it's via a pinned map like you
> described, or through other means like a unix socket or some other
> API), it's just more complicated.
>
> Every consumer also needs to know about that API. That won't work with
> standard tools. For example if we set a PACKET_ID KV, maybe we could
> give it to pwru so it could track packets using it?
> Without registering keys, we could pass it as a cli flag. With
> registration, we'd have to have some helper to get the KV ID.
>
> It also introduces ordering dependencies between the services on
> startup, eg packet tracing hooks could only be attached once our XDP
> service has registered a PACKET_ID KV, and they could query it's API.

Yeah, we definitely need a way to make that accessible and not too
cumbersome.

I suppose what we really need is a way to map an application-specific
identifier to an ID. And, well, those identifiers could just be (string)
names? That's what we do for CO-RE, after all. So you'd get something
like:

id =3D bpf_register_metadata_field("packet_id", 8, BPF_CREATE); /* register=
 */

id =3D bpf_register_metadata_field("packet_id", 8, BPF_NO_CREATE); /* resol=
ve */

and we make that idempotent, so that two callers using the same name and
size will just get the same id back; and if called with BPF_NO_CREATE,
you'll get -ENOENT if it hasn't already been registered by someone else?

We could even make this a sub-command of the bpf() syscall if we want it
to be UAPI, but that's not strictly necessary, applications can also
just call the registration from a syscall program at startup...

>> We could combine such a registration API with your header format, so
>> that the registration just becomes a way of allocating one of the keys
>> from 0-63 (and the registry just becomes a global copy of the header).
>> This would basically amount to moving the "service config file" into the
>> kernel, since that seems to be the only common denominator we can rely
>> on between BPF applications (as all attempts to write a common daemon
>> for BPF management have shown).
>
> That sounds reasonable. And I guess we'd have set() check the global
> registry to enforce that the key has been registered beforehand?

Yes, exactly. And maybe check that the size matches as well just to
remove the obvious footgun of accidentally stepping on each other's
toes?

> Thanks for all the feedback!

You're welcome! Thanks for working on this :)

-Toke


