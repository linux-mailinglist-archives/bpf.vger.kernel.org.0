Return-Path: <bpf+bounces-40664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C4298BD4E
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B611F23790
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6E21C578D;
	Tue,  1 Oct 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok47sf90"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F361C2431;
	Tue,  1 Oct 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788694; cv=none; b=NCwDLS8JpaWGkJPXzafbiBAvvLvF61hBfnuF3eRm4V0AxJm+FYRTbg2z5A7TJ4F+2nlZBVzBchLJIF1IpAQ2bgdHTIM+Yde2zBlQoGBFnlqak/AgCuKJT6YAa6v80nSrqbr7+oofKmvFk1RUIVQaxKGANddh4raCbgVk+xyuBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788694; c=relaxed/simple;
	bh=Okn+mx+uYn0kfAfwXQWbKAPKeaRjfMI1ii3mkKFVF1s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2D/aoQzct4DcJ+Hib0HFVaYFIYNzemCxNck4AhNpcrqAjbUF9uwpEdaEXcssvzcrQSPmgofRex9N4kKMWcYHhsqPMAfNlFuMzdcRT06MA0NJ4cR31CX37W01zqBrxYdJqbTsg1F5RjmZE2qsUf83yY6/r9wOrKNPeeJvvbolRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok47sf90; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37cea34cb57so1265170f8f.0;
        Tue, 01 Oct 2024 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727788691; x=1728393491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dcqjAVHSpsLjXQ2Z6LjUVpS0oZlaZkuQkPko6JUhHmc=;
        b=Ok47sf90W5sM+sz//s6rkE0ri7XitvoCJ0uxGCDSOpunXTlosdqGuqiF9SfJ2rr83L
         wH3j6Oe1tAgFQpAWhxNnwRQR6+0gtV++8tDppRhVsFm6CGDMS8CnFVjnyNsYg1/qzbga
         JeVmjtsnJ7ogbW5Mt+AGVsg1q9BDGL9wOJf2jAjT6C0THv0TswaWwIjTwnocKlh3+BvR
         U8enhHu2stKqYQrFXIsm8fNxVJ605sbnHGr7Nj1oU3zYImSC4r36lANBeZ/zrK+d6Gwc
         qTFm04JUJ3JdkpdcleZ5+YhnXlHD9yDUDqkwm/bffQ8P0GiXIi95Nby29CWPz8b8hKY1
         iURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788691; x=1728393491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcqjAVHSpsLjXQ2Z6LjUVpS0oZlaZkuQkPko6JUhHmc=;
        b=I7UMq0pv6s/ul9eT2uD0k5y0U9VayXkDrqQLx9LPNl9Fbxi3P91T105pye6Xs0qy7E
         KE5UfOPxhCpbILmu8jXP5q2eRtq1C+ogZGGtepdl/kMZXIAgKb8lj/cJ7c8dcgwLyd2H
         tbxZO92ImcoCxQXH/TVUwQXfDHTjJwbCTecl8Le6bO4gfXvLTrEqCw0s3DjMMH6IYbSP
         ynkw6Xp9AXASzRyGPBSQdtNurbmf9PQRqIRwI3mT0zWrlNYO1D0FeCPqW0hFBRBJZiTD
         f4ug7I/ZRJwTpHsIIEDcAywSX/hC7YV/MVuFU2caooMB6thtRg8DtviCupys0jXHgGAT
         XG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxdFCT/9+BPFUdipkeRctyNJ8ZZIGvJMlaeo84qBwL9Qr6ByPMOTtzjlYxCfApCPEr9kK6P4vRzqgrPPbR@vger.kernel.org, AJvYcCVWj4OZRgCvHVVvZheo8jWs9nZL62cgKuTeKfZQ0vgcSfepiT5yTLn7yL5K+ur8Zp5HDAs=@vger.kernel.org, AJvYcCXf9xFxR9YMy5cJaU3Tn9RhhXwqxE95+Vg6qTcSv/soV01meklkCgj4m7mDkxZMZRW7eph1HieGV29JQQ0L9pA2HOQn@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLm6Fa71drIhY34oxG2Jn1WnjEIun0sKHLSKfuYLnv0S9T7wP
	DDdSNgubnS7K99d9gmnWmV2HcE5qFCA4THc1lLJFPcFrTuMdHD2N
X-Google-Smtp-Source: AGHT+IFY4PiSb6s6KZNY8gwYcnfdtbJMwEwk6doKg25fEYDiVcPSlcAsi9u+t4E4kni8VJeY1UPYqA==
X-Received: by 2002:a05:6000:1103:b0:371:a70d:107e with SMTP id ffacd0b85a97d-37cd5a62b3fmr8342000f8f.6.1727788690656;
        Tue, 01 Oct 2024 06:18:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5742a23sm11791320f8f.105.2024.10.01.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:18:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 1 Oct 2024 15:18:07 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 06/13] libbpf: Add support for uprobe multi
 session attach
Message-ID: <Zvv2jzNRzzm1ND-y@krava>
References: <20240929205717.3813648-1-jolsa@kernel.org>
 <20240929205717.3813648-7-jolsa@kernel.org>
 <CAEf4BzYQLo41DtTPpkZ-mMWx-34G4h2pFKY_mDrBfFibjGHjPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYQLo41DtTPpkZ-mMWx-34G4h2pFKY_mDrBfFibjGHjPA@mail.gmail.com>

On Mon, Sep 30, 2024 at 02:36:35PM -0700, Andrii Nakryiko wrote:
> On Sun, Sep 29, 2024 at 1:58 PM Jiri Olsa <jolsa@kernel.org> wrote:
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
> > Adding sleepable hook (uprobe.session.s) as well.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/bpf.c    |  1 +
> >  tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++---
> >  tools/lib/bpf/libbpf.h |  4 +++-
> >  3 files changed, 22 insertions(+), 4 deletions(-)
> >
> 
> LGTM, though see the nit below
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 2a4c71501a17..becdfa701c75 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -776,6 +776,7 @@ int bpf_link_create(int prog_fd, int target_fd,
> >                         return libbpf_err(-EINVAL);
> >                 break;
> >         case BPF_TRACE_UPROBE_MULTI:
> > +       case BPF_TRACE_UPROBE_SESSION:
> >                 attr.link_create.uprobe_multi.flags = OPTS_GET(opts, uprobe_multi.flags, 0);
> >                 attr.link_create.uprobe_multi.cnt = OPTS_GET(opts, uprobe_multi.cnt, 0);
> >                 attr.link_create.uprobe_multi.path = ptr_to_u64(OPTS_GET(opts, uprobe_multi.path, 0));
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 3587ed7ec359..563ff5e64269 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9410,8 +9410,10 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("kprobe.session+",      KPROBE, BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
> >         SEC_DEF("uprobe.multi+",        KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> >         SEC_DEF("uretprobe.multi+",     KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_NONE, attach_uprobe_multi),
> > +       SEC_DEF("uprobe.session+",      KPROBE, BPF_TRACE_UPROBE_SESSION, SEC_NONE, attach_uprobe_multi),
> >         SEC_DEF("uprobe.multi.s+",      KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> >         SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> > +       SEC_DEF("uprobe.session.s+",    KPROBE, BPF_TRACE_UPROBE_SESSION, SEC_SLEEPABLE, attach_uprobe_multi),
> >         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksyscall),
> >         SEC_DEF("kretsyscall+",         KPROBE, 0, SEC_NONE, attach_ksyscall),
> >         SEC_DEF("usdt+",                KPROBE, 0, SEC_USDT, attach_usdt),
> > @@ -11733,7 +11735,10 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
> >                 ret = 0;
> >                 break;
> >         case 3:
> > -               opts.retprobe = str_has_pfx(probe_type, "uretprobe.multi");
> > +               if (str_has_pfx(probe_type, "uprobe.session"))
> > +                       opts.session = true;
> > +               else
> > +                       opts.retprobe = str_has_pfx(probe_type, "uretprobe.multi");
> 
> nit: this is very non-uniform, can you please just do:
> 
> opts.session = str_has_pfx(probe_type, "uprobe.session");
> opts.retprobe = str_has_pfx(probe_type, "uretprobe.multi");
> 
> There is no need to micro-optimize str_has_pfx() calls, IMO.

sure, will change

thanks,
jirka

