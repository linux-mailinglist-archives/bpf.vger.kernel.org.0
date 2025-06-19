Return-Path: <bpf+bounces-61127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82888AE0F78
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 00:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F195E1BC3125
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E8A25EFB9;
	Thu, 19 Jun 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDT9SRFX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB630E826
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750371266; cv=none; b=fgOT7vpKuv99ZhkaNzx/aE15/XDuU2eXHQzoTcNnxymqgvVDy+dRIvthoUDt0jcBdtd0+iHbBKD1W4Tm0j0y1yFN+aLYZVE+wkWkAyHyt3JPH8g21pdOm3rP+5Zp2QVlQJl3hRfM8BXOHDFV34n3ewVOIXQu0TP70K3z9boudak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750371266; c=relaxed/simple;
	bh=km2GDs110bHh1EdDUtu8Be0wtTFBJbPGRrr18WT3tOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Acgl2AJ8Bccf1/EkaeiIrjVmdxEEJTCD6bnP3mJoDE+V7lL7JD+saYw42XCLp5uA1eOcdw7K02JGQXm/k4MVB/W3pDKMjtAV84HPvUGOLOIjUMwlwlNLzrW5hmjRwFlJM6XRtISGIZJUJQoi2sZ/wG9tAtJlQNRBKe2/8C2Gzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=scannell.ca; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDT9SRFX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=scannell.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so9212115e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 15:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750371262; x=1750976062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WT4P8MlXaQzK0MCV6GKAfI2mlMLpfWf5UqTGhXXvYHs=;
        b=jDT9SRFXihzFYV4Ru0gR+cdDC1hVewrDvQk29rHFfhslGdc1xffSAFU1h/3jIOB1Uf
         3K1SftySz9jU5uTGPB00/5v/w1Kfe5+d4suG7oEFLvWx4XMtO2DvfWJc9gMLNPwFlqxX
         OfMa7AkKfclsxpd7brbS+RPsVg3uwv26hsaEbLEJWRCYpb3ZV/VDD9hEvHbGt70XBDg7
         X7mk9VbeDO5I/XDa0bGbojHF3hE7eO5Hj2Rp8yIiXE0Q/F2Q+K4yRInsXqGFqm93Sl9e
         2/mU/R0W2ybWyyTa/917fYoE7IUqgaufjs0bxPJQgBw9SAHIJTnXvcDJHAISY5EGnAfP
         Gzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750371262; x=1750976062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT4P8MlXaQzK0MCV6GKAfI2mlMLpfWf5UqTGhXXvYHs=;
        b=rV++U56DH9wSnFbVarLTN7y5vD4CITrnt663iqXzpsBRjZVNtTcLrqbHjZblmDQfLV
         RX/16uPCT2PMbyT4TAnCmNHHEAc7qeVwzwYskaQX7kLB+D/+d7Kwztat3OaFWdZ9AUCE
         r03Tmu64TqjM7TK+qV0Pds3PAKMFxAMGZ46Ohc15Gta/gvZLVj0NKcOvX34xHlfXBwSO
         Ao9YNagN+/nGex9cdO1LjHTB7kD4jWIc8aI2bp69whFX/VJXPBN6QgQfdOlcbjCXAG1F
         P5PBNiNZS5y/ZK89EiD64T5OoKQLLVD3jAERejNDtNp7BjEYw+vQilD/U04HnErJxIlp
         Yylg==
X-Gm-Message-State: AOJu0Yz/EcRFWBr5oGdz3HRFMslXDF2Mo6BIyFUmzzqh+n/NR6hvuHI7
	qIA9E1CFslJiKbO1Mc5E9Er0DNsH+oAjqJfHCYIV9vOQ/Ql27CZdBjpKqak7KoUfnY0=
X-Gm-Gg: ASbGncuPV4T+DoKghPzBCK2hHVqSYD7VP1WLTJsNHEWLRChnwY+nt9Gx3XfCv1gCv1u
	Ye3HUDqgzlyJDWh5uG4Zgg5JpO+cu4c4lp77wKQ0h+iTzrYqa+dpgSV+PllBYiLIOENjMlIEIdo
	B/zZpeSsu+5ULBwikNrxSwSvOIhx9CkGDOT9tbfDgj+lIEVSMyzuBBtdUS9E8/kFDgL3kpzGCth
	EEn/T8UOj9JNQPJFsyFLkLAYTL2Nd3m99qIbz40XCsiDvHAdxQc2Jkraxm8NWx2UxHq658sHpYF
	Ca69yseQDvm+yfOits49F85uqIo54ww8bJpcyQx1Oy/Vz68O4t6+3dJKjRu6x6kq1ZBgZtTxF4O
	pb1+AW2w=
X-Google-Smtp-Source: AGHT+IGMJWqskbHtvSA/FMmD1vUKwVLJX580b89++C+5T2URrthgvSqv3vZ11Jm/i6HZ7w3PCAcODQ==
X-Received: by 2002:a05:600c:1d27:b0:453:10c1:cb21 with SMTP id 5b1f17b1804b1-45365e3dffamr607785e9.8.1750371261869;
        Thu, 19 Jun 2025 15:14:21 -0700 (PDT)
Received: from localhost.localdomain ([193.117.204.194])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453632312a3sm16075725e9.1.2025.06.19.15.14.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 15:14:21 -0700 (PDT)
Sender: Adin Scannell <amscanne@gmail.com>
From: Adin Scannell <adin@scannell.ca>
To: bpf@vger.kernel.org
Cc: Adin Scannell <adin@scannell.ca>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] libbpf: fix possible use-after-free for externs
Date: Thu, 19 Jun 2025 23:12:56 +0100
Message-Id: <20250619221256.50893-1-adin@scannell.ca>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `name` field in `obj->externs` points into the BTF data at load time.
However, some functions may invalidate this after loading (e.g.
`bpf_map__set_value_size`), which results in pointers into freed memory and
undefined behavior.

The simplest solution is to simply `strdup` these strings, similar to the
`essent_name`, and free them at the same time.

Signed-off-by: Adin Scannell <adin@scannell.ca>
---
 tools/lib/bpf/libbpf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6445165a24f2..5adf2b68adb3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -597,7 +597,7 @@ struct extern_desc {
 	int sym_idx;
 	int btf_id;
 	int sec_btf_id;
-	const char *name;
+	char *name;
 	char *essent_name;
 	bool is_set;
 	bool is_weak;
@@ -4259,7 +4259,7 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 			return ext->btf_id;
 		}
 		t = btf__type_by_id(obj->btf, ext->btf_id);
-		ext->name = btf__name_by_offset(obj->btf, t->name_off);
+		ext->name = strdup(btf__name_by_offset(obj->btf, t->name_off));
 		ext->sym_idx = i;
 		ext->is_weak = ELF64_ST_BIND(sym->st_info) == STB_WEAK;
 
@@ -9138,8 +9138,10 @@ void bpf_object__close(struct bpf_object *obj)
 	zfree(&obj->btf_custom_path);
 	zfree(&obj->kconfig);
 
-	for (i = 0; i < obj->nr_extern; i++)
+	for (i = 0; i < obj->nr_extern; i++) {
+		zfree(&obj->externs[i].name);
 		zfree(&obj->externs[i].essent_name);
+	}
 
 	zfree(&obj->externs);
 	obj->nr_extern = 0;
-- 
2.39.5 (Apple Git-154)


