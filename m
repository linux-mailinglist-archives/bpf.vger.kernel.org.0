Return-Path: <bpf+bounces-9559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB1B799229
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1D51C20CD0
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24C0B653;
	Fri,  8 Sep 2023 22:22:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0349B64F
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 22:22:45 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E01FE0
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 15:22:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ec9300c51so2480554276.3
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694211762; x=1694816562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+XsVL+cfbctslxXvk7LS6u0UZeiKqg6dlFRPCcpa5Q=;
        b=cYgimaAonFtIAE2JPYenda9hHfJ6NxqzYDRmmXS5WMVZTIRwoSQiI6jFEZI48hGVoC
         ZgmQOk0uXz2myx0aoGaw31iksN1d2ibIzxgrnWRC035dYWlkUIM+c7R+BTxo7S5395xO
         gy2oBX0b7wvFDHqMQXZVxYFaGObiSWBfh7g9BfkTCdLiOSCzUU7XNoN3wYtBY7gwTE2P
         oEpsF9Ms3F2jiANbgjNKcEgU1JEQ8oGo1EEJY/PX5u59Bkv3GDebesNZXtPUAb8VNQj+
         iJIJPuK1446tNAR5yaa34z7zcGk/p739nHfJ2AF46tUKgeTxm4Lmlm1TSG5FdL1dDwbJ
         u9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694211762; x=1694816562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+XsVL+cfbctslxXvk7LS6u0UZeiKqg6dlFRPCcpa5Q=;
        b=v50UxOXFqYITjRllqFdZOFqvhmYzbWKiP0wCoA+xhZIYG9QtoC6YPa9i/BIZ5K+cfO
         Pd7q5RKOtDSajo5a5a69pMGmU9XqCUIRyMDlamtLu5xQsNbGnbmRroaNt0vGfQww22nw
         Sg3rYk1dk9dtfF3ixzhmjx2iItGxODvO94N4ypbanMMiTARFdcr2/HWggGg2xT+0nuWR
         5clSbCAs+BqNuc918iGdvp4WDBf31TnCIUP0hvKid8IZ/K6FMKRg0Cipx171Fwj86WdT
         QVoxYHkBXpQjhT5TQRzFjtsafjsIaQfUbj5RyLp9aszO7iyOHOeZtn/vQtr7NfxKQdfs
         dkaw==
X-Gm-Message-State: AOJu0YwR/rNqvrUR73KfpQajY7/brQzFI4CkutGpJl+AkIovrER6Yrt8
	njtUWu1pUzTmB0nkyksMjFzufMyVTShzZIAbdA==
X-Google-Smtp-Source: AGHT+IGlV+Bui1NhfsZcgAuQyYigiF5ebLDLzQkJw9NJtHLbI7T+ogXsvWSe1DFxu6mDYwpFXo/UCbASGCw+2oWhug==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1682:b0:d7b:8d0c:43f1 with
 SMTP id bx2-20020a056902168200b00d7b8d0c43f1mr90192ybb.9.1694211762818; Fri,
 08 Sep 2023 15:22:42 -0700 (PDT)
Date: Fri, 08 Sep 2023 22:22:38 +0000
In-Reply-To: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694211760; l=3339;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=N4AQQf1s6GS4HMDxm7EJ3Mrjm49lo4/602kAGPRlBLI=; b=NJcm/MUhsVHBnIDjTMJ/p/eLC/yv0wVVnD2ZMioXy3Orh4E/bG/xqpYwiDjhVedUGQMZKqSZp
 IsloYcGhvJ0B4HbCUH1dKzV7c/Vu9fU8k+DlskVemHnZNtfeswgFEPk
X-Mailer: b4 0.12.3
Message-ID: <20230908-kselftest-09-08-v2-1-0def978a4c1b@google.com>
Subject: [PATCH v2 1/3] selftests/hid: ensure we can compile the tests on
 kernels pre-6.3
From: Justin Stitt <justinstitt@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Benjamin Tissoires <bentiss@kernel.org>

For the hid-bpf tests to compile, we need to have the definition of
struct hid_bpf_ctx. This definition is an internal one from the kernel
and it is supposed to be defined in the generated vmlinux.h.

This vmlinux.h header is generated based on the currently running kernel
or if the kernel was already compiled in the tree. If you just compile
the selftests without compiling the kernel beforehand and you are running
on a 6.2 kernel, you'll end up with a vmlinux.h without the hid_bpf_ctx
definition.

Use the clever trick from tools/testing/selftests/bpf/progs/bpf_iter.h
to force the definition of that symbol in case we don't find it in the
BTF and also add __attribute__((preserve_access_index)) to further
support CO-RE functionality for these tests.

Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/progs/hid.c            |  3 --
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 88c593f753b5..1e558826b809 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Red hat */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include "hid_bpf_helpers.h"
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 4fff31dbe0e7..ab3b18ba48c4 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -5,6 +5,55 @@
 #ifndef __HID_BPF_HELPERS_H
 #define __HID_BPF_HELPERS_H
 
+/* "undefine" structs in vmlinux.h, because we "override" them below */
+#define hid_bpf_ctx hid_bpf_ctx___not_used
+#define hid_report_type hid_report_type___not_used
+#define hid_class_request hid_class_request___not_used
+#define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
+#include "vmlinux.h"
+#undef hid_bpf_ctx
+#undef hid_report_type
+#undef hid_class_request
+#undef hid_bpf_attach_flags
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/const.h>
+
+enum hid_report_type {
+	HID_INPUT_REPORT		= 0,
+	HID_OUTPUT_REPORT		= 1,
+	HID_FEATURE_REPORT		= 2,
+
+	HID_REPORT_TYPES,
+};
+
+struct hid_bpf_ctx {
+	__u32 index;
+	const struct hid_device *hid;
+	__u32 allocated_size;
+	enum hid_report_type report_type;
+	union {
+		__s32 retval;
+		__s32 size;
+	};
+} __attribute__((preserve_access_index));
+
+enum hid_class_request {
+	HID_REQ_GET_REPORT		= 0x01,
+	HID_REQ_GET_IDLE		= 0x02,
+	HID_REQ_GET_PROTOCOL		= 0x03,
+	HID_REQ_SET_REPORT		= 0x09,
+	HID_REQ_SET_IDLE		= 0x0A,
+	HID_REQ_SET_PROTOCOL		= 0x0B,
+};
+
+enum hid_bpf_attach_flags {
+	HID_BPF_FLAG_NONE = 0,
+	HID_BPF_FLAG_INSERT_HEAD = _BITUL(0),
+	HID_BPF_FLAG_MAX,
+};
+
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,

-- 
2.42.0.283.g2d96d420d3-goog


