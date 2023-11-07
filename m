Return-Path: <bpf+bounces-14447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C47E4A63
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 22:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFC21C20BF5
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBE82A1C0;
	Tue,  7 Nov 2023 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HoH6ZM3o"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9372A1B0
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:15:28 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCFE10DF
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 13:15:28 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7FwNKn013198;
	Tue, 7 Nov 2023 13:15:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=mMyrMCvY40YjiLPCfI16dMnpYsCvVwG5N/bnFMNYmi0=;
 b=HoH6ZM3o+qkCqorqcQnsXBJRO19Vce00O3Kn3mx/kfTMESSplFfLFPRzO1blRwNxGuh0
 369kj2K6DxC4wb/UGRi+ORo/kLJMwp/Q5y6O4zALeeSO7s4V6OAvq0jVkr2rhxty682o
 4Aoi9u2emlcjEMR3eb7ra5Fee1s01RMNYGOVpCawGCaCUAadUCNOR1/R/lrkN/qBGeR4
 HN5gF3OSNjsbyMFIvddHQHAsazc3m/s1aKcY/ErZCxXS73LMG/Ei96ZXrk7F2oXSe1oU
 mHWInK1VLVs5JFTHeDz0efgpeC962YEtMdYRONori32Z+tqCgKoS9UvIbcUIpKpaiPVk Bg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7qepuaua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Nov 2023 13:15:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL2r5IlpMlz6HIleGHmLnBPdXzEY9mpuxqb8/geXy1krnCIZ5HAJlOf1NnvUNRMz5dYluyAxaTrxTVaXrFvHdueK14vvGAtY1qD2F2UBNCzjZqwdn9qy9SPUjb8+oHA68YL9Germ/Dv7k3ucirTTInC8f8+ZS41FEMBSNOz4czeEZoJJjUE5wqyvbEjbmEV9Xl4j84PmiME/5wd4hqqrcm/5uDMyji3Txz6N+OKy8J1U4Htat12529ZJuBXtxwSvVeTbEnXlItvYfDIpdpucdN8CABFg3SL7O4eDIAwpPou8dC4g25ETFtCWmzn4M5/mjRutORQHpzFpBR9JqnWH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2jtEiTbXifSGV07He9o8rcw8dEHATafXew3UULYUAc=;
 b=PLKzmc554K42okFUXmeYDf1JRsGm9Dlnnx8jqmmxBYDupdnicW9dtK7nPQpejLwsCxAKQM1fUQ+ZCfPhqq8NaInyd9jP7w7CHThvWj4S9gqvb0INBxjA8YF+4+VuccxI1s/6ScUPGZyYnq28piLnItFfEI78s7RuAmdPv+HkQ3Usmw9f2/XIjaZQe4sVvFjum17jr+VyMnz7iSC5KISSPKn1W3fGL7W0mYh57+iRPLhsHc8Cj9KpNP0ysMrI27CbyGGfwTW/2JqkhfC0Hru34TUgl9vb8uad7gVRBF8itEMsWQiXC7NqE15N20JS09jP/xvKiO16bWSM/akUNx4+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM4PR15MB5565.namprd15.prod.outlook.com (2603:10b6:8:10e::16)
 by DS0PR15MB5924.namprd15.prod.outlook.com (2603:10b6:8:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.17; Tue, 7 Nov 2023 21:15:10 +0000
Received: from DM4PR15MB5565.namprd15.prod.outlook.com
 ([fe80::2d9b:2b79:d3d3:6542]) by DM4PR15MB5565.namprd15.prod.outlook.com
 ([fe80::2d9b:2b79:d3d3:6542%4]) with mapi id 15.20.6977.017; Tue, 7 Nov 2023
 21:15:10 +0000
Message-ID: <8d83c573-789f-48cf-8911-88bbe6a379c8@meta.com>
Date: Tue, 7 Nov 2023 16:15:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: stackmap: add crosstask check to
 `__bpf_get_stack`
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20231106221423.564362-1-jordalgo@meta.com>
 <CAEf4BzaUeSrgvWw7HiMDr1uF0KKSgyz+_19r03nQm+JU7WPkag@mail.gmail.com>
 <37feefda-1a65-445e-8f92-01160b1f1ea7@meta.com>
 <CAEf4BzaSzfJvn==NfUvMmg6sg6N6+iZLAT8he+ayrBDnAW75Og@mail.gmail.com>
From: Jordan Rome <jordalgo@meta.com>
In-Reply-To: <CAEf4BzaSzfJvn==NfUvMmg6sg6N6+iZLAT8he+ayrBDnAW75Og@mail.gmail.com>
X-ClientProxiedBy: BL0PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:208:51::49) To DM4PR15MB5565.namprd15.prod.outlook.com
 (2603:10b6:8:10e::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR15MB5565:EE_|DS0PR15MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4c9ad3-57f6-4ad3-16af-08dbdfd69fee
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4FD0YYMq1qu5XV1SoPyDIwiQ7UxAlM6lark60QKjeDTX3ZN6nSgD0moZ4VO8AmahxrYnWs7BYcofFfs/NrYkybK1ucojpy3/wdOQAysAohg1Xfc5h9Plm+ZVbZr4gy8rZH2rBhqnxsPaaVLMJ4+JCRyaAS2Qluo0R35vhgf3Z8ly3oxH3UDPmWQrxe4q4GNNwjRn0+t/DAChRW21vcGx4XVHjUWnW0W4cgEb+1psfXG9Y1j41erSsWaoG7u7ta/m/jJYHK3OGXiQx5OnK8+Rz+NgFzeiTYJoUr96O8L7llq/CI8qD5zgobjf7L7BaZyPKii+gk+p2LkIzWB2uj4d3nljqjfbNmTX89iAvYUU8P+zL8qbMwzN+UR5LpRy+2UwT1I/kinwXulFZMPmBkwJ+mj/d0U+tnwtmjcLJAjEr5PVxiDTqRXOaIGeVZvasdI8o9m/qxSWi199UOLtFC0y7Za7cuxCCYDqt5b0MSsfiAX92cz/kQ1rohmPDuDhHeV8/bSudI0ULQOFgUGl6QVXdC7L6t4o8N4V6rWuxNbr/NnQx4UeFxV14NP5iIImabHHJumLpC6Cb6b+pvwFFvpHN7JMmcBHiJ/nmZZ9stsVRKqY27jQuJGOhoMeUEN7kd0prtlPP2BEQPF1/j2TtAaWfsXUl9OBO35eYuBeMi1adyuE/7GaendzuR52Iu3FEBDBafFhZ7817AervREfYzoOuw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR15MB5565.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(38100700002)(6666004)(31696002)(478600001)(6506007)(6512007)(6486002)(53546011)(54906003)(66556008)(2616005)(66946007)(36756003)(66476007)(86362001)(31686004)(26005)(2906002)(6916009)(83380400001)(316002)(8676002)(4326008)(5660300002)(8936002)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y01MZ2xpT3lKaEJ6QTRLWlBFVTZBTUh3bWFYSUpOTHA3amJkQUlEb1Y3dnNj?=
 =?utf-8?B?bGtXQXBjdW5rUlRGZ2NuRXJRSkVpVm90a2xBVlZDZzBGNGk0c3RWcFhpd3oy?=
 =?utf-8?B?d0tVTjVrU1ErVWJ0MjJwNGd5VlBVdXo1UCtaTFhESzIycUFzcUZvWVM5WGla?=
 =?utf-8?B?dXFlNFpuVkxsMTA5blRFaGI0UG1YZ1hpMVV5ZlJpYjJMMHl0QzNTTzNHNlRL?=
 =?utf-8?B?SFo0Zk8zSzA3R2FVUXRvMG1uQWdYR1VWeU94dlYzSmxaWDRReW1YL2dMbmZC?=
 =?utf-8?B?YTIxeit4ZHlqVWlDN1orVTRYSlpzYktweHZhL29QWkZzOU4rdklLeVpPbEs4?=
 =?utf-8?B?a2szNHl2MFp4czg0WjBvNjYrcHl4S3MzOVJaQyttelcxZ1pFYVgrUEEzbEh0?=
 =?utf-8?B?eXo4UmVkbXdrY1gyMHA2VGtxYTFYTTl3bmM2dXBJMXZOTldNOFNoNHNSYmlx?=
 =?utf-8?B?Yk5jc2d3ZW9KYXNNRFNIQ1JWOTVHb2hRQnRnRmVsRUdocldNMVZXZlg1QnVr?=
 =?utf-8?B?dS9xVGRnVWJqQU90WGdWSDRpdU9ic2F2MlJGTTdZQUUvYU5SMG5KTDBjYzBI?=
 =?utf-8?B?VDJEVldtMWt0YmM1cW9TeGFlZ2ppUVdtVDRtTUNNeS9wM2tOR1R5dXRrS2Qv?=
 =?utf-8?B?VEdmbWhvS1VPQ1V6eDNtSFoyZ2Y4MDJFaHZjeFI2NXpmMkhkRmJFb2haQWNL?=
 =?utf-8?B?V1J0aUsvanRRVk04akszQy9nbUthOG1PcDZCU3dZY04vTHNYQzNCL1RKbTFL?=
 =?utf-8?B?d2xHb3RWbGxCdGlDcHB4S1RVdDJwVkQvT1ZLOXBXdzc5UHdtNWo0SExTY0FG?=
 =?utf-8?B?eUp2VlVGOWFoR2kxaGNNZHBSQ3RrVWFJaWN1Z2hPb2Zxc2xaemtxUUZiUW1C?=
 =?utf-8?B?MWhWT1l4NzUxRWd6RTcxSkNMMUdZK1FVa3haOHJFN0d4NStrUzVKVkhzQXFQ?=
 =?utf-8?B?MTU1UUJ3WTI2RzNqYzNhT0h5dGNINnQ2S1NPZ0xiNEtSVXVndG82TUVFU04r?=
 =?utf-8?B?Ky85NFJMbWliQzd5UFBlR1lsYkZqRTdaOGxVTFR0d21uOU55cUpPSm16Rk9v?=
 =?utf-8?B?blFkNTNvSENxMTNBNFNWMlpwSHQzR2o2a1I5ZkRCRTNJNnY2TDJvTi9LM1Ev?=
 =?utf-8?B?UnpxTEJNTWtBOW9CSUhJbVVFSlJIWVNwVEpLeXZDckN6NThVdjc1Ui81MFhZ?=
 =?utf-8?B?UzlMMHRCNzA1VS80R2I4cWdzcU0rWWFZZGE1WmNsNDlwZVJRaEUwaUJLYnBi?=
 =?utf-8?B?dllscElDR2t3VTF6NzV5OTJJdlRiUFpKQm1uU29NT0NNeGJpYzNoVERIak90?=
 =?utf-8?B?ZEE0TnAvMk1vTUVFRmo0ajkreEswWnY2cUJlVTdESEVJbmkyNXg3SDMxYWFG?=
 =?utf-8?B?aXorcE9MbW80UGduUXBTRDQyaWdHNXlCb2RGMUlwWHNCQVVtYWk0dW5Xb3ZR?=
 =?utf-8?B?VlJlTWZGZ09INVMrWVZRd2htN3VpV1B1QmJiK2dVcGt2RGpUa3dwNGhFalJS?=
 =?utf-8?B?dGpMV0JudExTY0VXUEcyU2FIMXlSa0lrVldRZGRmNkhlRGdlQUUwWEs5UGgx?=
 =?utf-8?B?WXM4MVNvZFdvMTJ2YkMzZWN1T2N5VDU3QkE3VzdsK3hlUEh0V0ZlcHdiY21F?=
 =?utf-8?B?SGFLZHcvOXZ6VkE3K1gwdzUyc3JqWGQ3ZGdMajVHZEtGdjQxM3VPVHIxYzdH?=
 =?utf-8?B?bEpvZ21ua0RLK01xTW5OejJISWhXcVRKVDg1dlQ1M3VwajBXUzhGQnJGSERH?=
 =?utf-8?B?Zm9xZUxNNTFkb3lVWmd6NGoweHhvNWIrbUlDVWpaTkNLYU5pTnFkK1ZFNUIy?=
 =?utf-8?B?T210cWF6TzVFSEsxWU8zS09wZFlBL2Y4M1YxU01lMFZqYXFubnhhanQxMFBQ?=
 =?utf-8?B?ckNHSWdkWmR4MnZoZzRFYkxlUmlESUFLakxicW9WcTNDaUsxOHNhQUJ5aVNP?=
 =?utf-8?B?dFBMQW9uWE0rck1uK3JFZUJJYldhTlE0MEFJeFlrSGlONUg1b0VTdnloRlpz?=
 =?utf-8?B?N1FpamwyTUwvNmZ0SWI5cldKR0U5Ty9hMGR1ZTZjQWZkSllBOERPOWZvNmFx?=
 =?utf-8?B?S0ZLRUtLSi8xdnZBR2EybVh0WGdWUkh4MGJqNzNWVittUENTUityUUNhcUhq?=
 =?utf-8?Q?8srFvQF+b2bdtKtyIJyirGUY8?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4c9ad3-57f6-4ad3-16af-08dbdfd69fee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR15MB5565.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:15:10.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcXlJFLP7SgimrUAiu1Vpy6VmM0mhoyfvFxLwueSTWRPLRFRWRDtukBJWpAYreSG3K0WddH2yAc5zLJzJDxXiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5924
X-Proofpoint-GUID: by5vkXkew8ndaCoEvDKeR0FrHAhB8TbT
X-Proofpoint-ORIG-GUID: by5vkXkew8ndaCoEvDKeR0FrHAhB8TbT
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02



On 11/7/23 4:03 PM, Andrii Nakryiko wrote:
> >=20
> On Tue, Nov 7, 2023 at 1:01=E2=80=AFPM Jordan Rome <jordalgo@meta.com> wr=
ote:
>>
>>
>>
>> On 11/6/23 5:45 PM, Andrii Nakryiko wrote:
>>>>
>>> On Mon, Nov 6, 2023 at 2:15=E2=80=AFPM Jordan Rome <jordalgo@meta.com> =
wrote:
>>>>
>>>> Currently `get_perf_callchain` only supports user stack walking for
>>>> the current task. Passing the correct *crosstask* param will return
>>>> -EFAULT if the task passed to `__bpf_get_stack` isn't the current
>>>> one instead of a single incorrect frame/address.
>>>>
>>>> This issue was found using `bpf_get_task_stack` inside a BPF
>>>> iterator ("iter/task"), which iterates over all tasks.
>>>> `bpf_get_task_stack` works fine for fetching kernel stacks
>>>> but because `get_perf_callchain` relies on the caller to know
>>>> if the requested *task* is the current one (via *crosstask*)
>>>> it wasn't returning an error.
>>>>
>>>> It might be possible to get user stacks for all tasks utilizing
>>>> something like `access_process_vm` but that requires the bpf
>>>> program calling `bpf_get_task_stack` to be sleepable and would
>>>> therefore be a breaking change.
>>>>
>>>> Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
>>>> Signed-off-by: Jordan Rome <jordalgo@meta.com>
>>>> ---
>>>>    include/uapi/linux/bpf.h                                | 3 +++
>>>>    kernel/bpf/stackmap.c                                   | 3 ++-
>>>>    tools/include/uapi/linux/bpf.h                          | 3 +++
>>>>    tools/testing/selftests/bpf/prog_tests/bpf_iter.c       | 3 +++
>>>>    tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c | 5 +++++
>>>>    5 files changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index 0f6cdf52b1da..da2871145274 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -4517,6 +4517,8 @@ union bpf_attr {
>>>>     * long bpf_get_task_stack(struct task_struct *task, void *buf, u32=
 size, u64 flags)
>>>>     *     Description
>>>>     *             Return a user or a kernel stack in bpf program provi=
ded buffer.
>>>> + *             Note: the user stack will only be populated if the *ta=
sk* is
>>>> + *             the current task; all other tasks will return -EFAULT.
>>>
>>> I thought that you were not getting an error even for a non-current
>>> task with BPF_F_USER_STACK? Shouldn't we make sure to return error
>>> (-ENOTSUP?) for such cases? Taking a quick look at
>>> get_perf_callchain(), it doesn't seem to return NULL in such cases.
>>
>> You're right. `get_perf_callchain` does not return -EFAULT. I misread.
>> This change will make `__bpf_get_stack` return 0 instead of 1 frame.
>> We could return `-ENOTSUP` but then we're adding additional crosstask
>> checking in `__bpf_get_stack` instead of just passing the correct
>> `crosstask` param value to `get_perf_callchain` and letting it
>> check. If then, in the future, `get_perf_callchain` does support
>> crosstask user stack walking then `__bpf_get_stack` would still be
>> returning -ENOTSUP.
>=20
> Yes, but current behavior is worse. So we either return -ENOTSUP from
> BPF helper for conditions we now are not supported right now. Or we
> change get_perf_callchain() to return NULL, and then return just
> generic error (-EINVAL?), which is not bad, but not as meaningful as
> -ENOSUP.
>=20
> So I'd say let's add -ENOTSUP, but also return NULL from
> get_perf_callchain? For the latter change, though, please CC relevant
> perf list/folks, so that they are aware (and maybe they can suggest
> the best way to add support for this).
>=20

Ok, I'll have `__bpf_get_stack` return -ENOTSUP and submit a separate=20
patch for `get_perf_callchain` to make this cleaner. Sound good?

>>
>>>
>>>>     *             To achieve this, the helper needs *task*, which is a=
 valid
>>>>     *             pointer to **struct task_struct**. To store the stac=
ktrace, the
>>>>     *             bpf program provides *buf* with a nonnegative *size*.
>>>> @@ -4528,6 +4530,7 @@ union bpf_attr {
>>>>     *
>>>>     *             **BPF_F_USER_STACK**
>>>>     *                     Collect a user space stack instead of a kern=
el stack.
>>>> + *                     The *task* must be the current task.
>>>>     *             **BPF_F_USER_BUILD_ID**
>>>>     *                     Collect buildid+offset instead of ips for us=
er stack,
>>>>     *                     only valid if **BPF_F_USER_STACK** is also s=
pecified.
>>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>>> index d6b277482085..96641766e90c 100644
>>>> --- a/kernel/bpf/stackmap.c
>>>> +++ b/kernel/bpf/stackmap.c
>>>> @@ -388,6 +388,7 @@ static long __bpf_get_stack(struct pt_regs *regs, =
struct task_struct *task,
>>>>    {
>>>>           u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>>>>           bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
>>>> +       bool crosstask =3D task && task !=3D current;
>>>>           u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
>>>>           bool user =3D flags & BPF_F_USER_STACK;
>>>>           struct perf_callchain_entry *trace;
>>>> @@ -421,7 +422,7 @@ static long __bpf_get_stack(struct pt_regs *regs, =
struct task_struct *task,
>>>>                   trace =3D get_callchain_entry_for_task(task, max_dep=
th);
>>>>           else
>>>>                   trace =3D get_perf_callchain(regs, 0, kernel, user, =
max_depth,
>>>> -                                          false, false);
>>>> +                                          crosstask, false);
>>>>           if (unlikely(!trace))
>>>>                   goto err_fault;
>>>>
>>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux=
/bpf.h
>>>> index 0f6cdf52b1da..da2871145274 100644
>>>> --- a/tools/include/uapi/linux/bpf.h
>>>> +++ b/tools/include/uapi/linux/bpf.h
>>>> @@ -4517,6 +4517,8 @@ union bpf_attr {
>>>>     * long bpf_get_task_stack(struct task_struct *task, void *buf, u32=
 size, u64 flags)
>>>>     *     Description
>>>>     *             Return a user or a kernel stack in bpf program provi=
ded buffer.
>>>> + *             Note: the user stack will only be populated if the *ta=
sk* is
>>>> + *             the current task; all other tasks will return -EFAULT.
>>>>     *             To achieve this, the helper needs *task*, which is a=
 valid
>>>>     *             pointer to **struct task_struct**. To store the stac=
ktrace, the
>>>>     *             bpf program provides *buf* with a nonnegative *size*.
>>>> @@ -4528,6 +4530,7 @@ union bpf_attr {
>>>>     *
>>>>     *             **BPF_F_USER_STACK**
>>>>     *                     Collect a user space stack instead of a kern=
el stack.
>>>> + *                     The *task* must be the current task.
>>>>     *             **BPF_F_USER_BUILD_ID**
>>>>     *                     Collect buildid+offset instead of ips for us=
er stack,
>>>>     *                     only valid if **BPF_F_USER_STACK** is also s=
pecified.
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_iter.c
>>>> index 4e02093c2cbe..757635145510 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
>>>> @@ -332,6 +332,9 @@ static void test_task_stack(void)
>>>>           do_dummy_read(skel->progs.dump_task_stack);
>>>>           do_dummy_read(skel->progs.get_task_user_stacks);
>>>>
>>>> +       ASSERT_EQ(skel->bss->num_user_stacks, 1,
>>>> +                 "num_user_stacks");
>>>> +
>>>
>>> please split selftests into a separate patch
>>>
>>
>> Will do.
>>
>>>>           bpf_iter_task_stack__destroy(skel);
>>>>    }
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b=
/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
>>>> index f2b8167b72a8..442f4ca39fd7 100644
>>>> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
>>>> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
>>>> @@ -35,6 +35,8 @@ int dump_task_stack(struct bpf_iter__task *ctx)
>>>>           return 0;
>>>>    }
>>>>
>>>> +int num_user_stacks =3D 0;
>>>> +
>>>>    SEC("iter/task")
>>>>    int get_task_user_stacks(struct bpf_iter__task *ctx)
>>>>    {
>>>> @@ -51,6 +53,9 @@ int get_task_user_stacks(struct bpf_iter__task *ctx)
>>>>           if (res <=3D 0)
>>>>                   return 0;
>>>>
>>>> +       /* Only one task, the current one, should succeed */
>>>> +       ++num_user_stacks;
>>>> +
>>>>           buf_sz +=3D res;
>>>>
>>>>           /* If the verifier doesn't refine bpf_get_task_stack res, an=
d instead
>>>> --
>>>> 2.39.3
>>>>

