Return-Path: <bpf+bounces-71234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC8BEB0D0
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F583BD724
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B39305E2D;
	Fri, 17 Oct 2025 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="imemcL5P"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF2304972;
	Fri, 17 Oct 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721379; cv=none; b=QZCSYN1JqrIL1CSHKgHwtaIGigl6fwKOdDz/pFVRds9SGR3JpfifA3rMcostSFUUX8+oQzKtAYlbyYPEf4VK28jF8/d/2FvNVoWuUb8Yle0algoI4IBDF9h8kw1VZYWywCuA09RFXHRPJuxLt7jpBVtLqBTAR75KSoLSQU2Damw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721379; c=relaxed/simple;
	bh=J77Bge3X5lG9xPM88ALgibxlEyLhgPjCdT0Op0/XSXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcaGm2zlDJqhVPq67gap0/BqAnvnOYcnoH7OHp5o+JF5W+XmLcJWm3c8gUJK2WvyJCLanP0rQYNwiMbyPl9mXcjk34jjZ1MdeG5VjHzsFps2L7m2WwAmvgh9J7HtKdO4tcHioFowWn1oqtaUPlSICgywAyOoGYm8qG3slnBdTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=imemcL5P; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cpBLP37kXz9scR;
	Fri, 17 Oct 2025 19:16:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760721373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oYAvtg51SooxYJuOlKf+hXOb32u2qfNNBX1dRS4YiB8=;
	b=imemcL5PMoL44zuZ0hyUU7YmNi9hBN6pGluRJVlt+T5gynhnu7bmLpJCm/SmZCztSdYRez
	3e0Wk/M6KWjmzHWVR9GakUjtyMgpAwzIAvTJzbdf5b5gUQH4qDeU4v1DEEAsxzgBzTKWb7
	+oj9sYTsc/g9AjX2dYtYETqWKrwc5VdKIsap3ByhnzxGgdZ4FSmKfpBUOpVOBWYVXBS4nH
	ppv3RLHFb0OmW8xLQT8mOUi/XGg+7ij0mU8JZFkkb7WrOTEZXPQN4bTomJF1ZUf/DQa9RO
	eFDNcfRi0zJ7gQ61bJlT0pKFwt0uO3scjrR8z3lVaRV+8+mQ55WpJ6UCT2eBJw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yonghong.song@linux.dev,
	andrii@kernel.org,
	eddyz87@gmail.com,
	yangtiezhu@loongson.cn,
	ast@kernel.org
Subject: [PATCH bpf v2] selftests/bpf: Fix redefinition of 'off' as different kind of symbol
Date: Fri, 17 Oct 2025 22:45:51 +0530
Message-ID: <20251017171551.53142-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cpBLP37kXz9scR

This fixes the following build error

   CLNG-BPF [test_progs] verifier_global_ptr_args.bpf.o
progs/verifier_global_ptr_args.c:228:5: error: redefinition of 'off' as
different kind of symbol
   228 | u32 off;
       |     ^

The symbol 'off' was previously defined in
tools/testing/selftests/bpf/tools/include/vmlinux.h, which includes an
enum i40e_ptp_gpio_pin_state from
drivers/net/ethernet/intel/i40e/i40e_ptp.c:

	enum i40e_ptp_gpio_pin_state {
		end = -2,
		invalid = -1,
		off = 0,
		in_A = 1,
		in_B = 2,
		out_A = 3,
		out_B = 4,
	};

This enum is included when CONFIG_I40E is enabled. As of commit
032676ff8217 ("LoongArch: Update Loongson-3 default config file"),
CONFIG_I40E is set in the defconfig, which leads to the conflict.

Renaming the local variable avoids the redefinition and allows the
build to succeed.

Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
Changes in v2:
- more context in the commit message about where the redefinition of
'off' comes from.
- replace [PATCH] to [PATCH bpf]

v1:
- Fix Fix redefinition of 'off' as different kind of symbol
Refer: https://lore.kernel.org/bpf/5ca1d6a6-5e5a-3485-d3cd-f9439612d1f3@loongson.cn/
Link: https://lore.kernel.org/bpf/20251017155450.4016595-1-listout@listout.xyz/
---
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 6630a92b1b47..1204fbc58178 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -225,7 +225,7 @@ int trusted_to_untrusted(void *ctx)
 }
 
 char mem[16];
-u32 off;
+u32 offset;
 
 SEC("tp_btf/sys_enter")
 __success
@@ -240,9 +240,9 @@ int anything_to_untrusted(void *ctx)
 	/* scalar to untrusted */
 	subprog_untrusted(0);
 	/* variable offset to untrusted (map) */
-	subprog_untrusted((void *)mem + off);
+	subprog_untrusted((void *)mem + offset);
 	/* variable offset to untrusted (trusted) */
-	subprog_untrusted((void *)bpf_get_current_task_btf() + off);
+	subprog_untrusted((void *)bpf_get_current_task_btf() + offset);
 	return 0;
 }
 
@@ -298,12 +298,12 @@ int anything_to_untrusted_mem(void *ctx)
 	/* scalar to untrusted mem */
 	subprog_void_untrusted(0);
 	/* variable offset to untrusted mem (map) */
-	subprog_void_untrusted((void *)mem + off);
+	subprog_void_untrusted((void *)mem + offset);
 	/* variable offset to untrusted mem (trusted) */
-	subprog_void_untrusted(bpf_get_current_task_btf() + off);
+	subprog_void_untrusted(bpf_get_current_task_btf() + offset);
 	/* variable offset to untrusted char/enum (map) */
-	subprog_char_untrusted(mem + off);
-	subprog_enum_untrusted((void *)mem + off);
+	subprog_char_untrusted(mem + offset);
+	subprog_enum_untrusted((void *)mem + offset);
 	return 0;
 }
 
-- 
2.51.0


