Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B337438568
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhJWUy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Oct 2021 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhJWUy0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Oct 2021 16:54:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935FC061220
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:52:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j205so5819789wmj.3
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7vZZQ81xPSpmrpG2XPMAeZXt4/fk8crwLDwheVDqVc=;
        b=rGMy+ylC4M74y8ns7W6VVgb9qZHN8FJ6lpCF6Kj5K3f49FU9zzNXUE2Or0xUq7UXVq
         ahTHC6YdH3YuzE1cKR9bxk/bMcaPQKGRpPIGYbhMTo5mPb0RuvSnFNqOx6klEgTZvihL
         iIpEWv7wFF18tq/3RrvS0BuanNA9l4sJ5oSt9rLw75CrX5vKIRpA2nPw/CQqrQfcX+N4
         CY2GAZVN1sTP5wT2wefoYiXUqyth5qND4Oq97G8RbwS3lVcnfcVX8xUcvaefFGduzk/t
         oW3hHaf6OjQru117IPj8JR4TBMQh7sdoV2wDQAQtk8aYdKySx1Ir5+q5qDhyU0aA/5jS
         3nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7vZZQ81xPSpmrpG2XPMAeZXt4/fk8crwLDwheVDqVc=;
        b=RYOx56NKh5VwlxX9294PA2grmnAE0VEr4DjtgsRxc8u5vpK/iG+ZMVUrMbytN72qOm
         yCppXfmyLdsrmhC28e5wQBf/QTsiXZ+DQEqmNAdztQyx9wC+n0SyL1nbxrULXzoL3g7f
         Mphg2nv75YV5kJOlGOZW+A7b416N+Cs6RBmEMQsAwMgSjQjb2xgcgxqmx68vR5OBOWbs
         FafF7mUONLe6EBnmsggGmlk+L0gd2N9VdpDfL1BStyn9IrLgxLHRj+tR4/u91f/SnjAj
         hdXeTWt3aMCfeOu37N4GaI1xSdT3sFXUzdrI3ob2Hw16BZV2nlehJ1UclRmiqaor9GAq
         IXyA==
X-Gm-Message-State: AOAM531xkUx9j4FL9MPxdJhqzX4cy2u8J+aYfoPkXtfOyKc5JNKE0fhz
        CiNPHvUH1H+IsVi9dh/U5493EA==
X-Google-Smtp-Source: ABdhPJz5kEYvrH0IyW2BEgOwhf1W7ehe5KwvGaoplM2GFEDpylyB+pSL6zv7EhCtKHSEp2UtuVxfew==
X-Received: by 2002:a1c:f316:: with SMTP id q22mr22106612wmq.55.1635022322468;
        Sat, 23 Oct 2021 13:52:02 -0700 (PDT)
Received: from localhost.localdomain ([149.86.74.50])
        by smtp.gmail.com with ESMTPSA id u16sm13555398wmc.21.2021.10.23.13.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 13:52:02 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 2/5] bpftool: Do not expose and init hash maps for pinned path in main.c
Date:   Sat, 23 Oct 2021 21:51:51 +0100
Message-Id: <20211023205154.6710-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211023205154.6710-1-quentin@isovalent.com>
References: <20211023205154.6710-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF programs, maps, and links, can all be listed with their pinned paths
by bpftool, when the "-f" option is provided. To do so, bpftool builds
hash maps containing all pinned paths for each kind of objects.

These three hash maps are always initialised in main.c, and exposed
through main.h. There appear to be no particular reason to do so: we can
just as well make them static to the files that need them (prog.c,
map.c, and link.c respectively), and initialise them only when we want
to show objects and the "-f" switch is provided.

This may prevent unnecessary memory allocations if the implementation of
the hash maps was to change in the future.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/link.c |  9 ++++++++-
 tools/bpf/bpftool/main.c | 12 ------------
 tools/bpf/bpftool/main.h |  3 ---
 tools/bpf/bpftool/map.c  |  9 ++++++++-
 tools/bpf/bpftool/prog.c |  9 ++++++++-
 5 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 8cc3e36f8cc6..a5effb1816b7 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -20,6 +20,8 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_NETNS]			= "netns",
 };
 
+static struct pinned_obj_table link_table;
+
 static int link_parse_fd(int *argc, char ***argv)
 {
 	int fd;
@@ -302,8 +304,10 @@ static int do_show(int argc, char **argv)
 	__u32 id = 0;
 	int err, fd;
 
-	if (show_pinned)
+	if (show_pinned) {
+		hash_init(link_table.table);
 		build_pinned_obj_table(&link_table, BPF_OBJ_LINK);
+	}
 	build_obj_refs_table(&refs_table, BPF_OBJ_LINK);
 
 	if (argc == 2) {
@@ -346,6 +350,9 @@ static int do_show(int argc, char **argv)
 
 	delete_obj_refs_table(&refs_table);
 
+	if (show_pinned)
+		delete_pinned_obj_table(&link_table);
+
 	return errno == ENOENT ? 0 : -1;
 }
 
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 02eaaf065f65..7a33f0e6da28 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -31,9 +31,6 @@ bool verifier_logs;
 bool relaxed_maps;
 bool use_loader;
 struct btf *base_btf;
-struct pinned_obj_table prog_table;
-struct pinned_obj_table map_table;
-struct pinned_obj_table link_table;
 struct obj_refs_table refs_table;
 
 static void __noreturn clean_and_exit(int i)
@@ -409,10 +406,6 @@ int main(int argc, char **argv)
 	block_mount = false;
 	bin_name = argv[0];
 
-	hash_init(prog_table.table);
-	hash_init(map_table.table);
-	hash_init(link_table.table);
-
 	opterr = 0;
 	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:",
 				  options, NULL)) >= 0) {
@@ -479,11 +472,6 @@ int main(int argc, char **argv)
 	if (json_output)
 		jsonw_destroy(&json_wtr);
 
-	if (show_pinned) {
-		delete_pinned_obj_table(&prog_table);
-		delete_pinned_obj_table(&map_table);
-		delete_pinned_obj_table(&link_table);
-	}
 	btf__free(base_btf);
 
 	return ret;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 90caa42aac4c..baf607cd5924 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -91,9 +91,6 @@ extern bool verifier_logs;
 extern bool relaxed_maps;
 extern bool use_loader;
 extern struct btf *base_btf;
-extern struct pinned_obj_table prog_table;
-extern struct pinned_obj_table map_table;
-extern struct pinned_obj_table link_table;
 extern struct obj_refs_table refs_table;
 
 void __printf(1, 2) p_err(const char *fmt, ...);
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 407071d54ab1..0085039d9610 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -56,6 +56,8 @@ const char * const map_type_name[] = {
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
 
+static struct pinned_obj_table map_table;
+
 static bool map_is_per_cpu(__u32 type)
 {
 	return type == BPF_MAP_TYPE_PERCPU_HASH ||
@@ -694,8 +696,10 @@ static int do_show(int argc, char **argv)
 	int err;
 	int fd;
 
-	if (show_pinned)
+	if (show_pinned) {
+		hash_init(map_table.table);
 		build_pinned_obj_table(&map_table, BPF_OBJ_MAP);
+	}
 	build_obj_refs_table(&refs_table, BPF_OBJ_MAP);
 
 	if (argc == 2)
@@ -742,6 +746,9 @@ static int do_show(int argc, char **argv)
 
 	delete_obj_refs_table(&refs_table);
 
+	if (show_pinned)
+		delete_pinned_obj_table(&map_table);
+
 	return errno == ENOENT ? 0 : -1;
 }
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f633299b1261..48c2fa4d068e 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -84,6 +84,8 @@ static const char * const attach_type_strings[] = {
 	[__MAX_BPF_ATTACH_TYPE] = NULL,
 };
 
+static struct pinned_obj_table prog_table;
+
 static enum bpf_attach_type parse_attach_type(const char *str)
 {
 	enum bpf_attach_type type;
@@ -567,8 +569,10 @@ static int do_show(int argc, char **argv)
 	int err;
 	int fd;
 
-	if (show_pinned)
+	if (show_pinned) {
+		hash_init(prog_table.table);
 		build_pinned_obj_table(&prog_table, BPF_OBJ_PROG);
+	}
 	build_obj_refs_table(&refs_table, BPF_OBJ_PROG);
 
 	if (argc == 2)
@@ -613,6 +617,9 @@ static int do_show(int argc, char **argv)
 
 	delete_obj_refs_table(&refs_table);
 
+	if (show_pinned)
+		delete_pinned_obj_table(&prog_table);
+
 	return err;
 }
 
-- 
2.30.2

