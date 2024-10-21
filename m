Return-Path: <bpf+bounces-42653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE49A6E1D
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2063D1C21B1D
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA813664E;
	Mon, 21 Oct 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BcVjCfJc"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C776137923
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524496; cv=none; b=b8xCvcnbpM0YZWj7DaRhJKMDcn5zC8EjgqNRRELtoFljfx+tAxEritrof+Q71NIki/S9Dweldn4yZpZX7NdZAQ/PDg0zwJid48OhRD+WZuDr18UzmEek/uAvAHspuycCW8C5eyzOQaE2Rgaqy0ogdg7jXUFjvzrOtudUp+TIqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524496; c=relaxed/simple;
	bh=YXbZpWIZsRvQWIFXqppwHuHIgmy8iAtaNrTV9nNBkT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2td4AEd4+RTbUVKTiLiibrDW3pOlECY7sZEFUAQKZeMhvNgHZzZGTDnStPJmlO07LP+yDzdIs0VfXq8MGB5mPtck5tI1+czN2MBzTrH3UZ0sh7mbB063BCvheIemUARFztPE13zncXCd1ccThJ4MYjzV67iyMVgodsHLK3vICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BcVjCfJc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TWSySzEd3KEH6gscwZsD8ZI2exSJEfuGfK550fw5M8Y=; b=BcVjCfJcMLTneyEe/+H3I0Q3jC
	WUzau9dJeE9mDgoxeeD3UcuB4Hb0EUrJMnSuI/BZluKs3xF3qnMBfoROIYdHJhhVrwtGQliF2qTHG
	srholS3I9u7ahZ3rQThw1rUwGYjOKdMFsG4KWP0Sk/9LNOY118bO3itkuHKRE/ZDCyLO6RGxkyXAU
	+vGIg83TQ1Z8/nIhKE00L1KmJQRjKjOqM5ce/mwJ1Fh6E0hlLnKzWv17TV8+0x/9oEqz5d5lJXlM9
	NyNt7sYjnCpCzloQou8FmRmplx/7qIPx1v5x7Ey5SO+gdA9qaWwiVOlpLkD5akbr0JWyI0Ukf1iTK
	q96eCZ5g==;
Received: from 43.248.197.178.dynamic.cust.swisscom.net ([178.197.248.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t2uKJ-000MzQ-NC; Mon, 21 Oct 2024 17:28:11 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	kongln9170@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf 4/5] selftests/bpf: Add test for writes to .rodata
Date: Mon, 21 Oct 2024 17:28:08 +0200
Message-Id: <20241021152809.33343-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021152809.33343-1-daniel@iogearbox.net>
References: <20241021152809.33343-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27434/Mon Oct 21 10:49:31 2024)

Add a small test to write a (verification-time) fixed vs unknown but
bounded-sized buffer into .rodata BPF map and assert that both get
rejected.

  # ./vmtest.sh -- ./test_progs -t verifier_const
  [...]
  ./test_progs -t verifier_const
  [    1.418717] tsc: Refined TSC clocksource calibration: 3407.994 MHz
  [    1.419113] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fcde90a1, max_idle_ns: 440795222066 ns
  [    1.419972] clocksource: Switched to clocksource tsc
  [    1.449596] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.449958] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #475/1   verifier_const/rodata/strtol: write rejected:OK
  #475/2   verifier_const/bss/strtol: write accepted:OK
  #475/3   verifier_const/data/strtol: write accepted:OK
  #475/4   verifier_const/rodata/mtu: write rejected:OK
  #475/5   verifier_const/bss/mtu: write accepted:OK
  #475/6   verifier_const/data/mtu: write accepted:OK
  #475/7   verifier_const/rodata/mark: write with unknown reg rejected:OK
  #475/8   verifier_const/rodata/mark: write with unknown reg rejected:OK
  #475     verifier_const:OK
  #476/1   verifier_const_or/constant register |= constant should keep constant type:OK
  #476/2   verifier_const_or/constant register |= constant should not bypass stack boundary checks:OK
  #476/3   verifier_const_or/constant register |= constant register should keep constant type:OK
  #476/4   verifier_const_or/constant register |= constant register should not bypass stack boundary checks:OK
  #476     verifier_const_or:OK
  Summary: 2/12 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_const.c      | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_const.c b/tools/testing/selftests/bpf/progs/verifier_const.c
index 2e533d7eec2f..e118dbb768bf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_const.c
+++ b/tools/testing/selftests/bpf/progs/verifier_const.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Isovalent */
 
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 
 const volatile long foo = 42;
@@ -66,4 +67,32 @@ int tcx6(struct __sk_buff *skb)
 	return TCX_PASS;
 }
 
+static inline void write_fixed(volatile void *p, __u32 val)
+{
+	*(volatile __u32 *)p = val;
+}
+
+static inline void write_dyn(void *p, void *val, int len)
+{
+	bpf_copy_from_user(p, len, val);
+}
+
+SEC("tc/ingress")
+__description("rodata/mark: write with unknown reg rejected")
+__failure __msg("write into map forbidden")
+int tcx7(struct __sk_buff *skb)
+{
+	write_fixed((void *)&foo, skb->mark);
+	return TCX_PASS;
+}
+
+SEC("lsm.s/bprm_committed_creds")
+__description("rodata/mark: write with unknown reg rejected")
+__failure __msg("write into map forbidden")
+int BPF_PROG(bprm, struct linux_binprm *bprm)
+{
+	write_dyn((void *)&foo, &bart, bpf_get_prandom_u32() & 3);
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0


