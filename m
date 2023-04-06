Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7730F6D9DE5
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbjDFQtq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbjDFQto (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:49:44 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B112D
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:49:41 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336EEhL9032570;
        Thu, 6 Apr 2023 09:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=fQn8eF4wIvkUt6I8ruVVeVUb1UojRMXXrnc2qBR17Yc=;
 b=OLM2XrLzPro3HRnXEhgeSIAADW8uz0zfZnzAxgVYpbIueD5Mmx3okEEv7TrLjIMqyr+c
 iLaatgMDRv6vRhX7sIDR+s4yMjbUgWLOEZexLh44P1AdUV6iYsy/2+OrvkwdPSNHmAxG
 XQYFh3XUNG46EgMC2UU0n7/E5biys5xWRxrtQKdnolMM6ZbGp25euBqp874FBoXf82W8
 WNUEY3fRKbeHH0B19ddppJILLSmseu3HmekqNsmRiGHRmX7KghUrJcyBU0L4zuyy9SYe
 1rXkO7qkzyYk8Q3iro/07joaUCfUQvVLuyRa1Dn5TqXVVALW5xctmmFbdJ1kexl/zu8B Bg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3psynn14ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 09:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/E+6uu9x0KH7V3cGqAWc3t/HPZqHVrkcB2PLV6W3rRdFcsiAmcgWnTJhTOHTLTeXWDUiyWla1wqH9FLJdVeOQkDI6r2TBLFzvqkTwArcU8r5iAiBdRDnSnH8vpkZ1WZTvZH2HJcmYRZCIrise0IzcxK/afRx+0JUKk3Ztpy9YLruLo43IsSOAnUC8P50pzowOoAQ06mbPhXQqufHFT+3GaoZQr3rZxQSWpI4JG3tz8It//Aqsh/P53S3AhDMowWhf0e34pSmBIYD192Lt4dyhIefY+4nMresKBC4tErkLF8SYfLoLOCDLjDYuDx7ibFpIQ2QmHqtl7YeFIcMx+wPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQn8eF4wIvkUt6I8ruVVeVUb1UojRMXXrnc2qBR17Yc=;
 b=UQCQ2/y1T3LhOCh1yjjqfHmRSKjWF1F9gHypsjK67qJQeK6kqjxzDbQfEICQ7xRLGDf+XW0+MfssaL4qctdrpUik0ktIktyhUl421bOGK0mEvAIfHQOD7Dv4a2xnQgPucC1y8tqxQq45orpJne1OeRJC2QYQwZC4TEelH0URigTux7z/Wyq3eCeTJLfXvt9wZmQuCyj/Kgs28M/bpNbhw46wWY1xWeTtPnB73vNUzSw0o2cSnDfte/b+WMNbZ6zPTReH+1v/1u+sjbUNZ5knk2ZNm3O/B29mXiqZWsNzUwgEmblwBXjpGWAVa9KDn/3bYOotb86z2qAtdhlVVAQiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5355.namprd15.prod.outlook.com (2603:10b6:8:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 16:49:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 16:49:23 +0000
Message-ID: <b73075cb-67c4-2144-64f9-fc564eb00833@meta.com>
Date:   Thu, 6 Apr 2023 09:49:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next 0/7] bpf: Improve verifier for cond_op and
 spilled loop index variables
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <CAEf4Bzayt_FUG6JyMzU060swqP_w=W9TFJOKD15ux6GNDm3qSg@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4Bzayt_FUG6JyMzU060swqP_w=W9TFJOKD15ux6GNDm3qSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbf4556-78cd-487e-4223-08db36bedfea
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3D5whsgg6lc6dqGnZsZQTnbbWjI2KEsHwv/f7oreTNVb1E8vk19RBnVO2u9mKRxlaCUxjVcVt5BGGSSJV3jxMFSn8bJBpYT9tmaOgfo6eZ00cq9zeLDqEgaROV8l5lYRJe+vSxNFZ4SPVF+SRG5Nj3vK2hqcncMm4/MmJko01pyRsDjZmPC72qL1LhAOwD0/VKHg2+9eLfmWwDRvvTw9Xy7vHmbN2y0wvIxsTI6+i0NCCjn2NbMrLMxU/DZRwRERv310wGamHWKT70Tx1aoV5yvbwotQDeN6j2xfng2nm8jaqZBiTJTm9ZCDDmLYcGtYy/roh8xeqXwy5Rojfb67zBbxahwxmEtf303udqBlMdJIXuQPCMZaNqpRW/aeKlJ9isu6ptd9AiEOwUNm71P5o1pa4rZ/DbskZRJUopoW8VttgwI94cWDNXkzuzVD5LcLR+YBaKU0br73P/M4s4DTgBUPpMwuqsBCsG5tT1Tp+srK928lR1goyCcyROgWEaJjcctFH3CD7N0IgVW22/MKEhyfG0OzCppM8J75at9GR06bEE03mpFP5vk0OERrnjSGquR3aEQFHZb1uPf9J2pd0FN5nBJN4MbsGla1MZwKjhhrO75vMg3S+IoUGPWziWPZe/0i5IBPjdzagovS2978Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(478600001)(66476007)(66946007)(8676002)(66556008)(4326008)(38100700002)(110136005)(41300700001)(8936002)(54906003)(5660300002)(316002)(186003)(53546011)(6512007)(6486002)(2616005)(83380400001)(6506007)(6666004)(31696002)(2906002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEI0UWtrNTFiU0UvZWF6NVYwMlRUYTBxUkpEUUZ1NkFtbkZXcjBOaXA4bW5l?=
 =?utf-8?B?MVB2YUprTEpYQmcvV3lZYlVHSWlsMGlsRHByVVA4RTFQVUhKeitxYi9VSDNk?=
 =?utf-8?B?ZDNLVmpFcndkS1huMGhBS1UzbU5UaU83M0xNRVB2QW5aMEk0Q0FZM0Rkb0tr?=
 =?utf-8?B?cUNGcHp4alROU1FwajlXOHhHa09JZm5VUjB1YXVOanBZRzBpblhTQ1R3bVFX?=
 =?utf-8?B?QmZmenlZNGxCdGFENUhRM25BNWdKU3VPZFdoQUFGdThXcXg4aXNQNnpnM2tw?=
 =?utf-8?B?L1orMDdFZE9CdzBCejJYblhncmRIVFFjekZlYVBEOVdvK2NBcUswd2l4cFlp?=
 =?utf-8?B?d0FSTkoyL05EUWZTMXZQWXM1NmFvUjBHN0xJSFFOcjBNanEvRWNteEkxYzdh?=
 =?utf-8?B?amx4MHFwb216WjNjY1dPYkd4dWcxMnIzNEdMclVqN0FjVDVieUNQNFZweGFQ?=
 =?utf-8?B?c21tQ3hZeGxya3EyMThDanVTVDdZMUVFY0U0U1JWSmhBL0MvU1crem1sR2dH?=
 =?utf-8?B?azAvSzZCb3dRdDdrWlRjZWhBVllaekdqOTJYTXIxS1RxeEJ1Q2U0ZFRmUEJC?=
 =?utf-8?B?NjArTzVVUFdYTXlkWlJ1eVZyM2RJOS9ESkRmTWQxQzRmTG9Zeko2WmpCKzQy?=
 =?utf-8?B?QWxMMDExN2w0QW1YQllKeFluNldyR0xMSmRBQW1SUmpTbEIrY1ZESmorS1Ay?=
 =?utf-8?B?emtkTFZ0OEcxVVhIS0hPbzdsMGRSdjNBYUdVKzlDbFlkUDhzNUM1N21id25T?=
 =?utf-8?B?T3pEMXhSZWZ2OE5zaWgyZlRDenVZK0dvakVJQ2hMVGxwUXlsTUJORTFNKzhu?=
 =?utf-8?B?MG9Eem83OGlpUnY3TTJyWk0xSkJEc0wwZlpQWFpRZ1YyVUFMNWtuNEVqN3Mv?=
 =?utf-8?B?akJUbHN3Um43TDd3dmY5MlRacWtXTFJ0eThMSjY5WXBjemhzbHVwNTV1ZkhO?=
 =?utf-8?B?bEJhNG1NWUsvelExbEpqZ2VUajM1WjgyOVZUQ3BIQUVYK0dJdGZhZlBYdkdN?=
 =?utf-8?B?Z3FhVmN4clJvZGplUkRpek44MGlqR2c5dEZDVVIrRVFmMEpvc2lRTnU4VlJV?=
 =?utf-8?B?R2dDRThtMlRIRS9EWTdiNGRNNTVYRkpob0lmTlRjY29YUUdRQVZqc05SaDU0?=
 =?utf-8?B?eUpxZ254ek8xOFZubk5wUWI4RHJoRjE0R2VmSHpRMzJSZVMrVkZVU1RrcDN4?=
 =?utf-8?B?SGE3UWVPcVFwclRlcE5jUnBGSnBnNDE5Ri9UcjdMYXFrVTdQd2xHU2IveUJM?=
 =?utf-8?B?M1Z3Z25pRTgwcHBTV0lsS0E2UVNKM1FKdnFuUTlGL2NpMmM2Ym55SlNJbXU5?=
 =?utf-8?B?czY2VWZhZGN5S0l0TFJWSU1heGs2blFDRndOQlRMZlEzZVFVWDQxejNHbEFP?=
 =?utf-8?B?SC96bC90VVdqQm9NNGpoK3RaWkVtYmRmN1ZlL3d3OGJaNFh2VTdMZU1iTG5o?=
 =?utf-8?B?VGRMZjRnczI1b241elplQkJrUTRUcEIvcTMvaDNjR3VzVjZZSGZGeHZNMElR?=
 =?utf-8?B?Nm1VaW9qYXQyK2ZIN3RsVWRYWVV6djZzSkVFZzVHME1kQlJmTldkTFFSb2pz?=
 =?utf-8?B?b2lMalpwODROdnFuMitVcVBCT2ZXdkFDZENQVjVKYUc2bHVWOEp2a2w0TkZl?=
 =?utf-8?B?MEs5Qk1xdlBZZG9oTVdjVW94ZEl4d0VrUTFOWVJVWEJvRVJIK3ZYZmhmRWh5?=
 =?utf-8?B?bXlteXdTVy9ERkE5TjJtTHlZOSs4MEJ2Sk1BWU1ZUjVNN3BYWGc5MzVYR08r?=
 =?utf-8?B?L0JSSzhSajV4Zk94MFNVVWhKUVI4eFE1SWRTTE1JWjlNMmVQWER4bW8xYmU1?=
 =?utf-8?B?SHlocGcxeVo3K2w3OEJiOXM4SlVGR3BpeXlKL0F2Nk92K0ROejU4VzhCWlB0?=
 =?utf-8?B?Z2J1ZUI4TFZWcFB4K1pqRDNoMUxLTW5TVEdlS0E5dzhDRDA3d0d4N0ZEamV0?=
 =?utf-8?B?RTVJaDliWE1rZWRXWnMzSjZhZFpDSGl2WlZEb3lSZ1dSdVgvNWUySElvWEdD?=
 =?utf-8?B?SzBpcFdkMFk2UDV2NGJ6N21JQVl1ZDNNRm1sOGVIMkFhUlhpRjFFYTNRYTdI?=
 =?utf-8?B?SWRZcnpBZ1NxQkQrWG5WRDM5QStOazlBOGdaWkt2TnhwTTg1ZTVGUTFCam54?=
 =?utf-8?B?ZmFBODRJeGtNSW96TnFzZEpkbFZrWXBrVDV5Tk01bkdPU1FJVVJKZ0VkQkg4?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbf4556-78cd-487e-4223-08db36bedfea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 16:49:23.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBEfcJGkvT7PPI8CZjXv9AGmGqj2o3aZ0kq/hkR1OvzQkW4BFFRBewkb6aBF5BbX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5355
X-Proofpoint-ORIG-GUID: b_JVkY0a4uJVh5N_ps0djr6U2fbC9BtF
X-Proofpoint-GUID: b_JVkY0a4uJVh5N_ps0djr6U2fbC9BtF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/4/23 2:46 PM, Andrii Nakryiko wrote:
> On Wed, Mar 29, 2023 at 10:56 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> LLVM commit [1] introduced hoistMinMax optimization like
>>    (i < VIRTIO_MAX_SGS) && (i < out_sgs)
>> to
>>    upper = MIN(VIRTIO_MAX_SGS, out_sgs)
>>    ... i < upper ...
>> and caused the verification failure. Commit [2] workarounded the issue by
>> adding some bpf assembly code to prohibit the above optimization.
>> This patch improved verifier such that verification can succeed without
>> the above workaround.
>>
>> Without [2], the current verifier will hit the following failures:
>>    ...
>>    119: (15) if r1 == 0x0 goto pc+1
>>    The sequence of 8193 jumps is too complex.
>>    verification time 525829 usec
>>    stack depth 64
>>    processed 156616 insns (limit 1000000) max_states_per_insn 8 total_states 1754 peak_states 1712 mark_read 12
>>    -- END PROG LOAD LOG --
>>    libbpf: prog 'trace_virtqueue_add_sgs': failed to load: -14
>>    libbpf: failed to load object 'loop6.bpf.o'
>>    ...
>> The failure is due to verifier inadequately handling '<const> <cond_op> <non_const>' which will
>> go through both pathes and generate the following verificaiton states:
>>    ...
>>    89: (07) r2 += 1                      ; R2_w=5
>>    90: (79) r8 = *(u64 *)(r10 -48)       ; R8_w=scalar() R10=fp0
>>    91: (79) r1 = *(u64 *)(r10 -56)       ; R1_w=scalar(umax=5,var_off=(0x0; 0x7)) R10=fp0
>>    92: (ad) if r2 < r1 goto pc+41        ; R0_w=scalar() R1_w=scalar(umin=6,umax=5,var_off=(0x4; 0x3))
> 
> offtopic, but if this is a real output, then something is wrong with
> scratching register logic for conditional, it should have emitted
> states of R1 and R2, maybe you can take a look while working on this
> patch set?

Yes, this is the real output. Yes, the above R1_w should be an 
impossible state. This is what this patch tries to fix.
I am not what verifier should do if this state indeed happens,
return an -EFAULT or something?

> 
>>        R2_w=5 R6_w=scalar(id=385) R7_w=0 R8_w=scalar() R9_w=scalar(umax=21474836475,var_off=(0x0; 0x7ffffffff))
>>        R10=fp0 fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmm???? fp-32= fp-40_w=4 fp-48=mmmmmmmm fp-56= fp-64=mmmmmmmm
>>    ...
>>    89: (07) r2 += 1                      ; R2_w=6
>>    90: (79) r8 = *(u64 *)(r10 -48)       ; R8_w=scalar() R10=fp0
>>    91: (79) r1 = *(u64 *)(r10 -56)       ; R1_w=scalar(umax=5,var_off=(0x0; 0x7)) R10=fp0
>>    92: (ad) if r2 < r1 goto pc+41        ; R0_w=scalar() R1_w=scalar(umin=7,umax=5,var_off=(0x4; 0x3))
>>        R2_w=6 R6=scalar(id=388) R7=0 R8_w=scalar() R9_w=scalar(umax=25769803770,var_off=(0x0; 0x7ffffffff))
>>        R10=fp0 fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmm???? fp-32= fp-40=5 fp-48=mmmmmmmm fp-56= fp-64=mmmmmmmm
>>      ...
>>    89: (07) r2 += 1                      ; R2_w=4088
>>    90: (79) r8 = *(u64 *)(r10 -48)       ; R8_w=scalar() R10=fp0
>>    91: (79) r1 = *(u64 *)(r10 -56)       ; R1_w=scalar(umax=5,var_off=(0x0; 0x7)) R10=fp0
>>    92: (ad) if r2 < r1 goto pc+41        ; R0=scalar() R1=scalar(umin=4089,umax=5,var_off=(0x0; 0x7))
>>        R2=4088 R6=scalar(id=12634) R7=0 R8=scalar() R9=scalar(umax=17557826301960,var_off=(0x0; 0xfffffffffff))
>>        R10=fp0 fp-8=mmmmmmmm fp-16=mmmmmmmm fp-24=mmmm???? fp-32= fp-40=4087 fp-48=mmmmmmmm fp-56= fp-64=mmmmmmmm
>>
>> Patch 3 fixed the above issue by handling '<const> <cond_op> <non_const>' properly.
>> During developing selftests for Patch 3, I found some issues with bound deduction with
>> BPF_EQ/BPF_NE and fixed the issue in Patch 1.
[...]
