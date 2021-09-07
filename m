Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981A8402EDC
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbhIGTQs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 15:16:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39378 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230203AbhIGTQs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 15:16:48 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187JEMsW007573;
        Tue, 7 Sep 2021 12:15:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BNj5MCaKsi+7p8yit81ZeAK78jrjJqZoD6IIdJFmcvQ=;
 b=decLq8moaG4kNSF+9pZILb+bDuFd8cs8tiGZ5pDkvC6PyDjlKIpwHqkrdfJfvjR871xN
 wGpFvI/adEEaBFN1SDqdJiW14AiZRJFiHTGRpJGNlhWrHmKBNXpH7awdMD6bMCOAJyEZ
 NZc5ljeJMkeV9yN5No6Qf0gh2AltoeEgHOY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpggppt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 12:15:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 12:15:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJVVOeI+VF5a/Q6tTGbyqlXdktbSGP5SOfG/ANHRErtsbdvUvlKrAjv17Kxx7r8+CE0K+qyHqxIwT9W2V8nz1RMkbpVa8mialE6Bn9F5fTVHg9XCTBrLwDrN2PiurmC8fDMHf4cacPu2qrYFTvuk4Mu0QA1wUEWsW4/UUD0c6FWTjnvV0XwyEUgFkg7mpMZp81FbP17HeOSwe1cd5YPoT7x5/W6qi2VQImQBsuNyKlY9id2M2RKqLvjjczlM9l2d/9oUJgwXYpTZtc4C1cW6o4R7fEH62TYPCyoc9l8vCNbh/lnTdQjGS91kDNpIV8DLEGZq/9t6WDfcR9DWaHpx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BNj5MCaKsi+7p8yit81ZeAK78jrjJqZoD6IIdJFmcvQ=;
 b=hnGjLOfXdbsBCYnRt+NenozIFRFYpVU9lcloATUXPZJvErEImz4FBWm8XbWXJ2q9GFdZnqoF7TQ6GQi0fPxNALFIO0R8Yc5Cd/mZGeJxQyoU5gmOXraRDoc2I1eJASHX5bDD8owA5+vWLVdh8syHHeqon6UIlxshpJ6MPqtiE6uosEp8iu0lc7lx7SMbpoKSUI/O2IUe0eCIMblr5e0WEuZeVJBXFT2T1n3Zwc5LRgoF2Hy32y1lWHU++8ESGB1JokJtpdVd1Vabtwq0WPlpyS+Pht9+BiJgZ56tHe1Fa7jpf10KCCEsSFyzeVfJgudCByTvQeXlzAgqPZgQGUwO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3966.namprd15.prod.outlook.com (2603:10b6:806:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 19:15:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 19:15:23 +0000
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <095f116b-7399-25a5-dca2-145cbd093326@fb.com> <87czpqskac.fsf@toke.dk>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0426a8fb-ee42-cbcc-65e9-45654adf5948@fb.com>
Date:   Tue, 7 Sep 2021 12:15:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <87czpqskac.fsf@toke.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e8::18c1] (2620:10d:c090:400::5:6488) by SJ0PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:33f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 19:15:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76bec8f4-def6-44ee-e5e5-08d97233d765
X-MS-TrafficTypeDiagnostic: SA0PR15MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3966366A380CDFEE7B97F6A9D3D39@SA0PR15MB3966.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbHJK+YNKewFAAZiqWQKKU2BhISOfStAAxBUmivn+5BIyAQlZ6qFQRwCWcKYtR6s6umB2JjwqOviJMhEw9qczdollsrCaR7kbALeICgcJsY0ywUcgAdaqzqfTW5wCCYSp9HYk7J4Lw+H2rE/37cnaHlBBQTIyOiu6RVimiNy2TfXN6LiQObs+sm//K9VmH0tuC8ZqIHFD/q3iGP+PWGxWhFLzW6XAad/9Yfp8U3XB0B4znb5H7xL7yykEPiIUHK7krGtaernNnlhyQX64M5JtBFexOPqjRzkgwFFCvsgaKX+r+vpqyaHwrEJN+wV+rUEMBwzbYPn4TYJ7GB9v6XWHo7ggLIsGzTS09TGTpMYUdx8HZgQ7+rdmdHFK12hrWhx0NQaCPmd69CoYHCqRgm4XsplSRrNYApLkxu9OE7lKmxxxWUk8kBZoH46FJeJ/mLNb63pNIP6cOVCKYsgkus2dtDdX7a/ovTPTpSMilqNZTRKb/oRru+2wWKPfM6K/7Ch4OoHrkRmtnBVDSQivwtZs7JWdK+ZHjrixjhQ8iuYhbfBk8svV6euNhchABHxv8/qNp9Sp251tntU5TLO5ftUlq2tz0q2pQLxZtqp4U69cNxxPBdtIZKJim3inJsPTxPgJP0arq3ug3xu71Eh4kMGUledKOMmLNX2R0xAxJyYY1Ne4ULY/Qfie7sDa0JY2ucsG4xNtmtd9KKyAIW5L0CPRxyviJI6LDnuO2QZG/9+mzfrnfd0X3KRpUO2oii5USPiS4+v6hBBAMOhFNkkv9IXyfyI48HSg2IxAAAjfmICYtSIUmHIIRMvRE9709u+CLBBMargXxDgSAHGlxYHwEb4tWWCTGjN2m3lJiGl8+ZH5gMkenqv1anWb4M5wRxCq2nL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(2906002)(66946007)(4326008)(66476007)(52116002)(8676002)(2616005)(966005)(66556008)(110136005)(31696002)(54906003)(83380400001)(7416002)(316002)(5660300002)(36756003)(8936002)(186003)(478600001)(86362001)(53546011)(38100700002)(31686004)(66574015)(6486002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHQrMUIyQTZhZmNTK1J0SVBTVkdkMW9ZUGpTWHhKZXR5bFJvN0lXM2xuNTlk?=
 =?utf-8?B?N3Y2bTlwYTN3ZHB5NWtDM1BTdmZnckZ3aWFlcmtPUzBLZkNsTERXSHArSmgv?=
 =?utf-8?B?QjVVcmE2ZDgyeGpDOGlsMUQvT05YMklRMXZGZEhrZjlFVnFIMWp1S2F1ZnpD?=
 =?utf-8?B?Y0M1WHRFNjlMVk55U01kRnBoQWRxTWJIdFZrNGZXMDhWaFU4YmlWMGtZWHZJ?=
 =?utf-8?B?clNUdXA2blpNT0hCSzNIZTFmSWZCZzUwelIzdktnUjJhRW1EZ001Y2M1Smph?=
 =?utf-8?B?ZVk2ZzFqSUFMcktqR1ZBUW9yZXZ4UklIOGV3VUx3YWhzWmxLUWRyYjM5djRp?=
 =?utf-8?B?bmg2L3p5ck51Z0xXS0xXOTl2b0pXVVJWQXZJTDhacXBBRzhTUHVPSzNUWFk2?=
 =?utf-8?B?ZU1vQ0F2c1puTEZoRE5JM2xkRXlETkJ2UENlSDJRdGNrY21sYWtnNUpKejVt?=
 =?utf-8?B?L0hwaHJYSEhQMlduYTVuMm5kajJnSVhweHhXR0liSVpqNmdnaXdrWUtFV25L?=
 =?utf-8?B?SVJIUW1RWkdYalJJTWpseDY5YmhIUkNvd2oxSVZKQkJjM29xcWJIOStwYUly?=
 =?utf-8?B?b01KNzZ2MGx1M3ZHN2dZaSsrR3JoZktjSC85UDFVaFNTeFA1S0p1Z2JIb3Jm?=
 =?utf-8?B?cXdKWXNGUGNPSGp0NlE0THJqWnRWY0N0aWtyWnRBMllrWHc1SFd1Qm0vOWhK?=
 =?utf-8?B?cXIvcGpQNzREMmQyR0NxdjRFd3daSHFxanZka0VFa0ZGRkpCcitFWGFzZ0w4?=
 =?utf-8?B?MU9xMHZ4cHFjTWFyK05IWFhtbG94VDYwV2lCK05nekV6OEErVWMwZHNqQVZw?=
 =?utf-8?B?bkVBdjRqdlYwZk42WG5pd0RQeXBQWS8yWFJiTitlYlh0Rm8vOGpjUlV1ZjV0?=
 =?utf-8?B?OGU4TnN1N29ZNnlBZVA0d1NiNlhnUU84Y1ZhamJ6SXg2VjBqSzM1OENMRmR2?=
 =?utf-8?B?MFNZQnk2WG5scmRDd2tYcGNnKzBwWi9MNVVpUUc1NDJHL1dKREtzUkkyckdR?=
 =?utf-8?B?ZlZOa3ltMGp5aVdmcVM3cGpSSzhDVU5mOEUvWFc1bkUrby9LNjQwU01WMWtv?=
 =?utf-8?B?NkNFK3k3dHpEUjl4dElreXoyWVk1azV3ZzFJb0lWV3BQSFJITXhXcy9VU0hZ?=
 =?utf-8?B?TXQ5WFNaeDBlYWV1SUsyVE94eUdMbXRjS3VHTjFjamN1bE93WWM3TjlLaThW?=
 =?utf-8?B?L1RkaUpiL2toLy9nTkZOT1FCdzZvcDZYQUZHdnNSaHVJTHA4SlN2QVYxNnkx?=
 =?utf-8?B?a2xCTzgvMC9ZOWFNbWJjQlpENUptYzViMlpHNUk2a2pQQ1hMRmVEeHpXMERn?=
 =?utf-8?B?UEpzUzQwaWpaTFdKYXlYdzB4QmZLMXpsdWttcmg0UWZZQWtNdVlBeHlmUjVU?=
 =?utf-8?B?MFM1Ri9USzlRaFdYRjU4T1ViOEZuakhsRmhPZDZTRDNySFBDOVRCOE9zS2tM?=
 =?utf-8?B?a3JCaHNqeWVTVGJEaVpBTmI1U3pobXdVYlMwa1FNQ1ppcEYwbzROZGtXV3hB?=
 =?utf-8?B?UjNxR1JvQVNnMkFITnlUM1JyQ0E5SVE5ZTZEaU1QQVZuVzIrR0ZEdHlYL2Vu?=
 =?utf-8?B?TE8yQlVwL2RvdUFVWlE4Wk1DdEVFL1RJRmdtSnRXYnZLQm5DcGRRMk5XeXpD?=
 =?utf-8?B?OXVweitiMy9qTzVSTjY5a2s1ODJZVkNqWHJSUEEvSHpFeXR2RGxybU9jWllI?=
 =?utf-8?B?M2tqR280QWwzMGUxM3lMczc1WldaSzNtb2UzRFdtdEJvV0MwUVF1Q1ZDOVFF?=
 =?utf-8?B?NUoySkI4TWE5V3cyYnl0dEFxN3FDMENERi9KalMreVZnOTA3NzZuUDdNcWxm?=
 =?utf-8?B?QU1ZU2p0WVdWZUdJSmNGUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bec8f4-def6-44ee-e5e5-08d97233d765
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 19:15:23.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdlAOE/d3ZD+riOrx38ijPGKP8GQBmMkBtwSXqNEgwbzmrxPYSiqqUeXlABCUFJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3966
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: e_6JHGGcpK-PoTof6f5LuId4MbKbHDxl
X-Proofpoint-GUID: e_6JHGGcpK-PoTof6f5LuId4MbKbHDxl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_07:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/2/21 3:08 PM, Toke Høiland-Jørgensen wrote:
> Yonghong Song <yhs@fb.com> writes:
> 
>> On 9/2/21 12:32 PM, Alexei Starovoitov wrote:
>>> On Thu, Sep 2, 2021 at 10:08 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>
>>>> Yonghong Song <yhs@fb.com> writes:
>>>>
>>>>> On 8/31/21 3:28 AM, Toke Høiland-Jørgensen wrote:
>>>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>>>>>
>>>>>>> On Thu, Aug 26, 2021 at 5:10 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>>>>>
>>>>>>>> When .eh_frame and .rel.eh_frame sections are present in BPF object files,
>>>>>>>> libbpf produces errors like this when loading the file:
>>>>>>>>
>>>>>>>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>>>>>>>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .eh_frame
>>>>>>>>
>>>>>>>> It is possible to get rid of the .eh_frame section by adding
>>>>>>>> -fno-asynchronous-unwind-tables to the compilation, but we have seen
>>>>>>>> multiple examples of these sections appearing in BPF files in the wild,
>>>>>>>> most recently in samples/bpf, fixed by:
>>>>>>>> 5a0ae9872d5c ("bpf, samples: Add -fno-
>>> /to BPF Clang invocation")
>>>>>>>>
>>>>>>>> While the errors are technically harmless, they look odd and confuse users.
>>>>>>>
>>>>>>> These warnings point out invalid set of compiler flags used for
>>>>>>> compiling BPF object files, though. Which is a good thing and should
>>>>>>> incentivize anyone getting those warnings to check and fix how they do
>>>>>>> BPF compilation. Those .eh_frame sections shouldn't be present in BPF
>>>>>>> object files at all, and that's what libbpf is trying to say.
>>>>>>
>>>>>> Apart from triggering that warning, what effect does this have, though?
>>>>>> The programs seem to work just fine (as evidenced by the fact that
>>>>>> samples/bpf has been built this way for years, for instance)...
>>>>>>
>>>>>> Also, how is a user supposed to go from that cryptic error message to
>>>>>> figuring out that it has something to do with compiler flags?
>>>>>>
>>>>>>> I don't know exactly in which situations that .eh_frame section is
>>>>>>> added, but looking at our selftests (and now samples/bpf as well),
>>>>>>> where we use -target bpf, we don't need
>>>>>>> -fno-asynchronous-unwind-tables at all.
>>>>>>
>>>>>> This seems to at least be compiler-dependent. We ran into this with
>>>>>> bpftool as well (for the internal BPF programs it loads whenever it
>>>>>> runs), which already had '-target bpf' in the Makefile. We're carrying
>>>>>> an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
>>>>>> bpftool build to fix this...
>>>>>
>>>>> I haven't seen an instance of .eh_frame as well with -target bpf.
>>>>> Do you have a reproducible test case? I would like to investigate
>>>>> what is the possible cause and whether we could do something in llvm
>>>>> to prevent its generatin. Thanks!
>>>>
>>>> We found this in the RHEL builds of bpftool. I don't think we're doing
>>>> anything special, other than maybe building with a clang version that's
>>>> a few versions behind:
>>>>
>>>> # clang --version
>>>> clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+8598+a071fcd5)
>>>> Target: x86_64-unknown-linux-gnu
>>>> Thread model: posix
>>>> InstalledDir: /usr/bin
>>>>
>>>> So I suppose it may resolve itself once we upgrade LLVM?
>>>
>>> That's odd. I don't think I've seen this issue even with clang 11
>>> (but I built it myself).
>>
>> I cannot reproduce it by self with self built llvm (11, 12, 13, 14).
>> But I can reproduce it with an upstream built llvm12.
>>
>> /bin/clang \
>>           -I. \
>>           -I/home/yhs/work/bpf-next/tools/include/uapi/ \
>>           -I/home/yhs/work/bpf-next/tools/lib/bpf/ \
>>           -I/home/yhs/work/bpf-next/tools/lib \
>>           -g -O2 -Wall -target bpf -c skeleton/pid_iter.bpf.c -o
>> pid_iter.bpf.o && llvm-strip -g pid_iter.bpf.o
>>     GEN     pid_iter.skel.h
>> libbpf: elf: skipping unrecognized data section(11) .eh_frame
>> libbpf: elf: skipping relo section(12) .rel.eh_frame for section(11)
>> .eh_frame
> 
> Ah, that's interesting!
> 
>>> If there is a fix indeed let's backport it to llvm 11. The user
>>> experience matters.
>>> It could be llvm configuration too.
>>> I'm guessing some build flags might influence default settings
>>> for unwind tables.
>>>
>>> Yonghong, can we make bpf backend to ignore needsUnwindTableEntry ?
>>
>> Sure. I will try to get upstream build flags, reproduce and fix it
>> in llvm.

I did some investigation and this is due to centos private patch:
https://git.centos.org/rpms/clang/blob/b99d8d4a38320329e10570f308c3e2d8cf295c78/f/SOURCES/0002-PATCH-clang-Make-funwind-tables-the-default-on-all-a.patch

In upstream, the original llvm-project source is patched with
several private patches before building the rpm.
https://koji.mbox.centos.org/pkgs/packages/clang/12.0.1/1.module_el8.5.0+892+54d791e1/data/logs/x86_64/build.log

The above private patch enables unwind-table (.eh_frame section)
by default for ALL architectures and bpf is a victim of this.

I filed a redhat bugzilla bug to fix their private patch.

https://bugzilla.redhat.com/show_bug.cgi?id=2002024

Hopefully future newer compiler build won't have this issue.

> 
> Awesome, thanks for looking at this! :)
> 
> -Toke
> 
