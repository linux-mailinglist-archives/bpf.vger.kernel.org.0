Return-Path: <bpf+bounces-26180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6265F89BEDA
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D96B24A8F
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB57C6E9;
	Mon,  8 Apr 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GhpNL52V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543517C082
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578842; cv=none; b=T9l9n3yS6cDIXRLlmPFXadSuG8DISXOKhI2J6LxAaExmG2g3TPL0tSZxHRc8T1nmoRv3ynnfEgh+gHFDhGxupFkQeVpkbnEjpJNAMEg0RaVnriY/z5i3q/qUTo7QtKv3McD+qnG3tLzv6O43uMF0Hhhp0xzXq/gbzc6+WEgO+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578842; c=relaxed/simple;
	bh=mci0gIDnwzY3fo5ZXpGHb4PyE/1HdxWmtIAxL1W90n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihtObdLjrSGopEVmmhO3Df4mn8XhYHOcVJS2s8CkmXqmUpbUSA6dta986J49RdSIhjr7w4prrfctlSjVLJ5zbC8MrPeCt5jx/BvmITcbBojFdvUaN0ZLpvFuLyWIy6ef9A/aDWUmIxXqz1tmz94G2kwio1wnRLenvQKuKxfX2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GhpNL52V; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a26aaefc8so247397585a.1
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712578837; x=1713183637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18oP3IK/xNV47Gu68PpS2dLZVkSO8spv1t0NfeFzEuA=;
        b=GhpNL52VMvYobddqO/yvD19QKyQLpm7TnI6ywmv6mPbHCRJALtAmydfEmK8NW8ZRY0
         1lm1GWcKB5ZbWFLBQrqI785r45HMvr6QNzGNDNdaIOFxq3FYEkRFhO5Zy8NzyDW2CI/l
         HE/3cDJcG3smKF1ZteFKF9fwZk/vUVlJnK1Zc+Z4XeDbVVIxirU4vij8sk4UkOPkY9Ae
         I5BEbR9D6ZvwQWF4FYXsR9FFPO5B8euuE6FO94YksA1BdLvZz3VYN/5rfGonGQ5XELk6
         FXQQnxx8i6L0s27wTZultSrSM1RWzrQyDsMS1zccbUsAYsdFUwMP2urbUiJ3FAZNMprK
         vhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578837; x=1713183637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18oP3IK/xNV47Gu68PpS2dLZVkSO8spv1t0NfeFzEuA=;
        b=FBWW+p9yoeloqda/FMfK6b42V3tfMjgYek+Z3orTuoKSn49+NgoP0zo7HK5BOxCcD4
         ujkr33pQOyNBcnQwKp38PiOk07F5PkuAVCEcAM3cPywIRAXL+LFMb3JWHouvjERrESnl
         r0k/htWpnNwZAkjlMcnxn/9G/vtpVfxrBVO5p37ltZEaBb0tSd6NWiKLAn7jkvpezxRt
         eCJq/G+U3fuSK91HtT0NFXI5u/oD1VgHALCHcB2dCmlqEMd+gG3yim4tzEV0oxrOY1am
         +j0570fPT7Zdeq+4nYotSDncUJhRk4MG9jRpZR3bdjOxPVTvL7x+GLk+NwtvcNsxGUsC
         ROBA==
X-Forwarded-Encrypted: i=1; AJvYcCXDRyvfdQmP5ie5chVorxjG8S+RN94nyalzvitlr26A8tsZqGKSimdNE2LV+ClJJHIkjJ08CqGMk3MnA1AG6fmpNlr0
X-Gm-Message-State: AOJu0Yyd8wMQ/df+k81NCMBBOPkVV9Lbijl7iqDsqQ1Ta3pdVWGoZBd1
	rCF8B5UGh3gm6y229xPm4kw9fTKeLb0+4LmgfxoyNMsoHtuHaJ9BkcgTzZIEbQ==
X-Google-Smtp-Source: AGHT+IHNKcUn5I2u3dLYGCrc0Wxolv+Dv1zNU8zBwp/OrCjjdwAUTfgQ0uw6+C448C0O1C2YBfyvkg==
X-Received: by 2002:a05:620a:6110:b0:78d:465e:8025 with SMTP id oq16-20020a05620a611000b0078d465e8025mr7827265qkn.14.1712578836892;
        Mon, 08 Apr 2024 05:20:36 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a148a00b0078d5d81d65fsm1936142qkj.32.2024.04.08.05.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:20:35 -0700 (PDT)
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
Subject: [PATCH net-next v15  13/15] p4tc: add runtime table entry get, delete, flush and dump
Date: Mon,  8 Apr 2024 08:19:58 -0400
Message-Id: <20240408122000.449238-14-jhs@mojatatu.com>
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

This commit allows users to get, delete, flush and dump table _entries_
(templates were described in earlier patch and so were create and update).

If the user wants to, for example, read a table entry from a table
(nh_table) which has as key nh_index (bit32), belongs to pipeline
(routing) and has as its key an nh_index of 1, they'd issue the
following command:

tc p4ctrl get routing/table/Main/nh_table nh_index 1

Which will give us the following output:

$TC p4ctrl get routing/table/Main/nh_table

pipeline:  routing(id 1)
 table: Main/nh_table(id 1)entry priority 64000[permissions -RUD-PS-R--X--]
    entry key
     nh_index id:1 size:32b type:bit32 exact fieldval  1
    entry actions:
	action order 1: routing/Main/set_nh  index 2 ref 1 bind 1
	 params:
	  dmac type macaddr  value: 13:37:13:37:13:37 id 1
	  port type dev  value: port1 id 2

    created by: tc (id 2)
    dynamic false
    created 20338 sec  used 39 sec

Note that, as with create and update, we need to specify the pipeline name,
the table name, the key and the priority, so that we can locate the table
entry. Also, in this case, the entry had an action which has a parameter
dmac (a mac address) and port1 (a net device).

If the user wanted to delete the same table entry, they'd issue the
following command:

tc p4ctrl del routing/table/Main/nh_table nh_index 1

Note that, again, we need to specify the pipeline name, the table
name, the key and the priority, so that we can locate the table entry.

We can also flush all the table entries from a specific table.
To flush the table entries of table tname ane pipeline ptables,
the user would issue the following command:

tc p4ctrl del routing/table/Main/nh_table

Likewise, we can also dump all the table entries from a specific table.
To dump the table entries of table tname and pipeline myprog, the user
would issue the following command:

tc p4ctrl get routing/table/Main/nh_table

Which will give the following output (in case we had one entry with
nh_index key value 1):

pipeline:  routing(id 1)
 table: Main/nh_table(id 1)entry priority 64000[permissions -RUD-PS-R--X--]
    entry key
     nh_index id:1 size:32b type:bit32 exact fieldval  1
    entry actions:
	action order 1: routing/Main/set_nh  index 2 ref 1 bind 1
	 params:
	  dmac type macaddr  value: 13:37:13:37:13:37 id 1
	  port type dev  value: port1 id 2

    created by: tc (id 2)
    dynamic false
    created 20338 sec  used 39 sec

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/p4tc.h                |   61 +-
 include/uapi/linux/p4tc.h         |  109 ++++
 net/sched/p4tc/Makefile           |    2 +-
 net/sched/p4tc/p4tc_filter.c      | 1012 +++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_runtime_api.c |   63 ++
 net/sched/p4tc/p4tc_table.c       |  118 +++-
 net/sched/p4tc/p4tc_tbl_entry.c   |  883 ++++++++++++++++++++++++-
 7 files changed, 2225 insertions(+), 23 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_filter.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index e2959c7677..a49d61637d 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -36,11 +36,44 @@
 #define P4TC_AID_IDX 1
 #define P4TC_PARSEID_IDX 1
 
+struct p4tc_filter {
+	struct p4tc_filter_oper *operation;
+	union {
+		struct {
+			u32 tbl_id;
+		};
+	};
+	u32 obj_id;
+};
+
+struct p4tc_filter_context {
+	struct p4tc_pipeline *pipeline;
+	union {
+		struct p4tc_table *table;
+	};
+	int cmd;
+	u32 obj_id;
+};
+
 struct p4tc_dump_ctx {
 	u32 ids[P4TC_PATH_MAX];
 	struct rhashtable_iter *iter;
+	struct p4tc_filter *entry_filter;
 };
 
+enum {
+	P4TC_FILTER_OBJ_UNSPEC,
+	P4TC_FILTER_OBJ_TMPL_PIPELINE,
+	P4TC_FILTER_OBJ_TMPL_ACT,
+	P4TC_FILTER_OBJ_TMPL_TABLE,
+	P4TC_FILTER_OBJ_TMPL_EXT,
+	P4TC_FILTER_OBJ_RUNTIME_TABLE,
+	P4TC_FILTER_OBJ_RUNTIME_EXT,
+	__P4TC_FILTER_OBJ_MAX,
+};
+
+#define P4TC_FILTER_OBJ_MAX (__P4TC_FILTER_OBJ_MAX - 1)
+
 struct p4tc_template_common;
 
 struct p4tc_path_nlattrs {
@@ -349,6 +382,7 @@ struct p4tc_table_entry_value {
 	struct p4tc_table_entry_work             *entry_work;
 	u64                                      aging_ms;
 	struct hrtimer                           entry_timer;
+	bool                                     is_dyn;
 	bool                                     tmpl_created;
 };
 
@@ -468,6 +502,12 @@ struct p4tc_table *p4tc_table_find_byid(struct p4tc_pipeline *pipeline,
 int p4tc_table_try_set_state_ready(struct p4tc_pipeline *pipeline,
 				   struct netlink_ext_ack *extack);
 void p4tc_table_put_mask_array(struct p4tc_pipeline *pipeline);
+
+static inline int p4tc_table_get(struct p4tc_table *table)
+{
+	return refcount_inc_not_zero(&table->tbl_ctrl_ref);
+}
+
 struct p4tc_table *p4tc_table_find_get(struct p4tc_pipeline *pipeline,
 				       const char *tblname, const u32 tbl_id,
 				       struct netlink_ext_ack *extack);
@@ -532,6 +572,15 @@ p4tc_table_init_permissions(struct p4tc_table *table, u16 permissions,
 void p4tc_table_replace_permissions(struct p4tc_table *table,
 				    struct p4tc_table_perm *tbl_perm,
 				    bool lock_rtnl);
+int p4tc_table_timer_profile_update(struct p4tc_table *table,
+				    struct nlattr *nla,
+				    struct netlink_ext_ack *extack);
+struct p4tc_table_timer_profile *
+p4tc_table_timer_profile_find_byaging(struct p4tc_table *table,
+				      u64 aging_ms);
+struct p4tc_table_timer_profile *
+p4tc_table_timer_profile_find(struct p4tc_table *table, u32 profile_id);
+
 void p4tc_table_entry_destroy_hash(void *ptr, void *arg);
 
 struct p4tc_table_entry *
@@ -546,7 +595,17 @@ int p4tc_tbl_entry_dumpit(struct net *net, struct sk_buff *skb,
 			  struct netlink_callback *cb,
 			  struct nlattr *arg, char *p_name);
 int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
-			struct p4tc_table_entry *entry, u32 tbl_id);
+			struct p4tc_table_entry *entry, u32 tbl_id,
+			u16 who_deleted);
+void p4tc_tbl_entry_mask_key(u8 *masked_key, u8 *key, const u8 *mask,
+			     u32 masksz);
+
+struct p4tc_filter *
+p4tc_filter_build(struct p4tc_filter_context *ctx,
+		  struct nlattr *nla, struct netlink_ext_ack *extack);
+bool p4tc_filter_exec(struct p4tc_filter *filter,
+		      struct p4tc_table_entry *entry);
+void p4tc_filter_destroy(struct p4tc_filter *filter);
 
 struct tcf_p4act *
 p4a_runt_prealloc_get_next(struct p4tc_act *act);
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 13a0af3c13..a73b13ac17 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -302,11 +302,116 @@ struct p4tc_table_entry_tm {
 	__u16 permissions;
 };
 
+enum {
+	P4TC_FILTER_OPND_ENTRY_ACT_UNSPEC,
+	P4TC_FILTER_OPND_ENTRY_ACT_NAME, /* string  */
+	P4TC_FILTER_OPND_ENTRY_ACT_ID, /* u32 */
+	P4TC_FILTER_OPND_ENTRY_ACT_PARAMS, /* nested params */
+	__P4TC_FILTER_OPND_ENTRY_ACT_MAX
+};
+
+#define P4TC_FILTER_OPND_ENTRY_ACT_MAX (__P4TC_FILTER_OPND_ENTRY_ACT_MAX - 1)
+
+enum {
+	P4TC_FILTER_OPND_ENTRY_UNSPEC,
+	P4TC_FILTER_OPND_ENTRY_KEY_BLOB, /* Key blob */
+	P4TC_FILTER_OPND_ENTRY_MASK_BLOB, /* Mask blob */
+	P4TC_FILTER_OPND_ENTRY_ACT, /* nested action -
+				     * P4TC_FITLER_OPND_ACT_XXX
+				     */
+	P4TC_FILTER_OPND_ENTRY_PRIO, /* u32 */
+	P4TC_FILTER_OPND_ENTRY_TIME_DELTA, /* in msecs */
+	__P4TC_FILTER_OPND_ENTRY_MAX
+};
+
+#define P4TC_FILTER_OPND_ENTRY_MAX (__P4TC_FILTER_OPND_ENTRY_MAX - 1)
+
+enum {
+	P4TC_FILTER_OPND_UNSPEC,
+	P4TC_FILTER_OPND_ENTRY, /* nested entry operands -
+				 * P4TC_FILTER_OPND_ENTRY_XXX
+				 */
+	__P4TC_FILTER_OPND_MAX
+};
+
+#define P4TC_FILTER_OPND_MAX (__P4TC_FILTER_OPND_MAX - 1)
+
+enum {
+	P4TC_FILTER_OP_KIND_UNSPEC,
+	P4TC_FILTER_OP_KIND_REL,
+	P4TC_FILTER_OP_KIND_LOGICAL,
+	__P4TC_FILTER_OP_KIND_MAX
+};
+
+#define P4TC_FILTER_OP_KIND_MAX (__P4TC_FILTER_OP_KIND_MAX - 1)
+
+enum {
+	P4TC_FILTER_OP_KIND_REL_UNSPEC,
+	P4TC_FILTER_OP_KIND_REL_EQ,
+	P4TC_FILTER_OP_KIND_REL_NEQ,
+	P4TC_FILTER_OP_KIND_REL_LT,
+	P4TC_FILTER_OP_KIND_REL_GT,
+	P4TC_FILTER_OP_KIND_REL_LE,
+	P4TC_FILTER_OP_KIND_REL_GE,
+	__P4TC_FILTER_OP_KIND_REL_MAX
+};
+
+#define P4TC_FILTER_OP_KIND_REL_MAX (__P4TC_FILTER_OP_KIND_REL_MAX - 1)
+
+enum {
+	P4TC_FILTER_OP_KIND_LOGICAL_UNSPEC,
+	P4TC_FILTER_OP_KIND_LOGICAL_AND,
+	P4TC_FILTER_OP_KIND_LOGICAL_OR,
+	P4TC_FILTER_OP_KIND_LOGICAL_NOT,
+	P4TC_FILTER_OP_KIND_LOGICAL_XOR,
+	__P4TC_FILTER_OP_KIND_LOGICAL_MAX
+};
+
+#define P4TC_FILTER_OP_KIND_LOGICAL_MAX (__P4TC_FILTER_OP_KIND_LOGICAL_MAX - 1)
+
+enum p4tc_filter_ntype {
+	P4TC_FILTER_OP_NODE_UNSPEC,
+	P4TC_FILTER_OP_NODE_PARENT, /* nested - P4TC_FILTER_XXX */
+	P4TC_FILTER_OP_NODE_LEAF, /* nested - P4TC_FILTER_OPND_XXX */
+	__P4TC_FILTER_OP_NODE_MAX
+};
+
+#define P4TC_FILTER_OP_NODE_MAX (__P4TC_FILTER_OP_NODE_MAX - 1)
+
+enum {
+	P4TC_FILTER_OP_UNSPEC,
+	P4TC_FILTER_OP_KIND, /* P4TC_FILTER_OP_KIND_REL ||
+			      * P4TC_FILTER_OP_KIND_LOGICAL
+			      */
+	P4TC_FILTER_OP_VALUE, /* P4TC_FILTER_OP_KIND_REL_XXX ||
+			       * P4TC_FILTER_OP_KIND_LOGICAL_XXX
+			       */
+	P4TC_FILTER_OP_NODE1, /* nested - P4TC_FILTER_OP_NODE_XXX */
+	P4TC_FILTER_OP_NODE2, /* nested - P4TC_FILTER_OP_NODE_XXX - Present only
+			       * for LOGICAL OPS with LOGICAL_NOT being the
+			       * exception
+			       */
+	__P4TC_FILTER_OP_MAX
+};
+
+#define P4TC_FILTER_OP_MAX (__P4TC_FILTER_OP_MAX - 1)
+
+enum {
+	P4TC_FILTER_UNSPEC,
+	P4TC_FILTER_OP,
+	__P4TC_FILTER_MAX,
+};
+
+#define P4TC_FILTER_MAX (__P4TC_FILTER_MAX - 1)
+
+#define P4TC_FILTER_DEPTH_LIMIT 5
+
 enum {
 	P4TC_ENTRY_TBL_ATTRS_UNSPEC,
 	P4TC_ENTRY_TBL_ATTRS_DEFAULT_HIT, /* nested default hit attrs */
 	P4TC_ENTRY_TBL_ATTRS_DEFAULT_MISS, /* nested default miss attrs */
 	P4TC_ENTRY_TBL_ATTRS_PERMISSIONS, /* u16 table permissions */
+	P4TC_ENTRY_TBL_ATTRS_TIMER_PROFILE, /* nested timer profile */
 	__P4TC_ENTRY_TBL_ATTRS,
 };
 
@@ -334,6 +439,10 @@ enum {
 	P4TC_ENTRY_TMPL_CREATED, /* u8 tells whether entry was create by
 				  * template
 				  */
+	P4TC_ENTRY_DYNAMIC, /* u8 tells if table entry is dynamic */
+	P4TC_ENTRY_AGING, /* u64 table entry aging */
+	P4TC_ENTRY_PROFILE_ID, /* u32 table entry profile ID */
+	P4TC_ENTRY_FILTER, /* nested filter */
 	P4TC_ENTRY_PAD,
 	__P4TC_ENTRY_MAX
 };
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 921909ac46..56a8adc741 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -2,4 +2,4 @@
 
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
 	p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
-	p4tc_runtime_api.o
+	p4tc_filter.o p4tc_runtime_api.o
diff --git a/net/sched/p4tc/p4tc_filter.c b/net/sched/p4tc/p4tc_filter.c
new file mode 100644
index 0000000000..57ff4e9fc5
--- /dev/null
+++ b/net/sched/p4tc/p4tc_filter.c
@@ -0,0 +1,1012 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_filter.c P4 TC FILTER
+ *
+ * Copyright (c) 2022-2024, Mojatatu Networks
+ * Copyright (c) 2022-2024, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+
+enum {
+	P4TC_FILTER_OPND_ENTRY_KIND_UNSPEC,
+	P4TC_FILTER_OPND_ENTRY_KIND_KEY,
+	P4TC_FILTER_OPND_ENTRY_KIND_ACT,
+	P4TC_FILTER_OPND_ENTRY_KIND_ACT_PARAM,
+	P4TC_FILTER_OPND_ENTRY_KIND_PRIO,
+	P4TC_FILTER_OPND_ENTRY_KIND_MSECS,
+};
+
+struct p4tc_filter_opnd_entry {
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+	u32 opnd_kind;
+	union {
+		struct {
+			u8 val[BITS_TO_BYTES(P4TC_MAX_KEYSZ)];
+			u8 mask[BITS_TO_BYTES(P4TC_MAX_KEYSZ)];
+		} entry_key;
+		struct {
+			struct p4tc_act *val;
+			struct p4tc_act_param *param;
+		} act;
+		u32 prio;
+		u32 msecs_since;
+	};
+};
+
+struct p4tc_filter_opnd {
+	u32 obj_id;
+	union {
+		struct p4tc_filter_opnd_entry opnd_entry;
+	};
+};
+
+struct p4tc_filter_oper;
+struct p4tc_filter_node {
+	enum p4tc_filter_ntype ntype;
+	union {
+		struct p4tc_filter_opnd *opnd;
+		struct p4tc_filter_oper *operation;
+	};
+};
+
+struct p4tc_filter_oper {
+	struct p4tc_filter_node *node1;
+	struct p4tc_filter_node *node2;
+	u16 op_kind;
+	u16 op_value;
+};
+
+static const struct nla_policy
+p4tc_entry_filter_act_policy[P4TC_FILTER_OPND_ENTRY_ACT_MAX + 1] = {
+	[P4TC_FILTER_OPND_ENTRY_ACT_NAME] = {
+		.type = NLA_STRING,
+		.len = ACTNAMSIZ
+	},
+	[P4TC_FILTER_OPND_ENTRY_ACT_ID] = { .type = NLA_U32 },
+	[P4TC_FILTER_OPND_ENTRY_ACT_PARAMS] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy
+p4tc_filter_opnd_entry_policy[P4TC_FILTER_OPND_ENTRY_MAX + 1] = {
+	[P4TC_FILTER_OPND_ENTRY_KEY_BLOB] =
+		NLA_POLICY_MAX(NLA_BINARY, BITS_TO_BYTES(P4TC_MAX_KEYSZ)),
+	[P4TC_FILTER_OPND_ENTRY_MASK_BLOB] =
+		NLA_POLICY_MAX(NLA_BINARY, BITS_TO_BYTES(P4TC_MAX_KEYSZ)),
+	[P4TC_FILTER_OPND_ENTRY_ACT] = { .type = NLA_NESTED },
+	[P4TC_FILTER_OPND_ENTRY_PRIO] = { .type = NLA_U32 },
+	[P4TC_FILTER_OPND_ENTRY_TIME_DELTA] = { .type = NLA_U32 },
+};
+
+static const struct nla_policy
+p4tc_filter_opnd_policy[P4TC_FILTER_OPND_MAX + 1] = {
+	[P4TC_FILTER_OPND_ENTRY] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy
+p4tc_entry_filter_op_node_policy[P4TC_FILTER_OP_NODE_MAX + 1] = {
+	[P4TC_FILTER_OP_NODE_PARENT] = { .type = NLA_NESTED },
+	[P4TC_FILTER_OP_NODE_LEAF] = { .type = NLA_NESTED },
+};
+
+static struct netlink_range_validation range_filter_op_kind = {
+	.min = P4TC_FILTER_OP_KIND_REL,
+	.max = P4TC_FILTER_OP_KIND_MAX,
+};
+
+static const struct nla_policy
+p4tc_entry_filter_op_policy[P4TC_FILTER_OP_MAX + 1] = {
+	[P4TC_FILTER_OP_KIND] =
+		NLA_POLICY_FULL_RANGE(NLA_U16, &range_filter_op_kind),
+	[P4TC_FILTER_OP_VALUE] = { .type = NLA_U16 },
+	[P4TC_FILTER_OP_NODE1] = { .type = NLA_NESTED },
+	[P4TC_FILTER_OP_NODE2] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy
+p4tc_entry_filter_policy[P4TC_FILTER_OP_MAX + 1] = {
+	[P4TC_FILTER_OP] = { .type = NLA_NESTED },
+};
+
+static bool p4tc_filter_msg_valid(struct nlattr **tb,
+				  struct netlink_ext_ack *extack)
+{
+	bool is_empty = true;
+	int i;
+
+	if ((tb[P4TC_FILTER_OPND_ENTRY_KEY_BLOB] &&
+	     !tb[P4TC_FILTER_OPND_ENTRY_MASK_BLOB]) ||
+	    (tb[P4TC_FILTER_OPND_ENTRY_MASK_BLOB] &&
+	     !tb[P4TC_FILTER_OPND_ENTRY_KEY_BLOB])) {
+		NL_SET_ERR_MSG(extack, "Must specify key with mask");
+		return false;
+	}
+
+	for (i = P4TC_FILTER_OPND_ENTRY_MASK_BLOB;
+	     i < P4TC_FILTER_OPND_ENTRY_MAX + 1; i++) {
+		if (tb[i]) {
+			if (!is_empty) {
+				NL_SET_ERR_MSG(extack,
+					       "May only specify one filter key attribute");
+				return false;
+			}
+			is_empty = false;
+		}
+	}
+
+	if (is_empty) {
+		NL_SET_ERR_MSG(extack, "Filter opnd message is empty");
+		return false;
+	}
+
+	return true;
+}
+
+static bool p4tc_filter_op_value_valid(const u16 filter_op_kind,
+				       const u16 filter_op_value,
+				       struct netlink_ext_ack *extack)
+{
+	switch (filter_op_kind) {
+	case P4TC_FILTER_OP_KIND_REL:
+		if (filter_op_value < P4TC_FILTER_OP_KIND_REL_EQ ||
+		    filter_op_value > P4TC_FILTER_OP_KIND_REL_MAX) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Invalid filter relational op %u\n",
+					   filter_op_value);
+			return false;
+		}
+		break;
+	case P4TC_FILTER_OP_KIND_LOGICAL:
+		if (filter_op_value < P4TC_FILTER_OP_KIND_LOGICAL_AND ||
+		    filter_op_value > P4TC_FILTER_OP_KIND_LOGICAL_MAX) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Invalid filter logical op %u\n",
+					   filter_op_value);
+			return false;
+		}
+		break;
+	default:
+		/* Will never happen */
+		return false;
+	}
+
+	return true;
+}
+
+static bool p4tc_filter_op_requires_node2(const u16 filter_op_kind,
+					  const u16 filter_op_value)
+{
+	switch (filter_op_kind) {
+	case P4TC_FILTER_OP_KIND_LOGICAL:
+		switch (filter_op_value) {
+		case P4TC_FILTER_OP_KIND_LOGICAL_AND:
+		case P4TC_FILTER_OP_KIND_LOGICAL_OR:
+		case P4TC_FILTER_OP_KIND_LOGICAL_XOR:
+			return true;
+		default:
+			return false;
+		}
+	case P4TC_FILTER_OP_KIND_REL:
+		return false;
+	default:
+		return false;
+	}
+}
+
+static void
+p4tc_filter_opnd_entry_destroy(struct p4tc_filter_opnd_entry *opnd_entry)
+{
+	switch (opnd_entry->opnd_kind) {
+	case P4TC_FILTER_OPND_ENTRY_KIND_ACT:
+		p4tc_action_put_ref(opnd_entry->act.val);
+		break;
+	case P4TC_FILTER_OPND_ENTRY_KIND_ACT_PARAM:
+		p4a_runt_parm_destroy(opnd_entry->act.param);
+		break;
+	default:
+		break;
+	}
+
+	p4tc_table_put_ref(opnd_entry->table);
+	p4tc_pipeline_put_ref(opnd_entry->pipeline);
+}
+
+static void p4tc_filter_opnd_destroy(struct p4tc_filter_opnd *opnd)
+{
+	p4tc_filter_opnd_entry_destroy(&opnd->opnd_entry);
+	kfree(opnd);
+}
+
+static void
+p4tc_filter_oper_destroy(struct p4tc_filter_oper *operation);
+
+static void p4tc_filter_node_destroy(struct p4tc_filter_node *node)
+{
+	if (!node)
+		return;
+
+	if (node->ntype == P4TC_FILTER_OP_NODE_LEAF)
+		p4tc_filter_opnd_destroy(node->opnd);
+	else
+		p4tc_filter_oper_destroy(node->operation);
+	kfree(node);
+}
+
+static void p4tc_filter_oper_destroy(struct p4tc_filter_oper *operation)
+{
+	p4tc_filter_node_destroy(operation->node1);
+	p4tc_filter_node_destroy(operation->node2);
+	kfree(operation);
+}
+
+void p4tc_filter_destroy(struct p4tc_filter *filter)
+{
+	if (filter)
+		p4tc_filter_oper_destroy(filter->operation);
+	kfree(filter);
+}
+
+static void
+p4tc_filter_opnd_entry_prio_build(struct p4tc_filter_opnd_entry *opnd_entry,
+				  struct nlattr *nla)
+{
+	opnd_entry->opnd_kind = P4TC_FILTER_OPND_ENTRY_KIND_PRIO;
+	opnd_entry->prio = nla_get_u32(nla);
+}
+
+static void
+p4tc_filter_opnd_entry_ms_since_build(struct p4tc_filter_opnd_entry *opnd_entry,
+				      struct nlattr *nla)
+{
+	opnd_entry->opnd_kind = P4TC_FILTER_OPND_ENTRY_KIND_MSECS;
+	opnd_entry->msecs_since = nla_get_u32(nla);
+}
+
+static int
+p4tc_filter_opnd_entry_act_build(struct p4tc_pipeline *pipeline,
+				 struct nlattr *nla,
+				 struct p4tc_filter_opnd_entry *opnd_entry,
+				 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_FILTER_OPND_ENTRY_MAX + 1];
+	struct p4tc_act_param *param = NULL;
+	struct p4tc_act *act;
+	char *act_name;
+	u32 act_id;
+	int ret;
+
+	if (!nla)
+		return 0;
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_OPND_ENTRY_ACT_MAX, nla,
+			       p4tc_entry_filter_act_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	act_id = tb[P4TC_FILTER_OPND_ENTRY_ACT_ID] ?
+		nla_get_u32(tb[P4TC_FILTER_OPND_ENTRY_ACT_ID]) : 0;
+
+	act_name = tb[P4TC_FILTER_OPND_ENTRY_ACT_NAME] ?
+		nla_data(tb[P4TC_FILTER_OPND_ENTRY_ACT_NAME]) : NULL;
+
+	act = p4a_tmpl_get(pipeline, act_name, act_id, extack);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	if (tb[P4TC_FILTER_OPND_ENTRY_ACT_PARAMS]) {
+		struct nlattr *act_params_attr;
+
+		act_params_attr = tb[P4TC_FILTER_OPND_ENTRY_ACT_PARAMS];
+		param = p4a_runt_parm_init(pipeline->net, act, act_params_attr,
+					   extack);
+		if (IS_ERR(param)) {
+			ret = PTR_ERR(param);
+			goto params_destroy;
+		}
+
+		opnd_entry->act.param = param;
+		opnd_entry->opnd_kind = P4TC_FILTER_OPND_ENTRY_KIND_ACT_PARAM;
+	} else {
+		opnd_entry->opnd_kind = P4TC_FILTER_OPND_ENTRY_KIND_ACT;
+	}
+
+	opnd_entry->act.val = act;
+
+	return 0;
+
+params_destroy:
+	p4a_runt_parm_destroy(param);
+
+	p4tc_action_put_ref(act);
+
+	return ret;
+}
+
+static int
+p4tc_filter_opnd_entry_key_build(struct nlattr **tb,
+				 struct p4tc_table *table,
+				 struct p4tc_filter_opnd_entry *opnd_entry,
+				 struct netlink_ext_ack *extack)
+{
+	u32 maskblob_len;
+	u32 keysz;
+
+	keysz = nla_len(tb[P4TC_FILTER_OPND_ENTRY_KEY_BLOB]);
+	nla_memcpy(opnd_entry->entry_key.val,
+		   tb[P4TC_FILTER_OPND_ENTRY_KEY_BLOB], keysz);
+
+	if (BITS_TO_BYTES(table->tbl_keysz) != keysz)
+		return -EINVAL;
+
+	maskblob_len =
+		nla_len(tb[P4TC_FILTER_OPND_ENTRY_MASK_BLOB]);
+	if (keysz != maskblob_len) {
+		NL_SET_ERR_MSG(extack,
+			       "Key and mask blob must have the same length");
+		return -EINVAL;
+	}
+
+	nla_memcpy(opnd_entry->entry_key.mask,
+		   tb[P4TC_FILTER_OPND_ENTRY_MASK_BLOB], keysz);
+	p4tc_tbl_entry_mask_key(opnd_entry->entry_key.val,
+				opnd_entry->entry_key.val,
+				opnd_entry->entry_key.mask, keysz);
+
+	opnd_entry->opnd_kind = P4TC_FILTER_OPND_ENTRY_KIND_KEY;
+
+	return 0;
+}
+
+static int
+p4tc_filter_opnd_entry_build(struct p4tc_filter_context *ctx,
+			     struct p4tc_filter_opnd_entry *opnd_entry,
+			     struct nlattr *nla,
+			     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_FILTER_OPND_ENTRY_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_OPND_ENTRY_MAX, nla,
+			       p4tc_filter_opnd_entry_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (!p4tc_filter_msg_valid(tb, extack))
+		return -EINVAL;
+
+	if (tb[P4TC_FILTER_OPND_ENTRY_PRIO]) {
+		struct nlattr *prio_attr;
+
+		prio_attr = tb[P4TC_FILTER_OPND_ENTRY_PRIO];
+		p4tc_filter_opnd_entry_prio_build(opnd_entry, prio_attr);
+	} else if (tb[P4TC_FILTER_OPND_ENTRY_TIME_DELTA]) {
+		struct nlattr *msecs_attr =
+			tb[P4TC_FILTER_OPND_ENTRY_TIME_DELTA];
+
+		p4tc_filter_opnd_entry_ms_since_build(opnd_entry,
+						      msecs_attr);
+	} else if (tb[P4TC_FILTER_OPND_ENTRY_ACT]) {
+		struct nlattr *entry_act_attr;
+
+		entry_act_attr = tb[P4TC_FILTER_OPND_ENTRY_ACT];
+		ret = p4tc_filter_opnd_entry_act_build(ctx->pipeline,
+						       entry_act_attr,
+						       opnd_entry, extack);
+		if (ret < 0)
+			return ret;
+	} else if (tb[P4TC_FILTER_OPND_ENTRY_KEY_BLOB]) {
+		ret = p4tc_filter_opnd_entry_key_build(tb, ctx->table,
+						       opnd_entry, extack);
+		if (ret < 0)
+			return ret;
+	} else {
+		return -EINVAL;
+	}
+
+	p4tc_pipeline_get(ctx->pipeline);
+	opnd_entry->pipeline = ctx->pipeline;
+	p4tc_table_get(ctx->table);
+	opnd_entry->table = ctx->table;
+
+	return 0;
+}
+
+static struct p4tc_filter_opnd *
+p4tc_filter_opnd_build(struct p4tc_filter_context *ctx, struct nlattr *nla,
+		       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_FILTER_OPND_MAX + 1];
+	struct p4tc_filter_opnd *filter_opnd;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_OPND_MAX, nla,
+			       p4tc_filter_opnd_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	filter_opnd = kzalloc(sizeof(*filter_opnd), GFP_KERNEL);
+	if (!filter_opnd)
+		return ERR_PTR(-ENOMEM);
+
+	filter_opnd->obj_id = ctx->obj_id;
+
+	switch (ctx->obj_id) {
+	case P4TC_FILTER_OBJ_RUNTIME_TABLE:
+		ret = p4tc_filter_opnd_entry_build(ctx,
+						   &filter_opnd->opnd_entry,
+						   tb[P4TC_FILTER_OPND_ENTRY],
+						   extack);
+		if (ret < 0)
+			goto free_filter_opnd;
+		break;
+	default:
+		ret = -EINVAL;
+		goto free_filter_opnd;
+	}
+
+	return filter_opnd;
+
+free_filter_opnd:
+	kfree(filter_opnd);
+	return ERR_PTR(ret);
+}
+
+static bool
+p4tc_filter_oper_rel_opnd_entry_is_comp(struct p4tc_filter_opnd_entry *opnd1,
+					struct netlink_ext_ack *extack)
+{
+	switch (opnd1->opnd_kind) {
+	case P4TC_FILTER_OPND_ENTRY_KIND_KEY:
+		NL_SET_ERR_MSG(extack,
+			       "Compare with key operand isn't allowed");
+		return false;
+	case P4TC_FILTER_OPND_ENTRY_KIND_ACT:
+		NL_SET_ERR_MSG(extack,
+			       "Compare with act operand is forbidden");
+		return false;
+	case P4TC_FILTER_OPND_ENTRY_KIND_ACT_PARAM: {
+		struct p4tc_act_param *param;
+
+		param = opnd1->act.param;
+		if (!p4tc_is_type_numeric(param->type->typeid)) {
+			NL_SET_ERR_MSG(extack,
+				       "May only compare numeric act parameters");
+			return false;
+		}
+		return true;
+	}
+	default:
+		return true;
+	}
+}
+
+static bool p4tc_filter_oper_rel_opnd_is_comp(struct p4tc_filter_opnd *opnd1,
+					      struct netlink_ext_ack *extack)
+{
+	switch (opnd1->obj_id) {
+	case P4TC_FILTER_OBJ_RUNTIME_TABLE: {
+		struct p4tc_filter_opnd_entry *opnd_entry = &opnd1->opnd_entry;
+
+		return p4tc_filter_oper_rel_opnd_entry_is_comp(opnd_entry,
+							       extack);
+	}
+	default:
+		/* Will never happen */
+		return false;
+	}
+}
+
+static bool p4tc_filter_oper_rel_is_valid(struct p4tc_filter_oper *filter_oper,
+					  struct netlink_ext_ack *extack)
+{
+	struct p4tc_filter_node *filter_node1 = filter_oper->node1;
+	struct p4tc_filter_opnd *opnd = filter_node1->opnd;
+
+	switch (filter_oper->op_value) {
+	case P4TC_FILTER_OP_KIND_REL_EQ:
+	case P4TC_FILTER_OP_KIND_REL_NEQ:
+		return true;
+	case P4TC_FILTER_OP_KIND_REL_LT:
+	case P4TC_FILTER_OP_KIND_REL_GT:
+	case P4TC_FILTER_OP_KIND_REL_LE:
+	case P4TC_FILTER_OP_KIND_REL_GE:
+		return p4tc_filter_oper_rel_opnd_is_comp(opnd, extack);
+	default:
+		/* Will never happen */
+		return false;
+	}
+}
+
+static bool p4tc_filter_oper_is_valid(struct p4tc_filter_oper *filter_oper,
+				      struct netlink_ext_ack *extack)
+{
+	switch (filter_oper->op_kind) {
+	case P4TC_FILTER_OP_KIND_LOGICAL:
+		return true;
+	case P4TC_FILTER_OP_KIND_REL:
+		return p4tc_filter_oper_rel_is_valid(filter_oper, extack);
+	default:
+		/* Will never happen */
+		return false;
+	}
+}
+
+static struct p4tc_filter_oper *
+p4tc_filter_oper_build(struct p4tc_filter_context *ctx, struct nlattr *nla,
+		       u32 depth, struct netlink_ext_ack *extack);
+
+static struct p4tc_filter_node *
+p4tc_filter_node_build(struct p4tc_filter_context *ctx,  struct nlattr *nla,
+		       u32 depth, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_FILTER_OP_NODE_MAX + 1];
+	struct p4tc_filter_oper *operation;
+	struct p4tc_filter_node *node;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_OP_NODE_MAX, nla,
+			       p4tc_entry_filter_op_node_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(-EINVAL);
+
+	if ((!tb[P4TC_FILTER_OP_NODE_PARENT] &&
+	     !tb[P4TC_FILTER_OP_NODE_LEAF]) ||
+	    (tb[P4TC_FILTER_OP_NODE_PARENT] && tb[P4TC_FILTER_OP_NODE_LEAF])) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify either P4TC_FILTER_OP_NODE_PARENT or P4TC_FILTER_OP_NODE_LEAF");
+		return ERR_PTR(-EINVAL);
+	}
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	if (tb[P4TC_FILTER_OP_NODE_LEAF]) {
+		struct p4tc_filter_opnd *opnd;
+
+		opnd = p4tc_filter_opnd_build(ctx,
+					      tb[P4TC_FILTER_OP_NODE_LEAF],
+					      extack);
+		if (IS_ERR(opnd)) {
+			ret = PTR_ERR(opnd);
+			goto free_node;
+		}
+		node->ntype = P4TC_FILTER_OP_NODE_LEAF;
+		node->opnd = opnd;
+
+		return node;
+	}
+
+	if (depth == P4TC_FILTER_DEPTH_LIMIT) {
+		NL_SET_ERR_MSG_FMT(extack, "Recursion limit (%d) exceeded",
+				   P4TC_FILTER_DEPTH_LIMIT);
+		ret = -EINVAL;
+		goto free_node;
+	}
+
+	operation = p4tc_filter_oper_build(ctx,
+					   tb[P4TC_FILTER_OP_NODE_PARENT],
+					   depth + 1, extack);
+	if (IS_ERR(operation)) {
+		ret = PTR_ERR(operation);
+		goto free_node;
+	}
+	node->ntype = P4TC_FILTER_OP_NODE_PARENT;
+	node->operation = operation;
+
+	return node;
+
+free_node:
+	kfree(node);
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_filter_oper *
+p4tc_filter_oper_build(struct p4tc_filter_context *ctx, struct nlattr *nla,
+		       u32 depth, struct netlink_ext_ack *extack)
+{
+	struct p4tc_filter_node *filter_node2 = NULL;
+	struct p4tc_filter_node *filter_node1;
+	struct nlattr *tb[P4TC_FILTER_OP_MAX + 1];
+	struct p4tc_filter_oper *filter_oper;
+	u16 filter_op_value;
+	u16 filter_op_kind;
+	int ret;
+
+	if (!nla)
+		return ERR_PTR(-EINVAL);
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_OP_MAX, nla,
+			       p4tc_entry_filter_op_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (!tb[P4TC_FILTER_OP_KIND] || !tb[P4TC_FILTER_OP_VALUE]) {
+		NL_SET_ERR_MSG(extack, "Must specify filter op kind and value");
+		return ERR_PTR(-EINVAL);
+	}
+
+	filter_op_kind = nla_get_u16(tb[P4TC_FILTER_OP_KIND]);
+	filter_op_value = nla_get_u16(tb[P4TC_FILTER_OP_VALUE]);
+
+	/* filter_op_kind is checked by netlink policy */
+	if (!p4tc_filter_op_value_valid(filter_op_kind, filter_op_value,
+					extack))
+		return ERR_PTR(-EINVAL);
+
+	if (!tb[P4TC_FILTER_OP_NODE1]) {
+		NL_SET_ERR_MSG_FMT(extack, "Must specify filter node1");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (p4tc_filter_op_requires_node2(filter_op_kind, filter_op_value)) {
+		if (!tb[P4TC_FILTER_OP_NODE2]) {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify filter node2");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	filter_oper = kzalloc(sizeof(*filter_oper), GFP_KERNEL);
+	if (!filter_oper)
+		return ERR_PTR(-ENOMEM);
+
+	filter_node1 = p4tc_filter_node_build(ctx,
+					      tb[P4TC_FILTER_OP_NODE1],
+					      depth, extack);
+	if (IS_ERR(filter_node1)) {
+		ret = PTR_ERR(filter_node1);
+		goto free_operation;
+	}
+
+	if (tb[P4TC_FILTER_OP_NODE2]) {
+		filter_node2 = p4tc_filter_node_build(ctx,
+						      tb[P4TC_FILTER_OP_NODE2],
+						      depth, extack);
+		if (IS_ERR(filter_node2)) {
+			ret = PTR_ERR(filter_node2);
+			goto free_node1;
+		}
+	}
+
+	filter_oper->op_kind = filter_op_kind;
+	filter_oper->op_value = filter_op_value;
+	filter_oper->node1 = filter_node1;
+	filter_oper->node2 = filter_node2;
+
+	if (!p4tc_filter_oper_is_valid(filter_oper, extack)) {
+		ret = -EINVAL;
+		goto free_node2;
+	}
+
+	return filter_oper;
+
+free_node2:
+	p4tc_filter_node_destroy(filter_node2);
+
+free_node1:
+	p4tc_filter_node_destroy(filter_node1);
+
+free_operation:
+	kfree(filter_oper);
+
+	return ERR_PTR(ret);
+}
+
+static bool p4tc_filter_obj_id_supported(u32 obj_id,
+					 struct netlink_ext_ack *extack)
+{
+	switch (obj_id) {
+	case P4TC_FILTER_OBJ_RUNTIME_TABLE:
+		return true;
+	default:
+		NL_SET_ERR_MSG_FMT(extack, "Unsupported runtime object ID %u\n",
+				   obj_id);
+		return false;
+	}
+}
+
+static struct p4tc_filter *
+__p4tc_filter_build(struct p4tc_filter_context *ctx,
+		    struct nlattr *nla, struct netlink_ext_ack *extack)
+{
+	struct p4tc_filter_oper *filter_oper;
+	struct p4tc_filter *filter;
+
+	if (!p4tc_filter_obj_id_supported(ctx->obj_id, extack))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return ERR_PTR(-ENOMEM);
+
+	filter_oper = p4tc_filter_oper_build(ctx, nla, 0, extack);
+	if (IS_ERR(filter_oper)) {
+		kfree(filter);
+		return (struct p4tc_filter *)filter_oper;
+	}
+
+	filter->operation = filter_oper;
+	filter->obj_id = ctx->obj_id;
+
+	switch (ctx->obj_id) {
+	case P4TC_FILTER_OBJ_RUNTIME_TABLE: {
+		struct p4tc_table *table = ctx->table;
+
+		filter->tbl_id = table ? table->tbl_id : 0;
+		break;
+	}
+	default:
+		break;
+	}
+
+	return filter;
+}
+
+struct p4tc_filter *
+p4tc_filter_build(struct p4tc_filter_context *ctx,
+		  struct nlattr *nla, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_FILTER_MAX + 1];
+	int ret;
+
+	if (!nla)
+		return NULL;
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_MAX, nla,
+			       p4tc_entry_filter_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return __p4tc_filter_build(ctx, tb[P4TC_FILTER_OP], extack);
+}
+
+static int
+p4tc_filter_act_param(struct p4tc_act_param *entry_act_param,
+		      struct p4tc_act_param *filter_act_param)
+{
+	return p4t_cmp(NULL, entry_act_param->type, entry_act_param->value,
+		       NULL, filter_act_param->type, filter_act_param->value);
+}
+
+static bool p4tc_filter_cmp_op(u16 op_value, int cmp)
+{
+	switch (op_value) {
+	case P4TC_FILTER_OP_KIND_REL_EQ:
+		return !cmp;
+	case P4TC_FILTER_OP_KIND_REL_NEQ:
+		return !!cmp;
+	case P4TC_FILTER_OP_KIND_REL_LT:
+		return cmp < 0;
+	case P4TC_FILTER_OP_KIND_REL_GT:
+		return cmp > 0;
+	case P4TC_FILTER_OP_KIND_REL_LE:
+		return cmp <= 0;
+	case P4TC_FILTER_OP_KIND_REL_GE:
+		return cmp >= 0;
+	default:
+		return false;
+	}
+}
+
+static bool
+p4tc_filter_act_params(struct p4tc_filter_oper *filter_oper,
+		       struct tcf_p4act_params *entry_act_params,
+		       struct p4tc_act_param *filter_act_param)
+{
+	struct idr *entry_act_params_idr = &entry_act_params->params_idr;
+	struct p4tc_act_param *entry_act_param;
+	int cmp;
+
+	entry_act_param = p4a_parm_find_byid(entry_act_params_idr,
+					     filter_act_param->id);
+	if (!entry_act_param)
+		return false;
+
+	cmp = p4tc_filter_act_param(entry_act_param,
+				    filter_act_param);
+	return p4tc_filter_cmp_op(filter_oper->op_value, cmp);
+}
+
+static bool
+p4tc_filter_exec_act(struct p4tc_filter_oper *filter_oper,
+		     struct p4tc_table_entry_value *value,
+		     struct p4tc_filter_opnd_entry *filter_opnd)
+{
+	struct tcf_p4act *p4act;
+
+	if (!filter_opnd)
+		return true;
+
+	if (!value->acts[0])
+		return false;
+
+	p4act = to_p4act(value->acts[0]);
+	if (filter_opnd->act.val->a_id != p4act->act_id)
+		return false;
+
+	if (filter_opnd->opnd_kind == P4TC_FILTER_OPND_ENTRY_KIND_ACT_PARAM) {
+		struct tcf_p4act_params *params;
+
+		params = rcu_dereference(p4act->params);
+		return p4tc_filter_act_params(filter_oper, params,
+					      filter_opnd->act.param);
+	}
+
+	return true;
+}
+
+static bool
+p4tc_filter_exec_opnd_entry(struct p4tc_filter_oper *filter_oper,
+			    struct p4tc_table_entry *entry,
+			    struct p4tc_filter_opnd_entry *opnd_entry)
+{
+	switch (opnd_entry->opnd_kind) {
+	case P4TC_FILTER_OPND_ENTRY_KIND_KEY: {
+		u8 key[BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = {0};
+		u32 keysz;
+		int cmp;
+
+		keysz = BITS_TO_BYTES(entry->key.keysz);
+		p4tc_tbl_entry_mask_key(key, entry->key.fa_key,
+					opnd_entry->entry_key.mask, keysz);
+
+		cmp = memcmp(key, opnd_entry->entry_key.val, keysz);
+		return p4tc_filter_cmp_op(filter_oper->op_value, cmp);
+	}
+	case P4TC_FILTER_OPND_ENTRY_KIND_ACT:
+	case P4TC_FILTER_OPND_ENTRY_KIND_ACT_PARAM:
+		return p4tc_filter_exec_act(filter_oper,
+					     p4tc_table_entry_value(entry),
+					     opnd_entry);
+	case P4TC_FILTER_OPND_ENTRY_KIND_PRIO: {
+		struct p4tc_table_entry_value *value;
+
+		value = p4tc_table_entry_value(entry);
+		switch (filter_oper->op_value) {
+		case P4TC_FILTER_OP_KIND_REL_EQ:
+			return value->prio == opnd_entry->prio;
+		case P4TC_FILTER_OP_KIND_REL_NEQ:
+			return value->prio != opnd_entry->prio;
+		case P4TC_FILTER_OP_KIND_REL_LT:
+			return value->prio < opnd_entry->prio;
+		case P4TC_FILTER_OP_KIND_REL_GT:
+			return value->prio > opnd_entry->prio;
+		case P4TC_FILTER_OP_KIND_REL_LE:
+			return value->prio <= opnd_entry->prio;
+		case P4TC_FILTER_OP_KIND_REL_GE:
+			return value->prio >= opnd_entry->prio;
+		default:
+			return false;
+		}
+	}
+	case P4TC_FILTER_OPND_ENTRY_KIND_MSECS: {
+		struct p4tc_table_entry_value *value;
+		unsigned long jiffy_since;
+		unsigned long last_used;
+
+		jiffy_since = jiffies -
+			msecs_to_jiffies(opnd_entry->msecs_since);
+
+		value = p4tc_table_entry_value(entry);
+		last_used = rcu_dereference(value->tm)->lastused;
+
+		switch (filter_oper->op_value) {
+		case P4TC_FILTER_OP_KIND_REL_EQ:
+			return jiffy_since == last_used;
+		case P4TC_FILTER_OP_KIND_REL_NEQ:
+			return jiffy_since != last_used;
+		case P4TC_FILTER_OP_KIND_REL_LT:
+			return time_before(jiffy_since, last_used);
+		case P4TC_FILTER_OP_KIND_REL_GT:
+			return time_after(jiffy_since, last_used);
+		case P4TC_FILTER_OP_KIND_REL_LE:
+			return time_before_eq(jiffy_since, last_used);
+		case P4TC_FILTER_OP_KIND_REL_GE:
+			return time_after_eq(jiffy_since, last_used);
+		default:
+			/* Will never happen */
+			return false;
+		}
+	}
+	default:
+		return false;
+	}
+}
+
+static bool
+p4tc_filter_exec_opnd(struct p4tc_filter_oper *filter_oper,
+		      struct p4tc_table_entry *entry,
+		      struct p4tc_filter_opnd *filter_opnd)
+{
+	switch (filter_opnd->obj_id) {
+	case P4TC_FILTER_OBJ_RUNTIME_TABLE:
+		return p4tc_filter_exec_opnd_entry(filter_oper, entry,
+						   &filter_opnd->opnd_entry);
+	default:
+		return false;
+	}
+}
+
+static bool p4tc_filter_exec_oper(struct p4tc_filter_oper *filter_oper,
+				  struct p4tc_table_entry *entry);
+
+static bool p4tc_filter_exec_node(struct p4tc_filter_oper *filter_oper,
+				  struct p4tc_table_entry *entry,
+				  struct p4tc_filter_node *node)
+{
+	if (node->ntype == P4TC_FILTER_OP_NODE_PARENT)
+		return p4tc_filter_exec_oper(node->operation, entry);
+
+	return p4tc_filter_exec_opnd(filter_oper, entry, node->opnd);
+}
+
+static bool
+p4tc_filter_exec_oper_logical(struct p4tc_filter_oper *filter_oper,
+			      struct p4tc_table_entry *entry)
+{
+	bool ret;
+
+	ret = p4tc_filter_exec_node(filter_oper, entry, filter_oper->node1);
+
+	switch (filter_oper->op_value) {
+	case P4TC_FILTER_OP_KIND_LOGICAL_AND:
+		return ret && p4tc_filter_exec_node(filter_oper, entry,
+						    filter_oper->node2);
+	case P4TC_FILTER_OP_KIND_LOGICAL_OR:
+		return ret || p4tc_filter_exec_node(filter_oper, entry,
+						    filter_oper->node2);
+	case P4TC_FILTER_OP_KIND_LOGICAL_NOT:
+		return !ret;
+	case P4TC_FILTER_OP_KIND_LOGICAL_XOR:
+		return ret != p4tc_filter_exec_node(filter_oper, entry,
+						    filter_oper->node2);
+	default:
+		/* Never happens */
+		return false;
+	}
+}
+
+static bool
+p4tc_filter_exec_oper_rel(struct p4tc_filter_oper *filter_oper,
+			  struct p4tc_table_entry *entry)
+{
+	return p4tc_filter_exec_node(filter_oper, entry,
+				     filter_oper->node1);
+}
+
+static bool
+p4tc_filter_exec_oper(struct p4tc_filter_oper *filter_oper,
+		      struct p4tc_table_entry *entry)
+{
+	switch (filter_oper->op_kind) {
+	case P4TC_FILTER_OP_KIND_REL:
+		return p4tc_filter_exec_oper_rel(filter_oper, entry);
+	case P4TC_FILTER_OP_KIND_LOGICAL:
+		return p4tc_filter_exec_oper_logical(filter_oper, entry);
+	default:
+		return false;
+	}
+}
+
+bool p4tc_filter_exec(struct p4tc_filter *filter,
+		      struct p4tc_table_entry *entry)
+{
+	if (!filter)
+		return true;
+
+	return p4tc_filter_exec_oper(filter->operation, entry);
+}
diff --git a/net/sched/p4tc/p4tc_runtime_api.c b/net/sched/p4tc/p4tc_runtime_api.c
index d80103d364..44239cb228 100644
--- a/net/sched/p4tc/p4tc_runtime_api.c
+++ b/net/sched/p4tc/p4tc_runtime_api.c
@@ -56,6 +56,21 @@ static int tc_ctl_p4_root(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
 	}
 }
 
+static int tc_ctl_p4_get(struct sk_buff *skb, struct nlmsghdr *n,
+			 struct netlink_ext_ack *extack)
+{
+	return tc_ctl_p4_root(skb, n, RTM_P4TC_GET, extack);
+}
+
+static int tc_ctl_p4_delete(struct sk_buff *skb, struct nlmsghdr *n,
+			    struct netlink_ext_ack *extack)
+{
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	return tc_ctl_p4_root(skb, n, RTM_P4TC_DEL, extack);
+}
+
 static int tc_ctl_p4_cu(struct sk_buff *skb, struct nlmsghdr *n,
 			struct netlink_ext_ack *extack)
 {
@@ -69,12 +84,60 @@ static int tc_ctl_p4_cu(struct sk_buff *skb, struct nlmsghdr *n,
 	return ret;
 }
 
+static int tc_ctl_p4_dump(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
+	struct p4tcmsg *t;
+	int ret = 0;
+
+	/* Dump is always called with the nlk->cb_mutex held.
+	 * In rtnl this mutex is set to rtnl_lock, which makes dump,
+	 * even for table entries, to serialized over the rtnl_lock.
+	 *
+	 * For table entries, it guarantees the net namespace is alive.
+	 * For externs, we don't need to lock the rtnl_lock.
+	 */
+	ASSERT_RTNL();
+
+	ret = nlmsg_parse(cb->nlh, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, cb->extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(cb->extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(cb->extack,
+			       "Netlink P4TC Runtime attributes missing");
+		return -EINVAL;
+	}
+
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	t = nlmsg_data(cb->nlh);
+
+	switch (t->obj) {
+	case P4TC_OBJ_RUNTIME_TABLE:
+		return p4tc_tbl_entry_dumpit(sock_net(skb->sk), skb, cb,
+					     tb[P4TC_ROOT], p_name);
+	default:
+		NL_SET_ERR_MSG_FMT(cb->extack,
+				   "Unknown p4 runtime object type %u\n",
+				   t->obj);
+		return -ENOENT;
+	}
+}
+
 static int __init p4tc_tbl_init(void)
 {
 	rtnl_register(PF_UNSPEC, RTM_P4TC_CREATE, tc_ctl_p4_cu, NULL,
 		      RTNL_FLAG_DOIT_UNLOCKED);
 	rtnl_register(PF_UNSPEC, RTM_P4TC_UPDATE, tc_ctl_p4_cu, NULL,
 		      RTNL_FLAG_DOIT_UNLOCKED);
+	rtnl_register(PF_UNSPEC, RTM_P4TC_DEL, tc_ctl_p4_delete, NULL,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+	rtnl_register(PF_UNSPEC, RTM_P4TC_GET, tc_ctl_p4_get, tc_ctl_p4_dump,
+		      RTNL_FLAG_DOIT_UNLOCKED);
 
 	return 0;
 }
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index ab5cd0f62c..588d22cc48 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -106,6 +106,11 @@ int p4tc_table_try_set_state_ready(struct p4tc_pipeline *pipeline,
 	return ret;
 }
 
+static const struct netlink_range_validation aging_range = {
+	.min = 1,
+	.max = P4TC_MAX_T_AGING_MS,
+};
+
 static const struct netlink_range_validation keysz_range = {
 	.min = 1,
 	.max = P4TC_MAX_KEYSZ,
@@ -290,7 +295,7 @@ static int _p4tc_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
 
 		entry_nest = nla_nest_start(skb, P4TC_TABLE_ENTRY);
 		if (p4tc_tbl_entry_fill(skb, table, table->tbl_entry,
-					table->tbl_id) < 0)
+					table->tbl_id, P4TC_ENTITY_UNSPEC) < 0)
 			goto out_nlmsg_trim;
 
 		nla_nest_end(skb, entry_nest);
@@ -363,6 +368,112 @@ static void p4tc_table_timer_profiles_destroy(struct p4tc_table *table)
 	mutex_unlock(&table->tbl_profiles_xa_lock);
 }
 
+static const struct nla_policy
+p4tc_timer_profile_policy[P4TC_TIMER_PROFILE_MAX + 1] = {
+	[P4TC_TIMER_PROFILE_ID] =
+		NLA_POLICY_RANGE(NLA_U32, 0, P4TC_MAX_NUM_TIMER_PROFILES),
+	[P4TC_TIMER_PROFILE_AGING] =
+		NLA_POLICY_FULL_RANGE(NLA_U64, &aging_range),
+};
+
+struct p4tc_table_timer_profile *
+p4tc_table_timer_profile_find_byaging(struct p4tc_table *table, u64 aging_ms)
+__must_hold(RCU)
+{
+	struct p4tc_table_timer_profile *timer_profile;
+	unsigned long profile_id;
+
+	xa_for_each(&table->tbl_profiles_xa, profile_id, timer_profile) {
+		if (timer_profile->aging_ms == aging_ms)
+			return timer_profile;
+	}
+
+	return NULL;
+}
+
+struct p4tc_table_timer_profile *
+p4tc_table_timer_profile_find(struct p4tc_table *table, u32 profile_id)
+__must_hold(RCU)
+{
+	return xa_load(&table->tbl_profiles_xa, profile_id);
+}
+
+/* This function will be exercised via a runtime command.
+ * Note that two profile IDs can't have the same aging value
+ */
+int p4tc_table_timer_profile_update(struct p4tc_table *table,
+				    struct nlattr *nla,
+				    struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_timer_profile *old_timer_profile;
+	struct p4tc_table_timer_profile *timer_profile;
+	struct nlattr *tb[P4TC_TIMER_PROFILE_MAX + 1];
+	u32 profile_id;
+	u64 aging_ms;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TIMER_PROFILE_MAX, nla,
+			       p4tc_timer_profile_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (!tb[P4TC_TIMER_PROFILE_ID]) {
+		NL_SET_ERR_MSG(extack, "Must specify table profile ID");
+		return -EINVAL;
+	}
+	profile_id = nla_get_u32(tb[P4TC_TIMER_PROFILE_ID]);
+
+	if (!tb[P4TC_TIMER_PROFILE_AGING]) {
+		NL_SET_ERR_MSG(extack, "Must specify table profile aging");
+		return -EINVAL;
+	}
+	aging_ms = nla_get_u64(tb[P4TC_TIMER_PROFILE_AGING]);
+
+	rcu_read_lock();
+	timer_profile = p4tc_table_timer_profile_find_byaging(table,
+							      aging_ms);
+	if (timer_profile && timer_profile->profile_id != profile_id) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Aging %llu was already specified by profile ID %u",
+				   aging_ms, timer_profile->profile_id);
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+
+	timer_profile = kzalloc(sizeof(*timer_profile), GFP_KERNEL);
+	if (unlikely(!timer_profile))
+		return -ENOMEM;
+
+	timer_profile->profile_id = profile_id;
+	timer_profile->aging_ms = aging_ms;
+
+	mutex_lock(&table->tbl_profiles_xa_lock);
+	old_timer_profile = xa_load(&table->tbl_profiles_xa, profile_id);
+	if (!old_timer_profile) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Unable to find timer profile with ID %u\n",
+				   profile_id);
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	old_timer_profile = xa_cmpxchg(&table->tbl_profiles_xa,
+				       timer_profile->profile_id,
+				       old_timer_profile,
+				       timer_profile, GFP_KERNEL);
+	kfree_rcu(old_timer_profile, rcu);
+	mutex_unlock(&table->tbl_profiles_xa_lock);
+
+	return 0;
+
+unlock:
+	mutex_unlock(&table->tbl_profiles_xa_lock);
+
+	kfree(timer_profile);
+	return ret;
+}
+
 /* From the template, the user may only specify the number of timer profiles
  * they want for the table. If this number is not specified during the table
  * creation command, the kernel will create 4 timer profiles:
@@ -614,11 +725,6 @@ struct p4tc_table *p4tc_table_find_byany(struct p4tc_pipeline *pipeline,
 	return ERR_PTR(err);
 }
 
-static int p4tc_table_get(struct p4tc_table *table)
-{
-	return refcount_inc_not_zero(&table->tbl_ctrl_ref);
-}
-
 struct p4tc_table *p4tc_table_find_get(struct p4tc_pipeline *pipeline,
 				       const char *tblname, const u32 tbl_id,
 				       struct netlink_ext_ack *extack)
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index da211418bc..6e24014b22 100644
--- a/net/sched/p4tc/p4tc_tbl_entry.c
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -38,11 +38,21 @@
  * whether a delete is happening in parallel.
  */
 
+static int p4tc_tbl_entry_get(struct p4tc_table_entry_value *value)
+{
+	return refcount_inc_not_zero(&value->entries_ref);
+}
+
 static bool p4tc_tbl_entry_put(struct p4tc_table_entry_value *value)
 {
 	return refcount_dec_if_one(&value->entries_ref);
 }
 
+static bool p4tc_tbl_entry_put_ref(struct p4tc_table_entry_value *value)
+{
+	return refcount_dec_not_one(&value->entries_ref);
+}
+
 static u32 p4tc_entry_hash_fn(const void *data, u32 len, u32 seed)
 {
 	const struct p4tc_table_entry_key *key = data;
@@ -133,6 +143,15 @@ p4tc_entry_lookup(struct p4tc_table *table, struct p4tc_table_entry_key *key,
 	return NULL;
 }
 
+void p4tc_tbl_entry_mask_key(u8 *masked_key, u8 *key, const u8 *mask,
+			     u32 masksz)
+{
+	int i;
+
+	for (i = 0; i < masksz; i++)
+		masked_key[i] = key[i] & mask[i];
+}
+
 #define p4tc_table_entry_mask_find_byid(table, id) \
 	(idr_find(&(table)->tbl_masks_idr, id))
 
@@ -201,7 +220,8 @@ static void p4tc_table_entry_tm_dump(struct p4tc_table_entry_tm *dtm,
 #define P4TC_ENTRY_MAX_IDS (P4TC_PATH_MAX - 1)
 
 int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
-			struct p4tc_table_entry *entry, u32 tbl_id)
+			struct p4tc_table_entry *entry, u32 tbl_id,
+			u16 who_deleted)
 {
 	unsigned char *b = nlmsg_get_pos(skb);
 	struct p4tc_table_entry_value *value;
@@ -248,11 +268,28 @@ int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
 			goto out_nlmsg_trim;
 	}
 
+	if (who_deleted) {
+		if (nla_put_u8(skb, P4TC_ENTRY_DELETE_WHODUNNIT,
+			       who_deleted))
+			goto out_nlmsg_trim;
+	}
+
 	p4tc_table_entry_tm_dump(&dtm, tm);
 	if (nla_put_64bit(skb, P4TC_ENTRY_TM, sizeof(dtm), &dtm,
 			  P4TC_ENTRY_PAD))
 		goto out_nlmsg_trim;
 
+	if (value->is_dyn) {
+		if (nla_put_u8(skb, P4TC_ENTRY_DYNAMIC, 1))
+			goto out_nlmsg_trim;
+
+		if (value->aging_ms) {
+			if (nla_put_u64_64bit(skb, P4TC_ENTRY_AGING,
+					      value->aging_ms, P4TC_ENTRY_PAD))
+				goto out_nlmsg_trim;
+		}
+	}
+
 	if (value->tmpl_created) {
 		if (nla_put_u8(skb, P4TC_ENTRY_TMPL_CREATED, 1))
 			goto out_nlmsg_trim;
@@ -267,6 +304,11 @@ int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
 	return ret;
 }
 
+static struct netlink_range_validation range_aging = {
+	.min = 1,
+	.max = P4TC_MAX_T_AGING_MS,
+};
+
 static const struct nla_policy p4tc_entry_policy[P4TC_ENTRY_MAX + 1] = {
 	[P4TC_ENTRY_TBLNAME] = { .type = NLA_STRING },
 	[P4TC_ENTRY_KEY_BLOB] = { .type = NLA_BINARY },
@@ -281,6 +323,11 @@ static const struct nla_policy p4tc_entry_policy[P4TC_ENTRY_MAX + 1] = {
 	[P4TC_ENTRY_DELETE_WHODUNNIT] = { .type = NLA_U8 },
 	[P4TC_ENTRY_PERMISSIONS] = NLA_POLICY_MAX(NLA_U16, P4TC_MAX_PERMISSION),
 	[P4TC_ENTRY_TBL_ATTRS] = { .type = NLA_NESTED },
+	[P4TC_ENTRY_DYNAMIC] = NLA_POLICY_RANGE(NLA_U8, 1, 1),
+	[P4TC_ENTRY_AGING] = NLA_POLICY_FULL_RANGE(NLA_U64, &range_aging),
+	[P4TC_ENTRY_PROFILE_ID] =
+		NLA_POLICY_RANGE(NLA_U32, 0, P4TC_MAX_NUM_TIMER_PROFILES - 1),
+	[P4TC_ENTRY_FILTER] = { .type = NLA_NESTED },
 };
 
 static struct p4tc_table_entry_mask *
@@ -585,6 +632,7 @@ p4tc_tbl_entry_emit_event(struct p4tc_table_entry_work *entry_work,
 	struct p4tc_pipeline *pipeline = entry_work->pipeline;
 	struct p4tc_table_entry *entry = entry_work->entry;
 	struct p4tc_table *table = entry_work->table;
+	u16 who_deleted = entry_work->who_deleted;
 	struct net *net = pipeline->net;
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
@@ -602,13 +650,17 @@ p4tc_tbl_entry_emit_event(struct p4tc_table_entry_work *entry_work,
 		goto free_skb;
 
 	nest = nla_nest_start(skb, 1);
-	if (p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id) < 0)
+	if (p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id,
+				who_deleted) < 0)
 		goto free_skb;
 	nla_nest_end(skb, nest);
 	nla_nest_end(skb, root);
 
 	nlmsg_end(skb, nlh);
 
+	if (cmd == RTM_P4TC_GET)
+		return rtnl_unicast(skb, net, portid);
+
 	err = nlmsg_notify(net->rtnl, skb, portid, RTNLGRP_TC, echo,
 			   GFP_ATOMIC);
 	if (!err)
@@ -650,6 +702,9 @@ static void p4tc_table_entry_del_work(struct work_struct *work)
 		p4tc_tbl_entry_emit_event(entry_work, 0, RTM_P4TC_DEL,
 					  0, false, true);
 
+	if (value->is_dyn)
+		hrtimer_cancel(&value->entry_timer);
+
 	put_net(pipeline->net);
 	p4tc_pipeline_put_ref(pipeline);
 
@@ -672,6 +727,9 @@ static void p4tc_table_entry_put(struct p4tc_table_entry *entry, bool deferred)
 		get_net(pipeline->net); /* avoid action cleanup */
 		schedule_work(&entry_work->work);
 	} else {
+		if (value->is_dyn)
+			hrtimer_cancel(&value->entry_timer);
+
 		__p4tc_table_entry_put(entry);
 	}
 }
@@ -950,6 +1008,408 @@ static void p4tc_table_entry_build_key(struct p4tc_table *table,
 		key->fa_key[i] &= mask->fa_value[i];
 }
 
+static int
+___p4tc_table_entry_del(struct p4tc_table *table,
+			struct p4tc_table_entry *entry,
+			bool from_control)
+__must_hold(RCU)
+{
+	struct p4tc_table_entry_value *value = p4tc_table_entry_value(entry);
+
+	if (from_control) {
+		if (!p4tc_ctrl_delete_ok(value->permissions))
+			return -EPERM;
+	} else {
+		if (!p4tc_data_delete_ok(value->permissions))
+			return -EPERM;
+	}
+
+	if (p4tc_table_entry_destroy(table, entry, true, !from_control,
+				     P4TC_ENTITY_KERNEL) < 0)
+		return -EBUSY;
+
+	return 0;
+}
+
+#define RET_EVENT_FAILED 1
+
+static int
+p4tc_table_entry_gd(struct net *net,
+		    struct nlmsghdr *n, struct nlattr *arg,
+		    struct p4tc_path_nlattrs *nl_path_attrs,
+		    const u32 portid,
+		    struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_get_state table_get_state = { NULL };
+	struct p4tc_table_entry_mask *mask = NULL, *new_mask;
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	bool get = n->nlmsg_type == RTM_P4TC_GET;
+	struct p4tc_table_entry *entry = NULL;
+	struct p4tc_pipeline *pipeline = NULL;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry_key *key;
+	u32 *ids = nl_path_attrs->ids;
+	bool has_listener = !!portid;
+	struct p4tc_table *table;
+	int cmd = n->nlmsg_type;
+	u16 who_deleted = 0;
+	bool del = !get;
+	u32 keysz_bytes;
+	u32 keysz_bits;
+	u32 prio;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg, p4tc_entry_policy,
+			       extack);
+	if (ret < 0)
+		return ret;
+
+	ret = p4tc_table_entry_get_table(net, cmd, &table_get_state, tb,
+					 nl_path_attrs, extack);
+	if (ret < 0)
+		return ret;
+
+	pipeline = table_get_state.pipeline;
+	table = table_get_state.table;
+
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT) {
+		prio = p4tc_table_entry_exact_prio();
+	} else {
+		if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_ENTRY_PRIO)) {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify table entry priority");
+			return -EINVAL;
+		}
+		prio = nla_get_u32(tb[P4TC_ENTRY_PRIO]);
+	}
+
+	keysz_bits = table->tbl_keysz;
+	keysz_bytes = P4TC_KEYSZ_BYTES(table->tbl_keysz);
+
+	key = kzalloc(struct_size(key, fa_key, keysz_bytes),
+		      GFP_KERNEL_ACCOUNT);
+	if (unlikely(!key)) {
+		NL_SET_ERR_MSG(extack, "Unable to allocate key");
+		ret = -ENOMEM;
+		goto table_put;
+	}
+
+	key->keysz = keysz_bits;
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT) {
+		mask = kzalloc(struct_size(mask, fa_value, keysz_bytes),
+			       GFP_KERNEL_ACCOUNT);
+		if (unlikely(!mask)) {
+			NL_SET_ERR_MSG(extack, "Failed to allocate mask");
+			ret = -ENOMEM;
+			goto free_key;
+		}
+		mask->sz = key->keysz;
+	}
+
+	ret = p4tc_table_entry_extract_key(table, tb, key, mask, extack);
+	if (unlikely(ret < 0)) {
+		if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+			kfree(mask);
+
+		goto free_key;
+	}
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT) {
+		new_mask = p4tc_table_entry_mask_find_byvalue(table, mask);
+		kfree(mask);
+		if (!new_mask) {
+			NL_SET_ERR_MSG(extack, "Unable to find entry mask");
+			ret = -ENOENT;
+			goto free_key;
+		} else {
+			mask = new_mask;
+		}
+	}
+
+	p4tc_table_entry_build_key(table, key, mask);
+
+	rcu_read_lock();
+	entry = p4tc_entry_lookup(table, key, prio);
+	if (!entry) {
+		NL_SET_ERR_MSG(extack, "Unable to find entry");
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	/* As we can run delete/update in parallel we might get a soon to be
+	 * purged entry from the lookup
+	 */
+	value = p4tc_table_entry_value(entry);
+	if (get && !p4tc_tbl_entry_get(value)) {
+		NL_SET_ERR_MSG(extack, "Entry deleted in parallel");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (del) {
+		if (tb[P4TC_ENTRY_WHODUNNIT])
+			who_deleted = nla_get_u8(tb[P4TC_ENTRY_WHODUNNIT]);
+	} else {
+		if (!p4tc_ctrl_read_ok(value->permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to read table entry");
+			ret = -EPERM;
+			goto entry_put;
+		}
+	}
+
+	if (has_listener) {
+		struct p4tc_table_entry_work *entry_work =
+			value->entry_work;
+		const bool echo = n->nlmsg_flags & NLM_F_ECHO;
+
+		if (p4tc_ctrl_pub_ok(value->permissions)) {
+			if (del)
+				entry_work->who_deleted = who_deleted;
+
+			ret = p4tc_tbl_entry_emit_event(entry_work, portid, cmd,
+							n->nlmsg_seq, echo,
+							false);
+			if (ret < 0)
+				ret = RET_EVENT_FAILED;
+		} else {
+			if (get) {
+				NL_SET_ERR_MSG(extack,
+					       "Unable to publish read entry");
+				ret = -EPERM;
+				goto entry_put;
+			}
+		}
+	}
+
+	if (del) {
+		ret = ___p4tc_table_entry_del(table, entry, true);
+		if (ret < 0) {
+			if (ret == -EBUSY)
+				NL_SET_ERR_MSG(extack,
+					       "Entry was deleted in parallel");
+			goto entry_put;
+		}
+
+		if (!has_listener) {
+			ret = 0;
+			goto entry_put;
+		}
+	}
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			P4TC_PIPELINE_NAMSIZ);
+
+entry_put:
+	if (get)
+		p4tc_tbl_entry_put_ref(value);
+
+unlock:
+	rcu_read_unlock();
+
+free_key:
+	kfree(key);
+
+table_put:
+	p4tc_table_entry_put_table(&table_get_state);
+
+	return ret;
+}
+
+static int p4tc_table_entry_flush(struct net *net,
+				  struct nlmsghdr *n,
+				  struct nlattr *arg,
+				  struct p4tc_path_nlattrs *nl_path_attrs,
+				  const u32 portid,
+				  struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_get_state table_get_state = { NULL};
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	struct p4tc_filter_context filter_ctx = { NULL };
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table_entry *entry;
+	bool has_listener = !!portid;
+	struct rhashtable_iter iter;
+	struct p4tc_filter *filter;
+	struct p4tc_table *table;
+	struct sk_buff *skb;
+	int fails = 0;
+	int ret = 0;
+	int i = 0;
+
+	if (arg) {
+		ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg,
+				       p4tc_entry_policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = p4tc_table_entry_get_table(net, RTM_P4TC_DEL, &table_get_state,
+					 tb, nl_path_attrs, extack);
+	if (ret < 0)
+		return ret;
+
+	if (!has_listener) {
+		if (tb[P4TC_ENTRY_FILTER]) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Can't specify filter attributes without a listener");
+			ret = -EINVAL;
+			goto table_put;
+		}
+	}
+
+	pipeline = table_get_state.pipeline;
+	table = table_get_state.table;
+
+	filter_ctx.pipeline = pipeline;
+	filter_ctx.table = table;
+	filter_ctx.obj_id = P4TC_FILTER_OBJ_RUNTIME_TABLE;
+	filter = p4tc_filter_build(&filter_ctx, tb[P4TC_ENTRY_FILTER], extack);
+	if (IS_ERR(filter)) {
+		ret = PTR_ERR(filter);
+		goto table_put;
+	}
+
+	/* There is an issue here regarding the stability of walking an
+	 * rhashtable. If an insert or a delete happens in parallel, we may see
+	 * duplicate entries or skip some valid entries. To solve this we are
+	 * going to have an auxiliary list that also stores the entries and will
+	 * be used for flushing, instead of walking over the rhastable.
+	 */
+	rhltable_walk_enter(&table->tbl_entries, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		while ((entry = rhashtable_walk_next(&iter)) &&
+		       !IS_ERR(entry)) {
+			struct p4tc_table_entry_value *value =
+				p4tc_table_entry_value(entry);
+
+			if (!p4tc_ctrl_delete_ok(value->permissions)) {
+				ret = -EPERM;
+				fails++;
+				continue;
+			}
+
+			if (!p4tc_filter_exec(filter, entry))
+				continue;
+
+			ret = p4tc_table_entry_destroy(table, entry, true,
+						       false,
+						       P4TC_ENTITY_UNSPEC);
+			if (ret < 0) {
+				fails++;
+				continue;
+			}
+
+			i++;
+		}
+
+		rhashtable_walk_stop(&iter);
+	} while (entry == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&iter);
+
+	/* If another user creates a table entry in parallel with this flush,
+	 * we may not be able to flush all the entries. So the user should
+	 * verify after flush to check for this.
+	 */
+
+	if (fails) {
+		if (i == 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush any entries");
+			ret = -EINVAL;
+			goto filter_destroy;
+		} else {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Flushed %u table entries and %u failed",
+					   i, fails);
+		}
+	}
+
+	if (has_listener) {
+		struct nlmsghdr *nlh;
+		struct nlattr *root;
+		struct nlattr *nest;
+
+		skb = alloc_and_fill_root_attrs(&nlh, pipeline, portid,
+						n->nlmsg_seq, n->nlmsg_type,
+						GFP_KERNEL);
+
+		root = nla_nest_start(skb, P4TC_ROOT);
+		if (!root)
+			goto free_skb;
+
+		nest = nla_nest_start(skb, 1);
+
+		if (nla_put_u32(skb, P4TC_PATH, table->tbl_id))
+			goto free_skb;
+
+		if (nla_put_u32(skb, P4TC_COUNT, i))
+			goto free_skb;
+
+		nla_nest_end(skb, nest);
+		nla_nest_end(skb, root);
+		nlmsg_end(skb, nlh);
+
+		ret = nlmsg_notify(pipeline->net->rtnl, skb, portid, RTNLGRP_TC,
+				   n->nlmsg_flags & NLM_F_ECHO, GFP_KERNEL);
+		if (ret < 0)
+			NL_SET_ERR_MSG(extack,
+				       "Unable to send flush netlink event");
+	}
+
+	ret = 0;
+	goto filter_destroy;
+
+free_skb:
+	kfree_skb(skb);
+
+filter_destroy:
+	p4tc_filter_destroy(filter);
+
+table_put:
+	p4tc_table_entry_put_table(&table_get_state);
+
+	return ret;
+}
+
+static enum hrtimer_restart entry_timer_handle(struct hrtimer *timer)
+{
+	struct p4tc_table_entry_value *value =
+		container_of(timer, struct p4tc_table_entry_value, entry_timer);
+	struct p4tc_table_entry_tm *tm;
+	struct p4tc_table_entry *entry;
+	u64 aging_ms = value->aging_ms;
+	struct p4tc_table *table;
+	u64 tdiff, lastused;
+
+	rcu_read_lock();
+	tm = rcu_dereference(value->tm);
+	lastused = tm->lastused;
+	rcu_read_unlock();
+
+	tdiff = jiffies64_to_msecs(get_jiffies_64() - lastused);
+
+	if (tdiff < aging_ms) {
+		hrtimer_forward_now(timer, ms_to_ktime(aging_ms));
+		return HRTIMER_RESTART;
+	}
+
+	entry = value->entry_work->entry;
+	table = value->entry_work->table;
+
+	p4tc_table_entry_destroy(table, entry, true,
+				 true, P4TC_ENTITY_TIMER);
+
+	return HRTIMER_NORESTART;
+}
+
 static struct p4tc_table_entry_tm *
 p4tc_table_entry_create_tm(const u16 whodunnit)
 {
@@ -1050,6 +1510,14 @@ __must_hold(RCU)
 		goto free_work;
 	}
 
+	if (value->is_dyn) {
+		hrtimer_init(&value->entry_timer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL);
+		value->entry_timer.function = &entry_timer_handle;
+		hrtimer_start(&value->entry_timer, ms_to_ktime(value->aging_ms),
+			      HRTIMER_MODE_REL);
+	}
+
 	if (!from_control && p4tc_ctrl_pub_ok(value->permissions))
 		p4tc_tbl_entry_emit_event(entry_work, 0, RTM_P4TC_CREATE, 0,
 					  false, GFP_ATOMIC);
@@ -1159,6 +1627,20 @@ __must_hold(RCU)
 	entry_work->table = table;
 	entry_work->entry = entry;
 	value->entry_work = entry_work;
+	if (!value->is_dyn)
+		value->is_dyn = value_old->is_dyn;
+
+	if (value->is_dyn) {
+		/* Only use old entry value if user didn't specify new one */
+		value->aging_ms = value->aging_ms ?: value_old->aging_ms;
+
+		hrtimer_init(&value->entry_timer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL);
+		value->entry_timer.function = &entry_timer_handle;
+
+		hrtimer_start(&value->entry_timer, ms_to_ktime(value->aging_ms),
+			      HRTIMER_MODE_REL);
+	}
 
 	INIT_WORK(&entry_work->work, p4tc_table_entry_del_work);
 
@@ -1236,6 +1718,7 @@ p4tc_table_attrs_policy[P4TC_ENTRY_TBL_ATTRS_MAX + 1] = {
 	[P4TC_ENTRY_TBL_ATTRS_DEFAULT_MISS] = { .type = NLA_NESTED },
 	[P4TC_ENTRY_TBL_ATTRS_PERMISSIONS] =
 		NLA_POLICY_MAX(NLA_U16, P4TC_MAX_PERMISSION),
+	[P4TC_ENTRY_TBL_ATTRS_TIMER_PROFILE] = { .type = NLA_NESTED },
 };
 
 static int p4tc_tbl_attrs_update(struct net *net, struct p4tc_table *table,
@@ -1276,11 +1759,23 @@ static int p4tc_tbl_attrs_update(struct net *net, struct p4tc_table *table,
 	if (err < 0)
 		goto free_tbl_perm;
 
+	if (tb[P4TC_ENTRY_TBL_ATTRS_TIMER_PROFILE]) {
+		struct nlattr *attr = tb[P4TC_ENTRY_TBL_ATTRS_TIMER_PROFILE];
+
+		err = p4tc_table_timer_profile_update(table, attr, extack);
+		if (err < 0)
+			goto default_acts_free;
+	}
+
 	p4tc_table_replace_default_acts(table, &dflt, true);
 	p4tc_table_replace_permissions(table, tbl_perm, true);
 
 	return 0;
 
+default_acts_free:
+	p4tc_table_defact_destroy(dflt.hitact);
+	p4tc_table_defact_destroy(dflt.missact);
+
 free_tbl_perm:
 	kfree(tbl_perm);
 	return err;
@@ -1424,6 +1919,75 @@ __p4tc_table_entry_cu(struct net *net, u8 cu_flags, struct nlattr **tb,
 		}
 	}
 
+	if (tb[P4TC_ENTRY_AGING] && tb[P4TC_ENTRY_PROFILE_ID]) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify either aging or profile ID");
+		ret = -EINVAL;
+		goto free_acts;
+	}
+
+	if (!replace) {
+		if (tb[P4TC_ENTRY_AGING] && !tb[P4TC_ENTRY_DYNAMIC]) {
+			NL_SET_ERR_MSG(extack,
+				       "Aging may only be set alongside dynamic");
+			ret = -EINVAL;
+			goto free_acts;
+		}
+		if (tb[P4TC_ENTRY_PROFILE_ID] && !tb[P4TC_ENTRY_DYNAMIC]) {
+			NL_SET_ERR_MSG(extack,
+				       "Profile may only be set alongside dynamic");
+			ret = -EINVAL;
+			goto free_acts;
+		}
+	}
+
+	if (tb[P4TC_ENTRY_DYNAMIC])
+		value->is_dyn = true;
+
+	if (tb[P4TC_ENTRY_AGING]) {
+		u64 aging_ms = nla_get_u64(tb[P4TC_ENTRY_AGING]);
+		struct p4tc_table_timer_profile *timer_profile;
+
+		/* Aging value specified for entry cu(create/update) command
+		 * must match one of the timer profiles. We'll lift this
+		 * requirement for SW only in the future.
+		 */
+		rcu_read_lock();
+		timer_profile = p4tc_table_timer_profile_find_byaging(table,
+								      aging_ms);
+		if (!timer_profile) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Specified aging %llu doesn't match any timer profile",
+					   aging_ms);
+			ret = -EINVAL;
+			rcu_read_unlock();
+			goto free_acts;
+		}
+		rcu_read_unlock();
+		value->aging_ms = aging_ms;
+	} else if (tb[P4TC_ENTRY_PROFILE_ID]) {
+		u32 profile_id = nla_get_u32(tb[P4TC_ENTRY_PROFILE_ID]);
+		struct p4tc_table_timer_profile *timer_profile;
+
+		rcu_read_lock();
+		timer_profile = p4tc_table_timer_profile_find(table,
+							      profile_id);
+		if (!timer_profile) {
+			ret = -ENOENT;
+			rcu_read_unlock();
+			goto free_acts;
+		}
+		value->aging_ms = timer_profile->aging_ms;
+		rcu_read_unlock();
+	} else if (value->is_dyn) {
+		struct p4tc_table_timer_profile *timer_profile;
+
+		rcu_read_lock();
+		timer_profile = p4tc_table_timer_profile_find(table, 0);
+		value->aging_ms = timer_profile->aging_ms;
+		rcu_read_unlock();
+	}
+
 	whodunnit = nla_get_u8(tb[P4TC_ENTRY_WHODUNNIT]);
 
 	rcu_read_lock();
@@ -1466,8 +2030,6 @@ __p4tc_table_entry_cu(struct net *net, u8 cu_flags, struct nlattr **tb,
 	return ERR_PTR(ret);
 }
 
-#define RET_EVENT_FAILED 1
-
 static int
 p4tc_table_entry_cu(struct net *net, struct nlmsghdr *n, struct nlattr *arg,
 		    struct p4tc_path_nlattrs *nl_path_attrs, const u32 portid,
@@ -1595,6 +2157,79 @@ p4tc_tmpl_table_entry_cu(struct net *net, struct nlattr *arg,
 	return entry;
 }
 
+static int p4tc_tbl_entry_get_1(struct net *net,
+				struct nlmsghdr *n, struct nlattr *arg,
+				struct p4tc_path_nlattrs *nl_path_attrs,
+				const u32 portid,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MAX + 1];
+	u32 *arg_ids;
+	int ret = 0;
+
+	ret = nla_parse_nested(tb, P4TC_MAX, arg, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PATH)) {
+		NL_SET_ERR_MSG(extack, "Must specify object path");
+		return -EINVAL;
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PARAMS)) {
+		NL_SET_ERR_MSG(extack, "Must specify parameters");
+		return -EINVAL;
+	}
+
+	arg_ids = nla_data(tb[P4TC_PATH]);
+	memcpy(&nl_path_attrs->ids[P4TC_TBLID_IDX], arg_ids,
+	       nla_len(tb[P4TC_PATH]));
+
+	return p4tc_table_entry_gd(net, n, tb[P4TC_PARAMS],
+				   nl_path_attrs, portid, extack);
+}
+
+static int p4tc_tbl_entry_del_1(struct net *net,
+				struct nlmsghdr *n,
+				struct nlattr *arg,
+				struct p4tc_path_nlattrs *nl_path_attrs,
+				const u32 portid,
+				struct netlink_ext_ack *extack)
+{
+	bool flush = n->nlmsg_flags & NLM_F_ROOT;
+	struct nlattr *tb[P4TC_MAX + 1];
+	u32 *arg_ids;
+	int ret = 0;
+
+	ret = nla_parse_nested(tb, P4TC_MAX, arg, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PATH)) {
+		NL_SET_ERR_MSG(extack, "Must specify object path");
+		return -EINVAL;
+	}
+
+	arg_ids = nla_data(tb[P4TC_PATH]);
+	memcpy(&nl_path_attrs->ids[P4TC_TBLID_IDX], arg_ids,
+	       nla_len(tb[P4TC_PATH]));
+
+	if (flush) {
+		ret = p4tc_table_entry_flush(net, n, tb[P4TC_PARAMS],
+					     nl_path_attrs, portid, extack);
+	} else {
+		if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PARAMS)) {
+			NL_SET_ERR_MSG(extack, "Must specify parameters");
+			return -EINVAL;
+		}
+		ret = p4tc_table_entry_gd(net, n, tb[P4TC_PARAMS],
+					  nl_path_attrs, portid,
+					  extack);
+	}
+
+	return ret;
+}
+
 static int
 p4tc_tbl_entry_cu_1(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
 		    struct p4tc_path_nlattrs *nl_path_attrs, const u32 portid,
@@ -1663,14 +2298,17 @@ static int __p4tc_tbl_entry_root_1(struct net *net, struct sk_buff *skb,
 	ids[P4TC_PID_IDX] = t->pipeid;
 	nl_path_attrs.ids = ids;
 
-	if (cmd == RTM_P4TC_CREATE || cmd == RTM_P4TC_UPDATE) {
+	if (cmd == RTM_P4TC_GET)
+		ret = p4tc_tbl_entry_get_1(net, n, p4tca, &nl_path_attrs,
+					   portid, extack);
+	else if (cmd == RTM_P4TC_CREATE || cmd == RTM_P4TC_UPDATE)
 		ret = p4tc_tbl_entry_cu_1(net, n,
 					  p4tca, &nl_path_attrs,
 					  portid, extack);
-	} else {
-		NL_SET_ERR_MSG_FMT(extack, "Unsupported cmd %u\n", cmd);
-		ret = -EOPNOTSUPP;
-	}
+	else if (cmd == RTM_P4TC_DEL)
+		ret = p4tc_tbl_entry_del_1(net, n,
+					   p4tca, &nl_path_attrs,
+					   portid, extack);
 
 	if (ret < 0)
 		goto free_pname;
@@ -1744,14 +2382,14 @@ static int __p4tc_tbl_entry_root_fast(struct net *net, struct nlmsghdr *n,
 
 	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && p4tca[i]; i++) {
 		if (cmd == RTM_P4TC_CREATE ||
-		    cmd == RTM_P4TC_UPDATE) {
+		    cmd == RTM_P4TC_UPDATE)
 			ret = p4tc_tbl_entry_cu_1(net, n,
 						  p4tca[i], &nl_path_attrs,
 						  0, extack);
-		} else {
-			NL_SET_ERR_MSG_FMT(extack, "Unsupported cmd %u\n", cmd);
-			ret = -EOPNOTSUPP;
-		}
+		else if (cmd == RTM_P4TC_DEL)
+			ret = p4tc_tbl_entry_del_1(net, n, p4tca[i],
+						   &nl_path_attrs, 0,
+						   extack);
 
 		if (ret < 0) {
 			int num_batched = __p4tc_entry_root_num_batched(p4tca);
@@ -1808,7 +2446,7 @@ int p4tc_tbl_entry_root(struct net *net, struct sk_buff *skb,
 
 	listeners = rtnl_has_listeners(net, RTNLGRP_TC);
 
-	if ((echo || listeners))
+	if ((echo || listeners) || cmd == RTM_P4TC_GET)
 		ret = __p4tc_tbl_entry_root(net, skb, n, cmd, p_name, p4tca,
 					    extack);
 	else
@@ -1816,3 +2454,218 @@ int p4tc_tbl_entry_root(struct net *net, struct sk_buff *skb,
 						 extack);
 	return ret;
 }
+
+static void p4tc_table_entry_dump_ctx_destroy(struct p4tc_dump_ctx *ctx)
+{
+	kfree(ctx->iter);
+	if (ctx->entry_filter)
+		p4tc_filter_destroy(ctx->entry_filter);
+}
+
+static int p4tc_table_entry_dump(struct net *net, struct sk_buff *skb,
+				 struct nlattr *arg,
+				 struct p4tc_path_nlattrs *nl_path_attrs,
+				 struct netlink_callback *cb,
+				 struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_get_state table_get_state = { NULL};
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	struct p4tc_dump_ctx *ctx = (void *)cb->ctx;
+	struct p4tc_pipeline *pipeline = NULL;
+	struct p4tc_table_entry *entry = NULL;
+	struct p4tc_table *table;
+	int i = 0;
+	int ret;
+
+	if (arg) {
+		ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg,
+				       p4tc_entry_policy, extack);
+		if (ret < 0) {
+			p4tc_table_entry_dump_ctx_destroy(ctx);
+			return ret;
+		}
+	}
+
+	ret = p4tc_table_entry_get_table(net, RTM_P4TC_GET, &table_get_state,
+					 tb, nl_path_attrs, extack);
+	if (ret < 0) {
+		p4tc_table_entry_dump_ctx_destroy(ctx);
+		return ret;
+	}
+
+	pipeline = table_get_state.pipeline;
+	table = table_get_state.table;
+
+	if (!ctx->iter) {
+		struct p4tc_filter_context filter_ctx = { NULL };
+		struct p4tc_filter *entry_filter;
+
+		ctx->iter = kzalloc(sizeof(*ctx->iter), GFP_KERNEL);
+		if (!ctx->iter) {
+			ret = -ENOMEM;
+			goto table_put;
+		}
+
+		filter_ctx.pipeline = pipeline;
+		filter_ctx.table = table;
+		filter_ctx.obj_id = P4TC_FILTER_OBJ_RUNTIME_TABLE;
+		entry_filter = p4tc_filter_build(&filter_ctx,
+						 tb[P4TC_ENTRY_FILTER], extack);
+		if (IS_ERR(entry_filter)) {
+			kfree(ctx->iter);
+			ret = PTR_ERR(entry_filter);
+			goto table_put;
+		}
+		ctx->entry_filter = entry_filter;
+
+		rhltable_walk_enter(&table->tbl_entries, ctx->iter);
+	}
+
+	/* There is an issue here regarding the stability of walking an
+	 * rhashtable. If an insert or a delete happens in parallel, we may see
+	 * duplicate entries or skip some valid entries. To solve this we are
+	 * going to have an auxiliary list that also stores the entries and will
+	 * be used for dump, instead of walking over the rhastable.
+	 */
+	ret = -ENOMEM;
+	rhashtable_walk_start(ctx->iter);
+	do {
+		i = 0;
+		while (i < P4TC_MSGBATCH_SIZE &&
+		       (entry = rhashtable_walk_next(ctx->iter)) &&
+		       !IS_ERR(entry)) {
+			struct p4tc_table_entry_value *value =
+				p4tc_table_entry_value(entry);
+			struct nlattr *count;
+
+			if (p4tc_ctrl_read_ok(value->permissions) &&
+			    p4tc_filter_exec(ctx->entry_filter, entry)) {
+				count = nla_nest_start(skb, i + 1);
+				if (!count) {
+					rhashtable_walk_stop(ctx->iter);
+					goto table_put;
+				}
+
+				ret = p4tc_tbl_entry_fill(skb, table, entry,
+							  table->tbl_id,
+							  P4TC_ENTITY_UNSPEC);
+				if (ret == -ENOMEM) {
+					ret = 1;
+					nla_nest_cancel(skb, count);
+					rhashtable_walk_stop(ctx->iter);
+					goto table_put;
+				}
+				nla_nest_end(skb, count);
+
+				i++;
+			}
+		}
+	} while (entry == ERR_PTR(-EAGAIN));
+	rhashtable_walk_stop(ctx->iter);
+
+	if (!i) {
+		rhashtable_walk_exit(ctx->iter);
+
+		ret = 0;
+		p4tc_table_entry_dump_ctx_destroy(ctx);
+
+		goto table_put;
+	}
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			P4TC_PIPELINE_NAMSIZ);
+
+	if (!nl_path_attrs->ids[P4TC_PID_IDX])
+		nl_path_attrs->ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!nl_path_attrs->ids[P4TC_TBLID_IDX])
+		nl_path_attrs->ids[P4TC_TBLID_IDX] = table->tbl_id;
+
+	ret = skb->len;
+
+table_put:
+	p4tc_table_entry_put_table(&table_get_state);
+
+	return ret;
+}
+
+int p4tc_tbl_entry_dumpit(struct net *net, struct sk_buff *skb,
+			  struct netlink_callback *cb,
+			  struct nlattr *arg, char *p_name)
+{
+	struct p4tc_path_nlattrs nl_path_attrs = {0};
+	struct netlink_ext_ack *extack = cb->extack;
+	u32 portid = NETLINK_CB(cb->skb).portid;
+	const struct nlmsghdr *n = cb->nlh;
+	struct nlattr *tb[P4TC_MAX + 1];
+	u32 ids[P4TC_PATH_MAX] = { 0 };
+	struct p4tcmsg *t_new;
+	struct nlmsghdr *nlh;
+	struct nlattr *pnatt;
+	struct nlattr *root;
+	struct p4tcmsg *t;
+	u32 *arg_ids;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_MAX, arg, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	nlh = nlmsg_put(skb, portid, n->nlmsg_seq, RTM_P4TC_GET, sizeof(*t),
+			n->nlmsg_flags);
+	if (!nlh)
+		return -ENOSPC;
+
+	t = (struct p4tcmsg *)nlmsg_data(n);
+	t_new = nlmsg_data(nlh);
+	t_new->pipeid = t->pipeid;
+	t_new->obj = t->obj;
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PATH)) {
+		NL_SET_ERR_MSG(extack, "Must specify object path");
+		return -EINVAL;
+	}
+
+	pnatt = nla_reserve(skb, P4TC_ROOT_PNAME, P4TC_PIPELINE_NAMSIZ);
+	if (!pnatt)
+		return -ENOMEM;
+
+	ids[P4TC_PID_IDX] = t_new->pipeid;
+	arg_ids = nla_data(tb[P4TC_PATH]);
+	memcpy(&ids[P4TC_TBLID_IDX], arg_ids, nla_len(tb[P4TC_PATH]));
+	nl_path_attrs.ids = ids;
+
+	nl_path_attrs.pname = nla_data(pnatt);
+	if (!p_name) {
+		/* Filled up by the operation or forced failure */
+		memset(nl_path_attrs.pname, 0, P4TC_PIPELINE_NAMSIZ);
+		nl_path_attrs.pname_passed = false;
+	} else {
+		strscpy(nl_path_attrs.pname, p_name, P4TC_PIPELINE_NAMSIZ);
+		nl_path_attrs.pname_passed = true;
+	}
+
+	root = nla_nest_start(skb, P4TC_ROOT);
+	ret = p4tc_table_entry_dump(net, skb, tb[P4TC_PARAMS], &nl_path_attrs,
+				    cb, extack);
+	if (ret <= 0)
+		goto out;
+	nla_nest_end(skb, root);
+
+	if (nla_put_string(skb, P4TC_ROOT_PNAME, nl_path_attrs.pname)) {
+		ret = -1;
+		goto out;
+	}
+
+	if (!t_new->pipeid)
+		t_new->pipeid = ids[P4TC_PID_IDX];
+
+	nlmsg_end(skb, nlh);
+
+	return skb->len;
+
+out:
+	nlmsg_cancel(skb, nlh);
+	return ret;
+}
-- 
2.34.1


