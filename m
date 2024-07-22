Return-Path: <bpf+bounces-35229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2822D939035
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF6BB211AA
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C116DC3B;
	Mon, 22 Jul 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2gP95A7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6E16D9D0
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656389; cv=none; b=nSDAfVcyiNDApx/RJrNc08gvKFo+Ev9UP8dqCPH10QLXMTIYVmrRpb88vafoZn2F4irxSSgFznDaX6/qFjPXVD1kF1dwAi3TaWov79nsigPQPnguW/awqan/gHfabbpvmZVtzrCaWLNUxD5uC6azjzVLErPbqWcqvY4k5OHD8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656389; c=relaxed/simple;
	bh=BOwZ4vF66z6wa6MKO33rnyYPrAj9i0vfjPJ/MqZzYgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzGwNuAbBST+qHlyUhcWabilmEidT8Hv6aDfiuKAq8fEJTxNOU/P3tLnXkxPpn6k022bdWlE7qSMcU7Xf6+5muXlHAgQxCJzUSTJp/mibTp7xE8Om1TFCGOJGjyy3ugD3G5N/B9YyloCRsSyAeu6PSZ1APT91t95A/dSUEQFtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2gP95A7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721656385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZetsGJ5blfoCZSbkciEC6WflLyvv2m8UF1Hjh4ODOYY=;
	b=O2gP95A7wwRr5E3ifWwZSoISHIvc51NItIx6eCc9dzDER4nzw75fntZFQPSdRbQCQhfw6g
	iOJ5mVACHt1GHHt2XggqLmGlguJafRaH6mD9qNhuTqjE2yDTJPJjdAeqGpFKhVtO+X5P65
	ADC0xAhZ2nWWP70N+ELlDfVDNHHXPA8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-wwJ61nsKOciIoNFaQQbK5Q-1; Mon,
 22 Jul 2024 09:53:00 -0400
X-MC-Unique: wwJ61nsKOciIoNFaQQbK5Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBFC41944A88;
	Mon, 22 Jul 2024 13:52:57 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AD021955F40;
	Mon, 22 Jul 2024 13:52:55 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH bpf-next v2] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
Date: Mon, 22 Jul 2024 15:52:53 +0200
Message-ID: <20240722135253.3298964-1-asavkov@redhat.com>
In-Reply-To: <005ef8ac-d48e-304f-65c5-97a17d83fd86@iogearbox.net>
References: <005ef8ac-d48e-304f-65c5-97a17d83fd86@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Without CONFIG_NET_FOU bpf selftests are unable to build because of
missing definitions. Add ___local versions of struct bpf_fou_encap and
enum bpf_fou_encap_type to fix the issue.

Signed-off-by: Artem Savkov <asavkov@redhat.com>

---
v2: added BPF_NO_KFUNC_PROTOTYPES define to avoid issues when
CONFIG_NET_FOU is set.
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3f5abcf3ff136..4d526fc73f2bb 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,6 +6,7 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
+#define BPF_NO_KFUNC_PROTOTYPES
 #include "vmlinux.h"
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
@@ -26,10 +27,20 @@
  */
 #define ASSIGNED_ADDR_VETH1 0xac1001c8
 
+struct bpf_fou_encap___local {
+       __be16 sport;
+       __be16 dport;
+};
+
+enum bpf_fou_encap_type___local {
+       FOU_BPF_ENCAP_FOU___local,
+       FOU_BPF_ENCAP_GUE___local,
+};
+
 int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
-			  struct bpf_fou_encap *encap, int type) __ksym;
+			  struct bpf_fou_encap___local *encap, int type) __ksym;
 int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
-			  struct bpf_fou_encap *encap) __ksym;
+			  struct bpf_fou_encap___local *encap) __ksym;
 struct xfrm_state *
 bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts,
 		       u32 opts__sz) __ksym;
@@ -745,7 +756,7 @@ SEC("tc")
 int ipip_gue_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key = {};
-	struct bpf_fou_encap encap = {};
+	struct bpf_fou_encap___local encap = {};
 	void *data = (void *)(long)skb->data;
 	struct iphdr *iph = data;
 	void *data_end = (void *)(long)skb->data_end;
@@ -769,7 +780,7 @@ int ipip_gue_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE);
+	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE___local);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
@@ -782,7 +793,7 @@ SEC("tc")
 int ipip_fou_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key = {};
-	struct bpf_fou_encap encap = {};
+	struct bpf_fou_encap___local encap = {};
 	void *data = (void *)(long)skb->data;
 	struct iphdr *iph = data;
 	void *data_end = (void *)(long)skb->data_end;
@@ -806,7 +817,7 @@ int ipip_fou_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_FOU);
+	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_FOU___local);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
@@ -820,7 +831,7 @@ int ipip_encap_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key = {};
-	struct bpf_fou_encap encap = {};
+	struct bpf_fou_encap___local encap = {};
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
-- 
2.45.2


