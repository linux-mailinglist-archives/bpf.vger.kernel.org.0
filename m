Return-Path: <bpf+bounces-43781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA69B991E
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA891C20971
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF2C1D2707;
	Fri,  1 Nov 2024 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="wUHQjeZp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.219])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661981C7287
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491443; cv=none; b=HrJIkkWPc6FeAuc2DDus6jQZ8yv7tZ8bUnUQ0PA5E7BsDxMe8VNq17VbAWKeYAp4UNRwrcaYTEbssHy/qPjHSqpWBf+iyKY2sQWxDPWwNY40vVBRUhyexIclSSXubYez4xP9i8ILthWNm7S/uOP1PLK1/VVEA6fKxJGWcdpfvCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491443; c=relaxed/simple;
	bh=35lTSm2rOuZfqaj3EKow6eDjfZHr3x/H5eTLnuYzCuM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b0YSzV9umX1/FVbN3BjOrRJOnhYKTcCjh4yVtwwaowHwAKYZjd2jId7RrouDb/o4eNp/ojSUIneWoSAeSPDPawcLf8URRBvMRp1h/DwzlkaYuZagoZFLTytLktoTbC1l4W5vv+3B4iOr1ckq20IPcONeQcgUdrOQo/RtC6GrtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=wUHQjeZp; arc=none smtp.client-ip=128.178.224.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1730491036;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=35lTSm2rOuZfqaj3EKow6eDjfZHr3x/H5eTLnuYzCuM=;
      b=wUHQjeZp5c70Uyv+HVd6L05TJqH0zFTxlFCyHqcqILKF70iiV6JzAu3REQa9I/PbX
        KZPCgMFtU/pA7FuW9Mkyvn+YiByY2vmghGb5Ng+gkZEA/WWIAsSkwQPKS7E98GCye
        lwYx8GOqzcG4kL68SHMMogvpM6umTygDostTdA9PA=
Received: (qmail 25133 invoked by uid 107); 1 Nov 2024 19:57:16 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Fri, 01 Nov 2024 20:57:16 +0100
X-EPFL-Auth: 3CDc8tiVExnOsdTxrtRcClV4YkcoWE37nIiC8wlJATqvhd3BH0k=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 20:57:15 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <haoluo@google.com>,
	<martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH] bpf: Fix incorrect precision backtracking
Date: Fri, 1 Nov 2024 20:57:02 +0100
Message-ID: <20241101195702.2926731-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa05.intranet.epfl.ch (128.178.224.174) To
 ewa07.intranet.epfl.ch (128.178.224.178)

Hi,

The process_iter_arg check function misses the type check on the iter
args, which leads to any pointer types can be passed as iter args.

As the attached testcase shows, when I pass a ptr_to_map_value whose
offset is 0, process_iter_arg still regards it as a stack pointer and
use its offset to check the stack slot types.

In this case, as long as the stack slot types matched with the
ptr_to_map_value offset is correct, then checks can be bypassed.

I attached the fix, which checks if the argument type is stack pointer.

Please let me know if this fix might be incomplete.
I'm happy to revise it.

Best,
Tao

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 kernel/bpf/verifier.c                     |  6 ++++++
 tools/testing/selftests/bpf/progs/iters.c | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 797cf3ed32e0..bc968d2b76d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8031,6 +8031,12 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 		return -EINVAL;
 	}
 	t = btf_type_by_id(meta->btf, btf_id);
+
+	// Ensure the iter arg is a stack pointer
+	if (reg->type != PTR_TO_STACK) {
+		verbose(env, "iter pointer should be the PTR_TO_STACK type\n");
+		return -EINVAL;
+	}
 	nr_slots = t->size / BPF_REG_SIZE;
 
 	if (is_iter_new_kfunc(meta)) {
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index ef70b88bccb2..52078fc395fd 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1486,4 +1486,27 @@ int iter_subprog_check_stacksafe(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp")
+__failure __msg("iter pointer should be the PTR_TO_STACK type")
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
+        while ((v = bpf_iter_num_next((struct bpf_iter_num*)map_val))) {
+                bpf_printk("ITER_BASIC: E1 VAL: v=%d", *v);
+        }
+        bpf_iter_num_destroy(&it);
+
+        return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


