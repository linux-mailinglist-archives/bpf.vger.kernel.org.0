Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3930866E4EF
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 18:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjAQRbj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 12:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjAQR2L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 12:28:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E946715
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 09:26:52 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30HG4GIJ021077;
        Tue, 17 Jan 2023 09:26:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=uaEhqK17Sh9XYMnnvMpucKAmuWlrW8s53Vk/mkmjw3U=;
 b=Wk7T/G15BAYDTliornlfrso1WkOqV/g94T8k2xneGVcxfKwuqMP2xbHB0o2HASWVG2vd
 1Uee2UJhZ79ajCq3O/kwmu/Y/3V7D79kFFZOOnee5QzT35y+d9QRRwVDN3tcTST/MncC
 P5rM9f4Ld0H64h/2OIakFcTVFZ2Xs1e5dpuBmGSQD29HFT/BWGiHxgLhkKvkraBw4oOr
 AQrY/vnav9QnQmpzPg4N6Vx3UoqpSfNogaWXJr7Kjwp/J9HvtBSwtvvDMUBkGfCn+6F6
 JgKcnYMptoKRGoLGIW7ZoKDu9/+msS4c/YXD/eEDx2lZEP5rCIvamg1gS0kn0Zml3hTj 1A== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by m0001303.ppops.net (PPS) with ESMTPS id 3n5w8gh6jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:26:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp+FFfIPkgZiopUqc/kbrCG8UINyUt5h6YxKSIfJOHyOqa4xfI8SjORgIa4ToN9Sk3a6QRVbd0C7eC3g54qpJbKgsbP2KLBsQWTuaHf1XOJM7jSwxd7pC0uYZQX9Gca7s5cxlAMfSxzgeP68DhFfKHxa24dOVlX0o0PYIqxI9V5ikzI22i5knhTlYRKmXnuRQyGPuLDPBKNsxhCIZJedtQrSKJsBjx3L0jYkGbvB+WuOJvcIck0UeTxwFRxZFbnDd6ntd0DxY4LeWErBr529foWzHNBL9G/F/mtGOKmbUzQRN27qhrsj4LjM4oBx2ImmV5P/N9ZmfYP2T/HHlJEzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaEhqK17Sh9XYMnnvMpucKAmuWlrW8s53Vk/mkmjw3U=;
 b=nmsBCGOpRuqUZmpl0KTnvsCC//pp8VlvzoAOgg5srrjvY57wEcPU6/8cTadp5de6xn6klM2SYmtCP7EGqEnx0zgzrVrxbHMKb+lWiUzYB6+dNr4CLg9XjsxXtSEkstelDusl722ldvaB79skitI5Hyg0I+Sfz4OEHjm0Fs9k+8LYUKDGI6wb0VePE82wieu2qX8tElI9w2kx8Shq5QwfBc7PySr5m2xc249VZM85hdbr8qRJHZn9L1ZgHqKmOvxTwJC6yhAKG4JIcdOUKx4qNGDpeBFoIYuv1Bg/U9FKmbACZGTeKUHIIifUYMdZnuFQ7JQM/lXQZPvM0pUvQfXVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by CH3PR15MB6047.namprd15.prod.outlook.com (2603:10b6:610:162::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 17:26:35 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::406a:f351:63a7:7a0c]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::406a:f351:63a7:7a0c%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 17:26:35 +0000
Message-ID: <afcae0f4-97a0-b06e-0a4e-7955ca7dbc7c@meta.com>
Date:   Tue, 17 Jan 2023 12:26:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: Support multiple arg regs w/
 ref_obj_id for kfuncs
Content-Language: en-US
To:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <Y63HrbJV+rTSmvVe@maniforge.lan>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL1PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::25) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|CH3PR15MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9ce240-c6b8-44dc-08a4-08daf8affb6e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZTFMQPuCTZE99WZocjFvFG2O1sr9cF0HNWwBqWl5tZGaSc5D4rSCYDcHFZjEZ4prkJB9Ul8i2VEOKNlQpGhpJdjDo09Qno9ohK3xeDJnMZHHFzMZzvHWmXDzt9OCNHhjBbsVYaSFQgWReepyyi03D22lw+10p+oQtTV7k0gQkh4KtxgNGkzso7LnG51r1UsrngdkclidMpFT65z+xxd9/at6wC5FWrWowFVvZVDGrvWUUq9WpdK+B2j/qlG99wNB2gkn2j5nhLQ0843/p6ql6Qu/sz/DToGs/QxSNED2/MtKq5YzV2eXV3uXLormifci4Xz1QUQq2uP+HVoeTBTWGBGK7YpCZYpA8iiiXPhxWj3WEu7m2jMmsOZpj4eib12RTXiT85pDOALZLi6P46OsmywxfWsSp5TmVHubeBe0NYdBf9yEYDj2uuCc3uezLO369B4rlC+54buL6I1/xb1IeTzYARlHovIJQGLBNunVkqJ8PW1PVvROiquwC3lhCmhcuypvbb2BsQLamb2D+PpQmfoHXYZGJOQiNtAmcSzesCYcZXGGXJiDxqKjIDm4WgTxFFK8EYJZ4uhPrsFrKMbQEIHWUznZmoeKCG3sweZg2ZM6ibFgmIOOQMkAjRuSJl1xX0HrDQbi2lWPVMCVfWqPDVeXe6Rj2sWW3kto7rKP6Q5XnGAGFcXaqWtubUDrlItduM7P9eFA7DEDeHZRvi/B9NG3gplvGPaf3jkNAKkCNkZ4jUH7/+D8wrbyJK/XEjWNTRQcfDC1dByltmViGrmbfxluSv6AxUfs6xCpfkcl70=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(53546011)(66899015)(5660300002)(2906002)(41300700001)(8936002)(6666004)(83380400001)(6506007)(86362001)(38100700002)(31686004)(31696002)(66476007)(186003)(478600001)(966005)(66556008)(6486002)(36756003)(54906003)(316002)(4326008)(110136005)(2616005)(6512007)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21IbUIxUnY1ZWRPam9VUXdjUnEwTHRnU3NZVTdjU0tndSszNGpQVC92WGda?=
 =?utf-8?B?QkVQcHlQc1I2L0VBUks3d2x5T2Q0Tmw2SHZNU1VhcXIzaE4xUUkxZnJEdDB3?=
 =?utf-8?B?S3NmZ0M2YXZyY3VubTVyUEZ5WFpPenQxZVY4emswVllDUWFtYkdvc3lTcnpy?=
 =?utf-8?B?dnl4U28rRXY4Z1pac2xFaHhkVDRuMzYyMU1rdE5aV1FxaXJQbFF5R2lNVktY?=
 =?utf-8?B?bEFjMEIvcHlFNnZxRnV6Nk5OUzFHaDV3dTd1V2xveGZnb1BhRFd5RUozU3Mv?=
 =?utf-8?B?VXlBZ2pXSkhmQW1NUXlzUWZ0ZmZBS0c4azZZWGhCV29MaGNZTjRFRzh6SDJz?=
 =?utf-8?B?dTNjdjFkMUlqNXIvYm9EejRsREt3M0hpYjFKNllidDVCcnc0RVFRTVJDV0F6?=
 =?utf-8?B?L3JkZCtBck5tU1BpWkhCcUVEbEY1empidkFFYk9pNDYxcG9wd0dZcnA2OVBH?=
 =?utf-8?B?NkhMdisydUFMa2YyMVprd1ZoTWUraFpYODV4YkFGM1cyQ29DYzBJMVk4dlBu?=
 =?utf-8?B?M1ZnUk5oWDdqcTMvNTBBUk9oOUkybmlDOTZUZkVlem1RcXZjK1NoUHM1djBo?=
 =?utf-8?B?MHROLzNBbUdhQUphK1hwc24zaTBKR3l6Ull1Mklkc0dTUm9sSllRdjBNWkIz?=
 =?utf-8?B?ZDBjTnF3UHBudXkzdTNSbm12Wkh1R2hXenRvUWNGUzI5VEQyZ3VpSVFYczZC?=
 =?utf-8?B?WTg5dlVHUWdZdC9mc29Oa251Z3U3YWlnRGJKMHhqVUlTdWc2dFF0WjdMdGJK?=
 =?utf-8?B?NitSV1MvdHlZeUJENm02aUZsVXE2NVlVZno0ZjM4UENrejc4VXFxczBYdm5h?=
 =?utf-8?B?OFg1d0V2STNNcWltMTJ2THZRN2ZxQmgwQ3M1VmZKVXRmcUd4S1pZQXpUNEdL?=
 =?utf-8?B?U0tOeXRyU0NUUmFINXlsb09KQm04a0c3dnJ5cW5mbXh2VEh1a2JnOW93S0ZN?=
 =?utf-8?B?eE9VbmkxTkNZZlZMQjFLaUZGV2RtRGtLT2dENHZsZk5MdU9tSEVtaUh4MGpK?=
 =?utf-8?B?Z0RETGYyZlV4U0ppaW4xd1UwL1hQbHkxWWQ1dU9VelJsMWFWUUlmdC9lampr?=
 =?utf-8?B?dDJHRHJPc2RKWmRQa21GcUxRVVp2MTdVaDYzQzBLMlE1UmpXNHZNRGVrblJm?=
 =?utf-8?B?VGVJZFRUcFhFQlpPc0Q5R0hCNS8yYVNSZUxiRjdzRnplaFIyOGJIMzladDk5?=
 =?utf-8?B?RWtLc0x6WWluck1SRFUra1FaMFdtVWhuVUVkREhlWERtOGpiT25BM3RDNEc5?=
 =?utf-8?B?ZlVwTFdsNnh3dEJVcUpveGhXYVFRK1RZVFR5VVd4TkJqMmczWFFPaU1CN1FH?=
 =?utf-8?B?eldzcWF4QVQvbysvay9qRGRiQVM1VkVpa1p6c2JPV1prZk9RQlEzaEpQeitj?=
 =?utf-8?B?ZjJOR0Z1RlVyZDhuVzZsWXhMTXh4YkZndXU5UitpMWFEVlRLZVRBWHV0WE9i?=
 =?utf-8?B?UXpYYnNYZG5qemZ0QW1CaVF3RjExTmxCTVluRkxmMVl1NUdwdlRhOHNCdm1o?=
 =?utf-8?B?YlcwUCthcHRLZGZtNVR4N0hvblhxeUxIWFgyU3Q1VDZXaW8vb0pYZjNSbmlS?=
 =?utf-8?B?c0FhaXBJUjVCWk45NjBVcHZNUmZlN0U5ZTRsbXR2UzhEWkx1YkNVclpiMnhx?=
 =?utf-8?B?MTVUS3lPbDh0ZWgvRDBoWXRtUjJkN3JjV0ZoSVcyZFVwV0d4Nk9leWdqZi9a?=
 =?utf-8?B?QTdkemZGL0YrMzVFYmpIaXVvUDgyamVDOTBXMTNSNnFLTHlGYlBENEIrUEI5?=
 =?utf-8?B?TkFzSmJsQi9HK3N2TjBJdUlXekUyWVU3Qzh3SlFqU0dWTGtNL1RpcVFVbG82?=
 =?utf-8?B?TmdiS2NDMU9KSU5Jam4rMDErVWhZNEFPS0x4ZWFwRU5Cd3E2aG1BQ1RwR3lu?=
 =?utf-8?B?TjFqSFl5dW85N2RDSDEwQ1B5WjVUN2luNk8rdVZlTFpZQjVjRFpaa0FlV1VI?=
 =?utf-8?B?K3NvT084SnVPckVmNFIwa0FXQVZLVUJoeGZqUTJRNnZ3U2RoOEQ1UkNJRnhj?=
 =?utf-8?B?NTlHTGZUNzBkRmpPclNlSkJIU2liU0J3eGsxaEx0YkZ4dyttWk1JZWNQdVl4?=
 =?utf-8?B?RE5JeXQxU0t1T0M2TEZBRURWaFZiWmFWejVFbEN2TjlrbDdMdmtrN0pJODBk?=
 =?utf-8?B?NW1qR3NYSlpuTjhmZ3Y2d1BaMkYyOU5rUE01di9hZ3BsbWJ1Sml3YjNySnhj?=
 =?utf-8?Q?K6HbHi/efonxiKZ86OMT8tU=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9ce240-c6b8-44dc-08a4-08daf8affb6e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:26:34.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A5+KPz9DtCbONejRvx36zZwgYYs5ROVLVBJBuEYji1dfLlTX1mi1h0t09VXU9O0MO6zJLyJQosv8XHIeSUT5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6047
X-Proofpoint-GUID: sPSmipQCYqnLQObQxRXSWz6NlosCIFeT
X-Proofpoint-ORIG-GUID: sPSmipQCYqnLQObQxRXSWz6NlosCIFeT
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/29/22 12:00 PM, David Vernet wrote:
> On Thu, Dec 29, 2022 at 08:50:19AM -0800, Alexei Starovoitov wrote:
>> On Wed, Dec 28, 2022 at 10:40 PM David Vernet <void@manifault.com> wrote:
>>>
>>> On Sat, Dec 17, 2022 at 12:24:54AM -0800, Dave Marchevsky wrote:
>>>> Currently, kfuncs marked KF_RELEASE indicate that they release some
>>>> previously-acquired arg. The verifier assumes that such a function will
>>>> only have one arg reg w/ ref_obj_id set, and that that arg is the one to
>>>> be released. Multiple kfunc arg regs have ref_obj_id set is considered
>>>> an invalid state.
>>>>
>>>> For helpers, RELEASE is used to tag a particular arg in the function
>>>> proto, not the function itself. The arg with OBJ_RELEASE type tag is the
>>>> arg that the helper will release. There can only be one such tagged arg.
>>>> When verifying arg regs, multiple helper arg regs w/ ref_obj_id set is
>>>> also considered an invalid state.
>>>>
>>>> Later patches in this series will result in some linked_list helpers
>>>> marked KF_RELEASE having a valid reason to take two ref_obj_id args.
>>>> Specifically, bpf_list_push_{front,back} can push a node to a list head
>>>> which is itself part of a list node. In such a scenario both arguments
>>>> to these functions would have ref_obj_id > 0, thus would fail
>>>> verification under current logic.
>>>>
>>>> This patch changes kfunc ref_obj_id searching logic to find the last arg
>>>> reg w/ ref_obj_id and consider that the reg-to-release. This should be
>>>> backwards-compatible with all current kfuncs as they only expect one
>>>> such arg reg.
>>>
>>> Can't say I'm a huge fan of this proposal :-( While I think it's really
>>> unfortunate that kfunc flags are not defined per-arg for this exact type
>>> of reason, adding more flag-specific semantics like this is IMO a step
>>> in the wrong direction.  It's similar to the existing __sz and __k
>>> argument-naming semantics that inform the verifier that the arguments
>>> have special meaning. All of these little additions of special-case
>>> handling for kfunc flags end up requiring people writing kfuncs (and
>>> sometimes calling them) to read through the verifier to understand
>>> what's going on (though I will say that it's nice that __sz and __k are
>>> properly documented in [0]).
>>
>> Before getting to pros/cons of KF_* vs name suffix vs helper style
>> per-arg description...
>> It's important to highlight that here we're talking about
>> link list and rb tree kfuncs that are not like other kfuncs.
>> Majority of kfuncs can be added by subsystems like hid-bpf
>> without touching the verifier.
> 
> I hear you and I agree. It wasn't my intention to drag us into a larger
> discussion about kfuncs vs. helpers, but rather just to point out that I
> think we have to try hard to avoid adding special-case logic that
> requires looking into the verifier to understand the semantics. I think
> we're on the same page about this, based on this and your other
> response.
> 

In another thread you also mentioned that hypothetical "kfunc writer" persona
shouldn't have to understand kfunc flags in order to add their simple kfunc, and
I think your comments here are also presupposing a "kfunc writer" persona that
doesn't look at the verifier. Having such a person able to add kfuncs without
understanding the verifier is a good goal, but doesn't reflect current
reality when the kfunc needs to have any special semantics.

Regardless, I'd expect that anyone adding further new-style Graph
datastructures, old-style maps, or new datastructures unrelated to either,
will be closer to "verifier expert" than "random person adding a few kfuncs".

>> Here we're paving the way for graph (aka new gen data structs)
>> and so far not only kfuncs, but their arg types have to have
>> special handling inside the verifier.
>> There is not much yet to generalize and expose as generic KF_
>> flag or as a name suffix.
>> Therefore I think it's more appropriate to implement them
>> with minimal verifier changes and minimal complexity.
> 
> Agreed
> 

'Generalize' was addressed in Patch 2's thread.

>> There is no 3rd graph algorithm on the horizon after link list
>> and rbtree. Instead there is a big todo list for
>> 'multi owner graph node' and 'bpf_refcount_t'.
> 
> In this case my point in [0] of the only option for generalizing being
> to have something like KF_GRAPH_INSERT / KF_GRAPH_REMOVE is just not the
> way forward (which I also said was my opinion when I pointed it out as
> an option). Let's just special-case these kfuncs. There's already a
> precedence for doing that in the verifier anyways. Minimal complexity,
> minimal API changes. It's a win-win.
> 
> [0]: https://lore.kernel.org/all/Y63GLqZil9l1NzY4@maniforge.lan/
> 

There's certainly precedent for adding special-case "kfunc_id == KFUNC_whatever"
all over the verifier. It's a bad precedent, though, for reasons discussed in
[0].

To specifically address your points here, I don't buy the argument that
special-casing based on func id is "minimal complexity, minimal API changes".
Re: 'complexity': the logic implementing the complicated semantic will be
added regardless, it just won't have a name that's easily referenced in docs
and mailing list discussions.

Similarly, re: 'API changes': if by 'API' here you mean "API that's exposed
to folks adding kfuncs" - see my comments about "kfunc writer" persona above.
We can think of the verifier itself as an API too - with a single bpf_check
function. That API's behavior is indeed changed here, regardless of whether
the added semantics are gated by a kfunc flag or special-case checks. I don't
think that hiding complexity behind special-case checks when there could be
a named flag simplifies anything. The complexity is added regardless, question
is how many breadcrumbs and pointers we want to leave for folks trying to make
sense of it in the future.

  [0]: https://lore.kernel.org/bpf/9763aed7-0284-e400-b4dc-ed01718d8e1e@meta.com/

>> Those will require bigger changes in the verifier,
>> so I'd like to avoid premature generalization :) as analogous
>> to premature optimization :)
> 
> And of course given my points above and in other threads: agreed. I
> think we have an ideal middle-ground for minimizing complexity in the
> short term, and some nice follow-on todo-list items to work on in the
> medium-long term which will continue to improve things without
> (negatively) affecting users in any way. All SGTM
