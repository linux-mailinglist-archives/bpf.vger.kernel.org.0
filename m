Return-Path: <bpf+bounces-33859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466F892712D
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDEF1B239D4
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD041A38F2;
	Thu,  4 Jul 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ixZyUk/0"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7319DF4A;
	Thu,  4 Jul 2024 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080237; cv=none; b=L6tIbouynOnloTNxtWT4JnhLl8jP7KMGczRZ3mZc9whwJF0k6QUFErZANqRfRmzS82Qy5v3MMPxSetwgpKrNG/KQV0Mktlqq8BZJRijLCvV4uSCPN7IcOp3w1fVvduyjrth7wL+Dokc6Ft+xZLTs54MG2KQue5Dz0fR+ntUO5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080237; c=relaxed/simple;
	bh=aDXIoP7Qs12jneertwpAFgLP48rHuOyLUROrrqS1EyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBFsiaiV58VJ+C2/hDrSg6qcPP+Fp/48X7BVyQY2c6An1mEfxoUeDErp6tx3IyshcoXtY4nigDkskToxCRdlY1mSif4xcgqtWluOJxghTQknXTV9sAooQ3N5yJI0zjAPw5bBV7daNqqh6CaMeME8wNOe3D4si/cRLoFXcMhTFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ixZyUk/0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MAAslofSIU4T+suArmk0tqr6lMI/BMFkYGLdd/CxpD4=; b=ixZyUk/0xaMLNkaPkhYzRkC4Ra
	oKbTHlYjTGM5weGvibTXBbrVUJuO7kxbHzpz6v1o+96YdpFFmafYiDGSXDQk2pV6qXtzl2W2nvnHM
	hlmbmBFFeBbQ9jddPcIseCHBB7bmElFT0UDfb3Tj/pDi7oCiJH99hC2D0twK52r4atAjwIHNKfVSI
	an2pV54yl7etNI+2RavhNX3jSqX9RtqEFToASc7vu3k2tWP24hKF+WIA0w4+2RGeZgud2oXlMxJWc
	FmlIZlz35L4YnBp1Ypkm1GOI9mB1CMXCNt+QXvprFaQ8BobGATvLQWykyju737YsPSGRYa5jQ0inY
	6JOZjwNw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPHRU-00000002dFS-2wQY;
	Thu, 04 Jul 2024 08:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5651B3003FF; Thu,  4 Jul 2024 10:03:48 +0200 (CEST)
Date: Thu, 4 Jul 2024 10:03:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, clm@meta.com
Subject: Re: [PATCH v2 04/12] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240704080348.GP11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240701223935.3783951-5-andrii@kernel.org>
 <20240703133608.GO11386@noisy.programming.kicks-ass.net>
 <CAEf4BzZQQJGrC+tCbrU90JNpXxH8-vBg_c5GzjS=FLZp0PfExA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZQQJGrC+tCbrU90JNpXxH8-vBg_c5GzjS=FLZp0PfExA@mail.gmail.com>

On Wed, Jul 03, 2024 at 01:47:23PM -0700, Andrii Nakryiko wrote:
> Your innocuous "// XXX amortize / batch" comment below is *the major
> point of this patch set*. Try to appreciate that. It's not a small
> todo, it took this entire patch set to allow for that.

Tada!

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 354cab634341..c9c9ec87ab9a 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -115,7 +115,8 @@ extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+#define URF_NO_SYNC	0x01
+extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, unsigned int flags);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -165,7 +166,7 @@ uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, boo
 	return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, unsigned int flags)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0b7574a54093..1f4151c518ed 100644
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
@@ -1157,7 +1157,8 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
 		mutex_unlock(&uprobe->register_mutex);
 	}
 
-	synchronize_srcu(&uprobe_srcu); // XXX amortize / batch
+	if (!(flags & URF_NO_SYNC))
+		synchronize_srcu(&uprobe_srcu);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d1daeab1bbc1..950b5241244a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3182,7 +3182,7 @@ static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
 
 	for (i = 0; i < cnt; i++) {
 		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
-				  &uprobes[i].consumer);
+				  &uprobes[i].consumer, i != cnt-1 ? URF_NO_SYNC : 0);
 	}
 }
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c98e3b3386ba..4aafb4485be7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1112,7 +1112,8 @@ static void __probe_event_disable(struct trace_probe *tp)
 		if (!tu->inode)
 			continue;
 
-		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+		uprobe_unregister(tu->inode, tu->offset, &tu->consumer,
+				  list_is_last(trace_probe_probe_list(tp), &tu->tp.list) ? 0 : URF_NO_SYNC);
 		tu->inode = NULL;
 	}
 }

