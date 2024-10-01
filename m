Return-Path: <bpf+bounces-40672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84698BEF3
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 16:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10941C20B21
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462F1C6882;
	Tue,  1 Oct 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B4ZrFsBB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826DBE6F
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791585; cv=none; b=h854vhw1yJrnSOHMNzRMpfvZ9VrKM3X/GZl1evHvco10U1tX+MJYKMa1cCI11vi7o/ksnySiWkIFwbVTH9aFn1pAl5j53oVksfy2AHLb0Ata5NtuKxweyQ7uWCw3lTtI1atH9l+P1GOfpPgxNrcRL9tgulnX4TljawXmN1njaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791585; c=relaxed/simple;
	bh=k+HGpSm5hZTXbX2q38o3UsWdiRJiQ5DUA4WSCzHUkGc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=bkDtPcJi/nbxMcHoPLHNHUmLImZZRY5xUE210wfpBEVpttbLvKXHTq7JI0FZItqERKSztzdFprcODNmr8W74KrHSJ07CuYJ+R37plu9r47eTuhDf3jmIMD8lkpdDZOKAPdRFOp6OheRhVKKBZ5GY8WOeEhbaWTiYNvDH3A3oOx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B4ZrFsBB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37ccd50faafso3592944f8f.3
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727791582; x=1728396382; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+HGpSm5hZTXbX2q38o3UsWdiRJiQ5DUA4WSCzHUkGc=;
        b=B4ZrFsBBFlpJngRrIdgwC8hJMZCOTZfODjux5TBa0c0YakUoSQisGE9SqaF8v9KYKE
         mfCWNT5M6JoSjvCk4hQXsc7pAt93eGVJVr0H0mP5apRvfmGTtlhhO9HVhp7v2LxXknjM
         T3YkAIuF9s0UBDcb0msqgO2c5d7g5YX1oGXXD4/oCtVA202WnnlQwl99YBfRya6ZxVX6
         jlHZqKgQrsZiop+gRs1DPHhyXbgx0F4H8EJMAOrwl1p0eBo1H4YHkzljLaYJf/vBStpg
         nxWlzMPv1P+i1oA9w376Sj9pYGo+HekIUSx7jIDroixnGyFyq0XCFdgvLn1PZ3vlCYP5
         5A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791582; x=1728396382;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+HGpSm5hZTXbX2q38o3UsWdiRJiQ5DUA4WSCzHUkGc=;
        b=LiE79kNrFgzqo4POZMClWN+3nNa6ojC/urKNe5pHFzAgGDJUCdhoLL83TMoJVBb+Vz
         vIBEbYVNe6bvgDmag8Mp38GMnHW8AjpqDDCVVcaFN4V9D/rnsSdJgGNv88AtcpA6umH6
         /Qby/Gkax6D4iQmqNTh2M58Ykx7csjSeK83YtDR/2Ep9D+4jVziZjqisdE4h4o3GtyH3
         jK81dIOa3zEh+h31EIEBl3kMc+BrAhIgNcllxjSgeIfNj06Eot3idXiZCU4qSqOruZzD
         UQyU9n0H2rzHHq2Dzklx2vJ4k6ZpEIgNaLi78KxYArBovfyaEVNQnStluoRmSz7jh3Z0
         qbWA==
X-Forwarded-Encrypted: i=1; AJvYcCUn/HJJbFACI6H1jlCU1IcJP7A5/mohzAwTdqArgf3dfG/xGEvbRtk54YlRnChAfC2P5f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxjUJFt6nZkFXVEuoqcnqrD3Cv3tY2sXJ6pconVSBroMLrUr7p
	A3Mq5yCE+oV3kF+dh5I9oiIjetUPBEd6DmW5C5GaWbr8K2c+MRlLtMLwjvfrTmY=
X-Google-Smtp-Source: AGHT+IFbKmOHQzYH6RU5RJ695hEsh3LWNKXU2AyvEHj2fyjWXajYvlxmm7C65l5t2tAIDZnqYBHP2Q==
X-Received: by 2002:a05:6000:1141:b0:374:b9a7:5ed6 with SMTP id ffacd0b85a97d-37cd5ab7652mr9443619f8f.22.1727791581955;
        Tue, 01 Oct 2024 07:06:21 -0700 (PDT)
Received: from localhost ([2a09:bac1:27c0:58::241:6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5742499sm11766826f8f.93.2024.10.01.07.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Oct 2024 16:06:20 +0200
Message-Id: <D4KIZY73DAJJ.EVUPLH612IV6@bobby>
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
 <874j5xs9b1.fsf@toke.dk>
In-Reply-To: <874j5xs9b1.fsf@toke.dk>

On Mon Sep 30, 2024 at 12:52 PM CEST, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
> > Thinking about it more, my only relectance for a registration API is ho=
w
> > to communicate the ID back to other consumers (our discussion below).
> >
> >>
> >> > Dynamically registering fields means you have to share the returned =
ID
> >> > with whoever is interested, which sounds tricky.
> >> > If an XDP program sets a field like packet_id, every tracing
> >> > program that looks at it, and userspace service, would need to know =
what
> >> > the ID of that field is.
> >> > Is there a way to easily share that ID with all of them?
> >>
> >> Right, so I'll admit this was one of the handwavy bits of my original
> >> proposal, but I don't think it's unsolvable. You could do something li=
ke
> >> (once, on application initialisation):
> >>
> >> __u64 my_key =3D bpf_register_metadata_field(my_size); /* maybe add a =
name for introspection? */
> >> bpf_map_update(&shared_application_config, &my_key_index, &my_key);
> >>
> >> and then just get the key out of that map from all programs that want =
to
> >> use it?
> >
> > Passing it out of band works (whether it's via a pinned map like you
> > described, or through other means like a unix socket or some other
> > API), it's just more complicated.
> >
> > Every consumer also needs to know about that API. That won't work with
> > standard tools. For example if we set a PACKET_ID KV, maybe we could
> > give it to pwru so it could track packets using it?
> > Without registering keys, we could pass it as a cli flag. With
> > registration, we'd have to have some helper to get the KV ID.
> >
> > It also introduces ordering dependencies between the services on
> > startup, eg packet tracing hooks could only be attached once our XDP
> > service has registered a PACKET_ID KV, and they could query it's API.
>
> Yeah, we definitely need a way to make that accessible and not too
> cumbersome.
>
> I suppose what we really need is a way to map an application-specific
> identifier to an ID. And, well, those identifiers could just be (string)
> names? That's what we do for CO-RE, after all. So you'd get something
> like:
>
> id =3D bpf_register_metadata_field("packet_id", 8, BPF_CREATE); /* regist=
er */
>
> id =3D bpf_register_metadata_field("packet_id", 8, BPF_NO_CREATE); /* res=
olve */
>
> and we make that idempotent, so that two callers using the same name and
> size will just get the same id back; and if called with BPF_NO_CREATE,
> you'll get -ENOENT if it hasn't already been registered by someone else?
>
> We could even make this a sub-command of the bpf() syscall if we want it
> to be UAPI, but that's not strictly necessary, applications can also
> just call the registration from a syscall program at startup...

That's a nice API, it makes sharing the IDs much easier.

We still have to worry about collisions (what if two different things
want to add their own "packet_id" field?). But at least:

* "Any string" has many more possibilities than 0-64 keys.

* bpf_register_metadata() could return an error if a field is already
registered, instead of silently letting an application overwrite
metadata (although arguably we could have add a BPF_NOEXIST style flag
to the KV set() to kind of do the same).

At least internally, it still feels like we'd maintain a registry of
these string fields and make them configurable for each service to avoid
collisions.

> >> We could combine such a registration API with your header format, so
> >> that the registration just becomes a way of allocating one of the keys
> >> from 0-63 (and the registry just becomes a global copy of the header).
> >> This would basically amount to moving the "service config file" into t=
he
> >> kernel, since that seems to be the only common denominator we can rely
> >> on between BPF applications (as all attempts to write a common daemon
> >> for BPF management have shown).
> >
> > That sounds reasonable. And I guess we'd have set() check the global
> > registry to enforce that the key has been registered beforehand?
>
> Yes, exactly. And maybe check that the size matches as well just to
> remove the obvious footgun of accidentally stepping on each other's
> toes?
>
> > Thanks for all the feedback!
>
> You're welcome! Thanks for working on this :)
>
> -Toke


