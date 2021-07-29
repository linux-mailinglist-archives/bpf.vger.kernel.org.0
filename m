Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0D3DAA98
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhG2SAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 14:00:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24130 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhG2SAg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Jul 2021 14:00:36 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16THvk5E021242;
        Thu, 29 Jul 2021 11:00:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mFOW3doEmgvz7P0oWEuI8CE9uht+H9oFXpb7amBW2/Y=;
 b=TZCCS56hixTPaQO/IG5SNKdeHpAuEZh+LKGJDz3hvV6H+F+tfAvMElUAqklPg29Ctskl
 adnvKT1m5gO1BC4W+awyYX1TWAxIaROqE67bbx2y/Y+MQAAuf+TvjNhNCO/7Mgs1TAxb
 geLIItlfWuCivxhoFD7qExwEgjzVhMEclzE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3bu9fhfp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 11:00:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 11:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+EZ9S+YFRMV55UT3/famr6q5OX8ek9Ke3v1VTYuIGG0YOuds7Jwo01gJ+8pkBNU8Z+VxapjApLGs/8J6sX1sdPH/6yKgnuoWUmpqk3IP4a112NTpofz2Y/UjorD5LW+SoYHe1QcuGGAnNiY8bFrWVIjrbLQAWIVlTyLzkTXmpDsjYxVOqjJfZ0eMvEK6WZpp8nCu4LLFE3fWlTcqqeiwQp2JwLmyQfvlUWrqSGMG7EeS82Mosn5plW4HXAZak+Z79svPghXMZQCzFXdEz0T4WOh8f4dtj3vrYGCgQ9zXGoYh0tEx7XhCqCyz719TRgyki1YEt5MsjOtUo78GHSG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFOW3doEmgvz7P0oWEuI8CE9uht+H9oFXpb7amBW2/Y=;
 b=VHdeSw2jAU04sTOaGHdfohVaO7SFdT3BiuyyU9d4JT6ODHR4PkjCx1bAdLKazaiXRgKj8ga40cYWb53J5Wps/LOFl0R8hyAm/eKtD0cbLWReXDaYUicwPE+x6BM6Z0cgjDen8DNvhfTuPEq7oUB6udLV9VStd2tLkCNGaUFThQ8yD6Y2OV8TtG+LaxnC0iVHtkSISjUBUOezbGhclIbru/v0PMp4rFkJCIrj1XYXM8YLVnIkgVzigY+7Aop9im+j9hKxvHHO2wYDVclkWb03D+FrpHf5ft+DNjnVBnvdsN62uvM///MOFyIsTg1dELpYFr/duyHtUkv6UMknqTbjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4641.namprd15.prod.outlook.com (2603:10b6:806:19c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 18:00:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 18:00:14 +0000
Subject: Re: [PATCH v2 bpf-next 05/14] bpf: allow to specify user-provided
 context value for BPF perf links
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210726161211.925206-1-andrii@kernel.org>
 <20210726161211.925206-6-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <138b1ab0-1d9c-7288-06bd-fbe29285fc4f@fb.com>
Date:   Thu, 29 Jul 2021 11:00:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210726161211.925206-6-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::11d1] (2620:10d:c090:400::5:81b5) by SJ0PR13CA0214.namprd13.prod.outlook.com (2603:10b6:a03:2c1::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Thu, 29 Jul 2021 18:00:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ce8d264-83b5-4b56-470a-08d952bab726
X-MS-TrafficTypeDiagnostic: SA1PR15MB4641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4641BCFACAC7DCB14C947A5DD3EB9@SA1PR15MB4641.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4l8bZqXFkf3qq6humHbQglM5UP3pyz6RRehHwXlvziAqeITiSjJ0WHF3T1UZhGnheIGijzwmqGGLE3t2ZD7QQSQ9Ax/bCzIzdYlRfepAcSHx55l9AjlEp3fD0FyrXJ4zn1nWY0Ltx6twPyq9DP90kdADWCsC7UUvq/byHEAdD/UmxF36lF3458b89mhfTnkK93+P2KZxbDKOYuQVJWZRulJqEEnGKB9ZQdreo281BQw3UmVjre3gE+Nd6B2ZHz1ogVtWK/Y3Ono6IScz0TuYkkihlE8UUYQJgozv1O93UrDlWRJzC0ODvUesFrD6bz06FDnFNaDQHjf0oaG2h/pLybH0LxlZJRDsxxZKKmL8VvSniS81L/2oO+/Iqd0OoBxSneEZFthOAlMMfYFHx/V+hq6gcjOXRsFKF56pCRUlaf18Q9n2SmFXNq0/BtqrUGKjWLtS7uvyc+x1TzulHQly4l5laUXOGQoO8ObTu5pCZViB0nCoT7G8ZlRjZk/agDnVSuz8yeoPxrtbt20kqm47SX8i2lo63qbZRlP7n3r5MlSABnCSOuL9yhGYgQCYMBml+EAzMlpyTVNSlQ0w2OdNzdaPxF1LiiIKr4sVnGwrSvm721xPo/MtCAijTrZYWrs+3SgOntpezjtKof5fr3qz6mRdHz8aI8p4yDcr8xgLFmZBFQpt9COdBZoswvfJW/vYSXbRl0/Vs1DMuzD9iCg0dxV+NVDjup/i9pXkbfQlfo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(31696002)(66946007)(38100700002)(5660300002)(186003)(86362001)(31686004)(4326008)(8936002)(478600001)(8676002)(2616005)(52116002)(36756003)(6486002)(83380400001)(2906002)(66476007)(53546011)(316002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0s0SnR1dzRxb042ZktDWEtReHlkMFR2S08vd1RodCswRUhWMzJRNnhxR0E5?=
 =?utf-8?B?QmdjMDFYYkZrUjdzcFR2N2ZZc1NvRWlkdXRuZ0Y5VEVDOVNuOXVaTXp0Znls?=
 =?utf-8?B?WXNMdDVCUndla1MyOXNVaTJ1QUZQcTI5N2hqUGlXZkpTclE1eG56WTFGeVJW?=
 =?utf-8?B?ZmdhRnpMa1NJWlEvWXVoUVVGZnVydEJlWklFSHNBVno0MmpSWHgxVXhML0xw?=
 =?utf-8?B?ZkVyWUFKdDdIdkVKM1NaQndOb21XdzI1R2h2bXpVUVFwWGZJU3Y2aldnZzVY?=
 =?utf-8?B?M1M1L3diWnVoUWNYUHBPMkxWNzBIZm5veUVkRzQ1enRwcFd4NUFTZHZYWkFq?=
 =?utf-8?B?dU5obGpjc1A3aHdrdlhHWmlRZmswY21iWkJqc1Q0b05mSjlTT0lMcW1PODJH?=
 =?utf-8?B?QVBveXRyMk1ySXQyb2pIRksrU2RUOU9lRFpzZnJ0VVI5eGxHTWlYNFdDNnI3?=
 =?utf-8?B?eHFLTm5vRjBxWnNEaXZTSDh0Zk9nUEFRUGhkQnlJVXVJMXEyNUR1MlNoZ3U2?=
 =?utf-8?B?VkhpMHN2Q2VlU3pveGpRaEVETHlxdHNjZWEzV245MGtYcUk0aWF3Z3pKOWtv?=
 =?utf-8?B?MVZEMFlabFlLVHh4UEJvQW9FK3htRTRDeGprb2dSeUlkUHdaSlNBdVFJVURW?=
 =?utf-8?B?c2l4YnNYbmtLRDludE9BNGt3N0lzNGwvQmhjNzNSZmF4US90VFk3Q2RLaXBx?=
 =?utf-8?B?VDlhNUNyR0hvaVFoRDVkZmk0RTdmanovcklncEl6YmpLOE5kWnlMRzRmWVRv?=
 =?utf-8?B?WGx4THRpMmhWVVd1cW9EQXlHbVEzMlJuRW9IWXl4Z0MxVm1ZMTk5NmJYVGNm?=
 =?utf-8?B?TjNSSEs1YzVsSUUxT2gyci9pdk1pSzRYanFiZlRUYndUK2txTEFGbEZ1MWlY?=
 =?utf-8?B?c2V0SHEwQ3QvOXFWUUVmRXpXZEsrVlZERTA2L0E5MjNXRFVNNHlhTDB2SCtY?=
 =?utf-8?B?R2FURkRqeHc5a0xNUHFBZDhIY0gyZWRJYm51RG1TS05NWjFuV2l0N1d0R3R3?=
 =?utf-8?B?SkVXbGZKbGEwVlRkb2s5Q2Y0eE5GZnB2U3oyTVdBUkU3SmxXZnZDb1VJanpw?=
 =?utf-8?B?dnNwaVlJaDREVEl6WXR5Tk01NHlqaUQxSFZqUGJkM0FyaG1TbHorNjZMTUNB?=
 =?utf-8?B?TnMvcmRSNVVsU1VObFZlOGdCbm8yZzZKVXU5UDE1amdZbFc2UnFUN2JIWitj?=
 =?utf-8?B?T3Z0czBOL054VWx2UDFzTy9HTFpuNk0ybXZpUlRJWTU0MzRpNnBWeFZWR0Y5?=
 =?utf-8?B?cldyVkduN1pUWnVUNHZCaWxmVUQ1S3VhU216TUJYbkxjU0xXVHF1dzNSU21O?=
 =?utf-8?B?S2FsRVNmSlRsZzFqWC9lSVdpeEhjRFczb1ZHZjE4cVNaNzZacWNpbmNSYlBi?=
 =?utf-8?B?eFRZQnRDMUh0SnVjdkdxV2RUaGV3RkFlWDIxdk12cHJWc1pmV3FqR1ZCWm5V?=
 =?utf-8?B?Rm8yUnQ0Z0hLV0FIcEJxN1UzOUtueE9iN0c2QXVwdjRKdVZGeC9iRWEwUHFT?=
 =?utf-8?B?QUk5UC9TWkc1dW0xek9uQzVhcWpsNVc0Ly96dXY0eHl5ZC9sYnNDT0N5N2gr?=
 =?utf-8?B?T0NTN2puamU2RzBQSmpjTkxhT1FHQ0VFVEVXY1NReTVwSFlYODFMMTVCb1l6?=
 =?utf-8?B?MXdoSU53TUdJYllIQjNmNUlZRS9ZSVdHa0Y1Qk01YXE4SUdhYTJvZEIzZUVX?=
 =?utf-8?B?NWR1elI4ZVYrSHNiVE4xSWU3aGdsaytyRmpDZ0Eyd2s3N3pDRzl3WmdOTE05?=
 =?utf-8?B?UjQ1N25RU0FiTDNuWlBnbGFjMEo5WC9XZm5BUmZ2TWh4NHBWb1JXMTROMWxy?=
 =?utf-8?Q?mYAooPN2LZXUp1MIW/K5Qsl9//WJTHZ1ICVrk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce8d264-83b5-4b56-470a-08d952bab726
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 18:00:14.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbUunH275qT8cqeCAaSmmn9E48VdCXy6qQ9UyNW71B9Vql3A1fElQ7OvAmkvZq6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4641
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: d6WI9qi12AS7QENnX3_B46DROIDNn8kC
X-Proofpoint-GUID: d6WI9qi12AS7QENnX3_B46DROIDNn8kC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_14:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107290113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
> Add ability for users to specify custom u64 value when creating BPF link for
> perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).
> 
> This is useful for cases when the same BPF program is used for attaching and
> processing invocation of different tracepoints/kprobes/uprobes in a generic
> fashion, but such that each invocation is distinguished from each other (e.g.,
> BPF program can look up additional information associated with a specific
> kernel function without having to rely on function IP lookups). This enables
> new use cases to be implemented simply and efficiently that previously were
> possible only through code generation (and thus multiple instances of almost
> identical BPF program) or compilation at runtime (BCC-style) on target hosts
> (even more expensive resource-wise). For uprobes it is not even possible in
> some cases to know function IP before hand (e.g., when attaching to shared
> library without PID filtering, in which case base load address is not known
> for a library).
> 
> This is done by storing u64 user_ctx in struct bpf_prog_array_item,
> corresponding to each attached and run BPF program. Given cgroup BPF programs
> already use 2 8-byte pointers for their needs and cgroup BPF programs don't
> have (yet?) support for user_ctx, reuse that space through union of
> cgroup_storage and new user_ctx field.
> 
> Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
> This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
> program execution code, which luckily is now also split from
> BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
> giving access to this user context value from inside a BPF program. Generic
> perf_event BPF programs will access this value from perf_event itself through
> passed in BPF program context.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   drivers/media/rc/bpf-lirc.c    |  4 ++--
>   include/linux/bpf.h            | 16 +++++++++++++++-
>   include/linux/perf_event.h     |  1 +
>   include/linux/trace_events.h   |  6 +++---
>   include/uapi/linux/bpf.h       |  7 +++++++
>   kernel/bpf/core.c              | 29 ++++++++++++++++++-----------
>   kernel/bpf/syscall.c           |  2 +-
>   kernel/events/core.c           | 21 ++++++++++++++-------
>   kernel/trace/bpf_trace.c       |  8 +++++---
>   tools/include/uapi/linux/bpf.h |  7 +++++++
>   10 files changed, 73 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> index afae0afe3f81..7490494273e4 100644
> --- a/drivers/media/rc/bpf-lirc.c
> +++ b/drivers/media/rc/bpf-lirc.c
> @@ -160,7 +160,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
>   		goto unlock;
>   	}
>   
> -	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
> +	ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
>   	if (ret < 0)
>   		goto unlock;
>   
[...]
>   void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 00b1267ab4f0..bc1fd54a8f58 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1448,6 +1448,13 @@ union bpf_attr {
>   				__aligned_u64	iter_info;	/* extra bpf_iter_link_info */
>   				__u32		iter_info_len;	/* iter_info length */
>   			};
> +			struct {
> +				/* black box user-provided value passed through
> +				 * to BPF program at the execution time and
> +				 * accessible through bpf_get_user_ctx() BPF helper
> +				 */
> +				__u64		user_ctx;
> +			} perf_event;

Is it possible to fold this field into previous union?

                 union {
                         __u32           target_btf_id;  /* btf_id of 
target to attach to */
                         struct {
                                 __aligned_u64   iter_info;      /* 
extra bpf_iter_link_info */
                                 __u32           iter_info_len;  /* 
iter_info length */
                         };
                 };


>   		};
>   	} link_create;
>   
[...]
