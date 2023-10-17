Return-Path: <bpf+bounces-12415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643937CC39D
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467231C20C2A
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8B42C06;
	Tue, 17 Oct 2023 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8FR086a"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D542BF2
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 12:46:18 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2BDF9;
	Tue, 17 Oct 2023 05:46:17 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so3985345a34.0;
        Tue, 17 Oct 2023 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546776; x=1698151576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcMF4eEIqJtrI/6oP100C5PlEtM9pT5G9D1uUQ99pcY=;
        b=X8FR086aDIzdFh+TNwlQHsMQifG/jJquAA9koPW1KtMMS2P6z/kWBuz6JmMC7PtzTH
         7PU2UzEn+LNUIAPw4yLT0CgVnb2qaxA7D+jX7Zetrq/NOz6BpVPPpbmD2SRcC8140cH1
         WnANBXv1NHs8R8UY4U/rb49gp4dm5LZZ5XUGamAuDsa0cYmglFtMa1915KYx46hSPGqs
         kE72Jl8MHdlm9iwmewKP5UyxpJcB/d0u7O5AxMGVR1S41ryaLyQmTqt/WACYH41uSET8
         k6papRRSGdztgsoq3WdHIgv2rCA7jbLuaqYzJSxgltilrwhl4avquFUW4QfimxFGEBUc
         Cn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546776; x=1698151576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcMF4eEIqJtrI/6oP100C5PlEtM9pT5G9D1uUQ99pcY=;
        b=cLwFXg711XwFuoMQiU+oneM0YhgmP73yIKgYG7/H2giThXHaa3oxXOosMwnaOkHSbh
         Zjcl0XVI9zlf5wmhCCmGIkolSXfuHDL3cxP+MaNTHEMjAL2u2UXugT4g0I82Hh5uhAaI
         enGQCkQwEuzYMSisC5BVSD2T/thVNL2OvZkADRQsrd+XG5oDND3XHXotDFt/URdJL7rj
         640k+AZlYH8uvwvTM6MxK2O0yD2HOT8tpC5NnuyC0S+xY4IJwGqPepKycwPWIdCwZSRa
         Mixsm9l+6fxEuijxK8zPKK5YkGemYvQbzazq0BbAGewqA5h7H3QE+oeRTNRHrLN8pNIW
         t6LQ==
X-Gm-Message-State: AOJu0YzIkxqchmKCZVMyFtWT6V/g1kW8D7stVHugm8lJtY89x0sFuzG+
	iHYY0N5UztpcivThos3a87E=
X-Google-Smtp-Source: AGHT+IFEOCzTu3zygMpFFP6evpcF7YhAzUk0+zEMsq2t5gI/LwmIucYpXdBRbRm3JKngN8XAG7MrWw==
X-Received: by 2002:a9d:66d0:0:b0:6bd:152f:9918 with SMTP id t16-20020a9d66d0000000b006bd152f9918mr2131657otm.14.1697546776497;
        Tue, 17 Oct 2023 05:46:16 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006bdf4dfbe0dsm1375595pfb.12.2023.10.17.05.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:46:16 -0700 (PDT)
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
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	mkoutny@suse.com,
	sinquersw@gmail.com
Cc: cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 7/9] selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
Date: Tue, 17 Oct 2023 12:45:44 +0000
Message-Id: <20231017124546.24608-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017124546.24608-1-laoar.shao@gmail.com>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce a new helper function to retrieve the cgroup ID from a net_cls
cgroup directory.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 28 +++++++++++++++-----
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index f18649a79d64..63bfa72185be 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -422,26 +422,23 @@ int create_and_get_cgroup(const char *relative_path)
 }
 
 /**
- * get_cgroup_id() - Get cgroup id for a particular cgroup path
- * @relative_path: The cgroup path, relative to the workdir, to join
+ * get_cgroup_id_from_path - Get cgroup id for a particular cgroup path
+ * @cgroup_workdir: The absolute cgroup path
  *
  * On success, it returns the cgroup id. On failure it returns 0,
  * which is an invalid cgroup id.
  * If there is a failure, it prints the error to stderr.
  */
-unsigned long long get_cgroup_id(const char *relative_path)
+unsigned long long get_cgroup_id_from_path(const char *cgroup_workdir)
 {
 	int dirfd, err, flags, mount_id, fhsize;
 	union {
 		unsigned long long cgid;
 		unsigned char raw_bytes[8];
 	} id;
-	char cgroup_workdir[PATH_MAX + 1];
 	struct file_handle *fhp, *fhp2;
 	unsigned long long ret = 0;
 
-	format_cgroup_path(cgroup_workdir, relative_path);
-
 	dirfd = AT_FDCWD;
 	flags = 0;
 	fhsize = sizeof(*fhp);
@@ -477,6 +474,14 @@ unsigned long long get_cgroup_id(const char *relative_path)
 	return ret;
 }
 
+unsigned long long get_cgroup_id(const char *relative_path)
+{
+	char cgroup_workdir[PATH_MAX + 1];
+
+	format_cgroup_path(cgroup_workdir, relative_path);
+	return get_cgroup_id_from_path(cgroup_workdir);
+}
+
 int cgroup_setup_and_join(const char *path) {
 	int cg_fd;
 
@@ -621,3 +626,14 @@ void cleanup_classid_environment(void)
 	join_cgroup_from_top(NETCLS_MOUNT_PATH);
 	nftw(cgroup_workdir, nftwfunc, WALK_FD_LIMIT, FTW_DEPTH | FTW_MOUNT);
 }
+
+/**
+ * get_classid_cgroup_id - Get the cgroup id of a net_cls cgroup
+ */
+unsigned long long get_classid_cgroup_id(void)
+{
+	char cgroup_workdir[PATH_MAX + 1];
+
+	format_classid_path(cgroup_workdir);
+	return get_cgroup_id_from_path(cgroup_workdir);
+}
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 92fc41daf4a4..e71da4ef031b 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -31,6 +31,7 @@ void cleanup_cgroup_environment(void);
 /* cgroupv1 related */
 int set_classid(void);
 int join_classid(void);
+unsigned long long get_classid_cgroup_id(void);
 
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
-- 
2.30.1 (Apple Git-130)


