Return-Path: <bpf+bounces-27470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990588AD5B6
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0AD1C20E74
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41D155729;
	Mon, 22 Apr 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtAz2R+n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77A15539E;
	Mon, 22 Apr 2024 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816921; cv=none; b=YibNI7v8yMmrkUu1p2AMZkuR9vbyk3oFeO8frSE0YJR8yLCn8OaYRgWOSluySWnFEOSuCGtuU8ULa0P415vx85yY7XMXQtiyX9feailvsHnfVpcddTphL3YTwtZevQuS5rsZsuSp93SH8rCBMQEAuTTcpIrxhOq4ROWQC046OB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816921; c=relaxed/simple;
	bh=CO9sWn4TGwS+F6HGsjPCnompyAUQtRvkshYYjb0v0KM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux4Ny+e8eMdT1draNTl/NLYZ70vW7PDLtrqhP6Iv3DondZnpzykuJ/meVXhkMQ9pnKyIc4bQYCfKWy2SPzlYuOH9T2SYMNNd2UMAyHp4vajcBQxIS+7JE92ZR1b9p/T2o2h8gGRxp18TW54Cr7PBxiwYf6miVSVQ3f2Thkd/Em0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtAz2R+n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41aa2f6ff00so3741005e9.3;
        Mon, 22 Apr 2024 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713816918; x=1714421718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Eu3JFTPdyU8Z03j2EuYpTwgYH2/Fv3qtXMU2BdFdug=;
        b=BtAz2R+nC/KvxGa5WfpGt90866DOXerVcmJiaX/5SXuSwWEfX6gQcoy6hLy4PIQyvF
         ST1qFFp5RQyTeHJfzKTaerj60GjYW2SL4c3Vp/VCtFol7WSFrxyb1h71S3V3eFN3yHxt
         03q/3c8BX7kKxpk86DDMPh7iRTzAN/cQhn88tiIPWSY1Xealwiww+CdVeL4SuykdWPD1
         yeJv57RtZb3oYq/xhtkwr2IbAD8lPUn2ZrtDOL7H2W9xYx/Yp2UCdwbZHvODTpkyHVQv
         fv1nSh8luw978+b8PTt/qdASrEPoeQmgpY0TTSh5DtCdt4TjNE2uTOPwRnmp0YmvvDlh
         6vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816918; x=1714421718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Eu3JFTPdyU8Z03j2EuYpTwgYH2/Fv3qtXMU2BdFdug=;
        b=Q5Ey15UaTcIEhLGyAkyrOgwtMRNXwYuAVxXVbYPrb/VEmz5981P/C/on5DseIEBw16
         iW2d1PvJGd8BK80LcbHupWWe5ZiNGFGNai6ujuZxPJlaY1mFjR47mGLL2cjcHxV1k5R8
         yvqcQaiiEjcEtHlHCa6psNgGZ9GXY416aCsNf3fIqlBa+m7x/chkm+YkNt3uRWSIsnos
         SQ/gbOsjQeb8L6IaLU9OZDUvJ1Q0+ugkyshWfpk+pz222ymGhj+GK8060H8IVyx+AvWA
         TeolA4GH5pHzBNntkAXqSamq2l0cwOVBK6HHHdlG5zNPxd/D8h5tT4+dojlo/uDKMFt6
         2LVA==
X-Forwarded-Encrypted: i=1; AJvYcCWixELHkYf1yCqVR0QGmOdcm8+9eSSzWppsVnCaYmdxL7MZXZr1S3jJ4HRIoC6VJt9oULuVE9V7ykOMbsNev4iqY572k9Wu1MxWEeXzYmUKlxha/9M26NLsKvnxGAXE0O3o0bddzWGU0XLhxg1P6CENavVKI3WBvKeFXJlwzxGtH/C2kGlLg6GfIu4Mp/+482x1GA+GHha085pnScvw/Ktc
X-Gm-Message-State: AOJu0YyC6uQLx/VIcBb/eHeBDqn058dIrshsNdeyr0w4BrSC66QQrxnS
	k3+55PDqGVuEy1O7+R0j5IgoW/KKUHA0kyIygs+1iXfw//APIywyBMXt4d1n
X-Google-Smtp-Source: AGHT+IEThdBxdECz8bVPhQn5PHEhOkpePD5RpVqY08kUXP0btFQF0IfQfHbI4K1uwo6S0T0C5e1Dbw==
X-Received: by 2002:a05:600c:1c21:b0:418:ee1e:3445 with SMTP id j33-20020a05600c1c2100b00418ee1e3445mr10483617wms.26.1713816917679;
        Mon, 22 Apr 2024 13:15:17 -0700 (PDT)
Received: from krava ([83.240.62.18])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00418244d459esm17861156wmo.4.2024.04.22.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:15:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Apr 2024 22:15:14 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 7/7] man2: Add uretprobe syscall page
Message-ID: <ZibFUqtwELfVTHfq@krava>
References: <20240421194206.1010934-1-jolsa@kernel.org>
 <20240421194206.1010934-8-jolsa@kernel.org>
 <20240423000729.f1d58443100c3994afca0a7f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423000729.f1d58443100c3994afca0a7f@kernel.org>

On Tue, Apr 23, 2024 at 12:07:29AM +0900, Masami Hiramatsu wrote:
> On Sun, 21 Apr 2024 21:42:06 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding man page for new uretprobe syscall.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  man2/uretprobe.2 | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 man2/uretprobe.2
> > 
> > diff --git a/man2/uretprobe.2 b/man2/uretprobe.2
> > new file mode 100644
> > index 000000000000..c0343a88bb57
> > --- /dev/null
> > +++ b/man2/uretprobe.2
> > @@ -0,0 +1,40 @@
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
> > +On x86_64 architecture the kernel is using uretprobe syscall to trigger
> > +uprobe return probe consumers instead of using standard breakpoint instruction.
> > +The reason is that it's much faster to do syscall than breakpoint trap
> > +on x86_64 architecture.
> 
> Do we specify the supported architecture as this? Currently it is supported
> only on x86-64, but it could be extended later, right?

yes, that's the idea, but I can't really speak other than x86 ;-)
so not sure abour other archs details

> 
> This should be just noted as NOTES. Something like "This syscall is initially
> introduced on x86-64 because a syscall is faster than a breakpoint trap on it.
> But this will be extended to the architectures whose syscall is faster than
> breakpoint trap."

's/will be extended/might be will be extended/' seems better to me,
other than that it looks ok

thanks,
jirka


> 
> Thank you,
> 
> > +
> > +The uretprobe syscall is not supposed to be called directly by user, it's allowed
> > +to be invoked only through user space trampoline provided by kernel.
> > +When called from outside of this trampoline, the calling process will receive
> > +.BR SIGILL .
> > +
> > +.SH RETURN VALUE
> > +.BR uretprobe()
> > +return value is specific for given architecture.
> > +
> > +.SH VERSIONS
> > +This syscall is not specified in POSIX,
> > +and details of its behavior vary across systems.
> > +.SH STANDARDS
> > +None.
> > +.SH NOTES
> > +.BR uretprobe()
> > +exists only to allow the invocation of return uprobe consumers.
> > +It should
> > +.B never
> > +be called directly.
> > +Details of the arguments (if any) passed to
> > +.BR uretprobe ()
> > +and the return value are specific for given architecture.
> > -- 
> > 2.44.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

