Return-Path: <bpf+bounces-8418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C97863CC
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 00:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6E28140B
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 22:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC04A200CC;
	Wed, 23 Aug 2023 22:56:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6A1FB35
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 22:56:26 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C991712
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 15:56:13 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7009A254973EB; Wed, 23 Aug 2023 15:56:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a local kptr test with no special fields
Date: Wed, 23 Aug 2023 15:56:01 -0700
Message-Id: <20230823225601.1293468-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823225556.1292811-1-yonghong.song@linux.dev>
References: <20230823225556.1292811-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a local kptr test with no special fields in the struct. Without the
previous patch, the following warning will hit:

  [   44.683877] WARNING: CPU: 3 PID: 485 at kernel/bpf/syscall.c:660 bpf=
_obj_free_fields+0x220/0x240
  [   44.684640] Modules linked in: bpf_testmod(OE)
  [   44.685044] CPU: 3 PID: 485 Comm: kworker/u8:5 Tainted: G           =
OE      6.5.0-rc5-01703-g260d855e9b90 #248
  [   44.685827] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
  [   44.686693] Workqueue: events_unbound bpf_map_free_deferred
  [   44.687297] RIP: 0010:bpf_obj_free_fields+0x220/0x240
  [   44.687775] Code: e8 55 17 1f 00 49 8b 74 24 08 4c 89 ef e8 e8 14 05=
 00 e8 a3 da e2 ff e9 55 fe ff ff 0f 0b e9 4e fe ff
                       ff 0f 0b e9 47 fe ff ff <0f> 0b e8 d9 d9 e2 ff 31 =
f6 eb d5 48 83 c4 10 5b 41 5c e
  [   44.689353] RSP: 0018:ffff888106467cb8 EFLAGS: 00010246
  [   44.689806] RAX: 0000000000000000 RBX: ffff888112b3a200 RCX: 0000000=
000000001
  [   44.690433] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff888=
1128ad988
  [   44.691094] RBP: 0000000000000002 R08: ffffffff81370bd0 R09: 1ffff11=
0216231a5
  [   44.691643] R10: dffffc0000000000 R11: ffffed10216231a6 R12: ffff888=
10d68a488
  [   44.692245] R13: ffff88810767c288 R14: ffff88810d68a400 R15: ffff888=
10d68a418
  [   44.692829] FS:  0000000000000000(0000) GS:ffff8881f7580000(0000) kn=
lGS:0000000000000000
  [   44.693484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   44.693964] CR2: 000055c7f2afce28 CR3: 000000010fee4002 CR4: 0000000=
000370ee0
  [   44.694513] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
  [   44.695102] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
  [   44.695747] Call Trace:
  [   44.696001]  <TASK>
  [   44.696183]  ? __warn+0xfe/0x270
  [   44.696447]  ? bpf_obj_free_fields+0x220/0x240
  [   44.696817]  ? report_bug+0x220/0x2d0
  [   44.697180]  ? handle_bug+0x3d/0x70
  [   44.697507]  ? exc_invalid_op+0x1a/0x50
  [   44.697887]  ? asm_exc_invalid_op+0x1a/0x20
  [   44.698282]  ? btf_find_struct_meta+0xd0/0xd0
  [   44.698634]  ? bpf_obj_free_fields+0x220/0x240
  [   44.699027]  ? bpf_obj_free_fields+0x1e2/0x240
  [   44.699414]  array_map_free+0x1a3/0x260
  [   44.699763]  bpf_map_free_deferred+0x7b/0xe0
  [   44.700154]  process_one_work+0x46d/0x750
  [   44.700523]  worker_thread+0x49e/0x900
  [   44.700892]  ? pr_cont_work+0x270/0x270
  [   44.701224]  kthread+0x1ae/0x1d0
  [   44.701516]  ? kthread_blkcg+0x50/0x50
  [   44.701860]  ret_from_fork+0x34/0x50
  [   44.702178]  ? kthread_blkcg+0x50/0x50
  [   44.702508]  ret_from_fork_asm+0x11/0x20
  [   44.702880]  </TASK>

With the previous patch, there is no warnings.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/local_kptr_stash.c         | 25 ++++++++++++++++-
 .../selftests/bpf/progs/local_kptr_stash.c    | 28 +++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c b/=
tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
index 158616c94658..4225108b8e4d 100644
--- a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
@@ -27,6 +27,27 @@ static void test_local_kptr_stash_simple(void)
 	local_kptr_stash__destroy(skel);
 }
=20
+static void test_local_kptr_stash_simple_2(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .repeat =3D 1,
+	);
+	struct local_kptr_stash *skel;
+	int ret;
+
+	skel =3D local_kptr_stash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "local_kptr_stash__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.stash_rb_nod=
es_2), &opts);
+	ASSERT_OK(ret, "local_kptr_stash_add_nodes run");
+	ASSERT_OK(opts.retval, "local_kptr_stash_add_nodes retval");
+
+	local_kptr_stash__destroy(skel);
+}
+
 static void test_local_kptr_stash_unstash(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts,
@@ -59,8 +80,10 @@ static void test_local_kptr_stash_fail(void)
=20
 void test_local_kptr_stash(void)
 {
-	if (test__start_subtest("local_kptr_stash_simple"))
+	if (test__start_subtest("local_kptr_stash_simple_yes_special_field"))
 		test_local_kptr_stash_simple();
+	if (test__start_subtest("local_kptr_stash_simple_no_special_field"))
+		test_local_kptr_stash_simple_2();
 	if (test__start_subtest("local_kptr_stash_unstash"))
 		test_local_kptr_stash_unstash();
 	if (test__start_subtest("local_kptr_stash_fail"))
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools=
/testing/selftests/bpf/progs/local_kptr_stash.c
index 06838083079c..4de548c31aab 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -14,10 +14,16 @@ struct node_data {
 	struct bpf_rb_node node;
 };
=20
+struct node_data2 {
+	long key;
+	long data;
+};
+
 struct map_value {
 	struct prog_test_ref_kfunc *not_kptr;
 	struct prog_test_ref_kfunc __kptr *val;
 	struct node_data __kptr *node;
+	struct node_data2 __kptr *node2;
 };
=20
 /* This is necessary so that LLVM generates BTF for node_data struct
@@ -66,6 +72,28 @@ long stash_rb_nodes(void *ctx)
 	return create_and_stash(0, 41) ?: create_and_stash(1, 42);
 }
=20
+SEC("tc")
+long stash_rb_nodes_2(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data2 *res;
+	int idx =3D 0;
+
+	mapval =3D bpf_map_lookup_elem(&some_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	res =3D bpf_obj_new(typeof(*res));
+	if (!res)
+		return 1;
+	res->key =3D 41;
+
+	res =3D bpf_kptr_xchg(&mapval->node2, res);
+	if (res)
+		bpf_obj_drop(res);
+	return 0;
+}
+
 SEC("tc")
 long unstash_rb_node(void *ctx)
 {
--=20
2.34.1


