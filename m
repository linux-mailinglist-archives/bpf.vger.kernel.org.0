Return-Path: <bpf+bounces-14868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A47E89F9
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF120B20DCE
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC272747D;
	Sat, 11 Nov 2023 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvyZNZrq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898CB11703
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 09:00:45 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405384496
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:44 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b40d5ea323so1715313b6e.0
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699693243; x=1700298043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WGPpwvnjBN7lnD2fLR5fUdnGAqoZjDwFnJqTNXRdHE=;
        b=BvyZNZrqHx+ELwLD5+eKkahCKTZlpto/JczB8pfqPGyuiPeWcEZzRq0eNGoZua1rUL
         RVOoOwlK705pg1hKN8BBoHyK9Gz1QGki/ADl24UTX61smDM9kYKfBoJOd2XpBHSkt/Rr
         2a20peKcRItQ3rZW9++n1H88c3zELkDBcIhv+JHTuBWSuCgoiSEjmxmwJ6UOlCXV+/aD
         VbR5BGy/NCC7QyW/9XAqlv8dBGNYihkV9Tf07piTCnoykdJRY9P0Lr5CYtE59gaFl2Q0
         n3vopNjnfBZ6OJuXjZRcapw+kfuOmJD5GhCX+ZweIhCYCKrHTOuZHPRgrG2upax4zbMp
         KC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699693243; x=1700298043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WGPpwvnjBN7lnD2fLR5fUdnGAqoZjDwFnJqTNXRdHE=;
        b=BROR+EfF8b3d06vxq5O0oEOyQGabXow3vrGRRB+8pBzJdUZN+LHJQzirV1xGhMA93z
         lc1i0dQvrXHoRoAAoE6HDP3ZoXtD4oBlpwpRvxSZeUel1VEdfbhoG1p5JKDP2drIJvn2
         TRAtv6Mk6CNlPd2f2CxPFeztRUvWh6ceS0iTRPtp5KycDrNKk5YII/hrZkhEwrqSRF7y
         /5o5PfqNSUBAY6EVcLe9JL5Oo02pEVIMGpWCyhamtjhjxAlmh57hmElXaTBfVdmUiC/Q
         3OSa8ShJK0iBh3YXB6OxFRnjV6pVgsjpSt22jQA2hVhoNWZW1QcZWEX6zwWdrT/CPIFC
         lyzA==
X-Gm-Message-State: AOJu0YzGLe9jY5A3FGrOmte+HaI81lw9QemrLiVD17YZguURjh73Mzf9
	kulYWgYyMIrO/WudHkPcCLc=
X-Google-Smtp-Source: AGHT+IHoiUCK69uH7BxSm5yE7R5zg+brnHlnDyZKucfHRDFY8auk8viLRK3iOAsJi495Focv3T0UdQ==
X-Received: by 2002:a05:6808:3193:b0:3b2:e520:dfab with SMTP id cd19-20020a056808319300b003b2e520dfabmr2188080oib.44.1699693243488;
        Sat, 11 Nov 2023 01:00:43 -0800 (PST)
Received: from vultr.guest ([45.63.84.83])
        by smtp.gmail.com with ESMTPSA id fh38-20020a056a00392600b006b2e07a6235sm894254pfb.136.2023.11.11.01.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:00:43 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 3/6] selftests/bpf: Add parallel support for classid
Date: Sat, 11 Nov 2023 09:00:31 +0000
Message-Id: <20231111090034.4248-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231111090034.4248-1-laoar.shao@gmail.com>
References: <20231111090034.4248-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include the current pid in the classid cgroup path. This way, different
testers relying on classid-based configurations will have distinct classid
cgroup directories, enabling them to run concurrently. Additionally, we
leverage the current pid as the classid, ensuring unique identification.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c         | 18 +++++++++++-------
 tools/testing/selftests/bpf/cgroup_helpers.h         |  2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c |  2 +-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 10b5f42..f18649a 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -45,9 +45,12 @@
 #define format_parent_cgroup_path(buf, path) \
 	format_cgroup_path_pid(buf, path, getppid())
 
-#define format_classid_path(buf)				\
-	snprintf(buf, sizeof(buf), "%s%s", NETCLS_MOUNT_PATH,	\
-		 CGROUP_WORK_DIR)
+#define format_classid_path_pid(buf, pid)				\
+	snprintf(buf, sizeof(buf), "%s%s%d", NETCLS_MOUNT_PATH,	\
+		 CGROUP_WORK_DIR, pid)
+
+#define format_classid_path(buf)	\
+	format_classid_path_pid(buf, getpid())
 
 static __thread bool cgroup_workdir_mounted;
 
@@ -551,15 +554,16 @@ int setup_classid_environment(void)
 
 /**
  * set_classid() - Set a cgroupv1 net_cls classid
- * @id: the numeric classid
  *
- * Writes the passed classid into the cgroup work dir's net_cls.classid
+ * Writes the classid into the cgroup work dir's net_cls.classid
  * file in order to later on trigger socket tagging.
  *
+ * We leverage the current pid as the classid, ensuring unique identification.
+ *
  * On success, it returns 0, otherwise on failure it returns 1. If there
  * is a failure, it prints the error to stderr.
  */
-int set_classid(unsigned int id)
+int set_classid(void)
 {
 	char cgroup_workdir[PATH_MAX - 42];
 	char cgroup_classid_path[PATH_MAX + 1];
@@ -575,7 +579,7 @@ int set_classid(unsigned int id)
 		return 1;
 	}
 
-	if (dprintf(fd, "%u\n", id) < 0) {
+	if (dprintf(fd, "%u\n", getpid()) < 0) {
 		log_err("Setting cgroup classid");
 		rc = 1;
 	}
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 5c2cb9c..92fc41d 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -29,7 +29,7 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 void cleanup_cgroup_environment(void);
 
 /* cgroupv1 related */
-int set_classid(unsigned int id);
+int set_classid(void);
 int join_classid(void);
 
 int setup_classid_environment(void);
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index 9026b42..addf720 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -71,7 +71,7 @@ void test_cgroup_v1v2(void)
 	}
 	ASSERT_OK(run_test(cgroup_fd, server_fd, false), "cgroup-v2-only");
 	setup_classid_environment();
-	set_classid(42);
+	set_classid();
 	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "cgroup-v1v2");
 	cleanup_classid_environment();
 	close(server_fd);
-- 
1.8.3.1


