Return-Path: <bpf+bounces-74849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4EC6714B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 04:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E36435B85E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083E28D8ED;
	Tue, 18 Nov 2025 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="KRPGJ8V/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D12D515
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434876; cv=none; b=dSqMDAc5sWCYXmrzqcn1RqpGCoCI0lPrhiloJJEzjNaVwmeCQJe0gD3Q8fEHuCI2PQcgv4dxrTl3k7/8yyZU3bohHh9pdj0gsCQx6MGOoD0XYYmwrWmT6pX24jPGFADZYIE4qbQAZHO7Z7sgppPS0xo9H700XQag2y8sFndUXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434876; c=relaxed/simple;
	bh=c1IyFbHOX2idMINBtXrX7GH+BKTeybjwVnG+q9GqabI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7bbJSorLx2clRUKDax59G02fzSX2dsAdSugJ0DpE1nWyAJBBTz5+4rszRvA3hylrrA7eosZdl+0XfW2IbeomPe2AoOfjKT9CVqff8YKaF59uuYvBgCjnH0QSXJAML+GuI0LnVaNAZG2UZ1rrv048g/rEzvOLouKvVLTew/SjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=KRPGJ8V/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2ec756de0so156978485a.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 19:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763434874; x=1764039674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvtCJMihnDhsJMQjgOrRxxwn67jxIU81fxfJ5Bb1Nr4=;
        b=KRPGJ8V/h8aDcDj2NyGaiRNGU9vCVrwNywzgsZFwpurd/5lts5PfRBGK6ALgasUCzB
         GS56HkiwsW4JtIlqjdm2QmX8r9CN4zLLHr+fcuutbn6V3kbwi8Sgr28BLMM5jnGSGrcO
         EJwazXfz/YXzeNrjdk7sKwzkL5mHeneaF9maF8xub34NGhQizv4Ip4o1PNBInuQ9RkJq
         oAKJw/xaEkpXP9QqcEUyZmCATlv/osmra9NXXWYz2H8grbdpHMxaYahqu9as1aX8pmTE
         np7S6k8ax9F5BUWkvta9AwbXmAfwlHAac+W/V2828qfrpnSJbfMh1WyvXh8SFI8pCrmg
         kolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434874; x=1764039674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvtCJMihnDhsJMQjgOrRxxwn67jxIU81fxfJ5Bb1Nr4=;
        b=S7DWzLVFHEzfsv3/0nRPEAvTPJeSb71JUuYtLmWdmLmG611pfODKt6dAhsEeAjqg/2
         K/cACwOEBCpUfPvgYcwwpChsMphgPwqdurVaG3E1y4apTt3HvJVivozEjV6CucKrUsCZ
         JjrkEwpDC9AnaefcAgR7sMtTgxRYdPI0bs7uxnHNjd10DGU9VY8W2UaKhhx0oEI56cSY
         MWyUA3qmh2xhCIU5/JyOWHYLhPBNESRYXkjr9RGSoi8PlaBbxlplWdMTmDk8LRhDZxbk
         VyqN+RXXnxLrjskjFrVUShh15cPgJ+SXqktpr9lxWStYWdgGPQDPGCRRTOlEO6iOGtRm
         hq+g==
X-Gm-Message-State: AOJu0YwfgXIrw2FhBMTjKLQRtRBzAqh6Y02P0L1q53NaaQoXthD3ouOn
	uZADr5s9ysryfAHR89yLy5nKbQEpeFs9xpvOarSeH49uPMlqUI3KzQrwHDONmpqppDnj+BFyVvX
	ilRa6hOs=
X-Gm-Gg: ASbGncvoMt6LyTKCPA30yARGDLVpkP99ZTtqiEo30Wj7nYK6Mkj9q+iMFJ6frCrh9G2
	ejyXSy6RlvmeL4KTxK3frKzvBDXypuj2pZ/ZsCuonZ/DeTIXDjkL+XKp951SvZSVxHIJodDWiF/
	qZPFK0Z3x7Sgl+V2LDzHrgwYjBJE4Vf2bhToccip4m0rbvdQIWfSk8AI2749m0heDhUvviGDWAL
	ndDnGYbKAfeZi0QpTnpPDCAiWSODXTncUeLk7s5dgTInuFYuQPqm/iowPDf0ePfEQnJvfns42Sy
	9kktt/ASbdvIiSzLY496DTXnjYtgArbquPN8MAYGUprjodG9xy2ErOZOiAaSQgMrr43DoNkJa4g
	7jYqxpdFCii1m1r9mx4bujjMxZaq7oSZkZCcbJVYDPok6TqINbbec7azk7cZLKLvicUbj7AfSoM
	UDs++XDbbyRErZDytZrgGv
X-Google-Smtp-Source: AGHT+IEHefWqH3R7isF/F3QsPtVn+H/6wht7zJiZngsHcnluc/N3uk/rlZSUFdthryiwIQOfnBQTmg==
X-Received: by 2002:a05:620a:1a91:b0:8b2:6bdf:3d14 with SMTP id af79cd13be357-8b2c3148065mr2013611685a.17.1763434873565;
        Mon, 17 Nov 2025 19:01:13 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af043037sm1117130185a.48.2025.11.17.19.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:01:13 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 2/4] libbpf: add stub for offset-related skeleton padding
Date: Mon, 17 Nov 2025 22:00:56 -0500
Message-ID: <20251118030058.162967-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251118030058.162967-1-emil@etsalapatis.com>
References: <20251118030058.162967-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a stub function for reporting in which offset within a mapping
libbpf places the map's data. This will be used in a subsequent
patch to support offsetting arena variables within the mapped region.

Adjust skeleton generation to account for the new arena memory layout
by adding padding corresponding to the offset into the arena map. Add
a libbbpf API function to get the data offset within the map's mapping
during skeleton generation.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/bpf/bpftool/gen.c  | 23 +++++++++++++++++++++--
 tools/lib/bpf/libbpf.c   | 10 ++++++++++
 tools/lib/bpf/libbpf.h   |  9 +++++++++
 tools/lib/bpf/libbpf.map |  1 +
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 993c7d9484a4..6ed125b1b465 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -148,7 +148,8 @@ static int codegen_datasec_def(struct bpf_object *obj,
 			       struct btf *btf,
 			       struct btf_dump *d,
 			       const struct btf_type *sec,
-			       const char *obj_name)
+			       const char *obj_name,
+			       int var_off)
 {
 	const char *sec_name = btf__name_by_offset(btf, sec->name_off);
 	const struct btf_var_secinfo *sec_var = btf_var_secinfos(sec);
@@ -163,6 +164,17 @@ static int codegen_datasec_def(struct bpf_object *obj,
 		strip_mods = true;
 
 	printf("	struct %s__%s {\n", obj_name, sec_ident);
+
+	/*
+	 * Arena variables may be placed in an offset within the section.
+	 * Represent this in the skeleton using a padding struct.
+	 */
+	if (var_off > 0) {
+		printf("\t\tchar __pad%d[%d];\n",
+			pad_cnt, var_off);
+		pad_cnt++;
+	}
+
 	for (i = 0; i < vlen; i++, sec_var++) {
 		const struct btf_type *var = btf__type_by_id(btf, sec_var->type);
 		const char *var_name = btf__name_by_offset(btf, var->name_off);
@@ -279,6 +291,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 	struct bpf_map *map;
 	const struct btf_type *sec;
 	char map_ident[256];
+	int var_off;
 	int err = 0;
 
 	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
@@ -303,7 +316,13 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 			printf("	struct %s__%s {\n", obj_name, map_ident);
 			printf("	} *%s;\n", map_ident);
 		} else {
-			err = codegen_datasec_def(obj, btf, d, sec, obj_name);
+			var_off = bpf_map__data_offset(map);
+			if (var_off < 0)  {
+				p_err("bpf_map__data_offset called on unmapped map\n");
+				err = var_off;
+				goto out;
+			}
+			err = codegen_datasec_def(obj, btf, d, sec, obj_name, var_off);
 			if (err)
 				goto out;
 		}
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 706e7481bdf6..32dac36ba8db 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10552,6 +10552,16 @@ const char *bpf_map__name(const struct bpf_map *map)
 	return map->name;
 }
 
+int bpf_map__data_offset(const struct bpf_map *map)
+{
+	if (!map->mmaped)
+		return -EINVAL;
+
+	/* No offsetting for now. */
+	return 0;
+}
+
+
 enum bpf_map_type bpf_map__type(const struct bpf_map *map)
 {
 	return map->def.type;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..549289dd9891 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1314,6 +1314,15 @@ LIBBPF_API int bpf_map__set_exclusive_program(struct bpf_map *map, struct bpf_pr
  */
 LIBBPF_API struct bpf_program *bpf_map__exclusive_program(struct bpf_map *map);
 
+/*
+ * @brief **bpf_map__data_offset** returns the offset of the map's data
+ * within the address mapping.
+ * @param BPF map whose variable offset we are looking into.
+ * @return the offset >= 0 of the map's contents within its mapping; negative
+ * error code, otherwise.
+ */
+LIBBPF_API int bpf_map__data_offset(const struct bpf_map *map);
+
 struct bpf_xdp_set_link_opts {
 	size_t sz;
 	int old_fd;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..ac932ee3a932 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_map__data_offset;
 } LIBBPF_1.6.0;
-- 
2.49.0


