Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA01457620
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 19:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhKSSDm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 13:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbhKSSDm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 13:03:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20058C06173E
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 10:00:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 133so9306787wme.0
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 10:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bDpC1i2G5HQW+MPVVvZ8vQcm4TQ3xQ3au6LEt00a410=;
        b=oIKXUybqVzW5Fg1kyaU3H6IYTZwsIF5yGItWefrg0uCh0qMfPBiG5+Go99K3VZAl3q
         2JN0tn3LddzBC/D27m2jDFf121tUEpcy88B7k0Uj6vphEz1+UmXTQreNoo1hLMPP9j13
         cm1WVdxEi4DU4VGZcAbK40UPbXBN1iJjHcy/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bDpC1i2G5HQW+MPVVvZ8vQcm4TQ3xQ3au6LEt00a410=;
        b=b2ISyolGt4NT8R7lV+bCn5ukxonlwrBbXZxY6b7BbNcm8aNLIMCDHYfb7attJNNOA4
         REmLWk90k5emOLsr789hdPF0XsLohJxvRUc1K+UoEhoToo7XjwryiTRk67HSJ36+ZPNo
         hbdEExXq0bMPc1TIkNxpJBBjylLdxchmg7IsGrvhbI9GSLuhdQjBdMtTJGgUJUQql/7+
         p8L2fZ+qbLCGTrk+lBzk0ynTU/qhwGlIDjNWYF1a1m0AFAnO1Lh7IC7G6LiqSgys9sBP
         5J0b+3WISQCEAF+yWsXAoqcxi8ObW8wrZAwTEacC8XxlP4Hlq54LGyAX/+lH0OwX7MxG
         Yw7Q==
X-Gm-Message-State: AOAM531d72jnPuNeep4FlmYQrfattQ1uN4EW3p35P3pNA+mPREOI8HEq
        MMJte8DtocV5sHGptWdzIoQFjd/LzcMIOA==
X-Google-Smtp-Source: ABdhPJxkfKWC2wxvvZue3gXswLjQm9ptC0wOPGo//FV2cGyk4WSbKlZtdHw3YJa34qITmiXhKAGwEg==
X-Received: by 2002:a1c:287:: with SMTP id 129mr1937458wmc.49.1637344838341;
        Fri, 19 Nov 2021 10:00:38 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:bec8:f729:2747:99f])
        by smtp.gmail.com with ESMTPSA id r15sm12127445wmh.13.2021.11.19.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:00:38 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next] libbpf: Change bpf_program__set_extra_flags to bpf_program__set_flags
Date:   Fri, 19 Nov 2021 19:00:35 +0100
Message-Id: <20211119180035.1396139-1-revest@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_program__set_extra_flags has just been introduced so we can still
change it without breaking users.

This new interface is a bit more flexible (for example if someone wants
to clear a flag).

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/lib/bpf/libbpf.c                        | 4 ++--
 tools/lib/bpf/libbpf.h                        | 2 +-
 tools/lib/bpf/libbpf.map                      | 2 +-
 tools/testing/selftests/bpf/testing_helpers.c | 4 +++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index de7e09a6b5ec..fa164cdbf3c9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8296,12 +8296,12 @@ __u32 bpf_program__flags(const struct bpf_program *prog)
 	return prog->prog_flags;
 }
 
-int bpf_program__set_extra_flags(struct bpf_program *prog, __u32 extra_flags)
+int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
 {
 	if (prog->obj->loaded)
 		return libbpf_err(-EBUSY);
 
-	prog->prog_flags |= extra_flags;
+	prog->prog_flags = flags;
 	return 0;
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 4ec69f224342..b9900d9680d6 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -494,7 +494,7 @@ bpf_program__set_expected_attach_type(struct bpf_program *prog,
 				      enum bpf_attach_type type);
 
 LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
-LIBBPF_API int bpf_program__set_extra_flags(struct bpf_program *prog, __u32 extra_flags);
+LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 flags);
 
 LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6a59514a48cf..61ae2e0ab345 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -400,7 +400,7 @@ LIBBPF_0.6.0 {
 		bpf_program__flags;
 		bpf_program__insn_cnt;
 		bpf_program__insns;
-		bpf_program__set_extra_flags;
+		bpf_program__set_flags;
 		btf__add_btf;
 		btf__add_decl_tag;
 		btf__add_type_tag;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 52c2f24e0898..0f1c37ac6f2c 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -91,6 +91,7 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 	struct bpf_object_load_attr attr = {};
 	struct bpf_object *obj;
 	struct bpf_program *prog;
+	__u32 flags;
 	int err;
 
 	obj = bpf_object__open(file);
@@ -106,7 +107,8 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 	if (type != BPF_PROG_TYPE_UNSPEC)
 		bpf_program__set_type(prog, type);
 
-	bpf_program__set_extra_flags(prog, BPF_F_TEST_RND_HI32);
+	flags = bpf_program__flags(prog) | BPF_F_TEST_RND_HI32;
+	bpf_program__set_flags(prog, flags);
 
 	attr.obj = obj;
 	attr.log_level = extra_prog_load_log_flags;
-- 
2.34.0.rc2.393.gf8c9666880-goog

