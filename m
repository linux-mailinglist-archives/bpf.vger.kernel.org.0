Return-Path: <bpf+bounces-73153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D7C2478D
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 11:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC26A4E0F4E
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006033E37C;
	Fri, 31 Oct 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfl4OOWI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CB335570
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906819; cv=none; b=p2GHE/ZoMuNjtes9R7KWuv7yzsP0mnpfw4nV6BVamghCnDxCHriF0ajZAf7QVhcTDpwK6bZqmD73X3I64qBk1OiJVJcMme3Pxgg+ALnWrXmvVlgPZiKlJqiBFFQKEgLsEaWYR8OVx8Y7C6bpeHJeEVqsgUW1448AnhkiQjYSna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906819; c=relaxed/simple;
	bh=NqfgEExTDyu4ekyUV14Bk1tqKYqDa3c4eTax0NuMVKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sxHnAanE7Ht7WXxIfOLiH+RgKe+dyPeqmgqzuv7ovm43ekd6LsT0Ik3ICOuVAY0Jp/iQu9CHroeRtYq2A7N2u/OPJ0SiyDgD+9D/Mfaby7/pNaXkdeSNtjp3rL2uEJPDDvLOwQH85ammgJA5ZL78NAckTMDoqec/3MEng3dW73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfl4OOWI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so2132021b3a.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761906817; x=1762511617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDafDPUtFXrtAlT9VtBP4rWIbi0j9HAnmrWp0z/kAxs=;
        b=lfl4OOWI7STOeS28Tzbc1CfVhN8q+QU+1/C1bnTPBoCVy7CR9ZR7JCLavPr0ya+iEc
         y2ssDhNVU4204IoZc8p+JaaytJtbml0eodaICoqWLbhda/8wohMAZ5ptjoylg7QY6Sxc
         ACyoY2oHOok72r3UGvEJcI2GQbuXk2ksTwPj8iDGUnMBesRbNNXGz6Ajat/TFGXxBg4n
         3kouiJZATmlruaPxb1fR9Y2P8QmFGwGFc0WNbpVd56G1rN324NPzNgcuizH+km+oIJav
         iDlBMu0hgEyafO65ScGJeEEAtOLOGdgN9xBBREoJEg7KC+Nl6gKMupFtq94LhVapYorb
         3f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906817; x=1762511617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDafDPUtFXrtAlT9VtBP4rWIbi0j9HAnmrWp0z/kAxs=;
        b=rdL1s3kfFPMfn/awlZTfR17dI4U/kmJRnoq+JVXBbAEcBOibNyMFNSsuDdT4MVorkn
         hUMYB3oZ9if8TthnUVKJmPVo8qkDhJKm/7AA4ngVBui7EKV9JbW32CBU2QqNkIwqATvF
         DM+Jjq+oUOH3DqBBQEOTGiUZEe25+WChJYmS8DYM4vNzm2QCRR+lOhEcLk0wp3o0r75N
         cdT+xlsZlwbhUeqfERdZrT7RbC/Vkd97A74S9cSiEUL2tVeKBjnxiLegIfXFwEQgo+TI
         9a0FzDVYMxJ64LjCGer9aKh+QeNvOG8IlIYgbn40QpCfR1YiwmMdaIdWSYMHbD7jeR9a
         zgAw==
X-Gm-Message-State: AOJu0YzRLB+64HLV2n6tSbuMQguYDs0xnafl1eklnI8zC9EVbk82MGo9
	mxXifj8OewyrOVSkzFAMPIyY2HiiUSfW5Gm/T2azouJuwxQmZv3S/uoP
X-Gm-Gg: ASbGncvWTWVPcO3QapHRbMVJx8qu9IqVv999RA+hz57BOwZInDsATjgbgM+6/YEWbtk
	p+J0BmB9u3oLpbEM59jHtkmqi1r/6fUVp2dpDekwPOCwTNLuRa9crTw47AzAnhcbIg+O/yflnyT
	FP3XvDu0Yf1HR5OyVTVKOrjiPR8U3Vfs4hLjnOlPV2g4+5auuLVVwxz5gV9nnbazrNMMrRULc9j
	XzgGqzOUEiDNWkm6/BB2f2qA6VXCwwwkaEXHJbjEWUrNaBjEQsx3gO6mSsIu5nzquPwVTdnxZ8e
	OVPXFvILc/lw2xhXYoZcE0LFFnCAKvPBso8B1gioE6hWaz3e3ZEdDB7SuaCkKyRwXi/nV5rKDJ4
	HFe4fF14Y2hwcfHQcW/Bt4yMkw0UoaO/VhpTBnZB5K0eqPiCSNXlCIPLA00hpFVg9sal6wOmGNU
	ugWDvyzay7GyAq/YLQWfr3NRbU+nzNu8mLzpjsbfNH1jFmwlNjIOc+0tXPtErfVw==
X-Google-Smtp-Source: AGHT+IHM+XH6eYdXCIOjYkytbzv5MHIYUe/eXJH+/42z00FS0SYBENmMb3ab4XvaXsNiLMYWd7icvg==
X-Received: by 2002:a05:6a00:951a:b0:781:171c:54cf with SMTP id d2e1a72fcca58-7a777760e07mr3641417b3a.1.1761906816801;
        Fri, 31 Oct 2025 03:33:36 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db678f67sm1701530b3a.57.2025.10.31.03.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:33:36 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net-next v3] xsk: add indirect call for xsk_destruct_skb
Date: Fri, 31 Oct 2025 18:33:28 +0800
Message-Id: <20251031103328.95468-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since Eric proposed an idea about adding indirect call wrappers for
UDP and managed to see a huge improvement[1], the same situation can
also be applied in xsk scenario.

This patch adds an indirect call for xsk and helps current copy mode
improve the performance by around 1% stably which was observed with
IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
will be magnified. I applied this patch on top of batch xmit series[2],
and was able to see <5% improvement from our internal application
which is a little bit unstable though.

Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
be when the mitigation config is off.

Be aware of the freeing path that can be very hot since the frequency
can reach around 2,000,000 times per second with the xdpsock test.

[1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@google.com/
[2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
Link: https://lore.kernel.org/all/20251026145824.81675-1-kerneljasonxing@gmail.com/
1. revise the commit message (Paolo)

v2
Link: https://lore.kernel.org/all/20251023085843.25619-1-kerneljasonxing@gmail.com/
1. use INDIRECT helpers (Alexander)
---
 include/net/xdp_sock.h | 7 +++++++
 net/core/skbuff.c      | 8 +++++---
 net/xdp/xsk.c          | 3 ++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..23e8861e8b25 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -125,6 +125,7 @@ struct xsk_tx_metadata_ops {
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
 void __xsk_map_flush(struct list_head *flush_list);
+INDIRECT_CALLABLE_DECLARE(void xsk_destruct_skb(struct sk_buff *));
 
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
@@ -218,6 +219,12 @@ static inline void __xsk_map_flush(struct list_head *flush_list)
 {
 }
 
+#ifdef CONFIG_MITIGATION_RETPOLINE
+static inline void xsk_destruct_skb(struct sk_buff *skb)
+{
+}
+#endif
+
 static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 					    struct xsk_tx_metadata_compl *compl)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5b4bc8b1c7d5..00ea38248bd6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -81,6 +81,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <net/xdp_sock.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -1140,12 +1141,13 @@ void skb_release_head_state(struct sk_buff *skb)
 	if (skb->destructor) {
 		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
 #ifdef CONFIG_INET
-		INDIRECT_CALL_3(skb->destructor,
+		INDIRECT_CALL_4(skb->destructor,
 				tcp_wfree, __sock_wfree, sock_wfree,
+				xsk_destruct_skb,
 				skb);
 #else
-		INDIRECT_CALL_1(skb->destructor,
-				sock_wfree,
+		INDIRECT_CALL_2(skb->destructor,
+				sock_wfree, xsk_destruct_skb,
 				skb);
 
 #endif
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..9451b090db16 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -605,7 +605,8 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
 	return XSKCB(skb)->num_descs;
 }
 
-static void xsk_destruct_skb(struct sk_buff *skb)
+INDIRECT_CALLABLE_SCOPE
+void xsk_destruct_skb(struct sk_buff *skb)
 {
 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
 
-- 
2.41.3


