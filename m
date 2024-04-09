Return-Path: <bpf+bounces-26277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE7889D8D9
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 14:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AFA1F20EFB
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1356912D75B;
	Tue,  9 Apr 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgiVxh91"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08B12AAD3;
	Tue,  9 Apr 2024 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664386; cv=none; b=fhFD+2aRngxCnrh4lMkB+zXL95LhN9ysIw5fgkvCNkSVEqsmIG5P9b3bmHvN1SOU+iXK6ljcmpztmHjO8rWql7zi2uLqESVYTF7mP9dECLamK7nS8BaLcUsWxdahG4iI2uWwcMv7X4Vo9CQdKi/1X71FqRxiD3uxTqZTFI67fFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664386; c=relaxed/simple;
	bh=3AO53c9WLONX6THJEZDEWKPYefXDqN2JEENGhVOOsG8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEo0qg0100Qbj2IKHqxZwlj4qWHYGs5cpXeOVlbX78Wo6ruHtC2fRgWxz4PI21qbIpxJPz9eHONrERFKOV4Rnqib+nfFdQIrdhqg/JiOeullQMrukh0/pDkxeW13reEAFs/LfH7iy3miruDCpZEu7f431iEHWUyYkZFQSXRu2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgiVxh91; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d895138ce6so25936351fa.0;
        Tue, 09 Apr 2024 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712664383; x=1713269183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2e3wrJjk3kEfLUNGf9zPzelRPu7eNx73fHKPEVAegg=;
        b=NgiVxh918xP91PR9FUwnS8ND0DE+fGfuyjGC7duih6kWsVJj8w+2PLA5S5zjIxwF4l
         2RgjgM/AWE5WWPUwelLEXL+qP0647fy6QAwFY+tIL8QTfQmOYcGL1LaQduHnQBjSV6Ak
         qZ11hQKBIWYorSFbQxKXe0Eq8tF5mU25//1HMpiblwwjGN8kJ3rkrQJqMbYrixtt/okK
         iy1x5W+ngtJ2SEjKxr110EAZfM0N/UiQs7tY/34HH6yg3BWNPIGq1jT5yuya4WZGPb92
         1Vb22zMxJ+ltorLZteDpN8SJ+8OJVH2WUOPqJKyVhQH/mTYx1x6it7AyQ368z8z6maFx
         FHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664383; x=1713269183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2e3wrJjk3kEfLUNGf9zPzelRPu7eNx73fHKPEVAegg=;
        b=Ey9cWttVvXzd6YQIN/licnw5av5gppo9qADQMUg4LtTWSjHPm7VDF0x874bSHdcgjD
         OVoKmPMcLHzDzwUm4OGVBnyjRc4A64zo8KZ8AlkBLeyCI+TclabuMAeKDyEukV00WX9F
         35qopUUnGxIOya7rzp81IpKY4nmgm8hvSP/PoMhbpdhMlEwgNtd7EcJ6UHyqR/RxGcyL
         Goyj741l6RDExo4/lfSTJEA35fGgSituvKg3lrx4llPQ+4SxBh9WVftHk9fx2oyo4/0p
         feYSFPMiTSO8huP5cVn4pZMe6IEQlmZ88pceEnQvxNOUwbfUA+LbpOLlSZlMG9LDwTrS
         vEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHU6GPHqBMEyouL6qH7KyiSsjP9dcqy9ZZ+Ors2PFH1+7QnHw7rE8IXbKyAQu3kXOH7ZogRm8270cX3oZ5mGksWrZUy5j+46rXHeJTb4B+7b6Q94mI1Qes4mvzknBW5pJRFVjwhb/+C9V4E0aBh+2/msn/Wv9cbSKQzmTLwTn5NZRj46OspIZTCSjUaZMCKKEF7e5bPeSdxSW6SVqWfgcg
X-Gm-Message-State: AOJu0YyFsZICz32jkfSiRa2MqdtQia9CMna976bFJCoxWPES3++lrlPh
	u0q3JP9SnaT/7u058a8e6ug6F2fBJEbdmPmGdYgpyJReHqzwHM20
X-Google-Smtp-Source: AGHT+IHXzOkvkWMebnxceaPO+vdv3DDY9CB9H7+Am5m9tWr9T3xJlv7LNxMmkT69DJVbV3CHB7waIw==
X-Received: by 2002:a2e:890f:0:b0:2d8:2cd3:aa59 with SMTP id d15-20020a2e890f000000b002d82cd3aa59mr7789697lji.37.1712664382786;
        Tue, 09 Apr 2024 05:06:22 -0700 (PDT)
Received: from krava ([2a02:168:f656:0:bbb9:17bc:93d7:223])
        by smtp.gmail.com with ESMTPSA id w15-20020a05600c474f00b0041668770f37sm8111100wmo.17.2024.04.09.05.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:06:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Apr 2024 14:06:19 +0200
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
Message-ID: <ZhUvO4lHn-xh3jDm@krava>
References: <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
 <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
 <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
 <20240404161108.GG7153@redhat.com>
 <20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
 <Zg-8r63tPSkuhN7p@krava>
 <20240405110230.GA22839@redhat.com>
 <ZhQVBYQYr5ph33Uu@krava>
 <20240408162258.GC25058@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408162258.GC25058@redhat.com>

On Mon, Apr 08, 2024 at 06:22:59PM +0200, Oleg Nesterov wrote:
> On 04/08, Jiri Olsa wrote:
> >
> > On Fri, Apr 05, 2024 at 01:02:30PM +0200, Oleg Nesterov wrote:
> > >
> > > And what should sys_uretprobe() do if it is not called from the trampoline?
> > > I'd prefer force_sig(SIGILL) to punish the abuser ;) OK, OK, EINVAL.
> >
> > so the similar behaviour with int3 ends up with immediate SIGTRAP
> > and not invoking pending uretprobe consumers, like:
> >
> >   - setup uretprobe for foo
> >   - foo() {
> >       executes int 3 -> sends SIGTRAP
> >     }
> >
> > because the int3 handler checks if it got executed from the uretprobe's
> > trampoline.
> 
> ... or the task has uprobe at this address
> 
> > if not it treats that int3 as regular trap
> 
> Yes this mimics the "default" behaviour without uprobes/uretprobes
> 
> > so I think we should mimic int3 behaviour and:
> >
> >   - setup uretprobe for foo
> >   - foo() {
> >      uretprobe_syscall -> check if we got executed from uretprobe's
> >      trampoline and send SIGILL if that's not the case
> 
> Agreed,
> 
> > I think it's better to have the offending process killed right away,
> > rather than having more undefined behaviour, waiting for final 'ret'
> > instruction that jumps to uretprobe trampoline and causes SIGILL
> 
> Agreed. In fact I think it should be also killed if copy_to/from_user()
> fails by the same reason.

+1 makes sense

jirka

> 
> Oleg.
> 

