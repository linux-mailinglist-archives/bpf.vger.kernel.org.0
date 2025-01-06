Return-Path: <bpf+bounces-47959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AFEA0289A
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61ED1882C48
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C401186351;
	Mon,  6 Jan 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efaysKNc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A40149C7A
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175260; cv=none; b=fjqFLBUvl3bvrZogyzGdqH/q6xDoFUXy0gSBZOW2F/AKoO2xUsbcR3mOb7v7vmLU7DTdecP5ltrk0M8T9FH61oBh9iAVQz4QH77TjJivWQZucMZ2a9PvMgXbVSAlNahABjOybv3dg1D5zDSlOxhAf+6IcMwJzMkskQsN/6xB2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175260; c=relaxed/simple;
	bh=4ApDpjmxkffrRpNFhU+1HWLc7ansqaGNNqVeGbtIZxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMApmRCQoLyprBtZZh7w+HEsplw93AQHa+HqLkiY84M4pLQUIXtTuyfpIjIvaOW+j7wWzpnhZoLn6Yv94enSSB3xJltodY6R0KylwvSjLbjNDsa3cad4xGNgoMWmb74BbAfStbhn1u/+TCq2+kVGKG4zRy5A+Qv6+0hTIoVaa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efaysKNc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385deda28b3so9534534f8f.0
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 06:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736175254; x=1736780054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Nw6zDoZ2wfSbiPltCWmK0Kbd7iAlPXIjzSfpIYlNp8=;
        b=efaysKNcZBWJ4pA5sLVHxcHgYkg/8hwMWovTTuJ6UI0+i+C9YsrcIUHPhoVijoZwkV
         liz4ZvafPs359CyjnBxRBBs2sAM5OkuA9EFLgnpJlfJZnOwkzotQrVBvX60xh5YGhQil
         rhiKzCJEBYBsVqrWx+zmtoJRZtJ0lgXwIsvQeTFgygiGIkzojEMbLoVbVEL8SHZ5LY2J
         yelDwh2C16hWQVfP/XfcygpPNyxwr/veSXEzh4Fs1Pd9tIDn7aI032T5mRL3fO/gKGpn
         7rvSMCQ1ItiWEk6h4zByYRMkR6HIISaA11RBWWXTFiHGv9obs8piA8+d/zT4qeFpVe7Q
         7a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736175254; x=1736780054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Nw6zDoZ2wfSbiPltCWmK0Kbd7iAlPXIjzSfpIYlNp8=;
        b=GwsCEXooa+Z2aAW5WZJAymDOQbwNx01Q+jBOa7INaEb3yw4qDuHA7Fn/8CrwyYOU4/
         9bgW5DWjjDN3N6UF/pKGasH9qk5cZmwTxZwy/9RyRA7VNJw3QEALaGjB7T3hQAWwRV3T
         RpJNM1yrCLZ16kBiycUTLZxSuWyywWem/P37aWYU10zFhqVU4i/2PanJRrVVW47ZoTTp
         iOuesvcwodoruYQzzhYiGTHVZATJOdMwvcLbK7CD4pWDuvSYLKDTpKcxTh54IoQFo6UP
         6sS0HUoOFw0q3R9lB/QWPtb38LKuZ5JCawy7z8g52KwZtDHDSD/ypGMd7KAWscjKK5hi
         aTPQ==
X-Gm-Message-State: AOJu0YxeNcq9H9MoXcjlB6HYJUnz42OLptKHgFC6mWOWcAsdUjWIY1y5
	7O3KLGqHyHxwN12AcxfC88Z6Jxk7K63+kBs65ejNUvs8sRIkWEuOU0pRmvfz2oDOHQ==
X-Gm-Gg: ASbGncvomma7W6YT19j4muqu0azisLEMRCbSlNl/ykvN+WqoM2kTv/wYVMItDvwRX4K
	sk0Q+A9rRdn859/6mTJH0QYGhNYNySyoszhgnL1q8LAdL2osa1i4fEj7dgUbMCfd7pmgDczQcCr
	c4Yn5os7gWWuAHB8drt5/4MDaG0aOfzvjOOoT4VeBoYBUX0javkUgXAfjC9RNU/JQH8OhkXFZh3
	l2VFTR8UsOkyspLU5QH/RzHfGgkoBtBjph0quUk4duiUNSXWYZIhnLlzZ7H8ZkXe7/Rgp/CqsQ=
X-Google-Smtp-Source: AGHT+IHg1jdNIkXuSPlEnPnr+qsq5p3Jt3KiFth+eVB2Q0u2U2PhjPxArmRPr/HdH9B45JUMs141VQ==
X-Received: by 2002:a5d:47a7:0:b0:386:4034:f9a6 with SMTP id ffacd0b85a97d-38a223fd8d3mr44235049f8f.57.1736175254359;
        Mon, 06 Jan 2025 06:54:14 -0800 (PST)
Received: from babis.. ([2a02:3033:700:3ba2:3837:7343:334:7680])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm47389982f8f.30.2025.01.06.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:54:13 -0800 (PST)
From: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for bpf_map_get_num_entries
Date: Mon,  6 Jan 2025 15:53:28 +0100
Message-ID: <20250106145328.399610-5-charalampos.stylianopoulos@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the existing selftests for maps with checks that the number of
map entries returned by bpf_map_get_num_entries is as expected.

Co-developed-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
---
 .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
 tools/testing/selftests/bpf/test_maps.c       | 35 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
index d32e4edac930..40265b497791 100644
--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
@@ -434,6 +434,11 @@ static void test_lpm_ipaddr(void)
 	inet_pton(AF_INET6, "2a00:ffff::", key_ipv6->data);
 	assert(bpf_map_lookup_elem(map_fd_ipv6, key_ipv6, &value) == -ENOENT);
 
+	unsigned int entries;
+	/* Check that the reported number of entries in the map is as expected. */
+	assert(bpf_map_get_num_entries(map_fd_ipv4, &entries) == 0 && entries == 5);
+	assert(bpf_map_get_num_entries(map_fd_ipv6, &entries) == 0 && entries == 1);
+
 	close(map_fd_ipv4);
 	close(map_fd_ipv6);
 }
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 8b40e9496af1..c61cf740a6b6 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -109,6 +109,10 @@ static void test_hashmap(unsigned int task, void *data)
 	assert(bpf_map_get_next_key(fd, &next_key, &next_key) < 0 &&
 	       errno == ENOENT);
 
+	unsigned int entries;
+	/* Check that the number of entries in the map is 2. */
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == 2);
+
 	/* Delete both elements. */
 	key = 1;
 	assert(bpf_map_delete_elem(fd, &key) == 0);
@@ -122,6 +126,7 @@ static void test_hashmap(unsigned int task, void *data)
 	       errno == ENOENT);
 	assert(bpf_map_get_next_key(fd, &key, &next_key) < 0 &&
 	       errno == ENOENT);
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == 0);
 
 	close(fd);
 }
@@ -243,6 +248,11 @@ static void test_hashmap_percpu(unsigned int task, void *data)
 	key = 1;
 	assert(bpf_map_update_elem(fd, &key, value, BPF_EXIST) == 0);
 
+
+	unsigned int entries;
+	/* Check that the number of entries in the map is 2. */
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == 2);
+
 	/* Delete both elements. */
 	key = 1;
 	assert(bpf_map_delete_elem(fd, &key) == 0);
@@ -256,6 +266,7 @@ static void test_hashmap_percpu(unsigned int task, void *data)
 	       errno == ENOENT);
 	assert(bpf_map_get_next_key(fd, &key, &next_key) < 0 &&
 	       errno == ENOENT);
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == 0);
 
 	close(fd);
 }
@@ -529,6 +540,10 @@ static void test_devmap_hash(unsigned int task, void *data)
 		exit(1);
 	}
 
+	unsigned int entries;
+	/* Check that the number of entries in the map is 0. */
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == 0);
+
 	close(fd);
 }
 
@@ -557,10 +572,17 @@ static void test_queuemap(unsigned int task, void *data)
 		exit(1);
 	}
 
+	unsigned int entries;
+	/* Check that the number of entries in the map is 0. */
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == 0);
+
 	/* Push MAP_SIZE elements */
 	for (i = 0; i < MAP_SIZE; i++)
 		assert(bpf_map_update_elem(fd, NULL, &vals[i], 0) == 0);
 
+	/* Check that the number of entries in the map is MAP_SIZE. */
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == MAP_SIZE);
+
 	/* Check that element cannot be pushed due to max_entries limit */
 	assert(bpf_map_update_elem(fd, NULL, &val, 0) < 0 &&
 	       errno == E2BIG);
@@ -581,6 +603,9 @@ static void test_queuemap(unsigned int task, void *data)
 	assert(bpf_map_lookup_and_delete_elem(fd, NULL, &val) < 0 &&
 	       errno == ENOENT);
 
+	/* Check that the number of entries in the map is 0. */
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == 0);
+
 	/* Check that non supported functions set errno to EINVAL */
 	assert(bpf_map_delete_elem(fd, NULL) < 0 && errno == EINVAL);
 	assert(bpf_map_get_next_key(fd, NULL, NULL) < 0 && errno == EINVAL);
@@ -613,10 +638,17 @@ static void test_stackmap(unsigned int task, void *data)
 		exit(1);
 	}
 
+	unsigned int entries;
+	/* Check that the number of entries in the map is 0. */
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == 0);
+
 	/* Push MAP_SIZE elements */
 	for (i = 0; i < MAP_SIZE; i++)
 		assert(bpf_map_update_elem(fd, NULL, &vals[i], 0) == 0);
 
+	/* Check that the number of entries in the map is MAP_SIZE. */
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == MAP_SIZE);
+
 	/* Check that element cannot be pushed due to max_entries limit */
 	assert(bpf_map_update_elem(fd, NULL, &val, 0) < 0 &&
 	       errno == E2BIG);
@@ -637,6 +669,9 @@ static void test_stackmap(unsigned int task, void *data)
 	assert(bpf_map_lookup_and_delete_elem(fd, NULL, &val) < 0 &&
 	       errno == ENOENT);
 
+	/* Check that the number of entries in the map is 0. */
+	assert(bpf_map_get_num_entries(fd, &entries) == 0 && entries == 0);
+
 	/* Check that non supported functions set errno to EINVAL */
 	assert(bpf_map_delete_elem(fd, NULL) < 0 && errno == EINVAL);
 	assert(bpf_map_get_next_key(fd, NULL, NULL) < 0 && errno == EINVAL);
-- 
2.43.0


