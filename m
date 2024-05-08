Return-Path: <bpf+bounces-29014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893858BF541
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264342867DD
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 04:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393C81757D;
	Wed,  8 May 2024 04:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="gGLDUaxV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925F1A2C15
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715142709; cv=none; b=jl68pYYPLuYeMOcgcF5exiYK6foKbqKl2FW9CVBgqX3va5RqMFWN3i2yz1etwg9ymvz3VPHExSqGhcw8bXCknoa2aFsVpwc8W0cjxP/Yf+60Kdu4IpZx2lruN7BijNLurRs4ombIEq/f5aT/4tPsfBehNpLPBDzngMZvrH0u+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715142709; c=relaxed/simple;
	bh=TcKipYSQ7HxK9DGEAnXO7v/KoZRGOrh+vyY6CyEwTRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FG0hnI72aRXdk21HZcFxTUm2AWsLEQlHWY3takS8kJuZrSyFUupkLIBJLZRoHr5O30qQRZGsknIl1g7z+/nVnDdwD5zjAhQdQJ8lldNLFyXbJRN4kzCFskmAD4XZaB8CZxHL2BfznylgfT7EOY5QedsAMQFnlamd07Ax3xNCF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz; spf=pass smtp.mailfrom=fe-bounces.faucet.nz; dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b=gGLDUaxV; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-4ed8c67516; t=1715142676;
 bh=n5msmILHpinJBimNBcmxIbuUacgT3LzKm/AdQAyT72k=;
 b=gGLDUaxVaCUnDnk77pQcj79FyUzehnBvbAMW+33c/g1kufy446NJ32uO2JI+beqp3y7SRBekZ
 euRkjVSWJuyPjEUq0/znpkcZXEMCi6qS3ECwvQtMELlsgL5/t/nK9oraO+Anm4eisdrMTQj24au
 eta07vcCZlV4xw0rThhq73k=
From: Brad Cowie <brad@faucet.nz>
To: bpf@vger.kernel.org, martin.lau@linux.dev
Cc: lorenzo@kernel.org, memxor@gmail.com, pablo@netfilter.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, Brad Cowie <brad@faucet.nz>
Subject: [PATCH bpf-next v3 1/2] net: netfilter: Make ct zone opts configurable for bpf ct helpers
Date: Wed,  8 May 2024 16:30:32 +1200
Message-Id: <20240508043033.52311-1-brad@faucet.nz>
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
X-ForwardEmail-ID: 663b000c72b4a4e913ba5536

Add ct zone id and direction to bpf_ct_opts so that arbitrary ct zones
can be used for xdp/tc bpf ct helper functions bpf_{xdp,skb}_ct_alloc
and bpf_{xdp,skb}_ct_lookup.

Signed-off-by: Brad Cowie <brad@faucet.nz>
---
v2 -> v3:
  - Remove whitespace changes
  - Add reserved padding options
  - If ct_zone_id is set when opts__sz isn't 16 return -EINVAL
  - Remove ct_zone_flags, not used by nf_conntrack_alloc
    or nf_conntrack_find_get
  - Update comments to reflect opts__sz can be 16 or 12

v1 -> v2:
  - Make ct zone flags/dir configurable
---
 net/netfilter/nf_conntrack_bpf.c | 68 ++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index d2492d050fe6..4a136fc3a9c0 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -32,7 +32,9 @@
  *		   -EINVAL - Passed NULL for bpf_tuple pointer
  *		   -EINVAL - opts->reserved is not 0
  *		   -EINVAL - netns_id is less than -1
- *		   -EINVAL - opts__sz isn't NF_BPF_CT_OPTS_SZ (12)
+ *		   -EINVAL - opts__sz isn't NF_BPF_CT_OPTS_SZ (16) or 12
+ *		   -EINVAL - opts->ct_zone_id set when
+			     opts__sz isn't NF_BPF_CT_OPTS_SZ (16)
  *		   -EPROTO - l4proto isn't one of IPPROTO_TCP or IPPROTO_UDP
  *		   -ENONET - No network namespace found for netns_id
  *		   -ENOENT - Conntrack lookup could not find entry for tuple
@@ -42,6 +44,8 @@
  *		 Values:
  *		   IPPROTO_TCP, IPPROTO_UDP
  * @dir:       - connection tracking tuple direction.
+ * @ct_zone_id - connection tracking zone id.
+ * @ct_zone_dir - connection tracking zone direction.
  * @reserved   - Reserved member, will be reused for more options in future
  *		 Values:
  *		   0
@@ -51,11 +55,13 @@ struct bpf_ct_opts {
 	s32 error;
 	u8 l4proto;
 	u8 dir;
-	u8 reserved[2];
+	u16 ct_zone_id;
+	u8 ct_zone_dir;
+	u8 reserved[3];
 };
 
 enum {
-	NF_BPF_CT_OPTS_SZ = 12,
+	NF_BPF_CT_OPTS_SZ = 16,
 };
 
 static int bpf_nf_ct_tuple_parse(struct bpf_sock_tuple *bpf_tuple,
@@ -104,12 +110,21 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
 			u32 timeout)
 {
 	struct nf_conntrack_tuple otuple, rtuple;
+	struct nf_conntrack_zone ct_zone;
 	struct nf_conn *ct;
 	int err;
 
-	if (!opts || !bpf_tuple || opts->reserved[0] || opts->reserved[1] ||
-	    opts_len != NF_BPF_CT_OPTS_SZ)
+	if (!opts || !bpf_tuple)
 		return ERR_PTR(-EINVAL);
+	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == 12))
+		return ERR_PTR(-EINVAL);
+	if (opts_len == NF_BPF_CT_OPTS_SZ) {
+		if (opts->reserved[0] || opts->reserved[1] || opts->reserved[2])
+			return ERR_PTR(-EINVAL);
+	} else {
+		if (opts->ct_zone_id)
+			return ERR_PTR(-EINVAL);
+	}
 
 	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
 		return ERR_PTR(-EINVAL);
@@ -130,7 +145,16 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_sock_tuple *bpf_tuple,
 			return ERR_PTR(-ENONET);
 	}
 
-	ct = nf_conntrack_alloc(net, &nf_ct_zone_dflt, &otuple, &rtuple,
+	if (opts_len == NF_BPF_CT_OPTS_SZ) {
+		if (opts->ct_zone_dir == 0)
+			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
+		nf_ct_zone_init(&ct_zone,
+				opts->ct_zone_id, opts->ct_zone_dir, 0);
+	} else {
+		ct_zone = nf_ct_zone_dflt;
+	}
+
+	ct = nf_conntrack_alloc(net, &ct_zone, &otuple, &rtuple,
 				GFP_ATOMIC);
 	if (IS_ERR(ct))
 		goto out;
@@ -152,12 +176,21 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
 {
 	struct nf_conntrack_tuple_hash *hash;
 	struct nf_conntrack_tuple tuple;
+	struct nf_conntrack_zone ct_zone;
 	struct nf_conn *ct;
 	int err;
 
-	if (!opts || !bpf_tuple || opts->reserved[0] || opts->reserved[1] ||
-	    opts_len != NF_BPF_CT_OPTS_SZ)
+	if (!opts || !bpf_tuple)
 		return ERR_PTR(-EINVAL);
+	if (!(opts_len == NF_BPF_CT_OPTS_SZ || opts_len == 12))
+		return ERR_PTR(-EINVAL);
+	if (opts_len == NF_BPF_CT_OPTS_SZ) {
+		if (opts->reserved[0] || opts->reserved[1] || opts->reserved[2])
+			return ERR_PTR(-EINVAL);
+	} else {
+		if (opts->ct_zone_id)
+			return ERR_PTR(-EINVAL);
+	}
 	if (unlikely(opts->l4proto != IPPROTO_TCP && opts->l4proto != IPPROTO_UDP))
 		return ERR_PTR(-EPROTO);
 	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
@@ -174,7 +207,16 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
 			return ERR_PTR(-ENONET);
 	}
 
-	hash = nf_conntrack_find_get(net, &nf_ct_zone_dflt, &tuple);
+	if (opts_len == NF_BPF_CT_OPTS_SZ) {
+		if (opts->ct_zone_dir == 0)
+			opts->ct_zone_dir = NF_CT_DEFAULT_ZONE_DIR;
+		nf_ct_zone_init(&ct_zone,
+				opts->ct_zone_id, opts->ct_zone_dir, 0);
+	} else {
+		ct_zone = nf_ct_zone_dflt;
+	}
+
+	hash = nf_conntrack_find_get(net, &ct_zone, &tuple);
 	if (opts->netns_id >= 0)
 		put_net(net);
 	if (!hash)
@@ -245,7 +287,7 @@ __bpf_kfunc_start_defs();
  * @opts	- Additional options for allocation (documented above)
  *		    Cannot be NULL
  * @opts__sz	- Length of the bpf_ct_opts structure
- *		    Must be NF_BPF_CT_OPTS_SZ (12)
+ *		    Must be NF_BPF_CT_OPTS_SZ (16) or 12
  */
 __bpf_kfunc struct nf_conn___init *
 bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
@@ -279,7 +321,7 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts	- Additional options for lookup (documented above)
  *		    Cannot be NULL
  * @opts__sz	- Length of the bpf_ct_opts structure
- *		    Must be NF_BPF_CT_OPTS_SZ (12)
+ *		    Must be NF_BPF_CT_OPTS_SZ (16) or 12
  */
 __bpf_kfunc struct nf_conn *
 bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
@@ -312,7 +354,7 @@ bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts	- Additional options for allocation (documented above)
  *		    Cannot be NULL
  * @opts__sz	- Length of the bpf_ct_opts structure
- *		    Must be NF_BPF_CT_OPTS_SZ (12)
+ *		    Must be NF_BPF_CT_OPTS_SZ (16) or 12
  */
 __bpf_kfunc struct nf_conn___init *
 bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
@@ -347,7 +389,7 @@ bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
  * @opts	- Additional options for lookup (documented above)
  *		    Cannot be NULL
  * @opts__sz	- Length of the bpf_ct_opts structure
- *		    Must be NF_BPF_CT_OPTS_SZ (12)
+ *		    Must be NF_BPF_CT_OPTS_SZ (16) or 12
  */
 __bpf_kfunc struct nf_conn *
 bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
-- 
2.34.1


