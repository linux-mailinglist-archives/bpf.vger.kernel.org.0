Return-Path: <bpf+bounces-36401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB84947FD1
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 19:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFE3B21535
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4B515C15C;
	Mon,  5 Aug 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMyr3q2i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697017C64;
	Mon,  5 Aug 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877255; cv=none; b=qmExgLU6LGOGNyyhwn+xJ8dYzXU/aZjjZNlBbt3pes5rf26mSQpqTyKm3ggjE2wo7KsQaQS4oU+6t1a36qBWgc0SHoUUrEwoRXumfRfLsjAPo8BlgPY2xv+f6fENf/RBpl10jsP1Pm/Y2jqozs98mXTETYNqbREmY6PdRm1A4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877255; c=relaxed/simple;
	bh=eobICkOWAmxEBSshtGOfdFcI6tIGCul3FjvhghdxQB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRY4utNMcKo880YMy9SqI7UZxCCJjHU1zkDXon33zVjhfjEAqhpQ3pxV7L13/R9JTCRO65BK/OmdjlC7qQutnY5Vag2iW9wUW7JvEyEWkHz6DgiMuACqF/dJ7DSaBC2q8ekLN6l+T1YHsSMC/cm3unoe0ZMQ8kO8yF9Aa40fg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMyr3q2i; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3686b285969so5583966f8f.0;
        Mon, 05 Aug 2024 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722877252; x=1723482052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpJJPQQZnU216BSgRsWNdhbkOkM5t7BWfA5+QIiHiT8=;
        b=aMyr3q2iVUiTVSzDqqlILHC4McQiFcscG/NpT7JZG6mPoM2xyVxb4Jt67ITcO0yByh
         DyIdXiTZLMTmldqWh0txJUeHZEMBhvWEJ3NPxnp9UuupGf29L4QY8BywKmrmw367VFn7
         4ewhdHVnNk3ALzb0HkYx3mNMV77jrL3mQDOYVE2Orh2agTS9J1k7CCP9sXzXxw6mwHc4
         OHoavajzLD7DE02Ex1qp3zskN4dQngLa8fUDZ3iiVU1yhC45zpTYleIaHF7iUuwFPMIs
         asKw3ivVPVK5hhUHipQxO3N9oT8PSeX5j8wpITYw7+Rkfy+o/oW4pWnF0xZIrz6De62F
         GL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877252; x=1723482052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpJJPQQZnU216BSgRsWNdhbkOkM5t7BWfA5+QIiHiT8=;
        b=dfhdwrXiEYiVrfOE4iUXghWc6W1jJZbl0N+QzQ8PE6Vro+cJ1B1Q+QvuK9jWEe5GnQ
         6LF8P8lHBZ2e8vVMKn9HoHUkw22FvQ/BPXKB7wPwE26UZpxjYbmqAcxrIrJddr6lFl3C
         FzUNvFqm/k6ZjYqgcm+4nvkNVCd6WKwsDqdy9JQvm82m/fwnhPS3Dfa6bxGFH3tniRGf
         oHO4bZTRqJeFIatKdujtvY88TqWoc1BuacbIZLCeAHY8BSjjlPVsupr6l28tYkPIXaca
         5fJHxTwqZb5XzxCRQuwbCTI+31+KUYHECh9hsxlu8dIZdKMvfpcBPUDJcfRbwBkwCC5I
         ymHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW6K6ZjQZZZDPKUI96McPhcrRymJVyPHl0cds4w3xNc9y0IXSBT+jIRn4EvG+04Xbsq7GSzgQKH1Icu6DN1F7K8Mm2JMl5Zm7xMa3F6G5qLdArVaAHgupOG4r+7K9qV/T+
X-Gm-Message-State: AOJu0Yw6Q0GMcHMaeqwCoITG0ILYQjelrAXDrIOlFxJ8DIv4BCL5HrPr
	fRp8T0XdHdoPbCY7TrXMlgWyreNPzVeRxufCVgtc0n2KxBP8AUrU1/I7rrms0sOFUsjClpQUtfc
	Swqc86xTGVeb9ImZLUL5TDTBRTbuVcMUM
X-Google-Smtp-Source: AGHT+IFWplyPstARhl5gl3u38aoCEzsMlxUyARfYMGyFbhVixkH/jCzxuSgqtABCcYHDdSha6uGehcDjpchZVD3nviQ=
X-Received: by 2002:adf:b606:0:b0:366:f469:a8d with SMTP id
 ffacd0b85a97d-36bbc0f3632mr8116378f8f.35.1722877252042; Mon, 05 Aug 2024
 10:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb> <ZrECsnSJWDS7jFUu@krava>
In-Reply-To: <ZrECsnSJWDS7jFUu@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Aug 2024 10:00:40 -0700
Message-ID: <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Artem Savkov <asavkov@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 9:50=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Aug 05, 2024 at 11:20:11AM +0200, Juri Lelli wrote:
>
> SNIP
>
> > [  154.566882] BUG: kernel NULL pointer dereference, address: 000000000=
000040c
> > [  154.573844] #PF: supervisor read access in kernel mode
> > [  154.578982] #PF: error_code(0x0000) - not-present page
> > [  154.584122] PGD 146fff067 P4D 146fff067 PUD 10fc00067 PMD 0
> > [  154.589780] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [  154.594659] CPU: 28 UID: 0 PID: 2234 Comm: thread0-13 Kdump: loaded =
Not tainted 6.11.0-rc1 #8
> > [  154.603179] Hardware name: Dell Inc. PowerEdge R740/04FC42, BIOS 2.1=
0.2 02/24/2021
> > [  154.610744] RIP: 0010:bpf_prog_ec8173ca2868eb50_handle__sched_pi_set=
prio+0x22/0xd7
> > [  154.618310] Code: cc cc cc cc cc cc cc cc 0f 1f 44 00 00 66 90 55 48=
 89 e5 48 81 ec 30 00 00 00 53 41 55 41 56 48 89 fb 4c 8b 6b 00 4c 8b 73 08=
 <41> 8b be 0c 04 00 00 48 83 ff 06 0f 85 9b 00 00 00 41 8b be c0 09
> > [  154.637052] RSP: 0018:ffffabac60aebbc0 EFLAGS: 00010086
> > [  154.642278] RAX: ffffffffc03fba5c RBX: ffffabac60aebc28 RCX: 0000000=
00000001f
> > [  154.649411] RDX: ffff95a90b4e4180 RSI: ffffabac4e639048 RDI: ffffaba=
c60aebc28
> > [  154.656544] RBP: ffffabac60aebc08 R08: 00000023fce7674a R09: ffff95a=
91d85af38
> > [  154.663674] R10: ffff95a91d85a0c0 R11: 000000003357e518 R12: 0000000=
000000000
> > [  154.670807] R13: ffff95a90b4e4180 R14: 0000000000000000 R15: 0000000=
000000001
> > [  154.677939] FS:  00007ffa6d600640(0000) GS:ffff95c01bf00000(0000) kn=
lGS:0000000000000000
> > [  154.686026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  154.691769] CR2: 000000000000040c CR3: 000000014b9f2005 CR4: 0000000=
0007706f0
> > [  154.698903] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [  154.706035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [  154.713168] PKRU: 55555554
> > [  154.715879] Call Trace:
> > [  154.718332]  <TASK>
> > [  154.720439]  ? __die+0x20/0x70
> > [  154.723498]  ? page_fault_oops+0x75/0x170
> > [  154.727508]  ? sysvec_irq_work+0xb/0x90
> > [  154.731348]  ? exc_page_fault+0x64/0x140
> > [  154.735275]  ? asm_exc_page_fault+0x22/0x30
> > [  154.739461]  ? 0xffffffffc03fba5c
> > [  154.742780]  ? bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x=
22/0xd7
>
> hi,
> reproduced.. AFAICS looks like the bpf program somehow lost the booster !=
=3D NULL
> check and just load the policy field without it and crash when booster is=
 rubbish
>
> int handle__sched_pi_setprio(u64 * ctx):
> ; int handle__sched_pi_setprio(u64 *ctx)
>    0: (bf) r6 =3D r1
> ; struct task_struct *boosted =3D (void *) ctx[0];
>    1: (79) r7 =3D *(u64 *)(r6 +0)
> ; struct task_struct *booster =3D (void *) ctx[1];
>    2: (79) r8 =3D *(u64 *)(r6 +8)
> ; if (booster->policy !=3D SCHED_DEADLINE)
>
> curious why the check disappeared, because object file has it, so I guess=
 verifier
> took it out for some reason, will check

Juri,

Thanks for flagging!

Jiri,

the verifier removes the check because it assumes that pointers
passed by the kernel into tracepoint are valid and trusted.
In this case:
        trace_sched_pi_setprio(p, pi_task);

pi_task can be NULL.

We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NULL
by default, since it will break a bunch of progs.
Instead we can annotate this tracepoint arg as __nullable and
teach the verifier to recognize such special arguments of tracepoints.

Let's think how to workaround such verifier eagerness to remove !=3D null c=
heck.

