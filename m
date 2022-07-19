Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129515796AB
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 11:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiGSJuL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiGSJuK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 05:50:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F631033;
        Tue, 19 Jul 2022 02:50:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8DSMr008261;
        Tue, 19 Jul 2022 09:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=NCUpJ44xmiANoMtDkO+pr2Bd5wYA72e3i0z9diEMMGg=;
 b=O3nJt84tTRMqlfa0IJDJMDTwY0pUEDoi44r9RmqI3T84uvgynNu3HujCFtziMM7jterA
 g1la70amyu3i66TeMp3SRmCiwBSnpXe2Atu1mGAu7rBcG27L+tw6PcJqlGuENUzAKtt8
 M2Uo03uF50ooqfJ24bybdPs1pFz3SNzk8QzfE8EQd3X/DjpD3m4vLjmHOskhqFPf9eis
 BEr8GHqLSGrVv/5fdbR1GRd/v1Yrgx8FEGO0lnJFZeuP9ifL6d5jtELlBNFNNaWTbZKL
 s8MY/rUj8XxS2MbsXYZitglChQdnYbaaFnc4pNNTFpVPoMZyag/f90m/RxomIcIAaJk/ Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc5pkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:49:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8ZgIg007822;
        Tue, 19 Jul 2022 09:49:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3798b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efupUoUXHdx1Ian7oAegzC9UJwl1dAoQMFrSMgQsnP32H64pES5DuKl9hfafSgY2IuSiZI5fofritrjZbn2reqSwHKmP3K9Zjy7tmlcJEu98HkIlYrS6iTz3wOYUNOhyen3Nl2hHCXfonyCIDAbxRqCPfcFCUEq5fuETmGPtG4ZYDQS2X6KxCsquXoX3gjsz+UQ2WLE5+VsCwaKBKFmJF+zOw93R3E3JEKlK/4GZFuCYhn9DW3/GXZMYixhahded51tpTX3hAGpS3poPnitgm/TJBRRzx+kLciY9kzVfAez6ONhjBZFYyDg1OCYOvGHwSMAp6fZiLN0A4guqavuY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCUpJ44xmiANoMtDkO+pr2Bd5wYA72e3i0z9diEMMGg=;
 b=Lcv+ydoPJH4JPviesVmzWHy8Egh6vDHq7ROHzwcIp8L6v+9Ri7OkB6W4Gfau6c5pi+J8ufgY7rYNApH4Ny8PIjOq5IQCvHh0AWgLJVg6LHYYUTNQ0JtkXYNRC4gttoD4e3E1+6eM+hzjMHwNl378YVvfb86FeOLUA0fXspoROYAihZQzQ7/qeEYfa86VQI+nDZqjgm9s4kIfkjJYnRfJAEADF0pBv6rUtzHU1TOBPCbG2pB5/JopIYBEJGidiQGN4XpZMSKh8mSKXeq/9gwZUUAssywRPnP7H64sD4HEzfbtzVlsZX+5Iu4nOr2As5P/X9GsNpeH1aPJU17VkikSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCUpJ44xmiANoMtDkO+pr2Bd5wYA72e3i0z9diEMMGg=;
 b=ksGD6Be9YSq1eZXomxHaOSogFbv+S08pAEh8vjQnNtM7dTNC+ugRUAkeTsYGY3BdipVBYM5qrp+aYGH55UGWgf9iFMJiJD1AhF0oS+mX0U1UMDmL5cumpah1/unYGxSvkgV3GqBglpwt6GlChvgzyIvMUs0kHUcaCqUsoM9KSPc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB5924.namprd10.prod.outlook.com
 (2603:10b6:208:3d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 09:49:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:49:46 +0000
Date:   Tue, 19 Jul 2022 12:49:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] libbpf: fix sign expansion bug in btf_dump_get_enum_value()
Message-ID: <YtZ+LpgPADm7BeEd@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0124.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd66e6f6-28e8-43c9-bbab-08da696c03c2
X-MS-TrafficTypeDiagnostic: IA1PR10MB5924:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQchr3mkkN4YQ/7EJOtbeJIgc4dBQqG1Li6h3IdB0ateQRyovtmM1ohVRXjc1Qp9D5DFNv3ixrB7ZjFUwDFSEpknsmcepNLhW/C0RAcjfRMlIBv2Oo2w+c8tDuVehVVj+pSSfG2pjdhbqnvhbCXPxJiCEYucc4tgMhe9nvH1vBLXFNth9+7gMIM9uNaqJQNarJafyAWfadRa4kO8i7C1mkX8/v/UfCjwylz/caY6WTKH4rEIC+CsRP0aW6FvmulmUYtGJwlJDAN3fozLM0a+yqhxE+yrskUDxtcsov1vF2y3AutXOZmmyndSBhNt8EM/65eElReHfu16lyJpZBvMP02GrByvZ67ROETn+hPGvMT1jF223abeXMHq6uU2VuLJtmeGWkiIB+2DFtVyih4fznJSHE0PPAYQHQ1teulOzM5PIVD8kd40PCbdRS07PRXDBzO56vFhUvw4DOG9M7qfUyp5uWL6bqzTu5VN6hd4v0nKpI8NbZHcBU087969dw9icj0dnCc3hA7xBwp7LA4f7Vd0WrE/p6J405u16tpsmPDFrYa+wRFlEAN1tbLZK35M9GaiM8f9CM3B7You1bJI5zlFPQD86pQ3PcjAwl8SR+347ccrFpG396bFx36KTIuKM8A8FEgRow4hiUioDnYB3Gdh108MfJ4RGyCrUnPK6Mv/RWB+mxTXE9G2V28g9NJc606DUOsJRwetM6g7lT7q07UID87pMyhbWmVjHyZZz2VpwQUin/z0yYrxV1n8ooqs+7BZltoebvBmiOD8fvnmgpAHbndgMdLcm23XivdzWWn8cH3gFB2cPF+NluxxRTai5laMGoqS8R7COCWmFeE0AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(86362001)(478600001)(6666004)(41300700001)(6486002)(26005)(9686003)(186003)(52116002)(6506007)(83380400001)(110136005)(316002)(6512007)(54906003)(66556008)(66476007)(4326008)(5660300002)(7416002)(4744005)(8676002)(44832011)(8936002)(66946007)(33716001)(2906002)(38100700002)(38350700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qIpbrudiwDF0kQFwIEn0G5id80V316OYevYIDwa666PC6ryr5Z/V4/q8TnJA?=
 =?us-ascii?Q?GtUtKgp91sWlvwuJbckTQudB4nqSE4sqF5bUc9BfNKMxjh6Ovf7oc02+wY0f?=
 =?us-ascii?Q?sXFqMf8uu284v1Tak6sQlV6tlHEDECtVmNDb66+fzLxCt5fvClV79jO90lLB?=
 =?us-ascii?Q?b45frd6BeFL3CKxaSCh1EJlnBTa7ULsR8oHIj9aVxzaSTELtwYN7mU5e8qF8?=
 =?us-ascii?Q?6miQBDzyiXrrXK18f/VR4WbMT3XCEV3IkObOgpQzLiAkF3JlgjxkCTlmrHe4?=
 =?us-ascii?Q?/7qKV5ZGYRCHaSouHnXqrXJca4sXXK3urttcNf/mOAw2i3fU9qnCGmrJJhA3?=
 =?us-ascii?Q?DQ1v5pT9RhhARWBuQ4/wUuI0bk/8jbUK0AwSktblMLLpIQY0keBAkeDs533c?=
 =?us-ascii?Q?FTE2zKz7xJ5qxFDm/Ulm12fsPgZ14ix6LOv2uwsPVy/MCRouR/ypmbaFtKTx?=
 =?us-ascii?Q?Iy7XzMw1nQLjd98EIZJN89EN4sW8EBwbVwqNntN2STjz/3k08Q93zrqLtrEr?=
 =?us-ascii?Q?ACnp1zfRsqPB8Ytuv6llrQ/WSDx2OE57vfUvaGAzFW+kxhYDr+Cj3FYu908H?=
 =?us-ascii?Q?AtES/QS3f3w0D2I4sQG+7tTKzIi3DsOw6bWlOh+dyqzqRnbD71gvaFViD0hT?=
 =?us-ascii?Q?77jzVoAsuXtTZuFavMfCdZu0U4R7wKPgJfE1PMOWVhDmbS+U7Alhwm9VABdp?=
 =?us-ascii?Q?LSXgPS1TS0WdPN5un9gnmAng9fznpOfJ5HAXq5Rvv9oM0uV4r6dmqawBR9po?=
 =?us-ascii?Q?pJhiHby4u7T4USCQXCBxxBnNwNyocSxRqsJAvqIIuWl8hD1DAMWnPvhP1gQz?=
 =?us-ascii?Q?b3dGhEnhuccrBcd8YG4mhvJqB7DMlo7r/E2KUyNTEGSbD1Um/dTf2bAjBvQS?=
 =?us-ascii?Q?emXyT84hkoAEHPgxLt50ssi4dvU2Kpboj6QR7g3cSDqnbE6XWG454KR5w1BR?=
 =?us-ascii?Q?wSshXlWolA8NYHfNVU/Wv50PeKNyK7wijUsgThBiK3l7yco+53zWVyp7ID7e?=
 =?us-ascii?Q?EYNrGvbREJfef02uMVzBeK7KNLaUGx/fsPg/hSbJFKjl5SbpegxoqzWlqex+?=
 =?us-ascii?Q?myJdQUz9FxifTMqwkAzUnlIlLBLZpNmYxV1BLt+HnoJ/kelGyvi9vYYi2PGz?=
 =?us-ascii?Q?ONdgn4PGOyWP3/+3rHvzhUJNAoYR1zXibgZYjvZOJV2VRZvI2x0ZRud9ijJ+?=
 =?us-ascii?Q?cCwRB4+2Qf0dYEKDZS4v9jHxOJBZHxxrog5ma//b1x8iTLkr048DM6yZQYH7?=
 =?us-ascii?Q?wvsYZ/HNBMVf5XXO7+N8Q3R5wAuDbOoBQXkEQ66Jpc2um8sEPkZPZDnIgtHL?=
 =?us-ascii?Q?sL46baXb+CHegZL7vmMeWiYceM71ztfplz12NwXt/cMQwXZKbbEfrjWWE7Z7?=
 =?us-ascii?Q?i6zqHo3kobZvp04TqKCdRNAtM8TVrJBPFWTe2rn9q+GCIZCg3xQOd32NfzgG?=
 =?us-ascii?Q?IAcvXVKl/epleuEAedoQrxf50J2eW7j07/yX8R0w6j3RVxwvbObX7q7nUKjE?=
 =?us-ascii?Q?v8EFKd7GGMidyvvYpZBTkHNhXnShiOW3mpq8UxRM+ik2bCKV+KDpPGxKd2Kb?=
 =?us-ascii?Q?fUFsQZBu/9Ml3/cDzJiWcAHJD14zlIzhiVCk7ZvoKsz1E7Ru1OgJ9LEb5Qvk?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd66e6f6-28e8-43c9-bbab-08da696c03c2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:49:46.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNEgSO+lX/O1IrNdHNcpnzEF+3f3FlWHkHxEPipFpUrIIp/nU2f3KU2osBkRdhgc0dF7ghi7LIgmOBFJCT3eiXRXXoAn+i1Rcs+B4P06Yks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=970 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190041
X-Proofpoint-GUID: wl3EuvnE0PrXruPIuLnC1i52kX169_LC
X-Proofpoint-ORIG-GUID: wl3EuvnE0PrXruPIuLnC1i52kX169_LC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The code here is supposed to take a signed int and store it in a
signed long long.  Unfortunately, the way that the type promotion works
with this conditional statement is that it takes a signed int, type
promotes it to a __u32, and then stores that as a signed long long.
The result is never negative.

Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/lib/bpf/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 400e84fd0578..627edb5bb6de 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2045,7 +2045,7 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
 		*value = *(__s64 *)data;
 		return 0;
 	case 4:
-		*value = is_signed ? *(__s32 *)data : *(__u32 *)data;
+		*value = is_signed ? (__s64)*(__s32 *)data : *(__u32 *)data;
 		return 0;
 	case 2:
 		*value = is_signed ? *(__s16 *)data : *(__u16 *)data;
-- 
2.35.1

