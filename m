Return-Path: <bpf+bounces-50872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C064A2D807
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 19:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907EF166BA2
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA1C187848;
	Sat,  8 Feb 2025 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icyAm3ZY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689624111A
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739039594; cv=none; b=AaZCVtWoprOhNyJK0yOEi2wtLF1pGh+n7YwMGLiSl0rZX1FMwo2VHLAskjAv2/7qtCbMD7dzUNxETNfZc7Lyb4C6/5TruXF3FNPyvmcv3Q1mInhcVFYKerDGfSXOD6vlRufmFy7/9XP2EK/MuEOYp3CAXMrUT/Am/ZBojREsbJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739039594; c=relaxed/simple;
	bh=Ev9L9BLYy4OY9Yh/y7HcvT4fPVaDTxRpiug/66o7SNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw43SNnC3aMU5VPycnrOdEIOmPq8ezu370Uvvc0bEHtj8HzfQvYsoWjgIuHYLaDymmYQnWEuJjwjEMy/tpvjUw0XYfGmeAY7WZe0copMzW2aeQSCzHmCcHJGVJ2JQi/mSifFLRDOqT+0KVuCngAHmr/V48K0MG4JE7eocbNSIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icyAm3ZY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f441791e40so4368480a91.3
        for <bpf@vger.kernel.org>; Sat, 08 Feb 2025 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739039592; x=1739644392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kSwR8KKQZgWDYRTWkkxol9mRLYwUXLBLxj6MAQ5d7Zk=;
        b=icyAm3ZYgf9Lc3tEGO/+6YJH2oJ7aO8EON0pjXShsaz0BKzLBz52yA5M9lA8zhwHTT
         0XDakui24EwhnQ4vKj3Dd8ZZADkp8q+W8Js7Vx87rRxXcC4CRk1S2LTDuhG7i0FKckWz
         crtp/Ygzv48ScZe5iT7PsBBiQDaA97XGeL2S+HvblgFZkW2Ldj3p5zd8+f5m6JvTwdk/
         SdYh2y1AjFAYV32F5aeNq3oL3EJr3LP/Z7rltzcaJ03Qcm7BqMxLIaz14Gq8QlpehQWb
         wBvpv0FOrNzwAOkt/ivNDlmGFNSeY3FPbzbXCU2h3avfRayTWCMUyhjIBSp98U3yFTfk
         I8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739039592; x=1739644392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSwR8KKQZgWDYRTWkkxol9mRLYwUXLBLxj6MAQ5d7Zk=;
        b=luZaPPYi2iuzt0jf2yELsLrkbgIUXi8INRRqz17vZ7/7HPsSPkTCaiU8KVRIzFObOb
         3g3y36cDMiVgR0v6nhmxbW6SLSvDCSNJc9iebZLk8vCYNSrST5B2bLbRXSV5Fi0Spya/
         zpYE8IsSl+DV8mfy8vLFBZ4UAzuvmSBovMtnhyu/X2Sl9wcT72BdAyja1wFtPPbb8FXH
         SadiHd3fUyW3WprQHShkCHrmhyTdjmSPX1Jcu0npZW/BAcRRNoNZIeRiegfzkDCakpc4
         xR48QQnAr/m83MCo6Gwst8Z1aBlDhX3JBirZ8mRO8rh1iCPkkNHDJfIv2l4NkXdKf21m
         3EQA==
X-Forwarded-Encrypted: i=1; AJvYcCWeLM5M3ZStU9RJBNuq8tBP0HnxDy2poxcPH82lIrTDzkeQR8GF/lf2ZuD7tan3lJVu1m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKFiaM4IYHsjFiN0t53tQ/mj7Jk8NurmOtkw5OVODTzY3SvB6U
	iTKDR18lHtIj7IcLo6YOAyZp9DydUrNlelYt/29ARVittFY24yDB+PbItQ==
X-Gm-Gg: ASbGncuWAc4f8h5d/y5VMsv+chI55WQ9XYofmVs2eksuEj7EoFj7CPXtqq6HRExIelU
	Ay5DM8nNKI3WjXybYVdgMewzb83OK4Io/lkezOcUdWxgH0JAY2Pd1cZSYWSfVzBWfnXWFlsPjYb
	dia+P68U1SRU4g7OmHQGm6Ufq1LFpuKd8xVrZj1uoQXpwlAr4RqAUNIbceAhWr4GtWdbx3KKJ8S
	Ayc3kruGxsw29FHEXDo8vo9aGIsvNVPCrMhyebHnSsGL4NvcFyF0B1NJ+TPqC0enuJkApIwb9C+
	U/nU6xpomKJ/7oiIhBVE
X-Google-Smtp-Source: AGHT+IG8dFz9PyEFnXlv+C+1ps4VLFSoRyTDwrUmHh69Mpbv5456nSOr0uQaw+gh5DFzLlRzMhPgVg==
X-Received: by 2002:a17:90b:3dc3:b0:2fa:1451:2d56 with SMTP id 98e67ed59e1d1-2fa243e10b6mr11670560a91.25.1739039592341;
        Sat, 08 Feb 2025 10:33:12 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:42b5:3377:c59:865b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e633sm49673715ad.15.2025.02.08.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 10:33:11 -0800 (PST)
Date: Sat, 8 Feb 2025 10:33:10 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>,
	Jelle van der Beek <jelle@superluminal.eu>
Subject: Re: Poor performance of bpf_map_update_elem() for
 BPF_MAP_TYPE_HASH_OF_MAPS / BPF_MAP_TYPE_ARRAY_OF_MAPS
Message-ID: <Z6ejZh/7jJCHbdVi@pop-os.localdomain>
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
 <CAADnVQ+FJA6jBRxCagAR6GuW0uRysfmgCnGk=ym1-rV0DPHPJg@mail.gmail.com>
 <CAH6OuBQa2QbCXzksiy5PhTCEYBf6m=w0ZKAUzTptxjgqKC25Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH6OuBQa2QbCXzksiy5PhTCEYBf6m=w0ZKAUzTptxjgqKC25Mw@mail.gmail.com>

On Sat, Feb 08, 2025 at 11:39:31AM +0100, Ritesh Oedayrajsingh Varma wrote:
> On Sat, Feb 8, 2025 at 4:58 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Feb 5, 2025 at 4:58 AM Ritesh Oedayrajsingh Varma
> > <ritesh@superluminal.eu> wrote:
> > >
> > > Given this, while it's not possible to remove the wait entirely
> > > without breaking user space, I was wondering if it would be
> > > possible/acceptable to add a way to opt-out of this behavior for
> > > programs like ours that don't care about this. One way to do so could
> > > be to add an additional flag to the BPF_MAP_CREATE flags, perhaps
> > > something like BPF_F_INNER_MAP_NO_SYNC.
> >
> > Sounds reasonable.
> > The flag name is a bit cryptic, BPF_F_UPDATE_INNER_MAP_NO_WAIT
> > is a bit more explicit, but I'm not sure whether it's better.
> 
> I agree the name is a bit cryptic. A related question is whether the
> optimization to skip the RCU wait should only apply to the update, or
> also to delete. I think it would make sense for it to apply to all
> operations. What do you think?

Exposing kernel-behavior to user-space is not a good idea, since users
have to understand kernel details to know how to safely use this flag.

> 
> I also realized the flag should technically apply to the *outer* map,
> since that's the map that's actually being modified and synced on, not
> the inner map. So I don't think "inner" should be part of the name in
> retrospect. Perhaps BPF_F_MAP_OF_MAPS_NO_WAIT or
> BPF_F_MAP_IN_MAP_NO_WAIT? I'm slightly leaning towards the latter
> because the map of maps support code is also located in map_in_map.c,
> so that matches nicely. They're both a bit long though. Either way,
> the definition of the outer map when using this flag would become
> something like:
> 
> struct {
>     __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
>     __uint(max_entries, 4096);
>     __type(key, u64);
>     __type(value, u32);
>     __uint(map_flags, BPF_F_MAP_IN_MAP_NO_WAIT);
> } mapInMap SEC(".maps");
> 
> > Also have you considered a batched update? There will be
> > only one sync_rcu() for the whole batch.
> 
> We have, yes, but in our case, these updates are a result of another
> system generating events, and it is a bit hard to batch them together:
> it would involve waiting for multiple events to arrive, instead of
> processing events as they come in, which introduces an additional
> layer of latency by itself.
> 
> Regarding batched update, we've found that it is also very slow when
> inserting a large number of elements. In one example where we inserted
> ~1.2 million 16-byte elements, we found it took 4-500 milliseconds to
> update the map via batched update. This is due to the overhead of
> generic_map_update_batch() individually copying each element to be
> inserted from user space via copy_from_user(); almost all time is
> going to __check_object_size() called by copy_from_user(). I suspect
> this one is hard to fix though, due to how the elements in a map are
> laid out in memory; it would be hard to change such batched updates
> into a single copy. But perhaps that's something for a different
> thread (and we can easily work around it on our side).

I think there are rooms to improve this:

1) As you mentioned, for hash-based or any other non-linear maps, it is
indeed hard to optimize. However, for linear ones like array map, it is
possible to copy the whole memory from user-space once.

2) There are actualy two copies here, one is from user-space to a temporary
kernel memory, the other is from this temporary memory to the actual map
key/value memory. _I speculate_ it is possible to optimize them down to
one copy, at least for simple cases.

Just my two cents.

Thanks!

