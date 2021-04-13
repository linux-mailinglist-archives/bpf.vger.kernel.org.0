Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C03335E293
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbhDMPWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 11:22:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25686 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231640AbhDMPWU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 11:22:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DF9MZr017752;
        Tue, 13 Apr 2021 08:21:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GBaAZoP7Ie741Ba6QBCvBnCy9XuvjqDFqk30YB6kyDI=;
 b=YZMhnoMjbBjdtuNzfWkLvJxPbwfgxAuYwUK4rU0M7KeWxaMOe1UvT8/B1njWsT5IVYXo
 Q15eqZZQxQhsCDoI5tfLg0jzOdzalRE4+rzJqiDX5683ZmgKgxgthCyB/I2I4QbeuIh1
 6kHY+OdnOkKzlWcztK5iZA4gCGL9SoxUEd4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37wd5wr9cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Apr 2021 08:21:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 08:21:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBaDIuZ4nRl7Bal5vJLujtBJ1mVIC+yFuHeYj20LaPqLitphB7UbsOCUXAbynrl0inwWV/LquKBNr3HFsiyY97SLPgE66+7d51+ICAx4PBCBepghHmf7bP6FinEqyJuxcDfXXaQAZ66TbvjGW43NqZoHP3/Df9wWzQYR/SqyABbxtOq0sZLQFruY1LsAgypoHlpxrQVlMTHxa3FPrDBWI5yDSKgOR2myYjbThD70YirtUsPS2FpLfis78F7k7hhj4ljLtusFo5h14XIhjYILPDl+cEHwXMnbUeRMW5QeOFDl4ZDw3d4Vz4ZuvH5N9aO+mxrPeAJehnBeka1iWV9O6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBaAZoP7Ie741Ba6QBCvBnCy9XuvjqDFqk30YB6kyDI=;
 b=GG2LOEu5+kWZNct9AH/VLnhvwuubRgcabVsxX7ubIIKo8SsM+r7i/iGjK8bm0G12lgaH9RX6vKLouHP22gjS5RwVZxxojtQ/LbLb62fG3KBaxXTA7DQgpP2sCXXF+kU1kxR9hHmPnnJm/+PGCRBWu0vrUqUxrJ2GQje6JR0OMRIEfINdgKBjKdSrLJuinLaXjeAmLXOauf11phLiZ4igrLMub/KyQfyn2maieVFmjmKziJd0H0jQU9X+QTk7smfTfzn3kd1SCgiywt2mcZYD1Iwz2l4wzbW3tk92BxnYgA6gRQ76LqFAflocuQeuvQkkZtUM2vdTAx7MMg4NC8/wAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3822.namprd15.prod.outlook.com (2603:10b6:806:83::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 15:21:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Tue, 13 Apr 2021
 15:21:54 +0000
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210412142905.266942-1-yhs@fb.com>
 <CA+icZUVFGe443PsDj8SmBpD95YEBzYATgx8LDQQwYtdY+j6sxw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3996f0de-2ade-ef1a-65c8-fdfb073dfd4d@fb.com>
Date:   Tue, 13 Apr 2021 08:21:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUVFGe443PsDj8SmBpD95YEBzYATgx8LDQQwYtdY+j6sxw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:d65d]
X-ClientProxiedBy: CO1PR15CA0046.namprd15.prod.outlook.com
 (2603:10b6:101:1f::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1a0e] (2620:10d:c090:400::5:d65d) by CO1PR15CA0046.namprd15.prod.outlook.com (2603:10b6:101:1f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 13 Apr 2021 15:21:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e68e4063-fd94-4e64-45e4-08d8fe8fde7d
X-MS-TrafficTypeDiagnostic: SA0PR15MB3822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB38225E68E12D24F6E35029ECD34F9@SA0PR15MB3822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5r5Nq2ZjVo7n0x4vHwiCB4a8XXu8zqbdcDPmQXZV08Zh6LmGzSa8nniThxsjHDL284CoYyHE5nfuhKrCiFABHDaJ8zeDC/vkVs0cqXLIk8lmY1Sam7fhy5a5RzGMNwnYWi0UetLQuKO29/qi8IeYKNOzcKpzcFk/giUkExzBx6rcEDuJ0F7+SvZGBWTShE/xxaNtP7aM4env88rZxZCKD6JH0Go9YtsSzmBOCWHXR1JOcZ5Bz8jF945Mqpyn/JLu08pxkb9dwFE1F0ahamx8D5yd6DZLg/D5SiS2NOVF/gcOclPytIwPcXORbcei3l/midwSv7kM7cktJaL10gCdoLiFiljqGF78Q9lcO3fHXrlqjlsRrBNZy4ydcPs8ewOFX232xHcwhrm+JJYeVyzWZ+ZEpMZweqGab+QADjjhDf1BvgIBP3FTc5Z3Im+6AxzxCyyvAzQpt2Noi8iNHBk3oKK8f4TgpAh+MuxjMoWq6glm9EpmAUhsZnsTsbSQFt/Jkt5cu47k5DcVurOO1BzURqbD+U/HqKUmrD3I4GQCGuPXxn8wo/QJ+tkHDH28yLJIGqya3PiDxreGiDNV4m7Y4/QMokW3seIW7xW0gSmoKh90ID0fHSlkLH2xv64e5QhQq+sUhg/QICBxz63UVGDvcEZL9TXagJ88T0NECZhZlbvJTOhYvKUw2cL1td4z0nX87KXG+/UbjK8X/RdTYCoaaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(366004)(376002)(53546011)(8676002)(83380400001)(186003)(31696002)(54906003)(66946007)(66476007)(16526019)(86362001)(2616005)(6486002)(66556008)(31686004)(316002)(4326008)(52116002)(8936002)(478600001)(2906002)(36756003)(6916009)(38100700002)(5660300002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWNlTjdTeEUvZ1pra3FxOEt1cm9LY2dZdmZ6anJkTDBPOTkzN0t5Q2MxdnhM?=
 =?utf-8?B?MnR3ZXdvSnMxRkVFU3Jhck51b0JvT2dYcnllUEI3cjU1QUtJU0FQUmZQUk90?=
 =?utf-8?B?RWtoSGtiQXFiczBCeHhXd3Q3VlpxVCsvVnBEOUdFMXRxZ0RibXVDOHovQ1BI?=
 =?utf-8?B?R1JVTE9Bc2had0lPQ29FUGRHdElDZ0NlemhzeGxub0k0c2VrcHJUUGIvVEZR?=
 =?utf-8?B?L3A2SFUrSlcvMlFjREdJbllBMjdueWMzZ0wwTDJlMTYxZ2MvdUxaME15cFhx?=
 =?utf-8?B?NUdDK3p1dFZGM1JwbG8wKytudktGbm5GS1FBdjhibHlaYjlUa2lka3MyMG1S?=
 =?utf-8?B?QTI3Z1BqbG8vMkgvK3VDN3haa2JrQmQ4VTNXbUt0TE42MHNjSndNYUR6aVdL?=
 =?utf-8?B?bG9YSXBoUktxbnlvUFArUU1GSjRZMzhIUmFmYzRPWFZiRXJpRC9jOGlpOEdm?=
 =?utf-8?B?VmFMWFV2MDZieXR0OGpFbGsyeWNqVXJ4Ryt4d0ZKTmtyMmN4UXIrN3hiNjNs?=
 =?utf-8?B?MFk0dld5Z2MxczhVSlhlczF4eXhCQ25NZ0x6OExlTlpRTU9tcTFwYWF5OEZO?=
 =?utf-8?B?b3h6N0RZZTVXcmViZ0ZUQzlBeWk2WUtXRk0rWVpNSzBTQStkQm01TTZqMUNn?=
 =?utf-8?B?M0xZVTFBYUZVRmQ2TWZrT09BaUgvWWZBMUtjdHFuc0lraDJRMjFSOUxHQmtV?=
 =?utf-8?B?bldlZHRvdHlPb2djUmlPdlhHNU8wTEQzdWlCSFBkaVpqNGE3SFEwRzVyd0l5?=
 =?utf-8?B?bGNTdWxNMG54azdRWVhJcFQzRFJ4QWQzOS9nQVRleHhJdWhLRlVCRks5RHRX?=
 =?utf-8?B?TlZnY3hqak1XMXVhKy9JSDloZ242SDNSNVlHSStiSm1rK2pXREYxbFhpMWZZ?=
 =?utf-8?B?a0l6QmNId0VKZFJMNTkzSVh4ZWhXQVhaUUMwYmppV3FYSjVIWERTMGpDdSs0?=
 =?utf-8?B?UlpGT2kyakZkMmNxQ1ArNW9GVEZDZVpSMGxtRS9PbWdHUE85NmVGeFpzOVdi?=
 =?utf-8?B?WXB4UCt1R1J5ay9YUCtrZ2NSZ0tKSllMOTRIb3dBU2dmNWFjMVJmcVQwRXVD?=
 =?utf-8?B?NWY2TGlDaXZhS3Jkck9ORVJNMjB6SFhIaFh2K2xhbVN2Mk5saE5iZnNiODZz?=
 =?utf-8?B?a1JpNzdOTE5RSXk1VHprcnBObytPNXlqRnBkcDNGTEdMZ3R6L1lnaEN4NDJo?=
 =?utf-8?B?QUtpWjRwTUNwTTd1T2pPOXc1TWhOV0phRW5YWCtCdlFDdnBwY1BaS1Q0Q05u?=
 =?utf-8?B?VFdlUmxpMXA2K0NQNjNreUpId25yZ3M3a1FFQ2pOTnYxaDI2U1pGOS8xbmFF?=
 =?utf-8?B?MnRBT3dZWEFZRngvZDZFYXVOaWtOaXNqMUZ5aE4yRUdGNjExSUVQRXE0N0pD?=
 =?utf-8?B?WEIwMUJ2UTJSS2x1WUJZdXR0K0tEcU9tM0pWOFNTbW5FMEpEa25ONFMwSmZT?=
 =?utf-8?B?Mkg3dlhUbldqbGpabkhlQUU3S1lEaHdWYlBpUUJUdmdSV3BiQVN3NkZXZDJV?=
 =?utf-8?B?TEc0aEhqZ3U3RkF4WGlYcUYyc1dWZWZiOFNFRWJaTTJMVWo4NUc2NStxeGk3?=
 =?utf-8?B?T2xyR2FuUVk1UC9QZXFpbi92blh2VlhHUjlnMkwzWkoyRnVZZ2tyRVFUQzNw?=
 =?utf-8?B?dW1yTlhmZnl6M1I4aGlvU0F0NFJCM3JGL3RORWVGMEpqYTNzdi81TitRUHhv?=
 =?utf-8?B?MXpWUHBiWTh4cFIvOVZ6cFBBT1oxR1pDcjdXWUJpMEs4dFpBMFVaend6L3Rh?=
 =?utf-8?B?eWYvTUkvWXJQQ3dnRUhWcmJWRjlhWTVEc1N6SGpsZ3pnSC9BMk9BQStvT0oy?=
 =?utf-8?B?S1lneUVDU0pCaXdzMkM0dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e68e4063-fd94-4e64-45e4-08d8fe8fde7d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 15:21:54.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQbYmeTjYZqCBgIdjjFzN3oskXRkW5ThEa0hAlgb1SVMCcfvE9j9d5kgFZyyN578
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3822
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: slOyN0pdaumd5sx5pV2f6haLw8eWr9QP
X-Proofpoint-ORIG-GUID: slOyN0pdaumd5sx5pV2f6haLw8eWr9QP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_09:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/12/21 6:44 PM, Sedat Dilek wrote:
> On Mon, Apr 12, 2021 at 4:29 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> To build kernel with clang, people typically use
>>    make -j60 LLVM=1 LLVM_IAS=1
>> LLVM_IAS=1 is not required for non-LTO build but
>> is required for LTO build. In my environment,
>> I am always having LLVM_IAS=1 regardless of
>> whether LTO is enabled or not.
>>
>> After kernel is build with clang, the following command
>> can be used to build selftests with clang:
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>>
>> But currently, using the above command, some compilations
>> still use gcc and there are also compilation errors and warnings.
>> This patch set intends to fix these issues.
>> Patch #1 and #2 fixed the issue so clang/clang++ is
>> used instead of gcc/g++. Patch #3 fixed a compilation
>> failure. Patch #4 and #5 fixed various compiler warnings.
>>
> 
> Might be good to add some hints like when the build stops or errors:
> 
> Like in my case when I had no CONFIG_DEBUG_INFO_BTF set.
> 
> Of course in combination with Clang-LTO a pointer "you need pahole
> version 1.21." and CONFIG_DEBUG_INFO_BTF=y.
> 
> Finally, a hint for missing xxx-dev(el) packages (see Nick's report).
> 
> The tools directory has its own build rules thus I cannot say how to
> check for specific Kconfigs.
> I have not looked.

I will add some more information about how I have tested in the
cover letter.

> 
> NOTE: I have not checked without setting CONFIG_DEBUG_INFO.
> 
> - Sedat -
> 
>> Changelog:
>>    v1 -> v2:
>>      . add -Wno-unused-command-line-argument and -Wno-format-security
>>        for clang only as (1). gcc does not exhibit those
>>        warnings, and (2). -Wno-unused-command-line-argument is
>>        only supported by clang. (Sedat)
>>
>> Yonghong Song (5):
>>    selftests: set CC to clang in lib.mk if LLVM is set
>>    tools: allow proper CC/CXX/... override with LLVM=1 in
>>      Makefile.include
>>    selftests/bpf: fix test_cpp compilation failure with clang
>>    selftests/bpf: silence clang compilation warnings
>>    bpftool: fix a clang compilation warning
>>
>>   tools/bpf/bpftool/net.c              |  2 +-
>>   tools/scripts/Makefile.include       | 12 ++++++++++--
>>   tools/testing/selftests/bpf/Makefile |  7 ++++++-
>>   tools/testing/selftests/lib.mk       |  4 ++++
>>   4 files changed, 21 insertions(+), 4 deletions(-)
>>
>> --
>> 2.30.2
>>
