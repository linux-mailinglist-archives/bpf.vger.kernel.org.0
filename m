Return-Path: <bpf+bounces-26094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1558889ABE7
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055091C20C35
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4803BBF3;
	Sat,  6 Apr 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5wYRLfR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624839FC5;
	Sat,  6 Apr 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419612; cv=none; b=hVVRRA42Wp73PiFwg6GRStOzdIyNlHW0gH3DPqcyqZctqrscQYfll3+khIpYANTrk0tLn8Fj7dH0T2ycKqyOKGkUmr545FXWMTm43j3jfoVXT0tD1+to5iWdiUsGXhR4F40KI4P270xwD4upfMoUMASfpQXNknHxYgu6Xvw4G9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419612; c=relaxed/simple;
	bh=xm7FJoKKCux4d/oHVvVrKqKlNsZude49WwII/qXfp6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8yqMG+2tv68S5Jg5RWsg/5hSBTP4kq7JMEijxOYTQfcIGqdkfO+vSxImH9hFr37yTHVaow4MnSc4q5owSLN4xkWsEZssnmPybagYaRjuJZQVcorUl5DCLlQ3k3IRYRgzsYqnYBCZT4UvHFMY7Em++WigDX2KJyfoeS7Rrigtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5wYRLfR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2a7b5ef7bso25668705ad.1;
        Sat, 06 Apr 2024 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712419611; x=1713024411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngJECPtFU3bvYIOQYpeXZI9aknWsyMDwcoCnSJe8oU8=;
        b=b5wYRLfRgE+vhgbL78CvLaspsZKPjERKx1S451gMnAoY9qiEtQ3/Pk23bfFWj5wSVc
         2zds2yAo8V6+AspGLYZ6gt1Vy71A/TRihJUkbL3OGYRHsV0x2sW6XVs7+Vg1cVZ2ViDV
         sBghfmg1lWfaUg+vMeZSZ/oQzq9StJcIb190VfHyfz7UxlgFPJIpmPfFulRlpV5SVo0g
         9PkX3sThwCKzrxkokCyuwsJ1HomHoRf7V4l8QjnI8TOLUm7TDU2vsmxfj9CWRr5w5w1a
         IF9qsdam4ZArsgGyL7f5F09uD/EHieCpV2jVu3ccTnS5lhmjXT2ppnGTMM3j/iEF/sOV
         W4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712419611; x=1713024411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngJECPtFU3bvYIOQYpeXZI9aknWsyMDwcoCnSJe8oU8=;
        b=keZgHjlT+go2qTGz+RRWtGld+fjvJ3eWhiGkwMQ/tRSYZH5Z3kCDllJZcKR7SiW9/y
         XZSTXBjb9jySNd04wSKjTVPK1HmkfgHjcuwjOrO+uQVwLsg6pD2BWX82L7jHqBWW8u8G
         N5mmzh92ErB0BdyNdaYo3xoOc8/J2CjYDYX2Z9daNNv3Ujq7fxGC7X7WWA7aDvVQsqTz
         C5an8gYkZsR5UUl6/iF3q4YHYK/emu0IFPybhawxcyoQ5OQ2snqfDxHjljoCav/5rfXB
         rAO2j64z0ibqPIyVZUe/E8h2xo4NukJ4sPiW1ulBTvFeecl5dLw/6TFiGVxFkS6dD9Rb
         9cHA==
X-Forwarded-Encrypted: i=1; AJvYcCV5zC+XtceLc8p5T/TzhOneryffsuFSXlZ2sWkiUqfMUJuFlb8uZGNy+3c/CmndYDW4TEyMQb2qU8i01QInpCFLRNwqxfbY7tla4kJiitblO14Zjf5XG7jFVYcMZ0TWqJKcGguN1yCH
X-Gm-Message-State: AOJu0Yz2b3n2XR6HuN6qKQ+eMAqsi+EVgTgtrqQUedQjHdoNweA5mtHM
	HZe7oT4lySFqgUEps+XWf1EzgITwGf5LO7lFbzDwr4ME85Gy/1KhAPaFGRZhIcVEzLvuyRSZ5DJ
	cJmWJD9r+6KE5FLG9Lle3dLu2ySPq0uK7HEk=
X-Google-Smtp-Source: AGHT+IFT9wA4gM+Qyu9QX3E/HS5bJisp56n2GQmt6kYUBgOl6SreTa8iX9LHHrQYAqJJrZ6mMvySJFOEafLp6NRSct8=
X-Received: by 2002:a17:902:ec8f:b0:1e2:8aa4:f4fc with SMTP id
 x15-20020a170902ec8f00b001e28aa4f4fcmr6447761plg.56.1712419610682; Sat, 06
 Apr 2024 09:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322160323.2463329-1-andrii@kernel.org> <20240325113848.32a70948d1cdb0fa76225690@kernel.org>
 <20240325181338.39376089@gandalf.local.home> <CAEf4BzazyWqLRmruj6XPXMYSYrrFPRAJRizWGhKtTt9A8zWE3A@mail.gmail.com>
 <20240326150121.68e9db8a@gandalf.local.home> <20240401202552.470d845bd79c841b9158fb56@kernel.org>
 <20240401120918.67cc3191@gandalf.local.home> <20240402093839.7de89341138748f743ae896d@kernel.org>
 <CAEf4BzaGWEKnntoD2KLhVORGZ0ATq_TqhPBQnbbWQCeCM2EteA@mail.gmail.com>
 <20240401224733.7a9bcbb6@gandalf.local.home> <20240403094048.3a443fbeeed551f11c1970d8@kernel.org>
 <20240402205459.297c4206@gandalf.local.home> <CAEf4BzahMFsdN8QvW6XiUk+3MzvLUjudXO5=qfhKBYfDvEgy5w@mail.gmail.com>
 <CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aNDXQSHYia47pQ-w@mail.gmail.com> <20240406124105.5a31c488b00c36432cc81446@kernel.org>
In-Reply-To: <20240406124105.5a31c488b00c36432cc81446@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 6 Apr 2024 09:06:38 -0700
Message-ID: <CAEf4BzZWZkU3k902MmRByLDGhL8=K+hiME_y66PPf4h7csy+Uw@mail.gmail.com>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check optional
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, jolsa@kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:41=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 2 Apr 2024 22:21:00 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Tue, Apr 2, 2024 at 9:00=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Apr 2, 2024 at 5:52=E2=80=AFPM Steven Rostedt <rostedt@goodmi=
s.org> wrote:
> > > >
> > > > On Wed, 3 Apr 2024 09:40:48 +0900
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > >
> > > > > OK, for me, this last sentence is preferred for the help message.=
 That explains
> > > > > what this is for.
> > > > >
> > > > >         All callbacks that attach to the function tracing have so=
me sort
> > > > >         of protection against recursion. This option is only to v=
erify that
> > > > >=E3=80=80       ftrace (and other users of ftrace_test_recursion_t=
rylock()) are not
> > > > >         called outside of RCU, as if they are, it can cause a rac=
e.
> > > > >         But it also has a noticeable overhead when enabled.
> > >
> > > Sounds good to me, I can add this to the description of the Kconfig o=
ption.
> > >
> > > > >
> > > > > BTW, how much overhead does this introduce? and the race case a k=
ernel crash?
> > >
> > > I just checked our fleet-wide production data for the last 24 hours.
> > > Within the kprobe/kretprobe code path (ftrace_trampoline and
> > > everything called from it), rcu_is_watching (both calls, see below)
> > > cause 0.484% CPU cycles usage, which isn't nothing. So definitely we'=
d
> > > prefer to be able to avoid that in production use cases.
> > >
> >
> > I just ran synthetic microbenchmark testing multi-kretprobe
> > throughput. We get (in millions of BPF kretprobe-multi program
> > invocations per second):
> >   - 5.568M/s as baseline;
> >   - 5.679M/s with changes in this patch (+2% throughput improvement);
> >   - 5.808M/s with disabling rcu_is_watching in rethook_try_get()
> > (+2.3% more vs just one of rcu_is_watching, and +4.3% vs baseline).
> >
> > It's definitely noticeable.
>
> Thanks for checking the overhead! Hmm, it is considerable.
>
> > > > > or just messed up the ftrace buffer?
> > > >
> > > > There's a hypothetical race where it can cause a use after free.
>
> Hmm, so it might not lead a kernel crash but is better to enable with
> other debugging options.
>
> > > >
> > > > That is, after you shutdown ftrace, you need to call synchronize_rc=
u_tasks(),
> > > > which requires RCU to be watching. There's a theoretical case where=
 that
> > > > task calls the trampoline and misses the synchronization. Note, the=
se
> > > > locations are with preemption disabled, as rcu is always watching w=
hen
> > > > preemption is enabled. Thus it would be extremely fast where as the
> > > > synchronize_rcu_tasks() is rather slow.
> > > >
> > > > We also have synchronize_rcu_tasks_rude() which would actually keep=
 the
> > > > trace from happening, as it would schedule on each CPU forcing all =
CPUs to
> > > > have RCU watching.
> > > >
> > > > I have never heard of this race being hit. I guess it could happen =
on a VM
> > > > where a vCPU gets preempted at the right moment for a long time and=
 the
> > > > other CPUs synchronize.
> > > >
> > > > But like lockdep, where deadlocks can crash the kernel, we don't en=
able it
> > > > for production.
> > > >
> > > > The overhead is another function call within the function tracer. I=
 had
> > > > numbers before, but I guess I could run tests again and get new num=
bers.
> > > >
> > >
> > > I just noticed another rcu_is_watching() call, in rethook_try_get(),
> > > which seems to be a similar and complementary validation check to the
> > > one we are putting under CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING optio=
n
> > > in this patch. It feels like both of them should be controlled by the
> > > same settings. WDYT? Can I add CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
> > > guard around rcu_is_watching() check in rethook_try_get() as well?
>
> Hmmm, no, I think it should not change the rethook side because rethook
> can be used with kprobes without ftrace. If we can detect it is used from

It's a good thing that I split that into a separate patch, then.
Hopefully the first patch looks good and you can apply it as is.

> the ftrace, we can skip it. (From this reason, I would like to remove
> return probe from kprobes...)

I'm on PTO for the next two weeks and I can take a look at more
properly guarding rcu_is_watching() in rethook_try_get() when I'm
back. Thanks.

>
> Thank you,
>
> > >
> > >
> > > > Thanks,
> > > >
> > > > -- Steve
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

