Return-Path: <bpf+bounces-64459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16002B12E71
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 10:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9648F3BDBB7
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731A21E32A3;
	Sun, 27 Jul 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv1tHGXx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3923B7A8;
	Sun, 27 Jul 2025 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753604289; cv=none; b=klk9ChsYy2g/dHehEZLNrcvlw2ZvMsIUqP7aBATtCaGJ13oWi+ZSk1U3TfenRAjhL8tNDMa1rnCXEqvqBzHReYKgQO66I33BmnErQMCYDZxZMT/hn9rmEx3gd7nx+75d75x/FQ3ciGH0BHq9FnKjNxJ5nDWX3S5doICsfKV6hNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753604289; c=relaxed/simple;
	bh=h2x6vdv/JzyV9NCqHup4antc8GUh2Fc+FuFK5KC/RRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QM+WTRgDBCYADdnofoKS8vI2sTB7/gPp/zAvdZOFxN7mOO3vLJOHekZwiicBJdSZFFyLsawdoH6+RrwIimvieE0FBBP/04qVqNDCShEHI/ExE93JZSmRVZNNT8mCbFje4AXF/9VVJnEPhmlMdT++9L4QDb/ngNaWmZrrjUuKUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv1tHGXx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-749248d06faso3011291b3a.2;
        Sun, 27 Jul 2025 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753604287; x=1754209087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4w3nvIifgn0iSMKuiOg/hmSn/FEUf3sNnbRx7riRRJg=;
        b=Lv1tHGXxpGsHUh5ZlxkISH1rSrnfCGqikTKZS1kd7ZsiVlebGCzilHPHDyQJZQUaxQ
         RJZKOVSAV7RRjsvcTqbeNo4eONRa2lryZHZ/h0tTnZoqRfP7xGRYzoeBuKheGLi07dxm
         EHXqgG1xnJFTeSBkg5oNphtSt08TS2hYjbaeCKu/7Y+EApV9GfmP6Bh7h6GEwKjDEEd9
         03JUK8+6OErKaGoYTYeIqxMK3JMwRsIr0y91jRtF6mK5FgARKw+QqJf2VaADSVtyX+qo
         YLw4Lh6kqLzym5UzGNVvoB4dcQv9CfgDMQl9EIh+y9ScLCgaAvpnG5c21k18DP6RLei6
         IH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753604287; x=1754209087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4w3nvIifgn0iSMKuiOg/hmSn/FEUf3sNnbRx7riRRJg=;
        b=E+eSLcoOJgPs+oUL+rR30YgG/JzWanc1xDhRRdEVroIwWYkeGyJli9tI3QDMjdcgGK
         e7lBmW/wKrIdkSUUc6abbwqPxAg+bZGZHMamQg3lVGRBovKXoV1sgqBvtKxXvT7x1tQc
         PFKy+9hbgoGvNUDrJ4RQRlOk5dbK5r0OUJyuBsEAgMlvT5f2WNeXdg58xS8iNZ6/sQ1X
         Cc4zFway80EfAUcsjlxK1Rp3D3EUuPZ7f5tIjBzUxBT773uzU83BkujeRqjmodDgfUQO
         hMf6xKpgA0mHB5xbHbx7N+9ZL6Xid0+tvi51V8OGj6BuDw4/95e/+te/QXQDKU34/flt
         zf7w==
X-Forwarded-Encrypted: i=1; AJvYcCUMbY7df2/4XW07HOx39wNyyadnPEi7BvggCSI4SknC/3LxMXg6xSEFry8i4j//6tq2ieY=@vger.kernel.org, AJvYcCVJCU7fyFCvWrXK2OydGiXR7OeCGYWzLYXZkYiNwk4/MC5b0AHVHLoAZjpu0c/kkKP4I6WhrAJkN9z6peh8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7fFlF//qlvW9CMzS2Q4sJ1MRlO3OvoCabymzX3o+OZ731gBx6
	hMmPcG3p6VGpihVbXmnHsa+CMNTqKiow2AXabnF56XQk04uz1rPmMO/b
X-Gm-Gg: ASbGncuInCHbAbaxbGdYJGlWQnfPnqO2m2epzgRn0lOTvlQh/sddWYdOyc/1gEnqZyi
	oRKrCf+qNYckK9CZQPsTyHBjnF1i3xHO/wRiZYWLW/32i4cdNhGEvQaCwJsb9jO4Vsz90vhILY2
	cUhyV2DhH4AI2T3MGF5w49YuoS9YAqmFG7uW2ta+Uw3aHdeuUfpZS6FdNWsYPNUTT49SyhdkaT+
	bAD1xzA9ePYjeeWVZDMAvjGR8/Ue7mHEWLhVmuiqp1uwo4qj0rQBs7L047usekEjncDcFrAR5Ut
	x1A612vCbfabywjK9/Sd8H5FSDr/VSsNicVwWMiG4Uf6Sld77XzlhcSP5qzzi17C/DyiRPutRPv
	IB3tr+AuuR/Gybmv2iJ7Z+RO3wEAk0cg=
X-Google-Smtp-Source: AGHT+IERtAcA1hASNVnSuyLgCZuySFIDgpHVod4VMFHMhTbjWTMV5KfmnnO/eqKIF5S6h8aYQR0OlQ==
X-Received: by 2002:a05:6a00:1741:b0:736:4644:86ee with SMTP id d2e1a72fcca58-763343da65dmr10726993b3a.14.1753604286599;
        Sun, 27 Jul 2025 01:18:06 -0700 (PDT)
Received: from archlinux ([205.254.163.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640863503csm3085296b3a.5.2025.07.27.01.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 01:18:06 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] bpf: fix various typos in verifier.c comments
Date: Sun, 27 Jul 2025 13:47:54 +0530
Message-ID: <20250727081754.15986-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several minor typos in comments within the BPF verifier.
No changes in functionality.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 kernel/bpf/verifier.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..4f13cce28815 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4518,7 +4518,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
  *   . if (scalar cond K|scalar)
  *   .  helper_call(.., scalar, ...) where ARG_CONST is expected
  *   backtrack through the verifier states and mark all registers and
- *   stack slots with spilled constants that these scalar regisers
+ *   stack slots with spilled constants that these scalar registers
  *   should be precise.
  * . during state pruning two registers (or spilled stack slots)
  *   are equivalent if both are not precise.
@@ -18450,7 +18450,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 /* the parentage chains form a tree.
  * the verifier states are added to state lists at given insn and
  * pushed into state stack for future exploration.
- * when the verifier reaches bpf_exit insn some of the verifer states
+ * when the verifier reaches bpf_exit insn some of the verifier states
  * stored in the state lists have their final liveness state already,
  * but a lot of states will get revised from liveness point of view when
  * the verifier explores other branches.
@@ -19166,7 +19166,7 @@ static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx)
  * terminology) calls specially: as opposed to bounded BPF loops, it *expects*
  * states to match, which otherwise would look like an infinite loop. So while
  * iter_next() calls are taken care of, we still need to be careful and
- * prevent erroneous and too eager declaration of "ininite loop", when
+ * prevent erroneous and too eager declaration of "infinite loop", when
  * iterators are involved.
  *
  * Here's a situation in pseudo-BPF assembly form:
@@ -19208,7 +19208,7 @@ static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx)
  *
  * This approach allows to keep infinite loop heuristic even in the face of
  * active iterator. E.g., C snippet below is and will be detected as
- * inifintely looping:
+ * infinitely looping:
  *
  *   struct bpf_iter_num it;
  *   int *p, x;
@@ -24449,7 +24449,7 @@ static int compute_scc(struct bpf_verifier_env *env)
 	 *        if pre[i] == 0:
 	 *            recur(i)
 	 *
-	 * Below implementation replaces explicit recusion with array 'dfs'.
+	 * Below implementation replaces explicit recursion with array 'dfs'.
 	 */
 	for (i = 0; i < insn_cnt; i++) {
 		if (pre[i])
-- 
2.50.1


