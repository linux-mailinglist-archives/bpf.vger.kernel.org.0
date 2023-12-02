Return-Path: <bpf+bounces-16497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D8A801C44
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 11:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50A31C20B31
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D38715AF7;
	Sat,  2 Dec 2023 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="W9xiqWwx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp0.epfl.ch (smtp0.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e058:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5F123
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 02:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1701513856;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=eX+al20/xtD+gaHQhh0TNlkAwRMGx6OKAt6J7zT0FNU=;
      b=W9xiqWwxb7XVGCtiy6BzCvM6ezTBatcxw70Yr25kATiZ5xdu1eMt0ZCYyRSchSmiK
        4ivOBWm8nGKoqot5pQddIcpXaDpcRJlD7pRMGALicT8b7ApKh9BpH8KlugjujdMtT
        f2kWFQoFJk8bjxaOgxH1xeXddRmL5p766su0rqEoA=
Received: (qmail 17951 invoked by uid 107); 2 Dec 2023 10:44:16 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Sat, 02 Dec 2023 11:44:16 +0100
X-EPFL-Auth: LA16NkJ7gVNvYXADlBRpPx7yC/HLWmDjRgeit9xn0oR2ey5EgVQ=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 2 Dec 2023 11:44:15 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <yonghong.song@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <haoluo@google.com>, <martin.lau@linux.dev>,
	<song@kernel.org>, <tao.lyu@epfl.ch>
Subject: [PATCH] C inlined assembly for reproducing max<min
Date: Sat, 2 Dec 2023 11:44:03 +0100
Message-ID: <20231202104403.715483-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <56c00185-0b14-40d8-b72b-5a79797b94c0@linux.dev>
References: <56c00185-0b14-40d8-b72b-5a79797b94c0@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa02.intranet.epfl.ch (128.178.224.159) To
 ewa07.intranet.epfl.ch (128.178.224.178)

Hi,

We discussed the max<min issue in [1].
But it cannot reproduced with a C inlined assembly test,
as llvm doesn't support 'jset' assembly.

Thanks to Yonghong's patch [2], 
it is now supported in the latest llvm-18.

So, I resubmit the C inlined assembly test for the max<min issue here again.

[1] https://lore.kernel.org/bpf/20231121173206.3594040-1-tao.lyu@epfl.ch/
[2] https://github.com/yonghong-song/llvm-project/commit/e247e6ff272ce70003ca67f62be178f332f9de0f

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_range.c      | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+)
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
index 000000000000..affe09117b0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_range.c
@@ -0,0 +1,29 @@
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if __clang_major__ >= 18
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
+
+#endif
-- 
2.25.1


