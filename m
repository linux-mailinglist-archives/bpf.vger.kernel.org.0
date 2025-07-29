Return-Path: <bpf+bounces-64635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FF6B1511B
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAFE1895785
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CF223335;
	Tue, 29 Jul 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xg8OHYx8"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125520ED
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805869; cv=none; b=EO43ly7Ni8x08Ot0AB6nLxqjE7mgZ9jAOP7DQnYDBu2m5T9MTsnWecMTzh++tf6b9nAyh5pBXBuUkbH+59goqFLcIL2yTMMMN8TeZZUhRfwh/SAouxfEtUONVLLUlYrwXfbdGwYc3anb1ht9xyx3gsY+uCsZ6aK0aEKo0rIQfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805869; c=relaxed/simple;
	bh=QWpQU8PGPd2HQ6A9+gfoqjTiX83hg+ouG6zZsfgMAbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMBk710U/pKuDMwdPsOZ5pXbaBeafN9+Y8OTELnzXM2weInuGNTS3Dv+dfXEtET4C7M1qQVmtljnBIYY4v2619SKrZbeyttqPkVpUcBlMAYuo+CdMK2QmI8/EOQT6HKMG9AE8qpNI/JwZIcNYMjdK1pYWDzxcMVOS9/dLir21KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xg8OHYx8; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vo
	+yuRPeTOKA3B4bTARvY/owZt75ycTxjJsk8f2iSM8=; b=Xg8OHYx8TsuZi/Qceq
	sWzsFWtlC2JJhJxeVokAKIu+nCHWRZcR652NIxiNKpPWoJMZlIsXJKPfqjGzL0mn
	e8l3UnrgC3Ae7v2CQgwPZIOkmbMZ26d2Q77bfQP4hv+Kc1uY063pEPwn0Ucjx7t0
	IlydruwuOZ8MxsYU9ZBPaQwPE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3v5kS9IhoAZXtIA--.34400S2;
	Wed, 30 Jul 2025 00:17:24 +0800 (CST)
From: Jiawei Zhao <Phoenix500526@163.com>
To: andrii@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH v3] libbpf: fix USDT SIB argument handling causing unrecognized register error
Date: Wed, 30 Jul 2025 00:17:22 +0800
Message-Id: <20250729161722.35462-1-Phoenix500526@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v5kS9IhoAZXtIA--.34400S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryfArWkXF4kJr4rXFyUtrb_yoW7Gw45pa
	y0gwnayr18tr4SvFn3WF10ya9Ikws7JF48Zr4xJa45ZFWxWr4rJryfKF1ayrn8Ga9FyF13
	ZF4a9rWfCa4xur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UD-BiUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAeZiGiI5xDLqwAAs1

On x86-64, USDT arguments can be specified using Scale-Index-Base (SIB)
addressing, e.g. "1@-96(%rbp,%rax,8)". The current USDT implementation
in libbpf cannot parse this format, causing `bpf_program__attach_usdt()`
to fail with -ENOENT (unrecognized register).

This patch fixes this by implementing the necessary changes:
- add correct handling for SIB-addressed arguments in `bpf_usdt_arg`.
- add adaptive support to `__bpf_usdt_arg_type` and
`__bpf_usdt_arg_spec` to represent SIB addressing parameters.

Change since v1(https://lore.kernel.org/lkml/20250729125244.28364-1-Phoenix500526@163.com/):
- refactor the code to make it more readable
- modify the commit message to explain why and how

Change since v2:
- fix the `scale` uninitialized error

Signed-off-by: Jiawei Zhao <Phoenix500526@163.com>
---
 tools/lib/bpf/usdt.bpf.h | 33 ++++++++++++++++++++++++++++++++-
 tools/lib/bpf/usdt.c     | 26 +++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 2a7865c8e3fe..246513088c3a 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -34,6 +34,7 @@ enum __bpf_usdt_arg_type {
 	BPF_USDT_ARG_CONST,
 	BPF_USDT_ARG_REG,
 	BPF_USDT_ARG_REG_DEREF,
+	BPF_USDT_ARG_SIB,
 };
 
 struct __bpf_usdt_arg_spec {
@@ -43,6 +44,10 @@ struct __bpf_usdt_arg_spec {
 	enum __bpf_usdt_arg_type arg_type;
 	/* offset of referenced register within struct pt_regs */
 	short reg_off;
+	/* offset of index register in pt_regs, only used in SIB mode */
+	short idx_reg_off;
+	/* scale factor for index register, only used in SIB mode */
+	short scale;
 	/* whether arg should be interpreted as signed value */
 	bool arg_signed;
 	/* number of bits that need to be cleared and, optionally,
@@ -149,7 +154,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 {
 	struct __bpf_usdt_spec *spec;
 	struct __bpf_usdt_arg_spec *arg_spec;
-	unsigned long val;
+	unsigned long val, idx;
 	int err, spec_id;
 
 	*res = 0;
@@ -202,6 +207,32 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
 			return err;
 #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 		val >>= arg_spec->arg_bitshift;
+#endif
+		break;
+	case BPF_USDT_ARG_SIB:
+		/* Arg is in memory addressed by SIB (Scale-Index-Base) mode
+		 * (e.g., "-1@-96(%rbp,%rax,8)" in USDT arg spec). Register
+		 * is identified like with BPF_USDT_ARG_SIB case, the offset
+		 * is in arg_spec->val_off, the scale factor is in arg_spec->scale.
+		 * Firstly, we fetch the base register contents and the index
+		 * register contents from pt_regs. Secondly, we multiply the
+		 * index register contents by the scale factor, then add the
+		 * base address and the offset to get the final address. Finally,
+		 * we do another user-space probe read to fetch argument value
+		 * itself.
+		 */
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_kernel(&idx, sizeof(idx), (void *)ctx + arg_spec->idx_reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_user(&val, sizeof(val),
+				(void *)val + idx * arg_spec->scale + arg_spec->val_off);
+		if (err)
+			return err;
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		val >>= arg_spec->arg_bitshift;
 #endif
 		break;
 	default:
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 4e4a52742b01..260211e896d5 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -200,6 +200,7 @@ enum usdt_arg_type {
 	USDT_ARG_CONST,
 	USDT_ARG_REG,
 	USDT_ARG_REG_DEREF,
+	USDT_ARG_SIB,
 };
 
 /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
@@ -207,6 +208,8 @@ struct usdt_arg_spec {
 	__u64 val_off;
 	enum usdt_arg_type arg_type;
 	short reg_off;
+	short idx_reg_off;
+	short scale;
 	bool arg_signed;
 	char arg_bitshift;
 };
@@ -1283,11 +1286,28 @@ static int calc_pt_regs_off(const char *reg_name)
 
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
-	char reg_name[16];
-	int len, reg_off;
+	char reg_name[16], idx_reg_off, idx_reg_name[16];
+	int len, reg_off, scale;
 	long off;
 
-	if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, reg_name, &len) == 3) {
+	if (sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^,] , %d ) %n",
+				arg_sz, &off, reg_name, idx_reg_name, &scale, &len) == 5) {
+		/* Scale Index Base case, e.g., 1@-96(%rbp,%rax,8)*/
+		arg->arg_type = USDT_ARG_SIB;
+		arg->val_off = off;
+		arg->scale = scale;
+
+		reg_off = calc_pt_regs_off(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+
+		idx_reg_off = calc_pt_regs_off(idx_reg_name);
+		if (idx_reg_off < 0)
+			return idx_reg_off;
+		arg->idx_reg_off = idx_reg_off;
+	} else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
+				arg_sz, &off, reg_name, &len) == 3) {
 		/* Memory dereference case, e.g., -4@-20(%rbp) */
 		arg->arg_type = USDT_ARG_REG_DEREF;
 		arg->val_off = off;
-- 
2.39.5 (Apple Git-154)


