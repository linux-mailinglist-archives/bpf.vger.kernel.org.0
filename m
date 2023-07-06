Return-Path: <bpf+bounces-4181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A8749528
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270EA1C20CF5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8811102;
	Thu,  6 Jul 2023 05:57:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292110EF
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 05:57:19 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B32F7
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 22:57:18 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365NU3UE024487;
	Wed, 5 Jul 2023 22:57:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=S7hMqXnUBsYFWkjdNvD7obp+YTfguSz4DgbkEQmjluA=;
 b=JoTnkYdhpiyybTfEKsLyfqL+eV+qdTosbrLuo6yA4x2I5twuClE9K7CVSE/Y1XikCYb8
 EE+z69TJH9KmhBodpdvnvQjW9nJM0T5a2tEjmS97Mg0vBdEG7fpyTV9bSBkkhis8Az6z
 nHQHttDuyLAp8rmtzzVQ6KUTs6MMo+M4zQ0tk8C3hLO21RmASZ5bAf+XpVDIMUWnL7kf
 kCu01cj6oA0PUzqbYi00sVmRbOn3L9SNQxl9/uVwL/9LeSRv/i7WdQs6Qz9vDNBzN8dB
 VQFXqTr5hVEoeFEN6JwI+jBR4+AbM+vTLaM9va1kOERxB5NjKAc+H4LY95AfGgJp7tRQ Aw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rn0nk26sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jul 2023 22:57:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVanvXdpqXS9Mde56QMfqm41NoeomJq55z+yZoFeA0zJW65LsIluEp41vIq1UD3Uo2S4IMoEpR0sQDQb2PywXCjtqNlegHKlMHV2IUyCiru/BeRGul4aNHmBymzjRq3xHYlRqw2wLuXj7ODSXNYtSBSIZuVQgK3ZY8ue7dRx/4dHzJpsCh/a1VUv+Y5WKZFMLqKp0kpk1iHBO+aysY5rm5gIDNvjN6C+xb2+O3V/bvGk59d90UhTP+18oZndX0oPvIEAccvMDb7ptGam5SmnPkgXaEtNgMWtB/4k7YeLMmLnDf1ch4ohaxKiUlJ79YDvbzxzZykXJlfER5R8URpT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ0zZCNRPus9+cQycGQabl25eCqD92FxChJ3zuwkS1U=;
 b=YFrqdbxkXqPQI+H6ax9oX2hL5kH0Q+oZi0p6jhHQuOVxOcYCTb60002/rNZ4DI4w69dcuW6Ip8OJCYvdiPFmZtOC5OGmZ2ZPo1vAA70Sf1D8VeC45qrtoG7zhYHou6ikNrc/grqeiFhsaG/k49BI6N6OnnAzPwzOu+LY5HZOy3c1/O/rkOKCFhr6LbArq3XnmDugfvoz4vrKZGGLE1+3utrVl51fY+72nUAUCX6bvnAvIII9YxwbikE5rOiM5jLDctK84es9ejMQMf3aqbxC+q6J1vTft/OAt1FweI3/oh+iIGubmUpOJKfc88I7jcUdl7+T9Xts1+LL+vnGKHPA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4684.namprd15.prod.outlook.com (2603:10b6:303:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 05:57:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 05:57:12 +0000
Message-ID: <2fc4c441-be47-d74a-ca29-258732fb8513@meta.com>
Date: Wed, 5 Jul 2023 22:57:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: CO-RE builtins purity and other compiler optimizations
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, cupertino.miranda@oracle.com, david.faust@oracle.com
References: <87zg4as04i.fsf@oracle.com>
 <CAEf4BzagYTGu3eTVtrY+72-CSHDgrBiM3qeeFR8COc9MUYA9HA@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4BzagYTGu3eTVtrY+72-CSHDgrBiM3qeeFR8COc9MUYA9HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:332::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1601704e-3b45-4db8-e2c4-08db7de5d792
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cXzgwZgj3DHfSlnR4vPQSLaqsRC1DMJEhcCyKysasrFdNofYBEPazWXxRjBchVUeSG5Pu04CbD8/i3Oj6FZVZNZyEot9OvrjOiX3LAc5yG4BigojyZtTQR1bEONgzaZ5d8clUhlrBkjbChZtYminEEWOIjuGzVdL5+D+7WB+9Pxw7xC8/RydpZB7t9ft0WJ3nW/AmvDP/HFBNvkIdagr9Q9QJsbCWj9owfIlPXKMnZDpoGxb0VZ03VpDkqMOB4Kvg7vaBOIPk2Ean2wuvizCxx4toU+oH0p2P/Y0BH4HkgLG288LDPdRf/Yv1Gxe/P+puiImVZ1dVn3Q0se07LZdNE+JjUHQvTQEyC+982IQ6bhXAyqzcWzlPQgRkZdfcE16KNKnkZxiz/9qDpiWIjNC72V1vwzZH5HNWJr1K7UEqYY1z0DgfRC/mQOYq1waTS9R5Y7KJOlJmwKvm3IkB59P6y4rzfOyZI9EL5/9unUXgDdtSx0BKN9USVm0/aJyTI9bRJeHL84YqMNe3nWbVTZqF/IDJZ6WcNDUav+9obSuHh0uvkqH3ATgGjKhBV+Ra6+UGkUmhW/QVJnnkPUI0t58zjHeR+iZJENv1lXMUgbbbvvHBv3satUL9rqjIDJxY1lo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(66476007)(4326008)(66556008)(2616005)(31696002)(86362001)(186003)(53546011)(6506007)(83380400001)(38100700002)(66946007)(6666004)(6512007)(478600001)(966005)(6486002)(110136005)(36756003)(41300700001)(8936002)(8676002)(31686004)(5660300002)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UC9jR0FraHlNQzZCRmhyL0N5UXZYS1oyVXlpS0IwbWVDM1MrZHJJMFdDZHZj?=
 =?utf-8?B?VkZZSmpVVEhHeWhRa2FYbFZDaHpmcFNiNEtxZU1SakZvR29VMU1nNDU2UWdY?=
 =?utf-8?B?RTBFTmZjT1lwdXB5MW9kZ01YNUpMbEU0L1RTeHd0dUpiL2NuTlVFVm1XMkQw?=
 =?utf-8?B?RkN4UHhHRUFFcWYxSVllY3ZNUFg1Y0FwTWFQbk0zNWlucWlNdGZOUW1Xcm5R?=
 =?utf-8?B?VGx0cVFpQjVLbGpmaVlXUmhVaFdVajdmMy8xVWphY3gvQ3JCTUwxeWV0SVR1?=
 =?utf-8?B?cklQbzVBeGtvejNPVjltQjFGZ1g3QXRJQXRXcU1FMjRwZFErU0Nla0pTZXJG?=
 =?utf-8?B?TklOcXFYUnJmU3Ivclg4Q3prQkRNWUZ2MDQrT1ZVa1ExZytETUd4YUZWQnJV?=
 =?utf-8?B?UDJJRCtQOXRsaVJtM2VFNjFTWEc3Nk81cXpLTHlkbnpxcGdTdTc1Tm1Ralls?=
 =?utf-8?B?Q3YzNndCUnViQ2g5Q1BqMkxGcXhSQm9sOG50MVdmMUVPR0N1Q0FKVi9kVDRa?=
 =?utf-8?B?VmpiaG5sYk1JeEFVYkZoL3NLeFY1bkI4MnBMeVpHM3hiV3F5ZjIyR0M4aS81?=
 =?utf-8?B?TGlRbm9sUzJWV1RJdGl0THQ5TVBVWm1BT1UxWm5tZVM2cm0vMzc3RDZVYm9x?=
 =?utf-8?B?WkNHdjB5U2xXMnNMZFBrK2NQOXVZVytmdW9oaWxHcXI2NTRRTVZoSWJQWlg2?=
 =?utf-8?B?N2tLLzJwbmxmSm16NVoraWZZMjJEWWhUMHpxL2F5aEhFdExSZ0JCL0JCNHdQ?=
 =?utf-8?B?SXA3UnovNUtGcGFLbjgzem1ITTFNdWhxZEhDUXpiT1hvL2lCOTEzUDltbklO?=
 =?utf-8?B?enNKZXNmVUFMS3FYMG9lS2taUy92bG50V3RZTjQzUWdwdUgrcnkwcitjZW9W?=
 =?utf-8?B?NldXalplaWFBSjZMMjZNNnVsRE8yR2Y1bk11b0tkOG9yc0NlNk5HVFBSTjhQ?=
 =?utf-8?B?Qk9oQU1BRUVGQ2lpYnpPbmpZWUQ3M1hyQnRmZUhEUlJSdExZMzhhQmYzRUhC?=
 =?utf-8?B?OHFmZUpPWlcyejZ0c1B5Z3J2VmdjUDVTQXUvS0dFRnE3b00reEJCc2VpRm55?=
 =?utf-8?B?bXBPNlM5MjloOFJmNzJLVGNGQzNuV2cwYng5WHRLRSs0cDA3ZU9ZampsVXc2?=
 =?utf-8?B?RTlBbkdDbFVxenc1RTk2V3lWUzFLTjBMdEY4aG5IRWwwMGxDR0h0SkFKNVBt?=
 =?utf-8?B?QzZnVzdXWlI2bXRVVnA2MFZoYUpnYnYrRWNTQkkyaTJac1M3SjZ2TmJKRE1P?=
 =?utf-8?B?THpBVEdMalZCMENXdXFhaktsT3VDMW4wMk01aEtQczUzNUdMdTdTREhKeWMr?=
 =?utf-8?B?cHcxYno2bk40OUREQVpjVmlQaDVVdURxRHgxczlMN0xMZGFwODlmY3dYbnBT?=
 =?utf-8?B?dW1rMDViRndqeU5aZXR1UTVQUXBhS2hUVkpYQVp0TEExTE5Yb0JKaVlPSkY3?=
 =?utf-8?B?cmFiOTlVZkVEdnJRRHVOWnZUT0NZNVJ1VDB0N3p2L1FkclZ0bW4vNitJU3RU?=
 =?utf-8?B?L1k5dEdFSXM3UFB4eUpCbUR4ZnV6L24ydkg1dmo0WkVEbU9JN3Z1WDV6T0c3?=
 =?utf-8?B?ZXhvbU9talg4cXBFanJ4ZUF1cEkwM1liMnozRE1FOXhWRU8raXpja05kWHR0?=
 =?utf-8?B?cDZldW9ON0x4SnlNekZtSEFMRkJEUUhTNFdvS2dLbWZ0b2hsN2tmRnpnOFN0?=
 =?utf-8?B?bUpIMDBGTE5mcit0MUUzSmR2Mkx5Z25TTC8xTXB1S09heUlDc2xoTkExWWEr?=
 =?utf-8?B?UlpSaUVsamdNWnZDeFY1bFo3cDlYNU9HWjZIeTh5RGVIcE5VR0VnMk4xKzdz?=
 =?utf-8?B?bSs4dnRTZVkyVnllYnZtQk5PaUZPY2VucnpsTlNVcUVhSFhHSEtRTng3d3A1?=
 =?utf-8?B?V3h6Wm5sd3liOXJWcGlvVzZmL1ZaMFc5R2ZEVGFmTjJiRWxKRFRjbGx2VitP?=
 =?utf-8?B?WHBkRE5nV3ZneEhGVVlCUFNudkVheE56TG1xMjR5akF4Rk9wdGU3V0xiK0E5?=
 =?utf-8?B?WVZvSjVTeVd0dmlQbUYwSTZPem4xU3FoUzNJajZJYUZwZXhTQXZ5THhnTHhx?=
 =?utf-8?B?SmdlQjB6eFk3ZFcxQTJ1ZnJ4c0MvZ1RzQkpIa0lwTGZibFh3V0wvZHVvd1RD?=
 =?utf-8?B?eWcvbzQwREFqMndnU0UwWUdLTTJ0dk9zWDhUajQyUnJXaUU5Y2hiSHg2ZlhV?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1601704e-3b45-4db8-e2c4-08db7de5d792
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 05:57:12.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8k5DQTRYSNUVpikHV6t+NX5W3nCJwrFpK5IjOu9nb4Mh8gR6UxvkgiGw8yObtis
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4684
X-Proofpoint-GUID: yvxKCDYofSj55vGG6Z1hju3jSPUUTqL2
X-Proofpoint-ORIG-GUID: yvxKCDYofSj55vGG6Z1hju3jSPUUTqL2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_02,2023-07-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/5/23 5:02 PM, Andrii Nakryiko wrote:
> On Wed, Jul 5, 2023 at 11:07 AM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> Hello BPF people!
>>
>> We are still working in supporting the pending CO-RE built-ins in GCC.
>> The trick of hooking in the parser to avoid constant folding, as
>> discussed during LSFMMBPF, seems to work well.  Almost there!
>>
>> So, most of the CO-RE associated C built-ins have the side effect of
>> emiting a CO-RE relocation in the .BTF.ext section.  This is for example
>> the case of __builtin_preserve_enum_value.
>>
>> Like calls to regular functions, calls to C built-ins are also
>> candidates to certain optimizations.  For example, given this code:
>>
>> : int a = __builtin_preserve_enum_value(*(typeof(enum E) *)eB, BPF_ENUMVAL_VALUE);
>> : int b = __builtin_preserve_enum_value(*(typeof(enum E) *)eB, BPF_ENUMVAL_VALUE);
>>
>> The compiler may very well decide to optimize out the second call to the
>> built-in if it is to be considered "pure", i.e. given exactly the same
>> arguments it produces the same results.
>>
>> We observed that clang indeed seems to optimize that way.  See
>> https://godbolt.org/z/zqe9Kfrrj .
>>
>> That kind of optimizations have an impact on the number of CO-RE
>> relocations emitted.
>>
>> Question:
>>
>> Is the BPF loader, the BPF verifier or any other core component sensible
>> in any way to the number (and ordering) of CO-RE relocations for some
>> given BPF C program?  i.e. compiling the same BPF C program above with
>> and without that optimization, will it work in both cases?
> 
> Yes, it should.
> 
>>
>> If no, then perfect!  Different compilers can optimize slightly
> 
> Did you mean "if yes, then perfect"? Because otherwise it makes no sense :)
> 
>> differently (or not optimize at all) and we can mark these built-ins as
>> pure in GCC as well, benefiting from optimizations without worrying to
>> have to emit exactly what clang emits.
> 
> Yes, it should be fine, as long as the compiler doesn't assume any
> specific value returned by CO-RE relocation (and doesn't perform any
> optimizations based on that assumed value). From the BPF verifier
> side, it's just a constant, so the BPF verifier itself doesn't care.
>  From the libbpf/BPF loader standpoint, all that matters is that there
> is CO-RE relocation information that specifies how some BPF
> instruction needs to be adjusted to match the host kernel properly.
> Whether CO-RE relocation is repeated many times, or performed just
> once and that constant value is just reused in the code many times,
> shouldn't matter at all.


For cases like this:

 >> : int a = __builtin_preserve_enum_value(*(typeof(enum E) *)eB, 
BPF_ENUMVAL_VALUE);
 >> : int b = __builtin_preserve_enum_value(*(typeof(enum E) *)eB, 
BPF_ENUMVAL_VALUE);

Internally llvm (one bpf backend pass) will converts
   __builtin_preserve_enum_value(*(typeof(enum E) *)eB, BPF_ENUMVAL_VALUE)
to a global variable based on the captured info, builtin,
type, value, etc.

Since 'int a = ...' and 'int b = ...' have the same value,
the same bpf backend pass will only creates one global variable,
hence effectively doing CSE.

gcc might implement different way, but for the same
built in type + its same source representation, CSE
should be okay.

> 
>>
>> If yes, wouldn't it be better to disable that kind of optimization in
>> all C BPF compilers, i.e. to make the compilers aware of the side-effect
>> so they will not optimize built-in calls out (or replicate them.) and to
>> make this mandatory in the CO-RE spec?  Making a compiler to optimize
>> exactly like another compiler is difficult and sometimes even not
>> feasible.
>>
>> Thanks in advance for the clarification/info!
>>
> 

