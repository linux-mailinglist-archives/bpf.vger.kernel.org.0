Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AFE52D5F6
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiESO0M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbiESO0J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 10:26:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277CF2C138
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 07:26:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JD9gaJ012703;
        Thu, 19 May 2022 14:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=gAR0QmbXIn7tpf6gqvOgu07JYgo3MRKtxYwrtyHW70Q=;
 b=YUCe0hOFhFb8fusIQVbt7ALm9HC+yjx58CiNJZ/PtdfrV8mT4vyX93PmDJMaqSRm31cQ
 SsmPxFHdiVUt++5P05hKaXqTuok2XSEpY+nyZYf7PmES/BOXpJD5QjZp0plqO8IlXgma
 4Bf4C4fgNva2fQbTnhqIJ+PZEQxCqmzZUZOfE9c9ydHINv1SmnrZAe1EgzruMABp4YPC
 FmZ34tnxfa8VOLlNnZHZYd65Ju6CxNqH2kEQJC0pefxyWS/r4mfR+i0iR4BYa67i+n7O
 P8atQvsVoRQ4twzmt0EYzLnDXW5XnkF52sH9ihnsqCV7Qu9IN7y84q9TaIcNlV06tCWA jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aam3td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 14:25:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JEP6oq011269;
        Thu, 19 May 2022 14:25:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v5c5hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 14:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3MhREM4zSnt78CrDWLMPS18qBxLGvDuZYERJGpj9Lc925PQ+fLg+q7j04/cGG7sr3Ph3wCiQoei08zo0I9jzog2SEpzQqdvu96R1MGzWriUjeExMd2tneBXiDmHEb2gCNPVyHq56aGNqmKL5nXi+DJqNY+GUPtEi0VeK4NCPWKe4eKVB54gVwFFH+q5iMCRg+WsVQma4kmpNa2oYyLaBujmL9YoJvWSYlr/losj5M2YyV5yOIVCPvzUFMhVMPFjxPJD9jZEZpyHaUiDcCXjaJtKSxnSYphVDku+0myh0ll7eohO+57hsgnG7uZDR4EVH2bA82RbIsR+HgqQQQ+zeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAR0QmbXIn7tpf6gqvOgu07JYgo3MRKtxYwrtyHW70Q=;
 b=CSIU+1SOXgK+btqFQExADykAdImdtLDpaZSOVKKQOtbtlChpL3Eh41EV96VjBghVRH6lMMEFCb7JjK77RaAgPlJYA6KIIstXilgc+KxFznO/Co2cU8MSHsVaNz/AwKx+pr91nPCcVnZwk9CMwHJW3HIKygPhC8qtPGubWeFB7NPL7QG4HrGH+7thbITCa5OyICrwmggmdb2jyluZqRv3uAKnVK5W4Xlo56cxaJ1tYOIuleVyFSqNqU0aKtTUNDXhaCaqphKKGQcbH4GmgKHiv99XLT84kgiKtTCK1C5/s0rsrMTmVGpIHMdC+2q7W0pCMSGA0BjZ0z3LQy8sGY+mlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAR0QmbXIn7tpf6gqvOgu07JYgo3MRKtxYwrtyHW70Q=;
 b=JO1uqJywXIpZto8Pw2fXY54+0x8akl116axk2FbkKFYM1ETljOx+ijTnFx77ZTgPoDSfK/zaf7bhT99h1iDioR44kxkheCYm9/JmIbO6DqSLWazRtDJObBnGL58uPefkmD7OBBRdjdlNegTe23uyHmUgOvIgv3R5hx8iMi2d9fY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN8PR10MB3588.namprd10.prod.outlook.com (2603:10b6:408:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 14:25:43 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 14:25:43 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 2/2] selftests/bpf: add tests verifying unprivileged bpf behaviour
Date:   Thu, 19 May 2022 15:25:34 +0100
Message-Id: <1652970334-30510-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652970334-30510-1-git-send-email-alan.maguire@oracle.com>
References: <1652970334-30510-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5f5801a-2300-42f0-16bf-08da39a374f3
X-MS-TrafficTypeDiagnostic: BN8PR10MB3588:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3588D4CD30C55B83A16B81F2EFD09@BN8PR10MB3588.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHxJ1YFY2vjxaJVmavlykikAAHueIQwVrJdx0Hx4SisjSglRffZuz8ghqcruabX6yiM+Ut/QCPXZ9/S5IgOSNdkvCD4ytyqz/vi9/oUQyun3Hpfjfc4oeSCekGtGcDHlAc9Sk4UaLYDfxU7i9IDJ6yIwek0n+8tqK/On1Q9yOd3nvIDdOIVbHlcoxeQQhjLvIfF4SyyVzWBUeh0hSUTLQT3YTqxiKR3uEtEAuheDy6Y80IpTHtyMaHES+zAPxQEXVDx1aitidWyw4VNCcMSAk/5cpYsDR9DLbrkHqPLGQ0zgULj/pRKCZJA4nGtBTeMvoqGeG8vRfY/BYlWyclPiQsyNC0vM6VrF/pSrM+60CWTwgJyX3j2NY1tv+VBZ6ih4je5GpC6djFQ2yb/KNH0l8frwGdc3fukO9BbBrd10rf4KMA+Fu3eqrLq8XUXpPWwBtu8oYBesIT8Mv717MaGmbcdYhZ7ixbFp3FEqu6MSEo7H/N3OHwZX8Jj9RKVArrYnJqnE5g4vVelUXlZ8AQmzoQLTe5Qdtv6gQ4jdqC0PI329IYwG+GjssQp7NVW9sHf5sOpE+3MuyDP7NuE7LZsVQyZlB7+vnGojZONF1yk8Q8mhw0oOP4hH598UY62aNq1VN9e6YDPWc72drv2JmKzRs34di0oodO7xcWIWU8MBR/EToJxi3Ir9q0WfoFI15zw8aq9eE/dmYR6+9XntQTaH5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66946007)(66476007)(36756003)(8936002)(66556008)(2616005)(6506007)(107886003)(7416002)(30864003)(83380400001)(44832011)(26005)(38350700002)(6512007)(186003)(38100700002)(4326008)(8676002)(316002)(508600001)(52116002)(15650500001)(6486002)(2906002)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BNy3jt1sl6/jOnQmzpH+0xie8HVOjhmYoCNIxxEC51smxed2H5MzvffJoz2V?=
 =?us-ascii?Q?qoOHe5G6B9MG5TVYBuRL5V+caterOC0DQs8WdBEEpyrB9InCHAeClVZEsBM1?=
 =?us-ascii?Q?5d+bhO7BRBfzOyHjIwnbfZm/039GaJ6lr6X2Z+ElaqZv6e21BnBAxcIl34E9?=
 =?us-ascii?Q?g14mkTeQpUmxLp2BMfiv+0NXKquhSN/i1pHmhy+/UdJGOoTVaSTD45aTbxZw?=
 =?us-ascii?Q?UYzvKG+0yYL4xfBWdBn1MzHz26N/ChwPuPDNYRc7W5oS6Hj7DOmhaIfckgWn?=
 =?us-ascii?Q?Iss2J5weCLyQQX1Ty9JDJjbZpf//HP5RRIgrzJ+F/FHMs51FEpwQyeqII5KY?=
 =?us-ascii?Q?DDaCBpJ9ZS5iAVBHl+ZOc0e6hzqfsj2GKtXpcOE+TTyphO2M7n1mXSviMuA8?=
 =?us-ascii?Q?t9OQzkWtUKh8mzyIYlpgxVaEKcyQ+omoV1kfq+hyEXhBU7ZBIBoIsQCiBVer?=
 =?us-ascii?Q?aVdd0jXFm/Y1QS/CCLXmC3Hib6BR/r765pRufI0bMKKXuuQAujM3s2TpaS59?=
 =?us-ascii?Q?VT8d1yUL9zhbFlWl1QPOIF7xuPd0oit7URiop808CUy4y/M6atnIPY6IQbmL?=
 =?us-ascii?Q?/9W5xXyl35h8qiBnXsvetnNE1y+U8GWmlQG9Uc6R+OivN81UfpIKHybPomVh?=
 =?us-ascii?Q?xow4h7i1L1KEQsk0yqjYzR4dV+vcOc/yUOa/Zvf3NCswgg80dwkelI+6zH3E?=
 =?us-ascii?Q?omJQBhuZZQk9qkyR8ZE4Hf5wrqzZ0tgxPbZSeMqCuBT7d5d4kfWxQfpMFUao?=
 =?us-ascii?Q?dlnldjWl6WwkF1n+ow38/IYQCDe9WHgbAqt3Q0xjkg7o+1J2RqjFpsTI37lm?=
 =?us-ascii?Q?3fmYXmgmpWxmiT70o6Q9XYd8hjQ0j1VNQzEf8SpgkQ/rptSOBL9fwpuueWeJ?=
 =?us-ascii?Q?lCa/gxNzZuJ5frMA5+et3nxUXGzyp9qXkvXi2ufFBgGwPvWmjKLr5xzt/rhh?=
 =?us-ascii?Q?bs5wShpYM1M3ludLzOpVnvGmFFRU6+augaW6H4wJj6ww0g1w1gDZ+kNwFwDw?=
 =?us-ascii?Q?HMs2qDoUBa53BvkHKlK/o8kU0Ly6/i3R6M37iIu0ZV+15S54Gwl6ElHwb0Tc?=
 =?us-ascii?Q?0N1PPyEJQdwGi1hkK7OtDPJSL0iA7WDAoVc1jMiwETUWfoQEOtp1z1WhcLru?=
 =?us-ascii?Q?sXJW0w7bN2wbssamzik1J6XUSlPO6VDbZQpTGNvryfediaYACXknnuLs605f?=
 =?us-ascii?Q?ArwUSOW69cLQkOpF9381OOZ1KGur+MZ1tC/bTZva3OljrX6GDQSbyfHUCdL1?=
 =?us-ascii?Q?jB+qD2TN+3RokEbLbFh0rBW2/g1lnhw+313jFuMC02c4hbgBUNCMuH5NguRU?=
 =?us-ascii?Q?/wNOgUXv4NcXf9R/y4/MoAwbN0Woqsn/ZJUXmdbnTXsqwySd3DAT8rosmu0n?=
 =?us-ascii?Q?dBffUFuadROuubyI2XCFMjBgfep/B4pzaEZ5BAYM0OaTFKR5dKFbxui8H+9q?=
 =?us-ascii?Q?bVuNU2+rOCSHO46EoG1GidI07P7q5D2DLkxFfbQl7cVFKBb/htrKdJghS9GZ?=
 =?us-ascii?Q?mW5ESReKT2rYwSgx84/J1BBXR52DdTlbMHyO7J5/bQ7FqBHmHXAtfykRpfVz?=
 =?us-ascii?Q?xge4c91YHljCXOfkfMGRFV2GK3LelKWv74LCVxfV0LwPgvWM8c5tEHH23/Rs?=
 =?us-ascii?Q?zv6pacNvErwmq0l6EvyOeWwsLhTWfxTs2wdyNUloIkKSeW3OpayYrj/9HBdA?=
 =?us-ascii?Q?xsiaS3FNxfShX+3X9mvoA5+6I6DNPhuf1EuAU4i74WmeXxAqFQqJ18xaOBwm?=
 =?us-ascii?Q?YVIY4RhVy7FTTVjWafm8lHM6yd7CXl4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f5801a-2300-42f0-16bf-08da39a374f3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 14:25:43.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGOYCGdPCnguPoj9T5PqB1jnUa/tAYQDRB1hb2veaz3+usgMEANjdi8xVCT2ZSF3bzKClVTsqR6h3D8yPy299Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3588
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_04:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190085
X-Proofpoint-ORIG-GUID: f1wzb9XCVXX2CxRPJhAlX7-IUAgiTduG
X-Proofpoint-GUID: f1wzb9XCVXX2CxRPJhAlX7-IUAgiTduG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tests load/attach bpf prog with maps, perfbuf and ringbuf, pinning
them.  Then effective caps are dropped and we verify we can

- pick up the pin
- create ringbuf/perfbuf
- get ringbuf/perfbuf events, carry out map update, lookup and delete
- create a link

Negative testing also ensures

- BPF prog load fails
- BPF map create fails
- get fd by id fails
- get next id fails
- query fails
- BTF load fails

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/prog_tests/unpriv_bpf_disabled.c      | 312 ++++++++++++++++++
 .../bpf/progs/test_unpriv_bpf_disabled.c      |  83 +++++
 2 files changed, 395 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c

diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
new file mode 100644
index 000000000000..9149796bcd6d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "test_unpriv_bpf_disabled.skel.h"
+
+#include "cap_helpers.h"
+
+/* Using CAP_LAST_CAP is risky here, since it can get pulled in from
+ * an old /usr/include/linux/capability.h and be < CAP_BPF; as a result
+ * CAP_BPF would not be included in ALL_CAPS.  Instead use CAP_BPF as
+ * we know its value is correct since it is explicitly defined in
+ * cap_helpers.h.
+ */
+#define ALL_CAPS	((2ULL << CAP_BPF) - 1)
+
+#define PINPATH		"/sys/fs/bpf/unpriv_bpf_disabled_"
+#define NUM_MAPS	7
+
+static __u32 got_perfbuf_val;
+static __u32 got_ringbuf_val;
+
+static int process_ringbuf(void *ctx, void *data, size_t len)
+{
+	if (ASSERT_EQ(len, sizeof(__u32), "ringbuf_size_valid"))
+		got_ringbuf_val = *(__u32 *)data;
+	return 0;
+}
+
+static void process_perfbuf(void *ctx, int cpu, void *data, __u32 len)
+{
+	if (ASSERT_EQ(len, sizeof(__u32), "perfbuf_size_valid"))
+		got_perfbuf_val = *(__u32 *)data;
+}
+
+static int sysctl_set(const char *sysctl_path, char *old_val, const char *new_val)
+{
+	int ret = 0;
+	FILE *fp;
+
+	fp = fopen(sysctl_path, "r+");
+	if (!fp)
+		return -errno;
+	if (old_val && fscanf(fp, "%s", old_val) <= 0) {
+		ret = -ENOENT;
+	} else if (!old_val || strcmp(old_val, new_val) != 0) {
+		fseek(fp, 0, SEEK_SET);
+		if (fprintf(fp, "%s", new_val) < 0)
+			ret = -errno;
+	}
+	fclose(fp);
+
+	return ret;
+}
+
+static void test_unpriv_bpf_disabled_positive(struct test_unpriv_bpf_disabled *skel,
+					      __u32 prog_id, int prog_fd, int perf_fd,
+					      char **map_paths, int *map_fds)
+{
+	struct perf_buffer *perfbuf = NULL;
+	struct ring_buffer *ringbuf = NULL;
+	int i, nr_cpus, link_fd = -1;
+
+	nr_cpus = bpf_num_possible_cpus();
+
+	skel->bss->perfbuf_val = 1;
+	skel->bss->ringbuf_val = 2;
+
+	/* Positive tests for unprivileged BPF disabled. Verify we can
+	 * - retrieve and interact with pinned maps;
+	 * - set up and interact with perf buffer;
+	 * - set up and interact with ring buffer;
+	 * - create a link
+	 */
+	perfbuf = perf_buffer__new(bpf_map__fd(skel->maps.perfbuf), 8, process_perfbuf, NULL, NULL,
+				   NULL);
+	if (!ASSERT_OK_PTR(perfbuf, "perf_buffer__new"))
+		goto cleanup;
+
+	ringbuf = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf), process_ringbuf, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup;
+
+	/* trigger & validate perf event, ringbuf output */
+	usleep(1);
+
+	ASSERT_GT(perf_buffer__poll(perfbuf, 100), -1, "perf_buffer__poll");
+	ASSERT_EQ(got_perfbuf_val, skel->bss->perfbuf_val, "check_perfbuf_val");
+	ASSERT_EQ(ring_buffer__consume(ringbuf), 1, "ring_buffer__consume");
+	ASSERT_EQ(got_ringbuf_val, skel->bss->ringbuf_val, "check_ringbuf_val");
+
+	for (i = 0; i < NUM_MAPS; i++) {
+		map_fds[i] = bpf_obj_get(map_paths[i]);
+		if (!ASSERT_GT(map_fds[i], -1, "obj_get"))
+			goto cleanup;
+	}
+
+	for (i = 0; i < NUM_MAPS; i++) {
+		bool prog_array = strstr(map_paths[i], "prog_array") != NULL;
+		bool array = strstr(map_paths[i], "array") != NULL;
+		bool buf = strstr(map_paths[i], "buf") != NULL;
+		__u32 key = 0, vals[nr_cpus], lookup_vals[nr_cpus];
+		__u32 expected_val = 1;
+		int j;
+
+		/* skip ringbuf, perfbuf */
+		if (buf)
+			continue;
+
+		for (j = 0; j < nr_cpus; j++)
+			vals[j] = expected_val;
+
+		if (prog_array) {
+			/* need valid prog array value */
+			vals[0] = prog_fd;
+			/* prog array lookup returns prog id, not fd */
+			expected_val = prog_id;
+		}
+		ASSERT_OK(bpf_map_update_elem(map_fds[i], &key, vals, 0), "map_update_elem");
+		ASSERT_OK(bpf_map_lookup_elem(map_fds[i], &key, &lookup_vals), "map_lookup_elem");
+		ASSERT_EQ(lookup_vals[0], expected_val, "map_lookup_elem_values");
+		if (!array)
+			ASSERT_OK(bpf_map_delete_elem(map_fds[i], &key), "map_delete_elem");
+	}
+
+	link_fd = bpf_link_create(bpf_program__fd(skel->progs.handle_perf_event), perf_fd,
+				  BPF_PERF_EVENT, NULL);
+	ASSERT_GT(link_fd, 0, "link_create");
+
+cleanup:
+	if (link_fd)
+		close(link_fd);
+	if (perfbuf)
+		perf_buffer__free(perfbuf);
+	if (ringbuf)
+		ring_buffer__free(ringbuf);
+}
+
+static void test_unpriv_bpf_disabled_negative(struct test_unpriv_bpf_disabled *skel,
+					      __u32 prog_id, int prog_fd, int perf_fd,
+					      char **map_paths, int *map_fds)
+{
+	const struct bpf_insn prog_insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	const size_t prog_insn_cnt = sizeof(prog_insns) / sizeof(struct bpf_insn);
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts);
+	struct bpf_map_info map_info = {};
+	__u32 map_info_len = sizeof(map_info);
+	struct bpf_link_info link_info = {};
+	__u32 link_info_len = sizeof(link_info);
+	struct btf *btf = NULL;
+	__u32 attach_flags = 0;
+	__u32 prog_ids[3] = {};
+	__u32 prog_cnt = 3;
+	__u32 next;
+	int i;
+
+	/* Negative tests for unprivileged BPF disabled.  Verify we cannot
+	 * - load BPF programs;
+	 * - create BPF maps;
+	 * - get a prog/map/link fd by id;
+	 * - get next prog/map/link id
+	 * - query prog
+	 * - BTF load
+	 */
+	ASSERT_EQ(bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "simple_prog", "GPL",
+				prog_insns, prog_insn_cnt, &load_opts),
+		  -EPERM, "prog_load_fails");
+
+	for (i = BPF_MAP_TYPE_HASH; i <= BPF_MAP_TYPE_BLOOM_FILTER; i++)
+		ASSERT_EQ(bpf_map_create(i, NULL, sizeof(int), sizeof(int), 1, NULL),
+			  -EPERM, "map_create_fails");
+
+	ASSERT_EQ(bpf_prog_get_fd_by_id(prog_id), -EPERM, "prog_get_fd_by_id_fails");
+	ASSERT_EQ(bpf_prog_get_next_id(prog_id, &next), -EPERM, "prog_get_next_id_fails");
+	ASSERT_EQ(bpf_prog_get_next_id(0, &next), -EPERM, "prog_get_next_id_fails");
+
+	if (ASSERT_OK(bpf_obj_get_info_by_fd(map_fds[0], &map_info, &map_info_len),
+		      "obj_get_info_by_fd")) {
+		ASSERT_EQ(bpf_map_get_fd_by_id(map_info.id), -EPERM, "map_get_fd_by_id_fails");
+		ASSERT_EQ(bpf_map_get_next_id(map_info.id, &next), -EPERM,
+			  "map_get_next_id_fails");
+	}
+	ASSERT_EQ(bpf_map_get_next_id(0, &next), -EPERM, "map_get_next_id_fails");
+
+	if (ASSERT_OK(bpf_obj_get_info_by_fd(bpf_link__fd(skel->links.sys_nanosleep_enter),
+					     &link_info, &link_info_len),
+		      "obj_get_info_by_fd")) {
+		ASSERT_EQ(bpf_link_get_fd_by_id(link_info.id), -EPERM, "link_get_fd_by_id_fails");
+		ASSERT_EQ(bpf_link_get_next_id(link_info.id, &next), -EPERM,
+			  "link_get_next_id_fails");
+	}
+	ASSERT_EQ(bpf_link_get_next_id(0, &next), -EPERM, "link_get_next_id_fails");
+
+	ASSERT_EQ(bpf_prog_query(prog_fd, BPF_TRACE_FENTRY, 0, &attach_flags, prog_ids,
+				 &prog_cnt), -EPERM, "prog_query_fails");
+
+	btf = btf__new_empty();
+	if (ASSERT_OK_PTR(btf, "empty_btf") &&
+	    ASSERT_GT(btf__add_int(btf, "int", 4, 0), 0, "unpriv_int_type")) {
+		const void *raw_btf_data;
+		__u32 raw_btf_size;
+
+		raw_btf_data = btf__raw_data(btf, &raw_btf_size);
+		if (ASSERT_OK_PTR(raw_btf_data, "raw_btf_data_good"))
+			ASSERT_EQ(bpf_btf_load(raw_btf_data, raw_btf_size, NULL), -EPERM,
+				  "bpf_btf_load_fails");
+	}
+	btf__free(btf);
+}
+
+void test_unpriv_bpf_disabled(void)
+{
+	char *map_paths[NUM_MAPS] = {	PINPATH	"array",
+					PINPATH "percpu_array",
+					PINPATH "hash",
+					PINPATH "percpu_hash",
+					PINPATH "perfbuf",
+					PINPATH "ringbuf",
+					PINPATH "prog_array" };
+	int map_fds[NUM_MAPS];
+	struct test_unpriv_bpf_disabled *skel;
+	char unprivileged_bpf_disabled_orig[32] = {};
+	char perf_event_paranoid_orig[32] = {};
+	struct bpf_prog_info prog_info = {};
+	__u32 prog_info_len = sizeof(prog_info);
+	struct perf_event_attr attr = {};
+	int prog_fd, perf_fd, i, ret;
+	__u64 save_caps = 0;
+	__u32 prog_id;
+
+	skel = test_unpriv_bpf_disabled__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->test_pid = getpid();
+
+	map_fds[0] = bpf_map__fd(skel->maps.array);
+	map_fds[1] = bpf_map__fd(skel->maps.percpu_array);
+	map_fds[2] = bpf_map__fd(skel->maps.hash);
+	map_fds[3] = bpf_map__fd(skel->maps.percpu_hash);
+	map_fds[4] = bpf_map__fd(skel->maps.perfbuf);
+	map_fds[5] = bpf_map__fd(skel->maps.ringbuf);
+	map_fds[6] = bpf_map__fd(skel->maps.prog_array);
+
+	for (i = 0; i < NUM_MAPS; i++)
+		ASSERT_OK(bpf_obj_pin(map_fds[i], map_paths[i]), "pin map_fd");
+
+	/* allow user without caps to use perf events */
+	if (!ASSERT_OK(sysctl_set("/proc/sys/kernel/perf_event_paranoid", perf_event_paranoid_orig,
+				  "-1"),
+		       "set_perf_event_paranoid"))
+		goto cleanup;
+	/* ensure unprivileged bpf disabled is set */
+	ret = sysctl_set("/proc/sys/kernel/unprivileged_bpf_disabled",
+			 unprivileged_bpf_disabled_orig, "2");
+	if (ret == -EPERM) {
+		/* if unprivileged_bpf_disabled=1, we get -EPERM back; that's okay. */
+		if (!ASSERT_OK(strcmp(unprivileged_bpf_disabled_orig, "1"),
+			       "unpriviliged_bpf_disabled_on"))
+			goto cleanup;
+	} else {
+		if (!ASSERT_OK(ret, "set unpriviliged_bpf_disabled"))
+			goto cleanup;
+	}
+
+	prog_fd = bpf_program__fd(skel->progs.sys_nanosleep_enter);
+	ASSERT_OK(bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len),
+		  "obj_get_info_by_fd");
+	prog_id = prog_info.id;
+	ASSERT_GT(prog_id, 0, "valid_prog_id");
+
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_CPU_CLOCK;
+	attr.freq = 1;
+	attr.sample_freq = 1000;
+	perf_fd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+	if (!ASSERT_GE(perf_fd, 0, "perf_fd"))
+		goto cleanup;
+
+	if (!ASSERT_OK(test_unpriv_bpf_disabled__attach(skel), "skel_attach"))
+		goto cleanup;
+
+	if (!ASSERT_OK(cap_disable_effective(ALL_CAPS, &save_caps), "disable caps"))
+		goto cleanup;
+
+	if (test__start_subtest("unpriv_bpf_disabled_positive"))
+		test_unpriv_bpf_disabled_positive(skel, prog_id, prog_fd, perf_fd, map_paths,
+						  map_fds);
+
+	if (test__start_subtest("unpriv_bpf_disabled_negative"))
+		test_unpriv_bpf_disabled_negative(skel, prog_id, prog_fd, perf_fd, map_paths,
+						  map_fds);
+
+cleanup:
+	close(perf_fd);
+	if (save_caps)
+		cap_enable_effective(save_caps, NULL);
+	if (strlen(perf_event_paranoid_orig) > 0)
+		sysctl_set("/proc/sys/kernel/perf_event_paranoid", NULL, perf_event_paranoid_orig);
+	if (strlen(unprivileged_bpf_disabled_orig) > 0)
+		sysctl_set("/proc/sys/kernel/unprivileged_bpf_disabled", NULL,
+			   unprivileged_bpf_disabled_orig);
+	for (i = 0; i < NUM_MAPS; i++)
+		unlink(map_paths[i]);
+	test_unpriv_bpf_disabled__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c
new file mode 100644
index 000000000000..fc423e43a3cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+__u32 perfbuf_val = 0;
+__u32 ringbuf_val = 0;
+
+int test_pid;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} percpu_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} percpu_hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+} perfbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 1 << 12);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int sys_nanosleep_enter(void *ctx)
+{
+	int cur_pid;
+
+	cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (cur_pid != test_pid)
+		return 0;
+
+	bpf_perf_event_output(ctx, &perfbuf, BPF_F_CURRENT_CPU, &perfbuf_val, sizeof(perfbuf_val));
+	bpf_ringbuf_output(&ringbuf, &ringbuf_val, sizeof(ringbuf_val), 0);
+
+	return 0;
+}
+
+SEC("perf_event")
+int handle_perf_event(void *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.27.0

