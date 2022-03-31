Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716664EDC14
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiCaOwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 10:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbiCaOwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 10:52:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B9421FF63
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 07:50:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VCE1P1027915;
        Thu, 31 Mar 2022 14:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=voiFk9cX4zyernJqPf7AhNnoi4I5JFsY9dvd8MPgxRU=;
 b=IZDkidfwBClql/tEiDqApphswMWZfcT8ebeMuFQpVPVil8wpnXW7c5IXkFrOC8kE7/22
 2S1etlSmjEpIknQljApV4neZAT1R9e4wBqLGr47SrlOf9qftRgwkR64MlI9leK96GwnL
 yrKeqAzrdt+A6CpSxhMZZaLpp0K7fCIoxLLaokwEMq11WRUgppGg4EmtSGMBbtnA0Zj3
 E/hlTBnCbewxDuTncBxTU/7olhaX1+PoXLqWGZhM8NNyd04zrlKValJuUozhb1Hf4Eic
 mKnseMgPxe6QCzlAgvNcbtIM4hSTJn6rkJUIPK6OmNtA1F0Vnry+XofSkWp+hLL6Y5g0 4A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2mmct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:50:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VEjPn1036385;
        Thu, 31 Mar 2022 14:50:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95f3gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 14:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkiRUZDZxeADuM5IXbMBs/jW2Yb9YioBadjIozaJXyoiXXtYDJvhFSPB+fkVSqwMHKd0iYN/zoFd9N5SAFLK5OpI+XHjwTYnoW2tWf/m6q9LzvSl8mME+erEccPafsp0HXD1MsFJlFeFocwnoAz9TMfXONDfF/CgAbJTsu6y0U5KvyP8h8raYAQ7rFjueA3abE6NRD7J5TZgeajQQFWwgrqhZg0HK3z5vAonTadhXHD8BsGeH+6emsc5oMavGmGRVZoO/UfivPuUiyQYgyxAwGF2QrzTbrVLXjUDUbsJ4sIKlbtLNx9zFxM+zzTeBzSUdr1GOC4GbCoKKZY4X18Iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voiFk9cX4zyernJqPf7AhNnoi4I5JFsY9dvd8MPgxRU=;
 b=UuDpt/+Dp9XPfsBQcxY8ESt03XQKOH0E0T55MDNuXUgE/4KM+FY5cK7EqzPaOS08DqoWMcZiUCIlTR7ZPOx/6xrEOnbm0XjHVG+aL3ZRg3Xt+VUOkSIz9MUgd6ORUR4x3iC/a/bthdRfv7onMH3NzJ1+OT6oxw2r8tFRHt6gIcEX+2LQHvsMw0Kd3nxsMGrw6SIiBeY+eGSMyM81RFQYejIqrsJtGALZTN4dzGpxlNlq0yH4RY+hM3LFElyEjeQ4G1Vy3BlcaLyjgYs78A12c4Fh3QW1xCgY1+GSpRcSn86P3x860zdnNivXARKpJgusfnLHS3el6IbLcjqHDUQ0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voiFk9cX4zyernJqPf7AhNnoi4I5JFsY9dvd8MPgxRU=;
 b=jk2rg8vDGAlQAgZ8vuqUGtT/Mk6SIcPhZtzlDrjI/3ALF9flv8NysKbGOcE1nz1pcY2aIiFV4Ps1rgqv7OLNdAOmO9+nvmoSnrwIvQqkaIpesX0veHg1Qlvh1S06W9HKgKCzSXLfaDObjXBaGPI5psuakJ87/cidAYRoUn3rLB0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN6PR10MB1666.namprd10.prod.outlook.com (2603:10b6:405:8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 14:50:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386%4]) with mapi id 15.20.5123.020; Thu, 31 Mar 2022
 14:50:06 +0000
Date:   Thu, 31 Mar 2022 15:49:49 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: wire up spec management and other
 arch-independent USDT logic
In-Reply-To: <20220325052941.3526715-5-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2203311518530.22469@MyRouter>
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-5-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4469d52b-374a-4031-e31f-08da1325bea3
X-MS-TrafficTypeDiagnostic: BN6PR10MB1666:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB16660F0FA4EFE721F24E1688EFE19@BN6PR10MB1666.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7XzG1AtGiORiMmO0gd1D3gFsoq9B9r/NSPPnMf/8RWQJoqnJddNHXIvATw4P4kdNS/UlvPoUwuIC4zSDdes4DHuHyV0wuKg1aTLKxyi+hf3CO6cKo9q/7WPXlvyF6G6i5NAwRgNM4N4CHtBSI9IHpLcOdG50+a9v4FvkHObLG2dA75ddqZwm+rOeDVDD5CPPjDdulbGUmhMDJ2r1bA6pBW/IQjZMQ0yyGdRLs2h29q0mlcNevJQ4lhb6r0VsHRTUe5pEvvGX48ZAUUpIGVKatYQ4xnXo9JFtjE9KKUtb0BxYrS1fHHjBDcT0XpRCqObwFB8mF9Q3D/R4MgZWBXsWi32VBPxEL0meUsPJzUQ+T2GUtFG8pUdQqZcSBEJbmp+emQwjw/M6NTrPR22xkTJg8Ribp3jD3hlyo7iVVNv4wzYXNVP6KD6n/zIhNKEjDx/Mwc1YKMgYLp12zgRhE0iGCSczTtE+JHNdc7Yx//6UwVj+PmLyRv7fXOU9XrGl9uCGMmHyQQralMEenvwLtjS81s3JoUYcU5mFdVjDu3eRM5wDOWfga2uMfcB2XlYSn3LB6xoTidlBBsVZDeT9vXEwXa3su0HNFZ4AoTvGe0MQzm5V+m+h3jVhnHV6CPVZadtdNTFV1I24nztHUMyHgw1wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(316002)(6916009)(186003)(86362001)(83380400001)(33716001)(508600001)(9686003)(6666004)(6512007)(6506007)(52116002)(8936002)(44832011)(4326008)(8676002)(5660300002)(6486002)(38100700002)(2906002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vTvvnOqx7XPIrSEPJ3iabpmsGHu92nsdysUhIF3IauS2lG0B0zgzS8CKix0D?=
 =?us-ascii?Q?BjyvuHkgJf5uukQcVsABwZeWcYjbC5/ONJ4dAmWnDiJbVq7wc2G6Kw5yMfnv?=
 =?us-ascii?Q?du+ncdK7no8l+t9aFCFmGasUPp6GCiDyXVs7Vx5e1I1y9XyAV6i9/s6PVCsr?=
 =?us-ascii?Q?J5BkUTv4y4nWhqrfMI7ccP06vhvq5FjVnW2Ltb6rfPJZw9E0agY1M1HBV3J8?=
 =?us-ascii?Q?aPW17VlPUH1/ZBUJSvmR/T51QtCLfH3TeUpz64uFIfSNNxy4Ojxq5DzXx7JN?=
 =?us-ascii?Q?P61wpYl1wAxflMKwz5LT15+QOWwGQWxNFOFAlF+INyawXgtlKcQm96O92lWh?=
 =?us-ascii?Q?eF9O/BxieNL6HcpAosrhyqgnredqyxWHIOsvVzM1eB5ffCsMhnp5tyUZlAt8?=
 =?us-ascii?Q?GCTCv+rOqHcnINRTm1VbBJXOHlPovxjRmOt5w+59mhvbviVHw1NqFSSxNvF/?=
 =?us-ascii?Q?EFuE4UDHb7MHZR5Z1BoLvRsrCPRUzybDwtYwwNh+XLnvNP8w4tetmlm6i/iL?=
 =?us-ascii?Q?kA4lLT5KSArxWrg2PkN8TEu4UBAQx5a9wJhxwpE7GgNjujE1Z09OEXbZIJCE?=
 =?us-ascii?Q?XvhLrBq94fBh69RSYO/Qxx9xMjiy+eDFRjjqkadSX9waNCuQ5a4ZAkVrNHeP?=
 =?us-ascii?Q?+6Fxy9Y/JNiRbs7IUbF1Bvhqqk12o0RjNo0l4IcmeejdPCyp9LEvXWo6o5Zy?=
 =?us-ascii?Q?wq6jO9Rx/wH7PUl/GPijvlrHF1kjoZO1MQWuKcOTmlm5dFmEd1+6pRYYGB8o?=
 =?us-ascii?Q?380nxEx607EQEjRBZ8NxCayBn3EDFOOWSZoFseGJeGVJX9NoaniWvd7S/aWC?=
 =?us-ascii?Q?VV2tLRNlQ/f11sSoBNxL6wydJBP8gdwCVh860JtfPe2mLajyZcfr/5RC/aRo?=
 =?us-ascii?Q?1oKKCtUDIvnvzNMyhEAAvHruCq/BThrBIk/L+KSs9QRwRlAnybJidDza8gjO?=
 =?us-ascii?Q?qYjJzpEJ1e43XX5Qm4iPnOdkb4vgEzQTc/VoGAfXFm0Wwdb0DbQLxPFoRnpw?=
 =?us-ascii?Q?BakSDnZNlZoFlfOhMwAxDuUwAXsuwxQmSqvHDapyDe+mJ/A4O6aroLSIWSpS?=
 =?us-ascii?Q?KUZIQoC/Knw1hwskpfvn58fV4Ou3A8/SJIqsni/vsH+499xXFpQuhC/2pkZ+?=
 =?us-ascii?Q?4MiJI18VF51UsN5ZZMl7iuTcXhcJkleQ18610768FPklvFWRXzOGug+dc7Gi?=
 =?us-ascii?Q?qpGkpgd8tynozwSy0nHYRe+4IV2wjBp3Dldtnfjh5Rjj692o2A1LEYvxrKhw?=
 =?us-ascii?Q?55KWCz8jyzkS+m5+9Vp8znDMDlIx0dZRfKCutpTbFZyEo76E8HE4R8VqRBl4?=
 =?us-ascii?Q?eL++hg8ZUHc3cOme+3AWa+coRBKldj6OgjpsAlpi5Oo1ssQNyDEHYyU52BpA?=
 =?us-ascii?Q?u2LrvksNBI+clQ4cCMbMY0uALrXYcplZs6EqWE4RFpsV8T2/MZR6ZZ9p4D3O?=
 =?us-ascii?Q?rcqJPI74S2gd5UJE0s9p7f++gHf1ikkL0QiVX9epYzZbiEv1wHYqC/KodWZj?=
 =?us-ascii?Q?wBYMwjc9X4i6QnjsKSEQijoCF6hxTjiyMZWS8BSE0bW6OnOiy/jbLCNT8moj?=
 =?us-ascii?Q?KAYPUj4qX6dh1QzJ1MFsOCb99WU3FY3UVwXyEmAzEXNLDCKqj9NycGdMTEG6?=
 =?us-ascii?Q?YKCYouvS/+oIq+NCZQ1zQDicPnjl/jrj+DZ9vkVyh5Q8jSKyGA+emEP6zjCu?=
 =?us-ascii?Q?Lp3lAioIPPdHAfNs6RP7s5NOm/DoMiBNl4+zKmBYogqYdUj1Wp+gAnEAU4vr?=
 =?us-ascii?Q?xNqbDQeMpm8DFVEsne3LMShTZxAvvt87Hfl/srWByxniBumMk5to?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4469d52b-374a-4031-e31f-08da1325bea3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:50:06.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGUwv9rwuOxfif2LlM+ihz6zB3MtPk/hg6+Xa3+lEJzEYbHjEi3QSJgm24sDaFppxueP+QMkxHe7NKyD5O+w4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1666
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203310082
X-Proofpoint-ORIG-GUID: nZiKskCApf72y-hbD0B7e9n5L7W2aC5Q
X-Proofpoint-GUID: nZiKskCApf72y-hbD0B7e9n5L7W2aC5Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Mar 2022, Andrii Nakryiko wrote:

> Last part of architecture-agnostic user-space USDT handling logic is to
> set up BPF spec and, optionally, IP-to-ID maps from user-space.
> usdt_manager performs a compact spec ID allocation to utilize
> fixed-sized BPF maps as efficiently as possible. We also use hashmap to
> deduplicate USDT arg spec strings and map identical strings to single
> USDT spec, minimizing the necessary BPF map size. usdt_manager supports
> arbitrary sequences of attachment and detachment, both of the same USDT
> and multiple different USDTs and internally maintains a free list of
> unused spec IDs. bpf_link_usdt's logic is extended with proper setup and
> teardown of this spec ID free list and supporting BPF maps.
> 

It might be good to describe the relationship between a USDT specification
(spec) and the site specific targets that can be associated with it.  So 
the spec is the description of the provider + name + args, and the the 
target represents the potentially multiple sites associated with that 
spec.

Specs are stored in the spec array map, indexed by spec_id; targets are
stored in the ip_map, and these reference a spec id.  So from the BPF side 
we can use the bpf_cookie to look up the spec directly, or if cookies are
not supported on the BPF side, we can look up ip -> spec_id mapping in 
ip_map, and from there can look up the spec_id -> spec in the spec map.

Dumb question here: the spec id recycling is a lot of work; 
instead of maintaining this for the array map, couldn't we use a hashmap 
for spec ids with a monotonically-increasing next_spec_id value or
something similar?

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

one suggestion below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/usdt.c | 167 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 166 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 86d5d8390eb1..22f5f56992f8 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c

<snip>

>  		opts.ref_ctr_offset = target->sema_off;
> +		opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
>  		uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
>  							      target->rel_ip, &opts);
>  		err = libbpf_get_error(link);

should be uprobe_link I think.

