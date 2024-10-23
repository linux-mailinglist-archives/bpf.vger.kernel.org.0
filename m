Return-Path: <bpf+bounces-42959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF79AD6A8
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B263285A38
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23A21F9A98;
	Wed, 23 Oct 2024 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGz+cppl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC291EC01E;
	Wed, 23 Oct 2024 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718669; cv=none; b=KuOS/IC71adtEVkbvCxbu1VOhTmgTRDfsd4r9HE4MtBHyeTauXIqk9/KXgkBCD6u80F0WHBnlo7EdvMH6yqayANTGW7ki04wQLPWEJ7jmgP07IM0b5kecTJaBekfPqqbP3axvr5TlbfihtdBsonyyw9f1nAZoNIPFH5ZNSmNOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718669; c=relaxed/simple;
	bh=T8NCsed/jp/xJZ9a+48obUEJ8TTtyKuRsaNM43TWj2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUsxpsRZr1MaWJHT4/ZZCS3zSbid9c6/6fjvqxpmkxNgixxeiklDynCTXZTsoFAhAQDh8okQbLcElbEEmwRE61z+lhkFAzCq0AlcB2Fg5WXePc0wMtAmHOHFs83SRLc8VwWVUS5e7sQSFtms4YQ6OoHNF8MnI9npEiUX9zC3BTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGz+cppl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e67d12d04so195974b3a.1;
        Wed, 23 Oct 2024 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729718666; x=1730323466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpPrbKeJpe2aetvZMjmvWlceyNjjJZCCBYm0HhCXMd4=;
        b=TGz+cpplFdHTV8hJDYmU1sAnmhMP5LTgnCTCuIp1KvmoJfRFMAaNqJVhmef1ZDF54J
         HRQ9ppBNqTK2AVMdXmPHg0i9y5LUXXWKRPH9JyZPjNsvgPFJbs+C9jln9VYRlfTvEnOT
         RHVuinUm1x4J98S8OroAicGX+R8spKTT1ta4lFKyXJHza2dTfnd2HwLIgYRmzFc7kup6
         htyJHSigLFOyHmxn5cA2VmrvE52RbTyUr3Z+k5so86ko7qBXMk3iadO44uWxfOBvJ+1T
         zDjTTPPYiwHMiLLbGCGuPJyKolQzBiQGslDRFbMF7b+EXqRaujSwsafQRuPMdYDu4P97
         KFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718666; x=1730323466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpPrbKeJpe2aetvZMjmvWlceyNjjJZCCBYm0HhCXMd4=;
        b=LzQ9sRogL960xnCVNiN9K8gNPIwHU1+8Uwpy98LoFKTXOgJ0YqJJRDxEb6en3leSBf
         2GJ7veTm9wl3rSXpnRv1Ub/G49NvfswsrFyo6SSjTHT7f3tnit4d9UEevtNaHdiQZCoi
         1AoqFA0HNb8wozLfnCz0YNW6GI3HLkK5y13Oz3KnbjurDtQBlHXkad3tOFHiQjiNCblL
         EBXZd9AmlphfAQdj/afW+Ponpjm70T3ujQVuAroL9eVfzQky39ptThLLHq4+gp6sJvKg
         RDuzXC2Q7e88/Yre0nRGlDXuk7iXSOLIt4+LYl7hmQM5Vl+q5zMzpeTaX/rScsMjlbDi
         7omQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVq0cIFH3JafFeGvt1K81yj/LeiG5NrFUdnfdEsiXPNVQbxzu0o7RbTyl66XPWJ+QxfBY=@vger.kernel.org, AJvYcCUp8x+B0EOukgjEwcMOj5g/LSnZZFk7WdQXBtv5ycAxCo1rFG2exfdVX1JAkhJpmUv/LAVXH+1tt9zy5NZL@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWSbRx1vaDm3MbqCDA8k8gz64uOJv1b3q4cUmgWMnRzRwDBFA
	1awxngtlEJbaw6Kvd+EyaeCzpfi6gjw0VJx8GljURqYByM8+L22S4miem42YSGM6uK+1fFKWreF
	eaNTOma6JvIptXJrc7cBZvKXnEMa071qt
X-Google-Smtp-Source: AGHT+IGgO8NY1det3/b/0APgRY9RRTn1fKojySpkiELP7WOXfGTS7gCDC/eprM+Xtm/tBXw5tWc4s4XFeyFJrJPSo3Q=
X-Received: by 2002:a05:6a00:b48:b0:71e:67e7:1a4c with SMTP id
 d2e1a72fcca58-72030a41bc2mr5845860b3a.12.1729718666279; Wed, 23 Oct 2024
 14:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023000928.957077-1-namhyung@kernel.org> <20241023000928.957077-4-namhyung@kernel.org>
 <CAEf4BzaoWnUdO0OrmztT1NK62eVzYhFsUiD_E-hY5=oY3E-VeA@mail.gmail.com>
 <ZxlE2jEUzpt0WcFJ@google.com> <CAEf4BzaTGSK3ftjuN9sDA7KrBfWsjj7PcGYaJy55X9cHYQT9TQ@mail.gmail.com>
 <ZxldYfiWJQxu3MfN@google.com>
In-Reply-To: <ZxldYfiWJQxu3MfN@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 14:24:13 -0700
Message-ID: <CAEf4BzZgsvsqwJsLbPgmVrqPnwx4XPUOQgL10+eb=snTDrrRjw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf/core: Account dropped samples from BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Kyle Huey <me@kylehuey.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Oct 23, 2024 at 12:13:31PM -0700, Andrii Nakryiko wrote:
> > On Wed, Oct 23, 2024 at 11:47=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, Oct 23, 2024 at 09:12:52AM -0700, Andrii Nakryiko wrote:
> > > > On Tue, Oct 22, 2024 at 5:09=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Like in the software events, the BPF overflow handler can drop sa=
mples
> > > > > by returning 0.  Let's count the dropped samples here too.
> > > > >
> > > > > Acked-by: Kyle Huey <me@kylehuey.com>
> > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > > > Cc: Song Liu <song@kernel.org>
> > > > > Cc: bpf@vger.kernel.org
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  kernel/events/core.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > > index 5d24597180dec167..b41c17a0bc19f7c2 100644
> > > > > --- a/kernel/events/core.c
> > > > > +++ b/kernel/events/core.c
> > > > > @@ -9831,8 +9831,10 @@ static int __perf_event_overflow(struct pe=
rf_event *event,
> > > > >         ret =3D __perf_event_account_interrupt(event, throttle);
> > > > >
> > > > >         if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE=
_PERF_EVENT &&
> > > > > -           !bpf_overflow_handler(event, data, regs))
> > > > > +           !bpf_overflow_handler(event, data, regs)) {
> > > > > +               atomic64_inc(&event->dropped_samples);
> > > >
> > > > I don't see the full patch set (please cc relevant people and maili=
ng
> > > > list on each patch in the patch set), but do we really want to pay =
the
> > >
> > > Sorry, you can find the whole series here.
> > >
> > > https://lore.kernel.org/lkml/20241023000928.957077-1-namhyung@kernel.=
org
> > >
> > > I thought it's mostly for the perf part so I didn't CC bpf folks but
> > > I'll do in the next version.
> > >
> > >
> > > > price of atomic increment on what's the very typical situation of a
> > > > BPF program returning 0?
> > >
> > > Is it typical for BPF_PROG_TYPE_PERF_EVENT?  I guess TRACING programs
> > > usually return 0 but PERF_EVENT should care about the return values.
> > >
> >
> > Yeah, it's pretty much always `return 0;` for perf_event-based BPF
> > profilers. It's rather unusual to return non-zero, actually.
>
> Ok, then it may be local_t or plain unsigned long.  It should be
> updated on overflow only.  Read can be racy but I think it's ok to
> miss some numbers.  If someone really needs a precise count, they can
> read it after disabling the event IMHO.
>
> What do you think?
>

See [0] for unsynchronized increment absolutely killing the
performance due to cache line bouncing between CPUs. If the event is
high-frequency and can be triggered across multiple CPUs in short
succession, even an imprecise counter might be harmful.

In general, I'd say that if BPF attachment is involved, we probably
should avoid maintaining unnecessary statistics. Things like this
event->dropped_samples increment can be done very efficiently and
trivially from inside the BPF program, if at all necessary.

Having said that, if it's unlikely to have perf_event bouncing between
multiple CPUs, it's probably not that big of a deal.


  [0] https://lore.kernel.org/linux-trace-kernel/20240813203409.3985398-1-a=
ndrii@kernel.org/

> Thanks,
> Namhyung
>

