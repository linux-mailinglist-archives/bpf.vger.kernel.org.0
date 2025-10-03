Return-Path: <bpf+bounces-70283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E86BB62ED
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 09:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247F7483A32
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 07:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD54224C692;
	Fri,  3 Oct 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SJqeJVLl"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC51D618A;
	Fri,  3 Oct 2025 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476873; cv=none; b=Lr7cHHjhU5+DgCZpjgx9hdKlOBhNdtugtXJfDd642dQH5L1/Dvk4Ryn+ppePgtTfnCp1ZQBUb9fR4Lfln4WOoUOCTw0lkvOR+ncifbFVO8v+nfr1MoF6PQVDUP2ECWbvqt6TMzbLPYftr0KMCV85Yz7Vxof2O00BP2GwWV05nsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476873; c=relaxed/simple;
	bh=io/h4GzS9wWQgqDX6Wc8kmkzuLIzr692lbaIDGlGbaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJM6+IzckkbS2CLP0p7ILHqIe0oyHMME+dnlSBWU5r1EKK3WAAFEp2EJp+3AJN2Qg+jdSYchBNrxmEtdDU5DFP3+KSeARmG+i9GW51PNRFymMjp73KvsCY3nFBN8USmWxwFv5MO/+9rGxudNFFS5B3o4Hwf5W+13zLsgGt1j4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=SJqeJVLl; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=fXxC7BylrfSaTRfh3Iv/Tne5kbRujfdPCymewfxL8Nw=; b=SJqeJVLls1Z/et3HorVm1+SuGj
	80oMQCy8w8oXKfw6HrLzEpNaz5sZHQKgG8aYzHaiPam0XC6jfOsMAhbcBB50vd6JKLJjvBOXwdFVe
	hW9OwVEpIWsdxg1kZKmuWqwfz4S11qcqxGhRKMwFXJGq4iS4+BrshWMBt3eh86N39GAac6BV4AIQ2
	1f8c/o5kQPWuEYK5pr9w54QQkmXNLdGoYwQDk7Tzo+ORdFBwGlNHuPfmhXbudbnAI7xkVnYqJbPUm
	lGCNVOMnHqJF6B1jHcozby/MHU5ArYgsDHWW9o6C/Wm0BG9Yp4MQnHxWZMkI2OOAcxzHJeNKQEFbI
	ZQ8gUi/w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v4aJ1-000BI1-0q;
	Fri, 03 Oct 2025 09:34:19 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>,
	Julian Wiedmann <jwi@isovalent.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jordan Rife <jrife@google.com>
Subject: [PATCH bpf] bpf: Fix metadata_dst leak __bpf_redirect_neigh_v{4,6}
Date: Fri,  3 Oct 2025 09:34:18 +0200
Message-ID: <20251003073418.291171-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27780/Thu Oct  2 04:58:32 2025)

Cilium has a BPF egress gateway feature which forces outgoing K8s Pod
traffic to pass through dedicated egress gateways which then SNAT the
traffic in order to interact with stable IPs outside the cluster.

The traffic is directed to the gateway via vxlan tunnel in collect md
mode. A recent BPF change utilized the bpf_redirect_neigh() helper to
forward packets after the arrival and decap on vxlan, which turned out
over time that the kmalloc-256 slab usage in kernel was ever-increasing.

The issue was that vxlan allocates the metadata_dst object and attaches
it through a fake dst entry to the skb. The latter was never released
though given bpf_redirect_neigh() was merely setting the new dst entry
via skb_dst_set() without dropping an existing one first.

Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Reported-by: Julian Wiedmann <jwi@isovalent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jordan Rife <jrife@google.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index b005363f482c..c3c0b5a37504 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2281,6 +2281,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 		if (IS_ERR(dst))
 			goto out_drop;
 
+		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	} else if (nh->nh_family != AF_INET6) {
 		goto out_drop;
@@ -2389,6 +2390,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 			goto out_drop;
 		}
 
+		skb_dst_drop(skb);
 		skb_dst_set(skb, &rt->dst);
 	}
 
-- 
2.43.0


