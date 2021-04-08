Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD23357C39
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhDHGO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229921AbhDHGOY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TEgqazO+FOorNZlPkCKmy3FntovsJiuqTzZZRzi+kY=;
        b=I9azdPLXy5aSk5TtA1NISplFnTGG7c7K4oC6TYPBpQqpMJB7gbo2burv7aOPsFozuIWXhE
        KLYWkEMrFzzCleN8q6WpO5Fq0sHUE/pvJOv5VW94kywZMTQnzk9JmIELY4TG8PMin3Zy9F
        qjQEVi/QzPR7ZygyuGAztfI8CPuH444=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-UoC9QbxwPS6rHQOM0ldZBQ-1; Thu, 08 Apr 2021 02:14:12 -0400
X-MC-Unique: UoC9QbxwPS6rHQOM0ldZBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FB36A6864;
        Thu,  8 Apr 2021 06:14:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A54A47A39A;
        Thu,  8 Apr 2021 06:13:21 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 4/9] selftests/bpf: pass page size from userspace in map_ptr
Date:   Thu,  8 Apr 2021 09:13:05 +0300
Message-Id: <20210408061310.95877-4-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
 <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use ASSERT to check result but keep CHECK where format was used to
report error.

Use bpf_map__set_max_entries() to set map size dynamically from
userspace according to page size.

Zero-initialize the variable in bpf prog, otherwise it will cause
problems on some versions of Clang.

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
index d8850bc6a9f1..d1d304c980f0 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -12,6 +12,7 @@ _Static_assert(MAX_ENTRIES < LOOP_BOUND, "MAX_ENTRIES must be < LOOP_BOUND");
 
 enum bpf_map_type g_map_type = BPF_MAP_TYPE_UNSPEC;
 __u32 g_line = 0;
+int page_size = 0; /* userspace should set it */
 
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

