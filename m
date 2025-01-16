Return-Path: <bpf+bounces-49035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EDEA1342C
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 08:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2D77A1F28
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2F1AAA32;
	Thu, 16 Jan 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vHOT9cE+"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA618A6C1;
	Thu, 16 Jan 2025 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013502; cv=none; b=JTUdmaSkIHsMhoOzwm1SN+xmCkdqP0cie078DDxknn8L+rwvHfzLAIYjAQOh9Re43ECEi0xptSj/QzfWxK6q1fs8Aph083H/epawBAL0rfWucPqtbuwSbuxFwNOcdry+WERZ2e7P2xCDqRkz/9xsZTWNVKwMJNLqwI+HgsmkRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013502; c=relaxed/simple;
	bh=XPY5sBRMk+dQcK13GpQ1A7YfJP6sKoQcmp5Xgwf/KAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh/L/XWESGXQQ+bgkYOEL7+qUNqIPodV8eOtDd8ZX8jiT47ngCcI/lWZlvJBosVKJsS5hWgox0KUXsE0zqtqklN76JQkmln0XMZUpqcbl301QD+Xdkl2ZG3Sp+2xZMVJmXaW+kTULrJbeSH2BiKhLMuP7e84jB4jYQuH6mzj+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vHOT9cE+; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737013492; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=c0fwN+W0ffx+9pts7hqGMxh7U0dZDFO+zafipY+9BQo=;
	b=vHOT9cE+45yZCQwtmFqxDDNswYlvTn90FaiFXwZXqahk6mUKj5xBJRROE+6sSJi1TS1AX5uQ1MOI9k6FDTXDcygy2cxb7Yr4R8Z2hrMKKemheJwx8d9ka0/7aix98jue3jV4PW5Z7Aj7NR4V1GGbtYNlt61JzISS8XDP+kzMGno=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WNkukX3_1737013490 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 15:44:50 +0800
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
Subject: [PATCH bpf-next v6 3/5] net/smc: bpf: register smc_ops info struct_ops
Date: Thu, 16 Jan 2025 15:44:40 +0800
Message-ID: <20250116074442.79304-4-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250116074442.79304-1-alibuda@linux.alibaba.com>
References: <20250116074442.79304-1-alibuda@linux.alibaba.com>
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
 net/smc/af_smc.c  | 11 +++++++
 net/smc/smc_ops.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_ops.h |  5 +++
 3 files changed, 94 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9d76e902fd77..8af7c5503fdf 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -55,6 +55,7 @@
 #include "smc_sysctl.h"
 #include "smc_loopback.h"
 #include "smc_inet.h"
+#include "smc_ops.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3576,8 +3577,18 @@ static int __init smc_init(void)
 		pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
 		goto out_ulp;
 	}
+
+	rc = smc_bpf_struct_ops_init();
+	if (rc) {
+		pr_err("%s: smc_bpf_struct_ops_init fails with %d\n", __func__,
+		       rc);
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
index 86c71f6c5ea6..adff580a74eb 100644
--- a/net/smc/smc_ops.c
+++ b/net/smc/smc_ops.c
@@ -10,6 +10,9 @@
  *  Author: D. Wythe <alibuda@linux.alibaba.com>
  */
 
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/rculist.h>
 
 #include "smc_ops.h"
@@ -51,3 +54,78 @@ struct smc_ops *smc_ops_find_by_name(const char *name)
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
index 24f094464b45..412f225fe6f3 100644
--- a/net/smc/smc_ops.h
+++ b/net/smc/smc_ops.h
@@ -24,5 +24,10 @@ void smc_ops_unreg(struct smc_ops *ops);
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


