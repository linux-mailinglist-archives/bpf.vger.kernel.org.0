Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD45AC67F
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiIDUm2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiIDUmV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:21 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACC92CDDB
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:20 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w2so9104259edc.0
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IBwhPgvsOB/iNZbwal7QzccKUKMxmtQLNIo8pu0QN6Y=;
        b=S9o1UpIh0tw6ilPxxlbQgy3S8gV9/ke5cuATzHfyJlhjGtHDtmQbos4XNLEl1fvqZJ
         cGYB0C++ObwXCriOh4QNsDH4RgyYpeGk7uTWCtQSAYibMH0G7/wNKXaqLLTsm+V8nwIP
         uIW9uHkX5KQ2KmjGSbDK42pG4PymVLrSLZ4FguJs53tfONiopzyhJgq2LLTX/1mMbJSf
         iB3xa081g7itq91neGlT1Jq4yW5xnWL048+U3E7iuPV6MxgpnTWvyHIHS2fWphBCZNhW
         8mukQsmeU5747YNdohKgRjH8iIUaHJsZIMzO1eY6Lub8E0HF6PAxYe+OymYEH3f37mYE
         MK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IBwhPgvsOB/iNZbwal7QzccKUKMxmtQLNIo8pu0QN6Y=;
        b=dw0eRkBqmSTmVFVBJ22+0RjgaDr0ABlSupwD7Sf2Oju9eHtDfA8sY6nhyy6j9MeNDu
         pBfkyIkG57hubntBf0xqGPjn759yhM/cwInknXAgevwLna9EMDDxvurVIlj6FpyXpo2A
         2TwaEo0JQMxYax/3X2SouvuCBqbwikSNtqou66NgCKP1WPc9OIfVOYVmrkc/x/sE0l1c
         1jMGyFUZNUwDaqbuNauvR+HLHHhYoVN1IUWDrr2//7TmJPYkgJzZ57+NOFrfzrhRfPrL
         U+WR/fNXv15bI09jXxdpE+KL6AiyTnLWtgw/pGSxTh6j8bMd6fPdLjWmF/EtO8pRTh6g
         u6Yg==
X-Gm-Message-State: ACgBeo0bWSW1YfD9XPfeCPwIP6kSGNUymdgalNL69hY3vMIUHY3ekOcu
        O1Qy1LgPfOQvmjSWSmtCjVAJsPlczefeQA==
X-Google-Smtp-Source: AA6agR7TlP4osHd2x3JodLtbsil4/gSHfx4y+SZHipqA5rjIVGyOdqWbTC3EQ0u5ifX8IjvP8umzRg==
X-Received: by 2002:aa7:d853:0:b0:44e:8a89:52f with SMTP id f19-20020aa7d853000000b0044e8a89052fmr1302506eds.293.1662324139581;
        Sun, 04 Sep 2022 13:42:19 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906394900b0073d7862a5a5sm4121342eje.141.2022.09.04.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:19 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 29/32] libbpf: Add support for private BSS map section
Date:   Sun,  4 Sep 2022 22:41:42 +0200
Message-Id: <20220904204145.3089-30-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7442; i=memxor@gmail.com; h=from:subject; bh=Ywhk11K7h9ygimkFmErpzMTetRu9BmnAc4rUe7JlnVk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1yXAMVncFUKB4+WV1L4wxFSpLO8cD53PXbQVNS DKDHtkSJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcgAKCRBM4MiGSL8RytZkEA C0Sf0kXsNjcZGhleR240oKqkaUspZ6/rUwocw7XTXzBm78Xcfw+//47Bry0n/eNRWi61FdyHeD6yds O8iWizvLURUGZL4o5kTo0FyDiNTYY6ojuolclyJmmmsMs2LsP6ZCkrpL9iv5UJ/Yav8Vu+UtVJ1oVl YIvtMbxha+uTYmAzTEtlAWaBdewFQ2Np2kHTVqhidb6ndqFtec7miJYWnOSO1QlXSdQ8+jtfd1neWi c2ykD/P06VovnjkVmZEq0cfVul+0fjOGR4jS70ZNh7/9uvlrIG7CvZXfERclNtM6XC9C9t6gaIG4ck jq6g5PalWMkEo1V21q3YFcnMFXTi7zZpmLxHVv6qxMCE9lrpwmQ0yUxzh5PtbjvsXtrf1PaeXSC12N KDox25TgXMAoGTqdontTTb2z59+IWbgYqoNqbgy3XftpnIHoEMdbsNwrtgl8krw1wtyAuUHVOaEMzu DeZDnjFsvXbxXEH4nOq8hnePkDyE0OcQ0E7YqfCQ9gOJ8XfCIMWF2nfpMpDcZI50Yr0JYn8bB8YptS +n1gF8QEuRwMl9TiU9NYisYGyWhFeYPkZZzjDv9qdNPLp7ZUafWn7fnmoGJLwUPpBW/G9rzH86NkYa DNWB1Ia1Kq94TCRBA1iUXHYOxR4TdFTNJjU/YaksJbc+XPyEQPW6gRKjdPWA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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
index 3ad139285fad..17989dd49179 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -464,6 +464,7 @@ struct bpf_struct_ops {
 #define KCONFIG_SEC ".kconfig"
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
+#define BSS_SEC_PRIVATE ".bss.private"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -577,6 +578,7 @@ enum sec_type {
 	SEC_BSS,
 	SEC_DATA,
 	SEC_RODATA,
+	SEC_BSS_PRIVATE,
 };
 
 struct elf_sec_desc {
@@ -1581,7 +1583,8 @@ bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map);
 
 static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
-			      const char *real_name, int sec_idx, void *data, size_t data_sz)
+			      const char *real_name, int sec_idx, void *data,
+			      size_t data_sz, bool do_mmap)
 {
 	struct bpf_map_def *def;
 	struct bpf_map *map;
@@ -1609,27 +1612,31 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
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
@@ -1641,12 +1648,14 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
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
@@ -1658,7 +1667,8 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_DATA,
 							    sec_name, sec_idx,
 							    sec_desc->data->d_buf,
-							    sec_desc->data->d_size);
+							    sec_desc->data->d_size,
+							    do_mmap);
 			break;
 		case SEC_RODATA:
 			obj->has_rodata = true;
@@ -1666,14 +1676,18 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
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
@@ -1987,7 +2001,7 @@ static int bpf_object__init_kconfig_map(struct bpf_object *obj)
 	map_sz = last_ext->kcfg.data_off + last_ext->kcfg.sz;
 	err = bpf_object__init_internal_map(obj, LIBBPF_MAP_KCONFIG,
 					    ".kconfig", obj->efile.symbols_shndx,
-					    NULL, map_sz);
+					    NULL, map_sz, true);
 	if (err)
 		return err;
 
@@ -3431,6 +3445,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -3893,6 +3911,7 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 	case SEC_BSS:
 	case SEC_DATA:
 	case SEC_RODATA:
+	case SEC_BSS_PRIVATE:
 		return true;
 	default:
 		return false;
@@ -3912,6 +3931,7 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 		return LIBBPF_MAP_KCONFIG;
 
 	switch (obj->efile.secs[shndx].sec_type) {
+	case SEC_BSS_PRIVATE:
 	case SEC_BSS:
 		return LIBBPF_MAP_BSS;
 	case SEC_DATA:
@@ -4901,16 +4921,19 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
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

