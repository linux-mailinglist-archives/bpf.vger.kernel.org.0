Return-Path: <bpf+bounces-48072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C869A03E9F
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321063A4608
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900401EF08A;
	Tue,  7 Jan 2025 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrq49oJc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03681EBFEB;
	Tue,  7 Jan 2025 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251695; cv=none; b=WYZkR4lK4+3rRuUnwx77vXy2UJ6AwOXZC1H274k30C2zF9DfTIyTNLiqqHkPIKzpUXKMxhqK3+gcNcfLpRi0LwJFjBWhxTGu/jWJN/9dPxAK7FOxzl6sZJdXa7spMuSSt07mldG2Csdd6+EOOCBbId1y6FFt3lTMFUc1ka/EZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251695; c=relaxed/simple;
	bh=KG3HsvC8HUhrbrbpUJE4bQxwMEjYH6YZtoy2sf9d6hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKra7Cq0eltZx7zQljR9l7AekuKq7uvmqxkThQzCE2b4r2tHKNVxFo3MBlyVDR50kZ5QyY2iJi9O0H95b5Ye0xAWOoFRXRipWfgsfbfb3CckeVvEcB3f9lXfbMGMTOZtOFrwUtWaM25/HMXKninePjDMOQK1hiGqlA6T4N1Isp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrq49oJc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216426b0865so220067045ad.0;
        Tue, 07 Jan 2025 04:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251687; x=1736856487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2izW7BlDss+VrFsciVNsJsfoPjzBbhAU1O27zuOZQk=;
        b=Lrq49oJcRes6RoG7uwzwskeGf+hIFmp0QgX4hiIMs8x2L2Sb8rmxLgBUeEohNq3l38
         iCQnkLwBP4IKi2vAmYQbP4TtGXDIS7PwkKaog4XSoBm4z91hAXL98Bgqoqp3/KilIjS1
         GR0gu15qqNpkkC8hz7ddkAa6Fd7e16SjZ6zsvmDf7Dy1IeeMX6StMdj4NMEoix0ZnpHy
         0uiXSIIifHTNBkj/WYsZzyrdLsaRRE/iS2W2olZaYOUcrl/lQH6tXL5y6IIF2mFBEBgq
         uZCvd1bkuydNxQ8EL8ntWyJNhr/JpTFzsOscqPTB68RDxzTMVwfRKg37NlCzAydw6FU2
         vVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251687; x=1736856487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2izW7BlDss+VrFsciVNsJsfoPjzBbhAU1O27zuOZQk=;
        b=p+C13c4dI4Fkbz7DNS3YUHf0EJsNiIJLVSFt1+di+RO9Z2HRCl5qkLFXZ0jaWiwZ3d
         12oXVBHmGv/PKy65ZVaU8IEmY978m1vrc7y8XRRD6e8J8ElhAOBnqAfgQsUMjCoUKYc8
         XWCE1JclWiOHG7N09FXairGpDkNLnyVy19XA4bC8wbtJIqeiJZksdVgEYYoDHwABTfZj
         ggcIPuCDmokKRYZSmsoXfVfbXLSaulC3PA+qjHy8wI47ODKMWK2/j/rch10ii8BtAWYp
         g0D+zoasofiJFyJ5XkgrLrqzSL3kBX7/tTj6CafVH5f2jppIQe5vh2/QXQ2oJCmsZTH6
         KPYw==
X-Forwarded-Encrypted: i=1; AJvYcCVHVNEmyKZxTmzjFQ4VV2WqEcSL0e641jYlNiPas7ue/cOaLp+SffrAZzrASpa4o+estKbYfKMegSLz0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Y9yBpxvwjb8V76QfrDUp77YEjBuZKDDU7RnqeIrLcOMugeEK
	hwCrqFlCGkkeTXhpNwT+e+m3SUB2AZO42jUJ5NdpnWCTa0rO+D1g4tfj5IcABYo=
X-Gm-Gg: ASbGncuMF9b5tET54KU+k74UhHdLIXoQ2YU1DB0BrnS/RnP3eMXC5XnehXkpTXO5TjD
	a1UtSIxSfyYTDy+J7YJ+DKjiPsSSX0tauPEBz7rDtSYedJFY9fRMeFv8eCHTrDBAKn8Bx9VhBkY
	vbgUS3/UDab5qWYJ770lqDzUedJNAqgc14NvA0Lb0+fE3hbabPTf3+faKx4Fj/ebnjjylIZhNzT
	Y8JYJibWl8L6+NJZDcpx575Cp5IS1+7MfJO3qvHJsC/5kL9jTc2B+r8fBr6Us2frTa+
X-Google-Smtp-Source: AGHT+IEnnJB14dmBBtCUVZUo7FwFnSPPUoxdpWvs9jXkgkA2nLE2vDwuDDtcGJUwu67g5cwPgpB16w==
X-Received: by 2002:a05:6a20:e68c:b0:1e0:d380:fe66 with SMTP id adf61e73a8af0-1e5dfb408camr88880445637.0.1736251686998;
        Tue, 07 Jan 2025 04:08:06 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:06 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 04/22] ublk: move ublk into one standalone directory
Date: Tue,  7 Jan 2025 20:03:55 +0800
Message-ID: <20250107120417.1237392-5-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250107120417.1237392-1-tom.leiming@gmail.com>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for supporting ublk-bpf, which has to add more source files, so
create ublk/ for avoiding to pollute drivers/block/

Meantime rename the source file as ublk/main.c

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 MAINTAINERS                               |  2 +-
 drivers/block/Kconfig                     | 32 +-------------------
 drivers/block/Makefile                    |  2 +-
 drivers/block/ublk/Kconfig                | 36 +++++++++++++++++++++++
 drivers/block/ublk/Makefile               |  7 +++++
 drivers/block/{ublk_drv.c => ublk/main.c} |  0
 6 files changed, 46 insertions(+), 33 deletions(-)
 create mode 100644 drivers/block/ublk/Kconfig
 create mode 100644 drivers/block/ublk/Makefile
 rename drivers/block/{ublk_drv.c => ublk/main.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c575de4903db..890f6195d03f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23982,7 +23982,7 @@ M:	Ming Lei <ming.lei@redhat.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	Documentation/block/ublk.rst
-F:	drivers/block/ublk_drv.c
+F:	drivers/block/ublk/
 F:	include/uapi/linux/ublk_cmd.h
 
 UBSAN
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index a97f2c40c640..4e5144183ade 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -379,37 +379,7 @@ config BLK_DEV_RBD
 
 	  If unsure, say N.
 
-config BLK_DEV_UBLK
-	tristate "Userspace block driver (Experimental)"
-	select IO_URING
-	help
-	  io_uring based userspace block driver. Together with ublk server, ublk
-	  has been working well, but interface with userspace or command data
-	  definition isn't finalized yet, and might change according to future
-	  requirement, so mark is as experimental now.
-
-	  Say Y if you want to get better performance because task_work_add()
-	  can be used in IO path for replacing io_uring cmd, which will become
-	  shared between IO tasks and ubq daemon, meantime task_work_add() can
-	  can handle batch more effectively, but task_work_add() isn't exported
-	  for module, so ublk has to be built to kernel.
-
-config BLKDEV_UBLK_LEGACY_OPCODES
-	bool "Support legacy command opcode"
-	depends on BLK_DEV_UBLK
-	default y
-	help
-	  ublk driver started to take plain command encoding, which turns out
-	  one bad way. The traditional ioctl command opcode encodes more
-	  info and basically defines each code uniquely, so opcode conflict
-	  is avoided, and driver can handle wrong command easily, meantime it
-	  may help security subsystem to audit io_uring command.
-
-	  Say Y if your application still uses legacy command opcode.
-
-	  Say N if you don't want to support legacy command opcode. It is
-	  suggested to enable N if your application(ublk server) switches to
-	  ioctl command encoding.
+source "drivers/block/ublk/Kconfig"
 
 source "drivers/block/rnbd/Kconfig"
 
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 1105a2d4fdcb..a6fdc62b817c 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -40,6 +40,6 @@ obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
-obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
+obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk/
 
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/ublk/Kconfig b/drivers/block/ublk/Kconfig
new file mode 100644
index 000000000000..b06e3df09779
--- /dev/null
+++ b/drivers/block/ublk/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# ublkl block device driver configuration
+#
+
+config BLK_DEV_UBLK
+	tristate "Userspace block driver (Experimental)"
+	select IO_URING
+	help
+	  io_uring based userspace block driver. Together with ublk server, ublk
+	  has been working well, but interface with userspace or command data
+	  definition isn't finalized yet, and might change according to future
+	  requirement, so mark is as experimental now.
+
+	  Say Y if you want to get better performance because task_work_add()
+	  can be used in IO path for replacing io_uring cmd, which will become
+	  shared between IO tasks and ubq daemon, meantime task_work_add() can
+	  can handle batch more effectively, but task_work_add() isn't exported
+	  for module, so ublk has to be built to kernel.
+
+config BLKDEV_UBLK_LEGACY_OPCODES
+	bool "Support legacy command opcode"
+	depends on BLK_DEV_UBLK
+	default y
+	help
+	  ublk driver started to take plain command encoding, which turns out
+	  one bad way. The traditional ioctl command opcode encodes more
+	  info and basically defines each code uniquely, so opcode conflict
+	  is avoided, and driver can handle wrong command easily, meantime it
+	  may help security subsystem to audit io_uring command.
+
+	  Say Y if your application still uses legacy command opcode.
+
+	  Say N if you don't want to support legacy command opcode. It is
+	  suggested to enable N if your application(ublk server) switches to
+	  ioctl command encoding.
diff --git a/drivers/block/ublk/Makefile b/drivers/block/ublk/Makefile
new file mode 100644
index 000000000000..30e06b74dd82
--- /dev/null
+++ b/drivers/block/ublk/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# needed for trace events
+ccflags-y			+= -I$(src)
+
+ublk_drv-$(CONFIG_BLK_DEV_UBLK)	:= main.o
+obj-$(CONFIG_BLK_DEV_UBLK)	+= ublk_drv.o
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk/main.c
similarity index 100%
rename from drivers/block/ublk_drv.c
rename to drivers/block/ublk/main.c
-- 
2.47.0


