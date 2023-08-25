Return-Path: <bpf+bounces-8553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4AC78822C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656DF281772
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A61322A;
	Fri, 25 Aug 2023 08:36:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E9291F
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A501FC433CC;
	Fri, 25 Aug 2023 08:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692952602;
	bh=ZRxhja+kWh95QQ9Ag5tsl+R/z0NeWzN9jHlu0C7A4wA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ft+8pwJyuWHEfv4Jl7PdNA12K2RPuM6IDfiaadzHshHHqYz1dFU4H1rXpJMxZDIQx
	 6WnBtnSNWpdPeCZwuVRLxMzU2o22MxJVx29n1xnV97mJXenykoSu1mtuwuyFOX0Z6k
	 5YS+ESe4wewwrbSMD+rqyizPXG3H91b2a4QfelR44e+VaIyGd5ztW7AE5VdbcWOEKn
	 +un/KtsRYlXpRMDqUyR0ublP6/5ITXfQMELxz+rCeO7gkLzYruy0SWtcyOsSCii6nc
	 a4xZfHQIx/co4aJ0GeZbU02icMfWj9DOCZ8Dei3KvM1olfOAXzYAQfEf2adUhw7luK
	 dT70CsaI6jSLA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 25 Aug 2023 10:36:31 +0200
Subject: [PATCH 1/3] selftests/hid: ensure we can compile the tests on
 kernels pre-6.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v1-1-c862769020a8@kernel.org>
References: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
In-Reply-To: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Justin Stitt <justinstitt@google.com>, 
 Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692952596; l=2354;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ZRxhja+kWh95QQ9Ag5tsl+R/z0NeWzN9jHlu0C7A4wA=;
 b=iimzBHHTtnw9UqT5LTPnPjH2BmblUlmSaOVOnH9AokjeoHggqohBXHVXAhGNKTDsWMAp+ZDkr
 if9Qg/YhTcsBAMcZJyNG0YP8pdfdEPEJYwJ+j4k+6GM4wtitaQ6IbZJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

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
BTF.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/progs/hid.c             |  3 ---
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

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
index 4fff31dbe0e7..749097f8f4d9 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -5,6 +5,26 @@
 #ifndef __HID_BPF_HELPERS_H
 #define __HID_BPF_HELPERS_H
 
+/* "undefine" structs in vmlinux.h, because we "override" them below */
+#define hid_bpf_ctx hid_bpf_ctx___not_used
+#include "vmlinux.h"
+#undef hid_bpf_ctx
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
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
+};
+
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,

-- 
2.39.1


