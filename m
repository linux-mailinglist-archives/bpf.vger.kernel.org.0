Return-Path: <bpf+bounces-67396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCDB434BE
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 09:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D135E6A81
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1306A2BE04C;
	Thu,  4 Sep 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1XIUPu1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635D2BD5A8;
	Thu,  4 Sep 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972579; cv=none; b=lwcoJI9TX47rTwOFMBNwLNCcoGH3HBiYqfSIdFbi0rQM3X726GJWTuB23ugFyZ5p/UmB+WR2gnxEngGUi2OmvDeeInu5kda4hMUor0pCe/V3Wc5dYvXn1RzQV1J9FoxqnsZHgzUkv23oiLthaQAn/Bu+alZMoj1pzsd1MsinlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972579; c=relaxed/simple;
	bh=KaxI14PGx+2va8d76I8IO6QyJFhwddmPV6YbW4b5a7Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL8bDn+3L2hfQfetMCZdPvpYTEyxor76ocCBpzZp+wpVVOQ6SSGA9fqsd+CMxz05BaM6+lmBZygCiYx3HZmEKApMeVkI1Hq/G7/cOwxvOD9YdPmK26yJ+DPkv7w7ZP9pCMRkYPTpavuA8A7wSz5hG1YgS1COKVMjb7u9hlkv4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1XIUPu1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b04770a25f2so100595566b.2;
        Thu, 04 Sep 2025 00:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756972576; x=1757577376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eZ8jod7Af56ytSP2ydZ4q7A0RJBJCc32H7x6V6cO39I=;
        b=O1XIUPu1BoT5p3jZcIqs250DLC9CL6QUSJN69+8ny5xXZHk3fUbJMRqS3m3p5MK0EA
         YWx1gQW3uM56V2ZPSfn790nwyfuacmxsCvkKjrJ/uQ9iJ2OXNBbJtgP/LYQfRChQtupw
         2CGTu8c4OoSQsR1CD0Cb2jsudbjm5686nYYdJbk81PGqDSzw6kB+ScLAkulrBrd0zNWZ
         aoYZDa/qTJqGhfjmpqB7bRFOVhksQc9NQ4ac2GxIvihF66noLsZVJrR1GKb/H04WI4+b
         Kyo60U4U0436xvY0sNGjGkS3jrIC4pz/ys58OJhsYgiPuGzr4/kK8LFEE8LzrqjXRlmc
         KeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756972576; x=1757577376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ8jod7Af56ytSP2ydZ4q7A0RJBJCc32H7x6V6cO39I=;
        b=hscIZZwQs8RbXXy/Y3brSINSQ8Rcj3IIXi34EfP/31JARiWAwBeEThVlX3X0Cvw0rv
         M9Rfkpmu9g6oJTgjxpOePKFNa8AJSerjAXNopi5x3eyCorjtHDa26sakF4AZ06Mwq60D
         N3OwvF5y82AioHG01jsA4uSMxYXPf+iWhugXY+eBgjBXnsDwryAQOVJ5mfZdX+rNR1pp
         Q64ajC+yBJ74R4yl2ZmHtmG7Zzs1WWuGA7HnXh0rIkEA6i2oPYdoyeE2r7ejHq7Ybv7A
         tQODTCkYcpVPEL/T+Wmh8kyIDc7cUPtX4oAKiDg/tccn1j0h7NtL5zjX3Rj8OWHaWb96
         Gp5A==
X-Forwarded-Encrypted: i=1; AJvYcCU11A5DCCDrz2uJkhxYWOgcWsIkzRGBcTjP2/8S+eNWIuVb+OO0UfFhUmun+5p1NHd7Ln4GreYU1rEW7niQREJ7giTR@vger.kernel.org, AJvYcCU8JD3xul9F98AhMBmHg8i+49iqgxXRGTCZQNca1iAjdERac8P4UPIxRF+pooWe0MxmfddZazIGcNpH09x0@vger.kernel.org, AJvYcCX2E/Y0SEILnNJ5yYZA+KZSS4R+A6FhIuwEJCrgcUQCau83umQ2WIcz9jzv8/OMhpLJoaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyf9FEvHRvBmN1wTc1XU01KpZRTpwcYbzhJ24h+zszrOY90DAl
	ISCYOFbXKDntCNIGWzQ7jcaPMSDN7MV3MuvtasTbXHb3585WV/xG2NTp
X-Gm-Gg: ASbGncsFK2+Hzar03iYJgkE5MavFQxzyrdO4+pyH4qtoaAVqUzNfexReu7cx7QzlCNm
	kS8wesstgovjX8SNAoR8RkdWNRgPCKBF3I5Fz8R0Pmi1n2/4RtcD5AvAMHvjVgUSbNtT/zSkVsK
	tyh7g+yw3M+rFZzmzRdQGACqqRre/q+HSBvRj3NU3HFt2lI8PP79wGNbYzJe1tdzqxAduMXjqMB
	HqusaF9cBYcIK5g/Rm3grQ19Oczj72hOtmGargSBeDVJ6/luIFZivLR/cEmqtQlkNmfw0KOrvnK
	oRImdLoF4DfWnRhkw7lzxgwLB6gnDmDeHCx99Wo4OKznFwoZMdHac/kuhv2KbifdXg+zN6g/Tog
	TQd/Kirj8DLYc/vXhypwoD7GoV0n+DJ6x
X-Google-Smtp-Source: AGHT+IE8ZYTZ6PG3uV+NaUilMh28NQOiuNYmEFxVnG9FaTM0hi8Bsp68jmqpA8bcoET0M2dRNp7x+Q==
X-Received: by 2002:a17:907:3f9e:b0:b04:33a1:7f11 with SMTP id a640c23a62f3a-b0433a18511mr1259366366b.26.1756972575999;
        Thu, 04 Sep 2025 00:56:15 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff173ddc78sm1331075966b.33.2025.09.04.00.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:56:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Sep 2025 09:56:13 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <olsajiri@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <aLlGHSgTR5T17dma@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLirakTXlr4p2Z7K@krava>
 <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
 <CAEf4Bza-5u1j75YjvMdfgsEexv2W8nwikMaOUYpScie6ZWDOsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza-5u1j75YjvMdfgsEexv2W8nwikMaOUYpScie6ZWDOsg@mail.gmail.com>

On Wed, Sep 03, 2025 at 04:12:37PM -0700, Andrii Nakryiko wrote:
> On Wed, Sep 3, 2025 at 2:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Sep 03, 2025 at 10:56:10PM +0200, Jiri Olsa wrote:
> >
> > > > > +SYSCALL_DEFINE0(uprobe)
> > > > > +{
> > > > > +       struct pt_regs *regs = task_pt_regs(current);
> > > > > +       struct uprobe_syscall_args args;
> > > > > +       unsigned long ip, sp;
> > > > > +       int err;
> > > > > +
> > > > > +       /* Allow execution only from uprobe trampolines. */
> > > > > +       if (!in_uprobe_trampoline(regs->ip))
> > > > > +               goto sigill;
> > > >
> > > > Hey Jiri,
> > > >
> > > > So I've been thinking what's the simplest and most reliable way to
> > > > feature-detect support for this sys_uprobe (e.g., for libbpf to know
> > > > whether we should attach at nop5 vs nop1), and clearly that would be
> > > > to try to call uprobe() syscall not from trampoline, and expect some
> > > > error code.
> > > >
> > > > How bad would it be to change this part to return some unique-enough
> > > > error code (-ENXIO, -EDOM, whatever).
> > > >
> > > > Is there any reason not to do this? Security-wise it will be just fine, right?
> > >
> > > good question.. maybe :) the sys_uprobe sigill error path followed the
> > > uprobe logic when things go bad, seem like good idea to be strict
> > >
> > > I understand it'd make the detection code simpler, but it could just
> > > just fork and check for sigill, right?
> >
> > Can't you simply uprobe your own nop5 and read back the text to see what
> > it turns into?
> 
> Sure, but none of that is neither fast, nor cheap, nor that simple...
> (and requires elevated permissions just to detect)
> 
> Forking is also resource-intensive. (think from libbpf's perspective,
> it's not cool for library to fork some application just to check such
> a seemingly simple thing as whether to
> 
> The question is why all that? That SIGILL when !in_uprobe_trampoline()
> is just paranoid. I understand killing an application if it tries to
> screw up "protocol" in all the subsequent checks. But here it's
> equally secure to just fail that syscall with normal error, instead of
> punishing by death.

adding Jann to the loop, any thoughts on this ^^^ ?

thanks,
jirka

