Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE59D3CE9A2
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 19:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244147AbhGSQ61 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 12:58:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54129 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346757AbhGSQ4O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Jul 2021 12:56:14 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EBC615C006D;
        Mon, 19 Jul 2021 13:36:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Jul 2021 13:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=kuUA+sN8pgkWl6lvQTuie/Fh2xszQ+viTeTarlODegM=; b=t63ZsMiL
        tefmUfQg0+LZEOtn7W4yO/O7eqRqvwQO1LQxNSAtWCuyK8VIeVSImzTxARDRdpCY
        cZcRzwdkgrInPpAXdRwfDSFI89DeYnuEu07ZM3iGt2LTChTyXzd9EPS118TPGAVi
        oEffpymOkFpOOC2vEeHNB753bU3UD3HFwGyDY13ZRjJW6s6qjMO4bnC/BSJcRoGK
        XraM2zOwZ0dGyVa9JbloeFQDyPJ5t1NDlPQTBhZ4I3wzwXK+oQOSLX31euVRT9fb
        E9YD6k2U01slDYb5J6GCPE6PQ+RxdPH8j/zFHF0CLa02KmMHVUxXir0I9XglTom2
        /qKF4r/W++xjuw==
X-ME-Sender: <xms:Mrj1YEFUHqWdH9RoSO56Mxnx3z63dmbXcSUkoNJgMJjGJGl3mFRTTg>
    <xme:Mrj1YNVhft_c7ZFCqJdhTStS8UpXDK-Lq4xLf8xfgAB0BxiS6hZ5WZ21nAklGTyYU
    SKoxQihpUZ_Ay0EPrM>
X-ME-Received: <xmr:Mrj1YOJdcZJtMftdKCtoZxI1LRnzfqpRzClITj5hEjwxYibqq8qmL2kgH-cT0pGgHRxEFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepofgrrhhthihnrghsucfruhhmphhuthhishcuoehmsehlrghm
    sggurgdrlhhtqeenucggtffrrghtthgvrhhnpedtffffgeffjeeiheeuvdfhkeejvefhie
    dufeekffekueeuhfelvdetjeeiteduvdenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:Mrj1YGFx2QGzQpdR4jHAWA3dEbvfI4zfPaUgBXnAFOFwutobknJ6hQ>
    <xmx:Mrj1YKUwIgXpNF6Oq-MdtXVp7kYZavS0sFabzVTlB2MLhoorAnzYfQ>
    <xmx:Mrj1YJOQRVb0DsMa_M2iTfKbe03dgjATH-nZDzxNrEA_hPL8UQFqDQ>
    <xmx:Mrj1YHjNQiXGd7GA9UiUuqHeDig4bGe46ypgjPVPW9B2_8N_J5qJ9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jul 2021 13:36:48 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Subject: [PATCH bpf 2/2] selftests/bpf: check inner map deletion
Date:   Mon, 19 Jul 2021 19:38:38 +0200
Message-Id: <20210719173838.423148-3-m@lambda.lt>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719173838.423148-1-m@lambda.lt>
References: <20210719173838.423148-1-m@lambda.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test case to check whether an unsuccessful creation of an outer
map of a BTF-defined map-in-map destroys the inner map.

As bpf_object__create_map() is a static function, we cannot just call it
from the test case and then check whether a map accessible via
map->inner_map_fd has been closed. Instead, we iterate over all maps and
check whether the map "$MAP_NAME.inner" does not exist.

Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 .../bpf/progs/test_map_in_map_invalid.c       | 26 ++++++++
 tools/testing/selftests/bpf/test_maps.c       | 64 ++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c

diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
new file mode 100644
index 000000000000..2918caea1e3d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
@@ -0,0 +1,26 @@
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
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 30cbf5d98f7d..d4184dde04df 100644
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
 
@@ -1229,10 +1233,68 @@ static void test_map_in_map(void)
 
 	close(fd);
 	bpf_object__close(obj);
+
+
+	/* Test that failing bpf_object__create_map() destroys the inner map */
+
+	obj = bpf_object__open(MAPINMAP_INVALID_PROG);
+	err = libbpf_get_error(obj);
+	if (err) {
+		printf("Failed to load %s program: %d %d",
+		       MAPINMAP_INVALID_PROG, err, errno);
+		goto out_map_in_map;
+	}
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

