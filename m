Return-Path: <bpf+bounces-79577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26141D3C36F
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB0CE508310
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7985E3D301F;
	Tue, 20 Jan 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b="hSmEy0IY"
X-Original-To: bpf@vger.kernel.org
Received: from cvsmtppost03.nmdf.navercorp.com (cvsmtppost03.nmdf.navercorp.com [114.111.35.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5793D300C
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900679; cv=none; b=fMGd0uX/m+Wb+QMgFoNVNf9URlOisrlOvdFsu6TFTJVV0t7vIgHDklsFcbbGZiXFDG4hXtHhZb9VbaqqKEJ4y3I0AC0gOJyvgnoY9n75FxIxVZI431Y1+d/fj4CIII8sr2gFXymmvbKXkq/5ltDnVTWar2bsqqsyAccg/u/4hN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900679; c=relaxed/simple;
	bh=O/Mh7nvFRqR2V1lgWfJzdy5gT+PjfnHfRYG3+XYzr90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9A51V9QXev+06ifyV0diL96rr1TPB3ctGTOzXiilGtMhxoVUaJpSWOX6gdUYCW3cAiqMY1/YGXvAzCsnfGVF0wt3o7Wxmsy/ZfhZ+oCwa44JL0lhYw6oEB9xYzUGU9bexbPRHaB60UEPIL7muOrL6ETl2IBOJjjaAReLOHTqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com; spf=pass smtp.mailfrom=navercorp.com; dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b=hSmEy0IY; arc=none smtp.client-ip=114.111.35.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Received: from cvsendbo02.nmdf ([10.112.18.65])
  by cvsmtppost03.nmdf.navercorp.com with ESMTP id UQ1y75TQTh2oqEONbLbAsA
  for <bpf@vger.kernel.org>;
  Tue, 20 Jan 2026 09:07:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1768900067;
	bh=O/Mh7nvFRqR2V1lgWfJzdy5gT+PjfnHfRYG3+XYzr90=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=hSmEy0IYtw3UATRf3YlijmWV1yoWIO2t81aohFITPe2RhRUKVpdrLFO/npxxP/V39
	 w1zBStyMGyKPWOzon1ep0vh9fu2zCPeaIb7uq3dNboFSgVR0cd4wmMr7tpNQGAw5Wx
	 UDhjEHtLtW25FlYZ7A+batnJBII6dfLllwB6JUuHhSBaICqTqGMO9fD5seC2kc1wze
	 0IzlyFTWF3GCWphSUrN0Uh/lyvhYn32pe5DZoDCHWsC6gAMx6POiUO32px9sC6i6xT
	 DlVb1Idz8x2hR8fOYzTzpnMUGqtSBgJMOKQMKyvxzoPMXyRkY5HhWxhTsf3n7qAlFj
	 VPtH26GGyteFQ==
X-Session-ID: 5VnN9bM4RnaQzANsq-UP1Q
X-Works-Send-Opt: LebwjAJYjHm2KHwYjHm9UVg=
X-Works-Smtp-Source: u9nraA2rFqJZ+HmXFoMX+6E=
Received: from localhost.localdomain ([10.25.156.135])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id 5VnN9bM4RnaQzANsq-UP1Q
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Tue, 20 Jan 2026 09:07:47 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	gyutae.bae@navercorp.com
Subject: [PATCH] selftests/bpf: Add perfbuf multi-producer benchmark
Date: Tue, 20 Jan 2026 18:07:16 +0900
Message-Id: <20260120090716.82927-1-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gyutae Bae <gyutae.bae@navercorp.com>

Add a multi-producer benchmark for perfbuf to complement the existing
ringbuf multi-producer test. Unlike ringbuf which uses a shared buffer
and experiences contention, perfbuf uses per-CPU buffers so the test
measures scaling behavior rather than contention.

This allows developers to compare perfbuf vs ringbuf performance under
multi-producer workloads when choosing between the two for their systems.

Signed-off-by: Gyutae Bae <gyutae.bae@navercorp.com>
---
 tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
index 83e05e837871..123b7feb6935 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
@@ -49,6 +49,11 @@ for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
 	summarize "rb-libbpf nr_prod $b" "$($RUN_RB_BENCH -p$b --rb-batch-cnt 50 rb-libbpf)"
 done
 
+header "Perfbuf, multi-producer"
+for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
+	summarize "pb-libbpf nr_prod $b" "$($RUN_RB_BENCH -p$b --rb-batch-cnt 50 --rb-sample-rate 50 pb-libbpf)"
+done
+
 header "Ringbuf, multi-producer contention in overwrite mode, no consumer"
 for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
 	summarize "rb-prod nr_prod $b" "$($RUN_BENCH -p$b --rb-batch-cnt 50 --rb-overwrite --rb-bench-producer rb-libbpf)"
-- 
2.39.5 (Apple Git-154)


