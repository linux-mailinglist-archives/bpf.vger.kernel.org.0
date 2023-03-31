Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B187B6D1797
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 08:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCaGlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 02:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCaGlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 02:41:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FAD11E89
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 23:41:03 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V3xWLx007626;
        Thu, 30 Mar 2023 23:40:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=qE960Zlo3sjmWWVucsSnthdmKrO1O5Iuw2BnIxNRfqY=;
 b=Nc5nhbvf0e9yrNzsmJMGIMYrjMUJiqY/oLqy1ANLX5wjfIW/DwymjpVlaNgLOeg8mb9p
 hl97gYkJe5YJV63ILIbPAliihEmRRGB282uqWW46CY3Btq6SaZ3bZaCKUkE6xfZfaf6d
 eOz1fU+LLTySTsQnSFw7O/JKsdqGRTjgo/hbvxyhRuLqG6mlBqp1S4pM/N0cHRhOXok7
 HAtxoLnFv38tFBpNVPevo93igHmYwQQlYCt510xGVvTezQAzeW/GPrjNTRb+5SujOnIZ
 3pFB2LNZEBaiaMYtsC1ILvld0RTTGSOIqKd13l1xXPzkd52bx6IHizOyB5v0i9XQbknA 4g== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pnr3frmwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 23:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgnf2AVh3E6HzfhkBnU3MgrmbEuK+LtRzS7XgjqxtECIGKntBhe2mdLTuL17y7MQET8dZ4EmJ6YOARXRohA9n99aL+g9d7r4RHs2RCt2J1ex2oO7WECOa/pwF14wk3M/o/nMp6sZ62PCpEGtLWMel9NXYrtNUPAPLswg0RCg6FntboqebA9xhwKYOs6awKYVR8MP4NM/8xGL3Et8XS3yA0Fid5Gq/0RSfFOHy87Pah7+v+Pgwp6gOoxem75LrZyTIVLf9F0EKKuyAwCV1bWfJQdMPovU1UYaKmG+u22AMXCk+X8hOo1YBX3REWz/wSJ7vyDKwdgPxLDcKnETEGYV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE960Zlo3sjmWWVucsSnthdmKrO1O5Iuw2BnIxNRfqY=;
 b=TOEWAF2243t+aREv4UfAaOu0/JMyHN5GPuc1bUvl9mvfuqw6X0NEGP1veoJIwKYhKV9RB6T+SnVmZGH/IUjE63ug62x62Wo2BrqhLEEtXvr0MMV2eqJ4TWyGKISAMArbjmPTIZk8KWh1FPTOPU2urZYXaqbS5beLjRbM1GHGc1ELZ9z24bZ6knVruF5uMwYz6A88DVm7FA7aio+NmCZlHYd56QGfEjz+Z78BMakVBNZ9dMRskZ7HkhKlCpvs9G47aWarTLerH45yYkf/noy0WgOQGBw3qy+puZ/yRcNElOFk2QFIRKHvz/JCWEk7ZzYUXABfzyliwYTol9a23w/Acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5895.namprd15.prod.outlook.com (2603:10b6:208:3f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Fri, 31 Mar
 2023 06:40:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%5]) with mapi id 15.20.6254.021; Fri, 31 Mar 2023
 06:40:46 +0000
Message-ID: <689e376a-a6fe-d1f2-cc92-320e5ed1c44b@meta.com>
Date:   Thu, 30 Mar 2023 23:40:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next 1/7] bpf: Improve verifier JEQ/JNE insn branch
 taken checking
To:     Dave Marchevsky <davemarchevsky@meta.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055605.88807-1-yhs@fb.com>
 <e16053a8-d9af-ea22-3653-9cb9591c2eaf@meta.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <e16053a8-d9af-ea22-3653-9cb9591c2eaf@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0049.prod.exchangelabs.com (2603:10b6:a03:94::26)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7f9120-49bd-48fa-8c52-08db31b2db9b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrgS1re+qBSkjfgyMuEbu00EPM7lrgzWo9ynAkeuUp4LvUe0EQERWTHVkUzd6Hr3xS0mBCcA6uK/T0Jz2cMuCZsd4C3UxrsS6FRriEjut86T8x5sDCniG+sL48VYcf3o30IPvgY2mxV61Hd9xF800QPRAf3SmCEt96cF36fG2vV66U0nlEhD8kt7Xa/r22BMqx4Qcwq94rRQU2SklM8hobzeBU2zYMMCVeCLXSV8k62o5qKaEXuxy1BSjcnBdhoWwAO7cH1qchZdniwKqfp4Dq4pa4s/+J2bCDwaC6irc+kgeJvg9jDTdBmnkxFezJE8eSVoYgCHhpKrylU/Q88lapeLT+vfijy2kZOVw2q50hXqbYL2pQ7PijJD5y4oDwP9RG7lEvof28QqEhNdiRfkz8iFIaLFdSR5XDU/UBg6hX4FxxEcLEH8+iFISBHA4cD4ubbYU70Ice4XFtJ3uIShjEH4dz31eZCqiA8rH/fUw0EdNHD39SP6wKpY2VxBja2WRy5AHsagbm1cXJsLecDyamFBOlrrS2A2VWv4QPK8J2O5ttwgQTm0IIJGXTNSFYk126yObHKXrz71+rygmv5hFdXkanPaunFA88gpuAlGUEjqn5htSiyfJAk/kOJYFMe4JJF9SGIrLqXPOBgIQ3wvFdouadtNonPdds53qKLDi73Pz5C0RuZ6oSUmMJmobQu+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(316002)(110136005)(54906003)(31696002)(66946007)(36756003)(53546011)(6506007)(6512007)(6666004)(6486002)(478600001)(83380400001)(2616005)(38100700002)(186003)(5660300002)(2906002)(41300700001)(8676002)(4326008)(66556008)(86362001)(66476007)(31686004)(8936002)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTRkNjJZczIwdkh3djNsdkt4UmZ0TXp6NWlGK0hzNkpsVUh3SU8vRXBVUlFC?=
 =?utf-8?B?RmVxcG5oMnV5YU1FYkxzZmwrVmdwQWoybHk2TGJleG9NVTFiaWZCRUJPWHdP?=
 =?utf-8?B?VlB5R2I2V1cycTAyQXhjSjhhcWtrNDc1NkdFeHNneVExQzA1RFN5VDdsUm1I?=
 =?utf-8?B?ZytJb1FpazkrdCtsbkJXK0lwU05wWlB3SUNMaDViMDRJd3F2bmsyS1RGVzBZ?=
 =?utf-8?B?RWVJSHk5dG9vR0ZGQk1JMHhRN21yNmgvZmRwOXpva1lDaVJ3WUdjR0ZnYUJB?=
 =?utf-8?B?anBROWFvYXZrczlWUnROamFNa2tHYzRITUVWMjR4aENCd3hvRWl6NDBja1pZ?=
 =?utf-8?B?WU0rcXZ0SWJJRUVyMnV4UktJUW5scFZtOEd2b0Z1YmNlL3JvcXEvNlorRC85?=
 =?utf-8?B?Yld3L2MybHJkTlRmL1RyQ1p1bjhqbkxkdjlFbjl1VVJ3L1BneHM2VTBvdVMv?=
 =?utf-8?B?MDBySzQyelNQeU43eXY5TENmVWhaVG5TbStJbEl3WWh6eXkzUDliSHdTL3Bs?=
 =?utf-8?B?VGxxZzNyajhXSzR6cm41SFhHakJlK0FjdXdkNiswL2dxMVZqSU1Db3J1dmtp?=
 =?utf-8?B?Nm1hczRKZGFsTHBnZCtnN1ZVeGN6OUh1VWx1MTJDUVM1NmhjbS9qVHdiMWI5?=
 =?utf-8?B?OFFPcXhGYks1R2JveThZMHpDdjF5Njg2WTJUTlB4S2xodGlMdWx5cjZ5VUlY?=
 =?utf-8?B?c0pwSDJuNnc0YmEwYjhUZ0FmMXZObTlIY0tXMCs0bGhwY3FuZkZoTURUaWF3?=
 =?utf-8?B?cmpucVFjd2MrS2hJWEZpdzNBQWFuNTdHZkZQMkRIOSt6QjVBL05XWkdOaWto?=
 =?utf-8?B?Q29NZi8rMW5odXZJVzlkZEQxbFpIWExEL2VLQmZDMFZwZWs3K0wzWFFpWjRo?=
 =?utf-8?B?V0MySnYyVlRZTTdkWEFIRlZmUUpiaURDbFlUZGJvQTJJeklYOTFkWFpBNWp4?=
 =?utf-8?B?RlYwN1pFcG5MUGpSM1NNdEx3dk5HUjlXWjh6QnRIRDlJaDJmdnYvSGZmYlIy?=
 =?utf-8?B?bDU1MTBIS0RmditNRkdRdG1MTWt2c2UrTlVOZDVUNEFhaFZjemUwSkhSekZk?=
 =?utf-8?B?WXBoemtHbEgzVWgrZXl6bjVJY05wbnBkVUJ1QkJidXZnUlJWa0hNVjRwYmxz?=
 =?utf-8?B?TXZvVWxTN1RhdlFsMUgxOEdXOVkxMkxNNGp1ZUlDTHRlc2lrZ1lmdzFpNG8w?=
 =?utf-8?B?SXlVY3cvMVBCeHk0YVYrRUlWZE5wdHlSSlB0VmxOTmdpZ3JnWXlJei9QYjdU?=
 =?utf-8?B?emFCbC9MTW5CU3h2VExnRUxFSE4wMWJhM1hja285QXNsZXVCdkV3YWZKdXRp?=
 =?utf-8?B?dHZTYUdBUTR4a2FHQ2ZoNEttVmQvUkJyS0tSVHFKazZkdkVxN05XcEwyRUNk?=
 =?utf-8?B?aDJ0aW9Zc0F5eGIvSVdmTDRCaEpLUktueU96VWt6RGRlZjhGNlJJc2p6am9Q?=
 =?utf-8?B?bGdvaENqTW4yQkpxNlR6TFkxZm9Mb08rUlg1R3RKZ1NMSlFZVTNDSDcwL29I?=
 =?utf-8?B?Q25GYXFjV1dPWXJmSHpzMVRpa0dhcjNVTW1wZGNhaGRmWVNoK2tMQkx0NDdY?=
 =?utf-8?B?OE9RY01LVTYyTVE5QnZDUnhEZnc3Uk5zbHUvTEFyUi9XTnhWZnRLdkUwb1gz?=
 =?utf-8?B?N2cyS3FZRHlUcGxEUEI1OW1HcEc2S0Zyb0dacDZ1R2gxTkxXOFZ2UE9wY2c1?=
 =?utf-8?B?dmxNb0hpeWs1RnI1bnh2citnSnpZZnRpbXpBU2RHTFc2bjZTS2t6RGJVekhT?=
 =?utf-8?B?emhiR2hQcklUWXhYQTRBNHowNldjbXdLM0QwTU9GYndxbHJHS2FTWEhUVGVE?=
 =?utf-8?B?RXNzTW4raVJJZWtKR0lSanZUR0lNYXdFRndRMXFVNXlNcStIdXF0aWhIQlZ1?=
 =?utf-8?B?MmVXbzRkM3Fmb2FWSVpWcjRZd3Aza0JLSDdCdmgwTVVvU2FJc3hOamxaR0xr?=
 =?utf-8?B?VjBxR2NiYUNJb3Ftc3A0TXJSVVNkM0dGeDZrcks3UTUrc0cwNUw2YnROUUVH?=
 =?utf-8?B?K1Y4azNiV0grdk8wcWJqOEFDbW8wRFFBSXZyUEJ5akl5WVdXZzBNZzEzMGkv?=
 =?utf-8?B?dGo5dGJ4REM3NXJEdWpKbi9PMGVlTllNa0h1cDBUeklXZkR2KzAvaTg2Mm42?=
 =?utf-8?B?TUxPZ3FHU3VtRllkUXdJQmdKODJKTjh5dm5SWXFVTzl5TUNYUDVCNHdhMDJp?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7f9120-49bd-48fa-8c52-08db31b2db9b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:40:46.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptyhoVhdWp8RmBuvC2JGfni4l1u9RRN53a9aJOCusTfD+oqS6EDnHS5zxXEfEbwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5895
X-Proofpoint-GUID: n90vFKhK97gkbkS6IA-Kv_tZSaUSH_DZ
X-Proofpoint-ORIG-GUID: n90vFKhK97gkbkS6IA-Kv_tZSaUSH_DZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_02,2023-03-30_04,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/23 2:14 PM, Dave Marchevsky wrote:
> 
> 
> On 3/30/23 1:56 AM, Yonghong Song wrote:
>> Currently, for BPF_JEQ/BPF_JNE insn, verifier determines
>> whether the branch is taken or not only if both operands
>> are constants. Therefore, for the following code snippet,
>>    0: (85) call bpf_ktime_get_ns#5       ; R0_w=scalar()
>>    1: (a5) if r0 < 0x3 goto pc+2         ; R0_w=scalar(umin=3)
>>    2: (b7) r2 = 2                        ; R2_w=2
>>    3: (1d) if r0 == r2 goto pc+2 6
>>
>> At insn 3, since r0 is not a constant, verifier assumes both branch
>> can be taken which may lead inproper verification failure.
>>
>> Add comparing umin value and the constant. If the umin value
>> is greater than the constant, for JEQ the branch must be
>> not-taken, and for JNE the branch must be taken.
>> The jmp32 mode JEQ/JNE branch taken checking is also
>> handled similarly.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 20eb2015842f..90bb6d25bc9c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -12597,10 +12597,14 @@ static int is_branch32_taken(struct bpf_reg_state *reg, u32 val, u8 opcode)
>>   	case BPF_JEQ:
>>   		if (tnum_is_const(subreg))
>>   			return !!tnum_equals_const(subreg, val);
>> +		else if (reg->u32_min_value > val)
>> +			return 0;
>>   		break;
> 
> The explanation makes sense to me, and I see similar min_value logic elsewhere
> in the switch for other jmp types. But those other jmp types are bounding the
> value from one side. Since JEQ and JNE test equality, can't we also add logic
> for u32_max_value here? e.g.
> 
>          case BPF_JEQ:
>                  if (tnum_is_const(subreg))
>                          return !!tnum_equals_const(subreg, val);
>                  else if (reg->u32_min_value > val || reg->u32_max_value < val)
>                          return 0;
>                  break;
> 
> Similar comment for rest of additions.
> 

Sounds good. I agree reg->u32_max_value < val should ensure the branch
not taken too. Will accommodate this change in the next revision.

>>   	case BPF_JNE:
>>   		if (tnum_is_const(subreg))
>>   			return !tnum_equals_const(subreg, val);
>> +		else if (reg->u32_min_value > val)
>> +			return 1;
>>   		break;
>>   	case BPF_JSET:
>>   		if ((~subreg.mask & subreg.value) & val)
>> @@ -12670,10 +12674,14 @@ static int is_branch64_taken(struct bpf_reg_state *reg, u64 val, u8 opcode)
>>   	case BPF_JEQ:
>>   		if (tnum_is_const(reg->var_off))
>>   			return !!tnum_equals_const(reg->var_off, val);
>> +		else if (reg->umin_value > val)
>> +			return 0;
>>   		break;
>>   	case BPF_JNE:
>>   		if (tnum_is_const(reg->var_off))
>>   			return !tnum_equals_const(reg->var_off, val);
>> +		else if (reg->umin_value > val)
>> +			return 1;
>>   		break;
>>   	case BPF_JSET:
>>   		if ((~reg->var_off.mask & reg->var_off.value) & val)
