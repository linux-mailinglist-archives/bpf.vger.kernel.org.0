Return-Path: <bpf+bounces-43136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562B59AF919
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 07:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB9E1C21C94
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 05:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FC918DF67;
	Fri, 25 Oct 2024 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFXjaBdP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1F22B641;
	Fri, 25 Oct 2024 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729833161; cv=none; b=LRGcVxEHtHffAWkj8cUYns90515Qe9CqKl/RIExmkRiPCip9QnaefNYDIPwrIO8hCfNwthAUiVRICAz0Cj8uFX1pQLtRFsjz8gXW/Vx+wChJepmWbUy0enaKYNi1MZri2TN3GD1ZG9ubsbd6QomuO6C/dz9is9dxMT8k3ShMxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729833161; c=relaxed/simple;
	bh=/Tpkj435EOyN50vCRF2Ax6BCjnil4B9JArHmpZ92C68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcvdcnNUtNIesWF/Ke7+LtQDlM/2vjtoRmZvnw531f+CHl2pOA3sykdR2HfZmH9HKJNBLYRS7nIBf/qVuLnRkcX3D+bNMeAHyuzLbV7ySRFq8oB6F47qINUR/hLgQ05Mc2UmbnNDEhp7dTBujO/+MOxhbLWJOYzjuTX7G3Qpgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFXjaBdP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e67d12d04so1223609b3a.1;
        Thu, 24 Oct 2024 22:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729833159; x=1730437959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tpkj435EOyN50vCRF2Ax6BCjnil4B9JArHmpZ92C68=;
        b=UFXjaBdPMuEsxjm/8PXonrsCCxbJEUrAzFZ7q7+5gHcGNh9Iq8OJDWkfs9f8kVYBEF
         IC82IEVkF5mztYBjMqOIQiQEcClMhS15UjxrWkgMpCX0Li20xSh2l3YVOEyKHJtUBx/b
         0pJSOBLUp+H+Ju2vK51fPmZdU69VVlilsLRFMdOakL4uovJ030YFQcDZRPcr3PToil9M
         1xUDwK38BJtM4cMbAxiw0BuEVhknSYTc1teEbGh6fTJtDm4yZEV2+snWokAmZZDnl1Rg
         0aKgC4sVrbMgTvvvYqzpdvTDbZINx0P7uzRtaOFskW7ru5lHp3GtYVB77AA5PQoE89MB
         U8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729833159; x=1730437959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Tpkj435EOyN50vCRF2Ax6BCjnil4B9JArHmpZ92C68=;
        b=NLxXRMxBaDKMj0ABiViNW3B4UXO1n4flmccrjyH/9XnIt9tHuUO9BDXlZEuHK43H6n
         7MPckXmenJ+WVkfIL6LZwssO1pC3kL9MmDygdygUIWUwhElhc/tVycyqh0/P0sabEs4y
         4BruU8UkKjg56NV/KuaHxPLppQuLSgK4Ppbw2wXiM3JKoe5dWot/ohqj6Rl+hDEdfRUl
         ijeUwqNIbV4glnxRJJ2PsORaHdWM9K11d/t+wTsMxHr2gnAQN50fvvrskGrCZ9yn0b7w
         rdXxJbtWkmvWQOb16B8WiySzYLMvbDwcwj0/jUCP8dKf/O+KMsHOUDaeEpe0CTfj3wju
         n4qA==
X-Forwarded-Encrypted: i=1; AJvYcCWy9eJgpbQPCDVcHRm2xOcK+TNZjraiY/mU1LfRBjihAxRJMY9vpCZd8S2dOatl7smPfYG6Y+LXuq/V5r3Lro0AZCYF@vger.kernel.org, AJvYcCX2CplE+3tEnFs0mJ55nJEFuQBvxe+q1LIerxZn5GT1r9BNlgUGpEO8862QLgCwwUK1Lfs=@vger.kernel.org, AJvYcCXFiMYtDQ6roqPRClSZlCSnQjWmdd7fiV2KM4QXsmuvHoc30XlCPprL9PjO9WiL5iNkdqenjPzAhIVmA4xp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03yk765VvP9rfd71iz4VOzvE4K4mTZzZh/vvLWyMgdglE+1dh
	l7CUYubhGlNOHU5NVh7HggdkDdJIPPb6AuVD4q3/kD6DjjoAw8FYAkWZjh46euSa7KohpNngPJ8
	pv4ljZXvVuG0mRLd+KndAKnYiSig=
X-Google-Smtp-Source: AGHT+IEAk9YojetBkRLJe53COqtiLGEYhreTaZK/7pHC6B7uYCYlMywQUqjE4kFyEuwzJ2rYrbPOLuLkU41RwAyyzlk=
X-Received: by 2002:a05:6a21:168e:b0:1d9:2a0e:971e with SMTP id
 adf61e73a8af0-1d978bb27c5mr8798561637.46.1729833159199; Thu, 24 Oct 2024
 22:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <20241023201031.GF11151@noisy.programming.kicks-ass.net> <CAJuCfpFMhoCmqGJMU2uc4JHmk9zh88JzhZAeSz3DgvXEh+u+_g@mail.gmail.com>
 <20241024095659.GD9767@noisy.programming.kicks-ass.net> <CAJuCfpGxu=z-2Wsf41-m4MQ6t7DjfiiWXD408BW8SjTfx0NGTg@mail.gmail.com>
 <CAJuCfpGYzG+3aLjobsXcTSoo9Jo9MCYA_QcROPyLRKEeVHkLGA@mail.gmail.com>
 <CAEf4Bzbf_2tJL1ogZegy2sD=WbNmdKHXuXCXtAALGYuWYgyEEw@mail.gmail.com> <CAJuCfpFJG8MS=LMC2saYYRPGv+xs+UXkrPWD9_Eo1VqY=7v1ow@mail.gmail.com>
In-Reply-To: <CAJuCfpFJG8MS=LMC2saYYRPGv+xs+UXkrPWD9_Eo1VqY=7v1ow@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 22:12:26 -0700
Message-ID: <CAEf4BzbHs+XQK9GZQ59VB27s9Jz6AR7fQmX2XTsyTdz050xkOw@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:33=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 2:04=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Thu, Oct 24, 2024 at 9:28=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Thu, Oct 24, 2024 at 2:57=E2=80=AFAM Peter Zijlstra <peterz@infr=
adead.org> wrote:
> > > > >
> > > > > On Wed, Oct 23, 2024 at 03:17:01PM -0700, Suren Baghdasaryan wrot=
e:
> > > > >
> > > > > > > Or better yet, just use seqcount...
> > > > > >
> > > > > > Yeah, with these changes it does look a lot like seqcount now..=
.
> > > > > > I can take another stab at rewriting this using seqcount_t but =
one
> > > > > > issue that Jann was concerned about is the counter being int vs=
 long.
> > > > > > seqcount_t uses unsigned, so I'm not sure how to address that i=
f I
> > > > > > were to use seqcount_t. Any suggestions how to address that bef=
ore I
> > > > > > move forward with a rewrite?
> > > > >
> > > > > So if that issue is real, it is not specific to this case. Specif=
ically
> > > > > preemptible seqcount will be similarly affected. So we should pro=
bably
> > > > > address that in the seqcount implementation.
> > > >
> > > > Sounds good. Let me try rewriting this patch using seqcount_t and I=
'll
> > > > work with Jann on a separate patch to change seqcount_t.
> > > > Thanks for the feedback!
> > >
> > > I posted the patchset to convert mm_lock_seq into seqcount_t and to
> > > add speculative functions at
> > > https://lore.kernel.org/all/20241024205231.1944747-1-surenb@google.co=
m/.
> >
> > Thanks, Suren! Hopefully it can land soon!
>
> Would incorporating them into your patchset speed things up? If so,
> feel free to include them into your series.

I don't really think so. At this point the uprobe part is done (next
revision has a comment style fix, that's all). So I'll just wait for
your patches to be acked and applied, then I'll just do a trivial
rebase. This will be easier for everyone at this point, IMO, to not
couple them into a single patch set with two authors.

Hopefully Peter will take those patches through tip/perf/core, though,
so I don't have to wait for mm and tip trees to converge.

> The only required change in your other patches is the renaming of
> mmap_lock_speculation_start() to mmap_lock_speculation_begin().

Yep, no problem.

>
> >
> > >
> > > >
> > > > >

