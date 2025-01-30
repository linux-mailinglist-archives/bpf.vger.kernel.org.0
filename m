Return-Path: <bpf+bounces-50163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BEEA234F1
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 21:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF79A1637A9
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D71F1313;
	Thu, 30 Jan 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="egRdqv3I"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F51F0E5B
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738267977; cv=none; b=nD0FTfhqN9y9DXxSX7TwG+vT5mtdOg8hgnSIwSDe3t/zl5mCx2RmxZRKgO5XHtLJuZoeiABtW4yzZGB/Yrv73xyxPja6ptdqtf96QLQoVMgqIuAs5o+3g5rSHcsa0nQ0JVXf1cDew7WQzkZzm3KAe5sqYdM0O43U0RPwEAsDddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738267977; c=relaxed/simple;
	bh=lhm/4JxodG/npquGRyEwLbfG2Bg04sjRWBoO45lNQo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKsgAoR2NP8mw8+SbjZhMmprrK6RxB5hMZq43YhS9PP2JBG8d3kpdXP/+qJqjL2HIewa0jf0Ng5cnPDfvJUXl8nfOJp/1dSwZlxsPbM2TFpIBrh2Jtcw8GsXLCaslwCgJb1F/kiAF61WIgFp5m9h0w45m/ha/k7eET4/k+3YCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=egRdqv3I; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738267974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7j+wx1XXA57tEmKtlkZxRTt5BzPNsOBcj/sCUX6GblM=;
	b=egRdqv3ImIjM2mZQZybTv+7aW5wsscFrgUXuSIi9Ok6fc1FpGEtn05QAlifoXpr9CAYQ7A
	WZ2dr9R72H5CUBlskYxbIAvTf3/GXB3XdHI+d1ZTzIGokoU3uk8rPdC1MciABWatxm+tfq
	CBN7zNRxHOO0Dy/GizJ6XoQSDEnaGik=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: add a BTF verification test for kflagged type_tag
Date: Thu, 30 Jan 2025 12:12:39 -0800
Message-ID: <20250130201239.1429648-7-ihor.solodrai@linux.dev>
In-Reply-To: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
References: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
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


