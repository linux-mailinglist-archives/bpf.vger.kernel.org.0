Return-Path: <bpf+bounces-8032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395DD780198
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 01:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E727E281F7F
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865A31C28F;
	Thu, 17 Aug 2023 23:19:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B871C286
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 23:19:34 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E313595
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 16:19:32 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a44cccbd96so210592b6e.3
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692314372; x=1692919172;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6lHrCYuHuZi+FFA23xul/Fk0r5GfzER7QKxy4ctvGg=;
        b=QWk8eyNyXZA4pxDGPkWUGYQr/PsoaQN6ZSC0qFbaA+KNcBJmumdtu5r0bCw26WfrhY
         mvkY5VVbbn1EP/kJa8D9OeUprgQAARTFQ9a+W5Vz+Y34HRDnN4HUgRqw1+6K0masGgkL
         Nl1hZSrXc7Usj6EN7NG4z0BgbULaFNfVjY4BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692314372; x=1692919172;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6lHrCYuHuZi+FFA23xul/Fk0r5GfzER7QKxy4ctvGg=;
        b=RnRavJzunkzIgRd3buqntv5Z2hyT8rQJMNf7x9PevWAUNMlChPIm1dyHc7CvvLghse
         2EbxM30cz7ZufK5yC7qi7y25xOKw2zgflp9J1M1SRpqQ4GKMLHYEh94WdS0yzdCX4bvt
         wxElPFHMdaHsOFED64d1OiejZGQKT8s+JnvSvctwjjroREs6jwINf3jrriZBH+3Bf3RV
         lf2e3G0puTpIH+L+90+TFRDnEzv1lght9CbxJIY5KseTI5RAgFc0TyPkxni4bbOrgkNr
         kubJDkvSTUy+BBQdzcUcDffGH0H2uj6cMcPr2TVizRfO8SpOwPkZnzE8UVeaphWsqnyr
         Et0w==
X-Gm-Message-State: AOJu0YwtpKSR+qP0iKEUagDm84g4PZLFA/PO8+LHUs0XRVOPxuDgWfJ7
	L4dPa5pZtn1o9A4VnjGvz7lk64iroJLPJSq3Ww8=
X-Google-Smtp-Source: AGHT+IFQp7uSkrTryqlWyHTD/sfuCkh/CIBqV+7tHBekSU6UPBd01Owf+AYHRNdON5bDsaET6Wi8CA==
X-Received: by 2002:a05:6808:1795:b0:3a4:ccf:6a63 with SMTP id bg21-20020a056808179500b003a40ccf6a63mr1209512oib.55.1692314371688;
        Thu, 17 Aug 2023 16:19:31 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a149b00b0076d25b11b62sm145516qkj.38.2023.08.17.16.19.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2023 16:19:31 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 2/6] bnxt_en: Let the page pool manage the DMA mapping
Date: Thu, 17 Aug 2023 16:19:07 -0700
Message-Id: <20230817231911.165035-3-michael.chan@broadcom.com>
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
	boundary="000000000000002994060326a552"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000002994060326a552
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Use the page pool's ability to maintain DMA mappings for us.
This avoids re-mapping of the recycled pages.

Link: https://lore.kernel.org/netdev/20230728231829.235716-4-michael.chan@broadcom.com/
Cc: bpf@vger.kernel.org
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Use PAGE_SIZE for pp.max_len.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 32 +++++++----------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6b815a2288e2..73a3936ee498 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -761,7 +761,6 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 					 unsigned int *offset,
 					 gfp_t gfp)
 {
-	struct device *dev = &bp->pdev->dev;
 	struct page *page;
 
 	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
@@ -774,12 +773,7 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 	if (!page)
 		return NULL;
 
-	*mapping = dma_map_page_attrs(dev, page, *offset, BNXT_RX_PAGE_SIZE,
-				      bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
-	if (dma_mapping_error(dev, *mapping)) {
-		page_pool_recycle_direct(rxr->page_pool, page);
-		return NULL;
-	}
+	*mapping = page_pool_get_dma_addr(page) + *offset;
 	return page;
 }
 
@@ -998,8 +992,8 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
-			     bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+				bp->rx_dir);
 	skb = build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
@@ -1032,8 +1026,8 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
-			     bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
+	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+				bp->rx_dir);
 
 	if (unlikely(!payload))
 		payload = eth_get_headlen(bp->dev, data_ptr, len);
@@ -1149,9 +1143,8 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 			return 0;
 		}
 
-		dma_unmap_page_attrs(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
-				     bp->rx_dir,
-				     DMA_ATTR_WEAK_ORDERING);
+		dma_sync_single_for_cpu(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
+					bp->rx_dir);
 
 		total_frag_len += frag_len;
 		prod = NEXT_RX_AGG(prod);
@@ -2947,10 +2940,6 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 
 		rx_buf->data = NULL;
 		if (BNXT_RX_PAGE_MODE(bp)) {
-			mapping -= bp->rx_dma_offset;
-			dma_unmap_page_attrs(&pdev->dev, mapping,
-					     BNXT_RX_PAGE_SIZE, bp->rx_dir,
-					     DMA_ATTR_WEAK_ORDERING);
 			page_pool_recycle_direct(rxr->page_pool, data);
 		} else {
 			dma_unmap_single_attrs(&pdev->dev, mapping,
@@ -2971,9 +2960,6 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		if (!page)
 			continue;
 
-		dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
-				     BNXT_RX_PAGE_SIZE, bp->rx_dir,
-				     DMA_ATTR_WEAK_ORDERING);
 		rx_agg_buf->page = NULL;
 		__clear_bit(i, rxr->rx_agg_bmap);
 
@@ -3205,7 +3191,9 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.nid = dev_to_node(&bp->pdev->dev);
 	pp.napi = &rxr->bnapi->napi;
 	pp.dev = &bp->pdev->dev;
-	pp.dma_dir = DMA_BIDIRECTIONAL;
+	pp.dma_dir = bp->rx_dir;
+	pp.max_len = PAGE_SIZE;
+	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE)
 		pp.flags |= PP_FLAG_PAGE_FRAG;
 
-- 
2.30.1


--000000000000002994060326a552
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG7a8XRWGhMNBGOgWFXkepYEhVW0ar3J
ByJHSfMBY8uaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgx
NzIzMTkzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAcU4aCxPEKeV90+pcqO94siMdsmobX2leDYluUVhaJCReNbOGf
KeNiCB1+Cch5yKtXslHlkLdJDMAuIlTKqR5df8NqhM9K6z71hfwOIuM+limxiNQbkRn1Tmv3gk38
U1LeIckaJWA92xXhmhMGWKIwYR2U9PQSo5l6xUgwSvsFQA3dX5rnLFoM+FiXlC5CAfRjCLBvuUxb
T2LzOMYfWhUT42mGqB+6u3cuKZNc7DnlzeQRqSyIY0jlFBiAmnstD/B2IzB0ic/nCps+7j1Fdta2
CvAr5JV8+8k3e7JmV5X9DueqNP/1LSB+Znl+go02o0kKzUDB0WH9Dcb3V2KRXbc+
--000000000000002994060326a552--

