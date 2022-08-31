Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863575A74A5
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 06:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiHaEEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 00:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiHaEEm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 00:04:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB666B0B20
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 21:04:40 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V0ppQh024368;
        Tue, 30 Aug 2022 21:04:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=t7RVJD2mGDzXbpB8qjC3MDxxMWy6HgONs+L4TAf0C6s=;
 b=THm0URS3spAQuH8ndP9dtEIHwweaciz6x8vfmKOwh7MGlZ8ZwESJ0+I66cHTu6cWNwjE
 8Di+U/BbEb5uuPOsc68TiOnOJZLQQKzwAHCJHRzFTC0fn7sLxhr9qU27juEfs6u4p1Ux
 slotHza0TeeC6m5B7HptZ+XB8nhAKXKpC7k= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9ae4fawt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 21:04:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIpISXfPGNLeTJ8VwW90iHHWYntfKRNNPAyLydBij5wxHITPU57gppO+nJYAZ4U4fZ3svnNO1k+6Gwn8pAgq+NkRweVPZF5rBO2U/idHuYWqICt/Y9wu0k+jAq9bBaF40/466rjMT3HN3dX9MRjAxejc8JxvET/H8SdebplLLfwxtFR/O0NHkyI/JL48yEOdz4lfsfzPm3GhC9z/K3IHxPGWLrSY4MFi493ls6y+1TGPiAOxM7fdh1kAUj5IjbnKKCPhdxGdZm1NUcGVSHtdLcO1Y0IuHZbdrGsoUIvEstHFgChuj3rjYqs/XUAG/TMH3WUlDp0kNr8N7IjaHBIKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7RVJD2mGDzXbpB8qjC3MDxxMWy6HgONs+L4TAf0C6s=;
 b=aC0R4pfyUAIQ5VPlhczwUi9x2fyC4iQr1HgqQ30dxdq0EctyJYv21gONBSkVLEI+7LUh533VxcP4O1s5aTYqLRCB76kI5Xe3nwvM7UPiFmf5MfH2M1WdR+9cRYb62OqhjTe0pI/IfbyOYa/rZjxgaq/kfQtbmo4Q6cIxgfFgjCwAF51Lf628obivQsHaBec0lbOa+kDx5VQj0gZGD2zfAe46W8XFPJ4k4634+xP3cdU+ag1+U58A7GLlV0OMwwcrti8rgl5vavX06v4wxQlpJ96m/KyDNwqFLTb2iFFEmX0og2VAvtDqHP7JVa+YjgI3Uy95w0FSQLL+IJd097K67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by MW3PR15MB3817.namprd15.prod.outlook.com (2603:10b6:303:4d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 04:04:23 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3%7]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 04:04:23 +0000
Message-ID: <c5e60246-cd01-030d-9463-ce7b925c07cb@fb.com>
Date:   Tue, 30 Aug 2022 21:04:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220831023744.1790468-1-kuifeng@fb.com>
 <20220831023744.1790468-2-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220831023744.1790468-2-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1ac027-1d87-42ec-9fd6-08da8b05e08b
X-MS-TrafficTypeDiagnostic: MW3PR15MB3817:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+QNIRhfew8JfLFbIVLpnpnABSen6bKk1hr2UH9FPaBWFbet4pqwoK8e3/RDmL1+9Fu816qf1yhY5ilSuB2UfJ2n2C12w/dqmp3k1f0JmF5APG+ZhBL7Q5ZHbI/jN3X7XjUcPvftDysbAuniXG2Zm6pNI+x/9828vIy3Q6imT2qsWuUVR/4QtYe0mDf7jnyGdr7UQCrKozmVZerj/xSdNBCCEd7G+mBf/ZqMWpSwFOYpKmlfIXco1yWayicBT0pyYp/dl65Jqs+ZUBgFfnWq/6an+qJmzuqWK9YuwUoeLJD4jk5ki4271D4AwAngcllJEALd9DlkuojkSvDKJxfe/lXNMduu1OCivgUIRfW7VWqqG1tZqabinBeHxSPveE9aM6dn460Lk4ubfGkiJH/Py/C50/zIy/TGvh8yS9liNN1rJxvoxekJZ3K+069glYk1rpt2bGo5DFJPbsGXWSMmLJBSySUJ4+D+8YnWVsUChcedJdhcNWETRwMO3E8BLwTJaVnAV5ZtOy0YxYskWB/97uV8g1EtIFSrnqMLLC+XQczsBdgQXSHX1XEMWf2QjUL6drjNWU9Emgx+Kp6g40XRge6m6DSDT+4nwSqOs0ZW9iC+LQY1DqdbWHc8Eigto60u5V4oQ0esXJ/rNv459Kjyhs1XP/ggi2A+NnZOTJO2bmF7VOyC6BPvntZncVXxVJ5bfkglccoXDqVz7Dxmxc5ix2UixAdJIq6Jm8n8B/SzAjq0Pv5oHA8CkphuGYRnPvUALi2o4r8noCbCV/HIYZj1FvaBusZ9tn0bPbtlCVLvnic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(6636002)(8676002)(86362001)(31686004)(6486002)(66556008)(31696002)(66946007)(66476007)(5660300002)(8936002)(36756003)(316002)(478600001)(41300700001)(6666004)(2616005)(83380400001)(53546011)(2906002)(6506007)(38100700002)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENONDg3OWJWN2g0TVE3VHRjRlBBYUpLK1U1ZncwampVbEVZcVloY2w3MEZK?=
 =?utf-8?B?QVRDQjdEdTJEeDFkU0JwSW5Lb21VQnJjbTlpbWhQcXZSTUlDMU11dWNLOGhw?=
 =?utf-8?B?V1VXRWNkc1piYVk2V2svVW1UV0tMUWxIdXZvWmZXZ21jdklRY1k0WFlHbTVo?=
 =?utf-8?B?S2NIUzJPejd4ZFZvbnpnWm5kYUJ1TExOcnVOOHpqV2hjbzFudmRUT3lydEZr?=
 =?utf-8?B?T2hoZmpmNFF6M2JRM1FBQ2l6U0p3VFNVWGJrUWZHTVorUm1BQmpNalZFZUF1?=
 =?utf-8?B?djk0azRtUFJ2QVpkcXNtMmhPUElEQTRVNmRYSFJZTVNKTkV5T2g3Ri9IK1hw?=
 =?utf-8?B?ZUh0OFBndzJsL0tidjd1UFRmWS9sRHl4bW5KK1pKbGEwaEF5T3R2T2NJTjk5?=
 =?utf-8?B?UU1jKzdOcWJ3Q2FrenFUV252ZHdmdlhDS2Y1RCtQU3ZCaUVrN1FEV3ZXM0Rn?=
 =?utf-8?B?MjdGM0JqVGN4dFVMdUdkTlU1NTQrZXloN1ZFWkoyNnN1d0tjU296MmJhaFhW?=
 =?utf-8?B?UXRWMUdkbDBDa2Zpcyt5aGw5YzZqekFmdXJHa1NYV0ZtN1cvdFhjQ1o1c3RL?=
 =?utf-8?B?MWQ5UFBxL3hlYldRck1mbG5DVmhBTWRzMTlyOElOUnVmVWdPYVB5TWlPWVRP?=
 =?utf-8?B?WTVZVFhUcitUU1ArU0tJNHdsNWJOZktWMlUxa09nZkVuVHR3SlQ1WXNJeWli?=
 =?utf-8?B?RHBzQ0RPNnhWWWEzRnU3TXhPTzBTK1krY0RSOW00Rk8vRVYxT28wWEVCWTM1?=
 =?utf-8?B?cmVydkZJek5rcmJIMUZhQTNrVzUrOUwvNXZZYUorYm1YS3hERUc0ZkE0a0lv?=
 =?utf-8?B?bU1TdExNajcwbDlzdFErY1NOb0hSeVZiaU1MS2pFQlB3dWlsaVlwZk1Tbk5i?=
 =?utf-8?B?d0pyRStxUzdHWWxsVlp1d0tXaW95Sy90ZkZZV3IrUU4xdkIyTXJ0UmNWYkx0?=
 =?utf-8?B?WkFkR052UVVkVVNCQWNIKytJL3BjRXAyaG02aExmcFZ2RzNXak9sYWdTclg4?=
 =?utf-8?B?angvTUVzeldHeDBjQjZPSWdEMS9DVE4vUzRGeHY1WUJ4ZHFMQnlITTlWOURl?=
 =?utf-8?B?ZGFZaGFPUVZ2SEh6MU01Z3BLQ2VtK2JtNC8veE9xMGt4NlJpKzR2WTZxK0Z0?=
 =?utf-8?B?ZGdhdTRkNGRGYkU0Q1FWUzUzSVIyVnRQZHlJOExCQVNFR3pCMXZVaVNhQ2s4?=
 =?utf-8?B?UlVwaHVmYjcrZUQ5QmptampQcXZEbEtNdVdwak83QjFJSWhSSlJOSkh2T2VT?=
 =?utf-8?B?eG5nQ1lBWW51SCtFRVFPQk5WcnA3VUVsbG45RHZIcWczR3NRbnVFTDBZQkQw?=
 =?utf-8?B?WitaRDFsUUZrdWNWUnJCU29KZWJXUEQvbkRuZ1hnbWZtM0JxQXVhYTBucjBs?=
 =?utf-8?B?MDJNdlNkOXFhNUtwUzY3Nnk0bzgxMFprckt1S0hYQmRydkl1WTBCdUUxN2JS?=
 =?utf-8?B?eGNuUnJCd3BGVnkrcTE3aEFDWU04dEg3Ni9aVW1ySmFJNElJRENlcWM5OXVS?=
 =?utf-8?B?TWdtYWxYNE9UWGFFTHN4a2Q0TThWUTdZQVcvSzNoTHNzclY2UXJjZGJJem5r?=
 =?utf-8?B?RU55d0d6VVpTRVhLeHNwa1NMVEFGMDlrcEszQS9aM0g3cHBKODFmU0dXcnJM?=
 =?utf-8?B?WG9KZVluVCswbEJ1ZUpjZlZneTdjYThsQnJkYlRLUnNPQ1RJY3ZicUFYcTZp?=
 =?utf-8?B?Sy9TU2lseGtaMmVDYUlUR3lsMis5emlRUWlxN3N6VXVTUGJiTkp4MlRYZE15?=
 =?utf-8?B?VXVqNERBcm1CM0ZZMGsrQzlGTG13VVc4bnljc3J6cHp1VTV4MW1Hem4xYTZQ?=
 =?utf-8?B?NmpoWTZrelp4VVFVNi9seXU2d2dGcHBRQVgrNDFCVUhBejJZblpwbzJscFli?=
 =?utf-8?B?b21uVzV4KzN4WWo3N1ZHa2tEUW5LQktDYlNja0FwdVFZKzJMbjdCencxR0sv?=
 =?utf-8?B?MDRGQ0pLTEFMSWtUbElpTmhGcDl2ejdSelZZYzc1NE52V01NQjJpa1AzenJv?=
 =?utf-8?B?Q3p4ckoxSHRZVStaSVRtRTVRQmtCR25uaUhvRVZWNkV5SGs0K2lwbHpJMjNq?=
 =?utf-8?B?eVlQVXVCc2xNaEpwWEpvR2l6dlNMdmZMK00xYzV1d2QrQWI1QXVpeXdNM2VT?=
 =?utf-8?B?bzF2QWxyNXFJanNKUW9zSVhqa0RKQVBrSUJGWkNXcGY1RDhpOW5HNXN4WnQ3?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1ac027-1d87-42ec-9fd6-08da8b05e08b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 04:04:23.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipSfe3hcu4rVQrSo0RZbLRue5wHZ+gN/5z9cw6LAqevHLpAm54F42761GSfJEhJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3817
X-Proofpoint-ORIG-GUID: kJU2NILLWbmdNZ9k98lO890Sec3JMxDr
X-Proofpoint-GUID: kJU2NILLWbmdNZ9k98lO890Sec3JMxDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_01,2022-08-30_01,2022-06-22_01
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



On 8/30/22 7:37 PM, Kui-Feng Lee wrote:
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
>   kernel/bpf/task_iter.c         | 191 +++++++++++++++++++++++++++++----
>   tools/include/uapi/linux/bpf.h |   6 ++
>   4 files changed, 206 insertions(+), 22 deletions(-)
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
> index 8c921799def4..93779a021697 100644
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
> @@ -22,18 +25,114 @@ struct bpf_iter_seq_task_info {
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
> +	/* The value of *tid hasn't changed since the last time the
> +	 * iterator called this function.
> +	 *
> +	 * A caller will increase *tid by 1 to move to the next task.
> +	 * In other words, we should return the task of the given
> +	 * value of *tid if it hasn't changed since the last time
> +	 * the iterator called this function.
> +	 */
> +	if (*tid == common->pid_visiting) {
> +		pid = find_pid_ns(common->pid_visiting, common->ns);
> +		task = get_pid_task(pid, PIDTYPE_PID);
> +
> +		return task;
> +	}

As I mentioned in one of my previous replies, the code is correct but
the comment can be improved.

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

Okay, I double checked and the above change looks good to me.

> +
> +	return next_task;
> +}
> +
[...]
