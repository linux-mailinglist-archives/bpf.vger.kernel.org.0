Return-Path: <bpf+bounces-26093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C3B89ABE3
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0701F21A6B
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F23BBED;
	Sat,  6 Apr 2024 16:04:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED7C3BBDC
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419479; cv=none; b=ehV5H1XgED3QRV3GhkO7WaYy2wHKOaDWbCUvVP2EoVA/9Cjb75YVGtvIxKg5+8OkXN4sQxuN+1jQX2tCL3nEkRGPm3oa//Y2mdSJ94PWNqBRItMVTNm9oSnfEhxzEhz5f69CU7EDdv5qkYjJiN1r1SwduHIoaPzYv72fR6i+0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419479; c=relaxed/simple;
	bh=2yaw/lgBIXAw590+78hgH9AkSg1jKww4cuthU3koF8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qp9wb+tjNByw7znjfpqTmTZ8jTT5mhpPGppobla4iLzaI5DvCccftB7dEl8ACfiA5cr3cPCqoHuscpbnZch6dfPdYLnA/8uBoUmMJhxU3WtHdQLW59z4q9HYC4gcEgL95oBoGZ/RC5naW7fdQyY2u+JW/jm502jb2S8WoGYN8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 89E2B2B55204; Sat,  6 Apr 2024 09:04:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: Add some tests with new bpf_program__attach_sockmap() APIs
Date: Sat,  6 Apr 2024 09:04:24 -0700
Message-ID: <20240406160424.179173-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406160359.176498-1-yonghong.song@linux.dev>
References: <20240406160359.176498-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a few more tests in sockmap_basic.c and sockmap_listen.c to
test bpf_link based APIs for SK_MSG and SK_SKB programs.
Link attach/detach/update are all tested.

All tests are passed.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 133 ++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_listen.c |  38 +++++
 .../bpf/progs/test_skmsg_load_helpers.c       |  18 +++
 .../bpf/progs/test_sockmap_pass_prog.c        |  17 ++-
 .../progs/test_sockmap_skb_verdict_attach.c   |   2 +-
 5 files changed, 206 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 63fb2da7930a..1337153eb0ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -131,6 +131,65 @@ static void test_skmsg_helpers(enum bpf_map_type map=
_type)
 	test_skmsg_load_helpers__destroy(skel);
 }
=20
+static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
+{
+	struct bpf_program *prog, *prog_clone, *prog_clone2;
+	DECLARE_LIBBPF_OPTS(bpf_link_update_opts, opts);
+	struct test_skmsg_load_helpers *skel;
+	struct bpf_link *link, *link2;
+	int err, map;
+
+	skel =3D test_skmsg_load_helpers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_skmsg_load_helpers__open_and_load"))
+		return;
+
+	prog =3D skel->progs.prog_msg_verdict;
+	prog_clone =3D skel->progs.prog_msg_verdict_clone;
+	prog_clone2 =3D skel->progs.prog_msg_verdict_clone2;
+	map =3D bpf_map__fd(skel->maps.sock_map);
+
+	link =3D bpf_program__attach_sockmap(prog, map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		goto out;
+
+	/* Fail since bpf_link for the same prog has been created. */
+	err =3D bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_MSG_VERDICT,=
 0);
+	if (!ASSERT_ERR(err, "bpf_prog_attach"))
+		goto out;
+
+	/* Fail since bpf_link for the same prog type has been created. */
+	link2 =3D bpf_program__attach_sockmap(prog_clone, map);
+	if (!ASSERT_ERR_PTR(link2, "bpf_program__attach_sockmap")) {
+		bpf_link__detach(link2);
+		goto out;
+	}
+
+	err =3D bpf_link__update_program(link, prog_clone);
+	if (!ASSERT_OK(err, "bpf_link__update_program"))
+		goto out;
+
+	/* Fail since a prog with different type attempts to do update. */
+	err =3D bpf_link__update_program(link, skel->progs.prog_skb_verdict);
+	if (!ASSERT_ERR(err, "bpf_link__update_program"))
+		goto out;
+
+	/* Fail since the old prog does not match the one in the kernel. */
+	opts.old_prog_fd =3D bpf_program__fd(prog_clone2);
+	opts.flags =3D BPF_F_REPLACE;
+	err =3D bpf_link_update(bpf_link__fd(link), bpf_program__fd(prog), &opt=
s);
+	if (!ASSERT_ERR(err, "bpf_link_update"))
+		goto out;
+
+	opts.old_prog_fd =3D bpf_program__fd(prog_clone);
+	opts.flags =3D BPF_F_REPLACE;
+	err =3D bpf_link_update(bpf_link__fd(link), bpf_program__fd(prog), &opt=
s);
+	if (!ASSERT_OK(err, "bpf_link_update"))
+		goto out;
+out:
+	bpf_link__detach(link);
+	test_skmsg_load_helpers__destroy(skel);
+}
+
 static void test_sockmap_update(enum bpf_map_type map_type)
 {
 	int err, prog, src;
@@ -298,6 +357,40 @@ static void test_sockmap_skb_verdict_attach(enum bpf=
_attach_type first,
 	test_sockmap_skb_verdict_attach__destroy(skel);
 }
=20
+static void test_sockmap_skb_verdict_attach_with_link(void)
+{
+	struct test_sockmap_skb_verdict_attach *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	int err, map;
+
+	skel =3D test_sockmap_skb_verdict_attach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	prog =3D skel->progs.prog_skb_verdict;
+	map =3D bpf_map__fd(skel->maps.sock_map);
+	link =3D bpf_program__attach_sockmap(prog, map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		goto out;
+
+	bpf_link__detach(link);
+
+	err =3D bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_V=
ERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	/* Fail since attaching with the same prog/map has been done. */
+	link =3D bpf_program__attach_sockmap(prog, map);
+	if (!ASSERT_ERR_PTR(link, "bpf_program__attach_sockmap"))
+		bpf_link__detach(link);
+
+	err =3D bpf_prog_detach2(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_=
VERDICT);
+	if (!ASSERT_OK(err, "bpf_prog_detach2"))
+		goto out;
+out:
+	test_sockmap_skb_verdict_attach__destroy(skel);
+}
+
 static __u32 query_prog_id(int prog_fd)
 {
 	struct bpf_prog_info info =3D {};
@@ -532,6 +625,38 @@ static void test_sockmap_skb_verdict_peek(void)
 	test_sockmap_pass_prog__destroy(pass);
 }
=20
+static void test_sockmap_skb_verdict_peek_with_link(void)
+{
+	struct test_sockmap_pass_prog *pass;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	int err, map;
+
+	pass =3D test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(pass, "open_and_load"))
+		return;
+	prog =3D pass->progs.prog_skb_verdict;
+	map =3D bpf_map__fd(pass->maps.sock_map_rx);
+	link =3D bpf_program__attach_sockmap(prog, map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		goto out;
+
+	err =3D bpf_link__update_program(link, pass->progs.prog_skb_verdict_clo=
ne);
+	if (!ASSERT_OK(err, "bpf_link__update_program"))
+		goto out;
+
+	/* Fail since a prog with different attach type attempts to do update. =
*/
+	err =3D bpf_link__update_program(link, pass->progs.prog_skb_parser);
+	if (!ASSERT_ERR(err, "bpf_link__update_program"))
+		goto out;
+
+	test_sockmap_skb_verdict_peek_helper(map);
+	ASSERT_EQ(pass->bss->clone_called, 1, "clone_called");
+out:
+	bpf_link__detach(link);
+	test_sockmap_pass_prog__destroy(pass);
+}
+
 static void test_sockmap_unconnected_unix(void)
 {
 	int err, map, stream =3D 0, dgram =3D 0, zero =3D 0;
@@ -796,6 +921,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_attach(BPF_SK_SKB_STREAM_VERDICT,
 						BPF_SK_SKB_VERDICT);
 	}
+	if (test__start_subtest("sockmap skb_verdict attach_with_link"))
+		test_sockmap_skb_verdict_attach_with_link();
 	if (test__start_subtest("sockmap msg_verdict progs query"))
 		test_sockmap_progs_query(BPF_SK_MSG_VERDICT);
 	if (test__start_subtest("sockmap stream_parser progs query"))
@@ -812,6 +939,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
+	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
+		test_sockmap_skb_verdict_peek_with_link();
 	if (test__start_subtest("sockmap unconnected af_unix"))
 		test_sockmap_unconnected_unix();
 	if (test__start_subtest("sockmap one socket to many map entries"))
@@ -820,4 +949,8 @@ void test_sockmap_basic(void)
 		test_sockmap_many_maps();
 	if (test__start_subtest("sockmap same socket replace"))
 		test_sockmap_same_sock();
+	if (test__start_subtest("sockmap sk_msg attach sockmap helpers with lin=
k"))
+		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKMAP);
+	if (test__start_subtest("sockhash sk_msg attach sockhash helpers with l=
ink"))
+		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKHASH);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a92807bfcd13..54c93eee1808 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -767,6 +767,24 @@ static void test_msg_redir_to_connected(struct test_=
sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_MSG_VERDICT);
 }
=20
+static void test_msg_redir_to_connected_with_link(struct test_sockmap_li=
sten *skel,
+						  struct bpf_map *inner_map, int family,
+						  int sotype)
+{
+	struct bpf_program *verdict =3D skel->progs.prog_msg_verdict;
+	int verdict_map =3D bpf_map__fd(skel->maps.verdict_map);
+	int sock_map =3D bpf_map__fd(inner_map);
+	struct bpf_link *link;
+
+	link =3D bpf_program__attach_sockmap(verdict, sock_map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		return;
+
+	redir_to_connected(family, sotype, sock_map, verdict_map, REDIR_EGRESS)=
;
+
+	bpf_link__detach(link);
+}
+
 static void redir_to_listening(int family, int sotype, int sock_mapfd,
 			       int verd_mapfd, enum redir_mode mode)
 {
@@ -869,6 +887,24 @@ static void test_msg_redir_to_listening(struct test_=
sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_MSG_VERDICT);
 }
=20
+static void test_msg_redir_to_listening_with_link(struct test_sockmap_li=
sten *skel,
+						  struct bpf_map *inner_map, int family,
+						  int sotype)
+{
+	struct bpf_program *verdict =3D skel->progs.prog_msg_verdict;
+	int verdict_map =3D bpf_map__fd(skel->maps.verdict_map);
+	int sock_map =3D bpf_map__fd(inner_map);
+	struct bpf_link *link;
+
+	link =3D bpf_program__attach_sockmap(verdict, sock_map);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
+		return;
+
+	redir_to_listening(family, sotype, sock_map, verdict_map, REDIR_EGRESS)=
;
+
+	bpf_link__detach(link);
+}
+
 static void redir_partial(int family, int sotype, int sock_map, int pars=
er_map)
 {
 	int s, c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
@@ -1316,7 +1352,9 @@ static void test_redir(struct test_sockmap_listen *=
skel, struct bpf_map *map,
 		TEST(test_skb_redir_to_listening),
 		TEST(test_skb_redir_partial),
 		TEST(test_msg_redir_to_connected),
+		TEST(test_msg_redir_to_connected_with_link),
 		TEST(test_msg_redir_to_listening),
+		TEST(test_msg_redir_to_listening_with_link),
 	};
 	const char *family_name, *map_name;
 	const struct redir_test *t;
diff --git a/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c =
b/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
index b753672f04c9..996b177324ba 100644
--- a/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
@@ -49,4 +49,22 @@ int prog_msg_verdict(struct sk_msg_md *msg)
 	return prog_msg_verdict_common(msg);
 }
=20
+SEC("sk_msg")
+int prog_msg_verdict_clone(struct sk_msg_md *msg)
+{
+	return prog_msg_verdict_common(msg);
+}
+
+SEC("sk_msg")
+int prog_msg_verdict_clone2(struct sk_msg_md *msg)
+{
+	return prog_msg_verdict_common(msg);
+}
+
+SEC("sk_skb/stream_verdict")
+int prog_skb_verdict(struct __sk_buff *skb)
+{
+	return SK_PASS;
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c b=
/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
index 1d86a717a290..69aacc96db36 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
@@ -23,10 +23,25 @@ struct {
 	__type(value, int);
 } sock_map_msg SEC(".maps");
=20
-SEC("sk_skb")
+SEC("sk_skb/stream_verdict")
 int prog_skb_verdict(struct __sk_buff *skb)
 {
 	return SK_PASS;
 }
=20
+int clone_called;
+
+SEC("sk_skb/stream_verdict")
+int prog_skb_verdict_clone(struct __sk_buff *skb)
+{
+	clone_called =3D 1;
+	return SK_PASS;
+}
+
+SEC("sk_skb/stream_parser")
+int prog_skb_parser(struct __sk_buff *skb)
+{
+	return SK_PASS;
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_a=
ttach.c b/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_atta=
ch.c
index 3c69aa971738..d25b0bb30fc0 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_attach.c
@@ -9,7 +9,7 @@ struct {
 	__type(value, __u64);
 } sock_map SEC(".maps");
=20
-SEC("sk_skb")
+SEC("sk_skb/verdict")
 int prog_skb_verdict(struct __sk_buff *skb)
 {
 	return SK_DROP;
--=20
2.43.0


