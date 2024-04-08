Return-Path: <bpf+bounces-26181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E86489BEDB
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA92834EE
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC7B7CF30;
	Mon,  8 Apr 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hbeU+/R3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F27C0A1
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578843; cv=none; b=XWHtpkpMxvZvS78ErqTvHFHK1myQG59kzz1fIL9twLfUbZKcp8qk2N5e4djvgdYN8oJ1i9YYEhnRkpKPUgzZ+RYLnlk2knDJCJ/5SuXDl2DltYCeHezdI+qz8qAFQIZlZE+5Bv+yUXs+r67/W/xuFlwtKFdaQWxeV0KGpJkbU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578843; c=relaxed/simple;
	bh=RWYcwrEn2eaEF6R4PtJp8WkH6ktHkTCi7+wbp5AxyZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G21NiitmyrCOOjqglCTIKjCiCPB4Fhgl+Scf8upCTlUBHEMjVH4VKhvD8vt7ljM5+scVSRUHyqB/CdF88wVtNAtcae6gbe83MRZsVlCiXFGaj140UUldEA02mCQGk32vZ5tsxw3fmvhpx1l5nnL75YunGikdc1MnGnnQiJ24BZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hbeU+/R3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d555254b7so154431585a.1
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712578839; x=1713183639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWTZtKc7Ii0oeuh2xBYhMoSbzUrMb6YeytQylO5nBqA=;
        b=hbeU+/R35pQAhKRBS2CdPsQXnoH9pK50s49nyZrOQ09EccP4PfydS0x/7XdtMmjTvW
         N1q0AqjB9LmR83czug9YxzjYh5Bt0vJek/Xpp93qRK5MB+TbkLbe8extzKq2zjTuUOMM
         ZtikivuOOrdvMUwDcbwxXlGppb/5bapjB6v6VaNKKMkwq/Yl/n6yzXOGkMVhnrDQpSfs
         qFqLPaPSKMYl1rsJdqKuVjXToKo3urrvbNuWX+bNPPZNWShb2JQWrq/8fCLm6veYWme5
         xlt0vcjlviTWAIamIkRU3D4HkCu34QhrIyyXaBOThO9r6SBfduMWNxjpd9vT7gSHEA30
         tJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578839; x=1713183639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWTZtKc7Ii0oeuh2xBYhMoSbzUrMb6YeytQylO5nBqA=;
        b=meTHyG4Kd766HsfRklubcjkb/NNtwGnPnQiCS8F+gTssau/FxMW7N35JzkOVZJmu3x
         tUAxqaJ1X5Vpt1k0Jm/+GSGbUwH8Mnq2JgF+bGkaIjR0NqrMP4H3ppp1aY48wl7mXmf1
         EG4eIF8VZrvHSzwHTXPqDIr0bSqGtTezbDuAyWSmugmB544j4qM2tFCZfNaDrhbtG82P
         fXASkLGrOfF7eNCRdJj65TYzVml9iJdy9Kw7A3NvPG3g9Guh1oZiTCmjV6wsU2yv6LN/
         T5HnmO++81KnmFJsYjEIuxUwnxADRgL9u2Lv7LP5NjGy65lvoJxSLQqxEO5hzIq17XcN
         jn5A==
X-Forwarded-Encrypted: i=1; AJvYcCWIX2ZJwtub3rDkjwoTTSlkjiJ+ZpYDCbHv0kzdjJn3Zwu6HjbkL0nZskqI6zP+CQEwjBHRNE+kdzeaU1VcjvqK8YeU
X-Gm-Message-State: AOJu0Yxhp5g7D9gyp0PBo+qltWUZfa/5nmprJ8NBKCXAvNs5bQGERfMj
	Sc6K6gGxyAtwNdQgvi1kZtEiE7VZZ4AESXUGTPbRfkLCr+aYuf/Bkq1sf2V/SQ==
X-Google-Smtp-Source: AGHT+IEh6vP1WRW+43RRsXlwUdnnPNmm8Q7fzeUXC2cdDdbRNOw2TtA6cVQOIee8zpuUv2r20USGzA==
X-Received: by 2002:a05:620a:260f:b0:78d:46ba:b27b with SMTP id z15-20020a05620a260f00b0078d46bab27bmr15037753qko.21.1712578839148;
        Mon, 08 Apr 2024 05:20:39 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a148a00b0078d5d81d65fsm1936142qkj.32.2024.04.08.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:20:38 -0700 (PDT)
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
	martin.lau@linux.dev,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	alexei.starovoitov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v15  14/15] p4tc: add set of P4TC table kfuncs
Date: Mon,  8 Apr 2024 08:19:59 -0400
Message-Id: <20240408122000.449238-15-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408122000.449238-1-jhs@mojatatu.com>
References: <20240408122000.449238-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Note:
All P4 objects are owned and reside on the P4TC side. IOW, they are
controlled via TC netlink interfaces and their resources are managed
(created, updated, freed, etc) by the TC side. As an example, the structure
p4tc_table_entry_act is returned to the ebpf side on table lookup. On the
TC side that struct is wrapped around p4tc_table_entry_act_bpf_kern.
A multitude of these structure p4tc_table_entry_act_bpf_kern are
preallocated (to match the P4 architecture, patch #9 describes some of
the subtleties involved) by the P4TC control plane and put in a kernel
pool. Their purpose is to hold the action parameters for either a table
entry, a global per-table "miss" and "hit" action, etc - which are
instantiated and updated via netlink per runtime requests. An instance of
the p4tc_table_entry_act_bpf_kern.p4tc_table_entry_act is returned
to ebpf when there is a un/successful table lookup depending on how the
P4 program is written. When the table entry is deleted the instance of
the struct p4tc_table_entry_act_bpf_kern is recycled to the pool to be
reused for a future table entry. The only time the pool memory is released
is when the pipeline is deleted.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Nacked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bitops.h          |   1 +
 include/net/p4tc.h              |  93 ++++++-
 include/net/tc_act/p4tc.h       |  51 ++++
 include/uapi/linux/p4tc.h       |   2 +
 net/sched/p4tc/Makefile         |   1 +
 net/sched/p4tc/p4tc_action.c    |  71 +++++
 net/sched/p4tc/p4tc_bpf.c       | 360 +++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c  |  43 +++
 net/sched/p4tc/p4tc_table.c     |  50 +++-
 net/sched/p4tc/p4tc_tbl_entry.c | 458 ++++++++++++++++++++++++++++++--
 10 files changed, 1094 insertions(+), 36 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_bpf.c

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index b25dc87421..f8f02b9012 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -19,6 +19,7 @@
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_U16(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u16))
 #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 #define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index a49d61637d..466a33f812 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -127,8 +127,28 @@ struct p4tc_pipeline {
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
@@ -233,6 +253,8 @@ static inline int p4tc_action_destroy(struct tc_action *acts[])
 
 #define P4TC_PERMISSIONS_UNINIT (1 << P4TC_PERM_MAX_BIT)
 
+#define P4TC_MAX_PARAM_DATA_SIZE 124
+
 struct p4tc_table_defact {
 	struct tc_action *acts[2];
 	/* Will have two 7 bits blocks containing CRUDXPS (Create, read, update,
@@ -252,6 +274,7 @@ struct p4tc_table_perm {
 
 struct p4tc_table {
 	struct p4tc_template_common         common;
+	struct list_head                    tbl_cache_node;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
 	struct ida                          tbl_prio_ida;
@@ -352,6 +375,23 @@ struct p4tc_table_timer_profile {
 
 extern const struct rhashtable_params entry_hlt_params;
 
+struct p4tc_table_entry_act_bpf_params {
+	u32 pipeid;
+	u32 tblid;
+};
+
+struct p4tc_table_entry_create_bpf_params {
+	struct p4tc_table_entry_act_bpf act_bpf;
+	u32 profile_id;
+	u32 pipeid;
+	u32 tblid;
+};
+
+enum {
+	P4TC_ENTRY_CREATE_BPF_PARAMS_SZ = 144,
+	P4TC_ENTRY_ACT_BPF_PARAMS_SZ = 8,
+};
+
 struct p4tc_table_entry;
 struct p4tc_table_entry_work {
 	struct work_struct   work;
@@ -403,8 +443,24 @@ struct p4tc_table_entry {
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
@@ -421,6 +477,29 @@ p4tc_table_entry_work(struct p4tc_table_entry *entry)
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
@@ -490,6 +569,7 @@ static inline bool p4tc_action_put_ref(struct p4tc_act *act)
 
 struct p4tc_act_param *p4a_parm_find_byid(struct idr *params_idr,
 					  const u32 param_id);
+
 struct p4tc_act_param *
 p4a_parm_find_byany(struct p4tc_act *act, const char *param_name,
 		    const u32 param_id, struct netlink_ext_ack *extack);
@@ -546,10 +626,17 @@ static inline void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
 		if (defact->acts[0]) {
 			struct tcf_p4act *dflt = to_p4act(defact->acts[0]);
 
-			if (p4tc_table_defact_is_noaction(dflt))
+			if (p4tc_table_defact_is_noaction(dflt)) {
+				struct p4tc_table_entry_act_bpf_kern *act_bpf;
+
+				act_bpf =
+					rcu_dereference_protected(dflt->act_bpf,
+								  1);
+				kfree(act_bpf);
 				kfree(dflt);
-			else
+			} else {
 				p4tc_action_destroy(defact->acts);
+			}
 		}
 		kfree(defact);
 	}
diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
index 9b62dc76b6..f0da9a7115 100644
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
@@ -25,4 +41,39 @@ struct tcf_p4act {
 
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
index a73b13ac17..827f8e3bb1 100644
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
index 56a8adc741..73ccb53c46 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -3,3 +3,4 @@
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
 	p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
 	p4tc_filter.o p4tc_runtime_api.o
+obj-$(CONFIG_DEBUG_INFO_BTF) += p4tc_bpf.o
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
index b66b0413b3..64642c632c 100644
--- a/net/sched/p4tc/p4tc_action.c
+++ b/net/sched/p4tc/p4tc_action.c
@@ -292,17 +292,73 @@ static void p4a_set_num_runtime(struct tcf_p4act *p4act)
 	}
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
+	act_bpf = kzalloc(sizeof(*act_bpf), GFP_KERNEL_ACCOUNT);
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
+		param = params[i];
+		if (!p4a_param_has_runt_flag(param)) {
+			u32 type_bytesz;
+
+			type_bytesz =
+				BITS_TO_BYTES(param->type->container_bitsz);
+			memcpy(params_cursor, param->value, type_bytesz);
+			params_cursor += type_bytesz;
+		}
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
 	 * To avoid false positives, we are repeating these statements in
 	 * both branches of the if-statement
@@ -312,11 +368,13 @@ static int __p4a_runt_init_set(struct p4tc_act *act, struct tc_action **a,
 		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 		params_old = rcu_replace_pointer(p->params, params, 1);
 		p4a_set_num_runtime(p);
+		act_bpf_old = rcu_replace_pointer(p->act_bpf, act_bpf, 1);
 		spin_unlock_bh(&p->tcf_lock);
 	} else {
 		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 		params_old = rcu_replace_pointer(p->params, params, 1);
 		p4a_set_num_runtime(p);
+		act_bpf_old = rcu_replace_pointer(p->act_bpf, act_bpf, 1);
 	}
 
 	if (goto_ch)
@@ -325,6 +383,9 @@ static int __p4a_runt_init_set(struct p4tc_act *act, struct tc_action **a,
 	if (params_old)
 		call_rcu(&params_old->rcu, p4a_runt_parms_destroy_rcu);
 
+	if (act_bpf_old)
+		kfree_rcu(act_bpf_old, rcu);
+
 	return 0;
 }
 
@@ -519,6 +580,7 @@ void p4a_runt_prealloc_reference(struct p4tc_act *act, struct tcf_p4act *p4act)
 static void __p4a_runt_prealloc_put(struct p4tc_act *act,
 				    struct tcf_p4act *p4act)
 {
+	struct p4tc_table_entry_act_bpf_kern *act_bpf_old;
 	struct tcf_p4act_params *p4act_params;
 	struct p4tc_act_param *param;
 	unsigned long param_id, tmp;
@@ -541,6 +603,10 @@ static void __p4a_runt_prealloc_put(struct p4tc_act *act,
 	atomic_dec(&act->num_insts);
 	spin_unlock_bh(&p4act->tcf_lock);
 
+	act_bpf_old = rcu_replace_pointer(p4act->act_bpf, NULL, 1);
+	if (act_bpf_old)
+		kfree_rcu(act_bpf_old, rcu);
+
 	spin_lock_bh(&act->list_lock);
 	list_add_tail(&p4act->node, &act->prealloc_list);
 	spin_unlock_bh(&act->list_lock);
@@ -1240,10 +1306,12 @@ static int p4a_runt_walker(struct net *net, struct sk_buff *skb,
 static void p4a_runt_cleanup(struct tc_action *a)
 {
 	struct tc_action_ops *ops = (struct tc_action_ops *)a->ops;
+	struct p4tc_table_entry_act_bpf_kern *act_bpf;
 	struct tcf_p4act *m = to_p4act(a);
 	struct tcf_p4act_params *params;
 
 	params = rcu_dereference_protected(m->params, 1);
+	act_bpf = rcu_dereference_protected(m->act_bpf, 1);
 
 	if (!(a->tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED)) {
 		struct net *net = maybe_get_net(a->idrinfo->net);
@@ -1263,6 +1331,9 @@ static void p4a_runt_cleanup(struct tc_action *a)
 
 	if (params)
 		call_rcu(&params->rcu, p4a_runt_parms_destroy_rcu);
+
+	if (act_bpf)
+		kfree_rcu(act_bpf, rcu);
 }
 
 static void p4a_runt_net_exit(struct tc_action_net *tn)
diff --git a/net/sched/p4tc/p4tc_bpf.c b/net/sched/p4tc/p4tc_bpf.c
new file mode 100644
index 0000000000..1479fc5f1a
--- /dev/null
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -0,0 +1,360 @@
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
+		    const u32 params__sz,
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
+	if (params__sz != P4TC_ENTRY_ACT_BPF_PARAMS_SZ)
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
+bpf_p4tc_tbl_read(struct sk_buff *skb,
+		  struct p4tc_table_entry_act_bpf_params *params,
+		  const u32 params__sz,
+		  void *key, const u32 key__sz)
+{
+	struct net *caller_net;
+
+	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, params__sz, key,
+				   key__sz);
+}
+
+__bpf_kfunc static struct p4tc_table_entry_act_bpf *
+xdp_p4tc_tbl_read(struct xdp_buff *ctx,
+		  struct p4tc_table_entry_act_bpf_params *params,
+		  const u32 params__sz,
+		  void *key, const u32 key__sz)
+{
+	struct net *caller_net;
+
+	caller_net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, params__sz, key,
+				   key__sz);
+}
+
+static int
+__bpf_p4tc_entry_create(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			const u32 params__sz,
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
+	if (params__sz != P4TC_ENTRY_CREATE_BPF_PARAMS_SZ)
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
+bpf_p4tc_entry_create(struct sk_buff *skb,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      const u32 params__sz,
+		      void *key, const u32 key__sz)
+{
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_create(net, params, params__sz, key, key__sz,
+				       &params->act_bpf);
+}
+
+__bpf_kfunc static int
+xdp_p4tc_entry_create(struct xdp_buff *ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      const u32 params__sz,
+		      void *key, const u32 key__sz)
+{
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_create(net, params, params__sz, key, key__sz,
+				       &params->act_bpf);
+}
+
+__bpf_kfunc static int
+bpf_p4tc_entry_create_on_miss(struct sk_buff *skb,
+			      struct p4tc_table_entry_create_bpf_params *params,
+			      const u32 params__sz,
+			      void *key, const u32 key__sz)
+{
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_create(net, params, params__sz, key, key__sz,
+				       &params->act_bpf);
+}
+
+__bpf_kfunc static int
+xdp_p4tc_entry_create_on_miss(struct xdp_buff *ctx,
+			      struct p4tc_table_entry_create_bpf_params *params,
+			      const u32 params__sz,
+			      void *key, const u32 key__sz)
+{
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_create(net, params, params__sz, key, key__sz,
+				       &params->act_bpf);
+}
+
+static int
+__bpf_p4tc_entry_update(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			const u32 params__sz,
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
+	if (params__sz != P4TC_ENTRY_CREATE_BPF_PARAMS_SZ)
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
+bpf_p4tc_entry_update(struct sk_buff *skb,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      const u32 params__sz,
+		      void *key, const u32 key__sz)
+{
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_update(net, params, params__sz, key, key__sz,
+				       &params->act_bpf);
+}
+
+__bpf_kfunc static int
+xdp_p4tc_entry_update(struct xdp_buff *ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      const u32 params__sz,
+		      void *key, const u32 key__sz)
+{
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_update(net, params, params__sz, key, key__sz,
+				       &params->act_bpf);
+}
+
+static int
+__bpf_p4tc_entry_delete(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			const u32 params__sz,
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
+	if (params__sz != P4TC_ENTRY_CREATE_BPF_PARAMS_SZ)
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
+bpf_p4tc_entry_delete(struct sk_buff *skb,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      const u32 params__sz,
+		      void *key, const u32 key__sz)
+{
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_delete(net, params, params__sz, key, key__sz);
+}
+
+__bpf_kfunc static int
+xdp_p4tc_entry_delete(struct xdp_buff *ctx,
+		      struct p4tc_table_entry_create_bpf_params *params,
+		      const u32 params__sz,
+		      void *key, const u32 key__sz)
+{
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_delete(net, params, params__sz, key, key__sz);
+}
+
+BTF_KFUNCS_START(p4tc_kfunc_check_tbl_set_skb)
+BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
+BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
+BTF_KFUNCS_END(p4tc_kfunc_check_tbl_set_skb)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_skb = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_tbl_set_skb,
+};
+
+BTF_KFUNCS_START(p4tc_kfunc_check_tbl_set_xdp)
+BTF_ID_FLAGS(func, xdp_p4tc_tbl_read, KF_RET_NULL);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_create);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_create_on_miss);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_update);
+BTF_ID_FLAGS(func, xdp_p4tc_entry_delete);
+BTF_KFUNCS_END(p4tc_kfunc_check_tbl_set_xdp)
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
index 9b3cc9245f..90f81dedc6 100644
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
index 588d22cc48..024c478530 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -28,7 +28,8 @@
 #include <net/netlink.h>
 #include <net/flow_offload.h>
 
-static int __p4tc_table_try_set_state_ready(struct p4tc_table *table,
+static int __p4tc_table_try_set_state_ready(struct net *net,
+					    struct p4tc_table *table,
 					    struct netlink_ext_ack *extack)
 {
 	struct p4tc_table_entry_mask __rcu **masks_array;
@@ -53,10 +54,13 @@ static int __p4tc_table_try_set_state_ready(struct p4tc_table *table,
 	rcu_replace_pointer_rtnl(table->tbl_free_masks_bitmap,
 				 tbl_free_masks_bitmap);
 
+	p4tc_tbl_cache_insert(net, table->common.p_id, table);
+
 	return 0;
 }
 
-static void free_table_cache_array(struct p4tc_table **set_tables,
+static void free_table_cache_array(struct net *net,
+				   struct p4tc_table **set_tables,
 				   int num_tables)
 {
 	int i;
@@ -72,6 +76,8 @@ static void free_table_cache_array(struct p4tc_table **set_tables,
 		free_masks_bitmap =
 			rtnl_dereference(table->tbl_free_masks_bitmap);
 		bitmap_free(free_masks_bitmap);
+
+		p4tc_tbl_cache_remove(net, table);
 	}
 }
 
@@ -90,7 +96,8 @@ int p4tc_table_try_set_state_ready(struct p4tc_pipeline *pipeline,
 		return -ENOMEM;
 
 	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, id) {
-		ret = __p4tc_table_try_set_state_ready(table, extack);
+		ret = __p4tc_table_try_set_state_ready(pipeline->net, table,
+						       extack);
 		if (ret < 0)
 			goto free_set_tables;
 		set_tables[i] = table;
@@ -101,7 +108,7 @@ int p4tc_table_try_set_state_ready(struct p4tc_pipeline *pipeline,
 	return 0;
 
 free_set_tables:
-	free_table_cache_array(set_tables, i);
+	free_table_cache_array(pipeline->net, set_tables, i);
 	kfree(set_tables);
 	return ret;
 }
@@ -645,6 +652,8 @@ static int _p4tc_table_put(struct net *net, struct nlattr **tb,
 
 	rhltable_free_and_destroy(&table->tbl_entries,
 				  p4tc_table_entry_destroy_hash, table);
+	if (pipeline->p_state == P4TC_STATE_READY)
+		p4tc_tbl_cache_remove(net, table);
 
 	idr_destroy(&table->tbl_masks_idr);
 	ida_destroy(&table->tbl_prio_ida);
@@ -811,6 +820,7 @@ __p4tc_table_init_defact(struct net *net, struct nlattr **tb, u32 pipeid,
 		if (ret < 0)
 			goto err;
 	} else if (tb[P4TC_TABLE_DEFAULT_ACTION_NOACTION]) {
+		struct p4tc_table_entry_act_bpf_kern *no_action_bpf_kern;
 		struct tcf_p4act *p4_defact;
 
 		if (!p4tc_ctrl_update_ok(perm)) {
@@ -820,11 +830,20 @@ __p4tc_table_init_defact(struct net *net, struct nlattr **tb, u32 pipeid,
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
@@ -959,6 +978,14 @@ int p4tc_table_init_default_acts(struct net *net,
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
 
@@ -981,11 +1008,22 @@ int p4tc_table_init_default_acts(struct net *net,
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
@@ -1772,6 +1810,10 @@ static int __init p4tc_table_init(void)
 {
 	p4tc_tmpl_register_ops(&p4tc_table_ops);
 
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
+	register_p4tc_tbl_bpf();
+#endif
+
 	return 0;
 }
 
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index 6e24014b22..d28bba95c3 100644
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
 
@@ -1031,6 +1130,43 @@ __must_hold(RCU)
 	return 0;
 }
 
+/* Internal function which will be called by the data path */
+static int __p4tc_table_entry_del(struct p4tc_table *table,
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
+	ret = ___p4tc_table_entry_del(table, entry, false);
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
+	return __p4tc_table_entry_del(table, key, mask, 0);
+}
+
 #define RET_EVENT_FAILED 1
 
 static int
@@ -1379,6 +1515,43 @@ static int p4tc_table_entry_flush(struct net *net,
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
+	params_cursor = act_bpf->params;
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
@@ -1537,6 +1710,163 @@ __must_hold(RCU)
 	return ret;
 }
 
+static bool p4tc_table_check_entry_act(struct p4tc_table *table,
+				       struct tc_action *entry_act)
+{
+	struct tcf_p4act *entry_p4act = to_p4act(entry_act);
+	struct p4tc_table_act *table_act;
+
+	if (entry_p4act->num_runt_params > 0)
+		return false;
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
+	if (act_bpf->act_id) {
+		act = p4a_tmpl_get(pipeline, NULL, act_bpf->act_id, NULL);
+		if (IS_ERR(act)) {
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
+	if (state->act) {
+		p4tc_action_put_ref(state->act);
+		atomic_dec(&state->act->num_insts);
+	}
+}
+
 /* Invoked from both control and data path  */
 static int __p4tc_table_entry_update(struct p4tc_pipeline *pipeline,
 				     struct p4tc_table *table,
@@ -1675,41 +2005,111 @@ __must_hold(RCU)
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
 
-	if (entry_p4act->num_runt_params > 0)
-		return false;
+/* If the profile_id specified by the eBPF program for entry create or update is
+ * invalid, we'll use the default profile ID's aging value
+ */
+static void
+p4tc_table_entry_assign_aging(struct p4tc_table *table,
+			      struct p4tc_table_entry_create_state *state,
+			      u32 profile_id)
+{
+	struct p4tc_table_timer_profile *timer_profile;
 
-	list_for_each_entry(table_act, &table->tbl_acts_list, node) {
-		if (table_act->act->common.p_id != entry_p4act->p_id ||
-		    table_act->act->a_id != entry_p4act->act_id)
-			continue;
+	timer_profile = p4tc_table_timer_profile_find(table, profile_id);
+	if (!timer_profile)
+		timer_profile = p4tc_table_timer_profile_find(table,
+							      P4TC_DEFAULT_TIMER_PROFILE_ID);
 
-		if (!(table_act->flags &
-		      BIT(P4TC_TABLE_ACTS_DEFAULT_ONLY)))
-			return true;
-	}
+	state->aging_ms = timer_profile->aging_ms;
+}
 
-	return false;
+int p4tc_table_entry_create_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u32 profile_id)
+{
+	u16 tblperm = rcu_dereference(table->tbl_permissions)->permissions;
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	struct p4tc_table_entry_create_state state = {0};
+	struct p4tc_table_entry_value *value;
+	int err;
+
+	p4tc_table_entry_assign_aging(table, &state, profile_id);
+
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
+		p4a_runt_prealloc_reference(state.act, state.p4_act);
+
+	return 0;
+
+put_state:
+	p4tc_table_entry_create_state_put(table, &state);
+
+	return err;
 }
 
-static bool p4tc_table_check_no_act(struct p4tc_table *table)
+int p4tc_table_entry_update_bpf(struct p4tc_pipeline *pipeline,
+				struct p4tc_table *table,
+				struct p4tc_table_entry_key *key,
+				struct p4tc_table_entry_act_bpf *act_bpf,
+				u32 profile_id)
 {
-	struct p4tc_table_act *table_act;
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
+	state.permissions = P4TC_PERMISSIONS_UNINIT;
+	err = p4tc_table_entry_init_bpf(pipeline, table, key->keysz, act_bpf,
+					&state);
+	if (err < 0)
+		return err;
 
-	return false;
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
+		p4a_runt_prealloc_reference(state.act, state.p4_act);
+
+	return 0;
+
+put_state:
+	p4tc_table_entry_create_state_put(table, &state);
+
+	return err;
 }
 
 static struct nla_policy
@@ -1781,11 +2181,6 @@ static int p4tc_tbl_attrs_update(struct net *net, struct p4tc_table *table,
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
@@ -1910,6 +2305,11 @@ __p4tc_table_entry_cu(struct net *net, u8 cu_flags, struct nlattr **tb,
 				       "Action not allowed as entry action");
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


