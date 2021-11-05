Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17198446B56
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 00:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhKEXpq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 19:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhKEXpq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 19:45:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393BC061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 16:43:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g11so10190681pfv.7
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0eybG4zgHlHZXaO8p1AODx4E9lk0YJrK/wZsukAYNjw=;
        b=g9i0qkcGuQ7KLO5DRxzRKkEhp7ZMRTYWbr2oRHMTTKHtaoCd52ZQVJgjg5mtQzgKIZ
         56DoSwzTsKOHDBp30u/+tLMsOjnXLkcPuUoL/5Oj+eGXDeeIy59V5y7vET3GIlUE/9k+
         yIsOqXJvCG+JcqG47u3nCadTwrJ+QL4tAwYiLn4ymMJlcplT+3rBApT5x10rUBsXzeEn
         COmtgzPLt5nbXc87s3zmnB2cv4esDzEhfvZqRhT6o0v64OXFBm6FilNg+wCf/kwY+mqy
         Zx9SNpuwN9dqNGdRGoHQFpXRf5hMhznUk187mL7md9szfiWWNXbfA3q3jF6aZ7cemrXH
         76Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0eybG4zgHlHZXaO8p1AODx4E9lk0YJrK/wZsukAYNjw=;
        b=69FvGuPTnslZJI+frl3ErjHoxZfNZ34RA+AGxBS0v3ik0Mxgq1JT1k0mqe12I6rCLF
         bE10M9bAadxW3kt4lIH8XBpxHa/3VXdEvhMpOETqZXy8GpQ3tPiYluoH5m9TmskFWRIi
         0RxySRLMCmmKbVgiytEZgz89tUP0PcK2xJYBjX2dVClEaqUIhLy6ifElBfHxOK0Yl8w0
         qqc+7ujYE2TGm6Gg51QIuMrE+wjAYmup42DnDTaID1/SGs73wbAqXs8ihXqZqpjahb4N
         ctc9LrU+xQ3Uudlgw3Y98u61vBSL3JPF9dRXnbZ/54/R6t4s+8OwYRByeap1i0IyI2e+
         3pcA==
X-Gm-Message-State: AOAM530dqEf3QXSuOReDHTMyEFEA8EbN32Ei+uSFZllhwLHNN+9SC/tn
        QG5ieaN3jvicvQx8aQaNHPDUzkxkrBIypw==
X-Google-Smtp-Source: ABdhPJyCRmGt4d7+qUg3Jd1XloF1LBkh0Kt6xByJRPcoxZG4VHbVY6i/WNJpaNvXrPdETTffCvKVzg==
X-Received: by 2002:a05:6a00:c81:b029:30e:21bf:4c15 with SMTP id a1-20020a056a000c81b029030e21bf4c15mr62314964pfv.70.1636155785203;
        Fri, 05 Nov 2021 16:43:05 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id s6sm8580213pfu.137.2021.11.05.16.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 16:43:04 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 6/6] selftests/bpf: Compile using -std=gnu89
Date:   Sat,  6 Nov 2021 05:12:43 +0530
Message-Id: <20211105234243.390179-7-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105234243.390179-1-memxor@gmail.com>
References: <20211105234243.390179-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; h=from:subject; bh=E6MXCGxoOvlgGE9ca71nhl0pQaB51dC/kNCa6tTnyhk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhhb9BJuvuXyfVou8At7IZJTi5/CboTE2qzZvr/GW/ rmAaZGiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYYW/QQAKCRBM4MiGSL8RyiIBD/ 9JU/GeU1xwSbW2iPIh16vB0KsU0OM4jGOltpyCsO2C81a5e553JTiIXrxRfRKvW/+Lzp8jB4qgV4Iv ORlVE8AozzgdOW6lVvRQPx8DpjkAUocgPEgoKDBKK9C1xhfx238sGZR9hKCv6vAEdi4ZycjCHP6k8U 0F2K13fsMVseg89+wczrlzZLFjpQJ8QVBMNS5zZlJYcw7kFagPtxS1UGaH+KjcwHUdedtWpByfo9BA JuYBvA3U8yp7RJS4u70ZBUdmIDZSDTd8QbPZNanAyYfihehcxqJSFPriTwo4frMCmyOa1xX9aWC1TW B0slr9So6qaox5/mdorw5K/ek/ZAZRYjW7k/Qs7FXiomyW/vJyQaXptZ7WPjryENL9hbi9EIuWEdvf 2c+yFgI08njp7KLSkv7KazgXssmnygv7Ps4ojrBUdo3t8hIA4/ur18p6eE9+GaFgDZOg5tPRb1o9Zq IvCQb4gLjdlz3zb2NZYJYh4xjhNoPCk5GL0qEJ0q82LdbJ+x8iuPXtZI4tWeE9Idjb4lLbwJnUQts5 ftKFJYZNJNQ+XBavFc7/4Hbu8HbVlxssmLO3j4UNSLAAF4bDQ2i1Spvo+1u51pwt97ypdAckBWYtoM 0ITthS0ZSJtHxB87WgqilKRm6600EGfAVM/OkvJN+55rXMdJzHjRRNQbkRKQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The minimum supported C standard version is C89, with use of GNU
extensions, hence make sure to catch any instances that would break
the build for this mode by passing -std=gnu89.

Also, copy out CFLAGS for C++ test so that we don't end up passing
-std=gnu89 to g++, otherwise the build generates a (harmless) warning:

cc1plus: warning: command-line option ‘-std=gnu90’ is valid for C/ObjC but not for C++

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 54b0a41a3775..6239e51c310f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -33,6 +33,9 @@ ifneq ($(LLVM),)
 CFLAGS += -Wno-unused-command-line-argument
 endif
 
+CXXFLAGS := $(CFLAGS)
+CFLAGS += -std=gnu89
+
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
 	test_verifier_log test_dev_cgroup \
@@ -519,7 +522,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 # Make sure we are able to include and link libbpf against c++.
 $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
-	$(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
+	$(Q)$(CXX) $(CXXFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
 
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
-- 
2.33.1

