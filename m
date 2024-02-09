Return-Path: <bpf+bounces-21598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB60D84EF92
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408441F288D8
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1D5258;
	Fri,  9 Feb 2024 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAGacgMi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB46953B8
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451634; cv=none; b=iRRjMvfcjENi5ps0PMo6CEBGl7FjvkGmlamGTtk02KpEPzitdgzyqVEPZtTtzHZnYCoGcwZKGM2CK526E243b99Gfa7oZpDmjKDTRU5iQIbPOaml8hzbKrFtWv/X7SolK8bZTcjbfFmfF4m7cxj4bjXAfgncElIAyFlZokYvKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451634; c=relaxed/simple;
	bh=wOQzsme/WJx8E+7K76KBZWEu4MRl7v3chIkCFixnjIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l7QNbM+MP8IGM1VKtkFLehN59adTJ3wslfo0yFGLU6EfBA0ew8YnPXd1CP8Z3YdNjjqg0q15lduJLR+BKU19JjeGUfwi28A5HVqwRK8dA7obBVWAxUt5Z4isui7DXN7yKbYQsEybmK1hsIED4bdbB9u15P67X/TOLq2Wj8j/9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAGacgMi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da202aa138so369927b3a.2
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451632; x=1708056432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLcdghajJR/QGdT0y2Nv6AwpiR5Q3wh3RT5GphLP8Vw=;
        b=NAGacgMiy697GJH25gRxgG7eaM2er+6kVSIZEowEnivFNh7Lp+L/0v2C8g/052GB5M
         B7J4I6sWWZHQH1ODbDaBzB9S3TIhfJlAS431kfrOFzWJxNMlBJxxJEWiXjy8bxJOGR2I
         CHSPlsCg2XFJP9wZQvaLOiT0c37fX4IszDDwjg/pAjnOh818fnFnrd9SRsJBWXWfM1xP
         v38XR0S99h1OIPxqqB8vxqONM0c6gdQSyQq95QoKBUkRDDx44Hz05q1+YiHBbExU7dBt
         UyuRczQjhEPAwItnsljw5X0joxKuCZK7lPpK60LzX1geUGebCiuSdlxyt4ZdYupRRLko
         ipXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451632; x=1708056432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLcdghajJR/QGdT0y2Nv6AwpiR5Q3wh3RT5GphLP8Vw=;
        b=QsI3h9R5Sz6zkuuyRPM+LlbOPg+PdkusBISRacuJlVp+8mHX1Wof+v4jcKXfexfkyq
         EDs5XGDbM/CwrzasoM3hbMDTxvvTVdtXKjg7oj9eiO4lUpWh7dvQ8tWgOt5cgwIqbBpL
         zn7xd7VJQiJjdJZwgYXlfcOOq4nNUahDnCsXzmSdkmRpsCCTAMmJ7OxW6Dair0fYERVT
         FlqD21R74EgAJt2nEHChwKN4+5c7+x7R6pgp9aga6oTJJgl/ftidXdOw+yXl+QMFJUqs
         9cjwM3LQP9mVOEJCZiwQihlx52AG2opcSZFODfEF18Pm1qUFiWS2L/OXCza2zSHuCl7Z
         pF1g==
X-Gm-Message-State: AOJu0YwiRHfm7jG65HGCj46KSs+qqPcDIVYpKqJURVGnva2VC7iwQKKC
	U3eQhm9bdAmh/YvzvIennujqXh52368A+goegV3W5qbVSwZIfPBDtW5mtHrD
X-Google-Smtp-Source: AGHT+IFyT2HEc4ssBsDGMa4TA3yrF8aBqF74Rmstz83H0u4hHry+ndHS7WzzE7gccPrmnj/Cj736wQ==
X-Received: by 2002:a05:6a20:4c96:b0:19a:4418:1e86 with SMTP id fq22-20020a056a204c9600b0019a44181e86mr530941pzb.58.1707451631872;
        Thu, 08 Feb 2024 20:07:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMVJtQVx+RHJh+uTVXziJuPTI/HF31SiR4SNYP6BHTsrkAvpTU1sc62DC21f13kRH9Dye4YDzYfba3LqMoAKSi+zMvfbZxGIUdYE4eQTBaHACABp5HjD9YYkJ7KoGVldB8/5CPr+2TEHW8cuKCioB9EIZV+kQ5CCdT4rZWQSNjINRK7wk8vRN2AufUOUbG4S0F8ZI5Fh4BtKBORfHn9I/5Du1L3rrfFgBPPTnFwtR37nrQi7pimC+mbyRHJbo3bH7RKBioHKKpzRZiTlPSUxx5A2rr+cKgpBI7AI6TMyhVRxJ0Nu5ITYRkBCWEAd6OiF/vq72Jxx7rz7KGQuubEf/0nS2k6bgxYL+WyM67sSGSZp7txMlxWQ==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a438100b0029464b5fcdbsm715206pjg.42.2024.02.08.20.07.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:07:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
Date: Thu,  8 Feb 2024 20:06:02 -0800
Message-Id: <20240209040608.98927-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

LLVM automatically places __arena variables into ".arena.1" ELF section.
When libbpf sees such section it creates internal 'struct bpf_map' LIBBPF_MAP_ARENA
that is connected to actual BPF_MAP_TYPE_ARENA 'struct bpf_map'.
They share the same kernel's side bpf map and single map_fd.
Both are emitted into skeleton. Real arena with the name given by bpf program
in SEC(".maps") and another with "__arena_internal" name.
All global variables from ".arena.1" section are accessible from user space
via skel->arena->name_of_var.

For bss/data/rodata the skeleton/libbpf perform the following sequence:
1. addr = mmap(MAP_ANONYMOUS)
2. user space optionally modifies global vars
3. map_fd = bpf_create_map()
4. bpf_update_map_elem(map_fd, addr) // to store values into the kernel
5. mmap(addr, MAP_FIXED, map_fd)
after step 5 user spaces see the values it wrote at step 2 at the same addresses

arena doesn't support update_map_elem. Hence skeleton/libbpf do:
1. addr = mmap(MAP_ANONYMOUS)
2. user space optionally modifies global vars
3. map_fd = bpf_create_map(MAP_TYPE_ARENA)
4. real_addr = mmap(map->map_extra, MAP_SHARED | MAP_FIXED, map_fd)
5. memcpy(real_addr, addr) // this will fault-in and allocate pages
6. munmap(addr)

At the end look and feel of global data vs __arena global data is the same from bpf prog pov.

Another complication is:
struct {
  __uint(type, BPF_MAP_TYPE_ARENA);
} arena SEC(".maps");

int __arena foo;
int bar;

  ptr1 = &foo;   // relocation against ".arena.1" section
  ptr2 = &arena; // relocation against ".maps" section
  ptr3 = &bar;   // relocation against ".bss" section

Fo the kernel ptr1 and ptr2 has point to the same arena's map_fd
while ptr3 points to a different global array's map_fd.
For the verifier:
ptr1->type == unknown_scalar
ptr2->type == const_ptr_to_map
ptr3->type == ptr_to_map_value

after the verifier and for JIT all 3 ptr-s are normal ld_imm64 insns.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/gen.c |  13 ++++-
 tools/lib/bpf/libbpf.c  | 102 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 101 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a9334c57e859..74fabbdbad2b 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -82,7 +82,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 	const char *name = bpf_map__name(map);
 	int i, n;
 
-	if (!bpf_map__is_internal(map)) {
+	if (!bpf_map__is_internal(map) || bpf_map__type(map) == BPF_MAP_TYPE_ARENA) {
 		snprintf(buf, buf_sz, "%s", name);
 		return true;
 	}
@@ -106,6 +106,12 @@ static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
 	int i, n;
 
+	/* recognize hard coded LLVM section name */
+	if (strcmp(sec_name, ".arena.1") == 0) {
+		/* this is the name to use in skeleton */
+		strncpy(buf, "arena", buf_sz);
+		return true;
+	}
 	for  (i = 0, n = ARRAY_SIZE(pfxs); i < n; i++) {
 		const char *pfx = pfxs[i];
 
@@ -239,6 +245,11 @@ static bool is_internal_mmapable_map(const struct bpf_map *map, char *buf, size_
 	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
 		return false;
 
+	if (bpf_map__type(map) == BPF_MAP_TYPE_ARENA) {
+		strncpy(buf, "arena", sz);
+		return true;
+	}
+
 	if (!get_map_ident(map, buf, sz))
 		return false;
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f8158e250327..d5364280a06c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -498,6 +498,7 @@ struct bpf_struct_ops {
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
+#define ARENA_SEC ".arena.1"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -505,6 +506,7 @@ enum libbpf_map_type {
 	LIBBPF_MAP_BSS,
 	LIBBPF_MAP_RODATA,
 	LIBBPF_MAP_KCONFIG,
+	LIBBPF_MAP_ARENA,
 };
 
 struct bpf_map_def {
@@ -547,6 +549,7 @@ struct bpf_map {
 	bool reused;
 	bool autocreate;
 	__u64 map_extra;
+	struct bpf_map *arena;
 };
 
 enum extern_type {
@@ -613,6 +616,7 @@ enum sec_type {
 	SEC_BSS,
 	SEC_DATA,
 	SEC_RODATA,
+	SEC_ARENA,
 };
 
 struct elf_sec_desc {
@@ -1718,10 +1722,34 @@ static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 			      const char *real_name, int sec_idx, void *data, size_t data_sz)
 {
+	const long page_sz = sysconf(_SC_PAGE_SIZE);
+	struct bpf_map *map, *arena = NULL;
 	struct bpf_map_def *def;
-	struct bpf_map *map;
 	size_t mmap_sz;
-	int err;
+	int err, i;
+
+	if (type == LIBBPF_MAP_ARENA) {
+		for (i = 0; i < obj->nr_maps; i++) {
+			map = &obj->maps[i];
+			if (map->def.type != BPF_MAP_TYPE_ARENA)
+				continue;
+			arena = map;
+			real_name = "__arena_internal";
+		        mmap_sz = bpf_map_mmap_sz(map);
+			if (roundup(data_sz, page_sz) > mmap_sz) {
+				pr_warn("Declared arena map size %zd is too small to hold"
+					"global __arena variables of size %zd\n",
+					mmap_sz, data_sz);
+				return -E2BIG;
+			}
+			break;
+		}
+		if (!arena) {
+			pr_warn("To use global __arena variables the arena map should"
+				"be declared explicitly in SEC(\".maps\")\n");
+			return -ENOENT;
+		}
+	}
 
 	map = bpf_object__add_map(obj);
 	if (IS_ERR(map))
@@ -1732,6 +1760,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	map->sec_offset = 0;
 	map->real_name = strdup(real_name);
 	map->name = internal_map_name(obj, real_name);
+	map->arena = arena;
 	if (!map->real_name || !map->name) {
 		zfree(&map->real_name);
 		zfree(&map->name);
@@ -1739,18 +1768,32 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	}
 
 	def = &map->def;
-	def->type = BPF_MAP_TYPE_ARRAY;
-	def->key_size = sizeof(int);
-	def->value_size = data_sz;
-	def->max_entries = 1;
-	def->map_flags = type == LIBBPF_MAP_RODATA || type == LIBBPF_MAP_KCONFIG
-			 ? BPF_F_RDONLY_PROG : 0;
+	if (type == LIBBPF_MAP_ARENA) {
+		/* bpf_object will contain two arena maps:
+		 * LIBBPF_MAP_ARENA & BPF_MAP_TYPE_ARENA
+		 * and
+		 * LIBBPF_MAP_UNSPEC & BPF_MAP_TYPE_ARENA.
+		 * The former map->arena will point to latter.
+		 */
+		def->type = BPF_MAP_TYPE_ARENA;
+		def->key_size = 0;
+		def->value_size = 0;
+		def->max_entries = roundup(data_sz, page_sz) / page_sz;
+		def->map_flags = BPF_F_MMAPABLE;
+	} else {
+		def->type = BPF_MAP_TYPE_ARRAY;
+		def->key_size = sizeof(int);
+		def->value_size = data_sz;
+		def->max_entries = 1;
+		def->map_flags = type == LIBBPF_MAP_RODATA || type == LIBBPF_MAP_KCONFIG
+			? BPF_F_RDONLY_PROG : 0;
 
-	/* failures are fine because of maps like .rodata.str1.1 */
-	(void) map_fill_btf_type_info(obj, map);
+		/* failures are fine because of maps like .rodata.str1.1 */
+		(void) map_fill_btf_type_info(obj, map);
 
-	if (map_is_mmapable(obj, map))
-		def->map_flags |= BPF_F_MMAPABLE;
+		if (map_is_mmapable(obj, map))
+			def->map_flags |= BPF_F_MMAPABLE;
+	}
 
 	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
 		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
@@ -1814,6 +1857,13 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 							    NULL,
 							    sec_desc->data->d_size);
 			break;
+		case SEC_ARENA:
+			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
+			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_ARENA,
+							    sec_name, sec_idx,
+							    sec_desc->data->d_buf,
+							    sec_desc->data->d_size);
+			break;
 		default:
 			/* skip */
 			break;
@@ -3646,6 +3696,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			} else if (strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
 				obj->efile.st_ops_link_data = data;
 				obj->efile.st_ops_link_shndx = idx;
+			} else if (strcmp(name, ARENA_SEC) == 0) {
+				sec_desc->sec_type = SEC_ARENA;
+				sec_desc->shdr = sh;
+				sec_desc->data = data;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -4148,6 +4202,7 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 	case SEC_BSS:
 	case SEC_DATA:
 	case SEC_RODATA:
+	case SEC_ARENA:
 		return true;
 	default:
 		return false;
@@ -4173,6 +4228,8 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 		return LIBBPF_MAP_DATA;
 	case SEC_RODATA:
 		return LIBBPF_MAP_RODATA;
+	case SEC_ARENA:
+		return LIBBPF_MAP_ARENA;
 	default:
 		return LIBBPF_MAP_UNSPEC;
 	}
@@ -4326,7 +4383,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 
 	reloc_desc->type = RELO_DATA;
 	reloc_desc->insn_idx = insn_idx;
-	reloc_desc->map_idx = map_idx;
+	reloc_desc->map_idx = map->arena ? map->arena - obj->maps : map_idx;
 	reloc_desc->sym_off = sym->st_value;
 	return 0;
 }
@@ -4813,6 +4870,9 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
 		return 0;
 	}
+	if (map_type == LIBBPF_MAP_ARENA)
+		return 0;
+
 	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
 	if (err) {
 		err = -errno;
@@ -5119,6 +5179,15 @@ bpf_object__create_maps(struct bpf_object *obj)
 		if (bpf_map__is_internal(map) && !kernel_supports(obj, FEAT_GLOBAL_DATA))
 			map->autocreate = false;
 
+		if (map->libbpf_type == LIBBPF_MAP_ARENA) {
+			size_t len = bpf_map_mmap_sz(map);
+
+			memcpy(map->arena->mmaped, map->mmaped, len);
+			map->autocreate = false;
+			munmap(map->mmaped, len);
+			map->mmaped = NULL;
+		}
+
 		if (!map->autocreate) {
 			pr_debug("map '%s': skipped auto-creating...\n", map->name);
 			continue;
@@ -9735,6 +9804,8 @@ static bool map_uses_real_name(const struct bpf_map *map)
 		return true;
 	if (map->libbpf_type == LIBBPF_MAP_RODATA && strcmp(map->real_name, RODATA_SEC) != 0)
 		return true;
+	if (map->libbpf_type == LIBBPF_MAP_ARENA)
+		return true;
 	return false;
 }
 
@@ -13437,6 +13508,11 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 			continue;
 		}
 
+		if (map->arena) {
+			*mmaped = map->arena->mmaped;
+			continue;
+		}
+
 		if (map->def.map_flags & BPF_F_RDONLY_PROG)
 			prot = PROT_READ;
 		else
-- 
2.34.1


