Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347995A2FF7
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 21:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbiHZTaj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiHZTai (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 15:30:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8006A2AB7
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 12:30:37 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIPAR3007986;
        Fri, 26 Aug 2022 12:30:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5oxGvjQ/UfAtHwR964JDt73PyrRLNcofJ+LRALrygSQ=;
 b=c7RL2LsKUA0Zc1h+aJM4N/A80qOJWQVOY0PEFH0D87SLV2nIyIS7SZdMUna+IG0dBK4a
 1rXewKRejCDFX3hLc0dcsNlLDenP4Un8J8GnJMLI1k0hsA+Y07YyF2Weqs+Su+Cj230j
 Sxw9xhOsLO0ZRRF4n1ol+RO9C1Icwm/R5ww= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6rwdcdxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:30:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkfmzzKAPoaGZts62dP6G81w8uJ6xtKkrzJMpPp+skcuUAP0lPSi/F8CtwkA7hA6pQOepK58rcbkdGVqLJEbreOg6EK9lYkZ92b9FbGWVuR7zQbYk5Ma9tlHvM8TYlRaT/UEeCRfq+yQEAD+g9AvUleMcDbrdmIn5TP4JRJTXZ6YdhTBay3eHNyfg1mMs3y6quuCsMdBvuhkwuF/1iRhBGCymraTSW4+4SPJiMgcGq5wjSsgsQ47+0Q3b4JJy3WkCPhodq0OCcM3XMAXnt7wse+OLznrF+cTxMhd5iT88WHpPoRg4OOwa4iN/IxN/yftIugzLDh1GjGGCLckhQbWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oxGvjQ/UfAtHwR964JDt73PyrRLNcofJ+LRALrygSQ=;
 b=iLnB4R4ekeIcffIGOuhtD0xKdYUpJllKmhWVt+1b9zQMj4QU1C1MKNGnzfsEnQvzMC6offoDpY1OP9C1yIlrvCZWwCn+O4poDbB90iKMLEXQ7UUrF+VkrQFH6cpy3LNynisK/KDQtji3ZsXfoSRMgwcO4Az3EhliUR9KuWrc/TTcfBnOo6+DTTXJ5ULZVltKc+ELW+uwikhgApcqNPmxoYqcTARstazqa2LUlIxCHAhPlg1e2T1olETQekfiXVyBgRkW1RdroCXHslnUGgs+f/QlOfDkzrrnPZlqDkESnpaBKyOMkDjt8RP5A1eBU7IW30TXGhPCKT9Ue8AznqeMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by PH0PR15MB4165.namprd15.prod.outlook.com (2603:10b6:510:2b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 19:30:20 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3%7]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 19:30:20 +0000
Message-ID: <7beb3850-c1e4-7cfc-d39b-1a24f1354fdd@fb.com>
Date:   Fri, 26 Aug 2022 12:30:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v7 1/5] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220826003712.2810158-1-kuifeng@fb.com>
 <20220826003712.2810158-2-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220826003712.2810158-2-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:a03:114::39) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83128821-a5f4-461b-1acb-08da879969d4
X-MS-TrafficTypeDiagnostic: PH0PR15MB4165:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhUG+K2BdkAATsIla2oJI4XI1CASOX7cxhTRSQrID6CtRVmU0Sr6ReaKBA/WNXZ5gKu4x8eMr4cFF6P3Y6gFJ12dKDHWOgGjmrQuhYNaXCp26mma23M5hM8SGgPE5Fn7zFeVLMlnWYrBs+oxD5WCxX+eTLG012vJxyZ1x9TTNyEbPDNONxRfLoWM16DRF2EZ0b8nwTqKDx6uidNofbukjVpat+JUunZo/gj4jnGnM7p07OjQ7bUTIsLGK4YOHReNyWeW50/2afwwDd5buEoz0T445afV03YjQbnQhyMXgoVmKAnsEzoeZADGajMvt/gj8Jo0rs6Il1QjxR+WhP1Vt5e0xwKqW2olPmXYNO43+tRPHRmsd82teXqTbSY/pJVPaE6HJWOS6x2qdCIEbQFvw89Ln+sbx4UkAguQkGvPMf9BialdPuTyEZes+unqMx1AchW+Ka+bME9awI1NaEr07dGuZue1+4Ar/jWhzks4v+J++55RLd++CxAtOL/H3KGbtsFC/mJXd9HDAZpDFuPT0pM95DoSiZM5jbnIe5cU+9ejYCLLdgFRHjvhpottu8ggtC07j/s5mMSBUdjH64ucx8h7McYAPINPC1npLQ2hy/6XlHpXAUam2YkgHLEuaxPZTbV6JEYjt8eLIDK73XigTDIjpgMFvg95a5XhUGm7fOHYXGPUg/MGsymny1kyLu3UWg1+f6stLrCD/ufEZQolVpY9iorMFTVGnp6HXFLaPS5WKpXtK43xt5hbGM/a2/FsuWw35Cw0S8YueBDRo/ZJUwFICN6kvqe6KMU0n+Q1usCf/qPMkgp9g8pAXv2/bOPtDEgwQ1pwzlk9DaTWLAUi0XryWAMcf/63ycXWmIRhtBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(66946007)(38100700002)(66556008)(66476007)(8676002)(31696002)(86362001)(31686004)(36756003)(83380400001)(6512007)(6506007)(6666004)(6486002)(478600001)(53546011)(41300700001)(6636002)(316002)(2616005)(2906002)(186003)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azBpaFVFQ0FDUDJRcGpuMHhTMGU4WnJnMFQ0TjF3VzdLZ0Z1Nzg4S1hkQXVo?=
 =?utf-8?B?NGJ5VDVVcHorYTY2SE1QMmd5YVhPZFkzMlRYMENXcFdlQnpMZGFKQVBmc1d6?=
 =?utf-8?B?U2NYUm1HMDBBSEF4dzg5TlpVYVVrRWxFKzJVYjNFMlliK3RRcFhCM3dzRU14?=
 =?utf-8?B?dncxR3VIc3dhM2E0L3YrNkZZMDlpVlhQVFA3d0tPNTM1LzJPemR1cGZGYk1i?=
 =?utf-8?B?bXgvaVZsZ2JNUXFDQjhHZlNHQUtIV3BDTm9zQUlrTUdQb2Z1bzg4MG9EQXYv?=
 =?utf-8?B?aWFDblV6dHU2YVZnaFY0U1RrajRLSStEWkwxdWNvSkFVQzAveWFOSk54SXNh?=
 =?utf-8?B?NnRyVTRYRXNoNmhWYmxYV0RSaXFlbVJBaFNUVWZ4dklRUk1RYkZZRzFjOGxE?=
 =?utf-8?B?QlArTmNuNkhNcXBsUkQ3ZVo5WnAzYkRLYVhlaTc3SElJd25DYndqajU4cS8y?=
 =?utf-8?B?TXlSTm0zMEE5VDUycG1Zb3VoeG5wN1JkVkxsMUlXUVhpbWRiUUlub1NJVmkr?=
 =?utf-8?B?M3pudFkxZEEwSFBHTno4R1VlRUl5cE03V1N5dUI3M0d6NWhaaGduSS81ZHdl?=
 =?utf-8?B?eVl4ZXNUTFQzL1BxRHc1WnYrU2lHWkxza3BkZ0svWlB3MkhIRDdZdS9mUDlR?=
 =?utf-8?B?VDZtZmhJTzlrNEFXMjBMU284QXUrVGFmSmZSNERVRUxCOHpEekFWODh1Yy9w?=
 =?utf-8?B?SVJObTVBMFh0NUphWm1SeURSNXEyd251b09ucExGNVg0SFBiclRBSkF2WFhj?=
 =?utf-8?B?SStvNmRPTDdKTTJKaHZrQ1psOXUxS3lDd2l6M3FPcmJ0dFU5NXA1MjZrbkpr?=
 =?utf-8?B?K2VkdnI4MzA3MG5NcVc0VFg1ZzUyYmpUOHVIQ0VmZDFaaUZNNHMxOWt0RUN4?=
 =?utf-8?B?OS9MaUlVenIyaFhtdGZGcUlPSnZpVlFleDJnTnNPeVRKTnFXUzN6UlhiVEhm?=
 =?utf-8?B?cldSTS9ESkpqQ2RYbXVDMUorS1NFUkY2ZHZuYk9KSy90QnlaV2pSV2dnOHV6?=
 =?utf-8?B?NlhPdlBnQ3dFaW5WRWxaclNFRGZFa05lUGhUUkc0OG1YZWhHRnZUZWlwaEtP?=
 =?utf-8?B?QjBlNHJKMkVpczRoVi9CWGtNMTA1akVBTktJaHp1Qk5ZQmp1UEE5QnJEYXRy?=
 =?utf-8?B?ZU9yd0RiUCtiUC9aMFlGbmp1d2RpdlhmMDZzN3BKTkcvTFEwcHRMb09OcGNX?=
 =?utf-8?B?QXpXNzAvTEY0WWE2dmplZElmS2tCczlrTG02N1VuK28wNFlGNlE0SlUwSTRX?=
 =?utf-8?B?ZXBlUW9VcXJBV002ZklBU2M1WmV3dUhKNmY5aVAyQnRoaE5FYkpDOUZlN01p?=
 =?utf-8?B?TmdST1RNMUVLdXpWTk43aUsvMEljekNIMS8rVjNMelZUa0FuWXFITWdTdzQ3?=
 =?utf-8?B?dGJ3VzVqQ1UyL09kWFVMN0RDS2Zlb2pyMTdzTllxMEsxM2kzbmZNaGFzUU1o?=
 =?utf-8?B?TDAvNnVGaWFjM2lBVm5WMWhXaUJvbW1OWGlRdVptcnMxQXBPNU9qQWtEcTZC?=
 =?utf-8?B?VlYyVHpFdjJPSysrUlhtVlg4QlMvWXV0VXVDTFc0dWp0MUdvZ1dJNkVsK2Vu?=
 =?utf-8?B?RUhncGtRWUExODhOOGJoTCtoSmk1YmJYZGExQkMzYStDampxaktkeVIvbVZk?=
 =?utf-8?B?QUF4SnZQVmVnRjE5MXNkdDVDK0pOQ24wc2ovZW4xZ1BGUFpmckt6Zkh3Q3Bi?=
 =?utf-8?B?MlcvcVFnb0ZOdWFKbDU1N1R5VVlnOUdvdXpBREhjWkxDemhaeThISWY0N2hP?=
 =?utf-8?B?S3JVSVdFaDlwUElWeGhwZTJPOHYvOURwWGV3aTVpYmFLZEF0MkJ6MUZPb3NB?=
 =?utf-8?B?SFZVS2N1T1ZaYndrblg2WDFUU2NMakJhc1U3TlBrVE96a21oZVcrM0Y1Q3Jm?=
 =?utf-8?B?UCtFaDZNUmRPbHFvRWRULzA1ZFdDRUQwV1hEM3FjdjVCZE9La3hGd2ZCamxL?=
 =?utf-8?B?cFZnQml4RjRJYUNBZ3lmVC9qQkh3KzhCRmhHcFdDSTZXaDJBVFF2eTVUMjNI?=
 =?utf-8?B?Tk9ibDJ6RTdncUZZalUyVy92dHMreTVjV09QU1FyTGdtV1FFWWxCQVdGVXFj?=
 =?utf-8?B?V1dHdWNZNFk2bHpqelBKMlRZQ1E1U0hFeVhRcGFpRzVSMEZvalhjYXNjQ29t?=
 =?utf-8?B?M2Z3bDdJNkdoYXlBSEo2ZW4rUUpFQlN1YUZQeTVINGswWVVjN0dZNmJ3OVI0?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83128821-a5f4-461b-1acb-08da879969d4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 19:30:20.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybZub9wTKp86wa/RYTw7/SQx3jmq0tTayOxiQZVD7D2EMRAwiZHp7dsax6DOsyuw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4165
X-Proofpoint-GUID: 60R8MRVJlPgWcHakVyc0JtVnjMlWWO8J
X-Proofpoint-ORIG-GUID: 60R8MRVJlPgWcHakVyc0JtVnjMlWWO8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/25/22 5:37 PM, Kui-Feng Lee wrote:
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
>   include/linux/bpf.h            |  25 +++++++
>   include/uapi/linux/bpf.h       |   6 ++
>   kernel/bpf/task_iter.c         | 128 ++++++++++++++++++++++++++-------
>   tools/include/uapi/linux/bpf.h |   6 ++
>   4 files changed, 141 insertions(+), 24 deletions(-)
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
> index 0f61f09f467a..385deab984e1 100644
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
> index 8c921799def4..1200cfde71e3 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -12,6 +12,8 @@
>   
>   struct bpf_iter_seq_task_common {
>   	struct pid_namespace *ns;
> +	enum bpf_iter_task_type	type;
> +	u32 pid;
>   };
>   
>   struct bpf_iter_seq_task_info {
> @@ -22,24 +24,54 @@ struct bpf_iter_seq_task_info {
>   	u32 tid;
>   };
>   
> -static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
> +static bool matched_task(struct task_struct *task,
> +			 struct bpf_iter_seq_task_common *common,
> +			 bool skip_if_dup_file)
> +{
> +	/* Should not have the same 'files' if skip_if_dup_file is true */
> +	bool diff_files_if =
> +		!skip_if_dup_file ||
> +		(thread_group_leader(task) &&
> +		 task->files != task->group_leader->files);

Should this be
	!skip_if_dup_file || thread_group_leader(task) ||
	task->files != task->group_leader->files
?

> +	/* Should have the given tgid if the type is BPF_TASK_ITER_TGI */

BPF_TASK_ITER_TGID?

> +	bool have_tgid_if =
> +		common->type != BPF_TASK_ITER_TGID ||
> +		__task_pid_nr_ns(task, PIDTYPE_TGID,
> +				 common->ns) == common->pid;
> +	return diff_files_if && have_tgid_if;
> +}
> +
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
> +			task = get_pid_task(pid, PIDTYPE_PID);
> +			*tid = common->pid;
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
>   		if (!task) {
>   			++*tid;
>   			goto retry;
> -		} else if (skip_if_dup_files && !thread_group_leader(task) &&
> -			   task->files == task->group_leader->files) {
> +		} else if (!matched_task(task, common, skip_if_dup_files)) {
>   			put_task_struct(task);
>   			task = NULL;
>   			++*tid;
> @@ -56,7 +88,7 @@ static void *task_seq_start(struct seq_file *seq, loff_t *pos)
>   	struct bpf_iter_seq_task_info *info = seq->private;
>   	struct task_struct *task;
>   
> -	task = task_seq_get_next(info->common.ns, &info->tid, false);
> +	task = task_seq_get_next(&info->common, &info->tid, false);
>   	if (!task)
>   		return NULL;
>   
[...]
