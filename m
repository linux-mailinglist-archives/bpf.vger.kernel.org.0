Return-Path: <bpf+bounces-35005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752C3934F1B
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D741C217B3
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1111422DC;
	Thu, 18 Jul 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLZ5nFiZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCFC13B588
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313102; cv=none; b=D4uZYAeFaGerq95dR5Z19IZydUeu4tpAdoB26d3/Fum7wmjeg5O+xgsuBiL2AI7DqCfHVj1/Bu5wdZ72E3FmM1KVwErvba0AuFSt4UiyFIGibdt6pnl4O5yvqKAAeedq8PHxJsrt03NNC/eaADeoziJtazfFAegnAvW6bEAPBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313102; c=relaxed/simple;
	bh=aZC0NipmOCpnDWuRU4Lpn4yFcg9U/gTdWFivPqFpvck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjukpRlLX6QTGbNLPzVeKO3r1e94RbeULOZt/KSZE6lcUrsf6HTQIiWiKB0HB0hK602pjbKr3RUOMyvssc3davDNkKocQZcOrQsMPvwAZByknUj37Bot0M0/O+omTWQnZ0b35XivEUX7QXNOtNkJmFK+JHFf27M4TOyvZul0eTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLZ5nFiZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721313099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RQgd9VnW1B97sus5iTeLLvYo9dx1plAad5b8ctUM7g8=;
	b=OLZ5nFiZmtewzryUMNdwJL8+F36UBYuCpzDbloNmlp4MdOe11ivHQlVI9gjI8GKWrNmiQQ
	gYfdIifdIwttI1lrKaCr8LXG7wV4ZSD9PWponcFSop8NGVakiWro7XPwOZsxJRy4r6ZaGv
	kCilw9yzg+WpP4k9iPVYlC8B8piDFPE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-9bsy6NdJObKfacfuKh6QJQ-1; Thu,
 18 Jul 2024 10:31:29 -0400
X-MC-Unique: 9bsy6NdJObKfacfuKh6QJQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB7741956080;
	Thu, 18 Jul 2024 14:31:27 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17B52195605A;
	Thu, 18 Jul 2024 14:31:24 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH bpf-next] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
Date: Thu, 18 Jul 2024 16:31:22 +0200
Message-ID: <20240718143122.2230780-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Without CONFIG_NET_FOU bpf selftests are unable to build because of
missing definitions. Add ___local versions of struct bpf_fou_encap and
enum bpf_fou_encap_type to fix the issue.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3f5abcf3ff136..0913ec384b159 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -26,10 +26,20 @@
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
@@ -745,7 +755,7 @@ SEC("tc")
 int ipip_gue_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key = {};
-	struct bpf_fou_encap encap = {};
+	struct bpf_fou_encap___local encap = {};
 	void *data = (void *)(long)skb->data;
 	struct iphdr *iph = data;
 	void *data_end = (void *)(long)skb->data_end;
@@ -769,7 +779,7 @@ int ipip_gue_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE);
+	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE___local);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
@@ -782,7 +792,7 @@ SEC("tc")
 int ipip_fou_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key = {};
-	struct bpf_fou_encap encap = {};
+	struct bpf_fou_encap___local encap = {};
 	void *data = (void *)(long)skb->data;
 	struct iphdr *iph = data;
 	void *data_end = (void *)(long)skb->data_end;
@@ -806,7 +816,7 @@ int ipip_fou_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_FOU);
+	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_FOU___local);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
@@ -820,7 +830,7 @@ int ipip_encap_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key = {};
-	struct bpf_fou_encap encap = {};
+	struct bpf_fou_encap___local encap = {};
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
-- 
2.45.2


