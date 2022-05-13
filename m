Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6691525903
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 02:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiEMAlY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 20:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiEMAlX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 20:41:23 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7916B5FF28
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:41:21 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id i6-20020a17090a718600b001dc87aca289so3542210pjk.5
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PLHfkBps8/NN/F93wiTb1I9xCzDthCPlSjntIH72rDE=;
        b=I8afDsMFlizjC2WkKw9nEOj2vMJgklTATaw1Hsa/SWTOmJqlD7HHRMFbRFXtiK5hKb
         eWR68srOtf34zMu8hRlFofRBQy/Kzvf9bIK5KmrMoPCtMhuNUIreuIDMCS0+HR7A97qA
         4norc+7XY3Ry8c2YsW8H6ig1JhvGZVoetaN6esBwKE9GsFTgHy0aQb6TWGqWqT5+iagi
         u0NOcqhn2xj8lDeq6QVIGMfypdzYQUXj/zwLC7cAmZdjvcQbS1bZDx2o2Swcm1uJ7M+H
         MVP3texpB2djiZrBiw8E2Hcwgk3Wb3yQENmoEoJRD1eEtwku11QHqpbk9WVB9zxfdH3a
         fmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PLHfkBps8/NN/F93wiTb1I9xCzDthCPlSjntIH72rDE=;
        b=idQggOJ+GsTRTHO2HhEKElxNQQ4CFnFvn/ZgbrbAhMWx1dpxbDNBZB8vpg+TCqujv/
         q7bpriFwckvpRNYUCw3J8CC9KBwt1eNCi2HAN/aHc3jXxOHMht8Hl0YMovn/S9P0LPHd
         gSEjfWZ5/0dkj8LnUgIZtwOH/6OhYsevIUd3mbVyL2waH31jd2c6abXANyn8nR9e0+JD
         l/bqUEUG2sLT822jaZNJMeniCL/EIqGpc9bgyxppP6MWiBnQI5BZUNgfubhl1beEJNhL
         t8YQcvX04t8JyRwB4QOH3JELYrB9nUVPk9ZaN27olbcMku/XG88eu/hAWp1MtN0lR3/2
         OWPg==
X-Gm-Message-State: AOAM530qb+rppO0H8DhWBKtlvvgCslfA0cdhAuRrh5xLa5uj0C0fzOmK
        Q8ELHVV1+sRn5SWYAWivwkFplkgZhXpJpX4J
X-Google-Smtp-Source: ABdhPJyNqg86E2DPDFz9cP8m9RIs4OnDIdJI8SHawkmDOi6DsBWOzE4x5CksBx4CuyRBczY8XM/fFtpwNsdQ7jWf
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:4b42:b0:1dc:15f8:821b with SMTP
 id mi2-20020a17090b4b4200b001dc15f8821bmr13529101pjb.131.1652402480734; Thu,
 12 May 2022 17:41:20 -0700 (PDT)
Date:   Fri, 13 May 2022 00:41:17 +0000
Message-Id: <20220513004117.364577-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH bpf-next] selftests/bpf: fix building bpf selftests statically
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf selftests can no longer be built with CFLAGS=-static with
liburandom_read.so and its dependent target.

Filter out -static for liburandom_read.so and its dependent target.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6bbc03161544..4eaefc187d5b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -168,14 +168,17 @@ $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
+# If the tests are being built statically, exclude dynamic libraries defined
+# in this Makefile and their dependencies.
+DYNAMIC_CFLAGS := $(filter-out -static,$(CFLAGS))
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
 	$(call msg,LIB,,$@)
-	$(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
+	$(Q)$(CC) $(DYNAMIC_CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.c,$^)			       \
-		  liburandom_read.so $(LDLIBS)	       			       \
+	$(Q)$(CC) $(DYNAMIC_CFLAGS) $(LDFLAGS) $(filter %.c,$^)			\
+		  liburandom_read.so $(LDLIBS)					\
 		  -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
-- 
2.36.0.550.gb090851708-goog

