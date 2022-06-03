Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9304253D21B
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 21:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348727AbiFCTDz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 3 Jun 2022 15:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348711AbiFCTDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 15:03:54 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A9A3120B
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 12:03:52 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253GmdDA030100
        for <bpf@vger.kernel.org>; Fri, 3 Jun 2022 12:03:52 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gevuu9fg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 12:03:51 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 3 Jun 2022 12:03:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0311E1AC9C412; Fri,  3 Jun 2022 12:03:44 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 07/15] libbpf: remove prog_info_linear APIs
Date:   Fri, 3 Jun 2022 12:01:47 -0700
Message-ID: <20220603190155.3924899-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603190155.3924899-1-andrii@kernel.org>
References: <20220603190155.3924899-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RjYX9jyX6-BKbyqaa9XRY_bhXL5Z2pxY
X-Proofpoint-ORIG-GUID: RjYX9jyX6-BKbyqaa9XRY_bhXL5Z2pxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_06,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove prog_info_linear-related APIs previously used by perf.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 248 ---------------------------------------
 tools/lib/bpf/libbpf.h   |  66 -----------
 tools/lib/bpf/libbpf.map |   3 -
 3 files changed, 317 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 422c9d4811f4..93b1e1f95e64 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12546,254 +12546,6 @@ int perf_buffer__consume(struct perf_buffer *pb)
 	return 0;
 }
 
-struct bpf_prog_info_array_desc {
-	int	array_offset;	/* e.g. offset of jited_prog_insns */
-	int	count_offset;	/* e.g. offset of jited_prog_len */
-	int	size_offset;	/* > 0: offset of rec size,
-				 * < 0: fix size of -size_offset
-				 */
-};
-
-static struct bpf_prog_info_array_desc bpf_prog_info_array_desc[] = {
-	[BPF_PROG_INFO_JITED_INSNS] = {
-		offsetof(struct bpf_prog_info, jited_prog_insns),
-		offsetof(struct bpf_prog_info, jited_prog_len),
-		-1,
-	},
-	[BPF_PROG_INFO_XLATED_INSNS] = {
-		offsetof(struct bpf_prog_info, xlated_prog_insns),
-		offsetof(struct bpf_prog_info, xlated_prog_len),
-		-1,
-	},
-	[BPF_PROG_INFO_MAP_IDS] = {
-		offsetof(struct bpf_prog_info, map_ids),
-		offsetof(struct bpf_prog_info, nr_map_ids),
-		-(int)sizeof(__u32),
-	},
-	[BPF_PROG_INFO_JITED_KSYMS] = {
-		offsetof(struct bpf_prog_info, jited_ksyms),
-		offsetof(struct bpf_prog_info, nr_jited_ksyms),
-		-(int)sizeof(__u64),
-	},
-	[BPF_PROG_INFO_JITED_FUNC_LENS] = {
-		offsetof(struct bpf_prog_info, jited_func_lens),
-		offsetof(struct bpf_prog_info, nr_jited_func_lens),
-		-(int)sizeof(__u32),
-	},
-	[BPF_PROG_INFO_FUNC_INFO] = {
-		offsetof(struct bpf_prog_info, func_info),
-		offsetof(struct bpf_prog_info, nr_func_info),
-		offsetof(struct bpf_prog_info, func_info_rec_size),
-	},
-	[BPF_PROG_INFO_LINE_INFO] = {
-		offsetof(struct bpf_prog_info, line_info),
-		offsetof(struct bpf_prog_info, nr_line_info),
-		offsetof(struct bpf_prog_info, line_info_rec_size),
-	},
-	[BPF_PROG_INFO_JITED_LINE_INFO] = {
-		offsetof(struct bpf_prog_info, jited_line_info),
-		offsetof(struct bpf_prog_info, nr_jited_line_info),
-		offsetof(struct bpf_prog_info, jited_line_info_rec_size),
-	},
-	[BPF_PROG_INFO_PROG_TAGS] = {
-		offsetof(struct bpf_prog_info, prog_tags),
-		offsetof(struct bpf_prog_info, nr_prog_tags),
-		-(int)sizeof(__u8) * BPF_TAG_SIZE,
-	},
-
-};
-
-static __u32 bpf_prog_info_read_offset_u32(struct bpf_prog_info *info,
-					   int offset)
-{
-	__u32 *array = (__u32 *)info;
-
-	if (offset >= 0)
-		return array[offset / sizeof(__u32)];
-	return -(int)offset;
-}
-
-static __u64 bpf_prog_info_read_offset_u64(struct bpf_prog_info *info,
-					   int offset)
-{
-	__u64 *array = (__u64 *)info;
-
-	if (offset >= 0)
-		return array[offset / sizeof(__u64)];
-	return -(int)offset;
-}
-
-static void bpf_prog_info_set_offset_u32(struct bpf_prog_info *info, int offset,
-					 __u32 val)
-{
-	__u32 *array = (__u32 *)info;
-
-	if (offset >= 0)
-		array[offset / sizeof(__u32)] = val;
-}
-
-static void bpf_prog_info_set_offset_u64(struct bpf_prog_info *info, int offset,
-					 __u64 val)
-{
-	__u64 *array = (__u64 *)info;
-
-	if (offset >= 0)
-		array[offset / sizeof(__u64)] = val;
-}
-
-struct bpf_prog_info_linear *
-bpf_program__get_prog_info_linear(int fd, __u64 arrays)
-{
-	struct bpf_prog_info_linear *info_linear;
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	__u32 data_len = 0;
-	int i, err;
-	void *ptr;
-
-	if (arrays >> BPF_PROG_INFO_LAST_ARRAY)
-		return libbpf_err_ptr(-EINVAL);
-
-	/* step 1: get array dimensions */
-	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
-	if (err) {
-		pr_debug("can't get prog info: %s", strerror(errno));
-		return libbpf_err_ptr(-EFAULT);
-	}
-
-	/* step 2: calculate total size of all arrays */
-	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
-		bool include_array = (arrays & (1UL << i)) > 0;
-		struct bpf_prog_info_array_desc *desc;
-		__u32 count, size;
-
-		desc = bpf_prog_info_array_desc + i;
-
-		/* kernel is too old to support this field */
-		if (info_len < desc->array_offset + sizeof(__u32) ||
-		    info_len < desc->count_offset + sizeof(__u32) ||
-		    (desc->size_offset > 0 && info_len < desc->size_offset))
-			include_array = false;
-
-		if (!include_array) {
-			arrays &= ~(1UL << i);	/* clear the bit */
-			continue;
-		}
-
-		count = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
-		size  = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
-
-		data_len += count * size;
-	}
-
-	/* step 3: allocate continuous memory */
-	data_len = roundup(data_len, sizeof(__u64));
-	info_linear = malloc(sizeof(struct bpf_prog_info_linear) + data_len);
-	if (!info_linear)
-		return libbpf_err_ptr(-ENOMEM);
-
-	/* step 4: fill data to info_linear->info */
-	info_linear->arrays = arrays;
-	memset(&info_linear->info, 0, sizeof(info));
-	ptr = info_linear->data;
-
-	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
-		struct bpf_prog_info_array_desc *desc;
-		__u32 count, size;
-
-		if ((arrays & (1UL << i)) == 0)
-			continue;
-
-		desc  = bpf_prog_info_array_desc + i;
-		count = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
-		size  = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
-		bpf_prog_info_set_offset_u32(&info_linear->info,
-					     desc->count_offset, count);
-		bpf_prog_info_set_offset_u32(&info_linear->info,
-					     desc->size_offset, size);
-		bpf_prog_info_set_offset_u64(&info_linear->info,
-					     desc->array_offset,
-					     ptr_to_u64(ptr));
-		ptr += count * size;
-	}
-
-	/* step 5: call syscall again to get required arrays */
-	err = bpf_obj_get_info_by_fd(fd, &info_linear->info, &info_len);
-	if (err) {
-		pr_debug("can't get prog info: %s", strerror(errno));
-		free(info_linear);
-		return libbpf_err_ptr(-EFAULT);
-	}
-
-	/* step 6: verify the data */
-	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
-		struct bpf_prog_info_array_desc *desc;
-		__u32 v1, v2;
-
-		if ((arrays & (1UL << i)) == 0)
-			continue;
-
-		desc = bpf_prog_info_array_desc + i;
-		v1 = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
-		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
-						   desc->count_offset);
-		if (v1 != v2)
-			pr_warn("%s: mismatch in element count\n", __func__);
-
-		v1 = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
-		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
-						   desc->size_offset);
-		if (v1 != v2)
-			pr_warn("%s: mismatch in rec size\n", __func__);
-	}
-
-	/* step 7: update info_len and data_len */
-	info_linear->info_len = sizeof(struct bpf_prog_info);
-	info_linear->data_len = data_len;
-
-	return info_linear;
-}
-
-void bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear)
-{
-	int i;
-
-	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
-		struct bpf_prog_info_array_desc *desc;
-		__u64 addr, offs;
-
-		if ((info_linear->arrays & (1UL << i)) == 0)
-			continue;
-
-		desc = bpf_prog_info_array_desc + i;
-		addr = bpf_prog_info_read_offset_u64(&info_linear->info,
-						     desc->array_offset);
-		offs = addr - ptr_to_u64(info_linear->data);
-		bpf_prog_info_set_offset_u64(&info_linear->info,
-					     desc->array_offset, offs);
-	}
-}
-
-void bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear)
-{
-	int i;
-
-	for (i = BPF_PROG_INFO_FIRST_ARRAY; i < BPF_PROG_INFO_LAST_ARRAY; ++i) {
-		struct bpf_prog_info_array_desc *desc;
-		__u64 addr, offs;
-
-		if ((info_linear->arrays & (1UL << i)) == 0)
-			continue;
-
-		desc = bpf_prog_info_array_desc + i;
-		offs = bpf_prog_info_read_offset_u64(&info_linear->info,
-						     desc->array_offset);
-		addr = offs + ptr_to_u64(info_linear->data);
-		bpf_prog_info_set_offset_u64(&info_linear->info,
-					     desc->array_offset, addr);
-	}
-}
-
 int bpf_program__set_attach_target(struct bpf_program *prog,
 				   int attach_prog_fd,
 				   const char *attach_func_name)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5dc4271fcdb7..e6357ea7bf41 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1396,72 +1396,6 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
 LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
 				       enum bpf_func_id helper_id, const void *opts);
 
-/*
- * Get bpf_prog_info in continuous memory
- *
- * struct bpf_prog_info has multiple arrays. The user has option to choose
- * arrays to fetch from kernel. The following APIs provide an uniform way to
- * fetch these data. All arrays in bpf_prog_info are stored in a single
- * continuous memory region. This makes it easy to store the info in a
- * file.
- *
- * Before writing bpf_prog_info_linear to files, it is necessary to
- * translate pointers in bpf_prog_info to offsets. Helper functions
- * bpf_program__bpil_addr_to_offs() and bpf_program__bpil_offs_to_addr()
- * are introduced to switch between pointers and offsets.
- *
- * Examples:
- *   # To fetch map_ids and prog_tags:
- *   __u64 arrays = (1UL << BPF_PROG_INFO_MAP_IDS) |
- *           (1UL << BPF_PROG_INFO_PROG_TAGS);
- *   struct bpf_prog_info_linear *info_linear =
- *           bpf_program__get_prog_info_linear(fd, arrays);
- *
- *   # To save data in file
- *   bpf_program__bpil_addr_to_offs(info_linear);
- *   write(f, info_linear, sizeof(*info_linear) + info_linear->data_len);
- *
- *   # To read data from file
- *   read(f, info_linear, <proper_size>);
- *   bpf_program__bpil_offs_to_addr(info_linear);
- */
-enum bpf_prog_info_array {
-	BPF_PROG_INFO_FIRST_ARRAY = 0,
-	BPF_PROG_INFO_JITED_INSNS = 0,
-	BPF_PROG_INFO_XLATED_INSNS,
-	BPF_PROG_INFO_MAP_IDS,
-	BPF_PROG_INFO_JITED_KSYMS,
-	BPF_PROG_INFO_JITED_FUNC_LENS,
-	BPF_PROG_INFO_FUNC_INFO,
-	BPF_PROG_INFO_LINE_INFO,
-	BPF_PROG_INFO_JITED_LINE_INFO,
-	BPF_PROG_INFO_PROG_TAGS,
-	BPF_PROG_INFO_LAST_ARRAY,
-};
-
-struct bpf_prog_info_linear {
-	/* size of struct bpf_prog_info, when the tool is compiled */
-	__u32			info_len;
-	/* total bytes allocated for data, round up to 8 bytes */
-	__u32			data_len;
-	/* which arrays are included in data */
-	__u64			arrays;
-	struct bpf_prog_info	info;
-	__u8			data[];
-};
-
-LIBBPF_DEPRECATED_SINCE(0, 6, "use a custom linear prog_info wrapper")
-LIBBPF_API struct bpf_prog_info_linear *
-bpf_program__get_prog_info_linear(int fd, __u64 arrays);
-
-LIBBPF_DEPRECATED_SINCE(0, 6, "use a custom linear prog_info wrapper")
-LIBBPF_API void
-bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
-
-LIBBPF_DEPRECATED_SINCE(0, 6, "use a custom linear prog_info wrapper")
-LIBBPF_API void
-bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
-
 /**
  * @brief **libbpf_num_possible_cpus()** is a helper function to get the
  * number of possible CPUs that the host kernel supports and expects.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 88c622b784d9..1bb5d076b17e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -118,9 +118,6 @@ LIBBPF_0.0.2 {
 		btf_ext__free;
 		btf_ext__get_raw_data;
 		btf_ext__new;
-		bpf_program__get_prog_info_linear;
-		bpf_program__bpil_addr_to_offs;
-		bpf_program__bpil_offs_to_addr;
 } LIBBPF_0.0.1;
 
 LIBBPF_0.0.3 {
-- 
2.30.2

