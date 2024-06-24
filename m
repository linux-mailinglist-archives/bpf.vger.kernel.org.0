Return-Path: <bpf+bounces-32953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D89D915975
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12F2284CDE
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690EB1A0B0E;
	Mon, 24 Jun 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6HgShUi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DC482C1
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266476; cv=none; b=OcGoJf02fYkrTxlJH5n1G+DioXSeMLdNOiXZI7dd7GqowJuwGo1IQoys4ZQsufl8gPXEYD8qSKEoRTQwwKIwHYhtJDZi5PjrCCo19Bid5pW8c1Qwo+FptRRprPJH44Abmrvqxfe/zfzSrKVip1P4tGvvZd0QYhKCxNMafhjZFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266476; c=relaxed/simple;
	bh=Cedoh9kwS2x3muS2xE7G+dr6lA4JTIOOAY37VPCJM44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pzwb4dPx9nBe5c+xxVpLx7QOY7oiHmR0/KONwUVkhnseHyKbNk9DndA7URsOAX+mINtGb6qITnVOAA7A/PZtMgaHOLKuaiRKvsL9S0hweSWL4G0VwCHyKoDSgoTuJfbLFcgHRmFF32Uy0Q+8ux4PyNOXNNB4OjQtKs5Y9GEdPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6HgShUi; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f978caf8bbso1963056a34.0
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719266474; x=1719871274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw7MOMKXjuvTBW5Fb0DPZK7hr6TUBg6gf25Mlt5UQm0=;
        b=e6HgShUiEgEQxtSgbfXQseRYqXH8hiYcttX67FTMQhjqsfLvo5UIuo/3AuxmoG/41n
         hfNhtdOWDZZbV4APeR6L0I0BiJKmYo21r03zzMRTnGleW/U6q0QXovDic499uTcpPmTi
         pS32anJ9qKZxAwaAjTK+cd60sA5MOfsuJLH1w05NzbpSS08q+bVmqC+PxjKBYN3NE0CU
         4YgcWxSHPfO/xg6min8tSD6yo4DwD4wg50dSQ9FuXcf04OZRD2BN5we462CujV2FqMV1
         gfPittDGeuiy4CQN5EeJFw1IgXkbFmLkj22brtjEtMIHWobPvbsF7U5Fs3iRXRhVAri1
         iUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266474; x=1719871274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw7MOMKXjuvTBW5Fb0DPZK7hr6TUBg6gf25Mlt5UQm0=;
        b=FsNRRbo/z4iLkJF3kFKzB4QIAQ4l86Ye6ihpc4OALbD9RoUPQpq5huwiI7nKR0qIbR
         MepNNEknPYHP1SuDtkT0/SWWXkN+/RA7rmI7bheBRXXCPox9cUpZp8ZzPGEwBtVsuNXO
         8Wwr7TuSpKiqL6GRXAzF1IS6R4v1qfdmSyUfIMb4rtbuduSqaoAC3u0JCzJVVIROYw/Q
         D5+Zbhh5TyQYipjNn1pmTe+8DRrZbsW6XvvyI7Osm0dyWbY1tVkYegQiOUbYv3pRAsM5
         0/2cBIMduikrm2Y7146eM9fGl+W9lW2xZVraNGT2xDLxZFajxv0M5eHp/vDQ/24lMYbz
         qvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYEcUCjwqkc6rVn/YUKw7l/hb4RFhd+80SJoUjcsY+LDoCvjFuEzQ1q/Z0kVZCLVM0duWmMLS7fe1N5T8lnbAQVlwW
X-Gm-Message-State: AOJu0YyQEMvq9EP4ZmhPoyYKgjYngY3ARyXfoPKN80Bzd+Aw72NLrOVc
	WrMiIOaotD2GsEQ5j4FGcjYKNBJLeGkHv8UNHtp4KPH66PXBkINTRyg3Dbp2qnucVKbjwko6kUS
	qm1Evjh5WJXA2dEgySBzKgJIizcIL2HLG2PAq
X-Google-Smtp-Source: AGHT+IFseBLL+dDi4e4qkiKuQ0dqQDnZRl+TT6zxomA87Pc+8TKWbKHAG0tHRegXChGBzohq++KJQjkxk5F1D4i5yQc=
X-Received: by 2002:a05:6871:609:b0:25a:50b3:514f with SMTP id
 586e51a60fabf-25d32cae21fmr750979fac.25.1719266473627; Mon, 24 Jun 2024
 15:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx> <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx> <ZnSEeO8MHIQRJyt1@slm.duckdns.org> <87r0cqo9p0.ffs@tglx>
 <364ed9fa-e614-4994-8dd3-48b1d8887712@meta.com> <878qywyt1c.ffs@tglx>
 <612c8f18-21e5-452d-8e9f-583f224d8e54@meta.com> <Znm22Sgt-rIU_sp5@slm.duckdns.org>
In-Reply-To: <Znm22Sgt-rIU_sp5@slm.duckdns.org>
From: Peter Oskolkov <posk@google.com>
Date: Mon, 24 Jun 2024 15:01:01 -0700
Message-ID: <CAPNVh5dSMOfb1LEM_Djo8YyhpMd7GE_CakN2mj9NiUBoiCdWjA@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Tejun Heo <tj@kernel.org>
Cc: Chris Mason <clm@meta.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:11=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
[...]
> > >     - How is this supposed to work with different applications requir=
ing
> > >       different sched_ext schedulers?
[...]
> Long term, the tentative plan is to support a hierarchy of schedulers whe=
re
> the intermediate schedulers are responsible for granting CPUs to leaf
> schedulers which are responsible for scheduling tasks. Barret Rhoden has =
a
> framework called flux on top of ghost which already implements this albei=
t
> with compile time composition. Nothing is set in stone yet but it's likel=
y
> that I'll follow what Barret is doing in many parts.
>
> Taking a step back, because sched_ext currently supports a single
> system-wide scheduler, many of the techniques that the current crop of
> schedulers are playing with are pretty generic, at least to a class of
> problems - e.g. gaming.

[...]

> So, the summary is that there are plans to support a tree of schedulers b=
ut
> we're currently mostly focusing on more generic single scheduler
> experiments.

[...]

Yes, as I've just mentioned in another message in this thread, we plan
to explore building UMCG-like per-process scheduling infra on top of
sched_ext once it is merged into the mainline kernel. This is not a
promise to actually do that (build such an infra); but rather a claim
that we believe it is possible to do that and that we plan to look
into the technical details once sched_ext is merged.

