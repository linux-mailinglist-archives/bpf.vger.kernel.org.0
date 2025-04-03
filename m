Return-Path: <bpf+bounces-55240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A98A7A775
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D48F1758C7
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DD7250BF7;
	Thu,  3 Apr 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7yhYwBW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DFA24EF7B;
	Thu,  3 Apr 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696134; cv=none; b=Jkqfbrp3TXbfPlCl00hrUi1V++EWenRfqNtLNySDaKgWr/Dv1Gc8wNZpFKyuWazGIdbGFZXK/S875m8TKhBocNG4YXbThceHArZVbJsfwjyMbe5BTRdGxNJ+ciOk3DV8r5FDP7i5guWixdDj99ELSmyiuouF8pAlXPjL7DxmyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696134; c=relaxed/simple;
	bh=m7tu4rDfq00695S+IZ3bQyVVACf9bPRtoApVmM5hPGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEarw+BLUSwYSOdn8/0U7SOGaV7jjXsJJwupGGt11z1kddk5Gle9BWs15vlkZoxYK2qUPPvj8+nd/VyYUfSr3HjSDdaArkASu7ecfVWv0Y00HZrDZG8pB0TEeFMFTJZww+GVe4Opz53QT8/Qb/2vBw5+rmTqBp3qDevQ6yIwtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7yhYwBW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b350a22cso952782b3a.1;
        Thu, 03 Apr 2025 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743696132; x=1744300932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERaBmqCIf0T5YAHhV0wCrhXIl+DoA74R7uuluo5dCww=;
        b=R7yhYwBWov0JXyYo5UGDN3DNz03tI5VL4Gvgrvnztvsniv+7ObtJ1JFWSJ4ujlp1Gs
         w0jVhos1uz+ZivzX6uge6DRGrdCaCP1m2dYlKwiA1JDM9Kia82d5FEwaMNgwE0ujPZfb
         o548TRtJsgwmpEg4CCmTXyT7rk08P6rgrk8SHEK3yzQU4ipHeNRkqA3VdLpEGFv+uiMf
         d6+IXiMKbIwbddKbnQb8RDzfWivC76nrmPZ1GT5jELSA/nWtEEXuOEkFgOdvOWnFmjTC
         GwcMvKkwULP9UdME/FOoK30Q/QIFIugMfgavmfH/9FvFjEy69c6hsiChwRz52BX3nF2K
         tA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743696132; x=1744300932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERaBmqCIf0T5YAHhV0wCrhXIl+DoA74R7uuluo5dCww=;
        b=cXOy0Ne3Xxus2+yV/sBAHVwttp9ijLpiRxVh71sopBcZa4atsn36tIxEj1Ct00s5FN
         9b5kI/i5YAGw9KXoA4hujQQZkapDEqQIT992ShLXV9jyDUf0fkDVF13+HtNKku+PDizE
         0gi/IlwHi7eFY2K1tVGYm22XPX8x20il5K2E1TGudamJMlQQL1FN6wdOEGz7l2pkSz1l
         1vJtucc6L5DV3hRCsA3mPwpW3s6/8xiR1wdAOWvksvLsAeREaIh8H6hY6zjFobKG9U8k
         /5UDAp0Go6Z38SMFiM5D/KmRoMNN1czSEHR2uaJ1DBlFkSpcSYKVBWk+fvq3bdd8I4XN
         baNw==
X-Forwarded-Encrypted: i=1; AJvYcCVN3l26BG9AeVW1cvOy1xozc/A1BPmcCtKL4CcD3yI0nbP1CKJXFTlikrcJAKH+u74O0yy9rVHb12Ju6QGa@vger.kernel.org, AJvYcCWKncyN0gc7sxV53bUit57yHvL6zcVaBiAqRMdbmbO3H6VIHkAPbDkatgXdGYJhXddZABY=@vger.kernel.org, AJvYcCX9cnp2khn2MmevJtEhGt5Z87g5KJ1ZrwoBCfy0pWw0MbkaFl1vYwNjSrB52ttSFX/YknHq7WGR46O8vTGbntOU5vmF@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwPh/39HEcuGe6RuzkB4TxAm5aD5dVJvtr334hA7Oj3rSu184
	u+p58oEeUjBnax/7JSDWOsuIK10WPRs38LwQAunl/Kmagc6rgRcyM3nkm4hBdWEeVEGiqQ66o9z
	9Cgr23+43vZOYoaAs4GzF3tFVpYE=
X-Gm-Gg: ASbGncuHDgsRg46dOiAKsjOVH9xvFR+XDyNqCxyM1x8llAszsl4uDKZEhxx2++0eVNH
	d4nlW/VkysBypxjWDXeWhxZxsvGiwofGXAdDPXBKSc2APGylH+nfsAJbwnbiv3ppCV8Ufjf90AK
	WrguIzsidvJXX+cqEy7BPivtqUoknwVxBIcn0n5tPxnQ==
X-Google-Smtp-Source: AGHT+IFrnDbDbO9hh52XP1EFEhRczxV4AfHIekgrm8+a4QyhKJnT3NAnmiuxSphpvehUvVydL2WYUP+18gU4tmITRhE=
X-Received: by 2002:a05:6a00:2381:b0:736:5753:12f7 with SMTP id
 d2e1a72fcca58-739e48cf381mr188334b3a.3.1743696131261; Thu, 03 Apr 2025
 09:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402180925.90914-1-andrii@kernel.org> <Z-6TDh1MUT49lvjk@gmail.com>
 <20250403110615.7a51b793@gandalf.local.home> <Z-6lPadt51e7jcXd@gmail.com>
In-Reply-To: <Z-6lPadt51e7jcXd@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 3 Apr 2025 09:01:59 -0700
X-Gm-Features: AQ5f1Jq_ruvyVGPvzIEu_GKFQv45bDPlWqzaU4Z2mJaYsY8ahuIN2Oa34tScXbo
Message-ID: <CAEf4BzagjTyA+OWzWatrHvHu0wpzWBDJT=-qh+NWYTNAtjRWxQ@mail.gmail.com>
Subject: Re: [PATCH v2] exit: move and extend sched_process_exit() tracepoint
To: Ingo Molnar <mingo@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, mhocko@kernel.org, 
	oleg@redhat.com, brauner@kernel.org, glider@google.com, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 8:12=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Thu, 3 Apr 2025 15:54:22 +0200
> > Ingo Molnar <mingo@kernel.org> wrote:
> >
> > > This feels really fragile, could you please at least add a comment
> > > that points out that this is basically an extension of
> > > sched_process_template, and that it should remain a subset of it,
> > > or something to that end?
> >
> > Is there any dependency on this?
> >
> > I don't know of any other dependency to why this was a template other t=
han
> > to save memory.
>
> Uhm, to state the obvious: to not replicate the same definitions over
> and over again three times times, for 3 scheduler tracepoints that
> share the record format?
>
> Removing just a single sched_process_template use bloats the source and
> adds in potential fragility:
>
>  2 files changed, 26 insertions(+), 4 deletions(-)
>
> So my request is to please at least add a comment that points the
> reader to the shared record format between sched_process_exit and the
> other two tracepoints.

Sounds good, no problem. I'll send a follow up patch which Andrew can
fold, if he prefers.

>
> Thanks,
>
>         Ingo

