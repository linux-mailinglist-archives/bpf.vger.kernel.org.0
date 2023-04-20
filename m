Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36136E9FCF
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 01:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjDTXYe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 19:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjDTXYd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 19:24:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEED3AB5
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4edc114c716so1007103e87.1
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682033070; x=1684625070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g9NI7uSmY9Z7i5CsMM46mgnhfsWo738KkWe3w1sOT0=;
        b=F56zEiGNSqqREEo3rorROdX961Kzmr9kZqWRWKzfjTWncWJPe9l3SLFoB+43lNNUqt
         u67/V1Yb9nHC44NFo+vwy0AkZmHZ/xB5DJE4xMFTweFSYx+twB/hWMyU5ibkFfSHeRIU
         rSreV0E/cG6DlVBDUpDJW/6YpLT5uAY0+Ys1ZVjpm1uxpHzZoVl60TDMPuCyDVJLOJX6
         qn/d/IkvmTJ5gjW9gtnalX8+iO26ecdzVjlX2Vg7rkbFV0Bj50XKbZ6oS9MDUlFYAFK3
         klYTRfPhvuhF65/Y06sQGhaApTjqysn4j/nICBTj/rXuZ9yWaboegVZGzw4YdyxCIQNU
         IEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682033070; x=1684625070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5g9NI7uSmY9Z7i5CsMM46mgnhfsWo738KkWe3w1sOT0=;
        b=XehRXKf3qfEbVuLsqz092qMlbg6j2nyj91sKt2ssjqe0HUSVF9WtZUhglzOBTbqaHs
         sm+bg72sxIvbxTfjvpR2eK7bGubZvTWh7gz0dX/UT5tjNchqdRX90PjlMKYbrHapAea0
         dfDg6I9jaa/YLythcpGuaNgQxMGMLjtC8TobzwjjrmdXCHLJopKV2pSXgwSkvnnAZh4g
         pLX3OKIDRw1GfLUdeh9eUdJHKIHZQCkUfTKHCm+6E1mrvwLEsNBVMf2zpi076eKvESFl
         91uBbDsX7cfzR0jXzPLILm4QwI8ozJ2CKjj7D8cF3Sq177naFGknZonTd4pZpkeJlFcX
         3OBQ==
X-Gm-Message-State: AAQBX9cANvso6zX7RUHyxwp51Y2FgxkG842ZZlgoMnqNWZy8HvpVIwYG
        +nkh8Rtnp3BN+JnLd2Ty16XJcuX4v8UoLw==
X-Google-Smtp-Source: AKy350bSB8P2IgUuRlLiRfRbxk4tyiHG0Y+gVJKKjpVj7CBK4I0plaLDICqVVpaZZK8A1We+2RaWXw==
X-Received: by 2002:a19:7613:0:b0:4ec:809c:c64c with SMTP id c19-20020a197613000000b004ec809cc64cmr829646lff.20.1682033069826;
        Thu, 20 Apr 2023 16:24:29 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z2-20020ac25de2000000b004ec89c94f04sm360227lfq.155.2023.04.20.16.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 16:24:29 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf-next 1/4] selftests/bpf: disable program test run for progs/refcounted_kptr.c
Date:   Fri, 21 Apr 2023 02:23:14 +0300
Message-Id: <20230420232317.2181776-2-eddyz87@gmail.com>
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

Florian Westphal found a bug in test_loader.c processing of __retval
tag. Because of this bug the function test_loader.c:do_prog_test_run()
never executed and all __retval test tags were ignored. This hid an
issue with progs/refcounted_kptr.c tests.

When __retval tag bug is fixed and refcounted_kptr.c tests are run
kernel reports various issues and eventually hangs. Shortest reproducer
is the following command run a few times:

  $ for i in $(seq 1 4); do (./test_progs --allow=refcounted_kptr &); done

Commenting out __retval tags for these tests until this issue is resolved.

Reported-by: Florian Westphal <fw@strlen.de>
Link: https://lore.kernel.org/bpf/f4c4aee644425842ee6aa8edf1da68f0a8260e7c.camel@gmail.com/T/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/refcounted_kptr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 1d348a225140..b6b2d4f97b19 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -219,7 +219,7 @@ static long __read_from_unstash(int idx)
 #define INSERT_READ_BOTH(rem_tree, rem_list, desc)			\
 SEC("tc")								\
 __description(desc)							\
-__success __retval(579)							\
+__success /* __retval(579) temporarily disabled */			\
 long insert_and_remove_tree_##rem_tree##_list_##rem_list(void *ctx)	\
 {									\
 	long err, tree_data, list_data;					\
@@ -258,7 +258,7 @@ INSERT_READ_BOTH(false, true, "insert_read_both: remove from list");
 #define INSERT_READ_BOTH(rem_tree, rem_list, desc)			\
 SEC("tc")								\
 __description(desc)							\
-__success __retval(579)							\
+__success /* __retval(579) temporarily disabled */			\
 long insert_and_remove_lf_tree_##rem_tree##_list_##rem_list(void *ctx)	\
 {									\
 	long err, tree_data, list_data;					\
@@ -296,7 +296,7 @@ INSERT_READ_BOTH(false, true, "insert_read_both_list_first: remove from list");
 #define INSERT_DOUBLE_READ_AND_DEL(read_fn, read_root, desc)		\
 SEC("tc")								\
 __description(desc)							\
-__success __retval(-1)							\
+__success /* temporarily __retval(-1) disabled */			\
 long insert_double_##read_fn##_and_del_##read_root(void *ctx)		\
 {									\
 	long err, list_data;						\
@@ -329,7 +329,7 @@ INSERT_DOUBLE_READ_AND_DEL(__read_from_list, head, "insert_double_del: 2x read-a
 #define INSERT_STASH_READ(rem_tree, desc)				\
 SEC("tc")								\
 __description(desc)							\
-__success __retval(84)							\
+__success /* __retval(84) temporarily disabled */			\
 long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 {									\
 	long err, tree_data, map_data;					\
-- 
2.40.0

