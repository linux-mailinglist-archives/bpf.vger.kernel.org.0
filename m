Return-Path: <bpf+bounces-21935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA485413A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862E51C26459
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AB98C09;
	Wed, 14 Feb 2024 01:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHKcySYP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C6BA30
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873888; cv=none; b=cIXVgj0fG+At78TcDQiI0kJIQwzxtrkU5M7EAgoLVZkFtFE7hg5E/k5d7JniGx+xnhIN/KlCwJrc7HMjLPwxIGqQ+iuc1hukeemqApzKaN8MqS/U+w+W760LgbLMv8H1jMLFC6uni6CY+uNzUUFb2zlQuMv1YopyRnjIO51SGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873888; c=relaxed/simple;
	bh=u/OUWl+47j5cDJjs2LVRm6Fw1jbuaIzIh7BhdxjDwZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/6P9+DF/2ej9LxQLWevOR3qzHv9NeYdrZ8s3cOLEykg5XJMxcZuUp98QX74XNDATdTlCGQcey9YvYTnvFDMd36wlwyFuncAZCwC89GSx6GiWyZBdpMIk3Vw9rYhbH7ZGNQ5dOKhNq1cmZyublrdwY4RGOixo8c8kGL5ajm1naM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHKcySYP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337d05b8942so4027271f8f.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 17:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707873885; x=1708478685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAN6wJN8t3Wj9pNbdOPZpab49RIQxLUbM2po1RJfgNg=;
        b=AHKcySYPEbJEYXka5OjLhj7ZxpcNpPG7gcaL8dsDHbGkOmG0ZGUHZkHB/YzDZvepW9
         nFtyCLV+Wt4g0E4sqWtNoGWSafdmCBDBpAdKQSMVMxpKWJMyxgAXEKVlISSKPw5Q0tbC
         K3qd9XpPK+WloJ00AqByTAgwpO1YHiZ2TxIxKG9HkGAQPhD+7AN2gtfhg1RQxpwZ5p5c
         v7dAlEHM9VEgTz3Phrr6fFKNcCLYqllk8Qy68Ozezixeu2YmqRTsSd9ys1AC69NlqQ1d
         VZ7ah9LIxU4HeDcrHHhIP6YIJzVk1lHHFgqXk5oxlJgI5UdIxdY6AXl0pAc2PN0DzMxZ
         Z3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873885; x=1708478685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAN6wJN8t3Wj9pNbdOPZpab49RIQxLUbM2po1RJfgNg=;
        b=R3TXgtgJtUNlhvC7wEBn/ohgvAtW9cD8LDdkDthHnVUAviaiXWve0RpSL3y4uYxU1+
         BWHD4chH0GOQHDWq/1o9p1Bfndi9/CF6g7f9nc6INUpg6HqViz72YV/Q3dCn9F2QBqE2
         x6xkrdTYR4URXF5ag6K9QwdmmU7NqCjm2hNebQsd3paePoBwQsGTkad5ZDraZxdzGemn
         pz2FR0ichNUe9FK6KWeAX6vk7sfMiBU7GKR5MAugLwhpVTvpkziz5TjORdg1iJ0cRX0/
         wguePH0XGZvkJG1bdAvOb5U1mxZFjKdtXPDgWC2JLBoXl/5WOpWaRkCzaMWc2gpKaRq0
         ibmA==
X-Forwarded-Encrypted: i=1; AJvYcCUUdBs9yZMGsvkClcDgcAYior5m4ovYyPc1E7j30yU/Kz8y25L7yjTd233ax3kwySJD4y1wZA1vJtj/uuD096D2aOhl
X-Gm-Message-State: AOJu0YydKBkrXQ1gZkKjAU6pZL72lNjyI4Z7uVuKcEp3p2OocvtU8RDX
	JL4360eqR1HQQoysW9/yAmGYbnO4hLEu9KGK/oGSp18J/a8v/sMahESUG+etHZ+yxFyQs4ADwsn
	KGl6SC6unCouWN7XsW+SOpuz3PLQ=
X-Google-Smtp-Source: AGHT+IFP7jE013omUuIgoWyBfFFWhzTkKFhQzL7TUr3fOux83eVKQoDaYji9CCkwZ74pHixiVhVfjLLxON6raCpg6go=
X-Received: by 2002:a5d:5912:0:b0:33b:15fc:22bc with SMTP id
 v18-20020a5d5912000000b0033b15fc22bcmr645921wrd.52.1707873885278; Tue, 13 Feb
 2024 17:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
 <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
 <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com> <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com>
In-Reply-To: <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 17:24:33 -0800
Message-ID: <CAADnVQKY0UKYRUBmUZ8BPUrcx-t-v6iMz7u0AaBUKLB1-CS0qg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 4:09=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 13, 2024 at 3:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Tue, 2024-02-13 at 15:17 -0800, Andrii Nakryiko wrote:
> >
> > [...]
> >
> > > > So, at first I thought that having two maps is a bit of a hack.
> > >
> > > yep, that was my instinct as well
> > >
> > > > However, after trying to make it work with only one map I don't rea=
lly
> > > > like that either :)
> > >
> > > Can you elaborate? see my reply to Alexei, I wonder how did you think
> > > about doing this?
> >
> > Relocations in the ELF file are against a new section: ".arena.1".
> > This works nicely with logic in bpf_program__record_reloc().
> > If single map is used, we effectively need to track two indexes for
> > the map section:
> > - one used for relocations against map variables themselves
> >   (named "generic map reference relocation" in the function code);
> > - one used for relocations against ".arena.1"
> >   (named "global data map relocation" in the function code).
> >
> > This spooked me off:
> > - either bpf_object__init_internal_map() would have a specialized
> >   branch for arenas, as with current approach;
> > - or bpf_program__record_reloc() would have a specialized branch for ar=
enas,
> >   as with one map approach.
>
> Yes, relocations would know about .arena.1, but it's a pretty simple
> check in a few places. We basically have arena *definition* sec_idx
> (corresponding to SEC(".maps")) and arena *data* sec_idx. The latter
> is what is recorded for global variables in .arena.1. We can remember
> this arena data sec_idx in struct bpf_object once during ELF
> processing, and then just special case it internally in a few places.

That was my first attempt and bpf_program__record_reloc()
became a mess.
Currently it does relo search either in internal maps
or in obj->efile.btf_maps_shndx.
Doing double search wasn't nice.
And further, such dual meaning of 'struct bpf_map' object messes
assumptions of bpf_object__shndx_is_maps, bpf_object__shndx_is_data
and the way libbpf treats map->libbpf_type everywhere.

bpf_map__is_internal() cannot really say true or false
for such dual use map.
Then skeleton gen gets ugly.
Needs more public libbpf APIs to use in bpftool gen.
Just a mess.

> The "fake" bpf_map for __arena_internal is user-visible and requires
> autocreate=3Dfalse tricks, etc. I feel like it's a worse tradeoff from a
> user API perspective than a few extra ARENA-specific internal checks
> (which we already have a few anyways, ARENA is not completely
> transparent internally anyways).

what do you mean 'user visible'?
I can add a filter to avoid generating a pointer for it in a skeleton.
Then it won't be any more visible than other bss/data fake maps.
The 2nd fake arena returns true out of bpf_map__is_internal.

The key comment in the patch:
                /* bpf_object will contain two arena maps:
                 * LIBBPF_MAP_ARENA & BPF_MAP_TYPE_ARENA
                 * and
                 * LIBBPF_MAP_UNSPEC & BPF_MAP_TYPE_ARENA.
                 * The former map->arena will point to latter.
                 */

