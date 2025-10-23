Return-Path: <bpf+bounces-71862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729FDBFEE0B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 03:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BF618C71FF
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 01:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727019994F;
	Thu, 23 Oct 2025 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aST9B2M1"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BA19D07E;
	Thu, 23 Oct 2025 01:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184251; cv=none; b=hSvRyUGdHAT4Om8ttA89f+3vqjS0l5pJkx9CSx1MVvT/xfh+dMDPnTSv/nryfk+XVOPQOUDUvuebG3k06dAsceVcXTAr0kmUsb0wpOkwmlKs3K2B9FJBAKHIxgwRYPUj+GDUaZc7qbtD31oBNbaFg1udR6j7FST50dV90UmewUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184251; c=relaxed/simple;
	bh=VPjo/TavjCUYH5jpu2PF801e4hBBbq0xYZ2b9JS+peo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HPoPOIMN7Cd88B+LwLtP1NiavCfsdOFjYJRsTk227ljjUfx/7o4xdVlJ8uDWH+W+fdDtmw0oq0TyjC9IQF11m0mvECWG4NvjG1EFnP9LDZZFsVA1sZljSDj6z8euGp4Xf5ETNMxIS+CGbHbVtOJ12kC167NRZMg8klwDtsZeSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aST9B2M1; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761184246; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=otnpdiEFfursP3O2n6iIwcNh+RVBRlIiP4mgigVpXsY=;
	b=aST9B2M1wVb2bZpUb56Brplm5jlyTSa1SrFcGVpde0ZNAyMCRom6mbzuO8L0JRR5b9vLD3alMg1ZdmJDI4ulJyWLpQKHoCWmhzcRrWSDrVSMYb4TuVK5WWSWXV5ZlUcPERZ6amXYt22m5SDL5bKUVTbst5gH1a6m//qCzFnfWWo=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqokhmM_1761184244 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 09:50:45 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	james.clark@arm.com,
	leo.yan@linaro.org,
	irogers@google.com
Cc: mingo@redhat.com,
	baolin.wang@linux.alibaba.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] perf record: skip synthesize event when open evsel failed
Date: Thu, 23 Oct 2025 09:50:43 +0800
Message-Id: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using perf record with the `--overwrite` option, a segmentation fault
occurs if an event fails to open. For example:

  perf record -e cycles-ct -F 1000 -a --overwrite
  Error:
  cycles-ct:H: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
  perf: Segmentation fault
      #0 0x6466b6 in dump_stack debug.c:366
      #1 0x646729 in sighandler_dump_stack debug.c:378
      #2 0x453fd1 in sigsegv_handler builtin-record.c:722
      #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
      #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-events.c:1862
      #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-events.c:1943
      #6 0x458090 in record__synthesize builtin-record.c:2075
      #7 0x45a85a in __cmd_record builtin-record.c:2888
      #8 0x45deb6 in cmd_record builtin-record.c:4374
      #9 0x4e5e33 in run_builtin perf.c:349
      #10 0x4e60bf in handle_internal_command perf.c:401
      #11 0x4e6215 in run_argv perf.c:448
      #12 0x4e653a in main perf.c:555
      #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
      #14 0x43a3ee in _start ??:0

The --overwrite option implies --tail-synthesize, which collects non-sample
events reflecting the system status when recording finishes. However, when
evsel opening fails (e.g., unsupported event 'cycles-ct'), session->evlist
is not initialized and remains NULL. The code unconditionally calls
record__synthesize() in the error path, which iterates through the NULL
evlist pointer and causes a segfault.

To fix it, move the record__synthesize() call inside the error check block, so
it's only called when there was no error during recording, ensuring that evlist
is properly initialized.

Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d76f01956e33..b1fb87016d5a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2883,11 +2883,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		rec->bytes_written += off_cpu_write(rec->session);
 
 	record__read_lost_samples(rec);
-	record__synthesize(rec, true);
 	/* this will be recalculated during process_buildids() */
 	rec->samples = 0;
 
 	if (!err) {
+		record__synthesize(rec, true);
 		if (!rec->timestamp_filename) {
 			record__finish_output(rec);
 		} else {
-- 
2.39.3


