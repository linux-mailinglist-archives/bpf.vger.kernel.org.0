Return-Path: <bpf+bounces-51170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7418A313A6
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 19:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0E91883F27
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D41DF998;
	Tue, 11 Feb 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp/TQa5Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C826157B;
	Tue, 11 Feb 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296872; cv=none; b=joTeBv7F2eW7YhtC4ZjFLieVCaqfvnHo4nPP4QwRpewKHwopHskEmsH/SpgGjyV2Aha4gdEkHqYheZfCQgXE0vMgkm5hGomi620UYSf3YFzCrqBs2x26/vmIqkDJjDgNuE6T6hiNJxF5w1uogEBp3S0rn/W4zQZpMmFost1XC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296872; c=relaxed/simple;
	bh=5hkmwOuorZb2gxmCkHB0hfI4oiFsdLylO/wqM+DpAR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Afxu2i7NjqyuKWGePU51YOL8BdlTJw9HK//zzGLICOFLWrOn5SjxCox25966QAS4DXBFjX2CcSTj1iKWwHvgbEIPn7XSe8MRkpzXk2L68TaVkovXvyUlNWdrnEH8rkVfCGSJU3F/eNolh54t/hwljZJWdJAxihe3dC5Jvr83yNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp/TQa5Y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso39426695e9.1;
        Tue, 11 Feb 2025 10:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739296869; x=1739901669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUV7D/7FHhEkhtKkdqUEVJvJ3is/GshkRVyHniVhIV8=;
        b=Yp/TQa5Y4PkdSzoN9r1ZnKMYvYi+vlUSI2XQ2ohnOT6eqoCbwpVApD7kkZ5Svj43OF
         GF9MNow5tUqLq2arZRE6K5r6Qs5a5rU4Dbvn4ubo6VybXm5alN+K8ZydLBZfIqqWxraq
         kxXf/OizIPPUiy52T8+ttZkaD1vlGg/N2uMFilqcejQk1Ai3r8YQaDc+SwD5C8EStyx4
         zjUiOQfA6Ew2hfXuykbV1SW5wBwQ/APrtDaFzs72us+eRaHRkFoe4Vv7L6APbaiAwOOj
         sj+WAkFhLYCLUdB9n1Q2lU61x2Y0oubWg+o9MJ3NLBQEFmW2BIseAktuvJI85vsFeHa3
         kcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739296869; x=1739901669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUV7D/7FHhEkhtKkdqUEVJvJ3is/GshkRVyHniVhIV8=;
        b=AEqZYpecNPPjCsrcO2j3AXqnfGoNmDRcLk59/+FCltMW/f8BJifCeSC7ZxyG5onUcP
         ftfSuCFT6+EZfzvrdtedkQB8vYZGQzx57vRcqZoHdu4EQBIewVmOc5k6KMlhaNWHydfz
         XK4q+ejiJKicTciDQTrvrerxJccNnCGhc1nVqSNGZtPYANc3F0HkOveIVnciU3Od1oXo
         0U9W7Q1oAgBc3/rfUn9lNVnNYlKwHuYS1/lbl2nbq4Jf2dxOleKaAlYTP5bg1IjzWHq8
         Ja87Dk8ipPXFU7M8pe4tBLGE6CahZ2q9sBWlAJgilus7vciG2D0ZTZBuifB7xXpDsI2Q
         8eUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVboQ9+zosGe+fqoW7MO6+4ndWJh+qWXXgMFaweJCD1ps4rR7kDCstphwLqRtjFrVKZyc/1ILgUPHpJM/i7@vger.kernel.org, AJvYcCVfEDLDpRfV8aWa+yV3F878cKysB6jcQllJsyeSQ4vH4IHNdeuRRzTsw59aU+f6pTDi6bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywglvd2BWHonNnzj57dZH2dvK6l96Gaba7PfechL40u6/s2QxHI
	EpoO7uIsdiwKf00uLeSp4CJVi2dL42SXIx9MfjbXoiKCXExRCtmRixkmEj6XiZ4Ljd/SIqMHo0F
	Sh261pez7uRqXizRj2fHvvN4AjJM=
X-Gm-Gg: ASbGncuWES/7dwyBoH7GTu+R+eJ+HP5Dl8IrvNKvTp+b0/NqfAW0kiF2DAFAPvODQ70
	n5MaEDcXtsj9HaAfKIHZUEpO4lj1t22XSYjKXXYgoAM7KvomD8gESrW3FQMhHgu+UUSNWseogIi
	kvE4OKAjz73enV
X-Google-Smtp-Source: AGHT+IHcQ845RxBvXCqNmZWlyCfvxPz8/imRu/MMQzqaMkKRPhh0DXC4Vt/2tERs91TjyTpJDufKRRzRoTuvGlYQLAQ=
X-Received: by 2002:a05:600c:3b92:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-4395817a562mr2331075e9.12.1739296868563; Tue, 11 Feb 2025
 10:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-8-memxor@gmail.com>
 <20250210095607.GH10324@noisy.programming.kicks-ass.net> <CAADnVQKefT6iQVQ66QTCeRCMs_am4cC3pBt1Ym1fxfeeQVDDWA@mail.gmail.com>
 <20250211101146.GB29593@noisy.programming.kicks-ass.net>
In-Reply-To: <20250211101146.GB29593@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Feb 2025 10:00:57 -0800
X-Gm-Features: AWEUYZk5eSpapY-FzUEHzQMtVjTuyU3F0mPDQ4oZZjvclBX8VhXOaAxZ4UQug3A
Message-ID: <CAADnVQJjNzMapuJvOni2gPHhxRo=C7_FCXBpG2bb9ctN8L7rcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/26] rqspinlock: Add support for timeouts
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Barret Rhoden <brho@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, 
	Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:11=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Feb 10, 2025 at 08:55:56PM -0800, Alexei Starovoitov wrote:
> > On Mon, Feb 10, 2025 at 1:56=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Thu, Feb 06, 2025 at 02:54:15AM -0800, Kumar Kartikeya Dwivedi wro=
te:
> > > > @@ -68,6 +71,44 @@
> > > >
> > > >  #include "mcs_spinlock.h"
> > > >
> > > > +struct rqspinlock_timeout {
> > > > +     u64 timeout_end;
> > > > +     u64 duration;
> > > > +     u16 spin;
> > > > +};
> > > > +
> > > > +static noinline int check_timeout(struct rqspinlock_timeout *ts)
> > > > +{
> > > > +     u64 time =3D ktime_get_mono_fast_ns();
> > >
> > > This is only sane if you have a TSC clocksource. If you ever manage t=
o
> > > hit the HPET fallback, you're *really* sad.
> >
> > ktime_get_mono_fast_ns() is the best NMI safe time source we're aware o=
f.
> > perf, rcu, even hardlockup detector are using it.
>
> perf is primarily using local_clock(), as is the scheduler.

We considered it, but I think it won't tick when irqs are disabled,
since the generic part is jiffies based ?

