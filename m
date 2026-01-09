Return-Path: <bpf+bounces-78359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457AD0BF22
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0C8C3058BF7
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10F62DCF6B;
	Fri,  9 Jan 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SqYBx/iY"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4B33D503
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984596; cv=none; b=FJ8UgRDqVQ7QI+g96DN6SlF7rNrkafW+PQsmfq+C+Q/j8+EQr/FAIBnr+Mbrx1PtgFRJ109ioW5C+3a4G6+X9XXJKjER0kdg98+yaGoxxbS4KTzT/wpjwzI0QEOC8ahtdqpHhbLR1ee45y76n5QLgSNceifkDBDwp4ePehfT4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984596; c=relaxed/simple;
	bh=vnfT/MxFB789kZsoc+mRB1qE5YotE34y0Xhrm1/yBuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoB2xN9TWnEBC27sqo7kAlcyI8jssv98U4ABYHZc1unqr8u6GAEXfgd0L0mKyzNef3EZymjt82iV1vBIWisAclDF6oWNsvL8hShIh3Qnk1FEKy1u25fY3EkqZMA6luv+Sl6gyDU0jQ2VaR00FEWksVpegJSrpPTbPw7gSFxOJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SqYBx/iY; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767984592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQn5JdHX2mc1db31v0ksdAD5iVtUnSZyiKxTDgLohM8=;
	b=SqYBx/iYoyt7vJrLGNTqOmKyewzitew42Rle+l7AFbOOG85MMMcNK/xew/0xO+ZnQYQHTp
	0q915h+PtNmJmL+7EOfn/356690FVVYwDCXuF64Ao/n70nTGJAlShkOWyZiIkxvKKlfFwa
	gmv8dLcLPIQfpLqucbFYM+KeFdViWEI=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v1 07/10] HID: Use bpf_wq_set_callback kernel function
Date: Fri,  9 Jan 2026 10:48:49 -0800
Message-ID: <20260109184852.1089786-8-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove extern declaration of bpf_wq_set_callback_impl() from
hid_bpf_helpers.h and replace bpf_wq_set_callback macro with a
corresponding new declaration.

Fix selftests/hid build failure caused by missing BPF_CFLAGS.

Tested with:
  # append tools/testing/selftests/hid/config and build the kernel
  $ make -C tools/testing/selftests/hid
  # in built kernel
  $ ./tools/testing/selftests/hid/hid_bpf -t test_multiply_events_wq

  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           hid_bpf.test_multiply_events_wq ...
  [    2.575520] hid-generic 0003:0001:0A36.0001: hidraw0: USB HID v0.00 Device [test-uhid-device-138] on 138
  #            OK  hid_bpf.test_multiply_events_wq
  ok 1 hid_bpf.test_multiply_events_wq
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
  PASS

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 drivers/hid/bpf/progs/hid_bpf_helpers.h             | 8 +++-----
 tools/testing/selftests/hid/Makefile                | 4 +++-
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 8 +++-----
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/bpf/progs/hid_bpf_helpers.h b/drivers/hid/bpf/progs/hid_bpf_helpers.h
index bf19785a6b06..228f8d787567 100644
--- a/drivers/hid/bpf/progs/hid_bpf_helpers.h
+++ b/drivers/hid/bpf/progs/hid_bpf_helpers.h
@@ -33,11 +33,9 @@ extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx,
 /* bpf_wq implementation */
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
-extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-		int (callback_fn)(void *map, int *key, void *value),
-		unsigned int flags__k, void *aux__ign) __ksym;
-#define bpf_wq_set_callback(wq, cb, flags) \
-	bpf_wq_set_callback_impl(wq, cb, flags, NULL)
+extern int bpf_wq_set_callback(struct bpf_wq *wq,
+		int (*callback_fn)(void *, int *, void *),
+		unsigned int flags) __weak __ksym;
 
 #define HID_MAX_DESCRIPTOR_SIZE	4096
 #define HID_IGNORE_EVENT	-1
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2839d2612ce3..4c01bb649913 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -184,7 +184,9 @@ MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
 BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 		\
-	     -I$(INCLUDE_DIR)
+	     -I$(INCLUDE_DIR)						\
+	     -Wno-microsoft-anon-tag					\
+	     -fms-extensions
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
 	       -Wno-compare-distinct-pointer-types
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 531228b849da..80ab60905865 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -116,10 +116,8 @@ extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx,
 /* bpf_wq implementation */
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
-extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-		int (callback_fn)(void *map, int *key, void *wq),
-		unsigned int flags__k, void *aux__ign) __weak __ksym;
-#define bpf_wq_set_callback(timer, cb, flags) \
-	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
+extern int bpf_wq_set_callback(struct bpf_wq *wq,
+		int (*callback_fn)(void *, int *, void *),
+		unsigned int flags) __weak __ksym;
 
 #endif /* __HID_BPF_HELPERS_H */
-- 
2.52.0


