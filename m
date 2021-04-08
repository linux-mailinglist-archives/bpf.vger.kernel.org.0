Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A50357C3A
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhDHGO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229922AbhDHGOZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yv67MRDOTbIzLWn0D73vnrfkKM/SAVN1TQK0omOKWn0=;
        b=Pqy9m1bCMki0Co6E3vmmx72Grg49mGtzzWZOvEbBftJz8EJzHkf2rykmN8Rw56JASA90YJ
        Puk1I/hLl3IdlOk6isoC4R+3o1lqDv1ZQfq/K5dFiE4QoHpemKMzVPEKBh+nFipGnUnYUP
        YPj9SW1azaoNvbzAMm9brb+0DRnjMuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-pzu3X3thPM-znLdWFtiQPA-1; Thu, 08 Apr 2021 02:14:12 -0400
X-MC-Unique: pzu3X3thPM-znLdWFtiQPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F7881922965;
        Thu,  8 Apr 2021 06:14:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB1A7A3A1;
        Thu,  8 Apr 2021 06:13:23 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 5/9] selftests/bpf: mmap: use runtime page size
Date:   Thu,  8 Apr 2021 09:13:06 +0300
Message-Id: <20210408061310.95877-5-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
 <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace hardcoded 4096 with runtime value in the userspace part of
the test and set bpf table sizes dynamically according to the value.

Do not switch to ASSERT macros, keep CHECK, for consistency with the
rest of the test. Can be a separate cleanup patch.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/mmap.c | 24 +++++++++++++++----
 tools/testing/selftests/bpf/progs/test_mmap.c |  2 --
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mmap.c b/tools/testing/selftests/bpf/prog_tests/mmap.c
index 9c3c5c0f068f..37b002ca1167 100644
--- a/tools/testing/selftests/bpf/prog_tests/mmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/mmap.c
@@ -29,22 +29,36 @@ void test_mmap(void)
 	struct test_mmap *skel;
 	__u64 val = 0;
 
-	skel = test_mmap__open_and_load();
-	if (CHECK(!skel, "skel_open_and_load", "skeleton open/load failed\n"))
+	skel = test_mmap__open();
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
 		return;
 
+	err = bpf_map__set_max_entries(skel->maps.rdonly_map, page_size);
+	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
+		goto cleanup;
+
+	/* at least 4 pages of data */
+	err = bpf_map__set_max_entries(skel->maps.data_map,
+				       4 * (page_size / sizeof(u64)));
+	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
+		goto cleanup;
+
+	err = test_mmap__load(skel);
+	if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
+		goto cleanup;
+
 	bss_map = skel->maps.bss;
 	data_map = skel->maps.data_map;
 	data_map_fd = bpf_map__fd(data_map);
 
 	rdmap_fd = bpf_map__fd(skel->maps.rdonly_map);
-	tmp1 = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, rdmap_fd, 0);
+	tmp1 = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, rdmap_fd, 0);
 	if (CHECK(tmp1 != MAP_FAILED, "rdonly_write_mmap", "unexpected success\n")) {
-		munmap(tmp1, 4096);
+		munmap(tmp1, page_size);
 		goto cleanup;
 	}
 	/* now double-check if it's mmap()'able at all */
-	tmp1 = mmap(NULL, 4096, PROT_READ, MAP_SHARED, rdmap_fd, 0);
+	tmp1 = mmap(NULL, page_size, PROT_READ, MAP_SHARED, rdmap_fd, 0);
 	if (CHECK(tmp1 == MAP_FAILED, "rdonly_read_mmap", "failed: %d\n", errno))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/progs/test_mmap.c b/tools/testing/selftests/bpf/progs/test_mmap.c
index 4eb42cff5fe9..5a5cc19a15bf 100644
--- a/tools/testing/selftests/bpf/progs/test_mmap.c
+++ b/tools/testing/selftests/bpf/progs/test_mmap.c
@@ -9,7 +9,6 @@ char _license[] SEC("license") = "GPL";
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 4096);
 	__uint(map_flags, BPF_F_MMAPABLE | BPF_F_RDONLY_PROG);
 	__type(key, __u32);
 	__type(value, char);
@@ -17,7 +16,6 @@ struct {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 512 * 4); /* at least 4 pages of data */
 	__uint(map_flags, BPF_F_MMAPABLE);
 	__type(key, __u32);
 	__type(value, __u64);
-- 
2.31.1

