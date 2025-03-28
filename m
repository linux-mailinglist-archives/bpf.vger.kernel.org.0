Return-Path: <bpf+bounces-54867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8894A74F9A
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D59516A3BA
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210AA1DD0D5;
	Fri, 28 Mar 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fc0a0YrG"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971014A0BC
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183615; cv=none; b=MUMcUv8aZsoRnAk/1Aei4cfk8ZNu3vfzmXJFrgpEMERICCZteRJCEoBjaCHG7X0W6NznBfzgrqjtdFtXL3UY5fAkznX4MvJ2QyXh+Z3UNMRCb6PXXGN0U9Pfy6bHxsHLd2zToybLGGuRhNKQUX50LaHJ0f+DJuiZ4FNDMmxMcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183615; c=relaxed/simple;
	bh=hvKQWsor6oHR3PVvIDBycWw/wVt3mhgvGoOLKV6e+eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TS2hkR/zlm1D/O23bOswFXtTpe3UH+9BPZf7UnS0mJpKbqL495+la+73MFj+wk39iz4sph4JOBrjjpKp6We8rd30/0M0JGslshoGoKhTXNfpRn+VovG18sHrinix3q0uXWSAKk84s8/dDy+U0Q8KqnlkAjIGhAwe/DPIF6fWWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fc0a0YrG; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743183610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c9tRFmmDUR2CkOjf+6kZ9skNDlIoAYtoIjd2XfE+zUg=;
	b=fc0a0YrG7npJnrbcI5kbJOpKzoIQ3jNzf2EeeU62yLtT7Yox2R1xOZ9WMFI7/ZXbN66hG+
	EQACcHkW8XVGVsG5//DeuqwZ4nTXaZsUzUpUZABbupQ++Mfmx86QeDE+STnnjcaBt5a61s
	eua+mgz63BLpqQkiDQIP4JpM4Obxr0M=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: alan.maguire@oracle.com,
	domenico.andreoli@linux.com,
	acme@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH dwarves] dwarf_loader: fix termination on BTF encoding error
Date: Fri, 28 Mar 2025 10:40:03 -0700
Message-ID: <20250328174003.3945581-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When BTF encoding thread aborts because of an error, dwarf loader
worker threads get stuck in cus_queue__enqdeq_job() at:

    pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue.mutex);

To avoid this, introduce an abort flag into cus_processing_queue, and
atomically check for it in the deq loop. The flag is only set in case
of a worker thread exiting on error. Make sure to pthread_cond_signal
to the waiting threads to let them exit too.

In cus__process_file fix the check of an error returned from
dwfl_getmodules: it may return a positive number when a
callback (cus__process_dwflmod in our case) returns an error.

Link: https://lore.kernel.org/dwarves/Z-JzFrXaopQCYd6h@localhost/

Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 dwarf_loader.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 84122d0..e1ba7bc 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3459,6 +3459,7 @@ static struct {
 	 */
 	uint32_t next_cu_id;
 	struct list_head jobs;
+	bool abort;
 } cus_processing_queue;
 
 enum job_type {
@@ -3479,6 +3480,7 @@ static void cus_queue__init(void)
 	pthread_cond_init(&cus_processing_queue.job_added, NULL);
 	INIT_LIST_HEAD(&cus_processing_queue.jobs);
 	cus_processing_queue.next_cu_id = 0;
+	cus_processing_queue.abort = false;
 }
 
 static void cus_queue__destroy(void)
@@ -3535,8 +3537,9 @@ static struct cu_processing_job *cus_queue__enqdeq_job(struct cu_processing_job
 		pthread_cond_signal(&cus_processing_queue.job_added);
 	}
 	for (;;) {
+		bool abort = __atomic_load_n(&cus_processing_queue.abort, __ATOMIC_SEQ_CST);
 		job = cus_queue__try_dequeue();
-		if (job)
+		if (job || abort)
 			break;
 		/* No jobs or only steals out of order */
 		pthread_cond_wait(&cus_processing_queue.job_added, &cus_processing_queue.mutex);
@@ -3653,6 +3656,9 @@ static void *dwarf_loader__worker_thread(void *arg)
 
 	while (!stop) {
 		job = cus_queue__enqdeq_job(job);
+		if (!job)
+			goto out_abort;
+
 		switch (job->type) {
 
 		case JOB_DECODE:
@@ -3688,6 +3694,8 @@ static void *dwarf_loader__worker_thread(void *arg)
 
 	return (void *)DWARF_CB_OK;
 out_abort:
+	__atomic_store_n(&cus_processing_queue.abort, true, __ATOMIC_SEQ_CST);
+	pthread_cond_signal(&cus_processing_queue.job_added);
 	return (void *)DWARF_CB_ABORT;
 }
 
@@ -4028,7 +4036,7 @@ static int cus__process_file(struct cus *cus, struct conf_load *conf, int fd,
 
 	/* Process the one or more modules gleaned from this file. */
 	int err = dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
-	if (err < 0)
+	if (err)
 		return -1;
 
 	// We can't call dwfl_end(dwfl) here, as we keep pointers to strings
-- 
2.48.1


