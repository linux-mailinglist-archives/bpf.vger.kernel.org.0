Return-Path: <bpf+bounces-70577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B1CBC387A
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 09:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7106351EDF
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBB2F0C73;
	Wed,  8 Oct 2025 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWSKKDAE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA1246773
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907031; cv=none; b=CS6NCzdANmMPkPT+uDm5SRw8H3vHyCGwyVsSKoZHQ5uCRsQD7/uCYTHnXtki0GJ/FgNsAw6hZT2l25a8PTuNV56ktbTNiz/As1ryk+5gYyaE9AecvoqBcxV4zWp2uLJjROnPR4yO5srcmR4imzufxeVzKh06308X98FzcAjLvHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907031; c=relaxed/simple;
	bh=ZIBontMI3JXOfH0koR9RkZgD7vrZZLov/LpVr4jsmxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0dyQOxwaC2qFqFuI+F9v7S5Dgq61jqWEizAdYgaN9yGqzS/rfGn9n8mcAeFCcecoUaib5JEmXYCc5scWU5MfplQVh/acxW0GRhnfKke2rrVT21XZK9mNbfY30uC/EoDqV87SwMOIZu8sw21iWTtzVApMobi5tJw/El6RzNAZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWSKKDAE; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78f75b0a058so74026926d6.0
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759907028; x=1760511828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIBontMI3JXOfH0koR9RkZgD7vrZZLov/LpVr4jsmxQ=;
        b=GWSKKDAEvQrV7su8NC9s0viCQk9hrOTV3vHcDiJZpbP2DslEHA05H+E5qd7IiAyd24
         a4HCrSnRoqrKoElO1JHha8Nw1MfJIhYLRWw6WLaDX72XA4UTze7PS8hod42l9thQWIso
         00QzSfgVdQbVS6ix+l1w1FTbY1nMPdvYQza7+a3dG4x5PRxvM69TAKiqD5+j6cwaEVdV
         6O4rM918JTTIBudbCn5rcwAnzx9E7mVUWB9lD5sNOpup9QVUO3yux1uLNj5ysj4Nbit4
         gQmfLptggOSxpCuJF2xovP+y2pCaiwzvTZeWVVpm6+pOFhYDw45enUhYznPFZWehyAMi
         haGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759907028; x=1760511828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIBontMI3JXOfH0koR9RkZgD7vrZZLov/LpVr4jsmxQ=;
        b=n3ymHcBSI/hrPgV7HWcBKfZKgVLvGGX7Cna35EmkGp4+FRSFAKi+cFhMFAj6WDdox5
         hiVrLe4UZHKYaH6Gf6Vh+bHNeb+XxMVkeRiCI5oH4WT3hWiO7g0ovgXv1rh1Dc9lgNrI
         SQ1xxwC22G8rC1zLpcGgEU8WRbYZThZ4dtywl51FBCRXMdoCt74DKmqeQGmL/2yhlTfK
         L8ghtRCbSLrvByvjErtHIaE591br7SQDc84f6129s377IKU2XxWdyZlaiLrB0LymtlXu
         NNQviP1vCuiNLN33WeUu5qo2cOTqq+DNSdeb8Zf6OEtGoC6TuFdtEg1n7B3bOYwlqFap
         V/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVP7OfDZV6xrgzPV6LC+bN7aHmQM0wyyibJL6pmdx1PHqKkdvYOTjMNmrs2VsE4QVWcz6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6CM3aGQuqqGw+q/DjVQwngpP2nUJdPjyjzbeiM6h6nr8jazli
	kvsBIhlOLGyEr/IbyVvhvg2Irg8nFEDRwk8F0Aj0HqhFcGoG3crOHL1747Iijhuh1obdpUT3tCz
	zi0eh+UJ2UdeoBmLYBmb88QFndxGVPLs=
X-Gm-Gg: ASbGncu/OGd6tuA037gB7VlXqPARjbMNIme+Y6Dc8xU3IPhpbz3W4jggGNOQLzklwpI
	MCfpN6ed5PA70mwRd5NlMOrA+fdQLvnwMm2BK8Q+BZI6YwYiYFxy/WTNZwkqWgO1KfJ8L1Otvji
	9cynLlhLX/rNQ8DSpCMl7JQiJ7LR+8dcT72lVt/Zu/Tsq06cUgi8mZMyTloROsaJomt0PSUMUHk
	XCTkybqBM/uvK1BlbYX6UyjJbYrpcWS
X-Google-Smtp-Source: AGHT+IHedmjtfrfQZ6kW8QKuwAdECr6I1hiXfVOXlZcxsFN061YcDFnfXfAPwRPbs6K5+eMFaH0JseZMD/Jr2viOYaM=
X-Received: by 2002:a05:6214:5199:b0:720:3cd9:1f7e with SMTP id
 6a1803df08f44-87b1bb42849mr30308086d6.0.1759907027966; Wed, 08 Oct 2025
 00:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev> <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev> <a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev>
 <877bxb77eh.fsf@linux.dev> <CAEf4BzafXv-PstSAP6krers=S74ri1+zTB4Y2oT6f+33yznqsA@mail.gmail.com>
 <871pnfk2px.fsf@linux.dev> <CAEf4BzaVvNwt18eqVpigKh8Ftm=KfO_EsB2Hoh+LQCDLsWxRwg@mail.gmail.com>
 <87tt0bfsq7.fsf@linux.dev> <CAHzjS_v+N7UO-yEt-d0w3nE5_Y1LExQ5hFWYnHqARp9L-5P_cg@mail.gmail.com>
 <87playf8ab.fsf@linux.dev>
In-Reply-To: <87playf8ab.fsf@linux.dev>
From: Song Liu <liu.song.linuxdev@gmail.com>
Date: Wed, 8 Oct 2025 00:03:37 -0700
X-Gm-Features: AS18NWAyjZKWTXeQJNB3PaOT3WzsTXBdhqC-Rkcj8nywQj_gcgCbw3kGbTWlhpA
Message-ID: <CAHzjS_tq34QC4NDQd_L8crQii2QZCxZr28ywSw=gMnFnqD_z2A@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 7:15=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
[...]
> >
> > I am not sure what is the best option for cgroup oom killer. There
> > are multiple options. Technically, it can even be a sysfs entry.
> > We can use it as:
> >
> > # load and pin oom killers first
> > $ cat /sys/fs/cgroup/user.slice/oom.killer
> > [oom_a] oom_b oom_c
> > $ echo oom_b > /sys/fs/cgroup/user.slice/oom.killer
> > $ cat /sys/fs/cgroup/user.slice/oom.killer
> > oom_a [oom_b] oom_c
>
> It actually looks nice!
> But I expect that most users of bpf_oom won't use it directly,
> but through some sort of middleware (e.g. systemd), so Idk if
> such a user-oriented interface makes a lot of sense.
>
> > Note that, I am not proposing to use sysfs entries for oom killer.
> > I just want to say it is an option.
> >
> > Given attach() can be implemented in different ways, we probably
> > don't need to add it to bpf_struct_ops. But if that turns out to be
> > the best option, I would not argue against it. OTOH, I think it is
> > better to keep reg() and attach() separate, though sched_ext is
> > using reg() for both options.
>
> I'm inclining towards a similar approach, except that I don't want
> to embed cgroup_id into the struct_ops, but keep it in the link,
> as Martin suggested. But I need to implement it end-to-end before I can
> be sure that it's the best option. Working on it...

If we add cgroup_id to the link, I guess this means we need the link
(some fd in user space) to hold reference on the attachment of this
oom struct_ops on this is cgroup. Do we also need this link to hold
a reference on the cgroup?

Alternatively, we can have the cgroup hold a reference to this
struct_ops. This way, we don't need a link to hold reference to the
struct_ops. I think this might be a cleaner design.

Just an idea. If this doesn't make sense, we can revisit this with
the code.

Thanks,
Song

