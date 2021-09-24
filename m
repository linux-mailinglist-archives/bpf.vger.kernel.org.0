Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07D0417AB3
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347965AbhIXSOm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 14:14:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36340 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344906AbhIXSOm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Sep 2021 14:14:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OHAIud021586;
        Fri, 24 Sep 2021 18:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=6N2bspk0netSEsGh0rHn4nr+61UfgV5niE3eUCgAA1Y=;
 b=VD6Woxz4m/xGOlw7ApCWPRchm9Tyk2JtCsaq5+YQOAtp7H/NO0W11RTWi1+zUYMWiQOV
 SD3QqTTKxekwF0dU3Dv6jy+M4WBjj5QCemsEzz05QZVDgMRup1OH+Kg7ulHbjh0ZY264
 t1+BHRtYGH0/9ci4MlP2PVjapfKizeq5bobfozhY8osv2Hb66YsMDBc1k7KzmEdVAnj0
 tIWo4cZBxDJ1152WPvW5hJfET9dbFpS4GqLi3TUBFEHQWQELdnS2YwZXjasFVZXwz45p
 8eD3OASRf98H0ilhidaY6xWf+axgqjGfc0KHV2G/At0wFpaD36BFoEDS86ewlIqlPWmS ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b93etw5bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 18:12:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18OHniku045732;
        Fri, 24 Sep 2021 18:12:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3b93g3knk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 18:12:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvN+i6//kKE/JVi2lXrEd1phlBMMy21LCIqBCaje9fC7uwxXDj/+BTi5PlXaiXpv3luzVKHCb6zXzjB/CLGPg0S9qndjaXuM7Nq1xBuc3htLsSospaKCt+WL2J5xgHxA3a3pVbZ57hOs3fTdCH6QZ/8C5RnncnwrCKND3pFSwkbveZtfE2iV+3GXJR+TSoM/V5/QemHt1/63PgKvBdd5MwGuy3Hag5fcJOjEBGkcmyxV11yGSWNZp7DeayNRh8PQdbTYbjoKmRD9o9eTEctlf8Wt8LeO9VHe+IY8sHscaKHozgkuKAUh+izrCbHOm0JXvHRzy/hXJPKdus3M9XxZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6N2bspk0netSEsGh0rHn4nr+61UfgV5niE3eUCgAA1Y=;
 b=T53ll3OoTHp3Z5NOI5wzDAIHZ1u7jQXT47Wh+tpjjVUCgF98lEi20hvs0Em7Q0c+CLknD7hl3eRGabVIdexhfV0QOvnbVzXMDtAJcFiqiO9s7M3CA15BH/gpd4MI7Z9ho8itcR6g/EiZgu1uN5PDqa2G5iJEGldJ1pBfF+dG8bQ9lT/PLKxs8ijJt7ifltS8VyJQ3RYWIHHdyDjPDCymmaMHtWTh/tD7pzs0bFqP0r7EaEVTtkrKQF0MlTXUbmbSW+7zcdL+z+HCvFuDMK6wy5LV+OSqimQQd7EkC967jxHKdT6WsiW1y+eXlpHSFLOw0i7CeVQ6wEbUwLPWjLat2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N2bspk0netSEsGh0rHn4nr+61UfgV5niE3eUCgAA1Y=;
 b=JDlKQQIaS1Rwu2p2mNbutpktWwdufs/U7r1VPqGEPkQRPYRD1lLaeSoReCLANSRAGdzL/VGKg/q1VKD5WKsV+2ff+b9m8SLdDEAv+lVAzvRBEKTufOeyxb8GnFUSTqvqG98d+TpUmnNBi/yzsEZ9cdPgxQQwOfxw/nbRIW2sz10=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB3741.namprd10.prod.outlook.com (2603:10b6:208:117::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 18:12:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9dc9:24ec:f707:cb53]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9dc9:24ec:f707:cb53%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 18:12:50 +0000
Date:   Fri, 24 Sep 2021 19:12:39 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Yonghong Song <yhs@fb.com>
cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: fix btf_dump __int128 test
 failure with clang build kernel
In-Reply-To: <20210924025856.2192476-1-yhs@fb.com>
Message-ID: <alpine.LRH.2.23.451.2109241911100.21067@localhost>
References: <20210924025856.2192476-1-yhs@fb.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: AM8P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
Received: from localhost.localdomain (2a02:6900:8208:1848::16ae) by AM8P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 18:12:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 551cbeeb-656a-400c-7bf9-08d97f86eb95
X-MS-TrafficTypeDiagnostic: MN2PR10MB3741:
X-Microsoft-Antispam-PRVS: <MN2PR10MB374197B362FAF45F47313D5AEFA49@MN2PR10MB3741.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/HTAFThbQJdrI+MBAsphQuEI2jbZVbVaofu43SflaKAqlLacqswn5Va9VhHi5MnoJbw7fksVN9IK8JA5bvXqY5Ne0ogUyp4UV4+WGtIg8WRhq6KIooZI8HYr04Fap5BnmoGfU0gOjCrtyweuOBTXDO9U78AwmoN1jLQ2bqQvFzNooNjqrLxvlIaPfVridw7o6tOhpCQUoAHmm7Co2EVHrhAyj3W35sRR+SZj5Fqc2cfov/p4k7u6ycSAlrRCcDTDPgZI/iJs0Hd4TR7BosFU5MDuXZFNJgVvt9t0qXDbZzymC20ozVMVvh/WXVQVlO3/Xq+Saby7InmUgQpo6dpUsO3Y/Aq1xBqaiJhOz5ZxuX5CNuafn26uZQnSIDoJYiHeyJrkKlMBre9yVSGPFoLyOp2BOi5nbsQi3ZJq2I/j50o9co0ju+H0DWSufmYSPhEIzLJpDKsbZr6yiGUnUJSfYzIN36fDfL+KsM9ColP10KZ9HGCvPZBk11u1AhSwLkmmNP7DIJqrVT55DXSScQgPVWA7TlfwBSYLMbnmm+C6pmsEhV/T6meCa7KdZudD3kX0/SFyAI84bFEJtPwJMcVJ1RiUt2ebr8dTewjzZHpfEzYVnyB2iSZA8hpwSrvWQPMTfXJLiBPSDuYSfRm/MKrYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(6512007)(9686003)(6486002)(8936002)(6506007)(5660300002)(316002)(4326008)(33716001)(6916009)(44832011)(86362001)(2906002)(54906003)(38100700002)(186003)(52116002)(8676002)(83380400001)(66556008)(66476007)(9576002)(508600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QTPltKLzW/r8cANxauEm12nh0hlpodCgZlutHc4ieEcOM0POMGlFFX+upqA1?=
 =?us-ascii?Q?bKicCzh5v6KMhGKB3W5kY8Ze2cuqFh5F/+DgkeKP+DhoYeMvw3OBSxh8W4PL?=
 =?us-ascii?Q?fklkkaNrYp9FFGY5JAnEdfhMg0oMR/rWB0pW3ErTSKSg4Ut2MyBHsNngJ3O5?=
 =?us-ascii?Q?Ou59dg/SnzNEjZeT0aZkxeftVDd1UI5Z6rCos7EkrkowcIIWwr/HUNc4rwEW?=
 =?us-ascii?Q?Tsz5+nv6bG3q4Mj1x9UI2nOZqlLhMiXP11cjN0cZPuIRA1oYd4rRtxjXz0Ik?=
 =?us-ascii?Q?7L7riE8dDUg6lXSeu0YsZc6MmnBvyC/hTqlzwKkArszC69N3OWoiv+ygx2eu?=
 =?us-ascii?Q?3InA/oNidM3hcQ1tsZ02WV+heY+cWxFwLyshHwMj27XmE0gBqbFFhh5cwaTO?=
 =?us-ascii?Q?nOH/+UGCH2rEtDQKRjW2uqOzKB7UHoH2RS1tzb62e5z0BnRhUHSykuiZdoY7?=
 =?us-ascii?Q?aQQ4fFSt9K9xMKXaZsQ+JmvNQ/k2d0PcQ8XLpN1BQh6QuQzz0X530FEkIjCz?=
 =?us-ascii?Q?IHvMPvGHrggJoruaQ1oDHazTfhJj0CCzTNLorCDrTbuFuXdlZdKIXS75NaUp?=
 =?us-ascii?Q?Kg+FBSRSUfF99t9v0fVHL1yJkiE2TZtLHDMeMYYbdfxyS6WLR4BxBTcYuabQ?=
 =?us-ascii?Q?taE1hGSI6rR+PwqPNQRpbJ+uCd1JbaI40wAuActbjcc3PmqI8VNgqRXRLJCM?=
 =?us-ascii?Q?BUS0tHYf7pPgNZ/hLORtM7hnzLwnK3M+c30BAiJ0hxltSOCFqWSnIJuTxPGW?=
 =?us-ascii?Q?yYcha92+0sC1nFNACgRKWhQIMzVjJKO2OS+UYz8mbl4sJ94Quq8AZFofc9Ky?=
 =?us-ascii?Q?gtnRQFD9MyCftbcp+3rKBHtlmUeGy8Q27eoholhcXWre2+R5YV5ZEXwvQ8vL?=
 =?us-ascii?Q?pv+tzMyfRzlXswNscg/WtRdHWdUVg9wFEwecse+9cdtbXDWAaziixNgex3m4?=
 =?us-ascii?Q?qdK7aUJQnJoIS6LgGMtvsA+VidjFMF+If3ZHaSUZsSzPEYQoFq/NNuF+1dSk?=
 =?us-ascii?Q?AFggJBQHFybeGpunKWHKmvE6qCSXwb2yGP2WxY+1uaMMz9GtC3b9iyUEqy1Q?=
 =?us-ascii?Q?ctW2qLmGx3gLqPFEMhrNMAxU/VlbA2Ql+VW5gzoB7/Touj0t3tahbfihYdwz?=
 =?us-ascii?Q?ruD7t20UFHU9yO9s0X80tqw0bEGI/qVlanaugJvsw5fbK2jg+2Pe3ghlow4H?=
 =?us-ascii?Q?Xt6FcatTU6HMcp9ktyimHW+DIEkoKmZKwbielhtExVvmxXUy6LxSg9rCD7XG?=
 =?us-ascii?Q?W3gDuHbTcC8FhJ7ED8L1xuGlQgdelNgHIohRNjOgM5ePC0pRAMLtzCDGTjcn?=
 =?us-ascii?Q?feQENexsHDGoFh5dwe9k/ZBhIzf/1tMVeFUQ0o5qTNU6b0SKqhXybCZM8+gO?=
 =?us-ascii?Q?4vIZFyQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551cbeeb-656a-400c-7bf9-08d97f86eb95
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 18:12:50.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPBes7LvZWhQ/pRcHqJfBs79qbZjT5M9EF2bVZqGU+U0ah128kFX1f7pcWPetL0TW9MCIxQYp0nWtqjvelA2FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3741
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10117 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240113
X-Proofpoint-ORIG-GUID: 3KNvxpIjPfTudaJM60Mn0IYmq1CrD26P
X-Proofpoint-GUID: 3KNvxpIjPfTudaJM60Mn0IYmq1CrD26P
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 24 Sep 2021, Yonghong Song wrote:

> With clang build kernel (adding LLVM=1 to kernel and selftests/bpf build
> command line), I hit the following test failure:
> 
>   $ ./test_progs -t btf_dump
>   ...
>   btf_dump_data:PASS:ensure expected/actual match 0 nsec
>   btf_dump_data:FAIL:find type id unexpected find type id: actual -2 < expected 0
>   btf_dump_data:FAIL:find type id unexpected find type id: actual -2 < expected 0
>   test_btf_dump_int_data:FAIL:dump __int128 unexpected error: -2 (errno 2)
>   #15/9 btf_dump/btf_dump: int_data:FAIL
> 
> Further analysis showed gcc build kernel has type "__int128" in dwarf/BTF
> and it doesn't exist in clang build kernel. Code searching for kernel code
> found the following:
>   arch/s390/include/asm/types.h:  unsigned __int128 pair;
>   crypto/ecc.c:   unsigned __int128 m = (unsigned __int128)left * right;
>   include/linux/math64.h: return (u64)(((unsigned __int128)a * mul) >> shift);
>   include/linux/math64.h: return (u64)(((unsigned __int128)a * mul) >> shift);
>   lib/ubsan.h:typedef __int128 s_max;
>   lib/ubsan.h:typedef unsigned __int128 u_max;
> 
> In my case, CONFIG_UBSAN is not enabled. Even if we only have "unsigned __int128"
> in the code, somehow gcc still put "__int128" in dwarf while clang didn't.
> Hence current test works fine for gcc but not for clang.
> 
> Enabling CONFIG_UBSAN is an option to provide __int128 type into dwarf
> reliably for both gcc and clang, but not everybody enables CONFIG_UBSAN
> in their kernel build. So the best choice is to use "unsigned __int128" type
> which is available in both clang and gcc build kernels. But clang and gcc
> dwarf encoded names for "unsigned __int128" are different:
> 
>   [$ ~] cat t.c
>   unsigned __int128 a;
>   [$ ~] gcc -g -c t.c && llvm-dwarfdump t.o | grep __int128
>                   DW_AT_type      (0x00000031 "__int128 unsigned")
>                   DW_AT_name      ("__int128 unsigned")
>   [$ ~] clang -g -c t.c && llvm-dwarfdump t.o | grep __int128
>                   DW_AT_type      (0x00000033 "unsigned __int128")
>                   DW_AT_name      ("unsigned __int128")
> 
> The test change in this patch tries to test type name before
> doing actual test.
>

Thanks for finding and fixing this!
 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  .../selftests/bpf/prog_tests/btf_dump.c       | 27 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index 52ccf0cf35e1..87f9df653e4e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -358,12 +358,27 @@ static void test_btf_dump_int_data(struct btf *btf, struct btf_dump *d,
>  	TEST_BTF_DUMP_DATA_OVER(btf, d, NULL, str, int, sizeof(int)-1, "", 1);
>  
>  #ifdef __SIZEOF_INT128__
> -	TEST_BTF_DUMP_DATA(btf, d, NULL, str, __int128, BTF_F_COMPACT,
> -			   "(__int128)0xffffffffffffffff",
> -			   0xffffffffffffffff);
> -	ASSERT_OK(btf_dump_data(btf, d, "__int128", NULL, 0, &i, 16, str,
> -				"(__int128)0xfffffffffffffffffffffffffffffffe"),
> -		  "dump __int128");
> +	/* gcc encode unsigned __int128 type with name "__int128 unsigned" in dwarf,
> +	 * and clang encode it with name "unsigned __int128" in dwarf.
> +	 * Do an availability test for either variant before doing actual test.
> +	 */
> +	if (btf__find_by_name(btf, "unsigned __int128") > 0) {
> +		TEST_BTF_DUMP_DATA(btf, d, NULL, str, unsigned __int128, BTF_F_COMPACT,
> +				   "(unsigned __int128)0xffffffffffffffff",
> +				   0xffffffffffffffff);
> +		ASSERT_OK(btf_dump_data(btf, d, "unsigned __int128", NULL, 0, &i, 16, str,
> +					"(unsigned __int128)0xfffffffffffffffffffffffffffffffe"),
> +			  "dump unsigned __int128");
> +	} else if (btf__find_by_name(btf, "__int128 unsigned") > 0) {
> +		TEST_BTF_DUMP_DATA(btf, d, NULL, str, __int128 unsigned, BTF_F_COMPACT,
> +				   "(__int128 unsigned)0xffffffffffffffff",
> +				   0xffffffffffffffff);
> +		ASSERT_OK(btf_dump_data(btf, d, "__int128 unsigned", NULL, 0, &i, 16, str,
> +					"(__int128 unsigned)0xfffffffffffffffffffffffffffffffe"),
> +			  "dump unsigned __int128");
> +	} else {
> +		ASSERT_TRUE(false, "unsigned_int128_not_found");
> +	}
>  #endif
>  }
>  
> -- 
> 2.30.2
> 
> 
