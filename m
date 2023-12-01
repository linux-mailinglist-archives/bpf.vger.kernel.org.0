Return-Path: <bpf+bounces-16424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651DB8012BC
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159BF281DE7
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811735645E;
	Fri,  1 Dec 2023 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GiDlWIwD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB4C106
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:29:27 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58d4968c362so1335204eaf.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455367; x=1702060167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYOlpVrfUfN3if+4kSlIi5X7bRLWGAoD7o8+OAjGtNw=;
        b=GiDlWIwDqsI94D/9M9GJCAm92R6s4bU3szPWgsHF4jM1aIjOwAhTXeKe6829xvg4EH
         yilHADqK6+lj8MBhXYWHcyS4e2SljV25GYN2xU4Nv+4vEyVD/d50N1SrldaeSU1S0Cal
         ltOOBNM6LjmWRiIYGvLk5QRRQENbrLPry8kgieZ6Nv820cFrr1CBsAGWPgnV3Zolp23y
         yA5EQXDi/O/U+JdfwErxoJBAxiMHE84eMFmKOZfJGamMT3hWr+f/3/Q7pFc11u7b8Lkm
         JcnScs+u/zkvB+htVQomb7SpCwthFw5ZY3GnpOD+qFqtRTz9mnKVabdzGIKw1TuPxUkz
         M94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455367; x=1702060167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYOlpVrfUfN3if+4kSlIi5X7bRLWGAoD7o8+OAjGtNw=;
        b=sb0rSaYIaCBBw7ENDxgXVTePjBfGEYlabQf+aPyVsY85BW6fo1j61qwfezQWodLnky
         WCym/iOXzZiGItghcAv8qwxtPS9msHCU+CZabAlV7Ed6KdBU2Ms5wxeqP81TnpC7jCne
         wiNvM/49fff/xYhkzQzBbY3Je9d6kIOPqJ7J+TkaM1VmZhKCwv4BJwkDTzSpOf/Z+kDo
         V5NUpLbRVn+uP+6NBysF2vLYi99tAzrhuqGnCtUcdh2sno6FhvLRcxPBnwjG0y9FW+Gg
         ahXfmHj8hYlXdoZ9mBgJ8IhNwf4goOXWhiwQ9a7bcxwKwifa+/8SpwIgyT3EpEUfmvGS
         yNtQ==
X-Gm-Message-State: AOJu0YwHf6eIBUDJJvUbBohaMXP/3kwU1jR53HQlHolIh7451cwvpDy3
	FMlwaoibl3DpPk6zYs6LLy21kg==
X-Google-Smtp-Source: AGHT+IFFScsEGQOlZnO1DDp73m0Y4LQynOVvCxtEFzYPexV7YEznCvMuBxJMWrlbNXJHU5oDZVuA1Q==
X-Received: by 2002:a05:6358:7296:b0:16e:271d:1db7 with SMTP id w22-20020a056358729600b0016e271d1db7mr28142716rwf.2.1701455366374;
        Fri, 01 Dec 2023 10:29:26 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:25 -0800 (PST)
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
Subject: [PATCH net-next v9 12/15] p4tc: add template table create, update, delete, get, flush and dump
Date: Fri,  1 Dec 2023 13:29:01 -0500
Message-Id: <20231201182904.532825-13-jhs@mojatatu.com>
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

This commit introduces code to creation and maintenance of P4 tables
defined in a P4 program.

As with all other P4TC objects, tables' lifetimes conform to extended CRUD
operations and are maintained via templates.
It's important to note that write operations, such as create, update and
delete can only be made if the pipeline is not sealed.

Per the P4 specification, tables prefix their name with the control block
(although this could be overridden by P4 annotations).

As an example, if one were to create a table named table1 in a
pipeline named myprog1, on control block "mycontrol", one would use
the following command:

tc p4template create table/myprog1/mycontrol/table1 tblid 1 \
   keysz 32 nummasks 8 tentries 8192

Above says that we are creating a table (table1) attached to pipeline
myprog1 on control block mycontrol. Table1's key size is 32 bits wide
and it can have up to 8 associated masks and 8192 entries. The table id
for table1 is 1. The table id is typically provided by the compiler.

Parameters such as nummasks (number of masks this table may have) and
tentries (maximum number of entries this table may have) may also be
omitted in which case 8 masks and 256 entries will be assumed.

P4 tables have many associated attributes that further refine how these
tables operate. Some attributes per table and others per entry.
Attributes include:

- Table aging: The aging for the table entries belonging to the table
  (could be per table or entry)

- Match key type: The match type of the table key (exact, LPM, ternary,
  etc).
  Note in P4 a key may constitute multiple (sub)key types, eg matching on
  srcip using a prefix and an exact match for dstip. In such a case it is
  up to the compiler to generalize the key used (For example in this
  case the overall key may endup being LPM or ternary).

- Direct Counter: Table counter instances used directly by the table, when
  specified in the P4 program, there will be one counter per entry.

- Direct Meter: Table meter instances used directly by the table, when
  specified in the P4 program, there will be one meter per entry.

- CRUDXPS Permissions both for specific entries and tables. The permissions
  are applicable to both the control plane and the datapath (see "Table
  Permissions" further below).

- Allowed Actions List. This will be a list of all possible actions that
  can be added to table entries that are added to the specified table.

- Action profiles. When defined in a P4 program, action profiles provide a
  mechanism to share action instances.

- Actions Selectors. When defined in a P4 program can be used to select
  the execution of one or more action instance selected at table lookup
  time by using a hash computation.

- Default hit action. When a default hit action is defined it is used when
  a matched table entry did not define an action. Depending on the P4
  program the default hit action can be updated at runtime (in addition to
  being specified in the template).

- Default miss action. When a default miss action is defined it is used
  when a lookup that table fails.

- Action scope. In addition to actions being annotated as default hit or
  miss they can also be annotated to be either specific to a table of
  globally available to multiple tables within the same P4 program.

- Max entries. This is an upper bound for number of entries a specific
  table allows.

- Num masks. In the case of LPM or ternary matches, this defines the
  maximum allowed masks for that table.

- Timers. When defined in a P4 program, each entry has an associated timer.
  The table entries share a per-table timeout. The timer is refreshed
  every time there's a hit. After an idle period (defined in the per-table
  timeout), the P4 program can define whether it wants to have an event
  generated to user space (and have user space delete the entry), or
  whether it wants the kernel to delete it and send the event to announce
  the deletion.

- per entry "static" vs "dynamic" entry. By default all entries made from
  the control plane are "static" unless otherwise specified. All entries
  added from datapath are "dynamic" unless otherwise specified. "Dynamic"
  entries are subject to deletion when idle (subject to the rules specified
  in "Timers" above).

If one were to retrieve the table named table1 (before or after the
pipeline is sealed) one would use the following command:

tc -j p4template get table/myprog1/mycontrol/table1 | jq .

If one were to dump all the tables from a pipeline named myprog1, one would
use the following command:

tc p4template get table/myprog1

If one were to update table1 (before the pipeline is sealed) one would use
the following command:

tc p4template update table/myprog1/mycontrol/table1 ....

If one were to delete table1 (before the pipeline is sealed) one would use
the following command:

tc p4template del table/myprog1/mycontrol/table1

If one were to flush all the tables from a pipeline named myprog1, control
block "mycontrol" one would use the following command:

tc p4template del table/myprog1/mycontrol/

___Table Permissions___

Tables can have permissions which apply to all the entries in the specified
table. Permissions are defined for both what the control plane (user space)
as well as the data path are allowed to do.

The permissions field is a 16bit value which will hold CRUDXPS (create,
read, update, delete, execute, publish and subscribe) permissions for
control and data path. Bits 13-7 will have the CRUDXPS values for control
and bits 6-0 will have CRUDXPS values for data path. By default each table
has the following permissions:

CRUD-PS-R--X--

Which means the control plane can perform CRUDPS operations whereas the
data path can only Read and execute on the entries.
The user can override these permissions when creating the table or when
updating.

For example, the following command will create a table which will not allow
the datapath to create, update or delete entries but give full CRUDP
permissions for the control plane.

$TC p4template create table/aP4proggie/cb/tname tblid 1 keysz 64 type lpm \
permissions 0x3D24 ...

Recall that these permissions come in the form of CRUDXPSCRUDXPS, where the
first CRUDXPS block is for control and the last is for data path.

So 0x3D24 is equivalent to CR-D-P--R--X--

If we were to issue a read command on a table (tname):

$TC -j p4template get table/aP4proggie/cb/tname | jq .

The output would be the following:

[
  {
    "obj": "table",
    "pname": "aP4Proggie",
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
        "permissions": "CRUD-P--R--X--",
        "table_type": "lpm",
        "acts_list": []
      }
    ]
  }
]

Note, the permissions concept is more powerful than classical const
definition currently taken by P4 which makes everything in a table
read-only.

___Initial Table Entries___

Templating can create initial table entries. For example:

tc p4template update table/myprog/cb/tname \
  entry srcAddr 10.10.10.10/32 dstAddr 1.1.1.0/24 prio 17

In this command we are "updating" table cb/tname with a new entry. This
entry has as its key srcAddr concatenated with dstAddr
(both IPv4 addresses) and prio 17.

If one was to read back the entry by issuing the following command:

tc p4template get table/myprog/cb/tname

They would get:

pipeline id 22
    table id 1
    table name cb/tname
    key_sz 64
    max entries 256
    masks 8
    table entries 1
    permissions CRUD-P--R--X--
    entry:

        entry priority 17[permissions-RUD-P--R--X--]
        entry key
            srcAddr id:1 size:32b type:ipv4 exact fieldval  10.10.10.10/32
            dstAddr id:2 size:32b type:ipv4 exact fieldval  1.1.1.0/24

___Table Actions List___

P4 tables allow certain actions but not other to be part of match entry on
a table. P4 also defines default actions to be executed when no entries
match; we have extended this concept to have a default hit,which is
executed upon matching an entry which has no action associated with it.

We also allow flags for each of the actions in this list that specify if
the action can be added only as a table entry (tableonly), or only as a
default action (defaultonly). If no flags are specified, it is assumed
that the action can be used in both contexts.

Both default hit and default miss are optional.

An example of specifying a default miss action is as follows:

tc p4template update table/myprog/cb/mytable \
    default_miss_action permissions 0x1124 action drop

The above will drop packets if the entry is not found in mytable.
Note the above makes the default action a const. Meaning the control
plane can neither replace it nor delete it.

tc p4template update table/myprog/mytable \
  default_hit_action permissions 0x3004 action ok

Whereas the above allows a default hit action to accept the packet.
The permission 0x3004 (binary 11000000000100) means we have only Create and
Read permissions in the control plane and eXecute permissions in the data
plane. This means, for example, that now we can only delete the default hit
action from the control plane.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h             |  135 ++-
 include/net/p4tc_types.h       |    2 +-
 include/uapi/linux/p4tc.h      |  122 +++
 net/sched/p4tc/Makefile        |    2 +-
 net/sched/p4tc/p4tc_action.c   |    4 +-
 net/sched/p4tc/p4tc_pipeline.c |   23 +-
 net/sched/p4tc/p4tc_table.c    | 1542 ++++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c |    2 +
 8 files changed, 1820 insertions(+), 12 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_table.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 31ba51087..b5e84594e 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -16,10 +16,18 @@
 #define P4TC_DEFAULT_MAX_RULES 1
 #define P4TC_PATH_MAX 3
 #define P4TC_MAX_TENTRIES 0x2000000
+#define P4TC_DEFAULT_TENTRIES 256
+#define P4TC_MAX_TMASKS 1024
+#define P4TC_DEFAULT_TMASKS 8
+#define P4TC_MAX_T_AGING_MS 864000000
+#define P4TC_DEFAULT_T_AGING_MS 30000
+
+#define P4TC_MAX_PERMISSION (GENMASK(P4TC_PERM_MAX_BIT, 0))
 
 #define P4TC_KERNEL_PIPEID 0
 
 #define P4TC_PID_IDX 0
+#define P4TC_TBLID_IDX 1
 #define P4TC_AID_IDX 1
 #define P4TC_PARSEID_IDX 1
 
@@ -70,6 +78,7 @@ extern const struct p4tc_template_ops p4tc_pipeline_ops;
 struct p4tc_pipeline {
 	struct p4tc_template_common common;
 	struct idr                  p_act_idr;
+	struct idr                  p_tbl_idr;
 	struct rcu_head             rcu;
 	struct net                  *net;
 	u32                         num_created_acts;
@@ -123,6 +132,11 @@ struct p4tc_act *p4a_runt_find(struct net *net,
 void
 p4a_runt_prealloc_put(struct p4tc_act *act, struct tcf_p4act *p4_act);
 
+static inline bool p4tc_pipeline_sealed(struct p4tc_pipeline *pipeline)
+{
+	return pipeline->p_state == P4TC_STATE_READY;
+}
+
 static inline int p4tc_action_destroy(struct tc_action **acts)
 {
 	struct tc_action *acts_non_prealloc[TCA_ACT_MAX_PRIO] = {NULL};
@@ -170,6 +184,63 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 	return ret;
 }
 
+#define P4TC_CONTROL_PERMISSIONS (GENMASK(13, 7))
+#define P4TC_DATA_PERMISSIONS (GENMASK(6, 0))
+
+#define P4TC_TABLE_PERMISSIONS                                   \
+	((GENMASK(P4TC_CTRL_PERM_C_BIT, P4TC_CTRL_PERM_D_BIT)) | \
+	 P4TC_CTRL_PERM_P | P4TC_CTRL_PERM_S | P4TC_DATA_PERM_R | \
+	 P4TC_DATA_PERM_X)
+
+#define P4TC_PERMISSIONS_UNINIT (1 << P4TC_PERM_MAX_BIT)
+
+struct p4tc_table_defact {
+	struct tc_action **default_acts;
+	/* Will have two 7 bits blocks containing CRUDXPS (Create, read, update,
+	 * delete, execute, publish and subscribe) permissions for control plane
+	 * and data plane. The first 5 bits are for control and the next five
+	 * are for data plane. |crudxpscrudxps| if we were to denote it as UNIX
+	 * permission flags.
+	 */
+	__u16 permissions;
+	struct rcu_head  rcu;
+};
+
+struct p4tc_table_perm {
+	__u16           permissions;
+	struct rcu_head rcu;
+};
+
+struct p4tc_table {
+	struct p4tc_template_common         common;
+	struct list_head                    tbl_acts_list;
+	struct idr                          tbl_masks_idr;
+	struct idr                          tbl_prio_idr;
+	struct rhltable                     tbl_entries;
+	struct p4tc_table_defact __rcu      *tbl_default_hitact;
+	struct p4tc_table_defact __rcu      *tbl_default_missact;
+	struct p4tc_table_perm __rcu        *tbl_permissions;
+	struct p4tc_table_entry_mask __rcu  **tbl_masks_array;
+	unsigned long __rcu                 *tbl_free_masks_bitmap;
+	u64                                 tbl_aging;
+	/* Locks the available masks IDR which will be used when adding and
+	 * deleting table entries.
+	 */
+	spinlock_t                          tbl_masks_idr_lock;
+	u32                                 tbl_keysz;
+	u32                                 tbl_id;
+	u32                                 tbl_max_entries;
+	u32                                 tbl_max_masks;
+	u32                                 tbl_curr_num_masks;
+	/* Accounts for how many entities refer to this table. Usually just the
+	 * pipeline it belongs to.
+	 */
+	refcount_t                          tbl_ctrl_ref;
+	u16                                 tbl_type;
+};
+
+extern const struct p4tc_template_ops p4tc_table_ops;
+
 struct p4tc_act_param {
 	struct list_head head;
 	struct rcu_head	rcu;
@@ -222,6 +293,12 @@ struct p4tc_act {
 	char                        fullname[ACTNAMSIZ];
 };
 
+struct p4tc_table_act {
+	struct list_head node;
+	struct tc_action_ops *ops;
+	u8     flags;
+};
+
 extern const struct p4tc_template_ops p4tc_act_ops;
 
 static inline int p4tc_action_init(struct net *net, struct nlattr *nla,
@@ -276,12 +353,68 @@ static inline bool p4tc_action_put_ref(struct p4tc_act *act)
 	return refcount_dec_not_one(&act->a_ref);
 }
 
+struct p4tc_act_param *p4a_parm_find_byid(struct idr *params_idr,
+					  const u32 param_id);
+struct p4tc_act_param *
+p4a_parm_find_byany(struct p4tc_act *act, const char *param_name,
+		    const u32 param_id, struct netlink_ext_ack *extack);
+
+struct p4tc_table *p4tc_table_find_byany(struct p4tc_pipeline *pipeline,
+					 const char *tblname, const u32 tbl_id,
+					 struct netlink_ext_ack *extack);
+struct p4tc_table *p4tc_table_find_byid(struct p4tc_pipeline *pipeline,
+					const u32 tbl_id);
+int p4tc_table_try_set_state_ready(struct p4tc_pipeline *pipeline,
+				   struct netlink_ext_ack *extack);
+void p4tc_table_put_mask_array(struct p4tc_pipeline *pipeline);
+struct p4tc_table *p4tc_table_find_get(struct p4tc_pipeline *pipeline,
+				       const char *tblname, const u32 tbl_id,
+				       struct netlink_ext_ack *extack);
+
+static inline bool p4tc_table_put_ref(struct p4tc_table *table)
+{
+	return refcount_dec_not_one(&table->tbl_ctrl_ref);
+}
+
+struct p4tc_table_default_act_params {
+	struct p4tc_table_defact *default_hitact;
+	struct p4tc_table_defact *default_missact;
+	struct nlattr *default_hit_attr;
+	struct nlattr *default_miss_attr;
+};
+
+int
+p4tc_table_init_default_acts(struct net *net,
+			     struct p4tc_table_default_act_params *def_params,
+			     struct p4tc_table *table,
+			     struct list_head *acts_list,
+			     struct netlink_ext_ack *extack);
+
+static inline void
+p4tc_table_defacts_acts_copy(struct p4tc_table_defact *defact_copy,
+			     struct p4tc_table_defact *defact_orig)
+{
+	defact_copy->default_acts = defact_orig->default_acts;
+}
+
+void
+p4tc_table_replace_default_acts(struct p4tc_table *table,
+				struct p4tc_table_default_act_params *def_params,
+				bool lock_rtnl);
+
+struct p4tc_table_perm *
+p4tc_table_init_permissions(struct p4tc_table *table, u16 permissions,
+			    struct netlink_ext_ack *extack);
+void p4tc_table_replace_permissions(struct p4tc_table *table,
+				    struct p4tc_table_perm *tbl_perm,
+				    bool lock_rtnl);
+
 struct tcf_p4act *
 p4a_runt_prealloc_get_next(struct p4tc_act *act);
 void p4a_runt_init_flags(struct tcf_p4act *p4act);
 
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
-#define to_hdrfield(t) ((struct p4tc_hdrfield *)t)
 #define p4tc_to_act(t) ((struct p4tc_act *)t)
+#define p4tc_to_table(t) ((struct p4tc_table *)t)
 
 #endif
diff --git a/include/net/p4tc_types.h b/include/net/p4tc_types.h
index 6cba34e36..8f26b85fe 100644
--- a/include/net/p4tc_types.h
+++ b/include/net/p4tc_types.h
@@ -8,7 +8,7 @@
 
 #include <uapi/linux/p4tc.h>
 
-#define P4TC_T_MAX_BITSZ 128
+#define P4TC_T_MAX_BITSZ P4TC_MAX_KEYSZ
 
 struct p4tc_type_mask_shift {
 	void *mask;
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index f52e826bd..21f49de86 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -26,6 +26,87 @@ struct p4tcmsg {
 #define P4TC_PIPELINE_NAMSIZ P4TC_TMPL_NAMSZ
 #define P4TC_ACT_TMPL_NAMSZ P4TC_TMPL_NAMSZ
 #define P4TC_ACT_PARAM_NAMSIZ P4TC_TMPL_NAMSZ
+#define P4TC_TABLE_NAMSIZ P4TC_TMPL_NAMSZ
+
+#define P4TC_TABLE_FLAGS_KEYSZ (1 << 0)
+#define P4TC_TABLE_FLAGS_MAX_ENTRIES (1 << 1)
+#define P4TC_TABLE_FLAGS_MAX_MASKS (1 << 2)
+#define P4TC_TABLE_FLAGS_DEFAULT_KEY (1 << 3)
+#define P4TC_TABLE_FLAGS_PERMISSIONS (1 << 4)
+#define P4TC_TABLE_FLAGS_TYPE (1 << 5)
+#define P4TC_TABLE_FLAGS_AGING (1 << 6)
+
+enum {
+	P4TC_TABLE_TYPE_UNSPEC,
+	P4TC_TABLE_TYPE_EXACT = 1,
+	P4TC_TABLE_TYPE_LPM = 2,
+	P4TC_TABLE_TYPE_TERNARY = 3,
+	__P4TC_TABLE_TYPE_MAX,
+};
+
+#define P4TC_TABLE_TYPE_MAX (__P4TC_TABLE_TYPE_MAX - 1)
+
+#define P4TC_CTRL_PERM_C_BIT 13
+#define P4TC_CTRL_PERM_R_BIT 12
+#define P4TC_CTRL_PERM_U_BIT 11
+#define P4TC_CTRL_PERM_D_BIT 10
+#define P4TC_CTRL_PERM_X_BIT 9
+#define P4TC_CTRL_PERM_P_BIT 8
+#define P4TC_CTRL_PERM_S_BIT 7
+
+#define P4TC_DATA_PERM_C_BIT 6
+#define P4TC_DATA_PERM_R_BIT 5
+#define P4TC_DATA_PERM_U_BIT 4
+#define P4TC_DATA_PERM_D_BIT 3
+#define P4TC_DATA_PERM_X_BIT 2
+#define P4TC_DATA_PERM_P_BIT 1
+#define P4TC_DATA_PERM_S_BIT 0
+
+#define P4TC_PERM_MAX_BIT P4TC_CTRL_PERM_C_BIT
+
+#define P4TC_CTRL_PERM_C (1 << P4TC_CTRL_PERM_C_BIT)
+#define P4TC_CTRL_PERM_R (1 << P4TC_CTRL_PERM_R_BIT)
+#define P4TC_CTRL_PERM_U (1 << P4TC_CTRL_PERM_U_BIT)
+#define P4TC_CTRL_PERM_D (1 << P4TC_CTRL_PERM_D_BIT)
+#define P4TC_CTRL_PERM_X (1 << P4TC_CTRL_PERM_X_BIT)
+#define P4TC_CTRL_PERM_P (1 << P4TC_CTRL_PERM_P_BIT)
+#define P4TC_CTRL_PERM_S (1 << P4TC_CTRL_PERM_S_BIT)
+
+#define P4TC_DATA_PERM_C (1 << P4TC_DATA_PERM_C_BIT)
+#define P4TC_DATA_PERM_R (1 << P4TC_DATA_PERM_R_BIT)
+#define P4TC_DATA_PERM_U (1 << P4TC_DATA_PERM_U_BIT)
+#define P4TC_DATA_PERM_D (1 << P4TC_DATA_PERM_D_BIT)
+#define P4TC_DATA_PERM_X (1 << P4TC_DATA_PERM_X_BIT)
+#define P4TC_DATA_PERM_P (1 << P4TC_DATA_PERM_P_BIT)
+#define P4TC_DATA_PERM_S (1 << P4TC_DATA_PERM_S_BIT)
+
+#define p4tc_ctrl_create_ok(perm)   ((perm) & P4TC_CTRL_PERM_C)
+#define p4tc_ctrl_read_ok(perm)     ((perm) & P4TC_CTRL_PERM_R)
+#define p4tc_ctrl_update_ok(perm)   ((perm) & P4TC_CTRL_PERM_U)
+#define p4tc_ctrl_delete_ok(perm)   ((perm) & P4TC_CTRL_PERM_D)
+#define p4tc_ctrl_exec_ok(perm)     ((perm) & P4TC_CTRL_PERM_X)
+#define p4tc_ctrl_pub_ok(perm)      ((perm) & P4TC_CTRL_PERM_P)
+#define p4tc_ctrl_sub_ok(perm)      ((perm) & P4TC_CTRL_PERM_S)
+
+#define p4tc_data_create_ok(perm)   ((perm) & P4TC_DATA_PERM_C)
+#define p4tc_data_read_ok(perm)     ((perm) & P4TC_DATA_PERM_R)
+#define p4tc_data_update_ok(perm)   ((perm) & P4TC_DATA_PERM_U)
+#define p4tc_data_delete_ok(perm)   ((perm) & P4TC_DATA_PERM_D)
+#define p4tc_data_exec_ok(perm)     ((perm) & P4TC_DATA_PERM_X)
+#define p4tc_data_pub_ok(perm)      ((perm) & P4TC_DATA_PERM_P)
+#define p4tc_data_sub_ok(perm)      ((perm) & P4TC_DATA_PERM_S)
+
+struct p4tc_table_parm {
+	__u64 tbl_aging;
+	__u32 tbl_keysz;
+	__u32 tbl_max_entries;
+	__u32 tbl_max_masks;
+	__u32 tbl_flags;
+	__u32 tbl_num_entries;
+	__u16 tbl_permissions;
+	__u8  tbl_type;
+	__u8  PAD0;
+};
 
 /* Root attributes */
 enum {
@@ -42,6 +123,7 @@ enum {
 	P4TC_OBJ_UNSPEC,
 	P4TC_OBJ_PIPELINE,
 	P4TC_OBJ_ACT,
+	P4TC_OBJ_TABLE,
 	__P4TC_OBJ_MAX,
 };
 
@@ -101,6 +183,46 @@ enum {
 
 #define P4TC_T_MAX (__P4TC_T_MAX - 1)
 
+enum {
+	P4TC_TABLE_DEFAULT_UNSPEC,
+	P4TC_TABLE_DEFAULT_ACTION,
+	P4TC_TABLE_DEFAULT_PERMISSIONS,
+	__P4TC_TABLE_DEFAULT_MAX
+};
+
+#define P4TC_TABLE_DEFAULT_MAX (__P4TC_TABLE_DEFAULT_MAX - 1)
+
+enum {
+	P4TC_TABLE_ACTS_DEFAULT_ONLY,
+	P4TC_TABLE_ACTS_TABLE_ONLY,
+	__P4TC_TABLE_ACTS_FLAGS_MAX,
+};
+
+#define P4TC_TABLE_ACTS_FLAGS_MAX (__P4TC_TABLE_ACTS_FLAGS_MAX - 1)
+
+enum {
+	P4TC_TABLE_ACT_UNSPEC,
+	P4TC_TABLE_ACT_FLAGS, /* u8 */
+	P4TC_TABLE_ACT_NAME, /* string */
+	__P4TC_TABLE_ACT_MAX
+};
+
+#define P4TC_TABLE_ACT_MAX (__P4TC_TABLE_ACT_MAX - 1)
+
+/* Table type attributes */
+enum {
+	P4TC_TABLE_UNSPEC,
+	P4TC_TABLE_NAME, /* string */
+	P4TC_TABLE_INFO, /* struct p4tc_table_parm */
+	P4TC_TABLE_DEFAULT_HIT, /* nested default hit action attributes */
+	P4TC_TABLE_DEFAULT_MISS, /* nested default miss action attributes */
+	P4TC_TABLE_CONST_ENTRY, /* nested const table entry */
+	P4TC_TABLE_ACTS_LIST, /* nested table actions list */
+	__P4TC_TABLE_MAX
+};
+
+#define P4TC_TABLE_MAX (__P4TC_TABLE_MAX - 1)
+
 /* Action attributes */
 enum {
 	P4TC_ACT_UNSPEC,
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 7dbcf8915..7a9c13f86 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
-	p4tc_action.o
+	p4tc_action.o p4tc_table.o
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
index b0fdfec5b..ac35874b6 100644
--- a/net/sched/p4tc/p4tc_action.c
+++ b/net/sched/p4tc/p4tc_action.c
@@ -645,13 +645,13 @@ p4a_parm_find_byname(struct idr *params_idr, const char *param_name)
 	return NULL;
 }
 
-static struct p4tc_act_param *
+struct p4tc_act_param *
 p4a_parm_find_byid(struct idr *params_idr, const u32 param_id)
 {
 	return idr_find(params_idr, param_id);
 }
 
-static struct p4tc_act_param *
+struct p4tc_act_param *
 p4a_parm_find_byany(struct p4tc_act *act, const char *param_name,
 		    const u32 param_id, struct netlink_ext_ack *extack)
 {
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index c3c957ad8..f7ea1bcae 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -75,6 +75,7 @@ static const struct nla_policy tc_pipeline_policy[P4TC_PIPELINE_MAX + 1] = {
 static void p4tc_pipeline_destroy(struct p4tc_pipeline *pipeline)
 {
 	idr_destroy(&pipeline->p_act_idr);
+	idr_destroy(&pipeline->p_tbl_idr);
 
 	kfree(pipeline);
 }
@@ -97,9 +98,13 @@ static void p4tc_pipeline_teardown(struct p4tc_pipeline *pipeline,
 	struct net *net = pipeline->net;
 	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
 	struct net *pipeline_net = maybe_get_net(net);
-	unsigned long iter_act_id;
+	unsigned long iter_act_id, tmp;
+	struct p4tc_table *table;
 	struct p4tc_act *act;
-	unsigned long tmp;
+	unsigned long tbl_id;
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, tbl_id)
+		table->common.ops->put(pipeline, &table->common, extack);
 
 	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, iter_act_id)
 		act->common.ops->put(pipeline, &act->common, extack);
@@ -150,22 +155,23 @@ static int __p4tc_pipeline_put(struct p4tc_pipeline *pipeline,
 static inline int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
 					       struct netlink_ext_ack *extack)
 {
+	int ret;
+
 	if (pipeline->curr_tables != pipeline->num_tables) {
 		NL_SET_ERR_MSG(extack,
 			       "Must have all table defined to update state to ready");
 		return -EINVAL;
 	}
 
+	ret = p4tc_table_try_set_state_ready(pipeline, extack);
+	if (ret < 0)
+		return ret;
+
 	pipeline->p_state = P4TC_STATE_READY;
 
 	return true;
 }
 
-static inline bool p4tc_pipeline_sealed(struct p4tc_pipeline *pipeline)
-{
-	return pipeline->p_state == P4TC_STATE_READY;
-}
-
 struct p4tc_pipeline *p4tc_pipeline_find_byid(struct net *net, const u32 pipeid)
 {
 	struct p4tc_pipeline_net *pipe_net;
@@ -257,6 +263,9 @@ static struct p4tc_pipeline *p4tc_pipeline_create(struct net *net,
 
 	idr_init(&pipeline->p_act_idr);
 
+	idr_init(&pipeline->p_tbl_idr);
+	pipeline->curr_tables = 0;
+
 	pipeline->num_created_acts = 0;
 
 	pipeline->p_state = P4TC_STATE_NOT_READY;
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
new file mode 100644
index 000000000..ac6c28e2d
--- /dev/null
+++ b/net/sched/p4tc/p4tc_table.c
@@ -0,0 +1,1542 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_table.c	P4 TC TABLE
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
+static int __p4tc_table_try_set_state_ready(struct p4tc_table *table,
+					    struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_entry_mask __rcu **masks_array;
+	unsigned long *tbl_free_masks_bitmap;
+
+	masks_array = kcalloc(table->tbl_max_masks,
+			      sizeof(*table->tbl_masks_array),
+			      GFP_KERNEL);
+	if (!masks_array)
+		return -ENOMEM;
+
+	tbl_free_masks_bitmap =
+		bitmap_alloc(P4TC_MAX_TMASKS, GFP_KERNEL);
+	if (!tbl_free_masks_bitmap) {
+		kfree(masks_array);
+		return -ENOMEM;
+	}
+
+	bitmap_fill(tbl_free_masks_bitmap, P4TC_MAX_TMASKS);
+
+	table->tbl_masks_array = masks_array;
+	rcu_replace_pointer_rtnl(table->tbl_free_masks_bitmap,
+				 tbl_free_masks_bitmap);
+
+	return 0;
+}
+
+static void free_table_cache_array(struct p4tc_table **set_tables,
+				   int num_tables)
+{
+	int i;
+
+	for (i = 0; i < num_tables; i++) {
+		struct p4tc_table_entry_mask __rcu **masks_array;
+		struct p4tc_table *table = set_tables[i];
+		unsigned long *free_masks_bitmap;
+
+		masks_array = table->tbl_masks_array;
+
+		kfree(masks_array);
+		free_masks_bitmap =
+			rtnl_dereference(table->tbl_free_masks_bitmap);
+		bitmap_free(free_masks_bitmap);
+	}
+}
+
+int p4tc_table_try_set_state_ready(struct p4tc_pipeline *pipeline,
+				   struct netlink_ext_ack *extack)
+{
+	struct p4tc_table **set_tables;
+	struct p4tc_table *table;
+	unsigned long tmp, id;
+	int i = 0;
+	int ret;
+
+	set_tables = kcalloc(pipeline->num_tables, sizeof(*set_tables),
+			     GFP_KERNEL);
+	if (!set_tables)
+		return -ENOMEM;
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, id) {
+		ret = __p4tc_table_try_set_state_ready(table, extack);
+		if (ret < 0)
+			goto free_set_tables;
+		set_tables[i] = table;
+		i++;
+	}
+	kfree(set_tables);
+
+	return 0;
+
+free_set_tables:
+	free_table_cache_array(set_tables, i);
+	kfree(set_tables);
+	return ret;
+}
+
+static const struct nla_policy p4tc_table_policy[P4TC_TABLE_MAX + 1] = {
+	[P4TC_TABLE_NAME] = { .type = NLA_STRING, .len = P4TC_TABLE_NAMSIZ },
+	[P4TC_TABLE_INFO] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct p4tc_table_parm)),
+	[P4TC_TABLE_DEFAULT_HIT] = { .type = NLA_NESTED },
+	[P4TC_TABLE_DEFAULT_MISS] = { .type = NLA_NESTED },
+	[P4TC_TABLE_ACTS_LIST] = { .type = NLA_NESTED },
+	[P4TC_TABLE_CONST_ENTRY] = { .type = NLA_NESTED },
+};
+
+static int _p4tc_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_table_parm parm = {0};
+	struct p4tc_table_perm *tbl_perm;
+	struct p4tc_table_act *table_act;
+	struct nlattr *nested_tbl_acts;
+	struct nlattr *default_missact;
+	struct nlattr *default_hitact;
+	struct nlattr *nested_count;
+	struct nlattr *nest;
+	int i = 1;
+
+	if (nla_put_u32(skb, P4TC_PATH, table->tbl_id))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	if (nla_put_string(skb, P4TC_TABLE_NAME, table->common.name))
+		goto out_nlmsg_trim;
+
+	parm.tbl_keysz = table->tbl_keysz;
+	parm.tbl_max_entries = table->tbl_max_entries;
+	parm.tbl_max_masks = table->tbl_max_masks;
+	parm.tbl_type = table->tbl_type;
+	parm.tbl_aging = table->tbl_aging;
+
+	tbl_perm = rcu_dereference_rtnl(table->tbl_permissions);
+	parm.tbl_permissions = tbl_perm->permissions;
+
+	if (table->tbl_default_hitact) {
+		struct p4tc_table_defact *hitact;
+
+		default_hitact = nla_nest_start(skb, P4TC_TABLE_DEFAULT_HIT);
+		rcu_read_lock();
+		hitact = rcu_dereference_rtnl(table->tbl_default_hitact);
+		if (hitact->default_acts) {
+			struct nlattr *nest_defact;
+
+			nest_defact = nla_nest_start(skb,
+						     P4TC_TABLE_DEFAULT_ACTION);
+			if (tcf_action_dump(skb, hitact->default_acts, 0, 0,
+					    false) < 0) {
+				rcu_read_unlock();
+				goto out_nlmsg_trim;
+			}
+			nla_nest_end(skb, nest_defact);
+		}
+		if (nla_put_u16(skb, P4TC_TABLE_DEFAULT_PERMISSIONS,
+				hitact->permissions) < 0) {
+			rcu_read_unlock();
+			goto out_nlmsg_trim;
+		}
+		rcu_read_unlock();
+		nla_nest_end(skb, default_hitact);
+	}
+
+	if (table->tbl_default_missact) {
+		struct p4tc_table_defact *missact;
+
+		default_missact = nla_nest_start(skb, P4TC_TABLE_DEFAULT_MISS);
+		rcu_read_lock();
+		missact = rcu_dereference_rtnl(table->tbl_default_missact);
+		if (missact->default_acts) {
+			struct nlattr *nest_defact;
+
+			nest_defact = nla_nest_start(skb,
+						     P4TC_TABLE_DEFAULT_ACTION);
+			if (tcf_action_dump(skb, missact->default_acts, 0, 0,
+					    false) < 0) {
+				rcu_read_unlock();
+				goto out_nlmsg_trim;
+			}
+			nla_nest_end(skb, nest_defact);
+		}
+		if (nla_put_u16(skb, P4TC_TABLE_DEFAULT_PERMISSIONS,
+				missact->permissions) < 0) {
+			rcu_read_unlock();
+			goto out_nlmsg_trim;
+		}
+		rcu_read_unlock();
+		nla_nest_end(skb, default_missact);
+	}
+
+	nested_tbl_acts = nla_nest_start(skb, P4TC_TABLE_ACTS_LIST);
+	list_for_each_entry(table_act, &table->tbl_acts_list, node) {
+		nested_count = nla_nest_start(skb, i);
+		if (nla_put_string(skb, P4TC_TABLE_ACT_NAME,
+				   table_act->ops->kind) < 0)
+			goto out_nlmsg_trim;
+		if (nla_put_u32(skb, P4TC_TABLE_ACT_FLAGS,
+				table_act->flags) < 0)
+			goto out_nlmsg_trim;
+
+		nla_nest_end(skb, nested_count);
+		i++;
+	}
+	nla_nest_end(skb, nested_tbl_acts);
+
+	if (nla_put(skb, P4TC_TABLE_INFO, sizeof(parm), &parm))
+		goto out_nlmsg_trim;
+	nla_nest_end(skb, nest);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int p4tc_table_fill_nlmsg(struct net *net, struct sk_buff *skb,
+				 struct p4tc_template_common *template,
+				 struct netlink_ext_ack *extack)
+{
+	struct p4tc_table *table = p4tc_to_table(template);
+
+	if (_p4tc_table_fill_nlmsg(skb, table) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for table");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
+{
+	if (defact) {
+		p4tc_action_destroy(defact->default_acts);
+		kfree(defact);
+	}
+}
+
+static void p4tc_table_acts_list_destroy(struct list_head *acts_list)
+{
+	struct p4tc_table_act *table_act, *tmp;
+
+	list_for_each_entry_safe(table_act, tmp, acts_list, node) {
+		struct p4tc_act *act;
+
+		act = container_of(table_act->ops, typeof(*act), ops);
+		list_del(&table_act->node);
+		kfree(table_act);
+		p4tc_action_put_ref(act);
+	}
+}
+
+static void p4tc_table_acts_list_replace(struct list_head *orig,
+					 struct list_head *acts_list)
+{
+	struct p4tc_table_act *table_act, *tmp;
+
+	p4tc_table_acts_list_destroy(orig);
+
+	list_for_each_entry_safe(table_act, tmp, acts_list, node) {
+		list_del_init(&table_act->node);
+		list_add_tail(&table_act->node, orig);
+	}
+}
+
+static void __p4tc_table_put_mask_array(struct p4tc_table *table)
+{
+	unsigned long *free_masks_bitmap;
+
+	kfree(table->tbl_masks_array);
+
+	free_masks_bitmap = rcu_dereference_rtnl(table->tbl_free_masks_bitmap);
+	bitmap_free(free_masks_bitmap);
+}
+
+void p4tc_table_put_mask_array(struct p4tc_pipeline *pipeline)
+{
+	struct p4tc_table *table;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, id) {
+		__p4tc_table_put_mask_array(table);
+	}
+}
+
+static int _p4tc_table_put(struct net *net, struct nlattr **tb,
+			   struct p4tc_pipeline *pipeline,
+			   struct p4tc_table *table,
+			   struct netlink_ext_ack *extack)
+{
+	bool default_act_del = false;
+	struct p4tc_table_perm *perm;
+
+	if (tb)
+		default_act_del = tb[P4TC_TABLE_DEFAULT_HIT] ||
+			tb[P4TC_TABLE_DEFAULT_MISS];
+
+	if (!default_act_del) {
+		if (!refcount_dec_if_one(&table->tbl_ctrl_ref)) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to delete referenced table");
+			return -EBUSY;
+		}
+	}
+
+	if (tb && tb[P4TC_TABLE_DEFAULT_HIT]) {
+		struct p4tc_table_defact *hitact;
+
+		rcu_read_lock();
+		hitact = rcu_dereference(table->tbl_default_hitact);
+		if (hitact && !p4tc_ctrl_delete_ok(hitact->permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Permission denied: Unable to delete default hitact");
+			rcu_read_unlock();
+			return -EPERM;
+		}
+		rcu_read_unlock();
+	}
+
+	if (tb && tb[P4TC_TABLE_DEFAULT_MISS]) {
+		struct p4tc_table_defact *missact;
+
+		rcu_read_lock();
+		missact = rcu_dereference(table->tbl_default_missact);
+		if (missact && !p4tc_ctrl_delete_ok(missact->permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Permission denied: Unable to delete default missact");
+			rcu_read_unlock();
+			return -EPERM;
+		}
+		rcu_read_unlock();
+	}
+
+	if (!default_act_del || tb[P4TC_TABLE_DEFAULT_HIT]) {
+		struct p4tc_table_defact *hitact;
+
+		hitact = rtnl_dereference(table->tbl_default_hitact);
+		if (hitact) {
+			rcu_replace_pointer_rtnl(table->tbl_default_hitact,
+						 NULL);
+			synchronize_rcu();
+			p4tc_table_defact_destroy(hitact);
+		}
+	}
+
+	if (!default_act_del || tb[P4TC_TABLE_DEFAULT_MISS]) {
+		struct p4tc_table_defact *missact;
+
+		missact = rtnl_dereference(table->tbl_default_missact);
+		if (missact) {
+			rcu_replace_pointer_rtnl(table->tbl_default_missact,
+						 NULL);
+			synchronize_rcu();
+			p4tc_table_defact_destroy(missact);
+		}
+	}
+
+	if (default_act_del)
+		return 0;
+
+	p4tc_table_acts_list_destroy(&table->tbl_acts_list);
+
+	idr_destroy(&table->tbl_masks_idr);
+	idr_destroy(&table->tbl_prio_idr);
+
+	perm = rcu_replace_pointer_rtnl(table->tbl_permissions, NULL);
+	kfree_rcu(perm, rcu);
+
+	idr_remove(&pipeline->p_tbl_idr, table->tbl_id);
+	pipeline->curr_tables -= 1;
+
+	__p4tc_table_put_mask_array(table);
+
+	kfree(table);
+
+	return 0;
+}
+
+static int p4tc_table_put(struct p4tc_pipeline *pipeline,
+			  struct p4tc_template_common *tmpl,
+			  struct netlink_ext_ack *extack)
+{
+	struct p4tc_table *table = p4tc_to_table(tmpl);
+
+	return _p4tc_table_put(pipeline->net, NULL, pipeline, table, extack);
+}
+
+struct p4tc_table *p4tc_table_find_byid(struct p4tc_pipeline *pipeline,
+					const u32 tbl_id)
+{
+	return idr_find(&pipeline->p_tbl_idr, tbl_id);
+}
+
+static struct p4tc_table *p4tc_table_find_byname(const char *tblname,
+						 struct p4tc_pipeline *pipeline)
+{
+	struct p4tc_table *table;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, id)
+		if (strncmp(table->common.name, tblname,
+			    P4TC_TABLE_NAMSIZ) == 0)
+			return table;
+
+	return NULL;
+}
+
+struct p4tc_table *p4tc_table_find_byany(struct p4tc_pipeline *pipeline,
+					 const char *tblname, const u32 tbl_id,
+					 struct netlink_ext_ack *extack)
+{
+	struct p4tc_table *table;
+	int err;
+
+	if (tbl_id) {
+		table = p4tc_table_find_byid(pipeline, tbl_id);
+		if (!table) {
+			NL_SET_ERR_MSG(extack, "Unable to find table by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (tblname) {
+			table = p4tc_table_find_byname(tblname, pipeline);
+			if (!table) {
+				NL_SET_ERR_MSG(extack, "Table name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack, "Must specify table name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return table;
+out:
+	return ERR_PTR(err);
+}
+
+static int p4tc_table_get(struct p4tc_table *table)
+{
+	return refcount_inc_not_zero(&table->tbl_ctrl_ref);
+}
+
+struct p4tc_table *p4tc_table_find_get(struct p4tc_pipeline *pipeline,
+				       const char *tblname, const u32 tbl_id,
+				       struct netlink_ext_ack *extack)
+{
+	struct p4tc_table *table;
+
+	table = p4tc_table_find_byany(pipeline, tblname, tbl_id, extack);
+	if (IS_ERR(table))
+		return table;
+
+	if (!p4tc_table_get(table)) {
+		NL_SET_ERR_MSG(extack, "Table is marked for deletion");
+		return ERR_PTR(-EBUSY);
+	}
+
+	return table;
+}
+
+/* Permissions can also be updated by runtime command */
+static int __p4tc_table_init_default_act(struct net *net, struct nlattr **tb,
+					 struct p4tc_table_defact **default_act,
+					 u32 pipeid, __u16 curr_permissions,
+					 struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	*default_act = kzalloc(sizeof(**default_act), GFP_KERNEL);
+	if (!(*default_act))
+		return -ENOMEM;
+
+	if (tb[P4TC_TABLE_DEFAULT_PERMISSIONS]) {
+		__u16 *permissions;
+
+		permissions = nla_data(tb[P4TC_TABLE_DEFAULT_PERMISSIONS]);
+		if (!p4tc_ctrl_read_ok(*permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Default action must have ctrl path read permissions");
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		if (!p4tc_data_read_ok(*permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Default action must have data path read permissions");
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		if (!p4tc_data_exec_ok(*permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Default action must have data path execute permissions");
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		(*default_act)->permissions = *permissions;
+	} else {
+		(*default_act)->permissions = curr_permissions;
+	}
+
+	if (tb[P4TC_TABLE_DEFAULT_ACTION]) {
+		struct tc_action **default_acts;
+
+		if (!p4tc_ctrl_update_ok(curr_permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Permission denied: Unable to update default hit action");
+			ret = -EPERM;
+			goto default_act_free;
+		}
+
+		default_acts = kcalloc(TCA_ACT_MAX_PRIO,
+				       sizeof(struct tc_action *), GFP_KERNEL);
+		if (!default_acts) {
+			ret = -ENOMEM;
+			goto default_act_free;
+		}
+
+		ret = p4tc_action_init(net, tb[P4TC_TABLE_DEFAULT_ACTION],
+				       default_acts, pipeid, 0, extack);
+		if (ret < 0) {
+			kfree(default_acts);
+			goto default_act_free;
+		} else if (ret > 1) {
+			NL_SET_ERR_MSG(extack, "Can only have one hit action");
+			p4tc_action_destroy(default_acts);
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		(*default_act)->default_acts = default_acts;
+	}
+
+	return 0;
+
+default_act_free:
+	kfree(*default_act);
+
+	return ret;
+}
+
+static int p4tc_table_check_defacts(struct tc_action *defact,
+				    struct list_head *acts_list)
+{
+	struct p4tc_table_act *table_act;
+
+	list_for_each_entry(table_act, acts_list, node) {
+		if (table_act->ops->id == defact->ops->id &&
+		    !(table_act->flags & BIT(P4TC_TABLE_ACTS_TABLE_ONLY)))
+			return true;
+	}
+
+	return false;
+}
+
+static struct nla_policy p4tc_table_default_policy[P4TC_TABLE_DEFAULT_MAX + 1] = {
+	[P4TC_TABLE_DEFAULT_ACTION] = { .type = NLA_NESTED },
+	[P4TC_TABLE_DEFAULT_PERMISSIONS] =
+		NLA_POLICY_MAX(NLA_U16, P4TC_MAX_PERMISSION),
+};
+
+/* Runtime and template call this */
+static int
+p4tc_table_init_default_act(struct net *net, struct nlattr *nla,
+			    struct p4tc_table *table,
+			    u16 curr_permissions,
+			    struct p4tc_table_defact **default_act,
+			    struct list_head *acts_list,
+			    struct netlink_ext_ack *extack)
+{
+	u16 permissions = P4TC_CONTROL_PERMISSIONS | P4TC_DATA_PERMISSIONS;
+	struct nlattr *tb[P4TC_TABLE_DEFAULT_MAX + 1];
+	int ret;
+
+	if (curr_permissions)
+		permissions = curr_permissions;
+
+	ret = nla_parse_nested(tb, P4TC_TABLE_DEFAULT_MAX, nla,
+			       p4tc_table_default_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (!tb[P4TC_TABLE_DEFAULT_ACTION] &&
+	    !tb[P4TC_TABLE_DEFAULT_PERMISSIONS])
+		return 0;
+
+	ret = __p4tc_table_init_default_act(net, tb,
+					    default_act,
+					    table->common.p_id, permissions,
+					    extack);
+	if (ret < 0)
+		return ret;
+	if ((*default_act)->default_acts &&
+	    !p4tc_table_check_defacts((*default_act)->default_acts[0],
+				      acts_list)) {
+		NL_SET_ERR_MSG(extack,
+			       "Action is not allowed as default hit action");
+		p4tc_table_defact_destroy(*default_act);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+struct p4tc_table_perm *
+p4tc_table_init_permissions(struct p4tc_table *table, u16 permissions,
+			    struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_perm *tbl_perm;
+	int ret;
+
+	if (permissions > P4TC_MAX_PERMISSION) {
+		NL_SET_ERR_MSG(extack,
+			       "Permission may only have 14 bits turned on");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tbl_perm = kzalloc(sizeof(*tbl_perm), GFP_KERNEL);
+	if (!tbl_perm) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tbl_perm->permissions = permissions;
+
+	return tbl_perm;
+
+out:
+	return ERR_PTR(ret);
+}
+
+void p4tc_table_replace_permissions(struct p4tc_table *table,
+				    struct p4tc_table_perm *tbl_perm,
+				    bool lock_rtnl)
+{
+	if (!tbl_perm)
+		return;
+
+	if (lock_rtnl)
+		rtnl_lock();
+	tbl_perm = rcu_replace_pointer_rtnl(table->tbl_permissions, tbl_perm);
+	if (lock_rtnl)
+		rtnl_unlock();
+	kfree_rcu(tbl_perm, rcu);
+}
+
+int
+p4tc_table_init_default_acts(struct net *net,
+			     struct p4tc_table_default_act_params *def_params,
+			     struct p4tc_table *table,
+			     struct list_head *acts_list,
+			     struct netlink_ext_ack *extack)
+{
+	u16 permissions;
+	int ret;
+
+	def_params->default_missact = NULL;
+	def_params->default_hitact = NULL;
+
+	if (def_params->default_hit_attr) {
+		struct p4tc_table_defact *tmp_default_hitact;
+
+		permissions = P4TC_CONTROL_PERMISSIONS | P4TC_DATA_PERMISSIONS;
+
+		rcu_read_lock();
+		if (table->tbl_default_hitact) {
+			tmp_default_hitact = rcu_dereference(table->tbl_default_hitact);
+			permissions = tmp_default_hitact->permissions;
+		}
+		rcu_read_unlock();
+
+		ret = p4tc_table_init_default_act(net,
+						  def_params->default_hit_attr,
+						  table, permissions,
+						  &def_params->default_hitact,
+						  acts_list, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (def_params->default_miss_attr) {
+		struct p4tc_table_defact *tmp_default_missact;
+
+		permissions = P4TC_CONTROL_PERMISSIONS | P4TC_DATA_PERMISSIONS;
+
+		rcu_read_lock();
+		if (table->tbl_default_missact) {
+			tmp_default_missact = rcu_dereference(table->tbl_default_missact);
+			permissions = tmp_default_missact->permissions;
+		}
+		rcu_read_unlock();
+
+		ret = p4tc_table_init_default_act(net,
+						  def_params->default_miss_attr,
+						  table, permissions,
+						  &def_params->default_missact,
+						  acts_list, extack);
+		if (ret < 0)
+			goto default_hitacts_free;
+	}
+
+	return 0;
+
+default_hitacts_free:
+	p4tc_table_defact_destroy(def_params->default_hitact);
+
+	return ret;
+}
+
+static const struct nla_policy p4tc_acts_list_policy[P4TC_TABLE_MAX + 1] = {
+	[P4TC_TABLE_ACT_FLAGS] =
+		NLA_POLICY_RANGE(NLA_U8, 0, BIT(P4TC_TABLE_ACTS_FLAGS_MAX)),
+	[P4TC_TABLE_ACT_NAME] = { .type = NLA_STRING, .len = ACTNAMSIZ },
+};
+
+static struct p4tc_table_act *p4tc_table_act_init(struct nlattr *nla,
+						  struct p4tc_pipeline *pipeline,
+						  struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TABLE_ACT_MAX + 1];
+	struct p4tc_table_act *table_act;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TABLE_ACT_MAX, nla,
+			       p4tc_acts_list_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	table_act = kzalloc(sizeof(*table_act), GFP_KERNEL);
+	if (unlikely(!table_act))
+		return ERR_PTR(-ENOMEM);
+
+	if (tb[P4TC_TABLE_ACT_NAME]) {
+		const char *fullname = nla_data(tb[P4TC_TABLE_ACT_NAME]);
+		char *pname, *aname, actname[ACTNAMSIZ];
+		struct p4tc_act *act;
+
+		nla_strscpy(actname, tb[P4TC_TABLE_ACT_NAME], ACTNAMSIZ);
+		aname = actname;
+
+		pname = strsep(&aname, "/");
+		if (!aname) {
+			NL_SET_ERR_MSG(extack,
+				       "Action name must have format pname/actname");
+			ret = -EINVAL;
+			goto free_table_act;
+		}
+
+		if (strncmp(pipeline->common.name, pname, P4TC_PIPELINE_NAMSIZ)) {
+			NL_SET_ERR_MSG_FMT(extack, "Pipeline name must be %s\n",
+					   pipeline->common.name);
+			ret = -EINVAL;
+			goto free_table_act;
+		}
+
+		act = p4a_tmpl_get(pipeline, fullname, 0, extack);
+		if (IS_ERR(act)) {
+			ret = PTR_ERR(act);
+			goto free_table_act;
+		}
+
+		table_act->ops = &act->ops;
+	} else {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify allowed table action name");
+		ret = -EINVAL;
+		goto free_table_act;
+	}
+
+	if (tb[P4TC_TABLE_ACT_FLAGS]) {
+		u8 *flags = nla_data(tb[P4TC_TABLE_ACT_FLAGS]);
+
+		table_act->flags = *flags;
+	}
+
+	return table_act;
+
+free_table_act:
+	kfree(table_act);
+	return ERR_PTR(ret);
+}
+
+void
+p4tc_table_replace_default_acts(struct p4tc_table *table,
+				struct p4tc_table_default_act_params *def_params,
+				bool lock_rtnl)
+{
+	if (def_params->default_hitact) {
+		bool updated_actions = !!def_params->default_hitact->default_acts;
+		struct p4tc_table_defact *hitact;
+
+		if (lock_rtnl)
+			rtnl_lock();
+		if (!updated_actions) {
+			hitact = rcu_dereference_rtnl(table->tbl_default_hitact);
+			p4tc_table_defacts_acts_copy(def_params->default_hitact,
+						     hitact);
+		}
+		hitact = rcu_replace_pointer_rtnl(table->tbl_default_hitact,
+						  def_params->default_hitact);
+		if (lock_rtnl)
+			rtnl_unlock();
+		if (hitact) {
+			synchronize_rcu();
+			if (updated_actions)
+				p4tc_table_defact_destroy(hitact);
+			else
+				kfree(hitact);
+		}
+	}
+
+	if (def_params->default_missact) {
+		bool updated_actions = !!def_params->default_missact->default_acts;
+		struct p4tc_table_defact *missact;
+
+		if (lock_rtnl)
+			rtnl_lock();
+		if (!updated_actions) {
+			missact = rcu_dereference_rtnl(table->tbl_default_missact);
+			p4tc_table_defacts_acts_copy(def_params->default_missact,
+						     missact);
+		}
+		missact = rcu_replace_pointer_rtnl(table->tbl_default_missact,
+						   def_params->default_missact);
+		if (lock_rtnl)
+			rtnl_unlock();
+		if (missact) {
+			synchronize_rcu();
+			if (updated_actions)
+				p4tc_table_defact_destroy(missact);
+			else
+				kfree(missact);
+		}
+	}
+}
+
+static int p4tc_table_acts_list_init(struct nlattr *nla,
+				     struct p4tc_pipeline *pipeline,
+				     struct list_head *acts_list,
+				     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	struct p4tc_table_act *table_act;
+	int ret;
+	int i;
+
+	ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, extack);
+	if (ret < 0)
+		return ret;
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		table_act = p4tc_table_act_init(tb[i], pipeline, extack);
+		if (IS_ERR(table_act)) {
+			ret = PTR_ERR(table_act);
+			goto free_acts_list_list;
+		}
+		list_add_tail(&table_act->node, acts_list);
+	}
+
+	return 0;
+
+free_acts_list_list:
+	p4tc_table_acts_list_destroy(acts_list);
+
+	return ret;
+}
+
+static struct p4tc_table *
+p4tc_table_find_byanyattr(struct p4tc_pipeline *pipeline,
+			  struct nlattr *name_attr, const u32 tbl_id,
+			  struct netlink_ext_ack *extack)
+{
+	char *tblname = NULL;
+
+	if (name_attr)
+		tblname = nla_data(name_attr);
+
+	return p4tc_table_find_byany(pipeline, tblname, tbl_id, extack);
+}
+
+static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
+					    u32 tbl_id,
+					    struct p4tc_pipeline *pipeline,
+					    struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_default_act_params def_params = {0};
+	struct p4tc_table_perm *tbl_init_perms = NULL;
+	struct p4tc_table_parm *parm;
+	struct p4tc_table *table;
+	char *tblname;
+	int ret;
+
+	if (pipeline->curr_tables == pipeline->num_tables) {
+		NL_SET_ERR_MSG(extack,
+			       "Table range exceeded max allowed value");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Name has the following syntax cb/tname */
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_TABLE_NAME)) {
+		NL_SET_ERR_MSG(extack, "Must specify table name");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tblname =
+		strnchr(nla_data(tb[P4TC_TABLE_NAME]), P4TC_TABLE_NAMSIZ, '/');
+	if (!tblname) {
+		NL_SET_ERR_MSG(extack, "Table name must contain control block");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tblname += 1;
+	if (tblname[0] == '\0') {
+		NL_SET_ERR_MSG(extack, "Control block name is too big");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	table = p4tc_table_find_byanyattr(pipeline, tb[P4TC_TABLE_NAME], tbl_id,
+					  NULL);
+	if (!IS_ERR(table)) {
+		NL_SET_ERR_MSG(extack, "Table already exists");
+		ret = -EEXIST;
+		goto out;
+	}
+
+	table = kzalloc(sizeof(*table), GFP_KERNEL);
+	if (!table) {
+		NL_SET_ERR_MSG(extack, "Unable to create table");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	table->common.p_id = pipeline->common.p_id;
+	strscpy(table->common.name, nla_data(tb[P4TC_TABLE_NAME]),
+		P4TC_TABLE_NAMSIZ);
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_TABLE_INFO)) {
+		ret = -EINVAL;
+		NL_SET_ERR_MSG(extack, "Missing table info");
+		goto free;
+	}
+
+	parm = nla_data(tb[P4TC_TABLE_INFO]);
+	if (!parm->tbl_keysz) {
+		NL_SET_ERR_MSG(extack, "Table keysz cannot be zero");
+		ret = -EINVAL;
+		goto free;
+	}
+	if (parm->tbl_keysz > P4TC_MAX_KEYSZ) {
+		NL_SET_ERR_MSG(extack,
+			       "Table keysz exceeds maximum keysz");
+		ret = -EINVAL;
+		goto free;
+	}
+	table->tbl_keysz = parm->tbl_keysz;
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_MAX_ENTRIES) {
+		if (!parm->tbl_max_entries) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max_entries cannot be zero");
+			ret = -EINVAL;
+			goto free;
+		}
+		if (parm->tbl_max_entries > P4TC_MAX_TENTRIES) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max_entries exceeds maximum value");
+			ret = -EINVAL;
+			goto free;
+		}
+		table->tbl_max_entries = parm->tbl_max_entries;
+	} else {
+		table->tbl_max_entries = P4TC_DEFAULT_TENTRIES;
+	}
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_MAX_MASKS) {
+		if (!parm->tbl_max_masks) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max_masks cannot be zero");
+			ret = -EINVAL;
+			goto free;
+		}
+		if (parm->tbl_max_masks > P4TC_MAX_TMASKS) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max_masks exceeds maximum value");
+			ret = -EINVAL;
+			goto free;
+		}
+		table->tbl_max_masks = parm->tbl_max_masks;
+	} else {
+		table->tbl_max_masks = P4TC_DEFAULT_TMASKS;
+	}
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_PERMISSIONS) {
+		u16 tbl_perms = parm->tbl_permissions;
+
+		tbl_init_perms = p4tc_table_init_permissions(table, tbl_perms,
+							     extack);
+		if (IS_ERR(tbl_init_perms)) {
+			ret = PTR_ERR(tbl_init_perms);
+			goto free;
+		}
+		rcu_assign_pointer(table->tbl_permissions, tbl_init_perms);
+	} else {
+		u16 tbl_perms = P4TC_TABLE_PERMISSIONS;
+
+		tbl_init_perms = p4tc_table_init_permissions(table,
+							     tbl_perms,
+							     extack);
+		if (IS_ERR(tbl_init_perms)) {
+			ret = PTR_ERR(tbl_init_perms);
+			goto free;
+		}
+		rcu_assign_pointer(table->tbl_permissions, tbl_init_perms);
+	}
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_TYPE) {
+		if (parm->tbl_type > P4TC_TABLE_TYPE_MAX) {
+			NL_SET_ERR_MSG(extack, "Table type must be Exact / LPM / Ternary");
+			ret = -EINVAL;
+			goto free_permissions;
+		}
+		table->tbl_type = parm->tbl_type;
+	} else {
+		table->tbl_type = P4TC_TABLE_TYPE_EXACT;
+	}
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_AGING) {
+		if (!parm->tbl_aging) {
+			NL_SET_ERR_MSG(extack,
+				       "Table aging can't be zero");
+			ret = -EINVAL;
+			goto free;
+		}
+		if (parm->tbl_aging > P4TC_MAX_T_AGING_MS) {
+			NL_SET_ERR_MSG(extack,
+				       "Table aging exceeds maximum value");
+			ret = -EINVAL;
+			goto free;
+		}
+		table->tbl_aging = parm->tbl_aging;
+	} else {
+		table->tbl_aging = P4TC_DEFAULT_T_AGING_MS;
+	}
+
+	refcount_set(&table->tbl_ctrl_ref, 1);
+
+	if (tbl_id) {
+		table->tbl_id = tbl_id;
+		ret = idr_alloc_u32(&pipeline->p_tbl_idr, table, &table->tbl_id,
+				    table->tbl_id, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate table id");
+			goto free_permissions;
+		}
+	} else {
+		table->tbl_id = 1;
+		ret = idr_alloc_u32(&pipeline->p_tbl_idr, table, &table->tbl_id,
+				    UINT_MAX, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate table id");
+			goto free_permissions;
+		}
+	}
+
+	INIT_LIST_HEAD(&table->tbl_acts_list);
+	if (tb[P4TC_TABLE_ACTS_LIST]) {
+		ret = p4tc_table_acts_list_init(tb[P4TC_TABLE_ACTS_LIST],
+						pipeline, &table->tbl_acts_list,
+						extack);
+		if (ret < 0)
+			goto idr_rm;
+	}
+
+	def_params.default_hit_attr = tb[P4TC_TABLE_DEFAULT_HIT];
+	def_params.default_miss_attr = tb[P4TC_TABLE_DEFAULT_MISS];
+
+	ret = p4tc_table_init_default_acts(net, &def_params, table,
+					   &table->tbl_acts_list, extack);
+	if (ret < 0)
+		goto idr_rm;
+
+	rcu_replace_pointer_rtnl(table->tbl_default_hitact,
+				 def_params.default_hitact);
+	rcu_replace_pointer_rtnl(table->tbl_default_missact,
+				 def_params.default_missact);
+
+	if (def_params.default_hitact &&
+	    !def_params.default_hitact->default_acts) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify defaults_hit_actions's action values");
+		ret = -EINVAL;
+		goto defaultacts_destroy;
+	}
+
+	if (def_params.default_missact &&
+	    !def_params.default_missact->default_acts) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify defaults_miss_actions's action values");
+		ret = -EINVAL;
+		goto defaultacts_destroy;
+	}
+
+	idr_init(&table->tbl_masks_idr);
+	idr_init(&table->tbl_prio_idr);
+	spin_lock_init(&table->tbl_masks_idr_lock);
+
+	pipeline->curr_tables += 1;
+
+	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
+
+	return table;
+
+defaultacts_destroy:
+	p4tc_table_defact_destroy(def_params.default_hitact);
+	p4tc_table_defact_destroy(def_params.default_missact);
+
+idr_rm:
+	idr_remove(&pipeline->p_tbl_idr, table->tbl_id);
+
+free_permissions:
+	kfree(tbl_init_perms);
+
+	p4tc_table_acts_list_destroy(&table->tbl_acts_list);
+
+free:
+	kfree(table);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_table *p4tc_table_update(struct net *net, struct nlattr **tb,
+					    u32 tbl_id,
+					    struct p4tc_pipeline *pipeline,
+					    u32 flags,
+					    struct netlink_ext_ack *extack)
+{
+	u32 tbl_max_masks = 0, tbl_max_entries = 0, tbl_keysz = 0;
+	struct p4tc_table_default_act_params def_params = {0};
+	struct list_head *tbl_acts_list = NULL;
+	struct p4tc_table_perm *perm = NULL;
+	struct p4tc_table_parm *parm = NULL;
+	struct p4tc_table *table;
+	u64 tbl_aging = 0;
+	u8 tbl_type;
+	int ret = 0;
+
+	table = p4tc_table_find_byanyattr(pipeline, tb[P4TC_TABLE_NAME], tbl_id,
+					  extack);
+	if (IS_ERR(table))
+		return table;
+
+	/* Check if we are replacing this at the end */
+	if (tb[P4TC_TABLE_ACTS_LIST]) {
+		tbl_acts_list = kzalloc(sizeof(*tbl_acts_list), GFP_KERNEL);
+		if (!tbl_acts_list) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		INIT_LIST_HEAD(tbl_acts_list);
+		ret = p4tc_table_acts_list_init(tb[P4TC_TABLE_ACTS_LIST],
+						pipeline, tbl_acts_list, extack);
+		if (ret < 0)
+			goto table_acts_destroy;
+	}
+
+	def_params.default_hit_attr = tb[P4TC_TABLE_DEFAULT_HIT];
+	def_params.default_miss_attr = tb[P4TC_TABLE_DEFAULT_MISS];
+
+	if (tbl_acts_list)
+		ret = p4tc_table_init_default_acts(net, &def_params, table,
+						   tbl_acts_list, extack);
+	else
+		ret = p4tc_table_init_default_acts(net, &def_params, table,
+						   &table->tbl_acts_list,
+						   extack);
+	if (ret < 0)
+		goto table_acts_destroy;
+
+	tbl_type = table->tbl_type;
+
+	if (tb[P4TC_TABLE_INFO]) {
+		parm = nla_data(tb[P4TC_TABLE_INFO]);
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_KEYSZ) {
+			if (!parm->tbl_keysz) {
+				NL_SET_ERR_MSG(extack,
+					       "Table keysz cannot be zero");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			if (parm->tbl_keysz > P4TC_MAX_KEYSZ) {
+				NL_SET_ERR_MSG(extack,
+					       "Table keysz exceeds maximum keysz");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			tbl_keysz = parm->tbl_keysz;
+		}
+
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_MAX_ENTRIES) {
+			if (!parm->tbl_max_entries) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_entries cannot be zero");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			if (parm->tbl_max_entries > P4TC_MAX_TENTRIES) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_entries exceeds maximum value");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			tbl_max_entries = parm->tbl_max_entries;
+		}
+
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_MAX_MASKS) {
+			if (!parm->tbl_max_masks) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_masks cannot be zero");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			if (parm->tbl_max_masks > P4TC_MAX_TMASKS) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_masks exceeds maximum value");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			tbl_max_masks = parm->tbl_max_masks;
+		}
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_PERMISSIONS) {
+			perm = p4tc_table_init_permissions(table,
+							   parm->tbl_permissions,
+							   extack);
+			if (IS_ERR(perm)) {
+				ret = PTR_ERR(perm);
+				goto defaultacts_destroy;
+			}
+		}
+
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_TYPE) {
+			if (parm->tbl_type > P4TC_TABLE_TYPE_MAX) {
+				NL_SET_ERR_MSG(extack, "Table type can only be exact or LPM");
+				ret = -EINVAL;
+				goto free_perm;
+			}
+			tbl_type = parm->tbl_type;
+		}
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_AGING) {
+			if (!parm->tbl_aging) {
+				NL_SET_ERR_MSG(extack,
+					       "Table aging can't be zero");
+				ret = -EINVAL;
+				goto free_perm;
+			}
+			if (parm->tbl_aging > P4TC_MAX_T_AGING_MS) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_masks exceeds maximum value");
+				ret = -EINVAL;
+				goto free_perm;
+			}
+			tbl_aging = parm->tbl_aging;
+		}
+	}
+
+	p4tc_table_replace_default_acts(table, &def_params, false);
+	p4tc_table_replace_permissions(table, perm, false);
+
+	if (tbl_keysz)
+		table->tbl_keysz = tbl_keysz;
+	if (tbl_max_entries)
+		table->tbl_max_entries = tbl_max_entries;
+	if (tbl_max_masks)
+		table->tbl_max_masks = tbl_max_masks;
+	table->tbl_type = tbl_type;
+	if (tbl_aging)
+		table->tbl_aging = tbl_aging;
+
+	if (tbl_acts_list)
+		p4tc_table_acts_list_replace(&table->tbl_acts_list,
+					     tbl_acts_list);
+
+	return table;
+
+free_perm:
+	kfree(perm);
+
+defaultacts_destroy:
+	p4tc_table_defact_destroy(def_params.default_missact);
+	p4tc_table_defact_destroy(def_params.default_hitact);
+
+table_acts_destroy:
+	if (tbl_acts_list) {
+		p4tc_table_acts_list_destroy(tbl_acts_list);
+		kfree(tbl_acts_list);
+	}
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+p4tc_table_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+	      struct p4tc_path_nlattrs *nl_path_attrs,
+	      struct netlink_ext_ack *extack)
+{
+	u32 *ids = nl_path_attrs->ids;
+	u32 pipeid = ids[P4TC_PID_IDX], tbl_id = ids[P4TC_TBLID_IDX];
+	struct nlattr *tb[P4TC_TABLE_MAX + 1];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+	int ret;
+
+	pipeline = p4tc_pipeline_find_byany_unsealed(net, nl_path_attrs->pname,
+						     pipeid, extack);
+	if (IS_ERR(pipeline))
+		return (void *)pipeline;
+
+	ret = nla_parse_nested(tb, P4TC_TABLE_MAX, nla, p4tc_table_policy,
+			       extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	switch (n->nlmsg_type) {
+	case RTM_CREATEP4TEMPLATE:
+		table = p4tc_table_create(net, tb, tbl_id, pipeline, extack);
+		break;
+	case RTM_UPDATEP4TEMPLATE:
+		table = p4tc_table_update(net, tb, tbl_id, pipeline,
+					  n->nlmsg_flags, extack);
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (IS_ERR(table))
+		goto out;
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			P4TC_PIPELINE_NAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!ids[P4TC_TBLID_IDX])
+		ids[P4TC_TBLID_IDX] = table->tbl_id;
+
+out:
+	return (struct p4tc_template_common *)table;
+}
+
+static int p4tc_table_flush(struct net *net, struct sk_buff *skb,
+			    struct p4tc_pipeline *pipeline,
+			    struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	unsigned long tmp, tbl_id;
+	struct p4tc_table *table;
+	int ret = 0;
+	int i = 0;
+
+	if (nla_put_u32(skb, P4TC_PATH, 0))
+		goto out_nlmsg_trim;
+
+	if (idr_is_empty(&pipeline->p_tbl_idr)) {
+		NL_SET_ERR_MSG(extack, "There are no tables to flush");
+		goto out_nlmsg_trim;
+	}
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, tbl_id) {
+		if (_p4tc_table_put(net, NULL, pipeline, table, extack) < 0) {
+			ret = -EBUSY;
+			continue;
+		}
+		i++;
+	}
+
+	if (nla_put_u32(skb, P4TC_COUNT, i))
+		goto out_nlmsg_trim;
+
+	if (ret < 0) {
+		if (i == 0) {
+			NL_SET_ERR_MSG(extack, "Unable to flush any table");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Flushed only %u tables", i);
+		}
+	}
+
+	return i;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return ret;
+}
+
+static int p4tc_table_gd(struct net *net, struct sk_buff *skb,
+			 struct nlmsghdr *n, struct nlattr *nla,
+			 struct p4tc_path_nlattrs *nl_path_attrs,
+			 struct netlink_ext_ack *extack)
+{
+	u32 *ids = nl_path_attrs->ids;
+	u32 pipeid = ids[P4TC_PID_IDX], tbl_id = ids[P4TC_TBLID_IDX];
+	struct nlattr *tb[P4TC_TABLE_MAX + 1] = {};
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+	int ret = 0;
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_TABLE_MAX, nla,
+				       p4tc_table_policy, extack);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	if (n->nlmsg_type == RTM_GETP4TEMPLATE)
+		pipeline = p4tc_pipeline_find_byany(net,
+						    nl_path_attrs->pname,
+						    pipeid,
+						    extack);
+	else
+		pipeline = p4tc_pipeline_find_byany_unsealed(net,
+							     nl_path_attrs->pname,
+							     pipeid, extack);
+
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			P4TC_PIPELINE_NAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && (n->nlmsg_flags & NLM_F_ROOT))
+		return p4tc_table_flush(net, skb, pipeline, extack);
+
+	table = p4tc_table_find_byanyattr(pipeline, tb[P4TC_TABLE_NAME], tbl_id,
+					  extack);
+	if (IS_ERR(table))
+		return PTR_ERR(table);
+
+	if (_p4tc_table_fill_nlmsg(skb, table) < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for table");
+		return -EINVAL;
+	}
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = _p4tc_table_put(net, tb, pipeline, table, extack);
+		if (ret < 0)
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
+static int p4tc_table_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			   struct nlattr *nla, char **p_name, u32 *ids,
+			   struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct p4tc_pipeline *pipeline;
+
+	if (!ctx->ids[P4TC_PID_IDX]) {
+		pipeline = p4tc_pipeline_find_byany(net, *p_name,
+						    ids[P4TC_PID_IDX], extack);
+		if (IS_ERR(pipeline))
+			return PTR_ERR(pipeline);
+		ctx->ids[P4TC_PID_IDX] = pipeline->common.p_id;
+	} else {
+		pipeline = p4tc_pipeline_find_byid(net, ctx->ids[P4TC_PID_IDX]);
+	}
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!(*p_name))
+		*p_name = pipeline->common.name;
+
+	return p4tc_tmpl_generic_dump(skb, ctx, &pipeline->p_tbl_idr,
+				      P4TC_TBLID_IDX, extack);
+}
+
+static int p4tc_table_dump_1(struct sk_buff *skb,
+			     struct p4tc_template_common *common)
+{
+	struct nlattr *nest = nla_nest_start(skb, P4TC_PARAMS);
+	struct p4tc_table *table = p4tc_to_table(common);
+
+	if (!nest)
+		return -ENOMEM;
+
+	if (nla_put_string(skb, P4TC_TABLE_NAME, table->common.name)) {
+		nla_nest_cancel(skb, nest);
+		return -ENOMEM;
+	}
+
+	nla_nest_end(skb, nest);
+
+	return 0;
+}
+
+const struct p4tc_template_ops p4tc_table_ops = {
+	.init = NULL,
+	.cu = p4tc_table_cu,
+	.fill_nlmsg = p4tc_table_fill_nlmsg,
+	.gd = p4tc_table_gd,
+	.put = p4tc_table_put,
+	.dump = p4tc_table_dump,
+	.dump_1 = p4tc_table_dump_1,
+};
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index 329ec7bc9..2fc4a0a54 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -43,6 +43,7 @@ static bool obj_is_valid(u32 obj)
 	switch (obj) {
 	case P4TC_OBJ_PIPELINE:
 	case P4TC_OBJ_ACT:
+	case P4TC_OBJ_TABLE:
 		return true;
 	default:
 		return false;
@@ -52,6 +53,7 @@ static bool obj_is_valid(u32 obj)
 static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX + 1] = {
 	[P4TC_OBJ_PIPELINE] = &p4tc_pipeline_ops,
 	[P4TC_OBJ_ACT] = &p4tc_act_ops,
+	[P4TC_OBJ_TABLE] = &p4tc_table_ops,
 };
 
 int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
-- 
2.34.1


