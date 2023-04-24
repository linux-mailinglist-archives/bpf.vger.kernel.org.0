Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8326ED213
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjDXQHz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjDXQHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695E86587
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B0560C7A
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA6BC433D2;
        Mon, 24 Apr 2023 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352472;
        bh=KqYyrDf/DavyQZwTLj2tISjJdWnbVRwGS0L6EVvEp3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/pcvEudlwNQQpnkwtrt1y0TXPJEafWeRaQ8zKezzBWiaVXxXuRKrC1zzdezTxWsx
         93wlnNYcabPEh34vNCGP62P+nVNFjCAuicEyL3V9tQEARPCqYSkPCyJXepJdX2iw7d
         I2mtq7S3KFecQvC/FnvghqwsLcnDgy7cFzFdZ7Lkt2Fq0u1766lLigYrMOSrY5CG2T
         CNvqzkCJ35G9Guz79xyTuAjx73bSo2FNMdFCZMGL3qUEdPKP2mvvCQ7Bkco/laMTmK
         du4Ezb/1k2X1SlcnIZdkurly3OBHckzIU6K+23TZdxinGIiF+42V51tx8QWFvxgElp
         JnZqCHEPvxQDw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 18/20] selftests/bpf: Add usdt_multi test program
Date:   Mon, 24 Apr 2023 18:04:45 +0200
Message-Id: <20230424160447.2005755-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding usdt_multi test program that defines 50k usdts and will
serve as attach point for uprobe_multi usdt bench test in
following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile     |  5 +++++
 tools/testing/selftests/bpf/usdt_multi.c | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/usdt_multi.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 506d92d5505a..33278c21ed9d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -569,6 +569,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
 		       $(OUTPUT)/uprobe_multi				\
+		       $(OUTPUT)/usdt_multi				\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
@@ -676,6 +677,10 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
 
+$(OUTPUT)/usdt_multi: usdt_multi.c
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
+
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
diff --git a/tools/testing/selftests/bpf/usdt_multi.c b/tools/testing/selftests/bpf/usdt_multi.c
new file mode 100644
index 000000000000..3216d15dcd76
--- /dev/null
+++ b/tools/testing/selftests/bpf/usdt_multi.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sdt.h>
+
+#define PROBE STAP_PROBE(test, usdt);
+
+#define PROBE10    PROBE PROBE PROBE PROBE PROBE PROBE PROBE PROBE PROBE PROBE
+#define PROBE100   PROBE10 PROBE10 PROBE10 PROBE10 PROBE10 \
+		   PROBE10 PROBE10 PROBE10 PROBE10 PROBE10
+#define PROBE1000  PROBE100 PROBE100 PROBE100 PROBE100 PROBE100 \
+		   PROBE100 PROBE100 PROBE100 PROBE100 PROBE100
+#define PROBE10000 PROBE1000 PROBE1000 PROBE1000 PROBE1000 PROBE1000 \
+		   PROBE1000 PROBE1000 PROBE1000 PROBE1000 PROBE1000
+
+int main(void)
+{
+	PROBE10000
+	PROBE10000
+	PROBE10000
+	PROBE10000
+	PROBE10000
+	return 0;
+}
-- 
2.40.0

