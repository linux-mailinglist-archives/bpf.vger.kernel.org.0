Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921A661A6DF
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 03:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKECTx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 22:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKECTw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 22:19:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB5167DA
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 19:19:48 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4MueZm006051;
        Fri, 4 Nov 2022 19:19:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=0F9Q478YMfPbmIvzR1DrAHjRzF4ChkyTYeIco5ZITzM=;
 b=EYkrXaHct+dfOaN6MiM3drDgAu4bfqaFIpu58mYMjsIwyij1Sppb007Y7BsyQLZ4FQwl
 olNlyw/nL2y2yJwVZiIvsks9IBYuhhfjFdiWizC8jbPCN7nZgPDuOtpIrrBtqfFFuSOe
 0VAPxhz/PHT7hL9mD2PtqmZm91vh5KC1EiXf1dsUvOuhbVJyAj1/b3wGNMIvh32yeIWt
 2QejA8uYLLJes8UqFLDR56++AdX14enrHG2CUAaHx6Y85YRT7IPPj5sSx4VkCbLAVCx1
 2nfuWvTz4OSq+lmJEl1SuyppJX3wi3iGpt5U4rWaikG1A1ByVRZ8DxEhiaNC2AkknR3U vQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmpgm3j2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:19:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhCmebiaqgZMXJ9+aUBmnYZB4xXJR9w2JMIH32yUJ+hHmpMJLQpQN3GIVI0AOamSED3kIZYzOCOSeVR/yt7qnnddQJhCrnFeKsk/H1+IdpBjzJ3pMC9xjllJmukG520cbzDBArdh6d7RipoLcA/3FKaikZi+bDeU4zx8DIjdpSYkB97h1XgNq/Gvpc36DR6hjv6SO+LWjQ3PSDmJniTgHK3tpaSwqFlGsMDecpDlGy93O3d7ORZORanb0iQDnl054nwvjnGyjPLBhsiBbEEreCrk8q+TR+JZyqA7hIISnXqYnXJw2llq4gmGywZn1utOEK69BNOxmv/bPvtzG+Lt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0F9Q478YMfPbmIvzR1DrAHjRzF4ChkyTYeIco5ZITzM=;
 b=Jzqa8CWRUu1v3FyjFAmw+ypj8pF1fobbElLCsuTZSYYrYWWFiWJbsI2Dr00f8tTdliIHfSfZQFjgqJryBVVpkMNFmr0YQQsAl7QhLFSecCcRCm4nN7qoIPykZdUKu6qXwjE2HMbekon42yxVit2BgXYFB3cDCI+ysk1DtiS1BEMHCVTIadxps9vZNdoQu67tZDErfKJOFoANik6sScj4JbBnDlH8jnPARwgUB2qHoGOy5d9ZX6VeFidiwT2YYxvihiUeSlHQANsyMpEsBZE0xyhbGV0RkiFmYy3JpM8RY0KyZhKeRAH++EeTJcRxdvX4UFLjDs0/T7BDvVMtflO1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB2377.namprd15.prod.outlook.com (2603:10b6:5:8d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Sat, 5 Nov
 2022 02:19:31 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be%6]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 02:19:31 +0000
Message-ID: <2929a091-8193-3f0b-93b1-9812b69cf388@meta.com>
Date:   Fri, 4 Nov 2022 22:19:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v4 10/24] bpf: Introduce local kptrs
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-11-memxor@gmail.com>
 <CAADnVQKF7zs39ZRpU-9dAKaXZwRLRE8rFZ6m152AbWKC_6=LdQ@mail.gmail.com>
 <20221104075113.5ighwdvero4mugu7@apollo>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221104075113.5ighwdvero4mugu7@apollo>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|DM6PR15MB2377:EE_
X-MS-Office365-Filtering-Correlation-Id: c887f1c8-a7dc-44e2-7e30-08dabed42c9a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0xU+SDfu9yE4hbCd9QAxABh33TArVew2hH2xZk9PwA9PKMLW8/VU1yZdv0Rw4g0O6FQ18saZpnL9wIO57IXx57FUEUCzfmFbEG1Tbz8tlR5AbDe69T2ymKLR+YKeTfkftnBHP07vNi+iGNZA6OjFnHxOPlh4rozEu9Fl9NnUvD45n3kTadQMNlJog9piGhQv2DWC96QZvqhyrSiJqoGCDxZAr4EUEuy11vXpuP4qxkaLLGvriCaAnFtlmrlrbXdh8xiZkx4CLPOUMTI7z1NpixoytKotwBl2JIitAlEJKPYNIIn1VIHFT+UBir7RQ2elXFPb5ksFoMFc45v7oz30jjgQZuvCwXtUaWe6QV2v4fnEurCpCtrWM2gWbyVxCjIYOs3JksmECOB9RLYHRNaZ+SG2Acikh/uDj71mCnqS+KSN+WDyy+/Kvs1cwvQoCbk6Mwlsp6F27QmAy5CHTV0+jAOU6BQ/7H8wpaqE9wUqqqQDd/316CD9Lkn5/x2K5feDItKnrkUkSiXMYO2xpkcD21fDYLWHfnFVSlvzbfF17XTsOJ8JIusZgTPeUwRKqxoAdTV1NoB/9vJ5IdwsFRs1nFXg2Nm5gvuJkPKOfEX/YDTzKgzgiQy2Mt0LYGFSPT6QYAw/8YuNSNyl0C2F8B0chK9qij3kZYDSLlK3NI8kXDmVDQNfzjVLZtlvm/+BH0ulwqHvgymjIX15Z7wCRP5QakWIkt79DmzwUnDpG+RQ80DguorB/inYZbYN4K5GoPexvOtXAvSszmDvOCYG2+OJUMFMf5ZTrQk7plskHRn1UnmrUm1P1FH53PfER1cS2IfAXyTtDxxaqY6UwsqAzWp2dQEcFhsasvy+TiCmMv6GOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199015)(38100700002)(36756003)(31686004)(31696002)(86362001)(66476007)(53546011)(2906002)(6666004)(107886003)(6512007)(186003)(2616005)(83380400001)(6506007)(66556008)(478600001)(316002)(110136005)(8936002)(6486002)(54906003)(66946007)(966005)(41300700001)(4326008)(8676002)(5660300002)(17423001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25GYWpwdnVZZTFNUkx3UnpjVkpXVWNUOEJyTCs3SUpTOTduV1RHb0dGVzhN?=
 =?utf-8?B?YjBqb3QwQlA1TnpxTDAwelVmSEFLQUdidTRNYVpwaVRYd3JSWDNJY2t0aVNQ?=
 =?utf-8?B?NVh5Qms2Ymw1T1hiUnlqSjJpbVA4bzFtUFpnYnlLd0grWW9TaWZsUCtKWnFT?=
 =?utf-8?B?dWdrMWtxNTgzTjA5WUg5WEZ6UG02OVREY0Q0UjdWU21WVFYrVzZwb0ZNNXBv?=
 =?utf-8?B?Uk9GZmYvUDN5dHRqWllMQUROVThVaDFkbm15cnJnL3FRQXhzOC8vU0pDWUFj?=
 =?utf-8?B?dCs1UzYyWXVWNjdBOFgwQURTL2lJS3dtd3IvbDVrS3NtS3NUbmZCK0I3c3d4?=
 =?utf-8?B?RWJmNDFVV2ZNbW5xMHhMcGhia0pqNDZrM0M4cmJQd0lsNkNJeHJjcGRVRVVI?=
 =?utf-8?B?ZEx4c1FIRWp2ZkFOVFNFV1dxaUdoaVhpY1BvbnJmNi81THRqVFlTS1lnL1Z5?=
 =?utf-8?B?YzR1Y3Q5bEFBcEJEMzJhZkNMSHFaY2QzVnRMR3dKVjNNYmk5MUZiVndQbCsv?=
 =?utf-8?B?TmFmSzdHdmlLTTZqd0x2dC9HQ0FsTjRtcUlJTDMyc3JDdEc5VjNUcWRZMG51?=
 =?utf-8?B?M2RKL0RuN0tBZmRJTDlydEZiYlJ3bGpRYzZqdlEwdlc5ZU9ock5NWk4zbnVM?=
 =?utf-8?B?QU1acjY4TEI4OVI1VUJvWEYrNW1jeEkzblpqWUMxbkxnZ1RTeEtKMkhteWM4?=
 =?utf-8?B?WUpPM2EyNHpTSnJVbStFTGVRUGdqcXd2U1h4SkgyRkRVZ2gxeVg2ZWgyZW9P?=
 =?utf-8?B?czdhbVJ6OXFOVm1lRndKOXpTSDZFSHNkRUFsdXByeWJEWVFwRmpWeGNGTEdF?=
 =?utf-8?B?Ty96U0l2SEJCdUhXOFhMTXgvY2NhUWpMNVRXWkZGSmFMUHRCNEFLbjNFem93?=
 =?utf-8?B?ZnFBaXd3TTNZaUV5ZnFKaWx3T1RuK3ZDSkZ6QjBFbCtPZitMTWxtQUFCSWVj?=
 =?utf-8?B?THB2U2pjeElMem5sUE9Fenk2Mm80RmVvWEw0eDRseHFmWWx6cEJ1SnN0dThp?=
 =?utf-8?B?TGZCbVJPZ2dRZUFNUXdlTlRtSDZkbWNjT1djbHRQUEFtcllFNnMrRWVGTEQw?=
 =?utf-8?B?TkpYSXJOWnJVbU5PZ1F4MEVtOThZSXN2anpCT3EwdDBJYlcxRjFaOTVPckFH?=
 =?utf-8?B?a1NDMnJ3YWIwcWJHYzVWaFBEZ1hnT0JiejFib2FSODlhMWV2MGQ1SC9aU0VK?=
 =?utf-8?B?NkZjc1RNZ09LQXJTZFNuRHNhYWRrbEF3Y0tjeUJ6OHkzdzkyb1NnRUZLSlhq?=
 =?utf-8?B?Q0lodmIzYzBBeExiOHkraTZ6L0FCY0RzYlFtR3gvWWJBdWNUUXJaVklXNmlq?=
 =?utf-8?B?VEQzd3p4TE54NlRBVjRwQmRBaVZmY01sT1oxVkEycThLS0tYTUdYY0lTYTZp?=
 =?utf-8?B?Z09qSFRackptUnNvc0JOTUhCTEJ6WTZuaTY1dWFGVzh3Q3dBUEhtVytrODJI?=
 =?utf-8?B?cXhtQjRKMmxYZ1BDR0lRSVRjMDNFa1R1VktkdDVMUjhLRWViRkpMc1R2TWUv?=
 =?utf-8?B?Sk9aZnZFZjhkeTVGVCtKYkRtMWdJcmhmY0xQUXlKbllEaDVGS1RWdG05OUhU?=
 =?utf-8?B?eWkwOHZONE9hNWxabXRoWnBxNHNTcmZLcmlRaG16QUE5d1lEeEN0L3JoSWVT?=
 =?utf-8?B?ajBZNnNJbklIRWxCZWhnbnpMMU1vTWgrcVJOdmJUTzBrbXk3enNHdmNnNnR2?=
 =?utf-8?B?SXdMclVyKzZ0Y2RYNG1uKzhRREFvWVFkMzRIOHBBMWMxdXc5RzA3UG9OVm5K?=
 =?utf-8?B?NjVPcHVuMkVpQ1pUM3Q3OEplK1FhMWhmUFgwWmtqdFhWbmlmaXU4djQ3SSsx?=
 =?utf-8?B?WVRnazZaL3FNU1dlbzRNbnphdkM1YzhuWUczZi9TVit4OHVoMWx6OFhPVERo?=
 =?utf-8?B?eFFSczg4b0s5aGxjaW85Nm01VzIvbzRyVHJuOWdWRTV5U2VYcWNvQVZsMCtj?=
 =?utf-8?B?QnhUVlhaNnlvZW53WU56SEJKQ0tuSmNkOTBCdnJoLzBzdlBCY0t1a0xuMXRD?=
 =?utf-8?B?UmxxNnRFMHhyZHprNGZCZzdNbTFJZURranhydFloUFNZZm9Vdi9UeEpTVFI4?=
 =?utf-8?B?V2dadVNvWlZRM3pQbnZ2c3lMcVRtMmxiMWtFV2F2MUV6T3lSMS8zeFlpNUdk?=
 =?utf-8?B?TnM1VWxlK014cXlFU056dEFPemgxZmxyK2FwZDBHYlZUZ2VFU3hxR21TM1cz?=
 =?utf-8?Q?j57agR8hZ2Rp0o+5r9h1DEQ=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c887f1c8-a7dc-44e2-7e30-08dabed42c9a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2022 02:19:31.8575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rlCjaaGkUzU7LTGR+AbKpaRtets+/HEc+NtA2a1cZYtpFYt+PGAU15o+jpBeFUIAiCynD8Pos38Z5ldTmmlmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2377
X-Proofpoint-ORIG-GUID: WEm-EVaLeLbLDYsbnGLxW3WveBK2rFVm
X-Proofpoint-GUID: WEm-EVaLeLbLDYsbnGLxW3WveBK2rFVm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/4/22 3:51 AM, Kumar Kartikeya Dwivedi wrote:
> On Fri, Nov 04, 2022 at 11:27:04AM IST, Alexei Starovoitov wrote:
>> On Thu, Nov 3, 2022 at 12:11 PM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>>>
>>> Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
>>> program BTF. This is indicated by the presence of MEM_TYPE_LOCAL type
>>> tag in reg->type to avoid having to check btf_is_kernel when trying to
>>> match argument types in helpers.
>> ...
>>>
>>> +       /* MEM is of a type from program BTF, not kernel BTF. This is used to
>>> +        * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc.
>>> +        */
>>> +       MEM_TYPE_LOCAL          = BIT(11 + BPF_BASE_TYPE_BITS),
>>> +
>>
>> I know we have bpf_core_type_id_local.
>> It sort-of makes sense in the context of the program.
>> type_id_local -> inside the program
>> type_id_kernel -> kernel
>>
>> but in the context of the verifier "local kptr" doesn't read right.
>> Especially in MEM_TYPE_LOCAL.
> 
> Yes, "local kptr" is not the best name. "kptr to local type" is too verbose
> though, do you have any suggestions on what to call this?
> 
>>
>> Also, since it applies to PTR_TO_BTF_ID, should it prefix with PTR_?
>> Probably MEM_ is actually cleaner.
>> And we're not consistent already with MEM_PERCPU.
>> We can live with this inconsistency for now.
>>
>> So how about we rename MEM_ALLOC to MEM_RINGBUF,
>> since it's special bpf_ringbuf_reserve() memory
>> and use MEM_ALLOC to indicate the memory that came from bpf_obj_new ?
>>
> 
> Yes, it makes sense. I think Andrii has expressed the same wish to rename it to
> something similar to MEM_RINGBUF before in [0].

I like this idea as well. I've been poking on a small refactoring patchset in
the background which will get rid of (current) MEM_ALLOC anyways.

> 
> [0]: https://lore.kernel.org/bpf/CAEf4BzYK939fgyc3LwNvoz3vPk2avyskP_3wRZO344irubXPtg@mail.gmail.com
> 
>> ... which made me realize that the comment above should
>> s/bpf_kptr_alloc/bpf_obj_new/
> 
> I'll fix the comment.
