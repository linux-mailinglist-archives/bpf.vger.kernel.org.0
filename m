Return-Path: <bpf+bounces-12937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504707D2232
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C725AB20DDE
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23762103;
	Sun, 22 Oct 2023 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh3z6Nwf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8415CA
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 09:26:18 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5397D99
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 02:26:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d0251d305so1374157a91.2
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697966777; x=1698571577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORduZjPM6yqsRTEzn/po3JFAgmG7BIFNOwDp+movjvY=;
        b=Hh3z6NwfkjzQMiM8O2dqKuJuTc74mAUiWLp44DAXzNNyZsl+t0RhkDSVt2ExMOaQKH
         niYO0uTqIs3MAnPw1LbdkihbntX1pFpwG/XyqA7V6POvhb/ld9AoX7alWba9D1T39CUc
         CZNRLuZiy2uT1wCCSU80GnA1Iqaiabbc9Nn/efa3YyEnQdvdkZtOXIpZdG1T6huk9YnN
         em+WKLBCHPr3sajjy6DGiEetny9G8uO803x3YnyOcxdnX5wUh9YjvqWxRQQd2B1VQYIs
         WY0S98YV+gGbuxWWWxNfU2IsRjOHVoBH/KuoQsGNvZgHI0hXOS8Csa9F+/u+0vfPtovz
         UZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697966777; x=1698571577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORduZjPM6yqsRTEzn/po3JFAgmG7BIFNOwDp+movjvY=;
        b=ZWHIvzdd0K4OdFFFCVM/0OK9tyQF5wogs/xsOJU/rYGHPbUxh6zgkUO4J8ItxfF6UJ
         Uvi78MJZTZFZbjRM39N4M2lIzkau4Qd0qbrUDzpHzbKvoU2NZNtSjMWCuOGYlSSRP3fN
         zrBdOa8YzMcmM+pV9O5/G462Ntbx13eZfzk2j7ntzBdssSCRr2LqrhIiq4ykO9+NeLSp
         DljWOzbMHhjDizYalc2SlZk1nciUiRGWPtnwfpuXpnjsbaJlzovdE7aRnlM8TOUj7+BY
         21TWTpUwYRCnXB8vqfaDFG57MzOZ5/juBSMzy/OON13L1Tyyz59baqcYaTpX5nuDpKfs
         TnNQ==
X-Gm-Message-State: AOJu0YzAtIPizXrIlq9hfm+XSpyzQEVzWCtcoZ63pUOYF86eWUHtP4VN
	AJwYggGoPHzJH58/47IJFuo=
X-Google-Smtp-Source: AGHT+IGaxGRJxTFOCQr3A99twquBr/pI07Ae9z0hJx7xLS1BYi2H35yQr1/ADIz/JBy6Vi5yZ9wvjg==
X-Received: by 2002:a17:90b:3c02:b0:27d:af3:f143 with SMTP id pb2-20020a17090b3c0200b0027d0af3f143mr4357466pjb.43.1697966776539;
        Sun, 22 Oct 2023 02:26:16 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id fa17-20020a17090af0d100b00274922d4b38sm4017117pjb.27.2023.10.22.02.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 02:26:16 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	gerhorst@cs.fau.de,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	laoar.shao@gmail.com,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next] selftests/bpf: Fix selftests broken by mitigations=off
Date: Sun, 22 Oct 2023 09:26:06 +0000
Message-Id: <20231022092606.2245-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com>
References: <CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com>
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
Link: https://lore.kernel.org/bpf/CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 29 +++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index 2a6efbd0401e..2e756c89b37c 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -4,9 +4,36 @@
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
+	int fd;
+
+	fd = open("/proc/cmdline", O_RDONLY);
+	if (fd < 0) {
+		perror("open /proc/cmdline");
+		return false;
+	}
+
+	if (read(fd, cmdline, sizeof(cmdline) - 1) < 0) {
+		perror("read /proc/cmdline");
+		return false;
+	}
+
+	cmdline[sizeof(cmdline) - 1] = '\0';
+	for (c = strtok(cmdline, " \n"); c; c = strtok(NULL, " \n")) {
+		if (!strncmp(c, "mitigtions=off", strlen(c)))
+			return true;
+	}
+	return false;
+}
+
 bool get_unpriv_disabled(void)
 {
 	bool disabled;
@@ -22,5 +49,5 @@ bool get_unpriv_disabled(void)
 		disabled = true;
 	}
 
-	return disabled;
+	return disabled ? true : !get_mitigations_off();
 }
-- 
2.39.3


