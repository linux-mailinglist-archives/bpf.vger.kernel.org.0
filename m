Return-Path: <bpf+bounces-58946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F9BAC42F0
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A1517A961
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50723D2BA;
	Mon, 26 May 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jJEA1Efh"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681CC23D29F
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276537; cv=none; b=GEzNQJgjYiaIRtZnkxTTSeiAjybQcfza5l9vovlBqvybps5PDr3Kk1sh5CyQgRU1JaK6DoXPImVTXPEfR6Y4D2aWtCd9XOrICja4Uu/KO0f5xyV+lXyDJCdc/T4F5gt9g546Pr1vGrHagyu8MyeKXNisRIGcquwguGt50hKo94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276537; c=relaxed/simple;
	bh=G6a66kktrGBmACdH9xkzjizs/YKnjIrJlj3NRQsIxt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e13uxMXDftVNKIQYpXEgYJpC1i5X6TY+qjE/StX3MoOIw2TRF9u8D8tQLKdaKnGhiIizW+qP2UdBTSahB1RWnh5M/kGWuE0oj0AwWi+q0GIzEDffIjv1+HDDB4di+Yhrp8npT2dRMNzz6ZYLwpF7E8Uj8A8Ex0p3y3GWk7zoc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jJEA1Efh; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748276533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+F32+nhO2t/weV8NlrTkKbm0/w6lugGE6ti6EAqeQ8=;
	b=jJEA1EfhBqp0ClcILeJM7MH+WTPIJHKxyo7v2YZpKlx6+NS/UjIuk1lgp5LolORGzMROl+
	vpN6JAiut9Y6PW/0plbgltNjJVmc2JmY+L8zELMxbfc2rSkyXWfhrtSIZGJe4H6l92NaCy
	4fc+4z922sD7CjTTb+qPuvSSy4N3U+M=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 3/4] bpf, bpftool: Generate skeleton for global percpu data
Date: Tue, 27 May 2025 00:21:45 +0800
Message-ID: <20250526162146.24429-4-leon.hwang@linux.dev>
In-Reply-To: <20250526162146.24429-1-leon.hwang@linux.dev>
References: <20250526162146.24429-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch enhances bpftool to generate skeletons that properly handle
global percpu variables. The generated skeleton now includes a dedicated
structure for percpu data, allowing users to initialize and access percpu
variables more efficiently.

For global percpu variables, the skeleton now includes a nested
structure, e.g.:

struct test_global_percpu_data {
	struct bpf_object_skeleton *skeleton;
	struct bpf_object *obj;
	struct {
		struct bpf_map *data__percpu;
	} maps;
	// ...
	struct test_global_percpu_data__data__percpu {
		int data;
		char run;
		struct {
			char set;
			int i;
			int nums[7];
		} struct_data;
		int nums[7];
	} __aligned(8) *data__percpu;

	// ...
};

  * The "struct test_global_percpu_data__data__percpu *data__percpu" points
    to initialized data, which is actually "maps.data__percpu->mmaped".
  * Before loading the skeleton, updating the
    "struct test_global_percpu_data__data__percpu *data__percpu" modifies
    the initial value of the corresponding global percpu variables.
  * After loading the skeleton, accessing or updating this struct is not
    allowed because this struct pointer has been reset as NULL. Instead,
    users must interact with the global percpu variables via the
    "maps.data__percpu" map.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/gen.c | 47 +++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 67a60114368f5..c672f52110221 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *obj_name, const char *suff
 
 static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 {
-	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *sfxs[] = { ".data..percpu", ".data", ".rodata", ".bss", ".kconfig" };
 	const char *name = bpf_map__name(map);
 	int i, n;
 
@@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 
 static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 {
-	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *pfxs[] = { ".data..percpu", ".data", ".rodata", ".bss", ".kconfig" };
 	int i, n;
 
 	/* recognize hard coded LLVM section name */
@@ -148,7 +148,8 @@ static int codegen_datasec_def(struct bpf_object *obj,
 			       struct btf *btf,
 			       struct btf_dump *d,
 			       const struct btf_type *sec,
-			       const char *obj_name)
+			       const char *obj_name,
+			       bool is_percpu)
 {
 	const char *sec_name = btf__name_by_offset(btf, sec->name_off);
 	const struct btf_var_secinfo *sec_var = btf_var_secinfos(sec);
@@ -228,7 +229,7 @@ static int codegen_datasec_def(struct bpf_object *obj,
 
 		off = sec_var->offset + sec_var->size;
 	}
-	printf("	} *%s;\n", sec_ident);
+	printf("	}%s *%s;\n", is_percpu ? " __aligned(8)" : "", sec_ident);
 	return 0;
 }
 
@@ -263,13 +264,13 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 		return true;
 	}
 
-	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
-		return false;
-
-	if (!get_map_ident(map, buf, sz))
-		return false;
+	if (bpf_map__is_internal(map) &&
+	    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
+	     bpf_map__is_internal_percpu(map)) &&
+	    get_map_ident(map, buf, sz))
+		return true;
 
-	return true;
+	return false;
 }
 
 static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
@@ -303,7 +304,8 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 			printf("	struct %s__%s {\n", obj_name, map_ident);
 			printf("	} *%s;\n", map_ident);
 		} else {
-			err = codegen_datasec_def(obj, btf, d, sec, obj_name);
+			err = codegen_datasec_def(obj, btf, d, sec, obj_name,
+						  bpf_map__is_internal_percpu(map));
 			if (err)
 				goto out;
 		}
@@ -795,7 +797,8 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	bpf_object__for_each_map(map, obj) {
 		const char *mmap_flags;
 
-		if (!is_mmapable_map(map, ident, sizeof(ident)))
+		if (!is_mmapable_map(map, ident, sizeof(ident)) ||
+		    bpf_map__is_internal_percpu(map))
 			continue;
 
 		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
@@ -1434,7 +1437,25 @@ static int do_skeleton(int argc, char **argv)
 		static inline int					    \n\
 		%1$s__load(struct %1$s *obj)				    \n\
 		{							    \n\
-			return bpf_object__load_skeleton(obj->skeleton);    \n\
+			int err;					    \n\
+									    \n\
+			err = bpf_object__load_skeleton(obj->skeleton);	    \n\
+			if (err)					    \n\
+				return err;				    \n\
+									    \n\
+		", obj_name);
+
+	if (map_cnt) {
+		bpf_object__for_each_map(map, obj) {
+			if (bpf_map__is_internal_percpu(map) &&
+			    get_map_ident(map, ident, sizeof(ident)))
+				printf("\tobj->%s = NULL;\n", ident);
+		}
+	}
+
+	codegen("\
+		\n\
+			return 0;					    \n\
 		}							    \n\
 									    \n\
 		static inline struct %1$s *				    \n\
-- 
2.49.0


