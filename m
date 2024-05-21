Return-Path: <bpf+bounces-30159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345658CB4A9
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE134282FCB
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987C3149C47;
	Tue, 21 May 2024 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKN2yFP/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1C3FB8B;
	Tue, 21 May 2024 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323077; cv=none; b=p5DiG7qPvdlDPi9gGGVJx02T4v6WhB7QCLvEs3GkLC8XmSDWiDrvIOvPcx16n7tPF/innPlq6O6dxUqGy2vTwT4Nk+Rg2ltiB40BDP4lwWHVJZG/djsKuJKeRxynxl7b9tA3seON06apEZ7y6eWgM25il/d7dsplCtGPx4hR7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323077; c=relaxed/simple;
	bh=/UG2kuAuMTEuajL7u1UkPBllsxmrQaa1uMNhHwaSNKQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZYX8FkJnFlgfmDEdM4DT5cJRJ1jHtQWX4ziQ/sVw1NVid257a7w9cfczRgyW3GsWo1o6vPi+PHj5hib/LDPquPMxU4sYGgjbIu0b1ks2fF1ebHNrgXl1zvtrgPT62HKTw3S99emBRI2HXepCen51izSzIIe5cHJRHamGef4nrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKN2yFP/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-574f7c0bab4so420744a12.0;
        Tue, 21 May 2024 13:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716323074; x=1716927874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OYnvnXcE3D/kvzMwZLCJA06YMqi27boOmTrkHntlVqc=;
        b=HKN2yFP/lyi/+RWnO83w3FarOOZ5AwzDMNfV9eQ6XJHAnM9Spx7haut7ndYa/c322F
         gwjwdXhPpoeMaQTPVlnfRSAeulOIQvAiGDSrPycFQgJZW/T2JNLQB8UA8Ocr7rDnewCk
         F9Zf3YgOstAxA4B0kq2ziixP9GGeD48sH4BpmXmoopEWb4TJoDFo5a+U7eIwrW8Wba33
         adr/tCB/9XKTudjAgvPT4ebo8WYqCujfkpfFHNOL0kUzXFJ1DGAH+4QSfJWwiX98oNL0
         UdX0uSnUyI+0zLfs+UBb4uqTLGVcI38XMuCpeZahllEWLFxd8jPVgQ+Tdm0p/Gv8fy6d
         jvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716323074; x=1716927874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYnvnXcE3D/kvzMwZLCJA06YMqi27boOmTrkHntlVqc=;
        b=SwyDfhpBXo06nlxACwqlQYy6T+bBwo9Vt/+0kPUYoeV9FPia3CdqSQTEvRaEJX4LLa
         vvZ6sRHt+q1iTZhAMkueJtUm0DcdQRtzjjwgT/q6tBzwcPCtJwuabn8hikY5uBG2swcG
         OuFxvlbjslvj9/jVEyQmwCUe89vw4kX/cxMKfPBAd6IUSeewVCpfszbpCUQdwrOuyg7f
         G5aneuTVT42SnDwgMuyUziXhPsyoUhF2ovQ3HZhak4gBS8IOGiHxan4paJVVCj8AjaFs
         t61Va39012UQvapsk/smlqYCfOPbFhOwA8ywbGLxDfFQMv/ov0PkkduUHTQhEm27Heh5
         Bdjw==
X-Forwarded-Encrypted: i=1; AJvYcCWh82GU1Un3d1QzOFtcNCVD8YRNq0HKw2NaRqLg8XlRpDR4MsXSMZE+SVA5gy6BPYF+hXLJMT3qL9pC8XbD6RVkVQQbRHKojuJIVN8a6aPgsCZ022nfkr0jLTwul7Ssg4Y/ecijqVFHRkMl2LhNoRC/keCp5J7wKztNxe5rQ0WbwH324tF8drI44EHHbOZVlsHM9XHtybpr2NqgfVEGGTxnz4TwESZnzboXdiPHZkO79wYWHfFfk/aSVMZ0
X-Gm-Message-State: AOJu0YzRrISSvPkbm6pZrnhV7d4Um2R5L+CoRk8NjiVP3kTde77W1WC7
	6FZ6/pPzOJycXRb5NB59jbsp18An5jGF/lDFNK96gc7ZWXx6bmna
X-Google-Smtp-Source: AGHT+IEiOq3YhqETpKwsUd1R/rNi0bETGeC8Gk4xXoSQWd28rw7Q0HtpnLbLaW3hdtGHuy7n+J5naQ==
X-Received: by 2002:a50:d4d1:0:b0:575:17ca:7f7b with SMTP id 4fb4d7f45d1cf-57831140f4cmr129623a12.15.1716323073367;
        Tue, 21 May 2024 13:24:33 -0700 (PDT)
Received: from krava ([83.240.61.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfbd3sm17643868a12.44.2024.05.21.13.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:24:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 May 2024 22:24:30 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <Zk0C_vm3T2L79-_W@krava>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-10-jolsa@kernel.org>
 <j6qxudmvwccpqnle4evabxbswdygmx35bgqwhemuzsjs5iuydv@fk2iumwucifx>
 <ZkyKKwfhNZxrGWsa@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkyKKwfhNZxrGWsa@krava>

On Tue, May 21, 2024 at 01:48:59PM +0200, Jiri Olsa wrote:
> On Tue, May 21, 2024 at 01:36:25PM +0200, Alejandro Colomar wrote:
> > Hi Jiri,
> > 
> > On Tue, May 21, 2024 at 12:48:25PM GMT, Jiri Olsa wrote:
> > > Adding man page for new uretprobe syscall.
> > > 
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  man2/uretprobe.2 | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > >  create mode 100644 man2/uretprobe.2
> > > 
> > > diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
> > > new file mode 100644
> > > index 000000000000..690fe3b1a44f
> > > --- /dev/null
> > > +++ b/man2/uretprobe.2
> > > @@ -0,0 +1,50 @@
> > > +.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
> > > +.\"
> > > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > > +.\"
> > > +.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
> > > +.SH NAME
> > > +uretprobe \- execute pending return uprobes
> > > +.SH SYNOPSIS
> > > +.nf
> > > +.B int uretprobe(void)
> > > +.fi
> > 
> > What header file provides this system call?
> 
> there's no header, it's used/called only by user space trampoline
> provided by kernel, it's not expected to be called by user
> 
> > 
> > > +.SH DESCRIPTION
> > > +The
> > > +.BR uretprobe ()
> > > +syscall is an alternative to breakpoint instructions for
> > > +triggering return uprobe consumers.
> > > +.P
> > > +Calls to
> > > +.BR uretprobe ()
> > > +suscall are only made from the user-space trampoline provided by the kernel.
> > 
> > s/suscall/system call/
> 
> ugh leftover sry
> 
> > 
> > > +Calls from any other place result in a
> > > +.BR SIGILL .
> > 
> > Maybe add an ERRORS section?
> > 
> > > +
> > 
> > We don't use blank lines; it causes a groff(1) warning, and other
> > problems.  Instead, use '.P'.
> > 
> > > +.SH RETURN VALUE
> > > +The
> > > +.BR uretprobe ()
> > > +syscall return value is architecture-specific.
> > > +
> > 
> > .P
> > 
> > > +.SH VERSIONS
> > > +This syscall is not specified in POSIX,
> > 
> > Redundant with "STANDARDS: None.".
> > 
> > > +and details of its behavior vary across systems.
> > 
> > Keep this.
> 
> ok
> 
> > 
> > > +.SH STANDARDS
> > > +None.
> > > +.SH HISTORY
> > > +TBD
> > > +.SH NOTES
> > > +The
> > > +.BR uretprobe ()
> > > +syscall was initially introduced for the x86_64 architecture where it was shown
> > > +to be faster than breakpoint traps. It might be extended to other architectures.
> > 
> > Please use semantic newlines.
> > 
> > $ MANWIDTH=72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
> >    Use semantic newlines
> >      In the source of a manual page, new sentences should be started on
> >      new lines, long sentences should be split  into  lines  at  clause
> >      breaks  (commas,  semicolons, colons, and so on), and long clauses
> >      should be split at phrase boundaries.  This convention,  sometimes
> >      known as "semantic newlines", makes it easier to see the effect of
> >      patches, which often operate at the level of individual sentences,
> >      clauses, or phrases.
> 

how about the change below?

thanks,
jirka


---
diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
new file mode 100644
index 000000000000..959b7a47102b
--- /dev/null
+++ b/man/man2/uretprobe.2
@@ -0,0 +1,55 @@
+.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH uretprobe 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+uretprobe \- execute pending return uprobes
+.SH SYNOPSIS
+.nf
+.B int uretprobe(void)
+.fi
+.SH DESCRIPTION
+The
+.BR uretprobe ()
+system call is an alternative to breakpoint instructions for triggering return
+uprobe consumers.
+.P
+Calls to
+.BR uretprobe ()
+system call are only made from the user-space trampoline provided by the kernel.
+Calls from any other place result in a
+.BR SIGILL .
+.SH RETURN VALUE
+The
+.BR uretprobe ()
+system call return value is architecture-specific.
+.SH ERRORS
+.BR SIGILL
+The
+.BR uretprobe ()
+system call was called by user.
+.SH VERSIONS
+Details of the
+.BR uretprobe ()
+system call behavior vary across systems.
+.SH STANDARDS
+None.
+.SH HISTORY
+TBD
+.SH NOTES
+The
+.BR uretprobe ()
+system call was initially introduced for the x86_64 architecture where it was shown
+to be faster than breakpoint traps.
+It might be extended to other architectures.
+.P
+The
+.BR uretprobe ()
+system call exists only to allow the invocation of return uprobe consumers.
+It should
+.B never
+be called directly.
+Details of the arguments (if any) passed to
+.BR uretprobe ()
+and the return value are architecture-specific.

