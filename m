Return-Path: <bpf+bounces-60381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C3AD5FDB
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290B217937B
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FE52BE7AB;
	Wed, 11 Jun 2025 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nokfRFhe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F512BDC0F
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672550; cv=none; b=LRcPxJURXZb6z0Cd6Jv/eNoFqMuIkzeAlbJ38qjW5WyrFZls0iSfCNyMA8aL/V8iKVPEC3z40He1qBtmvRuKefEWjo+43HgJLKZpA8B8aUzH5xI2pJkOVF8tQtOL/Tmo6SEsrWngMzhFlAefgYMDgxepnqGuoLyPI8T2YwGDrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672550; c=relaxed/simple;
	bh=qMjx8kF3q6XB16/lvlNH2U0I5etxEFsa+sGzN1/D8OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+WxqFbkWtl79o5fhAZA66i9PdNjYfKufpY5lxuFZ5fWUx9kEZsCJmJFiBk7W52DK2l3Nj8gq/CL7fnpLOTlUmRRetC8HG+Sae67ARplt+MKvr5lNI+0JpZNK81yYHW0CKHtbbUROE5eIKd5DKQ1Bt4+BHj9i2cktn394WXf3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nokfRFhe; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7086dcab64bso1809567b3.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672548; x=1750277348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E28mgwHcKzuP9l8sq34AysBoLhu+Qe2bgt2e7tJfhGE=;
        b=nokfRFhecPKJ0xxM1Emx53dBRNihVRNwwTdJZBb8yL9nATCD8oPDHNVqTZW3jasJIQ
         fQ2+NT4XdENtaL0gYHjI7Z007RI+tlxjSyinc2mCrzd7b7IcOlqGs4IN5F+vwDTvcf8m
         8ip0Hz7S1nGELVVbrfVT9LGy++j10r2Jr1FmqCXZt5mAe9Rbyy4H6RxPZOlSIGJbDrrX
         zIFXUGhHfzyA7fDt9m01ISehk0xRFNuLgr5uIqUPY4c6PLt1KmmlviC7HpqTMOjqscvN
         YFPzFsQ1frFN0SwF1c1JaOWQUjIluBg8w1Oy5xEgqhIarLQ5vWqLOrxz/S6ST0mr9Dnm
         VN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672548; x=1750277348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E28mgwHcKzuP9l8sq34AysBoLhu+Qe2bgt2e7tJfhGE=;
        b=RqkWAvaLJoc1K3ny/Y/Yj4QFxtjdR2q1pgvorsgjA3WOtHnBq8Yyek1H0pMAnmG7Hs
         fx3UYgVgtjS+fdyuMFNDJZDaH0rei9k1TcQEqR2a3Cy92kyWC1x0D0Pcu7me0y2yrXH3
         2x1yUUb0dkPPBiaxUFtyiHJsDsjzLDqszSsI25rVahSic2LbLUZOuVscRzABR9Sr4Imq
         n7MOU5Jx0oGRaJZ2p8wCLdlMBj8Fb2ANMtjX1FXXxdx2P8NoNJw0r1NKvZZgTZzdkFqQ
         WDZ7Fs1hv9Pvz9jXjY5lhjc4cvn9tqPMJTjXl5gDVNACnzgYVuhoyEvO6Fa24jyu4V8x
         bLPQ==
X-Gm-Message-State: AOJu0YwlBfD/PTQoBtJd2uEWRR89wOvELGCsGtrUcIxHf7oGoSepcNJ7
	HSHpi8FSiIKZJ/ji9hOyJ1HCB9rIkhlA5fmWWYm3XCQCwPIS+oyJXn++RQyzuFaC
X-Gm-Gg: ASbGncvrc2aTmW211OI9bbA7LRbYArQzn+r/DIl8zzPZlmFPYeav9/qP+Zj0lnSK3H2
	jWxJXbTOO7pqf7Rhxo4w3TPQLKs+BOHBc0te8qnx3Pd7IutP7YI20QtordKnBrn+iCB5FVgmW5G
	cn+/y7bkYKZidxgjnF6bJEfhX+7a50xj9hW+v3y6baQx/thwPUmBV3BG0gOO6C6nXn/5uxf1EZV
	eWVFp4VENP1ZRr4YAgid2Q+NNoyXHTum5E/C/HnyS1AWOAaBcTlWypl+xV3j5YRQco1Ez8koOxc
	5oB4MmW0VZHOsS0BiVf2StOHo/wf3VXCIV6R/jwHtETCcuG9Mfmf
X-Google-Smtp-Source: AGHT+IFVvJbvR4n8FAK6Zj0tKfcmItVn/yEU/GtZWIaPU2BiH6TGnnhlR313OtJrF9sewzbuYE5bsw==
X-Received: by 2002:a05:690c:3503:b0:70c:bb54:ccfb with SMTP id 00721157ae682-71150a77db4mr7718377b3.21.1749672548271;
        Wed, 11 Jun 2025 13:09:08 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711527b838fsm115157b3.102.2025.06.11.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:09:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 10/11] bpf: include backedges in peak_states stat
Date: Wed, 11 Jun 2025 13:08:35 -0700
Message-ID: <20250611200836.4135542-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611200836.4135542-1-eddyz87@gmail.com>
References: <20250611200836.4135542-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count states accumulated in bpf_scc_visit->backedges in
env->peak_states.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 2 ++
 kernel/bpf/verifier.c        | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1ae588679e20..7e459e839f8b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -733,6 +733,7 @@ struct bpf_scc_visit {
 	 */
 	struct bpf_verifier_state *entry_state;
 	struct bpf_scc_backedge *backedges; /* list of backedges */
+	u32 num_backedges;
 };
 
 /* An array of bpf_scc_visit structs sharing tht same bpf_scc_callchain->scc
@@ -822,6 +823,7 @@ struct bpf_verifier_env {
 	u32 longest_mark_read_walk;
 	u32 free_list_size;
 	u32 explored_states_size;
+	u32 num_backedges;
 	bpfptr_t fd_array;
 
 	/* bit mask to keep track of whether a register has been accessed
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 48847f8da5b1..1d3277bf935e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1648,7 +1648,7 @@ static void update_peak_states(struct bpf_verifier_env *env)
 {
 	u32 cur_states;
 
-	cur_states = env->explored_states_size + env->free_list_size;
+	cur_states = env->explored_states_size + env->free_list_size + env->num_backedges;
 	env->peak_states = max(env->peak_states, cur_states);
 }
 
@@ -1949,6 +1949,9 @@ static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_stat
 	if (env->log.level & BPF_LOG_LEVEL2)
 		verbose(env, "SCC exit %s\n", format_callchain(env, &callchain));
 	visit->entry_state = NULL;
+	env->num_backedges -= visit->num_backedges;
+	visit->num_backedges = 0;
+	update_peak_states(env);
 	return propagate_backedges(env, visit);
 }
 
@@ -1977,6 +1980,9 @@ static int add_scc_backedge(struct bpf_verifier_env *env,
 		verbose(env, "SCC backedge %s\n", format_callchain(env, &callchain));
 	backedge->next = visit->backedges;
 	visit->backedges = backedge;
+	visit->num_backedges++;
+	env->num_backedges++;
+	update_peak_states(env);
 	return 0;
 }
 
-- 
2.47.1


