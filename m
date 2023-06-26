Return-Path: <bpf+bounces-3414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AED73D5EE
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 04:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E981C20443
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 02:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359FC81F;
	Mon, 26 Jun 2023 02:39:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C77F
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 02:39:00 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49F310CF
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 19:38:35 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a04e5baffcso2498813b6e.3
        for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 19:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687747114; x=1690339114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HewVP/TT0M2VFIvYbhqV6pFKN27B5G0/3KqOapXtxqo=;
        b=rnW2YVPlQFNUq4CrhGYU6l/3nrRboreuXRAHyGPnYiH30T98EmR7CTf6YIzH7V7a0l
         iNS854y3XFrTjgi5jVOxaHuY1YE6OExpvXXDfEoH485sp6pCnn4p/iot1yPgz5l0Exjz
         XkPrHWCj5In564mcKOTi7H0Ud3WFS9NzGXtSqNjIxU1e/QwPAhcFSFmA4vnJRpNSTYkR
         57nru6bZ0g92mYnxQjJTElH9OHOghb4FUIOIqyw/szlJ8IE++/zBwZXCrOufmrGLRxVL
         dllcscQZH5+EL+zwy+eGwlVyuSoquj3BV4L20xhocjnKXHNO5SN/KEZnoKd5i3VpTDSp
         gJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687747114; x=1690339114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HewVP/TT0M2VFIvYbhqV6pFKN27B5G0/3KqOapXtxqo=;
        b=d4rXx3fNoimFdSU6Ofn/jcPD+Ok9VRelxA6pH3f70N8Vkt6AVLnYNjMMkLq6dS67yn
         OhkkMdNPa9E5PSmqYytx2v+IHEQAwGnAgWxWF/HjQrYs9DzSiJgkgr2mDInzgso47NQg
         dwXon/jNMzqxZZdU/3Kpfmd27s+RAG6UamQwRdJTdc9kUujYCaIKtKss2G/qK9nUtARR
         EuDMUIDDz9hwFakn21DIzmBwTwH3h2VVGvLKz3mv64ArPF0XjTlpvwIvnKOKi7fTJKpH
         ULWegs/PVyhdRBvmgUrEIUtyI7Cpy44lE5nSrqDdW6HYLj8htitdjwUHbLn8GnZNCgMF
         2Jaw==
X-Gm-Message-State: AC+VfDyDNhnQ1EMFegMUCu9NImBnKQmrnesupws2VJyfELC8qMc73S6g
	4U/RawlRHmalW5L7aEGHbPRHGrw2AYU=
X-Google-Smtp-Source: ACHHUZ5HmeKcxr2viU/G5oENZEVig+n/joZJ+K1fmLqk7Lj7Pkz78dBapmLnhp3kKjpRpumeNIRWkQ==
X-Received: by 2002:a54:401a:0:b0:3a1:e219:8cdb with SMTP id x26-20020a54401a000000b003a1e2198cdbmr725348oie.40.1687747113743;
        Sun, 25 Jun 2023 19:38:33 -0700 (PDT)
Received: from carlos-desktop.lan ([2600:8800:7280:a54d::813])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a031600b00262ffa796d7sm73951pje.42.2023.06.25.19.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 19:38:33 -0700 (PDT)
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
To: bpf@vger.kernel.org
Cc: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
Subject: [PATCH] libbpf: provide num present cpus
Date: Sun, 25 Jun 2023 19:34:08 -0700
Message-ID: <20230626023731.115783-1-carlosrodrifernandez@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It allows tools to iterate over CPUs present
in the system that are actually running processes,
which can be less than the number of possible CPUs.

Signed-off-by: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
---
 src/libbpf.c | 32 +++++++++++++++++++++++++++-----
 src/libbpf.h |  8 +++++---
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/src/libbpf.c b/src/libbpf.c
index 214f828..e42d252 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -12615,14 +12615,26 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz)
 	return parse_cpu_mask_str(buf, mask, mask_sz);
 }
 
-int libbpf_num_possible_cpus(void)
+typedef enum {POSSIBLE=0, PRESENT, NUM_TYPES } CPU_TOPOLOGY_SYSFS_TYPE;
+
+static const char *cpu_topology_sysfs_path_by_type(const CPU_TOPOLOGY_SYSFS_TYPE type) {
+	const static char *possible_sysfs_path = "/sys/devices/system/cpu/possible";
+	const static char *present_sysfs_path = "/sys/devices/system/cpu/present";
+	switch(type) {
+		case POSSIBLE: return possible_sysfs_path;
+		case PRESENT: return present_sysfs_path;
+		default: return possible_sysfs_path;
+	}
+}
+
+int libbpf_num_cpus_by_topology_sysfs_type(const CPU_TOPOLOGY_SYSFS_TYPE type)
 {
-	static const char *fcpu = "/sys/devices/system/cpu/possible";
-	static int cpus;
+	const char *fcpu = cpu_topology_sysfs_path_by_type(type);
+	static int cpus[NUM_TYPES];
 	int err, n, i, tmp_cpus;
 	bool *mask;
 
-	tmp_cpus = READ_ONCE(cpus);
+	tmp_cpus = READ_ONCE(cpus[type]);
 	if (tmp_cpus > 0)
 		return tmp_cpus;
 
@@ -12637,10 +12649,20 @@ int libbpf_num_possible_cpus(void)
 	}
 	free(mask);
 
-	WRITE_ONCE(cpus, tmp_cpus);
+	WRITE_ONCE(cpus[type], tmp_cpus);
 	return tmp_cpus;
 }
 
+int libbpf_num_possible_cpus(void)
+{
+	return libbpf_num_cpus_by_topology_sysfs_type(POSSIBLE);
+}
+
+int libbpf_num_present_cpus(void)
+{
+	return libbpf_num_cpus_by_topology_sysfs_type(PRESENT);
+}
+
 static int populate_skeleton_maps(const struct bpf_object *obj,
 				  struct bpf_map_skeleton *maps,
 				  size_t map_cnt)
diff --git a/src/libbpf.h b/src/libbpf.h
index 754da73..a34152c 100644
--- a/src/libbpf.h
+++ b/src/libbpf.h
@@ -1433,9 +1433,10 @@ LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
 				       enum bpf_func_id helper_id, const void *opts);
 
 /**
- * @brief **libbpf_num_possible_cpus()** is a helper function to get the
- * number of possible CPUs that the host kernel supports and expects.
- * @return number of possible CPUs; or error code on failure
+ * @brief **libbpf_num_possible_cpus()**, and **libbpf_num_present_cpus()**
+ * are helper functions to get the number of possible, and present CPUs respectivelly.
+ * See for more information: https://www.kernel.org/doc/html/latest/admin-guide/cputopology.html
+ * @return number of CPUs; or error code on failure
  *
  * Example usage:
  *
@@ -1447,6 +1448,7 @@ LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
  *     bpf_map_lookup_elem(per_cpu_map_fd, key, values);
  */
 LIBBPF_API int libbpf_num_possible_cpus(void);
+LIBBPF_API int libbpf_num_present_cpus(void);
 
 struct bpf_map_skeleton {
 	const char *name;
-- 
2.41.0


