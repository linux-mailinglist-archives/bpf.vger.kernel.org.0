Return-Path: <bpf+bounces-56671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D1A9BF6C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143F09A4E84
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFBD233701;
	Fri, 25 Apr 2025 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSE5Wk7g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FA231A55;
	Fri, 25 Apr 2025 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565119; cv=none; b=fy9baytJ4eSnFGgqwFG+RsY0i7G1x2nXROEEJFFhphH/Z3q9BEOHriNK/gvjhaul424jWVfMI9/jQkJYvmO2YBk0qQl4B0bBc7Stt5nLg3oOXy83vriCzA46pMjXBcbT5ZDRXokvoqPZ4nB4OlLN/m6LhB4ye3T5AlDo/sWy50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565119; c=relaxed/simple;
	bh=HEECyfZinc+wH1214D5sqHe2jbzMGQUAA//2Fpca0iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8NPXFkxMUYGevJTYMHahZoEu4HsLhzmfAfIEuuxK05XnL4zTMZYOSzQY5VfTTpwF8ulmlhjULdCXWy1Vxlp7mXZNaMQX37uSuloiLvH7t2Vuf8b/Z/EoFpao1NfWKVTG4PBwQMhRS9R0o9EhhjQf1Belzk8oJ9KldXR6mMky04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSE5Wk7g; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso23437345ad.2;
        Fri, 25 Apr 2025 00:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565117; x=1746169917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGgNXuFLvWdU6d7kOZ4c8+NmxWqqCA2URptaw+zqZE4=;
        b=aSE5Wk7gfETGS74gq9ERVmdwYHRum9FtP54DL9L3vPSi7YQtkmwXa86YtLWjgbK6mY
         YxQPbdCbadHHS1VbhcW+0Gz3CjGHgDT346yrZhKhgnZMC3kiYhs2f+KDsmz82qSk5pDi
         wyz6Y0haafafkho+e+nOpHdNXkciZ7+AbeCnn1exX8xY82lzDfl9r1FQAy2neLsdXsrL
         XZWsRIia1TPVoav6JxqCCIrtlR/ElRFX4qEULcaKSJGdqOEHuy+kxiTRkXzLwk+bPkK4
         Mj/35ivAApanOE+aECmADEsSp2zIH+sS6xADTnCWO3/+KHi+PaVEWCnfl/p+PkTdn90p
         +s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565117; x=1746169917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGgNXuFLvWdU6d7kOZ4c8+NmxWqqCA2URptaw+zqZE4=;
        b=JZN/KivYy2F9Sbq3/lkK+IDUfvSCE5tOINeeVJmf5zj6pWyuRrYuOrS7gn0dt74s6I
         cqVGje5bL0FmUFm5AhwyVKp5v5+RjeARiRJGf1RApi4Wy9g3mWAHUo28MXaXxCOfhjfv
         Go8XwHC/D35sghRUKoFKiNyt17DarK10aq59uQUMLXuX4dlSqxuJN5Pra/1R4ZAgiAzR
         vosDRCZtZWJtJjnpGScCweuSGz/BKbtZay6Hjh4EBa1/oKu6GfxMKYnrlToHcZjogjx/
         AjjgeLZBXn7XpCKblAsI15mbxWqOsri/IAotxme/qqwr2KmIhQ1vT78XsFY0OR9uqFAL
         n4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH+/UhInUKeYCpOYliVrhouTux9KBnGAbpbQiTfajc9n4XyTHqDl0F3edNYxIbRTC4Kr4=@vger.kernel.org, AJvYcCVY47bERyRXW/YfGrcBppfn1B0vD13LyYlDOJ5CH3j7mhZMkerpWO6mKz7Q2N1CUVULUizeHQ59@vger.kernel.org, AJvYcCXfZLrpeV61CBNFW1f3A5wcbaWLNcTafWbfj23CqVAN76YjcEiEopxFBxh9aDqPaX7qnIE06TBQzsXGpHH/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+LxrtaPsnIOm8BEqjv8BZuJK3rI8+CYdBPsZx+blNYz65Z5t
	73d1m46wQBYNOccu6/KLERxrH+bYIyaj18L8kszf+NG/alNWW3E2
X-Gm-Gg: ASbGncuEMbeo5o9sVd35sSrRIo/QWu0koxeq4FhHnYL50N+p4CJ1GAGwfT+u3la3ep2
	hDWZPUkREV06OPZE4LoUbp7hwNW/fSShG5YVVMvPzy9YvHP7UhAJ9DMMprxZXiKArR4EVVlWVLI
	Lmzr6NWJtA/cpeK1w9HWAHUfmYCRoG5WDqHxjtigwsJFcyB2Qj6dArSjQ2iXIEHJcpqigsejNSl
	Qi1bgrjecnTUWKLDS6Ld1FQyckOwrzqPhgdlLQjo8ecf9Bjp821ocNKgm3B8/JEj7BD5nufnNyW
	yMUFTYsjY8lyaOy4V3qqSj41V/SwTkaUY+mQ+mL6IllrsUYumjNCRTsqHXD5UMtKFGU=
X-Google-Smtp-Source: AGHT+IFpuBEDWJ4Jdf5U2gn8bRZq3DJLbe8GQt+jgcamP/LZqySE7mAq8G00x6oy8xUhODZjxUMyRQ==
X-Received: by 2002:a17:903:2987:b0:223:f408:c3cf with SMTP id d9443c01a7336-22dbf5eaa52mr19859965ad.21.1745565117500;
        Fri, 25 Apr 2025 00:11:57 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:11:57 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v6 2/4] selftests: net: add flag to force zerocopy mode in xdp_helper
Date: Fri, 25 Apr 2025 14:10:16 +0700
Message-ID: <20250425071018.36078-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an optional -z flag to xdp_helper. When this flag is
provided, the XDP socket binding is forced to be in zerocopy mode.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/net/lib/xdp_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index d5bb8ac33efa..6327863cafa6 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -17,6 +17,12 @@
 #define NUM_DESC (UMEM_SZ / 2048)
 
 
+static void print_usage(const char *bin)
+{
+	fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
+		"where:\n\t-z: force zerocopy mode", bin);
+}
+
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
  *
@@ -36,8 +42,8 @@ int main(int argc, char **argv)
 	int sock_fd;
 	int queue;
 
-	if (argc != 3) {
-		fprintf(stderr, "Usage: %s ifindex queue_id\n", argv[0]);
+	if (argc != 3 && argc != 4) {
+		print_usage(argv[0]);
 		return 1;
 	}
 
@@ -87,6 +93,15 @@ int main(int argc, char **argv)
 	sxdp.sxdp_queue_id = queue;
 	sxdp.sxdp_flags = 0;
 
+	if (argc > 3) {
+		if (!strcmp(argv[3], "-z")) {
+			sxdp.sxdp_flags = XDP_ZEROCOPY;
+		} else {
+			print_usage(argv[0]);
+			return 1;
+		}
+	}
+
 	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
 		munmap(umem_area, UMEM_SZ);
 		perror("bind failed");
-- 
2.43.0


