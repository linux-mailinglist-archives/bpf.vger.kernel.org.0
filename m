Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7BF326B7A
	for <lists+bpf@lfdr.de>; Sat, 27 Feb 2021 04:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhB0DsF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 22:48:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12528 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229745AbhB0DsC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 22:48:02 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11R3d11Y026508;
        Fri, 26 Feb 2021 19:47:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=27yHutRdVBtWpl2D4Z/aAFGUwpLzYJYJLUZSa9B+aRs=;
 b=lphi/t2ROul75ExQJxukeREVDH5VJ8/yDA4iHn8g1OuPmRlSSpI4OQ8RoCkghd1bub8p
 U9+uUPIAXCbJClWsraSrJtBizgVvG0EfNl3xi6YxhbVNuK3sMZBKIL6hhtmZrz46GUKm
 VVk07JjhEpePmoxFJPyghB9roDQEcSotYoQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36y8md9cxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Feb 2021 19:47:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 19:47:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhdxGSM2tdqrJlmfHpZDZraConVNHQiIVEO/9/1ewTuwZJBi36uCMzM50EwJNT5HFx9mh6bIFA+AltvNX19pPYEyrNBLmR6dzAF/X2h//4tJmn21EZ4X/UTP+qCb4hPrBMzfGy+p5heCiw+Gr6GPkyaAHf+hIIOjE/x1b1vY0zV3RnwBsbXPd4bKUsolBvVVTPb9eAURir1eWGejf70LZonMuZBZ6QMC0EIy0DO7/uYtkDl5i1jMqDmrvH3Am9CLLegF4x0lIUSW9qfyzPMAQKgFDJ4sAIK+FhgPfUWdBoU2yMTUooczcH88yiHn7lBj0bCb5RPR3T4zH6HlLXmUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27yHutRdVBtWpl2D4Z/aAFGUwpLzYJYJLUZSa9B+aRs=;
 b=LzNvRrZxXOSqeiS362fXkRzn/yjhwFc0gJcy4c90NiteolNElatWVUE99YmSV9JxrFcddwhD0xVt65bc9YUWRajqL2fj9QZm/XG+qQlXzjNCyW3pWIkIAhoSQcK4VNDeEVKxPTGVOMrpLvv1FSx9drb//D+5VYClLCciA/nBIRzZIyiWavhzaDFSGwPKEYS+/Gr3wzh9pdOh/at7yJwa/KFXKiNRN2wHgjIoeEowLR1DErLd7Er7e08pCGO/G/8CqAJ8eC6MwFx1mvTf1ziPQ/iKuNxomiBP+PPJrd0ejNCxRbUR9m80F0PvZeJtq7BLr5JK/mjsLyhz5gtpH1JiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2063.namprd15.prod.outlook.com (2603:10b6:805:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sat, 27 Feb
 2021 03:47:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Sat, 27 Feb 2021
 03:47:04 +0000
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Use the last page in
 test_snprintf_btf on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
CC:     <bpf@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>
References: <20210226190908.115706-1-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <21c13c15-0dbc-8430-9e04-0932f6f913f0@fb.com>
Date:   Fri, 26 Feb 2021 19:47:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210226190908.115706-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:f604]
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::193f] (2620:10d:c090:400::5:f604) by BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Sat, 27 Feb 2021 03:47:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ed0c919-fd0c-4bbb-ae27-08d8dad25911
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2063:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2063824C81439007CEB735A8D39C9@SN6PR1501MB2063.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6giJR4QqEa2AZZRzlUdc+CkrYeR4nr/VzULRWQKhNUhz4dj6piRm6hExbFQ0GSpUEigBUcfVtHy23KR9Hb1WVB5gk8lCtMFg5R6XR61TD9804sTauJvHE9rM3U99tgm4q+qXM/5p9YKGcR3Z+w0iRQ1cmIhCNTshh0/2uWssciUHcP9UPHhqWFOnYF8yOn1rxtzqFsrN+OOiaeqXOFnChYmfwyQaDooq3g/EDOw4P5wRtgpn6r9qYfHuK9Xdj8m5YXS90GahBdwKlhNF4zjmhz19rkrTF5FTYumM/rp5tRRVZFcX4FuoWkCN+eQOQkryFh82cuY6D6DxZ5eENmG4WpfKAWzwuS96adVwyp2RsVAfAyMe14RKholD96JswaLxwi2nceD337P6QmNXGranSwNvnAwVuiIu/Os2ZD0ZbmZ6rNXm911SLc3d3f2jFW2IwCKoJPK1vKE6n+LarKZ5f2PeGTiSJsmRIUtvr3J0R8/YYmyC3GcGcYeXEtYZ0qAB+bzO8+qolYKkNKI56GgZXeBc4LD3opM6A4o0sP8kUfL0MG7fBFIlyyfaqE8cowfTYVlpjTyB2lGGCeGzOERoOBQC8UNgIhE/zeE5rvFNvrZL6OOyWG+e/7HvBs0NKFLjjAxQ2LMkGaVWmtZKtDnUiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(8676002)(8936002)(4326008)(6486002)(66946007)(2616005)(316002)(83380400001)(66556008)(186003)(31696002)(66476007)(16526019)(110136005)(36756003)(31686004)(5660300002)(53546011)(478600001)(86362001)(2906002)(966005)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YVV6MkUzUXlXajcxZTQxeU50bnVyR1E4M1BLZmNQREdtZmdWU3BKY3pHSVgv?=
 =?utf-8?B?ZVhSbXVwTkw3OHo5dFllUlVpRzdoYnJET2lmZEpJeWdsVit4WGowNUYvR0RZ?=
 =?utf-8?B?UHk0ZVZnVUtXVkdRdmxWNHl5T1hoY1ZOMklwZ083bStOS2szdTBETmNwQ2Jp?=
 =?utf-8?B?a1BOclF0Ymg4MjZaTUJ2SEM4aGVEZTZqUDZqeC9HcTRaTy82UDFzdFFzKysy?=
 =?utf-8?B?UUdPV3MrK2V3bEk5OFJnRlRmNXhFK2lHNytPMHFNdlB4VW1RcXpFNlAvSU96?=
 =?utf-8?B?dXZqWWtSV1lQYnp5a2RnQXNsSTZuSmV6SC9BMnJtNjhYbTcxOGZRaFpBMGg1?=
 =?utf-8?B?T1JHVE1lU2l1TFNVdXR2YWRRdTlIN0FCemxXemNJQlJHZ1ZveEdLS29MYWNS?=
 =?utf-8?B?SW53TnRLR3dzbDhPa3c2TGxNYTluSjI0b2xFVGRLTmUxbVpqbG5HMWltTnBX?=
 =?utf-8?B?dVVqRWhHdng0cXR0WVhNMkJCK3F4d2pDQ1B0cEw1YTFmR21ZQldpbDEzZTdO?=
 =?utf-8?B?QitVeW1uQUlaVzZYb1N1UW5WbEhrWFBjbTJUQkdROHFsTEhKQm1GTDlnMUlx?=
 =?utf-8?B?SE5QcWljOFQwbk0rNmFCTGJmbEozQUZER2w3a0ZPWTlzbURnNU1ZSTdzRGpj?=
 =?utf-8?B?emg3THBlaDRPaVBlM00yU0NNeVpkSGQzQmNyZFBhcEsxK1VPZ0ZGUkZiM3hz?=
 =?utf-8?B?UGhONDZtbmxVNE5mTS9uSG9XQjVxT3hZZ25oTUhoMFFNMTR3elBqSU4yUWZT?=
 =?utf-8?B?dUtBUzE4NnNiVEJaUHMvNVVQdUk5Njgwb3Yrb2JtKzlvbTBiY0JEeTZJNW9C?=
 =?utf-8?B?bnBJbU42SG9aUmRaM0I5elVBQzl6OHZrU3dBS20yV2YyM3V2VzdxdTBtSGc1?=
 =?utf-8?B?Tk1kMjJvY2lDZDJ4T3hKNXN2STg2NG1WN2hZcFhUM0tyZy9zTVNGQzVXSkFI?=
 =?utf-8?B?N1NuZ1Q1ejFHcFpUT1hXUUtYam5taGFPWEJFMlhwN2F2TmZLbDF0M2grU1Mw?=
 =?utf-8?B?cE5neWx6V1FQL2xJYm01M3ZtMlVFdjhLTVRRRVVhRmxGU0RjV3dSeEc0Wnl2?=
 =?utf-8?B?eGdXY2ZKc29zZlpKVjAzZ28rRXBOdUVmaG55VTBLdFUwbUFNRzhBZXVyU0Nx?=
 =?utf-8?B?bE00QVJGZVBoUVUxdmZ1eFN6MSs3Z082SWs4eTE3aUhQYnMvUFY1R2swMitZ?=
 =?utf-8?B?VWhQWGdURE5iRHJYOVRLdW1xdFVqYWNHamtNUml0QTZHRkFMVk54K0JoUkUw?=
 =?utf-8?B?SGFmY01Mb1ZwUWVNMzVYMTFYQlhyemc1eUg0RnluZ3p6WC9LQ0RDRGw2ODUz?=
 =?utf-8?B?R0F3VngwOUlCQXZkYXdZRU9UVTlaVDVCNitqZnpqaVVBT1FTbG5ZTkNoRWo3?=
 =?utf-8?B?WDdyeGlPdUhSd3BXQ1dEbWg2NDFyNUlhNXJUakVsR3J3NkZzRW5QYm5COS9K?=
 =?utf-8?B?aHRzYzlHS3FvM0MvTy8wT0dPKzROTktibmRYWWRscW5pa2p5bU9HUWhtMldV?=
 =?utf-8?B?ajlzNGh4MStNcE9CS3Q2cEtQdzZrZmJ6RWVaaVU3ZlF6eE04emlBeDZDc3VD?=
 =?utf-8?B?bFV5VW5iQ3JqTFY4V1g4b0lnNGVpa1hFTmN0RXBxU1NVdTYrVVZRam5VUHFP?=
 =?utf-8?B?L3Vxdk1jYWo4YlFlNHRFaEovazl3aHFYNE5UaTU4QnliOGVyL1BER0o1Z0FR?=
 =?utf-8?B?aXdEYVRuTFVyYXVMY29lVFN1MHJaVnNzQkhCRFFtTFJkVk9BdmlyeDNYNTkw?=
 =?utf-8?B?UjJMb2JqUHVMcEdWN2hJeUlxVVAvUjk5ekNRcXlXNHNkMVN4ZVhLa2hOUGdR?=
 =?utf-8?Q?g4oqdg4YTNzAWiPufBw1LLGJyaoOs2ZQToO24=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed0c919-fd0c-4bbb-ae27-08d8dad25911
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2021 03:47:04.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBm14fyf0a9jJLDuKJrm7BU0ZZsKRanOVs+D1jnbO4r3j0Ss09En9v6iI8zbZfmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2063
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-27_01:2021-02-26,2021-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102270024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/26/21 11:09 AM, Ilya Leoshkevich wrote:
> test_snprintf_btf fails on s390, because NULL points to a readable
> struct lowcore there. Fix by using the last page instead.
> 
> Error message example:
> 
>      printing 0000000000000000 should generate error, got (361)
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1: https://lore.kernel.org/bpf/20210226135923.114211-1-iii@linux.ibm.com/
> v1 -> v2: Yonghong suggested to add the pointer value to the error
>            message.
>            I've noticed that I've been passing BADPTR as flags, therefore
>            the fix worked only by accident. Put it into p.ptr where it
>            belongs.
> 
> v2: https://lore.kernel.org/bpf/20210226182014.115347-1-iii@linux.ibm.com/
> v2 -> v3: Heiko mentioned that using _REGION1_SIZE is not future-proof.
>            We had a private discussion and came to the conclusion that
>            the the last page is good enough.

Heiko, could you ack the patch if it is okay? Thanks!

> 
>   .../testing/selftests/bpf/progs/netif_receive_skb.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> index 6b670039ea67..c3669967067e 100644
> --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> @@ -16,6 +16,13 @@ bool skip = false;
>   #define STRSIZE			2048
>   #define EXPECTED_STRSIZE	256
>   
> +#if defined(bpf_target_s390)
> +/* NULL points to a readable struct lowcore on s390, so take the last page */
> +#define BADPTR			((void *)0xFFFFFFFFFFFFF000ULL)
> +#else
> +#define BADPTR			0
> +#endif
> +
>   #ifndef ARRAY_SIZE
>   #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
>   #endif
> @@ -113,11 +120,11 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
>   	}
>   
>   	/* Check invalid ptr value */
> -	p.ptr = 0;
> +	p.ptr = BADPTR;
>   	__ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
>   	if (__ret >= 0) {
> -		bpf_printk("printing NULL should generate error, got (%d)",
> -			   __ret);
> +		bpf_printk("printing %p should generate error, got (%d)",
> +			   BADPTR, __ret);

 From https://www.kernel.org/doc/Documentation/printk-formats.txt:

Pointers printed without a specifier extension (i.e unadorned %p) are
hashed to give a unique identifier without leaking kernel addresses to user
space. On 64 bit machines the first 32 bits are zeroed. If you _really_
want the address see %px below.

I think it is okay to use %px here.

>   		ret = -ERANGE;
>   	}
>   
> 
