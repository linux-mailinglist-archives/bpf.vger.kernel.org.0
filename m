Return-Path: <bpf+bounces-23270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E1986F45E
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 11:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE37228162C
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5AEB662;
	Sun,  3 Mar 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se4uLQ6s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2EBE49
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461246; cv=none; b=MgBUBW7nki8XlrD4tkTiUl6xeUK8N53PO+GcB+Sx9y0z2S0kXXx9bbph3NrMUuK94g5W/0mG99ID5gA4WgsQWsHic0XVQtHenp7OUGcnuXNT3s5iqmmXe+quNIdNEbeLX39L85qH5EaiFJ69fws6gGpiYbh7g20qbYsQWgT9e3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461246; c=relaxed/simple;
	bh=MnMEj67v7LeaRAhIWhmrFi++IN1oA+GQq8y3fhWK0HU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ky81uZp/ilsWqKREfPVLOkhq2B1gzdQiYahE47QCY+QVeMEajHmx8Jvw3iU4CLfBIu6FOR6x5xcb+bcA30TimBSzaFJP0aWvYU3f+4JzYW6KS7w2ELbrb5zT4IPunglvxrzf4+qmqyd6yWPzQ0hWZrocSHJfFh+ZfzPSwPp/0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se4uLQ6s; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a446b5a08f0so401235366b.1
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 02:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709461243; x=1710066043; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uv9zV4JSwXxAKed+XbbXLf1OcOlYwquYhC/8u3xg+Nw=;
        b=Se4uLQ6sft26PCyIIsNB1zy8MMsF735xYvY1JPW5h3xLro9ZVaKUKlrOoo1ilfpPhE
         pAZKCK6QLUU8jCEMpqmPa4T9vrKXIhaon1QWhiuPlTQvz5/sZrB/VdtkPxq02WLUN8t4
         XrnM1cEFEZiMB1Y9oFklq9s2Q7MsuJ1eBWM+YupzU2TkkQTk8Vwcqlmge+YTto31A+R1
         /L7U+8pGMJTtnC+XCjXcc0nuE38KT6syBFIb4+a6vtHePtZip+y7IDNvPPHoUKcSKvGe
         7WMRyKHyc4H9o4t5hazy0a53aMhWmizG9WCecqcAPRhwraLjuVvctcEqKjHRsPRtreud
         PGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461243; x=1710066043;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv9zV4JSwXxAKed+XbbXLf1OcOlYwquYhC/8u3xg+Nw=;
        b=Xy5+Tml5mPwWUFk0pOqjkC2TpY09RkUMkH3dX7WXCRXQLZN20j/2PXG+9SC5wH5UxS
         0eZvQeG8qf0ohpk97+tZtFNTsmO11ZH0AenJAcXzp8fbKQ5/e9iLHhde/sCo8rK5+196
         AQnloUUNJjz1ZW91cz/bsFKtW42cFn8be69KtioqgO8mHrJ1XeIWy+gMOWIHK9L9yzTQ
         1dT9I8uA9lhKG4sYI0CNaN6IHAtgULU4gcLdHVzt2O8DBoy4Zzjr+Ks4pLttVScvwlhM
         l0vlFLyr8PzZkdG0Pct2G+lRqnvOknIjZHPu/vkjw1ItZdVmo5QvJT+HOYyhoJ1hvktf
         6Y0w==
X-Forwarded-Encrypted: i=1; AJvYcCU1GlqPHASAdvrdUAFksh+OEfZdWwyje9SRNfFWMd3tT1Me6JxWZF8NnLC/y8WqFAB4cGduAJTudqZtOxAGqwV7YAUb
X-Gm-Message-State: AOJu0Yxq5NnpR6kJ6nc98ihNjDLk3skifNksiZbijG8Akpi068etyXxd
	dFPrQtBWl7jn1mK4szQVTBKTB8zhNIeL3Vc0z+EsfWKVZurxqJXLaVDucR/K
X-Google-Smtp-Source: AGHT+IEEpkr9KPvytiVRVzZXA2BKprmkYVKkWz2gCz5L1Zg29n5cyMGr2nERrkGvfYRVLnzgqTX1EQ==
X-Received: by 2002:a17:906:2dc7:b0:a44:1db8:d37a with SMTP id h7-20020a1709062dc700b00a441db8d37amr5088818eji.32.1709461243171;
        Sun, 03 Mar 2024 02:20:43 -0800 (PST)
Received: from krava ([83.240.61.14])
        by smtp.gmail.com with ESMTPSA id g7-20020a170906198700b00a4503a78dd5sm839131ejd.17.2024.03.03.02.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:20:42 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 3 Mar 2024 11:20:39 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, yunwei356@gmail.com,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <ZeRO9_IiLSy9D7jQ@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>

On Fri, Mar 01, 2024 at 09:26:57AM -0800, Andrii Nakryiko wrote:
> On Fri, Mar 1, 2024 at 9:01 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 1, 2024 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > > > On Thu, Feb 29, 2024 at 6:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > One of uprobe pain points is having slow execution that involves
> > > > > two traps in worst case scenario or single trap if the original
> > > > > instruction can be emulated. For return uprobes there's one extra
> > > > > trap on top of that.
> > > > >
> > > > > My current idea on how to make this faster is to follow the optimized
> > > > > kprobes and replace the normal uprobe trap instruction with jump to
> > > > > user space trampoline that:
> > > > >
> > > > >   - executes syscall to call uprobe consumers callbacks
> > > >
> > > > Did you get a chance to measure relative performance of syscall vs
> > > > int3 interrupt handling? If not, do you think you'll be able to get
> > > > some numbers by the time the conference starts? This should inform the
> > > > decision whether it even makes sense to go through all the trouble.
> > >
> > > right, will do that
> >
> > I believe Yusheng measured syscall vs uprobe performance
> > difference during LPC. iirc it was something like 3x.
> 
> Do you have a link to slides? Was it actual uprobe vs just some fast
> syscall (not doing BPF program execution) comparison? Or comparing the
> performance of int3 handling vs equivalent syscall handling.
> 
> I suspect it's the former, and so probably not that representative.
> I'm curious about the performance of going
> userspace->kernel->userspace through int3 vs syscall (all other things
> being equal).

I have a simple test [1] comparing:
  - uprobe with 2 traps
  - uprobe with 1 trap
  - syscall executing uprobe

the syscall takes uprobe address as argument, finds the uprobe and executes
its consumers, which should be comparable to what the trampoline will do

test does same amount of loops triggering each uprobe type and measures
the time it took

  # ./test_progs -t uprobe_syscall_bench -v
  bpf_testmod.ko is already unloaded.
  Loading bpf_testmod.ko...
  Successfully loaded bpf_testmod.ko.
  test_bench_1:PASS:uprobe_bench__open_and_load 0 nsec
  test_bench_1:PASS:uprobe_bench__attach 0 nsec
  test_bench_1:PASS:uprobe1_cnt 0 nsec
  test_bench_1:PASS:syscalls_uprobe1_cnt 0 nsec
  test_bench_1:PASS:uprobe2_cnt 0 nsec
  test_bench_1: uprobes (1 trap) in  36.439s
  test_bench_1: uprobes (2 trap) in  91.960s
  test_bench_1: syscalls         in  17.872s
  #395/1   uprobe_syscall_bench/bench_1:OK
  #395     uprobe_syscall_bench:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

syscall uprobe execution seems to be ~2x faster than 1 trap uprobe
and ~5x faster than 2 traps uprobe

jirka


[1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=uprobe_syscall_bench

> 
> > Certainly necessary to have a benchmark.
> > selftests/bpf/bench has one for uprobe.
> > Probably should extend with sys_bpf.
> >
> > Regarding:
> > > replace the normal uprobe trap instruction with jump to
> > user space trampoline
> >
> > it should probably be a call to trampoline instead of a jump.
> > Unless you plan to generate a different trampoline for every location ?
> >
> > Also how would you pick a space for a trampoline in the target process ?
> > Analyze /proc/pid/maps and look for gaps in executable sections?
> 
> kernel already does that for uretprobes, it adds a new "[uprobes]"
> memory mapping, so this part is already implemented
> 
> >
> > We can start simple with a USDT that uses nop5 instead of nop1
> > and explicit single trampoline for all USDT locations
> > that saves all (callee and caller saved) registers and
> > then does sys_bpf with a new cmd.
> >
> > To replace nop5 with a call to trampoline we can use text_poke_bp
> > approach: replace 1st byte with int3, replace 2-5 with target addr,
> > replace 1st byte to make an actual call insn.
> >
> > Once patched there will be no simulation of insns or kernel traps.
> > Just normal user code that calls into trampoline, that calls sys_bpf,
> > and returns back.

