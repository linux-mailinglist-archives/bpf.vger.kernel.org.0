Return-Path: <bpf+bounces-6449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E408B769966
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB671C20C06
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DCF18C18;
	Mon, 31 Jul 2023 14:21:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90918C09
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 14:21:17 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B1CB3
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:21:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686efa1804eso3199815b3a.3
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690813275; x=1691418075;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qb+UofH4ZA/Hg1FUv3Yuc6s26yCrwMyhAhKosqSojLk=;
        b=WvCsNQPQREb73SeTsy2U2ZlQcxu1scD9kyl4jVXsK6jv/gvy2cQbhLD9OQdE3j9ki6
         eykuUopj+NmnO4CwYA9nnAHcxctxzxRoxqHbstNAuj1CztcwB3vXnvUAC/wZSE7Q3A2J
         dDv6RYBbETldlTKLwlGkVG1og6Eqe265Wsqks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690813275; x=1691418075;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qb+UofH4ZA/Hg1FUv3Yuc6s26yCrwMyhAhKosqSojLk=;
        b=k/nKxdPFDcaxbcpGIbK/Lmnh1VkBH4H2Z5z4vhXUKCwoSx6BuSB5CEPQ6W5EJDqMkl
         QHglrx6xK03YH6/QZ7zH6BimXzB7imk/1RyB/POzectvJlhYCYUNADr7SGI0wn2dqBZp
         BPhH3hTwHuTo7ubwsvKlG1djCI1o8Q/FSIuW+o7EwwKYAVUrHz51oTgznv4jZLn2H7B/
         LBvG0nudCwJ5yKP9do+RAFBWE6UJ7bIbHwoo2hwKWDFmTFDRJDFfYM1/KaTTVQIukrv+
         J1F7U4gFtc/RisOzQURzX+HKj41kTKlBnKx71Hs35PCsA+jGh6NGIooKaeGzNJJeZZC5
         WlvQ==
X-Gm-Message-State: ABy/qLZwBuDFNZHGPit8QL72cmOXITxNuyyz7AIfttx62YJVHebpSBVU
	XGS+Z/kkOYJXd/BY8k0cEPYunQ==
X-Google-Smtp-Source: APBJJlG16Wo/MGvRwPgSvHy+/AwOjJxcpigjRG4GcdDpDJ1lOW0Ob45vuH+pR1d3+TUMCHcEVwc6Rg==
X-Received: by 2002:a05:6a00:240a:b0:682:b6c8:2eb with SMTP id z10-20020a056a00240a00b00682b6c802ebmr11184039pfh.1.1690813274749;
        Mon, 31 Jul 2023 07:21:14 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k12-20020aa790cc000000b00682c1db7551sm5509924pfk.49.2023.07.31.07.21.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2023 07:21:13 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	bpf@vger.kernel.org,
	somnath.kotur@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net 1/2] bnxt_en: Fix page pool logic for page size >= 64K
Date: Mon, 31 Jul 2023 07:20:42 -0700
Message-Id: <20230731142043.58855-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230731142043.58855-1-michael.chan@broadcom.com>
References: <20230731142043.58855-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000aef4760601c92407"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000aef4760601c92407
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

The RXBD length field on all bnxt chips is 16-bit and so we cannot
support a full page when the native page size is 64K or greater.
The non-XDP (non page pool) code path has logic to handle this but
the XDP page pool code path does not handle this.  Add the missing
logic to use page_pool_dev_alloc_frag() to allocate 32K chunks if
the page size is 64K or greater.

Fixes: 9f4b28301ce6 ("bnxt: XDP multibuffer enablement")
Link: https://lore.kernel.org/netdev/20230728231829.235716-2-michael.chan@broadcom.com/
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2:
- Resubmit to net since it is a bug fix
- Fix some lines > 80 characters
- Fix reverse xmas tree style
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 42 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  6 +--
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e5b54e6025be..13662b114f90 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -697,17 +697,24 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 					 struct bnxt_rx_ring_info *rxr,
+					 unsigned int *offset,
 					 gfp_t gfp)
 {
 	struct device *dev = &bp->pdev->dev;
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rxr->page_pool);
+	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
+		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
+						BNXT_RX_PAGE_SIZE);
+	} else {
+		page = page_pool_dev_alloc_pages(rxr->page_pool);
+		*offset = 0;
+	}
 	if (!page)
 		return NULL;
 
-	*mapping = dma_map_page_attrs(dev, page, 0, PAGE_SIZE, bp->rx_dir,
-				      DMA_ATTR_WEAK_ORDERING);
+	*mapping = dma_map_page_attrs(dev, page, *offset, BNXT_RX_PAGE_SIZE,
+				      bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
 	if (dma_mapping_error(dev, *mapping)) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -747,15 +754,16 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	dma_addr_t mapping;
 
 	if (BNXT_RX_PAGE_MODE(bp)) {
+		unsigned int offset;
 		struct page *page =
-			__bnxt_alloc_rx_page(bp, &mapping, rxr, gfp);
+			__bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
 
 		if (!page)
 			return -ENOMEM;
 
 		mapping += bp->rx_dma_offset;
 		rx_buf->data = page;
-		rx_buf->data_ptr = page_address(page) + bp->rx_offset;
+		rx_buf->data_ptr = page_address(page) + offset + bp->rx_offset;
 	} else {
 		u8 *data = __bnxt_alloc_rx_frag(bp, &mapping, gfp);
 
@@ -815,7 +823,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	unsigned int offset = 0;
 
 	if (BNXT_RX_PAGE_MODE(bp)) {
-		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, gfp);
+		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
 
 		if (!page)
 			return -ENOMEM;
@@ -962,15 +970,15 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
-			     DMA_ATTR_WEAK_ORDERING);
-	skb = build_skb(page_address(page), PAGE_SIZE);
+	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+			     bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
+	skb = build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
 	}
 	skb_mark_for_recycle(skb);
-	skb_reserve(skb, bp->rx_dma_offset);
+	skb_reserve(skb, bp->rx_offset);
 	__skb_put(skb, len);
 
 	return skb;
@@ -996,8 +1004,8 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
-			     DMA_ATTR_WEAK_ORDERING);
+	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+			     bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
 
 	if (unlikely(!payload))
 		payload = eth_get_headlen(bp->dev, data_ptr, len);
@@ -1010,7 +1018,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb_mark_for_recycle(skb);
 	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, PAGE_SIZE);
+	skb_add_rx_frag(skb, 0, page, off, len, BNXT_RX_PAGE_SIZE);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1141,7 +1149,7 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 
 	skb->data_len += total_frag_len;
 	skb->len += total_frag_len;
-	skb->truesize += PAGE_SIZE * agg_bufs;
+	skb->truesize += BNXT_RX_PAGE_SIZE * agg_bufs;
 	return skb;
 }
 
@@ -2943,8 +2951,8 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		rx_buf->data = NULL;
 		if (BNXT_RX_PAGE_MODE(bp)) {
 			mapping -= bp->rx_dma_offset;
-			dma_unmap_page_attrs(&pdev->dev, mapping, PAGE_SIZE,
-					     bp->rx_dir,
+			dma_unmap_page_attrs(&pdev->dev, mapping,
+					     BNXT_RX_PAGE_SIZE, bp->rx_dir,
 					     DMA_ATTR_WEAK_ORDERING);
 			page_pool_recycle_direct(rxr->page_pool, data);
 		} else {
@@ -3213,6 +3221,8 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.napi = &rxr->bnapi->napi;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = DMA_BIDIRECTIONAL;
+	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE)
+		pp.flags |= PP_FLAG_PAGE_FRAG;
 
 	rxr->page_pool = page_pool_create(&pp);
 	if (IS_ERR(rxr->page_pool)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 4efa5fe6972b..902b36a99b2e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -180,8 +180,8 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			u16 cons, u8 *data_ptr, unsigned int len,
 			struct xdp_buff *xdp)
 {
+	u32 buflen = BNXT_RX_PAGE_SIZE;
 	struct bnxt_sw_rx_bd *rx_buf;
-	u32 buflen = PAGE_SIZE;
 	struct pci_dev *pdev;
 	dma_addr_t mapping;
 	u32 offset;
@@ -297,7 +297,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		rx_buf = &rxr->rx_buf_ring[cons];
 		mapping = rx_buf->mapping - bp->rx_dma_offset;
 		dma_unmap_page_attrs(&pdev->dev, mapping,
-				     PAGE_SIZE, bp->rx_dir,
+				     BNXT_RX_PAGE_SIZE, bp->rx_dir,
 				     DMA_ATTR_WEAK_ORDERING);
 
 		/* if we are unable to allocate a new buffer, abort and reuse */
@@ -480,7 +480,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 	}
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
-				   PAGE_SIZE * sinfo->nr_frags,
+				   BNXT_RX_PAGE_SIZE * sinfo->nr_frags,
 				   xdp_buff_is_frag_pfmemalloc(xdp));
 	return skb;
 }
-- 
2.30.1


--000000000000aef4760601c92407
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIE/J9nqg1L+xTJ+KU7oUWPXdnxNSOOT
A3G90dfcFrMaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcz
MTE0MjExNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQApBn9Yxi9HRtOQBUsfR4mhbUNW+RWrxn1yt1dLCmhI8sWZtCD9
AdMs9qeyzZY6QRBRFeayJgYqA5tInpRXck90tS/RofJdiIY+zOBlmMsUNN4mf/fi+nmM744TFukO
IQJAen+xSl67r8YuyafZPiXxAOERNxwkVzbAJXuAua7S23lfds10QnCocH9spHLMMAX7TvxGrI/M
sKh4ojtfh+Q5PkmZDB7zLEXulb3tKsRNFntParSbVwDD0t449wgL0DrbxQMxbKkYwS73IP+gd01C
/rDU+u8TFFL5gjz+PUnhKtTmiWUeznLMKPpiAb+8z2bjbSUAHYxKaz0F2WzPEMX3
--000000000000aef4760601c92407--

