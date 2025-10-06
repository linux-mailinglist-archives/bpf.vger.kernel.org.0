Return-Path: <bpf+bounces-70439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EF4BBF22D
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 22:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567CB189A6AE
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3651F8755;
	Mon,  6 Oct 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI9u1xzV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5371A0BF1
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780965; cv=none; b=pf6fpjeLkvNKBA6QP3qG7pTHKphUFqVYIH/J7PONRKsiztWqjKfJKKSmFICYnf4Pe+wQI7pRJ7kU2bdwUJRUHxSC+ZtiFJmditQWg2FylNRsNhi8MMs/ywWCQgsguZAyxRz+AWy5eafocON/BSlRAbMAwtgDKgfR09LTQmnEEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780965; c=relaxed/simple;
	bh=pt6uVl2va0017+usTJPtB2mgd02MUjIvG/vyseBfMA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQIUv/geYkPZs0PdDp7UI76Wp0Qr1SFmUpgvURhpGrGIWFoLnwfnPzCh+RcjUx2rO5kkKcLjXNbKcvkBeG8Gg2ah7dzKiEQPNXSXXqVaMVBkaDWNQ1BHqaejB4kQ8aOTYwV5p+2kO9Ek0XwUCxntUml3Ky9Z0uZb1cliTsbt/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI9u1xzV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so32387615e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759780962; x=1760385762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTZb7gvf4mYiD/+BcSu2mE9chUq77bafq2p8amfYPNg=;
        b=DI9u1xzVyYty/VZqXU82mD+v3Rxto4ceJhr7Nzx2Ry4s7HMo2LdUW1x64mjJ3jznMb
         C/PpPM5eZi53vdX82p78kZayJwz3f5UzWCrVS6zxr/Hx6OQ7oyxDShJ1hk7TFV4Ox19G
         UaIN29A4S5OEgtjSRULbVZ0cHC+VuWm2mBfF1mmn9cA6XESZ3HgJhQtNY85D81mBgbvv
         fEHPM1lemPB+AqH1+/orPuBqY9Nol8aFVCdVKw9LGt8yYxUqH4Q18Fber4cnfE5Gzm4x
         Kfvh9JFUyfwvevEb70C+2Ra8RQwfiG5VjpeKjiQaPRRr+wY6Oc/MdVq2OinWMvx+oEAR
         Maug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759780962; x=1760385762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTZb7gvf4mYiD/+BcSu2mE9chUq77bafq2p8amfYPNg=;
        b=SOqCwbmZ452ZtHJLA4qL+1UPic+TZj87rAncJv1INkx4vujP9QnCKpchJpsLsfd1jA
         xZ61NAenk+j+26Eyug9Nq2pRHjmu+22KeZDs2zk6ZpE4vLm/6baEO+NGQcRIdHEB81Ld
         Sh/OdOzTTl4Y8C9TO5DgjbdlbOHrPAStIgZyyauGRSHGPcg/bmZmE0pr2zEMGwWNOYC/
         QVedtNAsn2aad+pGsjLtGaEnVxwR5PW5wi/G9FOiPyYx0w55YeYWRCBisJlHXrUiI3BK
         wGE+uGBhjqQ2e2EEj4ft3L6bnyQICuMSiIcGI/FwxHuyWkddj5J0BBgsys6dx1aJcRVq
         PT5A==
X-Gm-Message-State: AOJu0YwPzTMkTvU+L4sdeji+4rOnl2nEUxVMi+qHcGSaueptTTE8YnR8
	/NMbwWIa3ZfzR9xD0gSwhwkA5HDibAk2Emye/n8bBDa5yzJ9rnnaCBTksm976w==
X-Gm-Gg: ASbGncuriuAUZTt/N9PfUh/soojmxw3hBST9fyKmdXqWGg2o99f/jW4RVDtY4Wre2pD
	RJmjqm3zH3fyQwebmSuDQHgkHQyMbP4XCeMaO/+2LuE5PVW0WU0fn9fvfraF1Z0qGj/1d+DZlSH
	OgXO9QGs+O3IBl1DvkcO3wBNQUzpLiZuwKQU6DhcGLwYeuSxy4UDaaI32qHiFWGdRWp4sJPtkZF
	kSL6zvpDTvnz5fAqb6zskD5VsEl3zVBNuQegU4MglrDAKCd/hyZBTzjTcuBFquK+hShFMfQ/bI2
	g+uxZy2Yorx5QFJo1e+iW3D19HgwNyJtwfRAhdiZHoeJtE66z5vnM6wjIv2rd2yZt08/g8AgeSd
	x4iX8AIEu1+KZANtKXjUjV8+rXVW6S0uVOIxdd/ZVSL1hXTSWSmNC5nZv
X-Google-Smtp-Source: AGHT+IG4W5w5yHkvM/imk8FILbtkt+RvteBW7EreUxZNdIszsOFz1pM3TLB08NNtwVqqv2Do9l6BiQ==
X-Received: by 2002:a05:600c:680a:b0:46e:42cb:d93f with SMTP id 5b1f17b1804b1-46fa26df6f0mr6702145e9.15.1759780961534;
        Mon, 06 Oct 2025 13:02:41 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a022d8sm257564135e9.12.2025.10.06.13.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:02:40 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 1/3] bpf: verifier: refactor bpf_wq handling
Date: Mon,  6 Oct 2025 21:02:35 +0100
Message-ID: <20251006200237.252611-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move bpf_wq map-field validation into the common helper by adding a
BPF_WORKQUEUE case that maps to record->wq_off, and switch
process_wq_func() to use it instead of doing its own offset math.

Fix handling maps with no BTF and non-constant offsets for the bpf_wq.

This de-duplicates logic with other internal structs (task_work, timer),
keeps error reporting consistent, and makes future changes to the layout
handling centralized.

Fixes: d940c9b94d7e ("bpf: add support for KF_ARG_PTR_TO_WORKQUEUE")

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..b2d8847b25cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8464,6 +8464,9 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 	case BPF_TASK_WORK:
 		field_off = map->record->task_work_off;
 		break;
+	case BPF_WORKQUEUE:
+		field_off = map->record->wq_off;
+		break;
 	default:
 		verifier_bug(env, "unsupported BTF field type: %s\n", struct_name);
 		return -EINVAL;
@@ -8505,13 +8508,17 @@ static int process_wq_func(struct bpf_verifier_env *env, int regno,
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_map *map = reg->map_ptr;
-	u64 val = reg->var_off.value;
+	int err;
 
-	if (map->record->wq_off != val + reg->off) {
-		verbose(env, "off %lld doesn't point to 'struct bpf_wq' that is at %d\n",
-			val + reg->off, map->record->wq_off);
-		return -EINVAL;
+	err = check_map_field_pointer(env, regno, BPF_WORKQUEUE);
+	if (err)
+		return err;
+
+	if (meta->map.ptr) {
+		verifier_bug(env, "Two map pointers in a bpf_wq helper");
+		return -EFAULT;
 	}
+
 	meta->map.uid = reg->map_uid;
 	meta->map.ptr = map;
 	return 0;
-- 
2.51.0


