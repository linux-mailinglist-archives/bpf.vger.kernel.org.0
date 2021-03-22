Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A0344CCB
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 18:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhCVRHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 13:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhCVRHa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 13:07:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0806619A0;
        Mon, 22 Mar 2021 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616432850;
        bh=9Pq0sQEeR4olSkvZgwdxlBggjM+zJrgIiZwmS8FjX2U=;
        h=From:To:Cc:Subject:Date:From;
        b=dJvi2fu0+Ij6gi+g5j1ZBPiWrn42ldpT0FdF2oAPzYu+yQRKhdQOMaU6BjqlEh8xl
         FRbqCimRXfFrzKLfFDTbTGpyQ7KhfKqjqBk98K873T/QpWoSm3qMzatJfwxAs25Sup
         jxAs3aMpUcCWsIUrgJhhA/vaXWpsoEKG5dtabtJNzgA0hBFWTiWNdEA3fc3cBpiL+C
         jzLh8UfPJHz2FdZfK84r0lOQvm3r8libW+69OVpIgqHRqbUZbznd+KIz2IAM2t1Am2
         Id8ljFwfKwybfesOEHcW0CFmZBVRJLYCdLc2bdgo+rPNHi+jW7aTTzHYJWh95RVGLG
         Jxkj/1AFz5aRg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next] selftests/bpf: Better error messages for ima_setup.sh failures
Date:   Mon, 22 Mar 2021 17:07:20 +0000
Message-Id: <20210322170720.2926715-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current implementation uses the CHECK_FAIL macro which does not
provide useful error messages when the script fails. Use the CHECK macro
instead and provide more descriptive messages to aid debugging.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/test_ima.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
index b54bc0c351b7..0252f61d611a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
@@ -68,7 +68,8 @@ void test_test_ima(void)
 		goto close_prog;
 
 	snprintf(cmd, sizeof(cmd), "./ima_setup.sh setup %s", measured_dir);
-	if (CHECK_FAIL(system(cmd)))
+	err = system(cmd);
+	if (CHECK(err, "failed to run command", "%s, errno = %d\n", cmd, errno))
 		goto close_clean;
 
 	err = run_measured_process(measured_dir, &skel->bss->monitored_pid);
@@ -81,7 +82,8 @@ void test_test_ima(void)
 
 close_clean:
 	snprintf(cmd, sizeof(cmd), "./ima_setup.sh cleanup %s", measured_dir);
-	CHECK_FAIL(system(cmd));
+	err = system(cmd);
+	CHECK(err, "failed to run command", "%s, errno = %d\n", cmd, errno);
 close_prog:
 	ima__destroy(skel);
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

