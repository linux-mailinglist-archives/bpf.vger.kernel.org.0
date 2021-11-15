Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2826844FCB9
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 02:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhKOB1o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Nov 2021 20:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhKOB1m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Nov 2021 20:27:42 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E2AC061766
        for <bpf@vger.kernel.org>; Sun, 14 Nov 2021 17:24:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g19so13594438pfb.8
        for <bpf@vger.kernel.org>; Sun, 14 Nov 2021 17:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vvr27CrA6/O1GnVPpfDbTI8ifi3QUkdbWNm944IcFUM=;
        b=LtJaNFo8erCuKuO+a2xF+VX27TJjVOHyxFtQk61zrljeRz+uF+zqF22mYy/YJy2jmP
         Ljv8QGkmdUhykARD6XCwVn1RBt1Q9m75ICza8gpO/a/SsoQNlZytZC4dSdAs7/BMhehb
         3zVfMebqldDob6ldHwvnlokdIHgtGb1B89zSAOTJeDRYS8RCWyZLThVYsAfLcXP6zRNI
         zcBJlXMZfK+DBehlxcOU2BXjqiqWndCxQbj8f8vXdN0lHOJiQ8FmHKeIoZqUnex6LurI
         i/5GINGJmwkzxmmk8WnK8CUYGhD7WFZPvgf3y4UXq8nejZxlmuXMu1L8lG/N/eQWkSrr
         wQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vvr27CrA6/O1GnVPpfDbTI8ifi3QUkdbWNm944IcFUM=;
        b=UohwjgDA0HLX4/8O6kHAdOMzBOodD2ZwxwJP6wIgAKLn7gxxb7gNWzX2902tL560pm
         lZxp/TF8zly0fJgvMz8x4OeBkevH3HNusovfZIGkWWBt51qHfp8hOLsDrRjfT8N+VVph
         HNRQ3GoJer7K5gv1KsKCClbpuIGnWjGkkZ/+YaP5eMdU1UGXLEYDaNQuqwNTL7MA1TLQ
         O6Asd3BC654KCCkRrsWKjSVRLWiwXY4vdQt3pVBtF8ruzR+ml8bjVrCkR3oaMp17A+cH
         s7WkRql8r7Qqc3W8UcYUfbAxVtuK3SJbxEOW+XVPw2C4wLKX+LINDKjWvVdgmnTOVJFC
         LHRg==
X-Gm-Message-State: AOAM531mLn8kT2tyf+PIjkXgqFYAzYD3Pb7pza3LXNpUDyr4N1JUzpsb
        ZMGDA9i8OrRYCja1F7Q/q46zjEN9rhzYXg==
X-Google-Smtp-Source: ABdhPJxYC8FNDdrcvrVAM7OfciDkFFKGMymAWgTqjM2UnvuFVJHtQpcBAzEv0dTUHv5m1wa7qrROyA==
X-Received: by 2002:a63:8742:: with SMTP id i63mr22065927pge.282.1636939486427;
        Sun, 14 Nov 2021 17:24:46 -0800 (PST)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id j62sm10023593pgc.62.2021.11.14.17.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 17:24:46 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next] bpftool: Use libbpf_get_error() to check error
Date:   Mon, 15 Nov 2021 09:24:36 +0800
Message-Id: <20211115012436.3143318-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, LIBBPF_STRICT_ALL mode is enabled by default for
bpftool which means on error cases, some libbpf APIs would
return NULL pointers. This makes IS_ERR check failed to detect
such cases and result in segfault error. Use libbpf_get_error()
instead like we do in libbpf itself.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/bpf/bpftool/btf.c        |  9 +++++----
 tools/bpf/bpftool/gen.c        | 10 ++++++----
 tools/bpf/bpftool/iter.c       |  7 ++++---
 tools/bpf/bpftool/map.c        | 10 +++++-----
 tools/bpf/bpftool/struct_ops.c | 14 +++++++-------
 5 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index c7e3b0b0029e..59833125ac0a 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -421,8 +421,9 @@ static int dump_btf_c(const struct btf *btf,
 	int err = 0, i;
 
 	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
+	err = libbpf_get_error(d);
+	if (err)
+		return err;
 
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
@@ -549,8 +550,8 @@ static int do_dump(int argc, char **argv)
 		}
 
 		btf = btf__parse_split(*argv, base ?: base_btf);
-		if (IS_ERR(btf)) {
-			err = -PTR_ERR(btf);
+		err = libbpf_get_error(btf);
+		if (err) {
 			btf = NULL;
 			p_err("failed to load BTF from %s: %s",
 			      *argv, strerror(err));
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 89f0e828bbfa..997a2865e04a 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -219,8 +219,9 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 	int i, err = 0;
 
 	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
+	err = libbpf_get_error(d);
+	if (err)
+		return err;
 
 	bpf_object__for_each_map(map, obj) {
 		/* only generate definitions for memory-mapped internal maps */
@@ -719,10 +720,11 @@ static int do_skeleton(int argc, char **argv)
 		get_obj_name(obj_name, file);
 	opts.object_name = obj_name;
 	obj = bpf_object__open_mem(obj_data, file_sz, &opts);
-	if (IS_ERR(obj)) {
+	err = libbpf_get_error(obj);
+	if (err) {
 		char err_buf[256];
 
-		libbpf_strerror(PTR_ERR(obj), err_buf, sizeof(err_buf));
+		libbpf_strerror(err, err_buf, sizeof(err_buf));
 		p_err("failed to open BPF object file: %s", err_buf);
 		obj = NULL;
 		goto out;
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index 6c0de647b8ad..f88fdc820d23 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -46,7 +46,8 @@ static int do_pin(int argc, char **argv)
 	}
 
 	obj = bpf_object__open(objfile);
-	if (IS_ERR(obj)) {
+	err = libbpf_get_error(obj);
+	if (err) {
 		p_err("can't open objfile %s", objfile);
 		goto close_map_fd;
 	}
@@ -64,8 +65,8 @@ static int do_pin(int argc, char **argv)
 	}
 
 	link = bpf_program__attach_iter(prog, &iter_opts);
-	if (IS_ERR(link)) {
-		err = PTR_ERR(link);
+	err = libbpf_get_error(link);
+	if (err) {
 		p_err("attach_iter failed for program %s",
 		      bpf_program__name(prog));
 		goto close_obj;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index cae1f1119296..b57fefac6812 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -811,7 +811,7 @@ static struct btf *get_map_kv_btf(const struct bpf_map_info *info)
 	if (info->btf_vmlinux_value_type_id) {
 		if (!btf_vmlinux) {
 			btf_vmlinux = libbpf_find_kernel_btf();
-			if (IS_ERR(btf_vmlinux))
+			if (libbpf_get_error(btf_vmlinux))
 				p_err("failed to get kernel btf");
 		}
 		return btf_vmlinux;
@@ -831,13 +831,13 @@ static struct btf *get_map_kv_btf(const struct bpf_map_info *info)
 
 static void free_map_kv_btf(struct btf *btf)
 {
-	if (!IS_ERR(btf) && btf != btf_vmlinux)
+	if (!libbpf_get_error(btf) && btf != btf_vmlinux)
 		btf__free(btf);
 }
 
 static void free_btf_vmlinux(void)
 {
-	if (!IS_ERR(btf_vmlinux))
+	if (!libbpf_get_error(btf_vmlinux))
 		btf__free(btf_vmlinux);
 }
 
@@ -862,8 +862,8 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 
 	if (wtr) {
 		btf = get_map_kv_btf(info);
-		if (IS_ERR(btf)) {
-			err = PTR_ERR(btf);
+		err = libbpf_get_error(btf);
+		if (err) {
 			goto exit_free;
 		}
 
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index 20f803dce2e4..cbdca37a53f0 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -32,7 +32,7 @@ static const struct btf *get_btf_vmlinux(void)
 		return btf_vmlinux;
 
 	btf_vmlinux = libbpf_find_kernel_btf();
-	if (IS_ERR(btf_vmlinux))
+	if (libbpf_get_error(btf_vmlinux))
 		p_err("struct_ops requires kernel CONFIG_DEBUG_INFO_BTF=y");
 
 	return btf_vmlinux;
@@ -45,7 +45,7 @@ static const char *get_kern_struct_ops_name(const struct bpf_map_info *info)
 	const char *st_ops_name;
 
 	kern_btf = get_btf_vmlinux();
-	if (IS_ERR(kern_btf))
+	if (libbpf_get_error(kern_btf))
 		return "<btf_vmlinux_not_found>";
 
 	t = btf__type_by_id(kern_btf, info->btf_vmlinux_value_type_id);
@@ -63,7 +63,7 @@ static __s32 get_map_info_type_id(void)
 		return map_info_type_id;
 
 	kern_btf = get_btf_vmlinux();
-	if (IS_ERR(kern_btf)) {
+	if (libbpf_get_error(kern_btf)) {
 		map_info_type_id = PTR_ERR(kern_btf);
 		return map_info_type_id;
 	}
@@ -415,7 +415,7 @@ static int do_dump(int argc, char **argv)
 	}
 
 	kern_btf = get_btf_vmlinux();
-	if (IS_ERR(kern_btf))
+	if (libbpf_get_error(kern_btf))
 		return -1;
 
 	if (!json_output) {
@@ -495,7 +495,7 @@ static int do_register(int argc, char **argv)
 	file = GET_ARG();
 
 	obj = bpf_object__open(file);
-	if (IS_ERR_OR_NULL(obj))
+	if (libbpf_get_error(obj))
 		return -1;
 
 	set_max_rlimit();
@@ -516,7 +516,7 @@ static int do_register(int argc, char **argv)
 			continue;
 
 		link = bpf_map__attach_struct_ops(map);
-		if (IS_ERR(link)) {
+		if (libbpf_get_error(link)) {
 			p_err("can't register struct_ops %s: %s",
 			      bpf_map__name(map),
 			      strerror(-PTR_ERR(link)));
@@ -596,7 +596,7 @@ int do_struct_ops(int argc, char **argv)
 
 	err = cmd_select(cmds, argc, argv, do_help);
 
-	if (!IS_ERR(btf_vmlinux))
+	if (!libbpf_get_error(btf_vmlinux))
 		btf__free(btf_vmlinux);
 
 	return err;
-- 
2.30.2

