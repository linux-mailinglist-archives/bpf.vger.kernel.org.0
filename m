Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B8F661C63
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 03:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjAICiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 Jan 2023 21:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjAICiT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Jan 2023 21:38:19 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A1A47C
        for <bpf@vger.kernel.org>; Sun,  8 Jan 2023 18:38:17 -0800 (PST)
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3092RW4A007786;
        Mon, 9 Jan 2023 02:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id; s=S1;
 bh=edY/tm2eSq9U5R0UYbDIP3xu66fP1v8wrJ7S/xD/irU=;
 b=ikRu7Hn5R2EDk8TsSccBboSQtWqxzyJFnlTnBx8hqc+eJe8ZY2i51dEJcbh+aiBJLPGq
 phqmBnTkyvd+Sh37Bm/qD/JxgGW3MVZYmgdP/wcRzwHaKis+Eayh2iY64/jmgibYCKM1
 OUzId0wmkqGWTQsPrMQkzcC+yyLh99+XGSQH2L35udJRh0Nb/dSDag9azYtcRIeighxO
 B7bhG5FpoKL8hVy1ethOFm9HEyVb1bxCGmwpnlue9XrDVsqLKvwLL/Raak/9RCDW/9Gy
 56BWXI+d2vpEjMc2CznqhyAQ2cYB3TkRjalP4aFMPSbWitoW002YG4CzmCehTM473Jbj Xg== 
Received: from usculxsntmt02v.am.sony.com ([160.33.194.234])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3my1wm94mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 09 Jan 2023 02:38:15 +0000
Received: from pps.filterd (USCULXSNTMT02v.am.sony.com [127.0.0.1])
        by USCULXSNTMT02v.am.sony.com (8.17.1.5/8.17.1.5) with ESMTP id 3092GaCF007513;
        Mon, 9 Jan 2023 02:38:04 GMT
Received: from usculxsntmt01v.am.sony.com ([146.215.230.189])
        by USCULXSNTMT02v.am.sony.com (PPS) with ESMTPS id 3my0j9s7q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 02:38:04 +0000
Received: from pps.filterd (USCULXSNTMT01v.am.sony.com [127.0.0.1])
        by USCULXSNTMT01v.am.sony.com (8.17.1.5/8.17.1.5) with ESMTP id 3092UgJ8028485;
        Mon, 9 Jan 2023 02:38:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by USCULXSNTMT01v.am.sony.com (PPS) with ESMTPS id 3my0jdwmya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 09 Jan 2023 02:38:04 +0000
Received: from USCULXSNTMT01v.am.sony.com (USCULXSNTMT01v.am.sony.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3092c3gf010326;
        Mon, 9 Jan 2023 02:38:03 GMT
Received: from prime ([10.10.10.214])
        by USCULXSNTMT01v.am.sony.com (PPS) with ESMTP id 3my0jdwmy8-1;
        Mon, 09 Jan 2023 02:38:03 +0000
From:   Chethan Suresh <chethan.suresh@sony.com>
To:     quentin@isovalent.com, bpf@vger.kernel.org
Cc:     Chethan Suresh <chethan.suresh@sony.com>,
        Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH bpf-next] bpftool: fix output for skipping kernel config check
Date:   Mon,  9 Jan 2023 08:07:42 +0530
Message-Id: <20230109023742.29657-1-chethan.suresh@sony.com>
X-Mailer: git-send-email 2.17.1
X-Sony-BusinessRelay-GUID: 3JW061EE9ErcP-3lKL4sSVOZUNfpU9gj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Sony-EdgeRelay-GUID: QpJwuOkMZtW-_2N-6ZR68bBSeaXdIDuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-ORIG-GUID: l3so7z6Pw3v6jkdMXfjGPZGg24rLx-07
X-Proofpoint-GUID: l3so7z6Pw3v6jkdMXfjGPZGg24rLx-07
X-Sony-Outbound-GUID: l3so7z6Pw3v6jkdMXfjGPZGg24rLx-07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When bpftool feature does not find kernel config
files under default path or wrong format,
do not output CONFIG_XYZ is not set.
Skip kernel config check and continue.

Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 tools/bpf/bpftool/feature.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 36cf0f1517c9..da16e6a27ccc 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -486,16 +486,16 @@ static void probe_kernel_image_config(const char *define_prefix)
 		}
 	}
 
-end_parse:
-	if (file)
-		gzclose(file);
-
 	for (i = 0; i < ARRAY_SIZE(options); i++) {
 		if (define_prefix && !options[i].macro_dump)
 			continue;
 		print_kernel_option(options[i].name, values[i], define_prefix);
 		free(values[i]);
 	}
+
+end_parse:
+	if (file)
+		gzclose(file);
 }
 
 static bool probe_bpf_syscall(const char *define_prefix)
-- 
2.17.1

