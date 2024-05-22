Return-Path: <bpf+bounces-30268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E5B8CBC7C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 09:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CA31F2283D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3053F7E583;
	Wed, 22 May 2024 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiWSTZc2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BEB7D3F5;
	Wed, 22 May 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364505; cv=none; b=hXvjPu8p2DpVbaQcXMcf8qfA4Axa4/FT6USY5Y43einn5jF/heH8TIw7KIPUpK3NHDXGhbW8M2kDhgMhOkkLt4vfB2418sbBv+V0EhWnl5SSOBGEwjM06AbirGjDxmT/ad5vdWRYRfDeMO+b08AvLFhITD9mYl3ZQZXtU8USzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364505; c=relaxed/simple;
	bh=DdDjo/FDiOgPMkdXr0NfnzwZ3Z18E8np1Z5caXxRP9Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL8kv+Dz9IIo+MiSlOWyvwlysiSkxcOtInqnS3Dx/nFa1tnf4eHhsaf7APXJrTUprz9sM8ASqP4E7ZHOlYUjLThos4uewv5bIzRzL+rlCkftNjLs0prke6pMIcT4kmha77r1Q1VXObL4FbGFxzW+9FWG8zoQikS9nvGexUUAR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiWSTZc2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354de97586cso319102f8f.0;
        Wed, 22 May 2024 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716364501; x=1716969301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzr0sl4QQMjCNSxyJObQ0Q87Cq15Drd+3aEObwMgsYs=;
        b=KiWSTZc2/u7OYCikImaM+3ByyRKamq+owzP7o6LkQjnBrU6iyvx1rxeDZ+egEhQ6qe
         8mdRaA4nUiHUy17waEkYt+JPu7uDKH6074WXufPMcKBT+LyRqOhyfZ0vg8yPCxqWNNgO
         F6agQ+AcBoMKXMJlT9Sbfqsx1zU/F2TtL5ooujmqMzDEkCnCa3svE6Iv03u0s8F24/6S
         kf+urGtAOUi2mxEMH4hwBFTtHtYY/wfHDT0jouI4FMsKnUR6nhilewbc80mHB/+7+jfa
         cMXtCENnaTbdThBji+wFTCZyQ7NgH5FeO0+4fTS+Ruf2lOnXal+svvANO5YuOHnfGIHW
         2l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716364501; x=1716969301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzr0sl4QQMjCNSxyJObQ0Q87Cq15Drd+3aEObwMgsYs=;
        b=MA33ExrkEnHwQKZK8HaL5RBRo5VgK7UyTcEPdwMZOmjQJWwrp46/gYpMoWsWo2bpWc
         dGlRSrE2G/SnrsQ9G/N4mDFg7lKXaj5aB+D0lTZdb0koaZTLepxthvy7Xc35Y5AeGbX+
         yNqXMWpcZS/qvnGSqZNhnc+xzLeCoKuW4Lo4lMak8A/+UjoDwHRFCXmd2EkEolvsjWMa
         9B4xJWkt5OAqDZbtWo69/AFHF9YK9vIQzsHo6wF8RVNYBKz8tv2UMJpOvT2B0aIBoDSP
         ntF/eNvHDv/N6j1K4IFlEU6ZnaX0S8t6K1tSnnKuOFzoTElRMuAeIxvC7ztY1smEDaQi
         ZNOg==
X-Forwarded-Encrypted: i=1; AJvYcCWGJqlzP2osCirgpVrtU9NAEm3rBRczcjLDYyrO6KUAKeyWXXUuO7hj2rfs2mU4HMR3Leej1VjpQYKg4v4g72UiNwKnpdPaCyrRrZXi3ZeCFlMA5uDw9+WoRiWaGsLQ92lv9o7oG7xfGrfl6dP9VYjkYc3zG6QsuF3S410pUz4LY8JN7W5Mof7FgCqj1AHsQzlsBdh/cA4EFRJraDWLZHks33wgWw9Hsnvhd+kQvTeYrDaBpzWdcdXWqImJ
X-Gm-Message-State: AOJu0Yygv4MOCXkg9psnwRFnTDN7mJFWzw+0dwr7tIj+oKKnP4HwFnGM
	+yvH0C+PtPhm67tPgulhzzpwHH2ga+O5vRTc60Y6IfSrLiOfM1J5
X-Google-Smtp-Source: AGHT+IFlFYN8l/AArJT6QXVg4LOkcTXz9Zoe+wcrglUn97ZwbHHO866jMAGQGE+l61RC7QCEmvV+qw==
X-Received: by 2002:adf:ea0c:0:b0:351:debf:a3a2 with SMTP id ffacd0b85a97d-354d8d85d63mr780762f8f.52.1716364500858;
        Wed, 22 May 2024 00:55:00 -0700 (PDT)
Received: from krava ([212.20.115.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3518d817ee2sm29904561f8f.2.2024.05.22.00.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 00:55:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 May 2024 09:54:58 +0200
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
Message-ID: <Zk2k0ttdR7abKSuv@krava>
References: <20240521104825.1060966-1-jolsa@kernel.org>
 <20240521104825.1060966-10-jolsa@kernel.org>
 <j6qxudmvwccpqnle4evabxbswdygmx35bgqwhemuzsjs5iuydv@fk2iumwucifx>
 <ZkyKKwfhNZxrGWsa@krava>
 <Zk0C_vm3T2L79-_W@krava>
 <o5pkz3eenii6p6sm7dl2fsgy4fqqaq2qbn2rbxddhkvaarvwgm@dkjjknb44qp2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o5pkz3eenii6p6sm7dl2fsgy4fqqaq2qbn2rbxddhkvaarvwgm@dkjjknb44qp2>

On Tue, May 21, 2024 at 10:54:36PM +0200, Alejandro Colomar wrote:
> Hi Jirka,
> 
> On Tue, May 21, 2024 at 10:24:30PM GMT, Jiri Olsa wrote:
> > how about the change below?
> 
> Much better.  I still have a few comments below.  :-)
> 
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
> > new file mode 100644
> > index 000000000000..959b7a47102b
> > --- /dev/null
> > +++ b/man/man2/uretprobe.2
> > @@ -0,0 +1,55 @@
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
> > +.BR SIGILL
> 
> This should be a tagged paragraph, preceeded with '.TP'.  See any manual
> page with an ERRORS section for an example.
> 
> Also, BR is Bold alternating with Roman, but this is just bold, so it
> should use '.B'.
> 
> .TP
> .B SIGILL

ok

> 
> > +The
> > +.BR uretprobe ()
> > +system call was called by user.
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
> > +system call was initially introduced for the x86_64 architecture where it was shown
> 
> We have a strong-ish limit at column 80.  Please break after
> 'architecture', which is a clause boundary.
> 

ok, thanks

jirka


---
diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
new file mode 100644
index 000000000000..5b5f340b59b6
--- /dev/null
+++ b/man/man2/uretprobe.2
@@ -0,0 +1,56 @@
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
+.TP
+.B SIGILL
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
+system call was initially introduced for the x86_64 architecture
+where it was shown to be faster than breakpoint traps.
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

