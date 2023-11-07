Return-Path: <bpf+bounces-14445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE5A7E4A3E
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 22:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61BB1F216F1
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299C83C6AD;
	Tue,  7 Nov 2023 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OehTBOh1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500833C682
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:02:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636F010CC
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 13:01:22 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A7FwcAs004992;
	Tue, 7 Nov 2023 13:01:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=7CqCsGPeSbJJrnOzZloNxCodc+59ZJrBBiS3SUzwyJ0=;
 b=OehTBOh14ry5oYVzdmd7attbcc/q+ehd+EImEVDzoi9Gml/ZRSh84gzRN9879KWTxLOy
 X0KI/beYGQWXI/uJUJLH0NoqVL6fEvw62ADRNbapxIasN4FUv6FQYZcktlwSp8+le+Gk
 hM+++yx/e8a1Iq3d/gHVHDpS3XAWEjb5TFoY2yujv1G99gfn8bHiiC1szhK6ufWpUzPz
 vGn7oOjaim3m2M7YnZ5YgLQvG/1QAy1J95UKKHCc11vvXV+dkdG2tf1G/V33VssIpgtY
 DIXKFWC+zn5tfvBBvvmX+WQm2R9p8MQLAQDF2I3l3hvnOMU7a4iz6QPBTYUTLrLE9uBT nQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u7a4a85tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 13:01:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtIXKD//+ssdjbWnH4wloEEDljKNeQgE/yXB2AeqJvkboFly4JQXHLCPp3PteMoq6vlDGaQHc5g3hx/xI2a42vJpER4Omllo+316i5FzFUrb1IHkz9jfOJTPyMJRJgVzzTCEXAiFzecPzOM5wr4rl2tNiczfpKHkfiE0QthYt4VfBoe0fIch2dxzJLODomTU69DjUjLz+9do0OizUUchTdYZn90KeFis64rJKQWnqGOAkuKv/DH1J9DfWixZRmL7pyC8NL9FvsEGEE0414wAHA6KxoQfxfZb5C9M2oULRou3tZQvf05NovkMk0/1XbEkvjCzmuI32edNj/bNM+XsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6MuOhuN8qszpfEcMnX7hkl54YdCHB0RV+pLzsJAwcg=;
 b=JBgW4ylew6bmJ60Mm8KTwB9Fqew7uB++Qt7UGoM6al0n/x9vJ5haBkdPmhdMMUnu8WnCzTxzq5sqm9tdtmresaWqcmnVAC1xS8xxQ5R2nzZYMej4kah1y5w6EhCL3lDJbuOuxq6dcVHriiBa5ikjBDWOoDU19wBSoYyM2ScLwJzU6VQiV7sl+ro/YXJbFgO3epBJiGik6wIuKXI7it2RFtjstVyFQIQyJgujtrjW9UMjtQ2C9c33se0di0uqJnCNNm3XVdZlKqnLrr7dkXBp72Pp2SkX6mylkcYQr4aFU+7DqOGgC295tG6nrbCw33Rpejm1cESgXrWOER/LnqKPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM4PR15MB5565.namprd15.prod.outlook.com (2603:10b6:8:10e::16)
 by SA1PR15MB4641.namprd15.prod.outlook.com (2603:10b6:806:19c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 21:00:59 +0000
Received: from DM4PR15MB5565.namprd15.prod.outlook.com
 ([fe80::2d9b:2b79:d3d3:6542]) by DM4PR15MB5565.namprd15.prod.outlook.com
 ([fe80::2d9b:2b79:d3d3:6542%4]) with mapi id 15.20.6977.017; Tue, 7 Nov 2023
 21:00:59 +0000
Message-ID: <37feefda-1a65-445e-8f92-01160b1f1ea7@meta.com>
Date: Tue, 7 Nov 2023 16:00:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: stackmap: add crosstask check to
 `__bpf_get_stack`
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20231106221423.564362-1-jordalgo@meta.com>
 <CAEf4BzaUeSrgvWw7HiMDr1uF0KKSgyz+_19r03nQm+JU7WPkag@mail.gmail.com>
Content-Language: en-US
From: Jordan Rome <jordalgo@meta.com>
In-Reply-To: <CAEf4BzaUeSrgvWw7HiMDr1uF0KKSgyz+_19r03nQm+JU7WPkag@mail.gmail.com>
X-ClientProxiedBy: BL0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:207:3d::21) To DM4PR15MB5565.namprd15.prod.outlook.com
 (2603:10b6:8:10e::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR15MB5565:EE_|SA1PR15MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7322a1-31cd-4d16-a4d7-08dbdfd4a4f2
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aCRHyZWVLHGhI3qA3awjddtDEN70s3WZI3xsSnJrzs4U0888lWGmMLz0t+hTrqcbmZujqhitAv7DWTbWq0AD3Qtuc0+ES0kzmoHJ8LahA/pHl0HPyAA22/8dJYEP5ZaGu0XcHGev50chmBDsYeWYnDTBky2IYNcNLMhgnK7+uPDWw5AVtVUSbJWTQGAynkk1W3bXcLdWm/iWOnk3HpEYMDkK5cY1uLZHHnBmez1NSTiRsDVr0wa4116yzF1aa5PCsI4rEaX1zwdpJ+wfN3eUnAS7G0iYgYvUCEjrx0bW1WNj1rgCddcjaOY6sbsFifFl6bvjfb4kqMh/taHRyH+StLye/FTaA4V93cui+XPRihxK2uXcEq9LHiGDlTO3GVORdpFb5iEXiOIp+F6aX2ABiclV8cV85ZcBS0UcZDyKfYQ2B20bPFiYVfvFouDp0Jhzeqdi1/EBmFuvrsZhOcnzAv5lFpfwPAauzqqIo2eDLfiCLDX2y1XOafd34l6ejJug69607rV5HMcT4ofXyxsywQC9vJ5EOklbq5AL/ST1O+fHqhKIThjAhiGO8Bf2/C5OkUBf7Xnmrh+z0XtNiFBuzBmEidmgkeaZ8O1E7GULQj0e7FH3pFMJ/LYhKw+NrGu9dO9oll47BGuLB+P74WCPDEXZqKQ4w6t3TOmjm3tMOQ1ffbTb9ooBaT0BVP4xCAvoLfZrS55ycma2Y0nsI1ymMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR15MB5565.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799009)(186009)(451199024)(6916009)(316002)(66946007)(66476007)(66556008)(2616005)(26005)(6512007)(54906003)(8936002)(31686004)(6506007)(2906002)(478600001)(41300700001)(5660300002)(6486002)(53546011)(38100700002)(83380400001)(4326008)(8676002)(31696002)(86362001)(36756003)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUE1cC9MRFZ4TlVYaDVHQlVYRVUrSENBMzN5Tm93MjBLUkZmdXVRRlIwaHZs?=
 =?utf-8?B?YWVjd3d2dk1xVHdoaEZaRE1NSFp6SFVRQnBTRXRrNzN2V1RLWENJcDUwbXIv?=
 =?utf-8?B?U2tBNGRFVUplMkt3Y2Q0dkNBNjZkc0F4bnBOd2t1YjFkaFN4VUNFaEh4WC9O?=
 =?utf-8?B?NERyT0NHazJHT2MxSnhQa2JFTmVrRjlLby9sQ1I0YVFnNmJOd0xpNEtDQ0k0?=
 =?utf-8?B?NllCZkhKZmJFRVNwbXdLMnB4S0dQYS9ET3ZKMyt3d3hidHlmR0dXMjZGTW11?=
 =?utf-8?B?NjlXRGFkTzNwbEVlMklUbjNZMUVJU0pXZ1ZHeHRUUEhUOU1rS0tRb3J3N1hU?=
 =?utf-8?B?WkZ2ZE83R3BGVGlWTnhUYTRZZ3lhWGNUbjV2N0pXcGtDem40K0lSa1ZnN1d2?=
 =?utf-8?B?YXNPMkVkSHYwTHVaMFBrdlh5d0xSa1JUdFhtRzBWbVBQSzljclVTaUpkV3I4?=
 =?utf-8?B?QjVQK3ZwT0Q1K3p4U3Q1eEhaL3p3clZKUStsU0FEQW5uSm16WDRtclF1K21I?=
 =?utf-8?B?d3J6cEVDWFpNeGhhMXFGZjJ4Yks5eHB3TW1zaUFFaWl6T0lMeWVjSUJXSmQ1?=
 =?utf-8?B?UllKWGN1Zi83V1ZNb092dFhtalY5RkRvOVRKSkV1R2k4ZzN1bzZEMkpNVkxU?=
 =?utf-8?B?RCtGVUFRaStXRms1aTkzdmhHMTZ3b1JiYlVOM05LZFNaVXFlK1orUWZBMDBW?=
 =?utf-8?B?cVYyK1lrYk1NQzhlSHhLUWloNHM5VkE3dXV2YnJxaDV1NXJCMCtCTkZmR3c0?=
 =?utf-8?B?b1diSXdMZXovcllHRkYxNTQvdm1kY1RSNXN5RERaOFl2ZkVaeWtBN1FGL0Vz?=
 =?utf-8?B?RHAyZEhMTExSRTdSbXRBYnE4RWlMSGd4bWVVQzF6THJDOHpCL0d6SWFHWVg1?=
 =?utf-8?B?NEJBRjhRbzdObDM4VFdKa2VFL1luVWxLYlczdWRoNTdsVlZya2o3ZHJ2SWhu?=
 =?utf-8?B?cmdYRk9MZWRnb2t1WFhzdXhJUEpFamlGYmNLbVlzTzZIMmdZZnlvT0UxQ3po?=
 =?utf-8?B?aG02THlXR2VMT20yOGEzVTRLM2tleldUM1dSdE1mSUo4MHlVZjU5cmtSMUNq?=
 =?utf-8?B?MkpFT2dBYWtQdjRGTlZaNHN3YjBUaWhKeHlzUVhKN2cvSWRSeE5oMEV2cUQ0?=
 =?utf-8?B?KytxdksrTTNYR3puazhialIzTFhQNWg0SWRQTzRvN1o5V2NkMEZMTEI4c2J0?=
 =?utf-8?B?elA1bzF3WFU2QklBNWFCS3FtV0pxVU1VTFZ3cm1BSU54WlYvV1hCWHNkcHh5?=
 =?utf-8?B?aWdNOUtnWkNwUGpZb3lHcUNGY0puOXh6K0l6TG9FTW5qdy9JT0ZzMUdSczRN?=
 =?utf-8?B?UHNISnhYaUJha2lhUmhaeVU0RXlMQ01NNk5TcGJxQzkxbnU0K3lMdGNpQWRk?=
 =?utf-8?B?VTh0bEdEODRyVTU3QzJWQkxTd2l6V3pJZVFDNEtaeFZ4akM5a1NJOFVRNURL?=
 =?utf-8?B?QmIxT3Y5Sy9VTkxyQ3lvZGQ0YStMSThKQUIyOHY0eHhrcnlpSTByTlUvYWpN?=
 =?utf-8?B?NUhZeXVRbmdGTC8xblhWVEtzQ2J2SUYzc29XVVdaZVRITnE2YWd3clFNSHp0?=
 =?utf-8?B?dWpyK2E4dkc1NkpyY09wU09LVlhuRmJqa3BhWWlVY3hINlNZZ2gvdUttUEJn?=
 =?utf-8?B?ekIxMS94WmdoZmZ5MkJLYWozV3hUVkF6Rm1qSW0vQTk4L1dqZFJyZUIzcVVQ?=
 =?utf-8?B?MUNtajhLcDhTUjM0Q3NvUXJ4SDFadGQyK0IyVWozVmUrN21pSndGQ0V5Q0NG?=
 =?utf-8?B?TmVCTysvWHNDVWdvM2RoeHJycFFZd2F5cWNBeFAzU3drb0N3RC9RSHEzb3cw?=
 =?utf-8?B?cC9YcDVTdkZvUVE2aVl3QWFsRzNtSlV3YXo3aXY4V1llTzNSbndUSzd0cDdW?=
 =?utf-8?B?RWltWTN4MTNBd3NGZnRvNFkvRmpvR1FjTTg3c2RTSlMwK1VJRlBuRU5wcDRk?=
 =?utf-8?B?TjFYMStkVTVTdk9pUEVPR3gvZm9MTE1LUmx2ckxWd1RubkdFMFRCSUJXSjd5?=
 =?utf-8?B?TU4vbXJkWjRGd0NReExTWWs5N2Nxci9wVVJmaUx0ZEp3SXJHOFd4dXNDc3Ew?=
 =?utf-8?B?SmZBRjZUZUphSXJoQmkrZnQydlcvVUV5TTQ3dmo3K0dmcjlqY05nck9ERXJK?=
 =?utf-8?Q?0pJxPZzi2uF8pIAX4V45PQah0?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7322a1-31cd-4d16-a4d7-08dbdfd4a4f2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR15MB5565.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:00:59.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJBgVD+TQOlzsqQScpMwtU3Qs0NZgL+yAmMJqw2deDObBWLNpEQKNWXHZ167s2vFfrvPhco4sVzZmI3m4lkN8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4641
X-Proofpoint-ORIG-GUID: d0q6dN3tu9d_ID6xIlDrq8bJwqCa4rOz
X-Proofpoint-GUID: d0q6dN3tu9d_ID6xIlDrq8bJwqCa4rOz
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_12,2023-11-07_01,2023-05-22_02



On 11/6/23 5:45 PM, Andrii Nakryiko wrote:
> >=20
> On Mon, Nov 6, 2023 at 2:15=E2=80=AFPM Jordan Rome <jordalgo@meta.com> wr=
ote:
>>
>> Currently `get_perf_callchain` only supports user stack walking for
>> the current task. Passing the correct *crosstask* param will return
>> -EFAULT if the task passed to `__bpf_get_stack` isn't the current
>> one instead of a single incorrect frame/address.
>>
>> This issue was found using `bpf_get_task_stack` inside a BPF
>> iterator ("iter/task"), which iterates over all tasks.
>> `bpf_get_task_stack` works fine for fetching kernel stacks
>> but because `get_perf_callchain` relies on the caller to know
>> if the requested *task* is the current one (via *crosstask*)
>> it wasn't returning an error.
>>
>> It might be possible to get user stacks for all tasks utilizing
>> something like `access_process_vm` but that requires the bpf
>> program calling `bpf_get_task_stack` to be sleepable and would
>> therefore be a breaking change.
>>
>> Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
>> Signed-off-by: Jordan Rome <jordalgo@meta.com>
>> ---
>>   include/uapi/linux/bpf.h                                | 3 +++
>>   kernel/bpf/stackmap.c                                   | 3 ++-
>>   tools/include/uapi/linux/bpf.h                          | 3 +++
>>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c       | 3 +++
>>   tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c | 5 +++++
>>   5 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 0f6cdf52b1da..da2871145274 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -4517,6 +4517,8 @@ union bpf_attr {
>>    * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 si=
ze, u64 flags)
>>    *     Description
>>    *             Return a user or a kernel stack in bpf program provided=
 buffer.
>> + *             Note: the user stack will only be populated if the *task=
* is
>> + *             the current task; all other tasks will return -EFAULT.
>=20
> I thought that you were not getting an error even for a non-current
> task with BPF_F_USER_STACK? Shouldn't we make sure to return error
> (-ENOTSUP?) for such cases? Taking a quick look at
> get_perf_callchain(), it doesn't seem to return NULL in such cases.

You're right. `get_perf_callchain` does not return -EFAULT. I misread.
This change will make `__bpf_get_stack` return 0 instead of 1 frame.
We could return `-ENOTSUP` but then we're adding additional crosstask=20
checking in `__bpf_get_stack` instead of just passing the correct=20
`crosstask` param value to `get_perf_callchain` and letting it
check. If then, in the future, `get_perf_callchain` does support=20
crosstask user stack walking then `__bpf_get_stack` would still be=20
returning -ENOTSUP.

>=20
>>    *             To achieve this, the helper needs *task*, which is a va=
lid
>>    *             pointer to **struct task_struct**. To store the stacktr=
ace, the
>>    *             bpf program provides *buf* with a nonnegative *size*.
>> @@ -4528,6 +4530,7 @@ union bpf_attr {
>>    *
>>    *             **BPF_F_USER_STACK**
>>    *                     Collect a user space stack instead of a kernel =
stack.
>> + *                     The *task* must be the current task.
>>    *             **BPF_F_USER_BUILD_ID**
>>    *                     Collect buildid+offset instead of ips for user =
stack,
>>    *                     only valid if **BPF_F_USER_STACK** is also spec=
ified.
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index d6b277482085..96641766e90c 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -388,6 +388,7 @@ static long __bpf_get_stack(struct pt_regs *regs, st=
ruct task_struct *task,
>>   {
>>          u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>>          bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
>> +       bool crosstask =3D task && task !=3D current;
>>          u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
>>          bool user =3D flags & BPF_F_USER_STACK;
>>          struct perf_callchain_entry *trace;
>> @@ -421,7 +422,7 @@ static long __bpf_get_stack(struct pt_regs *regs, st=
ruct task_struct *task,
>>                  trace =3D get_callchain_entry_for_task(task, max_depth);
>>          else
>>                  trace =3D get_perf_callchain(regs, 0, kernel, user, max=
_depth,
>> -                                          false, false);
>> +                                          crosstask, false);
>>          if (unlikely(!trace))
>>                  goto err_fault;
>>
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/b=
pf.h
>> index 0f6cdf52b1da..da2871145274 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -4517,6 +4517,8 @@ union bpf_attr {
>>    * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 si=
ze, u64 flags)
>>    *     Description
>>    *             Return a user or a kernel stack in bpf program provided=
 buffer.
>> + *             Note: the user stack will only be populated if the *task=
* is
>> + *             the current task; all other tasks will return -EFAULT.
>>    *             To achieve this, the helper needs *task*, which is a va=
lid
>>    *             pointer to **struct task_struct**. To store the stacktr=
ace, the
>>    *             bpf program provides *buf* with a nonnegative *size*.
>> @@ -4528,6 +4530,7 @@ union bpf_attr {
>>    *
>>    *             **BPF_F_USER_STACK**
>>    *                     Collect a user space stack instead of a kernel =
stack.
>> + *                     The *task* must be the current task.
>>    *             **BPF_F_USER_BUILD_ID**
>>    *                     Collect buildid+offset instead of ips for user =
stack,
>>    *                     only valid if **BPF_F_USER_STACK** is also spec=
ified.
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/t=
esting/selftests/bpf/prog_tests/bpf_iter.c
>> index 4e02093c2cbe..757635145510 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>> @@ -332,6 +332,9 @@ static void test_task_stack(void)
>>          do_dummy_read(skel->progs.dump_task_stack);
>>          do_dummy_read(skel->progs.get_task_user_stacks);
>>
>> +       ASSERT_EQ(skel->bss->num_user_stacks, 1,
>> +                 "num_user_stacks");
>> +
>=20
> please split selftests into a separate patch
>=20

Will do.

>>          bpf_iter_task_stack__destroy(skel);
>>   }
>>
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/t=
ools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
>> index f2b8167b72a8..442f4ca39fd7 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
>> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
>> @@ -35,6 +35,8 @@ int dump_task_stack(struct bpf_iter__task *ctx)
>>          return 0;
>>   }
>>
>> +int num_user_stacks =3D 0;
>> +
>>   SEC("iter/task")
>>   int get_task_user_stacks(struct bpf_iter__task *ctx)
>>   {
>> @@ -51,6 +53,9 @@ int get_task_user_stacks(struct bpf_iter__task *ctx)
>>          if (res <=3D 0)
>>                  return 0;
>>
>> +       /* Only one task, the current one, should succeed */
>> +       ++num_user_stacks;
>> +
>>          buf_sz +=3D res;
>>
>>          /* If the verifier doesn't refine bpf_get_task_stack res, and i=
nstead
>> --
>> 2.39.3
>>

