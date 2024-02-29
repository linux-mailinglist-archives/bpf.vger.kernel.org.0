Return-Path: <bpf+bounces-23088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3235086D668
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D282854E8
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA66D52D;
	Thu, 29 Feb 2024 21:53:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520EF16FF46;
	Thu, 29 Feb 2024 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243614; cv=none; b=VbhZuKQjLdQLpj1lTUplml4yLYb7N9z7wxSXYBrMW1XFs2ijQLMk6rz4j5Akl6sbQP0U6YTiMTYQDj0zhHFBweVZR1jeGmM+D8HrMIOQ9ly//8UG6tY7REyfDXElRQl7jzQ0E3TO+Z1ffae5R4gN6OGagwhu7urhm/ZNRSykX/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243614; c=relaxed/simple;
	bh=POqv0h1t39Wybcz3NApqo2vEL4LbOvoTJUL75VTqPzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkRZLRrxRMbf8pBUB57CTlU0UdlWP4ye6YODUbu1XpwkIqopzOB+B4YwbksL/w2nwTTkmBVyMr45KWjHWxda3ug0AMF5bXeHJT/oOzujldLCtM2J2KV77uv7ZUPNRh1Yyt2e9xtBkIX94H6QfvyB02F4P2kmMrSIrd7IC3uLjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1278691a12.1;
        Thu, 29 Feb 2024 13:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709243612; x=1709848412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haUJa+5TdcS6m1vT9CvX3WylWRv8eifDwIPUXf2O2d4=;
        b=Do1ObdRP8QG+kkhUk6dkmaevdkREhUKq2DqKlKm+XYu1P8MxdNoF5GJWrgLYgaV5c/
         Et1rU50JVnU7WT/dz2gYTsp+NYXIqWnUOtlXWEu9pe1trWEM5Z5b6Mo6aAt9lB2yBz3z
         PaF7RnvOFUSWBo4PEIE/5Uxh4mzkorqTDFZpfcivto/y3IZxNsoewhZ5FOXVhv1fWx7b
         tTnP1exq6BAmEzNjVP1HQ0jOe6axJIBM4OK8rVIDeo1aGVXlX2v6OXULAgmp9NjMMldz
         wRMJV+R8bU3XTrgfrP/ZNINbxcrxkr3yFunDM4WTIX0QkZeYssc7tRFPYIU0GBuseb8Z
         Ss1A==
X-Forwarded-Encrypted: i=1; AJvYcCXhGNq8JE5E4wjdLrmyLleWnpGNeVLF0XWB5SJ5QWQfADvVnJFced4I9DaVZTw2zVJTLuI+FsG/eUdvMWnh32Z58TPnysg/weSIBdrZJT5bHPWNIu/xTyHLZ9FFoUKlBKoevO8uw3ccXKfTfGq6ELpj4rDbZ/20bT2v2Rpmkn43wAyl7Q==
X-Gm-Message-State: AOJu0YxpSYA9Ml7qGYhnsc0VNyBRtqCc5ZHgcH/PC+b07Zs/wCqZ+vY5
	vJLMKMCL2vf78JlH2tPsPkzBJt02S7tDuwkQZI2kWZn5c8auVTqHgrt4sdjQsqQGlne4kTG1ASP
	cChquKwRFwl/kzW2AsM/yavUojuaWuzvZ
X-Google-Smtp-Source: AGHT+IFBSRvQ+r0EXa9q2GBrMWhn0LzDwgGCDrMn25SAlWV3W/po7XZ7pjMbxhZRxGVyf5m/1cmFj6Vee7TppEkoLO4=
X-Received: by 2002:a17:902:a70c:b0:1dc:a844:a38b with SMTP id
 w12-20020a170902a70c00b001dca844a38bmr3162774plq.67.1709243612496; Thu, 29
 Feb 2024 13:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228053335.312776-1-namhyung@kernel.org> <Zd8lkcb5irCOY4-m@x1>
 <CAM9d7cicRtxCvMWu4pk6kdZAqT2pt3erpzL4_Jdt1pKLLYoFgQ@mail.gmail.com>
 <Zd-UmcqV0mbrKnd0@x1> <CAM9d7cg-M_8V0O2rv_gx+1u=axpRmCp4XcBkkqsiGmDgeU2xZw@mail.gmail.com>
 <ZeC9ki-4SGa-iU0C@x1>
In-Reply-To: <ZeC9ki-4SGa-iU0C@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 29 Feb 2024 13:53:21 -0800
Message-ID: <CAM9d7cgb+-treat5Mf_hitEjLDJH8B-RFZYoDxzaGXu0VbNr8A@mail.gmail.com>
Subject: Re: [PATCH v2] perf lock contention: Account contending locks too
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 9:23=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Feb 28, 2024 at 01:19:12PM -0800, Namhyung Kim wrote:
> > On Wed, Feb 28, 2024 at 12:16=E2=80=AFPM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > On Wed, Feb 28, 2024 at 12:01:55PM -0800, Namhyung Kim wrote:
> > > > On Wed, Feb 28, 2024 at 4:22=E2=80=AFAM Arnaldo Carvalho de Melo <a=
cme@kernel.org> wrote:
> > > > > On Tue, Feb 27, 2024 at 09:33:35PM -0800, Namhyung Kim wrote:
> > > > > > Currently it accounts the contention using delta between timest=
amps in
> > > > > > lock:contention_begin and lock:contention_end tracepoints.  But=
 it means
> > > > > > the lock should see the both events during the monitoring perio=
d.
>
> > > > > > Actually there are 4 cases that happen with the monitoring:
>
> > > > > >                 monitoring period
> > > > > >             /                       \
> > > > > >             |                       |
> > > > > >  1:  B------+-----------------------+--------E
> > > > > >  2:    B----+-------------E         |
> > > > > >  3:         |           B-----------+----E
> > > > > >  4:         |     B-------------E   |
> > > > > >             |                       |
> > > > > >             t0                      t1
>
> > > > > > where B and E mean contention BEGIN and END, respectively.  So =
it only
> > > > > > accounts the case 4 for now.  It seems there's no way to handle=
 the case
> > > > > > 1.  The case 2 might be handled if it saved the timestamp (t0),=
 but it
> > > > > > lacks the information from the B notably the flags which shows =
the lock
> > > > > > types.  Also it could be a nested lock which it currently ignor=
es.  So
> > > > > > I think we should ignore the case 2.
>
> > > > > Perhaps have a separate output listing locks that were found to b=
e with
> > > > > at least tE - t0 time, with perhaps a backtrace at that END time?
>
> > > > Do you mean long contentions in case 3?  I'm not sure what do
> > > > you mean by tE, but they started after t0 so cannot be greater
>
> > > case 2
>
> > >                 monitoring period
> > >             /                       \
> > >             |                       |
> > >  2:    B----+-------------E         |
> > >             |             |         |
> > >             t0            tE        t1
> > >
> > > We get a notification for event E, right? We don=C2=B4t have one for =
B,
> > > because it happened before we were monitoring.
> >
> > Ah, ok.  But there should be too many events in case 2 and
> > I don't think users want to see them all.  And they don't have
>
> So maybe a summary, something like:
>
>   N locks that were locked before this session started have been
>   released, no further info besides this histogram of in-session
>   durations:
>
>     0-N units of time: ++
>   N+1-M units of time: ++++
>     ...

Summary could work.  But I'm not sure about the histogram
since different locks would have different behavior - spinlock
vs. mutex/semaphore.  Maybe it's more meaningful when
you have filters or separate histograms for each lock.


>
> > flags.  But maybe we can update the flag when it sees exactly
> > the same callstack later.
>
>   The callstack, if going all the way to userspace may have the workload
> targeted in the command line ( some pid, tid, CPU, etc) and thus would
> point for things the user probably is interested than some other lock
> that may affect it but indirectly.

It doesn't collect user callstacks yet since it requires recording memory
address space information of every process - basically FORK and MMAP.
Maybe we can use callstacks with build-ID and offsets but it also requires
mapping from build-ID to binary somewhere.

Anyway, it's good to add more features to it.  Let me process this
patch first and think about more later. :)

Thanks,
Namhyung

