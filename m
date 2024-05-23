Return-Path: <bpf+bounces-30365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617F8CCB67
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 06:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E790D1F21C98
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 04:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE6446AE;
	Thu, 23 May 2024 04:34:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1203C0B;
	Thu, 23 May 2024 04:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438874; cv=none; b=uK2VnbGhQU5S+UNXhaicS0/QcfSQxPvpFEuuh9dQfYgNBPleX46PpPx+usSjfqvjX/XBLyMYhBR6wKI5rY5iVS243xneWl9RxRu4jrAQrA1iZjutjAnTA4NFSpvEr3O9ePn+ZNipvoYRUh8LeGiu4E4Xim2MkldeuPICW0E9HL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438874; c=relaxed/simple;
	bh=hS9Acnxk7Hffa/ZSk/2BXr9V4kB09rgT1BDZLI6R4ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoGo+NE6bRJ7EEHejqKtJzmpAxCgr6X+Gp1baIHWYeNkYWOsT5magpQYAvLRktIOVEMrVJUT2wJg/S9Fuge242PoRav0TbRKe+mYVZ1CCQpLHbN9BT2MDRcS79QLkCqzfwn/Lo19mwtJAVQR8+xxORKSyFdfOH8xrOtECdrIgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bdb61c5fdbso629685a91.2;
        Wed, 22 May 2024 21:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438873; x=1717043673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=at5UxiV48avlyrvXoXbH6Ae16IV46P5/O03jUQ7gmcY=;
        b=mfH/33s4XmpjTPJCM+5n0XWZ+RdnhxdgbI4tNQtKHILlb4atvvJ1nRiFzkY1iQcA9u
         WhM3rXW0RwpEjwBU/OcuVenw+AWHmsCMv22qNQpiUHwabzDlNM00dsp73HKqTuvcEMCb
         XgZ0e1JmHphW8rx6DY8m+in3KEvkZxSW+5EueLJ9GbJiRtYExZvEqMcFdUA3c2WZlX8b
         XoSx2X0pl7/V9nVELs3Yf9RddbI55roUJohirjIOfyk/OtYsIpDX9lXhZZ07rHZlU4iT
         EfV5iGWilTbjZzjGPWhu5jkG8T1SC5R5QDvVKG2BS3Q3Q6oSfti+wlgnjyjd0EQoZGiA
         9oOw==
X-Forwarded-Encrypted: i=1; AJvYcCWo66UuDemO2kCT3RaSkLfFBHCaBMu3viKV1eQJl52seBX6kaDC0OypoSJsa/y1aEk8+pNmw6uNonfzkHxUw565qdvWuqv9Dn/p3jCQAym8DsgT5pvQEkBxaISd9Fe/4LPLgI6n4rU+D+T7+KwD0M/FFGAqpcaTQSgUtl6aReotCBM7Rw==
X-Gm-Message-State: AOJu0YwqEgV0Q6BFPzyUGo+7+1ECdKjrzVvsY778hh2N2QaJwcs3m0+2
	woaQ8p/SQbpYs5OeRI1xPWsNitApMvxifPTtdaoQbCvNlBOX/DfO9WDuEaNmyJRgUospwUpCQBa
	Dw/8J9c1p5S51Zz+zWcZ02VgEcGA=
X-Google-Smtp-Source: AGHT+IHkf+5HXomKRdze2Asxnjd6NaHwZaOrdmoVGhjrrDECKs/zdQMnjvBeyee4WFzt3qvhBWsRa+zq4W+CEx+jN2U=
X-Received: by 2002:a17:90a:ff15:b0:2b9:dd9c:34cb with SMTP id
 98e67ed59e1d1-2bd9f477f2amr3803344a91.27.1716438872775; Wed, 22 May 2024
 21:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424024805.144759-1-howardchu95@gmail.com>
 <CAM9d7chOdrPyeGk=O+7Hxzdm5ziBXLES8PLbpNJvA7_DMrrGHA@mail.gmail.com>
 <Zil1ZKc7mibs6ONQ@x1> <CAP-5=fVYHjUk8OyidXbutBvZMPxf48LW7v-N3zvHBe5QME1vVQ@mail.gmail.com>
 <CAM9d7cggak7qZcX7tFZvJ69H3cwEnWvNOnBsQrkFQkQVf+bUjQ@mail.gmail.com>
 <CAH0uvohPg7LtSOLDNaPwnC5ePwjwg0NtKzLZ_oJcAz7zOwdwdw@mail.gmail.com> <CAP-5=fUzD8VZRnsxEBNPK_7PAGzdFjzmBAupA-eh=7VCDHBkbA@mail.gmail.com>
In-Reply-To: <CAP-5=fUzD8VZRnsxEBNPK_7PAGzdFjzmBAupA-eh=7VCDHBkbA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 22 May 2024 21:34:21 -0700
Message-ID: <CAM9d7cgqr0Op5UuTcV2q8-Ju3yB7cYPvG7=Nrb4K=oW4Lt4Lcg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Dump off-cpu samples directly
To: Ian Rogers <irogers@google.com>
Cc: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 15, 2024 at 9:56=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, May 15, 2024 at 9:24=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Hello,
> >
> > Here is a little update on --off-cpu.
> >
> > > > It would be nice to start landing this work so I'm wondering what t=
he
> > > > minimal way to do that is. It seems putting behavior behind a flag =
is
> > > > a first step.
> >
> > The flag to determine output threshold of off-cpu has been implemented.
> > If the accumulated off-cpu time exceeds this threshold, output the samp=
le
> > directly; otherwise, save it later for off_cpu_write.
> >
> > But adding an extra pass to handle off-cpu samples introduces performan=
ce
> > issues, here's the processing rate of --off-cpu sampling(with the
> > extra pass to extract raw
> > sample data) and without. The --off-cpu-threshold is in nanoseconds.
> >
> > +-----------------------------------------------------+----------------=
-----------------------+----------------------+
> > | comm                                                | type
> >                        | process rate         |
> > +-----------------------------------------------------+----------------=
-----------------------+----------------------+
> > | -F 4999 -a                                          | regular
> > samples (w/o extra pass)      | 13128.675 samples/ms |
> > +-----------------------------------------------------+----------------=
-----------------------+----------------------+
> > | -F 1 -a --off-cpu --off-cpu-threshold 100           | offcpu samples
> > (extra pass)           |  2843.247 samples/ms |
> > +-----------------------------------------------------+----------------=
-----------------------+----------------------+
> > | -F 4999 -a --off-cpu --off-cpu-threshold 100        | offcpu &
> > regular samples (extra pass) |  3910.686 samples/ms |
> > +-----------------------------------------------------+----------------=
-----------------------+----------------------+
> > | -F 4999 -a --off-cpu --off-cpu-threshold 1000000000 | few offcpu &
> > regular (extra pass)     |  4661.229 samples/ms |
> > +-----------------------------------------------------+----------------=
-----------------------+----------------------+

What does the process rate mean?  Is the sample for the
off-cpu event or other (cpu-cycles)?  Is it from a single CPU
or system-wide or per-task?

> >
> > It's not ideal. I will find a way to reduce overhead. For example
> > process them samples
> > at save time as Ian mentioned.
> >
> > > > To turn the bpf-output samples into off-cpu events there is a pass
> > > > added to the saving. I wonder if that can be more generic, like a s=
ave
> > > > time perf inject.
> >
> > And I will find a default value for such a threshold based on performan=
ce
> > and common use cases.
> >
> > > Sounds good.  We might add an option to specify the threshold to
> > > determine whether to dump the data or to save it for later.  But idea=
lly
> > > it should be able to find a good default.
> >
> > These will be done before the GSoC kick-off on May 27.
>
> This all sounds good. 100ns seems like quite a low threshold and 1s
> extremely high, shame such a high threshold is marginal for the
> context switch performance change. I wonder 100 microseconds may be a
> more sensible threshold. It's 100 times larger than the cost of 1
> context switch but considerably less than a frame redraw at 60FPS (16
> milliseconds).

I don't know what's the sensible default.  But 1 msec could be
another candidate for the similar reason. :)

Thanks,
Namhyung

