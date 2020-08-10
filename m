Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B40240970
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 17:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgHJPbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 11:31:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30848 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbgHJPbr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 11:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597073506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xkqD+5Yst/HOqj9SedC/0eD/S/vPo6jy5Xn+7cpb0sM=;
        b=hbxFRZdBbBt/Z/R1UdKxpufeMwX1OzpiOxOtBd0krFCKMDhPqWeahlzF7+1kTVuShonsuv
        AOMQdEV9dSw+u9I0kSlmVhuugo0BqL6rjzcBGpqUItk+mVICo9V0xjc219pY7p29Rakb4A
        4LODeMa0G3sFcD+81BZKmLMzw+N+H5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-q9rD6ogYP_azuQVymLn2dw-1; Mon, 10 Aug 2020 11:31:43 -0400
X-MC-Unique: q9rD6ogYP_azuQVymLn2dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D130B1902EB8;
        Mon, 10 Aug 2020 15:31:42 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-54.ams2.redhat.com [10.36.114.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9514E6111F;
        Mon, 10 Aug 2020 15:31:41 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] selftests: bpf: mmap: reorder mmap manipulations of adv_mmap tests
Date:   Mon, 10 Aug 2020 18:31:39 +0300
Message-Id: <20200810153139.41134-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The idea of adv_mmap tests is to map/unmap pages in arbitrary
order. It works fine as soon as the kernel allocates first 3 pages
for from a region with unallocated page after that. If it's not the
case, the last remapping of 4 pages with MAP_FIXED will remap the
page to bpf map which will break the code which worked with the data
located there before.

Change the test to map first the whole bpf map, 4 pages, and then
manipulate the mappings.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/mmap.c | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mmap.c b/tools/testing/selftests/bpf/prog_tests/mmap.c
index 43d0b5578f46..5768af1e16a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/mmap.c
@@ -183,38 +183,45 @@ void test_mmap(void)
 
 	/* check some more advanced mmap() manipulations */
 
-	/* map all but last page: pages 1-3 mapped */
-	tmp1 = mmap(NULL, 3 * page_size, PROT_READ, MAP_SHARED,
+	/* map all 4 pages */
+	tmp1 = mmap(NULL, 4 * page_size, PROT_READ, MAP_SHARED,
 			  data_map_fd, 0);
 	if (CHECK(tmp1 == MAP_FAILED, "adv_mmap1", "errno %d\n", errno))
 		goto cleanup;
 
-	/* unmap second page: pages 1, 3 mapped */
+	/* unmap second page: pages 1, 3, 4 mapped */
 	err = munmap(tmp1 + page_size, page_size);
 	if (CHECK(err, "adv_mmap2", "errno %d\n", errno)) {
 		munmap(tmp1, map_sz);
 		goto cleanup;
 	}
 
+	/* unmap forth page: pages 1, 3 mapped */
+	err = munmap(tmp1 + (3 * page_size), page_size);
+	if (CHECK(err, "adv_mmap3", "errno %d\n", errno)) {
+		munmap(tmp1, map_sz);
+		goto cleanup;
+	}
+
 	/* map page 2 back */
 	tmp2 = mmap(tmp1 + page_size, page_size, PROT_READ,
 		    MAP_SHARED | MAP_FIXED, data_map_fd, 0);
-	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap3", "errno %d\n", errno)) {
+	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap4", "errno %d\n", errno)) {
 		munmap(tmp1, page_size);
 		munmap(tmp1 + 2*page_size, page_size);
 		goto cleanup;
 	}
-	CHECK(tmp1 + page_size != tmp2, "adv_mmap4",
+	CHECK(tmp1 + page_size != tmp2, "adv_mmap5",
 	      "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
 
 	/* re-map all 4 pages */
 	tmp2 = mmap(tmp1, 4 * page_size, PROT_READ, MAP_SHARED | MAP_FIXED,
 		    data_map_fd, 0);
-	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap5", "errno %d\n", errno)) {
+	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap6", "errno %d\n", errno)) {
 		munmap(tmp1, 3 * page_size); /* unmap page 1 */
 		goto cleanup;
 	}
-	CHECK(tmp1 != tmp2, "adv_mmap6", "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
+	CHECK(tmp1 != tmp2, "adv_mmap7", "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
 
 	map_data = tmp2;
 	CHECK_FAIL(bss_data->in_val != 321);
@@ -231,7 +238,7 @@ void test_mmap(void)
 	/* map all 4 pages, but with pg_off=1 page, should fail */
 	tmp1 = mmap(NULL, 4 * page_size, PROT_READ, MAP_SHARED | MAP_FIXED,
 		    data_map_fd, page_size /* initial page shift */);
-	if (CHECK(tmp1 != MAP_FAILED, "adv_mmap7", "unexpected success")) {
+	if (CHECK(tmp1 != MAP_FAILED, "adv_mmap8", "unexpected success")) {
 		munmap(tmp1, 4 * page_size);
 		goto cleanup;
 	}
-- 
2.26.2

