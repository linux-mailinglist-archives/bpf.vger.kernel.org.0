Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78FF6572DF
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 05:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiL1EwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 23:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiL1EvM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 23:51:12 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBC5E081
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 20:49:52 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BS1WAEF009368;
        Tue, 27 Dec 2022 20:49:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=uQu6aNJ4pwZdrIyw1nbY8YAVRPtRbHbCFPyYSA6pBiE=;
 b=ljgD16jp45LzoHRLsnY5s0mckRPZMV9YMMaTE7kGFiMw1zQfI0aFVi0PS5FayPO1jrQw
 wxnDRU+9tz4uZtNyGA04m/NXL3vsx0odiI3srhBjyQJByD8p2uTDaLvDT7ticefJf9qL
 8KMcrjMw9+3E33psR/3wi0K/7T9pgH2FTrtUZvryi9iDKoUWEg7gKK1fahydG43JOMd7
 PJu56ctjd8iMvj9ALZ3yAfwcfzHWEa52NtvysbMvAxphaNgr33WcTC/uL09UMa59lmRt
 +YK4wchyQQxAbI8DJDA3hoXZX/XY04ng14xEVamT5tEbvzvlDTKHnYSL5mcS1kXNHIjG 6Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mp1ma0y5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 20:49:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g13peuKpPpBsugkJp2YGmR9WI9+izr8T7Q7yNfA3Z2tEWJ6MUAF7TuWuYKjBgH8yPgJB/9y5SB5I5L0cEdWDxqJWL5+E0ggqy3n7hFlPa0fvvG2+/Q+VTUhdUIqQ9JbUzieAdbaphgdCvoi3vCgTo5Gi7v07XvQ/f14MXho5Sl347VHhBICLNA+vgEqBlj9hWc9WZcj3ZNugkFC0fARHG+LCHSkdjxTIyM8wgtcVQ/gQwaAlMng0w4KZeErybP38qoMZL3FJQprnxCKcoXaltHMxw+BW9q4aXLQ8yoLbbLe/tu6yJWUWU1OB+8owN51MqAStuYsGPW7KaF9bpTOhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQu6aNJ4pwZdrIyw1nbY8YAVRPtRbHbCFPyYSA6pBiE=;
 b=NaVsFKamar56mhOORauQy7tPtZ4dj9jLkDjX/BP0ngakCVkB2pKRUUzaKzZuku0/lsk9EaLirodM+4m6AApiml4NWB/4wOmPZZnp0TdU2BrX31bFOpqy+GUTllzJvYN9iwyJ2KXwdsmYdmJZik9xYGZAJvwn6X+CxIH2Cz69J58VX47wwjxZrzCy2iTvdzS0atvvwceL9xShUPDBxlXl7m2vN13vZRvKRRFobN+Fpd+FjWmezas33KyCKc9+6uGCMhOOnJLeYCxJyCjRE/TNUyHY8DJtTN5wzfBKD8VvD2if38j6KRB8aMVZ7y+yU71aUpjbkbBmQrca/nN+JZluDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5129.namprd15.prod.outlook.com (2603:10b6:a03:421::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 28 Dec
 2022 04:49:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 04:49:34 +0000
Message-ID: <c56183d3-7d75-af03-321e-8ccffafdd1ab@meta.com>
Date:   Tue, 27 Dec 2022 20:49:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Follow up from the btf_type_tag discussion in the BPF office
 hours
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf@vger.kernel.org, david.faust@oracle.com,
        elena.zannoni@oracle.com, David Malcolm <dmalcolm@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <87o7s4ece1.fsf@oracle.com>
 <757e5dde-75ed-80e2-9a34-ff7c2259de78@meta.com> <87h6xrfgmz.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87h6xrfgmz.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: ae870693-e80e-4bd0-207a-08dae88eea30
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofg/sjudLkfRC04SYqwP5/5Xu1BzFVSC5Pf9RLi+/cG3ICMTcLG2pZMfjwDe2Yye+3/fyOAalGBVVHx+I0wymicq49lB82P4xq/qZD9P5+U0jDihEIivekMFEr9TvsjFLWd3po6lcoVorLLEGcScSr6g02PvY+kjPiF7AfKD12KJUTEE63kGRurAYawRL9Tak+86ISvGw5iwpOAMQav9ymT2KZJ0rIZqZkqiOPMDywRy7Xi5eh6Kyqdfvq5RASrncBb+ojCohWKYt97haBazbgmlgacJSLqYbvAMk8nmVeUdjx/Fy8+pAjL49+1FKBCdYtRCovbkIajLGk0gIG9/5WknmYbTk3ajJkBUs9GUubMN6pfZprDwHXFUG+KXjKlQ7HybWnhA89lW9isKfBRjhr5LzUR3XE1TG+8JujHbfSIu8pSTLUGbnlufS07XUoB/UosbnmuXuw6FGfmqKL5h4kbJFf8kRsqP1pYzFO792u/WnnYkKBpJJeH0MzIubV09PSaL98AwYN8KpZtZ5F6BV1Hie8D1AuxveeFt6bPtJR5gmP+guFIuCOnJpowVQewyxz5iyRKmWBwr5eAYqPIWG8RK5+ryJcI+hTr7//8KPaHFHfhkqz4y2dRCxtNBpHoCtz0Gb8sr7WT910pcFDESH51jpESgfZD+geSddFha9TmOLFhyiVQF2tOn08OR1JrlHL89vU5ADj1NwX7ZLbKTW6Hez9OxDdr64pkAaJrAZhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(31686004)(2616005)(5660300002)(6512007)(38100700002)(186003)(36756003)(66476007)(6506007)(53546011)(41300700001)(66946007)(66556008)(8936002)(478600001)(8676002)(6486002)(4326008)(316002)(66899015)(6666004)(6916009)(54906003)(2906002)(83380400001)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCtXd0EvejN1TmtZTENPbHVlT0dpVUtIOVZ4SlJGVURmdW9IV1hwYzhIbVNU?=
 =?utf-8?B?UGlGamQ2d2hzWU82WmJaUEhkZnBkOXhQbGYza1VRVXV0MDBBdVExWW5BQzdt?=
 =?utf-8?B?dzlaYW9wVyt4YmlhalRBV0JrcVQ3ZmxPclZ0T0EzQmhzaTJMTlE5b2Z2emxk?=
 =?utf-8?B?YzlYaldScm1YWjk3WWIyMk5wYVl1clNMT2dPbzFIZ2swYW5mc1ZiVGJMeU9k?=
 =?utf-8?B?R0JPRUlLTEJMQ3JtZjlXVGVvTlFoL0MzRmNZckdZSUdwK0dVRkxVQzYxSlVV?=
 =?utf-8?B?UldUMDZWOGtaaG9INFVBMlBsOEdtU1BtZm55OG1wRnNBZ0NqL3k0UTZNblhT?=
 =?utf-8?B?TXI0ZnRtNWwxU1FVSys1NUVPZnQwVFpES1Bzc1poSVdXUnFCTnBDS003cjZk?=
 =?utf-8?B?S0locnUwZDdSYm9lU0Q5dUJwbU51MlVzcHV5aHFVTk13VWxmZ2xnaVZWMnR0?=
 =?utf-8?B?N3FLMGV5dUJOY2NydmljS1RSZWRDTVlpRU9TbTJ1bWpQWjFRdHFLVDMxaGtq?=
 =?utf-8?B?RWZhUFJwbVV4UGZUVjlZQUdoTTgxNFI3akNvSVp1SGxYTWNPZ2o4amMySGp6?=
 =?utf-8?B?c3d4WSthQWZ5b2xKT0toM2ovR2RCZUJiaG9wSitHeDZGUEtFcTVydnBOVE9h?=
 =?utf-8?B?YitiaDV6SlpXV0FtdGNkZ3ZZdXZETk5BdjNTd1N2aHVCN05qaW5jZ1BBVGNM?=
 =?utf-8?B?NmgzTGVZVHdNNGdOOHJqMFBzK2hkV0M0VnJFWVpVNXh2UHFTcm9uTG14c2da?=
 =?utf-8?B?WTVPQTZXZ3BNK3BkdGU3aW5zdFg2L21yT3ppYmtGVHVuRXB6Z3VBVXVWVDRr?=
 =?utf-8?B?TDdBTHFZQ2c3MkNIbGhHV1owWGFoNmJ4akdqdE50Q1NLUDkxMG9oREpVOG1a?=
 =?utf-8?B?VzdCOU80VlNuQTk0M0lXbUhBQVJJY3RLUW9JQS9zZkdHT2crV2tlY3g4V2JP?=
 =?utf-8?B?YkJtcXUrTlZWTzBuSGlaVXRMMFFBVVBNdnhiSU10Rkk1UW9LTTgyY2JmN3Nv?=
 =?utf-8?B?aEh5eEJSZHIveGRDRGoyZk4xeHRyVjlCR0NNNmdZdHFKaVQxSGUzNE9BdFVv?=
 =?utf-8?B?eTF0TzdUSzZGc3VhVHRPaDBQdlFHVXI5SE8wbXF1VGo2NUVZY1k2VGZXS0dh?=
 =?utf-8?B?MkhwTFh2SG5MVmNVUjJ2bWRvMkhTbU9LMTNCKytkcURRb0F2TFBlcmdhZVlM?=
 =?utf-8?B?Z3NSdzdqK01zM0l6MEcwTmR0TnVIV1dSR1U4Yk9Ia2V5OHpDbGYzVERBUW83?=
 =?utf-8?B?Qk9VbWRPYU1OS3pPRFpSc0RHVlVlZ0pvOEZtelNpSDc1eVlaRytSNDYwRFVF?=
 =?utf-8?B?N3lpN3NVY3NBRHBiMCtJajQyS3F4VXVyZEdQQWZCbS9mcGRzbHhnNjg1T1RS?=
 =?utf-8?B?aE91YTRpRGlETVRZZHg2NEhNdm1VRGVNQVcyL0g0WDl4d0pFNjNLbXhNcjJY?=
 =?utf-8?B?TU9WakpXN3p4dkZ2dmZxTjV1QW4vQnk4bk41TzFiVWJIREgxVTRjQjY4aHB3?=
 =?utf-8?B?UHQrQzEvcEdjWUxvVGV4ZFJpZmV6OUdkZnUzUDJiMXdjd1RPK0ZtU0NxTWZW?=
 =?utf-8?B?a0gwUFlCbGkzVW82VUp4NGE0ZU4rZ2R3SUdoRkQwZE5rbmo5aEtEY211Sk9k?=
 =?utf-8?B?U2FxM1VIeHBsb2FFSlordk5EeG83U3JWeXFvcy9LRFNLQzc5QVlYbmFuT3Av?=
 =?utf-8?B?SkdyOE5yQTlPQm9Ld2VxelgxTDJOc0lqNDNIdjZBV1FYNXd2bFY2eldjQWgv?=
 =?utf-8?B?UGZOTVlsSG5EZnhZU3V5bDgwRWJvRndFdjNnTFhCMWpKZ25sSVg3YzlnNk1G?=
 =?utf-8?B?ck9zakRwbXNtQzZCMXZ2UDdmTmJXaENoOXZXLys0MDZUR0ZmR1kvVEVCYXd2?=
 =?utf-8?B?K2hmcWlRclpCWE40UzVaN0pFUDlLUUpYcm1RcDl6Q1FWNGRDMTRwZ2J6U2tJ?=
 =?utf-8?B?Y3pCZlQ4eGRpRzVEUEU3dVdGRXEzRWNTU29Oajg4bDBHdmYrOFZBalJRQks2?=
 =?utf-8?B?aHZLU2JkRkR4cnU4N2FEeWJpeHFtbUdPSHJKNzMvMmJuZnlXYmRqYkNRbGpm?=
 =?utf-8?B?RVMzZGVaR2dDMlpOcmpNL1JwdXhISjE0dmhuejdwdGlRTHV5NkxGeU9JdjBj?=
 =?utf-8?B?a1p6UXBBbWJvQlMzMXNQbzNXWm04VXBIR2YyYkRNUEpGS2tKVmVnTVJzUHRi?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae870693-e80e-4bd0-207a-08dae88eea30
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 04:49:33.9931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VQ5+Rcs1c+jPZ4VXgUxRnGS9NkDwtCCMJFOhqtVy3iWVSI1DBJ7obmjbtb8Yw2q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5129
X-Proofpoint-GUID: mAkZpmx56LRx1lX3Rem0_TMW8RPpqWIG
X-Proofpoint-ORIG-GUID: mAkZpmx56LRx1lX3Rem0_TMW8RPpqWIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_02,2022-12-27_01,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/19/22 9:27 AM, Jose E. Marchesi wrote:
> 
> Hi Yonghong.
> 
>> On 12/15/22 10:43 AM, Jose E. Marchesi wrote:
>>> Of the two problems discussed:
>>> 1. DW_TAG_LLVM_annotation not being able to denote annotations to
>>>      non-pointed based types.  clang currently ignores these instances.
>>>      We discussed two possible options to deal with this:
>>>      1.1 To continue ignoring these cases in the front-end, keep the dwarf
>>>          expressiveness limitation, and document it.
>>>      1.2 To change DW_TAG_LLVM_annotation so it behaves like a qualifier
>>>          DIE (like const, volatile, etc.) so it can apply to any type.
>>
>> Thanks for the detailed update. Yes, we do want to __tag behaving like
>> a qualifier.
>>
>> Today clang only support 'base_type <type_tag> *' style of code.
>> But we are open to support non-pointer style of tagging like
>> 'base_type <type_tag> global_var'. Because of this, the following
>> dwarf output should be adopted:
>>     C: int __tag1 * __tag2 * p;
>>     dwarf: ptr -> __tag2 --> ptr -> __tag1 -> int
>> or
>>     C: int __tag1 g;
>>     dwarf: var_g -> __tag1 --> int
>>
>> The above format *might* require particular dwarf tools to add support
>> for __tag attribute. But I think it is a good thing in the long run
>> esp. if we might add support to non-pointer types. In current
>> implementation, dwarf tools can simply ignore the children of ptr
>> which they may already do it.
> 
> I wonder, since these annotations are atomic, is there a reason for not
> using an attribute instead of a DIE tag?  Something like DW_AT_annotation.

Yes, we can. My suggestion is to facilitate gcc implementation. 
Currently clang uses an attribute instead of a DIE tag. I am totally 
fine if gcc uses the same dwarf representation mechanism as clang.

> 
> The attribute could then be used by any DIE (declaration, type, ...) and
> existing DWARF consumers that don't support the new attribute would
> happily just ignore it.

clang already use attributes to represent btf_type_tag and btf_decl_tag.
One of early considerations to use attribute in clang indeed is to avoid 
existing tool changes as much as possible.
