Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4BD35B63C
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 18:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhDKQwR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 12:52:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20664 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233514AbhDKQwR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 12:52:17 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13BGnBbr011712;
        Sun, 11 Apr 2021 09:51:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=z486wpUfwK5i4Kf9Ku78D1jET+ueW8BxJSLnWvVP2z0=;
 b=AJoFI50MK8D1IIwoPd4HVMN1KvDpuHn5EDeBkYiJu6wOAnkVph4sY1Yz3xiTCnlADA1i
 T2VZ8hhOfnHDIXZxfEbtyxfYiey68DrA4liQDQ4Cqn1Z9TIBhne/YyGiJUGsxjOmiIa9
 LIDgGqA44+WBzaWaWipY1H9SUI5Gx1xzI3w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37uurwhk1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 09:51:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 09:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVP8kzhdywXFPFSpYponymhoLE0kjwkRalkgMflJsYRmdw0A4GnS/bnTy+ymwQ/TN6QCnTDOz+rA54y30+5q4HpqUzkQcz8T7BBVQcWcJpx4NJu+ZFPZ0I64wvSZb/bhS1I1Q6TTK1SDUhdnCOWt3ygAyaEJssMkWNHXRGDzK2/UNAV5R6KJtHJSIC0dFU4BYaXymxur/z6+8SHkea70yxDEasbv/Ab/rDPZxSgSRoOCX6YrBFFvY9xL6vEIjqSd0u/DNojkFoW4wrVVhm51HRKG466GVpkaOxgZN/Zi+CPim76OzP6t9DNUbig35eHM6OqK9UO9VUnIWPzC9teyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z486wpUfwK5i4Kf9Ku78D1jET+ueW8BxJSLnWvVP2z0=;
 b=Ww+MeuCsJYpZ7IZW9pgL+T3hVV51MGUX38x3QPJ0jn6aRygxBvAk4rQgvX3Xb3PQ8vqbahbbH9vkZXY/sry45LmPtdWChWiQLjlr2GFm3QlZFYSwcrSap1d1i8amvrP9tHL4KEf8gpA8Ve39Chrw3u2al30ypOF1CFp/qk5iAmGV/hWcoOcL2V5x2vQzx01YsILbrTJZzgqZ01krVmV0PgfhgEbA31DdNdBTJg6pO/5LEnjUkgSofs3EZ0U8h6BKT2OMcvJJUAMGy4dF/ufyeYJEZ6UpA9acYYqj6KaEuz4U7VUIAt6cAe7sMqUPZIXlCk9HDiP1Kp8zvklHkexV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2334.namprd15.prod.outlook.com (2603:10b6:805:23::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Sun, 11 Apr
 2021 16:51:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sun, 11 Apr 2021
 16:51:52 +0000
Subject: Re: [PATCH bpf-next 1/5] selftests: set CC to clang in lib.mk if LLVM
 is set
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <20210410164930.769251-1-yhs@fb.com>
 <CA+icZUVf9RPxBHZvTaEK0scNoPkF3pf__wWCy3K=TeacgBq98g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b161ef91-8f3b-9f09-660e-69ee33982334@fb.com>
Date:   Sun, 11 Apr 2021 09:51:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUVf9RPxBHZvTaEK0scNoPkF3pf__wWCy3K=TeacgBq98g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ec9]
X-ClientProxiedBy: MW4PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:303:b9::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:ec9) by MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Sun, 11 Apr 2021 16:51:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95419611-c1e6-454a-333f-08d8fd0a1b70
X-MS-TrafficTypeDiagnostic: SN6PR15MB2334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB23345D1B6317800AAA149C8FD3719@SN6PR15MB2334.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztq15/AhWIUggHgNaPK4aCLI50mzYK0vCxV80pP6llFNi0pKQTzk6pm8wFnOhiZQjprE+q8yI5UZ16UdlfsNRvpIWdD8f9W8DyQwhiWBTnzZE7fUEULJLoByhPbPWxYhxOQQGcqwW6NxbMdYpXL5y/ozlriVoBX/DFUI+tyXfgOxTNyAwe3mT7iL1gwTcDPlITp+e3M0AMUodZkoLIMPNrDoshNZ8K2YDsjLjvo5XdHkptziBL6ij+S+h3Jy/OJqHQ2+tvmQ4MlEBklthb6+OKlHv0CXg+oAk86542jxoWPUVIpR6Y8egQezTnEQ+Hf+CGxlkD8F8p7416rYXwlOPfxPQMiAdDTylTzD7V0jsf/JbHYG2+7kEhvCtr3xkOY6hJTr/fqyzaIp2q0zoAABatJI3EPttQe4/y9O9lz9OBXnAcJ4ygry3GLGnO7kkAJOoymygcuYPdP/pEks4rHZJ7KAMEyRhsk79/E508fYH5zpU/jcw+n8FD0KPPw31UeNOEJXADn28wX29aM3Nq1tKWTdu1zYC9sIgZoI/KZJkv4aWgOVq1A8tGiPrtBShQFZz2bSoPGSIYl/KOX+5QplyhDLzIzGuifrc2eBcDChydngdDdtIO5srdMXoKO8A9Cu/Y+9nGlvB3x83b52kjyuGe3+EEr3vK7r7ks7ksloBdFpkPxa56aojJRCxm8On2vuE/L6vwq0Hz3qJePhaaedpErJc4BIaBzYsPuRFXHHFqiYFV78PJG90cTCS+Xev7pv0SvSuIN2/sWJBe9Y70kOtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(86362001)(478600001)(2906002)(8936002)(66946007)(31696002)(2616005)(6666004)(6486002)(36756003)(66476007)(4326008)(66556008)(316002)(8676002)(16526019)(186003)(53546011)(52116002)(966005)(5660300002)(54906003)(31686004)(38100700002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cnJBWmdiTjdhYVFheVdzbk5UdHd4S0N4dXRrMXNiYWN4T1diaE5RUmJXaEUz?=
 =?utf-8?B?dUN5WWhiZGZpcmk2a0M0cTBKbkVyREFocFdUVzgwQ21uWjFIVlJYM0tFcCta?=
 =?utf-8?B?cWR1Rk1KRFV2TDBKaG9QRDNCSUphYndKVDZZTWhBZjJFTVpWdDhqOVZlUnJK?=
 =?utf-8?B?OFZpQ3RPbS8rb2JBbkhGQSthaFdtRHMwTFhEdWpHSGJ1eWFhRFFnVUhZV2lq?=
 =?utf-8?B?MGdOVFNpMXRFYjFFRnhOMEZZY3VicFRLeGRpSEt5WXJyVSs4SWlVWHJJNll4?=
 =?utf-8?B?T1AzN25EZE5BWWRGVHMvOVBxNFM0bkRWMmxqZElCeU1keEVrdG96TCtINnlE?=
 =?utf-8?B?WTkzenJTTUg2a2hXL2JBYlkwRGRORzJOOThvemo0RXNZNkE2cG83SjdaQzZ2?=
 =?utf-8?B?SjJ0djR5dW5qdjVsNjFnN3lwREwvZHBETGNYYzNOaFJ6eEw0RTlpeGl5MHdI?=
 =?utf-8?B?SFFYT1NINzk2SFRvQXJEdkRYZGo1SklOSlRRU21aT0pxM0gvSTUyR2lEQ1U0?=
 =?utf-8?B?eDhSZnJYMHkvbTcwNXpuL09pdk5UM1ZxK1NDWXhLcS9iRTF2R3paSnNyVUE2?=
 =?utf-8?B?TjhiYkpObTlBc2FlNkVTSnFHL0R1VzA0SkJqUThKbDZrOWQ4MFoyNGdKOFAv?=
 =?utf-8?B?SThlWmdlMGo0Mml4eENOYnU2TWJaL1pEUGRXQjJETFpHUzR4VjJPS2pVWTF3?=
 =?utf-8?B?MjF4ZDR6aGtERmJCTUZXTUU3ZWpCdnpPM1AvOEpycmNQbnJrZmlhdUhqNjVV?=
 =?utf-8?B?VzFMTjVyKzRYN3FLWkgwVmNDQlErekV3TnpoODJvVThKckdyOWNqNDJHY2hD?=
 =?utf-8?B?azFNVzlVa0Z0dUY3R0o5YlFLa1Z6Y0pybnZTVTVseXJqQnFxcWRTQmlvbkNo?=
 =?utf-8?B?WkRlSFdGWSt6RE5rSGJlTU0wMUdpUGNLOU9ZYnpZNzFTMktPRXcxWUFoT0pE?=
 =?utf-8?B?MmlyRWtwTmMvNWg4Tm1yWFJlYUJkSENJNVEwZWF3V1J6T3R0bkF4TlZMbEh0?=
 =?utf-8?B?WFhYdWpaOTEwQmxmRlNGSVNiU3Jkd084NmYxd1VLNE5jalh2UjJ2SWpsZnFU?=
 =?utf-8?B?dUZNZERxZXY5ZU9jdTBQbjg1UVdTUDRSZVloNVRrdW5IVE5sdUxDek05R2la?=
 =?utf-8?B?SzRZaGlIOFQxUlRIMVJsQjJocUZ1VFFJOWRHS2hJUlU3Ty9IL1pCRDRVNm9Y?=
 =?utf-8?B?SVJaRm1sUHJZYXh2MUNxMmdIbUJBai9VSjNyNHdMekRwQmozYU9UVnQzQVdT?=
 =?utf-8?B?QTBMTVVaWFNqZHl2UTY3U1lEOVdZTlBRNE5UcTJoN2xQVEVqNXloL0FmSTFL?=
 =?utf-8?B?N2I1bFJaZm9pYjJvR1ZFL0liWXRWK3RjM0xxUzJqN29PUnBET2dYZ1NORWJQ?=
 =?utf-8?B?OW5BR3l6TlVCVlBjb0V4VDNXbkFoN0hXSnRaLzVSNnh3V0FuOGtGTStONW5j?=
 =?utf-8?B?TUVJQWV6b3MzdnoxbUhFdnQ3K0w2Uk9jc2llZy9CZjZpZloxUkJTZVlyZC8z?=
 =?utf-8?B?QWFpZUIrZjRpVS9mSk0zMDJwY0YyY3JjQ2ttdzM4K21KQVp3bHpYbGtBOC9B?=
 =?utf-8?B?WkhIVUlMOUdlcU5SQTlOcmpjRk9GcUVPNlFNaHFKZHFHVml2TUFlMVgvVzU2?=
 =?utf-8?B?aTN3S20veG9lMTFEbEZOeHhzTmlmbm9hL280TUxkdk1WRkU1VjBWQWs3MVFp?=
 =?utf-8?B?aE5tamY1eXVwdjRFVnJVT0U5aDlvRkJPWFlYcWY1ZDNLUkxKTVZaZFJFcEZr?=
 =?utf-8?B?Mmg1VEpEZHhORkVEZGVjQy8vRS84OWs5RlJhcGY3WDdkMERqWmhSVisyWFpZ?=
 =?utf-8?Q?QR1VZ+bSNw1AzMWnJGXJCv53+pgC7qIcTgg0k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95419611-c1e6-454a-333f-08d8fd0a1b70
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 16:51:52.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4/LLsJgCRlhPXGSsSbDtf0bLjKH3ZJy7FiIC4EYPddX5gL4mSRVF4nfeZk7aD9E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2334
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: f9WfS2GwlFROh-ijau0b6ZdcjIHh328e
X-Proofpoint-GUID: f9WfS2GwlFROh-ijau0b6ZdcjIHh328e
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_09:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 3:22 AM, Sedat Dilek wrote:
> On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> selftests/bpf/Makefile includes lib.mk. With the following command
>>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
>> some files are still compiled with gcc. This patch
>> fixed lib.mk issue which sets CC to gcc in all cases.
>>
>> Cc: Sedat Dilek <sedat.dilek@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/lib.mk | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>> index a5ce26d548e4..9a41d8bb9ff1 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -1,6 +1,10 @@
>>   # This mimics the top-level Makefile. We do it explicitly here so that this
>>   # Makefile can operate with or without the kbuild infrastructure.
>> +ifneq ($(LLVM),)
>> +CC := clang
>> +else
>>   CC := $(CROSS_COMPILE)gcc
>> +endif
>>
> 
> Why not use include "include ../../../scripts/Makefile.include" here
> and include CC and GNU or LLVM (bin)utils from there?

There is a comment above my change,

 >>   # This mimics the top-level Makefile. We do it explicitly here so 
that this
 >>   # Makefile can operate with or without the kbuild infrastructure.

It is intentionally not depending on kbuild 
(../../../scripts/Makefile.include).

> 
> Should the CC line have a $(CROSS_COMPILE) for people doing cross-compilation?
> 
> CC := $(CROSS_COMPILE)clang

The top linux/Makefile has

ifneq ($(LLVM),)
CC              = clang
LD              = ld.lld
AR              = llvm-ar
NM              = llvm-nm
OBJCOPY         = llvm-objcopy
OBJDUMP         = llvm-objdump
READELF         = llvm-readelf
STRIP           = llvm-strip
else
CC              = $(CROSS_COMPILE)gcc
LD              = $(CROSS_COMPILE)ld
AR              = $(CROSS_COMPILE)ar
NM              = $(CROSS_COMPILE)nm
OBJCOPY         = $(CROSS_COMPILE)objcopy
OBJDUMP         = $(CROSS_COMPILE)objdump
READELF         = $(CROSS_COMPILE)readelf
STRIP           = $(CROSS_COMPILE)strip
endif

There is no CROSS_COMPILE prefix for llvm.
Also see here:
   https://clang.llvm.org/docs/CrossCompilation.html
for clang, cross compilation is mostly related to
tweaking compiler options than building a different
compiler.

Hence, I didn't add $(CROSS_COMPILER) prefix.

> 
> - Sedat -
> 
> 
>>   ifeq (0,$(MAKELEVEL))
>>       ifeq ($(OUTPUT),)
>> --
>> 2.30.2
>>
