Return-Path: <bpf+bounces-39509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804979741B7
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E13C1F270FA
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2646C1A4AC6;
	Tue, 10 Sep 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bixBHskS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B61990D7;
	Tue, 10 Sep 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991762; cv=none; b=tFZcFNjOIsr0KrAul+uLJnRsH6WErMB9IQpyg888QQWu20OxnCZHjgDxTi8zI4nqBVXvh/gGq6Tte5tFiyoUK8Re2h2pSELFF7yRRJl/ekXdm8qElT5NfSRwvq1eK0LZJPTkCWSwCwkZ114buEHjSVL6wbXmJRz4DcGGVfCeXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991762; c=relaxed/simple;
	bh=2N8/D1ihjU6aMGhqrHGl3VqZHWCEUcRQ7LCRsQXs7YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw4SZm5tv5vXjPmBYuNus7JCu0DuSCX6YURSgF08QG8tkUInc45BPqsM9B4yuqZWpNuIyqYqc+Tqm3I6DnZyWOYIP5uVoXDMFhl1+mhs1041ShpDsR7+lWBi2Gjueq4MfHD2hBWRzEHQCxrePQUvIZm4BTBAeLQepInnNsiNDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bixBHskS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso4044072a91.3;
        Tue, 10 Sep 2024 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725991760; x=1726596560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keS3UcLB/RNrCfylnLbsmtnQNe6Qyfi2aduCceDFWdk=;
        b=bixBHskSKFM3iyIdxq/WFT5BMhySTUmeyubyAaURAC3zfcU29/ZmJn1kUEwnqFzchD
         sL5hvtXmvoykASk3ILAxBKL5yZKayKmecViRhj9+igg5PRseY8zeHKMk5W4gvZssJeq6
         zlEhk1JwsQnRDAWi7Yn2kT16JbSM6YEqoVKQ7Qj8LHUfVb6NM6i93to41x53dWxPp8Gi
         U1mBNzKzZMZVLJGeTzvwVA/DbFC11KN4c9uEuhYS4FLoGkHIyd0i4nPmgUwGO6rQdPmj
         AfA+HpOVT5cThIl86uCaEhitep9zbpU74DPEqO3E9kGVSg9b1aolmWVBMtFgtnNKRfqL
         uBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725991760; x=1726596560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keS3UcLB/RNrCfylnLbsmtnQNe6Qyfi2aduCceDFWdk=;
        b=gSYZgZDM9pFQM2vhT6+2S81QHp8whpW7TYOgJvtN5Mk/GE/xpWOsfR93YOxsZcgb/s
         HM3y+kxPsJC7SMRZQ83GtDB/8bXG/7TGNvE/6LUn0xs343glcyPQv7N50Y0OMTH4lrql
         JJsvKvljbFmJSdJVRBe53+KRi4TjluOGf4PIWnLiHZfNp+1FDdp5Vg5OY5Evw5RkHx36
         jFK10LDMX/F0iS8HF6Hc32nf47Fj/LOEiYQn+3nf77sACgWEQrStFnlWROfGXMqQ185F
         d3fJt9+uFb0pH0dghmAyrzV1rBxyymlO2vE+15HByPOLMmZ4f7BFscQ0CfNI8gqZXNvB
         NSiw==
X-Forwarded-Encrypted: i=1; AJvYcCWH0hFt+MZiqbuSHQyNm7KFqH864leFQ9P7rTo1y2HNirs37KF781OfJIjFxdv5SgWkOhhXrzOhnaaOovO6CB6nKxRs@vger.kernel.org, AJvYcCXgA9r7DuXfFHDfvViJeI1XD2G8qwviJIOuF5Si8eMGlpXDqjPG31FYa9n1Tt4M9s+0A3g=@vger.kernel.org, AJvYcCXyPmlKW6oYa/7vmIBV/ohZX79nRtfAAAky2bM6uh6BANd9//azwlUYJxD1LzahsEOYSFwRdcejyZ7Ohbpa@vger.kernel.org
X-Gm-Message-State: AOJu0Yymuc2od1w5qmX7zS2BenCQZr0K/hX2SHjLnacptR28mdg7zb0H
	Dgx26V2H3EtobpV94TvSMndnoehnkPxWBBM325TMtGtvWGHQV9bSptp2dEG9nuzHaS7o/slwiHu
	t4JOpaTCvqo8ZS/bA2KdB2vKEAdo=
X-Google-Smtp-Source: AGHT+IFfxI5/uWeMY+TBei8CnO15BojmFlKAAp1PNFk4TgZBhiS9LTFwdr5mC0MfHuwNgWKu60Xieb6B1yaiMQBR1fc=
X-Received: by 2002:a17:90b:438d:b0:2cd:1e60:9c31 with SMTP id
 98e67ed59e1d1-2dad5181c35mr15620037a91.30.1725991760259; Tue, 10 Sep 2024
 11:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909074554.2339984-1-jolsa@kernel.org> <20240909074554.2339984-3-jolsa@kernel.org>
 <CAEf4BzZ0+4Hd1xESWgE2WhSsNEuNuxtTju+OQeGiY0_iZsZbXQ@mail.gmail.com> <Zt_ygFPEdX53rqaW@krava>
In-Reply-To: <Zt_ygFPEdX53rqaW@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 11:09:07 -0700
Message-ID: <CAEf4BzZbLWKJkykHDu_Az5h8HYT-h31ELY2KPE5=VOymRBbCCg@mail.gmail.com>
Subject: Re: [PATCHv3 2/7] bpf: Add support for uprobe multi session attach
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:17=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Mon, Sep 09, 2024 at 04:44:29PM -0700, Andrii Nakryiko wrote:
> > On Mon, Sep 9, 2024 at 12:46=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding support to attach bpf program for entry and return probe
> > > of the same function. This is common use case which at the moment
> > > requires to create two uprobe multi links.
> > >
> > > Adding new BPF_TRACE_UPROBE_SESSION attach type that instructs
> > > kernel to attach single link program to both entry and exit probe.
> > >
> > > It's possible to control execution of the bpf program on return
> > > probe simply by returning zero or non zero from the entry bpf
> > > program execution to execute or not the bpf program on return
> > > probe respectively.
> > >
> >
> > pedantic nit: bpf -> BPF
>
> ok
>
> >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/uapi/linux/bpf.h       |  1 +
> > >  kernel/bpf/syscall.c           |  9 +++++++--
> > >  kernel/trace/bpf_trace.c       | 32 ++++++++++++++++++++++++--------
> > >  tools/include/uapi/linux/bpf.h |  1 +
> > >  tools/lib/bpf/libbpf.c         |  1 +
> > >  5 files changed, 34 insertions(+), 10 deletions(-)
> > >
> >
> > LGTM
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > [...]
> >
> > > @@ -3336,9 +3347,13 @@ uprobe_multi_link_handler(struct uprobe_consum=
er *con, struct pt_regs *regs,
> > >                           __u64 *data)
> > >  {
> > >         struct bpf_uprobe *uprobe;
> > > +       int ret;
> > >
> > >         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> > > -       return uprobe_prog_run(uprobe, instruction_pointer(regs), reg=
s);
> > > +       ret =3D uprobe_prog_run(uprobe, instruction_pointer(regs), re=
gs);
> > > +       if (uprobe->consumer.session)
> > > +               return ret ? UPROBE_HANDLER_IGNORE : 0;
> >
> > Should we restrict the return range to [0, 1] for UPROBE_SESSION
> > programs on the verifier side (given it's a new program type and we
> > can do that)?
>
> yes, I think we can do that.. we have BPF_TRACE_UPROBE_SESSION as
> expected_attach_type so we can do that during the load
>
> hum, is it too late to do that for kprobe session as well?

I'd say let's do it, unlikely we'll break anyone. I'd expect everyone
doing explicit return 0 or return 1 anyways.

>
> thanks,
> jirka
>
> >
> > > +       return ret;
> > >  }
> > >
> >
> > [...]

