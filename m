Return-Path: <bpf+bounces-1180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924AC70FDF9
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 20:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FA41C20E25
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 18:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370481992C;
	Wed, 24 May 2023 18:45:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9BC13A
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 18:45:57 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334EEFC;
	Wed, 24 May 2023 11:45:56 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHFv8n024882;
	Wed, 24 May 2023 11:45:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=OwKabPI/qbsY2au9QNofyNdNfZC+++mL1WhYgrqgMaY=;
 b=LyxlKMP6phdGbdFcoEd1MHBAhQvbD5CYnUlZlPLX1ao23rL2pTul0c4bts14xwOVmDLO
 93/Z/IKJ8i//TWyJkAciDNv7BAHxNtneq0yYFwXC3KqPzu5T97HLkrq7mgzo4w6a8GSH
 QSwfioAvjMLfzcDZpMNBz7myESZJ2aPnNOOodLbZEV7vpTWBvMJ+7oxi3KQjasujVBIr
 PSwNzDKNN0tAbhwakFOoLian32dluk6spP8tNfqclp5lN8fM7rmAV+wbPW2sHnckseua
 Thd9SjmxKDJ+pra1HwhzwSExGjJyCHv0XCN96hZD6UwuLjaMF4cHck8AJ+CnezWnvibp rg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qsctfw0df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 May 2023 11:45:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCDPUVsT5mrBU/TmU/PLY/0bR6TvyWjozFmIQQ9+3MgV06H0NRpXESWJuYNLfFvTPDIFpK4wXypxrhiTyxuZ20YbSpGpezjxWsLcW13k+q3awEmbpiJUwxs6czTyQr76RmJSrFyxF0gpXnD5Hfb84Q5pQU6lGazyTso1ZCy9jZzpTPheoBpWFiP0VmWTmpjcMmbJBZU7dzNmQnaotBDKAcF4D57ZkJ9khxAxIPKpQXoTgcnoojMZP4ujvSQRd7e50wxI5RFB63nIHBCHeI7EZmwBCd5epP3lfAjQF13kvqjJX4w+YG/Rjia+VxKWjkBqgmdZIcWrBAexilBzLj9gRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwKabPI/qbsY2au9QNofyNdNfZC+++mL1WhYgrqgMaY=;
 b=eF7qqw8b9URI6wI0lcBn65bnZoi5y9f8GTx6gst3gJ8olYhWyqyHKt2nSNTG1CvQxsIWZTGG/LsD1uGevLOwWnFYJde4wYkH3DgW8Q6isWx5VMDjXPl+VUXIwv1gOFs26Rs09HqMTX/dkaHO2vYFJbepMFWR8C+sUKdEm+avSvhm+AwO7j4+7toGya0jONYaVSwk+cVeBEi1Q9KbVQDxcTou4sUKkrxzPMHAJTVN/hlV70dWQbFju5blTXq6m9F1ebFlnA2u7/eW6aYTkjiCnQ4KMQQadr3Wpca9eQiqn24Ks7X5MsBU9X/vInrsH1bHYfnNUiXReriFLMeBcn4tZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5713.namprd15.prod.outlook.com (2603:10b6:510:279::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 18:45:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 18:45:26 +0000
Message-ID: <186025b3-cea2-f07c-d2b9-8eadff6e0f4b@meta.com>
Date: Wed, 24 May 2023 11:45:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] [v2] bpf: fix bpf_probe_read_kernel prototype
 mismatch
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Peter Zijlstra
 <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230523194930.2116181-1-arnd@kernel.org>
 <20230523194930.2116181-2-arnd@kernel.org>
 <3c029fae-cb42-5a75-2858-7b8fc56a8769@meta.com>
 <a63a344c-e64e-4f2a-9082-f970ae9f963a@app.fastmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <a63a344c-e64e-4f2a-9082-f970ae9f963a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 6976d14c-8947-4f2b-cd94-08db5c8709f8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vlc6W+kCiDJMQ7z3ofSnHTYklv2k06h6zR2nwq6QLisvyGj/4J9KhtuSIKQAlmMdHXUXgsM502pOQmBlYAmhgAgZnLMyDJDtxpguJa3h0ZUEhyvXhsg+tBEE+nqn31PT6MGEDP1eV6ogmpL+RH+afrrgA1/6ucq/1arE2BxuI4HgGQ6azy9v0EQUEFkPVSJs+YSLZ5EOF9rB3kQoYNbwnAapdgM3FKHQrPHlRB9axCmbJLuhrvpS9TeCJeSD/xgywT7nRjFnjfMHNJ198UHH+QMLtRY8y4WgTbUTu6K3KKxxG+EHPIuw3p6/SH/h/BwpAOYU6HRiLeMWkc0sMgnCvmWjylvxZV7KsxJTROrAcDYOdeSbtG0LOE8uxDuLb2u2CHCpx6T+axpCM/WPyf66rzTuXMJJKtF7X8g+ymaMdTodPmUv6lO3puuRa4pi5TaF7y9VlYLXcJ3WbD7E7OwoRuv1Yhss1ASrTaUYOsem2LZPplzXGPzPuQxq+yCcNT07L5wgOnklZe2mjPrjNT9YkZw+Hc8YI7SpM8XFJKgBW/dd6Vwc6VwmvVw91onJG6pkl1bTXgcnIkbDFPLFNdtIJWkZiufZq+pUOpar0swiVireA8wFZ8DkStn1WKC5bOcLm2qOeH7IpGmsy/M8Tz54Ww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(8936002)(8676002)(7416002)(5660300002)(83380400001)(186003)(6512007)(53546011)(6506007)(31696002)(2616005)(86362001)(38100700002)(66946007)(478600001)(6486002)(36756003)(66476007)(4326008)(66556008)(110136005)(6666004)(54906003)(316002)(41300700001)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UmNPM3U4dklsT3dIeDJrOXplSGwzd1dYOGxER2V4UUNON1gyZnhrYnZTMVZL?=
 =?utf-8?B?MWF2bk1TMWZ5YXdVNzdrNW16ckJ5aytudllJSFhuU3BsTTZCTk9kaElXSGdQ?=
 =?utf-8?B?VVVwU3Z2UFF3K0RYWmRwbUt1dXJVb1VQU29ScTJLOVkxVFNoOVI0YVFjK3A3?=
 =?utf-8?B?YlJzV3gzTkZDamZRc2k5dTVlNDMzQUN1MGZXSzRBZ0c4KzdVTWNmTTE2Qng4?=
 =?utf-8?B?NEFLWW5WbkhvUDcwdHJSS002ZFlOV084SC8zNm9rOFEra09EbXViNnZqdStX?=
 =?utf-8?B?c0U0d1hweExKUkJDN0tYQ1dhSmVGa2w1bU1vSnRIRThkN1J5S0NRRzUyVkh6?=
 =?utf-8?B?NmQ4cERpOG5TNTdpNC8wSVVKUjhNOWcwSE9yMWVmdGpRNXlPQS9nSFNtUGVP?=
 =?utf-8?B?aXVSOXU5Yk5OY3ZBTDdERjNOWnJoSG8vd0tSRkNvUWo5N2hYLzZySjZSZk5T?=
 =?utf-8?B?bWZ4LzJtRVl2cUNwNVV0NFdrcWttL1hzVklFaTFoK0dzaXdhQVc1YXJsRGlV?=
 =?utf-8?B?OWV4WHgxWkpra3ZmZTdWdE1QbXdhekxuckxaQlZnZ3lBUUg3YTJQMlJCL0xy?=
 =?utf-8?B?OHROSWUyU1hJTytFTmk5UEJVMm92NmlkSDlEakNnMkdROS9XTkExNXcwdGxl?=
 =?utf-8?B?WXNMSXZHZlJkbWw3MzdwVWdKSVM1MmxMckNUemhMWlRHNEhjNEJibnN4bEJT?=
 =?utf-8?B?WnFVZ29LbTN4T1hNdU9vbWRqNTluelNUeWw1dmI5a2hOU2twSXhIYVE1Q0pa?=
 =?utf-8?B?NjVLMG05NVZtSjhCcUNDK2lHK0hnNE9Kci9ySmhkQm5kcUxYMGw5OHoyVDJY?=
 =?utf-8?B?MFNKenRpS28wcy9MMVZTMENvRWJBelZCek1kaDUxL3RsaTlTZGFacXNvVkQ3?=
 =?utf-8?B?bENWWUZIRmFLdmt1TkZDMk45ZmlDNDBFWkdnb1RhdC9NWmthbDJ5UGE0Y2o0?=
 =?utf-8?B?b3gvVVMycHFwblR4RUNOd3hWZjdXTlhuYWlMWk9zSE5YNDZHS2V5MmlqR3Uy?=
 =?utf-8?B?dWdJT0ZFaHNtWWNoZ3AxRjRzcUdsSFpoYUZyREUxUmhtQlZ5Q1FBUVlaWDR6?=
 =?utf-8?B?VHVHbjRqemcrOTgxQUk5STYxeUdXaERQR0FiMVlCeFRkNnJleWlzRDR2bTJI?=
 =?utf-8?B?U2ZhZDNYT0VCQm5NVVBFMUx5MzdCRUk3UkUxakZmQUYrMFpETSs2SGsyZjZa?=
 =?utf-8?B?Sk9oenhUWlp2Vm8zZGR4aWNGOEdCVkxtUUdiWjJtUEw4M2xIS2pCVnVSNHVi?=
 =?utf-8?B?V2xMN05INEJEZzFNK0grRitCMlBiVEJpUFRiYlU3T3N6UVI3VzBiWVdZdFFy?=
 =?utf-8?B?RTM3WW8xQVUzZHByRTMxZG5UeW0rYWJPeVNSajBqQ1hCRWJ5aDVxTVJKaklm?=
 =?utf-8?B?U1ZNMzE1OUZMcUlSL0hvUi8vRk1Oa0hrMlY0dmR5eE9Xekcxd2VBTjZsUFVM?=
 =?utf-8?B?NmpncUJaeE9wbEorUnZhbUxxcUZFQWpXQlhxZGVodXBhY3I4TmZnZXRJYml0?=
 =?utf-8?B?VlBNMDZwV2hBQ2VCTU1ueVdlRm53WUpIV0R2dlVBL3VpMy94N0E2Sys1ek9W?=
 =?utf-8?B?QzFBSEtuS3hZa0lwMmRaQXZ2OFV1c2h2UW0wMmluQkpTL1BQTTJkdkdhZnNJ?=
 =?utf-8?B?QVBkQlBiOHJ3eHF2WjQ3Y2xKR2w5NTlqUGpvRlgwQld2ZEZKUUMySEthOVl2?=
 =?utf-8?B?Myt5WlVGa2tGZkRwMGV1VVdWRWgzd1RlakozcitMeEh1RFAzempSOW9QY0c5?=
 =?utf-8?B?Q3p4cmFVd2NDVEx4Q21KZi9XRXllcXlac2gzZ3QyTGRYMUVoRjRoQnllVmUv?=
 =?utf-8?B?TjlVU0gvV25sTXB6TnhQa050dXJSd09IVGd5dTZJd0J0MlM2ampHREN5Y21s?=
 =?utf-8?B?blROTituYWZPUDFoYWxmQTQ1QXhKVEVVU2FQaDJENzhuekFHTVZqOFNKcmNN?=
 =?utf-8?B?T0Y3Ti9RNlFveUM3TjVzZ0E5TU9ObnBrWk5PWVFlMzhEcVh2RGJwZXo2ZzBI?=
 =?utf-8?B?RGx3UnlGSlJGeGlZb1RMa3c5SHJIdFFLbVl2K0dBSlBTN2p2YjY5OXV1TXlk?=
 =?utf-8?B?VjN6bDQ0bnBndEhud0J1eDB2aWxBaG5SbWZ4K2FhSHVYKy85Q2ROa2ZxV0Zw?=
 =?utf-8?B?MndJeFdaWmQwYWhVUmduWHB2UzVWS1BzWTJHekhKTHpBZnRwVGZkSHNleXRS?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6976d14c-8947-4f2b-cd94-08db5c8709f8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 18:45:26.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 054BFSUmRrYzGrvgN/3ik4gR33aKtzI3Gw8yr5R11eckge34xwOI8NhCyFxsfE9e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5713
X-Proofpoint-ORIG-GUID: wKl5gf1YMuhcYdRQJcKNdzU2iqI7MV-J
X-Proofpoint-GUID: wKl5gf1YMuhcYdRQJcKNdzU2iqI7MV-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_13,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/24/23 6:28 AM, Arnd Bergmann wrote:
> On Wed, May 24, 2023, at 05:12, Yonghong Song wrote:
>> On 5/23/23 12:43 PM, Arnd Bergmann wrote:
> 
>>> Aside from the warning, this addresses a bug on 32-bit architectures
>>> from incorrect argument passing with the mismatched prototype.
>>
>> Could you explain what is this '32-bit architectures ... incorrect
>> argument passing' thing?
> 
> I've expanded that paragraph now:
> 
> | Aside from the warning, this addresses a bug on 32-bit architectures
> | from incorrect argument passing with the mismatched prototype:
> | BPF_CALL_x() functions use 64-bit arguments that are passed in
> | pairs of register or on the stack on 32-bit architectures, while the
> | normal function uses one register per argument.
> 
> Let me know if you think I should put more details in there.

Please mention the function you try to address for the bug on
32-bit architecture is:

u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void 
*unsafe_ptr)

which will be incompatible with
BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
            const void *, unsafe_ptr)
in bpf_trace.c.

So you fixed this bug by using internal function 
bpf_probe_read_kernel_common() instead.

Thanks.

> 
>>> @@ -1635,11 +1636,13 @@ bool bpf_opcode_in_insntable(u8 code)
>>>    }
>>>    
>>>    #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>>> -u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
>>> +#ifndef CONFIG_BPF_EVENTS
>>> +int bpf_probe_read_kernel_common(void * dst, u32 size, const void *unsafe_ptr)
>>
>> void * dst => void *dst
>>
> 
> Fixed now.
> 
> Thanks,
> 
>       Arnd

