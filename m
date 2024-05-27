Return-Path: <bpf+bounces-30665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CBC8D0465
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83A61F20F11
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB348155CBA;
	Mon, 27 May 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqUadv46"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47912155CAA;
	Mon, 27 May 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819528; cv=none; b=oIIy9VHkFZbru64KCDAMtKkvdm1CuI2++at90AsR7bmj1aYLM9tdSZXgOJz66rSoFjw3mPXeyjf9Q6QXsuSJerK6HS3UC5rdl20APAkGJdfHFCAIF1/fj3bu2B0ysWAMPQHav/f+OKbLlX+Fkea2YNNTQNqV6A8EehLrS7sUIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819528; c=relaxed/simple;
	bh=HksO7wi2Tu4etRYRKkyII0g6QFyH1LvtCOoKVJ36MLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGsOO875+gnN6sbWfmCt9FpXPmpPoyJzbGxmDg/cVAof64Nsv7gzRJCgHXCnJsoh2OvMxlt4HRicpgLjrv7UyaD8WbLlqrd31KQocdNa0yCORoXy2dEVdYbhngjprEZLHncm16jrHgF7xZ+1SMC29Ou9f2NU4mz8UZSlptgdZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqUadv46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B36FC4AF09;
	Mon, 27 May 2024 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819528;
	bh=HksO7wi2Tu4etRYRKkyII0g6QFyH1LvtCOoKVJ36MLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqUadv467otSItlbmohnF5e1uJ4i/pisLvupB39A4yHVgCeYAEfcqCRFAYE5EAsph
	 YRjnTgqhL0M4RhcM2tIBq5fk4GYClQvF41UAmqYvrsVwMn9Re18fMcoE7xBBQ6hvGa
	 1Mv34xc2qWCXvyI5ZkTeCquf3fJHTFXz1Z9pLZYfOHtL1xamIyesNFlk9SqSNDUzPQ
	 Kt59X6K4Rd2RN+bmEGBmY1aGFyWVhPii43r27D0HcY9QJomzfOqx2lh+mqXYDNmjxq
	 AoE4ppvqnrRrqTGtT+b7mZ5Ytc7kTBfOAOGVlHoZGXumt6wVIXMHiepeyo9amf4+Es
	 6Xe7zvALbMNrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/13] HID: bpf: add in-tree HID-BPF fix for the HP Elite Presenter Mouse
Date: Mon, 27 May 2024 10:18:06 -0400
Message-ID: <20240527141819.3854376-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141819.3854376-1-sashal@kernel.org>
References: <20240527141819.3854376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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


