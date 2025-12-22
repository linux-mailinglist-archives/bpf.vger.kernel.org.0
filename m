Return-Path: <bpf+bounces-77275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B3DCD47EF
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 01:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D7DD3004C8F
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 00:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F999217F53;
	Mon, 22 Dec 2025 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClVeC/XL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E61DF72C
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766364730; cv=none; b=EQHezRgYNtSz9PX72tp0Gq/LDpiLzHkj/0BXrNrKc1vy1V+rWj6XNbd9O5EP9ixfkQ0OqFY40KE/aKgwbpHPer2LzcpuMObHwSBhETOh/joKEWcp67Mz3qGKLeI8MOnyfUVQOMCTPt+sLYDieOdjB5LBB7AVLTribeZ+MJoWGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766364730; c=relaxed/simple;
	bh=zGPHvsjMOfedVa8KtCuZY3ReiFy0F0bvrCsI9MCYeas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByWLftrJGV0y7yaX04NkLBYINy61jAy72bcZgvnFFnZOkSnIwqiCT9bMHW/A9AR/EMZTOhDczlEkKrPL/ojcNncuvm87uP3q2tHtlVF0YcIJO47++p403HxJwi5rVgGMraRaSLRbOA4MT4R3wRITnEta4/VwvZmpgjHaORVNnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClVeC/XL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so19466515e9.3
        for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 16:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766364726; x=1766969526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sgxw54yt9GSPY/wJxGqE9fcBAoHDCIdYJf5fPQafeGk=;
        b=ClVeC/XL6ReIuYcUK+270dFk9urAIwYCrWUf0zxhvBJbItpGb4T9wJC1K7St1Ey+Qg
         ghfXt09QXW1NP56+La01R7+CdHgBmhhGQmrh37EKiU+RudqxqsRmd3O8GlF939Efevqe
         UyxnDBCxcBoDbhvUkTJZbWbhSWd03NRedTkPZ6pfXnmh+GlFNaX/vfkQq8wNzKioPaBM
         wiMTtKsu4MJl142H+MSvTmFbf/+Uc9OvbngtpP36M3MGDpGKITmDkaM4szFSqSIcXY6o
         jPHJMAE9k909JP49dPT5vIyNLlf2bKd2XiyQOkJiykOsJKfamt1vB2/aCZegNBbOYgrQ
         6j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364726; x=1766969526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sgxw54yt9GSPY/wJxGqE9fcBAoHDCIdYJf5fPQafeGk=;
        b=j7onz3T256lyxcP60Oma4Re/uDcAzts50y9Gj7m+Q4SkFxOsdG+vOwv7OYEMsK8H+g
         G0+0aafZ6uK2oAibZL42E8gQ4qpUQ9hUPFoWz4ZN55uR34RzUbOst7kmmMe/mElZx04W
         VDgyelaq421Soqo1CV/z9ebH3gM1E0Z0HYOQrjTHEDcmrZSYsDC1aSz9R6E3b0+AV2hD
         Q2A+zm7Di+4icSpNNC8WUnG2PIBF9qz03IEqoidFl+/STlwePGiCDkebiWXamiQaZtfb
         VtsAi67QJmfdNPSKZbL7NyzrFClgI8r200qEfp4TXI4gyRPPrCen2qOKuVdXf2bpIgpn
         sxyQ==
X-Gm-Message-State: AOJu0YxALoKTs7V8/TndjezQah8wwIkF8RMXYndYjmYYh5g9rnHrZWei
	2diln6Uq5XOA9o02ug6jeSZKnDN4zfo108u96Bu7Znll+ZB2h5i8+j3rhNZRg80ioCBWAJ0gNTM
	6rQbRAByc6MAgqqwWIKoWX8f3Pe4Uy3I=
X-Gm-Gg: AY/fxX4rYR9K20xxTousxT0xAxq+xPiDJ+ZIaIBJfBBLtOltjRoYltJ4VbRKul+lUNN
	Jtf69NesUZlJT5h7VAwCNT99+EYoWMHeAni4Lbk1bZQ4MdO4Jem9ERwlnBmKidT1c0UNYHcAtnT
	AUJlKHXNScwaoKgn4mfO8SqrbNtDuzI0Tube1dDvf5rjAC+1Csm9m1tD9v2RxTKFliQOcTiZU2O
	QaCw0X1tG3aeKswicSUd40E9lPRwVua98u4WZD8FBghCgl4GEKfYblS4nNQvaTBZThBGVyMbQfE
	Ku5r5rg=
X-Google-Smtp-Source: AGHT+IHA16aQRMS4Hem/AC74vdS4Ff7LKIP4VMbmo8FPVAYBL8Mw/QHeO5wccSM02ZpEMBGqze5bFexvMNsLQRlPNA4=
X-Received: by 2002:a5d:6b04:0:b0:432:586f:2ab9 with SMTP id
 ffacd0b85a97d-432586f2d34mr5077050f8f.5.1766364726514; Sun, 21 Dec 2025
 16:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220041250.372179-1-roman.gushchin@linux.dev>
 <20251220041250.372179-6-roman.gushchin@linux.dev> <CAADnVQJo3HspB9-_R5yWKWLdExDmFayDpNZ4JnoBpCw6aRNTrA@mail.gmail.com>
In-Reply-To: <CAADnVQJo3HspB9-_R5yWKWLdExDmFayDpNZ4JnoBpCw6aRNTrA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Dec 2025 16:51:55 -0800
X-Gm-Features: AQt7F2oaz8HCkylGYSDrvse4JsGkKsP4asJjXaU4aAhPWzWneVtyudJr_jhxED4
Message-ID: <CAADnVQLfrUxh6vLz4S0otPppHTNx6Dno_bfsTgt=67e=mKoeHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/7] mm: introduce BPF kfunc to access memory events
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 2:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 19, 2025 at 6:13=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> >
> > From: JP Kobryn <inwardvessel@gmail.com>
> >
> > Introduce BPF kfunc to access memory events, e.g.:
> > MEMCG_LOW, MEMCG_MAX, MEMCG_OOM, MEMCG_OOM_KILL etc.
> >
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/bpf_memcontrol.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> > index d84fe6f3ed43..858eb43766ce 100644
> > --- a/mm/bpf_memcontrol.c
> > +++ b/mm/bpf_memcontrol.c
> > @@ -103,6 +103,22 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(str=
uct mem_cgroup *memcg)
> >         return mem_cgroup_usage(memcg, false) * PAGE_SIZE;
> >  }
> >
> > +/**
> > + * bpf_mem_cgroup_memory_events - Read memory cgroup's memory event va=
lue
> > + * @memcg: memory cgroup
> > + * @event: memory event id
> > + *
> > + * Returns current memory event count.
> > + */
> > +__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgro=
up *memcg,
> > +                                               enum memcg_memory_event=
 event)
> > +{
> > +       if (event >=3D MEMCG_NR_MEMORY_EVENTS)
> > +               return (unsigned long)-1;
> > +
> > +       return atomic_long_read(&memcg->memory_events[event]);
> > +}
>
> Why is patch 5 not squashed with patch 4?
> I'd think placing bpf_mem_cgroup_memory_events()
> right next to bpf_mem_cgroup_vm_events() in the same patch
> will make the difference more clear.
> For non-mm people the names are very close and on the first glance
> it looks like a duplicate.

Also see a bunch of kdoc warnings flagged by CI.

