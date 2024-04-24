Return-Path: <bpf+bounces-27632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179B08AFF41
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740EC1F231C6
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0D128360;
	Wed, 24 Apr 2024 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="i04hjCIq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A288529E
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928389; cv=none; b=oN1LOTYGhcJfNI5+LcHCXWdgilGHfVZjG2fWZOXoicmwsAnc/bNkxvC2h8Z+1CrrsQtfjhzw0T/gEFCJntP5ZhDiT+spWOQjY0pRvO7NqdJGlTP7jwqL0+qnSmZLFLvuPTkZq/j+RknznxtLDAdBCJUpof5X4rd/aAQOREysjoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928389; c=relaxed/simple;
	bh=tg31TNyBqe3HU0jkHJbf+NlmS6IddKPkb9/qVP0HBj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzB960EOC4uiGFGZ/r/IRrvEVQIWu3wosM43M3NsPLt/is8eF+15QwMup+6g0C02CLne0GeuohhSm1XrnGx6Lwh18cxb/S3IypKmR1rYnx5nlaaY5RoO8mjrtANxzV+faJYBRITe1D+nssJef8D5E1+ttF/QMzth9tGW3NGDie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz; spf=pass smtp.mailfrom=fe-bounces.faucet.nz; dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b=i04hjCIq; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-Id: Date: Subject: Cc: To: From; q=dns/txt; s=fe-4ed8c67516;
 t=1713928372; bh=otRTde3iwWVVSbUbQ6qJYUOlvD+bh8w/dP23dF0cilE=;
 b=i04hjCIqJTQEDpHrJ2401NjNntCdtz31+ILg1gyiaju8j1BfGff8mzMYwhlr57NEtiDsA9jtT
 yTGyabgGfFddtW95/356sOttRIFv/JGH+P/etahd9V+9GJ1k+tqm7eECKql+4lZHxCjkuX5eijw
 ntglAT7GMbuKm02yUkrQfWA=
From: Brad Cowie <brad@faucet.nz>
To: bpf@vger.kernel.org, martin.lau@linux.dev
Cc: lorenzo@kernel.org, memxor@gmail.com, pablo@netfilter.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, Brad Cowie <brad@faucet.nz>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Update tests for new ct zone opts for nf_conntrack kfuncs
Date: Wed, 24 Apr 2024 15:00:27 +1200
Message-Id: <20240424030027.3932184-2-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424030027.3932184-1-brad@faucet.nz>
References: <20240424030027.3932184-1-brad@faucet.nz>
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
X-ForwardEmail-ID: 66287606fb9de1ab903e4133

Remove test for reserved options in bpf_ct_opts,
which have been removed.

Add test for allocating and looking up ct entry in a
non-default ct zone with kfuncs bpf_{xdp,skb}_ct_alloc
and bpf_{xdp,skb}_ct_lookup.

Add negative test for looking up ct entry in a different
ct zone to where it was allocated.

Signed-off-by: Brad Cowie <brad@faucet.nz>
---
v1 -> v2:
  - Separate test changes into different patch
  - Add test for allocating/looking up entry in non-default ct zone
---
 tools/testing/selftests/bpf/config            |  1 +
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  6 +-
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 88 ++++++++++++++++---
 3 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index afd675b1bf80..8d4110fe8d26 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -75,6 +75,7 @@ CONFIG_NETFILTER_XT_TARGET_CT=y
 CONFIG_NETKIT=y
 CONFIG_NF_CONNTRACK=y
 CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
 CONFIG_NF_NAT=y
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index b30ff6b3b81a..853f694af6d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -103,7 +103,6 @@ static void test_bpf_nf_ct(int mode)
 		goto end;
 
 	ASSERT_EQ(skel->bss->test_einval_bpf_tuple, -EINVAL, "Test EINVAL for NULL bpf_tuple");
-	ASSERT_EQ(skel->bss->test_einval_reserved, -EINVAL, "Test EINVAL for reserved not set to 0");
 	ASSERT_EQ(skel->bss->test_einval_netns_id, -EINVAL, "Test EINVAL for netns_id < -1");
 	ASSERT_EQ(skel->bss->test_einval_len_opts, -EINVAL, "Test EINVAL for len__opts != NF_BPF_CT_OPTS_SZ");
 	ASSERT_EQ(skel->bss->test_eproto_l4proto, -EPROTO, "Test EPROTO for l4proto != TCP or UDP");
@@ -122,6 +121,11 @@ static void test_bpf_nf_ct(int mode)
 	ASSERT_EQ(skel->bss->test_exist_lookup_mark, 43, "Test existing connection lookup ctmark");
 	ASSERT_EQ(skel->data->test_snat_addr, 0, "Test for source natting");
 	ASSERT_EQ(skel->data->test_dnat_addr, 0, "Test for destination natting");
+	ASSERT_EQ(skel->data->test_ct_zone_id_alloc_entry, 0, "Test for alloc new entry in specified ct zone");
+	ASSERT_EQ(skel->data->test_ct_zone_id_insert_entry, 0, "Test for insert new entry in specified ct zone");
+	ASSERT_EQ(skel->data->test_ct_zone_id_succ_lookup, 0, "Test for successful lookup in specified ct_zone");
+	ASSERT_EQ(skel->bss->test_ct_zone_id_enoent_lookup, -ENOENT, "Test ENOENT for lookup in wrong ct zone");
+
 end:
 	if (client_fd != -1)
 		close(client_fd);
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 77ad8adf68da..b47fa0708f1e 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -12,7 +12,6 @@
 extern unsigned long CONFIG_HZ __kconfig;
 
 int test_einval_bpf_tuple = 0;
-int test_einval_reserved = 0;
 int test_einval_netns_id = 0;
 int test_einval_len_opts = 0;
 int test_eproto_l4proto = 0;
@@ -22,6 +21,10 @@ int test_eafnosupport = 0;
 int test_alloc_entry = -EINVAL;
 int test_insert_entry = -EAFNOSUPPORT;
 int test_succ_lookup = -ENOENT;
+int test_ct_zone_id_alloc_entry = -EINVAL;
+int test_ct_zone_id_insert_entry = -EAFNOSUPPORT;
+int test_ct_zone_id_succ_lookup = -ENOENT;
+int test_ct_zone_id_enoent_lookup = 0;
 u32 test_delta_timeout = 0;
 u32 test_status = 0;
 u32 test_insert_lookup_mark = 0;
@@ -45,7 +48,10 @@ struct bpf_ct_opts___local {
 	s32 netns_id;
 	s32 error;
 	u8 l4proto;
-	u8 reserved[3];
+	u8 dir;
+	u16 ct_zone_id;
+	u8 ct_zone_flags;
+	u8 ct_zone_dir;
 } __attribute__((preserve_access_index));
 
 struct nf_conn *bpf_xdp_ct_alloc(struct xdp_md *, struct bpf_sock_tuple *, u32,
@@ -84,16 +90,6 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
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
@@ -220,10 +216,77 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 	}
 }
 
+static __always_inline void
+nf_ct_zone_id_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
+						struct bpf_ct_opts___local *, u32),
+		   struct nf_conn *(*alloc_fn)(void *, struct bpf_sock_tuple *, u32,
+					       struct bpf_ct_opts___local *, u32),
+		   void *ctx)
+{
+	struct bpf_ct_opts___local opts_def = { .l4proto = IPPROTO_TCP, .netns_id = -1 };
+	struct bpf_sock_tuple bpf_tuple;
+	struct nf_conn *ct;
+
+	__builtin_memset(&bpf_tuple, 0, sizeof(bpf_tuple.ipv4));
+
+	bpf_tuple.ipv4.saddr = bpf_get_prandom_u32(); /* src IP */
+	bpf_tuple.ipv4.daddr = bpf_get_prandom_u32(); /* dst IP */
+	bpf_tuple.ipv4.sport = bpf_get_prandom_u32(); /* src port */
+	bpf_tuple.ipv4.dport = bpf_get_prandom_u32(); /* dst port */
+
+	/* use non-default ct zone */
+	opts_def.ct_zone_id = 10;
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
+	nf_ct_zone_id_test((void *)bpf_xdp_ct_lookup, (void *)bpf_xdp_ct_alloc, ctx);
 	return 0;
 }
 
@@ -231,6 +294,7 @@ SEC("tc")
 int nf_skb_ct_test(struct __sk_buff *ctx)
 {
 	nf_ct_test((void *)bpf_skb_ct_lookup, (void *)bpf_skb_ct_alloc, ctx);
+	nf_ct_zone_id_test((void *)bpf_skb_ct_lookup, (void *)bpf_skb_ct_alloc, ctx);
 	return 0;
 }
 
-- 
2.34.1


