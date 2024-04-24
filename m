Return-Path: <bpf+bounces-27674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F0A8B088F
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64ACA1C2328D
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA315A4BC;
	Wed, 24 Apr 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj9+sjgU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367B15A4B0
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959123; cv=none; b=cVv7QOxU7/2diBSHwRNpWmq1EjyeGmc6YFcirPUxMtjn8uWCKSvau6K/rDDtklmHbW7gtqApNSqbX72pgy4YwWklbEn6XvqnYqnqlQvdQfX4F9Bn6VJD4Kxav/lwzcJ4N446SrZpRm0oNVTjFiisC9lTbNO1PyBK4GrAxcj9mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959123; c=relaxed/simple;
	bh=mVGm/zqSvI89Ok8Cte0AfMPH1j3WMt6boLqzhvcnvFM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAzpTjwtB4MryXyy4kovC82RuO0pfsrJHLJFA24C4+YTmzx+AVdxqoW0DYdyU8l2MbR4oLzKdf22Pw5701jj+YxlhpRQu9FhR8d+KgYI/3HIxp3kUG70numhS4R+R4kgsXMTn7qMvcyKu0IjlrosZijfPH2siRgYpVYC/dhFQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj9+sjgU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so6608391a12.1
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713959120; x=1714563920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkYBCX3g8pweOhb+RTVIFbCyuJ0Lb6pM5AdHUP97e0M=;
        b=Uj9+sjgUv3SkZH6v1yRDEPi8uFMGXP4jjge5tzypMHpBRrOp26fkepvTtexZrD087x
         eZGc1HQ3nKXdBsoQdELUydb+ejW/hgMGfAUh5K+4HRZvIHJZgJyKXIt7UmcXiV9ljyvW
         sCv3TrIprywdioiho0ULuYZqaW2zw80txDM5HPQfDVV/CC0WPXWjT7yBBq/He4+hcYsH
         08maZ6zIsXcNG8LShxqlNF/5/b30a40pkrPr1rhBwVGSas27UV3jLNM3Obl3WUMy0tyK
         yx1h6X++4EJk9lEYiNJSVxWPP049w357OegtaKWtw6IFldHdpOIER+5s9T9mkcuoi6Ay
         xToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959120; x=1714563920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkYBCX3g8pweOhb+RTVIFbCyuJ0Lb6pM5AdHUP97e0M=;
        b=UbjardIU6NWaanQvhjB8CG16DarePqsGyMxP7myZ/3rGmyvPU5LOLKQXmBJ9qr3QAC
         UoINq/tNciCEcJk2OrcaHEDaL/W9QWtXZ/6nfPyZFKSTUbhgfWuZbgyDLWnAShrHYWAS
         rQMDkk2TDdaj+7RapBxbDgGC54qSXUUyzhe6/ASYcunTvkh5NjDyYt/70QlS0o5JCqs9
         cIEOGZ6JbTMzZ8FlyzCBRjad3MPaqAv+27waJqA59okH1cjMF6wDAg9GtNOMbTPaZ4HM
         2AgGtQQDkUOUxX15A+1V5StEACrJNg6upCW8uR23TzSxjKR6VTT9gWIp2jBYyrRJrDiL
         lIzw==
X-Forwarded-Encrypted: i=1; AJvYcCWvVFzbISG/OTisV+uDgV8LfFFA0xE4xRHC7yuhSbEpWEiOzqPO9S4xys6QMrsn11lnGPcFscJ8e4kRSjDrAmG2zE68
X-Gm-Message-State: AOJu0YxatImH/j0CT3RG0aLWda18+/ooWemQOcAz8zhYnqdE8Fu3Qnqt
	Ja5LR6xtr/F2oL2kRQ0rzUCHwXPtSE2Z3tZyLw7Wr/uE8YNRcVIB
X-Google-Smtp-Source: AGHT+IF782KH/Yto3v7TSYZFNM2c72gP4pdb/0RPHzxKXExpgVxSodQHitIBLozvJQP3LrHj8JG4yA==
X-Received: by 2002:a17:906:e4a:b0:a58:7ede:9540 with SMTP id q10-20020a1709060e4a00b00a587ede9540mr1231217eji.43.1713959119759;
        Wed, 24 Apr 2024 04:45:19 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id cw11-20020a170906c78b00b00a556c5190ecsm8321128ejb.221.2024.04.24.04.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:45:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Apr 2024 13:45:17 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 4/7] libbpf: Add support for kprobe multi
 session attach
Message-ID: <ZijwzUx_dD0gp0S4@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <20240422121241.1307168-5-jolsa@kernel.org>
 <CAEf4BzZEwjGndOZWe8aLD3Atzde2M5gqnwbh28HZsXrSTS9gvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZEwjGndOZWe8aLD3Atzde2M5gqnwbh28HZsXrSTS9gvA@mail.gmail.com>

On Tue, Apr 23, 2024 at 05:26:59PM -0700, Andrii Nakryiko wrote:

SNIP

> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 97eb6e5dd7c8..ca605240205f 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9272,6 +9272,7 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
> >  static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > +static int attach_kprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > @@ -9288,6 +9289,7 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
> >         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> >         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> > +       SEC_DEF("kprobe.session+",      KPROBE, BPF_TRACE_KPROBE_MULTI_SESSION, SEC_NONE, attach_kprobe_session),
> >         SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> >         SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> >         SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> > @@ -11380,13 +11382,14 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >         struct kprobe_multi_resolve res = {
> >                 .pattern = pattern,
> >         };
> > +       enum bpf_attach_type attach_type;
> >         struct bpf_link *link = NULL;
> >         char errmsg[STRERR_BUFSIZE];
> >         const unsigned long *addrs;
> >         int err, link_fd, prog_fd;
> > +       bool retprobe, session;
> >         const __u64 *cookies;
> >         const char **syms;
> > -       bool retprobe;
> >         size_t cnt;
> >
> >         if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
> > @@ -11425,6 +11428,13 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >         }
> >
> >         retprobe = OPTS_GET(opts, retprobe, false);
> > +       session  = OPTS_GET(opts, session, false);
> > +
> > +       if (retprobe && session)
> > +               return libbpf_err_ptr(-EINVAL);
> > +
> > +       attach_type = session ? BPF_TRACE_KPROBE_MULTI_SESSION :
> > +                               BPF_TRACE_KPROBE_MULTI;
> 
> doesn't fit under 100?

88 ;-) ok

> 
> >
> >         lopts.kprobe_multi.syms = syms;
> >         lopts.kprobe_multi.addrs = addrs;
> > @@ -11439,7 +11449,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >         }
> >         link->detach = &bpf_link__detach_fd;
> >
> > -       link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, &lopts);
> > +       link_fd = bpf_link_create(prog_fd, 0, attach_type, &lopts);
> >         if (link_fd < 0) {
> >                 err = -errno;
> >                 pr_warn("prog '%s': failed to attach: %s\n",
> > @@ -11545,6 +11555,32 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
> >         return libbpf_get_error(*link);
> >  }
> >
> > +static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
> > +                                struct bpf_link **link)
> > +{
> > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts, .session = true);
> > +       const char *spec;
> > +       char *pattern;
> > +       int n;
> > +
> > +       *link = NULL;
> > +
> > +       /* no auto-attach for SEC("kprobe.session") */
> > +       if (strcmp(prog->sec_name, "kprobe.session") == 0)
> > +               return 0;
> > +
> > +       spec = prog->sec_name + sizeof("kprobe.session/") - 1;
> > +       n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> > +       if (n < 1) {
> > +               pr_warn("kprobe session pattern is invalid: %s\n", pattern);
> > +               return -EINVAL;
> > +       }
> > +
> > +       *link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
> > +       free(pattern);
> > +       return libbpf_get_error(*link);
> 
> let's try not to add new uses of libbpf_get_error? Would this work:
> 
> return *link ? 0 : -errno;

ok

jirka

