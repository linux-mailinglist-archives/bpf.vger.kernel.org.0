Return-Path: <bpf+bounces-64494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34885B13834
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CAB3A9912
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919B266560;
	Mon, 28 Jul 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvbeOQYI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA93264625;
	Mon, 28 Jul 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695849; cv=none; b=Egoqe3V1c7tAzqihBy7JB27afOTgr7y/HzgIQ0OHUbARcDBJIzpoXi1pSmp5VozZuNu14Zs0U1POX0peXc3bJChIhtjnR14ak6l0YQp05opxRh0E6+JNgsW6deTHyVKar7ihSEhczYIqmmzPR7khavf1FnBv16HsSdR3T7QJWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695849; c=relaxed/simple;
	bh=8WV+cWhcfM9K9VU9HUEfZN7gptZm+lCmHHT/GLpr/Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G9mI5djumGYpEQTJrr52zVW4ZBJYugF15Y9DbAYLPSBfeaz4dd5lGYcsDjh00EzkMj+yOLkF8ZTLtlqeWRLVXD9JiABeAqNLkeNvDpTC0SBGBbQ0PVQYbm07ZzNLzxzLMwtyW6Mz/0k8gxTbHyWPTkjj5/nTxO0zBzNGxxuyQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvbeOQYI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a588da60dfso2138869f8f.1;
        Mon, 28 Jul 2025 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753695844; x=1754300644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFp2I4omjYRuFO7iuM5mH+nPGTxW4G7hOZbPaKnkEMg=;
        b=hvbeOQYIUMjLE5xATL1L/al5+gGkwC2UZ+1NA8ScReUzkSV1dMkemMsDicy8B+sylp
         0A2JOC/UCvNS1atBr5YyPPGaDib+NdH+VdrY9FuW+Ei67mCAr8tGyLVz/Gi6hapK9en8
         QKU0xhA+hOpawT8vWOCo1xEAursLqEM8n6sW6my2UZk+hWm3hdnBxGEOOjGKKCc0vnMj
         NgJGLh9jfcp4qfbfFfHUmn09B4DqKtLvtzBrHXcm1EVxKUoO53fdsiRvgddq9HJH8gkt
         Jfc+prdqSP+3e/+WrvvGy0yooT+McgBnyXWm1YuFTeurHKyrlBOQ5XqvYdq2cY3Jgtc5
         //+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695844; x=1754300644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFp2I4omjYRuFO7iuM5mH+nPGTxW4G7hOZbPaKnkEMg=;
        b=XvZCKA8cRHHwpLzpYh5NNwTR5OJvwAwZiFjtDn7cTlUF0bi1poOMcu7k2Bfyj2jEfl
         qJUWxiyBKajufW+KmCXOHKQbgRXmVIEa/Ot3fzzHMRTYXZl9Xli5VX1M7dgAm99XjoxF
         rUXLKzXW8+ZHoYj4hbCyjOGawgTptdI8QUuMZ/nLP3aZivQbbtSw3HXVC5MAkIlNu58X
         tfTNbuK7FOlOsBtc4kDQHNNfXmQ2QFIQkW6mW6EXJm2s78GzWSFMJodSwIMYGsXkK2bM
         wNhfZtGvRwlWiFNgLHzK5WakXjUFYC/OOM6EHDErZzghcXF2Z0Qi/i3S9C9+qLWh/gPQ
         j3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUMc13q9Kr2J2MFC+e+KGWBh2OPta36ChjlhMCncoY12BrALdGHwBtDZ/aQ674c/u1IO9I=@vger.kernel.org, AJvYcCWUe21kLDCTiEgQtK5wM0ctZ/sUTBMxlTPnwGZfhDgwqn0KDqBnOd2nOhF7NEwpcnCMFErDKWEzfc4oz+e3oWLS@vger.kernel.org, AJvYcCXAZhPDFtQS8xhBx93KFg1tDhSPim3Z1L6TIBguod2g69ABTSSJR6l+ByGOM/Vd/nf+UBXx48V5@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRFYfVqhpqtPxx4FpGeUqXiPg23T05I6K65/uPyhgeMCI0kPx
	Uw5dic1PX+/l4k4o00FFOEJRCR2syl4bjG9LUR1MQHRRzI2CdCX/u+CJ
X-Gm-Gg: ASbGncv4a/cq5hLBo1MQbJXxLQqLifPBC3IhufgQVVou0M4rkeqV6eW6Sp3HFdsCSaC
	0UQq6mp6vatJ4hPh51OEId0KjPUK2f58FJ0U+9BlU3iRCs7H/KveCcBgXZywHayhMKtbqnKs1G9
	Aj07iDOLWYcNa2fVHB5eWLa3Z9q22ttHuPced/66MGf64Iy6+NyJZLX5VeLVqZCIZF54beaxlVp
	6hyTPufCHo2v5/75lihZ0GAeufo8lopxkru3tXXixM6DheEe3oP/lzRFTK6WPT/U94t3He4iFFO
	woUitFscIqLEjjncxS+wl9ECZfNrCGOpB/Ounfq/5bP8JBuzHhugunWrpbwbMDk8N6O5wHklXBC
	yIKBzR16/oUDCyZ5bSpon1CzbaaOrf2wX3q8ALJ3hFEnNiS89
X-Google-Smtp-Source: AGHT+IEtfYZlLiEHEr689fId7m8sq3LHQPfHzZXeAGEPX5MzGQc1Xmo+EoG2SrcnCHk8UfuIAB651g==
X-Received: by 2002:a5d:588f:0:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3b7765ee46cmr7119141f8f.19.1753695844135;
        Mon, 28 Jul 2025 02:44:04 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705bcbfbsm153422725e9.16.2025.07.28.02.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:03 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: lkp@intel.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	mahe.tardy@gmail.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v3 3/4] bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
Date: Mon, 28 Jul 2025 09:43:44 +0000
Message-Id: <20250728094345.46132-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728094345.46132-1-mahe.tardy@gmail.com>
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
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
 net/core/filter.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7a72f766aacf..050872324575 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -85,6 +85,10 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmp.h>
+#include <net/icmp.h>
+#include <net/route.h>
+#include <net/ip6_route.h>

 #include "dev.h"

@@ -12148,6 +12152,53 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
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
@@ -12185,6 +12236,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send_unreach)
+BTF_ID_FLAGS(func, bpf_icmp_send_unreach, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send_unreach)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12210,6 +12265,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
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
@@ -12229,6 +12289,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send_unreach);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
--
2.34.1


