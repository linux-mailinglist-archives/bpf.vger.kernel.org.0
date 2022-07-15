Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C7575B65
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 08:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiGOGQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 02:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiGOGPl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 02:15:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0FB62CE
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 23:13:44 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ENcbRN009948;
        Thu, 14 Jul 2022 23:13:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=n3N8RNsQFdbS7jsRf9g0yHrxI6QVKMT8aBxUeNpn4iI=;
 b=B4tNwhW8AfYnfR7cCmw0nrv80970TT3S4QPwxYdihI2j77yWAXajv2GPHvIWXGPIOilr
 2/xRwhrcdcdNYLWOxQAXHVCKUF0c4SwKRhIHysmasuW1YngTU+aBSRUnb7ChuNOjY3O5
 VX/FSW2vHV3XBdOb3jUR71oHQsZxGQKEbBo= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hae0w731d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 23:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw+Nw9GNu3cP4HXz+24aNxrY1uuTuMypYvb4wAAOny06rQdy6AIjUOZz+XuU9MQfggN14PKBdnxzfGXhjbrkGoFuUuQl7EF+vXwXO5j4twmgTyS7FHM6afzz8Xm/T36H3B5BGx6xE0xhEpJkp0iFRzcF47U2sn5btalc5v8saIi6T+8I8S1hLaT1CHbGFWk5ZBNRLe0hlhiGy3gSzlTqV3E+Bh9bOttZgKEDyw0hxbKKrofbvjdMC/nFhDWaERicjWDad1y2m8tZrovEHk7vt1wE/qVhIMdU+BIrAIZJ/T/mN4AHxtVkBMpWpN8xpe/Z079cEsx7VzablnnW1ou9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3N8RNsQFdbS7jsRf9g0yHrxI6QVKMT8aBxUeNpn4iI=;
 b=R4o7OUOkCLcyhSeqWOAwrXSISH0+Todx/b5h61R3NFTP3Ty+idK8DwA/OSDctXdAgGNsIw8Cdbv/OvluQUij5ev7zOsiIxFA8/eaO6lcuZie5yka4ypUwej/W7EcwIiPZskZE9Q4xaKWcByr7m0eIHieVCaCqD8YyeXWso0yKmCkhKZyTDhvn7ZiDlAE+PRKk+A7tmKQRJwsIAxIzth+J7YHJ7J4pLQQBWEU9bxjVj6YQ8vk7xxc+kv0KpYwalc9NRynL50CZZVKCzCZF2ajmuLGarki7sDtccXsGx5TlgyMFT9VkLXocJF3a6CjiLGKK/8dvbE3YseI2B/Qa8HLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY5PR15MB3730.namprd15.prod.outlook.com (2603:10b6:a03:1b5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 06:13:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 06:13:01 +0000
Message-ID: <17dbbee6-f7d1-0e8d-ddf6-d713eda5b498@fb.com>
Date:   Thu, 14 Jul 2022 23:12:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] libbpf: fallback to tracefs mount point if
 debugfs is not mounted
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Connor O'Brien <connoro@google.com>
References: <20220714232143.3728834-1-andrii@kernel.org>
 <fc3dfc6c-25f8-a7a5-7ec1-b929712ed9b5@fb.com>
 <CAEf4BzZHmyN5vweCNWJq=GnqGT6T0CfP7QxAHNTOoe5TJB3o-g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZHmyN5vweCNWJq=GnqGT6T0CfP7QxAHNTOoe5TJB3o-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:a03:255::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0234161d-8a8c-466a-33a5-08da66291273
X-MS-TrafficTypeDiagnostic: BY5PR15MB3730:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5IcS/wnG9Nd8EshV2yBA5MBCzMa+7cptLGQNnS4EpFYdroGtw8wQNnP/luU6IWDAB7ifT5nHEYLq2bu6hfMbwCtikcZ6dS6sYHFa4SYXrttNO8kyLF01Gvab998Xs40Efjj3+S5nxsLaqw9rrFFbGHc4d8Iu6i5mM/s8DdD11GJGXq6ChpOp8CUc7s5gp5MX2F3wbC7/u1T9+x1gJfDxLUDt922T7tE0BQtzDYNX3fvD1sD0/Wl/MFgSggCyHyIlh2iEp1zUb5gb6alT2C9XnSGG6R66Oogt03RLMUnqC66hFlzdXJ27L0z6z/hPd4TTzNdETl5RP5vSTwu1vAWd0opXoIWz5mvLQYGaRlXK3oift1KULYuIlHPjycQmNvKHSYItr+mQxTwm7wPhaiS5vqLth8phEDTA5YDa+m8KYqNlZZBQ9rF8C+q6+6/ROEdpFkcwSV/5LgahM6WnFCXTqeHdf/obfqPiF2Qo4T4jIFNmfJI1nFTrO0hT+zFwgpfcpwZtMEBQ9uAcS4xFwLBl+GJBPP2HE3twXnnOiBGJuuVLNHRA3oIfDDxsclvADPgiAuB+kpis8hMKUFmwUoin27kOi2fBL8OKiFmmcA9Ujddq/c0XavbDzKFA1hoQI29z2PBLCl7kuruDPP96LnEnPivQHKfo9zhXEA243mVStbdJW3lZDmjsO90rwoOTzaTQeB5flks+Pcx/bOKausofa1C/mcxjoX3fKY6FrkvfSg/mNA4CvCnhLhoDEZr8r33QY2O5sA+E30Xnud0bHUrI69V+qYbawf/ZEP5wlZCjIALxf/D/ey3fBXTOlxhIibZOrKhYEEVPRc25DNFJL84jFgejhE0x4dPBOkHmtBLOKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(2616005)(6512007)(6486002)(8676002)(2906002)(41300700001)(31696002)(86362001)(66476007)(83380400001)(5660300002)(186003)(53546011)(478600001)(6506007)(54906003)(6916009)(31686004)(316002)(4326008)(36756003)(66946007)(38100700002)(8936002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1dnQmZ1R25qUGhzQ2dzajFzK1A2OGJFcDB3amF5dCs0Zkw1eGJaRHpPWk5r?=
 =?utf-8?B?M3YwcUU2QTFITTFVNTVyS1RWM3BMR1d1UVVNbnVJRnV4QWM4eWFFbWxsc25G?=
 =?utf-8?B?R2M5QjQ4K0FPZHZUSnpKL3dmK2MxL3lnZG45aDhzbEF0RHgrcW03L0dzMmM3?=
 =?utf-8?B?d25iQVVuald4UTc2YkR4a2I3bjIxWVVCME1VbHd2bEYycUpuZDgzNDFvVmF2?=
 =?utf-8?B?bm9qT3pNVVI5VHJsa0hyL3AvZEMwREFKWTUxNWZwbjAwQlRUSnpzQ2Rxdnh2?=
 =?utf-8?B?a1FRbXFBcXBENHowZzdWdXdTSERtK2xJN1N3aWFzenFpNzFmUEF4VTFGeFJ5?=
 =?utf-8?B?aGlEcXV0dlFCTmMySTFLT0ltQ25MNlBGMlhkUWdlWXlQY3dCUnRHTjJ3Uzgv?=
 =?utf-8?B?Mm1KYzFpb2oxWDJZS3ZZanNwVEd6b3dWS2Y0ZkY4dVQ3L2YweGZqVTQ0dnZF?=
 =?utf-8?B?VUMzMklSTW56eFRjQktueituTks2K2NIR0xHaTQxWFRPV05GbnJZU29taUxt?=
 =?utf-8?B?T2grc1Z2aHBnbFo1QkgyUEoxTjVkanErMDgvOFRsTzhKQmxXdG9oTlBXRXds?=
 =?utf-8?B?SVZwMTZSQTZZK1hLTnAzSVVkdTA3YjlPczZ6TlFWSWt3ekVZblJGL1BvQ2J5?=
 =?utf-8?B?V0xxSVlhbWJmV1E1dG1lQmVQWXNrWTJ6MHlhcGJIZ2NpYnJLYURERG5CNWpD?=
 =?utf-8?B?OTdZQUtFOHJlOXdsc3pvcHBvWm1IWDEveDlGYjk4U01ISWUvQmtDdXdscXJ1?=
 =?utf-8?B?ZE0zNDk4K1VhY25jZTRCTmY3Z2ZDZi9YbmcyRjdUM0hDN2RxMi9PeDd0bDlE?=
 =?utf-8?B?dmxpanBNclBqUmEwYXNKZnBsWDBLMzVyMnQ4cVMyd3BJYzRGWm4vdWRyMXdD?=
 =?utf-8?B?ZVFvelJ2U2NoWFZpVXUzazUyYUxXRk02b3dQb2tSVkJNUE9qeGlYdGxlZ2M4?=
 =?utf-8?B?NlJNb2FlaFVXRUJMU29UZmNZeXVQcXh1VnlpMkZsam5XU0VPclNBemhDQTRo?=
 =?utf-8?B?RDVJelNFd3QwNnFINUkwa28zdk1yRC9XaysvYUk2ZkVqSlVZSDJPNnRWYUdL?=
 =?utf-8?B?NGluZnlTUUZnV0UydkxMeml2YWJaSDNxODhpYmZlYkErK0hBNTkxMmIrRnNC?=
 =?utf-8?B?ZTFvU2VBZ2FPVWRMQWhBM3U4Ti9uZ2lSN095QVN1UjZXTkJOVEZhV2lFZFp0?=
 =?utf-8?B?UHdZMllvU1UvZFZLLzcxaWFaZXNKaGVQRW42YzhMUmtmVU5idjFwWEEvNjhp?=
 =?utf-8?B?aU43QnlPb1F2SHBFbUVpWHNTRDNKc0xSYnZDMjE0alpBTmxPVGVDT0JJSnl4?=
 =?utf-8?B?RWkwU1pMTk1MT3RSWGYrN3Bkbzh4ZWhKNUhraXRmRWpFTzNNNWs5U0QzeGhq?=
 =?utf-8?B?NG0xN2gzL3ZhUGVFVWR6M2tJcFVXakhCNVJpTDFhQ1RSZ1dqVFFWMjNIWW14?=
 =?utf-8?B?Qmo2L0tVMXQ5YmZEUnpHQkVEWE05L09pMGoybHVscGtNZ1h2aG1xVVhreENz?=
 =?utf-8?B?dHl3WEhuSWNrK3hsaStFM0tzQjRScUxvc3c0VFpuUEdrT0lGT2dnZVBXOU9X?=
 =?utf-8?B?ek5QdTBmTVowT01tN2hQL2FxUndBbHltQUc0TkVEbFFQUmtudG9PWDJhNm5r?=
 =?utf-8?B?WXpTWFY1VXJLSVBHNlB6Y0Rjdmg5R0x1d3haQmdqSlBkSjMyTVUyN1dSNDlE?=
 =?utf-8?B?bFB0UjZvanF4S0VKdktZTEVkaDdsekVhNlNJck1veFJ0UXpqNE95Sk9RdVJW?=
 =?utf-8?B?OHlrdU0rZUFzdm0wbE5iTW43bDkvRjBtMnc0eVNDN3ZsZ2k0T1BNMDhqYVJE?=
 =?utf-8?B?MHJNQUpGUWxYVVpPWjE5M29DMDlVY2ZvMGllTTRmYnVOdmltMkxSREdWRE9v?=
 =?utf-8?B?VDNGdDNhTEUrNFNKY1cwc3psN3NUVnJvUVF5YmdGSWM3YlM3ekRtejVRcFdi?=
 =?utf-8?B?cnhkbjc5ZEI4a3pwUUY3LzVyaW9vVGtmYWIrS2lpeWJKS3FieWM1aDdSb2cv?=
 =?utf-8?B?N1dYcE5ZTG9ZL2pWL3pHaER4QVZTQzFpZDJURmlVUlhBS2k4THdZcVN1QjFE?=
 =?utf-8?B?N3FXTG00V3VVRTdMY09uaktvbEVUSUFOMytSY2h3NUdEaUZOQVN4akNUUUZm?=
 =?utf-8?Q?sLbFU0/rvIJmZgawIJ4OvOSEk?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0234161d-8a8c-466a-33a5-08da66291273
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 06:13:01.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wM1j4E/+eStCoQv2D7KdpZeP5RFaIdAvLDObai48r825Z4wUQmQP9gbajW18kdcA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3730
X-Proofpoint-GUID: M5beFMB-VZ81PT_36cgHkbS5B25-tiTp
X-Proofpoint-ORIG-GUID: M5beFMB-VZ81PT_36cgHkbS5B25-tiTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/14/22 10:25 PM, Andrii Nakryiko wrote:
> On Thu, Jul 14, 2022 at 5:29 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 7/14/22 4:21 PM, Andrii Nakryiko wrote:
>>> Teach libbpf to fallback to tracefs mount point (/sys/kernel/tracing) if
>>> debugfs (/sys/kernel/debug/tracing) isn't mounted.
>>>
>>> Suggested-by: Connor O'Brien <connoro@google.com>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>
>> Ack with a few suggestions below.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>>> ---
>>>    tools/lib/bpf/libbpf.c | 33 +++++++++++++++++++++++----------
>>>    1 file changed, 23 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 68da1aca406c..4acdc174cc73 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -9828,6 +9828,19 @@ static int append_to_file(const char *file, const char *fmt, ...)
>>>        return err;
>>>    }
>>>
>>> +#define DEBUGFS "/sys/kernel/debug/tracing"
>>> +#define TRACEFS "/sys/kernel/tracing"
>>> +
>>> +static bool use_debugfs(void)
>>> +{
>>> +     static int has_debugfs = -1;
>>> +
>>> +     if (has_debugfs < 0)
>>> +             has_debugfs = access(DEBUGFS, F_OK) == 0;
>>> +
>>> +     return has_debugfs == 1;
>>> +}
>>> +
>>>    static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>>>                                         const char *kfunc_name, size_t offset)
>>>    {
>>> @@ -9840,7 +9853,7 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>>>    static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
>>>                                   const char *kfunc_name, size_t offset)
>>>    {
>>> -     const char *file = "/sys/kernel/debug/tracing/kprobe_events";
>>> +     const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
>>
>> I am wondering whether we can have a helper function to return
>>     use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events"
>> so use_debugfs() won't appear in add_kprobe_event_legacy() function.
>>
> 
> So I'm not sure what exactly you are proposing. We have 3 different
> paths involving DEBUGS/TRACEFS prefix: DEBUGFS/kprobe_events,
> DEBUGFS/uprobe_events, and "%s/events/%s/%s/id where first part is
> DEBUGFS/TRACEFS.
> 
> Are you proposing to add two extra helper functions effectively returning:
>    - use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events"
>    - use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events"
> 
> and leave the third case as is? That seems inconsistent, and extra
> function just makes it slightly harder to track what actual path is
> used.
> 
> In general, I've always argued for using such string constants inline
> without extra #defines and I'd love to be able to still do that, but
> this debugfs vs tracefs unfortunately means I can't do it. The current
> approach was the closest I could come up with. But at least I don't
> want to dig those even deeper unnecessarily into some extra helper
> funcs.

The following is what I mean (on top of your patch):

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4acdc174cc73..38cdeab1622d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9841,6 +9841,18 @@ static bool use_debugfs(void)
         return has_debugfs == 1;
  }

+static const char *kprobe_events_path(void) {
+       return use_debugfs() ? DEBUGFS"/kprobe_events" : 
TRACEFS"/kprobe_events";
+}
+
+static const char *uprobe_events_path(void) {
+       return use_debugfs() ? DEBUGFS"/uprobe_events" : 
TRACEFS"/uprobe_events";
+}
+
+static const char *tracefs_path(void) {
+       return use_debugfs() ? DEBUGFS : TRACEFS;
+}
+
  static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
                                          const char *kfunc_name, size_t 
offset)
  {
@@ -9853,7 +9865,7 @@ static void gen_kprobe_legacy_event_name(char 
*buf, size_t buf_sz,
  static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
                                    const char *kfunc_name, size_t offset)
  {
-       const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : 
TRACEFS"/kprobe_events";
+       const char *file = kprobe_events_path();

         return append_to_file(file, "%c:%s/%s %s+0x%zx",
                               retprobe ? 'r' : 'p',
@@ -9863,7 +9875,7 @@ static int add_kprobe_event_legacy(const char 
*probe_name, bool retprobe,

  static int remove_kprobe_event_legacy(const char *probe_name, bool 
retprobe)
  {
-       const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : 
TRACEFS"/kprobe_events";
+       const char *file = kprobe_events_path();

         return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes" 
: "kprobes", probe_name);
  }
@@ -9873,7 +9885,7 @@ static int determine_kprobe_perf_type_legacy(const 
char *probe_name, bool retpro
         char file[256];

         snprintf(file, sizeof(file), "%s/events/%s/%s/id",
-                use_debugfs() ? DEBUGFS : TRACEFS,
+                tracefs_path(),
                  retprobe ? "kretprobes" : "kprobes", probe_name);

         return parse_uint_from_file(file, "%d\n");
@@ -10226,7 +10238,7 @@ static void gen_uprobe_legacy_event_name(char 
*buf, size_t buf_sz,
  static inline int add_uprobe_event_legacy(const char *probe_name, bool 
retprobe,
                                           const char *binary_path, 
size_t offset)
  {
-       const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" : 
TRACEFS"/uprobe_events";
+       const char *file = uprobe_events_path();

         return append_to_file(file, "%c:%s/%s %s:0x%zx",
                               retprobe ? 'r' : 'p',
@@ -10236,7 +10248,7 @@ static inline int add_uprobe_event_legacy(const 
char *probe_name, bool retprobe,

  static inline int remove_uprobe_event_legacy(const char *probe_name, 
bool retprobe)
  {
-       const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" : 
TRACEFS"/uprobe_events";
+       const char *file = uprobe_events_path();

         return append_to_file(file, "-:%s/%s", retprobe ? "uretprobes" 
: "uprobes", probe_name);
  }
@@ -10246,7 +10258,7 @@ static int 
determine_uprobe_perf_type_legacy(const char *probe_name, bool retpro
         char file[512];

         snprintf(file, sizeof(file), "%s/events/%s/%s/id",
-                use_debugfs() ? DEBUGFS : TRACEFS,
+                tracefs_path(),
                  retprobe ? "uretprobes" : "uprobes", probe_name);

         return parse_uint_from_file(file, "%d\n");
@@ -10796,7 +10808,7 @@ static int determine_tracepoint_id(const char 
*tp_category,
         int ret;

         ret = snprintf(file, sizeof(file), "%s/events/%s/%s/id",
-                      use_debugfs() ? DEBUGFS : TRACEFS,
+                      tracefs_path(),
                        tp_category, tp_name);
         if (ret < 0)
                 return -errno;

The goal is to hide use_debugfs() from functions 
{add,remove)_kprobe_event_legacy and {add,remove)_uprobe_event_legacy.
Previously I missed the different usage of kprobe/uprobe, so now my
approach has three (inlinable) static functions instead two.
I guess your current approach should be okay then. I have acked anyway.

> 
>>>
>>>        return append_to_file(file, "%c:%s/%s %s+0x%zx",
>>>                              retprobe ? 'r' : 'p',
>>> @@ -9850,7 +9863,7 @@ static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
>>>
>>>    static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
>>>    {
>>> -     const char *file = "/sys/kernel/debug/tracing/kprobe_events";
>>> +     const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
>>>
>>>        return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes" : "kprobes", probe_name);
>>>    }
>>> @@ -9859,8 +9872,8 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
>>>    {
>>>        char file[256];
>>>
>>> -     snprintf(file, sizeof(file),
>>> -              "/sys/kernel/debug/tracing/events/%s/%s/id",
>>> +     snprintf(file, sizeof(file), "%s/events/%s/%s/id",
>>> +              use_debugfs() ? DEBUGFS : TRACEFS,
>>
>> The same here, a helper function can hide the details of use_debugfs().
> 
> well here I can't hide just DEBUGFS/TRACEFS parts, or are you
> suggesting to move the entire snprintf() into a separate function? Not
> sure I see benefits of the latter, tbh.
> 
>>
>>>                 retprobe ? "kretprobes" : "kprobes", probe_name);
>>>
>>>        return parse_uint_from_file(file, "%d\n");
>>> @@ -10213,7 +10226,7 @@ static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
>>>    static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
>>>                                          const char *binary_path, size_t offset)
>>>    {
>>> -     const char *file = "/sys/kernel/debug/tracing/uprobe_events";
>>> +     const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
>>>
>>>        return append_to_file(file, "%c:%s/%s %s:0x%zx",
>>>                              retprobe ? 'r' : 'p',
>> [...]
