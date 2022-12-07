Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E09646287
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLGUmL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiLGUmK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:42:10 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2719530558
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:42:09 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x66so18532314pfx.3
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01wauH19eqmzO4s5n5a0PMWF5ZMamX+v9IeWG7qrBA4=;
        b=DMT/zHN6OOwxU2R61XCl0XP8ml2rluCzHotD5KBI+eZHb2iY9Rma5U46CMxOblNXCZ
         Q6x/mqDDb0ysPihqEK4hjQvSQbFfz08Ss1NZDJZqXS2CUZMWeMMADUdfx3ai4Lr0PH1P
         2VXz3qXDJrZL55oqdRCN09s6TwbYSTeuJlC9vqD7yvB5+eT1quDp/K33Aak4+rID8dNW
         AQ1x7vGcUghCQHHoT0SwHl7j+6H1QeLutqiWEqIc/Jti+gSQQkS2Iqrr4wx34pcKgEE1
         9i/qujMEnsXNQ8JKJtWFmI32bjXFGRKANKubfq86zxxLSpNwaC9LQMN0GzEoO6QgAqtj
         hirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01wauH19eqmzO4s5n5a0PMWF5ZMamX+v9IeWG7qrBA4=;
        b=ancwnPAk6ZxuSYuKGyGlJ89p4NFj0iLRXQc+ibTZuLsgmlNnYekN3+aYzFSupLGtFh
         Fxjql+tV5LGoL3qr2VVuhQtViioPoEfhgL+bVF0hahr3iBwkBegGpns5Cll0nTuT4etf
         kJ1SHFuB+cE+ad8cOBbafjcerrbBiy7R1UdwzuQVMcIi9T/89cBY3d86SZGAn2LCbotq
         nLF/wcpLvRXKDLGoQyZSACWDciYxq1y1pXj5uzdKNaf3edYZo3Q5gs1WCX22DJmAJX7A
         Ed2oyIuPx0TJIu3r7ntSDsnNQ97bqhbfIbZq21XSns1MEtX9nMTFF/ZY3JrIquuUC2o2
         GBiQ==
X-Gm-Message-State: ANoB5plfjXGGMC0fuc8SPvtrEeHBQciqwYkCyfNyp6ql2dwzi2gVllvE
        IZPB7D1rFRY4iBqPb4GuZ4zXvYBAV6vwiRB3
X-Google-Smtp-Source: AA0mqf5GIe7QpOodQ8ccv5eGGDOuJdnlyMOJK+Rbl/2ZcEXkK4LAk0Of/vepWsmzbGbKuFeJ8HtL6Q==
X-Received: by 2002:a63:921b:0:b0:478:f30b:8f5f with SMTP id o27-20020a63921b000000b00478f30b8f5fmr3986237pgd.527.1670445728350;
        Wed, 07 Dec 2022 12:42:08 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id d9-20020aa797a9000000b00576489088c7sm8302771pfq.37.2022.12.07.12.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:42:08 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: Add test for dynptr reinit in user_ringbuf callback
Date:   Thu,  8 Dec 2022 02:11:41 +0530
Message-Id: <20221207204141.308952-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207204141.308952-1-memxor@gmail.com>
References: <20221207204141.308952-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6299; i=memxor@gmail.com; h=from:subject; bh=KrAgt8E55V4soRSbWm0Gn0wfos9fuJxLAXqsuZnNVWE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjkPOpOjVosuvB+BMgAIfcdG2PRmInjvZ9DD/P6F7H ElGvnuCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY5DzqQAKCRBM4MiGSL8RylarEA CLloRoyGbQDhI44s5Mt5NVxpE+xCmY0ifkaJe0wDUNgS79Bp+dVNdEdcU3M6qNQTg6lFzH0ouldx9F FlJ21MvOd6GmeBcD7W0OZnBRDzqDZw2N/rPbUaRDuniwPLWKl3oNAqJeRHDpHpw7/4xiGWfw4Zw1W5 YZUqVZHcHLPz8IErV/rNZKVfBWXnY2xf3Om2RQasB6gayNDbRoGZlK0+a/9RZkMC8ooGn5L4qBzbjU /ocQXCYxN5nGrLAMOoTrR6qXdjlCz64dSk0MOkp4ehTU7kkYrsHuiUCsGfP7UYd+IrbClp4fBABkHi 7nr0Tik5z6oYV/GIQsBknJxYbNi/+1lgN+VhiEEqD0e1zh4p9O1VfLReL1pmDGaujIyX4qzJZtIRSj V/xu+ZrxEwrU/wfDRivyow+IkBsJIyCoRwUhWEnGcXziRYFUQjwfGKKVFV7wWyOaw3OhpvHIANb6xs Sv39EJ+6vaRmusCpZLMytWquXwiqhPqjByLYRl3f7E4K5iCa6YmPPgRXijTCqLPVTZgv73CcTgSknl qLmX3zdOrPnKK51CYyYgWNu3hVryBJULssS7EVNmZd7kIxF+NQK9ZgxzXUqLz7DYEe5mzs5t9nFvo/ Hay8hB3UVVq3Vy3PFa+O+WjlHIL/mp9ROWxm02irTp47RcZIp+lmDbukg+kg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The original support for bpf_user_ringbuf_drain callbacks simply
short-circuited checks for the dynptr state, allowing users to pass
PTR_TO_DYNPTR (now CONST_PTR_TO_DYNPTR) to helpers that initialize a
dynptr. This bug would have also surfaced with other dynptr helpers in
the future that changed dynptr view or modified it in some way.

Include test cases for all cases, i.e. both bpf_dynptr_from_mem and
bpf_ringbuf_reserve_dynptr, and ensure verifier rejects both of them.
Without the fix, both of these programs load and pass verification.

While at it, remove sys_nanosleep target from failure cases' SEC
definition, as there is no such tracepoint.

Acked-by: David Vernet <void@manifault.com>
Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/user_ringbuf.c   |  2 +
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 51 ++++++++++++++++---
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index aefa0a474e58..dae68de285b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -676,6 +676,8 @@ static struct {
 	{"user_ringbuf_callback_discard_dynptr", "cannot release unowned const bpf_dynptr"},
 	{"user_ringbuf_callback_submit_dynptr", "cannot release unowned const bpf_dynptr"},
 	{"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
+	{"user_ringbuf_callback_reinit_dynptr_mem", "Dynptr has to be an uninitialized dynptr"},
+	{"user_ringbuf_callback_reinit_dynptr_ringbuf", "Dynptr has to be an uninitialized dynptr"},
 };
 
 #define SUCCESS_TEST(_func) { _func, #_func }
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 82aba4529aa9..f3201dc69a60 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -18,6 +18,13 @@ struct {
 	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
 } user_ringbuf SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 2);
+} ringbuf SEC(".maps");
+
+static int map_value;
+
 static long
 bad_access1(struct bpf_dynptr *dynptr, void *context)
 {
@@ -32,7 +39,7 @@ bad_access1(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
  * not be able to read before the pointer.
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp/")
 int user_ringbuf_callback_bad_access1(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, bad_access1, NULL, 0);
@@ -54,7 +61,7 @@ bad_access2(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
  * not be able to read past the end of the pointer.
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp/")
 int user_ringbuf_callback_bad_access2(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, bad_access2, NULL, 0);
@@ -73,7 +80,7 @@ write_forbidden(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
  * not be able to write to that pointer.
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp/")
 int user_ringbuf_callback_write_forbidden(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, write_forbidden, NULL, 0);
@@ -92,7 +99,7 @@ null_context_write(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
  * not be able to write to that pointer.
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp/")
 int user_ringbuf_callback_null_context_write(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, null_context_write, NULL, 0);
@@ -113,7 +120,7 @@ null_context_read(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
  * not be able to write to that pointer.
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp/")
 int user_ringbuf_callback_null_context_read(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, null_context_read, NULL, 0);
@@ -132,7 +139,7 @@ try_discard_dynptr(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
  * not be able to read past the end of the pointer.
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp/")
 int user_ringbuf_callback_discard_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
@@ -151,7 +158,7 @@ try_submit_dynptr(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
  * not be able to read past the end of the pointer.
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp/")
 int user_ringbuf_callback_submit_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
@@ -168,10 +175,38 @@ invalid_drain_callback_return(struct bpf_dynptr *dynptr, void *context)
 /* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
  * not be able to write to that pointer.
  */
-SEC("?raw_tp/sys_nanosleep")
+SEC("?raw_tp/")
 int user_ringbuf_callback_invalid_return(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, invalid_drain_callback_return, NULL, 0);
 
 	return 0;
 }
+
+static long
+try_reinit_dynptr_mem(struct bpf_dynptr *dynptr, void *context)
+{
+	bpf_dynptr_from_mem(&map_value, 4, 0, dynptr);
+	return 0;
+}
+
+static long
+try_reinit_dynptr_ringbuf(struct bpf_dynptr *dynptr, void *context)
+{
+	bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, dynptr);
+	return 0;
+}
+
+SEC("?raw_tp/")
+int user_ringbuf_callback_reinit_dynptr_mem(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_mem, NULL, 0);
+	return 0;
+}
+
+SEC("?raw_tp/")
+int user_ringbuf_callback_reinit_dynptr_ringbuf(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, try_reinit_dynptr_ringbuf, NULL, 0);
+	return 0;
+}
-- 
2.38.1

