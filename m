Return-Path: <bpf+bounces-54323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5372A6767C
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27378188AF4F
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297A220E706;
	Tue, 18 Mar 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iSC19qDk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE220E33A
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308202; cv=none; b=g55kGX3YliUYafYp6c9fdJWlZIWx15n3mFf1V8QDEtUg0fsgKeuvwESwolXExnL8CtLUlbyDsXIE2rPDKF8ABFb+C1j+3cJSHCn725WS5+UHtm3wlfzP4zpv1GbE79NTQpNhk0U/T30SSt6zrhY8rZOY+E1KA5Bx1lGxurqK+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308202; c=relaxed/simple;
	bh=B9tx1zLKvJBZT9nmOTQldDd8niiTgAWsc+9N9iasq+A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9nikJ1byW4n84mSkCTprHpGhStxGUeh13Z579h2KfHD/8pduaNiV645hbu9kofv+kt4MiIFGSmUpXtJ07fdnYvqT82i5rOHz46qKXFMc4cp9pA+jIDbVkmXEmXA6vzLNISvxiNSn6I+f8eMUi9USNGcSE7EACs4oY38/ZJxZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iSC19qDk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso4923231f8f.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308198; x=1742912998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2111fFDp3wOq8Kh+y3PKWKWjYpgdItLQ7Fr50XOregU=;
        b=iSC19qDkAxEr4OHsqcUfDrHtjvziIURFkq69nHg6K5Ef5qtMoC3QfCaa0bv2YF+6f9
         vUQPpa8Ma9mLsuFG5CPeefOUtnljOMOMz4MdAIoYfdly9mpGAHcZNyC22pIDBphRGm84
         ompXBF1lVwHR/8KKY7sR8lFSHGmJG+xR8fr95n94U12VIzpsItDvP2GzBiVZmv5x5LY6
         GjqzXbWhWSSzILga/PoCFUszyjhtqAPI46++fUaggTXi+LaJkBBZl4RGhqXz7/f/lSFJ
         G/hJq4hIo2RScxA0+70rF895YaqILSlcuJN18WAG4EBkqCll753qde8FoI0GsVWS+poP
         W4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308198; x=1742912998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2111fFDp3wOq8Kh+y3PKWKWjYpgdItLQ7Fr50XOregU=;
        b=GsrWtlVwn/a/QmrYVEYIALjFo2cGVBDZtzYvLWzipiPnd71YMdckiel43ncJMOBxSA
         jE/0KgLo5yHWEYBiTJNM9a5FXgaOVwJjmxFhOt6+7jGFU8ZEIt8V7t+pfOeX+p2mJP4y
         K4iNEIXxzysWPBQVqmqGVCLI6dplZ/QnAQ/OUiT/Vf48uNsp/Py95bY4DkDjlOX3h9lq
         MkW0sGLEUL3T2v7WlaUbzhR/L4CFhcpMZleOgKzInKFrUOsEl8vNCe1YEjLGBiseS1ka
         7X+5UDF/CVL/v+c9OcvLD17NL8B0Q+0Tv0803WtTZsy4zYxBlQNVTLloJ0L0mcndMn/I
         Q3gQ==
X-Gm-Message-State: AOJu0YwdAoKiRMG/zrdlXVg18S7GZz/P8xNuv1L0zlR2oRYILZXCQZ79
	CHJ9SXwq44h2pYx/hhxdip+nOmi7bEccgKvxFW9/qg9Yodmf5ClcVga8LNl4osA1ewJA8pPASJ7
	I
X-Gm-Gg: ASbGnct12Z1VW8AAokHO38wXkBZdn2ltYG3oN5k8AOARgtrrjHo/wHQQe7BY0MvQV+N
	VACFGELfXPsX2cZCzX7exrcKLvz8xY6nNK1mbD/S766oiw6bOdvQctwQKwweclf/rnB6ytii9Dc
	exsYbtcklYDc4G+cJVSMuCxbMjPjtMzqzeFh+qUBK+kULyU6GN8ZPsyZYV8QCKtO9N1eZmT0MUF
	3vn9V/BuPFvs0Y2Ntk2ULRVyOxItIjSaFtrivH9MfOW87EqjXn7p1QcYGgtscf+nD+18n4x/PlQ
	7wi2VSvHBEzI9bwYumta/Uk7fRLkC37cf6ZitLLCOlVMFcMT60ZDYCyNxQ==
X-Google-Smtp-Source: AGHT+IGRjf45Oey7gwQkektzZEfB8tYdBD843D/sljyUUX1yD+G3sk7QKQ4fRj6944tMXyatu0HBLg==
X-Received: by 2002:a05:6000:1a8c:b0:391:48d4:bd02 with SMTP id ffacd0b85a97d-3996b47c944mr4072789f8f.29.1742308197933;
        Tue, 18 Mar 2025 07:29:57 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:57 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 12/14] libbpf: BPF Static Keys support
Date: Tue, 18 Mar 2025 14:33:16 +0000
Message-Id: <20250318143318.656785-13-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the DEFINE_STATIC_KEY() and bpf_static_branch_{unlikely,likely}
macros to mimic Linux Kernel Static Keys API in BPF.

Example of usage would be as follows:

    DEFINE_STATIC_KEY(key);

    void prog(void)
    {
            if (bpf_static_branch_unlikely(key))
                    /* rarely used code */
            else
                    /* default hot path code */
    }

or, using the likely variant:

    void prog(void)
    {
            if (bpf_static_branch_likely(key))
                    /* default hot path code */
            else
                    /* rarely used code */
    }

The "unlikely" version of macro compiles in the code where the
else-branch (key is off) is fall-through, the "likely" macro
prioritises the if-branch.

Both macros push an entry in the new ".static_keys" section, which
contains the following information:

               32 bits                   32 bits           64 bits
    offset of jump instruction | offset of jump target |    flags

The corresponding ".rel.static_keys" relocations table entry contains
the static key name. This information is enough to construct corresponding
INSN_SET maps.

NOTE. This is an RFC version of the patch. The main design flow of it
is what to do when a static key is used in a noinline function and/or
in two BPF programs. Consider the following example:

    DEFINE_STATIC_KEY(key);

    static __noinline foo()
    {
            if (bpf_static_key_unlikely(&key)) {
                /* do something special */
            }
            ...
    }

    SEC("xdp")
    int prog1(ctx) {
        foo();
        ...
    }

    SEC("xdp")
    int prog2(ctx) {
        foo();
        ...
    }

The problem here is that when such an ELF object is parsed and loaded
by libbpf, then, from the kernel point of view, two programs are
loaded: prog1 + a copy of "foo", then prog2 + a copy of "foo".
However, the static key "key" can only be used in one program (and,
of course, it will point to different instructions in both cases, as
prog1/prog2 have different sizes + there might be more relocations).
The solution is to actually create private copies of the key "key"
per "load object". This automatically allows to reuse the "same"
static key for multiple programs.

From the uAPI perspective, the bpf_static_key_update() system call
only operates on a particular "atomic" object -- a map representing
the static key. However, there should be a way to toggle all the keys
derived from the "key" (this should looks more natural for a user,
as from the C perspective there is only one object).
So, the following changes to the API should be

  * when libbpf opens an object, it replaces "key" with private per-prog
    instances "prog1_key", "prog2_key", etc. Then these static keys can be
    already set individually by the bpf syscall

  * for "wrapper API", either introduce a helper which takes a skeleton and key
    name, or just generate a helper in the generated skeleton (does this introduce
    new API as well?)

Some other bugs included in this patch (as before the libbpf API is
discussed, this might be painful to re-implement this patch +
selftests). One obvious bug is that gen-loader is not supported.
Another one related to fd_array. Namely, in order to pass static
keys on load, they should be placed in fd_array, and fd_array_cnt
must be set. The current code in libbpf creates an fd_array which
is shared between all the programs in the ELF object, which doesn't
work if fd_array_cnt is set to non-zero, as all maps/btfs in
fd_array[0,...,fd_array_cnt-1] are bound to the program. So instead,
loader should create private copy of fd_array per bpf_prog_load.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/lib/bpf/bpf_helpers.h     |  55 +++++
 tools/lib/bpf/libbpf.c          | 362 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |   3 +
 tools/lib/bpf/linker.c          |   6 +-
 4 files changed, 423 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index a50773d4616e..c66f579d3ddf 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -429,4 +429,59 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
 )
 #endif /* bpf_repeat */
 
+#define DEFINE_STATIC_KEY(NAME)									\
+	struct {										\
+		__uint(type, BPF_MAP_TYPE_INSN_SET);						\
+		__type(key, __u32);								\
+		__type(value, __u32);								\
+		__uint(map_extra, BPF_F_STATIC_KEY);						\
+	} NAME SEC(".maps")
+
+static __always_inline int __bpf_static_branch_nop(void *static_key)
+{
+	asm goto("1:\n\t"
+		"gotol_or_nop %l[l_yes]\n\t"
+		".pushsection .static_keys, \"aw\"\n\t"
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
+		"nop_or_gotol %l[l_yes]\n\t"
+		".pushsection .static_keys, \"aw\"\n\t"
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
index 6b85060f07b3..fdf00bc32366 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -422,6 +422,17 @@ struct bpf_sec_def {
 	libbpf_prog_attach_fn_t prog_attach_fn;
 };
 
+struct static_key_insn {
+	__u32 insn_offset;
+	__u32 jump_target;
+};
+
+struct static_key {
+	struct bpf_map *map;
+	struct static_key_insn *insns;
+	__u32 insns_cnt;
+};
+
 /*
  * bpf_prog should be a better name but it has been used in
  * linux/filter.h.
@@ -494,6 +505,9 @@ struct bpf_program {
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
 	__u32 prog_flags;
+
+	struct static_key *static_keys;
+	__u32 static_keys_cnt;
 };
 
 struct bpf_struct_ops {
@@ -523,6 +537,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define STATIC_KEYS_SEC ".static_keys"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -656,6 +671,7 @@ struct elf_state {
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
 	Elf_Data *arena_data;
+	Elf_Data *static_keys_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -666,6 +682,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int static_keys_data_shndx;
 };
 
 struct usdt_manager;
@@ -763,6 +780,7 @@ void bpf_program__unload(struct bpf_program *prog)
 
 	zfree(&prog->func_info);
 	zfree(&prog->line_info);
+	zfree(&prog->static_keys);
 }
 
 static void bpf_program__exit(struct bpf_program *prog)
@@ -1895,6 +1913,213 @@ static char *internal_map_name(struct bpf_object *obj, const char *real_name)
 	return strdup(map_name);
 }
 
+struct static_keys_table_entry {
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
+					 struct static_keys_table_entry *entry)
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
+			pr_warn("static key: offset %u is in boundaries, target %u is not\n",
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
+						    struct static_keys_table_entry *entry)
+{
+	struct bpf_program *prog;
+	Elf64_Rel *rel;
+	Elf64_Sym *sym;
+	int i;
+
+	for (i = 0; i < nrels; i++) {
+		rel = elf_rel_by_idx(relo_data, i);
+		if (!rel) {
+			pr_warn("static key: relo #%d: failed to get ELF relo\n", i);
+			return ERR_PTR(-LIBBPF_ERRNO__FORMAT);
+		}
+
+		if ((__u32)rel->r_offset != entry_offset)
+			continue;
+
+		sym = elf_sym_by_idx(obj, ELF64_R_SYM(rel->r_info));
+		if (!sym) {
+			pr_warn("static key: .maps relo #%d: symbol %zx not found\n",
+				i, (size_t)ELF64_R_SYM(rel->r_info));
+			return ERR_PTR(-LIBBPF_ERRNO__FORMAT);
+		}
+
+		prog = shndx_to_prog(obj, sym->st_shndx, entry);
+		if (!prog) {
+			pr_warn("static key: .maps relo #%d: program %zx not found\n",
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
+			pr_warn("static key: relo #%d: failed to get ELF relo\n", i);
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
+static struct static_key *find_static_key(struct bpf_program *prog, struct bpf_map *map)
+{
+	__u32 i;
+
+	for (i = 0; i < prog->static_keys_cnt; i++)
+		if (prog->static_keys[i].map == map)
+			return &prog->static_keys[i];
+
+	return NULL;
+}
+
+static int add_static_key_insn(struct bpf_program *prog,
+			       struct static_keys_table_entry *entry,
+			       struct bpf_map *map)
+{
+	struct static_key_insn *insn;
+	struct static_key *key;
+	void *x;
+
+	key = find_static_key(prog, map);
+	if (!key) {
+		__u32 size_old = prog->static_keys_cnt * sizeof(*key);
+
+		x = realloc(prog->static_keys, size_old + sizeof(*key));
+		if (!x)
+			return -ENOMEM;
+
+		prog->static_keys = x;
+		prog->static_keys_cnt += 1;
+
+		key = x + size_old;
+		key->map = map;
+		key->insns = NULL;
+		key->insns_cnt = 0;
+	}
+
+	x = realloc(key->insns, (key->insns_cnt + 1) * sizeof(key->insns[0]));
+	if (!x)
+		return -ENOMEM;
+
+	key->insns = x;
+	insn = &key->insns[key->insns_cnt++];
+	insn->insn_offset = (entry->insn_offset / 8) - prog->sec_insn_off;
+	insn->jump_target = (entry->jump_target / 8) - prog->sec_insn_off;
+	key->map->def.max_entries += 1;
+
+	return 0;
+}
+
+static int
+bpf_object__collect_static_keys_relos(struct bpf_object *obj,
+				      Elf64_Shdr *shdr,
+				      Elf_Data *relo_data)
+{
+	Elf_Data *data = obj->efile.static_keys_data;
+	int nrels = shdr->sh_size / shdr->sh_entsize;
+	struct static_keys_table_entry *entries;
+	size_t i;
+	int err;
+
+	if (!data)
+		return 0;
+
+	entries = (void *)data->d_buf;
+	for (i = 0; i < data->d_size / sizeof(struct static_keys_table_entry); i++) {
+		__u32 entry_offset = i * sizeof(struct static_keys_table_entry);
+		struct bpf_program *prog;
+		struct bpf_map *map;
+
+		prog = find_prog_for_jump_entry(obj, nrels, relo_data, entry_offset, &entries[i]);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+
+		map = find_map_for_jump_entry(obj, nrels, relo_data,
+				entry_offset + offsetof(struct static_keys_table_entry, map_ptr));
+		if (!map)
+			return -EINVAL;
+
+		err = add_static_key_insn(prog, &entries[i], map);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int
 map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map);
 
@@ -3951,6 +4176,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			} else if (strcmp(name, ARENA_SEC) == 0) {
 				obj->efile.arena_data = data;
 				obj->efile.arena_data_shndx = idx;
+			} else if (strcmp(name, STATIC_KEYS_SEC) == 0) {
+				obj->efile.static_keys_data = data;
+				obj->efile.static_keys_data_shndx = idx;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -3968,7 +4196,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_LINK_SEC) &&
-			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
+			    strcmp(name, ".rel" MAPS_ELF_SEC) &&
+			    strcmp(name, ".rel" STATIC_KEYS_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
 					elf_sec_name(obj, elf_sec_by_idx(obj, targ_sec_idx)) ?: "<?>");
@@ -5200,6 +5429,69 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 	return 0;
 }
 
+static struct static_key *
+bpf_object__find_static_key(struct bpf_object *obj, struct bpf_map *map)
+{
+	struct static_key *key = NULL;
+	int i;
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		key = find_static_key(&obj->programs[i], map);
+		if (key)
+			return key;
+	}
+
+	return NULL;
+}
+
+static int bpf_object__init_static_key_map(struct bpf_object *obj,
+					   struct bpf_map *map)
+{
+	struct static_key *key;
+	__u32 map_key;
+	int err;
+	int i;
+
+	if (obj->gen_loader) {
+		pr_warn("not supported: obj->gen_loader ^ static keys\n");
+		return libbpf_err(-ENOTSUP);
+	}
+
+	key = bpf_object__find_static_key(obj, map);
+	if (!key) {
+		pr_warn("map '%s': static key is not used by any program\n",
+			bpf_map__name(map));
+		return libbpf_err(-EINVAL);
+	}
+
+	if (key->insns_cnt != map->def.max_entries) {
+		pr_warn("map '%s': static key #entries and max_entries differ: %d != %d\n",
+			bpf_map__name(map), key->insns_cnt, map->def.max_entries);
+		return libbpf_err(-EINVAL);
+	}
+
+	for (i = 0; i < key->insns_cnt; i++) {
+		map_key = key->insns[i].insn_offset;
+		err = bpf_map_update_elem(map->fd, &i, &map_key, 0);
+		if (err) {
+			err = -errno;
+			pr_warn("map '%s': failed to set initial contents: %s\n",
+				bpf_map__name(map), errstr(err));
+			return err;
+		}
+	}
+
+	err = bpf_map_freeze(map->fd);
+	if (err) {
+		err = -errno;
+		pr_warn("map '%s': failed to freeze as read-only: %s\n",
+			bpf_map__name(map), errstr(err));
+		return err;
+	}
+
+	return 0;
+}
+
 static void bpf_map__destroy(struct bpf_map *map);
 
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
@@ -5520,6 +5812,12 @@ bpf_object__create_maps(struct bpf_object *obj)
 					memcpy(map->mmaped, obj->arena_data, obj->arena_data_sz);
 					zfree(&obj->arena_data);
 				}
+			} else if (map->def.type == BPF_MAP_TYPE_INSN_SET) {
+				if (map->map_extra & BPF_F_STATIC_KEY) {
+					err = bpf_object__init_static_key_map(obj, map);
+					if (err < 0)
+						goto err_out;
+				}
 			}
 			if (map->init_slots_sz && map->def.type != BPF_MAP_TYPE_PROG_ARRAY) {
 				err = init_map_in_map_slots(obj, map);
@@ -6344,10 +6642,43 @@ static struct reloc_desc *find_prog_insn_relo(const struct bpf_program *prog, si
 		       sizeof(*prog->reloc_desc), cmp_relo_by_insn_idx);
 }
 
+static int append_subprog_static_keys(struct bpf_program *main_prog,
+				      struct bpf_program *subprog)
+{
+	size_t main_size = main_prog->static_keys_cnt * sizeof(struct static_key);
+	size_t subprog_size = subprog->static_keys_cnt * sizeof(struct static_key);
+	struct static_key *key;
+	void *new_keys;
+	int i, j;
+
+	if (!subprog->static_keys_cnt)
+		return 0;
+
+	new_keys = realloc(main_prog->static_keys, subprog_size + main_size);
+	if (!new_keys)
+		return -ENOMEM;
+
+	memcpy(new_keys + main_size, subprog->static_keys, subprog_size);
+
+	for (i = 0; i < subprog->static_keys_cnt; i++) {
+		key = new_keys + main_size + i * sizeof(struct static_key);
+		for (j = 0; j < key->insns_cnt; j++) {
+			key->insns[j].insn_offset += subprog->sub_insn_off;
+			key->insns[j].jump_target += subprog->sub_insn_off;
+		}
+	}
+
+	main_prog->static_keys = new_keys;
+	main_prog->static_keys_cnt += subprog->static_keys_cnt;
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
@@ -6370,6 +6701,11 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	 */
 	main_prog->reloc_desc = relos;
 	main_prog->nr_reloc = new_cnt;
+
+	err = append_subprog_static_keys(main_prog, subprog);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -7337,6 +7673,8 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
 			err = bpf_object__collect_map_relos(obj, shdr, data);
+		else if (idx == obj->efile.static_keys_data_shndx)
+			err = bpf_object__collect_static_keys_relos(obj, shdr, data);
 		else
 			err = bpf_object__collect_prog_relos(obj, shdr, data);
 		if (err)
@@ -7461,6 +7799,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		opts->attach_btf_obj_fd = btf_obj_fd;
 		opts->attach_btf_id = btf_type_id;
 	}
+
 	return 0;
 }
 
@@ -7551,6 +7890,27 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		return 0;
 	}
 
+	if (obj->fd_array_cnt) {
+		pr_warn("not supported: fd_array was already present\n");
+		return -ENOTSUP;
+	} else if (prog->static_keys_cnt) {
+		int i, fd, *fd_array;
+
+		fd_array = calloc(prog->static_keys_cnt, sizeof(int));
+		if (!fd_array)
+			return -ENOMEM;
+
+		for (i = 0; i < prog->static_keys_cnt; i++) {
+			fd = prog->static_keys[i].map->fd;
+			if (fd < 0)
+				return -EINVAL;
+			fd_array[i] = fd;
+		}
+
+		load_attr.fd_array = fd_array;
+		load_attr.fd_array_cnt = prog->static_keys_cnt;
+	}
+
 retry_load:
 	/* if log_level is zero, we don't request logs initially even if
 	 * custom log_buf is specified; if the program load fails, then we'll
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 76669c73dcd1..0235e85832c2 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -56,6 +56,9 @@
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
index 800e0ef09c37..4bcf122d053c 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -28,6 +28,7 @@
 #include "str_error.h"
 
 #define BTF_EXTERN_SEC ".extern"
+#define STATIC_KEYS_REL_SEC ".rel.static_keys"
 
 struct src_sec {
 	const char *sec_name;
@@ -1037,7 +1038,8 @@ static int linker_sanity_check_elf_relos(struct src_obj *obj, struct src_sec *se
 		size_t sym_type = ELF64_R_TYPE(relo->r_info);
 
 		if (sym_type != R_BPF_64_64 && sym_type != R_BPF_64_32 &&
-		    sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32) {
+		    sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32 &&
+		    sym_type != R_BPF_64_NODYLD32 && strcmp(sec->sec_name, STATIC_KEYS_REL_SEC)) {
 			pr_warn("ELF relo #%d in section #%zu has unexpected type %zu in %s\n",
 				i, sec->sec_idx, sym_type, obj->filename);
 			return -EINVAL;
@@ -2272,7 +2274,7 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm += sec->dst_off;
-				} else {
+				} else if (strcmp(src_sec->sec_name, STATIC_KEYS_REL_SEC)) {
 					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
 					return -EINVAL;
 				}
-- 
2.34.1


