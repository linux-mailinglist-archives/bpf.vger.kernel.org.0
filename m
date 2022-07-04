Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6E5657EB
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiGDN4K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiGDNz5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 09:55:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026A2720;
        Mon,  4 Jul 2022 06:55:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264D1ht8001897;
        Mon, 4 Jul 2022 13:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=pObFwCVo2FoHciZaUaaRdKkaYDoKG+CZ3gSiSK2FBz0=;
 b=iJTVxMp+JW0OxhK0GfoZn8mcHYKwtKLgPHBDurjP5A8bFuvik8rN3HSj2aLJwBTwYJOR
 IAeQr7HvK+1UKtSCYBBCXkLgu1/iHAHWoQDmads477wRuTP1lPws18Ui49RWBCIAptgl
 5MQ2OroIQRrTc8PsczJOAFAoJcjWM+tP3b4P60oTvEtGiLWIqGeTh0sZfGswIfgTqF8b
 3HWhuaomwF8fs4jX3U1KP35CqrdTUNXokeiBbqm8BRka75IvHE/ibQcOU/FCsvuu90OY
 3GtvEWzYbmioKcH8kmZb3S8rq2jRol186RjqIYjNuS4hTE41P7MCKNOkDwjbC3zWUK8T bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2cecbjpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:55:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264DpBDK028675;
        Mon, 4 Jul 2022 13:55:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7qrh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:55:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrL7saNVtMuFMDFgRkTDJtIORntVSVAD4q+NdqedMVFUTRiCb6AbsKgdX8cazb2dB7kDDX69reKMFisIx7b5A+I1O7I10vDsLdmxctoHfISoIHrD7r30ci9lhfOZxAjIDJLPMIYrFYQCPvd9czM/FH+M54Jp1skVir8RgMw91NUibAya0+tfiP13fsnwRGcTH1ZIHjL8Tm+vQMlIltNbxSJnrmzKHNSko/Q2+C5eB0dCvMrU445K38+gTN3w0MDzkAhvzegqKxAl1dYDlGmSrB4sQ++uQn9F6KSeD5vob4+xGohCyvu8ndfBd3t+1dpQPJNYEkCLjzLyFlPUikt5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pObFwCVo2FoHciZaUaaRdKkaYDoKG+CZ3gSiSK2FBz0=;
 b=GA+9iIWd5ihv9ySVFQAzDojOgVgqbIuL7G+7hhMX4C581xgNpy7AtP14DkaTrBYljzc0gaba5IMtFy7nT7Jiss577IkvKugpfHG1Ii+9lF89A3qfbuLR2ORo5VGUunj6F5IKLFxL2o5kWlTiNdiNj/kpkoRoumeUDYd8Cx4KshMdz+Rx170E5GNqbFp5nY68k8Iuw9iEQWEs8xSw2Au8RSwVxjHgObQNtJ8JoDhE/jR6SfOPd6Lf+WpYJf/NVHtSr/vRJtuiekqBrddN4lPGL7mtrmr6jgPVEvWbSI0Cdj7a38RTr7cJWuwsJGXvIOsTDr+bgs1UtmNgBMXmgMrzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pObFwCVo2FoHciZaUaaRdKkaYDoKG+CZ3gSiSK2FBz0=;
 b=O0uTdXTek5uCwe5Aefu5IprLl9cjk5b2Fc/218RykHQgUN0KnKmy3GhQMyvOokDfmk9FhgiJbiarX7vPhC0JRMr21s8GA4Y45ti2jNxJ9kUoDaPa/4FO6b7Hztm++izV4SeNZwx4lXiFhBC2GqtVB+/AGdOkgiX2cvb+zwv10HE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6086.namprd10.prod.outlook.com (2603:10b6:8:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 13:55:29 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e%7]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:55:29 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com
Cc:     kafai@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, void@manifault.com, swboyd@chromium.org,
        ndesaulniers@google.com, 9erthalion6@gmail.com, kennyyu@fb.com,
        geliang.tang@suse.com, kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: add a ksym iter subtest
Date:   Mon,  4 Jul 2022 14:55:16 +0100
Message-Id: <1656942916-13491-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656942916-13491-1-git-send-email-alan.maguire@oracle.com>
References: <1656942916-13491-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 282ae8a2-80fc-419e-c522-08da5dc4da93
X-MS-TrafficTypeDiagnostic: DM4PR10MB6086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDwABjghfOGT0MSmrnVqSoSJW6tySYSJQi20Kjf4cDcDH/KXOG5fl6xtWVbeTTHnUP9iTZKlTVsu2TfQiW0EJUedh+BgPGEXKovX1iTuLr7U2f/aAQWUnz3biuE5j40F6hLAV5mAqoEK+qF1kNlBSYsZ3uXowsSbzgqdMMMEetywYw1pC3gHscJa092/eUTr8xc/ifnjbmJLw5kEnFvRPiwsKUyZzB12/O7LX1TI5zkB0s2EKAxZAJ193+UYmcyzkS2HEwEPUbPgZu0tCeEcpAyAVQvS9DLX7ZRpp3oK2D/To+LwbnWsb2B7aqiu1BOv6a0I0TFj/AUeCct5el1/Bnq+nQzYmsIhTPc9Lj3XhFuBVJHmrgw2M3LABJHwRPooyDWcjHaVi8VkmKt1H2RmyheaIkA8z4a1Z/PP8jo41W9IYrN5IDzts8AUHe5+0KkU5U4y30X0yviCdUQsFTPwuQjymFNVoWnyUaICoytiyE3WekYzjvO+qzynhBCXpBg/GYS7dsCKDPaU3hMB0WfKNcJyVrArcxxRlILUxK2NZZ81J84pOTkGAZmaXfbGm2dvGSMcTi+czhEV41k5wqcjm7WacJmCyuof0trocAGoRkJ9vCzGSrm2WegtufjKGKOq8i+Quz73o3fRgZ5JkrW6to090M3QOClc2YRYvpZhzF1b0IdRyEzxKmHB4xzVyyrxMTUs361w/1RHnyx5Qir06dkrL48fCgCM9p9mc16ULG39fi6pbzZeLjfAj5IgLREAcqkdgMojcPc02jIKHsMyaYCQc+qJJXS6npYCXf0qxRp+WEoiWk0h5eMzuvt0APmE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(136003)(366004)(4326008)(6506007)(8676002)(316002)(66476007)(66946007)(66556008)(6666004)(478600001)(41300700001)(6486002)(8936002)(7416002)(44832011)(2906002)(5660300002)(38350700002)(36756003)(86362001)(2616005)(6512007)(186003)(38100700002)(83380400001)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dBd13r3gYwPYcM+GOVCXY4CKFFJLqD7qytD7La4UUjkPU5HOj21D4mPJ+pTJ?=
 =?us-ascii?Q?Sd28lnOsaYut4/dR6MZZrwzCVmQkkdGcnV/hOhjxvqYXNpagsTl2qppgStvN?=
 =?us-ascii?Q?bNCMdcN1HqNY80lziGocyRy8WIjCE77vxOwa6rxQz0Qm/xTKTLQmt1wF74pt?=
 =?us-ascii?Q?8N8HcWpYr3smKnqnBGWUOEberqSBZGikj6TcHGAPr4Lpe7CHiJav369JdyD9?=
 =?us-ascii?Q?PmAui7ChATJTgIdYs/Et0XPY4D0SHfqUr+cepumbmaGrJKmidOhQJ1n2wCte?=
 =?us-ascii?Q?ifcoKW+45NkTzGFFwr3S9TLqTx4wwkNRUq/CpXLyjrdoBIx6MdeK6gV+RC1F?=
 =?us-ascii?Q?Ai4DklC6ocnCnL2+7HQUqCvb3p+330REXuLd5NKkZN3sB5B3ryD7DD9p9pqe?=
 =?us-ascii?Q?IIF3OmCpfKtz5A8d8sNNge8PiDjf9nWv9023LkkL+In70/UlICocGP9VMe4k?=
 =?us-ascii?Q?HMuimBlZnDnykWr6JL6kv5X1H6btpVq0xJh9l60CMOEf3OEUW+k4Ueux5Emb?=
 =?us-ascii?Q?1b2mJz4VwVz1zyJ3t6N+x1V1O22IS6Td47S/EWK230sxtPCXdAHT9Ehv0KQp?=
 =?us-ascii?Q?ecmOnO20iTpXW4lLBOTqdWks9y9vqcVO9WtoBYXpEM0/MVpVgG24OGcICG6T?=
 =?us-ascii?Q?G478LpiBen6Yk9SAHkLSglgWO7vWrGYidQLDkHICXhCIVKV+G+w9dobcnrI0?=
 =?us-ascii?Q?jjl9v6QGiKpHnZDBQtGheSAiGW8s5log89S+vhH55I1LidQtCU0OnFSDskaK?=
 =?us-ascii?Q?ey0GWcXc/zib+kOfEcX7SqE3mYMWQbBKKPfxXZDpWsnI3T9LVG5xZXNXSGQa?=
 =?us-ascii?Q?YC5kyDjPhoBXlv0VYsEg0b/ejJDXm4rF+BxI+HquE4dzE9Dwlp8seqHJBFCj?=
 =?us-ascii?Q?2pF2e/I+pCBoZUbOUG0AVDathJXs0Ix8QvxFhzp/PvPjm8F3N00fuAipo2Bw?=
 =?us-ascii?Q?yLTemf+jOoTesAjh+nAepre4fK6Do+pHrftUklsCGeYdFs56B1udmDac1/pd?=
 =?us-ascii?Q?3i2ZQS0qhbJj5ZJlDnolR3qnDC3Rphj1W7/mfZ70LMZZKBbEG5/2TFhI4oZO?=
 =?us-ascii?Q?8G9MFbmN5f92FfEVcyyUE1ILKgLRLVkM42NPBNCxsr4xsEoqsx9UzogS3J3t?=
 =?us-ascii?Q?c0M+KYBPSjFabhT6L949wuFAKcqAmg8ZNzWswKB82/2JFBs9zMDMoI6OctRZ?=
 =?us-ascii?Q?/ujP+g4CpdSOErxwRo1/7lhEfq69TXpQuT1wjQmcuOSiAb5QOyv6zGOhyZL1?=
 =?us-ascii?Q?OerRi92M232hzXf0U2TcIHD5bQ9h6U7glxlFdZ0FOmrShJOYSbWmtWbDYSuH?=
 =?us-ascii?Q?upCE/vzA5ADF1Mvc3YhnvjXCH83ITGSHL2VnCsRRea50BBcQgQ/CcVYEk7Fy?=
 =?us-ascii?Q?k8kDTlrtU/azy5+3VuVj5GP6nETTJe5C0NyVGVkuCol22ZYjPbPTEJ/wfZpi?=
 =?us-ascii?Q?x0Z+ZbetiodsGzY0X6yE81dRFMvdpSP4e68P7Vz1ktL1ugEtP9TtV9Mzp9ry?=
 =?us-ascii?Q?al6ZHKWkQ0jG1tvDnNtAcUVzv3SXwhx+H18FHbrIYXopOaLRnSmosNa/f3F4?=
 =?us-ascii?Q?pxXZb4qzgx1iL0diRvsvhf2YXwwLi/2xr028HpSY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282ae8a2-80fc-419e-c522-08da5dc4da93
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:55:29.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIYMesSGVGWjRidZtzap71znBpd6p7Zl893FtBnMuYIchrLflsYgoWJ2KNWnC777pDHZQmeU9rNNX/zWdtt9XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6086
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_13:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040060
X-Proofpoint-GUID: 4qPbnEe5dEoXzo25gzi7lklUWxUk0lFS
X-Proofpoint-ORIG-GUID: 4qPbnEe5dEoXzo25gzi7lklUWxUk0lFS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

add subtest verifying BPF ksym iter behaviour.  The BPF ksym
iter program shows an example of dumping a format different to
/proc/kallsyms.  It adds KIND and MAX_SIZE fields which represent the
kind of symbol (core kernel, module, ftrace, bpf, or kprobe) and
the maximum size the symbol can be.  The latter is calculated from
the difference between current symbol value and the next symbol
value.

The key benefit for this iterator will likely be supporting in-kernel
data-gathering rather than dumping symbol details to userspace and
parsing the results.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Yonghong Song <yhs@fb.com>

---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 +++++
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 74 +++++++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 7ff5fa9..a33874b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -27,6 +27,7 @@
 #include "bpf_iter_test_kern5.skel.h"
 #include "bpf_iter_test_kern6.skel.h"
 #include "bpf_iter_bpf_link.skel.h"
+#include "bpf_iter_ksym.skel.h"
 
 static int duration;
 
@@ -1120,6 +1121,19 @@ static void test_link_iter(void)
 	bpf_iter_bpf_link__destroy(skel);
 }
 
+static void test_ksym_iter(void)
+{
+	struct bpf_iter_ksym *skel;
+
+	skel = bpf_iter_ksym__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_ksym__open_and_load"))
+		return;
+
+	do_dummy_read(skel->progs.dump_ksym);
+
+	bpf_iter_ksym__destroy(skel);
+}
+
 #define CMP_BUFFER_SIZE 1024
 static char task_vma_output[CMP_BUFFER_SIZE];
 static char proc_maps_output[CMP_BUFFER_SIZE];
@@ -1267,4 +1281,6 @@ void test_bpf_iter(void)
 		test_buf_neg_offset();
 	if (test__start_subtest("link-iter"))
 		test_link_iter();
+	if (test__start_subtest("ksym"))
+		test_ksym_iter();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
new file mode 100644
index 0000000..285c008
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+unsigned long last_sym_value = 0;
+
+static inline char tolower(char c)
+{
+	if (c >= 'A' && c <= 'Z')
+		c += ('a' - 'A');
+	return c;
+}
+
+static inline char toupper(char c)
+{
+	if (c >= 'a' && c <= 'z')
+		c -= ('a' - 'A');
+	return c;
+}
+
+/* Dump symbols with max size; the latter is calculated by caching symbol N value
+ * and when iterating on symbol N+1, we can print max size of symbol N via
+ * address of N+1 - address of N.
+ */
+SEC("iter/ksym")
+int dump_ksym(struct bpf_iter__ksym *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct kallsym_iter *iter = ctx->ksym;
+	__u32 seq_num = ctx->meta->seq_num;
+	unsigned long value;
+	char type;
+	int ret;
+
+	if (!iter)
+		return 0;
+
+	if (seq_num == 0) {
+		BPF_SEQ_PRINTF(seq, "ADDR TYPE NAME MODULE_NAME KIND MAX_SIZE\n");
+		return 0;
+	}
+	if (last_sym_value)
+		BPF_SEQ_PRINTF(seq, "0x%x\n", iter->value - last_sym_value);
+	else
+		BPF_SEQ_PRINTF(seq, "\n");
+
+	value = iter->show_value ? iter->value : 0;
+
+	last_sym_value = value;
+
+	type = iter->type;
+
+	if (iter->module_name[0]) {
+		type = iter->exported ? toupper(type) : tolower(type);
+		BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
+			       value, type, iter->name, iter->module_name);
+	} else {
+		BPF_SEQ_PRINTF(seq, "0x%llx %c %s ", value, type, iter->name);
+	}
+	if (!iter->pos_arch_end || iter->pos_arch_end > iter->pos)
+		BPF_SEQ_PRINTF(seq, "CORE ");
+	else if (!iter->pos_mod_end || iter->pos_mod_end > iter->pos)
+		BPF_SEQ_PRINTF(seq, "MOD ");
+	else if (!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > iter->pos)
+		BPF_SEQ_PRINTF(seq, "FTRACE_MOD ");
+	else if (!iter->pos_bpf_end || iter->pos_bpf_end > iter->pos)
+		BPF_SEQ_PRINTF(seq, "BPF ");
+	else
+		BPF_SEQ_PRINTF(seq, "KPROBE ");
+	return 0;
+}
-- 
1.8.3.1

