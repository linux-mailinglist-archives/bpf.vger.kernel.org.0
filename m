Return-Path: <bpf+bounces-38309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F819630B8
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 21:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2E2B21D2D
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D201AB521;
	Wed, 28 Aug 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7Jhod2x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE419E83D
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872132; cv=none; b=frkAoYCHHNkX52BmaNbb7vW00LGdfGY2f1mvNY/EWzs97JMjXQvzFWzZlPXS/dLJrmaB5p8wwLwxS8as2TDQu7UkPMjYiTJU4vx9IxDfkwFIvprDv4+PbWY/WmkV6O2SOkYt+deUgJij5kE4FwaL1ipHtieiEV8aEL3QmxIndJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872132; c=relaxed/simple;
	bh=VSh1UFDlUAhUFilHoZ/7yJvtaikLW1QkDF4cBh4per0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIzMxf/2HxzrRD+cF1fp9tVE8aCE1daIdMhaA6eeU0pMA2hSsoClFcDaK8bnmq9Vyf72KdMYLT1rjR1r1fWYXKhv/aGHir/1QDk1+UbPtWPuW1Bj7fGohddSclv+8/wjW87VTBpwsi6bOKFu+qsyzhV4uCuIrOApTLl4XcuOuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7Jhod2x; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so5636891b3a.3
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724872130; x=1725476930; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wRaUnuTyXBhONb24kC7ElFaVH3n3mjJlkkF2qGENmhU=;
        b=m7Jhod2xZZiHCp/Ft7Q2iKuEi1CJzcVWjZlIQP13ZlS1ScQzZANxNkSg4bjJh2BegM
         hpExoHdYxQSiOKbNdpeDPkGPTzfclK3bCZH6R6No9hJzWkM/J1j8BTQqvm3vg2kmN8nM
         DDoz/GhUmXvGA2FpuqE5j1saWnFqCJSg1YSe0xxgcRxIk366VBYtdIkw/QJFMPB+ngL2
         SB2jSyefJJ7pUZU7ofk2Hmu/yfAgNexcqMqOW4aJ47N076Xr0Q1qiA1oXphvG9NzD45X
         Mqsf+pvV+ELpOrtNtGMwEs1vEtJx4DrypX5JRsnsgEBhOI7uRDScGWzZODPVRsjegt/1
         cr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724872130; x=1725476930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRaUnuTyXBhONb24kC7ElFaVH3n3mjJlkkF2qGENmhU=;
        b=OzcVkKTgINLQNthlUrDDbNuV4lTbOkMOmIkCy4SeCEQ74H56mOm15uPcQZKgRDVhPT
         5/K+29ANFPXkb2hucz7BhLI9LRnS71CawXQIf1TpelR3zUlKd+CbeQugKuKPpUV8D/oP
         2wNn4kw3BLR/HBPPUvYS0gB+pY+vITh1Zf5+J8YvEQeb8RXnTz4hlDo0mSGgC1j5z568
         t/9WEe28WjdQl1c9cx26aes3o2A/nrD1Ft9qpFRUH1MiLxjIUcheDESk6Te/ClVqXtNT
         +TcCTZfD6iGVqaRGhuDKl0aw0YQHGmy176+2Gz4/Q+//888nxaT3A41TWxEspVX3jRj1
         z8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWDOCYHqQxwJKRKgr7IA6w4t0LsPJ/LOQpplXIVG2GFYDwMr32LsAAUxj/XLTeuLio3Xgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuogvYhDPigN53X9GHZA0gW8SG0iNjL6EQRYYrsaUG7uQElG+P
	BqfvddcMRHodeEBjL1hpk1zPbTVOVda9Tg+7wBI3vDI8Wq/bpaFdZhvnFw==
X-Google-Smtp-Source: AGHT+IG75x4bkDFZ+L5Rme7+3eQRy3fJMvgfjf3EIfR9UebPaW7SSkn5xFZNqZffKRECBXr4xLqh5A==
X-Received: by 2002:a17:903:40c6:b0:202:48a6:c882 with SMTP id d9443c01a7336-2050c4c9d01mr5321255ad.52.1724872129776;
        Wed, 28 Aug 2024 12:08:49 -0700 (PDT)
Received: from saturn (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203860c9d6asm102704705ad.303.2024.08.28.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:08:49 -0700 (PDT)
Date: Wed, 28 Aug 2024 12:08:36 -0700
From: JP Kobryn <inwardvessel@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Eddy Z <eddyz87@gmail.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: new btf kfunc hooks for tracepoint
 and perf event
Message-ID: <Zs91tK9dduFe1dIj@saturn>
References: <20240826224814.289034-1-inwardvessel@gmail.com>
 <20240826224814.289034-2-inwardvessel@gmail.com>
 <CAADnVQJp3Me_tXRs6Nupbi93bAj2D-sFuN-N7DMfKU=EtMu5ow@mail.gmail.com>
 <CAEf4BzaaZqiRGwK5=GHrd81HgtVbWfXOSWAeyorHgbCVjsv-jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaaZqiRGwK5=GHrd81HgtVbWfXOSWAeyorHgbCVjsv-jw@mail.gmail.com>

On Tue, Aug 27, 2024 at 03:42:34PM -0700, Andrii Nakryiko wrote:
> On Tue, Aug 27, 2024 at 2:01 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Aug 26, 2024 at 3:48 PM JP Kobryn <inwardvessel@gmail.com> wrote:
> > >
> > > The additional hooks (and prog-to-hook mapping) for tracepoint and perf
> > > event programs allow for registering kfuncs to be used within these
> > > program types.
> > >
> > > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > > ---
> > >  kernel/bpf/btf.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 520f49f422fe..4816e309314e 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -210,6 +210,7 @@ enum btf_kfunc_hook {
> > >         BTF_KFUNC_HOOK_TC,
> > >         BTF_KFUNC_HOOK_STRUCT_OPS,
> > >         BTF_KFUNC_HOOK_TRACING,
> > > +       BTF_KFUNC_HOOK_TRACEPOINT,
> > >         BTF_KFUNC_HOOK_SYSCALL,
> > >         BTF_KFUNC_HOOK_FMODRET,
> > >         BTF_KFUNC_HOOK_CGROUP_SKB,
> > > @@ -219,6 +220,7 @@ enum btf_kfunc_hook {
> > >         BTF_KFUNC_HOOK_LWT,
> > >         BTF_KFUNC_HOOK_NETFILTER,
> > >         BTF_KFUNC_HOOK_KPROBE,
> > > +       BTF_KFUNC_HOOK_PERF_EVENT,
> > >         BTF_KFUNC_HOOK_MAX,
> > >  };
> > >
> > > @@ -8306,6 +8308,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
> > >         case BPF_PROG_TYPE_TRACING:
> > >         case BPF_PROG_TYPE_LSM:
> > >                 return BTF_KFUNC_HOOK_TRACING;
> > > +       case BPF_PROG_TYPE_TRACEPOINT:
> > > +               return BTF_KFUNC_HOOK_TRACEPOINT;
> >
> > why special case tp and perf_event and only limit them to cpumask?
> > The following would be equally safe, no?
> 
> Assuming we don't have kfuncs that accepts program context (like
> bpf_get_stack(), if it was a kfunc) and that doesn't access
> bpf_run_ctx (like bpf_get_func_ip()). We just need to be careful about
> adding new special kfuncs like that going forward (not sure how to
> best ensure we don't forget, though). Other than that I agree that
> it's all "tracing".

What Alexei is suggesting works. I did something similar in v1[0] where I
associated BPF_PROG_TYPE_TRACEPOINT with BTF_KFUNC_HOOK_TRACING. But it
occurred to me that this circumvents the registration process during
initialization, so I want to make sure if this is or is not acceptable. See
below for my thoughts.
> 
> >          case BPF_PROG_TYPE_TRACING:
> >          case BPF_PROG_TYPE_LSM:
> >  +       case BPF_PROG_TYPE_TRACEPOINT:
> >  +       case BPF_PROG_TYPE_PERF_EVENT:
> >                 return BTF_KFUNC_HOOK_TRACING;
> > ?

With this change, anywhere we do
register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &some_kfunc_set),
BTF_KFUNC_HOOK_TRACING becomes allowed. So even if we never register the
extra program types like PROG_TYPE_PERF_EVENT, we still allow them as a
side effect since at runtime the program type mapping returns HOOK_TRACING.
Any program type associated with this hook will be allowed even though not
explicitly registered. My take on v2 was moving towards the element of
least surprise, and thought the explicit registration with the new hooks
made sense. I'm fine though, if we prefer this style above with the
implicit registration. Let me know and I can make a v3 if needed.

[0] https://lore.kernel.org/all/20240814235800.15253-3-inwardvessel@gmail.com/

