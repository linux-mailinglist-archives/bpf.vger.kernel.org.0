Return-Path: <bpf+bounces-68894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C9CB87B83
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FD7BB78C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19826F443;
	Fri, 19 Sep 2025 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGvFB3p5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5027147C
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248350; cv=none; b=RObAA7JYOmeuVWc0p2vODnyxaxVc2aoyl6c9+B3f15xyeXPK1CHQ8BG8+wZp4hUpRVq7EpwJ8v7XJJeWW2B3aE8H6sFCtPBOKPJc9YtAGFFASnb7kP7tLC7yx6hpz576Zk6b9uIQLkdlDB5gvixYfSm29vgvDCIV6FZ3lDbtWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248350; c=relaxed/simple;
	bh=Dh7wQS6r+emcA7mBC5levC9TCApeehbrn1o3g6mkP6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roQxLBpIe9J6WXWhW89CnhQ5QnHEqsym29njgG3pJMUM7ZvksPHXTGdJYp3c8eT/Y/JRHvgvNKdH8BAkJp+8IF5n5DaSndMKJsXWGrwo78cNF+u44oL86lWO/evJ5w2tTjA96F84oqAe9I/Ncf31dWb7baGW5PdRAvopBAckNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGvFB3p5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b54f57eb7c9so921605a12.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248348; x=1758853148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX5sSlhOXybEh1e3svCyCkgCHzTuYeQh5qcCb/Vw4vA=;
        b=RGvFB3p5k65s432Z0f4V+1TnjNmd61eXcIFEmn8pjKX05X9uKDaqjWvATJkJ1AlZ6t
         VveRN8Ti/0WyUMqlJ5FKUHO7RDEytWH14Q2yRo0F8dS1lM3HeH4hue8Kn6ZauDozPqad
         1BN1GzRNUWhhf5jAUgmyHHNyBQHg/DPCz27sgMOoS5HLi42rlgYlkFmxbyWMCEp8QwHH
         XGYXDySm7hqmY2d4v7v/l3UH3as8gMAJ7igyzLA1On9H/9+B8WhpMEDjV9wkjbudUYkC
         1/K8Du9MTbF4hwfvuW6xhAXnNQiNRHpxI8Svx8ekVR+P/kegLpGZPdIUWq6DDOZscaFZ
         fMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248348; x=1758853148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX5sSlhOXybEh1e3svCyCkgCHzTuYeQh5qcCb/Vw4vA=;
        b=i1b0MhgEoACuCrf9X472nWNwczVDGl97e8CNkohznFiKdXcG1oHRCVp7HgT4QTA6iI
         6KZy905EVY94y9s9okBusvghRct2ZpfZIDs/NihUDEJLqiLQnI6rqmYuAwj/+/ZCU77R
         bsxprUwEwc5jsZTCgssbzyy5znCYvDEOQanp5t78q7mghK5vdcd9whRftWknOcIBnZIu
         0EHu0MUJyDneIYE/EsrAzZTdOYQxXF7Ly9edtKAvFpmJdtStcylSmCVyYsOufYV+cgum
         ROHUM22NtI6/tDSADbORHVs+FK4gZtCtdIv7aElYDNyamOhFX2bLrCEkXCvGNx5R53Hy
         +20w==
X-Gm-Message-State: AOJu0YyrVuX94tplQB5PIeg3ZLTP8K4eGD2HxT0BXHPKNfFXNyCEaPjj
	knuWq1AVq29pK4fujGUU9tXCFCv2stcPgrDFJZEVuMO0/iZqABgtSrSsJpDI6w==
X-Gm-Gg: ASbGncvNQ3BFRjhfO93kyUFOfkMcPmCVLnS5D1h31WULVe8PEzOiYFzKla6cLu1Ng6V
	LWe0f88EQnjCm6P2Ydm3GRzNwgNPTEY83fx8E49vevKNFXXlaKh73yrN1MHspbzNmHbjlDHrMfD
	Oo9MZKNg1eyf2kMn1EMghMV2G6Ahh3QcO5rdpaQBv3KMyq/Kjj97dNW1cHRrb1tZg0Tq1Ps0OWh
	0QHjmryhaVygTk6IEs72I7fIqkndYdSsy8hEBoISmOQlRkK9HnxoZSzZfo2ER6dUjULw9DOluIU
	H0INcqqfNLy0X55Mcx1tzKvK3fZ9w5TeYWF+D0b0AJa+dDk9gFWd7/rR+F0Oq6DJ/MmU7oXJv0C
	8gQlALYBrbgAVgaiy
X-Google-Smtp-Source: AGHT+IEl7bfG4PT0Qbk63WWJcQvVX3KZB1pq9K8UPgoZgQEv413vpQo7n8sj7tW/CbF1Whzfack/Bw==
X-Received: by 2002:a17:903:1b68:b0:264:5c06:4d7b with SMTP id d9443c01a7336-269ba51703cmr20153215ad.32.1758248347718;
        Thu, 18 Sep 2025 19:19:07 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 08/12] bpf: signal error if old liveness is more conservative than new
Date: Thu, 18 Sep 2025 19:18:41 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-8-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Unlike the new algorithm, register chain based liveness tracking is
fully path sensitive, and thus should be strictly more accurate.
Validate the new algorithm by signaling an error whenever it considers
a stack slot dead while the old algorithm considers it alive.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2e3bdd50e2ba46040d6806a0b6ac18124fcb6c75..dec5da3a2e59dc22ef3cb60407f82267cf5a2c61 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -852,6 +852,7 @@ struct bpf_verifier_env {
 	/* array of pointers to bpf_scc_info indexed by SCC id */
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
+	bool internal_error;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 991b5593a27708a49933a3cf3ef3aabe76862db2..568676e49ade206950cd1b4d17679f821b933cd9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18576,6 +18576,11 @@ static void clean_func_state(struct bpf_verifier_env *env,
 
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
 		if (!bpf_stack_slot_alive(env, st->frameno, i)) {
+			if (st->stack[i].spilled_ptr.live & REG_LIVE_READ) {
+				verifier_bug(env, "incorrect live marks #1 for insn %d frameno %d spi %d\n",
+					     env->insn_idx, st->frameno, i);
+				env->internal_error = true;
+			}
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
 				st->stack[i].slot_type[j] = STACK_INVALID;
@@ -19546,6 +19551,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		loop = incomplete_read_marks(env, &sl->state);
 		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
 hit:
+			if (env->internal_error)
+				return -EFAULT;
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
 			 * prune the search.
@@ -19660,6 +19667,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			return 1;
 		}
 miss:
+		if (env->internal_error)
+			return -EFAULT;
 		/* when new state is not going to be added do not increase miss count.
 		 * Otherwise several loop iterations will remove the state
 		 * recorded earlier. The goal of these heuristics is to have

-- 
2.51.0

