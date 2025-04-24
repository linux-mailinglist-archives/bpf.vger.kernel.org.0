Return-Path: <bpf+bounces-56564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39879A99CFA
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 02:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A81F462ABA
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 00:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5B8E545;
	Thu, 24 Apr 2025 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gi9Jco+a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AD7081F
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 00:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454499; cv=none; b=RCeIUaCFTES2o0kO9i2dgsbgQoGn+EGque7/S+XFs5bl6YAMf9JmEJAE7UBnn7MLSNBgpX9jvNx40fHL1Y8w2owKY6oCE1OAo5IF+JWWiRauWKUE8Woy4mULD1aqYsymDObdvLG1smxGzHpd1xQY2sRpwT0QNXPo28ocELXwNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454499; c=relaxed/simple;
	bh=CC5P9PlTFOFYmpGkh+AgeMpeAfxK9NmmEpB4vEaUjMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRbjkHIBEiWCYiTxL5P8P/5oTyW7lPRWQfJnRV9a4mGozS6ZPuf+ACUSQ+qSuETqJ/4WLlDgJKR9QgE3VGn8yh7kPq5Yj/VRYu56JxynLm29SPJtBcStqxkpMLIeT+ZDyLY1duqhSOOfRbsEMtnDXQYYJlJ67XakoMnxt/368zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gi9Jco+a; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b12b984e791so320873a12.2
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745454497; x=1746059297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0pZyEyvgBt8oFD4ZrZQFJhXNyLvOB+O0xQ+Wcll9kk=;
        b=gi9Jco+aEqNtbuyDmscJmg9o5IK/DK1zy6puezcbPjsbBSPJKI+Meuy8cuotwPLx5Y
         UIPLcYZuj5PdAU25UiZdjQ1pKX6lzWIHfjAbLI6W8esUbXsxGM6o32Mh1dH9yWRhSZmZ
         aQZSpBl49lHIJz+HRB3PB3KFttNvWiZCkfEpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745454497; x=1746059297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0pZyEyvgBt8oFD4ZrZQFJhXNyLvOB+O0xQ+Wcll9kk=;
        b=bE8R+oCus+uDoUZSfA86w6B1oWTiPX5yiP6RugZsrXevofju0QqDlxdtcjgCw+DWAX
         70WdaedunKBrPjYBxdbu9u79YTDKSmRNde+Jd2y0CP6/HO7nCTEBSKsFU5wrtmmTs9Kc
         1NAcHFN3mb9FdoId1/6B8ZSTp8WvX0T3g/RyQ0iT9reaTTjXlalvGB1Zye1PGmC0mQVX
         3q3apPCD0B/hIaUNmetAX1glxk3pUnuF6DNVmRmbbIGc+aEGtq9rI3GTYLE6xSH2k/P1
         HWw+7flsskYMV827dLoAOGkWQQZaOo35eEXsahA4W4puumUwwhywSU9xRmGzsSkScwEk
         BYjw==
X-Forwarded-Encrypted: i=1; AJvYcCWnIGTJmsDBS1sKJmwR0sOCw5k8UWd7ArJiRoYxemnWhAY3Y4QfihQvPIP5gWzyIiTp5Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIs9pIT6bEfPvogk7MNDvzZ9gdP6qdWfFTY9ZqQv8HNbF0ISr
	ilP032A6Knx1L1qKO1QfszpXlGM+279UD/Te6A6nx8/dwTZ0ivm2J3Jzxc0XCH8=
X-Gm-Gg: ASbGncu6t8KOEOBFzUDsGl54DridpqF3kKyotdFG1GexpgPRH98mifIUkCTQDZA05n5
	KdN/nIeqSvQPyxz7AvYCaBoYEjkyE/e9EIzmeROFScwIdudTKTdtU4fxx1FuNmr+lV0TOD+UA8D
	J4lY9bKm5P/7ANtftT37g8if/NbXLe8lkX/99ZzuSa4qQWYFglPHsWB7VwHz6ujAH8XOX+rzLB4
	RSobkMhYaKyqXeMlDBFaxtHhaJYjWUR2ubzajPmVEVWBTnZfQnxlspPZun+whSVQ4xcq9INfYqv
	eJ/GLPuX1LoUEZMgrzNDfAUDTRvTJLji44lRsSpthhPIeESJ
X-Google-Smtp-Source: AGHT+IEAmg0XR+f+4dbbuaII7I/1Nj1o8g+oD7f7K+/8qFPWxrVWr1FeBq7fThzkgJQPYmfowLY1oQ==
X-Received: by 2002:a17:90a:f945:b0:2f6:be57:49d2 with SMTP id 98e67ed59e1d1-309ed29c8d8mr1097904a91.17.1745454497172;
        Wed, 23 Apr 2025 17:28:17 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ee7c4054sm83013a91.23.2025.04.23.17.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:28:16 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	shaw.leon@gmail.com,
	pabeni@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v4 2/3] selftests: drv-net: Factor out ksft C helpers
Date: Thu, 24 Apr 2025 00:27:32 +0000
Message-ID: <20250424002746.16891-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424002746.16891-1-jdamato@fastly.com>
References: <20250424002746.16891-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor ksft C helpers to a header so they can be used by other C-based
tests.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +---------------
 2 files changed, 58 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h

diff --git a/tools/testing/selftests/drivers/net/ksft.h b/tools/testing/selftests/drivers/net/ksft.h
new file mode 100644
index 000000000000..c30a02da903f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ksft.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(__NET_KSFT_H__)
+#define __NET_KSFT_H__
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static void ksft_ready(void)
+{
+	const char msg[7] = "ready\n";
+	char *env_str;
+	int fd;
+
+	env_str = getenv("KSFT_READY_FD");
+	if (env_str) {
+		fd = atoi(env_str);
+		if (!fd) {
+			fprintf(stderr, "invalid KSFT_READY_FD = '%s'\n",
+				env_str);
+			return;
+		}
+	} else {
+		fd = STDOUT_FILENO;
+	}
+
+	write(fd, msg, sizeof(msg));
+	if (fd != STDOUT_FILENO)
+		close(fd);
+}
+
+static void ksft_wait(void)
+{
+	char *env_str;
+	char byte;
+	int fd;
+
+	env_str = getenv("KSFT_WAIT_FD");
+	if (env_str) {
+		fd = atoi(env_str);
+		if (!fd) {
+			fprintf(stderr, "invalid KSFT_WAIT_FD = '%s'\n",
+				env_str);
+			return;
+		}
+	} else {
+		/* Not running in KSFT env, wait for input from STDIN instead */
+		fd = STDIN_FILENO;
+	}
+
+	read(fd, &byte, sizeof(byte));
+	if (fd != STDIN_FILENO)
+		close(fd);
+}
+
+#endif
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
index aeed25914104..d5bb8ac33efa 100644
--- a/tools/testing/selftests/drivers/net/xdp_helper.c
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -11,56 +11,11 @@
 #include <net/if.h>
 #include <inttypes.h>
 
+#include "ksft.h"
+
 #define UMEM_SZ (1U << 16)
 #define NUM_DESC (UMEM_SZ / 2048)
 
-/* Move this to a common header when reused! */
-static void ksft_ready(void)
-{
-	const char msg[7] = "ready\n";
-	char *env_str;
-	int fd;
-
-	env_str = getenv("KSFT_READY_FD");
-	if (env_str) {
-		fd = atoi(env_str);
-		if (!fd) {
-			fprintf(stderr, "invalid KSFT_READY_FD = '%s'\n",
-				env_str);
-			return;
-		}
-	} else {
-		fd = STDOUT_FILENO;
-	}
-
-	write(fd, msg, sizeof(msg));
-	if (fd != STDOUT_FILENO)
-		close(fd);
-}
-
-static void ksft_wait(void)
-{
-	char *env_str;
-	char byte;
-	int fd;
-
-	env_str = getenv("KSFT_WAIT_FD");
-	if (env_str) {
-		fd = atoi(env_str);
-		if (!fd) {
-			fprintf(stderr, "invalid KSFT_WAIT_FD = '%s'\n",
-				env_str);
-			return;
-		}
-	} else {
-		/* Not running in KSFT env, wait for input from STDIN instead */
-		fd = STDIN_FILENO;
-	}
-
-	read(fd, &byte, sizeof(byte));
-	if (fd != STDIN_FILENO)
-		close(fd);
-}
 
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
-- 
2.43.0


