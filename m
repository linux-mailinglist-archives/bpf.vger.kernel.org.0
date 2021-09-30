Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1641D375
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348071AbhI3Gft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 02:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbhI3Gfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 02:35:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972FDC06161C
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 23:34:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k7so8069688wrd.13
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zoQFpdU/4SCUhvk9BVLWtQNzKxicdIAL3RbzmUC/etE=;
        b=bWu+A/+zeX4krbo9BCsGzY/goqlXVNkuF0/SUf5xpZWpn+FBkE6MKLkp7s/wz5zYe4
         iRaOUy1vueX8muQLBjY9rJFFV7bDDdHA5gkmfqTTJjiB4EebbWZfgt/ELkbAwzUZQbX3
         bsiBcz5NStBuCp6zbhMVW/ZefJWgcfVzYbJ5NHeAYvQmIcszFQ/HLSRZBqgVmysZ/f8l
         1n0d7RajTJUzRxlng4+cn0HTiN1AjS7cAgMi38VbnAW5mIuy5pk6nzB5LQ6uDnB5naP+
         j7wJWw8/QeEfLju4UivB3Jm72Yirw8tUIwqhjthuftx9p7OUEhrUnFETcAJafgYawzOF
         DZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zoQFpdU/4SCUhvk9BVLWtQNzKxicdIAL3RbzmUC/etE=;
        b=s7PYiyxv9fbvAL9QJq/0VLueYv4eli2s80cVUjsTRdFIvAMIfnXMtULirHv/YUoGX/
         Xj4qGdtv/hn02HyOmS9ztg86ynJQpw2NWgs+4J/9vYD6irqjd4ye2kmZcFByyz/ChiBH
         E688Wa8TTVBWK7eM6/ClQhDyVjvzuF7WdxVLdHVwiQ8fhewQuj/zKJ4+HyidkWNEPrg5
         LNhqVhJKfHz2NgIEY/vbRoH65kg3tOh7hdE19C5NCeqPQDnAkTvXNAiBcYPpjrZ9fPMt
         sEOnSoBXYsF+qVLZFR/Yfxr/KziTtGNzjxszLAwkJu5NOIGSp6mcwrdqm9kRcjU/2mwf
         aztw==
X-Gm-Message-State: AOAM530M2bV4cFf24kApukoo1GHa4wdG4sh+RNYMJCUIilMHB3iHmm7n
        XNTmuvZ1C04R+b3xUDL+L8MTj/Qt9Ia640VE
X-Google-Smtp-Source: ABdhPJz2clV71yn+AAPqYDEV3L++K5HPZDI+N0euzwQpfcZzNQ9NDgSv27ssbgv5XZbSFTglk7MnKg==
X-Received: by 2002:adf:e742:: with SMTP id c2mr4181872wrn.18.1632983645113;
        Wed, 29 Sep 2021 23:34:05 -0700 (PDT)
Received: from kev-VirtualBox (host86-149-72-135.range86-149.btcentralplus.com. [86.149.72.135])
        by smtp.gmail.com with ESMTPSA id z12sm3603407wmf.21.2021.09.29.23.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 23:34:04 -0700 (PDT)
Date:   Thu, 30 Sep 2021 07:34:02 +0100
From:   Kev Jackson <foamdino@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     bpf@vger.kernel.org
Subject: [PATCH bpf-next] Trivial: docs: correct some English grammar and
 spelling
Message-ID: <YVVaWmKqA8l9Tm4J@kev-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Header DOC on include/net/xdp.h contained a few English
 grammer and spelling errors.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Kev Jackson <foamdino@gmail.com>
---
 include/net/xdp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index ad5b02dcb6f4..447f9b1578f3 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -15,13 +15,13 @@
  * level RX-ring queues.  It is information that is specific to how
  * the driver have configured a given RX-ring queue.
  *
- * Each xdp_buff frame received in the driver carry a (pointer)
+ * Each xdp_buff frame received in the driver carries a (pointer)
  * reference to this xdp_rxq_info structure.  This provides the XDP
  * data-path read-access to RX-info for both kernel and bpf-side
  * (limited subset).
  *
  * For now, direct access is only safe while running in NAPI/softirq
- * context.  Contents is read-mostly and must not be updated during
+ * context.  Contents are read-mostly and must not be updated during
  * driver NAPI/softirq poll.
  *
  * The driver usage API is a register and unregister API.
@@ -30,8 +30,8 @@
  * can be attached as long as it doesn't change the underlying
  * RX-ring.  If the RX-ring does change significantly, the NIC driver
  * naturally need to stop the RX-ring before purging and reallocating
- * memory.  In that process the driver MUST call unregistor (which
- * also apply for driver shutdown and unload).  The register API is
+ * memory.  In that process the driver MUST call unregister (which
+ * also applies for driver shutdown and unload).  The register API is
  * also mandatory during RX-ring setup.
  */
 
-- 
2.30.2

