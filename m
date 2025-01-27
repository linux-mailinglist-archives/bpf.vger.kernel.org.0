Return-Path: <bpf+bounces-49908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1931FA201CD
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03023A54D6
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE41DE2BE;
	Mon, 27 Jan 2025 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iTavZsUA"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534441DE2A0
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021217; cv=none; b=KyhfaQatgxnEU3NRCchRFEppKiTknbxHFCrz2ZgzK63+eXnGv58IysMbKWdmFDhhOR9H1oFlvWmwYwo8aMkYaeQsqDyOnR/JHnLg8jc6iQPxBQ3kayFqwvNcbfEwxRUh0ZFX7o9JSeVxMwkjDjXA5DIsKd1Fv5DfHUadXE6UgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021217; c=relaxed/simple;
	bh=lhm/4JxodG/npquGRyEwLbfG2Bg04sjRWBoO45lNQo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDnwtXlMNiRP3w0qKZ2G7b18XZlMDvTZ5oV8hQXkZAzm2gXRjk8D/reNJcoapz/nSKH4G2rCVRn9AII/N+02N0beCOTHiBgfc6LixVPlvhPqAH+w1a+hdQT/q2rOAyqGNS3rHuju1tvGZAelOs2wdKBKHfQLGbXZ26O/JdOfjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iTavZsUA; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738021212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7j+wx1XXA57tEmKtlkZxRTt5BzPNsOBcj/sCUX6GblM=;
	b=iTavZsUATfSzMu+A3+Yune+6ix5EAf991w47XcW/zpeZ4Kqutr0EPEDYjHFEWSs8XZF7DI
	/puR7Fxsr2Z6MOq66c/oIDTQdGDVMc06zivtiVDebnq37uT/cBjUXRV8M5mSMgKM6cKKFV
	Lvu99n8kq2jThF1bTzpolsk8vL4yYXI=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: add a BTF verification test for kflagged type_tag
Date: Mon, 27 Jan 2025 15:39:55 -0800
Message-ID: <20250127233955.2275804-7-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a BTF verification test case for a type_tag with a kflag set.
Type tags with a kflag are now valid.

Add BTF_DECL_ATTR_ENC and BTF_TYPE_ATTR_ENC test helper macros,
corresponding to *_TAG_ENC.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 19 ++++++++++++++++++-
 tools/testing/selftests/bpf/test_btf.h       |  6 ++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index aab9ad88c845..8a9ba4292109 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3870,7 +3870,7 @@ static struct btf_raw_test raw_tests[] = {
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
-		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 1, 0), 2), (-1),
+		BTF_DECL_ATTR_ENC(NAME_TBD, 2, -1),
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0local\0tag1"),
@@ -4204,6 +4204,23 @@ static struct btf_raw_test raw_tests[] = {
 	.btf_load_err = true,
 	.err_str = "Type tags don't precede modifiers",
 },
+{
+	.descr = "type_tag test #7, tag with kflag",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_ATTR_ENC(NAME_TBD, 1),			/* [2] */
+		BTF_PTR_ENC(2),					/* [3] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "tag_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 1,
+},
 {
 	.descr = "enum64 test #1, unsigned, size 8",
 	.raw_types = {
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
index fb4f4714eeb4..e65889ab4adf 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -72,9 +72,15 @@
 #define BTF_TYPE_FLOAT_ENC(name, sz) \
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
 
+#define BTF_DECL_ATTR_ENC(value, type, component_idx)	\
+	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 1, 0), type), (component_idx)
+
 #define BTF_DECL_TAG_ENC(value, type, component_idx)	\
 	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 0), type), (component_idx)
 
+#define BTF_TYPE_ATTR_ENC(value, type)	\
+	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 1, 0), type)
+
 #define BTF_TYPE_TAG_ENC(value, type)	\
 	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
 
-- 
2.48.1


