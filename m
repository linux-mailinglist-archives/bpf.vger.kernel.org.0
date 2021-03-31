Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60C3504F1
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhCaQps (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhCaQpe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 12:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nwj7au0bVAHGitRo2xZXQfk6qVnKwbNoNpFW+kN8KBM=;
        b=KbwmTe9fiFFo17h+DcKd1F3ljm9ufQ7PeZe5Y3RPXjM89sJpcmDXJ90LIdlG2cHybwamXG
        5JXQ3dSdBmhy0+W1aUO3cckgZSuXVPqAF6YvWUWI2PZAa3KC28B3CFvSKo6YJ9WDMtYIWL
        IPzxTmHEuT6ErUsO9ITxPoieAKlG94k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-SzsGfUP8Ppelr8wVbp-twQ-1; Wed, 31 Mar 2021 12:45:29 -0400
X-MC-Unique: SzsGfUP8Ppelr8wVbp-twQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 674BE1084C95;
        Wed, 31 Mar 2021 16:45:28 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-48.ams2.redhat.com [10.36.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3210316922;
        Wed, 31 Mar 2021 16:45:26 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: ringbuf_multi: use runtime page size
Date:   Wed, 31 Mar 2021 19:45:04 +0300
Message-Id: <20210331164504.320614-8-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

