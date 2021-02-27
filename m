Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998D4326B5D
	for <lists+bpf@lfdr.de>; Sat, 27 Feb 2021 04:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhB0DcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 22:32:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55866 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229915AbhB0DcK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 22:32:10 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11R3N6gn000625;
        Fri, 26 Feb 2021 19:31:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jknKsDKnCFbLDaYcR1C0u6ht9JK0YIjRl/gReXU57ss=;
 b=U8jpW6wJ3OaCd7ts5BORHB62QkNujWaMyXn5h0jC2Xve+Llt3gl8CP84/F5FCPHuiRLy
 RLO1YrrqrvtBahtgURLaqakdOfS9R/yygDI1UhS0HdcqFU57Ip+mf1k0nXoGwDYaVCCw
 hFwx/UJtuVFbzY3gVxf80gjX4WysI5mmgkY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36y8md9bwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Feb 2021 19:31:26 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 19:31:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUXXUEqc1OysbooZMVHnKAqDjCtrfklWGeF10ibvfq2YkOrLrSihpGQtisnRxqAVsIRFLMaYVdIqFdpEDw4eXqQCywFjDzx7eogaCSwJR3ipdHLqPZ7huMcgrz9QOCEfksEW9/FfJYtipYQy4MOi6nQss8nCnCl9pdjmKVUgdjDIJa9Hm6G5YU6Bi1XACBCMTC2UGgLZ12rTrRTaCgCIqWxmJPdCZmXNnb0ldZQ8/Vl1K68mZmEUhCWaJZUTwvmxD95SG1QXwm7aLkkPPfeZMrxtQV/rYqp4nPpCtOM22dqrhh8nxyX1y3t6Q2Eqa/6npZMwnfeW5fSiWYQsAL5L7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jknKsDKnCFbLDaYcR1C0u6ht9JK0YIjRl/gReXU57ss=;
 b=QpqZHK8hrVej8kzRDxhW2mGy2tlg8BhGNgbFOjMxbeGHi3ZRCDmaQQcYoVc3xb7Pcj/peXGAnJVA2lD8al0EtnPXSsbEnEbupaV2Slh1Dswa9zmDtnSjznk7Wgb9AhDGy7JjldXB6rfYun+BMDVG7hfhFkU7HI3nhQUZ38lw9Z+A8epp/pqkp13vYI+37h1/Z5pWHNoQIW7I8BAZLK4Ctj0gmOGd1FWInJU3VtsqV1x2UkCCN02Y26kPu4iYU40a1GBQm7siV6Z3I5u62fgppv/u6PEUSwN5Nfb5qxIVGOyKyQqKkovJyebj1bIIzRIdbo92R/quqJzk7pUX+042zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2061.namprd15.prod.outlook.com (2603:10b6:805:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sat, 27 Feb
 2021 03:31:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Sat, 27 Feb 2021
 03:31:24 +0000
Subject: Re: Enum relocations against zero values
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <CACAyw9-XZ4XqNP1MZxC1i7+zntVAivopkgRgc4yXaNtD8QcADw@mail.gmail.com>
 <05c0e4ff-3d93-00c8-b81b-9758c90deca8@fb.com>
 <CAEf4BzZVXtVnV9aSQLaQ=7qz-3E44gvMf-abHeHKLS3S4xjChg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3a6d2ee3-4ce0-0f8b-2ab4-dad77e6da42e@fb.com>
Date:   Fri, 26 Feb 2021 19:31:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <CAEf4BzZVXtVnV9aSQLaQ=7qz-3E44gvMf-abHeHKLS3S4xjChg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f604]
X-ClientProxiedBy: CO2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:100::24)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::193f] (2620:10d:c090:400::5:f604) by CO2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:100::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Sat, 27 Feb 2021 03:31:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc362163-1679-4116-9c51-08d8dad028aa
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2061:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2061E91CC8846B2BC3DABBE6D39C9@SN6PR1501MB2061.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnTALjWl6ahE9SyspuD0itY6jgQ0oNM832pKQOtNMXtO3mBZgQaCn3RfN6R5qpBi0N2Ee+vvtbGqrT9ci6r1gxz9QSUt0Cw1t12r3embfdveW9yfnUWEpzQUtkryEKZqOakok/xAArvfTgZiJWEmzkJCdj4AVdGAewEtj6ts51m/FD3eNUpiOptOqMz+MIQXWUk2iXTxG3wIYWp2lpgi9YkuhssuHZCudi1Gw+vQc6qi4eOF1uWghpR/aYYxI53GBO91ii5vH1DWmbYURU/c6Ctv1fgTbKzQZOREgIckw8wzd35RU9hZe8I87XMJa3RWe6TSSc8KSt1d7M1D0leJBvQBitu6AETmYSL1FzOf7oU//Bb8SduUObJv1suLRee2FKen3NjfJXKhur6GoSbB1fyDHkNTJFkkTISj9HksGLv37yT9MSncr404QjfkVSC6nGk64LTYUj/sZ73oCA/+9KxVaT2tvPgWbFGtfMAVROaMU2MfuzUrRP+54jxwfPDeu4FzSL9K31u9buBn3EeeJ8pwNjvzYBIEST5wR1kvJ/FMK9y/QbIYBI0oDupSsApZaWra+3lilzhfWpa2UJVy7+hvCxf6S/LAMt9uFr2GdR/6zMVZNUPnbCZmlXsWUCw/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39860400002)(376002)(16526019)(186003)(86362001)(4326008)(6916009)(52116002)(66946007)(54906003)(66556008)(5660300002)(31696002)(66476007)(6486002)(36756003)(2616005)(31686004)(2906002)(316002)(83380400001)(478600001)(8676002)(8936002)(53546011)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L0Jtdis3QzE5L1I5Vk1Wd1pyOUxHVXkzZEZTMVEyWWlPbS9KS0FHcUhwVS81?=
 =?utf-8?B?dTdjVC9XaVJHOW1OU2F6K1FlVlRWcjlPdmhoaDg0MUYybnpGYWRNRmNjQWd3?=
 =?utf-8?B?UGtjUkJITjFqQk1sRGltcUMvaC9mSE1jVlpqQ2NwR0FyMUJ5UzFCeW9Jd1JV?=
 =?utf-8?B?QnJYbXFESTRLSkNBRzk2d2hnNkhMNUpCMXZwdmFvY3FmMW82a29mMTA2cGRF?=
 =?utf-8?B?SnVWM2haSTIvOHVSRC9JSi9oYmcxRWxESktFWmpsQThMUDdrRXFEOTJXWVlm?=
 =?utf-8?B?WVJqM0hwOVRySWdEM1ZoU0RSZzNnME1XOGV1TkxmQWVtY1lNamJGZExUeko3?=
 =?utf-8?B?WWRPT053cUV6WHpXOWplVWpwNXlZNTBxOGZCbmpsYkhNL3ZkRm44TjdHM1Uv?=
 =?utf-8?B?V3Z5V2U0WDM2c1NjajZvVytSeVc0eldTODNUTGZhbDNFR3IxdXVnUHJWUGtM?=
 =?utf-8?B?SWUyRDV5Zm9Ralk3NHNxdkpZSEY5aGpwSjZUUDExbVp1U2ZTOGwycHpXNWtL?=
 =?utf-8?B?OExwQW1DWUtDc3d4Yld1RHViZFhubDh5aVZ4cCtzNUFDTWlxOXYyRDdrREVU?=
 =?utf-8?B?b3lMT0FoejZ1VGxvSy9WeXc5NFdiZTh3OEc3bTFPWXVYcHRZRk1lVzJwOTNK?=
 =?utf-8?B?SnZremhaZ3NiTUFBSTNMbmhoc2VpRVk5QkducmRUYmJCaG9aT3NCcitVZGdq?=
 =?utf-8?B?Z3BhZ1Q4UEFJQTQ3UTFqQ3oxUjVncDFRWjMvQ3E2WnZmdWdmT1c1TjhvK3hR?=
 =?utf-8?B?U25MTmRmRUxMTkp6Ny9DT2RwL3hSTnlmZEZzSlFZRDhVS1pPZ1VFdTVLTm5O?=
 =?utf-8?B?czZhNktxTG9sc1dDU1FETVpCV05FTnlwbTUybUJtSUlBUHlkQ2xrUGZKd0py?=
 =?utf-8?B?L3ErVEJCQWFrRU44NVprd2wxWVZDbjJtT0w4bGdwN0tiRVc4YXQ5VlVnWkxF?=
 =?utf-8?B?TlArdTByS3p1aDY1cFFpTFFjUDU4MzdaenpKWVNMM0l1NEdYNUFrcUZRYkJ6?=
 =?utf-8?B?NHZMd1Q2SnRTbW90R2RWN04xR0VVbjBhazlvY3prU3l3NHhQbWRadkxhZm81?=
 =?utf-8?B?NTBCWkZzS09mb0UxVDZ6WkRVa1RzKzMzN1I3bGJiN083MFhleFZXWkR6YmR4?=
 =?utf-8?B?WXl5aXVhRDFuNDRCYVBqU1p6YzNnRzd4UE04RWQrZXk4a3JPc0ZINWNwTTVD?=
 =?utf-8?B?Z2xrcUQrZVZIOVNaNXltbXpaMmxJOEhHL09tR3JQSk16S0NDRFJ5Y2tXc3Nn?=
 =?utf-8?B?L2oycUFSZjU3QUFBNjBXY3dvQTZSNDRsc1EvR1M0Y2JlRDA0MzFCdjRTV1VK?=
 =?utf-8?B?V0RabXJQNHpzbHRJWUhKbjVDb0tPTVROa3JjbzI1RXd1dHFYZ091WTMvN0h5?=
 =?utf-8?B?M3pFNmpRdTBJbUdsMjVGbnBqZ0pOU0c2OXpRRDY3bHFuN25ad3kyaExWc0JY?=
 =?utf-8?B?cHpFNm9ONTBscmRXbURtd2JEVzM4dWlBOUJHcXZhK253eXFZQ0wxakZYUzA1?=
 =?utf-8?B?MXQ1dWJ2b0NvQzdIUWltS08wNFQwUWZkRDFQSjB5eFQxRmQ4R1R2akd6bTB1?=
 =?utf-8?B?N01uR0ZJT3NCdUpHOWphRTVudjVlUm56Ty81Y1hqUWlKUUxGVHd5TGZodXVq?=
 =?utf-8?B?RXJXc0dRSkdWRmlOZWZWMHlvdGdzY0ZpOFI0TURya0l0UWVoZTNZTjF6Sm1v?=
 =?utf-8?B?RGJhTjBFNDkwRFZBZU1nTTVSRGpIdXlobDF4WGM5aXU5M0RJeVVWaXNqaFoy?=
 =?utf-8?B?bUpjSnJBREhCWmhMamtmSXhGU1J0bTVMK1ZHMTZCcnZ3ZFBuYzhmeElXbEFW?=
 =?utf-8?Q?2kJ569F9cg1u7cnUWg10bTWQl3bhXcWxcUfcI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc362163-1679-4116-9c51-08d8dad028aa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2021 03:31:24.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: st2K5I2+rL3SOZOoRfbHMUVTtfe2jbWj3lQ4iZWIZF86ylJBN4G46VpTM+FDMmiD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2061
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-27_01:2021-02-26,2021-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102270023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/26/21 12:43 PM, Andrii Nakryiko wrote:
> On Fri, Feb 26, 2021 at 10:08 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/26/21 9:47 AM, Lorenz Bauer wrote:
>>> Hi Andrii and Yonghong,
>>>
>>> I'm playing around with enum CO-RE relocations, and hit the following snag:
>>>
>>>       enum e { TWO };
>>>       bpf_core_enum_value_exists(enum e, TWO);
>>>
>>> Compiling this with clang-12
>>> (12.0.0-++20210225092616+e0e6b1e39e7e-1~exp1~20210225083321.50) gives
>>> me the following:
>>>
>>> internal/btf/testdata/relocs.c:66:2: error:
>>> __builtin_preserve_enum_value argument 1 invalid
>>>           enum_value_exists(enum e, TWO);
>>>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> internal/btf/testdata/relocs.c:53:8: note: expanded from macro
>>> 'enum_value_exists'
>>>                   if (!bpf_core_enum_value_exists(t, v)) { \
>>>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> internal/btf/testdata/bpf_core_read.h:168:32: note: expanded from
>>> macro 'bpf_core_enum_value_exists'
>>>           __builtin_preserve_enum_value(*(typeof(enum_type)
>>> *)enum_value, BPF_ENUMVAL_EXISTS)
>>>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Andrii can comment on MACRO failures.
> 
> Yeah, I ran into this a long time ago as well...
> 
> I don't actually know why this doesn't work for zeroes. I've tried to
> write that macro in a bit different way, but Clang rejects it:
> 
> __builtin_preserve_enum_value(({typeof(enum_type) ___xxx =
> (enum_value); *(typeof(enum_type)*)&___xxx;}), BPF_ENUMVAL_EXISTS)
> 
> And something as straightforward as
> 
> __builtin_preserve_enum_value((typeof(enum_type))(enum_value),
> BPF_ENUMVAL_EXISTS)
> 
> doesn't work as well.
> 
> Yonghong, any idea how to write such a macro to work in all cases? Or
> why those alternatives don't work? I only get " error:
> __builtin_preserve_enum_value argument 1 invalid" with no more
> details, so hard to do anything about this.

This is a clang BPF bug. In certain number classification system,
clang considers 0 as NULL and non-0 as INTEGER. I only checked
INTEGER and hence only non-0 works. All my tests has non-zero
enum values :-(

Will fix the issue soon. Thanks for reporting!

> 
> 
>>
>>>
>>> Changing the definition of the enum to
>>>
>>>       enum e { TWO = 1 }
>>>
>>> compiles successfully. I get the same result for any enum value that
>>> is zero. Is this expected?
>>
>> IIRC, libbpf will try to do relocation against vmlinux BTF.
>> So here, "enum e" probably does not exist in vmlinux BTF, so
>> the builtin will return 0. You can try some enum type
>> existing in vmlinux BTF to see what happens.
>>
>>>
>>> Best
>>> Lorenz
>>>
