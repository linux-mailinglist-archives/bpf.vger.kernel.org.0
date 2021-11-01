Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F35C442049
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhKASwc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 14:52:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41880 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232100AbhKASwc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 14:52:32 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GofLK005653;
        Mon, 1 Nov 2021 11:03:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Jd75kcNl6pwor6JMgE43cHaeuCrfEepu+s+/8JfJppQ=;
 b=AVmvIVijRDBweiotA73nW+Hlhv2E31f6lO/XaMt5Bv37P6Wk+9vxl+urYWZ4hBnQxjEF
 iM/xIUv7J2gqulXcxBps+9l7KWXpe0NcqVJCg1bHjpkJbjXz6xHjuhjyfWMWKU1QRxge
 HELsvfFP+0NU3FDCVDCPCnoa/oXItS977ec= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2dp1kcu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Nov 2021 11:03:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 11:02:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PA3LL4bMQgXtB/BeocA6uf4sONsk6nK2C7QPLGhD8uUqQrIC/cCJPmbikP5pK4D8K9FZlnn6IlWW86lrSLiKZkNpxWrsjua1i4dAe92dBh9tU7upQPKs/255wCbEvUo4/mh8xtcbKMNP3Ql5VDYr60a8jwdiOInXAcgWu83TdvsSl+AYdT6oLRniDDSBItPtNBexxC3PobwH6WYH2PKLsy8QpCeCVJzeqDrDyEei/mq8Gm+yV0E82HneSEScbWSAnApHLwv6plHzWEid/n+sYgJhzcQLuMPo34qf5ZMDfSTOefy3CbmduIKpJ8U4dfGpoLCr2etpjTnljLgGmAb32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd75kcNl6pwor6JMgE43cHaeuCrfEepu+s+/8JfJppQ=;
 b=E479iDXauWYg53SZ2CfodMlyLVq/RffVnRE+aqYnPG+/pLFyKRw29iOaGsvtiGyT2ZhRqXtpzQjYXFj1da1Ajs22zRVSNLvythXXqMaQTO7Z7hSL+Ne1eU6r28NU0apzHJFqMzzuCMozHPzQmee9ogn3OIA+J8Lu5Y6WQUUesMr6a6wI26+pEZj8fb4AHbFz5E967fJr8WH53KrPJFIytE3shK6EWT8R9TFDLwsD6QJ5TnRfKMAGXpJejnFdbgMKiYchgeBKGWolU83HZD/lacb0p42G9p7UuC7Ocy3UEMRKpYX8DDIH0NHU3pd4DDqBFG4VVNtneS9KVU+3xpgWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4886.namprd15.prod.outlook.com (2603:10b6:806:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 18:02:58 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 18:02:58 +0000
Date:   Mon, 1 Nov 2021 11:02:55 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <Kernel-team@fb.com>, <yhs@fb.com>
Subject: Re: [PATCH bpf-next 0/3] "map_extra" and bloom filter fixups
Message-ID: <20211101180255.v6egjsnvujrl5eom@kafai-mbp.dhcp.thefacebook.com>
References: <20211029224909.1721024-1-joannekoong@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211029224909.1721024-1-joannekoong@fb.com>
X-ClientProxiedBy: CO2PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:104:7::20) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:6c3f) by CO2PR04CA0118.namprd04.prod.outlook.com (2603:10b6:104:7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 18:02:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b54b2a2-38a8-4164-9667-08d99d61d680
X-MS-TrafficTypeDiagnostic: SA1PR15MB4886:
X-Microsoft-Antispam-PRVS: <SA1PR15MB488674E8EEACF51D733B265DD58A9@SA1PR15MB4886.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6qePKBhkcBrQWDRFLFfffoYHrfe3FEdmaKRHiPuYydz90YJKHcpIePHzFpyeQk0i6tvtJrKstIVVj5k1PaTvmz1vnL4oaM0L7Rg2WxoeSPOUUdtymkImK2FLyKSzexCejTr/xITT0u8CkbdorPJEUM9qlei6ZIZa4Al6X6eJaHhfBhGELdjq4LLtdHwBSzt4UefNwtequGyiPPJyeJ7oeKveuuPmZIor17MHM2NxNFs+lMl4QV9yxueEraojgSsIvvZBrJkFzIpwqlVkeFJyeLAAhg1Xv4o2WasQy9grnwq/egBAQXfQ3I6qi/+199n8EDLdRxA3ZAsJzO4CBRcvH4IrlXXst0stm53Bw7CufaP58w4DjNCbq3AjIgr0GYmOavs75n1qghsuHdi+Adut5XdUIABWlZ85dK3215POI8NHffQctcE2OfQ+t0PxS6c9WIuO4iJU+9URXoO6vF6V7RaaQHgPOwGA+o4oeXx23QyhXa1Y2fO//2myR1091YznIrrJ/rQVgaaaIyi7xZFss34Y8bglXpnKbi/enFMhnMV0P5tibOB01PrSYosVQZzig/u3Z2haQTZuW0phS/cjzU8EqfOT9T6JibS+pudljZ8smeQ4xoa4qsXfWXu6AvCXRdZ188M6G1zx5WJqpkNEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(4326008)(8936002)(6636002)(8676002)(66946007)(38100700002)(6862004)(83380400001)(9686003)(1076003)(7696005)(2906002)(508600001)(4744005)(86362001)(6506007)(5660300002)(55016002)(52116002)(316002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wbPl9TEZipLzaM1mRoFB7vGrd7SEA8T76YHdl2MbdybiKKH0plRIfeFSKRPm?=
 =?us-ascii?Q?edl4BcZqkbKg0NZy6GyYQ/xAaeIH1/NhZmQhHz9sJ8XgtENx5FkpUD+G1i1I?=
 =?us-ascii?Q?aKqbmU10XNgQ0q4/If1BuYZtmh2oaT5sHtS0cMCciP80K9rj+tr/3p1bJ/n8?=
 =?us-ascii?Q?2IBs1aMVGDNbyrsqwjv5/G7dYC3jyuDAiJherzcwwJaiNcDUumpmbMzDyst2?=
 =?us-ascii?Q?9x7jFtxiFXpg+7DfVuy5edkqPg9bOBXQ3qi3CWQPWQtsF9hJy7Aaf9kidL3T?=
 =?us-ascii?Q?f1q6hDmtdo6/Sp9V/frQq7jJ8eEJcqxHlUTtU7jPHiT0wUe1hTi724ePclaN?=
 =?us-ascii?Q?xsYCrVCSwf7H6TIAtcQYzAEvfdlRb2vKLfCRmCOD9aQZ0R2yca25PJbjnrOD?=
 =?us-ascii?Q?0LlPeCQ8PdmbfyCk/hDvUNwlRg7YYt8P9RZOGm0azQJw3N7VI6UCmzqZgTdm?=
 =?us-ascii?Q?mrgZlnSUPpWNPkDxFZDWc9xmEUAUKCVtdQF6c7zEJ6YtbUH/3Pqc4n5/R+Ip?=
 =?us-ascii?Q?BQY4z0Mk50Mf75Cn8Vq4nd1FwL2UiP/EBpxctSE3dyQce3AhvrNweZGVav/q?=
 =?us-ascii?Q?piuAhpYIomFfc8ZUr1maG/joCQ1qUQxVB9rsR0lW/NF7CYFgY1c0VJnoQm4E?=
 =?us-ascii?Q?Zb1FhM8YFBqD+jDTJ6fWyzYwmJMsWGyM5fKaIWwEeh9Ch3C7s6N5It1r0Q1r?=
 =?us-ascii?Q?KbmS5MTSBujYsoXy25c3i4uT1SbidzPK0OA4y6hn3mkS2o8w+7VCApMHfpaS?=
 =?us-ascii?Q?8cPVrMijd2rf8ez5+AwtgvhiZYnOpwFuxVczXpxZEcPbPBy+SEKBr1yPRJUr?=
 =?us-ascii?Q?gewBWhudT4FGha3kVjWVtf5+Qybhv1F8tktZYxsik+reLMpyof/V5iuk4UUj?=
 =?us-ascii?Q?z/HY2zUKuG/io/MyizX+Aw3Jw/G6HZt1/nC/gLY1idUb4Nj6InX96VYHmRcu?=
 =?us-ascii?Q?J6q+9jv6Ii4/lY/HLD7ElUFENxwMhUkCWFgvyltQi2Z2poENIuwQvJ8r+Z9a?=
 =?us-ascii?Q?UkEbBBLqL3+hJGxOZC0I1LLdf/Jm5GR5jTAeEz6QodUToDmcQoPvCloid9oT?=
 =?us-ascii?Q?ImazhD/taCGXoe9SeV4A71H+uqJamiU0NJ71cJNHVtxVwzN0O2lwq5DW8rhK?=
 =?us-ascii?Q?BxtFhTWfu51dD3mwFQ5zVVihEvYwbmvI7ydsZt1QOEL673YnF4qtFkGBVnpU?=
 =?us-ascii?Q?IpG7VM4/pL/HfsBiTPVHHrwHXYVnYYoQQ0l/hPrnxDv6M7IX4p5qdQqc6ABm?=
 =?us-ascii?Q?oiQZuv8isLAXLVER8ku1FP3N9oA29ithOsfWErV47y20qHmFUwPdwzQhrpeU?=
 =?us-ascii?Q?2tB+VcGj54RomaElLmpGsQnEtGYb33l/k5ZIKsBME1jx3Muvr+GlkJsR6y89?=
 =?us-ascii?Q?MssOCPPJS3OX9nnJj0mlH7oEMFfq6ESlXTONN3AUV/RpZf8Ovhew1LZ2vSJn?=
 =?us-ascii?Q?rVjDwwPkCri+SuvLfgkOMSOTIZujLhcCKEx8uPqTf4pvka4mPpXdQKHcS7Uk?=
 =?us-ascii?Q?SS5z5u/r9oVIFGjtVQA7O2+nHfoT5kWyCCA/ZGb3fAkQsZGHonK9ifJB7FGc?=
 =?us-ascii?Q?NIk+CF1QaZj1tbCu6wbPWv+HX9jXAAmi2krdPD+U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b54b2a2-38a8-4164-9667-08d99d61d680
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 18:02:58.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsWGZbdlD6qhQRFuuIRzr+X3/SqNLe8ZmWDhGjauh2ZYKTLWUe9K9jn/4p6GCT3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4886
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 3V_IvdXjpxIQLVzhXd_06zX4BEHpdX_t
X-Proofpoint-GUID: 3V_IvdXjpxIQLVzhXd_06zX4BEHpdX_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_06,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=866 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111010097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 29, 2021 at 03:49:06PM -0700, Joanne Koong wrote:
> There are 3 patches in this patchset:
> 
> 1/3 - Bloom filter naming fixups (kernel/bpf/bloom_filter.c)
> 
> 2/3 - Add alignment padding for map_extra, rearrange fields in
> bpf_map struct to consolidate holes
> 
> 3/3 - Bloom filter tests (prog_tests/bloom_filter_map):
> Add test for successful userspace calls, some refactoring to
> use bpf_create_map instead of bpf_create_map_xattr
> 
> v1 -> v2:
>     * In prog_tests/bloom_filter_map: remove unneeded line break,
> 	also change the inner_map_test to use bpf_create_map instead
> 	of bpf_create_map_xattr.
>     * Add acked-bys to commit messages
Acked-by: Martin KaFai Lau <kafai@fb.com>
