Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52896710FB
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 03:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjARCQb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 21:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjARCQ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 21:16:26 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360824E50A
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 18:16:24 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I1btOh025670;
        Tue, 17 Jan 2023 18:16:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=uJh1RoAztg+SZKzJ0wGLW5IdmnTbi14k2W3RYLRqAl4=;
 b=OhVSqNk2SfUEdVdFzwaSxK2JV9OTFGPcoVWNQdcqBaBk0ZGHD6wW/l/O3S90Wgs7aQDJ
 LiPkT758sqmLb6v8wIcMnNvxs4wy8h9LmUW0C5YazWnDeG6SvwvLtfLxTKMRCfWTOeCg
 TDl+bTodq0ggK93km7N2ZmaSE8Ka6mtkB2WY7vGIiN+z0UZL2kjFLYJxMBz588x4Qian
 BrGRZjYsokoszRHSifSxsJ0pdc0u0pbYEgyT9g3nP979H31ZpoAetxmpf+1kh02SXb7g
 VIqETA4WuFpIW2NN47POBheKJ7CpG3rIfwWtP3gsDOjlRLUiDfNKoNok5a4r74ytL7ag Jw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5ufemuns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 18:16:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC2BTxLhkvTF91lR9PS0fq8JInMfjkYbG3LsNn98rRMnmQrMB1QdEHMkXlr5SBl6jHZ9vESzKnYj6ODd/IaRnyrEYapLNzPMgm+jtMoMi+tLtOokmByCtY5XjIAefNoqylfdx0powd83yllE/KEIPSqgFH1EOJVkYnA3Tz8ZVg7a13bM6vobYRpVoxtlW5j36GQdB1mvaSxzp9afSdTT09IrgMpH4ccBS2SjcCzb4Q+/2Fvvsm6z5CjTIdasz+jMw+LLMcEMDUInnWxeSc2NzoA3gOMqqLaJ4BpIh4gSD2YxbaosvLhSA/pzF3hz5Qpb6GKE6tmqqWQ9vRoVRK5OVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJh1RoAztg+SZKzJ0wGLW5IdmnTbi14k2W3RYLRqAl4=;
 b=LvEg6P5k2bNUw23g0VuJPrP8mrECoPC6BkGTrx4/Gdtyle16OjUsqyPW3ECila994iTf6phO6WqGdEwMo52AjZqyVc6hJ4ahrz/pNa+R+YqU0SzIyg0ZWouiqky5S7S3soWkd4ARCG06TmHHvseWx6D0N4iuAwoyqTgsQQL/5fKJD1Hlj56nSySrnr7TORLD5aISqak0y+r3fkNoIjaJwm6+W57fAAIYJkFC0gXi8Lq8g+DhHgAYFRNDZUB6CewXGHJkT9wCtV/iAuHx1ykBKoY7a/RI+GXKrLPVXdptWtPEcGK5wdrgyAA9M6DhhiisXLTkzKJtqe6Y1w97JnFqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by SA1PR15MB4708.namprd15.prod.outlook.com (2603:10b6:806:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 02:16:03 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::a677:2a9d:89d6:b1d1]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::a677:2a9d:89d6:b1d1%9]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 02:16:02 +0000
Message-ID: <02b5f2ab-ed78-d006-f6b0-0f391c67ea5e@meta.com>
Date:   Tue, 17 Jan 2023 21:16:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 bpf-next 13/13] bpf, documentation: Add graph
 documentation for non-owning refs
Content-Language: en-US
To:     David Vernet <void@manifault.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-14-davemarchevsky@fb.com>
 <Y6y0l30bFTK7KalE@maniforge.lan>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <Y6y0l30bFTK7KalE@maniforge.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|SA1PR15MB4708:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd4e4fe-81ed-481e-743e-08daf8f9f28d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huVc4TxNGfG1eYrkiLT651ZJnCa8h8kYZLEu25w5iJDSEeRmrrwD7V01jEyQxuWTC9u5n/W1xgnUJcjl9xwSHfG6FsEweA1316HGFjPji7xUQch5Bf6mIViNt4rdECD6OFfZbcUTz+t5u8jsTtUdUHV6LhNCvlw3EFGvxhp14Zp0fEuaaIUHF+LzGf7k0BPcsr11IIr/lPFhu0zscfNylVPPn6CKMQ/GATMnwPyeF8WgvD9NBp4yFL7dWTEHPFMKQK/GbayX8uUtXMqKG97qNPEUm7peMGrLnoPYnEkcZ1NfpQ+VkQZQkLjhYJmL6GecWvS/Or/HmcasXdICK804t4WO1+fuhDcdu8IwTqUUL12qy0BtpKw2EbO41AMS33nlYPMOl32mdP09dqMODyUbtZTIkDD6usuF3zA/g1e6U3b157VBv21c1PqOGK/7h9HPUZkb3r4OwdXG9Y7Ce/Y/yhd3/b2StqhYSUuXZZxNSujSXmYv4Nf/4JxN9GhfvSQhias2tXG/z/5W/INl5bBbSB/luyuUxfUroEnHgqMxdhZWOmu+3s7GyEJxfEGTCDJnd2orAGzh5amtaQrWM6aTUcUK4QPdwgna4R9VBxXZsIxEbY+bZK+/5pIDZFoLzDTgTGyAw0DgiLH8nZTaL5wJsiSkIcnrECZUIYwcLMuvo9hrf169s0t5x8FDKkHWKKX5kQ//ltHQoDnj4RpG38rJAucvhPFGP0AokdWBFLyPoeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(38100700002)(83380400001)(86362001)(2906002)(5660300002)(8936002)(66946007)(8676002)(66476007)(30864003)(4326008)(66556008)(31696002)(41300700001)(2616005)(6506007)(186003)(6486002)(53546011)(6512007)(110136005)(316002)(478600001)(54906003)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktqaUlOSXN1RnhWY2VaTEcwMTZwM2lUNjIwcVBnbkYxUDF3akdlbzdacUp1?=
 =?utf-8?B?VHYwUjd1bzZ6RzEyRFNzL3lGaXdaVkxTaCtwWW83ZU90a2xRbWRrMksvOXdX?=
 =?utf-8?B?azZKdVVab1ZMb0VaY0tyKytIanpJQ1pyUGw0ZS9aV01pME96dGhvb2lnTDRu?=
 =?utf-8?B?Rm40SGJLeHpITkVYVXlyamxhRUlsTDlpb0xkSkRGN0J6S2JBcTlQK0VhenUx?=
 =?utf-8?B?dEdhckVPek5TSkVaNVFnVFRLUllzK0xHM1ErMEJHZWlnSEMwTUNRVjNFdm5n?=
 =?utf-8?B?Q2RiSkhZVHFaaXZLTDJxS1FTazZSLzFOa0dsdmdRemFJWkpUSDNCUHFTQURV?=
 =?utf-8?B?QXdTbHhNZzRpTGl2Wnh0T0QrY1lGU05VSEp0bW5VVStLeXI3REllbERYeDRF?=
 =?utf-8?B?R2dEVUxPRHB0dUs3d2Z2NWdzaFUwNnlCbHZQWkR3a0tNQ1BSUmdnaW1KWGZR?=
 =?utf-8?B?S252QzFlMEhKc1pPWXRUYk9KWXVxOEJwN1BmQ2JOT05nbW9sYVAvajhtMFVa?=
 =?utf-8?B?MWhBcG05NkIyd0liamJTME4xbWFkSS8ycUZrV3pwK1VKUW5IZTFRTjJBc3VX?=
 =?utf-8?B?ZHU2ME94cnNmYzBxMnhQbHJYc0JhTURLRkJheXJQTlk0L0N6OVhDZE1zd0xO?=
 =?utf-8?B?Q0cwK3htQWdOQWpwUWl0cWljOHlmZndqRWVzUlpxVzVjQ21tTXYvcG4yZUlC?=
 =?utf-8?B?b0p6WWNxSnh3M3BtUTltaG1kcytIWWVOcmYwTDlTZjB3dGtXWUtyUnVXSkJI?=
 =?utf-8?B?bHAzVlZOTTVQOU9tUVZVSUwvTmhlWWdHNEZKWkFrdkcvckR5RkE2ckVZVjZu?=
 =?utf-8?B?NjcxVVdmTVhybkJUNTE1OWorOGZPeE5VdVVUZDFkNTU3MW5Ja1hhNllETGw4?=
 =?utf-8?B?Nk9vUjlvSWxYSFJaVWdZT1VGOHFudHg5dzVsNGdUUFkyQ1luZnZmUVJiSTE1?=
 =?utf-8?B?T2UxemljYWFubktUZFdkNHRyYkt5UEpkV1RmZTRVTm1leFg0cVNUbTRjZzh3?=
 =?utf-8?B?cjFTRDY0S29xU3FpdjIzQ2FWRGZPZWJGU2RYMmtidWJPajhkSUd4Zkwyenp5?=
 =?utf-8?B?S0t2enJMSnNkdnFINWQzbFNYY0UrZnY3SFlsZEZnMUR2anNEWnN4UVlwNHNU?=
 =?utf-8?B?N0FHNTBiM3kxd3NBamNhTW1BTjNwZnFIVFE0U3pBbWZGS0lucXZoWmZCa0pG?=
 =?utf-8?B?UGhCREtCaDJpcU5KVi9GVVRrR0FaTjZhVUcwbFRxVFR3TVFMZEhXaXNISkRH?=
 =?utf-8?B?NGhuR29UTXFkN091ek1LQ3RXRmw1RGxtdTFWN2NGMFZhSXpTdWhPMElGNVJy?=
 =?utf-8?B?aUFLVnY3RnRNclRhZHNOT1ljNm5GdlRWNHVNVXZnN1FYMnJDU1FobWxNSStS?=
 =?utf-8?B?YkF2MW00TlJTTkRDUE1KZWZQS0NzMWw2K2JXcG5lWnBJZjkzajA2bWJrY0lI?=
 =?utf-8?B?aWNJOS9KdXV6QTB4TDlmcjBwd2I2cnNGVlVXYTFzbTRHVGZQVVRqU2Y3clJi?=
 =?utf-8?B?U3JySWNLNllacUNPakJ0MEluRUVJejQ2bGJVNytPdnlheCs5c2hWSm0zeXFw?=
 =?utf-8?B?bUJqWTZpN2orZE00dEw2aVc3SzVOTG12dTRxTWhNSGUxS1NlVTdyVE5LMFRt?=
 =?utf-8?B?d3JhaUlnWnlLSjdXTU16eDNPOXpab1ZxU29vQ2JQdUw1eDFBclJHQWVqVlB0?=
 =?utf-8?B?V1ZlYUFyZ3J4MWE5TldCMEJXWUQyQWJGWUF5QjgvZ1lna1JEZVVlWE5lVGYw?=
 =?utf-8?B?ME5CUUtjM0E2QklQdFVJMzdKTkdwbzhlZkFvZE5jd2w2QXNOZU94U3lpMUI5?=
 =?utf-8?B?amNjaW14U0xMS2VlQUZVbjdwZld6VTNENENDT1NRSnR1UEUrL1M0cUpBeFh0?=
 =?utf-8?B?RnhHT1ZwbThWeDdTQ09mV2c4N1c0SjR3UFZWSmNrUUpHdEZyYVM5ZmJKQ3p3?=
 =?utf-8?B?YWVYTVpObmZoR1pXQ1M0a2sxaGV1azJrOEFtNmdGbll6QXR5MnlOMXF0TVR1?=
 =?utf-8?B?MkNqY05HbHNLRFZXaTA0eEwra2pKSHBaaG54RVcxVW9iY0RkanJqU3czTGVy?=
 =?utf-8?B?MXZQY1B2UTlleC9YQTR4d2R6WGRSK0h2aXpHeWEvN0lYc2pBNmMyM2sxQXV5?=
 =?utf-8?B?SUhJMTQ1NUg2ZmdEYktSVFY0Zk9lQmtkR0FoL1VTZ1ZMYytpcXVLdmgwNm5S?=
 =?utf-8?Q?Cn60FoaSjsjNSuTnVpBEmqs=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd4e4fe-81ed-481e-743e-08daf8f9f28d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 02:16:02.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1L40XNvv3BdYRQIY7V+ZtU/YRP6/jrnbx0NpWYyIX1uOP7600IONm5+0XIHuOacJkjlwxXin44r0IO4gb0T2Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4708
X-Proofpoint-GUID: cMjlGOrARFCw_QzuODOyacp_Z55RD_bC
X-Proofpoint-ORIG-GUID: cMjlGOrARFCw_QzuODOyacp_Z55RD_bC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_11,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/28/22 4:26 PM, David Vernet wrote:
> On Sat, Dec 17, 2022 at 12:25:06AM -0800, Dave Marchevsky wrote:
>> It is difficult to intuit the semantics of owning and non-owning
>> references from verifier code. In order to keep the high-level details
>> from being lost in the mailing list, this patch adds documentation
>> explaining semantics and details.
>>
>> The target audience of doc added in this patch is folks working on BPF
>> internals, as there's focus on "what should the verifier do here". Via
>> reorganization or copy-and-paste, much of the content can probably be
>> repurposed for BPF program writer audience as well.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> 
> Hey Dave,
> 
> Thanks for writing this up. I left a few comments and suggestions as a
> first pass. Feel free to push back on any of them.
> 
>> ---
>>  Documentation/bpf/graph_ds_impl.rst | 208 ++++++++++++++++++++++++++++
>>  Documentation/bpf/other.rst         |   3 +-
>>  2 files changed, 210 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/bpf/graph_ds_impl.rst
>>
>> diff --git a/Documentation/bpf/graph_ds_impl.rst b/Documentation/bpf/graph_ds_impl.rst
>> new file mode 100644
>> index 000000000000..f92cbd223dc3
>> --- /dev/null
>> +++ b/Documentation/bpf/graph_ds_impl.rst
>> @@ -0,0 +1,208 @@
>> +=========================
>> +BPF Graph Data Structures
>> +=========================
>> +
>> +This document describes implementation details of new-style "graph" data
>> +structures (linked_list, rbtree), with particular focus on verifier
> 
> s/with particular/with a particular
> 

I'm no grammar expert, but based on my googling
"with particular focus" is widely used in newspapers and other places
where grammarians lurk.

>> +implementation of semantics particular to those data structures.
> 
> s/particular/specific
> 
> Just because we already use the word "particular" in the sentence?
> 

Ack

> In general this sentence feels a bit difficult to parse. Wdyt about
> this?
> 
> ...with a particular focus on how the verifier ensures that they are
> properly and safely used by BPF programs.
> 

Agreed in general, but re: your specific suggestion: "the verifier's
implementation of semantics specific to those data structures" communicates
that there are semantics specific to those data structures which required
verifier changes. 

"ensures that they are properly and safely used by BPF programs" is more
vague, but definitely easier to parse.

Will rewrite in some other way which is hopefully best of both worlds.

>> +
>> +Note that the intent of this document is to describe the current state of
>> +these graph data structures, **no guarantees** of stability for either
> 
> I think we can end the sentence in the middle here.
> 
> ...these graph data structures. **No guarantees**...

Ack

> 
> Should we also add a sentence or two here about the intended audience
> (people working on the verifier or readers who are interested in
> learning more about BPF internals)?
> 

Ack

>> +semantics or APIs are made or implied here.
>> +
>> +.. contents::
>> +    :local:
>> +    :depth: 2
>> +
>> +Introduction
>> +------------
>> +
>> +The BPF map API has historically been the main way to expose data structures
>> +of various types for use within BPF programs. Some data structures fit naturally
>> +with the map API (HASH, ARRAY), others less so. Consequentially, programs
> 
> Would you mind please adding some details on why some data structures
> don't fit naturally into the existing map APIs? I feel like that's kind
> of the main focus of the article, so it would probably help to give some
> high-level context up front.
> 
>> +interacting with the latter group of data structures can be hard to parse
>> +for kernel programmers without previous BPF experience.
> 
> I'm not sure I quite follow how this latter point about data structures
> being hard to parse is derived from the point about how some data
> structures don't fit naturally with the map APIs. Maybe we should say
> something like:
> 
> ..., others less so. Given that the API surface and behavioral semantics
> are fundmentally different between these two classes of BPF data
> structures, kernel programmers who are used to interacting with map-type
> data structures may find these graph-type data structures to be
> confusing or unfamiliar.
> 
> Wdyt?
> 

The "Introduction" section is trying to make these points:

  * Data structures have historically been forced to adhere to the Map API
  * Some data structures (linked list, rbtree) don't fit the Map API well
  * For data stuctures that don't fit the Map API well, two problems would
    arise if they were exposed as maps:
    * "square peg / round hole" - in a vacuum, it'd be hard to make sense
      of how Map API manipulates those data structures
    * "Familiarity" - we're not in a vacuum, folks would prefer to write / read
      code that interacts with these data structures in a "normal" kernel style

I will expand upon these, but FWIW the main point of this document is to explain
why new verifier functionality is necessary to make Graph datastructures work,
and what said new functionality does.

Explaining why map API is a bad fit is part of that, but I expect the reader to
have some experience writing BPF programs which interact with maps, so I
probably won't elaborate too much on the basics here. The sentence(s) added to
satisfy your "intended audience" suggestion will say as much.

>> +
>> +Luckily, some restrictions which necessitated the use of BPF map semantics are
>> +no longer relevant. With the introduction of kfuncs, kptrs, and the any-context
>> +BPF allocator, it is now possible to implement BPF data structures whose API
>> +and semantics more closely match those exposed to the rest of the kernel.
> 
> Suggestion, I'd consider explicitly contrasting the map-type
> implementation here with the graph-type implementation. What do you
> think of something like this instead of the above paragraph:
> 
> BPF map-type data structures are defined as part of the UAPI in ``enum
> bpf_map_type``, and are accessed and manipulated using BPF
> :doc:`helpers`. The behaviors, backing memory, and implementations of
> these map-type data structures are entirely encapsulated from BPF
> programs, and mostly encapsulated from the verifier, by the helper
> functions. The logic in the verifier for ensuring that map-type data
> structures are correctly used therefore essentially amounts to
> statically verifying that the helper functions that manipulate and
> access the data structure are called correctly by the program, as
> defined in the helper prototypes. The verifier then relies on the helper
> to properly manipulate the backing data structure with its validated
> arguments.
>> BPF graph-type data structures, on the other hand, leverage more modern
> features such as :doc:`kfuncs`, kptrs, and the any-context BPF
> allocator. They allow BPF programs to manipulate the data structures
> directly using APIs and semantics which more closely match those exposed
> to code in the main kernel, with the verifier's job now being to ensure
> that the programs are properly manipulating the data structures, rather
> than relying on helper functions to properly manipulate the data
> structures in the main kernel.
> 

There's good info here, but I think it belongs in specific sections where
new approach is discussed, not in introduction. For "intended audience" reasons
touched on in my response above.

For "non-owning references section", I will add some paragraphs explaining why
there's no equivalent concept for Map API. For other things you touched on (UAPI
vs kptrs, prealloc vs any-context allocator, etc), I'll add other sections.

>> +
>> +Two such data structures - linked_list and rbtree - have many verification
>> +details in common. Because both have "root"s ("head" for linked_list) and
>> +"node"s, the verifier code and this document refer to common functionality
>> +as "graph_api", "graph_root", "graph_node", etc.
> 
> 
> 
>> +
>> +Unless otherwise stated, examples and semantics below apply to both graph data
>> +structures.
>> +
>> +Non-owning references
>> +---------------------
>> +
>> +**Motivation**
>> +
>> +Consider the following BPF code:
>> +
>> +.. code-block:: c
> 
> You need an extra newline here or the docs build will complain:
> 
> bpf-next/Documentation/bpf/graph_ds_impl.rst:46: ERROR: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 9 supplied.
> 
> .. code-block:: c
>         struct node_data *n = bpf_obj_new(typeof(*n)); /* BEFORE */
> 
>         bpf_spin_lock(&lock);
> 
>         bpf_rbtree_add(&tree, n); /* AFTER */
> 
>         bpf_spin_unlock(&lock);
> 

Ack

>> +        struct node_data *n = bpf_obj_new(typeof(*n)); /* BEFORE */
>> +
>> +        bpf_spin_lock(&lock);
>> +
>> +        bpf_rbtree_add(&tree, n); /* AFTER */
>> +
>> +        bpf_spin_unlock(&lock);
> 
> Also need a newline here or sphinx will get confused and think the
> vertical line is part of the code block.
> 

Ack, all sphinx build errors / warnings for this doc have been fixed.

>> +----
>> +
>> +From the verifier's perspective, after bpf_obj_new ``n`` has type
>> +``PTR_TO_BTF_ID | MEM_ALLOC`` with btf_id of ``struct node_data`` and a
>> +nonzero ``ref_obj_id``. Because it holds ``n``, the program has ownership
> 
> I had to read this first sentence a few times to parse it, maybe due to
> a missing comma between "after bpf_obj_new" and "``n`` has type...".
> What do you think about this wording?
> 
> From the verifier's perspective, the pointer ``n`` returned from
> ``bpf_obj_new`` has type ``PTR_TO_BTF_ID | MEM_ALLOC``, with a `btf_id`
> of ``struct node_data``, and a nonzero ``ref_obj_id``.
> 

Ack, your wording is better.

>> +of the pointee's lifetime (object pointed to by ``n``). The BPF program must
> 
> Should we move (object pointed to by ``n``) to be directly after
> "pointee's" / before "lifetime"? Otherwise it reads kind of odd given
> that "lifetime" is really the indirect object in the sentence.
> 

Ack.

>> +pass off ownership before exiting - either via ``bpf_obj_drop``, which free's
> 
> s/free's/frees
> 

I did ``free``'s and ``free``'d instead of these suggested changes. Want to make
it obvious that the action taken is equivalent to free() from malloc API.

>> +the object, or by adding it to ``tree`` with ``bpf_rbtree_add``.
>> +
>> +(``BEFORE`` and ``AFTER`` comments in the example denote beginning of "before
>> +ownership is passed" and "after ownership is passed")
> 
> Should we use something like ACQUIRED / PASSED / RELEASED instead of
> BEFORE / AFTER?
> 

Ack. None of the code samples need RELEASED comment yet, but this scheme is
easier to follow regardless.

>> +
>> +What should the verifier do with ``n`` after ownership is passed off? If the
>> +object was free'd with ``bpf_obj_drop`` the answer is obvious: the verifier
> 
> s/free'd/freed
> 
>> +should reject programs which attempt to access ``n`` after ``bpf_obj_drop`` as
>> +the object is no longer valid. The underlying memory may have been reused for
>> +some other allocation, unmapped, etc.
>> +
>> +When ownership is passed to ``tree`` via ``bpf_rbtree_add`` the answer is less
>> +obvious. The verifier could enforce the same semantics as for ``bpf_obj_drop``,
>> +but that would result in programs with useful, common coding patterns being
>> +rejected, e.g.:
>> +
>> +.. code-block:: c
> 
> Same here (newline)
> 
>> +        int x;
>> +        struct node_data *n = bpf_obj_new(typeof(*n)); /* BEFORE */
>> +
>> +        bpf_spin_lock(&lock);
>> +
>> +        bpf_rbtree_add(&tree, n); /* AFTER */
>> +        x = n->data;
>> +        n->data = 42;
>> +
>> +        bpf_spin_unlock(&lock);
> 
> Same here (newline)
> 
>> +----
>> +
>> +Both the read from and write to ``n->data`` would be rejected. The verifier
>> +can do better, though, by taking advantage of two details:
>> +
>> +  * Graph data structure APIs can only be used when the ``bpf_spin_lock``
>> +    associated with the graph root is held
> 
> I'd consider giving a bit more background information on this somewhere
> above. This is the first time we've mentioned anything about a lock, so
> it might be worth it to give some context on how these graph-type maps
> are defined and initialized.
> 
> I realize we could be approaching "useful even to people who aren't
> working on the verifier" territory if we go into too much detail, but I
> also think it's important to give backround context on this stuff
> regardless of the intended audience in order for the documentation to
> really be useful.
> 

Agreed, this document is missing important background information about
spin_locks + Graph Datastructures.

>> +  * Both graph data structures have pointer stability
> 
> You also need a newline between nested list entries or sphinx will get
> confused. My suggestion would be to just always have a newline between
> list entries (applies elsewhere in the file as well).
> 

Ack. Apparently I needed three spaces to trigger the next nesting level (had
two). After doing that, it was obvious why your "always have a newline"
suggestion is good.

>> +    * Because graph nodes are allocated with ``bpf_obj_new`` and
>> +      adding / removing from the root involves fiddling with the
>> +      ``bpf_{list,rb}_node`` field of the node struct, a graph node will
>> +      remain at the same address after either operation.
>> +
>> +Because the associated ``bpf_spin_lock`` must be held by any program adding
>> +or removing, if we're in the critical section bounded by that lock, we know
>> +that no other program can add or remove until the end of the critical section.
>> +This combined with pointer stability means that, until the critical section
>> +ends, we can safely access the graph node through ``n`` even after it was used
>> +to pass ownership.
>> +
>> +The verifier considers such a reference a *non-owning reference*. The ref
>> +returned by ``bpf_obj_new`` is accordingly considered an *owning reference*.
>> +Both terms currently only have meaning in the context of graph nodes and API.
>> +
>> +**Details**
>> +
>> +Let's enumerate the properties of both types of references.
>> +
>> +*owning reference*
>> +
>> +  * This reference controls the lifetime of the pointee
>> +  * Ownership of pointee must be 'released' by passing it to some graph API
>> +    kfunc, or via ``bpf_obj_drop``, which free's the pointee
> 
> s/free's/frees. "Frees" is a verb, "free's" is a possessive.
> 
>> +    * If not released before program ends, verifier considers program invalid
>> +  * Access to the pointee's memory will not page fault
>> +
>> +*non-owning reference*
>> +
>> +  * This reference does not own the pointee
>> +    * It cannot be used to add the graph node to a graph root, nor free via
>> +      ``bpf_obj_drop``
>> +  * No explicit control of lifetime, but can infer valid lifetime based on
>> +    non-owning ref existence (see explanation below)
>> +  * Access to the pointee's memory will not page fault
> 
> I'd consider defining references, or at least giving some high-level
> description of how they work, somewhere a bit earlier in the page. The
> "Non-owning references" section kind of just jumps right into examples
> of what the verifier allows without describing the concept at a higher
> level, so readers will have a difficult time applying what they're
> reading to the examples being provided.
> 
>> +
>> +From verifier's perspective non-owning references can only exist
>> +between spin_lock and spin_unlock. Why? After spin_unlock another program
>> +can do arbitrary operations on the data structure like removing and free-ing
> 
> s/free-ing/freeing
> 
>> +via bpf_obj_drop. A non-owning ref to some chunk of memory that was remove'd,
> 
> s/remove'd/removed

Similarly to ``free``'d, 'remove' here is referring to a specific function, so
did ``remove``'d instead.

> 
> I'll stop pointing these out for now, they apply throughout the page.
> 
>> +free'd, and reused via bpf_obj_new would point to an entirely different thing.
>> +Or the memory could go away.
>> +
>> +To prevent this logic violation all non-owning references are invalidated by
>> +verifier after critical section ends. This is necessary to ensure "will
> 
> - s/by verifier/by the verifier
> - s/after critical section/after a critical section
> - s/to ensure "will not"/to ensure a "will not"
> 
> 

Ack, except s/to ensure "will not"/to ensure the "will not"

>> +not page fault" property of non-owning reference. So if verifier hasn't
> 
> - s/of non-owning/of the non-owning
> - s/So if verifier/So if the verifier
> 

Ack, except s/of non-owning reference/of non-owning references

>> +invalidated a non-owning ref, accessing it will not page fault.
>> +
>> +Currently ``bpf_obj_drop`` is not allowed in the critical section, so
>> +if there's a valid non-owning ref, we must be in critical section, and can
> 
> s/in critical section/in a critical section
> 

Ack

>> +conclude that the ref's memory hasn't been dropped-and-free'd or dropped-
>> +and-reused.
> 
> If you split the line like this, it will render as "dropped-and- reused".
> 

Ack

>> +
>> +Any reference to a node that is in a rbtree _must_ be non-owning, since
> 
> s/a rbtree/an rbtree
> 

TIL, ack.

>> +the tree has control of pointee lifetime. Similarly, any ref to a node
> 
> s/of pointee lifetime/of the pointee's lifetime
> 

ack

>> +that isn't in rbtree _must_ be owning. This results in a nice property:
> 
> s/in rbtree/in an rbtree
> 

ack

>> +graph API add / remove implementations don't need to check if a node
>> +has already been added (or already removed), as the verifier type system
>> +prevents such a state from being valid.
> 
> I feel like "verifier type system" isn't quite accurate here, though I
> may be wrong. When I think of something like "verifier type system" I'm
> more envisioning how the verifier ensures that the correct BTF IDs are
> passed. In this case, it's really the BPF graph-object ownership model
> that's ensuring that the state is valid, right?
> 

I mean "type system" here in the PL / language runtime sense. Although the
verifier doesn't execute the code at runtime, at verification time it augments
the raw BPF bytecode with type information (BTF or type inferred from attach
context) and does some execution-like things with the program, including
complaining if some function expects type X but gets type Y as input.

In this case "owning reference" and "non-owning reference" are distinct types
(owning has nonzero ref_obj_id) and the verifier rejects wrong type for kfunc
input based on this info alone. "graph-object ownership model" is responsible
for changing refs of one type to another.

Regardless, your broader point stands - "verifier type system" isn't commonly
used to describe this behavior, so I should phrase this better.

>> +
>> +However, pointer aliasing poses an issue for the above "nice property".
>> +Consider the following example:
>> +
>> +.. code-block:: c
> 
> Same here (newline)
> 
>> +        struct node_data *n, *m, *o, *p;
>> +        n = bpf_obj_new(typeof(*n));     /* 1 */
>> +
>> +        bpf_spin_lock(&lock);
>> +
>> +        bpf_rbtree_add(&tree, n);        /* 2 */
>> +        m = bpf_rbtree_first(&tree);     /* 3 */
>> +
>> +        o = bpf_rbtree_remove(&tree, n); /* 4 */
>> +        p = bpf_rbtree_remove(&tree, m); /* 5 */
>> +
>> +        bpf_spin_unlock(&lock);
>> +
>> +        bpf_obj_drop(o);
>> +        bpf_obj_drop(p); /* 6 */
> 
> Same here (newline)
> 
>> +----
>> +
>> +Assume tree is empty before this program runs. If we track verifier state
> 
> s/Assume tree,/Assume the tree
> 

ack

>> +changes here using numbers in above comments:
>> +
>> +  1) n is an owning reference
>> +  2) n is a non-owning reference, it's been added to the tree
>> +  3) n and m are non-owning references, they both point to the same node
>> +  4) o is an owning reference, n and m non-owning, all point to same node
>> +  5) o and p are owning, n and m non-owning, all point to the same node
>> +  6) a double-free has occurred, since o and p point to same node and o was
>> +     free'd in previous statement
>> +
>> +States 4 and 5 violate our "nice property", as there are non-owning refs to
>> +a node which is not in a rbtree. Statement 5 will try to remove a node which
>> +has already been removed as a result of this violation. State 6 is a dangerous
>> +double-free.
>> +
>> +At a minimum we should prevent state 6 from being possible. If we can't also
>> +prevent state 5 then we must abandon our "nice property" and check whether a
>> +node has already been removed at runtime.
>> +
>> +We prevent both by generalizing the "invalidate non-owning references" behavior
>> +of ``bpf_spin_unlock`` and doing similar invalidation after
>> +``bpf_rbtree_remove``. The logic here being that any graph API kfunc which:
>> +
>> +  * takes an arbitrary node argument
>> +  * removes it from the datastructure
>> +  * returns an owning reference to the removed node
>> +
>> +May result in a state where some other non-owning reference points to the same
>> +node. So ``remove``-type kfuncs must be considered a non-owning reference
>> +invalidation point as well.
> 
> Could you please also add the new kfunc flags that signal this to
> Documentation/bpf/kfuncs.rst?
> 

ack

>> diff --git a/Documentation/bpf/other.rst b/Documentation/bpf/other.rst
>> index 3d61963403b4..7e6b12018802 100644
>> --- a/Documentation/bpf/other.rst
>> +++ b/Documentation/bpf/other.rst
>> @@ -6,4 +6,5 @@ Other
>>     :maxdepth: 1
>>  
>>     ringbuf
>> -   llvm_reloc
>> \ No newline at end of file
>> +   llvm_reloc
>> +   graph_ds_impl
>> -- 
>> 2.30.2
>>
