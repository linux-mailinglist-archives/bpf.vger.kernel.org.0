Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A725670E47
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 00:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjAQX6r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 18:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAQX6Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 18:58:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D0078AAC
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 15:12:38 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLKCAQ012726;
        Tue, 17 Jan 2023 15:12:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6OTsR+P+9Mxy3DWIkosYne3Sgc4kBS/TeZajA1IOmRk=;
 b=OoR0W0DpkBsE3LWkZE+m26jGp3z+WYv2ha8xbOIxmWqo9uRgQvtqAGLECdczaiAEobl2
 MjwnyoWMobONgBbzu4yA5TGxc/laqBqO8zsO16JQfHWG2vcl0XvvBlA2S5kZ8YiFwSZj
 CPCnPfaRdaSoOIKVPIEWD+UAjgtwkmN+/G5JRYTBCKfamah/bTEcdrZ7Jsw5Gbe9NpSE
 2nbNzXRPdDeiOWToXp6ktcpuNz8AYrnWx6lHjGPkhdqwRTRMsttOl5rLnns/euMZ+Cm7
 Cf1C/6g9ZYnvne+vnHphQ1ndcZ+V8sj3scjrZhBkaKnYFAn5udvjVW8eBLFdJfc5ZN6i CQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5s5m4v0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:12:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE1iy1gHxvTOBuvvLKjWMMQj8/iOxwoSQOpucoEB+EubkZqm/0vEVggpJFkLJuRvcd1xVO4ebTigy7qNKZap+jRd9AWGAZM2863JaMT+MFQ79bgyXiB/EFhbQ7VQo1p3rz2c3G/FmGYcdJvr+11NKrOb7AKye72lNBiBh2LgELFTFzbAvptz9A6UsUqzPVgzMqhYYenS1yxP/Ys56yRRBFXJ982Lu32Qm6FkIK76b4K3wR2MjevKIafHw/r1w+wrgWguG1512rz2+HTJgsYi9wrz2xTRgqnTj2upFeb/EwnoovamnGKfiEQ4eiZj4aV51YCRWtJs0pjfi8D5l082HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OTsR+P+9Mxy3DWIkosYne3Sgc4kBS/TeZajA1IOmRk=;
 b=fxODZqTvcsaIz/adda+x+blcvPFlAjuqqZpH2woRd6nK2cY86u4HWqgpNfilY/QQUVLYV55QhfA0BlmZpyCICr1480maCEnamYeLkAbWDpapz/+uxtObAe/inXqTLBb7kP3lOlHhOk8G4JxJVv1hX+kndFrUHx0hZm2FPG+YT0U53ie+vGRMmtfNyVWSQTssAvKTSZspEHn+Xrf6ZL4YJsysjgin/wsGJRB2sGJl347cquFK/E4Z+cus99hWqgpnMMXFObvSb3ltvNX4CwV8jdYd6yy8DMoUq3nfwmcTxto2ha3pL5h0m6cMG2bWRFP+Mop1oC9DhgnyyyQg/bxzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by SA1PR15MB4321.namprd15.prod.outlook.com (2603:10b6:806:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 23:12:19 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::406a:f351:63a7:7a0c]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::406a:f351:63a7:7a0c%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 23:12:19 +0000
Message-ID: <51956c3d-3133-9ebd-b27c-ae704ead05ff@meta.com>
Date:   Tue, 17 Jan 2023 18:12:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: Support multiple arg regs w/
 ref_obj_id for kfuncs
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-2-davemarchevsky@fb.com>
 <Y602StijD+4Nymf6@maniforge.lan>
 <CAADnVQJREMX7p6QwmPsX9xsGnd3+CqB2WQbokf1vev6h7ZS7Pg@mail.gmail.com>
 <Y63HrbJV+rTSmvVe@maniforge.lan>
 <afcae0f4-97a0-b06e-0a4e-7955ca7dbc7c@meta.com>
 <CAADnVQJLnLpLjWgWqDPc96Jgk+OHZTeNux+iiyFjCcy+mQK5HA@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <CAADnVQJLnLpLjWgWqDPc96Jgk+OHZTeNux+iiyFjCcy+mQK5HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL0PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:207:3c::20) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|SA1PR15MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d31a22-63d1-4808-1aed-08daf8e04850
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3p0n1HUBMGDfy/+JK6mlaUawh4gXfZQFO9x4yti5XiY2Vogo+qdgQOa5QZj5EieeRpD0xQVkjSLFs1dcPqvxm2q+P8Ki3MM+jl/L9vnP1k4qFpATh1n7uEctEVYIOpXwm4WWJ8dDAsXNyeQpg/j0vfQgz4m8Qai8D+qE2Nujp1oeRc4aanNnC7RxQovZEcFtLdHTyv2q+3RIAdE2LTTnbOq95H8ZExxZA4YWnTedHL0ldSW8yyv0fynvFtxlsiWcTtCX9XF/toFaCJMstrefuXDvxChFOHnDiksIEf+ARwNvuXoHNFffT/vvLUimzps9Asw/1eP0Uy6SgPiR3c8ZnV1rwjz9oBQv2S3/BbKOdM/EswV3Vty9Ev0L8XVhjBREju3zyzCmdmuPbYnTW4evAP8M2KT9ugrtBPoeFLml6Cld9VVl3C2HoRjLIFIgsLwWHPMUXmVb0Q7CwK8ND90byAOrWG6U06jgRcbiZG46cqgilMjnZ1IyNiY4X9GwQmZBH7Z9x56u0P+QDZN3yveFz67x7oXBR9ZtVBtNU5ZfcVT+DSRpJ4jjqB/CvSs7y3RjTjRpN8sX67VKoP+cnSeDE8HvkAqkSimK4HMCx26BeM79oClo1MaiTBGJOWl2W8aYxw+ycDnjQQD1LuXkxspb0FX2l93+oyKD4LMMWSWbNAg2scVtrflPO+CffaKEuAeIlTeHxyP9dk4nK9KKS/xxxloZAZ6xNaOsLDl6ZbriVB1zEogLI9EqUMeu2MtNXEFu0zKiPvnSkUcF9mynvzpTrIxvtFA1VXA9vxU+b4EaAEA8ln67Xy5hjOEeUT9dChxh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199015)(83380400001)(41300700001)(5660300002)(8936002)(6916009)(4326008)(8676002)(66476007)(66946007)(66556008)(86362001)(31696002)(2906002)(36756003)(38100700002)(6486002)(966005)(2616005)(6506007)(53546011)(478600001)(186003)(6512007)(31686004)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXU1emV4UVA0VTBJNE13WUxjM3BqTWlhWlRxSGtVWU1PTTlhQmFlTk01ek9B?=
 =?utf-8?B?VktkOUZOcTE4S3o3SUNEWXFJZnNPZmhBbm81RmJLRDFGa3p6b08rRExlN05n?=
 =?utf-8?B?NHoyRGg5SituNkFGaTNCeTRvc0YxVm54dk9KZDNna3VMUnB3QWxuTDFEQ1pF?=
 =?utf-8?B?RHdETFVQMTlSQU5FSTBVVzNid1Q3YnpMeTczMFlzazRlcWJUcnNCYnNWSmlJ?=
 =?utf-8?B?eVloRjIwaVgvUVNkV2F3S2g3SlJHQWNrSGQvQWxZUU1ZYUVYMytpZGF6amxE?=
 =?utf-8?B?ZXgzZHFtZitEaEZCNW5XajhTL2dIR2Y2WGtNREN6NEcrLzhEQjR6NzdpUFhV?=
 =?utf-8?B?QzY1M21nTWgwMDdwRWtudlhCR2JaMmZvN3YzdTUrWGFpWkg3dlE0UE1jZzdC?=
 =?utf-8?B?ajh1T2QvRTNRTFlUdnR2Q1VrdTFjNXNJZVBTR2krR09NVm8zOVcrSFF1Z1R5?=
 =?utf-8?B?WE9NU3MrK1dFcjZVZHBGNkxrUHdGSFFQcFJpVThVVy9wM3A1RWk3bUphWk1B?=
 =?utf-8?B?aXRPWS81ZXllWHRaMFZxd3MzUDEvWGJBMDJ2TC93VzJ0OHNGZ043d3BkNFI2?=
 =?utf-8?B?MHRUTk9SaklDVk1VK1ZJeGdQTFd2Y2NiUTZDVDBHWXorK0dzUFhhL2VGdVBq?=
 =?utf-8?B?OTBadGJpWm9iNDBLL0dObWNuWmR1TU1keU91UGVDNnF6ZjlTNDdMRzRZWmlC?=
 =?utf-8?B?YXVpd045TW9UWkljR0o4UmdDOHdtSEwyOXJaUzJzVDl0b1VZS1Y3R0JXYjQ3?=
 =?utf-8?B?cWVmS0MzMmRwQUlwMDV4dHBEa1JKWld5alA1QVNxa2E0eDl0cVFiUFhTMWJR?=
 =?utf-8?B?NExIczRITENVYjhXOE1sTG5odkViVXlKM1ZMbko5b0NRNnEreVhKckt6aHhj?=
 =?utf-8?B?L3BMSU9rT0FISHBaYjZ5STN0YzFCaXp2STg0QjB2cXdtQ0tlZE5NSTQ3Tmpz?=
 =?utf-8?B?M2NNaW93RWtISmdaNmkzTFhRNHc2bEJIV0xHLytGbnZacWJGeGkreGd5RXVZ?=
 =?utf-8?B?MHdlOFN6VHZtV0NETjZWUkpTUVBhNnRWWXJ1c2U3OWpWZ052NDBoSERpZE5y?=
 =?utf-8?B?M2hBcmlZSlQ3U3dFdXlDclBzK1ZiUEk3aHBLZWhkNnpDQ2Z2NUU3aUpIRFVT?=
 =?utf-8?B?aEVjazM2Sk9GbDhGaGloTUhNWUJxV1JZc3kwSHY5bXN1QXpZYitJYVFaNExp?=
 =?utf-8?B?V0VTYW5zQlFtSkNEUFpHU2xFcWdIQmFJNkxoZmQ2MmRpQnAvN08wK3QwbkUx?=
 =?utf-8?B?OXk5NUNSSGRqV0Ivc0pRZDdYWlZadXdROWpqTFlib0toOHQrdnlvVURkT3R2?=
 =?utf-8?B?QVlwWnB1amgrM3ZiUXkzYklwVGcxOWNacE9OY0tBb0RBSFQ3eDJlMUFVR0I3?=
 =?utf-8?B?WmFmdlhpMGNOTnk2TGg3Ty85OUJiSVBLb25EVlErci94bTFOVVlJbWE4V3FM?=
 =?utf-8?B?azlZMlNIZVFWUE55RFdTenBNR0lkejU5c0xDU1VnSFhpMnZleG9LdDNOV05G?=
 =?utf-8?B?eEdIanUrT3ltQU52bko0aFJaMjdmYytkYUx2RFZJYURkbGxQRjc0VGxYNElq?=
 =?utf-8?B?c0pnUTVzdEtpeHFSWG95dnlRY2FLbmdBUzMyVVFQcjdMbUQ0aUQrcHVXZnRi?=
 =?utf-8?B?SS80R3phQWlwNjVHOFd4d0FoMnEyMDV3ZC9xUHNkZDRkL2ZEZkk4MzBTdjY5?=
 =?utf-8?B?dHUrK2NJZlBDeVlaWWNqUDhkWEMwZk9CRDdUbTdDcE9jQ21qS3Q2TS80U2RY?=
 =?utf-8?B?Q1BwTkJ2WUhJUUl4STJPalc5TWZVZERBdU5FdFJCMTdyditQVWhSa2xqU2NH?=
 =?utf-8?B?ckxYQ25IV1pJcU0wbitSbFhSMGFnU3Z5MWRCN0VkcVMyOHRtYXp1MUpRa2Vp?=
 =?utf-8?B?QVNkT1lQNXgxN2lFaXlSdmo5WEVZb3o3eDVnWU9DNXYzc09DSm5mbkh6Q1ZQ?=
 =?utf-8?B?aFdxcTlMbmlaWTRxT1dYcEYrQTFnSUZwSXVKaXpyeE1Bd2ovZEF4Sk56c3hP?=
 =?utf-8?B?YUpJamdWWDEydHNYVXpPdTRBK0s2aWdHQ0xzUFQwcXFkTnVaZXkvRmJzMVZX?=
 =?utf-8?B?UnQyaVJPNXl6NGJ1MXk3L0lyTmw5WTJ6SkVUazRUZW1BdXozLzMwbGUrQ2dk?=
 =?utf-8?B?SDNEcWtpYjFRckJnN05mbjFTVE1ObEFWdUpqMzZDQ0tiaENHK2NQWFJaT1lp?=
 =?utf-8?Q?TtenLyp+Sxm2XPM3Lq8XUAI=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d31a22-63d1-4808-1aed-08daf8e04850
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 23:12:19.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtYPjtVcRxakG+pSXpI0ALByQkli1v5u326+4iZPBOj3X7s4DkNJOgeHuN2OtJ/fyj8ad6stByQLK5P+OBzfqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4321
X-Proofpoint-GUID: f6_DPq2PV-ASWvd9bEaokNsaP-lro7jR
X-Proofpoint-ORIG-GUID: f6_DPq2PV-ASWvd9bEaokNsaP-lro7jR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/17/23 12:36 PM, Alexei Starovoitov wrote:
> On Tue, Jan 17, 2023 at 9:26 AM Dave Marchevsky <davemarchevsky@meta.com> wrote:
>>
>> In another thread you also mentioned that hypothetical "kfunc writer" persona
>> shouldn't have to understand kfunc flags in order to add their simple kfunc, and
>> I think your comments here are also presupposing a "kfunc writer" persona that
>> doesn't look at the verifier. Having such a person able to add kfuncs without
>> understanding the verifier is a good goal, but doesn't reflect current
>> reality when the kfunc needs to have any special semantics.
> 
> agree on that goal.
> 
>> Regardless, I'd expect that anyone adding further new-style Graph
>> datastructures, old-style maps, or new datastructures unrelated to either,
>> will be closer to "verifier expert" than "random person adding a few kfuncs".
> 
> also agree, since it's a reality right now.
> 
>>>> Here we're paving the way for graph (aka new gen data structs)
>>>> and so far not only kfuncs, but their arg types have to have
>>>> special handling inside the verifier.
>>>> There is not much yet to generalize and expose as generic KF_
>>>> flag or as a name suffix.
>>>> Therefore I think it's more appropriate to implement them
>>>> with minimal verifier changes and minimal complexity.
>>>
>>> Agreed
>>>
>>
>> 'Generalize' was addressed in Patch 2's thread.
>>
>>>> There is no 3rd graph algorithm on the horizon after link list
>>>> and rbtree. Instead there is a big todo list for
>>>> 'multi owner graph node' and 'bpf_refcount_t'.
>>>
>>> In this case my point in [0] of the only option for generalizing being
>>> to have something like KF_GRAPH_INSERT / KF_GRAPH_REMOVE is just not the
>>> way forward (which I also said was my opinion when I pointed it out as
>>> an option). Let's just special-case these kfuncs. There's already a
>>> precedence for doing that in the verifier anyways. Minimal complexity,
>>> minimal API changes. It's a win-win.
>>>
>>> [0]: https://lore.kernel.org/all/Y63GLqZil9l1NzY4@maniforge.lan/
>>>
>>
>> There's certainly precedent for adding special-case "kfunc_id == KFUNC_whatever"
>> all over the verifier. It's a bad precedent, though, for reasons discussed in
>> [0].
>>
>> To specifically address your points here, I don't buy the argument that
>> special-casing based on func id is "minimal complexity, minimal API changes".
>> Re: 'complexity': the logic implementing the complicated semantic will be
>> added regardless, it just won't have a name that's easily referenced in docs
>> and mailing list discussions.
>>
>> Similarly, re: 'API changes': if by 'API' here you mean "API that's exposed
>> to folks adding kfuncs" - see my comments about "kfunc writer" persona above.
>> We can think of the verifier itself as an API too - with a single bpf_check
>> function. That API's behavior is indeed changed here, regardless of whether
>> the added semantics are gated by a kfunc flag or special-case checks. I don't
>> think that hiding complexity behind special-case checks when there could be
>> a named flag simplifies anything. The complexity is added regardless, question
>> is how many breadcrumbs and pointers we want to leave for folks trying to make
>> sense of it in the future.
>>
>>   [0]: https://lore.kernel.org/bpf/9763aed7-0284-e400-b4dc-ed01718d8e1e@meta.com/
> 
> I could have agreed to this as well if I didn't go and remove
> all the new KF_*OWN* flags.
> imo the resulting diff of mine vs your initial patch is easier to
> follow and reason about.
> So for this case "kfunc_id == KFUNC_whatever" is cleaner.
> It doesn't mean that it will be the case in other situations.

In the alternate "bpf: Migrate release_on_unlock logic to non-owning ref
semantics" series you submitted, you mean?

It's certainly a smaller diff and easier to reason about as an individual
change. IMO "smaller diff" is largely due to my version moving
convert_owning_non_owning semantics to function-level while yours keeps it at
arg-level. I think moving to function-level is necessary, elaborated on
why in the other deep side-thread [0].

  [0]: https://lore.kernel.org/bpf/9763aed7-0284-e400-b4dc-ed01718d8e1e@meta.com/
