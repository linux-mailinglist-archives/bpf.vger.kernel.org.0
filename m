Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B3E39E10D
	for <lists+bpf@lfdr.de>; Mon,  7 Jun 2021 17:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhFGPou (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Jun 2021 11:44:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34194 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231163AbhFGPos (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Jun 2021 11:44:48 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157Fe8SX005052;
        Mon, 7 Jun 2021 08:42:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CNqh8ovP+q+4ZM4AHiSak37KrrH8GH1iR2uNRi0to/U=;
 b=Iw6pOt/AXYnUQH0XsQiz8aiYafrcck6P6MVt3DkAaSzyv1zHjoFYqfY6bemGMqk3hLur
 w8HDC1bf3y4jtrir63D1//OWxHVOoEUtcBsTsFOiB7+yqJvkQbX7YS2QyAd18Jap/1AZ
 aDYuOETGnL3elnQBs67bnMu+hDI3ipRgxR8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 391m0t0wj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Jun 2021 08:42:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 08:42:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVyz+GQdp3xNHTwuC9h22fUMDl8vKt3pNjm0DPMPztFkPZliTLgG1jJya3OB/ljq/xZExD7GU5tlj4kDgO3BqUPigEH1PeAtdv/2UvPaBTADd4zQLa7Qa+K1wXSazbemzea9tiBf/dRdRvn+Gi99rkwC6bUUitGg/pkiN8TqqjMlDj/mTal3J568xkL5XkIBIu0sFzZKRwGEk6NMlecOBjwPce+BADTNBV5DJR1GUAmVk79DDEAAWk0Q2jP/IXSl/AtFPuQjdVAX8LtYWRho2yS+8f8Fxt4IFTCDvo+TQALcxOJv7vW2n1IEWlT634z+RO1xlJkugFesIu+TQuMcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNqh8ovP+q+4ZM4AHiSak37KrrH8GH1iR2uNRi0to/U=;
 b=G6EiYBiyqxhmX4TUOyl4HHF+SjwldSNjm6xv1IFjEHECGzrIw2KrTg8zdoXWyj0MCh40NNbP3eePRHyeHL7K9/Cwkzi//afht6rmWONuFGLb8M8Vru8o+GKJFfOGfEPyIdojMd/1S+jxCtQbuLrIN86OYcBlrwnf5c6EGbB6CeC99ctbBKsRwU2Hsb1Mta2c9U1S/gKMRqefvahCT/9ZTHkA+crJnWP80oMHDSdYBAT3LScBXgeChBvHmGVs0MyqmIr/z6P7YQ5hV/LJPCqNnA+nMOZzNvS8GAe3UkR8g1viezmw6egzkxBKYbiMpoiHXMr4zy73faaFkjP2IWy7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4062.namprd15.prod.outlook.com (2603:10b6:806:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 15:42:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 15:42:52 +0000
Subject: Re: Parallelizing vmlinux BTF encoding. was Re: [RFT] Testing 1.22
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YK+41f972j25Z1QQ@kernel.org>
 <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
 <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
 <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org>
 <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
 <YLjtwB+nGYvcCfgC@kernel.org>
 <CAEf4BzbQ9w2smTMK5uwGGjyZ_mjDy-TGxd6m8tiDd3T_nJ7khQ@mail.gmail.com>
 <YL4dGFsfb0ZzgxlR@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c5a2c9fc-e541-7a0d-daa8-5af802f8336d@fb.com>
Date:   Mon, 7 Jun 2021 08:42:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YL4dGFsfb0ZzgxlR@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:db22]
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1097] (2620:10d:c090:400::5:db22) by SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Mon, 7 Jun 2021 15:42:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee683968-73d6-406e-f677-08d929cae91f
X-MS-TrafficTypeDiagnostic: SA0PR15MB4062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB4062BA4A0361D1A2C5A302F8D3389@SA0PR15MB4062.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UgMzg7m0bE/cXvnw2OB8PAYq/IwA3ysLohyYEFDDhlqDJQR/SFTfd9jxCruwLtd9EP9OpG6S+KbpS6YKINSw5HeeKFI94gtHiNJtKlueuQ20LWjAHyhmpb6G0C97piPmBgMkrr8VFMpg95/rknZkOzTyrxNoW6NrXB0k5C/p3lzXlOO1Y1AeCXjvfeuoKtJKZP6WiONRIezFyaJuKOWIas7XEPlcPndOIai579EKG4P+hIRhDGbdZTnv475EpXy9g3cusHUQKN6Fdkw8S8LIGoUqjBPcKhQCTgRjyAqoTtK0qB+ZG90KdeVy4Rl+xLGqiHkxXqYRQEMlmbcNtDGKwQwR57OaOhS70KIZ7LTi5pCQErCAp5aseaulFwxdnMh9oAQpt4QHZlB2BcCZQ4ACQI5MQAt8NDsthVvq6ExNVX/HJPnuIpFw/eKCHFJRurXAZK4rw/58wj0ePNjQL4GoBcGmi4T9+esNGr6MBMW2kbmm7fX3DDLMaM7rF9BmHw15rlyYNKFCsf/NQa3XGvYr0rtHEe2CQG8r7EkXSIAmw7X0XB6OhCna3dZ9uD9BMuIyxlRyhVm0D7o8/1sNYpXFWMkiWAqEdGnZvW9OO/kE+6JvifK51R+y/t//YJXRuuJ9XrYyEYtcgWc27pIt5C9zLxCul4BCmePiJAgq4d3sFWkIbHi9EK0AI4ZAEXywZPY+h7LiHI9qlXkcE8DXon4+02X9riJOp4bUihQXKE4KTnIlUPg5px+3MOuCohJUCoHUAVex4wlcgNstb9fAda/K7hNzSPCazsu5n57fY9mNL0XYvat/7UieaAsHM+HVIJ8n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(8676002)(8936002)(966005)(478600001)(6486002)(38100700002)(5660300002)(2616005)(186003)(31686004)(316002)(66476007)(86362001)(36756003)(31696002)(52116002)(110136005)(53546011)(66946007)(54906003)(6666004)(66556008)(16526019)(4326008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDQvcnJBRTFtdWdUeDVQVzB6RnBkeUdJVjlOYVdoeDN3bDNJQi9KWThnUG9T?=
 =?utf-8?B?Mys5QTNwVEd1dnBVYlJZbCs1SytKNDI1TGxVWnQvSHZRWDNxRWMvK3RTTEJS?=
 =?utf-8?B?Z1BwWnlTbDNOajZUZnJBRzNTc3gzdFlSQ1pYSnJ4YWJwS05rdmRkY1lNdjJK?=
 =?utf-8?B?NU5xaElzWHhkaHRnMVhhbnNlSUZWMmNXS3huTU8zOWdEWU0wR3cwcXpPT0xF?=
 =?utf-8?B?ZUl4eTRsV2hOVnFCdldBbEdiYytzZEtjaUhLV0dTTHVRYUVDeGVCNDVRMVVy?=
 =?utf-8?B?UGhSZ3FLdlR3Q25KZFBlZC85bUZXVFUzUmZWVkhaMkZGQ21CaU1Jcis4Vmsx?=
 =?utf-8?B?cWJ1V3ppOFBhRnl5MXE0SlNsenoxbEtWbTRRWGtCYlNBMHNJYUxzTGQ0Y0V5?=
 =?utf-8?B?c2xZdCswd3Y2SjZCemdVL1pkN3FtY0h5WFplR08zUk1zbUJZTFJ1akpObjRO?=
 =?utf-8?B?Q0FxUkhrTUZtUDBoSzlmLzc5VGtYY0JSaThPSGtZRmVCdVdPSmRZREJyTC9y?=
 =?utf-8?B?d2IrNHA1eHMrKy9iLzltaEtXMVBlUkxITHoxVmVheVVyVkdlalUvNmdRN3hS?=
 =?utf-8?B?WTd2ZUUwRVBKWXJQekhlRE1QUzlkcnArRXY3N0JTU3MvOW9NWE82cDgyRkM3?=
 =?utf-8?B?cWRGeVZ0bGF3ZG9keUl5WFJ4K3lZMWZuZkdOcDh1WlhpMkNZeUVpcmJvOWdW?=
 =?utf-8?B?RWZNWUh2YkxoZ01EalR2aGhRZ1Bvcm5qZmhuZmNlbGVYWncwUUsxMFJBemhP?=
 =?utf-8?B?WGlOU3NuUDVsVHJ6S05DS1QzUU9JQk1Sc2ZremFmZXFJYjBZaWJWd3FFcXhE?=
 =?utf-8?B?emVoejIxVmdqTmxPVVVVdFRVOEJra0pWbWlEbGRUNmo2WlFCbFBFMW4wQ29W?=
 =?utf-8?B?MnFMWUs4eEJNZGxadTI0Z2czYnpDakNYWFNIMk0vby9ZRjdIVTJKTlpVck9j?=
 =?utf-8?B?NHNUY0dERlY0UWo2TUlxdmNyREIzWU1VSlN2b2JDMDQ3MUNqOUVkbEI5N2JD?=
 =?utf-8?B?c2tndHJRN3ozL0hwMHl5U3JTcHczaGhQa05GWmJaNURFdDZOSUtqc0JKdTBN?=
 =?utf-8?B?c21aK2x3azQ1RjhOU0JlL0E1RU9MTHlxL1pIbXNOVGhTbHk5Vk5ZcnYyOGFt?=
 =?utf-8?B?TkUvaFdWV1VZYWQ4TElrL1dYYU9tdVJ5WHdIS0NBMlBUUXRRWmYrcUdjTG4w?=
 =?utf-8?B?ejZOUGVuZDcvc25qUnlvRHd4VmlkMFhWckg3VTErZnpIYUZxM3dDU3lJVEtp?=
 =?utf-8?B?RW5ZNDFPaE80U3JyamR2WWsxTWNxL1MzNUljU0t3T1dEcDlsaDMybEZnQmk0?=
 =?utf-8?B?aDUwVHNYMldzdTl3VHlaNjJUMlZnaGppeStSUnhRUmpaUkRnSXhyY1JTN0tr?=
 =?utf-8?B?cERZcnErcEd3SDlZeTczWC9xOW5mYTYySW1TVWhzam9BR1JGM1F0WkliYlZy?=
 =?utf-8?B?b1c1Q0FPNS82b1ZhVjh3WlV0MnBZaXYyWnR1bjh2Y05HUUxUSUkxTXhzK3ls?=
 =?utf-8?B?cVdlSmVaUStKNXBrdENTV2xyVmk1NlNrZE1NUEhsaEpPUzBiaFhXOXBsdE95?=
 =?utf-8?B?NUcxZjRmZE8zKzk2TnpDcnZiUndSY0J4Rm9BZGovMU1XZWdxQkhOQWcxS1FQ?=
 =?utf-8?B?alBUR01YM29YWExFY3AvMW0ySXpuTHM3TmwwVjAvekl0VEsyUyttS0dDYk9I?=
 =?utf-8?B?MTUzTjBxYUlWTVlHdXp6c1E5N21LTTZZM0VWeTU1bzdZdGlvWVFYSXloM0pu?=
 =?utf-8?B?TDJVMzRXKy9jOGl1S05mUlVRelhPeWQxcTlwRGt6Y1dLUU9EenJwZXorQUlV?=
 =?utf-8?Q?HndWGxrdrETRHcRGFcGWhdiQYYxIQZN00ykrI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee683968-73d6-406e-f677-08d929cae91f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 15:42:52.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOiIiHisMZ9STaTAEvxuRv2S7R3WvskSho8JCzIKWtMD9RaFQ8nSwno4huENwnWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4062
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 85P7_kdIpVRw9AsvV7T8lA-zAFYwQeEK
X-Proofpoint-ORIG-GUID: 85P7_kdIpVRw9AsvV7T8lA-zAFYwQeEK
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_11:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/7/21 6:20 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 04, 2021 at 07:55:17PM -0700, Andrii Nakryiko escreveu:
>> On Thu, Jun 3, 2021 at 7:57 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>> Em Sat, May 29, 2021 at 05:40:17PM -0700, Andrii Nakryiko escreveu:
> 
>>>> At some point it probably would make sense to formalize
>>>> "btf_encoder" as a struct with its own state instead of passing in
>>>> multiple variables. It would probably also
> 
>>> Take a look at the tmp.master branch at:
> 
>>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=tmp.master
>   
>> Oh wow, that's a lot of commits! :) Great that you decided to do this
>> refactoring, thanks!
>   
>>> that btf_elf class isn't used anymore by btf_loader, that uses only
>>> libbpf's APIs, and now we have a btf_encoder class with all the globals,
>>> etc, more baby steps are needed to finally ditch btf_elf altogether and
>>> move on to the parallelization.
>   
>> So do you plan to try to parallelize as a next step? I'm pretty
> 
> So, I haven't looked at details but what I thought would be interesting
> to investigate is to see if we can piggyback DWARF generation with BTF
> one, i.e. when we generate a .o file with -g we encode the DWARF info,
> so, right after this, we could call pahole as-is and encode BTF, then,
> when vmlinux is linked, we would do the dedup.
> 
> I.e. when generating ../build/v5.13.0-rc4+/kernel/fork.o, that comes
> with:
> 
> ⬢[acme@toolbox perf]$ readelf -SW ../build/v5.13.0-rc4+/kernel/fork.o | grep debug
>    [78] .debug_info       PROGBITS        0000000000000000 00daec 032968 00      0   0  1
>    [79] .rela.debug_info  RELA            0000000000000000 040458 053b68 18   I 95  78  8
>    [80] .debug_abbrev     PROGBITS        0000000000000000 093fc0 0012e9 00      0   0  1
>    [81] .debug_loclists   PROGBITS        0000000000000000 0952a9 00aa43 00      0   0  1
>    [82] .rela.debug_loclists RELA         0000000000000000 09fcf0 009d98 18   I 95  81  8
>    [83] .debug_aranges    PROGBITS        0000000000000000 0a9a88 000080 00      0   0  1
>    [84] .rela.debug_aranges RELA          0000000000000000 0a9b08 0000a8 18   I 95  83  8
>    [85] .debug_rnglists   PROGBITS        0000000000000000 0a9bb0 001509 00      0   0  1
>    [86] .rela.debug_rnglists RELA         0000000000000000 0ab0c0 001bc0 18   I 95  85  8
>    [87] .debug_line       PROGBITS        0000000000000000 0acc80 0086b7 00      0   0  1
>    [88] .rela.debug_line  RELA            0000000000000000 0b5338 002550 18   I 95  87  8
>    [89] .debug_str        PROGBITS        0000000000000000 0b7888 0177ad 01  MS  0   0  1
>    [90] .debug_line_str   PROGBITS        0000000000000000 0cf035 001308 01  MS  0   0  1
>    [93] .debug_frame      PROGBITS        0000000000000000 0d0370 000e38 00      0   0  8
>    [94] .rela.debug_frame RELA            0000000000000000 0d11a8 000e70 18   I 95  93  8
> ⬢[acme@toolbox perf]$
> 
> We would do:
> 
> ⬢[acme@toolbox perf]$ pahole -J ../build/v5.13.0-rc4+/kernel/fork.o
> ⬢[acme@toolbox perf]$
> 
> Which would get us to have:
> 
> ⬢[acme@toolbox perf]$ readelf -SW ../build/v5.13.0-rc4+/kernel/fork.o | grep BTF
>    [103] .BTF              PROGBITS        0000000000000000 0db658 030550 00      0   0  1
> ⬢[acme@toolbox perf]
> 
> ⬢[acme@toolbox perf]$ pahole -F btf -C hlist_node ../build/v5.13.0-rc4+/kernel/fork.o
> struct hlist_node {
> 	struct hlist_node *        next;                 /*     0     8 */
> 	struct hlist_node * *      pprev;                /*     8     8 */
> 
> 	/* size: 16, cachelines: 1, members: 2 */
> 	/* last cacheline: 16 bytes */
> };
> ⬢[acme@toolbox perf]$
> 
> So, a 'pahole --dedup_btf vmlinux' would just go on looking at:
> 
> ⬢[acme@toolbox perf]$ readelf -wi ../build/v5.13.0-rc4+/vmlinux | grep -A10 DW_TAG_compile_unit | grep -w DW_AT_name | grep fork
>      <f220eb>   DW_AT_name        : (indirect line string, offset: 0x62e7): /var/home/acme/git/linux/kernel/fork.c
> 
> To go there and go on extracting those ELF sections to combine and
> dedup.
> 
> This combine thing could be done even by the linker, I think, when all
> the DWARF data in the .o file are combined into vmlinux, we could do it
> for the .BTF sections as well, that way would be even more elegant, I

The linker will do the combine. It should just concatenate
all .BTF sections together like
    .BTF section
       .BTF data from file 1
       .BTF data from file 2
       ...

> think. Then, the combined vmlinux .BTF section would be read and fed in
> one go to libbtf's dedup arg.

I think this should work based on today's implementation but we do have
a caveat here.

The issue is related to DATASEC's. In DATASEC, we tried to encode
section offset for variables. These section offset should be
relocated during linking stage. But currently pahole does not
generate reloations for such variables so linker will ignore
them.

This shouldn't be an issue for global variables as we can find its
name in VAR and look up final symbol table for its section offset.

But this might be an issue for static variables with the same
name and just matching names in VAR is not enough as their
may be multiple ones in the symbol table. We could have a
workaround though, e.g., rename all static variables with a unique name
like <file_name>.[<func_name>.]<var_name> and went to dwarf
to find this static variable offset. dwarf should have
static variable section offset properly relocated.

Another solution is for pahole to generate .rel.BTF which
encodes relocations.

Currently, we don't emit static variables in vmlinux BTF (only
percpu globals), but not sure whether in the future we still
won't.

> 
> This way the encoding of BTF would be as paralellized as the kernel build
> process, following the same logic (-j NR_PROCESSORS).
> 
> wdyt?
> 
> If this isn't the case, we can process vmlinux as is today and go on
> creating N threads and feeding each with a DW_TAG_compile_unit
> "container", i.e. each thread would consume all the tags below each
> DW_TAG_compile_unit and produce a foo.BTF file that in the end would be
> combined and deduped by libbpf.
> 
> Doing it as my first sketch above would take advantage of locality of
> reference, i.e. the DWARF data would be freshly produced and in the
> cache hierarchy when we first encode BTF, later, when doing the
> combine+dedup we wouldn't be touching the more voluminous DWARF data.
> 
> - Arnaldo
> 
>> confident about BTF encoding part: dump each CU into its own BTF, use
>> btf__add_type() to merge multiple BTFs together. Just need to re-map
>> IDs (libbpf internally has API to visit each field that contains
>> type_id, it's well-defined enough to expose that as a public API, if
>> necessary). Then final btf_dedup().
>   
>> But the DWARF loading and parsing part is almost a black box to me, so
>> I'm not sure how much work it would involve.
> 
>>> I'm doing 'pahole -J vmlinux && btfdiff' after each cset and doing it
>>> very piecemeal as I'm doing will help bisecting any subtle bug this may
>>> introduce.
> 
>>>> allow to parallelize BTF generation, where each CU would proceed in
>>>> parallel generating local BTF, and then the final pass would merge and
>>>> dedup BTFs. Currently reading and processing DWARF is the slowest part
>>>> of the DWARF-to-BTF conversion, parallelization and maybe some other
>>>> optimization seems like the only way to speed the process up.
> 
>>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>>> Thanks!
