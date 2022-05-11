Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A887F523CEE
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346490AbiEKS4d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346489AbiEKS4c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 14:56:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA1246B1D
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 11:56:30 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BFoZC3025954;
        Wed, 11 May 2022 11:56:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cKJIYrw8hFrug/uAvfqUPIZyZvXSX9WhNZB9drU4Tgg=;
 b=SGNs6+yFP1e0UiInGAU3aukFgov+Lq503ScenQ7QX84CJd7KNgCY5NAu5EIwf1DwdilV
 Af839CA/dkLn+2YdNhfk7UpUqYg3JDPjmaNMqHFajzFOzrKH59tgInbXeqb4nplc9wc/
 e7zQK/iEkGuGh2vUNvLWnY8h19ASDRRQPBA= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g04tb5387-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 11:56:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzneQUyDEhoIZvgvJJr5vsR37vZywNkOTyfKaSwDIj22tmYpbv8GBh9Zhx4iyb3gxCNK5EAz5EyFjCdmuBgYD1fzrLgZIVJ/fLGcmw7y2rFnu3VlYfj2Zc+SUMivQ+JQRoy5bTRaMjo1uj8QiCQA3jXfIXsZdOy/DIzJvvtFYxo/QNrXte6EpD26wlLdwZMXzOnUBOe8+O926gjpe159sfFHbrZYKqPbJ1OESUF3M9siFjbIJ1MdAVTjS/expk3gQ4V7RFVr/zYIy+rhF0Td+u1HF1QEbOxFRCjpseUW66Zks5sf81U0LFJi85p9n3m/T3jADw6oaxq4BlF7KgI4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKJIYrw8hFrug/uAvfqUPIZyZvXSX9WhNZB9drU4Tgg=;
 b=DF3IkxHHdMHYnGayzjhuI3FQIJ2yCtgAHRsj1yTXe9Rqd86a9jrbK+cVIONOJu+N64IMQUVvpBt8s1NUb8MDpjSTdPWI5Ynp2e46IyXUKhbtw8wOrPgpm/7fxwDxLU9tXhEH73LwMF8V8b37rZZ5KinLTwu7wpf0na1CLC0Nuqg3MfQFb/nunbBCHZNHIYIcAzkY4QyowgUT8VvKVHW+5rROqT/YEnR/8BpZyHn1+ARTpuYURZC6rV4Wxi+s852TcSUxKpEmWkos6fLemhYWP48XHoXgk+clLCgz356+3Te8zc0yV4dx+S3PcdPs0kgOwZEDrDtVpoXvezqPVuFQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by SA1PR15MB5186.namprd15.prod.outlook.com (2603:10b6:806:236::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 18:56:13 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::29c5:e5e5:39e5:7df6]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::29c5:e5e5:39e5:7df6%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 18:56:13 +0000
Message-ID: <1d4067c6-9124-1a6f-a43a-054cdb57a443@fb.com>
Date:   Wed, 11 May 2022 11:56:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190023.2578209-1-yhs@fb.com>
 <CAEf4BzbXuN4YOYqm_ojgTuJMo4a+J_M6WPF=MUX1B9BK8DdmMQ@mail.gmail.com>
 <f9fa3310-0f63-18af-5424-b82df11c4a70@fb.com>
 <CAEf4BzZg2e5XvE-E7mz9Vss-YJfP8SbuqogpN0837UjshBg8EA@mail.gmail.com>
 <132622f3-71ec-61a0-924f-a112fd6f822c@fb.com>
 <CAEf4BzYmJd_xdyhaWtyck9veAKjtB0z=RfGip4jdygdE8wj6Fg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYmJd_xdyhaWtyck9veAKjtB0z=RfGip4jdygdE8wj6Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:930:2::20) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e13e903-e235-4618-a416-08da337feb1f
X-MS-TrafficTypeDiagnostic: SA1PR15MB5186:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB5186A0C01E7BF74DC45808E4D3C89@SA1PR15MB5186.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLYd+/TSzk66j+kBW29MdAoKZkLvMoV87PVBOuG+2wMwVoa3cDLNgmS3jjFPE9JW2vB91z+uF81+L4DJXs12ikR1gMhajItyvSBMuZ4xC1cXMIDyONI9ocJZIF9g1mYJ8qgTZZ2rNJr8jTNos2NsEqYwblNiO7fhmtpV9hST0PLJy5f20pqr5vpvPAfgmJn8jSl6NCwm+perYYB5c6Gl0P7Y6CTYjXqwgrwF0OmeelgNsUwgkLK54pAaXVWrvmfQGAUxe5UH3DClgj1BS4wIY6vj7wERXJGb67AMMa4FukvXwJOGZwTIe7YKIwFIQAC6JNY9R6zwTmnHSoMxtNiB53VagDKOlsOwE8Q2eY4pEz4MgqT3OFwrpdphAgn7ZqMPZ3Hc/B/Nsbzxk6at3D7SMe+mLRT+fl/xSUrh2GWf4uEUqIt4CidcKyv9xrNxfTKcyLrBloyYY/40nojVMj+MpEmzKN2uDTTuk8IEONKjvipiDtekB1SuSLAehi7qpvuBaMPtaXDaEQchYZWJLb1FeHWNgpokdUdQjmY8eEHAnhI30OFXzO0nUDBSaAVc7ShWD0PLSt5Y5UubfTqq4y0HpK77mo4+nNUl+iQWzZ/gRxXRnqflnZb9KI19QRX3/t9OXe89a/Y4oGxVRQs6M7KyP/4kd1xBqXtXNtkhoGk4YW4gmtWJ7OlYNdNlhtVnezcJOrJVDVCoxL+x9ChnWMQyAa5WUrgbGtNgwXZ+n3GyW5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(186003)(38100700002)(66946007)(31696002)(6486002)(8936002)(66476007)(508600001)(6916009)(83380400001)(5660300002)(316002)(2616005)(54906003)(4326008)(52116002)(66556008)(6506007)(6512007)(53546011)(6666004)(8676002)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0p1clo4cFIvVmdleWhCRTkvUFBzN0dwaHVWSkJXU25oY29yYXpGL21HWmZo?=
 =?utf-8?B?cWdRWlZUNE1sSnlJUjdMRVh3aTFYUVZ5MkhoMDM5eFJiajVqamcvRGRndDNL?=
 =?utf-8?B?QjY1VkpPWTkxNDhINDFyQTFEaWo0cHBBc21Xc21oK09EdHdNNndmVThxQlZG?=
 =?utf-8?B?OVlZeTFkNkgySzdQYlh1cDZmbUdIU056US9TdVl6aUxuV05xemdBNytTd1hi?=
 =?utf-8?B?Q0pUeThsZVRTcGRuMTdYSVBYTzZvNWpsSUVoLzFFL1pBRTZoakM0bVdNMUVt?=
 =?utf-8?B?UnpCWlZVTENISy9CRmF2WjVIUldRRFNIanhYUkxsSUdBUWtHbHVFTytWVG5W?=
 =?utf-8?B?dzJ2dHlEK1M4bUExRVlXYXBnNTdHckJnY0lhdzk2aVpGVTFIN0ozYUNkRVBr?=
 =?utf-8?B?aFFVZThNaVlPSGJxZWZUYWcyVHVRejFzYm84ZHprSzFCSGV2RE05Tjl5SEVt?=
 =?utf-8?B?SXhvSE8rbjU4N1FyNHp2NzBNV2d2dFlIMW9YOE0yb3lFMmNNWTVCWGpVZHlM?=
 =?utf-8?B?bktxbUF6cUh0WlVySkgrb3BnU2xmbG5xTFh1S3JQNENjL2xOaW05bHkrRUJs?=
 =?utf-8?B?N1M4c282dURadmplTWtwZGtsN1lRTzV1VTVMbFJqRFdaYXQ4S1J0RDhJc3JP?=
 =?utf-8?B?S0lwbHJMeXpQaENQQ0tUdEF5SU1JaE1Ba2xrSEhNclJYNXdTYkY1NnJ6VVJD?=
 =?utf-8?B?L3V2K0w2a0hTTVp6RHBaWlFFQm9lb0dROUIzbnZtRTY3eDlONXNFbXR1Y3E4?=
 =?utf-8?B?aVNzVThXMlN6MDhDN281VGY4emFnMmFCSHRaMmR4SDFxZDQvVGlSclVSakYy?=
 =?utf-8?B?VnNjTEZ4QnVNVzJ4RnYrQTJuT1p0dzNrTGxIZUNRb2w2bHpZRHlSUDNaZTRt?=
 =?utf-8?B?NkNKMUZsZGZPeUI5U1AxSEdjSW9rMWNOT0dNMGEyQzJOK1IrZFBxR3dGZzlZ?=
 =?utf-8?B?MlliMTRUcW5VNXlXbFRMMTU3eW5KaTJjMTRrRzZMYlpDamsvU2s1T0Z1NWp3?=
 =?utf-8?B?SGRFTi9saU13U3QveDkxdC9qRGdwb1FMbjM3UWJoSTFOYkU2ZFNtL0hrRW4r?=
 =?utf-8?B?cTFSa25aUGZ2aXUzclVpdEZNRjdsMlBsaE16NS9JbU5RaG5GNk1EOTJLQkE5?=
 =?utf-8?B?eld2MUJoczM4MVluSkdjMFowbVBQRytONXdJUFp1QTZ2MmVDbFNHRmNxWnRt?=
 =?utf-8?B?V1IybnhqK0U3ajlBbkw1MENyb2oxd1BmSzhZblkwYzgxbklFVndrUzRHNTVq?=
 =?utf-8?B?REI3U29wWVMxUm5XTGxKaXIrSlA2elA4RXJDT0ZIUDI4cEZYd3F2Q294RzN3?=
 =?utf-8?B?N3o1YzI3eTljZXZlc3NoS05VTTI2VXR6VVRiZGFnM2UyN1RDOEJCZnArZGRO?=
 =?utf-8?B?VUNDYmd2SUpTV3luMmQvNC9rUXAwS1VhalV1eUM5YUNHeHdPRHVvWGJ1Vk5W?=
 =?utf-8?B?Y1VNUUJ2YUJjUEFlL3YzVDZ5bGxNOG5CTXVYVTMzSWkxb0Z0bEoyRWl4VmV3?=
 =?utf-8?B?R08zd09hQ1MxQVhrQ2M5Z0lJQ2kySHhHenc3cldybkxSRWo4bXl3RUpvVGtU?=
 =?utf-8?B?dHpEY1BDd3BNYnRZRm9ETEptV3J1R0s0QnFQOFFSYUlCL0pGUS83NWhLenQ5?=
 =?utf-8?B?Qk8rcjRNMmU4cEFpcVVZUk14dWhaYk5ydjdFelVrM1U3SGhMcittUmlXaExM?=
 =?utf-8?B?V0pLQSt0ZDduUm9mQ201S2t6aVp1YVBIaVJ6VUFzUUx5VC9jbTF1eThMT0dG?=
 =?utf-8?B?aTAwYm9GVS9CTGEzeHVxckF6UC9ocFMvSmJDRm45bkJHVWk1dHlZaUFsdFZM?=
 =?utf-8?B?dVFjMEh1cUtjNmtuY2tOM256MDlNN0RqdnYzcDVsWlFSU2dMdUhvQ2U1ZUxv?=
 =?utf-8?B?bVIwcURIa3BBVHg1YWVmTUhKWnJjTWh5MG1PenQvUnBucFBlUGVxMk1naHRY?=
 =?utf-8?B?UERvTFZXSkJYYkF0c2RqNW1UbUtaRjlGNERNbXRFWGVSQVZybFlXUDJ0cXNJ?=
 =?utf-8?B?U01Fcm1YUWw2WTczM3FVQTVITXlpMXhrODhhdFZMWitWN0I4QVFRTFU2U2do?=
 =?utf-8?B?UnNYenhnNkpkanVDM3FYc0tldGdrTjdKVEZEMURBUS9YZVNhczRpbVJXWDYy?=
 =?utf-8?B?QTN1VERSU2hEeDRiT0tRQkFaV1ZkaUVLaUx4LzdNVVFmOG8yQXE4YWVoZ05j?=
 =?utf-8?B?L2grcFErSEdkZXBNRk5vRlZ5eVBuajlyQ3doeHBUTmxEZTBjblFEUkRiRjg4?=
 =?utf-8?B?aFVOME1TcjMxNWdBaTV6T2JYZzVrK3FpK0c5WDIvMXZub0tzcGg3cDJ1VmxT?=
 =?utf-8?B?c2xTQTViMkhqVE9HWjFERWVrb3lXdlU5NjRid1BjMEFaSlp6SHp1L0oxZmtC?=
 =?utf-8?Q?b88z41qI27NpYabg=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e13e903-e235-4618-a416-08da337feb1f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 18:56:12.6647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SszGRZb9s9OXsXedNTbITp5XZac8VF1L9VEiCteuvIBXg9Ka0MCkzvPcp9S9aT6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5186
X-Proofpoint-GUID: rgWKDu4jILcuFQmkDS_buvICVPOrZyMk
X-Proofpoint-ORIG-GUID: rgWKDu4jILcuFQmkDS_buvICVPOrZyMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/11/22 10:43 AM, Andrii Nakryiko wrote:
> On Tue, May 10, 2022 at 5:39 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 5/10/22 4:38 PM, Andrii Nakryiko wrote:
>>> On Tue, May 10, 2022 at 3:40 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>>
>>>> On 5/9/22 4:25 PM, Andrii Nakryiko wrote:
>>>>> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>>>>>
>>>>>> Add BTF_KIND_ENUM64 support. Deprecated btf__add_enum() and
>>>>>> btf__add_enum_value() and introduced the following new APIs
>>>>>>      btf__add_enum32()
>>>>>>      btf__add_enum32_value()
>>>>>>      btf__add_enum64()
>>>>>>      btf__add_enum64_value()
>>>>>> due to new kind and introduction of kflag.
>>>>>>
>>>>>> To support old kernel with enum64, the sanitization is
>>>>>> added to replace BTF_KIND_ENUM64 with a bunch of
>>>>>> pointer-to-void types.
>>>>>>
>>>>>> The enum64 value relocation is also supported. The enum64
>>>>>> forward resolution, with enum type as forward declaration
>>>>>> and enum64 as the actual definition, is also supported.
>>>>>>
>>>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>>>> ---
>>>>>>     tools/lib/bpf/btf.c                           | 226 +++++++++++++++++-
>>>>>>     tools/lib/bpf/btf.h                           |  21 ++
>>>>>>     tools/lib/bpf/btf_dump.c                      |  94 ++++++--
>>>>>>     tools/lib/bpf/libbpf.c                        |  64 ++++-
>>>>>>     tools/lib/bpf/libbpf.map                      |   4 +
>>>>>>     tools/lib/bpf/libbpf_internal.h               |   2 +
>>>>>>     tools/lib/bpf/linker.c                        |   2 +
>>>>>>     tools/lib/bpf/relo_core.c                     |  93 ++++---
>>>>>>     .../selftests/bpf/prog_tests/btf_dump.c       |  10 +-
>>>>>>     .../selftests/bpf/prog_tests/btf_write.c      |   6 +-
>>>>>>     10 files changed, 450 insertions(+), 72 deletions(-)
>>>>>>
>>>>>
>>>
>>> [...]
>>>
>>>>>
>>>>>
>>>>>> +       t->size = tsize;
>>>>>> +
>>>>>> +       return btf_commit_type(btf, sz);
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Append new BTF_KIND_ENUM type with:
>>>>>> + *   - *name* - name of the enum, can be NULL or empty for anonymous enums;
>>>>>> + *   - *is_unsigned* - whether the enum values are unsigned or not;
>>>>>> + *
>>>>>> + * Enum initially has no enum values in it (and corresponds to enum forward
>>>>>> + * declaration). Enumerator values can be added by btf__add_enum64_value()
>>>>>> + * immediately after btf__add_enum() succeeds.
>>>>>> + *
>>>>>> + * Returns:
>>>>>> + *   - >0, type ID of newly added BTF type;
>>>>>> + *   - <0, on error.
>>>>>> + */
>>>>>> +int btf__add_enum32(struct btf *btf, const char *name, bool is_unsigned)
>>>>>
>>>>> given it's still BTF_KIND_ENUM in UAPI, let's keep 32-bit ones as just
>>>>> btf__add_enum()/btf__add_enum_value() and not deprecate anything.
>>>>> ENUM64 can be thought about as more of a special case, so I think it's
>>>>> ok.
>>>>
>>>> The current btf__add_enum api:
>>>> LIBBPF_API int btf__add_enum(struct btf *btf, const char *name, __u32
>>>> bytes_sz);
>>>>
>>>> The issue is it doesn't have signedness parameter. if the user input
>>>> is
>>>>       enum { A = -1, B = 0, C = 1 };
>>>> the actual printout btf format will be
>>>>       enum { A 4294967295, B = 0, C = 1}
>>>> does not match the original source.
>>>
>>> Oh, I didn't realize that's the reason. I still like btf__add_enum()
>>> name much better, can you please do the same macro trick that I did
>>> for bpf_prog_load() based on the number of arguments? We'll be able to
>>> preserve good API name and add extra argument. Once this lands we'll
>>> need to update pahole to added signedness bit, but otherwise I don't
>>> think there are many other users of these APIs currently (I might be
>>> wrong, but macro magic gives us backwards compat anyway).
>>>
>>>>
>>>>>
>>>>>> +{
>>>>>> +       return btf_add_enum_common(btf, name, is_unsigned, BTF_KIND_ENUM, 4);
>>>>>> +}
>>>>>> +
>>>>>
>>>>> [...]
>>>>>
>>>>>>     /*
>>>
>>> [...]
>>>
>>>>>> @@ -764,8 +792,13 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>>>>>>                    if (!spec)
>>>>>>                            return -EUCLEAN; /* request instruction poisoning */
>>>>>>                    t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
>>>>>> -               e = btf_enum(t) + spec->spec[0].idx;
>>>>>> -               *val = e->val;
>>>>>> +               if (btf_is_enum(t)) {
>>>>>> +                       e = btf_enum(t) + spec->spec[0].idx;
>>>>>> +                       *val = e->val;
>>>>>> +               } else {
>>>>>> +                       e64 = btf_enum64(t) + spec->spec[0].idx;
>>>>>> +                       *val = btf_enum64_value(e64);
>>>>>> +               }
>>>>>
>>>>> I think with sign bit we now have further complication: for 32-bit
>>>>> enums we need to sign extend 32-bit values to s64 and then cast as
>>>>> u64, no? Seems like a helper to abstract that is good to have here.
>>>>> Otherwise relocating enum ABC { D = -1 } will produce invalid ldimm64
>>>>> instruction, right?
>>>>
>>>> We should be fine here. For enum32, we have
>>>> struct btf_enum {
>>>>            __u32   name_off;
>>>>            __s32   val;
>>>> };
>>>> So above *val = e->val will first sign extend from __s32 to __s64
>>>> and then the __u64. Let me have a helper with additional comments
>>>> to make it clear.
>>>>
>>>
>>> Ok, great! Let's just shorten this as I suggested below?
>>
>> The
>>   >>> *val = btf_is_enum(t)
>>   >>>       ? btf_enum(t)[spec->spec[0].idx]
>>   >>>       : btf_enum64(t)[spec->spec[0].idx];
>> won't work, but the following should work:
>>      *val = btf_is_enum(t)
>>          ? btf_enum(t)[spec->spec[0].idx].val
>>          : btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
> 
> yep, for consistency it should be btf_enum64(t)[spec->spec[0].idx],
> but it's very minor, of course
> 
>>>
>>>>>
>>>>> Also keep in mind that you can use btf_enum()/btf_enum64() as an
>>>>> array, so above you can write just as
>>>>>
>>>>> *val = btf_is_enum(t)
>>>>>        ? btf_enum(t)[spec->spec[0].idx]
>>>>>        : btf_enum64(t)[spec->spec[0].idx];
>>>>>
>>>>> But we need sign check and extension, so better to have a separate helper.
>>>>>
>>>>>>                    break;
>>>>>>            default:
>>>>>>                    return -EOPNOTSUPP;
>>>>>> @@ -1034,7 +1067,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>>>>>                    }
>>>>>>
>>>>>>                    insn[0].imm = new_val;
>>>>>> -               insn[1].imm = 0; /* currently only 32-bit values are supported */
>>>>>> +               insn[1].imm = new_val >> 32;
>>>>>
>>>>> for 32-bit instructions (ALU/ALU32, etc) we need to make sure that
>>>>> new_val fits in 32 bits. And we need to be careful about
>>>>> signed/unsigned, because for signed case all-zero or all-one upper 32
>>>>> bits are ok (sign extension). Can we know the expected signed/unsigned
>>>>> operation from bpf_insn itself? We should be, right?
>>>>
>>>> The core relocation insn for constant is
>>>>      move r1, <32bit value>
>>>> or
>>>>      ldimm_64 r1, <64bit value>
>>>> and there are no signedness information.
>>>> So the 64bit value (except sign extension) can only from
>>>> ldimm_64. We should be okay here, but I can double check.
>>>
>>> not sure how full 64-bit -1 should be loaded into register then. Does
>>> compiler generate extra sign-extending bit shifts or embedded constant
>>> is considered to be a signed constant always?
>>
>> For ldimm64 r1, -1,
>> the first insn imm will be 0xffffffff, and the second insn will also be
>> 0xffffffff. The final value will be
>>     ((u64)(u32)0xffffffff << 32) | (u32)0xffffffff
> 
> yeah, I get it for ldimm64, but I was specifically curious about move
> instruction that only has 32-bit immediate value but assigns to full
> 64-bit r1? Is it treated as signed unconditionally?

Yes, it is treated as 32-bit signed int and will do sign extension
if needed.

> 
>>
>>
>>>
>>>>
>>>>>
>>>>>>                    pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
>>>>>>                             prog_name, relo_idx, insn_idx,
>>>>>>                             (unsigned long long)imm, new_val);
>>>>>> @@ -1056,6 +1089,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>>>>>>      */
>>>
>>> [...]
