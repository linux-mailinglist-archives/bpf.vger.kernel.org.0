Return-Path: <bpf+bounces-26174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7273489BECC
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75611F23C14
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 12:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14D74BE8;
	Mon,  8 Apr 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qQhSzDm3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA06A34C
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578827; cv=none; b=bPd6alU0dFr27XKxK+zOSjl0rL3HyHsKD1mlbEn4aWolkDeI15AmWIu7weE38ApiQKuNcELMTpKuDnU2JPqMDVFdzzniDInBgBL/SnA+V6N3Ur2tum6rOhV1vaQ0AcLVq1iStdqe/z/PGG9r9oTiROlaJIsqWxvBEx9H3djn71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578827; c=relaxed/simple;
	bh=KKOwWmQDK7GALhYWW5/SFfuX5v1k9q6y1R9WeNg0Sv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DO9IP/LeQFX7vvk2KxJHjIbcA/IGkSaPxYM+gTmNFH70QGRGJ9QfxZqEAonTpLY0XLHkpT/OMjKjxJlTQyyzjyeJgxATbwvLqh5ey6ZPo93HHac6aglTHp+gag8tRhc4XFGvGKVAKtxXCM/TZAD4al+Y4t8JqsoY4zaz7atCNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qQhSzDm3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d543db3a4so136411385a.0
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 05:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712578824; x=1713183624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soCSOt3DiUGIZe+PBCr6IZUedDhPW2CzzAsurirzpmY=;
        b=qQhSzDm3y+WV8cp4T1KoyJzrfOAIty940sxl9Yq+BlDULRxVdoYJmU0932VahOB2nl
         47ow6kWvCBuvqHKEzAjhuPQjw2I1SZHcqRaCuU2y/hu73lbPHJuhQbCZW0vIJv38Hve8
         osVYbxRFEsYlYH4ppnmJfElv1qwjyk3s9jbN31ElYV4YwwbfbIJZtCvBtHgyFHqeVSCv
         AytPD84tjTGaw5fQ6mmZbAdwcz6Mw7E4zKIU/koFabPjO9Etstv/wvC0FEr81TkMO3mZ
         QTJm9OIL1iB3l2FSZ/ZyRTZuW77Nv/CPuvhepeAOkzQrXFQpEe0pChcEv/3qkvBM/dKZ
         pM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578824; x=1713183624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soCSOt3DiUGIZe+PBCr6IZUedDhPW2CzzAsurirzpmY=;
        b=A+5IxO6YgDgAuIlHDfv82OTIqwiPDjWy/atj6vOa4iCsRlChSWQ22GomFoKdzBBdBS
         ttDdnTKIXY3veR+fW9pPchrf2WW/pzP+BEye/Cy4hD+YDJdh/fYxwq9yO1zQZz3m8Wp+
         s9ET7YhMblGxl9ykwWp1BwNxMiil2HQJS16XAA1M4RjbBwmrxmkhG3FtFpYKszYppPa0
         rjJSelJylSt5pbU3/lJJehm7yzFKB+abCs8Rnpo+MjmsweCWDCSP+4Hda5NLT0EwJehS
         gMYlR7QXHd6ivIR1HYcKibp+tREHh4UqWv3YrPda44yGfqTJ1yfa0MxR8a7ufPd8f6jm
         9x2A==
X-Forwarded-Encrypted: i=1; AJvYcCVrYEPVltsmTDGVBS26BS/+WvVPNN5VUJcdXCVjoYPgbKCO0OTAq8nmDhE4KomY6OUOs5rO/tdS1V4Gq1u6sjCB78lX
X-Gm-Message-State: AOJu0YyL8iEHV6NSfGagWHAh8jRkTK34HV7God2tIWM3GMhMkMc5FFNn
	v4yGTJWnj5B5zbPt9QEB9VA5/3Lg10YBuMZziSEY2gow4WiZ+9V3euQJlHBwIA==
X-Google-Smtp-Source: AGHT+IGBA0ci3Ey4K+YFSpFJtiCzGFHEiGLFIwWPCGz+ZQAUQAAgN0/OR6+dBtsDy5Mf15ooPHnpcw==
X-Received: by 2002:a05:620a:8406:b0:78b:e7ec:99a with SMTP id pc6-20020a05620a840600b0078be7ec099amr8642562qkn.10.1712578823930;
        Mon, 08 Apr 2024 05:20:23 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a148a00b0078d5d81d65fsm1936142qkj.32.2024.04.08.05.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:20:23 -0700 (PDT)
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
Subject: [PATCH net-next v15  07/15] p4tc: add template API
Date: Mon,  8 Apr 2024 08:19:52 -0400
Message-Id: <20240408122000.449238-8-jhs@mojatatu.com>
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

Add p4tc template API that will serve as infrastructure for all future
template objects (in this set pipeline, table, action, and more later)

This commit is not functional by itself. It needs the subsequent patch
to be of any use. This commit's purpose is to ease review. If something
were to break and you do git bisect to this patch it will not be helpful.
In the next release we are planning to merge the two back again.

The template API infrastructure follows the CRUD (Create, Read/get, Update,
and Delete) commands.

To issue a p4template create command the user will follow the below grammar:

tc p4template create objtype/[objpath] [objid] objparams

To show a more concrete example, to create a new pipeline (pipelines
come in the next commit), the user would issue the following command:

tc p4template create pipeline/aP4proggie pipeid 1 numtables 1 ...

Note that the user may specify an optional ID to the obj ("pipeid 1" above), if
none is specified, the kernel will assign one.

The command for update is analogous:

tc p4template update objtype/[objpath] [objid] objparams

Note that for the user may refer to the object by name (in the objpath)
or directly by ID.

Delete is also analogous:

tc p4template delete objtype/[objpath] [objid]

As is get:

tc p4template get objtype/[objpath] [objid]

One can also dump or flush template objects. This will be better
exposed in the object specific commits in this patchset

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/p4tc.h             |  53 +++++
 include/uapi/linux/p4tc.h      |  42 ++++
 include/uapi/linux/rtnetlink.h |   9 +
 net/sched/p4tc/Makefile        |   2 +-
 net/sched/p4tc/p4tc_tmpl_api.c | 361 +++++++++++++++++++++++++++++++++
 security/selinux/nlmsgtab.c    |   6 +-
 6 files changed, 471 insertions(+), 2 deletions(-)
 create mode 100644 include/net/p4tc.h
 create mode 100644 net/sched/p4tc/p4tc_tmpl_api.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
new file mode 100644
index 0000000000..e55d7b0b67
--- /dev/null
+++ b/include/net/p4tc.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_P4TC_H
+#define __NET_P4TC_H
+
+#include <uapi/linux/p4tc.h>
+#include <linux/workqueue.h>
+#include <net/sch_generic.h>
+#include <net/net_namespace.h>
+#include <linux/refcount.h>
+#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
+
+#define P4TC_PATH_MAX 3
+
+struct p4tc_dump_ctx {
+	u32 ids[P4TC_PATH_MAX];
+};
+
+struct p4tc_template_common;
+
+struct p4tc_template_ops {
+	struct p4tc_template_common *(*cu)(struct net *net, struct nlmsghdr *n,
+					   struct nlattr *nla,
+					   struct netlink_ext_ack *extack);
+	int (*put)(struct p4tc_template_common *tmpl,
+		   struct netlink_ext_ack *extack);
+	int (*gd)(struct net *net, struct sk_buff *skb, struct nlmsghdr *n,
+		  struct nlattr *nla, struct netlink_ext_ack *extack);
+	int (*fill_nlmsg)(struct net *net, struct sk_buff *skb,
+			  struct p4tc_template_common *tmpl,
+			  struct netlink_ext_ack *extack);
+	int (*dump)(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+		    struct nlattr *nla, u32 *ids,
+		    struct netlink_ext_ack *extack);
+	int (*dump_1)(struct sk_buff *skb, struct p4tc_template_common *common);
+	u32 obj_id;
+};
+
+struct p4tc_template_common {
+	char                     name[P4TC_TMPL_NAMSZ];
+	struct p4tc_template_ops *ops;
+};
+
+static inline bool p4tc_tmpl_msg_is_update(struct nlmsghdr *n)
+{
+	return n->nlmsg_type == RTM_UPDATEP4TEMPLATE;
+}
+
+int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			   struct idr *idr, int idx,
+			   struct netlink_ext_ack *extack);
+
+#endif
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 0133947c5b..22ba1c05aa 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -2,8 +2,47 @@
 #ifndef __LINUX_P4TC_H
 #define __LINUX_P4TC_H
 
+#include <linux/types.h>
+#include <linux/pkt_sched.h>
+
+/* pipeline header */
+struct p4tcmsg {
+	__u32 obj;
+};
+
+#define P4TC_MSGBATCH_SIZE 16
+
 #define P4TC_MAX_KEYSZ 512
 
+#define P4TC_TMPL_NAMSZ 32
+
+/* Root attributes */
+enum {
+	P4TC_ROOT_UNSPEC,
+	P4TC_ROOT, /* nested messages */
+	__P4TC_ROOT_MAX,
+};
+
+#define P4TC_ROOT_MAX (__P4TC_ROOT_MAX - 1)
+
+/* P4 Object types */
+enum {
+	P4TC_OBJ_UNSPEC,
+	__P4TC_OBJ_MAX,
+};
+
+#define P4TC_OBJ_MAX (__P4TC_OBJ_MAX - 1)
+
+/* P4 attributes */
+enum {
+	P4TC_UNSPEC,
+	P4TC_PATH,
+	P4TC_PARAMS,
+	__P4TC_MAX,
+};
+
+#define P4TC_MAX (__P4TC_MAX - 1)
+
 enum {
 	P4TC_T_UNSPEC,
 	P4TC_T_U8,
@@ -30,4 +69,7 @@ enum {
 
 #define P4TC_T_MAX (__P4TC_T_MAX - 1)
 
+#define P4TC_RTA(r) \
+	((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct p4tcmsg))))
+
 #endif
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 3b687d20c9..4f9ebe3e72 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -194,6 +194,15 @@ enum {
 	RTM_GETTUNNEL,
 #define RTM_GETTUNNEL	RTM_GETTUNNEL
 
+	RTM_CREATEP4TEMPLATE = 124,
+#define RTM_CREATEP4TEMPLATE	RTM_CREATEP4TEMPLATE
+	RTM_DELP4TEMPLATE,
+#define RTM_DELP4TEMPLATE	RTM_DELP4TEMPLATE
+	RTM_GETP4TEMPLATE,
+#define RTM_GETP4TEMPLATE	RTM_GETP4TEMPLATE
+	RTM_UPDATEP4TEMPLATE,
+#define RTM_UPDATEP4TEMPLATE	RTM_UPDATEP4TEMPLATE
+
 	__RTM_MAX,
 #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
 };
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index dd1358c9e8..e28dfc6eb6 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := p4tc_types.o
+obj-y := p4tc_types.o p4tc_tmpl_api.o
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
new file mode 100644
index 0000000000..bbc0c7a058
--- /dev/null
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_tmpl_api.c	P4 TC TEMPLATE API
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
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <net/sch_generic.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+#include <net/flow_offload.h>
+
+static const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1] = {
+	[P4TC_ROOT] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy p4tc_policy[P4TC_MAX + 1] = {
+	[P4TC_PATH] = { .type = NLA_BINARY,
+			.len = P4TC_PATH_MAX * sizeof(u32) },
+	[P4TC_PARAMS] = { .type = NLA_NESTED },
+};
+
+static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX + 1] = {};
+
+static bool obj_is_valid(u32 obj_id)
+{
+	if (obj_id > P4TC_OBJ_MAX)
+		return false;
+
+	return !!p4tc_ops[obj_id];
+}
+
+int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			   struct idr *idr, int idx,
+			   struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_template_common *common;
+	unsigned long id = 0;
+	unsigned long tmp;
+	int i = 0;
+
+	id = ctx->ids[idx];
+
+	idr_for_each_entry_continue_ul(idr, common, tmp, id) {
+		struct nlattr *count;
+		int ret;
+
+		if (i == P4TC_MSGBATCH_SIZE)
+			break;
+
+		count = nla_nest_start(skb, i + 1);
+		if (!count)
+			goto out_nlmsg_trim;
+		ret = common->ops->dump_1(skb, common);
+		if (ret < 0) {
+			goto out_nlmsg_trim;
+		} else if (ret) {
+			nla_nest_cancel(skb, count);
+			continue;
+		}
+		nla_nest_end(skb, count);
+
+		i++;
+	}
+
+	if (i == 0) {
+		if (!ctx->ids[idx])
+			NL_SET_ERR_MSG(extack,
+				       "There are no pipeline components");
+		return 0;
+	}
+
+	ctx->ids[idx] = id;
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -ENOMEM;
+}
+
+static int p4tc_template_put(struct net *net,
+			     struct p4tc_template_common *common,
+			     struct netlink_ext_ack *extack)
+{
+	/* Every created template is bound to a pipeline */
+	return common->ops->put(common, extack);
+}
+
+static int tc_ctl_p4_tmpl_1_send(struct sk_buff *skb, struct net *net,
+				 struct nlmsghdr *n, u32 portid)
+{
+	if (n->nlmsg_type == RTM_GETP4TEMPLATE)
+		return rtnl_unicast(skb, net, portid);
+
+	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
+			      n->nlmsg_flags & NLM_F_ECHO);
+}
+
+static int tc_ctl_p4_tmpl_1(struct sk_buff *skb, struct nlmsghdr *n,
+			    struct nlattr *nla, struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	struct net *net = sock_net(skb->sk);
+	u32 portid = NETLINK_CB(skb).portid;
+	struct p4tc_template_common *tmpl;
+	struct p4tc_template_ops *obj_op;
+	struct nlattr *tb[P4TC_MAX + 1];
+	struct p4tcmsg *t_new;
+	struct nlmsghdr *nlh;
+	struct sk_buff *nskb;
+	struct nlattr *root;
+	int ret;
+
+	/* All checks will fail at this point because obj_is_valid will return
+	 * false. The next patch will make this functional
+	 */
+	if (!obj_is_valid(t->obj)) {
+		NL_SET_ERR_MSG(extack, "Invalid object type");
+		return -EINVAL;
+	}
+
+	ret = nla_parse_nested(tb, P4TC_MAX, nla, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	nskb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!nskb)
+		return -ENOMEM;
+
+	nlh = nlmsg_put(nskb, portid, n->nlmsg_seq, n->nlmsg_type,
+			sizeof(*t), n->nlmsg_flags);
+	if (!nlh) {
+		ret = -ENOMEM;
+		goto free_skb;
+	}
+
+	t_new = nlmsg_data(nlh);
+	t_new->obj = t->obj;
+
+	root = nla_nest_start(nskb, P4TC_ROOT);
+	if (!root) {
+		ret = -ENOMEM;
+		goto free_skb;
+	}
+
+	obj_op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
+	switch (n->nlmsg_type) {
+	case RTM_CREATEP4TEMPLATE:
+	case RTM_UPDATEP4TEMPLATE:
+		if (NL_REQ_ATTR_CHECK(extack, nla, tb, P4TC_PARAMS)) {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify object attributes");
+			ret = -EINVAL;
+			goto free_skb;
+		}
+		tmpl = obj_op->cu(net, n, tb[P4TC_PARAMS], extack);
+		if (IS_ERR(tmpl)) {
+			ret = PTR_ERR(tmpl);
+			goto free_skb;
+		}
+
+		ret = obj_op->fill_nlmsg(net, nskb, tmpl, extack);
+		if (ret < 0) {
+			p4tc_template_put(net, tmpl, extack);
+			goto free_skb;
+		}
+		break;
+	case RTM_DELP4TEMPLATE:
+	case RTM_GETP4TEMPLATE:
+		ret = obj_op->gd(net, nskb, n, tb[P4TC_PARAMS], extack);
+		if (ret < 0)
+			goto free_skb;
+		break;
+	default:
+		ret = -EINVAL;
+		goto free_skb;
+	}
+
+	nlmsg_end(nskb, nlh);
+
+	return tc_ctl_p4_tmpl_1_send(nskb, net, nlh, portid);
+
+free_skb:
+	kfree_skb(nskb);
+
+	return ret;
+}
+
+static int tc_ctl_p4_tmpl_get(struct sk_buff *skb, struct nlmsghdr *n,
+			      struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	int ret;
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack,
+			       "Netlink P4TC template attributes missing");
+		return -EINVAL;
+	}
+
+	return tc_ctl_p4_tmpl_1(skb, n, tb[P4TC_ROOT], extack);
+}
+
+static int tc_ctl_p4_tmpl_delete(struct sk_buff *skb, struct nlmsghdr *n,
+				 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	int ret;
+
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack,
+			       "Netlink P4TC template attributes missing");
+		return -EINVAL;
+	}
+
+	return tc_ctl_p4_tmpl_1(skb, n, tb[P4TC_ROOT], extack);
+}
+
+static int tc_ctl_p4_tmpl_cu(struct sk_buff *skb, struct nlmsghdr *n,
+			     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	int ret = 0;
+
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack,
+			       "Netlink P4TC template attributes missing");
+		return -EINVAL;
+	}
+
+	return tc_ctl_p4_tmpl_1(skb, n, tb[P4TC_ROOT], extack);
+}
+
+static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
+				 struct netlink_callback *cb)
+{
+	struct p4tc_dump_ctx *ctx = (void *)cb->ctx;
+	struct netlink_ext_ack *extack = cb->extack;
+	u32 portid = NETLINK_CB(cb->skb).portid;
+	const struct nlmsghdr *n = cb->nlh;
+	struct p4tc_template_ops *obj_op;
+	struct nlattr *tb[P4TC_MAX + 1];
+	u32 ids[P4TC_PATH_MAX] = {};
+	struct p4tcmsg *t_new;
+	struct nlmsghdr *nlh;
+	struct nlattr *root;
+	struct p4tcmsg *t;
+	int ret;
+
+	ret = nla_parse_nested_deprecated(tb, P4TC_MAX, arg, p4tc_policy,
+					  extack);
+	if (ret < 0)
+		return ret;
+
+	t = (struct p4tcmsg *)nlmsg_data(n);
+	/* All checks will fail at this point because obj_is_valid will return
+	 * false. The next patch will make this functional
+	 */
+	if (!obj_is_valid(t->obj)) {
+		NL_SET_ERR_MSG(extack, "Invalid object type");
+		return -EINVAL;
+	}
+
+	nlh = nlmsg_put(skb, portid, n->nlmsg_seq, n->nlmsg_type,
+			sizeof(*t), n->nlmsg_flags);
+	if (!nlh)
+		return -ENOSPC;
+
+	t_new = nlmsg_data(nlh);
+	t_new->obj = t->obj;
+
+	root = nla_nest_start(skb, P4TC_ROOT);
+
+	obj_op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
+	ret = obj_op->dump(skb, ctx, tb[P4TC_PARAMS], ids, extack);
+	if (ret <= 0)
+		goto out;
+	nla_nest_end(skb, root);
+
+	nlmsg_end(skb, nlh);
+
+	return ret;
+
+out:
+	nlmsg_cancel(skb, nlh);
+	return ret;
+}
+
+static int tc_ctl_p4_tmpl_dump(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	int ret;
+
+	ret = nlmsg_parse(cb->nlh, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, cb->extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(cb->extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(cb->extack,
+			       "Netlink P4TC template attributes missing");
+		return -EINVAL;
+	}
+
+	return tc_ctl_p4_tmpl_dump_1(skb, tb[P4TC_ROOT], cb);
+}
+
+static int __init p4tc_template_init(void)
+{
+	rtnl_register(PF_UNSPEC, RTM_CREATEP4TEMPLATE, tc_ctl_p4_tmpl_cu, NULL,
+		      0);
+	rtnl_register(PF_UNSPEC, RTM_UPDATEP4TEMPLATE, tc_ctl_p4_tmpl_cu, NULL,
+		      0);
+	rtnl_register(PF_UNSPEC, RTM_DELP4TEMPLATE, tc_ctl_p4_tmpl_delete, NULL,
+		      0);
+	rtnl_register(PF_UNSPEC, RTM_GETP4TEMPLATE, tc_ctl_p4_tmpl_get,
+		      tc_ctl_p4_tmpl_dump, 0);
+	return 0;
+}
+
+subsys_initcall(p4tc_template_init);
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 8ff670cf1e..e50a1c1ffa 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -94,6 +94,10 @@ static const struct nlmsg_perm nlmsg_route_perms[] = {
 	{ RTM_NEWTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_DELTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_CREATEP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_READ },
+	{ RTM_UPDATEP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 };
 
 static const struct nlmsg_perm nlmsg_tcpdiag_perms[] = {
@@ -177,7 +181,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		 * structures at the top of this file with the new mappings
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
-		BUILD_BUG_ON(RTM_MAX != (RTM_NEWTUNNEL + 3));
+		BUILD_BUG_ON(RTM_MAX != (RTM_CREATEP4TEMPLATE + 3));
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
 				 sizeof(nlmsg_route_perms));
 		break;
-- 
2.34.1


