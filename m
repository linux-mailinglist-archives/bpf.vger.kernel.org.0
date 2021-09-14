Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3545740BBDC
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 01:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhINXDO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 19:03:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235495AbhINXDN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 19:03:13 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG1hhd002100;
        Tue, 14 Sep 2021 16:01:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8mIowaC85EGreQHY+UkK5jQq3WEg3tZh9jZVRzInA0k=;
 b=GMgBJ6kOStM29gayF1RfYOGPHzCIqB2e2UV57YCMWCAzzKJG6DS4RstMTw8oWRK0ODAk
 sBy5TDkqc9aPtXld68sL8w9AparAbMKKOjs9N9X4RasHTki1SHr3nxRdeTf+H7ozBdT2
 yHAXJzP+AA1p3Lau57HOgXCdPuLWfjzllsk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b2uq0kx4f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 16:01:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 16:01:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkBLfOETN1v+eaA9+ZuMVNl2LflyKGkzoOIite2johiGL3bfA33o9EhRZPtwjGUd7HV7exlyosyBITJSGGpM5aM7umzJe5o/AJOdgAyvBfoPI3ACRx0MaMIbqvuuYJNiP+5I20HOVAsCY4xU/Hw/MJHFo5a+oz/LIEHCG1dREQT4Q7ngDTpR27QD9D4s5G5opDLCT9nwOhLwtNMFKW7K22z1hW/+Lbwki95iM+nyIp7MnzBONAI+p/f2IIYd+aRv+Q8TUta8ZiERo4psimfYkMjy/WctrHOrqkwTjGsDXkw+itcxdbYejG1Ba+KiLwiqy+KCv1CrZ+WaQmQSJvq/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8mIowaC85EGreQHY+UkK5jQq3WEg3tZh9jZVRzInA0k=;
 b=Pf1FdpCbboI5cJMqKGfUROteC5sfg+6Bb24/VeY4gT96tGFupi1iUG1zf5g/+Lj+8zyJ3ihYPkO1cmVD/x4kkjCBHHqogBz+j+bpAoaINDUD7dLi5u4HeCBPmRFpXN+uDdGRtlX4HDKVykX8IpUgUcdlqPsY3QX2/AAw1DyOgF1lMoetTN2QVApZGJgVyU9xbRcE3ujycgj5A/JvMDPYu+u3yUFeIYs/XoT4106xb68UiEr80fZJhJhWKW//TJeVXe5a5a3DLIUXag07ZZ6U8iuaLIDRMXddP3YT5jp8kEMyXJqr5fgCXig8FlIDFSNm2/l/pV+KYYdR7eL0XwB46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4419.namprd15.prod.outlook.com (2603:10b6:806:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 23:01:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 23:01:39 +0000
Subject: Re: [PATCH bpf] bpf: update bpf_get_smp_processor_id() documentation
To:     Matteo Croce <mcroce@linux.microsoft.com>, <bpf@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210914222306.52522-1-mcroce@linux.microsoft.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <322d781e-3e69-aa5f-7b99-5c8bc768e87b@fb.com>
Date:   Tue, 14 Sep 2021 16:01:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210914222306.52522-1-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:1c4d) by SJ0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:a03:331::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Tue, 14 Sep 2021 23:01:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8927d2d2-9148-4d8d-61a8-08d977d39c7e
X-MS-TrafficTypeDiagnostic: SA1PR15MB4419:
X-Microsoft-Antispam-PRVS: <SA1PR15MB441931B675DDC3834EA2A5AFD3DA9@SA1PR15MB4419.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXOHKTkDu4utkJAh6wSTSkXedcLo6tdafljACZtRnGTMP3/kiEzA6GeLqNDeG54nNxLO42wqPVXSpDGfVsoKM07TMBnSqUYLYQMbuUKwiy1EbGhWKjWoDDTw/2QxfJ+ipi/1Q4BDRiwf61LMzS6ugbAUK47tOksFLj7kWcBcFB1Khs+YxTbVs7OWjVamtShynsTJjmN0CF0lMum7lreXV12o0A6zFlIFci/l+3hVKRTpTVAFpp2qXKzenw2OUbfbyUrdLnSwemJH7PgXdhSroJ5zhwb3nHMunmKEFG9dOxkE2WhPh+loDfmXAcL5Ck8ZsSfvX0i4PyPHfUE4Fz04SxCQsVHeUd5etXPJkAcB5LNN9IhcFVkZDUumdvzqut5YsqK8+BAT6Qcq2xIVqy9IB5rcj6eBflbRrYgI4eI9Uw+huOYSWouF6LauguGsgRP+mbetrbJKMADF0XoIum9wq+PK5JL0tIw761iG5mEFZVO1qIQT1VfEq5jDxt5TEzw3w831iyPh3EuO+VHMA+la1wy0Qt2t/RqLoxROMMW/VhczpyO1dHoCCg+j+bocU/tI4h92wLymh7hIJ8gttquEN0ZPEYHutzjZIIKdZCLd4DJwp0s2Y4VwpWS23+cfGnDXV6a7KJbHwHBh5tQxUDQ7+CzXrcsBphNdehe8ton75RNYhsegJSl7gq63mY41uStD0VrrqSTpKe5RPBwxB67L+EgqS7i/+LglNJUjA8dg4dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(508600001)(8676002)(53546011)(8936002)(6486002)(45080400002)(31696002)(2616005)(186003)(31686004)(316002)(52116002)(38100700002)(5660300002)(86362001)(66556008)(66476007)(66946007)(4326008)(83380400001)(36756003)(2906002)(6666004)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnB0RVdONXB6R0tYM1U4RmR3ZDlXWFVXalhncFVnKzB2U3lwbG43eW1pQ2Ur?=
 =?utf-8?B?YmJEUEM5TGtYdGFVUFpDeWluZ3VEVC9qMUNhbmYyUVhTb09rY2dtYmdVVzRs?=
 =?utf-8?B?WW82R3BHTDBnZ1Y4cnlMUW5ONTFCenF3cVQrTDhaWmVXdkc2LzQvanhweGdV?=
 =?utf-8?B?Ui9WZy9zbTNZWjR2N1lDUVV1c0FWSmcybnVxZTZ1NGEzMjNhendjVTRZeHp3?=
 =?utf-8?B?eDNEdEViS3BGcUVlaXRhOGtBMGFRdmJuTkVhVkxkajJ5cUxlNjBtTS80NWFO?=
 =?utf-8?B?eHVWSUFVVnp6dWxrUzFieEpkY0lhT3JkRHlDaU90MWtaUW1QOHlHWlBxdkcy?=
 =?utf-8?B?amJULzduYjdGdTFLU0k5Mmh5MlRiMEk1L3QxRTk5VWY1UklhNnowbnRXVTdJ?=
 =?utf-8?B?WVZXS3JVUktZaTVHU3ptaXRxck93MHN3ZURIa3dSQlRyYU9HTFdjU2JwT0pB?=
 =?utf-8?B?aEIyczdrZWZoWlNZd0F5a0VwV0MvS3R5UmhXaEpOZTh3RlMvaERRS2R2L2pM?=
 =?utf-8?B?OWxXYUZidVVjSlFyK3NhU0tzeGxrMGFFeTVhVXN0LzY4N1BQbUdteWR1VGs2?=
 =?utf-8?B?MmxWSFRwKys0YmZ6OUlPemExRmZJUlZJdmp2THRGTGg1QUorbGp5WXo1V3FI?=
 =?utf-8?B?MFEwWUNRS1BobVhidFI3eE11bVJPbDBrMUdtN1VjL2NvZnZobDcxbnk0WWRn?=
 =?utf-8?B?amdVdFZHR1BRZG16NFpKdzZHUU4raVlWZVF4TnFDS1orZkpobUo0L3BkWTJi?=
 =?utf-8?B?YXpxcXpoTFVCa3EzNmJaclByczZ5WXFOelFOdG5TaDZnZjhHMUhzSUFsbktK?=
 =?utf-8?B?L1BjK2JZQXU1ZFc4TllBd1lLcmMwSGtPUGFQc0J0eEozaGhURXM0NUpwTWxl?=
 =?utf-8?B?dTlCTUlGRUc0dHNlWUgxNzFjQkE0OExjSVBZdGMwbjhITlZ1VkRueUpENUVn?=
 =?utf-8?B?TGQ0R0pVaVhwdVFHUW9kT1V4Q2hZMFNUendYNHFiemdBbVovTXBTSm1zck9P?=
 =?utf-8?B?NFJwWmZDSmpWWGdJMkI5MjhaQ1JTQ2c4aWt6MG82aXVlT2JLNHQ0dVlmdHRY?=
 =?utf-8?B?Qm9ZNWozRE5LY0tzS1RKRHVzRDdtRzhtbkcxVm5vSFBXQ2tlYUE3WXFPd2Fw?=
 =?utf-8?B?V0NTZmQxMG1KRWhqRUlFM3Vaa0syTkhaRkN0V3RrQlZHenR3TVFrcWJocHBE?=
 =?utf-8?B?Qkhtb2k2Q21qZkVLRk5GOEkwTS9SejZiOWlQVVYrdEdUclVFa0lvTTJxa3Y0?=
 =?utf-8?B?S1FHbThNYzFsMkNrVUdIeDA3dmJwVjhXTDR3NkkvWndQZWhKQXlYTm5Ea0sv?=
 =?utf-8?B?SnliSnhIMEI2UWV2aDZvc1c2akE1azZRQmJVOUtrTkhNTnhCMWhxZ3h3aVd5?=
 =?utf-8?B?WnByNWRieG96MVVpd0pYZ3BnSnBsdlJSQkluSlNjUXZNeUZJV0JubTlYSVFP?=
 =?utf-8?B?WHlCYUp6MEc3MkROYmt3Uk5YSWhqTldwU0VCeDBWS1FUMU1YRXRRaSsxQUZs?=
 =?utf-8?B?ZytNd0sxRDl6YlpHWFNQM1k3YmhodDVUWDZIQkNVaHBCeXpOR1g4WXkyUTFN?=
 =?utf-8?B?aDNzS2FxRGFYRU1pdnhCSXF0aDAreXpPcFIzaHZ3MXlKMTQ3alM2T1o5Z3hr?=
 =?utf-8?B?Wk0rU3JVOU9UbS9CcUZqcFpma2tmeit5N0RhMzdHZG5TeVdubkVqWXgzK0ZG?=
 =?utf-8?B?Nm9CNE90Q3lzL3VPRTlyaWNXbEtvMlpzWlNhVklxTDk4a2g3UjJOSXhVWWhW?=
 =?utf-8?B?L0tvN2I0YktBM1B4bjlPU3oxbThXYkdIQXB5aUJldmF6MThjb01mLzdmTXIy?=
 =?utf-8?B?cVV3S0Z3aERudFVKOU1WQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8927d2d2-9148-4d8d-61a8-08d977d39c7e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 23:01:39.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fptk2lGY3NSqE++xXxFCcdJamcZqk+gQjSk7Romi367QDaHu0xKs1SwKQS1Z6uri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4419
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: GolIvVTjMWCPIYwHpTKGtp5oQsWqgAyA
X-Proofpoint-GUID: GolIvVTjMWCPIYwHpTKGtp5oQsWqgAyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=941
 clxscore=1011 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/14/21 3:23 PM, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Since commit 1e6c62a88215 ("bpf: Introduce sleepable BPF programs"), BPF
> programs can sleep if the BPF_F_SLEEPABLE flag is set.
> Update the documentation accordingly.
> 
> Fixes: 1e6c62a88215 ("bpf: Introduce sleepable BPF programs")

I think we don't need this Fixes tag as this patch should target to
bpf-next tree. There is no need to backport to bpf tree since it is
just a documentation change.

Based on *current* implementation, referring to sleepable BPF
program commit is not needed any more. See below for the suggested
change.

> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>   include/uapi/linux/bpf.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d21326558d42..5e3b2fb62d84 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1629,9 +1629,9 @@ union bpf_attr {
>    * u32 bpf_get_smp_processor_id(void)
>    * 	Description
>    * 		Get the SMP (symmetric multiprocessing) processor id. Note that
> - * 		all programs run with preemption disabled, which means that the
> - * 		SMP processor id is stable during all the execution of the
> - * 		program.
> + * 		programs run with preemption disabled unless BPF_F_SLEEPABLE is
> + * 		set, which means that the SMP processor id is stable during all
> + * 		the execution of the program.

Currently, migrate_disable() means true migration disable and preemption 
is possible, and BPF_F_SLEEPABLE programs are also protected by 
migrate_disable().

So the patch should just change "with preemption disabled" to
"with migration disabled" to reflect the new implementation.

>    * 	Return
>    * 		The SMP id of the processor running the program.
>    *
> 
