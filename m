Return-Path: <bpf+bounces-33786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE009266E0
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 19:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B3E1F23E61
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B501849C7;
	Wed,  3 Jul 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCanIDw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05F17995;
	Wed,  3 Jul 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026854; cv=none; b=fp08OgbstIfJCgI1ReMUxI6RSm45iixUVLtIHGUE77UlIgR/eeOt1Ou02F9tABoPkLwxCiQ2ouZip75lg1S2BsdycQNDynPd7oT7HKbu/lJt7FC8I8CW9ig6Avj3fXhu/LrZDQV81oJxmVJscBT3osfpT8dv7uv3ECVDMD2zULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026854; c=relaxed/simple;
	bh=GWJrkhre4xnlx4zgTTv4Qd2cymlf2IVWeXmg1AzNe24=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1TycK8g2W45ERyx36sC/W95g2EpzC4hy5BDThK6txiJGwd55Hdglh/0hnm/0Ta5n/7cCvEDrhpMas3+w8c1giqLFnGFRsjrQ3/We3kWS0FyK34NTZeV5cN1fqC9F9goZC/ImIbxaB4qEjO1zB6XsvDtnqPXfe7Ukz3RkDtekMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCanIDw3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4256742f67fso40916915e9.3;
        Wed, 03 Jul 2024 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026851; x=1720631651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cHCw/hfVVQjPMKzB7Kyk8/6igXkXue8yvBHwZXwaOR0=;
        b=dCanIDw3x8lk3JAhwd1Hgcog8s3+LqefpxoFuRr1F3J7jxufVujcD8D58sPBAzYAer
         y5kTPfCdON9h8nze4hYJCzInyXT4jecC6h/vpC4EA5oGSAzvJcLnNOiigyjOW3YeJRkn
         50/gnxp3SG55BvnWNKrKdt7z6c8yyyRPYAFRvmbyslyFChZGUownWib9VWYnpOphhVhc
         pV2Mrjx/bKzadQaxGl9++izRRcG7lP8+ZzUI7f6D90QqT4ySLdiYKldjlSe83D6nKlJ3
         11n4+Ty/7svT07WFTMiM3jn1hv81hoTL91BpkR5FjTQ95YWCh3Z+Gp0xNQrnc3VHzbz2
         P9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026851; x=1720631651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHCw/hfVVQjPMKzB7Kyk8/6igXkXue8yvBHwZXwaOR0=;
        b=bTKeLzaLdrOqpnRioD93EctuKV9GPSTKln3YZI4QFFtbYzVzBpMk8SKWKMfJ1EudoU
         tQnE0UUqPiT087Wr2SOXjvL/Be6NhyK2D7MibgZ1X/heNIvdgM647rGrNnJs5US3OgI7
         n4od6xIqsFjW4lQLANOY2ISizd7SnMAGgcq/mQORkyZHqModEB3oezeU8RankBehtOKP
         WK8kVf/9iUEIw99sKXf7nI+ryuUgAtMVNNT5vv7WscF/Ak0NrmsQPP9Ws/rbHTI6Senq
         ZQdeMiGYjpI5f4QeP5adqlPaRaOFj3VEV0iflz1hhTH2761S2hvSLZT0yFUhD+xKoNuF
         cVuA==
X-Forwarded-Encrypted: i=1; AJvYcCV2t/+RslI7hjkAiA28BlXHecKWOz9OMBINHi6EDgu9mrRni48rpXf5kAR5SiiCSMj6XQPptoAtBBDFoveF2/Ov7MvDn9I6IQs4OE37RwCvUTyYX+g02atxlIF85HUgKOOn+fbHyUNEZWXgrjBIb3faHJ/7XgaQLeFIDm9WEuTl1kCjIyPL
X-Gm-Message-State: AOJu0YwW0El1Ejlfw9Vw6t+8nJBS2TwjdH2JbqLn1uEhIABgUUA5FkeO
	1kLC3Cusbs4jMnb1ocBU654GQPNRdnoF19b+VaKE93NMDXndZaHN
X-Google-Smtp-Source: AGHT+IFkPwwxoF6hzJcEdxx6vWqzEI1A8sXzVSgeAaIRiel4DU+ythfV8KP6R00IgyZjK9aHxYpdXw==
X-Received: by 2002:a05:600c:1d1a:b0:425:73c9:e60e with SMTP id 5b1f17b1804b1-4257a020eafmr80575345e9.25.1720026851001;
        Wed, 03 Jul 2024 10:14:11 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b626sm243684285e9.15.2024.07.03.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:14:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 19:14:06 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 4/9] libbpf: Add support for uprobe multi
 session attach
Message-ID: <ZoWG3vNs5SW90wmp@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-5-jolsa@kernel.org>
 <CAEf4BzYP6zW0Mmi_=J5ng+GiUSJpB1JCg-qai0kp_N+_vestxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYP6zW0Mmi_=J5ng+GiUSJpB1JCg-qai0kp_N+_vestxA@mail.gmail.com>

On Tue, Jul 02, 2024 at 02:34:34PM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 1, 2024 at 9:42 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to attach program in uprobe session mode
> > with bpf_program__attach_uprobe_multi function.
> >
> > Adding session bool to bpf_uprobe_multi_opts struct that allows
> > to load and attach the bpf program via uprobe session.
> > the attachment to create uprobe multi session.
> >
> > Also adding new program loader section that allows:
> >   SEC("uprobe.session/bpf_fentry_test*")
> >
> > and loads/attaches uprobe program as uprobe session.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/bpf.c    |  1 +
> >  tools/lib/bpf/libbpf.c | 50 ++++++++++++++++++++++++++++++++++++++++--
> >  tools/lib/bpf/libbpf.h |  4 +++-
> >  3 files changed, 52 insertions(+), 3 deletions(-)
> >
> 
> [...]
> 
> > @@ -9362,6 +9363,7 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("kprobe.session+",      KPROBE, BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
> >         SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> >         SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> > +       SEC_DEF("uprobe.session+",      KPROBE, BPF_TRACE_UPROBE_SESSION, SEC_NONE, attach_uprobe_session),
> 
> sleepable ones as well?

ah right, forgot.. will add

> 
> >         SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> >         SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> >         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksyscall),
> > @@ -11698,6 +11700,40 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
> >         return ret;
> >  }
> >
> > +static int attach_uprobe_session(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> > +{
> > +       char *binary_path = NULL, *func_name = NULL;
> > +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
> > +               .session = true,
> > +       );
> 
> nit: keep a single line?

ok

> 
> > +       int n, ret = -EINVAL;
> > +       const char *spec;
> > +
> > +       *link = NULL;
> > +
> > +       spec = prog->sec_name + sizeof("uprobe.session/") - 1;
> > +       n = sscanf(spec, "%m[^:]:%m[^\n]",
> > +                  &binary_path, &func_name);
> 
> single line, wrapping lines is a necessary evil, please

ok

thanks,
jirka

