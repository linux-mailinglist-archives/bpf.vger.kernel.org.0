Return-Path: <bpf+bounces-13201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E51B7D604A
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 05:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BF1B211BA
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 03:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85417EA;
	Wed, 25 Oct 2023 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrhAuMOM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC51FBF
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 03:11:50 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4012A
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 20:11:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so5170302b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698203508; x=1698808308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NFPkYnCos96tYWYoFb2Ur0uVJtm7asjgaJR8wmpc2g=;
        b=YrhAuMOMK/J68ec0KEOyoeLZoNWNkMj1iB4+NpQbibSOrP91z997bqK+5So0yjHZVc
         S+K8pd1cXSeRT1cR8emVYSYAcBe2NfU6nH2f7SqH0K0+lyeU2dzh7CHNzKqBUdclX1XB
         8MUSETR9S+aNoCIbSA/UVTsUEASA+5hSbbsPNKD3X03NrgJ8eC5sCMuzwm2GY8cOSc0Q
         bvuQRTAFeDxH2YhNpCoMbdQiUJkcQ+2PS8rjuzovXmUMOmvuWxGFn1C68DKkqjqWyYsK
         fATQU1Da5feUBNxkUQ7nFYJlCwNGIU1Z5OfOfQyyRTU3GQpprExuQfiiqYV89rPCxxjq
         4mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698203508; x=1698808308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NFPkYnCos96tYWYoFb2Ur0uVJtm7asjgaJR8wmpc2g=;
        b=Uk4A54PGJco0zCZs5y84p69W5kUp7KxiVvoiZnN7JJ3D/X7xv7bpsi6Eg6uCxubHN/
         z7Sz1hUly8TWxhcLlGn7V2lvwQxxVuSI2K9zfwXhkfXhfoC8ZsPecJr0mhTkdQ+gwIQd
         lPOTTLn8Rgqe8nvic4IsK4eSKw2YsprFGxIYnWhiLciMkRSLNFu5/g6POJI3NqE7Fbrm
         823mazwyLD12mgOI537Lhxdhlv/8OYMTIkQV3lBHQbb9RB/4OfY4pDAvmTWG+H0xHHdz
         0lE2bF4H2xQqoFstn4kWPMMg/28xh5FCNKs5sfyrp+kU7GBFD8LTGKrttQM4ftgdrblM
         Kfig==
X-Gm-Message-State: AOJu0Yzj8wfybVwQyQGjUYfyLpTX2oA75SxyWgM8OnE76MkCJYFdJKdH
	Lm6Xi3+zwEGFkdk989W2tjc=
X-Google-Smtp-Source: AGHT+IFj2IYnSqE7jndsn20AWT8NuzHqDJyWkMMQusvBu/nARq3M5eyV7wqXGNqn66NwkpxSGl0MbQ==
X-Received: by 2002:a05:6a20:7f9c:b0:173:f8c9:94ef with SMTP id d28-20020a056a207f9c00b00173f8c994efmr6376560pzj.41.1698203507643;
        Tue, 24 Oct 2023 20:11:47 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac00:4bae:5400:4ff:fe9f:2311])
        by smtp.gmail.com with ESMTPSA id i1-20020aa796e1000000b006bdf4dfbe0dsm8624790pfq.12.2023.10.24.20.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 20:11:47 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next] selftests/bpf: Fix selftests broken by mitigations=off
Date: Wed, 25 Oct 2023 03:11:44 +0000
Message-Id: <20231025031144.5508-1-laoar.shao@gmail.com>
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
causes issues in the execution of `test_progs -t verifier`. This is because
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
'mitigations=off' is enabled. The result of `test_progs -t verifier` as
follows after this commit,

Before this commit
==================
- without 'mitigations=off'
  - kernel.unprivileged_bpf_disabled = 2
    Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
  - kernel.unprivileged_bpf_disabled = 0
    Summary: 74/1336 PASSED, 0 SKIPPED, 0 FAILED   <<<<
- with 'mitigations=off'
  - kernel.unprivileged_bpf_disabled = 2
    Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
  - kernel.unprivileged_bpf_disabled = 0
    Summary: 63/1276 PASSED, 0 SKIPPED, 11 FAILED   <<<< 11 FAILED

After this commit
=================
- without 'mitigations=off'
  - kernel.unprivileged_bpf_disabled = 2
    Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
  - kernel.unprivileged_bpf_disabled = 0
    Summary: 74/1336 PASSED, 0 SKIPPED, 0 FAILED    <<<<
- with this patch, with 'mitigations=off'
  - kernel.unprivileged_bpf_disabled = 2
    Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED
  - kernel.unprivileged_bpf_disabled = 0
    Summary: 74/948 PASSED, 388 SKIPPED, 0 FAILED   <<<< SKIPPED

Fixes: bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/bpf/CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 35 +++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index 2a6efbd0401e..7101e72ef4a3 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -4,9 +4,42 @@
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
+		if (strncmp(c, "mitigations=off", strlen(c)))
+			continue;
+
+		ret = true;
+		break;
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
@@ -22,5 +55,5 @@ bool get_unpriv_disabled(void)
 		disabled = true;
 	}
 
-	return disabled;
+	return disabled ? true : get_mitigations_off();
 }
-- 
2.39.3


