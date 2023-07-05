Return-Path: <bpf+bounces-4066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6957486C9
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F3C281054
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474FB11C90;
	Wed,  5 Jul 2023 14:47:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44A3233
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 14:47:50 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4755F1B6
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 07:47:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1b88e5b3834so16813495ad.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688568467; x=1691160467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M83gZd8Zadb83q5TrdCvxbKyZ8+U22NCP8QItkiTLnA=;
        b=dw25QlX4SUMfRhjwooWjo+V+XwVI529xo5Wg7eEdi2NkyFiB45sxIXa2HMbEDRvUIM
         iRD27WeUKLUTcz7rGNL9aMMfTWbqm/T73Rx3MhPg94nSESzxC9QsZZ1vnBHAr3OylWSo
         bfSJgURhxv9RA1Z+iYUQ6s1+A60mCX+mvofGmQG1nKtQDPzBtFTC+o7EZk/4TVQ6YoM2
         NED7ZpEKP911BwfTNdcW3no3ywKu7Aok3B4GO3NPkPZXWAaJPzEEjTM+A2bmMOSxVOJV
         oni7Ie8jhd0OAlFgQANUetW0PO4jqOtBKIDNQk7HFKHPZ2XyTCxz2LGypCgvDEuFqc8E
         6wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688568467; x=1691160467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M83gZd8Zadb83q5TrdCvxbKyZ8+U22NCP8QItkiTLnA=;
        b=eW6FADJJT4OtUUSBvaXgSJwL6DiAaSj9VpUdYxDjbfrOd1bTWZ04sTHFLRj6cnRRpC
         arvlObn4HXi7BzUJ+XBiVJ9/SZHpiF9Iu6CrKv9ScmQlr/IriG4sw4hVfE1akqWD9TdM
         YsTGQWioghf0W2UHppEfo3ce0DgZlljuTzSY4HAyzYVa7nSQ81HTH7YUybnco6m4Q/OR
         3PDeDUybxqj16z8iqaGWEoAX2CjFeAcj/BTtd76Et5RGmRbpY/XHvc5NSIkbXvRdy6dH
         HbgwanNT3K67aKJtuWAUqL3jJQD95JaIO8We4YDU4ak+Vtpr9ZMtlehX4iVTkV0yc6eO
         0vZA==
X-Gm-Message-State: ABy/qLbYkLtCQIggzTu5nuTXQDrffFCYSDiLXwH8yJMwH6uMu4q3Tl5d
	i3zjmUZ2UNvsgGuNZW6gkKqnLfriDCezJgG4
X-Google-Smtp-Source: APBJJlF/GwvbLkkHdi/e2vcpX56wVBIY0TsKCSfFfOweHpLLp08L7Y6mYftFbYT+k9Vu0AiDvNYiQA==
X-Received: by 2002:a17:902:ea08:b0:1ad:f407:37d1 with SMTP id s8-20020a170902ea0800b001adf40737d1mr12627949plg.52.1688568467119;
        Wed, 05 Jul 2023 07:47:47 -0700 (PDT)
Received: from localhost ([49.36.209.255])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709027c0300b001ab1b7bae5asm19062284pll.184.2023.07.05.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:47:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v1 2/2] selftests/bpf: Add selftest for check_stack_max_depth bug
Date: Wed,  5 Jul 2023 20:17:30 +0530
Message-Id: <20230705144730.235802-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705144730.235802-1-memxor@gmail.com>
References: <20230705144730.235802-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=memxor@gmail.com; h=from:subject; bh=3WfVBEfjwSndKJo7xtesDDpuAoXw5+no5uSSdV3Ph4M=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkpYFovLvhXYyITzdrqe/GKMU4nQJ9IR9ie9VtW w7SK8odg3SJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZKWBaAAKCRBM4MiGSL8R ypWWD/wKj6MLLjEjUqgXrKakCS8YdtmE8doN60ESA8/1tlgYOLV/d65fP7ZrSA1ekZI6EeSr+1R NCT7k/kXwBBue28kFTTIWJUTH7D9gltd52megDbpwyZLP0OoInYZg5NlmC19WlCdQtyvz6LPLYb Fh7CFuVY45ouqVlQzc308cAendI8nbqNL5xSwzORFNvYlVj04wYx8aFg6laG/T3bqSiNrUzv33I h7AE30+UrTW5xzMhmkPbE4czm9CgL23KjnXlKLfI4DTOCXPRxH8CH8Q70MbAyTgohN5r32tNFw+ SXmLo7q4ebMr3JRL+KYJsGeKpUvs4FepbWqMAtcIHoz8iWML8w28bAHvWVcR+YfUSndVoCI0V9+ 1GzLJBmcu5tkrJRIPEgXIqVF52v/jqQ/b5nFncgkgY3FAE6iYhsoU1DAJtTu3J5gp1lewsiqbQK OMidW+sujPy5Hon5LILnEH9zPKGUpZAiHkyGk5l6yICQwnldoFp9Eqk1OsTGnTweGgCgck+5UHP xFD+HpTw3XhrWkjF/TtILCkMWe1qKsBcGZ/usyZyr8lisLxHv/UZlugS1qnmvm5/01XdUiagMEb Kj6xRW6oMqP6YofnTV35DZu056DzsiQigyfGJx0nfsUBPu0TOICPHW4RB9NWEPP29Lm7akCdBj9 kuwnaD0qZmWBbhQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the bpf_timer_set_callback helper to mark timer_cb as an async
callback, and put a direct call to timer_cb in the main subprog.

As the check_stack_max_depth happens after the do_check pass, the order
does not matter. Without the previous fix, the test passes successfully.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/async_stack_depth.c        |  9 +++++
 .../selftests/bpf/progs/async_stack_depth.c   | 40 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/async_stack_depth.c
 create mode 100644 tools/testing/selftests/bpf/progs/async_stack_depth.c

diff --git a/tools/testing/selftests/bpf/prog_tests/async_stack_depth.c b/tools/testing/selftests/bpf/prog_tests/async_stack_depth.c
new file mode 100644
index 000000000000..118abc29b236
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/async_stack_depth.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#include "async_stack_depth.skel.h"
+
+void test_async_stack_depth(void)
+{
+	RUN_TESTS(async_stack_depth);
+}
diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tools/testing/selftests/bpf/progs/async_stack_depth.c
new file mode 100644
index 000000000000..477ba950bb43
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+struct hmap_elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, int);
+	__type(value, struct hmap_elem);
+} hmap SEC(".maps");
+
+__attribute__((noinline))
+static int timer_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	volatile char buf[256] = {};
+	return buf[69];
+}
+
+SEC("tc")
+__failure __msg("combined stack size of 2 calls")
+int prog(struct __sk_buff *ctx)
+{
+	struct hmap_elem *elem;
+	volatile char buf[256] = {};
+
+	elem = bpf_map_lookup_elem(&hmap, &(int){0});
+	if (!elem)
+		return 0;
+
+	timer_cb(NULL, NULL, NULL);
+	return bpf_timer_set_callback(&elem->timer, timer_cb) + buf[0];
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.1


