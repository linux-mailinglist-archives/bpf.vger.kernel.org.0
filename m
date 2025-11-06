Return-Path: <bpf+bounces-73848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE8C3B0F9
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC8D34F90AC
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65D133CEB0;
	Thu,  6 Nov 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfbcxNqy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF2338F39
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433627; cv=none; b=FV85GXOzJOJSBjIgoAIsXVSwI8Njdq+F70R9N5Y+UnnQJDWs4Cu8pG5L32IujjkwUPnZUQuXxmnzka0GcahvMZizA5DMvMpzTel7bWG4QR/Jg1In1Xg3pVHQO/+pUUGWisj4Kdzr4h8mBTaJcbs0bZQ435keAq0nsOg9ydBL2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433627; c=relaxed/simple;
	bh=ic+gOBYrHkh39eOmG4GQwcvbU3ifr1hE78B2se07zwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OtcaFT+ZoQxX09eb8Q9qsEhQ+AC/rBzN45d1GPh7WS8yTjPhN1FkUVG+IQTet/0T5hm8rYPvwoxvcqvJToWxTmtnLa4Ju/JjAmS+dg5qtaL255OVf6TndQyTKD6x+eF+luBy7MdvfFA+Xcb1wWSl7M0i8kX1yV1lEfTOqwmGtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfbcxNqy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-421851bca51so768844f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433623; x=1763038423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BVecavUPRiHXmHkxwJOxXNf9imfUNAzPBNe3t0kkm0=;
        b=nfbcxNqyWvXuIrAjO8EePloZWZV6MsKkuS/ZeMGAkF1/D06PnkqKC3LNwC8zZI4Ccc
         PvvWlPieXlBArGq5dVl2OjRNraIZHb+z6JbslivOJb95VJOAtRxyCepZ4GGZC2hYkdtC
         Rhlbva5ZjJ1T290lpl4mFaIQbYI9HhgQQM71c6j5S2ab/aFyL/uVFCxZYakXgIg36QL0
         yNvMX1lMpcSbWG3+zsw1ISFlXsGcMDD/mq96ih/nkQrP00AN+lyzxBKJfnXr30aQ+ukW
         cjx5vbD64IAvjC2dxuSLv5B5o/266trnOrvRiKGYMy9+9hPOJQLS/49i7zGfqNpggcDS
         vIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433623; x=1763038423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BVecavUPRiHXmHkxwJOxXNf9imfUNAzPBNe3t0kkm0=;
        b=s8yHpTaoUkEHf5DvoA1AGiUx1zXGxsALSxkhvWVz/cHv8MZ73NdcBSdxF7Q0bnM/Fy
         c29YlOijqNpZ63sSvkViD1LT3OzZ81ZLgWL4eRwlNYFO4ZDAV274I3MhHR5FreHpUd34
         2mi5gkdXHZeBj8XWalejYodT2pPd6FhubxzpHx1059ED9pEZAtxZCB6e6juOu8su7EE0
         3aCPW/tFowIXkpwE7byw3dtiLd7L1Cwr9XzlLzYpzhLUYDTky0CjBAlbvPKajumxAsA8
         ksQ0nrJkvsp9gRfibPl1rD+pxd3TxGgzU4akzfUqJezRVukajJEuO0WuMh56G8xjIOYz
         S3uA==
X-Gm-Message-State: AOJu0YyCZ+tOWTh3ID59lpcWQMr4uKn15qACrkXbHdRm3Gx+JVsDW8Jw
	akjmz7MFsxdE+SGvX0UftHyItwztq6xL0PRXmwJK6qR+gCdaWnRUq3u8UP96
X-Gm-Gg: ASbGncuDOf7VaEK+yuHU1fPthnU4whlOOkuw+MRorPiuVv4ED4PJ2zEPTW9YD7syJAO
	Sl5+zp+8ca65Qw6huN5UMDIultqgcVbiA8EKQUYbTFBQkW+jbtQbcIisHDApQl9hUO5+AyZaqTS
	KqlnhAtxGWrp3yPh+AlJm5HTnlOxRkcAn0OS0nMVGgLoZWl3kjsiUWtsA9QTi/XxRthmnYky8iG
	6hWN6pyMQcPQLE5bsoXkcemIfpnDTetbM2O0cEMVaZCKbIIK9VV+h/5nM4YOuc4Me2cxu38dL+7
	VJ7Tzlso9pEHH/KSn7CC47EW2HpbQ2seVwxGpHinePKwT47zBHpwLQY6YNO5sdwew6PNd9f7XmF
	B/S9ZDYNVt31CE/EUUMGUcaJG2LtjRbq5eNuDgprdwHhrbgtVyNU8iGkRuGzzX1mHylHPhVqUhS
	kaLUS5TQHM8MliC/q4+U13xVjO15qh1rgszWt9aPRGyqFu9isi/l8KHyg+zNDMdJJZ8g==
X-Google-Smtp-Source: AGHT+IHyCbG6Ib5B/hxvhvU1M9zTmkq15fseYuID4g2BHydDK2L/8J6Y6qTfp+dgmtEKmD6926vZsg==
X-Received: by 2002:a05:6000:2502:b0:427:454:43b4 with SMTP id ffacd0b85a97d-429e330ab16mr6604348f8f.48.1762433623418;
        Thu, 06 Nov 2025 04:53:43 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:43 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 13/17] bpf: Skip state pruning for the parent states
Date: Thu,  6 Nov 2025 13:52:51 +0100
Message-Id: <20251106125255.1969938-14-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different incoming paths to the same instruction may yield different path
conditions; pruning by containment would drop paths with different constraints.

- Add `children_unsafe` flag to `struct bpf_verifier_state`.
- In `is_state_visited()`, if a visited candidate has `children_unsafe`, treat
  it as a miss.
- Propagate `children_unsafe` to the next state on split and clear it in the
  current state when pushing a new parent.
- After a refinement request, clear all `bcf_expr` in registers and mark all
  collected parents (except the base) as `children_unsafe` to avoid pruning
  alternative suffixes that may build different path conditions.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b430702784e2..9b91353a86d7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -422,6 +422,7 @@ struct bpf_verifier_state {
 	bool speculative;
 	bool in_sleepable;
 	bool cleaned;
+	bool children_unsafe;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f1e8e70f9f61..ec0e736f39c5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19904,6 +19904,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		states_cnt++;
 		if (sl->state.insn_idx != insn_idx)
 			continue;
+		if (sl->state.children_unsafe)
+			goto miss;
 
 		if (sl->state.branches) {
 			struct bpf_func_state *frame = sl->state.frame[sl->state.curframe];
@@ -20216,6 +20218,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		return err;
 	}
 
+	new->children_unsafe = cur->children_unsafe;
+	cur->children_unsafe = false;
 	cur->parent = new;
 	cur->first_insn_idx = insn_idx;
 	cur->dfs_depth = new->dfs_depth + 1;
@@ -24272,6 +24276,20 @@ static int __used bcf_refine(struct bpf_verifier_env *env,
 	if (!err && (env->bcf.refine_cond >= 0 || env->bcf.path_cond >= 0))
 		mark_bcf_requested(env);
 
+	for (i = 0; i < MAX_BPF_REG; i++)
+		regs[i].bcf_expr = -1;
+
+	/*
+	 * Mark the parents as children_unsafe, i.e., they are not safe for
+	 * state pruning anymore. Say s0 is contained in s1 (marked), then
+	 * exploring s0 will reach the same error state that triggers the
+	 * refinement. However, since the path they reach the pruning point
+	 * can be different, the path condition collected for s0 can be
+	 * different from s1's. Hence, pruning is not safe.
+	 */
+	for (i = 0; i < bcf->vstate_cnt - 1; i++)
+		bcf->parents[i]->children_unsafe = true;
+
 	kfree(env->bcf.parents);
 	return err ?: 1;
 }
-- 
2.34.1


