Return-Path: <bpf+bounces-67783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88DB49A15
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B7F167F9E
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614E2BE658;
	Mon,  8 Sep 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkZJDNKk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27045945;
	Mon,  8 Sep 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360182; cv=none; b=RgXwYJTqud28+DvfFlulMeTOXoWtzWL5DxnIMrnLJ2zA2hg0lAiuOtvRU7jGkb2W5NyAE++fB8y1WMyGChnqGkKrGsk7UxJbaDyCoKnrlQfGPk3r/iUcLwu5vAkn4mr64fCbSzESDOiuAFOjhzKpSQKQSR1lpvw3A4DBFGIkoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360182; c=relaxed/simple;
	bh=Bo0hCDM48l6MeV5W+uWlFYBVKoa36PqCvcURT03ayKc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1gz7dzTB/C5mWxl8WyAygglPpqVyiRPbMfCHMe+JAVCCKLIinXhkNdbRyXmBy//4bWuWHKStuyA9T4RC3jbS42Z49rrsDVDmS3Z+RRb6AQgJpfncQvhYiC19l/elFrQkVHxcMaaTIVpED+ovGxLDJSVBQhpbqSJy0zFcH1r1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkZJDNKk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso2390994a12.3;
        Mon, 08 Sep 2025 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757360179; x=1757964979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7PxCoAvR6l4gW5lG5Yd8jKDUVRJOCjR4r1nXG3daz4I=;
        b=YkZJDNKkolGstj4Lt459QRGPAFbM5IVCRQ9D+Yl5TbvzoJYCWClHJp9EIenMzzVYGC
         WonTkOTTveWJ/1t9NgdmvVHwZtdJ0xKLPWi06+5TnrXE3ibNOM8GGPQxvUOtzp1WTLvZ
         jNJhODipLUTkpC8UXaXllzd4ejhVoqadc9L7RKMgu8nqGnSUu1E6stOvFxB3AX65bLR/
         l2iZHJQxcQu0Vt7cipC/BNaygWehayjalrKfOiAbpeclMj7SxtcHHeCqYKHHmqGbLQ+i
         56UVbRcqRIR2Ra7jfPLqg1odH2Z2nDLbRytpMlwJtTR7U8A4wg+o68WeQ50gbDXbaokj
         kyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757360179; x=1757964979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PxCoAvR6l4gW5lG5Yd8jKDUVRJOCjR4r1nXG3daz4I=;
        b=jeis8k6sXv/Q1UORW/+8SunlgUwnzEP0MXvUf6hQdMeTHBP/ggiQXpu5i0MbHBCiPG
         +h/CZM8btY0dIJFfdar3IGGmsEDBCSoxrXJthGQl7AOriopTXJf3p4YFUI5wXBdY6JSE
         1d6KOcCeUUGVdHicsJ8lINpmpEVxcp/hnY/v8I1fWK1l1dZHQyjftaHojE16nn68Op4O
         kIybrr3nIAKr1tu7vzbs7kk92VGfnO09Eg6q5mKVIYgaNhpiUZcIxUfJzM/W9JNzEVWS
         gdhWVOvNZnwwzD+sBiteNq48AV7m1uA6uDlL6OmzxSqbKehZemQTVYXOucEag0/XoCdv
         hIxA==
X-Forwarded-Encrypted: i=1; AJvYcCU5jLqdS4gWYFu1GkcltB2SQEssHgGJ+olpyfTQeXkluPxR9TgvnzTaIeD+2+QalFth1IfG3NC5Lgif6hDoZgIetjuS@vger.kernel.org, AJvYcCUqYMxew0woNw22fgHdvvCEnE3qZc+daTRnxW1ghamT2M648fsnzD8rWqXpKuHBhu9MnBdiysNxpEM2lLO/@vger.kernel.org, AJvYcCXG5OQZWS2lrzv0plakv2hZ8DgMdTsqvNJ3UEtJqHaU6KF/fCTvs/O6EfvtM6sGIWQAt5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIroCKiUjpOPAaIfbpx3TGu86IsozAarkamNETgDPW2UoGydwK
	8Ba0NJi4v/LWOUyiFPnAXg0oY/MegRNsgjc2XgipevZmfqeXftxz55fN
X-Gm-Gg: ASbGncvjiwTv+YqRGroIOIoeINBeh929F1/rrVRllu8R6SzkZzp8HiWCatmZeu2ADoZ
	bwXUoNaoGggKVEbLxdR1VIw8L65ExhIdg6raycqDfmcfMEwoBW4ChavvQezfUCISm7AxE2BX3B5
	/3boDVPoer3mpiCyuQviGfbm1H5lu0lUhYALbyDRQJ5GBCS5reNALOGA0oo0QYHRohDHif1jvxR
	Vs82BSAZavnoYSv+MQsVT017TmHttps4JvWS3teag/QVAscdDgMi/di3ByJ1F/+Zp/QYz6VFfUC
	buM4oxEAzKUIDjYLm7PhLkhJF5+ZQfo0Za0rZSnL4Cu/4Ifdrt0kKJJxHNkTRmAfiEk65G+xawf
	yQU05ZTG/Af0=
X-Google-Smtp-Source: AGHT+IFLfG/96PmNOOS1sDG/gwN3q65g5ZhGzfd6k4qr91vqyjSbl27rWiEXu2Mn02q2AVdYFmGt0Q==
X-Received: by 2002:a05:6402:1ecf:b0:62a:82e8:e1f6 with SMTP id 4fb4d7f45d1cf-62a82e8e4afmr2476554a12.36.1757360178263;
        Mon, 08 Sep 2025 12:36:18 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61d3174074bsm19440249a12.35.2025.09.08.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:36:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 8 Sep 2025 21:36:15 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 1/4] bpf: Allow uprobe program to change
 context registers
Message-ID: <aL8wL1rJRpWp_qHs@krava>
References: <20250908121310.46824-1-jolsa@kernel.org>
 <20250908121310.46824-2-jolsa@kernel.org>
 <CAADnVQKC4tNCLrS6_1zLOtF7MUWiXUWnLXCnQBp_UDLQZj3rrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKC4tNCLrS6_1zLOtF7MUWiXUWnLXCnQBp_UDLQZj3rrg@mail.gmail.com>

On Mon, Sep 08, 2025 at 10:20:55AM -0700, Alexei Starovoitov wrote:
> On Mon, Sep 8, 2025 at 5:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
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
> >  kernel/trace/bpf_trace.c | 3 +--
> >  3 files changed, 6 insertions(+), 2 deletions(-)
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
> > index 3ae52978cae6..467fd5ab4b79 100644
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
> iirc the same function is used to validate [ku]probe.multi ctx access,
> but attaching is not done via __perf_event_set_bpf_prog().
> The check at attach time is missing?

argh, yes, missed that.. good catch, thanks

jirka

