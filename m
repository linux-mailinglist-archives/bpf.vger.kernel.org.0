Return-Path: <bpf+bounces-38411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F62A9649DF
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6A5B269C4
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8D91B2505;
	Thu, 29 Aug 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FacFhs1U"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922C1487F1
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944855; cv=none; b=bzzIA2EXFSNxg/HOFPGbMFL06yKIaCUIsonw9T7apPGhQERFz3v5cb5rYTuFtJ8rTRn2tKY/u/49Qnd6fcWMdSJp1aOMeG9MmcpDbqAtFYlAe814N4To4q6zzQa4oEN5tqtxYjwuLZsKYRtLiaOg7p0ThrgsqNYVKRkpqjLSrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944855; c=relaxed/simple;
	bh=VzvFm5X4E+ZuLcyLJfznBhONfOhsAxOWG2f9QQsKMfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1aLT+m1YIMAfgATTzZmh7yumYCdPbNKQt4x//gp7JNwn1c7Ne/BBX7fcxiTnHUgUkyZajSnbSW2/u10y14k4obfKjNKpGOYppyT63+C9A16PTP2HYOu9GTgsj41b3urvKb9aAtxQG6xG8L2lnS+YeqISQcNNvygfqScAuVG3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FacFhs1U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/3P26cuv3TUVRRp+TSC+oGfXdDo0J9OUwaTJoFEzis=;
	b=FacFhs1U8EEyqlug4mEAnOP8J/JJISqzoTc6k3G0hDuy36+1wHaGsuCdAtKutfzTmSJHGC
	NJlwoEtZtzKn5AC+eEQJM+GjSWKr7rofqaFwgrwDEY9CyAQLOnKmi+Yr6/B8sUbXL+J9La
	5HPftlaIjOCx6Z0CY2TFoFGlw695joE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-dkgkyYAmOXmJ_Lh1aUFgDQ-1; Thu,
 29 Aug 2024 11:20:49 -0400
X-MC-Unique: dkgkyYAmOXmJ_Lh1aUFgDQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 060B31955EB3;
	Thu, 29 Aug 2024 15:20:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.139])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D71973001FC3;
	Thu, 29 Aug 2024 15:20:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 29 Aug 2024 17:20:38 +0200 (CEST)
Date: Thu, 29 Aug 2024 17:20:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Tianyi Liu <i.pear@outlook.com>, andrii.nakryiko@gmail.com,
	mhiramat@kernel.org, ajor@meta.com, albancrequy@linux.microsoft.com,
	bpf@vger.kernel.org, flaniel@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org, linux@jordanrome.com,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <20240829152032.GA23996@redhat.com>
References: <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <ZsyHrhG9Q5BpZ1ae@krava>
 <20240826212552.GB30765@redhat.com>
 <Zsz7SPp71jPlH4MS@krava>
 <20240826222938.GC30765@redhat.com>
 <Zs3PdV6nqed1jWC2@krava>
 <20240827201926.GA15197@redhat.com>
 <Zs8N-xP4jlPK2yjE@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8N-xP4jlPK2yjE@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/28, Jiri Olsa wrote:
>
> On Tue, Aug 27, 2024 at 10:19:26PM +0200, Oleg Nesterov wrote:
> > Hmm. Really? In this case these 2 different consumers will have the different
> > trace_event_call's, so
> >
> > 	// consumer for task 1019
> > 	uretprobe_dispatcher
> > 	  uretprobe_perf_func
> > 	    __uprobe_perf_func
> > 	      perf_tp_event
> >
> > won't store the event because this_cpu_ptr(call->perf_events) should be
> > hlist_empty() on this CPU, the perf_event for task 1019 wasn't scheduled in
> > on this CPU...
>
> I'll double check on that,

Yes, please.

> but because there's no filter for uretprobe
> I think it will be stored under 1018 event
...
> I'm working on bpf selftests for above (uprobe and uprobe_multi paths)

Meanwhile, I decided to try to test this case too ;)

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

run_probe.c:

	#include "./include/uapi/linux/perf_event.h"
	#define _GNU_SOURCE
	#include <sys/syscall.h>
	#include <sys/ioctl.h>
	#include <assert.h>
	#include <unistd.h>
	#include <stdlib.h>
	#include <stdio.h>

	// cat /sys/bus/event_source/devices/uprobe/type
	#define UPROBE_TYPE	9

	void run_probe(const char *file, unsigned offset, int pid)
	{
		struct perf_event_attr attr = {
			.type		= UPROBE_TYPE,
			.config		= 1, // ret-probe
			.uprobe_path	= (unsigned long)file,
			.probe_offset	= offset,
			.size		= sizeof(struct perf_event_attr),
		};

		int fd = syscall(__NR_perf_event_open, &attr, pid, 0, -1, 0);
		assert(fd >= 0);

		assert(ioctl(fd, PERF_EVENT_IOC_ENABLE, 0) == 0);

		for (;;)
			pause();
	}

	int main(int argc, const char *argv[])
	{
		int pid = atoi(argv[1]);
		run_probe("./test", 0x536, pid);
		return 0;
	}

Now, with the kernel patch below applied, I do

	$ ./test &
	$ PID1=$!
	$ ./test &
	$ PID2=$!

	$ ./run_probe $PID1 &
	$ ./run_probe $PID2 &

and the kernel prints:

	CHAIN
	trace_uprobe: HANDLER pid=46 consumers_target=46 stored=1
	trace_uprobe: HANDLER pid=46 consumers_target=45 stored=0
	CHAIN
	trace_uprobe: HANDLER pid=45 consumers_target=46 stored=0
	trace_uprobe: HANDLER pid=45 consumers_target=45 stored=1
	CHAIN
	trace_uprobe: HANDLER pid=46 consumers_target=46 stored=1
	trace_uprobe: HANDLER pid=46 consumers_target=45 stored=0
	CHAIN
	trace_uprobe: HANDLER pid=45 consumers_target=46 stored=0
	trace_uprobe: HANDLER pid=45 consumers_target=45 stored=1
	CHAIN
	trace_uprobe: HANDLER pid=46 consumers_target=46 stored=1
	trace_uprobe: HANDLER pid=46 consumers_target=45 stored=0
	CHAIN
	trace_uprobe: HANDLER pid=45 consumers_target=46 stored=0
	trace_uprobe: HANDLER pid=45 consumers_target=45 stored=1
	CHAIN
	trace_uprobe: HANDLER pid=46 consumers_target=46 stored=1
	trace_uprobe: HANDLER pid=46 consumers_target=45 stored=0
	CHAIN
	trace_uprobe: HANDLER pid=45 consumers_target=46 stored=0
	trace_uprobe: HANDLER pid=45 consumers_target=45 stored=1

and so on.

As you can see, perf_trace_buf_submit/etc is never called for the "unfiltered"
consumer, so I still think that perf is fine wrt filtering. But I can be easily
wrong, please check.

Oleg.


diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index acc73c1bc54c..14aa92a78d6d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2150,6 +2150,8 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
 	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
 
+	pr_crit("CHAIN\n");
+
 	rcu_read_lock_trace();
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		if (uc->ret_handler)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f7443e996b1b..e4eaa0363742 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1364,7 +1364,7 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc, struct mm_struct *mm)
 	return ret;
 }
 
-static void __uprobe_perf_func(struct trace_uprobe *tu,
+static int __uprobe_perf_func(struct trace_uprobe *tu,
 			       unsigned long func, struct pt_regs *regs,
 			       struct uprobe_cpu_buffer **ucbp)
 {
@@ -1375,6 +1375,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 	void *data;
 	int size, esize;
 	int rctx;
+	int ret = 0;
 
 #ifdef CONFIG_BPF_EVENTS
 	if (bpf_prog_array_valid(call)) {
@@ -1382,7 +1383,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
 		if (!ret)
-			return;
+			return -1;
 	}
 #endif /* CONFIG_BPF_EVENTS */
 
@@ -1392,12 +1393,13 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 	size = esize + ucb->dsize;
 	size = ALIGN(size + sizeof(u32), sizeof(u64)) - sizeof(u32);
 	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE, "profile buffer not large enough"))
-		return;
+		return -1;
 
 	preempt_disable();
 	head = this_cpu_ptr(call->perf_events);
 	if (hlist_empty(head))
 		goto out;
+	ret = 1;
 
 	entry = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!entry)
@@ -1421,6 +1423,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 			      head, NULL);
  out:
 	preempt_enable();
+	return ret;
 }
 
 /* uprobe profile handler */
@@ -1439,7 +1442,15 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 				struct pt_regs *regs,
 				struct uprobe_cpu_buffer **ucbp)
 {
-	__uprobe_perf_func(tu, func, regs, ucbp);
+	struct trace_uprobe_filter *filter = tu->tp.event->filter;
+	struct perf_event *event = list_first_entry(&filter->perf_events,
+					struct perf_event, hw.tp_list);
+
+	int r = __uprobe_perf_func(tu, func, regs, ucbp);
+
+	pr_crit("HANDLER pid=%d consumers_target=%d stored=%d\n",
+		current->pid, event->hw.target ? event->hw.target->pid : -1, r);
+
 }
 
 int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,


