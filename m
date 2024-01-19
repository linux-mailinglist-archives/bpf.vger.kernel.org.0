Return-Path: <bpf+bounces-19922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED418330EC
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E470A288412
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA445A105;
	Fri, 19 Jan 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHjSFVu8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98D58ACB
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704621; cv=none; b=tlf617jJgnimQ3Wkp1N+IXAS3YsuvJthGmw6u4I/cD3ra3yMkrxVwcVRRofLtbocgBigA6SnS+t3Hc7Jh0x7YxEu3onMXISXZIEKOZ1AqYcrmw6wofGUQI262YC4TnaBbiH6Y3KPdaVnsU3+mimMQHC5xHG7XbnoSwMIn8GtKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704621; c=relaxed/simple;
	bh=95a0yqhJqEJ2eSnmB0Bwv/kLPu1mLnX1I+z6KNpil6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwZXtc/mDW5lMW3SaYfQh6EMNVufRuUOpamFLPOP+lv+KNt3pM8os2YpfPreWZFtEw9Ef+zsxMJZRWHU23dXDvsf72iPvatfOyOFzA7kMMrrUtupu81zm/uC7vndTzd5mqP+pwGvUI8MVnAhGiAd8zYN95ES3fePct/w73rdjjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHjSFVu8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f8cf76ef5bso15451847b3.0
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 14:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705704618; x=1706309418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDr+NjtX2UDLWx9szIwoRGkmVQoh5QgUN+RdNYwqcvY=;
        b=iHjSFVu8GGh+gvEj+ayVd0eOfgXjziIGgxTCjWmL6w++iH15j7XvZcDXsfv0aux7Wi
         BwVqGTlLWE1tfNo1ZCnCpd+ykluKLQEQpnyLzyMhBhYO8Bod8MtcvBRbhyHUYLZSF8r1
         A0iWVEquWwLA3yToX6fytqXAN9kQZK6AdgX2iDx5CjH9yfHq+rCDfoHFJLgiJPFy7HJs
         ARHOgNVmwr/axiadHzjlSPCALCLUuEB3UO/jWsO2nKNdILbGCI6Zc2U+55Py8q9MBJMl
         yAx+2NOzMk2T2+OCVpHlefFOadYlpdhpK6wJfbjYIUijdnE/uwOxKrkg2T2av5jzN+iU
         70MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704618; x=1706309418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDr+NjtX2UDLWx9szIwoRGkmVQoh5QgUN+RdNYwqcvY=;
        b=eyaE6KG6aOHYRUf6qPLYDz22VVE1Q65e9W/yg04Hi/UoH0ItZqZVJVkC1vIWiKQdUx
         nctJIY9P8siCS2wnlePdL59U2282TDR0xrGV6VNIrpTpj/Ry9NLf6QWdSrlHPLAcQuUq
         1fRZT6Fg8P/oqE/pCbkEYUXyoWO81MES1G4HIaGDE6ZXIjRrdcvTBQ1yG+TYlY1qwwx1
         I168kC3Plth9uN9Xk485lc9Kp+ZBGeh551YH+M97Z4PoAe8S3hhghXbRLkaeft7epRJE
         IKUOSRvZBulVwMoySuRA7+5/DYcS4SFaxD8X/idX0HGsUwrdBySM4CeTLn8jKH1yxTrp
         KXeg==
X-Gm-Message-State: AOJu0YxjqchJ8IJ+Dl0iGFAu07B4ceyNMbAGXSsGn+WlcLefcd5UBMbv
	4tnP7+xPdSSTSaA8j/85OiZCWDveW44YQYzNChF+7+42McLPUr1OfAW6o0eF
X-Google-Smtp-Source: AGHT+IHjNpZkPXkPml8T1DLmN7B0gc+/hEar9SfOWrVkPAKF8nsN9yezjasvqDR///ueCDTescOX7Q==
X-Received: by 2002:a0d:cc0c:0:b0:5ff:846c:7081 with SMTP id o12-20020a0dcc0c000000b005ff846c7081mr736479ywd.13.1705704618500;
        Fri, 19 Jan 2024 14:50:18 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b170:5bda:247f:8c47])
        by smtp.gmail.com with ESMTPSA id s184-20020a819bc1000000b005ffa70964f4sm411770ywg.115.2024.01.19.14.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:50:18 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v17 02/14] bpf: get type information with BTF_ID_LIST
Date: Fri, 19 Jan 2024 14:49:53 -0800
Message-Id: <20240119225005.668602-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119225005.668602-1-thinker.li@gmail.com>
References: <20240119225005.668602-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Get ready to remove bpf_struct_ops_init() in the future. By using
BTF_ID_LIST, it is possible to gather type information while building
instead of runtime.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 96cba76f4ac3..5b3ebcb435d0 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -108,7 +108,12 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 #endif
 };
 
-static const struct btf_type *module_type;
+BTF_ID_LIST(st_ops_ids)
+BTF_ID(struct, module)
+
+enum {
+	IDX_MODULE_ID,
+};
 
 static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 				    struct btf *btf,
@@ -197,7 +202,6 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops *st_ops;
-	s32 module_id;
 	u32 i;
 
 	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
@@ -205,13 +209,6 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 #include "bpf_struct_ops_types.h"
 #undef BPF_STRUCT_OPS_TYPE
 
-	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
-	if (module_id < 0) {
-		pr_warn("Cannot find struct module in %s\n", btf_get_name(btf));
-		return;
-	}
-	module_type = btf_type_by_id(btf, module_id);
-
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
 		st_ops = bpf_struct_ops[i];
 		bpf_struct_ops_init_one(st_ops, btf, log);
@@ -387,6 +384,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	const struct bpf_struct_ops *st_ops = st_map->st_ops;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
+	const struct btf_type *module_type;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops->type;
 	struct bpf_tramp_links *tlinks;
@@ -434,6 +432,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	image = st_map->image;
 	image_end = st_map->image + PAGE_SIZE;
 
+	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
-- 
2.34.1


