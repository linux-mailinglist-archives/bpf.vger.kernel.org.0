Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35C52BC3F
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiERNex (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 09:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiERNev (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 09:34:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F715A77A
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 06:34:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IBmnq8001099;
        Wed, 18 May 2022 13:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=zgv1SrWoUDdj4R1R5HEtgQy7YoW3falybi2I9MIDJIU=;
 b=rVyIe3URvG0ky0xm/80ZpCnmrvqHFDCjWaB+tMcxZ3DX6/0i93O3y03adWa14Foja7jx
 x66R7Q+CfInSt+JTy/23fyKog52apUZIrjibhsQmnkyjfblv702YSYFX2Dfy2p714Ftc
 cj8i0L053e0u3+oaA4wZwcem3DRh2u52I1/neSld+TGD9vY7XTx1dZnx2uzN9JfJ1wOW
 4pJU9Yk3CZ3s5CV6jVhhEfYI81wUFMXL7bZGCkW99P/PI5WSmbjzT2nqLOEMj8v1odiF
 6jYdIYhovAm1L38uhGUX+UjictTtxiHBck2r+AIkn2uts8uZQ4NHYXuuLsCVSmEIUWmd ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s98rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:34:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24IDU0OG020658;
        Wed, 18 May 2022 13:34:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v9tadm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO9VZAlPsYZkC0cpksfvEYzLGgJQFlEasPf2Iu1/moSPZ8Xi8g4aV7Co72YewAnUb3f+9+YUFkxHbxKUCKjPXEd3eqSpiif04fgGyq3g8ifikrCcDA33biur1VGGZZMdBZUBDMN/jkVYJ0yj3r9K6ufjy6Mr5tPdTu6zwNBHxtQS9/IRhfItmV2ZTBWJeGGZdUX7BLk4LeNE1jsjI+zw1aGU6RwP5IP39GyDSOXujeu2ky1LHOWMrioAXpwgGbMAjFPbsPw6G4yNCk1gb7a7b4w2joLolYHJZpiQELlz+fwauNj77P38LJtScagAIMQ4LUWYpTpxZQBGlgmOHqxXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgv1SrWoUDdj4R1R5HEtgQy7YoW3falybi2I9MIDJIU=;
 b=kITrnQce3us52sZ+wucl3t2SPbni9X41675WXhrvWlxojvK3Hg4qKTa7qZdqZ5IN0Jbw0By+i4OzlLwa/yom87XOCqkib+iU9KmvsTLnkRGe1EOq1PTvIEg8HpOIwXqdYKXQsJmPpYBL3Rdj5tCEXvNrWpq7DDMJS27WakBr3evKaloIkhSmgc2l9yaBJoReqlFnPlUh4cxIJvYDMDLfkTbNNbzJqHbYkDc1b2xdbMifGrgXw2uvOHhRCN90Q2M/OD0Bs9LPb2l6chSiDrUoHWwWdNdWAvmd81iZcefrgmRblsP+hCZhX/0Uoc/VYFsJAl6AVr2ENPzetoppSfKnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgv1SrWoUDdj4R1R5HEtgQy7YoW3falybi2I9MIDJIU=;
 b=P/M9awqEoCZtOJVnWE4/V9poDbgke8y3PWdt1aSck9/oGmD/C3+FdqKLUbLeT+oFuV5IU9uahiVSOwbfT6vMxVS53nRGWdPqsm6CrN6PEgJWln70EeTrSrSsw7pgLEYBiy4BeTQ+gF/LpCg7d8fFjVoObjg+mJpfUQoV4qQYK4o=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4039.namprd10.prod.outlook.com (2603:10b6:610:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 13:34:29 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6969:7923:5c22:a739%4]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 13:34:29 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        keescook@chromium.org, bpf@vger.kernel.org
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: add tests verifying unprivileged bpf behaviour
Date:   Wed, 18 May 2022 14:34:21 +0100
Message-Id: <1652880861-27373-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1652880861-27373-1-git-send-email-alan.maguire@oracle.com>
References: <1652880861-27373-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1e6c1ad-9dd9-4a59-a48a-08da38d32258
X-MS-TrafficTypeDiagnostic: CH2PR10MB4039:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB40391BDF2EA1198012D61397EFD19@CH2PR10MB4039.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiYijHkPWA7Vd3QnSDCXMpcgxdrKG7to1+X/IOCAdRSoouLk0TPPKzbL+aYEBLCoS1t6B3ZQ4dWhFNNIjtnIKnHZ97e9qCDdE3M67qHU9XyatvsfFCVKlWa9JVYnQ56vYUAjLidUDADnjzcayaTQLyIxIHsIILhM8KYFPcxJ50YebJODdWJiskgv7BGAi+6F2MZCU+D6xxdwVwN5JV6Z5x6FdUUcBE3/k0vcKlnJvmtZKCxFzQJybWCWrTOHvx2eIQKZJXHB/yxEt+WsESDN9XmDj8e86IpeIH8lPqaJt8n4FV6FlpTN+EzKD3Qw8wvfvjmPyPB/v8nvEGKtjj8UjRJq3Ar5h4RPaDDL8A2gadLCCMtn8EzphScmBjdCQK195x6NPDiIbzVxPNRZjlzWpC642u2VV21waEGEch3k+EwJU0p1t3PUIZNGyP87roMkPiIqBVtRTXFvl0UzAHwNCCrgzBIQNA2cPLW2r/n2saaoc84znj0dQEr9+Za6wZJ7Oesok3gMsi2s0O5VMK05W0q2kCeO9pFJqO5ojDN2gPfpdzmGSUqTMeZuikr4zOj1C97Ze4plBBBfEGuIyDtVfb+/jVnP/MOroD+sjkUyTGzsG89/SLTAZELc+A7KNS35l0u5gOQVzpa191ScQxQOwoQosFYnKX3WZa3G1/V/kcmOkfV/S5x8xQjxnixQcr3wakR/rVHMpqMguuk80Ex1EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(5660300002)(7416002)(83380400001)(186003)(30864003)(2616005)(36756003)(316002)(26005)(6512007)(2906002)(15650500001)(6486002)(66476007)(52116002)(6666004)(66946007)(66556008)(8936002)(6506007)(86362001)(4326008)(8676002)(508600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLA/PT7FWJFHVyVjnzDAuQSgG1UaFvbl81e+7ztgyQe4+9Jc4Be90Oo6JjBO?=
 =?us-ascii?Q?3tulYlk9t4pOGd4CgAkCX/nq+l429gFoq1WLXkRqDWd9iD4WyUnpWqELg5jg?=
 =?us-ascii?Q?Bg/PTz5X9TpwyysJVEr1tV7uBnDG3wF+reSCLoRM+MeixMLs5/miAPqsnyZQ?=
 =?us-ascii?Q?GYXdLHCEMMflFcEKC4+kJ/Ipf/7miknDfcx5aj6p+b52XgAtTytAQfv9rxo+?=
 =?us-ascii?Q?ve0LUmqzDzPvgANqPG5KDpNXLh4e/2JAKN5/MrlW9n/bBCXV1GE6mSfV2dcl?=
 =?us-ascii?Q?f/zJ/JK4SaaQ+jqu/LDAjIC4B7a9UgCW+SX7XPzHxkPVwevhrzu7D/5P4zOq?=
 =?us-ascii?Q?Fbew5bEySPEbleeBI1Z5tCZ5TXTh+BENvr5EiRjeyqIi7cxkwyX+c87u2X7k?=
 =?us-ascii?Q?R+lU+IAjseWALc3DjUM8iSGStjSb0wFLPaWY1WQPDEat5tPqYU12ApbgOvu5?=
 =?us-ascii?Q?KeVTQA7E8UJ9597Rv8dIarD3SLm99SSX6y5l/n4GkcFalmX6fAwuf1IkutIc?=
 =?us-ascii?Q?zi+ri5GBCvykc3bVVyp+yp3UyGCdkRFIlQXown/TnwNnH3frjhiZLT5RqrMJ?=
 =?us-ascii?Q?aQxmwRgnn6HjqGLhWfHHGXVglk3wwPuyQf0BqEakIlrx8G0vF+V79I4hVgSF?=
 =?us-ascii?Q?XCdsRObcYDaWCVdUTg75+EQSOkJpmq/FnyZLpg2RS9yvWX29v0VgmGvKHEGb?=
 =?us-ascii?Q?o0werjoAE2Dj+RmUIpLmw+Pbi26rNb9f6gps7eTwiExtKdsjoChEMqDUrfTx?=
 =?us-ascii?Q?KZ3uiNYtseTb2sXS5MhiEYltwb8VFs/NKVwmH2Rm3oDDoqDv1U3gpc1gnXMa?=
 =?us-ascii?Q?t+SA+C3QJrfnuzpMmFFWJpBGBVWQ3kiDomn7dAdhFPiQ9fvRQR7lHmf6tYLX?=
 =?us-ascii?Q?wHxkTJBRvcCIXNQYk7ircyQqxt+bWOb6mDTjiJuDD947LQRe/RP9dulqGHNE?=
 =?us-ascii?Q?ZhXJD5V2CJ4i8VzuBADW68FIKDWCbQoutCNw6iOFAhnZOUQnK0/Lt+K9u1Ep?=
 =?us-ascii?Q?8zn8w18kxDV2NTT7hfujOamJVpkGEm7nJHqvsoB9m/M3OADC2LMyhSw67kQY?=
 =?us-ascii?Q?Xg9G8vQ5YbyTnXZp7bHFYOTZRFmCXOs//bnCucTJGFpVSXaYmtr+9jCtFK9w?=
 =?us-ascii?Q?LKV98CeyBmvarLVA4IVJeYN4A6dQUNj4Q8WfOSQkdIWJWCwHkp4G7RMKo/mC?=
 =?us-ascii?Q?iS3DOnYBj8edNl0cWSJqKD7DBUPvkMLgBOIifVWYl7sg7d6+kCvwhn1WT5AL?=
 =?us-ascii?Q?uF+njX5sMITb+5qpS+DJmxX+0S0z95Bm5AUOA26UGRi05E+tvDmU2sJxN+aX?=
 =?us-ascii?Q?p7UBgthzuD6CQVUVol0410dy7fRpf90zlUVjqzBD81WiiPC0e0BFckocfAWx?=
 =?us-ascii?Q?/s6IrXnCqgfLXtAayO7XCWd6pupvR9DcZK8tZcYgmnUzI0fkaYPx8cPKMQsL?=
 =?us-ascii?Q?b87gTYKc1iG/EyQdPLILrCKapQX2WRT78/+0fMNh92bH/PlzgR0x1OpF7FmL?=
 =?us-ascii?Q?ZbCxlf+Pxs4AMfK4Pqd22R4VDwB4AcIZ8g0eHz7c8qRNzz4fsvOvXuN/bQ31?=
 =?us-ascii?Q?1ktogmYaK/BYbbn7VIFtXT5sAPuBWFKSapcXJyuGbMmduygFaE+ajR3WMAGa?=
 =?us-ascii?Q?kxZt14qn2X0LdeMNtYhp0KkGbVy/XLZK+IFx7YOEZQN4/AJhmddStGxr7pNW?=
 =?us-ascii?Q?QNHyCtSqw9dl1bhhAhrfzZHU72qxsO6uKdh69qN/6B3q8UXsBTbevYxSFWAm?=
 =?us-ascii?Q?Ap3PZR1/rbZw/qoezTPGVyrzs5rR4pQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e6c1ad-9dd9-4a59-a48a-08da38d32258
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:34:29.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8auDdpGF3/SgLDYxf5dR3sXY7czNf85M03RPe9MDb14hqMBoMNgxrF4RbHiSGFttyuZoFFvnvg6W3l9Id8ePAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4039
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-18_04:2022-05-17,2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180079
X-Proofpoint-GUID: vLc4t9sP0TfcS4NBQ4Xg9EcBmU3-An6f
X-Proofpoint-ORIG-GUID: vLc4t9sP0TfcS4NBQ4Xg9EcBmU3-An6f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../bpf/prog_tests/unpriv_bpf_disabled.c      | 301 ++++++++++++++++++
 .../bpf/progs/test_unpriv_bpf_disabled.c      |  83 +++++
 2 files changed, 384 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c

diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
new file mode 100644
index 000000000000..ac51193a30a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
@@ -0,0 +1,301 @@
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
+#define ALL_CAPS	((2ULL << CAP_LAST_CAP) - 1)
+
+#define PINPATH		"/sys/fs/bpf/unpriv_bpf_disabled_"
+#define NUM_MAPS	7
+
+static char *map_paths[NUM_MAPS] =	{ PINPATH "array",
+					  PINPATH "percpu_array",
+					  PINPATH "hash",
+					  PINPATH "percpu_hash",
+					  PINPATH "perfbuf",
+					  PINPATH "ringbuf",
+					  PINPATH "prog_array" };
+static int map_fds[NUM_MAPS];
+static struct test_unpriv_bpf_disabled *skel;
+static __u32 prog_id;
+static int prog_fd, perf_fd;
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
+static void test_unpriv_bpf_disabled_positive(void)
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
+	for (i = 0; i < ARRAY_SIZE(map_fds); i++) {
+		map_fds[i] = bpf_obj_get(map_paths[i]);
+		if (!ASSERT_GT(map_fds[i], -1, "obj_get"))
+			goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(map_fds); i++) {
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
+static void test_unpriv_bpf_disabled_negative(void)
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
+	char unprivileged_bpf_disabled_orig[32] = {};
+	char perf_event_paranoid_orig[32] = {};
+	struct bpf_prog_info prog_info = {};
+	__u32 prog_info_len = sizeof(prog_info);
+	struct perf_event_attr attr = {};
+	__u64 save_caps = 0;
+	int i, ret;
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
+	for (i = 0; i < ARRAY_SIZE(map_fds); i++)
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
+		test_unpriv_bpf_disabled_positive();
+
+	if (test__start_subtest("unpriv_bpf_disabled_negative"))
+		test_unpriv_bpf_disabled_negative();
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
+	for (i = 0; i < ARRAY_SIZE(map_paths); i++)
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

