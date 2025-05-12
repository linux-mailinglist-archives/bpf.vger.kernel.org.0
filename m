Return-Path: <bpf+bounces-58028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E449EAB3D52
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA4A188EF80
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E624BBFB;
	Mon, 12 May 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC4BzF2A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880324678D;
	Mon, 12 May 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066654; cv=none; b=T/M0zt4hY0s3m4sOReotQOz5agS1T8tF9/ZwfAziEAkAs7z6W3KcSBJM87D2uZdlYoEZXsVjuo9+4KdyP/QT5AQGHVfoHDEbUub6gjFJPwhCCf6kvdrAx5TNpZkVvIg6TmGiRRyjUJUP0BlSooh9lZ+BRcrzNdtd9iRjQ8pG1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066654; c=relaxed/simple;
	bh=bgp4i9EUIQbKNiJUfwhdvJH5H7aeG1dF49FUZ6vXukQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwfqi0z33hzqYF3NBAmOeys8OIT5G08xjFq4TzWe7AiDD8WLDKcGtfan7QtO7j/CGNA9f+kBlulbob3xQDWZJY+egFMMdGZPJUQSDviHoYm/YaJhwFG3StpQdIJU1+mRK7FJpecMH9589/PFy6H8dt2F4dfdpiCIWoJ7k2ozUGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC4BzF2A; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30a8cfa713fso4438022a91.1;
        Mon, 12 May 2025 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747066652; x=1747671452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uvHjXCxcVfNXCFQY8QeQ7tL8pdwghSrCmXwREw/SuQ=;
        b=HC4BzF2ARz6EHSEkiG2HQFYYeCKsW1DsHe6G/daon0LXrqHvdghi7mWPOzRkezFcqo
         xZVwkC1jmjKLYuh1q0f2BQvu6LVSQkIo1NxqBG1yTJv20Jp/J3Q2Y7hTOrUJirFyXuum
         d3otWC7c+/S8Xzmva3f+BwwNmadQAUYs/dYTEX18IgECWMYyFwS1mhJ6WVKfoAr54z8k
         NSYERULa7HyhFrHPKcPdL7UGBmTahQnhN+MMdHzoa7D6kDhpXtBpX8P4W1zmNnlA2f2i
         L9tZQRP/O8ssz1m29O2FHyRdDazYfJbcUVqQmk6l6zYG7J1enFBs110R/9yhgJa/46fB
         RrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066652; x=1747671452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uvHjXCxcVfNXCFQY8QeQ7tL8pdwghSrCmXwREw/SuQ=;
        b=N1hCmSfS8qwSIA7lHgUCIZI6ITC/BHiOQf2FEvqfqVft/TPAo3pBaO0dWHfd3qnRGJ
         5HavAMjFuYlea09kG3khE3hAdUGlfiSct8dM6M0Fs89PnEMSppTwMLYMLMCUNM3KcS6B
         u7uetERYI+oIR0rmd6pKbr7EX/dGsm/iYpUnMPJ9Jpq+qnz2hHfSrrWBk1Vt5ctigrPb
         UwpDkrwtJNGNnBmELlz35URlXlGUET+LReR3GxMw6z3vO3eIskOs8ULn2QSbqr2+6lCa
         J7HfQ3OAwBo04aWK7I1P6Sp3aKsLnOzrD3pZYtpzQ4IkTYNX38ESvkkzOFhbpApQWhvk
         QAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1FerOGgeWipFJSTXFIuxQkAS0rd+FIGjYMrE1eLlRArd7lKhNRDSugv3ZWfrDEvjX2GA8WenbIpLtbP8sptReAdoV@vger.kernel.org, AJvYcCXzhghijdqjHIDNhZAFwLuEEPsp2FXW64et+I0VzZbj77EryzxZ+h5dm+LwVIIJK5xB96I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50V4I4FFBwic1sfbs8thgOhvtuoxxOmMKFRZ+5npJQXdhogVr
	zXWfh6tqrxbtyY5wUg6vopxTKdM/49fvrDm+CwwLr/jRP/W95fXi2NHmoh7eT57a888X2GEyWvW
	Z6ernKXZR8voD6OqmmJV2oneH3J0ZUG3W
X-Gm-Gg: ASbGncsgNO2OXPMSSgGWrYLWaHQ6Lu/yssgG1yNTZLpb6T7GNktwyPBwe6tTKZpzUXo
	FygYAjnScP7P1g7CXYx7GJXY/GyV0vDepL9iObR3eV2YDALFVg4HBb65O6JbQ9Cl9wPg+qAwOsx
	Cs0ezEmIJET3XjcOla2IBXSg0W2yIXcJ8lW6v10VKiZtXpj5aZHFxSVjvS0Ww=
X-Google-Smtp-Source: AGHT+IHeVbbq75QFEsdBwLdk0G775rWp2KMcd7S50ydlk0AYFnSK87YAytaVJ4OEH2EAwBERrs4xBteqdST6Ut18BBo=
X-Received: by 2002:a17:90b:1a89:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-30c3cff4192mr24639689a91.14.1747066652101; Mon, 12 May 2025
 09:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509164524.448387100@goodmis.org> <20250509165155.628873521@goodmis.org>
 <CAEf4Bzb7MCv87ZEPXvH7APk9yvmtCWvuUO5ShEaLvz_DLfNqpw@mail.gmail.com> <20250510094149.7e91736d@gandalf.local.home>
In-Reply-To: <20250510094149.7e91736d@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 May 2025 09:17:19 -0700
X-Gm-Features: AX0GCFvGFzGHwTHTkppy2G0wRc8r3BTb9Wt9Jz0r138tBIO0LakJqFig68Nag50
Message-ID: <CAEf4BzYrz8-aBW0q7wwMOyO3v0ByLuFBRLtBQhSe1fesXwrPWw@mail.gmail.com>
Subject: Re: [PATCH v8 12/18] unwind deferred: Use SRCU unwind_deferred_task_work()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 6:41=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 9 May 2025 14:49:37 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > @@ -133,13 +135,15 @@ static void unwind_deferred_task_work(struct ca=
llback_head *head)
> > >
> > >         timestamp =3D info->timestamp;
> > >
> > > -       guard(mutex)(&callback_mutex);
> > > -       list_for_each_entry(work, &callbacks, list) {
> > > +       idx =3D srcu_read_lock(&unwind_srcu);
> >
> > nit: you could have used guard(srcu)(&unwind_srcu) ?
>
> Then it would be a scope_guard() as it is only needed for the list. I
> prefer using guard() when it is most of the function that is being
> protected. Here it's just the list and nothing else.
>
> One issue I have with guard() is that it tends to "leak". That is, if you
> use it to protect only one thing and then add more after what you are
> protecting, then the guard ends up protecting more than it needs to.
>

Yep, makes sense. I just noticed the use of guard() for mutex before,
so assumes the same could be done for SRCU, but what you are saying
makes sense, no problem.

> If anything, I would make the loop into its own function with the guard()
> then it is more obvious. But for now, I think it's fine as is, unless
> others prefer the switch.
>
> -- Steve
>
> >
> > > +       list_for_each_entry_srcu(work, &callbacks, list,
> > > +                                srcu_read_lock_held(&unwind_srcu)) {
> > >                 if (task->unwind_mask & (1UL << work->bit)) {
> > >                         work->func(work, &trace, timestamp);
> > >                         clear_bit(work->bit, &current->unwind_mask);
> > >                 }
> > >         }
> > > +       srcu_read_unlock(&unwind_srcu, idx);
> > >  }
> > >

