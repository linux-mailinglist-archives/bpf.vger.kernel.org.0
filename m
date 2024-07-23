Return-Path: <bpf+bounces-35378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A653B939B84
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 09:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BED21F22AB0
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89BD14B965;
	Tue, 23 Jul 2024 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyOQpiaJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19714B940
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718648; cv=none; b=NmF0M+vFdtnKZphtg3VSqYCIgZ6tJfTyFrRIOuSbdxGaCCoJG6NgDtCfSh2kqDK4MSN8tVKwAHF0AIEmRxWOqWJDF5OpnooXeTqQVxY93f+M+RFH4kqWSsxcf3XuQg49gHGj3P5w4+D/5Ke0P/35glAmiMIMalAHOBKGJxaJZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718648; c=relaxed/simple;
	bh=u/QsKyttUCU09OB5lypgCukROiu0KDjYn/kne8MGZsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQnbfTqjvMjr3iueos6TnrF/yU8Wnfgw0KqqByAU9DuL/r545VNARJjcJR1qAbxSG4gP2jlvtMHa0qHfAIMBvIEOvX3c4hf/EEqP0ouU7Rd74hFhRLGaUSLNrWF1Bh+a6M7Oukxll2CtUlhj8PKmwVXdfF3fIacoGbut52Z0fOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyOQpiaJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721718645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdPO/Vt26loGhN/7TbhKVqyyms9ZE6JlxaJFW/Mi4bc=;
	b=JyOQpiaJNqmRnGut4aQpiTY5mTwGdh39SDA/vP0g5N3Q9S1/cEdC3jX7rA9/BhTdkgksN8
	cmTeGlpQZAB2R31z8yNAboerqXkBacAYpIx+Vp2lkSS8JYQASAwSYkK6Ck2F9IXKMYNgGF
	9FRX5j7FTgNPdPUO8c2KuHwsJ/Pb4hE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-NxUWQI8GPx6Udv3-oRtnSA-1; Tue,
 23 Jul 2024 03:10:39 -0400
X-MC-Unique: NxUWQI8GPx6Udv3-oRtnSA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E09B81955F43;
	Tue, 23 Jul 2024 07:10:37 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.224.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B85293000194;
	Tue, 23 Jul 2024 07:10:34 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH bpf-next v3] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
Date: Tue, 23 Jul 2024 09:10:31 +0200
Message-ID: <20240723071031.3389423-1-asavkov@redhat.com>
In-Reply-To: <CAADnVQKE1Xmjhx3Xwdidmmn=BGzjgc89i+UMhHR7=6HupPQZSA@mail.gmail.com>
References: <CAADnVQKE1Xmjhx3Xwdidmmn=BGzjgc89i+UMhHR7=6HupPQZSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Without CONFIG_NET_FOU bpf selftests are unable to build because of
missing definitions. Add ___local versions of struct bpf_fou_encap and
enum bpf_fou_encap_type to fix the issue.

Signed-off-by: Artem Savkov <asavkov@redhat.com>

---
v3: swith from using BPF_NO_KFUNC_PROTOTYPES to casting to keep kfunc
prototype intact.

v2: added BPF_NO_KFUNC_PROTOTYPES define to avoid issues when
CONFIG_NET_FOU is set.
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3f5abcf3ff136..fcff3010d8a60 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -26,6 +26,18 @@
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
+struct bpf_fou_encap;
+
 int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap, int type) __ksym;
 int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
@@ -745,7 +757,7 @@ SEC("tc")
 int ipip_gue_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key = {};
-	struct bpf_fou_encap encap = {};
+	struct bpf_fou_encap___local encap = {};
 	void *data = (void *)(long)skb->data;
 	struct iphdr *iph = data;
 	void *data_end = (void *)(long)skb->data_end;
@@ -769,7 +781,8 @@ int ipip_gue_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE);
+	ret = bpf_skb_set_fou_encap(skb, (struct bpf_fou_encap *)&encap,
+				    FOU_BPF_ENCAP_GUE___local);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
@@ -782,7 +795,7 @@ SEC("tc")
 int ipip_fou_set_tunnel(struct __sk_buff *skb)
 {
 	struct bpf_tunnel_key key = {};
-	struct bpf_fou_encap encap = {};
+	struct bpf_fou_encap___local encap = {};
 	void *data = (void *)(long)skb->data;
 	struct iphdr *iph = data;
 	void *data_end = (void *)(long)skb->data_end;
@@ -806,7 +819,8 @@ int ipip_fou_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_FOU);
+	ret = bpf_skb_set_fou_encap(skb, (struct bpf_fou_encap *)&encap,
+				    FOU_BPF_ENCAP_FOU___local);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
@@ -820,7 +834,7 @@ int ipip_encap_get_tunnel(struct __sk_buff *skb)
 {
 	int ret;
 	struct bpf_tunnel_key key = {};
-	struct bpf_fou_encap encap = {};
+	struct bpf_fou_encap___local encap = {};
 
 	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
 	if (ret < 0) {
@@ -828,7 +842,7 @@ int ipip_encap_get_tunnel(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	ret = bpf_skb_get_fou_encap(skb, &encap);
+	ret = bpf_skb_get_fou_encap(skb, (struct bpf_fou_encap *)&encap);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
-- 
2.45.2


