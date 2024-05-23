Return-Path: <bpf+bounces-30438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE498CDD1F
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092F61F21548
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8512839A;
	Thu, 23 May 2024 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN26rxcG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3F84D25
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505736; cv=none; b=NREo5jZQ6qRcskNQK1IbrgJg2sJgiPOJaq5SKGTGJO6qfpTFcViAzcq4c6JxEmBzHU0+a8k7nJRC2uQ/QqSx2HKj2io8H06AetaOnQZD6YHKDilmIGf8a+8kKHuf1RLzA79FfoCwE+910CSLepKepnC0ZE6hdRAB1w6THuE/HEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505736; c=relaxed/simple;
	bh=CJw1aL03b9FTfcvig5zTnobUTi1c6JlqNPNhQ64K2wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rsvZVRV9+GDnMdEIWe8rLT2HDkT2QLdgp2DcfGyPo5kfzSBQeB2QcMysrEGfN2TrZbMRaLQglm4ZgX4OrHbX8qfTTXUDkn8ThJxFv+BkPezt06JEDyF4xD1OPzGnh3blDxqh06JsiZLmYeRo6SJEwBNK1CrdxL/XCbOXhw4Dcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN26rxcG; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-627ebbe7720so24636987b3.0
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716505733; x=1717110533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmt0rlNlJbrjlCasd7uin+JcPRwcvSc+pKBeG7SHYHw=;
        b=FN26rxcGqjD5+wQWUCc0nWYt8rQ11+4TRtnxkdNeolJ3tSjse1+GoDKcM9I5afzro3
         t3Zprw6zsPZLBqH3EBIatxka0KrwZP0wU8si8GgZ/SYGF+tDmOlV6/8lEJKVtM0/trzE
         qxcHhQJ57sGRDpKB6deyNXu/GDwdMuZa7cyN2DyXql1u8+RnwIUAg/fLpaZKb1xX+CqE
         nkfcf6hEl+eLWkzGj+4o/otuGlH0D1fwEiMHhc8oXSagW3uldqK5zJnb7kXVEM/Cjovc
         9rzgufj6o6SJhVXPQhy8zkUHYrT7jNyC82o1v6nMuxFf7oDqCAtXZiD+3R31QCqsT5HU
         EyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505733; x=1717110533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmt0rlNlJbrjlCasd7uin+JcPRwcvSc+pKBeG7SHYHw=;
        b=VVbNkynaPlKbVRwjLWylkkPpOdMa4MA0/j3VIY32Hi8ipw4N3ocRUcTfZCGynenrKj
         D+TtpvPmB+sbhB4RtRnipVzpVTBBR9HP9PgYGXL6bwU9Z27ftF8orPKy8tl23w3deBvx
         siaKAvGCqh9iwiwYncCBvB0/fiIygzDzPtMYJGeJKKaNLqgsvh1eNvMfYf8urNtPtHny
         1FhqzV0gIwCswBEBODxPbS67VCt30GSGbyO+zy1Pu/r/tX5nAmVoihhcvEu+wg37l0jP
         yv/K5554pkqp1StzJSTnB71U02RIz0RFrG3ObjcxBksmNLqd9cvOQnf0Jtc4SeDpfKqM
         C34g==
X-Gm-Message-State: AOJu0Yy0mtvzauX4eFlNXQt81mUnR9BL30qIrV4gAtQiq/BDoTo8EZhk
	TXgurVc/MartpfyTlbLx/pvTV3Hbxed+SOlSHXLJlEFEvSLYe1lXRSbaAQ==
X-Google-Smtp-Source: AGHT+IGoppjWltwBNIpDBk6njAABGZRS84K8C7OIDqMLz1Z5ktVdld/MosvDt9GEAs3RwBMm7MYPoQ==
X-Received: by 2002:a81:4911:0:b0:614:c76:26f1 with SMTP id 00721157ae682-62a08d93a36mr6159327b3.21.1716505733238;
        Thu, 23 May 2024 16:08:53 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b7f1:1457:70d4:ab6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37d5d0sm474087b3.16.2024.05.23.16.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:08:52 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 1/8] bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
Date: Thu, 23 May 2024 16:08:41 -0700
Message-Id: <20240523230848.2022072-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523230848.2022072-1-thinker.li@gmail.com>
References: <20240523230848.2022072-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass an additional pointer of bpf_struct_ops_link to callback function reg,
unreg, and update provided by subsystems defined in bpf_struct_ops. A
bpf_struct_ops_map can be registered for multiple links. Passing a pointer
of bpf_struct_ops_link helps subsystems to distinguish them.

This pointer will be used in the later patches to let the subsystem
initiate a detachment on a link that was registered to it previously.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h                                    |  6 +++---
 kernel/bpf/bpf_struct_ops.c                            | 10 +++++-----
 net/bpf/bpf_dummy_struct_ops.c                         |  4 ++--
 net/ipv4/bpf_tcp_ca.c                                  |  6 +++---
 .../selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c    |  4 ++--
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c  |  6 +++---
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 90094400cc63..b600767ebe02 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1730,9 +1730,9 @@ struct bpf_struct_ops {
 	int (*init_member)(const struct btf_type *t,
 			   const struct btf_member *member,
 			   void *kdata, const void *udata);
-	int (*reg)(void *kdata);
-	void (*unreg)(void *kdata);
-	int (*update)(void *kdata, void *old_kdata);
+	int (*reg)(void *kdata, struct bpf_link *link);
+	void (*unreg)(void *kdata, struct bpf_link *link);
+	int (*update)(void *kdata, void *old_kdata, struct bpf_link *link);
 	int (*validate)(void *kdata);
 	void *cfi_stubs;
 	struct module *owner;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 86c7884abaf8..1542dded7489 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -757,7 +757,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
-	err = st_ops->reg(kdata);
+	err = st_ops->reg(kdata, NULL);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
 		 * 'st_ops->reg()' is secure since the state of the
@@ -805,7 +805,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
 	case BPF_STRUCT_OPS_STATE_INUSE:
-		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, NULL);
 		bpf_map_put(map);
 		return 0;
 	case BPF_STRUCT_OPS_STATE_TOBEFREE:
@@ -1060,7 +1060,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		/* st_link->map can be NULL if
 		 * bpf_struct_ops_link_create() fails to register.
 		 */
-		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -1125,7 +1125,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		goto err_out;
 	}
 
-	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
+	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data, link);
 	if (err)
 		goto err_out;
 
@@ -1176,7 +1176,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;
 
-	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
+	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		link = NULL;
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 891cdf61c65a..3ea52b05adfb 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -272,12 +272,12 @@ static int bpf_dummy_init_member(const struct btf_type *t,
 	return -EOPNOTSUPP;
 }
 
-static int bpf_dummy_reg(void *kdata)
+static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 {
 	return -EOPNOTSUPP;
 }
 
-static void bpf_dummy_unreg(void *kdata)
+static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
 }
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 18227757ec0c..3f88d0961e5b 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -260,17 +260,17 @@ static int bpf_tcp_ca_check_member(const struct btf_type *t,
 	return 0;
 }
 
-static int bpf_tcp_ca_reg(void *kdata)
+static int bpf_tcp_ca_reg(void *kdata, struct bpf_link *link)
 {
 	return tcp_register_congestion_control(kdata);
 }
 
-static void bpf_tcp_ca_unreg(void *kdata)
+static void bpf_tcp_ca_unreg(void *kdata, struct bpf_link *link)
 {
 	tcp_unregister_congestion_control(kdata);
 }
 
-static int bpf_tcp_ca_update(void *kdata, void *old_kdata)
+static int bpf_tcp_ca_update(void *kdata, void *old_kdata, struct bpf_link *link)
 {
 	return tcp_update_congestion_control(kdata, old_kdata);
 }
diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
index b1dd889d5d7d..948eb3962732 100644
--- a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
+++ b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
@@ -22,12 +22,12 @@ static int dummy_init_member(const struct btf_type *t,
 	return 0;
 }
 
-static int dummy_reg(void *kdata)
+static int dummy_reg(void *kdata, struct bpf_link *link)
 {
 	return 0;
 }
 
-static void dummy_unreg(void *kdata)
+static void dummy_unreg(void *kdata, struct bpf_link *link)
 {
 }
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 2a18bd320e92..0a09732cde4b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -820,7 +820,7 @@ static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
 	.is_valid_access = bpf_testmod_ops_is_valid_access,
 };
 
-static int bpf_dummy_reg(void *kdata)
+static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
@@ -835,7 +835,7 @@ static int bpf_dummy_reg(void *kdata)
 	return 0;
 }
 
-static void bpf_dummy_unreg(void *kdata)
+static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
 }
 
@@ -871,7 +871,7 @@ struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int bpf_dummy_reg2(void *kdata)
+static int bpf_dummy_reg2(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops2 *ops = kdata;
 
-- 
2.34.1


