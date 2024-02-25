Return-Path: <bpf+bounces-22702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0BB862C22
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1938D1F21B0C
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D8D1C6B1;
	Sun, 25 Feb 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KIU8Yr+U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182FE1C294
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880135; cv=none; b=p5fTWvZ/PMG3E+8fzN6/2obyPNvIwfWlNNhgDBBWjD2dPipfj9bfeUyhryeEB8N07V1cgvLHF4cLSU3YKYFL5cXL3e+BXn9CUjwWiJFfWL+XxArzlkMOz+8V6X1gV1W5knYeAm9t8kViGDjFmLpTloZnnLddhWOZZVdp9MXanec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880135; c=relaxed/simple;
	bh=dWDhb4yFjNP7bz3M/z95Gd9eVtLQfdbA9WpE4GghovU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CG1ELFZJi+zzZJdydIVr4M7N9rFw5MQMLqRa434BlW/z2gfWYdUrzBiZmP/UONA6QaDgDk8JoWVx0+MZHNQDoOGIcnAU9WMLLKbwf/tTAinbqB7xWHhpsI73P/UXEL6Wgr2eRm8mGrvVIiQ4o9yb1FUWNnohAK3vjyjlS9pSAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KIU8Yr+U; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21433afcc53so1368472fac.3
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 08:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708880131; x=1709484931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k6lHPj6gB2vUosfAMw/B8vZQTCeZ2KNbBRfXnJtv4s=;
        b=KIU8Yr+Uy+NzUG++rXEwVs5EbutIMZuwq3IlrqVURwTKJ1pfNusO+VtyhtYjZ7CKmR
         y980rllg6HbTLoiQdFt0MdawWF+RFdSEg4MzPAC/mHdPDwtG07b0DTgwntw7rEMgsRzV
         d/f2jCEX4GLqB/YEZErlIkIIEml60N4clgslkg/rsvIZRRTyDWTItZloU+RjSJWQfrhM
         CqnscpCQx0q9AcJocujtzz4X1IPfB3dPRFExVlL1DBAaMEzL3JKK7dLmfU6nHKWoL5v5
         nMFj9UH1T6uvlnofJrgEYSvKcgK/zCyuRQFj8yqNN3x96L7GnE5ZOlpFdJLd5smw2qHa
         5GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880131; x=1709484931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k6lHPj6gB2vUosfAMw/B8vZQTCeZ2KNbBRfXnJtv4s=;
        b=I2CB692uw2WKzMRvETYlRU2Tm80yDnLV6pL7dKADx73Pb89SdDVUDcpVAUltK15+5O
         SqwWpSx4U8zPXMuTA3OKTl4uINg4DWPoGdWwmiIYCfWbCTzA7WXTiCiY/9lkm4ctzc4S
         J/6HHOx/80eZEo7Bw3jjLWPc+g+8LaC3TY2AtgAztcXVWWnJFsCF3FaTPqecNd3mHHLE
         i3mDFTrRR7OViUHRInUgqJMryiWYOkcaeHHNEDk1OlnOyeTEVmqkKTR9RUcmNpH9Tjli
         sCYzXXUlhsumqssIjQYuizXRbA3JWqRwmlOvl5aEioTP0UAL1MZW3hd9vWZCRo6jcFCM
         rsJw==
X-Forwarded-Encrypted: i=1; AJvYcCWgJl8bhF6W5jg8OJhDo67H6LBG7iTsKaO1pPvE7dFGTwFEZ8vCkK+HbOLkngco41vljWKsvUcKZv0COTgSZoWi26p4
X-Gm-Message-State: AOJu0Yx27Flc197uvYpqMu6i3d4yuQ825eznR929X+TV9ZueKzOfg689
	avJ7ZNghptnkKCttk2Hh5t0Xc9HwH25iglJW8fSX76mr3+ts0j8DLygWYGlCcA==
X-Google-Smtp-Source: AGHT+IFOAQKiS8wAP4bi2oWmUPGdG7bnZY+BWvUu+7wKQdlWoi83+8Tzj8uL1vHS6/q3rk0vJv364Q==
X-Received: by 2002:a05:6870:9726:b0:21e:6732:76bb with SMTP id n38-20020a056870972600b0021e673276bbmr5997132oaq.39.1708880130823;
        Sun, 25 Feb 2024 08:55:30 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a14b500b00787ba78da02sm1620698qkj.93.2024.02.25.08.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:55:30 -0800 (PST)
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
Subject: [PATCH net-next v12  13/15] p4tc: add runtime table entry get, delete, flush and dump
Date: Sun, 25 Feb 2024 11:54:44 -0500
Message-Id: <20240225165447.156954-14-jhs@mojatatu.com>
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
---
 include/net/p4tc.h                |  28 +-
 include/uapi/linux/p4tc.h         |  90 +++-
 net/sched/p4tc/Makefile           |   2 +-
 net/sched/p4tc/p4tc_filter.c      | 870 ++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_runtime_api.c |  63 +++
 net/sched/p4tc/p4tc_table.c       | 113 +++-
 net/sched/p4tc/p4tc_tbl_entry.c   | 853 ++++++++++++++++++++++++++++-
 7 files changed, 2010 insertions(+), 9 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_filter.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index bc32b73ec..231936df4 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -36,9 +36,15 @@
 #define P4TC_AID_IDX 1
 #define P4TC_PARSEID_IDX 1
 
+struct p4tc_filter {
+	struct p4tc_filter_oper *operation;
+	int cmd; /* CRUD command */
+};
+
 struct p4tc_dump_ctx {
 	u32 ids[P4TC_PATH_MAX];
 	struct rhashtable_iter *iter;
+	struct p4tc_filter *entry_filter;
 };
 
 struct p4tc_template_common;
@@ -351,6 +357,7 @@ struct p4tc_table_entry_value {
 	struct p4tc_table_entry_work             *entry_work;
 	u64                                      aging_ms;
 	struct hrtimer                           entry_timer;
+	bool                                     is_dyn;
 	bool                                     tmpl_created;
 };
 
@@ -534,6 +541,15 @@ p4tc_table_init_permissions(struct p4tc_table *table, u16 permissions,
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
@@ -548,7 +564,17 @@ int p4tc_tbl_entry_dumpit(struct net *net, struct sk_buff *skb,
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
+p4tc_filter_build(struct p4tc_pipeline *pipeline, struct p4tc_table *table,
+		  struct nlattr *nla, struct netlink_ext_ack *extack);
+bool p4tc_filter_exec(struct p4tc_filter *filter,
+		      struct p4tc_table_entry *entry);
+void p4tc_filter_destroy(struct p4tc_filter *filter);
 
 struct tcf_p4act *
 p4a_runt_prealloc_get_next(struct p4tc_act *act);
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index adac8024c..3f1444ad9 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -226,6 +226,8 @@ enum {
 	__P4TC_TABLE_MAX
 };
 
+#define P4TC_TABLE_MAX (__P4TC_TABLE_MAX - 1)
+
 enum {
 	P4TC_TIMER_PROFILE_UNSPEC,
 	P4TC_TIMER_PROFILE_ID, /* u32 */
@@ -233,7 +235,7 @@ enum {
 	__P4TC_TIMER_PROFILE_MAX
 };
 
-#define P4TC_TABLE_MAX (__P4TC_TABLE_MAX - 1)
+#define P4TC_TIMER_PROFILE_MAX (__P4TC_TIMER_PROFILE_MAX - 1)
 
 /* Action attributes */
 enum {
@@ -300,11 +302,93 @@ struct p4tc_table_entry_tm {
 	__u16 permissions;
 };
 
+enum {
+	P4TC_FILTER_OPND_ACT_UNSPEC,
+	P4TC_FILTER_OPND_ACT_NAME, /* string  */
+	P4TC_FILTER_OPND_ACT_ID, /* u32 */
+	P4TC_FILTER_OPND_ACT_PARAMS, /* nested params */
+	__P4TC_FILTER_OPND_ACT_MAX
+};
+
+#define P4TC_FILTER_OPND_ACT_MAX (__P4TC_FILTER_OPND_ACT_MAX - 1)
+
+enum {
+	P4TC_FILTER_OPND_UNSPEC,
+	P4TC_FILTER_OPND_ENTRY_KEY_BLOB, /* Key blob */
+	P4TC_FILTER_OPND_ENTRY_MASK_BLOB, /* Mask blob */
+	P4TC_FILTER_OPND_ACT, /* nested action - P4TC_FITLER_OPND_ACT_XXX */
+	P4TC_FILTER_OPND_PRIO, /* u32 */
+	P4TC_FILTER_OPND_TIME_DELTA, /* in msecs */
+	__P4TC_FILTER_OPND_MAX
+};
+
+#define P4TC_FILTER_OPND_MAX (__P4TC_FILTER_OPND_MAX - 1)
+
+enum {
+	P4TC_FILTER_OP_UNSPEC,
+	P4TC_FILTER_OP_REL,
+	P4TC_FILTER_OP_LOGICAL,
+	__P4TC_FILTER_OP_MAX
+};
+
+#define P4TC_FILTER_OP_MAX (__P4TC_FILTER_OP_MAX - 1)
+
+enum {
+	P4TC_FILTER_OP_REL_UNSPEC,
+	P4TC_FILTER_OP_REL_EQ,
+	P4TC_FILTER_OP_REL_NEQ,
+	P4TC_FILTER_OP_REL_LT,
+	P4TC_FILTER_OP_REL_GT,
+	P4TC_FILTER_OP_REL_LE,
+	P4TC_FILTER_OP_REL_GE,
+	__P4TC_FILTER_OP_REL_MAX
+};
+
+#define P4TC_FILTER_OP_REL_MAX (__P4TC_FILTER_OP_REL_MAX - 1)
+
+enum {
+	P4TC_FILTER_OP_LOGICAL_UNSPEC,
+	P4TC_FILTER_OP_LOGICAL_AND,
+	P4TC_FILTER_OP_LOGICAL_OR,
+	P4TC_FILTER_OP_LOGICAL_NOT,
+	P4TC_FILTER_OP_LOGICAL_XOR,
+	__P4TC_FILTER_OP_LOGICAL_MAX
+};
+
+#define P4TC_FILTER_OP_LOGICAL_MAX (__P4TC_FILTER_OP_LOGICAL_MAX - 1)
+
+enum p4tc_filter_ntype {
+	P4TC_FILTER_NODE_UNSPEC,
+	P4TC_FILTER_NODE_PARENT, /* nested - P4TC_FILTER_XXX */
+	P4TC_FILTER_NODE_LEAF, /* nested - P4TC_FILTER_OPND_XXX */
+	__P4TC_FILTER_NODE_MAX
+};
+
+#define P4TC_FILTER_NODE_MAX (__P4TC_FILTER_NODE_MAX - 1)
+
+enum {
+	P4TC_FILTER_UNSPEC,
+	P4TC_FILTER_OP_KIND, /* P4TC_FILTER_OP_REL || P4TC_FILTER_OP_LOGICAL */
+	P4TC_FILTER_OP_VALUE, /* P4TC_FILTER_OP_REL_XXX ||
+			       * P4TC_FILTER_OP_LOGICAL_XXX
+			       */
+	P4TC_FILTER_NODE1, /* nested - P4TC_FILTER_NODE_XXX */
+	P4TC_FILTER_NODE2, /* nested - P4TC_FILTER_NODE_XXX - Present only for
+			    * LOGICAL OPS with LOGICAL_NOT being the exception
+			    */
+	__P4TC_FILTER_MAX
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
 
@@ -332,6 +416,10 @@ enum {
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
index 921909ac4..56a8adc74 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -2,4 +2,4 @@
 
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
 	p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
-	p4tc_runtime_api.o
+	p4tc_filter.o p4tc_runtime_api.o
diff --git a/net/sched/p4tc/p4tc_filter.c b/net/sched/p4tc/p4tc_filter.c
new file mode 100644
index 000000000..4db726816
--- /dev/null
+++ b/net/sched/p4tc/p4tc_filter.c
@@ -0,0 +1,870 @@
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
+	P4TC_FILTER_OPND_KIND_UNSPEC,
+	P4TC_FILTER_OPND_KIND_ENTRY_KEY,
+	P4TC_FILTER_OPND_KIND_ACT,
+	P4TC_FILTER_OPND_KIND_ACT_PARAM,
+	P4TC_FILTER_OPND_KIND_PRIO,
+	P4TC_FILTER_OPND_KIND_MSECS,
+};
+
+struct p4tc_filter_opnd {
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
+p4tc_entry_filter_act_policy[P4TC_FILTER_OPND_ACT_MAX + 1] = {
+	[P4TC_FILTER_OPND_ACT_NAME] = {
+		.type = NLA_STRING,
+		.len = P4TC_ACT_TMPL_NAMSZ
+	},
+	[P4TC_FILTER_OPND_ACT_ID] = { .type = NLA_U32 },
+	[P4TC_FILTER_OPND_ACT_PARAMS] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy
+p4tc_entry_filter_opnd_policy[P4TC_FILTER_OPND_MAX + 1] = {
+	[P4TC_FILTER_OPND_ENTRY_KEY_BLOB] = { .type = NLA_BINARY },
+	[P4TC_FILTER_OPND_ENTRY_MASK_BLOB] = { .type = NLA_BINARY },
+	[P4TC_FILTER_OPND_ACT] = { .type = NLA_NESTED },
+	[P4TC_FILTER_OPND_PRIO] = { .type = NLA_U32 },
+	[P4TC_FILTER_OPND_TIME_DELTA] = { .type = NLA_U32 },
+};
+
+static const struct nla_policy
+p4tc_entry_filter_node_policy[P4TC_FILTER_NODE_MAX + 1] = {
+	[P4TC_FILTER_NODE_PARENT] = { .type = NLA_NESTED },
+	[P4TC_FILTER_NODE_LEAF] = { .type = NLA_NESTED },
+};
+
+static struct netlink_range_validation range_filter_op_kind = {
+	.min = P4TC_FILTER_OP_REL,
+	.max = P4TC_FILTER_OP_MAX,
+};
+
+static const struct nla_policy p4tc_entry_filter_policy[P4TC_FILTER_MAX + 1] = {
+	[P4TC_FILTER_OP_KIND] =
+		NLA_POLICY_FULL_RANGE(NLA_U16, &range_filter_op_kind),
+	[P4TC_FILTER_OP_VALUE] = { .type = NLA_U16 },
+	[P4TC_FILTER_NODE1] = { .type = NLA_NESTED },
+	[P4TC_FILTER_NODE2] = { .type = NLA_NESTED },
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
+	for (i = P4TC_FILTER_OPND_ENTRY_MASK_BLOB; i < P4TC_FILTER_OPND_MAX + 1;
+	     i++) {
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
+	case P4TC_FILTER_OP_REL:
+		if (filter_op_value < P4TC_FILTER_OP_REL_EQ ||
+		    filter_op_value > P4TC_FILTER_OP_REL_MAX) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Invalid filter relational op %u\n",
+					   filter_op_value);
+			return false;
+		}
+		break;
+	case P4TC_FILTER_OP_LOGICAL:
+		if (filter_op_value < P4TC_FILTER_OP_LOGICAL_AND ||
+		    filter_op_value > P4TC_FILTER_OP_LOGICAL_MAX) {
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
+	case P4TC_FILTER_OP_LOGICAL:
+		switch (filter_op_value) {
+		case P4TC_FILTER_OP_LOGICAL_AND:
+		case P4TC_FILTER_OP_LOGICAL_OR:
+		case P4TC_FILTER_OP_LOGICAL_XOR:
+			return true;
+		default:
+			return false;
+		}
+	case P4TC_FILTER_OP_REL:
+		return false;
+	default:
+		return false;
+	}
+}
+
+static void p4tc_filter_opnd_destroy(struct p4tc_filter_opnd *opnd)
+{
+	switch (opnd->opnd_kind) {
+	case P4TC_FILTER_OPND_KIND_ACT:
+		p4tc_action_put_ref(opnd->act.val);
+		break;
+	case P4TC_FILTER_OPND_KIND_ACT_PARAM:
+		p4a_runt_parm_destroy(opnd->act.param);
+		break;
+	default:
+		break;
+	}
+
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
+	if (node->ntype == P4TC_FILTER_NODE_LEAF)
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
+static void p4tc_filter_opnd_prio_build(struct p4tc_filter_opnd *filter_opnd,
+					struct nlattr *nla)
+{
+	filter_opnd->opnd_kind = P4TC_FILTER_OPND_KIND_PRIO;
+	filter_opnd->prio = nla_get_u32(nla);
+}
+
+static void
+p4tc_filter_opnd_msecs_since_build(struct p4tc_filter_opnd *filter_opnd,
+				   struct nlattr *nla)
+{
+	filter_opnd->opnd_kind = P4TC_FILTER_OPND_KIND_MSECS;
+	filter_opnd->msecs_since = nla_get_u32(nla);
+}
+
+static int
+p4tc_filter_opnd_act_build(struct p4tc_pipeline *pipeline, struct nlattr *nla,
+			   struct p4tc_filter_opnd *filter_opnd,
+			   struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_FILTER_OPND_MAX + 1];
+	struct p4tc_act_param *param = NULL;
+	struct p4tc_act *act;
+	char *act_name;
+	u32 act_id;
+	int ret;
+
+	if (!nla)
+		return 0;
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_OPND_ACT_MAX, nla,
+			       p4tc_entry_filter_act_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	act_id = tb[P4TC_FILTER_OPND_ACT_ID] ?
+		nla_get_u32(tb[P4TC_FILTER_OPND_ACT_ID]) : 0;
+
+	act_name = tb[P4TC_FILTER_OPND_ACT_NAME] ?
+		nla_data(tb[P4TC_FILTER_OPND_ACT_NAME]) : NULL;
+
+	act = p4a_tmpl_get(pipeline, act_name, act_id, extack);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	if (tb[P4TC_FILTER_OPND_ACT_PARAMS]) {
+		/* Don't call p4a_runt_parm_alloc because we needn't allocate
+		 * params_array for the filter_opnd.
+		 */
+		param = p4a_runt_parm_init(pipeline->net, act,
+					   tb[P4TC_FILTER_OPND_ACT_PARAMS],
+					   extack);
+		if (IS_ERR(param)) {
+			ret = PTR_ERR(param);
+			goto params_destroy;
+		}
+
+		filter_opnd->act.param = param;
+		filter_opnd->opnd_kind = P4TC_FILTER_OPND_KIND_ACT_PARAM;
+	} else {
+		filter_opnd->opnd_kind = P4TC_FILTER_OPND_KIND_ACT;
+	}
+
+	filter_opnd->act.val = act;
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
+p4tc_filter_opnd_entry_key_build(struct nlattr **tb, struct p4tc_table *table,
+				 struct p4tc_filter_opnd *filter_opnd,
+				 struct netlink_ext_ack *extack)
+{
+	u32 maskblob_len;
+	u32 keysz;
+
+	keysz = nla_len(tb[P4TC_FILTER_OPND_ENTRY_KEY_BLOB]);
+	if (keysz != BITS_TO_BYTES(table->tbl_keysz)) {
+		NL_SET_ERR_MSG(extack,
+			       "Filter key size and table key size differ");
+		return -EINVAL;
+	}
+
+	nla_memcpy(filter_opnd->entry_key.val,
+		   tb[P4TC_FILTER_OPND_ENTRY_KEY_BLOB], keysz);
+
+	maskblob_len =
+		nla_len(tb[P4TC_FILTER_OPND_ENTRY_MASK_BLOB]);
+	if (keysz != maskblob_len) {
+		NL_SET_ERR_MSG(extack,
+			       "Key and mask blob must have the same length");
+		return -EINVAL;
+	}
+
+	nla_memcpy(filter_opnd->entry_key.mask,
+		   tb[P4TC_FILTER_OPND_ENTRY_MASK_BLOB], keysz);
+	p4tc_tbl_entry_mask_key(filter_opnd->entry_key.val,
+				filter_opnd->entry_key.val,
+				filter_opnd->entry_key.mask, keysz);
+
+	filter_opnd->opnd_kind = P4TC_FILTER_OPND_KIND_ENTRY_KEY;
+
+	return 0;
+}
+
+static struct p4tc_filter_opnd *
+p4tc_filter_opnd_build(struct p4tc_pipeline *pipeline,
+		       struct p4tc_table *table, struct nlattr *nla,
+		       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_FILTER_OPND_MAX + 1];
+	struct p4tc_filter_opnd *filter_opnd;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_OPND_MAX, nla,
+			       p4tc_entry_filter_opnd_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (!p4tc_filter_msg_valid(tb, extack))
+		return ERR_PTR(-EINVAL);
+
+	filter_opnd = kzalloc(sizeof(*filter_opnd), GFP_KERNEL);
+	if (!filter_opnd)
+		return ERR_PTR(-ENOMEM);
+
+	if (tb[P4TC_FILTER_OPND_PRIO]) {
+		p4tc_filter_opnd_prio_build(filter_opnd,
+					    tb[P4TC_FILTER_OPND_PRIO]);
+	} else if (tb[P4TC_FILTER_OPND_TIME_DELTA]) {
+		struct nlattr *msecs_attr = tb[P4TC_FILTER_OPND_TIME_DELTA];
+
+		p4tc_filter_opnd_msecs_since_build(filter_opnd, msecs_attr);
+	} else if (tb[P4TC_FILTER_OPND_ACT]) {
+		ret = p4tc_filter_opnd_act_build(pipeline,
+						 tb[P4TC_FILTER_OPND_ACT],
+						 filter_opnd, extack);
+		if (ret < 0)
+			goto free_filter_opnd;
+	} else if (tb[P4TC_FILTER_OPND_ENTRY_KEY_BLOB]) {
+		ret = p4tc_filter_opnd_entry_key_build(tb, table, filter_opnd,
+						       extack);
+		if (ret < 0)
+			goto free_filter_opnd;
+	} else {
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
+static bool p4tc_filter_oper_rel_opnd_is_comp(struct p4tc_filter_opnd *opnd1,
+					      struct netlink_ext_ack *extack)
+{
+	switch (opnd1->opnd_kind) {
+	case P4TC_FILTER_OPND_KIND_ENTRY_KEY:
+		NL_SET_ERR_MSG(extack,
+			       "Compare with key operand isn't allowed");
+		return false;
+	case P4TC_FILTER_OPND_KIND_ACT:
+		NL_SET_ERR_MSG(extack,
+			       "Compare with act operand is forbidden");
+		return false;
+	case P4TC_FILTER_OPND_KIND_ACT_PARAM: {
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
+static bool p4tc_filter_oper_rel_is_valid(struct p4tc_filter_oper *filter_oper,
+					  struct netlink_ext_ack *extack)
+{
+	struct p4tc_filter_node *filter_node1 = filter_oper->node1;
+	struct p4tc_filter_opnd *opnd = filter_node1->opnd;
+
+	switch (filter_oper->op_value) {
+	case P4TC_FILTER_OP_REL_EQ:
+	case P4TC_FILTER_OP_REL_NEQ:
+		return true;
+	case P4TC_FILTER_OP_REL_LT:
+	case P4TC_FILTER_OP_REL_GT:
+	case P4TC_FILTER_OP_REL_LE:
+	case P4TC_FILTER_OP_REL_GE:
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
+	case P4TC_FILTER_OP_LOGICAL:
+		return true;
+	case P4TC_FILTER_OP_REL:
+		return p4tc_filter_oper_rel_is_valid(filter_oper, extack);
+	default:
+		/* Will never happen */
+		return false;
+	}
+}
+
+static struct p4tc_filter_oper *
+p4tc_filter_oper_build(struct p4tc_pipeline *pipeline, struct p4tc_table *table,
+		       struct nlattr *nla, u32 depth,
+		       struct netlink_ext_ack *extack);
+
+static struct p4tc_filter_node *
+p4tc_filter_node_build(struct p4tc_pipeline *pipeline, struct p4tc_table *table,
+		       struct nlattr *nla, u32 depth,
+		       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_FILTER_NODE_MAX + 1];
+	struct p4tc_filter_oper *operation;
+	struct p4tc_filter_node *node;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_NODE_MAX, nla,
+			       p4tc_entry_filter_node_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(-EINVAL);
+
+	if ((!tb[P4TC_FILTER_NODE_PARENT] && !tb[P4TC_FILTER_NODE_LEAF]) ||
+	    (tb[P4TC_FILTER_NODE_PARENT] && tb[P4TC_FILTER_NODE_LEAF])) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify either P4TC_FILTER_NODE_PARENT or P4TC_FILTER_NODE_LEAF");
+		return ERR_PTR(-EINVAL);
+	}
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	if (tb[P4TC_FILTER_NODE_LEAF]) {
+		struct p4tc_filter_opnd *opnd;
+
+		opnd = p4tc_filter_opnd_build(pipeline, table,
+					      tb[P4TC_FILTER_NODE_LEAF],
+					      extack);
+		if (IS_ERR(opnd)) {
+			ret = PTR_ERR(opnd);
+			goto free_node;
+		}
+		node->ntype = P4TC_FILTER_NODE_LEAF;
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
+	operation = p4tc_filter_oper_build(pipeline, table,
+					   tb[P4TC_FILTER_NODE_PARENT],
+					   depth + 1, extack);
+	if (IS_ERR(operation)) {
+		ret = PTR_ERR(operation);
+		goto free_node;
+	}
+	node->ntype = P4TC_FILTER_NODE_PARENT;
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
+p4tc_filter_oper_build(struct p4tc_pipeline *pipeline, struct p4tc_table *table,
+		       struct nlattr *nla, u32 depth,
+		       struct netlink_ext_ack *extack)
+{
+	struct p4tc_filter_node *filter_node2 = NULL;
+	struct p4tc_filter_node *filter_node1;
+	struct nlattr *tb[P4TC_FILTER_MAX + 1];
+	struct p4tc_filter_oper *filter_oper;
+	u16 filter_op_value;
+	u16 filter_op_kind;
+	int ret;
+
+	if (!nla)
+		return ERR_PTR(-EINVAL);
+
+	ret = nla_parse_nested(tb, P4TC_FILTER_MAX, nla,
+			       p4tc_entry_filter_policy, extack);
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
+	if (!tb[P4TC_FILTER_NODE1]) {
+		NL_SET_ERR_MSG_FMT(extack, "Must specify filter node1");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (p4tc_filter_op_requires_node2(filter_op_kind, filter_op_value)) {
+		if (!tb[P4TC_FILTER_NODE2]) {
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
+	filter_node1 = p4tc_filter_node_build(pipeline, table,
+					      tb[P4TC_FILTER_NODE1],
+					      depth, extack);
+	if (IS_ERR(filter_node1)) {
+		ret = PTR_ERR(filter_node1);
+		goto free_operation;
+	}
+
+	if (tb[P4TC_FILTER_NODE2]) {
+		filter_node2 = p4tc_filter_node_build(pipeline, table,
+						      tb[P4TC_FILTER_NODE2],
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
+struct p4tc_filter *
+p4tc_filter_build(struct p4tc_pipeline *pipeline, struct p4tc_table *table,
+		  struct nlattr *nla, struct netlink_ext_ack *extack)
+{
+	struct p4tc_filter_oper *filter_oper;
+	struct p4tc_filter *filter;
+
+	if (!nla)
+		return NULL;
+
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return ERR_PTR(-ENOMEM);
+
+	filter_oper = p4tc_filter_oper_build(pipeline, table, nla, 0, extack);
+	if (IS_ERR(filter_oper)) {
+		kfree(filter);
+		return (struct p4tc_filter *)filter_oper;
+	}
+
+	filter->operation = filter_oper;
+
+	return filter;
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
+	case P4TC_FILTER_OP_REL_EQ:
+		return !cmp;
+	case P4TC_FILTER_OP_REL_NEQ:
+		return !!cmp;
+	case P4TC_FILTER_OP_REL_LT:
+		return cmp < 0;
+	case P4TC_FILTER_OP_REL_GT:
+		return cmp > 0;
+	case P4TC_FILTER_OP_REL_LE:
+		return cmp <= 0;
+	case P4TC_FILTER_OP_REL_GE:
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
+		     struct p4tc_filter_opnd *filter_opnd)
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
+	if (filter_opnd->opnd_kind == P4TC_FILTER_OPND_KIND_ACT_PARAM) {
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
+p4tc_filter_exec_opnd(struct p4tc_filter_oper *filter_oper,
+		      struct p4tc_table_entry *entry,
+		      struct p4tc_filter_opnd *filter_opnd)
+{
+	switch (filter_opnd->opnd_kind) {
+	case P4TC_FILTER_OPND_KIND_ENTRY_KEY: {
+		u8 key[BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = {0};
+		u32 keysz;
+		int cmp;
+
+		keysz = BITS_TO_BYTES(entry->key.keysz);
+		p4tc_tbl_entry_mask_key(key, entry->key.fa_key,
+					filter_opnd->entry_key.mask, keysz);
+
+		cmp = memcmp(key, filter_opnd->entry_key.val, keysz);
+		return p4tc_filter_cmp_op(filter_oper->op_value, cmp);
+	}
+	case P4TC_FILTER_OPND_KIND_ACT:
+	case P4TC_FILTER_OPND_KIND_ACT_PARAM:
+		return p4tc_filter_exec_act(filter_oper,
+					     p4tc_table_entry_value(entry),
+					     filter_opnd);
+	case P4TC_FILTER_OPND_KIND_PRIO: {
+		struct p4tc_table_entry_value *value;
+
+		value = p4tc_table_entry_value(entry);
+		switch (filter_oper->op_value) {
+		case P4TC_FILTER_OP_REL_EQ:
+			return value->prio == filter_opnd->prio;
+		case P4TC_FILTER_OP_REL_NEQ:
+			return value->prio != filter_opnd->prio;
+		case P4TC_FILTER_OP_REL_LT:
+			return value->prio < filter_opnd->prio;
+		case P4TC_FILTER_OP_REL_GT:
+			return value->prio > filter_opnd->prio;
+		case P4TC_FILTER_OP_REL_LE:
+			return value->prio <= filter_opnd->prio;
+		case P4TC_FILTER_OP_REL_GE:
+			return value->prio >= filter_opnd->prio;
+		default:
+			return false;
+		}
+	}
+	case P4TC_FILTER_OPND_KIND_MSECS: {
+		struct p4tc_table_entry_value *value;
+		unsigned long jiffy_since;
+		unsigned long last_used;
+
+		jiffy_since = jiffies -
+			msecs_to_jiffies(filter_opnd->msecs_since);
+
+		value = p4tc_table_entry_value(entry);
+		rcu_read_lock();
+		last_used = rcu_dereference(value->tm)->lastused;
+		rcu_read_unlock();
+
+		switch (filter_oper->op_value) {
+		case P4TC_FILTER_OP_REL_EQ:
+			return jiffy_since == last_used;
+		case P4TC_FILTER_OP_REL_NEQ:
+			return jiffy_since != last_used;
+		case P4TC_FILTER_OP_REL_LT:
+			return time_before(jiffy_since, last_used);
+		case P4TC_FILTER_OP_REL_GT:
+			return time_after(jiffy_since, last_used);
+		case P4TC_FILTER_OP_REL_LE:
+			return time_before_eq(jiffy_since, last_used);
+		case P4TC_FILTER_OP_REL_GE:
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
+static bool p4tc_filter_exec_oper(struct p4tc_filter_oper *filter_oper,
+				  struct p4tc_table_entry *entry);
+
+static bool p4tc_filter_exec_node(struct p4tc_filter_oper *filter_oper,
+				  struct p4tc_table_entry *entry,
+				  struct p4tc_filter_node *node)
+{
+	if (node->ntype == P4TC_FILTER_NODE_PARENT)
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
+	case P4TC_FILTER_OP_LOGICAL_AND:
+		return ret && p4tc_filter_exec_node(filter_oper, entry,
+						    filter_oper->node2);
+	case P4TC_FILTER_OP_LOGICAL_OR:
+		return ret || p4tc_filter_exec_node(filter_oper, entry,
+						    filter_oper->node2);
+	case P4TC_FILTER_OP_LOGICAL_NOT:
+		return !ret;
+	case P4TC_FILTER_OP_LOGICAL_XOR:
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
+	case P4TC_FILTER_OP_REL:
+		return p4tc_filter_exec_oper_rel(filter_oper, entry);
+	case P4TC_FILTER_OP_LOGICAL:
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
index d80103d36..44239cb22 100644
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
index 4bfff14bd..e1b2beed2 100644
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
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index a2f9ab959..7a644eb40 100644
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
@@ -548,6 +595,7 @@ static int p4tc_tbl_entry_emit_event(struct p4tc_table_entry_work *entry_work,
 	struct p4tc_pipeline *pipeline = entry_work->pipeline;
 	struct p4tc_table_entry *entry = entry_work->entry;
 	struct p4tc_table *table = entry_work->table;
+	u16 who_deleted = entry_work->who_deleted;
 	struct net *net = pipeline->net;
 	struct sock *rtnl = net->rtnl;
 	struct nlmsghdr *nlh;
@@ -583,7 +631,8 @@ static int p4tc_tbl_entry_emit_event(struct p4tc_table_entry_work *entry_work,
 		goto free_skb;
 
 	nest = nla_nest_start(skb, 1);
-	if (p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id) < 0)
+	if (p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id,
+				who_deleted) < 0)
 		goto free_skb;
 	nla_nest_end(skb, nest);
 
@@ -628,6 +677,9 @@ static void p4tc_table_entry_del_work(struct work_struct *work)
 	if (entry_work->send_event && p4tc_ctrl_pub_ok(value->permissions))
 		p4tc_tbl_entry_emit_event(entry_work, RTM_P4TC_DEL, GFP_KERNEL);
 
+	if (value->is_dyn)
+		hrtimer_cancel(&value->entry_timer);
+
 	put_net(pipeline->net);
 	p4tc_pipeline_put_ref(pipeline);
 
@@ -650,6 +702,9 @@ static void p4tc_table_entry_put(struct p4tc_table_entry *entry, bool deferred)
 		get_net(pipeline->net); /* avoid action cleanup */
 		schedule_work(&entry_work->work);
 	} else {
+		if (value->is_dyn)
+			hrtimer_cancel(&value->entry_timer);
+
 		__p4tc_table_entry_put(entry);
 	}
 }
@@ -926,6 +981,388 @@ static void p4tc_table_entry_build_key(struct p4tc_table *table,
 		key->fa_key[i] &= mask->fa_value[i];
 }
 
+static int ___p4tc_table_entry_del(struct p4tc_pipeline *pipeline,
+				   struct p4tc_table *table,
+				   struct p4tc_table_entry *entry,
+				   bool from_control)
+__must_hold(RCU)
+{
+	u16 who_deleted = from_control ?
+		P4TC_ENTITY_UNSPEC : P4TC_ENTITY_KERNEL;
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
+				     who_deleted) < 0)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int p4tc_table_entry_gd(struct net *net, struct sk_buff *skb,
+			       int cmd, u16 *permissions, struct nlattr *arg,
+			       struct p4tc_path_nlattrs *nl_path_attrs,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_get_state table_get_state = { NULL };
+	struct p4tc_table_entry_mask *mask = NULL, *new_mask;
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	struct p4tc_table_entry *entry = NULL;
+	struct p4tc_pipeline *pipeline = NULL;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry_key *key;
+	bool get = cmd == RTM_P4TC_GET;
+	u32 *ids = nl_path_attrs->ids;
+	bool has_listener = !!skb;
+	struct p4tc_table *table;
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
+	key = kzalloc(struct_size(key, fa_key, keysz_bytes), GFP_KERNEL);
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
+			       GFP_KERNEL);
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
+
+		if (!p4tc_ctrl_pub_ok(value->permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to publish read entry");
+			ret = -EPERM;
+			goto entry_put;
+		}
+	}
+
+	if (has_listener) {
+		if (p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id,
+					who_deleted) <= 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to fill table entry attributes");
+			ret = -EINVAL;
+			goto entry_put;
+		}
+		*permissions = value->permissions;
+	}
+
+	if (del) {
+		ret = ___p4tc_table_entry_del(pipeline, table, entry, true);
+		if (ret < 0) {
+			if (ret == -EBUSY)
+				NL_SET_ERR_MSG(extack,
+					       "Entry was deleted in parallel");
+			goto entry_put;
+		}
+
+		if (!has_listener)
+			goto out;
+	}
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			P4TC_PIPELINE_NAMSIZ);
+
+out:
+	ret = 0;
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
+static int p4tc_table_entry_flush(struct net *net, struct sk_buff *skb,
+				  struct nlattr *arg,
+				  struct p4tc_path_nlattrs *nl_path_attrs,
+				  struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_get_state table_get_state = { NULL};
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	u32 arg_ids[P4TC_PATH_MAX - 1];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table_entry *entry;
+	u32 *ids = nl_path_attrs->ids;
+	struct rhashtable_iter iter;
+	struct p4tc_filter *filter;
+	bool has_listener = !!skb;
+	struct p4tc_table *table;
+	unsigned char *b;
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
+	if (has_listener) {
+		b = nlmsg_get_pos(skb);
+	} else {
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
+	if (!ids[P4TC_TBLID_IDX])
+		arg_ids[P4TC_TBLID_IDX - 1] = table->tbl_id;
+
+	filter = p4tc_filter_build(pipeline, table, tb[P4TC_ENTRY_FILTER],
+				   extack);
+	if (IS_ERR(filter)) {
+		ret = PTR_ERR(filter);
+		goto table_put;
+	}
+
+	if (has_listener && nla_put(skb, P4TC_PATH, sizeof(arg_ids), arg_ids)) {
+		ret = -ENOMEM;
+		goto filter_destroy;
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
+	if (has_listener) {
+		if (nla_put_u32(skb, P4TC_COUNT, i))
+			goto out_nlmsg_trim;
+	}
+
+	if (fails) {
+		if (i == 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush any entries");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Flushed %u table entries and %u failed",
+					   i, fails);
+		}
+	}
+
+	if (has_listener) {
+		if (!ids[P4TC_PID_IDX])
+			ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+		if (!nl_path_attrs->pname_passed)
+			strscpy(nl_path_attrs->pname, pipeline->common.name,
+				P4TC_PIPELINE_NAMSIZ);
+	}
+
+	ret = 0;
+	goto filter_destroy;
+
+out_nlmsg_trim:
+	if (has_listener)
+		nlmsg_trim(skb, b);
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
@@ -1026,6 +1463,14 @@ __must_hold(RCU)
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
 		p4tc_tbl_entry_emit_event(entry_work, RTM_P4TC_CREATE,
 					  GFP_ATOMIC);
@@ -1135,6 +1580,20 @@ __must_hold(RCU)
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
 
@@ -1209,6 +1668,7 @@ p4tc_table_attrs_policy[P4TC_ENTRY_TBL_ATTRS_MAX + 1] = {
 	[P4TC_ENTRY_TBL_ATTRS_DEFAULT_MISS] = { .type = NLA_NESTED },
 	[P4TC_ENTRY_TBL_ATTRS_PERMISSIONS] =
 		NLA_POLICY_MAX(NLA_U16, P4TC_MAX_PERMISSION),
+	[P4TC_ENTRY_TBL_ATTRS_TIMER_PROFILE] = { .type = NLA_NESTED },
 };
 
 static int p4tc_tbl_attrs_update(struct net *net, struct p4tc_table *table,
@@ -1249,11 +1709,23 @@ static int p4tc_tbl_attrs_update(struct net *net, struct p4tc_table *table,
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
@@ -1397,6 +1869,75 @@ __p4tc_table_entry_cu(struct net *net, u8 cu_flags, struct nlattr **tb,
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
@@ -1495,8 +2036,10 @@ static int p4tc_table_entry_cu(struct net *net, struct sk_buff *skb,
 	value = p4tc_table_entry_value(entry);
 	if (has_listener) {
 		if (p4tc_ctrl_pub_ok(value->permissions)) {
+			u16 who_del = P4TC_ENTITY_UNSPEC;
+
 			if (p4tc_tbl_entry_fill(skb, table, entry,
-						table->tbl_id) <= 0)
+						table->tbl_id, who_del) <= 0)
 				NL_SET_ERR_MSG(extack,
 					       "Unable to fill table entry attributes");
 
@@ -1557,6 +2100,76 @@ p4tc_tmpl_table_entry_cu(struct net *net, struct nlattr *arg,
 	return entry;
 }
 
+static int p4tc_tbl_entry_get_1(struct net *net, struct sk_buff *skb,
+				struct nlattr *arg, u16 *permissions,
+				struct p4tc_path_nlattrs *nl_path_attrs,
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
+	return p4tc_table_entry_gd(net, skb, RTM_P4TC_GET, permissions,
+				   tb[P4TC_PARAMS], nl_path_attrs, extack);
+}
+
+static int p4tc_tbl_entry_del_1(struct net *net, struct sk_buff *skb,
+				bool flush, u16 *permissions,
+				struct nlattr *arg,
+				struct p4tc_path_nlattrs *nl_path_attrs,
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
+	arg_ids = nla_data(tb[P4TC_PATH]);
+	memcpy(&nl_path_attrs->ids[P4TC_TBLID_IDX], arg_ids,
+	       nla_len(tb[P4TC_PATH]));
+
+	if (flush) {
+		ret = p4tc_table_entry_flush(net, skb, tb[P4TC_PARAMS],
+					     nl_path_attrs, extack);
+	} else {
+		if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PARAMS)) {
+			NL_SET_ERR_MSG(extack, "Must specify parameters");
+			return -EINVAL;
+		}
+		ret = p4tc_table_entry_gd(net, skb, RTM_P4TC_DEL, permissions,
+					  tb[P4TC_PARAMS], nl_path_attrs,
+					  extack);
+	}
+
+	return ret;
+}
+
 static int p4tc_tbl_entry_cu_1(struct net *net, struct sk_buff *skb,
 			       u8 cu_flags, u16 *permissions,
 			       struct nlattr *nla,
@@ -1652,7 +2265,11 @@ static int __p4tc_tbl_entry_root(struct net *net, struct sk_buff *skb,
 	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && p4tca[i]; i++) {
 		struct nlattr *nest = nla_nest_start(nskb, i);
 
-		if (cmd == RTM_P4TC_CREATE || cmd == RTM_P4TC_UPDATE) {
+		if (cmd == RTM_P4TC_GET)
+			ret = p4tc_tbl_entry_get_1(net, nskb, p4tca[i],
+						   &permissions, &nl_path_attrs,
+						   extack);
+		else if (cmd == RTM_P4TC_CREATE || cmd == RTM_P4TC_UPDATE) {
 			u8 cu_flags;
 
 			if (cmd == RTM_P4TC_UPDATE)
@@ -1668,6 +2285,12 @@ static int __p4tc_tbl_entry_root(struct net *net, struct sk_buff *skb,
 						  &permissions,
 						  p4tca[i], &nl_path_attrs,
 						  extack);
+		} else if (cmd == RTM_P4TC_DEL) {
+			bool flush = nlh->nlmsg_flags & NLM_F_ROOT;
+
+			ret = p4tc_tbl_entry_del_1(net, nskb, flush,
+						   &permissions, p4tca[i],
+						   &nl_path_attrs, extack);
 		}
 
 		if (p4tc_ctrl_pub_ok(permissions)) {
@@ -1699,7 +2322,9 @@ static int __p4tc_tbl_entry_root(struct net *net, struct sk_buff *skb,
 
 	nlmsg_end(nskb, nlh);
 
-	if (num_pub_permission) {
+	if (cmd == RTM_P4TC_GET) {
+		ret_send = rtnl_unicast(nskb, net, portid);
+	} else if (num_pub_permission) {
 		ret_send = rtnetlink_send(nskb, net, portid, RTNLGRP_TC,
 					  n->nlmsg_flags & NLM_F_ECHO);
 	} else {
@@ -1748,6 +2373,12 @@ static int __p4tc_tbl_entry_root_fast(struct net *net, struct nlmsghdr *n,
 			ret = p4tc_tbl_entry_cu_1(net, NULL, cu_flags, NULL,
 						  p4tca[i], &nl_path_attrs,
 						  extack);
+		} else if (cmd == RTM_P4TC_DEL) {
+			bool flush = n->nlmsg_flags & NLM_F_ROOT;
+
+			ret = p4tc_tbl_entry_del_1(net, NULL, flush, NULL,
+						   p4tca[i], &nl_path_attrs,
+						   extack);
 		}
 
 		if (ret < 0)
@@ -1802,3 +2433,215 @@ int p4tc_tbl_entry_root(struct net *net, struct sk_buff *skb,
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
+		struct p4tc_filter *entry_filter;
+
+		ctx->iter = kzalloc(sizeof(*ctx->iter), GFP_KERNEL);
+		if (!ctx->iter) {
+			ret = -ENOMEM;
+			goto table_put;
+		}
+
+		entry_filter = p4tc_filter_build(pipeline, table,
+						 tb[P4TC_ENTRY_FILTER],
+						 extack);
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


