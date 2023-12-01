Return-Path: <bpf+bounces-16425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C227F8012BD
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75643281A7C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5338056476;
	Fri,  1 Dec 2023 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nj/GNavm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443C0133
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:29:31 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a8edae551so8040866d6.2
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455370; x=1702060170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCccx9iwuxXme0mgLZFBNuU2zWsbh779uS1mIH9qRKM=;
        b=nj/GNavmicSdXJ2N+oi5Ndvs3Z/ZdzRVd2FM8yjNIJPf83yp5/rG2Fb8dlEBADJzCL
         3JGdjCWZ28GFudK82VTcyKzVgR+USjYcvyXmRoZxAkSiSYBVT/pB0s2bTBuReo39U8ZT
         wH2Qy2sDWttFKKn+idWUtSbOy2IR0GfPTaazrtFBkIcYjJRWhTtM7BqcISAI4IRqufGd
         IdEFXhkvp37C7LMTumO5sK45nYXZQy7wROazeq0+RuLHQIYegAASm6RQmAnlj6q7bOuc
         wIXZpylpsFSS7Itkc7imdRWIdQh7Xjz7M+Vbp2RK68pYsBkiOPsvN9sfykd+z3wYBxEx
         uYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455370; x=1702060170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCccx9iwuxXme0mgLZFBNuU2zWsbh779uS1mIH9qRKM=;
        b=mBMa9cvAogUYRhKjFJ0L8njWibAtTXn8K0//kSRIKjAlxp34SXiQMVJVaCkEJTdcD2
         ClsCNJfu7wO8jESgl1SuRpxuEkx+vsoK00aq8Vfd702gj4A+UNhZtlYdZsWyBXjIjLF/
         xh+rFTP22stv1dKRK2WKBwn/DyhQpO2x3DcbB+jzp1b7A3ezltwFGNUO0YkcyNfWZjWQ
         qpKK8BSJXS/j6NMI3bNpFiLOp9T8949qCKdgVLWRxaHGq0tx+az/HXN739cMn0UjWMcV
         JqfOjONiEjTAAbtYiOn3FrngiaaS507ipNdMUVSNY3SKjNc69o66qwSfkBjZOkHhoz5u
         xu3w==
X-Gm-Message-State: AOJu0YzR7UqSy9cUHXtk9QDAEgd1HD5yyDm68j5EzD2vxGkMlH9umASo
	lNsTgtXHNYIOYqkJAKzCTapigg==
X-Google-Smtp-Source: AGHT+IHax+STQwHk68dfnLA/vqTOR6gimovY1eazO7+0EW/cJiC0aDEYVITUK2WIc/nY7x1NFGqwhw==
X-Received: by 2002:a0c:fa90:0:b0:67a:8ff2:34dc with SMTP id o16-20020a0cfa90000000b0067a8ff234dcmr4858685qvn.3.1701455370093;
        Fri, 01 Dec 2023 10:29:30 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:29 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH net-next v9 14/15] p4tc: add set of P4TC table kfuncs
Date: Fri,  1 Dec 2023 13:29:03 -0500
Message-Id: <20231201182904.532825-15-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201182904.532825-1-jhs@mojatatu.com>
References: <20231201182904.532825-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We add an initial set of kfuncs to allow interactions from eBPF programs
to the P4TC domain.

- bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
program installed in TC. To find the table entry we take in an skb, the
pipeline ID, the table ID, a key and a key size.
We use the skb to get the network namespace structure where all the
pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

- xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
program installed in XDP. To find the table entry we take in an xdp_md,
the pipeline ID, the table ID, a key and a key size.
We use struct xdp_md to get the network namespace structure where all
the pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

- bpf_p4tc_entry_create: Used to create a table entry from a BPF
program installed in TC. To create the table entry we take an skb, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- xdp_p4tc_entry_create: Used to create a table entry from a BPF
program installed in XDP. To create the table entry we take an xdp_md, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
First does a lookup using the passed key and upon a miss will add the entry
to the table.
We return 0 on success and a negative errno on failure

- xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
First does a lookup using the passed key and upon a miss will add the entry
to the table.
We return 0 on success and a negative errno on failure

- bpf_p4tc_entry_update: Used to update a table entry from a BPF
program installed in TC. To update the table entry we take an skb, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- xdp_p4tc_entry_update: Used to update a table entry from a BPF
program installed in XDP. To update the table entry we take an xdp_md, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
program installed in TC. To delete the table entry we take an skb, the
pipeline ID, the table ID, a key and a key size.
We return 0 on success and a negative errno on failure

- xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
program installed in XDP. To delete the table entry we take an xdp_md, the
pipeline ID, the table ID, a key and a key size.
We return 0 on success and a negative errno on failure

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/bitops.h          |   1 +
 include/net/p4tc.h              |  60 +++++-
 include/net/tc_act/p4tc.h       |  24 +++
 include/uapi/linux/p4tc.h       |   2 +
 net/sched/p4tc/Makefile         |   1 +
 net/sched/p4tc/p4tc_action.c    |  70 ++++++-
 net/sched/p4tc/p4tc_bpf.c       | 338 ++++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c  |  47 ++++-
 net/sched/p4tc/p4tc_table.c     |   8 +
 net/sched/p4tc/p4tc_tbl_entry.c | 301 +++++++++++++++++++++++++++-
 net/sched/p4tc/p4tc_tmpl_api.c  |   4 +
 11 files changed, 843 insertions(+), 13 deletions(-)
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
index d600e8655..3557e3b8b 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -91,8 +91,28 @@ struct p4tc_pipeline {
 	u8                          p_state;
 };
 
+#define P4TC_PIPELINE_MAX_ARRAY 32
+
+struct p4tc_tbl_cache_key {
+	u32 pipeid;
+	u32 tblid;
+};
+
+extern const struct rhashtable_params tbl_cache_ht_params;
+
+struct p4tc_table;
+
+int p4tc_tbl_cache_insert(struct net *net, u32 pipeid,
+			  struct p4tc_table *table);
+void p4tc_tbl_cache_remove(struct net *net, struct p4tc_table *table);
+struct p4tc_table *p4tc_tbl_cache_lookup(struct net *net, u32 pipeid,
+					 u32 tblid);
+
+#define P4TC_TBLS_CACHE_SIZE 32
+
 struct p4tc_pipeline_net {
-	struct idr pipeline_idr;
+	struct list_head  tbls_cache[P4TC_TBLS_CACHE_SIZE];
+	struct idr        pipeline_idr;
 };
 
 static inline bool p4tc_tmpl_msg_is_update(struct nlmsghdr *n)
@@ -220,6 +240,7 @@ struct p4tc_table_perm {
 
 struct p4tc_table {
 	struct p4tc_template_common         common;
+	struct list_head                    tbl_cache_node;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
 	struct ida                          tbl_prio_idr;
@@ -314,6 +335,17 @@ extern const struct p4tc_template_ops p4tc_act_ops;
 
 extern const struct rhashtable_params entry_hlt_params;
 
+struct p4tc_table_entry_act_bpf_params {
+	u32 pipeid;
+	u32 tblid;
+};
+
+struct p4tc_table_entry_create_bpf_params {
+	u64 aging_ms;
+	u32 pipeid;
+	u32 tblid;
+};
+
 struct p4tc_table_entry;
 struct p4tc_table_entry_work {
 	struct work_struct   work;
@@ -364,6 +396,13 @@ struct p4tc_table_entry {
 	/* fallthrough: key data + value */
 };
 
+struct p4tc_entry_key_bpf {
+	void *key;
+	void *mask;
+	u32 key_sz;
+	u32 mask_sz;
+};
+
 #define P4TC_KEYSZ_BYTES(bits) (round_up(BITS_TO_BYTES(bits), 8))
 
 #define P4TC_ENTRY_KEY_OFFSET (offsetof(struct p4tc_table_entry_key, fa_key))
@@ -392,6 +431,25 @@ struct p4tc_table_entry *
 p4tc_table_entry_lookup_direct(struct p4tc_table *table,
 			       struct p4tc_table_entry_key *key);
 
+struct p4tc_table_entry_act_bpf *
+p4tc_table_entry_create_act_bpf(struct tc_action *action,
+				struct netlink_ext_ack *extack);
+int register_p4tc_tbl_bpf(void);
+int p4tc_table_entry_create_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u64 aging_ms);
+int p4tc_table_entry_update_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u64 aging_ms);
+
+int p4tc_table_entry_del_bpf(struct p4tc_pipeline *pipeline,
+			     struct p4tc_table *table,
+			     struct p4tc_table_entry_key *key);
+
 static inline int p4tc_action_init(struct net *net, struct nlattr *nla,
 				   struct tc_action *acts[], u32 pipeid,
 				   u32 flags, struct netlink_ext_ack *extack)
diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
index 6447fe5ce..ca925d112 100644
--- a/include/net/tc_act/p4tc.h
+++ b/include/net/tc_act/p4tc.h
@@ -14,10 +14,23 @@ struct tcf_p4act_params {
 	u32 tot_params_sz;
 };
 
+#define P4TC_MAX_PARAM_DATA_SIZE 124
+
+struct p4tc_table_entry_act_bpf {
+	u32 act_id;
+	u8 params[P4TC_MAX_PARAM_DATA_SIZE];
+} __packed;
+
+struct p4tc_table_entry_act_bpf_kern {
+	struct rcu_head rcu;
+	struct p4tc_table_entry_act_bpf act_bpf;
+};
+
 struct tcf_p4act {
 	struct tc_action common;
 	/* Params IDR reference passed during runtime */
 	struct tcf_p4act_params __rcu *params;
+	struct p4tc_table_entry_act_bpf_kern __rcu *act_bpf;
 	u32 p_id;
 	u32 act_id;
 	struct list_head node;
@@ -25,4 +38,15 @@ struct tcf_p4act {
 
 #define to_p4act(a) ((struct tcf_p4act *)a)
 
+static inline struct p4tc_table_entry_act_bpf *
+p4tc_table_entry_act_bpf(struct tc_action *action)
+{
+	struct p4tc_table_entry_act_bpf_kern *act_bpf;
+	struct tcf_p4act *p4act = to_p4act(action);
+
+	act_bpf = rcu_dereference(p4act->act_bpf);
+
+	return &act_bpf->act_bpf;
+}
+
 #endif /* __NET_TC_ACT_P4_H */
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 55fc660c9..8815e6422 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -19,6 +19,8 @@ struct p4tcmsg {
 #define P4TC_MINTABLES_COUNT 0
 #define P4TC_MSGBATCH_SIZE 16
 
+#define P4TC_ACT_MAX_NUM_PARAMS P4TC_MSGBATCH_SIZE
+
 #define P4TC_MAX_KEYSZ 512
 #define P4TC_DEFAULT_NUM_PREALLOC 16
 
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 921909ac4..3fed9a853 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -3,3 +3,4 @@
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
 	p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
 	p4tc_runtime_api.o
+obj-$(CONFIG_DEBUG_INFO_BTF) += p4tc_bpf.o
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
index ac35874b6..bd51b07ce 100644
--- a/net/sched/p4tc/p4tc_action.c
+++ b/net/sched/p4tc/p4tc_action.c
@@ -270,29 +270,84 @@ static void p4a_runt_parms_destroy_rcu(struct rcu_head *head)
 	p4a_runt_parms_destroy(params);
 }
 
+static struct p4tc_table_entry_act_bpf_kern *
+p4a_runt_create_bpf(struct tcf_p4act *p4act,
+		    struct tcf_p4act_params *act_params,
+		    struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *params[P4TC_ACT_MAX_NUM_PARAMS];
+	struct p4tc_table_entry_act_bpf_kern *act_bpf;
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+	size_t tot_params_sz = 0;
+	u8 *params_cursor;
+	int nparams = 0;
+	int i;
+
+	act_bpf = kzalloc(sizeof(*act_bpf), GFP_KERNEL);
+	if (!act_bpf)
+		return ERR_PTR(-ENOMEM);
+
+	idr_for_each_entry_ul(&act_params->params_idr, param, tmp, param_id) {
+		const struct p4tc_type *type = param->type;
+
+		if (tot_params_sz > P4TC_MAX_PARAM_DATA_SIZE) {
+			NL_SET_ERR_MSG(extack,
+				       "Maximum parameter byte size reached");
+			kfree(act_bpf);
+			return ERR_PTR(-EINVAL);
+		}
+
+		tot_params_sz += BITS_TO_BYTES(type->container_bitsz);
+		params[nparams++] = param;
+	}
+
+	act_bpf->act_bpf.act_id = p4act->act_id;
+	params_cursor = act_bpf->act_bpf.params;
+	for (i = 0; i < nparams; i++) {
+		u32 type_bytesz;
+
+		param = params[i];
+		type_bytesz =  BITS_TO_BYTES(param->type->container_bitsz);
+		memcpy(params_cursor, param->value, type_bytesz);
+		params_cursor += type_bytesz;
+	}
+
+	return act_bpf;
+}
+
 static int __p4a_runt_init_set(struct p4tc_act *act, struct tc_action **a,
 			       struct tcf_p4act_params *params,
 			       struct tcf_chain *goto_ch,
 			       struct tc_act_p4 *parm, bool exists,
 			       struct netlink_ext_ack *extack)
 {
+	struct p4tc_table_entry_act_bpf_kern *act_bpf = NULL, *act_bpf_old;
 	struct tcf_p4act_params *params_old;
 	struct tcf_p4act *p;
 
 	p = to_p4act(*a);
 
+	if (!((*a)->tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED)) {
+		act_bpf = p4a_runt_create_bpf(p, params, extack);
+		if (IS_ERR(act_bpf))
+			return PTR_ERR(act_bpf);
+	}
+
 	/* sparse is fooled by lock under conditionals.
-	 * To avoid false positives, we are repeating these two lines in both
+	 * To avoid false positives, we are repeating these 3 lines in both
 	 * branches of the if-statement
 	 */
 	if (exists) {
 		spin_lock_bh(&p->tcf_lock);
 		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 		params_old = rcu_replace_pointer(p->params, params, 1);
+		act_bpf_old = rcu_replace_pointer(p->act_bpf, act_bpf, 1);
 		spin_unlock_bh(&p->tcf_lock);
 	} else {
 		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 		params_old = rcu_replace_pointer(p->params, params, 1);
+		act_bpf_old = rcu_replace_pointer(p->act_bpf, act_bpf, 1);
 	}
 
 	if (goto_ch)
@@ -301,6 +356,9 @@ static int __p4a_runt_init_set(struct p4tc_act *act, struct tc_action **a,
 	if (params_old)
 		call_rcu(&params_old->rcu, p4a_runt_parms_destroy_rcu);
 
+	if (act_bpf_old)
+		kfree_rcu(act_bpf_old, rcu);
+
 	return 0;
 }
 
@@ -493,6 +551,7 @@ void p4a_runt_init_flags(struct tcf_p4act *p4act)
 static void __p4a_runt_prealloc_put(struct p4tc_act *act,
 				    struct tcf_p4act *p4act)
 {
+	struct p4tc_table_entry_act_bpf_kern *act_bpf_old;
 	struct tcf_p4act_params *p4act_params;
 	struct p4tc_act_param *param;
 	unsigned long param_id, tmp;
@@ -511,6 +570,10 @@ static void __p4a_runt_prealloc_put(struct p4tc_act *act,
 	p4act->common.tcfa_flags |= TCA_ACT_FLAGS_UNREFERENCED;
 	spin_unlock_bh(&p4act->tcf_lock);
 
+	act_bpf_old = rcu_replace_pointer(p4act->act_bpf, NULL, 1);
+	if (act_bpf_old)
+		kfree_rcu(act_bpf_old, rcu);
+
 	spin_lock_bh(&act->list_lock);
 	list_add_tail(&p4act->node, &act->prealloc_list);
 	spin_unlock_bh(&act->list_lock);
@@ -1147,16 +1210,21 @@ static int p4a_runt_walker(struct net *net, struct sk_buff *skb,
 static void p4a_runt_cleanup(struct tc_action *a)
 {
 	struct tc_action_ops *ops = (struct tc_action_ops *)a->ops;
+	struct p4tc_table_entry_act_bpf_kern *act_bpf;
 	struct tcf_p4act *m = to_p4act(a);
 	struct tcf_p4act_params *params;
 
 	params = rcu_dereference_protected(m->params, 1);
+	act_bpf = rcu_dereference_protected(m->act_bpf, 1);
 
 	if (refcount_read(&ops->p4_ref) > 1)
 		refcount_dec(&ops->p4_ref);
 
 	if (params)
 		call_rcu(&params->rcu, p4a_runt_parms_destroy_rcu);
+
+	if (act_bpf)
+		kfree_rcu(act_bpf, rcu);
 }
 
 static void p4a_runt_net_exit(struct tc_action_net *tn)
diff --git a/net/sched/p4tc/p4tc_bpf.c b/net/sched/p4tc/p4tc_bpf.c
new file mode 100644
index 000000000..ba479f111
--- /dev/null
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/filter.h>
+#include <linux/btf_ids.h>
+#include <linux/net_namespace.h>
+#include <net/p4tc.h>
+#include <linux/netdevice.h>
+#include <net/sock.h>
+#include <net/xdp.h>
+
+BTF_ID_LIST(btf_p4tc_ids)
+BTF_ID(struct, p4tc_table_entry_act_bpf)
+BTF_ID(struct, p4tc_table_entry_act_bpf_params)
+BTF_ID(struct, p4tc_table_entry_act_bpf)
+BTF_ID(struct, p4tc_table_entry_create_bpf_params)
+
+static struct p4tc_table_entry_act_bpf no_action_bpf = {};
+
+static struct p4tc_table_entry_act_bpf *
+__bpf_p4tc_tbl_read(struct net *caller_net,
+		    struct p4tc_table_entry_act_bpf_params *params,
+		    void *key, const u32 key__sz)
+{
+	struct p4tc_table_entry_key *entry_key = key;
+	struct p4tc_table_defact *defact_hit;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry *entry;
+	struct p4tc_table *table;
+	u32 pipeid;
+	u32 tblid;
+
+	if (!params || !key)
+		return NULL;
+
+	if (key__sz <= P4TC_ENTRY_KEY_OFFSET)
+		return NULL;
+
+	pipeid = params->pipeid;
+	tblid = params->tblid;
+
+	entry_key->keysz = (key__sz - P4TC_ENTRY_KEY_OFFSET) << 3;
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
+		return defact ?
+			p4tc_table_entry_act_bpf(defact->default_acts[0]) : NULL;
+	}
+
+	value = p4tc_table_entry_value(entry);
+
+	if (value->acts)
+		return p4tc_table_entry_act_bpf(value->acts[0]);
+
+	defact_hit = rcu_dereference(table->tbl_default_hitact);
+	return defact_hit ?
+		p4tc_table_entry_act_bpf(defact_hit->default_acts[0]) :
+		&no_action_bpf;
+}
+
+__bpf_kfunc static struct p4tc_table_entry_act_bpf *
+bpf_p4tc_tbl_read(struct __sk_buff *skb_ctx,
+		  struct p4tc_table_entry_act_bpf_params *params,
+		  void *key, const u32 key__sz)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *caller_net;
+
+	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+}
+
+__bpf_kfunc static struct p4tc_table_entry_act_bpf *
+xdp_p4tc_tbl_read(struct xdp_md *xdp_ctx,
+		  struct p4tc_table_entry_act_bpf_params *params,
+		  void *key, const u32 key__sz)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *caller_net;
+
+	caller_net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+}
+
+static int
+__bpf_p4tc_entry_create(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			void *key, const u32 key__sz,
+			struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct p4tc_table_entry_key *entry_key = key;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	if (!params || !key)
+		return -EINVAL;
+
+	if (key__sz <= P4TC_ENTRY_KEY_OFFSET)
+		return -EINVAL;
+
+	pipeline = p4tc_pipeline_find_byid(net, params->pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
+	if (!table)
+		return -ENOENT;
+
+	entry_key->keysz = (key__sz - P4TC_ENTRY_KEY_OFFSET) << 3;
+
+	return p4tc_table_entry_create_bpf(pipeline, table, entry_key, act_bpf,
+					   params->aging_ms);
+}
+
+__bpf_kfunc static int
+bpf_p4tc_entry_create(struct __sk_buff *skb_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz,
+		      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
+}
+
+__bpf_kfunc static int
+xdp_p4tc_entry_create(struct xdp_md *xdp_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz,
+		      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
+}
+
+__bpf_kfunc static int
+bpf_p4tc_entry_create_on_miss(struct __sk_buff *skb_ctx,
+			      struct p4tc_table_entry_create_bpf_params *params,
+			      void *key, const u32 key__sz,
+			      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
+}
+
+__bpf_kfunc static int
+xdp_p4tc_entry_create_on_miss(struct xdp_md *xdp_ctx,
+			      struct p4tc_table_entry_create_bpf_params *params,
+			      void *key, const u32 key__sz,
+			      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf);
+}
+
+static int
+__bpf_p4tc_entry_update(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			void *key, const u32 key__sz,
+			struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct p4tc_table_entry_key *entry_key = key;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	if (!params || !key)
+		return -EINVAL;
+
+	if (key__sz <= P4TC_ENTRY_KEY_OFFSET)
+		return -EINVAL;
+
+	pipeline = p4tc_pipeline_find_byid(net, params->pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
+	if (!table)
+		return -ENOENT;
+
+	entry_key->keysz = (key__sz - P4TC_ENTRY_KEY_OFFSET) << 3;
+
+	return p4tc_table_entry_update_bpf(pipeline, table, entry_key,
+					  act_bpf, params->aging_ms);
+}
+
+__bpf_kfunc static int
+bpf_p4tc_entry_update(struct __sk_buff *skb_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz,
+		      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_update(net, params, key, key__sz, act_bpf);
+}
+
+__bpf_kfunc static int
+xdp_p4tc_entry_update(struct xdp_md *xdp_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz,
+		      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_update(net, params, key, key__sz, act_bpf);
+}
+
+static int
+__bpf_p4tc_entry_delete(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			void *key, const u32 key__sz)
+{
+	struct p4tc_table_entry_key *entry_key = key;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	if (!params || !key)
+		return -EINVAL;
+
+	if (key__sz <= P4TC_ENTRY_KEY_OFFSET)
+		return -EINVAL;
+
+	pipeline = p4tc_pipeline_find_byid(net, params->pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
+	if (!table)
+		return -ENOENT;
+
+	entry_key->keysz = (key__sz - P4TC_ENTRY_KEY_OFFSET) << 3;
+
+	return p4tc_table_entry_del_bpf(pipeline, table, entry_key);
+}
+
+__bpf_kfunc static int
+bpf_p4tc_entry_delete(struct __sk_buff *skb_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
+}
+
+__bpf_kfunc static int
+xdp_p4tc_entry_delete(struct xdp_md *xdp_ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      void *key, const u32 key__sz)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
+}
+
+BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
+BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
+BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_skb = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_tbl_set_skb,
+};
+
+BTF_SET8_START(p4tc_kfunc_check_tbl_set_xdp)
+BTF_ID_FLAGS(func, xdp_p4tc_tbl_read, KF_RET_NULL);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_create);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_create_on_miss);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_update);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_delete);
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
index f7ea1bcae..a617b8333 100644
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
+static size_t p4tc_tbl_cache_hash(u32 pipeid, u32 tblid)
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
 
@@ -44,6 +82,11 @@ static int __p4tc_pipeline_put(struct p4tc_pipeline *pipeline,
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
@@ -152,8 +195,8 @@ static int __p4tc_pipeline_put(struct p4tc_pipeline *pipeline,
 	return 0;
 }
 
-static inline int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
-					       struct netlink_ext_ack *extack)
+static int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
+					struct netlink_ext_ack *extack)
 {
 	int ret;
 
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index df3fd3eef..d3390034a 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -380,6 +380,7 @@ static int _p4tc_table_put(struct net *net, struct nlattr **tb,
 
 	rhltable_free_and_destroy(&table->tbl_entries,
 				  p4tc_table_entry_destroy_hash, table);
+	p4tc_tbl_cache_remove(net, table);
 
 	idr_destroy(&table->tbl_masks_idr);
 	ida_destroy(&table->tbl_prio_idr);
@@ -1143,6 +1144,10 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 		goto defaultacts_destroy;
 	}
 
+	ret = p4tc_tbl_cache_insert(net, pipeline->common.p_id, table);
+	if (ret < 0)
+		goto entries_hashtable_destroy;
+
 	pipeline->curr_tables += 1;
 
 	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
@@ -1150,6 +1155,9 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 
 	return table;
 
+entries_hashtable_destroy:
+	rhltable_destroy(&table->tbl_entries);
+
 defaultacts_destroy:
 	p4tc_table_defact_destroy(def_params.default_hitact);
 	p4tc_table_defact_destroy(def_params.default_missact);
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index ee1ecdf71..f4542d839 100644
--- a/net/sched/p4tc/p4tc_tbl_entry.c
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -275,7 +275,8 @@ static int p4tca_table_get_entry_keys(struct sk_buff *skb,
 			goto out_nlmsg_trim;
 
 		gen_exact_mask(mask_value, key_sz_bytes);
-		if (nla_put(skb, P4TC_ENTRY_MASK_BLOB, key_sz_bytes, mask_value))
+		if (nla_put(skb, P4TC_ENTRY_MASK_BLOB, key_sz_bytes,
+			    mask_value))
 			goto out_nlmsg_trim;
 	} else {
 		key_sz_bytes = BITS_TO_BYTES(entry->key.keysz);
@@ -431,7 +432,8 @@ p4tc_table_entry_mask_find_byvalue(struct p4tc_table *table,
 			void *curr_mask_value = mask_cur->fa_value;
 			void *mask_value = mask->fa_value;
 
-			if (memcmp(curr_mask_value, mask_value, mask_sz_bytes) == 0)
+			if (memcmp(curr_mask_value, mask_value,
+				   mask_sz_bytes) == 0)
 				return mask_cur;
 		}
 	}
@@ -559,7 +561,9 @@ static int p4tc_table_lpm_mask_insert(struct p4tc_table *table,
 				find_lpm_mask(table, mask_pos->fa_value);
 
 			if (mask_value > array_mask_value) {
-				/* shift masks to the right (will keep invariant) */
+				/* shift masks to the right (will keep
+				 * invariant).
+				 */
 				u32 tail = nmasks;
 
 				while (tail > pos + 1) {
@@ -941,7 +945,8 @@ static int p4tc_table_entry_get_table(struct net *net,
 	}
 
 	tbl_id = ids[P4TC_TBLID_IDX];
-	tblname = tb[P4TC_ENTRY_TBLNAME] ? nla_data(tb[P4TC_ENTRY_TBLNAME]) : NULL;
+	tblname = tb[P4TC_ENTRY_TBLNAME] ?
+		nla_data(tb[P4TC_ENTRY_TBLNAME]) : NULL;
 
 	*table = p4tc_table_find_get(*pipeline, tblname, tbl_id, extack);
 	if (IS_ERR(*table)) {
@@ -1064,6 +1069,44 @@ __must_hold(RCU)
 	return 0;
 }
 
+/* Internal function which will be called by the data path */
+static int __p4tc_table_entry_del(struct p4tc_pipeline *pipeline,
+				  struct p4tc_table *table,
+				  struct p4tc_table_entry_key *key,
+				  struct p4tc_table_entry_mask *mask, u32 prio)
+{
+	struct p4tc_table_entry *entry;
+	int ret;
+
+	p4tc_table_entry_build_key(table, key, mask);
+
+	entry = p4tc_entry_lookup(table, key, prio);
+	if (!entry)
+		return -ENOENT;
+
+	ret = ___p4tc_table_entry_del(pipeline, table, entry, false);
+
+	return ret;
+}
+
+int p4tc_table_entry_del_bpf(struct p4tc_pipeline *pipeline,
+			     struct p4tc_table *table,
+			     struct p4tc_table_entry_key *key)
+{
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	const u32 keysz_bytes = P4TC_KEYSZ_BYTES(table->tbl_keysz);
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		return -EINVAL;
+
+	if (keysz_bytes != P4TC_KEYSZ_BYTES(key->keysz))
+		return -EINVAL;
+
+	return __p4tc_table_entry_del(pipeline, table, key, mask, 0);
+}
+
 static int p4tc_table_entry_gd(struct net *net, struct sk_buff *skb, bool del,
 			       u16 *permissions, struct nlattr *arg,
 			       struct p4tc_path_nlattrs *nl_path_attrs,
@@ -1360,6 +1403,54 @@ static int p4tc_table_entry_flush(struct net *net, struct sk_buff *skb,
 	return ret;
 }
 
+static int
+p4tc_table_tc_act_from_bpf_act(struct tcf_p4act *p4act,
+			       struct p4tc_table_entry_value *value,
+			       struct p4tc_table_entry_act_bpf *act_bpf)
+__must_hold(RCU)
+{
+	struct p4tc_table_entry_act_bpf_kern *new_act_bpf;
+	struct tcf_p4act_params *p4act_params;
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+	u8 *params_cursor;
+	int err;
+
+	p4act_params = rcu_dereference(p4act->params);
+	/* Skip act_id */
+	params_cursor = (u8 *)act_bpf + sizeof(act_bpf->act_id);
+	idr_for_each_entry_ul(&p4act_params->params_idr, param, tmp, param_id) {
+		const struct p4tc_type *type = param->type;
+		const u32 type_bytesz = BITS_TO_BYTES(type->container_bitsz);
+
+		memcpy(param->value, params_cursor, type_bytesz);
+		params_cursor += type_bytesz;
+	}
+
+	new_act_bpf = kzalloc(sizeof(*new_act_bpf), GFP_ATOMIC);
+	if (unlikely(!new_act_bpf))
+		return -ENOMEM;
+
+	value->acts = kcalloc(TCA_ACT_MAX_PRIO, sizeof(struct tc_action *),
+			      GFP_ATOMIC);
+	if (unlikely(!value->acts)) {
+		err = -ENOMEM;
+		goto free_act_bpf;
+	}
+
+	new_act_bpf->act_bpf = *act_bpf;
+
+	rcu_assign_pointer(p4act->act_bpf, new_act_bpf);
+	value->num_acts = 1;
+	value->acts[0] = (struct tc_action *)p4act;
+
+	return 0;
+
+free_act_bpf:
+	kfree(new_act_bpf);
+	return err;
+}
+
 static enum hrtimer_restart entry_timer_handle(struct hrtimer *timer)
 {
 	struct p4tc_table_entry_value *value =
@@ -1521,6 +1612,116 @@ __must_hold(RCU)
 	return ret;
 }
 
+struct p4tc_table_entry_create_state {
+	struct p4tc_act *act;
+	struct tcf_p4act *p4_act;
+	struct p4tc_table_entry *entry;
+	u64 aging_ms;
+	u16 permissions;
+};
+
+static int
+p4tc_table_entry_init_bpf(struct p4tc_pipeline *pipeline,
+			  struct p4tc_table *table, u32 entry_key_sz,
+			  struct p4tc_table_entry_act_bpf *act_bpf,
+			  struct p4tc_table_entry_create_state *state)
+{
+	const u32 keysz_bytes = P4TC_KEYSZ_BYTES(table->tbl_keysz);
+	struct p4tc_table_entry_value *entry_value;
+	const u32 keysz_bits = table->tbl_keysz;
+	struct tcf_p4act *p4_act = NULL;
+	struct p4tc_table_entry *entry;
+	struct p4tc_act *act = NULL;
+	int err = -EINVAL;
+	u32 entrysz;
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		goto out;
+
+	if (keysz_bytes != P4TC_KEYSZ_BYTES(entry_key_sz))
+		goto out;
+
+	if (atomic_read(&table->tbl_nelems) + 1 > table->tbl_max_entries)
+		goto out;
+
+	if (act_bpf) {
+		act = p4a_tmpl_get(pipeline, NULL, act_bpf->act_id, NULL);
+		if (!act) {
+			err = -ENOENT;
+			goto out;
+		}
+	}
+
+	entrysz = sizeof(*entry) + keysz_bytes +
+		  sizeof(struct p4tc_table_entry_value);
+
+	entry = kzalloc(entrysz, GFP_ATOMIC);
+	if (unlikely(!entry)) {
+		err = -ENOMEM;
+		goto act_put;
+	}
+	entry->key.keysz = keysz_bits;
+
+	entry_value = p4tc_table_entry_value(entry);
+	entry_value->prio = p4tc_table_entry_exact_prio();
+	entry_value->permissions = state->permissions;
+	entry_value->aging_ms = state->aging_ms;
+
+	if (act) {
+		p4_act = p4a_runt_prealloc_get_next(act);
+		if (!p4_act) {
+			err = -ENOENT;
+			goto idr_rm;
+		}
+
+		err = p4tc_table_tc_act_from_bpf_act(p4_act, entry_value,
+						     act_bpf);
+		if (err < 0)
+			goto free_prealloc;
+	}
+
+	state->act = act;
+	state->p4_act = p4_act;
+	state->entry = entry;
+
+	return 0;
+
+free_prealloc:
+	if (p4_act)
+		p4a_runt_prealloc_put(act, p4_act);
+
+idr_rm:
+	p4tc_table_entry_free_prio(table, entry_value->prio);
+
+	kfree(entry);
+
+act_put:
+	if (act)
+		p4tc_action_put_ref(act);
+out:
+	return err;
+}
+
+static void
+p4tc_table_entry_create_state_put(struct p4tc_table *table,
+				  struct p4tc_table_entry_create_state *state)
+{
+	struct p4tc_table_entry_value *value;
+
+	if (state->act)
+		p4a_runt_prealloc_put(state->act, state->p4_act);
+
+	value = p4tc_table_entry_value(state->entry);
+	p4tc_table_entry_free_prio(table, value->prio);
+
+	kfree(value->acts);
+
+	kfree(state->entry);
+
+	if (state->act)
+		p4tc_action_put_ref(state->act);
+}
+
 /* Invoked from both control and data path  */
 static int __p4tc_table_entry_update(struct p4tc_pipeline *pipeline,
 				     struct p4tc_table *table,
@@ -1659,6 +1860,93 @@ __must_hold(RCU)
 	return ret;
 }
 
+static u16 p4tc_table_entry_tbl_permcpy(const u16 tblperm)
+{
+	return p4tc_ctrl_perm_rm_create(p4tc_data_perm_rm_create(tblperm));
+}
+
+int p4tc_table_entry_create_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u64 aging_ms)
+{
+	u16 tblperm = rcu_dereference(table->tbl_permissions)->permissions;
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	struct p4tc_table_entry_create_state state = {0};
+	struct p4tc_table_entry_value *value;
+	int err;
+
+	state.aging_ms = aging_ms;
+	state.permissions = p4tc_table_entry_tbl_permcpy(tblperm);
+	err = p4tc_table_entry_init_bpf(pipeline, table, key->keysz,
+					act_bpf, &state);
+	if (err < 0)
+		return err;
+	p4tc_table_entry_assign_key_exact(&state.entry->key, key->fa_key);
+
+	value = p4tc_table_entry_value(state.entry);
+	/* Entry is always dynamic when it comes from the data path */
+	value->is_dyn = true;
+
+	err = __p4tc_table_entry_create(pipeline, table, state.entry, mask,
+					P4TC_ENTITY_KERNEL, false);
+	if (err < 0)
+		goto put_state;
+
+	refcount_set(&value->entries_ref, 1);
+	if (state.p4_act)
+		p4a_runt_init_flags(state.p4_act);
+
+	return 0;
+
+put_state:
+	p4tc_table_entry_create_state_put(table, &state);
+
+	return err;
+}
+
+int p4tc_table_entry_update_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u64 aging_ms)
+{
+	struct p4tc_table_entry_create_state state = {0};
+	struct p4tc_table_entry_value *value;
+	int err;
+
+	state.aging_ms = aging_ms;
+	state.permissions = P4TC_PERMISSIONS_UNINIT;
+	err = p4tc_table_entry_init_bpf(pipeline, table, key->keysz, act_bpf,
+					&state);
+	if (err < 0)
+		return err;
+
+	p4tc_table_entry_assign_key_exact(&state.entry->key, key->fa_key);
+
+	value = p4tc_table_entry_value(state.entry);
+	value->is_dyn = !!aging_ms;
+	err = __p4tc_table_entry_update(pipeline, table, state.entry, NULL,
+					P4TC_ENTITY_KERNEL, false);
+
+	if (err < 0)
+		goto put_state;
+
+	refcount_set(&value->entries_ref, 1);
+	if (state.p4_act)
+		p4a_runt_init_flags(state.p4_act);
+
+	return 0;
+
+put_state:
+	p4tc_table_entry_create_state_put(table, &state);
+
+	return err;
+}
+
 static bool p4tc_table_check_entry_act(struct p4tc_table *table,
 				       struct tc_action *entry_act)
 {
@@ -1731,11 +2019,6 @@ update_tbl_attrs(struct net *net, struct p4tc_table *table,
 	return err;
 }
 
-static u16 p4tc_table_entry_tbl_permcpy(const u16 tblperm)
-{
-	return p4tc_ctrl_perm_rm_create(p4tc_data_perm_rm_create(tblperm));
-}
-
 #define P4TC_TBL_ENTRY_CU_FLAG_CREATE 0x1
 #define P4TC_TBL_ENTRY_CU_FLAG_UPDATE 0x2
 #define P4TC_TBL_ENTRY_CU_FLAG_SET 0x4
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index dfeb00446..ca80291d2 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -599,6 +599,10 @@ static int __init p4tc_template_init(void)
 			op->init();
 	}
 
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
+	register_p4tc_tbl_bpf();
+#endif
+
 	return 0;
 }
 
-- 
2.34.1


