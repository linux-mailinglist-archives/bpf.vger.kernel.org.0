Return-Path: <bpf+bounces-62267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF22AF73BC
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D304E671F
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B5A2ECD06;
	Thu,  3 Jul 2025 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT3l9V4w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA922EBDE0;
	Thu,  3 Jul 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545075; cv=none; b=qQybd7KUxoMv7jL2RJA/eRX4Or15jgPRTI2SCiwhL3UXxPu/sZeTRBjmeDvXpQo798cNLjSarWaKt2F26Fv4goPpcFC2h0MmRC1z7rOn53NetqhYYR/KGNEcl3JcAq/Xgb0Ml2RuUJVVNBXudYXtzDV027kjb4FmWz/mlGpGtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545075; c=relaxed/simple;
	bh=qbFWPI3qQKBzaJMk0/qZuYzmhEZx8nhnr6vpGU+YY18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFOhctMQXC77rA74xiM8H/ShWhYI0MmmPtVp009BHtKC6wmOXH8e7D/qW1pHjyNiqZS8CfvYYpL/PMkkk8zNqoGFz2c1sLo1eWyzomnybv5fXPp8kpuHnAf90YhzT38r+JiqUGn/RNzz9Kq+l2SVo1KcdxhV0m5ZEEUfEMNI0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT3l9V4w; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-748d982e92cso5881655b3a.1;
        Thu, 03 Jul 2025 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545073; x=1752149873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNAEr0n5xgoN2F7SQuZ8TopxhIEYwBeAbNHCXadCPPE=;
        b=FT3l9V4wQQl7KB1ZuE5FuEXiKSPbnGOoEjPmr3nrDUA6oxxZpAQjQlOctVX/XACaTN
         X2VhxwFp4Xgr7gLF5Ad2llJ7XShfO3LyzC5d53wk2GNj6DLA9UGlYn1pmy4ME4iQ9FBg
         jC+HgPjbMGUjxYeatSumtInt5h+slfVAQUXML6k2dYUlt/OER25A7Td+juB8gIzX0O3O
         uKDheuHsQ2AJYLLmfbUhluJR4UDpnfL7cM3AxK5LSNMfkvBN1gFijcUFpJ0RjOjNNAFq
         C7yjZLdxqoFAll3MCPUBuAbk9crFV0Qg8Vtrs4PKwLYgXPt0CHq9LxLdMr+XcaVsW5XE
         pnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545073; x=1752149873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNAEr0n5xgoN2F7SQuZ8TopxhIEYwBeAbNHCXadCPPE=;
        b=cjHj/dRYPfteOYwZvLEFWgKtfh35grM5SiejWzxT65jD7+o+Be/RrHEcW6iwPz3H3b
         cwXHfmkpfpgQUDnerxB7hQLPLAf2vrTIyPlm+BpTDb3M8n7piJL3W76aPhx9F87eObAB
         dIxD1nBRC51bi0MvUZm9/WYpyz4UKyEnegiRFfyRuvhWgsjpdNzQOEGi2EMyckC6Vujm
         97X2sD3y6Vj8YwTdHoU7cL8Otb0XUR4cg4MlX2LC0sSl2dSOElWbC+QFiUvyYo30VgQD
         BeD6Y5z2qhg//YYvREYweFpG2dlktkbgP0G8yuxYzykG34CBMq5zl1ec/j6dUfbihNZf
         ADeA==
X-Forwarded-Encrypted: i=1; AJvYcCW27t9VFX3Ugd2V+xuKvayfDK2XFpIX8Yi0pkAUhjqPCV6u/RqmEl2Tjfs96KdW0oJzjyICj1TL0x23b+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFJSWffUQWaatRJS3gmRToW71NtnJTEjL3hS6Ml+Ic0UxPgxy
	rsqlhDWNExJ/P2N5dj4I/liBe30fUpLBVawH4dSS5vLyEi867PpTpcIa
X-Gm-Gg: ASbGncuutby81bvkE5qlXR/ItjNp7LcW8IeXewpfgqBKwhNzP7L8bbRKtNHc4i2SqXd
	7+UCnoxUWLCPX3e7V7N6YqPYZrSQZ8qkKmfgGf+via5a6AdCWIr4MZ9xmbRrCLVJ4MyW/emhGr0
	vT02qv/HqmOvOKHyAKt5khFcDJ6CPTmAhaq79XBeKROi3sscbuVdts0lj6vCpGZj1fs3aYl2/tr
	6CFROpTg5Nk2yFaWCgqzWRYanbuDE9Ff/SL45FeXQyRLQtfrQTIMxmYxtdpLFKKsLNQAGqyNd55
	4jvat8K0PmRJjho9wwN2QWKNDYGZR+xQlARZS15VjLu/b2YaFTPbe+UPbo8Zpv8d+LbW+yc0Krw
	LBEUYvRL1ICZ7ew==
X-Google-Smtp-Source: AGHT+IEJgG6ee5lvafsegYZ2xxsDcysI/JhM1ADMfAAnu+cxVUR3was2BndcHLnsPgdCznEquh/U6A==
X-Received: by 2002:a05:6a00:3e1b:b0:748:31ed:ba8a with SMTP id d2e1a72fcca58-74b51048cf8mr7226798b3a.15.1751545072971;
        Thu, 03 Jul 2025 05:17:52 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:52 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 12/18] libbpf: don't free btf if tracing_multi progs existing
Date: Thu,  3 Jul 2025 20:15:15 +0800
Message-Id: <20250703121521.1874196-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, the kernel btf that we load during loading program will be
freed after the programs are loaded in bpf_object_load(). However, we
still need to use these btf for tracing of multi-link during attaching.
Therefore, we don't free the btfs until the bpf object is closed if any
bpf programs of the type multi-link tracing exist.

Meanwhile, introduce the new api bpf_object__free_btf() to manually free
the btfs after attaching.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/lib/bpf/libbpf.c   | 24 +++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aee36402f0a3..530c29f2f5fc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8583,6 +8583,28 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 	obj->btf_vmlinux = NULL;
 }
 
+void bpf_object__free_btfs(struct bpf_object *obj)
+{
+	if (!obj->btf_vmlinux || obj->state != OBJ_LOADED)
+		return;
+
+	bpf_object_post_load_cleanup(obj);
+}
+
+static void bpf_object_early_free_btf(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+
+	bpf_object__for_each_program(prog, obj) {
+		if (prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
+		    prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
+		    prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI)
+			return;
+	}
+
+	bpf_object_post_load_cleanup(obj);
+}
+
 static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_path)
 {
 	int err;
@@ -8654,7 +8676,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_early_free_btf(obj);
 	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
 
 	if (err) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057b..7cc810aa7967 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -323,6 +323,8 @@ LIBBPF_API struct bpf_program *
 bpf_object__find_program_by_name(const struct bpf_object *obj,
 				 const char *name);
 
+LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
+
 LIBBPF_API int
 libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 			 enum bpf_attach_type *expected_attach_type);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c7fc0bde5648..4a0c993221a5 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -444,4 +444,5 @@ LIBBPF_1.6.0 {
 		bpf_program__line_info_cnt;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		bpf_object__free_btfs;
 } LIBBPF_1.5.0;
-- 
2.39.5


