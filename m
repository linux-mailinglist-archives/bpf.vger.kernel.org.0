Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3885A7207
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 01:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiH3Xyw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 19:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiH3Xyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 19:54:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D628BF9
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 16:54:48 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UMjKH7001050;
        Tue, 30 Aug 2022 16:54:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7kvZSyRnZASP5AsCXpATf8M5CEdO4JTWKh80HWe+CQ8=;
 b=qB30lK2LUoYekJmRkPbCOhg8r2HhXnFO6Sg849XwW1s7uioHR369tL8W8ttCllbKWh6a
 H7wGinzypac47mY5X2AczR9NLvnzXxujj8A4f52HDhTzvAJgCFjX+oXTGdAMYAwNnVjz
 s8E1o1+jiFEk7rS2HrbgK+38yCybpFXv5Qg= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9e9ywqam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 16:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGIH4ZsFA1nLRlIKXxouRk0EpsP7bZz3+vETKHznphGANAE+MOGotHDYNunNPomtPo1kpZa9F7JNCu7xSQEjm1ld25NkIshKMv8mi7u3WJax3tgVNRr1HR/URegA8JCHZP8A44jJ3hjiygHlM2vFWqvCq5mZt80OtoYZBZ3iDmwYjLWKr7IsongPwkDuOA/qpcEc3DisWD04at5EK+o+I+Ejh/sgbA5TXGBuY7n/SscNMAUhT1Ilkx36ySvuwrs5oEX+crD8RPec7N3Z5ylbafAolGuh0MUJh3mX5/gcXZ5yyIrNhv4w9SkhrlO/GpHfjX21gwM1tmEzWvmpZgtcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kvZSyRnZASP5AsCXpATf8M5CEdO4JTWKh80HWe+CQ8=;
 b=Mjjso3qFoDmkt3EVKAECfW/6DJ/575nnivh8oLsQOIRjBQtNIhfTzJNPyXyVCqCAtbt0Wq/fLlJ2GfKIXD4+hkO8vW6VOHjZt+Dj7J7UCxnZKQTX7a0tyIylzCE/Oos5sQsvK4b+DuL6pGOOM3LJnfXNHOsdPEvnEuK8QH9/HX2olMASQE1vIXVutwoP/pOybMG1Hdwn+52UFppc9d6VWhfXYTlXE2QqYOkpvwGJobPiWFmZRa3agvI2VyrIe+631/drfhBeQNwN2izn6j19n9gXjik4PPxqE0s8+EjHVHVd3fU0umgOme/ooat70/VrOo9lquzoDPi2ms9X7ar1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1446.namprd15.prod.outlook.com (2603:10b6:903:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 23:54:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 23:54:31 +0000
Message-ID: <463f8b46-dd40-a91a-b7fe-36846d4c6a34@fb.com>
Date:   Tue, 30 Aug 2022 16:54:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v8 1/5] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220829192317.486946-1-kuifeng@fb.com>
 <20220829192317.486946-2-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220829192317.486946-2-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b461b226-fe8a-41ce-17b7-08da8ae2fb96
X-MS-TrafficTypeDiagnostic: CY4PR15MB1446:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaLPzFt3L/A7w3FN+b/YJWtrDYsw4NyFsF7oGFio/n6Hx13WcgARG3SoY8/OMET6BOScLV4xoGRuU+m47gapbeVaPddh40ElG16bh9t546LfYQQcvzcVxT1+7jk5SVgYotP69wN8U0BcAW5GtZGWIQuwYSbML/q9jbcDbjMA/dKNmtOzW+LvHpHlPbV0ghsVxxx9/1wCWu96N6QHzow7mqFAe0dQz/aP7sqycHRypH8+sQS88ryMsiVfNY4b4xN7ta8lOFTBUl/7WWHiTULKKPaVyq5cVyP+b7obKEAdRIMiZUZUpJYfrEkb2MMO4gu7AiP+rlNQMdZUrz6xan5nQsTiTReKm43Exb6IGjf+Cw0Wc7A+MUUuyEokVNJdqgMRkKxg7MQ1UcGU0Z82HSyMTMYnX3ju8tQ4d6hygl7BbATIKt73Fqa0Zp19xW28asaUN8WxoXT9ZUOZtZvF0qSJfhYYEgO90b4Z0niqBZdekKc+fRGFI3+rvgaN09flKgwqx0sQL/dqkM/XU+Ntjl/H21/jU1tPOsTY4ko2h2pan0VuhpqLkQCffFpxfdyICaBQiCc6C1LB3rC+myjnJZQuI4VRo1hQ3RHiYvaczPL0oIIKamVFgUWRUiwXrBlK4QyX1GX1gixXMlVrBPgiFunESufRkpQXMVxkfqrkkdFdw3xoLmt41mvm+16TArtdLFJCDWc0/lqqfMYVCU2/kRco+fFxoET5ktIgkLvKpTwGMGEql5aI7xQ4HoEi1ZULstSevYXhuR9Gf8ZApHLJK1Sc3PLKG0XSCE0FA2aS5J7CQSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(38100700002)(2906002)(6506007)(53546011)(2616005)(83380400001)(6512007)(86362001)(66946007)(6636002)(31696002)(6486002)(316002)(66476007)(66556008)(8676002)(186003)(5660300002)(478600001)(31686004)(41300700001)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0dvY3Z3cUprcU1ZMEgxdW1aY21UeUFlOVpjcE1rZXRoa2Q3L1VyT0JBZVRr?=
 =?utf-8?B?TlVVMXpTOXZrUko0V3BHMERIOFZXY2V6QUlZdzlObE1MS2ZyR2NKN3VMKzhP?=
 =?utf-8?B?aE5QM1RiaHBhZUpRQjFMcnNMVlRJOThGc3RPcDdNeDh2TjljWWVRYm9lZFNI?=
 =?utf-8?B?aG1Hcm1zY2IyaG5GWnpoRnl5Q1dXREF2R2xiTmIxV1Bsam5oeXQ5OTRFRGF5?=
 =?utf-8?B?eW1peHVpMW5UVE9qaEQxMThSZDBWUEtmWDZ3R01qbjFCY1g4UFdERjhhMnYy?=
 =?utf-8?B?TXhmOXVVbG9weXJTZjNXTDNjZXNVQXBiVHZta2RIVmt5dXVTeE1rVUFzVFdl?=
 =?utf-8?B?RzROUmZTSDlqT2R5emYvVzBsZ1JBUXVUdEZkTk9BdVkyTmpJU21wd295bXBB?=
 =?utf-8?B?NzBqUEgxZ1dFL3ZrT2lUMExwSVFNa3V1SlRTWW1ZMkNPU0NISUVGSVQ5Mjdx?=
 =?utf-8?B?ZkpCa0h3dnlwZWZzVFdLOEZjaVdiYkNMZjg2K1Q1d0hsalJKc21vVXBsR2Fy?=
 =?utf-8?B?ZWRXdGZaVi93UldycFpMSEdXcjB1R2w1Q3l4M2VjclNZWEVOSUpkbzZQZWVU?=
 =?utf-8?B?ZVdydExUQm14SEk3K3FHYWZGTHNiVXE0S1J1RVYrNXVYRDJFQkZVMmpqS1lY?=
 =?utf-8?B?QnFqRGFXTXN1clREN2pjYnMyMUNWcnFvZEI0ZDVQakJSeElRTTV2d0xWZWdx?=
 =?utf-8?B?eVpFRVlXaGdNaTlKSSsrdkE4aWVxZmU5Ry96N2FvNVN3Rnh1K2ZmR1pYSzls?=
 =?utf-8?B?QnU4ald4SVo1SWdNV3RGNXVUdEk1cXQ2S1hFc1ZVZzgySkZoa1ZMMWg1S284?=
 =?utf-8?B?bzM2blBndW44bVBOU3RtVUNCczRUdjlmY3ZKU3o1aC90UUZya3VZMHBza1p5?=
 =?utf-8?B?S3RLQTJYT0dUUTloRjlMNHFuTTVMMldUd1pybmhwRmtYM3Y3Y1lFbzY3enVL?=
 =?utf-8?B?cTMyYVBRVHpXc0pnSTJ0cHdhMG1kVTRGckpWTGZhUE90cnk4NFpEaDl2S0xG?=
 =?utf-8?B?cGorZVhKM29JYk5NOFBrU2YzK1E5U0JTa2daN1hKWG1PUWFTM3BvSTdsOFNi?=
 =?utf-8?B?Nmw2UDlmeHVONWJhaFFPdVlmRTRaQy9nMWMvUGZUSElVQmE1Nk1sb21oT2Fx?=
 =?utf-8?B?RlMrWUlvVGljZjVyaVgweHZueWM5dXNuVFJwVXA0KzRyNFRVMmFEK0hvNXlk?=
 =?utf-8?B?b1gxYVBNZFFndFZnRGdwRE0wckV4UzBLWU5TQTFHOXNCZXFYSmlET01ISk5s?=
 =?utf-8?B?cFh5SUpTOWVYTnBmUmJWS2dHQXlzTDljR2MzeVlYUEZJcE1hTmRkT3p0bEVX?=
 =?utf-8?B?ZW4wWUlDWndkd0dSRi9zV01QQkVSK0pDL0h1MlF3ZjdzTnZqcDlMbzh1MG1x?=
 =?utf-8?B?cWRZWDcvamZWcmUwQ3RJYmZWWDgwM094SnAvWk55SVUwQ1JrTVdoVHFLTkt6?=
 =?utf-8?B?cncvY1RINERoV1RwZVd6MXRQaDFNcFdML2RuOUMvaEh2aENSTE1NaEJQNkhR?=
 =?utf-8?B?RTVYaTUreU1CTE85NGdwSG1MdUVaWVBCd2pMbmFSRmkwVUpMTWtoVGU4S0VY?=
 =?utf-8?B?TjJoNXc4N1g2eTExUEF4M0VYejRTMW1VUzFWQXFtcWlvVFgxMmpFN04wY1Yw?=
 =?utf-8?B?R1FSS3RuNi9kdk13cWlRYTRJVUpzY0tNUUpqeW5WZUhON0cySmFTVm4zOW43?=
 =?utf-8?B?djlGV3o0UUJlKzUvS2tmOW1JdGtmRERhYU4wM3ViWHFYODdFYWFCdmdyZWhZ?=
 =?utf-8?B?Wis3VGRiYjlnOWVpbUc4TnZraFJBNnhwSTRqdDRJdk1XUDNONTRuaWR2Z1lT?=
 =?utf-8?B?Ukw1eTBXWnJnSTNaMlQ0UDA3SEhtNUZNRldwcWF3TmJoLzYvN0lSdXc2N0x1?=
 =?utf-8?B?dlRLZFMvNHBrbVRXdmM2cEpldGpKc2tuSTh3Zy9pRUVnbHBRWHgvV0pmMmRq?=
 =?utf-8?B?cEN4dks3OHJmZTI5TjJ2ZzdWQnhBdklpbjhkVFIyK21udVphZkRjK21TR1k5?=
 =?utf-8?B?cDhDampLb2FWNHlVYW9hYzVOUGU0K1o2WSs4Nlg2aW10TDllU2xBM0N6cUFS?=
 =?utf-8?B?ai8zbE5zK21aeXQ0QzhacHU3ZWgxWjNxZ2ROVHVYdW1oeUdKVkJSVW8yODNE?=
 =?utf-8?B?Y2ZqWHd0YS91YlFQc3pDTTN5aVF5VGJ6d2haY1FIQmFXeFlGS2l1eElDTXNX?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b461b226-fe8a-41ce-17b7-08da8ae2fb96
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 23:54:31.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTjYK5s54OFsnustf61nlXc608ZzTL3ShX2wV4y1WyMk4iNFg/kpieiF6q3K5Zjl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1446
X-Proofpoint-ORIG-GUID: RlQMATHkKYWWB_I-ERMciJXHqVMck7s1
X-Proofpoint-GUID: RlQMATHkKYWWB_I-ERMciJXHqVMck7s1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
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



On 8/29/22 12:23 PM, Kui-Feng Lee wrote:
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
>   kernel/bpf/task_iter.c         | 184 +++++++++++++++++++++++++++++----
>   tools/include/uapi/linux/bpf.h |   6 ++
>   4 files changed, 199 insertions(+), 22 deletions(-)
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
> index 8c921799def4..0bc7277d1ee1 100644
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
> @@ -22,18 +25,107 @@ struct bpf_iter_seq_task_info {
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

Add a comment in the above to say that this is for the *very first* 
visit of tasks in the process.

> +		pid = find_pid_ns(common->pid, common->ns);
> +		if (pid)
> +			task = get_pid_task(pid, PIDTYPE_TGID);

'task' is not initialized, so it is possible task could hold a
garbase value here if !pid, right?

Also if indeed task is NULL, here, should we return NULL here
first?

> +
> +		*tid = common->pid;
> +		common->pid_visiting = common->pid;
> +
> +		return task;
> +	}
> +
> +	/* The callers increase *tid by 1 once they want next task.
> +	 * However, next_thread() doesn't return tasks in incremental
> +	 * order of pids. We can not find next task by just finding a
> +	 * task whose pid is greater or equal to *tid.  pid_visiting
> +	 * remembers the pid value of the task returned last time. By
> +	 * comparing pid_visiting and *tid, we known if the caller
> +	 * wants the next task.
> +	 */
> +	if (*tid == common->pid_visiting) {
> +		pid = find_pid_ns(common->pid_visiting, common->ns);
> +		task = get_pid_task(pid, PIDTYPE_PID);
> +
> +		return task;
> +	}

Do not understand the above code. Why we need it? Looks like
the code below trying to get the *next_task* and will return NULL
if wrap around happens(the tid again equals tgid), right?

> +
> +retry:
> +	pid = find_pid_ns(common->pid_visiting, common->ns);
> +	if (!pid)
> +		return NULL;
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task)
> +		return NULL;
> +
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

We could do quite some redundant works here if the following
condition is true. Basically, we get next_task and get a tid
and release it, but in the next iteration, from tid, we try to get
the task again.

> +
> +	if (skip_if_dup_files && task->files == task->group_leader->files)
> +		goto retry;
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
> @@ -56,7 +148,7 @@ static void *task_seq_start(struct seq_file *seq, loff_t *pos)
>   	struct bpf_iter_seq_task_info *info = seq->private;
>   	struct task_struct *task;
>   
> -	task = task_seq_get_next(info->common.ns, &info->tid, false);
> +	task = task_seq_get_next(&info->common, &info->tid, false);
>   	if (!task)
>   		return NULL;
>   
> @@ -73,7 +165,7 @@ static void *task_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>   	++*pos;
>   	++info->tid;
>   	put_task_struct((struct task_struct *)v);
> -	task = task_seq_get_next(info->common.ns, &info->tid, false);
> +	task = task_seq_get_next(&info->common, &info->tid, false);
>   	if (!task)
>   		return NULL;
>   
> @@ -117,6 +209,45 @@ static void task_seq_stop(struct seq_file *seq, void *v)
>   		put_task_struct((struct task_struct *)v);
>   }
>   
[...]
