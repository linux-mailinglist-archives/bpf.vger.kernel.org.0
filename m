Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73054295F3
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbfEXKg7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 06:36:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42638 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbfEXKg7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 06:36:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so9472963wrb.9
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FN7+F07jk0cXNHqGvnexqRvbRQXxEOlEcuIDe3AGnZ8=;
        b=pBaYKQMzs9hg01nElyXzAh0eMZto0VWjL5pgLWbWLvTOCkFfFWcsjPtQCGAbCAlktf
         HIsetFcEwyT6Nxj+ZolvMTMHJE6mQbb8INeyX7DFqWnAn7Ng5yHgeSVMGpFTfXdQ7eB0
         58tvhCrR3LF7YiQCVgXe+mfHxY5tEv8u0mLL138n1cUBPZCRSlzxHAN8dJNUGMBhowu1
         4GxSvMNRfdVWNrszmhb40wA3bvKthidVJeHjuiWjpslYS4I9+fuL6Mn3xeE3RGjfZeg5
         FhQUI3CoF/mKAcuNphMZuOs20feeyW0qFKLODKkJLtqS3/k/oQkSriCkdNR26UMdTw3Z
         lN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FN7+F07jk0cXNHqGvnexqRvbRQXxEOlEcuIDe3AGnZ8=;
        b=Qyt/bgpnMWyYYEq/0DqarfaF3CI23UHnbn72eMXAvX0E7N3qzHzMLk5FWv6q65DISv
         wpuWCTdjWMkHr6facEV31WpBagcKlc6Fi2pyEYXbbbefolnvLjMSi8LciubM88qggu7+
         fi0RyNcpw1Pa4OW/FWA9vQrQUW2nKCMqNQn9pCoR779EK2VIDB9Wjlj4kJYPbZa60YUo
         nZh/Mr751P07TGt1+iurvLmgFpNw5Jg3hhDw5gzU1slymTf1l/YQcJlZyMvgC34LPb0c
         UO+JKHSRuP9L4ytZ6e1m6A24mJbbm2lNjFYvJmFFiWTMEYUR4qzuwzCN6wIv/4emyL4D
         APkw==
X-Gm-Message-State: APjAAAUO4yqYyBYIxuwjUgA1bgTuc+/vlyArt2FFa9qKKvnUwJv+L6bv
        AwcWc1XIhIW8T1On1i8UUx24rg==
X-Google-Smtp-Source: APXvYqz2TllmKCt2qz2BULfMEXyPJJuPYBdnOQ/jxdMSxfkcg+vz4kpOG9c1jYbMGQYuOUvh1vExJA==
X-Received: by 2002:adf:d4c2:: with SMTP id w2mr933500wrk.167.1558694216465;
        Fri, 24 May 2019 03:36:56 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id g2sm1955759wru.37.2019.05.24.03.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:36:55 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v3 2/3] libbpf: add bpf_object__load_xattr() API function to pass log_level
Date:   Fri, 24 May 2019 11:36:47 +0100
Message-Id: <20190524103648.15669-3-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524103648.15669-1-quentin.monnet@netronome.com>
References: <20190524103648.15669-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf was recently made aware of the log_level attribute for programs,
used to specify the level of information expected to be dumped by the
verifier. Function bpf_prog_load_xattr() got support for this log_level
parameter.

But some applications using libbpf rely on another function to load
programs, bpf_object__load(), which does accept any parameter for log
level. Create an API function based on bpf_object__load(), but accepting
an "attr" object as a parameter. Then add a log_level field to that
object, so that applications calling the new bpf_object__load_xattr()
can pick the desired log level.

v3:
- Rewrite commit log.

v2:
- We are in a new cycle, bump libbpf extraversion number.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/lib/bpf/Makefile   |  2 +-
 tools/lib/bpf/libbpf.c   | 20 +++++++++++++++++---
 tools/lib/bpf/libbpf.h   |  6 ++++++
 tools/lib/bpf/libbpf.map |  5 +++++
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index a2aceadf68db..9312066a1ae3 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -3,7 +3,7 @@
 
 BPF_VERSION = 0
 BPF_PATCHLEVEL = 0
-BPF_EXTRAVERSION = 3
+BPF_EXTRAVERSION = 4
 
 MAKEFLAGS += --no-print-directory
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 197b574406b3..1c6fb7a3201e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2222,7 +2222,7 @@ static bool bpf_program__is_function_storage(struct bpf_program *prog,
 }
 
 static int
-bpf_object__load_progs(struct bpf_object *obj)
+bpf_object__load_progs(struct bpf_object *obj, int log_level)
 {
 	size_t i;
 	int err;
@@ -2230,6 +2230,7 @@ bpf_object__load_progs(struct bpf_object *obj)
 	for (i = 0; i < obj->nr_programs; i++) {
 		if (bpf_program__is_function_storage(&obj->programs[i], obj))
 			continue;
+		obj->programs[i].log_level = log_level;
 		err = bpf_program__load(&obj->programs[i],
 					obj->license,
 					obj->kern_version);
@@ -2381,10 +2382,14 @@ int bpf_object__unload(struct bpf_object *obj)
 	return 0;
 }
 
-int bpf_object__load(struct bpf_object *obj)
+int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 {
+	struct bpf_object *obj;
 	int err;
 
+	if (!attr)
+		return -EINVAL;
+	obj = attr->obj;
 	if (!obj)
 		return -EINVAL;
 
@@ -2397,7 +2402,7 @@ int bpf_object__load(struct bpf_object *obj)
 
 	CHECK_ERR(bpf_object__create_maps(obj), err, out);
 	CHECK_ERR(bpf_object__relocate(obj), err, out);
-	CHECK_ERR(bpf_object__load_progs(obj), err, out);
+	CHECK_ERR(bpf_object__load_progs(obj, attr->log_level), err, out);
 
 	return 0;
 out:
@@ -2406,6 +2411,15 @@ int bpf_object__load(struct bpf_object *obj)
 	return err;
 }
 
+int bpf_object__load(struct bpf_object *obj)
+{
+	struct bpf_object_load_attr attr = {
+		.obj = obj,
+	};
+
+	return bpf_object__load_xattr(&attr);
+}
+
 static int check_path(const char *path)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c5ff00515ce7..e1c748db44f6 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -89,8 +89,14 @@ LIBBPF_API int bpf_object__unpin_programs(struct bpf_object *obj,
 LIBBPF_API int bpf_object__pin(struct bpf_object *object, const char *path);
 LIBBPF_API void bpf_object__close(struct bpf_object *object);
 
+struct bpf_object_load_attr {
+	struct bpf_object *obj;
+	int log_level;
+};
+
 /* Load/unload object into/from kernel */
 LIBBPF_API int bpf_object__load(struct bpf_object *obj);
+LIBBPF_API int bpf_object__load_xattr(struct bpf_object_load_attr *attr);
 LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
 LIBBPF_API const char *bpf_object__name(struct bpf_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(struct bpf_object *obj);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 673001787cba..6ce61fa0baf3 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -164,3 +164,8 @@ LIBBPF_0.0.3 {
 		bpf_map_freeze;
 		btf__finalize_data;
 } LIBBPF_0.0.2;
+
+LIBBPF_0.0.4 {
+	global:
+		bpf_object__load_xattr;
+} LIBBPF_0.0.3;
-- 
2.17.1

