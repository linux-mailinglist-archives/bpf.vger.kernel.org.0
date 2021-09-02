Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114953FE7CE
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 04:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbhIBCt2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 22:49:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20238 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233142AbhIBCt2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 22:49:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1822iXQ8002654;
        Wed, 1 Sep 2021 19:48:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mcuK5NtoAFFkEYBCRqf0cgazdpJLVwkuj7YpR0CZYtM=;
 b=J1cIui9mgQIQ5wVkglDhIC2FmUsDprK1ncsJ2y4bPkgYuIoHR4mfGMvPfPsPygUicvLr
 kLJGmaLvQUpPEthnesqsLgd/QOb51yZdlL6+PK5HhpB9dFcxvxKnU7CG/9BDnzDjmAiJ
 J/0UKAw+UpA/5xOXWSneQVV7m7lChGSI+Iw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3atdwtxh71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Sep 2021 19:48:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 1 Sep 2021 19:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEr8E6qZOSIAGpWXoDQ0v5BXyhUCA9NliGBPQJBKRFv0Sa40oevuyRvuComTOXzp01pnDS/WD8ZMV4KNJ111FlsoE7adzGzDCZHtntIz0i7xCCQOUpqWj+NyEskxaJXpNgHG3k6kZiXr9Wgjxq16SOqbcuV426xB/6CBUZhGFmvqmKGthDUDVPeEEu0e0RFgUEJEJqOT7LYsQ1xVumSGQiFBiMs9XUh3AmHV2iESKx8rGwOHus0HecUpTvov/u/YsSJ/pSMCGj6w+9piHRiC91ueloW13JD1MoKZl+812LYIlmEeM4C6Fb+lnXQN+/EsK+fYZNOhaUHozco+eArDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mcuK5NtoAFFkEYBCRqf0cgazdpJLVwkuj7YpR0CZYtM=;
 b=kyDnp2GEEHt0pSqkn0dgsVV81D5WkKN8EdRkwvNUObm3S3sw7cpLMRiU9KDrS4E9lZ5EFo8nFe/kXJCH35uTR68x8TqwYCMJxx0bnZqr1y8vaEmPi2wUxfvzNMEZrhaAAi/vgRRqj3T9Vp3d8ntJWKnlbeiXdSEVeIw0baU0VbUlCQQKUYbnfFvbn2y+W5xDTeuxy0hPERDU3T/TUjJ9S43dADKOZBLLrtIM5KtUfYNaFhHOEc4K2uRxfL5tmpuSPaznCFfO+d/L0mlrTJZ50hfrJc8lzaD1EV56cXeIGtWwrcBEMc/z2K22cyScGmjQDslhYpmB2IMVNsNi7YoNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3760.namprd15.prod.outlook.com (2603:10b6:806:84::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 02:48:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 02:48:08 +0000
Subject: Re: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when
 parsing elf files
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
References: <20210826120953.11041-1-toke@redhat.com>
 <CAEf4BzZ7dcYrGRgOczk-mLC_VcRW3rucj3TRgkRqLgKXFHgtog@mail.gmail.com>
 <87lf4hvrgc.fsf@toke.dk>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a65e20f9-d554-761e-9a9e-8a9dfcf13919@fb.com>
Date:   Wed, 1 Sep 2021 19:48:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <87lf4hvrgc.fsf@toke.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:303:dd::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21e1::1642] (2620:10d:c090:400::5:4f44) by MW4PR03CA0328.namprd03.prod.outlook.com (2603:10b6:303:dd::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Thu, 2 Sep 2021 02:48:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60930b58-a512-4116-0b47-08d96dbc1897
X-MS-TrafficTypeDiagnostic: SA0PR15MB3760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3760AB20345366B5D1EDF925D3CE9@SA0PR15MB3760.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrsFZf4/WBmVCQuZSwPVGa/FFmsFksFjjGIen+ZBfnwEGJSqrUcqhE5Y0VSb8freumEPEtI6wxA73WnJdq3DSzNP1kkt589qiksytcR/fYPfle4Y0JyPHfEq3oy8tySciftIevQtYTb9H9bB97qZvVPbOlEpFrucwIy1c5w9nL+rZBxjvkoExcsQJI08xHFMKvKMB5YmRnvfVlVtW4MND2WAmiMEEvGCG1mnd6MSiIMDZ86D/B1jS3D2wEgiYjO5kXINtr0pmS/OpPwIvf2HNPz8ljGQjZXsSI7MaRC9zRAPc00VPOVbMKcrZHivBGWiylxbSPPsgFW+6xjhYZN21YlSWskEHql3M5ce6GjKzNDKJpVT63eYphvO3TJfnEvKD1wDE7FX52y7nSAlch6OiaEHMFPCYSU7uEXqCN5Z3Y2x4EifrPhg50cZdiWbKCbo18AIhfQvKaFN9Iy3fZs/Rtx4LWhv+ZVLbQrUXmPv1z1H42nIdQik/WOEy1ecyZWJUC9oOTXB9xSfddVvl8vzEil8n+gGRbAgaxwQkguk3LebRY16UU7MsFBXCsMh903UcoaTQ1j9t1ViOn5Xr9Y7iWqTooCfayJKgHe0rLKh05C5Ebc4ydHq9eEIZywWdNnCow171f9hjYJXfzl51lh6fBMTDpGoH26z/99HXuEzWITyGoFXTV5Ju2wQmnxr37fka/kIUyZTRGHNesbqFgmocMS0rv1l+EB8Yc21aPWwSvURMzYgLhJWxj/IewXldsXgge5dhQxu9yT0DhVDKfnePg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(38100700002)(2906002)(52116002)(186003)(478600001)(53546011)(83380400001)(66574015)(66946007)(66556008)(66476007)(54906003)(110136005)(4326008)(8936002)(2616005)(6486002)(5660300002)(6666004)(31686004)(86362001)(31696002)(316002)(36756003)(8676002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk9jS3ZkUE05akliMFd2L1gvcmk4SURVZ3VYUnZGTWJVZG1LWXFmY2taeWZh?=
 =?utf-8?B?eGhYcE5Ddjk5YzNrTzArQ2x2N1kvRlhJYWQvUW1wekdzUEN6SWhXZEMwYkNF?=
 =?utf-8?B?VXJMZko0WTFiU1FnN1U0TVd5UXRxUFJyWkt4NEFHcDVaOU1yRm1va2QxNEtC?=
 =?utf-8?B?eTVhYkFwVDM1bHVUaHhRRVpvY0VCcXl0WDJrSDVCUysxN1J2QUlEaVoxZEd3?=
 =?utf-8?B?bEtycElwa3JSVUZtQ29sUzVLWmhMY0w2ckQvOTdVMTEzcFZEUVlubVFDVmtk?=
 =?utf-8?B?Q2JWVG5tUFRCTjJkRzFnYlBQb1pUOWFVd2s0SURqOHhtQjdpR25Weno0NFVQ?=
 =?utf-8?B?R1FMVENrZ01jSUF3Y3Q4Ry9MVTFJT2YwV2ZkaXpXdGY1czlOT2FEMTNnVEkw?=
 =?utf-8?B?NHgwS0NQRGE3UnlwcHFOVmlXTGlzWlVyaTI4RjRScTNjT3ltcThQbFc4YlBY?=
 =?utf-8?B?Ym1WQ3ZNZVIxSkRnTlRpaWE3VXRXM1l4Ymt6S1ByNTRRLzQ5WmwzczJJS3BH?=
 =?utf-8?B?OFlTdDFBanJPbmVEdzkvYnI4NkV2QzNkYk1LbE1LSGFpZEorQ0FEZVpId2V2?=
 =?utf-8?B?OWhyR1hCZFFhbzRsM2tPZmlsOUlCZENRM25hWUlqUENlT1FrS256YTNLd3hp?=
 =?utf-8?B?bEhUdVVsVWhVVTkvVFJhMktEa1FoU3JScWV4bGJiNHFoZHBLejZSMFUyV3Qw?=
 =?utf-8?B?SEtzRFIvU3E4Z1ROU2xnMytadVN5b21mZjh2a1hPRGpwNnNJcFRzdytXbFZH?=
 =?utf-8?B?VSs2amdwSHk0WXhmUkFpc1ovUEU1S21YaERPbXBaYTZSV21VUk4rVEY2UllB?=
 =?utf-8?B?ZUZtWHI2NnlEZHFmVGQxUmNZeWRpaXk5K01Ua1Nqa3ZpdklQSVJJZldKdWMr?=
 =?utf-8?B?bXlXWENwUjg5MnRFcTVYdXN6TEJZZktXQm9kWFREaUFZNkZRaTd2cXVVM216?=
 =?utf-8?B?TGtJL3JzZ3hsSzR2MFU3UWdLTlduenI5elVrWm9vSjNaekdtd3NYMTl2TVYy?=
 =?utf-8?B?VFR4TUFQWVN6bTMyTGVPL3V5ZmU4bkxnbC9vb293RmxENnY4VjZTc2tJRUtw?=
 =?utf-8?B?UWZwRFIwaVNrdXJKd3VINENZa3hsSjFZOFp1Mm04Q0swb29rU2R0NEhMVW9w?=
 =?utf-8?B?QzI3MVVDR0Jzd3BNd1QrWXh1dFJodzVUdUVIdmJZRDI3QU91c3gzd2FvSDRZ?=
 =?utf-8?B?cnphOHM3RXM3R0g0V0hDZmgzRzJPZjdBcFNJYWt5eVRsdHpXQUJFZThVbUEy?=
 =?utf-8?B?MnJCMCtPVlBpTlFGZGN0SWI3Y29maW12anlSNXB6OVJGZDNxaVh3TVplQjkv?=
 =?utf-8?B?dmY4dmdIZS9yUEhPOXpSY0ZYOGJLQlFwTzROUnFrdTBmb1BVWWxWS0VDUDZB?=
 =?utf-8?B?c3VUWVVxWmhic3hnaVRuMkRQU2x5ais2L3dZQXlyMjk4TGJMdytpSVMvMjly?=
 =?utf-8?B?U2tZLy9uazlXOGF4WC9GbTh1M1hTSnM5ZlBBcEFicVRBYWR3OC9rZ3QreVkw?=
 =?utf-8?B?eUNGdmtQRVhWVVhqWHVQRTFMaGJyNFE1Z0RjclRHYmxaM3czeDk0Sld1Q1dM?=
 =?utf-8?B?YThkZm1YdnlXMktYMWxRbk16VmJvUVpLV1VkSzFrTXAxY2pQUUxBdE5WcTFS?=
 =?utf-8?B?OWlpYnJYZkFiTC9Ra0ZBajFodFdvcllUeUYvaTc4ZFcxNlV6c3Mrdis0T0N0?=
 =?utf-8?B?R1JkMFRXOE0rMnc5UHVoY3l4L3RKd3lWU3hkU1d2SkdrNmdjRmtlT2pzUmJS?=
 =?utf-8?B?VkYwN3c0S05iMmd4OEltM3pXK0ZyRzVhVTMvQ2hacmJTVTNCMmI1a0daRmpk?=
 =?utf-8?B?aHVQOEZ5R3pabzZBU3djdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60930b58-a512-4116-0b47-08d96dbc1897
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 02:48:08.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZjBLZ0Jz1HuE1VaqboYf8Max0Fhi9rrktbpsd/b1Sxz3bjjdmn5KYoT3h1WrMpA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3760
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Mxso3Y94DtxkfFtk3PNVlJ8-IhfXJcqi
X-Proofpoint-ORIG-GUID: Mxso3Y94DtxkfFtk3PNVlJ8-IhfXJcqi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_05:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/31/21 3:28 AM, Toke Høiland-Jørgensen wrote:
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> 
>> On Thu, Aug 26, 2021 at 5:10 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>
>>> When .eh_frame and .rel.eh_frame sections are present in BPF object files,
>>> libbpf produces errors like this when loading the file:
>>>
>>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .eh_frame
>>>
>>> It is possible to get rid of the .eh_frame section by adding
>>> -fno-asynchronous-unwind-tables to the compilation, but we have seen
>>> multiple examples of these sections appearing in BPF files in the wild,
>>> most recently in samples/bpf, fixed by:
>>> 5a0ae9872d5c ("bpf, samples: Add -fno-asynchronous-unwind-tables to BPF Clang invocation")
>>>
>>> While the errors are technically harmless, they look odd and confuse users.
>>
>> These warnings point out invalid set of compiler flags used for
>> compiling BPF object files, though. Which is a good thing and should
>> incentivize anyone getting those warnings to check and fix how they do
>> BPF compilation. Those .eh_frame sections shouldn't be present in BPF
>> object files at all, and that's what libbpf is trying to say.
> 
> Apart from triggering that warning, what effect does this have, though?
> The programs seem to work just fine (as evidenced by the fact that
> samples/bpf has been built this way for years, for instance)...
> 
> Also, how is a user supposed to go from that cryptic error message to
> figuring out that it has something to do with compiler flags?
> 
>> I don't know exactly in which situations that .eh_frame section is
>> added, but looking at our selftests (and now samples/bpf as well),
>> where we use -target bpf, we don't need
>> -fno-asynchronous-unwind-tables at all.
> 
> This seems to at least be compiler-dependent. We ran into this with
> bpftool as well (for the internal BPF programs it loads whenever it
> runs), which already had '-target bpf' in the Makefile. We're carrying
> an internal RHEL patch adding -fno-asynchronous-unwind-tables to the
> bpftool build to fix this...

I haven't seen an instance of .eh_frame as well with -target bpf.
Do you have a reproducible test case? I would like to investigate
what is the possible cause and whether we could do something in llvm
to prevent its generatin. Thanks!

> 
>> So instead of hiding the problem, let's use this as an opportunity to
>> fix those user's compilation flags instead.
> 
> This really doesn't seem like something that's helping anyone, it's just
> annoying and confusing users...
> 
> -Toke
> 
