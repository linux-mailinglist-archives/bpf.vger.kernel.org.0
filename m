Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F4C33F628
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhCQRAe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 13:00:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232256AbhCQRAG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Mar 2021 13:00:06 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12HGu8jI020313;
        Wed, 17 Mar 2021 09:59:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cEQlTZzSU4dTDh1IFpQTvxeaFUX4fiJSRZy7heuwAr0=;
 b=pf+lsv0qHZZRNBU4BIeclXXWPrDMNZ40OosEyaHe7RzeBdcHhd0EP+0F1ENveLKnZS1C
 UrJXZ7H8oEr4TJgmP8ZXzvlIj3Ff1jhrdbj682z+Z+xsNebPRhp59Ht0Z22CSZ2TRYQI
 6j0U5REpmG79xyKNK1zY2YRU8PO7zUX4mZ0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 379dx7ugsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Mar 2021 09:59:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 17 Mar 2021 09:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu10otM08x6nwI0dweDwR4eC8sXyBTaTaPUmjIbMCWtroA3ormkXlQWxxD1gxsJCFwxhtwLEiNfM7WCT7hekhA0pfCtMXzay6U5/TlsC+95E6nURCuxp0HYbyqUQuh/zhujNGh0uUiV4YDwkUd0UTkR/Llgs4HQsnZpdpscu4Yenvql84N+12Jdr3K74L7wGqQzvl2VZtez8Pq76CQLh4Q13ZRAX+/MJnliZbghxX2QrTJ17BqdzBo7NNsozmgN7kfuQB/BpLTd2qwaa0X8kP341wWiAmKOId8Uhd4IbC1XWy6KZHhKrLI4WC5ZZ4IlDxk/dD2Y/sc+cOOVXW5c3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEQlTZzSU4dTDh1IFpQTvxeaFUX4fiJSRZy7heuwAr0=;
 b=AgrMkQ0w5n4TfgthJWzkeNv5iqengfKwibXBXJZDQFCJec40qmWI4Qa6ElYznCAL6vyen55e/dxlwl8ItA9WEgOL638+8Eu8H4rnx3sJjK1q6uhL/WV55ZvBjmrv/sxLzH9vCZmgXe/7qhV4BY5QcszAGpRJEgfuYgLwv1S1EOBQ4J2VTSd39VjBWtPP2T5MmsBzY0WlPOGgs9G102iKODmS73auxjPnpjBpEl8rgIpixaQGdeQdBos9pdwlYxKXQdSggQFxcHYr2hi/GMQ64oacTMtoz+QhcUaPjfs2e5BExAENg6oAKSGQBxdDIsQ9vD4r5Eo3r1lj/seo4eKSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4450.namprd15.prod.outlook.com (2603:10b6:806:195::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 16:58:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 16:58:57 +0000
Subject: Re: [PATCH bpf-next v2] bpf: net: emit anonymous enum with
 BPF_TCP_CLOSE value explicitly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210317042906.1011232-1-yhs@fb.com>
 <CAADnVQLY1ftbZxFqAMSN4amWoYZN0ka3DyVLXAWhgsTO7V9V+Q@mail.gmail.com>
 <58a10cec-180b-d8d5-e1d3-de9b695a8878@fb.com>
 <CAADnVQ+hUjX-Hk9=9X+=ii1SusfsZJrsxXUn4krH1bUvNjuVRg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <81097bbb-a315-75ff-7c35-217c17c5f002@fb.com>
Date:   Wed, 17 Mar 2021 09:58:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <CAADnVQ+hUjX-Hk9=9X+=ii1SusfsZJrsxXUn4krH1bUvNjuVRg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f17c]
X-ClientProxiedBy: MW4PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:303:b9::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::19fd] (2620:10d:c090:400::5:f17c) by MW4PR03CA0237.namprd03.prod.outlook.com (2603:10b6:303:b9::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 16:58:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88da26d9-a71c-4e1c-1c18-08d8e965f430
X-MS-TrafficTypeDiagnostic: SA1PR15MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB445064BF22BCB157882B8085D36A9@SA1PR15MB4450.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znIwl6QsboP+fOv8/sNZt2YBNdampFrt0XJz61j1yg6dDsOLXm01Q4CK875rIrUhM32rC6+X3THcNzJNzv5pOkTSqtKXwxFr0zdZUCGrkxfdfNDDqOH1qynXDE9+q71+SW4kAKdL5dHrCKbPkGPoIfLkLaLvr82EfgWA80uzbZryEI8nCqR8enVsiX2TqNotQpSdOE5l1sbHwh26BGkqFvX0mPHs8W85N0r0MqY3ov3csoc9kLPGqebgLJU//MKOtWVgrT84Ym4ggCXGvQDmFlPnOlrmYQSeI++0IvMcPLPLxFDsVMd6PIkx0ipNWK5texAF5VG3lBDfj/9j3CnEEQk0hVyniaSMDsqsCGA3sZiJFarIGkHztLXjS1JiRXZfolkJsuYzOioxkh2Twgo7JPCILyw5ILf4gSPR2t3dG4244NwLUzoUbkiT+v+xyUR6QesWc6A6XbL1IH65kDNNP0hKqcRmvTIKY0UaSGWwEQbtYpzej6sD4Kn5NxKrRzDIxnoPpdNdd85YRPXUueu557xu4J75yRJ6/JM0Fe/aycXUozhLnW4rEWjRzo80XB4wEaqC2oAup5whKMt7Zmn1Nwo+sNeeK5UpDaLnUW7LZWUP8Ts0dJmLJmaJTxDtKCTc4xphenF2Cot5imo0SwWtKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(52116002)(66946007)(31686004)(83380400001)(478600001)(8676002)(6916009)(86362001)(6486002)(53546011)(8936002)(6666004)(66556008)(66476007)(16526019)(316002)(186003)(2906002)(36756003)(5660300002)(2616005)(31696002)(54906003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VkZCZUJwN3BrT3BxM3YrMEJrMVF5djFnQWhzclMyS0Q5amhlRGhnUjJjbDMw?=
 =?utf-8?B?d20reEs0Ykl3UndkazFtRVVkeXVtQ1dxMTVvVDdIaVZlZlBReUFPVjZrZE04?=
 =?utf-8?B?ZHFJK05OUm85cmJLSytLck1pYWgrV2QvNE84QWVTTnJpWnBTbEF4ME5GaEgv?=
 =?utf-8?B?RHNMc3VSQ1RJS21UNE4yckoyZ3dabGJpK3BXN2cyWEpGVEduTndnZVVBQjRk?=
 =?utf-8?B?Uk9jU3F4U2NjaDVIQmpHMFB6SENzcnR5MmlhTFlYYzhzWXV0ckpYZll4b2Nl?=
 =?utf-8?B?OGxxUkZVNzkrUmh5cVdMcllvZjhZNGYvTE5VdWFRaHZRN1ZTVlltMzNmeTNO?=
 =?utf-8?B?c3BaYlZkVkdPOXpSaGdFZE9FVjcwYUloQXZjQVAybVFXUmdmcXBSUk13TGxv?=
 =?utf-8?B?eHRaYWtSQ205WHRxbm5xQU5Zb2xjUnJXZTM0TWxMQjF1d0s3ZzV5TWxkM0pJ?=
 =?utf-8?B?SXV6NnFod3MrTUs1d2JZZVJ1VVgwR0plUGtqRW5VZHloU0xJVkpkSk92WldD?=
 =?utf-8?B?dTdRK0JPNWptVmptejY4Mmp2NkdOb24ybzJPQXlGb2gyU1NvNnduK21Fckpz?=
 =?utf-8?B?NnB5cTY1RmpYc3JhMHRTNjlzY0hwQlczc3IwQno2VEJ1RkFJcDhVSnUzRkVU?=
 =?utf-8?B?L1lHZnBlRnE1bmEyMy96UmxBdWtFMUZBZFI5SkU4TGl1elJOaE94ODE3ZzNY?=
 =?utf-8?B?SUtKSk1VaHRicDRmeEhYNStHbEdnTlRzSmhlSUJQZ0lRaUZWbDBNc1JvZURa?=
 =?utf-8?B?T2ZmRFhpUjU5TDZzZkJCMzJPanZQaU1nWGFsOGlURWZFYjhYRGxpWHYxNU5X?=
 =?utf-8?B?Qm5nZGpKSTduYnpTalFGMXl5Vm8ybXZiWW45cXhlc05aUmVVZXdTS0h2ZzNy?=
 =?utf-8?B?VTNRVGkrZjcxd2xuUkVEYzBtRTZhVEVsT2h3cWwya2hYbjVsQ0hUZWR2cVRE?=
 =?utf-8?B?bWtiKzYzbXUxOUlJeE9oTzQ3TmxTTUprNEl0VVNhVEtyMWVVOE4zaUJ5MEc3?=
 =?utf-8?B?R2E4TVVRK2ptWHdtM3RmVjQ5eThma0NHaDR0Tk1HSmpyU0FMd25vQTlETDJJ?=
 =?utf-8?B?UFVjQjVDemlOSW0xYUtDMmpDTEZwbzdGZzd6cEtCYTBTZkVyT0RDMFdoR3k4?=
 =?utf-8?B?N0NLdVVya3g0YmV3TGYzMGg3aFpIMHVJMy95QTBrTlJnaUY1ZTZaTFU5NDQr?=
 =?utf-8?B?a1lWN1J4Si9xYkduV3V6MjJNZFY1VDR2WEV4SEVnQU5uSU1pMm1PeklQN0Nm?=
 =?utf-8?B?SlM1U0p4VnZXRjkraGF4QkRiZWMvUjJMZENxMGpieXVnT1dFM3Jybm14NGUy?=
 =?utf-8?B?VDErRmY0S3ZqM1ZSMkZaV1k1YTVKQjFsNHZya3ZkZVVMSnhMM0hIMmt4RUpM?=
 =?utf-8?B?WHJWMkxKcFdHU25iK1EvRndxYmhXOGg3b2Q0aWtCY1RuTmZNS2ROdEpwbTgz?=
 =?utf-8?B?UmRnQURGSUJrT2dxWWEzR1VZbzRoWTI2SHFqQnlvZzV4TXE3YU41RkVEM25R?=
 =?utf-8?B?SW02N2JnWWZ4ZnZpMDV0N2ZqYVY4NVF6UExKMTE3eXJ0TXNMOEM2ekRNR0t4?=
 =?utf-8?B?UTJaSkhZcCtFZmlWUVMzM295dXp4c1FuRUR0Z0VJV2VBSzA5VUU2TkZocGhS?=
 =?utf-8?B?bzB6THBENURtcXFMMXJqVWZXSm1qQkNqbUErWjVTT1NKSnVCWVl2TXA4QTdM?=
 =?utf-8?B?VVdXcFgxVCsvQTQvVUZFOUFtajJlWHBEdVZCYmp4WG9KeVYrMGdieFFtL0FG?=
 =?utf-8?B?aTRaRjY0VjdJTUlKQXNzVUh5M1JWMTBqcmdUMUVNTjFEa21hYm1LQXJLWUZL?=
 =?utf-8?Q?i8Xb4ARgCKM/mL1XFM4TcE/ShzC8cl+1MSng8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88da26d9-a71c-4e1c-1c18-08d8e965f430
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 16:58:57.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6L+6BK3jNP07dW0s7XPZXcwK+APLzb75UduBkS66vYjcEYreibgTBI44eyvwe99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4450
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_11:2021-03-17,2021-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103170116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/17/21 9:45 AM, Alexei Starovoitov wrote:
> On Tue, Mar 16, 2021 at 10:58 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 3/16/21 10:44 PM, Alexei Starovoitov wrote:
>>> On Tue, Mar 16, 2021 at 9:29 PM Yonghong Song <yhs@fb.com> wrote:
>>>> +       BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +late_initcall(bpf_emit_btf_type);
>>>
>>> I think if we burn a dummy function on this it would be a wrong
>>> pattern to follow.
>>
>> Maybe we can pick another initcall to piggyback?
>>
>>> This is just a nop C statement.
>>> Typically we add BUILD_BUG_ON near the places that rely on that constraint.
>>> There is such a function already. It's tcp_set_state() as you pointed out.
>>> It's not using BTF of course, but I would move above BTF_TYPE_EMIT_ENUM there.
>>> I'm not sure why you're calling it "pollute net/ipv4/tcp.c".
>>
>> This is the minor reason. I first coded in that place and feel awkward
>> where we have macro referenced above and we still emit a BTF_TYPE_EMIT
>> below although with some comments.
>>
>> The major reason is I think we may have some uapi type/enum's (e.g., in
>> uapi/linux/bpf.h) which will be used in bpf program but not in kernel
>> itself. So we cannot generate types in vmlinux btf because of this. So I
>> used this case to find a place to generate these btf types.
>> BPF_TCP_CLOSE is actually such an example, it happens we have a
>> BUILD_BUG_ON in kernel to access it.
>> Maybe I am too forward looking?
> 
> It's great to be forward looking :)
> I'm just having a hard time justifying an empty function with single 'ret' insn
> that actually will be called at init time and it will stay empty like this for
> foreseeable future. Static analysis tools and whatnot will start sending
> patches to remove that empty function.

Okay, will go back to net/ipv4/tcp.c approach. We can address missing 
uapi type issue later if it ever comes up. Thanks!
