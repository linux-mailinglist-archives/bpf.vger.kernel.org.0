Return-Path: <bpf+bounces-48779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E28A10907
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844F83A53BD
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE10E142E9F;
	Tue, 14 Jan 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N23bPLBH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91411130E58;
	Tue, 14 Jan 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864362; cv=none; b=M1nhfMoG+KfYZB7ct3rsGxSJEDz0qJeA8eJ1kNGpcUPIY5VISm/Lw7SrVDQ5B+0DFmA57a6P+QNTD5sGeCn3uJ2LgkEktodYdwethQQ6bWVspvZUnZTICsKeZ5UQKYMJkYLuauMPQWu3yP8rWGbNfOUb7UhB9KKkCr2y30ULT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864362; c=relaxed/simple;
	bh=ny4L4LPo5vA7xZZrNMtu7tjNQo7DrhSZzVllvL95yh0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G63PeTUuo4v2BBD3jr7xk0rjadfvoWq5u4QOValKd6cfi9hubEN+mspY86xFjnumdJgrub1Kwle3xwpb/KV9CKwpCWMwiOqfqc8wSLUI4r9KgaCftTVkST1yNnKki9LCy8KbjMr3dNGiLmJS8ucgCMWsmk8F2AqnYJxPQIcAe98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N23bPLBH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so792289366b.0;
        Tue, 14 Jan 2025 06:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736864359; x=1737469159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cx1wKgftUrggncpdaxijtdrURHMNcMHBwKBUZEcKcV0=;
        b=N23bPLBHIeJQx8VOSMdLf3rLWTZhqMRiwAd070sQIbYVk5ttqlLUkov4Be682tF/SQ
         iFojLHsJglx6h3LzP++yLJAe266LjnwV5SiYbeSuS4Ai5joFBi9IIYh2QBjlo9n05Zb/
         825oy5rA5l6dMAewBWc2anJZ+HfEC2aGt/FH2l2rKY8eyoOC3r2CUcNSoixnsyP1zYbF
         /i0LRizf9yRv7JuDJaaR8G4MJeBT70IUysXGpnlxe02v6jcIHlVL+4+5wcpdA71E9r0T
         YCva+abiFSas98oNCl2o2sbeY9ei0LWi2K3NUkUPfVQzJDcZLLbOXkKsZxH3EFynxHUc
         YhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864359; x=1737469159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx1wKgftUrggncpdaxijtdrURHMNcMHBwKBUZEcKcV0=;
        b=mqrme0+075wyd2VwsslcD/HJ4ZbBXpyEQShVfCZsRV7XnEZkXjL0Q7GtUiqe8slMXs
         lVY98Tgf0PNoGhqKY2eUgi9yvtSLbThyAShsMRuNMLNtczLcmfazzMpHpDNbO/14eWSM
         RTJoVD/Aju4QlAQNZjz6xZzwcoZRbG8AO+69l8ErVlf+e7KMiK/Tb//8HseQrAuEW+XM
         rDjXWvdt2xT2mR6AGg4DYvhGOZiolUnJ22QnSEnLn3nZxEzoHY1iNqtN/vifFqU4XtP+
         8WTsNUNk1LDCjGXt7Eb+l3rrGgmRifaA+hBKFmN0h+ZT0P24XraiBmaRuvlOiloy6F2K
         acyg==
X-Forwarded-Encrypted: i=1; AJvYcCUXypHX8IL3o/fyijsPwlGGhOvwToSsLo4m8dp+Il12GvNtf+Xg8ckxJu78Jxok/hMP7Hk=@vger.kernel.org, AJvYcCUejJijzaEXHTB/XUnkanOVOmi7Vu06oWEVuENWpc8sBadfI7tQSl7h02jMg96b9Pzz04c5/TXrFAm+lnLl6JRlM6bo@vger.kernel.org, AJvYcCUhFVw4xETn8U+K/LSN/JL46n7iCc/0zEt091L2QvrGabwAv+7keIquMBTB14ujRJcSFe9Uuo6rOttN@vger.kernel.org, AJvYcCVz+kUqehnIHVrrHOlxtu7e5QzWndveLULBVvHQ8b8+kVN/ygl4bcn3WBx+L9NhpJKne0uxIq5Oz36QCIRV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1HLloill8fIBRepepHSjgpnJCVaOD216y3Di9Fs87G/grImnb
	gXdvBROs+5p3jnli1bSXdJdbAilyXbYQdDOLiij+JxpJ8x7E1WjA
X-Gm-Gg: ASbGnct4Fkr9a/1ELaxZgZE61BIJNeNjTKmh0MotBiE/3zMHSfAE+xJCmwp2MOVxOK4
	1VTMtZGzYRT4ljAaBitz0eiIplvDTTFvmDB2TX6aOO/ZACE697HgxVkvb1LWBYK2cJ8KpFLcGJA
	vFmwbEuJmKIe4V141v0Qd7pmK/6DT6DJZS5vMCtgHvD5jhCj+y7AJADkuJ3QdeTZHdCSJdTJRer
	x5svo5T59rQabnh8bMr65g8LnaBJXnHYxzgeinoQ3s=
X-Google-Smtp-Source: AGHT+IEbCm45F9Lp6VAFUIPPILkKB+i0VidmNZ4No9XerQAqWiLazSW+RH7/uOy6dteOvZjGFvFBdg==
X-Received: by 2002:a05:6402:1eca:b0:5d6:688d:b683 with SMTP id 4fb4d7f45d1cf-5d972e0b18bmr58457103a12.9.1736864357373;
        Tue, 14 Jan 2025 06:19:17 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046e048sm6077873a12.71.2025.01.14.06.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:19:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Jan 2025 15:19:14 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <Z4ZyYudZSD92DPiF@krava>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114105802.GA19816@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114105802.GA19816@redhat.com>

On Tue, Jan 14, 2025 at 11:58:03AM +0100, Oleg Nesterov wrote:
> On 01/14, Jiri Olsa wrote:
> >
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -315,14 +315,25 @@ asm (
> >  	".global uretprobe_trampoline_entry\n"
> >  	"uretprobe_trampoline_entry:\n"
> >  	"pushq %rax\n"
> > +	"pushq %rbx\n"
> >  	"pushq %rcx\n"
> >  	"pushq %r11\n"
> > +	"movq $1, %rbx\n"
> >  	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
> >  	"syscall\n"
> >  	".global uretprobe_syscall_check\n"
> >  	"uretprobe_syscall_check:\n"
> > +	"or %rbx,%rbx\n"
> > +	"jz uretprobe_syscall_return\n"
> >  	"popq %r11\n"
> >  	"popq %rcx\n"
> > +	"popq %rbx\n"
> > +	"popq %rax\n"
> > +	"int3\n"
> > +	"uretprobe_syscall_return:\n"
> > +	"popq %r11\n"
> > +	"popq %rcx\n"
> > +	"popq %rbx\n"
> 
> But why do we need to abuse %rbx? Can't uretprobe_trampoline_entry do
> 
> 	syscall
> 
> // int3_section, in case sys_uretprobe() doesn't work
> 	popq %r11
> 	popq %rcx
> 	popq %rax
> 	int3
> 
> uretprobe_syscall_return:
> 	popq %r11
> 	popq %rcx
> 	popq %rbx
> 	retq
> 
> and change sys_uretprobe() to do
> 
> 	- regs->ip = ip;
> 	+ regs->ip = ip + sizeof(int3_section);

nice idea, I wonder we get the trampoline size under one xol slot with that

thanks,
jirka

