Return-Path: <bpf+bounces-12939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7E7D2268
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 11:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A56D281680
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CD5693;
	Sun, 22 Oct 2023 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTYaz7Hn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA981875
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 09:49:15 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96814DC
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 02:49:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-578b4997decso1685894a12.0
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697968154; x=1698572954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFw5SBOPauon28x1DRliGsnW1Hs+V3EbT8Om6GQK/Yo=;
        b=LTYaz7Hn6pjw4Gu5PEvNDsnMLIy4lTyn2p637D+vo8AX66dh+CgN0oc29BiudGXwjU
         ypN3/hvpIgcW5XGzS+l9GctyBM5D6XFc2qkYleLu8LZmw7sD3hxUmOq8EjGEFcYMGejt
         uXYFbxvXxQexIk3EMemvv0N2Zlz+ZbnHZyt10tLs/YUkf7v8i6hVsLcmYaYJwi6sWsk5
         9p6SzXoAL528rAg/wgoJ4WCL02P84wp5MStV7Bao+otJWk8VPp5AuQu3O296bomm78In
         udqq/LMdK+pM2cq1jkAEMEUdInJohDImpEKT+nuC3ES6erlZ+k5TPB0ziNJxx9x9dcXd
         NQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697968154; x=1698572954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFw5SBOPauon28x1DRliGsnW1Hs+V3EbT8Om6GQK/Yo=;
        b=kxpLUoPp1fWIkFs1EUK4W76rdQgdz8mhYXkQyUjDSN3ieXY+V49eFx/T0me8OPrS4U
         7lPk0B72O90rNdLAz4F7OB7f/9E6gHTdQ1NyXBQX7iCzl6xKrksfN+UIcZqAFmIsND31
         XVDLxAA+1XaivFmInHCIPTughrQDrTOtYcH1rLjQuuUvV+bJdej8erqRF1Vl2qZOZ6nu
         C2xyPMaUlNFyTFt6lR8rZFznxPNDbdDCXlPkFs6tnTA1Ps2kyQ3D4v2eG+Xbb8QFEDHH
         ER1LLWmLW0to9jMoDU6WI+s78fnY19j6u1clxQUt6ioJgR6dGspjQmOCu1clIg4oN5pl
         7d0g==
X-Gm-Message-State: AOJu0YyHFoTRzniXkEHM4F6l9hPHQct9bXshxod+IAxz9zu4YJzp8N5S
	CFuBPsF3s5rCDZNg1oha4TxqdwLK85dPPQqJ
X-Google-Smtp-Source: AGHT+IGBfM8gQL2gBITuKRDusWkQ72QNOwojO+YpGee5Iku1EUKSf3k+xNnuVBM8TQqiqwmaXFPILg==
X-Received: by 2002:a05:6a21:999d:b0:157:1b5:61ce with SMTP id ve29-20020a056a21999d00b0015701b561cemr8264055pzb.4.1697968153933;
        Sun, 22 Oct 2023 02:49:13 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id n5-20020aa79845000000b006bd67a7a7b3sm4339549pfq.68.2023.10.22.02.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 02:49:13 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: laoar.shao@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	gerhorst@cs.fau.de,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 bpf-next] selftests/bpf: Fix selftests broken by mitigations=off
Date: Sun, 22 Oct 2023 09:49:06 +0000
Message-Id: <20231022094906.3003-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231022092606.2245-1-laoar.shao@gmail.com>
References: <20231022092606.2245-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we configure the kernel command line with 'mitigations=off' and set
the sysctl knob 'kernel.unprivileged_bpf_disabled' to 0, the commit
bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
causes issues in the execution of 'test_progs -t verifier.' This is because
'mitigations=off' bypasses Spectre v1 and Spectre v4 protections.

Currently, when a program requests to run in unprivileged mode
(kernel.unprivileged_bpf_disabled = 0), the BPF verifier may prevent it
from running due to the following conditions not being enabled:

  - bypass_spec_v1
  - bypass_spec_v4
  - allow_ptr_leaks
  - allow_uninit_stack

While 'mitigations=off' enables the first two conditions, it does not
enable the latter two. As a result, some test cases in
'test_progs -t verifier' that were expected to fail to run may run
successfully, while others still fail but with different error messages.
This makes it challenging to address them comprehensively.

Moreover, in the future, we may introduce more fine-grained control over
CPU mitigations, such as enabling only bypass_spec_v1 or bypass_spec_v4.

Given the complexity of the situation, rather than fixing each broken test
case individually, it's preferable to skip them when 'mitigations=off' is
in effect and introduce specific test cases for the new 'mitigations=off'
scenario. For instance, we can introduce new BTF declaration tags like
'__failure__nospec', '__failure_nospecv1' and '__failure_nospecv4'.

In this patch, the approach is to simply skip the broken test cases when
'mitigations=off' is enabled. The result as follows after this commit,

- without 'mitigations=off'
  - kernel.unprivileged_bpf_disabled = 2
    Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
  - kernel.unprivileged_bpf_disabled = 0
    Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
- with 'mitigations=off'
  - kernel.unprivileged_bpf_disabled = 2
    Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
  - kernel.unprivileged_bpf_disabled = 0
    Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED

Fixes: bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/bpf/CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 34 +++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

---
v1 -> v2: Fix leaked fd

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index 2a6efbd0401e..ca4760795f5d 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -4,9 +4,41 @@
 #include <stdlib.h>
 #include <error.h>
 #include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
 
 #include "unpriv_helpers.h"
 
+static bool get_mitigations_off(void)
+{
+	char cmdline[4096], *c;
+	int fd, ret = false;
+
+	fd = open("/proc/cmdline", O_RDONLY);
+	if (fd < 0) {
+		perror("open /proc/cmdline");
+		return false;
+	}
+
+	if (read(fd, cmdline, sizeof(cmdline) - 1) < 0) {
+		perror("read /proc/cmdline");
+		goto out;
+	}
+
+	cmdline[sizeof(cmdline) - 1] = '\0';
+	for (c = strtok(cmdline, " \n"); c; c = strtok(NULL, " \n")) {
+		if (!strncmp(c, "mitigtions=off", strlen(c))) {
+			ret = true;
+			break;
+		}
+	}
+
+out:
+	close(fd);
+	return ret;
+}
+
 bool get_unpriv_disabled(void)
 {
 	bool disabled;
@@ -22,5 +54,5 @@ bool get_unpriv_disabled(void)
 		disabled = true;
 	}
 
-	return disabled;
+	return disabled ? true : !get_mitigations_off();
 }
-- 
2.39.3


