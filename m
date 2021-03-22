Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A95344EB0
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 19:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhCVSkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 14:40:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230443AbhCVSkE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Mar 2021 14:40:04 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MIMwI2005351;
        Mon, 22 Mar 2021 11:39:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ZWGuNoJ7hyk2pCZ1mI4BBSj06YtOHzgjzjQp5dDdAyQ=;
 b=TWIlJqJ4azuTJ5gyzQdC0HBjulvjE3VO0QxZD5yvPCV7Lx0ML1lHdgtYr5+ksOIiujLr
 mrKh7J3BssYzL+w1X9wPwJhLVrXFkbaxebgDnybtRQW11lTlUzgT+LMJj+jdIUUKghyX
 +v9z/VPXOCcXQuiOL8PEPeASEcp09yotrXg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37e0rhf0qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Mar 2021 11:39:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 11:39:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSnizz4r26snlP5tKAQmnYL1nDVQaenlyr+rhHooBYyG6Q2iAv3wMSeYQ7gtRgn8lqrcc/P6nCm9HDeinOIsjMQu9y5M2gAWto0xDOuqfNb0xulrJbzawR9vWaHMyY2fWws85aqrsBEZGtscFwwLjvudQ39pSlbWGYtNL8L6ykRDDOa2qefCsn0boCUv8RUYbAK53onhEKvGbWQ0fjr3AdvYxQ333fcw7G8DSMJx2KRsluH21eQDiddRaNZtflXsVHKV/sw3nxH8wt+bUp0uuIjllnHA4AAnnTleTIWfpnPRol9SysuUkwE+DX2cQoefrki426vckFGWxRPG+pUZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWGuNoJ7hyk2pCZ1mI4BBSj06YtOHzgjzjQp5dDdAyQ=;
 b=mv0Pdbmc7vQjYRIYhWTmnnm+C7roqVZQcZ9NuOt0ALRVidufXpx3M9ocEBTtXcmeb3XTlyLl3a9OhjMB1O+ZNNMeoihCExWt65UzqOwNs65XRCQx3+Dx2gzjpdQl5SQ/4f3ulHWLjh9ywP5foVE7L+dRjrNx4bD9A9h9YrTu+9hGRYxUm8AyCue8zk1lBS/rSeMdjXNeznlOtjSEuzz+HZa2yKO7YmK1fKnyUz9Wg9J4qwRFHR+9c3QUE4UOcohPzSo+p1G938NIBwMZb2jRQhoH0Zl9ZMpRwG/fFRkgWQA/OGa4e9ZHcO9aYIjnTPPi21eqo5pbeI9C1eL6HDdRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4632.namprd15.prod.outlook.com (2603:10b6:a03:37d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 18:39:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 18:39:42 +0000
Date:   Mon, 22 Mar 2021 11:39:38 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next v3] bpf: fix NULL pointer dereference in
 bpf_get_local_storage() helper
Message-ID: <YFjkarhTFseEDn9L@carbon.dhcp.thefacebook.com>
References: <20210320170201.698472-1-yhs@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210320170201.698472-1-yhs@fb.com>
X-Originating-IP: [2620:10d:c090:400::5:cef2]
X-ClientProxiedBy: MW4PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:303:8e::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:cef2) by MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 18:39:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 471003bc-4eb0-4b74-f276-08d8ed61db59
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4632:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4632BF8F3AC61AEE81229D4FBE659@SJ0PR15MB4632.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFvG/056974f5isUGbcf14QtKhFMQgZKi42ULolNiaJyNFWOfgcCr1yJwAcr/44AWPX+oC7F88PjQMwly6m7M2I2PkcdzjGCAxZ2GedME3Nxl+2pkbZYS0UApfmc58VFimAFR+eRSYUHGMDbBB84klpE6jjj689ebeUoOukM5oiowRpPLy1p+v9ngm+iwcRweNQ6TOUItqEphKHTBgVOiGK9Wd87S5iY+9hUp8GGQ2iKgfdBbu1Xjz/kA6kG9Yds+tmCMpADnFv8B4Sw33DmNSvw/l1jeVm2tFZckB32Q4BCGDYsN+J2m/APsftJk+BuPndF7m+DHWYpqrwSkMEmEcHZev/aKVTwQVAT+fhYvKXwCOxcoWcLMFRXm9po659gFT9KdypOE8Yje2v8D+BY5esG1Z7b6OPrVR5u6eLb969dZDCPw4Td8zAm152VVZGMrE42R8Opifv0+1y9Ey07PiF9qDPu/M4/jE6pNEiThrU2q/mNddi/ZJR2kh6/1p/d9KpM6qvI8vjYL+9I4R/gSEb3d41eKAQzReasVCsztTd1a8+GIEtgNPdjftQvwI+TLMbxBg15RA/mP807vwdTZdoYFG19/83O/eJW9YNevTkgXPFGDvfmwE5DoXHQOMoslpa14qLvZ/dkRrMowSycnhotvict/fQ5bIGs3IFWuRoEuDWlrHqQEJndEl5a/nxZ+BySXAX7y7UQ0yh/bhlzM69ShLctQIHovzVVyK0TKHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(54906003)(30864003)(6862004)(4326008)(9686003)(2906002)(83380400001)(316002)(8676002)(6506007)(8936002)(66476007)(38100700001)(55016002)(966005)(6666004)(478600001)(86362001)(16526019)(186003)(66946007)(7696005)(66556008)(52116002)(5660300002)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0XGB3sGoP9/xu/EyJS9J8M1ObkuW3C+hwZ5iKK0ja4tDYwn2MUtEnSvX3906?=
 =?us-ascii?Q?NphCUG0o96TI92yB+WQeKAeseZ+TdvA+B1vDxUBTjtR+90/wl3AcU3ChM4+B?=
 =?us-ascii?Q?VJmRnhgIvlJcP+pKycy26IU8ifr6SUIFm+5+7DFb1MhF+ndotE4YcAc9HasF?=
 =?us-ascii?Q?7F5zeClZt0jOGAkXpDiy1l2OTVb4GPXnhJSeO8GOtCgNjD77POVxCxcBNtjx?=
 =?us-ascii?Q?Z8dHb00eFxo/+lc+N47H1wO1CezQ/hvKf6+dmsnWmr9BIxIrviAdV0YDFLIZ?=
 =?us-ascii?Q?XLHFpt9MjnG+DvR4hwbNBSZIWVBuQCckTF+px09dXqnwwBkbB+CtZ4zLFcnt?=
 =?us-ascii?Q?9LShBb1/GGzN3dywkYJLtdhAt0xhto8y6ZqACbmnUe+kkVAItxzjbzyb9Vud?=
 =?us-ascii?Q?bNQzyauY0k5LciYkw+iEP3PEKKb6D1Kj2LLtfwIKfqwnBwYweVxRcIdVkcmN?=
 =?us-ascii?Q?rWAEypKjyyW7mfX8QioXbU93SGZGDxNqfI3VRWt8gG338HIFT9epzaINTLcf?=
 =?us-ascii?Q?jpjKr36Ef5+NuoK9FiguBr7LkehZwyzYsbejxgKVjZmRWyV0/2kxy4klTaJR?=
 =?us-ascii?Q?wtkJk10JRxsDwzvkf9ZNsDHY8WCcedMXhdt2vysKt7Hlwkj0UYXm4QT1Xh/W?=
 =?us-ascii?Q?bRfXO4d0J9CdFpoZ5XNSkIz7d3zcS4Q7WnBYzz5pmZqdQ+5qUscgqHVHrh8g?=
 =?us-ascii?Q?Zb1gq24wS2YzRoTOVqSK9l4s8ch+SXAz7c+pHQYsh30TgQQf4sbA0vwCp7Tz?=
 =?us-ascii?Q?KRKONlKNVkJWGvpYM5HpLFr0Jkiqc4F/G0sbBz6YCQ71+7W5cgbQ/6MpY7nv?=
 =?us-ascii?Q?ifR6T7PaK2wn50hVUKvtiPk4xyyC3m+YAFMSYA+uhEAbACa6f1tLKOdu413o?=
 =?us-ascii?Q?XyT89DTR/MPj6L+WFJGO4tDtdi/XkJQCWWGYBISsqOpdcoQcr5szh585fPT0?=
 =?us-ascii?Q?2FkhMU6gd6PsbAXEXkoGkbVr/44UICOIMt7tTRg1eShzx82PyenVJObafKN5?=
 =?us-ascii?Q?/tOiUIVHL+ftFd/iPD64+AJIZvOekeAuoyRbtZO9HkwNrsIJjfB0PQkwtjAr?=
 =?us-ascii?Q?UJXX6rQyYHB4JIkeSvPFWuERqFwO+71hVqfJpS2ml4UGGOFsRe/poSYs4O4O?=
 =?us-ascii?Q?QcGf2uGekzij47yzBcgM1HLjAXm/h67IqP5y+6k5PZE9PCeFLPTszgO2BQWJ?=
 =?us-ascii?Q?adX3Z3W//LpNlkPhc836gPfKbdzPPng8VBnHoZ7Oz1CPbttLwUcq+LXkkFbX?=
 =?us-ascii?Q?u7z6Ka7Ewtm3eXTzczB59nZx96G0bCSX9lLswdxK9sDkP9gQJ2a/zqNEHF25?=
 =?us-ascii?Q?Rg6Bc/XIvYlO21wrgMZs3iteR425SqqJn7zP/dnNfykCYg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 471003bc-4eb0-4b74-f276-08d8ed61db59
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 18:39:42.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGzgoyqKUvQnnJh9oSwlZeHwsEq7aLLDv/wjUKmyaJv4sqqfAytSormixHI8hzK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4632
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_10:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 20, 2021 at 10:02:01AM -0700, Yonghong Song wrote:
> Jiri Olsa reported a bug ([1]) in kernel where cgroup local
> storage pointer may be NULL in bpf_get_local_storage() helper.
> There are two issues uncovered by this bug:
>   (1). kprobe or tracepoint prog incorrectly sets cgroup local storage
>        before prog run,
>   (2). due to change from preempt_disable to migrate_disable,
>        preemption is possible and percpu storage might be overwritten
>        by other tasks.
> 
> This issue (1) is fixed in [2]. This patch tried to address issue (2).
> The following shows how things can go wrong:
>   task 1:   bpf_cgroup_storage_set() for percpu local storage
>          preemption happens
>   task 2:   bpf_cgroup_storage_set() for percpu local storage
>          preemption happens
>   task 1:   run bpf program
> 
> task 1 will effectively use the percpu local storage setting by task 2
> which will be either NULL or incorrect ones.
> 
> Instead of just one common local storage per cpu, this patch fixed
> the issue by permitting 8 local storages per cpu and each local
> storage is identified by a task_struct pointer. This way, we
> allow at most 8 nested preemption between bpf_cgroup_storage_set()
> and bpf_cgroup_storage_unset(). The percpu local storage slot
> is released (calling bpf_cgroup_storage_unset()) by the same task
> after bpf program finished running.
> bpf_test_run() is also fixed to use the new bpf_cgroup_storage_set()
> interface.
> 
> The patch is tested on top of [2] with reproducer in [1].
> Without this patch, kernel will emit error in 2-3 minutes.
> With this patch, after one hour, still no error.
> 
>  [1] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
>  [2] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=w8L+Fj74OaUpbosO29niYwTki7e3Ag044_aww@mail.gmail.com/T
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>

It looks a bit artificial (8 storages to handle the nesting), but most likely
it will work in the real life and the code looks correct to me.
Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com>
and thank you for fixing it!

Btw, is it intended for a stable backport?

Thanks!

> ---
>  include/linux/bpf-cgroup.h | 57 ++++++++++++++++++++++++++++++++------
>  include/linux/bpf.h        | 22 ++++++++++++---
>  kernel/bpf/helpers.c       | 15 +++++++---
>  kernel/bpf/local_storage.c |  5 ++--
>  net/bpf/test_run.c         |  6 +++-
>  5 files changed, 86 insertions(+), 19 deletions(-)
> 
> Changelogs:
>   v2 -> v3:
>     . merge two patches as bpf_test_run() will have compilation error
>       and may fail with other changes.
>     . rewrite bpf_cgroup_storage_set() to be more inline with kernel
>       coding style.
>   v1 -> v2:
>     . fix compilation issues when CONFIG_CGROUPS is off or
>       CONFIG_CGROUP_BPF is off.
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index c42e02b4d84b..6a29fe11485d 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -20,14 +20,25 @@ struct bpf_sock_ops_kern;
>  struct bpf_cgroup_storage;
>  struct ctl_table;
>  struct ctl_table_header;
> +struct task_struct;
>  
>  #ifdef CONFIG_CGROUP_BPF
>  
>  extern struct static_key_false cgroup_bpf_enabled_key[MAX_BPF_ATTACH_TYPE];
>  #define cgroup_bpf_enabled(type) static_branch_unlikely(&cgroup_bpf_enabled_key[type])
>  
> -DECLARE_PER_CPU(struct bpf_cgroup_storage*,
> -		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> +#define BPF_CGROUP_STORAGE_NEST_MAX	8
> +
> +struct bpf_cgroup_storage_info {
> +	struct task_struct *task;
> +	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
> +};
> +
> +/* For each cpu, permit maximum BPF_CGROUP_STORAGE_NEST_MAX number of tasks
> + * to use bpf cgroup storage simultaneously.
> + */
> +DECLARE_PER_CPU(struct bpf_cgroup_storage_info,
> +		bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
>  
>  #define for_each_cgroup_storage_type(stype) \
>  	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
> @@ -161,13 +172,42 @@ static inline enum bpf_cgroup_storage_type cgroup_storage_type(
>  	return BPF_CGROUP_STORAGE_SHARED;
>  }
>  
> -static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
> -					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
> +static inline int bpf_cgroup_storage_set(struct bpf_cgroup_storage
> +					 *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
>  {
>  	enum bpf_cgroup_storage_type stype;
> +	int i, err = 0;
> +
> +	preempt_disable();
> +	for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
> +		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != NULL))
> +			continue;
> +
> +		this_cpu_write(bpf_cgroup_storage_info[i].task, current);
> +		for_each_cgroup_storage_type(stype)
> +			this_cpu_write(bpf_cgroup_storage_info[i].storage[stype],
> +				       storage[stype]);
> +		goto out;
> +	}
> +	err = -EBUSY;
> +	WARN_ON_ONCE(1);
> +
> +out:
> +	preempt_enable();
> +	return err;
> +}
> +
> +static inline void bpf_cgroup_storage_unset(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
> +		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != current))
> +			continue;
>  
> -	for_each_cgroup_storage_type(stype)
> -		this_cpu_write(bpf_cgroup_storage[stype], storage[stype]);
> +		this_cpu_write(bpf_cgroup_storage_info[i].task, NULL);
> +		return;
> +	}
>  }
>  
>  struct bpf_cgroup_storage *
> @@ -448,8 +488,9 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
>  	return -EINVAL;
>  }
>  
> -static inline void bpf_cgroup_storage_set(
> -	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
> +static inline int bpf_cgroup_storage_set(
> +	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) { return 0; }
> +static inline void bpf_cgroup_storage_unset(void) {}
>  static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
>  					    struct bpf_map *map) { return 0; }
>  static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a47285cd39c2..3a6ae69743ff 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1090,6 +1090,13 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
>  /* BPF program asks to set CN on the packet. */
>  #define BPF_RET_SET_CN						(1 << 0)
>  
> +/* For BPF_PROG_RUN_ARRAY_FLAGS and __BPF_PROG_RUN_ARRAY,
> + * if bpf_cgroup_storage_set() failed, the rest of programs
> + * will not execute. This should be a really rare scenario
> + * as it requires BPF_CGROUP_STORAGE_NEST_MAX number of
> + * preemptions all between bpf_cgroup_storage_set() and
> + * bpf_cgroup_storage_unset() on the same cpu.
> + */
>  #define BPF_PROG_RUN_ARRAY_FLAGS(array, ctx, func, ret_flags)		\
>  	({								\
>  		struct bpf_prog_array_item *_item;			\
> @@ -1102,10 +1109,12 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
>  		_array = rcu_dereference(array);			\
>  		_item = &_array->items[0];				\
>  		while ((_prog = READ_ONCE(_item->prog))) {		\
> -			bpf_cgroup_storage_set(_item->cgroup_storage);	\
> +			if (unlikely(bpf_cgroup_storage_set(_item->cgroup_storage)))	\
> +				break;					\
>  			func_ret = func(_prog, ctx);			\
>  			_ret &= (func_ret & 1);				\
>  			*(ret_flags) |= (func_ret >> 1);			\
> +			bpf_cgroup_storage_unset();			\
>  			_item++;					\
>  		}							\
>  		rcu_read_unlock();					\
> @@ -1126,9 +1135,14 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
>  			goto _out;			\
>  		_item = &_array->items[0];		\
>  		while ((_prog = READ_ONCE(_item->prog))) {		\
> -			if (set_cg_storage)		\
> -				bpf_cgroup_storage_set(_item->cgroup_storage);	\
> -			_ret &= func(_prog, ctx);	\
> +			if (!set_cg_storage) {			\
> +				_ret &= func(_prog, ctx);	\
> +			} else {				\
> +				if (unlikely(bpf_cgroup_storage_set(_item->cgroup_storage)))	\
> +					break;			\
> +				_ret &= func(_prog, ctx);	\
> +				bpf_cgroup_storage_unset();	\
> +			}				\
>  			_item++;			\
>  		}					\
>  _out:							\
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 074800226327..f306611c4ddf 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -382,8 +382,8 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
>  };
>  
>  #ifdef CONFIG_CGROUP_BPF
> -DECLARE_PER_CPU(struct bpf_cgroup_storage*,
> -		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> +DECLARE_PER_CPU(struct bpf_cgroup_storage_info,
> +		bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
>  
>  BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>  {
> @@ -392,10 +392,17 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
>  	 * verifier checks that its value is correct.
>  	 */
>  	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
> -	struct bpf_cgroup_storage *storage;
> +	struct bpf_cgroup_storage *storage = NULL;
>  	void *ptr;
> +	int i;
>  
> -	storage = this_cpu_read(bpf_cgroup_storage[stype]);
> +	for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
> +		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != current))
> +			continue;
> +
> +		storage = this_cpu_read(bpf_cgroup_storage_info[i].storage[stype]);
> +		break;
> +	}
>  
>  	if (stype == BPF_CGROUP_STORAGE_SHARED)
>  		ptr = &READ_ONCE(storage->buf)->data[0];
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 2d4f9ac12377..bd11db9774c3 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -9,10 +9,11 @@
>  #include <linux/slab.h>
>  #include <uapi/linux/btf.h>
>  
> -DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
> -
>  #ifdef CONFIG_CGROUP_BPF
>  
> +DEFINE_PER_CPU(struct bpf_cgroup_storage_info,
> +	       bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
> +
>  #include "../cgroup/cgroup-internal.h"
>  
>  #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 0abdd67f44b1..4aabf71cd95d 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -106,12 +106,16 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
>  
>  	bpf_test_timer_enter(&t);
>  	do {
> -		bpf_cgroup_storage_set(storage);
> +		ret = bpf_cgroup_storage_set(storage);
> +		if (ret)
> +			break;
>  
>  		if (xdp)
>  			*retval = bpf_prog_run_xdp(prog, ctx);
>  		else
>  			*retval = BPF_PROG_RUN(prog, ctx);
> +
> +		bpf_cgroup_storage_unset();
>  	} while (bpf_test_timer_continue(&t, repeat, &ret, time));
>  	bpf_test_timer_leave(&t);
>  
> -- 
> 2.30.2
> 
