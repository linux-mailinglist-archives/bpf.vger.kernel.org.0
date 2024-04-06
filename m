Return-Path: <bpf+bounces-26092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69B89ABE2
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3851F21B4C
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36923D387;
	Sat,  6 Apr 2024 16:04:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21F3BBEB
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419464; cv=none; b=OULfCc+M7rBpPSAID4bEdmguRscgiYgrImQ5Efsvh8tsy1fX6X5pSsKVzHklCGp4mhKHjUgPJ4lZKGC/+CX9CZiLtsM6VNeG+D7Pq2PZr1eiRCRoK/ROyFm+9k8YpPtGGfJurb5DgLHXkMwMRwpYztojQ3kMVlf0/WwSab8nLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419464; c=relaxed/simple;
	bh=CrFr0efWTROxchFFt86b6TOwhG1Ccmp+/KHHRYzeGDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrPnxyIwNVembBrmgzlnJqh0zB9t7PLWgM0oVDMjyT0Hah8hrrkml++I8ss0jTx1eHI1BSDzekuphZbuxF5+mwzKw1HfmGXuhteMhe8Ip9Uc6RwBcMXjG4YzDR3/KJ8NeG71cVGcAlw3ue+CEnk14rsDdpaO8Mr6nAGp7kL/Tj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6F4852B551E9; Sat,  6 Apr 2024 09:04:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v5 4/5] selftests/bpf: Refactor out helper functions for a few tests
Date: Sat,  6 Apr 2024 09:04:19 -0700
Message-ID: <20240406160419.178871-1-yonghong.song@linux.dev>
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

These helper functions will be used later new tests as well.
There are no functionality change.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 38 +++++++++++--------
 .../bpf/progs/test_skmsg_load_helpers.c       |  9 ++++-
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 77e26ecffa9d..63fb2da7930a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -475,30 +475,19 @@ static void test_sockmap_skb_verdict_fionread(bool =
pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
=20
-static void test_sockmap_skb_verdict_peek(void)
+static void test_sockmap_skb_verdict_peek_helper(int map)
 {
-	int err, map, verdict, s, c1, p1, zero =3D 0, sent, recvd, avail;
-	struct test_sockmap_pass_prog *pass;
+	int err, s, c1, p1, zero =3D 0, sent, recvd, avail;
 	char snd[256] =3D "0123456789";
 	char rcv[256] =3D "0";
=20
-	pass =3D test_sockmap_pass_prog__open_and_load();
-	if (!ASSERT_OK_PTR(pass, "open_and_load"))
-		return;
-	verdict =3D bpf_program__fd(pass->progs.prog_skb_verdict);
-	map =3D bpf_map__fd(pass->maps.sock_map_rx);
-
-	err =3D bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
-	if (!ASSERT_OK(err, "bpf_prog_attach"))
-		goto out;
-
 	s =3D socket_loopback(AF_INET, SOCK_STREAM);
 	if (!ASSERT_GT(s, -1, "socket_loopback(s)"))
-		goto out;
+		return;
=20
 	err =3D create_pair(s, AF_INET, SOCK_STREAM, &c1, &p1);
 	if (!ASSERT_OK(err, "create_pairs(s)"))
-		goto out;
+		return;
=20
 	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
 	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
@@ -520,6 +509,25 @@ static void test_sockmap_skb_verdict_peek(void)
 out_close:
 	close(c1);
 	close(p1);
+}
+
+static void test_sockmap_skb_verdict_peek(void)
+{
+	struct test_sockmap_pass_prog *pass;
+	int err, map, verdict;
+
+	pass =3D test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(pass, "open_and_load"))
+		return;
+	verdict =3D bpf_program__fd(pass->progs.prog_skb_verdict);
+	map =3D bpf_map__fd(pass->maps.sock_map_rx);
+
+	err =3D bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	test_sockmap_skb_verdict_peek_helper(map);
+
 out:
 	test_sockmap_pass_prog__destroy(pass);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c =
b/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
index 45e8fc75a739..b753672f04c9 100644
--- a/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_skmsg_load_helpers.c
@@ -24,8 +24,7 @@ struct {
 	__type(value, __u64);
 } socket_storage SEC(".maps");
=20
-SEC("sk_msg")
-int prog_msg_verdict(struct sk_msg_md *msg)
+static int prog_msg_verdict_common(struct sk_msg_md *msg)
 {
 	struct task_struct *task =3D (struct task_struct *)bpf_get_current_task=
();
 	int verdict =3D SK_PASS;
@@ -44,4 +43,10 @@ int prog_msg_verdict(struct sk_msg_md *msg)
 	return verdict;
 }
=20
+SEC("sk_msg")
+int prog_msg_verdict(struct sk_msg_md *msg)
+{
+	return prog_msg_verdict_common(msg);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.43.0


