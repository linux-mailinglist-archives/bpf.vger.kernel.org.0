Return-Path: <bpf+bounces-8031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E0780195
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 01:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2907C1C21460
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 23:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFC51BF1E;
	Thu, 17 Aug 2023 23:19:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C81BEED
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 23:19:32 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA7E35AB
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 16:19:31 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6471744acb6so1378536d6.1
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 16:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692314370; x=1692919170;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UM56ydzu4TfXzkslBZgulgI4H2pjWf6VZCweuk0YZk=;
        b=GnAWeH9g1V+7B8MmUhFDFUTlqVH3IAh0/Nbu5C/t7q2lWMiI/Q0uVtaUqYhbvCm6qU
         Nj6gg2uxAUgPP1AgBCrVaO0JwQbMxqgypt642gv+KJDP498TqzL4aw8N8t005UugW3xf
         NOMWpKwa6olZhB6clslL70ZtrheUUqVjsBZ98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692314370; x=1692919170;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UM56ydzu4TfXzkslBZgulgI4H2pjWf6VZCweuk0YZk=;
        b=UxMliYJI2sYG/vsbuiJGJ1JQ7/Xs0Ouq3JyT4quhnUDOkmrUitVt5VHkM+fhZUtyvP
         +bR4hc6CPGx4oUgGwI68BiZQoex4CCWek2FpSwc7QvDBnLEjnEkDTUH5ViPWKlR7AwcX
         3mY/vsjyzXmyEcWJC6FmgcyvLJPnEk5eXC8d/5HvPdLmO8Jw6saRPjE6mRokquFcoRuT
         hHIg47Qv9qZlbIUlcUPsqcNX6XhsLPiEotmcbjqRJ8j9gWkXc4TmKwmt+mxJGtAFEl+5
         0HwwjkNcwu6VzTmPmvJvz0SVK9hKOt/y3aKyz4Lu5EGvQZA5mH1XmYObiKBEv3UlV9PL
         Z02g==
X-Gm-Message-State: AOJu0YxwVovpIQOt3LRdeOFd4QLvPZUJbuACQrKE0SgsvWkeEyt2cJMM
	OEcuone0O3cF1+3IqUgI8Tt/dg==
X-Google-Smtp-Source: AGHT+IGJ2CkOYVXn7l+Ev1IgGxDAZ0RGjA9TjpL3LvZoPCOmHifCz/snjpn4AgxwejGTwKJRG75J3g==
X-Received: by 2002:a0c:b25e:0:b0:63f:90b8:6a30 with SMTP id k30-20020a0cb25e000000b0063f90b86a30mr1163395qve.26.1692314370271;
        Thu, 17 Aug 2023 16:19:30 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a149b00b0076d25b11b62sm145516qkj.38.2023.08.17.16.19.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2023 16:19:29 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 1/6] bnxt_en: Use the unified RX page pool buffers for XDP and non-XDP
Date: Thu, 17 Aug 2023 16:19:06 -0700
Message-Id: <20230817231911.165035-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230817231911.165035-1-michael.chan@broadcom.com>
References: <20230817231911.165035-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ea8efa060326a4f5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000ea8efa060326a4f5
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Convert to use the page pool buffers for the aggregation ring when
running in non-XDP mode.  This simplifies the driver and we benefit
from the recycling of pages.  Adjust the page pool size to account
for the aggregation ring size.

Cc: bpf@vger.kernel.org
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 71 +++++------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 -
 2 files changed, 14 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7be917a8da48..6b815a2288e2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -877,48 +877,15 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	struct rx_bd *rxbd =
 		&rxr->rx_agg_desc_ring[RX_RING(prod)][RX_IDX(prod)];
 	struct bnxt_sw_rx_agg_bd *rx_agg_buf;
-	struct pci_dev *pdev = bp->pdev;
 	struct page *page;
 	dma_addr_t mapping;
 	u16 sw_prod = rxr->rx_sw_agg_prod;
 	unsigned int offset = 0;
 
-	if (BNXT_RX_PAGE_MODE(bp)) {
-		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
-
-		if (!page)
-			return -ENOMEM;
-
-	} else {
-		if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
-			page = rxr->rx_page;
-			if (!page) {
-				page = alloc_page(gfp);
-				if (!page)
-					return -ENOMEM;
-				rxr->rx_page = page;
-				rxr->rx_page_offset = 0;
-			}
-			offset = rxr->rx_page_offset;
-			rxr->rx_page_offset += BNXT_RX_PAGE_SIZE;
-			if (rxr->rx_page_offset == PAGE_SIZE)
-				rxr->rx_page = NULL;
-			else
-				get_page(page);
-		} else {
-			page = alloc_page(gfp);
-			if (!page)
-				return -ENOMEM;
-		}
+	page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
 
-		mapping = dma_map_page_attrs(&pdev->dev, page, offset,
-					     BNXT_RX_PAGE_SIZE, DMA_FROM_DEVICE,
-					     DMA_ATTR_WEAK_ORDERING);
-		if (dma_mapping_error(&pdev->dev, mapping)) {
-			__free_page(page);
-			return -EIO;
-		}
-	}
+	if (!page)
+		return -ENOMEM;
 
 	if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
 		sw_prod = bnxt_find_next_agg_idx(rxr, sw_prod);
@@ -1204,6 +1171,7 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
 					     agg_bufs, tpa, NULL);
 	if (!total_frag_len) {
+		skb_mark_for_recycle(skb);
 		dev_kfree_skb(skb);
 		return NULL;
 	}
@@ -1794,6 +1762,7 @@ static void bnxt_deliver_skb(struct bnxt *bp, struct bnxt_napi *bnapi,
 		return;
 	}
 	skb_record_rx_queue(skb, bnapi->index);
+	skb_mark_for_recycle(skb);
 	napi_gro_receive(&bnapi->napi, skb);
 }
 
@@ -3002,30 +2971,16 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		if (!page)
 			continue;
 
-		if (BNXT_RX_PAGE_MODE(bp)) {
-			dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
-					     BNXT_RX_PAGE_SIZE, bp->rx_dir,
-					     DMA_ATTR_WEAK_ORDERING);
-			rx_agg_buf->page = NULL;
-			__clear_bit(i, rxr->rx_agg_bmap);
-
-			page_pool_recycle_direct(rxr->page_pool, page);
-		} else {
-			dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
-					     BNXT_RX_PAGE_SIZE, DMA_FROM_DEVICE,
-					     DMA_ATTR_WEAK_ORDERING);
-			rx_agg_buf->page = NULL;
-			__clear_bit(i, rxr->rx_agg_bmap);
+		dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
+				     BNXT_RX_PAGE_SIZE, bp->rx_dir,
+				     DMA_ATTR_WEAK_ORDERING);
+		rx_agg_buf->page = NULL;
+		__clear_bit(i, rxr->rx_agg_bmap);
 
-			__free_page(page);
-		}
+		page_pool_recycle_direct(rxr->page_pool, page);
 	}
 
 skip_rx_agg_free:
-	if (rxr->rx_page) {
-		__free_page(rxr->rx_page);
-		rxr->rx_page = NULL;
-	}
 	map = rxr->rx_tpa_idx_map;
 	if (map)
 		memset(map->agg_idx_bmap, 0, sizeof(map->agg_idx_bmap));
@@ -3244,7 +3199,9 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 {
 	struct page_pool_params pp = { 0 };
 
-	pp.pool_size = bp->rx_ring_size;
+	pp.pool_size = bp->rx_agg_ring_size;
+	if (BNXT_RX_PAGE_MODE(bp))
+		pp.pool_size += bp->rx_ring_size;
 	pp.nid = dev_to_node(&bp->pdev->dev);
 	pp.napi = &rxr->bnapi->napi;
 	pp.dev = &bp->pdev->dev;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 362918876d3c..d6a1eaa69774 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -919,9 +919,6 @@ struct bnxt_rx_ring_info {
 	unsigned long		*rx_agg_bmap;
 	u16			rx_agg_bmap_size;
 
-	struct page		*rx_page;
-	unsigned int		rx_page_offset;
-
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
 	dma_addr_t		rx_agg_desc_mapping[MAX_RX_AGG_PAGES];
 
-- 
2.30.1


--000000000000ea8efa060326a4f5
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKfACHAkRqer//riuB7hog1eC2tMC/RO
pzChDHda1QI8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgx
NzIzMTkzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBZlhv/iVhvYf6+ZLAdVj88/UOHT5UZmC5dOl8ruvqqaET0nzSc
+NxY7nukxbW2jSq0SS/BOHZ5PHemRXFuebJ71GDuWIfazfXL+/YFMsCSKymrbNxlhbgrBbMGyTvT
JHmLEK80olq+FVTJCJ6kSzKUWCUTbotLIwU5RPv/dVZUnLwc5bFg4k/E2OMxcWrU/0mFpgJws7WE
iTnL5gNbAtkmHRHGIhwr+43/Gdl+ZPdaWRP3z8Oii6z1r2nqf3tZNM7SclEKPqqT7iwD0wk5FUcx
SAL8YIA34j7XzEV4tn6LIJoOY+H/NpQJ6HlmVko0Ss+dHz/tyHW+qNFFD7wfQLTI
--000000000000ea8efa060326a4f5--

