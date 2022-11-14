Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5033862851B
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 17:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiKNQYM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 11:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbiKNQX4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 11:23:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42BDD9F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:54 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEDCID0021977
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LvqNpvaV95sExdjWMQNvly1gUb3zRV6YZkLdRWc/dLo=;
 b=Dn6jtcvNwXnyrxx34Fo7HGIsgZciyiB570li3I9lUIuA+27FgCq54PdEYkacE9g0KHCG
 ctXD1vy/DcRXciQwUCcsQYg0dnH23ChG85hP5g9LOp9TOhsJqHHKyUbmg4lc2pduRZ2V
 IbleKq71wO6x9pFdmZQWyuPzk7mUV1s90Fs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kupbjstjn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:54 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub102.TheFacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 08:23:53 -0800
Received: from twshared28932.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 08:23:52 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id CD34112265F09; Mon, 14 Nov 2022 08:23:45 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH bpf-next 3/3] bpf: Add bpf_get_kern_btf_id() tests
Date:   Mon, 14 Nov 2022 08:23:45 -0800
Message-ID: <20221114162345.625666-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114162328.622665-1-yhs@fb.com>
References: <20221114162328.622665-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: u8uWU6C5AVVQevP8YOir1tzXXH2mP3XZ
X-Proofpoint-ORIG-GUID: u8uWU6C5AVVQevP8YOir1tzXXH2mP3XZ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two tests are added. One is from John Fastabend ({1]) which tests
tracing style access for xdp program from the kernel ctx.
Another is a tc test to test both kernel ctx tracing style access
and explicit non-ctx type cast.

  [1] https://lore.kernel.org/bpf/20221109215242.1279993-1-john.fastabend@g=
mail.com/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/prog_tests/get_kern_btf_id.c          | 81 +++++++++++++++++++
 .../selftests/bpf/progs/get_kern_btf_id.c     | 44 ++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_kern_btf_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_kern_btf_id.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_kern_btf_id.c b/too=
ls/testing/selftests/bpf/prog_tests/get_kern_btf_id.c
new file mode 100644
index 000000000000..205631916564
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_kern_btf_id.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "get_kern_btf_id.skel.h"
+
+static void test_xdp(void)
+{
+	struct get_kern_btf_id *skel;
+	int err, prog_fd;
+	char buf[128];
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.data_out =3D buf,
+		.data_size_out =3D sizeof(buf),
+		.repeat =3D 1,
+	);
+
+	skel =3D get_kern_btf_id__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.md_xdp, true);
+	err =3D get_kern_btf_id__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto out;
+
+	prog_fd =3D bpf_program__fd(skel->progs.md_xdp);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, XDP_PASS, "xdp test_run retval");
+
+	ASSERT_EQ(skel->bss->ifindex, 1, "xdp_md ifindex");
+	ASSERT_EQ(skel->bss->ifindex, skel->bss->ingress_ifindex, "xdp_md ingress=
_ifindex");
+	ASSERT_STREQ(skel->bss->name, "lo", "xdp_md name");
+	ASSERT_NEQ(skel->bss->inum, 0, "xdp_md inum");
+
+out:
+	get_kern_btf_id__destroy(skel);
+}
+
+static void test_tc(void)
+{
+	struct get_kern_btf_id *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);
+
+	skel =3D get_kern_btf_id__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.md_skb, true);
+	err =3D get_kern_btf_id__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto out;
+
+	prog_fd =3D bpf_program__fd(skel->progs.md_skb);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "tc test_run retval");
+
+	ASSERT_EQ(skel->bss->meta_len, 0, "skb meta_len");
+	ASSERT_EQ(skel->bss->frag0_len, 0, "skb frag0_len");
+
+out:
+	get_kern_btf_id__destroy(skel);
+}
+
+void test_get_kern_btf_id(void)
+{
+	if (test__start_subtest("xdp"))
+		test_xdp();
+	if (test__start_subtest("tc"))
+		test_tc();
+}
diff --git a/tools/testing/selftests/bpf/progs/get_kern_btf_id.c b/tools/te=
sting/selftests/bpf/progs/get_kern_btf_id.c
new file mode 100644
index 000000000000..b530c7c52ff3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_kern_btf_id.c
@@ -0,0 +1,44 @@
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#define	IFNAMSIZ 16
+
+int ifindex, ingress_ifindex;
+char name[IFNAMSIZ];
+unsigned int inum;
+int meta_len, frag0_len;
+
+extern void *bpf_get_kern_btf_id(void *, __u32) __ksym;
+
+SEC("?xdp")
+int md_xdp(struct xdp_md *ctx)
+{
+	struct xdp_buff *kctx =3D bpf_get_kern_btf_id(ctx, 0);
+	struct net_device *dev;
+
+	dev =3D kctx->rxq->dev;
+	ifindex =3D dev->ifindex;
+	inum =3D dev->nd_net.net->ns.inum;
+	__builtin_memcpy(name, dev->name, IFNAMSIZ);
+	ingress_ifindex =3D ctx->ingress_ifindex;
+	return XDP_PASS;
+}
+
+SEC("?tc")
+int md_skb(struct __sk_buff *skb)
+{
+	struct sk_buff *kskb =3D bpf_get_kern_btf_id(skb, 0);
+	struct skb_shared_info *shared_info;
+
+	/* Simulate the following kernel macro:
+	 *   #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(=
SKB)))
+	 */
+	shared_info =3D bpf_get_kern_btf_id(kskb->head + kskb->end,
+		bpf_core_type_id_kernel(struct skb_shared_info));
+	meta_len =3D shared_info->meta_len;
+	frag0_len =3D shared_info->frag_list->len;
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

