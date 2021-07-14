Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27C3C890B
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhGNQze (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 12:55:34 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57717 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhGNQze (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 12:55:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FE9D5C0148;
        Wed, 14 Jul 2021 12:52:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 14 Jul 2021 12:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xlzZVhl3F+Swixx7hiJRES3vDMsEtXk782bM7FHoOlc=; b=bobTGKU1
        8ExtmfgsbcyxuQmV4S0tLB5sxxjErAbjVDtB877Ms0WQiPhzScjDHpVXG51BXpWl
        mASZ7xP241GUN6K7lc0HdruPUJAuU1YN93QIvHGe6hM2EPjXbrxG4ikPmAmTuGad
        aUj/8d1Yy7JxVXWWiQ9P+6f34chx5wPuLunI4nqRiKdir/hcB5pnnsAJ7JVDAAMV
        Oo2I9+Do8nZAbT2MMgeIKApeI2F1bM5wAtM0bEyxOLAF4yLLh0MeHjY/k2kb6VQl
        ApHvfnV72p/XuBtLJttdc3xT4QFaugj1L3hdVGxH3effHdMcNG/b4ntgITLaq7rx
        bbwoUAqM8474pw==
X-ME-Sender: <xms:WRbvYEhVFEL1ObWbUtmhXMFWkx2_dxXamcLQ_0zoAoSSun_D2s1TxA>
    <xme:WRbvYNAbnb1VdAsah_wo_0gIs0GcBpc6QygWOFkvImajP0eCJ23KvbugXhYXkTQVl
    XyXDxlVfegKgHWfe_Y>
X-ME-Received: <xmr:WRbvYMEPAt74eRbmsuszHMZjD8VNlj4kSnOg37sosgbiLGY5io_yTcNPTgob92ze0n6hqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepofgrrhhthihnrghsucfruhhmphhuthhishcuoehmsehlrghm
    sggurgdrlhhtqeenucggtffrrghtthgvrhhnpedtffffgeffjeeiheeuvdfhkeejvefhie
    dufeekffekueeuhfelvdetjeeiteduvdenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:WRbvYFSH14mBH9-ZOxd28egcTytQf1NKkzc2zRU1EHgkoQ_xWmSjUg>
    <xmx:WRbvYBzbDSoTv7dFcNHPLI8ZShvKMqgdYKolHruG-jA2TaAAOIeCKQ>
    <xmx:WRbvYD4PeCHtgQ1y485s3EW0kuTllJ5gT85M0421OWNrAJp3-VHdzg>
    <xmx:WhbvYM-vttLbllbsR5ARQkCkk8soCG_RBI4zWDWlHTwhGULAdSU0kg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 12:52:40 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Subject: [PATCH bpf 2/2] selftests/bpf: check inner map deletion
Date:   Wed, 14 Jul 2021 18:54:40 +0200
Message-Id: <20210714165440.472566-3-m@lambda.lt>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714165440.472566-1-m@lambda.lt>
References: <20210714165440.472566-1-m@lambda.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test case to check whether an unsuccessful creation of an outer
map of a BTF-defined map-in-map destroys the inner map.

As bpf_object__create_map() is a static function, we cannot just call it
from the test case and then check whether a map accessible via
map->inner_map_fd has been removed. Instead, we iterate over all maps
and check whether the map "$MAP_NAME.inner" does not exist.

Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 .../bpf/progs/test_map_in_map_invalid.c       | 27 +++++++++
 tools/testing/selftests/bpf/test_maps.c       | 58 ++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c

diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
new file mode 100644
index 000000000000..03601779e4ed
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Isovalent, Inc. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct inner {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, int);
+	__uint(max_entries, 4);
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 0); /* This will make map creation to fail */
+	__uint(key_size, sizeof(__u32));
+	__array(values, struct inner);
+} mim SEC(".maps");
+
+SEC("xdp_noop")
+int xdp_noop0(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+int _version SEC("version") = 1;
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 30cbf5d98f7d..48f6c6dfd188 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1153,12 +1153,16 @@ static void test_sockmap(unsigned int tasks, void *data)
 }
 
 #define MAPINMAP_PROG "./test_map_in_map.o"
+#define MAPINMAP_INVALID_PROG "./test_map_in_map_invalid.o"
 static void test_map_in_map(void)
 {
 	struct bpf_object *obj;
 	struct bpf_map *map;
 	int mim_fd, fd, err;
 	int pos = 0;
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	__u32 id = 0;
 
 	obj = bpf_object__open(MAPINMAP_PROG);
 
@@ -1229,10 +1233,62 @@ static void test_map_in_map(void)
 
 	close(fd);
 	bpf_object__close(obj);
+
+
+	/* Test that failing bpf_object__create_map() destroys the inner map */
+
+	obj = bpf_object__open(MAPINMAP_INVALID_PROG);
+
+	map = bpf_object__find_map_by_name(obj, "mim");
+	if (!map) {
+		printf("Failed to load array of maps from test prog\n");
+		goto out_map_in_map;
+	}
+
+	err = bpf_object__load(obj);
+	if (!err) {
+		printf("Loading obj supposed to fail\n");
+		goto out_map_in_map;
+	}
+
+	/* Iterate over all maps to check whether the internal map
+	 * ("mim.internal") has been destroyed.
+	 */
+	while (true) {
+		err = bpf_map_get_next_id(id, &id);
+		if (err) {
+			if (errno == ENOENT)
+				break;
+			printf("Failed to get next map: %d", errno);
+			goto out_map_in_map;
+		}
+
+		fd = bpf_map_get_fd_by_id(id);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			printf("Failed to get map by id %u: %d", id, errno);
+			goto out_map_in_map;
+		}
+
+		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			printf("Failed to get map info by fd %d: %d", fd,
+			       errno);
+			goto out_map_in_map;
+		}
+
+		if (!strcmp(info.name, "mim.inner")) {
+			printf("Inner map mim.inner was not destroyed\n");
+			goto out_map_in_map;
+		}
+	}
+
 	return;
 
 out_map_in_map:
-	close(fd);
+	if (fd >= 0)
+		close(fd);
 	exit(1);
 }
 
-- 
2.32.0

