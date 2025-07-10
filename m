Return-Path: <bpf+bounces-62910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB976AFFF39
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84935A511D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137CD2D8DAF;
	Thu, 10 Jul 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjdeAyY1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B02C1599
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143203; cv=none; b=P+iZ/kwYzytbX7H7tnxOaXjxpORUbe4r3gb97HvpG4dt/ie5k+n9PdPwYsBjTIfZgyEDfwAhfj/pkvTEZVxetRDXCvNIZfSi1cMhm4dsjE3yojoyikoKKu2o7+w69p4lF+eac4zfoKc1ocbt6HGgzoAwx713RIle9i0hgWC5pUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143203; c=relaxed/simple;
	bh=KQu2MJtzDPhLXJL6vQzXJUwGQ+XqqvQkX+7VcJgW0go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eyq3Qh3pXl/pm2XFXE/cVRAcfz1hCWBXntHgZ7b4gv/8uuCWpSig5LR3eTyGSekAqEqcNRn1Ut+Aj/GXLcZw+nbe9raaErDPtdhmcQ2C9ch5ZhtNov4AfqYmeSeUaNxdQFTxJkax+UBOsQl2vQxYLFbzKKelCvz3PuAMf6jHQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjdeAyY1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso13724385e9.0
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752143200; x=1752748000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTkbQnmUIoSFDoPiPFuvmlQdhgMWK9fGlB17UK6/q7A=;
        b=EjdeAyY1DaG850Rv9x4b43BRhY6GkIiy3wA+eNm+X+54TXOK6BmE4j6hD19u5O+a4C
         4OOAN+Cu8M13N73ddTR9MY7a7SGKvBB/pJBKL5PHU3IFiP+6zcONu0M7+LS9UpVcFkJx
         3NbUheQn8GyrOCJDtm+TBAa5I6vSdBZNx7rc3oOQQOePvy8z4b297wveayoCUSPGaCwV
         GJd3MNjbefvJTrrU7njP0pHlGsv8Rn4Isq8w2aB437Bbo88oyO6mVahvpUB3YbIhx+TI
         f5HoM8QbzQ6y0vIcDMYy2v8ic+UGFpS0+LZ7fXbgqpfj4YV90paYJJ9EhUGDAOgRBZRM
         ntXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143200; x=1752748000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTkbQnmUIoSFDoPiPFuvmlQdhgMWK9fGlB17UK6/q7A=;
        b=oNEtTubVMvKxWiaD4N0D6hNmmsSSlqQ5D0WoyVoTAXNncBlevqr/8RBW7rfz6RZAOD
         HNxKcPYzITyCkv8DOjq3jYYaT0lgdBTw1llk16BthgaLrBNbMomP83/sn9Lidff0pVZh
         2SC2VRjGEVP0GNjMfNJbjgn/+MNeBV8IC0uWvL4CTpZrFYp+Djf9hcxYHoMXCypGzhy8
         Cc6EJFfLuUuOh0P/2h7AVOddG7UdyZ4BKhDJ5TFXv4YpbqBvv+jcQRfyCpctgfJW/Qz5
         b+347JzgXAUs50PFxKKCEbWERx2Bh8YjULEbVAwfs3WCgRj3fvipA1XpjGm5HOShQfoC
         JTqw==
X-Gm-Message-State: AOJu0YzAh5C/DDh/9iFDMGvK5EG7yARJb/AOexfACrNJeudAIqBJOpOa
	aRzSrauEu3k6MnJt6qhv+Hu3u/L0E08eVp/03mZVjX6BRw41GmZcq84M/WS9E0zqsUm7ew==
X-Gm-Gg: ASbGncu1m789DkljJz8APA7JGBi7BYBTslHkCUFV9wk7n+Xi7CrvNX87Jw/toCZPqDE
	LZ/AhOGZC8CECnSurLcpjzgcz1CMNOrpaReC994kT+vX74Uli48h1LvdcIIpty8F8rgj+wglwYP
	NqVx5nuo57Zag4qCnYF2LKHIlis4Pzot4K68EIoKj2b5UITRtQkK/rtQCSMlacgY185Ez+Gn8Yg
	kX9WV1LjPJSS3j3Y+vju/0ZA2gYUMRogSjqqHfujaVoh3BrvNira9EBL6/NgKKj/v5SGL94l6ta
	vL6dC/JrUJ7ETZ6VehFOamd2ueSVM+RKiCJF+w2VrcYZyzF13CKbw7nndwnDPVYSCEcJgTHjF6x
	VlNaWUTt8JdF5
X-Google-Smtp-Source: AGHT+IEvw1z6nCr6n7Nf6SG9jAA//9L2W2xiqrZCc4OYQY0z3rbBYhsNLMeRPsr1A4rjMqumPrFNfQ==
X-Received: by 2002:a05:600c:4f06:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-454e10d1497mr2982055e9.3.1752143199878;
        Thu, 10 Jul 2025 03:26:39 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454d511cb48sm52639745e9.36.2025.07.10.03.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:26:39 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v1 3/4] bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
Date: Thu, 10 Jul 2025 10:26:06 +0000
Message-Id: <20250710102607.12413-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710102607.12413-1-mahe.tardy@gmail.com>
References: <20250710102607.12413-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed in the context of Tetragon to provide improved feedback
(in contrast to just dropping packets) to east-west traffic when blocked
by policies using cgroup_skb programs.

This reuse concepts from netfilter reject target codepath with the
differences that:
* Packets are cloned since the BPF user can still return SK_PASS from
  the cgroup_skb progs and the current skb need to stay untouched
  (cgroup_skb hooks only allow read-only skb payload).
* Since cgroup_skb programs are called late in the stack, checksums do
  not need to be computed or verified, and IPv4 fragmentation does not
  need to be checked (ip_local_deliver should take care of that
  earlier).

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index ab456bf1056e..9215f79e7690 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -85,6 +85,8 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmp.h>
+#include <net/icmp.h>

 #include "dev.h"

@@ -12140,6 +12142,53 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }

+__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
+{
+	struct sk_buff *skb = (struct sk_buff *)__skb;
+	struct sk_buff *nskb;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (code < 0 || code > NR_ICMP_UNREACH)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (ip_route_reply_fetch_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);
+		kfree_skb(nskb);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (ip6_route_reply_fetch_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
+		kfree_skb(nskb);
+		break;
+#endif
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();

 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12177,6 +12226,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send_unreach)
+BTF_ID_FLAGS(func, bpf_icmp_send_unreach, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send_unreach)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12202,6 +12255,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
 	.set = &bpf_kfunc_check_set_sock_ops,
 };

+static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send_unreach = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_icmp_send_unreach,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -12221,7 +12279,8 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send_unreach);
 }
 late_initcall(bpf_kfunc_init);

--
2.34.1


