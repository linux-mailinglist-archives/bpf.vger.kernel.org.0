Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4134F6066
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiDFNd1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 09:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiDFNck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 09:32:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE8C32FDED
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 19:54:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so1368016pjk.4
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 19:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uy1+mqy44Y8ZNqwhRp+n17IT9yEhFha7+I3bQ7ogrb0=;
        b=HykHgv4xjU9u+nbufo46UzkTjKkvwUtVsODgHE8Tm9UTd2vUjZ5+3d0C4U8Lkcm8Nb
         fBmULl/WyBr8kkrcyXDFV/cdgCQKaGNzvNFumfqiStZZGvieGi20BiaJyF1xlENr4m7H
         D7/yrY0dnGE6oxtRvkVm4+DpKjQvgylQmghkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uy1+mqy44Y8ZNqwhRp+n17IT9yEhFha7+I3bQ7ogrb0=;
        b=vlj2xQXZDkdsMaAynYiDpVcyAz35smRy5qz8dGC3+5q7bBv5rxR6xxBFwgtsvkmyRw
         Y/HKh4Iu2JjzwIpteZt1qID7BxMhhUQksBYFhUIP5H9I+a/EcocTfyzVszUKSIRuIago
         1fKn6JyfktY/INwtD/IA447Emu2Bffed1CYv9HBOmtBAEJ2laI3bjdD5Wf3/A3WVymJl
         jfU6d9TH3ICqgr55mKAamo4VIyoaiRIEXDD602UI5XLGeZmOe3tyTDK5ebrMf9lmBPcp
         /Ug3QAaxa2hyaANlCZ/kS95Jy5unV0FIEAo7N7Weju4F4juG6V3jxDFfduWg7bPm6jpt
         RsZA==
X-Gm-Message-State: AOAM533WKgOfYiiBPuq/KzfQOP31PLnv1WCZZ5AHI4fus2Y8LwrygSbY
        1SiWFGZ/IlKBnNk8e2cJUSXXWw==
X-Google-Smtp-Source: ABdhPJxcyIhFXuBH/o9qSpncXnltOTaXEKCjCbaO+g1ma0AgOVqKeY7prZ0lApPhHGCoCYYM2+swQw==
X-Received: by 2002:a17:902:f612:b0:14c:e978:f99e with SMTP id n18-20020a170902f61200b0014ce978f99emr6562680plg.23.1649213667684;
        Tue, 05 Apr 2022 19:54:27 -0700 (PDT)
Received: from localhost.swdvt.lab.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x9-20020a17090a970900b001ca6c59b350sm3395111pjo.2.2022.04.05.19.54.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Apr 2022 19:54:27 -0700 (PDT)
From:   Michael Chan <michael.chan@broadcom.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, kuba@kernel.org, gospo@broadcom.com,
        bpf@vger.kernel.org, john.fastabend@gmail.com, toke@redhat.com,
        lorenzo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        echaudro@redhat.com, pabeni@redhat.com
Subject: [PATCH net-next v3 08/11] bnxt: add page_pool support for aggregation ring when using xdp
Date:   Tue,  5 Apr 2022 22:53:50 -0400
Message-Id: <1649213633-7662-9-git-send-email-michael.chan@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649213633-7662-1-git-send-email-michael.chan@broadcom.com>
References: <1649213633-7662-1-git-send-email-michael.chan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000dd9c9f05dbf37af1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--000000000000dd9c9f05dbf37af1

From: Andy Gospodarek <gospo@broadcom.com>

If we are using aggregation rings with XDP enabled, allocate page
buffers for the aggregation rings from the page_pool.

Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 77 ++++++++++++++---------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2a919905f256..f89a45042f38 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -739,7 +739,6 @@ static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
 	}
-	*mapping += bp->rx_dma_offset;
 	return page;
 }
 
@@ -781,6 +780,7 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		if (!page)
 			return -ENOMEM;
 
+		mapping += bp->rx_dma_offset;
 		rx_buf->data = page;
 		rx_buf->data_ptr = page_address(page) + bp->rx_offset;
 	} else {
@@ -841,33 +841,41 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	u16 sw_prod = rxr->rx_sw_agg_prod;
 	unsigned int offset = 0;
 
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
-		page = rxr->rx_page;
-		if (!page) {
+	if (BNXT_RX_PAGE_MODE(bp)) {
+		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, gfp);
+
+		if (!page)
+			return -ENOMEM;
+
+	} else {
+		if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
+			page = rxr->rx_page;
+			if (!page) {
+				page = alloc_page(gfp);
+				if (!page)
+					return -ENOMEM;
+				rxr->rx_page = page;
+				rxr->rx_page_offset = 0;
+			}
+			offset = rxr->rx_page_offset;
+			rxr->rx_page_offset += BNXT_RX_PAGE_SIZE;
+			if (rxr->rx_page_offset == PAGE_SIZE)
+				rxr->rx_page = NULL;
+			else
+				get_page(page);
+		} else {
 			page = alloc_page(gfp);
 			if (!page)
 				return -ENOMEM;
-			rxr->rx_page = page;
-			rxr->rx_page_offset = 0;
 		}
-		offset = rxr->rx_page_offset;
-		rxr->rx_page_offset += BNXT_RX_PAGE_SIZE;
-		if (rxr->rx_page_offset == PAGE_SIZE)
-			rxr->rx_page = NULL;
-		else
-			get_page(page);
-	} else {
-		page = alloc_page(gfp);
-		if (!page)
-			return -ENOMEM;
-	}
 
-	mapping = dma_map_page_attrs(&pdev->dev, page, offset,
-				     BNXT_RX_PAGE_SIZE, DMA_FROM_DEVICE,
-				     DMA_ATTR_WEAK_ORDERING);
-	if (dma_mapping_error(&pdev->dev, mapping)) {
-		__free_page(page);
-		return -EIO;
+		mapping = dma_map_page_attrs(&pdev->dev, page, offset,
+					     BNXT_RX_PAGE_SIZE, DMA_FROM_DEVICE,
+					     DMA_ATTR_WEAK_ORDERING);
+		if (dma_mapping_error(&pdev->dev, mapping)) {
+			__free_page(page);
+			return -EIO;
+		}
 	}
 
 	if (unlikely(test_bit(sw_prod, rxr->rx_agg_bmap)))
@@ -1105,7 +1113,7 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
 		}
 
 		dma_unmap_page_attrs(&pdev->dev, mapping, BNXT_RX_PAGE_SIZE,
-				     DMA_FROM_DEVICE,
+				     bp->rx_dir,
 				     DMA_ATTR_WEAK_ORDERING);
 
 		total_frag_len += frag_len;
@@ -2936,14 +2944,23 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		if (!page)
 			continue;
 
-		dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
-				     BNXT_RX_PAGE_SIZE, DMA_FROM_DEVICE,
-				     DMA_ATTR_WEAK_ORDERING);
+		if (BNXT_RX_PAGE_MODE(bp)) {
+			dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
+					     BNXT_RX_PAGE_SIZE, bp->rx_dir,
+					     DMA_ATTR_WEAK_ORDERING);
+			rx_agg_buf->page = NULL;
+			__clear_bit(i, rxr->rx_agg_bmap);
 
-		rx_agg_buf->page = NULL;
-		__clear_bit(i, rxr->rx_agg_bmap);
+			page_pool_recycle_direct(rxr->page_pool, page);
+		} else {
+			dma_unmap_page_attrs(&pdev->dev, rx_agg_buf->mapping,
+					     BNXT_RX_PAGE_SIZE, DMA_FROM_DEVICE,
+					     DMA_ATTR_WEAK_ORDERING);
+			rx_agg_buf->page = NULL;
+			__clear_bit(i, rxr->rx_agg_bmap);
 
-		__free_page(page);
+			__free_page(page);
+		}
 	}
 
 skip_rx_agg_free:
-- 
2.18.1


--000000000000dd9c9f05dbf37af1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
xV4Em+0wQoEIR2kPG6yiZNtUK0tNCaZejYU/Mf/bzdKSwud3pLgHV8ls83y2OU/ha9xgJMLpRswv
xucFCxMsPmk0yoVmpbr92kIpLm+TomNZsL++LcDRa2ECAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUz2bMvqtXpXM0u3vAvRkalz60
CjswDQYJKoZIhvcNAQELBQADggEBAGUgeqqI/q2pkETeLr6oS7nnm1bkeNmtnJ2bnybNO/RdrbPj
DHVSiDCCrWr6xrc+q6OiZDKm0Ieq6BN+Wfr8h5mCkZMUdJikI85WcQTRk6EEF2lzIiaULmFD7U15
FSWQptLx+kiu63idTII4r3k/7+dJ5AhLRr4WCoXEme2GZkfSbYC3fEL46tb1w7w+25OEFCv1MtDZ
1CHkODrS2JGwDQxXKmyF64MhJiOutWHmqoGmLJVz1jnDvClsYtgT4zcNtoqKtjpWDYAefncWDPIQ
DauX1eWVM+KepL7zoSNzVbTipc65WuZFLR8ngOwkpknqvS9n/nKd885m23oIocC+GA4xggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwQeU+Y6hbenPzRMJsw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJjY8EEWIGbdRKn8WbdHzcn2pcTH9pZo
JKbF9PGNzg2yMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDQw
NjAyNTQyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB+AYtVC7tGOoqglCPO59ga9GHyKufZGsWUdvU1JiV8k83x/t/K
9ETZWExwWt5SiZRePxfC1KdhtCC66wCcZoyxWXA9zL2B4aNWkAmWisAJGH9qcuaaKlOEeiT3R9CJ
NwcdvoJG+V1pfjoUQQZEgQ7aQawp5Y13vU0GzI4O+/95/ctZWcHeY708dKqA4blYNW5XCbWgMZuF
maYy/69GNFjZ3iRUcx3Sdmvq11r5HZ7fAzASJOx3JaNoxBf8RPqyXKVqaMn97ACr1Puvol/vS92M
kMYKC+4bYlj6Sq4RaCpgvuH385D3xsRZDr8jBZubzNKS/y+DqpGwWBivIafj8fD3
--000000000000dd9c9f05dbf37af1--
