Return-Path: <bpf+bounces-18760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856B1821493
	for <lists+bpf@lfdr.de>; Mon,  1 Jan 2024 18:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9833D1C20B29
	for <lists+bpf@lfdr.de>; Mon,  1 Jan 2024 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40286FD7;
	Mon,  1 Jan 2024 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="j48D/gbS"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C863A7;
	Mon,  1 Jan 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704128420; x=1704733220; i=markus.elfring@web.de;
	bh=jt0jjg+eimru4BQyDAlCdV4s+tkByojsMTZSQQ+umHc=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=j48D/gbSB+TQnLiZIq/v7o2ONanye319FJHEw05/LjFntPfG0ByiD2W2qHEzX/gm
	 /wiMGq2G7eRL9bQnorT1Xf0YLYd1bmWnM8UjMPXWbhywtLhCVASn7GPQzbZ7S4wv1
	 cqlVmKAiMgQcMwTPn1R0JJrHCPxwI9agcVrOwL3sW2Pq0PluWvMp3iCiOcOnaroWK
	 PDcBMvc4XaresTDMJiQNjrPZdL4rgTaqFxiSHO5V13MU2iSLmgo0rx0HPZqNH2aD8
	 bEau4rp7qY0HTzfDUi3mUCFdho2IJAqaGBiMl79XkLwe3ejaFNvekidvYGzb0MLmz
	 F6l7Q1XCGj2t5E/lKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1qrrO11gfh-00og42; Mon, 01
 Jan 2024 18:00:20 +0100
Message-ID: <7daa06c8-7d96-4126-a182-ca4c5e67f7a4@web.de>
Date: Mon, 1 Jan 2024 18:00:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] bpf: Improve 11 size determinations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v86Vs62BHchJJKAdMgD0EeqotTgVb0nTmYvBzO0cZeKqJd1f400
 +UhG3FpnfGq+PKC4UW1p3808eZlsff5Ui+Ah22uG1s98RbLPttCcyL1Q1V7h04lnkPpXtqw
 0K3G4qKn+8AkaaeH2+sv9KMFT9fP3VXMXQeq68bJzm+SPexeCZbWSkqBEC4ceSaAM1OdNKj
 5GWUR7EHjhLiZ+oGH7FTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YbwE0/JINh4=;3Hutg4rS2LnlMHt7cy+e1dNqYib
 YecUKMHgDWj7bgWjKqXcNqpBR6mqT0IwZMtnYyd5V4UFHjZrAYoOmvU6qtCPRmGnultiPwF1Q
 pe1Yb3nGWWmLhkQZ+bPTAlyPKf12h6OiqEN9CXQ+5TJJP+g1NTsrsFrQDPMCFfcU+VJDh4RDs
 kslF20c8Du6P4+GYA76hEGNIgDgjrxK+vQIFobcSbsrNczeIU75YcjTz1LBWHzEF0K/g0omyP
 Gja+SDsP/r8N9e49R2HXkOi2RFneBtxnxac9ImtBXYTAuVXo6h8P9pdediafMNLYiiyOb1Ilq
 dEYYWyHbBybz/yexAYSq0u5wnDrGY4Ps3mqraCED83UrqOdVICA5Dkp0HbvSV8V4Kj2P9Pe3s
 a8geLIo1vcDEeLwjmQ0N5b4uTQu1bXUGrzN9QvCDCkuv8BXWknrupndioXINdcxEB6azG91QG
 O/Z3nQELZuqXW1v5JVo2qfYrtpnN4yYMn9XjVsHzgWjtmgbTOEdujFXwfmdN54p7U1NqXWRQt
 j6FXVWmYHAtPOC/osvd5zgssDl2A1WKxdqYlRu7VbkjE5eOwZFbQ+hAFtLDfzDkoCgXyKRqBU
 B8a64oc4RNAWoRzNrSogjv+mQOruEY6K1WtQ9l/xSs15Cjn2rLnQs6jY2et+MYDbWYCAPMVG5
 dMGlXl1MWisGaM5sLUQlGxbHERW/luNqiFpTMZgopmR8yB6EcQ/kKBVusbt0H6RFTGILeXmg8
 uyvImsdIJMnhGm6Mpug//We/5WzsnKgRLEcR6PDxLU4v/UiF6Sr0SwLxMIQS1YUOfK1hPhVKg
 Uwx+wLOTjer4YRJ8L4z2skj8NFgnIMkuRJrGkMJTOUCrPiSlsvgg8mmbCcNFw1pIWM+4xDGz3
 HkBrL+UeKgND/PJ8V5DIqc1klTHMh6Bi1ceMSGVLRhRt3CJABcS+e+RIi2pZQ9jkgq5tPkuHr
 bPSWRA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2024 17:33:55 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/bpf/core.c          |  2 +-
 kernel/bpf/inode.c         |  2 +-
 kernel/bpf/local_storage.c |  4 ++--
 kernel/bpf/lpm_trie.c      |  2 +-
 kernel/bpf/verifier.c      | 13 ++++++-------
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ea6843be2616..1ae7b3054424 100644
=2D-- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2517,7 +2517,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_arra=
y *array,
 	 *     bpf_prog_array_copy_to_user(..., cnt);
 	 * so below kcalloc doesn't need extra cnt > 0 check.
 	 */
-	ids =3D kcalloc(cnt, sizeof(u32), GFP_USER | __GFP_NOWARN);
+	ids =3D kcalloc(cnt, sizeof(*ids), GFP_USER | __GFP_NOWARN);
 	if (!ids)
 		return -ENOMEM;
 	nospc =3D bpf_prog_array_copy_core(array, ids, cnt);
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 41e0a55c35f5..2189760bdf0b 100644
=2D-- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -827,7 +827,7 @@ static int bpf_init_fs_context(struct fs_context *fc)
 {
 	struct bpf_mount_opts *opts;

-	opts =3D kzalloc(sizeof(struct bpf_mount_opts), GFP_KERNEL);
+	opts =3D kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
 		return -ENOMEM;

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index a04f505aefe9..75dba32cf91c 100644
=2D-- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -313,7 +313,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union =
bpf_attr *attr)
 		/* max_entries is not used and enforced to be 0 */
 		return ERR_PTR(-EINVAL);

-	map =3D bpf_map_area_alloc(sizeof(struct bpf_cgroup_storage_map), numa_n=
ode);
+	map =3D bpf_map_area_alloc(sizeof(*map), numa_node);
 	if (!map)
 		return ERR_PTR(-ENOMEM);

@@ -511,7 +511,7 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(st=
ruct bpf_prog *prog,

 	size =3D bpf_cgroup_storage_calculate_size(map, &pages);

-	storage =3D bpf_map_kmalloc_node(map, sizeof(struct bpf_cgroup_storage),
+	storage =3D bpf_map_kmalloc_node(map, sizeof(*storage),
 				       gfp, map->numa_node);
 	if (!storage)
 		goto enomem;
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index b32be680da6c..3a69155d4ef3 100644
=2D-- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -643,7 +643,7 @@ static int trie_get_next_key(struct bpf_map *map, void=
 *_key, void *_next_key)
 		goto find_leftmost;

 	node_stack =3D kmalloc_array(trie->max_prefixlen,
-				   sizeof(struct lpm_trie_node *),
+				   sizeof(*node_stack),
 				   GFP_ATOMIC | __GFP_NOWARN);
 	if (!node_stack)
 		return -ENOMEM;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a376eb609c41..98c1dd43670b 100644
=2D-- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1677,7 +1677,7 @@ static struct bpf_verifier_state *push_stack(struct =
bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	int err;

-	elem =3D kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
+	elem =3D kzalloc(sizeof(*elem), GFP_KERNEL);
 	if (!elem)
 		goto err;

@@ -2374,7 +2374,7 @@ static struct bpf_verifier_state *push_async_cb(stru=
ct bpf_verifier_env *env,
 	struct bpf_verifier_stack_elem *elem;
 	struct bpf_func_state *frame;

-	elem =3D kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
+	elem =3D kzalloc(sizeof(*elem), GFP_KERNEL);
 	if (!elem)
 		goto err;

@@ -15913,8 +15913,7 @@ static int check_btf_line(struct bpf_verifier_env =
*env,
 	/* Need to zero it in case the userspace may
 	 * pass in a smaller bpf_line_info object.
 	 */
-	linfo =3D kvcalloc(nr_linfo, sizeof(struct bpf_line_info),
-			 GFP_KERNEL | __GFP_NOWARN);
+	linfo =3D kvcalloc(nr_linfo, sizeof(*linfo), GFP_KERNEL | __GFP_NOWARN);
 	if (!linfo)
 		return -ENOMEM;

@@ -17161,7 +17160,7 @@ static int is_state_visited(struct bpf_verifier_en=
v *env, int insn_idx)
 	 * When looping the sl->state.branches will be > 0 and this state
 	 * will not be considered for equivalence until branches =3D=3D 0.
 	 */
-	new_sl =3D kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL);
+	new_sl =3D kzalloc(sizeof(*new_sl), GFP_KERNEL);
 	if (!new_sl)
 		return -ENOMEM;
 	env->total_states++;
@@ -20003,7 +20002,7 @@ static int do_check_common(struct bpf_verifier_env=
 *env, int subprog)
 	env->prev_linfo =3D NULL;
 	env->pass_cnt++;

-	state =3D kzalloc(sizeof(struct bpf_verifier_state), GFP_KERNEL);
+	state =3D kzalloc(sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
 	state->curframe =3D 0;
@@ -20717,7 +20716,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_at=
tr *attr, bpfptr_t uattr, __u3
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env =3D kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env =3D kzalloc(sizeof(*env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;

=2D-
2.43.0


