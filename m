Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD01C597C54
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 05:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiHRDlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 23:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiHRDlI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 23:41:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F64915C0
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 20:41:05 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27HNSqVR019902;
        Wed, 17 Aug 2022 20:40:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MVwFef46dKu12Vzr61RIxn2lI4UjPvcppocux5ykFPA=;
 b=UU7Pr4btEtESOrGpEvKGoWtKOEc54KhZyzqzwe8kzewqHcguPNb8UGrCeZNyFKylWAXY
 TCJkWRCiXL6zjO4OM6KrFNpB7N1ct1P6NLKu4dUTMkVlWTQOsMuhDR6j399oNHP9T9/w
 eYVeYev+meRVPo4+3dFlSKYEpLt3VXssYS8= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j0nph0497-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 20:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP2UMMDxlNsN9W9C7cuwwkoLKe2sJkpTiqk4FVN/IitorrX0vN46RVQM7KdOynS3DBnjJXRJnM4KFgdb6UdnFUlp4wKckHycZ/X0GFzHlzWYL4TiCj+epM56kIpy1KpQYpJIEtS82in7jzMm7JGkB4/UAoFtOXEKZ4AXpqPDYVUR2UfR76cSGu4EpAKiA/JltyVrf+XupQJRUrmy+2/6qO80Cbllu38PPvCm7B/VFIs2Bu38qpEznKllvgPmzo2ryAkM9SDZVH7ExnCe/pTI5ZTj56tdQNVSrvOjbw/opDM9uS3fnSpoUE4EjFW2mumsVwD0UWHQMTAGVx0hgk1+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVwFef46dKu12Vzr61RIxn2lI4UjPvcppocux5ykFPA=;
 b=XoXkONX+chkPNRzqkg1o1uM9qc4QGC0iTAj03jasKa67zLz3d2VoXLqOrX2JX/EE32qzoN14ymbZ2rtp2lNnUWcJB6B7u7/wg+KS1L9r0hWBZYwAsE49td8I8IFO+DAVrV9t1fFEFFw/L6n1vnbwsV2ql2yqCfEt6UpoBgavVJYhrZgDcjc4HGoVm9P7H1DSFdkhlzMtPasRoHjji7ZNs7H0LaIc8/pJsFBuNSMOsKPdT7Fqv6o4ylfVudJGr0YsXtG8OOX3slDmSq0h7JwjlCL2M1dEJWZBHPI2QEvH3uJaoZ4/f+Tu5TklVpeCAOwiAMdGq7VVODBSgQKXb+wpCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1147.namprd15.prod.outlook.com (2603:10b6:3:bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Thu, 18 Aug
 2022 03:40:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Thu, 18 Aug 2022
 03:40:44 +0000
Message-ID: <545f5e3b-b8f6-dfc4-5833-b44a61766e9b@fb.com>
Date:   Wed, 17 Aug 2022 20:40:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220811001654.1316689-1-kuifeng@fb.com>
 <20220811001654.1316689-2-kuifeng@fb.com>
 <0f5123dc-5334-7e23-e143-c82002762242@fb.com>
 <CAEf4BzYsKaFJHPn2uDz+xLGWLz5BFi5Q9ESDffbVXetZbiC5fA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzYsKaFJHPn2uDz+xLGWLz5BFi5Q9ESDffbVXetZbiC5fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95786d81-0923-4130-8737-08da80cb6e73
X-MS-TrafficTypeDiagnostic: DM5PR15MB1147:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJ1yxgrT6LfcBXCmFmsXuvq88QeVF4L+rDm7dNErglgGB5UxnFtD9KGc6XFA2fa/Kjfuk4/gzu36+sZYlmuQ57YoK6+AYxXaSO82PPTgFgUUJcFcDClLleejmhamKV9hh9MhomO9+4JycNdD5q6zfTpD4205QMLMqB7PJwhvuA67XKLbUHu238netsk8SQFeXPaTSVTC8P8VspgTIGC32k02Dk2ZYLXjggD7L8JUptZ8FsuGsnnT11MQfXdpVHV4RfehsOD2GgKg+n011sJ00IJWHMugUdL7Sam2r6XM5N8HOA+/Xf7CKsv20um9wGpLva3rvsxWpu0yhGroOPpT1TZoti6Q2SrkcvBrSqBEdL1ZQMZftHnJ7DujfGUtRSq3jPZdLbVfbTpWZwbUnJsbt1fUTdDETi72BObiO86O2W/bai2qe4LRzW7cNFOIhV5lELNi1rMMhucvt7LnGm2pa0V87vo82PABRDNWdGF2DZMDMLkTFtF/kb7xpj0AuZk8OLRuqFWAaQ3p4STQsmKjo1WqlD18aru8Zcwhvb3Uc0VKJUX6PqEHO1PmxuL9mDhQo4WVb0cBIaesObmc5uNIireMigZcIxvdlG1zoOaCKm6/eU0RbUfnqfmYUyuCcCwGbf88fjTxyf00sHprZ6Jr6gpF3n4C3YYsc8CSmCcfQg/BnEtJTp+Ziia9StPdzAZ3LuITJKigx61HZcMhi4g2r7LMg7jkF8LYXVHkCeImQl4/xNanvBCaPUbMCMpAl+OdKUHKbY4P3LM7JGIYzyEc3A2UZLXL4mkC3svR041SdKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(31686004)(186003)(6512007)(2616005)(8936002)(5660300002)(83380400001)(38100700002)(6506007)(8676002)(316002)(66946007)(66476007)(2906002)(478600001)(4326008)(36756003)(31696002)(6486002)(66556008)(53546011)(86362001)(41300700001)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25ublFSUExSOStaRm1ZcjRPalNjRDBnRGJzRzVQNGcyNHVhME1FV2EzVmpG?=
 =?utf-8?B?TzdzYVRxbGl5dk55NTYvMTI2R3VCMmJoclRxZTdwTkI2a2h6emhZeExTNkFB?=
 =?utf-8?B?anNPVlc4ZEVPbHdOMFFhT2FDUnB2VXhPcUU2NllCK2RpdE0rcmJ6amo1NnRr?=
 =?utf-8?B?ZUt1S0JZbGtzb0h3bGI1YnB0VVlXbmhmbEJ1U3d1QzFDZFJUQmo0b2QwU0Zz?=
 =?utf-8?B?TWg2WFE4Y1lyQlJuV1p2TjN5MXJESWpJWFdxMlV4TFQrY3E0aU9taGFhM3Mr?=
 =?utf-8?B?UXZVbmtrUG94UGYyUWVkRWsvQjFJRTlHTHdaNU83M0QxbjJxekVkN253M3Yy?=
 =?utf-8?B?WUwwTDJvaXZzVG8zSkE4RlpGc0dnWUxhSmpQUndiaEhTRkxPYkhualBpOGRX?=
 =?utf-8?B?eC9aWkZDaWtBZzR4dHhCd2ZpMldTWUxCN1dQTlZWdVdubDBXK25PSVZlUzBQ?=
 =?utf-8?B?MDZaNDlkNDl1N0doWkJGczhVSUhPb01GaUExSTRZUHIyWHIxU0hoU3BKdDcz?=
 =?utf-8?B?cmF5NDdFRXJSTGNKTFQ1czIwcFc4bmZLRkdmK3kyUVJHWlFpbDBIZk9IMk0y?=
 =?utf-8?B?a29lRDdBb1hZclhLSUdLWUJuQU5tQXBGNTFkOGZCSWxid1dVdjNQSkdIaFFa?=
 =?utf-8?B?M0JwQXVpRjlHRHdXS2VQQ3ZDd09sek94ZHhYK1QrV2d2ZG9xWDJnQXFkRUJo?=
 =?utf-8?B?bjhMNnI4bVk0RFNpWVNqeDJaQXB0Q255NitJR2E4aVAyZkkvMktWRCsvdUNZ?=
 =?utf-8?B?c2l6ajluQUkvS1JjSGtHbHUvc0NLOWJQbUdLcG9LT2VGUVlONHRZSC83dzd2?=
 =?utf-8?B?Z0RCVWRsU2JiRUZoOU95ZmU1cDZka1pScEJDRkFHODdTbmhucmlUWStPT01t?=
 =?utf-8?B?UG9ibzk2ZlJZenRFbkRKTXlsWjFqUXlHY3c3L2VCM0Q5Z2hpM3pjLytjTFc1?=
 =?utf-8?B?RFpLcTVRS0xLb0ZIOVlBNk16MWlZbzB2S0VUeVhRNVdtYUZVT2dIUmcwbWFN?=
 =?utf-8?B?ZEx1YzBxaWgvdEkrWUJmTzhnY0d5MzI5RVJpU3lsL3JvdDlVOTZ6UDJjNEpa?=
 =?utf-8?B?bTg0TTZMS2ltNU83YnNwVzBBTTFPVWxweUtOYkZGK3hsNmwxNU00dXVlM0hJ?=
 =?utf-8?B?Mzd4ejFjY21jQ3d4M3pMNjYvT1VORzU4QlFibFFWcThHNVRKZ3djVExjeERG?=
 =?utf-8?B?MjNHNHVvRHZEYWZtQlpobWp0cG9jK3pkbVRER1dSUi94eCtpTFl3dmpBd25K?=
 =?utf-8?B?dVI3TlhUK2kyQzUyN042QXpPYjZDbUEwci9qV1lWS0J0S21ZSmVlaEUzekFw?=
 =?utf-8?B?aXd1bFEzMC9NVVFsTjFJNVNIV2ZUSCtqQ1J2YjBwaWdhOXNmL0l4Ukt2a2h3?=
 =?utf-8?B?QUJndmNiS2x2UzFxYk9rS29nZVBMTjZmQjNxeTZVN3F6ZldNR0JHWUJWeFlW?=
 =?utf-8?B?SEZqd0kzSmpzNk95c3RabllFY3RPVEZOYXluTHR5Qi9ranhkV3V3RDhNWkFi?=
 =?utf-8?B?TU1xUzB4T0pNUnhUNXorN09aS2xvVUxEcTVuZnhiZ3U4S3lPVHljaWpJQnAr?=
 =?utf-8?B?bUFVRGxRdDlPU1RqSFRkTStoTUJLaXRCd0ExUGxNTU5JVW0vMCtJWkIwZUhH?=
 =?utf-8?B?NlhBWEJwT29MM1I0NzhjUm54eHBYM2pUZkZGMFhJaHR1SzBTWnRjTFMzaml4?=
 =?utf-8?B?T3ZoTUhyTUl3aGtrYjkxZmVBanN6UU5YZjFNd1J0b0JvSEJLZzdUOGhrYi9D?=
 =?utf-8?B?dXdpdDJXd1BHZ3BWd3RlZGhTT1pQYlBlUFU5T3dlWldGcTRxR1JZb012ckVu?=
 =?utf-8?B?U0YwYW1vRG43Y0M2Qis2eWpOT0c1NjRFVFZvVU1RbmNKcXNnbzJTZ3JrV1lH?=
 =?utf-8?B?ZGFXY0wyM2loQ1NSNk5BOVNOaVZ0ZEp6dDlSS21BRms0YndaWXFMbWI1Rjg2?=
 =?utf-8?B?NUEyZWRjNzU1RStZY3R2SStub3ZTZ3pmVWJ1b3YxZ0FWNEZBb1VkekI1ejhq?=
 =?utf-8?B?V0k2VXBieWtsTTNVNHBtNmRBS0F1cVZFRGdCcVduKzFWQmI4bmNYR3BQUno5?=
 =?utf-8?B?K1M4RmxuUkxPSVNtcklnY0x0MEhsbUo5Q1ZOaVI5NUY5QXd5c3ZSSUtUZG9Z?=
 =?utf-8?Q?Rojqm1q5wd4yBKr7JPGHenquW?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95786d81-0923-4130-8737-08da80cb6e73
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 03:40:44.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+FVImHCLbZ+agPkrmsrtSBNBEdWUO9SXK8JMTSrwdaHSTcc+Ta4O7SgXkYyJySD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1147
X-Proofpoint-GUID: za8SDTPQrMpKB3kFLzd9VfzbeakW1OPz
X-Proofpoint-ORIG-GUID: za8SDTPQrMpKB3kFLzd9VfzbeakW1OPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/15/22 9:42 PM, Andrii Nakryiko wrote:
> On Sat, Aug 13, 2022 at 3:17 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 8/10/22 5:16 PM, Kui-Feng Lee wrote:
>>> Allow creating an iterator that loops through resources of one task/thread.
>>>
>>> People could only create iterators to loop through all resources of
>>> files, vma, and tasks in the system, even though they were interested
>>> in only the resources of a specific task or process.  Passing the
>>> additional parameters, people can now create an iterator to go
>>> through all resources or only the resources of a task.
>>>
>>> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
>>> ---
>>>    include/linux/bpf.h            |  29 ++++++++
>>>    include/uapi/linux/bpf.h       |   8 +++
>>>    kernel/bpf/task_iter.c         | 126 ++++++++++++++++++++++++++-------
>>>    tools/include/uapi/linux/bpf.h |   8 +++
>>>    4 files changed, 147 insertions(+), 24 deletions(-)
>>>
> 
> [...]
> 
>>> +     struct {
>>> +             __u32   tid;
>>> +             __u32   tgid;
>>> +             __u32   pid_fd;
>>
>> The above is a max of kernel and user space terminologies.
>> tid/pid are user space concept and tgid is a kernel space
>> concept.
>>
>> In bpf uapi header, we have
>>
>> struct bpf_pidns_info {
>>           __u32 pid;
>>           __u32 tgid;
>> };
>>
>> which uses kernel terminologies.
>>
>> So I suggest the bpf_iter_link_info.task can also
>> use pure kernel terminology pid/tgid/tgid_fd here.
> 
> Except tgid_fd is a made up terminology. It is called pidfd in
> documentation and even if pidfd gains add support for threads (tasks),
> it would still be created through pidfd_open() syscall, probably. So
> it seems better to stick to "pidfd" here.
> 
> As for pid/tgid precedent. Are we referring to
> bpf_get_current_pid_tgid() BPF helper and struct bpf_pidns_info? Those
> are kernel-side BPF helper and kernel-side auxiliary type to describe
> return results of another in-kernel helper, so I think it's a bit less
> relevant here to set a precedent.
> 
> On the other hand, if we look at user-space-facing perf_event
> subsystem UAPI, for example, it seems to be using pid/tid terminology
> (and so does getpid()/gettid() syscall, etc). So I wonder if for a
> user-space-facing API it's better to stick with user-space-facing
> terminology?

I don't have strong preferences here as long as all terminologies are
consistent. user-space-facing API is okay.

Currently, we only have pid_fd to traverse all tasks in a process.
Based on an early discussion, it is possible that
pidfd_open syscall might adapt to return a fd for a task
in the future if necessary.
So we might have tid_fd as well to traverse a single task.

> 
>>
>> Alternative, using pure user space terminology
>> can be tid/pid/pid_fd but seems the kernel terminology
>> might be better since we already have precedence.
>>
>>
>>> +     } task;
>>>    };
>>>
> 
> [...]
