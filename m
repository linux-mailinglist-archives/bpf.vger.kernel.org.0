Return-Path: <bpf+bounces-45081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CE79D0CBA
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 10:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D231F2239E
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D7192B66;
	Mon, 18 Nov 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6fAf0Jd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3218E361;
	Mon, 18 Nov 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923576; cv=none; b=D68P+rnIrfkrOFszUGNHAGQuMHE8XrJoYairRAXGAhGxgCWuXTWsI/Qg5s0UDJSQ2j/K/pAfmVD8XaDHBiPicP7tzZWvOd9m4KaI8lUuXf/sqj7rs1T79F6bN9Clz9L0X36gWeHsZ4eSK1GqQwL8zLg3vyF8CoisqelR7fcG4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923576; c=relaxed/simple;
	bh=clpEwkq7OFcEO/AkrHyvA//H6oCN2aMzRoh+nIJjAvA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raxQig0tMoegmjv8KCipN8H5UxNhHsTaEpsHq1QHJEU1YJCS76Nrn0yhQrmSncilC6VCExXUl9iAVvcbNVI4HKgra0nCvLuMaGosx9DAL9catZdBB7wKK8ySLGwO7MDqu7q1Lhdne/5QDW1kR0OgrdiCbbEa7fHKe61TDt+76UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6fAf0Jd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so2007755f8f.3;
        Mon, 18 Nov 2024 01:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731923573; x=1732528373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZthoNTYuoSTKsL9w3a6LFvwzeMySe7WDnpbpdlEhTo=;
        b=E6fAf0Jd754Mk6GDXkdScT5zpCB1hCS/b01yp8F63Oc1eD3ZWivQJLn2Z1Cq0WX7X+
         3ghOyG4UVdvdHwm6XBmrbTOyfe9mjs7X+HqTRHuqg2aflptT78iUHVXhSkMu+tDvssTf
         Nbu+vWT1LW8k4oAibxNr9rjwCuf4VmN+saMRr0LO2DvrJIy/3OyirnO7DRSa7avKd1yk
         Lc8Gphx9bL10Tuo9vydehze4XFt/dURd4R9VfHJArFiBe+AoioFinQYdr82MpxiGRKtT
         3QM9YrmnehhDKIkvadD3hcXYjyqcPtFBBVnI0ChbSoCTK19U1Rb7hNqibIZPhIGxr5dC
         X+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731923573; x=1732528373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZthoNTYuoSTKsL9w3a6LFvwzeMySe7WDnpbpdlEhTo=;
        b=NSykCMfHyX+bxtnkiCkTDSFIsg6TZEfTZag3YscyiYQLTXqIH+Qhi74E75nQFKDKXi
         3NX02ZmYVCfON7NG0xSp7mU7UwWIDc8aUjems/wEGTt/X7PmgpHCdQWdyTU6uBwKOQJt
         Ta7PE4WJUiBYUhgGtsTZEXm/kNUSuUoLJox3mDEUldeEQ96cd1shwu+LIRK4i1+FWY5w
         6s/0X8bY3iVyKouXNuTzVm8dLgg8BALb50ZJlJTUstNmJRGBeCY56Dn3caQH3b8EjXMy
         ODSgRQH+VxIkt75CTShxL2QozoxkVHd3HhyDRdHeD0pOBNrk6KBXUEgYW8jSoIrQYRGN
         0KkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXdlLhEk0DsfJVY8D+EVbWj8l9AaowlQaWD9ilabYsp+DjwZvSkireXa3Seg2fjkCgaH4=@vger.kernel.org, AJvYcCWF7QAcwT5faDj7zFAouQgSGQgkJobjnt5b0/BHAIDhW935QIXE9k7G0HXbtJ7CVxx58hyBlIZusPj2ROd/5Q91Di8i@vger.kernel.org, AJvYcCWtY+2x1wKxncZKTa1yCDiGW3SvfMV088S0H4OVQeXMo0+CvlS1RQoRid8v1mbxLJazcuwofvLTzxGtXyND@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdx9eD5OYVr2AntCCRFNOvqlYe1SgwBGE7P+ygMGKE7SAJHWCk
	4tqkboVG4r7tYxIpCAYGos8QE8Znbfq2A1xeCGR50Q0k6DCiiBxd
X-Google-Smtp-Source: AGHT+IGAtRgXjncHwmpQFzig+ldv+Ywcn3GiRJDGkCtqiIMfQRPWxo7I2N3YEecAeerhq6KEJIZYQQ==
X-Received: by 2002:a05:6000:1fa3:b0:37c:cbd4:ec9 with SMTP id ffacd0b85a97d-382259023f1mr9663343f8f.5.1731923572507;
        Mon, 18 Nov 2024 01:52:52 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382398aa925sm6204490f8f.50.2024.11.18.01.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:52:52 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Nov 2024 10:52:50 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [RFC 00/11] uprobes: Add support to optimize usdt probes on
 x86_64
Message-ID: <ZzsOcgJkdnq5ywE_@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241118170458.c825bf255c2fb93f2e6a3519@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118170458.c825bf255c2fb93f2e6a3519@kernel.org>

On Mon, Nov 18, 2024 at 05:04:58PM +0900, Masami Hiramatsu wrote:
> Hi Jiri,
> 
> On Tue,  5 Nov 2024 14:33:54 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
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
> > is faster on x86_64. For more details please see changelog of patch 7.
> 
> This looks like a great idea!
> 
> > 
> > The first benchmark shows about 68% speed up (see below). The benchmark
> > triggers usdt probe in a loop and counts how many of those happened
> > per second.
> 
> Hmm, interesting result. I'd like to compare it with user-space event,
> which is also use "write" syscall to write the pre-defined events
> in the ftrace trace buffer.
> 
> But if uprobe trampoline can run in the comparable speed, user may
> want to use uprobes because it is based on widely used usdt and
> avoid accessing tracefs from application. (The user event user
> application has to setup their events via tracefs interface)

I see, will check more details on user events

> 
> > 
> > It's still rfc state with some loose ends, but I'd be interested in
> > any feedback about the direction of this.
> 
> So does this change the usdt macro? Or it just reuse the usdt so that
> user applications does not need to be recompiled?

yes, ideally apps keeps using the current usdt macro (or switch to [1])
which would unwind to nop5 (or whatever we will end up using)

there's an issue wrt to old kernels running apps compiled with the new usdt macro,
but it's solvable as Andrii pointed out in the other reply [2]

thanks,
jirka

[1] https://github.com/libbpf/usdt
[2] https://lore.kernel.org/bpf/20241118170458.c825bf255c2fb93f2e6a3519@kernel.org/T/#m20da8469e210880cae07f01783f4a51817ffbe4d

> 
> Thank you,
> 
> > 
> > It's based on tip/perf/core with bpf-next/master merged on top of
> > that together with uprobe session patchset.
> > 
> > thanks,
> > jirka
> > 
> > 
> > current:
> >         # ./bench -w2 -d5 -a  trig-usdt
> >         Setting up benchmark 'trig-usdt'...
> >         Benchmark 'trig-usdt' started.
> >         Iter   0 ( 46.982us): hits    4.893M/s (  4.893M/prod), drops    0.000M/s, total operations    4.893M/s
> >         Iter   1 ( -5.967us): hits    4.892M/s (  4.892M/prod), drops    0.000M/s, total operations    4.892M/s
> >         Iter   2 ( -2.771us): hits    4.899M/s (  4.899M/prod), drops    0.000M/s, total operations    4.899M/s
> >         Iter   3 (  1.286us): hits    4.889M/s (  4.889M/prod), drops    0.000M/s, total operations    4.889M/s
> >         Iter   4 ( -2.871us): hits    4.881M/s (  4.881M/prod), drops    0.000M/s, total operations    4.881M/s
> >         Iter   5 (  1.005us): hits    4.886M/s (  4.886M/prod), drops    0.000M/s, total operations    4.886M/s
> >         Iter   6 ( 11.626us): hits    4.906M/s (  4.906M/prod), drops    0.000M/s, total operations    4.906M/s
> >         Iter   7 ( -6.638us): hits    4.896M/s (  4.896M/prod), drops    0.000M/s, total operations    4.896M/s
> >         Summary: hits    4.893 +- 0.009M/s (  4.893M/prod), drops    0.000 +- 0.000M/s, total operations    4.893 +- 0.009M/s
> > 
> > optimized:
> >         # ./bench -w2 -d5 -a  trig-usdt
> >         Setting up benchmark 'trig-usdt'...
> >         Benchmark 'trig-usdt' started.
> >         Iter   0 ( 46.073us): hits    8.258M/s (  8.258M/prod), drops    0.000M/s, total operations    8.258M/s
> >         Iter   1 ( -5.752us): hits    8.264M/s (  8.264M/prod), drops    0.000M/s, total operations    8.264M/s
> >         Iter   2 ( -1.333us): hits    8.263M/s (  8.263M/prod), drops    0.000M/s, total operations    8.263M/s
> >         Iter   3 ( -2.996us): hits    8.265M/s (  8.265M/prod), drops    0.000M/s, total operations    8.265M/s
> >         Iter   4 ( -0.620us): hits    8.264M/s (  8.264M/prod), drops    0.000M/s, total operations    8.264M/s
> >         Iter   5 ( -2.624us): hits    8.236M/s (  8.236M/prod), drops    0.000M/s, total operations    8.236M/s
> >         Iter   6 ( -0.840us): hits    8.232M/s (  8.232M/prod), drops    0.000M/s, total operations    8.232M/s
> >         Iter   7 ( -1.783us): hits    8.235M/s (  8.235M/prod), drops    0.000M/s, total operations    8.235M/s
> >         Summary: hits    8.249 +- 0.016M/s (  8.249M/prod), drops    0.000 +- 0.000M/s, total operations    8.249 +- 0.016M/s
> > 
> > ---
> > Jiri Olsa (11):
> >       uprobes: Rename arch_uretprobe_trampoline function
> >       uprobes: Make copy_from_page global
> >       uprobes: Add len argument to uprobe_write_opcode
> >       uprobes: Add data argument to uprobe_write_opcode function
> >       uprobes: Add mapping for optimized uprobe trampolines
> >       uprobes: Add uprobe syscall to speed up uprobe
> >       uprobes/x86: Add support to optimize uprobes
> >       selftests/bpf: Use 5-byte nop for x86 usdt probes
> >       selftests/bpf: Add usdt trigger bench
> >       selftests/bpf: Add uprobe/usdt optimized test
> >       selftests/bpf: Add hit/attach/detach race optimized uprobe test
> > 
> >  arch/x86/entry/syscalls/syscall_64.tbl                    |   1 +
> >  arch/x86/include/asm/uprobes.h                            |   7 +++
> >  arch/x86/kernel/uprobes.c                                 | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/syscalls.h                                  |   2 +
> >  include/linux/uprobes.h                                   |  25 +++++++++-
> >  kernel/events/uprobes.c                                   | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
> >  kernel/fork.c                                             |   2 +
> >  kernel/sys_ni.c                                           |   1 +
> >  tools/testing/selftests/bpf/bench.c                       |   2 +
> >  tools/testing/selftests/bpf/benchs/bench_trigger.c        |  45 +++++++++++++++++
> >  tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c | 252 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/trigger_bench.c         |  10 +++-
> >  tools/testing/selftests/bpf/progs/uprobe_optimized.c      |  29 +++++++++++
> >  tools/testing/selftests/bpf/sdt.h                         |   9 +++-
> >  14 files changed, 768 insertions(+), 19 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_optimized.c
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

