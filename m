Return-Path: <bpf+bounces-43104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED29D9AF42E
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 23:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5663DB21853
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697F9217320;
	Thu, 24 Oct 2024 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCXtLERL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB481F8184
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803869; cv=none; b=fPeml1RUPXZC2ZXprmUatR0l6kyf0tkXCwr3/Jtvm9Tpj0xb9DM1n/gKXPSBQKGwrZ8v9Mco1OFO5/2PyJbDOnPzIYlPhxeU20ALgPMJLPfDSu0Kc/VzNOClTUn5b73uI0BgiuflHukBcf8mM2EO5nyelwW1+2T26dpS//PXiWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803869; c=relaxed/simple;
	bh=nqqSg47he0TtlycFFpXvz9xRR7UfqPmmjsU1yS4l5II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4nVhHSDDHMMmgwwFUwHcX5t6lAi+wZrCwSKHBfBmzIZPMSU9QuDBDkABCVZ96wxYQDuy4Q29HQS+fFiwJLa2jcN33MJBdYFivNuTsqpI0EneJJ7BRMjvf63hA27AG9qdUR8N4xCBgtqpKz5ff64Eig+J7l2lO7BssXTU9UN2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCXtLERL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460969c49f2so97271cf.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729803866; x=1730408666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqqSg47he0TtlycFFpXvz9xRR7UfqPmmjsU1yS4l5II=;
        b=WCXtLERLGg0rhpPjU5VGI+IHHsqzY6MxgemGEvYPWCGmtcvS0A07TQ5AIs0y/aeKWS
         MSyZuHs/2yVnHyuwHMMTaGR8vR+HT+gZXFZNU5BpE/Xu6aA47Thf4TkwBWSD++npE8KG
         Nmt9hYJlIN+sv7R9/Obn6eSpklhSM5gFH492ctFK1TBEfT8nCKzJsPUt+wZGx8SfAlm0
         9Y/6Qy1YbyS6B3Z50SyJC2cqTS95mEeAPfWeB2J0cm50/D4Gz+fuEY/ipVmv8pfopmOt
         JS3hEtvP1IaLL1qahnb7stT/NuzLl2r4epj/HcfmsdP4qRESIk9CkCPJJzpw0ifQBz5D
         DcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803866; x=1730408666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqqSg47he0TtlycFFpXvz9xRR7UfqPmmjsU1yS4l5II=;
        b=VeC9uiBSpzC/Rf1sTcpmzXGGQrPC2ra17uOmbA967D6E7N5/ZqmeAfs1iQn0jHR+1B
         83QSGqn/zYzLyKCaxrM4VcqIcyf5Wxp/9yzpPovS7hJ5Xy5cUIuRB4Wp+RbHtBMR1aiB
         0eue2EHe3WA/g1BAJCx+WMxAScStiTkMmN1SFdNubmSCoceuGrXaKaqjkirfjOu4DqZm
         Heyk9vmucXPiLrjADsnt+hy82x7TOwCfIoQzq956Dd+43cGDtO5zDS+1keT+tZWdlIQy
         CWRB9gVETLrb7q4/CmE8oooZhMizGW+zx/rb8EHiI9paO57Sk7qArbPGPSiDhuXumPRv
         ADDA==
X-Forwarded-Encrypted: i=1; AJvYcCVdq44ZAPGFT5S/CnKgbnBIx5RE8UmH2ZAivLnFCTH8u9D9M1ppenJEazB58VtA/bVvgYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0vVXK7yOpk6kYoL9xGWACw9gA/3bz0K82n+VpxPE7oGm7JGp
	m4wgX0nOhB+EKdfIXHjpBuW9xoTNGmjK6UCE3CoTB8q+Q+F3R+q1DFm5bduPbeQ0S4ALzZGLQ4J
	0ydqgxWBbxB2xqFo7kkb81Jj1zooib2H2iLKH
X-Google-Smtp-Source: AGHT+IGisIN/UZv7/esRlf3uon9fn8YMbFTRhXss794QzDx8oCXm0J9V3yroMLoSfTdav1KAufZuEW84U22WNwJ62yY=
X-Received: by 2002:a05:622a:4b0d:b0:460:4841:8eb5 with SMTP id
 d75a77b69052e-461306d63f2mr89291cf.19.1729803865443; Thu, 24 Oct 2024
 14:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <20241023201031.GF11151@noisy.programming.kicks-ass.net> <CAJuCfpFMhoCmqGJMU2uc4JHmk9zh88JzhZAeSz3DgvXEh+u+_g@mail.gmail.com>
 <20241024095659.GD9767@noisy.programming.kicks-ass.net> <CAJuCfpGxu=z-2Wsf41-m4MQ6t7DjfiiWXD408BW8SjTfx0NGTg@mail.gmail.com>
In-Reply-To: <CAJuCfpGxu=z-2Wsf41-m4MQ6t7DjfiiWXD408BW8SjTfx0NGTg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Oct 2024 14:04:12 -0700
Message-ID: <CAJuCfpGYzG+3aLjobsXcTSoo9Jo9MCYA_QcROPyLRKEeVHkLGA@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 9:28=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Oct 24, 2024 at 2:57=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Wed, Oct 23, 2024 at 03:17:01PM -0700, Suren Baghdasaryan wrote:
> >
> > > > Or better yet, just use seqcount...
> > >
> > > Yeah, with these changes it does look a lot like seqcount now...
> > > I can take another stab at rewriting this using seqcount_t but one
> > > issue that Jann was concerned about is the counter being int vs long.
> > > seqcount_t uses unsigned, so I'm not sure how to address that if I
> > > were to use seqcount_t. Any suggestions how to address that before I
> > > move forward with a rewrite?
> >
> > So if that issue is real, it is not specific to this case. Specifically
> > preemptible seqcount will be similarly affected. So we should probably
> > address that in the seqcount implementation.
>
> Sounds good. Let me try rewriting this patch using seqcount_t and I'll
> work with Jann on a separate patch to change seqcount_t.
> Thanks for the feedback!

I posted the patchset to convert mm_lock_seq into seqcount_t and to
add speculative functions at
https://lore.kernel.org/all/20241024205231.1944747-1-surenb@google.com/.

>
> >

