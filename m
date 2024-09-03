Return-Path: <bpf+bounces-38778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F4896A0BD
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677931F229BD
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E63B80C02;
	Tue,  3 Sep 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AErLq2qr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7EB1F937;
	Tue,  3 Sep 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374038; cv=none; b=CBNW9uxCu/PISSKslRUJ8KF6HQtAz0NxmGluR/BKfPBkS8GroOykMw//fnmXUqFnzHgN9XRVUK9FcCQGCrdy8lIB3wCWzs2VA1OXrugUz3eh+GstigbOprnJO7VokdSmzMmvkI92LlpBHLJslFDg8631jJAga69mQOpGttIO5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374038; c=relaxed/simple;
	bh=51yKYnAUW7oklod6dtzZQ26I19gDaZakx/DoxivsNUQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3VNEUMir+pO0L/YjPCwVlEM1nJRrJfmapc8LVCcA85mqSa2IspeY340Yl9BlU/ZQsE7d9Nb1kVZ/KPPQCX4k4huXpH06+lqkK0cNorAYP2kBuNFSXMhW//JVHm8ISzmIORWc2X1QnIsvf9zhQpm8Pc1Jb+aQZZ09YHAghh2bMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AErLq2qr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42c2e50ec6aso18914975e9.0;
        Tue, 03 Sep 2024 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725374035; x=1725978835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnzRvcPxcU9HJutxpjUBFOS12M76EnYdbYmii/N2uto=;
        b=AErLq2qrDv1yhtftYDcKeE4Tmhq/8PrOS+upjWnkbqTBnymj6f3tsXlkAD4vWnYtHN
         CyChajty4GPI3Eg96L84G2Z7sbm+EHvswusPmkZN30SKQlQP6iuKMxjNcClghXvUpgRx
         Q6v16D5SVxPhr6X6bDRudVk6DoVFh5XrXE24C8nIF8xGebVmcB9EBtLxJUade1y2iDoE
         I9dsEmenPSTH3KkiafHCT+lVeePdegn1ElbzAj34Lsq19tFmtdQ4H7cMu4+N2gGux98M
         dbodZ4bEBxoBCeROMM64tXdDZ01+bgl0vvBmOKzX6IXKYY9Mt/0KbJsUUbRQyh459D+x
         4lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725374035; x=1725978835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnzRvcPxcU9HJutxpjUBFOS12M76EnYdbYmii/N2uto=;
        b=X5vofpojgdlcuLx4xUwobxyvCnS3GxuTyxZCSPFsoqS1WZs64lew8I+QyFXHpu3YzY
         r9rvrzd1zw6ibdJRyeoNFo7gUFGGBtRZtdXDHMVKZWLBi6VOeguCMSVs+zXa0rA1f3ne
         J1l/ODRsizalsiVdAl2onuAQ/Gfdk1AZBPOefelGTYnuzEe+aB4EZWH129V9Pfyhhqv2
         rdGjJDnoV+RacyZgMhjT61HgLS2R2Nh+eUsThcPUIWYziR1PD77ekxovXhMtu1zVm4L9
         BSNp+opno0t1j6hTv6g3y50807JcYnOkz82Ci3GZ9TeU+Q21bEROIz/MdwysP0Ay0J9V
         zJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZD5Wo1y6Krsgsk3kNCe72PvYhM6LIdmgCNfo41CauIkvqjFBKG2o9FkGNBj3w792A0pY=@vger.kernel.org, AJvYcCVEtloOeRdRv/hZTWm93m97cIUGHEpAJlwTTsMFBxYd/EgKyZTYGyddI0xxdAcsyGvSqb4TyK1j/BTedfqfK8FZv8cQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVX3GGZgkZ4u6GixwoMu3Gw6GzK/ueH6CYAqAXfHlDNoK7qcF
	zxxNCQaCKkKt/4N3WywAj7XpqWfbYlIqVYCPVgJkMrIrXqTSHdy+
X-Google-Smtp-Source: AGHT+IFJ4UEX7VZbZMjHnIz5fla2uLp0LDOKqYaUgkCv/sVxN37oK9l1TNTIjInZdzY+b+G10Na2MA==
X-Received: by 2002:a05:600c:4450:b0:426:5fa7:b495 with SMTP id 5b1f17b1804b1-42bbb69bc2fmr92127195e9.15.1725374034251;
        Tue, 03 Sep 2024 07:33:54 -0700 (PDT)
Received: from krava ([87.202.122.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm174546095e9.17.2024.09.03.07.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:33:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Sep 2024 17:33:50 +0300
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	ajor@meta.com, albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <ZtceTuu8E4hHZr2P@krava>
References: <20240830101209.GA24733@redhat.com>
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240901232652.GA12854@redhat.com>
 <20240902171745.GC26532@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902171745.GC26532@redhat.com>

On Mon, Sep 02, 2024 at 07:17:45PM +0200, Oleg Nesterov wrote:
> On 09/02, Oleg Nesterov wrote:
> >
> > And... I think that BPF has even more problems with filtering. Not sure,
> > I'll try to write another test-case tomorrow.
> 
> See below. This test-case needs a one-liner patch at the end, but this is only
> because I have no idea how to add BPF_EMIT_CALL(BPF_FUNC_trace_printk) into
> "struct bpf_insn insns[]" correctly. Is there a simple-to-use user-space tool
> which can translate 'bpf_trace_printk("Hello world\n", 13)' into bpf_insn[] ???
> 
> So. The CONFIG_BPF_EVENTS code in __uprobe_perf_func() assumes that it "owns"
> tu->consumer and uprobe_perf_filter(), but this is not true in general.
> 
> test.c:
> 	#include <unistd.h>
> 
> 	int func(int i)
> 	{
> 		return i;
> 	}
> 
> 	int main(void)
> 	{
> 		int i;
> 		for (i = 0;; ++i) {
> 			sleep(1);
> 			func(i);
> 		}
> 		return 0;
> 	}
> 
> run_prog.c
> 	// cc -I./tools/include -I./tools/include/uapi -Wall
> 	#include "./include/generated/uapi/linux/version.h"
> 	#include <linux/perf_event.h>
> 	#include <linux/filter.h>
> 	#define _GNU_SOURCE
> 	#include <sys/syscall.h>
> 	#include <sys/ioctl.h>
> 	#include <assert.h>
> 	#include <unistd.h>
> 	#include <stdlib.h>
> 
> 	int prog_load(void)
> 	{
> 		struct bpf_insn insns[] = {
> 			BPF_MOV64_IMM(BPF_REG_0, 0),
> 			BPF_EXIT_INSN(),
> 		};
> 
> 		union bpf_attr attr = {
> 			.prog_type	= BPF_PROG_TYPE_KPROBE,
> 			.insns		= (unsigned long)insns,
> 			.insn_cnt	= sizeof(insns) / sizeof(insns[0]),
> 			.license	= (unsigned long)"GPL",
> 			.kern_version	= LINUX_VERSION_CODE, // unneeded
> 		};
> 
> 		return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
> 	}
> 
> 	void run_probe(int eid, int pid)
> 	{
> 		struct perf_event_attr attr = {
> 			.type	= PERF_TYPE_TRACEPOINT,
> 			.config	= eid,
> 			.size	= sizeof(struct perf_event_attr),
> 		};
> 
> 		int fd = syscall(__NR_perf_event_open, &attr, pid, 0, -1, 0);
> 		assert(fd >= 0);
> 
> 		int pfd = prog_load();
> 		assert(pfd >= 0);
> 
> 		assert(ioctl(fd, PERF_EVENT_IOC_SET_BPF, pfd) == 0);
> 		assert(ioctl(fd, PERF_EVENT_IOC_ENABLE, 0) == 0);
> 
> 		for (;;)
> 			pause();
> 	}
> 
> 	int main(int argc, const char *argv[])
> 	{
> 		int eid = atoi(argv[1]);
> 		int pid = atoi(argv[2]);
> 		run_probe(eid, pid);
> 		return 0;
> 	}
> 
> Now,
> 
> 	$ ./test &
> 	$ PID1=$!
> 	$ ./test &
> 	$ PID2=$!
> 	$ perf probe -x ./test -a func
> 	$ ./run_prog `cat /sys/kernel/debug/tracing/events/probe_test/func/id` $PID1 &
> 
> dmesg -c:
> 	trace_uprobe: BPF_FUNC: pid=50 ret=0
> 	trace_uprobe: BPF_FUNC: pid=50 ret=0
> 	trace_uprobe: BPF_FUNC: pid=50 ret=0
> 	trace_uprobe: BPF_FUNC: pid=50 ret=0
> 	...
> 
> So far so good. Now,
> 
> 	$ perf record -e probe_test:func -p $PID2 -- sleep 10 &
> 
> This creates another PERF_TYPE_TRACEPOINT perf_event which shares
> trace_uprobe/consumer/filter with the perf_event created by run_prog.
> 
> dmesg -c:
> 	trace_uprobe: BPF_FUNC: pid=51 ret=0
> 	trace_uprobe: BPF_FUNC: pid=50 ret=0
> 	trace_uprobe: BPF_FUNC: pid=51 ret=0
> 	trace_uprobe: BPF_FUNC: pid=50 ret=0
> 	...
> 
> until perf-record exits. and after that
> 
> 	$ perf script
> 
> reports nothing.
> 
> So, in this case:
> 
> 	- run_prog's bpf program is called when current->pid == $PID2, this patch
> 	  (or any other change in trace_uprobe.c) can't help.
> 
> 	- run_prog's bpf program "steals" __uprobe_perf_func() from /usr/bin/perf

ok, there's just one call instance (struct trace_event_call) shared
with all the uprobe tracepoints, so if there's bpf program attached
to any uprobe tracepoint, it will not continue and send the perf event
for any other uprobe tracepoint (without the bpf program attached)

I think there might be similar issue with tracepoints and kprobes

> 
> and to me this is yet another indication that we need some changes in the
> bpf_prog_run_array_uprobe() paths, or even in the user-space bpftrace/whatever's
> code.
> 
> And. Why the "if (bpf_prog_array_valid(call))" block in __uprobe_perf_func() returns?
> Why this depends on "ret == 0" ??? I fail to understand this logic.

I'd think the intention was that if there's bpf program we don't emit
the perf event.. and we never thought about having them (event with bpf
program and standard perf event) co-existing together

problem is that the perf event pid filtering is implemented through the
call->perf_events list 

jirka

