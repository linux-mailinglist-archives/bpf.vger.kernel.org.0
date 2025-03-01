Return-Path: <bpf+bounces-52964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00DA4ABBB
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5076A1895688
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A01E25E8;
	Sat,  1 Mar 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udp6PF9O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2881E0DEB;
	Sat,  1 Mar 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839128; cv=none; b=paA+xThdKQ+OhIt/BY1JvDcnA9tZmR/1MdFwZDDSqHm7c/ci3CzhWa7Vgpq7bZnhwCK2kOfCT4olCXzOTkTPvYzlOuUzjlJufAN2Ak0oZSkDYpTATSGzOJ/j0sAPaU9lIWJDofhby0hUABKs4NOdJEPr2kvLfZyQjGAStBQMn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839128; c=relaxed/simple;
	bh=ba2kUP6U2nQhwPc/YT5wm25vzRDR53W9pxGrlJ+24E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwPQu8U12uYNRyu9E20Ax1nYFnRRmO0Y/7/C03KXd71K5slr3OVjtsqzYnXbuHww2TNVrqk1GbvKyHcdnASvzEwZuzHOtaHJfvMGgym5KDj/SAy+Ao6bKPthTv/Q4CsVCjFT6fhoggzwMIgXn3cMkuo/pbhMLBj+Fwwy8Y00JdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udp6PF9O; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22374f56453so33955975ad.0;
        Sat, 01 Mar 2025 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839126; x=1741443926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXn6GKhF5PCrQUxpPI6cKx6cLS6wqLkAI6AcaLhK77k=;
        b=Udp6PF9OBFT4BFNijpgFvxxM/4YjjDk1D3/aVSTk8BKAg83UKEU403QZO/GWUu0LIZ
         FklY35ZaS3TkjZpYoVpL90hXLGJbwRnt9ooSlC4NI7HT4SMJouK+zWPMCBgQ8ZK9nxj2
         66LwRxzPcnSxQn66srJxzqbzY0mhGApR02ZXPJBp8odLLVk4rp5y/++4sE44OxkYkW46
         P1AHzseNS/xxxOnJlS4HaYsB9bFg2g1UXJmzmUsUeCwW4C3x2IZhiss7dfpdYctJOEez
         qhITyWBBpka2ItJU80U4M1zHxKhubgX6O2GmU5JBANjM01VkonaHjYvdwLnWmlm/ovEr
         2SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839126; x=1741443926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXn6GKhF5PCrQUxpPI6cKx6cLS6wqLkAI6AcaLhK77k=;
        b=h2w9mUoeNEQuXRsn2MIlrOi01lh1B5qfHcQ2jr8B1f3VlBNbxuF7VJbpqH+B3H71Ya
         kcJpzFH58pRRssoRYneittz7hbcBl2HmcrVpNIJPaU8II/R5dfmTIm0qIXIQC5JytBOi
         MibxiJnlZWwjcKweVHdlUtvKW7g4cbRRwiY/sM5I31lRNroLQrb0N6Q717YiY/gzNp5C
         g1fnY74pry2J5m+cVBpO/TYpI9a9zNqrNBzOXKyzSqpFmXBr/8nKB8+syMBIxssqrRu3
         Ocjq811i2C8EJRhtvV0QYPlmDRWGOzY3+8DXhoGVXv39qb60Yt2xjFwkSjeapqBvVBpP
         H2nA==
X-Forwarded-Encrypted: i=1; AJvYcCUOSNDYOcGjdx3hv046YnHhmSVKF8t25tDzbv168AoikVvZiXtnFURXWcFtWXUsea6zvIU=@vger.kernel.org, AJvYcCVA48pG0eQt5IRe6xiWTSk4m6DB6iPVHjxDpGuEz+D+9LVu0/E58ELK3qjaB1/rKxq1Ttt/9gRP8yvP9DepkOc=@vger.kernel.org, AJvYcCW2AJJVOVCe/JNt8r+nQ4KkQoI1eWK1PtAfenyMid/UAWcOy8GKHvGH3FbktAd+OGBHBPQhXx157wMCnXQ=@vger.kernel.org, AJvYcCWelHCpHxGo8jNZuEJw8ko2s+i6wOfNhbrzo1hlkw5PRqlv/83coRzoE9Gq5vhOnLe7tcD916e2Muclobao@vger.kernel.org, AJvYcCXESg+tl1nOp6QkkvtZrocbKkyoLe2Hgx7wobGabfShskSwOJllPefA7WvieoEF5W/wsdJLLwqV@vger.kernel.org, AJvYcCXFZE7HFd33tneczSLiYTGj0lTEF+6bNl11e6aqL3sQy3VN82+p9g1tc2Vf2dvFU3fOgSE/hTecDg945gI/@vger.kernel.org, AJvYcCXfyRf1dyMAggMocE0g4GFQe5crAvNSXboISqwX+9GXNeqOR/291VOM9+lD+SHDGrcvyre37CMnC68vBm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ITDaIDcFhG6stfcK24Ksi2beCeTbZVOOcIwmEXy17kUUhmGi
	lObUHdcL7erw2RRjXsidVt0eRPs3Uj/kJFnuLNpfP+BrLv6Xhwtp
X-Gm-Gg: ASbGnctwsndmh3eKYrEIHv+w3EADDf77BIea+NVr2BSzBfbRxa3x8xb2HE/7brK28ec
	fzPWZgHZ71WXJoMtqZkZsctS3UlYpLqp6E2Bc0S0NXhYRjoaX69IyiWeKKkfKB9t1GKe3TlG105
	dBApKu9f+v2luYAwJ9JjkRAUC3XOElN2ZhNrhZ8Uv1OPyqHiBPPZxhA/sHMDufIB14VugYMn69c
	uboFURWvD5wRHzX5HeCGSFSMH17zMSHlmJg/Xtl5jfFFBheqFJMgGSCdDyTDGFa+RotPPLBtDLl
	m2JQmLcHCNemHSRoKw28wT9SHpmsjGLmqhuxPw7QgL2xRqBO+jOGQbIHdmmYioGYP4f6ZJdrE1g
	=
X-Google-Smtp-Source: AGHT+IF5pURPLoHQQUwY6iobOMXaj/n4QtZUV4ZbycQ+e8lZRNMONMXX28RkgoVRrFQeanZPW34ebQ==
X-Received: by 2002:a17:903:2346:b0:223:635d:3e38 with SMTP id d9443c01a7336-22368fa24bemr111392555ad.15.1740839125810;
        Sat, 01 Mar 2025 06:25:25 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa8f1sm49231965ad.90.2025.03.01.06.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:25:25 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	jk@ozlabs.org,
	joel@jms.id.au,
	eajames@linux.ibm.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dmitry.torokhov@gmail.com,
	mchehab@kernel.org,
	awalls@md.metrocast.net,
	hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	louis.peens@corigine.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	parthiban.veerasooran@microchip.com,
	arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	yury.norov@gmail.com,
	akpm@linux-foundation.org
Cc: hpa@zytor.com,
	alistair@popple.id.au,
	linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-serial@vger.kernel.org,
	bpf@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	david.laight.linux@gmail.com,
	andrew.cooper3@citrix.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH v2 01/18] lib/parity: Add __builtin_parity() fallback implementations
Date: Sat,  1 Mar 2025 22:23:52 +0800
Message-Id: <20250301142409.2513835-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301142409.2513835-1-visitorckw@gmail.com>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic C implementations of __paritysi2(), __paritydi2(), and
__parityti2() as fallback functions in lib/parity.c. These functions
compute the parity of a given integer using a bitwise approach and are
marked with __weak, allowing architecture-specific implementations to
override them.

This patch serves as preparation for using __builtin_parity() by
ensuring a fallback mechanism is available when the compiler does not
inline the __builtin_parity().

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/Makefile |  2 +-
 lib/parity.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 lib/parity.c

diff --git a/lib/Makefile b/lib/Makefile
index 7bab71e59019..45affad85ee4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -51,7 +51,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o bitmap-str.o
+	 generic-radix-tree.o bitmap-str.o parity.o
 obj-y += string_helpers.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
diff --git a/lib/parity.c b/lib/parity.c
new file mode 100644
index 000000000000..a83ff8d96778
--- /dev/null
+++ b/lib/parity.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * lib/parity.c
+ *
+ * Copyright (C) 2025 Kuan-Wei Chiu <visitorckw@gmail.com>
+ * Copyright (C) 2025 Yu-Chun Lin <eleanor15x@gmail.com>
+ *
+ * __parity[sdt]i2 can be overridden by linking arch-specific versions.
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+
+/*
+ * One explanation of this algorithm:
+ * https://funloop.org/codex/problem/parity/README.html
+ */
+int __weak __paritysi2(u32 val);
+int __weak __paritysi2(u32 val)
+{
+	val ^= val >> 16;
+	val ^= val >> 8;
+	val ^= val >> 4;
+	return (0x6996 >> (val & 0xf)) & 1;
+}
+EXPORT_SYMBOL(__paritysi2);
+
+int __weak __paritydi2(u64 val);
+int __weak __paritydi2(u64 val)
+{
+	val ^= val >> 32;
+	val ^= val >> 16;
+	val ^= val >> 8;
+	val ^= val >> 4;
+	return (0x6996 >> (val & 0xf)) & 1;
+}
+EXPORT_SYMBOL(__paritydi2);
+
+int __weak __parityti2(u64 val);
+int __weak __parityti2(u64 val)
+{
+	val ^= val >> 32;
+	val ^= val >> 16;
+	val ^= val >> 8;
+	val ^= val >> 4;
+	return (0x6996 >> (val & 0xf)) & 1;
+}
+EXPORT_SYMBOL(__parityti2);
-- 
2.34.1


