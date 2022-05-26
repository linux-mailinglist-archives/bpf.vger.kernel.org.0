Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A795351DF
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiEZQM0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 12:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiEZQMZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 12:12:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121EE60DB2
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 09:12:24 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QDTPwM028525;
        Thu, 26 May 2022 09:12:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wrDAfHCX1OOChE2ef41LFNrDJG4NYzIDZ2I+o/UjjaQ=;
 b=G6p7xOcKYtAoIsAG3M7pyjJx7pCYtcJaUlukrqSzif8EaOKrUNOjW36N2qJO0i+Eb8Jl
 UtB2QLiinUjB0CYfCuhD4Ny/phEOrIrlVR/HPb/P8kmFKxi0H9sRkFHYXtv3BWgdjaiW
 KgRAN9auqRaBVc+zGvDWQINUoDYEynAU9RY= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gaafu15hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 09:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ6/mHAaYHXIHK/Kkg7lrqceHqQck8IYcSXFUTCtJFMOrAHFpa7p7dk/7aweElm4H9sblKiPFvCcCDdpC6kRE3Tpyb/abbD4U2kiqg6DvNqDhPbMGQ07Lzc7xwGh/LkT8l1d/hNRA6Wl/zSFVCPbmVLTw2sDwEJi63zu/sK8BTjMcKQw8urR4BYQ75YkqTuNQP3s/y5WkdbahF+xGgwjyR/aclVHi1HSydkadcug1e4bZusv69PHeZ94MvKWUE+viJrnRU/xVTVzI5cX3u1TvYrpjlxVfZ5q0mcpFLx5L/SsDJ4uLnBIDvsL55n3Q4B4G+gILWhFkTbucGawaEFHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrDAfHCX1OOChE2ef41LFNrDJG4NYzIDZ2I+o/UjjaQ=;
 b=aGFOv2RvoISmkiidpecLq54NGhVCDnAD3KwNW3Pi0qIRnMXsxBW5Z4gqnZSkWBfws8quBChVcDAmZECKro14pvTiAVmBxATd+g4cOUM+8jCwjZiIUjkBlWV2G71LnxAxlFKrREKIHIhCJafht1UG1IKkDxTg6r4MBDg5OBD/rMj/ywy+p+IDBlFj3ttAlcTJB5HElt7ZOQOOaszqmXbi+OWYowUckAxRvUHXOs4SyL8abP78b0d4P5UNAQZvRZrYwoJ2xiwZO1Lt2PIqtyoGLoAvrMipItJPhZQ+Uu1pNbYYrzP6tss/Pn7CKcSr7QWqrqkL3qfBOkEmqudkNrEmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4493.namprd15.prod.outlook.com (2603:10b6:510:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 16:12:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 16:12:14 +0000
Message-ID: <22d0a399-738d-297c-6c71-c36fa848af97@fb.com>
Date:   Thu, 26 May 2022 09:12:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: Relocation error on 32 bit systems of longs from vmlinux.h
Content-Language: en-US
To:     Matteo Nardi <matteo@exein.io>, bpf@vger.kernel.org
References: <CALo96CRkg4eH=Ee0qvx3YigyP9mPyzz6vhTtpqNN1n4mvUQUPA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CALo96CRkg4eH=Ee0qvx3YigyP9mPyzz6vhTtpqNN1n4mvUQUPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fed83fc7-10cc-4a68-bb86-08da3f327f5a
X-MS-TrafficTypeDiagnostic: PH0PR15MB4493:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB449380A19EA61D1F49B6665CD3D99@PH0PR15MB4493.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSxhq32177P0KCtNXQqcb2RNf6109q/GlZU8U2s/FIwk+97PrTvATLs5fd9L1EsW5N15kaXnFCIJA5gOpptu/5TgCWD5RIlE7EIZ1PqWXLE9oOrcb7q1gfcTbUypfP3bWkJRyGBApOnow00FYaoHck1l84VJoLEPL9pUwJDuZEE2MQ4/WapTVX0PpEssbnVywTfRhjKuB0AaS9LZzOrkGadGSVY7bOwjd7aA6vW8FbT5U3GvcQBaI2uy9xTmbM+WM8GkhUtm2ry1vIBk7n4y+44eYSOKqtNTId9QHtWjW4qbExPvFex54z0H9Ocf+D9fOI5cBqLR6BfEbznBBBPg8ADTfSYx++gwEWYaB7y5orPnTHFsQaS2G2+HqFyJg5j2+0qhr84bJwNq6j2Okxmz4McJrE0Ju3YeYeZcaQRRSguGESjERwh2m5sYGtdaKgLdCio2e90TPIqCplrKoUQZ6QeFna2nBvEHPtYs+2Ipabcc+Bl5bAUzYAa039cIt6eokPXzCEbWgWaMQeR/7FCweKrgA6NVAbXYj543pDtoBjy4o6lrCOiBSztbGHV2LwTVsp5hxirKseCb/nfXz1fbAEGpbh2w3FY+ZZJVnFMaxMafob2ZCUWaDGlPxiwFHZmmDh/1gK7/CcrpcgweZO4crPgyNDgHO7JxR38hiSLdMvPmDwNPf+bDTXQi2p4SnzG0WEuLGpPte5cf+F4BJ+WbLMXb8P5/pyuJVvGczERomDo30JVQlFRCDIUL8UjpyhOSRcN0REdAI/lrC9ylDJ00EdDZalW8sScfQgTW8tLF2KsOmbWxQ7nihmfWEj4iBf5K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66476007)(52116002)(31696002)(186003)(5660300002)(6486002)(966005)(83380400001)(53546011)(508600001)(8936002)(2906002)(6506007)(316002)(2616005)(38100700002)(31686004)(36756003)(86362001)(6512007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjNmaXFGZWsvV1NRVEN6QUZ1YTYyNGYrenQxdVVENWFzcE0vK2JvQkNTWUZl?=
 =?utf-8?B?dHFMNHRETGJvK0FicHEvSHQ5Q3lYeVRzRCtYbWNlN3FrcnB4ZTEwUzZWMmpB?=
 =?utf-8?B?VmgvQzNtSHBTRGtPejh2Q3JpZThwUGY5MytsVTVXU2c0dE9Idjk5bHkrVUly?=
 =?utf-8?B?NDVCMEVmRllzMzVqRE1ZRG8xL0FNWFZNNzZjUFEwS0hvYVg1S3duVjNTblda?=
 =?utf-8?B?cEU4dDh5OVdQeW54UkhiRk90ZUJZVHlxUFVrY0wwdHM3WEgxbXpTVWlWMHJr?=
 =?utf-8?B?elBYVXZTRTRVT3FVenNhNWo0Q3VlcjN6MFRHZTJBcms0RTMwYmNpVXh2ZGJ2?=
 =?utf-8?B?cXVSUXVJaysyQXhoN25hQWVmamQ2MWdXR3hxQWFwNnNPZVhYTTFVY2pzZ3Ft?=
 =?utf-8?B?VFU2NHpGYy85aURMbVJxVHZVeU1ld1oxK1BEckFxcnBxRHdUSWRQeXN6aXFQ?=
 =?utf-8?B?R3ZKam9XZFNuOHllai9JRm5JaXhGRXZkYkYzT0l5OVZMY0JoV2JQZWE0ZUJi?=
 =?utf-8?B?NklZVzZsUTUvanhSaHpacGx1SVpmQkRtcURLUWxWODhwaFAwckF3d3Nqb2hX?=
 =?utf-8?B?bURhYkRrcTVIYytHT3A4SjFiSXdSRzUzVllxL2pqZ0IxU0tlQWdPMTNjWFNH?=
 =?utf-8?B?ZFN6SHdzYUJjNHRBTys2TTlpVE5EZHVUN0VPQ2Fta0xhQVdDd2VxQk9JcEJK?=
 =?utf-8?B?bGdwR1R1YUw3NWlzMVlUQ25VV05DUWsvd2NKQUdad3JOTk9QTlRldllvdVh1?=
 =?utf-8?B?di9GU2dLK2VXL2dNcHpTdnd3MjB1ZDRqUlQ1ZG1XSFhtY3ZqNDBTbytyZ3ho?=
 =?utf-8?B?WUZJZEFmV2xSSllDeit6UmF4VW1remNZZzErMVRwL1BsbHpIVUh4c0VXdWVJ?=
 =?utf-8?B?Rnd4KzFrbk84RFpyWE8yYVQ1Z2RxZnBpOGpMT2M3R3dWKzc1SDkvYzROZlZt?=
 =?utf-8?B?aDFFTDB3dnp0TTRlb2w3OUdLUjR2MlhiYmtEVURuWndkRENhdXdNeXVua0Jm?=
 =?utf-8?B?MXBMTG85bjVKVEpwbDdmcUhhcHg0V09TOHNrVFdwdjBoTGpCUHlCSFhBdzVt?=
 =?utf-8?B?ekp1Z1NDcWp1NGZ6THNXaXo5MXN1L2ZiTnB6aEh0OWliNVJRV0NucVYxNWow?=
 =?utf-8?B?NlNSZklIZmdCQWg5WGgwR2VPUlJqWlhLenJrNHJ6c1BkZ2RjNXpQRlVlcnNt?=
 =?utf-8?B?b216TndqM3ZTZW1ObXJ2UEdibjAzdjlXNUxkSy8xT3NjZGNvOVpjbjRZRHVO?=
 =?utf-8?B?Y242dS9XVGM5NWFaWmJROThTRzg3VmlTMFJVVXAxVHAwK3hKWGQ5Q2FCQUdp?=
 =?utf-8?B?djhibXQ2VjVlanBGaHBETGN6Qy9JSi9KZkcwVm1IMU1pbUJrNEI1NVpSN0xi?=
 =?utf-8?B?ZW9uSFBXQ2dPd2RGQ1MyTERiQzNmZFR1ZUZRTUlpL2tVOXFWTnJoUk9DWVFJ?=
 =?utf-8?B?NnBBQjVOUE1PVUJXYVFMaFRqSHh1Q2NuWWVpejE1RE5LZDBlMnpqUTNLYzV4?=
 =?utf-8?B?ZEg3WEpoUE9GaTRnQytyS3o4RWp0M2dXVTZSbGNFSDRQQnZURTl6WEtUakVY?=
 =?utf-8?B?ZHE4TXZnRFBqTXAwUk9SLzZMTXcrL2czQnNaRi8ydEFwZDhMUnhpQ3R3bjM0?=
 =?utf-8?B?YldqRzNxNTdLUVZ0U3FtdklkVkswVkVVdnovK0l6bHBZVWpOcENyOFRmczlO?=
 =?utf-8?B?TWtZTlNGZlpIUWlscEdieEJmUEczYmtTMlBidUo2MHg4VFRBOE9vakdieUQy?=
 =?utf-8?B?UnFYd1VuSm1DbCtldGQyaWxCNTBpc2FQTmNDR00vbUtsV3EwdjFHT3BVS2Fm?=
 =?utf-8?B?K0lkQWNsaWVWQWpTeTZ2R3BQa21nLzBnb2YyTEdhdVo0MGUvZkg5dVlHZVlX?=
 =?utf-8?B?eG8vQ0lLUkJPc1BzRWxWQWY1dDVzd1o5TmRqd1lwT2RSQ0ZpVnhLNFovaTcx?=
 =?utf-8?B?NitiMDcrdVpUQjVOU0lQWCtRRkFzbTJKVkZPVnVPMXc0M1IxeDgwNE5Wd1Zu?=
 =?utf-8?B?UkxlWWNQeCtpTFkyTmRITkx2ZTdWUHBSc0JRMUpMM1ZNQXFXN3dwYnJMUEUv?=
 =?utf-8?B?S0d6cklwNFhGNVd4dGs0SWsvRm1iUVp6eGpxSkQ2OFhhYUpuRFFmNy9VMk05?=
 =?utf-8?B?ZHZXWjcyYUFXNXNZcFVpSTQvSDQ1QlVzSXFTdWltbkFKaVJxc3A5a2ZZSitX?=
 =?utf-8?B?dEhkTEdsbkpyM1grYXZNRnJtUmVORG1oMURSeFpRNEYzZ1ZBRzVDRXZBZVp2?=
 =?utf-8?B?WjQ4bzZqcjJIYTJWK2g0WkI2d3g0ZkoxcUYwZlhCeUhFUG0yMFFlRU43TGV5?=
 =?utf-8?B?UmNtRGVPVFY3cWN4WlRnNm9xNkppdFpkVGRCRTRJakY2Q3l1bFB1NCsxU2cw?=
 =?utf-8?Q?fka33mccxDsJMqR4=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed83fc7-10cc-4a68-bb86-08da3f327f5a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 16:12:14.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7xJE8lWFtBIlj7Se75X74rdlfDU43GTNMiqc4Ca7JVsuH+fSmIHGYbP8jCzNc89
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4493
X-Proofpoint-GUID: zfaImtmrQbcUQkngSlhAOwX62GUmg5E4
X-Proofpoint-ORIG-GUID: zfaImtmrQbcUQkngSlhAOwX62GUmg5E4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_08,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/25/22 2:53 AM, Matteo Nardi wrote:
> This program will compile and run fine on my 64 bit system, but it
> will fail with a relocation error on 32 bit systems:
> 
> SEC("tp/raw_syscalls/sys_enter")
> int sys_enter(struct trace_event_raw_sys_enter *ctx) {
>          long int n = ctx->id;
>          bpf_printk("hello world %d", n);
>          return 0;
> }
> 
> ```
> libbpf: prog 'sys_enter': relo #0: insn #0 (LDX/ST/STX) accesses field
> incorrectly. Make sure you are accessing pointers, unsigned integers,
> or fields of matching type and size.
> libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
> libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
> R1 type=ctx expected=fp
> ; long int n = ctx->id;
> 0: (85) call unknown#195896080
> invalid func unknown#195896080
> processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: failed to load program 'sys_enter'
> libbpf: failed to load object 'bootstrap_bpf'
> libbpf: failed to load BPF skeleton 'bootstrap_bpf': -22
> Failed to load and verify BPF skeleton
> ```
> 
> I'm cross-compiling using a Yocto build. I've reproduced this both
> with arm and x86.
> 
>  From my understanding, the issue comes from the `long int` in
> `trace_event_raw_sys_enter`, which is 64 bit in the compiled eBPF
> program, but 32 bit in the target kernel.
> 
> struct trace_event_raw_sys_enter {
>          struct trace_entry ent;
>          long int id;
>          long unsigned int args[6];
>          char __data[0];
> } __attribute__((preserve_access_index));
> 
> Indeed, manually changing the `id` definition  in `vmlinux.h` will fix
> the relocation error:
> 
> struct trace_event_raw_sys_enter {
>          u32 id;
> } __attribute__((preserve_access_index));

Right, for such cases, the bpf view of trace_event_raw_sys_enter will
have a different view from the kernel due to different interpretation
of 'long' type size.

In the above case, you don't need to change vmlinux.h, you can define
something like

/* you can change "___correct" to anything "___<your name>" */
struct trace_event_raw_sys_enter___correct {
          u32 id;
} __attribute__((preserve_access_index));

And use trace_event_raw_sys_enter___correct in your program and
it should be okay.

> 
> 
> "Q: clang flag for target bpf?"[0] hints that using a native target
> could help, but I guess that would completely break CORE relocations
> since `preserve_access_index` is a `-target bpf`-specific attribute,
> right?

The "-target bpf" approach is to compile bpf program .c file with
"-target bpf" flag.
The non-native mode is to first compile with from ".c"=>".ll" (from .c file
to intermediate file with native target like x86) and then compile
with -target bpf from .ll file to .o file.

Typically use non-native mode, you directly use kernel headers and
don't use vmlinux.h and CO-RE, which is discouraged for portability
reasons.

So in your case, use trace_event_raw_sys_enter___correct
is the best approach.

> 
> Am I missing something? If I had to fix the issue right now I would
> replace all long definitions in `vmlinux.h` to u32 when targeting 32
> bit systems. Could `bpftool btf dump` handle this?
> We're using eBPF on embedded systems, where 32 bit is still fairly common.
> 
> Thanks.
> 
> Best regards,
> Matteo Nardi
> 
> [0] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html#q-clang-flag-for-target-bpf
