Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855F84D76F4
	for <lists+bpf@lfdr.de>; Sun, 13 Mar 2022 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiCMQnG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Mar 2022 12:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiCMQnF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Mar 2022 12:43:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A576162
        for <bpf@vger.kernel.org>; Sun, 13 Mar 2022 09:41:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z3so11658564plg.8
        for <bpf@vger.kernel.org>; Sun, 13 Mar 2022 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbrnaGEc2Ha5JAqOzocKA2rWH1QtHTPkTA8Sp4SL09A=;
        b=JNZgQaDnqCkwpDeZA1cRHWylsx6jBa2IZis+vOpr3582YiINkafo3+6KR27NUnXt5z
         Pwd0q4Py7SssuK7mqKLzU5/Al1j4VoDsV2C9RLU3VrNwKkFKjnwmhXthBmPBD6BLAmME
         fWg9RttoFCNCr5hoVLVwrEQMCgwfNrMBMAzPNMMDiGSR4kIdezWdC0c4ClmMOXPVTZVP
         GuB7RcuYHncNk8+4V4OeCuZgWi7Dv1H67OJPBvkoeP8WfzhPd/4CNjtqWyAELdWK2FUR
         k8P5gfHhvUktOyyHDsIlFa2a3z01ZGUxm64DlddIUwoErLP3L8wEn4A/v7UfnNz008yP
         gvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbrnaGEc2Ha5JAqOzocKA2rWH1QtHTPkTA8Sp4SL09A=;
        b=7tFVC9MFYqaZ6/obNrn5rnOBGJQ3CvUi5Af17SIom1pARUa7nuFxmba9oBBVjwQnHq
         geVzxYmJI5JwcUArTmnukOphjiob54FEJxBV2YVwAKic/ZLjoALbnzzy3379/uY2PTXz
         IvaQ40oXIi7QtG/FfAs+xSTlrnCXNGi18+ZLfGwUgyqzwDPp1SoUsvC7KSm9muhvQchq
         rRaF/7Zc16ASbnPnM13t1BjwguJVHGzZzh4p/go7X6DGPG1kUNpSEtGdWotmaTeArLCp
         /qUMRyULOAaUcRIl+brtHXvdMv7d2pF3+LNvC4ktlvdLeayQkdvQl1Cz0rYmGMpAHKvg
         zcyg==
X-Gm-Message-State: AOAM530sZcGjwfi8gvPz493N2rkkhxHRYXwTFT8YHzMXHdplY0vGPcwV
        pu7wahNaWw1mSUBJGmznCD/0IC00Gq87HAcD
X-Google-Smtp-Source: ABdhPJwr1Q+0lEK0DintBK8aqwXCl8TxVKU8d5mTk6Hty92c79GBBXA1qIW/Y/k7ScgqrvAEdgwVCw==
X-Received: by 2002:a17:90b:f8a:b0:1be:dccd:e4f7 with SMTP id ft10-20020a17090b0f8a00b001bedccde4f7mr20948864pjb.92.1647189717343;
        Sun, 13 Mar 2022 09:41:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4835:ff60:5c2a:e570:2bbf:d409])
        by smtp.gmail.com with ESMTPSA id e13-20020a63370d000000b003810782e0cdsm8012765pga.56.2022.03.13.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 09:41:56 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     shuah@kernel.org, bpf@vger.kernel.org
Cc:     "kaixi.fan" <fankaixi.li@bytedance.com>
Subject: [PATCH] selftests/bpf: fix tunnel remote ip comments
Date:   Mon, 14 Mar 2022 00:41:16 +0800
Message-Id: <20220313164116.5889-1-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "kaixi.fan" <fankaixi.li@bytedance.com>

In namespace at_ns0, the ip address of tnl dev is 10.1.1.100 which
is the overlay ip, and the ip address of veth0 is 172.16.1.100
which is the vtep ip.
When doing 'ping 10.1.1.100' from root namespace, the
remote_ip should be 172.16.1.100.

Fixs: 933a741e ("selftests/bpf: bpf tunnel test.")
Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
---
 tools/testing/selftests/bpf/test_tunnel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index ca1372924023..2817d9948d59 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -39,7 +39,7 @@
 # from root namespace, the following operations happen:
 # 1) Route lookup shows 10.1.1.100/24 belongs to tnl dev, fwd to tnl dev.
 # 2) Tnl device's egress BPF program is triggered and set the tunnel metadata,
-#    with remote_ip=172.16.1.200 and others.
+#    with remote_ip=172.16.1.100 and others.
 # 3) Outer tunnel header is prepended and route the packet to veth1's egress
 # 4) veth0's ingress queue receive the tunneled packet at namespace at_ns0
 # 5) Tunnel protocol handler, ex: vxlan_rcv, decap the packet
-- 
2.24.3 (Apple Git-128)

