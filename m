Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD8D357C36
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhDHGO0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhDHGOY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkYs017JkymhNMCLGKpP+Y5PL7IjOVaHvxFAECG8pow=;
        b=YAzrn2474OtAEoSqOGbUp+mRs9s5E8iO5GxC4xFAs0U3ZRlxqRWLM0X0VIBAYvUUGoQYFH
        B2xrUG3WjpOXE9W4WobFvlmXSK9dIAE73FuojHn01TMPoDWQ759ksR6a2C9BAo9BoXlJp2
        +vCYUutEodP8wxC06bKKZcL/is7pSqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-FIxreC93PrGL7l60moJcqQ-1; Thu, 08 Apr 2021 02:14:12 -0400
X-MC-Unique: FIxreC93PrGL7l60moJcqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F8E383DD22;
        Thu,  8 Apr 2021 06:14:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41D857A39D;
        Thu,  8 Apr 2021 06:13:24 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 6/9] selftests/bpf: ringbuf: use runtime page size
Date:   Thu,  8 Apr 2021 09:13:07 +0300
Message-Id: <20210408061310.95877-6-yauheni.kaliuta@redhat.com>
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
 .../testing/selftests/bpf/prog_tests/ringbuf.c  | 17 +++++++++++++----
 .../testing/selftests/bpf/progs/test_ringbuf.c  |  1 -
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index fddbc5db5d6a..de78617f6550 100644
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
+		goto cleanup;
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

