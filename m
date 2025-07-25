Return-Path: <bpf+bounces-64395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA98B1246E
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F7564D5E
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DF225B692;
	Fri, 25 Jul 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llC9YKUV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6D2512E6;
	Fri, 25 Jul 2025 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469753; cv=none; b=PlcyuMTfzwQgy8Wkqu54dItDGVFprAHCMw3hOXEBV3wLjIY1eR+hEpj2FPofuo+B21mHs8QL2WU6HxjQ1Qrr+Xg/BcnVjG5b8SwDpw78U/ZMHGeO9NXeFAwqIfwY++zPQ7oNgyZXlVBIqz8qKPau7gmun7PMwkSQXGnDZObIegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469753; c=relaxed/simple;
	bh=IiXOyGL8ykYvdqVN3nC1r0jjteHrEGVLAu0WTKYyaEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1QKzixeOLnewbSyqxqiNEJzcAGbx6RMkw1rkM0MqnVJ2M7IR4s/l3DFJpfWrFKgrkbwAQl78Ji2m0rjh6ZbkzWsx6dY5EFrtsT/SIBbyzN7t8OYTkFZ5ut/0Lm4YTeChMYThmaVseGNxD6Xq1LsnwNln8Fp4dMwtk0LptIvlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llC9YKUV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b77683cc5bso697182f8f.1;
        Fri, 25 Jul 2025 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753469750; x=1754074550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6Ec72tuRm28hfX3b3V4ZYH9lERx8Ab7Dflx+a0SQYA=;
        b=llC9YKUVJMB+fQYgkl8ZlfwuB8zgySfu8k+GxJPLNv9rXwIs07J6Ch6p0e1V1/09zs
         lrIa36YUlIbcz+HH0D7/KwnO8SQo7Z4sjpb1YC9G9UoafcnFN84GtcDOpOvTmxHT4LDL
         qpuSFSQgEpdIvLGFERXguJa15ZyS5En+QJSsXClnosc/Axi11RK+1v96kmITaAzeJ/87
         4iG4NOKJhb942I8V1eSDVSBirk71FthoynV4JHCBk/VemAjDwSR8j1N6TcV4KL/4Y9A6
         FZ5mR+oJk9k5KF7LoS6t2sTPqLDZZOZesxDH8Q5qr6VNCZGMQ+4969LVzhj73vmVt5br
         3BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469750; x=1754074550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6Ec72tuRm28hfX3b3V4ZYH9lERx8Ab7Dflx+a0SQYA=;
        b=Ktv66Li0RxgxRItOjDrW1kjvQ8Tghxi8zToHtWh3l8ukQ2CdT1fnsEeSvVnGClHkoN
         eomJmHKFuwsb/XnZQhk5UNTw7q8qJlVLsqPscnByaxEExu2wAvtubFtW8uywrSEm2O8L
         SPmYHwtbJAVs5FWGhBiQegUHFOEoWQT7NHFupTaH7PXSdwL5P8727azeNr/En4lHSylV
         Vgcai6ekQ/rG9ayz6ObZTmGLyxj6O6fonvH1hjlVTO4l/+A6L9L5OvKVjrzs189dWQvE
         RGjNb9gAA3gYdu3FHR3K3hi/g9qOoLq0GzgiT727OA2B2N9yjSs6SrQl/nh1fYB0oHAV
         egiA==
X-Forwarded-Encrypted: i=1; AJvYcCUWULHEU3sKLamtk59F4whFLo0PLyKKOh3p3511PwvNg/hOeAPCLYaO3AW59GS7v4+I8G0=@vger.kernel.org, AJvYcCUq8osLZ6o0Uw+0p0WIuUTj1P4laFmyBMTYsGWew6lADVAQaJF4oBoXGPOYnyQPpIg7xT8lBbqD5sRSboOwxbRx@vger.kernel.org, AJvYcCV0hjgCMWhqlz38jfxHH3hne+p2WmyIw3n6N3jkJBaCb5RnlCEyXKydBe3stFjso8/+EVzz4Dj2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfz58V6Oy9VxZkS+gAK+7P4bQhWML+2Tg3C71AzEGJCaGlUGtC
	P0GOz2xXKU61n5TifVagxFItuKTNT8fCQFtcvgDthZQaEMR/ZP19akkP
X-Gm-Gg: ASbGncut1//Sd1NWMeVM26/p6qvAfiGwrZowFdIIYhJPRfbvIUmalUHL3sSZAzxmJPN
	MciM+a/DTBRgSEqcF0ALguE43ob2ORweYpCLoiz6KxxVtuub9hProOBZUgtzrJnBQo113G40E7x
	hyWad7qHMpy++PgX6WgkJQpcveQF5nc/YP7U9FWYFcxsdP/ZwB4l0WQFMsN1GPP8ERGRDLaUowt
	KQDXuxrbqbCCEzGf8GVGy3OukT5Opdv6GjfJbBHFwRHbO5F1SqYB2Va3zyy/lcCVNer5Bij1rT7
	wfDcLH/U5SoUDxM+OTYDJHnd/9NDnc58y1ADTcQjTIX8aSmNQWTtAyJArye7h1LuXYOwQ13k5fF
	C19XJUpIUEHiCrsQA+FtUXLboj/qO8TY40BngIV/kNLCgsgXY+cK8OYILgUM=
X-Google-Smtp-Source: AGHT+IH9Vr5XeG16SwfaWvGa1j0Q2CYXCzfhRDMkUCEO9vK5rLjkdz6xI8kW6v5V6DKH2BcOzI/vJw==
X-Received: by 2002:a05:6000:1448:b0:3b5:e714:9c1e with SMTP id ffacd0b85a97d-3b7765e5d89mr2348673f8f.12.1753469750144;
        Fri, 25 Jul 2025 11:55:50 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b778eb276esm607743f8f.6.2025.07.25.11.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:55:49 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	mahe.tardy@gmail.com,
	martin.lau@linux.dev,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH bpf-next v2 3/4] bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
Date: Fri, 25 Jul 2025 18:53:41 +0000
Message-Id: <20250725185342.262067-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725185342.262067-1-mahe.tardy@gmail.com>
References: <CAADnVQKq_-=N7eJoup6AqFngoocT+D02NF0md_3mi2Vcrw09nQ@mail.gmail.com>
 <20250725185342.262067-1-mahe.tardy@gmail.com>
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
 net/core/filter.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7a72f766aacf..ff7b2b175425 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -85,6 +85,8 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmp.h>
+#include <net/icmp.h>

 #include "dev.h"

@@ -12148,6 +12150,53 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
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
+	return SK_DROP;
+}
+
 __bpf_kfunc_end_defs();

 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12185,6 +12234,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send_unreach)
+BTF_ID_FLAGS(func, bpf_icmp_send_unreach, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send_unreach)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12210,6 +12263,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
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
@@ -12229,6 +12287,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send_unreach);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
--
2.34.1


