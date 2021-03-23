Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0CF34544A
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 01:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhCWA4J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 20:56:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14960 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231308AbhCWAzv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Mar 2021 20:55:51 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12N0jFJU019016;
        Mon, 22 Mar 2021 17:55:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+fCIUbWySItWNMwIevXv1k3ECd3bLblGQq8o+MO/pgU=;
 b=nrK97HIy27eAFWAjwHht7fED9QBm4XLwXbjvcOyDve5DsgVYCd/3CNQylHYPxUegWoeE
 khEK97ElEgEJuSonEvPpaJzQKXjNZViNrpYT6RF1u37Dx8YpgnTPNmOZDYa/6H/SKbdM
 R99m2eLF2VqTC8EpunTY6UEU8Mo2AxNn6Nc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 37dcj1m3qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Mar 2021 17:55:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 17:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz/XQY/Z9UmmV9MQx+PKrW40BBDfX0B8RTSTAe5yD/ODX08pZtkmExQax2pfe/neQ7uTRb6JZ8wxOh77RpcyNfmGLN1SXW81XdhwjRb3vqhhEYV3uLqHG8h6GQugYK2GzngJZmM6oBoqwiCXxpURxtsP4gsoNweYOKzcqWOVJEMSIbQXFOFAmWS1/HMFjYYPoF6J3Xv04KaqeaqjWBlMJSRv6zpqbWuHl1ffJbxEPblJfHh6lvsm1coClhQfn3gpBoIL/s/9PSYhGtAIdtmK0VEP/W8QSWvIxfCH6AsVPDa+0h7kpDdz/z6iiJKKDhw1C5J8lmlH+tKeyNEJUjMKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fCIUbWySItWNMwIevXv1k3ECd3bLblGQq8o+MO/pgU=;
 b=ipJOkOisB63aaTQNSHYyjPMwNACROnQenjMmlCdsT0Hfft66amXcKRNjHZqwBf97BgST9JUd5vThiU8jeWTxHYVmKvUXsTQFiKUkvPENxm517P7R8ApzLDDHQVuMr8jbOCuVSEcL3qEYZtwnl3wRa5yuoZGt/ZxBdmjlROiRMPsJSPvHuMWzpDpaVBjHxGDSX93fAOqh0jEk4nPlwy25bJ8lIFBHsOTLfgzBIxzMAdhZ5vlcQbBJJpS/uQuOvq7wm/JM8hEC50d05S5inSor72isPN8dTVwgXVeSH4bK/TSAQ0WrFGp71tgo00CY9advMttwwEkTLUasvBUnTW0S0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1968.namprd15.prod.outlook.com (2603:10b6:805:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 00:55:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 00:55:35 +0000
Subject: Re: [PATCH bpf-next v3] bpf: fix NULL pointer dereference in
 bpf_get_local_storage() helper
To:     Roman Gushchin <guro@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20210320170201.698472-1-yhs@fb.com>
 <YFjkarhTFseEDn9L@carbon.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <64872f78-75f0-2187-d07a-4196dd2738b4@fb.com>
Date:   Mon, 22 Mar 2021 17:55:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <YFjkarhTFseEDn9L@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c091:480::1:fbbb]
X-ClientProxiedBy: MN2PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:208:15e::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d9::11e9] (2620:10d:c091:480::1:fbbb) by MN2PR17CA0004.namprd17.prod.outlook.com (2603:10b6:208:15e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 00:55:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac23821-1853-4309-0343-08d8ed965e0c
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1968:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB1968991CF63D742A9F8DE25AD3649@SN6PR1501MB1968.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArbzpgRDF3Mj344vGOI88IDlYZ6n5xSrWEoqJNo9Mab2fEc9RGSZuNhc/aHSU07oA0/iGnhy4N7G3R7ES6FkTjlTZ+ffjIkdxb+4wGvzVz8FQ4YVlnx1HQDTNtygsp2MWt1I6skrz9NYPKcyJ7kDCoDGk2U2a7tS4zJx8d9Sjo2rH2lIaEuKh1ZNSUnsc0nC8W1UVDEHAtnLAXZLL2+AdQFb+GZ8CuFcHWAaURf7LQpCpwmGE3iAXYsjNnz6JIkNM2+Kt4deSId+xtHPEvEueygOyyPFKZGYC7VZ5yCBFZ5daD4vxADoAvZ5LCvy9oKYfcQQElTnuDkCOIyUZUi5cnGAlb1OJiNUvArP1Zbrjm+8EA21PvHDwNmpl2mRX5rKfI//hrds0/20XSjp1tb3lxR1+uSQ9fEGWxzzZb1ouE9z970WviuugleM1rA2BoP5PBfxbLLqRM3eIkfDpQzMowcCBh+CoSx6cs6nlX/r4EcvoJX7ZxKfWnX8HaS1QLBR9qsBIwLi/mtrhphQRJiVpD/nDP4IPCkSBdnHvVCcVe6PvMrJktRPi4gPc7rgDwXnJF0dqEuUnw1tgnIU8n3M0+dkX7xbDPxuQdU0evLcxgAOnpUfX/CAnm8EvFYRJFKCr+qaW+cOVvMYov+JNVP0qBT+tsKMAap6feI+1xMuLqjRCvKO2gsLoEj1ZwlfRrxlIhTlEgRoOVPuH0PZ8xtl1Wf51zmZvkcX7QSWrz7AqbG8rDpyovuq/8Vjk9bk9rYsFnAFFXY8etiRcNDk9z8JhYT7LZ+XPN7EM3quvKkgMR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(8676002)(2616005)(86362001)(316002)(52116002)(6666004)(5660300002)(16526019)(8936002)(186003)(66476007)(6486002)(66946007)(54906003)(6862004)(38100700001)(66556008)(4326008)(31696002)(83380400001)(36756003)(31686004)(478600001)(2906002)(6636002)(53546011)(37006003)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K05OaDFmMlBVWnoyQmJjQjJhRGY2N0tlNzNKNDFWRnV0TDZjMXJRUjBLM05T?=
 =?utf-8?B?bUx2dUlIYWJkUWc5SW00cGEydjlheUN4ZDdod2x2SkNpVERaVnk0NysvY1Ja?=
 =?utf-8?B?dDg3UGZPdUg0OFI4SHVObUtCUkprV1k2bzhaVzQ2MnZXSVdnVFdFUHcyVlIy?=
 =?utf-8?B?c3NBV1NDRk90RE96NytOUkQyeGtsS0VIdmVrV3dKRkovaTVuNlNqTGZWSEY2?=
 =?utf-8?B?TmRLKzZCV3QrajZocWVUaGN6dGZWcVhyTSs3ZjR4aGU1YmdjQ0xudUx3c2ZR?=
 =?utf-8?B?UG16SUV1Sm53dzc2cE1XWGJmazdDQ2hCRk9XR0tVT0NkeEgxR05RQ3VPNU5Y?=
 =?utf-8?B?VUxzSWJtUFJaL1VTdUo1YTVWa0RCczFMSmw4WlhYYmhPRlZlZ2FTNWFMbFMw?=
 =?utf-8?B?TERmc041bnZjdC8zeFA0NlBab3Uwb0lRcWpuTEp1YUdXSm5NQ0NkaFVTb2dv?=
 =?utf-8?B?SU5xYlBQbDZtN0ZURHg4OGF5YmY2SG0zN1IrWndNaEZRSG5vOXZTUEVPajJR?=
 =?utf-8?B?L2tsS3MyVTZDWS92aHUyMGF1VUlHb3FsYVJzR2RqcGJmeVg3VGpnaVUwMUsr?=
 =?utf-8?B?bHZ4QlJySXovdUhUMDlwR0hYMXZoNWVPdDUxMEJHWm5ySU96UUR3bGNJY3lB?=
 =?utf-8?B?Vy9YYTVBSDJUVS9HVFZ3eFNZWVJZNUdrV1IzUklQNGtLejcrV3VoQVltK0dK?=
 =?utf-8?B?c1haSnE1WlkvNmU2NTRxbDg3MkdFdW5xaVU4R0pOVVNxK1VDUldPU2RPWXM1?=
 =?utf-8?B?NnY2Q0o1cHZDNWpuNmJpZ3hGQmdHVThDUDZxa1pJbmVOVjk1UXpjL3dMYnBM?=
 =?utf-8?B?VG5LZ0tuUFp3TnJkVE5WNUxPd3RsTGNpbjZYUDkvMGZZYXNVNm9TZUFMK0Ri?=
 =?utf-8?B?WVRZeXVDcEJyMW5xK2dWQ2lpTnkyNXdPajI2NGw2ckRSREpXQy9CbElZL0Zx?=
 =?utf-8?B?MVd4Tm5JdlBOSWRqYTZGZDlNZ0xEYjdzVFBxZW1zWkN1Q0ZTRGNYb2c0eTB1?=
 =?utf-8?B?TUJXOFVPNGFmQStjWXZ2T29rNUF6SmF4bldTQnR4ek92Tk0vS21SQ2dldXYx?=
 =?utf-8?B?c1JZN1J6UWR5enZYU0I1MXptTTlkYk1JbFIwM0kyTFZrMkJJMWE4cXdXeTE4?=
 =?utf-8?B?OUx4S1JrYXQ2MXRzdGZmaTBnSW9OUWhrMFJyeS9ZQzZ4emt5T0xqUUVuUHRn?=
 =?utf-8?B?ZlJpNmhaVWU2YVdTclBsRGFWN056SExPS1pIUHF5MUMreE5nMGVkT1NzU0lx?=
 =?utf-8?B?enBjTytLWVRLOXNvTTc4QzdOMXVrVHlvRnUyRU5sWlpWMmVqNmp5Y04zMXA5?=
 =?utf-8?B?Z2JDYlpiNzNnSzY0QVBpUHRqQ0FKdXNHN0JGRnZVZWdwRW5OeWcxdWFCS3c1?=
 =?utf-8?B?V3JvZWlNbW9RZTM3a1RzbmtaL0xNYzcxa3F5UEIvSzh0MjlaZDVRRWRpekxz?=
 =?utf-8?B?M3RkcE1samhhdldYMXZ5VVcxZERSS0VPZFkvaVFzSWh3TUUrckwzY1haT0hE?=
 =?utf-8?B?ZmRiaTdLdzRCQzNPeTYxWHVKWlhtRDB1WUViMEpmSmF6V1JBdUVJUzNpOGRO?=
 =?utf-8?B?aWFpOWgrRHVJM1o5VGpmV05keUV4a2FiNnRaT053S29LZTlBUzZKWi95SDhk?=
 =?utf-8?B?c2hrTFhXb3NJbC9Ia0NFVUczMXBFeDdLMU96OFpmUndjK3dGa1N2RnhOaG9V?=
 =?utf-8?B?dWM3Q1d4QVJ4ekVlWnpsdE1mdXY5OEJXbFo5NHFsRUw2ZGdDRWZxejgyUHht?=
 =?utf-8?B?YUMvUlJJSHBJWmxJajlYeXZDeFBDR0xlTksrcHNmbjBsZEJCWlh6ZEw4WWdR?=
 =?utf-8?B?dWFwRlM4YWJpNTJiNVVQQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac23821-1853-4309-0343-08d8ed965e0c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 00:55:35.3457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QoxDq+mIcKKlRVYgmBZleMBe1BvlgfFhGvc+XRkt2F4bmOkK5Ky/MkQhxyVts9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1968
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_12:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/22/21 11:39 AM, Roman Gushchin wrote:
> On Sat, Mar 20, 2021 at 10:02:01AM -0700, Yonghong Song wrote:
>> Jiri Olsa reported a bug ([1]) in kernel where cgroup local
>> storage pointer may be NULL in bpf_get_local_storage() helper.
>> There are two issues uncovered by this bug:
>>    (1). kprobe or tracepoint prog incorrectly sets cgroup local storage
>>         before prog run,
>>    (2). due to change from preempt_disable to migrate_disable,
>>         preemption is possible and percpu storage might be overwritten
>>         by other tasks.
>>
>> This issue (1) is fixed in [2]. This patch tried to address issue (2).
>> The following shows how things can go wrong:
>>    task 1:   bpf_cgroup_storage_set() for percpu local storage
>>           preemption happens
>>    task 2:   bpf_cgroup_storage_set() for percpu local storage
>>           preemption happens
>>    task 1:   run bpf program
>>
>> task 1 will effectively use the percpu local storage setting by task 2
>> which will be either NULL or incorrect ones.
>>
>> Instead of just one common local storage per cpu, this patch fixed
>> the issue by permitting 8 local storages per cpu and each local
>> storage is identified by a task_struct pointer. This way, we
>> allow at most 8 nested preemption between bpf_cgroup_storage_set()
>> and bpf_cgroup_storage_unset(). The percpu local storage slot
>> is released (calling bpf_cgroup_storage_unset()) by the same task
>> after bpf program finished running.
>> bpf_test_run() is also fixed to use the new bpf_cgroup_storage_set()
>> interface.
>>
>> The patch is tested on top of [2] with reproducer in [1].
>> Without this patch, kernel will emit error in 2-3 minutes.
>> With this patch, after one hour, still no error.
>>
>>   [1] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
>>   [2] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
>>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Roman Gushchin <guro@fb.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> It looks a bit artificial (8 storages to handle the nesting), but most likely
> it will work in the real life and the code looks correct to me.

Indeed. I picked 8 so it is large enough to cover "all" realistic cases.

> Please, feel free to add
> Acked-by: Roman Gushchin <guro@fb.com>
> and thank you for fixing it!
> 
> Btw, is it intended for a stable backport?

This patch cannbe be used for backport as is. The test_run.c in
bpf-next has a refactoring which is quite different from bpf tree.
If we want to backport to bpf/stable, we will need a different
patch. We can address this later.

> 
> Thanks!
> 
>> ---
>>   include/linux/bpf-cgroup.h | 57 ++++++++++++++++++++++++++++++++------
>>   include/linux/bpf.h        | 22 ++++++++++++---
>>   kernel/bpf/helpers.c       | 15 +++++++---
>>   kernel/bpf/local_storage.c |  5 ++--
>>   net/bpf/test_run.c         |  6 +++-
>>   5 files changed, 86 insertions(+), 19 deletions(-)
>>
[...]
