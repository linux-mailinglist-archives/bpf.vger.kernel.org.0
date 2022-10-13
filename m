Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08805FD4C3
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJMGYr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJMGYp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABCDF17
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h10so974798plb.2
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9GlUD1lt5WgFdVGyElG5sRCdDKcrQ1U2o5683UtVTQ=;
        b=mW2jjQT+sLfH0fE5Buji2qxXMu0SE7xSU5/pm/hFVnaZO6ZlQUOxYiVawsWh3WjQ5p
         gA+zlDqbJaVcSaI12ON8vezyxQvg4vZYzStJShuEGKwQfWcJms7Ye0A1FJt1nd7sNb4g
         Kvvw8Rl9lMsyREpR5J3AQyxPAr6xIR9HdUcmsqlWSYDTC+mJO7nKJEtLsm6vDawDnfTS
         9RXoQYyPraMAy/itp78Xy9akkU17d31zIOms4vJ32RgOLxbaYZcgOfoRGDYWqeZ186js
         XVEng/CBEBhnjQ27j8t/AiFinT1SupapLTi0yFWvVtMorQHddFNdbh/uBHrhelag1jlA
         rZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9GlUD1lt5WgFdVGyElG5sRCdDKcrQ1U2o5683UtVTQ=;
        b=zgRwA5oL4OOE5EPfOIgmrwEF9/+9ksSQiiinQPKW8488YEwG/2s/FR4G14gHLcMRDQ
         xW4mzeUFTLI6shNerLfCzLzUiHnowaCNzm/qvhlSGhaVllrVHcZgsNGlqeIss8unyE/z
         RQRkuYromV8YGOkGItV+LwBWHVKfweN8aIOc0qAajO+RG3M6lCxDiuz5hdoG0JmKklW4
         h95yVH3qrxs1WzQOVbcWxpZfRvHbPE06Xm9Da+/66L2xfdfNP0Cjij3tq0RteJBBEcfI
         mhNZ68KYBlikoHT2IDGpAN5Ol3hqrbnU9dzkivsrLNvPA/46KXC4mPa8qJyexdS62gDF
         NiZA==
X-Gm-Message-State: ACrzQf26xvozpO84ulEK/JFg1XSoyUbz3kgNcM3pVEmFHZYrAUWa9rpi
        8y/NnNZBySvMg4/Z01J2HdE9o5iB98Q=
X-Google-Smtp-Source: AMsMyM7eWktyUzhlo0cHoNsfqq5PEdIrD4keELz4XB4/kCNmY9yafbuKHSq1JtvOU8dP9MilYuF05w==
X-Received: by 2002:a17:90b:400f:b0:20a:9965:ef08 with SMTP id ie15-20020a17090b400f00b0020a9965ef08mr9547612pjb.155.1665642283242;
        Wed, 12 Oct 2022 23:24:43 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id e6-20020a656886000000b0043b565cb57csm10829046pgt.73.2022.10.12.23.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:42 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 23/25] libbpf: Add support for private BSS map section
Date:   Thu, 13 Oct 2022 11:53:01 +0530
Message-Id: <20221013062303.896469-24-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7442; i=memxor@gmail.com; h=from:subject; bh=k3muFEoTX8/C5fafawMM+3XLRM5Skoq6ZayNn+WwaHM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67Eh17HkkNi8+fO4UsQkQRjWjEtJB7WYrKK0O8S MaopK3qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euxAAKCRBM4MiGSL8RyhAxD/ 9BXT4oN9U0Gu6JVhy0VcWLLELANtq1Qy/MAeR5XGsEqA1jHbb68djSM/n+usl+T/kgow5RA0QwGuNm WMROFvHYNi2GacMSfw1tf1CeB1ZnTNL7szO+q5w/QEnFCGJI3EvuwKPSbjf0puQ0Q1DweP6iYTlK/f NLVHa9t3WfGqT4Oy7kjiZ7r4J4ll832SKAPN7juq0cXcnLbCxlwXpUE6ips8dH8ECMbzVeReehtAzc 0DTrHZfk/HX0ZHlRozdaoCPopgPs826kuMehqXr/KhFQNuizWjfKDxczPnb6hWlpeafBvVybfO072Z aZ7hhv8hUkGfoFKD3aqKw7N1VU2rZwhSwFRuAwOY1+fRHZTgKObQp5oxHt6rrUCLmxlvEyG0PZIQkq z78SJ3pGSEENgvgItSxJfTqK39YdspPjLw7UaLdlsId6oo3OpkygF9Pv2tleLPiAwO7X76ni9AFWNF PAOD+hTVU/W8qcTpdCPOeGy4x0pSG6Exl5IziNffbuzljF8X1DQ7aExoepYu0omdvBdZKaECw6Fq1Y BKBUCphnsuNAhO6rIKR3hHxl2kHzWJElEPRMprPC43x3bsKjhbf7jTwCTRYFGlEtnzZ+EvP1g3a7LY LWIiwIGllXp/jROPpCRmdMP/DmJOepG6Y3oeo7SOxHHARr+aSVfHcHutKMaw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Dave Marchevsky <davemarchevsky@fb.com>

Currently libbpf does not allow declaration of a struct bpf_spin_lock in
global scope. Attempting to do so results in "failed to re-mmap" error,
as .bss arraymap containing spinlock is not allowed to be mmap'd.

This patch adds support for a .bss.private section. The maps contained
in this section will not be mmaped into userspace by libbpf, nor will
they be exposed via bpftool-generated skeleton.

Intent here is to allow more natural programming pattern for
global-scope spinlocks which will be used by rbtree locking mechanism in
further patches in this series.

Notes:

  * Initially I called the section .bss.no_mmap, but the broader
    'private' term better indicates that skeleton shouldn't expose these
    maps at all, IMO.

  * bpftool/gen.c's is_internal_mmapable_map function checks whether the
    map flags have BPF_F_MMAPABLE, so no bpftool changes were necessary
    to remove .bss.private maps from skeleton

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.c | 65 ++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 184ce1684dcd..fc4d15515b02 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -465,6 +465,7 @@ struct bpf_struct_ops {
 #define KCONFIG_SEC ".kconfig"
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
+#define BSS_SEC_PRIVATE ".bss.private"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -578,6 +579,7 @@ enum sec_type {
 	SEC_BSS,
 	SEC_DATA,
 	SEC_RODATA,
+	SEC_BSS_PRIVATE,
 };
 
 struct elf_sec_desc {
@@ -1582,7 +1584,8 @@ bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map);
 
 static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
-			      const char *real_name, int sec_idx, void *data, size_t data_sz)
+			      const char *real_name, int sec_idx, void *data,
+			      size_t data_sz, bool do_mmap)
 {
 	struct bpf_map_def *def;
 	struct bpf_map *map;
@@ -1610,27 +1613,31 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	def->max_entries = 1;
 	def->map_flags = type == LIBBPF_MAP_RODATA || type == LIBBPF_MAP_KCONFIG
 			 ? BPF_F_RDONLY_PROG : 0;
-	def->map_flags |= BPF_F_MMAPABLE;
+	if (do_mmap)
+		def->map_flags |= BPF_F_MMAPABLE;
 
 	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
 		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
 
-	map->mmaped = mmap(NULL, bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
-			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	if (map->mmaped == MAP_FAILED) {
-		err = -errno;
-		map->mmaped = NULL;
-		pr_warn("failed to alloc map '%s' content buffer: %d\n",
-			map->name, err);
-		zfree(&map->real_name);
-		zfree(&map->name);
-		return err;
+	map->mmaped = NULL;
+	if (do_mmap) {
+		map->mmaped = mmap(NULL, bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
+				   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+		if (map->mmaped == MAP_FAILED) {
+			err = -errno;
+			map->mmaped = NULL;
+			pr_warn("failed to alloc map '%s' content buffer: %d\n",
+				map->name, err);
+			zfree(&map->real_name);
+			zfree(&map->name);
+			return err;
+		}
 	}
 
 	/* failures are fine because of maps like .rodata.str1.1 */
 	(void) bpf_map_find_btf_info(obj, map);
 
-	if (data)
+	if (do_mmap && data)
 		memcpy(map->mmaped, data, data_sz);
 
 	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
@@ -1642,12 +1649,14 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 	struct elf_sec_desc *sec_desc;
 	const char *sec_name;
 	int err = 0, sec_idx;
+	bool do_mmap;
 
 	/*
 	 * Populate obj->maps with libbpf internal maps.
 	 */
 	for (sec_idx = 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
 		sec_desc = &obj->efile.secs[sec_idx];
+		do_mmap = true;
 
 		/* Skip recognized sections with size 0. */
 		if (!sec_desc->data || sec_desc->data->d_size == 0)
@@ -1659,7 +1668,8 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_DATA,
 							    sec_name, sec_idx,
 							    sec_desc->data->d_buf,
-							    sec_desc->data->d_size);
+							    sec_desc->data->d_size,
+							    do_mmap);
 			break;
 		case SEC_RODATA:
 			obj->has_rodata = true;
@@ -1667,14 +1677,18 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_RODATA,
 							    sec_name, sec_idx,
 							    sec_desc->data->d_buf,
-							    sec_desc->data->d_size);
+							    sec_desc->data->d_size,
+							    do_mmap);
 			break;
+		case SEC_BSS_PRIVATE:
+			do_mmap = false;
 		case SEC_BSS:
 			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_BSS,
 							    sec_name, sec_idx,
 							    NULL,
-							    sec_desc->data->d_size);
+							    sec_desc->data->d_size,
+							    do_mmap);
 			break;
 		default:
 			/* skip */
@@ -1988,7 +2002,7 @@ static int bpf_object__init_kconfig_map(struct bpf_object *obj)
 	map_sz = last_ext->kcfg.data_off + last_ext->kcfg.sz;
 	err = bpf_object__init_internal_map(obj, LIBBPF_MAP_KCONFIG,
 					    ".kconfig", obj->efile.symbols_shndx,
-					    NULL, map_sz);
+					    NULL, map_sz, true);
 	if (err)
 		return err;
 
@@ -3449,6 +3463,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			sec_desc->sec_type = SEC_BSS;
 			sec_desc->shdr = sh;
 			sec_desc->data = data;
+		} else if (sh->sh_type == SHT_NOBITS && strcmp(name, BSS_SEC_PRIVATE) == 0) {
+			sec_desc->sec_type = SEC_BSS_PRIVATE;
+			sec_desc->shdr = sh;
+			sec_desc->data = data;
 		} else {
 			pr_info("elf: skipping section(%d) %s (size %zu)\n", idx, name,
 				(size_t)sh->sh_size);
@@ -3911,6 +3929,7 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 	case SEC_BSS:
 	case SEC_DATA:
 	case SEC_RODATA:
+	case SEC_BSS_PRIVATE:
 		return true;
 	default:
 		return false;
@@ -3930,6 +3949,7 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 		return LIBBPF_MAP_KCONFIG;
 
 	switch (obj->efile.secs[shndx].sec_type) {
+	case SEC_BSS_PRIVATE:
 	case SEC_BSS:
 		return LIBBPF_MAP_BSS;
 	case SEC_DATA:
@@ -4919,16 +4939,19 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 {
 	enum libbpf_map_type map_type = map->libbpf_type;
 	char *cp, errmsg[STRERR_BUFSIZE];
-	int err, zero = 0;
+	int err = 0, zero = 0;
 
 	if (obj->gen_loader) {
-		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
-					 map->mmaped, map->def.value_size);
+		if (map->mmaped)
+			bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
+						 map->mmaped, map->def.value_size);
 		if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG)
 			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
 		return 0;
 	}
-	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
+
+	if (map->mmaped)
+		err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
 	if (err) {
 		err = -errno;
 		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-- 
2.38.0

