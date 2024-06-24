Return-Path: <bpf+bounces-32945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF4D915812
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD1D1F26334
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE831A08A6;
	Mon, 24 Jun 2024 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1WelBFb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434371A0720;
	Mon, 24 Jun 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261169; cv=none; b=HoyWJjGCOBjmvzjbEiUPKaiIwrGwVL7xz2+9aP0hZmqj7oQGlHxgzYb6ysK872pY46FcD2xdSdYaBiKMvFtFXlzFZ0TKxex0OXNnS9ivz3E71jFuuB129YqQlbHcc3QanjNTl3v50j/dmbGD3NRqsyRpmiQfFsH5JCYpGXSO/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261169; c=relaxed/simple;
	bh=loUGGKUlMKTeqzXspfiDA736Im9cK0196cAIr8hvDi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPBi8+oEbwxHdGFAlHZ35ZMZxF0Hufo7EzFi2YUjq0tlV4CWlpVWLVWuArHhlO0564CT7sHwrD0CygYjMyaNwYSWgmTX+uz7QoRnUR8XUMpMzUZEZ1+55QJ9c0bTUey0iwqERp7flwcj8jDrAM28wfSynaEcKmgpKBCp7bYigIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1WelBFb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c7bf925764so3855866a91.0;
        Mon, 24 Jun 2024 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719261167; x=1719865967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUakyHd6S2JJ/XFe+nLMWI4tCoE1o1PHt5flYDloRUw=;
        b=c1WelBFbhvXUvP6kH9dCfA6KrxxpZ5ehGHQa6TGAn6ngKjr6kF6Nh3PIqdExUcw4ue
         vrrsTWtc6arRZQtRN46q9pIHr9m8Q3z0YoDHIdmZe8BXsCl1/8MxCval7lukajpsHTQh
         /HHF/KrCNloN2AOUpFjTLJR5oETbobpQqpsWBTwRfIORaEuNoEhMEU0bgx9BNNleqhr6
         LHFuF/QKtRUvaVjVXAe0UFZDb1dY7yVAQAEDorNAMYQqVoU0cEJpHz0DB7Myx7XuyPx0
         jLN6FkPgLJwCpyKWKa3H8thOM196Apc+Sc3hmLFxkqbG7p3+VGaxBZ4fOcKqx6gIFfwt
         t+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261167; x=1719865967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUakyHd6S2JJ/XFe+nLMWI4tCoE1o1PHt5flYDloRUw=;
        b=ZRmT6aJVq28VBjg6/2CI9PvyWMTl8L/hpcRMUZSX6yz547APn5/rBtd/dJGl72SqEQ
         q44d9CjIb0jUmb/kxdXBRBqG3qIOf4wUY5gU5JeFAWAv5NvsXlV4yV3a821BNLMZvoxE
         dy9UVBil1xv8zgo66Y34IQrm4BBiHlJkBs4hdwemoLEGHlDI+ozP/LFcdFdr6Ur18gMv
         83q6On79KVG/S2vMmz+qXIeFdmPrVDqTiinIq16I18b7S1KX88vkkW5+ae32sGLUujuo
         rDANRuqnm6fwl0w+p8Yt0RQ5grzsoqraRbRPUXiZmD9jIJGbst9Z5DNj4GxftxpRtWyR
         fKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY+s4SBoxpVKqJ3iLD8vt9KMv3ffDCcQw2vrh6gg4B5V2j363E2SkJcnLQ+E02JqzuB4sdBn4ZitNULar72j0CYKrasHdClnRDtBEElE7++3WJI8ue2gkbXJxhN3m6QKaJOrRBrZYeVgFDN30oBqOqdGw/1WP0olTMkvRp9lu80Z53wMVupQKE4A==
X-Gm-Message-State: AOJu0YxZP1xtacHa2HAQHePAYNT1CajcygwoZvZak3shhoubCkIN+sCU
	srNBwxVkz4yADw9lexQ5kcSVqk8fmARaa8cIrHdBx1Dt1IT/krS7wAfZTS66VkxEMMBNjXm+tSd
	8ZL/e0Jl3mVpmFErQHb9E9Kib/eQ=
X-Google-Smtp-Source: AGHT+IFXJ361DSX3cUBE3zfYqJGNG+ljkJkdlEuomdBuT53GtY6qQXdHgFQa5QbVIrpWDoPFaGRKKo0LVUNjeROqaZE=
X-Received: by 2002:a17:90b:1288:b0:2c7:7718:a9dc with SMTP id
 98e67ed59e1d1-2c86141e878mr5449280a91.46.1719261167304; Mon, 24 Jun 2024
 13:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522013845.1631305-1-andrii@kernel.org> <20240522013845.1631305-3-andrii@kernel.org>
 <20240604231314.e924c51f7b9a18428a8a7f0f@kernel.org> <CAEf4BzbneP7Zoo5q54eh4=DVgcwPSiZh3=bZk6T2to88613dnw@mail.gmail.com>
 <CAEf4BzY0VWXDo_PUUZmRwfGZc3YfNy4+DDLLPT3+b3m6T57f8w@mail.gmail.com>
In-Reply-To: <CAEf4BzY0VWXDo_PUUZmRwfGZc3YfNy4+DDLLPT3+b3m6T57f8w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Jun 2024 13:32:35 -0700
Message-ID: <CAEf4BzbWM0Jd59cadyfhpmV5DC+QAoLTwAfjzT9mt4HkoAeGpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf,uprobes: fix user stack traces in the
 presence of pending uretprobes
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, x86@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org, Riham Selim <rihams@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:37=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jun 4, 2024 at 10:16=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jun 4, 2024 at 7:13=E2=80=AFAM Masami Hiramatsu <mhiramat@kerne=
l.org> wrote:
> > >
> > > On Tue, 21 May 2024 18:38:43 -0700
> > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > > When kernel has pending uretprobes installed, it hijacks original u=
ser
> > > > function return address on the stack with a uretprobe trampoline
> > > > address. There could be multiple such pending uretprobes (either on
> > > > different user functions or on the same recursive one) at any given
> > > > time within the same task.
> > > >
> > > > This approach interferes with the user stack trace capture logic, w=
hich
> > > > would report suprising addresses (like 0x7fffffffe000) that corresp=
ond
> > > > to a special "[uprobes]" section that kernel installs in the target
> > > > process address space for uretprobe trampoline code, while logicall=
y it
> > > > should be an address somewhere within the calling function of anoth=
er
> > > > traced user function.
> > > >
> > > > This is easy to correct for, though. Uprobes subsystem keeps track =
of
> > > > pending uretprobes and records original return addresses. This patc=
h is
> > > > using this to do a post-processing step and restore each trampoline
> > > > address entries with correct original return address. This is done =
only
> > > > if there are pending uretprobes for current task.
> > > >
> > > > This is a similar approach to what fprobe/kretprobe infrastructure =
is
> > > > doing when capturing kernel stack traces in the presence of pending
> > > > return probes.
> > > >
> > >
> > > This looks good to me because this trampoline information is only
> > > managed in uprobes. And it should be provided when unwinding user
> > > stack.
> > >
> > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > Thank you!
> >
> > Great, thanks for reviewing, Masami!
> >
> > Would you take this fix through your tree, or where should it be routed=
 to?
> >
>
> Ping! What would you like me to do with this patch set? Should I
> resend it without patch 3 (the one that tries to guess whether we are
> at the entry to the function?), or did I manage to convince you that
> this heuristic is OK, given perf's stack trace capturing logic already
> makes heavy assumption of rbp register being used for frame pointer?
>
> Please let me know your preference, I could drop patch 3 and send it
> separately, if that helps move the main fix forward. Thanks!

Masami,

Another week went by with absolutely no action or reaction from you.
Is there any way I can help improve the collaboration here?

I'm preparing more patches for uprobes and about to submit them. If
each reviewed and ready to be applied patch set has to sit idle for
multiple weeks for no good reason, we all will soon be lost just plain
forgetting the context in which the patch was prepared.

Please, prioritize handling patches that are meant to be routed
through your tree in a more timely fashion. Or propose some
alternative acceptable arrangement.

Thank you.

>
> > >
> > > > Reported-by: Riham Selim <rihams@meta.com>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  kernel/events/callchain.c | 43 +++++++++++++++++++++++++++++++++++=
+++-
> > > >  kernel/events/uprobes.c   |  9 ++++++++
> > > >  2 files changed, 51 insertions(+), 1 deletion(-)
> > > >
> >
> > [...]

