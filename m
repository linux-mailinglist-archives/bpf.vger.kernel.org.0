Return-Path: <bpf+bounces-7048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE99A770AF6
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADC11C20FA8
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462221D29;
	Fri,  4 Aug 2023 21:30:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05561AA9F;
	Fri,  4 Aug 2023 21:30:31 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BF04C04;
	Fri,  4 Aug 2023 14:30:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcb15aa074so1742342a34.0;
        Fri, 04 Aug 2023 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691184601; x=1691789401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHueQwLIWCEz3XlJcUxmIZmOh2PU2xR1L0WHNOS+ItE=;
        b=NubayiF9StvSreesK/se9xgtK3Pj1akbCsTAN1F1SqvLsIuHg8gPSTuRlv9zfTbwln
         Ei4zEyKppfLO3i1hCk9UD/vA0X9pjgK+sRuD4UPJJMjRr/mf4MfvtSiYyovbRSgP4wj+
         l7icgc8fH3KrL5PJ2kq5VleKHu9M+3agQdrXmPAz05wQjfOMJSvT7e4LoBX1FXj68w1s
         97CeRGH7CWLuESRUNAGYgf/h/GPSseyUK+3WrvblYKXbT/AMBp5DR/Ahk1YazZ1kiMXx
         o43uB2S7e+zSpFjfkr4/02Avb6eCyVlJujjNxvAxwZvErB4XknSqv4M63PH56c6vQSaT
         I+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691184601; x=1691789401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHueQwLIWCEz3XlJcUxmIZmOh2PU2xR1L0WHNOS+ItE=;
        b=OXfqErhVQzPiNAwxNZkdo1qkll6JdUF28Mdt9Dcw+rNXjZofD1ThzdIsMlnvdJDIl0
         LGzoKqYg5+ocCJD0RRmk5bLSEQtuzGYA8apoxeI8e0x9BGmrWbONImaqQrlLnoH5qPmZ
         k/PbhVwzRa0vI3nBXqXKrlMhEUp08WjUS+cGeRN4gIhjgcixTtIQhFllYGqGSkOQWcS4
         J+v0l7a4HWOmZTx/fR5f4L8zomSd8I5lUBYPsDiBec5xNWGKfe0Ut60X/ZMib0Ilv0JB
         PYfs90KdET2ly6iwhx9VPG8xMZoby/GyFCpBrvxuwFQfbn1ivyXkoQZJ8ydWuqklaCXW
         /wUg==
X-Gm-Message-State: AOJu0Yw2FxXm+lrQ0dgPePoGE/kTH3UI9gPvNHG8luakEsNAjjM5kBIj
	JmAolShJmnuBHt6y9LVdBmo=
X-Google-Smtp-Source: AGHT+IG3aZIhyXFX9KbGK82uqdRKKBFUjUpR6ElmdBZkW6b4N2NcbiOW/DkYL0HXX4uI+rT2YHfi1g==
X-Received: by 2002:a05:6830:4101:b0:6bb:132f:a785 with SMTP id w1-20020a056830410100b006bb132fa785mr769625ott.10.1691184601561;
        Fri, 04 Aug 2023 14:30:01 -0700 (PDT)
Received: from localhost.localdomain (ip98-167-164-238.ph.ph.cox.net. [98.167.164.238])
        by smtp.gmail.com with ESMTPSA id e20-20020a05683013d400b006b9d21100d0sm1645420otq.64.2023.08.04.14.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:30:01 -0700 (PDT)
From: Matthew Cover <werekraken@gmail.com>
X-Google-Original-From: Matthew Cover <matthew.cover@stackpath.com>
To: Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Matthew Cover <matthew.cover@stackpath.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] Add bnxt_netlink to facilitate representor pair configurations.
Date: Fri,  4 Aug 2023 14:29:54 -0700
Message-Id: <20230804212954.98868-1-matthew.cover@stackpath.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To leverage the SmartNIC capabilities available in Broadcom
NetXtreme-C/E ethernet devices, representor pairs must be configured
via bnxt-ctl.

Without bnxt_netlink as a registered family, bnxt-ctl errors as seen
below, even for the most basic of subcommands.

  $ sudo bnxt-ctl show-pair
  Error: Failed to resolve family for name: bnxt_netlink, Cannot allocate memory

With this patch, bnxt-ctl functions as expected providing display of
and changes to representor pair configurations.

  $ sudo bnxt-ctl show-pair
  Representor Pair[4]: interface: enp65s0f0  name: 0000:06:00.0  state: down
    member(a): Linux PF index 2 Firmware function id: 0x3
  ...

This patch is a minimally modified port of the bnxt_netlink code
found in out-of-tree bnxt_en-1.10.2-218.1.182.15.tar.gz. The
out-of-tree driver contains both the GPL-2.0 in the file COPYING
and a GPL comment in each source file.

Signed-off-by: Matthew Cover <matthew.cover@stackpath.com>
---
 drivers/net/ethernet/broadcom/bnxt/Makefile       |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |   6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.c | 231 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.h |  41 ++++
 4 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index 2bc2b70..31e154f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BNXT) += bnxt_en.o
 
-bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_dim.o bnxt_coredump.o
+bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_netlink.o bnxt_dim.o bnxt_coredump.o
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6a643aa..a33c7b6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -67,6 +67,7 @@
 #include "bnxt_dcb.h"
 #include "bnxt_xdp.h"
 #include "bnxt_ptp.h"
+#include "bnxt_netlink.h"
 #include "bnxt_vfr.h"
 #include "bnxt_tc.h"
 #include "bnxt_devlink.h"
@@ -14118,6 +14119,10 @@ static int __init bnxt_init(void)
 {
 	int err;
 
+	err = bnxt_nl_register();
+	if (err)
+		pr_info("%s : failed to load\n", BNXT_NL_NAME);
+
 	bnxt_debug_init();
 	err = pci_register_driver(&bnxt_pci_driver);
 	if (err) {
@@ -14130,6 +14135,7 @@ static int __init bnxt_init(void)
 
 static void __exit bnxt_exit(void)
 {
+	bnxt_nl_unregister();
 	pci_unregister_driver(&bnxt_pci_driver);
 	if (bnxt_pf_wq)
 		destroy_workqueue(bnxt_pf_wq);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.c
new file mode 100644
index 0000000..48c1357
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.c
@@ -0,0 +1,231 @@
+/* Broadcom NetXtreme-C/E network driver.
+ *
+ * Copyright (c) 2014-2016 Broadcom Corporation
+ * Copyright (c) 2016-2017 Broadcom Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include "bnxt_hsi.h"
+#include "bnxt_netlink.h"
+#include "bnxt.h"
+#include "bnxt_hwrm.h"
+
+/* attribute policy */
+static struct nla_policy bnxt_netlink_policy[BNXT_NUM_ATTRS] = {
+	[BNXT_ATTR_PID] = { .type = NLA_U32 },
+	[BNXT_ATTR_IF_INDEX] = { .type = NLA_U32 },
+	[BNXT_ATTR_REQUEST] = { .type = NLA_BINARY },
+	[BNXT_ATTR_RESPONSE] = { .type = NLA_BINARY },
+};
+
+static struct genl_family bnxt_netlink_family;
+
+static int bnxt_parse_attrs(struct nlattr **a, struct bnxt **bp,
+			    struct net_device **dev)
+{
+	pid_t pid;
+	struct net *ns = NULL;
+	const char *drivername;
+
+	if (!a[BNXT_ATTR_PID]) {
+		netdev_err(*dev, "No process ID specified\n");
+		goto err_inval;
+	}
+	pid = nla_get_u32(a[BNXT_ATTR_PID]);
+	ns = get_net_ns_by_pid(pid);
+	if (IS_ERR(ns)) {
+		netdev_err(*dev, "Invalid net namespace for pid %d (err: %ld)\n",
+			pid, PTR_ERR(ns));
+		goto err_inval;
+	}
+
+	if (!a[BNXT_ATTR_IF_INDEX]) {
+		netdev_err(*dev, "No interface index specified\n");
+		goto err_inval;
+	}
+	*dev = dev_get_by_index(ns, nla_get_u32(a[BNXT_ATTR_IF_INDEX]));
+
+	put_net(ns);
+	ns = NULL;
+	if (!*dev) {
+		netdev_err(*dev, "Invalid network interface index %d (err: %ld)\n",
+		       nla_get_u32(a[BNXT_ATTR_IF_INDEX]), PTR_ERR(ns));
+		goto err_inval;
+	}
+	if (!(*dev)->dev.parent || !(*dev)->dev.parent->driver ||
+	    !(*dev)->dev.parent->driver->name) {
+		netdev_err(*dev, "Unable to get driver name for device %s\n",
+		       (*dev)->name);
+		goto err_inval;
+	}
+	drivername = (*dev)->dev.parent->driver->name;
+	if (strcmp(drivername, DRV_MODULE_NAME)) {
+		netdev_err(*dev, "Device %s (%s) is not a %s device!\n",
+		       (*dev)->name, drivername, DRV_MODULE_NAME);
+		goto err_inval;
+	}
+	*bp = netdev_priv(*dev);
+	if (!*bp) {
+		netdev_warn((*bp)->dev, "No private data\n");
+		goto err_inval;
+	}
+
+	return 0;
+
+err_inval:
+	if (ns && !IS_ERR(ns))
+		put_net(ns);
+	return -EINVAL;
+}
+
+/* handler */
+static int bnxt_netlink_hwrm(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr **a = info->attrs;
+	struct net_device *dev = NULL;
+	struct sk_buff *reply = NULL;
+	struct input *req, *nl_req;
+	struct bnxt *bp = NULL;
+	struct output *resp;
+	int len, rc;
+	void *hdr;
+
+	rc = bnxt_parse_attrs(a, &bp, &dev);
+	if (rc)
+		goto err_rc;
+
+	if (!bp) {
+		rc = -EINVAL;
+		goto err_rc;
+	}
+
+	if (!bp->hwrm_dma_pool) {
+		netdev_warn(bp->dev, "HWRM interface not currently available on %s\n",
+		       dev->name);
+		rc = -EINVAL;
+		goto err_rc;
+	}
+
+	if (!a[BNXT_ATTR_REQUEST]) {
+		netdev_warn(bp->dev, "No request specified\n");
+		rc = -EINVAL;
+		goto err_rc;
+	}
+	len = nla_len(a[BNXT_ATTR_REQUEST]);
+	nl_req = nla_data(a[BNXT_ATTR_REQUEST]);
+
+	reply = genlmsg_new(PAGE_SIZE, GFP_KERNEL);
+	if (!reply) {
+		netdev_warn(bp->dev, "Error: genlmsg_new failed\n");
+		rc = -ENOMEM;
+		goto err_rc;
+	}
+
+	rc = hwrm_req_init(bp, req, nl_req->req_type);
+	if (rc)
+		goto err_rc;
+
+	rc = hwrm_req_replace(bp, req, nl_req, len);
+	if (rc)
+		goto err_rc;
+
+	resp = hwrm_req_hold(bp, req);
+	rc = hwrm_req_send_silent(bp, req);
+	if (rc) {
+		/*
+		 * Indicate success for the hwrm transport, while letting
+		 * the hwrm error be passed back to the netlink caller in
+		 * the response message.  Caller is responsible for handling
+		 * any errors.
+		 *
+		 * no kernel warnings are logged in this case.
+		 */
+		rc = 0;
+	}
+	hdr = genlmsg_put_reply(reply, info, &bnxt_netlink_family, 0,
+				BNXT_CMD_HWRM);
+	if (nla_put(reply, BNXT_ATTR_RESPONSE, resp->resp_len, resp)) {
+		netdev_warn(bp->dev, "No space for response attribte\n");
+		hwrm_req_drop(bp, req);
+		rc = -ENOMEM;
+		goto err_rc;
+	}
+	genlmsg_end(reply, hdr);
+	hwrm_req_drop(bp, req);
+
+	dev_put(dev);
+	dev = NULL;
+
+	return genlmsg_reply(reply, info);
+
+err_rc:
+	if (reply && !IS_ERR(reply))
+		kfree_skb(reply);
+	if (dev && !IS_ERR(dev))
+		dev_put(dev);
+
+	if (bp)
+		netdev_warn(bp->dev, "returning with error code %d\n", rc);
+
+	return rc;
+}
+
+/* handlers */
+#if defined(HAVE_GENL_REG_OPS_GRPS) || !defined(HAVE_GENL_REG_FAMILY_WITH_OPS)
+static const struct genl_ops bnxt_netlink_ops[] = {
+#else
+static struct genl_ops bnxt_netlink_ops[] = {
+#endif
+	{
+		.cmd = BNXT_CMD_HWRM,
+		.flags = GENL_ADMIN_PERM, /* Req's CAP_NET_ADMIN privilege */
+#ifndef HAVE_GENL_POLICY
+		.policy = bnxt_netlink_policy,
+#endif
+		.doit = bnxt_netlink_hwrm,
+		.dumpit = NULL,
+	},
+};
+
+/* family definition */
+static struct genl_family bnxt_netlink_family = {
+#ifdef HAVE_GENL_ID_GENERATE
+	.id = GENL_ID_GENERATE,
+#endif
+	.hdrsize = 0,
+	.name = BNXT_NL_NAME,
+	.version = BNXT_NL_VER,
+	.maxattr = BNXT_NUM_ATTRS,
+#ifdef HAVE_GENL_POLICY
+	.policy = bnxt_netlink_policy,
+#endif
+#ifndef HAVE_GENL_REG_FAMILY_WITH_OPS
+	.ops = bnxt_netlink_ops,
+	.n_ops = ARRAY_SIZE(bnxt_netlink_ops)
+#endif
+};
+
+int bnxt_nl_register(void)
+{
+#ifndef HAVE_GENL_REG_FAMILY_WITH_OPS
+	return genl_register_family(&bnxt_netlink_family);
+#elif defined(HAVE_GENL_REG_OPS_GRPS)
+	return genl_register_family_with_ops(&bnxt_netlink_family,
+					     bnxt_netlink_ops);
+#else
+	return genl_register_family_with_ops(&bnxt_netlink_family,
+					     bnxt_netlink_ops,
+					     ARRAY_SIZE(bnxt_netlink_ops));
+#endif
+
+	return 0;
+}
+
+int bnxt_nl_unregister(void)
+{
+	return genl_unregister_family(&bnxt_netlink_family);
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.h
new file mode 100644
index 0000000..6939cd4
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_netlink.h
@@ -0,0 +1,41 @@
+/* Broadcom NetXtreme-C/E network driver.
+ *
+ * Copyright (c) 2014-2016 Broadcom Corporation
+ * Copyright (c) 2016-2017 Broadcom Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+#ifndef __BNXT_NETLINK_H__
+#define __BNXT_NETLINK_H__
+
+#include <net/genetlink.h>
+#include <net/netlink.h>
+
+/* commands */
+enum {
+	BNXT_CMD_UNSPEC,
+	BNXT_CMD_HWRM,
+	BNXT_NUM_CMDS
+};
+#define BNXT_CMD_MAX (BNXT_NUM_CMDS - 1)
+
+/* attributes */
+enum {
+	BNXT_ATTR_UNSPEC,
+	BNXT_ATTR_PID,
+	BNXT_ATTR_IF_INDEX,
+	BNXT_ATTR_REQUEST,
+	BNXT_ATTR_RESPONSE,
+	BNXT_NUM_ATTRS
+};
+#define BNXT_ATTR_MAX (BNXT_NUM_ATTRS - 1)
+
+#define BNXT_NL_NAME "bnxt_netlink"
+#define BNXT_NL_VER  1
+
+int bnxt_nl_register(void);
+int bnxt_nl_unregister(void);
+
+#endif
-- 
1.8.3.1


