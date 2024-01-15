Return-Path: <bpf+bounces-19532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF9E82D95B
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 14:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FAB1C2147D
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650B7168AF;
	Mon, 15 Jan 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fWELMRLm"
X-Original-To: bpf@vger.kernel.org
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA8168AB
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:4da0:0:640:817e:0])
	by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 4E7DA613D3;
	Mon, 15 Jan 2024 15:59:21 +0300 (MSK)
Received: from conquistador.yandex.net (unknown [2a02:6b8:0:40c:d80d:e04a:8a36:b2e9])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id HxmEA40IfmI0-RY3y6nl3;
	Mon, 15 Jan 2024 15:59:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1705323560;
	bh=PypGBs92Bt8Pt/vBeDOPJ7o3hA2mw3Bkn4RwFePY4P8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=fWELMRLmQB4iDlm1zJKtMiXPPE+FchXwuIXbIVVFXz8Cxgwozwd5/sixZie8tUVuQ
	 OdtYYoyAoDZDFUata6Ijlx4laTqCY6W5gVXrIurArMgPl/Qak3nKCrr2SoM8o9hNPx
	 SArJIyarniKmlwEbncM/g1gnvy8peezpFr5fUMx0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Grafin <conquistador@yandex-team.ru>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org
Subject: [PATCH bpf v3] libbpf: Apply map_set_def_max_entries() for inner_maps on creation
Date: Mon, 15 Jan 2024 15:59:14 +0300
Message-ID: <20240115125914.28588-1-conquistador@yandex-team.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows to create BPF_MAP_TYPE_ARRAY_OF_MAPS and
BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY.

Previous behaviour created a zero filled btf_map_def for inner maps and
tried to use it for a map creation but the linux kernel forbids to create
a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.

Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
---
 tools/lib/bpf/libbpf.c                        |  4 +++
 .../selftests/bpf/progs/test_map_in_map.c     | 23 +++++++++++++++
 tools/testing/selftests/bpf/test_maps.c       | 29 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067be95da3c..8f4d580187aa 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -70,6 +70,7 @@
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
+static int map_set_def_max_entries(struct bpf_map *map);
 
 static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
@@ -5212,6 +5213,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
 	if (bpf_map_type__is_map_in_map(def->type)) {
 		if (map->inner_map) {
+			err = map_set_def_max_entries(map->inner_map);
+			if (err)
+				return err;
 			err = bpf_object__create_map(obj, map->inner_map, true);
 			if (err) {
 				pr_warn("map '%s': failed to create inner map: %d\n",
diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
index f416032ba858..b393d2b8bd6f 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
@@ -21,6 +21,29 @@ struct {
 	__type(value, __u32);
 } mim_hash SEC(".maps");
 
+struct perf_event_array {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+} inner_map0 SEC(".maps"), inner_map1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__array(values, struct perf_event_array);
+} mim_array_pe SEC(".maps") = {
+	.values = {&inner_map0, &inner_map1}};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__array(values, struct perf_event_array);
+} mim_hash_pe SEC(".maps") = {
+	.values = {&inner_map0, &inner_map1}};
+
+
 SEC("xdp")
 int xdp_mimtest0(struct xdp_md *ctx)
 {
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 7fc00e423e4d..03f4d448fd3b 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1159,6 +1159,7 @@ static void test_map_in_map(void)
 	__u32 len = sizeof(info);
 	__u32 id = 0;
 	libbpf_print_fn_t old_print_fn;
+	int ret;
 
 	obj = bpf_object__open(MAPINMAP_PROG);
 
@@ -1190,7 +1191,11 @@ static void test_map_in_map(void)
 		goto out_map_in_map;
 	}
 
-	bpf_object__load(obj);
+	ret = bpf_object__load(obj);
+	if (ret) {
+		printf("Failed to load test prog\n");
+		goto out_map_in_map;
+	}
 
 	map = bpf_object__find_map_by_name(obj, "mim_array");
 	if (!map) {
@@ -1226,6 +1231,28 @@ static void test_map_in_map(void)
 		goto out_map_in_map;
 	}
 
+	map = bpf_object__find_map_by_name(obj, "mim_array_pe");
+	if (!map) {
+		printf("Failed to load array of perf event array maps\n");
+		goto out_map_in_map;
+	}
+	mim_fd = bpf_map__fd(map);
+	if (mim_fd < 0) {
+		printf("Failed to get descriptor for array of perf event array maps\n");
+		goto out_map_in_map;
+	}
+
+	map = bpf_object__find_map_by_name(obj, "mim_hash_pe");
+	if (!map) {
+		printf("Failed to load hash of perf event array maps\n");
+		goto out_map_in_map;
+	}
+	mim_fd = bpf_map__fd(map);
+	if (mim_fd < 0) {
+		printf("Failed to get descriptor for array of perf event array maps\n");
+		goto out_map_in_map;
+	}
+
 	close(fd);
 	fd = -1;
 	bpf_object__close(obj);
-- 
2.41.0


