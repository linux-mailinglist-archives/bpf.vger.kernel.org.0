Return-Path: <bpf+bounces-48464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F2A08262
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC023A857A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6574202F72;
	Thu,  9 Jan 2025 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eyCywxp0"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008AC1FF617
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459246; cv=none; b=A5IhZNlpOnAJgR3rtVopP2DNAU0fQ6AvVghXWo2q42YYsBo/SbrU6zDnlZ5hV1rVSU3Dq1Xi7hN3lRhz6jBg9UtaezBdwljhswSuapD9whdGSvy1rR3MK4UzWjzKleRNwAh909zmItqU3i2k3Rowb0f35aB41yIYG1d4y/YOPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459246; c=relaxed/simple;
	bh=/cBDmvCHF6f150+aqxCNNQymVhhdJpBLR5PeEeU56oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvG7pJBgm2VQ6am19m9sA7eADdtEIr3vEdxRKWXdikBENuDSYVgn0rG8vrnomrki6o7zV7DHjCaG7ysdjfjqHYTq/tipAc5eX876no+MVMymBcImrjp7hANGofNlBxF4/XV9pj9q6Mbj7m0GseKpHoihw/mTGBzmshRPZX2llIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eyCywxp0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8669203E3BC;
	Thu,  9 Jan 2025 13:47:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8669203E3BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459244;
	bh=+sa5nAvOB+Lxlj2kzQHy4u83ZRNGE+gmcDLGoo02OiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyCywxp06Vd5WuUjonp9qHurjFxaDtTyTItgDR7au7M6dieH7SSYHsdCsxaP2Pe6B
	 7TbJimgKanZazL+HeKmwu9GtYAUnGqgdkFWlxALTDGXGlDdzAhHRgiCGODuGWr5wnU
	 ok6pAiMoXfqB19jXocjEreXl7r44dLHLPUlL9PGM=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 02/14] bpf: Add data structures for managing in-kernel eBPF relocations
Date: Thu,  9 Jan 2025 13:43:44 -0800
Message-ID: <20250109214617.485144-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here we introduce several new structs used in the management of ebpf
instruction relocation metadata. These structs are heavily inspired by
existing definitions from libbpf, albeit a bit stripped down for
kernel use along with some semantical changes due to differing elf
abstractions between userspace and kernelspace.

Additionally we introduce several struct definitions and macros for
the handling of .btf.ext sections which are utilized by libbpf but
missing from the kernel.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/linux/bpf.h | 257 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3ace0d6227e3c..0859e71e2641c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1631,6 +1631,263 @@ struct bpf_prog {
 	};
 };
 
+struct btf_ext_info {
+	/*
+	 * info points to the individual info section (e.g. func_info and
+	 * line_info) from the .BTF.ext. It does not include the __u32 rec_size.
+	 */
+	void *info;
+	__u32 rec_size;
+	__u32 len;
+	/* optional (maintained internally by libbpf) mapping between .BTF.ext
+	 * section and corresponding ELF section. This is used to join
+	 * information like CO-RE relocation records with corresponding BPF
+	 * programs defined in ELF sections
+	 */
+	__u32 *sec_idxs;
+	int sec_cnt;
+};
+
+#define for_each_btf_ext_sec(seg, sec)					\
+	for (sec = (seg)->info;						\
+	     (void *)sec < (seg)->info + (seg)->len;			\
+	     sec = (void *)sec + sizeof(struct btf_ext_info_sec) +	\
+		   (seg)->rec_size * sec->num_info)
+
+#define for_each_btf_ext_rec(seg, sec, i, rec)				\
+	for (i = 0, rec = (void *)&(sec)->data;				\
+	     i < (sec)->num_info;					\
+	     i++, rec = (void *)rec + (seg)->rec_size)
+
+/*
+ * The .BTF.ext ELF section layout defined as
+ *   struct btf_ext_header
+ *   func_info subsection
+ *
+ * The func_info subsection layout:
+ *   record size for struct bpf_func_info in the func_info subsection
+ *   struct btf_sec_func_info for section #1
+ *   a list of bpf_func_info records for section #1
+ *     where struct bpf_func_info mimics one in include/uapi/linux/bpf.h
+ *     but may not be identical
+ *   struct btf_sec_func_info for section #2
+ *   a list of bpf_func_info records for section #2
+ *   ......
+ *
+ * Note that the bpf_func_info record size in .BTF.ext may not
+ * be the same as the one defined in include/uapi/linux/bpf.h.
+ * The loader should ensure that record_size meets minimum
+ * requirement and pass the record as is to the kernel. The
+ * kernel will handle the func_info properly based on its contents.
+ */
+struct btf_ext_header {
+	__u16	magic;
+	__u8	version;
+	__u8	flags;
+	__u32	hdr_len;
+
+	/* All offsets are in bytes relative to the end of this header */
+	__u32	func_info_off;
+	__u32	func_info_len;
+	__u32	line_info_off;
+	__u32	line_info_len;
+
+	/* optional part of .BTF.ext header */
+	__u32	core_relo_off;
+	__u32	core_relo_len;
+};
+
+struct btf_ext {
+	union {
+		struct btf_ext_header *hdr;
+		void *data;
+	};
+	struct btf_ext_info func_info;
+	struct btf_ext_info line_info;
+	struct btf_ext_info core_relo_info;
+	__u32 data_size;
+};
+
+struct btf_ext_info_sec {
+	__u32	sec_name_off;
+	__u32	num_info;
+	/* Followed by num_info * record_size number of bytes */
+	__u8	data[];
+};
+
+
+enum bpf_reloc_type {
+	RELO_LD64,
+	RELO_CALL,
+	RELO_DATA,
+	RELO_EXTERN_LD64,
+	RELO_EXTERN_CALL,
+	RELO_SUBPROG_ADDR,
+	RELO_CORE,
+};
+
+struct bpf_reloc_desc {
+	enum bpf_reloc_type type;
+	int insn_idx;
+	union {
+		const struct bpf_core_relo *core_relo; /* used when type == RELO_CORE */
+		struct {
+			int map_idx;
+			int sym_off;
+			int ext_idx;
+		};
+	};
+};
+
+enum bpf_extern_type {
+	EXT_UNKNOWN,
+	EXT_KCFG,
+	EXT_KSYM,
+};
+
+enum bpf_kcfg_type {
+	KCFG_UNKNOWN,
+	KCFG_CHAR,
+	KCFG_BOOL,
+	KCFG_INT,
+	KCFG_TRISTATE,
+	KCFG_CHAR_ARR,
+};
+
+struct bpf_extern_desc {
+	enum bpf_extern_type type;
+	int sym_idx;
+	int btf_id;
+	int sec_btf_id;
+	const char *name;
+	char *essent_name;
+	bool is_set;
+	bool is_weak;
+	union {
+		struct {
+			enum bpf_kcfg_type type;
+			int sz;
+			int align;
+			int data_off;
+			bool is_signed;
+		} kcfg;
+		struct {
+			unsigned long long addr;
+
+			/* target btf_id of the corresponding kernel var. */
+			int kernel_btf_obj_fd;
+			int kernel_btf_id;
+
+			/* local btf_id of the ksym extern's type. */
+			__u32 type_id;
+			/* BTF fd index to be patched in for insn->off, this is
+			 * 0 for vmlinux BTF, index in obj->fd_array for module
+			 * BTF
+			 */
+			__s16 btf_fd_idx;
+		} ksym;
+	};
+};
+
+
+struct bpf_prog_obj {
+	char *name;
+
+	struct bpf_insn *insn;
+	unsigned int insn_cnt;
+
+	size_t sec_idx;
+	size_t sec_insn_off;
+	size_t sec_insn_cnt;
+	size_t sub_insn_off;
+
+	struct bpf_reloc_desc *reloc_desc;
+	int nr_reloc;
+
+	int exception_cb_idx;
+
+};
+
+struct bpf_st_ops {
+	const char *tname;
+	const struct btf_type *type;
+	struct bpf_program **progs;
+	__u32 *kern_func_off;
+	/* e.g. struct tcp_congestion_ops in bpf_prog's btf format */
+	void *data;
+	/* e.g. struct bpf_struct_ops_tcp_congestion_ops in
+	 *      btf_vmlinux's format.
+	 * struct bpf_struct_ops_tcp_congestion_ops {
+	 *	[... some other kernel fields ...]
+	 *	struct tcp_congestion_ops data;
+	 * }
+	 * kern_vdata-size == sizeof(struct bpf_struct_ops_tcp_congestion_ops)
+	 * bpf_map__init_kern_struct_ops() will populate the "kern_vdata"
+	 * from "data".
+	 */
+	void *kern_vdata;
+	__u32 type_id;
+};
+
+enum libbpf_map_type {
+	LIBBPF_MAP_UNSPEC,
+	LIBBPF_MAP_DATA,
+	LIBBPF_MAP_BSS,
+	LIBBPF_MAP_RODATA,
+	LIBBPF_MAP_KCONFIG,
+};
+
+struct bpf_map_obj {
+	u32 map_type;
+	u32 fd;
+	u32 sec_idx;
+	u32 sec_offset;
+};
+
+struct bpf_module_obj {
+	u32 id;
+	u32 fd;
+	u32 fd_array_idx;
+};
+
+struct bpf_module_btf {
+	struct btf *btf;
+	u32 id;
+	int fd;
+	int fd_array_idx;
+};
+
+struct bpf_obj {
+	u32 nr_programs;
+	Elf_Ehdr *hdr;
+	unsigned long len;
+	Elf_Shdr *sechdrs;
+	char *secstrings, *strtab;
+
+	struct {
+		unsigned int sym, str, btf, btf_ext, text, arena;
+	} index;
+
+	struct bpf_prog_obj *progs;
+
+	struct btf *btf;
+	struct btf_ext *btf_ext;
+
+	struct bpf_extern_desc *externs;
+	int nr_extern;
+
+	struct bpf_map_obj *maps;
+	int nr_maps;
+
+	int arena_map_idx;
+	int kconfig_map_idx;
+
+	struct btf *btf_vmlinux;
+
+	struct bpf_module_btf *btf_modules;
+	int btf_modules_cnt;
+};
+
 struct bpf_array_aux {
 	/* Programs with direct jumps into programs part of this array. */
 	struct list_head poke_progs;
-- 
2.47.1


