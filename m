Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7608B4A7DB3
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 03:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiBCCLu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 21:11:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45094 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236688AbiBCCLt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 21:11:49 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212LnQNN031122;
        Wed, 2 Feb 2022 18:11:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wfSrZJaZZ8iiiGBHmXVFo4hPM8bT24HOGw50ULr1UtM=;
 b=H3SqgyIbhXFVw1ICHyTWMPT8U+s32zVAraElI2jjUVjyZb/rvUVzx08se3t0Pdfr9wgn
 fmeSvtpkajIMwkUYcBJhPo57tLZf8pVg31kBk21x4/+BuRKWAiakCMZT9DWfrB39s7Vm
 /eOS1/RzqOIJ2Bds+pInUX1ejniWYLxR1sY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dym1gxpt1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Feb 2022 18:11:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 18:11:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx+F7iMWgstsVh7mF8Gr6DcV5OrN2FLRbxytliDh9FsfSKJFSSLDHjACLgAvwxtEnBQy+CXcUlvsz2v3eAMsn0PAhLJ633S8cx+Wp0LrQ8ca/6ynKSux3IeN0GYt+Rf6vbG9jPrDCa5PPFBJ0ZbKQFN7cMypFnMS+WMYS3eeDqKWu9FQvfdvKr+wt3Tm/5AdkmOirrAb9JxowcGKMwtxL3VUka8fbD0jkWyq1AWmlB4gxgWtRBi5Oh+o0VeKB8ZYuGs5CT+PunmxpxXEjia3kzst0u51veAT7ZpoSZJrmC5Yo+lJWNz0eHaZADDUkkZvorUsPgldKaq+VOkuOImSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfSrZJaZZ8iiiGBHmXVFo4hPM8bT24HOGw50ULr1UtM=;
 b=TG7zUWFHcLDwNOMdtPAbiPJJlG32TO7gp9DN6K2h0FSS2fZTglXCttf7fkYnsHn0IHVEtJa3WU4nmA5WadKLh0awiCjbCmXufy0lXM9BnMHKM8sWAKDRNiroNhSIUHXJq3pznuTuTKT5wW2i+y8VVpGPqVgm4wAqjBrWMjvR31El+UU1j8IYnkJ5A2CXeAI+i4W6ZVjMfTvv+LSq+n2SaMP/HX/lR0GQyQ/D1ylEl0LDIcSIitzo3ke3WHcexFAgNECnJe+gG2QAe0+W5uYNKrO12PpwBX3d+7cdtRxorAcKO+ZYxUBh0NIkzyYLgHerQdIb+cDWOIlZYCymjXgiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2301.namprd15.prod.outlook.com (2603:10b6:805:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 3 Feb
 2022 02:11:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 02:11:39 +0000
Message-ID: <85800d3d-d8d5-caba-e6c9-2505788d42b7@fb.com>
Date:   Wed, 2 Feb 2022 18:11:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: can't get BTF: type .rodata.cst32: not found
Content-Language: en-US
To:     Timo Beckers <timo@incline.eu>,
        Vincent Li <vincent.mc.li@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
 <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
 <CAK3+h2zLv6BcfOO7HZmRdXZcHf_zvY91iUH08OgpcetOJkM=EQ@mail.gmail.com>
 <41e809b6-62ac-355a-082f-559fa4b1ffea@fb.com>
 <CAK3+h2xD5h9oKqvkCTsexKprCjL0UEaqzBJ3xR65q-k0y_Rg1A@mail.gmail.com>
 <CAK3+h2x5pHC+8qJtY7qrJRhrJCeyvgPEY1G+utdvbzLiZLzB3A@mail.gmail.com>
 <81a30d50-b5c5-987a-33f2-ab12cbd6e709@fb.com>
 <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <4ff8334f-fc51-0738-b8c6-a45403eed9e1@incline.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: CO2PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:104:4::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94a0dd0f-536a-4815-80df-08d9e6ba8371
X-MS-TrafficTypeDiagnostic: SN6PR15MB2301:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB23014DAE8F6F47F5303FFB7CD3289@SN6PR15MB2301.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90x6okxs1aNRgX9XC0UlirZ2i3/Mr8yBr/0DEuH+CYsybJxHPcK+5lf38sCZv4c76zMNGhkt9RLB0o8ToYRuAIQuyq51V/9tKRlb/0alXgeZk5MErToHJyDBsaKdZ+cKxDBSooRiyUAQGHowF7TuGKWzb4JuH9y2fOV1v9NGoDpUuu2a9CdWlgXEsjUriHUA2gjHk31bhoBNJr+av5v4X6NCgy9Oq74OnxuNUB5CvB4HCLGERz78yHS3m7pPHh1dEJNOdgbWvqdzz/PEo3Rtg/QPN0eQUrfUgG4FheI0HcCTMsI+NQX4fg/wjAb9KjY/sbdBRC1YDSEB9Ien6gZcm4GKe5UtmHPIN3tZaP0IFj/1v6BmHU0ZFN6wlblZ8JbF/hbo76PjULY6Be7ajfSpzLiWgkd8rmo+/482qRWZHUYl9E2iRwTKZEKBU43XvHtH60SmB6lDIBE6UKS+8ko+LSZFnlNPb39E7JH55R/QBxuLpr4bCiPX2WHKzj4KdEgb2K6WEfBszCAsChsmhZVcrJqiY3jeLyCXItpfvjL2pOvRhxMVPn6s1RokYFkHmL4SlwDizQmekWOju/3ow9YgYKh7zWlcU+1+wRglHdwnTEiwLJU2cI9esHIbkdlQdLerL0kVy2xdh8JrvUE/tC+F6BGjRM0Cj72sVbv5T1YwaT0l7f5NT8pZT45GAQMp/dTyTXy2UbJTLbLxiY8xvu9VB/F9NSPvKHG88PiyGXLxHRX3jtztglI5dS3UZWNW+s6DhIcG+52qZWbUSt4DdnoeTpddwHMSL4kkW+3D2b53AJyp9yqhiyWcz2QDfMz0BVbkaR26FvaUJ6NlFO3ghw6CtKZesaGT1MQFQgGaBFVErS+liNkpwIMp8qf3NlwX0atQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8936002)(66476007)(31696002)(66946007)(316002)(66556008)(8676002)(110136005)(5660300002)(38100700002)(86362001)(36756003)(31686004)(6486002)(508600001)(53546011)(186003)(6506007)(6666004)(6512007)(2906002)(52116002)(966005)(83380400001)(2616005)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhsNjRFQjZ4Sit1ZytzbU14TzVrWVZDekpYcEE0ZjgrMmpSUmx2Qyt1Y29v?=
 =?utf-8?B?Uk5zUHJxQm9CNkFqdFVmbC9jNks3M3JkOC84QWZBdlN2cGpGbzNOMHpFNVZD?=
 =?utf-8?B?R0pRTWFoa0dra04vR3crQzFyN0h2cDNBMGllUDJDWWJzYjdTQWVrV2lNUjFq?=
 =?utf-8?B?NHVkVWZQUXFFTTgwQ2U5TjZHTHlRUXppSDVmZUwvaEtDcXI5cWZTWHRFZ25Y?=
 =?utf-8?B?YVRHVU1EY0kweUVQTzg3RTlnTXFPUC9jK0tPTkFhaEl3dGRnUXNTdWR5eXlo?=
 =?utf-8?B?cmVpRWN0MlB3b09GZW8vaHp3SjdDSFJCaXFSeFJ1Mm1iTnVxcnY2U1lOcU15?=
 =?utf-8?B?YnE0YXh4VmNITUk5Q3lPeWJFOGYweGRBV0NLa1ZXWUhHMXVtYnBqSTdJeS9V?=
 =?utf-8?B?SFZibzlJbmVIWGtDbFgrYVFDajZERjJUTG44aExyYlRESTJRbDh2NXRnczNx?=
 =?utf-8?B?RHJpbERBRzBmWExpaktpaTFuaHZWeWJ0eHBueUd4bCtBMDluM2hoNnJUVVRF?=
 =?utf-8?B?bGZoRDVjcUhqTjJ5VFJlaURPbFAwRk9ZSTU0LzZ5SEFQRTlEZzFYVUZYR0E4?=
 =?utf-8?B?cDNDQTRYRjVCRWRycDRQTnBKZVNHY2FqS1A5V3k2b2hSdnFrZGpVNllJQTlO?=
 =?utf-8?B?L3gzeHpJTDBIZFNJMWxPaEx6R0NDeHBIVzJCQUFyeVExQXQvUUFQWU9tYmJE?=
 =?utf-8?B?bVVPVmFVamR5WUErbHdWUkpRWk5VV3plOG52TnMwWGZuNFdMY1dhaWk1ZE1k?=
 =?utf-8?B?M1M3cE5OUTVQSjVJUVlQMENINEJzaXdhVURNVVphekQ2NmU4YTZ4MkNNSWZY?=
 =?utf-8?B?NnpFQUpMaG1VR2pkOVlKS0NVZVZGdUt3VzM3WFpoWDdjWG90bU8rdk53cDgx?=
 =?utf-8?B?Q2lBTGlwRm03Mm8zcE43d0J6Qm4xd3VmRXlnY1hoTExWTWFlQ0xLYVIwTzY3?=
 =?utf-8?B?clNlR0RzR0tSMjJveXlMRSsxNktUMEhJb1dNRzQ3S3dSWVZ5T1pVLzJrRS9q?=
 =?utf-8?B?cWdVaUJFY2NoVGNHVVpRVVZZdk1WZkFoTENGMGV5cEFWdVdVZXN6YUFhQTBa?=
 =?utf-8?B?RUpWQlplS0lHSUpuQ2I0WUhMQkFVM1JvLzJSQUptRUJmS3Q3VUNoWDkvVnFt?=
 =?utf-8?B?bWxPZVRJbFNkQWRuV3NqaDg1Y1dYK2hocDlsL3BPZWt1b3FQMWFDR3RXY2g4?=
 =?utf-8?B?ekVJUS9SZCttSFcxVFVYMFBtSEJGWS9QbVRFUzJJbWJSbWVrQ3FQeFovUlE4?=
 =?utf-8?B?Ym1VTERUMjlwa2V1U0dUb3VCQ0lIeXdwOXFldmFaZUdhT1M3Y0FweGc0SXZi?=
 =?utf-8?B?N1NmU2JIWFMxdXl0bFpOLzA3eExTaUdRbEpRelRzMXI3MDQ2bzdmT2lHaXUy?=
 =?utf-8?B?YUV6SnhWVGhMOU1QbDhhKzg0K2F4ZVhzcGZXM0NqM0tWWk9LeGVwZ0VFR0FH?=
 =?utf-8?B?Y2g0cUZ2b2ZWVE8valNlRVFNVzVsb1JRdkhYM25zeFg3TDhpV3d5OGpHVm8z?=
 =?utf-8?B?bTVmcTc5Z3RPaE9Fa2hvSFJERXJBdVhTdnEwM3M1bk9yU21BaWFiMjU2cXlJ?=
 =?utf-8?B?WURqSnJBaVd6TzZ3dURvaFlsTGlHKzE3N2hjN2RLaEZZRVMzK0ZGZGpBYnd0?=
 =?utf-8?B?a2NNRUlTYXg1aE9oRDJ6akZKb3pCSU1Xb2NpRVhnN3NUVlFNeDVMOHhKR3dw?=
 =?utf-8?B?VGcremZtaG9kbG90UXJyS0xwSnh5NmhRcTVrekNyZTNidmQ1T0VpVGw1eEtF?=
 =?utf-8?B?ZTlmckFhS1JOUVAyL09KQWlNVmJiRVM3TEswWCszWDloR00wVkRZTEdLMWtG?=
 =?utf-8?B?RHNxQkRybGpHRDVYd3l5Y01aQTBiT2x4UWpuN01PVE95eHFFMnExcmN0c2lm?=
 =?utf-8?B?VkNQanIzMTBPZkNBMXdueEk4SjJwTjJ2QWFwR1p2VzJlSWRqejVDZHgwV1oz?=
 =?utf-8?B?QjVMMmlHZlFZTVRxcUFRR0dvVkJUamJXVmlmanFBOFhNNWJaNS9jTElBMmtK?=
 =?utf-8?B?QTF0RzNvTXNNMFFYZFJ3N05WK2FJd2taVHVuSzlmTkRYRDFIMmxVQmZ3MVVU?=
 =?utf-8?B?SEhBanEvSkMxMjcyQUFNa0xEMzZCMDhwaWdsOHZnTW1Jd3BqS0ZtbmFxQldE?=
 =?utf-8?Q?oTEI/aByMAf+fZhl0k/6+x27Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a0dd0f-536a-4815-80df-08d9e6ba8371
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 02:11:39.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIfIpoYKNKR/hBNhu9mlkyHMZ0HdBQRzbNTgBu6v18z6P4/LASXhEZ9u6klfDncS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2301
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: AOvsBgo5EmWRNtf1tTkj_QYu80GrLxqU
X-Proofpoint-ORIG-GUID: AOvsBgo5EmWRNtf1tTkj_QYu80GrLxqU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202030010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/2/22 5:47 AM, Timo Beckers wrote:
> On 2/2/22 08:17, Yonghong Song wrote:
>>
>>
>> On 2/1/22 10:07 AM, Vincent Li wrote:
>>> On Fri, Jan 28, 2022 at 10:27 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>
>>>> On Thu, Jan 27, 2022 at 5:50 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 1/25/22 12:32 PM, Vincent Li wrote:
>>>>>> On Tue, Jan 25, 2022 at 9:52 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>
>>>>>>> this is macro I suspected in my implementation that could cause issue with BTF
>>>>>>>
>>>>>>> #define ENABLE_VTEP 1
>>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>>>> 0x2048a90a, }
>>>>>>> #define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
>>>>>>> 0x5eaaed93fdf2, 0x5faaed93fdf2, }
>>>>>>> #define VTEP_NUMS 4
>>>>>>>
>>>>>>> On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Hi
>>>>>>>>
>>>>>>>> While developing Cilium VTEP integration feature
>>>>>>>> https://github.com/cilium/cilium/pull/17370, I found a strange issue
>>>>>>>> that seems related to BTF and probably caused by my specific
>>>>>>>> implementation, the issue is described in
>>>>>>>> https://github.com/cilium/cilium/issues/18616, I don't know much about
>>>>>>>> BTF and not sure if my implementation is seriously flawed or just some
>>>>>>>> implementation bug or maybe not compatible with BTF. Strangely, the
>>>>>>>> issue appears related to number of VTEPs I use, no problem with 1 or 2
>>>>>>>> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
>>>>>>>> experts  are appreciated :-).
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>> Vincent
>>>>>>
>>>>>> Sorry for previous top post
>>>>>>
>>>>>> it looks the compiler compiles the cilium bpf_lxc.c to bpf_lxc.o
>>>>>> differently and added " [21] .rodata.cst32     PROGBITS
>>>>>> 0000000000000000  00011e68" when  following macro exceeded 2 members
>>>>>>
>>>>>> #define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
>>>>>> 0x2048a90a, }
>>>>>>
>>>>>> no ".rodata.cst32" compiled in bpf_lxc.o  when above VTEP_ENDPOINT
>>>>>> member <=2. any reason why compiler would do that?
>>>>>
>>>>> Regarding to why compiler generates .rodata.cst32, the reason is
>>>>> you have some 32-byte constants which needs to be saved somewhere.
>>>>> For example,
>>>>>
>>>>> $ cat t.c
>>>>> struct t {
>>>>>      long c[2];
>>>>>      int d[4];
>>>>> };
>>>>> struct t g;
>>>>> int test()
>>>>> {
>>>>>       struct t tmp  = {.c = {1, 2}, .d = {3, 4}};
>>>>>       g = tmp;
>>>>>       return 0;
>>>>> }
>>>>>
>>>>> $ clang -target bpf -O2 -c t.c
>>>>> $ llvm-readelf -S t.o
>>>>> ...
>>>>>      [ 4] .rodata.cst32     PROGBITS        0000000000000000 0000a8 000020
>>>>> 20  AM  0   0  8
>>>>> ...
>>>>>
>>>>> In the above code, if you change the struct size, say from 32 bytes to
>>>>> 40 bytes, the rodata.cst32 will go away.
>>>>
>>>> Thanks Yonghong! I guess it is cilium/ebpf needs to recognize rodata.cst32 then
>>>
>>> Hi Yonghong,
>>>
>>> Here is a follow-up question, it looks cilium/ebpf parse vmlinux and
>>> stores BTF type info in btf.Spec.namedTypes, but the elf object file
>>> provided by user may have section like rodata.cst32 generated by
>>> compiler that does not have accompanying BTF type info stored in
>>> btf.Spec.NamedTypes for the rodata.cst32, how vmlinux can be
>>> guaranteed to  have every BTF type info from application/user provided
>>> elf object file ? I guess there is no guarantee.
>>
>> vmlinux holds kernel types. rodata.cst32 holds data. If the type of
>> rodata.cst32 needs to be emitted, the type will be encoded in bpf
>> program BTF.
>>
>> Did you actually find an issue with .rodata.cst32 section? Such a
>> section is typically generated by the compiler for initial data
>> inside the function and llvm bpf backend tries to inline the
>> values through a bunch of load instructions. So even you see
>> .rodata.cst32, typically you can safely ignore it.
>>
>>>
>>> Vincent
>>
> 
> Hi Yonghong,
> 
> Thanks for the reproducer. Couldn't figure out what to do with .rodata.cst32,
> since there are no symbols and no BTF info for that section.
> 
> The values found in .rodata.cst32 are indeed inlined in the bytecode as you
> mentioned, so it seems like we can ignore it.
> 
> Why does the compiler emit these sections? cilium/ebpf assumed up until now
> that all sections starting with '.rodata' are datasecs and must be loaded into
> the kernel, which of course needs accompanying BTF.

The clang frontend emits these .rodata.* sections. In early days, kernel
doesn't support global data so llvm bpf backend implements an
optimization to inline these values. But llvm bpf backend didn't 
completely remove them as the backend doesn't have a global view
whether these .rodata.* are being used in other places or not.

Now, llvm bpf backend has better infrastructure and we probably can
implement an IR pass to detect all uses of .rodata.*, inline these
uses, and remove the .rodata.* global variable.

You can check relocation section of the program text. If the .rodata.*
section is referenced, you should preserve it. Otherwise, you can
ignore that .rodata.* section.

> 
> What other .rodata.* should we expect?

Glancing through llvm code, you may see .rodata.{4,8,16,32},
.rodata.str*.

> 
> Thanks,
> 
> Timo
