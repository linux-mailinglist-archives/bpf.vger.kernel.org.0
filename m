Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343665A2CC6
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbiHZQvP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344872AbiHZQuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:50:19 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46716E3C0F;
        Fri, 26 Aug 2022 09:48:43 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q6QvHg007921;
        Fri, 26 Aug 2022 09:48:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UDd4y0V5gbr0fyjdCEI361TM+oD+woFPQO/znfeEH6I=;
 b=Z6DGVJSksV7ihsvHl9yvoIiWZv+GI9P0V6cw9V4WShC2cunDwRoSZmHVsiwFZznENPBt
 mwdpsmc8bPfr+qMFDb9KS6tXm/3BkrIsMXEvZdv1LjHyp4e6T8OisdOyE+hdWZhQ7dV/
 vj0Bh8fe1TtlDGYw3l3ZUgfxqDsuKZbnWBY= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6rwdb99g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 09:48:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8QhXk6hSfVNWl4rDUwxNuRZDFrPX5EFxmj2mYlMGp/S0eE9+tKJJiosPboP4D8vtPWJ+IlezZk9pUAieWJ00Se734eqQM7iDHWbpkPNSLobzg+42485eg+rMPBFbS+2dd5M2bvAHcPIGtNkEOxSyjSxPtaPHKhhImh3fA9N15/zIO9ngM6fm7Frr7ICd4fJhYEHhuI4IiFrABay0sDrIwyvH13Ll987V+EXaevG6PXV14jj7fEokQu0f+ADAjYBS9ZIbzklw8IXvyQA9cjU3X9fDA5kqnPfMXaLHUBxVOfgHE7w4W1Rn7JCtBVNi0t2KYfcaChziRS+OpklMsv9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDd4y0V5gbr0fyjdCEI361TM+oD+woFPQO/znfeEH6I=;
 b=POLA8oBxTgxOGtRN6xd4+zLCZdvhCwQv/pwslR62jhyoVZt1GGTW1PdK+wuaYeaNyHVvlvn3Zy31MVkX7s1GCbGv3Noqzjy2Epcw/IosiCURw7cCm2J+fXKVdIwPDiCHpuTELgQVZQcWN8mEBIGjHiF9yaT855yFJto6SHDXMryTd7aWclopULk5HOMkbyWUMuLcUy12DMxVaIByTRUzRpyNdzd/je15ryTb7kjoNJuN6SVrHsiMNHMt9CWDQ2yD+QrI5gfLlnoIhqhvMKjhMVikTpBhL1XsmiMSEeQ8qU5RIEnLH00WxsBKM0GlEQ35V6mMXM1uq32ExurZSlLbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR1501MB2038.namprd15.prod.outlook.com (2603:10b6:4:a7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 16:48:01 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3%7]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 16:48:01 +0000
Message-ID: <00cb99bd-bd17-3ff6-9008-92861518aff8@fb.com>
Date:   Fri, 26 Aug 2022 09:47:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Content-Language: en-US
To:     Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220826025944.hd7htqqwljhse6ht@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0532ef93-1e2d-4b2e-43bf-08da8782bd20
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2038:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nk3jQloHwgvvrPoKRI5zbt9CbZOJ3g2FolSqsZsS632X/4bB6h4p8pZ3vipa4To5oHxT49Loz6ov6kOeKMuPdaT02vZlGnLR4XECUSdMJy/8q3KMc4ZspNr8Ult8lChWYkgDyJdqTvfK5iUDMAXXUkZtZ9qa+XAwef1H4OGvPh+U/9d5SDMP5tlB6BHuf1slRCFguyAZhoqS58hZWBBk9J04Sdcf8cIgj6uY3G4D+umDqNRJXnRIc6frDJ/RZzyfqPsxk1ROgO+7d0Oeptt6GMgJzY8SBQfKafopbklADyXL5bHL1A5yuZ6VKQwixMWo0qvT0MBThFZMCHcpw3+89IyXuLOew3HB9NFXeDdIgc5i1mPBxpdNhXn7BC+tUd67XvSZnSR8kURKReAsKuacvAvpbAoEppL4cMpw+GewHljdFudjV3zcC8C4AdBPmeGWJSOZkdcOMFiRE850y3zm6ZvPIvia+ugIskktrmkmwtTuvbHCIa3QajZUWEnUQnxjFBZu8tUfFG+/HYqM4m07/yW/LR4PgoyZ6+nr42Q90oENG3hY3FgpCV0+FHNrFb+PN/K5H5/sAu4/Czvj99NZSOL8XUVLhfLAbQ0Hxcv9CEzRH/HaYFV+0VurrNsR4myMr/QPXqHauHF3cpzqThyILMTpReL0d9g3q6h2N5QL/zte7WJGRgWt0/F5h++44sMNWnHWIFEnKjaLEvZyyjkU5LClHZo3VMuamagLk7zGODLmtQmXp9qtSsi3upvp2hMwH8j5KiDgGlB2tBSBQZBpVaeW1750oKJO9+6IEjTxDlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(186003)(2616005)(8936002)(53546011)(83380400001)(6512007)(5660300002)(41300700001)(36756003)(8676002)(86362001)(31686004)(478600001)(6486002)(6506007)(31696002)(38100700002)(66946007)(316002)(110136005)(54906003)(2906002)(4326008)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SElkditqY2ZzSlVpUEVCQ3pmYitHdXBGL01PdXRxYTE4eVhINkY2eUE5d3g5?=
 =?utf-8?B?a2RaLzNFaW1vUzNoQmJIbWp0R2U1OXpOS2xBaDhwdlU5eUVoT25tWXdQQmZQ?=
 =?utf-8?B?OW9MYXBUcDJYRDIraklaVkpOZGpmQTBheENlY1dncVRQZUxCbVlwSmRaRy8x?=
 =?utf-8?B?TkRtV0pQT1I0Z01sZnRBWkZ3d3piS1VSNURtOWRsQjVNL0FWQW1rUTVka01x?=
 =?utf-8?B?Ykc2MmZBNXhuQVR2NmFhMkdCNDdlMEJsemo5YTcydVNQc3A0MTk4d2J2SXBH?=
 =?utf-8?B?eWtkNTZGbS9mbHA0NFk4N0htMmhNdnFOUTZsV0xESmw3NEt2NVYwY01IVkVM?=
 =?utf-8?B?MWRvU0NwVHZIQ1hZbGNFeEE0bWs1U3lPY0Nyd0FETWpuZ1B0ZElQd0Q4bWdD?=
 =?utf-8?B?dkVZNTMxaUZOS2xhRlJxaEF0RmRHL0U0SGQwYlJGWmp2cHhweTVVRkVhcFB0?=
 =?utf-8?B?RUZBa2NZTUNKdnFzRU9sZTZVMnFXODNrcDZzTlUvMlRDV0dlQzEzaTJoWG5u?=
 =?utf-8?B?QkhuZDkySnZIUEVRSTh5OUFRTEcwaWZOd0hITFgydmdxVmJHVWpYOGJJNk1L?=
 =?utf-8?B?emxDczBZNGYxcEpVRW5NS1BWRU9FL0k0VmJZRTBuNkl5VVQ3MFNBQWlLQSt3?=
 =?utf-8?B?MDgzeTRWZExSRkMzRmNMNUhaVkxqVHdyRXRVQWx2ZkNHQWY0bnpDLytiYXRp?=
 =?utf-8?B?MEJreGRKZ1RkN1Fvcmh4RU1iL25rYVh5M0tBeDlGNi90U0lKa29iNGZKaHUy?=
 =?utf-8?B?ZHBobkltRUQ3RlhUakdMc1RxUGNNaW4vZXp3VmJYS21jWnR5Z01ubzdwdWZ1?=
 =?utf-8?B?R2xxRDl4RUxZVFZYNnBUN3lyTjlLcm1HekphRHNDWkJ0dHZZS1E1OU5nU05t?=
 =?utf-8?B?L1M1S2dBdWoyNS9xbzM0ZW9GYlQ4U0tRT3BOSXArQlNmd1cwV0RNMytnN2g1?=
 =?utf-8?B?K3cxNG91OGhhdk9zY1R5UGxkR1JWanUxdXVxTDZiSDVFbG9pNmRvWEVTWTVh?=
 =?utf-8?B?ak9lTDBEMjBTRnFFVTM3SXl1bUdRVUZvM0RVVWs2M3EwQkdmRitaR3F3MWRQ?=
 =?utf-8?B?WHF6QmE2eDJOOStSWlgzS3QxTDZxRkFGdEw2WW1tL3dCUSs1ZFlmUjRUY3Rv?=
 =?utf-8?B?a2JxZmd0cy96cE5qT0NsK0xFRVFrbk92dElEaWJBa2VrUFBOSElUSDdrUVh1?=
 =?utf-8?B?dFpVbWZ5ZHd6SlpwZFBUUmVkd2ltOHRzNTBnL1Q0TTFYbTVUZzNrVjRwY0ps?=
 =?utf-8?B?MkxXQjVxS2dNb3QxaEFiZnFqajhWK2ZlZ0lpMjBMazhramk5Y1pCaHd1QStz?=
 =?utf-8?B?NXBtVFN5MXoxdVNrTjB2elNSRjRpbGJXMkk5RXZWQzRoYzUwM3JoVkwvWGRC?=
 =?utf-8?B?c0pyc05SUWtQeXVKb05LSmRXWmRTa2p6RndUZHFDS3FkMGc5VXJrNmhjam1F?=
 =?utf-8?B?N3lyZnh4dm4xbnloU2JQaE9SUmMrK2VkNW9NS3g1RnRHajFHQmJMK0FYRjQ1?=
 =?utf-8?B?Vi9HRGNzbmhlamcrem9yYjhiMGhWellOc1NXK3k3bi9Xbi82dlZVTGdCd1dF?=
 =?utf-8?B?Z0VIU0tJK0oxZFhSeWpuRzlrZXllb0tLc2Qxd3piU2JraTcwdEpYd0Q5amZF?=
 =?utf-8?B?cm9jeHFNNHZhWXVnOC9PY2pxdk1pS2J6TUtJZS9YU01DeW1zaHg4N3Z3ZHVx?=
 =?utf-8?B?MU1SMzAzZVkxV2VHdnRvM0lSNm8wd0tLUlZNYll5NHJQR0tmajJKY1FWV3lq?=
 =?utf-8?B?SHVEL3Rvb0hGSGN6WFhLdjFOd1ZzemRYc01YUWRxcTV3TTcvVHZHWFowdlgy?=
 =?utf-8?B?U1MvU0xoUDdhd0RoQklEZTFucjVyY1RQM1RsSnQ1VTUyTnVMYlJoYzZJc3Ra?=
 =?utf-8?B?THJKaS9vKzJCdmZXdDhyWkNEMEFWNzNtaWd3N29wQ2V4Y3ZqNXZLbC9wTitT?=
 =?utf-8?B?T3BtYnB0V2dDL0pQZmRtNDdyZ0VYZ2VWN1BHemhxZ0w3L0VCNmlCd3JsVFl5?=
 =?utf-8?B?cHJXRUx3aVVGejFPUmZrN0dTOS9oZnBtUnNYQ25aZk1zaVpubER1NHZpcldo?=
 =?utf-8?B?Y2xlWHB3OXk4dEloT29SUWxoOEVxV2xjbFZQT1dnM0VUK2dnUmtDZmloM29W?=
 =?utf-8?B?VThoalczdjlPQ3dIQ2R5UGJNQ21mZnNkWlQ2dzRzY3dBOHZrVjI3Q2tHbnNO?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0532ef93-1e2d-4b2e-43bf-08da8782bd20
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:48:01.6259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBqH7cYZ54LRgSjVApMC+wJ89HynWz0zQlsy2mBjjvUlJEzge8GPqOpVn1oe4jYa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2038
X-Proofpoint-GUID: MLxxof3I2l5WXNhn032TK7NrOVK62d4U
X-Proofpoint-ORIG-GUID: MLxxof3I2l5WXNhn032TK7NrOVK62d4U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_09,2022-08-25_01,2022-06-22_01
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



On 8/25/22 7:59 PM, Vitaly Chikunov wrote:
> On Fri, Aug 26, 2022 at 05:52:20AM +0300, Vitaly Chikunov wrote:
>> Arnaldo,
>>
>> On Thu, Aug 25, 2022 at 08:16:20PM +0300, Vitaly Chikunov wrote:
>>> On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
>>>>>
>>>>> I also noticed that after upgrading pahole to v1.24 kernel build (tested on
>>>>> v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:
>>>>>
>>>>>      BTFIDS  vmlinux
>>>>>    + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
>>>>>    FAILED: load BTF from vmlinux: Invalid argument
>>>>>
>>>>> Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
>>>>> v1.23 resolves the issue.
>>>>>
>>>>
>>>> Can you try this, from Martin Reboredo (Archlinux):
>>>>
>>>> Can you try a build of the kernel or the by passing the
>>>> --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
>>>>
>>>> Here's a patch for either in tree scripts/pahole-flags.sh or
>>>> /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh
>>>
>>> This patch helped and kernel builds successfully after applying it.
>>> (Didn't notice this suggestion in release discussion thread.)
>>
>> Even thought it now compiles with this patch, it does not boot
>> afterwards (in virtme-like env), witch such console messages:
> 
> I'm talking here about 5.15.62. Yes, proposed patch does not apply there
> (since there is no `scripts/pahole-flags.sh`), but I updated
> `scripts/link-vmlinux.sh` with the similar `if` to append
> `--skip_encoding_btf_enum64` which lets then compilation pass.

Right, pahole v1.24 supports enum64 to correctly encode
some big 64bit values in BTF. But enum64 is only supported
in recent kernels. For old kernels, --skip_encoding_btf_enum64
is the way to workaround the issue.

> 
> Thanks,
> 
>>
>>    [    0.767649] Run /init as init process
>>    [    0.770858] BPF:[593] ENUM perf_event_task_context
>>    [    0.771262] BPF:size=4 vlen=4
>>    [    0.771511] BPF:
>>    [    0.771680] BPF:Invalid btf_info kind_flag
>>    [    0.772016] BPF:
>>    [    0.772016]
>>    [    0.772288] failed to validate module [9pnet] BTF: -22
>>    init_module '9pnet.ko' error -1
>>    [    0.785515] 9p: Unknown symbol p9_client_getattr_dotl (err -2)
>>    [    0.786005] 9p: Unknown symbol p9_client_wstat (err -2)
>>    [    0.786438] 9p: Unknown symbol p9_client_open (err -2)
>>    [    0.786863] 9p: Unknown symbol p9_client_rename (err -2)
>>    [    0.787307] 9p: Unknown symbol p9_client_remove (err -2)
>>    [    0.787749] 9p: Unknown symbol p9_client_renameat (err -2)
[...]
