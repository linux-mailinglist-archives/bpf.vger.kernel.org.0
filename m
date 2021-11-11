Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C644DC1E
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 20:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhKKTXL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 14:23:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45782 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbhKKTXK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 14:23:10 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABJFAGk017138;
        Thu, 11 Nov 2021 11:20:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dUd/3sOCX4h/NitUnztCywaJxe3FzTQEIqEVo3lM5Eo=;
 b=IRwK4M0NrnTM8YU+Zt2I+KlpnyhN7AUP48GX2hZTDFwnqDUzb5WINdprq4fn89T0Om2a
 g0AyX6c7zFzP9axHhCw4wQVgNOmADdnJoSoQtg9sHfNzzbAWfTsr81aUh8NzxhSQ6qZd
 m/VJM8y/QRPWJOL8w7ySxT879bulNFyTmUw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c98k50c1v-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 11:20:06 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 11:20:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG7ZsZxhjmZhuoLngz+at8Cg48HrvFcUUORWCLAfKnioWCq/ZDizAgm5feZPttocbz6g2qajLjRRYH1ozqtOI+NjIpDaLce2VSCl7qs6HUs9XOskdqRJ91S1K2GLw5170ZWuYm6XqN8dqfOLbQmyYktmbt/FeB9U6HlqOWB+RnSGYPHqgMD72brRHXWhLkV3JCV6sFSlPMwVYvORHoex1FOmX+4v08pY8poRbs4rwjJ9JgbseKTSqqXt3QbvtvqElE9ozGYHwQfVjCNOSsT8F6Yn5uwWK7N7T6+c+32x/OqbF3xT0CDwDU/7UjcNBK84x++DGQRmCyVxXoUgZ2VEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUd/3sOCX4h/NitUnztCywaJxe3FzTQEIqEVo3lM5Eo=;
 b=FryHZaMdq0aJniWcNkcwnaQLoRA9MvAT6PbgR6fA+ufSDaLUsKu+64UrdHJ3uusbJTObBDFwKb6MESIyN/JGBcnu/tl0AUN64QmU6KkYdvwnwetYWyq/jhbX1vL8bWYKm00Ny/8HypXJRAvOIA95lVpsIfpV3OBPKpskHpCacEiNUEjSyX0WhTgnYBXNs4F7eqAHYp2dPLiATwFulGhS90p2hbZ9zmoA5s6C7mKhQ8vD3Wd1vLoQ/nYuhGnp//E1HewkHnBWk6xahUPiFblsSRdfRkmvXUEGFz8PAGfrxFi9KDU0m6v4DyiVKv72yJEkYMsvtXQ8Ig7KJoXqxLKcgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4871.namprd15.prod.outlook.com (2603:10b6:806:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Thu, 11 Nov
 2021 19:20:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 19:20:00 +0000
Message-ID: <2d2c70e8-a365-f562-bc0b-f7b0c2bc5e64@fb.com>
Date:   Thu, 11 Nov 2021 11:19:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next 08/10] selftests/bpf: Add a C test for
 btf_type_tag
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
 <20211110052022.372373-1-yhs@fb.com>
 <CAEf4BzbaATS=A1R-rEOuwp6ZTwMLd2jXRUOykfxGHZ8qS9LJPg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzbaATS=A1R-rEOuwp6ZTwMLd2jXRUOykfxGHZ8qS9LJPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21c8::18c7] (2620:10d:c090:400::5:918d) by MW4PR03CA0007.namprd03.prod.outlook.com (2603:10b6:303:8f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Thu, 11 Nov 2021 19:19:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60fe5e98-903d-431f-26ce-08d9a5484136
X-MS-TrafficTypeDiagnostic: SA1PR15MB4871:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4871310E6F3AA72713176B47D3949@SA1PR15MB4871.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZySO+fNjiApU3jpZcVoUXLOQjVCo9sukEdYkqQ0wd0YrQ+qCQzJ7+763vQJTbuK/G3PjYUEpH0na99rxDm3x1wxnS9FRqNLEtlbHNZQ2c478G0KyQmEkk/PW7NqGIA//9edSKJJFYMDSOkI0BghGfUFke2gLHYCNRfFAQdRn/DJErY4orBLXsA5zafE64z+yfNcXdHlmnhETVOCp0w/mRQSB90geOycz5oMl18x+C9dIogkWvh+b9bvM3i+zlB9Zzupj9sfN0e1W5q5OyMDAGC23VG4Y4PTHNsHbBNAlvq0P0acngAq2r6rq9xmcU8y7bB2H4Vl4Omu5z6VoyZGU8B1OZsHH+1ppbfDjXdvNBwmqgEj6PM0vC17QBrlF8AChASt3iOGLeJoDHj/+GCIpSBNuEqL2e7mNentv8o6LVmk0rsGPvhaZh8rKfuETPVOgMGVOfhwEwpmbfv2zlxZqNEoqOPMLaTipHCYJ9BeKQO/SxJYBaIP0rvYo+r+D6gLatzKNGMXvUMNhiYhEMEmyBsVX8Xw+8SqDumguecVKfzqPN301uqlaZH//OV0x3n/sl0CWOIbXb5F9r6PSKAaU6eSrnHz9dYvCQkq2C088aOPrmgGg/ejg02mrYiYDa76xOUypCD13cP2o4VjNyajG0kLDGdGZZU8MpzC58yIgIqqo3cc08VENI2tEMbDawkLPgj1RqkXi7dDJUe00s64CWY2F6wKLRJENsswzK4zEG9ieD6u5igjllLU1RhCj4AKKmUeZU4U6+XCfRvdFnTX3laTsLkcxz+RSS3/EEqKW2EauQuZUkKwv/L1If++7TyYs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(186003)(54906003)(8676002)(86362001)(31696002)(38100700002)(66946007)(66476007)(66556008)(966005)(5660300002)(4326008)(6486002)(316002)(31686004)(8936002)(52116002)(6916009)(36756003)(2616005)(508600001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRSV1p4eFU0bXpMRytWeEVWWkE1VU5veTZSOUhmbjUxOWNyZC9XcnkxYytM?=
 =?utf-8?B?bE5rTVlWTXhmVFRHTzZuZjZVejdINTBCWHNNU3Y5VVlraUlvUWVBTS8rM2Fw?=
 =?utf-8?B?bDdUTzRpM2EwaHpuSC9VZXBQRmIzZWFqcitFa3RIRm5uMnQzN3Y4bDYyVnRC?=
 =?utf-8?B?eWUyUm53cWNZS2dRNmVmdFR2VmVoOERINW5VK0tvdC9ZV2xkK3UyVUFHTnV4?=
 =?utf-8?B?YTc0QjNSbHAyOXJsR2pVTHpHc3l3VUtkRCthSmpvbjZQMFVvdGFHcGZ3cEkr?=
 =?utf-8?B?bU8xakRWZzhJK1Q0Zy92ZVUrblR2c21IbEFkODJuTUhtVUVKaU5id3pYMmV2?=
 =?utf-8?B?ZUtiU2t6ZXd2aXZqOGxwYVNkWXJSU2k5Z2xvWmVqTUc0QUJDTEdhaWlhSnNI?=
 =?utf-8?B?cnIwUDNLS3hjVXZMOTdLWW4xN090UnpCUHhOdVltNWJkc3ZLN2NhNnp0eFhs?=
 =?utf-8?B?NzkxS3cxQ2VHcUQ4RUtGQ29WTFAycENIVmxYSG1VajVCWXp0UElTRTgwUy9K?=
 =?utf-8?B?VktyK2lBSlZwNk9aYmhONXNtOWhrZ2IrVlpnNlZnSUg5QnZmdEtvQUd5bUN2?=
 =?utf-8?B?MEF3R0ZqaHlRdmVoeFY0N0ZmYUNReUFMQ2JpL2hlRVFyaHBnZDBXOE10UE5a?=
 =?utf-8?B?NTBMRmpCVjZCY0IyOXhCMHFoNDhQMm9MbWYrYlNzUDNPTk9RN0dsN0dieTJB?=
 =?utf-8?B?R2FsZTgrT25jc2J0M3dVMWczU25wdk1xd3JEVjcxZ0daWi9QNlRBaDFtQTZw?=
 =?utf-8?B?M3FKa21SVGJpeXNMRDlEZFBSSDBPOTNubytaQUthWlVlWkl0QzR2RlJPMkVL?=
 =?utf-8?B?UjhabHkyNnorV0MweUMrS0J1RHBiODNYazllMFVNOFZzSW41anNTL2VYdUVJ?=
 =?utf-8?B?MnZFTFNzZjhPT3kvY0Y0ZDQ2aGlVbFJ2S2wxaFVrTFdlY0p6bGdHZENHbm50?=
 =?utf-8?B?cUk0Wk9hM1pweWsxaGNoYjQza0x0dlptOGpvck1ieHpyNWZPOWRySVkrcXJ2?=
 =?utf-8?B?OHFLTzJsYXJ5TVFTRnk5QXhwdlNaTXNHRjBrbXdIYlhNQWcyNEFxMXhqREtP?=
 =?utf-8?B?eWlwZ2xqR3MwdnFWMDFlVS9wS0R0bFZYNGRPUXJ6VW00TDZwZTA3b2V3L1I5?=
 =?utf-8?B?MHlNYUxKN2QwQllNTTVtRmg5a3FHQi9BcXpTMmNVNDRSbUdpOHVUWHBUYmly?=
 =?utf-8?B?bGdKZWp1dkZUQlJtSVVIQTFqYVVFb3NNOTFld0d6dHRweXVta0ZOUkpJdFpY?=
 =?utf-8?B?bkJZc2d6aW1yeUphOE5nYkZ2Nkg4QkNOUmVTS0E3RVgwckFRNGFiWFQ5RzdC?=
 =?utf-8?B?bTBKZnVvQk1UYnAxMmNSRjBhQTN0aVFhekRCRERYZDFpZ0xUMWdWQnA4dVBT?=
 =?utf-8?B?ZG1WYlF3Vk1Nbjh1NnVlaGdHMXhEV2pPRGJ2TUxXVUJ6RW1EbjJKWS9UYjcz?=
 =?utf-8?B?djUvM09TbitFSjNkbThwYWl4clZBUWhWaU55REJpZXVBbmt2WXhKVHlkSmdl?=
 =?utf-8?B?TVhsbEp6UnljSzk0QzNKZjdmWTQ1VndlZXFJSHJFbytkUjA0dFRSNVlsSG1C?=
 =?utf-8?B?dG9oWGRQUkpSSUhUMmptdjFVN1N1R3Qva05RWnlON0VaTnk5dnNuSm5obU45?=
 =?utf-8?B?dWhQZFJSTmVBUytZSmpXenVOMDRSdUpkaU4xM3UrWHhkYnIvZzYyb1RQcWVr?=
 =?utf-8?B?ZFZDN1pCUHFwV2RxQjgxckZjZ05semVHdzRYY2lKdFVWbW9NeVM0SXpxNWFW?=
 =?utf-8?B?MTdmcXBQZnN0Yks3ZUVFK3NOTk4zTittaGdKQzBKSCs2OFpkME9DZGkraStN?=
 =?utf-8?B?VHVGR2dOZmpzNTVKOGFjY1l2Wi9Ia1E1T0N0aEIyZEtzbTBZREprc3NJb1F1?=
 =?utf-8?B?dmFUZ2htWGFkYmJCUStUdU5WWHJ1NjhFdUhYVjMrZzdzUUU5dXBRYmJKZHlP?=
 =?utf-8?B?RTF2ejIxT2FKR2p6L3Z6ZWlXVlMwRTYyaGlVRDNaenpYQ3hHMmpkc0pzUVdj?=
 =?utf-8?B?U21mUFV2bHc5Wi9XdGsyaGwvdUJrckZHdGNUWHNMZ2J3K1dyVkdnZWtheS9t?=
 =?utf-8?B?UkdrWk1BNkVzTWtnSHFkcmswa2hZQjhYQ1NrMEZoT0ZCWi9WaDNUU045dnRp?=
 =?utf-8?B?VFZUa2FCVVE0WVdQSk4yaWEyWkFmR2oyLzVYb3p4UUtwbHVRZk5hU2ZLcUE2?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fe5e98-903d-431f-26ce-08d9a5484136
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 19:20:00.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+cUuwHPqXUKzBTOyXfLw6JYWlV6gaKRO2Bct9EcbTvgpv786+sCWVRx3u5X/RSf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4871
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: RXHlPh2daFwOtD0_YNegLJKwjWePJx87
X-Proofpoint-GUID: RXHlPh2daFwOtD0_YNegLJKwjWePJx87
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_07,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/11/21 10:55 AM, Andrii Nakryiko wrote:
> On Tue, Nov 9, 2021 at 9:21 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> For the C test, compiler the kernel and selftest with clang compiler
>> by adding LLVM=1 to the make command line since btf_type_tag is
>> only supported by clang compiler now.
> 
> I'm confused. Why does kernel compilation matter at all? And then for
> progs/*.c we always compile with Clang anyway (except for unused
> gcc_bpf flavor, but that's separate). So what am I missing?

This patch set is tested with additional change with
   #define __user __attribute__((btf_type_tag("user")))
plus pahole hack so I can ensure kernel implementation is
okay with vmlinux + btf_type_tag.
LLVM=1 is needed to test this.

But just for this patch set, you are right, LLVM=1 is not needed.
Will remove it.

> 
>>
>> The following is the key btf_type_tag usage:
>>    #define __tag1 __attribute__((btf_type_tag("tag1")))
>>    #define __tag2 __attribute__((btf_type_tag("tag2")))
>>    struct btf_type_tag_test {
>>         int __tag1 * __tag1 __tag2 *p;
>>    } g;
>>
>> The bpftool raw dump with related types:
>>    [4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>>    [11] STRUCT 'btf_type_tag_test' size=8 vlen=1
>>            'p' type_id=14 bits_offset=0
>>    [12] TYPE_TAG 'tag1' type_id=16
>>    [13] TYPE_TAG 'tag2' type_id=12
>>    [14] PTR '(anon)' type_id=13
>>    [15] TYPE_TAG 'tag1' type_id=4
>>    [16] PTR '(anon)' type_id=15
>>    [17] VAR 'g' type_id=11, linkage=global
>>
>> With format C dump, we have
>>    struct btf_type_tag_test {
>>          int __attribute__((btf_type_tag("tag1"))) * __attribute__((btf_type_tag("tag1"))) __attribute__((btf_type_tag("tag2"))) *p;
>>    };
>> The result C code is identical to the original definition except macro's are gone.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../selftests/bpf/prog_tests/btf_tag.c        | 24 +++++++++++++++
>>   .../selftests/bpf/progs/btf_type_tag.c        | 29 +++++++++++++++++++
>>   2 files changed, 53 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
>> index d15cc7a88182..88d63e23e35f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
>> @@ -3,6 +3,12 @@
>>   #include <test_progs.h>
>>   #include "btf_decl_tag.skel.h"
>>
>> +/* struct btf_type_tag_test is referenced in btf_type_tag.skel.h */
>> +struct btf_type_tag_test {
>> +        int **p;
>> +};
>> +#include "btf_type_tag.skel.h"
>> +
>>   static void test_btf_decl_tag(void)
>>   {
>>          struct btf_decl_tag *skel;
>> @@ -19,8 +25,26 @@ static void test_btf_decl_tag(void)
>>          btf_decl_tag__destroy(skel);
>>   }
>>
>> +static void test_btf_type_tag(void)
>> +{
>> +       struct btf_type_tag *skel;
>> +
>> +       skel = btf_type_tag__open_and_load();
>> +       if (!ASSERT_OK_PTR(skel, "btf_type_tag"))
>> +               return;
>> +
>> +       if (skel->rodata->skip_tests) {
>> +               printf("%s:SKIP: btf_type_tag attribute not supported", __func__);
>> +               test__skip();
>> +       }
>> +
>> +       btf_type_tag__destroy(skel);
>> +}
>> +
>>   void test_btf_tag(void)
>>   {
>>          if (test__start_subtest("btf_decl_tag"))
>>                  test_btf_decl_tag();
>> +       if (test__start_subtest("btf_type_tag"))
>> +               test_btf_type_tag();
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag.c b/tools/testing/selftests/bpf/progs/btf_type_tag.c
>> new file mode 100644
>> index 000000000000..0e18c777862c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/btf_type_tag.c
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2021 Facebook */
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +#ifndef __has_attribute
>> +#define __has_attribute(x) 0
>> +#endif
> 
> is this necessary, doesn't the minimum Clang/GCC version that we
> support have __has_attribute already?

No. It is not necessary. I just copy-pasted code from
https://clang.llvm.org/docs/LanguageExtensions.html#has-attribute

We recommend clang >= 11 for kernel. So above is indeed not
needed.

> 
>> +
>> +#if __has_attribute(btf_type_tag)
>> +#define __tag1 __attribute__((btf_type_tag("tag1")))
>> +#define __tag2 __attribute__((btf_type_tag("tag2")))
>> +volatile const bool skip_tests = false;
>> +#else
>> +#define __tag1
>> +#define __tag2
>> +volatile const bool skip_tests = true;
>> +#endif
>> +
>> +struct btf_type_tag_test {
>> +       int __tag1 * __tag1 __tag2 *p;
>> +} g;
>> +
>> +SEC("fentry/bpf_fentry_test1")
>> +int BPF_PROG(sub, int x)
>> +{
>> +  return 0;
>> +}
>> --
>> 2.30.2
>>
