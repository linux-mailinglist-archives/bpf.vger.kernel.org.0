Return-Path: <bpf+bounces-5025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D720753D04
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 16:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00061C21503
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AD14ABD;
	Fri, 14 Jul 2023 14:16:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9914AAA;
	Fri, 14 Jul 2023 14:16:07 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA11989;
	Fri, 14 Jul 2023 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JI5f5p9OWdA5zEAtGiPkDSI0Of9ph0t5gpFxBAcpqLE=; b=CX0Os9dM1CRlrmFifp/i3pHjqu
	AK9n4IsE7fRodl1fq58GNTu54fJqicTZbQVYtNDA7lwqWyqbyodgZui6XJFABSm8yotZqmd4Bv9G8
	YRymLuawlp3yUSwBbFXlkj1rdFLGK9KgpcDJB3rz5pqiM2OGbUO93SN3t5JUdlniCrb5ef5mbcUGM
	hY9FB0OXP2FDe1ZvwjwPWrXzWxPKdwUTaugVxRFkMApe/ik50lDQigipd36U4zGH7Qm44MGhhGJdT
	NreoVTO2c9KNp2Jrg5m9c6tDQGtDf45TzKgABGs5z0AOhN3g+jPSm3oe34nS3+MK+hpJaKeaSh7uB
	EGWX+zgQ==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qKJaV-000B38-JE; Fri, 14 Jul 2023 16:16:03 +0200
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
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v5 6/8] bpftool: Extend net dump with tcx progs
Date: Fri, 14 Jul 2023 16:15:43 +0200
Message-Id: <20230714141545.26904-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230714141545.26904-1-daniel@iogearbox.net>
References: <20230714141545.26904-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26969/Fri Jul 14 09:28:15 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to dump fd-based attach types via bpftool. This includes both
the tc BPF link and attach ops programs. Dumped information contain the
attach location, function entry name, program ID and link ID when applicable.

Example with tc BPF link:

  # ./bpftool net
  xdp:

  tc:
  bond0(4) tcx/ingress cil_from_netdev prog_id 784 link_id 10
  bond0(4) tcx/egress cil_to_netdev prog_id 804 link_id 11

  flow_dissector:

  netfilter:

Example with tc BPF attach ops:

  # ./bpftool net
  xdp:

  tc:
  bond0(4) tcx/ingress cil_from_netdev prog_id 654
  bond0(4) tcx/egress cil_to_netdev prog_id 672

  flow_dissector:

  netfilter:

Currently, permanent flags are not yet supported, so 'unknown' ones are dumped
via NET_DUMP_UINT_ONLY() and once we do have permanent ones, we dump them as
human readable string.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 .../bpf/bpftool/Documentation/bpftool-net.rst | 26 ++---
 tools/bpf/bpftool/net.c                       | 98 ++++++++++++++++++-
 tools/bpf/bpftool/netlink_dumper.h            |  8 ++
 3 files changed, 116 insertions(+), 16 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index f4e0a516335a..5e2abd3de5ab 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -4,7 +4,7 @@
 bpftool-net
 ================
 -------------------------------------------------------------------------------
-tool for inspection of netdev/tc related bpf prog attachments
+tool for inspection of networking related bpf prog attachments
 -------------------------------------------------------------------------------
 
 :Manual section: 8
@@ -37,10 +37,13 @@ DESCRIPTION
 	**bpftool net { show | list }** [ **dev** *NAME* ]
 		  List bpf program attachments in the kernel networking subsystem.
 
-		  Currently, only device driver xdp attachments and tc filter
-		  classification/action attachments are implemented, i.e., for
-		  program types **BPF_PROG_TYPE_SCHED_CLS**,
-		  **BPF_PROG_TYPE_SCHED_ACT** and **BPF_PROG_TYPE_XDP**.
+		  Currently, device driver xdp attachments, tcx and old-style tc
+		  classifier/action attachments, flow_dissector as well as netfilter
+		  attachments are implemented, i.e., for
+		  program types **BPF_PROG_TYPE_XDP**, **BPF_PROG_TYPE_SCHED_CLS**,
+		  **BPF_PROG_TYPE_SCHED_ACT**, **BPF_PROG_TYPE_FLOW_DISSECTOR**,
+		  **BPF_PROG_TYPE_NETFILTER**.
+
 		  For programs attached to a particular cgroup, e.g.,
 		  **BPF_PROG_TYPE_CGROUP_SKB**, **BPF_PROG_TYPE_CGROUP_SOCK**,
 		  **BPF_PROG_TYPE_SOCK_OPS** and **BPF_PROG_TYPE_CGROUP_SOCK_ADDR**,
@@ -49,12 +52,13 @@ DESCRIPTION
 		  bpf programs, users should consult other tools, e.g., iproute2.
 
 		  The current output will start with all xdp program attachments, followed by
-		  all tc class/qdisc bpf program attachments. Both xdp programs and
-		  tc programs are ordered based on ifindex number. If multiple bpf
-		  programs attached to the same networking device through **tc filter**,
-		  the order will be first all bpf programs attached to tc classes, then
-		  all bpf programs attached to non clsact qdiscs, and finally all
-		  bpf programs attached to root and clsact qdisc.
+		  all tcx, then tc class/qdisc bpf program attachments, then flow_dissector
+		  and finally netfilter programs. Both xdp programs and tcx/tc programs are
+		  ordered based on ifindex number. If multiple bpf programs attached
+		  to the same networking device through **tc**, the order will be first
+		  all bpf programs attached to tcx, then tc classes, then all bpf programs
+		  attached to non clsact qdiscs, and finally all bpf programs attached
+		  to root and clsact qdisc.
 
 	**bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** ]
 		  Attach bpf program *PROG* to network interface *NAME* with
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 26a49965bf71..66a8ce8ae012 100644
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
@@ -422,8 +427,89 @@ static int dump_filter_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 			      filter_info->devname, filter_info->ifindex);
 }
 
-static int show_dev_tc_bpf(int sock, unsigned int nl_pid,
-			   struct ip_devname_ifindex *dev)
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
+	__u32 prog_flags[64] = {}, link_flags[64] = {}, i, j;
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
+		NET_DUMP_UINT("prog_id", " prog_id %u ", prog_ids[i]);
+		if (prog_flags[i] || json_output) {
+			NET_START_ARRAY("prog_flags", "%s ");
+			for (j = 0; prog_flags[i] && j < 32; j++) {
+				if (!(prog_flags[i] & (1 << j)))
+					continue;
+				NET_DUMP_UINT_ONLY(1 << j);
+			}
+			NET_END_ARRAY("");
+		}
+		if (link_ids[i] || json_output) {
+			NET_DUMP_UINT("link_id", "link_id %u ", link_ids[i]);
+			if (link_flags[i] || json_output) {
+				NET_START_ARRAY("link_flags", "%s ");
+				for (j = 0; link_flags[i] && j < 32; j++) {
+					if (!(link_flags[i] & (1 << j)))
+						continue;
+					NET_DUMP_UINT_ONLY(1 << j);
+				}
+				NET_END_ARRAY("");
+			}
+		}
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
@@ -790,8 +876,9 @@ static int do_show(int argc, char **argv)
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
@@ -839,7 +926,8 @@ static int do_help(int argc, char **argv)
 		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }\n"
 		"       " HELP_SPEC_OPTIONS " }\n"
 		"\n"
-		"Note: Only xdp and tc attachments are supported now.\n"
+		"Note: Only xdp, tcx, tc, flow_dissector and netfilter attachments\n"
+		"      are currently supported.\n"
 		"      For progs attached to cgroups, use \"bpftool cgroup\"\n"
 		"      to dump program attachments. For program types\n"
 		"      sk_{filter,skb,msg,reuseport} and lwt/seg6, please\n"
diff --git a/tools/bpf/bpftool/netlink_dumper.h b/tools/bpf/bpftool/netlink_dumper.h
index 774af6c62ef5..96318106fb49 100644
--- a/tools/bpf/bpftool/netlink_dumper.h
+++ b/tools/bpf/bpftool/netlink_dumper.h
@@ -76,6 +76,14 @@
 		fprintf(stdout, fmt_str, val);		\
 }
 
+#define NET_DUMP_UINT_ONLY(str)				\
+{							\
+	if (json_output)				\
+		jsonw_uint(json_wtr, str);		\
+	else						\
+		fprintf(stdout, "%u ", str);		\
+}
+
 #define NET_DUMP_STR(name, fmt_str, str)		\
 {							\
 	if (json_output)				\
-- 
2.34.1


