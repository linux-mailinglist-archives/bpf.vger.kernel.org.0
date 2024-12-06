Return-Path: <bpf+bounces-46291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CFB9E76B8
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9812F1884D5F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C841F63F5;
	Fri,  6 Dec 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/YPB9b8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943B206274;
	Fri,  6 Dec 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504997; cv=none; b=IOTP0FiBV/W6/EpCs4971R6HFBrZP9GjiKv8nsw7qRChsEe0cFMBIE91Jm5FPEhsloUlg62GOWnf7lEeaLBvENejPRiMH1j9j+gnynuihinfxNKFipKVxv77m4hcMUEx/Uu5bpmuWuSVDv1YtN5hezr93/Mcgu7QeKU1j2AyABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504997; c=relaxed/simple;
	bh=yVYh77QGpu190qlU9GzwT893AJG342yRSbhqb76koAA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUF+fOgKgS2F9G3ZZXn/RaIcZWW+RU5X7QAOs8n70Vk301ZbUWUNIqdPjxzUp+V787ubHZs+uGNghJXQ3PQ5exK0EzsWoNSoCElmLXEPHJ1Dkz40AiZtD0jK9O4TBrIx9fS/IWF84C8rI00dnYxt3ZYmDwpdf7tcEDZH1vn1R+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/YPB9b8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a736518eso26494735e9.1;
        Fri, 06 Dec 2024 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733504994; x=1734109794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ToNAV72Q9Rie3oh8XyiNxbNNZl8vUy9Ma4qHyv7z8XU=;
        b=k/YPB9b8qnB8FY7aLTtQ8GFQ3Nl0W5UrfPt43PhCHpGusoj6GP+liZiuAzpfTvMdaO
         sAZ/Jnbe6FIWE++jgx0yQfxL3JQbFqfhkSP1u9J/joROPaT03hXJKlvvqOsGa+UsJ8cD
         6uB4j3NJxfbibFrNLULJ3gPtCxVgslnZqRIdtD9FapkBEnFTCQBCIlx02MgcEhlmZlum
         FOxbOSusGEh5LDo5981XvGeF8uIWLAWZAWSU5b0oT4IeGL3k9WY9oH/83ygy/1EW51uo
         oh1K/D/9KR2q/i/0P4crihyvBc/1tenIQ3rp3oEx8KANH96lTJmEXfo0IBMeLcl6XXDv
         4BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733504994; x=1734109794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToNAV72Q9Rie3oh8XyiNxbNNZl8vUy9Ma4qHyv7z8XU=;
        b=f8xtD6a5r0tsX9ocfYStgMRuuZiBscwg/b/4MLGNHBwaqLBBPrwyB9T0sYhFGb8AUT
         x37/I1H/0t+VdPjmh5n/vOmMOerHp+pO4jgpy9wYRXmksD3OANNdE8pfexwUl6qPkz/T
         dXDKxxt4LOk8qlW1BPOsV/h/9fHYMV77iiot8cADzUV+quaJeFVHp4fVrbMNAgUQrndF
         bdJI8BdMY0s5XSUbIloq891va5aMjcXDdFSX1QAKnx0dMhhw160GpV+gJwaTcd3Vbu9D
         wpWHGGGrzsFeDinFJ+SwB3BCeCtSGeZRmeqgfZUnz/2uoWPGsNGYC1aJY67bnhyWx2uL
         hLdw==
X-Forwarded-Encrypted: i=1; AJvYcCU9CFvob/ajYaMU+hBCzytLkBtcfiZhD4UvzOjDDNyfKmqW4/ffZPvUoEZqvcawGM6FjLQ=@vger.kernel.org, AJvYcCV3KSNGII3+xeIcmSz6Fo6QawwiV94lLDpxte+IylzuH/kW1PEVtSz4Bx1aJNBvxTMEjDKEuScMrCV0RdlPAOj7hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQxwNJdsOlqK/umYwTZE+vDt8ZlDpkt2634uCsD4ol50oc+3wF
	vZkKM9LmY+WHT5CtVnA6Nlk1ttBz34GCn2KL2pwSDUasPL3fEmr7
X-Gm-Gg: ASbGncuoNQGPWfrUpxGispGZyv7eMYxvY3WTMWpp9MOx8rhKZpXfBbG8WPtRKuVxRcH
	+iAZo/DgysdKiL8JZ+JY9tb2t8XKFQGvnHRxeA6XStvDkpLXHgh3mlMh/HPjSBpF+9/wrT8ct69
	2QBx8uyWThel//ThIki2puhWIGLCUHuvT21CZOLBDcQBz1EC8FEfbtW+fONPvdfoEK8LuTqiq0y
	8chv0fWwM8ckjAltH0rDpYQbo42p2DwzqmSpZ1hCTcAS5JJR8lxc7ugU38CgBpeiZjlb++XdmCL
	gcK78LQzSes1vSERCKjM5++O6JeDX02X6A==
X-Google-Smtp-Source: AGHT+IHx7D/9uBIg1UvCUle5j19DkJtqsRc+B7LX2QxXhyZbb5zOKQNAY/gU4G0I9HYyaRxrMBuBIg==
X-Received: by 2002:a05:6000:1865:b0:385:ed1e:20fe with SMTP id ffacd0b85a97d-3862b3e649amr3295071f8f.59.1733504994036;
        Fri, 06 Dec 2024 09:09:54 -0800 (PST)
Received: from krava (dynamic-2a00-1028-83a2-52b6-eb07-575d-6885-126a.ipv6.o2.cz. [2a00:1028:83a2:52b6:eb07:575d:6885:126a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf416fsm4952493f8f.16.2024.12.06.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:09:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Dec 2024 18:09:51 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Sean Young <sean@mess.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf,perf: Fix perf_event_detach_bpf_prog error
 handling
Message-ID: <Z1Mv3wjtonrX_ptM@krava>
References: <20241023100131.3400274-1-jolsa@kernel.org>
 <CAEf4BzbZdaPaspRAVP7=UcfpFzR4qhksJTRiEwiZ9RDQtdg0bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbZdaPaspRAVP7=UcfpFzR4qhksJTRiEwiZ9RDQtdg0bQ@mail.gmail.com>

On Wed, Oct 23, 2024 at 09:01:02AM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 23, 2024 at 3:01 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Peter reported that perf_event_detach_bpf_prog might skip to release
> > the bpf program for -ENOENT error from bpf_prog_array_copy.
> >
> > This can't happen because bpf program is stored in perf event and is
> > detached and released only when perf event is freed.
> >
> > Let's make it obvious and add WARN_ON_ONCE on the -ENOENT check and
> > make sure the bpf program is released in any case.
> >
> > Cc: Sean Young <sean@mess.org>
> > Fixes: 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return -ENOENT if exclude_prog not found")
> > Closes: https://lore.kernel.org/lkml/20241022111638.GC16066@noisy.programming.kicks-ass.net/
> > Reported-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 95b6b3b16bac..2c064ba7b0bd 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2216,8 +2216,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
> >
> >         old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
> >         ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
> > -       if (ret == -ENOENT)
> > -               goto unlock;
> > +       if (WARN_ON_ONCE(ret == -ENOENT))
> > +               goto put;
> >         if (ret < 0) {
> >                 bpf_prog_array_delete_safe(old_array, event->prog);
> 
> seeing
> 
> if (ret < 0)
>     bpf_prog_array_delete_safe(old_array, event->prog);
> 
> I think neither ret == -ENOENT nor WARN_ON_ONCE is necessary,  tbh. So
> now I feel like just dropping WARN_ON_ONCE() is better.

hi,
there's syzbot report [1] where we could end up with following

  - create perf event and set bpf program to it
  - clone process -> create inherited event
  - exit -> release both events
  - first perf_event_detach_bpf_prog call will release tp_event->prog_array
    and second perf_event_detach_bpf_prog will crash because
    tp_event->prog_array is NULL

we can fix that quicly with change below, I guess we could add refcount
to bpf_prog_array_item and allow one of the parent/inherited events to
work while the other is gone.. but that might be too much, will check

jirka


[1] https://lore.kernel.org/bpf/Z1MR6dCIKajNS6nU@krava/T/#m91dbf0688221ec7a7fc95e896a7ef9ff93b0b8ad
---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fe57dfbf2a86..d4b45543ebc2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2251,6 +2251,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		goto unlock;
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
+	if (!old_array)
+		goto put;
 	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
 	if (ret < 0) {
 		bpf_prog_array_delete_safe(old_array, event->prog);
@@ -2259,6 +2261,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 		bpf_prog_array_free_sleepable(old_array);
 	}
 
+put:
 	bpf_prog_put(event->prog);
 	event->prog = NULL;
 

