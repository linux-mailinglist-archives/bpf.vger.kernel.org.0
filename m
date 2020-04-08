Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68751A206A
	for <lists+bpf@lfdr.de>; Wed,  8 Apr 2020 13:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgDHLxb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Apr 2020 07:53:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726924AbgDHLxb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Apr 2020 07:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586346810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOIT+50UaskstZKzUohgylRkHvdR91qp4pnNKr6BjiM=;
        b=T9gfVFwPpOJeqHlj7FgHMiWZ7+ZTdPrdO+BCwigadV9XQu8gmPlaAcoee2soiUnz4xqBFf
        YTZ1xqfJeW2pmtd3JaGy1C7lvGgHLPQgZBW9kQwUEwuhyaQlgYjUtsPz5Tx8VkwUJQM2Sz
        pMBZ7f6kTsy0MPItcZ9XAtKDmOTh3bY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-aDnH0EhjNQuUjCLfJc30Ow-1; Wed, 08 Apr 2020 07:53:26 -0400
X-MC-Unique: aDnH0EhjNQuUjCLfJc30Ow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A422800D50;
        Wed,  8 Apr 2020 11:53:24 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E995260BF7;
        Wed,  8 Apr 2020 11:53:17 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 06450300020FA;
        Wed,  8 Apr 2020 13:53:17 +0200 (CEST)
Subject: [PATCH RFC v2 32/33] selftests/bpf: adjust BPF selftest for
 xdp_adjust_tail
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
Date:   Wed, 08 Apr 2020 13:53:17 +0200
Message-ID: <158634679695.707275.8490414568501090905.stgit@firesoul>
In-Reply-To: <158634658714.707275.7903484085370879864.stgit@firesoul>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current selftest for BPF-helper xdp_adjust_tail only shrink tail.
Make it more clear that this is a shrink test case.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c     |    9 +++++-
 .../testing/selftests/bpf/progs/test_adjust_tail.c |   30 --------------------
 .../bpf/progs/test_xdp_adjust_tail_shrink.c        |   30 ++++++++++++++++++++
 3 files changed, 37 insertions(+), 32 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_adjust_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 3744196d7cba..d258f979d5ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 
-void test_xdp_adjust_tail(void)
+void test_xdp_adjust_tail_shrink(void)
 {
-	const char *file = "./test_adjust_tail.o";
+	const char *file = "./test_xdp_adjust_tail_shrink.o";
 	struct bpf_object *obj;
 	char buf[128];
 	__u32 duration, retval, size;
@@ -27,3 +27,8 @@ void test_xdp_adjust_tail(void)
 	      err, errno, retval, size);
 	bpf_object__close(obj);
 }
+
+void test_xdp_adjust_tail(void)
+{
+	test_xdp_adjust_tail_shrink();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_adjust_tail.c b/tools/testing/selftests/bpf/progs/test_adjust_tail.c
deleted file mode 100644
index b7fc85769bdc..000000000000
--- a/tools/testing/selftests/bpf/progs/test_adjust_tail.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- * Copyright (c) 2018 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#include <linux/bpf.h>
-#include <linux/if_ether.h>
-#include <bpf/bpf_helpers.h>
-
-int _version SEC("version") = 1;
-
-SEC("xdp_adjust_tail")
-int _xdp_adjust_tail(struct xdp_md *xdp)
-{
-	void *data_end = (void *)(long)xdp->data_end;
-	void *data = (void *)(long)xdp->data;
-	int offset = 0;
-
-	if (data_end - data == 54)
-		offset = 256;
-	else
-		offset = 20;
-	if (bpf_xdp_adjust_tail(xdp, 0 - offset))
-		return XDP_DROP;
-	return XDP_TX;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
new file mode 100644
index 000000000000..c8a7c17b54f4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2018 Facebook
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ */
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <bpf/bpf_helpers.h>
+
+int _version SEC("version") = 1;
+
+SEC("xdp_adjust_tail_shrink")
+int _xdp_adjust_tail_shrink(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	int offset = 0;
+
+	if (data_end - data == 54) /* sizeof(pkt_v4) */
+		offset = 256; /* shrink too much */
+	else
+		offset = 20;
+	if (bpf_xdp_adjust_tail(xdp, 0 - offset))
+		return XDP_DROP;
+	return XDP_TX;
+}
+
+char _license[] SEC("license") = "GPL";


