Return-Path: <bpf+bounces-48431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B065A07FE4
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDC3188BAC8
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E38C19D081;
	Thu,  9 Jan 2025 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="R1vLQ+yU"
X-Original-To: bpf@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187C13B2B8;
	Thu,  9 Jan 2025 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447864; cv=none; b=Lq9ZQSBmJwqHHg0gzUDoHfOPxyxSmiElHvxbqzKrovanf/UaUO1+iQiaZDCEO4A3Xk3/3UFyA0UxquCcMiAmP62Q6UEDBvjOYA6OtqaMzdD9SqlXvmKl30vi1IwXjYk4Qn22vKaMy9B6eQ/Ls1PxUvP9vDE0vZ1TWNGcvBx8/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447864; c=relaxed/simple;
	bh=ucw+uP9EwSHDOcG+pjr12fHHdfM1VZuXNa3NtH5ZJOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2MHEOTjNazd3wuXqg1zhWGz+sAqzVYCkZugwr4CxbeGzf4U4i5UasHVLjpcdFWdqMgf6e9VpST7ljt1cMaRlD6TYyptJPhyYuQMsZPlAxC2zq6iYW+lgnFzjvoIiNQ8C01+TjzjDKDKD+ahFhvQBMxYeYAMyw+ILRzIqIjA6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=R1vLQ+yU; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (pd9e5946e.dip0.t-ipconnect.de [217.229.148.110])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 36BF42FC007B;
	Thu,  9 Jan 2025 19:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1736447853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ufmmxImt2CUdgjCn0jac9WAzrcm/rpKHwW8TaVpqlgs=;
	b=R1vLQ+yU468zhXurHcTtuPWItXOwCDI+JgHQE4V5SU3CF1EbPSFi+aQsuvTDP8gyjYwTkS
	Fnb0R9PGmtvZI7pl5Z5oMvr32g75cRlpaULgLtFgCMk+X2pGdxV6loMhmGrgFPtiMwG4kC
	b7+i/VwFXm5jYyVSIloklcJKGvxpZzQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Werner Sembach <wse@tuxedocomputers.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] Suppress bogus F13 trigger on Sirius keyboard full fan shortcut
Date: Thu,  9 Jan 2025 19:37:01 +0100
Message-ID: <20250109183723.190507-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TUXEDO Sirius 15 Gen1 and the TUXEDO Sirius 15 Gen2 Notebooks have an
additional "fan" key next to F12.

Pressing it alone sends a F14 key press which can be bound by user space.

Pressing it while holding the FN key triggers two things:
- The EC firmware locks the fan speed of the internal fans at 100%
- F13 key press is registered which by default is already bound in xkb and
  desktop environments (e.g. in KDE Plasma it launches system settings)

To avoid this unexpected double duty of the FN shortcut, this bpf program
suppresses the F13 key press.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 MAINTAINERS                                   |  6 +++
 .../TUXEDO__Sirius-15-Gen1-and-Gen2.bpf.c     | 51 +++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 drivers/hid/bpf/progs/TUXEDO__Sirius-15-Gen1-and-Gen2.bpf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 30cbc3d44cd53..cdd86aaa4d979 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23924,6 +23924,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
 F:	tools/power/x86/turbostat/
 F:	tools/testing/selftests/turbostat/
 
+TUXEDO SIRIUS 15 GEN1 AND GEN2 BPF KEYBOARD FIX
+M:	Werner Sembach <wse@tuxedocomputers.com>
+L:	linux-input@vger.kernel.org
+S:	Supported
+F:	drivers/hid/bpf/progs/TUXEDO__Sirius-15-Gen1-and-Gen2.bpf.c
+
 TW5864 VIDEO4LINUX DRIVER
 M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
 M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
diff --git a/drivers/hid/bpf/progs/TUXEDO__Sirius-15-Gen1-and-Gen2.bpf.c b/drivers/hid/bpf/progs/TUXEDO__Sirius-15-Gen1-and-Gen2.bpf.c
new file mode 100644
index 0000000000000..e77530bd60a59
--- /dev/null
+++ b/drivers/hid/bpf/progs/TUXEDO__Sirius-15-Gen1-and-Gen2.bpf.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2025 TUXEDO Computers GmbH
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, 0x048D, 0x8910)
+);
+
+SEC(HID_BPF_DEVICE_EVENT)
+int BPF_PROG(ignore_key_fix_event, struct hid_bpf_ctx *hid_ctx)
+{
+	const int expected_length = 37;
+	const int expected_report_id = 1;
+	__u8 *data;
+	int i;
+
+	if (hid_ctx->size < expected_length)
+		return 0;
+
+	data = hid_bpf_get_data(hid_ctx, 0, expected_length);
+	if (!data || data[0] != expected_report_id)
+		return 0;
+
+
+	// Delete F13 (HID usage ID: 0x68) key press.
+
+	// The first 6 parallel key presses (excluding modifier keys) are
+	// encoded in an array containing usage IDs.
+	for (i = 3; i < 9; ++i)
+		if (data[i] == 0x68)
+			data[i] = 0x00;
+
+	// Additional parallel key presses starting with the 7th (excluding
+	// modifier keys) are encoded as a bit flag with the offset being
+	// the usage ID.
+	data[22] &= 0xfe;
+
+
+	return 0;
+}
+
+HID_BPF_OPS(ignore_button) = {
+	.hid_device_event = (void *)ignore_key_fix_event,
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


