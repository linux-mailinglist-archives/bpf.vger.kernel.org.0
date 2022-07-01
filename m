Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA26562FFC
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiGAJ2E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiGAJ1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:27:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3102470AC1;
        Fri,  1 Jul 2022 02:27:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26198ZVi021945;
        Fri, 1 Jul 2022 09:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=EbQO0zrx6hTAu3vi9ENmCgUba55f0zvdWjh+Q5Kw43E=;
 b=DmcPvuOrR0k8f4NdkDclHlSjOpZiJV9ruDzIfHCLKK05eZTXaUX9rAgAQg2DSLgNQg32
 GL7qA73rLradoSweyUVuxTdD8WPvJhzgGhVHeNQnFb7ZXdoDXtdkrf/xhzdsYr9uiZXr
 hJW29aq9tdKdKc3VjcwLpJ7Iaz/tJ5dChWxicC/ExvOALZ7NaQ94vFNql2dJI8oG+dMN
 VLZUknaIe9LQ2aPPSpxJl2BnvEFQ2RHyiNRRY7nXZ0njN3X3qtZsAm+68O7MRr3m3A3P
 9RvQU2dUqbcEBKOFfovjnZ6V3j056k4rsCIhUAbBvSH0wmDDF9Ng+t1JsJeyBn3ERT4i 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52ppxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 09:27:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2619L2Mn003534;
        Fri, 1 Jul 2022 09:27:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt51ag4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 09:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDnCGwGmvGFl3WBG9sTDXRjKQLGsHK2T+JRhYPwPtusXbD7AtNn2V6JRcIXuWLtbk0yvgXKXS4yFrpiKCmWrY91cuJV9+adcwpwaCWOqBFpbR0PtDhuuf5jt8eFE+qhuhf+jPEsDmeseyC55DlJ713r7g+NHnCEkZ/vvB8z4XLulEAyEaJSI/FltLLyVCEEiK2cNaboMW6RxkFKu/J8Kn+HCaiu9K/FMGcwUx2UPkPDMwm3Y88Pdlf5tghUNn5Pbjf9fJybCdTK6qiERXnJGMjso+KQ7pSqp8bRHBIvk6VXZNsEORmdFnPU7ieaIOIk2wCShJAfvpgEX/vYaI4Zn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbQO0zrx6hTAu3vi9ENmCgUba55f0zvdWjh+Q5Kw43E=;
 b=iz4u5WkXzqiyGhLRXi90qMXGg+lTgskZqqZMmCp34FV4OEzqhqXzqzmllldveSZQCeqNzn66zcuMNgCAx9eQFD/h/8Oi2NAGIkC50pDTtHf5NX+p3aCWwlo32VK1AvhnP4/C3qlJWXDMnYBTwtfvQsEKY3l2jvKtK6V2Ec10HUX5RvBmUqoJdTnIZVfBFtS/IG6lxOnEper0mpZsFPjsWXkT+9mXPkrdL6EuHtUm2u+PYH8Cn/hgGvprKIe+1x29L1+AVTEL1rTA0dmPeAsGJ4nzPMSHqyqBVeAdSISrXIPjPA6Lil4rEEQnLT6tKJcX/jP0JFoAklw1w3plCdLaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbQO0zrx6hTAu3vi9ENmCgUba55f0zvdWjh+Q5Kw43E=;
 b=ewP5cSyL8zGvNuuhZe0l5uzs29naUQUM9wG2ElZx5XBhaRm2ZCuINHXV772IU7WopNE+DYcDgXsIxjdsklg3nTTZ2z4Om4zeri2MkhByDVQ/ShNqgzcrxyOmd8diE0qHrTp3srNdYjEGRrUz5Jt10aojgSmA5k5jASdEo9/OBmU=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 MN2PR10MB3951.namprd10.prod.outlook.com (2603:10b6:208:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 09:27:12 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::289e:c33:4eff:517c]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::289e:c33:4eff:517c%4]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 09:27:12 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: add a ksym iter subtest
Date:   Fri,  1 Jul 2022 10:27:00 +0100
Message-Id: <1656667620-18718-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656667620-18718-1-git-send-email-alan.maguire@oracle.com>
References: <1656667620-18718-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3acf9ff4-3b5b-48fd-2261-08da5b43e102
X-MS-TrafficTypeDiagnostic: MN2PR10MB3951:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqZUbZ6nrVVyqRDt6XDC5bp1vcdgkwn00E0vhQuHG7/Fg8fIFyD76yKutJMrYA+YIC+jFA8vDiF7W6MTZLpsJicNgarnctvYpNelG9kZdVIQlJebXCF9noJ5Odm/N2iEUxjbhR60o8WaRUi8Yt3roeMS8tyrGYuqjsekLHpUMlVtaTkuqGW4TiHPMywQo3V8ObcVojGQALbInUUjtrEdliHpJZ+qFm0mrT5unkMLe77VLehk9HI4MrJFNU7dKcZJojiWV0hEY1QvGn3azTP2H4ST3xQQHxN0RBLAufhb/Yy6at+AW5RFio6V7aVZpkbCruORPqDnbS0mMZdOLQa3KGkm3m6uMUdnZnZh9yU9DSImrLVD78mZ/jWy51ZEDMBosMFVSUTJT+jnocFVTVHfQq75j8zsOq1vtRqh7iHfMn1fKLGFQm0AySFdNNin49HjiaAbrcrO5HeG2WjFjAubxc1PPPmnwkzfzo4iwxBKCaExJGD9cDEpzP1Q5LMYL/DlR8lTez+V3opc9B9U95Thk2ltnYvMmrE2ArUsUAyGfIjml/hCUBd61krA6/xLVFK94kr6TTlAFeSNDcsuO/SFW3flGYCdnOUaIfQPvjhl+7My0k5IXyJWpvk4X1KhHNjcd3EX58Tg9Z653w5GXEL+gO0sds7rLefsclu4lBHfurzJ18El7gYrIjyEM2e0wat+0pw7XCJ8jv8fSXejy5cL+t1I+L8o6NDS2+LIG6pvKoKQu0K64cRx7J4ntVHATQKhfB+LKiCrz/CCoaQBoe0iTuEtNxBP1DPta3ua7N2AHnbhyu/efq03wIfk0OOW3Dzz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(396003)(39860400002)(5660300002)(2906002)(86362001)(316002)(66556008)(66476007)(66946007)(6666004)(8936002)(8676002)(26005)(4326008)(38100700002)(38350700002)(41300700001)(6486002)(186003)(6512007)(2616005)(36756003)(478600001)(83380400001)(7416002)(44832011)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/asSc2T7oJ92m0pXOhh+5b8wFs/fUBw0Jc/85VYdGdRj+hkDQpa72oXq0jg?=
 =?us-ascii?Q?HSNxvxMbZo6wUkjhs+avr4WRh07zaI8VX16mhgbPdmNPfuHZkvtxsFtLfasC?=
 =?us-ascii?Q?rQn9HQ8vdT0ZIwdbZ5ulXi2CIiQeamK9VpnZQx6VVyQ7+d7W8cAiHKwieKI2?=
 =?us-ascii?Q?We+uv4qZw5tQz3G7s7J27fOT+l1PxL44pXSH4JBE1/3B39R3N5S/EmFc9zJl?=
 =?us-ascii?Q?YNbmX8iidbQohlKABH4JQBcCoX6Tray5wFUf0+BBLT4hU4IryOUmYHbwNONW?=
 =?us-ascii?Q?wSvfMK1UIPsV5cpGFF7+ztNdtaFjqI+oPnMbfnPYgJoX3PKoDfb1k1LEjAeh?=
 =?us-ascii?Q?LdaiyhdFg+sG/oJJGyDZph+ebNw0obUIgusdzgkx4PTXUcshRVM71RScmv6E?=
 =?us-ascii?Q?x0LMs8AxWw6a1VghQIQkcXbN/s5f95FiF1PUBQ/NhSXW+ddS6cpJydrzQZc5?=
 =?us-ascii?Q?taYQ6OLkaGm/sh81aASVFMIjEUMmYm/K3CUu8REdeEHfok+eHsmKl/h35nM/?=
 =?us-ascii?Q?Zc3QhQcoCGDGhXimUK9anAaoIcKRql4Z18GJEpawHIEAEDqG5ANo7FpXwFn9?=
 =?us-ascii?Q?BY+7KSTJNUdl+bg+ujjb/tuXItJXVm0fY2mOxNM4ZfmkkPgq0QymodbG70eo?=
 =?us-ascii?Q?NoYn+57GzdbgKmE3s3TRXwGRj0GaVP8n/Rm8NRuVUdZIaSS43Ykk2sMYY6Cv?=
 =?us-ascii?Q?dLH7xDPQnidoViEVaZxZyFJKCqLCaWMm/UIQ94vwyIcLZw42NPRwy13fdjV0?=
 =?us-ascii?Q?WYSWIKp6rLQ8a3DGNKvaRJy5PrQqbIvEt6NRl3gWwbFtWutxD6T5eECR8k/l?=
 =?us-ascii?Q?yp87clvKafBR1xIprG+/Ph+dlL6KliDjlOUf6Du/UTNVVluMo39DBhuhoDk8?=
 =?us-ascii?Q?21SNrUy4iET4jVoE1fCqJWVE8aMJmGtS8LPwz30XBjpXnk0XevIiPeU4TAO4?=
 =?us-ascii?Q?78Mbqe/WhRqLMYOCCtVInrODRjbvdQx3ceoyY9llv4jkMRsxLaOGRMSZvRXC?=
 =?us-ascii?Q?jgjjFIT7nd+zMKBUx55A4NP1YimBgPx+Y0nAjtPoRac/NimNZyxSRjOXtzZq?=
 =?us-ascii?Q?zTqJFxmH2pn7nxdX5pFcG1O9irCAYce6C/dyUEHRQiteZsBCQ8beGQ8PL3cY?=
 =?us-ascii?Q?CDy3WQQQrAoNKWpdMyNYsHHLcw16t4fnD4CZhSLO+9ZXhyaZMMTArxxRQ6Kl?=
 =?us-ascii?Q?yv8dL1W4/+t4QAbWeqXPQCe6rljTbcdbg8vWzpKeqUCDSquhP/fyIrt88AwP?=
 =?us-ascii?Q?myX481E93ubgPQXMIsdkxsBvDfbyfg6PxMcO/+WkhU4aMJwJ+J+gCF1sLHTi?=
 =?us-ascii?Q?E16+rsc/MlftBBnRFuBOaGw8oYmcVgo86dffagUZnXCnI3uVDzDVBXj7rwZt?=
 =?us-ascii?Q?xD7Vvww+fTqvX8KnKuQsM/7nvfYSxsz9rvhg6QWRZNgzgYxeo5+qeIEwyd8I?=
 =?us-ascii?Q?7dQHhdoq600cA6pNVEZAiEfvO+LuGL6G+NN1SL2i1bgqI/JTFFnOwdNWLJBR?=
 =?us-ascii?Q?RUo0urVqiYq3cmS2McvFSK2cxVbdFW8XDDbpe/3XzdV4JQN450nSvyPimm6b?=
 =?us-ascii?Q?eYcT0mD6w7X6dd5phfLflRuBa50K0znCi5Ij/KOX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acf9ff4-3b5b-48fd-2261-08da5b43e102
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 09:27:12.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQUT0QzgjgnDCxGbnX4Wb8rYycfhAsqelEK4fWxWYekH+fUYxogHPcy4tGFwVGJH7Q6NJErnQr32bDqbwwOPNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_05:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010034
X-Proofpoint-ORIG-GUID: Hg-_9HnM4FZ1VRbl8YYJrpvCAQzkom3p
X-Proofpoint-GUID: Hg-_9HnM4FZ1VRbl8YYJrpvCAQzkom3p
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
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 +++++
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 71 +++++++++++++++++++++++
 2 files changed, 87 insertions(+)
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
index 0000000..bc3a479
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
@@ -0,0 +1,71 @@
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
+	last_sym_value = iter->value;
+
+	type = iter->type;
+
+	if (iter->module_name[0]) {
+		type = iter->exported ? toupper(type) : tolower(type);
+		BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
+			       iter->value, type, iter->name, iter->module_name);
+	} else {
+		BPF_SEQ_PRINTF(seq, "0x%llx %c %s ", iter->value, type, iter->name);
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

