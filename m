Return-Path: <bpf+bounces-68556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25074B5A445
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387F23A8C78
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F731FEFB;
	Tue, 16 Sep 2025 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5EvIdYK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8EA2F9DB5
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059541; cv=none; b=jHVm7bZEL6cw3rGBDliCsI2D1wt0BFOlyIi5/kQcWIHLDl40JhEPVdLq4GsT7wsITsDaHOdEeB8vb/x1exL83RvL4ZMmP8UD/dwqJpuPhCmOSIxd4WDE7Na3v/2iNiowUeP3xnYwyzYu00ynSvHMEcWRHN6iwv9dGatjtXVYcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059541; c=relaxed/simple;
	bh=I7vgzpb4iQRotjVoiX/pLxoru+xY5k4ZR4ZCWGtLhqk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqbCdiMjSmVLjdhuWcR/6NSN1K2TtP0qA09fDj/Z1n8/oPRYbl9iVVhF0fPJKD7S1gbzDtbAbZkAXeylkIChmcofPg4t5S3PCi2ysZ3S+l7lpygRk84AAw+NGKZ+eHlL1CVTmFUh/N36CVI9GHg5odJRaOkPdX6u27i9HT5kmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5EvIdYK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so11510597a12.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758059535; x=1758664335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HmHjJhcmqy1sBBEmVO7MB7cGRMGtnkst9/nnRmc5EGM=;
        b=T5EvIdYKM7xdM80hgROGpZCjWUgiJyj6DNTUADzcCLD4yLYcqmtXVTmvW3+7fpwF49
         /1RkICJtwQU2llZPTyAbZVkHRQ8uBP9DR6mL1qO10ss66D6YTTDTN7wGITa2Rhtvk2r7
         RK4hPqbl5KImlcQaDGEzLjpKVuhnM8ds/63Bbl0leLu8GWKGf/JQStWel3qZvP/RXvEk
         MGjP21F4XJiTJNFGacNlozYeVZqnyj5Hmn2FWTvfY/BiIPG/rcoMu7LtNXq4jQH9k0rs
         wclDdfnjRr9VItIOY3f1gv66UroRHmbwr4G+V6FYmuq02IftQEapEmpaVQ3GbMFYtYAg
         tqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059535; x=1758664335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmHjJhcmqy1sBBEmVO7MB7cGRMGtnkst9/nnRmc5EGM=;
        b=b1lwLz7a1zFqYoA5d0Gj10kxhD9UXezEPQwyFYWYfQ4K1q7IovkSGFilx2zOo4oOap
         g3lixYHza9YSX+2ObDxyaaH4wIF2Dr7o1neXReH16umJqEfFaj0d/NUGXTRPS3psxPFC
         jDih7hmdQf1+c03avMIcI7yBRmXXhLliA0wVhKduzYPVUTMKxz8hGMYj15RcGiQrleo7
         GxRPHrEdHuGDoGPoEQk+gAbf/LM8aZ+PyngbCtEs7MT4kX5H23T4dYbqIV36i4iEZLxA
         fLr7FBaujSO2n/+dxzg51FsD02PibnVrxDdTVefrU3lxlCtFw9PPpYUik0lsPK9n8dO+
         K99w==
X-Forwarded-Encrypted: i=1; AJvYcCXODq9zVc2/AqH8nMUZ5Sg05PnB7gDrUS83xVHHkF/Qr5eO/LNM81UbMhY3r21LTCo8wcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51mzxfaru6jH6i+sz08G20Toglz6yR75mlxctL9l9WMH5NNCq
	DvMfOoLjWZKR2apGFDLMEPTPUfHtWLiCBdLi3VNci8kzwANBWbLs0Fj3
X-Gm-Gg: ASbGncsSKm70046GokyQWCIAwJtGTYKMsS9esqLBmwhAg1LmkKYZF+Ieqeuob/2XJsP
	BiWj+rfe/E8fdhFP4dt8OfcCJt+OQTWYtE+SRWWl6hAsQmTfALGobMlIVSqG+YH5XvGCgw+Gn5R
	DPQ/sskOk+ZvFmxzYmyT7OMzDdJ5pdqRIty6Zv/w+fDkJmIexjFLgMSU764+eTr+v40ZzO957At
	zJIEG8qXPePaXyH3ISnv2/bOxmWf1rEzocMtPhwor7FfeEJ3KK4K2teKjxdDxnMMQyvzy0hCnpt
	Ar4YymHCa/Ob8Vji+sah5GqfFpCTdhZ4BtYIz4Ugjfs8Z9/UTC5lxLG5vysvoU20yRg5K8vGJfh
	onQvKTRbmiOnFbPTIi36ON2RaL0QGNsryK71BhVQ=
X-Google-Smtp-Source: AGHT+IEEPGcRJK3rkvIfHaTSzEc1f2K/e0Z2Jggqlv4rhtrevVG/kWh6oUJyYLTrD+W1XABPwN8FRQ==
X-Received: by 2002:a17:906:dc89:b0:b12:3f5f:603b with SMTP id a640c23a62f3a-b1bb08685eamr3355066b.3.1758059535004;
        Tue, 16 Sep 2025 14:52:15 -0700 (PDT)
Received: from krava (89-40-234-69.wdsl.neomedia.it. [89.40.234.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c6110c27sm1027530466b.66.2025.09.16.14.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:52:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Sep 2025 23:52:11 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 1/6] bpf: Allow uprobe program to change
 context registers
Message-ID: <aMncCwre1QwJTNcL@krava>
References: <20250909123857.315599-1-jolsa@kernel.org>
 <20250909123857.315599-2-jolsa@kernel.org>
 <CAEf4Bzbw0uvfNgUHQM9iG2YRtnVbgdh_GgFGy4Q7eQiPPJ==dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbw0uvfNgUHQM9iG2YRtnVbgdh_GgFGy4Q7eQiPPJ==dA@mail.gmail.com>

On Tue, Sep 09, 2025 at 12:41:36PM -0400, Andrii Nakryiko wrote:
> On Tue, Sep 9, 2025 at 8:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently uprobe (BPF_PROG_TYPE_KPROBE) program can't write to the
> > context registers data. While this makes sense for kprobe attachments,
> > for uprobe attachment it might make sense to be able to change user
> > space registers to alter application execution.
> >
> > Since uprobe and kprobe programs share the same type (BPF_PROG_TYPE_KPROBE),
> > we can't deny write access to context during the program load. We need
> > to check on it during program attachment to see if it's going to be
> > kprobe or uprobe.
> >
> > Storing the program's write attempt to context and checking on it
> > during the attachment.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h      | 1 +
> >  kernel/events/core.c     | 4 ++++
> >  kernel/trace/bpf_trace.c | 7 +++++--
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index cc700925b802..404a30cde84e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1619,6 +1619,7 @@ struct bpf_prog_aux {
> >         bool priv_stack_requested;
> >         bool changes_pkt_data;
> >         bool might_sleep;
> > +       bool kprobe_write_ctx;
> >         u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
> >         struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
> >         struct bpf_arena *arena;
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 28de3baff792..c3f37b266fc4 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11238,6 +11238,10 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
> >         if (prog->kprobe_override && !is_kprobe)
> >                 return -EINVAL;
> >
> > +       /* Writing to context allowed only for uprobes. */
> > +       if (prog->aux->kprobe_write_ctx && !is_uprobe)
> > +               return -EINVAL;
> > +
> >         if (is_tracepoint || is_syscall_tp) {
> >                 int off = trace_event_get_offsets(event->tp_event);
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 3ae52978cae6..dfb19e773afa 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1521,8 +1521,6 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
> >  {
> >         if (off < 0 || off >= sizeof(struct pt_regs))
> >                 return false;
> > -       if (type != BPF_READ)
> > -               return false;
> >         if (off % size != 0)
> >                 return false;
> >         /*
> > @@ -1532,6 +1530,7 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
> >         if (off + size > sizeof(struct pt_regs))
> >                 return false;
> >
> > +       prog->aux->kprobe_write_ctx |= type == BPF_WRITE;
> 
> nit: minor preference for
> 
> if (type == BPF_WRITE)
>     prog->aux->kprobe_write_ctx = true;

ok, will change

jirka

> 
> 
> >         return true;
> >  }
> >
> > @@ -2913,6 +2912,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         if (!is_kprobe_multi(prog))
> >                 return -EINVAL;
> >
> > +       /* Writing to context is not allowed for kprobes. */
> > +       if (prog->aux->kprobe_write_ctx)
> > +               return -EINVAL;
> > +
> >         flags = attr->link_create.kprobe_multi.flags;
> >         if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
> >                 return -EINVAL;
> > --
> > 2.51.0
> >

