Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B74526E8B
	for <lists+bpf@lfdr.de>; Sat, 14 May 2022 09:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiENCdy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 22:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiENCdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 22:33:53 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3930032F1A8
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 17:34:31 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id s14-20020ab02bce000000b0035d45862725so4442819uar.22
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CleGR40pCscZ7DX+JE9UL8AwIhXuuwyZAmYy00HxsZE=;
        b=GKcrB79yedOhvremqRqfx2EEtubE/eyN0JrwxnHMy1Nx5PykTiyD7nKel0Omg5vymk
         6XX1h8zMRXwXQMbT9RWJmwqZWKb0uZhG8k4UUQ0NijUkhOsxW4JoBuv4+kVdbrVWp1Y6
         ANGUeQs7HysTo/cvIGwnNRxClRcgw8YP9fFPN/zE24iVnz/Wp1Lu0Blha36/yfJcIYkk
         DUhmk0ld4NSUFFuYCRhJCBYugyyQrSl8xSR4hdwGCx8z1keAmANLb5uj3zhIC262iZ8D
         sPvVId0WqsDtgIV3143I4tddKV9UtH9vVwku4d47YnGCiWKoYt0K2kmN7CiP63D/Bvtw
         o/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CleGR40pCscZ7DX+JE9UL8AwIhXuuwyZAmYy00HxsZE=;
        b=hyQIvarkHT18jC1R8G7QM64T2cYZmiwzgQ0lGM58HUfvajzsdSbcATxQfyP+kAOtbj
         NohRZ184wUfdKFRW1EqMfztCT7Xyh6orZEcB/3KXatNu20d4A0VEwOjkAN0bK4JGuJzR
         Dmd4iBEu3vgABJYBYeF0AxhUaZn9onlgZsGfKjY9HDjeaBC0HZFfU9c6OQWVQM1WIGV1
         w2NhBBNosu1mWG+fNlmUymFmWiRfSZbRDI/FBkKc7Pr1pqyIzCUwBJjqvZhCLYPeIh5/
         NxzBPsleJAcWVX6oB/ETS7p4WToMsUXkXebIoNcUwOPMC8eMABgSoCfybE32iC0NmSdc
         YOpQ==
X-Gm-Message-State: AOAM530XLMLFIwsnSdewykmjpzpHIwe5EQgq6/lgSvH0AAPNy6hseS4u
        Hy7LWmDq0foXeV9hVFEboM0GIbqa3xCRHd7y
X-Google-Smtp-Source: ABdhPJxywSRLaodpDSsq62D/NbDNNlbxqYbHUFeNFrs/LghHREk6Ui4Slhk+CDu0AZbxFPQdBk8KqU7Oq8cMJvKD
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1d8f:b0:510:9397:65b with SMTP
 id z15-20020a056a001d8f00b005109397065bmr6927932pfw.57.1652487684383; Fri, 13
 May 2022 17:21:24 -0700 (PDT)
Date:   Sat, 14 May 2022 00:21:15 +0000
Message-Id: <20220514002115.1376033-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH bpf-next v2] selftests/bpf: fix building bpf selftests statically
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf selftests can no longer be built with CFLAGS=-static with
liburandom_read.so and its dependent target.

Filter out -static for liburandom_read.so and its dependent target.

When building statically, this leaves urandom_read relying on
system-wide shared libraries.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6bbc03161544..4030dd6cbc34 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -168,13 +168,15 @@ $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
+# Filter out -static for liburandom_read.so and its dependent targets so that static builds
+# do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
 	$(call msg,LIB,,$@)
-	$(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
+	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS) -fPIC -shared -o $@
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.c,$^)			       \
+	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^)  \
 		  liburandom_read.so $(LDLIBS)	       			       \
 		  -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
 
-- 
2.36.0.550.gb090851708-goog

