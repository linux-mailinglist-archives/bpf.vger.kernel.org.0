Return-Path: <bpf+bounces-7733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B686C77BDB3
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 18:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98F21C209BA
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0159C8DE;
	Mon, 14 Aug 2023 16:14:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F381C8D1
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 16:14:28 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10195F1
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=VNRDgVgsqY45x0Gcv8CsVN5/yiyXraLdmnqdKHv77hY=; b=qMI8GuG2AXzEPXR66Me+1gO1Ed
	ju+iscbnaYTP4z95sKhSekMkb1J8x+oK4hMfPQVlDPirkqVIMu6n5NWR4dcwFU1hmdxzE1fXvCnub
	Kq/BT+T06Yu/RnoNhu1DM6DA5xfhjcNbRZZe1bTuMfBocfLBYeGqw3wayz/Q4NqjEjFeR9WEsTC1W
	eAabSlVRZ6whiyfxuK6rRVEAr7rVFGY8iU9hGAPvv4B6VChy3EZHm6Ojqb6gdv+MNaF+CUYP+vk2/
	Yes88Qb7dlzOPXGBmdA5PkHwSvZgjW0XOBxdQ9JSPgtFyGF7ftRTs2ewhBhner6Run7rf0Zb0GIAf
	fqxPtR3A==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qVaD2-000Noe-8c; Mon, 14 Aug 2023 18:14:24 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] selftests/bpf: Add various more tcx test cases
Date: Mon, 14 Aug 2023 18:14:10 +0200
Message-Id: <8699efc284b75ccdc51ddf7062fa2370330dc6c0.1692029283.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27000/Mon Aug 14 09:37:02 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add several new tcx test cases to improve test coverage. This also includes
a few new tests with ingress instead of clsact qdisc, to cover the fix from
commit dc644b540a2d ("tcx: Fix splat in ingress_destroy upon tcx_entry_free").

  # ./test_progs -t tc
  [...]
  #234     tc_links_after:OK
  #235     tc_links_append:OK
  #236     tc_links_basic:OK
  #237     tc_links_before:OK
  #238     tc_links_chain_classic:OK
  #239     tc_links_chain_mixed:OK
  #240     tc_links_dev_cleanup:OK
  #241     tc_links_dev_mixed:OK
  #242     tc_links_ingress:OK
  #243     tc_links_invalid:OK
  #244     tc_links_prepend:OK
  #245     tc_links_replace:OK
  #246     tc_links_revision:OK
  #247     tc_opts_after:OK
  #248     tc_opts_append:OK
  #249     tc_opts_basic:OK
  #250     tc_opts_before:OK
  #251     tc_opts_chain_classic:OK
  #252     tc_opts_chain_mixed:OK
  #253     tc_opts_delete_empty:OK
  #254     tc_opts_demixed:OK
  #255     tc_opts_detach:OK
  #256     tc_opts_detach_after:OK
  #257     tc_opts_detach_before:OK
  #258     tc_opts_dev_cleanup:OK
  #259     tc_opts_invalid:OK
  #260     tc_opts_mixed:OK
  #261     tc_opts_prepend:OK
  #262     tc_opts_replace:OK
  #263     tc_opts_revision:OK
  [...]
  Summary: 44/38 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_links.c       | 336 ++++++++++++++++++
 .../selftests/bpf/prog_tests/tc_opts.c        | 110 ++++++
 .../selftests/bpf/progs/test_tc_link.c        |  16 +
 3 files changed, 462 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
index 81eea5f10742..74fc1fe9ee26 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Isovalent */
 #include <uapi/linux/if_link.h>
+#include <uapi/linux/pkt_sched.h>
 #include <net/if.h>
 #include <test_progs.h>
 
@@ -1581,3 +1582,338 @@ void serial_test_tc_links_dev_cleanup(void)
 	test_tc_links_dev_cleanup_target(BPF_TCX_INGRESS);
 	test_tc_links_dev_cleanup_target(BPF_TCX_EGRESS);
 }
+
+static void test_tc_chain_mixed(int target)
+{
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .ifindex = loopback);
+	LIBBPF_OPTS(bpf_tcx_opts, optl);
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	__u32 pid1, pid2, pid3;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc4, target),
+		  0, "tc4_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc5, target),
+		  0, "tc5_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc6, target),
+		  0, "tc6_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc4));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc5));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc6));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	tc_hook.attach_point = target == BPF_TCX_INGRESS ?
+			       BPF_TC_INGRESS : BPF_TC_EGRESS;
+	err = bpf_tc_hook_create(&tc_hook);
+	err = err == -EEXIST ? 0 : err;
+	if (!ASSERT_OK(err, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc5);
+	err = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(err, "bpf_tc_attach"))
+		goto cleanup;
+
+	link = bpf_program__attach_tcx(skel->progs.tc6, loopback, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc6 = link;
+
+	assert_mprog_count(target, 1);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+	ASSERT_EQ(skel->bss->seen_tc5, false, "seen_tc5");
+	ASSERT_EQ(skel->bss->seen_tc6, true, "seen_tc6");
+
+	skel->bss->seen_tc4 = false;
+	skel->bss->seen_tc5 = false;
+	skel->bss->seen_tc6 = false;
+
+	err = bpf_link__update_program(skel->links.tc6, skel->progs.tc4);
+	if (!ASSERT_OK(err, "link_update"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+	ASSERT_EQ(skel->bss->seen_tc5, true, "seen_tc5");
+	ASSERT_EQ(skel->bss->seen_tc6, false, "seen_tc6");
+
+	skel->bss->seen_tc4 = false;
+	skel->bss->seen_tc5 = false;
+	skel->bss->seen_tc6 = false;
+
+	err = bpf_link__detach(skel->links.tc6);
+	if (!ASSERT_OK(err, "prog_detach"))
+		goto cleanup;
+
+	__assert_mprog_count(target, 0, true, loopback);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+	ASSERT_EQ(skel->bss->seen_tc5, true, "seen_tc5");
+	ASSERT_EQ(skel->bss->seen_tc6, false, "seen_tc6");
+
+cleanup:
+	tc_opts.flags = tc_opts.prog_fd = tc_opts.prog_id = 0;
+	err = bpf_tc_detach(&tc_hook, &tc_opts);
+	ASSERT_OK(err, "bpf_tc_detach");
+
+	tc_hook.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS;
+	bpf_tc_hook_destroy(&tc_hook);
+
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_links_chain_mixed(void)
+{
+	test_tc_chain_mixed(BPF_TCX_INGRESS);
+	test_tc_chain_mixed(BPF_TCX_EGRESS);
+}
+
+static void test_tc_links_ingress(int target, bool chain_tc_old,
+				  bool tcx_teardown_first)
+{
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts,
+		.handle		= 1,
+		.priority	= 1,
+	);
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		.ifindex	= loopback,
+		.attach_point	= BPF_TC_CUSTOM,
+		.parent		= TC_H_INGRESS,
+	);
+	bool hook_created = false, tc_attached = false;
+	LIBBPF_OPTS(bpf_tcx_opts, optl);
+	__u32 pid1, pid2, pid3;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc3));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	if (chain_tc_old) {
+		ASSERT_OK(system("tc qdisc add dev lo ingress"), "add_ingress");
+		hook_created = true;
+
+		tc_opts.prog_fd = bpf_program__fd(skel->progs.tc3);
+		err = bpf_tc_attach(&tc_hook, &tc_opts);
+		if (!ASSERT_OK(err, "bpf_tc_attach"))
+			goto cleanup;
+		tc_attached = true;
+	}
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, loopback, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, loopback, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	assert_mprog_count(target, 2);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, chain_tc_old, "seen_tc3");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+	skel->bss->seen_tc3 = false;
+
+	err = bpf_link__detach(skel->links.tc2);
+	if (!ASSERT_OK(err, "prog_detach"))
+		goto cleanup;
+
+	assert_mprog_count(target, 1);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+	ASSERT_EQ(skel->bss->seen_tc3, chain_tc_old, "seen_tc3");
+cleanup:
+	if (tc_attached) {
+		tc_opts.flags = tc_opts.prog_fd = tc_opts.prog_id = 0;
+		err = bpf_tc_detach(&tc_hook, &tc_opts);
+		ASSERT_OK(err, "bpf_tc_detach");
+	}
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+	assert_mprog_count(target, 1);
+	if (hook_created && tcx_teardown_first)
+		ASSERT_OK(system("tc qdisc del dev lo ingress"), "del_ingress");
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+	test_tc_link__destroy(skel);
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+	if (hook_created && !tcx_teardown_first)
+		ASSERT_OK(system("tc qdisc del dev lo ingress"), "del_ingress");
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+	assert_mprog_count(target, 0);
+}
+
+void serial_test_tc_links_ingress(void)
+{
+	test_tc_links_ingress(BPF_TCX_INGRESS, true, true);
+	test_tc_links_ingress(BPF_TCX_INGRESS, true, false);
+	test_tc_links_ingress(BPF_TCX_INGRESS, false, false);
+}
+
+static void test_tc_links_dev_mixed(int target)
+{
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook);
+	LIBBPF_OPTS(bpf_tcx_opts, optl);
+	__u32 pid1, pid2, pid3, pid4;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err, ifindex;
+
+	ASSERT_OK(system("ip link add dev tcx_opts1 type veth peer name tcx_opts2"), "add veth");
+	ifindex = if_nametoindex("tcx_opts1");
+	ASSERT_NEQ(ifindex, 0, "non_zero_ifindex");
+
+	skel = test_tc_link__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc1, target),
+		  0, "tc1_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc2, target),
+		  0, "tc2_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc3, target),
+		  0, "tc3_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc4, target),
+		  0, "tc4_attach_type");
+
+	err = test_tc_link__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+	pid3 = id_from_prog_fd(bpf_program__fd(skel->progs.tc3));
+	pid4 = id_from_prog_fd(bpf_program__fd(skel->progs.tc4));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+	ASSERT_NEQ(pid3, pid4, "prog_ids_3_4");
+	ASSERT_NEQ(pid2, pid3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	link = bpf_program__attach_tcx(skel->progs.tc1, ifindex, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	assert_mprog_count_ifindex(ifindex, target, 1);
+
+	link = bpf_program__attach_tcx(skel->progs.tc2, ifindex, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	assert_mprog_count_ifindex(ifindex, target, 2);
+
+	link = bpf_program__attach_tcx(skel->progs.tc3, ifindex, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc3 = link;
+
+	assert_mprog_count_ifindex(ifindex, target, 3);
+
+	link = bpf_program__attach_tcx(skel->progs.tc4, ifindex, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc4 = link;
+
+	assert_mprog_count_ifindex(ifindex, target, 4);
+
+	tc_hook.ifindex = ifindex;
+	tc_hook.attach_point = target == BPF_TCX_INGRESS ?
+			       BPF_TC_INGRESS : BPF_TC_EGRESS;
+
+	err = bpf_tc_hook_create(&tc_hook);
+	err = err == -EEXIST ? 0 : err;
+	if (!ASSERT_OK(err, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc5);
+	err = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(err, "bpf_tc_attach"))
+		goto cleanup;
+
+	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
+	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
+	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
+
+	ASSERT_EQ(ifindex_from_link_fd(bpf_link__fd(skel->links.tc1)), 0, "tc1_ifindex");
+	ASSERT_EQ(ifindex_from_link_fd(bpf_link__fd(skel->links.tc2)), 0, "tc2_ifindex");
+	ASSERT_EQ(ifindex_from_link_fd(bpf_link__fd(skel->links.tc3)), 0, "tc3_ifindex");
+	ASSERT_EQ(ifindex_from_link_fd(bpf_link__fd(skel->links.tc4)), 0, "tc4_ifindex");
+
+	test_tc_link__destroy(skel);
+	return;
+cleanup:
+	test_tc_link__destroy(skel);
+
+	ASSERT_OK(system("ip link del dev tcx_opts1"), "del veth");
+	ASSERT_EQ(if_nametoindex("tcx_opts1"), 0, "dev1_removed");
+	ASSERT_EQ(if_nametoindex("tcx_opts2"), 0, "dev2_removed");
+}
+
+void serial_test_tc_links_dev_mixed(void)
+{
+	test_tc_links_dev_mixed(BPF_TCX_INGRESS);
+	test_tc_links_dev_mixed(BPF_TCX_EGRESS);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index 39bd253e41aa..7a2ecd4eca5d 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -2268,3 +2268,113 @@ void serial_test_tc_opts_delete_empty(void)
 	test_tc_opts_delete_empty(BPF_TCX_INGRESS, true);
 	test_tc_opts_delete_empty(BPF_TCX_EGRESS, true);
 }
+
+static void test_tc_chain_mixed(int target)
+{
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .ifindex = loopback);
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	__u32 fd1, fd2, fd3, id1, id2, id3;
+	struct test_tc_link *skel;
+	int err, detach_fd;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 = bpf_program__fd(skel->progs.tc4);
+	fd2 = bpf_program__fd(skel->progs.tc5);
+	fd3 = bpf_program__fd(skel->progs.tc6);
+
+	id1 = id_from_prog_fd(fd1);
+	id2 = id_from_prog_fd(fd2);
+	id3 = id_from_prog_fd(fd3);
+
+	ASSERT_NEQ(id1, id2, "prog_ids_1_2");
+	ASSERT_NEQ(id2, id3, "prog_ids_2_3");
+
+	assert_mprog_count(target, 0);
+
+	tc_hook.attach_point = target == BPF_TCX_INGRESS ?
+			       BPF_TC_INGRESS : BPF_TC_EGRESS;
+	err = bpf_tc_hook_create(&tc_hook);
+	err = err == -EEXIST ? 0 : err;
+	if (!ASSERT_OK(err, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = fd2;
+	err = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(err, "bpf_tc_attach"))
+		goto cleanup_hook;
+
+	err = bpf_prog_attach_opts(fd3, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_filter;
+
+	detach_fd = fd3;
+
+	assert_mprog_count(target, 1);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+	ASSERT_EQ(skel->bss->seen_tc5, false, "seen_tc5");
+	ASSERT_EQ(skel->bss->seen_tc6, true, "seen_tc6");
+
+	skel->bss->seen_tc4 = false;
+	skel->bss->seen_tc5 = false;
+	skel->bss->seen_tc6 = false;
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags = BPF_F_REPLACE,
+		.replace_prog_fd = fd3,
+	);
+
+	err = bpf_prog_attach_opts(fd1, loopback, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_opts;
+
+	detach_fd = fd1;
+
+	assert_mprog_count(target, 1);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc4, true, "seen_tc4");
+	ASSERT_EQ(skel->bss->seen_tc5, true, "seen_tc5");
+	ASSERT_EQ(skel->bss->seen_tc6, false, "seen_tc6");
+
+	skel->bss->seen_tc4 = false;
+	skel->bss->seen_tc5 = false;
+	skel->bss->seen_tc6 = false;
+
+cleanup_opts:
+	err = bpf_prog_detach_opts(detach_fd, loopback, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	__assert_mprog_count(target, 0, true, loopback);
+
+	ASSERT_OK(system(ping_cmd), ping_cmd);
+
+	ASSERT_EQ(skel->bss->seen_tc4, false, "seen_tc4");
+	ASSERT_EQ(skel->bss->seen_tc5, true, "seen_tc5");
+	ASSERT_EQ(skel->bss->seen_tc6, false, "seen_tc6");
+
+cleanup_filter:
+	tc_opts.flags = tc_opts.prog_fd = tc_opts.prog_id = 0;
+	err = bpf_tc_detach(&tc_hook, &tc_opts);
+	ASSERT_OK(err, "bpf_tc_detach");
+
+cleanup_hook:
+	tc_hook.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS;
+	bpf_tc_hook_destroy(&tc_hook);
+
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+void serial_test_tc_opts_chain_mixed(void)
+{
+	test_tc_chain_mixed(BPF_TCX_INGRESS);
+	test_tc_chain_mixed(BPF_TCX_EGRESS);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
index ed1fd0e9cee9..30e7124c49a1 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_link.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
@@ -10,6 +10,8 @@ bool seen_tc1;
 bool seen_tc2;
 bool seen_tc3;
 bool seen_tc4;
+bool seen_tc5;
+bool seen_tc6;
 
 SEC("tc/ingress")
 int tc1(struct __sk_buff *skb)
@@ -38,3 +40,17 @@ int tc4(struct __sk_buff *skb)
 	seen_tc4 = true;
 	return TCX_NEXT;
 }
+
+SEC("tc/egress")
+int tc5(struct __sk_buff *skb)
+{
+	seen_tc5 = true;
+	return TCX_PASS;
+}
+
+SEC("tc/egress")
+int tc6(struct __sk_buff *skb)
+{
+	seen_tc6 = true;
+	return TCX_PASS;
+}
-- 
2.21.0


