Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7A0DA77E
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 10:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393333AbfJQIh5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 04:37:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42601 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388788AbfJQIh5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 04:37:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id z12so1168973lfj.9
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyXqf2Y5RVgz0dXJDcgvlyJCh/JIvnGuh8RzmE45oX0=;
        b=r+BzTn0BajFC/ZI5g1K2t2f9T+3f2xuwJg8Eqd9aSRIRbvS9DXxRYnFMeSLd5TQoVC
         nzRuRNEuk1bl7KahgGzNEHVBZxJ5w2XEo8Z2OTYgSMpojdFUWKLD4it1wYD/6NPAKKFp
         MvTDiAc6M4Fk3REMyBDc3b/AeILoexp5m+4JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyXqf2Y5RVgz0dXJDcgvlyJCh/JIvnGuh8RzmE45oX0=;
        b=oFebXskY2m8c2xXHDMLy4e+SOrjhpxy4rFM9ggQ4VBV+MbIm9hz/H2wGuWOjGlkSVB
         jgms+VD6yR1Vp9hYWBSO9oBkUSWqoiQe0Zv3eHVaf5Ndpd2dXjzYkGrXZ4/kyzb6BB84
         LuE5P2izlaXwGpNnFP1rifTgZGcnKbWHX3v9PFq0cCQoGeFA3CHv1eDG9jg2LxNr7bnO
         7HFlpFZxGQ/OmI219G3mL1DJAlkiFaUMN929QMre0mCv9MKmuACSR+9fCdA2rgdtZIvo
         BlQhz/R2qVegytN2dPG8gUBULgq4Biy0qE7NwEFOiyLTzWBPvuPhSU2cx5bCV9UIoHUz
         Oftw==
X-Gm-Message-State: APjAAAVcVQHq7HTSpFC4mmn11a6PBWJwioku4AYY/GD7ydpRZZEN4lYe
        LTSzi0U42H0C5HV2AamMhxw4D9N3OebfEQ==
X-Google-Smtp-Source: APXvYqwLL5rugmzKDMycdTY030AImuFDveTcvViXTY8X4oBD724KF5HLxwJ+k2O0HGl3y2NYBlhKwA==
X-Received: by 2002:a19:dc14:: with SMTP id t20mr1518966lfg.21.1571301473596;
        Thu, 17 Oct 2019 01:37:53 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id n11sm266072lfd.88.2019.10.17.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 01:37:52 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Restore the netns after flow dissector reattach test
Date:   Thu, 17 Oct 2019 10:37:52 +0200
Message-Id: <20191017083752.30999-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

flow_dissector_reattach test changes the netns we run in but does not
restore it to the one we started in when finished. This interferes with
tests that run after it. Fix it by restoring the netns when done.

Fixes: f97eea1756f3 ("selftests/bpf: Check that flow dissector can be re-attached")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/flow_dissector_reattach.c  | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
index 777faffc4639..1f51ba66b98b 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
@@ -91,12 +91,18 @@ static void do_flow_dissector_reattach(void)
 
 void test_flow_dissector_reattach(void)
 {
-	int init_net, err;
+	int init_net, self_net, err;
+
+	self_net = open("/proc/self/ns/net", O_RDONLY);
+	if (CHECK_FAIL(self_net < 0)) {
+		perror("open(/proc/self/ns/net");
+		return;
+	}
 
 	init_net = open("/proc/1/ns/net", O_RDONLY);
 	if (CHECK_FAIL(init_net < 0)) {
 		perror("open(/proc/1/ns/net)");
-		return;
+		goto out_close;
 	}
 
 	err = setns(init_net, CLONE_NEWNET);
@@ -108,7 +114,7 @@ void test_flow_dissector_reattach(void)
 	if (is_attached(init_net)) {
 		test__skip();
 		printf("Can't test with flow dissector attached to init_net\n");
-		return;
+		goto out_setns;
 	}
 
 	/* First run tests in root network namespace */
@@ -118,10 +124,17 @@ void test_flow_dissector_reattach(void)
 	err = unshare(CLONE_NEWNET);
 	if (CHECK_FAIL(err)) {
 		perror("unshare(CLONE_NEWNET)");
-		goto out_close;
+		goto out_setns;
 	}
 	do_flow_dissector_reattach();
 
+out_setns:
+	/* Move back to netns we started in. */
+	err = setns(self_net, CLONE_NEWNET);
+	if (CHECK_FAIL(err))
+		perror("setns(/proc/self/ns/net)");
+
 out_close:
 	close(init_net);
+	close(self_net);
 }
-- 
2.20.1

