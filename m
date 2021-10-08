Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E74260DF
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 02:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhJHAFa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 20:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbhJHAF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 20:05:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B3C061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 17:03:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id o133so427290pfg.7
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 17:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mx0IwzcsM+t1MJCyKa/HQd4El0ePQRlE+ud24xS3iTo=;
        b=R3H89i/+ZaJFxXcTAgerNk3noBiBn+k++RCCWvYBvwhsohOY35cixYzR1SOcPjSqJ5
         TL9Xz+t/nJEf9er08INicO9sIDB7RNh6dyKjgMihoVXlJ/d8YRpAQtBT2J/YOhpa/mJM
         8fZ3eK4rGDBsF52NIQIGRIDPtk2P9+FQG43BvUItnV9tlPKCF07Bw9ZKI6Y9rdBj0Aal
         rDkqhWyAsbeoIq7hbWrtC4AEJ9IlZrB0MaCDYr9tRGrByPd1oJPK16Tkj/vlRmP5O9Qq
         eDTrbe4oeOKjR+iIUlcm3LLTG7QSiFKa1D0ozQH5MJGdRZ23vDwL9kj6QYdTQpWh0ptR
         UjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mx0IwzcsM+t1MJCyKa/HQd4El0ePQRlE+ud24xS3iTo=;
        b=nWU8Gxoyh4PN7l5weQI8Dz/N/RhcaX3g1WE5KIuTpclFNXjqldJ4DA/gA7LEZMajRq
         CIHmdRpzbal+fNpdudp9F1Pwx9JUW2XuSyfM7RnAB7P/VobAjUBv+hv35rxRefvDm6r5
         56piXkpdHSI2MuLI2TH6IjiolR4Q1RSqZWiONPeU4bPVbvSji2a2xUv3C1JEubes+e9t
         BnGs/iTP0GXmSAuItggL4dCYabv8j4ndz2I8heQj5jNBHCp5ssLGZrBmogOrNdYhZVP+
         poQV2MsDpvmB84Psy0Dtb3e+M5uSWMA05Fux0iCM5gnbxqnrkvPU79waEZCMnX48jGP7
         6Jew==
X-Gm-Message-State: AOAM530Nf2Z0vJJcIy2qB2RwQbSEzBqzipLUuf7hwkwZEOtBlzlBwcp+
        ApPPlIk8zrqmTbgef9i0jzNNvBQM5oIGMg==
X-Google-Smtp-Source: ABdhPJxLeYIY4Ts8cl0fY5fJ1L+Gt/c7YOX6bnyHyrjvtsYSebm9PMqWDT22SEETcOG0CGUXdikxFA==
X-Received: by 2002:a63:df06:: with SMTP id u6mr2096748pgg.148.1633651414810;
        Thu, 07 Oct 2021 17:03:34 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::e050])
        by smtp.gmail.com with ESMTPSA id 184sm502121pfw.49.2021.10.07.17.03.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 17:03:34 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 05/10] bpftool: support multiple .rodata/.data internal maps in skeleton
Date:   Thu,  7 Oct 2021 17:03:04 -0700
Message-Id: <20211008000309.43274-6-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008000309.43274-1-andrii@kernel.org>
References: <20211008000309.43274-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Remove the assumption about only single instance of each of .rodata and
.data internal maps. Nothing changes for '.rodata' and '.data' maps, but new
'.rodata.something' map will get 'rodata_something' section in BPF
skeleton for them (as well as having struct bpf_map * field in maps
section with the same field name).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 107 ++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 47 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index cc835859465b..5fbd90bb0c09 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -34,6 +34,11 @@ static void sanitize_identifier(char *name)
 			name[i] = '_';
 }
 
+static bool str_has_prefix(const char *str, const char *prefix)
+{
+	return strncmp(str, prefix, strlen(prefix)) == 0;
+}
+
 static bool str_has_suffix(const char *str, const char *suffix)
 {
 	size_t i, n1 = strlen(str), n2 = strlen(suffix);
@@ -68,23 +73,47 @@ static void get_header_guard(char *guard, const char *obj_name)
 		guard[i] = toupper(guard[i]);
 }
 
-static const char *get_map_ident(const struct bpf_map *map)
+static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 {
+	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
 	const char *name = bpf_map__name(map);
+	int i, n;
+
+	if (!bpf_map__is_internal(map)) {
+		snprintf(buf, buf_sz, "%s", name);
+		return true;
+	}
+
+	for  (i = 0, n = ARRAY_SIZE(sfxs); i < n; i++) {
+		const char *sfx = sfxs[i], *p;
+
+		p = strstr(name, sfx);
+		if (p) {
+			snprintf(buf, buf_sz, "%s", p + 1);
+			sanitize_identifier(buf);
+			return true;
+		}
+	}
 
-	if (!bpf_map__is_internal(map))
-		return name;
-
-	if (str_has_suffix(name, ".data"))
-		return "data";
-	else if (str_has_suffix(name, ".rodata"))
-		return "rodata";
-	else if (str_has_suffix(name, ".bss"))
-		return "bss";
-	else if (str_has_suffix(name, ".kconfig"))
-		return "kconfig";
-	else
-		return NULL;
+	return false;
+}
+
+static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
+{
+	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	int i, n;
+
+	for  (i = 0, n = ARRAY_SIZE(pfxs); i < n; i++) {
+		const char *pfx = pfxs[i];
+
+		if (str_has_prefix(sec_name, pfx)) {
+			snprintf(buf, buf_sz, "%s", sec_name + 1);
+			sanitize_identifier(buf);
+			return true;
+		}
+	}
+
+	return false;
 }
 
 static void codegen_btf_dump_printf(void *ctx, const char *fmt, va_list args)
@@ -101,24 +130,14 @@ static int codegen_datasec_def(struct bpf_object *obj,
 	const char *sec_name = btf__name_by_offset(btf, sec->name_off);
 	const struct btf_var_secinfo *sec_var = btf_var_secinfos(sec);
 	int i, err, off = 0, pad_cnt = 0, vlen = btf_vlen(sec);
-	const char *sec_ident;
-	char var_ident[256];
+	char var_ident[256], sec_ident[256];
 	bool strip_mods = false;
 
-	if (strcmp(sec_name, ".data") == 0) {
-		sec_ident = "data";
-		strip_mods = true;
-	} else if (strcmp(sec_name, ".bss") == 0) {
-		sec_ident = "bss";
-		strip_mods = true;
-	} else if (strcmp(sec_name, ".rodata") == 0) {
-		sec_ident = "rodata";
-		strip_mods = true;
-	} else if (strcmp(sec_name, ".kconfig") == 0) {
-		sec_ident = "kconfig";
-	} else {
+	if (!get_datasec_ident(sec_name, sec_ident, sizeof(sec_ident)))
 		return 0;
-	}
+
+	if (strcmp(sec_name, ".kconfig") != 0)
+		strip_mods = true;
 
 	printf("	struct %s__%s {\n", obj_name, sec_ident);
 	for (i = 0; i < vlen; i++, sec_var++) {
@@ -386,6 +405,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 {
 	struct bpf_program *prog;
 	struct bpf_map *map;
+	char ident[256];
 
 	codegen("\
 		\n\
@@ -406,10 +426,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 	}
 
 	bpf_object__for_each_map(map, obj) {
-		const char *ident;
-
-		ident = get_map_ident(map);
-		if (!ident)
+		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 		if (bpf_map__is_internal(map) &&
 		    (bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
@@ -433,6 +450,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	struct bpf_object_load_attr load_attr = {};
 	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
 	struct bpf_map *map;
+	char ident[256];
 	int err = 0;
 
 	err = bpf_object__gen_loader(obj, &opts);
@@ -478,12 +496,10 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		",
 		obj_name, opts.data_sz);
 	bpf_object__for_each_map(map, obj) {
-		const char *ident;
 		const void *mmap_data = NULL;
 		size_t mmap_size = 0;
 
-		ident = get_map_ident(map);
-		if (!ident)
+		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 
 		if (!bpf_map__is_internal(map) ||
@@ -545,15 +561,15 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 				return err;				    \n\
 		", obj_name);
 	bpf_object__for_each_map(map, obj) {
-		const char *ident, *mmap_flags;
+		const char *mmap_flags;
 
-		ident = get_map_ident(map);
-		if (!ident)
+		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 
 		if (!bpf_map__is_internal(map) ||
 		    !(bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
 			continue;
+
 		if (bpf_map__def(map)->map_flags & BPF_F_RDONLY_PROG)
 			mmap_flags = "PROT_READ";
 		else
@@ -603,7 +619,8 @@ static int do_skeleton(int argc, char **argv)
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
 	char obj_name[MAX_OBJ_NAME_LEN] = "", *obj_data;
 	struct bpf_object *obj = NULL;
-	const char *file, *ident;
+	const char *file;
+	char ident[256];
 	struct bpf_program *prog;
 	int fd, err = -1;
 	struct bpf_map *map;
@@ -674,8 +691,7 @@ static int do_skeleton(int argc, char **argv)
 	}
 
 	bpf_object__for_each_map(map, obj) {
-		ident = get_map_ident(map);
-		if (!ident) {
+		if (!get_map_ident(map, ident, sizeof(ident))) {
 			p_err("ignoring unrecognized internal map '%s'...",
 			      bpf_map__name(map));
 			continue;
@@ -728,8 +744,7 @@ static int do_skeleton(int argc, char **argv)
 	if (map_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_map(map, obj) {
-			ident = get_map_ident(map);
-			if (!ident)
+			if (!get_map_ident(map, ident, sizeof(ident)))
 				continue;
 			if (use_loader)
 				printf("\t\tstruct bpf_map_desc %s;\n", ident);
@@ -898,9 +913,7 @@ static int do_skeleton(int argc, char **argv)
 		);
 		i = 0;
 		bpf_object__for_each_map(map, obj) {
-			ident = get_map_ident(map);
-
-			if (!ident)
+			if (!get_map_ident(map, ident, sizeof(ident)))
 				continue;
 
 			codegen("\
-- 
2.30.2

