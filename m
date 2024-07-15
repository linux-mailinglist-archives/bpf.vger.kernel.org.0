Return-Path: <bpf+bounces-34832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059469318CC
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 18:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2D3281A94
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514D23749;
	Mon, 15 Jul 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="O0IATCKe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13B208A9
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062155; cv=none; b=YtWdF9E2E8WY92ruk3L5DeGWjkG2rq1AOjcSI8p/i3eMZZCRH+aXfJ3X0rh/eCxbrMJuRj5dfeRmYh0m1kPs8kcfnXR7xImHv6qo9Us68cfLfVSmGFDh/VDpUceIzlzfBBWqk/81dXxrC7y9dQ5NhG6kf7fIUpthXFpE05XmsmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062155; c=relaxed/simple;
	bh=BVNgqz+4odXWv/QdUrTS3ZJYLwOEmal7WpHwLv2mPPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPBWXcK6IC0N4WTM2PPnHdkr+O7+PtoqZOfSXHnxcIUH7WWvIKVmalUCPBIDBDW/GFu7w8s+0aJ9yAux9J6JKXmeUvubs0TLOY8zRRgkMZZGwPYXT/5AoHfjZ0ihYn05w65lXzE+7ZfPYht2++evl+SbYKlQRJeNWnetUSnQUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=O0IATCKe; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so52831281fa.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1721062152; x=1721666952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVNgqz+4odXWv/QdUrTS3ZJYLwOEmal7WpHwLv2mPPA=;
        b=O0IATCKey6MKjFNC30HNhcqiXRYtr6jzdhzKD67767VsixBnf+t9b6z+OZwb0+uWAF
         Sy4M1LqsS46kUGORmxMKEf/FpJ4MwKN4T/GPArbRZosgHqr2ZtbxrdbYUhEVH0RmYl4i
         ttZkwjsCGfpRLBRgxNpTDen5ISr54ydL7arrtK21e61xNzK5YYiQoB2m06FXzcSeeXu4
         am/FF5oWO898QmeLiIhD1Th8XESx3WUZ6LvkbvmFg5I9Ol6StYUyekO2xnbfnFTGi9Oj
         1J20staOnGBMYu6Zvgn9fwbhRZJiq10YZDFS+pTy8YF3UCDjExj+HqksoLedH+MWR1DP
         Y7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062152; x=1721666952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVNgqz+4odXWv/QdUrTS3ZJYLwOEmal7WpHwLv2mPPA=;
        b=w2yqc7/CdC3EJXaEdWwdLt7DEfYG+08qSuGawx3pqk3Ufn8rdeeXt9/yy8nTa82cIr
         qTs2GsqJsTlVowKKYNhvOds++TqrZaYVsDUcb7n63lDh9siYvwjmcPwf6FeEZywSV50N
         F/ZfIN4ZJV9EtcTaM92wkLKIa+yiadtmSH/MkU3itwboT+DyDpoYFj8voMAIGCDBWPGg
         JhBc9kH7ArmfDMcUFp1vklpl9Z6D8x1qa/s9jhbWzLlgts4EWs/dqjtC1j3/jmEaAOiF
         vVwu0MO94JvCejeZVknh3Twg9wPsJp/o32Y5JBhuaTzi6xmHL18qASmkezFgkZklj04h
         KZvg==
X-Forwarded-Encrypted: i=1; AJvYcCXTUVrk+9XGd3crVHE2hhooBrxXKP38891SjV1Burd9b50QBG+F0L1GVi6DXhcSKmUlIFT38S+xSZpuMZKLNolvWvmo
X-Gm-Message-State: AOJu0Yw8/FP2P/oXdEk6VKN8y1o9Fuo6ORJILpsMVK4bw+VDMLd1T4Ya
	POe0HgSDppjMswD5rObPNiL9PJk293q8xxAPpFW4G6Ru7RpN4KAodUxIL27BSk/oriWROeEdF8B
	mh2tldFJcCmyQDKppf6KGZYJm1pxyxSDgsuAJ
X-Google-Smtp-Source: AGHT+IFRSOgkzkjLnzFYhjtojv9zXtEfhnmrpuhjhF1QSAGhPIuoCZ6kU3nMDyjzf5kVyjnwwKCKcmfbXnyCQ/kBnoQ=
X-Received: by 2002:a2e:beaa:0:b0:2ee:5b64:b471 with SMTP id
 38308e7fff4ca-2eef2da5dacmr4220141fa.30.1721062151922; Mon, 15 Jul 2024
 09:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713044645.10840-1-khuey@kylehuey.com> <ZpLkR2qOo0wTyfqB@krava>
 <20240715111208.GB14400@noisy.programming.kicks-ass.net> <CAP045ArBNZ559RFrvDTsHj42S4W+BuReHe+XV2tBPSeoHOMMpA@mail.gmail.com>
 <20240715150410.GJ14400@noisy.programming.kicks-ass.net> <CAP045Aq3Mv2oDMCU8-Afe7Ne+RLH62120F3RWqc+p9STpcxyxg@mail.gmail.com>
 <20240715163003.GK14400@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715163003.GK14400@noisy.programming.kicks-ass.net>
From: Kyle Huey <me@kylehuey.com>
Date: Mon, 15 Jul 2024 09:48:58 -0700
Message-ID: <CAP045Apu6Sb=eKLXkZ5TWitWbmGHMDArD1++81vdN2_NqeFTyw@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Don't call bpf_overflow_handler() for tracing events
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, khuey@kylehuey.com, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	robert@ocallahan.org, Joe Damato <jdamato@fastly.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 9:30=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jul 15, 2024 at 08:19:44AM -0700, Kyle Huey wrote:
>
> > I think this would probably work but stealing the bit seems far more
> > complicated than just gating on perf_event_is_tracing().
>
> perf_event_is_tracing() is something like 3 branches. It is not a simple
> conditional. Combined with that re-load and the wrong return value, this
> all wants a cleanup.
>
> Using that LSB works, it's just that the code aint pretty.

Maybe we could gate on !event->tp_event instead. Somebody who is more
familiar with this code than me should probably confirm that tp_event
being non-null and perf_event_is_tracing() being true are equivalent
though.

- Kyle

