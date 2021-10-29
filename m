Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD56943F3DB
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 02:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhJ2A1G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 20:27:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65070 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230211AbhJ2A1F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 20:27:05 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19SKV81O010861;
        Thu, 28 Oct 2021 17:24:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sWwoKVRAsROFJx8qS1JCjyJ3fm2qyzyRhRp8vk0KN/w=;
 b=ThGy362Iqf6xPWKSpW8s7pB4dB/4kGvxVgFzRfdb5nfelbEux6NIkSSK7TT8aZzFccb/
 11UJuA1ZMdYbupIq/epyPbO1VGDstJJhfoQ4Y8+Bx6yOeGi9HMXxKVzdjjIGK+N+UE9u
 idTQKnZbH1cxhfF6T/3E2lL3RlfM1rY0ROM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3byuucmyqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 17:24:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 17:23:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiaI46kteNrx739hYHYrbF4N7WXXlgS7Gmlys+EfP01CtGR329eF2rY2oW7xIJgIQOL/OPqlTflw7NHqa7fX3bZbDnxYSceqDkEFoqLgC/ZbKIS5nEazx33Gv1lJUPYVe+10nAiLDfr/ncBIrb8XVGuJUp5gMcJJFzitMBRjV407Rb3cOqjeHzR1j8m3Ky7qs2AIBa+wkd/npr/NEfiKew84Z9CoYGw0lb2trLhkjjufEtml/FK965iQFE3WV3MVWcuxoWq1fNBHsRNE+hfhtJkn/ghJ41vXKrDD5gpzaDgXIakL3pAAdS1NSw2qFx/+MUxJVFL8ESe5dVkPwN65Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF60jy3d3O1ljF3Ri+CnsANh+VgBRqjEiX+iFZ8uKfs=;
 b=bXdNsPr9TwQtCFODKxgICOS1z2tmkbTbmG7yiOi/nIC25Xt94jHF4f37Gy3Y2RTsZYP1YJnURqCWU5+W/w6ixzZJc4L9xNRG+e2RVvXcLV7ttgwwOIflDWge3wVx70s1CaYDUNGiY2+hWMiePgwiXaqXTAPbfsnoOy8br+Oy0HWCfqRH68uEbEUWk9ICnmKbGvAk/CwQQSgrbzRlsd6dZ18i6pBSzzawaMo+OiZydzAMRbMAfVgj71dAVAJfWTeO7W4wP4vHO8S/NO4ORCEn9AkKAkXihSP3jxR6Tkks1N5WIUPtiQ7U9k0mw9Q43fLG8v6NeRZVApE/3LSNYJX1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 00:23:49 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::49cf:2655:67d:7b2b%7]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 00:23:49 +0000
Message-ID: <e8b531f2-71b2-044f-93be-2a42dfb3610a@fb.com>
Date:   Thu, 28 Oct 2021 17:23:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v6 bpf-next 0/5] Implement bloom filter map
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
 <20211028221019.oinkfqhb3keuuzau@kafai-mbp.dhcp.thefacebook.com>
 <CAADnVQL8jdVfcekJ8Ch7xDJCU5nyXr-q+ZrqXY2enCb6DJPRqg@mail.gmail.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <CAADnVQL8jdVfcekJ8Ch7xDJCU5nyXr-q+ZrqXY2enCb6DJPRqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:303:b9::30) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
Received: from [IPV6:2620:10d:c085:21c8::1716] (2620:10d:c090:400::5:5753) by MW4PR03CA0235.namprd03.prod.outlook.com (2603:10b6:303:b9::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 00:23:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a5c8e0-b0e5-4aaf-b5b4-08d99a7260ce
X-MS-TrafficTypeDiagnostic: SA0PR15MB3839:
X-Microsoft-Antispam-PRVS: <SA0PR15MB38392C9B4F055D1484824666D2879@SA0PR15MB3839.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SM3FgukHOkyaPHalQbVW82s9VyQFfWysMLRZO7uvtue4zsimWehEm4PKEGrt8hELZA6HzuXW5aLfGo6+8BpmE/+0epNqcioP6ThwrHUquYf1zQXDWdjmsVkKd+LuNxBdTRHheeNmea8J7fSl6QpPx9ghvrRyMHx+dzRZbmqWp+cJrInfcHGev65RfZOTE9RKwTJsgtgFlnz+XoEZoItv18JtYq/ot48YLRpLxzUg4ZwdFmvGgSoyJbYrWTk89cy4CIzAM5NntoRAbql3ATrxsmxJx+74L0rYfJXYIE1DjlTB+BEX/wl/ghhfnRqya6gH5yDJXaK3QvTVtfkdNF/D0c6iCVUaF2JXthCGyBBtXZQjbJHmTWJwX4/VqSBkNmXIf/dsDig1+oxi2CLbWrbQkH06H/CW9ke8qiMaoCGvZn16orslPpdBVD+o6VMjOoZO2dQD08ZoS/g51SyifkNH0e6QFhEC3ym0kOP2lrBxex2nF7iE8D05t6IhN25/pBSbFiPI1mK3qgNDPdPpImVZWSIZ6Vj/oMS85auUq0Vsg4fRgCNKtzS2LCAkNJcpLHpCMTu2WykaP/zt71RKhWQWIROpOFo2SdpdvMSsf8Kb1aLI0LMwHh/lGvtMRJ8nSBHxbJsuQf025QMT2vvtrxud74fp+QlJH0SyGuFr5yU82ds0YWWz1UDuWJ4sQf6QrIIN9f5ink/3eOzr04rLOLLSgXyrUHXRJaKlJfe+kANXAcrXdNpFJ0nHAwCyklpJitHV5rXW/eyYxRZonZ/nAqfVPQO3pipGIge1ViKTH7cZHXZwsrPPLfqV94ASNrqB6X++
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(31686004)(6636002)(110136005)(5660300002)(6666004)(31696002)(6486002)(53546011)(83380400001)(86362001)(36756003)(38100700002)(54906003)(66556008)(316002)(66476007)(66946007)(186003)(2616005)(2906002)(966005)(508600001)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZSekZEeVRTN1dYOUJMSC80SzFWQU5XOVBhZ240L2FZSWVTRm44VmtoVzll?=
 =?utf-8?B?S3paYlh2Y0xBbTA0UnVGNmE4ZkdQUXlNREp6SnowY2JnZm5lb29seFVnRTVS?=
 =?utf-8?B?Y2x0Q0FWUmxCY0tQME5tdERMbGRqcTMrQzhQSGJiV2l6b3hLYTVqNVVsSjNS?=
 =?utf-8?B?VkVrVW1zSmpvRlJ2bGhSSXRvZEhVcVZ4enlYdjZyNVBuUlJja0xveTJnVGVD?=
 =?utf-8?B?OElKdVowYnl2TUZkQlRmTE83dm9XYnZYYzFvaklES2hUQTlpTTFWOWx0Q0hS?=
 =?utf-8?B?bllKa041Sm1WTG5DSnVIRmZ6L0FscU9LQVo5NHpMSnNvNFZRKy9YV28yaktU?=
 =?utf-8?B?R1pSbzBCY2xCYy9aNEhrd2o5VUlYVk9yOU80b1hKV2p0eDJ4ajMyZmpZU1JI?=
 =?utf-8?B?bmtGd3JVTWFvWjJ6SlAzcFo0cFE5OEtsRzVVdWhuYTBlcTRYbzVPV2UwcWdY?=
 =?utf-8?B?a1JNSVJ6UmpVMURXRkFuZGpSendEb09oWUNSRkplSWhtT3FBcEFIS3h3bzVZ?=
 =?utf-8?B?QkRqYjF5Tkptay8wdi9JZUxIVUlNZTZ4bU5McmNzRWJrRTF4Yi82aGk0Tzgx?=
 =?utf-8?B?Nm1MbmdpelYyMWh2MGJLOVg3ZVJUa0YzdTJNbGpVMTR3TkpqS3FlTTVlb0FC?=
 =?utf-8?B?RHYra29tSGJVS0lKMXEwSklCeGIwTnA3Wk1LdVE0VmNQcG5EaVdCRHdKaE14?=
 =?utf-8?B?TnlwZGVWL0swemNPWTJGMytUODQrOWk1dWgxK2R6MFBpUUloV015Q0grenVW?=
 =?utf-8?B?d2s4Rm5NTjhkaTZlY24yamNSN2pJT0RSdU4xck50WWs3SU1tUk9DY1ZFYmNK?=
 =?utf-8?B?Nm9CNGtyaTJNRlZFZGJJNExSTm1tK3l2U2xkV2JUR2swbi9YYUFMbjFEQWZ1?=
 =?utf-8?B?VUs2K3Y1WGZxWE1SZjl2YUwxZUtFQndZaUFUeG1qeG5hUy90OFFmYUhNUyti?=
 =?utf-8?B?UERTTjExY2RiMjNTMEZrS3Q4VHFQcFVsZmFXVUJMVkg3T093cVd6QUFKTHRY?=
 =?utf-8?B?azdTeEFUNGVEUmlMWTZJVkFJYnFaYzhoOXJ1UUJ4VlZLRU0wS1lkZktheUhB?=
 =?utf-8?B?ZE9wdkVqRWtFeElIN0QzWi9kdEZSL0hWdzdGSDhvQ0pXZGpaWjVTcEpLNk5a?=
 =?utf-8?B?Z2F5UG5sYTZqamtxRFhVb3BsdXhCSWtNUlFoc1o0b3lWK25VTkRTL2NUcjAy?=
 =?utf-8?B?NGxWUzRLS0FSTk9XenJaN1hvN3FCLzZEYUZvc3dPQitiNjd3dWxvc05DUnZW?=
 =?utf-8?B?VGF1aEZEL0RpMG9GSnpsTFhwZjZKV2FGLysyTHdHUnJkWUp6dnljaytkdW9r?=
 =?utf-8?B?YkF2U0FLbHkxUG9SN0FpWHg1bmxsa3ovbStqcXlKOW55SFp6UlZtV1lEWWE5?=
 =?utf-8?B?ZjJFRzliUTJNUDNlcWJ6dFI1bHZyTjdrdStZUGFXYkVXbEUrc201Smx2ZzhG?=
 =?utf-8?B?VjlnUktuV0h2Nkd0ZkFzSW9rb0xUNGQxYXlRMjZvK2h0dG9jQndScVZhWDZx?=
 =?utf-8?B?cy9MYUQ0SFI2YytiQmY3a2c0djBveEpZdDVjczlBZFE0YmFEeUNJTUV4V05j?=
 =?utf-8?B?WGhTb1Z0L0l5YUpSSDJUcXd6T2duLzQwTnVBVWZ5N0NrUkw2MTRvQjhNTCtM?=
 =?utf-8?B?OXRtR0ZTeitOZzZRZ3VBSmRnU2ovWDQ1RWdta2hsdTk2VVhpSjV3bVFYUnZa?=
 =?utf-8?B?RmMxbnEycEViVXlFcWY4YVpQRUZCd1lRbXVldGVSNGFZejdHVThUdmt4S3RK?=
 =?utf-8?B?UkhwNEpEYnhrV3lNa2N1NTR4MnBkTFQ0QlZHeE50T0dma2xod0xKOHNWMTdY?=
 =?utf-8?B?WkNpNFoxKzlCeG9tdU1Qa3FrdERJQnlEMXhpcGUxczg1bHI3SHVvTFAwWnh1?=
 =?utf-8?B?NjBUbThQWnA4Ni8zaFl3cUg2Uy9saU8za0xCaUNPVWNTYThuMFd6RUpCTWlX?=
 =?utf-8?B?VUlMeE5WQWM1NUlYNWpFUTNFbnc0TzBUT09oS1pPeGpnYWU2Nm5KcHVmL2dz?=
 =?utf-8?B?TWIyYlArQUNiYkRZSmMzbWNkc1lHRWtDWHBEZTR3YWJ1UEVXd2tibUhjOUZm?=
 =?utf-8?B?cWd2S0RacHZocms5eWoyS0J5bVFGOVNvSXcxbkc2eGgxSU1SL0dJNm0zS3l2?=
 =?utf-8?B?ZzZ0RFRKRWdiVDc4QmNMWWkwdDYwb2Q5cE5IOXdrY2Y5RDIzNm1tYmZzaE9Q?=
 =?utf-8?Q?ok/rZUwEnxVcFvbwIZjGiaDh1nttl5tHzZIDbo12/40s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a5c8e0-b0e5-4aaf-b5b4-08d99a7260ce
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 00:23:49.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSay35kiHDYxz6PqUsT3Ia4Gnv+uMvzNPS7shca6nmlT3vP46Ka2bF/3FvnvfR0lwM6CihoIJydu/bDcMoZHTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3839
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: hK6trB7KbVdPi2dMX-f-i2XkyMCiiB2X
X-Proofpoint-GUID: hK6trB7KbVdPi2dMX-f-i2XkyMCiiB2X
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/28/21 4:05 PM, Alexei Starovoitov wrote:

> On Thu, Oct 28, 2021 at 3:10 PM Martin KaFai Lau <kafai@fb.com> wrote:
>> On Wed, Oct 27, 2021 at 04:44:59PM -0700, Joanne Koong wrote:
>>> This patchset adds a new kind of bpf map: the bloom filter map.
>>> Bloom filters are a space-efficient probabilistic data structure
>>> used to quickly test whether an element exists in a set.
>>> For a brief overview about how bloom filters work,
>>> https://en.wikipedia.org/wiki/Bloom_filter
>>> may be helpful.
>>>
>>> One example use-case is an application leveraging a bloom filter
>>> map to determine whether a computationally expensive hashmap
>>> lookup can be avoided. If the element was not found in the bloom
>>> filter map, the hashmap lookup can be skipped.
>>>
>>> This patchset includes benchmarks for testing the performance of
>>> the bloom filter for different entry sizes and different number of
>>> hash functions used, as well as comparisons for hashmap lookups
>>> with vs. without the bloom filter.
>>>
>>> A high level overview of this patchset is as follows:
>>> 1/5 - kernel changes for adding bloom filter map
>>> 2/5 - libbpf changes for adding map_extra flags
>>> 3/5 - tests for the bloom filter map
>>> 4/5 - benchmarks for bloom filter lookup/update throughput and false positive
>>> rate
>>> 5/5 - benchmarks for how hashmap lookups perform with vs. without the bloom
>>> filter
>>>
>>> v5 -> v6:
>>> * in 1/5: remove "inline" from the hash function, add check in syscall to
>>> fail out in cases where map_extra is not 0 for non-bloom-filter maps,
>>> fix alignment matching issues, move "map_extra flags" comments to inside
>>> the bpf_attr struct, add bpf_map_info map_extra changes here, add map_extra
>>> assignment in bpf_map_get_info_by_fd, change hash value_size to u32 instead of
>>> a u64
>>> * in 2/5: remove bpf_map_info map_extra changes, remove TODO comment about
>>> extending BTF arrays to cover u64s, cast to unsigned long long for %llx when
>>> printing out map_extra flags
>>> * in 3/5: use __type(value, ...) instead of __uint(value_size, ...) for values
>>> and keys
>>> * in 4/5: fix wrong bounds for the index when iterating through random values,
>>> update commit message to include update+lookup benchmark results for 8 byte
>>> and 64-byte value sizes, remove explicit global bool initializaton to false
>>> for hashmap_use_bloom and count_false_hits variables
>> Thanks!  Only have minor comments in patch 1.  belated
>> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Thanks for the detailed review and sorry for pushing too soon.
> I forced pushed your Ack.
>
> Joanne, pls follow up with fixes for patch 1 asap, so we get it cleaned up
> before the merge window.
Should the fixes be in a new separate patchset or as v7 of this existing
patchset? Thanks.
