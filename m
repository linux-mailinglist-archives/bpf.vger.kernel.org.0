Return-Path: <bpf+bounces-42002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80D99E35F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BBB1F23F41
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5EC1E379E;
	Tue, 15 Oct 2024 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6lwJAi9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F51B85DB
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986747; cv=none; b=kjuIMUnuTN8U1uvL48QmfSGIDXQVcOrRX7Os9BUUQzCW1GhF2bm2DIZv8yBfWDsf0NaJCIEr3h+E9YaBRTSrg28CEExuBWoFgFHocDvyl6N8zLdCAv1R06JITRgjkNobefKu6QJoU2QQnoFwXeVITGoByTvFVl+TKqfuqSOEP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986747; c=relaxed/simple;
	bh=BPsnlM4jiS7NsX7J2NdZKdPrFoWf/4f2HMA3nR+Yv3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkHeXQxjtnTPas7OTUxbaPILdkJniZ9Q4inPcnFaScfaiLAzuyczOmDcshlSULGSm1+a7AIjXjf/hSbseWDfH3kr355dMJxo7JPhhd3UQoBnQ0nlo7BE/Mp58v+tWjN6OBiu8PgmgTEAdZznzJIWSoozpVagZShvAVKDNBR3wDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V6lwJAi9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e31af47681so2144611a91.2
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728986743; x=1729591543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qrkg/ZRV10IdU56/7mYKjiH6Upw8Qx1eT1zUM9r+QU=;
        b=V6lwJAi9ATBprSXBlwBEAF/EGPX0fGKWZ5th8Gob+kRbtYG9mJs2uKI9PkK7Y0NN+H
         mUhOao3UYL2oE5vUuQFyLVjiUeGDpPeeEKqiSioPCd8IqttXBZtZSjFlFvbO7wZ+Oati
         NxNyw+6EhjvGJGDLKIN35YUJ6mQXyqkkmFlNAcszDk7mFsg3mLDB0ACbWEtav9EFsVik
         XxN5Su2yG0Rvi//ID9/qiV+AAqgCl2H9BTAP7b5NXKALPLLJfjUmg4dHl9szGAJUl9pw
         N/PcITj00ryexU6JjyWFleZzQYpxfQvcsx/9PlBcG1PgcB+LfV4ieboFg9rkyBAylrZV
         VStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728986743; x=1729591543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Qrkg/ZRV10IdU56/7mYKjiH6Upw8Qx1eT1zUM9r+QU=;
        b=VhZ9bInbzcoFwl/jzP/QPQmbU50bszJ5NOo643Rx6HuFRiU0DMHAVToZYsDS93n/89
         /JLLiiBjxbuY4LlQOpmZ6ZwGWDHLTW5rQKTwbAXErDb6DR0aTq9p+RO7fDp+5eXHH0SJ
         6eOnmXzElNlZYJ2cN+PEoNgkhlRfvGABuhbYuh3lyNv3ge7nEPqAjmYTa8C/1NLgDOdN
         mT0PvANXYOSaVYTWvqpR4dT0BGcnpsSHtSzSjvGBbRl9h9VoNNi0Zoy5NIFzoPHgxNCq
         zHMXTF8omPYFXVBcC/Y8wkPm0FviL+5bNeEcUqGNHteD4vqDn15uRsCa6fRDsPnnwrGF
         TaJw==
X-Forwarded-Encrypted: i=1; AJvYcCWe2FNR8HYplVFBx5i+gy8YQxLtBkGTV8wZyfQrVKf2LvwcStUDfG+4dkmfouD3olJsEEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGjiBXIkXwZq6MIGoOYsVuVSjN5Cak3YZfS43daBrld3WTkP9
	I+H92X74IxnieRmOxKpRZCwdKyGcVtAe5WcpVLaF2Iw9OSu70CxlLYDHoYYhV7r7B6oFDXeDTeT
	08ZMTaf4Gk5A+YhCguNtrb0AONdYDd6VU/iaI
X-Google-Smtp-Source: AGHT+IHbXOGzJCKOgpup02dkaO5xVaIhqtf9TGZtn/M5v/vKmEv8ALqVeLPqkRz25CJYOQrboeLU0AvZT7KH0o5zi68=
X-Received: by 2002:a17:90a:ee85:b0:2e2:e8fc:e0dd with SMTP id
 98e67ed59e1d1-2e2f0dc33f8mr15829263a91.35.1728986742588; Tue, 15 Oct 2024
 03:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67094369.050a0220.4cbc0.000d.GAE@google.com> <20241011120028.1e4ed71c@gandalf.local.home>
In-Reply-To: <20241011120028.1e4ed71c@gandalf.local.home>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 15 Oct 2024 12:05:29 +0200
Message-ID: <CANp29Y4KERQxwOwMCW5a4+YahhA8gWyJ=btE=OxnNgrF6puFgw@mail.gmail.com>
Subject: Re: [syzbot] Monthly trace report (Oct 2024)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Thanks for the analysis!

On Fri, Oct 11, 2024 at 6:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 11 Oct 2024 08:25:29 -0700
> syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com> wrote:
>
> > Hello trace maintainers/developers,
> >
> > This is a 31-day syzbot report for the trace subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/trace
> >
> > During the period, 1 new issues were detected and 0 were fixed.
> > In total, 10 issues are still open and 38 have been fixed so far.
> >
> > Some of the still happening issues:
> >
> > Ref Crashes Repro Title
> > <1> 34      Yes   INFO: task hung in blk_trace_ioctl (4)
> >                   https://syzkaller.appspot.com/bug?extid=3Ded812ed4614=
71ab17a0c
>
> If you check the maintainers file, blktrace.c has:
>
> BLOCK LAYER
> M:      Jens Axboe <axboe@kernel.dk>
> L:      linux-block@vger.kernel.org

Judging by MAINTAINERS and ./scripts/get_maintainer.pl,
kernel/trace/blktrace.c belongs to both "BLOCK LAYER" and "TRACING".

$ ./scripts/get_maintainer.pl kernel/trace/blktrace.c
< ... >
linux-block@vger.kernel.org (open list:BLOCK LAYER)
linux-kernel@vger.kernel.org (open list:TRACING)


>
>
>
> > <2> 32      Yes   WARNING in bpf_get_stack_raw_tp
> >                   https://syzkaller.appspot.com/bug?extid=3Dce35de20ed6=
652f60652
>
> bpf_trace.c has:
>
> M:      Alexei Starovoitov <ast@kernel.org>
> M:      Daniel Borkmann <daniel@iogearbox.net>
> M:      Andrii Nakryiko <andrii@kernel.org>
> R:      Martin KaFai Lau <martin.lau@linux.dev>
> R:      Eduard Zingerman <eddyz87@gmail.com>
> R:      Song Liu <song@kernel.org>
> R:      Yonghong Song <yonghong.song@linux.dev>
> R:      John Fastabend <john.fastabend@gmail.com>
> R:      KP Singh <kpsingh@kernel.org>
> R:      Stanislav Fomichev <sdf@fomichev.me>
> R:      Hao Luo <haoluo@google.com>
> R:      Jiri Olsa <jolsa@kernel.org>
> L:      bpf@vger.kernel.org

Same for kernel/trace/bpf_trace.c:

$ ./scripts/get_maintainer.pl kernel/trace/bpf_trace.c
< ... >
Matt Bobrowski <mattbobrowski@google.com> (maintainer:BPF [SECURITY &
LSM] (Security Audit and Enforc...)
Steven Rostedt <rostedt@goodmis.org> (maintainer:TRACING)

>
> > <3> 13      Yes   WARNING in get_probe_ref
> >                   https://syzkaller.appspot.com/bug?extid=3D8672dcb9d10=
011c0a160
> > <4> 6       Yes   INFO: task hung in blk_trace_remove (2)
> >                   https://syzkaller.appspot.com/bug?extid=3D2373f6be3e6=
de4f92562
> > <5> 4       Yes   possible deadlock in __mod_timer (4)
> >                   https://syzkaller.appspot.com/bug?extid=3D83a876aef81=
c9a485ae8
>
> None of these look like they are tracing infrastructure related.

Like get_maintainer.pl, syzbot relies on the MAINTAINERS file to
attribute bugs to the individual kernel subsystems. If several ones
are suitable, the bug is assigned several labels at once. It's now
actually the case for all open "trace" findings:

https://syzkaller.appspot.com/upstream/s/trace

(FWIW it's also possible to manually overwrite these labels and remove
specific bugs from the monthly reports).

I could make syzbot set "trace" only if there's no other good
candidate, but I wonder if that could hide the findings in the trace
infrastructure that manifested themselves in some specific traced
subsystem.

--=20
Aleksandr

>
> -- Steve
>
>
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > To disable reminders for individual bugs, reply with the following comm=
and:
> > #syz set <Ref> no-reminders
> >
> > To change bug's subsystems, reply with:
> > #syz set <Ref> subsystems: new-subsystem
> >
> > You may send multiple commands in a single email message.
>

