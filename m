Return-Path: <bpf+bounces-71411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E827BF25B7
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EA9A4F7745
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4767B285CA4;
	Mon, 20 Oct 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci+iD7PV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE77277C9A
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977052; cv=none; b=X+YC1QybLHcygG2W/meAlAVIc0NmJfQbX36A3CwHhPIKQEFsnUmKbhndm3X8ofS2BVLEBQ2xqkMAU4rfi31Dk0HaZfql8EtYxiQuLSfuCoNghOZX0m//aTxVxQLGJedg1CJDf2aOW3PQ12/nYkhfCxjiYH3NI6tRtHyF6PFWrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977052; c=relaxed/simple;
	bh=ULurqNgTjIRm8jXItaQmTq6l/zmGPnpuvlJ/4FEyZY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3HqRZR02X3neMZFv+F/SdPTHnu4aCf6mua6Egbju2ZAxw3WG/vC7HbjciL/27Cvo4UrRoTETBka7jJVyySn5lBzAyIPw7ECRe/OsHjqLK/e1vWC9Le2kFOKpustYTzeldoInbp6nkid/NY5TxmXtVt6g6chlyCJN+oj783JA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci+iD7PV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7930132f59aso6125664b3a.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760977051; x=1761581851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JV3ElJ0PE7M/5axYF+HEhAt8OP699X7xWQsv/feFME=;
        b=ci+iD7PVtHiBERs6XyLwgVIb02uilqDcfkFSgew8sk8cTVqVbeNWfDswWGeOJk0B94
         Nf1vB3cn8gLn5dLQ9xjq9YbMXDcV/14b1LvmSpn2D3lfIRPrqyyxlQQ2aYHwnUYNRjgQ
         7wuDczftRGd/q49WTl15/dRkuVPsaLgUjg98kXBt75kHR4WmUhrucMEWg4pJ/jLKaCk5
         NnqixYopplIu9mzLvMMU5sjJljhYALekZGNQI6M7ex7XcFvKeHaK8PqukbAWMzJ5SQ17
         +maN4LRWYUxOqSReG+FHCI05EsafguMn5BRJWgWoqVW882/vp6kXcw7P0Fnf/cnWATXY
         yWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977051; x=1761581851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JV3ElJ0PE7M/5axYF+HEhAt8OP699X7xWQsv/feFME=;
        b=CONbvyN1QRIUPwJpEtFgVo1H+OCozjDfgBYsGUnHbsBPzjSvfpsiHl9BLAFNETR0SU
         JLHjYv+reHrxz24UN75eDV5aWg4ie4yAvQS1NVSHDxeqHzbRzzkTSOK/84tzDTDjkGit
         b2TClUB3FowGf/y46SaClwsqc9JF6T0JYtcYbV/01417CuHl8bzIcV8rrqXRYUrPN0lN
         7cHuonznWuoGFHFPDl0sLSRA4uK+FYRCOYhsLYLHx7lNcsiCEpNtz8cFgHnIu+5Hv2Wk
         uEAx78A0nTisEx64oxHYePVQ5mnkiHmWJZXl6qc707yKb+Uq3wn0xb+u92MHDLhf8KG3
         fxWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmHrvQq2wr05bKJmvxIWCosFHiifymgPtpSMxOpylqjcbKoar2UoT5nc5WNMaGdRP8GrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4b/dlO3+qPnFSOqY0CWFRx70NWmTSaoWbmovyLTt2R80Rd3yx
	e6mqF0kj6u0Ez7I4CQEspjLIkCXpfKiNu922BqQ+5ssqRan+l1lwzM/iWmc3DiRuOWv9YAqVrmW
	tB70vzxJYFQw81/0aZvx7/ooRwBAP7wI=
X-Gm-Gg: ASbGncuNKjL+3Ep0mEORTEaUMz+P9GJ+dvQmzYAf5NCvEElE1/zxc5h0yAIYWfVHmF3
	K6hf+S5GQUfklVh93EBZcyNMJHzTFk1lwCLAadnN0J7hLcolDbt3WFD8yPKGERoVEStyF5ZKsvX
	1Qt6CGL+5ERk53zPXXUYaXI/RqZYhfGD0clsDYsY2MIVYvg5zLV3IWjW6ZbX0M423CyfLkVVwV8
	JQKo1dcxMloL5x9btxIQAOtx8h3iWWHRGdhP/ynfcs7bzEEW4uIzBRCbOGMwiXRLJ4JywmTumgZ
	avYGPIH+zwI=
X-Google-Smtp-Source: AGHT+IGbh3vIY6677DF9brRXSRdqlbWv3B0n8wxI06Wzk1E/BOpWWUwdp56dVrMID+U6pR7TEAzyQ0+fm4lNYwaxZ54=
X-Received: by 2002:a17:903:138a:b0:290:567a:bb98 with SMTP id
 d9443c01a7336-290cc6da1fdmr167710265ad.57.1760977050441; Mon, 20 Oct 2025
 09:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQ+pXhEsumx6NapCU0sCJw9vdB3TdLMLtCoHa7_sqCRH1A@mail.gmail.com>
 <20251019223006.26252-1-nooraineqbal@gmail.com>
In-Reply-To: <20251019223006.26252-1-nooraineqbal@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Oct 2025 09:17:18 -0700
X-Gm-Features: AS18NWBGqjFbbLYWqoMHdvc1S5PFT_whCkYbB4vjL2fGXEzy9hWRYir83-8Tb60
Message-ID: <CAEf4BzbtzHsa8DASzOg-Xqp8_-vG5ekC7JXhwuyZqPhrckU1hA@mail.gmail.com>
Subject: Re: [PATCH] bpf: sync pending IRQ work before freeing ring buffer
To: Noorain Eqbal <nooraineqbal@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, david.hunter@linuxfoundation.org, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	skhan@linuxfoundation.org, song@kernel.org, 
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 3:30=E2=80=AFPM Noorain Eqbal <nooraineqbal@gmail.c=
om> wrote:
>
> On Sat, Oct 19, 2025 at 1:13 UTC, Alexei Starovoitov wrote:
> > Why do you think irq_work_run_list() processes bpf ringbuf in
> > the above splat?
>
> In the syzbot reproducer, GDB shows that when bpf_ringbuf_free() is enter=
ed
> the ring buffer's irq_work was still pending when the map was being freed=
.
>
>     (gdb) p rb->work
>     $5 =3D {
>       node =3D {llist =3D {next =3D 0xffffffff8dc055c0 <wake_up_kfence_ti=
mer_work>},
>               {u_flags =3D 35, a_flags =3D {counter =3D 35}}},
>       func =3D 0xffffffff8223ac60 <bpf_ringbuf_notify>,
>       irqwait =3D {task =3D 0x0}
>     }
>
> Here, `u_flags =3D 0x23` indicates IRQ_WORK_PENDING and IRQ_WORK_BUSY
> are set, which shows that irq_work for the ring buffer was still queued
> at the time of free. This confirms that `irq_work_run_list()` could
> process the ring buffer after memory was freed.
>
> On Sat, Oct 19, 2025 at 1:13 UTC, Alexei Starovoitov wrote:
> > Sort-of kind-of makes sense, but bpf_ringbuf_free() is called
> > when no references to bpf map are left. User space and bpf progs
> > are not using it anymore, so irq_work callbacks should have completed
> > long ago.
>
> You're correct that normally all irq_work callbacks should have completed
> by the time bpf_ringbuf_free() is called. However, there is a small
> race window. In the syzbot reproducer (https://syzkaller.appspot.com/text=
?tag=3DReproC&x=3D17a24b34580000),
> the BPF program is attached to sched_switch and it also writes to the
> ring buffer on every context switch. Each forked child creates the
> BPF program and quickly drops the last reference after bpf_ringbuf_commit=
()
> queues an irq_work. Because the irq_work runs asynchronously, it may stil=
l
> be pending when bpf_ringbuf_free() executes, thus creating a small race
> window that can lead to use-after-free.
>
> Adding `irq_work_sync(&rb->work)` ensures that all pending notifications
> complete before freeing the buffer.

I think this all makes sense and the fix should be good. Please add
the above details (perhaps in a bit more condensed form) to the commit
message.

>
> Thanks,
> Noorain Eqbal

