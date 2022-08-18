Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F790597D88
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 06:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbiHREbk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 00:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243369AbiHREbj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 00:31:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB0A3D47
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 21:31:38 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27HNSr16010135;
        Wed, 17 Aug 2022 21:31:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=h0J8f5dbPKUynAYpgcBCZTIX4gkcoNrQ2k4C5HJ6q/o=;
 b=HO2M3ys51lDVaYmh/1Bb62Rnom+ZoHHyOsv1SvomgGp66aeqrkR2XUuj+0/c/DVlhXTd
 vhC/YSYishfrKjFY7lL/Y3WMrKWGYMpoDR55tcXgG7wvSqJVHJuGnqrCLq/mnrOa3u/2
 LW3aSSgeRGmpKnRlgw+/WQuqL6mLjKYcJM4= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j0nvjr77r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 21:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV+V2rzbcmTnxyCvrBSafkxW+OP4KglP1HjVyG5c3crnmYoQVghmnivObnwEcwMjPS8KsXapJwf3OsoCGbuHLJDPzAvUNJguYmEk4WpsCmUquDNjKuhVeb/fyUlu7zEgqKHlbKF7Z4dBZfMud+Z3Otb4qZI05RZbs9kkft/4IPTYwfFP8zmKM3nbvgOipJIEH3j2JOgxGOeQmJttfhJ1eYhlE5pzlK16Jc8Oi/1aaHZwAqjjEAef0NFoUXy1aur5XlGGym1gs1AM3s3sCmpnKDuWW1QOgNyyRSPdOMdpDtZZ/lqNkZ7q9uNB4JAoz1LH/ihmNeJmftXXH+OaB/bYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0J8f5dbPKUynAYpgcBCZTIX4gkcoNrQ2k4C5HJ6q/o=;
 b=F/G0XiFqO7N4XeIiX7mCQlCU4H4E7k0H4vhoIJ6KVOtCVS/WBjlPyEYTx+zf4RUMDEuSMiIXS7MpdoeAEFJ2NWNWuhP02VeVJMdcK6cbb18hGLEmSc+wvHivuzDHpnfSpZh2XAhCD7k6Y9rns0rDSR/utAcSi12BnyYKENrMeX1gzLYPKpRJe4z9dYa4l48uIOa7kfQ+dV88xXoEwYO0nk/WnsTLg4z99OXh2r8ii5rDK4diuLyR5d1Q9Veg2d7uVfOlqD7twXjTt/5g1OHZoR4Sygp5OVzxWQf/wrjA6UUYFie2OdNqn990hzUE62gf9E2zGtwMc0q7sWH7n4nJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB5116.namprd15.prod.outlook.com (2603:10b6:303:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 04:31:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Thu, 18 Aug 2022
 04:31:21 +0000
Message-ID: <c752a54f-d2e2-157e-778a-5b3f01bf5e6f@fb.com>
Date:   Wed, 17 Aug 2022 21:31:19 -0700
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
 <CAEf4BzaRK5hfuDP6HJXzCHfhuLZBF44z7RTzdEGQw54zTwrAaw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaRK5hfuDP6HJXzCHfhuLZBF44z7RTzdEGQw54zTwrAaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:74::48) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb5fb8cc-aab7-4862-e621-08da80d2803c
X-MS-TrafficTypeDiagnostic: CO1PR15MB5116:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RC6wrZZ6nPPu9DQSOTgadYy41UI/C3xH39eqToWrYInOg+O8JPWuhNH9xNXAM9QoaHz3eDqpbwenyY8qC71ZHbtI/VZZA7aZBg4ehmdB0SPCx19QQyMge8nv0W58sUX8Js8SjcltHNOmDObZnkAQX66albyRZU0l4+KQ5cjXhogzXFzkm9jMqDoAlM92M8zOmtXxukAS6jpXqRLKteGblWgpWQYvsR9RhDsFRsCjXS+bf40/UgyuWOyClJ0imQzUr8VNQuh1Jjq18++ue+5YcYJACLlMn67Z97lsmyBIlR4LGQ6PIvoLeisJGCwRBEii5vru4SnNdNfKFbOD8r/sGOpYfLHUDvf7peKwuKhXcVLHJypKb5+Q3UAJqR7ZNk3Wa01C0bP99IW4OvN39u8RBCdIt/dzqfvvNXo1xFH6THFkw3j1wFnShL8fUjrnyarDbFWdqalE08z/zWwd9jWAVTs5vj3nDUTBOntSrFkoKaHSNXdGngTvw+0qDACaEOa0o3RYdE0+sQawBFCmVyWrU5IlWCrPvlwizOQ0icJ7Wm5P6x3salH55BXAtOk5oz70Ela87nlZUrZpdUz2tjARbRdWj8tnn+fhElDP8vNGYL05AOEjj9GwM8q+zQertu1bZro4e6hXKS0hIUkGdIidajczIBLuzwRLrIhcfnAkVJz6ro08Z7CtROyJnZgYgvMmROiMNT/CSPTJ6Y/11UOXq7JVmkC4dCLj6qjkuFCtEU38ItSJ+nE+kX9FyVINl08naSf1wLyJ8P0thDfDcbmnW/YbJWESZm/4feghCSDN4UQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(86362001)(2616005)(186003)(31696002)(83380400001)(38100700002)(4326008)(8676002)(66556008)(66476007)(66946007)(31686004)(2906002)(36756003)(8936002)(5660300002)(478600001)(6486002)(41300700001)(6506007)(53546011)(316002)(6916009)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNpWDl0ZmlPSjZVd1JwZldPU1k5dStpMjFVQ3kxVFVBMU5vL1VZcXd5Ukln?=
 =?utf-8?B?Zk1sajZEKzFUc2p1YTNDVHRoam11bml1bWFTcER4VEkxNFhEV3JqdTl6ODVX?=
 =?utf-8?B?T2NPT1Y5V2t4WFpuWk1TcUtPWHZnTHN6MmtacXFpblpwRVhDV1BIU1VJZlds?=
 =?utf-8?B?UENMem9xZzBSVEI5Q3JpczMvalRHNmxCbnJUa1pNV1Z5SGh4Q1hjSUh4aDR1?=
 =?utf-8?B?L1ZkZTdrQzZ5VTJGSmVrSWNFVXVuaExsVEFhOHlnZzZwMXBYbFRRTnRSZDdJ?=
 =?utf-8?B?WHhLZUU2aFJiM241TEQ3aVFQZUN5UE9BOWwveVIyUzBoQk8vQmhTZmZ6VjhK?=
 =?utf-8?B?MU1YZVlzcGsrM25ZL29SbHMwMFNVTitjWkJWNytHN2p1eHl6Tlpxak51L0RQ?=
 =?utf-8?B?ckpIeUZZc1ZRR0lYQ29GMDdyS2d4c21iejhVM01LNkp5OW52b2U5Rm1JeEdv?=
 =?utf-8?B?SStuNTVXL2krNlVkSmEyVU1kOWp1Y28vTDFsRWt2TmZOZEwvSFhLdnhSeDFs?=
 =?utf-8?B?V1pQZEdFbWRIbFRXUDB4cnZuWnBnRkIxUXh2TExURU9LbzlBbyttTjZCNkw0?=
 =?utf-8?B?VGlQT3RJa3Z6NGJOdkNaRW9TZllaRnFmM3pBaXc0L1IrK1ZqMFg5MkVvdFpQ?=
 =?utf-8?B?RmlybWFWV2pKaXQ1Sk9mZkxGQWs0c2ZtdzUxQURQajhPNzd3b0Y3TEJFQ29n?=
 =?utf-8?B?cUp5MFQ0TXlDU3paQjNmOC8raGJMS0hrR1VvcXp0VUIyRi81dWsyTHQyOTJk?=
 =?utf-8?B?U3pETlFQaC9CK2pzNFlNN3lmTEluOTcvOExLQ2pCZzZqeTRPTUNHRWwyaDRU?=
 =?utf-8?B?RExlTFZvSlFUQVRKS2RFK3V0Nmg4SjFHODhZenJWMHd1L2paSkppSTViWkpZ?=
 =?utf-8?B?Y0xPbTVUOEJTR1dmQ2ZCeGpBT0wva2JKenQxcVpZMS9KWHRXa1lpRVgwT29C?=
 =?utf-8?B?UG5qWmhvWS8yZUtjWXZ4dVJIQ21uTEo1Z21aSVB1dGhpTHVMREE0NUFmdjlF?=
 =?utf-8?B?NjlSd3R6cmVoRUxHUkoyZWFEQmdvQUFQamhNRm45R2p1V0oxUlBDbEp1SzFS?=
 =?utf-8?B?VncwU29sSmJkMmR0Y0NySDhmQ2ZJZS94dmhKVFlwSnFTSVN4YzFYVWJ4RnF1?=
 =?utf-8?B?K1pCd3BiQlRMc1hWSUt5OHYvODlqUEdKb2Y4UEdVcHRrVWZLS0x0RTMzcGNw?=
 =?utf-8?B?b2JNQk9hYWxHaHRpai9KVVl2cXhsUmUxV2lXc3NLWUlPdHZ6ZU5jRjEreDRx?=
 =?utf-8?B?NGdScUw5amg2ejdyRHFHTjRMUGdtYmYzZzlZeXhBZWR6eTg1cDZiMnNqOFhL?=
 =?utf-8?B?MzNvU2huNDRkQ3NhQ1pWWkdNSTZDZkNuTHpBcStQbndrZkkyTTlaZlgzaEty?=
 =?utf-8?B?YjZmR3JiVitCcFdDbldLRTZGbzlidEVnVG5HNnNOODhMcU5tSUhlcnpkd2Ja?=
 =?utf-8?B?WEZla2NLbGFZbU02NllaZFlyc01FbnVMVVpVMEVrYnhjVWcyZmJ5a0dHWWkz?=
 =?utf-8?B?Y2phZ2VzUlB3c0lUcEJKdjJxQmczc3Z1OGxjNld4K3Y1LzZXekhTWlViM1Vq?=
 =?utf-8?B?dFNoRmNWK0x0T1BETDcwSDlSbjZjSit2ZEdZVVJ6emJhVlB5MUphM2hvM01h?=
 =?utf-8?B?d2FEUWNxdjFONTZYSkdnd09pUVBzbEZ0K1RNdUs0VUJzeGE3THkzM3l5cWlI?=
 =?utf-8?B?cUtsS25qS09qbTFIdjdPaW9LNUQ1OEhnM1hNZXI1TUthZDNNQkVhellhd2J5?=
 =?utf-8?B?cHBzUUU5MXZnZVNYTmc2Q2ZTZUFVOVMwc2ZPcDF5WlFjK3U1M1lWREdUWldG?=
 =?utf-8?B?VHF3S0daYk5YK0dHZExBOHpsQWtqUGtsMnFiY09sbXJlZkRwemkvNUlpQ2o3?=
 =?utf-8?B?M0F6b1dxNGVDZ3ZvL21rZ1VtU2RCM2tNTzlyNFBUbWlaV1A1Q09zeHFVeHdX?=
 =?utf-8?B?QmJUUzRQQUZ3ZnZuMG9ZbHVQTFB4Nzd2OGJBWlBZa3ZkdGVWUTA4QzA1TlVJ?=
 =?utf-8?B?TmxNT0phdFgxTXNTSGRTaC9HN2I0UFhucnFqY2NnY2NuVm9oOVNLdGEzZnB0?=
 =?utf-8?B?QzBnSHMwUzZWcTM1WmVWR005MHVGVzlsdDVtMUtER3Vzb3I4WjVLaW1lQWpW?=
 =?utf-8?B?QlZ1bFdIVHhuU3l0TDVGcGF3Wm5VdnFxT0FqWFlFSlA5bUlJV01SbFBIL1Fs?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5fb8cc-aab7-4862-e621-08da80d2803c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 04:31:21.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZrYbBZ1Tses2cIa5blEsyYWCR5npIji+oftdRIGPV5totFx7S4nif801/NfTv2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5116
X-Proofpoint-GUID: PdfbrGWHEaDa3OeWYcQX_BHt5Svtv6QK
X-Proofpoint-ORIG-GUID: PdfbrGWHEaDa3OeWYcQX_BHt5Svtv6QK
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



On 8/15/22 10:25 PM, Andrii Nakryiko wrote:
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
> Btw, Yonghong, I tried to figure it out myself, but got lost in all
> the kernel functions that don't seem to be very well documented. Sorry
> for being lazy and throwing this at you :)
> 
> Is it easy and efficient to iterate only processes using whatever
> kernel helpers we have at our disposal? E.g., if I wanted to write an
> iterator that would go only over processes (not individual threads,
> just task leaders of each different process) within a cgroup, is that
> possible?

To traverse processes in a cgroup, the best location is in
kernel/cgroup/cgroup.c where there exists a seq_ops to
traverse all processes in cgroup.procs file. If we try
to implement a bpf based iterator, we could reuse some
codes in that file.

> 
> I see task iterator as consisting of two different parts (and that
> makes it a bit hard to define nice and clean interface, but if we can
> crack this, we'd get an elegant and powerful construct):
> 
> 1. What entity to iterate: threads or processes? (I'm ignoring
> task_vma and task_files here, but one could task about files of each
> thread or files of each process, but it's less practical, probably)
> 
> 2. What's the scope of objects to iterate: just a thread by tid, just
> a process by pid/pidfd, once cgroup iter lands, we'll be able to talk
> about threads or processes within a cgroup or cgroup hierarchy (this
> is where descendants_{pre,post}, cgroup_self_only and ancestors
> ordering comes in as well).
> 
> Currently Kui-Feng is addressing first half of #2 (tid/pid/pidfd
> parameters), we can use cgroup iter's parameters to define the scope
> of tasks/processes by cgroup "filter" in a follow up (it naturally
> extends what we have in this patch set).

For #2 as well, it is also possible to have a complete new seq_ops
if the traversal is only once. That is why in Kui-Feng's patch,
there are a few special case w.r.t. TID. But current approach
is also okay.

> 
> So now I'm wondering if there is any benefit to also somehow
> specifying threads vs processes as entities to iterate? And if we do
> that, does kernel support efficient iteration of processes (as opposed
> to threads).

IIUC, I didn't find an efficient way to traverse processes only.
The current pid_ns.idr records all tasks so traversing processes
have to skip intermediate non-main-thread tasks.

> 
> 
> To be clear, there is a lot of value in having just #2, but while we
> are all at this topic, I thought I'd clarify for myself #1 as well.
> 
> Thanks!
