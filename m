Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06722A0E79
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 02:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfH2ABq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 20:01:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43071 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfH2ABq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Aug 2019 20:01:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so553686pgb.10;
        Wed, 28 Aug 2019 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xL/Oj30ungnv7AXXKEXXc2ijUo+geLZ+6VixKgBmaI=;
        b=LnP8qDwmC568ICHNp5X4e3Me3bgQ1MS4TmeAket+k/S9bNYaRQbWXvtxpZbflN52ID
         cqHHfqWLapFZ4Un9/GVlrZ5xNbG+pxfF/GbZEy9dgC2M4JGM8mGkzXOAwfxgz467bt/5
         9CIwOOcmDgwmv11Ro5n7QgufcHzqnJlkS8svK0O6mL06fuqfWxs/qDiS/fMEzFPXVRPr
         v4fRA3LAZR3w4GhDLJ8X0t0SYQGI7RITGnd21qQv5lghBlcVTXWBEfnXvbWjXtHOfZaa
         Q6uS78IWI2Y8KEdT1EFRwVOrwyi00Y9GH0W/PxBJg3K1zuGQ6bdp2LC9Ewhe2amfPsEk
         MEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xL/Oj30ungnv7AXXKEXXc2ijUo+geLZ+6VixKgBmaI=;
        b=d9DCEl/cmybYdZCPYH3hyR1SYdS7dl596HsF7/prfN2g7wjW+hKN6hFfY/YohYtaMb
         EcMh+FPuuwNNB9edS9csw5S3xdpmYVoJyoj7w1mSFgrcS4juRramPtN2sbUloOm2AXyP
         2Nvbx/9l54k+wyN/2Fi7y7amwfWT1vv0cdUVP2FxHkoRWyRI0svoI2zTwldJ3sIn0Q/+
         wvfnCTGJDTMPsRU0nRFsvCdZiR23tyJyOaAvsOpd72Ps3gcSu81N/hajoGNkpZXe2aSB
         AKdne90eJXfJvd3tTQyhj4/1oSKZEebnTGg4v/ldECyxbLRhy3om9/Gwy6eA9X7oePbD
         p9pQ==
X-Gm-Message-State: APjAAAUBQzFE4SiQoLMSPB/RvKa4xsIoaImLM9q4EdTD8/+dQ29QPYDC
        PGmnE5hF+DLESgiHM+oMOMQthizR
X-Google-Smtp-Source: APXvYqwkb50dVh1LsEmevzcBW8xq0HTr8GOVnv0hQTgH4Tc05RGyLNRErIMMR6mRVV0ZvzpdRTupNg==
X-Received: by 2002:a65:5b09:: with SMTP id y9mr5874979pgq.345.1567036905268;
        Wed, 28 Aug 2019 17:01:45 -0700 (PDT)
Received: from masabert (150-66-70-147m5.mineo.jp. [150.66.70.147])
        by smtp.gmail.com with ESMTPSA id y10sm277114pjp.27.2019.08.28.17.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 17:01:44 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 010D42011A3; Thu, 29 Aug 2019 09:01:31 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] selftests/bpf: Fix a typo in test_offload.py
Date:   Thu, 29 Aug 2019 09:01:30 +0900
Message-Id: <20190829000130.7845-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0.37.g745f6812895b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch fix a spelling typo in test_offload.py

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/testing/selftests/bpf/test_offload.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 425f9ed27c3b..15a666329a34 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -1353,7 +1353,7 @@ try:
     bpftool_prog_list_wait(expected=1)
 
     ifnameB = bpftool("prog show %s" % (progB))[1]["dev"]["ifname"]
-    fail(ifnameB != simB1['ifname'], "program not bound to originial device")
+    fail(ifnameB != simB1['ifname'], "program not bound to original device")
     simB1.remove()
     bpftool_prog_list_wait(expected=1)
 
-- 
2.23.0.37.g745f6812895b

