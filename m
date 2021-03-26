Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4234A71C
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCZMZN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230054AbhCZMYt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 08:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616761488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJVWMxceisDQsF9m4+VnneiUiqpvYHl9MaEFmAKL1r8=;
        b=gr0gkhPN0cdQYIEuFasfrDn2tBoVCwS9u9KGxHKND2Es/5Kmp/QQcCs9PoT3OzfCddcs2n
        /mc6imwZFfdQ9QLN4u0lFwF1sVji4Y3JQFolQnFa0tR5Tw0WfA7qifV/v5xb8jqI7EdXeF
        8gYFJ/bMiyNiZi41a+DlrgJIazAQqDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-gj9A2EbcNRqMyO_heVsVQQ-1; Fri, 26 Mar 2021 08:24:47 -0400
X-MC-Unique: gj9A2EbcNRqMyO_heVsVQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42AA683DD20;
        Fri, 26 Mar 2021 12:24:46 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-130.ams2.redhat.com [10.36.114.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BACCA5D9E3;
        Fri, 26 Mar 2021 12:24:44 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH v2 4/4] selftests/bpf: ringbuf, mmap: bump up page size to 64K
Date:   Fri, 26 Mar 2021 14:24:38 +0200
Message-Id: <20210326122438.211242-4-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326122438.211242-1-yauheni.kaliuta@redhat.com>
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122438.211242-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both ringbuf and mmap need PAGE_SIZE, but it's not available during
bpf program compile time. 4K size was hardcoded (page shift 12 bits)
which makes the tests fail on systems, configured for larger pages.

Bump it up to 64K which at the first glance look reasonable at the
moment for most of the systems.

Use define to make it clear.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c       |  9 +++++++--
 tools/testing/selftests/bpf/progs/map_ptr_kern.c       |  9 +++++++--
 tools/testing/selftests/bpf/progs/test_mmap.c          | 10 ++++++++--
 tools/testing/selftests/bpf/progs/test_ringbuf.c       |  8 +++++++-
 tools/testing/selftests/bpf/progs/test_ringbuf_multi.c |  7 ++++++-
 5 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index fddbc5db5d6a..9057654da957 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -15,6 +15,11 @@
 #include "test_ringbuf.skel.h"
 
 #define EDONE 7777
+#ifdef PAGE_SIZE
+#undef PAGE_SIZE
+#endif
+/* this is not actual page size, but the value used for ringbuf */
+#define PAGE_SIZE 65536
 
 static int duration = 0;
 
@@ -110,9 +115,9 @@ void test_ringbuf(void)
 	CHECK(skel->bss->avail_data != 3 * rec_sz,
 	      "err_avail_size", "exp %ld, got %ld\n",
 	      3L * rec_sz, skel->bss->avail_data);
-	CHECK(skel->bss->ring_size != 4096,
+	CHECK(skel->bss->ring_size != PAGE_SIZE,
 	      "err_ring_size", "exp %ld, got %ld\n",
-	      4096L, skel->bss->ring_size);
+	      (long)PAGE_SIZE, skel->bss->ring_size);
 	CHECK(skel->bss->cons_pos != 0,
 	      "err_cons_pos", "exp %ld, got %ld\n",
 	      0L, skel->bss->cons_pos);
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index d8850bc6a9f1..c1460f27af78 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -8,6 +8,11 @@
 #define MAX_ENTRIES 8
 #define HALF_ENTRIES (MAX_ENTRIES >> 1)
 
+#ifndef PAGE_SIZE
+/* use reasonable value for various configurations */
+#define PAGE_SIZE 65536
+#endif
+
 _Static_assert(MAX_ENTRIES < LOOP_BOUND, "MAX_ENTRIES must be < LOOP_BOUND");
 
 enum bpf_map_type g_map_type = BPF_MAP_TYPE_UNSPEC;
@@ -635,7 +640,7 @@ struct bpf_ringbuf_map {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
-	__uint(max_entries, 1 << 12);
+	__uint(max_entries, PAGE_SIZE);
 } m_ringbuf SEC(".maps");
 
 static inline int check_ringbuf(void)
@@ -643,7 +648,7 @@ static inline int check_ringbuf(void)
 	struct bpf_ringbuf_map *ringbuf = (struct bpf_ringbuf_map *)&m_ringbuf;
 	struct bpf_map *map = (struct bpf_map *)&m_ringbuf;
 
-	VERIFY(check(&ringbuf->map, map, 0, 0, 1 << 12));
+	VERIFY(check(&ringbuf->map, map, 0, 0, PAGE_SIZE));
 
 	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_mmap.c b/tools/testing/selftests/bpf/progs/test_mmap.c
index 4eb42cff5fe9..c22fcfea0767 100644
--- a/tools/testing/selftests/bpf/progs/test_mmap.c
+++ b/tools/testing/selftests/bpf/progs/test_mmap.c
@@ -5,11 +5,16 @@
 #include <stdint.h>
 #include <bpf/bpf_helpers.h>
 
+#ifndef PAGE_SIZE
+/* use reasonable value for various configurations */
+#define PAGE_SIZE 65536
+#endif
+
 char _license[] SEC("license") = "GPL";
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 4096);
+	__uint(max_entries, PAGE_SIZE);
 	__uint(map_flags, BPF_F_MMAPABLE | BPF_F_RDONLY_PROG);
 	__type(key, __u32);
 	__type(value, char);
@@ -17,7 +22,8 @@ struct {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 512 * 4); /* at least 4 pages of data */
+	/* at least 4 pages of data */
+	__uint(max_entries, 4 * (PAGE_SIZE / sizeof (__u64)));
 	__uint(map_flags, BPF_F_MMAPABLE);
 	__type(key, __u32);
 	__type(value, __u64);
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf.c b/tools/testing/selftests/bpf/progs/test_ringbuf.c
index 8ba9959b036b..6e645babdc18 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf.c
@@ -4,6 +4,12 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
+#ifndef PAGE_SIZE
+/* use reasonable value for various configurations */
+#define PAGE_SIZE 65536
+#endif
+
+
 char _license[] SEC("license") = "GPL";
 
 struct sample {
@@ -15,7 +21,7 @@ struct sample {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
-	__uint(max_entries, 1 << 12);
+	__uint(max_entries, PAGE_SIZE);
 } ringbuf SEC(".maps");
 
 /* inputs */
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
index edf3b6953533..13bcf095e06c 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
@@ -4,6 +4,11 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
+#ifndef PAGE_SIZE
+/* use reasonable value for various configurations */
+#define PAGE_SIZE 65536
+#endif
+
 char _license[] SEC("license") = "GPL";
 
 struct sample {
@@ -15,7 +20,7 @@ struct sample {
 
 struct ringbuf_map {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
-	__uint(max_entries, 1 << 12);
+	__uint(max_entries, PAGE_SIZE);
 } ringbuf1 SEC(".maps"),
   ringbuf2 SEC(".maps");
 
-- 
2.29.2

