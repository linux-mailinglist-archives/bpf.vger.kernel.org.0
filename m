Return-Path: <bpf+bounces-33792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989FB926810
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D601F214E4
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183F187570;
	Wed,  3 Jul 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPy1mGIf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96E17F511;
	Wed,  3 Jul 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031104; cv=none; b=oBflgnDa6RY9Wt6IKrj1pM3EHEIQN55bMnzKPSFDDPgrLW+a/LxvR3Ko78cWxDN0qZIitt0Dxinwn37w0r74rdwe/0dyZFUApS4L4eStuiuiXPQqwjH2WTAIcxcorI3hr9FlAXVUPqjrPJxqd8qI0j5WFWs+3MAVqIFN8xM5Ieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031104; c=relaxed/simple;
	bh=Zf8YUxcGRUbLSJgWXia4yC8kqQfNw8U1S+iQ2tT1pQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpR40B0qL6wR1WJkQ6vwFdhmZr1U8+/9U4N4Lhit/DINf6DqRk8T7qy9gTfMUj1EVK3xf04vxuxsTmxg7n6ghmsqw2nwDbL82XJH1bemOLSo6s0830KTAI/Zi5r7WgPxSiRnTP4+oNuK4vohopt6ZqtmW3tbpvgEXRkFB4rzdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPy1mGIf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-713fa1aea36so2501838a12.1;
        Wed, 03 Jul 2024 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720031102; x=1720635902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DneYV0IYWuK4OodqDNO4Eog7C54F1unFAEgI5t+RVAg=;
        b=VPy1mGIfdc4Y/uNL3dXJz/Ss8dM3SlYlT9tvPkAbYWmDO1AldmaAPaqe8p3q7F44pV
         OpBxrg/ciI9RixdJtHYJoAhVz3S8C735yizInqkXlrS07b0kwOMrtEvHZUEASb8rR+wO
         fCSgwesTeuofkzd4kURR9zMHVjtIO9kQJRzCxlP2hMthg9f5+rbtznj0tTv0AKstD/+P
         ywrnYiKEwny07VS7dSvdzTDOJDbselEoep1RJdoVsZSNf0EGZg6/4mu9folCgGS+34Xi
         bNYuu3TuAZP5AuHV2x9tXh6q8GPa2dhVVq3AyLlMuMfH1Hu2W10808f/2RP3MH6NwBCb
         zGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720031102; x=1720635902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DneYV0IYWuK4OodqDNO4Eog7C54F1unFAEgI5t+RVAg=;
        b=X56/2x8rXtWjhiEFx2UYABA24P6Hv9jB4Yzx/TuvyFm56FyHmRwDxG/aaezCZroDuG
         psfdyLY9zpdt2joKLd69S+FNe2ThFy99s+s5LKZfWremBT0g0nNHO7rfdRVubh0OnbUS
         bqnh5u4GhKcV9LBbIWEiIzCWAEJ9KtZs60I21izpANLpwGMXqrgfbj3gIMBawTeREXZZ
         RZToauR+67i7anNB7UAe4zVCbPo7Mw3hFkUury8AqGo2Pg46ykQstBUu2jyTaGSOPcbU
         06xPrrT+a5qpbAa9vtc83FCm6PT7cuvriNl3r5oY/UOgraw3HripDaX0Excbm+VhnqIS
         dgrA==
X-Forwarded-Encrypted: i=1; AJvYcCX89bpuX16Ly9LmPFdBxlGkKGXVLJBQ2cKM4gdxDT7DFs0ZBRzdE/0VuzamJCYLUiavzp7BWyKFEiR33gNNl/GeB0CJiKi9HUHNBgKr8p7V/7KtJqskKnRbhS8hjfmtYNHtpTTc3sZ4
X-Gm-Message-State: AOJu0YwYC8PSsYauLaBTK2nqQenK5OFJNkexKB4P5mWwlLv368uDjmLU
	hNLAqngkfMzk9wd9th1EdhF+gGZLrYyePc5zrlGThsIw1vX3FZidWCgOCkbCFner+UHsOxXLxzQ
	kgq+plgoy4605xBuJBUJfooQ9D0k=
X-Google-Smtp-Source: AGHT+IF1Bnr6wKhM+3Q+PCLTWBY7tdLJD8dzNz4vkiz7LKvD39724Uw0+w9oa/UiPTFXG8Ml4Wua24R2dWaecyXfXJk=
X-Received: by 2002:a05:6a21:7885:b0:1be:e4dd:17a1 with SMTP id
 adf61e73a8af0-1bef611ba18mr13061255637.5.1720031101861; Wed, 03 Jul 2024
 11:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-2-andrii@kernel.org>
 <20240703113829.GA28444@redhat.com>
In-Reply-To: <20240703113829.GA28444@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 11:24:49 -0700
Message-ID: <CAEf4BzbuTUU=95_Ou0vFUmt=u6M8KAgdm1pdVsthAZYb2nGpMQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] uprobes: update outdated comment
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:40=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Sorry for the late reply. I'll try to read this version/discussion
> when I have time... yes, I have already promised this before, sorry :/
>
> On 07/01, Andrii Nakryiko wrote:
> >
> > There is no task_struct passed into get_user_pages_remote() anymore,
> > drop the parts of comment mentioning NULL tsk, it's just confusing at
> > this point.
>
> Agreed.
>
> > @@ -2030,10 +2030,8 @@ static int is_trap_at_addr(struct mm_struct *mm,=
 unsigned long vaddr)
> >               goto out;
> >
> >       /*
> > -      * The NULL 'tsk' here ensures that any faults that occur here
> > -      * will not be accounted to the task.  'mm' *is* current->mm,
> > -      * but we treat this as a 'remote' access since it is
> > -      * essentially a kernel access to the memory.
> > +      * 'mm' *is* current->mm, but we treat this as a 'remote' access =
since
> > +      * it is essentially a kernel access to the memory.
> >        */
> >       result =3D get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page,=
 NULL);
>
> OK, this makes it less confusing, so
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
>
> ---------------------------------------------------------------------
> but it still looks confusing to me. This code used to pass tsk =3D NULL
> only to avoid tsk->maj/min_flt++ in faultin_page().
>
> But today mm_account_fault() increments these counters without checking
> FAULT_FLAG_REMOTE, mm =3D=3D current->mm, so it seems it would be better =
to
> just use get_user_pages() and remove this comment?

I don't know, it was a drive-by cleanup which I'm starting to regret alread=
y :)

>
> Oleg.
>

