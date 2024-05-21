Return-Path: <bpf+bounces-30121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448E8CB1F9
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B541C21F3D
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704DA1CAB7;
	Tue, 21 May 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFVEbKll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D9C182DB
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307958; cv=none; b=onUk5N3fHut8NHXYDYJYBMs8aPd7RxZ1EfAztFYe4u4DHDRS2lW+Bz92IE8s33kIMdkyVDvGEcR1/UZd3dPAoVq8u1NAS3ODgCYYOhFH7v23xiKrybrrJTMeQpgnabobKERayWsrmC0CLiWE+Jk56244QORz5KR5GYop+uepP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307958; c=relaxed/simple;
	bh=lTmi57M6pmx61JMX619vJQ1iVovNp69plB1UeFD0wyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N54gGyMq1BYRmZNiInq0L8xEGrxCNCY4FTeGwynLAPBl+S+k2RAilD9dBodCoZx+RUMIk/vQFzxO496UJMXzp4QrO+ioTPKXxNaEDZfrd852lM28U+maVkf0NFZFooEsLzpWe0ozWiSlziydrkfUEMJCesnc6e/toIjjQ0o9Hn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFVEbKll; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-657a07878easo517251a12.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716307956; x=1716912756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giIa5jL76PLbCeLJNv7/HXt+kLRUPlOtIiiq0GSvxsw=;
        b=XFVEbKll39VQ+knlpb8FG2yOBWMn17nyuHrX2NPfsnbuumj3e7fRYqLboWhgTegYEX
         ZpY9J+KdH0SGqjQyBQLhH8ASkYUXNDVkd9sB4Bpv7UfUHGdAXKzAZCGvJRq6njRQ0g+5
         Yi32X/9qsUEd3LVmjXZrsE2OHXFJ+BMgqF7h6m82MqcODRW/iPPY1K+t6algQOkfEVhb
         L8R6IF1xAHeZyHPITQnBZW2qbg+Ju9/Z3W4PaI31UYSJYeZROUQtEPHyYvZioxHniEp8
         pQMSRfJg1rW4L0hOj72x2fky5PzQHihaNdotuCOQQeT4CgswePj6bUpje4aB4+G80eeE
         0EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716307956; x=1716912756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giIa5jL76PLbCeLJNv7/HXt+kLRUPlOtIiiq0GSvxsw=;
        b=syvGkwe+D+MqV7oYWKu6pmow1W1ZG/dto3ypons697Di/YrUF09zU06TUCeKmjo3aq
         VbZD0zyim3qQbFsYbM5/zPinaO7wAvLCS5+oWOeDk6iwLshwPISVoshyJ93UkCLUdKXe
         xLAeyObDyjrPZG9kvGA27LCb0ZzVFunk9WF9rNJbpf/DyoQmn6oyaCyD8duXHvSrXC+/
         JUHdhxfI3mNvRBET/reNATlhm3SLhTfHYkeP3Bxgi1s8GbDuuO9X9ufDWI8Xmt0Zgd3x
         oq6M5KgWLDOV+NPYueS/OBDLHMhE/xjTR8eY6D0LnUdoWm8o9aNdC4MOBXOodt6Zt0f/
         XfwA==
X-Forwarded-Encrypted: i=1; AJvYcCUJHju5oCKiAcjTEmSvOrr+KWun3d4a6KBPZv09mActoIDekyAgfLoNtByCj2SI6aUUC2k+rtDPgDr6ItKc854rIPgU
X-Gm-Message-State: AOJu0YxbWp8icYHc+ezbpRAoEEbRyq1akWkosgvhzNMPksYsbgyl1L7y
	D19V7JXsZkAQagiWSMRM2FuwhMMbWtOJXW0y1gxc4XZDoEHq5O0tcCikpBYcwjZES5uNLCn6s6M
	hcbmakgTm8KPOfgTlftLVEBKGk18=
X-Google-Smtp-Source: AGHT+IFotBffOT2zkeCBM8khXzeYlXTclazty+KTYoYWIPgeJ+BasR0xp99t7wTIOanrLrsF8pg8Ypdx2qCHt+6Mey4=
X-Received: by 2002:a17:90a:fb8c:b0:2b4:329e:e373 with SMTP id
 98e67ed59e1d1-2bd92e9a9e3mr2766370a91.6.1716307955656; Tue, 21 May 2024
 09:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520234720.1748918-1-andrii@kernel.org> <20240520234720.1748918-4-andrii@kernel.org>
 <Zkxxsx6WQ4H-r6Lt@krava>
In-Reply-To: <Zkxxsx6WQ4H-r6Lt@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 May 2024 09:12:23 -0700
Message-ID: <CAEf4Bzag8RxJBwg=gSi_imFsbeyPyNdu1Doq581eJg=aGgOYNA@mail.gmail.com>
Subject: Re: [PATCH bpf 3/5] libbpf: detect broken PID filtering logic for multi-uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 3:04=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, May 20, 2024 at 04:47:18PM -0700, Andrii Nakryiko wrote:
> > Libbpf is automatically (and transparently to user) detecting
> > multi-uprobe support in the kernel, and, if supported, uses
> > multi-uprobes to improve USDT attachment speed.
> >
> > USDTs can be attached system-wide or for the specific process by PID. I=
n
> > the latter case, we rely on correct kernel logic of not triggering USDT
> > for unrelated processes.
> >
> > As such, on older kernels that do support multi-uprobes, but still have
> > broken PID filtering logic, we need to fall back to singular uprobes.
> >
> > Unfortunately, whether user is using PID filtering or not is known at
> > the attachment time, which happens after relevant BPF programs were
> > loaded into the kernel. Also unfortunately, we need to make a call
> > whether to use multi-uprobes or singular uprobe for SEC("usdt") program=
s
> > during BPF object load time, at which point we have no information abou=
t
> > possible PID filtering.
> >
> > The distinction between single and multi-uprobes is small, but importan=
t
> > for the kernel. Multi-uprobes get BPF_TRACE_UPROBE_MULTI attach type,
> > and kernel internally substitiute different implementation of some of
> > BPF helpers (e.g., bpf_get_attach_cookie()) depending on whether uprobe
> > is multi or singular. So, multi-uprobes and singular uprobes cannot be
> > intermixed.
> >
> > All the above implies that we have to make an early and conservative
> > call about the use of multi-uprobes. And so this patch modifies libbpf'=
s
> > existing feature detector for multi-uprobe support to also check correc=
t
> > PID filtering. If PID filtering is not yet fixed, we fall back to
> > singular uprobes for USDTs.
> >
> > This extension to feature detection is simple thanks to kernel's -EINVA=
L
> > addition for pid < 0.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/features.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index a336786a22a3..cff8640ca66f 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
> > @@ -392,11 +392,40 @@ static int probe_uprobe_multi_link(int token_fd)
> >       link_fd =3D bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, =
&link_opts);
> >       err =3D -errno; /* close() can clobber errno */
> >
> > +     if (link_fd >=3D 0 || err !=3D -EBADF) {
> > +             close(link_fd);
> > +             close(prog_fd);
> > +             return 0;
> > +     }
> > +
> > +     /* Initial multi-uprobe support in kernel didn't handle PID filte=
ring
> > +      * correctly (it was doing thread filtering, not process filterin=
g).
> > +      * So now we'll detect if PID filtering logic was fixed, and, if =
not,
> > +      * we'll pretend multi-uprobes are not supported, if not.
> > +      * Multi-uprobes are used in USDT attachment logic, and we need t=
o be
> > +      * conservative here, because multi-uprobe selection happens earl=
y at
> > +      * load time, while the use of PID filtering is known late at
> > +      * attachment time, at which point it's too late to undo multi-up=
robe
> > +      * selection.
> > +      *
> > +      * Creating uprobe with pid =3D=3D -1 for (invalid) '/' binary wi=
ll fail
> > +      * early with -EINVAL on kernels with fixed PID filtering logic;
> > +      * otherwise -ESRCH would be returned if passed correct binary pa=
th
> > +      * (but we'll just get -BADF, of course).
> > +      */
> > +     link_opts.uprobe_multi.pid =3D -1, /* invalid PID */
>
>                                        ^ s/,/;/
>
> so this affects just USDT load/attach, you right?

good eye, fixing :)

and yes, for libbpf this affects only USDTs. If user uses multi-uprobe
directly through bpf_program__attach_uprobe_multi(), they will need to
do similar feature detection, if they care about PID filtering.

>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>
>
> > +     link_opts.uprobe_multi.path =3D "/"; /* invalid path */
> > +     link_opts.uprobe_multi.offsets =3D &offset;
> > +     link_opts.uprobe_multi.cnt =3D 1;
> > +
> > +     link_fd =3D bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, =
&link_opts);
> > +     err =3D -errno; /* close() can clobber errno */
> > +
> >       if (link_fd >=3D 0)
> >               close(link_fd);
> >       close(prog_fd);
> >
> > -     return link_fd < 0 && err =3D=3D -EBADF;
> > +     return link_fd < 0 && err =3D=3D -EINVAL;
> >  }
> >
> >  static int probe_kern_bpf_cookie(int token_fd)
> > --
> > 2.43.0
> >
> >

