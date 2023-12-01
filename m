Return-Path: <bpf+bounces-16426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C838012C0
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B000281EE2
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F056760;
	Fri,  1 Dec 2023 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aVaUe0bn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE512A
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:29:29 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a99dbb21fso4563696d6.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455369; x=1702060169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lyl4Fr9oSsSnZbugjecW8M+O+w+ah/1Ba0PdWqtTAM8=;
        b=aVaUe0bnvyqaQD9YxfNa4CwJeXJ1pTQ6hUmt9bX6WKU+sSevAp4ZFOGyzjLsFZHjQN
         5fAPifHCSS3OvKOXHZRZOlEolRbtbkgzK/JdxGz4vtUu1y6GU4RnZGfXpYO1VoigdUwC
         EuipRf0kh8NffkCKkfmMDEhONn0WnW6J1zT0C3C4AGrfQH2DWtaO0KUSgJTA8HSkO/yU
         g/EpJh+hLdQ7wFH583glBhKNb/Oneydgz5Ei/Qn4NKGOob4D2fr0ReP5UpIJ67MsvDI6
         Ws2YK7sxRKVq3LIUw2vMK7E5anvR6IDithBILGenp81jUolJBC1Fa5kYKh28/ktsf9PI
         HE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455369; x=1702060169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lyl4Fr9oSsSnZbugjecW8M+O+w+ah/1Ba0PdWqtTAM8=;
        b=PQg9SfOjO69OUXQ39UVuh9ly6dsaHidGZ9EAEre2MW2eBZqSM3+yigd/sPao0tK81x
         KVuLG3tfptOxQSQWiLEF7lFjcjlNDm/cc0Yrq21M/YsRiXYnQEmV6pumEZP1pVeylBbw
         zaQJcqetCyZvPb17UeE0rc/5M3hldFCX+9314TCWhc7gtHLfm++0bsF+D/XEknGZn1Fl
         ahfl9mfWbAQOXFNC8Q/5PZ0vNZYX28pTtRvDjzkLrUfnitzi6+NH+Bfxise+1wdrAulQ
         4DeQqnqqifxo+0sXpdp53xfUWRPAAQS8+D1jxdcQ6gzhDCHmYEL8AyHWVMH5jjXJFpSi
         I6SQ==
X-Gm-Message-State: AOJu0YxlEGgc20gzOnd4VD4BioK1aB5KDUbXC5sX1kobJ7WESmVhhWo4
	rQg6yhxHI45oWo/Q+aX/Y66DwQ==
X-Google-Smtp-Source: AGHT+IHEY7S2DJ71RxCLYkC4knpHNAp95NjpzoGgrt9ucq56R4ZOfGCvLEaqTaWz8k4c+j/q4gtcSQ==
X-Received: by 2002:a0c:f188:0:b0:67a:44c9:a4be with SMTP id m8-20020a0cf188000000b0067a44c9a4bemr18924327qvl.23.1701455368562;
        Fri, 01 Dec 2023 10:29:28 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:27 -0800 (PST)
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
Subject: [PATCH net-next v9 13/15] p4tc: add runtime table entry create, update, get, delete, flush and dump
Date: Fri,  1 Dec 2023 13:29:02 -0500
Message-Id: <20231201182904.532825-14-jhs@mojatatu.com>
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

Tables are conceptually similar to TCAMs and this implementation could be
labelled as an "algorithmic" TCAM. Tables have a key of a specific size,
maximum number of entries and masks allowed. The basic P4 key types
are supported (exact, LPM, ternary, and ranges) although the kernel side is
oblivious of all that and sees only bit blobs which it masks before a
lookup is performed.

This commit allows users to create, update, delete, get, flush and dump
table _entries_ (templates were described in earlier patch).

Note that table entries can only be created once the pipeline template is
sealed.

For example, a user issuing the following command:

tc p4ctrl create myprog/table/cb/tname  \
  dstAddr 10.10.10.0/24 srcAddr 192.168.0.0/16 prio 16 \
  action send param port port1

indicates we are creating a table entry in table "cb/tname" (a table
residing in control block "cb") on a pipeline named "myprog".

User space tc will create a key which has a value of 0x0a0a0a00c0a00000
(10.10.10.0 concatenated with 192.168.0.0) and a mask value of
0xffffff00ffff0000 (/24 concatenated with /16) that will be sent to the
kernel. In addition a priority field of 16 is passed to the kernel as
well as the action definition.
The priority field is needed to disambiguate in case two entries
match. In that case, the kernel will choose the one with lowest priority
number.

If the user wanted to, for example, update our just created entry with
an action, they'd issue the following command:

tc p4ctrl update myprog/table/cb/tname srcAddr 10.10.10.0/24 \
  dstAddr 192.168.0.0/16 prio 16 action send param port port5

In this case, the user needs to specify the pipeline name, the table name,
the key and the priority, so that we can locate the table entry.

If the user wanted to, for example, get the table entry that we just
updated, they'd issue the following command:

tc p4ctrl get myprog/table/cb/tname srcAddr 10.10.10.0/24 \
  dstAddr 192.168.0.0/16 prio 16

Note that, again, we need to specify the pipeline name, the table name,
the key and the priority, so that we can locate the table entry.

If the user wanted to delete the table entry we created, they'd issue the
following command:

tc p4ctrl del myprog/table/cb/tname srcAddr 10.10.10.0/24 \
  dstAddr 192.168.0.0/16 prio 16

Note that, again, we need to specify the pipeline name, the table
name, the key and the priority, so that we can
locate the table entry.

We can also flush all the table entries from a specific table.
To flush the table entries of table tname ane pipeline ptables,
the user would issue the following command:

tc p4ctrl del myprog/table/cb/tname

We can also dump all the table entries from a specific table.
To dump the table entries of table tname and pipeline myprog, the user
would issue the following command:

tc p4ctrl get myprog/table/cb/tname

__Table Entry Permissions__

Table entries can have permissions specified when they are being added.
Caveat: we are doing a lot more than what P4 defines because we feel it is
necessary.

It should be noted that there are two types of permissions:
 - Table permissions which are a property of the table (think directory in
   file systems). These are set by the template (see earlier patch on table
   template).
 - Table entry permissions which are specific to a table entry (think a
   file in a directory). This patch describes those permissions.

Furthermore in both cases the permissions are split into datapath vs
control path. The template definition can set either one. For example, one
could allow for adding table entries by the datapath in case of PNA
add-on-miss is needed.
By default tables entries have control plane RUD, meaning the control plane
can Read, Update or Delete entries. By default, as well, the control plane
can create new entries unless specified otherwise by the template.

Lets see an example of which creates the table "cb/tname" at template time:

    tc p4template create table/aP4proggie/cb/tname tblid 1 keysz 64 \
      permissions 0x3C24 ...

Above is setting the table tname's permission to be 0x3C24 is equivalent to
CRUD----R--X-- meaning:

The control plane can Create, Read, Update, Delete
The datapath can only Read and Execute table entries.
If one was to dump this table with:

tc -j p4template get table/aP4proggie/cb/tname | jq .

The output would be the following:

[
  {
    "obj": "table",
    "pname": "aP4proggie",
    "pipeid": 22
  },
  {
    "templates": [
      {
        "tblid": 1,
        "tname": "cb/tname",
        "keysz": 64,
        "max_entries": 256,
        "masks": 8,
        "entries": 0,
        "permissions": "CRUD----R--X--",
        "table_type": "exact",
        "acts_list": []
      }
    ]
  }
]

The expressed permissions above are probably the most practical for most
use cases.

__Constant Tables And P4-programmed Defined Entries__

If one wanted to restrict the table to be an equivalent to a "const" then
the permissions would be set to be: -R------R--X--

In such a case, typically the P4 program will have some entries defined
(see the famous P4 calculate example). The "initial entries" specified in
the P4 program will have to be added by the template (as generated by the
compiler), as such:

tc p4template update table/aP4proggie/cb/tname \
  entry srcAddr 10.10.10.10/24 dstAddr 1.1.1.0/24 prio 17

This table cannot be updated at runtime. Any attempt to add an entry of a
table which is read-only at runtime will get a permission denied response
back from the kernel.

Note: If one was to create an equivalent for PNA add-on-miss feature for
this table, then the template would issue table permissions as:
-R-----CR--X-- PNA doesn't specify whether the datapath can also delete or
update entries, but if it did then more appropriate permissions will be:
-R-----CRUDX--

__Mix And Match of RW vs Constant Entries__
Lets look at other scenarios; lets say the table has CRUD----R--X--
permissions as defined by the template...
At runtime the user could add entries which are "const" - by specifying the
entry's permission as -R------R--X-- example:

tc p4ctrl create aP4proggie/table/cb/tname srcAddr 10.10.10.10/24 \
  dstAddr 1.1.1.0/24 prio 17 permissions 0x1024 action drop

or not specify permissions at all as such:

tc p4ctrl create aP4proggie/table/cb/tname srcAddr 10.10.10.10/24 \
  dstAddr 1.1.1.0/24 prio 17 action drop

in which case the table's permissions defined at template
time(CRUD----R--X--) are assumed; meaning the table entry can be deleted or
updated by the control plane.

__Entries permissions Allowed On A Table Entry Creation At Runtime__

When an entry is added with expressed permissions it has at most to have
what the template table definition expressed but could ask for less
permission. For example, assuming a table with templated specified
permissions of CR-D----R--X--:
An entry created at runtime with permission of -R------R--X-- is allowed
but an entry with -RUD----R--X-- will be rejected.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h                |  124 +-
 include/uapi/linux/p4tc.h         |   68 +-
 include/uapi/linux/rtnetlink.h    |    9 +
 net/sched/p4tc/Makefile           |    3 +-
 net/sched/p4tc/p4tc_runtime_api.c |  145 ++
 net/sched/p4tc/p4tc_table.c       |   54 +-
 net/sched/p4tc/p4tc_tbl_entry.c   | 2572 +++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c    |    4 +-
 security/selinux/nlmsgtab.c       |    6 +-
 9 files changed, 2968 insertions(+), 17 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_runtime_api.c
 create mode 100644 net/sched/p4tc/p4tc_tbl_entry.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index b5e84594e..d600e8655 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -120,6 +120,11 @@ static inline bool p4tc_pipeline_get(struct p4tc_pipeline *pipeline)
 	return refcount_inc_not_zero(&pipeline->p_ctrl_ref);
 }
 
+static inline void p4tc_pipeline_put_ref(struct p4tc_pipeline *pipeline)
+{
+	refcount_dec(&pipeline->p_ctrl_ref);
+}
+
 void p4tc_pipeline_put(struct p4tc_pipeline *pipeline);
 struct p4tc_pipeline *
 p4tc_pipeline_find_byany_unsealed(struct net *net, const char *p_name,
@@ -194,6 +199,8 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 
 #define P4TC_PERMISSIONS_UNINIT (1 << P4TC_PERM_MAX_BIT)
 
+#define P4TC_MAX_PARAM_DATA_SIZE 124
+
 struct p4tc_table_defact {
 	struct tc_action **default_acts;
 	/* Will have two 7 bits blocks containing CRUDXPS (Create, read, update,
@@ -215,8 +222,9 @@ struct p4tc_table {
 	struct p4tc_template_common         common;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
-	struct idr                          tbl_prio_idr;
+	struct ida                          tbl_prio_idr;
 	struct rhltable                     tbl_entries;
+	struct p4tc_table_entry             *tbl_const_entry;
 	struct p4tc_table_defact __rcu      *tbl_default_hitact;
 	struct p4tc_table_defact __rcu      *tbl_default_missact;
 	struct p4tc_table_perm __rcu        *tbl_permissions;
@@ -232,11 +240,14 @@ struct p4tc_table {
 	u32                                 tbl_max_entries;
 	u32                                 tbl_max_masks;
 	u32                                 tbl_curr_num_masks;
+	/* Accounts for how many entries this table has */
+	atomic_t                            tbl_nelems;
 	/* Accounts for how many entities refer to this table. Usually just the
 	 * pipeline it belongs to.
 	 */
 	refcount_t                          tbl_ctrl_ref;
 	u16                                 tbl_type;
+	u16                                 PAD0;
 };
 
 extern const struct p4tc_template_ops p4tc_table_ops;
@@ -301,6 +312,86 @@ struct p4tc_table_act {
 
 extern const struct p4tc_template_ops p4tc_act_ops;
 
+extern const struct rhashtable_params entry_hlt_params;
+
+struct p4tc_table_entry;
+struct p4tc_table_entry_work {
+	struct work_struct   work;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table_entry *entry;
+	struct p4tc_table *table;
+	u16 who_deleted;
+	bool send_event;
+};
+
+struct p4tc_table_entry_key {
+	u32 keysz;
+	/* Key start */
+	u32 maskid;
+	unsigned char fa_key[] __aligned(8);
+};
+
+struct p4tc_table_entry_value {
+	u32                              prio;
+	int                              num_acts;
+	struct tc_action                 **acts;
+	/* Accounts for how many entities are referencing, eg: Data path,
+	 * one or more control path and timer.
+	 */
+	refcount_t                       entries_ref;
+	u32                              permissions;
+	struct p4tc_table_entry_tm __rcu *tm;
+	struct p4tc_table_entry_work     *entry_work;
+	u64                              aging_ms;
+	struct hrtimer                   entry_timer;
+	bool                             is_dyn;
+};
+
+struct p4tc_table_entry_mask {
+	struct rcu_head	 rcu;
+	u32              sz;
+	u32              mask_index;
+	/* Accounts for how many entries are using this mask */
+	refcount_t       mask_ref;
+	u32              mask_id;
+	unsigned char fa_value[] __aligned(8);
+};
+
+struct p4tc_table_entry {
+	struct rcu_head rcu;
+	struct rhlist_head ht_node;
+	struct p4tc_table_entry_key key;
+	/* fallthrough: key data + value */
+};
+
+#define P4TC_KEYSZ_BYTES(bits) (round_up(BITS_TO_BYTES(bits), 8))
+
+#define P4TC_ENTRY_KEY_OFFSET (offsetof(struct p4tc_table_entry_key, fa_key))
+
+#define P4TC_ENTRY_VALUE_OFFSET(entry) \
+	(offsetof(struct p4tc_table_entry, key) + P4TC_ENTRY_KEY_OFFSET \
+	 + P4TC_KEYSZ_BYTES((entry)->key.keysz))
+
+static inline void *p4tc_table_entry_value(struct p4tc_table_entry *entry)
+{
+	return entry->key.fa_key + P4TC_KEYSZ_BYTES(entry->key.keysz);
+}
+
+static inline struct p4tc_table_entry_work *
+p4tc_table_entry_work(struct p4tc_table_entry *entry)
+{
+	struct p4tc_table_entry_value *value = p4tc_table_entry_value(entry);
+
+	return value->entry_work;
+}
+
+extern const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1];
+extern const struct nla_policy p4tc_policy[P4TC_MAX + 1];
+
+struct p4tc_table_entry *
+p4tc_table_entry_lookup_direct(struct p4tc_table *table,
+			       struct p4tc_table_entry_key *key);
+
 static inline int p4tc_action_init(struct net *net, struct nlattr *nla,
 				   struct tc_action *acts[], u32 pipeid,
 				   u32 flags, struct netlink_ext_ack *extack)
@@ -390,6 +481,14 @@ p4tc_table_init_default_acts(struct net *net,
 			     struct list_head *acts_list,
 			     struct netlink_ext_ack *extack);
 
+static inline void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
+{
+	if (defact) {
+		p4tc_action_destroy(defact->default_acts);
+		kfree(defact);
+	}
+}
+
 static inline void
 p4tc_table_defacts_acts_copy(struct p4tc_table_defact *defact_copy,
 			     struct p4tc_table_defact *defact_orig)
@@ -404,15 +503,36 @@ p4tc_table_replace_default_acts(struct p4tc_table *table,
 
 struct p4tc_table_perm *
 p4tc_table_init_permissions(struct p4tc_table *table, u16 permissions,
-			    struct netlink_ext_ack *extack);
+			   struct netlink_ext_ack *extack);
 void p4tc_table_replace_permissions(struct p4tc_table *table,
 				    struct p4tc_table_perm *tbl_perm,
 				    bool lock_rtnl);
+void p4tc_table_entry_destroy_hash(void *ptr, void *arg);
+
+struct p4tc_table_entry *
+p4tc_table_const_entry_cu(struct net *net, struct nlattr *arg,
+			  struct p4tc_pipeline *pipeline,
+			  struct p4tc_table *table,
+			  struct netlink_ext_ack *extack);
+int p4tc_tbl_entry_crud(struct net *net, struct sk_buff *skb,
+			struct nlmsghdr *n, int cmd,
+			struct netlink_ext_ack *extack);
+int p4tc_tbl_entry_dumpit(struct net *net, struct sk_buff *skb,
+			  struct netlink_callback *cb,
+			  struct nlattr *arg, char *p_name);
+int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
+			struct p4tc_table_entry *entry, u32 tbl_id,
+			u16 who_deleted);
 
 struct tcf_p4act *
 p4a_runt_prealloc_get_next(struct p4tc_act *act);
 void p4a_runt_init_flags(struct tcf_p4act *p4act);
 
+static inline bool p4tc_runtime_msg_is_update(struct nlmsghdr *n)
+{
+	return n->nlmsg_type == RTM_P4TC_UPDATE;
+}
+
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
 #define p4tc_to_act(t) ((struct p4tc_act *)t)
 #define p4tc_to_table(t) ((struct p4tc_table *)t)
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 21f49de86..55fc660c9 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -88,6 +88,9 @@ enum {
 #define p4tc_ctrl_pub_ok(perm)      ((perm) & P4TC_CTRL_PERM_P)
 #define p4tc_ctrl_sub_ok(perm)      ((perm) & P4TC_CTRL_PERM_S)
 
+#define p4tc_ctrl_perm_rm_create(perm) \
+	(((perm) & ~P4TC_CTRL_PERM_C))
+
 #define p4tc_data_create_ok(perm)   ((perm) & P4TC_DATA_PERM_C)
 #define p4tc_data_read_ok(perm)     ((perm) & P4TC_DATA_PERM_R)
 #define p4tc_data_update_ok(perm)   ((perm) & P4TC_DATA_PERM_U)
@@ -96,6 +99,9 @@ enum {
 #define p4tc_data_pub_ok(perm)      ((perm) & P4TC_DATA_PERM_P)
 #define p4tc_data_sub_ok(perm)      ((perm) & P4TC_DATA_PERM_S)
 
+#define p4tc_data_perm_rm_create(perm) \
+	(((perm) & ~P4TC_DATA_PERM_C))
+
 struct p4tc_table_parm {
 	__u64 tbl_aging;
 	__u32 tbl_keysz;
@@ -129,6 +135,15 @@ enum {
 
 #define P4TC_OBJ_MAX (__P4TC_OBJ_MAX - 1)
 
+/* P4 runtime Object types */
+enum {
+	P4TC_OBJ_RUNTIME_UNSPEC,
+	P4TC_OBJ_RUNTIME_TABLE,
+	__P4TC_OBJ_RUNTIME_MAX,
+};
+
+#define P4TC_OBJ_RUNTIME_MAX (__P4TC_OBJ_RUNTIME_MAX - 1)
+
 /* P4 attributes */
 enum {
 	P4TC_UNSPEC,
@@ -216,7 +231,7 @@ enum {
 	P4TC_TABLE_INFO, /* struct p4tc_table_parm */
 	P4TC_TABLE_DEFAULT_HIT, /* nested default hit action attributes */
 	P4TC_TABLE_DEFAULT_MISS, /* nested default miss action attributes */
-	P4TC_TABLE_CONST_ENTRY, /* nested const table entry */
+	P4TC_TABLE_CONST_ENTRY, /* nested const table entry*/
 	P4TC_TABLE_ACTS_LIST, /* nested table actions list */
 	__P4TC_TABLE_MAX
 };
@@ -269,6 +284,57 @@ enum {
 
 #define P4TC_ACT_PARAMS_MAX (__P4TC_ACT_PARAMS_MAX - 1)
 
+struct p4tc_table_entry_tm {
+	__u64 created;
+	__u64 lastused;
+	__u64 firstused;
+	__u16 who_created;
+	__u16 who_updated;
+	__u16 who_deleted;
+	__u16 permissions;
+};
+
+enum {
+	P4TC_ENTRY_TBL_ATTRS_UNSPEC,
+	P4TC_ENTRY_TBL_ATTRS_DEFAULT_HIT, /* nested default hit attrs */
+	P4TC_ENTRY_TBL_ATTRS_DEFAULT_MISS, /* nested default miss attrs */
+	P4TC_ENTRY_TBL_ATTRS_PERMISSIONS, /* u16 table permissions */
+	__P4TC_ENTRY_TBL_ATTRS,
+};
+
+#define P4TC_ENTRY_TBL_ATTRS_MAX (__P4TC_ENTRY_TBL_ATTRS - 1)
+
+/* Table entry attributes */
+enum {
+	P4TC_ENTRY_UNSPEC,
+	P4TC_ENTRY_TBLNAME, /* string */
+	P4TC_ENTRY_KEY_BLOB, /* Key blob */
+	P4TC_ENTRY_MASK_BLOB, /* Mask blob */
+	P4TC_ENTRY_PRIO, /* u32 */
+	P4TC_ENTRY_ACT, /* nested actions */
+	P4TC_ENTRY_TM, /* entry data path timestamps */
+	P4TC_ENTRY_WHODUNNIT, /* tells who's modifying the entry */
+	P4TC_ENTRY_CREATE_WHODUNNIT, /* tells who created the entry */
+	P4TC_ENTRY_UPDATE_WHODUNNIT, /* tells who updated the entry last */
+	P4TC_ENTRY_DELETE_WHODUNNIT, /* tells who deleted the entry */
+	P4TC_ENTRY_PERMISSIONS, /* entry CRUDXPS permissions */
+	P4TC_ENTRY_TBL_ATTRS, /* nested table attributes */
+	P4TC_ENTRY_DYNAMIC, /* u8 tells if table entry is dynamic */
+	P4TC_ENTRY_AGING, /* u64 table entry aging */
+	P4TC_ENTRY_PAD,
+	__P4TC_ENTRY_MAX
+};
+
+#define P4TC_ENTRY_MAX (__P4TC_ENTRY_MAX - 1)
+
+enum {
+	P4TC_ENTITY_UNSPEC,
+	P4TC_ENTITY_KERNEL,
+	P4TC_ENTITY_TC,
+	P4TC_ENTITY_TIMER,
+	P4TC_ENTITY_MAX
+};
+
 #define P4TC_RTA(r) \
 	((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct p4tcmsg))))
 
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 4f9ebe3e7..76645560b 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -203,6 +203,15 @@ enum {
 	RTM_UPDATEP4TEMPLATE,
 #define RTM_UPDATEP4TEMPLATE	RTM_UPDATEP4TEMPLATE
 
+	RTM_P4TC_CREATE = 128,
+#define RTM_P4TC_CREATE	RTM_P4TC_CREATE
+	RTM_P4TC_DEL,
+#define RTM_P4TC_DEL		RTM_P4TC_DEL
+	RTM_P4TC_GET,
+#define RTM_P4TC_GET		RTM_P4TC_GET
+	RTM_P4TC_UPDATE,
+#define RTM_P4TC_UPDATE	RTM_P4TC_UPDATE
+
 	__RTM_MAX,
 #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
 };
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 7a9c13f86..921909ac4 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
-	p4tc_action.o p4tc_table.o
+	p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
+	p4tc_runtime_api.o
diff --git a/net/sched/p4tc/p4tc_runtime_api.c b/net/sched/p4tc/p4tc_runtime_api.c
new file mode 100644
index 000000000..fe9d9703c
--- /dev/null
+++ b/net/sched/p4tc/p4tc_runtime_api.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_runtime_api.c P4 TC RUNTIME API
+ *
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
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
+#include <linux/kmod.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/bitmap.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <net/sch_generic.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+#include <net/flow_offload.h>
+
+static int tc_ctl_p4_root(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
+			  struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+
+	switch (t->obj) {
+	case P4TC_OBJ_RUNTIME_TABLE: {
+		struct net *net = sock_net(skb->sk);
+		int ret;
+
+		net = maybe_get_net(net);
+		if (!net) {
+			NL_SET_ERR_MSG(extack, "Net namespace is going down");
+			return -EBUSY;
+		}
+
+		ret = p4tc_tbl_entry_crud(net, skb, n, cmd, extack);
+
+		put_net(net);
+
+		return ret;
+	}
+	default:
+		NL_SET_ERR_MSG(extack, "Unknown P4 runtime object type");
+		return -EOPNOTSUPP;
+	}
+}
+
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
+static int tc_ctl_p4_cu(struct sk_buff *skb, struct nlmsghdr *n,
+			struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	ret = tc_ctl_p4_root(skb, n, n->nlmsg_type, extack);
+
+	return ret;
+}
+
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
+static int __init p4tc_tbl_init(void)
+{
+	rtnl_register(PF_UNSPEC, RTM_P4TC_CREATE, tc_ctl_p4_cu, NULL,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+	rtnl_register(PF_UNSPEC, RTM_P4TC_UPDATE, tc_ctl_p4_cu, NULL,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+	rtnl_register(PF_UNSPEC, RTM_P4TC_DEL, tc_ctl_p4_delete, NULL,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+	rtnl_register(PF_UNSPEC, RTM_P4TC_GET, tc_ctl_p4_get, tc_ctl_p4_dump,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+
+	return 0;
+}
+
+subsys_initcall(p4tc_tbl_init);
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index ac6c28e2d..df3fd3eef 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -144,6 +144,7 @@ static int _p4tc_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
 	parm.tbl_max_masks = table->tbl_max_masks;
 	parm.tbl_type = table->tbl_type;
 	parm.tbl_aging = table->tbl_aging;
+	parm.tbl_num_entries = atomic_read(&table->tbl_nelems);
 
 	tbl_perm = rcu_dereference_rtnl(table->tbl_permissions);
 	parm.tbl_permissions = tbl_perm->permissions;
@@ -217,6 +218,16 @@ static int _p4tc_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
 	}
 	nla_nest_end(skb, nested_tbl_acts);
 
+	if (table->tbl_const_entry) {
+		struct nlattr *const_nest;
+
+		const_nest = nla_nest_start(skb, P4TC_TABLE_CONST_ENTRY);
+		p4tc_tbl_entry_fill(skb, table, table->tbl_const_entry,
+				    table->tbl_id, P4TC_ENTITY_UNSPEC);
+		nla_nest_end(skb, const_nest);
+	}
+	table->tbl_const_entry = NULL;
+
 	if (nla_put(skb, P4TC_TABLE_INFO, sizeof(parm), &parm))
 		goto out_nlmsg_trim;
 	nla_nest_end(skb, nest);
@@ -243,14 +254,6 @@ static int p4tc_table_fill_nlmsg(struct net *net, struct sk_buff *skb,
 	return 0;
 }
 
-static inline void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
-{
-	if (defact) {
-		p4tc_action_destroy(defact->default_acts);
-		kfree(defact);
-	}
-}
-
 static void p4tc_table_acts_list_destroy(struct list_head *acts_list)
 {
 	struct p4tc_table_act *table_act, *tmp;
@@ -375,8 +378,11 @@ static int _p4tc_table_put(struct net *net, struct nlattr **tb,
 
 	p4tc_table_acts_list_destroy(&table->tbl_acts_list);
 
+	rhltable_free_and_destroy(&table->tbl_entries,
+				  p4tc_table_entry_destroy_hash, table);
+
 	idr_destroy(&table->tbl_masks_idr);
-	idr_destroy(&table->tbl_prio_idr);
+	ida_destroy(&table->tbl_prio_idr);
 
 	perm = rcu_replace_pointer_rtnl(table->tbl_permissions, NULL);
 	kfree_rcu(perm, rcu);
@@ -900,6 +906,7 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 					    struct p4tc_pipeline *pipeline,
 					    struct netlink_ext_ack *extack)
 {
+	struct rhashtable_params table_hlt_params = entry_hlt_params;
 	struct p4tc_table_default_act_params def_params = {0};
 	struct p4tc_table_perm *tbl_init_perms = NULL;
 	struct p4tc_table_parm *parm;
@@ -1122,12 +1129,24 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 	}
 
 	idr_init(&table->tbl_masks_idr);
-	idr_init(&table->tbl_prio_idr);
+	ida_init(&table->tbl_prio_idr);
 	spin_lock_init(&table->tbl_masks_idr_lock);
 
+	table_hlt_params.max_size = table->tbl_max_entries;
+	if (table->tbl_max_entries > U16_MAX)
+		table_hlt_params.nelem_hint = U16_MAX / 4 * 3;
+	else
+		table_hlt_params.nelem_hint = table->tbl_max_entries / 4 * 3;
+
+	if (rhltable_init(&table->tbl_entries, &table_hlt_params) < 0) {
+		ret = -EINVAL;
+		goto defaultacts_destroy;
+	}
+
 	pipeline->curr_tables += 1;
 
 	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
+	atomic_set(&table->tbl_nelems, 0);
 
 	return table;
 
@@ -1284,6 +1303,21 @@ static struct p4tc_table *p4tc_table_update(struct net *net, struct nlattr **tb,
 		}
 	}
 
+	if (tb[P4TC_TABLE_CONST_ENTRY]) {
+		struct p4tc_table_entry *entry;
+
+		/* Workaround to make this work */
+		entry = p4tc_table_const_entry_cu(net,
+						  tb[P4TC_TABLE_CONST_ENTRY],
+						  pipeline, table, extack);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry);
+			goto free_perm;
+		}
+
+		table->tbl_const_entry = entry;
+	}
+
 	p4tc_table_replace_default_acts(table, &def_params, false);
 	p4tc_table_replace_permissions(table, perm, false);
 
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
new file mode 100644
index 000000000..ee1ecdf71
--- /dev/null
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -0,0 +1,2572 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_tbl_entry.c P4 TC TABLE ENTRY
+ *
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
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
+#include <linux/kmod.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/bitmap.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <net/sch_generic.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+#include <net/flow_offload.h>
+
+#define SIZEOF_MASKID (sizeof(((struct p4tc_table_entry_key *)0)->maskid))
+
+#define STARTOF_KEY(key) (&((key)->maskid))
+
+/* In this code we avoid locks for create/updating/deleting table entries by
+ * using a refcount (entries_ref). We also use RCU to avoid locks for reading.
+ * Everytime we try to get the entry, we increment and check the refcount to see
+ * whether a delete is happening in parallel.
+ */
+
+static int p4tc_tbl_entry_get(struct p4tc_table_entry_value *value)
+{
+	return refcount_inc_not_zero(&value->entries_ref);
+}
+
+static bool p4tc_tbl_entry_put(struct p4tc_table_entry_value *value)
+{
+	return refcount_dec_if_one(&value->entries_ref);
+}
+
+static bool p4tc_tbl_entry_put_ref(struct p4tc_table_entry_value *value)
+{
+	return refcount_dec_not_one(&value->entries_ref);
+}
+
+static u32 p4tc_entry_hash_fn(const void *data, u32 len, u32 seed)
+{
+	const struct p4tc_table_entry_key *key = data;
+	u32 keysz;
+
+	/* The key memory area is always zero allocated aligned to 8 */
+	keysz = round_up(SIZEOF_MASKID + (key->keysz >> 3), 4);
+
+	return jhash2(STARTOF_KEY(key), keysz / sizeof(u32), seed);
+}
+
+static int p4tc_entry_hash_cmp(struct rhashtable_compare_arg *arg,
+			       const void *ptr)
+{
+	const struct p4tc_table_entry_key *key = arg->key;
+	const struct p4tc_table_entry *entry = ptr;
+	u32 keysz;
+
+	keysz = SIZEOF_MASKID + (entry->key.keysz >> 3);
+
+	return memcmp(STARTOF_KEY(&entry->key), STARTOF_KEY(key), keysz);
+}
+
+static u32 p4tc_entry_obj_hash_fn(const void *data, u32 len, u32 seed)
+{
+	const struct p4tc_table_entry *entry = data;
+
+	return p4tc_entry_hash_fn(&entry->key, len, seed);
+}
+
+const struct rhashtable_params entry_hlt_params = {
+	.obj_cmpfn = p4tc_entry_hash_cmp,
+	.obj_hashfn = p4tc_entry_obj_hash_fn,
+	.hashfn = p4tc_entry_hash_fn,
+	.head_offset = offsetof(struct p4tc_table_entry, ht_node),
+	.key_offset = offsetof(struct p4tc_table_entry, key),
+	.automatic_shrinking = true,
+};
+
+static struct rhlist_head *
+p4tc_entry_lookup_bucket(struct p4tc_table *table,
+			 struct p4tc_table_entry_key *key)
+{
+	return rhltable_lookup(&table->tbl_entries, key, entry_hlt_params);
+}
+
+static struct p4tc_table_entry *
+__p4tc_entry_lookup_fast(struct p4tc_table *table,
+			 struct p4tc_table_entry_key *key)
+	__must_hold(RCU)
+{
+	struct p4tc_table_entry *entry_curr;
+	struct rhlist_head *bucket_list;
+
+	bucket_list =
+		p4tc_entry_lookup_bucket(table, key);
+	if (!bucket_list)
+		return NULL;
+
+	rht_entry(entry_curr, bucket_list, ht_node);
+
+	return entry_curr;
+}
+
+static struct p4tc_table_entry *
+p4tc_entry_lookup(struct p4tc_table *table, struct p4tc_table_entry_key *key,
+		  u32 prio) __must_hold(RCU)
+{
+	struct rhlist_head *tmp, *bucket_list;
+	struct p4tc_table_entry *entry;
+
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT)
+		return __p4tc_entry_lookup_fast(table, key);
+
+	bucket_list =
+		p4tc_entry_lookup_bucket(table, key);
+	if (!bucket_list)
+		return NULL;
+
+	rhl_for_each_entry_rcu(entry, tmp, bucket_list, ht_node) {
+		struct p4tc_table_entry_value *value =
+			p4tc_table_entry_value(entry);
+
+		if (value->prio == prio)
+			return entry;
+	}
+
+	return NULL;
+}
+
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
+static void mask_key(const struct p4tc_table_entry_mask *mask, u8 *masked_key,
+		     u8 *skb_key)
+{
+	int i;
+
+	for (i = 0; i < BITS_TO_BYTES(mask->sz); i++)
+		masked_key[i] = skb_key[i] & mask->fa_value[i];
+}
+
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
+		mask_key(mask, mkey->fa_key, key->fa_key);
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
+#define p4tc_table_entry_mask_find_byid(table, id) \
+	(idr_find(&(table)->tbl_masks_idr, id))
+
+static void gen_exact_mask(u8 *mask, u32 mask_size)
+{
+	memset(mask, 0xFF, mask_size);
+}
+
+static int p4tca_table_get_entry_keys(struct sk_buff *skb,
+				      struct p4tc_table *table,
+				      struct p4tc_table_entry *entry)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_table_entry_mask *mask;
+	int ret = -ENOMEM;
+	u32 key_sz_bytes;
+
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT) {
+		u8 mask_value[BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+
+		key_sz_bytes = BITS_TO_BYTES(entry->key.keysz);
+		if (nla_put(skb, P4TC_ENTRY_KEY_BLOB, key_sz_bytes,
+			    entry->key.fa_key))
+			goto out_nlmsg_trim;
+
+		gen_exact_mask(mask_value, key_sz_bytes);
+		if (nla_put(skb, P4TC_ENTRY_MASK_BLOB, key_sz_bytes, mask_value))
+			goto out_nlmsg_trim;
+	} else {
+		key_sz_bytes = BITS_TO_BYTES(entry->key.keysz);
+		if (nla_put(skb, P4TC_ENTRY_KEY_BLOB, key_sz_bytes,
+			    entry->key.fa_key))
+			goto out_nlmsg_trim;
+
+		mask = p4tc_table_entry_mask_find_byid(table,
+						       entry->key.maskid);
+		if (nla_put(skb, P4TC_ENTRY_MASK_BLOB, key_sz_bytes,
+			    mask->fa_value))
+			goto out_nlmsg_trim;
+	}
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return ret;
+}
+
+static void p4tc_table_entry_tm_dump(struct p4tc_table_entry_tm *dtm,
+				     struct p4tc_table_entry_tm *stm)
+{
+	unsigned long now = jiffies;
+	u64 last_used;
+
+	dtm->created = stm->created ?
+		jiffies_to_clock_t(now - stm->created) : 0;
+
+	last_used = READ_ONCE(stm->lastused);
+	dtm->lastused = stm->lastused ?
+		jiffies_to_clock_t(now - last_used) : 0;
+	dtm->firstused = stm->firstused ?
+		jiffies_to_clock_t(now - stm->firstused) : 0;
+}
+
+#define P4TC_ENTRY_MAX_IDS (P4TC_PATH_MAX - 1)
+
+int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
+			struct p4tc_table_entry *entry, u32 tbl_id,
+			u16 who_deleted)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry_tm dtm, *tm;
+	struct nlattr *nest, *nest_acts;
+	u32 ids[P4TC_ENTRY_MAX_IDS];
+	int ret = -ENOMEM;
+
+	ids[P4TC_TBLID_IDX - 1] = tbl_id;
+
+	if (nla_put(skb, P4TC_PATH, P4TC_ENTRY_MAX_IDS * sizeof(u32), ids))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	value = p4tc_table_entry_value(entry);
+
+	if (nla_put_u32(skb, P4TC_ENTRY_PRIO, value->prio))
+		goto out_nlmsg_trim;
+
+	if (p4tca_table_get_entry_keys(skb, table, entry) < 0)
+		goto out_nlmsg_trim;
+
+	if (value->acts) {
+		nest_acts = nla_nest_start(skb, P4TC_ENTRY_ACT);
+		if (tcf_action_dump(skb, value->acts, 0, 0, false) < 0)
+			goto out_nlmsg_trim;
+		nla_nest_end(skb, nest_acts);
+	}
+
+	if (nla_put_u16(skb, P4TC_ENTRY_PERMISSIONS, value->permissions))
+		goto out_nlmsg_trim;
+
+	tm = rcu_dereference_protected(value->tm, 1);
+
+	if (nla_put_u8(skb, P4TC_ENTRY_CREATE_WHODUNNIT, tm->who_created))
+		goto out_nlmsg_trim;
+
+	if (tm->who_updated) {
+		if (nla_put_u8(skb, P4TC_ENTRY_UPDATE_WHODUNNIT,
+			       tm->who_updated))
+			goto out_nlmsg_trim;
+	}
+
+	if (who_deleted) {
+		if (nla_put_u8(skb, P4TC_ENTRY_DELETE_WHODUNNIT,
+			       who_deleted))
+			goto out_nlmsg_trim;
+	}
+
+	p4tc_table_entry_tm_dump(&dtm, tm);
+	if (nla_put_64bit(skb, P4TC_ENTRY_TM, sizeof(dtm), &dtm,
+			  P4TC_ENTRY_PAD))
+		goto out_nlmsg_trim;
+
+	if (value->is_dyn) {
+		if (nla_put_u8(skb, P4TC_ENTRY_DYNAMIC, 1))
+			goto out_nlmsg_trim;
+	}
+
+	if (value->aging_ms) {
+		if (nla_put_u64_64bit(skb, P4TC_ENTRY_AGING, value->aging_ms,
+				      P4TC_ENTRY_PAD))
+			goto out_nlmsg_trim;
+	}
+
+	nla_nest_end(skb, nest);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return ret;
+}
+
+static struct netlink_range_validation range_aging = {
+	.min = 1,
+	.max = P4TC_MAX_T_AGING_MS,
+};
+
+static const struct nla_policy p4tc_entry_policy[P4TC_ENTRY_MAX + 1] = {
+	[P4TC_ENTRY_TBLNAME] = { .type = NLA_STRING },
+	[P4TC_ENTRY_KEY_BLOB] = { .type = NLA_BINARY },
+	[P4TC_ENTRY_MASK_BLOB] = { .type = NLA_BINARY },
+	[P4TC_ENTRY_PRIO] = { .type = NLA_U32 },
+	[P4TC_ENTRY_ACT] = { .type = NLA_NESTED },
+	[P4TC_ENTRY_TM] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct p4tc_table_entry_tm)),
+	[P4TC_ENTRY_WHODUNNIT] = { .type = NLA_U8 },
+	[P4TC_ENTRY_CREATE_WHODUNNIT] = { .type = NLA_U8 },
+	[P4TC_ENTRY_UPDATE_WHODUNNIT] = { .type = NLA_U8 },
+	[P4TC_ENTRY_DELETE_WHODUNNIT] = { .type = NLA_U8 },
+	[P4TC_ENTRY_PERMISSIONS] = NLA_POLICY_MAX(NLA_U16, P4TC_MAX_PERMISSION),
+	[P4TC_ENTRY_TBL_ATTRS] = { .type = NLA_NESTED },
+	[P4TC_ENTRY_DYNAMIC] = NLA_POLICY_RANGE(NLA_U8, 1, 1),
+	[P4TC_ENTRY_AGING] = NLA_POLICY_FULL_RANGE(NLA_U64, &range_aging),
+};
+
+static struct p4tc_table_entry_mask *
+p4tc_table_entry_mask_find_byvalue(struct p4tc_table *table,
+				   struct p4tc_table_entry_mask *mask)
+{
+	struct p4tc_table_entry_mask *mask_cur;
+	unsigned long mask_id, tmp;
+
+	idr_for_each_entry_ul(&table->tbl_masks_idr, mask_cur, tmp, mask_id) {
+		if (mask_cur->sz == mask->sz) {
+			u32 mask_sz_bytes = BITS_TO_BYTES(mask->sz);
+			void *curr_mask_value = mask_cur->fa_value;
+			void *mask_value = mask->fa_value;
+
+			if (memcmp(curr_mask_value, mask_value, mask_sz_bytes) == 0)
+				return mask_cur;
+		}
+	}
+
+	return NULL;
+}
+
+static void __p4tc_table_entry_mask_del(struct p4tc_table *table,
+					struct p4tc_table_entry_mask *mask)
+{
+	if (table->tbl_type == P4TC_TABLE_TYPE_TERNARY) {
+		struct p4tc_table_entry_mask __rcu **masks_array;
+		unsigned long *free_masks_bitmap;
+
+		masks_array = table->tbl_masks_array;
+		rcu_assign_pointer(masks_array[mask->mask_index], NULL);
+
+		free_masks_bitmap =
+			rcu_dereference_protected(table->tbl_free_masks_bitmap,
+						  1);
+		bitmap_set(free_masks_bitmap, mask->mask_index, 1);
+	} else if (table->tbl_type == P4TC_TABLE_TYPE_LPM) {
+		struct p4tc_table_entry_mask __rcu **masks_array;
+		int i;
+
+		masks_array = table->tbl_masks_array;
+
+		for (i = mask->mask_index; i < table->tbl_curr_num_masks - 1;
+		     i++) {
+			struct p4tc_table_entry_mask *mask_tmp;
+
+			mask_tmp = rcu_dereference_protected(masks_array[i + 1],
+							     1);
+			rcu_assign_pointer(masks_array[i + 1], mask_tmp);
+		}
+
+		rcu_assign_pointer(masks_array[table->tbl_curr_num_masks - 1],
+				   NULL);
+	}
+
+	table->tbl_curr_num_masks--;
+}
+
+static void p4tc_table_entry_mask_del(struct p4tc_table *table,
+				      struct p4tc_table_entry *entry)
+{
+	struct p4tc_table_entry_mask *mask_found;
+	const u32 mask_id = entry->key.maskid;
+
+	/* Will always be found */
+	mask_found = p4tc_table_entry_mask_find_byid(table, mask_id);
+
+	/* Last reference, can delete */
+	if (refcount_dec_if_one(&mask_found->mask_ref)) {
+		spin_lock_bh(&table->tbl_masks_idr_lock);
+		idr_remove(&table->tbl_masks_idr, mask_found->mask_id);
+		__p4tc_table_entry_mask_del(table, mask_found);
+		spin_unlock_bh(&table->tbl_masks_idr_lock);
+		kfree_rcu(mask_found, rcu);
+	} else {
+		if (!refcount_dec_not_one(&mask_found->mask_ref))
+			pr_warn("Mask was deleted in parallel");
+	}
+}
+
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+static u32 p4tc_fls(u8 *ptr, size_t len)
+{
+	int i;
+
+	for (i = len - 1; i >= 0; i--) {
+		int pos = fls(ptr[i]);
+
+		if (pos)
+			return (i * 8) + pos;
+	}
+
+	return 0;
+}
+#else
+static u32 p4tc_ffs(u8 *ptr, size_t len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		int pos = ffs(ptr[i]);
+
+		if (pos)
+			return (i * 8) + pos;
+	}
+
+	return 0;
+}
+#endif
+
+static u32 find_lpm_mask(struct p4tc_table *table, u8 *ptr)
+{
+	u32 ret;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	ret = p4tc_fls(ptr, BITS_TO_BYTES(table->tbl_keysz));
+#else
+	ret = p4tc_ffs(ptr, BITS_TO_BYTES(table->tbl_keysz));
+#endif
+	return ret ?: table->tbl_keysz;
+}
+
+static int p4tc_table_lpm_mask_insert(struct p4tc_table *table,
+				      struct p4tc_table_entry_mask *mask)
+{
+	struct p4tc_table_entry_mask __rcu **masks_array =
+		table->tbl_masks_array;
+	const u32 nmasks = table->tbl_curr_num_masks ?: 1;
+	int pos;
+
+	for (pos = 0; pos < nmasks; pos++) {
+		u32 mask_value = find_lpm_mask(table, mask->fa_value);
+
+		if (table->tbl_masks_array[pos]) {
+			struct p4tc_table_entry_mask *mask_pos;
+			u32 array_mask_value;
+
+			mask_pos = rcu_dereference_protected(masks_array[pos],
+							     1);
+			array_mask_value =
+				find_lpm_mask(table, mask_pos->fa_value);
+
+			if (mask_value > array_mask_value) {
+				/* shift masks to the right (will keep invariant) */
+				u32 tail = nmasks;
+
+				while (tail > pos + 1) {
+					rcu_assign_pointer(masks_array[tail],
+							   masks_array[tail - 1]);
+					table->tbl_masks_array[tail] =
+						table->tbl_masks_array[tail - 1];
+					tail--;
+				}
+				rcu_assign_pointer(masks_array[pos + 1],
+						   masks_array[pos]);
+				/* assign to pos */
+				break;
+			}
+		} else {
+			/* pos is empty, assign to pos */
+			break;
+		}
+	}
+
+	mask->mask_index = pos;
+	rcu_assign_pointer(masks_array[pos], mask);
+	table->tbl_curr_num_masks++;
+
+	return 0;
+}
+
+static int
+p4tc_table_ternary_mask_insert(struct p4tc_table *table,
+			       struct p4tc_table_entry_mask *mask)
+{
+	unsigned long *free_masks_bitmap =
+		rcu_dereference_protected(table->tbl_free_masks_bitmap, 1);
+	unsigned long pos =
+		find_first_bit(free_masks_bitmap, P4TC_MAX_TMASKS);
+	struct p4tc_table_entry_mask __rcu **masks_array =
+		table->tbl_masks_array;
+
+	if (pos == P4TC_MAX_TMASKS)
+		return -ENOSPC;
+
+	mask->mask_index = pos;
+	rcu_assign_pointer(masks_array[pos], mask);
+	bitmap_clear(free_masks_bitmap, pos, 1);
+	table->tbl_curr_num_masks++;
+
+	return 0;
+}
+
+static int p4tc_table_add_mask_array(struct p4tc_table *table,
+				     struct p4tc_table_entry_mask *mask)
+{
+	if (table->tbl_max_masks < table->tbl_curr_num_masks + 1)
+		return -ENOSPC;
+
+	switch (table->tbl_type) {
+	case P4TC_TABLE_TYPE_TERNARY:
+		return p4tc_table_ternary_mask_insert(table, mask);
+	case P4TC_TABLE_TYPE_LPM:
+		return p4tc_table_lpm_mask_insert(table, mask);
+	default:
+		return -ENOSPC;
+	}
+}
+
+/* TODO: Ordering optimisation for LPM */
+static struct p4tc_table_entry_mask *
+p4tc_table_entry_mask_add(struct p4tc_table *table,
+			  struct p4tc_table_entry *entry,
+			  struct p4tc_table_entry_mask *mask)
+{
+	struct p4tc_table_entry_mask *mask_found;
+	int ret;
+
+	mask_found = p4tc_table_entry_mask_find_byvalue(table, mask);
+	/* Only add mask if it was not already added */
+	if (!mask_found) {
+		struct p4tc_table_entry_mask *nmask;
+		size_t mask_sz_bytes = BITS_TO_BYTES(mask->sz);
+
+		nmask = kzalloc(struct_size(mask_found, fa_value, mask_sz_bytes), GFP_ATOMIC);
+		if (unlikely(!nmask))
+			return ERR_PTR(-ENOMEM);
+
+		memcpy(nmask->fa_value, mask->fa_value, mask_sz_bytes);
+
+		nmask->mask_id = 1;
+		nmask->sz = mask->sz;
+		refcount_set(&nmask->mask_ref, 1);
+
+		spin_lock_bh(&table->tbl_masks_idr_lock);
+		ret = idr_alloc_u32(&table->tbl_masks_idr, nmask,
+				    &nmask->mask_id, UINT_MAX, GFP_ATOMIC);
+		if (ret < 0)
+			goto unlock;
+
+		ret = p4tc_table_add_mask_array(table, nmask);
+unlock:
+		spin_unlock_bh(&table->tbl_masks_idr_lock);
+		if (ret < 0) {
+			kfree(nmask);
+			return ERR_PTR(ret);
+		}
+		entry->key.maskid = nmask->mask_id;
+		mask_found = nmask;
+	} else {
+		if (!refcount_inc_not_zero(&mask_found->mask_ref))
+			return ERR_PTR(-EBUSY);
+		entry->key.maskid = mask_found->mask_id;
+	}
+
+	return mask_found;
+}
+
+static int p4tc_tbl_entry_emit_event(struct p4tc_table_entry_work *entry_work,
+				     int cmd, gfp_t alloc_flags)
+{
+	struct p4tc_pipeline *pipeline = entry_work->pipeline;
+	struct p4tc_table_entry *entry = entry_work->entry;
+	struct p4tc_table *table = entry_work->table;
+	u16 who_deleted = entry_work->who_deleted;
+	struct net *net = pipeline->net;
+	struct sock *rtnl = net->rtnl;
+	struct nlmsghdr *nlh;
+	struct nlattr *nest;
+	struct sk_buff *skb;
+	struct nlattr *root;
+	struct p4tcmsg *t;
+	int err = -ENOMEM;
+
+	if (!rtnl_has_listeners(net, RTNLGRP_TC))
+		return 0;
+
+	skb = alloc_skb(NLMSG_GOODSIZE, alloc_flags);
+	if (!skb)
+		return err;
+
+	nlh = nlmsg_put(skb, 1, 1, cmd, sizeof(*t), NLM_F_REQUEST);
+	if (!nlh)
+		goto free_skb;
+
+	t = nlmsg_data(nlh);
+	if (!t)
+		goto free_skb;
+
+	t->pipeid = pipeline->common.p_id;
+	t->obj = P4TC_OBJ_RUNTIME_TABLE;
+
+	if (nla_put_string(skb, P4TC_ROOT_PNAME, pipeline->common.name))
+		goto free_skb;
+
+	root = nla_nest_start(skb, P4TC_ROOT);
+	if (!root)
+		goto free_skb;
+
+	nest = nla_nest_start(skb, 1);
+	if (p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id,
+				who_deleted) < 0)
+		goto free_skb;
+	nla_nest_end(skb, nest);
+
+	nla_nest_end(skb, root);
+
+	nlmsg_end(skb, nlh);
+
+	return nlmsg_notify(rtnl, skb, 0, RTNLGRP_TC, 0, alloc_flags);
+
+free_skb:
+	kfree_skb(skb);
+	return err;
+}
+
+static void __p4tc_table_entry_put(struct p4tc_table_entry *entry)
+{
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry_tm *tm;
+
+	value = p4tc_table_entry_value(entry);
+
+	if (value->acts)
+		p4tc_action_destroy(value->acts);
+
+	kfree(value->entry_work);
+	tm = rcu_dereference_protected(value->tm, 1);
+	kfree(tm);
+
+	kfree(entry);
+}
+
+static void p4tc_table_entry_del_work(struct work_struct *work)
+{
+	struct p4tc_table_entry_work *entry_work =
+		container_of(work, typeof(*entry_work), work);
+	struct p4tc_pipeline *pipeline = entry_work->pipeline;
+	struct p4tc_table_entry *entry = entry_work->entry;
+	struct p4tc_table_entry_value *value;
+
+	value = p4tc_table_entry_value(entry);
+
+	if (entry_work->send_event && p4tc_ctrl_pub_ok(value->permissions))
+		p4tc_tbl_entry_emit_event(entry_work, RTM_P4TC_DEL, GFP_KERNEL);
+
+	if (value->is_dyn)
+		hrtimer_cancel(&value->entry_timer);
+
+	put_net(pipeline->net);
+	p4tc_pipeline_put_ref(pipeline);
+
+	__p4tc_table_entry_put(entry);
+}
+
+static void p4tc_table_entry_put(struct p4tc_table_entry *entry, bool deferred)
+{
+	struct p4tc_table_entry_value *value = p4tc_table_entry_value(entry);
+
+	if (deferred) {
+		struct p4tc_table_entry_work *entry_work = value->entry_work;
+		/* We have to free tc actions
+		 * in a sleepable context
+		 */
+		struct p4tc_pipeline *pipeline = entry_work->pipeline;
+
+		/* Avoid pipeline del before deferral ends */
+		p4tc_pipeline_get(pipeline);
+		get_net(pipeline->net); /* avoid action cleanup */
+		schedule_work(&entry_work->work);
+	} else {
+		if (value->is_dyn)
+			hrtimer_cancel(&value->entry_timer);
+
+		__p4tc_table_entry_put(entry);
+	}
+}
+
+static void p4tc_table_entry_put_rcu(struct rcu_head *rcu)
+{
+	struct p4tc_table_entry *entry =
+		container_of(rcu, struct p4tc_table_entry, rcu);
+	struct p4tc_table_entry_work *entry_work =
+		p4tc_table_entry_work(entry);
+	struct p4tc_pipeline *pipeline = entry_work->pipeline;
+
+	p4tc_table_entry_put(entry, true);
+
+	p4tc_pipeline_put_ref(pipeline);
+	put_net(pipeline->net);
+}
+
+static void __p4tc_table_entry_destroy(struct p4tc_table *table,
+				       struct p4tc_table_entry *entry,
+				       bool remove_from_hash, bool send_event,
+				       u16 who_deleted)
+{
+	/* !remove_from_hash and deferred deletion are incompatible
+	 * as entries that defer deletion after a GP __must__
+	 * be removed from the hash
+	 */
+	if (remove_from_hash)
+		rhltable_remove(&table->tbl_entries, &entry->ht_node,
+				entry_hlt_params);
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		p4tc_table_entry_mask_del(table, entry);
+
+	if (remove_from_hash) {
+		struct p4tc_table_entry_work *entry_work =
+			p4tc_table_entry_work(entry);
+
+		entry_work->send_event = send_event;
+		entry_work->who_deleted = who_deleted;
+		/* guarantee net doesn't go down before async task runs */
+		get_net(entry_work->pipeline->net);
+		/* guarantee pipeline isn't deleted before async task runs */
+		p4tc_pipeline_get(entry_work->pipeline);
+		call_rcu(&entry->rcu, p4tc_table_entry_put_rcu);
+	} else {
+		p4tc_table_entry_put(entry, false);
+	}
+}
+
+#define P4TC_TABLE_EXACT_PRIO 64000
+
+static int p4tc_table_entry_exact_prio(void)
+{
+	return P4TC_TABLE_EXACT_PRIO;
+}
+
+static int p4tc_table_entry_alloc_new_prio(struct p4tc_table *table)
+{
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT)
+		return p4tc_table_entry_exact_prio();
+
+	return ida_alloc_min(&table->tbl_prio_idr, 1,
+			     GFP_ATOMIC);
+}
+
+static void p4tc_table_entry_free_prio(struct p4tc_table *table, u32 prio)
+{
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		ida_free(&table->tbl_prio_idr, prio);
+}
+
+static int p4tc_table_entry_destroy(struct p4tc_table *table,
+				    struct p4tc_table_entry *entry,
+				    bool remove_from_hash,
+				    bool send_event, u16 who_deleted)
+{
+	struct p4tc_table_entry_value *value = p4tc_table_entry_value(entry);
+
+	/* Entry was deleted in parallel */
+	if (!p4tc_tbl_entry_put(value))
+		return -EBUSY;
+
+	p4tc_table_entry_free_prio(table, value->prio);
+
+	__p4tc_table_entry_destroy(table, entry, remove_from_hash, send_event,
+				   who_deleted);
+
+	atomic_dec(&table->tbl_nelems);
+
+	return 0;
+}
+
+static void p4tc_table_entry_destroy_noida(struct p4tc_table *table,
+					   struct p4tc_table_entry *entry)
+{
+	/* Entry refcount was already decremented */
+	__p4tc_table_entry_destroy(table, entry, true, false, 0);
+}
+
+/* Only deletes entries when called from pipeline put */
+void p4tc_table_entry_destroy_hash(void *ptr, void *arg)
+{
+	struct p4tc_table_entry *entry = ptr;
+	struct p4tc_table *table = arg;
+
+	p4tc_table_entry_destroy(table, entry, false, false,
+				 P4TC_ENTITY_TC);
+}
+
+static void p4tc_table_entry_put_table(struct p4tc_pipeline *pipeline,
+				       struct p4tc_table *table)
+{
+	p4tc_table_put_ref(table);
+	p4tc_pipeline_put_ref(pipeline);
+}
+
+static int p4tc_table_entry_get_table(struct net *net,
+				      struct p4tc_pipeline **pipeline,
+				      struct p4tc_table **table,
+				      struct nlattr **tb,
+				      struct p4tc_path_nlattrs *nl_path_attrs,
+				      struct netlink_ext_ack *extack)
+{
+	/* The following can only race with user driven events
+	 * Netns is guaranteed to be alive
+	 */
+	u32 *ids = nl_path_attrs->ids;
+	u32 pipeid, tbl_id;
+	char *tblname;
+	int ret;
+
+	rcu_read_lock();
+
+	pipeid = ids[P4TC_PID_IDX];
+
+	*pipeline = p4tc_pipeline_find_get(net, nl_path_attrs->pname, pipeid,
+					   extack);
+	if (IS_ERR(*pipeline)) {
+		ret = PTR_ERR(*pipeline);
+		goto out;
+	}
+
+	if (!p4tc_pipeline_sealed(*pipeline)) {
+		NL_SET_ERR_MSG(extack,
+			       "Need to seal pipeline before issuing runtime command");
+		ret = -EINVAL;
+		goto put;
+	}
+
+	tbl_id = ids[P4TC_TBLID_IDX];
+	tblname = tb[P4TC_ENTRY_TBLNAME] ? nla_data(tb[P4TC_ENTRY_TBLNAME]) : NULL;
+
+	*table = p4tc_table_find_get(*pipeline, tblname, tbl_id, extack);
+	if (IS_ERR(*table)) {
+		ret = PTR_ERR(*table);
+		goto put;
+	}
+
+	rcu_read_unlock();
+
+	return 0;
+
+put:
+	p4tc_pipeline_put_ref(*pipeline);
+
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
+static void
+p4tc_table_entry_assign_key_exact(struct p4tc_table_entry_key *key, u8 *keyblob)
+{
+	memcpy(key->fa_key, keyblob, BITS_TO_BYTES(key->keysz));
+}
+
+static void
+p4tc_table_entry_assign_key_generic(struct p4tc_table_entry_key *key,
+				    struct p4tc_table_entry_mask *mask,
+				    u8 *keyblob, u8 *maskblob)
+{
+	u32 keysz = BITS_TO_BYTES(key->keysz);
+
+	memcpy(key->fa_key, keyblob, keysz);
+	memcpy(mask->fa_value, maskblob, keysz);
+}
+
+static int p4tc_table_entry_extract_key(struct p4tc_table *table,
+					struct nlattr **tb,
+					struct p4tc_table_entry_key *key,
+					struct p4tc_table_entry_mask *mask,
+					struct netlink_ext_ack *extack)
+{
+	bool is_exact = table->tbl_type == P4TC_TABLE_TYPE_EXACT;
+	void *keyblob, *maskblob;
+	u32 keysz;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ENTRY_KEY_BLOB)) {
+		NL_SET_ERR_MSG(extack, "Must specify key blobs");
+		return -EINVAL;
+	}
+
+	keysz = nla_len(tb[P4TC_ENTRY_KEY_BLOB]);
+	if (BITS_TO_BYTES(key->keysz) != keysz) {
+		NL_SET_ERR_MSG(extack,
+			       "Key blob size and table key size differ");
+		return -EINVAL;
+	}
+
+	if (!is_exact) {
+		if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ENTRY_MASK_BLOB)) {
+			NL_SET_ERR_MSG(extack, "Must specify mask blobs");
+			return -EINVAL;
+		}
+
+		if (keysz != nla_len(tb[P4TC_ENTRY_MASK_BLOB])) {
+			NL_SET_ERR_MSG(extack,
+				       "Key and mask blob must have the same length");
+			return -EINVAL;
+		}
+	}
+
+	keyblob = nla_data(tb[P4TC_ENTRY_KEY_BLOB]);
+	if (is_exact) {
+		p4tc_table_entry_assign_key_exact(key, keyblob);
+	} else {
+		maskblob = nla_data(tb[P4TC_ENTRY_MASK_BLOB]);
+		p4tc_table_entry_assign_key_generic(key, mask, keyblob,
+						    maskblob);
+	}
+
+	return 0;
+}
+
+static void p4tc_table_entry_build_key(struct p4tc_table *table,
+				       struct p4tc_table_entry_key *key,
+				       struct p4tc_table_entry_mask *mask)
+{
+	int i;
+
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT)
+		return;
+
+	key->maskid = mask->mask_id;
+
+	for (i = 0; i < BITS_TO_BYTES(key->keysz); i++)
+		key->fa_key[i] &= mask->fa_value[i];
+}
+
+static int ___p4tc_table_entry_del(struct p4tc_pipeline *pipeline,
+				   struct p4tc_table *table,
+				   struct p4tc_table_entry *entry,
+				   bool from_control)
+__must_hold(RCU)
+{
+	u16 who_deleted = from_control ? P4TC_ENTITY_UNSPEC : P4TC_ENTITY_KERNEL;
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
+static int p4tc_table_entry_gd(struct net *net, struct sk_buff *skb, bool del,
+			       u16 *permissions, struct nlattr *arg,
+			       struct p4tc_path_nlattrs *nl_path_attrs,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_entry_mask *mask = NULL, *new_mask;
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	struct p4tc_table_entry *entry = NULL;
+	struct p4tc_pipeline *pipeline = NULL;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry_key *key;
+	u32 *ids = nl_path_attrs->ids;
+	bool has_listener = !!skb;
+	struct p4tc_table *table;
+	u16 who_deleted = 0;
+	bool get = !del;
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
+	ret = p4tc_table_entry_get_table(net, &pipeline, &table, tb,
+					 nl_path_attrs, extack);
+	if (ret < 0)
+		return ret;
+
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT) {
+		prio = p4tc_table_entry_exact_prio();
+	} else {
+		if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_ENTRY_PRIO)) {
+			NL_SET_ERR_MSG(extack, "Must specify table entry priority");
+			return -EINVAL;
+		}
+		prio = nla_get_u32(tb[P4TC_ENTRY_PRIO]);
+	}
+
+	if (del && !p4tc_pipeline_sealed(pipeline)) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to delete table entry in unsealed pipeline");
+		ret = -EINVAL;
+		goto table_put;
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
+	p4tc_table_entry_put_table(pipeline, table);
+
+	return ret;
+}
+
+static int p4tc_table_entry_flush(struct net *net, struct sk_buff *skb,
+				  struct nlattr *arg,
+				  struct p4tc_path_nlattrs *nl_path_attrs,
+				  struct netlink_ext_ack *extack)
+{
+	u32 *ids = nl_path_attrs->ids;
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	u32 arg_ids[P4TC_PATH_MAX - 1];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table_entry *entry;
+	struct rhashtable_iter iter;
+	bool has_listener = !!skb;
+	struct p4tc_table *table;
+	unsigned char *b;
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
+	ret = p4tc_table_entry_get_table(net, &pipeline, &table, tb,
+					 nl_path_attrs, extack);
+	if (ret < 0)
+		return ret;
+
+	if (has_listener)
+		b = nlmsg_get_pos(skb);
+
+	if (!ids[P4TC_TBLID_IDX])
+		arg_ids[P4TC_TBLID_IDX - 1] = table->tbl_id;
+
+	if (has_listener && nla_put(skb, P4TC_PATH, sizeof(arg_ids), arg_ids)) {
+		ret = -ENOMEM;
+		goto out_nlmsg_trim;
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
+		while ((entry = rhashtable_walk_next(&iter)) && !IS_ERR(entry)) {
+			struct p4tc_table_entry_value *value =
+				p4tc_table_entry_value(entry);
+
+			if (!p4tc_ctrl_delete_ok(value->permissions)) {
+				ret = -EPERM;
+				continue;
+			}
+
+			ret = p4tc_table_entry_destroy(table, entry, true, false,
+						       P4TC_ENTITY_UNSPEC);
+			if (ret < 0)
+				continue;
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
+	if (ret < 0) {
+		if (i == 0) {
+			NL_SET_ERR_MSG_WEAK(extack,
+					    "Unable to flush any entries");
+			goto out_nlmsg_trim;
+		} else {
+			if (!extack->_msg)
+				NL_SET_ERR_MSG_FMT(extack,
+						   "Flush only %u table entries",
+						   i);
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
+	goto table_put;
+
+out_nlmsg_trim:
+	if (has_listener)
+		nlmsg_trim(skb, b);
+
+table_put:
+	p4tc_table_entry_put_table(pipeline, table);
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
+static struct p4tc_table_entry_tm *
+p4tc_table_entry_create_tm(const u16 whodunnit)
+{
+	struct p4tc_table_entry_tm *dtm;
+
+	dtm = kzalloc(sizeof(*dtm), GFP_ATOMIC);
+	if (unlikely(!dtm))
+		return ERR_PTR(-ENOMEM);
+
+	dtm->who_created = whodunnit;
+	dtm->who_deleted = P4TC_ENTITY_UNSPEC;
+	dtm->created = jiffies;
+	dtm->firstused = 0;
+	dtm->lastused = jiffies;
+
+	return dtm;
+}
+
+/* Invoked from both control and data path */
+static int __p4tc_table_entry_create(struct p4tc_pipeline *pipeline,
+				     struct p4tc_table *table,
+				     struct p4tc_table_entry *entry,
+				     struct p4tc_table_entry_mask *mask,
+				     u16 whodunnit, bool from_control)
+__must_hold(RCU)
+{
+	struct p4tc_table_entry_mask *mask_found = NULL;
+	struct p4tc_table_entry_work *entry_work;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_perm *tbl_perm;
+	struct p4tc_table_entry_tm *dtm;
+	u16 permissions;
+	int ret;
+
+	value = p4tc_table_entry_value(entry);
+	/* We set it to zero on create an update to avoid having entry
+	 * deletion in parallel before we report to user space.
+	 */
+	refcount_set(&value->entries_ref, 0);
+
+	tbl_perm = rcu_dereference(table->tbl_permissions);
+	permissions = tbl_perm->permissions;
+	if (from_control) {
+		if (!p4tc_ctrl_create_ok(permissions))
+			return -EPERM;
+	} else {
+		if (!p4tc_data_create_ok(permissions))
+			return -EPERM;
+	}
+
+	/* From data plane we can only create entries on exact match */
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT) {
+		mask_found = p4tc_table_entry_mask_add(table, entry, mask);
+		if (IS_ERR(mask_found)) {
+			ret = PTR_ERR(mask_found);
+			goto out;
+		}
+	}
+
+	p4tc_table_entry_build_key(table, &entry->key, mask_found);
+
+	if (p4tc_entry_lookup(table, &entry->key, value->prio)) {
+		ret = -EEXIST;
+		goto rm_masks_idr;
+	}
+
+	dtm = p4tc_table_entry_create_tm(whodunnit);
+	if (IS_ERR(dtm)) {
+		ret = PTR_ERR(dtm);
+		goto rm_masks_idr;
+	}
+
+	rcu_assign_pointer(value->tm, dtm);
+
+	entry_work = kzalloc(sizeof(*entry_work), GFP_ATOMIC);
+	if (unlikely(!entry_work)) {
+		ret = -ENOMEM;
+		goto free_tm;
+	}
+
+	entry_work->pipeline = pipeline;
+	entry_work->table = table;
+	entry_work->entry = entry;
+	value->entry_work = entry_work;
+
+	INIT_WORK(&entry_work->work, p4tc_table_entry_del_work);
+
+	if (atomic_inc_return(&table->tbl_nelems) > table->tbl_max_entries) {
+		atomic_dec(&table->tbl_nelems);
+		ret = -ENOSPC;
+		goto free_work;
+	}
+
+	if (rhltable_insert(&table->tbl_entries, &entry->ht_node,
+			    entry_hlt_params) < 0) {
+		atomic_dec(&table->tbl_nelems);
+		ret = -EBUSY;
+		goto free_work;
+	}
+
+	if (value->is_dyn) {
+		/* Only use table template aging if user didn't specify one */
+		value->aging_ms = value->aging_ms ?: table->tbl_aging;
+
+		hrtimer_init(&value->entry_timer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL);
+		value->entry_timer.function = &entry_timer_handle;
+		hrtimer_start(&value->entry_timer, ms_to_ktime(value->aging_ms),
+			      HRTIMER_MODE_REL);
+	}
+
+	if (!from_control && p4tc_ctrl_pub_ok(value->permissions))
+		p4tc_tbl_entry_emit_event(entry_work, RTM_P4TC_CREATE,
+					  GFP_ATOMIC);
+
+	return 0;
+
+free_work:
+	kfree(entry_work);
+
+free_tm:
+	kfree(dtm);
+
+rm_masks_idr:
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		p4tc_table_entry_mask_del(table, entry);
+out:
+	return ret;
+}
+
+/* Invoked from both control and data path  */
+static int __p4tc_table_entry_update(struct p4tc_pipeline *pipeline,
+				     struct p4tc_table *table,
+				     struct p4tc_table_entry *entry,
+				     struct p4tc_table_entry_mask *mask,
+				     u16 whodunnit, bool from_control)
+__must_hold(RCU)
+{
+	struct p4tc_table_entry_mask *mask_found = NULL;
+	struct p4tc_table_entry_work *entry_work;
+	struct p4tc_table_entry_value *value_old;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry *entry_old;
+	struct p4tc_table_entry_tm *tm_old;
+	struct p4tc_table_entry_tm *tm;
+	int ret;
+
+	value = p4tc_table_entry_value(entry);
+	/* We set it to zero on update to avoid having entry removed from the
+	 * rhashtable in parallel before we report to user space.
+	 */
+	refcount_set(&value->entries_ref, 0);
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT) {
+		mask_found = p4tc_table_entry_mask_add(table, entry, mask);
+		if (IS_ERR(mask_found)) {
+			ret = PTR_ERR(mask_found);
+			goto out;
+		}
+	}
+
+	p4tc_table_entry_build_key(table, &entry->key, mask_found);
+
+	entry_old = p4tc_entry_lookup(table, &entry->key, value->prio);
+	if (!entry_old) {
+		ret = -ENOENT;
+		goto rm_masks_idr;
+	}
+
+	/* In case of parallel update, the thread that arrives here first will
+	 * get the right to update.
+	 *
+	 * In case of a parallel get/update, whoever is second will fail
+	 * appropriately.
+	 */
+	value_old = p4tc_table_entry_value(entry_old);
+	if (!p4tc_tbl_entry_put(value_old)) {
+		ret = -EAGAIN;
+		goto rm_masks_idr;
+	}
+
+	if (from_control) {
+		if (!p4tc_ctrl_update_ok(value_old->permissions)) {
+			ret = -EPERM;
+			goto set_entries_refcount;
+		}
+	} else {
+		if (!p4tc_data_update_ok(value_old->permissions)) {
+			ret = -EPERM;
+			goto set_entries_refcount;
+		}
+	}
+
+	tm = kzalloc(sizeof(*tm), GFP_ATOMIC);
+	if (unlikely(!tm)) {
+		ret = -ENOMEM;
+		goto set_entries_refcount;
+	}
+
+	tm_old = rcu_dereference_protected(value_old->tm, 1);
+	*tm = *tm_old;
+
+	tm->lastused = jiffies;
+	tm->who_updated = whodunnit;
+
+	if (value->permissions == P4TC_PERMISSIONS_UNINIT)
+		value->permissions = value_old->permissions;
+
+	rcu_assign_pointer(value->tm, tm);
+
+	entry_work = kzalloc(sizeof(*(entry_work)), GFP_ATOMIC);
+	if (unlikely(!entry_work)) {
+		ret = -ENOMEM;
+		goto free_tm;
+	}
+
+	entry_work->pipeline = pipeline;
+	entry_work->table = table;
+	entry_work->entry = entry;
+	value->entry_work = entry_work;
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
+
+	INIT_WORK(&entry_work->work, p4tc_table_entry_del_work);
+
+	if (rhltable_insert(&table->tbl_entries, &entry->ht_node,
+			    entry_hlt_params) < 0) {
+		ret = -EEXIST;
+		goto free_entry_work;
+	}
+
+	p4tc_table_entry_destroy_noida(table, entry_old);
+
+	if (!from_control && p4tc_ctrl_pub_ok(value->permissions))
+		p4tc_tbl_entry_emit_event(entry_work, RTM_P4TC_UPDATE,
+					  GFP_ATOMIC);
+
+	return 0;
+
+free_entry_work:
+	kfree(entry_work);
+
+free_tm:
+	kfree(tm);
+
+set_entries_refcount:
+	refcount_set(&value_old->entries_ref, 1);
+
+rm_masks_idr:
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		p4tc_table_entry_mask_del(table, entry);
+
+out:
+	return ret;
+}
+
+static bool p4tc_table_check_entry_act(struct p4tc_table *table,
+				       struct tc_action *entry_act)
+{
+	struct p4tc_table_act *table_act;
+
+	list_for_each_entry(table_act, &table->tbl_acts_list, node) {
+		if (table_act->ops->id != entry_act->ops->id)
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
+static struct nla_policy p4tc_table_attrs_policy[P4TC_ENTRY_TBL_ATTRS_MAX + 1] = {
+	[P4TC_ENTRY_TBL_ATTRS_DEFAULT_HIT] = { .type = NLA_NESTED },
+	[P4TC_ENTRY_TBL_ATTRS_DEFAULT_MISS] = { .type = NLA_NESTED },
+	[P4TC_ENTRY_TBL_ATTRS_PERMISSIONS] = NLA_POLICY_MAX(NLA_U16, P4TC_MAX_PERMISSION),
+};
+
+static int
+update_tbl_attrs(struct net *net, struct p4tc_table *table,
+		 struct nlattr *table_attrs,
+		 struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_default_act_params def_params = {0};
+	struct nlattr *tb[P4TC_ENTRY_TBL_ATTRS_MAX + 1];
+	struct p4tc_table_perm *tbl_perm = NULL;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_ENTRY_TBL_ATTRS_MAX, table_attrs,
+			       p4tc_table_attrs_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (tb[P4TC_ENTRY_TBL_ATTRS_PERMISSIONS]) {
+		u16 permissions;
+
+		if (atomic_read(&table->tbl_nelems) > 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to set table permissions if it already has entries");
+			return -EINVAL;
+		}
+
+		permissions = nla_get_u16(tb[P4TC_ENTRY_TBL_ATTRS_PERMISSIONS]);
+		tbl_perm = p4tc_table_init_permissions(table, permissions,
+						       extack);
+		if (IS_ERR(tbl_perm))
+			return PTR_ERR(tbl_perm);
+	}
+
+	def_params.default_hit_attr = tb[P4TC_ENTRY_TBL_ATTRS_DEFAULT_HIT];
+	def_params.default_miss_attr = tb[P4TC_ENTRY_TBL_ATTRS_DEFAULT_MISS];
+
+	err = p4tc_table_init_default_acts(net, &def_params, table,
+					   &table->tbl_acts_list, extack);
+	if (err < 0)
+		goto free_tbl_perm;
+
+	p4tc_table_replace_default_acts(table, &def_params, true);
+	p4tc_table_replace_permissions(table, tbl_perm, true);
+
+	return 0;
+
+free_tbl_perm:
+	kfree(tbl_perm);
+	return err;
+}
+
+static u16 p4tc_table_entry_tbl_permcpy(const u16 tblperm)
+{
+	return p4tc_ctrl_perm_rm_create(p4tc_data_perm_rm_create(tblperm));
+}
+
+#define P4TC_TBL_ENTRY_CU_FLAG_CREATE 0x1
+#define P4TC_TBL_ENTRY_CU_FLAG_UPDATE 0x2
+#define P4TC_TBL_ENTRY_CU_FLAG_SET 0x4
+
+static struct p4tc_table_entry *
+__p4tc_table_entry_cu(struct net *net, u8 cu_flags, struct nlattr **tb,
+		      struct p4tc_pipeline *pipeline, struct p4tc_table *table,
+		      struct netlink_ext_ack *extack)
+{
+	bool replace = cu_flags == P4TC_TBL_ENTRY_CU_FLAG_UPDATE;
+	bool set = cu_flags == P4TC_TBL_ENTRY_CU_FLAG_SET;
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	struct p4tc_table_entry_value *value;
+	u8 whodunnit = P4TC_ENTITY_UNSPEC;
+	struct p4tc_table_entry *entry;
+	u32 keysz_bytes;
+	u32 keysz_bits;
+	u16 tblperm;
+	int ret = 0;
+	u32 entrysz;
+	u32 prio;
+
+	prio = tb[P4TC_ENTRY_PRIO] ? nla_get_u32(tb[P4TC_ENTRY_PRIO]) : 0;
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT && replace) {
+		if (!prio) {
+			NL_SET_ERR_MSG(extack, "Must specify entry priority");
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		if (table->tbl_type == P4TC_TABLE_TYPE_EXACT) {
+			if (prio) {
+				NL_SET_ERR_MSG(extack,
+					       "Mustn't specify entry priority for exact");
+				return ERR_PTR(-EINVAL);
+			}
+			prio = p4tc_table_entry_alloc_new_prio(table);
+		} else {
+			if (prio)
+				ret = ida_alloc_range(&table->tbl_prio_idr,
+						      prio, prio, GFP_ATOMIC);
+			else
+				ret = p4tc_table_entry_alloc_new_prio(table);
+			if (ret < 0) {
+				NL_SET_ERR_MSG(extack,
+					       "Unable to allocate priority");
+				return ERR_PTR(ret);
+			}
+			prio = ret;
+		}
+	}
+
+	whodunnit = nla_get_u8(tb[P4TC_ENTRY_WHODUNNIT]);
+
+	keysz_bits = table->tbl_keysz;
+	keysz_bytes = P4TC_KEYSZ_BYTES(keysz_bits);
+
+	/* Entry memory layout:
+	 * { entry:key __aligned(8):value }
+	 */
+	entrysz = sizeof(*entry) + keysz_bytes +
+		sizeof(struct p4tc_table_entry_value);
+
+	entry = kzalloc(entrysz, GFP_KERNEL);
+	if (unlikely(!entry)) {
+		NL_SET_ERR_MSG(extack, "Unable to allocate table entry");
+		ret = -ENOMEM;
+		goto idr_rm;
+	}
+
+	entry->key.keysz = keysz_bits;
+	mask->sz = keysz_bits;
+
+	ret = p4tc_table_entry_extract_key(table, tb, &entry->key, mask, extack);
+	if (ret < 0)
+		goto free_entry;
+
+	value = p4tc_table_entry_value(entry);
+	value->prio = prio;
+
+	rcu_read_lock();
+	tblperm = rcu_dereference(table->tbl_permissions)->permissions;
+	rcu_read_unlock();
+
+	if (tb[P4TC_ENTRY_PERMISSIONS]) {
+		u16 nlperm;
+
+		nlperm = nla_get_u16(tb[P4TC_ENTRY_PERMISSIONS]);
+		if (~tblperm & nlperm) {
+			NL_SET_ERR_MSG(extack,
+				       "Trying to set permission bits which aren't allowed by table");
+			ret = -EINVAL;
+			goto free_entry;
+		}
+
+		if (p4tc_ctrl_create_ok(nlperm) || p4tc_data_create_ok(nlperm)) {
+			NL_SET_ERR_MSG(extack,
+				       "Create permission for table entry doesn't make sense");
+			ret = -EINVAL;
+			goto free_entry;
+		}
+		value->permissions = nlperm;
+	} else {
+		if (replace)
+			value->permissions = P4TC_PERMISSIONS_UNINIT;
+		else
+			value->permissions =
+				p4tc_table_entry_tbl_permcpy(tblperm);
+	}
+
+	if (tb[P4TC_ENTRY_ACT]) {
+		value->acts = kcalloc(TCA_ACT_MAX_PRIO,
+				      sizeof(struct tc_action *), GFP_KERNEL);
+		if (unlikely(!value->acts)) {
+			ret = -ENOMEM;
+			goto free_entry;
+		}
+
+		ret = p4tc_action_init(net, tb[P4TC_ENTRY_ACT], value->acts,
+				       table->common.p_id,
+				       TCA_ACT_FLAGS_NO_RTNL, extack);
+		if (unlikely(ret < 0)) {
+			kfree(value->acts);
+			value->acts = NULL;
+			goto free_entry;
+		} else if (ret > 1) {
+			NL_SET_ERR_MSG(extack,
+				       "Can only have one entry action");
+			ret = -EINVAL;
+			goto free_acts;
+		}
+
+		value->num_acts = ret;
+
+		if (!p4tc_table_check_entry_act(table, value->acts[0])) {
+			ret = -EPERM;
+			NL_SET_ERR_MSG(extack,
+				       "Action is not allowed as entry action");
+			goto free_acts;
+		}
+	}
+
+	if (!replace) {
+		if ((!tb[P4TC_ENTRY_AGING] && tb[P4TC_ENTRY_DYNAMIC]) ||
+		    (tb[P4TC_ENTRY_AGING] && !tb[P4TC_ENTRY_DYNAMIC])) {
+			NL_SET_ERR_MSG(extack,
+				       "Aging may only be set alongside dynamic");
+			ret = -EINVAL;
+			goto free_acts;
+		}
+	}
+
+	if (tb[P4TC_ENTRY_AGING])
+		value->aging_ms = nla_get_u64(tb[P4TC_ENTRY_AGING]);
+
+	if (tb[P4TC_ENTRY_DYNAMIC])
+		value->is_dyn = true;
+
+	rcu_read_lock();
+	if (replace) {
+		ret = __p4tc_table_entry_update(pipeline, table, entry, mask,
+						whodunnit, true);
+	} else {
+		ret = __p4tc_table_entry_create(pipeline, table, entry, mask,
+						whodunnit, true);
+		if (set && ret == -EEXIST)
+			ret = __p4tc_table_entry_update(pipeline, table, entry,
+							mask, whodunnit, true);
+	}
+	rcu_read_unlock();
+	if (ret < 0) {
+		if ((replace || set) && ret == -EAGAIN)
+			NL_SET_ERR_MSG(extack,
+				       "Entry was being updated in parallel");
+
+		if (ret == -ENOSPC)
+			NL_SET_ERR_MSG(extack, "Table max entries reached");
+		else
+			NL_SET_ERR_MSG(extack, "Failed to create/update entry");
+
+		goto free_acts;
+	}
+
+	return entry;
+
+free_acts:
+	p4tc_action_destroy(value->acts);
+
+free_entry:
+	kfree(entry);
+
+idr_rm:
+	if (!replace)
+		p4tc_table_entry_free_prio(table, prio);
+
+	return ERR_PTR(ret);
+}
+
+static int p4tc_table_entry_cu(struct net *net, struct sk_buff *skb,
+			       u8 cu_flags, u16 *permissions,
+			       struct nlattr *arg,
+			       struct p4tc_path_nlattrs *nl_path_attrs,
+			       struct netlink_ext_ack *extack)
+{
+	bool replace = cu_flags == P4TC_TBL_ENTRY_CU_FLAG_UPDATE;
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	struct p4tc_table_entry_value *value;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table_entry *entry;
+	u32 *ids = nl_path_attrs->ids;
+	bool has_listener = !!skb;
+	struct p4tc_table *table;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg, p4tc_entry_policy,
+			       extack);
+	if (ret < 0)
+		return ret;
+
+	ret = p4tc_table_entry_get_table(net, &pipeline, &table, tb,
+					 nl_path_attrs, extack);
+	if (ret < 0)
+		return ret;
+
+	if (replace && tb[P4TC_ENTRY_TBL_ATTRS]) {
+		/* Table attributes update */
+		ret = update_tbl_attrs(net, table,
+				       tb[P4TC_ENTRY_TBL_ATTRS],
+				       extack);
+		goto table_put;
+	} else {
+		/* Table entry create or update */
+		if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_ENTRY_WHODUNNIT)) {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify whodunnit attribute");
+			ret = -EINVAL;
+			goto table_put;
+		}
+	}
+
+	entry = __p4tc_table_entry_cu(net, cu_flags, tb, pipeline, table,
+				      extack);
+	if (IS_ERR(entry)) {
+		ret = PTR_ERR(entry);
+		goto table_put;
+	}
+
+	value = p4tc_table_entry_value(entry);
+	if (has_listener) {
+		if (p4tc_ctrl_pub_ok(value->permissions)) {
+			if (p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id,
+						P4TC_ENTITY_UNSPEC) <= 0)
+				NL_SET_ERR_MSG(extack,
+					       "Unable to fill table entry attributes");
+
+			if (!nl_path_attrs->pname_passed)
+				strscpy(nl_path_attrs->pname,
+					pipeline->common.name,
+					P4TC_PIPELINE_NAMSIZ);
+
+			if (!ids[P4TC_PID_IDX])
+				ids[P4TC_PID_IDX] = pipeline->common.p_id;
+		}
+
+		*permissions = value->permissions;
+	}
+
+	/* We set it to zero on create an update to avoid having the entry
+	 * deleted in parallel before we report to user space.
+	 * We only set it to 1 here, after reporting.
+	 */
+	refcount_set(&value->entries_ref, 1);
+
+table_put:
+	p4tc_table_entry_put_table(pipeline, table);
+	return ret;
+}
+
+struct p4tc_table_entry *
+p4tc_table_const_entry_cu(struct net *net,
+			  struct nlattr *arg,
+			  struct p4tc_pipeline *pipeline,
+			  struct p4tc_table *table,
+			  struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	u8 cu_flags = P4TC_TBL_ENTRY_CU_FLAG_CREATE;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry *entry;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg, p4tc_entry_policy,
+			       extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_ENTRY_WHODUNNIT)) {
+		NL_SET_ERR_MSG(extack, "Must specify whodunnit attribute");
+		return ERR_PTR(-EINVAL);
+	}
+
+	entry = __p4tc_table_entry_cu(net, cu_flags, tb, pipeline, table,
+				      extack);
+	if (IS_ERR(entry))
+		return entry;
+
+	value = p4tc_table_entry_value(entry);
+	refcount_set(&value->entries_ref, 1);
+
+	return entry;
+}
+
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
+	return p4tc_table_entry_gd(net, skb, false, permissions,
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
+		ret = p4tc_table_entry_gd(net, skb, true, permissions,
+					  tb[P4TC_PARAMS], nl_path_attrs,
+					  extack);
+	}
+
+	return ret;
+}
+
+static int p4tc_tbl_entry_cu_1(struct net *net, struct sk_buff *skb,
+			       u8 cu_flags, u16 *permissions,
+			       struct nlattr *nla,
+			       struct p4tc_path_nlattrs *nl_path_attrs,
+			       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MAX + 1];
+	u32 *tbl_id;
+	int ret = 0;
+
+	ret = nla_parse_nested(tb, P4TC_MAX, nla, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, P4TC_PATH)) {
+		NL_SET_ERR_MSG(extack, "Must specify object path");
+		return -EINVAL;
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, P4TC_PARAMS)) {
+		NL_SET_ERR_MSG(extack, "Must specify object attributes");
+		return -EINVAL;
+	}
+
+	tbl_id = nla_data(tb[P4TC_PATH]);
+	memcpy(&nl_path_attrs->ids[P4TC_TBLID_IDX], tbl_id,
+	       nla_len(tb[P4TC_PATH]));
+
+	return p4tc_table_entry_cu(net, skb, cu_flags, permissions,
+				   tb[P4TC_PARAMS], nl_path_attrs, extack);
+}
+
+static int __p4tc_tbl_entry_crud(struct net *net, struct sk_buff *skb,
+				 struct nlmsghdr *n, int cmd, char *p_name,
+				 struct nlattr *p4tca[],
+				 struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	struct p4tc_path_nlattrs nl_path_attrs = {0};
+	u32 portid = NETLINK_CB(skb).portid;
+	u16 permissions = P4TC_CTRL_PERM_P;
+	u32 ids[P4TC_PATH_MAX] = { 0 };
+	int i, num_pub_permission = 0;
+	int ret = 0, ret_send;
+	struct p4tcmsg *t_new;
+	struct sk_buff *nskb;
+	struct nlmsghdr *nlh;
+	struct nlattr *pn_att;
+	struct nlattr *root;
+
+	nskb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (unlikely(!nskb))
+		return -ENOBUFS;
+
+	nlh = nlmsg_put(nskb, portid, n->nlmsg_seq, cmd, sizeof(*t),
+			n->nlmsg_flags);
+	if (unlikely(!nlh))
+		goto out;
+
+	t_new = nlmsg_data(nlh);
+	t_new->pipeid = t->pipeid;
+	t_new->obj = t->obj;
+	ids[P4TC_PID_IDX] = t_new->pipeid;
+	nl_path_attrs.ids = ids;
+
+	pn_att = nla_reserve(nskb, P4TC_ROOT_PNAME, P4TC_PIPELINE_NAMSIZ);
+	if (unlikely(!pn_att)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	nl_path_attrs.pname = nla_data(pn_att);
+	if (!p_name) {
+		/* Filled up by the operation or forced failure */
+		memset(nl_path_attrs.pname, 0, P4TC_PIPELINE_NAMSIZ);
+		nl_path_attrs.pname_passed = false;
+	} else {
+		strscpy(nl_path_attrs.pname, p_name, P4TC_PIPELINE_NAMSIZ);
+		nl_path_attrs.pname_passed = true;
+	}
+
+	root = nla_nest_start(nskb, P4TC_ROOT);
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && p4tca[i]; i++) {
+		struct nlattr *nest = nla_nest_start(nskb, i);
+
+		if (cmd == RTM_P4TC_GET)
+			ret = p4tc_tbl_entry_get_1(net, nskb, p4tca[i],
+						   &permissions, &nl_path_attrs,
+						   extack);
+		else if (cmd == RTM_P4TC_CREATE ||
+			 cmd == RTM_P4TC_UPDATE) {
+			u8 cu_flags;
+
+			if (cmd == RTM_P4TC_UPDATE)
+				cu_flags = P4TC_TBL_ENTRY_CU_FLAG_UPDATE;
+			else
+				if (n->nlmsg_flags & NLM_F_REPLACE)
+					cu_flags = P4TC_TBL_ENTRY_CU_FLAG_SET;
+				else
+					cu_flags = P4TC_TBL_ENTRY_CU_FLAG_CREATE;
+
+			ret = p4tc_tbl_entry_cu_1(net, nskb, cu_flags,
+						  &permissions,
+						  p4tca[i], &nl_path_attrs,
+						  extack);
+		} else if (cmd == RTM_P4TC_DEL) {
+			bool flush = nlh->nlmsg_flags & NLM_F_ROOT;
+
+			ret = p4tc_tbl_entry_del_1(net, nskb, flush,
+						   &permissions, p4tca[i],
+						   &nl_path_attrs, extack);
+		}
+
+		if (p4tc_ctrl_pub_ok(permissions)) {
+			num_pub_permission++;
+		} else {
+			nla_nest_cancel(nskb, nest);
+			continue;
+		}
+
+		if (ret < 0) {
+			if (i == 1) {
+				goto out;
+			} else {
+				nla_nest_cancel(nskb, nest);
+				break;
+			}
+		}
+		nla_nest_end(nskb, nest);
+	}
+	nla_nest_end(nskb, root);
+
+	if (!t_new->pipeid)
+		t_new->pipeid = ids[P4TC_PID_IDX];
+
+	nlmsg_end(nskb, nlh);
+
+	if (cmd == RTM_P4TC_GET) {
+		ret_send = rtnl_unicast(nskb, net, portid);
+	} else if (num_pub_permission) {
+		ret_send = rtnetlink_send(nskb, net, portid, RTNLGRP_TC,
+					  n->nlmsg_flags & NLM_F_ECHO);
+	} else {
+		ret_send = 0;
+		kfree_skb(nskb);
+	}
+
+	return ret_send ? ret_send : ret;
+
+out:
+	kfree_skb(nskb);
+	return ret;
+}
+
+static int __p4tc_tbl_entry_crud_fast(struct net *net, struct nlmsghdr *n,
+				      int cmd, char *p_name,
+				      struct nlattr *p4tca[],
+				      struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	struct p4tc_path_nlattrs nl_path_attrs = {0};
+	u32 ids[P4TC_PATH_MAX] = { 0 };
+	int ret = 0;
+	int i;
+
+	ids[P4TC_PID_IDX] = t->pipeid;
+	nl_path_attrs.ids = ids;
+
+	/* Only read for searching the pipeline */
+	nl_path_attrs.pname = p_name;
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && p4tca[i]; i++) {
+		if (cmd == RTM_P4TC_CREATE ||
+		    cmd == RTM_P4TC_UPDATE) {
+			u8 cu_flags;
+
+			if (cmd == RTM_P4TC_UPDATE)
+				cu_flags = P4TC_TBL_ENTRY_CU_FLAG_UPDATE;
+			else
+				if (n->nlmsg_flags & NLM_F_REPLACE)
+					cu_flags = P4TC_TBL_ENTRY_CU_FLAG_SET;
+				else
+					cu_flags = P4TC_TBL_ENTRY_CU_FLAG_CREATE;
+
+			ret = p4tc_tbl_entry_cu_1(net, NULL, cu_flags, NULL,
+						  p4tca[i], &nl_path_attrs,
+						  extack);
+		} else if (cmd == RTM_P4TC_DEL) {
+			bool flush = n->nlmsg_flags & NLM_F_ROOT;
+
+			ret = p4tc_tbl_entry_del_1(net, NULL, flush, NULL,
+						   p4tca[i], &nl_path_attrs,
+						   extack);
+		}
+
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
+int p4tc_tbl_entry_crud(struct net *net, struct sk_buff *skb,
+			struct nlmsghdr *n, int cmd,
+			struct netlink_ext_ack *extack)
+{
+	struct nlattr *p4tca[P4TC_MSGBATCH_SIZE + 1];
+	int echo = n->nlmsg_flags & NLM_F_ECHO;
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
+	int listeners;
+	int ret = 0;
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack, "Netlink P4TC table attributes missing");
+		return -EINVAL;
+	}
+
+	ret = nla_parse_nested(p4tca, P4TC_MSGBATCH_SIZE, tb[P4TC_ROOT], NULL,
+			       extack);
+	if (ret < 0)
+		return ret;
+
+	if (!p4tca[1]) {
+		NL_SET_ERR_MSG(extack, "No elements in root table array");
+		return -EINVAL;
+	}
+
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	listeners = rtnl_has_listeners(net, RTNLGRP_TC);
+
+	if ((echo || listeners) || cmd == RTM_P4TC_GET)
+		ret = __p4tc_tbl_entry_crud(net, skb, n, cmd, p_name, p4tca,
+					    extack);
+	else
+		ret = __p4tc_tbl_entry_crud_fast(net, n, cmd, p_name, p4tca,
+						 extack);
+	return ret;
+}
+
+static int p4tc_table_entry_dump(struct net *net, struct sk_buff *skb,
+				 struct nlattr *arg,
+				 struct p4tc_path_nlattrs *nl_path_attrs,
+				 struct netlink_callback *cb,
+				 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	struct p4tc_dump_ctx *ctx = (void *)cb->ctx;
+	unsigned char *b = nlmsg_get_pos(skb);
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
+			kfree(ctx->iter);
+			return ret;
+		}
+	}
+
+	ret = p4tc_table_entry_get_table(net, &pipeline, &table, tb,
+					 nl_path_attrs, extack);
+	if (ret < 0) {
+		kfree(ctx->iter);
+		return ret;
+	}
+
+	if (!ctx->iter) {
+		ctx->iter = kzalloc(sizeof(*ctx->iter), GFP_KERNEL);
+		if (!ctx->iter) {
+			ret = -ENOMEM;
+			goto table_put;
+		}
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
+		for (i = 0; i < P4TC_MSGBATCH_SIZE &&
+		     (entry = rhashtable_walk_next(ctx->iter)) &&
+		     !IS_ERR(entry); i++) {
+			struct p4tc_table_entry_value *value =
+				p4tc_table_entry_value(entry);
+			struct nlattr *count;
+
+			if (!p4tc_ctrl_read_ok(value->permissions)) {
+				i--;
+				continue;
+			}
+
+			count = nla_nest_start(skb, i + 1);
+			if (!count) {
+				rhashtable_walk_stop(ctx->iter);
+				goto table_put;
+			}
+
+			ret = p4tc_tbl_entry_fill(skb, table, entry,
+						  table->tbl_id,
+						  P4TC_ENTITY_UNSPEC);
+			if (ret == 0) {
+				NL_SET_ERR_MSG(extack,
+					       "Failed to fill notification attributes for table entry");
+				goto walk_done;
+			} else if (ret == -ENOMEM) {
+				ret = 1;
+				nla_nest_cancel(skb, count);
+				rhashtable_walk_stop(ctx->iter);
+				goto table_put;
+			}
+			nla_nest_end(skb, count);
+		}
+	} while (entry == ERR_PTR(-EAGAIN));
+	rhashtable_walk_stop(ctx->iter);
+
+	if (!i) {
+		rhashtable_walk_exit(ctx->iter);
+
+		ret = 0;
+		kfree(ctx->iter);
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
+	goto table_put;
+
+walk_done:
+	rhashtable_walk_stop(ctx->iter);
+	rhashtable_walk_exit(ctx->iter);
+	kfree(ctx->iter);
+
+	nlmsg_trim(skb, b);
+
+table_put:
+	p4tc_table_entry_put_table(pipeline, table);
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
+	if (nl_path_attrs.pname) {
+		if (nla_put_string(skb, P4TC_ROOT_PNAME, nl_path_attrs.pname)) {
+			ret = -1;
+			goto out;
+		}
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
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index 2fc4a0a54..dfeb00446 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -27,12 +27,12 @@
 #include <net/netlink.h>
 #include <net/flow_offload.h>
 
-static const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1] = {
+const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1] = {
 	[P4TC_ROOT] = { .type = NLA_NESTED },
 	[P4TC_ROOT_PNAME] = { .type = NLA_STRING, .len = P4TC_PIPELINE_NAMSIZ },
 };
 
-static const struct nla_policy p4tc_policy[P4TC_MAX + 1] = {
+const struct nla_policy p4tc_policy[P4TC_MAX + 1] = {
 	[P4TC_PATH] = { .type = NLA_BINARY,
 			.len = P4TC_PATH_MAX * sizeof(u32) },
 	[P4TC_PARAMS] = { .type = NLA_NESTED },
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index e50a1c1ff..da7902404 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -98,6 +98,10 @@ static const struct nlmsg_perm nlmsg_route_perms[] = {
 	{ RTM_DELP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_READ },
 	{ RTM_UPDATEP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_P4TC_CREATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_P4TC_DEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_P4TC_GET,	NETLINK_ROUTE_SOCKET__NLMSG_READ },
+	{ RTM_P4TC_UPDATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 };
 
 static const struct nlmsg_perm nlmsg_tcpdiag_perms[] = {
@@ -181,7 +185,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		 * structures at the top of this file with the new mappings
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
-		BUILD_BUG_ON(RTM_MAX != (RTM_CREATEP4TEMPLATE + 3));
+		BUILD_BUG_ON(RTM_MAX != (RTM_P4TC_CREATE + 3));
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
 				 sizeof(nlmsg_route_perms));
 		break;
-- 
2.34.1


