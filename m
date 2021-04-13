Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E483735D469
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 02:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhDMA0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 20:26:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229581AbhDMAZ7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 20:25:59 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13D0EUTO021290;
        Mon, 12 Apr 2021 17:25:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BYxJZedBl+WTermU0WcmjuVeVwWwSOcmy7zcwwoOdUo=;
 b=fGhhAmfRJ5Q6Ld5QLMaIFATD8xix6RxqqUdEjL+E6qtRDgT3yAOmVL+vniCDShxleadH
 EjTMtiBOQvkCdkhSe6i26kItmYaQBpQstTI82ZmiNVHhX8RtDNCMi01BThJMg9SRaS+t
 JDD8FrruSHxPJPGWK+g/aQy8CD1xslKl6CY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37vs1cjsec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 17:25:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 17:25:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3miuWLnHwereSu3sT3gbXYzxYrouKoZwpAv+wNzxJMVxO9yrU1AkpU2O6RSzbfNMqUQbmkQidqXrzWnEeQKm2bsLy5FCBtpftrdjWMN1G74HhVkVdOT3J6cxlIZGxjjhW0+XrFrMvNLULr0gvgMI/6fHmj6EBD7Kf8RwbUELFPLbJ9+UV0yBUspnj3PCvtChwr2zna0+AS4l+0AT71WBU4WVwSIYpnHgI6lr1TKGOTG7VGsjiyQCxxgCcuwaBOGqsr4AySjEoSMpi9Ds/J+a5VExHI55cuCrlhbfzBHqt+MhypoEs45zpnbZrqYkGVQkiXXj5SuttCpmE+mm34f+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYxJZedBl+WTermU0WcmjuVeVwWwSOcmy7zcwwoOdUo=;
 b=b2D8rk3HS6UghgvdLc06qXkzHy6ZBKfgNsVC8837aQWV8qmObp/BiFDJPUl3rI9bCAKmO789nOigj5gYyuv0exBRBH1NUzLnJj8Gq7la0sU++T9MM+VGg3Omlg2erfPlgvoG5QB0thzOHV6U3iiezSLaPu/odJFZ5g+9XnJmUXsKhJBbG1QC6nTiKPAj5KK3DUqMP96FDN0/BtzHO6g3apzS/9OSm1yo/EWV1n8t3ZJG4/ipDDnmDes7xarANBtoMf48zqsNh3fV1F9mys1khBzW2+pIWKNHcc4FHWxqjfukzw4PPMz5qikBFfxWz0pZaZiMu5W024AVI9KW0XFI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2158.namprd15.prod.outlook.com (2603:10b6:805:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 00:25:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Tue, 13 Apr 2021
 00:25:33 +0000
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Sedat Dilek <sedat.dilek@gmail.com>
References: <20210412142905.266942-1-yhs@fb.com>
 <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ffa4feb1-db9d-5305-e1c3-042f3ce26f99@fb.com>
Date:   Mon, 12 Apr 2021 17:25:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:2d37]
X-ClientProxiedBy: CO2PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:104:6::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1a0e] (2620:10d:c090:400::5:2d37) by CO2PR04CA0100.namprd04.prod.outlook.com (2603:10b6:104:6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 00:25:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7b15769-f2fb-4954-8043-08d8fe12a69f
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2158A00ED5455FFA858DAA96D34F9@SN6PR1501MB2158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cR2/7VF1UZu3bh7QYH3Tu7sZY1pxh9OFa6Sc32Ot5u1IwU5uicCXHXJa26xphDBz2rhk8RsVFsIgx13Cr2nYgRkJttp1J1TLocC1IWAo6ZX6A7X4092MDx258gRCPSg7Un6sgFWIGdQ6FTvcvZOK9WTmeolnoQ96zZMYXIviXKKwNnecdUzCNH3jFZ7uNg5IUu3QI2GoOFhiNliuT7ms2bjAXnAc1o8sQ1l7dxuD0pwStiHeXNkwEvMnk8aV/boXn64NKAuOxeNYgmn4X7clJJMEOhKfzcosrckkoea4clnMd3O9Jef9pAUBMtE5YoqYtEQf7qq6Ch746HOFZuDyrvXe2s8mKUF9IXCjVCseFC2r5z82sfrqnT20Ep+gLKRrQNaLv1ZpOw5GAeRE3M75E39/Pf6e6/PRW754ZdZbOApwrx0ZBpyvNvMOqtndbLlOU3JS7vrhNOwb2y0/1mm3CVWa2j9RCnTjQSEpj/NGLp8lzv86OWV5XI9+QA7WIMnhQJ6qvVQ0KlURTYla5T2hHr1Mig179g2rOCoPGpubCS3sZWijl+jrk4GjqH37B4NLqZyu7JjT7uJOfYK/yKxewKv2akU/HdiMD5JqEVFeaZyv8lr7xO88BDbJZ+TieKl70hPtM/c7UgBtZS+EMFOx3qUM9a2wrZ/Bq7oyWLKripYyvmCFBMMhiFP6XcgMbq5S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(136003)(366004)(5660300002)(66476007)(4326008)(66946007)(2906002)(31686004)(478600001)(186003)(16526019)(83380400001)(31696002)(86362001)(66556008)(6486002)(36756003)(8676002)(6916009)(2616005)(8936002)(38100700002)(316002)(52116002)(6666004)(54906003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bjBFb2xybEc3c3RxV0pZK01NL2dSdGZNakdwUnMwMWNXQnY1bTh3MnNQaytZ?=
 =?utf-8?B?STJrOTNnZENvQmxEaDhtU0lHanUxSjZpNDIwVjhZZXQrS1pDKy9ZeHIxalFz?=
 =?utf-8?B?cmY4RENUcnphS1FhYXoyRmxUaTZnMFhtUEtWVElUMEdFdUJnUmx1M25GcXl6?=
 =?utf-8?B?UUdNV0pLbHlZMWd2K01DMG9mWmNzSG1Va3U1K09HK0JqQkx3TXFVYXlBcm5l?=
 =?utf-8?B?UXNNbzFyWjYyMTFEcWNIWVNpRzdiK05YNlRrdDA0Y0M3UkZIbkhTTWx1VW82?=
 =?utf-8?B?MTB6aDlCSkZxUjFyeWl1NERTb3RydzVjRUJuK3dHVDNjZ2F6NmJyQkg1VmVB?=
 =?utf-8?B?Tzl4V2pGb21NaTZvemZ0K2JkYnJMbC8rNTVTT21DZ1VGNG1xZG5ROW5mSlVL?=
 =?utf-8?B?V04wdHRNbkR4eHZUNUx2aWFpY0R3bElsRDFEZVF5R1JPQkJTNit6NFlhVnhU?=
 =?utf-8?B?SXJmR3RqTnlsY1FOTjlBYUhMbmdISUoxakM1RTkwVnFTRStjL2xsQklFbWgx?=
 =?utf-8?B?L2ROWTVndVRRNVh0eXBxa0s4bkUzS0hPQnhyaGMxWTArWm5RZFlEU1IyYi9v?=
 =?utf-8?B?aGtNWWRRTHFEWFlzaHZjbzRTaWE5dVBXVjc4SjcwMzhLcFlaUFBGWTRYalVi?=
 =?utf-8?B?d3dCYWZpdzlmTTZCU0NuMmNTNCtWOCtlS09rdFBOUE5yNVEzNEUxL0Q0OGdl?=
 =?utf-8?B?elhIWkVYdmkxaS9mOWRDd25rNHlLdDhhRlFzS1hUdk1STXZmOXNwUVpHQ3ln?=
 =?utf-8?B?bHpLT0RVZTloUExrVWdWZ1ZyQ0Q0bTJXS202ZWNnLy9UTDdsdkdVNWRZVjFX?=
 =?utf-8?B?T1lkMnR4amQvRVVvS0kwYkkyZWREOVJvOG9ldVVpaDNkM0ZPS01RR0FzY0Z6?=
 =?utf-8?B?bWhVOC9KSThUN2FQeTJvcjVRR0RTdm1sL1puNFJUS2l2WHAwMnV0akh6VWFq?=
 =?utf-8?B?WENnNUc4b0wwR2tKTkRYY2ZIQnFETVlyekZxNURNRURKLzA0THFHWkQ3T3RF?=
 =?utf-8?B?WC9NdHcvZ0huUjlaWER5bjZ2TUZIM25wb2N2dlNDdzJXci9BRjA4MUJLMi9S?=
 =?utf-8?B?MTRYU3dSZitYQjZ4OTRxSVhHdFpMRFFMQmt3SHJJcjJzZmZqREhJQVNLa01l?=
 =?utf-8?B?UkpnVFpRbnBXSFlFdnhGdDF3OHlOSnh2dXViV0VYcyswQjBveDVVOU9CbU9E?=
 =?utf-8?B?NVgxcGhTemlmWmRYamNpMnFWd3N4SVd0K2FwemtodHI0SThHc00wM0V4SFJo?=
 =?utf-8?B?UHEyQ2VaR0FvM1JDei9qTkFqWHFudERRenJXTUNmeEJoWVkwVm1MbHc1Qm8w?=
 =?utf-8?B?Y24vbFY0NTZXRmY3THRqc2RFRlI1ZUoxTU9uWDV4b1FWU1NuZVFYWVJDTEl4?=
 =?utf-8?B?SHNlSi8yRGhlTmZJYmFyM2QzdGU1Y0pGdElnTmFRTFhFMEVuY2N0N3JyQmxq?=
 =?utf-8?B?c05LakVOd1YvOEhHU29wK2xMMkphZTZFQTNEOURPRUlBNk5RMU0rTVQrK1pE?=
 =?utf-8?B?Y0tyU1UyNUwzSDlWRmZHZm52NU1ZZTB3TEtGdmJ2V2J2YnEwb252dkJaa3N3?=
 =?utf-8?B?RDNvRXZ4OWhhL1JDSlRzM3hiY1pmK0krQUhWemlTVTdMOGwrbEdVUWlCdnh3?=
 =?utf-8?B?NjlUL203Ulo4RmdlRWE4TG1weGVTKzdxWE5WcGNwNllWb0Ztd3E2dXE3QzQy?=
 =?utf-8?B?WEZrYVlPQ3ZsNVJrNDRWQUVBSFpJVzFmcmpLRFF5ei9zZEJYRFg3ZE9aUHBi?=
 =?utf-8?B?ZENvempHU2VIVCtHY2IyQ2hpZktIMVhpMzlPL3JkaXY0cWtkaE5aaU1ZS2ZY?=
 =?utf-8?B?QkI1Wk02UzJ6K2FPYlVhUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b15769-f2fb-4954-8043-08d8fe12a69f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 00:25:33.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOrqtC5F534qJWfF//xPFDskvHFGQudB74tDXJg9n0Pap9LHRDxjNFl2VYa04P+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2158
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 2PxN9RtO2bmxK3x6qTauF4t0SjQ83O5v
X-Proofpoint-GUID: 2PxN9RtO2bmxK3x6qTauF4t0SjQ83O5v
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/12/21 4:58 PM, Nick Desaulniers wrote:
> On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
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
> 
> Thank you for the series Yonghong.  When I test the above command with
> your series applied, I observe:
> /usr/bin/ld: cannot find -lcap
> clang-13: error: linker command failed with exit code 1 (use -v to see
> invocation)
> 
> I need to install libcap-dev, but this also seems to imply that BFD is
> being used as the linker, not LLD.  Perhaps if the compiler is being
> used as the "driver" to also link executables, `-fuse-ld=lld` is
> needed for the compiler flags.

Yes, bfd is needed to build selftests/bpf. This is due to a dependency
on bpftool which needs uses libbfd to disassemble the jited code.

> 
> Then there's:
> tools/include/tools/libc_compat.h:11:21: error: static declaration of
> 'reallocarray' follows non-static declaration
> static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
>                      ^
> /usr/include/stdlib.h:559:14: note: previous declaration is here
> extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
>               ^
> so perhaps the detection of
> COMPAT_NEED_REALLOCARRAY/feature-reallocarray is incorrect?

libbpf already stopped to use system reallocarray(), but
bpftool still uses it.

In bpftool makefile, we have

ifeq ($(feature-reallocarray), 0)
CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
endif

I guess probably detection of feature-reallocarray is
not correct? Could you take a look at your system?
My system supports reallocarray, so the above
-DCOMPAT_NEED_REALLOCARRAY is not added to
compilation flags.

> 
> 
>>
>> But currently, using the above command, some compilations
>> still use gcc and there are also compilation errors and warnings.
>> This patch set intends to fix these issues.
>> Patch #1 and #2 fixed the issue so clang/clang++ is
>> used instead of gcc/g++. Patch #3 fixed a compilation
>> failure. Patch #4 and #5 fixed various compiler warnings.
>>
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
> 
> 
> --
> Thanks,
> ~Nick Desaulniers
> 
