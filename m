Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D994307A82
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 17:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhA1QSJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 11:18:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45279 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhA1QSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 11:18:06 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l59z1-0002aU-Kd
        for bpf@vger.kernel.org; Thu, 28 Jan 2021 16:17:23 +0000
Received: by mail-il1-f200.google.com with SMTP id h17so5096597ila.12
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 08:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tkk2BUb79GCkzB0eTMBLvXetGKpINayzR/LLA/HkVzI=;
        b=r7axtXVJDkDAsIJZ4xntF2oFM6wQy5DHKUuROf+cw+JlitPXH/TE0yrK+ZCsnd2d6u
         RdbGfPBfrtA2NOTY8HdGusBIruW6Sm4jVHRSszBTrhIYLBvqhn2hXpdvfe8So6BL5nG3
         ddKEGUtS2k32kLyGc9Zf3z8epIjC1WnscKrs6EOVvKASD7tMv4V0g9aYgFvD/7ZMswO1
         31uDNsbo3kvGkC224Pb5gm6xp23ZPPU8tyNYtsh9WxtrbYJVEXX8yrhkKzUn2mGSLHQO
         vlqDmgzI6ahkI0kixQrG4PEtHJbXJZiBerwA2mvUNR6T/Km2/M7ivddqgvhrg9YXDwzX
         BULA==
X-Gm-Message-State: AOAM531JN+QX+CfvGb+avSZDbQgPzWzdrk74Ctz2sK8DaP5JPXuA55Lw
        VU4KEwvTUUsfgFmlQFySJxK58WWJzJaEDYeg9czQ976JVNNT4sglBhrqrLDge9wL6M7yrLJZNZq
        uxuwz/NLaiyxA0hH/kYFwp3MKGWiCSQ==
X-Received: by 2002:a92:358b:: with SMTP id c11mr13334164ilf.305.1611850642723;
        Thu, 28 Jan 2021 08:17:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXRVKkWU+ASLPWgeU5gL8fF7xCAiBTAgC12qWAiH5/nqd6FGmSEQ3n97e9J3Cd5lbQs6y/QQ==
X-Received: by 2002:a92:358b:: with SMTP id c11mr13334147ilf.305.1611850642504;
        Thu, 28 Jan 2021 08:17:22 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:52bc:7bc4:5d05:b6a5])
        by smtp.gmail.com with ESMTPSA id y11sm2796979ilv.64.2021.01.28.08.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:17:21 -0800 (PST)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Accept any valid fd in user_notification_addfd
Date:   Thu, 28 Jan 2021 10:17:21 -0600
Message-Id: <20210128161721.99150-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test expects fds to have specific values, which works fine
when the test is run standalone. However, the kselftest runner
consumes a couple of extra fds for redirection when running
tests, so the test fails when run via kselftest.

Change the test to pass on any valid fd number.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 26c72f2b61b1..9338df6f4ca8 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4019,18 +4019,14 @@ TEST(user_notification_addfd)
 
 	/* Verify we can set an arbitrary remote fd */
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
-	/*
-	 * The child has fds 0(stdin), 1(stdout), 2(stderr), 3(memfd),
-	 * 4(listener), so the newly allocated fd should be 5.
-	 */
-	EXPECT_EQ(fd, 5);
+	EXPECT_GE(fd, 0);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/* Verify we can set an arbitrary remote fd with large size */
 	memset(&big, 0x0, sizeof(big));
 	big.addfd = addfd;
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
-	EXPECT_EQ(fd, 6);
+	EXPECT_GE(fd, 0);
 
 	/* Verify we can set a specific remote fd */
 	addfd.newfd = 42;
-- 
2.29.2

