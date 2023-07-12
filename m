Return-Path: <bpf+bounces-4859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85594750CE6
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 17:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E84281A99
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868FB14F80;
	Wed, 12 Jul 2023 15:40:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A78714F78
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 15:40:28 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D14DC
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 08:40:21 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-635857af3beso36570936d6.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176420; x=1691768420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIVJ8m70eVFuGOxYvc51foJhdoHNj3yIFKjuy/q9AYg=;
        b=cGuVd4SXy4DHL/TTO+k/Ka8yR+mss0XN64UbovvpTezaL4BrWHu8CDYUhfYRl8T6uc
         nfkNXY+9UUgwxqCoWIsgozkByNcspCxxgL2BjPWSqYErClOW1zA8rBcI2N4gw3nI0ztG
         7w9fhPp2UYMq5VKAfG510CDDrcVNARElDqAnnvWmDxcPA2fkLtCUWF3i18OHIFy/hhnS
         ATPMJEwM3lHfIVLrNU11kUP1hqxqY2ntr5mEOQx6b+qZ2NSB73J11G1vT70LH8c5RqXN
         XiztDfsiw00cmyYy2ZugFo9CXM1ibXIsnFei8qj8CXX/qdTh6LhIUYthiUk/nXBc29Gf
         vKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176420; x=1691768420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIVJ8m70eVFuGOxYvc51foJhdoHNj3yIFKjuy/q9AYg=;
        b=gzn3h1KFwjV0mFsCPz584TKeBdYff41N7v0o+3uXx03Mq1huuM4WAJTqyty41J3uuq
         qlvswVWirZjOyw/dqkIFmONjGW5SJ99WI8JlMDX50a/hHuJY3Bq+EGk6Z4EpDhPZE25Z
         wJaF1NLrzX05Gjo7SbwyPf5Wtx/fVpoOxkFZa7vyxw7tEciXU7BZ6lRmlFp8CBkcsYk5
         nacMCEt6S5CVyu2YwRgl198LUQFDGAI3n3TaAglh3z4JZX83xMzirKGt0GU0KleqXJsr
         yeCuLCgHmOjsprynwBWQr2e9oiIxpFrdx92X9kVWALo4lp7xz2vYAbxXKebVU5oxxdZQ
         K+sw==
X-Gm-Message-State: ABy/qLbKPoewaZnU5l1lAonrsVXjbgnfHXDrsWOY1aZEWul6n8FN3Foy
	Kn+Hv736OTCNVDyFKeAiLiLMjQ==
X-Google-Smtp-Source: APBJJlHpRD5DrgG3JT93QY9DYyxOFBFDzOr0h3sYr5E3OzwPAcP8w24jhFdvAiBRW1TQsFsc2Pg/7A==
X-Received: by 2002:a0c:df94:0:b0:630:77b:2a08 with SMTP id w20-20020a0cdf94000000b00630077b2a08mr17053342qvl.41.1689176420363;
        Wed, 12 Jul 2023 08:40:20 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:19 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	bpf@vger.kernel.org,
	mattyk@nvidia.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v4 net-next 14/22] p4tc: add set of P4TC table read kfuncs
Date: Wed, 12 Jul 2023 11:39:41 -0400
Message-Id: <20230712153949.6894-15-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We add an initial set of kfuncs to allow interactions from eBPF programs
to the P4TC domain.

- bpf_skb_p4tc_tbl_read: Used to lookup a table entry from a BPF
program installed in TC. To find the table entry we take in an skb, the
pipeline ID, the table ID, a key and a key size.
We use the skb to get the network namespace structure where all the
pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

- bpf_xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
program installed in XDP. To find the table entry we take in an skb, the
pipeline ID, the table ID, a key and a key size.
We use struct xdp_md to get the network namespace structure where all
the pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

To load the eBPF program that uses the bpf_skb_p4tc_tbl_read kfunc into TC,
we issue the following command:

tc filter add dev $P0 ingress protocol any prio 1 p4 pname redirect_srcip \
     action bpf obj $PROGNAME.o section p4prog/tc

To load the eBPF program that uses the bpf_xdp_p4tc_tbl_read into XDP,
we first need to load it into XDP using, for example, the ip command:

ip link set $P0 xdp obj $PROGNAME.o section p4prog/xdp verbose

Then we pin it:

bpftool prog pin id $ID pin /tmp/

After that we create the P4 filter and reference the XDP program:

tc filter add dev $P0 ingress protocol any prio 1 p4 pname redirect_srcip \
     action bpf obj $PROGNAME.o section p4prog/tc

Note that we also specify a "prog_cookie", which is used to verify
whether the eBPF program has executed or not before we reach the P4
classifier. The eBPF program sets this cookie by using the kfunc
bpf_p4tc_set_cookie.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/bitops.h          |   1 +
 include/net/p4tc.h              |  42 ++++++++++-
 net/sched/Kconfig               |   1 +
 net/sched/p4tc/Makefile         |   2 +-
 net/sched/p4tc/p4tc_action.c    |   1 +
 net/sched/p4tc/p4tc_bpf.c       | 121 ++++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c  |  43 ++++++++++++
 net/sched/p4tc/p4tc_table.c     |  19 +++++
 net/sched/p4tc/p4tc_tbl_entry.c |  66 ++++++++++++++++-
 net/sched/p4tc/p4tc_tmpl_api.c  |   2 +
 10 files changed, 295 insertions(+), 3 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_bpf.c

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e06..290c2399a 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -19,6 +19,7 @@
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_U16(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u16))
 #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index ca2df3530..02583371e 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -91,8 +91,26 @@ struct p4tc_pipeline {
 	refcount_t                  p_hdrs_used;
 };
 
+#define P4TC_PIPELINE_MAX_ARRAY 32
+
+struct p4tc_table;
+
+struct p4tc_tbl_cache_key {
+	u32 pipeid;
+	u32 tblid;
+};
+
+extern const struct rhashtable_params tbl_cache_ht_params;
+
+int p4tc_tbl_cache_insert(struct net *net, u32 pipeid, struct p4tc_table *table);
+void p4tc_tbl_cache_remove(struct net *net, struct p4tc_table *table);
+struct p4tc_table *p4tc_tbl_cache_lookup(struct net *net, u32 pipeid, u32 tblid);
+
+#define P4TC_TBLS_CACHE_SIZE 32
+
 struct p4tc_pipeline_net {
-	struct idr pipeline_idr;
+	struct list_head  tbls_cache[P4TC_TBLS_CACHE_SIZE];
+	struct idr        pipeline_idr;
 };
 
 int tcf_p4_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
@@ -147,8 +165,14 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 
 #define P4TC_MAX_PARAM_DATA_SIZE 124
 
+struct p4tc_table_entry_act_bpf {
+	u32 act_id;
+	u8 params[P4TC_MAX_PARAM_DATA_SIZE];
+} __packed;
+
 struct p4tc_table_defact {
 	struct tc_action **default_acts;
+	struct p4tc_table_entry_act_bpf *defact_bpf;
 	/* Will have 2 5 bits blocks containing CRUDX (Create, read, update,
 	 * delete, execute) permissions for control plane and data plane.
 	 * The first 5 bits are for control and the next five are for data plane.
@@ -165,6 +189,7 @@ struct p4tc_table_perm {
 
 struct p4tc_table {
 	struct p4tc_template_common         common;
+	struct list_head                    tbl_cache_node;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
 	struct ida                          tbl_prio_idr;
@@ -241,6 +266,11 @@ extern const struct p4tc_template_ops p4tc_act_ops;
 
 extern const struct rhashtable_params entry_hlt_params;
 
+struct p4tc_table_entry_act_bpf_params {
+	u32 pipeid;
+	u32 tblid;
+};
+
 struct p4tc_table_entry;
 struct p4tc_table_entry_work {
 	struct work_struct   work;
@@ -259,6 +289,7 @@ struct p4tc_table_entry_value {
 	u32                              prio;
 	int                              num_acts;
 	struct tc_action                 **acts;
+	struct p4tc_table_entry_act_bpf  *act_bpf;
 	refcount_t                       entries_ref;
 	u32                              permissions;
 	struct p4tc_table_entry_tm __rcu *tm;
@@ -299,10 +330,19 @@ p4tc_table_entry_work(struct p4tc_table_entry *entry)
 extern const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1];
 extern const struct nla_policy p4tc_policy[P4TC_MAX + 1];
 
+struct p4tc_table_entry *
+p4tc_table_entry_lookup_direct(struct p4tc_table *table,
+			       struct p4tc_table_entry_key *key);
+
+
 int __tcf_table_entry_del(struct p4tc_pipeline *pipeline,
 			  struct p4tc_table *table,
 			  struct p4tc_table_entry_key *key,
 			  struct p4tc_table_entry_mask *mask, u32 prio);
+struct p4tc_table_entry_act_bpf *
+tcf_table_entry_create_act_bpf(struct tc_action *action,
+			       struct netlink_ext_ack *extack);
+int register_p4tc_tbl_bpf(void);
 
 struct p4tc_parser {
 	char parser_name[PARSERNAMSIZ];
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index ea57a4c7b..d071f9075 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -678,6 +678,7 @@ config NET_EMATCH_IPT
 
 config NET_P4_TC
 	bool "P4 TC support"
+	depends on DEBUG_INFO_BTF
 	select NET_CLS_ACT
 	help
 	  Say Y here if you want to use P4 features on top of TC.
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index c9e2555a8..161a515ad 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -2,4 +2,4 @@
 
 obj-y := p4tc_types.o p4tc_pipeline.o p4tc_tmpl_api.o \
 	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o p4tc_table.o \
-	p4tc_tbl_entry.o p4tc_runtime_api.o
+	p4tc_tbl_entry.o p4tc_runtime_api.o p4tc_bpf.o
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
index f9e9a04b0..c1309bd4f 100644
--- a/net/sched/p4tc/p4tc_action.c
+++ b/net/sched/p4tc/p4tc_action.c
@@ -28,6 +28,7 @@
 #include <net/p4tc.h>
 #include <net/sch_generic.h>
 #include <net/sock.h>
+
 #include <net/tc_act/p4tc.h>
 
 static LIST_HEAD(dynact_list);
diff --git a/net/sched/p4tc/p4tc_bpf.c b/net/sched/p4tc/p4tc_bpf.c
new file mode 100644
index 000000000..26f1ecb57
--- /dev/null
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/filter.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/btf_ids.h>
+#include <linux/net_namespace.h>
+#include <net/p4tc.h>
+#include <linux/netdevice.h>
+#include <net/sock.h>
+#include <linux/filter.h>
+
+BTF_ID_LIST(btf_p4tc_ids)
+BTF_ID(struct, p4tc_table_entry_act_bpf)
+BTF_ID(struct, p4tc_table_entry_act_bpf_params)
+
+#define ENTRY_KEY_OFFSET (offsetof(struct p4tc_table_entry_key, fa_key))
+
+struct p4tc_table_entry_act_bpf *
+__bpf_p4tc_tbl_read(struct net *caller_net,
+		    struct p4tc_table_entry_act_bpf_params *params,
+		    void *key, const u32 key__sz)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	struct p4tc_table_entry_value *value;
+	const u32 pipeid = params->pipeid;
+	const u32 tblid = params->tblid;
+	struct p4tc_table_entry *entry;
+	struct p4tc_table *table;
+
+	entry_key->keysz = (key__sz - ENTRY_KEY_OFFSET) << 3;
+
+	table = p4tc_tbl_cache_lookup(caller_net, pipeid, tblid);
+	if (!table)
+		return NULL;
+
+	entry = p4tc_table_entry_lookup_direct(table, entry_key);
+	if (!entry) {
+		struct p4tc_table_defact *defact;
+
+		defact = rcu_dereference(table->tbl_default_missact);
+		return defact ? defact->defact_bpf : NULL;
+	}
+
+	value = p4tc_table_entry_value(entry);
+
+	return value->act_bpf;
+}
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc struct p4tc_table_entry_act_bpf *
+bpf_skb_p4tc_tbl_read(struct __sk_buff *skb_ctx,
+		      struct p4tc_table_entry_act_bpf_params *params,
+		      void *key, const u32 key__sz)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *caller_net;
+
+	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+}
+
+__bpf_kfunc struct p4tc_table_entry_act_bpf *
+bpf_xdp_p4tc_tbl_read(struct xdp_md *xdp_ctx,
+		      struct p4tc_table_entry_act_bpf_params *params,
+		      void *key, const u32 key__sz)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *caller_net;
+
+	caller_net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+}
+
+__diag_pop();
+
+BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
+BTF_ID_FLAGS(func, bpf_skb_p4tc_tbl_read, KF_RET_NULL);
+BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_skb = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_tbl_set_skb,
+};
+
+BTF_SET8_START(p4tc_kfunc_check_tbl_set_xdp)
+BTF_ID_FLAGS(func, bpf_xdp_p4tc_tbl_read, KF_RET_NULL);
+BTF_SET8_END(p4tc_kfunc_check_tbl_set_xdp)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_xdp = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_tbl_set_xdp,
+};
+
+int register_p4tc_tbl_bpf(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+					&p4tc_kfunc_tbl_set_skb);
+	if (ret < 0)
+		return ret;
+
+	/* There is no unregister_btf_kfunc_id_set function */
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					 &p4tc_kfunc_tbl_set_xdp);
+}
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 464b150e0..5db17f933 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -37,6 +37,44 @@ static __net_init int pipeline_init_net(struct net *net)
 
 	idr_init(&pipe_net->pipeline_idr);
 
+	for (int i = 0; i < P4TC_TBLS_CACHE_SIZE; i++)
+		INIT_LIST_HEAD(&pipe_net->tbls_cache[i]);
+
+	return 0;
+}
+
+static inline size_t p4tc_tbl_cache_hash(u32 pipeid, u32 tblid)
+{
+	return (pipeid + tblid) % P4TC_TBLS_CACHE_SIZE;
+}
+
+struct p4tc_table *p4tc_tbl_cache_lookup(struct net *net, u32 pipeid, u32 tblid)
+{
+	size_t hash = p4tc_tbl_cache_hash(pipeid, tblid);
+	struct p4tc_pipeline_net *pipe_net;
+	struct p4tc_table *pos, *tmp;
+	struct net_generic *ng;
+
+	/* RCU read lock is already being held */
+	ng = rcu_dereference(net->gen);
+	pipe_net = ng->ptr[pipeline_net_id];
+
+	list_for_each_entry_safe(pos, tmp, &pipe_net->tbls_cache[hash],
+				 tbl_cache_node) {
+		if (pos->common.p_id == pipeid && pos->tbl_id == tblid)
+			return pos;
+	}
+
+	return NULL;
+}
+
+int p4tc_tbl_cache_insert(struct net *net, u32 pipeid, struct p4tc_table *table)
+{
+	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
+	size_t hash = p4tc_tbl_cache_hash(pipeid, table->tbl_id);
+
+	list_add_tail(&table->tbl_cache_node, &pipe_net->tbls_cache[hash]);
+
 	return 0;
 }
 
@@ -44,6 +82,11 @@ static int __tcf_pipeline_put(struct p4tc_pipeline *pipeline,
 			      struct p4tc_template_common *template,
 			      struct netlink_ext_ack *extack);
 
+void p4tc_tbl_cache_remove(struct net *net, struct p4tc_table *table)
+{
+	list_del(&table->tbl_cache_node);
+}
+
 static void __net_exit pipeline_exit_net(struct net *net)
 {
 	struct p4tc_pipeline_net *pipe_net;
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index 78c78c842..1d15af5ef 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -244,6 +244,7 @@ static inline void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
 {
 	if (defact) {
 		p4tc_action_destroy(defact->default_acts);
+		kfree(defact->defact_bpf);
 		kfree(defact);
 	}
 }
@@ -341,6 +342,7 @@ static inline int _tcf_table_put(struct net *net, struct nlattr **tb,
 
 	rhltable_free_and_destroy(&table->tbl_entries,
 				  tcf_table_entry_destroy_hash, table);
+	p4tc_tbl_cache_remove(net, table);
 
 	idr_destroy(&table->tbl_masks_idr);
 	ida_destroy(&table->tbl_prio_idr);
@@ -478,6 +480,7 @@ static int tcf_table_init_default_act(struct net *net, struct nlattr **tb,
 	}
 
 	if (tb[P4TC_TABLE_DEFAULT_ACTION]) {
+		struct p4tc_table_entry_act_bpf *act_bpf;
 		struct tc_action **default_acts;
 
 		if (!p4tc_ctrl_update_ok(curr_permissions)) {
@@ -506,6 +509,15 @@ static int tcf_table_init_default_act(struct net *net, struct nlattr **tb,
 			ret = -EINVAL;
 			goto default_act_free;
 		}
+		act_bpf = tcf_table_entry_create_act_bpf(default_acts[0],
+							 extack);
+		if (IS_ERR(act_bpf)) {
+			tcf_action_destroy(default_acts, TCA_ACT_UNBIND);
+			kfree(default_acts);
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		(*default_act)->defact_bpf = act_bpf;
 		(*default_act)->default_acts = default_acts;
 	}
 
@@ -955,6 +967,10 @@ static struct p4tc_table *tcf_table_create(struct net *net, struct nlattr **tb,
 		goto defaultacts_destroy;
 	}
 
+	ret = p4tc_tbl_cache_insert(net, pipeline->common.p_id, table);
+	if (ret < 0)
+		goto entries_hashtable_destroy;
+
 	pipeline->curr_tables += 1;
 
 	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
@@ -962,6 +978,9 @@ static struct p4tc_table *tcf_table_create(struct net *net, struct nlattr **tb,
 
 	return table;
 
+entries_hashtable_destroy:
+	rhltable_destroy(&table->tbl_entries);
+
 defaultacts_destroy:
 	p4tc_table_defact_destroy(table->tbl_default_missact);
 	p4tc_table_defact_destroy(table->tbl_default_hitact);
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index 5b6ef1efd..4bb96e44f 100644
--- a/net/sched/p4tc/p4tc_tbl_entry.c
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -586,6 +586,7 @@ static void tcf_table_entry_put(struct p4tc_table_entry *entry, bool deferred)
 	kfree(tm);
 
 	if (value->acts) {
+		kfree(value->act_bpf);
 		if (deferred) {
 			/* We have to free tc actions
 			 * in a sleepable context
@@ -1329,6 +1330,56 @@ static bool tcf_table_check_entry_acts(struct p4tc_table *table,
 	return false;
 }
 
+struct p4tc_table_entry_act_bpf *
+tcf_table_entry_create_act_bpf(struct tc_action *action,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *params[P4TC_MSGBATCH_SIZE];
+	struct p4tc_table_entry_act_bpf *act_bpf;
+	struct tcf_p4act_params *act_params;
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+	size_t tot_params_sz = 0;
+	struct tcf_p4act *p4act;
+	int num_params = 0;
+	u8 *params_cursor;
+	int i;
+
+	p4act = to_p4act(action);
+
+	act_params = rcu_dereference(p4act->params);
+
+	idr_for_each_entry_ul(&act_params->params_idr, param, tmp, param_id) {
+		const struct p4tc_type *type = param->type;
+
+		if (tot_params_sz > P4TC_MAX_PARAM_DATA_SIZE) {
+			NL_SET_ERR_MSG(extack, "Maximum parameter byte size reached");
+			return ERR_PTR(-EINVAL);
+		}
+
+		tot_params_sz += BITS_TO_BYTES(type->container_bitsz);
+		params[num_params] = param;
+		num_params++;
+	}
+
+	act_bpf = kzalloc(sizeof(*act_bpf), GFP_KERNEL);
+	if (!act_bpf)
+		return ERR_PTR(-ENOMEM);
+
+	act_bpf->act_id = p4act->act_id;
+	params_cursor = (u8 *)act_bpf + sizeof(act_bpf->act_id);
+	for (i = 0; i < num_params; i++) {
+		const struct p4tc_act_param *param = params[i];
+		const struct p4tc_type *type = param->type;
+		const u32 type_bytesz = BITS_TO_BYTES(type->container_bitsz);
+
+		memcpy(params_cursor, param->value, type_bytesz);
+		params_cursor += type_bytesz;
+	}
+
+	return act_bpf;
+}
+
 static struct p4tc_table_entry *
 __tcf_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
 		     struct p4tc_pipeline *pipeline, struct p4tc_table *table,
@@ -1443,6 +1494,8 @@ __tcf_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
 	}
 
 	if (tb[P4TC_ENTRY_ACT]) {
+		struct p4tc_table_entry_act_bpf *act_bpf;
+
 		value->acts = kcalloc(TCA_ACT_MAX_PRIO,
 				      sizeof(struct tc_action *), GFP_KERNEL);
 		if (unlikely(!value->acts)) {
@@ -1468,6 +1521,14 @@ __tcf_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
 				       "Action is not allowed as entry action");
 			goto free_acts;
 		}
+
+		act_bpf = tcf_table_entry_create_act_bpf(value->acts[0],
+							 extack);
+		if (IS_ERR(act_bpf)) {
+			ret = PTR_ERR(act_bpf);
+			goto free_acts;
+		}
+		value->act_bpf = act_bpf;
 	}
 
 	rcu_read_lock();
@@ -1479,12 +1540,15 @@ __tcf_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
 					       whodunnit, true);
 	if (ret < 0) {
 		rcu_read_unlock();
-		goto free_acts;
+		goto free_act_bpf;
 	}
 	rcu_read_unlock();
 
 	return entry;
 
+free_act_bpf:
+	kfree(value->act_bpf);
+
 free_acts:
 	p4tc_action_destroy(value->acts);
 
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index faf312509..ff3f4bbaa 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -592,6 +592,8 @@ static int __init p4tc_template_init(void)
 			op->init();
 	}
 
+	register_p4tc_tbl_bpf();
+
 	return 0;
 }
 
-- 
2.34.1


