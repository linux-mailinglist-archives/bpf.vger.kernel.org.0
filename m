Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7626264B70A
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 15:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiLMONA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 09:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiLMOMb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 09:12:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282741CFDD;
        Tue, 13 Dec 2022 06:11:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB197B81189;
        Tue, 13 Dec 2022 14:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5C0C433D2;
        Tue, 13 Dec 2022 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670940686;
        bh=i4+X36aP4iUnP5dBT/vzjdrM0ePyEqx+ak2BmIRIs+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUxzoLVpYu2qisXG8MRJM5a56Uhdf/Ac/MoPyQmvI/hmHJ396CvYKXxq0iI31bsu2
         SaILArKAyI1DM2hqnBH6YCjZXr+cFzR1f/baQbcdt109Esjg3dQVDqAYrwMuIEgYYh
         iQpMkz2pDY3vmKSDVqWOxFXR6acAtblYHHS8hPV16FgL5ccWG35AoMzE+SG+RysjIa
         r/53WQCnFsMXLnJ2/q3uDdJ6S2To+/aNMBz86cUV1aXQRLd4XNea6TPUuTl9ueUlPS
         XWilQ42gRdNf5ZphpXp57CRHOPQ89MR3NaMiHCD4qid+f0foYHeRp5rfQw4MIc/1ja
         SdEa8IQT1prSw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     bpf@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/2] error-injection: Remove EI_ETYPE_NONE
Date:   Tue, 13 Dec 2022 23:11:21 +0900
Message-Id: <167094068123.608798.9238149148720683524.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <167094067084.608798.11303550366840600235.stgit@devnote3>
References: <167094067084.608798.11303550366840600235.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the EI_ETYPE_NONE is confusing type, replace it with appropriate
errno. The EI_ETYPE_NONE has been introduced for a dummy (error) value,
but it can mislead people that they can use ALLOW_ERROR_INJECTION(func,
NONE). So remove it from the EI_ETYPE and use appropriate errno instead.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 663faf9f7bee ("error-injection: Add injectable error types")
---
 Changes in v2:
  - include linux/errno.h
---
 include/asm-generic/error-injection.h |    1 -
 include/linux/error-injection.h       |    3 ++-
 lib/error-inject.c                    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index fbca56bd9cbc..c0b9d3217ed9 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -4,7 +4,6 @@
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 enum {
-	EI_ETYPE_NONE,		/* Dummy value for undefined case */
 	EI_ETYPE_NULL,		/* Return NULL if failure */
 	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
 	EI_ETYPE_ERRNO_NULL,	/* Return -ERRNO or NULL if failure */
diff --git a/include/linux/error-injection.h b/include/linux/error-injection.h
index 635a95caf29f..20e738f4eae8 100644
--- a/include/linux/error-injection.h
+++ b/include/linux/error-injection.h
@@ -3,6 +3,7 @@
 #define _LINUX_ERROR_INJECTION_H
 
 #include <linux/compiler.h>
+#include <linux/errno.h>
 #include <asm-generic/error-injection.h>
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
@@ -19,7 +20,7 @@ static inline bool within_error_injection_list(unsigned long addr)
 
 static inline int get_injectable_error_type(unsigned long addr)
 {
-	return EI_ETYPE_NONE;
+	return -EOPNOTSUPP;
 }
 
 #endif
diff --git a/lib/error-inject.c b/lib/error-inject.c
index 1afca1b1cdea..32c14770508e 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -40,7 +40,7 @@ bool within_error_injection_list(unsigned long addr)
 int get_injectable_error_type(unsigned long addr)
 {
 	struct ei_entry *ent;
-	int ei_type = EI_ETYPE_NONE;
+	int ei_type = -EINVAL;
 
 	mutex_lock(&ei_mutex);
 	list_for_each_entry(ent, &error_injection_list, list) {

