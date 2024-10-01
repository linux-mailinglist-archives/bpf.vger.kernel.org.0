Return-Path: <bpf+bounces-40690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0409D98C19F
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20B4282624
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835101C9ECA;
	Tue,  1 Oct 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvuK2P2R"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B71C7B64
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796523; cv=none; b=t5PCYhW/HBjFlK1I0TEJrGioKEIrcEIqLMjoAWJDN6YU8ahet2efNp+K8un65Qciuflt9HVWYVi6PPMYoM4HKiLKYv2XCWBfiXxSyeugw+3aZ+h9R5HonehHO1AxKjgD/XiQlx3jFKGj4r/J5n/99NR5ve4T6jJesdofG+csuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796523; c=relaxed/simple;
	bh=kRGJHFt1DyMRV2jFQBHdFqWxCL+YxoRO1mRYWbFhgaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K8mD104wRK2qlY1GBvV8Kzb7nlyj1eKh6nxuFC0qEX8RWToY8XCoZGDXnv2dh5esY5aF1N3TP8dokC3EL++KpwC+CUBYL3jB+QGlW6SicZvsMlm8e5WY6OJC83bVPbSPxbFIHXnDq3y5WTj024Ls+y9eUeMbVXMI1ABD2ikIQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvuK2P2R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727796520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRGJHFt1DyMRV2jFQBHdFqWxCL+YxoRO1mRYWbFhgaw=;
	b=QvuK2P2R3u8mfniTLrxZ01CO+NoSYmQzmDOcw8lM0HlAsUa6Hf3+DaTWUFYZ/VPgSd8wg7
	yfB6stdpufE+5wri6zhQXvAoibPG/ZonEjBmuqUNqRJnkuRVrUK9gJ0VdiH8oZf7psup9o
	QdHO6TR83GlAQMXTMJrrtCUqUhVQEp0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-K4lzCljuPjW1rv2wbnkrpQ-1; Tue, 01 Oct 2024 11:28:38 -0400
X-MC-Unique: K4lzCljuPjW1rv2wbnkrpQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c80d23d501so7158204a12.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 08:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796517; x=1728401317;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRGJHFt1DyMRV2jFQBHdFqWxCL+YxoRO1mRYWbFhgaw=;
        b=RI1ehG7HPfZRbUjc9xeeK1eNb4ju2KbVL5x8+sxVT+5ViQm6ZbMdt5d8xVQVu/BNV/
         65dRLEEXRtIk8bZy0a9m37fcD5yVPmzNZbFsOgIY51nu7C/dkS7xzynJsVcGYATNzPXg
         hQG0dUU4+oxNIPHTozZh9FNDojoqMhaL5tdKkrhEpxCpLZNRfbvs+H6yRme8+tm3Yhf5
         rNNOSttbAFTGUxO9GnNjQhIUNtvYYG64gu9u8+gto/k15TN7t3yopGL652aRH2GE2c+3
         jyUE+Nws+MdS6VLUiypgUmcwSa0Cmuw8UHcWBsTETbkDlULzWLhJsCW3WDCaaWFZeVPG
         9hYw==
X-Forwarded-Encrypted: i=1; AJvYcCUTRFNw9PsRW2T6QhsvmuRb799/+TeJg6fUQqeYefbF70PjZZldh9/pVwkEp1aZ1sNLqaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGvr8eZd19VMqIpbE8ZfKl8WcKDhPZr07XKTUK6BwuqkFGAj3
	gqfH3MWtztfi0aI6dtq6GJ1GywMseufdeEpE15vX3Nn+taWHExKkIsq5zZCdeD7qYam/Ipy36fI
	tcgOuW9Eg+oFyot9uaz/vweyECCwuLm8cMTGS73fw3MZG5C8Fzw==
X-Received: by 2002:a05:6402:13d5:b0:5c4:1c0c:cc6d with SMTP id 4fb4d7f45d1cf-5c8a296ec35mr4384642a12.0.1727796517113;
        Tue, 01 Oct 2024 08:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEcFj/QsrkctIUVpfyghKeZFMPLkKED4ekT6bU42YuhHO3I9kjOshTBDPGh8Wg4VrpGA3Yzg==
X-Received: by 2002:a05:6402:13d5:b0:5c4:1c0c:cc6d with SMTP id 4fb4d7f45d1cf-5c8a296ec35mr4384580a12.0.1727796516610;
        Tue, 01 Oct 2024 08:28:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245eb38sm6582810a12.48.2024.10.01.08.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:28:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 37EF61580162; Tue, 01 Oct 2024 17:28:35 +0200 (CEST)
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
In-Reply-To: <D4KIZY73DAJJ.EVUPLH612IV6@bobby>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk> <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk> <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <874j5xs9b1.fsf@toke.dk> <D4KIZY73DAJJ.EVUPLH612IV6@bobby>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Oct 2024 17:28:35 +0200
Message-ID: <87wmirq1uk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Arthur Fabre" <afabre@cloudflare.com> writes:

> On Mon Sep 30, 2024 at 12:52 PM CEST, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> > Thinking about it more, my only relectance for a registration API is h=
ow
>> > to communicate the ID back to other consumers (our discussion below).
>> >
>> >>
>> >> > Dynamically registering fields means you have to share the returned=
 ID
>> >> > with whoever is interested, which sounds tricky.
>> >> > If an XDP program sets a field like packet_id, every tracing
>> >> > program that looks at it, and userspace service, would need to know=
 what
>> >> > the ID of that field is.
>> >> > Is there a way to easily share that ID with all of them?
>> >>
>> >> Right, so I'll admit this was one of the handwavy bits of my original
>> >> proposal, but I don't think it's unsolvable. You could do something l=
ike
>> >> (once, on application initialisation):
>> >>
>> >> __u64 my_key =3D bpf_register_metadata_field(my_size); /* maybe add a=
 name for introspection? */
>> >> bpf_map_update(&shared_application_config, &my_key_index, &my_key);
>> >>
>> >> and then just get the key out of that map from all programs that want=
 to
>> >> use it?
>> >
>> > Passing it out of band works (whether it's via a pinned map like you
>> > described, or through other means like a unix socket or some other
>> > API), it's just more complicated.
>> >
>> > Every consumer also needs to know about that API. That won't work with
>> > standard tools. For example if we set a PACKET_ID KV, maybe we could
>> > give it to pwru so it could track packets using it?
>> > Without registering keys, we could pass it as a cli flag. With
>> > registration, we'd have to have some helper to get the KV ID.
>> >
>> > It also introduces ordering dependencies between the services on
>> > startup, eg packet tracing hooks could only be attached once our XDP
>> > service has registered a PACKET_ID KV, and they could query it's API.
>>
>> Yeah, we definitely need a way to make that accessible and not too
>> cumbersome.
>>
>> I suppose what we really need is a way to map an application-specific
>> identifier to an ID. And, well, those identifiers could just be (string)
>> names? That's what we do for CO-RE, after all. So you'd get something
>> like:
>>
>> id =3D bpf_register_metadata_field("packet_id", 8, BPF_CREATE); /* regis=
ter */
>>
>> id =3D bpf_register_metadata_field("packet_id", 8, BPF_NO_CREATE); /* re=
solve */
>>
>> and we make that idempotent, so that two callers using the same name and
>> size will just get the same id back; and if called with BPF_NO_CREATE,
>> you'll get -ENOENT if it hasn't already been registered by someone else?
>>
>> We could even make this a sub-command of the bpf() syscall if we want it
>> to be UAPI, but that's not strictly necessary, applications can also
>> just call the registration from a syscall program at startup...
>
> That's a nice API, it makes sharing the IDs much easier.
>
> We still have to worry about collisions (what if two different things
> want to add their own "packet_id" field?). But at least:
>
> * "Any string" has many more possibilities than 0-64 keys.

Yes, and it's easy to namespace (by prefixing, like
APPNAME_my_metaname). But sure, if everyone uses very generic names that
will be a problem.

> * bpf_register_metadata() could return an error if a field is already
> registered, instead of silently letting an application overwrite
> metadata

I don't think we can fundamentally solve the collision problem if we
also need to allow sharing keys (on purpose). I.e., we can't distinguish
between "these two applications deliberately want to share the packet_id
field" and "these two applications accidentally both picked packet_id as
their internal key".

I suppose we could pre-define some extra reserved keys if there turns
out to be widely used identifiers that many applications want. But I'm
not sure if that should be there from the start, it quickly becomes very
speculative(packet_id comes to mind as one that might be generally
useful, but I'm really not sure, TBH).

> (although arguably we could have add a BPF_NOEXIST style flag
> to the KV set() to kind of do the same).

A global registry will need locking, so not sure it's a good idea to
support inserting into it in the fast path?

> At least internally, it still feels like we'd maintain a registry of
> these string fields and make them configurable for each service to avoid
> collisions.

Yeah, see above. Some kind of coordination (like a registry) is
impossible to avoid if you *want* to share data, but not sure how
common that is?

-Toke


