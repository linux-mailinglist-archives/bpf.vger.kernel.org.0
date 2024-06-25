Return-Path: <bpf+bounces-33004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70569915D12
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 04:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4F02828F8
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 02:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121D770F8;
	Tue, 25 Jun 2024 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW85Wt2y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F336CDBA;
	Tue, 25 Jun 2024 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719284008; cv=none; b=pxm4+LSnyqJ6ASjCdFvXs4OJPjGUVyXUgcoAvQSTwI0JasHSfpISqODSWqnFRzwuIe+t06uK1Oo/D7A3YPBMYj94aVEU3iNPyBwGOqLKZ9UkRYh6Zkq0r1fBT49FQC8rnxeFLzmk6E/c6BFkZaKAkH9rzgxPygxVUwHuOaEFb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719284008; c=relaxed/simple;
	bh=4ctsB64TjeAHYT6A5ga0eengrAz6yVkTwMZJwIrPvys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXXDEvVi0khxZ1TWiYNJTPti3gFuXW61HVbOG2L63UpP+7BbMttykiPmbDhK8YWjWwhP1dg2o/F28MG7UvdRYDs3VQtbS/vMwW0VM5b0e80pSTT+//mvzzcfpjsBQe3EYaNrNw+r3jiqKsJ2cLVSYWO5XUkjBaAxs4VYbdCRQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW85Wt2y; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c722e54db8so3897370a91.2;
        Mon, 24 Jun 2024 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719284006; x=1719888806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uV4t+w32GLoyq5UQG9yphsh92JGonRXBYrmNqhwTfo=;
        b=OW85Wt2yGMVCcrbsn/hl9c7YSEBE88IAsu3gi0lN9+xUntZKgni2hdV4QsVjukWMjv
         J/H1PVZGTOFVb2oAW9e0pttcK5/xnFZHGXymXQp1Q4CuH7lG0rTxkbzRMk/Rmwl+6QbS
         HZBhJxRTLfOcBubeVUIhUBQObicAunm1FofrcKjg1ERRkV8mQNwjIGBeehiD21qEit5r
         3CqQhRVy9yWWFkQCctZ4tbOHBHl/bfpWGx0p04VuCG/A29zzpS+qWJJSzUFxhuN2sf9G
         Gs9GzkWlM4spXv1dIM8+kKGAKZmKShJUMtsNMjxeytqISeVAolguAOD9amgqe9euv9V2
         Wy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719284006; x=1719888806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uV4t+w32GLoyq5UQG9yphsh92JGonRXBYrmNqhwTfo=;
        b=jUkTZA946ckhyIQ9/UjTa9Uf8UpN587+fbsoajY7DelH2wd2rETkJNZguSEaWEeOpj
         GD6TQV3wy0rqCzunwLlUMa5H5/Yu3iCvq73sHoxk08doJrXsxtTQHeY2xsqnY3wZ/7gJ
         lvPtXsaBCg70/bS9/IRY9CBsRNiM7PCFxzDQS+3FrPynTcrLY+R7Xz8/jNDZrmhBz4II
         wkpLuM0F8EC8ProPJgid6QQ7Wqn/LsoCpQqFlHgpaLGqnHpwZWtWuTxT6n+eAMMyehX6
         y5LQpx29Gwr3HNguK3tze6HcI5nfQ9m8Vju7SI16HkWn+kow9PYuptyR+hLW0wIeG+Lj
         1h+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqb4J8UxhPhJmvHXx77QDw7nhQMDrbbip4MD79ndMVG/1vDruef0duapU8e+h8hpe2whDP3vc4n+/E8oP7EPi9c+5rK1gQJVghr0eqrGrwliubW4U4GK/EFP4lQBw0zfJXLiRwnFoCO/MdH07mnoznVV88DR+zdTExBpyTjZCVJF0KkK+YVx8t4A==
X-Gm-Message-State: AOJu0YwbWZKbLatP2S1DaE6bHeMELgCSlBdA2D86OL/UZwXoFnysH5ZY
	fVad6ijTMNbacUKYaw2YdagphAzCt3HGSHyB0THQs5xe5b/jInwXogT3lHxtn5LMwilKHqtXTru
	BmW2vAsl8hclCHWi+bti24rSge4c=
X-Google-Smtp-Source: AGHT+IG5eCNdsYEwOrns65apGYwDqCAOPSmA8xBZ+2KbBP+jS3lsN0qs8xVaHdVZhhOUX0BPQdxplR4ioJ2npO+TVxs=
X-Received: by 2002:a17:90b:218e:b0:2c8:647:35c with SMTP id
 98e67ed59e1d1-2c861409a36mr5549258a91.29.1719284006202; Mon, 24 Jun 2024
 19:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522013845.1631305-1-andrii@kernel.org> <20240522013845.1631305-5-andrii@kernel.org>
 <20240625101446.9dd0f4767392462e9923f0ba@kernel.org>
In-Reply-To: <20240625101446.9dd0f4767392462e9923f0ba@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Jun 2024 19:53:14 -0700
Message-ID: <CAEf4BzbTuZZUKGDbONQHH9PhvJi0TQD=piKUYTzpnOz9gewtMw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selftests/bpf: add test validating
 uprobe/uretprobe stack traces
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, x86@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:14=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 21 May 2024 18:38:45 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Add a set of tests to validate that stack traces captured from or in th=
e
> > presence of active uprobes and uretprobes are valid and complete.
> >
> > For this we use BPF program that are installed either on entry or exit
> > of user function, plus deep-nested USDT. One of target funtions
> > (target_1) is recursive to generate two different entries in the stack
> > trace for the same uprobe/uretprobe, testing potential edge conditions.
> >
> > Without fixes in this patch set, we get something like this for one of
> > the scenarios:
> >
> >  caller: 0x758fff - 0x7595ab
> >  target_1: 0x758fd5 - 0x758fff
> >  target_2: 0x758fca - 0x758fd5
> >  target_3: 0x758fbf - 0x758fca
> >  target_4: 0x758fb3 - 0x758fbf
> >  ENTRY #0: 0x758fb3 (in target_4)
> >  ENTRY #1: 0x758fd3 (in target_2)
> >  ENTRY #2: 0x758ffd (in target_1)
> >  ENTRY #3: 0x7fffffffe000
> >  ENTRY #4: 0x7fffffffe000
> >  ENTRY #5: 0x6f8f39
> >  ENTRY #6: 0x6fa6f0
> >  ENTRY #7: 0x7f403f229590
> >
> > Entry #3 and #4 (0x7fffffffe000) are uretprobe trampoline addresses
> > which obscure actual target_1 and another target_1 invocations. Also
> > note that between entry #0 and entry #1 we are missing an entry for
> > target_3, which is fixed in patch #2.
>
> Please avoid using `patch #2` because after commit, this means nothing.

Yep, makes sense, sorry about that, will keep descriptions a bit more
general going forward.

>
> Thank you,
>
> >
> > With all the fixes, we get desired full stack traces:
> >
> >  caller: 0x758fff - 0x7595ab
> >  target_1: 0x758fd5 - 0x758fff
> >  target_2: 0x758fca - 0x758fd5
> >  target_3: 0x758fbf - 0x758fca
> >  target_4: 0x758fb3 - 0x758fbf
> >  ENTRY #0: 0x758fb7 (in target_4)
> >  ENTRY #1: 0x758fc8 (in target_3)
> >  ENTRY #2: 0x758fd3 (in target_2)
> >  ENTRY #3: 0x758ffd (in target_1)
> >  ENTRY #4: 0x758ff3 (in target_1)
> >  ENTRY #5: 0x75922c (in caller)
> >  ENTRY #6: 0x6f8f39
> >  ENTRY #7: 0x6fa6f0
> >  ENTRY #8: 0x7f986adc4cd0
> >
> > Now there is a logical and complete sequence of function calls.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../bpf/prog_tests/uretprobe_stack.c          | 186 ++++++++++++++++++
> >  .../selftests/bpf/progs/uretprobe_stack.c     |  96 +++++++++
> >  2 files changed, 282 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uretprobe_st=
ack.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uretprobe_stack.c
> >

[...]

