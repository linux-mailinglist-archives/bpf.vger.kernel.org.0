Return-Path: <bpf+bounces-20036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13853837344
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 20:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96849B259BA
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240547F59;
	Mon, 22 Jan 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bLyoTJzQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DBF46547
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952911; cv=none; b=npRLZQVaWcemNx52/yyTu1/1GEpPzsD6Z58rVQDrXurpnbTsimTZGl+5RtJGaoc3tcUrzAoDCr3BjGMd3RuVM8oUf+35IUOW7tAkzmf4r3BVEIeZMFcEQTE/fNzv5HB6901hHKyajrF16JkvPl2I5RnvdaYwJnj4IJxhMgyEIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952911; c=relaxed/simple;
	bh=nfsvZwMI7Ia+2FT7r4FeHm3+HZChen1S9Ww0o+V/vGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k624krCabCfGNX7lglA+HEAtpJmPie2oEYqoEC4qyohVDLkVbtilR3nR+TG4g3g/JYFHel2a7Fg0zYuqAFi1LuJi8AD31gvkPFPmghsSbkDSe9cR5QLQceCnHSdkhRW1FKExYpRBPvVu7p/Gk8mE6pHn2T+F6w6iMbZfs3wtuSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=bLyoTJzQ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ebca94cf74so33226627b3.0
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 11:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705952906; x=1706557706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NndPnX2y1MQ/eNVbu5tetvkKDbD67qOsPU1riiFo9ho=;
        b=bLyoTJzQw2Ij2VJKTtJRdciQ/1BnqYkI4El5/F1CtkNiLscz9LEGfPGnZc1gZID+yO
         vE8dK248taH3v9aV/Mskttf+xsZgp/QQSUU7RVxCdx8IOU0KaVXqwj8bBfkwfHEsfPCH
         FQ4x07GnLu6eiiRVcQc2sX5hiEmNdLPKYMrQzUPLn7TZukSC6cEr90GRp9yzb14FFTOV
         yntZSgm5Nvx6Kd4Qu1IgE0IfCo+Js0owdApakqF7GtJ39TbXejMCayNBJs2kYMFqEShw
         HlaSqLtqZnW1gsAH4woQhDFYiJCCybzxIgE/BaJyYQvjPKh//MNLe3OS9zj8fFqcgi8S
         vqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952906; x=1706557706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NndPnX2y1MQ/eNVbu5tetvkKDbD67qOsPU1riiFo9ho=;
        b=Z2PjexeQHI2xqcYhgoUWLMURjmiHI6RHGKdmxiY16p6w5B2xaGRxdWh9gS+wu9qOLx
         4FytNVgB8RqMkrkShol6LMf3Z/0ZeS1CJbHTX9kIf0tLHI4JuerxZc8sQib0bbUiQxPY
         +vbfLOd0sgXzaLktb/5cSLzbtsG4Gu/P8nR9LpdmFhVQq+OiHTdqPuFTO9Zgf4xg49lV
         NBLb8Bsp9Fxs5Bl60js7bzgb1ktAOsyU3w1IBd060JpUEVvO1cZ8LHKNZ0B106btOyCf
         GXrP4TIASu78eOlxkcEx1e8P568u8BIk9dzrnmFNAVSatVuLM+/eEraCVQWiNFVoJN8H
         PxDA==
X-Gm-Message-State: AOJu0Yw17EQ5aYzoU080UGTjoa1hFuOT7IzlBq9bhGEKkvRFdawem0gw
	8DWPBRW3aa1eYLpOzAQ0Xot+biwFjcIFPmFO53dTQtT1W5eNnnacPvWVvtisgQ==
X-Google-Smtp-Source: AGHT+IGnC+lE26aF2woLsEe+eM+xPLhWFrJgqQMyXfCwAqTMT9uLMU58vRk7v+Wqdr+9iKvAokTeMQ==
X-Received: by 2002:a25:c7c9:0:b0:dbd:5a5e:b1cb with SMTP id w192-20020a25c7c9000000b00dbd5a5eb1cbmr2230420ybe.89.1705952906062;
        Mon, 22 Jan 2024 11:48:26 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id pf9-20020a056214498900b006818be28820sm1288601qvb.24.2024.01.22.11.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:48:24 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
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
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH v10 net-next 12/15] p4tc: add runtime table entry create and update
Date: Mon, 22 Jan 2024 14:47:58 -0500
Message-Id: <20240122194801.152658-13-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122194801.152658-1-jhs@mojatatu.com>
References: <20240122194801.152658-1-jhs@mojatatu.com>
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

This commit allows users to create and update table _entries_
(templates were described in earlier patch). We'll add get, delete and
dump in the next commit

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

__Table Attributes__

Just for context, these are the table attributes (presented in the table
template commit):

- Timer profiles: The timer profiles for the table entries belonging to the
  table. These profiles contain the supported aging values for the table.
  There are currently 4 different built-in profiles ID0=30s(default),
  ID1=60s, ID2=120s and ID3=180s.
  The user can override the defaults by specifying the number of profiles per
  table. In that case, the kernel will generate the specified number of
  profiles with their aging values abiding by the following rule:
    - Profile ID 0 - 30000ms
    - Profile ID(n) - Profile ID(n - 1) + 30000ms
  So, for example, if the user specified num_timer_profiles as 5, the
  profile IDs and aging values would be the following:
    - Profile ID 0 - 30000ms (default profile)
    - Profile ID 1 - 60000ms
    - Profile ID 2 - 90000ms
    - Profile ID 3 - 120000ms
    - Profile ID 4 - 150000ms
  The values of the different profiles could be changed at runtime.
  The default profile is used if the user specifies an out of range value.

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
  Depending on the programmed timer profile (see above), an entry gets a
  timeout. The timer attribute specifies the behavior of a table entry
  expiration.
  The timer is refreshed every time there's a hit. After an idle period
  the P4 program can define using this attribute, whether it wants to have
  an event generated to user space (and have user space delete the entry), or
  whether it wants the kernel to delete it and send the event to announce
  the deletion. The default in P4TC is to both delete and generate an event.

- per entry "static" vs "dynamic" entry. By default all entries created
  from the control plane are "static" unless otherwise specified. All
  entries added from datapath are "dynamic" unless otherwise specified.
  "Dynamic" entries are subject to deletion when idle (subject to the rules
  specified in "Timers" above).

__Table Entry Permissions__

Whereas templates can define the default permissions for tables, runtime has
ability to define table entry permissions as they are added.

To reiterate there are two types of permissions:
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
the permissions would be set to be: -R------R--X-- by the template.

In such a case, typically the P4 program will have some entries defined
(see the famous P4 calculate example). The "initial entries" specified in
the P4 program will have to be added by the template (as generated by the
compiler), as such:

tc p4template create table/aP4proggie/cb/tname \
  entry srcAddr 10.10.10.10/24 dstAddr 1.1.1.0/24 prio 17

This table cannot be updated at runtime. Any attempt to add an entry of a
table which is read-only at runtime will get a "permission denied" response
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

When entries are created without specifying permissions they inherit the
table permissions set by the template.
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
 include/net/p4tc.h                |  121 +-
 include/uapi/linux/p4tc.h         |   73 +-
 include/uapi/linux/rtnetlink.h    |    9 +
 net/sched/p4tc/Makefile           |    3 +-
 net/sched/p4tc/p4tc_runtime_api.c |   82 ++
 net/sched/p4tc/p4tc_table.c       |  100 +-
 net/sched/p4tc/p4tc_tbl_entry.c   | 1805 +++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c    |    4 +-
 security/selinux/nlmsgtab.c       |    6 +-
 9 files changed, 2186 insertions(+), 17 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_runtime_api.c
 create mode 100644 net/sched/p4tc/p4tc_tbl_entry.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 51ac3a38f..e0b1578c6 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -124,6 +124,11 @@ static inline bool p4tc_pipeline_get(struct p4tc_pipeline *pipeline)
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
@@ -198,6 +203,8 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 
 #define P4TC_PERMISSIONS_UNINIT (1 << P4TC_PERM_MAX_BIT)
 
+#define P4TC_MAX_PARAM_DATA_SIZE 124
+
 struct p4tc_table_defact {
 	struct tc_action **default_acts;
 	/* Will have two 7 bits blocks containing CRUDXPS (Create, read, update,
@@ -219,11 +226,12 @@ struct p4tc_table {
 	struct p4tc_template_common         common;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
-	struct idr                          tbl_prio_idr;
+	struct ida                          tbl_prio_idr;
 	struct xarray                       tbl_profiles_xa;
 	struct rhltable                     tbl_entries;
 	/* Mutex that protects tbl_profiles_xa */
 	struct mutex                        tbl_profiles_xa_lock;
+	struct p4tc_table_entry             *tbl_entry;
 	struct p4tc_table_defact __rcu      *tbl_default_hitact;
 	struct p4tc_table_defact __rcu      *tbl_default_missact;
 	struct p4tc_table_perm __rcu        *tbl_permissions;
@@ -239,11 +247,14 @@ struct p4tc_table {
 	u32                                 tbl_max_masks;
 	u32                                 tbl_curr_num_masks;
 	atomic_t                            tbl_num_timer_profiles;
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
@@ -316,6 +327,84 @@ extern struct tc_action_ops NoActionOps;
 
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
+	bool                             tmpl_created;
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
@@ -405,6 +494,14 @@ p4tc_table_init_default_acts(struct net *net,
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
@@ -419,10 +516,25 @@ p4tc_table_replace_default_acts(struct p4tc_table *table,
 
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
+p4tc_tmpl_table_entry_cu(struct net *net, struct nlattr *arg,
+			 struct p4tc_pipeline *pipeline,
+			 struct p4tc_table *table,
+			 struct netlink_ext_ack *extack);
+int p4tc_tbl_entry_root(struct net *net, struct sk_buff *skb,
+			struct nlmsghdr *n, int cmd,
+			struct netlink_ext_ack *extack);
+int p4tc_tbl_entry_dumpit(struct net *net, struct sk_buff *skb,
+			  struct netlink_callback *cb,
+			  struct nlattr *arg, char *p_name);
+int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
+			struct p4tc_table_entry *entry, u32 tbl_id);
 
 struct tcf_p4act *
 p4a_runt_prealloc_get_next(struct p4tc_act *act);
@@ -432,6 +544,11 @@ struct p4tc_act_param *
 p4a_runt_parm_init(struct net *net, struct p4tc_act *act,
 		   struct nlattr *nla, struct netlink_ext_ack *extack);
 
+static inline bool p4tc_runtime_msg_is_update(struct nlmsghdr *n)
+{
+	return n->nlmsg_type == RTM_P4TC_UPDATE;
+}
+
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
 #define p4tc_to_act(t) ((struct p4tc_act *)t)
 #define p4tc_to_table(t) ((struct p4tc_table *)t)
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 350bce788..820bd0fc2 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -80,6 +80,9 @@ enum {
 #define p4tc_ctrl_pub_ok(perm)      ((perm) & P4TC_CTRL_PERM_P)
 #define p4tc_ctrl_sub_ok(perm)      ((perm) & P4TC_CTRL_PERM_S)
 
+#define p4tc_ctrl_perm_rm_create(perm) \
+	(((perm) & ~P4TC_CTRL_PERM_C))
+
 #define p4tc_data_create_ok(perm)   ((perm) & P4TC_DATA_PERM_C)
 #define p4tc_data_read_ok(perm)     ((perm) & P4TC_DATA_PERM_R)
 #define p4tc_data_update_ok(perm)   ((perm) & P4TC_DATA_PERM_U)
@@ -88,6 +91,9 @@ enum {
 #define p4tc_data_pub_ok(perm)      ((perm) & P4TC_DATA_PERM_P)
 #define p4tc_data_sub_ok(perm)      ((perm) & P4TC_DATA_PERM_S)
 
+#define p4tc_data_perm_rm_create(perm) \
+	(((perm) & ~P4TC_DATA_PERM_C))
+
 /* Root attributes */
 enum {
 	P4TC_ROOT_UNSPEC,
@@ -109,6 +115,15 @@ enum {
 
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
@@ -201,7 +216,7 @@ enum {
 	P4TC_TABLE_TYPE, /* u8 */
 	P4TC_TABLE_DEFAULT_HIT, /* nested default hit action attributes */
 	P4TC_TABLE_DEFAULT_MISS, /* nested default miss action attributes */
-	P4TC_TABLE_CONST_ENTRY, /* nested const table entry */
+	P4TC_TABLE_ENTRY, /* nested const table entry*/
 	P4TC_TABLE_ACTS_LIST, /* nested table actions list */
 	P4TC_TABLE_NUM_TIMER_PROFILES, /* u32 - number of timer profiles */
 	P4TC_TABLE_TIMER_PROFILES, /* nested timer profiles
@@ -266,6 +281,62 @@ enum {
 
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
+	P4TC_ENTRY_TBLNAME, /* string - mandatory for create */
+	P4TC_ENTRY_KEY_BLOB, /* Key blob - mandatory for create, update, delete,
+			      * and get
+			      */
+	P4TC_ENTRY_MASK_BLOB, /* Mask blob */
+	P4TC_ENTRY_PRIO, /* u32 - mandatory for delete and get for non-exact
+			  * table
+			  */
+	P4TC_ENTRY_ACT, /* nested actions */
+	P4TC_ENTRY_TM, /* entry data path timestamps */
+	P4TC_ENTRY_WHODUNNIT, /* tells who's modifying the entry */
+	P4TC_ENTRY_CREATE_WHODUNNIT, /* tells who created the entry */
+	P4TC_ENTRY_UPDATE_WHODUNNIT, /* tells who updated the entry last */
+	P4TC_ENTRY_DELETE_WHODUNNIT, /* tells who deleted the entry */
+	P4TC_ENTRY_PERMISSIONS, /* entry CRUDXPS permissions */
+	P4TC_ENTRY_TBL_ATTRS, /* nested table attributes */
+	P4TC_ENTRY_TMPL_CREATED, /* u8 tells whether entry was create by
+				  * template
+				  */
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
index 000000000..d80103d36
--- /dev/null
+++ b/net/sched/p4tc/p4tc_runtime_api.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_runtime_api.c P4 TC RUNTIME API
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
+		ret = p4tc_tbl_entry_root(net, skb, n, cmd, extack);
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
+static int __init p4tc_tbl_init(void)
+{
+	rtnl_register(PF_UNSPEC, RTM_P4TC_CREATE, tc_ctl_p4_cu, NULL,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+	rtnl_register(PF_UNSPEC, RTM_P4TC_UPDATE, tc_ctl_p4_cu, NULL,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+
+	return 0;
+}
+
+subsys_initcall(p4tc_tbl_init);
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index 3b329d5ed..a8177465a 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -143,6 +143,7 @@ static const struct nla_policy p4tc_table_policy[P4TC_TABLE_MAX + 1] = {
 	[P4TC_TABLE_ACTS_LIST] = { .type = NLA_NESTED },
 	[P4TC_TABLE_NUM_TIMER_PROFILES] =
 		NLA_POLICY_RANGE(NLA_U32, 1, P4TC_MAX_NUM_TIMER_PROFILES),
+	[P4TC_TABLE_ENTRY] = { .type = NLA_NESTED },
 };
 
 static int _p4tc_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
@@ -266,6 +267,18 @@ static int _p4tc_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
 	}
 	nla_nest_end(skb, nested_tbl_acts);
 
+	if (table->tbl_entry) {
+		struct nlattr *entry_nest;
+
+		entry_nest = nla_nest_start(skb, P4TC_TABLE_ENTRY);
+		if (p4tc_tbl_entry_fill(skb, table, table->tbl_entry,
+					table->tbl_id) < 0)
+			goto out_nlmsg_trim;
+
+		nla_nest_end(skb, entry_nest);
+	}
+	table->tbl_entry = NULL;
+
 	if (nla_put_u32(skb, P4TC_TABLE_KEYSZ, table->tbl_keysz))
 		goto out_nlmsg_trim;
 
@@ -275,6 +288,10 @@ static int _p4tc_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
 	if (nla_put_u32(skb, P4TC_TABLE_MAX_MASKS, table->tbl_max_masks))
 		goto out_nlmsg_trim;
 
+	if (nla_put_u32(skb, P4TC_TABLE_NUM_ENTRIES,
+			atomic_read(&table->tbl_nelems)))
+		goto out_nlmsg_trim;
+
 	tbl_perm = rcu_dereference_rtnl(table->tbl_permissions);
 	if (nla_put_u16(skb, P4TC_TABLE_PERMISSIONS, tbl_perm->permissions))
 		goto out_nlmsg_trim;
@@ -303,14 +320,6 @@ static int p4tc_table_fill_nlmsg(struct net *net, struct sk_buff *skb,
 	return 0;
 }
 
-static void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
-{
-	if (defact) {
-		p4tc_action_destroy(defact->default_acts);
-		kfree(defact);
-	}
-}
-
 static void
 p4tc_table_timer_profile_destroy(struct p4tc_table *table,
 				 struct p4tc_table_timer_profile *table_profile)
@@ -514,8 +523,11 @@ static int _p4tc_table_put(struct net *net, struct nlattr **tb,
 	p4tc_table_acts_list_destroy(&table->tbl_acts_list);
 	p4tc_table_timer_profiles_destroy(table);
 
+	rhltable_free_and_destroy(&table->tbl_entries,
+				  p4tc_table_entry_destroy_hash, table);
+
 	idr_destroy(&table->tbl_masks_idr);
-	idr_destroy(&table->tbl_prio_idr);
+	ida_destroy(&table->tbl_prio_idr);
 
 	perm = rcu_replace_pointer_rtnl(table->tbl_permissions, NULL);
 	kfree_rcu(perm, rcu);
@@ -1047,11 +1059,50 @@ p4tc_table_find_byanyattr(struct p4tc_pipeline *pipeline,
 	return p4tc_table_find_byany(pipeline, tblname, tbl_id, extack);
 }
 
+static bool p4tc_table_entry_create_only(struct nlattr **tb)
+{
+	int i;
+
+	/* Excluding table name on purpose */
+	for (i = P4TC_TABLE_KEYSZ; i < P4TC_TABLE_MAX; i++)
+		if (tb[i] && i != P4TC_TABLE_ENTRY)
+			return false;
+
+	return true;
+}
+
+static struct p4tc_table *
+p4tc_table_entry_create(struct net *net, struct nlattr **tb,
+			u32 tbl_id, struct p4tc_pipeline *pipeline,
+			struct netlink_ext_ack *extack)
+{
+	struct p4tc_table *table;
+
+	table = p4tc_table_find_byanyattr(pipeline, tb[P4TC_TABLE_NAME], tbl_id,
+					  extack);
+	if (IS_ERR(table))
+		return table;
+
+	if (tb[P4TC_TABLE_ENTRY]) {
+		struct p4tc_table_entry *entry;
+
+		entry = p4tc_tmpl_table_entry_cu(net, tb[P4TC_TABLE_ENTRY],
+						 pipeline, table, extack);
+		if (IS_ERR(entry))
+			return (struct p4tc_table *)entry;
+
+		table->tbl_entry = entry;
+	}
+
+	return table;
+}
+
 static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 					    u32 tbl_id,
 					    struct p4tc_pipeline *pipeline,
 					    struct netlink_ext_ack *extack)
 {
+	struct rhashtable_params table_hlt_params = entry_hlt_params;
 	struct p4tc_table_default_act_params def_params = {0};
 	u32 num_profiles = P4TC_DEFAULT_NUM_TIMER_PROFILES;
 	struct p4tc_table_perm *tbl_init_perms = NULL;
@@ -1059,6 +1110,10 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 	char *tblname;
 	int ret;
 
+	if (p4tc_table_entry_create_only(tb))
+		return p4tc_table_entry_create(net, tb, tbl_id, pipeline,
+					       extack);
+
 	if (pipeline->curr_tables == pipeline->num_tables) {
 		NL_SET_ERR_MSG(extack,
 			       "Table range exceeded max allowed value");
@@ -1222,15 +1277,30 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 		goto defaultacts_destroy;
 
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
+		goto profiles_destroy;
+	}
+
 	pipeline->curr_tables += 1;
 
 	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
+	atomic_set(&table->tbl_nelems, 0);
 
 	return table;
 
+profiles_destroy:
+	p4tc_table_timer_profiles_destroy(table);
+
 defaultacts_destroy:
 	p4tc_table_defact_destroy(def_params.default_hitact);
 	p4tc_table_defact_destroy(def_params.default_missact);
@@ -1264,6 +1334,13 @@ static struct p4tc_table *p4tc_table_update(struct net *net, struct nlattr **tb,
 	u8 tbl_type;
 	int ret = 0;
 
+	if (tb[P4TC_TABLE_ENTRY]) {
+		NL_SET_ERR_MSG(extack,
+			       "Entry update not supported from template");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	table = p4tc_table_find_byanyattr(pipeline, tb[P4TC_TABLE_NAME], tbl_id,
 					  extack);
 	if (IS_ERR(table))
@@ -1326,6 +1403,9 @@ static struct p4tc_table *p4tc_table_update(struct net *net, struct nlattr **tb,
 		}
 	}
 
+	if (tb[P4TC_TABLE_TYPE])
+		tbl_type = nla_get_u8(tb[P4TC_TABLE_TYPE]);
+
 	p4tc_table_replace_default_acts(table, &def_params, false);
 	p4tc_table_replace_permissions(table, tbl_permissions, false);
 
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
new file mode 100644
index 000000000..1f72fed24
--- /dev/null
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -0,0 +1,1805 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_tbl_entry.c P4 TC TABLE ENTRY
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
+static bool p4tc_tbl_entry_put(struct p4tc_table_entry_value *value)
+{
+	return refcount_dec_if_one(&value->entries_ref);
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
+		if (nla_put(skb, P4TC_ENTRY_MASK_BLOB, key_sz_bytes,
+			    mask_value))
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
+			struct p4tc_table_entry *entry, u32 tbl_id)
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
+	p4tc_table_entry_tm_dump(&dtm, tm);
+	if (nla_put_64bit(skb, P4TC_ENTRY_TM, sizeof(dtm), &dtm,
+			  P4TC_ENTRY_PAD))
+		goto out_nlmsg_trim;
+
+	if (value->tmpl_created) {
+		if (nla_put_u8(skb, P4TC_ENTRY_TMPL_CREATED, 1))
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
+			if (memcmp(curr_mask_value, mask_value,
+				   mask_sz_bytes) == 0)
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
+				/* shift masks to the right (will keep
+				 * invariant)
+				 */
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
+		nmask = kzalloc(struct_size(mask_found, fa_value,
+					    mask_sz_bytes), GFP_ATOMIC);
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
+	if (p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id) < 0)
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
+	return ida_alloc_min(&table->tbl_prio_idr, 1, GFP_ATOMIC);
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
+struct p4tc_table_get_state {
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+};
+
+static void
+p4tc_table_entry_put_table(struct p4tc_table_get_state *table_get_state)
+{
+	p4tc_table_put_ref(table_get_state->table);
+	p4tc_pipeline_put_ref(table_get_state->pipeline);
+}
+
+static int
+p4tc_table_entry_get_table(struct net *net, int cmd,
+			   struct p4tc_table_get_state *table_get_state,
+			   struct nlattr **tb,
+			   struct p4tc_path_nlattrs *nl_path_attrs,
+			   struct netlink_ext_ack *extack)
+{
+	/* The following can only race with user driven events
+	 * Netns is guaranteed to be alive
+	 */
+	struct p4tc_pipeline *pipeline;
+	u32 *ids = nl_path_attrs->ids;
+	struct p4tc_table *table;
+	u32 pipeid, tbl_id;
+	char *tblname;
+	int ret;
+
+	rcu_read_lock();
+
+	pipeid = ids[P4TC_PID_IDX];
+
+	pipeline = p4tc_pipeline_find_get(net, nl_path_attrs->pname, pipeid,
+					  extack);
+	if (IS_ERR(pipeline)) {
+		ret = PTR_ERR(pipeline);
+		goto out;
+	}
+
+	if (cmd != RTM_P4TC_GET && !p4tc_pipeline_sealed(pipeline)) {
+		switch (cmd) {
+		case RTM_P4TC_CREATE:
+			NL_SET_ERR_MSG(extack,
+				       "Pipeline must be sealed for runtime create");
+			break;
+		case RTM_P4TC_UPDATE:
+			NL_SET_ERR_MSG(extack,
+				       "Pipeline must be sealed for runtime update");
+			break;
+		case RTM_P4TC_DEL:
+			NL_SET_ERR_MSG(extack,
+				       "Pipeline must be sealed for runtime delete");
+			break;
+		default:
+			/* Will never happen */
+			break;
+		}
+		ret = -EINVAL;
+		goto put;
+	}
+
+	tbl_id = ids[P4TC_TBLID_IDX];
+	tblname = tb[P4TC_ENTRY_TBLNAME] ?
+		nla_data(tb[P4TC_ENTRY_TBLNAME]) : NULL;
+
+	table = p4tc_table_find_get(pipeline, tblname, tbl_id, extack);
+	if (IS_ERR(table)) {
+		ret = PTR_ERR(table);
+		goto put;
+	}
+
+	rcu_read_unlock();
+
+	table_get_state->pipeline = pipeline;
+	table_get_state->table = table;
+
+	return 0;
+
+put:
+	p4tc_pipeline_put_ref(pipeline);
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
+			NL_SET_ERR_MSG(extack, "Must specify mask blob");
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
+static bool p4tc_table_check_no_act(struct p4tc_table *table)
+{
+	struct p4tc_table_act *table_act;
+
+	if (list_empty(&table->tbl_acts_list))
+		return true;
+
+	list_for_each_entry(table_act, &table->tbl_acts_list, node) {
+		if (strcmp(table_act->ops->kind, "NoAction") == 0)
+			return true;
+	}
+
+	return false;
+}
+
+static struct nla_policy
+p4tc_table_attrs_policy[P4TC_ENTRY_TBL_ATTRS_MAX + 1] = {
+	[P4TC_ENTRY_TBL_ATTRS_DEFAULT_HIT] = { .type = NLA_NESTED },
+	[P4TC_ENTRY_TBL_ATTRS_DEFAULT_MISS] = { .type = NLA_NESTED },
+	[P4TC_ENTRY_TBL_ATTRS_PERMISSIONS] =
+		NLA_POLICY_MAX(NLA_U16, P4TC_MAX_PERMISSION),
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
+	ret = p4tc_table_entry_extract_key(table, tb, &entry->key, mask,
+					   extack);
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
+		if (p4tc_ctrl_create_ok(nlperm) ||
+		    p4tc_data_create_ok(nlperm)) {
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
+	} else {
+		if (!p4tc_table_check_no_act(table)) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Entry must have action associated with it");
+			ret = -EPERM;
+			goto free_entry;
+		}
+	}
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
+	int cmd = replace ? RTM_P4TC_UPDATE : RTM_P4TC_CREATE;
+	struct p4tc_table_get_state table_get_state = { NULL};
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
+	ret = p4tc_table_entry_get_table(net, cmd, &table_get_state, tb,
+					 nl_path_attrs, extack);
+	if (ret < 0)
+		return ret;
+
+	pipeline = table_get_state.pipeline;
+	table = table_get_state.table;
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
+			if (p4tc_tbl_entry_fill(skb, table, entry,
+						table->tbl_id) <= 0)
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
+	p4tc_table_entry_put_table(&table_get_state);
+	return ret;
+}
+
+struct p4tc_table_entry *
+p4tc_tmpl_table_entry_cu(struct net *net, struct nlattr *arg,
+			 struct p4tc_pipeline *pipeline,
+			 struct p4tc_table *table,
+			 struct netlink_ext_ack *extack)
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
+	value->tmpl_created = true;
+
+	return entry;
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
+static int __p4tc_tbl_entry_root(struct net *net, struct sk_buff *skb,
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
+		if (cmd == RTM_P4TC_CREATE || cmd == RTM_P4TC_UPDATE) {
+			u8 cu_flags;
+
+			if (cmd == RTM_P4TC_UPDATE)
+				cu_flags = P4TC_TBL_ENTRY_CU_FLAG_UPDATE;
+			else
+				if (n->nlmsg_flags & NLM_F_REPLACE)
+					cu_flags = P4TC_TBL_ENTRY_CU_FLAG_SET;
+				else
+					cu_flags =
+						P4TC_TBL_ENTRY_CU_FLAG_CREATE;
+
+			ret = p4tc_tbl_entry_cu_1(net, nskb, cu_flags,
+						  &permissions,
+						  p4tca[i], &nl_path_attrs,
+						  extack);
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
+	if (num_pub_permission) {
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
+static int __p4tc_tbl_entry_root_fast(struct net *net, struct nlmsghdr *n,
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
+					cu_flags =
+						P4TC_TBL_ENTRY_CU_FLAG_CREATE;
+
+			ret = p4tc_tbl_entry_cu_1(net, NULL, cu_flags, NULL,
+						  p4tca[i], &nl_path_attrs,
+						  extack);
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
+int p4tc_tbl_entry_root(struct net *net, struct sk_buff *skb,
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
+		ret = __p4tc_tbl_entry_root(net, skb, n, cmd, p_name, p4tca,
+					    extack);
+	else
+		ret = __p4tc_tbl_entry_root_fast(net, n, cmd, p_name, p4tca,
+						 extack);
+	return ret;
+}
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index 1e79c2bde..17232060a 100644
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


