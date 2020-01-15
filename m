Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C995113C264
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 14:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAONP7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 08:15:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28538 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726220AbgAONP7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jan 2020 08:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579094158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CxVhE7XjFwcijbDOtv3VHh0R3n/aqdvJnm3oZGS0Kxo=;
        b=jKBmYwEVilrpESQyu0urZGR4NLwaHA3A+3iLqVcNXVe3dN/xIl2XlBb5QCSl5giXvw9xs/
        57qpoJICMw1gppFMF4hHRIIYbyRt45zVxWgbi8+4t76UKClzzBPBoNZ3Um9DZl00be1fm+
        3CQ1It2DFpCvBx7ncMWr+F5RhDBs1hY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-F9lvZH4iOse5fMVTXIsz9w-1; Wed, 15 Jan 2020 08:15:54 -0500
X-MC-Unique: F9lvZH4iOse5fMVTXIsz9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9076491222;
        Wed, 15 Jan 2020 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (wsfd-netdev76.ntdv.lab.eng.bos.redhat.com [10.19.188.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC166842BF;
        Wed, 15 Jan 2020 13:15:52 +0000 (UTC)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, netdev@vger.kernel.org,
        andrii.nakryiko@gmail.com, maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next v3] selftests/bpf: Add a test for attaching a bpf fentry/fexit trace to an XDP program
Date:   Wed, 15 Jan 2020 13:15:39 +0000
Message-Id: <157909410480.47481.11202505690938004673.stgit@xdp-tutorial>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test that will attach a FENTRY and FEXIT program to the XDP test
program. It will also verify data from the XDP context on FENTRY and
verifies the return code on exit.

Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
---
v2 -> v3:
  - Incorporated review comments from Andrii and Maciej

v1 -> v2:
  - Changed code to use the BPF skeleton
  - Replace static volatile with global variable in eBPF code

 .../testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c |   65 ++++++++++++++=
++++++
 .../testing/selftests/bpf/progs/test_xdp_bpf2bpf.c |   44 ++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c b/tools=
/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
new file mode 100644
index 000000000000..6b56bdc73ebc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <net/if.h>
+#include "test_xdp.skel.h"
+#include "test_xdp_bpf2bpf.skel.h"
+
+void test_xdp_bpf2bpf(void)
+{
+	__u32 duration =3D 0, retval, size;
+	char buf[128];
+	int err, pkt_fd, map_fd;
+	struct iphdr *iph =3D (void *)buf + sizeof(struct ethhdr);
+	struct iptnl_info value4 =3D {.family =3D AF_INET};
+	struct test_xdp *pkt_skel =3D NULL;
+	struct test_xdp_bpf2bpf *ftrace_skel =3D NULL;
+	struct vip key4 =3D {.protocol =3D 6, .family =3D AF_INET};
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+
+	/* Load XDP program to introspect */
+	pkt_skel =3D test_xdp__open_and_load();
+	if (CHECK(!pkt_skel, "pkt_skel_load", "test_xdp skeleton failed\n"))
+		return;
+
+	pkt_fd =3D bpf_program__fd(pkt_skel->progs._xdp_tx_iptunnel);
+
+	map_fd =3D bpf_map__fd(pkt_skel->maps.vip2tnl);
+	bpf_map_update_elem(map_fd, &key4, &value4, 0);
+
+	/* Load trace program */
+	opts.attach_prog_fd =3D pkt_fd,
+	ftrace_skel =3D test_xdp_bpf2bpf__open_opts(&opts);
+	if (CHECK(!ftrace_skel, "__open", "ftrace skeleton failed\n"))
+		goto out;
+
+	err =3D test_xdp_bpf2bpf__load(ftrace_skel);
+	if (CHECK(err, "__load", "ftrace skeleton failed\n"))
+		goto out;
+
+	err =3D test_xdp_bpf2bpf__attach(ftrace_skel);
+	if (CHECK(err, "ftrace_attach", "ftrace attach failed: %d\n", err))
+		goto out;
+
+	/* Run test program */
+	err =3D bpf_prog_test_run(pkt_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				buf, &size, &retval, &duration);
+
+	if (CHECK(err || retval !=3D XDP_TX || size !=3D 74 ||
+		  iph->protocol !=3D IPPROTO_IPIP, "ipv4",
+		  "err %d errno %d retval %d size %d\n",
+		  err, errno, retval, size))
+		goto out;
+
+	/* Verify test results */
+	if (CHECK(ftrace_skel->bss->test_result_fentry !=3D if_nametoindex("lo"=
),
+		  "result", "fentry failed err %llu\n",
+		  ftrace_skel->bss->test_result_fentry))
+		goto out;
+
+	CHECK(ftrace_skel->bss->test_result_fexit !=3D XDP_TX, "result",
+	      "fexit failed err %llu\n", ftrace_skel->bss->test_result_fexit);
+
+out:
+	test_xdp__destroy(pkt_skel);
+	test_xdp_bpf2bpf__destroy(ftrace_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c b/tools=
/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
new file mode 100644
index 000000000000..f8f105af6743
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+#include "bpf_trace_helpers.h"
+
+struct net_device {
+	/* Structure does not need to contain all entries,
+	 * as "preserve_access_index" will use BTF to fix this...
+	 */
+	int ifindex;
+} __attribute__((preserve_access_index));
+
+struct xdp_rxq_info {
+	/* Structure does not need to contain all entries,
+	 * as "preserve_access_index" will use BTF to fix this...
+	 */
+	struct net_device *dev;
+	__u32 queue_index;
+} __attribute__((preserve_access_index));
+
+struct xdp_buff {
+	void *data;
+	void *data_end;
+	void *data_meta;
+	void *data_hard_start;
+	unsigned long handle;
+	struct xdp_rxq_info *rxq;
+} __attribute__((preserve_access_index));
+
+__u64 test_result_fentry =3D 0;
+SEC("fentry/_xdp_tx_iptunnel")
+int BPF_PROG(trace_on_entry, struct xdp_buff *xdp)
+{
+	test_result_fentry =3D xdp->rxq->dev->ifindex;
+	return 0;
+}
+
+__u64 test_result_fexit =3D 0;
+SEC("fexit/_xdp_tx_iptunnel")
+int BPF_PROG(trace_on_exit, struct xdp_buff *xdp, int ret)
+{
+	test_result_fexit =3D ret;
+	return 0;
+}

