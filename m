Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA14AD202
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 08:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiBHHQc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 02:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiBHHQb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 02:16:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D7C0401F1;
        Mon,  7 Feb 2022 23:16:30 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2186M4FQ020227;
        Tue, 8 Feb 2022 07:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=9IUHIz/MJtbdj8GPXFb6j1FuJC6T0Q0UHR8KdT/rHyQ=;
 b=U5lJdrRa4We60xmTRPRloFaWotXtWF8oAsEFcqtfgvz0H16KOdga9zJQbFttU4l8o+Ed
 r8ncgcjk6F/PzPfeF+xBTCZmJZVo/UvrFyvEzKUWNHrcYNiaD6G1z1iERNEQa6QL1XLh
 OKtRjbLILcY8JaQUANlUjPWqC5ZeBXUXIsZLe4+LRIobxObHCxRmDPyVyD09X5c8Mq88
 XK6ICO8rKiuq0Jasp2jOizMVJ6e+NcSLsj+40xBi8iW2QGVSTAVNQtOO1WnxhTIrhMcE
 6z2ZGlu8pfB0o+pLOcEIP5VesSjQ+g98q7+dA1v+II8YblOKP/CmqDbfnTd6RNObSZGq 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wsxn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 07:16:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2187BuPU093651;
        Tue, 8 Feb 2022 07:16:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 3e1ebyk6an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 07:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTZih34O/uimJIp7lybT+aacgVekho0gUXS/jxFKtvrj2OuFQ5p9P7UWvtImR5LsuhPdRemSzKNciBsf9hGMruno5y/hT2PiWSgwG+ielhdgg8u5c1sg6tpGbHyg0g+Q1xP8FE/Kptoj+L9YJwX7csgYu5D6hU/klPC3v3O7anqgIC/gDw/ELfh0wiuFwFNMYGs8JS+8T4Hl8iRHTJ+942jS04Kz5sELSGGbguNj1aca/U/Cst2l2bMJHsoVChs0a4d9f+EXJMLrEhT1cmZj2JRhY0jQJN53F8f2HVgSiArDvWX6Vvaa5yaAiIUemCKpSLBWL6wwQmHervZ6ju5PxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IUHIz/MJtbdj8GPXFb6j1FuJC6T0Q0UHR8KdT/rHyQ=;
 b=hInCMAh6bspwHVkrHDLpNAQ6wyF6EJzH/1z7YlxYx72PmwjgDW1eRt62JdEMoUT8aOE2r7XCXAD0mtH427B6WR2aeRNxsBakKu8sWqVYjEKufJypV4ztqI8hLF7rodjba+xfCsZqvJLTeV9NLiyr+VGrslla3w5ku2CgIqdzhbJPYvsmzdvfFYCY+Pr/BtMs6eVmZzF+EVwPRkUZ4Kz1o0ho20Hf0M4N3WYKb7acHN5rENwOeFi8ylLWlsLs561fc1UwdbO7WlWUwW8wJvzIdfKeAZ6Knzv22of4+zSvb4S+9OJ9OYF4odqFNoOSGzb1eGWqOl6D6KBGlA1BQEWxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IUHIz/MJtbdj8GPXFb6j1FuJC6T0Q0UHR8KdT/rHyQ=;
 b=JClcj/WLIGZXRSLS+4f9MrFnH9pWX1lmADtjFbwZLyUTCIt86jjSdEtm5KIhS899FGH0/7BPXPu24addgbNiw8Nw3S2/Ogqojre6ce8uFXWo9cUoaaLwNCV3ATuOJhfUJbSB5JF0pLS17nDS8C7KvxKIkOz2XaP0UTguz7ycWuE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1269.namprd10.prod.outlook.com
 (2603:10b6:910:5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 07:16:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 07:16:04 +0000
Date:   Tue, 8 Feb 2022 10:15:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] libbpf: Fix signedness bug in btf_dump_array_data()
Message-ID: <20220208071552.GB10495@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM0PR02CA0124.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c22c9a1a-22b3-412c-d2b9-08d9ead2de47
X-MS-TrafficTypeDiagnostic: CY4PR10MB1269:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB12693D4264B6D31FE03C80E08E2D9@CY4PR10MB1269.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1z+zlUaJSowqiJ3yKdcv27ZrFSpZIyYZeyXxr1X/nxezC090UGJHZQob8U6YZWTGuPCD+DMdwa+Du8sminzdr9how0Mv6hgBMPGYCQ0IpP5nGQATVcY9tsVtJtAPyjX/0aEWRhdVMp7R2QEn2DNmDnrHoLCn1fsS4ckzfLKibYn+9d/G28dL65iUktNT2mo9DtbzUHLt/WYRsUULR/rL5CfjzfilVgkCSjfw3LCjVNqRWSnXixXBrLwYxYLisLQKTnKLyh/Xd6+SJwCw9Koj49DYwdbwQtW/yvUe4hxffUe2IeG9VIZlyXoGliWslxezG4d8RIIKTb6gOfBPfFlPIaP332e6tar9t3F+UrP/RX45NvccmPrKJQzb1F9CH98o1R0BkOoZCMH6WBPYA/lHS0QxQxvH/XnUfIriVbInHOezomDlSj4EskSiVpC45pRoV4usIGzn9YgHnW7jkrGxdeiiewHsldHvTIdNm23OlwZlRMo2A91qFMJLT/g7A6olkwME+ouJcKEKKcyWpkGgRXLRY/yxOOb3C1m6i2/pu8RJBjafgfsB3WoQmaJLlEn03gVJdYTw3F/J814rLZC736RhWwgVXw+GFtqRh4NOeZCV1H+DfSZVc0e1rnpR3BXCtF7xU+plpVyrymuIPFbkSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6636002)(1076003)(33716001)(38100700002)(2906002)(33656002)(44832011)(186003)(7416002)(86362001)(316002)(6486002)(83380400001)(8936002)(8676002)(66476007)(5660300002)(66556008)(66946007)(54906003)(508600001)(110136005)(52116002)(6506007)(6512007)(6666004)(4326008)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F5X6321PDOD2+/gWDd/qAdfGaKCqe5DNTNeblKtYkrIKdQRSRRIcq8xnb2hB?=
 =?us-ascii?Q?lahzhv4HC56OEJ/U6onfHKRL3aP1mvTxqFHL9h3HglYjapWpXydk1tZhKfFE?=
 =?us-ascii?Q?AINMQ5tjJ4jwoWFB/HQa7mOtgbpNR5FOfDGyPW/39iTlTbc0DStCUbpMeD9b?=
 =?us-ascii?Q?bYWxFM5D/wqfrcItNgVBc5KtdtVjsu/mZi0fcj1tQs7u3CSdxfdlZhJMeedI?=
 =?us-ascii?Q?hgT6awVjILOrB87xPUPvz8lzykVC4KIgFSnZgViHJna3YhhPKyA7LZD3ltZA?=
 =?us-ascii?Q?0iUrhWzniYcv3im+CUPxxj4gAO4NPWc+DQU0vOy4Vfuw16hLzlp3IJZ/iIJw?=
 =?us-ascii?Q?4LiHbFItFRTKap8cF5SomjgJH5byvkjnGfyWoP63NK7igYN3bMow13XoflXG?=
 =?us-ascii?Q?amD7g+JgR4NzYUBZiyvpRBLJEYU4Uv9d717/RyvLauZyDoQRsg9g814j2lp7?=
 =?us-ascii?Q?QdwePlPV5XymjCWPhSybStpIZik9p+4V4Z3YSG5hKdCnMC1eEpCQuqSv5MB4?=
 =?us-ascii?Q?8nhu+2adM7lxejyrIai6JWDPBFlgV56d05z93b3ITi0I9LLD3p5ZDeotXV26?=
 =?us-ascii?Q?OResXXFu42mgtCVjmoWE2RXqUDrthwHawoUrs3Kf9aTnjCE2bZbz736YpRlC?=
 =?us-ascii?Q?apXXoH6NBS7SoTwxuVHEJK4zj1HeHRJ330Bad3MBju3fxf+0XGcveTwpI78h?=
 =?us-ascii?Q?9rvkEyRyqWVQHdesj/dQHkyQSbQPydn1bebzSI2P+UCYVoMn56gyWM8z+P+b?=
 =?us-ascii?Q?fMXehs9vNyCsAn2yAJWubS/5AIVk2wHCedVIEUXY1mQBjWwJqXXh+SQ7FYrR?=
 =?us-ascii?Q?QXRjKm1/OGIAXYssY6lqzfalA2fEBCHHt6fGyCofOzJ5A90pnH81T/G/AFJM?=
 =?us-ascii?Q?mK2nlh9J1TytpVmy0JQCd9nNiMnXJcTMeza2M2O2qQUDhkP1//yEUu3owouK?=
 =?us-ascii?Q?7nynp3HamsDd2318hb6Ti/h6xeTMziBFnBqUc0w7Pnwa5QmT0PC/D3Az2eB2?=
 =?us-ascii?Q?zqIdQYW1offcB9C4ws9ySqyiwN5wWPB0Gc6bYjAs6g+dt9Iy50P+BwQphYXK?=
 =?us-ascii?Q?fCdMuc5ADiW/UPMLmFse9P0RC6l/gVaf+FPVKPEfHd571f8YZf1F6/S2icaO?=
 =?us-ascii?Q?e05MtGvx7Ub6jIhuNww3cxUUaeSzdBOl9sUy4Ockc1IzpX+czyGEu63QL6GH?=
 =?us-ascii?Q?LcWF+uL/PnP3lubWcLUTILQSrgEfZ5ss22x/2AUzliuxsxZbIMLGNbNHhLw3?=
 =?us-ascii?Q?J4dcVBQ7CD2/ZXgCRQMke4ofihrCtYSVGbqOUiBK/mcjzxdSUkySCXOa9VoF?=
 =?us-ascii?Q?l9peKoiT53pA/kNxhazB3zOLBlWsL38fH5EDC1haJeOR6ttHydNKmXi2wLFv?=
 =?us-ascii?Q?/YMdTDQJB3LtWulFclsnU5rNjWa1qmezTS5BSVUqG2V+LAr32ZIAC4F+0rmN?=
 =?us-ascii?Q?O1bEB6aW/q3THFD9edr/VhkeDEbB59owyNOoul1+uY8lFkgzBkE9vc4JVQzO?=
 =?us-ascii?Q?HFvF+5b2Z9VyEVxjDN/lZqitMNvppq18yyPvoU7zjOmaup62Kr9TT7A4xj2r?=
 =?us-ascii?Q?KUwAgR7ZBSEA/u9E9VR4sTICbViNw9r97pZG8u16zZATwaVKv7CFB3JHQjB9?=
 =?us-ascii?Q?VglpVRdbmkE96J5uv8cAIM5gJe57Ku+mU9xfSfRjwjmX+CklQlb18Mexvpae?=
 =?us-ascii?Q?QBefGVk4p/Sn0aeHf4FFmVkWpWATNeIrAqm7Uku9tIlGKQz9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22c9a1a-22b3-412c-d2b9-08d9ead2de47
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 07:16:04.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S35jtOpIXbnNITGlR7eGalVrQByRVJyO0poTmgpkA5WK50EStqbxlvnciN7IOOjeFT1+AW5rkKvS4niyQHLKb3gNRWjSV5TTTJEtYW6JqO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1269
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080038
X-Proofpoint-GUID: lyHKAIWJPes3Uh0YKglVovXBNh8RG44F
X-Proofpoint-ORIG-GUID: lyHKAIWJPes3Uh0YKglVovXBNh8RG44F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The btf__resolve_size() function returns negative error codes so
"elem_size" must be signed for the error handling to work.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/lib/bpf/btf_dump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index b9a3260c83cb..55aed9e398c3 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1861,14 +1861,15 @@ static int btf_dump_array_data(struct btf_dump *d,
 {
 	const struct btf_array *array = btf_array(t);
 	const struct btf_type *elem_type;
-	__u32 i, elem_size = 0, elem_type_id;
+	__u32 i, elem_type_id;
+	__s64 elem_size;
 	bool is_array_member;
 
 	elem_type_id = array->type;
 	elem_type = skip_mods_and_typedefs(d->btf, elem_type_id, NULL);
 	elem_size = btf__resolve_size(d->btf, elem_type_id);
 	if (elem_size <= 0) {
-		pr_warn("unexpected elem size %d for array type [%u]\n", elem_size, id);
+		pr_warn("unexpected elem size %lld for array type [%u]\n", elem_size, id);
 		return -EINVAL;
 	}
 
-- 
2.20.1

