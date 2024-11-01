Return-Path: <bpf+bounces-43690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594079B8969
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 03:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B0E1F22647
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 02:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD33145FFF;
	Fri,  1 Nov 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hRnK2B2H"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBCA73451;
	Fri,  1 Nov 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428829; cv=none; b=fpAviWnJCDC5kimbpmsgqktBEcDZ0ktCh6Ck9aNXv78Ye1395Tz0tVS0uhondKs4ecctpCs8mjNKmQnoSRTCXqnua6YkU6gtyFPOiKwLr63hb4gOXlIqn3Vl3ad/BY41qkAHOKwHbPW66q51aGDv2WlZxErILio8Jyb/1hj97iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428829; c=relaxed/simple;
	bh=HamhB/9kVT6nC1ZqKi2kZElwvGTbkV/1CeQUqskKmSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kw6LMnfxLARA9Ct/95RyTdX05HlngAK7jo9XXgf04SOMeaHX0mB4g7rYz27x4q/YZ8t8ba9YJmKFRdrZOa4pzEtRiG7Ba69wDRJPKn1R4OwCSH1gVnfJ+b3rTraCfUbzAlTJ4Al9Vje6EwCSPqH9uQQP0+8T+0EKX29VJvyg2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hRnK2B2H; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=7I3LX
	8cExmDiPWhipK+414Z78BH39l2/Zm0UHVryeA0=; b=hRnK2B2HpGKfAJ2U57jbO
	eyUELpf/1JC+ZawhUz6nOyTjaMfYxX7fQ2zYcRidaGxrfvGRLzpvoHUCEvQO3cHk
	Ku8kGjTUXz7jFb9zmht3V1KRWXi6AGMR2ns/RJ8PNenmSzeD7/sSspUICuQxKnX2
	y1KjTZDU+V/wnxCv+bDnd8=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCXf_dEPyRnhWzQCQ--.1082S3;
	Fri, 01 Nov 2024 10:39:12 +0800 (CST)
From: mrpre <mrpre@163.com>
To: yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mrpre <mrpre@163.com>
Subject: [PATCH 2/2] bpf: implement libbpf sockmap cpu affinity
Date: Fri,  1 Nov 2024 10:38:32 +0800
Message-ID: <20241101023832.32404-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241101023832.32404-1-mrpre@163.com>
References: <20241101023832.32404-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXf_dEPyRnhWzQCQ--.1082S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3WrWkAr15tw1xuF1fGw1kuFg_yoW7ArWDpF
	9YkF1SkF4Sqay5XrWYqa1IgrW5CF4Igw1jyrsrJ3W5ArnFgw1Iqr1Iyan3Ar13Wrs5Zw48
	A34a9r4rJ348ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEZ2-7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDxKKp2ckMsj0iwACs0

implement libbpf sockmap cpu affinity

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 tools/include/uapi/linux/bpf.h                |  4 ++++
 tools/lib/bpf/bpf.c                           | 22 +++++++++++++++++++
 tools/lib/bpf/bpf.h                           |  9 ++++++++
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 19 ++++++++++++----
 5 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f28b6527e815..2019a87b5d4a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1509,6 +1509,10 @@ union bpf_attr {
 			__aligned_u64 next_key;
 		};
 		__u64		flags;
+		union {
+			/* specify the CPU where the sockmap job run on */
+			__aligned_u64 target_cpu;
+		};
 	};
 
 	struct { /* struct used by BPF_MAP_*_BATCH commands */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 2a4c71501a17..13c3f3cfe889 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -401,6 +401,28 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
 	return libbpf_err_errno(ret);
 }
 
+int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
+			     __u64 flags, const struct bpf_map_update_opts *opts)
+{
+	union bpf_attr attr;
+	int ret;
+	__u64 *target_cpu;
+
+	if (!OPTS_VALID(opts, bpf_map_update_opts))
+		return libbpf_err(-EINVAL);
+
+	target_cpu = OPTS_GET(opts, target_cpu, NULL);
+	memset(&attr, 0, sizeof(attr));
+	attr.map_fd = fd;
+	attr.key = ptr_to_u64(key);
+	attr.value = ptr_to_u64(value);
+	attr.flags = flags;
+	attr.target_cpu = ptr_to_u64(target_cpu);
+
+	ret = sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
+	return libbpf_err_errno(ret);
+}
+
 int bpf_map_lookup_elem(int fd, const void *key, void *value)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, flags);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a4a7b1ad1b63..aec6dfddf697 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -147,6 +147,15 @@ LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
 
 LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
 				   __u64 flags);
+struct bpf_map_update_opts {
+	size_t sz;  /* size of this struct for forward/backward compatibility */
+	/* specify the CPU where the sockmap job run on */
+	__u64 *target_cpu;
+	size_t :0;
+};
+#define bpf_map_update_opts__last_field target_cpu
+LIBBPF_API int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
+					__u64 flags, const struct bpf_map_update_opts *opts);
 
 LIBBPF_API int bpf_map_lookup_elem(int fd, const void *key, void *value);
 LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *value,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 54b6f312cfa8..ab5ec29f542d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -17,6 +17,7 @@ LIBBPF_0.0.1 {
 		bpf_map_lookup_and_delete_elem;
 		bpf_map_lookup_elem;
 		bpf_map_update_elem;
+		bpf_map_update_elem_opts;
 		bpf_obj_get;
 		bpf_obj_get_info_by_fd;
 		bpf_obj_pin;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 82bfb266741c..84a35cb4b9fe 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -190,13 +190,18 @@ static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
 	test_skmsg_load_helpers__destroy(skel);
 }
 
-static void test_sockmap_update(enum bpf_map_type map_type)
+static void test_sockmap_update(enum bpf_map_type map_type, bool cpu_affinity)
 {
 	int err, prog, src;
 	struct test_sockmap_update *skel;
 	struct bpf_map *dst_map;
 	const __u32 zero = 0;
 	char dummy[14] = {0};
+	__u64 target_cpu = 0;
+
+	LIBBPF_OPTS(bpf_map_update_opts, update_opts,
+		.target_cpu = &target_cpu,
+	);
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in = dummy,
 		.data_size_in = sizeof(dummy),
@@ -219,7 +224,11 @@ static void test_sockmap_update(enum bpf_map_type map_type)
 	else
 		dst_map = skel->maps.dst_sock_hash;
 
-	err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
+	if (cpu_affinity)
+		err = bpf_map_update_elem_opts(src, &zero, &sk, BPF_NOEXIST, &update_opts);
+	else
+		err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
+
 	if (!ASSERT_OK(err, "update_elem(src)"))
 		goto out;
 
@@ -896,9 +905,11 @@ void test_sockmap_basic(void)
 	if (test__start_subtest("sockhash sk_msg load helpers"))
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKHASH);
 	if (test__start_subtest("sockmap update"))
-		test_sockmap_update(BPF_MAP_TYPE_SOCKMAP);
+		test_sockmap_update(BPF_MAP_TYPE_SOCKMAP, false);
+	if (test__start_subtest("sockmap update cpu affinity"))
+		test_sockmap_update(BPF_MAP_TYPE_SOCKMAP, true);
 	if (test__start_subtest("sockhash update"))
-		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
+		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH, false);
 	if (test__start_subtest("sockmap update in unsafe context"))
 		test_sockmap_invalid_update();
 	if (test__start_subtest("sockmap copy"))
-- 
2.43.5


