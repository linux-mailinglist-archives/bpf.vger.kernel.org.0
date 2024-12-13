Return-Path: <bpf+bounces-46906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2CE9F1829
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEDF188BAF9
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0892A19D09F;
	Fri, 13 Dec 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqwhlmf5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7F191F77;
	Fri, 13 Dec 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126749; cv=none; b=nJEE35+fjyhyji7we0d54K1AXr5GVkLV+AxsPOzSWY8R3x7NhsMUneNmvYbHt+P7O6TeTv/Jgtxjs/oV5Qa8qKdOkx9bZVxONRachCn632/8YmY3bCtjzsDYaAFA+YP7FsoiUtNkJv84umzOIgGOgKF0p4omaGpZtaiPDOCM8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126749; c=relaxed/simple;
	bh=P8xh8DSg2ceEwk9nqYxRdidov8zYMx8BAYdnboWZM2Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkwsnjfm962h6mfq4gthTImSAR3rO03YaMNCZLIeFNG0aVHBlz8QobC1eglU1B2pdFX24YkUpKpf2dYIY5qfYrZW+/u74QTSRpS+HwO2YXmMaYcCzsScmaSe/VDaxt4GK6ioFqaNj4vTHfqrjUcC6qsdQ8zfzpEOvK1w9rJiAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqwhlmf5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso3394201a12.2;
        Fri, 13 Dec 2024 13:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734126746; x=1734731546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAiPt4pKu5cF436gFldLI1uA4wJP/9SMBAOpZCXqVFk=;
        b=Oqwhlmf599pPONV9cecgMCXxV4aJyJ6gXGxPsHHSt+U/AjyX4vl/gdkEkZE+bSyEt5
         sPh4ibn5z1n16/E6aAWPEj4tHSOAAl9JPnNQ2nk9Dh5+6PL7AVu2izPzML31mPZTbveX
         3RlOYMj7kykzDzy2xw5bgHvzQMs9rT3+zTrByZVsmNUyS1BDf7sPMEY3mrnwdyQ5AoWz
         YUQQVmEeBLvPNubzh5C2sRm9fl5Z0xMKUsB6EwwoOzOzlD4lM8vXzj1TrEVk8CpuFwk1
         2z9+tISOeXSi41EcIAm4ZDMSBh5I6dFQ+YtbSIs8FuIHwlT+tvTlQwTKJqU0ZgToo35s
         q6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734126746; x=1734731546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAiPt4pKu5cF436gFldLI1uA4wJP/9SMBAOpZCXqVFk=;
        b=QypJI1N6JalwA9MKfTATdz5UkOp0qCTH7PPLN1q0GKgNqt9X/ZTiXSg5YtDEZ1pE7s
         l0KKbHq0ydTsECuL6tqHDdpNX9KJfdGHumnvsvR0O3Sq4n7K9l90RLWrtJh2vcC5p6m4
         TNfaW7NcIG8Ziqdkh0l9T4yTQFdqOmrN9kY0v58LZbNLQCuHmOht0dzZslsYmuK5671u
         nA795sQwZGJG2apFM5JHbH+lOlcwa/VWkvMfIaxz1K2FtNG9BdbtvsiXwDOyuXdbecQm
         tnIBiKB9bSP0ZciaKenYDxIMQdHeupirUKm2DGOrA8hjz02VL6ku/UTGQDBiQyRwgcRy
         crJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW/oOlkL24yCaT16S8G5+6O68EJV+fHTHo4GudIEO1Oij+jwzr4bal68OO78dv1i6JU/2+ZPCaOfE6/p1uJzDENKuP@vger.kernel.org, AJvYcCVfvxH9xZ1AAmhXOeXZn8wwcSZmN1PBg23/ymjon+xnYpxCCK2lY7y1zzhYw598B9SaOdg=@vger.kernel.org, AJvYcCX2oQV2b67MlHsRWI3mylR3YmOOeTdXaYvza2FXW4O8xfzv4vSAt2yqQ4NfERFPuDt3Cbuksw3DqqwCQqRl@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYuqUd2U5ubOrkTcli1eDBhXVvSCtTmoZkXdvYwPjqsrZtZGH
	rl4K3qrqjt23ySkkn915VwKvPtWROYtid6Sf2qmSKP+nvZH25Q9j
X-Gm-Gg: ASbGncv9FKwc3IeTi47ncsOYQZC/VHgQ3ll0FNW74lU+oHB9nJLaEmzKpRjY5h0xZa/
	IjldRptto9fgY3QNNeTdKMxNzz5Igkb+xy3Rdmnpfr70vAkFivrWYRCSVycKSMvp/hIrHFVZ5ec
	wErkxo3958QyRCQspHDBwzn3cyZ7J7d/HATlt2rrqMLJzTLwYhCWbwZ0DV2LUUsG9LjjbcETx54
	g4qk34ADMKxV1AcVkqYoExIt9Fx+xMCijZnXQkSsfiikST7x7YPmAWYj8YZzPnk3g==
X-Google-Smtp-Source: AGHT+IGML6XaJQy2k33PzG+FcokhI/HVROsD3POyBEip2kiXRj0K/Lml2bwFy05293LjAtJqIjaWCw==
X-Received: by 2002:a05:6402:5387:b0:5d0:c9e6:30bc with SMTP id 4fb4d7f45d1cf-5d63c306ad1mr3698962a12.10.1734126745868;
        Fri, 13 Dec 2024 13:52:25 -0800 (PST)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab50desm252025a12.3.2024.12.13.13.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:52:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 22:52:23 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt
 probes on x86_64
Message-ID: <Z1yslwyX0yYzS_sb@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241213105105.GB35539@noisy.programming.kicks-ass.net>
 <Z1wxqhwHbDbA2UHc@krava>
 <20241213135433.GD35539@noisy.programming.kicks-ass.net>
 <Z1w_Qi_Wya56YDO_@krava>
 <20241213183954.GC12338@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213183954.GC12338@noisy.programming.kicks-ass.net>

On Fri, Dec 13, 2024 at 07:39:54PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 13, 2024 at 03:05:54PM +0100, Jiri Olsa wrote:
> > On Fri, Dec 13, 2024 at 02:54:33PM +0100, Peter Zijlstra wrote:
> > > On Fri, Dec 13, 2024 at 02:07:54PM +0100, Jiri Olsa wrote:
> > > > On Fri, Dec 13, 2024 at 11:51:05AM +0100, Peter Zijlstra wrote:
> > > > > On Wed, Dec 11, 2024 at 02:33:49PM +0100, Jiri Olsa wrote:
> > > > > > hi,
> > > > > > this patchset adds support to optimize usdt probes on top of 5-byte
> > > > > > nop instruction.
> > > > > > 
> > > > > > The generic approach (optimize all uprobes) is hard due to emulating
> > > > > > possible multiple original instructions and its related issues. The
> > > > > > usdt case, which stores 5-byte nop seems much easier, so starting
> > > > > > with that.
> > > > > > 
> > > > > > The basic idea is to replace breakpoint exception with syscall which
> > > > > > is faster on x86_64. For more details please see changelog of patch 8.
> > > > > 
> > > > > So ideally we'd put a check in the syscall, which verifies it comes from
> > > > > one of our trampolines and reject any and all other usage.
> > > > > 
> > > > > The reason to do this is that we can then delete all this code the
> > > > > moment it becomes irrelevant without having to worry userspace might be
> > > > > 'creative' somewhere.
> > > > 
> > > > yes, we do that already in SYSCALL_DEFINE0(uprobe):
> > > > 
> > > >         /* Allow execution only from uprobe trampolines. */
> > > >         vma = vma_lookup(current->mm, regs->ip);
> > > >         if (!vma || vma->vm_private_data != (void *) &tramp_mapping) {
> > > >                 force_sig(SIGILL);
> > > >                 return -1;
> > > >         }
> > > 
> > > Ah, right I missed that. Doesn't that need more locking through? The
> > > moment vma_lookup() returns that vma can go bad.
> > 
> > ugh yes.. I guess mmap_read_lock(current->mm) should do, will check
> 
> If you check
> tip/perf/core:kernel/events/uprobe.c:find_active_uprobe_speculative()
> you'll find means of doing it locklessly using RCU.

right, will use that

thanks,
jirka

