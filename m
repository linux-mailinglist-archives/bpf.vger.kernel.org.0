Return-Path: <bpf+bounces-32952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B52915946
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 23:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF331F220D1
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB5136678;
	Mon, 24 Jun 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAAIKdTB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544691311A7
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266056; cv=none; b=VDIeX7kkf8cO0yIImRx0ZvBJnMkcktKHvTQl6fwuUbilTGrJBPJNJ+y0eWxfXbgbJroVmH01GVFMj/pyST2KtRpX1Wo+haxRGMQbeu97c8CbqpbgCHq4EuNES0IhYePo9VjpqeC550o6OWtugW6MMIGXL1HPqogFWzPYnCVy/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266056; c=relaxed/simple;
	bh=l45P9FyiFLa91DP9dHhK7vXylPyi8T10q6ip0p2RaOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJL7iGyth2swg6HWCiDR4pZeWqVZ5FxW53Yew4zNAphWWYK/YsfdimxX3+ygFJ0iSncP4m36M4a4vVzJCcMyczOraC29TVjkUCoEKo1TFXmtbu8RqrbDjroqp0g2KKyskID4fdlqXcTztv/oye6BugYrVohqibUeDp81plQbBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAAIKdTB; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2598abc6848so2065078fac.0
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719266054; x=1719870854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l45P9FyiFLa91DP9dHhK7vXylPyi8T10q6ip0p2RaOg=;
        b=bAAIKdTBfg5zhQOJs3g1TNwvyGrOaVZeyy0UYWPjwpCh/IkiTkRSTlP9/+yYiGOQ/s
         12MMG4BtdiAeiDryt9cTpmdr4Z8Pk0NtS+sKSGgrQBR5V8DkGLB9NEzhmvFDD3+iITCm
         eYnRSr+viw5BC6y0wz9lXOTgtPf8VuGBm4f+Yd1bQt4GV9uRM+7Szi0ffHDkj+BRyzXe
         vEJL2WwBWvkQ3sBZSo7NUN6VbL4ySVU5fUaxiRbqImy4JcPrZLjigCEldj3+6+I4lXc0
         vMVUsXZ6mLeAYjvMR/+6mMQdRlBJ7YIB18kz2gXusXi0rzdRfWleTbO+nUvyidFddfNX
         3PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266054; x=1719870854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l45P9FyiFLa91DP9dHhK7vXylPyi8T10q6ip0p2RaOg=;
        b=o9mDkGJNAVcTQP1CsllqKNiOY6mHZzJ22kTSrHm3/ep7TB4MypxWq9drlSfiLaEcZg
         vpKbJjzb8xobzv9Mrm81z14fvdYHqBuzolbefvoP7M+twVqALxijhg4WC3MtJ4eALRVF
         BfOP0Mxnj6bayiYJlLiMUxc3i/pcHPSAdf+dG1qpUR2/IxX6Sd7NqabqRDnV+QsEcyfz
         iqRF4SLW1jpJEXShuGegoGrMpXSLI5Df84Yf9RdyU2SRTJR4m1mOgqo1jqKjbyB1izMX
         8KzfPUVmkX5yqAOyTopHLnadOTf+pglDb9wWLFWIF/BuMP2jKgNyhh7KZXejac3k0ZzW
         cBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5grxtYFmLY4KGr82nyDieacED8QYRwIrsApSgmDNvhPgCiq5ThrhG0R+Ku+GQES1oe+qbCrVaKmJAedBfJOBsCCQa
X-Gm-Message-State: AOJu0Yx/6oQQIwZ6yLhctxH9JimFUVtrrzL9ZE4s+/K32t2F4lpUMVUG
	j7t7jZHw6+ATglkd7rw8MPO2Hq6pG7immQjPCONXp2FxHtori6Q4/7G4CeB2zyXZTlHz7I0qssa
	9vzV5MohA9/LhFvcl5/D9NclWbXlzZ4DotBwP
X-Google-Smtp-Source: AGHT+IEjJIp9HikBzMGB+GICZNBUfgcYH5qdFxgMJrlty+6si+IJS0JI9tXBlaH3hM/rOLZr454rM1lwjM6FfPmTIbo=
X-Received: by 2002:a05:6870:d1c3:b0:25c:adef:2348 with SMTP id
 586e51a60fabf-25cf8a3839amr2705146fac.12.1719266054293; Mon, 24 Jun 2024
 14:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx> <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
In-Reply-To: <878qz0pcir.ffs@tglx>
From: Peter Oskolkov <posk@google.com>
Date: Mon, 24 Jun 2024 14:54:02 -0700
Message-ID: <CAPNVh5cn9N21jC9cbVfPbZQEQgT1MDn-N9R4RgZuvF9h3byhZA@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	joshdon@google.com, brho@google.com, pjt@google.com, derkling@google.com, 
	haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com, 
	dskarlat@cs.cmu.edu, riel@surriel.com, changwoo@igalia.com, 
	himadrics@inria.fr, memxor@gmail.com, andrea.righi@canonical.com, 
	joel@joelfernandes.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 7:35=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:

[...]

> Just for the record, the scheduler people and myself spent a lot of time
> to help to get intrusive features like UMCG into mainline, but the
> efforts were dropped by the submitters for no reason. Short time after
> that sched_ext came around.

Hi Thomas,

I'm sorry I missed this callout re: UMCG last week.

The efforts were not dropped on our side, I assure you. For example, I
posted this last year:
https://lore.kernel.org/lkml/CAPNVh5eNEBu+gcex9pAej-_YN3zMKkG+rruXhopqS6EaG=
-izVQ@mail.gmail.com/T/
and I got no indication re: how I should proceed.

There were several earlier LKML posts that similarly did not result in
any actionable feedback. Based on this clear (maybe just perceived? if
so, I apologize) lack of interest in making UMCG ready for
upstream/mainline, we've decided to wait for sched_ext to get merged;
sched_ext already existed at the time, e.g.
https://lore.kernel.org/lkml/20221130082313.3241517-1-tj@kernel.org/.

I believe that sched_ext is flexible enough that, once merged, it will
allow us to build UMCG-like per-process schedulers on top of it, so I
see no reason in pushing both UMCG and sched_ext, given the difficulty
of getting anything merged. If I had to choose between UMCG and
sched_ext getting upstream (and I do not see both UMCG _and_ sched_ext
getting merged together any time soon), I'd choose sched_ext, because
it naturally opens up more opportunities to tailor scheduling to
different workloads.

Again, I appreciate the initial help and feedback you and Peter
provided re: UMCG; but then things stalled and I was not getting any
clear indication how to proceed; and given that UMCG can be built on
top of sched_ext (or ghost), and a clear (or perhaps also just
perceived) preference by sched maintainers to avoid competing
solutions, I now believe that sched_ext should be merged first.

Thanks,
Peter


[...]

