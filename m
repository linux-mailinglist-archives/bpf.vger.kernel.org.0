Return-Path: <bpf+bounces-66389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30CAB3425E
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 15:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D022A1AEB
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76732276058;
	Mon, 25 Aug 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw+aermE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DF2C031E;
	Mon, 25 Aug 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130055; cv=none; b=b3lx97taMnLZLrsCwkpf9x8n7+omuh4sG4uLhimdEgAZWEt16Ib01bwKkFykn0nL21OqizOIgeKOTzE5upZMFhYAHLDTzfoGNY9YGJg6AWyFVylgU5qXIbSLxQQKO5i9YE6xmZPmWkSiQ5sYoLJwDwPnmSpGhxUZ1XokgCw3D5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130055; c=relaxed/simple;
	bh=ZFhz+46NIOPD+wDGlBVZTQhDfXl96mFXOOn998cs0tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHenOVBsHatAEnYRjYP4w1L094a/Qsd2B92PMdWm03fGe9ETvZHKk56+0rruxEBaMgFFCbQGN1LHK6rruZSbZq7A+KzG4qXk7LC+0Zlm2TB5uv3qJH3TGz5HR6EwbDcuq4TRR2kwINjg2Y9iZvNrkt8cyS6mPLTQIIYNRsNUchM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw+aermE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7702fc617e9so2264177b3a.1;
        Mon, 25 Aug 2025 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130053; x=1756734853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p9ZvknKtsj3JPoP86U2i4X+o7O0iOXNaUFnYh0ovFY=;
        b=cw+aermEGD1+44Bp69yULTAKp7cAhg2ICI5kaHCuijhwPDMcACaqdvfM8OrqXlyaaf
         R75HkWy/FaqnpOQ9uiAB0rBfSnbPn38Wp7BwC6QKEMDBDa/7sTlRyN/IA/nBrN4oa8Mc
         5g7WWTToNY+R7PdN1DyGxDEGKk/7JR33yXNDO8GqCSR6mL+tQnLYgswZ8EG6YfIgj9bg
         725E4kYQ7AcH70bZqkjgWgQq9xO/JgokoeXl9Qrw/dSBjAyeJPszw29xZPpgTYC1X8om
         34all3z3GKwLItWyhk3BucmzRQZ26N5YxP7jUwqOX/3ZbaGfBQrRo5uNSfY7a3hg67Zr
         rx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130053; x=1756734853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p9ZvknKtsj3JPoP86U2i4X+o7O0iOXNaUFnYh0ovFY=;
        b=rrE3/XI0zPfNlaFPiUS4CDCdTMAthjk3j0ZHt7hHBDmV9PuCBEBUPLlxCAjiNYsyno
         +UT/AMgZvva6iDcoUXBkmA843jaCOzdRFf20gEY9O2v2+TYINR2toTByqENkaJ7qzzE0
         gZ04k9CEVT+crSamOKIcki7fLz2Lc48Pev13OgFAHEoUrwZUF6yUpobkYvyRSueMBwb4
         XbFzebZh6o+C75G26ibLYMwIBM8E5hR2CfA2iWjHp49MhguWHNQ7y5hAngLtJuZaLxqB
         L6tFfyOLxOCjULbhuBSdvm7jcFbKYAOVu3K48CWzp+ik3iCStCJEptKYbmBofayOrMIH
         if2A==
X-Forwarded-Encrypted: i=1; AJvYcCXvIPToXdQostbGYRvxkqoFEjHOz0rhGgtnZ8M19B3KSIHfn/n7xmKuzH1cuP6aw5dvkfjBx5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/oC+4cA7ImR38dQg6FusXFnJuckGztCP1uDcFIEBFuUzWn5/B
	YMQY1D0r8J1oU0BbbU7gXA20Le3eq+orkV/JJcyER2jCJtcs0Yl7BfdC
X-Gm-Gg: ASbGnctLx2n8AsY15HmRXPKY/mbD+tgIGNP37YuKhAy4TYOlySPoNcuN75JhAkCJQ4H
	Rd79zOuzKf9GoGtJoLSYZ8l1nu1jWrC4OJUCI1B8VOIVYHcPzAOR3644RQctVJ+MdAZMq1fGh9O
	hERIZtjvEsiEL7l107fhToOiN1Pn5Esa+yYuZiO2zSSehVz/I0RNTQXJmGjAlTgLrAi7h09L8Fc
	/7FS6Gddgfj7MsaOoWglmkyiscybCuOMM6kExKtqeFqpdAfFtR+mp8fPFg8Q/1+gu9Vq6ntR9xr
	59quYkFstD/wrCfEO+6QUrwJvBldi0GRVc9sZK9/uv5POJgULQN9yd1FXISpVqECQRXJwgB+xfI
	JHUSO8WqaJHW7ox/Dojv4i4pV59iwM+A+ZJRf8Lv67MFg6OZWM3b5nKoG3UU=
X-Google-Smtp-Source: AGHT+IGVPO2tgf9IH+k5PPH0X7bM8yO3LzuHk2R5MUxhwjYDrFVnVtLyVorwT9kptG7stjB3FVvoOA==
X-Received: by 2002:a05:6a20:3d8b:b0:231:bac6:7027 with SMTP id adf61e73a8af0-24340af116emr15770407637.11.1756130052677;
        Mon, 25 Aug 2025 06:54:12 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:12 -0700 (PDT)
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/9] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
Date: Mon, 25 Aug 2025 21:53:34 +0800
Message-Id: <20250825135342.53110-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a new socket option to provide an alternative to achieve a higher
overall throughput with the rest of series applied.

Init skb_cache and desc_batch when setting setsockopt with xs->mutex
protection.

skb_cache will be used to store newly allocated skb at one time in the
xmit path. desc_batch will be used to temporarily store descriptors of
pool.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 Documentation/networking/af_xdp.rst | 11 +++++++
 include/net/xdp_sock.h              |  3 ++
 include/uapi/linux/if_xdp.h         |  1 +
 net/xdp/xsk.c                       | 47 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/if_xdp.h   |  1 +
 5 files changed, 63 insertions(+)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 50d92084a49c..decb4da80db4 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -447,6 +447,17 @@ mode to allow application to tune the per-socket maximum iteration for
 better throughput and less frequency of send syscall.
 Allowed range is [32, xs->tx->nentries].
 
+XDP_GENERIC_XMIT_BATCH
+----------------------
+
+It provides an option that allows application to use batch xmit in the copy
+mode. Batch process tries to allocate a certain number skbs through bulk
+mechanism first and then send them out at one time, minimizing the number
+of grabbing/releasing a few locks (like cache lock and queue lock).
+it normally gains the overall performance improvement as observed by
+xdpsock benchmark, whereas it might increase the latency of per packet.
+The maximum value shouldn't be larger than xs->max_tx_budget.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..c2b05268b8ad 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -70,6 +70,7 @@ struct xdp_sock {
 	 * preventing other XSKs from being starved.
 	 */
 	u32 tx_budget_spent;
+	u32 generic_xmit_batch;
 
 	/* Statistics */
 	u64 rx_dropped;
@@ -89,6 +90,8 @@ struct xdp_sock {
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
 	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
+	struct sk_buff **skb_cache;
+	struct xdp_desc *desc_batch;
 };
 
 /*
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9c3acecc14b1..e75a6e2bab83 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1122,6 +1122,8 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	kfree(xs->skb_cache);
+	kvfree(xs->desc_batch);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1456,6 +1458,51 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		WRITE_ONCE(xs->max_tx_budget, budget);
 		return 0;
 	}
+	case XDP_GENERIC_XMIT_BATCH:
+	{
+		struct xdp_desc *descs;
+		struct sk_buff **skbs;
+		unsigned int batch;
+		int ret = 0;
+
+		if (optlen != sizeof(batch))
+			return -EINVAL;
+		if (copy_from_sockptr(&batch, optval, sizeof(batch)))
+			return -EFAULT;
+		if (batch > xs->max_tx_budget)
+			return -EACCES;
+
+		mutex_lock(&xs->mutex);
+		if (!batch) {
+			kfree(xs->skb_cache);
+			kvfree(xs->desc_batch);
+			xs->generic_xmit_batch = 0;
+			goto out;
+		}
+
+		skbs = kmalloc(batch * sizeof(struct sk_buff *), GFP_KERNEL);
+		if (!skbs) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		descs = kvcalloc(batch, sizeof(*xs->desc_batch), GFP_KERNEL);
+		if (!skbs) {
+			kfree(skbs);
+			ret = -ENOMEM;
+			goto out;
+		}
+		if (xs->skb_cache)
+			kfree(xs->skb_cache);
+		if (xs->desc_batch)
+			kvfree(xs->desc_batch);
+
+		xs->skb_cache = skbs;
+		xs->desc_batch = descs;
+		xs->generic_xmit_batch = batch;
+out:
+		mutex_unlock(&xs->mutex);
+		return ret;
+	}
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
-- 
2.41.3


