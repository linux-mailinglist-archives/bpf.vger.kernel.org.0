Return-Path: <bpf+bounces-66767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 192B1B39118
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 03:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB211896F4B
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434C02063E7;
	Thu, 28 Aug 2025 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNTwvccE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF101E1C02
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344880; cv=none; b=Bg/IN0XqPIqaPUTrCeK5ZqVnyv4XrIFif9izA5TkHba2mjqNhaKmpB0OS/N5ivlnm18EWP9TOKO/JklJ6gVLrkpI8HzimtzyEJoBGLR4zPUryQ1EOwxR7RM4Vev+VutQ0mzmoooccK160gh11r1ymnhrAgI87WyLSGgE2a9o+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344880; c=relaxed/simple;
	bh=YWdCj2FS8U9ffB8aAp+dU4j3311PuVO0XlAdhpNHapM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2kOdyRl/yCDbGc9zH47lt+q0ccOyVb3R7eari5xCZDBZ8Tr+eVLSPEYB6q0YJSdgn3UMa/X9PJK8IXwi6pZzQobjx9NaB6CVmnugpEPKynDdA3gL+ImZax48HqXtaOU516BUooQcCLpMjrKt9b6iP2iSES+Cv5anTGFYujk3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNTwvccE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c7ba6c2b2cso241122f8f.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 18:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756344877; x=1756949677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWdCj2FS8U9ffB8aAp+dU4j3311PuVO0XlAdhpNHapM=;
        b=SNTwvccE0wlJ/e5KArN0QS2UwG44WDwM+9wQT4crRLKhI3GMuHXEJPzfTpMe3tiuZR
         qi1EIs4+SIHB5bNLIzoApLIxcuICH1G5K+y6E1QblWBGXDuK0gynkQN/3itQb0hJQKwP
         u9MDOVOvDKiGfJ3QvpMM68Hfy/tbVlon5SG8KtV0o3fbRpIttfFClf83CpvXtu24wF76
         LCfs/zkFTNtBdeKj8nTWozWjAn52Tmso+GjHsJJRCoj34eEg0PKJNxattU3QZcFfwWJK
         YOjbPcum332vYPkhAI3FBlN5L0J+EW07G5KjjZd/iW7Cxs5CxUS4ZbNEQiFnXJchD9d+
         jiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756344877; x=1756949677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWdCj2FS8U9ffB8aAp+dU4j3311PuVO0XlAdhpNHapM=;
        b=DWkyk7nOduPnhxGe1c2neFv3hOAFi4vLPrZY3ySqTuEbdskKBPIlQsOqIbM3Ry6UWh
         ga7mnqfv7sYeydkSvwD+HR8kEbjBuxFignbU/PpoY3dHL3t0KSiiefWHZ4q6fFX31IaA
         Nc3H4DRFpXgA2Bd4NeZB577pH0GnNYwrJuf7l6Ur+vg1sKlHKwmbkALY82lSI2cZcT4x
         eH5NSqMSwFClgsCCCFPthkYk+uBEFxBY0ikL5wQL1t2R6lOmuSf2pfon1lM/qUajDoA3
         pJIV/JQDFbuBWUgaiBKC447DR0FMZpvAx8AYkj7oAwsJJBHaC2/EFPOjnDFcFY4wBEjd
         f5kw==
X-Forwarded-Encrypted: i=1; AJvYcCVdih7qpesQc0QVoPFKZrMuCiRa5SNS2T7cLtKvORucmDPEsmkVhsGiZjCGRNhdEqXURwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJqjDPsD8PPcRfcvrERpi7iXejSz/uFCm+s93zb+GlqxWkKWZ
	6nHL4LMpgtrcyot01lsLOXxv6GJschnpTgNlhCwHBgnnCzP6HJCSn49nvkIHP9vW/b+JRDuVn8M
	YVrb6xVwUlmL0yW3he7WQzst0yCybQ5c=
X-Gm-Gg: ASbGnct9NrEmpDvyXuFkkX7oh5nvcJmKfwlIdXwMWyIvT2NQlVh3AFa+d7b7AYwzmWF
	GR0PVEFJ207jB2E7rMq0wfP0akz9LpPu5wrgyANVK4MkdEO7gtRMAo1Pcy7QhntPQo4iJYX/j0y
	1eOcc8ZKrbuVWAy+yu+BZXach64vsbAATz4SVrIWjJrneuOsIlI2D8pGTZ0YUIqHEqYxiA1gQ2K
	y7FEU5XsaxBTwOW5Ra2TnAyezOLlKjIjSdg
X-Google-Smtp-Source: AGHT+IG2WKkNsBzn0l6S/CPyAZLEvMX//x7UfaL06y2OabZzFBguGkFhXunt4QIdYTypjMurS8cAfdOTdmUkakmWB30=
X-Received: by 2002:a5d:584f:0:b0:3ca:6a35:13ff with SMTP id
 ffacd0b85a97d-3ca6a351850mr9252251f8f.19.1756344877164; Wed, 27 Aug 2025
 18:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com> <CAP01T751FPiuZv5yBMeHSAmFmywc7L3iY=jYLb992YOp_94pRQ@mail.gmail.com>
 <7a40bdcc-3905-4fa2-beac-c7612becabb7@gmail.com> <CAP01T74vkbS6yszqe4GjECJq=j5-V7ADde7D6wnTfw=zN8zJyw@mail.gmail.com>
 <CAEf4BzZPcawkrrdd2OoKLT-BWzCYsEpNxw52RKa6dL1B=xvdoA@mail.gmail.com>
 <CAP01T74gKna6WrgZvkoBBmwsbhrqrv4azeKwfk=frQasc9eaXQ@mail.gmail.com> <CAEf4BzZadH9NYkYSrgUvZAynBuG=t2TayhFPxzFzbWHsP8HCUw@mail.gmail.com>
In-Reply-To: <CAEf4BzZadH9NYkYSrgUvZAynBuG=t2TayhFPxzFzbWHsP8HCUw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Aug 2025 18:34:26 -0700
X-Gm-Features: Ac12FXwjU8yREJT2U7wlCIATu_XvJCYT4rAYFQo3GEWmdSbh-TljGUX43_FEUUE
Message-ID: <CAADnVQLCg0KAo-uPL+nmYzwRJDcm0W5w_2=0p1PBgi=pUEONLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:33=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> I don't see why we can't consolidate internals of all these async
> callbacks while maintaining a user-facing API that makes most sense
> for each specific case. For task_work (and yes, I think for timers it
> would make more sense as well), we are talking about a single
> conceptual operation: just schedule a callback. So it makes sense to
> have a single kfunc that expresses that.
>
> Having a split into init, set_callback, kick is unnecessary and
> cumbersome.

For timers the split api of init vs start_timer is mandatory,
since it's common usage to start and stop the same timer before
it fires. So the moving init operation (which allocates) and
set_callback operation (that needs a pointer to callback)
out of start/stop is a good thing, since the code that does start/stop
may be far away and in a different file than init/set_callback.
That's how networking stack is written.
Where I screwed things up is when I made bpf_timer_cancel() to also
clear the callback to NULL. Not sure what I was thinking.
The api wasn't modelled by existing kernel timer api, but
by how the networking stack is using timers.
Most of the time the started timer will be cancelled before firing.
bpf_wq just followed bpf_timer api pattern.
But, unlike timers, wq and task_work actually expect the callback
to be called. It's rare to cancel wq/task_work.
So for them the single 'just schedule' kfunc that allocates,
sets callback, and schedules makes sense.
For wq there is no bpf_wq_cancel. So there is a difference already.
It's fine for bpf_timers, bpf_wq, bpf_task_work to have
different set of kfuncs, since the usage pattern is different.

Regarding state machine vs spinlock I think we should see
through this approach with state machine.
And if we convince ourselves that after all reviews it
looks to be bug free, we should try to convert timer/wq
to state machine as well to have a shared logic.
Note irq_work from nmi is mandatory for timers too
regardless of state machine or rqspinlock,
since timers/wq take more locks inside,
We cannot rqspinlock() + hrtimer_start() unconditionally.

