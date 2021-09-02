Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1144F3FF6AB
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 23:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347859AbhIBV4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 17:56:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56710 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347797AbhIBV4G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 17:56:06 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182Lo52x027233;
        Thu, 2 Sep 2021 14:54:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=M/za3MaWt/aewGXSL1YIVhwIPDyKL9tfM/Gx1N9lSHo=;
 b=I5anzSU83etdUPQzmNuQisQhj7IdIvhOd8tGNrOZGi0CgR2zBeuI7SI4Pca5S4rL1Ta9
 9Sp6FYDB8x69tGrwu+9ryH+0KZ0rJRtd+FTblpK2coqxORbOI8DWX2ioTOHZpGYM0Kv5
 uFNEgavHD+qVeumNHl0jkHpH7FtfWVxGdxs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3au5khrs7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Sep 2021 14:54:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 2 Sep 2021 14:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKGUk2XQzDwKjgPM9R6iMdHj/tzdjvxTyBPN9/8jY6Rzf8xS1MUvUqS8i3T5uS3Kf9qlhASzpvmuh5NMlwcCjYo5DRfdTUiLpvBJ6TJGZCH67s9oCyxsRqXDaU74ovUac5eBnzsw66dekthmQW0EPLwuvG8rGd53pyDINAab7mP5Ai6gUfsArgjSulhiTXL5I+KJtBzhg/C7dRvHy6Db8yN4Dp1BnzLYy9lNCmTAX80KMeSa9Mm3MMBhCcRdS2VMcrq4C9iAgR4eFByMYXSh8fLYCvNL+QBAZkokrvDWQfXEsn33pzozrk8jQZm22KtS5BNGGqK35QsSi8Z/SYRu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=M/za3MaWt/aewGXSL1YIVhwIPDyKL9tfM/Gx1N9lSHo=;
 b=Oxay1/j55BDOja7PNLNLd0MoWWzub9jPfexO+SMqs0Ib0izFhnEyWN4E1oWu23+Tvq1XJUA6jm/DmQBnza21UMnJd9/VqQ5DFQI0IiEz4eyQ7TXMoy7iWFrHwesRJjUmcGgBj5gkJtQy9ViSSkDk938z3ZaXxSsOokZiYfpu5ZXY8BM8YelXbnBvUuiArkRhjMGfTXo6SJIH8dyX3mcYHNcx+qEgKGzOni8yuE6ObC4ZcvLumnsEId4xSUnB0CN/Cm42PWDBdmK28mVt6slYjV+HaHe8mltUJIovckHZrvI8MPYnKmJRpZk7JCXeTf4yyvgD44tyk8cHhBrjNSmqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4740.namprd15.prod.outlook.com (2603:10b6:806:19f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 21:54:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 21:54:50 +0000
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
References: <20210826120953.11041-1-toke@redhat.com>
 <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
 <87lf4hvrgc.fsf@toke.dk> <a65e20f9-d554-761e-9a9e-8a9dfcf13919@fb.com>
 <87wnnysy6k.fsf@toke.dk>
 <CAADnVQKYdjFR+LvnQFdKF=TJ2fSRdG7B0L+Au9KchBsV+dCr5w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <095f116b-7399-25a5-dca2-145cbd093326@fb.com>
Date:   Thu, 2 Sep 2021 14:54:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <CAADnVQKYdjFR+LvnQFdKF=TJ2fSRdG7B0L+Au9KchBsV+dCr5w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c0a8:11d1::1535] (2620:10d:c091:480::1:c086) by BL1PR13CA0165.namprd13.prod.outlook.com (2603:10b6:208:2bd::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Thu, 2 Sep 2021 21:54:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2961850-371b-4350-29ea-08d96e5c49f6
X-MS-TrafficTypeDiagnostic: SA1PR15MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4740252AE6AA07FCF3B26A3DD3CE9@SA1PR15MB4740.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fy6oVStdR+qcnQF8fcxAHkXHOpDlyP3c5bDBckvDqExg8HWTtZcSdnVaTGNDg/RdFDUb0J0byPkEW4d0h2ggLUaCFFGPEFf2X5SQBOoHHJv0gPKuoRbE1lHZSPDUxbx84MmqMo8dwNC11O+XBvFVN3KCz4Y74cLJD1F3muAnztSh4tuX1cKOFLwvjkvrLa839Gpcy6hoDzzw95PFqlvGlo4GZh2SjfSRW65YnJ3mCS83l1kPfqK2plXcAs0AQ/gYJX8ZBaOEwlzQqmOvIg/aY/fmVTWyn2ERT7d3uiY9NUmQ8tzjN9B+ayjashoX3iVUDTX9rtW4iueg3rB6/Nmvl99wX0yVTBBXiNJYVZNeAH9J+uyDG4cO4NFT3YdUxeicN+00gE9b7UGreHwksSxVakWoFTibpMvw+Kg+55rP7EAzNG7c7jeTkOQy3gLlgijxrK+rC9C1WiW1o3Cnh1exxCJgUH54GnMqW87l+YpiZ3DGHpNktrUDMwouJ93wWOr7+E4C8h51GFRWgi76gp3xHhp8hs6JEXgwS6T8z5gAOWhgtuyzilEjCIoQwty7dxJQ64QVUvAQY5+xJK5Fz3wpY+rirvLK3j3S1e2UhAZOmUWLACFCv15jKCcFn0mXgs7E6kQWnsJ2leJkCNWEwXnWYLl/2QF8U3suhJCAa8e3SKDdcNbk0pIvw1bEJnVrqprc3RaH+UO+Ev1oNASGmp+z34ut0bSUkjD1uXrE+E2kEovNE1lAMHkyq14MkFavwlN/PSDWpiIL975B4RdmccoyAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(5660300002)(31696002)(478600001)(31686004)(54906003)(4326008)(110136005)(8936002)(36756003)(38100700002)(66476007)(186003)(2906002)(66946007)(7416002)(6486002)(316002)(53546011)(66556008)(8676002)(52116002)(86362001)(66574015)(83380400001)(2616005)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTV1K3RHYXNFeHFnNHVNbmRrZENpb1EzU3pseHpBOGVkeFRVZXJHOXczcllM?=
 =?utf-8?B?dzBPVEFNbDBxTVpZSHd2OGxZU2dLV1UzTG9CZ1ZJbERqMExlWkZtNnRkd3FW?=
 =?utf-8?B?Q3lNMmpGRzdNaVdMRGpDT0RrcWdkVW9PaVZTQllzUHdvWmVTbjBOcVlCOFp0?=
 =?utf-8?B?Zm9IOU9IQmhTZ0lJUHNYNEhySjNadm1BVmswYkJkcWJwY09abXBYV2UrVG45?=
 =?utf-8?B?ZlJ6WjBNc0t0d3l6MTBSdTU5cEVhSnZIQjl5MGduMU9kNzdOTWNHc2VtdFRo?=
 =?utf-8?B?MXdCb245SERQVHZib1hHbFdiSWtFc1JlV2U0TTJSL2RuMUVsMW4vbVRXUE1Z?=
 =?utf-8?B?YjF5K3dXZ3hLY0ZJcnR5bFZVTFRaMTRITlNLN3cwVldaeHRucFlabkgwdzlU?=
 =?utf-8?B?bmxWOHdyTEdXRHF5YVdiNXRvUndvSExGSEJLTks3R1VMNTdaKzRVbGQ1Nkpu?=
 =?utf-8?B?angvb1BIOFVhK0U1ZWtoZUVGV29NTzhEV0dTYnAydGtGVGNYMThaTzJjcEdU?=
 =?utf-8?B?ZHFRUmdibjlDUUxrY21qOGJPQ0NoZUt4NTcwY0dJKytwVytoUjhVbUtodHBs?=
 =?utf-8?B?b1VCSkpYYVdjTExaOS9LNzV5WTJwZUZ5K0x1Z3J3SjZLRW5nckh4aUFPYUJ4?=
 =?utf-8?B?TXE4WHpQaWVubm9TUnZ2Skx6d2paQWdYbjVTK3ZXenhkeS9hZEIrQXA4OUdx?=
 =?utf-8?B?TkJjbFRodCtKeVpxc215VndTRUlVdml5T3A4V3ZBYmNIMzQwb2NTa2dTajk2?=
 =?utf-8?B?RGdGSVNzOG52OWxVbm5SYVJ6SnphMzdjamJPTUNCMUVwZ1dBcG53TEIyVnlE?=
 =?utf-8?B?TmE0N3pXY3B2TFp3dG5BSzdiRVBVTldBVzFIeXVnMDgxRzltR255a3hJbWNv?=
 =?utf-8?B?RTNpc2dYRlgrd2hDSjB2Y1pNVkg1U3FFK0FjbnMyc3l1T21zOC90KzdrNmIz?=
 =?utf-8?B?dU9qcS9ubGhBNmlFWjFuRjhSUUc3QzJBUlFHbkw1Zm9sUmRKZGdpZnErc01L?=
 =?utf-8?B?bEsxdW9lcllQNXpZYjg3OHFkQlU2YkQxR2lHdGw1ek5aRTF5LzZFVjI4YnNC?=
 =?utf-8?B?SldRK095UjRBNENYbTE3YVRoSTJxeTh3ZHRpM1o2bkNhNm5ZcEcveXM3YUdV?=
 =?utf-8?B?VWpQamdUbkt5WmpNbkdLOU1kTTlFNjVicDJwTGdYdm5UdXBQTWdUak1ESUh3?=
 =?utf-8?B?TjlsYnF1bkV3cHZ3RThxNExPVjdlZlU1bzZTSnhkc01NSTRVOVlVc2JHcm53?=
 =?utf-8?B?OHg2T2d3aWZUeHkweENFb2lraTUySmVqZmdUQlNONC9UNnpVNjhzSEhQbFc1?=
 =?utf-8?B?cXkvVXFoclF2QVVpRmljUjl5SDZpVHNraWcxRWw1eGRZRjRpQmt0ajdEMm9r?=
 =?utf-8?B?WWExZ01QSTFZMWJFeTdzSEVTUHhUL0JqNEtDbSs1YTlETkZBY0RiUFk5ZHpJ?=
 =?utf-8?B?Y2VOMisvMklvMkc0alF0bUhOMDhhUWNhRkFVaTlhMEdhZWU5Sk8rYS9jWGdE?=
 =?utf-8?B?RVA5Ny81dVlXek9Na2tkTmpLTm0wRUg0YjdUN0FoL25IMWJKcWdXYStNNGx2?=
 =?utf-8?B?aDV4YzAxdlZvMEN3NmU4bkQxbGlUUFZsbkxvUGY1aG9qQ1hTVTNLMWRrRlA0?=
 =?utf-8?B?ZzdlMEtPNU9RTm5BS2hTalVhejhyWG83bThkVGVUSnZKa0Q3aU0wUDY0aXNh?=
 =?utf-8?B?bExaRStEVEticFBvWHd5M1NtUkZYbHlvYzRYbW5sQS8zejhKajhHTWh1NzFF?=
 =?utf-8?B?dTQ5ZWtQZ2YwNXJFeW1SRHV0YWt6TFFFQUV2Wk95Y2M1VnNnZloyUnJlcFha?=
 =?utf-8?Q?CxPN5Z4wKrqcMbg9HCU/kSvDu82KgBnkUTu8I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2961850-371b-4350-29ea-08d96e5c49f6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 21:54:50.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tqp06Bi+Tl5XlPFLr38W+UjaYKwKbz9I7NkJzLwWmbOdBpRkdMKj2j7Y6eGrK77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4740
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: E1klnyTBZ6H2B-SxYGxogqV8w33_HiB3
X-Proofpoint-ORIG-GUID: E1klnyTBZ6H2B-SxYGxogqV8w33_HiB3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/2/21 12:32 PM, Alexei Starovoitov wrote:
> On Thu, Sep 2, 2021 at 10:08 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Yonghong Song <yhs@fb.com> writes:
>>
>>> On 8/31/21 3:28 AM, Toke Høiland-Jørgensen wrote:
>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>>>
>>>>> On Thu, Aug 26, 2021 at 5:10 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>>>
>>>>>> When .eh_frame and .rel.eh_frame sections are present in BPF object files,
>>>>>> libbpf produces errors like this when loading the file:
>>>>>>
>>>>>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>>>>>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .eh_frame
>>>>>>
>>>>>> It is possible to get rid of the .eh_frame section by adding
>>>>>> -fno-asynchronous-unwind-tables to the compilation, but we have seen
>>>>>> multiple examples of these sections appearing in BPF files in the wild,
>>>>>> most recently in samples/bpf, fixed by:
>>>>>> 5a0ae9872d5c ("bpf, samples: Add -fno-
> /to BPF Clang invocation")
>>>>>>
>>>>>> While the errors are technically harmless, they look odd and confuse users.
>>>>>
>>>>> These warnings point out invalid set of compiler flags used for
>>>>> compiling BPF object files, though. Which is a good thing and should
>>>>> incentivize anyone getting those warnings to check and fix how they do
>>>>> BPF compilation. Those .eh_frame sections shouldn't be present in BPF
>>>>> object files at all, and that's what libbpf is trying to say.
>>>>
>>>> Apart from triggering that warning, what effect does this have, though?
>>>> The programs seem to work just fine (as evidenced by the fact that
>>>> samples/bpf has been built this way for years, for instance)...
>>>>
>>>> Also, how is a user supposed to go from that cryptic error message to
>>>> figuring out that it has something to do with compiler flags?
>>>>
>>>>> I don't know exactly in which situations that .eh_frame section is
>>>>> added, but looking at our selftests (and now samples/bpf as well),
>>>>> where we use -target bpf, we don't need
>>>>> -fno-asynchronous-unwind-tables at all.
>>>>
>>>> This seems to at least be compiler-dependent. We ran into this with
>>>> bpftool as well (for the internal BPF programs it loads whenever it
>>>> runs), which already had '-target bpf' in the Makefile. We're carrying
>>>> an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
>>>> bpftool build to fix this...
>>>
>>> I haven't seen an instance of .eh_frame as well with -target bpf.
>>> Do you have a reproducible test case? I would like to investigate
>>> what is the possible cause and whether we could do something in llvm
>>> to prevent its generatin. Thanks!
>>
>> We found this in the RHEL builds of bpftool. I don't think we're doing
>> anything special, other than maybe building with a clang version that's
>> a few versions behind:
>>
>> # clang --version
>> clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+8598+a071fcd5)
>> Target: x86_64-unknown-linux-gnu
>> Thread model: posix
>> InstalledDir: /usr/bin
>>
>> So I suppose it may resolve itself once we upgrade LLVM?
> 
> That's odd. I don't think I've seen this issue even with clang 11
> (but I built it myself).

I cannot reproduce it by self with self built llvm (11, 12, 13, 14).
But I can reproduce it with an upstream built llvm12.

/bin/clang \
         -I. \
         -I/home/yhs/work/bpf-next/tools/include/uapi/ \
         -I/home/yhs/work/bpf-next/tools/lib/bpf/ \
         -I/home/yhs/work/bpf-next/tools/lib \
         -g -O2 -Wall -target bpf -c skeleton/pid_iter.bpf.c -o 
pid_iter.bpf.o && llvm-strip -g pid_iter.bpf.o
   GEN     pid_iter.skel.h
libbpf: elf: skipping unrecognized data section(11) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(11) 
.eh_frame

> If there is a fix indeed let's backport it to llvm 11. The user
> experience matters.
> It could be llvm configuration too.
> I'm guessing some build flags might influence default settings
> for unwind tables.
> 
> Yonghong, can we make bpf backend to ignore needsUnwindTableEntry ?

Sure. I will try to get upstream build flags, reproduce and fix it
in llvm.
