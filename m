Return-Path: <bpf+bounces-71358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020BBEFBF6
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E5F3E133C
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 07:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFA52E22A7;
	Mon, 20 Oct 2025 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BTIkRn1f"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98ED2E1F02;
	Mon, 20 Oct 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946897; cv=none; b=aF+IbTVG1kmSwMS3JKJUO5mlJUHiYQig7TIDuchkhmyDJM77p27sL9rMQRMWEDOzebeKz7gZaQoF5IriyHYrUocE9FGeiCCeJjOnpIXBYmcSy2hXf4i/t78nJvpocHa39TCcvvPdIgXuWZDc+Qd9scmMXSVy04cj+S5Fszz/4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946897; c=relaxed/simple;
	bh=I5jCuepJI3vrBvT25Ra6E0AMw9dK+4snMIFbHEyu6Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnO7kfziYC/PrEcH+PPQFk3LM5kwl60Grw5BJekVr6iPw0bAAYCYCEm1ZAqcBezQJpgFV0rWTbfn0+Ha8L3Q3xcJCRjf3cNdDvViZ5TLbKZa5OrJag4rb1oJ0TKiWXmz+s6U2BgnI9FmOX4SaDYr0QNzS/dyjr1ajxOyWOaTBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BTIkRn1f; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=1jRErsjafOp2xqxe194vdLdVYDDtMtkVjrDYsKvGIbo=; b=BTIkRn1f0TazF+WECcO+mZejxM
	YJjEuNo/NtQljql4Dc+cNxegqUDJ1DT4uHBf40n3OAQmd17iDh+qrWP95RGu9E4hObejt9GdBdfgf
	aqOIHpoqzjG34c3DrLwt1i+n3lpLsXmMx7v20b7hsJc1vH4yjI3RW8a3tRbaNNceAXKy/rZr7nmbo
	n6OsY4RR3t9nnav2KFp9HzOgv4eByMejGEvI2epGayC49kq8fwZ5+G2XlkwEblRYXbZQPXX44Qwtr
	601GCQHmWxqe/z9i6IxAU7d7vivd+fo061SDt4OAdE86+QiC1LqdYzyZyAPq4+nZj57/r6I6YMR4q
	4sw+gCRw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAkj4-0005ZV-1Q;
	Mon, 20 Oct 2025 09:54:42 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@linux.dev
Cc: kuba@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Willem de Bruijn <willemb@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf] bpf: Do not let BPF test infra emit invalid GSO types to stack
Date: Mon, 20 Oct 2025 09:54:41 +0200
Message-ID: <20251020075441.127980-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27797/Sun Oct 19 11:52:26 2025)

Yinhao et al. reported that their fuzzer tool was able to trigger a
skb_warn_bad_offload() from netif_skb_features() -> gso_features_check().
When a BPF program - triggered via BPF test infra - pushes the packet
to the loopback device via bpf_clone_redirect() then mentioned offload
warning can be seen. GSO-related features are then rightfully disabled.

We get into this situation due to convert___skb_to_skb() setting
gso_segs and gso_size but not gso_type. Technically, it makes sense
that this warning triggers since the GSO properties are malformed due
to the gso_type. Potentially, the gso_type could be marked non-trustworthy
through setting it at least to SKB_GSO_DODGY without any other specific
assumptions, but that also feels wrong given we should not go further
into the GSO engine in the first place.

The checks were added in 121d57af308d ("gso: validate gso_type in GSO
handlers") because there were malicious (syzbot) senders that combine
a protocol with a non-matching gso_type. If we would want to drop such
packets, gso_features_check() currently only returns feature flags via
netif_skb_features(), so one location for potentially dropping such skbs
could be validate_xmit_unreadable_skb(), but then otoh it would be
an additional check in the fast-path for a very corner case. Given
bpf_clone_redirect() is the only place where BPF test infra could emit
such packets, lets reject them right there.

Fixes: 850a88cc4096 ("bpf: Expose __sk_buff wire_len/gso_segs to BPF_PROG_TEST_RUN")
Fixes: cf62089b0edd ("bpf: Add gso_size to __sk_buff")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
---
 [ bpf-next would be fine as well imho since its mainly about muting
   the skb_warn_bad_offload warning. The Fixes tags are mainly for
   reference / historic context. ]

 net/bpf/test_run.c | 5 +++++
 net/core/filter.c  | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 1782e83de2cb..983b9ee1164b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -950,6 +950,11 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 
 	if (__skb->gso_segs > GSO_MAX_SEGS)
 		return -EINVAL;
+
+	/* Currently GSO type is zero/unset. If this gets extended with
+	 * a small list of accepted GSO types in future, the filter for
+	 * an unset GSO type in bpf_clone_redirect() can be lifted.
+	 */
 	skb_shinfo(skb)->gso_segs = __skb->gso_segs;
 	skb_shinfo(skb)->gso_size = __skb->gso_size;
 	skb_shinfo(skb)->hwtstamps.hwtstamp = __skb->hwtstamp;
diff --git a/net/core/filter.c b/net/core/filter.c
index 76628df1fc82..9d67a34a6650 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2458,6 +2458,13 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return -EINVAL;
 
+	/* BPF test infra's convert___skb_to_skb() can create type-less
+	 * GSO packets. gso_features_check() will detect this as a bad
+	 * offload. However, lets not leak them out in the first place.
+	 */
+	if (unlikely(skb_is_gso(skb) && !skb_shinfo(skb)->gso_type))
+		return -EBADMSG;
+
 	dev = dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
 	if (unlikely(!dev))
 		return -EINVAL;
-- 
2.43.0


