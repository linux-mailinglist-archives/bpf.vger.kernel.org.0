Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F446B2596
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 14:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCINjI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 08:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCINjG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 08:39:06 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C9EBDA5
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 05:39:02 -0800 (PST)
Received: from weisslap.aisec.fraunhofer.de ([31.19.218.61]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8yso-1pgL1d474Y-006BBl; Thu, 09 Mar 2023 14:38:56 +0100
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH] bpf: fixed a typo for BPF_F_ANY_ALIGNMENT in bpf.h
Date:   Thu,  9 Mar 2023 14:38:23 +0100
Message-Id: <20230309133823.944097-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OwPUTMbFkkqej/qjOCpUVaTP3/ezv1+3ApnnuUX0WtRSMCh3kqL
 Mzir1ju7Ldot2wOvxbSKw0VQc0qqu0gUVpRsuvaBBDmNQpToYPeRK6fq/duOE/5rGucgYYt
 m2+pJuIOh9Kn9h2YfaTgGP2duyPxsnlCRSs86UwogiUgCSAXJLJJHT0u4asToo4N/8mMtOo
 HNRLDq3KHR/EGOumUWlpg==
UI-OutboundReport: notjunk:1;M01:P0:D6ZYJ42J57E=;Bc8OofrdmvXj+a1mfvoRAykE1+k
 W5LzfRLD5I50C+qwrvzKCK1FMjFgxnEWtm95UrJlIjsisC8zMCe3+Q2ETsGHoh7mIxp/CnUIi
 j6GCaheFymSbdUB968lOevj2Dd0SX+Izb/Z3PpJg5Ho54wf4kx/2EI2Xfz7NdCIYR/f2iCclo
 j3KPH2Ofdz11Hi4LJAzA0ekzt2dp4MmiASOINm6QpBDYAPh7hLn7EuKe5M+dQzl4V5e8D4cd4
 I28aDcorsLeZxQCx6jt41hhJAwKu7LV7HkA2DPcxX1AJdwZ3g+yE8E8QWK8D3AE7aggubPxCa
 Hro3tiMye0d7bmj1EAOOrJdUUMI9zTBqZBQXBuslttL1IwAM+gMMfvtfWRSBCeFEsXbuEwNt7
 3oy6afqPd7o/L+XNQyS0wcpj9F/rXgGwgq0KyjNDe8kddfmhcuOT68eYN4TPv1h13jtbRgwlH
 ra/ZzOza3T1JmDJpQF+K3+cattGD7+JjZlMDnwRpK7I2PNuVWoy07Z6tSGOL56WjUcScual2o
 0YBga1Q9zf7MX2X0c0vOJj2ZIXlkVxYJ4sbJCXzU7x8xynwH0eaal0M2QhERlEqmBEY//6FvI
 t/6sqP+TPMSEdodouKaPKREZh158jBOluCFe01tmiOZW+OUdqQ4VvamUhb5is+m2p8mBwMqHa
 Ht746lDiN7DhP4AwGPejX1wL9ESHh9yd/4piZzVTUg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixed s/BPF_PROF_LOAD/BPF_PROG_LOAD/ typo in the documentation
comment for BPF_F_ANY_ALIGNMENT in bpf.h.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62ce1f5d1b1d..2d9ce243521b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1108,7 +1108,7 @@ enum bpf_link_type {
  */
 #define BPF_F_STRICT_ALIGNMENT	(1U << 0)
 
-/* If BPF_F_ANY_ALIGNMENT is used in BPF_PROF_LOAD command, the
+/* If BPF_F_ANY_ALIGNMENT is used in BPF_PROG_LOAD command, the
  * verifier will allow any alignment whatsoever.  On platforms
  * with strict alignment requirements for loads ands stores (such
  * as sparc and mips) the verifier validates that all loads and
-- 
2.30.2

