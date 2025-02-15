Return-Path: <bpf+bounces-51654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E06A36D93
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4AB18952AD
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152421990B7;
	Sat, 15 Feb 2025 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdtwdkCx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D71AAA05
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617478; cv=none; b=kGM7lVq7vw+0Pus5P7ngUpDEZbiQuU7YiCYgB7faO4JIhm4S6AsTA1BdXDUlBohV2R0I2MFQz/uyH0cA7rMwlBmkXsMq74rBqA6EErIeZmFK9oMF4Y8TZzFHwgW911uE3qOiPMSXdP3r+19vf8BgrVaeJCBcpNg4TrqxRwZnIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617478; c=relaxed/simple;
	bh=zW8+5TENzAvCSmTbURt8vxWlBzCtY0nYAdZoNcBCKw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0Dg4YRTamBNscPCl1GPN0sJUy46p6TT2ff1AV0xTxe3iEImlBdwSAiqPCk4koAg1pgSfXeET/zLI3bW8mAK/kx8z3Tu8AAuFo6u4K+1l11pBFDwarv7zBQmA1TLSr6NRQOjmTCJeBjEP+1xmlcPFpBQ/eyLikEaD1qIUV4rLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdtwdkCx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e6028214so43940425ad.0
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617476; x=1740222276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+bl+eqTT71k7Cy8xTV2OMB4wPPQcmIs2LMmUf+rGFc=;
        b=PdtwdkCx2f3jUjRS/yjV2TniVpCV9DXTfW/cQVlKz3mmaTxJAzY/TsGxPKotYVozTX
         Udhh9ce33RLKtLeoXO7k8UyKjFUlNIAuLQuE0etyz0ex2/nVH0uXZ3hWcjFTrEN38iD7
         T8RczHYIkIP69KX+tK4362RbCaMM2URpESCbTd9/6HOZ7SoUkxXHDQH87w1/3J1vgA+Q
         BF4YdOKnwvlonDqqt3Yaw082EOu2SJ5DdAqO/XHdARSW5tWBjYXoWbML1kcAhfD9JM5m
         92q9OFbVKitL3aEFLNyQ/KkBTfgqmIe4hnflrqSFPRtx0Woszum7iBqZsEvvKzN+/fvZ
         WVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617476; x=1740222276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+bl+eqTT71k7Cy8xTV2OMB4wPPQcmIs2LMmUf+rGFc=;
        b=QFDSI8VMCGWskI+Z5NrvRPs/JAtiOx01/hDfJ9I05JbzcWGOZ6cCI0JQmFIVHPicUS
         yOmCIhuTf3xu1RzGZE0HCmQ+GtKO5Zi1A7TQnNLdcGTj6zVB2VkkP9fY3XFgX7Xp7DT5
         l6DhP1sU+SgLtfHdlkSaaSMzRRxRlgTvk67CGrnen/Jql3yqRo3/Y2N6M8WALv+TutpU
         Neup7hCPRuGIuGUGohTVoeBFgxhxzUEGmcpM58cSyH/Lcm6s244H/PhdqiYDbR72lMJ+
         tNLsDd2BRJlpoffUKrp+lXWR9eElYtq5J8CBjNWII+BgsYJYhiDScfQQnx8nIIjNUfa9
         KNlQ==
X-Gm-Message-State: AOJu0YwTTGpmLOHa3Kn1gWgjl6ZzwiryTzoS20DEB/6yM0pkru/fqhiO
	CY+v3k4J25eKqvWCrHI2lNBsHTxBhZVHlsYEXE5tAU4h7gcLMLfV5Y59Cw==
X-Gm-Gg: ASbGncvKFu7dSgxX9lA8dp8OEG+BTAJjgI1q0OFEV/mq5R8Wwkr6TjC+COBto5WffHg
	hjryK5aIlMP93tWnNqaY2jML1bnsV5Vk5/H1wTpsfjVG5curU1u01E0TE/sdnWy1UdJBX5phWCd
	aL1U4heABoAxOqx2iZGhAUa6en9wFKakJwc1LdpLu5sVl7w2Lt/ZG9LlirWSm4GSUn00ScQeNqY
	gMu+VkUu6n+6PPBHOPwTXmK8yhCPpKaMDq/4/m686BMXGzph3wjxf3T8jzH/1Usmvrh3Xj92cYN
	QAew36CF6oo=
X-Google-Smtp-Source: AGHT+IF5xSaFP4uk9kfHqmRO+6ik1V2ezCbpf/X+GjHmbQ5SFQVysU0bq5CMeOjBdx5Ls0J8sUVLag==
X-Received: by 2002:a05:6a00:2351:b0:732:564e:1ec6 with SMTP id d2e1a72fcca58-7326193a7e0mr3825641b3a.22.1739617476075;
        Sat, 15 Feb 2025 03:04:36 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:35 -0800 (PST)
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
Subject: [PATCH bpf-next v1 07/10] bpf: do not update state->loop_entry in get_loop_entry()
Date: Sat, 15 Feb 2025 03:03:58 -0800
Message-ID: <20250215110411.3236773-8-eddyz87@gmail.com>
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

The patch 9 is simpler if less places modify loop_entry field.
The loop deleted by this patch does not affect correctness, but is a
performance optimization. However, measurements on selftests and
sched_ext programs show that this optimization is unnecessary:
- at most 2 steps are done in get_loop_entry();
- most of the time 0 or 1 steps are done in get_loop_entry().

Measured using "do-not-submit" patches from here:
https://github.com/eddyz87/bpf/tree/get-loop-entry-hungup

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 02f60b8683b5..3c3f33d90fc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1818,13 +1818,12 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
  *   and cur's loop entry has to be updated (case A), handle this in
  *   update_branch_counts();
  * - use st->branch > 0 as a signal that st is in the current DFS path;
- * - handle cases B and C in is_state_visited();
- * - update topmost loop entry for intermediate states in get_loop_entry().
+ * - handle cases B and C in is_state_visited().
  */
 static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
 						 struct bpf_verifier_state *st)
 {
-	struct bpf_verifier_state *topmost = st->loop_entry, *old;
+	struct bpf_verifier_state *topmost = st->loop_entry;
 	u32 steps = 0;
 
 	while (topmost && topmost->loop_entry) {
@@ -1835,14 +1834,6 @@ static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
 		}
 		topmost = topmost->loop_entry;
 	}
-	/* Update loop entries for intermediate states to avoid this
-	 * traversal in future get_loop_entry() calls.
-	 */
-	while (st && st->loop_entry != topmost) {
-		old = st->loop_entry;
-		st->loop_entry = topmost;
-		st = old;
-	}
 	return topmost;
 }
 
-- 
2.48.1


