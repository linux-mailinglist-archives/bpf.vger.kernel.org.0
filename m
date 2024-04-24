Return-Path: <bpf+bounces-27644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 546038B0057
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 06:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC68B23CBA
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 04:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28852142E97;
	Wed, 24 Apr 2024 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="jj9edzBd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09513D619
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931571; cv=none; b=RRzrs50XbUN2HBWkKUyVTvLYVcb7RX14BmTp6CBHuwzvbx/gcz9JuydTAWfXouQ7wQaiJ7BcTOnWRScBXJalYEKebHRJ5nZ6yYswmV48eL+D7Y7xv2McSX/mXEAa9UC86ywu4GCVJ2ymi5Hw1bigGH1P5JxxcR9ZvmRSVt19lhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931571; c=relaxed/simple;
	bh=ixjUJXw4nQE3HB83UKcfDymblYLFDl/G8ayYXzBTTRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cCxYnuX8UNZfBByCJiOmD7IUTRXIDMo/97h0vTHbqjfHiPc0U77B3BMUKYxeNQHP2y+wysl52tOgJW5+3NgaIcH9GTBi5yR5N4qPfvgmMT2MSZHxcc5J0RwRjSfIMCy7GJQ9F2Bw1qSDqehIcSSSdokImUPLzU5qV5APWqZFg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz; spf=pass smtp.mailfrom=fe-bounces.faucet.nz; dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b=jj9edzBd; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-4ed8c67516; t=1713931559;
 bh=dctxQUTxOdRJTH9kP5hwSd0PPiNt9bq+Uh5QaMkxLw8=;
 b=jj9edzBdogH6xY0SS6A/nDQSzItOFCGKkYEpDSXnqrqxTCAdxDE9wIV7Sd9gQ866y708LQQ4O
 0pU6Q18iI9SQ0sVw9sJnE9cQWls9FEdjjwZL64vuks1ESwqGc+WOQEQGbD/eY0AbnYjke/w2mLf
 yMeySaeXiyvC/auEpgs4C+I=
From: Brad Cowie <brad@faucet.nz>
To: bpf@vger.kernel.org, martin.lau@linux.dev
Cc: lorenzo@kernel.org, memxor@gmail.com, pablo@netfilter.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, Brad Cowie <brad@faucet.nz>
Subject: [PATCH bpf-next v2 1/2] net: netfilter: Make ct zone opts configurable for bpf ct helpers
Date: Wed, 24 Apr 2024 15:00:26 +1200
Message-Id: <20240424030027.3932184-1-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
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
X-ForwardEmail-ID: 662875fefb9de1ab903e411e

Add ct zone id/flags/dir to bpf_ct_opts so that arbitrary ct zones
can be used for xdp/tc bpf ct helper functions bpf_{xdp,skb}_ct_alloc
and bpf_{xdp,skb}_ct_lookup.

Signed-off-by: Brad Cowie <brad@faucet.nz>
---
v1 -> v2:
  - Make ct zone flags/dir configurable
---
 net/netfilter/nf_conntrack_bpf.c | 97 ++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 36 deletions(-)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index d2492d050fe6..67f73b57089b 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -21,41 +21,44 @@
 /* bpf_ct_opts - Options for CT lookup helpers
  *
  * Members:
- * @netns_id   - Specify the network namespace for lookup
- *		 Values:
- *		   BPF_F_CURRENT_NETNS (-1)
- *		     Use namespace associated with ctx (xdp_md, __sk_buff)
- *		   [0, S32_MAX]
- *		     Network Namespace ID
- * @error      - Out parameter, set for any errors encountered
- *		 Values:
- *		   -EINVAL - Passed NULL for bpf_tuple pointer
- *		   -EINVAL - opts->reserved is not 0
- *		   -EINVAL - netns_id is less than -1
- *		   -EINVAL - opts__sz isn't NF_BPF_CT_OPTS_SZ (12)
- *		   -EPROTO - l4proto isn't one of IPPROTO_TCP or IPPROTO_UDP
- *		   -ENONET - No network namespace found for netns_id
- *		   -ENOENT - Conntrack lookup could not find entry for tuple
- *		   -EAFNOSUPPORT - tuple__sz isn't one of sizeof(tuple->ipv4)
- *				   or sizeof(tuple->ipv6)
- * @l4proto    - Layer 4 protocol
- *		 Values:
- *		   IPPROTO_TCP, IPPROTO_UDP
- * @dir:       - connection tracking tuple direction.
- * @reserved   - Reserved member, will be reused for more options in future
- *		 Values:
- *		   0
+ * @netns_id	  - Specify the network namespace for lookup
+ *		    Values:
+ *		      BPF_F_CURRENT_NETNS (-1)
+ *		        Use namespace associated with ctx (xdp_md, __sk_buff)
+ *		      [0, S32_MAX]
+ *		        Network Namespace ID
+ * @error	  - Out parameter, set for any errors encountered
+ *		    Values:
+ *		      -EINVAL - Passed NULL for bpf_tuple pointer
+ *		      -EINVAL - netns_id is less than -1
+ *		      -EINVAL - opts__sz isn't NF_BPF_CT_OPTS_SZ (16)
+ *			        or NF_BPF_CT_OPTS_OLD_SZ (12)
+ *		      -EPROTO - l4proto isn't one of IPPROTO_TCP or IPPROTO_UDP
+ *		      -ENONET - No network namespace found for netns_id
+ *		      -ENOENT - Conntrack lookup could not find entry for tuple
+ *		      -EAFNOSUPPORT - tuple__sz isn't one of sizeof(tuple->ipv4)
+ *				      or sizeof(tuple->ipv6)
+ * @l4proto	  - Layer 4 protocol
+ *		    Values:
+ *		      IPPROTO_TCP, IPPROTO_UDP
+ * @dir:	  - connection tracking tuple direction.
+ * @ct_zone_id	  - connection tracking zone id.
+ * @ct_zone_flags - connection tracking zone flags.
+ * @ct_zone_dir   - connection tracking zone direction.
  */
 struct bpf_ct_opts {
 	s32 netns_id;
 	s32 error;
 	u8 l4proto;
 	u8 dir;
-	u8 reserved[2];
+	u16 ct_zone_id;
+	u8 ct_zone_flags;
+	u8 ct_zone_dir;
 };
 
 enum {
-	NF_BPF_CT_OPTS_SZ = 12,
+	NF_BPF_CT_OPTS_SZ = 16,
+	NF_BPF_CT_OPTS_OLD_SZ = 12,
 };
 
 static int bpf_nf_ct_tuple_parse(struct bpf_sock_tuple *bpf_tuple,
@@ -104,11 +107,13 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
 			u32 timeout)
 {
 	struct nf_conntrack_tuple otuple, rtuple;
+	struct nf_conntrack_zone ct_zone;
 	struct nf_conn *ct;
 	int err;
 
-	if (!opts || !bpf_tuple || opts->reserved[0] || opts->reserved[1] ||
-	    opts_len != NF_BPF_CT_OPTS_SZ)
+	if (!opts || !bpf_tuple)
+		return ERR_PTR(-EINVAL);
+	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == NF_BPF_CT_OPTS_OLD_SZ))
 		return ERR_PTR(-EINVAL);
 
 	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
@@ -130,7 +135,16 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
 			return ERR_PTR(-ENONET);
 	}
 
-	ct = nf_conntrack_alloc(net, &nf_ct_zone_dflt, &otuple, &rtuple,
+	if (opts_len == NF_BPF_CT_OPTS_SZ) {
+		if (opts->ct_zone_dir == 0)
+			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
+		nf_ct_zone_init(&ct_zone,
+				opts->ct_zone_id, opts->ct_zone_dir, opts->ct_zone_flags);
+	} else {
+		ct_zone = nf_ct_zone_dflt;
+	}
+
+	ct = nf_conntrack_alloc(net, &ct_zone, &otuple, &rtuple,
 				GFP_ATOMIC);
 	if (IS_ERR(ct))
 		goto out;
@@ -152,11 +166,13 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
 {
 	struct nf_conntrack_tuple_hash *hash;
 	struct nf_conntrack_tuple tuple;
+	struct nf_conntrack_zone ct_zone;
 	struct nf_conn *ct;
 	int err;
 
-	if (!opts || !bpf_tuple || opts->reserved[0] || opts->reserved[1] ||
-	    opts_len != NF_BPF_CT_OPTS_SZ)
+	if (!opts || !bpf_tuple)
+		return ERR_PTR(-EINVAL);
+	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == NF_BPF_CT_OPTS_OLD_SZ))
 		return ERR_PTR(-EINVAL);
 	if (unlikely(opts->l4proto != IPPROTO_TCP && opts->l4proto != IPPROTO_UDP))
 		return ERR_PTR(-EPROTO);
@@ -174,7 +190,16 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
 			return ERR_PTR(-ENONET);
 	}
 
-	hash = nf_conntrack_find_get(net, &nf_ct_zone_dflt, &tuple);
+	if (opts_len == NF_BPF_CT_OPTS_SZ) {
+		if (opts->ct_zone_dir == 0)
+			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
+		nf_ct_zone_init(&ct_zone,
+				opts->ct_zone_id, opts->ct_zone_dir, opts->ct_zone_flags);
+	} else {
+		ct_zone = nf_ct_zone_dflt;
+	}
+
+	hash = nf_conntrack_find_get(net, &ct_zone, &tuple);
 	if (opts->netns_id >= 0)
 		put_net(net);
 	if (!hash)
@@ -245,7 +270,7 @@ __bpf_kfunc_start_defs();
  * @opts	- Additional options for allocation (documented above)
  *		    Cannot be NULL
  * @opts__sz	- Length of the bpf_ct_opts structure
- *		    Must be NF_BPF_CT_OPTS_SZ (12)
+ *		    Must be NF_BPF_CT_OPTS_SZ (16)
  */
 __bpf_kfunc struct nf_conn___init *
 bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
@@ -279,7 +304,7 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts	- Additional options for lookup (documented above)
  *		    Cannot be NULL
  * @opts__sz	- Length of the bpf_ct_opts structure
- *		    Must be NF_BPF_CT_OPTS_SZ (12)
+ *		    Must be NF_BPF_CT_OPTS_SZ (16)
  */
 __bpf_kfunc struct nf_conn *
 bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
@@ -312,7 +337,7 @@ bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts	- Additional options for allocation (documented above)
  *		    Cannot be NULL
  * @opts__sz	- Length of the bpf_ct_opts structure
- *		    Must be NF_BPF_CT_OPTS_SZ (12)
+ *		    Must be NF_BPF_CT_OPTS_SZ (16)
  */
 __bpf_kfunc struct nf_conn___init *
 bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
@@ -347,7 +372,7 @@ bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts	- Additional options for lookup (documented above)
  *		    Cannot be NULL
  * @opts__sz	- Length of the bpf_ct_opts structure
- *		    Must be NF_BPF_CT_OPTS_SZ (12)
+ *		    Must be NF_BPF_CT_OPTS_SZ (16)
  */
 __bpf_kfunc struct nf_conn *
 bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
-- 
2.34.1


