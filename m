Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863292C5C27
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 19:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404018AbgKZStu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 13:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgKZStu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 13:49:50 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E702C0613D4
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 10:49:50 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so3185600wrg.7
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3upl2y9I1+20x7TUdWh7mb3k00BroeAnnTfPUXtSn0=;
        b=c1YpjcCd+Ffza07cs7RIGwzc9Kf+ZBSnrBammqapxVrDYnOqkMhd7+JYt1CbGXVa9f
         DuTU/BKExOuA9ZsPIgms44zoLS6pExqT0w0wZI3F7z/KH/7FmyOyL0yUUxwvxWe/J1fw
         7stAdSnj0iCzVwfD5gUqMxJAQ6N9C/UmwvwM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3upl2y9I1+20x7TUdWh7mb3k00BroeAnnTfPUXtSn0=;
        b=k31lv5iHuPKDL8rCVdlyYvLtuCmpbVw1o8PXU7jpGjDxjG962n97KligKxhotJ/qyZ
         5SxslDYKq/aCiL0FlvW8q84FqhP+2r0uPt8nwkY2+iObqE9diLdVHQGGEHfgmpuQ+g4O
         GrkacuakjxQc5HG1VgEH84pr5MRMslE6RhAPDzFXXW+QU4YWmezlZXBnENSpPcGq9sBe
         KrAifylClJjXic5KSmGAXUlf5bCq/QC1QhBIvYiobVU743AEW9mK2bLJ6L71nPcojuv0
         BNvyCnIJnNvIawIVDb/dYrKpav9ysr971VKawHIHnTGVgdSEGYWCRXVkR/vAfMpU+4N4
         iLMw==
X-Gm-Message-State: AOAM531+3xOulwMUWAmfVaM5O+4aOQDMu71/2p1VKSUqo0ErmMP3HWwT
        xDqIETt6Y+/Hl3ta3ccpNPYn2jC8rxRJS880
X-Google-Smtp-Source: ABdhPJxEG+RVI1TX/1ziIbJ2NB42qUJVnspOSoK1fldM+Y15uRTlSEyPI5Ll3/vmUi6UfAzzLkYydQ==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr5365589wru.422.1606416588560;
        Thu, 26 Nov 2020 10:49:48 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id a14sm10093076wmj.40.2020.11.26.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 10:49:48 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix flavored variants of test_ima
Date:   Thu, 26 Nov 2020 18:49:46 +0000
Message-Id: <20201126184946.1708213-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Flavored variants of test_progs (e.g. test_progs-no_alu32) change their
working directory to the corresponding subdirectory (e.g. no_alu32).
Since the setup script required by test_ima (ima_setup.sh) is not
mentioned in the dependencies, it does not get copied to these
subdirectories and causes flavored variants of test_ima to fail.

Adding the script to TRUNNER_EXTRA_FILES ensures that the file is also
copied to the subdirectories for the flavored variants of test_progs.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Yonghong Song <yhs@fb.com>
Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3d5940cd110d..894192c319fb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -389,6 +389,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c	flow_dissector_load.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
+		       ima_setup.sh					\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
-- 
2.29.2.454.gaff20da3a2-goog

