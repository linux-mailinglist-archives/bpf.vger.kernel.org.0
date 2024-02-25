Return-Path: <bpf+bounces-22703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E580A862C26
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 17:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3360BB21175
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B11CA85;
	Sun, 25 Feb 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rehpEajR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D51C2A8
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880137; cv=none; b=eLkE26vxWZmtfvlf7UkGEVzWlf+tCPYA/qTWHWf6/ms+nulB0e3Jge1NaiSJMPzCiSumzaguNxeLEERA9W1ovGikCHfumDKZlxLhqJh1/SYRG4O8SLtjQXuse0KzE1Gi2/xxqRot7Da9MsKV+4LUuLHMpvJtWDSmkfZ3MnD1DbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880137; c=relaxed/simple;
	bh=Qwn0Km3TA7jbRjFmMBLtRA3I7bHtQ0vyjmXUmKB+3gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NfLmJjgpAtMeGSzCUtSFTYnOyUApjg0Ph4I7NdhmbgBr8f2yHTlEDAMwUgBHo78sdKZWOe+u45Tq42WIT9Kqvkx4mnm4gL94YsndlB4wGCS4/7puWCVRmE/bXheM6WHLmdPO8Iz7wD3+LGgmwztVSB7obKbW+rT58mGPpgzP3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rehpEajR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7810827e54eso201336285a.2
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708880133; x=1709484933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p++6wzkXmVXr38D9WMsFy8qlUOL+DA7EzjXJIyIezZI=;
        b=rehpEajRo7VyjjJDLHn9qR1WgmPPxr3IPJxGukY0P4Jl5NfhbAm4J5T3gES6SSESnP
         LIpXnwHx/WQeSaA466MFEkj4PvbuNc2bb0tbZvPUBN2NT4OeRh54Pl6RfJMWyVBE7G83
         36bvFqjR7w7AOfNdv//L87ZMkJReClo32mH8Q6ygqFaRNDsmNuukMNzU8jxo9O2l1yVT
         HV2IsvmPPd0RTNmbaTRHlbW4Q5sX4T9BmRl0ffQATGBxF0TV31gOLarbQH6VQuhf9XBU
         +DEysv3jzHASNkd+e9lN+zk8pHsOo0nQk/Pdt2u+BVyDuakuoWD6I2wHfKOAG7MgbfNJ
         Bv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880133; x=1709484933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p++6wzkXmVXr38D9WMsFy8qlUOL+DA7EzjXJIyIezZI=;
        b=tAc9nq6+VdFoU5U1AC38FFt5o46LPD3DYMAzZBF/5zq4eQilpLLVlq9ecGv9hhLWxJ
         YzVy8TbaxbeDu4e6seifyPEFaH87srvK8T7yK68PDHt6OCOSkFS6A+yA2DcC5slRS9ls
         B97sOCv+Q0p19CaRKf7oB6zcn3gglhM91a0fn+rAhh24yzerpdJZ+2F4iwaQPxOjkip8
         wBxAJWc2TqflA7qmDAiZ8bLXre1XxR+UNTSkXEl4JOtYZi27C9hv2LSOJwz94u8fdWj+
         M1l4LjYdSDpjgXqpawo08AoswQEnaIMpdI2k0ZESMU1cgZ7YEEjYPEZkhnLPsBY8Dnzz
         S3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUHdT2w3MtSqIXR/eJd0r7mCFLN2v+Bl491/H1h1qTxnq8kJrhnposh9T4465bCbhu37czJNhE7EfY3xXXyE5jbCc5Q
X-Gm-Message-State: AOJu0Yz9+2Y+UYGOgh/fIYm01E+EEhjkb3uxBicKtX/aaaOH769tdm/u
	KjCIKlSrqIpX7wwYLVict0jwB8KyKd9IIi5wPo7ecVuF8bhsJfz7GVLf8yLgBg==
X-Google-Smtp-Source: AGHT+IEVdGS20a2XeNJdEJn+rp+y0dTSWP5l/UADP7ZNgjj7jm+rZMesJfWM3G7ggvpLoK/2dHo0og==
X-Received: by 2002:a05:620a:1023:b0:787:9d8a:97da with SMTP id a3-20020a05620a102300b007879d8a97damr5798610qkk.4.1708880132896;
        Sun, 25 Feb 2024 08:55:32 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a14b500b00787ba78da02sm1620698qkj.93.2024.02.25.08.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:55:32 -0800 (PST)
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
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v12  14/15] p4tc: add set of P4TC table kfuncs
Date: Sun, 25 Feb 2024 11:54:45 -0500
Message-Id: <20240225165447.156954-15-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225165447.156954-1-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
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
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/linux/bitops.h          |   1 +
 include/net/p4tc.h              |  89 ++++++-
 include/net/tc_act/p4tc.h       |  51 ++++
 include/uapi/linux/p4tc.h       |   2 +
 net/sched/p4tc/Makefile         |   1 +
 net/sched/p4tc/p4tc_action.c    |  71 ++++-
 net/sched/p4tc/p4tc_bpf.c       | 342 ++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c  |  43 +++
 net/sched/p4tc/p4tc_table.c     |  41 +++
 net/sched/p4tc/p4tc_tbl_entry.c | 454 ++++++++++++++++++++++++++++++--
 10 files changed, 1062 insertions(+), 33 deletions(-)
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
index 231936df4..9e6317dea 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -100,8 +100,28 @@ struct p4tc_pipeline {
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
@@ -227,6 +247,7 @@ struct p4tc_table_perm {
 
 struct p4tc_table {
 	struct p4tc_template_common         common;
+	struct list_head                    tbl_cache_node;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
 	struct ida                          tbl_prio_idr;
@@ -327,6 +348,17 @@ struct p4tc_table_timer_profile {
 
 extern const struct rhashtable_params entry_hlt_params;
 
+struct p4tc_table_entry_act_bpf_params {
+	u32 pipeid;
+	u32 tblid;
+};
+
+struct p4tc_table_entry_create_bpf_params {
+	u32 profile_id;
+	u32 pipeid;
+	u32 tblid;
+};
+
 struct p4tc_table_entry;
 struct p4tc_table_entry_work {
 	struct work_struct   work;
@@ -378,8 +410,24 @@ struct p4tc_table_entry {
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
 
+#define P4TC_ENTRY_KEY_SZ_BYTES(bits) \
+	(P4TC_ENTRY_KEY_OFFSET + P4TC_KEYSZ_BYTES(bits))
+
+#define P4TC_ENTRY_KEY_OFFSET (offsetof(struct p4tc_table_entry_key, fa_key))
+
+#define P4TC_ENTRY_VALUE_OFFSET(entry) \
+	(offsetof(struct p4tc_table_entry, key) + P4TC_ENTRY_KEY_OFFSET \
+	 + P4TC_KEYSZ_BYTES((entry)->key.keysz))
+
 static inline void *p4tc_table_entry_value(struct p4tc_table_entry *entry)
 {
 	return entry->key.fa_key + P4TC_KEYSZ_BYTES(entry->key.keysz);
@@ -396,6 +444,29 @@ p4tc_table_entry_work(struct p4tc_table_entry *entry)
 extern const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1];
 extern const struct nla_policy p4tc_policy[P4TC_MAX + 1];
 
+struct p4tc_table_entry *
+p4tc_table_entry_lookup_direct(struct p4tc_table *table,
+			       struct p4tc_table_entry_key *key);
+
+struct p4tc_table_entry_act_bpf *
+p4tc_table_entry_create_act_bpf(struct tc_action *action,
+				struct netlink_ext_ack *extack);
+int register_p4tc_tbl_bpf(void);
+int p4tc_table_entry_create_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u32 profile_id);
+int p4tc_table_entry_update_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u32 profile_id);
+
+int p4tc_table_entry_del_bpf(struct p4tc_pipeline *pipeline,
+			     struct p4tc_table *table,
+			     struct p4tc_table_entry_key *key);
+
 static inline int p4tc_action_init(struct net *net, struct nlattr *nla,
 				   struct tc_action *acts[], u32 pipeid,
 				   u32 flags, struct netlink_ext_ack *extack)
@@ -465,6 +536,7 @@ static inline bool p4tc_action_put_ref(struct p4tc_act *act)
 
 struct p4tc_act_param *p4a_parm_find_byid(struct idr *params_idr,
 					  const u32 param_id);
+
 struct p4tc_act_param *
 p4a_parm_find_byany(struct p4tc_act *act, const char *param_name,
 		    const u32 param_id, struct netlink_ext_ack *extack);
@@ -513,12 +585,19 @@ static inline void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
 {
 	if (defact) {
 		if (defact->acts[0]) {
-			struct tcf_p4act *p4_defact = to_p4act(defact->acts[0]);
+			struct tcf_p4act *dflt = to_p4act(defact->acts[0]);
+
+			if (p4tc_table_defact_is_noaction(dflt)) {
+				struct p4tc_table_entry_act_bpf_kern *act_bpf;
 
-			if (p4tc_table_defact_is_noaction(p4_defact))
-				kfree(p4_defact);
-			else
+				act_bpf =
+					rcu_dereference_protected(dflt->act_bpf,
+								  1);
+				kfree(act_bpf);
+				kfree(dflt);
+			} else {
 				p4tc_action_destroy(defact->acts);
+			}
 		}
 		kfree(defact);
 	}
diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
index c5256d821..155068de0 100644
--- a/include/net/tc_act/p4tc.h
+++ b/include/net/tc_act/p4tc.h
@@ -13,10 +13,26 @@ struct tcf_p4act_params {
 	u32 tot_params_sz;
 };
 
+#define P4TC_MAX_PARAM_DATA_SIZE 124
+
+struct p4tc_table_entry_act_bpf {
+	u32 act_id;
+	u32 hit:1,
+	    is_default_miss_act:1,
+	    is_default_hit_act:1;
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
@@ -24,4 +40,39 @@ struct tcf_p4act {
 
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
+static inline int
+p4tc_table_entry_act_bpf_change_flags(struct tc_action *action, u32 hit,
+				      u32 dflt_miss, u32 dflt_hit)
+{
+	struct p4tc_table_entry_act_bpf_kern *act_bpf, *act_bpf_old;
+	struct tcf_p4act *p4act = to_p4act(action);
+
+	act_bpf = kzalloc(sizeof(*act_bpf), GFP_KERNEL);
+	if (!act_bpf)
+		return -ENOMEM;
+
+	spin_lock_bh(&p4act->tcf_lock);
+	act_bpf_old = rcu_dereference_protected(p4act->act_bpf, 1);
+	act_bpf->act_bpf = act_bpf_old->act_bpf;
+	act_bpf->act_bpf.hit = hit;
+	act_bpf->act_bpf.is_default_hit_act = dflt_hit;
+	act_bpf->act_bpf.is_default_miss_act = dflt_miss;
+	rcu_replace_pointer(p4act->act_bpf, act_bpf, 1);
+	kfree_rcu(act_bpf_old, rcu);
+	spin_unlock_bh(&p4act->tcf_lock);
+
+	return 0;
+}
+
 #endif /* __NET_TC_ACT_P4_H */
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 3f1444ad9..943c79fbc 100644
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
index 56a8adc74..73ccb53c4 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -3,3 +3,4 @@
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
 	p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
 	p4tc_filter.o p4tc_runtime_api.o
+obj-$(CONFIG_DEBUG_INFO_BTF) += p4tc_bpf.o
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
index 4b7b5501a..6108bcf65 100644
--- a/net/sched/p4tc/p4tc_action.c
+++ b/net/sched/p4tc/p4tc_action.c
@@ -278,29 +278,85 @@ static void p4a_runt_parms_destroy_rcu(struct rcu_head *head)
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
+	act_bpf->act_bpf.hit = true;
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
@@ -309,6 +365,9 @@ static int __p4a_runt_init_set(struct p4tc_act *act, struct tc_action **a,
 	if (params_old)
 		call_rcu(&params_old->rcu, p4a_runt_parms_destroy_rcu);
 
+	if (act_bpf_old)
+		kfree_rcu(act_bpf_old, rcu);
+
 	return 0;
 }
 
@@ -506,6 +565,7 @@ void p4a_runt_init_flags(struct tcf_p4act *p4act)
 static void __p4a_runt_prealloc_put(struct p4tc_act *act,
 				    struct tcf_p4act *p4act)
 {
+	struct p4tc_table_entry_act_bpf_kern *act_bpf_old;
 	struct tcf_p4act_params *p4act_params;
 	struct p4tc_act_param *param;
 	unsigned long param_id, tmp;
@@ -524,6 +584,10 @@ static void __p4a_runt_prealloc_put(struct p4tc_act *act,
 	p4act->common.tcfa_flags |= TCA_ACT_FLAGS_UNREFERENCED;
 	spin_unlock_bh(&p4act->tcf_lock);
 
+	act_bpf_old = rcu_replace_pointer(p4act->act_bpf, NULL, 1);
+	if (act_bpf_old)
+		kfree_rcu(act_bpf_old, rcu);
+
 	spin_lock_bh(&act->list_lock);
 	list_add_tail(&p4act->node, &act->prealloc_list);
 	spin_unlock_bh(&act->list_lock);
@@ -1214,16 +1278,21 @@ static int p4a_runt_walker(struct net *net, struct sk_buff *skb,
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
index 000000000..0eb1002ca
--- /dev/null
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022-2024, Mojatatu Networks
+ * Copyright (c) 2022-2024, Intel Corporation.
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
+static struct p4tc_table_entry_act_bpf p4tc_no_action_hit_bpf = {
+	.hit = 1,
+};
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
+	pipeid = params->pipeid;
+	tblid = params->tblid;
+
+	if (key__sz != P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
+		return NULL;
+
+	table = p4tc_tbl_cache_lookup(caller_net, pipeid, tblid);
+	if (!table)
+		return NULL;
+
+	if (entry_key->keysz != table->tbl_keysz)
+		return NULL;
+
+	entry = p4tc_table_entry_lookup_direct(table, entry_key);
+	if (!entry) {
+		struct p4tc_table_defact *defact;
+
+		defact = rcu_dereference(table->tbl_dflt_missact);
+		return defact ? p4tc_table_entry_act_bpf(defact->acts[0]) :
+				NULL;
+	}
+
+	value = p4tc_table_entry_value(entry);
+
+	if (value->acts[0])
+		return p4tc_table_entry_act_bpf(value->acts[0]);
+
+	defact_hit = rcu_dereference(table->tbl_dflt_hitact);
+	return defact_hit ? p4tc_table_entry_act_bpf(defact_hit->acts[0]) :
+		&p4tc_no_action_hit_bpf;
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
+	if (key__sz != P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
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
+	if (entry_key->keysz != table->tbl_keysz)
+		return -EINVAL;
+
+	return p4tc_table_entry_create_bpf(pipeline, table, entry_key, act_bpf,
+					   params->profile_id);
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
+	if (key__sz != P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
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
+	if (entry_key->keysz != table->tbl_keysz)
+		return -EINVAL;
+
+	return p4tc_table_entry_update_bpf(pipeline, table, entry_key,
+					  act_bpf, params->profile_id);
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
+	if (key__sz != P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
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
+	if (entry_key->keysz != table->tbl_keysz)
+		return -EINVAL;
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
index 9b3cc9245..90f81dedc 100644
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
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index e1b2beed2..2bc758d85 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -645,6 +645,7 @@ static int _p4tc_table_put(struct net *net, struct nlattr **tb,
 
 	rhltable_free_and_destroy(&table->tbl_entries,
 				  p4tc_table_entry_destroy_hash, table);
+	p4tc_tbl_cache_remove(net, table);
 
 	idr_destroy(&table->tbl_masks_idr);
 	ida_destroy(&table->tbl_prio_idr);
@@ -816,6 +817,7 @@ __p4tc_table_init_defact(struct net *net, struct nlattr **tb, u32 pipeid,
 		if (ret < 0)
 			goto err;
 	} else if (tb[P4TC_TABLE_DEFAULT_ACTION_NOACTION]) {
+		struct p4tc_table_entry_act_bpf_kern *no_action_bpf_kern;
 		struct tcf_p4act *p4_defact;
 
 		if (!p4tc_ctrl_update_ok(perm)) {
@@ -825,11 +827,20 @@ __p4tc_table_init_defact(struct net *net, struct nlattr **tb, u32 pipeid,
 			goto err;
 		}
 
+		no_action_bpf_kern = kzalloc(sizeof(*no_action_bpf_kern),
+					     GFP_KERNEL);
+		if (!no_action_bpf_kern) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
 		p4_defact = kzalloc(sizeof(*p4_defact), GFP_KERNEL);
 		if (!p4_defact) {
+			kfree(no_action_bpf_kern);
 			ret = -ENOMEM;
 			goto err;
 		}
+		rcu_assign_pointer(p4_defact->act_bpf, no_action_bpf_kern);
 		p4_defact->p_id = 0;
 		p4_defact->act_id = 0;
 		defact->acts[0] = (struct tc_action *)p4_defact;
@@ -964,6 +975,14 @@ int p4tc_table_init_default_acts(struct net *net,
 		if (IS_ERR(hitact))
 			return PTR_ERR(hitact);
 
+		if (hitact->acts[0]) {
+			struct tc_action *_hitact = hitact->acts[0];
+
+			ret = p4tc_table_entry_act_bpf_change_flags(_hitact, 1,
+								    0, 1);
+			if (ret < 0)
+				goto default_hitacts_free;
+		}
 		dflt->hitact = hitact;
 	}
 
@@ -986,11 +1005,22 @@ int p4tc_table_init_default_acts(struct net *net,
 			goto default_hitacts_free;
 		}
 
+		if (missact->acts[0]) {
+			struct tc_action *_missact = missact->acts[0];
+
+			ret = p4tc_table_entry_act_bpf_change_flags(_missact, 0,
+								    1, 0);
+			if (ret < 0)
+				goto default_missacts_free;
+		}
 		dflt->missact = missact;
 	}
 
 	return 0;
 
+default_missacts_free:
+	p4tc_table_defact_destroy(dflt->missact);
+
 default_hitacts_free:
 	p4tc_table_defact_destroy(dflt->hitact);
 	return ret;
@@ -1423,6 +1453,10 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 		goto profiles_destroy;
 	}
 
+	ret = p4tc_tbl_cache_insert(net, pipeline->common.p_id, table);
+	if (ret < 0)
+		goto entries_hashtable_destroy;
+
 	pipeline->curr_tables += 1;
 
 	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
@@ -1430,6 +1464,9 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 
 	return table;
 
+entries_hashtable_destroy:
+	rhltable_destroy(&table->tbl_entries);
+
 profiles_destroy:
 	p4tc_table_timer_profiles_destroy(table);
 
@@ -1787,6 +1824,10 @@ static int __init p4tc_table_init(void)
 {
 	p4tc_tmpl_register_ops(&p4tc_table_ops);
 
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
+	register_p4tc_tbl_bpf();
+#endif
+
 	return 0;
 }
 
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index 7a644eb40..3904f62e7 100644
--- a/net/sched/p4tc/p4tc_tbl_entry.c
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -143,6 +143,32 @@ p4tc_entry_lookup(struct p4tc_table *table, struct p4tc_table_entry_key *key,
 	return NULL;
 }
 
+static struct p4tc_table_entry *
+__p4tc_entry_lookup(struct p4tc_table *table, struct p4tc_table_entry_key *key)
+	__must_hold(RCU)
+{
+	struct p4tc_table_entry *entry = NULL;
+	struct rhlist_head *tmp, *bucket_list;
+	struct p4tc_table_entry *entry_curr;
+	u32 smallest_prio = U32_MAX;
+
+	bucket_list =
+		rhltable_lookup(&table->tbl_entries, key, entry_hlt_params);
+	if (!bucket_list)
+		return NULL;
+
+	rhl_for_each_entry_rcu(entry_curr, tmp, bucket_list, ht_node) {
+		struct p4tc_table_entry_value *value =
+			p4tc_table_entry_value(entry_curr);
+		if (value->prio <= smallest_prio) {
+			smallest_prio = value->prio;
+			entry = entry_curr;
+		}
+	}
+
+	return entry;
+}
+
 void p4tc_tbl_entry_mask_key(u8 *masked_key, u8 *key, const u8 *mask,
 			     u32 masksz)
 {
@@ -152,6 +178,79 @@ void p4tc_tbl_entry_mask_key(u8 *masked_key, u8 *key, const u8 *mask,
 		masked_key[i] = key[i] & mask[i];
 }
 
+static void update_last_used(struct p4tc_table_entry *entry)
+{
+	struct p4tc_table_entry_tm *entry_tm;
+	struct p4tc_table_entry_value *value;
+
+	value = p4tc_table_entry_value(entry);
+	entry_tm = rcu_dereference(value->tm);
+	WRITE_ONCE(entry_tm->lastused, get_jiffies_64());
+
+	if (value->is_dyn && !hrtimer_active(&value->entry_timer))
+		hrtimer_start(&value->entry_timer, ms_to_ktime(1000),
+			      HRTIMER_MODE_REL);
+}
+
+static struct p4tc_table_entry *
+__p4tc_table_entry_lookup_direct(struct p4tc_table *table,
+				 struct p4tc_table_entry_key *key)
+{
+	struct p4tc_table_entry *entry = NULL;
+	u32 smallest_prio = U32_MAX;
+	int i;
+
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT)
+		return __p4tc_entry_lookup_fast(table, key);
+
+	for (i = 0; i < table->tbl_curr_num_masks; i++) {
+		u8 __mkey[sizeof(*key) + BITS_TO_BYTES(P4TC_MAX_KEYSZ)];
+		struct p4tc_table_entry_key *mkey = (void *)&__mkey;
+		struct p4tc_table_entry_mask *mask =
+			rcu_dereference(table->tbl_masks_array[i]);
+		struct p4tc_table_entry *entry_curr = NULL;
+
+		mkey->keysz = key->keysz;
+		mkey->maskid = mask->mask_id;
+		p4tc_tbl_entry_mask_key(mkey->fa_key, key->fa_key,
+					mask->fa_value,
+					BITS_TO_BYTES(mask->sz));
+
+		if (table->tbl_type == P4TC_TABLE_TYPE_LPM) {
+			entry_curr = __p4tc_entry_lookup_fast(table, mkey);
+			if (entry_curr)
+				return entry_curr;
+		} else {
+			entry_curr = __p4tc_entry_lookup(table, mkey);
+
+			if (entry_curr) {
+				struct p4tc_table_entry_value *value =
+					p4tc_table_entry_value(entry_curr);
+				if (value->prio <= smallest_prio) {
+					smallest_prio = value->prio;
+					entry = entry_curr;
+				}
+			}
+		}
+	}
+
+	return entry;
+}
+
+struct p4tc_table_entry *
+p4tc_table_entry_lookup_direct(struct p4tc_table *table,
+			       struct p4tc_table_entry_key *key)
+{
+	struct p4tc_table_entry *entry;
+
+	entry = __p4tc_table_entry_lookup_direct(table, key);
+
+	if (entry)
+		update_last_used(entry);
+
+	return entry;
+}
+
 #define p4tc_table_entry_mask_find_byid(table, id) \
 	(idr_find(&(table)->tbl_masks_idr, id))
 
@@ -1006,6 +1105,44 @@ __must_hold(RCU)
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
 static int p4tc_table_entry_gd(struct net *net, struct sk_buff *skb,
 			       int cmd, u16 *permissions, struct nlattr *arg,
 			       struct p4tc_path_nlattrs *nl_path_attrs,
@@ -1332,6 +1469,44 @@ static int p4tc_table_entry_flush(struct net *net, struct sk_buff *skb,
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
+	new_act_bpf->act_bpf = *act_bpf;
+	new_act_bpf->act_bpf.hit = 1;
+	new_act_bpf->act_bpf.is_default_hit_act = 0;
+	new_act_bpf->act_bpf.is_default_miss_act = 0;
+
+	rcu_assign_pointer(p4act->act_bpf, new_act_bpf);
+	value->acts[0] = (struct tc_action *)p4act;
+
+	return 0;
+}
+
 static enum hrtimer_restart entry_timer_handle(struct hrtimer *timer)
 {
 	struct p4tc_table_entry_value *value =
@@ -1490,6 +1665,158 @@ __must_hold(RCU)
 	return ret;
 }
 
+static bool p4tc_table_check_entry_act(struct p4tc_table *table,
+				       struct tc_action *entry_act)
+{
+	struct tcf_p4act *entry_p4act = to_p4act(entry_act);
+	struct p4tc_table_act *table_act;
+
+	list_for_each_entry(table_act, &table->tbl_acts_list, node) {
+		if (table_act->act->common.p_id != entry_p4act->p_id ||
+		    table_act->act->a_id != entry_p4act->act_id)
+			continue;
+
+		if (!(table_act->flags &
+		      BIT(P4TC_TABLE_ACTS_DEFAULT_ONLY)))
+			return true;
+	}
+
+	return false;
+}
+
+static bool p4tc_table_check_no_act(struct p4tc_table *table)
+{
+	struct p4tc_table_act *table_act;
+
+	if (list_empty(&table->tbl_acts_list))
+		return false;
+
+	list_for_each_entry(table_act, &table->tbl_acts_list, node) {
+		if (p4tc_table_act_is_noaction(table_act))
+			return true;
+	}
+
+	return false;
+}
+
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
+	} else {
+		if (!p4tc_table_check_no_act(table)) {
+			err = -EPERM;
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
+		if (!p4tc_table_check_entry_act(table, &p4_act->common)) {
+			err = -EPERM;
+			goto free_prealloc;
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
+	kfree(state->entry);
+
+	if (state->act)
+		p4tc_action_put_ref(state->act);
+}
+
 /* Invoked from both control and data path  */
 static int __p4tc_table_entry_update(struct p4tc_pipeline *pipeline,
 				     struct p4tc_table *table,
@@ -1628,38 +1955,111 @@ __must_hold(RCU)
 	return ret;
 }
 
-static bool p4tc_table_check_entry_act(struct p4tc_table *table,
-				       struct tc_action *entry_act)
+static u16 p4tc_table_entry_tbl_permcpy(const u16 tblperm)
 {
-	struct tcf_p4act *entry_p4act = to_p4act(entry_act);
-	struct p4tc_table_act *table_act;
+	return p4tc_ctrl_perm_rm_create(p4tc_data_perm_rm_create(tblperm));
+}
 
-	list_for_each_entry(table_act, &table->tbl_acts_list, node) {
-		if (table_act->act->common.p_id != entry_p4act->p_id ||
-		    table_act->act->a_id != entry_p4act->act_id)
-			continue;
+/* If the profile_id specified by the eBPF program for entry create or update is
+ * invalid, we'll use the default profile ID's aging value
+ */
+static void
+p4tc_table_entry_assign_aging(struct p4tc_table *table,
+			      struct p4tc_table_entry_create_state *state,
+			      u32 profile_id)
+{
+	struct p4tc_table_timer_profile *timer_profile;
 
-		if (!(table_act->flags &
-		      BIT(P4TC_TABLE_ACTS_DEFAULT_ONLY)))
-			return true;
-	}
+	timer_profile = p4tc_table_timer_profile_find(table, profile_id);
+	if (!timer_profile)
+		timer_profile = p4tc_table_timer_profile_find(table,
+							      P4TC_DEFAULT_TIMER_PROFILE_ID);
 
-	return false;
+	state->aging_ms = timer_profile->aging_ms;
 }
 
-static bool p4tc_table_check_no_act(struct p4tc_table *table)
+int p4tc_table_entry_create_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u32 profile_id)
 {
-	struct p4tc_table_act *table_act;
+	u16 tblperm = rcu_dereference(table->tbl_permissions)->permissions;
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	struct p4tc_table_entry_create_state state = {0};
+	struct p4tc_table_entry_value *value;
+	int err;
 
-	if (list_empty(&table->tbl_acts_list))
-		return false;
+	p4tc_table_entry_assign_aging(table, &state, profile_id);
 
-	list_for_each_entry(table_act, &table->tbl_acts_list, node) {
-		if (p4tc_table_act_is_noaction(table_act))
-			return true;
-	}
+	state.permissions = p4tc_table_entry_tbl_permcpy(tblperm);
+	err = p4tc_table_entry_init_bpf(pipeline, table, key->keysz,
+					act_bpf, &state);
+	if (err < 0)
+		return err;
+	p4tc_table_entry_assign_key_exact(&state.entry->key, key->fa_key);
 
-	return false;
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
+				u32 profile_id)
+{
+	struct p4tc_table_entry_create_state state = {0};
+	struct p4tc_table_entry_value *value;
+	int err;
+
+	p4tc_table_entry_assign_aging(table, &state, profile_id);
+
+	state.permissions = P4TC_PERMISSIONS_UNINIT;
+	err = p4tc_table_entry_init_bpf(pipeline, table, key->keysz, act_bpf,
+					&state);
+	if (err < 0)
+		return err;
+
+	p4tc_table_entry_assign_key_exact(&state.entry->key, key->fa_key);
+
+	value = p4tc_table_entry_value(state.entry);
+	value->is_dyn = !!state.aging_ms;
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
 }
 
 static struct nla_policy
@@ -1731,11 +2131,6 @@ static int p4tc_tbl_attrs_update(struct net *net, struct p4tc_table *table,
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
@@ -1860,6 +2255,11 @@ __p4tc_table_entry_cu(struct net *net, u8 cu_flags, struct nlattr **tb,
 				       "Action is not allowed as entry action");
 			goto free_acts;
 		}
+
+		ret = p4tc_table_entry_act_bpf_change_flags(value->acts[0], 1,
+							    0, 0);
+		if (ret < 0)
+			goto free_acts;
 	} else {
 		if (!p4tc_table_check_no_act(table)) {
 			NL_SET_ERR_MSG_FMT(extack,
-- 
2.34.1


