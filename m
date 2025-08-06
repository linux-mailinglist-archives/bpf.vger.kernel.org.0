Return-Path: <bpf+bounces-65143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AEDB1C9C5
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B45416317C
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EEB29B8F0;
	Wed,  6 Aug 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM1tz3XF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E64429B21C;
	Wed,  6 Aug 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497548; cv=none; b=hfehEaAvsLhW0qrT6++dVqRV0qnN9zgtrUppkSSr2AFgE9E8ewWUaKCYQbjWB75G9+x/9BTaMYqp8yBXCm3RZBnrsBeeH8pTIaI/Sz+DhbcLDLh7mU1fLBiHRLZBC9aM+MJz75Qg5Y25zIO4eHmQn5DGaTqAV6Ku1uHYstNPH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497548; c=relaxed/simple;
	bh=oZwdBtx1Ak7sYrvCc5aVI0wrRzptGRUU+wvXli5kpWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAdQQJl3k6u1sL5Xaqf7W8I2hR2iu1W7gjfX91lFAUq8IiIkesQ8/oK/n9nQeITHWNqufDmCXh/t1ksIWFtPmuv3aISAgXlTv3Ziw9zLA824y/yO4zAvSVYTyRvQFujQ0hJHAO0nTQJEdA4Rsa3JOdrg7JSIUXfuLSS+2ODOgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM1tz3XF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4298520a12.2;
        Wed, 06 Aug 2025 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754497545; x=1755102345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgPLCasO+nEt6+klz9hJsRLR+sHZUUibNGqx8rxIwT4=;
        b=CM1tz3XFRVB1vDIeIKCY6za2MxSEW/Vt++G/Bt42zL/8P2W2YD+YzxdzQ52ZzNkSZ4
         8cRki1go4WRnynRi/oCxwfFLuM0nDY4JnfGIZEjll9sm8cTmVngVK0uUcAhpQpZTfEEd
         2vItVTQS+LR55AkP6lFLXh308+qHMLdm+s/bbsb4t+0MKf3bqLHkNKEv5oLBUklX4LdL
         dww75fGx+ICAWhrVM+6je7T4xBEhyGIIato6ETKvw3y/+p1NQWd10lOb3SWBAydKB+Q0
         e/wLXy2/Dp06+XJZx3og7U5lU6jVm8D9Ryl5t7PuAYnexiM9f8SUEcvho7zuZoX1ekCi
         20vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497545; x=1755102345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgPLCasO+nEt6+klz9hJsRLR+sHZUUibNGqx8rxIwT4=;
        b=LpQKp3FlYJAB4Eat5BMnbIJ0KZ75GfCA7S/NhfNkaaLV+pTtPTl8eT5VCdzU7H35sG
         FBCEwGmIxtJSTpMZ5Mj11ZTN1XDQf7ZWp94bQELJlGT0mPuaPYKaHd2l81vzEoHH0+cu
         pAvUanMLeQ2hOCUMQJjOWGYavGVbJK1i+7X2EPeLAbmxXnH+socMXqsb4WiofExPZCPD
         B09a20J8ch51Zx611Vkz360+cit9rFzAO8Gp82akQufRKp8bBBuVba134pXB+a+Ag31k
         xTPjqsQOJh+vlrHZKW9eY0qwFrzgY34KpoRlUFLboec4neLcAgWTjEJsSzEXg/aEvgwv
         6o3Q==
X-Gm-Message-State: AOJu0YyxurqIJqtVHUhegQJC6voS5X8OkJt6rPnacZGXj3xDVm6968eB
	QLFEBqOMcZn6XLHoldlhPeahaKjNlcK3wU2XMnrW7W4X24V533rYkgO7tyKH1A==
X-Gm-Gg: ASbGncs3ksbIkM7ZFfh6ul/sFvOi/60jTE7Rstm0EFcueRxgdaHaycbGu+T1FEldSEt
	KxYYRujD4cE2a3iNWeGzFU/XSq3Mgv2qtkCcK3VKzN2cM2vfkrVcXMKByZJerfAIBju21tz46nA
	Q4g38SE1Qf8lrd7PxeCF244bhfyeHD4JV9iBaSfUlTcDoYHqlU8ABz74rOh74MfRsjCYcE8gtZ+
	SmP0PWzfm03sTp9Z6Rocg7JnZWTDhiBg86ek8yhuEU9RLLA5f6hVctOy3klgqsblUIaXGzvoEz5
	MIPHPtRvuZthb/QFeliI6RfM2M9aRVNXdK0Q5gcj5r9Go2u9Pv/4FlZAz5IYqFbad8diWsup3ey
	8L9tAAoVs/IPY
X-Google-Smtp-Source: AGHT+IFIOe3MqC5khoOKX+VXnN3ZTGv0Yzye9zUuWL5CwGN5BIixC0lypgRg/x2L6NQKAlzXDfYogA==
X-Received: by 2002:a17:903:4b30:b0:235:779:edf0 with SMTP id d9443c01a7336-242a0be49b5mr40235165ad.50.1754497544316;
        Wed, 06 Aug 2025 09:25:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5e5sm161395475ad.124.2025.08.06.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:25:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Add multi_st_ops that supports multiple instances
Date: Wed,  6 Aug 2025 09:25:39 -0700
Message-ID: <20250806162540.681679-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250806162540.681679-1-ameryhung@gmail.com>
References: <20250806162540.681679-1-ameryhung@gmail.com>
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
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 109 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   8 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   2 +
 3 files changed, 119 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e9e918cdf31f..9ae31b1cbb13 100644
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
@@ -1528,6 +1531,111 @@ static struct bpf_struct_ops testmod_st_ops = {
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
+	unsigned long flags;
+	int err = 0;
+	u32 id;
+
+	id = bpf_struct_ops_id(kdata);
+
+	spin_lock_irqsave(&multi_st_ops_lock, flags);
+	if (multi_st_ops_find_nolock(id)) {
+		pr_err("multi_st_ops(id:%d) has already been registered\n", id);
+		err = -EEXIST;
+		goto unlock;
+	}
+
+	st_ops->id = id;
+	hlist_add_head(&st_ops->node, &multi_st_ops_list);
+unlock:
+	spin_unlock_irqrestore(&multi_st_ops_lock, flags);
+
+	return err;
+}
+
+static void multi_st_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_testmod_multi_st_ops *st_ops;
+	unsigned long flags;
+	u32 id;
+
+	id = bpf_struct_ops_id(kdata);
+
+	spin_lock_irqsave(&multi_st_ops_lock, flags);
+	st_ops = multi_st_ops_find_nolock(id);
+	if (st_ops)
+		hlist_del(&st_ops->node);
+	spin_unlock_irqrestore(&multi_st_ops_lock, flags);
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
@@ -1550,6 +1658,7 @@ static int bpf_testmod_init(void)
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


