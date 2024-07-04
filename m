Return-Path: <bpf+bounces-33862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBAD9271FA
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0026EB20C2C
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 08:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777B1A4F0F;
	Thu,  4 Jul 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gE1uYFwn"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB075107A0;
	Thu,  4 Jul 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082737; cv=none; b=YjmuGu4H1Ka0NBX+ioQ8EfqBKCO7Yc/EcI1dJlHQtU5Woxc67u1h7Q1Ti4T86ko76X2SRbdDH9e8TdG/WLtrLWwSjD8wh8KHHopQt3l/HXpZHpAxk1OdagolhsXbKT5TNtxuATTfsOUg1rNhs0auc6L8lqwfvFq8/RYtBCEbwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082737; c=relaxed/simple;
	bh=42P6ixEL1/t0fNcYlCm/UnkNeBXltpyRarpLhm/27Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUDu86utP7vewXhpDWSVdJmNeXwtDxq9hWOjgXa1nEdLjDn64fI4B8IXQnx3vYPrIuClg+FmqFiFh+F4ysgtTix9vCPYkaIi9CgvneEoVbygWGGNC9PQ/IfdnMRGVYSoG8Hm5+iweWxo7X8iWCVC536HwN610C+FiBQFH+C+mpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gE1uYFwn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IApq68reoIapG8KugSynJUOaPB90tTvNFzIcvMXZOhA=; b=gE1uYFwnXyoI/NJJNvRZ15qHRM
	qP7WILc2ePpxx3GlfAfS3Lj9SOFnbI4LVY8+EYxxKQqtV7VIZj9yVbScKQn7A+zFje4ibIVH0nX6B
	0xsH9o5cKMOzuzqBlfxQOtE2UjkpC+x0RfiPE3JwumDQ4cmpTho0cT2N88eoXib0IprevlI9tRDjd
	zGK3m+dnQht9XQDx/0iiJdR+v41+/oUYBzjrRS12eq06YjFUwQ5ku3bPy9oK6lV5r4dnZ3H5oJ48R
	Pg/XPQ8lXAcalRPwUx+DggZ+AZAW8zHsKBdLjIGPAo6m+TNcjYHfqzbERl8xUrCg8MIlNJyoiNLlQ
	RInI6XfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPI5l-0000000ACcy-0RAA;
	Thu, 04 Jul 2024 08:45:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B31713003FF; Thu,  4 Jul 2024 10:45:24 +0200 (CEST)
Date: Thu, 4 Jul 2024 10:45:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240704084524.GC28838@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
 <20240703133608.GO11386@noisy.programming.kicks-ass.net>
 <CAEf4BzZQQJGrC+tCbrU90JNpXxH8-vBg_c5GzjS=FLZp0PfExA@mail.gmail.com>
 <20240704080348.GP11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704080348.GP11386@noisy.programming.kicks-ass.net>

On Thu, Jul 04, 2024 at 10:03:48AM +0200, Peter Zijlstra wrote:

> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c98e3b3386ba..4aafb4485be7 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1112,7 +1112,8 @@ static void __probe_event_disable(struct trace_probe *tp)
>  		if (!tu->inode)
>  			continue;
>  
> -		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
> +		uprobe_unregister(tu->inode, tu->offset, &tu->consumer,
> +				  list_is_last(trace_probe_probe_list(tp), &tu->tp.list) ? 0 : URF_NO_SYNC);
>  		tu->inode = NULL;
>  	}
>  }


Hmm, that continue clause might ruin things. Still easy enough to add
uprobe_unregister_sync() and simpy always pass URF_NO_SYNC.

I really don't see why we should make this more complicated than it
needs to be.

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 354cab634341..681741a51df3 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -115,7 +115,9 @@ extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+#define URF_NO_SYNC	0x01
+extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, unsigned int flags);
+extern void uprobe_unregister_sync(void);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -165,7 +167,7 @@ uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, boo
 	return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, unsigned int flags)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0b7574a54093..d09f7b942076 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1145,7 +1145,7 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
  * @offset: offset from the start of the file.
  * @uc: identify which probe if multiple probes are colocated.
  */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, unsigned int flags)
 {
 	scoped_guard (srcu, &uprobe_srcu) {
 		struct uprobe *uprobe = find_uprobe(inode, offset);
@@ -1157,10 +1157,17 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
 		mutex_unlock(&uprobe->register_mutex);
 	}
 
-	synchronize_srcu(&uprobe_srcu); // XXX amortize / batch
+	if (!(flags & URF_NO_SYNC))
+		synchronize_srcu(&uprobe_srcu);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
+void uprobe_unregister_sync(void)
+{
+	synchronize_srcu(&uprobe_srcu);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
+
 /*
  * __uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d1daeab1bbc1..1f6adabbb1e7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3181,9 +3181,10 @@ static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
 	u32 i;
 
 	for (i = 0; i < cnt; i++) {
-		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
-				  &uprobes[i].consumer);
+		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset, URF_NO_SYNC);
 	}
+	if (cnt > 0)
+		uprobe_unregister_sync();
 }
 
 static void bpf_uprobe_multi_link_release(struct bpf_link *link)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c98e3b3386ba..6b64470a1c5c 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1104,6 +1104,7 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 static void __probe_event_disable(struct trace_probe *tp)
 {
 	struct trace_uprobe *tu;
+	bool sync = false;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
 	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
@@ -1112,9 +1113,12 @@ static void __probe_event_disable(struct trace_probe *tp)
 		if (!tu->inode)
 			continue;
 
-		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+		uprobe_unregister(tu->inode, tu->offset, &tu->consumer, URF_NO_SYNC);
+		sync = true;
 		tu->inode = NULL;
 	}
+	if (sync)
+		uprobe_unregister_sync();
 }
 
 static int probe_event_enable(struct trace_event_call *call,

