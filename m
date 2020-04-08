Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D821A206D
	for <lists+bpf@lfdr.de>; Wed,  8 Apr 2020 13:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgDHLxn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Apr 2020 07:53:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52953 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbgDHLxn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Apr 2020 07:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586346821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BaIxF6uhkA2o0cS38cCKXMWycTDocaV5riNLhrf1m8M=;
        b=eoUe5gfuUgAKgvCOd8TF3d55fLPQSOuSeYbh+F+BcVG30Ukmcm7sP47yjsF6a5v88CLZqn
        cw2R5TP9SVXTRwofvZadM0j2WsBGm6CwV+HRNgIJ161pc8XtKjqClnCmU9BQXdmxKcwa1Q
        +Pd0iDIcRbWI20WUZ9GXSHTXVcTVFPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-jEW7ALWHPVSXmEut5F3TIQ-1; Wed, 08 Apr 2020 07:53:37 -0400
X-MC-Unique: jEW7ALWHPVSXmEut5F3TIQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F38E7A89A0A;
        Wed,  8 Apr 2020 11:53:28 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0259B19C70;
        Wed,  8 Apr 2020 11:53:23 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 1ACB4300020FB;
        Wed,  8 Apr 2020 13:53:22 +0200 (CEST)
Subject: [PATCH RFC v2 33/33] selftests/bpf: xdp_adjust_tail add grow tail
 tests
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, zorik@amazon.com, akiyano@amazon.com,
        gtzalik@amazon.com,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Date:   Wed, 08 Apr 2020 13:53:22 +0200
Message-ID: <158634680203.707275.8127841328831399768.stgit@firesoul>
In-Reply-To: <158634658714.707275.7903484085370879864.stgit@firesoul>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend BPF selftest xdp_adjust_tail with grow tail tests, which is added
as subtest's. The first grow test stays in same form as original shrink
test. The second grow test use the newer bpf_prog_test_run_xattr() calls,
and does extra checking of data contents.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c     |  116 +++++++++++++++++++-
 .../bpf/progs/test_xdp_adjust_tail_grow.c          |   33 ++++++
 2 files changed, 144 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index d258f979d5ef..1498627af6e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -4,10 +4,10 @@
 void test_xdp_adjust_tail_shrink(void)
 {
 	const char *file = "./test_xdp_adjust_tail_shrink.o";
+	__u32 duration, retval, size, expect_sz;
 	struct bpf_object *obj;
-	char buf[128];
-	__u32 duration, retval, size;
 	int err, prog_fd;
+	char buf[128];
 
 	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
 	if (CHECK_FAIL(err))
@@ -20,15 +20,121 @@ void test_xdp_adjust_tail_shrink(void)
 	      "ipv4", "err %d errno %d retval %d size %d\n",
 	      err, errno, retval, size);
 
+	expect_sz = sizeof(pkt_v6) - 20;  /* Test shrink with 20 bytes */
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
 				buf, &size, &retval, &duration);
-	CHECK(err || retval != XDP_TX || size != 54,
-	      "ipv6", "err %d errno %d retval %d size %d\n",
+	CHECK(err || retval != XDP_TX || size != expect_sz,
+	      "ipv6", "err %d errno %d retval %d size %d expect-size %d\n",
+	      err, errno, retval, size, expect_sz);
+	bpf_object__close(obj);
+}
+
+void test_xdp_adjust_tail_grow(void)
+{
+	const char *file = "./test_xdp_adjust_tail_grow.o";
+	struct bpf_object *obj;
+	char buf[4096]; /* avoid segfault: large buf to hold grow results */
+	__u32 duration, retval, size, expect_sz;
+	int err, prog_fd;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
+	if (CHECK_FAIL(err))
+		return;
+
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != XDP_DROP,
+	      "ipv4", "err %d errno %d retval %d size %d\n",
 	      err, errno, retval, size);
+
+	expect_sz = sizeof(pkt_v6) + 40; /* Test grow with 40 bytes */
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6) /* 74 */,
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != XDP_TX || size != expect_sz,
+	      "ipv6", "err %d errno %d retval %d size %d expect-size %d\n",
+	      err, errno, retval, size, expect_sz);
+
+	bpf_object__close(obj);
+}
+
+void test_xdp_adjust_tail_grow2(void)
+{
+	const char *file = "./test_xdp_adjust_tail_grow.o";
+	char buf[4096]; /* avoid segfault: large buf to hold grow results */
+	int tailroom = 320; /* SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) */;
+	struct bpf_object *obj;
+	int err, cnt, i;
+	int max_grow;
+
+	struct bpf_prog_test_run_attr tattr = {
+		.repeat 	= 1,
+		.data_in	= &buf,
+		.data_out	= &buf,
+		.data_size_in	= 0, /* Per test */
+		.data_size_out	= 0, /* Per test */
+	};
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &tattr.prog_fd);
+	if (CHECK_ATTR(err, "load", "err %d errno %d\n", err, errno))
+		return;
+
+	/* Test case-64 */
+	memset(buf, 1, sizeof(buf));
+	tattr.data_size_in  =  64; /* Determine test case via pkt size */
+	tattr.data_size_out = 128; /* Limit copy_size */
+	/* Kernel side alloc packet memory area that is zero init */
+	err = bpf_prog_test_run_xattr(&tattr);
+
+	CHECK_ATTR(errno != ENOSPC /* Due limit copy_size in bpf_test_finish */
+		   || tattr.retval != XDP_TX
+		   || tattr.data_size_out != 192, /* Expected grow size */
+		   "case-64",
+		   "err %d errno %d retval %d size %d\n",
+		   err, errno, tattr.retval, tattr.data_size_out);
+
+	/* Extra checks for data contents */
+	CHECK_ATTR(tattr.data_size_out != 192
+		   || buf[0]   != 1 ||  buf[63]  != 1  /*  0-63  memset to 1 */
+		   || buf[64]  != 0 ||  buf[127] != 0  /* 64-127 memset to 0 */
+		   || buf[128] != 1 ||  buf[191] != 1, /*128-191 memset to 1 */
+		   "case-64-data",
+		   "err %d errno %d retval %d size %d\n",
+		   err, errno, tattr.retval, tattr.data_size_out);
+
+	/* Test case-128 */
+	memset(buf, 2, sizeof(buf));
+	tattr.data_size_in  = 128; /* Determine test case via pkt size */
+	tattr.data_size_out = sizeof(buf);   /* Copy everything */
+	err = bpf_prog_test_run_xattr(&tattr);
+
+	max_grow = 4096 - XDP_PACKET_HEADROOM -	tailroom; /* 3520 */
+	CHECK_ATTR(err
+		   || tattr.retval != XDP_TX
+		   || tattr.data_size_out != max_grow, /* Expect max grow size */
+		   "case-128",
+		   "err %d errno %d retval %d size %d expect-size %d\n",
+		   err, errno, tattr.retval, tattr.data_size_out, max_grow);
+
+	/* Extra checks for data contents: Count grow size, will contain zeros */
+	for (i = 0, cnt = 0; i < sizeof(buf); i++) {
+		if (buf[i] == 0)
+			cnt++;
+	}
+	CHECK_ATTR((cnt != (max_grow - tattr.data_size_in)) /* Grow increase */
+		   || tattr.data_size_out != max_grow, /* Total grow size */
+		   "case-128-data",
+		   "err %d errno %d retval %d size %d grow-size %d\n",
+		   err, errno, tattr.retval, tattr.data_size_out, cnt);
+
 	bpf_object__close(obj);
 }
 
 void test_xdp_adjust_tail(void)
 {
-	test_xdp_adjust_tail_shrink();
+	if (test__start_subtest("xdp_adjust_tail_shrink"))
+		test_xdp_adjust_tail_shrink();
+	if (test__start_subtest("xdp_adjust_tail_grow"))
+		test_xdp_adjust_tail_grow();
+	if (test__start_subtest("xdp_adjust_tail_grow2"))
+		test_xdp_adjust_tail_grow2();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
new file mode 100644
index 000000000000..3d66599eee2e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("xdp_adjust_tail_grow")
+int _xdp_adjust_tail_grow(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	unsigned int data_len;
+	int offset = 0;
+
+	/* Data length determine test case */
+	data_len = data_end - data;
+
+	if (data_len == 54) { /* sizeof(pkt_v4) */
+		offset = 4096; /* test too large offset */
+	} else if (data_len == 74) { /* sizeof(pkt_v6) */
+		offset = 40;
+	} else if (data_len == 64) {
+		offset = 128;
+	} else if (data_len == 128) {
+		offset = 4096 - 256 - 320 - data_len; /* Max tail grow 3520 */
+	} else {
+		return XDP_ABORTED; /* No matching test */
+	}
+
+	if (bpf_xdp_adjust_tail(xdp, offset))
+		return XDP_DROP;
+	return XDP_TX;
+}
+
+char _license[] SEC("license") = "GPL";


