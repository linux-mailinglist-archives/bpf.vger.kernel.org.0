Return-Path: <bpf+bounces-15973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC37FA994
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83664B212D5
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C56E3FB32;
	Mon, 27 Nov 2023 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4PvLDmPl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FDED5D
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:34 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-28525981a55so4788969a91.1
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111814; x=1701716614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=99qVGEnNEQZ0Ub6NY42NFhmi4pNAJrO1wmYriAMOllE=;
        b=4PvLDmPlZoP9x2c6EE2CeEQ3xJyFqpq6tQvQHcwqsSu+B/DfaRPrOQBCug46/nuEWA
         MgUMsufYSklRmUVJ6D4Wj+vyYaipVEQUZA8ywZA/lpSq6hpyOCoUymPkGdimBYSayN1T
         ZcjaiSX00TcWVKDGfLaz3lU7uqtsYcN06/zrWp4G2XVdCkQrmmD3kdB6dM3qB95sNTK7
         9p05aAWOcIP59u6e6Wo0pjsQliIEt3huBacaL1fiSFNlAzlWmhR7xfUzplsp6z0Usuxp
         gvHgvfR8vxkp432D9lk3iuTVDiTuIFwDUuKi5CAUA6+Ke7hhAmtmvgXdxTmwtLDRhbm9
         AI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111814; x=1701716614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99qVGEnNEQZ0Ub6NY42NFhmi4pNAJrO1wmYriAMOllE=;
        b=McIzjU67B3NS2kGIWb0k+aL9DjIxbo7sYjzzhea23mp6hgxo/2m026eJ41IyKKi1bz
         9M9tz8WopfTmSJWzfEUPgDko0HqaCIxRetk5S+LaYARX7+olT3+2Mc7eNmGY46KSVZ47
         VHGsmyZ51kcKgPSu7/8y0L6FP1WiXakr9cEhH4+YE4WKs+hDcUTFASAv6cwHD44rz8zs
         rc0QJFH77EgP6fz3On/E90VaMqcu1h7+g2NC+r4fHOpOA8ZdcJMcQC+wUH76nn6DE/9G
         GteSKp/KTrjf9upGn5+5g/DpAZWHbWZzY5Gwn/VSvGy/Sruwbo+5ze0a3HMT8MgX/yiT
         jq4Q==
X-Gm-Message-State: AOJu0Yy64A0cwtKyQfwb2T4iIHSEWmDW7svS2yBicMjbqyynrMncpnaB
	191K5BstMp2x+yhtUjt0rW/WyPA3u3a6cevMTxBBGZCcMxIb4IWJ8/N/NX60JPIfQpMEMKrwxgC
	gX5plxKP7WMfUPl2qzw/LW3yhkEzv815EXmv1S8HNoe7wG7xHCw==
X-Google-Smtp-Source: AGHT+IF4LeF4F6ujUaxMms+ifKigtIl1GqgRBxF8gPMPkhkgaMo0syeBjyEJ09ROh5SanlMUaHBbGMU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:ee8d:b0:27d:2cf5:7eb1 with SMTP id
 i13-20020a17090aee8d00b0027d2cf57eb1mr2904712pjz.4.1701111814269; Mon, 27 Nov
 2023 11:03:34 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:13 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-8-sdf@google.com>
Subject: [PATCH bpf-next v6 07/13] xsk: Validate xsk_tx_metadata flags
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

Accept only the flags that the kernel knows about to make
sure we can extend this field in the future. Note that only
in XDP_COPY mode we propagate the error signal back to the user
(via sendmsg). For zerocopy mode we silently skip the metadata
for the descriptors that have wrong flags (since we process
the descriptors deep in the driver).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xdp_sock_drv.h | 23 ++++++++++++++++++++++-
 net/xdp/xsk.c              |  4 ++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index e2558ac3e195..81e02de3f453 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -165,12 +165,28 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 	return xp_raw_get_data(pool, addr);
 }
 
+#define XDP_TXMD_FLAGS_VALID ( \
+		XDP_TXMD_FLAGS_TIMESTAMP | \
+		XDP_TXMD_FLAGS_CHECKSUM | \
+	0)
+
+static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+{
+	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
+}
+
 static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
 {
+	struct xsk_tx_metadata *meta;
+
 	if (!pool->tx_metadata_len)
 		return NULL;
 
-	return xp_raw_get_data(pool, addr) - pool->tx_metadata_len;
+	meta = xp_raw_get_data(pool, addr) - pool->tx_metadata_len;
+	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+		return NULL; /* no way to signal the error to the user */
+
+	return meta;
 }
 
 static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
@@ -332,6 +348,11 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 	return NULL;
 }
 
+static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+{
+	return false;
+}
+
 static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
 {
 	return NULL;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e83ade32f1fd..d66ba9d6154f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -728,6 +728,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			}
 
 			meta = buffer - xs->pool->tx_metadata_len;
+			if (unlikely(!xsk_buff_valid_tx_metadata(meta))) {
+				err = -EINVAL;
+				goto free_err;
+			}
 
 			if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
 				if (unlikely(meta->request.csum_start +
-- 
2.43.0.rc1.413.gea7ed67945-goog


