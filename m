Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0036E6D35
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 22:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDRUBG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 16:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjDRUBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 16:01:04 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD8C65A
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 13:01:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f6a796bd0so358104557b3.12
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 13:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681848062; x=1684440062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3X11Td/r0AU5FZC1D2/zxmhz41lqj2IQOxXAtKohg0=;
        b=Xo8zYlFTmkNrUYcjt35cqUilEKvS3yr9Rdm4EpqlPROa39D5Es3//tVO9SN+ItnxeI
         fUDK/6MwUHb2nO+vEmmAobwv/5DHXqsGkF0YSffG3pXEsX7wz1lMqdSYF+xW5AkR/x6s
         3Mha9vXKvAojOVu8PQU3Mpsk4Jg1HN7lfLodaqp+cuU+w3gnIGkV9eQ8IKO+28hdADxc
         kL5TFIa8ziMEdJc9vql32N/U8SxZ5YtOHVzNVlxKm+I5ubOcryLCAfN09GZJ/hGxIT99
         I5E/kOxch+YmFIYb9jCjVcmFiuJ1lfT6f9w4Hr7xyGQYCFyvi68a/RkpqgEX/W4GYmuA
         5KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681848062; x=1684440062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3X11Td/r0AU5FZC1D2/zxmhz41lqj2IQOxXAtKohg0=;
        b=Rxa+dx+PRQGo3EOyqpaRN6xY0BWWJTC4T9redpd7i444oRsGX2vfSpE8d8LCOuN8Sj
         10B1jRqEFiY66CA0EfHpL1HjLzdbe3c9SO9+19Ft0lURdiBPdYD9qTDwFcvKlOEsEhX3
         M6yEB5Ae4yXaJalWlll8k+trWBXRAyMS7f9kbNM9tKNOdx3Oe2Up4GvShAFvHqA+NYLT
         7co04HdGJVraNbTY7l0eIJ9H4Hjja/6pc5tV74jaJIHB0fPHPOyxXzTa7wik87Ujp/Fr
         gk0SqeeQQlVixyUVQcLlvoz4OlL5x+ATIKgizhiidI6Ecmq9SQz3KrrT6Jy5bTwa31WT
         ZmOQ==
X-Gm-Message-State: AAQBX9eT7XH33rd9GnBxLrVloAsCIA/k70fZnuaDo3XGTFZ6fn5AMS06
        6i7XzDK02ubZ6bJTuScs1B2hjVqDtEY=
X-Google-Smtp-Source: AKy350aN29PYXNU3tqJzUqW7zANGCiRRxrHrGnPwIAAI+BF8F2R32H+jizKKwLYWpekBw9TOs5mXrQ==
X-Received: by 2002:a81:6507:0:b0:54f:8b56:bb5 with SMTP id z7-20020a816507000000b0054f8b560bb5mr1130079ywb.1.1681848062226;
        Tue, 18 Apr 2023 13:01:02 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c63f:66a6:ac77:89c1])
        by smtp.gmail.com with ESMTPSA id 22-20020a810b16000000b0054fae5ed408sm4049569ywl.45.2023.04.18.13.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:01:01 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next] bpftool: Register struct_ops with a link.
Date:   Tue, 18 Apr 2023 13:00:58 -0700
Message-Id: <20230418200058.603169-1-kuifeng@meta.com>
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
 tools/bpf/bpftool/struct_ops.c | 86 ++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index b389f4830e11..d1ae39f9d8df 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -475,21 +475,62 @@ static int do_unregister(int argc, char **argv)
 	return cmd_retval(&res, true);
 }
 
+static int pathname_concat(char *buf, int buf_sz, const char *path,
+			   const char *name)
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
+
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
+	err = bpf_link__pin(link, pinfile);
+	if (err)
+		return -1;
+
+	return 0;
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
+	const char *pindir = NULL;
 	struct bpf_object *obj;
 	struct bpf_link *link;
 	struct bpf_map *map;
 	const char *file;
 
-	if (argc != 1)
+	if (argc != 1 && argc != 2)
 		usage();
 
 	file = GET_ARG();
+	if (argc == 1)
+		pindir = GET_ARG();
+
+	if (pindir && mount_bpffs_for_pin(pindir)) {
+		p_err("can't mount bpffs for pinning");
+		return -1;
+	}
 
 	if (verifier_logs)
 		/* log_level1 + log_level2 + stats, but not stable UAPI */
@@ -519,21 +560,38 @@ static int do_register(int argc, char **argv)
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
-			p_info("Registered %s but can't find id: %s",
-			       bpf_map__name(map), strerror(errno));
+			p_err("Registered %s but can't find id: %s",
+			      bpf_map__name(map), strerror(errno));
+			nr_errs++;
+		} else if (!(bpf_map__map_flags(map) & BPF_F_LINK)) {
+			p_info("Registered %s %s id %u",
+			       get_kern_struct_ops_name(&info),
+			       info.name,
+			       info.id);
+		} else if (bpf_link_get_info_by_fd(bpf_link__fd(link),
+						   &link_info,
+					    &link_info_len)) {
+			p_err("Registered %s but can't find link id: %s",
+			      bpf_map__name(map), strerror(errno));
+			nr_errs++;
+		} else if (pindir && pin_link(link, pindir, info.name)) {
+			p_err("can't pin link %u for %s: %s",
+			      link_info.id, info.name,
+			      strerror(errno));
+			nr_errs++;
+		} else
+			p_info("Registered %s %s map id %u link id %u",
+			       get_kern_struct_ops_name(&info),
+			       info.name, info.id, link_info.id);
+
+		bpf_link__disconnect(link);
+		bpf_link__destroy(link);
+
 	}
 
 	bpf_object__close(obj);
@@ -562,7 +620,7 @@ static int do_help(int argc, char **argv)
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list } [STRUCT_OPS_MAP]\n"
 		"       %1$s %2$s dump [STRUCT_OPS_MAP]\n"
-		"       %1$s %2$s register OBJ\n"
+		"       %1$s %2$s register OBJ [PATH]\n"
 		"       %1$s %2$s unregister STRUCT_OPS_MAP\n"
 		"       %1$s %2$s help\n"
 		"\n"
-- 
2.34.1

