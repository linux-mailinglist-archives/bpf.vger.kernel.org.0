Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455CD53CC75
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbiFCPmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245612AbiFCPmW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 11:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AD186401
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654270937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NCo7B84IbZwp1XsoEqfFhvfdIIB+fp6To7YmcMn/zU=;
        b=F8/3mGlixLMiC5rPSfRJ4lx5AQKQBAS7QmwRaLqw/+bYA6MUL6xebrQvT37zeeRvBlDKTx
        +w90bg9Z/i3vUZSZDy3ayr4mwEhuUw8UCJxm2vTXJ5vWDWr2rKd8n0yL/WhjVZGiGbnZpw
        iAkvmsF/05Fv2mF0KwvHLwmVbXv0M84=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-huyLmAp0P3e2WFFG9C5e-Q-1; Fri, 03 Jun 2022 11:42:16 -0400
X-MC-Unique: huyLmAp0P3e2WFFG9C5e-Q-1
Received: by mail-ed1-f71.google.com with SMTP id j4-20020aa7ca44000000b0042dd12a7bc5so5669950edt.13
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 08:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8NCo7B84IbZwp1XsoEqfFhvfdIIB+fp6To7YmcMn/zU=;
        b=8Bq5a45r154NVQrT86EMezaGDQeOzqIYYiM6TUG1HDcYYlg1WBuxIWTsT16OB0gFoB
         ipFSzxeZyLu8dAikay9hl9k4IoRyUJcTINIBbmXjasK+AQg8XY+VVg0YS+2x4U/ugU3g
         qxFukYDaFczNI/XHEnv28/R/FqQdpK2BKiIyZKkjI3kx++x5bdG2M+Urk+1q8zU69FYo
         Qpbb2FEVPdtiXkhqjIHTAysKwLaUAKHRGPEF/4KVgVKgZBmLNC7GYlhI9rq5DhI2Hy8R
         Mc08J0l2CbAqw6XBoBh9d7gsiZ2cvHTbGiT9cNp5mM4VEvdtwwOiJ+n5mMeIefAd9kkK
         xiNg==
X-Gm-Message-State: AOAM530bulSTw6z7c68bY/MMEEmK6eSEc6N74jlII5dg/wFQ0/C76ys3
        JGYkbVdKzXXu7qfxlthibTvsTfNF2KbPq+XSNtui9gurJH06rOHBbAq+D868iSlZBawHX3igSKf
        scztTejukoRu1
X-Received: by 2002:a05:6402:4412:b0:42b:a784:3dd2 with SMTP id y18-20020a056402441200b0042ba7843dd2mr11743439eda.162.1654270934956;
        Fri, 03 Jun 2022 08:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuzE5eIyuIu2WL5SpNrIPkWGKyxrMr96WC8p4jcvTzUUA0GPpH16KMw9jRibBCnKNem4sf8Q==
X-Received: by 2002:a05:6402:4412:b0:42b:a784:3dd2 with SMTP id y18-20020a056402441200b0042ba7843dd2mr11743408eda.162.1654270934721;
        Fri, 03 Jun 2022 08:42:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402400700b0042e15364d14sm2374709eda.8.2022.06.03.08.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 08:42:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 851BB4053BE; Fri,  3 Jun 2022 17:42:12 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Add selftest for calling global functions from freplace
Date:   Fri,  3 Jun 2022 17:40:27 +0200
Message-Id: <20220603154028.24904-2-toke@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603154028.24904-1-toke@redhat.com>
References: <20220603154028.24904-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest that calls a global function with a context object parameter
from an freplace function to check that the program context type is
correctly converted to the freplace target when fetching the context type
from the kernel BTF.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 13 ++++++++++
 .../bpf/progs/freplace_global_func.c          | 24 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_global_func.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index d9aad15e0d24..6e86a1d92e97 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -395,6 +395,17 @@ static void test_func_map_prog_compatibility(void)
 				     "./test_attach_probe.o");
 }
 
+static void test_func_replace_global_func(void)
+{
+	const char *prog_name[] = {
+		"freplace/test_pkt_access",
+	};
+	test_fexit_bpf2bpf_common("./freplace_global_func.o",
+				  "./test_pkt_access.o",
+				  ARRAY_SIZE(prog_name),
+				  prog_name, false, NULL);
+}
+
 /* NOTE: affect other tests, must run in serial mode */
 void serial_test_fexit_bpf2bpf(void)
 {
@@ -416,4 +427,6 @@ void serial_test_fexit_bpf2bpf(void)
 		test_func_replace_multi();
 	if (test__start_subtest("fmod_ret_freplace"))
 		test_fmod_ret_freplace();
+	if (test__start_subtest("func_replace_global_func"))
+		test_func_replace_global_func();
 }
diff --git a/tools/testing/selftests/bpf/progs/freplace_global_func.c b/tools/testing/selftests/bpf/progs/freplace_global_func.c
new file mode 100644
index 000000000000..d9f8276229cc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_global_func.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+#include <linux/stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+
+__attribute__ ((noinline))
+int test_ctx_global_func(struct __sk_buff *skb)
+{
+	volatile int retval = 1;
+	return retval;
+}
+
+__u64 test_pkt_access_global_func = 0;
+SEC("freplace/test_pkt_access")
+int new_test_pkt_access(struct __sk_buff *skb)
+{
+	test_pkt_access_global_func = test_ctx_global_func(skb);
+	return -1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.36.1

