Return-Path: <bpf+bounces-4636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E125974DEF2
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 22:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6341C20B13
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A93A1642C;
	Mon, 10 Jul 2023 20:12:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444AF1642D;
	Mon, 10 Jul 2023 20:12:32 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACB612F;
	Mon, 10 Jul 2023 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kdrjvTcbnVTCNlBeJF7MeDpQfsAEniQEdj+sxfb9ALA=; b=nbKB2a66kQYQpV7YWXe0gEk3EU
	JIwTy4t5OrlLmjOXKDsfPVtO3A5eE7dFxL1/sPW/sRy1ThcOfRqupEV4+vx4vcWRPqqhuRHso4dqJ
	7Ldd9F4yyMHSbGJb0w099Z6Et1hKyLj4/wRdHOq4H5KuQsldxgqs32qtlwB6pvWbzAY1QiAI7lfdE
	crQ0ltdvPlJaawzP/+xBEBykkvqnxeKmF0gstiszGfDmfP9S+KI206i6H0sMMilcpQuzfn+b4+edF
	M0PGoyXHnvfx/zybUGUhg5eQisZbS/lPZduv0eF19d4L8pqOEVx18YFgrwoXgJNsOltjgTwZXAdhU
	x1eu/rHA==;
Received: from 12.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.12] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIxFF-000E5f-5e; Mon, 10 Jul 2023 22:12:29 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	sdf@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	dxu@dxuuu.xyz,
	joe@cilium.io,
	toke@kernel.org,
	davem@davemloft.net,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 6/8] bpftool: Extend net dump with tcx progs
Date: Mon, 10 Jul 2023 22:12:16 +0200
Message-Id: <20230710201218.19460-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230710201218.19460-1-daniel@iogearbox.net>
References: <20230710201218.19460-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26965/Mon Jul 10 09:29:40 2023)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to dump fd-based attach types via bpftool. This includes both
the tc BPF link and attach ops programs. Dumped information contain the
attach location, function entry name, program ID and link ID when applicable.

Example with tc BPF link:

  # ./bpftool net
  xdp:

  tc:
  bond0(4) tcx/ingress cil_from_netdev prog id 784 link id 10
  bond0(4) tcx/egress cil_to_netdev prog id 804 link id 11

  flow_dissector:

  netfilter:

Example with tc BPF attach ops:

  # ./bpftool net
  xdp:

  tc:
  bond0(4) tcx/ingress cil_from_netdev prog id 654
  bond0(4) tcx/egress cil_to_netdev prog id 672

  flow_dissector:

  netfilter:

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/bpf/bpftool/net.c | 86 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 26a49965bf71..22af0a81458c 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -76,6 +76,11 @@ static const char * const attach_type_strings[] = {
 	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
 };
 
+static const char * const attach_loc_strings[] = {
+	[BPF_TCX_INGRESS]		= "tcx/ingress",
+	[BPF_TCX_EGRESS]		= "tcx/egress",
+};
+
 const size_t net_attach_type_size = ARRAY_SIZE(attach_type_strings);
 
 static enum net_attach_type parse_attach_type(const char *str)
@@ -422,8 +427,80 @@ static int dump_filter_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 			      filter_info->devname, filter_info->ifindex);
 }
 
-static int show_dev_tc_bpf(int sock, unsigned int nl_pid,
-			   struct ip_devname_ifindex *dev)
+static const char *flags_strings(__u32 flags)
+{
+	return json_output ? "none" : "";
+}
+
+static int __show_dev_tc_bpf_name(__u32 id, char *name, size_t len)
+{
+	struct bpf_prog_info info = {};
+	__u32 ilen = sizeof(info);
+	int fd, ret;
+
+	fd = bpf_prog_get_fd_by_id(id);
+	if (fd < 0)
+		return fd;
+	ret = bpf_obj_get_info_by_fd(fd, &info, &ilen);
+	if (ret < 0)
+		goto out;
+	ret = -ENOENT;
+	if (info.name[0]) {
+		get_prog_full_name(&info, fd, name, len);
+		ret = 0;
+	}
+out:
+	close(fd);
+	return ret;
+}
+
+static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
+			      const enum bpf_attach_type loc)
+{
+	__u32 prog_flags[64] = {}, link_flags[64] = {}, i;
+	__u32 prog_ids[64] = {}, link_ids[64] = {};
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	char prog_name[MAX_PROG_FULL_NAME];
+	int ret;
+
+	optq.prog_ids = prog_ids;
+	optq.prog_attach_flags = prog_flags;
+	optq.link_ids = link_ids;
+	optq.link_attach_flags = link_flags;
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	ret = bpf_prog_query_opts(dev->ifindex, loc, &optq);
+	if (ret)
+		return;
+	for (i = 0; i < optq.count; i++) {
+		NET_START_OBJECT;
+		NET_DUMP_STR("devname", "%s", dev->devname);
+		NET_DUMP_UINT("ifindex", "(%u)", dev->ifindex);
+		NET_DUMP_STR("kind", " %s", attach_loc_strings[loc]);
+		ret = __show_dev_tc_bpf_name(prog_ids[i], prog_name,
+					     sizeof(prog_name));
+		if (!ret)
+			NET_DUMP_STR("name", " %s", prog_name);
+		NET_DUMP_UINT("prog_id", " prog id %u", prog_ids[i]);
+		if (prog_flags[i])
+			NET_DUMP_STR("prog_flags", "%s", flags_strings(prog_flags[i]));
+		if (link_ids[i])
+			NET_DUMP_UINT("link_id", " link id %u",
+				      link_ids[i]);
+		if (link_flags[i])
+			NET_DUMP_STR("link_flags", "%s", flags_strings(link_flags[i]));
+		NET_END_OBJECT_FINAL;
+	}
+}
+
+static void show_dev_tc_bpf(struct ip_devname_ifindex *dev)
+{
+	__show_dev_tc_bpf(dev, BPF_TCX_INGRESS);
+	__show_dev_tc_bpf(dev, BPF_TCX_EGRESS);
+}
+
+static int show_dev_tc_bpf_classic(int sock, unsigned int nl_pid,
+				   struct ip_devname_ifindex *dev)
 {
 	struct bpf_filter_t filter_info;
 	struct bpf_tcinfo_t tcinfo;
@@ -790,8 +867,9 @@ static int do_show(int argc, char **argv)
 	if (!ret) {
 		NET_START_ARRAY("tc", "%s:\n");
 		for (i = 0; i < dev_array.used_len; i++) {
-			ret = show_dev_tc_bpf(sock, nl_pid,
-					      &dev_array.devices[i]);
+			show_dev_tc_bpf(&dev_array.devices[i]);
+			ret = show_dev_tc_bpf_classic(sock, nl_pid,
+						      &dev_array.devices[i]);
 			if (ret)
 				break;
 		}
-- 
2.34.1


