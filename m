Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A506E867C
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 02:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjDTA2h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 20:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjDTA2h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 20:28:37 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EAC59C0
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:28:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fa9da5e5bso23504397b3.1
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681950514; x=1684542514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eq2tQZLnrOgaEnVD8qpLVR21F4cq/6Ug20xlMDWv+uo=;
        b=XCNY3LYxQDRjsNxSVg4vG7UmV6PZFSrZtGRcjdB1qYjfTi8V3HHPeI2k7yeyVU5DSj
         MZSc3VruW5vqhklNymYGTsd/aFYd3QJhuFMkSCDZQE0DzLBRmsrdvTW8Q/BucHdFTraI
         ECkvYY3CypWPEPE+t2IRGloTn2rggLmFq5W9i2rfsI1/dH66rzq9HDL89sbltKa0G+om
         sQkox19p7tEDYAifdxIAML16kPlf9DYsEHGqSMu4cNyk4WvmQKgt+FoSk2M9xqDp+fn+
         LqyPpj+s7oUP+Gk+mfymYtiXsKfzJtl1FvqKe53CCeaxtXcvkTBsXI2iXtYbJkXQNPch
         hWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950514; x=1684542514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq2tQZLnrOgaEnVD8qpLVR21F4cq/6Ug20xlMDWv+uo=;
        b=abqdkJT2W58if9nRueT+PNiA4llk08SeBG5ybRHvrE6vqe1Gy1KafNHjw+rr48tmie
         RivsWv+k/P5oNTfoGsi9iIwl6Fu94sJyBoxRmsn6HXvguPqRxKrk0jI0Eh3FUNtV4YNY
         2e0NYXMQHCbYNsuwbxdXxUR7T6RoyCeTqiUqtuBxZ3Ij4G0qkAXCwm++1KX0goYYYbYj
         0OUUd4KXwZA6tUajQzbn90+ZhUYwLYY3IjPZDjxtBXhX8Cc5RfiD3S/Fr6s1b9IgGQWi
         oIJVWwq/lTerg5kDP5mq6FixOPeS2bm4qB4frQuM44n7p4GaRXbqnwPGxE0pzqKc0aLi
         gl+g==
X-Gm-Message-State: AAQBX9du1y/yAoozR2pPJ/y4TxZM2zWVJo2nG+n+snyVhP+d0YzCPFRw
        hMBqMEl0QYsdQ9L27JZKcezyLUbt1mU=
X-Google-Smtp-Source: AKy350aPFz0C6+Ba+JnJd8XIP1+vyJpYYDEt/e3/UKu4iIvm9rv4XLjDJiwwSqrOsqe4E6DfV+z87Q==
X-Received: by 2002:a0d:d695:0:b0:54f:e109:7153 with SMTP id y143-20020a0dd695000000b0054fe1097153mr4970949ywd.48.1681950514325;
        Wed, 19 Apr 2023 17:28:34 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:7d97:458e:fc71:f392])
        by smtp.gmail.com with ESMTPSA id j1-20020a0df901000000b0054f9dc9c7f2sm30822ywf.44.2023.04.19.17.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 17:28:34 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, quentin@isovalent.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 1/2] bpftool: Register struct_ops with a link.
Date:   Wed, 19 Apr 2023 17:28:21 -0700
Message-Id: <20230420002822.345222-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

You can include an optional path after specifying the object name for the
'struct_ops register' subcommand.

Since the commit 226bc6ae6405 ("Merge branch 'Transit between BPF TCP
congestion controls.'") has been accepted, it is now possible to create a
link for a struct_ops. This can be done by defining a struct_ops in
SEC(".struct_ops.link") to make libbpf returns a real link. If we don't pin
the links before leaving bpftool, they will disappear. To instruct bpftool
to pin the links in a directory with the names of the maps, we need to
provide the path of that directory.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/bpf/bpftool/common.c     | 14 +++++++
 tools/bpf/bpftool/main.h       |  3 ++
 tools/bpf/bpftool/prog.c       | 13 -------
 tools/bpf/bpftool/struct_ops.c | 70 ++++++++++++++++++++++++++++------
 4 files changed, 75 insertions(+), 25 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 5a73ccf14332..1360c82ae732 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1091,3 +1091,17 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	default:	return libbpf_bpf_attach_type_str(t);
 	}
 }
+
+int pathname_concat(char *buf, int buf_sz, const char *path,
+		    const char *name)
+{
+	int len;
+
+	len = snprintf(buf, buf_sz, "%s/%s", path, name);
+	if (len < 0)
+		return -EINVAL;
+	if (len >= buf_sz)
+		return -ENAMETOOLONG;
+
+	return 0;
+}
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0ef373cef4c7..f09853f24422 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -262,4 +262,7 @@ static inline bool hashmap__empty(struct hashmap *map)
 	return map ? hashmap__size(map) == 0 : true;
 }
 
+int pathname_concat(char *buf, int buf_sz, const char *path,
+		    const char *name);
+
 #endif
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index afbe3ec342c8..6024b7316875 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1472,19 +1472,6 @@ auto_attach_program(struct bpf_program *prog, const char *path)
 	return err;
 }
 
-static int pathname_concat(char *buf, size_t buf_sz, const char *path, const char *name)
-{
-	int len;
-
-	len = snprintf(buf, buf_sz, "%s/%s", path, name);
-	if (len < 0)
-		return -EINVAL;
-	if ((size_t)len >= buf_sz)
-		return -ENAMETOOLONG;
-
-	return 0;
-}
-
 static int
 auto_attach_programs(struct bpf_object *obj, const char *path)
 {
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index b389f4830e11..57c3da70aa31 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -475,21 +475,44 @@ static int do_unregister(int argc, char **argv)
 	return cmd_retval(&res, true);
 }
 
+static int pin_link(struct bpf_link *link, const char *pindir,
+		    const char *name)
+{
+	char pinfile[PATH_MAX];
+	int err;
+
+	err = pathname_concat(pinfile, sizeof(pinfile), pindir, name);
+	if (err)
+		return -1;
+
+	return bpf_link__pin(link, pinfile);
+}
+
 static int do_register(int argc, char **argv)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, open_opts);
+	__u32 link_info_len = sizeof(struct bpf_link_info);
+	struct bpf_link_info link_info = {};
 	struct bpf_map_info info = {};
 	__u32 info_len = sizeof(info);
 	int nr_errs = 0, nr_maps = 0;
+	const char *linkdir = NULL;
 	struct bpf_object *obj;
 	struct bpf_link *link;
 	struct bpf_map *map;
 	const char *file;
 
-	if (argc != 1)
+	if (argc != 1 && argc != 2)
 		usage();
 
 	file = GET_ARG();
+	if (argc == 1)
+		linkdir = GET_ARG();
+
+	if (linkdir && mount_bpffs_for_pin(linkdir)) {
+		p_err("can't mount bpffs for pinning");
+		return -1;
+	}
 
 	if (verifier_logs)
 		/* log_level1 + log_level2 + stats, but not stable UAPI */
@@ -519,21 +542,44 @@ static int do_register(int argc, char **argv)
 		}
 		nr_maps++;
 
-		bpf_link__disconnect(link);
-		bpf_link__destroy(link);
-
-		if (!bpf_map_get_info_by_fd(bpf_map__fd(map), &info,
-					    &info_len))
-			p_info("Registered %s %s id %u",
-			       get_kern_struct_ops_name(&info),
-			       bpf_map__name(map),
-			       info.id);
-		else
+		if (bpf_map_get_info_by_fd(bpf_map__fd(map), &info,
+					   &info_len)) {
 			/* Not p_err.  The struct_ops was attached
 			 * successfully.
 			 */
 			p_info("Registered %s but can't find id: %s",
 			       bpf_map__name(map), strerror(errno));
+			goto clean_link;
+		}
+		if (!(bpf_map__map_flags(map) & BPF_F_LINK)) {
+			p_info("Registered %s %s id %u",
+			       get_kern_struct_ops_name(&info),
+			       info.name,
+			       info.id);
+			goto clean_link;
+		}
+		if (bpf_link_get_info_by_fd(bpf_link__fd(link),
+					    &link_info,
+					    &link_info_len)) {
+			p_err("Registered %s but can't find link id: %s",
+			      bpf_map__name(map), strerror(errno));
+			nr_errs++;
+			goto clean_link;
+		}
+		if (linkdir && pin_link(link, linkdir, info.name)) {
+			p_err("can't pin link %u for %s: %s",
+			      link_info.id, info.name,
+			      strerror(errno));
+			nr_errs++;
+			goto clean_link;
+		}
+		p_info("Registered %s %s map id %u link id %u",
+		       get_kern_struct_ops_name(&info),
+		       info.name, info.id, link_info.id);
+
+clean_link:
+		bpf_link__disconnect(link);
+		bpf_link__destroy(link);
 	}
 
 	bpf_object__close(obj);
@@ -562,7 +608,7 @@ static int do_help(int argc, char **argv)
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list } [STRUCT_OPS_MAP]\n"
 		"       %1$s %2$s dump [STRUCT_OPS_MAP]\n"
-		"       %1$s %2$s register OBJ\n"
+		"       %1$s %2$s register OBJ [LINK_DIR]\n"
 		"       %1$s %2$s unregister STRUCT_OPS_MAP\n"
 		"       %1$s %2$s help\n"
 		"\n"
-- 
2.34.1

