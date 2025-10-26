Return-Path: <bpf+bounces-72248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37826C0ABBA
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 674634E918C
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72DC2EDD76;
	Sun, 26 Oct 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNU4eAqs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B31DF99C
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490713; cv=none; b=XbcxWYD9p37znGv47R/BZQT/HfaoQJh8Yd9XSpQcc9H47rf7vGOlHX70MO3qhewGke8ibrKaPH3ECwjwn0SY98GYPVjzNVvx8lSlscVZYB6b9CKD3QH164z5f54sfljzRgKRPYYY1kPynH9FKbGCGmOxMY93bU0Vl710NDtuc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490713; c=relaxed/simple;
	bh=fOaXASGzPYRLKIKCaWs5h26msLXfDZajF2c1OqkACO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=stFHgdp6zj7bDT1VV/9NEr5zE+Iuni9uuGLUOR+TrVHgWEvtBdIYKUwR338P1ZKMcsCvrun14Fz0L1NMy6sxpIWxmocPjiq1mKA2eHleSD1uoUN5qU7D6Rvp6LahIkKy858Gj7nsVdFcftfxo9DaZlFKDbTpr14egGzjykRsLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNU4eAqs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78af743c232so3456258b3a.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761490711; x=1762095511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqIwpgJ07rQkvt2nZ5lIXE4EoBFW2x/X3HrdwhoU2mk=;
        b=QNU4eAqshzx/8v7LkCnZbb8cuP2rRZ0yd0Ivpo+cDZeg+J/2zTorH6imup/Mw3cUUY
         xHOf5FtLvxqqgedHn//OmEaE3uGYEOGCEIfN7FukFUeFEHSSTl87Ij/1KkBglnIbCcHW
         11gLk61P4XV7TBx7lHK9r3W2Mn6Sg4qqxveCvDhtE2Gwdxd5G6F1R1r3R4oURLnCDEPa
         mPT6hpYieX1XbgfrgbN8B29bOVg8NZ4FY08RZxhHc6MwDqtk7UFtr11q1gsPK75GFk7b
         bf+dnAeDCrN3/DoAV/obCJegljbIkfvuRSVnN4wc014eCW6KiziveTEfvjiYXJ5bGx65
         yABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761490711; x=1762095511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqIwpgJ07rQkvt2nZ5lIXE4EoBFW2x/X3HrdwhoU2mk=;
        b=lZnHLlo2hADNei5+WWYhF1qgEMU4VABckkja0sLZZIzWtk+PCE78C7s5LweiUYocgu
         mZ2oCtR1cPzFMYWtct8iMUWv3GqEmQ8sLypJI3d3ypo12B8tnOwyGz3OcXjYrzwI/zEC
         BYDME/Udn0ljtGxVoQKG/CPnUu7dbCiIdFB4eQu6m1qYqhJECPgPrdKzWDqSD8hw2oAo
         3Xo+sU33jWX+Pfaf/sy/87EoXBGPWlMrU6y/DM7EW0qpAASAQYXjKzwY1o2+jJLtSjD8
         iJbgUcrTn3dJV8MNttqd3DE7FUOKnyD4tSO8dJSxLp2jOEuuPsYXnLzcN91TldJgHG7+
         pbGw==
X-Gm-Message-State: AOJu0YwyfEdckly1/z7Uyz50PsmbsF+ws9TM0CnIEf/TtPaRGJuhbrcL
	plb+yBIMqIgi2g8QoC/sTr4NOyIKsaKEpiUyaCek7ejt9XMGTrPxs4G/
X-Gm-Gg: ASbGncv/R0tOsdJjxe2VWC8VgRljt7G7/U1Ieztckp3QhkwE7OvhV289xw3mjVp7Fa6
	lptnEVX3XwreiIOYaU1XIVJ1W85dMPtV7IMFAMDF4/kakx90vG+l2PNfNqBe+MJVfqx3uCZ5TnD
	vPZ/z7oKq95FMdySPnjd7hJCS5f7RUVAQeDQ46wi4hqG2eLyRbQzU7ULxLUOnAwmg/jPRRzyMcd
	VFldUcXPI4msXhBSPi2qRqiNpZ0GJ4jk0eFwVCl8zc9QIpfCHadjex4RFad50qI8YzHqdt/zfaW
	/ati2mn9mv1QZrJ8x1eW18PZb7WaBKdk2saVZaYcyhM7jpkR/4fkTLqxbqPnChbEjMFgrGTltfx
	mdP8htkjz1JI9VLqaqxnZ9WjKACds/ycxcOOLaSnD7Y6owqE8sc5xTJpc6FbELlHkvfIFR8Oeu/
	QbHuigsmIlswBFV7dn+FJb0q4Csb1f47ns9BbdUFnESa0R4Xal
X-Google-Smtp-Source: AGHT+IG8/iwduXCVBk4ZRhZXTaP9XnVd9i3l9BxjZI7IzYSp7wsypo59lJDx5LnVEsBzLeLrdk9BJg==
X-Received: by 2002:a05:6a20:914a:b0:341:4dc7:6ac7 with SMTP id adf61e73a8af0-3414dc76bf0mr5033243637.17.1761490711268;
        Sun, 26 Oct 2025 07:58:31 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a427684bddsm1956042b3a.31.2025.10.26.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:58:30 -0700 (PDT)
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
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
Date: Sun, 26 Oct 2025 22:58:24 +0800
Message-Id: <20251026145824.81675-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since Eric proposed an idea about adding indirect call for UDP and
managed to see a huge improvement[1], the same situation can also be
applied in xsk scenario.

This patch adds an indirect call for xsk and helps current copy mode
improve the performance by around 1% stably which was observed with
IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
will be magnified. I applied this patch on top of batch xmit series[2],
and was able to see <5% improvement from our internal application
which is a little bit unstable though.

Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
be when the mitigation config is off.

[1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@google.com/
[2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
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


