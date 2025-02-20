Return-Path: <bpf+bounces-52105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD18A3E71D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 22:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FE3172336
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 21:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7E21480E;
	Thu, 20 Feb 2025 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ld4ima8g"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AD1EA7ED
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088755; cv=none; b=SE6HCk927jg6CBbGya7a+wT253r/ndrLDnf/bFGxfTaO+W2Rpn8zP6Z/R1tWnywyW/SbxktypGkahBTk1XaEW+sBS8NPcP0GI/+Jg3hAiG6Ejpz5OLgp5D7LpgPVSPh9cSiJBUE/S0DyAu6mdE4aD3bU+rJ8QEjj0qfPIoiLsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088755; c=relaxed/simple;
	bh=TOSygrza++He//qOVXcaQpNcfyAdM7kTtBs6knGw4V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCz/kZsEn7ufH4uPzhNFa75zpViM/8pEpv7UoJMzE9IeJQfvY85HugbwGvj+83tQScvxmfLD5B7FbrywD+nYIO/rWYUxWKEsnhHj75zEs95pfAU+Wz/f+li/nMnKHGA0/tLd/2EHmuOO2uc6TH4PC4jQzXVUFYUj/2U8dQqbnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ld4ima8g; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740088751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iZpJAulZucENFx39QcwmM0fgkw6mFhtqV9TUBtKQwFM=;
	b=Ld4ima8gcFsPO4psRhxF5xJPxiYA9JvMjoPw8sEZjIubdY8e52YhzHkwIPDVL+iTuyP3WB
	uL8SkOkWLAQZoJYixddbqyIqrLYVY26T/7CXLY7MnHCDnjDuTtFcixrI2BdswA7F/9qaES
	aV8LOV4eCQzBBveAx4iCVC9LW2Jt1+A=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] libbpf: implement bpf_usdt_arg_size BPF function
Date: Thu, 20 Feb 2025 13:59:03 -0800
Message-ID: <20250220215904.3362709-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Information about USDT argument size is implicitly stored in
__bpf_usdt_arg_spec, but currently it's not accessbile to BPF programs
that use USDT.

Implement bpf_sdt_arg_size() that returns the size of an USDT argument
in bytes.

Factor out __bpf_usdt_arg_spec() routine from bpf_usdt_arg(). It
searches for arg_spec given ctx and arg_num.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/usdt.bpf.h | 59 ++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index b811f754939f..6041271c5e4e 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -108,19 +108,12 @@ int bpf_usdt_arg_cnt(struct pt_regs *ctx)
 	return spec->arg_cnt;
 }
 
-/* Fetch USDT argument #*arg_num* (zero-indexed) and put its value into *res.
- * Returns 0 on success; negative error, otherwise.
- * On error *res is guaranteed to be set to zero.
- */
-__weak __hidden
-int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
+/* Validate ctx and arg_num, if ok set arg_spec pointer */
+static __always_inline
+int __bpf_usdt_arg_spec(struct pt_regs *ctx, __u64 arg_num, struct __bpf_usdt_arg_spec **arg_spec)
 {
 	struct __bpf_usdt_spec *spec;
-	struct __bpf_usdt_arg_spec *arg_spec;
-	unsigned long val;
-	int err, spec_id;
-
-	*res = 0;
+	int spec_id;
 
 	spec_id = __bpf_usdt_spec_id(ctx);
 	if (spec_id < 0)
@@ -136,7 +129,49 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 	if (arg_num >= spec->arg_cnt)
 		return -ENOENT;
 
-	arg_spec = &spec->args[arg_num];
+	*arg_spec = &spec->args[arg_num];
+
+	return 0;
+}
+
+/* Returns the size in bytes of the #*arg_num* (zero-indexed) USDT argument.
+ * Returns negative error if argument is not found or arg_num is invalid.
+ */
+static __always_inline
+int bpf_usdt_arg_size(struct pt_regs *ctx, __u64 arg_num)
+{
+	struct __bpf_usdt_arg_spec *arg_spec;
+	int err;
+
+	err = __bpf_usdt_arg_spec(ctx, arg_num, &arg_spec);
+	if (err)
+		return err;
+
+	/* arg_spec->arg_bitshift = 64 - arg_sz * 8
+	 * so: arg_sz = (64 - arg_spec->arg_bitshift) / 8
+	 * Do a bitshift instead of a division to avoid
+	 * "unsupported signed division" error.
+	 */
+	return (64 - arg_spec->arg_bitshift) >> 3;
+}
+
+/* Fetch USDT argument #*arg_num* (zero-indexed) and put its value into *res.
+ * Returns 0 on success; negative error, otherwise.
+ * On error *res is guaranteed to be set to zero.
+ */
+__weak __hidden
+int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
+{
+	struct __bpf_usdt_arg_spec *arg_spec;
+	unsigned long val;
+	int err;
+
+	*res = 0;
+
+	err = __bpf_usdt_arg_spec(ctx, arg_num, &arg_spec);
+	if (err)
+		return err;
+
 	switch (arg_spec->arg_type) {
 	case BPF_USDT_ARG_CONST:
 		/* Arg is just a constant ("-4@$-9" in USDT arg spec).
-- 
2.48.1


