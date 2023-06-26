Return-Path: <bpf+bounces-3463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B339E73E390
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7352A280DAE
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84993C2CE;
	Mon, 26 Jun 2023 15:38:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE61C2C1
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 15:38:42 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B3910F9
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 08:38:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8033987baso7635965ad.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687793913; x=1690385913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HewVP/TT0M2VFIvYbhqV6pFKN27B5G0/3KqOapXtxqo=;
        b=eEIyXZYCry7SriYEOyE519OyRW4f8w/aDmCO5BTcziU+4rnoUehrr6gK6yaJ4/rWyx
         ddaJGy7/8cTrVjL/hy5Zm04gKYBg1oS0vcC6n5CRVh8tEFx12mJjy0jJA9y75U/OQRMp
         SmjlrinEmC1rcdIVsLaviu7kjH6+CIVsBcnMkJQZJo0JQagg+8e2XkwX4IHIDcO3Ud6D
         3ZCDSVIl3sUxFgG2AjqJaEC/Y233pxdOG/9Ij513+RDb+YdVsX5ewYmDkIsrrReEpU/f
         fF5EsiLEdXNJqIFjp7F2d2qGWFoFiG26/t3CrsKn7Ro63PvEoLJReoIvllYv4QtDDhJd
         0JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793913; x=1690385913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HewVP/TT0M2VFIvYbhqV6pFKN27B5G0/3KqOapXtxqo=;
        b=CtZHb+VcOnQTO5djoim69YpysoDGj4RmT2l1GDfUNJP7MtNzy0mY/cKG4HaJPLwmi2
         s7ySWZ4jj8H6ryw1eD26mH5w8UsI36dVCu8dQ6zLi9TDwYyE8alHBV/v8v5UMbC/veVM
         aZnPccr9UIVRa48fV9Lb/ShHMcwIHCBuMIqtoGgSlmIwzVVZuJeNTZse3xUqeKTycZeP
         GXcOxQNKLJcCXU3HEu+BQ8ag1QqAjXTUi/A5d25rmZx2xsRImwIOmjq5ergOXkDhHjzi
         0D2VWz+kwglIHcXah/VuXi59N18x/b0ccD6jVSFwh2xo6vtL4UjD7GkoxECbjNOtsIP5
         Zh/A==
X-Gm-Message-State: AC+VfDyFhmOJlpJKA43mu6bZnLf2o/MQ2/dljfSvvPnma+EPfK56Dza0
	teT5NQQuJLn/sx1qaZrQ8tvvtsDgLyI=
X-Google-Smtp-Source: ACHHUZ4h4V9uh4viNZxGKFF/LlCssbGxLxFV1BL8bBrfejFQIJuGw+icft2xG/DkCV/D7l5jpByMkQ==
X-Received: by 2002:a17:903:1245:b0:1af:e302:123 with SMTP id u5-20020a170903124500b001afe3020123mr10901908plh.3.1687793913126;
        Mon, 26 Jun 2023 08:38:33 -0700 (PDT)
Received: from carlos-desktop.lan ([2600:8800:7280:a54d::813])
        by smtp.gmail.com with ESMTPSA id m23-20020a170902bb9700b001b1a2c14a4asm4363673pls.38.2023.06.26.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:38:32 -0700 (PDT)
From: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
To: bpf@vger.kernel.org
Cc: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
Subject: [PATCH 1/2] libbpf: provide num present cpus
Date: Mon, 26 Jun 2023 08:37:50 -0700
Message-ID: <20230626153819.134831-1-carlosrodrifernandez@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626023731.115783-1-carlosrodrifernandez@gmail.com>
References: <20230626023731.115783-1-carlosrodrifernandez@gmail.com>
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


