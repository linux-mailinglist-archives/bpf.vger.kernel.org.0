Return-Path: <bpf+bounces-75848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA56C99A3E
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 01:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AFA14E1DCF
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 00:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFE515746F;
	Tue,  2 Dec 2025 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4jH+Rng"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F8EEAB
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764634706; cv=none; b=gS7HD5VLbIt9WVsgM3gTcgE7NhhCT3l34SCf9XXvh+uNq3wd6FcpMa0Q+rLvRhHwheLSncsZuQONPrBORzDrt9vBi3Q+Sjjx+nSNHjPV/nlMdpvkT0zNTLLR4zZcpO2VbeHOylTRiUJSPsShtlVF+xNmoahe1foHTAMfv7AG1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764634706; c=relaxed/simple;
	bh=17Y0XO27mmu/toiuHtUHAQq4bly4uft3m6Xn1TFd0uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ho27j2SZm7roXhcrmUprRBF+xgswnV5khSmUVpOY0GTAT9lNtUZ3T7PmD/dtPj5F+JpSEiJKkfTgwUfa5WEcOA417fl2vpAg/kc7hUnAswLC2kftkQF8YqBdf7P0cNVX1vHcSw6fN2gvaTca3f9BoKbMy7FeajQFZq5M4ujaIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4jH+Rng; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so4562415a91.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 16:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764634704; x=1765239504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KX1cJ0mYzITSZGbbk27b8/+sceC0x3Oa5gy+iqIrAiY=;
        b=A4jH+RngrnoCPbMi0D6r46GjcUKHhhB70f4gRKnwM9Y6YGi3ahDGYCR1HYc6AbM9Ne
         sG1wj/zbOCCFRqUWCFl7qToWJAP1RlK46rmMAYWwPtNvBuaqCcv2EZq+9ckRJd6fV28u
         gqR8xacu39vKglJRUuSC/grPqLYHqCGmwejohIsiGJVZeYsaFakG83Ih+Y/hn2seSx8h
         XzDDczQLq3wZHsoD1VkD+sAeYeANkin0wse01a/++Hdqv8ld3JWOCYMVUncJbS2WB9Hu
         1O6TaIJ+QYfllA8xOuvQU3T/dKK7JyHzjFoyxsF9Rup6FZzWeTaBrYfKbdiw+kqdLBCZ
         bK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764634704; x=1765239504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX1cJ0mYzITSZGbbk27b8/+sceC0x3Oa5gy+iqIrAiY=;
        b=kkmNmlTU5FdB/AufsD4UXLYgDcLs3tbmnVRV+OCX8oT6S7YJVTRUsOG/m+nlZUoinC
         cGmzkNlEMNATBOuyXnRQgekNBqklT7fB/1gxME9d3uQsGvnLsP/6WcwbYSDWXbosCZOn
         GqLubq5w6ZVMRFIDkWFFARJg4ArlWHO1M/b/6Sdz9ZaENX5HCtdhzak8qPdAchDyb7rh
         omsPxwJDO5Lmv57Xnse7T1pBPbqSY00rKKFUVJGpSTm+GZCPiL7ePuBd9EZeWYKOESDj
         boXlq4mFgP3MyNHVjZgpYtn0D96krSIMMlGF0Q6BlW3Pa6S1bZQEqYrMs0uMtqRh7qds
         q2dw==
X-Gm-Message-State: AOJu0YyXpMc4IM4vunKPTeFrHj43l9GEhVDPcwpth+huqfV+IXA6ned+
	69z7UJPwG3vP8FTQgb1UiZ22hgNeWMoRNnA9JsbCqENqili0xtaK6EHbqGKFTg==
X-Gm-Gg: ASbGnctHc5Ttczvf7Rto6OfroBibwUD+ief1lX7DFBLmPnZejV9zix+YhRlIDiNdg1H
	5aEAa58ioXO217FbfWYam0XMbCBrAZQsuxYlhk/FcAN1RAOd8JG9dBAoS9VIIBW6sMaYIvsXwQA
	Jrr23RrDVm9o43YWjrDmxXzW8vhq3wY/+auoOvUlUWjhsu6f56zouKS2RBZt8pZIlYO6WucNF3W
	z4p6YxQRLZ/qAnsPQRIgTk1jAZHMby73Fj7SB2r6SLt9xBOfjRc5aVH36TG89VRhV/wsPp1iJhh
	/mgAzO3WJxmt6pay+AhhuE0CpcfshrnZK18pPYfhWOr9cGPlo1ZCA91imQZOjNtsTawqfuOdDOB
	0zEDSyTcLKMzpE7gDIg+WKicQlXn2fGq9RI53ark6Quk0OCJJ8WOQCyDJ/WIgENmmWSt0ru1RO9
	m9842KyZs0G4+CATGGEyG5zdk=
X-Google-Smtp-Source: AGHT+IH4dLWtTh4n6BdfJP0hLtpUWMqzqkCsnBXTHIBXy8i7imPPh/miYdB03uTe0kgJz1dUZcfrnw==
X-Received: by 2002:a17:90b:544b:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-34733e786f5mr36537212a91.13.1764634703577;
        Mon, 01 Dec 2025 16:18:23 -0800 (PST)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a55ed00sm18000824a91.5.2025.12.01.16.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 16:18:23 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/2] bpf: Disallow tail call to programs that use cgroup storage
Date: Mon,  1 Dec 2025 16:18:21 -0800
Message-ID: <20251202001822.2769330-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
by disallowing tail call to programs that use cgroup storage. Cgroup
storage is allocated lazily when attaching a cgroup bpf program. With
tail call, it is possible for a callee BPF program to see a NULL
storage pointer if the caller prorgam does not use cgroup storage.

Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn/
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/arraymap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1eeb31c5b317..9c3f86ef9d16 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 				 void *key, void *value, u64 map_flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	u32 i, index = *(u32 *)key, ufd;
 	void *new_ptr, *old_ptr;
-	u32 index = *(u32 *)key, ufd;
+	struct bpf_prog *prog;
 
 	if (map_flags != BPF_ANY)
 		return -EINVAL;
@@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	if (IS_ERR(new_ptr))
 		return PTR_ERR(new_ptr);
 
+	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
+		prog = (struct bpf_prog *)new_ptr;
+
+		for_each_cgroup_storage_type(i)
+			if (prog->aux->cgroup_storage[i])
+				return -EINVAL;
+	}
+
 	if (map->ops->map_poke_run) {
 		mutex_lock(&array->aux->poke_mutex);
 		old_ptr = xchg(array->ptrs + index, new_ptr);
-- 
2.47.3


