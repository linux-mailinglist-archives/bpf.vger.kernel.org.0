Return-Path: <bpf+bounces-30261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB828CBA9E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 07:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E65B2195C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 05:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF687710E;
	Wed, 22 May 2024 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="HQ+iT8d5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7935812B
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716354481; cv=none; b=U0dhpzVADRzX/dQLGjtmSnCvjCfCgWncQW21xFqURc4OJU0s1HSrYE4CVrSN1Nb6C86kFOkhzyDV6BFVzrtjLvPbmdpn6+rbyMRnNjJod8xdOml4S+JO0usJxqI/ecmQ8g3hGI2Gy8uYDnIeT1olFtwwvY5yxGH0JsDzQofIPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716354481; c=relaxed/simple;
	bh=4S+sRHsUY0iGGiG/+V3bhoWpHf9h7tv2ZIjvDAPqmD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRUMgu8i90WhoN12sJLsm+xX8izvKhk2Q37Jids4VG6Zt3v6Bj/DVX7wX8y4fUS7NPPjnMYKrw43pawqiYISy+2BA4c1l0BV+8MFGvx46EOafKjqbO9mPYJocAN8qW+pPElZdcsR3kq1tEzijFde4O+V9HtjyXPrnBORMkLhZsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz; spf=pass smtp.mailfrom=fe-bounces.faucet.nz; dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b=HQ+iT8d5; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-Id: Date: Subject: Cc: To: From; q=dns/txt; s=fe-4ed8c67516;
 t=1716354470; bh=+b94uweRdFBN0/L+NL9cyZf4Ao1x41bND2icwaz2k28=;
 b=HQ+iT8d50uVWAWWyUPq3LD0AR+KSq5X4Ck7ISRbMroyGIKZl1h3JN1LXiMKwchfo92oquDTlN
 XhWae/esG6TtdAIoDnJYFdP8KxjcmsD7xGEFS0iU76drJYQbf5njkRVtcHO0b8gpB/xaGcZS/LB
 uUylLC7OjOmEce6suP1ZOEY=
From: Brad Cowie <brad@faucet.nz>
To: bpf@vger.kernel.org, martin.lau@linux.dev
Cc: lorenzo@kernel.org, memxor@gmail.com, pablo@netfilter.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, Brad Cowie <brad@faucet.nz>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Update tests for new ct zone opts for nf_conntrack kfuncs
Date: Wed, 22 May 2024 17:07:12 +1200
Message-Id: <20240522050712.732558-2-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522050712.732558-1-brad@faucet.nz>
References: <20240522050712.732558-1-brad@faucet.nz>
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
 149.28.215.223
X-ForwardEmail-ID: 664d7da30ea3745ceca04956

Add test for allocating and looking up ct entry in a
non-default ct zone with kfuncs bpf_{xdp,skb}_ct_alloc
and bpf_{xdp,skb}_ct_lookup.

Add negative tests for looking up ct entry in a different
ct zone to where it was allocated and with a different
direction.

Update reserved test for old struct definition to test for
ct_zone_id being set when opts size isn't NF_BPF_CT_OPTS_SZ (16).

Signed-off-by: Brad Cowie <brad@faucet.nz>
---
v3 -> v4:
  - Restore test for reserved option in old opts struct

v2 -> v3:
  - Test both old and new bpf_ct_opts struct definitions
  - Restore test for reserved options
  - Add test for ct_zone_dir

v1 -> v2:
  - Separate test changes into different patch
  - Add test for allocating/looking up entry in non-default ct zone
---
 tools/testing/selftests/bpf/config            |   1 +
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   7 ++
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 108 ++++++++++++++++++
 3 files changed, 116 insertions(+)

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
index b30ff6b3b81a..a4a1f93878d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -104,6 +104,7 @@ static void test_bpf_nf_ct(int mode)
 
 	ASSERT_EQ(skel->bss->test_einval_bpf_tuple, -EINVAL, "Test EINVAL for NULL bpf_tuple");
 	ASSERT_EQ(skel->bss->test_einval_reserved, -EINVAL, "Test EINVAL for reserved not set to 0");
+	ASSERT_EQ(skel->bss->test_einval_reserved_new, -EINVAL, "Test EINVAL for reserved in new struct not set to 0");
 	ASSERT_EQ(skel->bss->test_einval_netns_id, -EINVAL, "Test EINVAL for netns_id < -1");
 	ASSERT_EQ(skel->bss->test_einval_len_opts, -EINVAL, "Test EINVAL for len__opts != NF_BPF_CT_OPTS_SZ");
 	ASSERT_EQ(skel->bss->test_eproto_l4proto, -EPROTO, "Test EPROTO for l4proto != TCP or UDP");
@@ -122,6 +123,12 @@ static void test_bpf_nf_ct(int mode)
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
index 77ad8adf68da..0289d8ce2b80 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -9,10 +9,14 @@
 #define EINVAL 22
 #define ENOENT 2
 
+#define NF_CT_ZONE_DIR_ORIG (1 << IP_CT_DIR_ORIGINAL)
+#define NF_CT_ZONE_DIR_REPL (1 << IP_CT_DIR_REPLY)
+
 extern unsigned long CONFIG_HZ __kconfig;
 
 int test_einval_bpf_tuple = 0;
 int test_einval_reserved = 0;
+int test_einval_reserved_new = 0;
 int test_einval_netns_id = 0;
 int test_einval_len_opts = 0;
 int test_eproto_l4proto = 0;
@@ -22,6 +26,11 @@ int test_eafnosupport = 0;
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
@@ -45,6 +54,17 @@ struct bpf_ct_opts___local {
 	s32 netns_id;
 	s32 error;
 	u8 l4proto;
+	u8 dir;
+	u8 reserved[2];
+};
+
+struct bpf_ct_opts___new {
+	s32 netns_id;
+	s32 error;
+	u8 l4proto;
+	u8 dir;
+	u16 ct_zone_id;
+	u8 ct_zone_dir;
 	u8 reserved[3];
 } __attribute__((preserve_access_index));
 
@@ -220,10 +240,97 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
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
+	if (ct)
+		bpf_ct_release(ct);
+	else
+		test_einval_reserved_new = opts_def.error;
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
 
@@ -231,6 +338,7 @@ SEC("tc")
 int nf_skb_ct_test(struct __sk_buff *ctx)
 {
 	nf_ct_test((void *)bpf_skb_ct_lookup, (void *)bpf_skb_ct_alloc, ctx);
+	nf_ct_opts_new_test((void *)bpf_skb_ct_lookup, (void *)bpf_skb_ct_alloc, ctx);
 	return 0;
 }
 
-- 
2.34.1


