Return-Path: <bpf+bounces-35073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB27A937620
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 11:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913F61F24E2B
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7938286F;
	Fri, 19 Jul 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLBF77U2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5342076;
	Fri, 19 Jul 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382683; cv=none; b=M8kUdL8MLlCNFzPNiTox165E+Uomz5d6oUAZCAk4qAS17+u+3jqYfxHaQ/ikcfIoI/KqMwxD3C8roOhTLJYXlBCewMAlw2zLEAgTZmyQdudFXZnecIQ08Cui6r8bO+9YO2eUHWCtdVKXvIQsNf2X9VDnFXc6wZxYubgEBhcYHNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382683; c=relaxed/simple;
	bh=MnSXZ5Y2JRGaTvmzg6a7BtAvUyKUSa9nM+gZtSNp1Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DYZvN/0ErEIZzi+kUoamCGlvxfvzqgInCzE/AVX65dkq8SLk2KujK7pXaW3c0YFOta/h+9rYiDvuBi52AhyAeij79inodT0btMFhp/FuGMufEK5OobsHCSaGjBbI/Z5FrXjZiog9w/ljsMwrufe0uhrBeMvHTLLCdCl2ALMT7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLBF77U2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B394AC4AF0E;
	Fri, 19 Jul 2024 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721382683;
	bh=MnSXZ5Y2JRGaTvmzg6a7BtAvUyKUSa9nM+gZtSNp1Ak=;
	h=From:To:Cc:Subject:Date:From;
	b=DLBF77U2pivtOk6gtH55fnZlisUxzZOULdaT+7dl143fWz8yGk3F5v4eGDK5U76fK
	 zR21b4MhvwlsMU+AEcu//K15Y6fn5WJnLidpl+Bk6yP3+7v4IK3/wdGoB0DDFxsS78
	 2t6N9BbcrwvJJHdBiz/kmLQJijilka2SWMGIGxotATNEZPqOGwrGPz2y3+C7IXMZVh
	 Sgzveqt90J58bYwqaxLEJWJrsy0cLQCetkaPT/G6agdMhGfMrn6x2UA++0AoD2lInG
	 hpwp/o+0K0TQ4j9mcPuQzf480upjMETTOjl7RvUmXfGOsL37mZMlOD5gTkF4DoT/50
	 r0+LZhvaifc1A==
From: Arnd Bergmann <arnd@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] hid: bpf: avoid building struct ops without JIT
Date: Fri, 19 Jul 2024 11:51:07 +0200
Message-Id: <20240719095117.3482509-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The module does not do anything when the JIT is disabled, but instead
causes a warning:

In file included from include/linux/bpf_verifier.h:7,
                 from drivers/hid/bpf/hid_bpf_struct_ops.c:10:
drivers/hid/bpf/hid_bpf_struct_ops.c: In function 'hid_bpf_struct_ops_init':
include/linux/bpf.h:1853:50: error: statement with no effect [-Werror=unused-value]
 1853 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
      |                                                  ^~~~~~~~~~~~~~~~
drivers/hid/bpf/hid_bpf_struct_ops.c:305:16: note: in expansion of macro 'register_bpf_struct_ops'
  305 |         return register_bpf_struct_ops(&bpf_hid_bpf_ops, hid_bpf_ops);
      |                ^~~~~~~~~~~~~~~~~~~~~~~

This could be avoided by making HID-BPF just depend on JIT, but that
is probably not what we want here. Checking the other users of struct_ops,
I see that those just leave out the struct_ops usage, so do the same here.

Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/bpf/Makefile           | 3 ++-
 drivers/hid/bpf/hid_bpf_dispatch.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/Makefile b/drivers/hid/bpf/Makefile
index d1f2b81788ca..7566be8eefba 100644
--- a/drivers/hid/bpf/Makefile
+++ b/drivers/hid/bpf/Makefile
@@ -8,4 +8,5 @@ LIBBPF_INCLUDE = $(srctree)/tools/lib
 obj-$(CONFIG_HID_BPF) += hid_bpf.o
 CFLAGS_hid_bpf_dispatch.o += -I$(LIBBPF_INCLUDE)
 CFLAGS_hid_bpf_jmp_table.o += -I$(LIBBPF_INCLUDE)
-hid_bpf-objs += hid_bpf_dispatch.o hid_bpf_struct_ops.o
+hid_bpf-y += hid_bpf_dispatch.o
+hid_bpf-$(CONFIG_BPF_JIT) += hid_bpf_struct_ops.o
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.h b/drivers/hid/bpf/hid_bpf_dispatch.h
index 44c6ea22233f..577572f41454 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.h
+++ b/drivers/hid/bpf/hid_bpf_dispatch.h
@@ -14,7 +14,13 @@ struct hid_bpf_ctx_kern {
 struct hid_device *hid_get_device(unsigned int hid_id);
 void hid_put_device(struct hid_device *hid);
 int hid_bpf_allocate_event_data(struct hid_device *hdev);
+#ifdef CONFIG_BPF_JIT
 void __hid_bpf_ops_destroy_device(struct hid_device *hdev);
+#else
+static inline void __hid_bpf_ops_destroy_device(struct hid_device *hdev)
+{
+}
+#endif
 int hid_bpf_reconnect(struct hid_device *hdev);
 
 struct bpf_prog;
-- 
2.39.2


