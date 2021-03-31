Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3D3504EC
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhCaQpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234182AbhCaQp2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 12:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMdkdegJVqh4WRz92PW5PUU8JBi58ZeBVxY5/fxVB8E=;
        b=CsX9CNYgYRnDpk/ConukTmeHVvZLHM0WP9TE0kiVSn0zCmld4qiva3RdccKcA2UW16LAmy
        4ZD2c+WdI65P7J8eHJxnx9jtpuW9WmDZgcMXpaMCHgUemhRdCwZpER+JK4OM3Azu3jaCaB
        SlDpKGUeKjKrcMBJpdgfxQtg2GhkfFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-qtmhY2S_OIC0OBu7Y7Le-A-1; Wed, 31 Mar 2021 12:45:26 -0400
X-MC-Unique: qtmhY2S_OIC0OBu7Y7Le-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BDFC50201;
        Wed, 31 Mar 2021 16:45:25 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-48.ams2.redhat.com [10.36.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DF1816922;
        Wed, 31 Mar 2021 16:45:23 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v3 6/8] selftests/bpf: ringbuf: use runtime page size
Date:   Wed, 31 Mar 2021 19:45:02 +0300
Message-Id: <20210331164504.320614-6-yauheni.kaliuta@redhat.com>
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
 .../testing/selftests/bpf/prog_tests/ringbuf.c  | 17 +++++++++++++----
 .../testing/selftests/bpf/progs/test_ringbuf.c  |  1 -
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index fddbc5db5d6a..8c9f71a816f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -87,11 +87,20 @@ void test_ringbuf(void)
 	pthread_t thread;
 	long bg_ret = -1;
 	int err, cnt;
+	int page_size = getpagesize();
 
-	skel = test_ringbuf__open_and_load();
-	if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
+	skel = test_ringbuf__open();
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
 		return;
 
+	err = bpf_map__set_max_entries(skel->maps.ringbuf, page_size);
+	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
+               goto cleanup;
+
+	err = test_ringbuf__load(skel);
+	if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
+		goto cleanup;
+
 	/* only trigger BPF program for current process */
 	skel->bss->pid = getpid();
 
@@ -110,9 +119,9 @@ void test_ringbuf(void)
 	CHECK(skel->bss->avail_data != 3 * rec_sz,
 	      "err_avail_size", "exp %ld, got %ld\n",
 	      3L * rec_sz, skel->bss->avail_data);
-	CHECK(skel->bss->ring_size != 4096,
+	CHECK(skel->bss->ring_size != page_size,
 	      "err_ring_size", "exp %ld, got %ld\n",
-	      4096L, skel->bss->ring_size);
+	      (long)page_size, skel->bss->ring_size);
 	CHECK(skel->bss->cons_pos != 0,
 	      "err_cons_pos", "exp %ld, got %ld\n",
 	      0L, skel->bss->cons_pos);
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf.c b/tools/testing/selftests/bpf/progs/test_ringbuf.c
index 8ba9959b036b..6b3f288b7c63 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf.c
@@ -15,7 +15,6 @@ struct sample {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
-	__uint(max_entries, 1 << 12);
 } ringbuf SEC(".maps");
 
 /* inputs */
-- 
2.31.1

