Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B88646277
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLGUjT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGUjS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:39:18 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB853AC11
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:39:17 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7KREw3017654;
        Wed, 7 Dec 2022 12:39:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=gjy+z12702AfKxH5nUlmneM5+C9Hb9WyWm8aYNmTe80=;
 b=GVQ5OnHvKo/d3tOk6LmWk3D4RWFJN8BZOfNqIedqkFVYhNQUgx39RmTtH6fC6roOausz
 25GpPt86gg0lqdk9qpnxjDvsssvDeUpRfmtU97XgLbNDu0hAP7nNHeCTooLBDrNMtYFf
 hx25rTQMSUrLtdKBBUxStCvy1K9oqDaKNLBTPT9VgdWToKRBDWAFcUTjfB6mbaxenXvs
 0jTmcceTxK+moUlUzX6YVWnaeQiG+EXA/oiF8QS0h/6o2e5YMmx9VDjqDAHkAfKsN0rY
 +9oTb71q70cgZQ8s0Rwpd8KEQqmP0oPSq0zCCh68DnlBx6KrwZGlZZVB6ISAoPELyImF 6g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mb118gpav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 12:39:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMLSycxV81Ei6eP14W+8jvJm5SZ3MQJXMT05JFVWmZVxkoJ5i0AM/X98b/lquY+rejs6qwixpg2tL9rOEi4B4WzeudNbwtDqZqR8FQ32sr7CNp7y0zmrm6DKJ2RAYm7UUod14/0OaryANY69cL1wgZLexGKfGLCuro3KZkLitwQ/cakqKBRlLnfQjJOrt1q8Fen/32Io+RhOZD+dPdujrp8ap3yoD6naBoh3O/uVOFmsnmKYRJWbWeRlJFCy37lQka2URFQLw6N3MHfSKZQYTa5eoJq4oDNd6KygbQjrHO88LXX/msLMrNFwNu7RmJo8jH6Hp+/PuehFkwUPuogxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjy+z12702AfKxH5nUlmneM5+C9Hb9WyWm8aYNmTe80=;
 b=IFkersmIm2QCpBcGslHUyKxygrNc4AkuXT2fWr9aLOQNjpsFRho02Lvw8gYLAQUjYutpH/8lRg+8DL/fWDZLWeK1DCPJEix5zNmJx6grpfCmef0B0HFpq8MX8mQoKUhpnLcllSCA0eB0ayjTO3J5+bDm9EFMuTxvCE0o6ZXph4DDQXg8DGi5HwOdA5/6FMrFPyfkaV25RznNFNVWFI/AcoNJ9WQmMObcAi/5h/4vyA8r7hKXt2Jy7uo+NNYMoHlsDkWNmmXOrBT8V0hra4fwFNy7Nto5uhUvDeffPkmhzxUfmo/XdaP4CVd33pmyiqvy0G+HP9TgFG8qo3ZhKWi2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by DM5PR15MB1561.namprd15.prod.outlook.com (2603:10b6:3:d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 7 Dec
 2022 20:38:59 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 20:38:59 +0000
Message-ID: <c6e5fb34-3dc5-de80-2e45-c0502be1c3ca@meta.com>
Date:   Wed, 7 Dec 2022 15:38:55 -0500
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
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221207185931.hvte3vutd4y4qfh4@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BLAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:32d::11) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|DM5PR15MB1561:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b08ca2-3d32-4138-ffe0-08dad89311a4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3WRAuAKTc2ZyW3gw0EBV0BVcWxGvCK36IFsZ75R8NOd3SnuBnrtQsYNJ+CzXzM9VSF068fZQh9N98smRdiZAVL4Nk/HM9Lpy/eauBgvDl7sVT8NhHrefM/ez7Umg1Vmw7BzllX9eYnyGBCvYr7vggG+2VJFIdmnjOUE4NkBGh37G+bmF4jMLAL1yHgYNkuuxI3KlrfxewUCSiaz0byhE5vFChQYWdN7HsdqHmBen/qny2rgMmdLx7Uub4odE4eovm9YQKJWN/+RKJlkuDfD9ORS7S7LuHURQ+n4bB0Wb4MBU+iD6eUiEgxuiCvYTwYgNq/1+fXODYp6BjlnhqATmbwG3sF8t8PDYMXFW6jMVda8E7j33R+GWpMgiv3/6LCGOLmIwghiqcpQ41rCRETz32zO0ADvMmInasYB+heHHxs3HrQ0pp15w+M7ItOHr/CU4jEVKq6+axjND6qqKWqGZL1rjck2Pj0KAjfESzEBXhCGzMpxRI6eERD2Kb+bKK2J/gailV6BF9foBFv7LKkzqt40Y9MSTBSnnRpmeq5DHJEhC2l/ZW4HIeRYAXt1Hs0uEPqYmUr/OX9yh7PyZp3AAfuzB6Nv9yqJjWFUkgjHGS9EQcyTo5wiwrWwz4DgBiLJHchyrzKtukky1l4d5oc4hp8jAEwwsGvJA6OGK8Nz91wlo4WgEUJNbD+pq8qFyxKw2QPfrZz6Q6WgkcCbW25PhvZvALGrH/aDF6vdY9mlyAz6BHtbCtueFRSgNBrM2ml57mAaQPThevpeiSXWbRMuv/K3JETG1eLCCDjp68RV96M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(66899015)(38100700002)(36756003)(6916009)(31686004)(86362001)(8936002)(2906002)(4326008)(5660300002)(31696002)(83380400001)(66476007)(316002)(2616005)(66946007)(6486002)(66556008)(478600001)(41300700001)(8676002)(54906003)(53546011)(966005)(6666004)(6512007)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldVVDZ3Z1RpR0hoU2JpOFFObGdtQmhGYXlONSs4YzNlY0E4dHowSEttTEY4?=
 =?utf-8?B?WDd0T25JVVlJQXZtcDBhWWYzbzg2QXRHVHJaU2hIcmFISW5VaGwxdzVTTndP?=
 =?utf-8?B?Vm1wVHltRUMwU1NzNzdiNnRXZTZsVEphRGxOQ1Q1SjJyOFgxOUFieXlhQXVK?=
 =?utf-8?B?UmgybHRqaGNSU3NZMUV6MkpDaUw3T2I4c0QyU05NRXQvWmxyNDEzakFoUmxs?=
 =?utf-8?B?bGpYOXoyR2FRQldzcWk0N2srVHQ4TmZ5VlpuU2NORW9raEV1eTVqSk9kR0h0?=
 =?utf-8?B?MEo1SXlPaDB2U21YL3k2YTVXYm1WbjlPb1BrZFRJU3l4YWtoQU94cXF5Sm91?=
 =?utf-8?B?U21RSkhwanB1cngzV1RYcjc3WmJSVWlnZDNRVGRaSXpTeHh2QzlySE8yVmdw?=
 =?utf-8?B?R0crYWZQREhWSW1kMWs1OG1Ja3RjYTN5eEZiUlVqNlVmVkRiMVFPTjZhWk1E?=
 =?utf-8?B?RFJtcFp4UlZYMlhaVXIzRDdqT3kvNTcvaGN0eis5Z2ZOdDl3VEVLUjVYcVBC?=
 =?utf-8?B?Rzc4V1dibjNWc29aUnVFM08wNXlNUlE5eGJiM2lDY0t4OFNMNUl4MVVrN3hn?=
 =?utf-8?B?eTBBMEprbDRZa2NLMVNZbk5walRaMHplZjFmYlZBMEdHZ2wxb0pUeWlLR2s4?=
 =?utf-8?B?SWo2bitTZjVGTzlwRlhoMGVXdFVCc2ZLQStBZ2FjdTVYV2JPRi9Pa0hQMjFs?=
 =?utf-8?B?WHVKa1lqYzdjaDJCYS9GUjlxMjlUOFpXb3B1dDRPWXMva0hVL2x6K0x2Y1VF?=
 =?utf-8?B?c3VKeWkzcXYvN2tvcUJ2ZVZmQllIODBxd3ZKNCtjMEcyUmpYU2ZqSENuQ0FX?=
 =?utf-8?B?OGdkMjlDTlByTEVkV2FZZlVMQkNYb3ZHL2JwNmIwSVNEb0tiSWlOM3lLU2ow?=
 =?utf-8?B?anlDQy93cG83NFhPUWR1Vm1DMWNKcjY3S3E1aE5NZG5XRTRCbEZQKzlDKzIw?=
 =?utf-8?B?cEZUa0JMRU1zMi95d1dWc0dtZmdsOElnMzdVRW1yL1VKRzJ6UFN3NWc0RTA5?=
 =?utf-8?B?M2ZIb0N1V2NDNnExRjVZNXVFOGdzNUZ5T2U5azNqc0gzejM3YlRhMlBzTnY0?=
 =?utf-8?B?aWJoTklrWXZ6UC9EQ0tlOG51WklwYVJTKzZEa0xBT0piVmNCV1R2eHZESjFr?=
 =?utf-8?B?bzFKY09Za2RUTERvWUZObnl4cUN6T2V5QUxxQ1ZyYjY4ZVZXdDlLTTFBcVM4?=
 =?utf-8?B?ZTNlbEJqeXJ5ZlBaa09mdS9KNUl2cVJjRU5pMDgxdjVQWWZIVjFlcndRYlln?=
 =?utf-8?B?Tkg2c0V2Skd2Z3h0ME9sM2ZhYlBqN3RVWUZYVk9udkNaL0wxUUtnQ0tQNmhL?=
 =?utf-8?B?TkEybjExOHdxTThRM1FISlVnYXpkWCtRT0dXdTMySFZOT2J3ai9tR2F2K2V5?=
 =?utf-8?B?V0ZMMkx4L0wxNE4yY0JxMy9YTkVDOUV4QmlDQ1pqbjZQWkNIek02QlVDYUtK?=
 =?utf-8?B?ZndwQ1d0R1BFRzRvdzFXc2RIbWpsUVl1T2VXZ01ac0RWVUFieGNpYUl3bjZo?=
 =?utf-8?B?NEZOTzJORTZ1aU8wSEtjenRmSmtuVXJ1bDFvdEd2eTBKM2NWc1lMMDMrRFEv?=
 =?utf-8?B?ZzdLcnRDM2hYTlpKQ0NsNmgrOFJzRXhaVEwzRWdSUC9WNE1BRTVJNVJDUzRQ?=
 =?utf-8?B?NlNEWFk3UHppUVFBenN6dmV4cUtubDRSR3ZRWlNCQXBwajRaUUhDY1YvdE55?=
 =?utf-8?B?VkxKQ2F6NkhtcklZMzJzbVR6MkRacmdRMit5bU8wSkxSSjNpVmJWZGppMWxZ?=
 =?utf-8?B?ZkE2Umg3MFZueUNWWXZzcld3SUN5Wk8vVlhKd2V4WVovbDdXcENTcXZvYjYw?=
 =?utf-8?B?T0gyV3JCS3FzNEZXUktYQ1kwQ0Y2SmtPR0FTL3BlM0gwekhCYXdyOTZOTHVL?=
 =?utf-8?B?akFkaWI5L28wbzNaVXlTNmtiOG9yeHNqemhJdlMrZzI4WjlUak9GaTZ6SDZG?=
 =?utf-8?B?WGRhdFNvTUlORnVZN3o1L016TkNTSVRIZlErTjduWTRrOVRJa2RzazVySzl2?=
 =?utf-8?B?bEg4d3N1S21nM3lDcmE1QkdnS1FEQjJlejlUUEdNK2NMZnJwZWU5alB5NllP?=
 =?utf-8?B?cG0yQVFJYWxIODAwQ2RyanoyQ1c4L2FTT0M5RnVMNkZqaTJHWnBpRndGUFRX?=
 =?utf-8?B?Rm02MXorRzBDS3NHZkcwNituOHhwNysrc3YxQmVqaTB0K0ZJU3ZPRmNvdHpn?=
 =?utf-8?Q?CsXqrHvXyuUWePvRW0swbOY=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b08ca2-3d32-4138-ffe0-08dad89311a4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 20:38:59.6195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFG85W5kzLZigOog5GFDAgDep5vTEUOUDFeeQhhytMNOP6Zj6J0EnDOMOVtL83/CFIXhIeFb5r84gpE3EdZGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1561
X-Proofpoint-GUID: FV9kGKECcqonUMXtbxK62fSKRzoUcbM4
X-Proofpoint-ORIG-GUID: FV9kGKECcqonUMXtbxK62fSKRzoUcbM4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/22 1:59 PM, Alexei Starovoitov wrote:
> On Wed, Dec 07, 2022 at 01:34:44PM -0500, Dave Marchevsky wrote:
>> On 12/7/22 11:41 AM, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, Dec 07, 2022 at 04:39:48AM IST, Dave Marchevsky wrote:
>>>> btf->struct_meta_tab is populated by btf_parse_struct_metas in btf.c.
>>>> There, a BTF record is created for any type containing a spin_lock or
>>>> any next-gen datastructure node/head.
>>>>
>>>> Currently, for non-MAP_VALUE types, reg_btf_record will only search for
>>>> a record using struct_meta_tab if the reg->type exactly matches
>>>> (PTR_TO_BTF_ID | MEM_ALLOC). This exact match is too strict: an
>>>> "allocated obj" type - returned from bpf_obj_new - might pick up other
>>>> flags while working its way through the program.
>>>>
>>>
>>> Not following. Only PTR_TO_BTF_ID | MEM_ALLOC is the valid reg->type that can be
>>> passed to helpers. reg_btf_record is used in helpers to inspect the btf_record.
>>> Any other flag combination (the only one possible is PTR_UNTRUSTED right now)
>>> cannot be passed to helpers in the first place. The reason to set PTR_UNTRUSTED
>>> is to make then unpassable to helpers.
>>>
>>
>> I see what you mean. If reg_btf_record is only used on regs which are args,
>> then the exact match helps enforce PTR_UNTRUSTED not being an acceptable
>> type flag for an arg. Most uses of reg_btf_record seem to be on arg regs,
>> but then we have its use in reg_may_point_to_spin_lock, which is itself
>> used in mark_ptr_or_null_reg and on BPF_REG_0 in check_kfunc_call. So I'm not
>> sure that it's only used on arg regs currently.
>>
>> Regardless, if the intended use is on arg regs only, it should be renamed to
>> arg_reg_btf_record or similar to make that clear, as current name sounds like
>> it should be applicable to any reg, and thus not enforce constraints particular
>> to arg regs.
>>
>> But I think it's better to leave it general and enforce those constraints
>> elsewhere. For kfuncs this is already happening in check_kfunc_args, where the
>> big switch statements for KF_ARG_* are doing exact type matching.
>>
>>>> Loosen the check to be exact for base_type and just use MEM_ALLOC mask
>>>> for type_flag.
>>>>
>>>> This patch is marked Fixes as the original intent of reg_btf_record was
>>>> unlikely to have been to fail finding btf_record for valid alloc obj
>>>> types with additional flags, some of which (e.g. PTR_UNTRUSTED)
>>>> are valid register type states for alloc obj independent of this series.
>>>
>>> That was the actual intent, same as how check_ptr_to_btf_access uses the exact
>>> reg->type to allow the BPF_WRITE case.
>>>
>>> I think this series is the one introducing this case, passing bpf_rbtree_first's
>>> result to bpf_rbtree_remove, which I think is not possible to make safe in the
>>> first place. We decided to do bpf_list_pop_front instead of bpf_list_entry ->
>>> bpf_list_del due to this exact issue. More in [0].
>>>
>>>  [0]: https://lore.kernel.org/bpf/CAADnVQKifhUk_HE+8qQ=AOhAssH6w9LZ082Oo53rwaS+tAGtOw@mail.gmail.com
>>>
>>
>> Thanks for the link, I better understand what Alexei meant in his comment on
>> patch 9 of this series. For the helpers added in this series, we can make
>> bpf_rbtree_first -> bpf_rbtree_remove safe by invalidating all release_on_unlock
>> refs after the rbtree_remove in same manner as they're invalidated after
>> spin_unlock currently.
>>
>> Logic for why this is safe:
>>
>>   * If we have two non-owning refs to nodes in a tree, e.g. from
>>     bpf_rbtree_add(node) and calling bpf_rbtree_first() immediately after,
>>     we have no way of knowing if they're aliases of same node.
>>
>>   * If bpf_rbtree_remove takes arbitrary non-owning ref to node in the tree,
>>     it might be removing a node that's already been removed, e.g.:
>>
>>         n = bpf_obj_new(...);
>>         bpf_spin_lock(&lock);
>>
>>         bpf_rbtree_add(&tree, &n->node);
>>         // n is now non-owning ref to node which was added
>>         res = bpf_rbtree_first();
>>         if (!m) {}
>>         m = container_of(res, struct node_data, node);
>>         // m is now non-owning ref to the same node
>>         bpf_rbtree_remove(&tree, &n->node);
>>         bpf_rbtree_remove(&tree, &m->node); // BAD
> 
> Let me clarify my previous email:
> 
> Above doesn't have to be 'BAD'.
> Instead of
> if (WARN_ON_ONCE(RB_EMPTY_NODE(n)))
> 
> we can drop WARN and simply return.
> If node is not part of the tree -> nop.
> 
> Same for bpf_rbtree_add.
> If it's already added -> nop.
> 

These runtime checks can certainly be done, but if we can guarantee via
verifier type system that a particular ptr-to-node is guaranteed to be in /
not be in a tree, that's better, no?

Feels like a similar train of thought to "fail verification when correct rbtree
lock isn't held" vs "just check if lock is held in every rbtree API kfunc".

> Then we can have bpf_rbtree_first() returning PTR_TRUSTED with acquire semantics.
> We do all these checks under the same rbtree root lock, so it's safe.
> 

I'll comment on PTR_TRUSTED in our discussion on patch 10.

>>         bpf_spin_unlock(&lock);
>>
>>   * bpf_rbtree_remove is the only "pop()" currently. Non-owning refs are at risk
>>     of pointing to something that was already removed _only_ after a
>>     rbtree_remove, so if we invalidate them all after rbtree_remove they can't
>>     be inputs to subsequent remove()s
> 
> With above proposed run-time checks both bpf_rbtree_remove and bpf_rbtree_add
> can have release semantics.
> No need for special release_on_unlock hacks.
> 

If we want to be able to interact w/ nodes after they've been added to the
rbtree, but before critical section ends, we need to support non-owning refs,
which are currently implemented using special release_on_unlock logic.

If we go with the runtime check suggestion from above, we'd need to implement
'conditional release' similarly to earlier "rbtree map" attempt:
https://lore.kernel.org/bpf/20220830172759.4069786-14-davemarchevsky@fb.com/ .

If rbtree_add has release semantics for its node arg, but the node is already
in some tree and runtime check fails, the reference should not be released as
rbtree_add() was a nop.

Similarly, if rbtree_remove has release semantics for its node arg and acquire
semantics for its return value, runtime check failing should result in the
node arg not being released. Acquire semantics for the retval are already
conditional - if retval == NULL, mark_ptr_or_null regs will release the
acquired ref before it can be used. So no issue with failing rbtree_remove
messing up acquire.

For this reason rbtree_remove and rbtree_first are tagged
KF_ACQUIRE | KF_RET_NULL. "special release_on_unlock hacks" can likely be
refactored into a similar flag, KF_RELEASE_NON_OWN or similar.

>> This does conflate current "release non-owning refs because it's not safe to
>> read from them" reasoning with new "release non-owning refs so they can't be
>> passed to remove()". Ideally we could add some new tag to these refs that
>> prevents them from being passed to remove()-type fns, but does allow them to
>> be read, e.g.:
>>
>>   n = bpf_obj_new(...);
> 
> 'n' is acquired.
> 
>>   bpf_spin_lock(&lock);
>>
>>   bpf_rbtree_add(&tree, &n->node);
>>   // n is now non-owning ref to node which was added
> 
> since bpf_rbtree_add does release on 'n'...
> 
>>   res = bpf_rbtree_first();
>>   if (!m) {}
>>   m = container_of(res, struct node_data, node);
>>   // m is now non-owning ref to the same node
> 
> ... below is not allowed by the verifier.
>>   n = bpf_rbtree_remove(&tree, &n->node);
> 
> I'm not sure what's an idea to return 'n' from remove...
> Maybe it should be simple bool ?
> 

I agree that returning node from rbtree_remove is not strictly necessary, since
rbtree_remove can be thought of turning its non-owning ref argument into an
owning ref, instead of taking non-owning ref and returning owning ref. But such
an operation isn't really an 'acquire' by current verifier logic, since only
retvals can be 'acquired'. So we'd need to add some logic to enable acquire
semantics for args. Furthermore it's not really 'acquiring' a new ref, rather
changing properties of node arg ref.

However, if rbtree_remove can fail, such a "turn non-owning into owning"
operation will need to be able to fail as well, and the program will need to
be able to check for failure. Returning 'acquire' result in retval makes
this simple - just check for NULL. For your "return bool" proposal, we'd have
to add verifier logic which turns the 'acquired' owning ref back into non-owning
based on check of the bool, which will add some verifier complexity.

IIRC when doing experimentation with "rbtree map" implementation, I did
something like this and decided that the additional complexity wasn't worth
it when retval can just be used. 

>>   // n is now owning ref again, m is non-owning ref to same node
>>   x = m->key; // this should be safe since we're still in CS
> 
> below works because 'm' cames from bpf_rbtree_first that acquired 'res'.
> 
>>   bpf_rbtree_remove(&tree, &m->node); // But this should be prevented
>>
>>   bpf_spin_unlock(&lock);
>>
