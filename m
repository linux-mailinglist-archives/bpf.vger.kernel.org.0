Return-Path: <bpf+bounces-51135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7AA30997
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CAA7A4456
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D438C1F8916;
	Tue, 11 Feb 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="HFaXDlOX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD91C9EAA
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272237; cv=none; b=i6xnJt2i2FGvbhvD+BhilZR8fGX1LRpP8Ka/qCFbTA18+2vxzbuylxklBDsQsoIQ2Br/500Gw33jKZ8qn5CB5mKGvXMmv6UQgX/Va3acOgVn9LXzcyxXOBWbp7UjPmFB79AiVWc6+xTEVaRfSbcEsMtkbx/gF/GlHGYtJUTHP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272237; c=relaxed/simple;
	bh=8cbJ0j8CaPNzMqLL97bzWA01nIw1cLsBpVdgRagGWAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCv3/cfH7IxI+N3m+opG2FWhbp6pAMgODEaOWKt9uqG2+jaob2dfxfLyIpYxy/WqNVHGeQwnRx3XuDdYsj178B/NFBjTdCNsIAYJe0XG7JDgodMPPLzEuT9DvzXSgo9OpK03ShoqWWPkaKzcLK1YRkbc27oEdzMKDBY6kzeYHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=HFaXDlOX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f42992f608so8197940a91.0
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 03:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1739272233; x=1739877033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSDIez2Rh9c72m8yN12QT8Ya/AxQN7YdwUSks3gyp2Y=;
        b=HFaXDlOXRnKFMZi13tbfvhVsFi1+LBjzYmTEFU1xDtC+3rWhINvsVVDJpGLFeN2M2d
         i/4HyoU35PRoAwIhBBywDsbzn/VaJw4ZjXLAk4QSrzeViKL7erHvThY2bt76oMxAK68i
         dGL2PMSgrIaoo6XScP3B1KdWr1rTLgj30ZrLlaNBsCIwaui4H1Z1a2uvBu4aqVKw+sNC
         JLGmSizxZg/V3nhTNyncH/D2PjAnJPAEmLTjt3w5Kfywfr4qeK3mtWsELwKAHs6kGQst
         yz6A4y6oA8WupKM6tZWzk+11gF/sRyhG1qiA7cE75inPF6cww4breDJcyuFFc2npp93M
         HNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272233; x=1739877033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSDIez2Rh9c72m8yN12QT8Ya/AxQN7YdwUSks3gyp2Y=;
        b=qDk3FTofEk1bH+pFgPG6oJxKZGuxdebBVcYRAFsacUQpXdIB/DQSFeo7IRECUfTP0S
         d1SJJcnLfK0lGviOE8bf+bY70awJ4kffXmjRBvy07miZVlDI2TFD6d+KJZkE56mRZJmD
         uLY0y9YGWRxuOd9Bh7dVfzd9wUQ+hC2qzpuTjBQ9ltoYZcEQ5SRq9SyhQ4N3vza4g3pI
         /7CZg4O3c1DCRYcKFEhXpvAjaOnkutM3zC41RS1TBZ5KU/U6QK3V6SZR3V2qUd9L0gVi
         cNchQL8zHuyaJ3vgupHSAp91UHogto/v/gNNwK2vsXCMxLKGyAOy2cfkp79SuSpvH+WP
         Fb/g==
X-Forwarded-Encrypted: i=1; AJvYcCXVPs55oHgPcza0rBQgDYwfvxYiXytaTz5kNQ63/JC+TVL7AeWkkhUEH1QYEhbLcS5dyzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53DeGawRoLmWCm34BEKTU+ews+nO5ID/l6WLPrxI7oUK5RbUq
	AxE1V+ER3nuMD5qkr3qcQCaZOgaLlXtEZhTnqXWXTk2TvYIdS2QacoMBnTqVUl2WfSc0XI5MXQz
	cbzMplwkT/QAs1ARw2n1+PbAi6L1Qsfj3pIr7ow==
X-Gm-Gg: ASbGnctfM25YNhxoyRxfF9SBFXACp3K1he18IsQLfT8fL6RasCq5R2dacOtwdRPRRQi
	8aVjeYl1Kq+xIWoWtcanG03orfK6cKN5Qi54NjhskXCFLnDaALqzaglqSR8F55RnC3YFI3LsoHs
	IYWnOlZ9Jb55IKEYQj539qIZpdHt2w/7E=
X-Google-Smtp-Source: AGHT+IEXWyOWn8aMBXGy8OUxzr1mrJhrvcug/VyN8sb7TyuJc7LwcgMY0H8DaerTKOIzP0ZPDpN0SEizO6COp0W7nbI=
X-Received: by 2002:a17:90b:4a43:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-2fa2416707cmr29510783a91.18.1739272233279; Tue, 11 Feb 2025
 03:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
 <CAADnVQ+FJA6jBRxCagAR6GuW0uRysfmgCnGk=ym1-rV0DPHPJg@mail.gmail.com>
 <CAH6OuBQa2QbCXzksiy5PhTCEYBf6m=w0ZKAUzTptxjgqKC25Mw@mail.gmail.com> <Z6ejZh/7jJCHbdVi@pop-os.localdomain>
In-Reply-To: <Z6ejZh/7jJCHbdVi@pop-os.localdomain>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Tue, 11 Feb 2025 12:10:21 +0100
X-Gm-Features: AWEUYZkU4x6M4a--FTcE1p0jhgUIs8GjZqXAA4xICh3mL5jpId6pJ2FHw4R6PR4
Message-ID: <CAH6OuBR7zS2x0B_opzoXQcRVTY-txpwDWL4U+M4kN8rk4kG9BA@mail.gmail.com>
Subject: Re: Poor performance of bpf_map_update_elem() for BPF_MAP_TYPE_HASH_OF_MAPS
 / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 7:33=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Sat, Feb 08, 2025 at 11:39:31AM +0100, Ritesh Oedayrajsingh Varma wrot=
e:
> > On Sat, Feb 8, 2025 at 4:58=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Feb 5, 2025 at 4:58=E2=80=AFAM Ritesh Oedayrajsingh Varma
> > > <ritesh@superluminal.eu> wrote:
> > > >
> > > > Given this, while it's not possible to remove the wait entirely
> > > > without breaking user space, I was wondering if it would be
> > > > possible/acceptable to add a way to opt-out of this behavior for
> > > > programs like ours that don't care about this. One way to do so cou=
ld
> > > > be to add an additional flag to the BPF_MAP_CREATE flags, perhaps
> > > > something like BPF_F_INNER_MAP_NO_SYNC.
> > >
> > > Sounds reasonable.
> > > The flag name is a bit cryptic, BPF_F_UPDATE_INNER_MAP_NO_WAIT
> > > is a bit more explicit, but I'm not sure whether it's better.
> >
> > I agree the name is a bit cryptic. A related question is whether the
> > optimization to skip the RCU wait should only apply to the update, or
> > also to delete. I think it would make sense for it to apply to all
> > operations. What do you think?
>
> Exposing kernel-behavior to user-space is not a good idea, since users
> have to understand kernel details to know how to safely use this flag.

I agree it's not ideal, but I don't really see another option that
doesn't involve breaking user-space, and the current brute force sync
in maybe_wait_bpf_programs() is quite heavy-handed for a guarantee
that at least some percentange of users (like us) don't care about.
Given that it's an *opt-out* and not an opt-in, I think it's okay,
because everything will just continue functioning as before if you
don't use the flag; if you *do* use the flag, then presumably you've
spent time to understand what (and why) it does (and we can of course
add a comment to the new flag with explanation).

>
> >
> > I also realized the flag should technically apply to the *outer* map,
> > since that's the map that's actually being modified and synced on, not
> > the inner map. So I don't think "inner" should be part of the name in
> > retrospect. Perhaps BPF_F_MAP_OF_MAPS_NO_WAIT or
> > BPF_F_MAP_IN_MAP_NO_WAIT? I'm slightly leaning towards the latter
> > because the map of maps support code is also located in map_in_map.c,
> > so that matches nicely. They're both a bit long though. Either way,
> > the definition of the outer map when using this flag would become
> > something like:
> >
> > struct {
> >     __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> >     __uint(max_entries, 4096);
> >     __type(key, u64);
> >     __type(value, u32);
> >     __uint(map_flags, BPF_F_MAP_IN_MAP_NO_WAIT);
> > } mapInMap SEC(".maps");
> >
> > > Also have you considered a batched update? There will be
> > > only one sync_rcu() for the whole batch.
> >
> > We have, yes, but in our case, these updates are a result of another
> > system generating events, and it is a bit hard to batch them together:
> > it would involve waiting for multiple events to arrive, instead of
> > processing events as they come in, which introduces an additional
> > layer of latency by itself.
> >
> > Regarding batched update, we've found that it is also very slow when
> > inserting a large number of elements. In one example where we inserted
> > ~1.2 million 16-byte elements, we found it took 4-500 milliseconds to
> > update the map via batched update. This is due to the overhead of
> > generic_map_update_batch() individually copying each element to be
> > inserted from user space via copy_from_user(); almost all time is
> > going to __check_object_size() called by copy_from_user(). I suspect
> > this one is hard to fix though, due to how the elements in a map are
> > laid out in memory; it would be hard to change such batched updates
> > into a single copy. But perhaps that's something for a different
> > thread (and we can easily work around it on our side).
>
> I think there are rooms to improve this:
>
> 1) As you mentioned, for hash-based or any other non-linear maps, it is
> indeed hard to optimize. However, for linear ones like array map, it is
> possible to copy the whole memory from user-space once.

It is possible yes, but it would have the effect that memory usage
would be (temporarily) higher than before as there would have to be a
temporary copy of the full array in kernel-space, whereas right now
there is only temporary space required for a single element. For large
arrays like we're talking about, that could be quite a lot of memory.

>
> 2) There are actualy two copies here, one is from user-space to a tempora=
ry
> kernel memory, the other is from this temporary memory to the actual map
> key/value memory. _I speculate_ it is possible to optimize them down to
> one copy, at least for simple cases.
>
> Just my two cents.
>
> Thanks!

This is something I looked at, but I don't see a way to do this
without significantly changing the code. As mentioned in the other
thread, this is not an active problem for us as we can work around
this quite easily on our end, so it's not something we'll be pursuing
further.

