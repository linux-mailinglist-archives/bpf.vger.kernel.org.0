Return-Path: <bpf+bounces-33003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A104915D10
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 04:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA7D1C2182C
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1DB61FEC;
	Tue, 25 Jun 2024 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yut9UEMT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008821CA8D;
	Tue, 25 Jun 2024 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719283926; cv=none; b=XUHsDZ5ivgG1qf5SrqaTIsyvqP53pgWFUsGAXB2gAHk5uT49bS8g2yX3nRdC3lY9a7bhVu7wz/Exvnte+/708S6Bm6y5NmJENP4YNlAEUbtLaoP+tKtb/yhb/YxoSlNOd8WGh/PH7vvBAM0BxJgV9bXUFO/F3wUvwHVU4u7R1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719283926; c=relaxed/simple;
	bh=hSY/49cn0tGt6JUdjKJS6ZzZN6MO4RqUUhxXNuSayak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fo9SmDhEmgitYlfi0Z2d5JsyaPP8l4mZbPT8WbtcqpEkI0ERZIpNZtBHLZuthWqwOMc3D9vyjHt7ywK2IxbF9AUO7dN5XBNSkPVW0afGfEaqVgoCOOldOcIsjjF/iSUAUeMAnbcSjUHkYaahCM4Cn3yWvpapQKnGOHV4Z7N+rNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yut9UEMT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c86e3fb6e7so1390152a91.1;
        Mon, 24 Jun 2024 19:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719283924; x=1719888724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxXtDQ2xW9AfQefbNiTroQGUiz0xawMKHcVZhoSIIp8=;
        b=Yut9UEMT6UXs1MU/QmX3EzzlWBsFL9BRspwlsreH+UA/jPuF+Dsh5zmEW+1Z2ZjTGG
         Q1Xe2ynGutHXqHnFLQMtrYCQM/SxPmCezINVXQTLJThd1nZ2dO2dHCVH0Zqi78mgioFx
         WtpjlamvkJY/AHbtJ8FmkfwEUGdLIkjJwe6KKSF/rqpaJEK002fyrWCVZyGXGGPPgcLe
         W4ET6iyosoGI0Q0Ck2Z5McYYJIvjYLM3GTA2SXmPHDaGQvrvPD8VZSRed7EDtcyffOXP
         N0Ehx5wXIW+jR2p3az9FMTp4vpcJWT9EAObVEB+NwrDLfl3rHhZshhxjH6fFVUyWjkdT
         60HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719283924; x=1719888724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxXtDQ2xW9AfQefbNiTroQGUiz0xawMKHcVZhoSIIp8=;
        b=j+JuPfFKOZeF9dJXycb7AtcFy4to5PJL/EbprPCWPz0bIqvXRjmBZmy20EmVTWOnHz
         3AW8iLKT/4z+n2C27cgcEbaWpOZHbGuK9zVZOagKGeo1adlvjZ4hjxdC4ZyxHWea7TcA
         NoHebyoGd4eoCK1YgHYtHT/hk/ll/H8FauZLJRW2Os2Mi0qs6KSxzbLxXnh5Q0xgvsVf
         keH7wj39f5b9kXCZiJx1ZQmxWXTG3qOTStYahHqqMIEkLV1N/sed/iD+G8/JPdiBkGNE
         Iwpl+/mwYQCIxMwQzrC5DYZcggT3rcxAx+i7PHhaALvhCS2luM32OqLKNYHVUVCtik3T
         z6rg==
X-Forwarded-Encrypted: i=1; AJvYcCX0R/kBKEghm843NbLhutf5sQEq1iytH4adt+yNMpFw0hCFKgtzXu6Ms6yZVyNwmJmMA3uF10OHvHd/jgEAGqzc9EUmNG6cKLivcdcEGfi1sIf47m2ya+x9vmjkroANRBlYpoBORJ/MMnGg6jMY+0XcoVAZ317aw9UVD15UpzmNKaLSZ9c3Xi5leA==
X-Gm-Message-State: AOJu0YzuFoOVM3GhraSPdpPndM/J88Nwt9vVeCy59NLm7asslrPSDN+M
	H/GGIY/RZ8E833MsKpSrF/OlHi3wQqdjqX8byB9xsgmnJVwjcsC9Ym7P8mRdyV+WQ9Fz78kxh0m
	6XzszjlOMtH2w6xILOsjIE0lxDOs=
X-Google-Smtp-Source: AGHT+IFnlSqFyshGgc0029y3MHLClxHmtnBnAYA/f2M15sr2gpNRDax1gxJkjqIIdeMJvueqTDqJ1HTIj4qwwD6nhHc=
X-Received: by 2002:a17:90b:180f:b0:2bf:7eb7:373b with SMTP id
 98e67ed59e1d1-2c861409e3fmr4464233a91.33.1719283924251; Mon, 24 Jun 2024
 19:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522013845.1631305-1-andrii@kernel.org> <20240522013845.1631305-3-andrii@kernel.org>
 <20240604231314.e924c51f7b9a18428a8a7f0f@kernel.org> <CAEf4BzbneP7Zoo5q54eh4=DVgcwPSiZh3=bZk6T2to88613dnw@mail.gmail.com>
 <CAEf4BzY0VWXDo_PUUZmRwfGZc3YfNy4+DDLLPT3+b3m6T57f8w@mail.gmail.com>
 <CAEf4BzbWM0Jd59cadyfhpmV5DC+QAoLTwAfjzT9mt4HkoAeGpA@mail.gmail.com> <20240625093947.85401db681715219a7c8b8e3@kernel.org>
In-Reply-To: <20240625093947.85401db681715219a7c8b8e3@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Jun 2024 19:51:52 -0700
Message-ID: <CAEf4BzZaYnM1iwiX6Tz3rk2JRSObLqjhjKTDhE22VVEFQQxdfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf,uprobes: fix user stack traces in the
 presence of pending uretprobes
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, x86@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org, Riham Selim <rihams@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:39=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Mon, 24 Jun 2024 13:32:35 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Mon, Jun 17, 2024 at 3:37=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Jun 4, 2024 at 10:16=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Jun 4, 2024 at 7:13=E2=80=AFAM Masami Hiramatsu <mhiramat@k=
ernel.org> wrote:
> > > > >
> > > > > On Tue, 21 May 2024 18:38:43 -0700
> > > > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > >
> > > > > > When kernel has pending uretprobes installed, it hijacks origin=
al user
> > > > > > function return address on the stack with a uretprobe trampolin=
e
> > > > > > address. There could be multiple such pending uretprobes (eithe=
r on
> > > > > > different user functions or on the same recursive one) at any g=
iven
> > > > > > time within the same task.
> > > > > >
> > > > > > This approach interferes with the user stack trace capture logi=
c, which
> > > > > > would report suprising addresses (like 0x7fffffffe000) that cor=
respond
> > > > > > to a special "[uprobes]" section that kernel installs in the ta=
rget
> > > > > > process address space for uretprobe trampoline code, while logi=
cally it
> > > > > > should be an address somewhere within the calling function of a=
nother
> > > > > > traced user function.
> > > > > >
> > > > > > This is easy to correct for, though. Uprobes subsystem keeps tr=
ack of
> > > > > > pending uretprobes and records original return addresses. This =
patch is
> > > > > > using this to do a post-processing step and restore each trampo=
line
> > > > > > address entries with correct original return address. This is d=
one only
> > > > > > if there are pending uretprobes for current task.
> > > > > >
> > > > > > This is a similar approach to what fprobe/kretprobe infrastruct=
ure is
> > > > > > doing when capturing kernel stack traces in the presence of pen=
ding
> > > > > > return probes.
> > > > > >
> > > > >
> > > > > This looks good to me because this trampoline information is only
> > > > > managed in uprobes. And it should be provided when unwinding user
> > > > > stack.
> > > > >
> > > > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >
> > > > > Thank you!
> > > >
> > > > Great, thanks for reviewing, Masami!
> > > >
> > > > Would you take this fix through your tree, or where should it be ro=
uted to?
> > > >
> > >
> > > Ping! What would you like me to do with this patch set? Should I
> > > resend it without patch 3 (the one that tries to guess whether we are
> > > at the entry to the function?), or did I manage to convince you that
> > > this heuristic is OK, given perf's stack trace capturing logic alread=
y
> > > makes heavy assumption of rbp register being used for frame pointer?
> > >
> > > Please let me know your preference, I could drop patch 3 and send it
> > > separately, if that helps move the main fix forward. Thanks!
> >
> > Masami,
> >
> > Another week went by with absolutely no action or reaction from you.
> > Is there any way I can help improve the collaboration here?
>
> OK, if there is no change without [3/4], let me pick the others on

Thanks, Masami!

Selftest is probably failing (as it expects correct stack trace), but
that's ok, we can fix it up once linux-trace-kernel and bpf-next trees
converge.

> probes/for-next directly. [3/4] I need other x86 maintainer's
> comments. And it should be handled by PMU maintainers.

Sounds good, I'll repost it separately. Do I need to CC anyone else
besides people on this thread already?

>
> Thanks,
>
>
> >
> > I'm preparing more patches for uprobes and about to submit them. If
> > each reviewed and ready to be applied patch set has to sit idle for
> > multiple weeks for no good reason, we all will soon be lost just plain
> > forgetting the context in which the patch was prepared.
> >
> > Please, prioritize handling patches that are meant to be routed
> > through your tree in a more timely fashion. Or propose some
> > alternative acceptable arrangement.
> >
> > Thank you.
> >
> > >
> > > > >
> > > > > > Reported-by: Riham Selim <rihams@meta.com>
> > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > > ---
> > > > > >  kernel/events/callchain.c | 43 +++++++++++++++++++++++++++++++=
+++++++-
> > > > > >  kernel/events/uprobes.c   |  9 ++++++++
> > > > > >  2 files changed, 51 insertions(+), 1 deletion(-)
> > > > > >
> > > >
> > > > [...]
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

