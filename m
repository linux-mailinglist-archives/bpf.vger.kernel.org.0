Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9428D357C38
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhDHGO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229911AbhDHGOY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paxVgMAoONrYAeNSgAW5QUom6MkNU0/qj2A6G+/PWLA=;
        b=MIT1QIXNMQw++dnfhY7LiVgoDUM8vwBpzAGla2bJ9WozWRJYGuiFLXDIX7WkTdi4bWRIXH
        4w3jHVZcOCozeebn3BHXMqHudy7i2NgRRx2x8u1UDNyI68ph6oD/VidQV/2X5BR5CBbDmk
        /E3WHNX01EakcHRi54VRPanJ/RcAGqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Myu72hKlOYeeChMS_9sPow-1; Thu, 08 Apr 2021 02:14:12 -0400
X-MC-Unique: Myu72hKlOYeeChMS_9sPow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3166987A826;
        Thu,  8 Apr 2021 06:14:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 761737A3A2;
        Thu,  8 Apr 2021 06:13:30 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 9/9] selftests/bpf: ringbuf_multi: test bpf_map__set_inner_map_fd
Date:   Thu,  8 Apr 2021 09:13:10 +0300
Message-Id: <20210408061310.95877-9-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
 <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test map__set_inner_map_fd() interaction with map-in-map
initialization. Use hashmap of maps just to make it different to
existing array of maps.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 .../testing/selftests/bpf/prog_tests/ringbuf_multi.c  | 11 +++++++++++
 .../testing/selftests/bpf/progs/test_ringbuf_multi.c  | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index 159de99621c7..0e79a7d28361 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -44,6 +44,7 @@ void test_ringbuf_multi(void)
 	struct ring_buffer *ringbuf = NULL;
 	int err;
 	int page_size = getpagesize();
+	int proto_fd;
 
 	skel = test_ringbuf_multi__open();
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
@@ -61,10 +62,20 @@ void test_ringbuf_multi(void)
 	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
 		goto cleanup;
 
+	proto_fd = bpf_create_map(BPF_MAP_TYPE_RINGBUF, 0, 0, page_size, 0);
+	if (CHECK(proto_fd == -1, "bpf_create_map", "bpf_create_map failed\n"))
+		goto cleanup;
+
+	err = bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
+	if (CHECK(err != 0, "bpf_map__set_inner_map_fd", "bpf_map__set_inner_map_fd failed\n"))
+		goto cleanup;
+
 	err = test_ringbuf_multi__load(skel);
 	if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
 		goto cleanup;
 
+	close(proto_fd);
+
 	/* only trigger BPF program for current process */
 	skel->bss->pid = getpid();
 
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
index 055c10b2ff80..197b86546dca 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
@@ -30,6 +30,17 @@ struct {
 	},
 };
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__array(values, struct ringbuf_map);
+} ringbuf_hash SEC(".maps") = {
+	.values = {
+		[0] = &ringbuf1,
+	},
+};
+
 /* inputs */
 int pid = 0;
 int target_ring = 0;
-- 
2.31.1

