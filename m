Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C343643C6F
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 05:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLFEkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 23:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiLFEja (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 23:39:30 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124F2717A
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 20:39:12 -0800 (PST)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B64aZuW012528;
        Tue, 6 Dec 2022 04:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id; s=S1;
 bh=l+PlveErNgHq0DSbEl7ni0TSU9l54Ed6U4IjPimZkoY=;
 b=eMMGa//4TTu1CfXUAtZ96HOmNo2RlXWQIlmEQ7I5p6bfKfXlwybr0mhDEqEu3pIEWa02
 Q1860bj493hdkWc2+sz6gtouPeICTf+hc7AyYunN4VwISqY0ITnlTuHzDal6LO1h9xtV
 H2ZuXNw8uVyNMxZfrEuaZo8+joKFUC906Tz8DtCmZHvSo+x9QAH6Yzi3GkOppoArgcUv
 825qqOLkLYyKZXpZkcNUB2DgCOEbXXpMfHDF2oiSoAq18/Pdh9ZAaOjiIHYrFpKEaHkL
 y59ZXW+FgFAsnUHGGge4XmOAlh1C3xek88jTje9HBagqZan6iL5r3LIRnQy20F7yZNpI cQ== 
Received: from usculxsntmt02v.am.sony.com (usculxsntmt02v.am.sony.com [160.33.194.234])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3m7ybgjfe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 06 Dec 2022 04:39:10 +0000
Received: from pps.filterd (USCULXSNTMT02v.am.sony.com [127.0.0.1])
        by USCULXSNTMT02v.am.sony.com (8.17.1.5/8.17.1.5) with ESMTP id 2B647voT009703;
        Tue, 6 Dec 2022 04:39:09 GMT
Received: from usculxsnt11v.am.sony.com ([146.215.230.185])
        by USCULXSNTMT02v.am.sony.com (PPS) with ESMTPS id 3m7x99xxcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 04:39:09 +0000
Received: from pps.filterd (USCULXSNT11v.am.sony.com [127.0.0.1])
        by USCULXSNT11v.am.sony.com (8.17.1.5/8.17.1.5) with ESMTP id 2B64cmFB006018;
        Tue, 6 Dec 2022 04:39:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by USCULXSNT11v.am.sony.com (PPS) with ESMTPS id 3m7wqfu8sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 06 Dec 2022 04:39:08 +0000
Received: from USCULXSNT11v.am.sony.com (USCULXSNT11v.am.sony.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B64d8QE006289;
        Tue, 6 Dec 2022 04:39:08 GMT
Received: from prime ([10.10.10.214])
        by USCULXSNT11v.am.sony.com (PPS) with ESMTP id 3m7wqfu8sk-1;
        Tue, 06 Dec 2022 04:39:08 +0000
From:   Chethan Suresh <chethan.suresh@sony.com>
To:     quentin@isovalent.com, bpf@vger.kernel.org
Cc:     Chethan Suresh <chethan.suresh@sony.com>,
        Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH bpf-next] bpftool: fix output for skipping kernel config check
Date:   Tue,  6 Dec 2022 10:05:01 +0530
Message-Id: <20221206043501.5249-1-chethan.suresh@sony.com>
X-Mailer: git-send-email 2.17.1
X-Sony-BusinessRelay-GUID: vl9C1-C1e1U7Pcb2vUX473moGVYLBRwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_03,2022-12-05_01,2022-06-22_01
X-Sony-EdgeRelay-GUID: 7kg1oUTmd9bAfgwHGNTcqys6nc7OVy-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_03,2022-12-05_01,2022-06-22_01
X-Proofpoint-GUID: R_M8IfoP5XWQjgN3yvDUh64i7acd_qe_
X-Proofpoint-ORIG-GUID: R_M8IfoP5XWQjgN3yvDUh64i7acd_qe_
X-Sony-Outbound-GUID: R_M8IfoP5XWQjgN3yvDUh64i7acd_qe_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_03,2022-12-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When bpftool feature does not find kernel config files
under default path, do not output CONFIG_XYZ is not set.
Skip kernel config check and continue.

Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 tools/bpf/bpftool/feature.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 36cf0f1517c9..316c4a01bdb7 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -487,14 +487,14 @@ static void probe_kernel_image_config(const char *define_prefix)
 	}
 
 end_parse:
-	if (file)
+	if (file) {
 		gzclose(file);
-
-	for (i = 0; i < ARRAY_SIZE(options); i++) {
-		if (define_prefix && !options[i].macro_dump)
-			continue;
-		print_kernel_option(options[i].name, values[i], define_prefix);
-		free(values[i]);
+		for (i = 0; i < ARRAY_SIZE(options); i++) {
+			if (define_prefix && !options[i].macro_dump)
+				continue;
+			print_kernel_option(options[i].name, values[i], define_prefix);
+			free(values[i]);
+		}
 	}
 }
 
-- 
2.17.1

