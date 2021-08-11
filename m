Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E43E919C
	for <lists+bpf@lfdr.de>; Wed, 11 Aug 2021 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhHKMhb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 08:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhHKMhW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 08:37:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17CC061799
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 05:36:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q11so2821527wrr.9
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vLy1Vn7jBZyaLX0Agp8iaSYDXRAQJFJPZZDH7bDt4Hg=;
        b=snPjhpT9HrNnQFId6jnvsMs7NgWbwtqAl2Lc0zrAJUDEgLi942APShyRb1ATtocRfb
         9wRoojWP1CeWDSW97XniV95vk1DqwIQOyu10RSgwWuB8mgwsOwwu3p8vJNyRiJlcO0ba
         qMAt3wCFEpHEl05+G+QQM3LRvRqQS/acfTBkDCmPHE0TcLlFTDD3IMZIKEmChZ57klMQ
         kBHLHexfDJKVlE8I8Fm9kKsp1bl4moEFvMsoRMkNlXzVi1OEXdHCr0vMwc1a6o8+0Whl
         RIMDdon0/sjTKp2pwPBWVwMUyA3hiA2u/O4zaWPtJV3dZ5WBDLDxpzT7Zff0eBFqsSqV
         lCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vLy1Vn7jBZyaLX0Agp8iaSYDXRAQJFJPZZDH7bDt4Hg=;
        b=i/zdZLNvNNsIrkkC7MS1Ynk/7tf94ZJFkRq3DfPpeH1zMOVJdpfoPCE/gd+Vx/c5o/
         TfP2nNA/Hr1s8KJM9Y/qP6iOfqY4LyEO95Kl9ikcsqYfqT1sD9X8fEK+vuGgnApc0+6A
         QTnhPIEGQ0wmmNrL3TwVH5DNvYiKvNEAAGcMcgkOtGVsUfnKV9mwwsTdPq5lLnnSw3Ws
         tKLhyQO+FW4cQ9jBj84p4TYFZ8RKFdyiao9o1Tgy6kduauPJMfUutCASsvX8oOcV/Ne0
         YL4HYwxA24Gr2Q9RjuWjPUOV8KKjgLOCqG7oi9FL6bQrySe6wErWjxTIQpAGTQqmeI7q
         wuOg==
X-Gm-Message-State: AOAM532WN1qciUbOPgx/3vJ9RS1p15WTP7Cv4FBDd3taTOfEUSqbYLM7
        poV2pAt1i2ryiJl/7K8l7qLx+8Do+Mjs
X-Google-Smtp-Source: ABdhPJzSNgHhnJw2m8+zUVzUpiOg3er0joZTaBTqA8ZbQ2Anmr3xNibFLkP4tbxhsy8pS66xw1MYVA==
X-Received: by 2002:adf:fc0d:: with SMTP id i13mr35405010wrr.276.1628685416610;
        Wed, 11 Aug 2021 05:36:56 -0700 (PDT)
Received: from localhost.localdomain ([77.109.191.101])
        by smtp.gmail.com with ESMTPSA id b80sm482512wmb.38.2021.08.11.05.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:36:55 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix running of XDP bonding tests
Date:   Wed, 11 Aug 2021 12:36:27 +0000
Message-Id: <20210811123627.20223-1-joamaki@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

An "innocent" cleanup in the last version of the XDP bonding
patchset moved the "test__start_subtest" calls to the test
main function, but I forgot to reverse the condition, which
lead to all tests being skipped. Fix it.

Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index 6b186b4238d0..370d220288a6 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -493,20 +493,20 @@ void test_xdp_bonding(void)
 			   "xdp_redirect_multi_kern__open_and_load"))
 		goto out;
 
-	if (!test__start_subtest("xdp_bonding_attach"))
+	if (test__start_subtest("xdp_bonding_attach"))
 		test_xdp_bonding_attach(&skeletons);
 
 	for (i = 0; i < ARRAY_SIZE(bond_test_cases); i++) {
 		struct bond_test_case *test_case = &bond_test_cases[i];
 
-		if (!test__start_subtest(test_case->name))
+		if (test__start_subtest(test_case->name))
 			test_xdp_bonding_with_mode(
 				&skeletons,
 				test_case->mode,
 				test_case->xmit_policy);
 	}
 
-	if (!test__start_subtest("xdp_bonding_redirect_multi"))
+	if (test__start_subtest("xdp_bonding_redirect_multi"))
 		test_xdp_bonding_redirect_multi(&skeletons);
 
 out:
-- 
2.17.1

