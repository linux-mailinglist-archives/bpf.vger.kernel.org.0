Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67273504F0
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhCaQpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234119AbhCaQp2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 12:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vu4HpU4JCTvWj881JzDXxJ0KAgPaUxPS8xJ1LdP5hJ8=;
        b=KoHz6ZAHZGICcURB82FnvyYACfRJf9eAihGkb9vpv32r3VgSA4I8CUqD562v2Cimj2SMDX
        FARPWoi3cB11xBj8fsMmkE+72TAkadEjNEE/FQLX9UpSog2QvH8mH1NFDrcev4wl5pwkqD
        oMwP+z6s3JyoXHq8TrySCELQ22cnk0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-Ek7yM-2-MNWGMapokeofLg-1; Wed, 31 Mar 2021 12:45:24 -0400
X-MC-Unique: Ek7yM-2-MNWGMapokeofLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B92E81B2C985;
        Wed, 31 Mar 2021 16:45:23 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-48.ams2.redhat.com [10.36.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B31316922;
        Wed, 31 Mar 2021 16:45:22 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v3 5/8] selftests/bpf: mmap: use runtime page size
Date:   Wed, 31 Mar 2021 19:45:01 +0300
Message-Id: <20210331164504.320614-5-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 9c3c5c0f068f..691b54b1c7cd 100644
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
+				       4 * (page_size / sizeof (u64)));
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

