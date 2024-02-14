Return-Path: <bpf+bounces-21978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33309854DB4
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8E41F20FDD
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A545FDD5;
	Wed, 14 Feb 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmyQlMG4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F95F871
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926931; cv=none; b=cwn4gPTxSOAgVcOaxMWocK6NRJH4fPd39c2JhqgnOXxYQLmuWVbR759CwwuDw22ZfdRfyYY2it0sRS/LuoM+pZfbTOJ6eYdmqwC9xA42FOdu4Q8R8i0uHMr1v/Vl1Obs/oRIuXwUS9mtjUZqiEmwSQVCiJwT2CuhOqO+eg1fOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926931; c=relaxed/simple;
	bh=pYQ6m2g2xB9FiGc7fUVB9aFo+2SuHOv/Hk+omg8ZnFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nF4LtzrDiOOb9fh9XDZdfNnBamMEO5xZHKAcR2xRnofdxvsrw4zGphHaf9DF2vK+sPgZvcMWZt7POxtQ/tGvTYUPvGi2/PrLC68BquQXbxMACVn7NkXwUUkP+rOso55Oyotu7AujhNFnm98AqaZnldava5bEbHy3a/ZFAB/xjFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmyQlMG4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707926929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFkYGBKgoKWvAKwSi8jHrZTu6gO8Ejnv8YkRpe/tU0c=;
	b=HmyQlMG4Mg2euSZzRaMxSymTDdqYJWP3RFfQCeX0oHf4Q5GUhg5vNzjpXr5t/VOsruq5aJ
	Hrbv7/DFS1voaEYrH9J0q5hlraCtwieHW7/1vbQ/ZYsW1U9ZPPyhH/erZRr4BrAFF6+dqa
	avLGC0dSiqvY+kpVwKECFJpNaKW2rnY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-lpyk96cENSqszTyGprdVHg-1; Wed, 14 Feb 2024 11:08:47 -0500
X-MC-Unique: lpyk96cENSqszTyGprdVHg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56261857d31so500673a12.2
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 08:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926926; x=1708531726;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFkYGBKgoKWvAKwSi8jHrZTu6gO8Ejnv8YkRpe/tU0c=;
        b=Ko2b8QI+l3YyV1wz3w7RfeR+/34sDIoaVQYBfTRPN44iwRyggzMsBthRCZdkp7fMVX
         z7vJym8svex87gEY5M5AkddnALylvH59AWXoaV52Ap0elA5mbfu6v6iYEOZwr47vEfkl
         DdRFLNwnaV3scF7oPJPyZf6X4HMXrSuDc/4JaONF4psGKYRHS0KYFYkXDEtTW+8MtNMY
         V1Lt3WWv+XWUvUXnKvg8BDsg/yFiXcYsyCm+h35ZTd0i7YzBlRiUGLyGNgt6kU7OwlTt
         0LgryBH6aod2lD5UcviojQ3NGujU9/wKKXKUE+MwBpBjkBFom8ZJ2+3O+nlAPFUDjHnp
         VZdw==
X-Forwarded-Encrypted: i=1; AJvYcCXIkashLe8gz8oKlIIKD57IS9v7iBTys2KdKNFxk88h7iaa3/YXw5m2o4P5/pPlX7kVLZw7z7i+eEbibprRM3Ao09nl
X-Gm-Message-State: AOJu0Ywbg2FB2kV+rACm97vsQEmRb5Qtbu9NlZB0XbYkNWmd0c+9XSM4
	nPH3oisG4KFzDseWu/OpxiVPl52Rtr6eHk8RJSXXbdeRXfdlZkU7X3CceQY+iWiIQCdLQa1MB68
	GfOGQNE9pwr7gqCJiYxxCguxo6eWi2Lkihq1KXVd+eppIAwUM3A==
X-Received: by 2002:a50:fb02:0:b0:561:f645:aa88 with SMTP id d2-20020a50fb02000000b00561f645aa88mr2658744edq.39.1707926926001;
        Wed, 14 Feb 2024 08:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqMJkRFF7ruKRiTmj9Ex1FZJe+wFMrOrs0QX5Gp+kJGSeSOkxFT4Pppctp781Lc1jKhcoC/g==
X-Received: by 2002:a50:fb02:0:b0:561:f645:aa88 with SMTP id d2-20020a50fb02000000b00561f645aa88mr2658717edq.39.1707926925681;
        Wed, 14 Feb 2024 08:08:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhv+05WW9Uc2W8dgxJoZ9zYI2AMvlYhkyzz+2EZWmq7YKUCFlI4VZayvObHgvKf/5ly5iMrX+26uECqTzxXMNj7vHnUD9j9Vb8BLhrfxnqPeMV/tdvEE5PAe/3MhX0YRlS2Kkp9pdU2tVxkXw7cvWrwEQGRH50jucZeSyD5O1VREfFZ/0rH0jsfXhFRzcsXZ+iQq+HzKTba0UYL6Unj9BkZEB6U1xoxQV0AMs3WVoJp8NFy7BAcXVuQeVghGOsQE4gjzDs7Tysv3rOPukyzsh7AdVqlKkjLElry+1JJAqTBj4uFaM84yH64fZedec8j50DKpYB8BsQ9uupX27KYlWhZRXgX8emfQEU0l0NcTsjZi/F6CN8qCB80thiJ0Twjfox1+i8UPXqJgKzHYLllAwiAdA26OBZJh2C01HSrCwhzRojtMXFtM3FWjfX6bunVNWTSsRwjEG+p2P/JY/me0TarTwvuCIZQWpu9SxgK7mCG88tgbPilko/N5pvNEUiDR2uptiH6MFEeEPcTPIg26QVmenO2d2uUPdjQKA4qsDTldmrunb241dNZEtBO42PS6nVmGhpbuPh61nBx/b7smATRhzicWQKMGCr1OMi+Rr5ocU5QdoJ/A5jFVEd2Bua6yRyC9KwRsp3RuznoQy+QuB5V5a/qm9O7aV2g3lVcYEhujgtOmhgR3HtyIigR+Qs6ZenDKl0
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x21-20020aa7d395000000b0056166a5ee75sm4699065edq.30.2024.02.14.08.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:08:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A167A10F57E5; Wed, 14 Feb 2024 17:08:44 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240214142827.3vV2WhIA@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de> <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Feb 2024 17:08:44 +0100
Message-ID: <87le7ndo4z.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-02-14 14:23:10 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>>=20
>> > On 2024-02-13 21:50:51 [+0100], Jesper Dangaard Brouer wrote:
>> >> I generally like the idea around bpf_xdp_storage.
>> >>=20
>> >> I only skimmed the code, but noticed some extra if-statements (for
>> >> !NULL). I don't think they will make a difference, but I know Toke wa=
nt
>> >> me to test it...
>> >
>> > I've been looking at the assembly for the return value of
>> > bpf_redirect_info() and there is a NULL pointer check. I hoped it was
>> > obvious to be nun-NULL because it is a static struct.
>> >
>> > Should this become a problem I could add
>> > "__attribute__((returns_nonnull))" to the declaration of the function
>> > which will optimize the NULL check away.
>>=20
>> If we know the function will never return NULL (I was wondering about
>> that, actually), why have the check in the C code at all? Couldn't we ju=
st
>> omit it entirely instead of relying on the compiler to optimise it out?
>
> The !RT version does:
> | static inline struct bpf_redirect_info *xdp_storage_get_ri(void)
> | {
> |         return this_cpu_ptr(&bpf_redirect_info);
> | }
>
> which is static and can't be NULL (unless by mysterious ways the per-CPU
> offset + bpf_redirect_info offset is NULL). Maybe I can put this in
> this_cpu_ptr()=E2=80=A6 Let me think about it.
>
> For RT I have:
> | static inline struct bpf_xdp_storage *xdp_storage_get(void)
> | {
> |         struct bpf_xdp_storage *xdp_store =3D current->bpf_xdp_storage;
> |
> |         WARN_ON_ONCE(!xdp_store);
> |         return xdp_store;
> | }
> |
> | static inline struct bpf_redirect_info *xdp_storage_get_ri(void)
> | {
> |         struct bpf_xdp_storage *xdp_store =3D xdp_storage_get();
> |
> |         if (!xdp_store)
> |                 return NULL;
> |         return &xdp_store->ri;
> | }
>
> so if current->bpf_xdp_storage is NULL then we get a warning and a NULL
> pointer. This *should* not happen due to xdp_storage_set() which
> assigns the pointer. However if I missed a spot then there is the check
> which aborts further processing.
>
> During testing I forgot a spot in egress and the test module. You could
> argue that the warning is enough since it should pop up in testing and
> not production because the code is always missed and not by chance (go
> boom, send a report). I *think* I covered all spots, at least the test
> suite didn't point anything out to me.

Well, I would prefer if we could make sure we covered everything and not
have this odd failure mode where redirect just mysteriously stops
working. At the very least, if we keep the check we should have a
WARN_ON in there to make it really obvious that something needs to be
fixed.

This brings me to another thing I was going to point out separately, but
may as well mention it here: It would be good if we could keep the
difference between the RT and !RT versions as small as possible to avoid
having subtle bugs that only appear in one configuration.

I agree with Jesper that the concept of a stack-allocated "run context"
for the XDP program makes sense in general (and I have some vague ideas
about other things that may be useful to stick in there). So I'm
wondering if it makes sense to do that even in the !RT case? We can't
stick the pointer to it into 'current' when running in softirq, but we
could change the per-cpu variable to just be a pointer that gets
populated by xdp_storage_set()?

I'm not really sure if this would be performance neutral (it's just
moving around a few bits of memory, but we do gain an extra pointer
deref), but it should be simple enough to benchmark.

> I was unsure if I need something around net_tx_action() due to
> TC_ACT_REDIRECT (I think qdisc) but this seems to be handled by
> sch_handle_egress().

Yup, I believe you're correct.

-Toke


