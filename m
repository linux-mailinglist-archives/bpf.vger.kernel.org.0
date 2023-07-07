Return-Path: <bpf+bounces-4483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5374B72B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7DD1C2108E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1BA18019;
	Fri,  7 Jul 2023 19:30:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58917FEF
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 19:30:36 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE452D45
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 12:30:22 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-668728bb904so3592832b3a.2
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758222; x=1691350222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BGiqgbrDyKLhwoMHCwnPJoUQz2wNa2y6goRcd3J+cs=;
        b=yhEMjNagmmrLmOyJIXf+GcVs/r/FLDht6NRolf4Io140nmc1zROztzx7zC6soHLmur
         QttelemzHbtFZS5G4ZUAcAPJrij8o23uNOzqZIiwF5PgBmio2S9yDnQkt/vgT9mNr2/o
         RJXkN1+K4nPSh14wkBaXxorFzvG7PYBJ/4kn8cHBUKz9Y359oKKCAodqg9iJDPHqIasc
         dDjo39FWkFej4GN9Q5YuGs03IGD2oflAHB2TaWVy/iKxhVn5uW0cCie0ly+nkJbEohGp
         ZEvGH8Rn2cpIS3mzniLZFDN5mV0ApFOm8GA+8B1fX0XL9WeHQna5yBUAMSYoK8Z14mTr
         mr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758222; x=1691350222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BGiqgbrDyKLhwoMHCwnPJoUQz2wNa2y6goRcd3J+cs=;
        b=j4jxZjsJt5+1AqtPXZKBzM7y9KVeaOsAcv5AcOFDvN0NH4+FtzBrOIpeXYK6iJ/qd2
         6CxHMca3gw5UNz603gcitrjZ+5SmY/V6VkpCByJV6xjszeDGEuZsKiSmNtsjtXdVKCLD
         oVRu/58AHtzGRBEYc8ks7dMAssR+4HpvdMfUtXwV8CRtVfaFZubgNfC7CVtlCnOGkO/L
         IgZnakAwflsYt7L3vmY6lvKs2XbWTTy10zMoGNirE8lF37uQaI5uQ9gYj7Cg1avZUfY2
         odoVyTxEdIuTBqCRwv6SvganVfK5lQ6giEJYosASd0CdGv9Slbu7b41pLgEDj4aIAbEA
         h5eg==
X-Gm-Message-State: ABy/qLauAeSkw26tdxShXhIed/3yRT/93Qa+2whwW6ec9yhpytUrBC2R
	0S1psuZqbZptT9Xm1U9ZpGawOXyg5FE0vDgPlMZwJ6KdvXDBM9iUpbvCWcMgWuQb6B0SDMe+tzr
	JfdQrM6kjlI8TMg78Uyt43Dskznv+u+maXdr7k+Ak27xlVfh57Q==
X-Google-Smtp-Source: APBJJlE1V2C1sYD7EMBUp/7vClIOTGCd6NsbSDTFDjXHYOlh+hp5b0zqxGQgzgcVakjTeyFl2UQG+e0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:b51:b0:66e:4df5:6c15 with SMTP id
 p17-20020a056a000b5100b0066e4df56c15mr8488242pfo.4.1688758222376; Fri, 07 Jul
 2023 12:30:22 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:30:00 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-9-sdf@google.com>
Subject: [RFC bpf-next v3 08/14] net: veth: Implement devtx tx checksum
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement tx checksum kfunc for veth by checksumming the packet
in software (since there is nothing to offload). The change mostly
exists to make it possible to have software-based selftest.

Probably should instead set csum_start/csum_offset on the skb
itself?

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/veth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 5af4b15e107c..6f97511a545b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1814,6 +1814,34 @@ static int veth_devtx_tx_timestamp(const struct devtx_ctx *_ctx, u64 *timestamp)
 	return 0;
 }
 
+static int veth_devtx_request_l4_csum(const struct devtx_ctx *_ctx,
+				      u16 csum_start, u16 csum_offset)
+{
+	struct veth_devtx_ctx *ctx = (struct veth_devtx_ctx *)_ctx;
+	struct sk_buff *skb = ctx->skb;
+	__wsum csum;
+	int ret;
+
+	if (!skb)
+		return -EINVAL;
+
+	if (skb_transport_header_was_set(skb))
+		return -EINVAL;
+
+	if (csum_start >= skb->len)
+		return -EINVAL;
+
+	ret = skb_ensure_writable(skb, csum_offset + sizeof(__sum16));
+	if (ret)
+		return ret;
+
+	csum = csum_partial(skb->data + csum_start, skb->len - csum_start, 0);
+	*(__sum16 *)(skb->data + csum_offset) = csum_fold(csum) ?: CSUM_MANGLED_0;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1840,6 +1868,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_request_tx_timestamp	= veth_devtx_request_tx_timestamp,
 	.xmo_tx_timestamp		= veth_devtx_tx_timestamp,
+	.xmo_request_l4_checksum	= veth_devtx_request_l4_csum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.41.0.255.g8b1d071c50-goog


