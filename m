Return-Path: <bpf+bounces-23224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D143486EDD0
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBF02875FE
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EEDAD49;
	Sat,  2 Mar 2024 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZTjYARx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD232883D
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342391; cv=none; b=OmAIekgckKmTUkfpAR0S4VZ12oR+5J4ehU7wW1qhi028V7b3j6SOOWa4xVyFXQUQiKGo1BuWyQ06GHflZ6jwLvmvn4BSGecu+jTsju2b0CjXyEAk/ZJ5CMeO+8HSKT4ihT+3d/66JwJ6bzArTxtBw570WP/FE4sSdSh9SW8bZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342391; c=relaxed/simple;
	bh=cIm4tyYIXVCjczcaRR27PEgHR74b6638+xqZA7CFIsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nm9j1XwI2cgW1n1SywYce6F7CkSNDHR8qvXwhqTddW5iXfNX/RrZfWwU7E1+U/fE6T8f20ercNlNna/f9Yt5yX86+Y2zjFaMlzyGJ1bWMgzhG13ujW876eT1EgDJjkrgPIXGOWeIHLEKvljaKjTZ3jzocHDwIvrVmb3sbYDJ+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZTjYARx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d269dc3575so23703411fa.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342387; x=1709947187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRJRHaBi8OzFwNPV6geePl2rpmmRsHc2/Z3LyoOlYMk=;
        b=IZTjYARxGZ8LMSsXi8PxX9plZTkaLK2OCoUNIKdTDIg1cpQRntoEc5PW+WEM4aUFIA
         u5THQ0Jqj5V55ldT7FCqfXmsVelAZcOhklbdzDjLljidOJt6lYlsyYu1qTCWuAVin/q5
         KchZo3KwSGLCBZ1SdtS+DB5PNdATPvbqKB/NDL1DPpcPfsadXe70xS7zZNt3wrow7HdE
         7bdtQJRrr7o5nERmgazMXkW5DP9A4AnHZYaOBPBq0VNfVgxXtH0CF9R7CPs/CnR/lemo
         1Z0XCpKOBL+DpOPEU5yWiJy6wzh9VsGKqoSL08wowykBOSMzeEQm87+ClabJPro0WJ38
         wtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342387; x=1709947187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRJRHaBi8OzFwNPV6geePl2rpmmRsHc2/Z3LyoOlYMk=;
        b=Y1SsYNRBU8utJd7HrAzrCEeNn1pXuNvDevLkBkLUVVTZ79xn9rteaTg2g1v12XT3DF
         IuHp+VF/QtyGhFNdENGZ4vYSks44iu7dzcMt+ns8S2iWG1GAjhkQvhSyLnvC4zZ2smEf
         B6tCmeIBxMma4pmNcop38Ap0eeLdqh1V/9fkft6xXNCcYwioBdAPOM1jhTRjO4tX39yd
         LluoeyVgn22fgfAWKeW78nhA8LRgN3eg/TLMr81RDqez0qAgw07kiVzbprkCYrlsrRzN
         BPAzh0Kao2SZMS0fopMdHT56wjmAudtskN1pS6Ou4NK0LUFaa18tXLVpTFdEz+dUarOe
         lOIw==
X-Gm-Message-State: AOJu0YwmTmzYqKu69X1zPy3QlB+Uc921j3F3cTwxkV7twG+1MyZ1pWqX
	caetIHryEFo68f96fLDsUxEg1QvEc7FB+tuwgv0Eksn91XHTCwB7kS72U8Y0
X-Google-Smtp-Source: AGHT+IHednO4NvEkDUJtIC7ZeT4t6ijOQSzRAgbLizr8uLZ+M4RoH109Y6k0sbNlnbgOLIBOoXCALg==
X-Received: by 2002:a2e:b602:0:b0:2d2:864c:8467 with SMTP id r2-20020a2eb602000000b002d2864c8467mr1551501ljn.20.1709342387396;
        Fri, 01 Mar 2024 17:19:47 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:47 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 11/15] libbpf: struct_ops in SEC("?.struct_ops") and SEC("?.struct_ops.link")
Date: Sat,  2 Mar 2024 03:19:16 +0200
Message-ID: <20240302011920.15302-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow using two new section names for struct_ops maps:
- SEC("?.struct_ops")
- SEC("?.struct_ops.link")

To specify maps that have bpf_map->autocreate == false after open.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8ecfad091cb5..157d28aea186 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -497,6 +497,8 @@ struct bpf_struct_ops {
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
+#define OPT_STRUCT_OPS_SEC "?.struct_ops"
+#define OPT_STRUCT_OPS_LINK_SEC "?.struct_ops.link"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -1278,6 +1280,15 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 			return -ENOMEM;
 		map->btf_value_type_id = type_id;
 
+		/* Follow same convention as for programs autoload:
+		 * SEC("?.struct_ops") means map is not created by default.
+		 */
+		if (sec_name[0] == '?') {
+			map->autocreate = false;
+			/* from now on forget there was ? in section name */
+			sec_name++;
+		}
+
 		map->def.type = BPF_MAP_TYPE_STRUCT_OPS;
 		map->def.key_size = sizeof(int);
 		map->def.value_size = type->size;
@@ -3647,7 +3658,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
 			} else if (strcmp(name, STRUCT_OPS_SEC) == 0 ||
-				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0) {
+				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0 ||
+				   strcmp(name, OPT_STRUCT_OPS_SEC) == 0 ||
+				   strcmp(name, OPT_STRUCT_OPS_LINK_SEC) == 0) {
 				sec_desc->sec_type = SEC_ST_OPS;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
@@ -3667,6 +3680,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
+			    strcmp(name, ".rel" OPT_STRUCT_OPS_SEC) &&
+			    strcmp(name, ".rel" OPT_STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
-- 
2.43.0


