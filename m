Return-Path: <bpf+bounces-61581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D998FAE8FD4
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20985189939C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD92620F076;
	Wed, 25 Jun 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK3bqBzX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FD1E98E6;
	Wed, 25 Jun 2025 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750885459; cv=none; b=ig4kFmS8R5yhJGSJ9HZ+e7Pj3uh5s4yZaOtGNKQn3bXYnesevxt1Bs2LudnDA4uvM2UxDwXnStVEJ5HhU6IPkguw4V9i2wgveftKp2eEm4I6ALxr5tKPNCGa0kO5KvEaq8xhvoD2UoqhaXrCk2+xrbtg0LAwKLytOdrSInScYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750885459; c=relaxed/simple;
	bh=rMNaI0Y/t2sZ7tWsrVrYbuUM8EYXA/TSZRovLOk2IyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfdVfmlBKdt54POcr1lsJSLhsj33E/F/LVubmWp9B+PC9D3VPVoQJlUffTf4tyFM5vqG6QbX8QpIBXyUSrNVSEnA1qYUGc1U1oQXmWQK8cMEfeq2nOZQibJXPhqPNeXPQMBuHArzbAbweo5QOszkFBy40xZx91k74EiImYpE27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK3bqBzX; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7111d02c777so3328877b3.3;
        Wed, 25 Jun 2025 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750885456; x=1751490256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kcexd2SdrP5HnCmtscgvQCYg4KidfM/I+5uOfERC6ZU=;
        b=VK3bqBzXfQpLunV+aEpfNQutR9tHkK+ppFEypBWnLGOmoRVXHyhVBRld5fA1uzMrfM
         wPsT16g0jRm2L+EUcH5GBcyp+o9xhNNdfcanCN1gDkmC6Zo4esfckRqpcda3jNkKc0LF
         t/kdRyKqqpHM3UNG+uimEszpVIi4mT+s/IfZUm0a6god+ex9g5hvVN0Gknw8rG2OLGBo
         cAhNHcHZHleIBxc4ztEgxofXZi+/1Xe0CJ0CyK5MKfaXrdODEKxnpOrDV4JIniE4mAZ3
         pp1aOpSy85aPU7mMgsTE1Va75zJniQvIIhLhPyjS9zcnj8gnoN7LC7o3FJ4Qc8Dihl0M
         +5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750885456; x=1751490256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcexd2SdrP5HnCmtscgvQCYg4KidfM/I+5uOfERC6ZU=;
        b=F+/fxhlVolGgD19ROejaj0+urot5f85qVdcrdgrHQHjRCqqxhg7w6azLIaYfqtyPcY
         DRmZKZoCcf2cUdW66oXBVY1uTsX8xOHDkT6ZJeikCkluxwArPNsgTMFYOpQysvotKbMw
         B+wEcHg/ujI/jRjEQVDIUz8VQWHoQ804n0lwAJdAQFz7xqI4kuglXHySXm/WnxoY0UqM
         50HN3hmgUT93+zjHRF7/2UoEBlhrsaFsZkutmuPsQpLPJ2jrkLjfdt+YP7tg9XogidRq
         3+TdgKcUnRqRuBaPZ3Sb4BrNwFfMK5JCLxCS1l+fQ469kfd/JV+FpC7GHqmkykiQ5nOr
         kEXA==
X-Gm-Message-State: AOJu0YxSi5sw4c+6UhiRqzl8Z63YaUZraoNtjQlRg3gFKZENKkFdWSaU
	/4hHomNNvj+t5XcVvICvbAlV+fg8qUudepeJnFQC217lr+/bGGZwSOKYutumcg==
X-Gm-Gg: ASbGnctUfVHWruBfAPquP347cVujvXqoV3sBI+S49WGramn5eAOmzZWS+5y+7nMVVUH
	pNnKrrXMIIDiniUd3+iHeRxyVkWIOegdn3RhKpc4SNxbYaHGnE2chUkhuIRA8GQ1PxG/Fe9NXmL
	3m+Vm7ujee8j5HLNMzfxZmLPXdA6CvRE0bByL9+76QfT1qCXpko5ohKXG2XXJ7o+TqaldRkPUcu
	VijA+Z0lmOv84bmMHbROjOxSVx7n4X9JV9jMpcYxPxPn2wsAiR1hxCkMFpmzfXTp2DbMKGxM/2r
	tG2VZEkL18NNDVfBD8ytBy6Iwz9yhq9v0Ho17MBBY5/dYKAyqYtjH6toxDXcJlMNiA1U6ALQbr4
	VTWeJPF+jCQfVyYO5kajOwkWNSy9sF9tQQZupZ3vDgxLwMKhC8k5URPxx0YqYCYrY
X-Google-Smtp-Source: AGHT+IEzQ9RAPrBx0UQ8Sv+etvOHn+5qtBDfoU8CNvtqH3JMZ5halDIT3L1O12j6fgNOb5U4WvegLg==
X-Received: by 2002:a05:690c:fd3:b0:711:af14:3981 with SMTP id 00721157ae682-71406de1bfbmr69320527b3.31.1750885456443;
        Wed, 25 Jun 2025 14:04:16 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4a4a7besm25975257b3.52.2025.06.25.14.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 14:04:15 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	stfomichev@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf] selftests/bpf: adapt one more case in test_lru_map to the new target_free
Date: Wed, 25 Jun 2025 17:03:55 -0400
Message-ID: <20250625210412.2732970-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The below commit that updated BPF_MAP_TYPE_LRU_HASH free target,
also updated tools/testing/selftests/bpf/test_lru_map to match.

But that missed one case that passes with 4 cores, but fails at
higher cpu counts.

Update test_lru_sanity3 to also adjust its expectation of target_free.

This time tested with 1, 4, 16, 64 and 384 cpu count.

Fixes: d4adf1c9ee77 ("bpf: Adjust free target to avoid global starvation of LRU map")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/bpf/test_lru_map.c | 33 ++++++++++++----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 4ae83f4b7fc7..0921939532c6 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -138,6 +138,12 @@ static int sched_next_online(int pid, int *next_to_try)
 	return ret;
 }
 
+/* Derive target_free from map_size, same as bpf_common_lru_populate */
+static unsigned int __tgt_size(unsigned int map_size)
+{
+	return (map_size / nr_cpus) / 2;
+}
+
 /* Inverse of how bpf_common_lru_populate derives target_free from map_size. */
 static unsigned int __map_size(unsigned int tgt_free)
 {
@@ -410,12 +416,12 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	printf("Pass\n");
 }
 
-/* Size of the LRU map is 2*tgt_free
- * It is to test the active/inactive list rotation
- * Insert 1 to 2*tgt_free (+2*tgt_free keys)
- * Lookup key 1 to tgt_free*3/2
- * Add 1+2*tgt_free to tgt_free*5/2 (+tgt_free/2 keys)
- *  => key 1+tgt_free*3/2 to 2*tgt_free are removed from LRU
+/* Test the active/inactive list rotation
+ *
+ * Fill the whole map, deplete the free list.
+ * Reference all except the last lru->target_free elements.
+ * Insert lru->target_free new elements. This triggers one shrink.
+ * Verify that the non-referenced elements are replaced.
  */
 static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 {
@@ -434,8 +440,7 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 
 	assert(sched_next_online(0, &next_cpu) != -1);
 
-	batch_size = tgt_free / 2;
-	assert(batch_size * 2 == tgt_free);
+	batch_size = __tgt_size(tgt_free);
 
 	map_size = tgt_free * 2;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
@@ -446,23 +451,21 @@ static void test_lru_sanity3(int map_type, int map_flags, unsigned int tgt_free)
 
 	value[0] = 1234;
 
-	/* Insert 1 to 2*tgt_free (+2*tgt_free keys) */
-	end_key = 1 + (2 * tgt_free);
+	/* Fill the map */
+	end_key = 1 + map_size;
 	for (key = 1; key < end_key; key++)
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
 
-	/* Lookup key 1 to tgt_free*3/2 */
-	end_key = tgt_free + batch_size;
+	/* Reference all but the last batch_size */
+	end_key = 1 + map_size - batch_size;
 	for (key = 1; key < end_key; key++) {
 		assert(!bpf_map_lookup_elem_with_ref_bit(lru_map_fd, key, value));
 		assert(!bpf_map_update_elem(expected_map_fd, &key, value,
 					    BPF_NOEXIST));
 	}
 
-	/* Add 1+2*tgt_free to tgt_free*5/2
-	 * (+tgt_free/2 keys)
-	 */
+	/* Insert new batch_size: replaces the non-referenced elements */
 	key = 2 * tgt_free + 1;
 	end_key = key + batch_size;
 	for (; key < end_key; key++) {
-- 
2.50.0.727.gbf7dc18ff4-goog


