Return-Path: <bpf+bounces-48049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3DDA036FA
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 05:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDC8160FAB
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 04:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25169158520;
	Tue,  7 Jan 2025 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P2uH12Uk"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20918C0C;
	Tue,  7 Jan 2025 04:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736223776; cv=none; b=uV2DPiL0n7yKVOwWpZ8Lu5TWIQBRoJxKC5k46VOl1I1lG/WKgzhuL9fjjr6YyaUZh45z35cHI1kQutrAC9JdkRfbkWFJL5F4BrvJj+s7ROaXzvF1r7b4jvly9Ledvte5mc2NkMLO46aadb80kt7JmDpRWfrXafVdW+2GMqHzbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736223776; c=relaxed/simple;
	bh=BndSGjZeeV8yhLuRMYNsncQZ7TF/PC+gXFAxaM11Isw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONzQj2u4fy0GgwKsgW0Xg3T4rwix9FPPybnyGoG7A571iz5+x3T2zehHW3YnrXidVQt4HNeP20fpb5202tWbRpwVkpuVX2xK0HazqWVcGNlNlBT0CVu5xPFA4W13yhQKQSuDaoGPTR7pP+PhLWJKyzYsI1VMgQTZuyKKrlbwnM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P2uH12Uk; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736223765; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8XcwzEH1Li0PZHViDS8i234tbohuRUg6Knq6W29/4RE=;
	b=P2uH12UkA3ib4mJfAt1ZTzmYtdXB6p1VLBtHmX2DovYvSxxOFdofSBwQpb9qeKG3Nhk4Pqqc0deItDjMruEm1b87KuXIe7O2dvX2AWdzPUDVQBQSwlqV9KirefMeF0WhWev72l2nKr5Acc7nPSPgtTf0EhsF4ksDOlNxG5C+Jqo=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WN9KZaX_1736223442 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jan 2025 12:17:23 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	yhs@fb.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v5 3/5] net/smc: bpf: register smc_ops info struct_ops
Date: Tue,  7 Jan 2025 12:17:13 +0800
Message-ID: <20250107041715.98342-4-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250107041715.98342-1-alibuda@linux.alibaba.com>
References: <20250107041715.98342-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To implement injection capability for smc via struct_ops, so that
user can make their own smc_ops to modify the behavior of smc stack.

Currently, user can write their own implememtion to choose whether to
use SMC or not before TCP 3rd handshake to be comleted. In the future,
users can implement more complex functions on smc by expanding it.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c  | 10 ++++++
 net/smc/smc_ops.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_ops.h |  5 +++
 3 files changed, 94 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9d76e902fd77..6adedae2986d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -55,6 +55,7 @@
 #include "smc_sysctl.h"
 #include "smc_loopback.h"
 #include "smc_inet.h"
+#include "smc_ops.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3576,8 +3577,17 @@ static int __init smc_init(void)
 		pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
 		goto out_ulp;
 	}
+
+	rc = smc_bpf_struct_ops_init();
+	if (rc) {
+		pr_err("%s: smc_bpf_struct_ops_init fails with %d\n", __func__, rc);
+		goto out_inet;
+	}
+
 	static_branch_enable(&tcp_have_smc);
 	return 0;
+out_inet:
+	smc_inet_exit();
 out_ulp:
 	tcp_unregister_ulp(&smc_ulp_ops);
 out_lo:
diff --git a/net/smc/smc_ops.c b/net/smc/smc_ops.c
index 0fc19cadd760..67b6b2b92771 100644
--- a/net/smc/smc_ops.c
+++ b/net/smc/smc_ops.c
@@ -10,6 +10,10 @@
  *  Author: D. Wythe <alibuda@linux.alibaba.com>
  */
 
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
 #include "smc_ops.h"
 
 static DEFINE_SPINLOCK(smc_ops_list_lock);
@@ -49,3 +53,78 @@ struct smc_ops *smc_ops_find_by_name(const char *name)
 	}
 	return NULL;
 }
+
+static int __bpf_smc_stub_set_tcp_option(struct tcp_sock *tp) { return 1; }
+static int __bpf_smc_stub_set_tcp_option_cond(const struct tcp_sock *tp,
+					      struct inet_request_sock *ireq)
+{
+	return 1;
+}
+
+static struct smc_ops __bpf_smc_bpf_ops = {
+	.set_option		= __bpf_smc_stub_set_tcp_option,
+	.set_option_cond	= __bpf_smc_stub_set_tcp_option_cond,
+};
+
+static int smc_bpf_ops_init(struct btf *btf) { return 0; }
+
+static int smc_bpf_ops_reg(void *kdata, struct bpf_link *link)
+{
+	return smc_ops_reg(kdata);
+}
+
+static void smc_bpf_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	smc_ops_unreg(kdata);
+}
+
+static int smc_bpf_ops_init_member(const struct btf_type *t,
+				   const struct btf_member *member,
+				   void *kdata, const void *udata)
+{
+	const struct smc_ops *u_ops;
+	struct smc_ops *k_ops;
+	u32 moff;
+
+	u_ops = (const struct smc_ops *)udata;
+	k_ops = (struct smc_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct smc_ops, name):
+		if (bpf_obj_name_cpy(k_ops->name, u_ops->name,
+				     sizeof(u_ops->name)) <= 0)
+			return -EINVAL;
+		return 1;
+	case offsetof(struct smc_ops, flags):
+		if (u_ops->flags & ~SMC_OPS_ALL_FLAGS)
+			return -EINVAL;
+		k_ops->flags = u_ops->flags;
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct bpf_verifier_ops smc_bpf_verifier_ops = {
+	.get_func_proto		= bpf_base_func_proto,
+	.is_valid_access	= bpf_tracing_btf_ctx_access,
+};
+
+static struct bpf_struct_ops bpf_smc_bpf_ops = {
+	.name		= "smc_ops",
+	.init		= smc_bpf_ops_init,
+	.reg		= smc_bpf_ops_reg,
+	.unreg		= smc_bpf_ops_unreg,
+	.cfi_stubs	= &__bpf_smc_bpf_ops,
+	.verifier_ops	= &smc_bpf_verifier_ops,
+	.init_member	= smc_bpf_ops_init_member,
+	.owner		= THIS_MODULE,
+};
+
+int smc_bpf_struct_ops_init(void)
+{
+	return register_bpf_struct_ops(&bpf_smc_bpf_ops, smc_ops);
+}
diff --git a/net/smc/smc_ops.h b/net/smc/smc_ops.h
index 4b33dc2d65b9..06dc30363a83 100644
--- a/net/smc/smc_ops.h
+++ b/net/smc/smc_ops.h
@@ -21,5 +21,10 @@
  * Note: Caller MUST ensure it's was invoked under rcu_read_lock.
  */
 struct smc_ops *smc_ops_find_by_name(const char *name);
+#if IS_ENABLED(CONFIG_SMC_OPS)
+int smc_bpf_struct_ops_init(void);
+#else
+static inline int smc_bpf_struct_ops_init(void) { return 0; }
+#endif
 
 #endif /* __SMC_OPS */
-- 
2.45.0


