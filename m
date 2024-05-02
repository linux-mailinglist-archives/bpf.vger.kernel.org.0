Return-Path: <bpf+bounces-28478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B88BA173
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 22:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05165B22CEC
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92075181BA8;
	Thu,  2 May 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYA8wDFB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793231802C4;
	Thu,  2 May 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680799; cv=none; b=If2RI4y2im+E8gBd1GveRyqdBcev2QjjLc1LqNWxwytGANXKXcVwu21PexrrL7ZhoCFU88cqgzCW7Ll39PCG6e6bOfjzDuf8Up9omJbWdsb0PqAHmdgxVq9MaKRrMOGkRAfgohIdGcTHBwa9fV5WgGFUKHVA2giJ9GX0hR0sxZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680799; c=relaxed/simple;
	bh=jk87aWQc77TF92KtV0+wN3JD3XrihNgxj8GvIBdQSv8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hULknYto/TdLmSEMmSj6qZHt3mxy3z2437i2f/kcLInWLjr/FLQEQ6UAcPy1AHTIpD6NlPf/KBpTF33Odct88Au4jEDN7+psg0N+nlp0awd4ZgZ2DgFz3Roex45H9o4BUwrUhgDW5EzYo/JGc/HhPR+yaSP/B00M/ToMvJRcDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYA8wDFB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so100995631fa.3;
        Thu, 02 May 2024 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680795; x=1715285595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A/VFRhG6UVmzgaQgZ92iFW2gF72/w57usEzS+XlOtLM=;
        b=BYA8wDFByjZGdP/bBWc5vIMKfRxNpUKqFRAuYwdfN6vrCPAhCmx3q4qX7AMTdeuIs9
         ne/oq5lUFXLsHZQ0BWoV8xVXYebRIaMPsQir6jKalZHjGLTlVNOlu3sg2rce/9rfEN4x
         AHCCIss0w5z8oFditayaTAU4tVMhn648GFZAYiFt0LdKV98qLwLVoXKc9mDgweF4CtpR
         dIIYKdt1WaPsZzaq20aR8sSPs9dsOPfTwoiIGF3l5JcXuAoaIEvPvLM1Npno3+D3DPOj
         4XCt0jOaqXXQsZZumJSk9hJDosm2l8leY2GDrJdPCBTTFNByT+pvc31aCleSS/SdOkiY
         TEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680795; x=1715285595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/VFRhG6UVmzgaQgZ92iFW2gF72/w57usEzS+XlOtLM=;
        b=Xx96iigaxcRkFMtyeYxwq3hnrXJsZHi4I6eC9moLH/b1FKA0fF4IcQv7rpalh0fLRi
         XRyMs4v5QjozUGKow1bTeWQ+ukt1xI194AH9+ec+Md+MJ4pOriEAeLL7CzpQoD9bjnIH
         21ia8qa+/1l86rclmyz0ggwOmGfYRtas7d72l6bPvaCWfDzLxzdh5pEHxMloRmjTUJrP
         4O5aKVS9+/Mu0O8kIM44I4rIEXM0GHOILD26NxrExUd/eBX/pVnr7HsnByIe8rpy5Yqn
         Y2NjtbSQAaI2MvhPfSWJKHlLYpt/VLI9+Ro2RmdhdltkLKZoSJuLOUol+eN7nel2O3T+
         Grfw==
X-Forwarded-Encrypted: i=1; AJvYcCVmRCS9u4U800QaLcWY3i4IqbWijkd+Ho/F9RPB9CWyeKT/cLnM3lBorNxHezpVKBZXJwMwa+I27Yj7Mb5J2D88s5umVpV4BkGnq7tdC2Q7PtKHHahfV4ywCp3HpTyS3cnURp5ggGymYXUgaYwACIpqIKgb5g/jmAkWtM8+J+slMFRNnrVHa1FHP3ZsIH1G+aXogxHc/axVF2hXz3ZVOs8diDP28cdrsNWWW+ZsJKegO24++72b40Byx+Ii
X-Gm-Message-State: AOJu0YyIvaEeZqzHwlB5Gw58KlqT4+aw9BYddOWa2TMfnpbFXdewGDJ1
	WWx9kakVJcDzQGOjrnyQjzH9b+TwJ84AR++bldl0547UyoKcUD+a
X-Google-Smtp-Source: AGHT+IFGfNaIMa/U0YcNFPZC/U92e0WGxqwV9yD85i1pkJ8ivQCSt+etW0CCzqk9pKTDT95SYuPUDQ==
X-Received: by 2002:a2e:b601:0:b0:2de:7cc5:7a27 with SMTP id r1-20020a2eb601000000b002de7cc57a27mr490128ljn.5.1714680795256;
        Thu, 02 May 2024 13:13:15 -0700 (PDT)
Received: from krava ([83.240.62.36])
        by smtp.gmail.com with ESMTPSA id j5-20020aa7c0c5000000b005723bcad44bsm851328edp.41.2024.05.02.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 13:13:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 May 2024 22:13:12 +0200
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
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv4 7/7] man2: Add uretprobe syscall page
Message-ID: <ZjPz2PWrW2BjXxlw@krava>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <20240502122313.1579719-8-jolsa@kernel.org>
 <ZjOYf_g2qRrhDoQD@debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjOYf_g2qRrhDoQD@debian>

On Thu, May 02, 2024 at 03:43:27PM +0200, Alejandro Colomar wrote:
> Hi Jiri,
> 
> On Thu, May 02, 2024 at 02:23:13PM +0200, Jiri Olsa wrote:
> > Adding man page for new uretprobe syscall.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  man2/uretprobe.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 man2/uretprobe.2
> > 
> > diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
> > new file mode 100644
> > index 000000000000..08fe6a670430
> > --- /dev/null
> > +++ b/man2/uretprobe.2
> > @@ -0,0 +1,45 @@
> > +.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.\"
> > +.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
> > +.SH NAME
> > +uretprobe \- execute pending return uprobes
> > +.SH SYNOPSIS
> > +.nf
> > +.B int uretprobe(void)
> > +.fi
> > +.SH DESCRIPTION
> > +Kernel is using
> > +.BR uretprobe()
> > +syscall to trigger uprobe return probe consumers instead of using
> > +standard breakpoint instruction.
> > +
> 
> Please use .P instead of a blank.  See man-pages(7):
> 
>    Formatting conventions (general)
>      Paragraphs should be separated by suitable markers (usually either
>      .P or .IP).  Do not separate paragraphs using blank lines, as this
>      results in poor rendering in some output formats  (such  as  Post‐
>      Script and PDF).

ok, will do

> 
> > +The uretprobe syscall is not supposed to be called directly by user, it's allowed
> 
> s/by user/by the user/

ok

> 
> > +to be invoked only through user space trampoline provided by kernel.
> 
> s/user space/user-space/

ok

> 
> Missing a few 'the' too, here and in the rest of the page.

ok, will check

> 
> > +When called from outside of this trampoline, the calling process will receive
> > +.BR SIGILL .
> > +
> > +.SH RETURN VALUE
> > +.BR uretprobe()
> 
> You're missing a space here:
> 
> .BR uretprobe ()

ok

> 
> > +return value is specific for given architecture.
> > +
> > +.SH VERSIONS
> > +This syscall is not specified in POSIX,
> > +and details of its behavior vary across systems.
> > +.SH STANDARDS
> > +None.
> 
> You could add a HISTORY section.

ok, IIUC for this syscall it should contain just kernel version where
it got merged, right?

> 
> Have a lovely day!

thanks for review,
jirka

