Return-Path: <bpf+bounces-42663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623849A7025
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 18:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE5E1F221AC
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE31E9089;
	Mon, 21 Oct 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na8G+TZO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A219939E;
	Mon, 21 Oct 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529625; cv=none; b=sPMGdEVbkcnIy1WiYJ8G0MAYMetkMOLxpcGxjBl0NqATmyhxpIhIDt0fneIzG0iVqIycMTqk6J68XsfhIxiwXzBeVzrYJ+3W7XucF4mkPxcRhgXCCC9fWHnQZ5e7HM8YvThzT1CncHfF1444PRCUyi01hdHytd5KBqPyURQxTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529625; c=relaxed/simple;
	bh=EsXxXxRJGbVJjy7LzZen8w+LBc3iNCB/jR5qIBgfuDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIBWNTOepqolDbIs1vdgu7qmmez90iGRgFdAq8mFaqGXFEcD92WWa61LFj+eJXarLeRm1aJ6oBn3FTJQVW3ZEh5u8SVmt3RW/qqMjc5szipZrMpeoTRgXQpuH0GXzRkR20opfsh0p6mIxGMHg+FIGOLDKIfVJsq/XP97ArUAQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na8G+TZO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea7d509e61so2008264a12.1;
        Mon, 21 Oct 2024 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729529623; x=1730134423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL3YgHyMFpNOAixJJrESMWkfYaHFaFLkhmt9ZVqRAnk=;
        b=na8G+TZOXfZq0eR5MSo/2BDUNylW99/35au4mVstt21Fgb9ehslyzkB9SPvcMpJ4QP
         UtxjMXfQbp5vP4xPt2ewm3hC91I0PRpv+QwUSNnT/1oZNw+u1tbffV06PqYi/X5MfHq2
         J2F1CI+DHY7tU7otGW+I86KeEpvHm+RzASwvdsTsmnQNL3aPRZ45iXFFyUTlHLgmompi
         gqOTm93HXJQt7gxP06SdNnRfAS7laRn16gDiZ68Pn0wPo303yLvS44kjh/+kyRdM7+UX
         Z2nn8CzyBCiJ4gZjarF1V+/a9HqjkjuUGWZWpW0nZ28X4Bl7VbxSscmvIZV9gE1sqAci
         3y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729529623; x=1730134423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL3YgHyMFpNOAixJJrESMWkfYaHFaFLkhmt9ZVqRAnk=;
        b=pX+F3DOfzjjcPaylYPuySrhOB6YD65n9vBzL0V32dndA1PYBixTtBsEISFt5JVV1eg
         vjvtB4G9F+wXwqTw0TwbBcZuQ+4uo0BDOxduZEhNXRcWHqCynWbFeTih8jpXdCxEI0qH
         aN7RcFEVL/KN9DE6VwHISly0qzQE8uyZq82EZ+vLjFUbIIx4ZB0mhWBjM+yJ/D9J4JBc
         XpTaEzuPHHYLPRIMYfOpZGDaAeBY3WFjRwRv6V1oOkYQXcnGiT1D9gQ3IGDUyOFBCh3X
         QA+zVapm8OMSbQ48wJ6YmdaUXL6gNsHtJUicaZsHPiJjDGtBV4ZpFZCof+sUTs9Y4+9z
         qZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP0SPR6qxFFBTvT/t2+G0mlAOTR8tNv6ZgPXfNWMgS+iUxPVCFtSzlBT3dvZwMWSy4peiPQXvzySF7URRO@vger.kernel.org, AJvYcCWBOBMOPTm6hDzwQ7QYoycM0iFhOn/jnq+ysQ8lUSksVMrXK3NB9DXPnbK4mI98Wj+HqlQ=@vger.kernel.org, AJvYcCWHgeqE7JRJIxzpF0Z8v/PMZwyNpR5lBa3V8wzMWuRyyrr3PtEo8BwhipF/8E4yio3CIVmrNzX0wWQTBTtnwRu4wnmt@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFkOyGnRd/l/ged9JqydDWVsYquHEKD3/omijKEdtJfIoAuOL
	Ju3GnUBX7uasT6e8MAmpPkj1IGoI1YkMSNOW7lN91TRuVxVf1qnh/Z+YrhCJR9T/C/OwUpa3crL
	3oS+SO0pESfN775xGbhNESbrj3amfAA==
X-Google-Smtp-Source: AGHT+IFLhyt/FNbKxokMI7+5ri0OxjGVa0fqnTmdI1cFqhmTSWuQybenV2Z8i205GSE3E7Vy10ElfcHJ4DGhQSfpZVo=
X-Received: by 2002:a05:6a20:2d27:b0:1d9:1af2:9697 with SMTP id
 adf61e73a8af0-1d96b89a174mr608264637.47.1729529622813; Mon, 21 Oct 2024
 09:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008002556.2332835-1-andrii@kernel.org> <20241008002556.2332835-3-andrii@kernel.org>
 <20241018101647.GA36494@noisy.programming.kicks-ass.net> <CAEf4BzZaZGE7Kb+AZkN0eTH+0ny-_0WUxKT7ydDzAfEwP8cKVg@mail.gmail.com>
 <20241021104815.GC6791@noisy.programming.kicks-ass.net>
In-Reply-To: <20241021104815.GC6791@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 09:53:30 -0700
Message-ID: <CAEf4BzbW7twYKPuU+ERy0z6Mfre8n_NswaR9Jxz03z-M312wKw@mail.gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:48=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Oct 18, 2024 at 11:22:09AM -0700, Andrii Nakryiko wrote:
>
> > > So... after a few readings I think I'm mostly okay with this. But I g=
ot
> > > annoyed by the whole HPROBE_STABLE with uprobe=3DNULL weirdness. Also=
,
> > > that data_race() usage is weird, what is that about?
> >
> > People keep saying that evil KCSAN will come after me if I don't add
> > data_race() for values that can change under me, so I add it to make
> > it explicit that it's fine. But I can of course just drop data_race(),
> > as it has no bearing on correctness.
>
> AFAICT this was READ_ONCE() vs xchg(), and that should work. Otherwise I
> have to yell at KCSAN people again :-)
>

sounds good, READ_ONCE() it is :)

> > > And then there's the case where we end up doing:
> > >
> > >   try_get_uprobe()
> > >   put_uprobe()
> > >   try_get_uprobe()
> > >
> > > in the dup path. Yes, it's unlikely, but gah.
> > >
> > >
> > > So how about something like this?
> >
> > Yep, it makes sense to start with HPROBE_GONE if it's already NULL, no
> > problem. I'll roll those changes in.
> >
> > I'm fine with the `bool get` flag as well. Will incorporate all that
> > into the next revision, thanks!
> >
> > The only problem I can see is in the assumption that `srcu_idx < 0` is
> > never going to be returned by srcu_read_lock(). Paul says that it can
> > only be 0 or 1, but it's not codified as part of a contract.
>
> Yeah, [0,1] is the current range. Fundamentally that thing is an array
> index, so negative values are out and generally safe to use as 'error'
> codes. Paul can't we simply document that the SRCU cookie is always a
> positive integer (or zero) and the negative space shall not be used?
>
> > So until we change that, probably safer to pass an extra bool
> > specifying whether srcu_idx is valid or not, is that OK?
>
> I think Changeing the SRCU documentation to provide us this guarantee
> should be an achievable goal.

agreed, I'll let Paul handle that, but will assume srcu_idx < 0 can't
legally happen

>
> > (and I assume you want me to drop verbose comments for various states, =
right?)
>
> I axed the comments because I made them invalid and didn't care enough
> to fix them up. If you like them feel free to amend them to reflect the
> new state of things.

got it, I'll update where necessary

