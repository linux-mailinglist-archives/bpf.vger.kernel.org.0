Return-Path: <bpf+bounces-66863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EAAB3A739
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 19:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D963B9699
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4B334726;
	Thu, 28 Aug 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHy1gRuT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE503314B9
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400444; cv=none; b=Jn3KceVoLhJu3oJBSvJdVjCLSiFpycFI7tNJ/W3LsqsOBXW/paGg9Cwb8h9d7E8XHKOzHfMt0NcJ9nL/JjfkXkUIt4V7hDUiAStoB4NaKwgVkfxBfkQvLHQFK1lkADP80VPwxvZUljCroC0+ga1/+Srsu6RXt9z44510/e3c+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400444; c=relaxed/simple;
	bh=6k2wz0cgZke0WYw25LjiWEOnhSt6CDhaLywzgayvjqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2DQylUg4NxP3c6u1ngDX+oXz3QzzDzKzVJkSu0i8niCNr5JCJHvol6x23t3l2bkvxRldMO2jCEuYCcjKK5+A6bHZj0plWF9aoBXY2KF3fRyXyfS9fZ2BRLtk6ZYbDyO4h0ZTehOunQogzu0TkXuJvshPtxejNFoXN8iMbetSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHy1gRuT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3277c603b83so712874a91.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756400442; x=1757005242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k2wz0cgZke0WYw25LjiWEOnhSt6CDhaLywzgayvjqk=;
        b=kHy1gRuTYUseeLGBQaonpnvDjxJahmXiZg8c0oCCT4qJB8hZJ2nLJEg8ZuLsxXg4BO
         Q/cVx2lE4kE916mW/Dvezk39PdDUmgMQ6y4fb5FvdwieImlk/5E3Fd6fiAtWaNA82gbj
         VngKgoT2uvuLet0omF1w/96X+2eSNMKG8DQar/mbRzYCi/Hu+tKKUx+y+kjkM9Vje5XJ
         2Uwc8tub/XEabqJgiddqR8Ydg/E5k5rFVYZNikVxEf10cOQXsH6gespLuFjhtlDVaYm+
         8h6MSTbnjxPuRqRpuDTQaTIaaGudQXgyd2Kbl9topZ2T/8amYFXR4dkn5GDnhPFe6FaP
         +6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400442; x=1757005242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k2wz0cgZke0WYw25LjiWEOnhSt6CDhaLywzgayvjqk=;
        b=CPxNCVeEr9XVnCaYILXCqB5ZZJ/QWOjHeeiAx6rK6b4Craijo0FjKwOq6ahhPh9jDO
         2XPFCCPVrGhVy9bGmlNdEIYwAWkEpiklATdVEZnhJs+xa/zuHCFehBUFr/ATtuadg3ZD
         DyGB/jkHrEVdiMl6tYXxBYsdlBsH97DhxyV9cKy7FzuQskGkD2tFdurLjB3U9cPnIffB
         H7SSceVGy+xShYSzFRaLxdMcgIqaZLwYUvOBHeMzRgTpoExcpEnQ5fxFc3qXBrrySxZQ
         whNpmyaoYOZNwK9/NEZgSQHY3wK+B4Xo2aijkGgq+xkUVf70OgMPE10SFVGyvEvHIn11
         Xtkw==
X-Forwarded-Encrypted: i=1; AJvYcCUjqYIYwcfQqN7RI40MwWKhd/s5dWiaQBw48+sdo3jS/ac+EwboOmrl/C/AEVu5GxzE/DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGEmo2k2KCXpXmZ4DaCc/tfK5dimxBj7lxHlNWxctghCIgIm10
	+IAUOakSI4d5mZ3ophwAzOl+1sX8ZqcN4tdx7LAL6uyZpe3dV48kQoyij+JPH+QiL41tyM+HRbb
	zQHKxCVdZpc/XCgV1UFUiqV69vKKfUZY=
X-Gm-Gg: ASbGncvsJdtDNsJxiQ/VecWFyYbW8Y9PxkjgvEr/ahd0wInCgaKq/6XcOL6s9KOmbUq
	G2S8A2eHKddRHDYw85Pe9HtZRmobSRf7MXamt51XEeagnKCHMu712FRIeHWGLxtN2Afbfu9b0Lc
	vpLea/QIvbvxa/6t5VW2bftPf/Tl/KNEoLK4+uYz1iSEoRzcbVx1BUI+YNp4YHT6j481oTSBS7m
	QHZxZ+jRhiIBtLWOXCUeGcNMemGjfBjcRAQZmJzj+U=
X-Google-Smtp-Source: AGHT+IH/UvSdrFoV4a1BmRirQyHoRTqHnNZqpL05x5s5opQqSQzpEEAYR9BKEnaPRTflRlJx+xu5fGdMPKd58XHsR4Y=
X-Received: by 2002:a17:90b:2d06:b0:327:ca0a:67b4 with SMTP id
 98e67ed59e1d1-327ca0a68f1mr2421943a91.12.1756400441491; Thu, 28 Aug 2025
 10:00:41 -0700 (PDT)
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
 <CAP01T74gKna6WrgZvkoBBmwsbhrqrv4azeKwfk=frQasc9eaXQ@mail.gmail.com>
 <CAEf4BzZadH9NYkYSrgUvZAynBuG=t2TayhFPxzFzbWHsP8HCUw@mail.gmail.com> <CAADnVQLCg0KAo-uPL+nmYzwRJDcm0W5w_2=0p1PBgi=pUEONLw@mail.gmail.com>
In-Reply-To: <CAADnVQLCg0KAo-uPL+nmYzwRJDcm0W5w_2=0p1PBgi=pUEONLw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 Aug 2025 10:00:27 -0700
X-Gm-Features: Ac12FXwBjIFETnPaiWZlmM9gBp4HM1V5s9gtUw72oN7rxSlLEVN3unVotb82PSY
Message-ID: <CAEf4BzagzR6xbbMJn7TQaCeP4trgv4wgWM-tUQYrMutRfx+qUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:34=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 20, 2025 at 11:33=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >
> > I don't see why we can't consolidate internals of all these async
> > callbacks while maintaining a user-facing API that makes most sense
> > for each specific case. For task_work (and yes, I think for timers it
> > would make more sense as well), we are talking about a single
> > conceptual operation: just schedule a callback. So it makes sense to
> > have a single kfunc that expresses that.
> >
> > Having a split into init, set_callback, kick is unnecessary and
> > cumbersome.
>
> For timers the split api of init vs start_timer is mandatory,
> since it's common usage to start and stop the same timer before
> it fires. So the moving init operation (which allocates) and
> set_callback operation (that needs a pointer to callback)
> out of start/stop is a good thing, since the code that does start/stop
> may be far away and in a different file than init/set_callback.

Ok, that makes sense, thanks for filling in the context.

> That's how networking stack is written.
> Where I screwed things up is when I made bpf_timer_cancel() to also
> clear the callback to NULL. Not sure what I was thinking.
> The api wasn't modelled by existing kernel timer api, but
> by how the networking stack is using timers.
> Most of the time the started timer will be cancelled before firing.
> bpf_wq just followed bpf_timer api pattern.
> But, unlike timers, wq and task_work actually expect the callback
> to be called. It's rare to cancel wq/task_work.
> So for them the single 'just schedule' kfunc that allocates,
> sets callback, and schedules makes sense.
> For wq there is no bpf_wq_cancel. So there is a difference already.
> It's fine for bpf_timers, bpf_wq, bpf_task_work to have
> different set of kfuncs, since the usage pattern is different.
>

agreed

> Regarding state machine vs spinlock I think we should see
> through this approach with state machine.
> And if we convince ourselves that after all reviews it
> looks to be bug free, we should try to convert timer/wq
> to state machine as well to have a shared logic.

yep, completely agree

> Note irq_work from nmi is mandatory for timers too
> regardless of state machine or rqspinlock,
> since timers/wq take more locks inside,
> We cannot rqspinlock() + hrtimer_start() unconditionally.

Ack. Once we unify all this, we can invest a bit more effort trying to
optimize away the need for irq_work when not under NMI (and maybe not
in irq). For timers this seems more important than for task_work, as
timers can be used significantly more frequently.

But one step at a time, let's wait for Mykyta to come back from
vacation and update the patch set.

