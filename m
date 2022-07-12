Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA1571A06
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 14:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiGLMcb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiGLMc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 08:32:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E7D32079;
        Tue, 12 Jul 2022 05:32:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCDnOd009255;
        Tue, 12 Jul 2022 12:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=YnYcffDk6ML4k3uLtmHf8a/FiXkNsaaPpPh8Gwy25g4=;
 b=c8vMXEx5MLry9R4OWVa/yIVw9mjU6VwNAKaiBF0Jtm90d0Jmjzg05Nyu+2hdImlVLqde
 XdGcUjYwP4RCsCJy1427TDljBt5++zQUXSbEVN8uqL55y4cBhKTNG7NNr9RIh6Wcs0JB
 1qLQJaN6J37elrTwfXPkELlgvJyOwTkRAmC5S65fcrmS911rOH5p++V/W2CxkBhatUeA
 yCOqN4s0hr17/USyQCaxe9kX3GJHNQEx6MlkzV4ksffICAqwQrBDnLyB5sDLSviQUK1Y
 x2dOIM4i8jFqTLyAuYzbuu4/vzSoW24tr/b0deMmwWlLpNXLQ1fIYstMHXHb57rjD70u bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgpb39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:32:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CCLJSs032296;
        Tue, 12 Jul 2022 12:32:03 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043nxj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBTMcpDemY6bTtubZ7fre4mQ/+zpf9mR6eHCdORHrzcFClasR0rfsHV5xBEZAbiVyXoZPyA9Dz3W15xXk3ciD5XSYHh2Sx2fEp0G87ImfjYEr4CnbIe3RbckHtkcyjZDHUFWB12fvCC8S2oq6N/dOYyy78mdMevFPhHd4P+kmFZidWBb9dppZ7Jh2cFZZ/qeKTy9OjBndGzfLdtac8fECIVOqmFYSYxiFzAAt5Ii+U5oj5SQuLrDsFg/7Spewb9dhO5QF0qd/WIVAJC4GLY3NGMRGpol+sMYh8JWqjqsBb45ANwQ/rU+nV4PN2ebS3hbdDtj4zIk+nkv9H4wYm5jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnYcffDk6ML4k3uLtmHf8a/FiXkNsaaPpPh8Gwy25g4=;
 b=DRDS/LHWfVLDy/u6icTSOYpYT0aW58JFKh2XbZsefiPzZ3Q4wekng98SUQ9Rjm+i6nbK0zQQ1PkoFsUkJ8a7hj978bddRahlWftVAm6iqO2a6KAUqUqQI7qgB0NNN7erQqeSEp2swKev6eUCzxMXepgo/ymaiE7t/4X7qLmdZCErUrxkkkLaFqP3VRD6cFoxNbhMFPh0tPUmkeblFwarAeVvNDc48GuxeG0Xk+OSxU0RppiKWCprlXA3ALVUu75hHxIGpv9GrqjvxhuSxAa48gHAZTm+rZLQyQ3Vr7DsiB5HY6/J6BhJfhiNWt09bkXR04H8cNRgGGFf7B4DSW724A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnYcffDk6ML4k3uLtmHf8a/FiXkNsaaPpPh8Gwy25g4=;
 b=Q08/w0Id6bRonyxzfaFwJaFCT6j+F6Yc5nlBvrwvRjrzWHwupvCiOvFhfn8Aa8lVc/Hkjeh7ZZZKAjcjVim63Vzx5g2zy4R2yqdlEVaHlIgpDptoTsGJ7IyYjfHdt4IrdTyLo8uRE2ZKXUGXFFXJmz5uPV0eWBxWfkciV/Ys6A4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB3293.namprd10.prod.outlook.com (2603:10b6:208:12b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 12:32:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 12:32:00 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, haoluo@google.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 bpf-next 2/2] selftests/bpf: add a ksym iter subtest
Date:   Tue, 12 Jul 2022 13:31:45 +0100
Message-Id: <1657629105-7812-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657629105-7812-1-git-send-email-alan.maguire@oracle.com>
References: <1657629105-7812-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0902CA0006.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87f717a1-7ef4-42d3-2a65-08da6402849b
X-MS-TrafficTypeDiagnostic: MN2PR10MB3293:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnahrTxg+crZjB8MmvHqlUeNQdmOGfVYfYhgtMW3QMeru8YZ92KtHgRVP1udLPVCUn+5EizzLKF8076XKSFyS1nEDUvcwvo4/GpSVtKSPPbevgnZlf9x4CJ+b6olQiL/ldekrO2JnLHTjipgb55C7yxD4toRnnUDjbuPrWDDI3vPbyzO03m4lBtA9+gjAfoC9r4DbjsnqVrdbKTNTOOWciM/aoBEFXdCpx60wJreTJ64LtYjg9DxIKPvJu/0EqwixB/t39PPbg1bs74liRGOtGkj/Y5f6DPCyVGSIY2OaGvL9FMQ/sFdnVDTete+jGZLX2NvVUWwe7dW7CCY9TnNhtHpteFZMEG+JwnyH0x5E3avGzDTg6/lT5SmYNJTjjAJozI48Cph6kgoSE4/5XnoewFO0rWnGHUI5/HC23vWq7d6B6nBQAZ3sD3nfRNUOhxDadj+tjb+1cvrb46FL8bjJvN/wKzoBjJrvJMUSOgYkaYzgQG2PosfV8sDZsrFe0StGnZ4HUh+SHzR/9DqqCjuNkxT9DF9S8rQ1d6sESj8n0Q84ozv5yiZmJxv2yFZKkbOOQky6MVXrKNE9DAAfX6Xz2fbJJaG9AWexW6yvBWNTiLrrbBjYhtEUUUrtgRvFgG5RNQv7SV+wolo+/TeglwqvtknZd0lo29fn8i61b2wKln2iGE79q2HGkAzephJ+Yzle97PdfTMZdQtMSCY74Yf2wMdGY4Cf3iEb5rXES0OeF20oo4SQgGy+akTfsOc+HvIh5BZH6UhtWmdUL9YkvSwbvoGG1PhKQSgeSr6ixcD31wYIiAV0ibfRu6sl+nE6sTD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(366004)(39860400002)(136003)(8936002)(66556008)(186003)(66476007)(8676002)(4326008)(5660300002)(38100700002)(66946007)(86362001)(7416002)(6506007)(2616005)(6666004)(41300700001)(316002)(6486002)(26005)(2906002)(6512007)(478600001)(38350700002)(52116002)(83380400001)(36756003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uu9UwW1KKxQGdG/rUsEkwvQK2HARAvGS/IYaGIIhnks0tWAlBXSZ4B4/vhfA?=
 =?us-ascii?Q?nuRASeqEZWM6lGnZxPdlzq+Uj3cbOVXsBG3XCEAFYlL6HGZJ5bvIJks5ymU3?=
 =?us-ascii?Q?0ZGqNg+AWGWKemNXJHyDh4L9tzfLHZTEMrqz9v2Nmoj3ZqdWWXn5IJIPfjUT?=
 =?us-ascii?Q?2Y1pqShm9HbwRaYQjHgoHEcDd0LGuIWOc0SHLzEWgGp0AuUpVKlPTI2YQ9A2?=
 =?us-ascii?Q?VFNpXVNFJfIaXICqTRwNAoTz+sm9qbSf5xHdDEyhtK7dc0EiBNPN8BkVVSGg?=
 =?us-ascii?Q?zI42UROkXFhj80YxtjhLxTKsGvSr9nBXQfq+lI0yYY03+BUg/8trg69mD9mE?=
 =?us-ascii?Q?hLvGUtHqsLkic+fAj3cIdR+HiAFJSQFAIADDw2RcpdRLdPE/vmk9XWLjsHGu?=
 =?us-ascii?Q?pappMHjh45nzh440kwaGlsFuRvaS7lS5ylBBs971dos3xQD3r6Jw+rdpC4b/?=
 =?us-ascii?Q?6nECvx4CgwJnDddEQzvbZvnKNWVMEeoVUc3levMMqlHZsGToJUMPA6bUKR1Q?=
 =?us-ascii?Q?6tlRfgv+0cu2KYIPXYUx8tdXBikEYTfE8Rp8IsRaulgfh/+sl2rKxpv6kITw?=
 =?us-ascii?Q?cYe/4bc2zk3tcNc5hlbT6uTbRlWzAw0GXdCeI75yEH1jRiqwrRntPASZL+i8?=
 =?us-ascii?Q?X5Wj4O2WJpfhsSTc4FhTSKm/A0CCMgJbnBhz6kKszDESm9nxZoBARjjj8to/?=
 =?us-ascii?Q?0fdnioWQzjZWMRbeBZJX9Ucj98otZW41lyf+Z5iMuCBJ+vWkQAeDJVwMUtyq?=
 =?us-ascii?Q?bBFyktWPkFDh6LSTkXDG4vRKIdV0EXQC/HzFnJmpjnEu6+lnyupDHyh5yP/K?=
 =?us-ascii?Q?/vg9cliJNqfPDGqFqygTmcV7GEkXRD97pMC2WFDM7BbT8vLIs5hT09E3xoXf?=
 =?us-ascii?Q?XGuBTgYa3+HIxwsZFU8rv5SXwFV7QdzT/yJTOIaCP1K+0Neks0ezFu0YcQrE?=
 =?us-ascii?Q?6z0MrTDS2y6HdHNCx4omnFnGP4gqzToPW+ok2s1WHrAlDud7NdeksR5zfifI?=
 =?us-ascii?Q?Yci6XuS3/XYi8hFNrcJQE7DmkQFlOjYL86ddZCGil445kRUgN9emwHXiV2cv?=
 =?us-ascii?Q?TT5rupQVWckvzcu5MulM8RwqZsvnHeVhB6EpIP9d+x9F/Kl4vweGAvOQS7TR?=
 =?us-ascii?Q?XuzF7NqFW3ma47MaI66PreDRFSTU3z2csLE+ntAfQDBScDiv2wam5dEoFX5j?=
 =?us-ascii?Q?61h5qkJB5OyYaaP9dBCkmYEfWOLPZcfbQi64KrmhjovNBrEy8b5UQ9Mopig9?=
 =?us-ascii?Q?td5JQnRRXMGXcNDmko3+cq+jwftDRwqlq7I8xB7L8LuPcE6kN+V84+N696cR?=
 =?us-ascii?Q?GMxoCkQe9hmiP2zPk+vs6TXGdFZtCpxwA4KxZcCdC3d5+MxgIv/Wz2APaMRt?=
 =?us-ascii?Q?g0Jg3LwT+R46oWgcSOIluOOCAnj0T5PEcxeROr2fDRsejCbKyicXxSRqxsnm?=
 =?us-ascii?Q?eeBJLDBPRtk2OE9KL6aZSxE3Ac6JCCiwQYo1t6J+Wvie73mKjpOjzXA52Udq?=
 =?us-ascii?Q?wCVkuvjJrc5AJk9Mvz4bPNuXvwhjlFWYcnymmsAJo2h2B7fPZqEdRsnm58hY?=
 =?us-ascii?Q?maYOf1CCraV/gGZUJG6G6VEKN5XpRWbVQOZx2ArNU0U3HMJq1mihd8STc0tv?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f717a1-7ef4-42d3-2a65-08da6402849b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 12:32:00.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEvBA02LhBAgIL6qofEghHFTEi1a1sxYWiD0jIxF1mP4EW/M2+iwWZcOYBCFBMNwRUaxnJ5ci8wfFTbdigFWTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3293
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120048
X-Proofpoint-GUID: ezaceH_9DT8x6F3jZ-oLPkWawfcX-DlD
X-Proofpoint-ORIG-GUID: ezaceH_9DT8x6F3jZ-oLPkWawfcX-DlD
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
 tools/testing/selftests/bpf/progs/bpf_iter.h      |  7 +++
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 74 +++++++++++++++++++++++
 3 files changed, 97 insertions(+)
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
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index 97ec8bc..e984660 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
@@ -22,6 +22,7 @@
 #define BTF_F_NONAME BTF_F_NONAME___not_used
 #define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
 #define BTF_F_ZERO BTF_F_ZERO___not_used
+#define bpf_iter__ksym bpf_iter__ksym___not_used
 #include "vmlinux.h"
 #undef bpf_iter_meta
 #undef bpf_iter__bpf_map
@@ -44,6 +45,7 @@
 #undef BTF_F_NONAME
 #undef BTF_F_PTR_RAW
 #undef BTF_F_ZERO
+#undef bpf_iter__ksym
 
 struct bpf_iter_meta {
 	struct seq_file *seq;
@@ -151,3 +153,8 @@ enum {
 	BTF_F_PTR_RAW	=	(1ULL << 2),
 	BTF_F_ZERO	=	(1ULL << 3),
 };
+
+struct bpf_iter__ksym {
+	struct bpf_iter_meta *meta;
+	struct kallsym_iter *ksym;
+};
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

