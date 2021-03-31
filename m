Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83EE3504EF
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhCaQpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234003AbhCaQpZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 12:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xFKRDA7GxWzWD13Ezn+FHhuS3mF6hkJYSoOAJxBcCA=;
        b=OuhyUJHppK/Z27Z6eIQOTob7e+aTrPm2CgP5hSim81L8whCEyv676An5C/07gNcGHBhjgM
        BL5GGS7iBOlIxOFWg6ipsl0NzkK9OWmFSBvDMBw8WWxtR6jc1XJJuoDk3RLCiOdPY9kd6W
        tCZ6LeFp70EjOaejQaV9PlR5XyfPYaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-b1x4-XifNyy8bJTHOb1ZFQ-1; Wed, 31 Mar 2021 12:45:23 -0400
X-MC-Unique: b1x4-XifNyy8bJTHOb1ZFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27B0A10082EA;
        Wed, 31 Mar 2021 16:45:22 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-48.ams2.redhat.com [10.36.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C67EDA8438;
        Wed, 31 Mar 2021 16:45:20 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v3 4/8] selftests/bpf: pass page size from userspace in map_ptr
Date:   Wed, 31 Mar 2021 19:45:00 +0300
Message-Id: <20210331164504.320614-4-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use ASSERT to check result but keep CHECK where format was used to
report error.

Use bpf_map__set_max_entries() to set map size dynamically from
userspace according to page size.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/map_ptr.c | 15 +++++++++++++--
 tools/testing/selftests/bpf/progs/map_ptr_kern.c |  4 ++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_ptr.c b/tools/testing/selftests/bpf/prog_tests/map_ptr.c
index c230a573c373..4972f92205c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_ptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_ptr.c
@@ -12,11 +12,22 @@ void test_map_ptr(void)
 	__u32 duration = 0, retval;
 	char buf[128];
 	int err;
+	int page_size = getpagesize();
 
-	skel = map_ptr_kern__open_and_load();
-	if (CHECK(!skel, "skel_open_load", "open_load failed\n"))
+	skel = map_ptr_kern__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	err = bpf_map__set_max_entries(skel->maps.m_ringbuf, page_size);
+	if (!ASSERT_OK(err, "bpf_map__set_max_entries"))
+		goto cleanup;
+
+	err = map_ptr_kern__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	skel->bss->page_size = page_size;
+
 	err = bpf_prog_test_run(bpf_program__fd(skel->progs.cg_skb), 1, &pkt_v4,
 				sizeof(pkt_v4), buf, NULL, &retval, NULL);
 
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index d8850bc6a9f1..0e06789ad4d2 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -12,6 +12,7 @@ _Static_assert(MAX_ENTRIES < LOOP_BOUND, "MAX_ENTRIES must be < LOOP_BOUND");
 
 enum bpf_map_type g_map_type = BPF_MAP_TYPE_UNSPEC;
 __u32 g_line = 0;
+int page_size; /* userspace should set it */
 
 #define VERIFY_TYPE(type, func) ({	\
 	g_map_type = type;		\
@@ -635,7 +636,6 @@ struct bpf_ringbuf_map {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
-	__uint(max_entries, 1 << 12);
 } m_ringbuf SEC(".maps");
 
 static inline int check_ringbuf(void)
@@ -643,7 +643,7 @@ static inline int check_ringbuf(void)
 	struct bpf_ringbuf_map *ringbuf = (struct bpf_ringbuf_map *)&m_ringbuf;
 	struct bpf_map *map = (struct bpf_map *)&m_ringbuf;
 
-	VERIFY(check(&ringbuf->map, map, 0, 0, 1 << 12));
+	VERIFY(check(&ringbuf->map, map, 0, 0, page_size));
 
 	return 1;
 }
-- 
2.31.1

