Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F953DB7ED
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhG3Lk3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhG3Lk3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 07:40:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3230C061765
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 04:40:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so20308670pja.5
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LBjSODnW2xscXNdIC1fGtYDW2oMbX16A41e/K4USwiE=;
        b=QtNb2dZ8KL+0Sj3oKUivUGSvF7PyB7rFqMhJIIclO++6IVlcP4vvCyWR1k2DXxlv2n
         ldMrJCGJpA4t6ucJGpgwGjIidv7o/ZFHhdtpcatBF7WfH+DkTU9y+lasOXQizRJaDuez
         BhlaQ7aAlOfIGVtgW0ApDm+xnrqoQJ/KbgLRTwba7TzzLVnf7asjfsTKADZHS1K7KreG
         cT3aHPdEzdxqF/yoY8rB/Jt2TzlWJ0aRzs85CIvt9tB4jKcuK2EKDgPYuzgBS0Pdg2DA
         VJ0OXrHMCLu7udL2filZwY0kPI4DWh2hHQTL+jL/9C2eaozxbVhdA4CNgXtXUdK5kJn4
         Yrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LBjSODnW2xscXNdIC1fGtYDW2oMbX16A41e/K4USwiE=;
        b=q6to+Dpr8MFWzBp6lCguDkE//KrJL9v7jvxUUwA6gFK+dLiN0F+FArPO0unS37r8eH
         woVXGMEkiYrANfTwLvsfaS9+v8CBCO59QEbL8cBK0+8P9AifpJOGYVanQ4LR9HK+0wK0
         3bYpbF3cEdvyzpAzjXHroG4uSfW03pLtms2lXHXNF1rQ+zB7JmmmaBV0MCw4fLUKaEAb
         IJm7u50b9uBM15BmamB8zHh37xlypokIWJNuNPBzQ5Q4O5OtzYkHT6WJ5uThmbgETapt
         v2S1ri1gFLbXz4hwc6mJ08UVW9Z5j9WX95IUs+rsSkQ6r1oZh3MSmJEY0/oUSgjKpzin
         CAxA==
X-Gm-Message-State: AOAM532eC6t6sK0+BuLy3MyLTr0diIzp5AR5gjKdtmWPnTf6+3T+hMPX
        k7j8vBs/VBzISPACQ6zJ1m4cOpfK25STDQ==
X-Google-Smtp-Source: ABdhPJwHzXN2LeuDrmn58q1Qt5pRj2TOtIb9rddqiMDF91g6IoiC4HQAV9Urav2INAodYhjevLWALQ==
X-Received: by 2002:a17:90a:e2c8:: with SMTP id fr8mr2576678pjb.131.1627645223307;
        Fri, 30 Jul 2021 04:40:23 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id 20sm2793019pgg.36.2021.07.30.04.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 04:40:23 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3] libbpf: add btf__load_vmlinux_btf/btf__load_module_btf
Date:   Fri, 30 Jul 2021 19:40:12 +0800
Message-Id: <20210730114012.494408-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two new APIs: btf__load_vmlinux_btf and btf__load_module_btf.
btf__load_vmlinux_btf is just an alias to the existing API named
libbpf_find_kernel_btf, rename to be more precisely and consistent
with existing BTF APIs. btf__load_module_btf can be used to load
module BTF, add it for completeness. These two APIs are useful for
implementing tracing tools and introspection tools. This is part
of the effort towards libbpf 1.0. [1]

[1] https://github.com/libbpf/libbpf/issues/280

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/btf.c      | 15 ++++++++++++++-
 tools/lib/bpf/btf.h      |  6 ++++--
 tools/lib/bpf/libbpf.c   |  4 ++--
 tools/lib/bpf/libbpf.map |  2 ++
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index cafa4f6bd9b1..56e84583e283 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4036,7 +4036,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
 		 */
 		if (d->hypot_adjust_canon)
 			continue;
-		
+
 		if (t_kind == BTF_KIND_FWD && c_kind != BTF_KIND_FWD)
 			d->map[t_id] = c_id;
 
@@ -4410,6 +4410,11 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
  * data out of it to use for target BTF.
  */
 struct btf *libbpf_find_kernel_btf(void)
+{
+	return btf__load_vmlinux_btf();
+}
+
+struct btf *btf__load_vmlinux_btf(void)
 {
 	struct {
 		const char *path_fmt;
@@ -4455,6 +4460,14 @@ struct btf *libbpf_find_kernel_btf(void)
 	return libbpf_err_ptr(-ESRCH);
 }
 
+struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf)
+{
+	char path[80];
+
+	snprintf(path, sizeof(path), "/sys/kernel/btf/%s", module_name);
+	return btf__parse_split(path, vmlinux_btf);
+}
+
 int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
 {
 	int i, n, err;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 596a42c8f4f5..6837dd116e87 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -44,6 +44,10 @@ LIBBPF_API struct btf *btf__parse_elf_split(const char *path, struct btf *base_b
 LIBBPF_API struct btf *btf__parse_raw(const char *path);
 LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf);
 
+LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
+LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
+LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
+
 LIBBPF_API struct btf *btf__load_from_kernel_by_id(__u32 id);
 LIBBPF_API struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf);
 LIBBPF_API int btf__get_from_id(__u32 id, struct btf **btf);
@@ -93,8 +97,6 @@ int btf_ext__reloc_line_info(const struct btf *btf,
 LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
 LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
 
-LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
-
 LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_type(struct btf *btf, const struct btf *src_btf,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 313883179919..cb106e8c42cb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2680,7 +2680,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
 	if (!force && !obj_needs_vmlinux_btf(obj))
 		return 0;
 
-	obj->btf_vmlinux = libbpf_find_kernel_btf();
+	obj->btf_vmlinux = btf__load_vmlinux_btf();
 	err = libbpf_get_error(obj->btf_vmlinux);
 	if (err) {
 		pr_warn("Error loading vmlinux BTF: %d\n", err);
@@ -8297,7 +8297,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
 	struct btf *btf;
 	int err;
 
-	btf = libbpf_find_kernel_btf();
+	btf = btf__load_vmlinux_btf();
 	err = libbpf_get_error(btf);
 	if (err) {
 		pr_warn("vmlinux BTF is not found\n");
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5aca3686ca5e..a2f471950213 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -380,4 +380,6 @@ LIBBPF_0.5.0 {
 		btf__load_into_kernel;
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
+		btf__load_vmlinux_btf;
+		btf__load_module_btf;
 } LIBBPF_0.4.0;
-- 
2.25.1

