Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A73627555
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 05:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiKNEit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 23:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKNEis (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 23:38:48 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6B55A6;
        Sun, 13 Nov 2022 20:38:45 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9c4z3W5CzRpHV;
        Mon, 14 Nov 2022 12:38:27 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 12:38:43 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <paul@paul-moore.com>,
        Wang Yufen <wangyufen@huawei.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf] selftests/bpf: fix memory leak of lsm_cgroup
Date:   Mon, 14 Nov 2022 12:59:02 +0800
Message-ID: <1668401942-6309-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kmemleak reports this issue:

unreferenced object 0xffff88810b7835c0 (size 32):
  comm "test_progs", pid 270, jiffies 4294969007 (age 1621.315s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    03 00 00 00 03 00 00 00 0f 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000376cdeab>] kmalloc_trace+0x27/0x110
    [<000000003bcdb3b6>] selinux_sk_alloc_security+0x66/0x110
    [<000000003959008f>] security_sk_alloc+0x47/0x80
    [<00000000e7bc6668>] sk_prot_alloc+0xbd/0x1a0
    [<0000000002d6343a>] sk_alloc+0x3b/0x940
    [<000000009812a46d>] unix_create1+0x8f/0x3d0
    [<000000005ed0976b>] unix_create+0xa1/0x150
    [<0000000086a1d27f>] __sock_create+0x233/0x4a0
    [<00000000cffe3a73>] __sys_socket_create.part.0+0xaa/0x110
    [<0000000007c63f20>] __sys_socket+0x49/0xf0
    [<00000000b08753c8>] __x64_sys_socket+0x42/0x50
    [<00000000b56e26b3>] do_syscall_64+0x3b/0x90
    [<000000009b4871b8>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

The issue occurs in the following scenarios:

unix_create1()
  sk_alloc()
    sk_prot_alloc()
      security_sk_alloc()
        call_int_hook()
          hlist_for_each_entry()
            entry1->hook.sk_alloc_security
            <-- selinux_sk_alloc_security() succeeded,
            <-- sk->security alloced here.
            entry2->hook.sk_alloc_security
            <-- bpf_lsm_sk_alloc_security() failed
      goto out_free;
        ...    <-- the sk->security not freed, memleak

The core problem is that the LSM is not yet fully stacked (work is
actively going on in this space) which means that some LSM hooks do
not support multiple LSMs at the same time. To fix, skip the
"EPERM" test when it runs in the environments that already have
non-bpf lsms installed

Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 19 +++++++++++++++----
 tools/testing/selftests/bpf/progs/lsm_cgroup.c      |  8 ++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
index 1102e4f..a927ade 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -173,10 +173,14 @@ static void test_lsm_cgroup_functional(void)
 	ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 4, "total prog count");
 	ASSERT_EQ(query_prog_cnt(cgroup_fd2, NULL), 1, "total prog count");
 
-	/* AF_UNIX is prohibited. */
-
 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
-	ASSERT_LT(fd, 0, "socket(AF_UNIX)");
+	if (skel->kconfig->CONFIG_SECURITY_APPARMOR
+	    || skel->kconfig->CONFIG_SECURITY_SELINUX
+	    || skel->kconfig->CONFIG_SECURITY_SMACK)
+		ASSERT_GE(fd, 0, "socket(AF_UNIX)");
+	else
+		/* AF_UNIX is prohibited. */
+		ASSERT_LT(fd, 0, "socket(AF_UNIX)");
 	close(fd);
 
 	/* AF_INET6 gets default policy (sk_priority). */
@@ -233,11 +237,18 @@ static void test_lsm_cgroup_functional(void)
 
 	/* AF_INET6+SOCK_STREAM
 	 * AF_PACKET+SOCK_RAW
+	 * AF_UNIX+SOCK_RAW if already have non-bpf lsms installed
 	 * listen_fd
 	 * client_fd
 	 * accepted_fd
 	 */
-	ASSERT_EQ(skel->bss->called_socket_post_create2, 5, "called_create2");
+	if (skel->kconfig->CONFIG_SECURITY_APPARMOR
+	    || skel->kconfig->CONFIG_SECURITY_SELINUX
+	    || skel->kconfig->CONFIG_SECURITY_SMACK)
+		/* AF_UNIX+SOCK_RAW if already have non-bpf lsms installed */
+		ASSERT_EQ(skel->bss->called_socket_post_create2, 6, "called_create2");
+	else
+		ASSERT_EQ(skel->bss->called_socket_post_create2, 5, "called_create2");
 
 	/* start_server
 	 * bind(ETH_P_ALL)
diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
index 4f2d60b..02c11d1 100644
--- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -7,6 +7,10 @@
 
 char _license[] SEC("license") = "GPL";
 
+extern bool CONFIG_SECURITY_SELINUX __kconfig __weak;
+extern bool CONFIG_SECURITY_SMACK __kconfig __weak;
+extern bool CONFIG_SECURITY_APPARMOR __kconfig __weak;
+
 #ifndef AF_PACKET
 #define AF_PACKET 17
 #endif
@@ -140,6 +144,10 @@ int BPF_PROG(socket_bind2, struct socket *sock, struct sockaddr *address,
 int BPF_PROG(socket_alloc, struct sock *sk, int family, gfp_t priority)
 {
 	called_socket_alloc++;
+	/* if already have non-bpf lsms installed, EPERM will cause memory leak of non-bpf lsms */
+	if (CONFIG_SECURITY_SELINUX || CONFIG_SECURITY_SMACK || CONFIG_SECURITY_APPARMOR)
+		return 1;
+
 	if (family == AF_UNIX)
 		return 0; /* EPERM */
 
-- 
1.8.3.1

