Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA27B357C35
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhDHGOZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229910AbhDHGOY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nwj7au0bVAHGitRo2xZXQfk6qVnKwbNoNpFW+kN8KBM=;
        b=XaMK4N5PoKcY1jRJ37Ib3F9Z2Xr6hfO5eGpW7J33L0RW3PBrizkzpPc+Ojcey1hHhfOuq6
        FLg9xwEwom5t3a2/S3BPWeF5SXMW/6u9fvz7D/fXuVWZqSyHpTIfTNsqFDQTWw4mCR1cDJ
        T4ilodi8YmCakGfEfKSlEDcNDLd8gi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-k59gRmrZNkyewavFs4Z54A-1; Thu, 08 Apr 2021 02:14:12 -0400
X-MC-Unique: k59gRmrZNkyewavFs4Z54A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FBBB83DD23;
        Thu,  8 Apr 2021 06:14:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C646E7A39F;
        Thu,  8 Apr 2021 06:13:28 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 8/9] selftests/bpf: ringbuf_multi: use runtime page size
Date:   Thu,  8 Apr 2021 09:13:09 +0300
Message-Id: <20210408061310.95877-8-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
 <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Set bpf table sizes dynamically according to the runtime page size
value.

Do not switch to ASSERT macros, keep CHECK, for consistency with the
rest of the test. Can be a separate cleanup patch.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 .../selftests/bpf/prog_tests/ringbuf_multi.c  | 23 ++++++++++++++++---
 .../selftests/bpf/progs/test_ringbuf_multi.c  |  1 -
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index d37161e59bb2..159de99621c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -41,13 +41,30 @@ static int process_sample(void *ctx, void *data, size_t len)
 void test_ringbuf_multi(void)
 {
 	struct test_ringbuf_multi *skel;
-	struct ring_buffer *ringbuf;
+	struct ring_buffer *ringbuf = NULL;
 	int err;
+	int page_size = getpagesize();
 
-	skel = test_ringbuf_multi__open_and_load();
-	if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
+	skel = test_ringbuf_multi__open();
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
 		return;
 
+	err = bpf_map__set_max_entries(skel->maps.ringbuf1, page_size);
+	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
+		goto cleanup;
+
+	err = bpf_map__set_max_entries(skel->maps.ringbuf2, page_size);
+	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
+		goto cleanup;
+
+	err = bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);
+	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
+		goto cleanup;
+
+	err = test_ringbuf_multi__load(skel);
+	if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
+		goto cleanup;
+
 	/* only trigger BPF program for current process */
 	skel->bss->pid = getpid();
 
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
index edf3b6953533..055c10b2ff80 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
@@ -15,7 +15,6 @@ struct sample {
 
 struct ringbuf_map {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
-	__uint(max_entries, 1 << 12);
 } ringbuf1 SEC(".maps"),
   ringbuf2 SEC(".maps");
 
-- 
2.31.1

