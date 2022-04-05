Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879604F214B
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiDECma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 22:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiDECmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:42:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D227D391D31
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 18:47:27 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234NPFU7016615;
        Mon, 4 Apr 2022 18:05:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ynrqd5/ggxe5QNs/3ijuOsf7X6pio5xFQg8aty4Xkz0=;
 b=UJ+qJkdwAyj5Mr8LHW51Tul+Upq0+/aWvvrRW/ykNBKxJoBv3HtA+SytxKE1W8a4U4uf
 LjDmDTyK13Otp+qvWzfPlrwSf8EBgBrYD4cfgij7CAur2RYpgfYFkOONtIZbi1GvKFTK
 4o5GL5ZVJf3+8cEzu1rosnEy/TJU8ZsPidE= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f6kkrxew3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 18:05:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJsLyqGACVtIquheLS+Rz/TpmlvJdY5/AcuoR95I0RfCpaSMYYh609cRX+tXEbtzekupJ8z4x3aXh420+IXe+bOWdFskfVkAmfFxFW2KwKKOL80UiNwmq8FOzaZCOEbvlJRiLOyhBNxVWJtO6NQXzK1hMUjN9FqZkiemj94E0CxAufQywRxPOEToopGKBgxW8WJm4dePRURv8Cuh5lWTjN2/NvGpT7EgYekwpTBu+QHjoeKExAPFmvxyv5nIvW1O+K94prFjVfyFQlqIK+qOY9Y+ZkG1oCjMi0Ca4sIdXDGslZyAUhoz0pNTj3cHzXdazEfypGeV2pkG4Rl2C+3+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ynrqd5/ggxe5QNs/3ijuOsf7X6pio5xFQg8aty4Xkz0=;
 b=B1LeDl3DyQ30m8x+91MFkqyM9eZfD5Svdcx7amCAT8dUwryxHXBDIsonHcrcp9q1xA6URxoT7HyrG6JAaQRSzKNZYA8WyLTrqm5J2qQWkg6PFoK/o0ojHaNMR2DIxvg7e1JmbDrZC3neWMvHAIK6lgsNaY+oYBt7QPNdyprOyypeVVMQ6WCrpofQRr1mRbB92hS+LbSTUWhNg/oJ/uAF5eazAcM+tg9rRXueKIeHlceanwoJgiCaSdFDdNBt/kH55TvvhDpz1yuYdxnuqiu5Dbr2J0khPBiMEyZ7B6swlvCM72iZldhWxq5ajcmVdg9G3si+q0vSpshaOzGvoRdr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MN2PR15MB3488.namprd15.prod.outlook.com (2603:10b6:208:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 01:05:30 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc%8]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 01:05:30 +0000
Message-ID: <1497128d-c44c-4ce9-3526-abf8ce61e0ae@fb.com>
Date:   Mon, 4 Apr 2022 21:05:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v3 bpf-next 1/7] libbpf: add BPF-side of USDT support
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
References: <20220404234202.331384-1-andrii@kernel.org>
 <20220404234202.331384-2-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220404234202.331384-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::30) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b116104-46c3-493b-e152-08da16a06122
X-MS-TrafficTypeDiagnostic: MN2PR15MB3488:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB34889F4530CD79C2DFDE6781A0E49@MN2PR15MB3488.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NToT6HaCFtveQvN3u53I1VGQuoK0BWjvXHI2X1ayzCYgV5mlBtlgc3kz5sIWVj2Id1lotM3jnlt7W/gxBNayMO/HM/+VBFj5TzI4PHZTWm/37lIrJEz8HCmf/khuXuQUzmzccHfEbRaIQHcKLi3IfHElkHCPE6c3MyfUl8u7qTSu1Wjv2bqi2rIDcyrk8Aii+zHy/Yr3WRIokBz5ggz28b4N0IKTCavpBEsuCWP950EA+w3PXLiWnQGNiiRjCoAMTg55xeZI9D+dehkcBAH8IbL/JVAEnRtO6s9wW3CGGAPCqBrGzqQlBmxuKxwh3b2AWt/uPkIPQ2wScFDHzNdOjzwXRl2jUpuxfLCEjyq61KxY7AOj4kL3zTiqHcB/Vp/IM1h4et0+iRKg9gDcfL6Vmi2B8EZNz+vArxXWi7P70iYTnDdnaZj5ZRvK3gGvYbk4JY3LzSD9zlo3FPRhNSH5x4ma+5cyhnejJ+nEkGxsetRas+zaKmTHILe5CL9PkaMqNwGC/Y0Yilr8L0mvCQOIDuW2ccE+F72Usvuss19y+K5M2PpYimQYgoT4QTTzjZtmZAx4TrhgkQhkGZfRVqQiBtgscx4SJsr5GRomYDhcRYI9OX4O5MVpOUOAg3r2CjxXilfSyspOdlLU5JgYlH6rfjTtU0ujpWF70Vy/0KANt6UDDv/TMZ8ZAE4D1MyMuhosHqR9l65rs+EQSdGdGYHq5SYhr7aQfBCSO+zTu2g7z+a7byDBC38W8uFk10AxioycuAwU1MfTh0qPme3BGFLWcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(186003)(2616005)(66946007)(66476007)(66556008)(8676002)(83380400001)(36756003)(2906002)(6512007)(6506007)(53546011)(31686004)(6486002)(8936002)(31696002)(5660300002)(316002)(86362001)(54906003)(4326008)(38100700002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkliTW5FdGwrc0VyYlZtdi9USmplN3JrM2RmcWJOTllJN0VhRTBvS0tva2d6?=
 =?utf-8?B?ZVUwZmtmbVJkSitFdW5BK0ZOMXVzcXl1KzV5ZDJJYmNDYXJrd2l6S3gyVit2?=
 =?utf-8?B?aE1oVi9YbGVVVnVCbm5hQnRTb2pFVURrdU5CUlAxMUJncVBJdGRBdkptcXhE?=
 =?utf-8?B?azZTM0lUMFY3eE9yckEvLzZzS1NHclF4cWtWb1F5eHJLQ2JUZys2TmE5clhz?=
 =?utf-8?B?UUtITlJNbEJSRHBwVGF1czhRQ1Z4T0U0djcvd1FnRXhPRDc4YTRjaGc0YUNN?=
 =?utf-8?B?Rnp5TzV1TExtL0xvcWJTcUlpTll2OXRoQlVFVExVUlJSZWg0QitTR3lLN3Nh?=
 =?utf-8?B?VjlvdzhmajR2NEE5clo2NEpGZ0Zmelc0OFRWSUMxTmZ6ekhKcjhZTGV3bjJH?=
 =?utf-8?B?Zzc4c0dpWFJYUUg2aHVobmkyVXlKeExWOTJRd3hjQ29RMjRMY2QySjlTbnNJ?=
 =?utf-8?B?ZFl4aGVpQUU2b1J1TjducE1pZ1VjVFZHanNUMkNZRnJIT0g5dElVaVV1UWVt?=
 =?utf-8?B?TWVySEZudmtzbGJ3NWlnWkpVMEgvWjFHQ2xiN2lHMUt6NlJESjE2cnBXSUZC?=
 =?utf-8?B?TE9IbzBzaTk3amRqVlZsMkJhLzhEd3NiVVFwaHZkQmZxcFBKRkNuSEs1K1Jh?=
 =?utf-8?B?eThFZExLMkJYOTQrNDRjeHc4U240NjJ6MUY2dTZFdmpyRnBBUHoyam55ZjZs?=
 =?utf-8?B?a3pqWGZPL25aTWxFQ0hHVnNndS9jcTRkRUM3ZWpSQ3VibG5DRjM5amt4eWM2?=
 =?utf-8?B?WWEvVEhQUER3TG5RQllNcTBobTNUdzlpR09KQWI2c1lXU3pxWXdSOUkrYUtZ?=
 =?utf-8?B?VE9USzFBeUd4QmxiM1J1ZUl1U09rbUtad0d3R3ZuVzc3NjFhMUV1aGRsaE1q?=
 =?utf-8?B?dnNTSzZWeTdwMTBjdmhYRUJ4cU9McWVRaFFKK3M4cmlveHNHS3BMNTJvNGlm?=
 =?utf-8?B?Nm5JSVFlZVA5SkdaRHpNdmhRZFFaUkJRU09vcmJxbTVONEVlSFErWVdyeXFY?=
 =?utf-8?B?d3NVQlFETVZjNzFYcm5YbGtTOW5KMmZaMlEvRU5EZCtKQnQzbDI2Y0hDMVJy?=
 =?utf-8?B?ejk0THp3cE1IZEJoOHdnOHRua1Q1MlNBMmttanNES3NtMWpKRFBHakt3UExM?=
 =?utf-8?B?VEk1RjFVSk9KWjRjYmhKLytDVVliOFFiRitOaXFlSHN6Qi8rNnFscXYxVmtN?=
 =?utf-8?B?QmJtYW5pQzdUV0tFbHhQeTFLRHIyVXd5UTAvTG5zN1pWaXVyVjNpT0JDeGwx?=
 =?utf-8?B?YndKaTVEcm9UVmZwZkRyR2FJV3NrRm54aEpMU3BYa3pwTm5OZVAwSlF4YXpC?=
 =?utf-8?B?MlJaN1IvN3ZlNGZrSXZFMTA3NGZ5SkhmOVVQbURjQThHTHgvU3dJMUcwRGND?=
 =?utf-8?B?WlJRMmt4cy9kbmJCWkx6MlpuMG9ZUXFrN29obzBrOEwwenBSblJCWUZuQnFk?=
 =?utf-8?B?Yml6MWtMK0ZlZzFGZHF5NVJzemNKd3V3d2VtN0RRN2VIcUZHQzhFc3pIOW1M?=
 =?utf-8?B?amdOclRWUFZZc3IzNG40aldJWmFLUGVmdGp4N2d4V0MwcWFpS3gxcDNxMFFn?=
 =?utf-8?B?TGQ0SlozMVUvbEJmdjVleWsvT0loMTZwTk1nQXNxVWEybEpVUVVBQ3cyY0Vr?=
 =?utf-8?B?OFZFc1I2M1QwUWFCK01mQkZsaU92bmcwaHkxS21rL0YrY1BJTkY5MnNtZVk4?=
 =?utf-8?B?Q1VGQ2t4bk9hWks2ZzYzOEE2ODIxTVpHYXp2OHRQWTA3bEk0a0VnVkZMUEt6?=
 =?utf-8?B?RTZzTmRIOUc1MVVRNGZQN3NldUxrRlkwSUtoc3VkT3VDdXRuc3VvZ24zSkk3?=
 =?utf-8?B?azhvbCtpKy9GYjN2Wll2ZHh2V2pqcmtnOG9HNGxBdXE5Y2J1QU9CaEdVUlg3?=
 =?utf-8?B?MXRibXZsUkh0ekh5V1JMYklKL3F3amg1bHg0a0J5QllJMkY2b3pwNWNIY2Jr?=
 =?utf-8?B?blZwckQwMmxhdmkxRmh0NFBaakR4bDZJelE3NEhlL095clF3VURka2ZFV3Rh?=
 =?utf-8?B?Ym8vZGdwK2NZYm9iMGdVQnVsUmFqN3U1Szd6emd5STlkNktDVE02dlp0VDg1?=
 =?utf-8?B?VjgrWWdmSE1EdmVwMXVXMk1Qd1c0Rlk0V0ZURnRMQXIyLyswREJkMEQ2cllL?=
 =?utf-8?B?cU5wTmNjSnNjVzhZNnNHVllSMDhiMVdXQ3YyMzU1WmhVSWE0WFlzTUdFMXkz?=
 =?utf-8?B?UFFVcjl4akVUZCtDNXJhUnQ0TFZDWkJSMkRFdTFJYXN5OTR2RXNtMEhNeE5M?=
 =?utf-8?B?dktSUzFyaldoZ1cwL1lVZHBOOGZ5b2lFVVV1UEpwUmNyTzV4bmFkVGlJcG1C?=
 =?utf-8?B?Y1hENTd4Z2RwbjVZNnJ6VmZqVW41cE9wcUhGdEFOMkhkdllDamlCRURsdWdX?=
 =?utf-8?Q?6PEzmTcUuKHJePcWMcIamY7/cJbbyXhmCXtxG?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b116104-46c3-493b-e152-08da16a06122
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 01:05:30.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAHPalaqvSBPIpv++pfZtMHDGAwK/4Dldzs30w1MW9wLKGrQcPfQiBmFZas86BbJO3v+kQInZYmZ9ueXNhrlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3488
X-Proofpoint-ORIG-GUID: jQQPgw2HgjQCFjukg3iTM5rV0vYnP2OG
X-Proofpoint-GUID: jQQPgw2HgjQCFjukg3iTM5rV0vYnP2OG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/4/22 7:41 PM, Andrii Nakryiko wrote:   
> Add BPF-side implementation of libbpf-provided USDT support. This
> consists of single header library, usdt.bpf.h, which is meant to be used
> from user's BPF-side source code. This header is added to the list of
> installed libbpf header, along bpf_helpers.h and others.
> 
> BPF-side implementation consists of two BPF maps:
>   - spec map, which contains "a USDT spec" which encodes information
>     necessary to be able to fetch USDT arguments and other information
>     (argument count, user-provided cookie value, etc) at runtime;
>   - IP-to-spec-ID map, which is only used on kernels that don't support
>     BPF cookie feature. It allows to lookup spec ID based on the place
>     in user application that triggers USDT program.
> 
> These maps have default sizes, 256 and 1024, which are chosen
> conservatively to not waste a lot of space, but handling a lot of common
> cases. But there could be cases when user application needs to either
> trace a lot of different USDTs, or USDTs are heavily inlined and their
> arguments are located in a lot of differing locations. For such cases it
> might be necessary to size those maps up, which libbpf allows to do by
> overriding BPF_USDT_MAX_SPEC_CNT and BPF_USDT_MAX_IP_CNT macros.
> 
> It is an important aspect to keep in mind. Single USDT (user-space
> equivalent of kernel tracepoint) can have multiple USDT "call sites".
> That is, single logical USDT is triggered from multiple places in user
> application. This can happen due to function inlining. Each such inlined
> instance of USDT invocation can have its own unique USDT argument
> specification (instructions about the location of the value of each of
> USDT arguments). So while USDT looks very similar to usual uprobe or
> kernel tracepoint, under the hood it's actually a collection of uprobes,
> each potentially needing different spec to know how to fetch arguments.
> 
> User-visible API consists of three helper functions:
>   - bpf_usdt_arg_cnt(), which returns number of arguments of current USDT;
>   - bpf_usdt_arg(), which reads value of specified USDT argument (by
>     it's zero-indexed position) and returns it as 64-bit value;
>   - bpf_usdt_cookie(), which functions like BPF cookie for USDT
>     programs; this is necessary as libbpf doesn't allow specifying actual
>     BPF cookie and utilizes it internally for USDT support implementation.
> 
> Each bpf_usdt_xxx() APIs expect struct pt_regs * context, passed into
> BPF program. On kernels that don't support BPF cookie it is used to
> fetch absolute IP address of the underlying uprobe.
> 
> usdt.bpf.h also provides BPF_USDT() macro, which functions like
> BPF_PROG() and BPF_KPROBE() and allows much more user-friendly way to
> get access to USDT arguments, if USDT definition is static and known to
> the user. It is expected that majority of use cases won't have to use
> bpf_usdt_arg_cnt() and bpf_usdt_arg() directly and BPF_USDT() will cover
> all their needs.
> 
> Last, usdt.bpf.h is utilizing BPF CO-RE for one single purpose: to
> detect kernel support for BPF cookie. If BPF CO-RE dependency is
> undesirable, user application can redefine BPF_USDT_HAS_BPF_COOKIE to
> either a boolean constant (or equivalently zero and non-zero), or even
> point it to its own .rodata variable that can be specified from user's
> application user-space code. It is important that
> BPF_USDT_HAS_BPF_COOKIE is known to BPF verifier as static value (thus
> .rodata and not just .data), as otherwise BPF code will still contain
> bpf_get_attach_cookie() BPF helper call and will fail validation at
> runtime, if not dead-code eliminated.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
