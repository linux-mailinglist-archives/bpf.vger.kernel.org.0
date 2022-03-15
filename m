Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50B04D942A
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 06:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiCOFzV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 01:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiCOFzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 01:55:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72305275D2
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 22:54:09 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22EMaWOT028727;
        Mon, 14 Mar 2022 22:54:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rCUuvOoE8gEGPJY3WgEoaYDX/6y9jhnT+Y7gIB2KawY=;
 b=I91DTflcSlGfrsbzhNprdPoRLa4iKZHiIVf8EPzllmr8phA4b5THcSQf929/ioy6PhT5
 BRcOqnqQGCwlBMiCq4xbSpTLNIXAT1P+r7vgmL7P0bQys0Mewyr6M0pkUAz0mdAvweFK
 FOPB2xIA0S75E79B9qiusZadfkFvXV64KMA= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3etac841tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 22:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnLZph2I4ajJ1/+NvzddhYiytfVxooJwIeHQANt3sdwMmer2kMGn7pbkQNppe3VzYjTMwAKW1u1nVnCk30eDYIe5x8rj/0LGUdh+Q60SwFn5aul38kMdHpk6DGltGlwEBoO5V6t5Mkm2pWi6QVnLdsz4jnYk9FBZDuFbdC76sEth8/5UfFhpZtTPK8iRde8ENFUxH0oH5ZTqi1F+N4nVSrOh6ujgafCS0tjKZJ5REVFbhPdBEaRry6bnoRedUNy+UXhgV2WBBopwvOUmTd37R6cntGIm4USv8aV7JQ2JdESRpiBDDKItnbbAlFdBA1PCj3eNjwNkpxfIidc6qbvfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCUuvOoE8gEGPJY3WgEoaYDX/6y9jhnT+Y7gIB2KawY=;
 b=RwwZjEhxVYm8OlxGykJm7ihfNF7EnKgSxPYjzoaQ7FHjzJdPnN8dvhOu4KdGyh889X1blEV9EbPtgaRkLIYkYsaRgYgmTAGSx4XDi0RSDLrt/JTHZFj2KC0IHTRz9X+bqHhgM8rWwbUg21wsx5etn8Jqg1KC68ueIcVZlKjfDBOzKDX0M10vpG2Se4n1fgNWSCpmQiB2rwnxXV3F1TQUNRJCFrHb27X9t1Em2ykkoYe9/C+duYX/7nnat51TUdLHGKRtkm2PvpZK7PTlkehcIXA1wLL82GuLnc0rTGHZBYdXapiCaez4BCfZRZ9/KUFgWo/AYrKrAi/mq910ojdeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1421.namprd15.prod.outlook.com (2603:10b6:300:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 05:53:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48%4]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 05:53:59 +0000
Message-ID: <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com>
Date:   Mon, 14 Mar 2022 22:53:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: Question: missing vmlinux BTF variable declarations
Content-Language: en-US
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     bpf@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <Yi7qQW+GIz+iOdYZ@syu-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MW4PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:303:b9::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 761f74b0-daa4-4ad9-2c7e-08da0648330a
X-MS-TrafficTypeDiagnostic: MWHPR15MB1421:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB14214F4F338E8E8C34C1C56CD3109@MWHPR15MB1421.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92E9+mVRDkI4orB3hEwZTogl9s2hR0iiiwysOKsdZi9PRCvMjZT3fdJEwYi6xzB65uepZAu7U3oCs9UyaOiK7SSQl80tR5yhXbPNcYCkq59ne9spTK6jkskh9fMBLerUf7vXLQWLAUpz8hIppTTiqW7d4PshWhyscNRSazMB8nHLBhgCquWRbIoBH8q8udDV7E752OlFnpFIiSHGZklZ61uqTkykrmZyGKsi1bVKPS0QmYqL7ceLejcrTsXGWK2mQk9dfc3sVqIaYFf1DmtS/xSuE517xQHJZlRxi5266p2eesKQWffT4z+V8WXdkIRhKjPtcm2emoHifE+0mQfyaMhcSlz4Kgi7BfueQa0lPMZW7OQnVy5g6OwC5a4tp/+F42kiMddzM4cnzp/1v+QsweQQ00Q+IqwZA9s8I8XS+c1CKiz1qOstxElLxigfdpxiIsD/jsmMLuU7CYKfGOd/eM0oPCIRbr4JssEoucMR3G0wHCUU/5HlyBGLiLtPQHyZLA9nmA7cccI4y4lPHJy9oVCrUfjMLFIxUqt9KqEdBteiWBDx8H65r8p1koDIZjXU2vGmqm+fcq4aYWBrG50L8lnd7AUmAAYCAWDHBwO+FReOs8D3ql1aPoDNo2qA/Gx9i/RfwhVZ6+H3quHEk3jiRUNSHu21/JoMhyvvHEqcR95iLftR9DlgJvP9dkVDe0iJXmqy7DXN1h8McbSLvT13J1B+zl4mO1LIm6F/bKFEd7V5KMWMbRhvF6cAbBU7Tc+XTCHSarvLMMUJV2O+DSaX/wo6QbGWN/EQnM2MDCmTm0cpdKf642X5ozi2qb8QUDBi+CHcRv+lhIK/DPmjHw5/x1jOadQs//D63yjz5PMkvGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(53546011)(66946007)(31686004)(2906002)(508600001)(52116002)(8936002)(5660300002)(31696002)(36756003)(66476007)(66556008)(2616005)(8676002)(38100700002)(186003)(83380400001)(316002)(86362001)(54906003)(966005)(6486002)(6666004)(4326008)(6512007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3drWlZOTkxsVG5hdmxpaEdCQkFpWUpZOFUrQ2hZb3EvOEdaYXRtazR1blcw?=
 =?utf-8?B?TnJrRXpVSTNCTnFXRFN3bE5iVkwvOUFZZHh2VGJQRkFNYjcxWUNzMjBuZGZz?=
 =?utf-8?B?dHZnYm5Hcy9zWUlOOWN1aFh4empyQlJ5UnJrQU9XTFNFbnJhY1FkT3hBdk94?=
 =?utf-8?B?MTBWVlAwSUd4ZzZnQkdJUE9LSGVBRlJVdTl6SHMzUVgxN3dNUkUvbCtIRW5a?=
 =?utf-8?B?d1ZmRTdpUThobWoydk9aaU51Z1o5b2Q1QWt1M25VdzFBY1F4djlxOHd1WDRz?=
 =?utf-8?B?M05mWkI2Z2ZpWmpDTVhtaE0rdk1mRDh3S0dqNUVnN2pHWCtsSDdSUWhYd0Nk?=
 =?utf-8?B?RjZXREcvcEI4aUc4dFpFSTBLY1hUVDM4NFpReXM2VEQwaWNwVXdOQjFrOFRE?=
 =?utf-8?B?OHZtaUs3Qy9OK2tmNkM1eWExSTdwb2NCTTM3Um9icW90RUU0OEQzSis5MUlw?=
 =?utf-8?B?RG9id0toWjFhaUNabG9ic3RRbkxuMkZpL2hsdVkvVUVXUldCbWxpNlV2WlZY?=
 =?utf-8?B?amo3WmIxVUZ3UXNmd0hvWHp3d3l4TzMvNG94VXRiZVM1LzcxV2ptY0NJRm9G?=
 =?utf-8?B?UjF4dkNNVlFGNXRKZHd1b2tidkxzQy9NbHhGS2VJamJZNlovOE9QaVEwcVBT?=
 =?utf-8?B?SnZhOGZlSEFmMFo2NjlBZDN6N3hNUFhwelVSenJzbU1JMWdTS2VtMXYyWHpY?=
 =?utf-8?B?bjZ6dkF6Qk50SGxHTlNoY0F1dXMrUVNIK3dITFpRN2VLREkzdVBSRHQ5YS90?=
 =?utf-8?B?bnZxSC9XUjlOQ1UvSnJCSXVaS2pyL3ViQjloenp3eUk3RXVpK1Y0QXB4cnVS?=
 =?utf-8?B?bGJZS0JRZ3F3T3B5TG8wSEdBTWg4Y3RvcUVzVUhxVEZ1NUgxYlZpS3FZTlpv?=
 =?utf-8?B?KzFERmRZSGJBM3IxOWZmSlJ6MjB2dHBXMlV2bFpHcEV4a0FKcnBidzkza0Uy?=
 =?utf-8?B?bzVCOTllbldTMG5KVHpscWh6Z2JreG1VcGRaVE5vVEVqRVYydWlyakVvTkda?=
 =?utf-8?B?U1VjSkRGc3RnUHU2T1ZWMVh0cllvcm5VSnNraDE5RExDNFpnTkxaeGM5YTZ6?=
 =?utf-8?B?d291U1lETXhSWkxsM2N0UnZUYkhOWmRJMG9Ob1JRS3I0NmRRTjdnWW1UVlRi?=
 =?utf-8?B?Z3RlUEVNTEV3WGY1MDZ0dFo0a05qcEI3bVNKRlU2QW1LTE1GWFhjeDRYM3li?=
 =?utf-8?B?RnFXRk5SS0wyQk5MWUFGaFd3aFRkRnY2bFRVRmZRYTBieFI2NFJFREFSRTFY?=
 =?utf-8?B?MWF1MEdMWkZUYnl0RGJyMUplK2xQeS9EUTBjRisrWGVlWTdzaHp1UXpGK1Jr?=
 =?utf-8?B?Nk9uS3JiSjJwdFFSdE1ZVG5kdUEycFZ4a0pwN2dhNnEzQjh6RXJUbHp3QU4v?=
 =?utf-8?B?WTRJL0NNQTg5QlJmTU50ZjAzZld3dytOWU1NT3kxanNMWHRDVTVpYk1WWHJB?=
 =?utf-8?B?N3dDbHJ5ZzhaMUxqeVA2aUIrRy9IOUNVbHBoRnhqM0JqK1ZRVE02MjRvM1Bx?=
 =?utf-8?B?SGlLUmxLbXBuUCtJb1lSNXJIQ1gxQnF6RU1lZU4zcm0vY054RmM3ck96Y0Mx?=
 =?utf-8?B?SGl4b0lUakFaZktvOHVGQ2czTzVzWE9Jc3RpSUh2UE5EelBlVXRtSzJVakFh?=
 =?utf-8?B?K21nZkpjdURqTUdQcHhiSTBlRWNrSWRRUE5mVUhlVnpiS2YyQmRxLzAzaVNj?=
 =?utf-8?B?ZW1aRU1qUDNvdjZtVENXQThPUmg1UnVEaEtiUzY0SWVGT2tVbkFLN2FlWUdS?=
 =?utf-8?B?aFo5Z21JUEcrRGZvLzI1OFUvZTJlNzhYbXVLUFR2K3h0SE0yazc0SWVKMGR0?=
 =?utf-8?B?ckVRSTc3Z2pGK2lMcmtsTWh6NC9vcDVVR1gyOUNyNkJTVVorSXpHVm5EYU1z?=
 =?utf-8?B?cE9KcENESksxZTZpSmtDcWxtRmdmT0NrQWxZSFdZU2pBdEwzUUhDWTJNUHFm?=
 =?utf-8?B?OE00akJ4OFpZYzlEQlFkSEJCWUc3bWUvQ2pyTlc1Mkx6aTBGZEFMM3dpNHEy?=
 =?utf-8?B?ZGJYTkxITnd3PT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761f74b0-daa4-4ad9-2c7e-08da0648330a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 05:53:59.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y/GO2s68cMWakOu2ob4cYogLtSiO5dE8L0zMiCIA9v/m5OJ/DAfumNqAJWzGvg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1421
X-Proofpoint-GUID: ckt3_tjMkeGWYZxcOqfhicBjRo2wmPTW
X-Proofpoint-ORIG-GUID: ckt3_tjMkeGWYZxcOqfhicBjRo2wmPTW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_14,2022-03-14_02,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/14/22 12:09 AM, Shung-Hsi Yu wrote:
> On Wed, Mar 09, 2022 at 03:20:47PM -0800, Stephen Brennan wrote:
>> Hello everyone,
>>
>> I've been recently learning about BTF with a keen interest in using it
>> as a fallback source of debug information. On the face of it, Linux
>> kernels these days have a lot of introspection information. BTF provides
>> information about types. kallsyms provides information about symbol
>> locations. ORC allows us to reliably unwind stack traces. So together,
>> these could enable a debugger (either postmortem, or live) to do a lot
>> without needing to read the (very large) DWARF debuginfo files. For
>> example, we could format backtraces with function names, we could

For backtraces with function names, you probably still need ksyms since
BTF won't encode address => symbol translation.

>> pretty-print global variables and data structures, etc. This is nice

This indeed is a potential use case.
We discussed this during adding per-cpu
global variables. Ultimately we just added per-cpu global variables 
since we didn't have a use case or request for other global variables.

But I still would like to know beyond this whether you have other needs
which BPF may or may not help. It would be good to know since if 
ultimately you still need dwarf, then it might be undesirable to
add general global variables to BTF.

>> given that depending on your distro, it might be tough to get debuginfo,
>> and it is quite large to download or install.
>>
>> As I've worked toward this goal, I discovered that while the
>> BTF_KIND_VAR exists [1], the BTF included in the core kernel only has
>> declarations for percpu variables. This makes BTF much less useful for
>> this (admittedly odd) use case. Without a way to bind a name found in
>> kallsyms to its type, we can't interpret global variables. It looks like
>> the restriction for percpu-only variables is baked into the pahole BTF
>> encoder [2].
>>
>> [1]: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-var
>> [2]: https://github.com/acmel/dwarves/blob/master/btf_encoder.c
>>
>> I wonder what the BPF / BTF community's thoughts are on including more
>> of these global variable declarations? Perhaps behind a
>> CONFIG_DEBUG_INFO_BTF_ALL, like how kallsyms does it? I'm aware that

Currently on my local machine, the vmlinux BTF's size is 4.2MB and
adding 1MB would be a big increase. CONFIG_DEBUG_INFO_BTF_ALL is a good
idea. But we might be able to just add global variables without this
new config if we have strong use case.


>> each declaration costs at least 16 bytes of BTF records, plus the
>> strings and any necessary type data. The string cost could be mitigated
>> by allowing "name_off" to refer to the kallsyms offset for variable or
>> function declaration. But the additional records could cost around 1MiB
>> for common distribution configurations.
>>
>> I know this isn't the designed use case for BTF, but I think it's very
>> exciting.
> 
> I've been wondering about the same (possibility of using BTF for postmortem
> debugging without debuginfo), though not to the extend that you've
> researched.
> 
> I find the idea exciting as well, and quite useful for distros where the
> kernel package changes quite often that the debuginfo package may be long
> gone by the time a crash dump for such kernel is captured.

I would love to use BTF (including global variables in BTF) for crash 
dump. But I suspect we may still have some gaps. Maybe you can
explore a little bit more on this?

> 
> Shung-Hsi
> 
>> Thanks for your attention!
>> Stephen
> 
