Return-Path: <bpf+bounces-35254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793EA939397
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A821F21EE5
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D0616EC1A;
	Mon, 22 Jul 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S6O+4rD9"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866E2907
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673079; cv=none; b=nP1SAOaJbQfFvXY3RofronUpHLCKMfjhPGC3OK7vAdigNq8ejK6ojOK1kCuQexsXlf4OwS/hNzpF6K2/pN2N9Qtfa/KrGMrwLXSeQdkBWUpeFCxXMhg3LpDmDFYgVbYRVMkgO7b9QdkryA0m5jVAl61S2W5vudBd/kVdw9EbTg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673079; c=relaxed/simple;
	bh=2eBa33WMGRRpHNuFZPYJPS4j1yIIAL9WmWkyaWiDrrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjLTsXz9JijSMiDM3/MJ6iDHnL7k2SzdC/tPeJSuH0K/avl8mWTIFEUYbShU4MRvFaip5aWwEbwsJhvQBLGDsKHdqESJJFc596obr7a2oNe0cvzAy6sBW+ho7Bp0Va9ez3H1JDJk0sOHd5RBY7+S+vIdjqUPq5uIWoJtNEpSrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S6O+4rD9; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721673075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+lHXyHsD+CeapY/YSkSG9Wzy59VfgppZeGy6tc9QZg=;
	b=S6O+4rD9v8is1T+ksdzNRmxRZ5vwO/6cy8ChtCFBkc3b/wdN95rziOG6fwX0P/IHaKlEji
	AiO29gAskCqSbdKhJYn3kQ9qx1xJgT3497onbj/1uruvalcklfCvz80n6627/xr+ldrDBR
	OPGH2j4bdSH9HrXB2PeB2tI7auMg1fM=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: ameryhung@gmail.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	Amery Hung <ameryhung@gmail.com>
Subject: [PATCH v2 bpf-next 1/3] bpf: Check unsupported ops from the bpf_struct_ops's cfi_stubs
Date: Mon, 22 Jul 2024 11:30:45 -0700
Message-ID: <20240722183049.2254692-2-martin.lau@linux.dev>
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

The bpf_tcp_ca struct_ops currently uses a "u32 unsupported_ops[]"
array to track which ops is not supported.

After cfi_stubs had been added, the function pointer in cfi_stubs is
also NULL for the unsupported ops. Thus, the "u32 unsupported_ops[]"
becomes redundant. This observation was originally brought up in the
bpf/cfi discussion:
https://lore.kernel.org/bpf/CAADnVQJoEkdjyCEJRPASjBw1QGsKYrF33QdMGc1RZa9b88bAEA@mail.gmail.com/

The recent bpf qdisc patch (https://lore.kernel.org/bpf/20240714175130.4051012-6-amery.hung@bytedance.com/)
also needs to specify quite many unsupported ops. It is a good time
to clean it up.

This patch removes the need of "u32 unsupported_ops[]" and tests for null-ness
in the cfi_stubs instead.

Testing the cfi_stubs is done in a new function bpf_struct_ops_supported().
The verifier will call bpf_struct_ops_supported() when loading the
struct_ops program. The ".check_member" is removed from the bpf_tcp_ca
in this patch. ".check_member" could still be useful for other subsytems
to enforce other restrictions (e.g. sched_ext checks for prog->sleepable).

To keep the same error return, ENOTSUPP is used.

Cc: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h         |  5 +++++
 kernel/bpf/bpf_struct_ops.c |  7 +++++++
 kernel/bpf/verifier.c       | 10 +++++++++-
 net/ipv4/bpf_tcp_ca.c       | 26 --------------------------
 4 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f1d4a97b9d1..6464dd78ea13 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1795,6 +1795,7 @@ struct bpf_struct_ops_common_value {
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
+int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 				       void *value);
 int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
@@ -1851,6 +1852,10 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 {
 	module_put(owner);
 }
+static inline int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
+{
+	return -ENOTSUPP;
+}
 static inline int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
 						     void *key,
 						     void *value)
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index bb3eabc0dc76..fda3dd2ee984 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1040,6 +1040,13 @@ void bpf_struct_ops_put(const void *kdata)
 	bpf_map_put(&st_map->map);
 }
 
+int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
+{
+	void *func_ptr = *(void **)(st_ops->cfi_stubs + moff);
+
+	return func_ptr ? 0 : -ENOTSUPP;
+}
+
 static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 656766dd76df..33cb57c20d78 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21132,6 +21132,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	u32 btf_id, member_idx;
 	struct btf *btf;
 	const char *mname;
+	int err;
 
 	if (!prog->gpl_compatible) {
 		verbose(env, "struct ops programs must have a GPL compatible license\n");
@@ -21179,8 +21180,15 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	err = bpf_struct_ops_supported(st_ops, __btf_member_bit_offset(t, member) / 8);
+	if (err) {
+		verbose(env, "attach to unsupported member %s of struct %s\n",
+			mname, st_ops->name);
+		return err;
+	}
+
 	if (st_ops->check_member) {
-		int err = st_ops->check_member(t, member, prog);
+		err = st_ops->check_member(t, member, prog);
 
 		if (err) {
 			verbose(env, "attach to unsupported member %s of struct %s\n",
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 3f88d0961e5b..554804774628 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -14,10 +14,6 @@
 /* "extern" is to avoid sparse warning.  It is only used in bpf_struct_ops.c. */
 static struct bpf_struct_ops bpf_tcp_congestion_ops;
 
-static u32 unsupported_ops[] = {
-	offsetof(struct tcp_congestion_ops, get_info),
-};
-
 static const struct btf_type *tcp_sock_type;
 static u32 tcp_sock_id, sock_id;
 static const struct btf_type *tcp_congestion_ops_type;
@@ -45,18 +41,6 @@ static int bpf_tcp_ca_init(struct btf *btf)
 	return 0;
 }
 
-static bool is_unsupported(u32 member_offset)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(unsupported_ops); i++) {
-		if (member_offset == unsupported_ops[i])
-			return true;
-	}
-
-	return false;
-}
-
 static bool bpf_tcp_ca_is_valid_access(int off, int size,
 				       enum bpf_access_type type,
 				       const struct bpf_prog *prog,
@@ -251,15 +235,6 @@ static int bpf_tcp_ca_init_member(const struct btf_type *t,
 	return 0;
 }
 
-static int bpf_tcp_ca_check_member(const struct btf_type *t,
-				   const struct btf_member *member,
-				   const struct bpf_prog *prog)
-{
-	if (is_unsupported(__btf_member_bit_offset(t, member) / 8))
-		return -ENOTSUPP;
-	return 0;
-}
-
 static int bpf_tcp_ca_reg(void *kdata, struct bpf_link *link)
 {
 	return tcp_register_congestion_control(kdata);
@@ -354,7 +329,6 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.reg = bpf_tcp_ca_reg,
 	.unreg = bpf_tcp_ca_unreg,
 	.update = bpf_tcp_ca_update,
-	.check_member = bpf_tcp_ca_check_member,
 	.init_member = bpf_tcp_ca_init_member,
 	.init = bpf_tcp_ca_init,
 	.validate = bpf_tcp_ca_validate,
-- 
2.43.0


