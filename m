Return-Path: <bpf+bounces-29412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E018C1BBE
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3D528558F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349FE51C4D;
	Fri, 10 May 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx/DMwlk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F5717995
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300988; cv=none; b=Y65pGDM9XGx822RerUhZSUAnvMuuHPujzcV9z7f18+E+FRnoc1mvSUxtIIIpByqOLkue8LNX/icCIG3V1SuxHNKPgNvCnTtlLqYUY5vAN4nespcJ9ip3qTcS96BkiQc1lXMne5/RvP+xU4RqTRqU+tXdtNBGtWpZyhJX/QrOyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300988; c=relaxed/simple;
	bh=VUGRX/70hVzxNPNnDhlV/a/lOJJQl40JorO2jRPSOag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oa8NFxSpk0O8uFeDAiwnFq0bjPKe+3kzefJ0tVKZVXsL5nBMqjk+9Qktt11CKImz/eI4pe4aGqjwCFjwkrOtDcwDlFck73HoZl0XZWY2bP5DuCQRRzVsGlmeEzJTOcD3ewpjsKvehid492XqkE1zFxgv2TS6lkyPaqRsAGbqsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx/DMwlk; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9539d1bbcso1210127b6e.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715300986; x=1715905786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0zZzdex50aU7PIEB2qKSmX/JBrGBruW4jEWlu/qrkg=;
        b=Sx/DMwlk+vwqeUf1L3MhxwHnN/3jqFlxp88aM/xuh1F9eyV4BdTCkCnTpA013YWZFl
         C8gxYtvofiAaRF/XJu2BCA5pKR5nf4/6YDx7rz0UrTy985WY1c9fGfNAahvXSatS7m4V
         9f4EdxIOSk+kGwZMVNVRNuRD5PGKfRjkYTqLiNZWOfX82HUQnISKxPbXz+UJ2K6+y7lm
         2pDABibJJCKjDIZUK1KYdq3yh4swNI4Z0b56iUJRD9Tvn7nv0WpneZROtSsylEqzCNFE
         e2lH2XYj+g8EfKLWAVGgf82Esu0JIQZ7m1yFigdJu9AS8qm4v/bH3TkwkXv+CcqXJi0b
         5kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300986; x=1715905786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0zZzdex50aU7PIEB2qKSmX/JBrGBruW4jEWlu/qrkg=;
        b=WuGKt5FtNjP+ax0Euci4lXyQUhacUoFKK9wu5CtQTAixeM0Y5gUQc29Qqn/acxhKeF
         qu+WbyTdalPYM3quP/sDXZUbRhqHnSykqpXo6Y0u1lTSSoViPpFvd6P0VMeu1b++wUAp
         TZtKCT3kggylS1rK0CtWkj+bEkw3ovnvcPZIYabSMWYe9gEM5+rxhOpVGHmjYvXxiORV
         i/+0sm55S7smXgyii74ZMjBrWqeBANwUv2Vptmu1gezhKCCvSjB/645YdGxUfrI11Pp/
         kpx6DdQMYvC1X/q+quho6h8g33vcpnGwlVf73WRGTRiF45rKmi6FtWtc0oquG5DSz51T
         qfXg==
X-Gm-Message-State: AOJu0YzcNE6p89H0soFJXeA+0lXaGtYggqBLoPyvtpkLh3HvNgZ4XOd5
	KkiNs1qcDIytVAS3KaHxU8bC8ZvWDz7ek0flk6eJxN4TQYzptZA0APa7kA==
X-Google-Smtp-Source: AGHT+IHbzo9jJcCFh3M12oIeKGvWMmfqZND1uhU/MPOJhpB543gQa3UnhrwATONBmduKBvyy4dt95g==
X-Received: by 2002:a05:6808:1820:b0:3c9:74e6:1f51 with SMTP id 5614622812f47-3c996d22738mr751325b6e.18.1715300985857;
        Thu, 09 May 2024 17:29:45 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fc7e00bsm433251b6e.4.2024.05.09.17.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 17:29:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/7] bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
Date: Thu,  9 May 2024 17:29:36 -0700
Message-Id: <20240510002942.1253354-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510002942.1253354-1-thinker.li@gmail.com>
References: <20240510002942.1253354-1-thinker.li@gmail.com>
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
index e93013fc7bf4..1150e758e630 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -817,7 +817,7 @@ static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
 	.is_valid_access = bpf_testmod_ops_is_valid_access,
 };
 
-static int bpf_dummy_reg(void *kdata)
+static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
@@ -832,7 +832,7 @@ static int bpf_dummy_reg(void *kdata)
 	return 0;
 }
 
-static void bpf_dummy_unreg(void *kdata)
+static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
 }
 
@@ -868,7 +868,7 @@ struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int bpf_dummy_reg2(void *kdata)
+static int bpf_dummy_reg2(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops2 *ops = kdata;
 
-- 
2.34.1


