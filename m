Return-Path: <bpf+bounces-50866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C93AA2D59E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D661188A526
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC481B4146;
	Sat,  8 Feb 2025 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="ecNHdGWa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007B1B3930
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739011186; cv=none; b=bvqwFqBimkMGI5p2DU1LC2gJ0RPIVqZ3pcT0Ll6xTOxknkxUpuXQjSKw9vKSEaFeBstGIIF81VBI6GOVwWMxNrTlcuZBjLcInBAzQ1yN/lJBJwqMRKO3mTOUBO98sgVOMgdl5/9bmt/NCUOI1UuqYlbzjqhXvrpCyDl52iE2lIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739011186; c=relaxed/simple;
	bh=T1nT9GSBaZOVZhUG+2djAhsWo2+WwIZETQIVwka4a4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edy/Zu4LF7/+Nub6O7xnBeegNIITw59oRsKTlfHwwzBAdxdPulbsQ5LI4Lf6tUdDfwtYrA16L/bK+u9BRw5FyzNs0KbGScDA/GrDCF/CRnDxFOWepkeuNrYUVD/T2UZL0LYk6p90PNz00MsDzB3JeX28iv8N8oyzlbIGADbO1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=ecNHdGWa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so5320426a91.0
        for <bpf@vger.kernel.org>; Sat, 08 Feb 2025 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1739011182; x=1739615982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UH7ex+XpuYWshXSRFhnGBXAN81LiPzvTCv8wS/FY3XE=;
        b=ecNHdGWa+Ztnni+NQczp5nu6keNtm/xs/jZN2lrUpAzpwJ1zUQ3BekrjHZC3tCR13o
         Tn38/55lpEqyOV9HsGvvc/L0PAqEuxVzAq0msFYBUVpME9OsMWeJAXv9dv61Pko77Q8W
         HJgo1TYVd49SR4IFr3jOabsgfYN9EVdXO7flY5Ul+w7B+xeP0QERCxbW3EMlEcINk0T2
         wCunKP8f3VJ9qXNzNuj4h1Kr2H5bhQt3tF4UddQ8y3ecFzl9+cvYWHQARZhCbbUiNUsF
         iE9iMzWr65E63AKy5Ynn06WdPDkXd2IKxriVqS444yJNP/g1iiKvH2YrxwvGUzFAajpz
         zg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739011182; x=1739615982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UH7ex+XpuYWshXSRFhnGBXAN81LiPzvTCv8wS/FY3XE=;
        b=lRNLCJVzYujbk8AX/USbCzLoc/kNfHNaWAOvXO4M55+tBhg58j2j5uc7hU0HlPikon
         VlHYAux6XKY2UUcWNcOi9DECR9L6zNmvVRSBrohv9hOMb2f3vjNEhPSw9xCQgxPfAEx9
         4ho7gJKmiqBTt4XTuvBh//oV2b7JGnC2ZUqBe0j+VTRrf5sxWovX3PkwbepJy8qE19YY
         cDUV+PYaPDZM4caG32SERGzHmrwrqimxhL3hiRs3+HjDMDQvrLfg0zs8iQ7K4ZcSXo4R
         PadvjJ6ovK5LxtfkRX1QgfjqUfwd4b4DHxYF+6hiyQo+JH3a3oS+BHa89YBFtwdbaFkZ
         Q77g==
X-Gm-Message-State: AOJu0YwYeWTfj2rDgqIkU4RFz74gzzsWQha3TejMx+AY8PSLMmnaSn0r
	PHkzMfDGqu2NEgqO+clWnctt7Ut8an/ViCOzcHXF3ue/zB4tZS+bpwpUe/F505qikNWuC1Qwa2c
	UO/LcLFLi1ybVtHFY/0DXvuxJwpduuTkWeplNvQfhFEP47VhHZlc=
X-Gm-Gg: ASbGncuoxAqn3JAvlrk9cBpIK0dmUgeYHPSn5qrM1ugGg8CH6TdBi04L5X1kw6a8Ecy
	Qb5oGarsQteFoKH9ubDLZNAEuV0g3YLiVOmvX8D8H4qGBgx2GepRcM5rg9dUr5bvF/2m0Njabeo
	YjfnKLEZc+EItFLaRFolU/2g+ggzSw7J4=
X-Google-Smtp-Source: AGHT+IF9lJRD9LcvC51tm7QbvQ3JXsB1hLDUaYnnmLX2kDAsDy2Rcn7LVvU3QXTyn/366CeCskgmkX+K/HGkBcjAXCI=
X-Received: by 2002:a17:90a:ec85:b0:2ee:ad18:b309 with SMTP id
 98e67ed59e1d1-2fa23f550c6mr8724820a91.3.1739011182496; Sat, 08 Feb 2025
 02:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
 <CAADnVQ+FJA6jBRxCagAR6GuW0uRysfmgCnGk=ym1-rV0DPHPJg@mail.gmail.com>
In-Reply-To: <CAADnVQ+FJA6jBRxCagAR6GuW0uRysfmgCnGk=ym1-rV0DPHPJg@mail.gmail.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Sat, 8 Feb 2025 11:39:31 +0100
X-Gm-Features: AWEUYZkUKQHxTz6Mjo4kHCgVnYqNEYieoJAul6bT9st9us0YiJrYndnYVYnHcQg
Message-ID: <CAH6OuBQa2QbCXzksiy5PhTCEYBf6m=w0ZKAUzTptxjgqKC25Mw@mail.gmail.com>
Subject: Re: Poor performance of bpf_map_update_elem() for BPF_MAP_TYPE_HASH_OF_MAPS
 / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 4:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 5, 2025 at 4:58=E2=80=AFAM Ritesh Oedayrajsingh Varma
> <ritesh@superluminal.eu> wrote:
> >
> > Given this, while it's not possible to remove the wait entirely
> > without breaking user space, I was wondering if it would be
> > possible/acceptable to add a way to opt-out of this behavior for
> > programs like ours that don't care about this. One way to do so could
> > be to add an additional flag to the BPF_MAP_CREATE flags, perhaps
> > something like BPF_F_INNER_MAP_NO_SYNC.
>
> Sounds reasonable.
> The flag name is a bit cryptic, BPF_F_UPDATE_INNER_MAP_NO_WAIT
> is a bit more explicit, but I'm not sure whether it's better.

I agree the name is a bit cryptic. A related question is whether the
optimization to skip the RCU wait should only apply to the update, or
also to delete. I think it would make sense for it to apply to all
operations. What do you think?

I also realized the flag should technically apply to the *outer* map,
since that's the map that's actually being modified and synced on, not
the inner map. So I don't think "inner" should be part of the name in
retrospect. Perhaps BPF_F_MAP_OF_MAPS_NO_WAIT or
BPF_F_MAP_IN_MAP_NO_WAIT? I'm slightly leaning towards the latter
because the map of maps support code is also located in map_in_map.c,
so that matches nicely. They're both a bit long though. Either way,
the definition of the outer map when using this flag would become
something like:

struct {
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __uint(max_entries, 4096);
    __type(key, u64);
    __type(value, u32);
    __uint(map_flags, BPF_F_MAP_IN_MAP_NO_WAIT);
} mapInMap SEC(".maps");

> Also have you considered a batched update? There will be
> only one sync_rcu() for the whole batch.

We have, yes, but in our case, these updates are a result of another
system generating events, and it is a bit hard to batch them together:
it would involve waiting for multiple events to arrive, instead of
processing events as they come in, which introduces an additional
layer of latency by itself.

Regarding batched update, we've found that it is also very slow when
inserting a large number of elements. In one example where we inserted
~1.2 million 16-byte elements, we found it took 4-500 milliseconds to
update the map via batched update. This is due to the overhead of
generic_map_update_batch() individually copying each element to be
inserted from user space via copy_from_user(); almost all time is
going to __check_object_size() called by copy_from_user(). I suspect
this one is hard to fix though, due to how the elements in a map are
laid out in memory; it would be hard to change such batched updates
into a single copy. But perhaps that's something for a different
thread (and we can easily work around it on our side).

Thanks,
Ritesh

