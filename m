Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA54E6E9FD0
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 01:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjDTXYf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 19:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjDTXYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 19:24:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F51BCE
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec9c7c6986so994546e87.0
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682033071; x=1684625071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzWSdXs5P+bPGi5Kwi+OhAIz+8fFAUMm/RT7jUF+fqY=;
        b=VeTUnl3biuY+gePiCG6fs6Zho5Sk97cyaC4qfMpbZHalUC3zw0oubLEBfzn76rM/HK
         6wKTu4wORgDOSzJ6csRTJhnEcGjYcVDVMFFLQcBahCDjLZPjnvz9LcL7sP5z/VMfLb79
         eDRQizwQCkRz57ESBEeMtTKlb193oLldTdJeTYi3dm8+FWvJWYNfqtdnFBFYgndSL86D
         cEYqbEzY2NLYgR6KOiZ0i5GuII7uYkDDFvWncmsg1a/dkrrFQZJPUfZkGLLxtQO9ASNX
         bm2fX6qg4jQdP7eLuW4vPHLgOxZtlerco4Xhf8wvuMgaEeTyRVkYiow7p0dui0HbPlIp
         NvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682033071; x=1684625071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzWSdXs5P+bPGi5Kwi+OhAIz+8fFAUMm/RT7jUF+fqY=;
        b=HLkPWwuW3/a7eqFcpDJ7X1crcNeuyOUcyE0qG8xQyrfSvFgAarewsE8dNp/TgBSs0q
         pAarg4RzO0PaBtMgV32tzdgIMmQMm5dOb3TJSJXezPoxGANnGgjhbL7xeLJbDqAUKVJ7
         UUehXqdcBPZgbcZrvXLthgiBgzmV5ARagISHLU1CNlWj/X+R5qvl9KYqTv51ANHCPr7l
         DvPrtwswA1JgXtw0rgJTzkQKcBhXxRg4V7v4YhK6Y8uyT8X3I5B6C9DDqND6WdWjH46Q
         b/Im/bokvLhnjxXNONt3fatMs991NDhCTvAixTB2+16hBqwE/PSaiddX7ud2Mjdln8VQ
         nFPA==
X-Gm-Message-State: AAQBX9d8B6GyTs9YblPkpn/Y4lRO2wiIfXXN9FAybBjIP90S38hlWJC/
        M4eO48SCnfzMQpJufjEf+sOc5BauBn675Q==
X-Google-Smtp-Source: AKy350Yv4KSoNd7kniMhyZO5myt+SIJdBccj5Kk9SfIzTuhD8veOCQcsYmkyXVcpy2JfGiRYdaJjrw==
X-Received: by 2002:ac2:5df0:0:b0:4ea:f636:6d02 with SMTP id z16-20020ac25df0000000b004eaf6366d02mr940382lfq.18.1682033071036;
        Thu, 20 Apr 2023 16:24:31 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z2-20020ac25de2000000b004ec89c94f04sm360227lfq.155.2023.04.20.16.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 16:24:30 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf-next 2/4] selftests/bpf: fix __retval() being always ignored
Date:   Fri, 21 Apr 2023 02:23:15 +0300
Message-Id: <20230420232317.2181776-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420232317.2181776-1-eddyz87@gmail.com>
References: <20230420232317.2181776-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal found a bug in and suggested a fix for test_loader.c
processing of __retval tag. Because of this bug the function
test_loader.c:do_prog_test_run() never executed and all __retval test
tags were ignored.

If this bug is fixed a number of test cases from
progs/verifier_array_access.c fail with retval not matching the
expected value. This test was recently converted to use test_loader.c
and inline assembly in [1]. When doing the conversion I missed the
important detail of test_verifier.c operation: when it creates
fixup_map_array_ro, fixup_map_array_wo and fixup_map_array_small it
populates these maps with a dummy record.

Disabling the __retval checks for the affected verifier_array_access
in this commit to avoid false-postivies in any potential bisects.
The issue is addressed in the next patch.

I verified that the __retval tags are now respected by changing
expected return values for all tests annotated with __retval, and
checking that these tests started to fail.

[1] https://lore.kernel.org/bpf/20230325025524.144043-1-eddyz87@gmail.com/

Fixes: 19a8e06f5f91 ("selftests/bpf: Tests execution support for test_loader.c")
Reported-by: Florian Westphal <fw@strlen.de>
Link: https://lore.kernel.org/bpf/f4c4aee644425842ee6aa8edf1da68f0a8260e7c.camel@gmail.com/T/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_array_access.c | 4 ++--
 tools/testing/selftests/bpf/test_loader.c                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 95d7ecc12963..fceeeef78721 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -330,7 +330,7 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("valid read map access into a read-only array 1")
-__success __success_unpriv __retval(28)
+__success __success_unpriv /* __retval(28) temporarily disable */
 __naked void a_read_only_array_1_1(void)
 {
 	asm volatile ("					\
@@ -351,7 +351,7 @@ l0_%=:	exit;						\
 
 SEC("tc")
 __description("valid read map access into a read-only array 2")
-__success __retval(65507)
+__success /* __retval(65507) temporarily disable */
 __naked void a_read_only_array_2_1(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 47e9e076bc8f..e2a1bdc5a570 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -587,7 +587,7 @@ void run_subtest(struct test_loader *tester,
 		/* For some reason test_verifier executes programs
 		 * with all capabilities restored. Do the same here.
 		 */
-		if (!restore_capabilities(&caps))
+		if (restore_capabilities(&caps))
 			goto tobj_cleanup;
 
 		do_prog_test_run(bpf_program__fd(tprog), &retval);
-- 
2.40.0

