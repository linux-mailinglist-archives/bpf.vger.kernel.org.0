Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A25591CFB
	for <lists+bpf@lfdr.de>; Sun, 14 Aug 2022 00:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiHMWR3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 13 Aug 2022 18:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiHMWR2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Aug 2022 18:17:28 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381DA50705
        for <bpf@vger.kernel.org>; Sat, 13 Aug 2022 15:17:27 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27DBMOX3019858;
        Sat, 13 Aug 2022 15:17:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ovMm/4Y/FdrrpWNQxVJ+Kgl8yn+/hotpl8HI6b+WIw8=;
 b=Eg10cZF/zF4c6TjFuFS8usl6YjW5gGWtnwM2/yLtZ6T5TirKQDw00Lj/qsNlIh43MC9Z
 xId76aXwmtAvGDvHVrq2zia62gGdtLjMlcIBdtYH30S02EBtZW9oacJ3fd32IfUf81Oi
 7xFuZPSyxlIOd9+I3CEwBCX+kO2va+1N+HM= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hx9sttvvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Aug 2022 15:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1xp8uQzqXMniW/t+AjP34iBlDkOfIutaRGTKs9KffiL62xUVLS45k8E9E/JMGa2cNsOMbcZcv0MJs7K5hCnhMw7J/VIT5otIV4FZD2kfmGtBbmyC2Uni4g523RiwS+CuATX5c+o18gsBBKCA9MNIA/+qPOQsSXEfYcVMLMwsWIErKsIiDcbMmKF0JaZrACCp8LzRMTfebxZ36tmDZIdCmgRU87tbC7iosksPsda6jnlyzK6k7k03WAPPFckE3+Duajb4uztFtSHbo4N5YFw7CTxf+cOVl9kqLPR1a6T+fY3sVRlE9FAne3b71Vfpg46QoWG5O8+66GHCaEBMKBMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovMm/4Y/FdrrpWNQxVJ+Kgl8yn+/hotpl8HI6b+WIw8=;
 b=JEKj7u012Lp8aC2hxZfOVK0iQ+8rt8CLU9U8X1VYXTkGHdYVTVS1ppE0a5oCBXE9Y2MZ7RFclzqC8Fv4DxI362c8fMnDIbZuHo31QVzkS1SKSnA2MkJzkjWiyOOoOYmpTd1qX8UCG/u9fvUE7PH2gsloEHa0LBy2lMTAaqAf+fnxBB4dKzZSKdyv/CuhvV+ZnjjAhDof7/49uVZ5ij10OwlQmYbQMRE/SMCYQeigq34Bb3LaMmKHmldmj7E+ovhOJ6gOrCuvF/fpIoIZ9OTIm1RMBhpEhe5GpASlp3Cud5fZPvUwjAFklo7okad/gzdrkaWNaufR7zwbNTmPlx2Kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2746.namprd15.prod.outlook.com (2603:10b6:5:1a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sat, 13 Aug
 2022 22:17:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Sat, 13 Aug 2022
 22:17:10 +0000
Message-ID: <0f5123dc-5334-7e23-e143-c82002762242@fb.com>
Date:   Sat, 13 Aug 2022 15:17:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220811001654.1316689-1-kuifeng@fb.com>
 <20220811001654.1316689-2-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220811001654.1316689-2-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:303:83::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdb0ad5b-03ce-4171-e34a-08da7d7990ce
X-MS-TrafficTypeDiagnostic: DM6PR15MB2746:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2Q/MobGI3iXDaBUCGLk6SocptPN/jTXpzDR3ZzyPjKICrEVdYz6PK6PgDZjfbH2ncrG6dly37uymQncG2mHjFsZa8GC6PavVL9iX4T1C5x86U8zVNfi5Lz3RzGR5VFHIm4wTxUQPW+aHYtk875/+QeAjSnGpZXpCh2VE9qTRWq/BcBXJ9fsZiWJGS7MPM0eK9v0qMYivouLKqa4BQ+ah66wqQrX248p5O7N0CNlMdq+fN5J5Y/kb1N8etmyy9BsQ9dmDcMyoZ9SyEXPCslIiYe5pTuv/fXRSXbky0+HH06AWHetKIbFsFrAvx2MXI1f+oMZkdHexGnNhSMM+Bbmota3kV+sVzowtbofHOnJzUz8V6g8K/eMiEjWigvBhGEwjTdPXt6FQKxt8ZbRIdlI6CsYJRTEye2oN5NyB7TuUA7Ja0ByiAyuyhhS+g67tWlmhYhl+pqPUAsGg5MkVBVjtdejHjazFwPKTPUV6O5qlwI8Y0KogbrMCNKZbZG1Mp16R1JCDO7TDmCitv8M6P+rALI7gHYCUA8PMwjlvVLpnp3CdJf02wFvQOUoYLhFczCjhJPvJT6Tw5V39lJR4GPI1aghjhKwbCPYuyASm3e6R24E+WMvysi27kloohRDwSsVXv2psAd4kTOyYY084OcOWPXdCHf7XwnZO7XFeTKMkt8ko99Dc8pOWp1AOGe7fSF2zKXq9kGKxYsDKUF6NYn+OwP3c6V2x3CoxJVWO7HzsFxjtqrByHbyGDQndbKVja08vyrnig3WkkpGQTqRtGMp/HrorhS0yEAICbVUe8WOMIy6dK7csoMhZoQl51zZ4wovHSpKrm7GecpQYadJsafdLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(316002)(38100700002)(6636002)(8676002)(478600001)(66556008)(83380400001)(36756003)(31686004)(6486002)(66946007)(31696002)(2906002)(5660300002)(8936002)(6666004)(6512007)(6506007)(41300700001)(66476007)(186003)(53546011)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS9qTnAyNVhVUzIxY2JvUXBWQUJlMlkvN0xUZDQ4djJRdU1Ib1k0enhwOW5C?=
 =?utf-8?B?bUdycGpjdldZSFJFR3BRVHZySGFUWEY1WTZUSEltYW90M3hnRkppeGJ5WU5E?=
 =?utf-8?B?dmVUTEZ6YmFnbUx5TWltV2xxTjg4ODE1elhYbytiQmtxU3M1N0FDM1ZxOStt?=
 =?utf-8?B?bndyRGtsQ1FjNWFBRE9paUJ3cWVJY2pzWTZ5YmhyTm1VeG54OVpwdTN0VnlI?=
 =?utf-8?B?VndUTUFUUmlTR3JvWmo0NEZxVU1vWmd6WDNOejNwQ3NZUTVKQy9PRHRucG8w?=
 =?utf-8?B?eXJDQStTM2U5OCs2UGlNazNsNkNaWS9NYk1KZEdsUGVpSEdldmRUekkvZGFj?=
 =?utf-8?B?eEJaQW8ra0xOOFExcXpXczB2blo4WFpMdElXQndOSHdzUm00Tnk5cEp2eTRR?=
 =?utf-8?B?WFBtbWNnemt1amlXNlBBYnoxSzhQU083bUJJQ2dQNW9VZXFXNTI0ZUd0a2FI?=
 =?utf-8?B?aCtRVTh0L0pwbTZ3OEFXbnpwSkJDcVpSWVFoQ0RnSEVxZ0ZnTG82ZDVMUWpU?=
 =?utf-8?B?Y1BORFpING43bUlEZjJLZVUyV3RSZHZOQTNTN1F1WjN0Q1hjT1dkTW9qY0tQ?=
 =?utf-8?B?SHg2UURCNGdWTnJhZkJRdFhQdFdZTDVWQ3hxTGhwNU91aEZCYXh4TlZ5WTgz?=
 =?utf-8?B?SFVwVWN6RnJadGRFS05vaWJqQXNFNTRjck1EcDAyZjFZMTA4QnBibTR6RDlW?=
 =?utf-8?B?bzcwb2hTKy9Ocyt5S3ZrTDkrMU1Rc2p0TXlqd0EySU9XQzRnankvWWRpdzFH?=
 =?utf-8?B?cHptaG1BcHpZNHhraktxQ2NiTlg0M3J0OFFqbit0aWV3ZlVjdHQ5Q0hwdVFz?=
 =?utf-8?B?aW5CbkprcFNmY2taTXF3TVRTbExxVTNkbERhZXg2Y2t3Ky81ekJQSlFHNUZP?=
 =?utf-8?B?MVhLNEQ2YVN3bmxIMitwRGh0bHpxY09MdEV5SEIwZ2Z0UXlNb0tOVjlVQkpP?=
 =?utf-8?B?clh2RHpKencxTnlWcnZjRjU2ZEt1M0x4TEFuanM4WmgzS3Nldm96eFJVQ0py?=
 =?utf-8?B?M2pLWkpTeXlnQWRRSU9DS043ZTlvYmdKWHhEVHRsSG4zNmRPbE9RVm11SVI1?=
 =?utf-8?B?dk5yWG5CZUY0dG5GZ2ExeUpOMWVJRkJaQTJmQXBTdGJVK0xIQWljY1g2TmxH?=
 =?utf-8?B?M2I2c25ZMGtUbzlLQThOcDBWbnVTUTFzM0dVaW9tTG5NeDJQNTZEMUxzTUQ5?=
 =?utf-8?B?Y1dzWnA5MFhwa2pFTUFXRkIxbEFxcGFnRmpHbjJ3U0VCRkV1RTQ0K1dLRjA2?=
 =?utf-8?B?MzhVck5RaU1PNUh3eUtneExkbE5HRmFOSi96Wm84UlFTc2EzSFgrNU9VZFEy?=
 =?utf-8?B?TUFvdDlIa2duZi9wTlZNNFRuUDVua29HOWdnWGgvbkFCQmhMMjU0NFVPTXJk?=
 =?utf-8?B?a2lNQVFzUjM3a0JiUjZvSjVxdFF0OS94ODMzT3psUSsrdHB1T0ptQkNLeDdq?=
 =?utf-8?B?SnRwdXV1d1JiNWJxSjBQTEFldnJtMDNTQnVKN2dDUitRQjFsQmRTcVlxRDUr?=
 =?utf-8?B?c1Z0ZjcrMHUrT0tiaVUxUkd6TlphYWV6aTBFUWNYeTNQOCtFRmhQcmRhak5i?=
 =?utf-8?B?dFN6Um5UV1MybEhIUXh6Y1RtMmxpT2dNeW9zUjJZVTN6Ykw5TzhYZE1kTkNq?=
 =?utf-8?B?YkZtbEZidTMxTlRiNkladUZYNWJQSXNEb28rRS9rTHJaRzhOQnM2UExxaG85?=
 =?utf-8?B?b3Y3TXZ5aklJT1FEK2oraWJZbldCUTcwS3ZuTE1pNm5rMFJJNjZOOW45TkxI?=
 =?utf-8?B?Q3RzbFl5VVkzK1ZFRkFnd3RDNkE1SUZzL3c5U1V5YVBwWkN0clVvY1JLZWth?=
 =?utf-8?B?NDZ6R2tlZ003UUc4NENqa1B2Z2tZdk1hNHVmc1V0N3l6OVVab3NLS01DUTFK?=
 =?utf-8?B?d1NrNVQwSXpDRVE4eFJXRmc2M3J3eGRYZ293dDNoNUxLZW02MGlwbGdLTmpV?=
 =?utf-8?B?ZE4zK0VpNVhySTg4L1UvTkl5aDRoeFZuM0NPWlltMmtkNFcweEFOTXpRaHVi?=
 =?utf-8?B?Z2MrYWF1VzQ0WG5Bd3NXZUJWNFlrby9hVnZiVUF4QXFQa0l5bVp5dnZ4TmtE?=
 =?utf-8?B?Q2NNME05V2lTNS9oQ3ZHbUtHUmhJRHVGcEtZL0FSVS9sb3pVMUU5RTBnV1RX?=
 =?utf-8?Q?/Tw4fr3wLiTG20wYAy/X2haCk?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb0ad5b-03ce-4171-e34a-08da7d7990ce
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 22:17:10.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C9dxF2+qa3LCurRvJHAB1NrZudlUxjDtrsKyroLL83SF85TnuBlNSMhSu/SUJGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2746
X-Proofpoint-GUID: EUZYLrPLWQbGZ8lFkvVgT7vuuJkfiJDH
X-Proofpoint-ORIG-GUID: EUZYLrPLWQbGZ8lFkvVgT7vuuJkfiJDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-13_11,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/10/22 5:16 PM, Kui-Feng Lee wrote:
> Allow creating an iterator that loops through resources of one task/thread.
> 
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested
> in only the resources of a specific task or process.  Passing the
> additional parameters, people can now create an iterator to go
> through all resources or only the resources of a task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   include/linux/bpf.h            |  29 ++++++++
>   include/uapi/linux/bpf.h       |   8 +++
>   kernel/bpf/task_iter.c         | 126 ++++++++++++++++++++++++++-------
>   tools/include/uapi/linux/bpf.h |   8 +++
>   4 files changed, 147 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 11950029284f..6bbe53d06faa 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1716,8 +1716,37 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
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
> + *	Iterate over reosurces of evevry task of a process / task group.
> + */
> +enum bpf_iter_task_type {
> +	BPF_TASK_ITER_ALL = 0,
> +	BPF_TASK_ITER_TID,
> +	BPF_TASK_ITER_TGID,
> +};
> +
>   struct bpf_iter_aux_info {
>   	struct bpf_map *map;
> +	struct {
> +		enum bpf_iter_task_type	type;
> +		union {
> +			u32 tid;
> +			u32 tgid;
> +			u32 pid_fd;
> +		};
> +	} task;
>   };
>   
>   typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ffcbf79a556b..6328aca0cf5c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -91,6 +91,14 @@ union bpf_iter_link_info {
>   	struct {
>   		__u32	map_fd;
>   	} map;
> +	/*
> +	 * Parameters of task iterators.
> +	 */

The comment can be put into one line.

> +	struct {
> +		__u32	tid;
> +		__u32	tgid;
> +		__u32	pid_fd;

The above is a max of kernel and user space terminologies.
tid/pid are user space concept and tgid is a kernel space
concept.

In bpf uapi header, we have

struct bpf_pidns_info {
         __u32 pid;
         __u32 tgid;
};

which uses kernel terminologies.

So I suggest the bpf_iter_link_info.task can also
use pure kernel terminology pid/tgid/tgid_fd here.

Alternative, using pure user space terminology
can be tid/pid/pid_fd but seems the kernel terminology
might be better since we already have precedence.


> +	} task;
>   };
>   
>   /* BPF syscall commands, see bpf(2) man-page for more details. */
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 8c921799def4..f2e21efe075d 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -12,6 +12,12 @@
>   
>   struct bpf_iter_seq_task_common {
>   	struct pid_namespace *ns;
> +	enum bpf_iter_task_type	type;
> +	union {
> +		u32 tid;
> +		u32 tgid;
> +		u32 pid_fd;
> +	};
>   };
>   
>   struct bpf_iter_seq_task_info {
> @@ -22,24 +28,40 @@ struct bpf_iter_seq_task_info {
>   	u32 tid;
>   };
>   
> -static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
> +static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_common *common,
>   					     u32 *tid,
>   					     bool skip_if_dup_files)
>   {
>   	struct task_struct *task = NULL;
>   	struct pid *pid;
>   
> +	if (common->type == BPF_TASK_ITER_TID) {
> +		if (*tid && *tid != common->tid)
> +			return NULL;
> +		rcu_read_lock();
> +		pid = find_pid_ns(common->tid, common->ns);
> +		if (pid) {
> +			task = get_pid_task(pid, PIDTYPE_PID);
> +			*tid = common->tid;
> +		}
> +		rcu_read_unlock();
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
> +

This extra line is unnecessary.

>   		if (!task) {
>   			++*tid;
>   			goto retry;
> -		} else if (skip_if_dup_files && !thread_group_leader(task) &&
> -			   task->files == task->group_leader->files) {
> +		} else if ((skip_if_dup_files && !thread_group_leader(task) &&
> +			    task->files == task->group_leader->files) ||
> +			   (common->type == BPF_TASK_ITER_TGID &&
> +			    __task_pid_nr_ns(task, PIDTYPE_TGID, common->ns) != common->tgid)) {
>   			put_task_struct(task);
>   			task = NULL;
>   			++*tid;
> @@ -56,7 +78,8 @@ static void *task_seq_start(struct seq_file *seq, loff_t *pos)
>   	struct bpf_iter_seq_task_info *info = seq->private;
>   	struct task_struct *task;
>   
> -	task = task_seq_get_next(info->common.ns, &info->tid, false);
> +	task = task_seq_get_next(&info->common, &info->tid, false);
> +

Extra line?

>   	if (!task)
>   		return NULL;
>   
> @@ -73,7 +96,8 @@ static void *task_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   	++*pos;
>   	++info->tid;
>   	put_task_struct((struct task_struct *)v);
> -	task = task_seq_get_next(info->common.ns, &info->tid, false);
> +

Extra line?

> +	task = task_seq_get_next(&info->common, &info->tid, false);
>   	if (!task)
>   		return NULL;
>   
> @@ -117,6 +141,43 @@ static void task_seq_stop(struct seq_file *seq, void *v)
>   		put_task_struct((struct task_struct *)v);
>   }
>   
> +static int bpf_iter_attach_task(struct bpf_prog *prog,
> +				union bpf_iter_link_info *linfo,
> +				struct bpf_iter_aux_info *aux)
> +{
> +	unsigned int flags;
> +	struct pid_namespace *ns;
> +	struct pid *pid;
> +	pid_t tgid;

Follow reverse chrismas tree style?

> +
> +	if (linfo->task.tid != 0) {
> +		aux->task.type = BPF_TASK_ITER_TID;
> +		aux->task.tid = linfo->task.tid;
> +	} else if (linfo->task.tgid != 0) {
> +		aux->task.type = BPF_TASK_ITER_TGID;
> +		aux->task.tgid = linfo->task.tgid;
> +	} else if (linfo->task.pid_fd != 0) {
> +		aux->task.type = BPF_TASK_ITER_TGID;
> +		pid = pidfd_get_pid(linfo->task.pid_fd, &flags);
> +		if (IS_ERR(pid))
> +			return PTR_ERR(pid);
> +
> +		ns = task_active_pid_ns(current);
> +		if (IS_ERR(ns))
> +			return PTR_ERR(ns);
> +
> +		tgid = pid_nr_ns(pid, ns);
> +		if (tgid <= 0)
> +			return -EINVAL;

Is it possible that tgid <= 0? I think no, so
the above two lines are unnecessary.

> +
> +		aux->task.tgid = tgid;

We leaks the reference count for 'pid' here.
We need to add
		put_pid(pid);
to release the reference for pid.
	
> +	} else {
> +		aux->task.type = BPF_TASK_ITER_ALL;
> +	}

What will happen if two or all of task.tid, task.tgid and
task.pid_fd non-zero? Should we fail here?

> +
> +	return 0;
> +}
> +
>   static const struct seq_operations task_seq_ops = {
>   	.start	= task_seq_start,
>   	.next	= task_seq_next,
> @@ -137,8 +198,7 @@ struct bpf_iter_seq_task_file_info {
>   static struct file *
[...]
>   
> @@ -307,11 +381,10 @@ enum bpf_task_vma_iter_find_op {
>   static struct vm_area_struct *
>   task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
>   {
> -	struct pid_namespace *ns = info->common.ns;
>   	enum bpf_task_vma_iter_find_op op;
>   	struct vm_area_struct *curr_vma;
>   	struct task_struct *curr_task;
> -	u32 curr_tid = info->tid;
> +	u32 saved_tid = info->tid;
>   
>   	/* If this function returns a non-NULL vma, it holds a reference to
>   	 * the task_struct, and holds read lock on vma->mm->mmap_lock.
> @@ -371,14 +444,13 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
>   		}
>   	} else {
>   again:
> -		curr_task = task_seq_get_next(ns, &curr_tid, true);
> +		curr_task = task_seq_get_next(&info->common, &info->tid, true);
>   		if (!curr_task) {
> -			info->tid = curr_tid + 1;
> +			info->tid++;
>   			goto finish;
>   		}
>   
> -		if (curr_tid != info->tid) {
> -			info->tid = curr_tid;
> +		if (saved_tid != info->tid) {
>   			/* new task, process the first vma */
>   			op = task_vma_iter_first_vma;
>   		} else {
> @@ -430,9 +502,12 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
>   	return curr_vma;
>   
>   next_task:
> +	if (info->common.type == BPF_TASK_ITER_TID)
> +		goto finish;
> +
>   	put_task_struct(curr_task);
>   	info->task = NULL;
> -	curr_tid++;
> +	info->tid++;

saved_tid = ++info->tid?

>   	goto again;
>   
>   finish:
[...]
