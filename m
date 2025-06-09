Return-Path: <bpf+bounces-60081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00183AD25A2
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8640116F648
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D90194C96;
	Mon,  9 Jun 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOp6gVni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944C1B425C;
	Mon,  9 Jun 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493859; cv=none; b=G/UB1lVUOllJSvErCjKuIKT7v7PRKyyH6Q09mtNmzTjJ6BOJJ7EM9zEmqvYSpnVgrOEmOpKubXsN1m2H593Yz89k6dKsQekKr0W/NPRHm2lYbvF/pr66o2Aq17Cg/wdPeDB/MHAPxJUxxfi/bVj3mRuQkxKWvZfndN6BBnkzmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493859; c=relaxed/simple;
	bh=7tBlI7YVFVyuUKinZrmWKCzdcD887YRbuUwOHfvc4Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unpsZDJJ/YxCJ4gqqGsV8LtNF70v2iMdaKIAxzv5hgSrgATPD2XO44NbNTSkgglDQLrDhs4QIFPiwrwLHgX78NgouFv9ZmGOGn6lzDADLM2FxIda9JOiaC3tFlgyH6BiZPtWouz5DcFIeVjnpQoA87IWLm6QHqBpUXcUxt34YCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOp6gVni; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e75668006b9so4403981276.3;
        Mon, 09 Jun 2025 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749493857; x=1750098657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGYZ3sF+/+CwXAOGiCqNoQMLv8bi21odrNnq7b87B2E=;
        b=eOp6gVnicQljzhpgE9E8kvioUNrmNB4nSb1zczExuIYGfaX9aClx/a9uXIw+4/XVOS
         jQw1la7GCz3YoQduZmYaWOcMRr6nqPTrcJZzTrzsaajYztQB8gHF/mPqUAiOhvtS8cve
         KovffAe/QsUOsQoZgB7uMRtgHNI/WqHOsBLIy4X/n88ASAjDO65Rsp6OigROjnO+pQ73
         xTUcccTZh6meluPk6Yzu6X4zpnP5wZiHtv5eUD44bBch6XF1wXQPXXS3u7AbqqlOy5FI
         FkiRs2dH5fqw0RJRNaNyrCwlVOTXzGmmd0BUgAnLnp0DfJUJipo/FX7bGTXBpHPI9obc
         sK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749493857; x=1750098657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGYZ3sF+/+CwXAOGiCqNoQMLv8bi21odrNnq7b87B2E=;
        b=w4ZM3vOZLv/ACk5f+UTutzT+prfrFrCApmSYZaJhnPe11OFJXNIcipUfJxSEbhBm39
         Ts9UF5HzfisXZLPVvNWgAec40BjWIqut4YjqZD4eOuE9qkkN3cc3rzdJxHhmWFNW67aR
         y6KA5uJ5YBq9PjjvItRrIY6XER9kXnp+0ZDFcTwQFXhUB483CRJnoqviUUsAYK/SQ/Pl
         BvyqSGSJ+6Wd6j2p6JDBvhh+dLdStvbfzOatJ/0DOU2zpEFoJcxaD2ucixDfB7Hp2Bl9
         SXyukCzN8RNxUDBGxWewXZjByGhp6/IiYyzGO3BDX1Q9eFOdFJQXKW3aFlhHhCbzK44p
         aAJw==
X-Forwarded-Encrypted: i=1; AJvYcCV6WYaRZ3trnemHjLswtCms0SQu6lOrpyyMJmod9G5JSnCdscHh+yapmqKRxZEvJVupG3HPhJoqVaHTBwWRYPlWFw==@vger.kernel.org, AJvYcCVKxlBIKx3F+1cy8vne+mflOCk4nwCBtZBNdRiAY4Y0118B55pI3Q7pBGB2Ml0wTIotAcAdedCtOUrrRTzL@vger.kernel.org, AJvYcCVSdj486DHY00KEPOtMk3Z5tnnG0IFhY1mMHGnlaOmv4SSV6Rxc+iacxmR38D8DnVZypqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7ef9uts3Gy1S+e//B4kdfr3At9S3mlqG9A3cvMxngubvfJW+
	zAQKIjF+y+L6zLsWJWiHBagVhZNvvyYl8SdclDF6B9cppWuBdgxrsoaY204bng8hVnfzdp/yGqV
	oRD0teQyU67/cmLBWMTTCwPL318gjnKQ=
X-Gm-Gg: ASbGnctSpvvCHqZX2HKM3rY3N70+tFJxh23yAwMAdGPxjZStgUPW3hZHyUZRf2FGRb8
	Rq5mC/5SkImatyfvZMgjo6bvv5tsqayNtcKp/lFna3s0jUsTpfC5KS0BpN44qkzeLQO6+td40ab
	4jRd7nzLJiQQLVGeQHBShsa5Q8vegTJug=
X-Google-Smtp-Source: AGHT+IHZNPBaLqoSkmJRi+qhvMGn4J2k5pOMYMdn5ZAzJX0wuEZmdbS6DKIMGfaHBlCa8AoBKH6kts41DFLPm/ggWUU=
X-Received: by 2002:a05:6902:2607:b0:e7f:7d27:7e63 with SMTP id
 3f1490d57ef6-e81a209d9c9mr19664871276.5.1749493856740; Mon, 09 Jun 2025
 11:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529065537.529937-1-howardchu95@gmail.com>
 <aDpBTLoeOJ3NAw_-@google.com> <CAH0uvojGoLX6mpK9wA1cw-EO-y_fUmdndAU8eZ1pa70Lc_rvvw@mail.gmail.com>
 <20250602181743.1c3dabea@gandalf.local.home> <aEAfHYLEyc7xGy7E@krava> <CAADnVQJBG=nHRCJBcxXuEjpNp8iy1CD+Hg=g571uOTr61b8Peg@mail.gmail.com>
In-Reply-To: <CAADnVQJBG=nHRCJBcxXuEjpNp8iy1CD+Hg=g571uOTr61b8Peg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 9 Jun 2025 11:30:45 -0700
X-Gm-Features: AX0GCFsFx22FRhR0Z-TdFdhHqdZnRO9-4l1VfHBKRMDjx4WpDRKiuR7IANj9fEg
Message-ID: <CAH0uvohAoi=h1=ANpUwYM3RYoiwYLyUdNqrA354qut2ba4RkTg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Fri, Jun 6, 2025 at 11:27=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 4, 2025 at 3:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Mon, Jun 02, 2025 at 06:17:43PM -0400, Steven Rostedt wrote:
> > > On Fri, 30 May 2025 17:00:38 -0700
> > > Howard Chu <howardchu95@gmail.com> wrote:
> > >
> > > > Hello Namhyung,
> > > >
> > > > On Fri, May 30, 2025 at 4:37=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > (Adding tracing folks)
> > > >
> > > > (That's so convenient wow)
> > >
> > > Shouldn't the BPF folks be more relevant. I don't see any of the trac=
ing
> > > code involved here.
> > >
> > > >
> > > > >
> > > > > On Wed, May 28, 2025 at 11:55:36PM -0700, Howard Chu wrote:
> > > > > > perf trace utilizes the tracepoint utility, the only filter in =
perf
> > > > > > trace is a filter on syscall type. For example, if perf traces =
only
> > > > > > openat, then it filters all the other syscalls, such as readlin=
kat,
> > > > > > readv, etc.
> > > > > >
> > > > > > This filtering is flawed. Consider this case: two perf trace
> > > > > > instances are running at the same time, trace instance A tracin=
g
> > > > > > readlinkat, trace instance B tracing openat. When an openat sys=
call
> > > > > > enters, it triggers both BPF programs (sys_enter) in both perf =
trace
> > > > > > instances, these kernel functions will be executed:
> > > > > >
> > > > > > perf_syscall_enter
> > > > > >   perf_call_bpf_enter
> > > > > >     trace_call_bpf
> > >
> > > This is in bpf_trace.c (BPF related, not tracing related).
> > >
> > > -- Steve
> > >
> > >
> > > > > >       bpf_prog_run_array
> > > > > >
> > > > > > In bpf_prog_run_array:
> > > > > > ~~~
> > > > > > while ((prog =3D READ_ONCE(item->prog))) {
> > > > > >       run_ctx.bpf_cookie =3D item->bpf_cookie;
> > > > > >       ret &=3D run_prog(prog, ctx);
> > > > > >       item++;
> > > > > > }
> > > > > > ~~~
> > > > > >
> > > > > > I'm not a BPF expert, but by tinkering I found that if one of t=
he BPF
> > > > > > programs returns 0, there will be no tracepoint sample. That is=
,
> > > > > >
> > > > > > (Is there a sample?) =3D ProgRetA & ProgRetB & ProgRetC
> > > > > >
> > > > > > Where ProgRetA is the return value of one of the BPF programs i=
n the BPF
> > > > > > program array.
> > > > > >
> > > > > > Go back to the case, when two perf trace instances are tracing =
two
> > > > > > different syscalls, again, A is tracing readlinkat, B is tracin=
g openat,
> > > > > > when an openat syscall enters, it triggers the sys_enter progra=
m in
> > > > > > instance A, call it ProgA, and the sys_enter program in instanc=
e B,
> > > > > > ProgB, now ProgA will return 0 because ProgA cares about readli=
nkat only,
> > > > > > even though ProgB returns 1; (Is there a sample?) =3D ProgRetA =
(0) &
> > > > > > ProgRetB (1) =3D 0. So there won't be a tracepoint sample in B'=
s output,
> > > > > > when there really should be one.
> > > > >
> > > > > Sounds like a bug.  I think it should run bpf programs attached t=
o the
> > > > > current perf_event only.  Isn't it the case for tracepoint + perf=
 + bpf?
> > > >
> > > > I really can't answer that question.
> >
> > bpf programs for tracepoint are executed before the perf event specific
> > check/trigger in perf_trace_run_bpf_submit
> >
> > bpf programs array is part of struct trace_event_call so it's global pe=
r
> > tracepoint, not per perf event
>
> right.
> looks like perf is attaching two different progs to the same sys_enter
> tracepoint and one of them returns 0.
> That's expected behavior.
> The rule is all-yes-is-yes, any-no-is-no.
> We apply this logic to majority (if not all) bpf prog return values.
>
> > IIRC perf trace needs the perf event sample and the bpf program is ther=
e
> > to do the filter and some other related stuff?
> >
> > if that's the case I wonder we could switch bpf_prog_run_array logic
> > to be permissive like below, and perhaps make that as tracepoint specif=
ic
> > change, because bpf_prog_run_array is used in other place
>
> No. That might break somebody and we don't want to deviate from the rule.

Makes sense. Thanks.

Thanks,
Howard

