Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CBF523418
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiEKNVJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 09:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbiEKNUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 09:20:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA78B23EB4B
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 06:19:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BC25WL003186;
        Wed, 11 May 2022 13:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=NBrXYfyhQiff5JfaCw5lqe9pcuSwtNXs0n7d9lSVpjE=;
 b=igDodRG/f5yul9231yQGYW2qnXZWix/A5FyMARfaUF2ZY8l4KjGXrV9Ad65G25mxV+ch
 SDlgDd9orLbVQLhVfod2rwD22RbldZya8H/obO2ZTPxDpO1+Xa1xUaXRWqC95Eu4ue2x
 5xUfE1t8FpKrlMXV2uCBhfBrRzC9PYZd6lAK56mxrM0v9ZLNkTqnUsWqZWbrZhbval5o
 n+DZo3b1h6Yog2AI9ope6XISQ3fM+y+z0zflIqjbDblLLw4phf0S88DJcyM8tC4if5YF
 Vk8/kO3atieV1ocmCdpfNtZ3GpR/uioLi202A7rhYJuWA04xGeADRkdBAdDWc4zDC7U9 Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04gnaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:19:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BDH89W010589;
        Wed, 11 May 2022 13:19:37 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fyg6es4tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:19:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDu3BavVwJbexN/i57O0z1DAdXA1klE2jX5duNh8zn2c9MdAX2YwanVtlQ6b//DqWaeztZTprbDpIJYs00E/GdWQoBYGZQardX41mUTjZxeUqMKZtUbQ9FAhXyns3mvu7TeCCMZs5M68OVbkREDWc9ttrcWQzWbYquPfZtKxbaGWWnIFhu/EmgylZLLMWb1vh6/3y3JLZqj/j79IAuJ74ssCHeyEm0LTz/CXcTk0D5eR9oR6nASyUPY7F3tyBRA8q7M9iXVZYi2pMPjTBWbVYhKo3etEolSD4VZGsimbzLMQSg3vGF9uHbPXjHb3YDWRwfVaUATd4o2X+C7xedzI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBrXYfyhQiff5JfaCw5lqe9pcuSwtNXs0n7d9lSVpjE=;
 b=VRQVhObR4dBxSgpMeAw7XfaGjRG3LFMcFVCtOIVZp1u1d/sqEQNTVq67nO/E8YXYs4j3kmmlayGlsWQHkZeMEEiEs/06UJOvqVPUN0vOeyMj8YEMVqebSDwAIeOXtJth+VVadgsGOdOlo8XH+bl+wNqxxkyJjwsjYK45T51Q31UK9E+028Z5QLDzvr//7U229mctReOG5wirB60WfPuzpUGPywf/AoA6MDal5FQTQ4F/ULwFu36OqcL76QIsLWy2A2dVo+MHEejiSBFiir4Ip7OhqdRuDkpujV0E6NaaLDZbS9XKsZbzZzwcgEQ5dkVPuwNpofm5TM8srxBR+pv0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBrXYfyhQiff5JfaCw5lqe9pcuSwtNXs0n7d9lSVpjE=;
 b=t3eVFUdU9Zum7EXE/ubeThmrD7QRML73LSP50Rso05vpzlLcTHUy9Me58XxIlVxz65AyRF3BuhxZozp6N2h2ij6jREawzG34pyVQW2I/GfgVbNQNf+3J2Uqk1cGprVDe60BnmKo4LyggYCd0r7JrRRDMTMMCb5pwN+P4KfyqRxY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 13:19:35 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 13:19:35 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: [RFC bpf-next 2/2] selftests/bpf: add tests verifying unpriv bpf map access
Date:   Wed, 11 May 2022 14:19:28 +0100
Message-Id: <1652275168-18630-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652275168-18630-1-git-send-email-alan.maguire@oracle.com>
References: <1652275168-18630-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac644359-866a-4f9b-dfc6-08da3350e47f
X-MS-TrafficTypeDiagnostic: BLAPR10MB5154:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5154CFF025228BAEDFCD0A44EFC89@BLAPR10MB5154.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEVfjjs12R4D/HFldatRrmJGnWvM/Sd/2dkL8Re5rIztyq0k0KcDf/fhW1CPIFCahX8jkdmme5cJpB+RARmMIrMVkC2pW5KuK5LDANWLS4qr4SkmYzKUcu2ut3Ma2r3sF3XHrc3HWj32QnfofaxQWuuCPT9diqW0mxrmzbn17KZc1B3YeuZjP3AjEINfKbPWPN6bCv12L08DDbg72rX8hOiGROePYRLg6QJw2c0yCrayBMSdoyxs5ikBIi7J7B/Pppb+qlHkgL6wxQi+UbmxtJGaMKlAYd6e97X00wfTKeLfI6dLV5pj5EGV4vLPgd5myVB6G33ROieIziU+cijzerP2f54txIF3wkBCMK92M6F/7/XL+YBYRSNBYa5eWFsoeENmz1COYB1veVB6ruoYngtueWfjqEeNvDIEV6/qGr+c4CjA48qL9qsMVMbP+/oPHtQSN0q0yeg/HjnU/WwG7e6cpb3Pa/F0vLTtsU70vfTvFYGbRH9NK7fHP5B3jvdJ6hmwp6R3HH9V/k/86yH5g3yJhIMeZIqbx5Sp0+i/icHTgBMZt3DmfMeg8C8/Bd3bJbTQMavbCMXB7/exnfuyGYEPOvb97Gb4VpMSkxeClHrBNxZiLc7xXANemUIu/mwzBMfzuRaFn28jwE01L4Ik9vVrIxlhuMeRdAC+juv/dpnPY3h+6qKvUnTG0ldWuZ/w0UIWwr+XylLjLIuYP8zsfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(186003)(83380400001)(2906002)(38350700002)(66946007)(66556008)(66476007)(15650500001)(7416002)(36756003)(44832011)(8936002)(8676002)(6486002)(6506007)(52116002)(6666004)(86362001)(26005)(4326008)(2616005)(6512007)(38100700002)(508600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iGwFmZ/MACSOc0yEBtvc9u75sFw17b2Ld84iyTR04jVyC49YJauHHx+ZL/2?=
 =?us-ascii?Q?fekbqKBpvORErlq1fL5Pf7rTDeIWn4UP6JGNTJo5zuE642ADB3qiA2G4/4kV?=
 =?us-ascii?Q?G7/Wl5dbxYjxbKc0uMqEZ8gxKYJeXoAGSRsg88EcLnwXlTYDDrLRZDe35+VK?=
 =?us-ascii?Q?W63T270IPliZchsMsl+I7qVbFe1cgfrP3MGC7QsOz8p1zkbz7c5sHuzdFCZy?=
 =?us-ascii?Q?aaOh5hod9G1AdZ4teo6/qSr7FZje1Q7g27qg1JFhbtEsm4deVTwxYSbkAiIL?=
 =?us-ascii?Q?f1qIjKXSDpcvBj1/m2nEY/74Vk333zvWnfRofAOI/gMSpJFFUcAMQSt5wNei?=
 =?us-ascii?Q?7p7pPa+29438aYhygdoUJOm8BwAoeq1zwH7TRKdJGrEs6frnnHudp4m6x0ZF?=
 =?us-ascii?Q?aFivl8RpJfPZO7pxs66N+uf0kqB9oxMul0GwoHgOK7Mb/EznY/RwlW8MyiJZ?=
 =?us-ascii?Q?aX2DA3bcmraRju/yCvMHqFlae4gOj58f5peHuQemNHJADjJYpqnsKJCAGFV0?=
 =?us-ascii?Q?mHui2KCj2suIP6AxOxQnixupfP9jAeMoEDCjCptbRW5iHoP01Uv+AJCoHLit?=
 =?us-ascii?Q?rQO7FHcVyW6noMTR9MIGjiAi+mT+eXA1WlJLoEnWB1sMnopYe47FHWrrW5bm?=
 =?us-ascii?Q?myvsHO5JPk55WaZimYI6e/3GAVM+aeRpKWtIZ56pqWKFcLiWYrGA+RKg4adi?=
 =?us-ascii?Q?ij7gHyT7hp8hdv6CpEQh7lR4H1EpGNm1FLQ11eLGoD5EOiWlVacxkoH/1vLG?=
 =?us-ascii?Q?DDNIpoHZD4jNO1lnAwb3z3hcNqXWhGg+U5tUjgx8j201TR7ITff7mN/iZhtR?=
 =?us-ascii?Q?VVRNTbOk6SMsfJZPDUB5gFQUAEfakFk1zqh7iAfgZctJa8TX98JO16uf3XEz?=
 =?us-ascii?Q?c60pN7JeSwC1BseIdsnA90EDRGTf/LFboDYER56Ktrun+YsSbPswKzS9PXAd?=
 =?us-ascii?Q?Z9R0eUPuVZ49yg/v0eCrMn/1C79OPyroqms6okdBT4D/b+KkYUPkgEX+Ujxj?=
 =?us-ascii?Q?akxC3H/8KalN8M5FyleJrfLAR80NzW+Gl7R9dNlKCrzHI+s4VElUaARaj9ud?=
 =?us-ascii?Q?oyeu1f3k/S0H4BDZ9dYtWgCQ/v3iNIBC3y+UdXYFom2Y/idpJmSs0H1BKo9I?=
 =?us-ascii?Q?YOYhVv/RdB86Xu7hGdrf8yh7FHGulo75zXoL7Wui3lW0pJLebMINdRzlQ9z+?=
 =?us-ascii?Q?o5XzvcSgt3+6UdwQMZCFWfLNwyUW60fk05iNwUHfzTN6kiI6jsxhnz/0a/S0?=
 =?us-ascii?Q?9GKWozS8cw6/JYWTAxt9O4GOYAZYyG/MzSln5ReQPdaOO0e5S1i40kp3pCNA?=
 =?us-ascii?Q?IZnG99GtIEajgCjGZ6yXYSXojdO/iyJlF99gqMF8qrQiAGQ+G4+IABuXqE4T?=
 =?us-ascii?Q?D2V0FeJ9CQPKbTe4LSqkk1jKssiTKVbbH6XOQx7t9IL41ACrQArWCg3BxoL0?=
 =?us-ascii?Q?R2FExVa5MvC0ZuRKsGWbkFU4WD1bbHOpe709Ky9sBMBHOWCkwjp4d9HVwsZe?=
 =?us-ascii?Q?GMpn1/OhP6up7cbzDpAgERFdcMEkgrO6SBEbP7OnHlxvlkOJewbeB374cFkg?=
 =?us-ascii?Q?M/54nSCU0m6lFjUKUoXcM9OhMXbxGAniCGU00HuyH89wA8Ki/TImEubjzeVw?=
 =?us-ascii?Q?LJ9CjlNurTKp9U3IHw/jcWcAZPl4wXA9SEexL14xkb0OCOcCbrewq9XN0z6k?=
 =?us-ascii?Q?xPyPXS1WrOl91u+1ySxqD/Pbaqxj5qYThWjHdOTDEdZhG5qE8U6cma+qgVGA?=
 =?us-ascii?Q?mwzltFZKktydd//b+Kh4By6NjLO12iM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac644359-866a-4f9b-dfc6-08da3350e47f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 13:19:35.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/g1K4LwvRb+Aj/tfqqKDm+jrPBNmHte94kX/NTUPLO4n5+DiteoJ96RW1gYT41PfuUS46CK5ejUxd3dxEoqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110063
X-Proofpoint-GUID: cXjgNmFMmTTFCmDRQ_OImJTaTqhvWNUM
X-Proofpoint-ORIG-GUID: cXjgNmFMmTTFCmDRQ_OImJTaTqhvWNUM
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

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/unpriv_map_access.c        | 194 ++++++++++++++++++
 .../bpf/progs/test_unpriv_map_access.c        |  81 ++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_map_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_map_access.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 763db63a3890..f9570f93ba29 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -36,6 +36,7 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_IPV6_SIT=m
 CONFIG_BPF_JIT=y
+CONFIG_BPF_UNPRIV_MAP_ACCESS=y
 CONFIG_BPF_LSM=y
 CONFIG_SECURITY=y
 CONFIG_RC_CORE=y
diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_map_access.c b/tools/testing/selftests/bpf/prog_tests/unpriv_map_access.c
new file mode 100644
index 000000000000..cd64a38ee075
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_map_access.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include "test_unpriv_map_access.skel.h"
+
+#include "cap_helpers.h"
+
+/* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
+#define ADMIN_CAPS (1ULL << CAP_SYS_ADMIN |	\
+		    1ULL << CAP_PERFMON |	\
+		    1ULL << CAP_BPF)
+
+#define PINPATH		"/sys/fs/bpf/unpriv_map_access_"
+
+static __u32 got_perfbuf_val;
+static __u32 got_ringbuf_val;
+
+static int process_ringbuf(void *ctx, void *data, size_t len)
+{
+	if (len == sizeof(__u32))
+		got_ringbuf_val = *(__u32 *)data;
+	return 0;
+}
+
+static void process_perfbuf(void *ctx, int cpu, void *data, __u32 len)
+{
+	if (len == sizeof(__u32))
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
+void test_unpriv_map_access(void)
+{
+	struct test_unpriv_map_access *skel;
+	struct perf_buffer *perfbuf = NULL;
+	struct ring_buffer *ringbuf = NULL;
+	__u64 save_caps = 0;
+	int i, ret, nr_cpus, map_fds[7];
+	char *map_paths[7] = { PINPATH "array",
+			       PINPATH "percpu_array",
+			       PINPATH "hash",
+			       PINPATH "percpu_hash",
+			       PINPATH "perfbuf",
+			       PINPATH "ringbuf",
+			       PINPATH "prog_array" };
+	char unprivileged_bpf_disabled_orig[32] = {};
+	char perf_event_paranoid_orig[32] = {};
+
+	nr_cpus = bpf_num_possible_cpus();
+
+	skel = test_unpriv_map_access__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	if (!ASSERT_OK_PTR(skel->kconfig, "skel_kconfig"))
+		goto cleanup;
+
+	if (!skel->kconfig->CONFIG_BPF_UNPRIV_MAP_ACCESS) {
+		printf("%s:SKIP:CONFIG_BPF_UNPRIV_MAP_ACCESS is not set", __func__);
+		test__skip();
+		goto cleanup;
+	}
+
+	skel->bss->perfbuf_val = 1;
+	skel->bss->ringbuf_val = 2;
+	skel->bss->test_pid = getpid();
+
+	if (!ASSERT_OK(test_unpriv_map_access__attach(skel), "skel_attach"))
+		goto cleanup;
+
+	map_fds[0] = bpf_map__fd(skel->maps.array);
+	map_fds[1] = bpf_map__fd(skel->maps.percpu_array);
+	map_fds[2] = bpf_map__fd(skel->maps.hash);
+	map_fds[3] = bpf_map__fd(skel->maps.percpu_hash);
+	map_fds[4] = bpf_map__fd(skel->maps.perfbuf);
+	map_fds[5] = bpf_map__fd(skel->maps.ringbuf);
+	map_fds[6] = bpf_map__fd(skel->maps.prog_array);
+
+	for (i = 0; i < ARRAY_SIZE(map_fds); i++)
+		ASSERT_OK(bpf_obj_pin(map_fds[i], map_paths[i]), "pin map_fd");
+
+	/* allow user without caps to use perf events */
+	if (!ASSERT_OK(sysctl_set("/proc/sys/kernel/perf_event_paranoid", perf_event_paranoid_orig,
+				  "-1"),
+		       "set_perf_event_paranoid"))
+		goto cleanup;
+	/* ensure unprivileged bpf id disabled */
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
+	if (!ASSERT_OK(cap_disable_effective(ADMIN_CAPS, &save_caps), "disable caps"))
+		goto cleanup;
+
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
+
+	ASSERT_EQ(got_perfbuf_val, skel->bss->perfbuf_val, "check_perfbuf_val");
+
+	ASSERT_EQ(ring_buffer__consume(ringbuf), 1, "ring_buffer__consume");
+
+	ASSERT_EQ(got_ringbuf_val, skel->bss->ringbuf_val, "check_ringbuf_val");
+
+	for (i = 0; i < ARRAY_SIZE(map_fds); i++) {
+		map_fds[i] = bpf_obj_get(map_paths[i]);
+		if (!ASSERT_GT(map_fds[i], -1, "bpf_obj_get"))
+			goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(map_fds); i++) {
+		bool prog_array = strstr(map_paths[i], "prog_array") != NULL;
+		bool array = strstr(map_paths[i], "array") != NULL;
+		bool buf = strstr(map_paths[i], "buf") != NULL;
+		__u32 key = 0, vals[nr_cpus], lookup_vals[nr_cpus];
+		int j;
+
+		/* skip ringbuf, perfbuf */
+		if (buf)
+			continue;
+
+		for (j = 0; j < nr_cpus; j++)
+			vals[j] = 1;
+
+		if (prog_array) {
+			ASSERT_EQ(bpf_map_update_elem(map_fds[i], &key, vals, 0), -EPERM,
+				  "bpf_map_update_elem_fail");
+			ASSERT_EQ(bpf_map_lookup_elem(map_fds[i], &key, &lookup_vals), -EPERM,
+				  "bpf_map_lookup_elem_fail");
+		} else {
+			ASSERT_OK(bpf_map_update_elem(map_fds[i], &key, vals, 0),
+				  "bpf_map_update_elem");
+			ASSERT_OK(bpf_map_lookup_elem(map_fds[i], &key, &lookup_vals),
+				  "bpf_map_lookup_elem");
+			ASSERT_EQ(lookup_vals[0], 1, "bpf_map_lookup_elem_values");
+			if (!array)
+				ASSERT_OK(bpf_map_delete_elem(map_fds[i], &key),
+					  "bpf_map_delete_elem");
+		}
+	}
+cleanup:
+	if (save_caps)
+		cap_enable_effective(save_caps, NULL);
+	if (strlen(perf_event_paranoid_orig) > 0)
+		sysctl_set("/proc/sys/kernel/perf_event_paranoid", NULL, perf_event_paranoid_orig);
+	if (strlen(unprivileged_bpf_disabled_orig) > 0)
+		sysctl_set("/proc/sys/kernel/unprivileged_bpf_disabled", NULL,
+			   unprivileged_bpf_disabled_orig);
+	if (perfbuf)
+		perf_buffer__free(perfbuf);
+	if (ringbuf)
+		ring_buffer__free(ringbuf);
+	for (i = 0; i < ARRAY_SIZE(map_paths); i++)
+		unlink(map_paths[i]);
+	test_unpriv_map_access__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_unpriv_map_access.c b/tools/testing/selftests/bpf/progs/test_unpriv_map_access.c
new file mode 100644
index 000000000000..a215e2f1fa16
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_unpriv_map_access.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, Oracle and/or its affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+extern bool CONFIG_BPF_UNPRIV_MAP_ACCESS __kconfig;
+bool unpriv_map_access = 0;
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
+int sys_enter(void *ctx)
+{
+	int cur_pid;
+
+	cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (cur_pid != test_pid)
+		return 0;
+
+	unpriv_map_access = CONFIG_BPF_UNPRIV_MAP_ACCESS;
+
+	bpf_perf_event_output(ctx, &perfbuf, BPF_F_CURRENT_CPU, &perfbuf_val, sizeof(perfbuf_val));
+	bpf_ringbuf_output(&ringbuf, &ringbuf_val, sizeof(ringbuf_val), 0);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.27.0

