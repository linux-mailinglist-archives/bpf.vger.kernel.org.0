Return-Path: <bpf+bounces-4461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129BF74B5D0
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436DD1C21038
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92911772B;
	Fri,  7 Jul 2023 17:26:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750617721;
	Fri,  7 Jul 2023 17:26:04 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4FE26A1;
	Fri,  7 Jul 2023 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=eo116LxlqlHMIw1RVuDCBvtGGdCHQXifwcTDbb1K1gg=; b=Zh+vn4vPlKiugP4ewhSKozILJ4
	b/owsZXTQtdzvd5VsnL/xkSvuuCbtlbMoOiAmLI5Qnw+Ur3fUvafMsa6mqj1eoxiKhN2CoXyzdYp8
	h6VRQ8zaU464qlI4NmQqFBDBniPbi1IKcx2yqmDjakvYIds/oSysYuSAN82fSyEPHJi+u/0KuDpcY
	rsMMhc/+11t59u9hVhvFYrzflkKqAUsI1ul+6FUtkXyeSmN/L28nLXDfyKkMq6NRz6c4auNk3qa0Z
	1vKETxtLv1N7vaajGqOQCiXAD54lQ0pgpaYFOIYs/1UPxgy3HS39zJtxE+84xN070a6ciL5laPBsL
	iwu4QRkg==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qHpCg-000Ayn-Ti; Fri, 07 Jul 2023 19:25:10 +0200
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
Subject: [PATCH bpf-next v3 6/8] bpftool: Extend net dump with tcx progs
Date: Fri,  7 Jul 2023 19:24:53 +0200
Message-Id: <20230707172455.7634-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230707172455.7634-1-daniel@iogearbox.net>
References: <20230707172455.7634-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26962/Fri Jul  7 09:29:02 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to dump fd-based attach types via bpftool. This includes both
the tc BPF link and attach ops programs. Dumped information contain the
attach location, function entry name, program ID and link ID when applicable.

Example with tc BPF link:

  # ./bpftool net
  xdp:

  tc:
  bond0(4) bpf/ingress cil_from_netdev prog id 784 link id 10
  bond0(4) bpf/egress cil_to_netdev prog id 804 link id 11

  flow_dissector:

  netfilter:

Example with tc BPF attach ops:

  # ./bpftool net
  xdp:

  tc:
  bond0(4) bpf/ingress cil_from_netdev prog id 654
  bond0(4) bpf/egress cil_to_netdev prog id 672

  flow_dissector:

  netfilter:

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/bpf/bpftool/net.c | 86 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 26a49965bf71..1ef1e880de61 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -76,6 +76,11 @@ static const char * const attach_type_strings[] = {
 	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
 };
 
+static const char * const attach_loc_strings[] = {
+	[BPF_TCX_INGRESS]		= "bpf/ingress",
+	[BPF_TCX_EGRESS]		= "bpf/egress",
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


