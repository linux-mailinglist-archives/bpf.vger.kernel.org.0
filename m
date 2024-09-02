Return-Path: <bpf+bounces-38725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201A968CC2
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 19:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8D92827DF
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 17:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598A1C62BB;
	Mon,  2 Sep 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/bsOPx9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098551C62BC
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297490; cv=none; b=aiw7Ac61NkA4067WfFTY2vMjMCvuqp/B01H3W0L7cZx04DNQVgHRT3vmwRj7zkX+aTWIrGTkSY9NkvJz70P/mdmcc8nEORFZJVi0+eJ9CtuX2y71YxE1KyQiWZFFxNkCXBb83sd3MQFaNEpsLiuW8h34rfDM7pLj8RS2VtcmI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297490; c=relaxed/simple;
	bh=Yn2qNVL1K2RGGB5yCkphtWuo9hLKLKoBXb3pnSF4zlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYiXtzhU9GQtwcle1/YPAdSBFX03ThyHI4F7gHD/ObcYwRH208EzXcTB0plYTBpPO7+qUmJn/qFYfN/QJnGIhJCOb9FzJ/gy5J+lv/aMH2O/oEVsQln89Z1i+qNStH9QHPQrATOI/jwTscMdOQ0gF82+BfVYOEb1YbstiAdZFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/bsOPx9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725297486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyCBRkcqdmq4zfHjNffbspBxhsd+++HG8bzbtwWl0VY=;
	b=U/bsOPx9RPfY4yskHyUDxAPvlhTAhPAF9E5sld9LMilYZl1EL18oWKX5piM+cotq85yZZx
	Y1ObrQGTSkWArJm8+AC3bep3k41YnU4s5RwrnJwyUgn8CAEdcxRr2NbWNTQCwNx/ov3Tds
	3co7rEtPxFqa5SE6/4Hk79FG9kYUYbc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-lrxZqYMrOi6CwVFovZAGRw-1; Mon,
 02 Sep 2024 13:18:02 -0400
X-MC-Unique: lrxZqYMrOi6CwVFovZAGRw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 966DE19560A6;
	Mon,  2 Sep 2024 17:18:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.49])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E79B11955F1B;
	Mon,  2 Sep 2024 17:17:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  2 Sep 2024 19:17:51 +0200 (CEST)
Date: Mon, 2 Sep 2024 19:17:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tianyi Liu <i.pear@outlook.com>, jolsa@kernel.org,
	andrii.nakryiko@gmail.com
Cc: ajor@meta.com, albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240902171745.GC26532@redhat.com>
References: <20240830101209.GA24733@redhat.com>
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240901232652.GA12854@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901232652.GA12854@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 09/02, Oleg Nesterov wrote:
>
> And... I think that BPF has even more problems with filtering. Not sure,
> I'll try to write another test-case tomorrow.

See below. This test-case needs a one-liner patch at the end, but this is only
because I have no idea how to add BPF_EMIT_CALL(BPF_FUNC_trace_printk) into
"struct bpf_insn insns[]" correctly. Is there a simple-to-use user-space tool
which can translate 'bpf_trace_printk("Hello world\n", 13)' into bpf_insn[] ???

So. The CONFIG_BPF_EVENTS code in __uprobe_perf_func() assumes that it "owns"
tu->consumer and uprobe_perf_filter(), but this is not true in general.

test.c:
	#include <unistd.h>

	int func(int i)
	{
		return i;
	}

	int main(void)
	{
		int i;
		for (i = 0;; ++i) {
			sleep(1);
			func(i);
		}
		return 0;
	}

run_prog.c
	// cc -I./tools/include -I./tools/include/uapi -Wall
	#include "./include/generated/uapi/linux/version.h"
	#include <linux/perf_event.h>
	#include <linux/filter.h>
	#define _GNU_SOURCE
	#include <sys/syscall.h>
	#include <sys/ioctl.h>
	#include <assert.h>
	#include <unistd.h>
	#include <stdlib.h>

	int prog_load(void)
	{
		struct bpf_insn insns[] = {
			BPF_MOV64_IMM(BPF_REG_0, 0),
			BPF_EXIT_INSN(),
		};

		union bpf_attr attr = {
			.prog_type	= BPF_PROG_TYPE_KPROBE,
			.insns		= (unsigned long)insns,
			.insn_cnt	= sizeof(insns) / sizeof(insns[0]),
			.license	= (unsigned long)"GPL",
			.kern_version	= LINUX_VERSION_CODE, // unneeded
		};

		return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
	}

	void run_probe(int eid, int pid)
	{
		struct perf_event_attr attr = {
			.type	= PERF_TYPE_TRACEPOINT,
			.config	= eid,
			.size	= sizeof(struct perf_event_attr),
		};

		int fd = syscall(__NR_perf_event_open, &attr, pid, 0, -1, 0);
		assert(fd >= 0);

		int pfd = prog_load();
		assert(pfd >= 0);

		assert(ioctl(fd, PERF_EVENT_IOC_SET_BPF, pfd) == 0);
		assert(ioctl(fd, PERF_EVENT_IOC_ENABLE, 0) == 0);

		for (;;)
			pause();
	}

	int main(int argc, const char *argv[])
	{
		int eid = atoi(argv[1]);
		int pid = atoi(argv[2]);
		run_probe(eid, pid);
		return 0;
	}

Now,

	$ ./test &
	$ PID1=$!
	$ ./test &
	$ PID2=$!
	$ perf probe -x ./test -a func
	$ ./run_prog `cat /sys/kernel/debug/tracing/events/probe_test/func/id` $PID1 &

dmesg -c:
	trace_uprobe: BPF_FUNC: pid=50 ret=0
	trace_uprobe: BPF_FUNC: pid=50 ret=0
	trace_uprobe: BPF_FUNC: pid=50 ret=0
	trace_uprobe: BPF_FUNC: pid=50 ret=0
	...

So far so good. Now,

	$ perf record -e probe_test:func -p $PID2 -- sleep 10 &

This creates another PERF_TYPE_TRACEPOINT perf_event which shares
trace_uprobe/consumer/filter with the perf_event created by run_prog.

dmesg -c:
	trace_uprobe: BPF_FUNC: pid=51 ret=0
	trace_uprobe: BPF_FUNC: pid=50 ret=0
	trace_uprobe: BPF_FUNC: pid=51 ret=0
	trace_uprobe: BPF_FUNC: pid=50 ret=0
	...

until perf-record exits. and after that

	$ perf script

reports nothing.

So, in this case:

	- run_prog's bpf program is called when current->pid == $PID2, this patch
	  (or any other change in trace_uprobe.c) can't help.

	- run_prog's bpf program "steals" __uprobe_perf_func() from /usr/bin/perf

and to me this is yet another indication that we need some changes in the
bpf_prog_run_array_uprobe() paths, or even in the user-space bpftrace/whatever's
code.

And. Why the "if (bpf_prog_array_valid(call))" block in __uprobe_perf_func() returns?
Why this depends on "ret == 0" ??? I fail to understand this logic.

Oleg.

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1381,6 +1381,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 		u32 ret;
 
 		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
+		pr_crit("BPF_FUNC: pid=%d ret=%d\n", current->pid, ret);
 		if (!ret)
 			return;
 	}


