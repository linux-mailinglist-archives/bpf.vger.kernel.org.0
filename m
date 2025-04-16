Return-Path: <bpf+bounces-56050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9939A9098A
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 19:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA36F7A5C83
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B2021517B;
	Wed, 16 Apr 2025 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vCmKX8/E"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133A1C4A24;
	Wed, 16 Apr 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822979; cv=none; b=kBIS/qumJ1PJBnSMqy5c46BM5TrbpKCBGXec6JOGpE8R8t/bTgYIWY8A1QbyLPIXQMgavzChSnBeRIqtaOP76N/A2Sm8Y7RbgZ3LnfDyutHdzUN7aHe3sfW0G+LzA4W8RC+NWZqxKiAbR50PcyYgkuW6KMLYCmHIP3heEEOYl+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822979; c=relaxed/simple;
	bh=c6n2S8Es1rQhG96rKpKg74dRponKYkPXa94utKlWUU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAVWelCAOgqSv9KE/eMweFgUksKBdC2o6das+bVzZbSFwm1VOkf9CVXe2CniOJiheQ9MT0s26F3v/WzOWUcmL5qsggZGQIiTplgrZpffdHHg3CwLOgtcsKsK/sYcdJCEtTTFvpmG3wpWbKSOPVw25Bvu3bUPyRiBneVuQaWWIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCmKX8/E; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744822974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/vQhnDlGrp5Wty3mwjV+dD/ZoteoqbDKx39VqSjIeyI=;
	b=vCmKX8/EcF4rryEcojcLgzkbhS0RgjkzuNLrSScmabTL+3v55sjykMA8MBdoRv8KyBIxuu
	CceesUKYSVIQIb1cwiw0KqIMop/NTf5sJENEMIfouyf+I6zGlRhY0XYsf7DK8PHBAP7tNH
	BLrcuUZarq0AT0yaXkwT0SSf2waT/gg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jiayuan.chen@linux.dev,
	pabeni@redhat.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH bpf] selftests/bpf: mitigate sockmap_ktls disconnect_after_delete failure
Date: Wed, 16 Apr 2025 10:02:46 -0700
Message-ID: <20250416170246.2438524-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

"sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
after recent merges from netdev:
* https://github.com/kernel-patches/bpf/actions/runs/14458537639
* https://github.com/kernel-patches/bpf/actions/runs/14457178732

It happens because disconnect has been disabled for TLS [1], and it
renders the test case invalid.

Removing all the test code creates a conflict between bpf and
bpf-next, so for now only remove the offending assert [2].

The test will be removed later on bpf-next.

[1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.org/
[2] https://lore.kernel.org/bpf/cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..0a99fd404f6d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -68,7 +68,6 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 		goto close_cli;
 
 	err = disconnect(cli);
-	ASSERT_OK(err, "disconnect");
 
 close_cli:
 	close(cli);
-- 
2.49.0


