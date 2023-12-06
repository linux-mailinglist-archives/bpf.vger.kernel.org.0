Return-Path: <bpf+bounces-16884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AC58071FC
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF10B20FAD
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C23E49F;
	Wed,  6 Dec 2023 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="HLrsHCqv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269DFD59
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 06:13:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso38812625e9.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701872031; x=1702476831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odAFtJgnDKyW71MhMDCtnqE2RXd+U86YhVhwvCqb1Po=;
        b=HLrsHCqvqVff0YoguYSonIepat+ztUox07eACcjaI84I7xWIIgwoz+NG6gXDCIm6Z9
         JBw+gO3ckATR4EXuvOXDIvW+cVFEI3JcZbmfQccBvRxGVupsUFg1HXqMDadk3YwFHfHe
         Heg3RYoiIvlv4s4tL561ja2Qs4ahjwnGtQnvbl5by9gdC+TsyvTQOofU/Oth+er+Pa70
         Yi5ukQ3jJEvyBjtGnMjAxbGF1uSG88dmT1HJZZWgzaVxIQiEUF/wfj00cELPHnfvcpnB
         qtkV1U5XloiGqzvwkkYDSUadYLGaoCQqaQShX35SyGFdxQKxM7BEFO3d5gI3khd63IX1
         kWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872031; x=1702476831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odAFtJgnDKyW71MhMDCtnqE2RXd+U86YhVhwvCqb1Po=;
        b=L7z8rOKY3DbWZVPd/5+oxOZ+EuF1huzuvRlF78U4sIjGoTw5ffw37TrTBIPrG5dHwP
         7avHyWfc9rBskx54XtlmASqi/hP4evXNStXFqtSHBDt9fE8m2OfKIor0/PrZwSbHbOaZ
         xhowLQcx1i9L4MwrNWXlmsjOE7JGZG+ZT3/shiT3gcfAgHn7dwx1Eo9b7XzyWnybD3ck
         6y0M2nsC/d1Cf4MBskdZTMp5kz2khU1xRDlXodxev+P70LuwXba/prvLeAvRmMN6YpBM
         25N25367c6s0VRvzFpNWfsgNTtybZ1atVLkmIrCV53LbIIgLYbHz42CKOvaZqY4ZdT9h
         NO5Q==
X-Gm-Message-State: AOJu0YzaRoSsejIm41vF+qpJJ3qiBDq5f4DxKS7D1nAu/Y6HSOXL8cAq
	C+wWhfO7l+gmA1mJ38g0YbgWng==
X-Google-Smtp-Source: AGHT+IEtkF9XGNFu3RKEA0GQS0zifyYyuxm6CaV3YIYKVfxLzoF56EHv+dhr2W+2ZHRBQ8AMDJnY/w==
X-Received: by 2002:a05:600c:358a:b0:40b:51cc:b98 with SMTP id p10-20020a05600c358a00b0040b51cc0b98mr704561wmq.9.1701872031180;
        Wed, 06 Dec 2023 06:13:51 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040b42df75fcsm22140330wmo.39.2023.12.06.06.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:13:50 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
Date: Wed,  6 Dec 2023 14:10:29 +0000
Message-Id: <20231206141030.1478753-7-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206141030.1478753-1-aspsk@isovalent.com>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the DEFINE_STATIC_KEY() and bpf_static_branch_{unlikely,likely}
macros to mimic Linux Kernel Static Keys API in BPF. Example of usage would
be as follows:

    DEFINE_STATIC_KEY(key);

    void prog(void)
    {
            if (bpf_static_branch_unlikely(&key))
                    /* rarely used code */
            else
                    /* default hot path code */
    }

or, using the likely variant:

    void prog2(void)
    {
            if (bpf_static_branch_likely(&key))
                    /* default hot path code */
            else
                    /* rarely used code */
    }

The "unlikely" version of macro compiles in the code where the else-branch
(key is off) is fall-through, the "likely" macro prioritises the if-branch.

Both macros push an entry in a new ".jump_table" section which contains the
following information:

               32 bits                   32 bits           64 bits
    offset of jump instruction | offset of jump target |    flags

The corresponding ".rel.jump_table" relocations table entry contains the
base section name and the static key (map) name. The bigger portion of this
patch works on parsing, relocating and sending this information to kernel
via the static_branches_info and static_branches_info_size attributes of
the BPF_PROG_LOAD syscall.

The same key may be used multiple times in one program and can be used by
multiple BPF programs. BPF doesn't provide guarantees on order in which
static branches controlled by one key are patched.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/lib/bpf/bpf.c             |   5 +-
 tools/lib/bpf/bpf.h             |   4 +-
 tools/lib/bpf/bpf_helpers.h     |  64 ++++++++
 tools/lib/bpf/libbpf.c          | 273 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |   3 +
 tools/lib/bpf/linker.c          |   8 +-
 6 files changed, 351 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9dc9625651dc..f67d6a4dac05 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -232,7 +232,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, log_true_size);
+	const size_t attr_sz = offsetofend(union bpf_attr, static_branches_info_size);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -262,6 +262,9 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.prog_ifindex = OPTS_GET(opts, prog_ifindex, 0);
 	attr.kern_version = OPTS_GET(opts, kern_version, 0);
 
+	attr.static_branches_info = ptr_to_u64(OPTS_GET(opts, static_branches_info, NULL));
+	attr.static_branches_info_size = OPTS_GET(opts, static_branches_info_size, 0);
+
 	if (prog_name && kernel_supports(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
 	attr.license = ptr_to_u64(license);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index d0f53772bdc0..ec6d4b955fb8 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -102,9 +102,11 @@ struct bpf_prog_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+	struct bpf_static_branch_info *static_branches_info;
+	__u32 static_branches_info_size;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field log_true_size
+#define bpf_prog_load_opts__last_field static_branches_info_size
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 77ceea575dc7..e3bfa0697304 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -400,4 +400,68 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
 )
 #endif /* bpf_repeat */
 
+#define DEFINE_STATIC_KEY(NAME)									\
+	struct {										\
+		__uint(type, BPF_MAP_TYPE_ARRAY);						\
+		__type(key, __u32);								\
+		__type(value, __u32);								\
+		__uint(map_flags, BPF_F_STATIC_KEY);						\
+		__uint(max_entries, 1);								\
+	} NAME SEC(".maps")
+
+#ifndef likely
+#define likely(x)	(__builtin_expect(!!(x), 1))
+#endif
+
+#ifndef unlikely
+#define unlikely(x)	(__builtin_expect(!!(x), 0))
+#endif
+
+static __always_inline int __bpf_static_branch_nop(void *static_key)
+{
+	asm goto("1:\n\t"
+		"goto +0\n\t"
+		".pushsection .jump_table, \"aw\"\n\t"
+		".balign 8\n\t"
+		".long 1b - .\n\t"
+		".long %l[l_yes] - .\n\t"
+		".quad %c0 - .\n\t"
+		".popsection\n\t"
+		:: "i" (static_key)
+		:: l_yes);
+	return 0;
+l_yes:
+	return 1;
+}
+
+static __always_inline int __bpf_static_branch_jump(void *static_key)
+{
+	asm goto("1:\n\t"
+		"goto %l[l_yes]\n\t"
+		".pushsection .jump_table, \"aw\"\n\t"
+		".balign 8\n\t"
+		".long 1b - .\n\t"
+		".long %l[l_yes] - .\n\t"
+		".quad %c0 - . + 1\n\t"
+		".popsection\n\t"
+		:: "i" (static_key)
+		:: l_yes);
+	return 0;
+l_yes:
+	return 1;
+}
+
+/*
+ * The bpf_static_branch_{unlikely,likely} macros provide a way to utilize BPF
+ * Static Keys in BPF programs in exactly the same manner this is done in the
+ * Linux Kernel.  The "unlikely" macro compiles in the code where the else-branch
+ * (key is off) is prioritized, the "likely" macro prioritises the if-branch.
+ */
+
+#define bpf_static_branch_unlikely(static_key) \
+	unlikely(__bpf_static_branch_nop(static_key))
+
+#define bpf_static_branch_likely(static_key) \
+	likely(!__bpf_static_branch_jump(static_key))
+
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067be95da3c..92620717abda 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -391,6 +391,13 @@ struct bpf_sec_def {
 	libbpf_prog_attach_fn_t prog_attach_fn;
 };
 
+struct static_branch_info {
+	struct bpf_map *map;
+	__u32 insn_offset;
+	__u32 jump_target;
+	__u32 flags;
+};
+
 /*
  * bpf_prog should be a better name but it has been used in
  * linux/filter.h.
@@ -463,6 +470,9 @@ struct bpf_program {
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
 	__u32 prog_flags;
+
+	struct static_branch_info *static_branches_info;
+	__u32 static_branches_info_size;
 };
 
 struct bpf_struct_ops {
@@ -493,6 +503,7 @@ struct bpf_struct_ops {
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
+#define STATIC_JUMPS_SEC ".jump_table"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -624,6 +635,7 @@ struct elf_state {
 	Elf_Data *symbols;
 	Elf_Data *st_ops_data;
 	Elf_Data *st_ops_link_data;
+	Elf_Data *static_branches_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -634,6 +646,7 @@ struct elf_state {
 	int symbols_shndx;
 	int st_ops_shndx;
 	int st_ops_link_shndx;
+	int static_branches_shndx;
 };
 
 struct usdt_manager;
@@ -715,6 +728,7 @@ void bpf_program__unload(struct bpf_program *prog)
 
 	zfree(&prog->func_info);
 	zfree(&prog->line_info);
+	zfree(&prog->static_branches_info);
 }
 
 static void bpf_program__exit(struct bpf_program *prog)
@@ -3605,6 +3619,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			} else if (strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
 				obj->efile.st_ops_link_data = data;
 				obj->efile.st_ops_link_shndx = idx;
+			} else if (strcmp(name, STATIC_JUMPS_SEC) == 0) {
+				obj->efile.static_branches_data = data;
+				obj->efile.static_branches_shndx = idx;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -3620,7 +3637,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
-			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
+			    strcmp(name, ".rel" MAPS_ELF_SEC) &&
+			    strcmp(name, ".rel" STATIC_JUMPS_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
 					elf_sec_name(obj, elf_sec_by_idx(obj, targ_sec_idx)) ?: "<?>");
@@ -4422,6 +4440,189 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr, Elf_Dat
 	return 0;
 }
 
+struct jump_table_entry {
+	__u32 insn_offset;
+	__u32 jump_target;
+	union {
+		__u64 map_ptr;	/* map_ptr is always zero, as it is relocated */
+		__u64 flags;	/* so we can reuse it to store flags */
+	};
+};
+
+static struct bpf_program *shndx_to_prog(struct bpf_object *obj,
+					 size_t sec_idx,
+					 struct jump_table_entry *entry)
+{
+	__u32 insn_offset = entry->insn_offset / 8;
+	__u32 jump_target = entry->jump_target / 8;
+	struct bpf_program *prog;
+	size_t i;
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->programs[i];
+		if (prog->sec_idx != sec_idx)
+			continue;
+
+		if (insn_offset < prog->sec_insn_off ||
+		    insn_offset >= prog->sec_insn_off + prog->sec_insn_cnt)
+			continue;
+
+		if (jump_target < prog->sec_insn_off ||
+		    jump_target >= prog->sec_insn_off + prog->sec_insn_cnt) {
+			pr_warn("static branch: offset %u is in boundaries, target %u is not\n",
+				insn_offset, jump_target);
+			return NULL;
+		}
+
+		return prog;
+	}
+
+	return NULL;
+}
+
+static struct bpf_program *find_prog_for_jump_entry(struct bpf_object *obj,
+						    int nrels,
+						    Elf_Data *relo_data,
+						    __u32 entry_offset,
+						    struct jump_table_entry *entry)
+{
+	struct bpf_program *prog;
+	Elf64_Rel *rel;
+	Elf64_Sym *sym;
+	int i;
+
+	for (i = 0; i < nrels; i++) {
+		rel = elf_rel_by_idx(relo_data, i);
+		if (!rel) {
+			pr_warn("static branch: relo #%d: failed to get ELF relo\n", i);
+			return ERR_PTR(-LIBBPF_ERRNO__FORMAT);
+		}
+
+		if ((__u32)rel->r_offset != entry_offset)
+			continue;
+
+		sym = elf_sym_by_idx(obj, ELF64_R_SYM(rel->r_info));
+		if (!sym) {
+			pr_warn("static branch: .maps relo #%d: symbol %zx not found\n",
+				i, (size_t)ELF64_R_SYM(rel->r_info));
+			return ERR_PTR(-LIBBPF_ERRNO__FORMAT);
+		}
+
+		prog = shndx_to_prog(obj, sym->st_shndx, entry);
+		if (!prog) {
+			pr_warn("static branch: .maps relo #%d: program %zx not found\n",
+				i, (size_t)sym->st_shndx);
+			return ERR_PTR(-LIBBPF_ERRNO__FORMAT);
+		}
+		return prog;
+	}
+	return ERR_PTR(-LIBBPF_ERRNO__FORMAT);
+}
+
+static struct bpf_map *find_map_for_jump_entry(struct bpf_object *obj,
+					       int nrels,
+					       Elf_Data *relo_data,
+					       __u32 entry_offset)
+{
+	struct bpf_map *map;
+	const char *name;
+	Elf64_Rel *rel;
+	Elf64_Sym *sym;
+	int i;
+
+	for (i = 0; i < nrels; i++) {
+		rel = elf_rel_by_idx(relo_data, i);
+		if (!rel) {
+			pr_warn("static branch: relo #%d: failed to get ELF relo\n", i);
+			return NULL;
+		}
+
+		if ((__u32)rel->r_offset != entry_offset)
+			continue;
+
+		sym = elf_sym_by_idx(obj, ELF64_R_SYM(rel->r_info));
+		if (!sym) {
+			pr_warn(".maps relo #%d: symbol %zx not found\n",
+				i, (size_t)ELF64_R_SYM(rel->r_info));
+			return NULL;
+		}
+
+		name = elf_sym_str(obj, sym->st_name) ?: "<?>";
+		if (!name || !strcmp(name, "")) {
+			pr_warn(".maps relo #%d: symbol name is zero or empty\n", i);
+			return NULL;
+		}
+
+		map = bpf_object__find_map_by_name(obj, name);
+		if (!map)
+			return NULL;
+		return map;
+	}
+	return NULL;
+}
+
+static int add_static_branch(struct bpf_program *prog,
+			     struct jump_table_entry *entry,
+			     struct bpf_map *map)
+{
+	__u32 size_old = prog->static_branches_info_size;
+	__u32 size_new = size_old + sizeof(struct static_branch_info);
+	struct static_branch_info *info;
+	void *x;
+
+	x = realloc(prog->static_branches_info, size_new);
+	if (!x)
+		return -ENOMEM;
+
+	info = x + size_old;
+	info->insn_offset = entry->insn_offset - prog->sec_insn_off * 8;
+	info->jump_target = entry->jump_target - prog->sec_insn_off * 8;
+	info->flags = (__u32) entry->flags;
+	info->map = map;
+
+	prog->static_branches_info = x;
+	prog->static_branches_info_size = size_new;
+
+	return 0;
+}
+
+static int
+bpf_object__collect_static_branches_relos(struct bpf_object *obj,
+					  Elf64_Shdr *shdr,
+					  Elf_Data *relo_data)
+{
+	Elf_Data *branches_data = obj->efile.static_branches_data;
+	int nrels = shdr->sh_size / shdr->sh_entsize;
+	struct jump_table_entry *entries;
+	size_t i;
+	int err;
+
+	if (!branches_data)
+		return 0;
+
+	entries = (void *)branches_data->d_buf;
+	for (i = 0; i < branches_data->d_size / sizeof(struct jump_table_entry); i++) {
+		__u32 entry_offset = i * sizeof(struct jump_table_entry);
+		struct bpf_program *prog;
+		struct bpf_map *map;
+
+		prog = find_prog_for_jump_entry(obj, nrels, relo_data, entry_offset, &entries[i]);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+
+		map = find_map_for_jump_entry(obj, nrels, relo_data,
+				entry_offset + offsetof(struct jump_table_entry, map_ptr));
+		if (!map)
+			return -EINVAL;
+
+		err = add_static_branch(prog, &entries[i], map);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map)
 {
 	int id;
@@ -6298,10 +6499,44 @@ static struct reloc_desc *find_prog_insn_relo(const struct bpf_program *prog, si
 		       sizeof(*prog->reloc_desc), cmp_relo_by_insn_idx);
 }
 
+static int append_subprog_static_branches(struct bpf_program *main_prog,
+					  struct bpf_program *subprog)
+{
+	size_t subprog_size = subprog->static_branches_info_size;
+	size_t main_size = main_prog->static_branches_info_size;
+	size_t entry_size = sizeof(struct static_branch_info);
+	void *old_info = main_prog->static_branches_info;
+	int n_entries = subprog_size / entry_size;
+	struct static_branch_info *branch;
+	void *new_info;
+	int i;
+
+	if (!subprog_size)
+		return 0;
+
+	new_info = realloc(old_info, subprog_size + main_size);
+	if (!new_info)
+		return -ENOMEM;
+
+	memcpy(new_info + main_size, subprog->static_branches_info, subprog_size);
+
+	for (i = 0; i < n_entries; i++) {
+		branch = new_info + main_size + i * entry_size;
+		branch->insn_offset += subprog->sub_insn_off * 8;
+		branch->jump_target += subprog->sub_insn_off * 8;
+	}
+
+	main_prog->static_branches_info = new_info;
+	main_prog->static_branches_info_size += subprog_size;
+
+	return 0;
+}
+
 static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_program *subprog)
 {
 	int new_cnt = main_prog->nr_reloc + subprog->nr_reloc;
 	struct reloc_desc *relos;
+	int err;
 	int i;
 
 	if (main_prog == subprog)
@@ -6324,6 +6559,11 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	 */
 	main_prog->reloc_desc = relos;
 	main_prog->nr_reloc = new_cnt;
+
+	err = append_subprog_static_branches(main_prog, subprog);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -6879,6 +7119,8 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
 			err = bpf_object__collect_map_relos(obj, shdr, data);
+		else if (idx == obj->efile.static_branches_shndx)
+			err = bpf_object__collect_static_branches_relos(obj, shdr, data);
 		else
 			err = bpf_object__collect_prog_relos(obj, shdr, data);
 		if (err)
@@ -7002,6 +7244,30 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz);
 
+static struct bpf_static_branch_info *
+convert_branch_info(struct static_branch_info *info, size_t size)
+{
+	size_t n = size/sizeof(struct static_branch_info);
+	struct bpf_static_branch_info *bpf_info;
+	size_t i;
+
+	if (!info)
+		return NULL;
+
+	bpf_info = calloc(n, sizeof(struct bpf_static_branch_info));
+	if (!bpf_info)
+		return NULL;
+
+	for (i = 0; i < n; i++) {
+		bpf_info[i].insn_offset = info[i].insn_offset;
+		bpf_info[i].jump_target = info[i].jump_target;
+		bpf_info[i].flags = info[i].flags;
+		bpf_info[i].map_fd = info[i].map->fd;
+	}
+
+	return bpf_info;
+}
+
 static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
 				struct bpf_insn *insns, int insns_cnt,
 				const char *license, __u32 kern_version, int *prog_fd)
@@ -7106,6 +7372,11 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.log_size = log_buf_size;
 	load_attr.log_level = log_level;
 
+	load_attr.static_branches_info = convert_branch_info(prog->static_branches_info,
+							     prog->static_branches_info_size);
+	load_attr.static_branches_info_size = prog->static_branches_info_size /
+			sizeof(struct static_branch_info) * sizeof(struct bpf_static_branch_info);
+
 	ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
 	if (ret >= 0) {
 		if (log_level && own_log_buf) {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index f0f08635adb0..62020e7a58b0 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -40,6 +40,9 @@
 #ifndef R_BPF_64_ABS32
 #define R_BPF_64_ABS32 3
 #endif
+#ifndef R_BPF_64_NODYLD32
+#define R_BPF_64_NODYLD32 4
+#endif
 #ifndef R_BPF_64_32
 #define R_BPF_64_32 10
 #endif
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 5ced96d99f8c..47b343e2813e 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -22,6 +22,7 @@
 #include "strset.h"
 
 #define BTF_EXTERN_SEC ".extern"
+#define STATIC_JUMPS_REL_SEC ".rel.jump_table"
 
 struct src_sec {
 	const char *sec_name;
@@ -888,8 +889,9 @@ static int linker_sanity_check_elf_relos(struct src_obj *obj, struct src_sec *se
 		size_t sym_type = ELF64_R_TYPE(relo->r_info);
 
 		if (sym_type != R_BPF_64_64 && sym_type != R_BPF_64_32 &&
-		    sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32) {
-			pr_warn("ELF relo #%d in section #%zu has unexpected type %zu in %s\n",
+		    sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32 &&
+		    sym_type != R_BPF_64_NODYLD32 && strcmp(sec->sec_name, STATIC_JUMPS_REL_SEC)) {
+			pr_warn("ELF relo #%d in section #%zu unexpected type %zu in %s\n",
 				i, sec->sec_idx, sym_type, obj->filename);
 			return -EINVAL;
 		}
@@ -2087,7 +2089,7 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm += sec->dst_off;
-				} else {
+				} else if (strcmp(src_sec->sec_name, STATIC_JUMPS_REL_SEC)) {
 					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
 					return -EINVAL;
 				}
-- 
2.34.1


