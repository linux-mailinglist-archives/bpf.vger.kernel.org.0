Return-Path: <bpf+bounces-35255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A791939398
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC27B21753
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09550170822;
	Mon, 22 Jul 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oVzwZntM"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27512907
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673081; cv=none; b=LV6mnpBvTFlUCG0fQvTLGhoquUbDS/jtuQUBTw4JmUYR1D7IZ8eu2Xo7R3Zarvhfx4Vj7nWTOLdiuqQJcbfaPYwWyQlh2dw/wJGBqtt4rIqLKSe+2AlkW0k8CxqhLXs4Y3aL4Pj9oYeN0oTRVWWiHbev/sRcPachXv4tmvOtKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673081; c=relaxed/simple;
	bh=K9gWPjipgq6F8jZRR1IWw0bTjDcwqQcLaz41LnKv3Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkhguckL6dX1vKs6HCnjOuViLO6gLVZpfFmHonTG4GgsyWNGPS8aTA6dgTP9kQjjAToUw8uESfKgwPp8apD5oV0IYlMerGagF+SlmnJ2UIEuLkmW3GO46U2rcuh6GqtMUs3QYfVsY/oaiWLfVHk/XH+NSzXUa121M2ZbNui4lC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oVzwZntM; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721673078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szr3DZbaMFvnAgwHjBej/wOowHjy9FmkntmAdOC5xyQ=;
	b=oVzwZntMkX40vzxwHHp2izRv7VJE57y8EiU2+Oft8tiYEv6TCr/0tX/pUq2qYC0Gv7oj9f
	x3xID+YNVbbnmQo/Ru0FycaCcr5W7BdOEYWn5trDmT8O8HTvY9HSEXtZOvwA7f/BS1TN4C
	ZpLw6GW8hywHzymiCeX+Q+ZZ7Gk64GQ=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/3] selftests/bpf: Fix the missing tramp_1 to tramp_40 ops in cfi_stubs
Date: Mon, 22 Jul 2024 11:30:46 -0700
Message-ID: <20240722183049.2254692-3-martin.lau@linux.dev>
In-Reply-To: <20240722183049.2254692-1-martin.lau@linux.dev>
References: <20240722183049.2254692-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The tramp_1 to tramp_40 ops is not set in the cfi_stubs in the
bpf_testmod_ops. It fails the struct_ops_multi_pages test after
retiring the unsupported_ops in the earlier patch.

This patch initializes them in a loop during the bpf_testmod_init().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index f8962a1dd397..fb951a1d91d5 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -910,6 +910,11 @@ static void bpf_testmod_test_2(int a, int b)
 {
 }
 
+static int bpf_testmod_tramp(int value)
+{
+	return 0;
+}
+
 static int bpf_testmod_ops__test_maybe_null(int dummy,
 					    struct task_struct *task__nullable)
 {
@@ -966,6 +971,7 @@ static int bpf_testmod_init(void)
 			.kfunc_btf_id	= bpf_testmod_dtor_ids[1]
 		},
 	};
+	void **tramp;
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_testmod_common_kfunc_set);
@@ -983,6 +989,14 @@ static int bpf_testmod_init(void)
 		return -EINVAL;
 	sock = NULL;
 	mutex_init(&sock_lock);
+
+	/* Ensure nothing is between tramp_1..tramp_40 */
+	BUILD_BUG_ON(offsetof(struct bpf_testmod_ops, tramp_1) + 40 * sizeof(long) !=
+		     offsetofend(struct bpf_testmod_ops, tramp_40));
+	tramp = (void **)&__bpf_testmod_ops.tramp_1;
+	while (tramp <= (void **)&__bpf_testmod_ops.tramp_40)
+		*tramp++ = bpf_testmod_tramp;
+
 	return sysfs_create_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
-- 
2.43.0


