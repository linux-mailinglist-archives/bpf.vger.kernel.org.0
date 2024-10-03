Return-Path: <bpf+bounces-40816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC4798E9CF
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 08:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E173D281ACB
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 06:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F4380C13;
	Thu,  3 Oct 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IvJmVuLs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4989BA49
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938291; cv=none; b=h9zEY4CDQ63ksZ6oyHmaeOJYo2a0LMVsQ5U/OTuHPAP0QiaDTA+mtakG0mP+iz12LyD3XN6BU5cPBkr5XXb2Tc83l0z7g/cUO2UYW2mR3OntJyPhpwXf7E7GUwO8bWEsG/PE51ISFaVBvN9yBcyO8WFP8NjP6fnWQj1YNUNWSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938291; c=relaxed/simple;
	bh=WfFQOlU/FNGjfQVBBdMXE6R4DGDei7d3X3WOszlo3XY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=NlhukxbKGLhxLA9ABlu7oKyJJX4Hmh+N+Zoh0r7RGi4cjgGGOLu6ExhOnciW0NkyDyaGNyKiPFOcs5D3UDRmiIKssyKNg2pNat1kxkng4+TN0Je9ir0H7tnUPmK7mMbXZfj+BV4p7ZLrkJtP0eUj050zvvMpMYzhRyS5pOb8z9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IvJmVuLs; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so723009e87.1
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 23:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727938288; x=1728543088; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfFQOlU/FNGjfQVBBdMXE6R4DGDei7d3X3WOszlo3XY=;
        b=IvJmVuLsz83pPgToWEj3tm07DeFgmFSKYUG5Vz1Lr1vZn5hmRmuwhTBwxyyMocmkPa
         w3SsVQgrf0n0h7G5QfuuY1QocXaRCmrE6TzayejTHeuXiSsV0qk/JWLxOu12emTc7/Rb
         f2whZMq3C3mM+XRzd4vo7soCjseukbJ4S7l2aDeJeqyqAHsfp6znHQyfOHJlKMw8KUIr
         J+EpqIc4/EQJwWr0fCZavqoDV/4/+lOR3v1kMPVDCeY6bOVTYWmL1pRPv72WZzE2rUAe
         hDQClxI4ilkdqIpSaJy6SZw6LRyXxMHxTSi0iHLcNGznWjrSCnin2PYXuMsS+XSoiLuV
         35eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938288; x=1728543088;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WfFQOlU/FNGjfQVBBdMXE6R4DGDei7d3X3WOszlo3XY=;
        b=FSBS7XjITnUNm/w4NYW+Xkpf+ObvFl05vtc9o/NrYG3kMyec2Uqh/oUfdW657wyD73
         oTdRngicqSnfygHTN+FbU5KAV8PLnLmrOMizJhwOvuLbisxZ+NfG5viCRwCGThY1tuoV
         TNHKVOBtdAWYKemA9Ot2lOHto9bO895YHgLJT1AJ2quCStI/Nhw/j0wNWSqqBPaShZGp
         EJ07iKaaWtkA/O+e2MUVy+dtfD3mQum2kOJRyIw9YnHYX8lJviIkhyIkSPAdyQrf9ldL
         eTPrQ/im0lSbIxHPytE4cTGRNsCtb2cSYGWiMRvEAI0KrEJZLA8mCawB1g8cyAPkD96Z
         nrsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAwrD/nkP9mZM2RLSlV0QuSXkSpUmnwkaYNxtt2he6n7D3jluFjmOodS//OT1ys51bvTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3U7315XR3cf0IkkaSExxtGocbU8YGsWBG7Dy2oHW0gpof0Y8
	gecSS1WDCzYhxdzzkP5UagpVWUd/TiRPV339NWZyzwE/C0ZBlU2YO9FsEWDAj5I=
X-Google-Smtp-Source: AGHT+IFPzic61mAOdapq2igy/pJOJfz/CFhssuKDfJVb3+2mio6Wf7QJg2yWIWSfpPGTMK9HJ+plaw==
X-Received: by 2002:a05:6512:b90:b0:534:3cdc:dbfe with SMTP id 2adb3069b0e04-539a067c3demr2912257e87.28.1727938287661;
        Wed, 02 Oct 2024 23:51:27 -0700 (PDT)
Received: from localhost ([2a09:bac1:27c0:58::31:92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802a0195sm7488605e9.38.2024.10.02.23.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 23:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Oct 2024 08:51:25 +0200
Message-Id: <D4LZ01REEQLV.3M4VOEW5XK5YZ@bobby>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>, "Lorenzo Bianconi"
 <lorenzo@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <kuba@kernel.org>, <john.fastabend@gmail.com>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sdf@fomichev.me>, <tariqt@nvidia.com>,
 <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <mst@redhat.com>, <jasowang@redhat.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, "kernel-team" <kernel-team@cloudflare.com>,
 "Yan Zhai" <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
From: "Arthur Fabre" <afabre@cloudflare.com>
X-Mailer: aerc 0.8.2
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk> <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk> <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <874j5xs9b1.fsf@toke.dk> <D4KIZY73DAJJ.EVUPLH612IV6@bobby>
 <87wmirq1uk.fsf@toke.dk>
In-Reply-To: <87wmirq1uk.fsf@toke.dk>

On Tue Oct 1, 2024 at 5:28 PM CEST, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> "Arthur Fabre" <afabre@cloudflare.com> writes:
>
> > On Mon Sep 30, 2024 at 12:52 PM CEST, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
> >> > Thinking about it more, my only relectance for a registration API is=
 how
> >> > to communicate the ID back to other consumers (our discussion below)=
.
> >> >
> >> >>
> >> >> > Dynamically registering fields means you have to share the return=
ed ID
> >> >> > with whoever is interested, which sounds tricky.
> >> >> > If an XDP program sets a field like packet_id, every tracing
> >> >> > program that looks at it, and userspace service, would need to kn=
ow what
> >> >> > the ID of that field is.
> >> >> > Is there a way to easily share that ID with all of them?
> >> >>
> >> >> Right, so I'll admit this was one of the handwavy bits of my origin=
al
> >> >> proposal, but I don't think it's unsolvable. You could do something=
 like
> >> >> (once, on application initialisation):
> >> >>
> >> >> __u64 my_key =3D bpf_register_metadata_field(my_size); /* maybe add=
 a name for introspection? */
> >> >> bpf_map_update(&shared_application_config, &my_key_index, &my_key);
> >> >>
> >> >> and then just get the key out of that map from all programs that wa=
nt to
> >> >> use it?
> >> >
> >> > Passing it out of band works (whether it's via a pinned map like you
> >> > described, or through other means like a unix socket or some other
> >> > API), it's just more complicated.
> >> >
> >> > Every consumer also needs to know about that API. That won't work wi=
th
> >> > standard tools. For example if we set a PACKET_ID KV, maybe we could
> >> > give it to pwru so it could track packets using it?
> >> > Without registering keys, we could pass it as a cli flag. With
> >> > registration, we'd have to have some helper to get the KV ID.
> >> >
> >> > It also introduces ordering dependencies between the services on
> >> > startup, eg packet tracing hooks could only be attached once our XDP
> >> > service has registered a PACKET_ID KV, and they could query it's API=
.
> >>
> >> Yeah, we definitely need a way to make that accessible and not too
> >> cumbersome.
> >>
> >> I suppose what we really need is a way to map an application-specific
> >> identifier to an ID. And, well, those identifiers could just be (strin=
g)
> >> names? That's what we do for CO-RE, after all. So you'd get something
> >> like:
> >>
> >> id =3D bpf_register_metadata_field("packet_id", 8, BPF_CREATE); /* reg=
ister */
> >>
> >> id =3D bpf_register_metadata_field("packet_id", 8, BPF_NO_CREATE); /* =
resolve */
> >>
> >> and we make that idempotent, so that two callers using the same name a=
nd
> >> size will just get the same id back; and if called with BPF_NO_CREATE,
> >> you'll get -ENOENT if it hasn't already been registered by someone els=
e?
> >>
> >> We could even make this a sub-command of the bpf() syscall if we want =
it
> >> to be UAPI, but that's not strictly necessary, applications can also
> >> just call the registration from a syscall program at startup...
> >
> > That's a nice API, it makes sharing the IDs much easier.
> >
> > We still have to worry about collisions (what if two different things
> > want to add their own "packet_id" field?). But at least:
> >
> > * "Any string" has many more possibilities than 0-64 keys.
>
> Yes, and it's easy to namespace (by prefixing, like
> APPNAME_my_metaname). But sure, if everyone uses very generic names that
> will be a problem.
>
> > * bpf_register_metadata() could return an error if a field is already
> > registered, instead of silently letting an application overwrite
> > metadata
>
> I don't think we can fundamentally solve the collision problem if we
> also need to allow sharing keys (on purpose). I.e., we can't distinguish
> between "these two applications deliberately want to share the packet_id
> field" and "these two applications accidentally both picked packet_id as
> their internal key".

Good point. We either have to be happy with sharing the small keys
space, or sharing the much bigger string space.

> I suppose we could pre-define some extra reserved keys if there turns
> out to be widely used identifiers that many applications want. But I'm
> not sure if that should be there from the start, it quickly becomes very
> speculative(packet_id comes to mind as one that might be generally
> useful, but I'm really not sure, TBH).
>
> > (although arguably we could have add a BPF_NOEXIST style flag
> > to the KV set() to kind of do the same).
>
> A global registry will need locking, so not sure it's a good idea to
> support inserting into it in the fast path?

(I meant just checking if a KV with that value has been set already or
not, in the case where we don't have a registration API).

That raises an interesting question: we probably won't be able to
ensure that the keys passed to set() have been registered ahead of time.
That would require checking the locked global registry as you point
out.=20

Misbehaving users could just skip calling register() altogether, and
directly pick a random key to use.

Maybe we could solve this by having a pair of atomic u64s per thread
storing the KV header to describe which keys are allowed to be set, and
what size they'll have? But that's starting to feel complicated.

(Same for the size parameter in register() - we won't be able to enforce
that that is actually the size then passed to set(). But I think we
can just drop it - anyways we can't check the size ahead of time because
we can't know about adjust_head() / expand_head() calls).

>
> > At least internally, it still feels like we'd maintain a registry of
> > these string fields and make them configurable for each service to avoi=
d
> > collisions.
>
> Yeah, see above. Some kind of coordination (like a registry) is
> impossible to avoid if you *want* to share data, but not sure how
> common that is?
>
> -Toke

