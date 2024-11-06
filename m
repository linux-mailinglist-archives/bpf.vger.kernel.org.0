Return-Path: <bpf+bounces-44153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D1B9BF7F5
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8625C283894
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9365720C304;
	Wed,  6 Nov 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="FEuR+Bwz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp5.epfl.ch (smtp5.epfl.ch [128.178.224.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152AD20C035
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924753; cv=none; b=RRn/iGKEGCFbSF6gta87xkT5TM4EtLDcY42hfxiKvf1Q2HwlYPzxl4aQieBLU2thRnNhx2sLEkT63/YCjdxUMH2Q1P2UJjvDx1Bqr1uXuaLKx5JNwfBOjA7bNu/lHCnUwvqf31WYJY/qYjq23W2uZW5CVDhrx1X0pZrDTIThrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924753; c=relaxed/simple;
	bh=tDpNlbGx8esH2FTD0cBQOLGp912UHlLA/+tk0j4948Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dba+JYY2NeViHtJET5efWWCprsM4q7LSLGZ5QifyouKqr0ZK03Zu3Wjk91QVzR1AM4xWn77cqEwV0v9viJZiA3v3Czl4bIkjcVCyW2unLA+uMdcSk+hHcCtXzVWxh+PNfdHdDIMr56E7yqYw6y+34Z/vou+x9Z1TDSJ5t/IHcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=FEuR+Bwz; arc=none smtp.client-ip=128.178.224.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1730924349;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=tDpNlbGx8esH2FTD0cBQOLGp912UHlLA/+tk0j4948Q=;
      b=FEuR+BwzlMt+xbgdf4HAf01HFxD64EpqDbn5NDan3bDvb3arxE1IRC7sIVw8IDI+Q
        NznJzi63lKbkMgPAq2KE09QsyMtgxdy/NLNUv8ir7KPCU/AiVnZ2UkkKMectGM1s4
        caHd8zXefofvOU2ENM4AGt9SVrAkukhXYjk2Dca14=
Received: (qmail 1883 invoked by uid 107); 6 Nov 2024 20:19:09 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Wed, 06 Nov 2024 21:19:09 +0100
X-EPFL-Auth: VuiqoBYMAg8NQshvcIII8CeiUA6aldHrLHOrVUzmeBH7F754EW0=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 21:19:08 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <haoluo@google.com>,
	<martin.lau@linux.dev>, <memxor@gmail.com>
CC: <bpf@vger.kernel.org>, Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH 2/2] selftests/bpf: Add a test for the type checking of iter args
Date: Wed, 6 Nov 2024 21:18:49 +0100
Message-ID: <20241106201849.2269411-3-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106201849.2269411-1-tao.lyu@epfl.ch>
References: <20241106201849.2269411-1-tao.lyu@epfl.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa11.intranet.epfl.ch (128.178.224.186) To
 ewa07.intranet.epfl.ch (128.178.224.178)

This is a selftest for the type checking of iter arguments.
When passing a PTR_TO_MAP_VALUE to bpf_iter_num_* kfuncs, the program should be rejected.

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 tools/testing/selftests/bpf/progs/iters.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index ef70b88bccb2..0a2df20afa30 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1486,4 +1486,25 @@ int iter_subprog_check_stacksafe(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp")
+__failure __msg("arg#0 expected pointer to the iterator")
+int iter_check_arg_type(const void *ctx)
+{
+        struct bpf_iter_num it;
+        int *v;
+
+        int *map_val = NULL;
+        int key = 0;
+
+        map_val = bpf_map_lookup_elem(&arr_map, &key);
+        if (!map_val)
+                return 0;
+
+        bpf_iter_num_new(&it, 0, 3);
+        while ((v = bpf_iter_num_next((struct bpf_iter_num*)map_val))) {}
+        bpf_iter_num_destroy(&it);
+
+        return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


