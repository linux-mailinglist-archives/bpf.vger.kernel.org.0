Return-Path: <bpf+bounces-26201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F2A89C941
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393AC286FCD
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606101422B6;
	Mon,  8 Apr 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9DGKylv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4522091;
	Mon,  8 Apr 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592138; cv=none; b=NCAkzf3pbxnzveCREpi2mHRHT2zG/dXTHaT7q0tFb9wiF6CaOBPW9zOdly7i/YsOG4AbiSc115FqbwHyzMDAOhM36gc0VbqzFfukk/kDj8Z08KoVgd1jSwqhYTdWmC6+1CVQcchVPLID2Fh5+gehDiaNTP7iIggEEl2xd1Mxras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592138; c=relaxed/simple;
	bh=DsV1N+RIyVPFhY9ohymknnp1vY6EQwDm/UwNOvg54ek=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqYvwTY9q/qfpP/lhDDsiFlD8gFsg/7n+kM4XDwGa45l+TqWVZ1dkPv2RnEtQKIJ8XXpl4BvFnXX+U/MagYv5gSisDZ0vffNEn8ssq2vdAsCjBLLOO/r4IF6dnjSmYEa0MRxhjW0oRGAImCoDIXQaldILKEXuKTCIdeTIc9PeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9DGKylv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4162b74f2a1so28504565e9.3;
        Mon, 08 Apr 2024 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712592135; x=1713196935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgj52WXFs3LmWD1cqpXTyIxxrakcLGvncSgOBzL0ZMw=;
        b=H9DGKylvkG9akjbCtSdIp9tsHFmJN+oIb/XfwqslJRpkg63moo8PDkqpLRiIZn4BkH
         7ix6PreWG89tMjecDMgPrDxfoYPrfudkjIqQx/H4X2srF05msQDSz/CYviAIWTvi2Prl
         W+2cbVqki4IKhbMK+JXGDjOmyU2+9Z5HAPUGKsUijjb4WlJ+T0wdAaFRjACgDOQ/28dD
         YAZGLG0w4ZoWrh+Q0MC1tyHN40HXAfnPJHq5RfYAoZUcp+rdkZaNAi28/BPGgRW+YixK
         ZJXGqJN/k8bbqaHGvZ+dB6IOcovEuo6dxxnh3Bbk+2q7VqdBzr/N3g5odUE2zFFx7+jn
         2FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712592135; x=1713196935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgj52WXFs3LmWD1cqpXTyIxxrakcLGvncSgOBzL0ZMw=;
        b=jZTRrDuo+T2bXtW9R9c2Vmq3cdpMoxG0ZAJjTG3ami6xVheVgTCNv9IgzssFEOx8JN
         j+aFm5bu+m39QoopilQxgaV2NaMUjfLuc8VgE22P7PxqPgH6gLuJENdvqUFaa3fCBcte
         QPQIyCl0r3b78JLiYIlz4rd6PTKS/H0yq+nvVQnLxmrIUMhXVChSrzM7iaPs/dzeW7sB
         l01H4IfaG0zXluPhf7gKFM0gaqaeS8ago5A81tcK+mzC8cUclyOt/wmTFYgVOu5br1D4
         /OGoElL46UjC4zWPt00tXTt/f50QbSRWAFxObvMazkmPdbc+UYoJWXOT7YBQZg3pL4Nn
         +9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVm02BwfCLo5d19t65Y/Az2DEiRGDZI6QOv2fSON9bM85sNo5Un9XqXxws7J0AAxwAqJfutvnGBJiwJ4zOFkdmjC1RJd41eTApFjqKHGGEe5p8HBYJOT85U0r1zFeVLcMFXbyc6XZ9ZyKD4kIpJahPnLTdugD8Ruk/S8U1glGTX/eUFhpmIFq4x1Obi/kvkquIlVRJx7UQt0Uu43Oar2JMP
X-Gm-Message-State: AOJu0Yxz4hSTB47K2uuJYKYAawWifK0zqRpTCIgHojZP8ioyKYgJVL45
	gMDN6i+c2sk8W2hb4SUngQ7BBSMGtsyb8196Xw2pAz3wdMuF+ev/
X-Google-Smtp-Source: AGHT+IGdszYLuUuRs9COV+xJUeakdZvTqC/ekAOo5huejMNRYzmLOl/jbRaits7AYT74QaZd4JioLg==
X-Received: by 2002:a05:600c:4f83:b0:416:5a88:4b49 with SMTP id n3-20020a05600c4f8300b004165a884b49mr3499009wmq.15.1712592135309;
        Mon, 08 Apr 2024 09:02:15 -0700 (PDT)
Received: from krava (212-147-51-13.fix.access.vtx.ch. [212.147.51.13])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0a4900b0041638a085d3sm9396272wmq.15.2024.04.08.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:02:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 8 Apr 2024 18:02:13 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <ZhQVBYQYr5ph33Uu@krava>
References: <Zg0lvUIB4WdRUGw_@krava>
 <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
 <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
 <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
 <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
 <20240404161108.GG7153@redhat.com>
 <20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
 <Zg-8r63tPSkuhN7p@krava>
 <20240405110230.GA22839@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405110230.GA22839@redhat.com>

On Fri, Apr 05, 2024 at 01:02:30PM +0200, Oleg Nesterov wrote:
> On 04/05, Jiri Olsa wrote:
> >
> > On Fri, Apr 05, 2024 at 10:22:03AM +0900, Masami Hiramatsu wrote:
> > >
> > > I think this expects setjmp/longjmp as below
> > >
> > > foo() { <- retprobe1
> > > 	setjmp()
> > > 	bar() { <- retprobe2
> > > 		longjmp()
> > > 	}
> > > } <- return to trampoline
> > >
> > > In this case, we need to skip retprobe2's instance.
> 
> Yes,
> 
> > > My concern is, if we can not find appropriate return instance, what happen?
> > > e.g.
> > >
> > > foo() { <-- retprobe1
> > >    bar() { # sp is decremented
> > >        sys_uretprobe() <-- ??
> > >     }
> > > }
> > >
> > > It seems sys_uretprobe() will handle retprobe1 at that point instead of
> > > SIGILL.
> >
> > yes, and I think it's fine, you get the consumer called in wrong place,
> > but it's your fault and kernel won't crash
> 
> Agreed.
> 
> With or without this patch userpace can also do
> 
> 	foo() { <-- retprobe1
> 		bar() {
> 			jump to xol_area
> 		}
> 	}
> 
> handle_trampoline() will handle retprobe1.
> 
> > this can be fixed by checking the syscall is called from the trampoline
> > and prevent handle_trampoline call if it's not
> 
> Yes, but I still do not think this makes a lot of sense. But I won't argue.
> 
> And what should sys_uretprobe() do if it is not called from the trampoline?
> I'd prefer force_sig(SIGILL) to punish the abuser ;) OK, OK, EINVAL.

so the similar behaviour with int3 ends up with immediate SIGTRAP
and not invoking pending uretprobe consumers, like:

  - setup uretprobe for foo
  - foo() {
      executes int 3 -> sends SIGTRAP
    }

because the int3 handler checks if it got executed from the uretprobe's
trampoline.. if not it treats that int3 as regular trap

while for uretprobe syscall we have at the moment following behaviour:

  - setup uretprobe for foo
  - foo() {
     uretprobe_syscall -> executes foo's uretprobe consumers
    }
  - at some point we get to the 'ret' instruction that jump into uretprobe
    trampoline and the uretprobe_syscall won't find pending uretprobe and
    will send SIGILL


so I think we should mimic int3 behaviour and:

  - setup uretprobe for foo
  - foo() {
     uretprobe_syscall -> check if we got executed from uretprobe's
     trampoline and send SIGILL if that's not the case

I think it's better to have the offending process killed right away,
rather than having more undefined behaviour, waiting for final 'ret'
instruction that jumps to uretprobe trampoline and causes SIGILL

> 
> I agree very much with Andrii,
> 
>        sigreturn()  exists only to allow the implementation of signal handlers.  It should never be
>        called directly.  Details of the arguments (if any) passed to sigreturn() vary depending  on
>        the architecture.
> 
> this is how sys_uretprobe() should be treated/documented.

yes, will include man page patch in new version

jirka

> 
> sigreturn() can be "improved" too. Say, it could validate sigcontext->ip
> and return -EINVAL if this addr is not valid. But why?
> 
> Oleg.
> 

