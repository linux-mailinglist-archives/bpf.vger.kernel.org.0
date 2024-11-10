Return-Path: <bpf+bounces-44459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F6B9C31CE
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916541C20948
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5813715665E;
	Sun, 10 Nov 2024 11:37:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C471547E9
	for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731238650; cv=none; b=IGni0/SBO4kY/KDaT/qeMrBrhtIrZ2MpS2owiI0msgj11YNh9cAu8TvBONtAIJ1Hbifg9/2rbr/6WHlefFuS8uYLivND/6h8QcB2LrBoXKiGfWPCjktSB6oVj3Oo0hXgfktDyGV6jZTtmcFrY5kRLq5KHAAClhhV3GN2TRFfn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731238650; c=relaxed/simple;
	bh=p63zmwTw0SAuuvlijeSTS+os7TcT9HAKhVTPweFYAjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iShy77SzDfUoKLVCEd7EFsdOr1Z8uZbnIgDH0DRB1oOrfOKlfTH9Ox8yf4Tduony3eyGkI/57V496iuNSqiJmGC2GGl7sPHggwuf9ieMJkXnqYqznIMbuyN2dX5Oib5TBy8sGI02pm+iodPzpE6mD/EZm+7sq4ssTnzdgbTRCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
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
	aspsk@isovalent.com,
	kees@kernel.org,
	quic_abchauha@quicinc.com,
	martin.kelly@crowdstrike.com,
	mykolal@fb.com,
	shuah@kernel.org,
	yikai.lin@vivo.com,
	Florian Lehner <dev@der-flo.net>
Subject: [bpf-next 2/2] selftests/bpf: Add a test for batch operation flag
Date: Sun, 10 Nov 2024 12:29:04 +0100
Message-ID: <20241110112905.64616-3-dev@der-flo.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241110112905.64616-1-dev@der-flo.net>
References: <20241110112905.64616-1-dev@der-flo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that verifies the batch operation continues if
BPF_F_BATCH_IGNORE_MISSING_KEY is set.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 .../bpf/map_tests/htab_map_batch_ops.c        | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
index 5da493b94ae2..76df196f5223 100644
--- a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
@@ -136,7 +136,25 @@ void __test_map_lookup_and_delete_batch(bool is_pcpu)
 	err = bpf_map_get_next_key(map_fd, NULL, &key);
 	CHECK(!err, "bpf_map_get_next_key()", "error: %s\n", strerror(errno));
 
-	/* test 4: lookup/delete in a loop with various steps. */
+	/* test 4: batch delete with missing key */
+	map_batch_update(map_fd, max_entries, keys, values, is_pcpu);
+
+	key = 2;
+	err = bpf_map_delete_elem(map_fd, &key);
+	CHECK(err, "bpf_map_delete_elem()", "error: %s\n", strerror(errno));
+
+	DECLARE_LIBBPF_OPTS(bpf_map_batch_opts, ignore_opts,
+		.elem_flags = 0,
+		.flags = BPF_F_BATCH_IGNORE_MISSING_KEY,
+	);
+
+	err = bpf_map_delete_batch(map_fd, keys, &count,
+	       &ignore_opts);
+	CHECK(err, "batch delete with missing key", "error: %s\n", strerror(errno));
+	CHECK(count != max_entries-1, "count != max_entries-1",
+	      "count = %u, max_entries = %u\n", count, max_entries);
+
+	/* test 5: lookup/delete in a loop with various steps. */
 	total_success = 0;
 	for (step = 1; step < max_entries; step++) {
 		map_batch_update(map_fd, max_entries, keys, values, is_pcpu);
-- 
2.47.0


