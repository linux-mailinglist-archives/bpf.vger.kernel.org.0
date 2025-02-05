Return-Path: <bpf+bounces-50553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27915A299C9
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C093A8FC0
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CD71FECD5;
	Wed,  5 Feb 2025 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FeM+TOOb"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3781FF1AC
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782587; cv=none; b=Nmb9vhnvRO8RhFPE8wo5xfSkkC6R6LJwA4YvJEfgXNIBwPc/bP732z1T/zvlS5ffQaaoFvV5JrXSIIS5+4YhDNU1HK58y9/SOR1dJzR550CrkS+pgLxatNiiTTl6t0iHUROwCFhy5QGOzUBd0j+v+3ElPyn0c1+q96Iei0p2fHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782587; c=relaxed/simple;
	bh=rkHcOv0mY5vzHzKsHjRAhnZk3FkzOr1IVjmC6ocihos=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVlznieLZETgPFlva1hkQ7hAfla0NsQQ+41cM4QWcIhRVzZfpnIUqm1JAO4LZ24Oz/+wAuaW7aMn8wcLvuF6sB0lMWWvHiMipsKCoXYHBIOlfj6lNeF+T0mPRp6hNKHaWIVYqXrg/G1893Yjeq94qRxwQSkAkmAgsHQDsRTNZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FeM+TOOb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A816203F59B;
	Wed,  5 Feb 2025 11:09:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A816203F59B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738782585;
	bh=GoPnXLB1CP3iSOAwYSGJtxX7kps5Zmznu79pLffoc8s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FeM+TOObhfMsMOjAB/XH+X3SACeTZmfkHss6uDUqcJstFhNiR+IqLXSSqMtJXrPT0
	 nS5v4HDDJdpVSmuu02Xs4uqOuBkrQS4gobaZtp4Fo45/hFdaRbvVn6nEkQuy9+oqxP
	 yvDLRexZ7MwfoudP3K9XlqWJiZ1Gz0UieQ2nYhqc=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org,
	kapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	xiyou.wangcong@gmail.com,
	bboscaccy@linux.microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH 1/1] libbpf: Convert ELF notes into read-only maps
Date: Wed,  5 Feb 2025 11:06:33 -0800
Message-ID: <20250205190918.2288389-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205190918.2288389-1-bboscaccy@linux.microsoft.com>
References: <20250205190918.2288389-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a flexible mechanism, using existing ELF constructs, to attach
additional metadata to BPF programs for possible use by BPF
gatekeepers and skeletons.

During object file parsing, note sections are no longer skipped and
now treated as read-only data. During libbpf-based loading or skeleton
generation, those sections are then transformed into read-only maps
which are subsequently passed into the kernel.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 tools/bpf/bpftool/gen.c | 4 ++--
 tools/lib/bpf/libbpf.c  | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 5a4d3240689ed..311d6a3f1c4bb 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *obj_name, const char *suff
 
 static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 {
-	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig", ".note" };
 	const char *name = bpf_map__name(map);
 	int i, n;
 
@@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 
 static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 {
-	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig", ".note" };
 	int i, n;
 
 	/* recognize hard coded LLVM section name */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da51725..be6af0fece040 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -523,6 +523,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define NOTE_SEC ".note"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -3977,6 +3978,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			sec_desc->sec_type = SEC_BSS;
 			sec_desc->shdr = sh;
 			sec_desc->data = data;
+		} else if (sh->sh_type == SHT_NOTE && (strcmp(name, NOTE_SEC) == 0 ||
+						       str_has_pfx(name, NOTE_SEC "."))) {
+			sec_desc->sec_type = SEC_RODATA;
+			sec_desc->shdr = sh;
+			sec_desc->data = data;
 		} else {
 			pr_info("elf: skipping section(%d) %s (size %zu)\n", idx, name,
 				(size_t)sh->sh_size);
-- 
2.48.1


