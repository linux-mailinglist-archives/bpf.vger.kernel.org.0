Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD65FAA18
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJKB2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiJKB2A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:28:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CAE1838B
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 10so11914836pli.0
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVxD/e6U/VoCyTLyftSz/kzHDPCpXEaqpNPy49ZtOP4=;
        b=JNA+m1m7kRv9Z9gFc5FwWKtUuMJ2gi+eMHWwAZtbuxKk7DMfs39sE2FJN87oiWDBrN
         Im91FyGCshjZkfIz75Rc2Ns+szfyxsYlB7//IdEfXlLx5SMqVPOb7fuD3IX6BjOzWGHq
         SkSUhFrGdWk200pUIUWrype9y5MYr4EaP72YdK6VdGjftvrOVIvh+OZor3GUY/lS03/y
         gMQ+ayB7eJ9Nt0X1q5DzOd3d2kk9PF9c52BMz0ZZ4oN0rKO93bXW8Aot5Pm2cbwmApDu
         NXFF8Q9rSkTXl2UNRGZ9YvekClllg1tNDxFoY/rthxwHO0zXfFuZEHZ9gOI5gbAtdjoU
         tBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVxD/e6U/VoCyTLyftSz/kzHDPCpXEaqpNPy49ZtOP4=;
        b=UFH0RCQOVJPZ+eS1Aci8Wb/kGR3RfCQgk7Dmq9ASwAZQlrtFJoM2XfWZawoMwL6rVs
         QYT1/U3MVu06I1FF1Nas2SkHdio9pFG6gq/bVg3TPTLm+8ssKV2bzjnFBBfpV3vcLZzf
         TdxoFFaRFcqsJcKpCb1Y5D/BEc0yrqjCAM1pUe5sT9oFSvztYWIPGPb44ToZWH09rBQ8
         +Ub5zf6NYkBAHw7m6D75MuR2+SXZMyffu9/w5F/uOQX928gaNQNMpaht9hRVVuoU2Xqx
         4aBcbLz65z5xFobloJlSpkUbtNzQ2uB9eiP1AeLwqXgBPfeG4moCEWiQa265YbLYx/Ui
         OhMw==
X-Gm-Message-State: ACrzQf0vCkO/SL4Abk+ja6YiIGAgLoYBkqfGaanah5CbuUxHYK1IGspI
        sMYXXqwRJLcv0U5H/E/N/dRT4pZ64cxCbQ==
X-Google-Smtp-Source: AMsMyM7DqlWK2SLWSNqoB/qUF7WUs/M8jLhIYS+NrGm538BNQUyXoyWiqDJQm5E4waBT5a+YEsya/w==
X-Received: by 2002:a17:90b:1b41:b0:20a:f406:2b90 with SMTP id nv1-20020a17090b1b4100b0020af4062b90mr24355140pjb.7.1665451678127;
        Mon, 10 Oct 2022 18:27:58 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7940e000000b00562677968aesm7604549pfo.72.2022.10.10.18.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:27:57 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 23/25] libbpf: Add support for private BSS map section
Date:   Tue, 11 Oct 2022 06:52:38 +0530
Message-Id: <20221011012240.3149-24-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7442; i=memxor@gmail.com; h=from:subject; bh=57gLGeWKLC1nCIuExtqPWr0STzM9s89D1zmt9MG0lIU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUbFbUMUO/tFuo0HuBKVA0xa+DPtwuk0YurbtzF 2HyJQu2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGwAKCRBM4MiGSL8Rym9kEA CqSRHnZAQhAHfm46Soyq58tNaHMZBkT+6WEG43VTQmEUWGi+s4aY35T0Z/XwPrXgeRVdrrW4aQkr5u DaJcrdiPo9DW+7CCFPUxYB1i3T8bDPa3s1UZ1Kd/+D4PZKuW/C6xMvxjypTxMoe6U0gpYsRYLsHC4i WpK/03HcwXwdh+hhZ0huwde6li394XYL1NhOO3UV93pJfC2DFYTFQxniCCn/77QSMxqZ7AscOvjrRW U7hkkxHgN2Xp9rhRVn09dtTEzry16Ge1TiUO0cmfYEq2oiCHdYtqUMiC/Kb7HwYM9cCgNmpRW9pCT6 +kETm0cM6PKIgrYt+4t4UJC99pIYbEGw2tH9b9CqIGPDBzqNkargGfgqqdI+LYB5onRxmmZFkzEN8I /xNgO5SArXU/mbI6mPkOtlqGH6IadpKOFOg8xcCFapSEQKevZ01ychSPSnLCf4VBDyC2SAkydczxwY AhNyBJykfeMV3elKN5+Dm0AEisLE+Qq9pR6NdpIwuo4MJKvYKqLf5p0scTx6p8+GLwkmznBZuZ5nrO hcUaKCBBuv+oattJYk+JoQp/wDYsWM9l5yy2H9fwYSNLpU7RhpvA6jHvWs6JU+g+mNQPPTjznxeH5u PNl+DYgTBiTydGVcCe4ihEHj6Qp10Kz5WGi5olgJgTq5BJxZ4z0YTHNcYwMA==
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
2.34.1

