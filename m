Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8758D3E7
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 08:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiHIGgo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 02:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiHIGg2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 02:36:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F391205CC
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 23:36:28 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278NSMhl027569;
        Mon, 8 Aug 2022 23:36:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yXMu3w5q6xYX2fwm+XLEr8CL5B5+rwfrTa2+z76tt2Y=;
 b=e0Tv93m3Y+ips3o3AAaKH5XtP6SRw6zTH6U5fyMmaML9ohYHz1/LetvK4BGeRvlpdu+O
 tfClIfz7Dr048dGnZzeIVHmvJTQoVuR+5wxIG0m3QIii75XGObkN0qgNqrdWTrjAuKCV
 6ErOoiBjLtXlbup+ONzXaZDfSXs98OLu/ac= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsp0q7a2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 23:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVGTAhw1DRSABhQQcVXvjuVzpTz5WqXSR8K/Q4vsr7raygyl3PrY5hO96DlCSSiX2h0/BYxDJYdQSzsTDURnTeUcg4+TpC2sv/K2Vz91YSsM2aVU6CX6G53ywq8b1a2xT48O7xL0lXB5DF5WeBc0qZENgv/grSUi8gIU50UenDy55uT8sz2QduiwJ5OXjHwLI9JN+9Hvrqoe6yV8shYvoRnq882Lhtc2dwXchaNXH+8WVeKpHZRex1m2H+lZ57PBWFBnELOh3Uyz/ezvNgwhrqKgmpYgD1uy8w3GlvY2kuHy7mmK2fwiZf5cnP0rnyYokDGehw257w+gDAp3vqrEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXMu3w5q6xYX2fwm+XLEr8CL5B5+rwfrTa2+z76tt2Y=;
 b=FO2onAM4wPr3RKSzIS0enAd6Oz+TYAc9qv3d6mIyCSELMH6ymKUiCT49TSQjOHcPhxkavzsMng5t6J98/7OuhGwOqQSquqRVzjZNApFyq43zmUCeKXBiMzrzY3/Jz8cbl7DnBCGqPmTVi779LLc6lfGwv0FwMuEH1ZklMkRwyztsx+Ma33IPOcRtzFdHru5EATLQjYv3n+2dFElKnzyT5p7V8/be21thIffNomq96v0eERGcgPi/k4sKwgkfpZ3kq89zJ8OLVO840+LELWBmZbtf7qPB6ECNKQbFJda6ZI71fwzsLHxo3S3l2s3ejp7CMSgww/c2FLyM+vPqHlNLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4197.namprd15.prod.outlook.com (2603:10b6:510:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 06:36:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 06:36:09 +0000
Message-ID: <b72643b6-831e-9362-c54b-ba6411338c77@fb.com>
Date:   Mon, 8 Aug 2022 23:36:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next 2/3] bpf: Perform necessary sign/zero extension
 for kfunc return values
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
References: <20220807175111.4178812-1-yhs@fb.com>
 <20220807175121.4179410-1-yhs@fb.com>
 <CAEf4BzaJydVpt+H6abR6udjcQ5Scu07W+LLQyo7jC9et9T=ZOA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaJydVpt+H6abR6udjcQ5Scu07W+LLQyo7jC9et9T=ZOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c777a5dd-2dc3-4c04-c175-08da79d1721f
X-MS-TrafficTypeDiagnostic: PH0PR15MB4197:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vG3YnZ268ffw9unsr7DEzSBhDkJq3DyimvW8j1BDKhFj1BmqQNVsHt4aYaWJYArsA8AruQppaoAepsKnYOq2bhLGi+BAq8p/IbL/bnUUYWmvGgTl3zfeHT0EK4xeBvcDXXCetB09GLBPiSMY3N9U+YHOBK2sBxmZddnRCxSZnyl2RuEq3xEfS4ELs3Nu6bIZP282ehaREahCyZ64WGCdvon0Kk44sihcxhLAulIl2SmKwMLOl0mw3buymGDfSXf7rF9K2jqYsyX8jaATYJhOdmmm9xOttqS4jkOrIRHp8mSo5Qw9VFBGGlKz6R4IYZM1EoPVBCp/URMm2Wr6aBz8XyiUXElEckbzAWzRsezkchBDbcHN1zIszIhSKldHCE1JGKs9coLwKoUMtfOcEGLfXmh0hg56w3Rl5Ubdjx38jTeNrFZ5QZAwKo04kmVzOFED0RJW1Uzn18CSpcz0E2INAPA7YI5sYkZbtGBPRPCqsRq6tZHkoGzH8LZN8/3tbhFL43IkbnqKS6sEpqlb9MQEMWGxBTyD7xGOU05ILIZkrV9xeN4lvPSzfLatMsdDIDSrm4/CJmq5RoP2seC3E+vRhh8RTpFm8zemNZyNuBwTyfjFOU/Zk4w6kWJturQa7vTIccFeX6XvEHVUUagYKJX+SsNQSk60qbWyCFkgdLkGeciG7/JCFGZuocJ/p+BjsKCf+ey/oDdkFt2lPfNdKcPoYZ+SK+7YaeJuEHXHR4HphJrcbwXNgPPiIGpK9SdD/fyQwRkWm4+yhqsQgkVa0CiPEH+h9//d/I/7cTaGBY7dHaOjXYqQeUKt9lKMkLY+BilFZ/aQmgJCHgKgMIUc6IZfUjD2higedc88LDDIJu89HKJJCfLMCXbM+aQeFSK90x4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(4326008)(66476007)(66556008)(66946007)(83380400001)(8676002)(6916009)(54906003)(41300700001)(316002)(31686004)(36756003)(6506007)(53546011)(6512007)(186003)(2616005)(2906002)(8936002)(5660300002)(478600001)(966005)(6486002)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVVxSTF4MkNMVFhsNlNtaGpDVEV6eUltL2RXSE11NjZhcUxvMy85ZWk4ZjhC?=
 =?utf-8?B?KzV3akxmcmpIOHRhelZGMkhqcmIrMUR6Ym1kNmIzb08xdVpBcmcrdlpIb0RV?=
 =?utf-8?B?cmgyYVc5Y01ITFhmWkJVRndsN1hOUDM5dEM4cEVqcFR5YXZ1R2I5OEdmS01n?=
 =?utf-8?B?UzI5Y1ZtdFh6ZkptSDJXRjl3TUVRdFBWSHJVOHNDSHNtbmpqMndkSWlOcXNn?=
 =?utf-8?B?enpvUytyc2U3Mm9ra1pwSlIxMVBLeUVJODVpUkRWQVFuSWhsQTdnNmdtcEp6?=
 =?utf-8?B?alZuZ2VZUjFxTjg5TlJDWVp0Q1UzcXhlL1IzbU8yaW9qQ0lOclNiWEx4YStI?=
 =?utf-8?B?UkI4WWFFRHR2bXFKZlA5WnU3aEdYK3Y1bVJEWkl2MWdFUS9HU0FaMGNscSs0?=
 =?utf-8?B?NmRwMWdrNTNBaDNXaUxGQ01nUXlMaXY0NTZpVFdsQUdTb25GR1IvOHBmaFdm?=
 =?utf-8?B?S1JQNGlXTWNBTzFGV3U3TEpjak1pUGt4OW9VRnF4NVdxdkZ0aW5rL21PblQ0?=
 =?utf-8?B?MThQS21FOUcycmVTakxRTjMvR0VWWmJuVUpYa2tPeTgralMrUHlwTUw4OVcy?=
 =?utf-8?B?eEdNREx2SGt0ZFlWVFExZGlxVHU3ZTF3dW91cSszbkRCMEErM3p1YkRjRnk1?=
 =?utf-8?B?VEF1U1MvNCs0RHJpUnp4bTlNN0NKekdvdnZTYS80Q2hydkJXalRKV1A3cUs1?=
 =?utf-8?B?VzJQeUhuMmY3Tkw0VzQxZGUwdDBPYXdHNTNreUhlQU9XVnFuNjFqeFRHY3FQ?=
 =?utf-8?B?ZmE1M0NFMnhXeHdmUFBrL0dIc3NvbVc3Tk1KWnk0dG5zcjdFWGt4M3EvSnZm?=
 =?utf-8?B?UVBLTTdQWml2S1IxdVBDajdxK0tQMDZOdngzZTBNbkFSVzB5TWFQNGxTY09Q?=
 =?utf-8?B?enlOcE1xSjN0WTNHQlV6cmtranhadG00Zk9zNW9GVnJ2WG8raXVTZHlTb3dS?=
 =?utf-8?B?RTFxTTRjKzVOYkRVSlErb2c2U2E2N0xocGtHRUtLMVZneExvdkl2bEtBQjFV?=
 =?utf-8?B?UC9jY0VZL3VDeWNzVHovMFpGb0NBUGpMbklvcEhScDd5Z2ZuVXdSdFUyOEJT?=
 =?utf-8?B?VGh1d2Zna3RUWnlzVThORmROWk5hMC9sMURha1ZDZ3ZkajVBa3VXeEMxS3dh?=
 =?utf-8?B?YlRtYTFKVDdicVhPVUFreVNOMDJTT1pqOHNBNE9meEZXUUplc0llQ0F3QUhQ?=
 =?utf-8?B?NXQzRjJTcUhETHV1ZU9RSy9rTWZ3dUE4bURpY1Q3SWdGQ25aNEFYNmErVm1Q?=
 =?utf-8?B?OVdSYzkzdlpRN3U3a0JzOHdhdzB1YXFISndDa05GZldnUlF5QS9wck45eG9C?=
 =?utf-8?B?eTUxYW1LVzJ3dHV5WGFwTkhrNVR2U0loYWV1REowdnJFZFhIS1FheGM4dk1L?=
 =?utf-8?B?ajFJcFQxS0JoWmcvYXpSODhoeG0yQzQ4NEkwZ0U1dUNxclc3TE1IaWhBN2FV?=
 =?utf-8?B?RnZEd25IY1QvOXQ4WnhRVkxHRC9tcHlnV2crbnd3MHlUWkp2ektGR2FNOUVm?=
 =?utf-8?B?aWxLTFNrajFtV2ZaOUpmWmw3VitKWTh4TWtmdGV0MXpoUWdHc0pzdDEwNWZj?=
 =?utf-8?B?b016aXBsQTI5N2ZoQ2J6NEszdU5CYXpzUzY4bWJrQzJmSCtiVUJtaW9ScDFP?=
 =?utf-8?B?cEJvN3V5eDlUT0l6QXR2MTR4cG1rUkNLbnltOUNzZlluSnlEcmdNczdyN2JH?=
 =?utf-8?B?WTF2WG8wSGlJNG15dGY3SnA1ZXF5UTMrOER5SmRiTnpzRWR1Q2VwdnVjN0NR?=
 =?utf-8?B?Slgzbmd1UDFibm1KdjloZjhzTEdjUFpBZGZZQjRvSjgrQ0JHWTFDaDlwOUVT?=
 =?utf-8?B?blRNejIyamVBOXFFOGYzMnVMd0daQi9RbDZmUUs5WFJ4aEl5M0NHYTVUeVEz?=
 =?utf-8?B?YjZRNFc5TGhFQWRRWk54QUcwV0I4QTBJcVVMVXNpVlFGeGk5RTVtQUNZSDhT?=
 =?utf-8?B?a2pZU1luYk4wdGlYRWt4WFRiN1U4cE5zclhGQXBzQzZyY0lNcUR2SHh2WkNT?=
 =?utf-8?B?U0pMVWdSMENBbFJsREx0ZFRXdzNqdjRna3IxVDhWeTVER3FncEIrbzRIZHRW?=
 =?utf-8?B?TkhZSHQrcmVmM3BxeTdwSUpsZjM5MkdRS2FYeWlUbW55SjhCL0pGMmZIODFo?=
 =?utf-8?B?RTFFdXcweEJTdU1INFhCWm9OOXFaVENtMzl5VU1tbU9TbmtEdUh0YTRubWcr?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c777a5dd-2dc3-4c04-c175-08da79d1721f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 06:36:09.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cn9OZI45pvCjAUIJkTUYleex8B5oMHBBeJJUycNuErOAbmlmrViZMDcsECOSOyl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4197
X-Proofpoint-ORIG-GUID: ev7HoVgOanokd1QPzcQqPHBtfG4JpAjt
X-Proofpoint-GUID: ev7HoVgOanokd1QPzcQqPHBtfG4JpAjt
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/8/22 4:25 PM, Andrii Nakryiko wrote:
> On Sun, Aug 7, 2022 at 10:51 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Tejun reported a bpf program kfunc return value mis-handling which
>> may cause incorrect result. The following is an example to show
>> the problem.
>>    $ cat t.c
>>    unsigned char bar();
>>    int foo() {
>>          if (bar() != 10) return 0; else return 1;
>>    }
>>    $ clang -target bpf -O2 -c t.c
>>    $ llvm-objdump -d t.o
>>    ...
>>    0000000000000000 <foo>:
>>         0:       85 10 00 00 ff ff ff ff call -1
>>         1:       bf 01 00 00 00 00 00 00 r1 = r0
>>         2:       b7 00 00 00 01 00 00 00 r0 = 1
>>         3:       15 01 01 00 0a 00 00 00 if r1 == 10 goto +1 <LBB0_2>
>>         4:       b7 00 00 00 00 00 00 00 r0 = 0
>>
>>    0000000000000028 <LBB0_2>:
>>         5:       95 00 00 00 00 00 00 00 exit
>>    $
>>
>> In the above example, the return type for bar() is 'unsigned char'.
>> But in the disassembly code, the whole register 'r1' is used to
>> compare to 10 without truncating upper 56 bits.
>>
>> If function bar() is implemented as a bpf function, everything
>> should be okay since bpf ABI will make sure the caller do
>> proper truncation of upper 56 bits.
>>
>> But if function bar() is implemented as a non-bpf kfunc,
>> there could a mismatch between bar() implementation and bpf program.
>> For example, if the host arch is x86_64, the bar() function
>> may just put the return value in lower 8-bit subregister and all
>> upper 56 bits could contain garbage. This is not a problem
>> if bar() is called in x86_64 context as the caller will use
>> %al to get the value.
>>
>> But this could be a problem if bar() is called in bpf context
>> and there is a mismatch expectation between bpf and native architecture.
>> Currently, bpf programs use the default llvm ABI ([1], function
>> isPromotableIntegerTypeForABI()) such that if an integer type size
>> is less than int type size, it is assumed proper sign or zero
>> extension has been done to the return value. There will be a problem
>> if the kfunc return value type is u8/s8/u16/s16.
> 
> Reading this I was still confused how (and whether) s32/u32 returns
> are going to be handled correctly, especially on non-cpuv3 BPF object
> code. So I played with this a bit and Clang does generate explicit <<
> and >>/>>= shifts as expected. It might be worth it emphasizing that
> for 32-bit returns Clang will generate explicit shifts?

Yes, I can reword the commit message to emphasize 32-bit return
value won't be an issue.

> 
>>
>> This patch intends to address this issue by doing proper sign or zero
>> extension for the kfunc return value before it is used later.
>>
>>   [1] https://github.com/llvm/llvm-project/blob/main/clang/lib/CodeGen/TargetInfo.cpp
>>
>> Reported-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h   |  2 ++
>>   kernel/bpf/btf.c      |  9 +++++++++
>>   kernel/bpf/verifier.c | 35 +++++++++++++++++++++++++++++++++--
>>   3 files changed, 44 insertions(+), 2 deletions(-)
>>
> 
> [...]
