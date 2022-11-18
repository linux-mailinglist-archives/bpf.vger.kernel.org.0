Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29AA62FD4E
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 19:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiKRSyq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 13:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242805AbiKRSy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 13:54:27 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1808B9C2A7;
        Fri, 18 Nov 2022 10:52:48 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIH9ODE019161;
        Fri, 18 Nov 2022 10:52:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6PEm6+kzt7u4soy8QlY0Eo3hg5iQkMEmvHHrtPwvMas=;
 b=PeBtW3nWO/DcmRjC2BbVtab4Tcg0xYr3FmUBjUN3ayDDv3OntMv1DvHz/4K67LwAmYbj
 YqlG9C/PPpU522cxKqPTHvP2Xi7PHrgtVQqkJEh15+xWYMBzbNwbEOehie9M5H2o97rI
 HfC98DJiYpmfKMVQNVqJMloScZOL45kDt7/z4d+faYvHgGuS38WIEZ5jHE07dGfr3pg/
 9oaa5DrCT3Lo52ucRzh8xY+Eg+j/w/Ae8EZI7mUBtRiMJUgVvKQKs7fupcw+iaH+hdUP
 l+Xh+7pVsXwW7KTcWJzq3E3XWbtQxc7cSLwpsaTzSGo9aFcMy5OmC98hqUUHIiUQmufF Pw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kx0u0dds7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 10:52:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fhw86Cb6ysTDXInaD9+Cy1VddOsYOPrFBfu8O4WonncVRgvE49jN4z764fL+gyzBVgPIAAg8+xrwMdU8Vry3CXSL6djXzjcvC4G60zb5klTb6cDy/0V+Cu1aoSjoNg/uTa3nMOxerWctLEHzYHkSG1Uf6KCrMrHdgH+IE9w0iuekVhXM40brPhkx9Lb0mIM15W0vLNhKx/cyRLnagaypvmvQTMJd1t14PdTwgAKMqzcwqLG71A21zKIeG3yB6UjuHfJBSzLAEMIRZ+VoFBHJcv43kRj728bpplr76MF7sGc+RDYFFFA1dRDW71P+jYIBA177fIklL/yzERalcZHOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PEm6+kzt7u4soy8QlY0Eo3hg5iQkMEmvHHrtPwvMas=;
 b=dyXjYl8WQaJBQkPl87KZVz9ygWG67QRHctaiHwgtO0zrb2rgeeaMYBTfPqstk9DPplFIHmksuEzlTE650ch0G3xDHKDBaWca3NTFwgp1dJSun7Mqb0TasLHl41jsjhtUYCtariZjnuIu3tVX/afNarPBTm+8d7DwwvJ030tmU681C4hqtawpwMw+3ikSzfvD850J7rsije8jDLK3ay8vzq/LB3nhKG+hkIa/v29OCSMmASF2B0a6QinkNK0ZFLHvK6vbi8H4zLylBzIZFZaOyHTUyK9ZEv3UC8/EgNpsGCcRW+Dpn2mnTJf+Fk+gpfbLb3Mu5eKtu4co3t4YYDzmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by DM5PR15MB1212.namprd15.prod.outlook.com (2603:10b6:3:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 18:52:03 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::563a:dd91:dd5:6a8f]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::563a:dd91:dd5:6a8f%7]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 18:52:03 +0000
Message-ID: <2ab2b854-723a-5f15-8c18-0b5730d1b535@meta.com>
Date:   Fri, 18 Nov 2022 13:52:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221108220651.24492-1-revest@chromium.org>
 <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home>
 <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
 <20221117174030.0170cd36@gandalf.local.home>
 <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
 <20221118114519.2711d890@gandalf.local.home>
 <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
 <20221118130608.5ba89bd8@gandalf.local.home>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20221118130608.5ba89bd8@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BL1PR13CA0317.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::22) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|DM5PR15MB1212:EE_
X-MS-Office365-Filtering-Correlation-Id: caf9171f-bd36-489b-574c-08dac995fb98
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hidt1Odyl5VzF+5BlJSm8XOdcXJeFavTA2+K6qbOtbIiDs41LZ2I+rNOXgxJs9S7cMZme9AsFSHGwIzhBzGF6MH0topGDlsDEDSnBB3rHV37ExoXJ6U+ypEPiT2GL1wBRgeQeLgdPPb4JoKergu6o0CjGi8PtXzlFFFcg/1sSPIWkoZO7Y9rJUO+aIyV43GtaDEW10IlV32Sp/9ShfGUHiemn6w5mwpFFWsNemHX3bNrngSlVsAPGaXFOzv6X5gCctylz3fXuTk9A11bPZhPEHs+7UgMRmwGloSnmVxDfYawEHat5R6B3CRArlrJgiXafgfDT5K9r+Y3ExFeMWJp7jihX99RUjrOEexbiSF1IfL4wDX7Te2NMDzhYooRjUu1nV/wnKWXbA7oEz0LAl6+R9nMVUU7tpixY0hrvMGBzAki76BK6imXof8UXHBlvqZHZ679F72NdDyFlqyaPgZurk3fiQLrD1GTB36GCVtUJ2PG2pTJB2CnFPsOaDJ8fyFg9zGzX+t1H+THbFcbl3x61b3GiVbv3BOid0aCeFIngvsWHjLRSDIEBHANbkqldlY5nNCPdRPK9MHRjhWjTwsTUabqIH3+QQXbr2j8auoAJjxADss7pHrO4MDboTdfoenQKuo+Q1DfX2M1DzJLzTBg2dGNo2aBbV4HxNc3++QyiSKBK6Y73W3dispsTrgp7zmV9hJcnIlo/a0NS6xv9nF68ucIklc+I0tN5OA8NucUBClACN6FwombTrezbHyMs1Sm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199015)(38100700002)(31696002)(86362001)(8676002)(6512007)(316002)(53546011)(66946007)(36756003)(66476007)(8936002)(2906002)(7416002)(186003)(66556008)(4326008)(83380400001)(41300700001)(5660300002)(2616005)(478600001)(54906003)(31686004)(966005)(6916009)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXZVMkJKUUVpVGxKNUtHbjhmR3o2aW5VTUw1cEFJdThwZTNVNjhqVzM4cUIx?=
 =?utf-8?B?bU9Nb0FiMTByKys2VnVXVHRwMTRQZldnbTRVY1djbXhHc1pvcUp1amlHNGp4?=
 =?utf-8?B?T3o0cnpVbU5HMVNsYTEvTFVMUklvMW1KbDU1SmQzTGZvQWc3MlBLeG02M3E3?=
 =?utf-8?B?Y29KUUFvWXFmU2lwbko4TUUvZkRLY2xnN2ErM01MRHZ4aXZWUVBaWjY4bCtq?=
 =?utf-8?B?T2FoYXoxYjNrVndudmdOOExYRS9OK1lKMDRsOTMzU1MzUTEreHZvZDd2Yldh?=
 =?utf-8?B?VzQ2Q2RwbnFnSzJJR0dVZDRZbC9HUnhJMGRsQjRzYWZyQ2tCT2FYcUtHMng2?=
 =?utf-8?B?NnArZmNzZktKUXFTaXpBeGVxTmE1aGZLcFc0OWpEQmJ6U1F3OGhKdFl2Q3cy?=
 =?utf-8?B?MWUxTWFwSUxJeW9PcE4xeFpNMGtPcElIalg5bUEzc1ppMmM5aGFJQUQ1eWM1?=
 =?utf-8?B?U3MvVDhIQjZJbDhTTzdEczI2WGZ2Smh3dWltc0ZJVnFUTmdBdUpaSy92WHcr?=
 =?utf-8?B?K0VIelp0SGhSem1UcEtwOStDZUJQd29sVS9KVHc2U2ZVbEY5WUZZQnFlTExl?=
 =?utf-8?B?aWcwem1WTFk5MWlWNGdoVUtyblcxWm85Z3hyMzRva1F5VVo4emNRMHk0WTJJ?=
 =?utf-8?B?ZDJOVVV5cjNtNWtYVktmdENZeGhFb1ZMbW9Cait4Z0dKQkV6SmlUZzJhYzdj?=
 =?utf-8?B?RGpmcG9STkszUTFwYjZJd0oxTWNpbE92UGJNVTZWNkNBZnR4TWw0WThpbDFz?=
 =?utf-8?B?UHVVRFdZVUFQTDFFdmp2NzlET0tjeUFIcUh0S0c4aEgvTytUZzhQNkdkMTdM?=
 =?utf-8?B?RFdoMEdSekxLcE1aY1c2Z2ZEOENYWURZY1ZyWVNRaHlxZjZOMHdWd3FESGVt?=
 =?utf-8?B?UVFLZmpCM0Q1UGJYM0svb0R2akhtdUI1aFpsMDgwalpvaDk5M1Y3TUlvOVZx?=
 =?utf-8?B?b0VQUGJrcUhtNVRWVjRCQ3JkSUxONnczQWY4TGszUk11WWhmMVI5Qlo1c1U3?=
 =?utf-8?B?enpBSGdweTNSM0Z6NUtTRjVCZXBHVXZ6U1NIbUhKZDh6VSs5MmpHRkFseUsr?=
 =?utf-8?B?a0NUNkpWdGlFWVBJc1NXeDZlMGNyR0hyM1hSZGxON1ViM21HekdyQnl1NUV3?=
 =?utf-8?B?NVJKV2hjS2FiUzhLQ1V3Y3JwTHdrbFkzZy9IVVlOTFZsaE1HMW92aVhoM1Jj?=
 =?utf-8?B?aXBZa2QwYkUvaDF5Y00zKy9ucXY1SFBIeCtZUnQ3YlZvc05Md29QRTVKekhw?=
 =?utf-8?B?cDZodStLaWlpN0UzQUI4Vko3R3B1N0xoQVZ0d0VVYzFKV2J6Y2ExOXM4RDZF?=
 =?utf-8?B?bmQ2QlN1dTQwa3RTczkyQnNKaXRadG5lVXRWbG41b1BOeC81ZU5hWCtub0l4?=
 =?utf-8?B?V0hQbVNuM3JMQndQMEM2UlJzNVc3aWFJeHJwSnUyaEpzL0FlM2I0MHVScHFs?=
 =?utf-8?B?VTMzb0VOOU5EL1hVdS9nQ0x1VFAxRDhVWWNqdXozSFQ4Wi9tNXBYOGptaHgx?=
 =?utf-8?B?TVpIN3FtSzRiVEU4bVM2TEV4bDdqajJadllPZ3NCclE3SXNrQ2pmSWtoOFcy?=
 =?utf-8?B?MXRMWFZRb3BROEMwaWlDWUpnUkJHd3VCRUxGdW9xMWkvdTYrRmNYYmZUdjF3?=
 =?utf-8?B?NU1JNldwbzZiSGhQS3djZnN3QVR1THhxY3NDd1ZhajUxOStwSWVtTDVtM0xV?=
 =?utf-8?B?OHYrNjIvVGM1aVRSLzFIU3o0VG1uQWNtWnZOdFlBU1E0YnIyTjJVK1g4TG4r?=
 =?utf-8?B?V3JWQk96enJYR1JETDNUNk0zd1MreVVWSnpOMXFUNDZ6bVh3aHlKZjRDRjda?=
 =?utf-8?B?ajU2eWFkYXVHb1pNNmlHTnJkS2FHR1RwSmlERnVJV1Bib2gzc1ZvSTEwTm5m?=
 =?utf-8?B?TzlURnU4UjROL2hIWlVzclhpUjZ3ZER6Z2g2aFEvNVNSVlBpS1BXcnc0aXNa?=
 =?utf-8?B?NFM4NFBqL0FBVUk4cG9BanNSaHYyenRyUU5oZFB3bGQ4MURrRE14enMwZjRk?=
 =?utf-8?B?TllqcU9aeERzdFhIRlJEakJ6aDdqbW9sbnJQdnJiYzl1blRtc0tjY1FkSEFi?=
 =?utf-8?B?WnJhb2xYRGI0SUxlcHpUQjZWWVVES09YT0dHcWQyWnJwMDdEeHBIYTQ3eXd2?=
 =?utf-8?B?Z09ZS3BqSVVVT1cwazZabndnN3BvUk03QS80UDM2VDJ3R2ExeDlkYnlTL3ln?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf9171f-bd36-489b-574c-08dac995fb98
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 18:52:03.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbzQIuOLWpsAvwIStGqOuSnPQo4o/WFPLL7IEcExdGhMahhRCBbzYBjmlfRo0WSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1212
X-Proofpoint-ORIG-GUID: bALn-VpusLP5vJrv4xwUrR6YvJqStMgO
X-Proofpoint-GUID: bALn-VpusLP5vJrv4xwUrR6YvJqStMgO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/18/22 1:06 PM, Steven Rostedt wrote:
> On Fri, 18 Nov 2022 12:44:00 -0500
> Chris Mason <clm@meta.com> wrote:
> 
>>> My biggest concern is changing functionality of arbitrary functions by BPF.
>>> I would much rather limit what functions BPF could change with some
>>> annotation.
>>>
>>> int __bpf_modify foo()
>>> {
>>> 	...
>>> }
>>>
>>>
>>> That way if somethings not working, you can see directly in the code that
>>> the function could be modified by a BPF program, instead of getting some
>>> random bug report because a function returned an unexpected result that the
>>> code of that function could never produce.
>>>   
>>
>> The good news is that BPF generally confines the function replacement
>> through struct ops interfaces.
> 
> What struct ops interfaces?

https://lwn.net/Articles/811631/

> 
>>   There are also explicit allow lists to
>> limit functions where you can do return value overrides etc, so I think
> 
> Where are these lists.

Some of the original features:

https://lwn.net/Articles/811631/

It has changed and expanded since then, but hopefully you get the idea.

> 
>> it's fair to say these concerns are already baked in.  I'm sure they can
> 
> How do I know that a function return was modified by BPF? If I'm debugging
> something, is it obvious to the developer that is debugging an issue
> (perhaps unaware of what BPF programs are loaded on the users machine),
> that the return of a function was tweaked by BPF and that could be the
> source of the bug?
> 
>> be improved over the long term, but I don't think that's related to this
>> set of functionality on ARM.
> 
> I disagree. These issues may have been added to x86, but perhaps we should
> take a deeper look at them again before extending them to other
> architectures.

Honestly, I think a large scale architecture review of every BPF feature
and decision over the last 10 years is just the wrong bar for this patch
series.

 From my understanding, Mark and Florent have some changes planned
that'll improve ftrace, livepatching, and bpf.  Lets talk about those,
and tackle any long term improvements you'd like to make to BPF in other
patch series.

-chris

