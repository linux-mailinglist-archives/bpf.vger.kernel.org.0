Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CBA444E78
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 06:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhKDFyc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 01:54:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230011AbhKDFyb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Nov 2021 01:54:31 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A41xPwE001827;
        Wed, 3 Nov 2021 22:51:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QIAz4MYIf7myn43+GKccNwDevsRd+U9UWDYePJMKVuI=;
 b=gUUlYEDP3enHUH7U0jNQg21fFZRmdZpuyBTcTkR9D8k9myGozzQRiwdAzh25xbmcUS55
 P2EFEQD/vET6yNWGfK5bkMYsFWtA8PVs/8Yjgdt9klkAotEDSQITvT4OkgG5Vw1Oz/p1
 3KXept7mFnRdYMF3aKgAT0BklpTwFdq00dg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c46b61g3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Nov 2021 22:51:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 22:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoyKKQyQDDfkOf1CPGSXOzheXFSrKVrjPMBDgNy82HDyGF7TD2qNANTgCrvyfJfi+q3K/XLW2kIUatPy7PiIhI8cFOk/cziTE4nvjNeEGXE7i9sUwFwZ9UN8CtCzhgqavNrCJoggLYvqaEl5Oy7+lnzkLg3YdkKVh4UQE4rZ8KtgehteEmLfQ/WwkYT0e2oQDeNaFKKVMl86J4lg+kq9vco5eDHe4B3uRSrnNBDA5vCTuPYjNKHHTOnzqKJ4+AQQttejERHurYCG+lGKfL8gVRa2/biiEt0r1asbTr0+ONWapHO8VDb6GnlpF7a//dgHyAFwX96vMhzBkB5WKW/QdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIAz4MYIf7myn43+GKccNwDevsRd+U9UWDYePJMKVuI=;
 b=n0TmSDKzr/iiLVJob/IE610ZYe127ZJktZMAZL6QVkjNkNYEVczqxPPM/0vlEZygAu8teC5IHVpxyOWXgQOmRgUCHp56BNcNAgDWq9u5J8sfLAiH+i+W82Nit55LvxllbIWwp5EPZyzubxuRLruir7XDEHUi6/sfEJvps46DlrwzvYqa2ag5X3k8B2MOxc36+9AWzp+e3vVILwmEGdrdXW9mOA9t59VhZI75uvMOB4+P5sT5V8FM43LWp2Xf3JTeJ39s6uwgislVMkMLF2tdbHWKDhpv+y6ayM7dJLwvXFNUATAshSbiCDj7UtH7uVQObrUNgf4lc+Lu/DjtNIpa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2288.namprd15.prod.outlook.com (2603:10b6:805:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 05:51:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 05:51:24 +0000
Message-ID: <93a6caf0-5b69-3788-7460-f56a3944b65e@fb.com>
Date:   Wed, 3 Nov 2021 22:51:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next v5 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
Content-Language: en-US
To:     Di Zhu <zhudi2@huawei.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211104010745.1177032-1-zhudi2@huawei.com>
 <20211104010745.1177032-2-zhudi2@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211104010745.1177032-2-zhudi2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1253] (2620:10d:c090:400::5:d1a6) by MW4PR04CA0144.namprd04.prod.outlook.com (2603:10b6:303:84::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 05:51:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3399a6e-ac38-45e1-6b1b-08d99f5722c1
X-MS-TrafficTypeDiagnostic: SN6PR15MB2288:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2288F9EB598DE813C72283E3D38D9@SN6PR15MB2288.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fj7eXdAWUpjhgutJGqo8efDx4LJayrugN+qMrpcDa6sikKrY2+VeZE49XC2wSjFxNrqFe8o6hDwAbLkHcLO/JcP9U+DVYT8+n45Icv0cmnl3QZvQjjjT2GED7mC2Kb1sbgGqtHDBbdB/bUzpsAgtixZ70H+Oots/F6M9boc1emBs2+mvyBiiHHLQ1RdmIvYJy8WW9mvgeReeqdUWGAbZZxWrgBlOq0H+5V7NixrhqjAFlMcgmGSY8+2yWi+P0slSOLCwtbKIHG5xbsiloAcblHO/Oh6HUcV59dv0FtJOlGwdL9C1srL/EcLnBwpEhUSOoVj6ms5KDeDokPbqgY1v1hvJ9IE9dsSo8xgB1jc+ySdZA8b5OZiMqcD2virLtsqBWgBVNsSHfNaKB13A95YmyvwnATex4UFDpz8x6MfGWGbYBna75vT6jJFh2KpYcxxB9eaG8SP9UnUUmph5mEwwlzFPswOCwgsFZuxjg1kWcHKKoTqMKk6ICqDBvEhdu9asf32pGhOPUsNKljouyk2XG7gHZcFtdiGDc9XAzbEgIFNRjP1dRAPr+bOWotWjZxZofvs2+GxpK118TN2n5fZi7smMXRgtICONWzT1cddh5Dig1mW2Pq0qK66i34BnuL70Im8N9dlUaOobQTB3r2Jyr73HdHZv/nZ4HmYz3JCR7Ol1yjFR2zFxWroArhjVk0vjltmZ8bZ2jB5Xr5wagyVYSj2ffDpFbelafBEudVHpkUcP+FQV0B0IA6UBIPnC0mq8NwHUm9D3EwGG8I/A3aTuMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(86362001)(508600001)(2906002)(66946007)(7416002)(316002)(2616005)(186003)(4326008)(38100700002)(52116002)(8676002)(921005)(5660300002)(8936002)(66476007)(31686004)(53546011)(6486002)(31696002)(66556008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmRhUEdUSGpRZlpmcUlqYnRLaC9hNk1uVmc2T0poZFhGSGovYTFwVUJ2TzdX?=
 =?utf-8?B?K3lxMEhhbDZwK1FHeWNFWEF0ejQvNW1VcFg2OU9JV0oyRTZVMEpzaXpGV1dY?=
 =?utf-8?B?UVZHM3hyVWp4Ziswb3VONU1zc05VRlp0VlFacWJGQ201bldjZnBLRDc2ency?=
 =?utf-8?B?SFBBblIyU25SdGRuVlhQWWhuZmwybnZnK2VXRDh3NElqZlFaWUJVTXhsTU1j?=
 =?utf-8?B?UkdhZUJweDB4TnZTVE4reGROUnl2RGxvZlRhaklPWThSYW5iTVZpSDBhVGQw?=
 =?utf-8?B?dlNpa0hlRGljNGRqUFRTRjZOZmEzczh1MkdIQXVjZERrcUlNV2R4bUszdTgy?=
 =?utf-8?B?dzZHLzBFVDJxdk9oc3ZZdGdnZ2FkU0NVTVdoTXBnbEFGVVpKZ2hDQzN0OXlP?=
 =?utf-8?B?ODczcGlyOWk5TG9JRlFFNkRZTE5GMTVrRkdMWDZhTjkvRHRZbkZDU29pb0RT?=
 =?utf-8?B?TTlBYnZGdXpRcjEzMXR4UW9PUktKalNheUlhaWd3azhmeVpaaXpVem5DV3dn?=
 =?utf-8?B?SXJoUDZrL09UV3BGeEVoWjh0RytjY21FcnRPU2JqQXIrM1F1ZndBMnZPNmhq?=
 =?utf-8?B?bTJRZVRQZ0dHamVwYkhKWWtMK3h3Z0tkRXlrY2lmMXl5T3grcTc3RExySytI?=
 =?utf-8?B?ZThMUDFHNFFscnc4UkxMcTQzQlF0NU1SMXI3U2FhdTBwZUxuTVdna1FKeHZI?=
 =?utf-8?B?V0RYSkQvU2QyZ0Z3OU1pcUZwWi85UGR1MmpYbEpBVzE1UlpRdDB0VWU3OEFl?=
 =?utf-8?B?NWNNbjNGVUFBWUVGVmZYdGY1Zk1qZE9qbCt0SmNOTGwrV1hhNjRUbVF2R3FW?=
 =?utf-8?B?OENwdUpyZm82SEdKbmQ5Z2p3b0dkbThEdGJ0VmVEakRudEo2WFhyVHBhMFhF?=
 =?utf-8?B?Q3lpbXY4NlZZVWk2WFpKK1VKZEg1S1BsMDZqc3hmaFN2ZCtDc1hzSW9ZMWxZ?=
 =?utf-8?B?YncrTURTSEVEL2lBbFJwVlFURk9wREEreTErVkZyRy9ycmdTNktGNUpFOWg5?=
 =?utf-8?B?M3RQT3o1TE0rQzQ3T2dtK3p2OC9zL2x0dEFzaXBmb01jUXRyRDZPaWZPS3l4?=
 =?utf-8?B?U1lFdkI3RjY3Mm9GWGZ1RVJNdlpYZG5vSjYyZnNBdDNsdkdER1ZDL0IxMnZC?=
 =?utf-8?B?Sks5YS92TzU0dnhLZ0JNQ0RIN2JjSmZtV2dVdVNmRWhtT2xjWWZRWGNaMHRh?=
 =?utf-8?B?NE9JdHk0bWJCZFcrZkZ3SFFXSE14U2EzdFlPblRMa29WejdsMkg3Z3hITEdv?=
 =?utf-8?B?eU9uQTBYbFV5eTJOU1FQenlzMTdLamkvb29ycjFZb3k5ZVorU2dGQm40WWFO?=
 =?utf-8?B?RWUvZFJJaDVKQVR4dVRWK2JwaWc5c0txZFFYc2M0UzFIaUdrSEw1RUdmM3cx?=
 =?utf-8?B?YUtDcXJCY3BCU3pua1lGU2FaSWhDZCtoNEJZMXhZWXEwQ2dSOXFwNEZ1eFlW?=
 =?utf-8?B?cGtSaFJyOUlnUEFvUkxpNWxCcVNaaHd6bk44THZ0R1pvSllwL3pkTW1ZVFpF?=
 =?utf-8?B?OG5QZTRyM2xVd1U1TTh0Q3dMTnhIMGg4N3VPWmhjcE5mdzRVNGFzeGRQbTdO?=
 =?utf-8?B?OG5DWFl1OTB2TU0xaEdIelo1Szc3cUMyWExPL29MbU9BVnBidWZwdE1TL0xa?=
 =?utf-8?B?RXlQUkxwUjJTQnFhZ3Vxd3F1OTJ1VDJYSHRXWE9RSGtvRjZtTGtxSjNueHQ4?=
 =?utf-8?B?V0cwS2o0UmhHUXFDbnp0ZmhsTDNIV3dYd1RBVjRhMk1BeCsybzY1bTZFdmQ0?=
 =?utf-8?B?ZkdkSm80K3prcFZTOUxwaUN4WERQRHM0cys1MEMyTngyT2RVVFNtQTNwWHRn?=
 =?utf-8?B?TU85cHNCY3lMVmtwRTdmS2VZQlRldzVhdGJTUk0yZ3dRcE05ZG85QUFacXg5?=
 =?utf-8?B?ajZLdWtrdmlaS0xXaDBpRG5RRllsTGtZK3FhRld2TlJOUVpxL0ExMkxZQXRP?=
 =?utf-8?B?RDFyc0huUkFIclhKV050YlhhMWFtWGpWRUZ5ZVFNYU44ZUJmNXFQMFRwMXgr?=
 =?utf-8?B?RnlRdTdpNkJjNnNHMnJYWUI0MFFUaHcrTnovMTJpSzhpN2VkamNrZ3FkeTNz?=
 =?utf-8?B?N1Y0bDlBdjJGZkNjTENQZUkrSkpPMitmcHB6TmRhSm0rdWtXL0IzM1p0bWZ2?=
 =?utf-8?B?cHVvTUdnTU85eHlKeW1XLzIrdWw4Ym5SZnBJaGpudHJ3a1VFdUhCQmtzK1pO?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3399a6e-ac38-45e1-6b1b-08d99f5722c1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 05:51:24.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2ARuiF38YxuttjPTlJ6uz3jB3usVlgW/IhsZSRn/z760z44ZWFpuNoiZm9AQ3/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2288
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: RaagSrThL-kfeu6SQWstfvrtm8_H86xf
X-Proofpoint-GUID: RaagSrThL-kfeu6SQWstfvrtm8_H86xf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=927
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/21 6:07 PM, Di Zhu wrote:
> Add test for querying progs attached to sockmap. we use an existing
> libbpf query interface to query prog cnt before and after progs
> attaching to sockmap and check whether the queried prog id is right.
> 
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> ---
>   .../selftests/bpf/prog_tests/sockmap_basic.c  | 75 +++++++++++++++++++
>   .../bpf/progs/test_sockmap_progs_query.c      | 24 ++++++
>   2 files changed, 99 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 1352ec104149..de8f91d91240 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -8,6 +8,7 @@
>   #include "test_sockmap_update.skel.h"
>   #include "test_sockmap_invalid_update.skel.h"
>   #include "test_sockmap_skb_verdict_attach.skel.h"
> +#include "test_sockmap_progs_query.skel.h"
>   #include "bpf_iter_sockmap.skel.h"
>   
>   #define TCP_REPAIR		19	/* TCP sock is under repair right now */
> @@ -315,6 +316,74 @@ static void test_sockmap_skb_verdict_attach(enum bpf_attach_type first,
>   	test_sockmap_skb_verdict_attach__destroy(skel);
>   }
>   
> +static __u32 query_prog_id(int prog_fd)
> +{
> +	struct bpf_prog_info info = {};
> +	__u32 info_len = sizeof(info);
> +	int err;
> +
> +	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
> +	if (CHECK_FAIL(err || info_len != sizeof(info))) {
> +		perror("bpf_obj_get_info_by_fd");

Please use ASSERT_* macros. These macros are defined in test_progs.h.
We may have some old files still using CHECK* which are not converted
to ASSERT* yet. But for new contributions, we would like to use
ASSERT* from start. You can check other prog_tests/*.c files for
examples.

For the above example, you can do
	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd") ||
	    !ASSERT_EQ(info_len, sizeof(info), "bpf_obj_get_info_by_fd"))
		return 0;

> +		return 0;
> +	}
> +
> +	return info.id;
[...]
> +	err = bpf_prog_query(map_fd, attach_type, 0 /* query flags */,
> +			     &attach_flags, prog_ids, &prog_cnt);
> +	if (CHECK(err, "bpf_prog_query", "failed\n"))
> +		goto out;

In this case, you can use
	if (!ASSERT_OK(err, "bpf_prog_query"))
		goto out;

Please also change below other CHECK usages.

> +
> +	if (CHECK(attach_flags != 0, "bpf_prog_query",
> +		  "wrong attach_flags on query: %u", attach_flags))
> +		goto out;
> +
> +	if (CHECK(prog_cnt != 0, "bpf_prog_query",
> +		  "wrong program count on query: %u", prog_cnt))
> +		goto out;
> +
> +	err = bpf_prog_attach(verdict_fd, map_fd, attach_type, 0);
> +	if (CHECK(err, "bpf_prog_attach", "failed\n"))
> +		goto out;
> +
> +	prog_cnt = 1;
> +	err = bpf_prog_query(map_fd, attach_type, 0 /* query flags */,
> +			     &attach_flags, prog_ids, &prog_cnt);
> +
> +	CHECK(err, "bpf_prog_query", "failed\n");
> +	CHECK(attach_flags != 0, "bpf_prog_query attach_flags",
> +	      "wrong attach_flags on query: %u", attach_flags);
> +	CHECK(prog_cnt != 1, "bpf_prog_query prog_cnt",
> +	      "wrong program count on query: %u", prog_cnt);
> +	CHECK(prog_ids[0] != query_prog_id(verdict_fd), "bpf_prog_query",
> +	      "wrong prog_ids on query: %u", prog_ids[0]);
[...]
