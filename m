Return-Path: <bpf+bounces-30172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC28CB62C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014CF1C21BC2
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2377149C66;
	Tue, 21 May 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnoNTLse"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A73DB89
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331984; cv=none; b=KVQK93gSQsW7YAyP3LBirIW6j5dDz0bY3S2glbS4y8I3vUav33FOEli7ip5M0GQZVCtSC4HUzHOjwQUkuXOqjyIPvyeRn/kNr6ky+SzS2vG6vcNVyQiLULgPh+hef3N8V7rMy9aDlwjj+L3365mC9KqNJI7x6fBnqD+TJLXIbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331984; c=relaxed/simple;
	bh=CJw1aL03b9FTfcvig5zTnobUTi1c6JlqNPNhQ64K2wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4IWvKBOPvKWkXLylZN4CsyleILnInZvdqk+23DUZNwb3bEJ0pt/ZwlkRjzV9AZLHL1DN8IICh80+e0H9lEqYWJArDgiwNdYfcqYK8SvGYW8Jb2Q4SyVctgFaGk3p02kzZBL47F9oAaiwvVAdgvOgfP0uceedx2unz5Ezks0meY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnoNTLse; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-df4dce67becso391036276.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331981; x=1716936781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmt0rlNlJbrjlCasd7uin+JcPRwcvSc+pKBeG7SHYHw=;
        b=gnoNTLsevPIuX/itLpZNqe481NXjhUSCiXCk3vtZh09Rr2AXvwseapA7HQK3ka002q
         zCfaulKTIfcEddmzDLmQF4wc6OrNKWbPIBS0J/fpyBMD8shUGQ5d+4Z2GRPqVK+PO2zV
         gdfcDdrO1WLRLR+7mK15T+7dGoXN8MqblylussDQim+sthjMBxUIk5qtJ9bnIp7qPJju
         +SAeX7uaLczGwdvKNEPtmSBKvEGuhHTQAvjwVgd6BYJKibXBWl3JmPGu8uGztaSQt4X0
         gJfPd/V0LSOZKyWbViz1LUE8DlRbPfYAR6k/kg5nZd0KF66zxRkBXiopC/IEuVgzv73M
         YHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331981; x=1716936781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmt0rlNlJbrjlCasd7uin+JcPRwcvSc+pKBeG7SHYHw=;
        b=r1LJGlvanGXdOn+WjxHpAp53siY+qeB51ZUoDco/2DYbp7V7i4ZN2B2qyjOM/fJPz0
         i2GWx7cmeOOdo5Lcx1XC7GdKuQWP63GJBoncYNEFSm2gHwoT8J0W/IgftIPfEaD7s+z4
         GFOKLv3w4+kI/sn2x9jZIkTUMpsbHA1MO/f1+ockIJAUWmCtywOe4/Mv8c8AYO4GGesY
         tNSYKj9+LvkcA8l26lilaZXWADn8IpbUKymaG9rB2HozYuoZx6HHHy3z2jVVmvRdhidi
         5IQMMnk43PRsa8AL9DKuH1ShzK4SGsGQvajO0eu18dx8HJvr2DNWz3c7Ngx/+kzTarLi
         81vw==
X-Gm-Message-State: AOJu0YxdVCejAztybXEsEQKXf5izZ8ndzRcYmNVBI3OxqcOoMgvGRbyP
	iSGjirqkOBRrIxRVo9DdQItmTBVDiw3kTq2cL0uNbv89DLbMGFbRtHSsGA==
X-Google-Smtp-Source: AGHT+IGCfAdSgMeaKbbmnRi2OrrUWI4Jatj928/eJ2jG77iC1fuEz+HImhVFqizczvQZocsCFAJ3Nw==
X-Received: by 2002:a5b:387:0:b0:df4:b3f0:5ee4 with SMTP id 3f1490d57ef6-df4e0aca9fcmr510502276.16.1716331981444;
        Tue, 21 May 2024 15:53:01 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1437:59a6:29be:9221])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd385be51sm5584956276.54.2024.05.21.15.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:53:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/7] bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
Date: Tue, 21 May 2024 15:51:15 -0700
Message-Id: <20240521225121.770930-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521225121.770930-1-thinker.li@gmail.com>
References: <20240521225121.770930-1-thinker.li@gmail.com>
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


