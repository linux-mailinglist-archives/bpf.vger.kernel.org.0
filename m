Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C736F443741
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 21:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhKBU1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 16:27:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53610 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229813AbhKBU1T (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 16:27:19 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2HmLE2020776;
        Tue, 2 Nov 2021 13:24:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bw3ljdo9bNMwvG87/wdliLBfn+Aq/n6fxEVnePzI0sg=;
 b=R7mOAycHmJsGklmgpPRDiO+rAi4+/4as6yebXBIJiFxGqYnFCOmeq/wZCkSm2eN+hiw0
 po6NpA8a3bJR/4aJwRYbre4otDa93NLqebQ9UgZRcs4Q3GvFCWuQ0TvUDkxyCJfmzDbO
 fNhvAVHXk1nkOqURs1AD7babKS8dmYHtT7k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c36rgu9jm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 13:24:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 13:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt+yHK6tphaoM/n5LSzRcVLuPyfBI9ZUZ7b2vSPvFLXejD8xnRdm36Njtd4e1gL5sp2Vsa/lrRKmVCVzl6XexQdXj9YWZb7ERFGlqfTA7049sQ7ZB/5aF8M9NKVD3b1XWFLzsW7+fpRo2hBYMQBxZtZ6r992XbmYyJFWfRVFJw1J3XlDaH1rcm9QBA26dfOVQowExH+kHsgNvQil8r/F8BEMCmu45vU+p0/on6bN2VI9ECyEfCybzmlf1f0LI24y8he0DUOEcszqmA3OISgzchG9N6t4B8MF7DcrdD1wnsfVom5EvlOmZ21AhH8Zdr+CwuGO2v59wEiWoFjAjxCbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw3ljdo9bNMwvG87/wdliLBfn+Aq/n6fxEVnePzI0sg=;
 b=aZKQdr0SigpbIlT7DrJ2QN7NDQncAQ/ONazDy9L0d2OJPgX83jkpMwxbUYNdRvvRCsUOetcjIPa/V/kLiWUhlaSPmZ+u5AFbUfdTF0u3ciwdHv1UoRhNs6kaf95/awZ7rFdabJK7NEUES/lDYSiGSQw1YA8t5r8tk3JsCcbioKdiglGauZqzl4BOjCDG8IB7uLbwXECsw5o4Y69qTZUGik6e5ludG4tJk+IzFJapTnfCc7I8GrjktT0tjRB6K6sX/gbaSs34J79uHFGwfknmpxSQuCoq0+pXb21oTG4i2Go2yVIJ/j5Miuadbv4IcEaS+NJpAps9Eq1wxHGclkeH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4657.namprd15.prod.outlook.com (2603:10b6:806:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 20:24:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 20:24:10 +0000
Message-ID: <eacddbc8-a255-e3e4-c4b4-b76db09d7bfc@fb.com>
Date:   Tue, 2 Nov 2021 13:24:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next v4 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
Content-Language: en-US
To:     Di Zhu <zhudi2@huawei.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211102084856.483534-1-zhudi2@huawei.com>
 <20211102084856.483534-2-zhudi2@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211102084856.483534-2-zhudi2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:2e35) by MW4PR03CA0229.namprd03.prod.outlook.com (2603:10b6:303:b9::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 20:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd80c53-7bfa-40a7-5e7f-08d99e3eba73
X-MS-TrafficTypeDiagnostic: SA1PR15MB4657:
X-Microsoft-Antispam-PRVS: <SA1PR15MB46579C78BBBD64DAC5F019EBD38B9@SA1PR15MB4657.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gbtS5pkw399Lb4p3JhDzS2BqkQFxvoL1CE64SasHaVS0U72d/khbc5Fas9rA8Kkqpy1BGfvb/lhdSVJhMcypSK9z8xJEnX49N/L8mbE3Sde4q0pOnqAAC+LjhE5ZvAMWJcn9NAmmFUgAuUqZPNwBmbMFlKGwdJ6ZIHkBvW56wzFSpxg6DDFQ8oD4RsjL7Cm3bcIU3TpasCB2Xujf3TYtzaxNs/JkRyJBW/YmUlmxDTce2jqPRhQ96OPhIUNjLZlaIHIiwIx7YEtiiquAed44nPnH2mi4LUz4Vh6bPLKQUH4Xbs9pdJA4TyjRHrAh4EF+s9eXZ0NqrNdLKKmcAe7IMT8CeQ+eQANc+y4yF2biYO4GCc55/xq4uXa5LqWiuknVWH/PJ7brgpsuFEuhlzfnnzSHXMMJhuH1OjOd5yiTKhNUKwjih4fiWMaFqNBerENZrBWdRTRlLKctgJ6m09PSu3PsXbGydFr3wBY2eIAWo6gn3BMAOW+IhC17JJawD7+fMkMQTshzabcknbA0syq9BV0y/+VAFx1DjU7lIPoO+6jpCHm6aQ+1R6XSz3aVKTaLVu2FwBhq8WHZEI+b7Ga4ymuM2x2CMW4mVKENjY5Mm9uvOCvotaTA0euvmgv+vPVHIv/XZj/HjP6WDgZ2ow3e+34exUZfXX3ttKftKUvmD2BnbOZD05n+ZOa6bnIHwmzv36WQOaJ2k50N3XhjBFAMjaVmm6AwEvRjdDwZgShUOdyFCwDGTuKQz8qkgIUHe65lPWCsGembKnrQsZusMB5KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66476007)(31686004)(186003)(2906002)(66556008)(66946007)(8936002)(5660300002)(36756003)(2616005)(53546011)(38100700002)(31696002)(316002)(86362001)(921005)(6486002)(6666004)(8676002)(7416002)(52116002)(508600001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZ3eU82d2JGYm40dCtuMEEvbW5NTlZwdkk3c3g3QmJ0blZlZG1DS1FrdkUw?=
 =?utf-8?B?N01XTW1CQ1FHUG5HWlZFdWd4VkRxVnlwUWRLbmpPUmtxNkdXcW5vRE1Xcmxx?=
 =?utf-8?B?YXFOZko2UkpJODd1T3BvbFVGOGZLSnBSVVc4a042RXpQTW9EQWFaekNzRi85?=
 =?utf-8?B?NjRYRy9sU2ZJc1pHSVNudXlTSDlDWC9QRW9DRndGR1orOTFERGxYZXJqUy8w?=
 =?utf-8?B?a01rL0J0dDJRVzRSVnFEKzhCTUt0TFUxUkNMV0ZqdStRdG12dis3TlNLK05j?=
 =?utf-8?B?emg3RXMwVmp3OEg0dGhCaFI4OEx3b0pDK3hNbUFRVHVCVmRlZ2ZNajRZUVlO?=
 =?utf-8?B?dUo1c3k1WEZ2R3RVOGxHdlhOTnRCc0xEeFVGYk1FVVJhMnF6aU90VU9IbStM?=
 =?utf-8?B?eDRDUmVPeU0rcVRZUXI2anErZUk1QmxsbmNPUGJ0TTVpUGdtb2FNcDNHanhy?=
 =?utf-8?B?VElsREZrZnB6SlFRajI4V1JpNHhhRFo3dkV5LzRUMjVUQlVsbk5HeEJvWWpM?=
 =?utf-8?B?KzZNTW1INnYwYkpmcHpDcm9PM21MVG8yd0F5MGVGN0N6MWpXTktkSVNlSnpm?=
 =?utf-8?B?U3NEc1ZTOFhkeUIyMWdYejJjNkFIWmZSdU1sK3BTMHpJelNGVVY5cGpYamJT?=
 =?utf-8?B?WVpvV0p1Q25paFVlVFNHZU9kY0I5MnAwWksvNnFvRWQ5US9jMFZhVjBkc2cz?=
 =?utf-8?B?aEN2cHZvMUx6S3QxbVVWekthRmF1U2hLYkZKL0Q0bTlBMHJReWxkVjJ5TnBT?=
 =?utf-8?B?VS9QU3EyZmJ5ZnlMUmJ2NnB5ODlkdzF1VzRzM0VMcEhDZlh3Z1ZRbTFWZTFz?=
 =?utf-8?B?TmJhV2NJd3lKSVVrTjRUSnJPRktpS2QyaERNUEx5SUlGQ1B0ek81RTVuMEdu?=
 =?utf-8?B?eDAvanZPSEtzZWhVZG1DMjhLUUYyYk1RSkl0QjlMa0ticEFOWmlCSE9WMHJk?=
 =?utf-8?B?RVUweS8yelZYcXdKbVRtZE1oUlNzdWVmSnlLVHdBUDBOUTNvYVMvRlQwTzZG?=
 =?utf-8?B?ZWwxdlpRUWRtSkxub2tza2E0akQ3OWF0V1NEWlZkeTg3ZTNRMGwyQjRzU3pW?=
 =?utf-8?B?MTM2OWtyZVpyV3ZQaWQxNnZQWi8yR2x6ZmdZSXdEVDJGVkNweklpL3pxdkhB?=
 =?utf-8?B?MkF5TEI5ZlVkRktqcUx4dzVhVjZxak9sUmpsODZyT1ZYcFc0dzM3bDJBRkdD?=
 =?utf-8?B?UEpBNmY4RGN0ZjVoc3N1OW90QnR3eWZ6Z1ordnFJdlVWaHdIa0M2UVBJOEZG?=
 =?utf-8?B?SXlVK1FHUmE1K3d2WFE0OG9BNmQ4b21zcmJGai8vck1CeUJuNkUvSEhYUk5D?=
 =?utf-8?B?WmgrZDJsVSs0c2N3QmNvdFM0OXZ4QStDWitSVmxMWDF3RitpZ3FuQWNFMVg2?=
 =?utf-8?B?RE5YV2RZd0ZRNE1KTitodXU2SlQyRzVMSjNMeERTcnY5U1VIOWM2bDMvdURp?=
 =?utf-8?B?Uk02c3YxbmFkY2czbDhoTDg4S2hTbDc3amFOSDJ3ZEtjS1MvYktScFlzV3ZS?=
 =?utf-8?B?NkFjZFFZOVc4YTJqNXVVZVlFcE9sRTEzSFZVSnlVMXpCWVFzS1NFcEswZlRh?=
 =?utf-8?B?VW1ZMEVrVEZIdERINmtpMnhqazZrc21ZWVBnamdKVWo5amp1ZkFvYVlYUDR2?=
 =?utf-8?B?WEtDYXc1U3g2c3V4TEp0QnorV1NrTFF0dmxyTENUSkJIeGtQQk9OWmtCT2xn?=
 =?utf-8?B?cWYraGVWZU5melcveE1DdlFqaEc2ZkZVbnBEOXcxWnNOL3NmSmN0NWplUzRL?=
 =?utf-8?B?OXd0dVhwYnNCaFAyNG9sdTNmMVJQMzFWa1NKYUorSkJ6aUhnUEZ0TUJuN0NN?=
 =?utf-8?B?T0N5N244ZHFXUkhLVlptVGFIRG9IM1laWnBPRTlPUndrZ2ZwSVBVaTZsODFw?=
 =?utf-8?B?c05yQjV1blQ2Y0ExR1gyUytHVnY1MU0xVUJhblk5cGx1czZJNW5PY1F5NGdE?=
 =?utf-8?B?bW1RYkhGVWwyY0ovd2tNTG9USjl4TVlOLytURk5QSS9sMUw3U1RHZ0dIMHRm?=
 =?utf-8?B?Y29KNXVpMy9JbmV0ZTBFcXdkYS9UREptWXU1em8xTmh1emhibzh5Z0w3Q3RH?=
 =?utf-8?B?MjVYN2JVR3BBbzQ1KzZvRk9IZVM5M1FuMnJXdVVRc1cvaHljd1VTczlyTXYx?=
 =?utf-8?B?cUx0emRRMXMyRWU0NWJwenJiSm9MN3psZEZEcXZTZWVrVGV4dnprTjRNQ203?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd80c53-7bfa-40a7-5e7f-08d99e3eba73
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 20:24:10.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Etbyo6SPnnloyGL/OPz0CdY6vIzUVrADA4gymEc86WMP49NNSqgZ0nvYG7eawOMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4657
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: wS2AasqS0TQomG2WddXj0TNvnwh-E2bF
X-Proofpoint-ORIG-GUID: wS2AasqS0TQomG2WddXj0TNvnwh-E2bF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=956
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 1:48 AM, Di Zhu wrote:
> Add test for querying progs attached to sockmap. we use an existing
> libbpf query interface to query prog cnt before and after progs
> attaching to sockmap and check whether the queried prog id is right.
> 
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> ---
>   .../selftests/bpf/prog_tests/sockmap_basic.c  | 84 +++++++++++++++++++
>   .../bpf/progs/test_sockmap_progs_query.c      | 24 ++++++
>   2 files changed, 108 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 1352ec104149..7f3d5c5da6e1 100644
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
> @@ -315,6 +316,83 @@ static void test_sockmap_skb_verdict_attach(enum bpf_attach_type first,
>   	test_sockmap_skb_verdict_attach__destroy(skel);
>   }
>   
> +static __u32 query_prog_id(int prog)

Let us use name "prog_fd" to be clear it is a fd.

> +{
> +	struct bpf_prog_info info = {};
> +	__u32 info_len = sizeof(info);
> +	int err;
> +
> +	err = bpf_obj_get_info_by_fd(prog, &info, &info_len);
> +	if (CHECK_FAIL(err || info_len != sizeof(info))) {
> +		perror("bpf_obj_get_info_by_fd");
> +		return 0;
> +	}
> +
> +	return info.id;
> +}
> +
> +static void test_sockmap_progs_query(enum bpf_attach_type attach_type)
> +{
> +	struct test_sockmap_progs_query *skel;
> +	int err, map, verdict, duration = 0;

Let us use map_fd, verdict_fd.

> +	__u32 attach_flags = 0;
> +	__u32 prog_ids[3] = {};
> +	__u32 prog_cnt = 3;
> +
> +	skel = test_sockmap_progs_query__open_and_load();
> +	if (CHECK_FAIL(!skel)) {

Please user ASSERT_* macros. You can check other prog_tests/... files.

> +		perror("test_sockmap_progs_query__open_and_load");

No need to have the above perror if you use
	if (!ASSERT_OK_PTR(skel, "..."))

> +		return;
> +	}
> +
> +	map = bpf_map__fd(skel->maps.sock_map);
> +
> +	if (attach_type == BPF_SK_MSG_VERDICT)
> +		verdict = bpf_program__fd(skel->progs.prog_skmsg_verdict);
> +	else
> +		verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
> +
> +	err = bpf_prog_query(map, attach_type, 0 /* query flags */,
> +			     &attach_flags, prog_ids, &prog_cnt);
> +	if (CHECK(err, "bpf_prog_query", "failed\n"))
> +		goto out;
> +
> +	if (CHECK(attach_flags != 0, "bpf_prog_query",
> +		  "wrong attach_flags on query: %u", attach_flags))
> +		goto out;
> +
> +	if (CHECK(prog_cnt != 0, "bpf_prog_query",
> +		  "wrong program count on query: %u", prog_cnt))
> +		goto out;
> +
> +	err = bpf_prog_attach(verdict, map, attach_type, 0);
> +	if (CHECK(err, "bpf_prog_attach", "failed\n"))
> +		goto out;
> +
> +	prog_cnt = 1;
> +	err = bpf_prog_query(map, attach_type, 0 /* query flags */,
> +			     &attach_flags, prog_ids, &prog_cnt);
> +	if (CHECK(err, "bpf_prog_query", "failed\n"))
> +		goto detach;
> +
> +	if (CHECK(attach_flags != 0, "bpf_prog_query attach_flags",
> +		  "wrong attach_flags on query: %u", attach_flags))
> +		goto detach;
> +
> +	if (CHECK(prog_cnt != 1, "bpf_prog_query prog_cnt",
> +		  "wrong program count on query: %u", prog_cnt))
> +		goto detach;
> +
> +	if (CHECK(prog_ids[0] != query_prog_id(verdict), "bpf_prog_query",
> +		  "wrong prog_ids on query: %u", prog_ids[0]))
> +		goto detach;

For the above four checks, you can check all of them instead of
goto detach if one of them failed. This gives better initial coverage.

> +
> +detach:
> +	bpf_prog_detach2(verdict, map, attach_type);
> +out:
> +	test_sockmap_progs_query__destroy(skel);
> +}
> +
>   void test_sockmap_basic(void)
>   {
>   	if (test__start_subtest("sockmap create_update_free"))
> @@ -341,4 +419,10 @@ void test_sockmap_basic(void)
>   		test_sockmap_skb_verdict_attach(BPF_SK_SKB_STREAM_VERDICT,
>   						BPF_SK_SKB_VERDICT);
>   	}
> +	if (test__start_subtest("sockmap progs query")) {
> +		test_sockmap_progs_query(BPF_SK_MSG_VERDICT);
> +		test_sockmap_progs_query(BPF_SK_SKB_STREAM_PARSER);
> +		test_sockmap_progs_query(BPF_SK_SKB_STREAM_VERDICT);
> +		test_sockmap_progs_query(BPF_SK_SKB_VERDICT);
> +	}
>   }
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c b/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> new file mode 100644
> index 000000000000..9d58d61c0dee
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} sock_map SEC(".maps");
> +
> +SEC("sk_skb")
> +int prog_skb_verdict(struct __sk_buff *skb)
> +{
> +	return SK_PASS;
> +}
> +
> +SEC("sk_msg")
> +int prog_skmsg_verdict(struct sk_msg_md *msg)
> +{
> +	return SK_PASS;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> 
