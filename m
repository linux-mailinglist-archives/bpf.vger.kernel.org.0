Return-Path: <bpf+bounces-12243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6227C9D06
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 03:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC10B20BB7
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 01:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84F17EA;
	Mon, 16 Oct 2023 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHGgOUlq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF51369
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 01:47:40 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D45F4;
	Sun, 15 Oct 2023 18:47:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b2018a11efso2402457b3a.0;
        Sun, 15 Oct 2023 18:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697420856; x=1698025656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSRIz1vcgrjsRKJR1DAFgT80TJOeno9JVnMf1bkF8yQ=;
        b=LHGgOUlqsGoQijaWFtVw0zgQtzoBgVsejg25gDfGoTDVaXt7zgixYS1WYbvJsuiJl0
         5aGxxlqDrAhmXESGDotyIiMODzeg+3Oo6zDFOfSKTa9f5VtWpIODIXt9PevhR6SNnAch
         3GUFwiffKuaakcBKlmZhqAjtNCZuYaWSYIdTjv/7EeHnhQgqQmdtYxMau1Uknmd3f71i
         Z6tEu1CUZJLJq3FMOowQWaJ0hvUXpfcXLAAyYype84ebdwTLvDWdpi1wFPuK8TeNGWPt
         jIx2n6/t+31Ihr6aRbJIZnUwKhPaTxe9hDOsE0nPG3g+GX2JiT67NNKaJqGKKRc8aSgd
         BVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697420856; x=1698025656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSRIz1vcgrjsRKJR1DAFgT80TJOeno9JVnMf1bkF8yQ=;
        b=Xop1EOnnsWzLZpVq0Qk55ABG+Mm/PtS/euqZpfZjgx3WCnNLRKbXEB7k9F0KzPQGjl
         qSgIOrgtmzlndc9/dL8XN7AWoEEWq+0v4GOmOiMSWBe1iN3jymSVc8l9tQDPegrsHYFQ
         fV7XCCIu8I3crUhOFqMwPqgc4oxGtJs9Au2ceADledQ9JgPw5iBcs1I45VvorCREXw52
         oMvq4r2m1uN9Tql34O/GvGWfdefcsYkXLck+hHDWfSTviPUX9HtMl1haj+pBB33adlG3
         eZT02guJ29Unm2owkzrNm+Rkr/R1ThGa1CQnaLc5KayX4EuySTNRnQhpNODRIQL/ONam
         JsfQ==
X-Gm-Message-State: AOJu0Yy/+hZgXXwo1yxv7MAueIq8LKVWWN1+B9oFhWKi5c0uK+tC/0SP
	E61ey51P8rP5zytg0aGVVMSAof8AqDp84A==
X-Google-Smtp-Source: AGHT+IEqrQpf1nJmozXn/wsImrF3IT7qQfBZOmsgPZiOrtm06RkyDB9tCIyMZ5XM12QEqUWaNPh+4A==
X-Received: by 2002:a05:6a21:7785:b0:179:f79e:8615 with SMTP id bd5-20020a056a21778500b00179f79e8615mr5301459pzc.52.1697420856610;
        Sun, 15 Oct 2023 18:47:36 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id pd17-20020a17090b1dd100b0027cfb5f010dsm3574377pjb.4.2023.10.15.18.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 18:47:35 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [PATCH v2 2/5] seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
Date: Sun, 15 Oct 2023 23:29:50 +0000
Message-Id: <20231015232953.84836-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015232953.84836-1-hengqi.chen@gmail.com>
References: <20231015232953.84836-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a new operation named SECCOMP_LOAD_FILTER.
It accepts a sock_fprog the same as SECCOMP_SET_MODE_FILTER
but only performs the loading process. If succeed, return a
new fd associated with the JITed BPF program (the filter).
The filter can then be pinned to bpffs using the returned
fd and reused for different processes. To distinguish the
filter from other BPF progs, BPF_PROG_TYPE_SECCOMP is added.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/uapi/linux/bpf.h       |  1 +
 include/uapi/linux/seccomp.h   |  1 +
 kernel/seccomp.c               | 43 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 46 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7ba61b75bc0e..61c80ffb1724 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -995,6 +995,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_SECCOMP,
 };
 
 enum bpf_attach_type {
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index dbfc9b37fcae..ee2c83697810 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -16,6 +16,7 @@
 #define SECCOMP_SET_MODE_FILTER		1
 #define SECCOMP_GET_ACTION_AVAIL	2
 #define SECCOMP_GET_NOTIF_SIZES		3
+#define SECCOMP_LOAD_FILTER		4
 
 /* Valid flags for SECCOMP_SET_MODE_FILTER */
 #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index faf84fc892eb..c9f6a19f7a4e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -17,6 +17,7 @@
 
 #include <linux/refcount.h>
 #include <linux/audit.h>
+#include <linux/bpf.h>
 #include <linux/compat.h>
 #include <linux/coredump.h>
 #include <linux/kmemleak.h>
@@ -25,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/seccomp.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/sysctl.h>
@@ -2032,12 +2034,48 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	seccomp_filter_free(prepared);
 	return ret;
 }
+
+static long seccomp_load_filter(const char __user *filter)
+{
+	struct sock_fprog fprog;
+	struct bpf_prog *prog;
+	int ret;
+
+	ret = seccomp_copy_user_filter(filter, &fprog);
+	if (ret)
+		return ret;
+
+	ret = seccomp_prepare_prog(&prog, &fprog);
+	if (ret)
+		return ret;
+
+	ret = security_bpf_prog_alloc(prog->aux);
+	if (ret) {
+		bpf_prog_free(prog);
+		return ret;
+	}
+
+	prog->aux->user = get_current_user();
+	atomic64_set(&prog->aux->refcnt, 1);
+	prog->type = BPF_PROG_TYPE_SECCOMP;
+
+	ret = bpf_prog_new_fd(prog);
+	if (ret < 0)
+		bpf_prog_put(prog);
+
+	return ret;
+}
 #else
 static inline long seccomp_set_mode_filter(unsigned int flags,
 					   const char __user *filter)
 {
 	return -EINVAL;
 }
+
+static inline long seccomp_load_filter(const char __user *filter)
+{
+	return -EINVAL;
+}
 #endif
 
 static long seccomp_get_action_avail(const char __user *uaction)
@@ -2099,6 +2137,11 @@ static long do_seccomp(unsigned int op, unsigned int flags,
 			return -EINVAL;
 
 		return seccomp_get_notif_sizes(uargs);
+	case SECCOMP_LOAD_FILTER:
+		if (flags != 0)
+			return -EINVAL;
+
+		return seccomp_load_filter(uargs);
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7ba61b75bc0e..61c80ffb1724 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -995,6 +995,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_SECCOMP,
 };
 
 enum bpf_attach_type {
-- 
2.34.1


