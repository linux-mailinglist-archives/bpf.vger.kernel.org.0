Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AC54300F
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 14:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiFHMPL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 08:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiFHMPJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 08:15:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F502FEBA8
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 05:14:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s1so5008401wra.9
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIZoX97lgMEfYXRtrRbHmV+MaPH2VSiRSbxgkQsYzMw=;
        b=LSCdIPdZavqtDj1jK8NrDfVKSWR3uDWlEYLg2M1qMViGyRGSQOn+UA54DLCfSpwhL9
         cBIoQbPgv7QYclBhzSF0HFv33/PAmJyBMga63dGdFuNCISCMQajj3Oa/bCa3GMFbpDRT
         3h6IZlKNydPST4CENUGKyfMuMPr9jwF2aDcipwq6otUI57WXfoJwnJCFi/mbCcDsxftm
         EsS04O9JMOPCdlpFxBsviXBySNXy4YSSBGCDa/nFMGcl4FQPB/RQi2XmINaQv8SHyUjK
         PEWlctJ5E8iRQChqrsu9joxjZv76vBDQiSIfhMBlJfnBm0aRDBzvKLdkq3ylCG0LGXcE
         C0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIZoX97lgMEfYXRtrRbHmV+MaPH2VSiRSbxgkQsYzMw=;
        b=NPxEj2rlMaunIvNYW5o+swjF6FVqPl35J0DJ5UOi293xTAUYqBQ1M2sGG+MYxJTH22
         gA6Xu41wrRd8C/0E/3K0HjYx9isZNAG8TpWdX2KmTC2r/aWtDeCRHBwPARHdvcQEowfS
         aWc697UaylinrI2cxugZnKaw1q/24xVp27pD/sXuhw1aPH2sowrDpwcTGb4OQcQ70HCz
         kmp0fpqfOZJYqgA9Cg9+FdMJ5j1nuSZ6QaXuzAk2JZ++bTAk+YzqDeQJFTRxAhwkDeAs
         snAijmPd8MdGaXZehhC7lzeerAv5H/btEkgrK0oOdhYNJz0FDbVdXLbwpEY38gHmNCP6
         tSjA==
X-Gm-Message-State: AOAM533RoNRs+l4qnVAP/X5/TFVVcxt7ifMlk8UnGS3geAgwf94af9OT
        X2lyVgApExoprb175G5FZ25rRw==
X-Google-Smtp-Source: ABdhPJwsewRZcYVPOzG6Etn7u0/qi/VK3DE3ZtPgvYb24Y1tSoa2lzpX+K915rMK5xG5dALLMF3jwg==
X-Received: by 2002:a5d:6dc6:0:b0:20f:bf64:c9fc with SMTP id d6-20020a5d6dc6000000b0020fbf64c9fcmr33092617wrz.648.1654690491945;
        Wed, 08 Jun 2022 05:14:51 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d6547000000b0021020517639sm21726421wrv.102.2022.06.08.05.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 05:14:51 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf] MAINTAINERS: Add a maintainer for bpftool
Date:   Wed,  8 Jun 2022 13:14:28 +0100
Message-Id: <20220608121428.69708-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I've been contributing and reviewing patches for bpftool for some time,
and I'm taking care of its external mirror. On Alexei, KP, and Daniel's
suggestion, I would like to step forwards and become a maintainer for
the tool. This patch adds a dedicated entry to MAINTAINERS.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 033a01b07f8f..92c8adc5471b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3731,6 +3731,13 @@ F:	include/linux/bpf_lsm.h
 F:	kernel/bpf/bpf_lsm.c
 F:	security/bpf/
 
+BPFTOOL
+M:	Quentin Monnet <quentin@isovalent.com>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	kernel/bpf/disasm.*
+F:	tools/bpf/bpftool/
+
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
 L:	netdev@vger.kernel.org
-- 
2.25.1

