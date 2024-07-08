Return-Path: <bpf+bounces-34077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456B092A3AB
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769C428387A
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570F17CF3A;
	Mon,  8 Jul 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="goeAqUHd"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768CB665;
	Mon,  8 Jul 2024 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445521; cv=none; b=Zu0xNR+JTdUI46heLyNvua/ggK3SzKD+YwZyYHqQEUpi8TcoaqOZjQZ9InICiP4ivkx5q3GL3jkQo0PC1CAyDttrRvSQ9nNot6SK8DyM8bSGVSMiXtOt5qm+kWHnI97C1LxGhscguf8/GBQLckX80P9t/rErJMxaD3zHtQd6dNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445521; c=relaxed/simple;
	bh=572glhSyk6BTuRM6yrwPG//XI+zDRm0J8fE6WzuPNg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYv3936tJ6iII9OtjNLMHLqq56DqEKO9TdmJnC3YICkwty0Qb+j+QcdkKMI4y8FtlkhOgRni++uB3/RGmwCVhzdBDCziXr4zavsIvWBhWt7WlGVTA58Mll3e18sSrMdgcQlMiVo3JU5snKi+Ml+S6nDLg5YBBcSnzjq2ntZWvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=goeAqUHd; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=62h8teGbKuadC6YE88nVJpQLYgQY0jX/eeYoOy9WQJQ=; b=goeAqUHdyfF2/N6Uld0yNjs8gV
	Dw9X3rWBAM/RPG4uV5Q0rYJGKju+up8toGYBLLDciSixglh441paE4v/kGS6ZfOE0eWd/mwZvyjnH
	dbUzZdIrjIwTa2xngTL/Wsr1GYc0ikbWUK7QBwmIIQJBd+DlS91VHxuR3yt5PnpKTCS/aokT6ZU/M
	NNadVMdGL+0wiuTw4zwPbaK4PfpszEBirIDKjIaw1anLpCi6gJk9He6f59+8AUyCJgZEJ7XBAGdl7
	sF6pX96J3LDQ+HkGqUtT3AYuHSIHIFYp+UkmQTLJZP0YlOuxJbtYPLYMP+i/6YzoMmOhT5KRlehc8
	X7ox2Vvw==;
Received: from 35.248.197.178.dynamic.cust.swisscom.net ([178.197.248.35] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQoT9-000NDd-37; Mon, 08 Jul 2024 15:31:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 2/2] selftests/bpf: Extend tcx tests to cover late tcx_entry release
Date: Mon,  8 Jul 2024 15:31:30 +0200
Message-Id: <20240708133130.11609-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240708133130.11609-1-daniel@iogearbox.net>
References: <20240708133130.11609-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27330/Mon Jul  8 10:36:43 2024)

Add a test case which replaces an active ingress qdisc while keeping the
miniq in-tact during the transition period to the new clsact qdisc.

  # ./vmtest.sh -- ./test_progs -t tc_link
  [...]
  ./test_progs -t tc_link
  [    3.412871] bpf_testmod: loading out-of-tree module taints kernel.
  [    3.413343] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #332     tc_links_after:OK
  #333     tc_links_append:OK
  #334     tc_links_basic:OK
  #335     tc_links_before:OK
  #336     tc_links_chain_classic:OK
  #337     tc_links_chain_mixed:OK
  #338     tc_links_dev_chain0:OK
  #339     tc_links_dev_cleanup:OK
  #340     tc_links_dev_mixed:OK
  #341     tc_links_ingress:OK
  #342     tc_links_invalid:OK
  #343     tc_links_prepend:OK
  #344     tc_links_replace:OK
  #345     tc_links_revision:OK
  Summary: 14/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/config            |  3 +
 .../selftests/bpf/prog_tests/tc_links.c       | 61 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c0ef168eb637..c95f6f1ab74a 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -61,9 +61,12 @@ CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
+CONFIG_NET_ACT_SKBMOD=y
+CONFIG_NET_CLS=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
 CONFIG_NET_CLS_FLOWER=y
+CONFIG_NET_CLS_MATCHALL=y
 CONFIG_NET_FOU=y
 CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_NET_IPGRE=y
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index bc9841144685..1af9ec1149aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -9,6 +9,8 @@
 #define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
 
 #include "test_tc_link.skel.h"
+
+#include "netlink_helpers.h"
 #include "tc_helpers.h"
 
 void serial_test_tc_links_basic(void)
@@ -1787,6 +1789,65 @@ void serial_test_tc_links_ingress(void)
 	test_tc_links_ingress(BPF_TCX_INGRESS, false, false);
 }
 
+struct qdisc_req {
+	struct nlmsghdr  n;
+	struct tcmsg     t;
+	char             buf[1024];
+};
+
+static int qdisc_replace(int ifindex, const char *kind, bool block)
+{
+	struct rtnl_handle rth = { .fd = -1 };
+	struct qdisc_req req;
+	int err;
+
+	err = rtnl_open(&rth, 0);
+	if (!ASSERT_OK(err, "open_rtnetlink"))
+		return err;
+
+	memset(&req, 0, sizeof(req));
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg));
+	req.n.nlmsg_flags = NLM_F_CREATE | NLM_F_REPLACE | NLM_F_REQUEST;
+	req.n.nlmsg_type = RTM_NEWQDISC;
+	req.t.tcm_family = AF_UNSPEC;
+	req.t.tcm_ifindex = ifindex;
+	req.t.tcm_parent = 0xfffffff1;
+
+	addattr_l(&req.n, sizeof(req), TCA_KIND, kind, strlen(kind) + 1);
+	if (block)
+		addattr32(&req.n, sizeof(req), TCA_INGRESS_BLOCK, 1);
+
+	err = rtnl_talk(&rth, &req.n, NULL);
+	ASSERT_OK(err, "talk_rtnetlink");
+	rtnl_close(&rth);
+	return err;
+}
+
+void serial_test_tc_links_dev_chain0(void)
+{
+	int err, ifindex;
+
+	ASSERT_OK(system("ip link add dev foo type veth peer name bar"), "add veth");
+	ifindex = if_nametoindex("foo");
+	ASSERT_NEQ(ifindex, 0, "non_zero_ifindex");
+	err = qdisc_replace(ifindex, "ingress", true);
+	if (!ASSERT_OK(err, "attaching ingress"))
+		goto cleanup;
+	ASSERT_OK(system("tc filter add block 1 matchall action skbmod swap mac"), "add block");
+	err = qdisc_replace(ifindex, "clsact", false);
+	if (!ASSERT_OK(err, "attaching clsact"))
+		goto cleanup;
+	/* Heuristic: kern_sync_rcu() alone does not work; a wait-time of ~5s
+	 * triggered the issue without the fix reliably 100% of the time.
+	 */
+	sleep(5);
+	ASSERT_OK(system("tc filter add dev foo ingress matchall action skbmod swap mac"), "add filter");
+cleanup:
+	ASSERT_OK(system("ip link del dev foo"), "del veth");
+	ASSERT_EQ(if_nametoindex("foo"), 0, "foo removed");
+	ASSERT_EQ(if_nametoindex("bar"), 0, "bar removed");
+}
+
 static void test_tc_links_dev_mixed(int target)
 {
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
-- 
2.43.0


