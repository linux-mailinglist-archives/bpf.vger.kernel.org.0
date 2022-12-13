Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA064B70F
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 15:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiLMONG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 09:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiLMOMg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 09:12:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7429320BEF;
        Tue, 13 Dec 2022 06:11:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 307E4B81204;
        Tue, 13 Dec 2022 14:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A207FC433EF;
        Tue, 13 Dec 2022 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670940697;
        bh=ro10CqJEpDOOkWURK+9ji5eHns6LfgisIWEJmB7FR+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SanjH8Fb0ODeBWUz3j1ivH32DpSj5Ca4m7gw/NdLbVmlty6u0V1Igza15BuLQxgLB
         C8Titz5NReQhGCN8R30WuDqou/FQyfgL2FdQZUgcaRPzUvfvOs5+rU5/N7AhVWNB/V
         sQTwrqX2Tddl8lLyDD1hT4yCWM7M/pz6nCvb/vRxKm/oSyvL/A5Ukc9ZseZ0fa19tU
         kyWwvHDQKxmasw7sd5DK3mucDS25TYLtGTADfR588x+nY7DbnQlcAzK1BsT0of3e0z
         UapAHLpim/YV8D0l/0a/9Sufg1kvJ3hJnlpyzYddMf9TpzB811gS9tU4a7GyZRLx3w
         gCZn8LpeY9ugw==
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
Subject: [PATCH v2 2/2] docs: fault-injection: Add requirements of error injectable functions
Date:   Tue, 13 Dec 2022 23:11:31 +0900
Message-Id: <167094069168.608798.9644454927302716989.stgit@devnote3>
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

Add a section about the requirements of the error injectable functions
and the type of errors.
Since this section must be read before using ALLOW_ERROR_INJECTION()
macro, that section is referred from the comment of the macro too.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/all/20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org/T/#u
---
 Changes in v2:
  - Fix typos and misses according to Randy's comment.
---
 Documentation/fault-injection/fault-injection.rst |   65 +++++++++++++++++++++
 include/asm-generic/error-injection.h             |    6 +-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 17779a2772e5..76bc9c857761 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -233,6 +233,71 @@ proc entries
 	This feature is intended for systematic testing of faults in a single
 	system call. See an example below.
 
+
+Error Injectable Functions
+--------------------------
+
+This part is for the kenrel developers considering adding a function
+using the ALLOW_ERROR_INJECTION() macro.
+
+Requirements for the Error Injectable Functions
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Since the function-level error injection forcibly changes the code path
+and returns an error even if the input and conditions are proper, this can
+cause unexpected kernel crash if you allow error injection on the function
+which is NOT error injectable. Thus, you (and reviewers) must ensure;
+
+- The function returns an error code if it fails, and the callers must check
+  it correctly (need to recover from it).
+
+- The function does not execute any code which can change any state before
+  the first error return. The state includes global or local, or input
+  variable. For example, clear output address storage (e.g. `*ret = NULL`),
+  increment/decrement counter, set a flag, preempt/irq disable or get
+  a lock (if those are recovered before returning error, that will be OK.)
+
+The first requirement is important, and it will result in that the release
+(free objects) functions are usually harder to inject errors than allocate
+functions. If errors of such release functions are not correctly handled
+it will cause a memory leak easily (the caller will confuse that the object
+has been released or corrupted.)
+
+The second one is for the caller which expects the function should always
+do something. Thus if the function error injection skips all of the
+function, the expectation is betrayed and causes an unexpected error.
+
+Type of the Error Injectable Functions
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Each error injectable function will have the error type specified by the
+ALLOW_ERROR_INJECTION() macro. You have to choose it carefully if you add
+a new error injectable function. If the wrong error type is chosen, the
+kernel may crash because it may not be able to handle the error.
+There are 4 types of errors defined in include/asm-generic/error-injection.h
+
+EI_ETYPE_NULL
+  This function will return `NULL` if it fails. e.g. return an allocated
+  object address.
+
+EI_ETYPE_ERRNO
+  This function will return an `-errno` error code if it fails. e.g. return
+  -EINVAL if the input is wrong. This will include the functions which will
+  return an address which encodes `-errno` by ERR_PTR() macro.
+
+EI_ETYPE_ERRNO_NULL
+  This function will return an `-errno` or `NULL` if it fails. If the caller
+  of this function checks the return value with IS_ERR_OR_NULL() macro, this
+  type will be appropriate.
+
+EI_ETYPE_TRUE
+  This function will return `true` (non-zero positive value) if it fails.
+
+If you specify a wrong type, for example, EI_TYPE_ERRNO for the function
+which returns an allocated object, it may cause a problem because the returned
+value is not an object address and the caller can not access to the address.
+
+
 How to add new fault injection capability
 -----------------------------------------
 
diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index c0b9d3217ed9..18324d7aa56d 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -19,8 +19,10 @@ struct pt_regs;
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 /*
- * Whitelist generating macro. Specify functions which can be
- * error-injectable using this macro.
+ * Whitelist generating macro. Specify functions which can be error-injectable
+ * using this macro. If you are unsure what is required for the error-injectable
+ * functions, please read Documentation/fault-injection/fault-injection.rst
+ * 'Error Injectable Functions' section.
  */
 #define ALLOW_ERROR_INJECTION(fname, _etype)				\
 static struct error_injection_entry __used				\

