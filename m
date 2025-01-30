Return-Path: <bpf+bounces-50091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37DBA2276C
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 02:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9BA188627E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6D329408;
	Thu, 30 Jan 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWayy1YE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4948F64
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738199832; cv=none; b=upzzK67yrZuB7wBMvuZu2WEwgDlGLVTy87XULHL9RwKfMsQrheauAxww3wny1fe4wgJMA2hlYcWhEWmLJT2YmcRwKmmeRrlBbV8txHRNONUrRPY5l8PT6uxhcz+gFQs0TcYohaEHgJ/9WMl1pXC4ROpdRNKaRfIs9DGsA4H+CPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738199832; c=relaxed/simple;
	bh=ffujUAFbgmhz7ZUYLUcWVIeAykLQM4Ew03siKaJwKrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCKmcdbryNeLOIbRFitjH4KlYdXb7OCVUZ9Ao0vvafagephBEd8tmxK8I89xRiso7RYXYOQuykp5MtcubDWgTd9hRCdOTnNfVO7pZZcN6/XJoB08bpORCO3BV0z4Mq7JtzZjMqTsf6q9o0wtSKTLg4F+SGoN+fPZsMi5/J/07JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWayy1YE; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso29255ab.1
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 17:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738199829; x=1738804629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV812xzV0e8aXKpif8S9KTZu09HRGN+g2VGxhmlJ8I0=;
        b=MWayy1YEu7zt6yH03dE+6yhskyWCiBc2wRS5gaMUZZtUs8JZvO5cR9k2C30bl6s4YT
         jTOGJmf5YQmmpl4LCQTsyOy8t8+/FPZwFElLM7Qcr4bT11yxTKwTmulqdRXq8Bfty9TY
         7arM6E3wuAY9dzyEXgKtzjW8+9yDDeH2mrkTf4NlaHJQ8v/c0OEtVEXqDT26WTac/nAh
         KaHRlnt69Gdwd3jSBPOdWL6iqAa8CEefb0yvXHalrpduj/oVCZyAVFgfZUXCbWsPxj1k
         QKlI7i6W9hUkXeeqnrNWsgiOZwckrigknwYLR5AsiSj/kjmDoOVpd4STzh764naehdxg
         8ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738199829; x=1738804629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV812xzV0e8aXKpif8S9KTZu09HRGN+g2VGxhmlJ8I0=;
        b=LzO2rNRt33JAW7bYYhjm1+VEajLsHuRVfOXHSUv24+0kOKBKxiBF9g3l0hQoHVPceB
         FDkQXxUgejFw77295QX4GxONp6TbE9+V0d28bKXye9govfHUFpD+b7uiQKhpLHDsBx6q
         kb8zAWUukxzlbcr7gXJaEcWrzAJ/oQrKeaktEMGLpsdq4KNKFBwc5VKRnJiym61xM1Qk
         aoxMtJrItiER6ZQjyeWrpYcunXPyYScPuN5FmZKtsuREuoKFdS8GbKeFIZWWuN58heTV
         ClNLEpSevB6mSB/DzWAMZw9WNPjpG1ssHUoJnK6lGDHmFUbfvac/EEJHTLWTvcWe7GcQ
         DKBw==
X-Forwarded-Encrypted: i=1; AJvYcCVbewmPPZ+qTXLqzswDsNLHwJSQGB51BB4oBYQ/cgG2hK+JvAhLJFaBXFLHfgKnzPKQzRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3ROha3u4yd+MweLTy24FfH97F2nYX/2BPWBXWc9RjP0VO3Jd
	xCCKBLg2IaVc3aXjbJmXkJN1KnVKIbQF+N7e6GXStUzJyHb7ydS/IiLsLdbBYMkWM8qT3hNTy24
	tebfYBZjTS+XOdThGSJm7mQabnzbFebbYsHue
X-Gm-Gg: ASbGncuh9YXDTqijLm986yCkycD3gthvMiQOqfq3hALjnVjjZoBtJECPgxgFKNNXVSI
	PLzckjzRjDV8aq7AOj3SEYkWuTEkDp0KmQCMSZsw9Vw3QYA12yJLgnM62FNdfkUkqTle2lEg8bg
	==
X-Google-Smtp-Source: AGHT+IFhocnKz4pRt+VZ0uZ9s3H2wf4R31X+Xz/KNOrL7es1lE5yacExWvi0pwSx5uErWY3GdGGuofp+Or8NaGNpP0g=
X-Received: by 2002:a05:6e02:1fe7:b0:3cf:fbc9:5c10 with SMTP id
 e9e14a558f8ab-3d0098e6eeamr1546535ab.26.1738199829397; Wed, 29 Jan 2025
 17:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com> <CAP-5=fVYMK6tnKH0QU_RPUaogpsDmhmXn+=4P1uXg-moX2QMDw@mail.gmail.com>
 <Z4WNT_UX9eMD_txf@google.com> <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com> <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com>
In-Reply-To: <Z5qjwRG5jX9zAGtf@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Jan 2025 17:16:58 -0800
X-Gm-Features: AWEUYZkyz1aRG7eZlk2U-0ehtuXuPlJRKOQYBIhCifcFv0gorlC6qNGUTSogmnQ
Message-ID: <CAP-5=fV4Q-J+Coybk5Uw=Xpx9sm5MG=2b-fvRLX14K+ZJcmz5Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 1:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> On Wed, Jan 15, 2025 at 01:20:32PM -0800, Ian Rogers wrote:
> > On Wed, Jan 15, 2025 at 9:59=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > > I think the behavior should be:
> > >
> > >   cycles -> PERF_COUNT_HW_CPU_CYCLES
> > >   cpu-cycles -> PERF_COUNT_HW_CPU_CYCLES
> > >   cpu_cycles -> no legacy -> sysfs or json
> > >   cpu/cycles/ -> sysfs or json
> > >   cpu/cpu-cycles/ -> sysfs or json
> >
> > So I disagree as if you add a PMU to an event name the encoding
> > shouldn't change:
> > 1) This historically was perf's behavior.
>
> Well.. I'm not sure about the history.  I believe the logic I said above
> is the historic and (I think) right behavior.

You're wrong as you are describing the behavior post:
https://lore.kernel.org/r/20231123042922.834425-1-irogers@google.com
commit a24d9d9dc096fc0d0bd85302c9a4fe4fe3b1107b from Nov 2022, but
somehow without legacy event fall backs which Intel added with a PMU
for hybrid.

The behavior in this patch series is best for RISC-V, presumably ARM
(particularly for Apple M? CPUs), carries ARM and Intel's tags,
implements the behavior Arnaldo asked for, and solves the
inconsistency that I think is fundamentally wrong in the tool that PMU
names shouldn't matter on an event name (an inconsistency my past
fixes introduced). It is also part of solving other problems:
https://lore.kernel.org/linux-perf-users/20250127-counter_delegation-v3-0-6=
4894d7e16d5@rivosinc.com/

You've not pointed at anything wrong in the scheme that these patches
introduce, and are supported by vendors, except that it is a behavior
change. I can, and have, pointed at many issues with your proposal
above and the current behavior. The behavior change came about to work
around PMU bugs over 2 years ago but only partially did so. It makes
sense to remedy this and for the clean, consistent behavior this
series achieves. It is unfortunate that it is a behavior change, but
the first step for that was made 2 years ago. I think it also makes
sense that something self described as legacy is a lower priority and
of the past (wrt event naming moving forward).

Thanks,
Ian

