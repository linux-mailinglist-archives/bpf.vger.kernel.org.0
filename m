Return-Path: <bpf+bounces-30297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D716E8CC0B0
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 13:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD851F23916
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8004313D53F;
	Wed, 22 May 2024 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTS0mQxV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C6713D52B;
	Wed, 22 May 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378747; cv=none; b=kcwKnWgvPo7Lc6A9Nz2uUWGpOonY5y6WK+1EuJqaccLQU6rZ42bB5RO7/0NOM3ePGJJsp0pHeKvfeXoXBCr3e+FITNRNjfQ5BzjsMxU/Kb0jQiiLQNDEveTJ1aqK7WxgZ4+e46VGfL9HjLXdTuTzLwZPfmkYWK8vS9Zl5AXVOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378747; c=relaxed/simple;
	bh=V0ezwHb1SaiH1+ZYoXStNv5UQt4JId9YALb5RVn1Ucg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIgmgWHh5TBmflwLpdMm5QT7jL8/0pfmt0iU0DhFFwes4ydF2WOYf2jOrEB+HUwwLppPLaVYB7FiCdu7Pswofur2/54UKKXGc13BSla4d7aEf9vNiKb29fOG1HMNvlV33t1P6lsjnGt9pxXp6lh+cZL3RZyUSO6AGCBE8CIWxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTS0mQxV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a88339780so957421966b.0;
        Wed, 22 May 2024 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716378744; x=1716983544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2NZDi+r+QkvMtUro+zrAmR/vp+4eEqWnBDxJ0ocZk70=;
        b=QTS0mQxVKuYpkYFd4xHjvbC5PCdjAlWft83wvb8Kuyt7xqnMb5r43mQakXOO/EH78a
         knlLqWeHix+JyLQ5LNc70rG8eEl/0y3CgTVKf8Ful0JC5UgRP5lTIJB7cLKv1m1CIoZD
         CapcGdslDBrJpq1gCvwvaddtVVHuDcjlhDlJQcBopCEFD0FrFo90I49rikiA7FqanzGt
         e5NNdrMWgeUi7P0U3+M7wVTG9XO02UB04lIR5arWfJ4FjMGTjiThE9xWHD6F5OplBwD2
         QxLA6p08wnngMk23/a3A+EJR+UhMjhP+8ryXZovggwi66abtXPhQ/N7Z2l2ZNaqm2Rza
         vUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716378744; x=1716983544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NZDi+r+QkvMtUro+zrAmR/vp+4eEqWnBDxJ0ocZk70=;
        b=Gfob/p5cWXjhaeVJ2PLeQFHo2v2tKyiPq5UC3b27ftRmedErTUhFaojJDIkceLqofs
         lU6gs5T/lfDe/w+TpnxFqgwhxRg39zttNLzJoH7NphJMtPm33EaChivE7hQyIo3XM34P
         12kla5e0jpe7Zbzu/XkcE00sN+pENUnOtGw8FnrEjJPekNUCwMr/F4vZ+gk27b2NPI1B
         mZn4wQaH03wY/eMcj/IqgcOLVGkEtQBkbcOI5sECgW6/NRpXdlGIhLsYFcxa2ZHMHAhQ
         8iVNPo+HzhRQ8fI8559iebQd0qXD6rggLVhMjKWVWYp5TQNrgARymaIoB8fcRgl6rpVp
         lDkw==
X-Forwarded-Encrypted: i=1; AJvYcCVsG6cKf7GKDKMlifRRISzIXU1x0pbjRullOFIt5AiQGWgFJH7FFYN3E0ttPpjwTr6n0TVpR9iLfw3Q4Ds9lpV7z3WhxG35QQaJjWputnrTj84+DQieeG8AQHJA08hMDHt/O+PPcW1Y8iN6HLtLuuIDdyHL1KNXw/ckI4y7U9X1SjFDG5Eq1n05Dp/Z5nnHpGHfKtvQAapCbMZWQu9yX6YsjNBhVns7JHC8RXmyY5KoA81DyHyhNQJjUfqK
X-Gm-Message-State: AOJu0YwLVLYtdERM8iK/p+skzzdZ2dxVSrWGrVxN7hgQyYEWxTm9AEeW
	MgIV9U+gRYEa1iQqPoZrKrroiIVDkERqbKjL8GYxpsyvhxswIfuX
X-Google-Smtp-Source: AGHT+IG0tIXBxMyZCTnOq3svjh4Vc3mtAvxvyuEgllvUJQwfYc+QzEtuie6pZpf9ZLtwIAorl/GhfQ==
X-Received: by 2002:a17:906:4716:b0:a5a:2d30:b8c1 with SMTP id a640c23a62f3a-a622807afb0mr114977366b.14.1716378743470;
        Wed, 22 May 2024 04:52:23 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cdce8f916sm929375466b.223.2024.05.22.04.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:52:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 May 2024 13:52:20 +0200
To: Alejandro Colomar <alx@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCHv6 9/9] man2: Add uretprobe syscall page
Message-ID: <Zk3cdJKGbzwbda2e@krava>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-10-jolsa@kernel.org>
 <j6qxudmvwccpqnle4evabxbswdygmx35bgqwhemuzsjs5iuydv@fk2iumwucifx>
 <ZkyKKwfhNZxrGWsa@krava>
 <Zk0C_vm3T2L79-_W@krava>
 <o5pkz3eenii6p6sm7dl2fsgy4fqqaq2qbn2rbxddhkvaarvwgm@dkjjknb44qp2>
 <Zk2k0ttdR7abKSuv@krava>
 <vqw4ibum2hfnxjkfp7io5ugmwaeok4tynchi3utmzp6xnsmjig@fbjxwmm6u6v3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vqw4ibum2hfnxjkfp7io5ugmwaeok4tynchi3utmzp6xnsmjig@fbjxwmm6u6v3>

On Wed, May 22, 2024 at 12:59:46PM +0200, Alejandro Colomar wrote:
> Hi Jirka,
> 
> On Wed, May 22, 2024 at 09:54:58AM GMT, Jiri Olsa wrote:
> > ok, thanks
> > 
> > jirka
> > 
> > 
> > ---
> > diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
> > new file mode 100644
> > index 000000000000..5b5f340b59b6
> > --- /dev/null
> > +++ b/man/man2/uretprobe.2
> > @@ -0,0 +1,56 @@
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
> > +The
> > +.BR uretprobe ()
> > +system call is an alternative to breakpoint instructions for triggering return
> > +uprobe consumers.
> > +.P
> > +Calls to
> > +.BR uretprobe ()
> > +system call are only made from the user-space trampoline provided by the kernel.
> > +Calls from any other place result in a
> > +.BR SIGILL .
> > +.SH RETURN VALUE
> > +The
> > +.BR uretprobe ()
> > +system call return value is architecture-specific.
> > +.SH ERRORS
> > +.TP
> > +.B SIGILL
> > +The
> > +.BR uretprobe ()
> > +system call was called by user.
> 
> Maybe 'a user-space program'?
> Anyway, LGTM.  Thanks!
> 
> 	Reviewed-by: Alejandro Colomar <alx@kernel.org>

ok, will change, thanks a lot

jirka

> 
> Have a lovely day!
> Alex
> 
> > +.SH VERSIONS
> > +Details of the
> > +.BR uretprobe ()
> > +system call behavior vary across systems.
> > +.SH STANDARDS
> > +None.
> > +.SH HISTORY
> > +TBD
> > +.SH NOTES
> > +The
> > +.BR uretprobe ()
> > +system call was initially introduced for the x86_64 architecture
> > +where it was shown to be faster than breakpoint traps.
> > +It might be extended to other architectures.
> > +.P
> > +The
> > +.BR uretprobe ()
> > +system call exists only to allow the invocation of return uprobe consumers.
> > +It should
> > +.B never
> > +be called directly.
> > +Details of the arguments (if any) passed to
> > +.BR uretprobe ()
> > +and the return value are architecture-specific.
> 
> -- 
> <https://www.alejandro-colomar.es/>



