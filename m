Return-Path: <bpf+bounces-50870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5670A2D72B
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 17:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DF81888F7D
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E4248194;
	Sat,  8 Feb 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRvMmICa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFB248176
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031329; cv=none; b=aUqToVuAcdXqKKo9znQs0uTVQhk1vdf8ftVPR6h/0Nxkbl+VLaaGaeqbL92WIRc4z+UNv6VOEfx4tTFvJtubi6vnYslY3lLBUzF5EjozjOkoR1SVJMclFsdrVsrbiKnq30cfHuMBOur5W6cBQvdS0ei2MTmdhfequTC5/YLJp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031329; c=relaxed/simple;
	bh=kwA7TvNyjqu4Wp1DAVX+xGEIHnoDp+F3s3TDCGcuaRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUuf6pMJfJzGVbzYb1iOcnBCu7mL8Xu7/psA6AVHWys9eA6C0RBhcqXxqM9h37hano+DMVa4brCWqItH3iRKoNHIEh6gOw9qU1U0/pcqBnkWdmNkDHGNCzQiahPalnuxvA+ukKL3lbjIOJzjOFppUjrBUs223s5yIaCnG+x/yZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRvMmICa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dd011ff8bso970231f8f.0
        for <bpf@vger.kernel.org>; Sat, 08 Feb 2025 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739031326; x=1739636126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLnQNxrlmosLw+GEZ/4gbtoqQUK531IlzfVWPwNxOcU=;
        b=mRvMmICavzrBCWG4OpfpCb2t5oo6YOdbTfeXhTgphKsMcJm0P9DQsUlOXnB2eT71PT
         Qag2kHAn/hBhrnV7YsGWqokPreTKYIKiQtuIqaYeCdDlW3MyjqlMVKufvhKP1K5KnOFE
         pWqWBbsmyRM50/fiB6G+rhagtTqYcuR1JYxLWgHtYy3KdALgysRa9jUb3jwWKlCveDRO
         uNKR2kaeoiWLaSerNVs70NYI64Drbr2FO2qJZTM01e4g1xiePPfmgaq8A9DBxZ0fOIaZ
         KbdXXlNeDofo6ygBRZiOoNHHnP+Y46Tk6uw4qjW3wFGweMfBTM1hDpAFd3fMiS7Erz2m
         mclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739031326; x=1739636126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLnQNxrlmosLw+GEZ/4gbtoqQUK531IlzfVWPwNxOcU=;
        b=tpnzbYdThmFNp4NJNfJOgUHPqTXRyXlocGgPwCkFra7Y5EoTiymr3V/VdL/noj1X0G
         n5UIB/FMee5LzCE/pd5ymQvP5oXMzy46KRHazz2N/MbkDeEfh70VihzP1PtlF0mUh5nP
         KRCUMvo8H/5/XC6njki/zJ8CCqLr5FDuhJ1YFiTu+J+0MxvHz5bfeMr7WMh6VYxIopAP
         RvKbDg7JLdSJZdRMscwhJcTPUaNm/11kku3h/Zil3FVGrXDOgN5i12m2UglZJ/gasK7n
         ctIjKwlmSSobT/VTwHFHX1ECvDpzePR7s6ACgbu3P9/R2pSIUQ/wYZyjdlafT45fxlPF
         JgpA==
X-Gm-Message-State: AOJu0YxTOncS4vxK0xIDHwSkHV5xF+PbibKiIbTbdNNlz8KG7OuWEw0J
	FxrBT1UHE2OSZoWYu6DgvO2DL7gowCU38P1ldAdWbh8mtAJj4+aUSaqIEdNyMWpYCqpEvS8jIxU
	Hn4UVKsUC4RICNPM+7EIeJbDP5hp3wmio
X-Gm-Gg: ASbGncunHnFoDONcLe1fWUT+As2aBrumYzWibEFSfjPyoenDFMjY6e2EjM9h7NsLvXf
	IVkzLIGXd9RLJmbzbI5qvYG01BL2RbY34v9YaS+PL0kBFAyDgO85ya9bWljz7vwV5sXNz592zLg
	HhlqA/Eco/Xl0K5BNPk1aJwTsrawlH
X-Google-Smtp-Source: AGHT+IFExh634pIPFn8GRKWCbICYtc/+bbFK5LNp2YsY6giKPBI4GaL3bk32xGQ5kG8Trigjh3Nvcw/YFI2YkD9foRg=
X-Received: by 2002:a05:6000:1faf:b0:38a:873f:e31f with SMTP id
 ffacd0b85a97d-38dc8da6f40mr5154460f8f.1.1739031325894; Sat, 08 Feb 2025
 08:15:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
 <CAADnVQ+FJA6jBRxCagAR6GuW0uRysfmgCnGk=ym1-rV0DPHPJg@mail.gmail.com> <CAH6OuBQa2QbCXzksiy5PhTCEYBf6m=w0ZKAUzTptxjgqKC25Mw@mail.gmail.com>
In-Reply-To: <CAH6OuBQa2QbCXzksiy5PhTCEYBf6m=w0ZKAUzTptxjgqKC25Mw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 8 Feb 2025 08:15:13 -0800
X-Gm-Features: AWEUYZmDAK2FEkRFEx7BsZTSX406WVy6bAtW8aEZkahIgXgnqLmwb9Kyv6KziK8
Message-ID: <CAADnVQJaOJbu9odEqCSRRfhvWtudzdN9_=ZqqO7A-jxQf9ZRJQ@mail.gmail.com>
Subject: Re: Poor performance of bpf_map_update_elem() for BPF_MAP_TYPE_HASH_OF_MAPS
 / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 2:39=E2=80=AFAM Ritesh Oedayrajsingh Varma
<ritesh@superluminal.eu> wrote:
>
> On Sat, Feb 8, 2025 at 4:58=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Feb 5, 2025 at 4:58=E2=80=AFAM Ritesh Oedayrajsingh Varma
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
>
> I also realized the flag should technically apply to the *outer* map,
> since that's the map that's actually being modified and synced on, not
> the inner map. So I don't think "inner" should be part of the name in
> retrospect.

BPF_F_UPDATE_INNER_MAP_NO_WAIT suppose to mean update_OF_inner_map.

> Perhaps BPF_F_MAP_OF_MAPS_NO_WAIT or
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

Actually we probably should make it similar to BPF_NOEXIST/ANY flag,
so it can be passed to update/delete command instead of
being a global property of the map.

BPF_F_MAP_IN_MAP_NO_WAIT name sounds fine.

But before we add the uapi flag please benchmark
synchronize_rcu_expedited() as Hou suggested.

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

Disable CONFIG_HARDENED_USERCOPY.

