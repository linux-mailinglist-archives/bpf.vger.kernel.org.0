Return-Path: <bpf+bounces-68534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264BCB59D94
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 18:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B681BC69A0
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2483C37C0E6;
	Tue, 16 Sep 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehbwFDCu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B034328582
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040045; cv=none; b=mLEvWm0WSaH21JSQHcCfoJCKEkGopQoE9I/XaSksCcriNaGU8sTj2TZwqhtF2xhDHy2mTydxdYHU6MYfNqxIXwcD92/LYbUqT+xuYiLI46BZphLu6jq4IzjQUvP01NpdYRUXCnhOtVxNLAYl8H6O4c5Hnkn+I3WlA7x6LPlN27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040045; c=relaxed/simple;
	bh=7Sofop84B/va7wxi0s8Nqnbyag9GnDQCwWHlJf6ZXqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bK3NRpOU9gomcCo933ojPM8Ll+oxsP4ggtBMnsSXCU/Y6X4q5QnTna321lAsWqUR4h7jOAyizNu00t8UnAPAqSHKFYFiatP3CZDspFz0M/AEVfGLPC5p+e1awiWoEdySJ1Xw+nr+c2fx0HsyCROs23DEfP5Rh10EEijguah/pcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehbwFDCu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3eb0a50a4d6so1431286f8f.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758040042; x=1758644842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2rqRfC2r2fuX+wp1zySAsw0yErvwHSiNWxCbPDGRe4=;
        b=ehbwFDCuICv8yIVsAxtl/TNqFIm16IIs7Zbc7olslel8XuX1Zh3n9LBWhhQb2RaBN4
         3nOUu2lgYkQn+SGsTl69q666ql5P1xom1Of5j8gT4aYVTvWCjUM5PKnukxZKpbptrn7e
         hvba1Hkbimpk0QTwgi0Mo9uGWqFp5FWPbNAlRXhXJeBgnmpCoh/NRp9b4Gptv801U915
         hVSizpxRljb9Hg4utPuv3hun+44l6uj15O+zFozSbO2W+Ez8c7kUvhwtfPjL2Z05b1A+
         CHauRyY9NKiCI/rb7UknQ/208wIsXQununrfJm+fAO7D9y7VgLadGEGX6CeLftKcirM6
         fdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040042; x=1758644842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2rqRfC2r2fuX+wp1zySAsw0yErvwHSiNWxCbPDGRe4=;
        b=F/5901ipUzRB79q0iVar1adlUz3Mn7+b15yyCfy418spBEZ4LpxdvbN1yPzs34tWz+
         iMEGGCzl5gBzJaV+k0RD/NP/IlN/1hJQROVx6GQLVyS/LZ6uut2WJXQzJCLhNK4qzlfp
         GDejPEakFf17s2m16FPtq3qyvHH6lIxe3wGsYfot1I71/ziq/YYk+m+3kr4gK4RjjsBM
         QHxwbqYEEBKHbZtvJSXpjTn+4ySv8/GBYbKUbSWBRIgswTmnDKBAWrvocnJA5WK0W+iz
         l4XRQBGnKPE68ZQT5O3gSPdPBJRhy9KNTuoJCZ+HztOONykMIAvNHXpGjnnzl88cK/x2
         RNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0CB5Af65deG7iaW6svAndMfQCUK/tj6gPWfN8pZLJrituca5IUHBhEK9dDxRf6KY4DIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOl7lh7R5xzsjgV430irQRkXco5G/5HlkIZz4oYZZUPh7m5Cey
	r9BB8bUUeUMuQ2s3lipRqbEGKJSNn1rz1oF9P4GtMZGbIiVYaE+NXQ9NN3AfuqfY7D/UOHgSziL
	SBMxLFq4cMDH6zgOCd1c9z2pbNU7GCOk=
X-Gm-Gg: ASbGnctDwly+wXbcz1+/NxHFfmxdv0V1wy0fma69Kdb1zeieXlbKYkRlUE7vTf0n1/D
	EgAR0f6Ylw91RUS4/CplM9WInszjiWqRyYsSiyut/5Gts4hk2SJZeJ9XdxU4auuB9Su3o5j+AA/
	OYc4bIMbk21nRj66dC1400aqCup0kFGV/aynFy/NcOioaN2cjxQx3IYLYYctesPYfWy8pzS4bv8
	EToJhU/towoGBu+eZWtiw==
X-Google-Smtp-Source: AGHT+IEmHyllaH6Tbc9KYf7eMYbeLik9g3loeo865h+KST/Rbl3vhDyXarGrGY3mESwNOh8akg5iYs4wYJb/xqMH7DE=
X-Received: by 2002:a05:6000:420a:b0:3e7:5f26:f1f0 with SMTP id
 ffacd0b85a97d-3e765a13179mr16374660f8f.40.1758040042066; Tue, 16 Sep 2025
 09:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828060354.57846-1-menglong.dong@linux.dev>
 <20250828060354.57846-3-menglong.dong@linux.dev> <20250916110712.GI3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250916110712.GI3245006@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 09:27:07 -0700
X-Gm-Features: AS18NWDg9ENi7jv_wAmNLnu_TfyWWImDeSeRFU5hRrT11slnm18VacxAiPVcOW8
Message-ID: <CAADnVQLCJETYQuqeQQYnDMKvM14BnvUDSE4mi5Z_UHdhewv2FA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] sched: make migrate_enable/migrate_disable inline
To: Peter Zijlstra <peterz@infradead.org>
Cc: Menglong Dong <menglong.dong@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	tzimmermann@suse.de, simona.vetter@ffwll.ch, 
	Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 28, 2025 at 02:03:53PM +0800, Menglong Dong wrote:
>
> > +/* The "struct rq" is not available here, so we can't access the
> > + * "runqueues" with this_cpu_ptr(), as the compilation will fail in
> > + * this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
> > + *   typeof((ptr) + 0)
> > + *
> > + * So use arch_raw_cpu_ptr()/PERCPU_PTR() directly here.
> > + */
>
> Please fix broken comment style while you fix that compile error.

+1

We switched to normal kernel comment style in bpf land quite some
time ago, but old habits die hard and I have to keep reminding people
to use normal comments in all new code.

