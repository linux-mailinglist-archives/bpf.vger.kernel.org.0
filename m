Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE13D93A1
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 18:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhG1Qzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1Qzo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 12:55:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9030C061757
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 09:55:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c16so3416701plh.7
        for <bpf@vger.kernel.org>; Wed, 28 Jul 2021 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whDJaf7RVSOm4RbPz78E8VrR5U8cw75/2SHmqgVXWPY=;
        b=qN5lzI74E5iMdHRtKTxQsJRtdGsX9zon1qEwQ4BbeZA6aq0Gt3UuZY9ZTd0phiK2sD
         ccyjM25uB/Q8RbFIvhrNoJ00Hv2xWq6E2TVg5/sLTO/SLbG7WlOQtywHLkhJAlXNazSq
         Hk/Fy4/UiTuYUg6q22HnI80TxsuWcv91IFvqIhevV0VyoKF5q7z013HZ53+brP7/VThE
         zTFsAg1DYcQvKjlBVuWqrn0Shnw7eMq8V3fDRp1Jtk5R6DfZO2Don+KurPLO0PIBbpvh
         bnkfMo8U9K4/TYX4r8bP8u7zlBnOl/2AXHOjHo4JR5fEnkwvpJfDqz4YlvgzHKpArjje
         fAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whDJaf7RVSOm4RbPz78E8VrR5U8cw75/2SHmqgVXWPY=;
        b=oXMRj7FLjM2UWemQxb0sszJmOr+Y9PhEmdgM7NZgR2lMGv4D8xxwDQxHYs/qwIlLIU
         5k9yQlJg8YkfaM6GUlljXE40Le/K/fvDhfVGldy9UbY+9CWEFnnCGXuahwlfGwPa6A8z
         nmB9K+oN+/X+ycr3K8/TFVKjCbeDTbzbH2RvQRhjT8seayhoVzlR8xL5NKbMIB6cItGm
         MYFbUbEsDhTI54MQOoWmYPocRislRkX9hoYUJe17Bc9xnN8KU/O3sIuePOrp5RbDVF1i
         nqkyCbq2Nwqq53Jpucud7Hv4vZo3kNu3skcs6b7hji//NiMuEqnEIVYcP8vcJEBF5TTd
         VWUQ==
X-Gm-Message-State: AOAM530Dfn+XauYvxzmEUmiBUhW+88qVsnGSgmp5pg8QYPhhC2jvVi1L
        xsdAT980O/jxTu9vFjR1Kp4hbKTLcnoakw==
X-Google-Smtp-Source: ABdhPJzJuKT0P9J1RSpT0EBHgTi+/RJIsfvW+pDMdDboOyZhE/F+ZCUNLySkS17tNmSUgincJKaRRw==
X-Received: by 2002:a63:fe51:: with SMTP id x17mr748758pgj.58.1627491341043;
        Wed, 28 Jul 2021 09:55:41 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id y187sm491505pfb.185.2021.07.28.09.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:55:40 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2] libbpf: add libbpf_load_vmlinux_btf/libbpf_load_module_btf APIs
Date:   Thu, 29 Jul 2021 00:55:25 +0800
Message-Id: <20210728165525.19104-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two new APIs: libbpf_load_vmlinux_btf/libbpf_load_module_btf.
libbpf_load_vmlinux_btf is just an alias to the existing API named
libbpf_find_kernel_btf, rename it to be more precisely.
libbpf_load_module_btf can be used to load module BTF, add it for
completeness. These two APIs are useful for implementing tracing
tools and introspection tools.
This is part of the efforts towards libbpf 1.0. [1]

[1] https://github.com/libbpf/libbpf/issues/280

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/btf.c      | 15 ++++++++++++++-
 tools/lib/bpf/btf.h      |  2 ++
 tools/lib/bpf/libbpf.c   |  4 ++--
 tools/lib/bpf/libbpf.map |  2 ++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b46760b93bb4..5f801739a1a2 100644
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
@@ -4440,6 +4445,14 @@ struct btf *libbpf_find_kernel_btf(void)
 	return libbpf_err_ptr(-ESRCH);
 }
 
+struct btf *libbpf_load_module_btf(const char *module_name, struct btf *vmlinux_btf)
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
index 374e9f15de2e..1abf94e3bd9e 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -90,6 +90,8 @@ LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
 LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
 
 LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
+LIBBPF_API struct btf *libbpf_load_vmlinux_btf(void);
+LIBBPF_API struct btf *libbpf_load_module_btf(const char *module_name, struct btf *vmlinux_btf);
 
 LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a1ca6fb0c6d8..321d8f4889af 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2680,7 +2680,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
 	if (!force && !obj_needs_vmlinux_btf(obj))
 		return 0;
 
-	obj->btf_vmlinux = libbpf_find_kernel_btf();
+	obj->btf_vmlinux = libbpf_load_vmlinux_btf();
 	err = libbpf_get_error(obj->btf_vmlinux);
 	if (err) {
 		pr_warn("Error loading vmlinux BTF: %d\n", err);
@@ -8297,7 +8297,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
 	struct btf *btf;
 	int err;
 
-	btf = libbpf_find_kernel_btf();
+	btf = libbpf_load_vmlinux_btf();
 	err = libbpf_get_error(btf);
 	if (err) {
 		pr_warn("vmlinux BTF is not found\n");
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

