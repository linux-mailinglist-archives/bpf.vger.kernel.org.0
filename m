Return-Path: <bpf+bounces-44614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 722DE9C586C
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 13:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893EDB3BCE9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D1213EF0;
	Tue, 12 Nov 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6Uqjfh6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC9213125
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409770; cv=none; b=X5r8UrZpCE9dH6VML1D/wW6zZ96yWo6Tel2Xc9JfQpomb10J7pWKDjoad8pb60PMvk1LC41NYiFnaEo4b6SntWgzWc5QcKI69QSQRxSFAWZDzg/F2SCAdl4aAZz2xRa5/3VCE5ZZLd/q+rx87nkUof3arxlImx0Bcy8Q0hwMLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409770; c=relaxed/simple;
	bh=4oZ0Fb/3Gvl9wYrbwx6xGDbjYJ3uyaY8dPZkefpr8z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yg0txyMAXBDLwIEqSPXmn3+sal/Ysr7HV/FJEBkFeYNTwmLzGpmkUyantmmMuP1D6EwdLZBgUuU+woZcH90tOMq7oVkhpZpm8XWd3U+o8Tn/oJtQHojTJ6y3J3Car0MA0wnNi5Dw6RO2BvUheU4kakhPLml+wzuekCYTMGXUAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6Uqjfh6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-211a4682fcaso12208915ad.2
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 03:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731409768; x=1732014568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWgwsdZ5ATw7w3LmjmIMGPEKMBsYBLsMaihOkWXYU+U=;
        b=c6Uqjfh65tczvQHSgYffnGztwhRVxfKXv/SeWdB/EdQdXsKODpv0lgDQFL/l2tRDXj
         1rYrM08awuWjG2+XYYdn/yf1kINOTpzn6tXaUEbErOCfaJ6PxlweudXts7ro4Kg7+H4A
         yKocOcs/krob1oBnko8JfV4fxuZCgjk8IgsGCQd2us9dhyEm4XfGBPTZxZved3Mj0QqP
         smUCunhBWmPfD0g0t+kl80ywoe6vKOpyuFRLk2gW2ZFtPmVxZGHmB5uWbEIUmgJpenUX
         3EU5+C/3VYL8WB5lb7jzK/9Zd7chmLnAQh3Upc8JcVhAk3C4ia2yQXyebc1+jEHuzP4w
         Qa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409768; x=1732014568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWgwsdZ5ATw7w3LmjmIMGPEKMBsYBLsMaihOkWXYU+U=;
        b=wvcIEdHl1kojN3jdsktIb66G3NR+H72woVSlUiZCurd9AmvxwwewFsfV5RgXH74iUG
         v4dRAS5ky8OKb404T8fysgdPyOWZo/565CsL9o2uEyvI3cbyfXiM9aWXx5w3Ifv7pxKX
         olUjnWNZcDh8hxSH1zWq//WGlX2nzF3BO8YpkH8eJq0aBRGYMWHy3I0ZOVvfzbTkwafP
         EyyboqDdDWSUlQpyEYJqvEl/mEz2S8M4H8GD0kNNkTUHwxavoWY+D9fc0/2JcVPKJ7NH
         5t7D+BAHWjLA6wpQiYPySeD3NwWSPYaceYPs9QQlVPV8MnNR6lhV8PmKveLQ6Z5vvtvh
         8n9g==
X-Gm-Message-State: AOJu0YyqGJysx4Az/DaCzYUks8iBaT6jbGn/DSYwumT6DuNkk/aZ8s9S
	JlVxIPBXRWm8HQ5qIE6o5IeXiqvhX7aWiGomNka8MJ0jsO9+bHzsmoa7Vg==
X-Google-Smtp-Source: AGHT+IGlPRVoVQ96upJX+wZY6hhrhgFyXDEPoilKP2ZZhpD/DyXcP0oIYBP47Q+WMLmD/Do2BWpIZw==
X-Received: by 2002:a17:902:ecc6:b0:20b:8776:4902 with SMTP id d9443c01a7336-2118359cd7bmr213261895ad.38.1731409767569;
        Tue, 12 Nov 2024 03:09:27 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e45eabsm91789135ad.114.2024.11.12.03.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:09:26 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next 2/4] selftests/bpf: add read_with_timeout() utility function
Date: Tue, 12 Nov 2024 03:09:04 -0800
Message-ID: <20241112110906.3045278-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112110906.3045278-1-eddyz87@gmail.com>
References: <20241112110906.3045278-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

int read_with_timeout(int fd, char *buf, size_t count, long usec)

As a regular read(2), but allows to specify a timeout in
micro-seconds. Returns -EAGAIN on timeout.
Implemented using select().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile     |  1 +
 tools/testing/selftests/bpf/io_helpers.c | 21 +++++++++++++++++++++
 tools/testing/selftests/bpf/io_helpers.h |  7 +++++++
 3 files changed, 29 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/io_helpers.c
 create mode 100644 tools/testing/selftests/bpf/io_helpers.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edef5df08cb2..b1080284522d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -742,6 +742,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 unpriv_helpers.c 	\
 			 netlink_helpers.c	\
 			 jit_disasm_helpers.c	\
+			 io_helpers.c		\
 			 test_loader.c		\
 			 xsk.c			\
 			 disasm.c		\
diff --git a/tools/testing/selftests/bpf/io_helpers.c b/tools/testing/selftests/bpf/io_helpers.c
new file mode 100644
index 000000000000..4ada0a74aa1f
--- /dev/null
+++ b/tools/testing/selftests/bpf/io_helpers.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/select.h>
+#include <unistd.h>
+#include <errno.h>
+
+int read_with_timeout(int fd, char *buf, size_t count, long usec)
+{
+	const long M = 1000 * 1000;
+	struct timeval tv = { usec / M, usec % M };
+	fd_set fds;
+	int err;
+
+	FD_ZERO(&fds);
+	FD_SET(fd, &fds);
+	err = select(fd + 1, &fds, NULL, NULL, &tv);
+	if (err < 0)
+		return err;
+	if (FD_ISSET(fd, &fds))
+		return read(fd, buf, count);
+	return -EAGAIN;
+}
diff --git a/tools/testing/selftests/bpf/io_helpers.h b/tools/testing/selftests/bpf/io_helpers.h
new file mode 100644
index 000000000000..21e1134cd3ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/io_helpers.h
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+
+/* As a regular read(2), but allows to specify a timeout in micro-seconds.
+ * Returns -EAGAIN on timeout.
+ */
+int read_with_timeout(int fd, char *buf, size_t count, long usec);
-- 
2.47.0


