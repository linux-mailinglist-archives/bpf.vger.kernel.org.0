Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55E30CE02
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 22:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhBBViP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 16:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhBBViO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 16:38:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBBAD64E3D;
        Tue,  2 Feb 2021 21:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612301853;
        bh=lOBdC+1AUbl9rnJt/M6mi8HptI7g7I29M82er2Fu5b0=;
        h=From:To:Cc:Subject:Date:From;
        b=jJ3VIRPGmlWge51yBcXbWWJeVhefsF9TQjZGGUf61bXisndLmkT22avKoY7oeDvT3
         k54hBHVgfzexV5J0VA2BIFp459MGlQEyuPELU1wWbA/XSFQwha7n6BkvUOBneXfStn
         snVzjObxTlqTd5bLEeX3fo7tfWa7gK0/KX4IbZm/b/nlD5qXC/W2XJbar+2HuLBfbJ
         SfjjlU6o2ja0NAfi71lPuxXFD3P3L57GH02sEo4+SsaCPI2pTbRsTJQwzOY/TvKEHS
         lCD1bAEh4xy5HuvfWYrhkg6h/bk0pLKypKsbTNV0RdZ/HFEb8P22aM1kEbw+k5FIUW
         TKshk+axLRQCg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf] selftests/bpf: Fix a compiler warning in local_storage test
Date:   Tue,  2 Feb 2021 21:37:30 +0000
Message-Id: <20210202213730.1906931-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some compilers trigger a warning when tmp_dir_path is allocated
with a fixed size of 64-bytes and used in the following snprintf:

  snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
	   tmp_dir_path);

  warning: ‘/copy_of_rm’ directive output may be truncated writing 11
  bytes into a region of size between 1 and 64 [-Wformat-truncation=]

This is because it assumes that tmp_dir_path can be a maximum of 64
bytes long and, therefore, the end-result can get truncated. Fix it by
not using a fixed size in the initialization of tmp_dir_path which
allows the compiler to track actual size of the array better.

Fixes: 2f94ac191846 ("bpf: Update local storage test to check handling of null ptrs")
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/test_local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
index 3bfcf00c0a67..d2c16eaae367 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
@@ -113,7 +113,7 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
 
 void test_test_local_storage(void)
 {
-	char tmp_dir_path[64] = "/tmp/local_storageXXXXXX";
+	char tmp_dir_path[] = "/tmp/local_storageXXXXXX";
 	int err, serv_sk = -1, task_fd = -1, rm_fd = -1;
 	struct local_storage *skel = NULL;
 	char tmp_exec_path[64];
-- 
2.30.0.365.g02bc693789-goog

