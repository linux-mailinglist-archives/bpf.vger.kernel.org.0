Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BCE697A5
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2019 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfGONwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Jul 2019 09:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732095AbfGONvh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Jul 2019 09:51:37 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1B72067C;
        Mon, 15 Jul 2019 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198696;
        bh=72ZPFHwqWAaNWIcd3wYc2xkP5JFEXff9X1ORAOpl6Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2PrnYkeqrOYqTbUkj3b9rbISMCGMEQvkS8DiWmkTjTPtwf+MWfW8ETxHw9o7X7FMb
         5NTc5BTNowyMBiQMiakqNmVc1P0BzVIM9bNaBcodEeIiS39o7sx0gKlahZ0U8z+sNV
         S3KryQ76vUe09er+zEmZcFy85SN8HXimVO9dgfGU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hechao Li <hechaol@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 085/249] selftests/bpf : clean up feature/ when make clean
Date:   Mon, 15 Jul 2019 09:44:10 -0400
Message-Id: <20190715134655.4076-85-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hechao Li <hechaol@fb.com>

[ Upstream commit 89cceaa939171fafa153d4bf637b39e396bbd785 ]

An error "implicit declaration of function 'reallocarray'" can be thrown
with the following steps:

$ cd tools/testing/selftests/bpf
$ make clean && make CC=<Path to GCC 4.8.5>
$ make clean && make CC=<Path to GCC 7.x>

The cause is that the feature folder generated by GCC 4.8.5 is not
removed, leaving feature-reallocarray being 1, which causes reallocarray
not defined when re-compliing with GCC 7.x. This diff adds feature
folder to EXTRA_CLEAN to avoid this problem.

v2: Rephrase the commit message.

Signed-off-by: Hechao Li <hechaol@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e36356e2377e..1c9511262947 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -275,4 +275,5 @@ $(OUTPUT)/verifier/tests.h: $(VERIFIER_TESTS_DIR) $(VERIFIER_TEST_FILES)
 		 ) > $(VERIFIER_TESTS_H))
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) \
-	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H)
+	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H) \
+	feature
-- 
2.20.1

