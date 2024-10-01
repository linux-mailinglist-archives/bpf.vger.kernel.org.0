Return-Path: <bpf+bounces-40673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DF998BFAB
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 16:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3238F283CC0
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4F41C8FA9;
	Tue,  1 Oct 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Iav4QSMl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603021C7B9E
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792168; cv=none; b=S7A/T0gIPf39rc1IE48FxGhyoPMa0c5FH4TFVwb+OW2Row5vNpOay+3PL8S/erqSlwowfXcYj1mikp7cHUbtm17tC0xy5b+ew6d4ylNJC83jsAA14eyHdTKv5SU4dLiFUFBzQlbKpzupzMy+S+IfdP1MA62xUPD3SsE7yDA/WEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792168; c=relaxed/simple;
	bh=/ghXGLfDb+Yaz4Y4rEQNrvZz7d6WnrYefmQ9E0NHUu4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nHRTLbwjPZ0IjkCVIOxfAE0RjpMqzQReawe3CX+W5zpZW/FojfIuECeuZ3QYaaj5EE49biLJNJa03WTR+ECPO59y+D8gQJCy1qTOf32TeBpSWhK6UldeCb1C8Wijh3OrSiECup4tKZBQLmdAZkP2hv1aU0MoaCEH+aGMLrBkkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Iav4QSMl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so53867425e9.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727792165; x=1728396965; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPrqx8PPN9XzYdGiRloXrCcCI6p+F6yes4vFqB5rjxE=;
        b=Iav4QSMlBVzZqAsM2XafiBoVdqdizdVA5MFmUCxSpHLc51sSWToosDoxB9RhYaCLTm
         93JugLwdEguuuVuPE9t0fQUDZb0PXcRdYPLWKbbktS7V0wA846MqzVGfur+U4mwV40rw
         d/ZYOtbdPM3jH9hWBuijy0Dx8BmKf5jA/Hf7Ts1TudDT5S+UZQfYnH9THWjiZmzRItez
         kjPRrE8iCUMr4qCP/QKzJh+W2uspb67enkgv85d1PcqjJJ3ScRWFNRRchG2kgo0wWX04
         Uax/jXU1RiEHoE8iYdnMeVmBYqgBynK+Ua1xTAp/lEfxusM9Nc4lAicKxCHM4+QN0w5+
         Z4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792165; x=1728396965;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bPrqx8PPN9XzYdGiRloXrCcCI6p+F6yes4vFqB5rjxE=;
        b=WDoMgM93l4mp/m5tnB5R402fGol8c+4nemRZxn0zf21SN+FjzTz8PKYGJFhyaSvQ2l
         aOtY4RFWrD1C/442y4afXPJH7RUrHFXOJPmyfL85GUIxqoOkG0SrFZEExsYjISyR3XvN
         g5nIIFlatWtaU9/FjRJy1Punujkiw59vorduPf+lUDhZC9OLTz/QtLIH8u+8DMVYkUhs
         nuUQoyNudL1TUEgBw+IETesa79Yk9dV0eEv1Ro8cH5dJLQFlpM+3pVnKEhUmw+H6PdLO
         Npo/nQTZeb2ynTEgLa2BuN6h2vkgjG6TsUGYIApqQEmGJjWAmMCwKMpgEB3AFf+WPhwF
         BVtg==
X-Forwarded-Encrypted: i=1; AJvYcCWZAPJCofkAhL0nPhJ6XhGHKLegaPES6xKtQBm9cn27FBI9USjJZ7mtnKbx5wsWX5MzP4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrybB6TKD50ymoeJ8nRaDb/Zbzd55txAYtcEC7zd20bjo+1F6I
	+bRSa3nAo38Cil3mm7m6IhTsjjeR8l4AGsCQjrJ3D2aggVEVomVAsWLfv55Aggg=
X-Google-Smtp-Source: AGHT+IEEDzSlqoarEzAhT2UJAuTsLs2NfHPHAaT2ZOAuyTteim903U5oB5dlvZ+hPXsXiJoXmrWn3A==
X-Received: by 2002:a05:600c:1e10:b0:42c:bbd5:af60 with SMTP id 5b1f17b1804b1-42f701c0b90mr32726345e9.24.1727792164685;
        Tue, 01 Oct 2024 07:16:04 -0700 (PDT)
Received: from localhost ([2a09:bac1:27c0:58::241:6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5730e55sm11937580f8f.82.2024.10.01.07.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Oct 2024 16:16:02 +0200
Message-Id: <D4KJ7DUXJQC5.2UFST9L3CUOH7@bobby>
To: "Lorenzo Bianconi" <lorenzo@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <davem@davemloft.net>, <kuba@kernel.org>, <john.fastabend@gmail.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <sdf@fomichev.me>,
 <tariqt@nvidia.com>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <mst@redhat.com>, <jasowang@redhat.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, "kernel-team" <kernel-team@cloudflare.com>,
 "Yan Zhai" <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
From: "Arthur Fabre" <afabre@cloudflare.com>
X-Mailer: aerc 0.8.2
References: <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <CAOn4ftshf3pyAst27C2haaSj4eR2n34_pcwWBc5o3zHBkwRb3g@mail.gmail.com>
 <87wmiysi37.fsf@toke.dk> <D4GBY7CHJNJ6.3O18I5W1FTPKR@bobby>
 <87ldzds8bp.fsf@toke.dk> <D4H5CAN4O95E.3KF8LAH75FYD4@bobby>
 <ZvbKDT-2xqx2unrx@lore-rh-laptop> <871q11s91e.fsf@toke.dk>
 <ZvqQOpqnK9hBmXNn@lore-desk>
In-Reply-To: <ZvqQOpqnK9hBmXNn@lore-desk>

On Mon Sep 30, 2024 at 1:49 PM CEST, Lorenzo Bianconi wrote:
> > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >=20
> > >> > We could combine such a registration API with your header format, =
so
> > >> > that the registration just becomes a way of allocating one of the =
keys
> > >> > from 0-63 (and the registry just becomes a global copy of the head=
er).
> > >> > This would basically amount to moving the "service config file" in=
to the
> > >> > kernel, since that seems to be the only common denominator we can =
rely
> > >> > on between BPF applications (as all attempts to write a common dae=
mon
> > >> > for BPF management have shown).
> > >>=20
> > >> That sounds reasonable. And I guess we'd have set() check the global
> > >> registry to enforce that the key has been registered beforehand?
> > >>=20
> > >> >
> > >> > -Toke
> > >>=20
> > >> Thanks for all the feedback!
> > >
> > > I like this 'fast' KV approach but I guess we should really evaluate =
its
> > > impact on performances (especially for xdp) since, based on the kfunc=
 calls
> > > order in the ebpf program, we can have one or multiple memmove/memcpy=
 for
> > > each packet, right?
> >=20
> > Yes, with Arthur's scheme, performance will be ordering dependent. Usin=
g
> > a global registry for offsets would sidestep this, but have the
> > synchronisation issues we discussed up-thread. So on balance, I think
> > the memmove() suggestion will probably lead to the least pain.
> >=20
> > For the HW metadata we could sidestep this by always having a fixed
> > struct for it (but using the same set/get() API with reserved keys). Th=
e
> > only drawback of doing that is that we statically reserve a bit of
> > space, but I'm not sure that is such a big issue in practice (at least
> > not until this becomes to popular that the space starts to be contended=
;
> > but surely 256 bytes ought to be enough for everybody, right? :)).
>
> I am fine with the proposed approach, but I think we need to verify what =
is the
> impact on performances (in the worst case??)

If drivers are responsible for populating the hardware metadata before
XDP, we could make sure drivers set the fields in order to avoid any
memove() (and maybe even provide a helper to ensure this?).

> > > Moreover, I still think the metadata area in the xdp_frame/xdp_buff i=
s not
> > > so suitable for nic hw metadata since:
> > > - it grows backward=20
> > > - it is probably in a different cacheline with respect to xdp_frame
> > > - nic hw metadata will not start at fixed and immutable address, but =
it depends
> > >   on the running ebpf program
> > >
> > > What about having something like:
> > > - fixed hw nic metadata: just after xdp_frame struct (or if you want =
at the end
> > >   of the metadata area :)). Here he can reuse the same KV approach if=
 it is fast
> > > - user defined metadata: in the metadata area of the xdp_frame/xdp_bu=
ff
> >=20
> > AFAIU, none of this will live in the (current) XDP metadata area. It
> > will all live just after the xdp_frame struct (so sharing the space wit=
h
> > the metadata area in the sense that adding more metadata kv fields will
> > decrease the amount of space that is usable by the current XDP metadata
> > APIs).
> >=20
> > -Toke
> >=20
>
> ah, ok. I was thinking the proposed approach was to put them in the curre=
nt
> metadata field.

I've also been thinking of putting this new KV stuff at the start of the
headroom (I think that's what you're saying Toke?). It has a few nice
advantanges:

* It coexists nicely with the current XDP / TC metadata support.
Those users won't be able to overwrite / corrupt the KV metadata.
KV users won't need to call xdp_adjust_meta() (which would be awkward -
how would they know how much space the KV implementation needs).

* We don't have to move all the metadata everytime we call
xdp_adjust_head() (or the kernel equivalent).

Are there any performance implications of that, e.g. for caching?

This would also grow "upwards" which is more natural, but I think=20
either way the KV API would hide whether it's downwards or upwards from
users.

>
> Regards,
> Lorenzo


