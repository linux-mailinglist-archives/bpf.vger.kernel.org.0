Return-Path: <bpf+bounces-35825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C75D93E376
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 05:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2BA1C210DE
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 03:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8777470;
	Sun, 28 Jul 2024 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6oUUPR9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8E29A1
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722135706; cv=none; b=H7nSHQuBiMnXjTVQU+rMhRK/XP1S2iINC8OFfwrsm697yud+83sqh4Vv0dYkOWMNDpFrxu1bOdGMOJLoQ6l/di3yOrbiDBs2dTcHKuVjpANb/Gz/EaxGEc+eqyZtcU0yHxZ5bqij2usVpGnFRT2VhSRwCQn9bS/ro4YVH8dQDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722135706; c=relaxed/simple;
	bh=l1P0twASE3WuDsB2Wzvp+isvEb4480jvH/gplhPlzvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpv7H0Q0a8shqkwgElSNwuW7r60R8RAyhbRBwKMhnPmMb40AchzsHvw0R0dXYCEBMoCH6BlayZO7V2DLK21oHPh4u1SEPItvmAaFLbAFaMG4Bab35IWDFdSVPn8OSYCjyZXjlBwWfWt1OPICz/l+RvfTVJeCTv1Sk02SX5azNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6oUUPR9; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45007373217so8611411cf.0
        for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722135704; x=1722740504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2T5ujHD/71naqt6MOMNh2CUrH17Rdn5Y7KDIc5IAEQ=;
        b=m6oUUPR9aZoizxXezYMtTxhapWgDibQ6faM+F9umsh/8wMEy77dvQBS8xOG/DnO46p
         h4BXNgvZmZNKJFIAP1bZyDOc8jpll6x6i1IHQ0eHMRmaL+WF1gWCAGNZa67wwa7eqFFt
         XXcMDy8r4tnDT/lWGaVKnX7EbP5CmksQkSuhRc1u68B0ZCF0r3oVEjn9SxTVcL34zMaY
         siOnGXmJhfyyb5NYgX52iss7U3ZfM5xM6cUKqsU+hXKH3kZFNrRUZloOSdRU9c3Xelzw
         xUtqPdhA/ke2SAlJk2yFTGcZs/qkpuKfF3LIjMnVNNDmMTzNVtg/seD0GGEsU7KBMqNx
         BFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722135704; x=1722740504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2T5ujHD/71naqt6MOMNh2CUrH17Rdn5Y7KDIc5IAEQ=;
        b=k8Z4PDMhwaDvfYDHURnDLH34bKy72YPGmDyJBKqru67zoxEiNflvoYCaFoKtRITy5p
         nt4kEV8auaoCAalhQcNT8x1vWyh2qAaXbO1HWvX/7N9hf/HPAWiBonj0RVN2IrNCD4ot
         MEppAwflEOnL9F6f3tOUJPiCITegkh/xemLwzVVa2JwkLkqZPE4xCNa0dQiK1ALY5nS1
         q/J6nEvakigdPQnaYjEs00MvfAue7YOB+Qm2LWsp0ag82W/9G/LfooPwFk7THw0v7m2r
         PvK/OTTOqqD/IhCioKQ+7QMBy80OyuXQxXkuXHLZ/xipyJQ/0yIwFZtU9PQL3XspGGYK
         KjlQ==
X-Gm-Message-State: AOJu0YxhweCzUqpC0YCbl4jI9zNbQkl26V8gUi1d5TY9vUHQAsOuqRfZ
	DJh98r7vmYffxW8aYd6gb5ylqGnM9xNa61mUAB48U8np4HvpNDyq2x2CBw==
X-Google-Smtp-Source: AGHT+IFkgAndNHAVdHYGQqo7pkj6/N7a1+X8RnO1k5kunXA04xdO9SlXXE2FhBYxrtriw3ZQOwRIgw==
X-Received: by 2002:a05:6214:27cf:b0:6b5:2aa3:3a7f with SMTP id 6a1803df08f44-6bb56353750mr68108316d6.20.1722135703663;
        Sat, 27 Jul 2024 20:01:43 -0700 (PDT)
Received: from n36-183-057.byted.org ([139.177.233.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f90e7b9sm37953306d6.52.2024.07.27.20.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 20:01:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v1 bpf-next 4/4] selftests/bpf: Test bpf_kptr_xchg stashing into local kptr
Date: Sun, 28 Jul 2024 03:01:15 +0000
Message-Id: <20240728030115.3970543-5-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240728030115.3970543-1-amery.hung@bytedance.com>
References: <20240728030115.3970543-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Test stashing a referenced kptr in to a local kptr.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/progs/local_kptr_stash.c    | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
index 75043ffc5dad..a0d784e8a05b 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -11,6 +11,7 @@
 struct node_data {
 	long key;
 	long data;
+	struct prog_test_ref_kfunc __kptr *stashed_in_node;
 	struct bpf_rb_node node;
 };
 
@@ -85,18 +86,35 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 
 static int create_and_stash(int idx, int val)
 {
+	struct prog_test_ref_kfunc *inner;
 	struct map_value *mapval;
 	struct node_data *res;
+	unsigned long dummy;
 
 	mapval = bpf_map_lookup_elem(&some_nodes, &idx);
 	if (!mapval)
 		return 1;
 
+	dummy = 0;
+	inner = bpf_kfunc_call_test_acquire(&dummy);
+	if (!inner)
+		return 2;
+
 	res = bpf_obj_new(typeof(*res));
-	if (!res)
-		return 1;
+	if (!res) {
+		bpf_kfunc_call_test_release(inner);
+		return 3;
+	}
 	res->key = val;
 
+	inner = bpf_kptr_xchg(&res->stashed_in_node, inner);
+	if (inner) {
+		/* Should never happen, we just obj_new'd res */
+		bpf_kfunc_call_test_release(inner);
+		bpf_obj_drop(res);
+		return 4;
+	}
+
 	res = bpf_kptr_xchg(&mapval->node, res);
 	if (res)
 		bpf_obj_drop(res);
-- 
2.20.1


