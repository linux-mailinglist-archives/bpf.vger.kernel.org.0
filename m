Return-Path: <bpf+bounces-46829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348B9F0856
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 10:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305A81690CD
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E01B395F;
	Fri, 13 Dec 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS8YRKXO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C418FDDF;
	Fri, 13 Dec 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083218; cv=none; b=eZIlCLHtfYimgQumZtWnS5kyoHlG/Nufq9PyI//VdvwUYk8Ad5a+JOoM4Ove1kyepfYSK8iH2ugxQa5i2a1//QGt6MfQ3hu8xGKIZEOvi1S52zTnF1zh0T1sQdoAFVp0W482ohCmKgrZAKQ0n3HxLJFOW81Yn9NAfYb8ZpuKH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083218; c=relaxed/simple;
	bh=Fb4ojrjIXUQQjlGljhBTlkjSXjzV08vRStnvR5HvFIY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug7y3/0Djdz0xmNNMOZRgH7fVCf9v5KP5dxNx8272G37Bd9YBTcsFOCgKYQ7IBwNkX1mxTdCVKHJX4nClxCLNFtTWDy5DP91ZG2z1XqkpIuk2mThqsZ2+MbNrcMA2N7tUUr89MYUwQWKVMZ5ZS24jpXv6mGCchxNuVdxrNyJ7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS8YRKXO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43618283d48so10998115e9.1;
        Fri, 13 Dec 2024 01:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734083215; x=1734688015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FIBvrKksVP7QW3u1SZtvYqLI5Bw8wSX/gMZ0AyP/buY=;
        b=NS8YRKXOBkW36rl9/wnrq8Cb3saI9pcSEjryL9/b4Qu8oNBFKwKIcicaD/HLKCh6w0
         Qzmc7DfefjSExlvug/yZiV57nyOyje6PTWURJZpua5abZcxhYz2X54NsiqllZaLkP3wX
         o/CBajfDI7jWhCIitZcvEbgU+bLFOPoaCXFjcXg1mRZk2JRnIySyV9a+Z693NuzTAfu/
         zxHWNkpXHgelRzoELC8h8+mRRgtIJT7/DSwZcTMm3Rib2xU3tJHFPjodQTN107CzRXWy
         Hq8Zl/07GTlP1JyoHFaKtJR2xwTssaZPNopEPQPLEY9/6lyCjgZB3LfEySyQPJb7+cCy
         1wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734083215; x=1734688015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIBvrKksVP7QW3u1SZtvYqLI5Bw8wSX/gMZ0AyP/buY=;
        b=wxG4XSfeoOmGGABTR4Zp1vYbfkdEF3wLy6Qu1IVDMw2VDNYBbeUipu8sv0KQY9NSgg
         28ndvSlBOD+VMbZdvDgfycWrOpbUng9we0n88gf13of7VTDjFH/acL5P0xIvXtZ071gX
         tGvaPS/PgckNKsXUoZeo+l4BiEiFtnifSwA3UjMoEFZ6QIcYNUc8oWUWndZGaCX3czJ+
         xt5l2VciXFHqKWjv4Q+YaybT38qdjrQEFa51wq/tZN5aI+qh9coLOGuyy8pDae+c+e5s
         RL4peAUZFpu5DdIJg2F1qSxir3cbPbkJ7A3NJEt1Nxvxwtu10aV9pmvr+rbJQa93PBSF
         LF4w==
X-Forwarded-Encrypted: i=1; AJvYcCUc4YkFe9DgVQ4USMO7Tzt4rO8SY9yXJVPNOxlJ0izInhwWNey+GAXhnwR7qPN76ywh3daudZtV290qYFpE@vger.kernel.org, AJvYcCX7Jy8Xl0lho8ObOM4gRoRtpCRNI+pHiA38mqNQe/S2zEnCmkWr8sjc3iNhv6dMyl8OnoVrS5oHXELVGYT92hgsEHnG@vger.kernel.org, AJvYcCXtqtvUAmNxRgTHWVqQl8kxbDmwlLeXUvG02sw3av6bD3DEtbTEsc1ZS+Q2ZoKJhxmIzz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYdPvMz0m/24xI/39nNpFebjzI7xss4vHpBInaQXcgfP04cbt
	ubiyl+8Ojgz6ugpD+UQxrzrKp0lB7Mc3V4qaK610w/o/Zx0+LcLJ
X-Gm-Gg: ASbGncuC5MHDrqKb3eP13waFCq/9fZnYIG5XJqqcgjh5deCjCFVgT8M3sxrllfk+y+w
	kMtuvl45ASzWmOan1Z6GGmKFKlyDulxDsUGEUlqaIHH6HCZaVoWzuZWEBwgu2gczDVtqDiN3r+E
	hAOdVB5QCJU5FgLWCjZal/ACJgi1jwEiD7BBqPzcXFpalruMUUdhTnC1l0JOzHGbf+UVfotoKm+
	O+wzKthHXUrvEWkYhtP1EkuxByyIKDOVL0QYf6Jt8aPpImPb0CP4W0dWmEQHn196paBFfqadbm6
	mGp8VahfUF1J9RBzfyPBQo87w1dR5Q==
X-Google-Smtp-Source: AGHT+IFKjWs5Y5dxu5SYlPM2TFrA57DoA+cTVQSBOy42DlEnTFd/N+glUTQ4+oGlMzybQtbzOSrBQQ==
X-Received: by 2002:a05:6000:699:b0:386:39ae:e803 with SMTP id ffacd0b85a97d-3888e0beb57mr1391740f8f.54.1734083214144;
        Fri, 13 Dec 2024 01:46:54 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dd5bsm6561784f8f.99.2024.12.13.01.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 01:46:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Dec 2024 10:46:51 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt
 probes on x86_64
Message-ID: <Z1wCi6zb2pto55gn@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <CAEf4BzaqFJw5wR5V7HCOf_31k+BXY7_hovNB=S7nurYez2ckcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaqFJw5wR5V7HCOf_31k+BXY7_hovNB=S7nurYez2ckcg@mail.gmail.com>

On Thu, Dec 12, 2024 at 04:43:02PM -0800, Andrii Nakryiko wrote:
> On Wed, Dec 11, 2024 at 5:34 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > this patchset adds support to optimize usdt probes on top of 5-byte
> > nop instruction.
> >
> > The generic approach (optimize all uprobes) is hard due to emulating
> > possible multiple original instructions and its related issues. The
> > usdt case, which stores 5-byte nop seems much easier, so starting
> > with that.
> >
> > The basic idea is to replace breakpoint exception with syscall which
> > is faster on x86_64. For more details please see changelog of patch 8.
> >
> > The run_bench_uprobes.sh benchmark triggers uprobe (on top of different
> > original instructions) in a loop and counts how many of those happened
> > per second (the unit below is million loops).
> >
> > There's big speed up if you consider current usdt implementation
> > (uprobe-nop) compared to proposed usdt (uprobe-nop5):
> >
> >   # ./benchs/run_bench_uprobes.sh
> >
> >       usermode-count :  233.831 ± 0.257M/s
> >       syscall-count  :   12.107 ± 0.038M/s
> >   --> uprobe-nop     :    3.246 ± 0.004M/s
> >       uprobe-push    :    3.057 ± 0.000M/s
> >       uprobe-ret     :    1.113 ± 0.003M/s
> >   --> uprobe-nop5    :    6.751 ± 0.037M/s
> >       uretprobe-nop  :    1.740 ± 0.015M/s
> >       uretprobe-push :    1.677 ± 0.018M/s
> >       uretprobe-ret  :    0.852 ± 0.005M/s
> >       uretprobe-nop5 :    6.769 ± 0.040M/s
> 
> uretprobe-nop5 throughput is the same as uprobe-nop5?..

ok, there's bug in the uretprobe bench setup, the number is wrong, sorry
will send new numbers

jirka

> 
> 
> >
> >
> > v1 changes:
> > - rebased on top of bpf-next/master
> > - couple of function/variable renames [Andrii]
> > - added nop5 emulation [Andrii]
> > - added checks to arch_uprobe_verify_opcode [Andrii]
> > - fixed arch_uprobe_is_callable/find_nearest_page [Andrii]
> > - used CALL_INSN_OPCODE [Masami]
> > - added uprobe-nop5 benchmark [Andrii]
> > - using atomic64_t in tramp_area [Andri]
> > - using single page for all uprobe trampoline mappings
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > Jiri Olsa (13):
> >       uprobes: Rename arch_uretprobe_trampoline function
> >       uprobes: Make copy_from_page global
> >       uprobes: Add nbytes argument to uprobe_write_opcode
> >       uprobes: Add arch_uprobe_verify_opcode function
> >       uprobes: Add mapping for optimized uprobe trampolines
> >       uprobes/x86: Add uprobe syscall to speed up uprobe
> >       uprobes/x86: Add support to emulate nop5 instruction
> >       uprobes/x86: Add support to optimize uprobes
> >       selftests/bpf: Use 5-byte nop for x86 usdt probes
> >       selftests/bpf: Add uprobe/usdt optimized test
> >       selftests/bpf: Add hit/attach/detach race optimized uprobe test
> >       selftests/bpf: Add uprobe syscall sigill signal test
> >       selftests/bpf: Add 5-byte nop uprobe trigger bench
> >
> >  arch/x86/entry/syscalls/syscall_64.tbl                  |   1 +
> >  arch/x86/include/asm/uprobes.h                          |   7 +++
> >  arch/x86/kernel/uprobes.c                               | 255 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/syscalls.h                                |   2 +
> >  include/linux/uprobes.h                                 |  25 +++++++-
> >  kernel/events/uprobes.c                                 | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  kernel/fork.c                                           |   1 +
> >  kernel/sys_ni.c                                         |   1 +
> >  tools/testing/selftests/bpf/bench.c                     |  12 ++++
> >  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  42 +++++++++++++
> >  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 326 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/uprobe_optimized.c    |  29 +++++++++
> >  tools/testing/selftests/bpf/sdt.h                       |   9 ++-
> >  14 files changed, 880 insertions(+), 23 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_optimized.c

