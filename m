Return-Path: <bpf+bounces-14033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB027DFCC9
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 23:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF4C1C21052
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 22:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57CA22F16;
	Thu,  2 Nov 2023 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22l0g9aA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25B225CC
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 22:58:53 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9330018E
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 15:58:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso1820691276.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965932; x=1699570732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cchCkg2hcFOX1ZtG27UCGvSuVnk6LdagSTMBDQs0CwQ=;
        b=22l0g9aAN7x9h7sy9Fd1R+xCasJ7Q7ooziP0A4fuG0zYmMyh/lOnHI/i7SpYLfdYkV
         aZUAxnunix6Tjy6jSf1zwMSvG9XP+SjNzTtcK3fyeTZFpAW7VFEJ3eKxNVj7LB+y3uGH
         gnptSoN3ETRq8jNFWnBVjUKtD4e6IgkWMV2Au8e3dtGcxaww+Qk9bXbrzXw3Rv1mbeLF
         opn+w0TcnTb1bBUQAIJhhqryFmM5iVEGaY+/vfgc78z7kn+9Xk3msWr7ScnkxXetfg6K
         sJhDaAgJbuvjeZGAUTBOswmVoHEcc7NJydFm6zuu0lD3oaSjN7p/hoasOoTDwbK3ao5O
         +Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965932; x=1699570732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cchCkg2hcFOX1ZtG27UCGvSuVnk6LdagSTMBDQs0CwQ=;
        b=tGzgZpgDoDuY1D3a5sWcWRSEYwFgvkkYHo/yaxaIG7pYovA460SVaxXg3zcxrKrJz9
         UBJ0k4+ApoO8Sx+g6Px3SSZCiDuV8mSPj7cxUkBk8vLU5i7vMojL9hPSvXrZ1OsRGrrW
         hob7HOdzt8BhcTCb+MNVhyFulTvhJFyq133LcVMVsmU1h/ZmyJCqiQSMx8itTmYomLXF
         JBinzUHRFOdVK9kcY+jdC9HIBuGhY0AF5u0zKmp74o09fMgsEpKi3H5kV9Yyun5G1RYY
         Bc0GiHPvalKfvWRGBYxOZTbnu/3bnGiCzk5UdWeBWdkD3um+xlkIlDJeyyKrtnTFIWX6
         GTEQ==
X-Gm-Message-State: AOJu0YztsFtv0t7szHTsXHm5F5II0y89BhPH232OHwgfyzpMYideEzlj
	pu0c8cYIYVklI27GJFD+ELEIFwuyd4xXmkFuJ9/1qt537udNXcvSGO7Kd65rs0EIWzPeIbXtiF4
	i3F85BM/75nDG9lhISkgAPO7TzKr3eDUkyY+Hvg3FX0Fc7vW2Lg==
X-Google-Smtp-Source: AGHT+IHj4JA6kBeIWI5vfIKduxpsOKCkJQxZJFhMF509ST6fAhXbSHC2dh+QTfMr/1MT9xvQhw/RoiI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:9392:0:b0:da0:cbe9:6bac with SMTP id
 a18-20020a259392000000b00da0cbe96bacmr401471ybm.11.1698965931578; Thu, 02 Nov
 2023 15:58:51 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:31 -0700
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-8-sdf@google.com>
Subject: [PATCH bpf-next v5 07/13] xsk: Validate xsk_tx_metadata flags
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
index e2558ac3e195..5885176ea01e 100644
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
+	return !(meta->request.flags & ~XDP_TXMD_FLAGS_VALID);
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
index 84fd10201f2a..0e81ae6bfff4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -728,6 +728,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			}
 
 			meta = buffer - xs->pool->tx_metadata_len;
+			if (unlikely(!xsk_buff_valid_tx_metadata(meta))) {
+				err = -EINVAL;
+				goto free_err;
+			}
 
 			if (meta->request.flags & XDP_TXMD_FLAGS_CHECKSUM) {
 				if (unlikely(meta->request.csum_start +
-- 
2.42.0.869.gea05f2083d-goog


