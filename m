Return-Path: <bpf+bounces-33249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C18491A324
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802CB1C220D0
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566913DDAB;
	Thu, 27 Jun 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5W7HY4z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CA13D8AE;
	Thu, 27 Jun 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482071; cv=none; b=FtAzZzoxtl8sHNu7ldg+iczHFOGcnDJA+nOxLhlgsGTIu3XHLveROVmLAk+iuN/jF1u4EexAUGPGQfEsFp4aaVlRXXP2s+MVO1jtDz8esiGsNj4yblnC46SQiRr2IdmVePbugUyHzcxzyejuo/udzEsKUgjPEsGt1G9dqaBYtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482071; c=relaxed/simple;
	bh=9GXsYZ3g+nul0QRkNDYMJ8neksOkpTDDlttRum4aA8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utxSvDsScbUUMwsRWstvZYl/Q1TyfW1801o+WZZOIJdC6y/KwYu7J72fJmRgJ22mzNikt9rncjMHnrpk+DDXi93jnbJomoxINHPbfnIMIdTrJPeYdAU/2tocV8M/0WCwS7qqOBU2FtrSVqGfufIoIeUBqRptUcRgSVtY0cJqvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5W7HY4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4637EC32786;
	Thu, 27 Jun 2024 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719482071;
	bh=9GXsYZ3g+nul0QRkNDYMJ8neksOkpTDDlttRum4aA8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H5W7HY4z1X67ndZDUBxK1sIDEzPm5F8tEmM29EV2hLWiJsG6RkfMUDkuolgVBMcx3
	 AgJHDZrgI2Tdde04NRgM87W7y2NJCoNOtjT9YjLnDmMyrbjMS0vVOJXu1hz72uKj1j
	 IUahmVpNt8RIAtOH6vvLbhjF3bbFODNVoN4GwKxuj3p6MKRtrHhsDIQnpQ6OOpzHCR
	 lTepgyHprExBKSmwp/j6ZC1b1nxJyDnhYXNd5PmXo7FE4ccuFD6csxtOD2c+FP8euY
	 N4fzHRwqSEHlFEm8w4jh4eDVAb/18sYIgyPZDwxMRhqKz+RFY9MO/ih/QsFtxI9fuj
	 wgIHIOn9ejlmQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 27 Jun 2024 11:54:20 +0200
Subject: [PATCH 4/6] HID: bpf: Add support for the XP-PEN Deco Mini 4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240627-import-bpf-v1-4-0dbcda4a5b1f@kernel.org>
References: <20240627-import-bpf-v1-0-0dbcda4a5b1f@kernel.org>
In-Reply-To: <20240627-import-bpf-v1-0-0dbcda4a5b1f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719482062; l=10943;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=9GXsYZ3g+nul0QRkNDYMJ8neksOkpTDDlttRum4aA8M=;
 b=hVq4a5nbtLN2opLgC0TLNo7LGFe62wE8pYRqlEb5j9Hzqh4ZZSknmlg1hY8E25TmJ5Q/aC284
 romFPPGwLwwAhdcfMN8fSVOb2f6oLR67G9DZcJcMsEe3TPbWOW5KQJU
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The XP-PEN Deco Mini 4 is a UGEE device with a frame with 6 buttons.
Its pen has 2 buttons and supports pressure reporting.

Fix their report descriptors and transform the frame button events to
support it.

Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/88
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c | 231 +++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c b/drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c
new file mode 100644
index 000000000000..46d5c459d0c9
--- /dev/null
+++ b/drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 José Expósito
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define VID_UGEE	0x28BD
+#define PID_DECO_MINI_4	0x0929
+#define RDESC_SIZE_PAD	177
+#define RDESC_SIZE_PEN	109
+#define PAD_REPORT_ID	0x06
+
+/*
+ * XP-Pen devices return a descriptor with the values the driver should use when
+ * one of its interfaces is queried. For this device the descriptor is:
+ *
+ * 0E 03 60 4F 88 3B 06 00 FF 1F D8 13
+ *       ----- -----       ----- -----
+ *         |     |           |     |
+ *         |     |           |     `- Resolution: 5080 (13d8)
+ *         |     |           `- Maximum pressure: 8191 (1FFF)
+ *         |     `- Logical maximum Y: 15240 (3B88)
+ *         `- Logical maximum X: 20320 (4F60)
+ *
+ * The physical maximum is calculated as (logical_max * 1000) / resolution.
+ */
+#define LOGICAL_MAX_X	0x60, 0x4F
+#define LOGICAL_MAX_Y	0x88, 0x3B
+#define PHYSICAL_MAX_X	0xA0, 0x0F
+#define PHYSICAL_MAX_Y	0xB8, 0x0B
+#define PRESSURE_MAX	0xFF, 0x1F
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_UGEE, PID_DECO_MINI_4)
+);
+
+/*
+ * The tablet send these values when the pad buttons are pressed individually:
+ *
+ *   Buttons released: 06 00 00 00 00 00 00 00
+ *   Button 1:         06 00 05 00 00 00 00 00 -> b
+ *   Button 2:         06 00 08 00 00 00 00 00 -> e
+ *   Button 3:         06 04 00 00 00 00 00 00 -> LAlt
+ *   Button 4:         06 00 2c 00 00 00 00 00 -> Space
+ *   Button 5:         06 01 16 00 00 00 00 00 -> LControl + s
+ *   Button 6:         06 01 1d 00 00 00 00 00 -> LControl + z
+ *
+ * When multiple buttons are pressed at the same time, the values used to
+ * identify the buttons are identical, but they appear in different bytes of the
+ * record. For example, when button 2 (0x08) and button 1 (0x05) are pressed,
+ * this is the report:
+ *
+ *   Buttons 2 and 1:  06 00 08 05 00 00 00 00 -> e + b
+ *
+ * Buttons 1, 2, 4, 5 and 6 can be matched by finding their values in the
+ * report.
+ *
+ * Button 3 is pressed when the 3rd bit is 1. For example, pressing buttons 3
+ * and 5 generates this report:
+ *
+ *   Buttons 3 and 5:  06 05 16 00 00 00 00 00 -> LControl + LAlt + s
+ *                        -- --
+ *                         |  |
+ *                         |  `- Button 5 (0x16)
+ *                         `- 0x05 = 0101. Button 3 is pressed
+ *                                    ^
+ *
+ * pad_buttons contains a list of buttons that can be matched in
+ * HID_BPF_DEVICE_EVENT. Button 3 as it has a dedicated bit.
+ */
+static const __u8 pad_buttons[] = { 0x05, 0x08, 0x00, 0x2C, 0x16, 0x1D };
+
+static const __u8 fixed_pad_rdesc[] = {
+	0x05, 0x01,           /*  Usage Page (Desktop),                   */
+	0x09, 0x07,           /*  Usage (Keypad),                         */
+	0xA1, 0x01,           /*  Collection (Application),               */
+	0x85, 0x06,           /*      Report ID (6),                      */
+	0x05, 0x0D,           /*      Usage Page (Digitizer),             */
+	0x09, 0x39,           /*      Usage (Tablet Function Keys),       */
+	0xA0,                 /*      Collection (Physical),              */
+	0x05, 0x09,           /*          Usage Page (Button),            */
+	0x75, 0x01,           /*          Report Size (1),                */
+	0x95, 0x06,           /*          Report Count (6),               */
+	0x19, 0x01,           /*          Usage Minimum (01h),            */
+	0x29, 0x06,           /*          Usage Maximum (06h),            */
+	0x14,                 /*          Logical Minimum (0),            */
+	0x25, 0x01,           /*          Logical Maximum (1),            */
+	0x81, 0x02,           /*          Input (Variable),               */
+	0x95, 0x32,           /*          Report Count (50),              */
+	0x81, 0x01,           /*          Input (Constant),               */
+	0xC0,                 /*      End Collection,                     */
+	0xC0                  /*  End Collection                          */
+};
+
+static const __u8 fixed_pen_rdesc[] = {
+	0x05, 0x0d,           /*  Usage Page (Digitizers),                */
+	0x09, 0x01,           /*  Usage (Digitizer),                      */
+	0xa1, 0x01,           /*  Collection (Application),               */
+	0x85, 0x07,           /*      Report ID (7),                      */
+	0x09, 0x20,           /*      Usage (Stylus),                     */
+	0xa1, 0x00,           /*      Collection (Physical),              */
+	0x09, 0x42,           /*          Usage (Tip Switch),             */
+	0x09, 0x44,           /*          Usage (Barrel Switch),          */
+	0x09, 0x46,           /*          Usage (Tablet Pick),            */
+	0x75, 0x01,           /*          Report Size (1),                */
+	0x95, 0x03,           /*          Report Count (3),               */
+	0x14,                 /*          Logical Minimum (0),            */
+	0x25, 0x01,           /*          Logical Maximum (1),            */
+	0x81, 0x02,           /*          Input (Variable),               */
+	0x95, 0x02,           /*          Report Count (2),               */
+	0x81, 0x03,           /*          Input (Constant, Variable),     */
+	0x09, 0x32,           /*          Usage (In Range),               */
+	0x95, 0x01,           /*          Report Count (1),               */
+	0x81, 0x02,           /*          Input (Variable),               */
+	0x95, 0x02,           /*          Report Count (2),               */
+	0x81, 0x03,           /*          Input (Constant, Variable),     */
+	0x75, 0x10,           /*          Report Size (16),               */
+	0x95, 0x01,           /*          Report Count (1),               */
+	0x35, 0x00,           /*          Physical Minimum (0),           */
+	0xa4,                 /*          Push,                           */
+	0x05, 0x01,           /*          Usage Page (Desktop),           */
+	0x09, 0x30,           /*          Usage (X),                      */
+	0x65, 0x13,           /*          Unit (Inch),                    */
+	0x55, 0x0d,           /*          Unit Exponent (-3),             */
+	0x26, LOGICAL_MAX_X,  /*          Logical Maximum,                */
+	0x46, PHYSICAL_MAX_X, /*          Physical Maximum,               */
+	0x81, 0x02,           /*          Input (Variable),               */
+	0x09, 0x31,           /*          Usage (Y),                      */
+	0x26, LOGICAL_MAX_Y,  /*          Logical Maximum,                */
+	0x46, PHYSICAL_MAX_Y, /*          Physical Maximum,               */
+	0x81, 0x02,           /*          Input (Variable),               */
+	0xb4,                 /*          Pop,                            */
+	0x09, 0x30,           /*          Usage (Tip Pressure),           */
+	0x45, 0x00,           /*          Physical Maximum (0),           */
+	0x26, PRESSURE_MAX,   /*          Logical Maximum,                */
+	0x75, 0x0D,           /*          Report Size (13),               */
+	0x95, 0x01,           /*          Report Count (1),               */
+	0x81, 0x02,           /*          Input (Variable),               */
+	0x75, 0x01,           /*          Report Size (1),                */
+	0x95, 0x13,           /*          Report Count (19),              */
+	0x81, 0x01,           /*          Input (Constant),               */
+	0xc0,                 /*      End Collection,                     */
+	0xc0,                 /*  End Collection                          */
+};
+
+static const size_t fixed_pad_rdesc_size = sizeof(fixed_pad_rdesc);
+static const size_t fixed_pen_rdesc_size = sizeof(fixed_pen_rdesc);
+
+SEC(HID_BPF_RDESC_FIXUP)
+int BPF_PROG(hid_rdesc_fixup_xppen_deco_mini_4, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0, HID_MAX_DESCRIPTOR_SIZE);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	if (hctx->size == RDESC_SIZE_PAD) {
+		__builtin_memcpy(data, fixed_pad_rdesc, fixed_pad_rdesc_size);
+		return fixed_pad_rdesc_size;
+	} else if (hctx->size == RDESC_SIZE_PEN) {
+		__builtin_memcpy(data, fixed_pen_rdesc, fixed_pen_rdesc_size);
+		return fixed_pen_rdesc_size;
+	}
+
+	return 0;
+}
+
+SEC(HID_BPF_DEVICE_EVENT)
+int BPF_PROG(hid_device_event_xppen_deco_mini_4, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 8 /* size */);
+	__u8 button_mask = 0;
+	int d, b;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	if (data[0] != PAD_REPORT_ID)
+		return 0;
+
+	/* data[1] stores the status of BTN_2 in the 3rd bit*/
+	if (data[1] & BIT(2))
+		button_mask |= BIT(2);
+
+	/* The rest of the descriptor stores the buttons as in pad_buttons */
+	for (d = 2; d < 8; d++) {
+		for (b = 0; b < sizeof(pad_buttons); b++) {
+			if (data[d] != 0 && data[d] == pad_buttons[b])
+				button_mask |= BIT(b);
+		}
+	}
+
+	__u8 report[8] = {PAD_REPORT_ID, button_mask, 0x00};
+
+	__builtin_memcpy(data, report, sizeof(report));
+
+	return 0;
+}
+
+HID_BPF_OPS(deco_mini_4) = {
+	.hid_device_event = (void *)hid_device_event_xppen_deco_mini_4,
+	.hid_rdesc_fixup = (void *)hid_rdesc_fixup_xppen_deco_mini_4,
+};
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	/*
+	 * The device has 2 modes: The compatibility mode, enabled by default,
+	 * and the raw mode, that can be activated by sending a buffer of magic
+	 * data to a certain USB endpoint.
+	 *
+	 * Depending on the mode, different interfaces of the device are used:
+	 * - First interface:  Pad in compatibility mode
+	 * - Second interface: Pen in compatibility mode
+	 * - Third interface:  Only used in raw mode
+	 *
+	 * We'll use the device in compatibility mode.
+	 */
+	ctx->retval = ctx->rdesc_size != RDESC_SIZE_PAD &&
+		      ctx->rdesc_size != RDESC_SIZE_PEN;
+	if (ctx->retval)
+		ctx->retval = -EINVAL;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.44.0


