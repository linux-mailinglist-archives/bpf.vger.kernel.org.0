Return-Path: <bpf+bounces-14957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385317E92AB
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 21:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692CD1C20433
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEEA1C6B1;
	Sun, 12 Nov 2023 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hEBnTSky"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8E1C685;
	Sun, 12 Nov 2023 20:31:02 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760D258D;
	Sun, 12 Nov 2023 12:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ubgxSWWiDDfFAC91UoFT9cAvwmMhf6epEbgV9lmxqEg=; b=hEBnTSkyi6Ch1jx/Cs7XEhN1Ki
	gS+xcO13RSO3UNhnU7Qh8o/XLZokfmc2nBKpprx7ngnyvzpYAAG7suLgdLW2MUIsBM1e8tad8+cSv
	CSHD/39XOKdt/7JMcAGDbDwH8EkIxZlFoRqfHsZzFJwj4oeyB3VtrJIPJ09JpoQnRmx8eEf1oQn4h
	6rPNusBbSWTNECCCkZr+Y8uEEiN/oao9/D1pmB9JzFGjmTeNxLfb0KOG4fB5oAt6XMD7xiSJ4cImv
	2pLVE5V7jto+j5ORY0GKxlQksiG3qxi4aWzH5yVsXOjUq9S+//Ny9DAcOcXG0GNI4uIzYOH8qTLVy
	03jVqmIw==;
Received: from mob-194-230-158-57.cgn.sunrise.net ([194.230.158.57] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2H6g-0002XO-VD; Sun, 12 Nov 2023 21:30:59 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: kuba@kernel.org,
	razor@blackwall.org,
	sdf@google.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 8/8] selftests/bpf: Add netkit to tc_redirect selftest
Date: Sun, 12 Nov 2023 21:30:09 +0100
Message-Id: <20231112203009.26073-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231112203009.26073-1-daniel@iogearbox.net>
References: <20231112203009.26073-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27091/Sun Nov 12 09:38:11 2023)

Extend the existing tc_redirect selftest to also cover netkit devices
for exercising the bpf_redirect_peer() code paths, so that we have both
veth as well as netkit covered, all tests still pass after this change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 407ff4e9bc78..518f143c5b0f 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -24,6 +24,7 @@
 
 #include "test_progs.h"
 #include "network_helpers.h"
+#include "netlink_helpers.h"
 #include "test_tc_neigh_fib.skel.h"
 #include "test_tc_neigh.skel.h"
 #include "test_tc_peer.skel.h"
@@ -112,6 +113,7 @@ static void netns_setup_namespaces_nofail(const char *verb)
 
 enum dev_mode {
 	MODE_VETH,
+	MODE_NETKIT,
 };
 
 struct netns_setup_result {
@@ -142,10 +144,51 @@ static int get_ifaddr(const char *name, char *ifaddr)
 	return 0;
 }
 
+static int create_netkit(int mode, char *prim, char *peer)
+{
+	struct rtattr *linkinfo, *data, *peer_info;
+	struct rtnl_handle rth = { .fd = -1 };
+	const char *type = "netkit";
+	struct {
+		struct nlmsghdr n;
+		struct ifinfomsg i;
+		char buf[1024];
+	} req = {};
+	int err;
+
+	err = rtnl_open(&rth, 0);
+	if (!ASSERT_OK(err, "open_rtnetlink"))
+		return err;
+
+	memset(&req, 0, sizeof(req));
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	req.n.nlmsg_type = RTM_NEWLINK;
+	req.i.ifi_family = AF_UNSPEC;
+
+	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, prim, strlen(prim));
+	linkinfo = addattr_nest(&req.n, sizeof(req), IFLA_LINKINFO);
+	addattr_l(&req.n, sizeof(req), IFLA_INFO_KIND, type, strlen(type));
+	data = addattr_nest(&req.n, sizeof(req), IFLA_INFO_DATA);
+	addattr32(&req.n, sizeof(req), IFLA_NETKIT_MODE, mode);
+	peer_info = addattr_nest(&req.n, sizeof(req), IFLA_NETKIT_PEER_INFO);
+	req.n.nlmsg_len += sizeof(struct ifinfomsg);
+	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, peer, strlen(peer));
+	addattr_nest_end(&req.n, peer_info);
+	addattr_nest_end(&req.n, data);
+	addattr_nest_end(&req.n, linkinfo);
+
+	err = rtnl_talk(&rth, &req.n, NULL);
+	ASSERT_OK(err, "talk_rtnetlink");
+	rtnl_close(&rth);
+	return err;
+}
+
 static int netns_setup_links_and_routes(struct netns_setup_result *result)
 {
 	struct nstoken *nstoken = NULL;
 	char src_fwd_addr[IFADDR_STR_LEN+1] = {};
+	int err;
 
 	if (result->dev_mode == MODE_VETH) {
 		SYS(fail, "ip link add src type veth peer name src_fwd");
@@ -153,6 +196,13 @@ static int netns_setup_links_and_routes(struct netns_setup_result *result)
 
 		SYS(fail, "ip link set dst_fwd address " MAC_DST_FWD);
 		SYS(fail, "ip link set dst address " MAC_DST);
+	} else if (result->dev_mode == MODE_NETKIT) {
+		err = create_netkit(NETKIT_L3, "src", "src_fwd");
+		if (!ASSERT_OK(err, "create_ifindex_src"))
+			goto fail;
+		err = create_netkit(NETKIT_L3, "dst", "dst_fwd");
+		if (!ASSERT_OK(err, "create_ifindex_dst"))
+			goto fail;
 	}
 
 	if (get_ifaddr("src_fwd", src_fwd_addr))
@@ -1134,7 +1184,9 @@ static void *test_tc_redirect_run_tests(void *arg)
 	netns_setup_namespaces_nofail("delete");
 
 	RUN_TEST(tc_redirect_peer, MODE_VETH);
+	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
 	RUN_TEST(tc_redirect_peer_l3, MODE_VETH);
+	RUN_TEST(tc_redirect_peer_l3, MODE_NETKIT);
 	RUN_TEST(tc_redirect_neigh, MODE_VETH);
 	RUN_TEST(tc_redirect_neigh_fib, MODE_VETH);
 	RUN_TEST(tc_redirect_dtime, MODE_VETH);
-- 
2.34.1


