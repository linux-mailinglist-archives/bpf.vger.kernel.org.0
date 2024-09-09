Return-Path: <bpf+bounces-39210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B25970AE4
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 03:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A5F281E60
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 01:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C975ADDC7;
	Mon,  9 Sep 2024 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSc4HkXp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3828EF;
	Mon,  9 Sep 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725844133; cv=none; b=Nu7o8GQT/lOvZOhc9Zko5+gUqI7KN9g32plPzIE6GyTta/OfDQdqd+4kKg02yWctUEWHdfjJp5wjK5S6IU3nht2SAewuGLrCObvx7rZkgWWL2bqzVmNoSCGlHrZRYiPVzDt71UhTDah65PYZLRJUgT8WdKj/OXCL2hxiEJr20qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725844133; c=relaxed/simple;
	bh=IxC6Z/GdaomlvqgADd6jb6fWI0AkCA513Vec7jMJuKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=I2KmP9MNSW07RORxPh+x5JZGY3f3eWzuc8bRPqNiRvseaM/qpRh3/BuYFEqTsQP/jpgSDEGczqSXogVMZQ9XFmelNLo57YZ0yW4UTybcLkt8oMksVbApprkOihxNpyxwk6V6+UbZuOWrOcnyXnNWdpKW4pbSgV0uWfhoriojSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSc4HkXp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d4f9e39c55so2550499a12.2;
        Sun, 08 Sep 2024 18:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725844131; x=1726448931; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKNbVeIN4E1J7b6asuuyRn99aGJZxDfyfdXFbSw1yAU=;
        b=nSc4HkXpSBIXHwKMDbNCtZxVjkv2/DiVrsJCM+fG7DZxyoII43lQX9gIVsSmPxF3rW
         C/nPSUgZaHm42+Np496UM2GMFs4R5Bd8vh1SK77gcFSiL436WatmSNN+RAHhkTMM021p
         SpsZpqedvjzf/V70u3DxNCulFGThr0j6S4/Nx9mWOzHEjNjIDjPKSBlvjPKQEH3la1lW
         7pj5pPaSozq2ESMnJXxWn0UUsblZo/SO1r1VBKNWjSPkiDBAFTBmJXUltTqpSE/p5g4i
         HfottV0FyLhCnylhx8PydGlFhhhI8SGQhPkM5jQ7il6KlUxz3VvCzsNDk3rQ143RBlGL
         ls7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725844131; x=1726448931;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKNbVeIN4E1J7b6asuuyRn99aGJZxDfyfdXFbSw1yAU=;
        b=qbycVILplyluqu4xqtET1dMR0FW5rg1ZIxLHWBbrj+sVy/+sud4MIghcFkunw7pzJs
         aYDFZsvPIlnc9FtCuwj5XGbac/Wzi2g4OGc/DWyMZGDuAQu8KMqbBXYtEmOI04ETN3pA
         Ys6iANXQMfsv7DVXyi+8XUebQzK94iq4h3SeMAriYfS1yTC34GFb7rW6n10yAT+UHWCW
         JHnhQIhhpytViPdB33sSsWAVHJ0S0moq3Yldmjeg+uENBV79T2/q7nVVgB6WmlBTpD1l
         RVwATkP+FG8ziGx4KI9Jq4ht/zjKAuNA0qdiEgdY/ZKvVanj5On5KMn/wPvHw3Un34Iq
         HwlA==
X-Forwarded-Encrypted: i=1; AJvYcCUEJVRT02D0SdfwyruotogYAGKXBnGdHiH1XjGzGy9oNzzxMWdjUYv5OkCEHwEqAgBZ3XM5RzK63fGwziLJaUc8YEDl@vger.kernel.org, AJvYcCX2CYuOsGpxzpfXHC3Rjat+nqcFsCg6KFctWd+bs+Mg8Lp8IARQ6nyrIu0l4mnkRrxtSHl+x7pCQtbTJjh2@vger.kernel.org, AJvYcCXU8/SGGlRgc+uP5mnfqXYxtSFivABTZeii+ZtA38FbDxSmsQGbhoy50wCi+kda/sfNBqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3VJd86uttL+gb3Z3aHO23HbMCLjk2zPzFBQmjDKrVEmBAXyG
	QR0i/B7u1l+tf/cpmJKJua5mfse7oQlg/fqB1PL86XeDSAw4RjUjCSdXJuwK5gcCLW0ESYuTHBN
	GoRFBXnkzf8lKxI7DBIDfRGojeOA=
X-Google-Smtp-Source: AGHT+IHviyd+MztZHLZ1PONgr8WHid8/FvS/G7KWLzX3Evvawum9LD2znLZsH3oJJGDbwpitRHcujJMf5zch9B8SpsI=
X-Received: by 2002:a17:90b:3504:b0:2d8:d254:6cdd with SMTP id
 98e67ed59e1d1-2daffe28fadmr7420121a91.38.1725844131190; Sun, 08 Sep 2024
 18:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <u2artc4iwuoo5y5rutseqlvnq4i44mcxne2ufwg3ya2hyonv45@v2ob54ci6ky7>
In-Reply-To: <u2artc4iwuoo5y5rutseqlvnq4i44mcxne2ufwg3ya2hyonv45@v2ob54ci6ky7>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 8 Sep 2024 18:08:39 -0700
Message-ID: <CAEf4BzbjiHjW7PTd2ONNkpU9CR68o8Wizuo0Y2MwmTSv6zw4JA@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 6:22=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Andrii Nakryiko <andrii@kernel.org> [240906 01:12]:
>
> ...
>
> > ---
> >  kernel/events/uprobes.c | 51 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index a2e6a57f79f2..b7e0baa83de1 100644
> ...
>
> > @@ -2088,6 +2135,10 @@ static struct uprobe *find_active_uprobe_rcu(uns=
igned long bp_vaddr, int *is_swb
>
> I'm having issues locating this function in akpm/mm-unstable.  What
> tree/commits am I missing to do a full review of this code?

Hey Liam,

These patches are based on tip/perf/core, find_active_uprobe_rcu()
just landed a few days ago. See [0].

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3D=
perf/core

>
> >       struct uprobe *uprobe =3D NULL;
> >       struct vm_area_struct *vma;
> >
> > +     uprobe =3D find_active_uprobe_speculative(bp_vaddr);
> > +     if (uprobe)
> > +             return uprobe;
> > +
> >       mmap_read_lock(mm);
> >       vma =3D vma_lookup(mm, bp_vaddr);
> >       if (vma) {
> > --
> > 2.43.5
> >
> >

