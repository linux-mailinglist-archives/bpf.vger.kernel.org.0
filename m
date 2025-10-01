Return-Path: <bpf+bounces-70138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD69BB193E
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C0A1925F5B
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4312D46AF;
	Wed,  1 Oct 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="0R2wAved"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9E20468E;
	Wed,  1 Oct 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346313; cv=none; b=Oy31wcYbi0xd4w0rjFEVDvXhib9BqbvWf1+3RjJ7jxhnQ2IAVqY+Ov8EQtmfTLq/ceWxyseWd8V+dx8nAh8RM8I3CrZNXBcxGDAJ2J4sAmXtn74wNvH5bLSzaT4GDT2JfGh54sJ3OcnyKfMxgd8QM+p7/GZGGbei6fIyxlzpaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346313; c=relaxed/simple;
	bh=HLYhW50XHaRj/9ZRdiTUSGg8dvCftmf3opE4NOaKOFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gg1rf3jq71a0oVyRrnRQFVDfhXXmahERn7XdhLmKThxh9cbuLZ9TxAvs3MrwpY7kTL8sHxQexG7MQgVsR5SMTtINlkV/vW4x3WxLjMx5PMHLK8Z8MQhJc43SQSNQv0vkE6HvuGkaXeTJGyn84cX0nEhyd+eUzsWaidL5Z2JvMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=0R2wAved; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ccPpq6CF0z9tMQ;
	Wed,  1 Oct 2025 21:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759346307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFOt7Q6Yh4zU6HGqC4KBvS7uM2NDq7KoM7BsVGIWIDU=;
	b=0R2wAvedEj44h9wfDrmE2K33AFr+WYGHh48El2DBatyjGDx8kAHW7h8CwACiigHt8YsN70
	gFOYV3cmViY7tR56qgSVdPjnuxsK8KmYgzATEERmOlTqujp/ydQhAfWw+K7KXq0J4grbGn
	WsZ03ckhhSEGi1yB6SYrQPpjItVZIi2s6cT5y4N/6tPrjBsUj2Uuz0s9cIRtMgf6qx+CJN
	gw51wGWUraqoykbbe1mGlhCJSFW4wzoNOhouF42tL8Ta4cQFq3eUTd2RGQOBmxjyIGTxab
	2a/Wk0AYsJxT8OM7zEavwZl29aVNkxDYZ1wA0Z9ptapJl9ndNyd1iYmBLUWNOg==
From: Brahmajit Das <listout@listout.xyz>
To: listout@listout.xyz
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH v4 2/2] selftests/bpf: Add test for BPF_NEG alu on CONST_PTR_TO_MAP
Date: Thu,  2 Oct 2025 00:47:39 +0530
Message-ID: <20251001191739.2323644-3-listout@listout.xyz>
In-Reply-To: <20251001191739.2323644-1-listout@listout.xyz>
References: <20250923164144.1573636-1-listout@listout.xyz>
 <20251001191739.2323644-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: KaFai Wan <kafai.wan@linux.dev>

Add a test case for BPF_NEG operation on CONST_PTR_TO_MAP. Tests if
BPF_NEG operation on map_ptr is rejected in unprivileged mode and is a
scalar value and do not trigger Oops in privileged mode.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../bpf/progs/verifier_value_illegal_alu.c     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index a9ab37d3b9e2..dcaab61a11a0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -146,6 +146,24 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("map_ptr illegal alu op, map_ptr = -map_ptr")
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R0 pointer arithmetic prohibited")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void map_ptr_illegal_alu_op(void)
+{
+	asm volatile ("					\
+	r0 = %[map_hash_48b] ll;			\
+	r0 = -r0;					\
+	r1 = 22;					\
+	*(u64*)(r0 + 0) = r1;				\
+	exit;						\
+"	:
+	: __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
 SEC("flow_dissector")
 __description("flow_keys illegal alu op with variable offset")
 __failure __msg("R7 pointer arithmetic on flow_keys prohibited")
-- 
2.51.0


