Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB390646546
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 00:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiLGXmy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 18:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGXmx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 18:42:53 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A541EEED
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 15:42:51 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2B7KlSeu010411;
        Wed, 7 Dec 2022 15:42:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=PFpeJfihsitkdf3WxYmEyk9zmiMn73ULD4wrw2Di/J4=;
 b=aqnJuJlIBRGeu8La1Iyyg51h3Oqe06gC/kn+htbfKEdS6mxoLr94k98qnOfLEUYc/7pT
 XBDsmvFepEV3uz2RZxwMcGinFUkW/vZ4UCT4gM7yr+Q46yNw2rjJSKkad9LHGIfMwCbw
 +VGA58EnUkrp2Ky0UWnxgGQXizMYOG1toZeCwToGTrNUzDQXv/r/NAaz+QYBQs6W5ahm
 YpPfDGV3yB/JVRc1hhCU/lwZ9obL+4t9iAHgtt2qy2YyF46iRbl/NwE+Yc5dfqluJcPN
 8gDMEm0UrYBHKzCQBR80zvvcqPxBZgG3wtf60jS0f7hlShzoYkQZ9pUdtV1o3lsUllKu 9Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by m0089730.ppops.net (PPS) with ESMTPS id 3man8vpnfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 15:42:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyxyVgoditLCd8AFBQnmwi9nrMuREU/OVlUrOs/0+2th8PbctDeSW/Q6WDMFg+YfBeZm4S8+KRTaG24lmBoSQ03lb8Cd4SLvP5WTw8Fg7jLSO9CRpySnv+WIVxdR/lQXuWgElaIJ8PEXtbil3y9X8k8ImomBNJpWHnPAoJkV5YomxKyoo7aqSRbsU3GqYog4AQ4Xh8d5mOOwUCu1sGl/xvAW3LvBI7gCGenh9nQloz6clX0lbo3dywyTi3lvKV4ibtYW20n+ss0iyIGjC/3rcfH5fZ9BA/xGrLjMwZe4rSTyBER8prrm8MQpHGOJya1vzsN/I8AQLEzzxKy4w+kZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFpeJfihsitkdf3WxYmEyk9zmiMn73ULD4wrw2Di/J4=;
 b=fU+dheYweN+gE0xLPCPqJ7Qfl6UQUxfT39E6t2fUgOW6xZzcdrLd0nQF2PlrMEfOjjI+hMGT3zkeiYzRorgOc7ti7fjSHHT1Y/5KWm7b8t3XzICW4iRhEAu+tmAMtDaubhYVYWzNTIq3hLf0ZUiNW+U7JXy/XcR4z0Cc8k8JGLRL543EqljuTpFVBcPqX3kfpaMT4RanY/d6jz0FCs2tXfxO1Ce3PR8pk124f+ig1jB3sGMc6gujVrxBHxrtXSdtRs9iEZpR4AlmNkW4h4+TyF0oETLbVeBa2DrnL27pnKOU9vDB/ZzNV0iFzdvatfIcCkmXNjeRlL1SlSNRLgkYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by DM5PR1501MB1990.namprd15.prod.outlook.com (2603:10b6:4:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 7 Dec
 2022 23:42:31 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 23:42:31 +0000
Message-ID: <c8dc13ff-1a6c-31aa-78fc-9c4abe0136e6@meta.com>
Date:   Wed, 7 Dec 2022 18:42:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 01/13] bpf: Loosen alloc obj test in verifier's
 reg_btf_record
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-2-davemarchevsky@fb.com>
 <20221207164121.h6wm5crfhhvekqvd@apollo>
 <a8079b93-15d5-147d-226b-13bbebfda75e@meta.com>
 <20221207185931.hvte3vutd4y4qfh4@macbook-pro-6.dhcp.thefacebook.com>
 <c6e5fb34-3dc5-de80-2e45-c0502be1c3ca@meta.com>
 <20221207224628.zwgxlurf2vdpc6gm@macbook-pro-6.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221207224628.zwgxlurf2vdpc6gm@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL1PR13CA0441.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::26) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|DM5PR1501MB1990:EE_
X-MS-Office365-Filtering-Correlation-Id: 7952402a-5291-437a-5ef5-08dad8acb515
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqqRQaUDXEy9Cua/mRzegYFzlfMRXQBpovN1WGS4CqmvyOsMm2baLiR1gsdAB2vdaeOtXRSalZnCUh/ohH1Q2Fvws1S4bigg6JoRbat5oBpvCBQk1JDkoNUkZ23kUlCW7d7waw+Cb6uMYIMha5tQSvS+Z8xl3s3ld8doOYT2o7JnPTDXHC6qb8hcdr/dUE6KVFijZd/x6tNAWMoTt8n2adE1xG+0OUhzLV7xHEcQwHXbMSf3lWXjg/TbAvCZP//jqfikTPPbQLsgaxlMysnLUSPNBhIjgbB+VxPGvOwbtLRjiLlr15wSumjpsWquTfm++qe9GdtuUagSSGqREB06evXG1yULSerHOeBuS1mp4UqufLUyBQAqe7YWSfyqjjn+gNc5UvuA4KH2CQL+qXn7+glqntieiplLTmUhGlFUb6nxtCJECwtJtGGvwFE+tkOZrakXsZ2CV5YI011OiXG2wFz+Cki4ZqVikYhj3evSRMWaDWPXeSel87SkuRURI+Ae4WJKnHBSFPC2mtIRm88GggA3ln10I9aT2pPI9TNz1unaGKfye0PcyxxugpBF995n0tDhTNOGY7QhOM8HnVDX872K12houuc7rqBf82IXrhmqCoAEiXGIkbyVPdhCJuWWQajD2fz4QyYet3fKQ32QyQ2Bgvnsk02uwE0ov7PNb2IqUW87zrLUKJ8/Jrj4kqGARvL5mB/4xNNm50p2Gtskp6qvWh+DPZ3l6dB31zbISRMB+Q7uocP5iKN4lf3/GPuZgMUgDSZj4yZwx1cyyfeC8rFIKgjzB2OY4ctT0oFIEXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(2616005)(186003)(316002)(31686004)(478600001)(6916009)(54906003)(6486002)(86362001)(31696002)(53546011)(36756003)(2906002)(83380400001)(6666004)(6506007)(6512007)(966005)(30864003)(38100700002)(66556008)(8936002)(5660300002)(41300700001)(4326008)(8676002)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai96bmlVRGpiVjhQYTB4T1FrQXlIQk1EaGQ4a2JWckdrVFhNazNLVnJBSjFv?=
 =?utf-8?B?eXVJSjNROG5PRG5qZHNZcHNPY3d1Qm5GNmdCWTRuM2srcVZXNHJYSFFvL0VX?=
 =?utf-8?B?bFRQdnI4dWM0cjBDNk05akJYNitremZjUUpRMnZHUTdVcFZZbjBzZ3R6Q29C?=
 =?utf-8?B?ODVxMkZJK3lZaHBCWVBGWXRyVXVHTzJYUXZTWVZ0WEs2eml5L0pZSnMwdmRP?=
 =?utf-8?B?SjJEUU5CZktSa2RzK1diUkFZNWVVL3AyeW1kTCsrZkZRbG93QXIyQXpYaFBh?=
 =?utf-8?B?RmlubUxzeklJNm85ZVpjWjEwNHB4TitZdWN3bzZpNFN6MTBRQ2JjV1dqM0Ex?=
 =?utf-8?B?M1QrYi9rR3hMT29pNktKTXBWNzFHUVZNTGhTUC9td0dlaGc0K3B1bkxlejds?=
 =?utf-8?B?dk9ZWE9ZMTd5Q0tSWWNvdTJJcjlzMXhRNzNuM0FJRTQydC9iQjJxb0c3M0xa?=
 =?utf-8?B?N29qWXpVMXJFbXd4RExRMUxodXRiUVIzMTlrMnJ0eldGaHRvaGZrTDFHcDdM?=
 =?utf-8?B?Q3FQRzljVW4vY2hOR3pmbEVOTWEva0QrTGM5VEg0Z2xQR0Jlc3lsM3E4QUJt?=
 =?utf-8?B?KzNOUFN0RHJQTUprZXBkVExVWU5VWUs1SUNqSk40TDYxajhLVG5NZ29xd0NC?=
 =?utf-8?B?KzBkZTdmN1RKaXRwLy9wWE9kYnNxMFZpK285VTBhZnl4MCtwbjVWeHhZSWdH?=
 =?utf-8?B?eHpjeWZaU0RqSENTK0hsYllBeDBnK2NjeElBbWVsVjlQaEhaSzFXU0kwSWZv?=
 =?utf-8?B?aitwclBlVlJKWXJEYnk0SVYvZ1cxV016Vm40ZVEvaVE1MGFJS0RQZy93Q1pz?=
 =?utf-8?B?U1IrZ0xBM0VhdnlkZlUxamRVSDJtZlpwNERqTDU3V0RkN0haUTFGb3daZXEr?=
 =?utf-8?B?dC93c0ZLOWJGM0l1RHh1TVFnZ3B6aVQzQXVTZzZ0TXlDYkJ2K0xKSW1aQlY0?=
 =?utf-8?B?NHJMbnQwKzBXdVZ3K1FEeVlWM2twRjczdFZOOThPQkNMRXhlNGRpZkNXamd6?=
 =?utf-8?B?SVhZUG43N21FNDRGVVdPWkJuMHRwUHlaTUZsRCt0V2QxZ1QwTC85TVFNUVk1?=
 =?utf-8?B?bGpQMzFhSGVNSWFrT3MxdWozWWxadGFkVW1Wd0xYcmJEczRPRGx1NVdZNi90?=
 =?utf-8?B?bHlYdGNTYmJ0SVFTK2IwUG0xQTZsc3BjWXVtckhGMjhpeU1BbzUzOWQ2Um1k?=
 =?utf-8?B?Qlc4ckF6RitYemxCYUlDWFJUNmNWSlVyOTBNb1BFTEowdTFPUEpVSEJWaXhu?=
 =?utf-8?B?K2RENnZZSGh4bEcycGswL2Z6MXp5Z3Z4OTR1NHNqR2FadEFScXZyNHBENjIv?=
 =?utf-8?B?UjVzTDNsYUhWVXN3MTcyd21BQnlNUE9nZkFSY3ZER0tMTjV5ZG1CWkJxaDBQ?=
 =?utf-8?B?RDBFSStPcTJ6Wmw4MVpSUHI1OEJkdVU2QTBsUkJGamtkVHFoSHc4RzFYeVNZ?=
 =?utf-8?B?WS90OHFERUp3TkFoV1JleksxSDNUL1FuNlpiUmJtVzRxVVNzaGVnMFBLYWZw?=
 =?utf-8?B?eDVYK0JMVWlnR0ZFREYwVFJBYkxndnEveUhiYzgzbXpydm5DUHVFUllKeXpT?=
 =?utf-8?B?VEMrUVNIVDRCTTBuYzhDQlh6dTlDVHl2K3liTGJienJBbml3SmNRUUREdEQ2?=
 =?utf-8?B?UDBGSU1LRVphSHl5b2tBUTErZFZmUmphV25jeENEb3VRSWNLMXkxc2s1QTc3?=
 =?utf-8?B?WWw5SzFBL2xVRmRrMEVyZkluS2lDMmF3Nnh4WFlFR21BNUliaStYamtVT285?=
 =?utf-8?B?Yzc1NWxSd2dQdnJ3UExMamM3TlUzVmp0aEpwUjQzRjN6UGoyVEw4bVRodGZs?=
 =?utf-8?B?aWlUOEdNMWFTVyt4SVZ0ZkNHMkptZGdqcHo2Q3RyTUlVOGJBenVzVzNXckxI?=
 =?utf-8?B?bGxySzErdzFHRTFIVlRBZnM1WmVKV2xYdkdvR1R0TDBkTVFuNFEzS1FNbGg5?=
 =?utf-8?B?UE1BdVRYaGxYbVFkZEVIenRlYVZIWFFwSFZEbHUxQmUydksvQWdPTXQrL0h2?=
 =?utf-8?B?YUJ4ck1aOXVOUTJjVnEwZG5lMjkrMEhzQnlUS2hSUFNOcEFXTmJ1MTlrQ0k4?=
 =?utf-8?B?ZWRJMFNpdnozWUlnNWJPMWNkT0QzeXlDd2xPNE0wdWlSZzZnVUNEbnluYlhT?=
 =?utf-8?B?T1luOHpJa1lXQjBncmgyVTBkbXNKd0hFcnJXS0U4NERLbUZma0xlaXMyMncz?=
 =?utf-8?Q?rRtp/y0IfRPpZlCHr6ms4hk=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7952402a-5291-437a-5ef5-08dad8acb515
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:42:31.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnQ5b4CoRVpcXhbucCjoWxp8amAjIEhoFQG4BuNS06mm9LUHd1GR8yyM7YWufNhyxqTgc7LEWeHUnQ6RqabU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB1990
X-Proofpoint-GUID: vY4vPh2rP5naQ95lak0eRv8Xh0MCGDm7
X-Proofpoint-ORIG-GUID: vY4vPh2rP5naQ95lak0eRv8Xh0MCGDm7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 5:46 PM, Alexei Starovoitov wrote:
> On Wed, Dec 07, 2022 at 03:38:55PM -0500, Dave Marchevsky wrote:
>> On 12/7/22 1:59 PM, Alexei Starovoitov wrote:
>>> On Wed, Dec 07, 2022 at 01:34:44PM -0500, Dave Marchevsky wrote:
>>>> On 12/7/22 11:41 AM, Kumar Kartikeya Dwivedi wrote:
>>>>> On Wed, Dec 07, 2022 at 04:39:48AM IST, Dave Marchevsky wrote:
>>>>>> btf->struct_meta_tab is populated by btf_parse_struct_metas in btf.c.
>>>>>> There, a BTF record is created for any type containing a spin_lock or
>>>>>> any next-gen datastructure node/head.
>>>>>>
>>>>>> Currently, for non-MAP_VALUE types, reg_btf_record will only search for
>>>>>> a record using struct_meta_tab if the reg->type exactly matches
>>>>>> (PTR_TO_BTF_ID | MEM_ALLOC). This exact match is too strict: an
>>>>>> "allocated obj" type - returned from bpf_obj_new - might pick up other
>>>>>> flags while working its way through the program.
>>>>>>
>>>>>
>>>>> Not following. Only PTR_TO_BTF_ID | MEM_ALLOC is the valid reg->type that can be
>>>>> passed to helpers. reg_btf_record is used in helpers to inspect the btf_record.
>>>>> Any other flag combination (the only one possible is PTR_UNTRUSTED right now)
>>>>> cannot be passed to helpers in the first place. The reason to set PTR_UNTRUSTED
>>>>> is to make then unpassable to helpers.
>>>>>
>>>>
>>>> I see what you mean. If reg_btf_record is only used on regs which are args,
>>>> then the exact match helps enforce PTR_UNTRUSTED not being an acceptable
>>>> type flag for an arg. Most uses of reg_btf_record seem to be on arg regs,
>>>> but then we have its use in reg_may_point_to_spin_lock, which is itself
>>>> used in mark_ptr_or_null_reg and on BPF_REG_0 in check_kfunc_call. So I'm not
>>>> sure that it's only used on arg regs currently.
>>>>
>>>> Regardless, if the intended use is on arg regs only, it should be renamed to
>>>> arg_reg_btf_record or similar to make that clear, as current name sounds like
>>>> it should be applicable to any reg, and thus not enforce constraints particular
>>>> to arg regs.
>>>>
>>>> But I think it's better to leave it general and enforce those constraints
>>>> elsewhere. For kfuncs this is already happening in check_kfunc_args, where the
>>>> big switch statements for KF_ARG_* are doing exact type matching.
>>>>
>>>>>> Loosen the check to be exact for base_type and just use MEM_ALLOC mask
>>>>>> for type_flag.
>>>>>>
>>>>>> This patch is marked Fixes as the original intent of reg_btf_record was
>>>>>> unlikely to have been to fail finding btf_record for valid alloc obj
>>>>>> types with additional flags, some of which (e.g. PTR_UNTRUSTED)
>>>>>> are valid register type states for alloc obj independent of this series.
>>>>>
>>>>> That was the actual intent, same as how check_ptr_to_btf_access uses the exact
>>>>> reg->type to allow the BPF_WRITE case.
>>>>>
>>>>> I think this series is the one introducing this case, passing bpf_rbtree_first's
>>>>> result to bpf_rbtree_remove, which I think is not possible to make safe in the
>>>>> first place. We decided to do bpf_list_pop_front instead of bpf_list_entry ->
>>>>> bpf_list_del due to this exact issue. More in [0].
>>>>>
>>>>>  [0]: https://lore.kernel.org/bpf/CAADnVQKifhUk_HE+8qQ=AOhAssH6w9LZ082Oo53rwaS+tAGtOw@mail.gmail.com
>>>>>
>>>>
>>>> Thanks for the link, I better understand what Alexei meant in his comment on
>>>> patch 9 of this series. For the helpers added in this series, we can make
>>>> bpf_rbtree_first -> bpf_rbtree_remove safe by invalidating all release_on_unlock
>>>> refs after the rbtree_remove in same manner as they're invalidated after
>>>> spin_unlock currently.
>>>>
>>>> Logic for why this is safe:
>>>>
>>>>   * If we have two non-owning refs to nodes in a tree, e.g. from
>>>>     bpf_rbtree_add(node) and calling bpf_rbtree_first() immediately after,
>>>>     we have no way of knowing if they're aliases of same node.
>>>>
>>>>   * If bpf_rbtree_remove takes arbitrary non-owning ref to node in the tree,
>>>>     it might be removing a node that's already been removed, e.g.:
>>>>
>>>>         n = bpf_obj_new(...);
>>>>         bpf_spin_lock(&lock);
>>>>
>>>>         bpf_rbtree_add(&tree, &n->node);
>>>>         // n is now non-owning ref to node which was added
>>>>         res = bpf_rbtree_first();
>>>>         if (!m) {}
>>>>         m = container_of(res, struct node_data, node);
>>>>         // m is now non-owning ref to the same node
>>>>         bpf_rbtree_remove(&tree, &n->node);
>>>>         bpf_rbtree_remove(&tree, &m->node); // BAD
>>>
>>> Let me clarify my previous email:
>>>
>>> Above doesn't have to be 'BAD'.
>>> Instead of
>>> if (WARN_ON_ONCE(RB_EMPTY_NODE(n)))
>>>
>>> we can drop WARN and simply return.
>>> If node is not part of the tree -> nop.
>>>
>>> Same for bpf_rbtree_add.
>>> If it's already added -> nop.
>>>
>>
>> These runtime checks can certainly be done, but if we can guarantee via
>> verifier type system that a particular ptr-to-node is guaranteed to be in /
>> not be in a tree, that's better, no?
>>
>> Feels like a similar train of thought to "fail verification when correct rbtree
>> lock isn't held" vs "just check if lock is held in every rbtree API kfunc".
>>
>>> Then we can have bpf_rbtree_first() returning PTR_TRUSTED with acquire semantics.
>>> We do all these checks under the same rbtree root lock, so it's safe.
>>>
>>
>> I'll comment on PTR_TRUSTED in our discussion on patch 10.
>>
>>>>         bpf_spin_unlock(&lock);
>>>>
>>>>   * bpf_rbtree_remove is the only "pop()" currently. Non-owning refs are at risk
>>>>     of pointing to something that was already removed _only_ after a
>>>>     rbtree_remove, so if we invalidate them all after rbtree_remove they can't
>>>>     be inputs to subsequent remove()s
>>>
>>> With above proposed run-time checks both bpf_rbtree_remove and bpf_rbtree_add
>>> can have release semantics.
>>> No need for special release_on_unlock hacks.
>>>
>>
>> If we want to be able to interact w/ nodes after they've been added to the
>> rbtree, but before critical section ends, we need to support non-owning refs,
>> which are currently implemented using special release_on_unlock logic.
>>
>> If we go with the runtime check suggestion from above, we'd need to implement
>> 'conditional release' similarly to earlier "rbtree map" attempt:
>> https://lore.kernel.org/bpf/20220830172759.4069786-14-davemarchevsky@fb.com/ .
>>
>> If rbtree_add has release semantics for its node arg, but the node is already
>> in some tree and runtime check fails, the reference should not be released as
>> rbtree_add() was a nop.
> 
> Got it.
> The conditional release is tricky. We should probably avoid it for now.
> 
> I think we can either go with Kumar's proposal and do
> bpf_rbtree_pop_front() instead of bpf_rbtree_first()
> that avoids all these issues...
> 
> but considering that we'll have inline iterators soon and should be able to do:
> 
> struct bpf_rbtree_iter it;
> struct bpf_rb_node * node;
> 
> bpf_rbtree_iter_init(&it, rb_root); // locks the rbtree
> while ((node = bpf_rbtree_iter_next(&it)) {
>   if (node->field == condition) {
>     struct bpf_rb_node *n;
> 
>     n = bpf_rbtree_remove(rb_root, node);
>     bpf_spin_lock(another_rb_root);
>     bpf_rbtree_add(another_rb_root, n);
>     bpf_spin_unlock(another_rb_root);
>     break;
>   }
> }
> bpf_rbtree_iter_destroy(&it);
> 
> We can treat the 'node' returned from bpf_rbtree_iter_next() the same way
> as return from bpf_rbtree_first() ->  PTR_TRUSTED | MAYBE_NULL,
> but not acquired (ref_obj_id == 0).
> 
> bpf_rbtree_add -> KF_RELEASE
> so we cannot pass not acquired pointers into it.
> 
> We should probably remove release_on_unlock logic as Kumar suggesting and
> make bpf_list_push_front/back to be KF_RELEASE.
> 
> Then
> bpf_list_pop_front/back stay KF_ACQUIRE | KF_RET_NULL
> and
> bpf_rbtree_remove is also KF_ACQUIRE | KF_RET_NULL.
> 
> The difference is bpf_list_pop has only 'head'
> while bpf_rbtree_remove has 'root' and 'node' where 'node' has to be PTR_TRUSTED
> (but not acquired).
> 
> bpf_rbtree_add will always succeed.
> bpf_rbtree_remove will conditionally fail if 'node' is not linked.
> 
> Similarly we can extend link list with
> n = bpf_list_remove(node)
> which will have KF_ACQUIRE | KF_RET_NULL semantics.
> 
> Then everything is nicely uniform.
> We'll be able to iterate rbtree and iterate link lists.
> 
> There are downsides, of course.
> Like the following from your test case:
> +       bpf_spin_lock(&glock);
> +       bpf_rbtree_add(&groot, &n->node, less);
> +       bpf_rbtree_add(&groot, &m->node, less);
> +       res = bpf_rbtree_remove(&groot, &n->node);
> +       bpf_spin_unlock(&glock);
> will not work.
> Since bpf_rbtree_add() releases 'n' and it becomes UNTRUSTED.
> (assuming release_on_unlock is removed).
> 
> I think it's fine for now. I have to agree with Kumar that it's hard to come up
> with realistic use case where 'n' should be accessed after it was added to link
> list or rbtree. Above test case doesn't look real.
> 
> This part of your test case:
> +       bpf_spin_lock(&glock);
> +       bpf_rbtree_add(&groot, &n->node, less);
> +       bpf_rbtree_add(&groot, &m->node, less);
> +       bpf_rbtree_add(&groot, &o->node, less);
> +
> +       res = bpf_rbtree_first(&groot);
> +       if (!res) {
> +               bpf_spin_unlock(&glock);
> +               return 2;
> +       }
> +
> +       o = container_of(res, struct node_data, node);
> +       res = bpf_rbtree_remove(&groot, &o->node);
> +       bpf_spin_unlock(&glock);
> 
> will work, because bpf_rbtree_first returns PTR_TRUSTED | MAYBE_NULL.
> 
>> Similarly, if rbtree_remove has release semantics for its node arg and acquire
>> semantics for its return value, runtime check failing should result in the
>> node arg not being released. Acquire semantics for the retval are already
>> conditional - if retval == NULL, mark_ptr_or_null regs will release the
>> acquired ref before it can be used. So no issue with failing rbtree_remove
>> messing up acquire.
>>
>> For this reason rbtree_remove and rbtree_first are tagged
>> KF_ACQUIRE | KF_RET_NULL. "special release_on_unlock hacks" can likely be
>> refactored into a similar flag, KF_RELEASE_NON_OWN or similar.
> 
> I guess what I'm propsing above is sort-of KF_RELEASE_NON_OWN idea,
> but from a different angle.
> I'd like to avoid introducing new flags.
> I think PTR_TRUSTED is enough.
> 
>>> I'm not sure what's an idea to return 'n' from remove...
>>> Maybe it should be simple bool ?
>>>
>>
>> I agree that returning node from rbtree_remove is not strictly necessary, since
>> rbtree_remove can be thought of turning its non-owning ref argument into an
>> owning ref, instead of taking non-owning ref and returning owning ref. But such
>> an operation isn't really an 'acquire' by current verifier logic, since only
>> retvals can be 'acquired'. So we'd need to add some logic to enable acquire
>> semantics for args. Furthermore it's not really 'acquiring' a new ref, rather
>> changing properties of node arg ref.
>>
>> However, if rbtree_remove can fail, such a "turn non-owning into owning"
>> operation will need to be able to fail as well, and the program will need to
>> be able to check for failure. Returning 'acquire' result in retval makes
>> this simple - just check for NULL. For your "return bool" proposal, we'd have
>> to add verifier logic which turns the 'acquired' owning ref back into non-owning
>> based on check of the bool, which will add some verifier complexity.
>>
>> IIRC when doing experimentation with "rbtree map" implementation, I did
>> something like this and decided that the additional complexity wasn't worth
>> it when retval can just be used. 
> 
> Agree. Forget 'bool' idea.

We will merge this convo w/ similar one in the cover letter's thread, and
continue w/ replies there.
