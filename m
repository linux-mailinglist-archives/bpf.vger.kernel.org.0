Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B89E23FA8D
	for <lists+bpf@lfdr.de>; Sun,  9 Aug 2020 01:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHHXjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Aug 2020 19:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgHHXjf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Aug 2020 19:39:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15B52073E;
        Sat,  8 Aug 2020 23:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929974;
        bh=cjtdBc3RixVqwCdUJQihsAUyE8l5VSflaCE6otsLWuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTMKQpRFU5o2oVXu2H0JhjO2+iopwE+VJWgOGVKAaTKxAJ56JvcdM9lBVmSwIJdFr
         IWUCnN/HIIVjxV94WHjzL45k4lkgJ+7Yqf9o/XeuHFluDJjVS/M1zWExg3Pnph4DF8
         QrpwSAstKW7PrlQzoUkd0GR8hjz/GG+Ie/33BP6k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 35/40] seccomp: Fix ioctl number for SECCOMP_IOCTL_NOTIF_ID_VALID
Date:   Sat,  8 Aug 2020 19:38:39 -0400
Message-Id: <20200808233844.3618823-35-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233844.3618823-1-sashal@kernel.org>
References: <20200808233844.3618823-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 47e33c05f9f07cac3de833e531bcac9ae052c7ca ]

When SECCOMP_IOCTL_NOTIF_ID_VALID was first introduced it had the wrong
direction flag set. While this isn't a big deal as nothing currently
enforces these bits in the kernel, it should be defined correctly. Fix
the define and provide support for the old command until it is no longer
needed for backward compatibility.

Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/seccomp.h                  | 3 ++-
 kernel/seccomp.c                              | 9 +++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 90734aa5aa363..b5f901af79f0b 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -93,5 +93,6 @@ struct seccomp_notif_resp {
 #define SECCOMP_IOCTL_NOTIF_RECV	SECCOMP_IOWR(0, struct seccomp_notif)
 #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
 						struct seccomp_notif_resp)
-#define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
+#define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOW(2, __u64)
+
 #endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 2c697ce7be21f..e0fd972356539 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -42,6 +42,14 @@
 #include <linux/uaccess.h>
 #include <linux/anon_inodes.h>
 
+/*
+ * When SECCOMP_IOCTL_NOTIF_ID_VALID was first introduced, it had the
+ * wrong direction flag in the ioctl number. This is the broken one,
+ * which the kernel needs to keep supporting until all userspaces stop
+ * using the wrong command number.
+ */
+#define SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR	SECCOMP_IOR(2, __u64)
+
 enum notify_state {
 	SECCOMP_NOTIFY_INIT,
 	SECCOMP_NOTIFY_SENT,
@@ -1168,6 +1176,7 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 		return seccomp_notify_recv(filter, buf);
 	case SECCOMP_IOCTL_NOTIF_SEND:
 		return seccomp_notify_send(filter, buf);
+	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
 	case SECCOMP_IOCTL_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, buf);
 	default:
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 96bbda4f10fc6..19c7351eeb74b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -177,7 +177,7 @@ struct seccomp_metadata {
 #define SECCOMP_IOCTL_NOTIF_RECV	SECCOMP_IOWR(0, struct seccomp_notif)
 #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
 						struct seccomp_notif_resp)
-#define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
+#define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOW(2, __u64)
 
 struct seccomp_notif {
 	__u64 id;
-- 
2.25.1

