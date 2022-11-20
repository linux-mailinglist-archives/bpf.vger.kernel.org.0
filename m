Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F7B631617
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKTTy6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKTTy5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:54:57 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5FAEE02
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:53 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AKI1gu8028844
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=o+Zl+/WSv7eITqspYc8KtUCmPcd15wRWPNogioOdXtA=;
 b=pRZyImxnSdy51d2D4jyStHv8LzDGl/HgUWQH42XpYe2G3CI76YtopbDVx0aC6o4MhlDK
 6AUQiKQKuMC6eMGexlY3Z3wFc1B7BapEMMYCddTRku/osvQALX0AaPZxct2LENwLTUUM
 wW3/ZWfLGzOELYisC8Ym+FaDB0Vc5yMU+Og= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxwj40006-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:52 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 11:54:52 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A88FA127744A3; Sun, 20 Nov 2022 11:54:42 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 4/4] bpf: Add type cast unit tests
Date:   Sun, 20 Nov 2022 11:54:42 -0800
Message-ID: <20221120195442.3114844-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120195421.3112414-1-yhs@fb.com>
References: <20221120195421.3112414-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: w5JMQ8s_PcKn5J6hJvxgp9GoLPSEniP-
X-Proofpoint-ORIG-GUID: w5JMQ8s_PcKn5J6hJvxgp9GoLPSEniP-
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Three tests are added. One is from John Fastabend ({1]) which tests
tracing style access for xdp program from the kernel ctx.
Another is a tc test to test both kernel ctx tracing style access
and explicit non-ctx type cast. The third one is for negative tests
including two tests, a tp_bpf test where the bpf_rdonly_cast()
returns a untrusted ptr which cannot be used as helper argument,
and a tracepoint test where the kernel ctx is a u64.

Also added the test to DENYLIST.s390x since s390 does not currently
support calling kernel functions in JIT mode.

  [1] https://lore.kernel.org/bpf/20221109215242.1279993-1-john.fastabend@g=
mail.com/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/type_cast.c      | 114 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/type_cast.c |  83 +++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/type_cast.c
 create mode 100644 tools/testing/selftests/bpf/progs/type_cast.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/sel=
ftests/bpf/DENYLIST.s390x
index f70a677b38e5..12cf2159975e 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -71,6 +71,7 @@ trace_printk                             # trace_printk__=
load unexpected error:
 trace_vprintk                            # trace_vprintk__open_and_load un=
expected error: -9                           (?)
 tracing_struct                           # failed to auto-attach: -524    =
                                             (trampoline)
 trampoline_count                         # prog 'prog1': failed to attach:=
 ERROR: strerror_r(-524)=3D22                  (trampoline)
+type_cast                                # JIT does not support calling ke=
rnel function
 unpriv_bpf_disabled                      # fentry
 user_ringbuf                             # failed to find kernel BTF type =
ID of '__s390x_sys_prctl': -3                (?)
 verif_stats                              # trace_vprintk__open_and_load un=
expected error: -9                           (?)
diff --git a/tools/testing/selftests/bpf/prog_tests/type_cast.c b/tools/tes=
ting/selftests/bpf/prog_tests/type_cast.c
new file mode 100644
index 000000000000..9317d5fa2635
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/type_cast.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "type_cast.skel.h"
+
+static void test_xdp(void)
+{
+	struct type_cast *skel;
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
+	skel =3D type_cast__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.md_xdp, true);
+	err =3D type_cast__load(skel);
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
+	type_cast__destroy(skel);
+}
+
+static void test_tc(void)
+{
+	struct type_cast *skel;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);
+
+	skel =3D type_cast__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.md_skb, true);
+	err =3D type_cast__load(skel);
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
+	ASSERT_NEQ(skel->bss->kskb_len, 0, "skb len");
+	ASSERT_NEQ(skel->bss->kskb2_len, 0, "skb2 len");
+	ASSERT_EQ(skel->bss->kskb_len, skel->bss->kskb2_len, "skb len compare");
+
+out:
+	type_cast__destroy(skel);
+}
+
+static const char * const negative_tests[] =3D {
+	"untrusted_ptr",
+	"kctx_u64",
+};
+
+static void test_negative(void)
+{
+	struct bpf_program *prog;
+	struct type_cast *skel;
+	int i, err;
+
+	for (i =3D 0; i < ARRAY_SIZE(negative_tests); i++) {
+		skel =3D type_cast__open();
+		if (!ASSERT_OK_PTR(skel, "skel_open"))
+			return;
+
+		prog =3D bpf_object__find_program_by_name(skel->obj, negative_tests[i]);
+		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+			goto out;
+		bpf_program__set_autoload(prog, true);
+		err =3D type_cast__load(skel);
+		ASSERT_ERR(err, "skel_load");
+out:
+		type_cast__destroy(skel);
+	}
+}
+
+void test_type_cast(void)
+{
+	if (test__start_subtest("xdp"))
+		test_xdp();
+	if (test__start_subtest("tc"))
+		test_tc();
+	if (test__start_subtest("negative"))
+		test_negative();
+}
diff --git a/tools/testing/selftests/bpf/progs/type_cast.c b/tools/testing/=
selftests/bpf/progs/type_cast.c
new file mode 100644
index 000000000000..eb78e6f03129
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/type_cast.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} enter_id SEC(".maps");
+
+#define	IFNAMSIZ 16
+
+int ifindex, ingress_ifindex;
+char name[IFNAMSIZ];
+unsigned int inum;
+unsigned int meta_len, frag0_len, kskb_len, kskb2_len;
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+void *bpf_rdonly_cast(void *, __u32) __ksym;
+
+SEC("?xdp")
+int md_xdp(struct xdp_md *ctx)
+{
+	struct xdp_buff *kctx =3D bpf_cast_to_kern_ctx(ctx);
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
+	struct sk_buff *kskb =3D bpf_cast_to_kern_ctx(skb);
+	struct skb_shared_info *shared_info;
+	struct sk_buff *kskb2;
+
+	kskb_len =3D kskb->len;
+
+	/* Simulate the following kernel macro:
+	 *   #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(=
SKB)))
+	 */
+	shared_info =3D bpf_rdonly_cast(kskb->head + kskb->end,
+		bpf_core_type_id_kernel(struct skb_shared_info));
+	meta_len =3D shared_info->meta_len;
+	frag0_len =3D shared_info->frag_list->len;
+
+	/* kskb2 should be equal to kskb */
+	kskb2 =3D bpf_rdonly_cast(kskb, bpf_core_type_id_kernel(struct sk_buff));
+	kskb2_len =3D kskb2->len;
+	return 0;
+}
+
+SEC("?tp_btf/sys_enter")
+int BPF_PROG(untrusted_ptr, struct pt_regs *regs, long id)
+{
+	struct task_struct *task, *task_dup;
+	long *ptr;
+
+	task =3D bpf_get_current_task_btf();
+	task_dup =3D bpf_rdonly_cast(task, bpf_core_type_id_kernel(struct task_st=
ruct));
+	(void)bpf_task_storage_get(&enter_id, task_dup, 0, 0);
+	return 0;
+}
+
+SEC("?tracepoint/syscalls/sys_enter_nanosleep")
+int kctx_u64(void *ctx)
+{
+	u64 *kctx =3D bpf_rdonly_cast(ctx, bpf_core_type_id_kernel(u64));
+
+	(void)kctx;
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

