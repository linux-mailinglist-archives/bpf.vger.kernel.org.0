Return-Path: <bpf+bounces-30662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B88D043C
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6061F214B7
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E416D9DB;
	Mon, 27 May 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVzdMkz8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A316D9DA;
	Mon, 27 May 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819485; cv=none; b=i6CztnPiTCl5uXxb0dfS6P0+TOPGeFbaaXkMBMAcEBoRoLoOzpjXyo2cXww54Dw/F45KoH7uI0NRXS8OwfjH1gfBAxNQqroWAMB5Nw+NFBOdpovI6oCiajMj6vpUTb+9vq3/0j2dIOcwC3qpYnVNCXIgwpJ461aJAJW9KXwQ1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819485; c=relaxed/simple;
	bh=HksO7wi2Tu4etRYRKkyII0g6QFyH1LvtCOoKVJ36MLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJz1r5GgtspCyuMjTS6BrH9ri8OEkYOKr9LgSLk47dSRkF442vk8xAgpRlpj2ijqkXDP2+RxcwLqhVIj/bQe3Ytkuy4wVuBwGQJgWculBVsNDHyKBqCp3KZUK19kt75hSaPDPs5FkI0DWWIcCeaLtAn/wRBX4YYPodZVBPQpTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVzdMkz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E79C32781;
	Mon, 27 May 2024 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819485;
	bh=HksO7wi2Tu4etRYRKkyII0g6QFyH1LvtCOoKVJ36MLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVzdMkz8vmaHqBxExs1DZ3EjfIfi6/ZWSTs3nFPYmxnpX3tLLCLah1FzOJASjUn+z
	 09IYHLu6Bh+xynp7NebORF7lFViHjNA9NEe0TxEkFbJhyQNB06cgKowIbXGkfZjnMl
	 7t6jB1vuGa1oahizYuDDwciFdzmT9QEoMAbSqOlU37ZGtMaGwxyLLfMsP7Bg/jHYij
	 Hz8WUnGvi0TNBwLtiGWAZ0xjYjPAxz6Tv7VtRubHtpZoHJI+OJ+HO+++sDMM0C8dUv
	 3RanLVtgwqw4l5CJfUkz5gFBCK5MfGKQ1NMj7md6k/4NPXMbTlobcVGaBlFkNhsdXv
	 KIBMzRWJapOWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/17] HID: bpf: add in-tree HID-BPF fix for the HP Elite Presenter Mouse
Date: Mon, 27 May 2024 10:16:53 -0400
Message-ID: <20240527141712.3853988-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141712.3853988-1-sashal@kernel.org>
References: <20240527141712.3853988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Benjamin Tissoires <bentiss@kernel.org>

[ Upstream commit 4e6d2a297dd5be26ad409b7a05b20bd033d1c95e ]

Duplicate of commit 0db117359e47 ("HID: add quirk for 03f0:464a HP Elite
Presenter Mouse"), but in a slightly better way.

This time we actually change the application collection, making clearer
for userspace what the second mouse is.

Note that having both hid-quirks fix and this HID-BPF fix is not a
problem at all.

Link: https://lore.kernel.org/r/20240410-bpf_sources-v1-4-a8bf16033ef8@kernel.org
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../hid/bpf/progs/HP__Elite-Presenter.bpf.c   | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c

diff --git a/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
new file mode 100644
index 0000000000000..3d14bbb6f2762
--- /dev/null
+++ b/drivers/hid/bpf/progs/HP__Elite-Presenter.bpf.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Benjamin Tissoires
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define VID_HP 0x03F0
+#define PID_ELITE_PRESENTER 0x464A
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, VID_HP, PID_ELITE_PRESENTER)
+);
+
+/*
+ * Already fixed as of commit 0db117359e47 ("HID: add quirk for 03f0:464a
+ * HP Elite Presenter Mouse") in the kernel, but this is a slightly better
+ * fix.
+ *
+ * The HP Elite Presenter Mouse HID Record Descriptor shows
+ * two mice (Report ID 0x1 and 0x2), one keypad (Report ID 0x5),
+ * two Consumer Controls (Report IDs 0x6 and 0x3).
+ * Prior to these fixes it registers one mouse, one keypad
+ * and one Consumer Control, and it was usable only as a
+ * digital laser pointer (one of the two mouses).
+ * We replace the second mouse collection with a pointer collection,
+ * allowing to use the device both as a mouse and a digital laser
+ * pointer.
+ */
+
+SEC("fmod_ret/hid_bpf_rdesc_fixup")
+int BPF_PROG(hid_fix_rdesc, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* replace application mouse by application pointer on the second collection */
+	if (data[79] == 0x02)
+		data[79] = 0x01;
+
+	return 0;
+}
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	ctx->retval = ctx->rdesc_size != 264;
+	if (ctx->retval)
+		ctx->retval = -EINVAL;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


