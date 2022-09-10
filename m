Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54265B47F4
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIJSoG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIJSoF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 14:44:05 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F33CBCB
        for <bpf@vger.kernel.org>; Sat, 10 Sep 2022 11:44:04 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28AEuQRM022290;
        Sat, 10 Sep 2022 11:43:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=q6T0X7yhVD4+LqeNWRdu8tJ0avD8EomiYSJkmGK7bso=;
 b=ZK7mM42Efh7kXsP2VitE8IuElL8bU5b6sQLAdzOrIoW7vXY2jeOvNUMYJEhMmXvuGtmr
 G2i+rll7bq1wMgEVw7yzeJQu1YiuAkr+up+GURY2hHFdjnOPLej0I/i8aBJrD+VGE1iy
 6r4ONvxc+1SsY+7ORtTSBvibw45BSmbeiGA= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jgrb19fhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 11:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqknTcsu41t95u3ODGNWDf0GWy8E9nL4YVvCrY4uvER6AiqxYh6+bI+SQSGVCjBi1fYI0LEoXMrNyHXBNG1qUgXNM3evuuQrzparh+nKQK//PSdFzdNd0/8G5oTueN6voFZa1ajFFCFpxOtnyo0PNFZW3jkE2HdfM78wgLXqnDGH6/ZwA/ngTyGyfTg2b7e2HQnnWGhd+fLWgxqnxC5m3Zp6WeFYrIqDdxhRf3EQNT2TCIVrY0tMZ8XTuI0kQO0wPUh3EWcJtg2OELFwW/syvK6bkBckY4uSVmoHtBDNsWZ/OPosrqd+eAS0xHujw8Oa3npq1OBiMsUwertZrszNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6T0X7yhVD4+LqeNWRdu8tJ0avD8EomiYSJkmGK7bso=;
 b=kquoLlHVEy7WsVxIITnXbGAIgaN3gz5eoTKrd8uZomE8PiRq1NylRqxr3LTHy2VB3JxXzjqkI5Uu3hPutnRp+t+0f3kEFdWOB+XkjajleG5gOjrqybPMU9mcXshhdWb7QMHUSquCwEO6Y252RZlhCvlET4rvSXss0yLfwoYAR+lgob80BWkzZ7QvOeZZJRjcLnYeC7BPcl/J63uJwrS9TPl1AI4q75b4Ovt2pNZTyENm8NAh/KLnvztWqfi5nSLDD6TnuV9g34cEewCLtKC8PiUBd709zHvKLW1u4dqMUv3Lnd+yaz1cr/M0ANZqmXkk3o5xDhfDxyIDAoNwfLtGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5365.namprd15.prod.outlook.com (2603:10b6:510:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Sat, 10 Sep
 2022 18:43:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.022; Sat, 10 Sep 2022
 18:43:46 +0000
Message-ID: <ae177dde-af36-351f-fa85-6e2d34644956@fb.com>
Date:   Sat, 10 Sep 2022 11:43:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v10 1/5] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220831181039.2680134-1-kuifeng@fb.com>
 <20220831181039.2680134-2-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220831181039.2680134-2-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0239.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5135c1-9440-4080-afae-08da935c649a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gq82laKhyFmtHVGxyZrAK/S03x3yYQd77gOsTJ+yLutXkG/RMT7jECxHCMTRuKtqwxDajZoKHQUliPyVWA2fGNDMnUSp2pUQEco0BdZ23Y+2HwYvQ3SXet1DNYABNuybjFgpW31BijsJZHujYM57IJlhKw5i4giaXZd+lRqU4Exq/mpYFkgPUVLTCodw0fPP02Qocpyvhte3/MS0jzPm2w6Iqq/sUeTonc9PL6zGZ2P/hRSuTyX4C/YG2rs1BbRv0WBhdvYE4q89Wk0FlsLUx4tUy0KPw6QD4q6LEIfvu+W6+EYpyZR5ol1ZYK6h4KSpMS2aol2g8qqp04JvK2uyw+EqqmCcy9yEjP7eaM0VJHSXy4O4JUYlgph32WJ9f7eBbiJYivvO10TCzijnb9e2pg/qp3QlChDB0a8t8k6oL6YtTTkJDP+rBb56iRukp0YJ17HdJke5fbudKcsST74hbAkAjQl2MTq42fCUIMJbNEWGjilovG9y6YVtXLHpRaQBNHvkGYOteRbeBpUxUy8tta9OO7cbfrEi9tFrSCAmfbrJeEFTee9/bX1ZUOU0xQeUNHqCwHRlTwM0h+FTa0+jblhw7hJdz/cd84yzawP/tBAki+XfWEUAtzDMtguABfwUcccrCG42EAtCkwUcTgRNgEtMwvz1ztt3eE5SMZVTf+Xdf3XFPuXDKk3sk2QVT4lyylyh9Rs7/6k307twW0xm9S4NbcGS1pCv3zySA5YSOeypqMCjxLD/V98mZXx6AjhY0jbAtfkUDAM72TcI1CSjqGWIPoAYfD4g/pqUdEc8nmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(6512007)(38100700002)(5660300002)(31696002)(66556008)(86362001)(8676002)(66946007)(66476007)(6636002)(6506007)(6486002)(316002)(2616005)(6666004)(36756003)(8936002)(2906002)(186003)(31686004)(478600001)(83380400001)(53546011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FBOHB5akQxckJDZnNWbjh0TDhSS3Y4VzdjS2h3VHNTblZpekdQME1XcHpK?=
 =?utf-8?B?aGpIeXd3VkF1bmFpTngrWHZhcjUzZUdWVUpOWDh4Mm5vNE5paDhnV2VxM2Jk?=
 =?utf-8?B?NGdYRDdSNFI2VGVjd2pEd1dzaUFSS3ZPUE05VTQ2WTk1YUJub3lVVXBNQkFT?=
 =?utf-8?B?S1J6NVNPWUk5U3U1YXE2RTJGWnU0bmM2RUtOZFdsRURIRUl1Z1M5dTVBSmtP?=
 =?utf-8?B?bThaVGdNTytDai85UFVpNEdKSlhNVTljODc3ZGJLM2xkemhkcUpXWkNPdlNN?=
 =?utf-8?B?eC91OVZxUlY3anZDUENJTVRIcTZlZ2FtZG9WTmZXNDNBS0I1OUdBeWtWUHgr?=
 =?utf-8?B?M2lBcWVzVHBaQVJwNGl0aDRCUTYxYlBRKzV3L2YwcGY0dm81V3VwTEsrQm9U?=
 =?utf-8?B?UlIvVzFkS05sM3lKR0xCMzNHQmIzVVhlOXp3eWE1cXdOQzgyM3N3R1h1bXU2?=
 =?utf-8?B?bmhwaEs3QzEyTy9vVm5NbXJ4cU5LWis0ZnhDN1ZxMHA0TXV0cW53dXJEemV2?=
 =?utf-8?B?OTRiNXNwNlp6OXg2bWw3akYrR1EzYmJBT3pFY1podnBZaDg1RnFuVHhDK2p0?=
 =?utf-8?B?VElKdkNEei83akpzYm90ekM5bGVvckZBVmIzUnkxUmdITWQxNTNaY1YzS1la?=
 =?utf-8?B?eS9GN284emIrcHJnVTdQeUJ6dE9rQ0tkSHc4M0I1THJ3UW9pZTFOZk1sRnVT?=
 =?utf-8?B?ZzZwQWpzaUpkL2dEMUR3RUc5bytSdnBGb1Nnd2NqS2NCd0R5S3dlY0c4VnV6?=
 =?utf-8?B?VHdTNkFMUHg1VklwMmYwdU1UZUJzVlFsUWxUUU5ESkg5azljVGlnT2E4VXVI?=
 =?utf-8?B?NS9DTmQvYkRUYlNRRnZzajMxT1VwakNFeExtSWV5Znh3RExVeEdtTXYrcXgx?=
 =?utf-8?B?a3NiY2VDb21abGIvakt0MllUZEFlOFFWYWlrcTlwZjNzVHBJWXlYQU9Pelpy?=
 =?utf-8?B?ajBrclRkOFlSemJxOGJVVlBZcFBMV0JXand5WkZjdFZyYWpIanlLTHdwenQy?=
 =?utf-8?B?ZDJwR0VydHRDVVRSNGU5a3plZ1dFWWM4dWhyRFByREt3bE10MFRzbFhGNFlt?=
 =?utf-8?B?UnhueHlSSEI0ZkR3Q1V6MndoMi9iS3crVlF5UHUvSXRmdzNleWc2ZnlvQkJD?=
 =?utf-8?B?WGpqVmxiYzE5TjVrT3RjeW5HV1FNcUQvYnFyY2VEWWo1NGQwVDQxN3h3ZDJm?=
 =?utf-8?B?YjROM1ZXa1lGN2tIZVRlN3d5MHBYdXk0YUVXVGFjSXU4UDlRaFliWURWME9v?=
 =?utf-8?B?NWs2eVZGcWtERG4yaUZ3VnB4WURLMENLOXhsY3RPMUFMNDZjYlZpK1hJTkZI?=
 =?utf-8?B?Nk0vUHNDcldTY0hxOTc0SHFmN2svVWRyWm16cXM5Q090cnVCLzIvTFlXcXl0?=
 =?utf-8?B?TzhWNWNDTzlFdjlzZktTdU1kY0w0dm0rREt4QmRCeGhZT3pJSnBPQ1p4TDU5?=
 =?utf-8?B?YStnbVQrb2VCc2c5bU5MeEFPODlBTjMvM3p1eEpFRE1hWnBvWWRzclhzdWFv?=
 =?utf-8?B?RFY2WWgxQXVUWmZJTnRnZ2RvQk1Kc21rTGM0MUhaUnY2NnBlS2Urdzk3UjBt?=
 =?utf-8?B?RHJrQjBPSUJRRlNheVExSDc1YjAyczBIYW9HUnRRVEg0Q2dNWTNHMmZtYjlz?=
 =?utf-8?B?UkJxL2VnMXFSRXJXR09hNkt3OTgvZWt4Tk9FRENQRVNiVXRUclp0cER1QWJM?=
 =?utf-8?B?R0xOT05GLzJQaWdtUm9saHl6ZWF6Y0t0SjRPb0xnaDVTdzJEM0pCVG0wVHNN?=
 =?utf-8?B?eWR2OWorV3B3NGRoWmFlazY2VUsxTkpFTWxFSXJLa2VwTDBwd2xYb0xvYTFq?=
 =?utf-8?B?RUl5TmJOdzg2cEhyakp6UHJiR3JlSzhhN3FUTXRNTnpkZjREayt6QjBENW5I?=
 =?utf-8?B?dy9kTGZHY2Y3QmEvVkdzWHJtRDVMdGMyZ2Y5UXVSdlhvWUNXdnVBNkpyMUZN?=
 =?utf-8?B?OHd5dFozVDFOb2dpVUxabzZTWnNmQVNjNHJuWmp2SzVoYlR4bGJXNVBFZGlx?=
 =?utf-8?B?aCt6Rm01NnZZYTd0YTdxK1crdkxXQVVMeEw5QTBZaG0vRFI1NEZ2eHdoZ0Y0?=
 =?utf-8?B?em42SzRsc1cvazVObEVsRUxqZCtXeGJPMWhqSnBNQnpjZlBzT3pGK2NralAz?=
 =?utf-8?Q?uB655q7hMmjbci2K1mBr5+7ZF?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5135c1-9440-4080-afae-08da935c649a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 18:43:46.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI6SsSz4QzFZW8TfocW1xY0/VC+ZpVE3EdiB5WJEzJzNZL1D6RJHkQniqUz0bXmc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5365
X-Proofpoint-ORIG-GUID: hZoOsyX4VMa7COJ-qQflD6nzA2pFOl5L
X-Proofpoint-GUID: hZoOsyX4VMa7COJ-qQflD6nzA2pFOl5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_08,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/31/22 11:10 AM, Kui-Feng Lee wrote:
> Allow creating an iterator that loops through resources of one
> thread/process.
> 
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested
> in only the resources of a specific task or process.  Passing the
> additional parameters, people can now create an iterator to go
> through all resources or only the resources of a task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>   include/linux/bpf.h            |  25 +++++
>   include/uapi/linux/bpf.h       |   6 ++
>   kernel/bpf/task_iter.c         | 187 +++++++++++++++++++++++++++++----
>   tools/include/uapi/linux/bpf.h |   6 ++
>   4 files changed, 202 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9c1674973e03..31ac2c1181f5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1730,6 +1730,27 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
>   	extern int bpf_iter_ ## target(args);			\
>   	int __init bpf_iter_ ## target(args) { return 0; }
>   
> +/*
> + * The task type of iterators.
> + *
> + * For BPF task iterators, they can be parameterized with various
> + * parameters to visit only some of tasks.
> + *
> + * BPF_TASK_ITER_ALL (default)
> + *	Iterate over resources of every task.
> + *
> + * BPF_TASK_ITER_TID
> + *	Iterate over resources of a task/tid.
> + *
> + * BPF_TASK_ITER_TGID
> + *	Iterate over resources of every task of a process / task group.
> + */
> +enum bpf_iter_task_type {
> +	BPF_TASK_ITER_ALL = 0,
> +	BPF_TASK_ITER_TID,
> +	BPF_TASK_ITER_TGID,
> +};
> +
>   struct bpf_iter_aux_info {
>   	/* for map_elem iter */
>   	struct bpf_map *map;
> @@ -1739,6 +1760,10 @@ struct bpf_iter_aux_info {
>   		struct cgroup *start; /* starting cgroup */
>   		enum bpf_cgroup_iter_order order;
>   	} cgroup;
> +	struct {
> +		enum bpf_iter_task_type	type;
> +		u32 pid;
> +	} task;
>   };
>   
>   typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 962960a98835..f212a19eda06 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -110,6 +110,12 @@ union bpf_iter_link_info {
>   		__u32	cgroup_fd;
>   		__u64	cgroup_id;
>   	} cgroup;
> +	/* Parameters of task iterators. */
> +	struct {
> +		__u32	tid;
> +		__u32	pid;
> +		__u32	pid_fd;
> +	} task;
>   };
>   
>   /* BPF syscall commands, see bpf(2) man-page for more details. */
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 8c921799def4..df7bf867e28f 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -12,6 +12,9 @@
>   
>   struct bpf_iter_seq_task_common {
>   	struct pid_namespace *ns;
> +	enum bpf_iter_task_type	type;
> +	u32 pid;
> +	u32 pid_visiting;
>   };
>   
>   struct bpf_iter_seq_task_info {
> @@ -22,18 +25,110 @@ struct bpf_iter_seq_task_info {
>   	u32 tid;
>   };
>   
> -static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
> +static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_common *common,
> +						   u32 *tid,
> +						   bool skip_if_dup_files)
> +{
> +	struct task_struct *task, *next_task;
> +	struct pid *pid;
> +	u32 saved_tid;
> +
> +	if (!*tid) {
> +		/* The first time, the iterator calls this function. */
> +		pid = find_pid_ns(common->pid, common->ns);
> +		if (!pid)
> +			return NULL;
> +
> +		task = get_pid_task(pid, PIDTYPE_TGID);
> +		if (!task)
> +			return NULL;
> +
> +		*tid = common->pid;
> +		common->pid_visiting = common->pid;
> +
> +		return task;
> +	}
> +
> +	/* If the control returns to user space and comes back to the
> +	 * kernel again, *tid and common->pid_visiting should be the
> +	 * same for task_seq_start() to pick up the correct task.
> +	 */
> +	if (*tid == common->pid_visiting) {
> +		pid = find_pid_ns(common->pid_visiting, common->ns);
> +		task = get_pid_task(pid, PIDTYPE_PID);
> +
> +		return task;
> +	}
> +
> +	pid = find_pid_ns(common->pid_visiting, common->ns);
> +	if (!pid)
> +		return NULL;
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task)
> +		return NULL;
> +
> +retry:
> +	next_task = next_thread(task);

I checked the func next_tid() in fs/proc/base.c.
The code looks like,

static struct task_struct *next_tid(struct task_struct *start)
{
         struct task_struct *pos = NULL;
         rcu_read_lock();
         if (pid_alive(start)) {
                 pos = next_thread(start);
                 if (thread_group_leader(pos))
                         pos = NULL;
                 else
                         get_task_struct(pos);
         }
         rcu_read_unlock();
         put_task_struct(start);
         return pos;
}

I think we should also check pid_alive(task) here as well.
Based on comment in pid_alive(start). If pid_alive(start)
is false, it is possible that pointers inside the 'start' might
be stale and pointer dereference might cause issues.

The whole task_group_seq_get_next() is protected by rcu_read_lock().
So the task pointer should be valid for the period of
rcu_read_lock(). So we need to do something like

retry:
	if (!pid_alive(task)) {
		put_task_struct(task);
		return NULL;
	}
	next_task = next_thread(task);
	...


> +	put_task_struct(task);
> +	if (!next_task)
> +		return NULL;
> +
> +	saved_tid = *tid;
> +	*tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);
> +	if (*tid == common->pid) {
> +		/* Run out of tasks of a process.  The tasks of a
> +		 * thread_group are linked as circular linked list.
> +		 */
> +		*tid = saved_tid;
> +		return NULL;
> +	}
> +
> +	get_task_struct(next_task);
> +	common->pid_visiting = *tid;
> +
> +	if (skip_if_dup_files && task->files == task->group_leader->files) {
> +		task = next_task;
> +		goto retry;
> +	}
> +
> +	return next_task;
> +}
> +
> +static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *common,
>   					     u32 *tid,
>   					     bool skip_if_dup_files)
>   {
>   	struct task_struct *task = NULL;
>   	struct pid *pid;
>   
> +	if (common->type == BPF_TASK_ITER_TID) {
> +		if (*tid && *tid != common->pid)
> +			return NULL;
> +		rcu_read_lock();
> +		pid = find_pid_ns(common->pid, common->ns);
> +		if (pid) {
> +			task = get_pid_task(pid, PIDTYPE_TGID);
> +			*tid = common->pid;
> +		}
> +		rcu_read_unlock();
> +
> +		return task;
> +	}
> +
> +	if (common->type == BPF_TASK_ITER_TGID) {
> +		rcu_read_lock();
> +		task = task_group_seq_get_next(common, tid, skip_if_dup_files);
> +		rcu_read_unlock();
> +
> +		return task;
> +	}
> +
>   	rcu_read_lock();
>   retry:
> -	pid = find_ge_pid(*tid, ns);
> +	pid = find_ge_pid(*tid, common->ns);
>   	if (pid) {
> -		*tid = pid_nr_ns(pid, ns);
> +		*tid = pid_nr_ns(pid, common->ns);
>   		task = get_pid_task(pid, PIDTYPE_PID);
>   		if (!task) {
>   			++*tid;
> @@ -56,7 +151,7 @@ static void *task_seq_start(struct seq_file *seq, loff_t *pos)
>   	struct bpf_iter_seq_task_info *info = seq->private;
>   	struct task_struct *task;
>   
> -	task = task_seq_get_next(info->common.ns, &info->tid, false);
> +	task = task_seq_get_next(&info->common, &info->tid, false);
>   	if (!task)
>   		return NULL;
>   
> @@ -73,7 +168,7 @@ static void *task_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   	++*pos;
>   	++info->tid;
>   	put_task_struct((struct task_struct *)v);
> -	task = task_seq_get_next(info->common.ns, &info->tid, false);
> +	task = task_seq_get_next(&info->common, &info->tid, false);
>   	if (!task)
>   		return NULL;
>   
[...]
