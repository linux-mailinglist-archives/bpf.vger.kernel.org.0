Return-Path: <bpf+bounces-49474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03364A1911C
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81591188787D
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B51211703;
	Wed, 22 Jan 2025 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLwwr70O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A61212B21
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547507; cv=none; b=HptauAB6evIkYo/ezuPQLwKAbyeu0lGvzWmkl1y1FlNc237FkiBRipVSCq/T6/qHT9QTeNA9rnhnluyw0KJz3Bt+1keWjLxLEGSr4AGeJaDoiKG5IxRozecdrHwF20JS1dYHiocoLGGE/+qOePuiUWhk1Mn2cpyWzHvBO8Jd/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547507; c=relaxed/simple;
	bh=U9VjoVwEI1GZDWJL4gENnlWoZSf/vyvnLCIilsG1aYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlCgCy/UuM3/lYlW2ySgcSYoggHJ4xV+UbH0Z4KB0sjGMAEQ9AAqHYmqzzY4n6COsielao2LTz1rnRFvX/iinHm431lLpZD2q7RsHwVCD72f1xxmYWAgKgJVBIsZVMH7QcJSJziUPAvMRz23lKOqv6PjEOXCa9oCtBt6S/VdQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLwwr70O; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b662090so124689905ad.1
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 04:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737547504; x=1738152304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQpN9Raq9KxubRV4TgvIOLOIn0GGWFbmG8pxMikfG8I=;
        b=gLwwr70O56QXKR/V1n/1e4uGvY475fAg5ecG/wTPv5ecpvtLcHIC8Qein8i2lprr3z
         GxdEFbs3tLp4dOEMQETVHIulQJs06paCdQuAAuqVU/ZCV6daaOGy9s3nh8BVOKmFCPEO
         boMFGT95Bn57PW5HT5nO6EMarYvTFJGpN/Zojy7GxKJxebX7+yPzpFy27ekXx0xTo5Yf
         ePWrMp9t9RP2oSVURcXZJH6lBGHfN1iP+Gov3LV3p0O/BcoXsjQeuWlNDN9CH4gIBsbi
         wtlfwB9sNuG0Hq/1Z1Jk8RtWKE0vg6Zq1is00KFEtBqZMAh6bV4nGtwfO3Qqy53I6qej
         MzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547504; x=1738152304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQpN9Raq9KxubRV4TgvIOLOIn0GGWFbmG8pxMikfG8I=;
        b=BC+2TzTlhk0FC6KuC4/Jkt7KDeRnLX1hY33rP1uAAy39cAA+JVCmOGtJ5ZeYEU3a5H
         fxdc2MHP8fn6VqSjdmWce1REGM/BYItXWymJukttwHYEXjGC87CCe0fwqoaPb3mkKkv2
         FqWmeKYxloebiqjgPntjXeUEIk/CIk/a4q0SU2w1qN3w580KVZVR9FBVCfkWGK655Lv2
         YYXgDnTaWDNmgZMo64kOfd8Bmyb+fx45e1+NniacnFAQ+6yVa3+sC3V5Kk18p3FK52Ij
         Jb5lCy5Tscd42CplvNXu3OJjv+aK9RSiR3CIuRe0uQ4yDVnxoa8FYPyic+VrGKfdrmay
         jCdQ==
X-Gm-Message-State: AOJu0YxRz1IYmiBE+vAnfRbeeVgD8iXWV7QG/o/StPFMYtnd+bDVKBnz
	lG8HpNSC/tIzCMj1O5JoAWPUOw1GFPMLaWCnD8F841olDHhAf2tr2te/ZQ==
X-Gm-Gg: ASbGnctg5b158bwbmvK2uerve2DeMqeI1sbyyM3lPRFgE3+qdLXSG0rZ8D5fF0miYA8
	pCxXfGdFsbAYywTwhOoWKwXcYuWitKDf1B/lchQnTtQS2LxRKtRTX1t+D2/ZygPtcpyCSg47eLS
	Svmz4tHaXa2sHlbgcX4fW6wY20UigVHSTqBNGUKH5QK53IfPik9dnPQV4XiXEUxcGQGoy5wfKf1
	dEW9Dziy5Fmo3VieC5ODNqskXEuy0sxsrqJiX3gx/iRBnqoBwue5K0BcYSjbKDT2Ehu/HVe16aN
X-Google-Smtp-Source: AGHT+IHVilZvItZYziHNTbi51M19KlmBFq2SG8tK75MkQvEdvulBfNrdaNwhXM44SMhZLLhH6Jr/9g==
X-Received: by 2002:a05:6a20:cf8e:b0:1e1:f40d:9783 with SMTP id adf61e73a8af0-1eb215ca197mr40439596637.40.1737547504468;
        Wed, 22 Jan 2025 04:05:04 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm11055732b3a.66.2025.01.22.04.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:05:03 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 4/7] selftests/bpf: check states pruning for deeply nested iterator
Date: Wed, 22 Jan 2025 04:04:39 -0800
Message-ID: <20250122120442.3536298-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122120442.3536298-1-eddyz87@gmail.com>
References: <20250122120442.3536298-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A test case with ridiculously deep bpf_for() nesting and
a conditional update of a stack location.

Consider the innermost loop structure:

	1: bpf_for(o, 0, 10)
	2:	if (unlikely(bpf_get_prandom_u32()))
	3:		buf[0] = 42;
	4: <exit>

Assuming that verifier.c:clean_live_states() operates w/o change from
the previous patch (e.g. as on current master) verification would
proceed as follows:
- at (1) state {buf[0]=?,o=drained}:
  - checkpoint
  - push visit to (2) for later
- at (4) {buf[0]=?,o=drained}
- pop (2) {buf[0]=?,o=active}, push visit to (3) for later
- at (1) {buf[0]=?,o=active}
  - checkpoint
  - push visit to (2) for later
- at (4) {buf[0]=?,o=drained}
- pop (2) {buf[0]=?,o=active}, push visit to (3) for later
- at (1) {buf[0]=?,o=active}:
  - checkpoint reached, checkpoint's branch count becomes 0
  - checkpoint is processed by clean_live_states() and
    becomes {o=active}
- pop (3) {buf[0]=42,o=active}
- at (1), {buf[0]=42,o=active}
  - checkpoint
  - push visit to (2) for later
- at (4) {buf[0]=42,o=drained}
- pop (2) {buf[0]=42,o=active}, push visit to (3) for later
- at (1) {buf[0]=42,o=active}, checkpoint reached
- pop (3) {buf[0]=42,o=active}
- at (1) {buf[0]=42,o=active}:
  - checkpoint reached, checkpoint's branch count becomes 0
  - checkpoint is processed by clean_live_states() and
    becomes {o=active}
- ...

Note how clean_live_states() converted the checkpoint
{buf[0]=42,o=active} to {o=active} and it can no longer be matched
against {buf[0]=<any>,o=active}, because iterator based states
are compared using stacksafe(... RANGE_WITHIN), that requires
stack slots to have same types. At the same time there are
still states {buf[0]=42,o=active} pushed to DFS stack.

This behaviour becomes exacerbated with multiple nesting levels,
here are veristat results:
- nesting level 1: 69 insns
- nesting level 2: 258 insns
- nesting level 3: 900 insns
- nesting level 4: 4754 insns
- nesting level 5: 35944 insns
- nesting level 6: 312558 insns
- nesting level 7: 1M limit

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 007831dc8c46..427b72954b87 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -7,6 +7,8 @@
 #include "bpf_misc.h"
 #include "bpf_compiler.h"
 
+#define unlikely(x)	__builtin_expect(!!(x), 0)
+
 static volatile int zero = 0;
 
 int my_pid;
@@ -1628,4 +1630,25 @@ int iter_destroy_bad_arg(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp")
+__success
+int clean_live_states(const void *ctx)
+{
+	char buf[1];
+	int i, j, k, l, m, n, o;
+
+	bpf_for(i, 0, 10)
+	bpf_for(j, 0, 10)
+	bpf_for(k, 0, 10)
+	bpf_for(l, 0, 10)
+	bpf_for(m, 0, 10)
+	bpf_for(n, 0, 10)
+	bpf_for(o, 0, 10) {
+		if (unlikely(bpf_get_prandom_u32()))
+			buf[0] = 42;
+		bpf_printk("%s", buf);
+	}
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


