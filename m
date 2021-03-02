Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D469032A463
	for <lists+bpf@lfdr.de>; Tue,  2 Mar 2021 16:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578063AbhCBKfV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 05:35:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57134 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381079AbhCBEUi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Mar 2021 23:20:38 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1224EWKa011177;
        Mon, 1 Mar 2021 20:19:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=21N4NXJ8pskilGAujn/B3XovaFKsghW6QK/J3/7crEQ=;
 b=c+kSO0mbPPUrW+oBF4/7vsCJ4b0+Du++a9BQkbtPIuOpLkiAjcbLSqnqTABZvmLjPvE5
 Oe6FiN0epRgfTkmWzKAYMR1YHIoyeTRUUzK9XvFgtXmf5jiHK0ERrHnHN8HMIqrjYlRv
 SgHj1tYTxAFlkac0gXA0bRZqtA2C1vQ6noc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36ymfx4328-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Mar 2021 20:19:44 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 20:19:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMyMl6t5xDrL0g5HfgfIoTfslUK2RhGwXc91ZokkNQMILnmLNj9Rjul3qyXDKnnjv5bOekdn1ZpmU3zyDYQKgTHkWkfuBiQ4v5iOWQbu8dx34NQOq9yVvqqY+raWQHmRi0RRaTn1w5HaBf5e/C+9aUf6pwvcVsZXDXmlUJVd8sFUupQHxxF01uWYsgJ3TG4GvexAp7EDVOXOVFu8/y3k8T3F1rWT9/kxZHL4Emr7qQwJpox53M7xn0nYj/8RT0oVDPFMvKxN5OJu3q0uvByKNFdwXr05FIEQx9aa98WYqUac9Qlf+sLVUaDOgrDsMyCmh2NwOoHHbwFaerQNdGgo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21N4NXJ8pskilGAujn/B3XovaFKsghW6QK/J3/7crEQ=;
 b=ZAtk85PHRVb4bHW+O8ddGZN6q7nPDCXJKPxKKCmtWc6fcjUvbXvA7p1NrezTWQgpf7ymh+A8idxAZ9VlISR8Ojom5qqwzyrVGhtEekIZh/szb/SLNrFoAK0EVaLUzJGGj0uzehjSvkdPg9znK7PBRabvNmxJYJQe2UQEtDrcEbV3QIjublNX3U90+hSo2WXBno/95vYUr1HXR7Nk/JOOuI20lIJRgPniS72TpglG7QoO08nwJmPjoJJjpL8lUVZzvJZgWY+qSM8qmqefa99Y2GWskl6WpjfPYMs5YWNaM1+StHD5O4fNtcwgKycpjqbQNczf7RR4H71HeDzprJYX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4062.namprd15.prod.outlook.com (2603:10b6:806:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Tue, 2 Mar
 2021 04:19:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 04:19:42 +0000
Subject: Re: Enum relocations against zero values
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <CACAyw9-XZ4XqNP1MZxC1i7+zntVAivopkgRgc4yXaNtD8QcADw@mail.gmail.com>
 <05c0e4ff-3d93-00c8-b81b-9758c90deca8@fb.com>
 <CAEf4BzZVXtVnV9aSQLaQ=7qz-3E44gvMf-abHeHKLS3S4xjChg@mail.gmail.com>
 <3a6d2ee3-4ce0-0f8b-2ab4-dad77e6da42e@fb.com>
Message-ID: <ffbd1904-ac22-7922-201d-a971c685d761@fb.com>
Date:   Mon, 1 Mar 2021 20:19:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <3a6d2ee3-4ce0-0f8b-2ab4-dad77e6da42e@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:4652]
X-ClientProxiedBy: BYAPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:a03:54::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:4652) by BYAPR02CA0044.namprd02.prod.outlook.com (2603:10b6:a03:54::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 04:19:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2682045f-1774-428b-5ee8-08d8dd32676c
X-MS-TrafficTypeDiagnostic: SA0PR15MB4062:
X-MS-Exchange-MinimumUrlDomainAge: llvm.org#6198
X-Microsoft-Antispam-PRVS: <SA0PR15MB4062E815459915C5B7EE68C8D3999@SA0PR15MB4062.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfLAoFRtseO+zgml3uUIphPUnoRAsonpROnNiDelA9Vy0YOggCPxTXhSbtjr95lVD3JEY0qIdYHip7I/DPzRxHxWTZqUBV6aNVxb/pYAnDMm6b07vrzY0pC6+w0o7z7bjEdfxJ2qT1fjGccnt1ugsbsVHeUquDjofk1qkrAMqi6ZPSRd9SFKkIPZC2lz//StSHEksDs0RGnHJWx7lMCdofyVY8VgyAeQOUuff2cPA9Ox3G2ED4aY0SKbj0qXcn9oovRWK/1k/RuCBU7BvvVvwR2Egbdo2NDZY4wVb4/Qg0gRRN4rpRF5fdKpJaxYqo4ByqH1sf5E/9BULtFaMmq5/CqXEizfxuAcfmf/xNiUQnO+3fAdR23eFQYTfaVr4aadpROkKj3lpC8H3IfMAVLvBss/c6YnG21Aodn7+6oKkC2jSzUSEFvnpopRtgoTPMDixxNEg+3Vcf2J68Au42+uotxXBVDhzS4YPGYMD3dmbopJuoxv8zqRcuqHvwjjEvrURFV13knlDRKp1GTDp0rYUcBlFxI6iDehi/APP2rBjV0s6eoj49aVu+SSD73xB0ckKqJmx68awDNAqrecx5x/ecssOokDj7cJjGHZzr6SYv4q51siVfSs9do8/RJTPJbUtYNkoL2QzvFx5wvvIpHgn4KNgGjxAPwObip3t5bQwzw2H0/Vw7CXV9B9Bvq3CwEjbpyx78GKA2XOjqH8PPgndQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(39860400002)(136003)(52116002)(16526019)(36756003)(4326008)(6486002)(53546011)(186003)(83380400001)(31686004)(5660300002)(8676002)(8936002)(478600001)(2906002)(86362001)(31696002)(2616005)(54906003)(6916009)(316002)(66946007)(66476007)(66556008)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RFUwNnJzQ1dIZ3hrWVpBYXhGVzVrSUpvYzB5eTBKOUJJaHNLTVBiOHFnNkNJ?=
 =?utf-8?B?NWladVoxSkd3VW10VWFoZVgvdUYvNk05UE5GY053c0tyMi9YNWtQUkxSQm1p?=
 =?utf-8?B?QUs2dHQyRVUyS2VibUk4ZHhNQ0lHelBBcEhwTGFONzhFb2U5VnhTMVptOXRy?=
 =?utf-8?B?VzJXd0NRMHE5R2hPamtoNWx1S0IzaWtGKzhWdWJBcXRkM3duRWIybWdzS3B4?=
 =?utf-8?B?SGsrMVl3d3YvdDNhcEphL3pqdEwwU3BQczBkZUdXWWc3Tk1NVmpyUUtBR0d2?=
 =?utf-8?B?Y0EzZC8valdaRmZlN3JDT3YyUGk4M0dWQ2ljWmVYRjFXdW9PeUI5VVBSSThL?=
 =?utf-8?B?ZjRUckJjWUhQZEJtbDZXVFpIWFAvN1J3KzQ5Vk9YeWNVc1pGY0FhcG13bDc4?=
 =?utf-8?B?a1puWFZMVTd5emIwa3VUTk1GaVJsTG55K2dvRTJlcHBaQVR2ZitxWkJ4blFX?=
 =?utf-8?B?cndpR1QreEpKZ2xtVHZQa3cxOWxuT1JOTzN6Y0ZxZzFnZ1cwdXRiS1ZCbVJz?=
 =?utf-8?B?dkhEQitHM3hZb1ZDeW0yMStLTHRpaHNXU294SG5kaWxWM3hxVk5Cc1M3ZTZ6?=
 =?utf-8?B?OERoMk5kU3IxUC85aCt4NU5pcERVTm1MSG45MWpYOElyS3EzdS9YY1gzZE5n?=
 =?utf-8?B?Y2pSVjU1R0I2aVM1UW0wTmFHamt1M09mSXdHd3JneVJRejRGRkRnaWVCTUhy?=
 =?utf-8?B?RUJReTJHUlIxWmpxVGNPTDJOMXh3WDB5NTZ2MU95U2ZGT2pkampISCtNSEhV?=
 =?utf-8?B?aHVveDczL2kyR2FBMlN4ekJ2ODMyMUhtZUJnQ05KUnZma1ViblVKelV1Mnho?=
 =?utf-8?B?Q3pYS0xvVGxkMFV6dkFoU2c0UnV1eVZtYVNSNWYvQ2Q4WVhpd0U0YWluV1pD?=
 =?utf-8?B?MHRHTnRjQ3lMRGEvVjN6MEJ2TVZCcjk5YkowVnVGSnUwUmFNbFBhM0tZNmVW?=
 =?utf-8?B?dW13UDlrTnFFZDZEZm1GKzMvMlp3b2xtZ0Iwb1FiQ29KSDBERFFzUU9WdFpK?=
 =?utf-8?B?dnNvNGZ1SktaYWkreVFTaVV4dVd2MVZZQU51c0VQejdqWWY4SnJUYU4xQ3NM?=
 =?utf-8?B?NGdIYkdINU9scU1GNUdMeEZ3Tkl6dk1pZmRFN202QUxqdEJYUzRSam5lNitr?=
 =?utf-8?B?UnlkbzNtOEhjS0RlT3NLNVZVdXg4dVJYSjRrTnBwcmEwb3BZTGRXZmU0bkVL?=
 =?utf-8?B?U3V3akd4QlVZRHJ0d1M2YVlqdXlKbjRQd3Nwc2I3WDZKLzJ5SzZndE1PbTZJ?=
 =?utf-8?B?Rm1SNDBZbkhUVzNabDFULzNxZ1FpdjdJcXhKczdraHBXT0hIQStLLzlXa3NH?=
 =?utf-8?B?NU1lMTRMdjVSdHkrRHRmYUNxbnZDN2I4N1pHU3piYkpIL0dvcWY0emgwVkt0?=
 =?utf-8?B?VFladElqMFZGdXYzVjI2RFcyZnd5M2N5Rlp2Rlg3NXcrcDJ6T3ZLUVQwZXNM?=
 =?utf-8?B?WitTQXMvNjZyRkQ0ejAycEpYNG5mUlJraFpYRENCSkFkeHdia21LdVVzVnlP?=
 =?utf-8?B?aEwyS1RBcFVjUVNrQ0ZhMjBoMk1XYk5XcEN2ZExaY0ZOTGdrWkMxVW5PL2k1?=
 =?utf-8?B?NXBNeW1pd2tIYUU3SVZGU0NZR1dSZXlIdU9IaHVHeVhwVjJuTng5UVJ4dElE?=
 =?utf-8?B?MnNtaEViMnB0Y1N0YWIxbWdHNjMrTmVlVkVHNVl1eWxRMllLejRZSGxQMVVL?=
 =?utf-8?B?dGRYcW05RnpZYzM0UXRJQWNCUk1MeTZWUDQ0VzJlVkZVZGd3VDl1VmRRLzI5?=
 =?utf-8?B?dWdiOWc3Snp5MGJrY0FMQlc1dHRaNU12YWFZOGJ3VDFSY1VieGQ0S1lNVkhy?=
 =?utf-8?Q?qbLC6V81Fnisjy5ppauZfwbutqSB+DaKKveUo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2682045f-1774-428b-5ee8-08d8dd32676c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 04:19:42.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/zg55agHogdRiuVPBPkghLansac7g+Vg9aI5VkJ7gx0Rv5X5ja41Ydk2bzbLyZ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4062
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_01:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/26/21 7:31 PM, Yonghong Song wrote:
> 
> 
> On 2/26/21 12:43 PM, Andrii Nakryiko wrote:
>> On Fri, Feb 26, 2021 at 10:08 AM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 2/26/21 9:47 AM, Lorenz Bauer wrote:
>>>> Hi Andrii and Yonghong,
>>>>
>>>> I'm playing around with enum CO-RE relocations, and hit the 
>>>> following snag:
>>>>
>>>>       enum e { TWO };
>>>>       bpf_core_enum_value_exists(enum e, TWO);
>>>>
>>>> Compiling this with clang-12
>>>> (12.0.0-++20210225092616+e0e6b1e39e7e-1~exp1~20210225083321.50) gives
>>>> me the following:
>>>>
>>>> internal/btf/testdata/relocs.c:66:2: error:
>>>> __builtin_preserve_enum_value argument 1 invalid
>>>>           enum_value_exists(enum e, TWO);
>>>>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> internal/btf/testdata/relocs.c:53:8: note: expanded from macro
>>>> 'enum_value_exists'
>>>>                   if (!bpf_core_enum_value_exists(t, v)) { \
>>>>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> internal/btf/testdata/bpf_core_read.h:168:32: note: expanded from
>>>> macro 'bpf_core_enum_value_exists'
>>>>           __builtin_preserve_enum_value(*(typeof(enum_type)
>>>> *)enum_value, BPF_ENUMVAL_EXISTS)
>>>>                                         
>>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Andrii can comment on MACRO failures.
>>
>> Yeah, I ran into this a long time ago as well...
>>
>> I don't actually know why this doesn't work for zeroes. I've tried to
>> write that macro in a bit different way, but Clang rejects it:
>>
>> __builtin_preserve_enum_value(({typeof(enum_type) ___xxx =
>> (enum_value); *(typeof(enum_type)*)&___xxx;}), BPF_ENUMVAL_EXISTS)
>>
>> And something as straightforward as
>>
>> __builtin_preserve_enum_value((typeof(enum_type))(enum_value),
>> BPF_ENUMVAL_EXISTS)
>>
>> doesn't work as well.
>>
>> Yonghong, any idea how to write such a macro to work in all cases? Or
>> why those alternatives don't work? I only get " error:
>> __builtin_preserve_enum_value argument 1 invalid" with no more
>> details, so hard to do anything about this.
> 
> This is a clang BPF bug. In certain number classification system,
> clang considers 0 as NULL and non-0 as INTEGER. I only checked
> INTEGER and hence only non-0 works. All my tests has non-zero
> enum values :-(
> 
> Will fix the issue soon. Thanks for reporting!

Just pushed the fix (https://reviews.llvm.org/D97659) to llvm trunk
this morning. Also filed a request 
(https://bugs.llvm.org/show_bug.cgi?id=49391) to backport the fix to 
12.0.1 release.
it is too late to be included in 12.0.0 release.
Thanks!

> 
>>
>>
>>>
>>>>
>>>> Changing the definition of the enum to
>>>>
>>>>       enum e { TWO = 1 }
>>>>
>>>> compiles successfully. I get the same result for any enum value that
>>>> is zero. Is this expected?
>>>
>>> IIRC, libbpf will try to do relocation against vmlinux BTF.
>>> So here, "enum e" probably does not exist in vmlinux BTF, so
>>> the builtin will return 0. You can try some enum type
>>> existing in vmlinux BTF to see what happens.
>>>
>>>>
>>>> Best
>>>> Lorenz
>>>>
