Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13C445FC3
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 07:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhKEGkM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 02:40:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2678 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231142AbhKEGkM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 02:40:12 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A50b5Oq024795;
        Thu, 4 Nov 2021 23:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=V50OnXE7Bh4X6TbG3zqLH6vhFCbaIFlaBwwW1wDvlE4=;
 b=LFzbAFrA0k90Ar90d9huac7Ma3gHP6C30svzOlnPxH3LXI8zSnlhM+wgxkQd8hu0eh1h
 qFoEXIYVJ5xV7EMWGqOIoYsv7nGnWlkIkQi9XRbdtgfaBkQnM80/ChtemDdXTzHiRYVR
 8PWXvwK66/7toNxbQUA1hhrfKMgOXmPySFY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4t7fhpdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 23:37:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 23:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN2XNTf185UglsCbI4EXhblFVB8Ris5j1s/p/fn+H4VlE7K/r1GKG3yMfLzYGyiNpSjhRJ91soit8VW7wx9DwyGDEoP4lTApPGJccpWaqlQCZxw1ijQw9FHAe53wCsiEay89ja+rDxUgcUdXWjkrcqKiBFTR5s48F3CUuGgBMtbajQqaRDKf9V/8v179uh04biFFq4geifT7rNoVBlte7qXppXEkXEh5dY5iKoqiLJU+x5olH4nsRbmx4xg6ve85Y65H/BhofTw6dqv8At8b/cDz9z9Q3eqVpLQCd1mAaFNlYk0pRXfQRqOjy/hwSvTqX+NQKXeIwEM1wEfMLscsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V50OnXE7Bh4X6TbG3zqLH6vhFCbaIFlaBwwW1wDvlE4=;
 b=BGPuOc9i1loyqNFA6bheMojybDgZ999yw78/od4HAl+rmOgBxltw4h6mEKRRTjB3kw8ZlAkV0c54OXYoC+KjbynyHQGNsr5JWBTo+o7kOKJD/Q2ACMP9Z+DJn3FXMPA68VW6VkfTxJK0dZ+Jml3LsFURRtvajfzoL94efFgOZdvoN96gzJT0mZ2tMW7SlpjhTjZ8QZ0K4sFh02lQRLOCB5l4UZFuyM2klyJ+tiJcKxuBbuzqMoWX6dhY/BSo6FrRG8Ik7oBq4eXmxNnmG+6b3WbL6G2vuc/YoIEQQkp6GENH1R1qdFhDu0WgnF+B1lVZu7bWfvpsgT6L3KTczDoY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR1501MB2008.namprd15.prod.outlook.com (2603:10b6:4:a6::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Fri, 5 Nov
 2021 06:37:17 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 06:37:17 +0000
Message-ID: <ee56d236-a0b2-bdf2-ad5c-8aa77608c1d1@fb.com>
Date:   Fri, 5 Nov 2021 02:37:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 01/12] libbpf: rename DECLARE_LIBBPF_OPTS into
 LIBBPF_OPTS
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Hengqi Chen <hengqi.chen@gmail.com>
References: <20211103220845.2676888-1-andrii@kernel.org>
 <20211103220845.2676888-2-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211103220845.2676888-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::7) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::102f] (2620:10d:c091:480::1:7c65) by BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 06:37:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9da3a364-ad2e-434c-b3df-08d9a026b5a7
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2008:
X-Microsoft-Antispam-PRVS: <DM5PR1501MB20087A389686830E97332C12A08E9@DM5PR1501MB2008.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMpH1JWureG+oxbxZdMBH+QlVl+a24gEZYsqGOBEu1yHiQ6AA2HO8cSNzH2hpriaHdeYUP8/okmr/UtWgGhbB7rPyZHLKZatbOH2T3OkrKi0pk9q1sbx2C+JPhJPrM3afvKY6jvOfBOgLvwYZHYTqX0XRqtXxD1aloqXphmAIhT6dwTXoYqZQkwzzCF3UO6Xh1wgWUE55eOsoLQqfPA/KY5b0nFMEbsVab6j7lRzZGYwUDTrnthreaW7ei1riEhMZsf9M1+oyB/QlWWRiDt1NaQ8WSFPwwteTrhSGcvuc5i6yIVEKyw+ZCHkiiuV8xjpiXc1Lj7vu5tC7rnhYV6CxUeOte6kxr9iFvJeFkSj19KA0lwkO9ehLyj2kfykWVjPj9coTS9heSYF1wu1u0XEy/ceXdmRxIoVND5tyVx1g4ckhehciw9ErOonBJxswymg5R0iOxsRREYHdKzmcCMPneH0ehMszCH26ruqHGBfH/rQlYgdkcl8TOzyqoPu75Tfo+614mKnfjz7TqRGm3PmIhlZtFzyBuuXcL95rqAAxEPpqzNnlS+y83cPrRPVwY7mSgo/wT2JyVbr0KAK3RjPACvUk0JkP9eFrLvLDv2e2E/XO306tjs4EirsWkFC/04p3/lvajjq+NYEdOTeW9i1GZC2PufYufAOZkFm12LZGdqf4mvUDRSM9Pc9XnqnFME4URdGMCSb+h7yCmeyAh9Ovuo9ns3zE89+4QnoaOaWO64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(8936002)(8676002)(66946007)(83380400001)(66556008)(186003)(2616005)(5660300002)(53546011)(36756003)(508600001)(4744005)(6486002)(2906002)(31696002)(316002)(4326008)(86362001)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUE2czhJWTAzYklaUTVKODdiQWhaWXVzQjZYM3ZYZUoyZmhjTE84ekJybzMx?=
 =?utf-8?B?MytUcFBuSm5YbkFiVDZ5bEk0VGthNmRXSFYxQ1FMTWdIQWxhVWVkRE5XR1cw?=
 =?utf-8?B?aEJUcVAxMXd2WFA0Tlhsb0ZDb25JZ0M1S2c5RDNRdE1HdXFJQkIrZ0ltNmNO?=
 =?utf-8?B?R2hkRitXdVRqNWg1dGhSOW5rRlFEQlQ2MnUyR1haR3JCeUVicE1xTndNejBx?=
 =?utf-8?B?VFVkRDg1WFQ4V2ZacFNCaWhGbXdNUUVhbE9ZakU2SXJaNXZMUUErNldnaGdY?=
 =?utf-8?B?NzlRTmhhZlJvLzMxSERkVWpxejNaRWUxOGVvZEJxMk5FNkVZZDNnN3V5em1v?=
 =?utf-8?B?SjJkdkVpcWlTRzlLeHhnQ0ZVTVlsVTkrOGpXbjZOMVRucEhpUlAyYTlQS3J5?=
 =?utf-8?B?Y3BtdHdWMVVNaEVETlEzci9hTzFNYjg3Tk1mQ1RzZHk3WFU2blpyMWQrTmdT?=
 =?utf-8?B?NWpnNUZPZGtkY1VkYXhISVBJMnk4YXpUSWwzeU9YczlIQnNhbkVva0xDODc5?=
 =?utf-8?B?N1pFajdDZkt3QjVnc1QzTWQzYll5a01ySi9KY0FlZFJjeEV3Mi9LMHowRE5q?=
 =?utf-8?B?THFxa1pndUVOMzA5alBSNkxIQ1VGaEFuL0xkVWFjY0hQb3JyVkxpK01uL2xY?=
 =?utf-8?B?MDAvU1ZPTWE3Z3pMY0ROM0FSWjI2MjRXRjVRYXVwZTN5VXphRmU3cmZyS093?=
 =?utf-8?B?TU1CM0FqcFdaSVNTNnJUbWdQNEIyU2lmVk9PVXEra1EzMmgyaUxHbGg2NzFu?=
 =?utf-8?B?aFpycmd1alpZcTliTGlnV0dhL0Z5WVJuZUZJTGxnUTFMUmZVdHVrQ2NYNFFm?=
 =?utf-8?B?UFFmTndncE9teTlzc3pvb3R0dTVsNzkzbzRtaE8yV1o5cmlQdm84NWdDbE1u?=
 =?utf-8?B?VGlOaE5HM3RsNVRENkdSK1JrUkgvWWkwajV5UkVXMkVkS24zOHNsTllzMVE1?=
 =?utf-8?B?UmRDWk1HSXZWREZjVkVQUG1aTlhDZFVzcEI3ZkRBV01BNS9sSTNDVkhjWThD?=
 =?utf-8?B?WVR1azI4eW5MVEtFZFJFRUV2alQrQ3N1Y0FGaTlJdHl0Y0V2K3lIQ1l2OG5j?=
 =?utf-8?B?QUQxZk0xRXVYSm1ML2xmU200WE80Sll3dFRQZHVDVml6RGxCbm9oazhVQVZV?=
 =?utf-8?B?b2Q4Y2NCbGJwTS83ZzF1dXpTZXNhUTF1MWgxTHcrZUdoeER1cVZyMjFlbytD?=
 =?utf-8?B?THVka3NvTG13NEZWVkhxRVFXNVFtenQ0Tnd4L2VTUTdnclhkUyt1eklsN0VM?=
 =?utf-8?B?b2FYU0FMbEtXaC9JYzN0RXVKNXo0dGNyK1JsT2h5Y0JUWFdNL29FWFE3T2RY?=
 =?utf-8?B?S3ozdWxLNlNSM3o4WENrc3FjUTdibzVOZzlGV2t5ZEUvRjlkbEZrWnNDTVAr?=
 =?utf-8?B?TkpXa1dIYmdPSWV5MDVySlFUcFJQK3JLeDB0OUpvM0hOVFVhVFpSaDZyYW1u?=
 =?utf-8?B?U0R5b1JJM2dUY1hMdDk1STlFQ1B0K3A4V0wvaW9TeG5HQnJxODRBWjRjS1RG?=
 =?utf-8?B?dGJMVGRSWlFFSUxJMktWQUxBSWUvaHpXZmo4UWp5VGo3ZW9FK3lNd1Z0RERz?=
 =?utf-8?B?NXNyTHlsMTJGRGozblYrb0lwWnhqaTFyc3ZHRlZHalY3ZngxMTdrRzR3Y2Y0?=
 =?utf-8?B?NnZ4cG01REZZTi9QNlp3Q1dZaXpEWVlOb1UyYWNKTW40cEo4UGtTdHFxekpx?=
 =?utf-8?B?dlU1TzVjeWpNelhDdjdBNlBxcGNnMUpESXVyOVViT1h2VG5jWVptR044bEV6?=
 =?utf-8?B?N3EvQ1liN3EwTy9lclMvbmJMOUU4ZDdaZWtMbXo0WmVzWjUvakhGZStjL3R5?=
 =?utf-8?B?cGJQL0x4dTJQUzVST0tKYUJJSWpnbWpaMlA5ZWNMNUdIYkI3S0hwdG9XRzBy?=
 =?utf-8?B?bGNPVmR2bkpadkFoMkhEQ1pGbVdQeGVnaTErejk4eFJYeGJJbEViUEgrV0kw?=
 =?utf-8?B?eFpTb1ZlS3hqaWRaRGRXdEFTcWdWU0pocm9ZQ05OZTN4S05mcDF2anA4NFVu?=
 =?utf-8?B?bm02bjZ2MktNT2hJdmxiM2M5UEsrTXVqZWdYbmJIaURraXFIckJmcm0zbEFl?=
 =?utf-8?B?WnpXTzFpSTVISDBCQjhwcjhlVzJIdkhpdVFpZGZsYXdvbUFSbnprcU5Kbndm?=
 =?utf-8?B?ZUdCb1NtR2RmYjlXMHB1TlVONUZEQVBhdTEzYkJlOC9zcUhVMERRbG51Skcv?=
 =?utf-8?Q?V0O2BIOwhvuyM8Kyu0empI1tAihko0kSVxnulS3yrjJw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da3a364-ad2e-434c-b3df-08d9a026b5a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 06:37:16.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4l98yyqvPbDpN90JYmKLTUO7YQF89X0SuV5z9bf9hDC+Ao3K31Ihic57XKP+japza05S4nPvmNKK2jSidHgn8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2008
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: wHYvOZtdncXxyiBntk4t2u3mjIK27abN
X-Proofpoint-GUID: wHYvOZtdncXxyiBntk4t2u3mjIK27abN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 mlxlogscore=790 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111050035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/21 6:08 PM, Andrii Nakryiko wrote:   
> It's confusing that libbpf-provided helper macro doesn't start with
> LIBBPF. Also "declare" vs "define" is confusing terminology, I can never
> remember and always have to look up previous examples.
> 
> Bypass both issues by renaming DECLARE_LIBBPF_OPTS into a short and
> clean LIBBPF_OPTS. To avoid breaking existing code, provide:
> 
>   #define DECLARE_LIBBPF_OPTS LIBBPF_OPTS
> 
> in libbpf_legacy.h. We can decide later if we ever want to remove it or
> we'll keep it forever because it doesn't add any maintainability burden.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>  tools/lib/bpf/bpf.h           | 1 +
>  tools/lib/bpf/libbpf_common.h | 2 +-
>  tools/lib/bpf/libbpf_legacy.h | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

[...]
