Return-Path: <bpf+bounces-56766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB7A9D760
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 05:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DD77A1CDE
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 03:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA531E1A3F;
	Sat, 26 Apr 2025 03:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrwJWZor"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DBE1401B;
	Sat, 26 Apr 2025 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745637794; cv=none; b=eBRxpEURw2a+kEJphX6UTIxx0zK01c7s9QSfP8a+VtyTW/lZXpVe5bn0ngggrgW8z9CuQPJsXuvUuCBFLMJsnAeGDRjIgtZfoj0kEEh62Li/9nMVtzytKK2Mg+Kzs+11F1+8FzbtDKOjfaHZ3cQY894ZT0n6VAoOSzcWEC7Nq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745637794; c=relaxed/simple;
	bh=OorEA4yKuv/EjmOfpY+5Jkej5ZMDx4tSaJq+Ih54/fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnZoWw2hJt2QId5P9ioU1155m8hCF0m/oEmGP6TQRgF+/SFFWc6SXSz+irfBZGlD/jO9r2lVkpiXLrw+F4kcfktsWyATbk42v6BwCOliIciKa5UXSzcNxEhNSyCQ8Q+Rw0RtLmGgocnM5E4EFPEeWmr+yRKFUi/9/zQBqgeZgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrwJWZor; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ac9aea656so3299921f8f.3;
        Fri, 25 Apr 2025 20:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745637791; x=1746242591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZ1xXxsW4NeRP98ef78rJYFaU6MaDAYecnV4YcmJ8Kk=;
        b=RrwJWZorpJu3NRtAetWvJVOUPwLfi9AtPf9MgyhMOyJvV00JZYLQpapIA0j9DNn7Tj
         UboG1FzJC0julG/rHM/daQyvNjqyHl19rTl28q2+9PySqgIJKayXD2aXVAkaQ8Cuicmj
         j0LgtW7uSOL+TKtCRqLnQ4S4i4KcXCawdYt7Y670M0yUe0JowISSZTiuX246TsfEMJzo
         aUMiZVHjsM489rnUQ0nIakgAFbRRneYuWqYUl52xnNe/KqA681NV9WrmZzG78QBN3s7d
         yx7QBz/lAVDWY1TeXDtYIV72yH9VhmVK3y2MAYCdjeivv4I9t3krJrWykDtDhwYSdmzq
         jaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745637791; x=1746242591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZ1xXxsW4NeRP98ef78rJYFaU6MaDAYecnV4YcmJ8Kk=;
        b=tpTVDR2xbOhGy8yiZ0QzzRBcFQvboIao8HOl+6WGMdivXQ0Gr/wquaHrpjCAjvjvoB
         vL4XawcSPggwDbO604bV34w+KBlw6tLvVp6xg/k6f14Qc50koHSMSKo/IOzGBuO/9u+Z
         7mb5kqyG1sZAh+Igucz2CJRBjxdHIHxw19suzTSsCLfPJprJWKVwUGT1BJCbZ4qYFhGo
         B7qmqyI7Dge39MY5LrZNXkJoVbZKYGXFdarCXwYWdYfaOl1N+hW2gOLkCLV/V8ZsOH10
         83awlk1Fd75No3sac1tlaXdTUgAvFROnN+uUNK8SXKRNZbpu0il7kzX+7LyOGKEO8xNu
         F4CA==
X-Forwarded-Encrypted: i=1; AJvYcCW1uo0+HTZkGjc/uMs9dcGjcq7SjYAQXGbwElKamqRSeTR/LXDY3DQcG9pVtXzL3uk6WWV7ipV0UY3myMq9BPry69/6@vger.kernel.org, AJvYcCWna5xgHw3izBMnaPyN4evQVhhvWFGa+02fybhg3Y606dbYdxY+FkgiCi5w0VCmUSF1k5OLRxgf59G5zUze@vger.kernel.org, AJvYcCXesNECBz4dPO7UGyuoPvCFxhMvA/x8K06heN6SOTIogVHOlrFJdVu3L3XD3JxJKlPadSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2uzW0jy3jCwP5pnm/E/aJHOfCXi6a0YQRHItZid/2u67aFPkA
	eVzPmtAi09F5OSlXrH/43WrwTS9Y90a21keXD7CbZUcyppipz4UMDrBZxc7+4T0VNMNO5tHIWMl
	VYkWPOgmvy3kXyhXRWuf8nKTx/a2l7BBf
X-Gm-Gg: ASbGnctQ+112yoUwlz89husszQndFCT70AmyqgwY0LH6ORABCUIkntIUu8jJl40cM42
	DH+zSFg4jjrXEHr/3x55da8YPu9K8iecSMmzL2TxMg6RkDuFH3ouf7DvNp0wN2cJKUUG6f1Z8ac
	cIOKHhE31xYVVlUNl3QZYYywFqRoky5MsA2QbHhQ==
X-Google-Smtp-Source: AGHT+IE3PHs6T3Jl0OrQH8KbLUj7MwKUzcPm7sefhDzp+dbq+GIago6Zs/rMPPxt/P4f8JZzpV/Z6+OX9kU2Fam6YaQ=
X-Received: by 2002:a05:6000:178a:b0:390:f4f9:8396 with SMTP id
 ffacd0b85a97d-3a074e4217dmr2985232f8f.28.1745637791026; Fri, 25 Apr 2025
 20:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425204120.639530125@goodmis.org> <20250425204313.784243618@goodmis.org>
 <202504251558.AA50716@keescook>
In-Reply-To: <202504251558.AA50716@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Apr 2025 20:22:59 -0700
X-Gm-Features: ATxdqUFNS03Ls-N5iHekEa4uNfOcUuKuOiG1gTLIFRDPQEpj5XX7j71ddsDqBts
Message-ID: <CAADnVQKdWSuDm52GmNor75rFZGNBLcoCto3oecA3D3QHD_MyCQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] treewide: Have the task->flags & PF_KTHREAD
 check use the helper functions
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, 
	X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 4:10=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Apr 25, 2025 at 04:41:22PM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> >
> > Getting the check if a task is a kernel thread or a user thread can be
> > error prone as it's not easy to see the difference.
> >
> >       if (!(task->flags & PF_KTHREAD))
> >
> > Is not immediately obvious that it's checking for a user thread.
> >
> >       if (is_user_thread(task))
> >
> > Is much easier to review, as it is obvious that it is checking if the t=
ask
> > is a user thread.
> >
> > Using a coccinelle script, convert these checks over to using either
> > is_user_thread() or is_kernel_thread().
> >
> >   $ cat kthread.cocci
> >   @@
> >   identifier task;
> >   @@
> >   -   !(task->flags & PF_KTHREAD)
> >   +   is_user_thread(task)
> >   @@
> >   identifier task;
> >   @@
> >   -   (task->flags & PF_KTHREAD) =3D=3D 0
> >   +   is_user_thread(task)
> >   @@
> >   identifier task;
> >   @@
> >   -   (task->flags & PF_KTHREAD) !=3D 0
> >   +   is_kernel_thread(task)
> >   @@
> >   identifier task;
> >   @@
> >   -   task->flags & PF_KTHREAD
> >   +   is_kernel_thread(task)
> >
> >   $ spatch --dir --include-headers kthread.cocci . > /tmp/t.patch
> >   $ patch -p1 < /tmp/t.patch
> >
> > Make sure to undo the conversion of the helper functions themselves!
> >
> >   $ git show include/linux/sched.h | patch -p1 -R
>
> FYI, the "file in" test can be helpful. I use it to exclude tools and
> samples regularly, and *I think* it would work for excluding individual
> files too:
>
> @name_of_rule depends !(file in "tools") && !(file in "samples")@
>
> I've been collecting random notes like this here:
>
> https://github.com/kees/kernel-tools/tree/trunk/coccinelle
>
> >  tools/sched_ext/scx_central.bpf.c          |  2 +-
> >  tools/sched_ext/scx_flatcg.bpf.c           |  2 +-
> >  tools/sched_ext/scx_qmap.bpf.c             |  2 +-
>
> I think these are fine. The Makefile is pulling in standard kbuild
> Makefiles, so I think the correct include directories (outside of
> tools/) are being used.

I suspect they are not fine.
I don't think they #include linux/sched.h
I would drop them for now.

Tejun,
please double check.

