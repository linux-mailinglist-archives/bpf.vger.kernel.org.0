Return-Path: <bpf+bounces-22018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E90855097
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B11F276AA
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACBF126F2D;
	Wed, 14 Feb 2024 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMn6m3Cm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE74126F2F
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932576; cv=none; b=W+2DrBFA1izIs2iNwp29B257YoJPMNKAvy8Tv1XbYjbiVpnvDSO4gkNMU+uqM3huqbPF0IjAw9Frjn8aQwgCpN5n1ZZcaQ537kFfgj2osRgjvQ9RxhxkTWiw8EY9bqcRYPmOIIKw2Vwj7RRgkf5woIODPOgqRctw0EyU+gT9kak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932576; c=relaxed/simple;
	bh=A3jNuo3+aMfBd/a46lrJjMimq4KWfJzitCEn+KfU/AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUg2sEhBqQWHHgYulMEwGlK1ozOZ5TZVHHZ1bjUU4huD9RZ1S2DZMFBo8VBHBFJmYp4+s+/kor2TsVxv7tkFAycM3yZZVrO0rAca7MeJs6fLuKQxxp+54qlGHqcmQ2q5ZIfmg/Nwng0O1gVS/mzzW+6HAudlHz7qTq7A0RAcBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMn6m3Cm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db35934648so287545ad.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707932574; x=1708537374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytC4jjoAE7J3d4w3/cSQmAwPp9HtPh6tMpBf/7S8E5A=;
        b=RMn6m3CmAuSCPkd5EZGiLiTuzTxcBqUfCEmXcixPlzWvOmDhEuXsWWuk8NIMWyWH2q
         Y6lHLHA5PYs8l+gi5WNqFsTpZBi3eXw6WNcM/Rs39Xt8uzvcuje8emk0KmuxeI0at4VQ
         VwmdpGYHHwuSL+5gbtA6OhtFRbUWxEPzXM5EMvps5SOv4KAjjsJK5YY/CccUCT0swCTb
         BWj1r3Pgmm6SDBOIw2mjxQG1ewe4D2idJT1etVEblpLHDBdNUWHNsiu8/xxAY9LbD+5q
         tcPxvEijWGRPfyqbi36fQ4lxGq6XNg7gzYprNKAMdlOKzObSvUJ6NBPYnN2GEjjG+It2
         pIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932574; x=1708537374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytC4jjoAE7J3d4w3/cSQmAwPp9HtPh6tMpBf/7S8E5A=;
        b=U3sFWpl8wT/ZcDlunckHE670hEtaYI3E0XM0vaK8SEbd9wW5mSOqSFnXyQPZbxgYZU
         97t7mpBbsBzYyiKL/31CLrputuK/aDE/JuFrfSQVziRxSW0KY2MEnPVH6kFzbm4uiye7
         Mire3qJlIH5Kbu1nY8Pt4kGcYXJL8ZAG6d/l6Tn0t9yOt+sJRtBDloGvQ1IQqUuGPgN6
         vpM9KnHXVvHSj/xLxKmkXpzy3R2ux7aMxAiRS4vGrTAwv3YdCP3gTNioBuoPBklCZUHo
         y62qPhRhR+3GiCULg3yUjCi1n0ULsIH41EZgKDRcsL5HzgUCfDARr1ZOMHIPw5OU/X0o
         V2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmrlDTFFZx9Lu8GgVYFR5Rhe4BKI8BihW99tOU+Aw22uNXdI03veqrv/zr8VEajUgC5rRS08Ddn2ondCPrSypk2SsP
X-Gm-Message-State: AOJu0YwUL+Af2pWtoLKeWZV8NcVqsTnnE8YFwE+qWXNNbo3elXdnlr3h
	tPjMtT8/BlE9iyGl/JNVyfh3HEdHXyh/5GKOAS5QYQNN4NJXnRwCTEBiZ/Jh3k2oCIZ822ABjCx
	0g/ZKntTSOmFSYj/KZFS6LbSbvg3OVyoR304z
X-Google-Smtp-Source: AGHT+IGOEogg4Yb9tI+FXwQw1QPr+hnIsaI5VmnKkS2h0TY3p0ODsid8cM97Zc2mxcKRzzKTDXH/NW5voAiEg5ceDGA=
X-Received: by 2002:a17:902:cac2:b0:1db:55d2:5e26 with SMTP id
 y2-20020a170902cac200b001db55d25e26mr263767pld.9.1707932573479; Wed, 14 Feb
 2024 09:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-2-irogers@google.com>
 <Zcz3UO5Jq4zAqSfx@x1>
In-Reply-To: <Zcz3UO5Jq4zAqSfx@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 09:42:38 -0800
Message-ID: <CAP-5=fXeLX8i8sK8EVquDqnV31rtum_K4TLtw5nG=nfL9-PKvQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf report: Sort child tasks by tid
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:24=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Feb 13, 2024 at 10:37:03PM -0800, Ian Rogers wrote:
> > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > threads") made the iteration of thread tids unordered. The perf report
> > --tasks output now shows child threads in an order determined by the
> > hashing. For example, in this snippet tid 3 appears after tid 256 even
> > though they have the same ppid 2:
> >
> > ```
> > $ perf report --tasks
> > %      pid      tid     ppid  comm
> >          0        0       -1 |swapper
> >          2        2        0 | kthreadd
> >        256      256        2 |  kworker/12:1H-k
> >     693761   693761        2 |  kworker/10:1-mm
> >    1301762  1301762        2 |  kworker/1:1-mm_
> >    1302530  1302530        2 |  kworker/u32:0-k
> >          3        3        2 |  rcu_gp
> > ...
> > ```
> >
> > The output is easier to read if threads appear numerically
> > increasing. To allow for this, read all threads into a list then sort
> > with a comparator that orders by the child task's of the first common
> > parent. The list creation and deletion are created as utilities on
> > machine.  The indentation is possible by counting the number of
> > parents a child has.
> >
> > With this change the output for the same data file is now like:
> > ```
> > $ perf report --tasks
> > %      pid      tid     ppid  comm
> >          0        0       -1 |swapper
> >          1        1        0 | systemd
> >        823      823        1 |  systemd-journal
> >        853      853        1 |  systemd-udevd
> >       3230     3230        1 |  systemd-timesyn
> >       3236     3236        1 |  auditd
> >       3239     3239     3236 |   audisp-syslog
> >       3321     3321        1 |  accounts-daemon
>
>
> Since we're adding extra code for sorting wouldn't be more convenient to
> have this done in an graphically hierarchical output?
>
> But maybe to make this honour asking for a CSV output the above is
> enough? Or can we have both, i.e. for people just doing --tasks, the
> hirarchical way, for CSV, then like above, with the comma separator.
>
> But then perf stat has -x to ask for CSV that is used by the more
> obscure --exclude-other option :-\
>
> Maybe we need a --csv that is consistent accross all tools.

I've no objection to a graphical/CSV output, I was in this code as I
was restructuring it for memory savings. Fixing the output ordering
was a side-effect, the "graphical" sorting/indentation is mentioned as
it is carrying forward a behavior from the previous code but done in a
somewhat different way. Let's have other output things as follow up
work.

Thanks,
Ian

> - Arnaldo

