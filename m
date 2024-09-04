Return-Path: <bpf+bounces-38905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2796C5D4
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 19:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709A71C24D6A
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BD2AE9F;
	Wed,  4 Sep 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+mh8nV4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6511DEFCD
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472571; cv=none; b=N8Wgj1kuRrxGujJnaWH5KBx/xVCBI7+oqayJEHmsVtkEVD5+xKw4wNeXVJG6RxWi0yXipkbTtWoN96hUrBRZXR/hYHWSDyKg6PcqqCtwQjbfzylMc/dkh+NvL94Jl6fIlftJg1Htobh/aJ+IzCaSnokHkdHz3jmOFZ+99MzgyjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472571; c=relaxed/simple;
	bh=HdgOomHFvE1/Wc4T6q4KiJOVWCAk9gCMvifTo+80K5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxbJegYubM10zQPTmJpZk2vx8SobPocS/6DxZb2u309oFvJ6rsPMS8AtB7Kxw9+G7HuVmLGIX8uHzqbZpm9eRffN1gPPyg++ygrCkHETCPIrPLcnCexIxeDMYj46rqQYZvY9px+lgOKz36W45OZGv5YJzvHoXbSd8VW9CVRMouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+mh8nV4; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d1fa104851so3961590a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2024 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725472569; x=1726077369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avmjvhA1OxauMDqS+XQ5yxzfTGqUbxQDmpTzQpjCWi8=;
        b=Y+mh8nV4+tQhDZEhSs0Ib2i5p6idoZx8aVaGgRMXYgLWiSXB6zZog5qzvQ2tbqJ0K9
         4OUCL1DBkEybphj77WSbodd3GMhW1xAiJjjGJnG7hUcA2+CqofJQn+QvS0RwYinnYqsy
         lEo3nyJMaTXshWYMjKdlRwcxLLSecBMGQW70KEgDZBR95VBJ5TgZ/1D/0+5yrJSkJL69
         jKXrciyX3FTml6rmiYn4bkQQAY7sYz/CjJjwxsy3Pj/2YIJn9wXuMFh6U1sIhUKbz5Ti
         xiRebG7lonAN4qf9ovJz3N6KcNw9UkEVOdurt9NCXWoI63ujymGeon3NCEY4PxRk2IaM
         I+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472569; x=1726077369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avmjvhA1OxauMDqS+XQ5yxzfTGqUbxQDmpTzQpjCWi8=;
        b=FBSU82F0V8L6Re2+3s/W0qlxXpFcXfK1UqJzjrLZzyjQLzzvzoIGMorze1rINDI9jd
         7BrkBozpvmXWHjIhuUtSJI1fAwBdI7c/X+nladOwObZ5C+baDpBmZ3cyVeHIi3aujkpg
         E0n1nK6I0iYEwCGcUvYj4M129YMK4pRR8lp0baOPrhbm1Ixjr5TryyfowpxOiIz0bqNQ
         uturIRhQrF60aGQln6VzpB4NJZzJnLtcCNUxD5q2xz4LYryFJN8G7zHC2xhefInXefsS
         aCs/2611NFkkF7O3IAifP8NWtOexLqMjdcHCJtAXhvf0xpKq86+kH3NunJjDKkmWFU/Q
         g4gA==
X-Forwarded-Encrypted: i=1; AJvYcCVzpQkriRySpwxboRwUTxJM7244IUAGMTFTiAsdFby65qkMEPKl2Jwu58dLu0HTWhsbveY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrdUvJr5w9QeyVW2TwxucmbKLYamFD8Wwl0ij23oSmnhSbdGY
	sTsS9+a/h+aHCKcY+8URE4C6Dlp9wMly3cGex9TpnnAcwbZVkqRyf3pcenKGYTLGX15wLKgnZfg
	e+Esk6tYhFQXCVX4krJXiZ7oTN0M=
X-Google-Smtp-Source: AGHT+IF85wgBt9VwTH6+yxOvsajitPwJ/uh9rlOk3dldt1S8EIZfPZu99w0cA2D/nv1sUanyk7mcU22MwKKJ2R9xrbs=
X-Received: by 2002:a17:90b:3e89:b0:2da:6a4d:53a6 with SMTP id
 98e67ed59e1d1-2da748855c4mr6012396a91.19.1725472569307; Wed, 04 Sep 2024
 10:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724113944.75977-1-puranjay@kernel.org> <CAADnVQKXY5E11gpng=0P_YFLJZh+nmiJDLOrtv2hftvxinukFQ@mail.gmail.com>
 <mb61pjzfrsgc4.fsf@kernel.org>
In-Reply-To: <mb61pjzfrsgc4.fsf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 10:55:57 -0700
Message-ID: <CAEf4BzaOxhTBf5TDZ0tstQNtdh-uf+d+ARTTX0YMnapdXucP5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: implement bpf_send_signal_pid/tgid() helpers
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 6:23=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> Hi,
> Sorry for the delay on this.
>
> > On Wed, Jul 24, 2024 at 4:40=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> >>
> >> Implement bpf_send_signal_pid and bpf_send_signal_tgid helpers which a=
re
> >> similar to bpf_send_signal_thread and bpf_send_signal helpers
> >> respectively but can be used to send signals to other threads and
> >> processes.
> >
> > Thanks for working on this!
> > But it needs more homework.
> >
> >>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
> >>         FN(unspec, 0, ##ctx)                            \
> >> @@ -6006,6 +6041,8 @@ union bpf_attr {
> >>         FN(user_ringbuf_drain, 209, ##ctx)              \
> >>         FN(cgrp_storage_get, 210, ##ctx)                \
> >>         FN(cgrp_storage_delete, 211, ##ctx)             \
> >> +       FN(send_signal_pid, 212, ##ctx)         \
> >> +       FN(send_signal_tgid, 213, ##ctx)                \
> >
> > We stopped adding helpers long ago.
> > They need to be kfuncs.
> >
> >>         /* */
> >>
> >>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that=
 don't
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index cd098846e251..f1e58122600d 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -839,21 +839,30 @@ static void do_bpf_send_signal(struct irq_work *=
entry)
> >>         put_task_struct(work->task);
> >>  }
> >>
> >> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
> >> +static int bpf_send_signal_common(u32 sig, enum pid_type type, u32 pi=
d)
> >>  {
> >>         struct send_signal_irq_work *work =3D NULL;
> >> +       struct task_struct *tsk;
> >> +
> >> +       if (pid) {
> >> +               tsk =3D find_task_by_vpid(pid);
> >
> > by vpid ?
> >
> > tracing bpf prog will have "random" current and "random" pidns.
> >
> > Should it be find_get_task vs find_task too ?
> >
> > Should kfunc take 'task' parameter instead
> > received from bpf_task_from_pid() ?
> >
> > two kfuncs for pid/tgid is overkill. Combine into one?
>
> So, I will add a single kfunc that can do both pid and tgid and it will
> take the 'task' parameter received from the call to bpf_task_from_pid()
> and a 'bool' to select pid/tgid.

Can you please also investigate passing an extra u64 of "context" to
the signal handler? It's been requested before, and at least for some
signals the kernel seems to support this functionality. Would be best
to avoid proliferation of kfuncs, if we can handle all this in one.

>
> >
> >> +               if (!tsk)
> >> +                       return -ESRCH;
> >> +       } else {
> >> +               tsk =3D current;
> >> +       }
>
> Thanks,
> Puranjay

