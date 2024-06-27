Return-Path: <bpf+bounces-33271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87AA91AD0C
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 18:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF63289A3C
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FDF1993BA;
	Thu, 27 Jun 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkdBWOQ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA91494A1;
	Thu, 27 Jun 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506621; cv=none; b=cbG5GEBPjmS9TA5rMwwOJ3htnjHgKIoVfEtCR3/gqPgEmMejUAHaJ8i8sLOqtRFIghLDWbUNwjdF/rjCTw3HbpG72kLvMqWAIA2dDS7ED1QB6newd/OoIWM+IEVyllgf6eb1/aBfXCD3bospxP+N+rbRrdaPirHQ3v9f4uSx514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506621; c=relaxed/simple;
	bh=Pzvab+P7oHtsuMWQVvxBpy27WDalK4SAhrkR7Q0XMms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHJsXomnJJ5wfkQLA3mjKi+WCWGnrS54NgYdHcSE3xhdDJcEbM6NqEHPM+kULZS/JUWC5iQiHOfRRBm5Gi8F+X3tpXdkI10M4wOYfeGCXyc6VuJnom9269UGbetStRmJmLNs+0DyYiM1Jb3FcfCOjxEpybcTobucWPfAuE3b8lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkdBWOQ1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c7dff0f4e4so6419600a91.2;
        Thu, 27 Jun 2024 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719506619; x=1720111419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrAx6aaMDW2xL/mgwiGPWCampdvgGJiEDrh0Y/dkQXE=;
        b=FkdBWOQ1FZLWvfK4V6MO03ohPgR1w+kdPcghKY4ATZyfpWdVRoZjBxbGmE3clMPDT6
         nlSTJdjxo3lrz9a44eqegIwoOHb/2nWmhyhEnf5SiJpdcfnXRXaY66ngo08wuBkVeySk
         YCsl2qrgS570RqwZQEkrXzkj33HziNflNYc8GJUpg8vghF8Neaow42jrmDNdf6B43/UX
         ao24265GWfffqcY3ske3ZVUCf0FgrJH5y9YvBqG3fYjp5La1vqPAXv0C3ho0htmGe40Q
         J+zFwX6MHoWXP4kUeJQwY8142gJaT4q8V7QYRhxUiLFiKVhC3r/+v/dTqoKum/OJZtAl
         OQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719506619; x=1720111419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrAx6aaMDW2xL/mgwiGPWCampdvgGJiEDrh0Y/dkQXE=;
        b=JvbXxpmGaW43C+hFZCY5aUauxwnIC/UJ+sHd+RBEC0A8G3Hg8gmGMaytoLZPe2Y+Fv
         LIA8bzyHeDzM2gLGry86cvotFS5vQYaAoVbA/Yfrpjdi11iNdKgRRinB+z97HV8s7vGk
         +SRwcUgDXj88GCjM5XSp/1KwkVCcsIIbtRfZaCUPgSfBPoUwJ+pNzU1iR4X8SXw1q5E6
         +IXmfRn94laP0rt1hmEYMlxk0b3ZwK8Y17ADIkEojR4U7TS+FAPtGKMw2E2ujWeDyK3g
         n1jXHutitgLBZ1/rvT2GWOePYzw2T32O9uwKQevxIjRZ94x/ctIJdIxOT+9FHN68loOs
         K44Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVibfy7XgWsLb2HXSQyG6DvolsV1ngXNyQb3ZxFfaXx8Gm6ipmRKcywsnOe7DWXZNew3kA56X1rewdGIe5ir7e4rkB/yaFUW5qF5EFj7yjq+lr5ImwCzqwOiESNosc9aSNss3w3XJJ
X-Gm-Message-State: AOJu0YzU0bMB4Schc9mRLmzOqf1Qc8SliYf2VILCCQ4wkXPPRZcKTuoz
	E/lMmK8QXak57pcI8NVGV1d5UiA8qe2tP46ndy8WW3G4C/Xz/qTC9bbAkixcw8SdfPB5FE45e7B
	ekQ16Hx1+ZRr5mZHOEAt/1QaUqkk=
X-Google-Smtp-Source: AGHT+IEaJSigUX5Kkf7eZK6OfnbzfrbSiyXBRiuu1f7shgCEz9vjnLpbFxc5KLKK9LSsVFuOOTHwqHcz6ViwIRByMZI=
X-Received: by 2002:a17:90a:448b:b0:2c7:dfb6:dbe6 with SMTP id
 98e67ed59e1d1-2c8614861c8mr9994167a91.45.1719506619278; Thu, 27 Jun 2024
 09:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-5-andrii@kernel.org>
 <20240627112958.0e4aa22fe5a694a2feb11e06@kernel.org>
In-Reply-To: <20240627112958.0e4aa22fe5a694a2feb11e06@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Jun 2024 09:43:26 -0700
Message-ID: <CAEf4BzYF4kyWoY9qz2KV0iUDnNO6xEHMaTpZQPTDe2Dqa0_Fyg@mail.gmail.com>
Subject: Re: [PATCH 04/12] uprobes: revamp uprobe refcounting and lifetime management
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 7:30=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Mon, 24 Jun 2024 17:21:36 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Anyways, under exclusive writer lock, we double-check that refcount
> > didn't change and is still zero. If it is, we proceed with destruction,
> > because at that point we have a guarantee that find_active_uprobe()
> > can't successfully look up this uprobe instance, as it's going to be
> > removed in destructor under writer lock. If, on the other hand,
> > find_active_uprobe() managed to bump refcount from zero to one in
> > between put_uprobe()'s atomic_dec_and_test(&uprobe->ref) and
> > write_lock(&uprobes_treelock), we'll deterministically detect this with
> > extra atomic_read(&uprobe->ref) check, and if it doesn't hold, we
> > pretend like atomic_dec_and_test() never returned true. There is no
> > resource freeing or any other irreversible action taken up till this
> > point, so we just exit early.
> >
> > One tricky part in the above is actually two CPUs racing and dropping
> > refcnt to zero, and then attempting to free resources. This can happen
> > as follows:
> >   - CPU #0 drops refcnt from 1 to 0, and proceeds to grab uprobes_treel=
ock;
> >   - before CPU #0 grabs a lock, CPU #1 updates refcnt as 0 -> 1 -> 0, a=
t
> >     which point it decides that it needs to free uprobe as well.
> >
> > At this point both CPU #0 and CPU #1 will believe they need to destroy
> > uprobe, which is obviously wrong. To prevent this situations, we augmen=
t
> > refcount with epoch counter, which is always incremented by 1 on either
> > get or put operation. This allows those two CPUs above to disambiguate
> > who should actually free uprobe (it's the CPU #1, because it has
> > up-to-date epoch). See comments in the code and note the specific value=
s
> > of UPROBE_REFCNT_GET and UPROBE_REFCNT_PUT constants. Keep in mind that
> > a single atomi64_t is actually a two sort-of-independent 32-bit counter=
s
> > that are incremented/decremented with a single atomic_add_and_return()
> > operation. Note also a small and extremely rare (and thus having no
> > effect on performance) need to clear the highest bit every 2 billion
> > get/put operations to prevent high 32-bit counter from "bleeding over"
> > into lower 32-bit counter.
>
> I have a question here.
> Is there any chance to the CPU#1 to put the uprobe before CPU#0 gets
> the uprobes_treelock, and free uprobe before CPU#0 validate uprobe->ref
> again? e.g.
>
> CPU#0                                                   CPU#1
>
> put_uprobe() {
>         atomic64_add_return()
>                                                         __get_uprobe();
>                                                         put_uprobe() {
>                                                                 kfree(upr=
obe)
>                                                         }
>         write_lock(&uprobes_treelock);
>         atomic64_read(&uprobe->ref);
> }
>
> I think it is very rare case, but I could not find any code to prevent
> this scenario.
>

Yes, I think you are right, great catch!

I concentrated on preventing double kfree() in this situation, and
somehow convinced myself that eager kfree() is fine. But I think I'll
need to delay freeing, probably with RCU. The problem is that we can't
use rcu_read_lock()/rcu_read_unlock() because we take locks, so it has
to be a sleepable variant of RCU. I'm thinking of using
rcu_read_lock_trace(), the same variant of RCU we use for sleepable
BPF programs (including sleepable uprobes). srcu might be too heavy
for this.

I'll try a few variants over the next few days and see how the
performance looks.

> Thank you,
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

