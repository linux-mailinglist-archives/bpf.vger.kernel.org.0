Return-Path: <bpf+bounces-15655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2087F4920
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10863B21099
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A12F1DA3B;
	Wed, 22 Nov 2023 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="ThrXgae9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp4.epfl.ch (smtp4.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e059:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDAD9A
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 06:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1700664031;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=WNYXua1bJmm6GlqIgYo3kYPIwV9l3gs4696pPzx7ZbQ=;
      b=ThrXgae9ED9+/kqTp3epjoFipHk+VnI6cJg8He6Hu7UZFG1JLdk5P3+6ryTEXfJ5y
        qMKrS9tO9SRaooe+xWVjsLY9q/TJotZL7hW2NDGjvXvQJqkJGpvO3VDPkzghhsIl6
        pn6t+Osxy4YiDB+GxXj/kw1o4zd/WtOsJIf6rqGBU=
Received: (qmail 10591 invoked by uid 107); 22 Nov 2023 14:40:31 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Wed, 22 Nov 2023 15:40:31 +0100
X-EPFL-Auth: +n/lB6ctDe49/9LhkJO167Hn+euVtnb1UPmkigDIn4UM8uXKUcA=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 15:40:31 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <yonghong.song@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <haoluo@google.com>, <martin.lau@linux.dev>,
	<mathias.payer@nebelwelt.net>, <meng.xu.cs@uwaterloo.ca>,
	<sanidhya.kashyap@epfl.ch>, <song@kernel.org>, <tao.lyu@epfl.ch>
Subject: [PATCH] C inlined assembly for reproducing max<min
Date: Wed, 22 Nov 2023 15:40:18 +0100
Message-ID: <20231122144018.4047232-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d3a518de-ada3-45e8-be3e-df942c2208b5@linux.dev>
References: <d3a518de-ada3-45e8-be3e-df942c2208b5@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa06.intranet.epfl.ch (128.178.224.177) To
 ewa07.intranet.epfl.ch (128.178.224.178)

Hi Yonghong,

Thanks for your reply.
The C inlined assembly code is attached.
I'm using clang-16, but it still fails.

Best,
Tao

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_range.c      | 25 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_range.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e5c61aa6604a..3a5d746f392d 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -77,6 +77,7 @@
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
+#include "verifier_range.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -184,6 +185,7 @@ void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
+void test_verifier_range(void)                { RUN(verifier_range); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_range.c b/tools/testing/selftests/bpf/progs/verifier_range.c
new file mode 100644
index 000000000000..27597eb8135c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_range.c
@@ -0,0 +1,25 @@
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("?tc")
+__log_level(2)
+int test_verifier_range(void)
+{
+    asm volatile (
+        "r5 = 100; \
+        r5 /= 3; \
+        w5 >>= 7; \
+        r5 &= -386969681; \
+        r5 -= -884670597; \
+        w0 = w5; \
+        if w0 & 0x894b6a55 goto +2; \
+        r2 = 1; \
+        r2 = 1; \
+        r0 = 0; \
+        "
+    );
+    return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.25.1


