Return-Path: <bpf+bounces-61155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2814AE12D1
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 07:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA61C4A12D5
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 05:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E8520458A;
	Fri, 20 Jun 2025 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JOCUVuHm"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A2202F6D
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750396252; cv=none; b=SfgioiD8UACjin6QxNwZjHW4LUfL6ADgt10l0V2RRoOPLq9W19gtMRpEtCMP2M8Np4Dd7xlPvTNLNDT2pIPwFMRKL5Mrozps0gJvCi6oLKhDk3TekyhPVLv1wiLzcH9DQa9hJU/QnD2MZi3MGkdroO4bwcWWQ8eszER78xGCl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750396252; c=relaxed/simple;
	bh=wTe9sZu+7w2/u0QZ1g9JhwPm1diF0KdniHSnNJVGwEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/vz5JR1mwPz1FIzg2pBL/D5wapu9deGlUZG5AwJ5RKsGerl03zk+YyC2Srjof6aQLgtMuiNBpcsdfdv5y4kHOrcZhmZ2xUAmQsFAfT3pHGxbz5G8zXq+rvjN8zvlqLmiN74FIc9RJN2gemMUJt8Jxh2a7lxeTuntAKgG0MBU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JOCUVuHm; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750396237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EbmDynAdqvSSqw5yXcEWVeaFPATe2PmYKwtuqurNZ0U=;
	b=JOCUVuHmW5dkBwVq9b8di//Jc6GWwZV0X18Wa2ZjO8/HBxPwlx7KZf4CTlql/Ry0gphvjs
	KiGBaPPom/+h1mMUEEwHtxdFAJD+X90F8fsRLIf8MauifA93mm5UsG85JlfV7EdS3O0bWy
	gvwtpEnny7G2yYh/1xO2J93AGUWszKo=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: Add load_time in bpf_prog fdinfo
Date: Fri, 20 Jun 2025 13:10:17 +0800
Message-ID: <20250620051017.111559-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The field run_time_ns can tell us the run time of the bpf_prog,
and load_time_s can tell us how long the bpf_prog loaded on the
machine.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51ba1a7aa43..407841ea296 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2438,6 +2438,7 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 	const struct bpf_prog *prog = filp->private_data;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 	struct bpf_prog_kstats stats;
+	u64 now = ktime_get_boottime_ns();
 
 	bpf_prog_get_stats(prog, &stats);
 	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
@@ -2450,7 +2451,8 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "run_time_ns:\t%llu\n"
 		   "run_cnt:\t%llu\n"
 		   "recursion_misses:\t%llu\n"
-		   "verified_insns:\t%u\n",
+		   "verified_insns:\t%u\n"
+		   "load_time_s:\t%llu\n",
 		   prog->type,
 		   prog->jited,
 		   prog_tag,
@@ -2459,7 +2461,8 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 		   stats.nsecs,
 		   stats.cnt,
 		   stats.misses,
-		   prog->aux->verified_insns);
+		   prog->aux->verified_insns,
+		   (now - prog->aux->load_time) / NSEC_PER_SEC);
 }
 #endif
 
-- 
2.48.1


