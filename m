Return-Path: <bpf+bounces-40694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D4298C438
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641B11F24E62
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6171CBE82;
	Tue,  1 Oct 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQQcptCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D831C8FD5;
	Tue,  1 Oct 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802602; cv=none; b=k9ur6je9R9E3OkcWp36AWE2FVwH5Ae9ro6nUvpszEUaPhleDMUJJxCyWloqtRY+hL6JgjbRZae+Jtp7CMJ2SWO31MwI6IrmL2sDXyFlg/JC86roi28BY4jS7bUe9lcd/kGw8vCqWqyFhinp/DQ8n72XULaq/19Q/9UOBtqZ/RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802602; c=relaxed/simple;
	bh=alDtEoNsU4mwdUuRnINXZRZyMrKQxS5WIZf9p9ulSNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpzRF2qCoqKc9/cNMQgSaQbutxG+ZvszPATw5nERYmZFeKyo+EQ+bUXkolEbF+w/ww609/UQsZiENTFOJ89j4Y3FcUtCD5AdqsMgdZTjUaJ5uP+MXUclOZCZZe9/+cwUHidhkUPMRyd0hl1e7AQUzzT74Q7OLtFRk1vrgZFIrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQQcptCJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0b9bca173so3456900a91.0;
        Tue, 01 Oct 2024 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802600; x=1728407400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IDIXsRvA4u9tioJjolq/9MIM5TaBVbevdVxNHBa54E=;
        b=CQQcptCJAEDFKclC5konuLM3iXtm7rjPRWaylj3cv1gur2zL1Ltoh3ONEfJJFUw3Wm
         YvNzUbMgMMk/oMxGXaq/ObmWiOw8Lyf1gzw9C+2HoUGTMqmbl/g0+aAmW6DWwykBFVPN
         DLaPnmA0kDwHCsdLmjVHmbo9FT+/q320GbPjlCQWQSxG/50cFRQsyETQKzDGb+QV9XwJ
         gw4xVCNN5rlbcAB/AdZZlZLrOsKnTDYkwdihVZyIdwDNlyWFCZisirV1m21Ysjpi06iG
         V7r/MQGFY8IqHX4vhUR2fq7EpmXeAKHb8f8vcqwRSxG/r7x6PRv0QENF2zgDCNQceTZY
         1udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802600; x=1728407400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IDIXsRvA4u9tioJjolq/9MIM5TaBVbevdVxNHBa54E=;
        b=OWiMCrE6432OpZdtRyUYCNF/ZNPN4KjraM563IS7akGC1Aq5EZRNqGpJtf8EJ3qCQO
         4JqMAuN2dxhayrV10ZRg5W/c8bDICw6mhK9X5bqmppkjtsMipo3QnqRmCRNAzXMwq5/S
         yPuZhRgzGghhbsBnWIukzeXlh6CwyHrWmrIKBPmYtZMHD4p8wEHFz7CkatIxdvUtGa5b
         j69Rqxj8JRiibTxlzElm8jlBSbnnkuhC3biXEZxspRpXkdruYihDtSOFeed8WOaHlji2
         O1pRM4WNBwmLQxYxrkGv2cR3rNM3C+OrKJ6bbro+S8rHVDsAKz9XoxnWx5bTaLXjEEy1
         JvLA==
X-Forwarded-Encrypted: i=1; AJvYcCV+idO/kg2uqLElM6qOuLQcrg4Qde4fpUksyngBIHX/IW1KUzpqgQgE+TPmED0K4piOUMjOxT46ngdecaYtIeiCMYNt@vger.kernel.org, AJvYcCV5fPd8N5ugl/1OlrlAakoQ42iriko1zCxKj6q9mVG/myswHoYp2dAJRBdud+LWY7lz2s5D+VvtF11qrlNS@vger.kernel.org, AJvYcCXonnAXtdSBoJDDgQS3HAdVeG0Fl4nYZdR0Q2CXV4YsTXX2anyQYoaX8CJYQKCRcg9xcPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tu0PQgzn0miesaB6tCN14GSXoWRQIQ8D4Fms8XIBPKipIK8G
	QIivFgtFifxeWLiHpdpCgZI6DFg80lDDSNEBvEufl4vjy/t9tQhG7Bm3yOIKW6iMB5IK27ydbQH
	kbzmOBKQ09A+85X6MtgMbftEj4O8=
X-Google-Smtp-Source: AGHT+IHzetG8vydc4yjfozPANM0fmOmtCvy0ZuI9MUfqcHltM4C6A8LVHuJgWUaFY4YmnkxbIbdxy7RByoTLOAvLbVA=
X-Received: by 2002:a17:90b:fc5:b0:2d3:dca0:89b7 with SMTP id
 98e67ed59e1d1-2e184527678mr464260a91.3.1727802599607; Tue, 01 Oct 2024
 10:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929205717.3813648-1-jolsa@kernel.org> <20240929205717.3813648-3-jolsa@kernel.org>
 <CAEf4BzZ+1=YU=61mVup8pAc80SOvNuYtMzNdz4miH+Sm4qV4ig@mail.gmail.com> <Zvv2eM2YNuiv7C8-@krava>
In-Reply-To: <Zvv2eM2YNuiv7C8-@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:09:47 -0700
Message-ID: <CAEf4BzY8tGCstcD4BVBLPd0V92p--b_vUmQyWydObRJHZPgCLA@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 02/13] uprobe: Add support for session consumer
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:17=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Sep 30, 2024 at 02:36:03PM -0700, Andrii Nakryiko wrote:
> > On Sun, Sep 29, 2024 at 1:57=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > This change allows the uprobe consumer to behave as session which
> > > means that 'handler' and 'ret_handler' callbacks are connected in
> > > a way that allows to:
> > >
> > >   - control execution of 'ret_handler' from 'handler' callback
> > >   - share data between 'handler' and 'ret_handler' callbacks
> > >
> > > The session concept fits to our common use case where we do filtering
> > > on entry uprobe and based on the result we decide to run the return
> > > uprobe (or not).
> > >
> > > It's also convenient to share the data between session callbacks.
> > >
> > > To achive this we are adding new return value the uprobe consumer
> > > can return from 'handler' callback:
> > >
> > >   UPROBE_HANDLER_IGNORE
> > >   - Ignore 'ret_handler' callback for this consumer.
> > >
> > > And store cookie and pass it to 'ret_handler' when consumer has both
> > > 'handler' and 'ret_handler' callbacks defined.
> > >
> > > We store shared data in the return_consumer object array as part of
> > > the return_instance object. This way the handle_uretprobe_chain can
> > > find related return_consumer and its shared data.
> > >
> > > We also store entry handler return value, for cases when there are
> > > multiple consumers on single uprobe and some of them are ignored and
> > > some of them not, in which case the return probe gets installed and
> > > we need to have a way to find out which consumer needs to be ignored.
> > >
> > > The tricky part is when consumer is registered 'after' the uprobe
> > > entry handler is hit. In such case this consumer's 'ret_handler' gets
> > > executed as well, but it won't have the proper data pointer set,
> > > so we can filter it out.
> > >
> > > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/uprobes.h |  21 +++++-
> > >  kernel/events/uprobes.c | 148 +++++++++++++++++++++++++++++++-------=
--
> > >  2 files changed, 137 insertions(+), 32 deletions(-)
> > >
> >
> > LGTM,
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >
> > Note also that I just resent the last patch from my patch set ([0]),
> > hopefully it will get applied, in which case you'd need to do a tiny
> > rebase.
> >
> >   [0] https://lore.kernel.org/linux-trace-kernel/20240930212246.1829395=
-1-andrii@kernel.org/
>
> the rebase is fine, but what I'm not clear about is that after yours and
> Oleg's changes get in, my kernel changes will depend on peter's perf/core=
,
> but bpf selftests changes will need bpf-next/master

Yep, and I was waiting for your next revision to discuss logistics,
but perhaps we could do it right here.

I think uprobe parts should stay in tip/perf/core (if that's where all
uprobe code goes in), as we have a bunch of ongoing work that all will
conflict a bit with each other, if it lands across multiple trees.

So that means that patches #1 and #2 ideally land in tip/perf/core.
But you have a lot of BPF-specific things that would be inconvenient
to route through tip, so I'd say those should go through bpf-next.

What we can do, if Ingo and Peter are OK with that, is to create a
stable (non-rebaseable) branch off of your first two patches (applied
in tip/perf/core), which we'll merge into bpf-next/master and land the
rest of your patch set there. We've done that with recent struct fd
changes, and there were few other similar cases in the past, and that
all worked well.

Peter, Ingo, are you guys OK with that approach?

>
> jirka

