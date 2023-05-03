Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A940B6F619A
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjECWyN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjECWyK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:54:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B2B44B7
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:54:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab05018381so33316875ad.2
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683154448; x=1685746448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avjys7QME+mclT8grC8JsMORlSrK23DSEmt8E1wDeZY=;
        b=QbNKIDHvDxSP9ng37nGB0Xf/c3db2BL9eIAzhFToX/Rdhr26Szab+KTcpWvilgEBG+
         re532HK3AoXHtwPwBKQSeaA7rH+dgA9taEiLODkbr7pkbM8ZCeNpNxN7tU4PV65iDoLZ
         4nRQ1/OzEEg10hlr5OEna4N0HGhjZAu+i914TFZR8BF5n2QWeCPmW2UUUJSzZ3FfV2Xf
         Dt3faQ4K2/JIFPrsDQECzzLB8yx2fhx4wTnpVTu5URCs/JtiB3GggT4Ji63u/53WIVtU
         F6YD8vs7kptlwe8/NbhTKYP7OuElteYfbLyVFj++0UM9ogWqtLCBD0QJ344CjFumazPi
         rszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154448; x=1685746448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avjys7QME+mclT8grC8JsMORlSrK23DSEmt8E1wDeZY=;
        b=Ik6KvR1pXN/xYXZRSr+Bn97o4jIqBp0q8TdX0YSJZncukqVurCHajvfFDZC5vnjUoV
         Ta64orWGquqDZdhyWTvQ8ahzG5V1XUKC30Nm0W8uLx3l7zZA+K/iIBYawcg06t5CLRYE
         U1KAPmGbdtVXXYY7k3WiCjSOqB+YEv8z2Lb+mT3VmW/zbP8umRG/cjjnvHi4d4fa8aJV
         KW8+nMFOAjfbc8Bp2P9oGdzvOHFbnaPIEkWf8Z6e/y045k3E0Xdj3dkAtwKBKko4oLhm
         clO43R0B+tu1E7wpWsIiUbKrO0w48ZQtpL1RNivbIGXsvtTcaTKThKVob3UsX87CM9hx
         iIbg==
X-Gm-Message-State: AC+VfDxiEV7mSy3TMbLID7/KZqzxpG4mjUNm/EQtUA4/xXPId/l/9tjx
        37nSLxDL/JsaI3GawmjC29FA5irJIbINuw+KypM=
X-Google-Smtp-Source: ACHHUZ7uVC373u6dsI4hr7CsNZ90skCs69b8pKSs16vTc4mZvhv93qM8t+VC/lT5NN9zrRUzzbTIAw==
X-Received: by 2002:a17:902:f68e:b0:1a2:58f1:5e1d with SMTP id l14-20020a170902f68e00b001a258f15e1dmr1938731plg.36.1683154448152;
        Wed, 03 May 2023 15:54:08 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709028a8200b001a641e4738asm2200443plo.1.2023.05.03.15.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:54:07 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, aditi.ghag@isovalent.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH v7 bpf-next 10/10] selftests/bpf: Extend bpf_sock_destroy tests
Date:   Wed,  3 May 2023 22:53:51 +0000
Message-Id: <20230503225351.3700208-11-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds a test case to verify that the
bpf_sock_destroy kfunc is not allowed from
program attach types other than BPF trace iterator.
Unsupprted programs calling the kfunc will be rejected by
the verifier.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   |  2 ++
 .../bpf/progs/sock_destroy_prog_fail.c        | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index d5f76731b4a3..8f7d745e55a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -3,6 +3,7 @@
 #include <bpf/bpf_endian.h>
 
 #include "sock_destroy_prog.skel.h"
+#include "sock_destroy_prog_fail.skel.h"
 #include "network_helpers.h"
 
 #define TEST_NS "sock_destroy_netns"
@@ -204,6 +205,7 @@ void test_sock_destroy(void)
 	if (test__start_subtest("udp_server"))
 		test_udp_server(skel);
 
+	RUN_TESTS(sock_destroy_prog_fail);
 
 cleanup:
 	if (nstoken)
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
new file mode 100644
index 000000000000..dd6850b58e25
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int bpf_sock_destroy(struct sock_common *sk) __ksym;
+
+SEC("tp_btf/tcp_destroy_sock")
+__failure __msg("calling kernel function bpf_sock_destroy is not allowed")
+int BPF_PROG(trace_tcp_destroy_sock, struct sock *sk)
+{
+	/* should not load */
+	bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}
+
-- 
2.34.1

