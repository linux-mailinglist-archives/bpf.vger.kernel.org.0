Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1672035AF69
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 19:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhDJR45 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJR45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Apr 2021 13:56:57 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F6C06138A
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 10:56:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g35so6192174pgg.9
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zhxgGD0Qe04Ri9cfIqQvNqUSMP7RX4IA7zyXt/5Wf0=;
        b=qHnRY6sLLDW9gtKAl8nqpfuI3KNkE/Y2brtsPFqtcqO0EK1O4350XrVPBBF1+Gqkmm
         PNXCPSzhEeSfJIPvkuX2s142PqfRVSkIC/nOrtPh2Q87tGoaime/8p0bPBHCfwrOd4qs
         KTd7ImSAeBIzRDtY/DaK6KZ5j7YcFOD4ya03DUXMrg6HjrKWV6K5Wk7ryGFNHbk1nAgq
         eruz2nidHlzxNBoyKKr3ZY2anA8HVcnAKuK/Uv2CR4DYtdqszyq8s0rBxmYVbdIVwDLq
         gzyPTAsX/McMK/i76hp3/07YHIrmM1XxC7YqvAqKjynD5LgvQgCtgpcBFnVXCo6+JaC0
         t85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zhxgGD0Qe04Ri9cfIqQvNqUSMP7RX4IA7zyXt/5Wf0=;
        b=gw/9LSHkaxoKRuUERLrKND8sc39ASpnORKlk1fWfaaqORh2HYp/xgIe1iPlm7hVrXC
         U+0BGSaXzCu5JU3G0r3gfC798UZ3nk5yvYsIHXfpZVh45+Y2ehgAXqbnuS9gql/PCEhk
         FZ3hJGlZspRPRVznQhAA3fOJz5XU+ljrX3/xeQ8ecSp3TpwOFtZtUHUhRFyKcFgAHiGY
         wnNAMMCMSmAPppgSZxilEb+UIgRa3MWC+bh/U8UqZt0E94xp1eFamvwIVBWW+kPSo05z
         mT5TUpuYbCQu3j95f3nBwXJ3HNEdTLTO7AQ8wFKeFE3OyeLrenAq4zxpWlDyWGOe6zBS
         SfVQ==
X-Gm-Message-State: AOAM531CjXUsKoED3WTrQmBlwpRRWOTZeSCKCMQJUF79u4fjDN4EKN+o
        wZl2aUHk+BmebExPJuR9WICVT8aDX7vNcIDU
X-Google-Smtp-Source: ABdhPJxzRSOMTBmoaECibs5y6iCOMatWFeWCyz/I9feDJYG8kJmmqdI9pUAPMsoh7AiO2ot09BHQ3Q==
X-Received: by 2002:a63:1a50:: with SMTP id a16mr19495543pgm.92.1618077401603;
        Sat, 10 Apr 2021 10:56:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id w26sm5457277pfj.58.2021.04.10.10.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:56:41 -0700 (PDT)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Make docs tests fail more reliably
Date:   Sat, 10 Apr 2021 10:56:01 -0700
Message-Id: <20210410175601.831013-1-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, if rst2man caught errors, then these would be ignored and
the output file would be written anyway. This would allow developers to
introduce regressions in the docs comments in the BPF headers.

Additionally, even if you instruct rst2man to fail out, it will still
write out to the destination target file, so if you ran the tests twice
in a row it would always pass. Use a temporary file for the initial run
to ensure that if rst2man fails out under "--strict" mode, subsequent
runs will not automatically pass.

Tested via ./tools/testing/selftests/bpf/test_doc_build.sh

Signed-off-by: Joe Stringer <joe@cilium.io>
---
 tools/testing/selftests/bpf/Makefile.docs     | 3 ++-
 tools/testing/selftests/bpf/test_doc_build.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
index ccf260021e83..a918790c8f9c 100644
--- a/tools/testing/selftests/bpf/Makefile.docs
+++ b/tools/testing/selftests/bpf/Makefile.docs
@@ -52,7 +52,8 @@ $(OUTPUT)%.$2: $(OUTPUT)%.rst
 ifndef RST2MAN_DEP
 	$$(error "rst2man not found, but required to generate man pages")
 endif
-	$$(QUIET_GEN)rst2man $$< > $$@
+	$$(QUIET_GEN)rst2man --strict $$< > $$@.tmp
+	$$(QUIET_GEN)mv $$@.tmp $$@
 
 docs-clean-$1:
 	$$(call QUIET_CLEAN, eBPF_$1-manpage)
diff --git a/tools/testing/selftests/bpf/test_doc_build.sh b/tools/testing/selftests/bpf/test_doc_build.sh
index 7eb940a7b2eb..ed12111cd2f0 100755
--- a/tools/testing/selftests/bpf/test_doc_build.sh
+++ b/tools/testing/selftests/bpf/test_doc_build.sh
@@ -1,5 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+set -e
 
 # Assume script is located under tools/testing/selftests/bpf/. We want to start
 # build attempts from the top of kernel repository.
-- 
2.27.0

