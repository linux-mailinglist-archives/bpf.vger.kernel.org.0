Return-Path: <bpf+bounces-14869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E47E89F8
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109D51C20AF5
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC96125A6;
	Sat, 11 Nov 2023 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/lCas7O"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D511703
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 09:00:48 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20190449A
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:47 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso1349355fac.0
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699693245; x=1700298045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ke1D6m74mgBawz9JZev+dTdh8Sh2Lm5iPjGvjgkU9M=;
        b=E/lCas7ObQ+ojqf6CDk8kobX0mUafVibaUsq7qDI3ik0hpnuD0wxVmEOl6Fx96WZbc
         TnMBhwdK4zncSaBdhF63pZALt9F25c9wxAm7t9j+QwXgJzpPc5vGLcm5iHbShw2OQlIk
         x0vZBKdTpXJPMWhw9D+trN9Cgu8kqIFV6pHq7/H87r0cS1BXL10sg5Yc9FC31vcPie9t
         e1FDwrP2NKcmSP2kM/aWtHparAHJ2vf9p5HFplK2nhufzlYVcEN6L07bwu/yOzs94Ycs
         6Tjlq6Y8LtkutYywn7069bzaHGNjUwZNxhPwkVM6b46yVzFZlGDwxqtWvQt1mX/v3FPq
         ME8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699693245; x=1700298045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ke1D6m74mgBawz9JZev+dTdh8Sh2Lm5iPjGvjgkU9M=;
        b=RFXVOM1rXbSqXiGNJNxiPmV0eHqyTu3P21wJeav92tKLETax0q5HaSwnQT0A7nn0UQ
         Vzu68ljhBnEKRc4XG+uBTUiHfk3lP3OdHPmFohiTy2XFGvAlHcEoCzhTxmh/bqBkCdKV
         mRQ9g8S7qSRDJg6HtK725vS6baTXkzL+98xy7GC6jZkc2V+hs+tJP7OCVrI1ltQVLyNj
         uXrECO/5tAW+Z/Yr6rX1dctqenplLF72ll2X4tVyUDmjBe8fk/aTiM1GDVCzhCGtEDLi
         OWVNnwMUNtMjz/tw+NVqZxusB8wRgIKdAcGQSQRNkUyiaWFoF35n/WUdTZrWzqv1ysYe
         yLtw==
X-Gm-Message-State: AOJu0Yyau4xJoedL1fOqMxRt7s9NK5PWxDgfRuwLojMevCVbdBp5sSMY
	FVTkqbRTrY3mkTiKrXR8Df0=
X-Google-Smtp-Source: AGHT+IF0uk65x9Da5U2Xo1vDPKYrqnyIDHNk4FXfFcgSwHNBM+D9uqWSJf/Qs9KmNiKCFXl90dVnrg==
X-Received: by 2002:a05:6871:448e:b0:1ef:15f5:1733 with SMTP id ne14-20020a056871448e00b001ef15f51733mr1785033oab.25.1699693244858;
        Sat, 11 Nov 2023 01:00:44 -0800 (PST)
Received: from vultr.guest ([45.63.84.83])
        by smtp.gmail.com with ESMTPSA id fh38-20020a056a00392600b006b2e07a6235sm894254pfb.136.2023.11.11.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:00:44 -0800 (PST)
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
Subject: [PATCH v4 bpf-next 4/6] selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
Date: Sat, 11 Nov 2023 09:00:32 +0000
Message-Id: <20231111090034.4248-5-laoar.shao@gmail.com>
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

Introduce a new helper function to retrieve the cgroup ID from a net_cls
cgroup directory.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 28 ++++++++++++++++++++++------
 tools/testing/selftests/bpf/cgroup_helpers.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index f18649a..63bfa72 100644
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
index 92fc41d..e71da4e 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -31,6 +31,7 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 /* cgroupv1 related */
 int set_classid(void);
 int join_classid(void);
+unsigned long long get_classid_cgroup_id(void);
 
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
-- 
1.8.3.1


