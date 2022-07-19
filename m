Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B35796BB
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiGSJxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbiGSJxf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 05:53:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D84728709;
        Tue, 19 Jul 2022 02:53:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8DQ98008280;
        Tue, 19 Jul 2022 09:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=9jeaRVLlv9LJH8vGkX+L6jqH3ScsKj30UivVJqren+g=;
 b=Vm3VtBtT/FxQChXerznGLoNDEZP6UiOzLoqwfbDdjW+Jw6i2Kxcw0uicNyrrMVQJnyhy
 u7Y8PtPAqFTRJYJ7zRBuj7a1DvTq79q7vGFypL/LDE9+ZkOhD1qqrvoJYJW0KEIsMhUs
 8pz5MArdvkKKzJYyYlxRO8kOh+dH6HAkXbzKOBbT0r3Erq9+RI7B6ghGzQE49lqIexAZ
 VYNKrIS1o0V9Gmm+bWvfmqcaMLW3Mkm5met771k97BvhJ6pEkliMkPMawRyzSeglSOmt
 7mWfiSo6pZ+neJCZOatx2RYsOC9so3pK1Xq+dM1+GkQSFHdD88T1SiCTCJAzXS9AYRUJ kQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc5pta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:53:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26J8ZgUO016449;
        Tue, 19 Jul 2022 09:53:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1emcsnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 09:53:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOKagPs1CRXLruM6hA8hbwBGrxEVtSWRxpCc8UZgFqb1cKFaYPvUHcvNig1+d1sGGJ1KT5Vn4pzRgJb7klr1cUF/Z+iT2W2eF+yArg2qIHT6NIZtt6Yz/g3WpPCgwMj9mnQMv8zjs0Jt5k04cG466K3hJecNiAbIFOeJETG+30qCG9viSHCK5x5DPbIEn/Aspb2PAv135XMDVQg4AjCtDuSva1/9w/t4/FKiChDt/2t8RQFO2Yw1vWBBRz1oMJQLFb2d2YXsTaZ6WQtyh+2tCs92bj5PD7TXSwMGb61dAtj0bFrOde8dJH5N+MMPH4lRHOZe6Skh4i6ffhwHnjS2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jeaRVLlv9LJH8vGkX+L6jqH3ScsKj30UivVJqren+g=;
 b=RvkzGAGYnwfLi+JBqP+KDUA0Vrdw7qb+zkELmHK49MYdHaSLH9UBDkCqqEuYU7P71sg2MAiuNKEOzEN3mkvl3Vc8mQdr6FbI5pnDeeP+zRieepUKJg/Dv4jNPkGqp/08h5iWBpd8rwz88jUb2WCvJFLgNGheWRP2A3Mc8t0p4UwfcMULis8EuAHe8xTEIJHw9/M40SQqTD2OrgqD0s4rLfMX7fm0HzYF+Q9JiAYhKSpERh+05eAHhkmKVhTDr51uL8Jd4l8F0dkTvlE5cCa2gy3jehIm+fkdXvi1ToZ1j0ReM0Au30K/Hck5SXDSvi+378EFsUKzjbxO/QCi+dFNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jeaRVLlv9LJH8vGkX+L6jqH3ScsKj30UivVJqren+g=;
 b=JHe0/8Sm4JNIoS2vkXQlO/HLCToI4va2iGeOmK3jhOKZS7lTiIjNNWxqFPz6ywFKL5rQNbuzGkFGXhifERDoY9JpiIAcdO96ns+YWdHL96xNVnhNQVcRBBTxEv0qmyJTF3bw80VYi20JPLPsvlBlCAdkW1MxFKBwlvazDcDEEJQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3907.namprd10.prod.outlook.com
 (2603:10b6:a03:1fc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 09:53:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 09:53:13 +0000
Date:   Tue, 19 Jul 2022 12:53:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] libbpf: fix str_has_sfx()
Message-ID: <YtZ+/dAA195d99ak@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0157.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69045f1b-e352-4d69-3b0c-08da696c7eb4
X-MS-TrafficTypeDiagnostic: BY5PR10MB3907:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+mY2n9IR2JSyHyqB8V8YaqA29aFL3ks97mlsbm6EWejydZ4JzMdslwvPuAtEy4yh9oPbGc9ndl0zkgTz/M+HylFjZZbVre0MXVFcFlzOLaRwWmOrFlFYvJksiQSe13QzqVYBOw7nsJEyx/zaa6JumLIPdiwNYrLDVBstppXXnutjGTK+UenN6IePB+szE3e1GIYzbQ8csNGewShPdoZoNGb4B4UiTcScVw/6ICkdL58HWSTPWixfcY0MXPizNTUOs0QoYbY7rE1HTSa+F3wWCCmG4raA3//tujWLGW0tmsBlYIhsJvkkjsDxJ45jDr3lhfFeadSf9cdzoBFsHdYKFgOdiZadBYBRdHoT5DQHcB84jjdaUv6woW/UcbHD2BSKuu8WYqf+RdJ1YEbxAVHj2R7yM5Sb/9BBG/bimVaNV4bQ9GtF7TwJMZgDHTfp0gTAOnL3Im7i1CVdQmyrA8tkCnFG840CldPDQveXEyg4uZQopbZ1jeLhMmiOy09Mha2t0ura80nTMWD6SN3saMyp+W+DunfG/nL9SfyqHCPj1kLWDBli49g6xi5kd46kjVNUKZ8AZhdecFNslTsMSKkucVZWFhXTwhxKeRL7D8E2Ofwp3w+bBxjhmqZruSJKff0KgyCLh6cLRai1F248BB2GEDK0tXxukD7zfc0oS6pH7tHUndMFMWGL6emXOtqV9daDkx5jbXwTXkoGoTfSzmVJYmtDgRbqTfo14zAsEUvh857hWdB3l8kBUWZ5xxyRUW/RnEXrW9/uKT6aXPURZGllrQ4H92w+m9G1JPTVt39JFkuONMn0s+c2UbtQxxWsH/f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(396003)(346002)(366004)(136003)(66946007)(478600001)(41300700001)(6666004)(8676002)(186003)(83380400001)(110136005)(4326008)(54906003)(66556008)(6486002)(6636002)(66476007)(316002)(33716001)(5660300002)(7416002)(44832011)(2906002)(6512007)(9686003)(86362001)(38350700002)(6506007)(38100700002)(8936002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rKfnBtUuEpgwzCJMsewbQFZy/ykPc2BHb1jec8w372hPbm5ql6BssIPbi/jd?=
 =?us-ascii?Q?pyCcbO8l5qmWZCLxpG1vd4QWBfr5vRa2Al/xkGT4wyPGy6OABeB/wRrPPAet?=
 =?us-ascii?Q?a/cveapOrFjCuF9+0KN7qmpuLzSWzYxQbezGrpZuZGsNvAuw5fTa0tbqiryL?=
 =?us-ascii?Q?qQPug6I62myMxakzehMCenBM8EQkPI+9caZZFA1YOlmgXWE03LY6Adfhx9PX?=
 =?us-ascii?Q?2g4Dx6yIR9OCtFtIfByszTTzBp5EaPsymAhgAS47DkOSRsw2hxluM5Il7Mul?=
 =?us-ascii?Q?U8NyzeZXHk70MUaUpebi0XggK2gi5VgV0PAjNYBQLPcMednT1YpbjfZFs+At?=
 =?us-ascii?Q?G6vqP/84aAUicmSN+Jt8gzx30QUf8FaaNHSzItzWHfUYddaUEfCbxy3PEDGh?=
 =?us-ascii?Q?zKNl/kjsIoJvkwchqR3JW1c6M0GCB75zWpXTQ36CAQTkGhznuCizUgElaUOv?=
 =?us-ascii?Q?KCPIQwfhSYhmkCzyExt1wzOql2+4aFwfo7/ZMryzrlCkCKGDxVZLqFP/dXt6?=
 =?us-ascii?Q?Rqu/0e9NxoZEds+B9F59gNGYjkB8b8ra0i4Q5C3POsu60CuF5As+1bWgCyAC?=
 =?us-ascii?Q?n0rSCWnwy74Rds3jXwJx0bR8ogeQ99ES2pyopvbjrMszLM9Vd6W8+4CHQ77I?=
 =?us-ascii?Q?sglvho+janh8AgL/XyNOUZVzvAX6eSF0l3esbffUb3FpYnBVKB16VhK7YLd0?=
 =?us-ascii?Q?0WPiwkhxenwHkEVgpu8hrammHVslTGCKQqtU7Hlh6GsQUsBIEcFauPeYI0L0?=
 =?us-ascii?Q?EkG8kYKEaDQcbxfvviob1xf/vFj1jKyrgkwqGaKEYI8MoD8SM+Or2yQKcMdu?=
 =?us-ascii?Q?rQ93+/s9A6IG1BO5jmKaNfCCZ3bm4D1IyZ30iU/PtSZ0Db3Gf9wVAh+HdfZe?=
 =?us-ascii?Q?U7KE5TlyrqSQNe0zPixrVuMQP0BQpS2yDSzCQwewxErjqeVtf3O/RsEh9uCp?=
 =?us-ascii?Q?TbYzGiPTfhAwpIuCZ5VI/zLxAzZBtbe5h4279fHnj5EEWqxHWHK9PzRqK5hU?=
 =?us-ascii?Q?H9l3xfKD7eQhlHgEHnhkhgWC84THTezhafgyOqvpTRFK613QjtQm6hI2Qell?=
 =?us-ascii?Q?WxA8byDSoNTtsjkW011X5mRFZSnXZV6dhRP02a1lDCXvPmeC+yG90y+ARJMB?=
 =?us-ascii?Q?XU4k9ZsSPvKzeWs3P/72ozJjv5QJ9U/9SnHoU+uNDKuRZ9lFQb4HCZUIWZ34?=
 =?us-ascii?Q?LGuRDCQzCrLSMFejQxLRtwtEQ05TLQFzFHVG//r6pq9J8F5EWTwMUKO1AOk1?=
 =?us-ascii?Q?mUg+Y/as2xwSt5JzFRSWU6K3Y/5vV3QgG+33f96ZSWyueAcLxRmxXWafzcIb?=
 =?us-ascii?Q?wH5wV94cOLeVPDp+fnfqovB/cHmw1bnC2HqG2QP12FIZYOONBbvEX1RU8Q8j?=
 =?us-ascii?Q?H/QGcTIP5Jrg6f+6pJn90FR3hUuaTi0joT8icjunZpEcWRxF8x5K9Na2kMjQ?=
 =?us-ascii?Q?m6HYqbB1eXzbMWNaTY5mUNGEYcXVIuEQQIV4mNoeZ9trcMy1Xn4KNI3QaWjx?=
 =?us-ascii?Q?YGF/sOk4DEwWwv3CPJJSWfh/zAjuoOPrjn5BelTBuRyNL1Pln+jICOpUu8w8?=
 =?us-ascii?Q?IlNgBkzDGbc9f68KBNphyNTG6O56VL/+Cw4zlyh9noraW2bU88TGLKpoJw0h?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69045f1b-e352-4d69-3b0c-08da696c7eb4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:53:13.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+7t6d+nY49GcSUnj3MOZdH1D4XzctGczFBp3dYQRekQKaQACKWKPEgBZmBLb0uWHAadeOLZftqOkSS5QQetboMevHB4b++X7ASgFYEpho4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190042
X-Proofpoint-GUID: un__C1Py2XG07W73sODuiTRgrk90YenA
X-Proofpoint-ORIG-GUID: un__C1Py2XG07W73sODuiTRgrk90YenA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The return from strcmp() is inverted so the it returns true instead
of false and vise versa.

Fixes: a1c9d61b19cb ("libbpf: Improve library identification for uprobe binary path resolution")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Spotted during review.  *cmp() functions should always have a comparison
to zero.
	if (strcmp(a, b) < 0) {  <-- means a < b
	if (strcmp(a, b) >= 0) { <-- means a >= b
	if (strcmp(a, b) != 0) { <-- means a != b
etc.

 tools/lib/bpf/libbpf_internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 9cd7829cbe41..008485296a29 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -108,9 +108,9 @@ static inline bool str_has_sfx(const char *str, const char *sfx)
 	size_t str_len = strlen(str);
 	size_t sfx_len = strlen(sfx);
 
-	if (sfx_len <= str_len)
-		return strcmp(str + str_len - sfx_len, sfx);
-	return false;
+	if (sfx_len > str_len)
+		return false;
+	return strcmp(str + str_len - sfx_len, sfx) == 0;
 }
 
 /* Symbol versioning is different between static and shared library.
-- 
2.35.1

