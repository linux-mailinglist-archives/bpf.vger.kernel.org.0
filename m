Return-Path: <bpf+bounces-33251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B991A32A
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7517E1C2200F
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FF613F43A;
	Thu, 27 Jun 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG/nmzH0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AE113F00A;
	Thu, 27 Jun 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482074; cv=none; b=uc/BO0iZXa1zzaKvSC49Z23FOA3hlK1K0iAWoYxrIUfYZmPld4R83EhJMeNGDlsAOc8ibhwTKBLZyWV9qQnE4IElJ1WHi0/dmZqbTvzPPCOaBNKhWjeDyUvdVwclJb5GGT6Tr1b5mjYfFQ1AsbbEj5IdaLuzR702nxyuX5b4IbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482074; c=relaxed/simple;
	bh=tu7CIR9pJO3oS0xR2pFICcs+1vj90OEa9Dpv62YlS7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWLeKAxCXvchOxwRaRRMfL3+Wy60rLYBJHNaykf75d/8TxAWcjlCqnGqWR2Y1reRGo5XH1nZRqnOemhy3Awpn1GLaMLeIzamZisXun4fHbatzBysAKZ9yKjYoS/k6kD9WUCwg5YYCa2p+qdWYCMSlTuqgc38PRrDaFsWiQho7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG/nmzH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA50C32786;
	Thu, 27 Jun 2024 09:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719482074;
	bh=tu7CIR9pJO3oS0xR2pFICcs+1vj90OEa9Dpv62YlS7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MG/nmzH0jLt+uuk5C5+QCP3An95pwEUMxMB/IebbofIG8HWc0rmtGbXlV2SvfeA9i
	 PxO+MF3akJH8o42mHDDJJvEtZSdfbflua4PCzCsTxpvUxjbYSBa6LH+M/L90gMm+gX
	 4xRRUJnLqKQ069AL5Ltza/GR67uZOJO7Tt6dZRDfzSxHHsrFi1HJ0JRvSQk72jSLly
	 nGU9L3p52a0oSFjbyyKyd4EGIci84QySjZg5PnCwJbbEi6g/4UwL2kJmC7b/2lDyYS
	 8KtMtLJTHf9fRr/FmjnALvtWxcgNnqufmj3Pn2QdHl6oQx85U1Wevwv8F+g5LAqnWy
	 xVUBcvscFsr3A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 27 Jun 2024 11:54:22 +0200
Subject: [PATCH 6/6] HID: bpf: Thrustmaster TCA Yoke Boeing joystick fix
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-import-bpf-v1-6-0dbcda4a5b1f@kernel.org>
References: <20240627-import-bpf-v1-0-0dbcda4a5b1f@kernel.org>
In-Reply-To: <20240627-import-bpf-v1-0-0dbcda4a5b1f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 K S Iyer <kumar.s.iyer65@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719482062; l=8756;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=tu7CIR9pJO3oS0xR2pFICcs+1vj90OEa9Dpv62YlS7o=;
 b=mPQZRQkzv5KfaHd0G3ucbEmLgqQq1ipOIjB6EAUNl/it6/RyMhXAkR0duAf/OqBTlztnlPGTF
 hqRJxi3paABA5z720de7anQvk88kqm4YOKEs3w7tUc/xQVN0uFNu+Dy
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This joystick's original HID descriptor is wrong & it shows a
ABS_MISC axis in Linux that doesn't exist on the hardware.

Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/82
Signed-off-by: K S Iyer <kumar.s.iyer65@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 .../bpf/progs/Thrustmaster__TCA-Yoke-Boeing.bpf.c  | 144 +++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/hid/bpf/progs/Thrustmaster__TCA-Yoke-Boeing.bpf.c b/drivers/hid/bpf/progs/Thrustmaster__TCA-Yoke-Boeing.bpf.c
new file mode 100644
index 000000000000..ecf775a99346
--- /dev/null
+++ b/drivers/hid/bpf/progs/Thrustmaster__TCA-Yoke-Boeing.bpf.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Kumar Swarnam Iyer (kumar.s.iyer65@gmail.com)
+ */
+
+#include "vmlinux.h"
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include <bpf/bpf_tracing.h>
+
+#define VID_THRUSTMASTER 0x044F
+#define PID_TCA_YOKE_BOEING 0x0409
+
+HID_BPF_CONFIG(
+	HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, VID_THRUSTMASTER, PID_TCA_YOKE_BOEING)
+);
+
+/*  The original HID descriptor of the Thrustmaster TCA Yoke Boeing joystick contains
+ *  an Input field that shows up as an axis, ABS_MISC in Linux. But it is not possible
+ *  to assign an actual physical control to this axis as they're all taken up. There
+ *  are 2 vendor-defined inputs where the Input type appears to be defined wrongly.
+ *  This bpf attempts to fix this by changing the Inputs so that it doesn't show up in
+ *  Linux at all.
+ *  This version is the short version fix that only changes 2 fields in the descriptor
+ *  instead of the whole report descriptor.
+ *  For reference, this is the original report descriptor:
+ *
+ *  0x05, 0x01,                    // Usage Page (Generic Desktop)        0
+ *  0x09, 0x04,                    // Usage (Joystick)                    2
+ *  0xa1, 0x01,                    // Collection (Application)            4
+ *  0x85, 0x01,                    //  Report ID (1)                      6
+ *  0x09, 0x39,                    //  Usage (Hat switch)                 8
+ *  0x15, 0x00,                    //  Logical Minimum (0)                10
+ *  0x25, 0x07,                    //  Logical Maximum (7)                12
+ *  0x35, 0x00,                    //  Physical Minimum (0)               14
+ *  0x46, 0x3b, 0x01,              //  Physical Maximum (315)             16
+ *  0x65, 0x14,                    //  Unit (EnglishRotation: deg)        19
+ *  0x75, 0x04,                    //  Report Size (4)                    21
+ *  0x95, 0x01,                    //  Report Count (1)                   23
+ *  0x81, 0x42,                    //  Input (Data,Var,Abs,Null)          25
+ *  0x65, 0x00,                    //  Unit (None)                        27
+ *  0x05, 0x09,                    //  Usage Page (Button)                29
+ *  0x19, 0x01,                    //  Usage Minimum (1)                  31
+ *  0x29, 0x12,                    //  Usage Maximum (18)                 33
+ *  0x15, 0x00,                    //  Logical Minimum (0)                35
+ *  0x25, 0x01,                    //  Logical Maximum (1)                37
+ *  0x75, 0x01,                    //  Report Size (1)                    39
+ *  0x95, 0x12,                    //  Report Count (18)                  41
+ *  0x81, 0x02,                    //  Input (Data,Var,Abs)               43
+ *  0x95, 0x02,                    //  Report Count (2)                   45
+ *  0x81, 0x03,                    //  Input (Cnst,Var,Abs)               47
+ *  0x05, 0x01,                    //  Usage Page (Generic Desktop)       49
+ *  0x09, 0x31,                    //  Usage (Y)                          51
+ *  0x09, 0x30,                    //  Usage (X)                          53
+ *  0x09, 0x32,                    //  Usage (Z)                          55
+ *  0x09, 0x34,                    //  Usage (Ry)                         57
+ *  0x09, 0x33,                    //  Usage (Rx)                         59
+ *  0x09, 0x35,                    //  Usage (Rz)                         61
+ *  0x15, 0x00,                    //  Logical Minimum (0)                63
+ *  0x27, 0xff, 0xff, 0x00, 0x00,  //  Logical Maximum (65535)            65
+ *  0x75, 0x10,                    //  Report Size (16)                   70
+ *  0x95, 0x06,                    //  Report Count (6)                   72
+ *  0x81, 0x02,                    //  Input (Data,Var,Abs)               74
+ *  0x06, 0xf0, 0xff,              //  Usage Page (Vendor Usage Page 0xfff0) 76
+ *  0x09, 0x59,                    //  Usage (Vendor Usage 0x59)          79
+ *  0x15, 0x00,                    //  Logical Minimum (0)                81
+ *  0x26, 0xff, 0x00,              //  Logical Maximum (255)              83
+ *  0x75, 0x08,                    //  Report Size (8)                    86
+ *  0x95, 0x01,                    //  Report Count (1)                   88
+ *  0x81, 0x02,                    //  Input (Data,Var,Abs)               90 --> Needs to be changed
+ *  0x09, 0x51,                    //  Usage (Vendor Usage 0x51)          92
+ *  0x15, 0x00,                    //  Logical Minimum (0)                94
+ *  0x26, 0xff, 0x00,              //  Logical Maximum (255)              96
+ *  0x75, 0x08,                    //  Report Size (8)                    99
+ *  0x95, 0x20,                    //  Report Count (32)                  101 --> Needs to be changed
+ *  0x81, 0x02,                    //  Input (Data,Var,Abs)               103
+ *  0x09, 0x50,                    //  Usage (Vendor Usage 0x50)          105
+ *  0x15, 0x00,                    //  Logical Minimum (0)                107
+ *  0x26, 0xff, 0x00,              //  Logical Maximum (255)              109
+ *  0x75, 0x08,                    //  Report Size (8)                    112
+ *  0x95, 0x0f,                    //  Report Count (15)                  114
+ *  0x81, 0x03,                    //  Input (Cnst,Var,Abs)               116
+ *  0x09, 0x47,                    //  Usage (Vendor Usage 0x47)          118
+ *  0x85, 0xf2,                    //  Report ID (242)                    120
+ *  0x15, 0x00,                    //  Logical Minimum (0)                122
+ *  0x26, 0xff, 0x00,              //  Logical Maximum (255)              124
+ *  0x75, 0x08,                    //  Report Size (8)                    127
+ *  0x95, 0x3f,                    //  Report Count (63)                  129
+ *  0xb1, 0x02,                    //  Feature (Data,Var,Abs)             131
+ *  0x09, 0x48,                    //  Usage (Vendor Usage 0x48)          133
+ *  0x85, 0xf3,                    //  Report ID (243)                    135
+ *  0x15, 0x00,                    //  Logical Minimum (0)                137
+ *  0x26, 0xff, 0x00,              //  Logical Maximum (255)              139
+ *  0x75, 0x08,                    //  Report Size (8)                    142
+ *  0x95, 0x3f,                    //  Report Count (63)                  144
+ *  0xb1, 0x02,                    //  Feature (Data,Var,Abs)             146
+ *  0xc0,                          // End Collection                      148
+ */
+
+SEC(HID_BPF_RDESC_FIXUP)
+int BPF_PROG(hid_fix_rdesc_tca_yoke, struct hid_bpf_ctx *hctx)
+{
+	const int expected_length = 148;
+
+	if (hctx->size != expected_length)
+		return 0;
+
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, HID_MAX_DESCRIPTOR_SIZE /* size */);
+
+	if (!data)
+		return 0; /* EPERM */
+
+	/* Safety check, our probe() should take care of this though */
+	if (data[1] != 0x01 /* Generic Desktop */ || data[3] != 0x04 /* Joystick */)
+		return 0;
+
+	/* The report descriptor sets incorrect Input items in 2 places, resulting in a
+	 * non-existing axis showing up.
+	 * This change sets the correct Input which prevents the axis from showing up in Linux.
+	 */
+
+	if (data[90] == 0x81 && /* Input */
+	    data[103] == 0x81) { /* Input */
+		data[91] = 0x03; /* Input set to 0x03 Constant, Variable Absolute */
+		data[104] = 0x03; /* Input set to 0X03 Constant, Variable Absolute */
+	}
+
+	return 0;
+}
+
+HID_BPF_OPS(tca_yoke) = {
+	.hid_rdesc_fixup = (void *)hid_fix_rdesc_tca_yoke,
+};
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	/* ensure the kernel isn't fixed already */
+	if (ctx->rdesc[91] != 0x02) /* Input for 0x59 Usage type has changed */
+		ctx->retval = -EINVAL;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.44.0


