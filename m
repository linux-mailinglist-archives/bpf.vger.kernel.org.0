Return-Path: <bpf+bounces-64841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD27B177D9
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 23:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E243A3B109F
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00248265631;
	Thu, 31 Jul 2025 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcFNmfML"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA91D07BA;
	Thu, 31 Jul 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996195; cv=none; b=SwzvFj629ZCvIWNsRlKVIrR8QVreuxQWvo50T5JVyp3j+EzkPhVeq6JbE3+BsRaubOdlMPdyMYo9V4oIoJf0rI0r+2sMvy5KFT9ScAh39h5fUSkFRxUTGMUdxH27I67kcBx13pmZoluqNTe2a8iabfwKTsrrexCFTulm9zwXKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996195; c=relaxed/simple;
	bh=WuvVu6AyTmhgiCHpFXe79/0zf5rcIT/+kdpThc6zKp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0MfbGCxedIn7hLhjmh94gHbjUB/G/xCHb+sF6KdgGdjpFoHbbJLvwedAtrnqzUfLhREoohMBXfP5Py1OQ/+g4BVxr6+TGG37iyScM3LtelcB+HiN4jeOq9qOqQ4IQEQNQ9j4nD8o/0coa02zR8sOBm2N4pLLfEVS5aidinfM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcFNmfML; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23ffdea3575so1645705ad.2;
        Thu, 31 Jul 2025 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753996193; x=1754600993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz4S62k/yZsD/QQgYbwfIcOjRRpF5xCpSfPDvi+GJh8=;
        b=mcFNmfMLD7jg94Tw6o+gCN2ShcF7Cj0BmccHEhckeO2DXuawQ2fJgvcyA+wm3jBwnR
         IgEGA+tyEL6yl4AQDBC8caal+n7h9UDV7X8cdQULsarX04Zn33WzCsmtM2VcU/vA2U08
         7NCEPKNp7ChfW1CxNB8e87v66VgmGumDzKP4YWoC3cAXuA0e4OyHwNpoL/H1Q5TF5elR
         UwzLO3WZMzNVMtUNa19l8kLmNgbYV3cgrBwnzY4NbsnfWZr2Z+VtqW8VfoL7+v4T9Kct
         MG+6geKb97mF6aiLSbg1Gjngd71xsfBhaz0j3yNEgGgMzESFyj7yJ2PLnS1Re8k4NlB8
         wTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996193; x=1754600993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz4S62k/yZsD/QQgYbwfIcOjRRpF5xCpSfPDvi+GJh8=;
        b=NL0TAM9SVKeDY0pZfeKYGzRK1LWJf/OFvOZnK7orHgk57ExucRLwvhkOQHRTTM4hat
         OPkFa5tP9TcOoZCNbDYX3V6M8ijmCjsS62oFxMyg/dAte0NZCk9tNUTvBTgC0uQIzh5m
         RRB9Ckr9PIm6Lt7WzLofCOGNR3xWPokTG9B0xm3aEMSpzhrvQ++R3BSFmIrkKpltO4KD
         cC8dZ/cSyGvBQmgHSxU8gSrwZ+5FeDov9NZgJvvAW9CtUq7sz6UXXkCuvVfiG37u3JPY
         Z6/BsLhT5zDosUysswEMY1Q6RYbmEaHUhqS2MK9IURwx/NqX3foT7/RI3kKAUHXUdqHO
         h7rg==
X-Gm-Message-State: AOJu0YyQ/Aawt5gDNm6GWFLKGI4xuuPiU8au4IHYYu1yitLmrjmZ0X7x
	Ec5ceCK36m8u/9On1vOT9I5Z0QUQWSQtR3j4+3oFHcax3kCwTi8dfFGzuRIWkA==
X-Gm-Gg: ASbGncupATGGQKQucOwnPCsVRH8n1o9anlErhPKFABU2aKMtpbno/2Zv/IZbt6deL/1
	NDv1iM1VJT80JM0RzK/tjMv+p0eX9lcJU/2BmMAgNB4GT6mPPzVXwGJP78zmJmlev2mgryvsEMV
	eeNNVhtrl918EGRYvXJoq4AxQEtSfGlI19EVXB9CLzVw1pbYLDriUR54O5GGR+0Rwg5xpqhgn/r
	G7w/O39tnZ8L6e/b3oErACHIachQUCGIvJkzcC1iOUbFVevVv4bLMvtDtemswYh/B5xIXQFNPSI
	Wj90UsQwhjCLTm9Owaw4eFJ4/Y3P6qNvXwBIKofIZYuL4zOiPIuDecW+Y8wrAXro3/ZD4uHm8RV
	fjaUROj+CYYHVOg==
X-Google-Smtp-Source: AGHT+IFzcFDOW8n1q+q6u1pWuYByHst9aZOjecyz1Mo7trCnXf/8Z2aAOmpKGO2ri+npIXkw/u1gGQ==
X-Received: by 2002:a17:903:2f05:b0:235:779:edfd with SMTP id d9443c01a7336-24096b24650mr118440355ad.39.1753996193151;
        Thu, 31 Jul 2025 14:09:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e945sm25914595ad.56.2025.07.31.14.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:09:52 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] selftests/bpf: Add multi_st_ops that supports multiple instances
Date: Thu, 31 Jul 2025 14:09:49 -0700
Message-ID: <20250731210950.3927649-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250731210950.3927649-1-ameryhung@gmail.com>
References: <20250731210950.3927649-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current struct_ops in bpf_testmod only support attaching single instance.
Add multi_st_ops that supports multiple instances. The struct_ops uses map
id as the struct_ops id and will reject attachment with an existing id.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 112 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   8 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   2 +
 3 files changed, 122 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e9e918cdf31f..522c2ddca929 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1057,6 +1057,8 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 	return args->a;
 }
 
+__bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id);
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -1097,6 +1099,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_SLEEPABL
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1528,6 +1531,114 @@ static struct bpf_struct_ops testmod_st_ops = {
 	.owner = THIS_MODULE,
 };
 
+struct hlist_head multi_st_ops_list;
+static DEFINE_SPINLOCK(multi_st_ops_lock);
+
+static int multi_st_ops_init(struct btf *btf)
+{
+	spin_lock_init(&multi_st_ops_lock);
+	INIT_HLIST_HEAD(&multi_st_ops_list);
+
+	return 0;
+}
+
+static int multi_st_ops_init_member(const struct btf_type *t,
+				    const struct btf_member *member,
+				    void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static struct bpf_testmod_multi_st_ops *multi_st_ops_find_nolock(u32 id)
+{
+	struct bpf_testmod_multi_st_ops *st_ops;
+
+	hlist_for_each_entry(st_ops, &multi_st_ops_list, node) {
+		if (st_ops->id == id)
+			return st_ops;
+	}
+
+	return NULL;
+}
+
+int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
+{
+	struct bpf_testmod_multi_st_ops *st_ops;
+	unsigned long flags;
+	int ret = -1;
+
+	spin_lock_irqsave(&multi_st_ops_lock, flags);
+	st_ops = multi_st_ops_find_nolock(id);
+	if (st_ops)
+		ret = st_ops->test_1(args);
+	spin_unlock_irqrestore(&multi_st_ops_lock, flags);
+
+	return ret;
+}
+
+static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_testmod_multi_st_ops *st_ops =
+		(struct bpf_testmod_multi_st_ops *)kdata;
+	struct bpf_map *map;
+	unsigned long flags;
+	int err = 0;
+
+	map = bpf_struct_ops_get(kdata);
+
+	spin_lock_irqsave(&multi_st_ops_lock, flags);
+	if (multi_st_ops_find_nolock(map->id)) {
+		pr_err("multi_st_ops(id:%d) has already been registered\n", map->id);
+		err = -EEXIST;
+		goto unlock;
+	}
+
+	st_ops->id = map->id;
+	hlist_add_head(&st_ops->node, &multi_st_ops_list);
+unlock:
+	bpf_struct_ops_put(kdata);
+	spin_unlock_irqrestore(&multi_st_ops_lock, flags);
+
+	return err;
+}
+
+static void multi_st_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_testmod_multi_st_ops *st_ops;
+	struct bpf_map *map;
+	unsigned long flags;
+
+	map = bpf_struct_ops_get(kdata);
+
+	spin_lock_irqsave(&multi_st_ops_lock, flags);
+	st_ops = multi_st_ops_find_nolock(map->id);
+	if (st_ops)
+		hlist_del(&st_ops->node);
+	spin_unlock_irqrestore(&multi_st_ops_lock, flags);
+
+	bpf_struct_ops_put(kdata);
+}
+
+static int bpf_testmod_multi_st_ops__test_1(struct st_ops_args *args)
+{
+	return 0;
+}
+
+static struct bpf_testmod_multi_st_ops multi_st_ops_cfi_stubs = {
+	.test_1 = bpf_testmod_multi_st_ops__test_1,
+};
+
+struct bpf_struct_ops testmod_multi_st_ops = {
+	.verifier_ops = &bpf_testmod_verifier_ops,
+	.init = multi_st_ops_init,
+	.init_member = multi_st_ops_init_member,
+	.reg = multi_st_ops_reg,
+	.unreg = multi_st_ops_unreg,
+	.cfi_stubs = &multi_st_ops_cfi_stubs,
+	.name = "bpf_testmod_multi_st_ops",
+	.owner = THIS_MODULE,
+};
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -1550,6 +1661,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_ops3);
 	ret = ret ?: register_bpf_struct_ops(&testmod_st_ops, bpf_testmod_st_ops);
+	ret = ret ?: register_bpf_struct_ops(&testmod_multi_st_ops, bpf_testmod_multi_st_ops);
 	ret = ret ?: register_btf_id_dtor_kfuncs(bpf_testmod_dtors,
 						 ARRAY_SIZE(bpf_testmod_dtors),
 						 THIS_MODULE);
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index c9fab51f16e2..b8001ba7c368 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -116,4 +116,12 @@ struct bpf_testmod_st_ops {
 	struct module *owner;
 };
 
+#define BPF_TESTMOD_NAME_SZ 16
+
+struct bpf_testmod_multi_st_ops {
+	int (*test_1)(struct st_ops_args *args);
+	struct hlist_node node;
+	int id;
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index b58817938deb..286e7faa4754 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -159,4 +159,6 @@ void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
 void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
 void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
 
+int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.47.3


