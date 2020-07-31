Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9150234D6C
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 00:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgGaWJ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 18:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaWJ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 18:09:27 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AB2C06174A
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 15:09:27 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d18so33146209ion.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 15:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vhT4okOquxC+IaMaNd3ePpk5fU36BRjrTjIPvVTOVF4=;
        b=kHMQOyWXPy0ppJNejsw/PofHqavJjZaVAq3tjSXCb1HDjtrylza2Neyi3TS6MKxfzW
         ks2fRK/lYtkXhhKLGgSQ8lNafWITM8S6sgUbClUWuPLCXhr/X4UrPNBiqn5+K8VOiCrH
         TfwpUzxVkG+rhVAaV/5qP1yjM80jdV1QxO+DAkobHVNq/X3lpZW27TK/h+fcEKHqoVqA
         +1KWPJ8ZLbPCQHNwEpBsB7FKcMscFZO2F3cStD5qTq7I+uFfxOxv1OxNEXqAu1d6iXue
         jY65nlhTrT0EvJv4uByXBy4P9McF8zmBSMi7B2DCw5/LViboUQU3u1BySA1Ski0we0tQ
         Eddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vhT4okOquxC+IaMaNd3ePpk5fU36BRjrTjIPvVTOVF4=;
        b=IAO6uYkhTvQKAhYaStvq9vNfn7cRjSRaeuKHwdXfAFcFspcRUgue369MNROn7Irjvh
         43k2Sp7NlNutretqBtTQQNa6iWAlUuAOnpf8v97ZvMQO4yvGaS1GbqVeN4ROK2OMX0YM
         aGvY49Xfi10bYZd1LGrhYJBXFNXeyf8CWjYEN3y9dgr3Hed1ee17EqUHrx4R5uRLnVN3
         LEJoEY0G7515RIZ7RLA8zmoI74cxt5Z/OIljO+HgV4bMpy5oYRmvU7SgDogWCnRoqBzA
         DmaMKvwZOlO3cood0cY1lhSxMT2NH2oU716hPPS5hK4Twov8W5LnWynzTVLCX0p1OFPJ
         Gxrg==
X-Gm-Message-State: AOAM532CYp4QP6aiuCDDMerA2GCN5JwGudFSx1Qc3PlLmSSzQ93ohj7K
        QYgbjOVsT6aukXdfXD6TJn5YfjNwCuY=
X-Google-Smtp-Source: ABdhPJzuFfzLDGXd9E2A+hWHFCwhcuDQ+v7xkCEGdOOQ4tERegVUXSlq76/YeHdU6pYtxMrUsKAogA==
X-Received: by 2002:a6b:b555:: with SMTP id e82mr5547458iof.56.1596233366865;
        Fri, 31 Jul 2020 15:09:26 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id s62sm3432023ili.80.2020.07.31.15.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:09:26 -0700 (PDT)
Subject: [bpf-next PATCH] bpf,
 selftests: Use single cgroup helpers for both test_sockmap/progs
From:   John Fastabend <john.fastabend@gmail.com>
To:     andriin@fb.com, john.fastabend@gmail.com, ast@kernel.org,
        daniel@iogearbox.net
Cc:     bpf@vger.kernel.org
Date:   Fri, 31 Jul 2020 15:09:14 -0700
Message-ID: <159623335418.30208.15807461815525100199.stgit@john-XPS-13-9370>
In-Reply-To: <159623300854.30208.15981610185239932416.stgit@john-XPS-13-9370>
References: <159623300854.30208.15981610185239932416.stgit@john-XPS-13-9370>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Nearly every user of cgroup helpers does the same sequence of API calls. So
push these into a single helper cgroup_setup_and_join. The cases that do
a bit of extra logic are test_progs which currently uses an env variable
to decide if it needs to setup the cgroup environment or can use an
existingi environment. And then tests that are doing cgroup tests
themselves. We skip these cases for now.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c       |   23 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h       |    1 +
 tools/testing/selftests/bpf/get_cgroup_id_user.c   |   14 ++----------
 tools/testing/selftests/bpf/test_cgroup_storage.c  |   17 +--------------
 tools/testing/selftests/bpf/test_dev_cgroup.c      |   15 ++-----------
 tools/testing/selftests/bpf/test_netcnt.c          |   17 ++-------------
 .../selftests/bpf/test_skb_cgroup_id_user.c        |    8 +------
 tools/testing/selftests/bpf/test_sock.c            |    8 +------
 tools/testing/selftests/bpf/test_sock_addr.c       |    8 +------
 tools/testing/selftests/bpf/test_sock_fields.c     |   14 +++---------
 tools/testing/selftests/bpf/test_socket_cookie.c   |    8 +------
 tools/testing/selftests/bpf/test_sockmap.c         |   18 ++--------------
 tools/testing/selftests/bpf/test_sysctl.c          |    8 +------
 tools/testing/selftests/bpf/test_tcpbpf_user.c     |    8 +------
 tools/testing/selftests/bpf/test_tcpnotify_user.c  |    8 +------
 15 files changed, 43 insertions(+), 132 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 0fb910df5387..033051717ba5 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -290,3 +290,26 @@ unsigned long long get_cgroup_id(const char *path)
 	free(fhp);
 	return ret;
 }
+
+int cgroup_setup_and_join(const char *path) {
+	int cg_fd;
+
+	if (setup_cgroup_environment()) {
+		fprintf(stderr, "Failed to setup cgroup environment\n");
+		return -EINVAL;
+	}
+
+	cg_fd = create_and_get_cgroup(path);
+	if (cg_fd < 0) {
+		fprintf(stderr, "Failed to create test cgroup\n");
+		cleanup_cgroup_environment();
+		return cg_fd;
+	}
+
+	if (join_cgroup(path)) {
+		fprintf(stderr, "Failed to join cgroup\n");
+		cleanup_cgroup_environment();
+		return -EINVAL;
+	}
+	return cg_fd;
+}
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index d64bb8957090..5fe3d88e4f0d 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -9,6 +9,7 @@
 	__FILE__, __LINE__, clean_errno(), ##__VA_ARGS__)
 
 
+int cgroup_setup_and_join(const char *path);
 int create_and_get_cgroup(const char *path);
 int join_cgroup(const char *path);
 int setup_cgroup_environment(void);
diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
index e8da7b39158d..b8d6aef99db4 100644
--- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
+++ b/tools/testing/selftests/bpf/get_cgroup_id_user.c
@@ -58,20 +58,10 @@ int main(int argc, char **argv)
 	int exit_code = 1;
 	char buf[256];
 
-	err = setup_cgroup_environment();
-	if (CHECK(err, "setup_cgroup_environment", "err %d errno %d\n", err,
-		  errno))
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (CHECK(cgroup_fd < 0, "cgroup_setup_and_join", "err %d errno %d\n", cgroup_fd, errno))
 		return 1;
 
-	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
-	if (CHECK(cgroup_fd < 0, "create_and_get_cgroup", "err %d errno %d\n",
-		  cgroup_fd, errno))
-		goto cleanup_cgroup_env;
-
-	err = join_cgroup(TEST_CGROUP);
-	if (CHECK(err, "join_cgroup", "err %d errno %d\n", err, errno))
-		goto cleanup_cgroup_env;
-
 	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "bpf_prog_load", "err %d errno %d\n", err, errno))
 		goto cleanup_cgroup_env;
diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
index 655729004391..d946252a25bb 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -74,22 +74,7 @@ int main(int argc, char **argv)
 		goto out;
 	}
 
-	if (setup_cgroup_environment()) {
-		printf("Failed to setup cgroup environment\n");
-		goto err;
-	}
-
-	/* Create a cgroup, get fd, and join it */
-	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
-	if (cgroup_fd < 0) {
-		printf("Failed to create test cgroup\n");
-		goto err;
-	}
-
-	if (join_cgroup(TEST_CGROUP)) {
-		printf("Failed to join cgroup\n");
-		goto err;
-	}
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
 
 	/* Attach the bpf program */
 	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c b/tools/testing/selftests/bpf/test_dev_cgroup.c
index d850fb9076b5..804dddd97d4c 100644
--- a/tools/testing/selftests/bpf/test_dev_cgroup.c
+++ b/tools/testing/selftests/bpf/test_dev_cgroup.c
@@ -33,21 +33,10 @@ int main(int argc, char **argv)
 		goto out;
 	}
 
-	if (setup_cgroup_environment()) {
-		printf("Failed to load DEV_CGROUP program\n");
-		goto err;
-	}
-
-	/* Create a cgroup, get fd, and join it */
-	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
 	if (cgroup_fd < 0) {
 		printf("Failed to create test cgroup\n");
-		goto err;
-	}
-
-	if (join_cgroup(TEST_CGROUP)) {
-		printf("Failed to join cgroup\n");
-		goto err;
+		goto out;
 	}
 
 	/* Attach bpf program */
diff --git a/tools/testing/selftests/bpf/test_netcnt.c b/tools/testing/selftests/bpf/test_netcnt.c
index 7a68c9069639..a7b9a69f4fd5 100644
--- a/tools/testing/selftests/bpf/test_netcnt.c
+++ b/tools/testing/selftests/bpf/test_netcnt.c
@@ -58,22 +58,9 @@ int main(int argc, char **argv)
 		goto out;
 	}
 
-	if (setup_cgroup_environment()) {
-		printf("Failed to load bpf program\n");
-		goto err;
-	}
-
-	/* Create a cgroup, get fd, and join it */
-	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
-	if (cgroup_fd < 0) {
-		printf("Failed to create test cgroup\n");
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (cgroup_fd < 0)
 		goto err;
-	}
-
-	if (join_cgroup(TEST_CGROUP)) {
-		printf("Failed to join cgroup\n");
-		goto err;
-	}
 
 	/* Attach bpf program */
 	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
index 356351c0ac28..4a64306728ab 100644
--- a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
+++ b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
@@ -160,16 +160,10 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	if (setup_cgroup_environment())
-		goto err;
-
-	cgfd = create_and_get_cgroup(CGROUP_PATH);
+	cgfd = cgroup_setup_and_join(CGROUP_PATH);
 	if (cgfd < 0)
 		goto err;
 
-	if (join_cgroup(CGROUP_PATH))
-		goto err;
-
 	if (send_packet(argv[1]))
 		goto err;
 
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
index 52bf14955797..9613f7538840 100644
--- a/tools/testing/selftests/bpf/test_sock.c
+++ b/tools/testing/selftests/bpf/test_sock.c
@@ -464,16 +464,10 @@ int main(int argc, char **argv)
 	int cgfd = -1;
 	int err = 0;
 
-	if (setup_cgroup_environment())
-		goto err;
-
-	cgfd = create_and_get_cgroup(CG_PATH);
+	cgfd = cgroup_setup_and_join(CG_PATH);
 	if (cgfd < 0)
 		goto err;
 
-	if (join_cgroup(CG_PATH))
-		goto err;
-
 	if (run_tests(cgfd))
 		goto err;
 
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 0358814c67dc..b8c72c1d9cf7 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -1638,16 +1638,10 @@ int main(int argc, char **argv)
 		exit(err);
 	}
 
-	if (setup_cgroup_environment())
-		goto err;
-
-	cgfd = create_and_get_cgroup(CG_PATH);
+	cgfd = cgroup_setup_and_join(CG_PATH);
 	if (cgfd < 0)
 		goto err;
 
-	if (join_cgroup(CG_PATH))
-		goto err;
-
 	if (run_tests(cgfd))
 		goto err;
 
diff --git a/tools/testing/selftests/bpf/test_sock_fields.c b/tools/testing/selftests/bpf/test_sock_fields.c
index f0fc103261a4..6c9f269c396d 100644
--- a/tools/testing/selftests/bpf/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/test_sock_fields.c
@@ -421,19 +421,11 @@ int main(int argc, char **argv)
 	struct bpf_object *obj;
 	struct bpf_map *map;
 
-	err = setup_cgroup_environment();
-	CHECK(err, "setup_cgroup_environment()", "err:%d errno:%d",
-	      err, errno);
-
-	atexit(cleanup_cgroup_environment);
-
 	/* Create a cgroup, get fd, and join it */
-	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
-	CHECK(cgroup_fd == -1, "create_and_get_cgroup()",
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	CHECK(cgroup_fd < 0, "cgroup_setup_and_join()",
 	      "cgroup_fd:%d errno:%d", cgroup_fd, errno);
-
-	err = join_cgroup(TEST_CGROUP);
-	CHECK(err, "join_cgroup", "err:%d errno:%d", err, errno);
+	atexit(cleanup_cgroup_environment);
 
 	err = bpf_prog_load_xattr(&attr, &obj, &egress_fd);
 	CHECK(err, "bpf_prog_load_xattr()", "err:%d", err);
diff --git a/tools/testing/selftests/bpf/test_socket_cookie.c b/tools/testing/selftests/bpf/test_socket_cookie.c
index 15653b0e26eb..154a8fd2a48d 100644
--- a/tools/testing/selftests/bpf/test_socket_cookie.c
+++ b/tools/testing/selftests/bpf/test_socket_cookie.c
@@ -191,16 +191,10 @@ int main(int argc, char **argv)
 	int cgfd = -1;
 	int err = 0;
 
-	if (setup_cgroup_environment())
-		goto err;
-
-	cgfd = create_and_get_cgroup(CG_PATH);
+	cgfd = cgroup_setup_and_join(CG_PATH);
 	if (cgfd < 0)
 		goto err;
 
-	if (join_cgroup(CG_PATH))
-		goto err;
-
 	if (run_test(cgfd))
 		goto err;
 
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 78789b27e573..9b6fb00dc7a0 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1963,23 +1963,9 @@ int main(int argc, char **argv)
 	}
 
 	if (!cg_fd) {
-		if (setup_cgroup_environment()) {
-			fprintf(stderr, "ERROR: cgroup env failed\n");
-			return -EINVAL;
-		}
-
-		cg_fd = create_and_get_cgroup(CG_PATH);
-		if (cg_fd < 0) {
-			fprintf(stderr,
-				"ERROR: (%i) open cg path failed: %s\n",
-				cg_fd, strerror(errno));
+		cg_fd = cgroup_setup_and_join(CG_PATH);
+		if (cg_fd < 0)
 			return cg_fd;
-		}
-
-		if (join_cgroup(CG_PATH)) {
-			fprintf(stderr, "ERROR: failed to join cgroup\n");
-			return -EINVAL;
-		}
 		cg_created = 1;
 	}
 
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index d196e2a4a6e0..a20a919244c0 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -1619,16 +1619,10 @@ int main(int argc, char **argv)
 	int cgfd = -1;
 	int err = 0;
 
-	if (setup_cgroup_environment())
-		goto err;
-
-	cgfd = create_and_get_cgroup(CG_PATH);
+	cgfd = cgroup_setup_and_join(CG_PATH);
 	if (cgfd < 0)
 		goto err;
 
-	if (join_cgroup(CG_PATH))
-		goto err;
-
 	if (run_tests(cgfd))
 		goto err;
 
diff --git a/tools/testing/selftests/bpf/test_tcpbpf_user.c b/tools/testing/selftests/bpf/test_tcpbpf_user.c
index 3ae127620463..74a9e49988b6 100644
--- a/tools/testing/selftests/bpf/test_tcpbpf_user.c
+++ b/tools/testing/selftests/bpf/test_tcpbpf_user.c
@@ -102,16 +102,10 @@ int main(int argc, char **argv)
 	__u32 key = 0;
 	int rv;
 
-	if (setup_cgroup_environment())
-		goto err;
-
-	cg_fd = create_and_get_cgroup(cg_path);
+	cg_fd = cgroup_setup_and_join(cg_path);
 	if (cg_fd < 0)
 		goto err;
 
-	if (join_cgroup(cg_path))
-		goto err;
-
 	if (bpf_prog_load(file, BPF_PROG_TYPE_SOCK_OPS, &obj, &prog_fd)) {
 		printf("FAILED: load_bpf_file failed for: %s\n", file);
 		goto err;
diff --git a/tools/testing/selftests/bpf/test_tcpnotify_user.c b/tools/testing/selftests/bpf/test_tcpnotify_user.c
index f9765ddf0761..8549b31716ab 100644
--- a/tools/testing/selftests/bpf/test_tcpnotify_user.c
+++ b/tools/testing/selftests/bpf/test_tcpnotify_user.c
@@ -86,16 +86,10 @@ int main(int argc, char **argv)
 	CPU_SET(0, &cpuset);
 	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
 
-	if (setup_cgroup_environment())
-		goto err;
-
-	cg_fd = create_and_get_cgroup(cg_path);
+	cg_fd = cgroup_setup_and_join(cg_path);
 	if (cg_fd < 0)
 		goto err;
 
-	if (join_cgroup(cg_path))
-		goto err;
-
 	if (bpf_prog_load(file, BPF_PROG_TYPE_SOCK_OPS, &obj, &prog_fd)) {
 		printf("FAILED: load_bpf_file failed for: %s\n", file);
 		goto err;

