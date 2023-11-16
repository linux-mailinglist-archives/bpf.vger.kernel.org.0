Return-Path: <bpf+bounces-15192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD507EE3BE
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC69BB20FF5
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2133BB32;
	Thu, 16 Nov 2023 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vtLPuLMN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F9CD52
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 07:00:25 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b566ee5f1dso516594b6e.0
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 07:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146825; x=1700751625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oox/8E0KFofAB3XeC9xGDzpSS3vf74WkFrZi7HqF1I0=;
        b=vtLPuLMNM6JZLanOmHn86xT62Ork/XmCoJlQoH+SZPkvC7BiE5CWygQ1oDdiMOVO+o
         6RwzZMsg/IHk52qZuJ/6o3LN8fWw5KfkJ/Mieuppwp/LeQ6rOxMzJp0HqrUP8wNkvqDE
         by1wkXqXEHl7GIk4DU0JKDfkv8t3y8uRa5yWrjIHyMeimAzHAY8wg4LfbEoFfTJkjutI
         8s+46N+PxDdLG1FaOFsYW9iE7IqxKWdX6WH6eHCc8VxjwZIUE0uAYaXT4wOh+W7wygKk
         hpfhZUKI8aTLOwIHD1sv1pxp+v3u2niZwiDmAIUtnumUa72heJhum8nFo08fvSXEedXg
         y4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146825; x=1700751625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oox/8E0KFofAB3XeC9xGDzpSS3vf74WkFrZi7HqF1I0=;
        b=i4pP2COu4YS9sPrXzTpzmPePldyJOuuVnDDRFmPr7iitD5MrJVzXSNoCV0l7VzG3mX
         kikmS2Th8IbU3D1XhLLhSwUHuKhhIz2WTD9z/weI1h6yyynJlMJMr/FQC9FDarxgX4y+
         dqNtuA3BlW319Z6UBoln8UE22oOG9kXZpMA8A2RpBKgxWZEGNLqiONEu+bZkqqf6Hg9E
         n2O/84MdV+5MFsXt5tXYxdqqS9DKU+yZLKoeVgo4wqNXEKQCNGD97lRseaoxUSY4HBS/
         XjMIKe7vuy9x1bcwHbbudMjgc7ye794oJohTxT0seEoaHivBBr9mX47mDPjXdlW2140t
         yhNA==
X-Gm-Message-State: AOJu0YwMLgRdALcaz+kFP9IMV9tDwc9dW/YQHK9Wh+rzXOYk6rIB0wsX
	Y9nOaFcBeBZc7SOXDjPMJBdMPA==
X-Google-Smtp-Source: AGHT+IFCwBpVfyRBnRt8ZX4cOedr73tHlZ9B9K9H1QDda0Te/0Exs4cBQvIbMSYYu1NbhwKrVQaTQA==
X-Received: by 2002:a05:6808:2396:b0:3b2:f37c:a6ac with SMTP id bp22-20020a056808239600b003b2f37ca6acmr19532986oib.59.1700146823708;
        Thu, 16 Nov 2023 07:00:23 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.07.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 07:00:22 -0800 (PST)
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
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH net-next v8 15/15] p4tc: Add P4 extern interface
Date: Thu, 16 Nov 2023 09:59:48 -0500
Message-Id: <20231116145948.203001-16-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116145948.203001-1-jhs@mojatatu.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

P4 externs are an abstraction in the language to call for extending
language functionality. For example, the function that sends a packet to a
specific port (send_to_port) in P4 PNA is an extern.

Externs can be seen as classes, which have constructors and methods.
Take, for example, the Register extern definition:

extern Register<T> {
    Register(@tc_numel bit<32> size);
    @tc_md_read T read(@tc_key bit<32> index);
    @tc_md_write void write(@tc_key bit<32> index, @tc_data T value);
}

struct tc_ControlPath_Register<T> {
    @tc_key bit<32> index;
    @tc_data T value;
}

Which can then be instantiated within a P4 program as:
Register<bit<32>>(128) reg1;
Register<bit<16>>(1024) reg2;

Will be abstracted into the template by the P4C compiler for "reg1" as
follows:

tc p4template create extern/root/register extid 10 numinstances 2
tc p4template create extern_inst/aP4Proggie/register/reg1 instid 1 \
control_path tc_key index type bit32 tc_data value type bit32 \
numelemens 128 default_value 22

=========================EXTERN RUNTIME COMMANDS=========================

Once we seal the pipeline, the register values will be assigned to the
default value specified on the template as "default_value". After sealing,
we can update the runtime instance element. For example to update
reg1[2] with the value 33, we will do the following:

tc p4ctrl update aP4proggie/extern/register/reg1 tc_key index 2 \
tc_data value 33

We can also get its value:

tc p4ctrl get aP4proggie/extern/register/reg1 tc_key index 2

Which will yield the following output:

total exts 0
        extern order 1:
          tc_key index id 1 type bit32 value: 1
          tc_data value id 2 type bit32 value: 33

We can also dump all of the elements in this register:

tc p4ctrl get aP4proggie/extern/register/reg1

Note that the only valid runtime operations are get and update.

=========================EXTERN P4 Runtime =========================

The generated ebpf code invokes the externs in the P4TC domain
using the md_read or md_write kfuncs, for example:
if the P4 program had this invocation:

tmp1 = reg1.read(index1);

Then equivalent generated ebpf code is as follows:

param.pipe_id = aP4Proggie_ID;
param.ext_id = EXTERN_REGISTER;
param.inst_id = EXTERN_REGISTER_INSTANCE_ID1;
param.index = index1;
param.param_id = EXTERN_REGISTER_PARAM_ID;
bpf_p4tc_extern_md_read(skb, &res, &param);
tmp1 = (u32 *)res.params;

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h                |  161 +++
 include/net/p4tc_ext_api.h        |  199 +++
 include/uapi/linux/p4tc.h         |   61 +
 include/uapi/linux/p4tc_ext.h     |   36 +
 net/sched/p4tc/Makefile           |    2 +-
 net/sched/p4tc/p4tc_bpf.c         |   79 +-
 net/sched/p4tc/p4tc_ext.c         | 2204 ++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c    |   34 +-
 net/sched/p4tc/p4tc_runtime_api.c |   10 +-
 net/sched/p4tc/p4tc_table.c       |   57 +-
 net/sched/p4tc/p4tc_tbl_entry.c   |   25 +-
 net/sched/p4tc/p4tc_tmpl_api.c    |    4 +
 net/sched/p4tc/p4tc_tmpl_ext.c    | 2221 +++++++++++++++++++++++++++++
 13 files changed, 5083 insertions(+), 10 deletions(-)
 create mode 100644 include/net/p4tc_ext_api.h
 create mode 100644 include/uapi/linux/p4tc_ext.h
 create mode 100644 net/sched/p4tc/p4tc_ext.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_ext.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index e25eaa4ac..b6b825c64 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -11,6 +11,7 @@
 #include <linux/rhashtable-types.h>
 #include <net/tc_act/p4tc.h>
 #include <net/p4tc_types.h>
+#include <linux/bpf.h>
 
 #define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
 #define P4TC_DEFAULT_MAX_RULES 1
@@ -21,6 +22,10 @@
 #define P4TC_DEFAULT_TMASKS 8
 #define P4TC_MAX_T_AGING 864000000
 #define P4TC_DEFAULT_T_AGING 30000
+#define P4TC_DEFAULT_NUM_EXT_INSTS 1
+#define P4TC_MAX_NUM_EXT_INSTS 1024
+#define P4TC_DEFAULT_NUM_EXT_INST_ELEMS 1
+#define P4TC_MAX_NUM_EXT_INST_ELEMS 1024
 
 #define P4TC_MAX_PERMISSION (GENMASK(P4TC_PERM_MAX_BIT, 0))
 
@@ -30,6 +35,8 @@
 #define P4TC_TBLID_IDX 1
 #define P4TC_AID_IDX 1
 #define P4TC_PARSEID_IDX 1
+#define P4TC_TMPL_EXT_IDX 1
+#define P4TC_TMPL_EXT_INST_IDX 2
 
 struct p4tc_dump_ctx {
 	u32 ids[P4TC_PATH_MAX];
@@ -79,9 +86,14 @@ struct p4tc_pipeline {
 	struct p4tc_template_common common;
 	struct idr                  p_act_idr;
 	struct idr                  p_tbl_idr;
+	/* IDR where the externs are stored globally in the root pipeline */
+	struct idr                  p_ext_idr;
+	/* IDR where the per user pipeline data related to externs is stored */
+	struct idr                  user_ext_idr;
 	struct rcu_head             rcu;
 	struct net                  *net;
 	u32                         num_created_acts;
+	u32                         num_created_ext_elems;
 	/* Accounts for how many entities are referencing this pipeline.
 	 * As for now only P4 filters can refer to pipelines.
 	 */
@@ -207,6 +219,27 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 
 #define P4TC_MAX_PARAM_DATA_SIZE 124
 
+#define P4TC_EXT_FLAGS_UNSPEC 0x0
+#define P4TC_EXT_FLAGS_CONTROL_READ 0x1
+#define P4TC_EXT_FLAGS_CONTROL_WRITE 0x2
+
+struct p4tc_ext_bpf_params {
+	u32 pipe_id;
+	u32 ext_id;
+	u32 inst_id;
+	u32 index;
+	u32 param_id;
+	u32 flags;
+	u8  in_params[128]; /* extern specific params if any */
+};
+
+struct p4tc_ext_bpf_res {
+	u32 ext_id;
+	u32 index;
+	u32 verdict;
+	u8 out_params[128]; /* specific values if any */
+};
+
 struct p4tc_table_defact {
 	struct tc_action **default_acts;
 	/* Will have two 7 bits blocks containing CRUDXPS (Create, read, update,
@@ -237,6 +270,7 @@ struct p4tc_table {
 	struct p4tc_table_perm __rcu        *tbl_permissions;
 	struct p4tc_table_entry_mask __rcu  **tbl_masks_array;
 	unsigned long __rcu                 *tbl_free_masks_bitmap;
+	struct p4tc_extern_inst             *tbl_counter;
 	u64                                 tbl_aging;
 	/* Locks the available masks IDR which will be used when adding and
 	 * deleting table entries.
@@ -352,6 +386,7 @@ struct p4tc_table_entry_key {
 struct p4tc_table_entry_value {
 	u32                              prio;
 	int                              num_acts;
+	struct p4tc_extern_common        *counter;
 	struct tc_action                 **acts;
 	/* Accounts for how many entities are referencing, eg: Data path,
 	 * one or more control path and timer.
@@ -576,8 +611,134 @@ static inline bool p4tc_runtime_msg_is_update(struct nlmsghdr *n)
 	return n->nlmsg_type == RTM_P4TC_UPDATE;
 }
 
+struct p4tc_user_pipeline_extern {
+	struct idr		e_inst_idr;
+	struct p4tc_tmpl_extern	*tmpl_ext;
+	void (*free)(struct p4tc_user_pipeline_extern *pipe_ext,
+		     struct idr *tmpl_exts_idr);
+	u32			ext_id;
+	/* Accounts for how many instances refer to this extern. */
+	refcount_t		ext_ref;
+	/* Counts how many instances this extern has */
+	atomic_t                curr_insts_num;
+	u32                     PAD0;
+	char			ext_name[EXTERNNAMSIZ];
+};
+
+struct p4tc_tmpl_extern {
+	struct p4tc_template_common  common;
+	struct idr                   params_idr;
+	const struct p4tc_extern_ops *ops;
+	u32                          ext_id;
+	u32                          num_params;
+	u32                          max_num_insts;
+	/* Accounts for how many pipelines refer to this extern. */
+	refcount_t                   tmpl_ref;
+	char                         mod_name[MODULE_NAME_LEN];
+	bool                         has_exec_method;
+};
+
+struct p4tc_extern_inst {
+	struct p4tc_template_common      common;
+	struct p4tc_extern_params        *params;
+	const struct p4tc_extern_ops     *ops;
+	struct idr                       control_elems_idr;
+	struct list_head                 unused_elems;
+	/* Locks the available externs list.
+	 * Which will be used by table entries that reference externs (refer to
+	 * direct counters and meters in P4).
+	 * Note that table entries can be created, update or deleted by both
+	 * control and data path. So this list may be modified from both
+	 * contexts.
+	 */
+	spinlock_t                       available_list_lock;
+	/* Accounts for how many elements refer to this extern. */
+	refcount_t                       inst_ref;
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	char                             *ext_name;
+	/* Counts how many elements this extern has */
+	atomic_t                         curr_num_elems;
+	u32                              max_num_elems;
+	u32                              ext_id;
+	u32                              ext_inst_id;
+	u32                              num_control_params;
+	struct p4tc_extern_params        *constr_params;
+	u32				 flags;
+	bool                             tbl_bindable;
+	bool				 is_scalar;
+};
+
+int p4tc_pipeline_create_extern_net(struct p4tc_tmpl_extern *tmpl_ext);
+int p4tc_pipeline_del_extern_net(struct p4tc_tmpl_extern *tmpl_ext);
+struct p4tc_extern_inst *
+p4tc_ext_inst_find_bynames(struct net *net, struct p4tc_pipeline *pipeline,
+			   const char *extname, const char *instname,
+			   struct netlink_ext_ack *extack);
+struct p4tc_user_pipeline_extern *
+p4tc_pipe_ext_find_bynames(struct net *net, struct p4tc_pipeline *pipeline,
+			   const char *extname, struct netlink_ext_ack *extack);
+struct p4tc_extern_inst *
+p4tc_ext_inst_table_bind(struct p4tc_pipeline *pipeline,
+			 struct p4tc_user_pipeline_extern **pipe_ext,
+			 const char *ext_inst_path,
+			 struct netlink_ext_ack *extack);
+void
+p4tc_ext_inst_table_unbind(struct p4tc_table *table,
+			   struct p4tc_user_pipeline_extern *pipe_ext,
+			   struct p4tc_extern_inst *inst);
+struct p4tc_extern_inst *
+p4tc_ext_inst_get_byids(struct net *net, struct p4tc_pipeline **pipeline,
+			struct p4tc_ext_bpf_params *params);
+struct p4tc_extern_inst *
+p4tc_ext_find_byids(struct p4tc_pipeline *pipeline,
+		    const u32 ext_id, const u32 inst_id);
+struct p4tc_extern_inst *
+p4tc_ext_inst_alloc(const struct p4tc_extern_ops *ops, const u32 max_num_elems,
+		    bool tbl_bindable, char *ext_name);
+
+int __bpf_p4tc_extern_md_write(struct net *net,
+			       struct p4tc_ext_bpf_params *params);
+int __bpf_p4tc_extern_md_read(struct net *net,
+			      struct p4tc_ext_bpf_res *res,
+			      struct p4tc_ext_bpf_params *params);
+struct p4tc_extern_params *
+p4tc_ext_params_copy(struct p4tc_extern_params *params_orig);
+
+extern const struct p4tc_template_ops p4tc_tmpl_ext_ops;
+extern const struct p4tc_template_ops p4tc_ext_inst_ops;
+
+struct p4tc_extern_param {
+	struct p4tc_extern_param_ops    *ops;
+	struct p4tc_extern_param_ops    *mod_ops;
+	void				*value;
+	struct p4tc_type		*type;
+	struct p4tc_type_mask_shift	*mask_shift;
+	u32				id;
+	u32				index;
+	u32                             bitsz;
+	u32				flags;
+	char				name[EXTPARAMNAMSIZ];
+	struct rcu_head			rcu;
+};
+
+struct p4tc_extern_param_ops {
+	int (*init_value)(struct net *net,
+			  struct p4tc_extern_param *nparam, void *value,
+			  struct netlink_ext_ack *extack);
+	/* Only for bit<X> parameter types */
+	void (*default_value)(struct p4tc_extern_param *nparam);
+	int (*dump_value)(struct sk_buff *skb, struct p4tc_extern_param_ops *op,
+			  struct p4tc_extern_param *param);
+	void (*free)(struct p4tc_extern_param *param);
+	u32 len;
+	u32 alloc_len;
+};
+
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
 #define to_act(t) ((struct p4tc_act *)t)
 #define to_table(t) ((struct p4tc_table *)t)
 
+#define to_extern(t) ((struct p4tc_tmpl_extern *)t)
+#define to_extern_inst(t) ((struct p4tc_extern_inst *)t)
+
 #endif
diff --git a/include/net/p4tc_ext_api.h b/include/net/p4tc_ext_api.h
new file mode 100644
index 000000000..fcc16d252
--- /dev/null
+++ b/include/net/p4tc_ext_api.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_P4TC_EXT_API_H
+#define __NET_P4TC_EXT_API_H
+
+/*
+ * Public extern P4TC_EXT API
+ */
+
+#include <uapi/linux/p4tc_ext.h>
+#include <linux/refcount.h>
+#include <net/flow_offload.h>
+#include <net/sch_generic.h>
+#include <net/pkt_sched.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
+#include <net/p4tc.h>
+
+struct p4tc_extern_ops;
+
+struct p4tc_extern_params {
+	struct idr params_idr;
+	rwlock_t params_lock;
+	u32 num_params;
+	u32 PAD0;
+};
+
+struct p4tc_extern_common {
+	struct list_head             node;
+	struct p4tc_extern_params    *params;
+	const struct p4tc_extern_ops *ops;
+	struct p4tc_extern_inst      *inst;
+	u32                          p4tc_ext_flags;
+	u32                          p4tc_ext_key;
+	refcount_t                   p4tc_ext_refcnt;
+	u32                          PAD0;
+};
+
+struct p4tc_extern {
+	struct p4tc_extern_common       common;
+	struct idr			*elems_idr;
+	struct rcu_head			rcu;
+	size_t				attrs_size;
+	/* Extern element lock */
+	spinlock_t			p4tc_ext_lock;
+};
+
+/* Reserve 16 bits for user-space. See P4TC_EXT_FLAGS_NO_PERCPU_STATS. */
+#define P4TC_EXT_FLAGS_USER_BITS 16
+#define P4TC_EXT_FLAGS_USER_MASK 0xffff
+
+struct p4tc_extern_ops {
+	struct list_head head;
+	size_t size;
+	size_t elem_size;
+	struct module *owner;
+	struct p4tc_tmpl_extern *tmpl_ext;
+	int (*exec)(struct p4tc_extern_common *common, void *priv);
+	int (*construct)(struct p4tc_extern_inst **common,
+			 struct p4tc_extern_params *params,
+			 struct p4tc_extern_params *constr_params,
+			 u32 max_num_elems, bool tbl_bindable,
+			 struct netlink_ext_ack *extack);
+	void (*deconstruct)(struct p4tc_extern_inst *common);
+	int (*dump)(struct sk_buff *skb,
+		    struct p4tc_extern_inst *common,
+		    struct netlink_callback *cb);
+	int (*rctrl)(int cmd, struct p4tc_extern_inst *inst,
+		     struct p4tc_extern_common **e,
+		     struct p4tc_extern_params *params,
+		     void *key_u32, struct netlink_ext_ack *extack);
+	u32 id; /* identifier should match kind */
+	u32 PAD0;
+	char kind[P4TC_EXT_NAMSIZ];
+};
+
+#define P4TC_EXT_P_CREATED 1
+#define P4TC_EXT_P_DELETED 1
+
+int p4tc_register_extern(struct p4tc_extern_ops *ext);
+int p4tc_unregister_extern(struct p4tc_extern_ops *ext);
+
+int p4tc_ctl_extern_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			 struct nlattr **tb, const char *pname);
+void p4tc_ext_purge(struct idr *idr);
+void p4tc_ext_inst_purge(struct p4tc_extern_inst *inst);
+
+int p4tc_ctl_extern(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
+		    struct netlink_ext_ack *extack);
+struct p4tc_extern_param *
+p4tc_ext_param_find_byanyattr(struct idr *params_idr,
+			      struct nlattr *name_attr,
+			      const u32 param_id,
+			      struct netlink_ext_ack *extack);
+struct p4tc_extern_param *
+p4tc_ext_param_find_byid(struct idr *params_idr, const u32 param_id);
+
+int p4tc_ext_param_value_init(struct net *net,
+			      struct p4tc_extern_param *param,
+			      struct nlattr **tb, u32 typeid,
+			      bool value_required,
+			      struct netlink_ext_ack *extack);
+void p4tc_ext_param_value_free_tmpl(struct p4tc_extern_param *param);
+int p4tc_ext_param_value_dump_tmpl(struct sk_buff *skb,
+				   struct p4tc_extern_param *param);
+int p4tc_extern_insts_init_elems(struct idr *user_ext_idr);
+int p4tc_extern_inst_init_elems(struct p4tc_extern_inst *inst, u32 num_elems);
+
+int p4tc_unregister_extern(struct p4tc_extern_ops *ext);
+
+struct p4tc_extern_common *p4tc_ext_elem_get(struct p4tc_extern_inst *inst);
+void p4tc_ext_elem_put_list(struct p4tc_extern_inst *inst,
+			    struct p4tc_extern_common *e);
+
+int p4tc_ext_elem_dump_1(struct sk_buff *skb, struct p4tc_extern_common *e);
+void p4tc_ext_params_free(struct p4tc_extern_params *params, bool free_vals);
+
+static inline struct p4tc_extern_param *
+p4tc_extern_params_find_byid(struct p4tc_extern_params *params, u32 param_id)
+{
+	return idr_find(&params->params_idr, param_id);
+}
+
+int p4tc_ext_init_defval_params(struct p4tc_extern_inst *inst,
+				struct p4tc_extern_common *common,
+				struct idr *control_params_idr,
+				struct netlink_ext_ack *extack);
+struct p4tc_extern_params *p4tc_extern_params_init(void);
+
+static inline bool p4tc_ext_inst_has_dump(const struct p4tc_extern_inst *inst)
+{
+	const struct p4tc_extern_ops *ops = inst->ops;
+
+	return ops && ops->dump;
+}
+
+static inline bool p4tc_ext_has_rctrl(const struct p4tc_extern_ops *ops)
+{
+	return ops && ops->rctrl;
+}
+
+static inline bool p4tc_ext_has_exec(const struct p4tc_extern_ops *ops)
+{
+	return ops && ops->exec;
+}
+
+static inline bool p4tc_ext_has_construct(const struct p4tc_extern_ops *ops)
+{
+	return ops && ops->construct;
+}
+
+static inline bool
+p4tc_ext_inst_has_construct(const struct p4tc_extern_inst *inst)
+{
+	const struct p4tc_extern_ops *ops = inst->ops;
+
+	return p4tc_ext_has_construct(ops);
+}
+
+static inline bool
+p4tc_ext_inst_has_rctrl(const struct p4tc_extern_inst *inst)
+{
+	const struct p4tc_extern_ops *ops = inst->ops;
+
+	return p4tc_ext_has_rctrl(ops);
+}
+
+static inline bool
+p4tc_ext_inst_has_exec(const struct p4tc_extern_inst *inst)
+{
+	const struct p4tc_extern_ops *ops = inst->ops;
+
+	return p4tc_ext_has_exec(ops);
+}
+
+struct p4tc_extern *
+p4tc_ext_elem_find(struct p4tc_extern_inst *inst,
+		   struct p4tc_ext_bpf_params *params);
+
+struct p4tc_extern_common *
+p4tc_ext_common_elem_get(struct sk_buff *skb, struct p4tc_pipeline **pipeline,
+			 struct p4tc_ext_bpf_params *params);
+struct p4tc_extern_common *
+p4tc_xdp_ext_common_elem_get(struct xdp_buff *ctx,
+			     struct p4tc_pipeline **pipeline,
+			     struct p4tc_ext_bpf_params *params);
+void p4tc_ext_common_elem_put(struct p4tc_pipeline *pipeline,
+			      struct p4tc_extern_common *common);
+
+static inline void p4tc_ext_inst_inc_num_elems(struct p4tc_extern_inst *inst)
+{
+	atomic_inc(&inst->curr_num_elems);
+}
+
+static inline void p4tc_ext_inst_dec_num_elems(struct p4tc_extern_inst *inst)
+{
+	atomic_dec(&inst->curr_num_elems);
+}
+
+#endif
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index a2a39303f..3f19a1e5e 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -18,6 +18,8 @@ struct p4tcmsg {
 #define P4TC_MSGBATCH_SIZE 16
 
 #define P4TC_ACT_MAX_NUM_PARAMS P4TC_MSGBATCH_SIZE
+#define EXTPARAMNAMSIZ 256
+#define P4TC_MAX_EXTERN_METHODS 32
 
 #define P4TC_MAX_KEYSZ 512
 #define P4TC_DEFAULT_NUM_PREALLOC 16
@@ -27,6 +29,8 @@ struct p4tcmsg {
 #define ACTTMPLNAMSIZ TEMPLATENAMSZ
 #define ACTPARAMNAMSIZ TEMPLATENAMSZ
 #define TABLENAMSIZ TEMPLATENAMSZ
+#define EXTERNNAMSIZ TEMPLATENAMSZ
+#define EXTERNINSTNAMSIZ TEMPLATENAMSZ
 
 #define P4TC_TABLE_FLAGS_KEYSZ (1 << 0)
 #define P4TC_TABLE_FLAGS_MAX_ENTRIES (1 << 1)
@@ -119,6 +123,8 @@ enum {
 	P4TC_ROOT_UNSPEC,
 	P4TC_ROOT, /* nested messages */
 	P4TC_ROOT_PNAME, /* string */
+	P4TC_ROOT_COUNT,
+	P4TC_ROOT_FLAGS,
 	__P4TC_ROOT_MAX,
 };
 
@@ -130,6 +136,8 @@ enum {
 	P4TC_OBJ_PIPELINE,
 	P4TC_OBJ_ACT,
 	P4TC_OBJ_TABLE,
+	P4TC_OBJ_EXT,
+	P4TC_OBJ_EXT_INST,
 	__P4TC_OBJ_MAX,
 };
 
@@ -139,6 +147,7 @@ enum {
 enum {
 	P4TC_OBJ_RUNTIME_UNSPEC,
 	P4TC_OBJ_RUNTIME_TABLE,
+	P4TC_OBJ_RUNTIME_EXTERN,
 	__P4TC_OBJ_RUNTIME_MAX,
 };
 
@@ -233,6 +242,7 @@ enum {
 	P4TC_TABLE_DEFAULT_MISS, /* nested default miss action attributes */
 	P4TC_TABLE_CONST_ENTRY, /* nested const table entry*/
 	P4TC_TABLE_ACTS_LIST, /* nested table actions list */
+	P4TC_TABLE_COUNTER, /* string */
 	__P4TC_TABLE_MAX
 };
 
@@ -325,6 +335,7 @@ enum {
 	P4TC_ENTRY_TBL_ATTRS, /* nested table attributes */
 	P4TC_ENTRY_DYNAMIC, /* u8 tells if table entry is dynamic */
 	P4TC_ENTRY_AGING, /* u64 table entry aging */
+	P4TC_ENTRY_COUNTER, /* nested extern associated with entry counter */
 	P4TC_ENTRY_PAD,
 	__P4TC_ENTRY_MAX
 };
@@ -339,6 +350,56 @@ enum {
 	P4TC_ENTITY_MAX
 };
 
+/* P4 Extern attributes */
+enum {
+	P4TC_TMPL_EXT_UNSPEC,
+	P4TC_TMPL_EXT_NAME, /* string */
+	P4TC_TMPL_EXT_NUM_INSTS, /* u16 */
+	P4TC_TMPL_EXT_HAS_EXEC_METHOD, /* u8 */
+	__P4TC_TMPL_EXT_MAX
+};
+
+#define P4TC_TMPL_EXT_MAX (__P4TC_TMPL_EXT_MAX - 1)
+
+enum {
+	P4TC_TMPL_EXT_INST_UNSPEC,
+	P4TC_TMPL_EXT_INST_EXT_NAME, /* string */
+	P4TC_TMPL_EXT_INST_NAME, /* string */
+	P4TC_TMPL_EXT_INST_NUM_ELEMS, /* u32 */
+	P4TC_TMPL_EXT_INST_CONTROL_PARAMS, /* nested control params */
+	P4TC_TMPL_EXT_INST_TABLE_BINDABLE, /* bool */
+	P4TC_TMPL_EXT_INST_CONSTR_PARAMS, /* nested constructor params */
+	__P4TC_TMPL_EXT_INST_MAX
+};
+
+#define P4TC_TMPL_EXT_INST_MAX (__P4TC_TMPL_EXT_INST_MAX - 1)
+
+/* Extern params attributes */
+enum {
+	P4TC_EXT_PARAMS_VALUE_UNSPEC,
+	P4TC_EXT_PARAMS_VALUE_RAW, /* binary */
+	__P4TC_EXT_PARAMS_VALUE_MAX
+};
+
+#define P4TC_EXT_VALUE_PARAMS_MAX (__P4TC_EXT_PARAMS_VALUE_MAX - 1)
+
+#define P4TC_EXT_PARAMS_FLAG_ISKEY 0x1
+#define P4TC_EXT_PARAMS_FLAG_IS_DATASCALAR 0x2
+
+/* Extern params attributes */
+enum {
+	P4TC_EXT_PARAMS_UNSPEC,
+	P4TC_EXT_PARAMS_NAME, /* string */
+	P4TC_EXT_PARAMS_ID, /* u32 */
+	P4TC_EXT_PARAMS_VALUE, /* bytes */
+	P4TC_EXT_PARAMS_TYPE, /* u32 */
+	P4TC_EXT_PARAMS_BITSZ, /* u16 */
+	P4TC_EXT_PARAMS_FLAGS, /* u8 */
+	__P4TC_EXT_PARAMS_MAX
+};
+
+#define P4TC_EXT_PARAMS_MAX (__P4TC_EXT_PARAMS_MAX - 1)
+
 #define P4TC_RTA(r) \
 	((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct p4tcmsg))))
 
diff --git a/include/uapi/linux/p4tc_ext.h b/include/uapi/linux/p4tc_ext.h
new file mode 100644
index 000000000..7d4ecb5b1
--- /dev/null
+++ b/include/uapi/linux/p4tc_ext.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_P4TC_EXT_H
+#define __LINUX_P4TC_EXT_H
+
+#include <linux/types.h>
+#include <linux/pkt_sched.h>
+
+#define P4TC_EXT_NAMSIZ 64
+
+/* Extern attributes */
+enum {
+	P4TC_EXT_UNSPEC,
+	P4TC_EXT_INST_NAME,
+	P4TC_EXT_KIND,
+	P4TC_EXT_PARAMS,
+	P4TC_EXT_KEY,
+	P4TC_EXT_PAD,
+	P4TC_EXT_FLAGS,
+	__P4TC_EXT_MAX
+};
+
+#define P4TC_EXT_ID_DYN 0x01
+#define P4TC_EXT_ID_MAX 1023
+
+/* See other P4TC_EXT_FLAGS_ * flags in include/net/act_api.h. */
+#define P4TC_EXT_FLAGS_NO_PERCPU_STATS (1 << 0) /* Don't use percpu allocator
+						 * for externs stats.
+						 */
+#define P4TC_EXT_FLAGS_SKIP_HW	(1 << 1) /* don't offload action to HW */
+#define P4TC_EXT_FLAGS_SKIP_SW	(1 << 2) /* don't use action in SW */
+
+#define P4TC_EXT_FLAG_LARGE_DUMP_ON	(1 << 0)
+
+#define P4TC_EXT_MAX __P4TC_EXT_MAX
+
+#endif
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 726902f10..0e1ca964f 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -4,5 +4,5 @@ CFLAGS_trace.o := -I$(src)
 
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
 	p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
-	p4tc_runtime_api.o trace.o
+	p4tc_runtime_api.o trace.o p4tc_ext.o p4tc_tmpl_ext.o
 obj-$(CONFIG_DEBUG_INFO_BTF) += p4tc_bpf.o
diff --git a/net/sched/p4tc/p4tc_bpf.c b/net/sched/p4tc/p4tc_bpf.c
index fe84c1504..71f397961 100644
--- a/net/sched/p4tc/p4tc_bpf.c
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -13,6 +13,7 @@
 #include <linux/btf_ids.h>
 #include <linux/net_namespace.h>
 #include <net/p4tc.h>
+#include <net/p4tc_ext_api.h>
 #include <linux/netdevice.h>
 #include <net/sock.h>
 #include <net/xdp.h>
@@ -22,6 +23,8 @@ BTF_ID(struct, p4tc_table_entry_act_bpf)
 BTF_ID(struct, p4tc_table_entry_act_bpf_params)
 BTF_ID(struct, p4tc_table_entry_act_bpf)
 BTF_ID(struct, p4tc_table_entry_create_bpf_params)
+BTF_ID(struct, p4tc_ext_bpf_params)
+BTF_ID(struct, p4tc_ext_bpf_res)
 
 static struct p4tc_table_entry_act_bpf dummy_act_bpf = {};
 
@@ -294,6 +297,50 @@ xdp_p4tc_entry_delete(struct xdp_md *xdp_ctx,
 	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
 }
 
+__bpf_kfunc int bpf_p4tc_extern_md_read(struct __sk_buff *skb_ctx,
+					struct p4tc_ext_bpf_res *res,
+					struct p4tc_ext_bpf_params *params)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_extern_md_read(net, res, params);
+}
+
+__bpf_kfunc int bpf_p4tc_extern_md_write(struct __sk_buff *skb_ctx,
+					 struct p4tc_ext_bpf_params *params)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_extern_md_write(net, params);
+}
+
+__bpf_kfunc int xdp_p4tc_extern_md_read(struct xdp_md *xdp_ctx,
+					struct p4tc_ext_bpf_res *res,
+					struct p4tc_ext_bpf_params *params)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_extern_md_read(net, res, params);
+}
+
+__bpf_kfunc int xdp_p4tc_extern_md_write(struct xdp_md *xdp_ctx,
+					 struct p4tc_ext_bpf_params *params)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_extern_md_write(net, params);
+}
+
 __diag_pop();
 
 BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
@@ -322,6 +369,26 @@ static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_xdp = {
 	.set = &p4tc_kfunc_check_tbl_set_xdp,
 };
 
+BTF_SET8_START(p4tc_kfunc_check_ext_set_skb)
+BTF_ID_FLAGS(func, bpf_p4tc_extern_md_write);
+BTF_ID_FLAGS(func, bpf_p4tc_extern_md_read);
+BTF_SET8_END(p4tc_kfunc_check_ext_set_skb)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_ext_set_skb = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_ext_set_skb,
+};
+
+BTF_SET8_START(p4tc_kfunc_check_ext_set_xdp)
+BTF_ID_FLAGS(func, xdp_p4tc_extern_md_write);
+BTF_ID_FLAGS(func, xdp_p4tc_extern_md_read);
+BTF_SET8_END(p4tc_kfunc_check_ext_set_xdp)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_ext_set_xdp = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_ext_set_xdp,
+};
+
 int register_p4tc_tbl_bpf(void)
 {
 	int ret;
@@ -332,6 +399,16 @@ int register_p4tc_tbl_bpf(void)
 		return ret;
 
 	/* There is no unregister_btf_kfunc_id_set function */
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					&p4tc_kfunc_tbl_set_xdp);
+	if (ret < 0)
+		return ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+					&p4tc_kfunc_ext_set_skb);
+	if (ret < 0)
+		return ret;
+
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
-					 &p4tc_kfunc_tbl_set_xdp);
+					 &p4tc_kfunc_ext_set_xdp);
 }
diff --git a/net/sched/p4tc/p4tc_ext.c b/net/sched/p4tc/p4tc_ext.c
new file mode 100644
index 000000000..604634c8e
--- /dev/null
+++ b/net/sched/p4tc/p4tc_ext.c
@@ -0,0 +1,2204 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_ext.c	P4 TC EXTERN API
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
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <net/sch_generic.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/p4tc_types.h>
+#include <net/p4tc_ext_api.h>
+#include <net/netlink.h>
+#include <net/flow_offload.h>
+#include <net/tc_wrapper.h>
+#include <uapi/linux/p4tc.h>
+#include <net/xdp.h>
+
+static bool p4tc_ext_param_ops_is_init(struct p4tc_extern_param_ops *ops)
+{
+	struct p4tc_extern_param_ops uninit_ops = {NULL};
+
+	return memcmp(ops, &uninit_ops, sizeof(*ops));
+}
+
+static void p4tc_ext_put_param(struct p4tc_extern_param *param, bool free_val)
+{
+	struct p4tc_extern_param_ops *val_ops;
+
+	if (p4tc_ext_param_ops_is_init(param->ops))
+		val_ops = param->ops;
+	else
+		val_ops = param->mod_ops;
+
+	if (free_val) {
+		if (val_ops && val_ops->free)
+			val_ops->free(param);
+		else
+			kfree(param->value);
+	}
+
+	if (param->mask_shift)
+		p4t_release(param->mask_shift);
+	kfree(param);
+}
+
+static void p4tc_ext_put_many_params(struct idr *params_idr,
+				     struct p4tc_extern_param *params[],
+				     int params_count)
+{
+	int i;
+
+	for (i = 0; i < params_count; i++)
+		p4tc_ext_put_param(params[i], true);
+}
+
+static void p4tc_ext_insert_param(struct idr *params_idr,
+				  struct p4tc_extern_param *param)
+{
+	struct p4tc_extern_param *param_old;
+
+	param_old = idr_replace(params_idr, param, param->id);
+	if (param_old != ERR_PTR(-EBUSY))
+		p4tc_ext_put_param(param_old, true);
+}
+
+static void p4tc_ext_insert_many_params(struct idr *params_idr,
+					struct p4tc_extern_param *params[],
+					int params_count)
+{
+	int i;
+
+	for (i = 0; i < params_count; i++)
+		p4tc_ext_insert_param(params_idr, params[i]);
+}
+
+static void __p4tc_ext_params_free(struct p4tc_extern_params *params,
+				   bool free_vals)
+{
+	struct p4tc_extern_param *parm;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&params->params_idr, parm, tmp, id) {
+		idr_remove(&params->params_idr, id);
+		p4tc_ext_put_param(parm, free_vals);
+	}
+}
+
+void p4tc_ext_params_free(struct p4tc_extern_params *params, bool free_vals)
+{
+	__p4tc_ext_params_free(params, free_vals);
+	idr_destroy(&params->params_idr);
+	kfree(params);
+}
+EXPORT_SYMBOL_GPL(p4tc_ext_params_free);
+
+static void free_p4tc_ext(struct p4tc_extern *p)
+{
+	if (p->common.params)
+		p4tc_ext_params_free(p->common.params, true);
+
+	kfree(p);
+}
+
+static void free_p4tc_ext_rcu(struct rcu_head *rcu)
+{
+	struct p4tc_extern *p;
+
+	p = container_of(rcu, struct p4tc_extern, rcu);
+
+	free_p4tc_ext(p);
+}
+
+static void p4tc_extern_cleanup(struct p4tc_extern *p)
+{
+	free_p4tc_ext_rcu(&p->rcu);
+}
+
+static int __p4tc_extern_put(struct p4tc_extern *p)
+{
+	if (refcount_dec_and_test(&p->common.p4tc_ext_refcnt)) {
+		idr_remove(p->elems_idr, p->common.p4tc_ext_key);
+
+		p4tc_extern_cleanup(p);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int __p4tc_ext_idr_release(struct p4tc_extern *p)
+{
+	int ret = 0;
+
+	if (p) {
+		if (__p4tc_extern_put(p))
+			ret = P4TC_EXT_P_DELETED;
+	}
+
+	return ret;
+}
+
+static int p4tc_ext_idr_release(struct p4tc_extern *e)
+{
+	return __p4tc_ext_idr_release(e);
+}
+
+static int p4tc_ext_idr_release_dec_num_elems(struct p4tc_extern *e)
+{
+	struct p4tc_extern_inst *inst = e->common.inst;
+	int ret;
+
+	ret = __p4tc_ext_idr_release(e);
+	if (ret == P4TC_EXT_P_DELETED)
+		p4tc_ext_inst_dec_num_elems(inst);
+
+	return ret;
+}
+
+static size_t p4tc_extern_shared_attrs_size(void)
+{
+	return  nla_total_size(0) /* extern number nested */
+		+ nla_total_size(EXTERNNAMSIZ)  /* P4TC_EXT_KIND */
+		+ nla_total_size(EXTERNINSTNAMSIZ) /* P4TC_EXT_INST_NAME */
+		+ nla_total_size(sizeof(struct nla_bitfield32)); /* P4TC_EXT_FLAGS */
+}
+
+static size_t p4tc_extern_full_attrs_size(size_t sz)
+{
+	return NLMSG_HDRLEN                     /* struct nlmsghdr */
+		+ sizeof(struct p4tcmsg)
+		+ nla_total_size(0)             /* P4TC_ROOT nested */
+		+ sz;
+}
+
+static int
+generic_dump_ext_param_value(struct sk_buff *skb, struct p4tc_type *type,
+			     struct p4tc_extern_param *param)
+{
+	const u32 bytesz = BITS_TO_BYTES(type->container_bitsz);
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *nla_value;
+
+	nla_value = nla_nest_start(skb, P4TC_EXT_PARAMS_VALUE);
+	if (nla_put(skb, P4TC_EXT_PARAMS_VALUE_RAW, bytesz,
+		    param->value))
+		goto out_nlmsg_trim;
+	nla_nest_end(skb, nla_value);
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static const struct nla_policy p4tc_extern_params_value_policy[P4TC_EXT_VALUE_PARAMS_MAX + 1] = {
+	[P4TC_EXT_PARAMS_VALUE_RAW] = { .type = NLA_BINARY },
+};
+
+static int dev_init_param_value(struct net *net,
+				struct p4tc_extern_param *nparam,
+				void *value,
+				struct netlink_ext_ack *extack)
+{
+	u32 ifindex, *ifindex_ptr;
+
+	if (value) {
+		ifindex = *((u32 *)value);
+	} else {
+		ifindex = 1;
+		goto param_alloc;
+	}
+
+	rcu_read_lock();
+	if (!dev_get_by_index_rcu(net, ifindex)) {
+		NL_SET_ERR_MSG(extack, "Invalid ifindex");
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+
+param_alloc:
+	nparam->value = kzalloc(sizeof(ifindex), GFP_KERNEL);
+	if (!nparam->value)
+		return -ENOMEM;
+
+	ifindex_ptr = nparam->value;
+	*ifindex_ptr = ifindex;
+
+	return 0;
+}
+
+static int dev_dump_param_value(struct sk_buff *skb,
+				struct p4tc_extern_param_ops *op,
+				struct p4tc_extern_param *param)
+{
+	struct nlattr *nest;
+	u32 *ifindex;
+	int ret;
+
+	nest = nla_nest_start(skb, P4TC_EXT_PARAMS_VALUE);
+	ifindex = (u32 *)param->value;
+
+	if (nla_put_u32(skb, P4TC_EXT_PARAMS_VALUE_RAW, *ifindex)) {
+		ret = -EINVAL;
+		goto out_nla_cancel;
+	}
+	nla_nest_end(skb, nest);
+
+	return 0;
+
+out_nla_cancel:
+	nla_nest_cancel(skb, nest);
+	return ret;
+}
+
+static void dev_free_param_value(struct p4tc_extern_param *param)
+{
+	kfree(param->value);
+}
+
+static const struct p4tc_extern_param_ops ext_param_ops[P4T_MAX + 1] = {
+	[P4T_DEV] = {
+		.init_value = dev_init_param_value,
+		.dump_value = dev_dump_param_value,
+		.free = dev_free_param_value,
+	},
+};
+
+static int p4tc_extern_elem_dump_param_noval(struct sk_buff *skb,
+					     struct p4tc_extern_param *parm)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+
+	if (nla_put_string(skb, P4TC_EXT_PARAMS_NAME,
+			   parm->name))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, P4TC_EXT_PARAMS_ID, parm->id))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, P4TC_EXT_PARAMS_TYPE, parm->type->typeid))
+		goto nla_put_failure;
+
+	return skb->len;
+
+nla_put_failure:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int
+p4tc_extern_elem_dump_params(struct sk_buff *skb, struct p4tc_extern_common *e)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_extern_param *parm;
+	struct nlattr *nest_parms;
+	int id;
+
+	nest_parms = nla_nest_start(skb, P4TC_EXT_PARAMS);
+	if (e->params) {
+		int i = 1;
+
+		idr_for_each_entry(&e->params->params_idr, parm, id) {
+			struct p4tc_extern_param_ops *val_ops;
+			struct nlattr *nest_count;
+
+			nest_count = nla_nest_start(skb, i);
+			if (!nest_count)
+				goto nla_put_failure;
+
+			if (p4tc_extern_elem_dump_param_noval(skb, parm) < 0)
+				goto nla_put_failure;
+
+			if (p4tc_ext_param_ops_is_init(parm->ops))
+				val_ops = parm->ops;
+			else
+				val_ops = parm->mod_ops;
+
+			read_lock_bh(&e->params->params_lock);
+			if (val_ops && val_ops->dump_value) {
+				if (val_ops->dump_value(skb, parm->ops, parm) < 0) {
+					read_unlock_bh(&e->params->params_lock);
+					goto nla_put_failure;
+				}
+			} else {
+				if (generic_dump_ext_param_value(skb, parm->type, parm)) {
+					read_unlock_bh(&e->params->params_lock);
+					goto nla_put_failure;
+				}
+			}
+			read_unlock_bh(&e->params->params_lock);
+
+			if (nla_put_u32(skb, P4TC_EXT_PARAMS_FLAGS,
+					parm->flags))
+				goto nla_put_failure;
+
+			nla_nest_end(skb, nest_count);
+			i++;
+		}
+	}
+	nla_nest_end(skb, nest_parms);
+
+	return skb->len;
+
+nla_put_failure:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+int
+p4tc_ext_elem_dump_1(struct sk_buff *skb, struct p4tc_extern_common *e)
+{
+	const char *instname = e->inst->common.name;
+	unsigned char *b = nlmsg_get_pos(skb);
+	const char *kind = e->inst->ext_name;
+	u32 flags = e->p4tc_ext_flags;
+	u32 key = e->p4tc_ext_key;
+	int err;
+
+	if (nla_put_string(skb, P4TC_EXT_KIND, kind))
+		goto nla_put_failure;
+
+	if (nla_put_string(skb, P4TC_EXT_INST_NAME, instname))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, P4TC_EXT_KEY, key))
+		goto nla_put_failure;
+
+	if (flags && nla_put_bitfield32(skb, P4TC_EXT_FLAGS,
+					flags, flags))
+		goto nla_put_failure;
+
+	err = p4tc_extern_elem_dump_params(skb, e);
+	if (err < 0)
+		goto nla_put_failure;
+
+	return skb->len;
+
+nla_put_failure:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+EXPORT_SYMBOL(p4tc_ext_elem_dump_1);
+
+static int p4tc_ext_dump_walker(struct p4tc_extern_inst *inst,
+				struct sk_buff *skb,
+				struct netlink_callback *cb)
+{
+	struct idr *idr = &inst->control_elems_idr;
+	int err = 0, s_i = 0, n_i = 0;
+	u32 ext_flags = cb->args[2];
+	struct p4tc_extern *p;
+	unsigned long id = 1;
+	struct nlattr *nest;
+	unsigned long tmp;
+	int key = -1;
+
+	if (p4tc_ext_inst_has_dump(inst)) {
+		n_i = inst->ops->dump(skb, inst, cb);
+		if (n_i < 0)
+			return n_i;
+	} else {
+		s_i = cb->args[0];
+
+		idr_for_each_entry_ul(idr, p, tmp, id) {
+			key++;
+			if (key < s_i)
+				continue;
+			if (IS_ERR(p))
+				continue;
+
+			nest = nla_nest_start(skb, n_i);
+			if (!nest) {
+				key--;
+				goto nla_put_failure;
+			}
+
+			err = p4tc_ext_elem_dump_1(skb, &p->common);
+			if (err < 0) {
+				key--;
+				nlmsg_trim(skb, nest);
+				goto done;
+			}
+			nla_nest_end(skb, nest);
+			n_i++;
+			if (!(ext_flags & P4TC_EXT_FLAG_LARGE_DUMP_ON) &&
+			    n_i >= P4TC_MSGBATCH_SIZE)
+				goto done;
+		}
+	}
+done:
+	if (key >= 0)
+		cb->args[0] = key + 1;
+
+	if (n_i) {
+		if (ext_flags & P4TC_EXT_FLAG_LARGE_DUMP_ON)
+			cb->args[1] = n_i;
+	}
+	return n_i;
+
+nla_put_failure:
+	nla_nest_cancel(skb, nest);
+	goto done;
+}
+
+static void __p4tc_ext_idr_purge(struct p4tc_extern *p)
+{
+	atomic_dec(&p->common.inst->curr_num_elems);
+	p4tc_extern_cleanup(p);
+}
+
+static void p4tc_ext_idr_purge(struct p4tc_extern *p)
+{
+	idr_remove(p->elems_idr, p->common.p4tc_ext_key);
+	__p4tc_ext_idr_purge(p);
+}
+
+/* Called when pipeline is being purged */
+void p4tc_ext_purge(struct idr *idr)
+{
+	struct p4tc_extern *p;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(idr, p, tmp, id) {
+		if (IS_ERR(p))
+			continue;
+		p4tc_ext_idr_purge(p);
+	}
+}
+
+static int p4tc_ext_idr_search(struct p4tc_extern_inst *inst,
+			       struct p4tc_extern **e, u32 key)
+{
+	struct idr *elems_idr = &inst->control_elems_idr;
+	struct p4tc_extern *p;
+
+	p = idr_find(elems_idr, key);
+	if (IS_ERR(p))
+		p = NULL;
+
+	if (p) {
+		*e = p;
+		return true;
+	}
+	return false;
+}
+
+static int __p4tc_ext_idr_search(struct p4tc_extern_inst *inst,
+				 struct p4tc_extern **e, u32 key)
+{
+	if (p4tc_ext_idr_search(inst, e, key)) {
+		refcount_inc(&((*e)->common.p4tc_ext_refcnt));
+		return true;
+	}
+
+	return false;
+}
+
+static int p4tc_ext_copy(struct p4tc_extern_inst *inst,
+			 u32 key, struct p4tc_extern **e,
+			 struct p4tc_extern *e_orig,
+			 const struct p4tc_extern_ops *ops,
+			 u32 flags)
+{
+	const u32 size = (ops && ops->elem_size) ? ops->elem_size : sizeof(**e);
+	struct p4tc_extern *p = kzalloc(size, GFP_KERNEL);
+
+	if (unlikely(!p))
+		return -ENOMEM;
+
+	spin_lock_init(&p->p4tc_ext_lock);
+	p->common.p4tc_ext_key = key;
+	p->common.p4tc_ext_flags = flags;
+	refcount_set(&p->common.p4tc_ext_refcnt,
+		     refcount_read(&e_orig->common.p4tc_ext_refcnt));
+
+	p->elems_idr = e_orig->elems_idr;
+	p->common.inst = inst;
+	p->common.ops = ops;
+	*e = p;
+	return 0;
+}
+
+static int p4tc_ext_idr_create(struct p4tc_extern_inst *inst,
+			       u32 key, struct p4tc_extern **e,
+			       const struct p4tc_extern_ops *ops,
+			       u32 flags)
+{
+	struct p4tc_extern *p = kzalloc(sizeof(*p), GFP_KERNEL);
+	u32 max_num_elems = inst->max_num_elems;
+
+	if (unlikely(!p))
+		return -ENOMEM;
+
+	if (atomic_read(&inst->curr_num_elems) == max_num_elems) {
+		kfree(p);
+		return -E2BIG;
+	}
+
+	p4tc_ext_inst_inc_num_elems(inst);
+
+	refcount_set(&p->common.p4tc_ext_refcnt, 1);
+
+	spin_lock_init(&p->p4tc_ext_lock);
+	p->common.p4tc_ext_key = key;
+	p->common.p4tc_ext_flags = flags;
+
+	p->elems_idr = &inst->control_elems_idr;
+	p->common.inst = inst;
+	p->common.ops = ops;
+	*e = p;
+	return 0;
+}
+
+/* Check if extern with specified key exists. If extern is found, increments
+ * its reference, and return 1. Otherwise return -ENOENT.
+ */
+static int p4tc_ext_idr_check_alloc(struct p4tc_extern_inst *inst,
+				    u32 key, struct p4tc_extern **e,
+				    struct netlink_ext_ack *extack)
+{
+	struct idr *elems_idr = &inst->control_elems_idr;
+	struct p4tc_extern *p;
+
+	p = idr_find(elems_idr, key);
+	if (p) {
+		refcount_inc(&p->common.p4tc_ext_refcnt);
+		*e = p;
+		return 1;
+	}
+
+	NL_SET_ERR_MSG_FMT(extack, "Unable to find element with key %u",
+			   key);
+	return -ENOENT;
+}
+
+struct p4tc_extern *
+p4tc_ext_elem_find(struct p4tc_extern_inst *inst,
+		   struct p4tc_ext_bpf_params *params)
+{
+	struct p4tc_extern *e;
+
+	e = idr_find(&inst->control_elems_idr, params->index);
+	if (!e)
+		return ERR_PTR(-ENOENT);
+
+	return e;
+}
+EXPORT_SYMBOL(p4tc_ext_elem_find);
+
+#define p4tc_ext_common_elem_find(common, params) \
+	((struct p4tc_extern_common *)p4tc_ext_elem_find(common, params))
+
+static struct p4tc_extern_common *
+__p4tc_ext_common_elem_get(struct net *net, struct p4tc_pipeline **pipeline,
+			   struct p4tc_ext_bpf_params *params)
+{
+	struct p4tc_extern_common *ext_common;
+	struct p4tc_extern_inst *inst;
+	int err;
+
+	inst = p4tc_ext_inst_get_byids(net, pipeline, params);
+	if (IS_ERR(inst)) {
+		err = PTR_ERR(inst);
+		goto put_pipe;
+	}
+
+	ext_common = p4tc_ext_common_elem_find(inst, params);
+	if (IS_ERR(ext_common)) {
+		err = PTR_ERR(ext_common);
+		goto put_pipe;
+	}
+
+	if (!refcount_inc_not_zero(&ext_common->p4tc_ext_refcnt)) {
+		err = -EBUSY;
+		goto put_pipe;
+	}
+
+	return ext_common;
+
+put_pipe:
+	p4tc_pipeline_put(*pipeline);
+	return ERR_PTR(err);
+}
+
+/* This function should be paired with p4tc_ext_common_elem_put */
+struct p4tc_extern_common *
+p4tc_ext_common_elem_get(struct sk_buff *skb, struct p4tc_pipeline **pipeline,
+			 struct p4tc_ext_bpf_params *params)
+{
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __p4tc_ext_common_elem_get(net, pipeline, params);
+}
+EXPORT_SYMBOL(p4tc_ext_common_elem_get);
+
+/* This function should be paired with p4tc_ext_common_elem_put */
+struct p4tc_extern_common *
+p4tc_xdp_ext_common_elem_get(struct xdp_buff *ctx,
+			     struct p4tc_pipeline **pipeline,
+			     struct p4tc_ext_bpf_params *params)
+{
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __p4tc_ext_common_elem_get(net, pipeline, params);
+}
+EXPORT_SYMBOL(p4tc_xdp_ext_common_elem_get);
+
+void p4tc_ext_common_elem_put(struct p4tc_pipeline *pipeline,
+			      struct p4tc_extern_common *common)
+{
+	refcount_dec(&common->p4tc_ext_refcnt);
+	p4tc_pipeline_put(pipeline);
+}
+EXPORT_SYMBOL(p4tc_ext_common_elem_put);
+
+static bool p4tc_ext_param_is_writable(struct p4tc_extern_param *param)
+{
+	return param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY;
+}
+
+int __bpf_p4tc_extern_md_write(struct net *net,
+			       struct p4tc_ext_bpf_params *params)
+{
+	struct p4tc_extern_param *param;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_common *e;
+	struct p4tc_type *type;
+	u8 *params_data;
+	int err = 0;
+
+	if (!params)
+		return -EINVAL;
+
+	params_data = params->in_params;
+
+	e = __p4tc_ext_common_elem_get(net, &pipeline, params);
+	if (IS_ERR(e))
+		return PTR_ERR(e);
+
+	param = idr_find(&e->params->params_idr, params->param_id);
+	if (unlikely(!param)) {
+		err = -EINVAL;
+		goto put_pipe;
+	}
+
+	if (!p4tc_ext_param_is_writable(param)) {
+		err = -EINVAL;
+		goto put_pipe;
+	}
+
+	type = param->type;
+	if (unlikely(!type->ops->host_read)) {
+		err = -EINVAL;
+		goto put_pipe;
+	}
+
+	if (unlikely(!type->ops->host_write)) {
+		err = -EINVAL;
+		goto put_pipe;
+	}
+
+	write_lock_bh(&e->params->params_lock);
+	p4t_copy(param->mask_shift, type, param->value,
+		 param->mask_shift, type, params_data);
+	write_unlock_bh(&e->params->params_lock);
+
+put_pipe:
+	p4tc_ext_common_elem_put(pipeline, e);
+
+	return err;
+}
+
+int __bpf_p4tc_extern_md_read(struct net *net,
+			      struct p4tc_ext_bpf_res *res,
+			      struct p4tc_ext_bpf_params *params)
+{
+	const struct p4tc_type_ops *ops;
+	struct p4tc_extern_param *param;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_common *e;
+	int err = 0;
+
+	if (!params || !res)
+		return -EINVAL;
+
+	e = __p4tc_ext_common_elem_get(net, &pipeline, params);
+	if (IS_ERR(e))
+		return PTR_ERR(e);
+
+	param = idr_find(&e->params->params_idr, params->param_id);
+	if (unlikely(!param)) {
+		err = -ENOENT;
+		goto refcount_dec;
+	}
+
+	ops = param->type->ops;
+	if (unlikely(!ops->host_read)) {
+		err = -ENOENT;
+		goto refcount_dec;
+	}
+
+	read_lock_bh(&e->params->params_lock);
+	ops->host_read(param->type, param->mask_shift, param->value,
+		       res->out_params);
+	read_unlock_bh(&e->params->params_lock);
+
+refcount_dec:
+	p4tc_ext_common_elem_put(pipeline, e);
+
+	return err;
+}
+
+static int p4tc_extern_destroy(struct p4tc_extern *externs[])
+{
+	struct p4tc_extern *e;
+	int ret = 0, i;
+
+	for (i = 0; i < P4TC_MSGBATCH_SIZE && externs[i]; i++) {
+		e = externs[i];
+		externs[i] = NULL;
+		free_p4tc_ext_rcu(&e->rcu);
+	}
+	return ret;
+}
+
+static int p4tc_extern_put(struct p4tc_extern *p)
+{
+	return __p4tc_extern_put(p);
+}
+
+/* Put all externs in this array, skip those NULL's. */
+static void p4tc_extern_put_many(struct p4tc_extern *externs[])
+{
+	int i;
+
+	for (i = 0; i < P4TC_MSGBATCH_SIZE; i++) {
+		struct p4tc_extern *e = externs[i];
+
+		if (!e)
+			continue;
+		p4tc_extern_put(e);
+	}
+}
+
+static int p4tc_extern_elem_dump(struct sk_buff *skb,
+				 struct p4tc_extern *externs[],
+				 int ref)
+{
+	struct p4tc_extern *e;
+	int err = -EINVAL, i;
+	struct nlattr *nest;
+
+	for (i = 0; i < P4TC_MSGBATCH_SIZE && externs[i]; i++) {
+		e = externs[i];
+		nest = nla_nest_start_noflag(skb, i + 1);
+		if (!nest)
+			goto nla_put_failure;
+		err = p4tc_ext_elem_dump_1(skb, &e->common);
+		if (err < 0)
+			goto errout;
+		nla_nest_end(skb, nest);
+	}
+
+	return 0;
+
+nla_put_failure:
+	err = -EINVAL;
+errout:
+	nla_nest_cancel(skb, nest);
+	return err;
+}
+
+static void generic_free_param_value(struct p4tc_extern_param *param)
+{
+	kfree(param->value);
+}
+
+static void *generic_parse_param_value(struct p4tc_extern_param *nparam,
+				       struct p4tc_type *type,
+				       struct nlattr *nla, bool value_required,
+				       struct netlink_ext_ack *extack)
+{
+	const u32 alloc_len = BITS_TO_BYTES(type->container_bitsz);
+	struct nlattr *tb_value[P4TC_EXT_VALUE_PARAMS_MAX + 1];
+	void *value;
+	int err;
+
+	if (!nla) {
+		if (value_required) {
+			NL_SET_ERR_MSG(extack, "Must specify param value");
+			return ERR_PTR(-EINVAL);
+		} else {
+			return NULL;
+		}
+	}
+
+	err = nla_parse_nested(tb_value, P4TC_EXT_VALUE_PARAMS_MAX,
+			       nla, p4tc_extern_params_value_policy,
+			       extack);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	value = nla_data(tb_value[P4TC_EXT_PARAMS_VALUE_RAW]);
+	if (type->ops->validate_p4t) {
+		err = type->ops->validate_p4t(type, value, 0, type->bitsz - 1,
+					      extack);
+		if (err < 0)
+			return ERR_PTR(err);
+	}
+
+	if (nla_len(tb_value[P4TC_EXT_PARAMS_VALUE_RAW]) != alloc_len)
+		return ERR_PTR(-EINVAL);
+
+	return value;
+}
+
+static int generic_init_param_value(struct net *net,
+				    struct p4tc_extern_param *nparam,
+				    struct nlattr **tb,
+				    u32 byte_sz, bool value_required,
+				    struct netlink_ext_ack *extack)
+{
+	const u32 alloc_len = BITS_TO_BYTES(nparam->type->container_bitsz);
+	struct p4tc_extern_param_ops *ops;
+	void *value;
+
+	if (p4tc_ext_param_ops_is_init(nparam->ops))
+		ops = nparam->ops;
+	else
+		ops = nparam->mod_ops;
+
+	value = generic_parse_param_value(nparam, nparam->type,
+					  tb[P4TC_EXT_PARAMS_VALUE],
+					  value_required, extack);
+	if (IS_ERR_OR_NULL(value))
+		return PTR_ERR(value);
+
+	if (ops && ops->init_value)
+		return ops->init_value(net, nparam, value, extack);
+
+	nparam->value = kzalloc(alloc_len, GFP_KERNEL);
+	if (!nparam->value)
+		return -ENOMEM;
+
+	memcpy(nparam->value, value, byte_sz);
+
+	return 0;
+}
+
+static const struct nla_policy p4tc_extern_policy[P4TC_EXT_MAX + 1] = {
+	[P4TC_EXT_INST_NAME] = {
+		.type = NLA_STRING,
+		.len = EXTERNINSTNAMSIZ
+	},
+	[P4TC_EXT_KIND]		= { .type = NLA_STRING },
+	[P4TC_EXT_PARAMS]	= { .type = NLA_NESTED },
+	[P4TC_EXT_KEY]		= { .type = NLA_NESTED },
+	[P4TC_EXT_FLAGS]	= { .type = NLA_BITFIELD32 },
+};
+
+static const struct nla_policy p4tc_extern_params_policy[P4TC_EXT_PARAMS_MAX + 1] = {
+	[P4TC_EXT_PARAMS_NAME] = { .type = NLA_STRING, .len = EXTPARAMNAMSIZ },
+	[P4TC_EXT_PARAMS_ID] = { .type = NLA_U32 },
+	[P4TC_EXT_PARAMS_VALUE] = { .type = NLA_NESTED },
+	[P4TC_EXT_PARAMS_TYPE] = { .type = NLA_U32 },
+	[P4TC_EXT_PARAMS_BITSZ] = { .type = NLA_U16 },
+	[P4TC_EXT_PARAMS_FLAGS] = { .type = NLA_U8 },
+};
+
+int p4tc_ext_param_value_init(struct net *net,
+			      struct p4tc_extern_param *param,
+			      struct nlattr **tb, u32 typeid,
+			      bool value_required,
+			      struct netlink_ext_ack *extack)
+{
+	u32 byte_sz = BITS_TO_BYTES(param->bitsz);
+
+	if (!param->ops) {
+		struct p4tc_extern_param_ops *ops;
+
+		ops = (struct p4tc_extern_param_ops *)&ext_param_ops[typeid];
+		param->ops = ops;
+	}
+
+	return generic_init_param_value(net, param, tb, byte_sz, value_required,
+					extack);
+}
+
+void p4tc_ext_param_value_free_tmpl(struct p4tc_extern_param *param)
+{
+	if (param->ops->free)
+		return param->ops->free(param);
+
+	return generic_free_param_value(param);
+}
+
+int p4tc_ext_param_value_dump_tmpl(struct sk_buff *skb,
+				   struct p4tc_extern_param *param)
+{
+	if (param->ops && param->ops->dump_value)
+		return param->ops->dump_value(skb, param->ops, param);
+
+	return generic_dump_ext_param_value(skb, param->type, param);
+}
+
+static struct p4tc_extern_param *
+p4tc_ext_create_param(struct net *net, struct p4tc_extern_params *params,
+		      struct idr *control_params_idr,
+		      struct nlattr **tb, size_t *attrs_size,
+		      bool init_param, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param, *nparam;
+	u32 param_id = 0;
+	int err = 0;
+
+	if (tb[P4TC_EXT_PARAMS_ID])
+		param_id = nla_get_u32(tb[P4TC_EXT_PARAMS_ID]);
+	*attrs_size += nla_total_size(sizeof(u32));
+
+	param = p4tc_ext_param_find_byanyattr(control_params_idr,
+					      tb[P4TC_EXT_PARAMS_NAME],
+					      param_id, extack);
+	if (IS_ERR(param))
+		return param;
+
+	if (tb[P4TC_EXT_PARAMS_TYPE]) {
+		u32 typeid = nla_get_u32(tb[P4TC_EXT_PARAMS_TYPE]);
+
+		if (param->type->typeid != typeid) {
+			NL_SET_ERR_MSG(extack,
+				       "Param type differs from template");
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param type");
+		return ERR_PTR(-EINVAL);
+	}
+	*attrs_size += nla_total_size(sizeof(u32));
+
+	nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+	if (!nparam)
+		return ERR_PTR(-ENOMEM);
+
+	strscpy(nparam->name, param->name, EXTPARAMNAMSIZ);
+	nparam->type = param->type;
+	nparam->bitsz = param->bitsz;
+
+	if (init_param) {
+		err = p4tc_ext_param_value_init(net, nparam, tb,
+						param->type->typeid, true,
+						extack);
+	} else {
+		void *value;
+
+		value = generic_parse_param_value(nparam, nparam->type,
+						  tb[P4TC_EXT_PARAMS_VALUE],
+						  true, extack);
+		if (IS_ERR(value))
+			err = PTR_ERR(value);
+		else
+			nparam->value = value;
+	}
+
+	if (err < 0)
+		goto free;
+
+	*attrs_size += nla_total_size(BITS_TO_BYTES(param->type->container_bitsz));
+	nparam->id = param->id;
+
+	err = idr_alloc_u32(&params->params_idr, ERR_PTR(-EBUSY), &nparam->id,
+			    nparam->id, GFP_KERNEL);
+	if (err < 0)
+		goto free_val;
+
+	return nparam;
+
+free_val:
+	if (param->ops && param->ops->free)
+		param->ops->free(nparam);
+	else
+		generic_free_param_value(nparam);
+
+free:
+	kfree(nparam);
+
+	return ERR_PTR(err);
+}
+
+static struct p4tc_extern_param *
+p4tc_ext_init_param(struct net *net, struct idr *control_params_idr,
+		    struct p4tc_extern_params *params, struct nlattr *nla,
+		    size_t *attrs_size, bool init_value,
+		    struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_PARAMS_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_PARAMS_MAX, nla,
+			       p4tc_extern_params_policy, extack);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return p4tc_ext_create_param(net, params, control_params_idr, tb,
+				     attrs_size, init_value, extack);
+}
+
+static int p4tc_ext_get_key_param_value(struct nlattr *nla,
+					u32 *key, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_VALUE_PARAMS_MAX + 1];
+	u32 *value;
+	int err;
+
+	if (!nla) {
+		NL_SET_ERR_MSG(extack, "Must specify key param value");
+		return -EINVAL;
+	}
+
+	err = nla_parse_nested(tb, P4TC_EXT_VALUE_PARAMS_MAX,
+			       nla, p4tc_extern_params_value_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[P4TC_EXT_PARAMS_VALUE_RAW]) {
+		NL_SET_ERR_MSG(extack, "Must specify raw value attr");
+		return -EINVAL;
+	}
+
+	if (nla_len(tb[P4TC_EXT_PARAMS_VALUE_RAW]) > sizeof(*key)) {
+		NL_SET_ERR_MSG(extack,
+			       "Param value is bigger than 32 bits");
+		return -EINVAL;
+	}
+
+	value = nla_data(tb[P4TC_EXT_PARAMS_VALUE_RAW]);
+
+	*key = *value;
+
+	return 0;
+}
+
+static int p4tc_ext_get_nonscalar_key_param(struct idr *params_idr,
+					    struct nlattr *nla, u32 *key,
+					    struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_PARAMS_MAX + 1];
+	struct p4tc_extern_param *index_param;
+	char *param_name;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_PARAMS_MAX, nla,
+			       p4tc_extern_params_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[P4TC_EXT_PARAMS_NAME]) {
+		NL_SET_ERR_MSG(extack, "Must specify key param name");
+		return -EINVAL;
+	}
+	param_name = nla_data(tb[P4TC_EXT_PARAMS_NAME]);
+
+	index_param = p4tc_ext_param_find_byanyattr(params_idr,
+						    tb[P4TC_EXT_PARAMS_NAME],
+						    0, extack);
+	if (IS_ERR(index_param)) {
+		NL_SET_ERR_MSG(extack, "Key param name not found");
+		return -EINVAL;
+	}
+
+	if (!(index_param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY)) {
+		NL_SET_ERR_MSG_FMT(extack, "%s is not the key param name",
+				   param_name);
+		return -EINVAL;
+	}
+
+	err = p4tc_ext_get_key_param_value(tb[P4TC_EXT_PARAMS_VALUE], key,
+					   extack);
+	if (err < 0)
+		return err;
+
+	return index_param->id;
+}
+
+static int p4tc_ext_get_key_param_scalar(struct p4tc_extern_inst *inst,
+					 struct nlattr *nla, u32 *key,
+					 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_PARAMS_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_PARAMS_MAX, nla,
+			       p4tc_extern_params_policy, extack);
+	if (err < 0)
+		return err;
+
+	return p4tc_ext_get_key_param_value(tb[P4TC_EXT_PARAMS_VALUE], key,
+					    extack);
+}
+
+struct p4tc_extern_params *p4tc_extern_params_init(void)
+{
+	struct p4tc_extern_params *params;
+
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return NULL;
+
+	idr_init(&params->params_idr);
+	rwlock_init(&params->params_lock);
+
+	return params;
+}
+
+static int __p4tc_ext_init_params(struct net *net,
+				  struct idr *control_params_idr,
+				  struct p4tc_extern_params **params,
+				  struct nlattr *nla, size_t *attrs_size,
+				  bool init_values,
+				  struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *params_backup[P4TC_MSGBATCH_SIZE] = { NULL };
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	int err;
+	int i;
+
+	if (!*params) {
+		*params = p4tc_extern_params_init();
+		if (!*params)
+			return -ENOMEM;
+	}
+
+	err = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, extack);
+	if (err < 0) {
+		kfree(*params);
+		*params = NULL;
+		return err;
+	}
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		struct p4tc_extern_param *param;
+
+		param = p4tc_ext_init_param(net, control_params_idr, *params,
+					    tb[i], attrs_size, init_values,
+					    extack);
+		if (IS_ERR(param)) {
+			err = PTR_ERR(param);
+			goto params_del;
+		}
+		params_backup[i - 1] = param;
+		*attrs_size = nla_total_size(0);  /* params array element nested */
+	}
+
+	p4tc_ext_insert_many_params(&((*params)->params_idr), params_backup,
+				    i - 1);
+	return 0;
+
+params_del:
+	p4tc_ext_put_many_params(&((*params)->params_idr), params_backup,
+				 i - 1);
+	kfree(*params);
+	*params = NULL;
+	return err;
+}
+
+#define p4tc_ext_init_params(net, control_params_idr, params, nla, atrrs_size, extack) \
+	(__p4tc_ext_init_params(net, control_params_idr, params, \
+				nla, &(attrs_size), true, extack))
+
+#define p4tc_ext_parse_params(net, control_params_idr, params, nla, attrs_size, extack) \
+	(__p4tc_ext_init_params(net, control_params_idr, params, \
+				nla, &(attrs_size), false, extack))
+
+void p4tc_ext_elem_put_list(struct p4tc_extern_inst *inst,
+			    struct p4tc_extern_common *e)
+{
+	struct p4tc_extern_param *param;
+	unsigned long param_id, tmp;
+
+	idr_for_each_entry_ul(&e->params->params_idr, param, tmp, param_id) {
+		const struct p4tc_type *type = param->type;
+		const u32 type_bytesz = BITS_TO_BYTES(type->container_bitsz);
+
+		if (param->mod_ops)
+			param->mod_ops->default_value(param);
+		else
+			memset(param->value, 0, type_bytesz);
+	}
+
+	spin_lock(&inst->available_list_lock);
+	list_add_tail(&e->node, &inst->unused_elems);
+	refcount_dec(&e->p4tc_ext_refcnt);
+	spin_unlock(&inst->available_list_lock);
+}
+
+struct p4tc_extern_common *p4tc_ext_elem_get(struct p4tc_extern_inst *inst)
+{
+	struct p4tc_extern_common *e;
+
+	spin_lock(&inst->available_list_lock);
+	e = list_first_entry_or_null(&inst->unused_elems,
+				     struct p4tc_extern_common, node);
+	if (e) {
+		refcount_inc(&e->p4tc_ext_refcnt);
+		list_del_init(&e->node);
+	}
+
+	spin_unlock(&inst->available_list_lock);
+
+	return e;
+}
+
+static void p4tc_ext_idr_insert_many(struct p4tc_extern *externs[])
+{
+	int i;
+
+	for (i = 0; i < P4TC_MSGBATCH_SIZE; i++) {
+		struct p4tc_extern *e = externs[i];
+		struct p4tc_extern_inst *inst;
+		struct p4tc_extern *old_e;
+
+		if (!e)
+			continue;
+
+		inst = e->common.inst;
+		spin_lock(&inst->available_list_lock);
+		old_e = idr_replace(e->elems_idr, e, e->common.p4tc_ext_key);
+		if (inst->tbl_bindable)
+			list_del(&old_e->common.node);
+		call_rcu(&old_e->rcu, free_p4tc_ext_rcu);
+		if (inst->tbl_bindable)
+			list_add(&e->common.node, &inst->unused_elems);
+		spin_unlock(&inst->available_list_lock);
+	}
+}
+
+static const char *
+p4tc_ext_get_kind(struct nlattr *nla, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_MAX + 1];
+	struct nlattr *kind;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_MAX, nla,
+			       p4tc_extern_policy, extack);
+	if (err < 0)
+		return ERR_PTR(err);
+	err = -EINVAL;
+	kind = tb[P4TC_EXT_KIND];
+	if (!kind) {
+		NL_SET_ERR_MSG(extack, "TC extern name must be specified");
+		return ERR_PTR(err);
+	}
+
+	return nla_data(kind);
+}
+
+static struct p4tc_extern *
+p4tc_ext_init(struct net *net, struct nlattr *nla,
+	      struct p4tc_extern_inst *inst,
+	      u32 key, u32 flags,
+	      struct netlink_ext_ack *extack)
+{
+	struct idr *control_params_idr = &inst->params->params_idr;
+	const struct p4tc_extern_ops *e_o = inst->ops;
+	struct p4tc_extern_params *params = NULL;
+	struct p4tc_extern *e_orig = NULL;
+	size_t attrs_size = 0;
+	struct p4tc_extern *e;
+	int err = 0;
+
+	if (!nla) {
+		NL_SET_ERR_MSG(extack, "Must specify extern params");
+		err =  -EINVAL;
+		goto out;
+	}
+
+	if (p4tc_ext_has_rctrl(e_o)) {
+		err = p4tc_ext_parse_params(net, control_params_idr, &params,
+					    nla, attrs_size, extack);
+		if (err < 0)
+			goto out;
+
+		err = e_o->rctrl(RTM_P4TC_UPDATE, inst,
+				 (struct p4tc_extern_common **)&e, params, &key,
+				 extack);
+		p4tc_ext_params_free(params, false);
+		if (err < 0)
+			goto out;
+
+		return e;
+	}
+
+	err = p4tc_ext_idr_check_alloc(inst, key, &e_orig, extack);
+	if (err < 0)
+		goto out;
+
+	err = p4tc_ext_copy(inst, key, &e, e_orig, e_o, flags);
+	if (err < 0)
+		goto out;
+
+	err = p4tc_ext_init_params(net, control_params_idr, &params,
+				   nla, &attrs_size, extack);
+	if (err < 0)
+		goto release_idr;
+	attrs_size += nla_total_size(0) + p4tc_extern_shared_attrs_size();
+	e->attrs_size = attrs_size;
+
+	e->common.params = params;
+
+	return e;
+
+release_idr:
+	p4tc_ext_idr_release(e);
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_extern_param *find_key_param(struct idr *params_idr)
+{
+	struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		if (param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY)
+			return param;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_extern_param *
+p4tc_ext_init_defval_param(struct p4tc_extern_param *param,
+			   struct netlink_ext_ack *extack)
+{
+	const u32 bytesz = BITS_TO_BYTES(param->type->container_bitsz);
+	struct p4tc_extern_param_ops *val_ops;
+	struct p4tc_extern_param *nparam;
+	int err;
+
+	if (p4tc_ext_param_ops_is_init(param->ops))
+		val_ops = param->ops;
+	else
+		val_ops = param->mod_ops;
+
+	nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+	if (!nparam) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	strscpy(nparam->name, param->name, EXTPARAMNAMSIZ);
+	nparam->type = param->type;
+	nparam->id = param->id;
+
+	if (val_ops) {
+		if (param->mod_ops && !val_ops->default_value) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Param %s should have default_value op",
+					   param->name);
+			err = -EINVAL;
+			goto free_param;
+		}
+		err = val_ops->init_value(NULL, nparam, param->value,
+					  extack);
+		if (err < 0)
+			goto free_param;
+	} else {
+		nparam->value = kzalloc(bytesz, GFP_KERNEL);
+		if (!nparam->value) {
+			err = -ENOMEM;
+			goto free_param;
+		}
+
+		if (param->value)
+			memcpy(nparam->value, param->value, bytesz);
+	}
+	nparam->ops = param->ops;
+	nparam->mod_ops = param->mod_ops;
+
+	return nparam;
+
+free_param:
+	kfree(nparam);
+out:
+	return ERR_PTR(err);
+}
+
+struct p4tc_extern_params *
+p4tc_ext_params_copy(struct p4tc_extern_params *params_orig)
+{
+	struct p4tc_extern_param *nparam = NULL;
+	struct p4tc_extern_params *params_copy;
+	const struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+	int err;
+
+	params_copy = p4tc_extern_params_init();
+	if (!params_copy) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	idr_for_each_entry_ul(&params_orig->params_idr, param, tmp, id) {
+		struct p4tc_type *param_type = param->type;
+		u32 alloc_len = BITS_TO_BYTES(param_type->container_bitsz);
+		struct p4tc_type_mask_shift *mask_shift = NULL;
+
+		nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+		if (!nparam) {
+			err = -ENOMEM;
+			goto free_params;
+		}
+		nparam->ops = param->ops;
+		nparam->mod_ops = param->mod_ops;
+		nparam->type = param->type;
+
+		if (param->value) {
+			nparam->value = kzalloc(alloc_len, GFP_KERNEL);
+			if (!nparam->value) {
+				err = -ENOMEM;
+				goto free_param;
+			}
+			memcpy(nparam->value, param->value, alloc_len);
+		}
+
+		if (param_type->ops && param_type->ops->create_bitops) {
+			const u32 bitsz = param->bitsz;
+
+			mask_shift = param_type->ops->create_bitops(bitsz, 0,
+								    bitsz - 1,
+								    NULL);
+			if (IS_ERR(mask_shift)) {
+				err = PTR_ERR(mask_shift);
+				goto free_param_value;
+			}
+			nparam->mask_shift = mask_shift;
+		}
+
+		nparam->id = param->id;
+		err = idr_alloc_u32(&params_copy->params_idr, nparam,
+				    &nparam->id, nparam->id, GFP_KERNEL);
+		if (err < 0)
+			goto free_mask_shift;
+
+		nparam->index = param->index;
+		nparam->bitsz = param->bitsz;
+		nparam->flags = param->flags;
+		strscpy(nparam->name, param->name, EXTPARAMNAMSIZ);
+		params_copy->num_params++;
+	}
+
+	return params_copy;
+
+free_mask_shift:
+	if (nparam->mask_shift)
+		p4t_release(nparam->mask_shift);
+free_param_value:
+	kfree(nparam->value);
+free_param:
+	kfree(nparam);
+free_params:
+	p4tc_ext_params_free(params_copy, true);
+err_out:
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL(p4tc_ext_params_copy);
+
+int p4tc_ext_init_defval_params(struct p4tc_extern_inst *inst,
+				struct p4tc_extern_common *common,
+				struct idr *control_params_idr,
+				struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_params *params = NULL;
+	struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+	int err;
+
+	params = p4tc_extern_params_init();
+	if (!params)
+		return -ENOMEM;
+
+	idr_for_each_entry_ul(control_params_idr, param, tmp, id) {
+		struct p4tc_extern_param *nparam;
+
+		if (param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY)
+			/* Skip key param */
+			continue;
+
+		nparam = p4tc_ext_init_defval_param(param, extack);
+		if (IS_ERR(nparam)) {
+			err = PTR_ERR(nparam);
+			goto free_params;
+		}
+
+		err = idr_alloc_u32(&params->params_idr, nparam, &nparam->id,
+				    nparam->id, GFP_KERNEL);
+		if (err < 0) {
+			kfree(nparam);
+			goto free_params;
+		}
+		params->num_params++;
+	}
+
+	common->params = params;
+	common->inst = inst;
+	common->ops = inst->ops;
+	refcount_set(&common->p4tc_ext_refcnt, 1);
+	if (inst->tbl_bindable)
+		list_add(&common->node, &inst->unused_elems);
+
+	return 0;
+
+free_params:
+	p4tc_ext_params_free(params, true);
+	return err;
+}
+EXPORT_SYMBOL_GPL(p4tc_ext_init_defval_params);
+
+static int p4tc_ext_init_defval(struct p4tc_extern **e,
+				struct p4tc_extern_inst *inst,
+				u32 key, struct netlink_ext_ack *extack)
+{
+	const struct p4tc_extern_ops *e_o = inst->ops;
+	int err;
+
+	if (!inst->is_scalar) {
+		struct p4tc_extern_param *key_param;
+
+		key_param = find_key_param(&inst->params->params_idr);
+		if (!key_param) {
+			NL_SET_ERR_MSG(extack, "Unable to find key param");
+			return -ENOENT;
+		}
+	}
+
+	err = p4tc_ext_idr_create(inst, key, e, e_o, 0);
+	if (err < 0)
+		return err;
+
+	/* We already store it in the IDR, because we arrive here with the
+	 * rtnl_lock, so this code is never accessed concurrently.
+	 */
+	err = idr_alloc_u32(&inst->control_elems_idr, *e, &key,
+			    key, GFP_KERNEL);
+	if (err < 0) {
+		__p4tc_ext_idr_purge(*e);
+		return err;
+	}
+
+	err = p4tc_ext_init_defval_params(inst, &((*e)->common),
+					  &inst->params->params_idr, extack);
+	if (err < 0)
+		goto release_idr;
+
+	return 0;
+
+release_idr:
+	p4tc_ext_idr_release_dec_num_elems(*e);
+
+	return err;
+}
+
+static void p4tc_extern_inst_destroy_elems(struct idr *insts_idr)
+{
+	struct p4tc_extern_inst *inst;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(insts_idr, inst, tmp, id) {
+		unsigned long tmp2, elem_id;
+		struct p4tc_extern *e;
+
+		idr_for_each_entry_ul(&inst->control_elems_idr, e,
+				      tmp2, elem_id) {
+			p4tc_ext_idr_purge(e);
+		}
+	}
+}
+
+static void p4tc_user_pipe_ext_destroy_elems(struct idr *user_ext_idr)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(user_ext_idr, pipe_ext, tmp, id) {
+		if (p4tc_ext_has_construct(pipe_ext->tmpl_ext->ops))
+			continue;
+
+		p4tc_extern_inst_destroy_elems(&pipe_ext->e_inst_idr);
+	}
+}
+
+int p4tc_extern_inst_init_elems(struct p4tc_extern_inst *inst, u32 num_elems)
+{
+	int err = 0;
+	int i;
+
+	for (i = 0; i < num_elems; i++) {
+		struct p4tc_extern *e = NULL;
+
+		err = p4tc_ext_init_defval(&e, inst, i + 1, NULL);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(p4tc_extern_inst_init_elems);
+
+static int
+__p4tc_extern_insts_init_elems(struct idr *insts_idr)
+{
+	struct p4tc_extern_inst *inst;
+	unsigned long tmp, id;
+	int err = 0;
+
+	idr_for_each_entry_ul(insts_idr, inst, tmp, id) {
+		u32 max_num_elems = inst->max_num_elems;
+
+		err = p4tc_extern_inst_init_elems(inst, max_num_elems);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/* Called before sealing the pipeline */
+int p4tc_extern_insts_init_elems(struct idr *user_ext_idr)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	unsigned long tmp, id;
+	int err;
+
+	idr_for_each_entry_ul(user_ext_idr, pipe_ext, tmp, id) {
+		/* We assume the module construct will create the initial elems
+		 * by itself.
+		 * We only initialise when sealing if we don't have construct.
+		 */
+		if (p4tc_ext_has_construct(pipe_ext->tmpl_ext->ops))
+			continue;
+
+		err = __p4tc_extern_insts_init_elems(&pipe_ext->e_inst_idr);
+		if (err < 0)
+			goto destroy_ext_inst_elems;
+	}
+
+	return 0;
+
+destroy_ext_inst_elems:
+	p4tc_user_pipe_ext_destroy_elems(user_ext_idr);
+	return err;
+}
+
+static struct p4tc_extern *
+p4tc_extern_init_1(struct p4tc_pipeline *pipeline,
+		   struct p4tc_extern_inst *inst,
+		   struct nlattr *nla, u32 key, u32 flags,
+		   struct netlink_ext_ack *extack)
+{
+	return p4tc_ext_init(pipeline->net, nla, inst, key,
+			     flags, extack);
+}
+
+static int tce_get_fill(struct sk_buff *skb, struct p4tc_extern *externs[],
+			u32 portid, u32 seq, u16 flags, u32 pipeid, int cmd,
+			int ref, struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlmsghdr *nlh;
+	struct nlattr *nest;
+	struct p4tcmsg *t;
+
+	nlh = nlmsg_put(skb, portid, seq, cmd, sizeof(*t), flags);
+	if (!nlh)
+		goto out_nlmsg_trim;
+	t = nlmsg_data(nlh);
+	t->pipeid = pipeid;
+	t->obj = P4TC_OBJ_RUNTIME_EXTERN;
+
+	nest = nla_nest_start(skb, P4TC_ROOT);
+	if (p4tc_extern_elem_dump(skb, externs, ref) < 0)
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, nest);
+
+	nlh->nlmsg_len = (unsigned char *)nlmsg_get_pos(skb) - b;
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int
+p4tc_extern_get_respond(struct net *net, u32 portid, struct nlmsghdr *n,
+			struct p4tc_extern *externs[], u32 pipeid,
+			size_t attr_size, struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
+			GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+	if (tce_get_fill(skb, externs, portid, n->nlmsg_seq, 0, pipeid,
+			 RTM_P4TC_GET, 1, NULL) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill netlink attributes while adding TC extern");
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return rtnl_unicast(skb, net, portid);
+}
+
+static struct p4tc_extern *
+p4tc_extern_get_1(struct p4tc_extern_inst *inst,
+		  struct nlattr *nla, const char *kind, struct nlmsghdr *n,
+		  u32 key, u32 portid, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern *e;
+	int err;
+
+	if (p4tc_ext_inst_has_rctrl(inst)) {
+		err = inst->ops->rctrl(n->nlmsg_type, inst,
+				       (struct p4tc_extern_common **)&e,
+				       NULL, &key, extack);
+		if (err < 0)
+			return ERR_PTR(err);
+
+		return e;
+	}
+
+	if (__p4tc_ext_idr_search(inst, &e, key) == 0) {
+		err = -ENOENT;
+		NL_SET_ERR_MSG(extack, "TC extern with specified key not found");
+		goto err_out;
+	}
+
+	return e;
+
+err_out:
+	return ERR_PTR(err);
+}
+
+static int
+p4tc_extern_add_notify(struct net *net, struct nlmsghdr *n,
+		       struct p4tc_extern *externs[], u32 portid, u32 pipeid,
+		       size_t attr_size, struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
+			GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
+	if (tce_get_fill(skb, externs, portid, n->nlmsg_seq, n->nlmsg_flags,
+			 pipeid, n->nlmsg_type, 0, extack) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill netlink attributes while adding TC extern");
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
+			      n->nlmsg_flags & NLM_F_ECHO);
+}
+
+static int p4tc_ext_get_key_param(struct p4tc_extern_inst *inst,
+				  struct nlattr *nla,
+				  struct idr *params_idr, u32 *key,
+				  struct netlink_ext_ack *extack)
+{
+	int err = 0;
+
+	if (inst->is_scalar) {
+		if (nla) {
+			err = p4tc_ext_get_key_param_scalar(inst, nla, key,
+							    extack);
+			if (err < 0)
+				return err;
+
+			if (*key != 1) {
+				NL_SET_ERR_MSG(extack,
+					       "Key of scalar must be 1");
+				return -EINVAL;
+			}
+		} else {
+			*key = 1;
+		}
+	} else {
+		if (nla) {
+			err = p4tc_ext_get_nonscalar_key_param(params_idr, nla,
+							       key, extack);
+			if (err < 0)
+				return -EINVAL;
+		}
+
+		if (!key) {
+			NL_SET_ERR_MSG(extack, "Must specify extern key");
+			return -EINVAL;
+		}
+	}
+
+	return err;
+}
+
+static struct p4tc_extern *
+__p4tc_ctl_extern_1(struct p4tc_pipeline *pipeline,
+		    struct nlattr *nla, struct nlmsghdr *n,
+		    u32 portid, u32 flags, bool rctrl_allowed,
+		    struct netlink_ext_ack *extack)
+{
+	const char *kind = p4tc_ext_get_kind(nla, extack);
+	struct nlattr *tb[P4TC_EXT_MAX + 1];
+	struct p4tc_extern_inst *inst;
+	struct nlattr *params_attr;
+	struct p4tc_extern *e;
+	char *instname;
+	u32 key;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_MAX, nla,
+			       p4tc_extern_policy, extack);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	if (IS_ERR(kind))
+		return (struct p4tc_extern *)kind;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_EXT_INST_NAME)) {
+		NL_SET_ERR_MSG(extack,
+			       "TC extern inst name must be specified");
+		return ERR_PTR(-EINVAL);
+	}
+	instname = nla_data(tb[P4TC_EXT_INST_NAME]);
+
+	err = -EINVAL;
+	inst = p4tc_ext_inst_find_bynames(pipeline->net, pipeline, kind,
+					  instname, extack);
+	if (IS_ERR(inst))
+		return (struct p4tc_extern *)inst;
+
+	if (!rctrl_allowed && p4tc_ext_has_rctrl(inst->ops)) {
+		NL_SET_ERR_MSG(extack,
+			       "Runtime message may only have one extern with rctrl op");
+		return ERR_PTR(-EINVAL);
+	}
+
+	err = p4tc_ext_get_key_param(inst, tb[P4TC_EXT_KEY],
+				     &inst->params->params_idr, &key,
+				     extack);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	params_attr = tb[P4TC_EXT_PARAMS];
+
+	switch (n->nlmsg_type) {
+	case RTM_P4TC_CREATE:
+		NL_SET_ERR_MSG(extack,
+			       "Create command is not supported");
+		return ERR_PTR(-EOPNOTSUPP);
+	case RTM_P4TC_UPDATE: {
+		struct nla_bitfield32 userflags = { 0, 0 };
+
+		if (tb[P4TC_EXT_FLAGS])
+			userflags = nla_get_bitfield32(tb[P4TC_EXT_FLAGS]);
+
+		flags = userflags.value | flags;
+		e = p4tc_extern_init_1(pipeline, inst, params_attr, key,
+				       flags, extack);
+		break;
+	}
+	case RTM_P4TC_DEL:
+		NL_SET_ERR_MSG(extack,
+			       "Delete command is not supported");
+		return ERR_PTR(-EOPNOTSUPP);
+	case RTM_P4TC_GET: {
+		e = p4tc_extern_get_1(inst, params_attr, kind, n, key, portid,
+				      extack);
+		break;
+	}
+	default:
+		NL_SET_ERR_MSG_FMT(extack, "Unknown extern command #%u",
+				   n->nlmsg_type);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	return e;
+}
+
+static int __p4tc_ctl_extern(struct p4tc_pipeline *pipeline,
+			     struct nlattr *nla, struct nlmsghdr *n,
+			     u32 portid, u32 flags,
+			     struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern *externs[P4TC_MSGBATCH_SIZE] = {};
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	bool processed_rctrl_extern = false;
+	struct p4tc_extern *ext;
+	size_t attr_size = 0;
+	bool has_one_element;
+	int i, ret;
+
+	ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL,
+			       extack);
+	if (ret < 0)
+		return ret;
+
+	/* We only allow 1 batched element in case the extern has an rctrl
+	 * callback.
+	 */
+	has_one_element = !tb[2];
+	ext = __p4tc_ctl_extern_1(pipeline, tb[1], n, portid,
+				  flags, has_one_element, extack);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	externs[0] = ext;
+	if (p4tc_ext_has_rctrl(ext->common.ops)) {
+		processed_rctrl_extern = true;
+		goto notify;
+	} else {
+		attr_size += ext->attrs_size;
+	}
+
+	for (i = 2; i <= P4TC_MSGBATCH_SIZE && tb[i]; i++) {
+		ext = __p4tc_ctl_extern_1(pipeline, tb[i], n, portid,
+					  flags, false, extack);
+		if (IS_ERR(ext)) {
+			ret = PTR_ERR(ext);
+			goto err;
+		}
+
+		attr_size += ext->attrs_size;
+		/* Only add to externs array, extern modules that don't
+		 * implement rctrl callback.
+		 */
+		externs[i - 1] = ext;
+	}
+
+notify:
+	attr_size = p4tc_extern_full_attrs_size(attr_size);
+
+	if (n->nlmsg_type == RTM_P4TC_UPDATE) {
+		int listeners = rtnl_has_listeners(pipeline->net, RTNLGRP_TC);
+		int echo = n->nlmsg_flags & NLM_F_ECHO;
+
+		if (!processed_rctrl_extern)
+			p4tc_ext_idr_insert_many(externs);
+
+		if (echo || listeners)
+			p4tc_extern_add_notify(pipeline->net, n, externs,
+					       portid, pipeline->common.p_id,
+					       attr_size, extack);
+	} else if (n->nlmsg_type == RTM_P4TC_GET) {
+		p4tc_extern_get_respond(pipeline->net, portid, n, externs,
+					pipeline->common.p_id, attr_size,
+					extack);
+	}
+
+	return 0;
+
+err:
+	if (n->nlmsg_type == RTM_P4TC_UPDATE)
+		p4tc_extern_destroy(externs);
+	else if (n->nlmsg_type == RTM_P4TC_GET)
+		p4tc_extern_put_many(externs);
+
+	return ret;
+}
+
+static int parse_dump_ext_attrs(struct nlattr *nla,
+				struct nlattr **tb2)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+
+	if (nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL,
+			     NULL) < 0)
+		return -EINVAL;
+
+	if (!tb[1])
+		return -EINVAL;
+	if (nla_parse_nested(tb2, P4TC_EXT_MAX, tb[1],
+			     p4tc_extern_policy, NULL) < 0)
+		return -EINVAL;
+
+	if (!tb2[P4TC_EXT_KIND])
+		return -EINVAL;
+
+	if (!tb2[P4TC_EXT_INST_NAME])
+		return -EINVAL;
+
+	return 0;
+}
+
+int p4tc_ctl_extern_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			 struct nlattr **tb, const char *pname)
+{
+	struct netlink_ext_ack *extack = cb->extack;
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *tb2[P4TC_EXT_MAX + 1];
+	struct net *net = sock_net(skb->sk);
+	struct nlattr *count_attr = NULL;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_inst *inst;
+	char *kind_str, *instname;
+	struct nla_bitfield32 bf;
+	struct nlmsghdr *nlh;
+	struct nlattr *nest;
+	u32 ext_count = 0;
+	struct p4tcmsg *t;
+	int ret = 0;
+
+	pipeline = p4tc_pipeline_find_byany(net, pname, 0, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (!pipeline_sealed(pipeline)) {
+		NL_SET_ERR_MSG(extack,
+			       "Pipeline must be sealed for extern runtime ops");
+		return -EINVAL;
+	}
+
+	ret = parse_dump_ext_attrs(tb[P4TC_ROOT], tb2);
+	if (ret < 0)
+		return ret;
+
+	kind_str = nla_data(tb2[P4TC_EXT_KIND]);
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_EXT_KIND)) {
+		NL_SET_ERR_MSG(extack,
+			       "TC extern kind name must be specified");
+		return -EINVAL;
+	}
+
+	instname = nla_data(tb2[P4TC_EXT_INST_NAME]);
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_EXT_INST_NAME)) {
+		NL_SET_ERR_MSG(extack,
+			       "TC extern inst name must be specified");
+		return -EINVAL;
+	}
+
+	inst = p4tc_ext_inst_find_bynames(pipeline->net, pipeline, kind_str,
+					  instname, extack);
+	if (IS_ERR(inst))
+		return PTR_ERR(inst);
+
+	cb->args[2] = 0;
+	if (tb[P4TC_ROOT_FLAGS]) {
+		bf = nla_get_bitfield32(tb[P4TC_ROOT_FLAGS]);
+		cb->args[2] = bf.value;
+	}
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			cb->nlh->nlmsg_type, sizeof(*t), 0);
+	if (!nlh)
+		goto err_out;
+
+	t = nlmsg_data(nlh);
+	t->pipeid = pipeline->common.p_id;
+	t->obj = P4TC_OBJ_RUNTIME_EXTERN;
+	count_attr = nla_reserve(skb, P4TC_ROOT_COUNT, sizeof(u32));
+	if (!count_attr)
+		goto err_out;
+
+	nest = nla_nest_start_noflag(skb, P4TC_ROOT);
+	if (!nest)
+		goto err_out;
+
+	ret = p4tc_ext_dump_walker(inst, skb, cb);
+	if (ret < 0)
+		goto err_out;
+
+	if (ret > 0) {
+		nla_nest_end(skb, nest);
+		ret = skb->len;
+		ext_count = cb->args[1];
+		memcpy(nla_data(count_attr), &ext_count, sizeof(u32));
+		cb->args[1] = 0;
+	} else {
+		nlmsg_trim(skb, b);
+	}
+
+	nlh->nlmsg_len = (unsigned char *)nlmsg_get_pos(skb) - b;
+	if (NETLINK_CB(cb->skb).portid && ret)
+		nlh->nlmsg_flags |= NLM_F_MULTI;
+	return skb->len;
+
+err_out:
+	nlmsg_trim(skb, b);
+	return skb->len;
+}
+
+int p4tc_ctl_extern(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
+		    struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	struct net *net = sock_net(skb->sk);
+	u32 portid = NETLINK_CB(skb).portid;
+	struct p4tc_pipeline *pipeline;
+	struct nlattr *root;
+	char *pname = NULL;
+	u32 flags = 0;
+	int ret = 0;
+
+	if (cmd != RTM_P4TC_GET && !netlink_capable(skb, CAP_NET_ADMIN)) {
+		NL_SET_ERR_MSG(extack, "Need CAP_NET_ADMIN to do CRU ops");
+		return -EPERM;
+	}
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (tb[P4TC_ROOT_PNAME])
+		pname = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack, "Netlink P4TC extern attributes missing");
+		return -EINVAL;
+	}
+
+	root = tb[P4TC_ROOT];
+
+	pipeline = p4tc_pipeline_find_byany(net, pname, 0, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (!pipeline_sealed(pipeline)) {
+		NL_SET_ERR_MSG(extack,
+			       "Pipeline must be sealed for extern runtime ops");
+		return -EPERM;
+	}
+
+	return __p4tc_ctl_extern(pipeline, root, n, portid, flags, extack);
+}
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 6c00747ac..c61115f78 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -27,6 +27,7 @@
 #include <net/netlink.h>
 #include <net/flow_offload.h>
 #include <net/p4tc_types.h>
+#include <net/p4tc_ext_api.h>
 
 static unsigned int pipeline_net_id;
 static struct p4tc_pipeline *root_pipeline;
@@ -99,6 +100,7 @@ static void __net_exit pipeline_exit_net(struct net *net)
 		__p4tc_pipeline_put(pipeline, &pipeline->common, NULL);
 	}
 	idr_destroy(&pipe_net->pipeline_idr);
+
 	rtnl_unlock();
 }
 
@@ -119,6 +121,7 @@ static void p4tc_pipeline_destroy(struct p4tc_pipeline *pipeline)
 {
 	idr_destroy(&pipeline->p_act_idr);
 	idr_destroy(&pipeline->p_tbl_idr);
+	idr_destroy(&pipeline->user_ext_idr);
 
 	kfree(pipeline);
 }
@@ -141,7 +144,8 @@ static void p4tc_pipeline_teardown(struct p4tc_pipeline *pipeline,
 	struct net *net = pipeline->net;
 	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
 	struct net *pipeline_net = maybe_get_net(net);
-	unsigned long iter_act_id, tmp;
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	unsigned long iter_act_id, ext_id, tmp;
 	struct p4tc_table *table;
 	struct p4tc_act *act;
 	unsigned long tbl_id;
@@ -152,6 +156,20 @@ static void p4tc_pipeline_teardown(struct p4tc_pipeline *pipeline,
 	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, iter_act_id)
 		act->common.ops->put(pipeline, &act->common, extack);
 
+	idr_for_each_entry_ul(&pipeline->user_ext_idr, pipe_ext, tmp, ext_id) {
+		unsigned long tmp_in, inst_id;
+		struct p4tc_extern_inst *inst;
+
+		idr_for_each_entry_ul(&pipe_ext->e_inst_idr, inst, tmp_in,
+				      inst_id) {
+			struct p4tc_template_common *common = &inst->common;
+
+			common->ops->put(pipeline, common, extack);
+		}
+
+		pipe_ext->free(pipe_ext, &pipeline->user_ext_idr);
+	}
+
 	/* If we are on netns cleanup we can't touch the pipeline_idr.
 	 * On pre_exit we will destroy the idr but never call into teardown
 	 * if filters are active which makes pipeline pointers dangle until
@@ -210,9 +228,18 @@ static int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
 	if (ret < 0)
 		return ret;
 
+	ret = p4tc_extern_insts_init_elems(&pipeline->user_ext_idr);
+	if (ret < 0)
+		goto unset_table_state_ready;
+
 	pipeline->p_state = P4TC_STATE_READY;
 
 	return true;
+
+unset_table_state_ready:
+	p4tc_table_put_mask_array(pipeline);
+
+	return ret;
 }
 
 struct p4tc_pipeline *p4tc_pipeline_find_byid(struct net *net, const u32 pipeid)
@@ -308,6 +335,9 @@ static struct p4tc_pipeline *p4tc_pipeline_create(struct net *net,
 
 	idr_init(&pipeline->p_tbl_idr);
 	pipeline->curr_tables = 0;
+	idr_init(&pipeline->p_tbl_idr);
+
+	idr_init(&pipeline->user_ext_idr);
 
 	pipeline->num_created_acts = 0;
 
@@ -645,6 +675,8 @@ static void __p4tc_pipeline_init(void)
 
 	strscpy(root_pipeline->common.name, "kernel", PIPELINENAMSIZ);
 
+	idr_init(&root_pipeline->p_ext_idr);
+
 	root_pipeline->common.ops =
 		(struct p4tc_template_ops *)&p4tc_pipeline_ops;
 
diff --git a/net/sched/p4tc/p4tc_runtime_api.c b/net/sched/p4tc/p4tc_runtime_api.c
index bcb280909..f085d1b2a 100644
--- a/net/sched/p4tc/p4tc_runtime_api.c
+++ b/net/sched/p4tc/p4tc_runtime_api.c
@@ -27,16 +27,17 @@
 #include <net/p4tc.h>
 #include <net/netlink.h>
 #include <net/flow_offload.h>
+#include <net/p4tc_ext_api.h>
 
 static int tc_ctl_p4_root(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
 			  struct netlink_ext_ack *extack)
 {
 	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	int ret;
 
 	switch (t->obj) {
 	case P4TC_OBJ_RUNTIME_TABLE: {
 		struct net *net = sock_net(skb->sk);
-		int ret;
 
 		net = maybe_get_net(net);
 		if (!net) {
@@ -50,6 +51,11 @@ static int tc_ctl_p4_root(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
 
 		return ret;
 	}
+	case P4TC_OBJ_RUNTIME_EXTERN:
+		rtnl_lock();
+		ret = p4tc_ctl_extern(skb, n, cmd, extack);
+		rtnl_unlock();
+		return ret;
 	default:
 		NL_SET_ERR_MSG(extack, "Unknown P4 runtime object type");
 		return -EOPNOTSUPP;
@@ -120,6 +126,8 @@ static int tc_ctl_p4_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	case P4TC_OBJ_RUNTIME_TABLE:
 		return p4tc_tbl_entry_dumpit(sock_net(skb->sk), skb, cb,
 					     tb[P4TC_ROOT], p_name);
+	case P4TC_OBJ_RUNTIME_EXTERN:
+		return p4tc_ctl_extern_dump(skb, cb, tb, p_name);
 	default:
 		NL_SET_ERR_MSG_FMT(cb->extack,
 				   "Unknown p4 runtime object type %u\n",
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index 7d79b01e5..534b972b9 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -114,6 +114,10 @@ static const struct nla_policy p4tc_table_policy[P4TC_TABLE_MAX + 1] = {
 	[P4TC_TABLE_DEFAULT_MISS] = { .type = NLA_NESTED },
 	[P4TC_TABLE_ACTS_LIST] = { .type = NLA_NESTED },
 	[P4TC_TABLE_CONST_ENTRY] = { .type = NLA_NESTED },
+	[P4TC_TABLE_COUNTER] = {
+		.type = NLA_STRING,
+		.len = EXTERNINSTNAMSIZ * 2 + 1
+	},
 };
 
 static int _p4tc_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
@@ -146,6 +150,12 @@ static int _p4tc_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
 	parm.tbl_aging = table->tbl_aging;
 	parm.tbl_num_entries = atomic_read(&table->tbl_nelems);
 
+	if (table->tbl_counter) {
+		if (nla_put_string(skb, P4TC_TABLE_COUNTER,
+				   table->tbl_counter->common.name) < 0)
+			goto out_nlmsg_trim;
+	}
+
 	tbl_perm = rcu_dereference_rtnl(table->tbl_permissions);
 	parm.tbl_permissions = tbl_perm->permissions;
 
@@ -914,7 +924,9 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 {
 	struct rhashtable_params table_hlt_params = entry_hlt_params;
 	struct p4tc_table_default_act_params def_params = {0};
+	struct p4tc_user_pipeline_extern *pipe_ext = NULL;
 	struct p4tc_table_perm *tbl_init_perms = NULL;
+	struct p4tc_extern_inst *inst = NULL;
 	struct p4tc_table_parm *parm;
 	struct p4tc_table *table;
 	char *tblname;
@@ -1077,13 +1089,25 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 
 	refcount_set(&table->tbl_ctrl_ref, 1);
 
+	if (tb[P4TC_TABLE_COUNTER]) {
+		const char *ext_inst_path = nla_data(tb[P4TC_TABLE_COUNTER]);
+
+		inst = p4tc_ext_inst_table_bind(pipeline, &pipe_ext,
+						ext_inst_path, extack);
+		if (IS_ERR(inst)) {
+			ret = PTR_ERR(inst);
+			goto free_permissions;
+		}
+		table->tbl_counter = inst;
+	}
+
 	if (tbl_id) {
 		table->tbl_id = tbl_id;
 		ret = idr_alloc_u32(&pipeline->p_tbl_idr, table, &table->tbl_id,
 				    table->tbl_id, GFP_KERNEL);
 		if (ret < 0) {
 			NL_SET_ERR_MSG(extack, "Unable to allocate table id");
-			goto free_permissions;
+			goto put_inst;
 		}
 	} else {
 		table->tbl_id = 1;
@@ -1091,7 +1115,7 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 				    UINT_MAX, GFP_KERNEL);
 		if (ret < 0) {
 			NL_SET_ERR_MSG(extack, "Unable to allocate table id");
-			goto free_permissions;
+			goto put_inst;
 		}
 	}
 
@@ -1169,11 +1193,15 @@ static struct p4tc_table *p4tc_table_create(struct net *net, struct nlattr **tb,
 idr_rm:
 	idr_remove(&pipeline->p_tbl_idr, table->tbl_id);
 
+	p4tc_table_acts_list_destroy(&table->tbl_acts_list);
+
+put_inst:
+	if (inst)
+		p4tc_ext_inst_table_unbind(table, pipe_ext, inst);
+
 free_permissions:
 	kfree(tbl_init_perms);
 
-	p4tc_table_acts_list_destroy(&table->tbl_acts_list);
-
 free:
 	kfree(table);
 
@@ -1189,7 +1217,9 @@ static struct p4tc_table *p4tc_table_update(struct net *net, struct nlattr **tb,
 {
 	u32 tbl_max_masks = 0, tbl_max_entries = 0, tbl_keysz = 0;
 	struct p4tc_table_default_act_params def_params = {0};
+	struct p4tc_user_pipeline_extern *pipe_ext = NULL;
 	struct list_head *tbl_acts_list = NULL;
+	struct p4tc_extern_inst *inst = NULL;
 	struct p4tc_table_perm *perm = NULL;
 	struct p4tc_table_parm *parm = NULL;
 	struct p4tc_table *table;
@@ -1315,6 +1345,17 @@ static struct p4tc_table *p4tc_table_update(struct net *net, struct nlattr **tb,
 		}
 	}
 
+	if (tb[P4TC_TABLE_COUNTER]) {
+		const char *ext_inst_path = nla_data(tb[P4TC_TABLE_COUNTER]);
+
+		inst = p4tc_ext_inst_table_bind(pipeline, &pipe_ext,
+						ext_inst_path, extack);
+		if (IS_ERR(inst)) {
+			ret = PTR_ERR(inst);
+			goto free_perm;
+		}
+	}
+
 	if (tb[P4TC_TABLE_CONST_ENTRY]) {
 		struct p4tc_table_entry *entry;
 
@@ -1324,7 +1365,7 @@ static struct p4tc_table *p4tc_table_update(struct net *net, struct nlattr **tb,
 						  pipeline, table, extack);
 		if (IS_ERR(entry)) {
 			ret = PTR_ERR(entry);
-			goto free_perm;
+			goto put_inst;
 		}
 
 		table->tbl_const_entry = entry;
@@ -1342,6 +1383,8 @@ static struct p4tc_table *p4tc_table_update(struct net *net, struct nlattr **tb,
 	table->tbl_type = tbl_type;
 	if (tbl_aging)
 		table->tbl_aging = tbl_aging;
+	if (inst)
+		table->tbl_counter = inst;
 
 	if (tbl_acts_list)
 		p4tc_table_acts_list_replace(&table->tbl_acts_list,
@@ -1349,6 +1392,10 @@ static struct p4tc_table *p4tc_table_update(struct net *net, struct nlattr **tb,
 
 	return table;
 
+put_inst:
+	if (inst)
+		p4tc_ext_inst_table_unbind(table, pipe_ext, inst);
+
 free_perm:
 	kfree(perm);
 
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index c6953199d..f90b6c66f 100644
--- a/net/sched/p4tc/p4tc_tbl_entry.c
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -27,6 +27,7 @@
 #include <net/p4tc.h>
 #include <net/netlink.h>
 #include <net/flow_offload.h>
+#include <net/p4tc_ext_api.h>
 
 #define SIZEOF_MASKID (sizeof(((struct p4tc_table_entry_key *)0)->maskid))
 
@@ -324,6 +325,7 @@ int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
 	struct p4tc_table_entry_tm dtm, *tm;
 	struct nlattr *nest, *nest_acts;
 	u32 ids[P4TC_ENTRY_MAX_IDS];
+	struct nlattr *nest_counter;
 	int ret = -ENOMEM;
 
 	ids[P4TC_TBLID_IDX - 1] = tbl_id;
@@ -385,6 +387,11 @@ int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
 				      P4TC_ENTRY_PAD))
 			goto out_nlmsg_trim;
 	}
+	if (value->counter) {
+		nest_counter = nla_nest_start(skb, P4TC_ENTRY_COUNTER);
+		p4tc_ext_elem_dump_1(skb, value->counter);
+		nla_nest_end(skb, nest_counter);
+	}
 
 	nla_nest_end(skb, nest);
 
@@ -1568,11 +1575,20 @@ __must_hold(RCU)
 		goto free_work;
 	}
 
+	if (table->tbl_counter) {
+		value->counter = p4tc_ext_elem_get(table->tbl_counter);
+		if (!value->counter) {
+			atomic_dec(&table->tbl_nelems);
+			ret = -ENOENT;
+			goto free_work;
+		}
+	}
+
 	if (rhltable_insert(&table->tbl_entries, &entry->ht_node,
 			    entry_hlt_params) < 0) {
 		atomic_dec(&table->tbl_nelems);
 		ret = -EBUSY;
-		goto free_work;
+		goto put_ext;
 	}
 
 	if (value->is_dyn) {
@@ -1592,6 +1608,10 @@ __must_hold(RCU)
 
 	return 0;
 
+put_ext:
+	if (table->tbl_counter && value->counter)
+		p4tc_ext_elem_put_list(table->tbl_counter, value->counter);
+
 free_work:
 	kfree(entry_work);
 
@@ -1820,6 +1840,9 @@ __must_hold(RCU)
 			      HRTIMER_MODE_REL);
 	}
 
+	if (value_old->counter)
+		value->counter = value_old->counter;
+
 	INIT_WORK(&entry_work->work, p4tc_table_entry_del_work);
 
 	if (rhltable_insert(&table->tbl_entries, &entry->ht_node,
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index a3b3b1430..55a738d1b 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -44,6 +44,8 @@ static bool obj_is_valid(u32 obj)
 	case P4TC_OBJ_PIPELINE:
 	case P4TC_OBJ_ACT:
 	case P4TC_OBJ_TABLE:
+	case P4TC_OBJ_EXT:
+	case P4TC_OBJ_EXT_INST:
 		return true;
 	default:
 		return false;
@@ -54,6 +56,8 @@ static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX + 1] = {
 	[P4TC_OBJ_PIPELINE] = &p4tc_pipeline_ops,
 	[P4TC_OBJ_ACT] = &p4tc_act_ops,
 	[P4TC_OBJ_TABLE] = &p4tc_table_ops,
+	[P4TC_OBJ_EXT] = &p4tc_tmpl_ext_ops,
+	[P4TC_OBJ_EXT_INST] = &p4tc_ext_inst_ops,
 };
 
 int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
diff --git a/net/sched/p4tc/p4tc_tmpl_ext.c b/net/sched/p4tc/p4tc_tmpl_ext.c
new file mode 100644
index 000000000..ec3efbc68
--- /dev/null
+++ b/net/sched/p4tc/p4tc_tmpl_ext.c
@@ -0,0 +1,2221 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_tmpl_extern.c	P4 TC EXTERN TEMPLATE
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
+#include <linux/err.h>
+#include <linux/module.h>
+#include <net/net_namespace.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+#include <net/p4tc_types.h>
+#include <net/sock.h>
+#include <net/p4tc_ext_api.h>
+
+static LIST_HEAD(ext_base);
+static DEFINE_RWLOCK(ext_mod_lock);
+
+static const struct nla_policy tc_extern_inst_policy[P4TC_TMPL_EXT_INST_MAX + 1] = {
+	[P4TC_TMPL_EXT_INST_EXT_NAME] = {
+		.type = NLA_STRING,
+		.len =  EXTERNNAMSIZ
+	},
+	[P4TC_TMPL_EXT_INST_NAME] = {
+		.type = NLA_STRING,
+		.len =  EXTERNINSTNAMSIZ
+	},
+	[P4TC_TMPL_EXT_INST_NUM_ELEMS] = NLA_POLICY_RANGE(NLA_U32, 1,
+							  P4TC_MAX_NUM_EXT_INST_ELEMS),
+	[P4TC_TMPL_EXT_INST_CONTROL_PARAMS] = { .type = NLA_NESTED },
+	[P4TC_TMPL_EXT_INST_TABLE_BINDABLE] = { . type = NLA_U8 },
+	[P4TC_TMPL_EXT_INST_CONSTR_PARAMS] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy tc_extern_policy[P4TC_TMPL_EXT_MAX + 1] = {
+	[P4TC_TMPL_EXT_NAME] = { .type = NLA_STRING, .len =  EXTERNNAMSIZ },
+	[P4TC_TMPL_EXT_NUM_INSTS] = NLA_POLICY_RANGE(NLA_U16, 1,
+						     P4TC_MAX_NUM_EXT_INSTS),
+	[P4TC_TMPL_EXT_HAS_EXEC_METHOD] = NLA_POLICY_RANGE(NLA_U8, 1, 1),
+};
+
+static const struct nla_policy p4tc_extern_params_policy[P4TC_EXT_PARAMS_MAX + 1] = {
+	[P4TC_EXT_PARAMS_NAME] = { .type = NLA_STRING, .len = EXTPARAMNAMSIZ },
+	[P4TC_EXT_PARAMS_ID] = { .type = NLA_U32 },
+	[P4TC_EXT_PARAMS_VALUE] = { .type = NLA_NESTED },
+	[P4TC_EXT_PARAMS_TYPE] = { .type = NLA_U32 },
+	[P4TC_EXT_PARAMS_BITSZ] = { .type = NLA_U16 },
+	[P4TC_EXT_PARAMS_FLAGS] = { .type = NLA_U8 },
+};
+
+static void p4tc_extern_ops_put(const struct p4tc_extern_ops *ops)
+{
+	if (ops)
+		module_put(ops->owner);
+}
+
+static bool
+p4tc_extern_mod_callbacks_check(const struct p4tc_extern_ops *ext)
+{
+	if ((ext->construct || ext->deconstruct) && !(ext->rctrl || ext->dump))
+		return (ext->construct && ext->deconstruct);
+
+	if (ext->rctrl || ext->dump)
+		return (ext->construct && ext->deconstruct && ext->rctrl &&
+			ext->dump);
+
+	return true;
+}
+
+static struct p4tc_extern_ops *p4tc_extern_lookup_n(char *kind)
+{
+	struct p4tc_extern_ops *a = NULL;
+
+	read_lock(&ext_mod_lock);
+	list_for_each_entry(a, &ext_base, head) {
+		if (strcmp(kind, a->kind) == 0) {
+			read_unlock(&ext_mod_lock);
+			return a;
+		}
+	}
+	read_unlock(&ext_mod_lock);
+
+	return NULL;
+}
+
+static int
+p4tc_extern_mod_name(char *mod_name, char *kind)
+{
+	int nbytes;
+
+	nbytes = snprintf(mod_name, EXTERNNAMSIZ, "ext_%s", kind);
+	/* Extern name was too long */
+	if (nbytes == EXTERNNAMSIZ)
+		return -E2BIG;
+
+	return 0;
+}
+
+static struct p4tc_extern_ops *p4tc_extern_ops_load(char *kind)
+{
+	struct p4tc_extern_ops *ops = NULL;
+	char mod_name[EXTERNNAMSIZ] = {0};
+	int err;
+
+	if (!kind)
+		return NULL;
+
+	err = p4tc_extern_mod_name(mod_name, kind);
+	if (err < 0)
+		return NULL;
+
+	ops = p4tc_extern_lookup_n(mod_name);
+	if (ops && try_module_get(ops->owner))
+		return ops;
+
+	if (!ops) {
+		rtnl_unlock();
+		request_module(mod_name);
+		rtnl_lock();
+
+		ops = p4tc_extern_lookup_n(mod_name);
+		if (ops) {
+			if (try_module_get(ops->owner))
+				return ops;
+
+			return NULL;
+		}
+	}
+
+	return ops;
+}
+
+static void p4tc_extern_put_param(struct p4tc_extern_param *param)
+{
+	if (param->mask_shift)
+		p4t_release(param->mask_shift);
+	if (param->value)
+		p4tc_ext_param_value_free_tmpl(param);
+	kfree(param);
+}
+
+static void p4tc_extern_put_param_idr(struct idr *params_idr,
+				      struct p4tc_extern_param *param)
+{
+	idr_remove(params_idr, param->id);
+	p4tc_extern_put_param(param);
+}
+
+static void
+p4tc_user_pipeline_ext_put_ref(struct p4tc_user_pipeline_extern *pipe_ext)
+{
+	refcount_dec(&pipe_ext->ext_ref);
+}
+
+static void
+p4tc_user_pipeline_ext_free(struct p4tc_user_pipeline_extern *pipe_ext,
+			    struct idr *tmpl_exts_idr)
+{
+	idr_remove(tmpl_exts_idr, pipe_ext->ext_id);
+	idr_destroy(&pipe_ext->e_inst_idr);
+	refcount_dec(&pipe_ext->tmpl_ext->tmpl_ref);
+	kfree(pipe_ext);
+}
+
+static void
+p4tc_user_pipeline_ext_put(struct p4tc_pipeline *pipeline,
+			   struct p4tc_user_pipeline_extern *pipe_ext,
+			   bool release, struct idr *tmpl_exts_idr)
+{
+	if (refcount_dec_and_test(&pipe_ext->ext_ref) && release)
+		p4tc_user_pipeline_ext_free(pipe_ext, tmpl_exts_idr);
+}
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_byid(struct p4tc_pipeline *pipeline,
+				 const u32 ext_id)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+
+	pipe_ext = idr_find(&pipeline->user_ext_idr, ext_id);
+
+	return pipe_ext;
+}
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_get(struct p4tc_pipeline *pipeline, const u32 ext_id)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byid(pipeline, ext_id);
+	if (!pipe_ext)
+		return ERR_PTR(-ENOENT);
+
+	refcount_inc(&pipe_ext->ext_ref);
+
+	return pipe_ext;
+}
+
+void p4tc_ext_inst_purge(struct p4tc_extern_inst *inst)
+{
+	p4tc_ext_purge(&inst->control_elems_idr);
+}
+EXPORT_SYMBOL_GPL(p4tc_ext_inst_purge);
+
+static void ___p4tc_ext_inst_put(struct p4tc_extern_inst *inst, bool put_params)
+{
+	if (p4tc_ext_inst_has_construct(inst)) {
+		inst->ops->deconstruct(inst);
+	} else {
+		if (inst->params && put_params)
+			p4tc_ext_params_free(inst->params, true);
+
+		p4tc_ext_inst_purge(inst);
+		kfree(inst);
+	}
+}
+
+static int __p4tc_ext_inst_put(struct p4tc_pipeline *pipeline,
+			       struct p4tc_extern_inst *inst, bool teardown,
+			       bool release, struct netlink_ext_ack *extack)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext = inst->pipe_ext;
+	const u32 inst_id = inst->ext_inst_id;
+
+	if (!teardown && !refcount_dec_if_one(&inst->inst_ref)) {
+		NL_SET_ERR_MSG(extack,
+			       "Can't delete referenced extern instance template");
+		return -EBUSY;
+	}
+
+	___p4tc_ext_inst_put(inst, true);
+
+	idr_remove(&pipe_ext->e_inst_idr, inst_id);
+
+	p4tc_user_pipeline_ext_put(pipeline, pipe_ext, release,
+				   &pipeline->user_ext_idr);
+
+	return 0;
+}
+
+static int _p4tc_tmpl_ext_put(struct p4tc_pipeline *pipeline,
+			      struct p4tc_tmpl_extern *ext, bool teardown,
+			      struct netlink_ext_ack *extack)
+{
+	if (!teardown && !refcount_dec_if_one(&ext->tmpl_ref)) {
+		NL_SET_ERR_MSG(extack,
+			       "Can't delete referenced extern template");
+		return -EBUSY;
+	}
+
+	idr_remove(&pipeline->p_ext_idr, ext->ext_id);
+	p4tc_extern_ops_put(ext->ops);
+
+	kfree(ext);
+
+	return 0;
+}
+
+static int p4tc_tmpl_ext_put(struct p4tc_pipeline *pipeline,
+			     struct p4tc_template_common *tmpl,
+			     struct netlink_ext_ack *extack)
+{
+	struct p4tc_tmpl_extern *ext;
+
+	ext = to_extern(tmpl);
+
+	return _p4tc_tmpl_ext_put(pipeline, ext, true, extack);
+}
+
+struct p4tc_extern_inst *
+p4tc_ext_inst_alloc(const struct p4tc_extern_ops *ops, const u32 max_num_elems,
+		    bool tbl_bindable, char *ext_name)
+{
+	struct p4tc_extern_inst *inst;
+	const u32 inst_size = (ops && ops->size) ? ops->size : sizeof(*inst);
+
+	inst = kzalloc(inst_size, GFP_KERNEL);
+	if (!inst)
+		return ERR_PTR(-ENOMEM);
+
+	inst->ops = ops;
+	inst->max_num_elems = max_num_elems;
+	refcount_set(&inst->inst_ref, 1);
+	INIT_LIST_HEAD(&inst->unused_elems);
+	spin_lock_init(&inst->available_list_lock);
+	atomic_set(&inst->curr_num_elems, 0);
+	idr_init(&inst->control_elems_idr);
+	inst->ext_name = ext_name;
+	inst->tbl_bindable = tbl_bindable;
+
+	inst->common.ops = (typeof(inst->common.ops))&p4tc_ext_inst_ops;
+
+	return inst;
+}
+EXPORT_SYMBOL(p4tc_ext_inst_alloc);
+
+static int p4tc_ext_inst_put(struct p4tc_pipeline *pipeline,
+			     struct p4tc_template_common *tmpl,
+			     struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_inst *inst;
+
+	inst = to_extern_inst(tmpl);
+
+	return __p4tc_ext_inst_put(pipeline, inst, true, false, extack);
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_find_byname(struct p4tc_user_pipeline_extern *pipe_ext,
+			  const char *instname)
+{
+	struct p4tc_extern_inst *ext_inst;
+	unsigned long tmp, inst_id;
+
+	idr_for_each_entry_ul(&pipe_ext->e_inst_idr, ext_inst, tmp, inst_id) {
+		if (strncmp(ext_inst->common.name, instname,
+			    EXTERNINSTNAMSIZ) == 0)
+			return ext_inst;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_find_byid(struct p4tc_user_pipeline_extern *pipe_ext,
+			const u32 inst_id)
+{
+	struct p4tc_extern_inst *ext_inst;
+
+	ext_inst = idr_find(&pipe_ext->e_inst_idr, inst_id);
+
+	return ext_inst;
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_find_byany(struct p4tc_user_pipeline_extern *pipe_ext,
+			 const char *instname, u32 instid,
+			 struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_inst *inst;
+	int err;
+
+	if (instid) {
+		inst = p4tc_ext_inst_find_byid(pipe_ext, instid);
+		if (!inst) {
+			NL_SET_ERR_MSG(extack, "Unable to find instance by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (instname) {
+			inst = p4tc_ext_inst_find_byname(pipe_ext, instname);
+			if (!inst) {
+				NL_SET_ERR_MSG_FMT(extack,
+						   "Instance name not found %s\n",
+						   instname);
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify instance name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return inst;
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_get(struct p4tc_user_pipeline_extern *pipe_ext,
+		  const char *instname, const u32 ext_inst_id,
+		  struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_inst *ext_inst;
+
+	ext_inst = p4tc_ext_inst_find_byany(pipe_ext, instname, ext_inst_id,
+					    extack);
+	if (IS_ERR(ext_inst))
+		return ext_inst;
+
+	/* Extern instance template was deleted in parallel */
+	if (!refcount_inc_not_zero(&ext_inst->inst_ref))
+		return ERR_PTR(-EBUSY);
+
+	return ext_inst;
+}
+
+static void p4tc_ext_inst_put_ref(struct p4tc_extern_inst *inst)
+{
+	refcount_dec(&inst->inst_ref);
+}
+
+static struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_find_name(struct p4tc_pipeline *pipeline, const char *extern_name)
+{
+	struct p4tc_tmpl_extern *ext;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&pipeline->p_ext_idr, ext, tmp, id)
+		if (ext->common.name[0] &&
+		    strncmp(ext->common.name, extern_name,
+			    EXTERNNAMSIZ) == 0)
+			return ext;
+
+	return NULL;
+}
+
+static struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_find_byid(struct p4tc_pipeline *pipeline, const u32 ext_id)
+{
+	return idr_find(&pipeline->p_ext_idr, ext_id);
+}
+
+static struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_find_byany(struct p4tc_pipeline *pipeline,
+			 const char *extern_name, u32 ext_id,
+			 struct netlink_ext_ack *extack)
+{
+	struct p4tc_tmpl_extern *ext;
+	int err;
+
+	if (ext_id) {
+		ext = p4tc_tmpl_ext_find_byid(pipeline, ext_id);
+		if (!ext) {
+			NL_SET_ERR_MSG(extack, "Unable to find ext by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (extern_name) {
+			ext = p4tc_tmpl_ext_find_name(pipeline, extern_name);
+			if (!ext) {
+				NL_SET_ERR_MSG(extack,
+					       "Extern name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify ext name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return ext;
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_find_byanyattr(struct p4tc_user_pipeline_extern *pipe_ext,
+			     struct nlattr *name_attr, u32 instid,
+			     struct netlink_ext_ack *extack)
+{
+	char *instname = NULL;
+
+	if (name_attr)
+		instname = nla_data(name_attr);
+
+	return p4tc_ext_inst_find_byany(pipe_ext, instname, instid,
+					extack);
+}
+
+static struct p4tc_extern_param *
+p4tc_ext_param_find_byname(struct idr *params_idr, const char *param_name)
+{
+	struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		if (param == ERR_PTR(-EBUSY))
+			continue;
+		if (strncmp(param->name, param_name, EXTPARAMNAMSIZ) == 0)
+			return param;
+	}
+
+	return NULL;
+}
+
+struct p4tc_extern_param *
+p4tc_ext_param_find_byid(struct idr *params_idr, const u32 param_id)
+{
+	return idr_find(params_idr, param_id);
+}
+EXPORT_SYMBOL(p4tc_ext_param_find_byid);
+
+static struct p4tc_extern_param *
+p4tc_ext_param_find_byany(struct idr *params_idr, const char *param_name,
+			  const u32 param_id, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param;
+	int err;
+
+	if (param_id) {
+		param = p4tc_ext_param_find_byid(params_idr, param_id);
+		if (!param) {
+			NL_SET_ERR_MSG(extack, "Unable to find param by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (param_name) {
+			param = p4tc_ext_param_find_byname(params_idr,
+							   param_name);
+			if (!param) {
+				NL_SET_ERR_MSG(extack, "Param name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack, "Must specify param name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return param;
+
+out:
+	return ERR_PTR(err);
+}
+
+struct p4tc_extern_param *
+p4tc_ext_param_find_byanyattr(struct idr *params_idr,
+			      struct nlattr *name_attr,
+			      const u32 param_id,
+			      struct netlink_ext_ack *extack)
+{
+	char *param_name = NULL;
+
+	if (name_attr)
+		param_name = nla_data(name_attr);
+
+	return p4tc_ext_param_find_byany(params_idr, param_name, param_id,
+					 extack);
+}
+
+static struct p4tc_extern_param *
+p4tc_extern_create_param(struct idr *params_idr, struct nlattr **tb,
+			 u32 param_id, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param;
+	u8 *flags = NULL;
+	char *name;
+	int ret;
+
+	if (tb[P4TC_EXT_PARAMS_NAME]) {
+		name = nla_data(tb[P4TC_EXT_PARAMS_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param name");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if ((param_id && p4tc_ext_param_find_byid(params_idr, param_id)) ||
+	    p4tc_ext_param_find_byname(params_idr, name)) {
+		NL_SET_ERR_MSG_FMT(extack, "Param already exists %s", name);
+		ret = -EEXIST;
+		goto free;
+	}
+
+	if ((tb[P4TC_EXT_PARAMS_TYPE] && !tb[P4TC_EXT_PARAMS_BITSZ]) ||
+	    (!tb[P4TC_EXT_PARAMS_TYPE] && tb[P4TC_EXT_PARAMS_BITSZ])) {
+		NL_SET_ERR_MSG(extack, "Must specify type with bit size");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (tb[P4TC_EXT_PARAMS_TYPE]) {
+		struct p4tc_type_mask_shift *mask_shift = NULL;
+		struct p4tc_type *type;
+		u32 typeid;
+		u16 bitsz;
+
+		typeid = nla_get_u32(tb[P4TC_EXT_PARAMS_TYPE]);
+		bitsz = nla_get_u16(tb[P4TC_EXT_PARAMS_BITSZ]);
+
+		type = p4type_find_byid(typeid);
+		if (!type) {
+			NL_SET_ERR_MSG(extack, "Param type is invalid");
+			ret = -EINVAL;
+			goto free;
+		}
+		param->type = type;
+		if (bitsz > param->type->bitsz) {
+			NL_SET_ERR_MSG(extack, "Bit size is bigger than type");
+			ret = -EINVAL;
+			goto free;
+		}
+		if (type->ops->create_bitops) {
+			mask_shift = type->ops->create_bitops(bitsz, 0,
+							      bitsz - 1,
+							      extack);
+			if (IS_ERR(mask_shift)) {
+				ret = PTR_ERR(mask_shift);
+				goto free;
+			}
+		}
+		param->mask_shift = mask_shift;
+		param->bitsz = bitsz;
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param type");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (tb[P4TC_EXT_PARAMS_FLAGS]) {
+		flags = nla_data(tb[P4TC_EXT_PARAMS_FLAGS]);
+		param->flags = *flags;
+	}
+
+	if (flags && *flags & P4TC_EXT_PARAMS_FLAG_ISKEY) {
+		switch (param->type->typeid) {
+		case P4T_U8:
+		case P4T_U16:
+		case P4T_U32:
+			break;
+		default: {
+			NL_SET_ERR_MSG(extack,
+				       "Key must be an unsigned integer");
+			ret = -EINVAL;
+			goto free_mask_shift;
+		}
+		}
+	}
+
+	if (param_id) {
+		ret = idr_alloc_u32(params_idr, param, &param_id,
+				    param_id, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate param id");
+			goto free_mask_shift;
+		}
+		param->id = param_id;
+	} else {
+		param->id = 1;
+
+		ret = idr_alloc_u32(params_idr, param, &param->id,
+				    UINT_MAX, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate param id");
+			goto free_mask_shift;
+		}
+	}
+
+	strscpy(param->name, name, EXTPARAMNAMSIZ);
+
+	return param;
+
+free_mask_shift:
+	if (param->mask_shift)
+		p4t_release(param->mask_shift);
+
+free:
+	kfree(param);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_extern_param *
+p4tc_extern_create_param_value(struct net *net, struct idr *params_idr,
+			       struct nlattr **tb, u32 param_id,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param;
+	int err;
+
+	param = p4tc_extern_create_param(params_idr, tb, param_id, extack);
+	if (IS_ERR(param))
+		return param;
+
+	err = p4tc_ext_param_value_init(net, param, tb, param->type->typeid,
+					false, extack);
+	if (err < 0) {
+		p4tc_extern_put_param_idr(params_idr, param);
+		return ERR_PTR(err);
+	}
+
+	return param;
+}
+
+static struct p4tc_extern_param *
+p4tc_extern_init_param_value(struct net *net, struct idr *params_idr,
+			     struct nlattr *nla,
+			     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_PARAMS_MAX + 1];
+	u32 param_id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_EXT_PARAMS_MAX, nla,
+			       p4tc_extern_params_policy, extack);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (tb[P4TC_EXT_PARAMS_ID])
+		param_id = nla_get_u32(tb[P4TC_EXT_PARAMS_ID]);
+
+	return p4tc_extern_create_param_value(net, params_idr, tb,
+					      param_id, extack);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static bool
+p4tc_extern_params_check_flags(struct p4tc_extern_param *param,
+			       struct netlink_ext_ack *extack)
+{
+	if (param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY &&
+	    param->flags & P4TC_EXT_PARAMS_FLAG_IS_DATASCALAR) {
+		NL_SET_ERR_MSG(extack,
+			       "Can't set key and data scalar flags at the same time");
+		return false;
+	}
+
+	return true;
+}
+
+static struct p4tc_extern_params *
+p4tc_extern_init_params_value(struct net *net,
+			      struct p4tc_extern_params *params,
+			      struct nlattr **tb,
+			      bool *is_scalar, bool tbl_bindable,
+			      struct netlink_ext_ack *extack)
+{
+	bool has_scalar_param = false;
+	bool has_key_param = false;
+	int ret;
+	int i;
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		struct p4tc_extern_param *param;
+
+		param = p4tc_extern_init_param_value(net, &params->params_idr,
+						     tb[i], extack);
+		if (IS_ERR(param)) {
+			ret = PTR_ERR(param);
+			goto params_del;
+		}
+
+		if (!p4tc_extern_params_check_flags(param, extack)) {
+			ret = -EINVAL;
+			goto params_del;
+		}
+
+		if (has_key_param) {
+			if (param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY) {
+				NL_SET_ERR_MSG(extack,
+					       "There can't be 2 key params");
+				ret = -EINVAL;
+				goto params_del;
+			}
+		} else {
+			has_key_param = param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY;
+		}
+
+		if (has_scalar_param) {
+			if (!param->flags ||
+			    (param->flags & P4TC_EXT_PARAMS_FLAG_IS_DATASCALAR)) {
+				NL_SET_ERR_MSG(extack,
+					       "All data parameters must be scalars");
+				ret = -EINVAL;
+				goto params_del;
+			}
+		} else {
+			has_scalar_param = param->flags & P4TC_EXT_PARAMS_FLAG_IS_DATASCALAR;
+		}
+		if (tbl_bindable) {
+			if (!p4tc_is_type_unsigned(param->type->typeid)) {
+				NL_SET_ERR_MSG_FMT(extack,
+						   "Extern with %s parameter is unbindable",
+						   param->type->name);
+				ret = -EINVAL;
+				goto params_del;
+			}
+		}
+		params->num_params++;
+	}
+	*is_scalar = has_scalar_param;
+
+	return params;
+
+params_del:
+	p4tc_ext_params_free(params, true);
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_extern_params *
+p4tc_extern_create_params_value(struct net *net, struct nlattr *nla,
+				bool *is_scalar, bool tbl_bindable,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	struct p4tc_extern_params *params;
+	int ret;
+
+	params = p4tc_extern_params_init();
+	if (!params) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL,
+				       extack);
+		if (ret < 0) {
+			ret = -EINVAL;
+			goto params_del;
+		}
+	} else {
+		return params;
+	}
+
+	return p4tc_extern_init_params_value(net, params, tb, is_scalar,
+					     tbl_bindable, extack);
+
+params_del:
+	p4tc_ext_params_free(params, true);
+err_out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_extern_params *
+p4tc_extern_update_params_value(struct net *net, struct nlattr *nla,
+				bool *is_scalar, bool tbl_bindable,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	struct p4tc_extern_params *params;
+	int ret;
+
+	if (nla) {
+		params = p4tc_extern_params_init();
+		if (!params) {
+			ret = -ENOMEM;
+			goto err_out;
+		}
+
+		ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL,
+				       extack);
+		if (ret < 0) {
+			ret = -EINVAL;
+			goto params_del;
+		}
+	} else {
+		return NULL;
+	}
+
+	return p4tc_extern_init_params_value(net, params, tb, is_scalar,
+					     tbl_bindable, extack);
+
+params_del:
+	p4tc_ext_params_free(params, true);
+err_out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_find_byanyattr(struct p4tc_pipeline *pipeline,
+			     struct nlattr *name_attr, u32 ext_id,
+			     struct netlink_ext_ack *extack)
+{
+	char *extern_name = NULL;
+
+	if (name_attr)
+		extern_name = nla_data(name_attr);
+
+	return p4tc_tmpl_ext_find_byany(pipeline, extern_name, ext_id,
+				       extack);
+}
+
+int p4tc_register_extern(struct p4tc_extern_ops *ext)
+{
+	if (p4tc_extern_lookup_n(ext->kind))
+		return -EEXIST;
+
+	if (!p4tc_extern_mod_callbacks_check(ext))
+		return -EINVAL;
+
+	write_lock(&ext_mod_lock);
+	list_add_tail(&ext->head, &ext_base);
+	write_unlock(&ext_mod_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(p4tc_register_extern);
+
+int p4tc_unregister_extern(struct p4tc_extern_ops *ext)
+{
+	struct p4tc_extern_ops *a;
+	int err = -ENOENT;
+
+	write_lock(&ext_mod_lock);
+	list_for_each_entry(a, &ext_base, head) {
+		if (a == ext) {
+			list_del(&ext->head);
+			err = 0;
+			break;
+		}
+	}
+	write_unlock(&ext_mod_lock);
+	return err;
+}
+EXPORT_SYMBOL(p4tc_unregister_extern);
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_byname(struct p4tc_pipeline *pipeline,
+				   const char *extname)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	unsigned long tmp, ext_id;
+
+	idr_for_each_entry_ul(&pipeline->user_ext_idr, pipe_ext, tmp, ext_id) {
+		if (strncmp(pipe_ext->ext_name, extname, EXTERNNAMSIZ) == 0)
+			return pipe_ext;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_byany(struct p4tc_pipeline *pipeline,
+				  const char *extname, u32 ext_id,
+				  struct netlink_ext_ack *extack)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	int err;
+
+	if (ext_id) {
+		pipe_ext = p4tc_user_pipeline_ext_find_byid(pipeline, ext_id);
+		if (!pipe_ext) {
+			NL_SET_ERR_MSG(extack, "Unable to find extern");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (extname) {
+			pipe_ext = p4tc_user_pipeline_ext_find_byname(pipeline,
+								      extname);
+			if (!pipe_ext) {
+				NL_SET_ERR_MSG(extack,
+					       "Extern name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify extern name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return pipe_ext;
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_byanyattr(struct p4tc_pipeline *pipeline,
+				      struct nlattr *name_attr, u32 ext_id,
+				      struct netlink_ext_ack *extack)
+{
+	char *extname = NULL;
+
+	if (name_attr)
+		extname = nla_data(name_attr);
+
+	return p4tc_user_pipeline_ext_find_byany(pipeline, extname, ext_id,
+						 extack);
+}
+
+static bool
+p4tc_user_pipeline_insts_exceeded(struct p4tc_user_pipeline_extern *pipe_ext)
+{
+	const u32 max_num_insts = pipe_ext->tmpl_ext->max_num_insts;
+
+	return atomic_read(&pipe_ext->curr_insts_num) == max_num_insts;
+}
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_or_create(struct p4tc_pipeline *pipeline,
+				      struct p4tc_tmpl_extern *tmpl_ext,
+				      struct netlink_ext_ack *extack)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	int err;
+
+	pipe_ext = p4tc_user_pipeline_ext_get(pipeline, tmpl_ext->ext_id);
+	if (pipe_ext != ERR_PTR(-ENOENT)) {
+		if (p4tc_user_pipeline_insts_exceeded(pipe_ext)) {
+			NL_SET_ERR_MSG(extack,
+				       "Maximum number of instances exceeded");
+			p4tc_user_pipeline_ext_put_ref(pipe_ext);
+			return ERR_PTR(-ENOSPC);
+		}
+
+		return pipe_ext;
+	}
+
+	pipe_ext = kzalloc(sizeof(*pipe_ext), GFP_KERNEL);
+	if (!pipe_ext)
+		return ERR_PTR(-ENOMEM);
+
+	pipe_ext->ext_id = tmpl_ext->ext_id;
+	err = idr_alloc_u32(&pipeline->user_ext_idr, pipe_ext,
+			    &pipe_ext->ext_id, pipe_ext->ext_id, GFP_KERNEL);
+	if (err < 0)
+		goto free_pipe_ext;
+
+	strscpy(pipe_ext->ext_name, tmpl_ext->common.name, EXTERNNAMSIZ);
+	idr_init(&pipe_ext->e_inst_idr);
+	refcount_set(&pipe_ext->ext_ref, 2);
+	atomic_set(&pipe_ext->curr_insts_num, 0);
+	refcount_inc(&tmpl_ext->tmpl_ref);
+	pipe_ext->tmpl_ext = tmpl_ext;
+	pipe_ext->free = p4tc_user_pipeline_ext_free;
+
+	return pipe_ext;
+
+free_pipe_ext:
+	kfree(pipe_ext);
+	return ERR_PTR(err);
+}
+
+struct p4tc_user_pipeline_extern *
+p4tc_pipe_ext_find_bynames(struct net *net, struct p4tc_pipeline *pipeline,
+			   const char *extname, struct netlink_ext_ack *extack)
+{
+	return p4tc_user_pipeline_ext_find_byany(pipeline, extname, 0,
+						 extack);
+}
+
+struct p4tc_extern_inst *
+p4tc_ext_inst_find_bynames(struct net *net, struct p4tc_pipeline *pipeline,
+			   const char *extname, const char *instname,
+			   struct netlink_ext_ack *extack)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	struct p4tc_extern_inst *inst;
+
+	pipe_ext = p4tc_pipe_ext_find_bynames(net, pipeline, extname, extack);
+	if (IS_ERR(pipe_ext))
+		return (void *)pipe_ext;
+
+	inst = p4tc_ext_inst_find_byany(pipe_ext, instname, 0, extack);
+	if (IS_ERR(inst))
+		return inst;
+
+	return inst;
+}
+
+static void
+__p4tc_ext_inst_table_unbind(struct p4tc_user_pipeline_extern *pipe_ext,
+			     struct p4tc_extern_inst *inst)
+{
+	p4tc_user_pipeline_ext_put_ref(pipe_ext);
+	p4tc_ext_inst_put_ref(inst);
+}
+
+void
+p4tc_ext_inst_table_unbind(struct p4tc_table *table,
+			   struct p4tc_user_pipeline_extern *pipe_ext,
+			   struct p4tc_extern_inst *inst)
+{
+	table->tbl_counter = NULL;
+	__p4tc_ext_inst_table_unbind(pipe_ext, inst);
+}
+
+struct p4tc_extern_inst *
+p4tc_ext_find_byids(struct p4tc_pipeline *pipeline,
+		    const u32 ext_id, const u32 inst_id)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	struct p4tc_extern_inst *inst;
+	int err;
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byid(pipeline, ext_id);
+	if (!pipe_ext) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	inst = p4tc_ext_inst_find_byid(pipe_ext, inst_id);
+	if (!inst) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	return inst;
+
+out:
+	return ERR_PTR(err);
+}
+
+#define SEPARATOR "/"
+
+struct p4tc_extern_inst *
+p4tc_ext_inst_table_bind(struct p4tc_pipeline *pipeline,
+			 struct p4tc_user_pipeline_extern **pipe_ext,
+			 const char *ext_inst_path,
+			 struct netlink_ext_ack *extack)
+{
+	char *instname_clone, *extname, *instname;
+	struct p4tc_extern_inst *inst;
+	int err;
+
+	instname_clone = instname = kstrdup(ext_inst_path, GFP_KERNEL);
+	if (!instname)
+		return ERR_PTR(-ENOMEM);
+
+	extname = strsep(&instname, SEPARATOR);
+
+	*pipe_ext = p4tc_pipe_ext_find_bynames(pipeline->net, pipeline, extname,
+					       extack);
+	if (IS_ERR(*pipe_ext)) {
+		err = PTR_ERR(*pipe_ext);
+		goto free_inst_path;
+	}
+
+	inst = p4tc_ext_inst_get(*pipe_ext, instname, 0, extack);
+	if (IS_ERR(inst)) {
+		err = PTR_ERR(inst);
+		goto free_inst_path;
+	}
+
+	if (!inst->tbl_bindable) {
+		__p4tc_ext_inst_table_unbind(*pipe_ext, inst);
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Extern instance %s can't be bound to a table",
+				   inst->common.name);
+		err = -EPERM;
+		goto put_inst;
+	}
+
+	kfree(instname_clone);
+
+	return inst;
+
+put_inst:
+	p4tc_ext_inst_put_ref(inst);
+
+free_inst_path:
+	kfree(instname_clone);
+	return ERR_PTR(err);
+}
+
+struct p4tc_extern_inst *
+p4tc_ext_inst_get_byids(struct net *net, struct p4tc_pipeline **pipeline,
+			struct p4tc_ext_bpf_params *params)
+{
+	struct p4tc_extern_inst *inst;
+	int err;
+
+	*pipeline = p4tc_pipeline_find_get(net, NULL, params->pipe_id, NULL);
+	if (IS_ERR(*pipeline))
+		return (struct p4tc_extern_inst *)*pipeline;
+
+	inst = p4tc_ext_find_byids(*pipeline, params->ext_id, params->inst_id);
+	if (IS_ERR(inst)) {
+		err = PTR_ERR(inst);
+		goto put_pipeline;
+	}
+
+	return inst;
+
+put_pipeline:
+	p4tc_pipeline_put(*pipeline);
+
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL(p4tc_ext_inst_get_byids);
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_update(struct net *net, struct nlmsghdr *n,
+		     struct nlattr *nla, struct p4tc_pipeline *pipeline,
+		     u32 *ids, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_params *new_params, *new_constr_params;
+	struct p4tc_extern_params *params, *constr_params;
+	struct nlattr *tb[P4TC_TMPL_EXT_INST_MAX + 1];
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	struct p4tc_extern_inst *new_inst = NULL;
+	struct p4tc_pipeline *root_pipeline;
+	struct p4tc_extern_inst *old_inst;
+	bool has_scalar_params = false;
+	struct p4tc_tmpl_extern *ext;
+	u32 ext_id = 0, inst_id = 0;
+	bool tbl_bindable = false;
+	char *inst_name = NULL;
+	u32 max_num_elems = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TMPL_EXT_INST_MAX, nla,
+			       tc_extern_inst_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	ext_id = ids[P4TC_TMPL_EXT_IDX];
+
+	root_pipeline = p4tc_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+
+	ext = p4tc_tmpl_ext_find_byanyattr(root_pipeline,
+					   tb[P4TC_TMPL_EXT_INST_EXT_NAME],
+					   ext_id, extack);
+	if (IS_ERR(ext))
+		return (struct p4tc_extern_inst *)ext;
+
+	inst_id = ids[P4TC_TMPL_EXT_INST_IDX];
+
+	if (tb[P4TC_TMPL_EXT_INST_NAME])
+		inst_name = nla_data(tb[P4TC_TMPL_EXT_INST_NAME]);
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byid(pipeline, ext->ext_id);
+	if (!pipe_ext) {
+		NL_SET_ERR_MSG(extack, "Unable to find pipeline extern by id");
+		return ERR_PTR(-ENOENT);
+	}
+
+	old_inst = p4tc_ext_inst_find_byanyattr(pipe_ext, tb[P4TC_TMPL_EXT_INST_NAME],
+						inst_id, extack);
+	if (IS_ERR(old_inst)) {
+		NL_SET_ERR_MSG(extack, "Unable to find extern instance by id");
+		return ERR_PTR(-ENOENT);
+	}
+
+	if (tb[P4TC_TMPL_EXT_INST_NUM_ELEMS])
+		max_num_elems = nla_get_u32(tb[P4TC_TMPL_EXT_INST_NUM_ELEMS]);
+
+	if (tb[P4TC_TMPL_EXT_INST_TABLE_BINDABLE])
+		tbl_bindable = true;
+	else
+		tbl_bindable = old_inst->tbl_bindable;
+
+	if (tbl_bindable && !p4tc_ext_has_exec(ext->ops)) {
+		NL_SET_ERR_MSG(extack,
+			       "Instance may only be table bindable if module has exec");
+		return ERR_PTR(-EINVAL);
+	}
+
+	new_params = p4tc_extern_update_params_value(net,
+						     tb[P4TC_TMPL_EXT_INST_CONTROL_PARAMS],
+						     &has_scalar_params, tbl_bindable,
+						     extack);
+	if (IS_ERR(new_params))
+		return (struct p4tc_extern_inst *)new_params;
+
+	params = new_params ?: old_inst->params;
+	max_num_elems = max_num_elems ?: old_inst->max_num_elems;
+
+	if (p4tc_ext_inst_has_construct(old_inst)) {
+		struct nlattr *nla_constr_params = tb[P4TC_TMPL_EXT_INST_CONSTR_PARAMS];
+
+		new_constr_params = p4tc_extern_update_params_value(net,
+								    nla_constr_params,
+								    &has_scalar_params,
+								    tbl_bindable,
+								    extack);
+		if (IS_ERR(new_constr_params)) {
+			if (new_params)
+				p4tc_ext_params_free(new_params, true);
+
+			return (struct p4tc_extern_inst *)new_constr_params;
+		}
+		constr_params = new_constr_params ?: old_inst->constr_params;
+
+		ret = old_inst->ops->construct(&new_inst, params, constr_params,
+					       max_num_elems, tbl_bindable,
+					       extack);
+		if (new_params)
+			p4tc_ext_params_free(new_params, true);
+		if (new_constr_params)
+			p4tc_ext_params_free(new_constr_params, true);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	} else {
+		if (tb[P4TC_TMPL_EXT_INST_CONSTR_PARAMS]) {
+			NL_SET_ERR_MSG(extack,
+				       "Need construct mod op to pass constructor params");
+			ret = -EINVAL;
+			goto free_control_params;
+		}
+
+		new_inst = p4tc_ext_inst_alloc(ext->ops, max_num_elems,
+					       tbl_bindable,
+					       pipe_ext->ext_name);
+		if (IS_ERR(new_inst)) {
+			ret = PTR_ERR(new_inst);
+			goto free_control_params;
+		}
+		new_inst->params = params;
+	}
+
+	new_inst->ext_inst_id = old_inst->ext_inst_id;
+	new_inst->is_scalar = has_scalar_params;
+	new_inst->ext_id = ext->ext_id;
+	new_inst->pipe_ext = pipe_ext;
+
+	strscpy(new_inst->common.name, inst_name, EXTERNINSTNAMSIZ);
+
+	idr_replace(&pipe_ext->e_inst_idr, new_inst, old_inst->ext_inst_id);
+
+	___p4tc_ext_inst_put(old_inst, !!new_params);
+
+	return new_inst;
+
+free_control_params:
+	if (new_params)
+		p4tc_ext_params_free(new_params, true);
+
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_create(struct net *net, struct nlmsghdr *n,
+		     struct nlattr *nla, struct p4tc_pipeline *pipeline,
+		     u32 *ids, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_params *constr_params = NULL, *params;
+	struct nlattr *tb[P4TC_TMPL_EXT_INST_MAX + 1];
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	struct p4tc_pipeline *root_pipeline;
+	bool has_scalar_params = false;
+	struct p4tc_extern_inst *inst;
+	struct p4tc_tmpl_extern *ext;
+	u32 ext_id = 0, inst_id = 0;
+	bool tbl_bindable = false;
+	char *inst_name = NULL;
+	u32 max_num_elems;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TMPL_EXT_INST_MAX, nla,
+			       tc_extern_inst_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	ext_id = ids[P4TC_TMPL_EXT_IDX];
+
+	root_pipeline = p4tc_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+
+	ext = p4tc_tmpl_ext_find_byanyattr(root_pipeline,
+					   tb[P4TC_TMPL_EXT_INST_EXT_NAME],
+					   ext_id, extack);
+	if (IS_ERR(ext))
+		return (struct p4tc_extern_inst *)ext;
+
+	if (tb[P4TC_TMPL_EXT_INST_NAME]) {
+		inst_name = nla_data(tb[P4TC_TMPL_EXT_INST_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify extern name");
+		return ERR_PTR(-EINVAL);
+	}
+
+	inst_id = ids[P4TC_TMPL_EXT_INST_IDX];
+	if (!inst_id) {
+		NL_SET_ERR_MSG(extack, "Must specify extern instance id");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pipe_ext = p4tc_user_pipeline_ext_find_or_create(pipeline, ext, extack);
+	if (IS_ERR(pipe_ext))
+		return (struct p4tc_extern_inst *)pipe_ext;
+
+	if (p4tc_ext_inst_find_byid(pipe_ext, inst_id) ||
+	    p4tc_ext_inst_find_byname(pipe_ext, inst_name)) {
+		NL_SET_ERR_MSG(extack,
+			       "Extern instance with same name or ID already exists");
+		ret = -EEXIST;
+		goto put_pipe_ext;
+	}
+
+	if (tb[P4TC_TMPL_EXT_INST_NUM_ELEMS])
+		max_num_elems = nla_get_u32(tb[P4TC_TMPL_EXT_INST_NUM_ELEMS]);
+	else
+		max_num_elems = P4TC_DEFAULT_NUM_EXT_INST_ELEMS;
+
+	if (tb[P4TC_TMPL_EXT_INST_TABLE_BINDABLE])
+		tbl_bindable = true;
+
+	if (tbl_bindable && !p4tc_ext_has_exec(ext->ops)) {
+		NL_SET_ERR_MSG(extack,
+			       "Instance may only be table bindable if module has exec");
+		return ERR_PTR(-EINVAL);
+	}
+
+	params = p4tc_extern_create_params_value(net,
+						 tb[P4TC_TMPL_EXT_INST_CONTROL_PARAMS],
+						 &has_scalar_params,
+						 tbl_bindable, extack);
+	if (IS_ERR(params))
+		return (struct p4tc_extern_inst *)params;
+
+	if (p4tc_ext_has_construct(ext->ops)) {
+		struct nlattr *nla_constr_params = tb[P4TC_TMPL_EXT_INST_CONSTR_PARAMS];
+
+		constr_params = p4tc_extern_create_params_value(net,
+								nla_constr_params,
+								&has_scalar_params,
+								tbl_bindable, extack);
+		if (IS_ERR(constr_params)) {
+			ret = PTR_ERR(constr_params);
+			goto free_control_params;
+		}
+
+		ret = ext->ops->construct(&inst, params, constr_params,
+					  max_num_elems, tbl_bindable, extack);
+		p4tc_ext_params_free(params, true);
+		p4tc_ext_params_free(constr_params, true);
+		if (ret < 0)
+			goto put_pipe_ext;
+	} else {
+		if (tb[P4TC_TMPL_EXT_INST_CONSTR_PARAMS]) {
+			NL_SET_ERR_MSG(extack,
+				       "Need construct mod op to pass constructor params");
+			ret = -EINVAL;
+			goto free_control_params;
+		}
+
+		inst = p4tc_ext_inst_alloc(ext->ops, max_num_elems,
+					   tbl_bindable, pipe_ext->ext_name);
+		if (IS_ERR(inst)) {
+			ret = -ENOMEM;
+			goto free_control_params;
+		}
+
+		inst->params = params;
+	}
+
+	inst->ext_id = ext->ext_id;
+	inst->ext_inst_id = inst_id;
+	inst->pipe_ext = pipe_ext;
+	inst->ext_id = ext->ext_id;
+	inst->is_scalar = has_scalar_params;
+
+	strscpy(inst->common.name, inst_name, EXTERNINSTNAMSIZ);
+
+	ret = idr_alloc_u32(&pipe_ext->e_inst_idr, inst, &inst_id,
+			    inst_id, GFP_KERNEL);
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to allocate ID for extern instance");
+		goto free_extern;
+	}
+
+	atomic_inc(&pipe_ext->curr_insts_num);
+
+	return inst;
+
+free_extern:
+	if (p4tc_ext_inst_has_construct(inst))
+		inst->ops->deconstruct(inst);
+	else
+		kfree(inst);
+
+free_control_params:
+	if (!p4tc_ext_has_construct(ext->ops) && params)
+		p4tc_ext_params_free(params, true);
+
+put_pipe_ext:
+	p4tc_user_pipeline_ext_put_ref(pipe_ext);
+
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+p4tc_ext_inst_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+		 struct p4tc_path_nlattrs *nl_path_attrs,
+		 struct netlink_ext_ack *extack)
+{
+	u32 *ids = nl_path_attrs->ids;
+	u32 pipeid = ids[P4TC_PID_IDX];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_inst *inst;
+
+	pipeline = p4tc_pipeline_find_byany_unsealed(net, nl_path_attrs->pname,
+						     pipeid, extack);
+	if (IS_ERR(pipeline))
+		return (void *)pipeline;
+
+	switch (n->nlmsg_type) {
+	case RTM_CREATEP4TEMPLATE:
+		inst = p4tc_ext_inst_create(net, n, nla, pipeline, ids,
+					    extack);
+		break;
+	case RTM_UPDATEP4TEMPLATE:
+		inst = p4tc_ext_inst_update(net, n, nla, pipeline, ids,
+					    extack);
+		break;
+	default:
+		/* Should never happen */
+		NL_SET_ERR_MSG(extack,
+			       "Only create and update are supported for extern inst");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (IS_ERR(inst))
+		goto out;
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!ids[P4TC_TMPL_EXT_IDX])
+		ids[P4TC_TMPL_EXT_IDX] = inst->ext_id;
+
+	if (!ids[P4TC_TMPL_EXT_INST_IDX])
+		ids[P4TC_TMPL_EXT_INST_IDX] = inst->ext_inst_id;
+
+out:
+	return (struct p4tc_template_common *)inst;
+}
+
+static struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_create(struct nlmsghdr *n, struct nlattr *nla,
+		     struct p4tc_pipeline *pipeline, u32 *ids,
+		     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TMPL_EXT_MAX + 1];
+	struct p4tc_tmpl_extern *ext;
+	char *extern_name = NULL;
+	u32 ext_id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TMPL_EXT_MAX, nla, tc_extern_policy,
+			       extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	ext_id = ids[P4TC_TMPL_EXT_IDX];
+	if (!ext_id) {
+		NL_SET_ERR_MSG(extack, "Must specify extern id");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (tb[P4TC_TMPL_EXT_NAME]) {
+		extern_name = nla_data(tb[P4TC_TMPL_EXT_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify extern name");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (p4tc_tmpl_ext_find_byid(pipeline, ext_id) ||
+	    p4tc_tmpl_ext_find_name(pipeline, extern_name)) {
+		NL_SET_ERR_MSG(extack,
+			       "Extern with same id or name was already inserted");
+		return ERR_PTR(-EEXIST);
+	}
+
+	ext = kzalloc(sizeof(*ext), GFP_KERNEL);
+	if (!ext) {
+		NL_SET_ERR_MSG(extack, "Failed to allocate ext");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (tb[P4TC_TMPL_EXT_NUM_INSTS]) {
+		u16 *num_insts = nla_data(tb[P4TC_TMPL_EXT_NUM_INSTS]);
+
+		ext->max_num_insts = *num_insts;
+	} else {
+		ext->max_num_insts = P4TC_DEFAULT_NUM_EXT_INSTS;
+	}
+
+	if (tb[P4TC_TMPL_EXT_HAS_EXEC_METHOD])
+		ext->has_exec_method = nla_get_u8(tb[P4TC_TMPL_EXT_HAS_EXEC_METHOD]);
+
+	/* Extern module is not mandatory */
+	if (ext->has_exec_method) {
+		struct p4tc_extern_ops *ops;
+
+		ops = p4tc_extern_ops_load(extern_name);
+		if (!ops) {
+			ret = -ENOENT;
+			goto free_extern;
+		}
+
+		ext->ops = ops;
+	}
+
+	ret = idr_alloc_u32(&pipeline->p_ext_idr, ext, &ext_id, ext_id,
+			    GFP_KERNEL);
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack, "Unable to allocate ID for extern");
+		goto free_extern;
+	}
+
+	ext->ext_id = ext_id;
+
+	strscpy(ext->common.name, extern_name, EXTERNNAMSIZ);
+
+	refcount_set(&ext->tmpl_ref, 1);
+
+	ext->common.p_id = pipeline->common.p_id;
+	ext->common.ops = (struct p4tc_template_ops *)&p4tc_tmpl_ext_ops;
+
+	return ext;
+
+free_extern:
+	p4tc_extern_ops_put(ext->ops);
+	kfree(ext);
+
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+p4tc_tmpl_ext_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+		 struct p4tc_path_nlattrs *nl_path_attrs,
+		 struct netlink_ext_ack *extack)
+{
+	struct p4tc_pipeline *pipeline;
+	u32 *ids = nl_path_attrs->ids;
+	struct p4tc_tmpl_extern *ext;
+
+	if (p4tc_tmpl_msg_is_update(n)) {
+		NL_SET_ERR_MSG(extack, "Extern update not supported");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	pipeline = p4tc_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+
+	ext = p4tc_tmpl_ext_create(n, nla, pipeline, ids, extack);
+	if (IS_ERR(ext))
+		goto out;
+
+out:
+	return (struct p4tc_template_common *)ext;
+}
+
+static int ext_inst_param_fill_nlmsg(struct sk_buff *skb,
+				     struct p4tc_extern_param *param)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+
+	if (nla_put_string(skb, P4TC_EXT_PARAMS_NAME, param->name))
+		goto out_nlmsg_trim;
+
+	if (nla_put_u32(skb, P4TC_EXT_PARAMS_ID, param->id))
+		goto out_nlmsg_trim;
+
+	if (nla_put_u32(skb, P4TC_EXT_PARAMS_TYPE, param->type->typeid))
+		goto out_nlmsg_trim;
+
+	if (param->value && p4tc_ext_param_value_dump_tmpl(skb, param))
+		goto out_nlmsg_trim;
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int ext_inst_params_fill_nlmsg(struct sk_buff *skb,
+				      struct p4tc_extern_params *params)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_extern_param *param;
+	struct nlattr *nest_count;
+	unsigned long id, tmp;
+	int i = 1;
+
+	if (!params)
+		return skb->len;
+
+	idr_for_each_entry_ul(&params->params_idr, param, tmp, id) {
+		nest_count = nla_nest_start(skb, i);
+		if (!nest_count)
+			goto out_nlmsg_trim;
+
+		if (ext_inst_param_fill_nlmsg(skb, param) < 0)
+			goto out_nlmsg_trim;
+
+		nla_nest_end(skb, nest_count);
+		i++;
+	}
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int
+__p4tc_ext_inst_fill_nlmsg(struct sk_buff *skb, struct p4tc_extern_inst *inst,
+			   struct netlink_ext_ack *extack)
+{
+	struct nlattr *nest, *parms, *constr_parms;
+	const char *ext_name = inst->ext_name;
+	unsigned char *b = nlmsg_get_pos(skb);
+	/* Parser instance id + header field id */
+	u32 ids[2];
+
+	ids[0] = inst->ext_id;
+	ids[1] = inst->ext_inst_id;
+
+	if (nla_put(skb, P4TC_PATH, sizeof(ids), &ids))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	if (ext_name[0]) {
+		if (nla_put_string(skb, P4TC_TMPL_EXT_INST_EXT_NAME,
+				   ext_name))
+			goto out_nlmsg_trim;
+	}
+
+	if (inst->common.name[0]) {
+		if (nla_put_string(skb, P4TC_TMPL_EXT_INST_NAME,
+				   inst->common.name))
+			goto out_nlmsg_trim;
+	}
+
+	if (nla_put_u32(skb, P4TC_TMPL_EXT_INST_NUM_ELEMS,
+			inst->max_num_elems))
+		goto out_nlmsg_trim;
+
+	parms = nla_nest_start(skb, P4TC_TMPL_EXT_INST_CONTROL_PARAMS);
+	if (!parms)
+		goto out_nlmsg_trim;
+
+	if (ext_inst_params_fill_nlmsg(skb, inst->params) < 0)
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, parms);
+
+	constr_parms = nla_nest_start(skb, P4TC_TMPL_EXT_INST_CONSTR_PARAMS);
+	if (!constr_parms)
+		goto out_nlmsg_trim;
+
+	if (ext_inst_params_fill_nlmsg(skb, inst->constr_params) < 0)
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, constr_parms);
+
+	nla_nest_end(skb, nest);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int __p4tc_tmpl_ext_fill_nlmsg(struct sk_buff *skb,
+				      struct p4tc_tmpl_extern *ext)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *nest;
+	/* Parser instance id + header field id */
+	u32 id;
+
+	id = ext->ext_id;
+
+	if (nla_put(skb, P4TC_PATH, sizeof(id), &id))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	if (ext->common.name[0]) {
+		if (nla_put_string(skb, P4TC_TMPL_EXT_NAME, ext->common.name))
+			goto out_nlmsg_trim;
+	}
+
+	if (nla_put_u16(skb, P4TC_TMPL_EXT_NUM_INSTS, ext->max_num_insts))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, nest);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int p4tc_ext_inst_fill_nlmsg(struct net *net, struct sk_buff *skb,
+				    struct p4tc_template_common *template,
+				    struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_inst *inst = to_extern_inst(template);
+
+	if (__p4tc_ext_inst_fill_nlmsg(skb, inst, extack) < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for extern instance");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4tc_tmpl_ext_fill_nlmsg(struct net *net, struct sk_buff *skb,
+				    struct p4tc_template_common *template,
+				    struct netlink_ext_ack *extack)
+{
+	struct p4tc_tmpl_extern *ext = to_extern(template);
+
+	if (__p4tc_tmpl_ext_fill_nlmsg(skb, ext) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for extern");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4tc_tmpl_ext_flush(struct sk_buff *skb,
+			       struct p4tc_pipeline *pipeline,
+			       struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_tmpl_extern *ext;
+	unsigned long tmp, ext_id;
+	int ret = 0;
+	u32 path[1];
+	int i = 0;
+
+	path[0] = 0;
+
+	if (idr_is_empty(&pipeline->p_ext_idr)) {
+		NL_SET_ERR_MSG(extack, "There are no externs to flush");
+		goto out_nlmsg_trim;
+	}
+
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	idr_for_each_entry_ul(&pipeline->p_ext_idr, ext, tmp, ext_id) {
+		if (_p4tc_tmpl_ext_put(pipeline, ext, false, extack) < 0) {
+			ret = -EBUSY;
+			continue;
+		}
+		i++;
+	}
+
+	nla_put_u32(skb, P4TC_COUNT, i);
+
+	if (ret < 0) {
+		if (i == 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush any externs");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Flush only %u externs", i);
+		}
+	}
+
+	return i;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return 0;
+}
+
+static int p4tc_ext_inst_flush(struct sk_buff *skb,
+			       struct p4tc_pipeline *pipeline,
+			       struct p4tc_user_pipeline_extern *pipe_ext,
+			       struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_extern_inst *inst;
+	unsigned long tmp, inst_id;
+	int ret = 0;
+	u32 path[2];
+	int i = 0;
+
+	if (idr_is_empty(&pipe_ext->e_inst_idr)) {
+		NL_SET_ERR_MSG(extack, "There are no externs to flush");
+		goto out_nlmsg_trim;
+	}
+
+	path[0] = pipe_ext->ext_id;
+	path[1] = 0;
+
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	idr_for_each_entry_ul(&pipe_ext->e_inst_idr, inst, tmp, inst_id) {
+		if (__p4tc_ext_inst_put(pipeline, inst, false, false,
+					extack) < 0) {
+			ret = -EBUSY;
+			continue;
+		}
+		i++;
+	}
+
+	/* We don't release pipe_ext in the loop to avoid use-after-free whilst
+	 * iterating through e_inst_idr. We free it here only if flush
+	 * succeeded, that is, all instances were deleted and thus ext_ref == 1
+	 */
+	if (refcount_read(&pipe_ext->ext_ref) == 1)
+		p4tc_user_pipeline_ext_free(pipe_ext, &pipeline->user_ext_idr);
+
+	nla_put_u32(skb, P4TC_COUNT, i);
+
+	if (ret < 0) {
+		if (i == 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush any externs instance");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Flushed only %u extern instances", i);
+		}
+	}
+
+	return i;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return 0;
+}
+
+static int p4tc_ext_inst_gd(struct net *net, struct sk_buff *skb,
+			    struct nlmsghdr *n, struct nlattr *nla,
+			    struct p4tc_path_nlattrs *nl_path_attrs,
+			    struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TMPL_EXT_INST_MAX + 1] = {NULL};
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	u32 *ids = nl_path_attrs->ids;
+	u32 inst_id = ids[P4TC_TMPL_EXT_INST_IDX];
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 ext_id = ids[P4TC_TMPL_EXT_IDX];
+	u32 pipe_id = ids[P4TC_PID_IDX];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_inst *inst;
+	int ret;
+
+	if (n->nlmsg_type == RTM_GETP4TEMPLATE)
+		pipeline = p4tc_pipeline_find_byany(net, nl_path_attrs->pname,
+						    pipe_id, extack);
+	else
+		pipeline = p4tc_pipeline_find_byany_unsealed(net,
+							     nl_path_attrs->pname,
+							     pipe_id, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_TMPL_EXT_MAX, nla,
+				       tc_extern_inst_policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byanyattr(pipeline,
+							 tb[P4TC_TMPL_EXT_INST_EXT_NAME],
+							 ext_id, extack);
+	if (IS_ERR(pipe_ext))
+		return PTR_ERR(pipe_ext);
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!ids[P4TC_TMPL_EXT_IDX])
+		ids[P4TC_TMPL_EXT_IDX] = pipe_ext->ext_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && n->nlmsg_flags & NLM_F_ROOT)
+		return p4tc_ext_inst_flush(skb, pipeline, pipe_ext, extack);
+
+	inst = p4tc_ext_inst_find_byanyattr(pipe_ext,
+					    tb[P4TC_TMPL_EXT_INST_NAME],
+					    inst_id, extack);
+	if (IS_ERR(inst))
+		return PTR_ERR(inst);
+
+	ret = __p4tc_ext_inst_fill_nlmsg(skb, inst, extack);
+	if (ret < 0)
+		return -ENOMEM;
+
+	if (!ids[P4TC_TMPL_EXT_INST_IDX])
+		ids[P4TC_TMPL_EXT_INST_IDX] = inst->ext_inst_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = __p4tc_ext_inst_put(pipeline, inst, false, true, extack);
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
+static int p4tc_tmpl_ext_gd(struct net *net, struct sk_buff *skb,
+			    struct nlmsghdr *n, struct nlattr *nla,
+			    struct p4tc_path_nlattrs *nl_path_attrs,
+			    struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TMPL_EXT_MAX + 1] = {NULL};
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 *ids = nl_path_attrs->ids;
+	u32 ext_id = ids[P4TC_TMPL_EXT_IDX];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_tmpl_extern *ext;
+	int ret;
+
+	pipeline = p4tc_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_TMPL_EXT_MAX, nla,
+				       tc_extern_policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && n->nlmsg_flags & NLM_F_ROOT)
+		return p4tc_tmpl_ext_flush(skb, pipeline, extack);
+
+	ext = p4tc_tmpl_ext_find_byanyattr(pipeline, tb[P4TC_TMPL_EXT_NAME],
+					   ext_id, extack);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	ret = __p4tc_tmpl_ext_fill_nlmsg(skb, ext);
+	if (ret < 0)
+		return -ENOMEM;
+
+	if (!ids[P4TC_TMPL_EXT_IDX])
+		ids[P4TC_TMPL_EXT_IDX] = ext->ext_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = _p4tc_tmpl_ext_put(pipeline, ext, false, extack);
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
+static int p4tc_tmpl_ext_dump_1(struct sk_buff *skb,
+				struct p4tc_template_common *common)
+{
+	struct nlattr *param = nla_nest_start(skb, P4TC_PARAMS);
+	struct p4tc_tmpl_extern *ext = to_extern(common);
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 path[2];
+
+	if (!param)
+		goto out_nlmsg_trim;
+
+	if (ext->common.name[0] &&
+	    nla_put_string(skb, P4TC_TMPL_EXT_NAME, ext->common.name))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, param);
+
+	path[0] = ext->ext_id;
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -ENOMEM;
+}
+
+static int p4tc_tmpl_ext_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			      struct nlattr *nla, char **p_name, u32 *ids,
+			      struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct p4tc_pipeline *pipeline;
+
+	pipeline = p4tc_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!(*p_name))
+		*p_name = pipeline->common.name;
+
+	return p4tc_tmpl_generic_dump(skb, ctx, &pipeline->p_ext_idr,
+				      P4TC_TMPL_EXT_IDX, extack);
+}
+
+static int p4tc_ext_inst_dump_1(struct sk_buff *skb,
+				struct p4tc_template_common *common)
+{
+	struct nlattr *param = nla_nest_start(skb, P4TC_PARAMS);
+	struct p4tc_extern_inst *inst = to_extern_inst(common);
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 path[2];
+
+	if (!param)
+		goto out_nlmsg_trim;
+
+	if (inst->common.name[0] &&
+	    nla_put_string(skb, P4TC_TMPL_EXT_NAME, inst->common.name))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, param);
+
+	path[0] = inst->ext_id;
+	path[1] = inst->ext_inst_id;
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -ENOMEM;
+}
+
+static int p4tc_ext_inst_dump(struct sk_buff *skb,
+			      struct p4tc_dump_ctx *ctx,
+			      struct nlattr *nla, char **p_name,
+			      u32 *ids, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TMPL_EXT_INST_MAX + 1] = {NULL};
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	u32 ext_id = ids[P4TC_TMPL_EXT_IDX];
+	struct net *net = sock_net(skb->sk);
+	struct p4tc_pipeline *pipeline;
+	u32 pipeid = ids[P4TC_PID_IDX];
+	int ret;
+
+	pipeline = p4tc_pipeline_find_byany(net, *p_name,
+					    pipeid, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!(*p_name))
+		*p_name = pipeline->common.name;
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_TMPL_EXT_INST_MAX, nla,
+				       tc_extern_inst_policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byanyattr(pipeline,
+							 tb[P4TC_TMPL_EXT_INST_EXT_NAME],
+							 ext_id, extack);
+	if (IS_ERR(pipe_ext))
+		return PTR_ERR(pipe_ext);
+
+	return p4tc_tmpl_generic_dump(skb, ctx, &pipe_ext->e_inst_idr,
+				      P4TC_TMPL_EXT_INST_IDX, extack);
+}
+
+const struct p4tc_template_ops p4tc_ext_inst_ops = {
+	.cu = p4tc_ext_inst_cu,
+	.fill_nlmsg = p4tc_ext_inst_fill_nlmsg,
+	.gd = p4tc_ext_inst_gd,
+	.put = p4tc_ext_inst_put,
+	.dump = p4tc_ext_inst_dump,
+	.dump_1 = p4tc_ext_inst_dump_1,
+};
+
+const struct p4tc_template_ops p4tc_tmpl_ext_ops = {
+	.cu = p4tc_tmpl_ext_cu,
+	.fill_nlmsg = p4tc_tmpl_ext_fill_nlmsg,
+	.gd = p4tc_tmpl_ext_gd,
+	.put = p4tc_tmpl_ext_put,
+	.dump = p4tc_tmpl_ext_dump,
+	.dump_1 = p4tc_tmpl_ext_dump_1,
+};
-- 
2.34.1


