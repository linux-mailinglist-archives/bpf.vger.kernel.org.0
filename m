Return-Path: <bpf+bounces-29016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A098BF570
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 07:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BED1F25F94
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 05:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FBC171C8;
	Wed,  8 May 2024 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="OOpdO87q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A808F6C
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715144850; cv=none; b=AI+uOUeSI46GPcO+gvfnWJCa+1DVTI60GPJmJmYx5c87W25JGBwWu814AZbLOdVa9ngwLfxPXFd53yNJYUc4qw0UcuiwWOMroDYiy6i20WN7H6F7npRmLHrSYdgCh7WkxCzWS/pdm9Wemqu2bAw30+1KO0jqPAF1dHudAqEc9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715144850; c=relaxed/simple;
	bh=Z2o2I5WcAMYKDQXdxREMXmKqV3sC/Mbn7eUMdL7i1YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URz3yl3CM7900iRJMvp6LiTGrn7lfCYhIXpAuli3Y2pyk3H2O/6Fo07jSCLHQ2qM9q3dS58gyrsshAgpIKKoEx1Pu93WJEKfs2fkucFoCDMRb2oWpU4TCOnuQSVjHWI5KoDFuKD7jfC+se//qPCw5ZUnrpN7EF7zAwPGAty/ZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz; spf=pass smtp.mailfrom=fe-bounces.faucet.nz; dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b=OOpdO87q; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-Id: Date: Subject: Cc: To: From; q=dns/txt; s=fe-4ed8c67516;
 t=1715144815; bh=rkWOQFNwdY5GouQOzcDon4MN1/rPKcGZmvC33wMBP4w=;
 b=OOpdO87qLmyDKnx9KmIKSvOh7QFyIVyHivkf6hQfR8wFeK4yTurJCevtOXA5rxW+oosN4ypyg
 BY0Y/ih4dg5Ca+nnby7KTM/RNs+UlUwQ0aPD7y/A8jk02zpTR0jAezVuCYDfbQaFZJm3duxDeWO
 7AkALgRDpXVwWD9FzgVWf/s=
From: Brad Cowie <brad@faucet.nz>
To: bpf@vger.kernel.org, martin.lau@linux.dev
Cc: lorenzo@kernel.org, memxor@gmail.com, pablo@netfilter.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, Brad Cowie <brad@faucet.nz>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Update tests for new ct zone opts for nf_conntrack kfuncs
Date: Wed,  8 May 2024 17:04:50 +1200
Message-Id: <20240508050450.88356-1-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508043033.52311-1-brad@faucet.nz>
References: <20240508043033.52311-1-brad@faucet.nz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; brad@faucet.nz, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 663b086e72b4a4e913ba5a86

Add test for allocating and looking up ct entry in a
non-default ct zone with kfuncs bpf_{xdp,skb}_ct_alloc
and bpf_{xdp,skb}_ct_lookup.

Add negative tests for looking up ct entry in a different
ct zone to where it was allocated and with a different
direction.

Signed-off-by: Brad Cowie <brad@faucet.nz>
---
v2 -> v3:
  - Test both old and new bpf_ct_opts struct definitions
  - Restore test for reserved options
  - Add test for ct_zone_dir

v1 -> v2:
  - Separate test changes into different patch
  - Add test for allocating/looking up entry in non-default ct zone
---
 tools/testing/selftests/bpf/config            |   1 +
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   6 +
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 117 ++++++++++++++++--
 3 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index eeabd798bc3a..2fb16da78dce 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -80,6 +80,7 @@ CONFIG_NETFILTER_XT_TARGET_CT=y
 CONFIG_NETKIT=y
 CONFIG_NF_CONNTRACK=y
 CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
 CONFIG_NF_NAT=y
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index b30ff6b3b81a..b73401a71e4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -122,6 +122,12 @@ static void test_bpf_nf_ct(int mode)
 	ASSERT_EQ(skel->bss->test_exist_lookup_mark, 43, "Test existing connection lookup ctmark");
 	ASSERT_EQ(skel->data->test_snat_addr, 0, "Test for source natting");
 	ASSERT_EQ(skel->data->test_dnat_addr, 0, "Test for destination natting");
+	ASSERT_EQ(skel->data->test_ct_zone_id_alloc_entry, 0, "Test for alloc new entry in specified ct zone");
+	ASSERT_EQ(skel->data->test_ct_zone_id_insert_entry, 0, "Test for insert new entry in specified ct zone");
+	ASSERT_EQ(skel->data->test_ct_zone_id_succ_lookup, 0, "Test for successful lookup in specified ct_zone");
+	ASSERT_EQ(skel->bss->test_ct_zone_dir_enoent_lookup, -ENOENT, "Test ENOENT for lookup with wrong ct zone dir");
+	ASSERT_EQ(skel->bss->test_ct_zone_id_enoent_lookup, -ENOENT, "Test ENOENT for lookup in wrong ct zone");
+
 end:
 	if (client_fd != -1)
 		close(client_fd);
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 77ad8adf68da..f57cd5d6d548 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -9,6 +9,9 @@
 #define EINVAL 22
 #define ENOENT 2
 
+#define NF_CT_ZONE_DIR_ORIG (1 << IP_CT_DIR_ORIGINAL)
+#define NF_CT_ZONE_DIR_REPL (1 << IP_CT_DIR_REPLY)
+
 extern unsigned long CONFIG_HZ __kconfig;
 
 int test_einval_bpf_tuple = 0;
@@ -22,6 +25,11 @@ int test_eafnosupport = 0;
 int test_alloc_entry = -EINVAL;
 int test_insert_entry = -EAFNOSUPPORT;
 int test_succ_lookup = -ENOENT;
+int test_ct_zone_id_alloc_entry = -EINVAL;
+int test_ct_zone_id_insert_entry = -EAFNOSUPPORT;
+int test_ct_zone_id_succ_lookup = -ENOENT;
+int test_ct_zone_dir_enoent_lookup = 0;
+int test_ct_zone_id_enoent_lookup = 0;
 u32 test_delta_timeout = 0;
 u32 test_status = 0;
 u32 test_insert_lookup_mark = 0;
@@ -48,6 +56,16 @@ struct bpf_ct_opts___local {
 	u8 reserved[3];
 } __attribute__((preserve_access_index));
 
+struct bpf_ct_opts___new {
+	s32 netns_id;
+	s32 error;
+	u8 l4proto;
+	u8 dir;
+	u16 ct_zone_id;
+	u8 ct_zone_dir;
+	u8 reserved[3];
+} __attribute__((preserve_access_index));
+
 struct nf_conn *bpf_xdp_ct_alloc(struct xdp_md *, struct bpf_sock_tuple *, u32,
 				 struct bpf_ct_opts___local *, u32) __ksym;
 struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *, struct bpf_sock_tuple *, u32,
@@ -84,16 +102,6 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 	else
 		test_einval_bpf_tuple = opts_def.error;
 
-	opts_def.reserved[0] = 1;
-	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
-		       sizeof(opts_def));
-	opts_def.reserved[0] = 0;
-	opts_def.l4proto = IPPROTO_TCP;
-	if (ct)
-		bpf_ct_release(ct);
-	else
-		test_einval_reserved = opts_def.error;
-
 	opts_def.netns_id = -2;
 	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
 		       sizeof(opts_def));
@@ -220,10 +228,98 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 	}
 }
 
+static __always_inline void
+nf_ct_opts_new_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
+						 struct bpf_ct_opts___new *, u32),
+		    struct nf_conn *(*alloc_fn)(void *, struct bpf_sock_tuple *, u32,
+						struct bpf_ct_opts___new *, u32),
+		    void *ctx)
+{
+	struct bpf_ct_opts___new opts_def = { .l4proto = IPPROTO_TCP, .netns_id = -1 };
+	struct bpf_sock_tuple bpf_tuple;
+	struct nf_conn *ct;
+
+	__builtin_memset(&bpf_tuple, 0, sizeof(bpf_tuple.ipv4));
+
+	opts_def.reserved[0] = 1;
+	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
+		       sizeof(opts_def));
+	opts_def.reserved[0] = 0;
+	opts_def.l4proto = IPPROTO_TCP;
+	if (ct)
+		bpf_ct_release(ct);
+	else
+		test_einval_reserved = opts_def.error;
+
+	bpf_tuple.ipv4.saddr = bpf_get_prandom_u32(); /* src IP */
+	bpf_tuple.ipv4.daddr = bpf_get_prandom_u32(); /* dst IP */
+	bpf_tuple.ipv4.sport = bpf_get_prandom_u32(); /* src port */
+	bpf_tuple.ipv4.dport = bpf_get_prandom_u32(); /* dst port */
+
+	/* use non-default ct zone */
+	opts_def.ct_zone_id = 10;
+	opts_def.ct_zone_dir = NF_CT_ZONE_DIR_ORIG;
+	ct = alloc_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
+		      sizeof(opts_def));
+	if (ct) {
+		__u16 sport = bpf_get_prandom_u32();
+		__u16 dport = bpf_get_prandom_u32();
+		union nf_inet_addr saddr = {};
+		union nf_inet_addr daddr = {};
+		struct nf_conn *ct_ins;
+
+		bpf_ct_set_timeout(ct, 10000);
+
+		/* snat */
+		saddr.ip = bpf_get_prandom_u32();
+		bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC___local);
+		/* dnat */
+		daddr.ip = bpf_get_prandom_u32();
+		bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST___local);
+
+		ct_ins = bpf_ct_insert_entry(ct);
+		if (ct_ins) {
+			struct nf_conn *ct_lk;
+
+			/* entry should exist in same ct zone we inserted it */
+			ct_lk = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4),
+					  &opts_def, sizeof(opts_def));
+			if (ct_lk) {
+				bpf_ct_release(ct_lk);
+				test_ct_zone_id_succ_lookup = 0;
+			}
+
+			/* entry should not exist with wrong direction */
+			opts_def.ct_zone_dir = NF_CT_ZONE_DIR_REPL;
+			ct_lk = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4),
+					  &opts_def, sizeof(opts_def));
+			opts_def.ct_zone_dir = NF_CT_ZONE_DIR_ORIG;
+			if (ct_lk)
+				bpf_ct_release(ct_lk);
+			else
+				test_ct_zone_dir_enoent_lookup = opts_def.error;
+
+			/* entry should not exist in default ct zone */
+			opts_def.ct_zone_id = 0;
+			ct_lk = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4),
+					  &opts_def, sizeof(opts_def));
+			if (ct_lk)
+				bpf_ct_release(ct_lk);
+			else
+				test_ct_zone_id_enoent_lookup = opts_def.error;
+
+			bpf_ct_release(ct_ins);
+			test_ct_zone_id_insert_entry = 0;
+		}
+		test_ct_zone_id_alloc_entry = 0;
+	}
+}
+
 SEC("xdp")
 int nf_xdp_ct_test(struct xdp_md *ctx)
 {
 	nf_ct_test((void *)bpf_xdp_ct_lookup, (void *)bpf_xdp_ct_alloc, ctx);
+	nf_ct_opts_new_test((void *)bpf_xdp_ct_lookup, (void *)bpf_xdp_ct_alloc, ctx);
 	return 0;
 }
 
@@ -231,6 +327,7 @@ SEC("tc")
 int nf_skb_ct_test(struct __sk_buff *ctx)
 {
 	nf_ct_test((void *)bpf_skb_ct_lookup, (void *)bpf_skb_ct_alloc, ctx);
+	nf_ct_opts_new_test((void *)bpf_skb_ct_lookup, (void *)bpf_skb_ct_alloc, ctx);
 	return 0;
 }
 
-- 
2.34.1


