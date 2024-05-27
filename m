Return-Path: <bpf+bounces-30671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F1C8D04BC
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803361F214B0
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 14:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE617B415;
	Mon, 27 May 2024 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCowWLh2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1669F17B408;
	Mon, 27 May 2024 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819626; cv=none; b=ubZ92oPOrZKHjqOzCdtCxtOmohpEafVp8enuYIddwa5vZhytIdRvSRbgww7+3isPj602tZQTDo5+hhJKYYciYZxnpY2fPGSt93VB/xA1ndSt5r2vd5EFH2CsL8KBCPeIsSL7ZGYz6nJIaSlg7XgNF2O4/WqpnNMLe5ialVGYB90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819626; c=relaxed/simple;
	bh=HksO7wi2Tu4etRYRKkyII0g6QFyH1LvtCOoKVJ36MLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUPEMuXU+LTQOJj1SufUTLuzntPAcDdpqtg//1VAej+NfAUX4BkYzBVR1kWtxgSgd9bzhja32b2N/bvIoIWJ1wl8LUffALqB8zlAKFSLnnvl4dswVZprbEouFH3ZN9tsRTBQfq91UlrneUiBsflBsbiWpwlr6Mpiq0funBVqMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCowWLh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3D5C2BBFC;
	Mon, 27 May 2024 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819626;
	bh=HksO7wi2Tu4etRYRKkyII0g6QFyH1LvtCOoKVJ36MLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCowWLh2sXP/MWEQjNYGiFN4hrc5UeFPjw73TNCi9svpFlcJvzaOH/xuo2yVwjiMM
	 EpfVhiLzOCEOrcVyAqu2XAtdUCUSctk5QvrPcwyhofOd0bN7KJ4VAmyQb8vtRCUZbB
	 UJuIvmV3ySdF7P0SP8F/98Eo5iwR9liznem+h39XIQ79qnbDnmbW8GtuFbbJVj5Oac
	 /4IYro19RRQTGqZbO1v2oq/vFeEBlj6GHjdrBIT6Dn0s1rcmfEXj5Bkp5oc3RJ6I6B
	 g1sQy/ALWl1CI47X49/n0s+RhpbHBj8Jqdyab2bJ6cD9X4TQpDc23YwAOI9UG1xJBh
	 sw6cIuEJHB/nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/3] HID: bpf: add in-tree HID-BPF fix for the HP Elite Presenter Mouse
Date: Mon, 27 May 2024 10:20:05 -0400
Message-ID: <20240527142010.3855135-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527142010.3855135-1-sashal@kernel.org>
References: <20240527142010.3855135-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.315
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


