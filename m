Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB443D4511
	for <lists+bpf@lfdr.de>; Sat, 24 Jul 2021 07:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGXEcw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Jul 2021 00:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhGXEcw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Jul 2021 00:32:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3014C061575
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 22:13:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id hg12-20020a17090b300cb02901736d9d2218so6550317pjb.1
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 22:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rngcTGKTGy8eXlB+PVK4FmM4+zqoEmcIAPbrkbOn/uU=;
        b=EWJyASSFZ0OXOkHMfu5v77qKZha2+Z6QgzmaIDJSJdA2R4XBbqKNZYy8qeDzOh7+ko
         mjatPsXnCG0hgCpuY/rTL221dl4eysgvJZ7B04hSYzCECXMrlglbe7NRq5ijUk0FFPQe
         jZA0sokh4ymnKlsX9crqu14Vs6gqAeX5x1lpCbCN+tNCQIRIc7+waO61xZ1lfp9hqFs0
         ukGDkVw1edvHzl4v+5emQFi0dX1A1P72aVjVncK8hHj6oBHsYD/fkmaXYt1slUtZ/PRg
         g3X3JqxSy3Y4z2kilQS5p/iyF8XiZJ1o30uJgOK05wdkTK9e5uYZQDermvOFahTwAapk
         qXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rngcTGKTGy8eXlB+PVK4FmM4+zqoEmcIAPbrkbOn/uU=;
        b=o4gUxldZtqlyBSfChrl1FNU1zy6zRprkfjXBjlGzk9/G6hvMsuRvLxetmg9/9hwmMW
         OLuFYWOmvNEz+xe6ISgXlrjlKjJPEa9IlKUN8aTeSfWYZzqozooy3C5H/Esbngvws76l
         ExTgd9eFom1slhYBrSngyi/3knkKWgxyxcvW40tPwcs11VELp6P8DkDzrFVOMl3s26CZ
         wEO9m2yV1UkXEqUHMy88aHqELp51fB6HapyAm5hXb5B6uJ27AYparWMw3bba7OKXIQ4M
         KpXdDLmkv9M/4CyLDDXqBX5I8a3HIbU0jTJhK6FHPgbgqPMJcFH38N5X0I6zJCfSX6Ij
         e3AA==
X-Gm-Message-State: AOAM530pmUljcMq+jH6EXAW7Bs6umgaxRoYKwiVNsyuA2qLDAmBo0Z6O
        fpIyOzCriem1YwNHmxZH1kSm5d4Tz6dcQw==
X-Google-Smtp-Source: ABdhPJwtPM7ISMu7VKeck1V+DZjq8d3iJcLwbIA8/x3DaRl+wRAaJkI0tdjV+iUVyf+52Mr4ovTGQw==
X-Received: by 2002:a17:902:e54f:b029:12b:55c9:3b48 with SMTP id n15-20020a170902e54fb029012b55c93b48mr6618553plf.45.1627103603236;
        Fri, 23 Jul 2021 22:13:23 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id h17sm35267771pfh.192.2021.07.23.22.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 22:13:22 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next] libbpf: add libbpf_load_vmlinux_btf/libbpf_load_module_btf APIs
Date:   Sat, 24 Jul 2021 13:12:56 +0800
Message-Id: <20210724051256.1629110-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add libbpf_load_vmlinux_btf/libbpf_load_module_btf APIs.
This is part of the libbpf v1.0. [1]

[1] https://github.com/libbpf/libbpf/issues/280

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/btf.c      | 24 +++++++++++++++++++++++-
 tools/lib/bpf/btf.h      |  2 ++
 tools/lib/bpf/libbpf.c   |  8 ++++----
 tools/lib/bpf/libbpf.map |  2 ++
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b46760b93bb4..414e1c5635ef 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4021,7 +4021,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
 		 */
 		if (d->hypot_adjust_canon)
 			continue;
-		
+
 		if (t_kind == BTF_KIND_FWD && c_kind != BTF_KIND_FWD)
 			d->map[t_id] = c_id;
 
@@ -4395,6 +4395,11 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
  * data out of it to use for target BTF.
  */
 struct btf *libbpf_find_kernel_btf(void)
+{
+	return libbpf_load_vmlinux_btf();
+}
+
+struct btf *libbpf_load_vmlinux_btf(void)
 {
 	struct {
 		const char *path_fmt;
@@ -4440,6 +4445,23 @@ struct btf *libbpf_find_kernel_btf(void)
 	return libbpf_err_ptr(-ESRCH);
 }
 
+struct btf *libbpf_load_module_btf(const char *mod)
+{
+	char path[80];
+	struct btf *base;
+	int err;
+
+	base = libbpf_load_vmlinux_btf();
+	err = libbpf_get_error(base);
+	if (err) {
+		pr_warn("Error loading vmlinux BTF: %d\n", err);
+		return base;
+	}
+
+	snprintf(path, sizeof(path), "/sys/kernel/btf/%s", mod);
+	return btf__parse_split(path, base);
+}
+
 int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
 {
 	int i, n, err;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 374e9f15de2e..d27cc2e2f220 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -90,6 +90,8 @@ LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
 LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
 
 LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
+LIBBPF_API struct btf *libbpf_load_vmlinux_btf(void);
+LIBBPF_API struct btf *libbpf_load_module_btf(const char *mod);
 
 LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a53ca29b44ab..6e4ead454c0e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2685,7 +2685,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
 	if (!force && !obj_needs_vmlinux_btf(obj))
 		return 0;
 
-	obj->btf_vmlinux = libbpf_find_kernel_btf();
+	obj->btf_vmlinux = libbpf_load_vmlinux_btf();
 	err = libbpf_get_error(obj->btf_vmlinux);
 	if (err) {
 		pr_warn("Error loading vmlinux BTF: %d\n", err);
@@ -7236,7 +7236,7 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 
 	for (i = 0; i < obj->nr_programs; i++) {
 		struct bpf_program *p = &obj->programs[i];
-		
+
 		if (!p->nr_reloc)
 			continue;
 
@@ -9562,7 +9562,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
 	struct btf *btf;
 	int err;
 
-	btf = libbpf_find_kernel_btf();
+	btf = libbpf_load_vmlinux_btf();
 	err = libbpf_get_error(btf);
 	if (err) {
 		pr_warn("vmlinux BTF is not found\n");
@@ -10080,7 +10080,7 @@ struct bpf_link {
 int bpf_link__update_program(struct bpf_link *link, struct bpf_program *prog)
 {
 	int ret;
-	
+
 	ret = bpf_link_update(bpf_link__fd(link), bpf_program__fd(prog), NULL);
 	return libbpf_err_errno(ret);
 }
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c240d488eb5e..2088bdbc0f50 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -377,4 +377,6 @@ LIBBPF_0.5.0 {
 		bpf_object__gen_loader;
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
+		libbpf_load_vmlinux_btf;
+		libbpf_load_module_btf;
 } LIBBPF_0.4.0;
-- 
2.25.1

