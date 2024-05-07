Return-Path: <bpf+bounces-28759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF68BDAE6
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C265F28232C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300E6D1BB;
	Tue,  7 May 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE1Y8VZT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8ED6BFA9
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061376; cv=none; b=HtAV2RBE8mccFCDGrmgkeKJ9WPnN1OBoZMAMfdNVUVsT42LHFElsmtWdGZwF5wMl45kITr4wRhiCL+0OEVLf47ke6bmhMgDocFdXyHcPCvuzf4k5CkChDvdQlDlvltMVwFuGkhUDHdURM3ns5w1ULJO5QCVNaIjE0D2wGCNZcJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061376; c=relaxed/simple;
	bh=900zX55GN3ZLaa7mKoA3DBpRpwEN/NauKWYO4JFkpdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EAETbh/OUdLtacse8vLnSRW7DltIZ9qL3hGuw0JxD/DImfPddXQHwaxcG4kd2OkYhyRfnKAKcZELUva030/nmOaKqNKTvwi9oIWNvk6zXUGY9cOC4DLcRuUcF8RZl4yDiXitnzOGMlfGr+NNpM+hlPjilVggr/FwGe4FcFjEBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE1Y8VZT; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b205a3b3dcso896892eaf.1
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 22:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061373; x=1715666173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HprPl2jxGxgn2322TEJ1A5FUP6xMck5u8525adKN288=;
        b=FE1Y8VZTuhCDpAHBtqKD0tN3t0w8wI0/1Xlplrirn3OJmHG2GvZ/gv0wO+54q59nwG
         Cbpk1W0tOgcvogWmYtm1Q3xtE7cuzT2sTV9B/vL7eOMpJpSC1jurgCBGzablFTxgGbhE
         1jWM7cO5kaYqE1yDxx572f0a8YtWKFJH6inEapBECM2qSTGvavXo7WNYkGlhfBGQCVfX
         zM+CqYrYtlUhS055XSH9OxQ3wB+yGqpX/4vzWPNyWQ6jEUgN14SYy0A5CzUiByC5QQh8
         KNYHagu7yOb+htu1uwsBy5KTGLcIj40b3r9sUlexQi24Al5SisK4Hd2icsGvFF6LDLYm
         hYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061373; x=1715666173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HprPl2jxGxgn2322TEJ1A5FUP6xMck5u8525adKN288=;
        b=eVHgPbUfWMXFmG8xJy1i26Qtn4ANdbWwMtlkoeoK2Lf4ut5t0K1uAb308cl9JPTm9v
         J+tZLnRMRzexKTUTPuskZVkjEOc6FEpdyDGgxYOxi5awpUWMLdjmkwbQ2Tj7vwhOyFac
         Qp2JN4oRYzCw51sPH6JCFUKd7fQ9dTYc5R0WiUtYPvqe2ZgN5mOG6Ywdy2uxFIZjo2dI
         OF4l1hTYCNaRTGpRoTgOSao3nSB71+kUcvOEEKA3N9UOBTxu0080YBdTGhO6jX5sFIRK
         O8fPp4mKozrWLflXV153BknbQn84yYPB4hA4+ACdrQ9naJ6CFg/I+tCvyYKF2QkB0p64
         Fbcg==
X-Gm-Message-State: AOJu0YyBIH2Sei5YkGeMhiQBvLlVHC6iYkXMEamgS5lYl3J3YXa9pJEC
	9xfeyXgkViiKtgR4SHMTtESsvghN6Qaqx1DdKSxsOREGFr2V/S++o1ysvQ==
X-Google-Smtp-Source: AGHT+IG6/3CNGyBoyf5UB2/2gaE/S/gaEWr6qiip64j7NDLtJVSqdqeYHmaKp/+RJYuICeVXyGC+7A==
X-Received: by 2002:a4a:4b01:0:b0:5ac:9ec3:8c76 with SMTP id q1-20020a4a4b01000000b005ac9ec38c76mr11519595ooa.7.1715061373527;
        Mon, 06 May 2024 22:56:13 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2e7d:922e:d30d:e503])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a586b0906esm2317011oob.26.2024.05.06.22.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 22:56:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/6] bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
Date: Mon,  6 May 2024 22:55:55 -0700
Message-Id: <20240507055600.2382627-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507055600.2382627-1-thinker.li@gmail.com>
References: <20240507055600.2382627-1-thinker.li@gmail.com>
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
index 86c7884abaf8..390f8c155135 100644
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
+		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, st_link);
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
index 7f518ea5f4ac..dd97f7ebcd29 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -257,17 +257,17 @@ static int bpf_tcp_ca_check_member(const struct btf_type *t,
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
index eb2b78552ca2..e24a18bfee14 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -565,7 +565,7 @@ static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
 	.is_valid_access = bpf_testmod_ops_is_valid_access,
 };
 
-static int bpf_dummy_reg(void *kdata)
+static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops *ops = kdata;
 
@@ -580,7 +580,7 @@ static int bpf_dummy_reg(void *kdata)
 	return 0;
 }
 
-static void bpf_dummy_unreg(void *kdata)
+static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
 }
 
@@ -616,7 +616,7 @@ struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int bpf_dummy_reg2(void *kdata)
+static int bpf_dummy_reg2(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_ops2 *ops = kdata;
 
-- 
2.34.1


