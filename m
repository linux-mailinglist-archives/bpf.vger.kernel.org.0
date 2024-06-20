Return-Path: <bpf+bounces-32632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6B9111FF
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 21:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D3C2857DD
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71FD1B4C3F;
	Thu, 20 Jun 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VUUEoGch"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCC22EED
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911267; cv=none; b=sJ7ZSOCNVPvs3QezTUowQVz3KbjZA90yRR+0fpK+lgqlVRX+8zSZswwpDZ6llfazw2CyKohK3rrhFJB+/KaKkQv37GstaYRCH9x8Uw2O76FyUC6ZUcq2xxaAhslQOuYmmU7BXPcqF+AVgyRhbrSUV5HojMTSljINixHqfVP6kUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911267; c=relaxed/simple;
	bh=6U+UiUTO23oyjadTo0w/kiMzzky8bLwHHVEdkkl6RAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7r67bxGfFoOpSCkuR1msyKu8G2BxYugngbTaA831s27vVm36UdorQYPrvlj3HwblLhJRd7sygNSwMHjW+N2vJcZU+AEIDcTgu5DypGqGH1v4li6XszHQoLNetiX2rR+AdNiv+nIhYEAKKt0f4a2Ci1xLYHTWA2hLdfjeUuj6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VUUEoGch; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so1284938a12.3
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718911263; x=1719516063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B1iJzjizGh2wBhzxdq8cmqbfEnfFmiOa9+Uvi8Nk2w4=;
        b=VUUEoGchGpaUoDKoJNGQ2CUq4bi+WcgvaGSGmj9P2CHer263YoI3z3PhiDpvpLbCi0
         ZeTFu4F2p6RawWAMvIyaYMnSs4rvNvXIt0SwjP79kEYIFr6Gw6IatBUwBmLgXVZtLt1K
         4xzq+Ur4kKEAsZmfWVb12AdcnuXn2WJofpMKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911263; x=1719516063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1iJzjizGh2wBhzxdq8cmqbfEnfFmiOa9+Uvi8Nk2w4=;
        b=vHUww8RW8P+cDN/fh0KwKzlPsv91H0cLD8ZZR0xkCMV4mU1qtNkOagyvIjBSosRYFt
         T2MCHP7E0T6r3ckcof6b/1i+gKYkUbnpefeXm7iUKbUyXhQoZSv7MSisZ08QPGu0gaqG
         MxjVHkSyBwxDV+7+6xRMdXRhbJoTp4YRlA++a16G6QkZDSGuCRq7xUP44uZTjgjfgkpD
         +hcXaAO9asucJkJlX3ptvqa6zpiVXd4Pcv0wykyyipu0sybLQwVGEgpgL1QHy1nmr+N6
         07Ev5ZM3lwhHyrNpiSni2Oq3AhB5kidpxPUQLaAYEKNpq9qKkZ9U1zjUdrSZWEuZcclj
         9I/w==
X-Forwarded-Encrypted: i=1; AJvYcCUl+ZrYRyg5fAsMVDlBDo2m1filK9G0kxOFOdrMwzxahLgQ6Q8yTp2k/c0N3gTnw86brfhVRrnFP38vdJ3Y4QzWEwIw
X-Gm-Message-State: AOJu0Yxoq5aPvm4x2p3NDD2LiJzTp+Pi/FH2Ws9raQEV4yBdfo705keU
	UciH43JoLZZug+KeNWhF/EvPfmNsLE+F6M3vKSvDyk3u+VV1UeNuVyrG5DgQar4I4AFWSXajQoe
	DCSDQtA==
X-Google-Smtp-Source: AGHT+IENDwY7m3erGfJp9lTZzGvJnQ5QXenMBS5S/zFEQdrhBEvATQMU/Z2bxFAWhEs82YVCUDlRBg==
X-Received: by 2002:aa7:c749:0:b0:57d:15ee:3d17 with SMTP id 4fb4d7f45d1cf-57d15ee42abmr2957721a12.14.1718911263481;
        Thu, 20 Jun 2024 12:21:03 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbdfe1428sm8920410a12.27.2024.06.20.12.21.02
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:21:03 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217926991fso12338505e9.3
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 12:21:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXr39/Kt/kq79KVhKARs0O2ZCqHaozUINh/zk9AZbc0m7RIgk8uRrmajJcT6pZw3h4v0FEajMcKpoxjQaPgwVW+wyXE
X-Received: by 2002:a17:906:1289:b0:a6f:6721:b06d with SMTP id
 a640c23a62f3a-a6fab613cbfmr334109566b.24.1718911242018; Thu, 20 Jun 2024
 12:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
In-Reply-To: <871q4rpi2s.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 12:20:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
Message-ID: <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
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

On Thu, 20 Jun 2024 at 11:47, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But wait a moment, that can't happen as pluggable schedulers have been
> rejected in the past:
>
>   "I absolutely *detest* pluggable schedulers."
>
> Guess which famous programmer said that.

I'e also said that I find schedulers in general boring. I think CPU
scheduling is just not very interesting.

Look at the 0.01 scheduler, and the comment above it:

 *  'schedule()' is the scheduler function. This is GOOD CODE! There
 * probably won't be any reason to change this, as it should work well
 * in all circumstances (ie gives IO-bound processes good response etc).
 * The one thing you might take a look at is the signal-handler code here.

Which shows just how much I knew (or cared).

Things change. Back then, you could have a maximum of 63 processes
(plus the idle task).

And the "I detest pluggabnle schedulers" has been long superseded by
"I detest people who complain about our one scheduler because they
have special loads that only they care about".

> > But I get the very strong feeling that people wanted to limit the
> > amount of changes they made to the core scheduler code.
>
> Which is exactly the point.

But Thomas - that's *MY* point.

If this code stays out of tree, the goal is always that "don't
integrate, make the patch easy to apply".

This whole "keep things out until they are perfect" is a DISEASE.

It's a disease because it's counter-productive. First off, things will
never be "perfect" because you have people with different goals in the
first place.,

But secondly, the "keep things out" is itself counter-productive.

             Linus

