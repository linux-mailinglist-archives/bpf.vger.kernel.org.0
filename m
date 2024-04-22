Return-Path: <bpf+bounces-27473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DDB8AD5C8
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 22:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BFD281C5F
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D144D155729;
	Mon, 22 Apr 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh0PyTvB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD415535D;
	Mon, 22 Apr 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817533; cv=none; b=rQzqJEhOmB2XF8Idd2UTDTSfmp5esBsAWqX0qAJMtrirdq9nkxysTBkfx+hGGzh8l8qEvSe9Dk6o75LgIHiASxZiJ/OIk66S52wt/JiRE/gEDxc+R5StAcLpvmoVfCOf6Km+XqzmYmllmB7ASgetMg3YecUkkHSCVLh3DH+6aZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817533; c=relaxed/simple;
	bh=YjFau6lGb9LTELqCEb2X2127G9ZwnIlW8kYv21dRJJA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz01MX3q+BR9HA7r0Met38v4BJEZfYKwZtaPZILQRbyuvEmv4jyvytVUBFoUIHrpNO3GGGoq4H+XoJU17oZwRJzvFZltmJIuyz/XKdCi5cqclctYDD6kqtKFBIZUOTkb7ijgnvWr8KC2R94joC+I6gwMFpXCwdb+M+YgdxldpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh0PyTvB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41aa21b06b3so4139585e9.0;
        Mon, 22 Apr 2024 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713817529; x=1714422329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLiWlfsmSMobonfpzJOKL/uqlF5pCv8voW0Gv0gZ6Xg=;
        b=Gh0PyTvBauqIoQuzFwPzAT9cIllRID2jLxH/W8N+oJUukbTuuXgj+iNlz/R5uH2162
         O3Fl7cdKLs540cAgmrg5BIqjpTBnYz03oPE590YpFFgU5aaeps3Emef8r+ZblBPuqEMF
         uMg42sbGgeDfa0VQG4ZjAEEa7q2azc8hjpXyX2N17u0UPNhhPngH1Ra+ZMD8G+IJ+W9B
         aa+POBd78H1LoI5DNgjBpWs4wxeYu1Wd8jS3Etr4zKwnnP+WSuYwIFbzxWKTKUjhrSuZ
         1yUDVEYT0oPvbYIWEF6Wvea8BTjnRq0pX1hjE0oYnKfgY2HyimlH8SuF0MOh/V/1BwjX
         MftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713817529; x=1714422329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLiWlfsmSMobonfpzJOKL/uqlF5pCv8voW0Gv0gZ6Xg=;
        b=lzA32fT7e6IVhv98ah6lzfGzBq1ujzlLUNQKxCJ72UUHImZwCMmsy/sPqrVVLnJ2Mm
         rwkgjtrE8d0jYn8gbxtk0xENqQoHvBCr49w7NX4rALMPdhvwescFiNbzY3nQ6JqBEoj1
         mbMtHRm1FcRynnHiROR+BAI8v3YBlm39n63Nw2ZkVuiskxjf22qo/8db/pZmcbLhHQ34
         YI79WLgSMRu5QixmfXAno0qrvLQ96jEH2HWExL2tWHWCssTh1jUIPokbAINHqz+bGH5r
         9cK3Nuft1nDuVHrKM1EIw2XwULWH7xpIug6dLcG7tadLXxzbmUKUYmBiv7vWAgWT6rIj
         87nA==
X-Forwarded-Encrypted: i=1; AJvYcCXEgou/2UoJKC2RJHvfiiYuKKJOaw/KMtTsq2DvHUctatnfGPCPQzWYIbPRBF53xG8JyHGnBeRlKWhT1dGX95kmH2yGdtEIzHFz1Wp8kfWR6heeDYmnMtwGV6zHC7qpEqA7UKTAdfWo9By+5wsbpcgx/dskr3s73eWa+hyZspxveVSVZ/WLmbqehHP1HgqDFhMq08MRRGjfS/3p91LOn/xZ
X-Gm-Message-State: AOJu0YzYt9KRGFV3SsOmXtjiBWj8U3E6EtJTUdQ0HCzi/toCeYeJdWja
	vpo2nlOhsKZhtWtkoXhwyQ7gdPFjC4FOEG2AlkQNC+ZCxCAuc+cS
X-Google-Smtp-Source: AGHT+IFdhuSfTDsPTFsuDuTro4BCnnKCqf/kS6VlPXSQ+kB2rJD85vAd/+j/R7CUUdiaTnwaZ5wk8g==
X-Received: by 2002:a05:600c:1c9b:b0:416:4641:5947 with SMTP id k27-20020a05600c1c9b00b0041646415947mr9806179wms.34.1713817528960;
        Mon, 22 Apr 2024 13:25:28 -0700 (PDT)
Received: from krava ([83.240.62.18])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b004182b87aaacsm17888971wmq.14.2024.04.22.13.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:25:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Apr 2024 22:25:25 +0200
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
Subject: Re: [PATCHv3 bpf-next 0/7] uprobe: uretprobe speed up
Message-ID: <ZibHtXFcHr_sJdP9@krava>
References: <20240421194206.1010934-1-jolsa@kernel.org>
 <20240423000943.478ccf1e735a63c6c1b4c66b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423000943.478ccf1e735a63c6c1b4c66b@kernel.org>

On Tue, Apr 23, 2024 at 12:09:43AM +0900, Masami Hiramatsu wrote:
> Hi Jiri,
> 
> On Sun, 21 Apr 2024 21:41:59 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > hi,
> > as part of the effort on speeding up the uprobes [0] coming with
> > return uprobe optimization by using syscall instead of the trap
> > on the uretprobe trampoline.
> > 
> > The speed up depends on instruction type that uprobe is installed
> > and depends on specific HW type, please check patch 1 for details.
> > 
> > Patches 1-6 are based on bpf-next/master, but path 1 and 2 are
> > apply-able on linux-trace.git tree probes/for-next branch.
> > Patch 7 is based on man-pages master.
> 
> Thanks for updated! I reviewed the series and just except for the
> manpage, it looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> for the series.
> If Linux API maintainers are OK, I can pick this in probes/for-next.

great, thanks

> (BTW, who will pick the manpage patch?)

ugh, I cc-ed linux-api but not linux-man@vger.kernel.org
I'll add that for new version

jirka

> 
> Thank you,
> 
> > 
> > v3 changes:
> >   - added source ip check if the uretprobe syscall is called from
> >     trampoline and sending SIGILL to process if it's not
> >   - keep x86 compat process to use standard breakpoint
> >   - split syscall wiring into separate change
> >   - ran ltp and syzkaller locally, no issues found [Masami]
> >   - building uprobe_compat binary in selftests which breaks
> >     CI atm because of missing 32-bit delve packages, I will
> >     need to fix that in separate changes once this is acked
> >   - added man page change
> >   - there were several changes so I removed acks [Oleg Andrii]
> > 
> > Also available at:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   uretprobe_syscall
> > 
> > thanks,
> > jirka
> > 
> > 
> > Notes to check list items in Documentation/process/adding-syscalls.rst:
> > 
> > - System Call Alternatives
> >   New syscall seems like the best way in here, becase we need
> >   just to quickly enter kernel with no extra arguments processing,
> >   which we'd need to do if we decided to use another syscall.
> > 
> > - Designing the API: Planning for Extension
> >   The uretprobe syscall is very specific and most likely won't be
> >   extended in the future.
> > 
> >   At the moment it does not take any arguments and even if it does
> >   in future, it's allowed to be called only from trampoline prepared
> >   by kernel, so there'll be no broken user.
> > 
> > - Designing the API: Other Considerations
> >   N/A because uretprobe syscall does not return reference to kernel
> >   object.
> > 
> > - Proposing the API
> >   Wiring up of the uretprobe system call si in separate change,
> >   selftests and man page changes are part of the patchset.
> > 
> > - Generic System Call Implementation
> >   There's no CONFIG option for the new functionality because it
> >   keeps the same behaviour from the user POV.
> > 
> > - x86 System Call Implementation
> >   It's 64-bit syscall only.
> > 
> > - Compatibility System Calls (Generic)
> >   N/A uretprobe syscall has no arguments and is not supported
> >   for compat processes.
> > 
> > - Compatibility System Calls (x86)
> >   N/A uretprobe syscall is not supported for compat processes.
> > 
> > - System Calls Returning Elsewhere
> >   N/A.
> > 
> > - Other Details
> >   N/A.
> > 
> > - Testing
> >   Adding new bpf selftests and ran ltp on top of this change.
> > 
> > - Man Page
> >   Attached.
> > 
> > - Do not call System Calls in the Kernel
> >   N/A.
> > 
> > 
> > [0] https://lore.kernel.org/bpf/ZeCXHKJ--iYYbmLj@krava/
> > ---
> > Jiri Olsa (6):
> >       uprobe: Wire up uretprobe system call
> >       uprobe: Add uretprobe syscall to speed up return probe
> >       selftests/bpf: Add uretprobe syscall test for regs integrity
> >       selftests/bpf: Add uretprobe syscall test for regs changes
> >       selftests/bpf: Add uretprobe syscall call from user space test
> >       selftests/bpf: Add uretprobe compat test
> > 
> >  arch/x86/entry/syscalls/syscall_64.tbl                    |   1 +
> >  arch/x86/kernel/uprobes.c                                 | 115 ++++++++++++++++++++++++++++++
> >  include/linux/syscalls.h                                  |   2 +
> >  include/linux/uprobes.h                                   |   3 +
> >  include/uapi/asm-generic/unistd.h                         |   5 +-
> >  kernel/events/uprobes.c                                   |  24 +++++--
> >  kernel/sys_ni.c                                           |   2 +
> >  tools/include/linux/compiler.h                            |   4 ++
> >  tools/testing/selftests/bpf/.gitignore                    |   1 +
> >  tools/testing/selftests/bpf/Makefile                      |   6 +-
> >  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c     | 123 +++++++++++++++++++++++++++++++-
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c   | 362 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/uprobe_syscall.c        |  15 ++++
> >  tools/testing/selftests/bpf/progs/uprobe_syscall_call.c   |  15 ++++
> >  tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c |  13 ++++
> >  15 files changed, 681 insertions(+), 10 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
> > 
> > 
> > Jiri Olsa (1):
> >       man2: Add uretprobe syscall page
> > 
> >  man2/uretprobe.2 | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 man2/uretprobe.2
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

