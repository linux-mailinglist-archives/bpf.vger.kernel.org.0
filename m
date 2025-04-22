Return-Path: <bpf+bounces-56414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E409A96DD6
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 16:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1074C188A0F7
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C32820B8;
	Tue, 22 Apr 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6omGFmt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C328134E;
	Tue, 22 Apr 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330523; cv=none; b=omj8ovSQs1CDwR8/mviWF3Sv4n/YsOirsK8L+Rj08pE3CMqkACD9XOi/sbnrMqj9G8HWKL4oodyzsT8ko9FMWEtctCmtfPW2Ah2oxywdDYGvZI/DjMQh6NBWdLTHGo5nDewxvYffnUymeI2f3Clzc8PAj7ay8YUsBWInnHj9MuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330523; c=relaxed/simple;
	bh=gpzfHIqtG4xrrnJa8j+492RroxTPtiKYMK20nKKT/k0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsCNu/jgYyAYIyYfL/wo6VzXr+1qDRy1/kSmaOqVyZ/6o6XPbTninxhFU9E5veywX4wdpw4sR3tIolS+9x3mI7KVpqiK1XUdEKFne9vms7dF6LSyolA6G1oIC1j2PU08jvhKIBCAQAYbBXfNefCuYKrjXoyJRuJYoruHcf3EyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6omGFmt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-548409cd2a8so6880696e87.3;
        Tue, 22 Apr 2025 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745330519; x=1745935319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GM/5CVrygYQSvYokwNwQr+lHyyAIT7IEVO4DNtORKxA=;
        b=g6omGFmtWmrAg8k52sMieh5nshJoVNuyp7rmXegg2KnAIrvS3hTa18YotMewvMeCcy
         HVWZ0Q7vN88gET2Q6RmbEGduut3n3lO1BQ8oZtziD8nVuntpa+nMG3Gv+fzsipkGjddW
         CARQROeGax19ZqVBI8emMs9GNpHJ+2AX/2cIEXbH3GUuFbfkRX6z0rZn9IdYzU4KUatS
         Pc3Ewk89XBHIXXyn2fwMxEmHvUpLlArN/LKYrM2EQxIDg94+TDmckxt1X1bV46igZX4g
         iH3a3DFLbo6KQlnfTS3tRe0gvXoYSOqGHp2wd9T/NatKfxyIqo3cr9+EfSyIeuPYy241
         gPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330519; x=1745935319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM/5CVrygYQSvYokwNwQr+lHyyAIT7IEVO4DNtORKxA=;
        b=RB/D3E5BWxNN+XVBmMZCpKQ9yo2GJB4IwRNC8V8tXOVukwCkI3/tGzC+9lEI9/OoZ/
         HS/f2/cgTGKFsk2ML6HwoGTzLnLT8BF0/7yYh1XrmWraTVuI62VcCPZ/2qDSWCTQIe4U
         7yot4JloZF4napyYnGQ7h8A7cjk6SFuUvFOHb0hBC7FsFLBDLw22B6iNzcBCxseVw8R5
         wY1LVoFU9n0mDhuVM0CCywcnYE/T1evzT2tkD7sJiVauYFguPuJYjLe0tPSLy8taJeqK
         43tqA4NUs/TLMpvNCyx9jbaV++/95gYhTVPdS7I0nXnSGWx9B93gzx35dipSi2Uj5cRN
         rUVw==
X-Forwarded-Encrypted: i=1; AJvYcCWSMPWAd5s6beWr1NNxK2/Bf9iic3yenMwif6lLkh6S+bPO1RPSL46y/FLkeGczBC1X0/8=@vger.kernel.org, AJvYcCWg9gCZ/3tbeXHoORopKfvXvUjOpUDGOk76yuQfF3KwTi/l6cuftdyOf8D9E3kEQHkZJbzM37eF1ByUEz6n@vger.kernel.org, AJvYcCXt6fGufcfCC+B/pzjM3lY+HDdpXEWytJsFM8Sij7paF0jg/vG8PyXOhtVjwE01/IBHQ73pBSFKxE+LWWgKQKq2XpRt@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7P1PR3B+OwqF1DstrrCftU8H1L5uPqAylsX631ADN6SFc61/
	/ZsY8vxev+SXY+vKsUZgLnnkycJe6nHTLs/t3J1f4MYH6N02ujDX
X-Gm-Gg: ASbGncsFWDXtIuBSz9s+IZ/25OtLPE0uPYUhwmcnT6PiRlvbucIz50R2WHcTbgA7XUH
	XS9ead1swgSqnJ/E4L4GinjAb2P2Sgl4s4/b7fU+aP1obs+uH053QD4u2/l1RDpPXPjMHMdO4yv
	DAJWaA1Nb3NcY7exiTNyDls2O8vzEky0k0ey0fd6901SHz2xTOp7DLv1HrJN1/xfmJU9odtLD/5
	KjB3Bx1XKScN5NyOI9EdLRAv4WeE1dBPxri1MsTMCbe4pMw20he1mTShg13PVtwO9juJ8Ru4CA4
	zR73v3Y+eWX0FvkQZ5nmxV5rweY=
X-Google-Smtp-Source: AGHT+IEq6YUeCvZOJCsZbBaS2JUjXTcHhttlXP8ATHkEhx7rqb2fksXRqeGL53z6MbJEEYxvzEtPBA==
X-Received: by 2002:a05:6512:b0f:b0:549:91c6:96a8 with SMTP id 2adb3069b0e04-54d6e6169bamr4248610e87.7.1745330518268;
        Tue, 22 Apr 2025 07:01:58 -0700 (PDT)
Received: from krava ([83.148.32.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc72fsm667357366b.101.2025.04.22.07.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:01:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 22 Apr 2025 16:01:56 +0200
To: Alejandro Colomar <alx@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 22/22] man2: Add uprobe syscall page
Message-ID: <aAehVOlj-W5kVyW3@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-23-jolsa@kernel.org>
 <42yzod7olktnj4meijj57j5peiojywo2d47d5gefnbmbwxfz4b@5ek6puondmck>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42yzod7olktnj4meijj57j5peiojywo2d47d5gefnbmbwxfz4b@5ek6puondmck>

On Tue, Apr 22, 2025 at 09:00:17AM +0200, Alejandro Colomar wrote:
> Hi Jiri,
> 
> On Mon, Apr 21, 2025 at 11:44:22PM +0200, Jiri Olsa wrote:
> > Adding man page for new uprobe syscall.
> > 
> > Cc: Alejandro Colomar <alx@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  man/man2/uprobe.2    | 49 ++++++++++++++++++++++++++++++++++++++++++++
> >  man/man2/uretprobe.2 |  2 ++
> >  2 files changed, 51 insertions(+)
> >  create mode 100644 man/man2/uprobe.2
> > 
> > diff --git a/man/man2/uprobe.2 b/man/man2/uprobe.2
> > new file mode 100644
> > index 000000000000..2b01a5ab5f3e
> > --- /dev/null
> > +++ b/man/man2/uprobe.2
> > @@ -0,0 +1,49 @@
> > +.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.\"
> > +.TH uprobe 2 (date) "Linux man-pages (unreleased)"
> > +.SH NAME
> > +uprobe
> > +\-
> > +execute pending entry uprobes
> > +.SH SYNOPSIS
> > +.nf
> > +.B int uprobe(void);
> > +.fi
> > +.SH DESCRIPTION
> > +.BR uprobe ()
> > +is an alternative to breakpoint instructions
> > +for triggering entry uprobe consumers.
> 
> What are breakpoint instructions?

it's int3 instruction to trigger breakpoint (on x86_64)

> 
> > +.P
> > +Calls to
> > +.BR uprobe ()
> > +are only made from the user-space trampoline provided by the kernel.
> > +Calls from any other place result in a
> > +.BR SIGILL .
> > +.SH RETURN VALUE
> > +The return value is architecture-specific.
> > +.SH ERRORS
> > +.TP
> > +.B SIGILL
> > +.BR uprobe ()
> > +was called by a user-space program.
> > +.SH VERSIONS
> > +The behavior varies across systems.
> > +.SH STANDARDS
> > +None.
> > +.SH HISTORY
> > +TBD
> > +.P
> > +.BR uprobe ()
> > +was initially introduced for the x86_64 architecture
> > +where it was shown to be faster than breakpoint traps.
> > +It might be extended to other architectures.
> > +.SH CAVEATS
> > +.BR uprobe ()
> > +exists only to allow the invocation of entry uprobe consumers.
> > +It should
> > +.B never
> > +be called directly.
> > +.SH SEE ALSO
> > +.BR uretprobe (2)
> 
> The pages are almost identical.  Should we document both pages in the
> same page?

great, I was wondering this was an option, looks much better
should we also add uprobe link, like below?

thanks,
jirka


---
diff --git a/man/man2/uprobe.2 b/man/man2/uprobe.2
new file mode 100644
index 000000000000..ea5ccf901591
--- /dev/null
+++ b/man/man2/uprobe.2
@@ -0,0 +1 @@
+.so man2/uretprobe.2

