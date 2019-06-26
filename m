Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2BF56E2E
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 17:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFZP7X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jun 2019 11:59:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41464 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZP7S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 11:59:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so1930143lfa.8
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=w3F+tqbuCaIkVEmb3xZOgqKho6J48v4zfZ9zqPryVN8=;
        b=g9V3FeUtFTWjdbosHMyZt4xm7w+kP7xwYdEacmzFkudE1y+O7N4jJ0o1485yPZ2KkV
         nE+9UENFAt22ikKN4VKWQsipR+VEnTM7ixoyzwPP0V6SnB1WMndNPVu0YtEYpWTyiSxW
         aDDIJ+QdEVHzhEbSwqWwItJ1ePptdzA73s771bAn8LtrY1GVRVbI5jK7isj2UJjeM01x
         pZXuRDiQpNPRezH1rd5nGe2EDGLrPqomN9gmggQCsn6kydp+UC530gotK5JtrcUOZPTv
         Z5narCZ1IsA10kj13uHoOyheyRkC638s8UVM6Nwguobhli26k3OUWn5HLVpXt/iyT/5c
         YJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w3F+tqbuCaIkVEmb3xZOgqKho6J48v4zfZ9zqPryVN8=;
        b=q7L8bf8OVMtCCBZJfVDFucs4ewgb2rtLozFOGmsrXyQN2r0OdiVAbsrO4k7Ydc7tV9
         5nQ49ky8FEb441gH7ph6bYQa8lWnTaeMlRidl8NS8+kuLm1jVu4/UbOrZkUfrTIy4Y32
         UaYqQ/MXoVAB5Qc3hOuEE0kzZX98t9AUjHMB0cN4S7MVwd73VbQcd6+gWndBbfEZ++1m
         8IgHLpc9pUDmCa/3xWN3dSee8hk8szg7W+j92Cbiii3I8qtm00Fq3SlpcRi7GDI78kPI
         sKhc2UOj+GjTzwJq/Fp9WlXlEECg9ZeHaNJ4Lhm6VYZAIacYzxXiMogtDKqp5WSVPfq9
         kckA==
X-Gm-Message-State: APjAAAVOBU5elS2SAKUFFe/Qz1p53iQB40OjneMfDwc70gZqKjd2bKhB
        LH9tljCaUty+xN8o3I2bmNAOUA==
X-Google-Smtp-Source: APXvYqwxPGGkHGeCrj0vxlOHZFHSZuMOUZLSiXgf7NgyB/aIkSZ03HweWLPeu8yjUokOOKyyRr1TDw==
X-Received: by 2002:a19:4f50:: with SMTP id a16mr3070485lfk.24.1561564755631;
        Wed, 26 Jun 2019 08:59:15 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id p27sm2504052lfo.16.2019.06.26.08.59.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 08:59:15 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        davem@davemloft.net
Cc:     ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] xdp: xdp_umem: fix umem pages mapping for 32bits systems
Date:   Wed, 26 Jun 2019 18:59:11 +0300
Message-Id: <20190626155911.13574-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use kmap instead of page_address as it's not always in low memory.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 net/xdp/xdp_umem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 9c6de4f114f8..d3c1411420fd 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -169,6 +169,14 @@ static void xdp_umem_clear_dev(struct xdp_umem *umem)
 	}
 }
 
+static void xdp_umem_unmap_pages(struct xdp_umem *umem)
+{
+	unsigned int i;
+
+	for (i = 0; i < umem->npgs; i++)
+		kunmap(umem->pgs[i]);
+}
+
 static void xdp_umem_unpin_pages(struct xdp_umem *umem)
 {
 	unsigned int i;
@@ -210,6 +218,7 @@ static void xdp_umem_release(struct xdp_umem *umem)
 
 	xsk_reuseq_destroy(umem);
 
+	xdp_umem_unmap_pages(umem);
 	xdp_umem_unpin_pages(umem);
 
 	kfree(umem->pages);
@@ -372,7 +381,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	}
 
 	for (i = 0; i < umem->npgs; i++)
-		umem->pages[i].addr = page_address(umem->pgs[i]);
+		umem->pages[i].addr = kmap(umem->pgs[i]);
 
 	return 0;
 
-- 
2.17.1

