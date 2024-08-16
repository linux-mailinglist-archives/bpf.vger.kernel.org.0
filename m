Return-Path: <bpf+bounces-37380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F48954F81
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642E71C20FCA
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C42A1C0DE0;
	Fri, 16 Aug 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8GWKdEh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B043136E30;
	Fri, 16 Aug 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827846; cv=none; b=fUe/M5qmMMM4xByNF13ZsAWzNpqMFSpEiOAoOqf6LU+TUiALG6AVKSjCofSRFncQQlgFi8zoMpFr3cokBVj1qbMn0jc5+L4cAqX0lugy1gK73fFVcx5JdzqO0BQumD3O3wEzMni8CiEBS1Ew3IJessW+ijle3EBUJp7CzwtvB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827846; c=relaxed/simple;
	bh=wuYag45KCCMNPdVOTNXs6hx1m9ceBhoFn44hOT7ug0w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klSUvmw0xl2GioLfypHOZV/YDsMMyHsarg7nnIbcy4uF6AalXGz+Mu8ulWQkwjV8ldQ31UYEDJPs/EbzgQJsbUfCQdfMhpHnSiLUwmAXNGNMMuZw3ld7imZwhJdqrkZ74mIro8SCFCVXUYsItwrMKwtzTa3eUuLYnldaB4prA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8GWKdEh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a9e25008aso293038866b.0;
        Fri, 16 Aug 2024 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723827843; x=1724432643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nsViohMsVlT1Cr/vk07GM1E4ZDq3GRRcVAXcInsaHcE=;
        b=U8GWKdEhFbV+oScjo0uKWWVDDzCEuz/Nz6RJ1PUGQWg7DvRx7fU98z+JY978VfYjKD
         nY8JI5CmtYDlHUC7lZHiG+zIWGe098qoa+5CaRknVQqX9P5A7ahpMbWrz3OzfA6kKg5K
         pbxsTjtePFo4zOBuiYedrBxDDTHbiC1kVcyViCFaJkxZkg08Cd/SbhF8sC6C8645GtbG
         yKprHrI/fLPD1uxVTZDbbbC85uiUhE1047YJmtwnGRTW5DEudxAHFODVaqmu9kJYHGuO
         v23n7v9qvsT6jQowlVK66/TrB+4Aspwa+NHPoxlulUOImE+NUJrSjjLzmCxG0pkpfByb
         Gcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723827843; x=1724432643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsViohMsVlT1Cr/vk07GM1E4ZDq3GRRcVAXcInsaHcE=;
        b=pHRPCvu1CL5y7EWNyTOteAf09i9lwxYtkln8AwsgBLrPgNIHkwRMLGpFaIURmJ3CT/
         wKVI8nqDjPLzxKonFl8gQvTrKs/0+BDUzoNZegrmGp10rS9TYhbdwIEsaL63jDzzBwvp
         EMTUBgyPS6Id6ui2Fo5HPjQaa06HzsZEc4JnIsAJc75MiKtdU7iLQpPxTVef6ZVNTrIc
         l0qBj6oX5Uji8KiWNg4he92kRqWvUav+dDQXOdzvy/mlc50ZxLWMuRy+Ai90T1t09mJz
         YPctpR7XlKkRFsMhw3Ob/wKXfTdIWetSFBEAi92APUUglty+xrdSD3aHXrTCqlIwPhcA
         8YAA==
X-Forwarded-Encrypted: i=1; AJvYcCWu3Bwc1yYKpjnCgyz2ablcowCO572uf95tEsh/GChL3d0jk27DwlniL1ktMAXfMS+0ZAkFAowfvpP4FU5cWhC/VoB8lclIg/IRkDTI1tlzg4uty/6/KaO0Nv1B9WxhwYrBfrFNQuJgk4kV8FYIyi71d+mUenCfIz47Tw1iyqkRbffCqCEYaqcTPjpLXjHvbu5CCH4j6TniSPI47Pr7QRc0XRCpQ8bnIdKG7vUjwcOF0NsieXnGYRA7CouP
X-Gm-Message-State: AOJu0YyXn+LZvKzACtSB53sAQGzxim0Dyo1RwDFr5KAO+2pNcru1QlXK
	y/rh4Fno10u+ROOgru/8I+Cp+e8T10OhfqkgjAn0VVdokhS/lp45
X-Google-Smtp-Source: AGHT+IGmQHqLgP7Yyh+oz/nFR7ZhrguSPynoN6KhTrPqXBYW/CiVRsTdzvtIkZTesS8hMABI8OjPqg==
X-Received: by 2002:a17:907:e6e4:b0:a7a:a33e:47b6 with SMTP id a640c23a62f3a-a8392a4b3f4mr270755866b.60.1723827842255;
        Fri, 16 Aug 2024 10:04:02 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383948d19sm281827466b.186.2024.08.16.10.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:04:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 Aug 2024 19:03:59 +0200
To: Alejandro Colomar <alx@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv8 9/9] man2: Add uretprobe syscall page
Message-ID: <Zr-Gf3EEganRSzGM@krava>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-10-jolsa@kernel.org>
 <20240611233022.82e8abfa2ff0e43fd36798b2@kernel.org>
 <3pc746tolavkbac4n62ku5h4qqkbcinvttvcnkib6nxvzzfzym@k6vozf6totdw>
 <20240807162734.100d3b55@gandalf.local.home>
 <ygpwfyjvhuctug2bsibvc7exbirahojuivglcfjusw4rrqeqhc@44h23muvk3xb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ygpwfyjvhuctug2bsibvc7exbirahojuivglcfjusw4rrqeqhc@44h23muvk3xb>

On Fri, Aug 16, 2024 at 01:42:26PM +0200, Alejandro Colomar wrote:
> Hi Steven, Jiri,
> 
> On Wed, Aug 07, 2024 at 04:27:34PM GMT, Steven Rostedt wrote:
> > Just in case nobody pinged you, the rest of the series is now in Linus's
> > tree.
> 
> Thanks for the ping!
> 
> I have prepared some tweaks to the patch (see below).
> Also, I have some doubts.  The prototype shows that it has no arguments
> (void), but the text said that arguments, if any, are arch-specific.
> Does any arch have arguments?  Should we use a variadic prototype (...)?

hi,
there are no args for x86.. it's there just to note that it might
be different on other archs, so not sure what man page should say
in such case.. keeping (void) is fine with me

> 
> Please add the changes proposed below to your patch, tweak anything if
> you consider it appropriate) and send it as v10.

it looks good to me, thanks a lot

Acked-by: From: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Have a lovely day!
> Alex
> 
> 
> diff --git i/man/man2/uretprobe.2 w/man/man2/uretprobe.2
> index cf1c2b0d8..51b566998 100644
> --- i/man/man2/uretprobe.2
> +++ w/man/man2/uretprobe.2
> @@ -7,50 +7,43 @@ .SH NAME
>  uretprobe \- execute pending return uprobes
>  .SH SYNOPSIS
>  .nf
> -.B int uretprobe(void)
> +.B int uretprobe(void);
>  .fi
>  .SH DESCRIPTION
> -The
>  .BR uretprobe ()
> -system call is an alternative to breakpoint instructions for triggering return
> -uprobe consumers.
> +is an alternative to breakpoint instructions
> +for triggering return uprobe consumers.
>  .P
>  Calls to
>  .BR uretprobe ()
> -system call are only made from the user-space trampoline provided by the kernel.
> +are only made from the user-space trampoline provided by the kernel.
>  Calls from any other place result in a
>  .BR SIGILL .
> -.SH RETURN VALUE
> -The
> +.P
> +Details of the arguments (if any) passed to
>  .BR uretprobe ()
> -system call return value is architecture-specific.
> +are architecture-specific.
> +.SH RETURN VALUE
> +The return value is architecture-specific.
>  .SH ERRORS
>  .TP
>  .B SIGILL
> -The
>  .BR uretprobe ()
> -system call was called by a user-space program.
> +was called by a user-space program.
>  .SH VERSIONS
> -Details of the
> -.BR uretprobe ()
> -system call behavior vary across systems.
> +The behavior varies across systems.
>  .SH STANDARDS
>  None.
>  .SH HISTORY
> -TBD
> -.SH NOTES
> -The
> +Linux 6.11.
> +.P
>  .BR uretprobe ()
> -system call was initially introduced for the x86_64 architecture
> +was initially introduced for the x86_64 architecture
>  where it was shown to be faster than breakpoint traps.
>  It might be extended to other architectures.
> -.P
> -The
> +.SH CAVEATS
>  .BR uretprobe ()
> -system call exists only to allow the invocation of return uprobe consumers.
> +exists only to allow the invocation of return uprobe consumers.
>  It should
>  .B never
>  be called directly.
> -Details of the arguments (if any) passed to
> -.BR uretprobe ()
> -and the return value are architecture-specific.
> 
> -- 
> <https://www.alejandro-colomar.es/>


