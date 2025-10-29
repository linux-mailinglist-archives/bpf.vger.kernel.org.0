Return-Path: <bpf+bounces-72854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BA1C1CDE5
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A5188C638
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEDD2F83DF;
	Wed, 29 Oct 2025 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ev0Aqda6"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD32D73BC
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764505; cv=none; b=BXrRZ4FMuTZfqOoaQhWrJelVgvAZyYs68HCszkDkmQVy1kMfeHCZ6MnYAQk7qLFn+VzW1qwZGLBKfxo+y94FABPhPt0/vXykWiu1ONw+z0AKEQY92PDJfbUX3v3QL1Z4laWGD8CW5bUl4STCugQ6DgRxIHcFlWetKFFDiC5jxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764505; c=relaxed/simple;
	bh=mKKZM3rc0/Xd4mLenkaT0zcYvULHaaojrw0OssKNRaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdGbsyFp57+H0ckYZGbsumO5XCTnzyNcWpesgXEEb3lxfCjzwvVgYKueLBg5uL0DfKgp/AWv8M3UU/jG5O9pCmcX05yQK88lQvYjp6vhbGlQjKzzRzcP7JJLfhxeJWRh7Q2QU+xBnO58MTKaR0QIFhbOrjbcTXu84BfLMTXMxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ev0Aqda6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTzz/CPGPTo1DUp0zkbRjfFHfHvomcYOTbZ0QPmfyGE=;
	b=Ev0Aqda6zOxXDImccJV2dt5/deKtyMbCxQKIxFwlpTLaVRCOA73zlc6OKy8L5VMJXvhKLx
	fCcNFYWY5eu8V2xgtxyTR/G6HPhwhgsXEriOsatZDkWJMXea1K+kIKKrenFufhW8/Y/oRC
	ZF/Q8/cL6b3YT/n6Fau3fV6PuSvrCrQ=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/8] bpf: Add BTF_ID_LIST_END and BTF_ID_LIST_SIZE macros
Date: Wed, 29 Oct 2025 12:01:06 -0700
Message-ID: <20251029190113.3323406-2-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement macros in btf_ids.h to enable a calculation of BTF_ID_LIST
size. This is done by declaring an additional __end symbol which can
then be used as an indicator of the end of an array.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/btf_ids.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 139bdececdcf..27a4724d5aa9 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -97,6 +97,16 @@ asm(							\
 __BTF_ID_LIST(name, local)				\
 extern u32 name[];
 
+/*
+ * The BTF_ID_LIST_END macro may be used to denote an end
+ * of a BTF_ID_LIST. This enables calculation of the list
+ * size with BTF_ID_LIST_SIZE.
+ */
+#define BTF_ID_LIST_END(name) \
+BTF_ID_LIST(name##__end)
+#define BTF_ID_LIST_SIZE(name) \
+(name##__end - name)
+
 #define BTF_ID_LIST_GLOBAL(name, n)			\
 __BTF_ID_LIST(name, globl)
 
-- 
2.51.1


