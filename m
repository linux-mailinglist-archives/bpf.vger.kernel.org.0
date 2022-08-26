Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449905A2F71
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345208AbiHZS5M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbiHZS4r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:56:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0DE97F9;
        Fri, 26 Aug 2022 11:53:43 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIPDrV019891;
        Fri, 26 Aug 2022 11:53:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CT54ywvauZnQU0RW9MHUT7VedERRjg+cyEAsrnz6Cvg=;
 b=H+SzhY0Iy9sAsHMJMpbGpx30nXZOeA6F4nT2lG6LsdpJOLhaF2BhjaUNOn3oHCIVfjIj
 +0DCvlMvW54lB9rkwCb1EUnTqDzsDD51VTA3shkLKn/u8FySmSXEbMNK9gvmyFL2wiXq
 SyM2S09fOp+KhU4PTFRSGzbtPqJv4JwbV28= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6cfwrtcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 11:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNmntAHFIYsV2KmH9VUQON/TybFUKNhI+/CtuLXTzvvBWx7BUVcPJ0DowMwqh6aEPilBDxymF3Bk3B49dwpZT0eaBy2pMTAkFxskvAaHBk44Y1LLEeUhfwuTGkCOdY1+ECH3J5e7JwJz5hD3KolmJH3ka7x6nW5/BE7NpMm752mYBW1psRuqzJv4XZTuDQi8CLmW3M6IeHH7WN8iIgqvXHQK9/kCkA2e5hW52PuL/prvv1qOuYHleYF8kh6X0PEa7sxpukre93ZlfVjtVMGnZislPgeKmE+fFFPCrM0rEER20jemweWx1sJc6WTVqH7a2PxowrxPmIFngxGGiSUM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT54ywvauZnQU0RW9MHUT7VedERRjg+cyEAsrnz6Cvg=;
 b=OiuIH61lU8zi/+Qzx3uR03xxPSYn6fYIrbXM8ZVuJkmnCVq4FXGMEYrk9CHMHc06hwY/a97gEHvAyqRWre6YqLDNjKN/jkQTGCA1KpUV912rb/jOHzndDzlaau0m5ZwhhpGK+5uWJ7NJa7hw67PTMpRYDYoqAPlUeMsxEtLE5MiBjA4eOiMao447wqvcCJdLCAoECkpVdASEwm/IdSWMMxV8N5U6xptxm6vcf8jyBoYRMRXb/rop9yldQHb1TYQ3PhHlUjMe6iI+100R+cZnT/7v+1uj/bTnrYS6Jwc6n+N1kc8vVwx37LqR0nWcAz8yMZUz4LpH9nltALX8/P44Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BLAPR15MB3857.namprd15.prod.outlook.com (2603:10b6:208:277::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:53:36 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3%7]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 18:53:36 +0000
Message-ID: <2b8a762d-d013-c1df-1be0-29df6126f8c6@fb.com>
Date:   Fri, 26 Aug 2022 11:53:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org> <YwjQDBovX+cX/JDJ@krava>
 <800bde36-6cb2-d482-0cdb-b3d6005b41da@fb.com> <Ywj8VBH3Ud6493/z@krava>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <Ywj8VBH3Ud6493/z@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acc44b18-0e75-43eb-cac4-08da8794486d
X-MS-TrafficTypeDiagnostic: BLAPR15MB3857:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUWKBhUnnGOTBlRosYpBgDqTy3S4NKQtIrd/rDGguFsPVArbsEHlxM2t/NfqaKXggeS6/G4fnKuyVexFgJ060QZU5gityQ9R+LCkWCgrL5Or9qu77zmEhg6+YVST5K3sKd4Wop7dKpJEmMxTQgRTlXUXQFCoNC2qBYbIVC0f5ujHbsqXnwm41GItSPurEF2GNw09y5bzH7V8FcWnAnq3eIUjkT7kClPcT/GDhtETykhlhtpQU1cIqc5YTbnA+FSZzDmDxMPlJ/a5THDBKZl1xAtsijhnq9xQ8PobYZq/W3q+tx3G84gLJdGvXd5iUmkshF6iBorVvpjGKf5P0T88L67zIDIJgFwR7sqpXql60Aai7bIbFv8fXVx6tkZjrnSPFu5XbOFNJNcyqU1xhioAaix1hJCHv3oY3dfLE/RlxHgH5E5Fl2NhDoVDD2cCm/LgBEMjCyC9+UEW6Ocy07+9HhVrjMWQb4T8NqzKqyDE8kFYTSJ7ITXWpHbpA6okDi/WXdUBwtzpnsHt+XzBSOBcUpzTJwY7UJA0GHCYoczjAQzyt47IdWu7EOa8rcJEBlK353f8mHCphoxk3ezPOThSOkt853fs7uwf/3xMbt7quXvlDYURkpSn5dSTyk0eTAj70ePQ4F6TEahOoiEx5Y9JYKbEVN1KSyvjVae+tJSXQDp36bFfzuryPlMmuKQrlxjxEAbRaUiQC4pIXEV2m3GZQrZfyD0yEPFMBm3vymU0C2euv1tHJMP/n7K1FcNd6++nkb/9fQTvq1NSv68hg1ISBt+kpc1wl6wFpHcKRhOaGiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(66946007)(66476007)(86362001)(31696002)(66556008)(6916009)(8676002)(316002)(54906003)(478600001)(2616005)(6486002)(186003)(38100700002)(6512007)(31686004)(8936002)(6506007)(53546011)(36756003)(41300700001)(4326008)(83380400001)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXNXZVdnT2NPKzBteFp6LzVoUWtoQVg4Wm5uNmJacS85NmV5aUV0N0xIQWdt?=
 =?utf-8?B?clNUN1FaZ1RhUm1sLzBnVWQ3MVVnRmovWk4reEpySHVCT2tGNUl6dUpKNG53?=
 =?utf-8?B?U0kwK2VNQlJydDRDZ28zaHJMU0xsemR1ZzNvM2hWOGtMQ1FSSEpGK0txZk9x?=
 =?utf-8?B?OCs4ZTlQZGx4TW5UN1VxVk5xczl4N0E5dkFlVjYvenZHVENKamErU293eHQz?=
 =?utf-8?B?a2Y0Q1gwSi9waFhtSm95dHRzVjYzTStWdURrTzRXR1FhdHJKRFhmbmpEaDVS?=
 =?utf-8?B?WkplSG1FY05EVnFOUWpFMG5BN05NanlYSWJjT25MaHVrLzU4WWlHL3VZT2dr?=
 =?utf-8?B?cnRaSGtNeGJJditSdEV2Rkx0VmZIdFJHcU9qZGdlWERNdFJDMEhWeUNpLzZQ?=
 =?utf-8?B?TVk3TXNqbnQzT1lPaS9qT1dUWnZrcUtONkwvSXZQK2YwMk5FVXFvTnJqZjBk?=
 =?utf-8?B?aVMxVkxrNDg5ZnRzVkI5bVVxY2E3bUc5QlZZNElUWCtGOGFEZXFxUXRERjBa?=
 =?utf-8?B?MXhUVEFib29TWTlVM2NXVFNSZzNJakxjWmtpd1NISElPekYyQWVlemg4aUJK?=
 =?utf-8?B?dnhQN1pqOVhBREN0ZUVlblBUcitXZVJ3a2VuOWJQUVBkODdtYiszUE55USti?=
 =?utf-8?B?bUVPUGhNNFByNXJJRnYzK2wzaW42UGVUWjdhOS9YUlpwNDQ2dEJTei9maG5I?=
 =?utf-8?B?YXdIRFczcVpabEVTV3hLVS8xZE9hUFJPUGZaSFVXQ1gySHNRakc4ZHpwdmZ3?=
 =?utf-8?B?QmZ0Z3RzeDc2NDRZMmxBcGdpOVQvQjZLamhKelNDNkYwV3VEb0xyMmtRa1lx?=
 =?utf-8?B?TUp1Q1MrK2ZCRjBKKzJ3QUdjaHdzUXRKRE44c2ZFUEoya0d2K2l0R1RRZ0Y4?=
 =?utf-8?B?UGU2NVJJcjdYZ2ZERHhXVEdFeUs4SUpJaTRYWVBhWDFYdE5wemt0TmoxbnZZ?=
 =?utf-8?B?VStMYXFuV1p0bzBlNUlEMmpEMEwyWE1FR1RIbEZ0QjFpVFh1cU9NSXdOblV6?=
 =?utf-8?B?cjdudUhRQ3RQYkkyYVNoQzNDTjhHTUhRK1crcGFGNHhENVg1MEdzMkRUUFFT?=
 =?utf-8?B?bGRaYzZpN3RoQTd5ZVpmVkFwWW9SbDVtLzJnbzVsNzNuNkZGT3E2cUo4UmN3?=
 =?utf-8?B?OVRJVmtuZEJRcnZkQ2I0bzZNNUNNYnEvK3YvWU9URnV2SElCVmxlWWtmRWdr?=
 =?utf-8?B?bWQzWWNSTFprMXoyNUlDZ1p4ek5QTlNSenpXUzNCSUEzeG8zYzkxdWllelBB?=
 =?utf-8?B?RkY4WElpSmd2L0NzNzM1N2QydGRLcUhhVG1VbWphWkhnTmpMOGN6bGd6Q2VO?=
 =?utf-8?B?OWp3Q2hlM1NFU3dzYUxZUGwrdDNhQ0w2aDRuYklrR3E1K3B2ejZrODFVaHRx?=
 =?utf-8?B?Zlgzd2cvY01yOCtyVXNWM0NaaFE4VkNtQ0tYMFhkNmIwenZQYzhyZUxjbWVG?=
 =?utf-8?B?bFQyUEN5Q3QvK0xoNDZ4YVRGK3BXWWFVQUk1VUhpc0N5dk11NUdhZFhFd2ow?=
 =?utf-8?B?a1M1dTY4b1YzMkVjMW9yeVVxbUs4aVZLRndzMXRJNC9DemlsM3NaZUgrTWFV?=
 =?utf-8?B?SCtOeExMYlA3alp1UkVSbHYzbkNUcFBUMDJlNW5xMW8zN2V4WDNsL214NkZz?=
 =?utf-8?B?TnRINlFHL0tKcXlNODNkd2FDNk1rSXZneTR3ZW1DK3FrdXJPaHI1SGhrTDRU?=
 =?utf-8?B?SW4yR2tvdFI4QWRNbUNPZkxCaWx2SjdDL1JvcGRaSmpQLzJjSThZVmdLQktu?=
 =?utf-8?B?N292N0lSR3RhZVVPUnBxM1owWXBiRlNkYUhmalA1MnptUVFvSFpyc0NpdGx4?=
 =?utf-8?B?RGZ0QUxwM3cxbUlHMGxhZjhTK25IUEZBWXRRVDFVdExPckZXR3hTOXZRdDJ1?=
 =?utf-8?B?M2IyanpRYW5PejZQY0xhOHVtK1JZYVVRdXZhZEtBWE5jbUlWWlJ5VG5vSnAx?=
 =?utf-8?B?UzhnUDNnTXBEcitiY2RtUk9ocHNNNk42dGJBQld1V3JWdTlTODZMUWVCWGpu?=
 =?utf-8?B?dnZrN2hQQWpNT1BPS05mcDBwZUVKQkVIUGdCTks5ZUVHTEFYUmlCU0VGWldt?=
 =?utf-8?B?K3lVVk5PYjBERzZWNGhwZnVLWnBoWk41Z1oxcXJrVUd6MDZ6YnBvUzBnbTBT?=
 =?utf-8?B?UzYwdllDZkVqZWRRYk8yNE94bHE3MGFTampnZzllcjNwakExUkJtVVZmeEND?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc44b18-0e75-43eb-cac4-08da8794486d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:53:36.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stBhA/f0kW8ClcTLy5SL4nLYYdlhau2Ghoe/r0dvpRt1POAIqzJ1n5z3cc5ByRlq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3857
X-Proofpoint-GUID: H97dkEJSxjHRLnErMzYOaCUC9R0r9pcC
X-Proofpoint-ORIG-GUID: H97dkEJSxjHRLnErMzYOaCUC9R0r9pcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/26/22 10:01 AM, Jiri Olsa wrote:
> On Fri, Aug 26, 2022 at 09:51:54AM -0700, Yonghong Song wrote:
>>
>>
>> On 8/26/22 6:52 AM, Jiri Olsa wrote:
>>> On Fri, Aug 26, 2022 at 05:59:44AM +0300, Vitaly Chikunov wrote:
>>>> On Fri, Aug 26, 2022 at 05:52:20AM +0300, Vitaly Chikunov wrote:
>>>>> Arnaldo,
>>>>>
>>>>> On Thu, Aug 25, 2022 at 08:16:20PM +0300, Vitaly Chikunov wrote:
>>>>>> On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>>>> On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
>>>>>>>>
>>>>>>>> I also noticed that after upgrading pahole to v1.24 kernel build (tested on
>>>>>>>> v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:
>>>>>>>>
>>>>>>>>       BTFIDS  vmlinux
>>>>>>>>     + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
>>>>>>>>     FAILED: load BTF from vmlinux: Invalid argument
>>>>>>>>
>>>>>>>> Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
>>>>>>>> v1.23 resolves the issue.
>>>>>>>>
>>>>>>>
>>>>>>> Can you try this, from Martin Reboredo (Archlinux):
>>>>>>>
>>>>>>> Can you try a build of the kernel or the by passing the
>>>>>>> --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
>>>>>>>
>>>>>>> Here's a patch for either in tree scripts/pahole-flags.sh or
>>>>>>> /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh
>>>>>>
>>>>>> This patch helped and kernel builds successfully after applying it.
>>>>>> (Didn't notice this suggestion in release discussion thread.)
>>>>>
>>>>> Even thought it now compiles with this patch, it does not boot
>>>>> afterwards (in virtme-like env), witch such console messages:
>>>>
>>>> I'm talking here about 5.15.62. Yes, proposed patch does not apply there
>>>> (since there is no `scripts/pahole-flags.sh`), but I updated
>>>> `scripts/link-vmlinux.sh` with the similar `if` to append
>>>> `--skip_encoding_btf_enum64` which lets then compilation pass.
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>     [    0.767649] Run /init as init process
>>>>>     [    0.770858] BPF:[593] ENUM perf_event_task_context
>>>>>     [    0.771262] BPF:size=4 vlen=4
>>>>>     [    0.771511] BPF:
>>>>>     [    0.771680] BPF:Invalid btf_info kind_flag
>>>>>     [    0.772016] BPF:
>>>
>>> I can see the same on 5.15, it looks like the libbpf change that
>>> pahole is compiled with is setting the type's kflag for values < 0:
>>> (which is the case for perf_event_task_context enum first value)
>>>
>>>     dffbbdc2d988 libbpf: Add enum64 parsing and new enum64 public API
>>>
>>> but IIUC kflag should stay zero for normal enum otherwise the btf meta
>>> verifier screams
>>
>> This is deliberate so we can have sign bit set properly for 32bit enum.
>> To avoid this behavior, the correct way is to turn off enum64 support
>> in pahole with flag --skip_encoding_btf_enum64.
> 
> I used that as well, it wouldn't compile without
> 
> the error is during the boot where the standard enum has kflag set

I just tried latest bpf-next, using pahole 1.24, with and without
--skip_encoding_btf_enum64. The following are BTF encoding
for enum perf_event_task_context.

enum perf_event_task_context {
         perf_invalid_context = -1,
         perf_hw_context = 0,
         perf_sw_context,
         perf_nr_task_contexts,
};

With --skip_encoding_btf_enum64:
[2285] ENUM 'perf_event_task_context' encoding=UNSIGNED size=4 vlen=4
         'perf_invalid_context' val=4294967295
         'perf_hw_context' val=0
         'perf_sw_context' val=1
         'perf_nr_task_contexts' val=2

Without --skip_encoding_btf_enum64:
[3786] ENUM 'perf_event_task_context' encoding=SIGNED size=4 vlen=4
         'perf_invalid_context' val=-1
         'perf_hw_context' val=0
         'perf_sw_context' val=1
         'perf_nr_task_contexts' val=2

encoding SIGNED means kflag = 1 and UNSIGNED is the default meaning
kflag = 0. So it looks okay to me. Could you try to use latest
bpftool to dump vmlinux BTF for your vmlinux binary?

Regarding the corresponding pahole enum64 support, we have
the following code,

         if (conf_load->skip_encoding_btf_enum64)
                 err = btf__add_enum_value(encoder->btf, name, 
(uint32_t)value);
         else if (etype->size > 32)
                 err = btf__add_enum64_value(encoder->btf, name, value);
         else
                 err = btf__add_enum_value(encoder->btf, name, value);

If skip_encoding_btf_enum64 is enabled, the value will be passed
as '(uint32_t)value', so '__s64 value' in the parameter should be
a unsigned value and 'if (value < 0) ...' should not be
triggered if skip_encoding_btf_enum64 is enabled.

Jiri, could you double check your build environment?

> 
> jirka
> 
>>
>>>
>>> if I compile pahole with the libbpf change below I can boot 5.15 kernel
>>> normally
>>>
>>> Yonghong, any idea?
>>>
>>> thanks,
>>> jirka
>>>
>>>
>>> ---
>>> diff --git a/src/btf.c b/src/btf.c
>>> index 2d14f1a52d7a..53d7516e4b89 100644
>>> --- a/src/btf.c
>>> +++ b/src/btf.c
>>> @@ -2151,10 +2151,6 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
>>>    	t = btf_last_type(btf);
>>>    	btf_type_inc_vlen(t);
>>> -	/* if negative value, set signedness to signed */
>>> -	if (value < 0)
>>> -		t->info = btf_type_info(btf_kind(t), btf_vlen(t), true);
>>> -
>>>    	btf->hdr->type_len += sz;
>>>    	btf->hdr->str_off += sz;
>>>    	return 0;
