Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE53DE3C3
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhHCBEA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:65281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232849AbhHCBD7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:03:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327835"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327835"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480109"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:48 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: [[RFC xdp-hints] 03/16] tools/bpf: Query XDP metadata BTF ID
Date:   Mon,  2 Aug 2021 18:03:18 -0700
Message-Id: <20210803010331.39453-4-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

When dumping bpf net information, also query XDP MD BTF attributes:

$ /usr/local/sbin/bpftool net
xdp:
mlx0(3) md_btf_id(1) md_btf_enabled(0)

tc:

flow_dissector:

Issue: 2114293
Change-Id: Ifef542ecf3defe4204947618c07cc3eac45b39f9
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
---
 tools/bpf/bpftool/netlink_dumper.c | 21 +++++++++++++++++----
 tools/include/uapi/linux/if_link.h |  2 ++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/netlink_dumper.c b/tools/bpf/bpftool/netlink_dumper.c
index 5f65140b003b..17807a3312ff 100644
--- a/tools/bpf/bpftool/netlink_dumper.c
+++ b/tools/bpf/bpftool/netlink_dumper.c
@@ -29,23 +29,36 @@ static void xdp_dump_prog_id(struct nlattr **tb, int attr,
 static int do_xdp_dump_one(struct nlattr *attr, unsigned int ifindex,
 			   const char *name)
 {
+	unsigned char mode = XDP_ATTACHED_NONE;
 	struct nlattr *tb[IFLA_XDP_MAX + 1];
-	unsigned char mode;
+	unsigned char md_btf_enabled = 0;
+	unsigned int md_btf_id = 0;
+	bool attached;
 
 	if (libbpf_nla_parse_nested(tb, IFLA_XDP_MAX, attr, NULL) < 0)
 		return -1;
 
-	if (!tb[IFLA_XDP_ATTACHED])
+	if (!tb[IFLA_XDP_ATTACHED] && !tb[IFLA_XDP_MD_BTF_ID])
 		return 0;
 
-	mode = libbpf_nla_getattr_u8(tb[IFLA_XDP_ATTACHED]);
-	if (mode == XDP_ATTACHED_NONE)
+	if (tb[IFLA_XDP_ATTACHED])
+		mode = libbpf_nla_getattr_u8(tb[IFLA_XDP_ATTACHED]);
+
+	if (tb[IFLA_XDP_MD_BTF_ID]) {
+		md_btf_id = libbpf_nla_getattr_u32(tb[IFLA_XDP_MD_BTF_ID]);
+		md_btf_enabled = libbpf_nla_getattr_u8(tb[IFLA_XDP_MD_BTF_STATE]);
+	}
+
+	attached = (mode != XDP_ATTACHED_NONE);
+	if (!attached && !md_btf_id)
 		return 0;
 
 	NET_START_OBJECT;
 	if (name)
 		NET_DUMP_STR("devname", "%s", name);
 	NET_DUMP_UINT("ifindex", "(%d)", ifindex);
+	NET_DUMP_UINT("md_btf_id", " md_btf_id(%d)", md_btf_id);
+	NET_DUMP_UINT("md_btf_enabled", " md_btf_enabled(%d)", md_btf_enabled);
 
 	if (mode == XDP_ATTACHED_MULTI) {
 		if (json_output) {
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index d208b2af697f..9b45bb3327c2 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -992,6 +992,8 @@ enum {
 	IFLA_XDP_SKB_PROG_ID,
 	IFLA_XDP_HW_PROG_ID,
 	IFLA_XDP_EXPECTED_FD,
+	IFLA_XDP_MD_BTF_ID,
+	IFLA_XDP_MD_BTF_STATE,
 	__IFLA_XDP_MAX,
 };
 
-- 
2.32.0

