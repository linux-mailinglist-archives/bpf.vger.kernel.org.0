Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A01568935
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiGFNRm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 09:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiGFNRf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 09:17:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0226ADF0A;
        Wed,  6 Jul 2022 06:17:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266Cmx1J017970;
        Wed, 6 Jul 2022 13:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=IiQIJN69PD5IJ10FmgQqijE0q3+yD1jjO2zKNLsotHo=;
 b=l+xyy4PGWb0Tok0k1M3md5ZQxaK5WRXLL57KilREbpHVRAgXoKfyNQMFvLKeU6MzmHfR
 uBu6IfiJMMKgqRIm6Gv1uYOqPAs2AdjHX+T23pJsDOshEIQG5icwZ4d9amZnJu2HCZ4O
 DWJoU/w5hZtBgTZcLfG17lvu5XzLwk6uF2WOWWyyzFqVk55oV3M35vkZnalTesD0zl6D
 UFJUH2za9wNpdAxRt2Cxnfhp2z8akhp2c22HDKk/s+RGpo9w9pHTpR4N1goFjvny3Icx
 N3b26D5n6vI7YdEM1VLMsJQCdtCvb0EzQzQp/roEpJfnZkci7OE9OwWyZAFZLBluoEXl ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby1xrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 13:16:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266DB1Ks023774;
        Wed, 6 Jul 2022 13:16:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud0tj2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 13:16:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg7XaO4+BTntMsJnm/CQr2N/BSpOsu7gy1QdVLxXtVatjIb5kQ1VxdkUAvlQCWexxQhQk2Wv8a4bnm5K8ryA3nMK9mCCjHdRDEO2ABKJXPqQpHOn+0WVBSoSV11mWK/4/v1ojOZRD59zWz2g6MZAHqVrn45BVcFUE6sP81n5XlSdm+V3ZUGp4jJKoAh+sgSRJpi0rB2V4IlpbwDolb2OWt4T5grrSBOlzzxUY6O22C053nHVELFCvzTD15MH03iXaSHOh50AKkvJ0qRKxbaDeqmWnmz3U/iLNRDSllJPJ37nvtWMzhVhv1Y+6O03H9BlRJ/fMijux+dr7rciF5TTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiQIJN69PD5IJ10FmgQqijE0q3+yD1jjO2zKNLsotHo=;
 b=H2zGFKO5q7l2NWK6FMC86mDpQCQEMMyYAeHsspA5RDHY0XTvCMcL1VuRJG9KXhw3GYAcvBgsKXStzUA5w7lG28bcoG351RzMX17KmRQEHrjaWg5FZ7MfkWGlw7v/QukRCW1HMhLrTzenybG0DJfOtAYpZOp4hK3S6JOrYyi7YCAotQHPYZ5at8Ul7HPvwdIA0RmumPyMavnKqJW243Dqc/3ZV0NDj+ylrl0Lx09onLRfV6k2adQpRakJkbF5d5//9gCkZdBZOxmqS+ThhA/myjfB2GrXjeZQBHXfzP1uaC6q3QlwxadM9RJVNs0OzY2wZv+FrTxfN+iQ8oLoHi1XGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiQIJN69PD5IJ10FmgQqijE0q3+yD1jjO2zKNLsotHo=;
 b=njOZ4Z9tsoTgSRBMu4/+rxcDOC2DhpWw7W/agB49yXWHrEdFYyrVhHWhsYwYXRv39X7HBbXiMnLNwfhstHQN0SM2HNvGYyThOuIgoBoL7eMu360rrtZHDWBphjTmokpmdRYKQZtLCUK3ceTbQXuHaBqicBWXBooIvM7HiBUl4yw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MWHPR10MB1421.namprd10.prod.outlook.com (2603:10b6:300:24::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 13:16:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e%7]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 13:16:46 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 bpf-next 2/2] selftests/bpf: add a ksym iter subtest
Date:   Wed,  6 Jul 2022 14:16:31 +0100
Message-Id: <1657113391-5624-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657113391-5624-1-git-send-email-alan.maguire@oracle.com>
References: <1657113391-5624-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80450b46-6080-4f6a-2dc1-08da5f51c4c3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1421:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOvnjRXedUo9FMwSvjyWi9GAhxs4gg4CrEk0uByCeBd/zOoxMbG/fiSMpPKDSKpkMXutmjmFJtDYzerf6u1H3QSQ1fWjsgwI4TtkpqO9m3iM9hCgKhs+S0laS2+wLUKv7kllEorPIkC2qNznx8HYGZL4S8xyAx8/0eWW/JHih/8+0IK37yIzn4lNPTk2ZTJZUR9GG27GzHw9+bvMwHq7TFcGadKPSasa3rO1oGVs1hJkDV5V27N0uq2XuEqZW1KHkTt6HrYwcrJx1pFtgEDLlRsSQc/e0nGCYISpnkoyfllsfgzVGFiambCnaU2/DPmZZcfPLUujdCep/6JmyCbQ/dERGWQ+Z5S4MOGnIP28lqTZogV+OO66Q41WdAryQXvw4ZLB27YLMpKTIn2D+g/UKc5SibGoGjzkfqEf1U3BJmjNCfG+Jidpf7wbumSu9xNInjSn9CwyjABxc9YqK5EnZ2TlxZofzb40riYqs+Uvqt1JVosoPmVNyz1ErPJXb2Nyxvt6TMhTd1bEVfW8cnB/zBoXGwC+y+nUkhiCNR4gEY/k65xbOdkUGTvzMqKxPPqLV7/01lqLnrO5Lify2xIkZQf/M6sl8xyMg9VSD5sKBMXE5PLubLzzqfxN1uQmaol7Kya72NHHKOPXffK90EIRecU/dKpOVosKW/vEI3jHok6Q470gAXmB1vvO9xYA7u3vFvrZ/rYRhhIwf2TGf/ABiazZNrK0bqyfRlyuveS4rLGYnqrUONFngL97TAb8xy4KEoPgHFHzxu3Zm+QO/5x+Y+jL0WkOeJbZ+E45+2AyhyFyOSWEhv1EV76+cM6AKMhC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(396003)(136003)(39860400002)(316002)(83380400001)(36756003)(6512007)(26005)(186003)(6506007)(86362001)(5660300002)(7416002)(44832011)(2906002)(38350700002)(66556008)(66476007)(38100700002)(66946007)(8676002)(4326008)(6666004)(478600001)(6486002)(41300700001)(52116002)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uEynSxJ11LO+4L6isQXZo8Ff58uC2liugSBhqVUafwm6Q2SYR/xqyVZtcvY6?=
 =?us-ascii?Q?2yFVEl5REzItir80RNVPTEY51GTwRXXq7Hzr9n2KoZY28HfBxivUAgybPK0b?=
 =?us-ascii?Q?H29NeAdG7+ITWDsZkHmF0eTFOr/ConJMH96KF7dA8XryMQ+VBJGYm30Fwjn4?=
 =?us-ascii?Q?v1gp0bJMF5Tw7rjTjH2tst9cD0rjDx4ZLfVTpSVv8qD8DhHfJPmWo+8/Q6gO?=
 =?us-ascii?Q?DAPRPH/H+kDMBr5ysX0ReSwceO+w0OqhRDw2iCbhULC5Nme8jMUkb6Uirr9m?=
 =?us-ascii?Q?lASILTj/6pvABGYKrRI3/25ajqVkss8tbI1BOhuJewWlzk0hOlTxjZniS+DG?=
 =?us-ascii?Q?6g3Cwcg28IOG1ytAufVwiZHSWHRaT9iy5N2340lUfF6E1jrGwQRVALLdJHO3?=
 =?us-ascii?Q?fBKx4m+pLfmt5TlPbNkFsX22KMUEUj9RTp5Nl8dDK1QY10Hj3hMFHdGowMjc?=
 =?us-ascii?Q?9z5s6ZKfw1uYSs3XRKm7rXkyVuOtTy/07IlrOBBP2069JIxv0gx5GQcUjTEK?=
 =?us-ascii?Q?HctxLYTpw5JxxGmXfoW24FUq4HmdWcoSBlxxDdH0k/H3+J7ZjpX9gmawUvXj?=
 =?us-ascii?Q?X0t9vdmuFyfUVh/Q0bDOXigErWm6vqO6n7XudIgKw6xojvU6vgclGNKGwckR?=
 =?us-ascii?Q?kdAqL7qIqwt9vl7hdhjE6kNv9qGPrAidosiuhPzlAdHAGaXmG/FnYKXC5d1T?=
 =?us-ascii?Q?ST72uTGvnfDnSbXU1auoAQklHDGlMQGLIn/YjiDgHxF9UQvecVs8GxdfL3hJ?=
 =?us-ascii?Q?7QDtrPsXtGVzlavGbHU9jMHVAX/uCU6bK1yZvPObPyCPi9KLVwwWdpUHPo/g?=
 =?us-ascii?Q?tuOOY4NMhBKTQudDY2tpwF2NX5t8QsJtS+tx17/F64wnQjjJE6OY6JQMdsc1?=
 =?us-ascii?Q?MWNV/l7WdmAY1VuNM7kqDS41LfTpoA509Hfu+L3sTqQwXOyoq4eBpB6HJ4zo?=
 =?us-ascii?Q?nIhoDTDCJ3iV5oE1zMMkH8T0cb8lxxg2ozF92CptiqZ3/iGYeJxFk22NDHXJ?=
 =?us-ascii?Q?yUpBwHGBx59ACx3/CY6kxuW804vMzJWWYJSI7ZXlxPtwPgaTi7kiAhTYRW/m?=
 =?us-ascii?Q?/cBAFbIwj4M92vr49mPhKX8hs7EZFLR6bBQ4sTnae+YB4jGieffVcwxAgcAp?=
 =?us-ascii?Q?84ETlvRh0ts9x9dZgrg5AsM2l7uSsX67iA9xCzWlBpcMgOXQh48GoOLBdgMD?=
 =?us-ascii?Q?+H/I+cE7UOIu+GAehjNLcGMa6w3V+RjdT3PNlta5kPzmBo1swREPrBuSJGwD?=
 =?us-ascii?Q?zSb+KGa/dxBVh9QjJxBppgl7X+Sqq05YsArcdxdaC2tVqV2JwrLCLLe8bcry?=
 =?us-ascii?Q?U+CWXVE3BkKrK72Ul9bDj+sjtxUGxQiQv0Hn0oZa/0mBg8p/VVzJE63YV75w?=
 =?us-ascii?Q?W7SC3H2hO+3bQZ2qqMoS3N9yUUgcgjYHLfRGgPvVomdPly/F9y5kXmSvaK9X?=
 =?us-ascii?Q?8LNh2p30LLPT6mPhZEECgZQhLJOj0B53KDE6RyNhP8E1vFtAxFgqXqeaFjvT?=
 =?us-ascii?Q?l+e63Xmi/9oVZ05aJJ7ieMR8j4NTilSnuJw10AhLq/cr1bZr29c4A+pQx+B9?=
 =?us-ascii?Q?6S8ClkyClKJS4hQisQ/1hJltEjrMdr0P7HE6ESmu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80450b46-6080-4f6a-2dc1-08da5f51c4c3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 13:16:42.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7JI0+2hEDsROrOYyLE1hQVjKiKMn2U3X44YzJVFntS0cvc0wWO2SImFpDAZfWPSpZQo9gND2yTLCahh1M8DfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1421
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_08:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060052
X-Proofpoint-ORIG-GUID: EFxXgvfKh5Q0b61qvNmaU5GjebcWWUTq
X-Proofpoint-GUID: EFxXgvfKh5Q0b61qvNmaU5GjebcWWUTq
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

