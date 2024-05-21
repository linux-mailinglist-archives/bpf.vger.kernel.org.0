Return-Path: <bpf+bounces-30112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D048CAD96
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0F2281E60
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 11:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F885770E6;
	Tue, 21 May 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRATUtNB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD476EEA;
	Tue, 21 May 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292145; cv=none; b=osN6zRyXf7zlXf3ySZpmqf2lwId24eGGiwZLAbXlSwZS4FVvD1IrJl0bbGIRZvnPdMk7MXQPxe003nzb3U/rBrth+FTk5ypCjqAIdqNXVOOK+c7Ic3r6gnTvVadTWVHsIbPw0Pc5o/y9z8vLZrbLcm+XSwLo9fYBbZPGz+3KRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292145; c=relaxed/simple;
	bh=IrfXhbXwURjgjuHcPJbS1Tsok2bkF7dHlUYlkUOlva0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIvJ8+cAYCjmGq1xrrMt/usb9ncrpy5TUwstgdSCxzZx/Q2ftBBjObnkF6hS9UyS15Cpiy+aoNiwTNxuGb9rFp0jqL+A8fSz6VBvup0OZ+1xn6IqPB7KsUNpGvR5Po/gobST7YgFxc6pqetGXXiAzVq+ee9MwnCMIH/lkL+iWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRATUtNB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59b49162aeso818450966b.3;
        Tue, 21 May 2024 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716292142; x=1716896942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P1AwFEaypQQLUmXbNtkojgKjia4yiQwYD/QyNFzC+5c=;
        b=KRATUtNBBi935SBhY6BDOfpCu0zFcbutBY9zw7KMKnnpi/CwYYKwq5USs2qkNeArkj
         pL829Mq4IiOgCCt1yBOjSgGyzqd7Cv5n0xrax3nT9qGKz63QPIiKTA3gD1p84+ItUObB
         J8VGqHHpsQWjB9E90X3jB00o05LPjSFV3USSR42Mfp/Pv/oMHhtvIyzSGjMCv6ODyFn8
         JBI29GocO8GHajLZrf5vGdtQ9/v4iTbwDbvOeQbsSbc72K16D0vgDQXO+dzopkYQL5Qd
         HWhyLLh1dI8mvi8d3C8SO1iEQsNnWn5qI87sM41XaYAHeL6NiEumnCzLRqA5EUWeyzH9
         lAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716292142; x=1716896942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1AwFEaypQQLUmXbNtkojgKjia4yiQwYD/QyNFzC+5c=;
        b=IO8hz3APQ3BnKsVxW/QkE9PU6jOIFXhJ2Hh04uDVU7AVv4LxOinuzj0f8qGWPX66qv
         rJeQm9C+jT5JWceccwoGATL13t6b6yaLVpXXCi0uL4f+kfxu327Hle2sNrxkmKeWDqI0
         Ve2bSvz/qaMpdR6ozJqCynTMknOF0+pGwBWURA174wJ/0m4G/MTIMmA+NMj6Kc30ffT0
         cMFwI/lqXQ1CUrA2ZZgtTJ9Tn3K6b5jKlErb2GrcfgLyfJIgJmG2XAmiLjaVg6JiNPBH
         eid6wUY0GJwPGb7/GNpdMEdzmeQNMeX7u5cMoqzsNURH2xKHJRU+NS1gHvBsjcRyKuGo
         zE+w==
X-Forwarded-Encrypted: i=1; AJvYcCXES8Ete+7MD9Kz4oe0OwR+HsDQhZebPmTUkbD5CiR2XUJWar/Sw1m+ZDj8uHkAHoB7AZipa161R9e6MTnGkGEIOVK+HjAiMnozFjkxQxtFIRry4zYTexyW5Crq8br0EWvFykB4P4sLgsShN3jLf7GYpbIyR1mHS2yX8ZTqvGmLP9fft392MIkJ2uaQPNs7Tw83lfCR+z9sEqmR3ZYoMtuevsd1GFJRoH8P4prZUaafwE5AaAXMzUDgu27q
X-Gm-Message-State: AOJu0YyMEpzPulLwJZKDVoew5g3cV1OzGmW2Ftn+Ep9are/ilWdW09/Q
	uqSg3pRxCBCqxuQlAuUS0X6Sb160ILs7kRYu0di/VckS3RckqsQG
X-Google-Smtp-Source: AGHT+IGwOqATHZsFbhwbjGwzE+zJgNafqxC0GyQxz3SfE0Isw4IdDy3aa3zuC1fKlhcm7n7zVqrcQw==
X-Received: by 2002:a17:906:305a:b0:a59:db0f:6be4 with SMTP id a640c23a62f3a-a5a2d534ec4mr2038795166b.5.1716292141970;
        Tue, 21 May 2024 04:49:01 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178923fesm1599960166b.64.2024.05.21.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 04:49:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 May 2024 13:48:59 +0200
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
Subject: Re: [PATCHv6 9/9] man2: Add uretprobe syscall page
Message-ID: <ZkyKKwfhNZxrGWsa@krava>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-10-jolsa@kernel.org>
 <j6qxudmvwccpqnle4evabxbswdygmx35bgqwhemuzsjs5iuydv@fk2iumwucifx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j6qxudmvwccpqnle4evabxbswdygmx35bgqwhemuzsjs5iuydv@fk2iumwucifx>

On Tue, May 21, 2024 at 01:36:25PM +0200, Alejandro Colomar wrote:
> Hi Jiri,
> 
> On Tue, May 21, 2024 at 12:48:25PM GMT, Jiri Olsa wrote:
> > Adding man page for new uretprobe syscall.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  man2/uretprobe.2 | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 man2/uretprobe.2
> > 
> > diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
> > new file mode 100644
> > index 000000000000..690fe3b1a44f
> > --- /dev/null
> > +++ b/man2/uretprobe.2
> > @@ -0,0 +1,50 @@
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
> 
> What header file provides this system call?

there's no header, it's used/called only by user space trampoline
provided by kernel, it's not expected to be called by user

> 
> > +.SH DESCRIPTION
> > +The
> > +.BR uretprobe ()
> > +syscall is an alternative to breakpoint instructions for
> > +triggering return uprobe consumers.
> > +.P
> > +Calls to
> > +.BR uretprobe ()
> > +suscall are only made from the user-space trampoline provided by the kernel.
> 
> s/suscall/system call/

ugh leftover sry

> 
> > +Calls from any other place result in a
> > +.BR SIGILL .
> 
> Maybe add an ERRORS section?
> 
> > +
> 
> We don't use blank lines; it causes a groff(1) warning, and other
> problems.  Instead, use '.P'.
> 
> > +.SH RETURN VALUE
> > +The
> > +.BR uretprobe ()
> > +syscall return value is architecture-specific.
> > +
> 
> .P
> 
> > +.SH VERSIONS
> > +This syscall is not specified in POSIX,
> 
> Redundant with "STANDARDS: None.".
> 
> > +and details of its behavior vary across systems.
> 
> Keep this.

ok

> 
> > +.SH STANDARDS
> > +None.
> > +.SH HISTORY
> > +TBD
> > +.SH NOTES
> > +The
> > +.BR uretprobe ()
> > +syscall was initially introduced for the x86_64 architecture where it was shown
> > +to be faster than breakpoint traps. It might be extended to other architectures.
> 
> Please use semantic newlines.
> 
> $ MANWIDTH=72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
>    Use semantic newlines
>      In the source of a manual page, new sentences should be started on
>      new lines, long sentences should be split  into  lines  at  clause
>      breaks  (commas,  semicolons, colons, and so on), and long clauses
>      should be split at phrase boundaries.  This convention,  sometimes
>      known as "semantic newlines", makes it easier to see the effect of
>      patches, which often operate at the level of individual sentences,
>      clauses, or phrases.

ok

thanks,
jirka

> 
> > +.P
> > +The
> > +.BR uretprobe ()
> > +syscall exists only to allow the invocation of return uprobe consumers.
> 
> s/syscall/system call/
> 
> > +It should
> > +.B never
> > +be called directly.
> > +Details of the arguments (if any) passed to
> > +.BR uretprobe ()
> > +and the return value are architecture-specific.
> > -- 
> > 2.44.0
> 
> Have a lovely day!
> Alex
> 
> -- 
> <https://www.alejandro-colomar.es/>



