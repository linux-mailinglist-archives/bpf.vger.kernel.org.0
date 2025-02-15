Return-Path: <bpf+bounces-51651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB2A36D90
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62BA47A4353
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A470B1A9B2C;
	Sat, 15 Feb 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQMhKPsl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADC1A7044
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617475; cv=none; b=IvqzJm7xGwLAT1mA1arUQPonkpF0/yDvysrgvgzKu/NSXxfCScmN12WtkabVEXqt2aacp0BHtU0oSooxRKO2lnqv+RJ81For0b0VBSrn68i3GEUojSvQrpeusyeCQ7myX+UTpoZMmz+pOHzatv64BIfiUggfvEL443hC6hP+AHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617475; c=relaxed/simple;
	bh=E7j3SOAv9uvgPzCiplw3O27KVBB/BmeGa6ttCeKsplA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UESCpfjl2LnmDd4YFc6LPGVZyP/BCODEvY9M811tN1mUK7GI7WL5g1bSd0kVBWJCtxQCR8EKOqKTJZGoxdVPY3Ek3NRbPnJ5WX2NCbl8HYFYdMB19tWm3AeZfeTnQZwkvQZJO4DzaTXPpdCcco8o7C1hYzGD+0eknqj3x+b9bb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQMhKPsl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-221050f3f00so8519105ad.2
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617473; x=1740222273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F77Gcm2L7f+gFRYtZxeBSlP72OFg0lY7wRA0PQsfy1w=;
        b=hQMhKPsl6Wr+zK3oeggAXc+hJ0tgeeEWb1507Ywxh6ydGPxaTXyKGR9Z+Tn2m07n8w
         XES7j86dGH9w6h+YJYFblp7H1UCKj/oeqIlZt/IODrwVluEcJCZ5BRrySm2iYP5Q3GOc
         3iX3RGW3pJBq0krP3W4xOvFeOrt6ybXORUqickudEeS1HZqm9nRslV1ptEf71/XtFnGp
         LNJpDHCMOsZw5OP5jHuBwjz8ySk85DYk5n33czLJZbnZAyTTB4m6QaOywgrJL9aR+aYe
         DuS3ANKhHjU3IXiRXiwCTlf+Izux1Z8URtUrNxwYOtT2x7TqGTWKsubhjBj/XinFQFEP
         yQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617473; x=1740222273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F77Gcm2L7f+gFRYtZxeBSlP72OFg0lY7wRA0PQsfy1w=;
        b=WAVkEXo8vfkYn8xFUbN19tlVzcI+FKcdL1Slhtw1secltnChtbDYe2rnU1y4HC8aXH
         pyF12VPgldY8hdWjqEXQwjpCTbMUSZNISICd1rU9bDeP8BtH9kHP5B6Ti9JgukBGsF/O
         BHWNn0CtJFmF0LU0/jG3zWQ2HjamLhogXWvAmUK2dLDiBHkpOMCHRj2/F7rgoyfnJBfe
         dS88H2MJY6Fr8afjNt81+OdA7m+6G9l5ibma4jlTFqNFNC3QIvT5ESgcxZDf5affqYfM
         DINU8cuzgYQ8b77FVYEULzCtRAlyPenCac3H9LiTqXFwbIUQc6O/oR6T4G6sv/8uD6kf
         mWJg==
X-Gm-Message-State: AOJu0YxHwOgaaMkqydQ6J3kCu5lti7/Z5vLGyKcH9UQrKCCpsRZVTYZU
	O7kvDGQy9rSHhJX3dLbKAKaQdlHCNXmxvXgLAeL+S5fGhpYqHKv15BX47w==
X-Gm-Gg: ASbGncsG0iSikPi3L2PCSs1JvpN/ydhlwDioYncyuptA7/mPKCRlcpQPXUcMLfhJofM
	xeTFsclSW/ga4Pt9pb828TOf47fLxrirr/wDQzfmvTmQG3J22h7xXPMO4ZSrC31qE9CRgidGyKp
	sJXABHnkYiHmR8+5PQERSjj8/DaKkE2rj3rDS+y9VtOdgKWxwpxgGOGbqKKCuGc8udfulZQYalj
	jlgHYVJyDIcAAKCqVbxR4R4sj1fYBGW/r1Lz9ilB9Qt+P2X3IP/H+P/y3cFf1ttbCxRO/kQ1P4k
	iwbvPgc2j4s=
X-Google-Smtp-Source: AGHT+IF80Nyjt7jz8cLtIibs2kYG22h214fi8iXqZEYSBJg1DTvldSwhaBmfzq9vge5jtIkvqNVASw==
X-Received: by 2002:a05:6a00:198c:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-732618c1cf1mr4111530b3a.17.1739617472768;
        Sat, 15 Feb 2025 03:04:32 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:32 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	patsomaru@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 04/10] selftests/bpf: check states pruning for deeply nested iterator
Date: Sat, 15 Feb 2025 03:03:55 -0800
Message-ID: <20250215110411.3236773-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215110411.3236773-1-eddyz87@gmail.com>
References: <20250215110411.3236773-1-eddyz87@gmail.com>
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
2.48.1


