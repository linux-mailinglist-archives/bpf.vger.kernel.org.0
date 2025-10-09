Return-Path: <bpf+bounces-70643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9BBC78CD
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 08:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27313C4969
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 06:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA44296BBA;
	Thu,  9 Oct 2025 06:28:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.189.cn (unknown [14.29.118.224])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB1AAD4B;
	Thu,  9 Oct 2025 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.29.118.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759991324; cv=none; b=AvS7R39HcBRcqkb2OvehdNytnBrAvR4/UtRo+P7h9woIKitbdg7fWK9Olf/KdK4jYL5xuKoHGxJzdtwTmDg7IyqDvAjUF3x6pSM3RffMyNZOqpF8/JCYlIGW1n+lZmd3lJiYpWoHoEH+GBEhbTxSYZAOOKBez/DDjszEXhB5Jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759991324; c=relaxed/simple;
	bh=Q5g1OD319Lff7qj+blafygQj3pPXujUf8BtY9CFebqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kY7Q0tCOwegfHWsPukbLDR6OamTbyDKZaxsIGWp9Huuv8P6+M8jEg7TuvKiJwxAudDMXuhrortPvSDNuXbfsULngqNNFn9M/e2onnBsnvpKMFj6ZUY4s1iZ5VfuDYpjVSI2Bl8ytqJGdWSoNCIHtlmpu/Rz029pMcNQAnQf2F6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.29.118.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.18:0.242344388
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-221.238.56.48 (unknown [10.158.243.18])
	by mail.189.cn (HERMES) with SMTP id 9418440008B;
	Thu,  9 Oct 2025 14:23:32 +0800 (CST)
Received: from  ([221.238.56.48])
	by gateway-153622-dep-6c94b68f6c-9t89z with ESMTP id 96661fc4fb894d3ba142648ca333ed18 for ast@kernel.org;
	Thu, 09 Oct 2025 14:23:33 CST
X-Transaction-ID: 96661fc4fb894d3ba142648ca333ed18
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 221.238.56.48
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From: chensong_2000@189.cn
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@189.cn>
Subject: [PATCH] kernel/bpf/syscall: use IS_FD_HASH in bpf_map_update_value
Date: Thu,  9 Oct 2025 14:23:30 +0800
Message-Id: <20251009062330.26436-1-chensong_2000@189.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Chen <chensong_2000@189.cn>

If IS_FD_HASH is defined on the top of the file, then use it to replace
"map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS".

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/bpf/syscall.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c39..2c194a73aeda 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -154,8 +154,7 @@ static void maybe_wait_bpf_programs(struct bpf_map *map)
 	 * time can be very long and userspace may think it will hang forever,
 	 * so don't handle sleepable BPF programs now.
 	 */
-	if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
-	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
+	if (IS_FD_HASH(map) || map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
 		synchronize_rcu();
 }
 
@@ -274,7 +273,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 	} else if (IS_FD_ARRAY(map)) {
 		err = bpf_fd_array_map_update_elem(map, map_file, key, value,
 						   flags);
-	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
+	} else if (IS_FD_HASH(map)) {
 		err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
 						  flags);
 	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
-- 
2.34.1


