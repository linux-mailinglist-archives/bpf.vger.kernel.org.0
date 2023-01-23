Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68C9678273
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 18:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjAWRCM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 12:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjAWRCL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 12:02:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A99C0
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 09:02:09 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N9xHTh012675;
        Mon, 23 Jan 2023 09:02:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=yGKTBgW0ymoSvnflX6qgg+0p0s8hAvhJyFh/cGOYmnE=;
 b=cvTr6hUT5djKHgR2ZoDiPxkKr1kSUTP5FNjq6bxaYRHzzHxaVF4inTte2QYW7CuypHr2
 NQBuQLpNhi7+1+yH3IVzMtKGY3pnldOpOwdPPeVN/3qfGWR3vV3U3gPuk5U7PQSnPSm9
 oHIkOQyJdrLgq1ZIkFKY0Cizltqs/Lu5xc4F9HXjSNJ9Q1Jeze1Xlk6tcF17pBf5ghDX
 +mezvgoVgNnT0Bj8vhCXb/V6aC6KtNqnfFJ9WraC01CyZafdSCaOxw0tbqO1fBdsDBzr
 j8ORH2UDtejSc1V8cxqeFbWCvb4JvQYu92uCLcyKOOOULATPMvrjNR7IfUNL3di/Nx7p iQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n8e2484fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 09:02:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hul8/Olk9+qnz7VaAzPllTbciGhrR17XMfpt2IRdraSks8Naz9b0AVTyJWLJsBr4FVWvQBvUpMVhJkHytNIz1wF4hM9mMIUjxqe5QAuy8uIvx2nx/N1BsINNVsZuZyDEpIfglxWGUrvAnMDMBn09x0YdL7RVvAF088u1/caVufjzkxkhg1bhxFn2CwEB6EYDPxRu+Mf14TgW1gvW5aKPa6BO7Ei2gIR64X1YVXiZPZch1YzgUDbxSFMVOozLZTeEy0Gj+izu7nGir5St6qO7qxPRuoRHssnlWWToOED0Tn8lq1Fe3+UlI+aeF6yjSTQXEULEORjb9MeCgCavB+NelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSyU7+Jq8PfvpL2WZ7a+PGJ0VxD4dVaJlJxeawgAKsQ=;
 b=fufIBKkh8JEBZraoOm4JTO7OGyPc+wCrghgrIdI3uQdv8JDbRQ73RX6CywPFHC49sX8SZrDWAWi7D29ssJpG67GaTcNEJy65V7vc9IDIqU9Av/n+pkkexduKdZ0bnxQgi3p0H1t/jMlsakGxFi5fEWx0xqoAgS42naRdIHgn9xZz44/SGVwAfrOFjaVFlMpM201bEmPiPWlEu70bPsIMys1vQdAo8u/0Zso20ONvq9EnquUvEBZGafybaXwXAhLzprhMkAWSqjJJeNojSo2zBd8ehI0eYuklWMLZDjYowNQ9ZhfkCO3A962OhfFzxHcCHgvBLR9Hmjq5I11STtrrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4534.namprd15.prod.outlook.com (2603:10b6:a03:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 17:02:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 17:02:05 +0000
Message-ID: <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com>
Date:   Mon, 23 Jan 2023 09:02:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Are BPF programs preemptible?
Content-Language: en-US
To:     Yaniv Agman <yanivagman@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com>
 <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 622805f4-c191-468f-e3a9-08dafd638dbc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkeo0Hf1GF9Euj65ekS1uNmmUs24H2ieSW773ByXKgQQ1td0AqI7BqFwqR2UPokv2P3QsxMcXU/+pjk2fHy7rEXWHIFMFvQX8fxXSEFCDpqztzVAfoHQHTGhwuDrSpevh9Jy4fDrebfyNON7aiB/hIkS3i/zFmNFnDpltTel0B5jSGoNf1giD3m+rrvkZKi62kVPrIzDnCv+zmpjHN201YZzqD22nz0wsojPVW+Yn8EX9NzV52zb3gz39bJ50tUzW13eFZ0d1h7ZPtZDCuu5YnEcJHmS++5LjWLa87zH5yjNDJU7VcI4fBzeLwAPwbO9n47KI8kNsXAcx42Dn5kyT/i8SNxq+JQnV+tLaL5/krcVWizJtK+ohEOmaYH4PI0iGKKW/3PV69hLu2V5YSJn8961dx4OWrZn905O/74BT5R50ALHcwzk1lgH+AvTRNhfIRxK0h+ReNVoATrYA6+pzzs4wUoWCYmgCaEsa9/GsAGfiTMpfDQxE4Hi0smF/GnxQdhcMxzVuSi+NLEJPn+2ohrkXbKtvwRyqogZxZ1hxVbfNi6XRQ4x9RHpfje1fLAG1isFq8RuaRLCDm839+e5NkfBmU452w9KIosmv+w2owDlfxDTN2e6XV0y1Aqa9IjQZIAhRdLlmPT4CPx49lZSVe8kx0ujtASkQuId8WvpZht8X6wFnIaPIoBeHySNN6cU62OMXmkCaHzFYZMvhVKsgExb1mjDugQnIeqKX0h46hijPnTKJvFeKxDK0hbpvXwV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(38100700002)(31686004)(41300700001)(83380400001)(66946007)(36756003)(8936002)(66476007)(8676002)(4326008)(66556008)(316002)(5660300002)(110136005)(86362001)(2906002)(31696002)(966005)(53546011)(6486002)(3480700007)(6512007)(2616005)(186003)(478600001)(6506007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1za09KZHNOZi9rT2hYb3Q5YmVYejlPS0NZdlBaa2UvZUoyOEVnbG03eDBE?=
 =?utf-8?B?UExuY3laUUpQd0YvNFVDZWp4a0NjcVlBbEJnUlNOUHE2L0VvcG5NRDd5RFhE?=
 =?utf-8?B?a1hFVkhSL1J0aCtpUXpxbE52NDBDc2FCQnVKYUxadWFZZ1ZrYzU4dmVNalNF?=
 =?utf-8?B?UmNzell0NkhtVGY5TFVOMDdjQ1l6VUVMUW9HdXdzejFkVk9oQk1MVm10elhj?=
 =?utf-8?B?WmRsSXZzZnhPTWFFWXF0SnNqVWFBL3JzbjdzbUZNL1YzNFVLWS9mNmQrLy9M?=
 =?utf-8?B?ejJYWWhSaVl3RmpsT0hEZVhwTHJMM25NdFdjcG9ybUlSZDQySk56YkZGTFdL?=
 =?utf-8?B?dm9IbmY0Q2ZPYjNDLzlTZGdPRzE1NjVCUWpVek54Wk0xY01JSk43MlQ1bDhS?=
 =?utf-8?B?ZnlNV1o1SnNBTnJzWjNadU05R2NFWGIrdUpGRlpXMDczM3ppbm8wVzB1bjVt?=
 =?utf-8?B?YmYxUmR4UTVPMGtDOE5DbmlaVGVBZGF5T2V3U3lFbnhqeS9BemUxQ1NJcGQ5?=
 =?utf-8?B?SmovWjZBdUJRVmxXTzR4MlU5a3JYT05oMGxlbmJnR0pqQVZJZmlETGUrSzJh?=
 =?utf-8?B?M2h4Y01abkhTT28yelJBU0RoR3pNeTEvZDA4OHdsR29JQ2l6cStwRHV4RkxP?=
 =?utf-8?B?M3V5U01vUFd4SUIxYWtRSlNmbG0xNzZ3WjJqTDFQdmgra3RFMUcwQzhYV2gr?=
 =?utf-8?B?Nkdqb1U0dlllLzNUV1NaemZZZG1ScVRKclMwNFhkSklzbDd0Z0UzOS9QUkxl?=
 =?utf-8?B?TlRVM2VzYXNoR2xlNFNMekRsRUFHZzZTRzY3YUI0QTIxU0JrZ3V6NmNaU0lm?=
 =?utf-8?B?THQ3QWoySWFQbFczNlI4L0kvdEM3bHlrVHJHbHgzcGtKYXZxbEx6SkpsL2wy?=
 =?utf-8?B?a0ZmMTlHN1VRdmxCLzZYTm9mR1Y2eDg5V0k4SDl5L3VrdkdzZFNDT1Bma29E?=
 =?utf-8?B?MEh2Qy9DdlFoZ1BQQTJwKzhxUXl2bytRdkxjbWRQS1lFK3VuSHYzRlJMYVBH?=
 =?utf-8?B?TW5MNHJTenRybFRaNjFOZkRBTlNJamt1cUdybzVtdUJ4ZHJEa09KY1l6UGVR?=
 =?utf-8?B?R2NDWXgyeDVvdnY2c3ByenBQTzk0T3FhZmUyTExZbEtmMFAvalAwaXYxU29F?=
 =?utf-8?B?akxOZVc1ZGVhNStPM3lwSXZMZmZlem5wSjBhRkVUaHdBZzNLM1o0TE50ZDRw?=
 =?utf-8?B?RkNvZlNkay9rLytJR0w0YkZkTXY1RGpLRmVRK3pudSs1UW05MXc1dXdvREkv?=
 =?utf-8?B?bkVOb0J0QjZDREZ0cStGQ0xNbVorTjBrOC91a0pQdGV0QmJ5cmF1V2tscEVn?=
 =?utf-8?B?dXdSamxzbWdicE1XOUNZK2dCY3VIY0VKTi9ENW4vRXZnU0FxSHFHcjIrL25u?=
 =?utf-8?B?SW9wT1J6ODRwZEdSQVFFK05tYXpLZEQ2TFFSR3BUdW1xTkR1SURRa00ycTA5?=
 =?utf-8?B?cHFNQVV4N1Q4RlZtRDB6R1VYRkZwelFucEFkcitFWXJxQTl0emtUQTluZ0Rt?=
 =?utf-8?B?dFliWUp4dlhXV1NKWTJyMG9xSE04ZEhucWlVY1lLNU5OMEFEUmtpZEpZOGFC?=
 =?utf-8?B?ODVLSldBaHFyc1k0L2pOOWFVdGE1N1BhcExkQTRlZU9MZ0xRMzh3TVQyNEhw?=
 =?utf-8?B?NkxRaXNIcW9YcTF2TmJpUGZpZ2puNmJoVHdtZ09pTDUyTHQyMlVhTVdlZ2FR?=
 =?utf-8?B?S1pXY3hJWTNQV0VyckMzdnQ0L3V5ZlRUZHlXZVJCSm10Nk9mWmhkWmVXM2JZ?=
 =?utf-8?B?UjFVWDRVc1Y1RloyRnE2YXRRT1ZKWmFsYmZVbnhpUUZrcnZLcFF4OEMyRjdt?=
 =?utf-8?B?Mk5QTEZqTGZLODlXc0o3Ny80VmZUWjJOaUNHNWZQRk0wQmkvY2t3SnZ5WlQ0?=
 =?utf-8?B?bFExbUZXN0MxckFXVFkrL2JBMVZCRnZndEljc09rVG5aQ0xIaEVIT0dWaFF6?=
 =?utf-8?B?cVQzME9PVGpHb2lzdjdqaVA4Z0ZCSUt5TjU2Nk56S3JGVGhoa0orSWJIM1ZZ?=
 =?utf-8?B?ZGZLdmd1S25RWk5rb29NQ05iVjVYUVJDM1MvUmNKSXQ2aVY4TzAwVGIrRlF5?=
 =?utf-8?B?ZW9RbWE4LzFqTlhyR0hKRFhiQ2ExbnAvcEdlV3lDeDdsWko0MmN0UGtBRXZy?=
 =?utf-8?B?TWJnMzI2dWsvMUMwaTRlcWYzQU1JN29Ubk9EUm9McHRuRjZZNnpOdWx4RStI?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622805f4-c191-468f-e3a9-08dafd638dbc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 17:02:04.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ9ucOVjWniqAjKQZGU3qgOveqerYd/J80Rt3ILgoDGF+GbOzLwctckowWJppEQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4534
X-Proofpoint-GUID: 8ONIEov-bBUbfdXEbYa2EzLB6jubVnIf
X-Proofpoint-ORIG-GUID: 8ONIEov-bBUbfdXEbYa2EzLB6jubVnIf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 5 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/23/23 4:30 AM, Yaniv Agman wrote:
> Ok, thanks Jakub for the answer and references.
> I must say that I am very surprised though. First, most of the
> documentation for BPF says that preemption is disabled, like the
> reference I gave [1] and even the bpf-helpers man page [2] says "Note
> that all programs run with preemption disabled..." for the
> bpf_get_smp_processor_id() helper. I think this is something that
> deserves more attention since many eBPF developers are still under the
> assumption that eBPF programs are non-preemptible, and running their
> programs on newer kernels might be broken.

It would be great if you can send a patch to fix these
out-dated comments!

> 
> I'm trying to figure out how I can solve this issue in our case - is
> it correct to assume that no more than one preemption can happen
> during a run of my bpf program? If so, I can try to write a percpu

No. It is possible that you have more than one preemption during the
same prog run. There is no restriction on this.

> buffer with 2 entries, and give the second entry to the program that
> interrupted the first one. But even then, I will need to find a way to
> know if my program currently interrupts the run of another program -
> is there a way to do that? Maybe checking if the current context is of
> an interrupt, can this be done? Any other suggestions to solve this
> problem?
> 
> [1]: https://docs.cilium.io/en/latest/bpf/toolchain
> [2]: https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
> 
> Thanks,
> Yaniv
> 
> ‫בתאריך יום ב׳, 23 בינו׳ 2023 ב-12:54 מאת ‪Jakub Sitnicki‬‏
> <‪jakub@cloudflare.com‬‏>:‬
>>
>> On Mon, Jan 23, 2023 at 11:21 AM +02, Yaniv Agman wrote:
>>> Hello!
>>>
>>> Several places state that eBPF programs cannot be preempted by the
>>> kernel (e.g. https://docs.cilium.io/en/latest/bpf/toolchain ), however,
>>> I did see a strange behavior where an eBPF percpu map gets overridden,
>>> and I'm trying to figure out if it's due to a bug in my program or
>>> some misunderstanding I have about eBPF. What caught my eye was a
>>> sentence in a LWN article (https://lwn.net/Articles/812503/ ) that
>>> says: "Alexei thankfully enlightened me recently over a beer that the
>>> real intent here is to guarantee that the program runs to completion
>>> on the same CPU where it started".
>>>
>>> So my question is - are BPF programs guaranteed to run from start to
>>> end without being interrupted at all or the only guarantee I get is
>>> that they run on the same CPU but IRQs (NMIs, soft irqs, whatever) can
>>> interrupt their run?
>>>
>>> If the only guarantee is no migration, it means that a percpu map
>>> cannot be safely used by two different BPF programs that can preempt
>>> each other (e.g. some kprobe and a network cgroup program).
>>
>> Since v5.7 BPF program runners use migrate_disable() instead of
>> preempt_disable(). See commit 2a916f2f546c ("bpf: Use
>> migrate_disable/enable in array macros and cgroup/lirc code.") [1].
>>
>> But at that time migrate_disable() was merely an alias for
>> preempt_disable() on !CONFIG_PREEMPT_RT kernels.
>>
>> Since v5.11 migrate_disable() does no longer disable preemption on
>> !CONFIG_PREEMPT_RT kernels. See commit 74d862b682f5 ("sched: Make
>> migrate_disable/enable() independent of RT") [2].
>>
>> So, yes, you are right, but it depends on the kernel version.
>>
>> PS. The migrate_disable vs per-CPU data problem is also covered in [3].
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a916f2f546ca1c1e3323e2a4269307f6d9890eb
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74d862b682f51e45d25b95b1ecf212428a4967b0
>> [3]: https://lwn.net/Articles/836503/
